Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A5CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8D610F34E;
	Thu,  2 Jul 2026 12:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KcVzo1UD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LFE+9IV6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B727F10F34E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:36:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6628sOb64172652
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 12:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lCJCbv0E0BPHDGtCuRumSuKi
 bvcyxri2VpiCoKAiOo8=; b=KcVzo1UD0A4Gl6Gc+lUxWkf9nedpLFnibRu45zan
 whVecqsEKpxEEtWVLIiQP0FZVBuOC3U3PeaInxP6q9yQvne2iHnTeUiV4BUBnJpL
 yt0Od0rYVb5Rs3wASjPeMUjF7+nqUvvw/4gxCemm+WHwJVyp3EkyaGZlE1hpBqGR
 9yOhOpLXrneDTnJ/OKCQETLRP3L6qmEaRtoQhjyuGRMU4eHZnZm4YgLk18MBzJWt
 f8oun5dDMjIjxYeSBWnUn4hvmk3CdxwvUygT1BK55TGosqY46eHY9MH8ZlJAevdG
 ghrtsgWNs8pgYKdpYlyilTdpntzcC0UZSDB5A7cUuhhLqg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwrunj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:36:52 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bd954154b1so443105e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782995811; x=1783600611;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lCJCbv0E0BPHDGtCuRumSuKibvcyxri2VpiCoKAiOo8=;
 b=LFE+9IV6ZciT79JbKGEbRoY71xuSem8iH8jpR+BZ7xjZsWDWElFSr1dffe9RmTafQS
 aiYIs7nSYxZvWQxF2S3+w2rhA0F0VqsADLSgDumzQPM0UivJ5QQ56Jl9y2n6EJMDbyeG
 dEaGvWa3m5lSjePBUq+f1Tqr8Itt6oeoUrXiQw+3pjR59eQL18rXUzQXsXrdvf+4I71a
 yVJCLwCPt0XUd2dwSfgpIATRpLHFKOyR5wNTpUIduxPvbnu8ptmntf5mSdxRjuo6S7GS
 nZZk0EYwk7q4i/sgTqETTkm9+oe7asQV5jX1X9i2XPo4D2ePGwai170/aBr5eX57VpAM
 TidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995811; x=1783600611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCJCbv0E0BPHDGtCuRumSuKibvcyxri2VpiCoKAiOo8=;
 b=K3Dz4W+Qxi9YFfUMfXhKCZt+zkw4756419hUlyrG8lModUig2B6n+kTJ7Zh4ZYneKC
 tAwpoRPjT9Lb0FTwkAyKhn3NhNi5y0Bb4JkIe9m0jWLVBBoW2nvq47qdTUqQztttN6ST
 2MgAg2nNffYqE5Co3s3isyzCGx806c8om2Yrudgf6z43Mp2rXF6hq/Cp2PudAo6SJ7+z
 ps2K+hERpcn6qWAG5rTLJnzDBlTUogKl8qdhKt1aHbHEELVHYmu2XWcLv85uU/8jY0dv
 b8HNbxjiMycrQbOl/tSDZy7JWyNXR8XYBQ+yKmQ0xLfSt1+B9tSW6nPAi0dP1I5MOvzR
 1VJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfPIqABCRa+i8s2h2Q65MtnO6UB+HtcBC/q+b/8GDfw0LXx5trZp5jsvQX5klaYdz/htd9Qujh7WA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmBxdxUSAGMJJO8h8EupGQxVuFiDBhHQvMASG3hIafrqx/X6oW
 clgN1aM5Gl1iA9SbST/GlFuEeZcyTkfCQFeZbqVyEcDLTXbmn8USLMd5grIDpi3K77UA/1p+odo
 FgsrkQ6EeCXq9iX8dzh+rGYmu61pMyP+zXQisNjiGJLiajP7J/KgVn+n3tjkVh+ly87pxZgs=
X-Gm-Gg: AfdE7ckNNDvzGT7PokFGxklf+yu58l70d25ao1Ofu3B20YrgbahyqhlX6fGZjspWT46
 OprY9VG8eE1iuaxALwjIeQvTW6BT3vDs/8i5KXbZEvjeIO1n/TE0IXOp8CjZyg7UgMqqRtMyqHE
 HewmZwagd+hR5CyFk5wpjkcIfLiXd38VoUhVYw54SmnB40ovrvQhedzAJR/SjI3/iGo0oYoy8cf
 tHJ1OGuDBQycFryNenOE582rYrFh0yrUUraKMSrIN3toK1taTU/od42EAvjRpqRoMP2/lYRPlDN
 Vty85XK6GathUC1KXmOvelWQ4vZWOsAvGFOrIzRMvXEckO21jF2PBRo2cO2lKNY/uPlxq8x9N6v
 fSxdGg69c2jLB2D1oYi0vQIeS6nBndxNVtJl1wqFZL+cwgdG9ovUcoJx50//XNjMSMu/Zs91dbN
 gPur/5k1l+rVMz8vNGdszdETV8
X-Received: by 2002:a05:6122:e1b2:b0:5a0:370:f12c with SMTP id
 71dfb90a1353d-5bde3b0e0f1mr1773671e0c.11.1782995811102; 
 Thu, 02 Jul 2026 05:36:51 -0700 (PDT)
X-Received: by 2002:a05:6122:e1b2:b0:5a0:370:f12c with SMTP id
 71dfb90a1353d-5bde3b0e0f1mr1773656e0c.11.1782995810560; 
 Thu, 02 Jul 2026 05:36:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aec89d526csm644713e87.43.2026.07.02.05.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:36:49 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:36:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v3 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
Message-ID: <yx4spk3w6stqtcxbivjwk6osghilb4a7a4drxr5l5wpzbwkjkd@2bzpt2zajker>
References: <20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org>
 <20260702-topic-sm8x50-vtdr6130-dsc-v3-1-db881a3fc026@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-topic-sm8x50-vtdr6130-dsc-v3-1-db881a3fc026@linaro.org>
X-Proofpoint-GUID: XuMnFVwKtPMzPlZluf8-xWeFzWRaWMNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX0gDp0rJ3G0pR
 EMLulls+ws/txNkAMRYLfTkoWx9+OrXkrRgMi5rWovAShZEpwU0s1/TQGpAhqXChszZpMyssn6/
 JWMrAzgVXby0ZGPMt3mMyh6vp/sIzPSPPC6dQHmYGVrkmYS6KYtAkC0jeY+Aad1mRSOpQGZ3Pfd
 YJxy1V3eRsPXYDCefWgFEPUKYSiRZD4pl1xZux/ZnJef77rDeMupUG8NqbOjXNgswKD9kiUf6KF
 VhSPvtIOz188ZUUgsz3FYAbQJp5lhUE4JFD39qRJ7vxJsSypJxkazZqrQ6TK2+xNrqD2yc8ynUu
 XTv5tUPP+wfMrcuSBGwRlujbTAo7jVgzIdiCe9OP7lhbUBYIBVqQ89F24u6WlGRRyInjsWEGPV8
 g/PQfRJUj7ig32crBVIsJds/9Sy7MXd+xJZV8z1UNMfS0J7ShCbBkQWrX283oe2JKCO/s4fSkR5
 4tm54IjqXylDm8bOFQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX/4aYT/cWonH/
 T5sHtR/oSRr5i/kSp6BZ83aPOT16BvSRrWOf1AxRupH2oo/0htvmsHpZOPciiw7h2IB19B4hn8A
 TC8U6Da/A5autTiiZhQ9CUxjj5z7qkU=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a465b64 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=hr6On4wLPrmFn5QqzOAA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XuMnFVwKtPMzPlZluf8-xWeFzWRaWMNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020132
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

On Thu, Jul 02, 2026 at 11:36:09AM +0200, Neil Armstrong wrote:
> From: Jun Nie <jun.nie@linaro.org>
> 
> Enable display compression (DSC v1.2) for 1080x2400 Visionox
> VTDR6130 AMOLED DSI panel.
> 
> This panel is the default panel for the following devices:
> - SM8550-QRD
> - SM8550-HDK
> - SM8650-QRD
> - SM8650-HDK
> 
> Enable DSC since now functional in the MSM/DPU/DSI driver.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/panel/Kconfig                   |  2 ++
>  drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index c0cc2bb4a3eb..d4e6535f3595 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1352,6 +1352,8 @@ config DRM_PANEL_VISIONOX_VTDR6130
>  	depends on OF
>  	depends on DRM_MIPI_DSI
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
> +	selecy DRM_DISPLAY_HELPER

With this fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



>  	help
>  	  Say Y here if you want to enable support for Visionox
>  	  VTDR6130 1080x2400 AMOLED DSI panel.

-- 
With best wishes
Dmitry
