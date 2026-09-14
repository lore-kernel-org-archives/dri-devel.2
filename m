Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF514C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F312F10EBDB;
	Mon, 14 Sep 2026 07:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oB9JJJP1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f5HMQ7Uj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC81710EBDD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:56:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5irho3369388
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hdpi2jzl0BvQv5X+F2dziFnBhCFeUf0VIA21wNKOf5E=; b=oB9JJJP1E/TZlsDk
 96UPZpWDmngqCXam50q43Hkzct6TF8/JLaxwFVAtm2LgpZho1WVYv7eYhRyQoWc4
 yQNloyf/8zK1HSWDiR1LEg+vvg0smBxvqqA9JtX0k9lUWeX4f0dEgmpqAGouwFNd
 YYcmmn3fbrP0+iLx9JM6+583KMvBV+K+7j6Ej1dHFG/advDis3XpoDkDuT913zLB
 LyI2NW2nXOG+G2E917iopFccrNOEXHmZdzI2QIiulRFYaO7q329nMwSmrr4yEvOY
 uFlyyFiCldk3CxN/LdWY+tUURitViwDTGBM3gbQwYyQp09cwuxGUnNYgLYfEA8wL
 PIcMog==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmygd5mq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:56:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93495488976so51801685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789372560; x=1789977360;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Hdpi2jzl0BvQv5X+F2dziFnBhCFeUf0VIA21wNKOf5E=;
 b=f5HMQ7UjEYoeo0u5n4mhDKKtOE53KDWoLnHsQ7/C3TVOHh9zz3mSubxjmlyoE5YEby
 hZQi6mkkRVm392kQjowKZ19imopxVQDljy84jW9pc6472fJ+b7LA6ksGXgKrB49drYL0
 g8kasw72BIZzFf5Bb32FccWEpRekm+r2BbN7aSIgVpbqJ0iYkY+uetYZEJltyiDEHeIy
 fkrXFWPqmt+H1UMZ9yaVglyihUlT3tgjihdCntpPIMNZ4kOkvAyaRtwZy17rovYd2X6l
 QWxaK1XioFPIBkG4qndV89Iduy5WmRHhLEqajFmz1suq3lL81nWOooWmh4hDWlM3tJaN
 9+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789372560; x=1789977360;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hdpi2jzl0BvQv5X+F2dziFnBhCFeUf0VIA21wNKOf5E=;
 b=JYG7/8TX/V9fUcGV9CNNEd9onPKuJz7zGJ+8j2zd0qPErv5WiU6laq1M6+VEyDgFqz
 oGW1t6mdTdNSv1kvlAz/OyqWRBoQ4+z1PllfbTuWYaPJjVdNy9Fya481rOmbdPTZ6WZj
 E/O9kmuADmzlk3HYNFxO2E2/eJfd00WRPOR+Ri8xcKZMfaVLARIQXEi3SI2XgMrrNraU
 umS9lIehbFzFY2YT/NJ9bVDQhun3G6f2wQHwO32GmeBIJwG+s3Ao6jtRdwDoPfFv8fYf
 EDbgP0OeRCuC3pllAlE9RGggaOmaizwK7/V+2MbLKGW0UGtNeHQpclQxYbgTOC2Tc4Mh
 RyhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIFC02CTSfe36SSa1pbKK+pJDGenhPyRjQxYiA+TyhxgYvXjLiRNQTiTex8qPLpEiFu2xZw8DCa8o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kclTtVH1jRoAiP/PfTCk2hAMUvBXNs3FdJIHRvfrKh1Tvfsvvz
 Q1cg+qY+ogMW+PHxqANPTC01rb0tdMckSSiPaZGQgD9ol5/U/tqRoDMbWgGuvxtIXOy96Gsihjb
 Mje2zn1XIeVGgKRFrhHViasKUzbG0hgihNN/ZU+K0wrCQsP3psYknvV8lSncSwjgFMIvWWgw=
X-Gm-Gg: AYBFou2zNm7jSgqAt0RuaNSYsddaH6m0JWvimqukbZ7+u6iUgiEAQ1Y+xOdUFGiF/Qs
 BH3OgIEFg+c2Dk9w+ArwtXNNLPnSh3E4ZU3JbXMgMH0XrbtvjfJHmRF/ebaLPx/pQ0Y1BIzV3cT
 HMv94riYJrJludv2kK8JsYSVA0AOu0uQ1kjZjvGTagE68gWVbMMJZB+tdUMOo6rpwyUw6oKDvyj
 jic1TjCGIcFhFhvbtkumfV4r/9j3CJp6VK6KNdg0Q6SACC3ndHQrC5PSd86LpfCL710Wtst48YY
 Zd7i0X1qk09CJcV78yajhFpTGGPHtqdJvR5HMpQmxecPjnrMcXnK5GQnJZib6UILrYb0oAavxp/
 O9AHq5LGzZI8Oaop8nmhrpw==
X-Received: by 2002:a05:620a:8394:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93a29bad63cmr143698185a.3.1789372560236; 
 Mon, 14 Sep 2026 00:56:00 -0700 (PDT)
X-Received: by 2002:a05:620a:8394:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93a29bad63cmr143696085a.3.1789372559829; 
 Mon, 14 Sep 2026 00:55:59 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966124c98sm373482966b.56.2026.09.14.00.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 00:55:59 -0700 (PDT)
Message-ID: <12b7dc43-b9c6-4cd5-bfaf-fac8bddd7352@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 09:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/msm/gem: Add modparam to disable shrinker
 blocking
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260912145922.24115-1-robin.clark@oss.qualcomm.com>
 <20260912145922.24115-2-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260912145922.24115-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RY0FmFtv c=1 sm=1 tr=0 ts=6aa7a891 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ZVvdkDrwHHLD4pTVV7YA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDExMSBTYWx0ZWRfX5x1APgerv1Y3
 InciGevJ7S0XOhUeX38GwH+26zxWTPxb8EgY/N1+VbswmMZ0Q/HFnFx2qXFuxYtEvPN8sXFCbup
 yI2zG57gwuod+1/ESOvu7VCdywcBovO9/wdyOTSajOgmqn+YaWXr6ZqsjESiE7d91u2otEN/wgQ
 8LqmSO/d7wgqk1a/1ikeZ3ofyHKaNU7SD7rQUr8Z+fDuDjcV95EoFzgMnGiRnVwGiXQgFhCthlC
 TI95/EpYcXScJRJLHDTYecUWLqXBck4JdJO26IYUF1ca+UQEqY+EraOVktoVFRTxClUEcw4z/wR
 hrMMPUtex57XGPcHotuLu9y7fWzj8jipvM5+oMKryzXnzPJSkiIdPoFWc3cL8/Gw7dW2Vm4wYTY
 YmxG/34rtQGt1JWYJt137bvHYo7E+iz4fL/UGMnFeNtv9TUpsXeKJOJ69EMYZJCVEjJRiR74ZkG
 rogxc2HDwh19LexFENA==
X-Proofpoint-ORIG-GUID: 9ZQPc8WytwSHRxylFSr837llY3xcJsOp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDExMSBTYWx0ZWRfX4owjFYhMZdKH
 TBdMXp71DYsVWksuFMLIm/o0Zx+jVLixrO5tzNYjdFt4cGUA36/vhF3zHD0u9GRG8nrIYCGWFdR
 4lU+DloZNn+KJshqHgAcb5KNB2GRREw=
X-Proofpoint-GUID: 9ZQPc8WytwSHRxylFSr837llY3xcJsOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140111
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

On 9/12/26 4:59 PM, Rob Clark wrote:
> Normally if we are under enough memory pressure, the shrinker will
> eventually start waiting for BOs to become idle.  In some very latency
> sensitive use-cases this is undesirable.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> index 3514d5c84989..83ee032cb21d 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -19,6 +19,10 @@ static bool enable_eviction = true;
>  MODULE_PARM_DESC(enable_eviction, "Enable swappable GEM buffers");
>  module_param(enable_eviction, bool, 0600);
>  
> +static bool eviction_can_block = true;
> +MODULE_PARM_DESC(eviction_can_block, "Enable blocking for GEM buffer to become idle for eviction");
> +module_param(eviction_can_block, bool, 0600);
> +
>  static bool can_swap(void)
>  {
>  	return enable_eviction && get_nr_swap_pages() > 0;
> @@ -26,6 +30,8 @@ static bool can_swap(void)
>  
>  static bool can_block(struct shrink_control *sc)
>  {
> +	if (!eviction_can_block)
> +		return false;
>  	return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
>  	       (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLAIM));
>  }

This is just a guess, but can we always keep both and jump out
of msm_gem_shrinker_scan() early if we can satistfy nr_to_scan
without locking?

Konrad
