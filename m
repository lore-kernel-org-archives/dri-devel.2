Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BF8D3514A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DAF210E2CB;
	Wed,  1 Apr 2026 07:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pyk+Yi7n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFmaD4sK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4BB10E012
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:21:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6314RRp33363375
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bTqCzsi1nmutkFjK1Fp2iUhqvTOgCiaWiH7VqwnHzVg=; b=pyk+Yi7nQzOlxe6/
 55pLlXvH91O1c5q8Ks5XPEKtzgbRnua3ZMF2Ur+x2QA+ZSobDP8S9j52Bu369/JJ
 fuK92xI1OYSwP01M8jpGaARWVbLo6NBtMaZ54JCfU8fpWCo/Wkz2g8qlsAIzpvE2
 4q3KOPmjz6dJSDA3phrsudiyxYoCYwIbM0ArLTzeoc2OhtnaW9FN14OgN2frjDX3
 hgdBMtmVzIDIw6laspPHPyDbytmCVQ7FHXCUUtpiLijjtvFZB3J66yGPE7uOzpMX
 CcaQ3AkiCHw+kvhqgoR/280H/VVlj70VWk+qNr4lYxZmMt24PmsfnBoykS3AR9D3
 EymeTw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddj5ut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:21:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358df8fbd1cso7888744a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028062; x=1775632862;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bTqCzsi1nmutkFjK1Fp2iUhqvTOgCiaWiH7VqwnHzVg=;
 b=iFmaD4sK9VaoZKovN6oKTXMTnbAacvsi170+xNwiiERWQ02ImQaSBftHqALwK7kLtv
 Km5OauAPVeYT8KMR8b7DJ3Dk0eZLT9fRKprrln360zqOwfplSMxklJImZ4u4z5UtgDXq
 nzBAcu2qVNDDcfwJ2+Dc3+Prhi5mLrwzuDGxwuZERLueBmGVLer004BIwyz6NwK2TVer
 5pBYdgWU0bOAFja33nMICsT8Fc829JdeS/9KXwb7IQmZAhLKEM+eJ6to2qHFQG0bjdK2
 BtTYL6tuvVBSfNr/uYwHOKfyQjOxmcymFJbdGzBe3FY7Iq7iV0EsbM7h2L+D+b6+fQ5c
 N9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028062; x=1775632862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bTqCzsi1nmutkFjK1Fp2iUhqvTOgCiaWiH7VqwnHzVg=;
 b=CLrqkkrqRHcoWVjxV6QQfwHD2RLllpKx1zHe6UflHtKdiRos50dqPla74GBXda8gBf
 OjqkeEsbQNqgRYYYuSxoAwPGsP44lA0Zo42RiqHzLb0Ppi9SuTSt+oDNC2H1lw7HOFE4
 TSt7Qg16UdcJbMkWR5teYObMlbXNyMTTsOgR2TxQh0zB4iUBcCylDrLpUluqHqC+VPRt
 hFvoGUin2PERN4TqWeAaC1BtCmRqdAIVIAIv7UTR6guy/HLI98sJTp5XjtO8rkL/KU0N
 TnY7LFykJGPBbIOFh4J7hqudTauCidggpKLmodndKXH64wbA/D58p5mPhEsiikoOGOGe
 kfFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS+75n4QyHJYrVRhwtaUxMskfMiizXbMycW/WBRyM504NXWdwjvvF2CJgV55608eVV1C5QWs/UqKE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJjxTLBxSVUtRpG6KjHOwjrOx1j/fJIqWp1kA258vT5N4/zQ1t
 klUFP7rLS3dteSr0c44BZgIDPvWePmg9Ncil2VhsibjOG3BuGhmejlPxcspsM84okddpbIb+rcq
 oxv5vYJ8QvxTd8pU/P7wV7FALVSGE19DRnnx3xUh3m23TnLWpvPlmWEcH7vpzngPR0jcahuY=
X-Gm-Gg: ATEYQzy5G49TOfRZ40uVa39awQpA+Wn2H8f03sZ9f5Fcirunwl8PAduhPYhgr3Rb+/L
 1A+2Jk6fxxNO/7c/tSgM2jVSPack4OowCggh3phDvo3PHgwcHm7HCU7CRHAZoqWvMU7MGOImpAP
 iFy+h3MM7V6bDOYCe5hzT528IWsn+PDOIIb0/39EeD+UY4fZ3Iq9Tn+pnmLba/fAZBva7ljGcb7
 Xhl39j69/6GmChP7XtsQ6PXMgQ4XBzdYkEJvhU1lB/1nPuuDNx4BX2iX+xh1iKPFLsKo+ueJl/6
 kjEqw06LBmTXlcbxCjzxrUboM4yfGuXZn0ouX+niwrkapEwfHVsnR8K5NvLbUQb30Gqp3w2x7Or
 0707pxsqUfHrBsVQ3EBxSMhqUDJcso8iXhMoahf5DMkMM+u2Lvjc1gWZ2y/xk0NddADy0FSCTZT
 OwFixmZGjKJi/QrJekdA==
X-Received: by 2002:a17:90b:1d02:b0:35b:9896:cbcd with SMTP id
 98e67ed59e1d1-35dc6f66f0amr2281824a91.27.1775028061696; 
 Wed, 01 Apr 2026 00:21:01 -0700 (PDT)
X-Received: by 2002:a17:90b:1d02:b0:35b:9896:cbcd with SMTP id
 98e67ed59e1d1-35dc6f66f0amr2281756a91.27.1775028061012; 
 Wed, 01 Apr 2026 00:21:01 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe6372e2sm3885896a91.5.2026.04.01.00.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 00:21:00 -0700 (PDT)
Message-ID: <272ec84a-d4d8-4f6d-93ec-980ac43179d5@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 15:20:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/38] drm/msm/dp: Add support for MST channel slot
 allocation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-20-01faacfcdedd@oss.qualcomm.com>
 <jbobh2meagyzmv6p3lxnu55wyzavldhyqloudcfj3cybeaco3e@hfip5yehyepv>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <jbobh2meagyzmv6p3lxnu55wyzavldhyqloudcfj3cybeaco3e@hfip5yehyepv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69ccc75f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=SW2CPrdtkTpymd68sWcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: i8mzl4j_JnpYsDasHS7XdjFyZcp4LubC
X-Proofpoint-ORIG-GUID: i8mzl4j_JnpYsDasHS7XdjFyZcp4LubC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MyBTYWx0ZWRfXxg7hA7e5UQnJ
 DKtmfnqfj9Cvyz/KPJ4O7rZtvhrKgXdyKueZidEXq+4oiWCOalPqd389L06Zb01B6IwwXGLI3g/
 nQ5DsZVxNOQz9mz5zYXkwLi5OIJxtaNQ9Yzdwxw1qX+KUERmZCFsQikz3SpMmsf22D4j0QZg4GJ
 p+aC3G/CtP9qWqgdvSF+8Z90Q5mFVdkN6d3KFPy7IOL5bHPqU5KV9FoAKKIQO+p3dX/feU3yB7n
 RrPrjgndbdXvil13KWd2JByS4wbsn0g6bbcBpCMvcPcn/XmFpxeSyyAouKiGRECLyuNcBOFbO6y
 nRQ1P5rnAKtO0W9kWVZQqIk3FNg13hXHfHXRQ93UL8gVWnqbdiG5b8CqB5X5M5t47T03oQTOMBM
 rtPZCKTu/aqsqRcjy5CzNYnYvoPlcYS3dE+c13/5mhg9wQ3F7X/Ac2H7DkW9X8T1/1rdKER5riJ
 28y2YJNRyKmq4c7hPBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010063
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



On 8/26/2025 5:52 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:06PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> DP MST streams share 64 MTP slots in a time-multiplexed manner. This patch
>> adds support for calculating the rate governor, slot allocation, and slot
>> reservation in the DP controller.
>>
>> Each MST stream can reserve its slots by calling
>> dp_display_set_stream_info() from its bridge callbacks.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 213 +++++++++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |   7 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  40 ++++---
>>   drivers/gpu/drm/msm/dp/dp_display.h |   5 +-
>>   drivers/gpu/drm/msm/dp/dp_panel.h   |   1 +
>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  14 ++-
>>   6 files changed, 262 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index c313a3b4853a1571c43a9f3c9e981fbc22d51d55..9d58d9480fc4ab33c58218ef9beb54c64805c34c 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -109,6 +109,11 @@ struct msm_dp_vc_tu_mapping_table {
>>   	u8 tu_size_minus1;
>>   };
>>   
>> +struct msm_dp_mst_ch_slot_info {
>> +	u32 start_slot;
>> +	u32 tot_slots;
>> +};
>> +
>>   struct msm_dp_ctrl_private {
>>   	struct msm_dp_ctrl msm_dp_ctrl;
>>   	struct drm_device *drm_dev;
>> @@ -143,6 +148,8 @@ struct msm_dp_ctrl_private {
>>   	bool link_clks_on;
>>   	bool stream_clks_on[DP_STREAM_MAX];
>>   	bool mst_active;
>> +
>> +	struct msm_dp_mst_ch_slot_info mst_ch_info[DP_STREAM_MAX];
>>   };
>>   
>>   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
>> @@ -267,6 +274,77 @@ static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable
>>   	msm_dp_write_link(ctrl, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
>>   }
>>   
>> +static void msm_dp_ctrl_mst_channel_alloc(struct msm_dp_ctrl_private *ctrl,
>> +				      enum msm_dp_stream_id stream_id, u32 ch_start_slot,
>> +				      u32 tot_slot_cnt)
>> +{
>> +	u32 i, slot_reg_1, slot_reg_2, slot;
>> +	u32 reg_off = 0;
>> +	int const num_slots_per_reg = 32;
>> +
>> +	if (ch_start_slot > DP_MAX_TIME_SLOTS ||
>> +	    (ch_start_slot + tot_slot_cnt > DP_MAX_TIME_SLOTS)) {
>> +		DRM_ERROR("invalid slots start %d, tot %d\n",
>> +			  ch_start_slot, tot_slot_cnt);
>> +		return;
>> +	}
>> +
>> +	drm_dbg_dp(ctrl->drm_dev, "stream_id %d, start_slot %d, tot_slot %d\n",
>> +		   stream_id, ch_start_slot, tot_slot_cnt);
>> +
>> +	if (stream_id == DP_STREAM_1)
>> +		reg_off = REG_DP_DP1_TIMESLOT_1_32 - REG_DP_DP0_TIMESLOT_1_32;
>> +
>> +	slot_reg_1 = 0;
>> +	slot_reg_2 = 0;
>> +
>> +	if (ch_start_slot && tot_slot_cnt) {
>> +		ch_start_slot--;
>> +		for (i = 0; i < tot_slot_cnt; i++) {
> 
> You can replace loops with maths.
> 
Ack.
>> +			if (ch_start_slot < num_slots_per_reg) {
>> +				slot_reg_1 |= BIT(ch_start_slot);
>> +			} else {
>> +				slot = ch_start_slot - num_slots_per_reg;
>> +				slot_reg_2 |= BIT(slot);
>> +			}
>> +			ch_start_slot++;
>> +		}
>> +	}
>> +
>> +	drm_dbg_dp(ctrl->drm_dev, "stream_id:%d slot_reg_1:%d, slot_reg_2:%d\n", stream_id,
>> +		   slot_reg_1, slot_reg_2);
>> +
>> +	if (stream_id > DP_STREAM_1) {
>> +		msm_dp_write_mstlink(ctrl, stream_id, REG_DP_MSTLINK_TIMESLOT_1_32,
>> +				      slot_reg_1);
>> +		msm_dp_write_mstlink(ctrl, stream_id, REG_DP_MSTLINK_TIMESLOT_33_63,
>> +				      slot_reg_2);
>> +	} else {
>> +		msm_dp_write_link(ctrl, REG_DP_DP0_TIMESLOT_1_32 + reg_off, slot_reg_1);
>> +		msm_dp_write_link(ctrl, REG_DP_DP0_TIMESLOT_33_63 + reg_off, slot_reg_2);
>> +	}
>> +}
>> +
>> +static void msm_dp_ctrl_update_rg(struct msm_dp_ctrl_private *ctrl,
>> +				 enum msm_dp_stream_id stream_id, u32 x_int, u32 y_frac_enum)
>> +{
>> +	u32 rg, reg_off = 0;
>> +
>> +	rg = y_frac_enum;
>> +	rg |= (x_int << 16);
>> +
>> +	drm_dbg_dp(ctrl->drm_dev, "stream_id: %d x_int:%d y_frac_enum:%d rg:%d\n",
>> +		stream_id, x_int, y_frac_enum, rg);
>> +
>> +	if (stream_id == DP_STREAM_1)
>> +		reg_off = REG_DP_DP1_RG - REG_DP_DP0_RG;
>> +
>> +	if (stream_id > DP_STREAM_1)
>> +		msm_dp_write_mstlink(ctrl, stream_id, REG_DP_MSTLINK_DP_RG, rg);
>> +	else
>> +		msm_dp_write_link(ctrl, REG_DP_DP0_RG + reg_off, rg);
>> +}
>> +
>>   /*
>>    * NOTE: resetting DP controller will also clear any pending HPD related interrupts
>>    */
>> @@ -2634,7 +2712,105 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
>>   	return ret;
>>   }
>>   
>> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
>> +static void msm_dp_ctrl_mst_calculate_rg(struct msm_dp_ctrl_private *ctrl,
>> +					 struct msm_dp_panel *panel,
>> +					 u32 *p_x_int, u32 *p_y_frac_enum)
> 
> A comment would be appreciated.
> 
Ack. Will update it.
>> +{
>> +	u64 min_slot_cnt, max_slot_cnt;
>> +	u64 raw_target_sc, target_sc_fixp;
>> +	u64 ts_denom, ts_enum, ts_int;
>> +	u64 pclk = panel->msm_dp_mode.drm_mode.clock;
>> +	u64 lclk = 0;
>> +	u64 lanes = ctrl->link->link_params.num_lanes;
>> +	u64 bpp = panel->msm_dp_mode.bpp;
>> +	u64 pbn = panel->pbn;
>> +	u64 numerator, denominator, temp, temp1, temp2;
>> +	u32 x_int = 0, y_frac_enum = 0;
>> +	u64 target_strm_sym, ts_int_fixp, ts_frac_fixp, y_frac_enum_fixp;
>> +
>> +	lclk = ctrl->link->link_params.rate;
>> +
>> +	/* min_slot_cnt */
>> +	numerator = pclk * bpp * 64 * 1000;
>> +	denominator = lclk * lanes * 8 * 1000;
>> +	min_slot_cnt = drm_fixp_from_fraction(numerator, denominator);
>> +
>> +	/* max_slot_cnt */
>> +	numerator = pbn * 54 * 1000;
>> +	denominator = lclk * lanes;
>> +	max_slot_cnt = drm_fixp_from_fraction(numerator, denominator);
>> +
>> +	/* raw_target_sc */
>> +	numerator = max_slot_cnt + min_slot_cnt;
>> +	denominator = drm_fixp_from_fraction(2, 1);
>> +	raw_target_sc = drm_fixp_div(numerator, denominator);
>> +
>> +	/* target_sc */
>> +	temp = drm_fixp_from_fraction(256 * lanes, 1);
>> +	numerator = drm_fixp_mul(raw_target_sc, temp);
>> +	denominator = drm_fixp_from_fraction(256 * lanes, 1);
>> +	target_sc_fixp = drm_fixp_div(numerator, denominator);
>> +
>> +	ts_enum = 256 * lanes;
>> +	ts_denom = drm_fixp_from_fraction(256 * lanes, 1);
>> +	ts_int = drm_fixp2int(target_sc_fixp);
>> +
>> +	temp = drm_fixp2int_ceil(raw_target_sc);
>> +	if (temp != ts_int) {
>> +		temp = drm_fixp_from_fraction(ts_int, 1);
>> +		temp1 = raw_target_sc - temp;
>> +		temp2 = drm_fixp_mul(temp1, ts_denom);
>> +		ts_enum = drm_fixp2int(temp2);
>> +	}
>> +
>> +	/* target_strm_sym */
>> +	ts_int_fixp = drm_fixp_from_fraction(ts_int, 1);
>> +	ts_frac_fixp = drm_fixp_from_fraction(ts_enum, drm_fixp2int(ts_denom));
>> +	temp = ts_int_fixp + ts_frac_fixp;
>> +	temp1 = drm_fixp_from_fraction(lanes, 1);
>> +	target_strm_sym = drm_fixp_mul(temp, temp1);
>> +
>> +	/* x_int */
>> +	x_int = drm_fixp2int(target_strm_sym);
>> +
>> +	/* y_enum_frac */
>> +	temp = drm_fixp_from_fraction(x_int, 1);
>> +	temp1 = target_strm_sym - temp;
>> +	temp2 = drm_fixp_from_fraction(256, 1);
>> +	y_frac_enum_fixp = drm_fixp_mul(temp1, temp2);
>> +
>> +	temp1 = drm_fixp2int(y_frac_enum_fixp);
>> +	temp2 = drm_fixp2int_ceil(y_frac_enum_fixp);
>> +
>> +	y_frac_enum = (u32)((temp1 == temp2) ? temp1 : temp1 + 1);
>> +
>> +	*p_x_int = x_int;
>> +	*p_y_frac_enum = y_frac_enum;
>> +
>> +	drm_dbg_dp(ctrl->drm_dev, "mst lane_cnt:%llu, rate:%llu x_int:%d, y_frac:%d\n",
> 
> globally, for all patches: s/\<mst\>/MST/g
> 
Ohh. sorry. will check all patches..
>> +		   lanes, lclk, x_int, y_frac_enum);
>> +}
>> +
>> +static void msm_dp_ctrl_mst_stream_setup(struct msm_dp_ctrl_private *ctrl,
>> +					 struct msm_dp_panel *panel,
>> +					 u32 max_streams)
> 
> It's not that max_streams can change... I'd totally prefer to stop
> passing it as params.
> 
Okay. We actually need max_stream here, Would you prefer it in ctrl or 
panel?
>> +{
>> +	u32 x_int, y_frac_enum;
>> +
>> +	if (!ctrl->mst_active)
>> +		return;
>> +
>> +	drm_dbg_dp(ctrl->drm_dev, "mst stream channel allocation\n");
>> +
>> +	msm_dp_ctrl_mst_stream_channel_slot_setup(&ctrl->msm_dp_ctrl, max_streams);
>> +
>> +	msm_dp_ctrl_mst_calculate_rg(ctrl, panel, &x_int, &y_frac_enum);
>> +
>> +	msm_dp_ctrl_update_rg(ctrl, panel->stream_id, x_int, y_frac_enum);
>> +}
>> +
>> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl,
>> +			  struct msm_dp_panel *msm_dp_panel, u32 max_streams)
>>   {
>>   	int ret = 0;
>>   	bool mainlink_ready = false;
>> @@ -2688,6 +2864,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>>   	if (!ctrl->mst_active)
>>   		msm_dp_ctrl_setup_tr_unit(ctrl);
>>   
>> +	msm_dp_ctrl_mst_stream_setup(ctrl, msm_dp_panel, max_streams);
>> +
>>   	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>>   
>>   	msm_dp_ctrl_mst_send_act(msm_dp_ctrl);
>> @@ -2742,6 +2920,39 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
>>   			phy, phy->init_count, phy->power_count);
>>   }
>>   
>> +void msm_dp_ctrl_set_mst_channel_info(struct msm_dp_ctrl *msm_dp_ctrl,
>> +				      enum msm_dp_stream_id stream_id,
>> +				      u32 start_slot, u32 tot_slots)
>> +{
>> +	struct msm_dp_ctrl_private *ctrl;
>> +
>> +	if (!msm_dp_ctrl || stream_id >= DP_STREAM_MAX) {
>> +		DRM_ERROR("invalid input\n");
>> +		return;
>> +	}
>> +
>> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>> +
>> +	ctrl->mst_ch_info[stream_id].start_slot = start_slot;
>> +	ctrl->mst_ch_info[stream_id].tot_slots = tot_slots;
>> +}
>> +
>> +void msm_dp_ctrl_mst_stream_channel_slot_setup(struct msm_dp_ctrl *msm_dp_ctrl, u32 max_streams)
>> +{
>> +	struct msm_dp_ctrl_private *ctrl;
>> +	int i;
>> +
>> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>> +
>> +	if (!ctrl->mst_active)
>> +		return;
>> +
>> +	for (i = DP_STREAM_0; i < max_streams; i++) {
>> +		msm_dp_ctrl_mst_channel_alloc(ctrl, i, ctrl->mst_ch_info[i].start_slot,
>> +					      ctrl->mst_ch_info[i].tot_slots);
>> +	}
>> +}
>> +
>>   irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
>>   {
>>   	struct msm_dp_ctrl_private *ctrl;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index abf84ddf463638900684f2511549a593783d2247..751f00c97b94dc3b9e8fae2a86e261f71f293425 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -17,7 +17,8 @@ struct msm_dp_ctrl {
>>   struct phy;
>>   
>>   int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active);
>> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl,
>> +			  struct msm_dp_panel *msm_dp_panel, u32 max_streams);
>>   int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>>   void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
>>   void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
>> @@ -51,4 +52,8 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>>   
>>   void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
>>   void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl);
>> +void msm_dp_ctrl_mst_stream_channel_slot_setup(struct msm_dp_ctrl *msm_dp_ctrl, u32 max_streams);
>> +void msm_dp_ctrl_set_mst_channel_info(struct msm_dp_ctrl *msm_dp_ctrl,
>> +				      enum msm_dp_stream_id stream_id,
>> +				      u32 start_slot, u32 tot_slots);
>>   #endif /* _DP_CTRL_H_ */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index eeba73f81c5ce7929dac88f4b47ac3741659864b..17633ba79aa7642856051b69227e8f5b23d76730 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -733,7 +733,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
>>   		return 0;
>>   	}
>>   
>> -	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
>> +	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel, dp->max_stream);
>>   	if (!rc)
>>   		msm_dp_display->power_on = true;
>>   
>> @@ -817,21 +817,33 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
>>   	return 0;
>>   }
>>   
>> -int msm_dp_display_set_stream_id(struct msm_dp *dp,
>> -				 struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id)
>> +int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
>> +				   enum msm_dp_stream_id stream_id, u32 start_slot,
>> +				   u32 num_slots, u32 pbn, int vcpi)
> 
> vcpi isn't being used at this patch, don't add it.
> 
Ack. thanks for point this.
>>   {
>>   	int rc = 0;
>> -	struct msm_dp_display_private *msm_dp_display;
>> +	struct msm_dp_display_private *dp;
>> +	const int max_slots = 64;
>>   
>> -	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> -	if (!msm_dp_display) {
>> +	if (!dp) {
>>   		DRM_ERROR("invalid input\n");
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (panel)
>> +	if (start_slot + num_slots > max_slots) {
>> +		DRM_ERROR("invalid channel info received. start:%d, slots:%d\n",
>> +			  start_slot, num_slots);
>> +		return -EINVAL;
>> +	}
>> +
>> +	msm_dp_ctrl_set_mst_channel_info(dp->ctrl, stream_id, start_slot, num_slots);
>> +
>> +	if (panel) {
> 
> The panel is always passed, as far as I can see.
> 
Ack.
>>   		panel->stream_id = stream_id;
>> +		panel->pbn = pbn;
>> +	}
>>   
>>   	return rc;
>>   }
>> @@ -1533,7 +1545,7 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>>   
>>   	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> -	msm_dp_display_set_stream_id(msm_dp_display, dp->panel, 0);
>> +	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0, 0);
>>   
>>   	if (msm_dp_display->prepared) {
>>   		rc = msm_dp_display_enable(dp);
>> @@ -1550,14 +1562,16 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>>   	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
>>   }
>>   
>> -void msm_dp_display_atomic_disable(struct msm_dp *dp)
>> +void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
>>   {
>> -	struct msm_dp_display_private *msm_dp_display;
>> +	struct msm_dp_display_private *dp;
>>   
>> -	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>>   
>> -	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
>> -	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
>> +	msm_dp_ctrl_push_idle(dp->ctrl);
>> +	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl,
>> +		dp->max_stream);
>> +	msm_dp_ctrl_mst_send_act(dp->ctrl);
>>   }
>>   
>>   static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index 9442157bca9d63467b4c43fa644651ad2cbcbef5..fa92f763d2304f15af7c4e1e7e8aab5a6ffd3459 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -48,7 +48,8 @@ void msm_dp_display_mode_set(struct msm_dp *dp,
>>   enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>>   					       const struct drm_display_info *info,
>>   					       const struct drm_display_mode *mode);
>> -int msm_dp_display_set_stream_id(struct msm_dp *dp,
>> -				 struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id);
>> +int msm_dp_display_set_stream_info(struct msm_dp *dp_display, struct msm_dp_panel *panel,
>> +				   enum msm_dp_stream_id stream_id,
>> +				   u32 start_slot, u32 num_slots, u32 pbn, int vcpi);
>>   
>>   #endif /* _DP_DISPLAY_H_ */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
>> index 2bfe3695994235d04e209a2785915107c6a8e413..cb5bf6c99a6f7a68995f0f0ac48382dc90beca31 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
>> @@ -50,6 +50,7 @@ struct msm_dp_panel {
>>   	u32 hw_revision;
>>   
>>   	enum msm_dp_stream_id stream_id;
>> +	u32 pbn;
>>   
>>   	u32 max_dp_lanes;
>>   	u32 max_dp_link_rate;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>> index fda847b33f8d0d6ec4d2589586b5a3d6c9b1ccf3..ee4debf796910e00d370ab4c687009747bae5378 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>> @@ -364,6 +364,19 @@
>>   #define REG_DP_PHY_AUX_BIST_CFG			(0x00000050)
>>   #define REG_DP_PHY_AUX_INTERRUPT_STATUS         (0x000000BC)
>>   
>> +/* DP MST related registers */
>> +#define DP_MAX_TIME_SLOTS 64
>> +
>> +#define REG_DP_MSTLINK_DP_RG			(0X0000011C)
>> +#define REG_DP_DP0_TIMESLOT_1_32		(0x00000404)
>> +#define REG_DP_DP0_TIMESLOT_33_63		(0x00000408)
>> +#define REG_DP_DP1_TIMESLOT_1_32		(0x0000040C)
>> +#define REG_DP_DP1_TIMESLOT_33_63		(0x00000410)
>> +#define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
>> +#define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003C)
>> +#define REG_DP_DP0_RG				(0x000004F8)
>> +#define REG_DP_DP1_RG				(0x000004FC)
>> +
>>   /* DP HDCP 1.3 registers */
>>   #define DP_HDCP_CTRL                                   (0x0A0)
>>   #define DP_HDCP_STATUS                                 (0x0A4)
>> @@ -388,5 +401,4 @@
>>   #define HDCP_SEC_DP_TZ_HV_HLOS_HDCP_RCVPORT_DATA10     (0x018)
>>   #define HDCP_SEC_DP_TZ_HV_HLOS_HDCP_RCVPORT_DATA11     (0x01C)
>>   #define HDCP_SEC_DP_TZ_HV_HLOS_HDCP_RCVPORT_DATA12     (0x020)
>> -
>>   #endif /* _DP_REG_H_ */
>>
>> -- 
>> 2.34.1
>>
> 

