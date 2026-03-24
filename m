Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EE3E9A755
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A70BC10E57C;
	Tue, 24 Mar 2026 09:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HzCHoPH2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A9vdNnXy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1F710E57C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:51:23 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O4Auw93170672
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zuEm4InrR8PTYNcIHNHYlCNu11l1X/KZ8SAxL2hLrew=; b=HzCHoPH29VN2ts+u
 k8WjvaZLRS2ZtlkgtUapLSP2BXj7Dr/6hSsv8B5rY3PilRil0oj6FVaO9bAPoZMO
 sKSsytQGH35bbwnZrZ4o7qPQMcu3w9PVnemyQuBSIoP+Cm/mmjSQ0CoucFTUjbMI
 Tp6R6TDH/uF1ykEqoUQ/STfgWhiNki0xvsY42pIFH2Go3BNRLft2tKeQVnz3PuOC
 xI0tSpZiNwsN9qppMGEHO3ppiEb0VHBFFI71EY4h4Aev82nDGnKcYWJiCrFHTkB/
 sHnOyfAcS8EBzMYqekhwPpx6+dUvxTpstlRz8VgCmWsEEE7AAWzVEv6FjQZ4I/WF
 MyB8aQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r243gg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:51:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c5014e220so39264276d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 02:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774345882; x=1774950682;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zuEm4InrR8PTYNcIHNHYlCNu11l1X/KZ8SAxL2hLrew=;
 b=A9vdNnXyIqDuYft7NCTRLoAxvcbkGHK7yh9VXFYeSrWfVaVA3n361kg/e5hkOFByzJ
 +00VVgckhk7++qbkHQjLVVxIwP7p3jnY80BA82EuRWKA/fYp2EaP8Ps8XfjRYCTQDz4z
 GcG8Cy7zGJTRnBdsTyDSTsghs/ufwGh/LfYZlHMsypuBbecvk8cwlr2mL3W5wi8ALo3D
 tzWVH87/T7pPArbC9/w8v0l7oG+MfEQimL7hoUJaESN111TSpgk8Rlt4yuOMBHGRkkbf
 IXuQc4hm/RvoiMxlMLHZwQTnSCULVK+chnICbzuFezjkWPmxEcBGiiKZPTUsM6WsJwNZ
 L4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774345882; x=1774950682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zuEm4InrR8PTYNcIHNHYlCNu11l1X/KZ8SAxL2hLrew=;
 b=coo/h2uIvj9PiwhzuRwyf4jcS3H6B+QkDXzwjbtnINBCxMeeOU0l9dMzmeRzYwhC5k
 wY6LVYoFWyqMcdmg7QqTbdyfw63rLUveJPOY0BEXSBtZMiDLsaW8ZHXTNNkeRlub/5pV
 3AVkNrvCX1RAmlParKqDXdq3gHq/VR+CIC/ez/OJc5nLXoha42Fzwn+HFQGkIKIk7nq2
 V1n3I6ER3M3RKddC5cHyK39MKQmtkTlwQi7pHmmo6GCHU2zOoNlrMcfPIlJH5jOgVtof
 dghyUVaASlx7cuZRp1GtYX45v0ykzyfLMxs8JBBzB7P6baGNuXKflEKIhOJzKGkzGbNc
 Gz7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJCSbFSItYNmDNf3JsqxXz/GTQAZORgQJllK8telZ0hc3FNjxcKuM7v/KvmhiMWmVdjy7gD553t34=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLGa1xt4wuKzosW26lBvkaHHkjxr5mV4kP/doHDwtfyq//NZ/9
 bb0J84xtV903xyUfjroqz6ZQNIl0AzSRoxLOHVAFJSVUZpEoQXDtYxOC28HrdeHCPvmeb16+oJQ
 RBRShrGxTXkhP6ERbXJPyPz/uOPVjKX6HfVrdGs/RWNQnjVp96hivZpMSSlBNTEcEb6VL9YiPNc
 KJlW4=
X-Gm-Gg: ATEYQzy40uwsiR45+17pWxhg0cfLv6dyvXZaHTXBMVuvk01Xj2S++v85QV24jNNR9fw
 yCeV8E+nvzG1Y4zPNf+lto1GQBBqg0ZOklf6U8CK/vhcw4lNiFQwO0kpoLGfbHxe06K471c/BxC
 XNLDmm93MvEKnVF8UireGDV7rs5a3cmgH6nHHuJL3u45GJi/8ow6jSmp3NURc2pWAOdKKQR9ZBr
 CYBJS7TE8kovOFYCc3fGUV04nk/n8cEWp5uLiac1Sniu5mpiyee4qCHlCqSM1H9rLaWHwyb/4I9
 M+MC2GBRpqd+BRlXArszRwaABqgsYBp+7RlIrLBK44LWg/utIHacQ9YL7TV2kdR/hbOgyzM+b+X
 /KCyZ96Y48f8XkSaVTuotG8FaPLnofu2njRSmRvHyhsj+7prc3+H0cz9ZmN7OIG4avBBszRF735
 970mo=
X-Received: by 2002:a05:6214:5293:b0:89a:53f8:2df0 with SMTP id
 6a1803df08f44-89c85a61351mr217672516d6.5.1774345881892; 
 Tue, 24 Mar 2026 02:51:21 -0700 (PDT)
X-Received: by 2002:a05:6214:5293:b0:89a:53f8:2df0 with SMTP id
 6a1803df08f44-89c85a61351mr217672196d6.5.1774345881426; 
 Tue, 24 Mar 2026 02:51:21 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f43bbbsm626014766b.8.2026.03.24.02.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 02:51:20 -0700 (PDT)
Message-ID: <deb68834-f384-46d8-81a3-9eff88deaef7@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 10:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] drm/msm/a6xx: Switch to preemption safe AO counter
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-2-fc95b8d9c017@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-2-fc95b8d9c017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c25e9a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-1Y_YdnrJnI9lEGYafQA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: AMZALkKoa8ZAamWVYfF2rA9VhqUJWX0z
X-Proofpoint-ORIG-GUID: AMZALkKoa8ZAamWVYfF2rA9VhqUJWX0z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3OSBTYWx0ZWRfX0jNjlo8aspYK
 bGqyxbkizMRiHW/OD9kIzYoVQZiD9GsYB3X8h1YNQkf3GxjcRiuOqviXPTv7IHMmztnk9A0XZ75
 GvZjLu7FoeppaP0ylMHTb+IIe/KSuUJsfBV8ly0bUzQzT7489UB5X8ZhgNG+skFJAgsHQiNmKuz
 C2JrGMRiQHIbPz6VoprZJvbl1rZ1KTonNtQrmzovvT1t3Qi1VOYy8RaJevK/n29JL3iFU4SUwtr
 gfF1uAZ+eBgkc15GtHKcJZ3rLZSHyoqi3seno8QRF9xUduZvI236C2MkUalp4QeUymzU8VISFhK
 P9CfWUo/BXX7WUFHFp7gxFXxNTEnCEoA6ITm7wkl9upKOYY0iXnnydW9lJs50yBJriI0JIUGitQ
 RnzkmESWx7egq9aekExjJZMudTEF6llgQCGVe+G6l72d2GTToV6tz61srzQIadgyCHrIPZuMash
 aGKhtdV+g6PFM1isFxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240079
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

On 3/23/26 9:12 PM, Akhil P Oommen wrote:
> CP_ALWAYS_ON_COUNTER is not save-restored during preemption, so it won't
> provide accurate data about the 'submit' when preemption is enabled.
> Switch to CP_ALWAYS_ON_CONTEXT which is preemption safe.
> 
> Fixes: e7ae83da4a28 ("drm/msm/a6xx: Implement preemption for a7xx targets")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 14d5b5e266f7..93bf2c40bfb9 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -345,7 +345,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  	 * GPU registers so we need to add 0x1a800 to the register value on A630
>  	 * to get the right value from PM4.
>  	 */
> -	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
>  		rbmemptr_stats(ring, index, alwayson_start));
>  
>  	/* Invalidate CCU depth and color */
> @@ -386,7 +386,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  
>  	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
>  		rbmemptr_stats(ring, index, cpcycles_end));
> -	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
> +	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_CONTEXT,
>  		rbmemptr_stats(ring, index, alwayson_end));
>  
>  	/* Write the fence to the scratch register */
> @@ -478,10 +478,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>  
>  	if (adreno_is_a8xx(adreno_gpu)) {
>  		rbbm_perfctr_cp0 = REG_A8XX_RBBM_PERFCTR_CP(0);
> -		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_COUNTER;
> +		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_CONTEXT;

I'm a little worried about mixing the names here - KGSL uses both of
these registers (A6XX_KERNEL_PROFILE vs A6XX_KERNEL_PROFILE_CONTEXT)
to track different fields of the struct adreno_drawobj_profile_entry

Konrad
