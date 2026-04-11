Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B73FF3ED6B
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 23:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DD810E262;
	Sat, 11 Apr 2026 23:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S4jcmqz1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJwt09AT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A44810E262
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:58:38 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BMMW1U3420182
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BbmBFdbUixMvWxkzC4XDqzQU
 R2bby+BxKze839a2Pfo=; b=S4jcmqz1abyFpsUcRPgnFZy55o8/Z6ncbQMTGa9X
 N41wPyiSJ770I5HB2IHnuLIo0COzSIOiXRVm6R3qmsQ27gbTWn+YGKNQ1Vg9+0ni
 lgBfuM07n4GFfBviGKLEvikasLbBhxFSGU4KxyC3UTEbIGnwSskWQXuqZrkyJSda
 SeaWiQtHno5O6l08bCfvtkuK0BerOBXem8x89atWnjtrXJ/84GF4mAcVrutjnt7t
 CS3zqmsK102e7pw8ft4RkzPoH7R2H3USxvhud32O33sughF1zRSEPtUNnUCIH2f/
 Vkd6C57rwD/+RFyCFMuNa/lnV3URy/zLafSgv757E5/G0w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jsgxm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 23:58:38 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89fd9daa423so65120946d6.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 16:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775951917; x=1776556717;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BbmBFdbUixMvWxkzC4XDqzQUR2bby+BxKze839a2Pfo=;
 b=EJwt09ATxqxtpb0/7WA7nIJBpga1jmBexdkpru4Q7eZdrBeWgSR5+fpCn4QV1o0qro
 MP9MMWZ/Qv86+EdrH5Sr6RRspDCDQ/71ARinnJjPvDYfeLtIdfpnOsDL7HaQyVZHsnKN
 u5TnZcgD7gOYtuMo+5aFm+rfMmMfUhGLpjZrWGUaxQmT/TwYWEvlbtQQwVDPxg7ZL8/8
 pw7KGt3TKFeXnXMJO4vn9d7V2XXIss/J4H+jTdK+UdE7I2nnyBg9Vj8YACgBnrHOglzJ
 dhIibMwa4iV9qywGp+zgapGjcszeifsDFAz/gIkom7+BLkGN06/CB8DkbtUOoyBBiWNi
 fMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775951917; x=1776556717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbmBFdbUixMvWxkzC4XDqzQUR2bby+BxKze839a2Pfo=;
 b=MMepHAEfYJmlHMMqTYxqvwljntxUJPLFZQS2CIb5Pi/7U6vP5LB2Zc2XA6MFNMAwpt
 b0g+V4a7wvNqM0RIcgPEmaTL+ieeG7b+/palIrpt+j6d0+wjjY/LgcyMoa/BhxevY77f
 mIe6+AhigF9lYq+/EFCUzvZZ34RUfLA1r52YfDRzD6QR1FfAnEP6XR56Jpn3Bh+Nj5Yp
 g2zUgi7g4oXuuCY5/ZiEKtExIpje0C9SEK/11X3JFz933eQ4yFeDs0oMr1UDaVuaDHkp
 1lGqFtQXhh9icCGFV5InVjuQ1bKVH6fcaAD6RsNGvJD3AU/A90aedswbuixtsc8QzPNE
 hiGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkmh35J/xHCOWs9pxXDHj6HN2MyNSS7vGBLe61WI35WVl50H8pP84+8fUmVnpxSMJEoiRdPM7YbCg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXAlCiQTUKWjTAQXG/vnWdTPBD38TRXz9Du65Gow1cnxH6gjSy
 nRgcZOjyfK2st43L2E3e2ZPoy9SYlRMr28S0HxXKbjxwdkAyn3AKu0q91awRyYAjZi8Lw9hdbuL
 cI7v4Dm/K21aj9S16+vrxrw4TglxTa227QcZZ5ZZhQzeqk9ORlPvsvYzgrQ+Kyt/Lcysfqdo=
X-Gm-Gg: AeBDievsUFOLk7MLM7tjzrQsOGwacq4TuagndHv3SL6cWlVE0dArgLGFyWXqjuntyR3
 f+YPxBkbLdTyW6Cr99kd3+y/KvPkOLW039nUIGp927MUYpwrKlZ96TcWLkgj1L16vInhy56NVvX
 1uDTBqbkDgc8UMTakbxZ7MJJGvxpv8yi5lWbQuuUIC7hPv4Ee92XGXWVs8m4vrWRiJ+vnxIVjdk
 Za8scEr90CD3wqxpATJs2mNcM4E1fx6/Zc9cXNQpvutTbpD+NkEfs0KAuoW1+8yj42tnnLkQyg7
 ngRyn9UbthyfTbvU33pmAINGwxKIgkIUxEjUmad8Jbn4Yl0la5JIABqMek4z47XtL098Yt1t0oT
 OHVHzv+9hYmlWCkACiq3sYlaoMiVuHOEMiIiVTa3Wsx5mRFucOqnFH32RqIDTH9BV8CnhAlKkdH
 4UrpNBjX8W8sGXRrzYtMlOQwAeDBzG29xmsZQ=
X-Received: by 2002:a05:622a:4009:b0:50d:ce35:6e67 with SMTP id
 d75a77b69052e-50dd5ba3bd7mr121267221cf.42.1775951917304; 
 Sat, 11 Apr 2026 16:58:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4009:b0:50d:ce35:6e67 with SMTP id
 d75a77b69052e-50dd5ba3bd7mr121267021cf.42.1775951916774; 
 Sat, 11 Apr 2026 16:58:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeefcb1asm1707059e87.69.2026.04.11.16.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 16:58:34 -0700 (PDT)
Date: Sun, 12 Apr 2026 02:58:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 21/39] drm/msm/dp: Add support for MST channel slot
 allocation
Message-ID: <o6n2h7q2q2r6yd3wpyfvd4napu3pixx6ni3o7r32yht2eyuc3a@renxw53ugvtt>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-21-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-21-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIxOSBTYWx0ZWRfXxY60HCuQ8zvE
 b4Fwtci7R1Ai3zQjCTj/MmqCAexZVu9SgYzYofEBGNx6nodktwEoma18CvihAtFfarSy2IBgEu2
 oenBGu3kX4Uwi1M0cPG1xmQRGzDh/FwhfCt+zM0slbqczK+D+qfw69nek9plOixDEBPnK4RPFdr
 qPiedKRGbLOWuXTDQfhNREzxdVVu9+4cPMArKtLBeTl/wLZMDzSR2s79zVD/O4LeHLgmaZm2ENW
 6kjQnhajAjeZYd5t4RC8xmrYtQcS5OLKbhaoGknByBHSWM7NctrMul7TB2QoTnEthW+HdYRjYxc
 ODCkJPf8CEWc7ItO6M5GIkQ3D7AXnn1TuiU+U6wuQfZoT3r+/4jz8wL+WTxpczgySVAC/CBo7Wi
 uw/ebATT+bzYlwS6baYEMqfTdh6kkIETCBkshqzdr6h1roVeHaw7K6udl9FysaxiG4RCFbGgWA5
 rdLMONHU4Fk7deoEidg==
X-Proofpoint-ORIG-GUID: Kzue6QEBMhO8gSmKXr9c2PN1t9TXkx_w
X-Proofpoint-GUID: Kzue6QEBMhO8gSmKXr9c2PN1t9TXkx_w
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69dae02e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=L8C09zN3Hve-ZzQWPfoA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110219
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Apr 10, 2026 at 05:33:56PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> DP MST streams share 64 MTP slots in a time-multiplexed manner. This patch

Documentation/process/submitting-patches.rst, "This patch".

> adds support for calculating the rate governor, slot allocation, and slot
> reservation in the DP controller.
> 
> Each MST stream can reserve its slots by calling
> dp_display_set_stream_info() from its bridge callbacks.

-ENOSUCHFUNCTION

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 207 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   7 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  28 +++--
>  drivers/gpu/drm/msm/dp/dp_display.h |   5 +-
>  drivers/gpu/drm/msm/dp/dp_panel.h   |   1 +
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  10 ++
>  6 files changed, 247 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 98316892eccd..e64f81bc8c36 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -73,6 +73,7 @@
>  #define MR_LINK_PRBS7 0x100
>  #define MR_LINK_CUSTOM80 0x200
>  #define MR_LINK_TRAINING4  0x40
> +#define DP_MAX_TIME_SLOTS 64
>  
>  enum {
>  	DP_TRAINING_NONE,
> @@ -109,6 +110,11 @@ struct msm_dp_vc_tu_mapping_table {
>  	u8 tu_size_minus1;
>  };
>  
> +struct msm_dp_mst_ch_slot_info {
> +	u32 start_slot;
> +	u32 tot_slots;
> +};
> +
>  struct msm_dp_ctrl_private {
>  	struct msm_dp_ctrl msm_dp_ctrl;
>  	struct drm_device *drm_dev;
> @@ -144,6 +150,8 @@ struct msm_dp_ctrl_private {
>  	bool link_clks_on;
>  	bool stream_clks_on[DP_STREAM_MAX];
>  	bool mst_active;
> +
> +	struct msm_dp_mst_ch_slot_info mst_ch_info[DP_STREAM_MAX];
>  };
>  
>  static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
> @@ -268,6 +276,73 @@ static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable
>  	msm_dp_write_link(ctrl, 0, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
>  }
>  
> +static void msm_dp_ctrl_mst_channel_alloc(struct msm_dp_ctrl_private *ctrl,
> +					  enum msm_dp_stream_id stream_id, u32 ch_start_slot,
> +					  u32 tot_slot_cnt)
> +{
> +	u32 i, slot;
> +	u32  slot_reg_1, slot_reg_2;

Fold these two lines.

> +	u32 reg_off = 0;
> +	int const num_slots_per_reg = 32;
> +
> +	if (ch_start_slot > DP_MAX_TIME_SLOTS ||
> +	    (ch_start_slot + tot_slot_cnt > DP_MAX_TIME_SLOTS)) {
> +		DRM_ERROR("invalid slots start %d, tot %d\n",
> +			  ch_start_slot, tot_slot_cnt);
> +		return;
> +	}
> +
> +	drm_dbg_dp(ctrl->drm_dev, "stream_id %d, start_slot %d, tot_slot %d\n",
> +		   stream_id, ch_start_slot, tot_slot_cnt);
> +
> +	if (stream_id == DP_STREAM_1)
> +		reg_off = REG_DP_DP1_TIMESLOT_1_32 - REG_DP_DP0_TIMESLOT_1_32;
> +
> +	slot_reg_1 = 0;
> +	slot_reg_2 = 0;
> +
> +	if (ch_start_slot && tot_slot_cnt) {
> +		ch_start_slot--;
> +		for (i = 0; i < tot_slot_cnt; i++) {
> +			if (ch_start_slot < num_slots_per_reg) {
> +				slot_reg_1 |= BIT(ch_start_slot);
> +			} else {
> +				slot = ch_start_slot - num_slots_per_reg;
> +				slot_reg_2 |= BIT(slot);
> +			}
> +			ch_start_slot++;

If it is a counter, it's no longer a starting slot. And I think I wrote
this before. Please replace the loop with the math.

> +		}
> +	}
> +
> +	drm_dbg_dp(ctrl->drm_dev, "stream_id:%d slot_reg_1:%d, slot_reg_2:%d\n", stream_id,
> +		   slot_reg_1, slot_reg_2);
> +
> +	msm_dp_write_link(ctrl, stream_id, stream_id > DP_STREAM_1 ?
> +			  REG_DP_MSTLINK_TIMESLOT_1_32 : REG_DP_DP0_TIMESLOT_1_32 + reg_off,
> +			  slot_reg_1);
> +	msm_dp_write_link(ctrl, stream_id, stream_id > DP_STREAM_1 ?
> +			  REG_DP_MSTLINK_TIMESLOT_33_63 : REG_DP_DP0_TIMESLOT_33_63 + reg_off,
> +			  slot_reg_2);
> +}
> +
> +static void msm_dp_ctrl_update_rg(struct msm_dp_ctrl_private *ctrl,
> +				  enum msm_dp_stream_id stream_id, u32 x_int, u32 y_frac_enum)
> +{
> +	u32 rg, reg_off = 0;
> +
> +	rg = y_frac_enum;
> +	rg |= (x_int << 16);
> +
> +	drm_dbg_dp(ctrl->drm_dev, "stream_id: %d x_int:%d y_frac_enum:%d rg:%d\n",
> +		   stream_id, x_int, y_frac_enum, rg);
> +
> +	if (stream_id == DP_STREAM_1)
> +		reg_off = REG_DP_DP1_RG - REG_DP_DP0_RG;
> +
> +	msm_dp_write_link(ctrl, stream_id, stream_id > 1 ?
> +			     REG_DP_MSTLINK_DP_RG : REG_DP_DP0_RG + reg_off, rg);
> +}
> +
>  /*
>   * NOTE: resetting DP controller will also clear any pending HPD related interrupts
>   */
> @@ -2615,6 +2690,103 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
>  			  nvid);
>  }
>  
> +/* TODO: comments here. */

Well, TODO, please.

> +static void msm_dp_ctrl_mst_calculate_rg(struct msm_dp_ctrl_private *ctrl,
> +					 struct msm_dp_panel *panel,
> +					 u32 *p_x_int, u32 *p_y_frac_enum)
> +{
> +	u64 min_slot_cnt, max_slot_cnt;
> +	u64 raw_target_sc, target_sc_fixp;
> +	u64 ts_denom, ts_enum, ts_int;
> +	u64 pclk = panel->msm_dp_mode.drm_mode.clock;
> +	u64 lclk = 0;
> +	u64 lanes = ctrl->link->link_params.num_lanes;
> +	u64 bpp = panel->msm_dp_mode.bpp;
> +	u64 pbn = panel->pbn;
> +	u64 numerator, denominator, temp, temp1, temp2;
> +	u32 x_int = 0, y_frac_enum = 0;
> +	u64 target_strm_sym, ts_int_fixp, ts_frac_fixp, y_frac_enum_fixp;
> +
> +	lclk = ctrl->link->link_params.rate;
> +
> +	/* min_slot_cnt */
> +	numerator = pclk * bpp * 64 * 1000;
> +	denominator = lclk * lanes * 8 * 1000;
> +	min_slot_cnt = drm_fixp_from_fraction(numerator, denominator);
> +
> +	/* max_slot_cnt */
> +	numerator = pbn * 54 * 1000;
> +	denominator = lclk * lanes;
> +	max_slot_cnt = drm_fixp_from_fraction(numerator, denominator);
> +
> +	/* raw_target_sc */
> +	numerator = max_slot_cnt + min_slot_cnt;
> +	denominator = drm_fixp_from_fraction(2, 1);
> +	raw_target_sc = drm_fixp_div(numerator, denominator);
> +
> +	/* target_sc */
> +	temp = drm_fixp_from_fraction(256 * lanes, 1);
> +	numerator = drm_fixp_mul(raw_target_sc, temp);
> +	denominator = drm_fixp_from_fraction(256 * lanes, 1);
> +	target_sc_fixp = drm_fixp_div(numerator, denominator);
> +
> +	ts_enum = 256 * lanes;
> +	ts_denom = drm_fixp_from_fraction(256 * lanes, 1);
> +	ts_int = drm_fixp2int(target_sc_fixp);
> +
> +	temp = drm_fixp2int_ceil(raw_target_sc);
> +	if (temp != ts_int) {
> +		temp = drm_fixp_from_fraction(ts_int, 1);
> +		temp1 = raw_target_sc - temp;
> +		temp2 = drm_fixp_mul(temp1, ts_denom);
> +		ts_enum = drm_fixp2int(temp2);
> +	}
> +
> +	/* target_strm_sym */
> +	ts_int_fixp = drm_fixp_from_fraction(ts_int, 1);
> +	ts_frac_fixp = drm_fixp_from_fraction(ts_enum, drm_fixp2int(ts_denom));
> +	temp = ts_int_fixp + ts_frac_fixp;
> +	temp1 = drm_fixp_from_fraction(lanes, 1);
> +	target_strm_sym = drm_fixp_mul(temp, temp1);
> +
> +	/* x_int */
> +	x_int = drm_fixp2int(target_strm_sym);
> +
> +	/* y_enum_frac */
> +	temp = drm_fixp_from_fraction(x_int, 1);
> +	temp1 = target_strm_sym - temp;
> +	temp2 = drm_fixp_from_fraction(256, 1);
> +	y_frac_enum_fixp = drm_fixp_mul(temp1, temp2);
> +
> +	temp1 = drm_fixp2int(y_frac_enum_fixp);
> +	temp2 = drm_fixp2int_ceil(y_frac_enum_fixp);
> +
> +	y_frac_enum = (u32)((temp1 == temp2) ? temp1 : temp1 + 1);
> +
> +	*p_x_int = x_int;
> +	*p_y_frac_enum = y_frac_enum;
> +
> +	drm_dbg_dp(ctrl->drm_dev, "MST lane_cnt:%llu, rate:%llu x_int:%d, y_frac:%d\n",
> +		   lanes, lclk, x_int, y_frac_enum);
> +}
> +
> +static void msm_dp_ctrl_mst_stream_setup(struct msm_dp_ctrl_private *ctrl,
> +					 struct msm_dp_panel *panel)
> +{
> +	u32 x_int, y_frac_enum;
> +
> +	if (!ctrl->mst_active)
> +		return;
> +
> +	drm_dbg_dp(ctrl->drm_dev, "MST stream channel allocation\n");
> +
> +	msm_dp_ctrl_mst_stream_channel_slot_setup(&ctrl->msm_dp_ctrl);
> +
> +	msm_dp_ctrl_mst_calculate_rg(ctrl, panel, &x_int, &y_frac_enum);
> +
> +	msm_dp_ctrl_update_rg(ctrl, panel->stream_id, x_int, y_frac_enum);
> +}
> +
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train)
>  {
>  	int ret = 0;
> @@ -2701,6 +2873,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  	if (!ctrl->mst_active)
>  		msm_dp_ctrl_setup_tr_unit(ctrl);
>  
> +	msm_dp_ctrl_mst_stream_setup(ctrl, msm_dp_panel);
> +
>  	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>  
>  	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl);
> @@ -2757,6 +2931,39 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  			phy, phy->init_count, phy->power_count);
>  }
>  
> +void msm_dp_ctrl_set_mst_channel_info(struct msm_dp_ctrl *msm_dp_ctrl,
> +				      enum msm_dp_stream_id stream_id,
> +				      u32 start_slot, u32 tot_slots)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +
> +	if (!msm_dp_ctrl || stream_id >= DP_STREAM_MAX) {
> +		DRM_ERROR("invalid input\n");
> +		return;
> +	}
> +
> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> +
> +	ctrl->mst_ch_info[stream_id].start_slot = start_slot;
> +	ctrl->mst_ch_info[stream_id].tot_slots = tot_slots;
> +}
> +
> +void msm_dp_ctrl_mst_stream_channel_slot_setup(struct msm_dp_ctrl *msm_dp_ctrl)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +	int i;
> +
> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> +
> +	if (!ctrl->mst_active)
> +		return;
> +
> +	for (i = DP_STREAM_0; i < ctrl->num_pixel_clks; i++) {
> +		msm_dp_ctrl_mst_channel_alloc(ctrl, i, ctrl->mst_ch_info[i].start_slot,
> +					      ctrl->mst_ch_info[i].tot_slots);
> +	}
> +}
> +
>  irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index f82fd96e412a..c59338199399 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -17,7 +17,8 @@ struct msm_dp_ctrl {
>  struct phy;
>  
>  int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active);
> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl,
> +			  struct msm_dp_panel *msm_dp_panel);
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>  void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
> @@ -52,4 +53,8 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
>  int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
>  int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl);
> +void msm_dp_ctrl_mst_stream_channel_slot_setup(struct msm_dp_ctrl *msm_dp_ctrl);
> +void msm_dp_ctrl_set_mst_channel_info(struct msm_dp_ctrl *msm_dp_ctrl,
> +				      enum msm_dp_stream_id stream_id,
> +				      u32 start_slot, u32 tot_slots);
>  #endif /* _DP_CTRL_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 80bb5fc4003f..e0bf4dffa6af 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -763,11 +763,13 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
>  	return 0;
>  }
>  
> -int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
> -				   struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id)
> +int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
> +				   enum msm_dp_stream_id stream_id, u32 start_slot,
> +				   u32 num_slots, u32 pbn)
>  {
>  	int rc = 0;
>  	struct msm_dp_display_private *dp;
> +	const int max_slots = 64;
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> @@ -776,7 +778,16 @@ int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
>  		return -EINVAL;
>  	}
>  
> +	if (start_slot + num_slots > max_slots) {
> +		DRM_ERROR("invalid channel info received. start:%d, slots:%d\n",
> +			  start_slot, num_slots);
> +		return -EINVAL;
> +	}
> +
> +	msm_dp_ctrl_set_mst_channel_info(dp->ctrl, stream_id, start_slot, num_slots);
> +
>  	panel->stream_id = stream_id;
> +	panel->pbn = pbn;
>  	msm_dp_panel_set_pixel_base(panel, dp->pixel_base[stream_id]);
>  
>  	return rc;
> @@ -1525,7 +1536,7 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0);
> +	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0);

Hmm.

>  
>  	rc = msm_dp_display_enable(dp);
>  	if (rc)
> @@ -1540,14 +1551,15 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>  	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
>  }
>  
> -void msm_dp_display_atomic_disable(struct msm_dp *dp)
> +void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
>  {
> -	struct msm_dp_display_private *msm_dp_display;
> +	struct msm_dp_display_private *dp;
>  
> -	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
> -	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
> +	msm_dp_ctrl_push_idle(dp->ctrl);
> +	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
> +	msm_dp_ctrl_mst_send_act(dp->ctrl);
>  }
>  
>  static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index fdbe6e4871d9..0ccdddb223c8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -43,7 +43,8 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp_display);
>  enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>  					       const struct drm_display_info *info,
>  					       const struct drm_display_mode *mode);
> -int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
> -				   struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id);
> +int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
> +				   enum msm_dp_stream_id stream_id,
> +				   u32 start_slot, u32 num_slots, u32 pbn);
>  
>  #endif /* _DP_DISPLAY_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> index 4873c55bd693..8e7374de90eb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> @@ -50,6 +50,7 @@ struct msm_dp_panel {
>  	u32 hw_revision;
>  
>  	enum msm_dp_stream_id stream_id;
> +	u32 pbn;
>  
>  	u32 max_bw_code;
>  };
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index 87eaaefa014d..835a55446868 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -338,7 +338,13 @@
>  #define DP_TPG_VIDEO_CONFIG_RGB			(0x00000004)
>  
>  /* DP MST registers */
> +
> +#define REG_DP_MSTLINK_DP_RG			(0X0000011C)
>  #define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
> +#define REG_DP_DP0_TIMESLOT_1_32		(0x00000404)
> +#define REG_DP_DP0_TIMESLOT_33_63		(0x00000408)
> +#define REG_DP_DP1_TIMESLOT_1_32		(0x0000040C)
> +#define REG_DP_DP1_TIMESLOT_33_63		(0x00000410)
>  #define REG_DP1_SOFTWARE_MVID			(0x00000414)
>  #define REG_DP1_SOFTWARE_NVID			(0x00000418)
>  #define REG_DP1_TOTAL_HOR_VER			(0x0000041C)
> @@ -347,8 +353,12 @@
>  #define MMSS_DP1_SDP_CFG			(0x000004E0)
>  #define MMSS_DP1_SDP_CFG2			(0x000004E4)
>  #define MMSS_DP1_SDP_CFG3			(0x000004E8)
> +#define REG_DP_DP0_RG				(0x000004F8)
> +#define REG_DP_DP1_RG				(0x000004FC)
>  
>  #define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
> +#define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
> +#define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003C)
>  #define REG_MSTLINK_SOFTWARE_MVID		(0x00000040)
>  #define REG_MSTLINK_SOFTWARE_NVID		(0x00000044)
>  #define REG_DP_MSTLINK_TOTAL_HOR_VER		(0x00000048)
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
