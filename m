Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28049D35145
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAF810EC82;
	Wed,  1 Apr 2026 06:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBkCHVyg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZGmmtLp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280FF10ED5B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:44:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6314RRiX3363375
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 06:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1P1UOfcVLyvox+YXpvYwZ0Xngo6w6eE5QVv1oIyIdFE=; b=GBkCHVygRqHblJTM
 b1qGLRcGbg2fOyeRZrpIrWDnOidkpVwVHZcEVOCPjsse4L2Z/BJxKrZXXuY3TIb2
 PeDpXRVLKyzUFQk/T5Zq6s6lGhL9uMiNZ1Rvfb22LCEc4Lkc5F/j1LX+mEAmeafs
 gWdUnF0UufXGQOYU/ADl+NWH1eDtj4LuPVEeWVOXRDlxxCJT8PJYsEPP7PTNWlUO
 JLK4zqTFTpm5d9H12lvd/vKXa46NMe7shAPXR+Q3xtkfRV21pUlmAuenFI5/y1l2
 /Gd84FkWd9mJnqeHLTzQ/CyfPLJ6rL11/qHwKV6hkXQdX+go8HW/4DEnqMjlAtKv
 84HvIQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddj13x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:44:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35da86144daso3323976a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 23:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775025853; x=1775630653;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1P1UOfcVLyvox+YXpvYwZ0Xngo6w6eE5QVv1oIyIdFE=;
 b=aZGmmtLpu5xnTqkl5Tar4MhNcO3cXu1jgFdU+l3OhVNNFGqqsRcKp+545ZtA4ZIBIu
 6hemFX2YAxH3KUuJ4Jg/Fqt2BHB5fcSvI2rNCevD9EWqv1kaGv7LHAcVBG41MwGz7abD
 tXepsjahVxzBdPhczP375OdiPO9cOXjy/nY5WZ5Sf3h8CDfXk/+AC7IKYWlWJ3XOyQlq
 w3oyU2pHkZ0Ram+Rlz1xVeioyRsmN2wj1+g3RAZ13VW7JwPv7YbhU9Jrx6HDJFZaUmpC
 MxfiYnQfvAu2fO0T3fE9/DW/itSQo4pm2vsUntWawK+iXZSPgdZhRtVyqiqFxCCcBB0K
 7BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775025853; x=1775630653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1P1UOfcVLyvox+YXpvYwZ0Xngo6w6eE5QVv1oIyIdFE=;
 b=tEExpbIfbnJsKQ+RnxYAVDuIhJLqITi4V8B+F38gUaML/FPkfwq0rD1hyEpCuYHrrs
 snKUOm7mI5CSekxSuygLHTqzs/4TyjN8JCUm3Cf2dyGlHoIMsPNSIcEDf1rJhtKSD+sw
 iJwlT+NQqTprmpDfNHags5/tpaLjh1imksvkGtPQKvgJpFoGVEMcCoEVdRc89YPLxU+n
 daZtoV2+XshT2xdm0kZQco9xftkvxTOqsrXP8qoSjTzPTdsZOqL6HvRIf9X3opGS+76z
 wweUTtSOxMGE5ax1PQI/2CBC0eZ4dxOpzFsF4VW/6DOIm+ZLcfseG9BPsB36zPtk+X21
 I64w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq1xEmnb9lsXg3SHAmloAUOAozd7POrcEu9W1ltFlETj7bCSIO9E9jYjOI8QBj6LA5O3vLkR8aa2U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzY27Au+RUXqeJuM5gq874Jf+4EbwV/b0B/JH4ztXBeflVHttpv
 QIcN3aFkIfxlwELggyAfXvxawTd9DTYmj757tL/oj9vOUauMTwiJ9bRkDQmsAA9dFo0RrJfHFlU
 Zxf4ODAkvGC6ZRFhhWLpUrJx96VwiLkf4UWi4JnVdrEeYFnmBQiE4F7+PR0vaNecg8KXQ6eQ=
X-Gm-Gg: ATEYQzyTTN2yj6IMlwv85sY8xy47YK/FU0oU7QlzjdBOyNugSdxYkEVjX9kKKMn7HPQ
 dRJjFrwtJIYv2jY+EZDGOjNK/xrPVH9hWvpTy2+I4Fdzq7kRmieOIDW6zlU3iZJ3a0GvJtGVPsO
 BOwE+baRMqos6BdXK9F3S1islflVDy96eVALX3W5JkJQj3oy1y4gSUB4oLBxGt2mgjd9rEK2Zlw
 OxVs/8GvUJ54mZ1K1UL7eYbA9qCsH+UUlDNgNGkBHNnfUxEdsXlmBFEQPqV4OTT9Ok63qcZZvN+
 W7zmDrt2FVceDEB60/HNM+NgFrswnsb6UA5FIYminPsVFttJh0OAe1XI0mCqw36DVvniDFGQwWd
 Td8QyfPbbqnb7rezIeXFt2hQKX+1tR0Vtil1S/j/WTfKNGuj1cMxxlpXRttDUgTkqfhAIJqlpCG
 jaqI2lzRARK9zg7U+g2Q==
X-Received: by 2002:a05:6a21:3397:b0:39b:e115:f690 with SMTP id
 adf61e73a8af0-39ef7712ed9mr2507003637.42.1775025853074; 
 Tue, 31 Mar 2026 23:44:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:3397:b0:39b:e115:f690 with SMTP id
 adf61e73a8af0-39ef7712ed9mr2506951637.42.1775025852464; 
 Tue, 31 Mar 2026 23:44:12 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c769179e3d3sm10917954a12.15.2026.03.31.23.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 23:44:12 -0700 (PDT)
Message-ID: <46d97aec-9f46-42bd-8725-2c236ffd13ba@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 14:44:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/38] drm/msm/dp: add support to send ACT packets for
 MST
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
 <20250825-msm-dp-mst-v3-17-01faacfcdedd@oss.qualcomm.com>
 <mtli7kelybfot6ai3lqjagy6hahnpkimqjnjbk26shaoekqoht@cbycvfsmry4o>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <mtli7kelybfot6ai3lqjagy6hahnpkimqjnjbk26shaoekqoht@cbycvfsmry4o>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69ccbebe cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=aNidHKw51tL1cJfPzJcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aVIQfbBJQMndjV3M47N5wOLP6zjntVo5
X-Proofpoint-ORIG-GUID: aVIQfbBJQMndjV3M47N5wOLP6zjntVo5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1NyBTYWx0ZWRfX8HWKrD5+cAQ9
 D03mFEbWPX3S//i+uCoh6ToHt/EeEv3kQtD6Yh+F8MDrGBo/UG3yY8e8I4+gfxKJ84beYdi6BjG
 rC2dXsFUPTR+ISGo5JU1OryspH2nMThCznwua4mzkHLKhbxGLbK9KxWnQtWsQWGJ1yoxsNWc9Tv
 uUm2pssMy819IGwLl14BJ8TX5ofSfujFXf7Z6U+pjAa8uSGz19x34JJ0mmnZ7IczkEKSnuYOV6X
 Dx0SPgMt4rcESjWAoSOAAQHNzyXndJ6+b0xefWIqqsnVWAXdV7K383ozztHS+3cPIBG9yyN2TiJ
 XqcAM8Yjvrycglt37UDpUXmL5UaZzjWQ/xkkxkYfv6BCnpNiqTLorv4gBWDf7OTHA45HTOQTxzS
 3amjNkHW0VwTSWWEwkvKAdv6hrljAY884goYSMlEupDgwVSMLoxr9nVrrIT6FUnZRq4PD5GZVNY
 wATzOr8aoH5ReKFP5FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010057
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



On 8/26/2025 5:10 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:03PM +0800, Yongxing Mou wrote:
>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> Whenever virtual channel slot allocation changes, the DP
>> source must send the action control trigger sequence to notify
>> the sink about the same. This would be applicable during the
>> start and stop of the pixel stream. Add the infrastructure
>> to be able to send ACT packets for the DP controller when
>> operating in MST mode.
>>
>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 39 +++++++++++++++++++++++++++++++++++--
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
>>   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>>   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>>   5 files changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 608a1a077301b2ef3c77c271d873bb4364abe779..16e5ed58e791971d5dca3077cbb77bfcc186505a 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>>   	bool core_clks_on;
>>   	bool link_clks_on;
>>   	bool stream_clks_on[DP_STREAM_MAX];
>> +	bool mst_active;
>>   };
>>   
>>   static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
>> @@ -227,6 +228,32 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
>>   	return 0;
>>   }
>>   
>> +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
>> +{
>> +	struct msm_dp_ctrl_private *ctrl;
>> +	bool act_complete;
>> +
>> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
>> +
>> +	if (!ctrl->mst_active)
>> +		return;
>> +
>> +	msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
>> +	/* make sure ACT signal is performed */
>> +	wmb();
>> +
>> +	msleep(20); /* needs 1 frame time */
>> +
>> +	act_complete = msm_dp_read_link(ctrl, REG_DP_MST_ACT);
>> +
>> +	if (!act_complete)
>> +		drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete SUCCESS\n");
>> +	else
>> +		drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete failed\n");
> 
> Shouldn't it return an error if the register dind't latch? Also,
> shouldn't we set mst_active only if the write went through?
> 
In some cases, MST still works correctly even when the ACT trigger 
fails; here refer to the downstream implementation.
>> +
>> +	return;
>> +}
>> +
>>   /*
>>    * NOTE: resetting DP controller will also clear any pending HPD related interrupts
>>    */
>> @@ -2079,6 +2106,8 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>>   
>>   	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>>   
>> +	msm_dp_ctrl_mst_send_act(&ctrl->msm_dp_ctrl);
>> +
>>   	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>>   end:
>>   	return ret;
>> @@ -2275,7 +2304,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>>   	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
>>   	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
>>   
>> -	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
>> +	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, false);
>>   	if (ret) {
>>   		DRM_ERROR("failed to enable DP link controller\n");
>>   		return ret;
>> @@ -2355,7 +2384,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
>>   	return drm_dp_channel_eq_ok(link_status, num_lanes);
>>   }
>>   
>> -int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>> +int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active)
>>   {
>>   	int rc = 0;
>>   	struct msm_dp_ctrl_private *ctrl;
>> @@ -2373,6 +2402,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>>   
>>   	rate = ctrl->panel->link_info.rate;
>>   	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
>> +	ctrl->mst_active = mst_active;
>>   
>>   	msm_dp_ctrl_core_clk_enable(&ctrl->msm_dp_ctrl);
>>   
>> @@ -2643,6 +2673,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>>   
>>   	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>>   
>> +	msm_dp_ctrl_mst_send_act(msm_dp_ctrl);
>> +
>>   	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>>   	if (ret)
>>   		return ret;
>> @@ -2682,6 +2714,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
>>   
>>   	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
>>   
>> +	ctrl->mst_active = false;
>> +
>>   	dev_pm_opp_set_rate(ctrl->dev, 0);
>>   	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
>>   
>> @@ -2849,6 +2883,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
>>   	ctrl->link_base = link_base;
>>   	ctrl->mst2link_base = mst2link_base;
>>   	ctrl->mst3link_base = mst3link_base;
>> +	ctrl->mst_active = false;
>>   
>>   	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl, max_stream);
>>   	if (ret) {
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> index 2baf7a1ff44dd7139d2da86390121d5e7a063e9a..abf84ddf463638900684f2511549a593783d2247 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
>> @@ -16,7 +16,7 @@ struct msm_dp_ctrl {
>>   
>>   struct phy;
>>   
>> -int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
>> +int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active);
>>   int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>>   int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>>   void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
>> @@ -50,5 +50,5 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>>   void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>>   
>>   void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
>> -
>> +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl);
>>   #endif /* _DP_CTRL_H_ */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 562a5eccf3f08c5669cc7c2ad1268897e975d0c4..eeba73f81c5ce7929dac88f4b47ac3741659864b 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -709,7 +709,7 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>>   		force_link_train = true;
>>   	}
>>   
>> -	rc = msm_dp_ctrl_on_link(dp->ctrl);
>> +	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
>>   	if (rc) {
>>   		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>>   		msm_dp_display->connector->state->link_status = DRM_LINK_STATUS_BAD;
>> @@ -1557,6 +1557,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
>>   	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>>   
>>   	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
>> +	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
>>   }
>>   
>>   static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
>> index a839d0a3941eac3e277185e42fddea15ca05a17f..9442157bca9d63467b4c43fa644651ad2cbcbef5 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
>> @@ -21,6 +21,7 @@ struct msm_dp {
>>   	bool audio_enabled;
>>   	bool power_on;
>>   	bool prepared;
>> +	bool mst_active;
>>   	unsigned int connector_type;
>>   	bool is_edp;
>>   	bool internal_hpd;
>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>> index a806d397ff9d9ad3830b1f539614bffcc955a786..de3d0b8b52c269fd7575edf3f4096a4284ad0b8d 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>> @@ -158,6 +158,8 @@
>>   #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)
>>   #define DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT	(0x0D)
>>   
>> +#define REG_DP_MST_ACT				(0x00000500)
>> +
>>   #define REG_DP_SOFTWARE_MVID			(0x00000010)
>>   #define REG_DP_SOFTWARE_NVID			(0x00000018)
>>   #define REG_DP_TOTAL_HOR_VER			(0x0000001C)
>>
>> -- 
>> 2.34.1
>>
> 

