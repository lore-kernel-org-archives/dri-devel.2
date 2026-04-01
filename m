Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9791076377
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA20610E38C;
	Wed,  1 Apr 2026 06:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IETE1HgG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gJMJkybT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F0610E38C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:33:58 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6314OUi11563304
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 06:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DIDwT12F2HzYRvmO+mLn9uhY16gzLALGWF/M0ipyyjM=; b=IETE1HgGSOmJvh3B
 /xoLu+iEYkcEIAe/uGqVF+qUYIuDC0ElhmIwb/frdbL3I70Shgr3YnWthM9/bwT9
 qa9qnnNvSy5tux5WQrUv5nhQHi7LVAG7hk1bhcUvbrpXHifDWu+/71xCYehBDK6H
 lCQuEeZmAf/oMXFpB1cuPWA9LJalXjRRm64071tVc4ZcZYcfAN0t3dENnMYkkH/T
 aTraL68UoxU20KUn5Q6bVnKneKnkz+5sC+FhCh94sulQiCoERjTgsFc3CKaVjROf
 hNII5+JXwZPdye8K5uj+XmE6rc2/Vd8DEsHh8Gt8u2jzMeaMY/0bn/rahBbJMEkV
 Jb6MLg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8va3rey9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:33:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3594620fe97so21488937a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775025237; x=1775630037;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DIDwT12F2HzYRvmO+mLn9uhY16gzLALGWF/M0ipyyjM=;
 b=gJMJkybTC+efBRCvmb0cVWL3pCRUOuB/FBjyK+knP55WDz/Thk+bimcDo1OuOgATE9
 T/tupympbP+Tbf5TFiHzzLQ7oqBgVbtdxEIOnFeWz9BWJ8/aDgtejsjX/sZieXpn8j6u
 ++Z/PqjGAHXouJl42Dki5t8dGt+gD5tF4VcM9g2tm/jM7C+4WMEFcm1CVU0BwGIxKDIG
 opNb1OZxpz3rYpteKyybmpa8xbiLCKZ7ewN95mfBngwWWGrTnUiNGsIPnauxJTl0J27W
 5uNLmQ0PT06PMZr7b8rPEtmGvVi8m88ZRnVugSSP84RM70ILI2Bpu/lYJ7BkppAZiLsS
 nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775025237; x=1775630037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DIDwT12F2HzYRvmO+mLn9uhY16gzLALGWF/M0ipyyjM=;
 b=czjoC9FfngpXVB1IWNqjpvviyfNcfLDU7ZPKw3QRZ5nq0uNCbE0ix2PRMV3ID8gqzK
 UfqAc2QC4zEKqRpRKD3YstpDX6Mh6Y7mpNxEyMksiT/z3UZ6Xdth0wckSjzduJvrWFOE
 wPjhJAKgtQTlJSHPpFPVjWC5/c7B4XV7+fbojL7cebQ8KH6Ai4OdboqVK5j8i7kTOz0d
 e10KMGYDKDqSEbgFe5N+jzGVbKO2InQH6DSGKvVNSgYqR1XXQLUGNZocy1VkjFTELFAE
 9VkYW/MH48Li3eG6ehl+nzLueWWP/g35i9WODp3ET/+fuTk3p+UMC6oqxzWICMb6WDF6
 cXOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMcBQ7LWKHlk07LpRoAF7w32/ucc8u9yDkQhNnPqKHgQ/pE0RiW9ND2oW+xwGG+KbrmlvXth3a2CQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4UbLO5CewPwl665aG6A/8LHe123ihJw76hcJ8GKkIwdXNGvub
 hmYzArl5qB9JfMPB8gyqYeiC4wg7COyHyv3ZcDXumIFoxZ9qHyq/5YPjzMrdhqeETCLonqRKxOs
 dLsaEB5xrkbbneuA5+N6lhUUQ+Xe6OC0KKlN1oeiv9iNFyujsx7wdKT+/bGZln4Atn88pcd4=
X-Gm-Gg: ATEYQzw+gLKjeMd9YVH0W+SXWbJnlQPPqxPeINfwo490JQ1VtennoBepT80vR+ElC9b
 ZVhgL8UOh7Vla0yyio6jYMwAPke1OArN556mVRlkTqWfpijsVeGAAW28+e0RtiGNZG37reB41IM
 kTFLZCy66AIQlgJKVQtmDKY9ifH1HZRFXBiAPUmQGKfLApoegBcP7x6HniHwcMJUb9y+RT44LzJ
 GHWX+PDWVLBoe/F0fyZD5q9hQs3P+V8AQoMJ7uloe6glPDVb9PMF7ZkHYx/aPbUHZyvA5VYCVP8
 o9fxXsfUQW5xpf+8Ut98ZQ70EH136jlq/zJA/w0Hna+oovEQM2dNc1RVcOwR/VxhJj571HB2iAe
 xVhtnZyPKPPIFpMPqYVaudtaOh3EuU66BsQAMkwut9ljqK+2/7nq/CQZ1kf1gxgPcfbZwucOkHr
 Gf407rAor/SseKWJgs7g==
X-Received: by 2002:a17:90b:518e:b0:356:2c7b:c026 with SMTP id
 98e67ed59e1d1-35dc6f291bamr2375747a91.23.1775025236502; 
 Tue, 31 Mar 2026 23:33:56 -0700 (PDT)
X-Received: by 2002:a17:90b:518e:b0:356:2c7b:c026 with SMTP id
 98e67ed59e1d1-35dc6f291bamr2375725a91.23.1775025235980; 
 Tue, 31 Mar 2026 23:33:55 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe937925sm5142713a91.12.2026.03.31.23.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 23:33:55 -0700 (PDT)
Message-ID: <0037ba69-c104-488c-a388-8d31dcbbc78f@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 14:33:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/38] drm/msm/dp: use stream_id to change offsets in
 dp_catalog
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
 <20250825-msm-dp-mst-v3-15-01faacfcdedd@oss.qualcomm.com>
 <vrbxqjfvg6urywwmehoykz463vphfg6c2qiryedulvlrcbvals@55lm4fmgf3in>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <vrbxqjfvg6urywwmehoykz463vphfg6c2qiryedulvlrcbvals@55lm4fmgf3in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lyCjAYxOLoW3iMR2ZK0JVzvDbGQvgz0y
X-Proofpoint-ORIG-GUID: lyCjAYxOLoW3iMR2ZK0JVzvDbGQvgz0y
X-Authority-Analysis: v=2.4 cv=B/C0EetM c=1 sm=1 tr=0 ts=69ccbc55 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dt10Ds6hDOc12g75CZYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1NSBTYWx0ZWRfX55U+9H5RKWUW
 +4QQSpTrybBKql0/6QsILDQ+OZZSPqouxnmD/om93qGUne6Y0pUkcadSm3Vk7H+8oYZMeJ/UN+U
 xKUc+nQfKAUlyuNh4lAz93XLR2xRYUTJuEk9YoZh3tGnX3xXPnImpo7Ct3pRzl15WsPrRjTlfBs
 zJ0BjujCGgr8yrRXOViz1AvUzfU8EjWBRz4ZpilCrTDo6Yky2IqJWqPULV7uKXEMc8MjaSQMoqb
 1ujjE6fANmuumCFens8KRv6kiGRmRp9GeECHVn4A2Z3RTPRu/e6NFTnrWpCwL2N55GJNSYEw2Cw
 q40rY0HY4msbM7F+RMbnYabXV8qGb2tW4FeWJOvkB4x39wj5O2T+TN+vlzy4bb1Qc5G2OUiXV19
 gVz8H1mzSd62rbYjpnXHJdFOnOe+JFrKmXqlp0A699hKJ99+FocwJYpVhI2l2rnzK15A3EGUX+D
 7VYMCztSwynhOJT0B9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010055
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



On 8/26/2025 2:01 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:01PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Use the dp_panel's stream_id to adjust the offsets for stream 1
>> which will be used for MST in the dp_catalog. Stream 1 share the
>> same link clk with stream 0 with different reg offset. Also add
> 
> Shares what? How do we handle streams 2 and 3?
> 
Stream 0 and stream 1 are controlled by *_DPTX0_LCLK, stream 2 uses 
*_MST_2_LCLK, and stream 3 uses *_MST_3_LCLK. Will update commit message.
>> additional register defines for stream 1.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c  | 24 ++++++++++---
>>   drivers/gpu/drm/msm/dp/dp_panel.c | 72 +++++++++++++++++++++++++++------------
>>   drivers/gpu/drm/msm/dp/dp_reg.h   |  9 +++++
>>   3 files changed, 79 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index d4a74c6b70fb182ad8a0a786f85a0f50982d3858..b8b6a09966aed96f705bdd54cb16ea63e5f0141f 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -384,6 +384,7 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>>   					    struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	u32 config = 0, tbd;
>> +	u32 reg_offset = 0;
>>   
>>   	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
>>   
>> @@ -400,7 +401,8 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>>   
>>   	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
>>   
>> -	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>> +	if (msm_dp_panel->stream_id == DP_STREAM_1)
>> +		reg_offset = REG_DP1_CONFIGURATION_CTRL - REG_DP_CONFIGURATION_CTRL;
>>   }
>>   
>>   static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
>> @@ -451,12 +453,16 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
>>   					   struct msm_dp_panel *msm_dp_panel)
>>   {
>>   	u32 colorimetry_cfg, test_bits_depth, misc_val;
>> +	u32 reg_offset = 0;
>>   
>>   	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
>>   		msm_dp_panel->msm_dp_mode.bpp);
>>   	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
>>   
>> -	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
>> +	if (msm_dp_panel->stream_id == DP_STREAM_1)
>> +		reg_offset = REG_DP1_MISC1_MISC0 - REG_DP_MISC1_MISC0;
>> +
>> +	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0 + reg_offset);
>>   
>>   	/* clear bpp bits */
>>   	misc_val &= ~(0x07 << DP_MISC0_TEST_BITS_DEPTH_SHIFT);
>> @@ -466,7 +472,7 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
>>   	misc_val |= DP_MISC0_SYNCHRONOUS_CLK;
>>   
>>   	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
>> -	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
>> +	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0 + reg_offset, misc_val);
>>   }
>>   
>>   static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
>> @@ -2431,6 +2437,7 @@ static int msm_dp_ctrl_link_retrain(struct msm_dp_ctrl_private *ctrl)
>>   }
>>   
>>   static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
>> +			       struct msm_dp_panel *msm_dp_panel,
>>   			       u32 rate, u32 stream_rate_khz,
>>   			       bool is_ycbcr_420)
>>   {
>> @@ -2440,6 +2447,12 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
>>   	u32 const link_rate_hbr2 = 540000;
>>   	u32 const link_rate_hbr3 = 810000;
>>   	unsigned long den, num;
>> +	u32 mvid_reg_off = 0, nvid_reg_off = 0;
>> +
>> +	if (msm_dp_panel->stream_id == DP_STREAM_1) {
>> +		mvid_reg_off = REG_DP1_SOFTWARE_MVID - REG_DP_SOFTWARE_MVID;
>> +		nvid_reg_off = REG_DP1_SOFTWARE_NVID - REG_DP_SOFTWARE_NVID;
>> +	}
>>   
>>   	if (rate == link_rate_hbr3)
>>   		pixel_div = 6;
>> @@ -2482,8 +2495,8 @@ static void msm_dp_ctrl_config_msa(struct msm_dp_ctrl_private *ctrl,
>>   		nvid *= 3;
>>   
>>   	drm_dbg_dp(ctrl->drm_dev, "mvid=0x%x, nvid=0x%x\n", mvid, nvid);
>> -	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_MVID, mvid);
>> -	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID, nvid);
>> +	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_MVID + mvid_reg_off, mvid);
>> +	msm_dp_write_link(ctrl, REG_DP_SOFTWARE_NVID + nvid_reg_off, nvid);
>>   }
>>   
>>   int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train)
>> @@ -2559,6 +2572,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>>   	msm_dp_ctrl_configure_source_params(ctrl, msm_dp_panel);
>>   
>>   	msm_dp_ctrl_config_msa(ctrl,
>> +		msm_dp_panel,
>>   		ctrl->link->link_params.rate,
>>   		pixel_rate_orig,
>>   		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
>> index e8c1cf0c7dab7217b8bfe7ecd586af33d7547ca9..d1af389dffcfee2d21a616de6ee027374997aaee 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
>> @@ -377,27 +377,35 @@ static void msm_dp_panel_send_vsc_sdp(struct msm_dp_panel_private *panel, struct
>>   	u32 header[2];
>>   	u32 val;
>>   	int i;
>> +	u32 offset = 0;
>> +
>> +	if (panel->msm_dp_panel.stream_id == DP_STREAM_1)
>> +		offset = MMSS_DP1_GENERIC0_0 - MMSS_DP_GENERIC0_0;
>>   
>>   	msm_dp_utils_pack_sdp_header(&vsc_sdp->sdp_header, header);
>>   
>> -	msm_dp_write_link(panel, MMSS_DP_GENERIC0_0, header[0]);
>> -	msm_dp_write_link(panel, MMSS_DP_GENERIC0_1, header[1]);
>> +	msm_dp_write_link(panel, MMSS_DP_GENERIC0_0 + offset, header[0]);
>> +	msm_dp_write_link(panel, MMSS_DP_GENERIC0_1 + offset, header[1]);
>>   
>>   	for (i = 0; i < sizeof(vsc_sdp->db); i += 4) {
>>   		val = ((vsc_sdp->db[i]) | (vsc_sdp->db[i + 1] << 8) | (vsc_sdp->db[i + 2] << 16) |
>>   		       (vsc_sdp->db[i + 3] << 24));
>> -		msm_dp_write_link(panel, MMSS_DP_GENERIC0_2 + i, val);
>> +		msm_dp_write_link(panel, MMSS_DP_GENERIC0_2 + i + offset, val);
>>   	}
>>   }
>>   
>>   static void msm_dp_panel_update_sdp(struct msm_dp_panel_private *panel)
>>   {
>>   	u32 hw_revision = panel->msm_dp_panel.hw_revision;
>> +	u32 offset = 0;
>> +
>> +	if (panel->msm_dp_panel.stream_id == DP_STREAM_1)
>> +		offset = MMSS_DP1_SDP_CFG3 - MMSS_DP_SDP_CFG3;
>>   
>>   	if (hw_revision >= DP_HW_VERSION_1_0 &&
>>   	    hw_revision < DP_HW_VERSION_1_2) {
>> -		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3, UPDATE_SDP);
>> -		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3, 0x0);
>> +		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3 + offset, UPDATE_SDP);
>> +		msm_dp_write_link(panel, MMSS_DP_SDP_CFG3 + offset, 0x0);
>>   	}
>>   }
>>   
>> @@ -406,16 +414,25 @@ void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sd
>>   	struct msm_dp_panel_private *panel =
>>   		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>>   	u32 cfg, cfg2, misc;
>> +	u32 misc_reg_offset = 0;
>> +	u32 sdp_cfg_offset = 0;
>> +	u32 sdp_cfg2_offset = 0;
>> +
>> +	if (msm_dp_panel->stream_id == DP_STREAM_1) {
>> +		misc_reg_offset = REG_DP1_MISC1_MISC0 - REG_DP_MISC1_MISC0;
>> +		sdp_cfg_offset = MMSS_DP1_SDP_CFG - MMSS_DP_SDP_CFG;
>> +		sdp_cfg2_offset = MMSS_DP1_SDP_CFG2 - MMSS_DP_SDP_CFG2;
>> +	}
>>   
>> -	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG);
>> -	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2);
>> -	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0);
>> +	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG + sdp_cfg_offset);
>> +	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2 + sdp_cfg2_offset);
>> +	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0 + misc_reg_offset);
>>   
>>   	cfg |= GEN0_SDP_EN;
>> -	msm_dp_write_link(panel, MMSS_DP_SDP_CFG, cfg);
>> +	msm_dp_write_link(panel, MMSS_DP_SDP_CFG + sdp_cfg_offset, cfg);
>>   
>>   	cfg2 |= GENERIC0_SDPSIZE_VALID;
>> -	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2);
>> +	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2 + sdp_cfg2_offset, cfg2);
>>   
>>   	msm_dp_panel_send_vsc_sdp(panel, vsc_sdp);
>>   
>> @@ -425,7 +442,7 @@ void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sd
>>   	drm_dbg_dp(panel->drm_dev, "vsc sdp enable=1\n");
>>   
>>   	pr_debug("misc settings = 0x%x\n", misc);
>> -	msm_dp_write_link(panel, REG_DP_MISC1_MISC0, misc);
>> +	msm_dp_write_link(panel, REG_DP_MISC1_MISC0 + misc_reg_offset, misc);
>>   
>>   	msm_dp_panel_update_sdp(panel);
>>   }
>> @@ -435,16 +452,25 @@ void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel)
>>   	struct msm_dp_panel_private *panel =
>>   		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>>   	u32 cfg, cfg2, misc;
>> +	u32 misc_reg_offset = 0;
>> +	u32 sdp_cfg_offset = 0;
>> +	u32 sdp_cfg2_offset = 0;
>> +
>> +	if (msm_dp_panel->stream_id == DP_STREAM_1) {
>> +		misc_reg_offset = REG_DP1_MISC1_MISC0 - REG_DP_MISC1_MISC0;
>> +		sdp_cfg_offset = MMSS_DP1_SDP_CFG - MMSS_DP_SDP_CFG;
>> +		sdp_cfg2_offset = MMSS_DP1_SDP_CFG2 - MMSS_DP_SDP_CFG2;
>> +	}
>>   
>> -	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG);
>> -	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2);
>> -	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0);
>> +	cfg = msm_dp_read_link(panel, MMSS_DP_SDP_CFG + sdp_cfg_offset);
>> +	cfg2 = msm_dp_read_link(panel, MMSS_DP_SDP_CFG2 + sdp_cfg2_offset);
>> +	misc = msm_dp_read_link(panel, REG_DP_MISC1_MISC0 + misc_reg_offset);
>>   
>>   	cfg &= ~GEN0_SDP_EN;
>> -	msm_dp_write_link(panel, MMSS_DP_SDP_CFG, cfg);
>> +	msm_dp_write_link(panel, MMSS_DP_SDP_CFG + sdp_cfg_offset, cfg);
>>   
>>   	cfg2 &= ~GENERIC0_SDPSIZE_VALID;
>> -	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2, cfg2);
>> +	msm_dp_write_link(panel, MMSS_DP_SDP_CFG2 + sdp_cfg2_offset, cfg2);
>>   
>>   	/* switch back to MSA */
>>   	misc &= ~DP_MISC1_VSC_SDP;
>> @@ -452,7 +478,7 @@ void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel)
>>   	drm_dbg_dp(panel->drm_dev, "vsc sdp enable=0\n");
>>   
>>   	pr_debug("misc settings = 0x%x\n", misc);
>> -	msm_dp_write_link(panel, REG_DP_MISC1_MISC0, misc);
>> +	msm_dp_write_link(panel, REG_DP_MISC1_MISC0 + misc_reg_offset, misc);
>>   
>>   	msm_dp_panel_update_sdp(panel);
>>   }
>> @@ -510,6 +536,7 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>>   	u32 msm_dp_active;
>>   	u32 total;
>>   	u32 reg;
>> +	u32 offset = 0;
>>   
>>   	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
>>   	drm_mode = &panel->msm_dp_panel.msm_dp_mode.drm_mode;
>> @@ -524,6 +551,9 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>>   		drm_mode->vsync_start - drm_mode->vdisplay,
>>   		drm_mode->vsync_end - drm_mode->vsync_start);
>>   
>> +	if (msm_dp_panel->stream_id == DP_STREAM_1)
>> +		offset = REG_DP1_TOTAL_HOR_VER - REG_DP_TOTAL_HOR_VER;
>> +
>>   	total_hor = drm_mode->htotal;
>>   
>>   	total_ver = drm_mode->vtotal;
>> @@ -554,10 +584,10 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
>>   
>>   	msm_dp_active = data;
>>   
>> -	msm_dp_write_link(panel, REG_DP_TOTAL_HOR_VER, total);
>> -	msm_dp_write_link(panel, REG_DP_START_HOR_VER_FROM_SYNC, sync_start);
>> -	msm_dp_write_link(panel, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY, width_blanking);
>> -	msm_dp_write_link(panel, REG_DP_ACTIVE_HOR_VER, msm_dp_active);
>> +	msm_dp_write_link(panel, REG_DP_TOTAL_HOR_VER + offset, total);
>> +	msm_dp_write_link(panel, REG_DP_START_HOR_VER_FROM_SYNC  + offset, sync_start);
>> +	msm_dp_write_link(panel, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY + offset, width_blanking);
>> +	msm_dp_write_link(panel, REG_DP_ACTIVE_HOR_VER  + offset, msm_dp_active);
>>   
>>   	reg = msm_dp_read_pn(panel, MMSS_DP_INTF_CONFIG);
>>   	if (wide_bus_en)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>> index b851efc132ea03884ce2563990fbc24c9577e724..43a9ce0539906e1f185abf250fdf161e462d9645 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>> @@ -141,6 +141,7 @@
>>   #define DP_STATE_CTRL_PUSH_IDLE			(0x00000100)
>>   
>>   #define REG_DP_CONFIGURATION_CTRL		(0x00000008)
>> +#define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
>>   #define DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK	(0x00000001)
>>   #define DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN (0x00000002)
>>   #define DP_CONFIGURATION_CTRL_P_INTERLACED	(0x00000004)
>> @@ -159,11 +160,15 @@
>>   #define REG_DP_SOFTWARE_MVID			(0x00000010)
>>   #define REG_DP_SOFTWARE_NVID			(0x00000018)
>>   #define REG_DP_TOTAL_HOR_VER			(0x0000001C)
>> +#define REG_DP1_SOFTWARE_MVID			(0x00000414)
>> +#define REG_DP1_SOFTWARE_NVID			(0x00000418)
>> +#define REG_DP1_TOTAL_HOR_VER			(0x0000041C)
>>   #define REG_DP_START_HOR_VER_FROM_SYNC		(0x00000020)
>>   #define REG_DP_HSYNC_VSYNC_WIDTH_POLARITY	(0x00000024)
>>   #define REG_DP_ACTIVE_HOR_VER			(0x00000028)
>>   
>>   #define REG_DP_MISC1_MISC0			(0x0000002C)
>> +#define REG_DP1_MISC1_MISC0			(0x0000042C)
>>   #define DP_MISC0_SYNCHRONOUS_CLK		(0x00000001)
>>   #define DP_MISC0_COLORIMETRY_CFG_SHIFT		(0x00000001)
>>   #define DP_MISC0_TEST_BITS_DEPTH_SHIFT		(0x00000005)
>> @@ -230,8 +235,10 @@
>>   #define MMSS_DP_AUDIO_CTRL_RESET		(0x00000214)
>>   
>>   #define MMSS_DP_SDP_CFG				(0x00000228)
>> +#define MMSS_DP1_SDP_CFG			(0x000004E0)
>>   #define GEN0_SDP_EN				(0x00020000)
>>   #define MMSS_DP_SDP_CFG2			(0x0000022C)
>> +#define MMSS_DP1_SDP_CFG2			(0x000004E4)
>>   #define MMSS_DP_AUDIO_TIMESTAMP_0		(0x00000230)
>>   #define MMSS_DP_AUDIO_TIMESTAMP_1		(0x00000234)
>>   #define GENERIC0_SDPSIZE_VALID			(0x00010000)
>> @@ -240,6 +247,7 @@
>>   #define MMSS_DP_AUDIO_STREAM_1			(0x00000244)
>>   
>>   #define MMSS_DP_SDP_CFG3			(0x0000024c)
>> +#define MMSS_DP1_SDP_CFG3			(0x000004E8)
>>   #define UPDATE_SDP				(0x00000001)
>>   
>>   #define MMSS_DP_EXTENSION_0			(0x00000250)
>> @@ -288,6 +296,7 @@
>>   #define MMSS_DP_GENERIC1_7			(0x00000344)
>>   #define MMSS_DP_GENERIC1_8			(0x00000348)
>>   #define MMSS_DP_GENERIC1_9			(0x0000034C)
>> +#define MMSS_DP1_GENERIC0_0			(0x00000490)
>>   
>>   #define MMSS_DP_VSCEXT_0			(0x000002D0)
>>   #define MMSS_DP_VSCEXT_1			(0x000002D4)
>>
>> -- 
>> 2.34.1
>>
> 

