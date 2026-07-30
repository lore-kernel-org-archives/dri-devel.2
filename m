Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C64C55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9314010E126;
	Thu, 30 Jul 2026 14:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C2YalGhS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFJmoRNo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF50D10E126
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:28:42 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDxKlb944563
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TeJATUx7ljVkLhlZlRGhQEAK
 TzXhPv+shwk0WDPgUfI=; b=C2YalGhSDICS4YRAXU2U+L8xwNORatJmUHoMwofp
 qqN7zufjbU8P37qCC9v/oSfnJTFw335fRWqFZRwWTwZvPjssYqUAJH1YqlvTybdY
 RaMXj8bmjYW1YnKlr2SmwhSDNWQAqe9hTkQ1ouKGjAlvZ1ILcJ6Oaw7hjjgJARMB
 RNA3nYnnNLijiCCoufJFiKBoc9YGo/+ghAfKIv7Eb3T53vJGWPAhiLUHIdEH1D/V
 fmyI8Sb4jwi5K2KRQlg1QS3hDE2hrTc7hC9bRyN5teYGXrmbUtmS6i/lRRXXP3vC
 OqsELm+b+ksxIjy1qcgPuEKkXGtiVd2YIRTyzOiKKt4uGA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7yt84h1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:28:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0408254aso11732601cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785421721; x=1786026521;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TeJATUx7ljVkLhlZlRGhQEAKTzXhPv+shwk0WDPgUfI=;
 b=KFJmoRNoySQjrfGCMskBI82DGdLnJdU9KtaBGiic5rcoTiA/hYFaiBIYgbZB3lgVoV
 5DJ0WMgkO0r5Yhz9+jmN5otD/Bv4VePJsiZRfN0hYOasJmuoR7qZxYtdiOOcxKY41OSr
 wODi3hD+F+2Asda1zR1ml/4pCcXYYIu0goLC+qAw1dH4g+wJPradc3m+bDl2Is5LIv5a
 MVBtFWBqbyAjHnRAvcx/xeI8uPGjrHC751BXCfwY6o7JGO4tRE/TdFKJEXpTejfoftx0
 A5ryhrO2g4nU9wjvT3xm5/zYon5032MIX0wR+xiyJ7j9VWHiMhATHHTHfsbNPdM8cMiK
 2v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421721; x=1786026521;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TeJATUx7ljVkLhlZlRGhQEAKTzXhPv+shwk0WDPgUfI=;
 b=haWd8HzIprvIyT7vWjx0ftLS2x3l2vufy1dyYrWjarHNOXUdgjS8I/12l5DClIi4Zy
 NVraw8RVeUygUmNXsY+WpogiVDbwzTqibgAx3t1RREBo6hJCF+EiC1wZf8L3wkUJCiwF
 8bhZ16HbUA52GJuvMrtOz078q7wb+o+tXyKMmevE2Vjac0+lsnxXnrIBVLLZ84P888ep
 na/S+xFfBjH4/pAHd5fhsd1ZeP3o1/eJp/0KuzX2aTag+teKc8k13N8cLGdxKXsv3uK9
 pj7u74XD1/im382Z+KEa86tdzxhl4nEIRgIAcZbwnCbShapkwSmnpVTLq+S9XzkUhWM3
 3uqw==
X-Forwarded-Encrypted: i=1;
 AHgh+RopM3RVl3VsfJZ9ozXXgv697QNZ9BpQoO5YE8p9NTZs32rBS9xhqAk9zSN7+L8RRsZBJxFKZDV7uX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwemjY7/ceRwvUQJkkaWeZ0uAdS96llyKPzm0faCzYfnftCQMds
 VG11uIFZrWUYwoOqpvxQoLMnIH7Aqo0rdKDFKx6sFpKDccnmKmW3cx9DHW1TkgIYIvYpxdSyYKI
 pYY//QAFBQj3qqxYcr/tKZzh5aAlS29YxdwDCg2Z4pzCHsjFAAleRuw5Qa2aXKBrmSv8whoM=
X-Gm-Gg: AR+sD13fQydHBlgQjuBx0Zk6dhXLlbwJnHR5kJC+EtDMRzhTPdrGUO84qrhYSY2Vnt2
 e7RiXkN/+kZk00wxh6PtvR9E+kjel9fQtr5093bKCZKeXeyuHad+RRPcpfC3ujpV/tZTeHgFHzz
 V1HHY3VuRT9KZ8Z4gOJ1mn/QsJu1tX+4iN9vivS6ILRfEi2fH50W16sPSmsgrDM0hdos3tLQp3k
 KP2amo9i6gWsneaIUYzdK6WVuGx09g4gdtGsI5NkC9MTpxlWntEgNXaWZi73bbn4mQc02C4oG/y
 i4JcHlJsW0ZX4pYrgZFxtzu4KfxcH9v/6FXsU/rTQoone4iWQXMe9kjLKxeupEG1W5qVoV+Vm2q
 60A9fGMhYNwO0n1Kad83aSJyCBuPUmCA9NKASRVoWm/4NYb5C6eaW4uxwvk7zNsPUZUsmROApIT
 vVn0U45/OVnv3cqg==
X-Received: by 2002:a05:622a:a10:b0:517:9407:5c38 with SMTP id
 d75a77b69052e-52b425c7cfbmr6250251cf.24.1785421721187; 
 Thu, 30 Jul 2026 07:28:41 -0700 (PDT)
X-Received: by 2002:a05:622a:a10:b0:517:9407:5c38 with SMTP id
 d75a77b69052e-52b425c7cfbmr6249781cf.24.1785421720708; 
 Thu, 30 Jul 2026 07:28:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db9c518bsm369768e87.59.2026.07.30.07.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:28:39 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:28:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>,
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>,
 Phong LE <ple@baylibre.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org,
 Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v9 06/61] drm/display: scdc-helper: Add macro for
 connector-prefixed debug messages
Message-ID: <y5776gxmfby42d25sp4zxpevhuj5s7zs5sd2i4d5xe2dodlbwh@ovrkyvgakd3i>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-6-4fb12ea22ac9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-6-4fb12ea22ac9@collabora.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDExMCBTYWx0ZWRfX9Np0nmtObCEo
 Tt9CzTjVBu87UDO5RVAtqXDcxXS6lJdaaguf7F7MecuT6rBJnpJ/ie/Y1MNsclZ7QjNe3CrSfln
 wBQG0So4ByYAvPMu2GKxcmL6DEwU+Wk=
X-Proofpoint-ORIG-GUID: 6cLrDkbD0oqnA-10Dz0TeoLxoj6P_Cm_
X-Proofpoint-GUID: 6cLrDkbD0oqnA-10Dz0TeoLxoj6P_Cm_
X-Authority-Analysis: v=2.4 cv=QNpYgALL c=1 sm=1 tr=0 ts=6a6b5f9a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=69EAbJreAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=1j1XXGRfLVQr3Hd9viAA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDExMCBTYWx0ZWRfX7zp5PUZ5tyFM
 hw35zMSmHWH71rrufek1FHZSWy+OV55vCWv9NoSh+z3r5gIJh1t7OfOsLzi2kkwfRfyugzHPQ85
 y5y5n/7E5tnkeg+OdOd0sobhgs0kRhQILTr4NuM96QfHax+FoVIo2dKq6gi6V3cypMtWtF9vL/k
 gsaRw7yxJSQ+JwW+iRaI4uNPzf5M0DIj6jnJnyTpSNvz9IY3OlKG3LG89XO54qM629uyTaaBmVJ
 OHVrULWmo2jVmaxQLRMFkC010otOwUT5EhtW9A/hiwh/IVuojtxnaW/+ZmIiYrDSPqHMyNN9Mgc
 9qFPYwqyyK9lGcjWChc4tgyIJSRcwa3B78s34ICTR0HR+DIM5u2uo7iAbd4ytQpJimCEbZzQuql
 kpUnGi3JCzQfRtqHVerW0X3nfdWB967oz8OAmI4gtKAZyZVYVMKibS2Sp2j6crzX81CmirA+d5K
 9NDLRGsP2JRcsnx9ZIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300110
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

On Thu, Jul 23, 2026 at 04:34:55AM +0300, Cristian Ciocaltea wrote:
> Introduce the drm_scdc_dbg() wrapper over drm_dbg_kms() to help getting
> rid of the boilerplate around prefixing the debug messages with the
> connector information.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_scdc_helper.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
