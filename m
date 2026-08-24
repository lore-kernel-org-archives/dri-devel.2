Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0341EC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E66810E2B5;
	Mon, 24 Aug 2026 07:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9i87oxO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iopwvPkK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB3010E2B5
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:31:33 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5REQi2602055
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GGW/2o11ZVLZJS92GyTOiHn4rgI8UzeMrVaPCXBo8Ng=; b=f9i87oxOAOwb1iso
 E6OrkENYef5T6l01cPTtRQ0nXkcn1Hm4S8CajoKsOt0iWII+bFTlD4dvVaRqvmkb
 QvPbSCHQjcLPPeDEpfuUFU1VwaZlvt9Rz/LFlwHUSqMBo+rn6/EaCKoPeIPzmyhP
 wFpSo1sTtod2YdHgHjqlshmoIsT224dyECJLMUCZEDKfVCo0n5MmY/l4XR3LTz0t
 6lrG2HqQ3HyoiNIRJ19K14oMKvEQYfpuCFvWpKVMRGAmrKztm3vi4aVymuLHpt6T
 hAa3hJn5wUK7V+voSLLBNJ4JOYsKQDqgAezNRh9l4xAgftLHiuNQ7S+pgUMgjxLK
 82hWpA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g744wwrja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:31:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso3453159a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787556692; x=1788161492;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GGW/2o11ZVLZJS92GyTOiHn4rgI8UzeMrVaPCXBo8Ng=;
 b=iopwvPkKnKwOu7vasE2O4na+3PsZR3KpJKouYlLt2nSvi4MrDTiIHnug01mei6hYj4
 Z79kZb7vfMdcjWfdh/62Sn4H2oDncUqWvOM1mbfdW8Gh0lcrBZbRF3RqHS3q2C8WbtVq
 O6v8vHAltUY4PorsUF4jHK+bG26Hg+H7vALLQkbNjDjBIJCY8N8q7GJx2/2Y7+9jEyG3
 2G7eiWq4xHrZHKq4a9ArDwTgKImcT7UzFQvtYjaFjtYQFwUITRUvjwhh5mSAmQJ+Wpb0
 vKXM5F3hpyHeb9ba7CCZihkaSn4JTAjv2EeQUmiTIh1KuSHR3ZLMYhyWE7x/aAT54/oS
 Mo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787556692; x=1788161492;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GGW/2o11ZVLZJS92GyTOiHn4rgI8UzeMrVaPCXBo8Ng=;
 b=i5ueJj6DbuqkZsQNAXTGy6m67zfMOAVELYDDPYbBG+u470kVcJ/oxe/kcDTkmJDNOV
 oBPH4fbShn2vjJnoMd3LRu7L5RtVi/cw4GdgkAaCBj9/qIrzj46voL1nw89EIOTdUBHk
 1HFTO7pRd5cf2fc3ndO4SDVGD0JUu+QOrjBy3U7OAHexsYk1brGNntwu/gDZY7GPbsBk
 XZ99aQ08OijbfCi7C0jnQELJXZog61NxlWnrO+7FmMHbgRkeETd8r8zfB68Men1cersm
 5OIxWuf3RHUnc8VS+NDSMoBhhItuM5EnDdy5PdjbS1oMO9rWEZkGb1GiQS2J3/hYHq8W
 1ARA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rokst7YcpsPOMN3EWlZSgmBGT1GCVyy5jfhcKOpVW5S+2ntqDbvWNRenyL38QSy8/Q4z3JgRhmZysg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lVTvkYdqCOOKLWcB0zWLaaBH35K6XO0kAmEBndmgTs4T3MVk+K
 69fQKsp7KkcxqWYSWnQiUSoMXDwagmXBqGj1ncKUJA1oy0wCyCPW0Ubdhr8oX3xlwNZzCQNcQbN
 3mIGJ4j01BS3UDha46xRATSqY3C6VoD6pz9mW/pZxKZsMnbdQ48p8//76cJzQ5dWbmT96MiQ=
X-Gm-Gg: AR+sD13TsWMf356r++LdR5ib5rOYsNmtr+ndDV7G1E+XCC+RTjMbC+f/yIngKlv3P3S
 5Y8py4VqRuD9AfqLVOHUsecQqf2h4cQ878v94O6cwMAP3SIlTtPdfYd8WCr2aPwOk3THLalV039
 htZHuaYXAat1KCf2Ot5MyqkxB+ADYLQV8V0cZsLoVSoh20iu85/1hBtzcWpIJptw+srcGqNgpCI
 YgJLLvfydDOuy/wz26oP+BnabsMAwTLND4fgZ1m5h25lRtxN+oR64hf6n1ntWar7gY/tlfsQbH+
 s8xrdytJqi94WGuHaUUtkrqm2K2QWPRSGYhbHDjbp3UOKuLaERhhDfkeoLFMmiqli+fYa09IQdZ
 WOLbHqTsZGOMTw3+GFQ1PAJlulyq9
X-Received: by 2002:a17:90b:5112:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-395df3cf1c8mr30844156a91.10.1787556692359; 
 Mon, 24 Aug 2026 00:31:32 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:381:cef1:11ac with SMTP id
 98e67ed59e1d1-395df3cf1c8mr30844077a91.10.1787556691821; 
 Mon, 24 Aug 2026 00:31:31 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e49b406bsm8987302a91.8.2026.08.24.00.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 00:31:31 -0700 (PDT)
Message-ID: <672f91dd-749a-4448-ab32-50ac064a4b98@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 13:01:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dpu: advertise linear-only modifiers on platforms
 without UBWC
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260819-remove_ubwc-v1-1-5357d5cc517f@oss.qualcomm.com>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <20260819-remove_ubwc-v1-1-5357d5cc517f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wws0V74Jg_yJiyEKpHfs3Va3ABCWzqCQ
X-Proofpoint-GUID: wws0V74Jg_yJiyEKpHfs3Va3ABCWzqCQ
X-Authority-Analysis: v=2.4 cv=KuF9H2WN c=1 sm=1 tr=0 ts=6a8bf355 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6mis40y7Vwa8aKjL8IcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2NSBTYWx0ZWRfX1FzP6KP0/oUv
 V4ezAC9BhQnjV8PyuDPtF29N/fcdxSndws9XbhHozg9QMQ3Ms3U84BgtHFgf/u8pcCBSswp4z98
 hFiCpFyLih23zJxWQ+qDnAcv2pMj1j0qUEQhP+DCt+qwmfD5C5p7UAx0db4hRDTuZypPodEDZZJ
 UbYpP+zcKLYF0jpwL1014bdKL2krQLfvtRIAW6cmbfFuRL8Tl50l9pFAdFxiZ1HUGwf96pQxn48
 +2C2dWNGe0aljIEK25cgSJQKQvQg60YQutHXaJiVgeLKw8UM/zgVCL59YRVkfWaCwIHSxh/SDts
 dR2W7ZYMnEtCAgb9WJlMbXq5B2VXh43b2vKYyxjML+r2C80tHRFRdI2qCDB1HBbqQK9oqURqLaY
 krPeIqGdStI1u2czHusc7anOZXW3lLFepVuh/rDg0ZM02JiyR/RBd2fWQ0GVk3e73YOhV2taPt5
 DdmIuy1CpQYH/Y85zzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2NSBTYWx0ZWRfXwcZ0FmRUEpee
 np/dNeditmwMPQswFJKOBQSZMU78L6OMnqtiWQi7kJbUk1Mp32NHAYmJAeRAPcqCe4gX5BtDoXa
 0a/EtNj52MPzdTTB7bti7/8GarOtjrY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240065
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


On 8/19/2026 4:53 PM, Mahadevan P wrote:
> Certain Qualcomm targets like QCM2290 and Shikra do not have UBWC
> support. On such targets, advertising DRM_FORMAT_MOD_QCOM_COMPRESSED
> in the supported modifier list causes userspace to attempt UBWC
> allocations that the kernel rejects:
>
>    msm_dpu: [drm] *ERROR* unsupported format modifier 500000000000003
>    msm_dpu: [drm] *ERROR* unsupported pixel format: AR24 little-endian
>
> On platforms without UBWC, only advertise DRM_FORMAT_MOD_LINEAR to
> avoid exposing formats that the hardware cannot handle.
>
> Fixes: 71c5c23be874 ("drm/msm/dpu: check ubwc support before adding compressed formats")
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 7b92082d35a6..c8bd034690cb 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -94,6 +94,11 @@ static const uint64_t supported_format_modifiers[] = {
>   	DRM_FORMAT_MOD_INVALID
>   };
>   
> +static const uint64_t supported_format_modifiers_no_ubwc[] = {
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
>   #define to_dpu_plane(x) container_of(x, struct dpu_plane, base)
>   
>   static struct dpu_kms *_dpu_plane_get_kms(struct drm_plane *plane)
> @@ -1836,7 +1841,10 @@ static struct drm_plane *dpu_plane_init_common(struct drm_device *dev,
>   	pdpu = drmm_universal_plane_alloc(dev, struct dpu_plane, base,
>   				0xff, &dpu_plane_funcs,
>   				format_list, num_formats,
> -				supported_format_modifiers, type, NULL);
> +				(kms->mdss->ubwc_enc_version == 0) ?
> +					supported_format_modifiers_no_ubwc :
> +					supported_format_modifiers,

Can we just pass the NULL here in case no ubwc modifer are supported 
instead of "supported_format_modifier_no_ubwc"?

would not it automatically handled in this function 
__drm_universal_plane_init as default_modifier?

Thanks,

Nabige

> +				type, NULL);
>   	if (IS_ERR(pdpu))
>   		return ERR_CAST(pdpu);
>   
>
> ---
> base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
> change-id: 20260819-remove_ubwc-0180dfb2908c
>
> Best regards,
