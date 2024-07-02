# Notes

## Abbreviations

IU: Execution Unit
HN: actually it's h0-h7 and points to entries of the ibuf. I think it's one bit per h0, h1, etc.

## IBUF

Contains instructions prefetched by the branch predictions.

## Branch history table

Questions:

* What are the branch select and branch predict tables?
* What is the BHT write buffer?

See description here: https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=645792

## Counter update policy

Only the selected PRE array is updated.
The choice predictor is also updated, except if it was wrong in the choice of the PRE array, but then the selected PRE array still made the correct prediction.

TODO: what is the update policy of the SEL array?
--> Where do I get the feedback that the prediction was correct?
L'input data est determine par `case({cur_sel_rst[1:0],cur_condbr_taken})`
--> Basically, it increases the select counter if the prediction was correct, and decreases it if it was wrong.

## Write buffers

There are 4, and they seem to be bypassable.
`create_ptr` and `retire_ptr` are one-hot pointers that manage them.

### Branch select vs branch predict

The select array chooses between the 2 predictor arrays, depending if it thinks it will be taken or not.

Content: concatenation of 8x the same `sel_array_updt_data[1:0]`.
Indexing: Some PC[9:3] without any kind of xor or concat.

--> Il semble que "branch select" soit utilise comme un 2-bit counter. Le MSB dit si la branch est taken ou pas
```
assign pre_array_data[31:0] = (bht_sel_result[1])
```

#### SEL is being read on still code
With a program made of nops, a store and an infinite loop, `sel` is sometimes activated, and sometimes th eindex is 1.
This is because of `pcgen_bht_chgflw`, because of the OR of these 2 conditions:
- `ct_ifu_pcgen.ifctrl_pcgen_reissue_pcload`, itself due to `icache_reissue`
- `ct_ifu_pcgen.ipctrl_pcgen_reissue_pcload`, itself due to `icache_refill_reissue` because of `l1_refill_pre & !l1_refill_ipctrl_busy`.


### Difference in read conditions for SEL and PRED:

assign bht_pred_array_cen_b  = !(
                                  bht_inv_on_reg || 
                                  after_inv_reg  || 
                                  (bht_wr_buf_updt_vld || 
                                   ipctrl_bht_con_br_vld && !lbuf_bht_active_state || 
                                   lbuf_bht_con_br_vld && lbuf_bht_active_state || 
                                   bju_mispred || 
                                   after_bju_mispred || 
                                   rtu_ifu_flush || 
                                   after_rtu_ifu_flush) && 
                                  cp0_ifu_bht_en

assign bht_sel_array_cen_b  = !(
                                bht_inv_on_reg || 
                                after_inv_reg  || 
                                (bht_wr_buf_updt_vld || 
                                 pcgen_bht_chgflw || 
                                 pcgen_bht_seq_read) && 
                                cp0_ifu_bht_en





## L0BTB

Bypass condition: if the value being written is directly being queried.

The L0BTB also predicts the way in the main BTB `entry_hit_way_pred`.

Difference between `ibdp_l0_btb_update_vld` and `ibdp_l0_btb_update_vld_bit`: the first is more of a sensitization signal. The second is a "valid" signal. In the end, they are conceptually ANDed together.

Update condition visible in `ct_ifu_ibdp.v`, line 2270, and happens in 3 cases:
a) RAS update
b) Branch miss (miss in L0BTB but not in main BTB)
c) Branch misprediction (but entry present in main BTB)

### L0BTB - RAS

The L0BTB predicts whether the instruction will hit the RAS.
The update of this prediction only happens if the RAS prediction was mistaken.

### L0BTB counter

It seems that `l0_btb_update_cnt_bit` says something about the confidence of the prediction.



## Main BTB

First experiment: a simple loop
```
  li t0, 10
  li t1, 0
loop:
  addi t1, t1, 1
  bne t1, t0, loop
```
This loop does not create any write to the BTB data or tag, although creates 8 BTB misses.




### When do we write to the BTB?

BTB tag is clocked when the condition is true:
```
pcgen_btb_chgflw_short || 
!pcgen_btb_stall_short || 
ibdp_btb_miss 
```

Why is `pcgen_btb_chgflw_short` so often 1? (often it has pattern 01010---01010--) What is its meaning at all?
--> It is due to `pcgen_chgflw_without_l0_btb`, itself due to `ipctrl_pcgen_reissue_pcload` and `ifctrl_pcgen_reissue_pcload` (which happens 2 cycles later) (and `ipctrl_pcgen_chgflw_pcload` during the loop).
--> Due to `icache_reissue`, itself due to `l1_refill_ifctrl_reissue`.



### More questions

What is `*_way_pred`?
