Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB66D35140
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 06:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF5B810EC2F;
	Wed,  1 Apr 2026 06:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="e5hHg7qE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UZvs0Ih7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850C410E240
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:41:00 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6312ULLI718636
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 06:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rzTAady7xf/9UKre2SGj4SnZ2Yd+FVnY2u9zy40iksI=; b=e5hHg7qEt1Qck8Df
 bA0oasMBGuJDJiJdzk6tCYGo/uSbiEaFjlmyLjmne9OSZC02OW0KySxNGdRTkKwZ
 6VMWfp2oZnwiB5EPR0hAydnxtuwxx5drfghe3PZcLXnSj1iZqDnStJxO/6lzPnKZ
 NB+O46txLIHiwLKE3wWGtrePXN6E1p8TjHgNzmhzPnngGi/x95VIuz59+Yc+J7gm
 kjJqob0DH6eUs6jhRD/YlV8sxpLCSbTK+Gctp3g9rBinga8KK5XNPGzYemftMv5Z
 4hEdV8oWNHCUcV+avC1+LEu0HsnAOlYjEGcwy7tJAfRIEHhTpxrV13B7ZilxYov/
 WhZ91Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcstmjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 06:40:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35d99c2908cso4322344a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775025658; x=1775630458;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rzTAady7xf/9UKre2SGj4SnZ2Yd+FVnY2u9zy40iksI=;
 b=UZvs0Ih7rctacS/kcvbWUWH0xztym9Devn7PGGS1FuAeo2o5n9Gm5S1lPC4CvHTM7X
 p5G0yK6rrS2Vqj5yYJBfvbJaAXCIRbfHT5VL2eg6lhA2aTh+mLqn72EII6+gWSx7Dt/E
 p0JOp+FJGHVUr6c50bbQCZzsXt1RDtagbSjtuaYibsDqn6fPOKg9hyL4c7A71Wqwl0Ab
 lWtjyTTG/1eVTXStMN8xScK9kruMpPxGmVgIfy5KDCkzvR2UqXG4U2Y3CwlW8piPgm+z
 61qOzx62L7+bsL+i86RA0jO/AeVBiH+lKIP1+ThM6qy+uGNLyujZ/B5y/97fdO154pKe
 nkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775025658; x=1775630458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rzTAady7xf/9UKre2SGj4SnZ2Yd+FVnY2u9zy40iksI=;
 b=lwM3mVPfcCqUAs4CxSbM4USpVKqJ1sWNgRwgVq/wYhhRwaX9D0rVkSDZ445rEyLk/c
 PVDFGiH4fvy3JIIkLJl1WYbMaU0CRkbQsD4wOMoY1NQ3BXiuLYGxorVZ0gHU62mlAf0a
 sqYQAR7z1y1v84vDoPkIC788HqE+O2QRyNlJS5aBKFeJed9aA+KhYUlY/ryn157U9ctI
 uGlPqFDthJILNSLpaQoAA0PWgfKrNXivMCJp2y+hnbA369eRRpeV4IgGMz7f4t/1m6Zz
 PB0OjKQNRgvB7S2Mwi6QvooEjrwkOhahvTdeY5BWWBYeX4vy1srG08u/S/HxvHZnjzdH
 zHMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYh8cnfDkVrXD/atuQroqFpjPN0rU2UwDibyQBq8y9vazj4xNsDq7o/9moGliiC2fzgSvA4v8gtD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBDWT208Knj2cpCNejH4psBWyAwFh4aSz/UG2mI1YAs5r8omwO
 nMKqy//E60Jns9RIE/x/rHje3noogZv28rP5PjRpMTJE+Ej7S8bblbDLj1L6LPv1n05wennQwPL
 bmg2JtoTbuyq4ZKd9gaZy3BIA0Lc9bgRf9G/H+vmcefwA16xyvfUCOgF/W1tnrKWA9sN3mxw=
X-Gm-Gg: ATEYQzxAO1Gxbig8s9hC81FhXS0OdPAbhIScIdkBe4N/nEnFCejbrTpSmMQ0QVF3YVk
 MAVdzIXm+cwJc/P5jC2mKvnuQqwUm/ZVH6rLfyUSZKP002j49cfZhn7KSHuDHrLMMxAFDiTpp3c
 El6VU43drtUDdaRpzin8EnldWAaGMb3pwSP4ucG8m95LdG8z2H0HPNG2USc3lVqUJpoQcct5fCi
 wojqSDoRM5eS5uGrrqeqeQ7OTyUv8WjEt9GfBu/XaXeyU7R2TK/9osE+hNKTZijr9nkoG2Jppzc
 pWS29UhUT0TFta8W8/vh5OCKJs1BPJP3sbXTElzQhn0rGuekmQ+RRn/EH1m38Avtee95mA67ial
 uZtxWKCzmxxYvwOrkdB8gf+7t3lshBEfAcINY61DHVPMcXEl73TFFblZRHlGbur5iGo/99xR5Qr
 7Zh9/Rr/ahiPvXDvQukw==
X-Received: by 2002:a17:90b:2ec4:b0:35d:a8d9:3a8 with SMTP id
 98e67ed59e1d1-35dc6f7ad0bmr2322319a91.16.1775025658211; 
 Tue, 31 Mar 2026 23:40:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2ec4:b0:35d:a8d9:3a8 with SMTP id
 98e67ed59e1d1-35dc6f7ad0bmr2322289a91.16.1775025657673; 
 Tue, 31 Mar 2026 23:40:57 -0700 (PDT)
Received: from [10.133.33.140] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbb96a125sm1434666a91.7.2026.03.31.23.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 23:40:56 -0700 (PDT)
Message-ID: <4f7772a9-2ab1-426a-83a6-7709bbdf0825@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 14:40:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/38] drm/msm/dp: Add catalog support for 3rd/4th
 stream MST
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-16-01faacfcdedd@oss.qualcomm.com>
 <j6n7jntsapy53ojyackylfctouuyu762pjf5dsbjhwoti6cos6@5ppukry35xo5>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <j6n7jntsapy53ojyackylfctouuyu762pjf5dsbjhwoti6cos6@5ppukry35xo5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA1NyBTYWx0ZWRfX+01OcXDXreVM
 5Vv+4FtspqMayoAt6eoy4yQAbvck3cPluqwu0Xf7gUDG4dMdESY28YI5SIXtPbDxNkN7xHyWmiW
 DU8yqYkM0ttdI8Zmv6e5FHoI9W4Q0NiH7E2aMXIWUGqfIaRcrOLVRypcClxgyNku/CoLkVIpGy0
 0net7mlB2z0GOHd6GgKmwpyDyyRfXGj/90CtcxOhmdo2tTysv0AYYTFGfFsoqzDToZw2hDffVfR
 3CJGnTbn+BMK+RlVHLSr5jxfEE7YVfdDTa4gYABiwrj8PqLJdohdOU+KJDKr1majPY3TZdgwtmX
 ixlHsqxkLu55dwHQYqbpJsTMEWGK1Vd0WY1fcClYpOdaihhFMf7LvIpzgaCmIHlpSCAcleFoj5U
 hHLhjo9pNdgnItJ2x4AO/HMoAOsihbkkQaMYd2BwNBCQOwm0gTGzAaLNA2UqXH3Nm0UhIlyE/GK
 tMnhxtks6VjkTYF2B+A==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69ccbdfb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EADwIwZ3O8U4OMQTBn4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Ctrrj9ISF4hlkpT5tMKGpCJFYlDqtGnJ
X-Proofpoint-GUID: Ctrrj9ISF4hlkpT5tMKGpCJFYlDqtGnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
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



On 8/26/2025 4:35 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:16:02PM +0800, Yongxing Mou wrote:
>> To support 4-stream MST, the link clocks for stream 3 and stream 4
>> are controlled by MST_2_LCLK and MST_3_LCLK. These clocks share the
>> same register definitions but use different base addresses.
>>
>> This patch adds catalog support to enable programming of these blocks.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    |  82 ++++++++++++++++++---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c |  24 ++++++-
>>   drivers/gpu/drm/msm/dp/dp_panel.c   | 138 ++++++++++++++++++++++++++++++------
>>   drivers/gpu/drm/msm/dp/dp_panel.h   |   4 +-
>>   drivers/gpu/drm/msm/dp/dp_reg.h     |  14 ++++
>>   6 files changed, 230 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index b8b6a09966aed96f705bdd54cb16ea63e5f0141f..608a1a077301b2ef3c77c271d873bb4364abe779 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -118,6 +118,8 @@ struct msm_dp_ctrl_private {
>>   	struct msm_dp_link *link;
>>   	void __iomem *ahb_base;
>>   	void __iomem *link_base;
>> +	void __iomem *mst2link_base;
>> +	void __iomem *mst3link_base;
>>   
>>   	struct phy *phy;
>>   
>> @@ -172,6 +174,40 @@ static inline void msm_dp_write_link(struct msm_dp_ctrl_private *ctrl,
>>   	writel(data, ctrl->link_base + offset);
>>   }
>>   
>> +static inline u32 msm_dp_read_mstlink(struct msm_dp_ctrl_private *ctrl,
>> +				       enum msm_dp_stream_id stream_id, u32 offset)
>> +{
>> +	switch (stream_id) {
>> +	case DP_STREAM_2:
>> +		return readl_relaxed(ctrl->mst2link_base + offset);
>> +	case DP_STREAM_3:
>> +		return readl_relaxed(ctrl->mst3link_base + offset);
>> +	default:
>> +		DRM_ERROR("error stream_id\n");
>> +		return 0;
> 
> I'd totally prefer having a single set of wrappers which can handle all
> 4 streams. Having separate call sequences is not a good idea and it
> makes it hard to change / extend it.
> 
Sure. will merge them into one func. eg. msm_dp_read_link(ctrl, id, 
offset)/msm_dp_write_link(ctrl, id , offset, data).
>> +	}
>> +}
>> +
>> +static inline void msm_dp_write_mstlink(struct msm_dp_ctrl_private *ctrl,
>> +			       enum msm_dp_stream_id stream_id, u32 offset, u32 data)
>> +{
>> +	/*
>> +	 * To make sure link reg writes happens before any other operation,
>> +	 * this function uses writel() instread of writel_relaxed()
>> +	 */
>> +	switch (stream_id) {
>> +	case DP_STREAM_2:
>> +		writel(data, ctrl->mst2link_base + offset);
>> +		break;
>> +	case DP_STREAM_3:
>> +		writel(data, ctrl->mst3link_base + offset);
>> +		break;
>> +	default:
>> +		DRM_ERROR("error stream_id\n");
>> +		break;
>> +	}
>> +}
>> +
>>   static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
>>   					struct msm_dp_link_info *link)
>>   {
>> @@ -386,7 +422,11 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>>   	u32 config = 0, tbd;
>>   	u32 reg_offset = 0;
>>   
>> -	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
>> +	if (msm_dp_panel->stream_id < DP_STREAM_2)
>> +		config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
>> +
>> +	if (msm_dp_panel->stream_id == DP_STREAM_1)
>> +		reg_offset = REG_DP1_CONFIGURATION_CTRL - REG_DP_CONFIGURATION_CTRL;
>>   
>>   	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>>   		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
>> @@ -401,8 +441,11 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>>   
>>   	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
>>   
>> -	if (msm_dp_panel->stream_id == DP_STREAM_1)
>> -		reg_offset = REG_DP1_CONFIGURATION_CTRL - REG_DP_CONFIGURATION_CTRL;
>> +	if (msm_dp_panel->stream_id > DP_STREAM_1)
>> +		msm_dp_write_mstlink(ctrl, msm_dp_panel->stream_id,
>> +			REG_DP_MSTLINK_CONFIGURATION_CTRL, config);
>> +	else
>> +		msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL + reg_offset, config);
>>   }
>>   
>>   static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
> 
> [...]
> 
>> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
>> index 43a9ce0539906e1f185abf250fdf161e462d9645..a806d397ff9d9ad3830b1f539614bffcc955a786 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
>> @@ -142,6 +142,7 @@
>>   
>>   #define REG_DP_CONFIGURATION_CTRL		(0x00000008)
>>   #define REG_DP1_CONFIGURATION_CTRL		(0x00000400)
>> +#define REG_DP_MSTLINK_CONFIGURATION_CTRL	(0x00000034)
> 
> Please don't mix registers from different register spaces, it's
> confusing.
> 
Got it. will put this into its own MST-specific domain.
>>   #define DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK	(0x00000001)
>>   #define DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN (0x00000002)
>>   #define DP_CONFIGURATION_CTRL_P_INTERLACED	(0x00000004)
>> @@ -163,12 +164,19 @@
>>   #define REG_DP1_SOFTWARE_MVID			(0x00000414)
>>   #define REG_DP1_SOFTWARE_NVID			(0x00000418)
>>   #define REG_DP1_TOTAL_HOR_VER			(0x0000041C)
>> +#define REG_MSTLINK_SOFTWARE_MVID		(0x00000040)
>> +#define REG_MSTLINK_SOFTWARE_NVID		(0x00000044)
>> +#define REG_DP_MSTLINK_TOTAL_HOR_VER		(0x00000048)
>>   #define REG_DP_START_HOR_VER_FROM_SYNC		(0x00000020)
>> +#define REG_DP_MSTLINK_START_HOR_VER_FROM_SYNC	(0x0000004C)
>>   #define REG_DP_HSYNC_VSYNC_WIDTH_POLARITY	(0x00000024)
>> +#define REG_DP_MSTLINK_HSYNC_VSYNC_WIDTH_POLARITY	(0x00000050)
>>   #define REG_DP_ACTIVE_HOR_VER			(0x00000028)
>> +#define REG_DP_MSTLINK_ACTIVE_HOR_VER		(0x00000054)
>>   
>>   #define REG_DP_MISC1_MISC0			(0x0000002C)
>>   #define REG_DP1_MISC1_MISC0			(0x0000042C)
>> +#define REG_DP_MSTLINK_MISC1_MISC0		(0x00000058)
>>   #define DP_MISC0_SYNCHRONOUS_CLK		(0x00000001)
>>   #define DP_MISC0_COLORIMETRY_CFG_SHIFT		(0x00000001)
>>   #define DP_MISC0_TEST_BITS_DEPTH_SHIFT		(0x00000005)
>> @@ -236,9 +244,11 @@
>>   
>>   #define MMSS_DP_SDP_CFG				(0x00000228)
>>   #define MMSS_DP1_SDP_CFG			(0x000004E0)
>> +#define MMSS_DP_MSTLINK_SDP_CFG		(0x0000010c)
>>   #define GEN0_SDP_EN				(0x00020000)
>>   #define MMSS_DP_SDP_CFG2			(0x0000022C)
>>   #define MMSS_DP1_SDP_CFG2			(0x000004E4)
>> +#define MMSS_DP_MSTLINK_SDP_CFG2		(0x0000011c)
>>   #define MMSS_DP_AUDIO_TIMESTAMP_0		(0x00000230)
>>   #define MMSS_DP_AUDIO_TIMESTAMP_1		(0x00000234)
>>   #define GENERIC0_SDPSIZE_VALID			(0x00010000)
>> @@ -248,6 +258,7 @@
>>   
>>   #define MMSS_DP_SDP_CFG3			(0x0000024c)
>>   #define MMSS_DP1_SDP_CFG3			(0x000004E8)
>> +#define MMSS_DP_MSTLINK_SDP_CFG3		(0x00000114)
>>   #define UPDATE_SDP				(0x00000001)
>>   
>>   #define MMSS_DP_EXTENSION_0			(0x00000250)
>> @@ -297,6 +308,9 @@
>>   #define MMSS_DP_GENERIC1_8			(0x00000348)
>>   #define MMSS_DP_GENERIC1_9			(0x0000034C)
>>   #define MMSS_DP1_GENERIC0_0			(0x00000490)
>> +#define MMSS_DP_MSTLINK_GENERIC0_0		(0x000000BC)
>> +#define MMSS_DP_MSTLINK_GENERIC0_1		(0x000000C0)
>> +#define MMSS_DP_MSTLINK_GENERIC0_2		(0x000000C4)
>>   
>>   #define MMSS_DP_VSCEXT_0			(0x000002D0)
>>   #define MMSS_DP_VSCEXT_1			(0x000002D4)
>>
>> -- 
>> 2.34.1
>>
> 

