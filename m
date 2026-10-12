Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0AECA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFB210F2E3;
	Mon, 12 Oct 2026 18:39:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EFD10F2E8
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:38:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CHujID3040341
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bgRYUW+Bei3Q21MTzmcxk2sT/AX/LHG8dFab1oytdc4=; b=KtVMSz83dFKaiUsR
 UAw/ofTyd9VTRnwAh3AExIWWC99HSrL0W2itiMZCy/ULzSNm8RgUihnUuZ2bKpLl
 9dQQHK9x4i1qB+SCXEYvMU1t+EMsM0bXAfC2dqLCK4Hubl5YAHKuWz7XZrZwESzd
 KdE7FMTNBCO52IPsP+3JslbEDDqktXq6Laxf1mW8YZCr2mEft12uORHZl3I2ZP5T
 IzVZpNJKDxMf1+aLWaMbULYXQpLZsfhfCZokQdkiQFZW5G4quuqZgDW7STL0fDjE
 u5pgVoeaWHhg03jaV59H69YviEzgEs7AvppX+fFTO85ux8pZDgKSJ/eyInjj1qPJ
 6M7XQQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h92jjrtfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:38:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso4900752eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791830328; x=1792435128;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bgRYUW+Bei3Q21MTzmcxk2sT/AX/LHG8dFab1oytdc4=;
 b=WECPmXpLzLJoGLVXttjYVMECJ68rQ9KX7AEdk5hzLpbcjAng3pFfXDZhTCfjzMFA29
 wPqdUVhGy/uoB9GYiGQB7GXL1x4xRfN/QUcHBPr0vjs3a5NA/Y/sBGkJOaclp9p3srYH
 1jOjxJGkX6Yhgi4xqiW0GjYcG2LsgQMzf12Beoh7pD0j5nkFswq6gBCAYv6IQtWT/lTh
 3ph5SqpiSBS3Kd8CslnPvwgT1aP3BKUe0FOgHIPwZJlPbKzD1FMerFU3shYRU+4lzlnT
 l7ZsPs0tCKmne5PmVbZADFLR23XITQK3jAeNy3rbggEWHuDp+2A7LicFXfzSAvb4wABJ
 MHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791830328; x=1792435128;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgRYUW+Bei3Q21MTzmcxk2sT/AX/LHG8dFab1oytdc4=;
 b=Z2+NUAwiAA9G7lKZ8FTlsqe+si06LRQuJs4KvY1Fhusqi7D4mfNmzORyTSv4+VvHPG
 5cUpZzw/yLW8rTzCB3tDBh0Tc/gFGs9/CIjDpDAe+JMawZaFLtmgA7DLaeRDRoNl7bQL
 EdsE39lrYO+WjVTy2Nm8bMJRyMChVf4hg+8T8uGlytt7E/+SEHuxR9r99dyUlI7+9VTp
 IHqn7ybERBRy3PqTAkWef9PrHmbjCb+hYFI3BcM7KPCdXfFj289ZkI65ybfG+7V6Okrn
 wcV8NIkKAZym4KcVu06Pu4t+i0iIbvAra1s6efeAhb3yOJ/kF3kbzpJy2+GFW43OwGng
 6VLg==
X-Forwarded-Encrypted: i=1;
 AKwUvByvsYcLT7kG8cQlmG7BPe33+Hmc7SEnhyVD6OfMFAuTtBW2rQ1T9r4WbYibJBRGi7z9LzgDCwlcj2U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLg/b0m/pff67X1xgvUlfZAWHbcL37h5iq+m+MK8FpuorbJdE2z
 L5uMUNmsplumfyQD+zK57ilNDmXqpT8OSyT/B89wS89Rk6EM7QLHbO/k5qyblvgIZt9Ob0hst+R
 +7RZBQ78RSYen8gO61G00Q3u5ZwlbE72PyqVGTzJ3SMB4Mr7abtUaayrKKAKJWsCUxZ3DC+U=
X-Gm-Gg: AYBFou0cdtsJjSb368O7BqUUjfDiy2trq4nq+x4LXVaEoqS5N/Ja1CZfo8fYQ8PMXl7
 Pb5mNTuJILf+N9ASb0nz4td3SSBWvsLzf2lHk2qERkX2S8n4z4qrF3AeUK8O7/TyzDMSZeOeK2r
 88Xy7YcEReugvxzEUKLG1e7vZvFciraLVlh6+KLPIzqDsUnCimZ/6vLRUu2PH6xJ6PBe9WcL4R7
 w+MmG+bmP6/ivBaDcayO9yIWWOsWu86cJV3S4svIT9NZcr0ubfC2i/f/+NEgEhzoAV+wKCD9Eof
 IggT54GQCQBVSljERInJxw71nxcijXQypfkYIVqlgYgyJOnomCNuQ3juzrSjGsYwR5Yr4HV9oRp
 pc4VYztcENvs1tgWr5UxD6OZaz2UL6A==
X-Received: by 2002:a05:701b:450a:10b0:151:bbe4:b6ab with SMTP id
 a92af1059eb24-16a5ed3d9bcmr13695566c88.17.1791830328115; 
 Mon, 12 Oct 2026 11:38:48 -0700 (PDT)
X-Received: by 2002:a05:701b:450a:10b0:151:bbe4:b6ab with SMTP id
 a92af1059eb24-16a5ed3d9bcmr13695537c88.17.1791830327520; 
 Mon, 12 Oct 2026 11:38:47 -0700 (PDT)
Received: from [192.168.29.225] ([49.37.144.177])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3581f594a41sm26956693eec.23.2026.10.12.11.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 11:38:46 -0700 (PDT)
Message-ID: <a91f5f24-7371-4d65-8409-e9fa9a4eb2cb@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 00:08:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/msm/dpu: check mode against PINGPONG or DSC
 max width
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261008-lm_fixes_final-v4-0-fa986071c3c1@oss.qualcomm.com>
 <20261008-lm_fixes_final-v4-3-fa986071c3c1@oss.qualcomm.com>
 <2mut637ssnnyf7spywezdkx5fpoc4virkr3zuqzj3klwd3ijfr@xk46zya3hgak>
Content-Language: en-US
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
In-Reply-To: <2mut637ssnnyf7spywezdkx5fpoc4virkr3zuqzj3klwd3ijfr@xk46zya3hgak>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vmtpPizLGL0WIK0naI_RW0Zh68izTxLT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3NCBTYWx0ZWRfX3lStiSXyGe6f
 ugDKI6hdyuHes2UHy+If6aL84QQTPVZN7zNfrGIpvnUxig0bZIxuh2ilfMFZAaUU+PUQfoIl7PY
 A6eI/oMJqFsIXP/q6+ccP3pTn2fI4js=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3NCBTYWx0ZWRfX0ENpQwH38H+V
 VpF9eErKYWhuE9I/7wysLumzNzIaMyeYYLXC83sESc6oCHqv2hY7yt+PMOZKrdq35r5tZvc6vnY
 FQkDopKeUb0Dk1cg/UiLhCHB+bysOHbi8iuiDzUvSibQrgWgBR2GavHuLwHIruktn3cTNTtVBt6
 9/m/pzlvfxf6hdKeZbKDxITL5TCu1cZkXtUrzcEWQUyZN+XeuihF+Y7CSERjv9LhFkKOkK9nW7a
 NjXIfRXuAOfSe/q9U1U9Sq69Woon97Za3LCjBRPyC/5uShUu3GPZuONgicqc2Zh6uqpyfGQX9dA
 zG1LQVOwlZgEPfeqcWxHHAeuDf3SDVFYdF4SOthXlLE+/ksLs+/hON2IuxV5jL+y0DCEvy2IHzF
 DiEre6mfknjfr0GBRe0ui2mxGEeAKyV7aDLWYG9io4MeHSlTOclA8k9Zrp0Xu/6ldx/76muzuvu
 qhn8U1PfqnQvfcigsUQ==
X-Authority-Analysis: v=2.4 cv=GfKCDgXL c=1 sm=1 tr=0 ts=6acd2939 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=20alU+YIu2uqf8Hyrg49Cw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ksxQWNrZAAAA:8 a=k6m01o0hih_xGdVfLsEA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: vmtpPizLGL0WIK0naI_RW0Zh68izTxLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120074
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


On 10/12/2026 5:44 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 08, 2026 at 10:53:49PM +0530, Mahadevan P wrote:
>> From: Jessica Zhang <jesszhan0024@gmail.com>
>>
>> LM block doesn't have a hardware buffer (unlike PINGPONG and DSC
>> encoders). As such, don't use ephemeral max_mixer_width and
>> MAX_HDISPLAY_SPLIT to validate requested modes. Instead use PP and DSC
>> buffer widths.
>>
>> While on the DPU 8.x+ supports a max linewidth of 8960 for PINGPONG_0,
>> there is some additional logic that needs to be added to the resource
>> manager to specifically try and reserve PINGPONG_0 for modes that are
>> greater than 5k.
>>
>> The layer-mixer count for a merge-capable, non-DSC mode is chosen by
>> dpu_crtc_num_lm_for_mode(); feed the PINGPONG/DSC derived width to it as
>> the split threshold in place of the removed MAX_HDISPLAY_SPLIT, so the
>> pixel-rate floor added earlier keeps high-refresh modes that now fit
>> within a single PINGPONG buffer split across two mixers.
>>
>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>> Tested-by: Xilin Wu <sophon@radxa.com> # qcs6490-radxa-dragon-q6a
>> [DB: reworked to drop catalog changes, updated commit message]
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> [MP: rebased on msm-next; fed PINGPONG/DSC width into
>>   dpu_crtc_num_lm_for_mode() instead of open-coding the width test]
>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       | 54 +++++++++++++++++++++-----
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  7 ++++
>>   2 files changed, 51 insertions(+), 10 deletions(-)
>>
>> @@ -765,13 +781,14 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
>>   	struct drm_display_mode *adj_mode = &state->adjusted_mode;
>>   	u32 crtc_split_width = adj_mode->hdisplay / cstate->num_mixers;
>>   	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
>> +	int max_pingpong_width = msm_display_get_max_pingpong_width(dpu_kms);
>>   	int i;
>>   
>>   	/* if we cannot merge 2 LMs (no 3d mux) better to fail earlier
>>   	 * before even checking the width after the split
>>   	 */
>>   	if (!dpu_kms->catalog->caps->has_3d_merge &&
>> -	    adj_mode->hdisplay > dpu_kms->catalog->caps->max_mixer_width)
>> +	    adj_mode->hdisplay > max_pingpong_width)
>>   		return -E2BIG;
> I guess Sashiko is correct here, we need to check DSC width.
Agreed, the PINGPONG bounds check alone does not enforce the DSC encoder 
width. The next revision validates the width per selected DSC encoder 
before resource reservation.
>
>>   
>>   	for (i = 0; i < cstate->num_mixers; i++) {
>> @@ -783,7 +800,7 @@ static int _dpu_crtc_check_and_setup_lm_bounds(struct drm_crtc *crtc,
>>   
>>   		trace_dpu_crtc_setup_lm_bounds(DRMID(crtc), i, r);
>>   
>> -		if (drm_rect_width(r) > dpu_kms->catalog->caps->max_mixer_width)
>> +		if (drm_rect_width(r) > max_pingpong_width)
>>   			return -E2BIG;
>>   	}
>>   
>> @@ -1374,17 +1391,17 @@ static int dpu_crtc_reassign_planes(struct drm_crtc *crtc, struct drm_crtc_state
>>   }
>>   
>>   #define MAX_CHANNELS_PER_CRTC PIPES_PER_PLANE
>> -#define MAX_HDISPLAY_SPLIT 1080
>>   
>>   static u32 dpu_crtc_num_lm_for_mode(struct dpu_kms *dpu_kms,
>> -				    const struct drm_display_mode *mode)
>> +				    const struct drm_display_mode *mode,
>> +				    u32 max_hdisplay_split)
>>   {
>>   	u64 mode_clk;
>>   
>>   	if (!dpu_kms->catalog->caps->has_3d_merge)
>>   		return 1;
>>   
>> -	if (mode->hdisplay > MAX_HDISPLAY_SPLIT)
>> +	if (mode->hdisplay > max_hdisplay_split)
>>   		return 2;
>>   
>>   	mode_clk = dpu_core_perf_adjusted_mode_clk(mode->clock,
>> @@ -1403,6 +1420,7 @@ static struct msm_display_topology dpu_crtc_get_topology(
>>   	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>>   	struct msm_display_topology topology = {0};
>>   	struct drm_encoder *drm_enc;
>> +	u32 max_hdisplay_split;
>>   
>>   	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask)
>>   		dpu_encoder_update_topology(drm_enc, &topology, crtc_state->state,
>> @@ -1410,6 +1428,19 @@ static struct msm_display_topology dpu_crtc_get_topology(
>>   
>>   	topology.cwb_enabled = drm_crtc_in_clone_mode(crtc_state);
>>   
>> +	max_hdisplay_split = msm_display_get_max_pingpong_width(dpu_kms);
>> +
>> +	if (topology.num_dsc > 0) {
>> +		u32 max_dsc_encoder_width;
>> +
>> +		if (dpu_kms->catalog->mdss_ver->core_major_ver < 6)
>> +			max_dsc_encoder_width = DPU_1_x_MAX_DSC_ENCODER_WIDTH;
>> +		else
>> +			max_dsc_encoder_width = DPU_8_x_MAX_DSC_ENCODER_WIDTH;
>> +
>> +		max_hdisplay_split = min(max_hdisplay_split, max_dsc_encoder_width);
> Should this be min() rather than max()?
The code already uses min() here, as the width must fit both the 
PINGPONG and DSC encoder limits. If the variable name is unclear, I can 
rename it to "single_lm_width".
>
>> +	}
>> +
>>   	/*
>>   	 * Datapath topology selection
>>   	 *
Thanks,
Mahadevan
