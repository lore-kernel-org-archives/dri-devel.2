Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB289CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B5E10EFE6;
	Wed, 20 May 2026 10:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dur7BtJP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TwhmTVsL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BF310EFDA
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:16:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K774sO2984398
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PLPdSyncFsO6G0/UzGd9/9d7L2FVL/Q63pbwujX07LQ=; b=dur7BtJP0OnsCBQV
 ABJAhPsQeOX7Obe09IL9Jo0WhgLzM0qWkzyKcUixEcY2w1NUHYH4HxBrg0WRwoL8
 /ci9nWX0JIofgzK570Lb/2S/V58DVgYqL+uf5ucSca/sfKICHXnvKOYKLi/k4Y17
 iLWcxWevX41R29IgZ2ui/SxcNc5w83w31hp4twpWUlsMR/ZpVK6uZC2Vlv61ePXr
 gNf1hf15GOoX5j++hOlQhA0HeTM+pAKATV8jQLTkXFLqXSJ72UJFsqmcNXczTDoY
 AzcU0JHdqwW7fEYz2IzhSZf5LIH7ZIiyLi3PAp2OfIQmF1wphFrd2q84/WXGeSPQ
 PMEQOQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t4ac1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:16:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-367cb6de61aso8188396a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 03:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779272172; x=1779876972;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PLPdSyncFsO6G0/UzGd9/9d7L2FVL/Q63pbwujX07LQ=;
 b=TwhmTVsLrK4hZwC//uK6emUzBsmtuTgek/DQ3y1bDGbIArXOC/XPD45ajtrkg/b0s+
 XTjhYEO3xPNqpqbGAwEkytHJC63T+STrXpm3V5WLitmv8oJxv4z1kZK691s9ydk1Du0P
 Z7GAWww4/03YJJmuoIijRgTYQGF+SIjpjyulN8Jbu49o83mGARHxZD8b0ukGYml5Jfmm
 XWznXVh5oQAzuS/cBceaPTLkNhKXzC2wYnVoXAWG81iC8BO5JBSrWM11ISxm0RCe4V+Y
 7bgJdVtbT8H7sJn8UDdGCr5BsjxzsrdKm8KgbLXhxb6XKQxliQ/ByfOryihxqmEcFemG
 pg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779272172; x=1779876972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PLPdSyncFsO6G0/UzGd9/9d7L2FVL/Q63pbwujX07LQ=;
 b=JPa0OjptAvgWvhqQbbWTFFZt5YD6/EIVRDVbl3YCkhPbD45yIHQiyIQkeDPo3trY+r
 kxS+60E6NeGnrxhiMLNbKix4GeGV/HYfKBIByYjvsVm3aVE+1vaOtxQj73QobXE7XwAm
 W03jJ1VrGaeWNh/qugGCYuzbvQhNPCUoLtepmwSKeQOlhXmaJgh5fJOWfiHpjMZd/fi0
 xG8wyzugeDOYJEfppN4AJ/pFb62U/fKyfiHjn+1WP5LGx3YQVyZXmDVXe2XY9CRvHBP9
 VsQ3RmLphQFquVw1r5gjQjtJmiWyulkwq8iLp9lQMT2gDXwbpJ1XhVQT/fOFRmmYkpQf
 AbeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IGMUfCPU7x08akod0uzGIjcqttTa8yYKRgMvU38pAwf/GMLUOXZDdNyCehLxMZdBzOA1fHNv5vjI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDXWiE6wMPWcG0Ty6y9+VDT9lptvA9QJqhd2oXRwIx8DJZRWwS
 OWGb5ZBa0Db8Biv5AVoXOuMe+RsSjIyG0uuhHMcKRDCIlM1xG1VFq5VgNYBvsVppoGm0fNkSap8
 GevxRkocCf/3gongw6dtkgFfZ795mYbp9oxhqokpArFA79pvyl3+h9l4r/WVKP314EinutEk=
X-Gm-Gg: Acq92OErW5SDSVFZw1vl9niLP1ZljL4gszNskoCoJpecsEPUK3Xmrxq8dTF6SQKKmnC
 3utDjcsBUpCGcsrK/By+kwH7XILeaeZFCTzkSFmyIFIclm8s35Ge9KuvGs/1A06PxiHj7orgFfR
 iBPog+SrKj1Uk9A3uRa1gbT5KJeA000LuPe6Hv7Jy7Zg3HbB83i1JT0p7rEhx6UCX5G2tt4CmSM
 CxqZgjzOZtbIeG8mzSj3qPFTNyHto2nPHFMvLOk8noxQ38HplpUTZkzS4+DEm7X2CtgZdL98Pqy
 n6BfEgn9EG2r4XGF/cMevgrmXCU+nc7wGKRWbtIZbWjG6Rb8YWiCoiLQXRwB3lFsnz45OQox0r7
 Q4AJ1gwBxwxY3wX5c2dLi+5IphqHxcS2S/zrhMG33lzcW6/bO8Y2f/iCfj9yxGbUB8fsVLmeqd2
 RbHR35zkDwLDI+DZ6qRg==
X-Received: by 2002:a17:90b:5290:b0:368:a297:bd38 with SMTP id
 98e67ed59e1d1-36951a044b5mr22745961a91.7.1779272171935; 
 Wed, 20 May 2026 03:16:11 -0700 (PDT)
X-Received: by 2002:a17:90b:5290:b0:368:a297:bd38 with SMTP id
 98e67ed59e1d1-36951a044b5mr22745868a91.7.1779272170556; 
 Wed, 20 May 2026 03:16:10 -0700 (PDT)
Received: from [10.133.33.114] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36968dae27bsm15108021a91.1.2026.05.20.03.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:16:10 -0700 (PDT)
Message-ID: <c1eb178a-4cde-4a4a-bfd9-e3b0ce4b52da@oss.qualcomm.com>
Date: Wed, 20 May 2026 18:16:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/39] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-5-b20518dea8de@oss.qualcomm.com>
 <omw63f7fbqiuw2t266dq5drk7rz2kohydpvbbhcrbfiehb7lzh@aucqhfaliams>
 <57f574d3-7000-42c8-a5b7-88f1a73efd50@oss.qualcomm.com>
 <etjni6nlx5a6xd4oqb6ow5ihxdl5zcdtcofmo74pbdt7lilnxd@q2zqgiqycjt3>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <etjni6nlx5a6xd4oqb6ow5ihxdl5zcdtcofmo74pbdt7lilnxd@q2zqgiqycjt3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BOCDalQG c=1 sm=1 tr=0 ts=6a0d89ec cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0cozv7LJkoRnZ4qxxmgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: x7ojwlctzCj6eOTzHQV_7TiEWHPuQKlT
X-Proofpoint-GUID: x7ojwlctzCj6eOTzHQV_7TiEWHPuQKlT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5OCBTYWx0ZWRfXywueSKokN/ZG
 OkihNulUlXQn6/rASVySc+l1yRE/4L7LLIJqmMkd1BoXCpTdY3brFYLLhiKI6a5PkCJ1RDdM89k
 aowe0Odo0QngCe+vaOvu0/Aoy4FLgBvM6nkU+7iyzl/g0N/Ord7nFWLHw0lD5ZA6W7puQCyYUzY
 hkIcYFaDkcUzUuJ+920/0Fem3UGb/JiqVwZ4R4KzGpkbttXfqj4M6DRP80M6aCXjZiJKRyWySZ4
 7d1Pd0Wy6O0miSdFEcScYX6ZpAwtMP86MyhUX0pKjw0b6WmDCVevqvW0mvr5UJeU1s32SNayMMW
 H85qjzoKW8rqUk1+IBOdar0q5YnMjAEy6+RDujRlnizVH+NmAN6nNM99NATbzd0fO9E3ddMUqQv
 UCvxqqjl11vW5rtYFFQp6uzDktfb0HUDm4D7we6m/baSORxIPeTrKaeb6c/uDgVHZ0cVbPrQw3c
 ep+w1+ubabPQ0JKV+1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200098
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



On 5/20/2026 5:23 PM, Dmitry Baryshkov wrote:
> On Tue, May 19, 2026 at 03:46:36PM +0800, Yongxing Mou wrote:
>>
>>
>> On 4/12/2026 1:34 AM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 10, 2026 at 05:33:40PM +0800, Yongxing Mou wrote:
>>>> The DP_CONFIGURATION_CTRL register contains both link-level and
>>>> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
>>>> all of them together. Separates the configuration into link parts and
>>>> streams part for support MST.
>>>>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/dp/dp_ctrl.c | 43 ++++++++++++++++++++++++++--------------
>>>>    1 file changed, 28 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> index 476346e3ac19..85315467b5d0 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> @@ -388,26 +388,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>>>>    	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
>>>>    }
>>>> -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
>>>> +static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>>>> +					    struct msm_dp_panel *msm_dp_panel)
>>>>    {
>>>>    	u32 config = 0, tbd;
>>>> +
>>>> +	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
>>>> +
>>>> +	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>>>> +		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
>>>> +
>>>> +	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
>>>> +					      msm_dp_panel->msm_dp_mode.bpp);
>>>> +
>>>> +	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
>>>> +
>>>> +	if (msm_dp_panel->psr_cap.version)
>>>> +		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
>>>> +
>>>> +	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
>>>> +
>>>> +	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>>>
>>> You have an RMW cycle here. Please document what prevents it from racing
>>> with the concurrent msm_dp_ctrl_config_ctrl_link().
>>>
>> Here protected by mst_lock in MST case. Will add a comment.
> 
> And in SST case?
>
Emm, do you think this comments fine?

   /*
    * RMW: in SST, config_ctrl_link and config_ctrl_streams are called
    * sequentially on the same thread. In MST, caller holds mst_lock.
    */

>>>> +}
>>>> +
>>>> +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
>>>> +{
>>>> +	u32 config = 0;
>>>>    	const u8 *dpcd = ctrl->panel->dpcd;
>>>>    	/* Default-> LSCLK DIV: 1/4 LCLK  */
>>>>    	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
>>>> -	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
>>>> -		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
>>>> -
>>>>    	/* Scrambler reset enable */
>>>>    	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
>>>>    		config |= DP_CONFIGURATION_CTRL_ASSR;
>>>> -	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
>>>> -			ctrl->panel->msm_dp_mode.bpp);
>>>> -
>>>> -	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
>>>> -
>>>>    	/* Num of Lanes */
>>>>    	config |= ((ctrl->link->link_params.num_lanes - 1)
>>>>    			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
>>>> @@ -421,10 +436,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
>>>>    	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
>>>>    	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
>>>> -	if (ctrl->panel->psr_cap.version)
>>>> -		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
>>>> -
>>>> -	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
>>>> +	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
>>>>    	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>>>>    }
>>>> @@ -450,7 +462,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
>>>>    	msm_dp_ctrl_lane_mapping(ctrl);
>>>>    	msm_dp_setup_peripheral_flush(ctrl);
>>>> -	msm_dp_ctrl_config_ctrl(ctrl);
>>>> +	msm_dp_ctrl_config_ctrl_link(ctrl);
>>>> +	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
>>>>    	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
>>>>    	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
>>>> @@ -1628,7 +1641,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>>>>    	u8 assr;
>>>>    	struct msm_dp_link_info link_info = {0};
>>>> -	msm_dp_ctrl_config_ctrl(ctrl);
>>>> +	msm_dp_ctrl_config_ctrl_link(ctrl);
>>>>    	link_info.num_lanes = ctrl->link->link_params.num_lanes;
>>>>    	link_info.rate = ctrl->link->link_params.rate;
>>>>
>>>> -- 
>>>> 2.43.0
>>>>
>>>
>>
> 

