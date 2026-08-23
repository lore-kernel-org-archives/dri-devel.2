Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D999BC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 21:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CBA10E05C;
	Sun, 23 Aug 2026 21:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eR/jx95A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iHjg2HUL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9158110E05C
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 21:19:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67NLDpoL1012295
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 21:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=l7RZsap49chD01FXy+hLzS/6
 WnZt4hChaP4Q9DCEjMM=; b=eR/jx95AtwAWeXuNlUrYcV+LJpiXQw5PxRRev38E
 xTrN9DECacOgT9kNqDcn5LmMbbhPkZO5IfIyM9UJUROywjay4vznKPW49wjdMK59
 49K/DZ1wIyXIdIdsilQBrfL4qY9if2iCv3pbF047Je8FrsfX9ptiBqeW5RIBJa4h
 lhFnlCo3GJV3b6EGllGW0+3y9mBXnkMF2n/vnB6GdQ9BVBagEiPxEHNS5VZ+eEor
 gbaMcrjbCjIOZsD5X7NmVb83Y+cHX6KvYX+xpm3bPyoSXIQn6fsszk1C/ybSjzCq
 qxyi6pM5+k9yGiY5ZxY6IucROn5KT2SY3/60nAg3Cz6AiQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7g079-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 21:19:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a23afcbso39543231cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787519982; x=1788124782;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l7RZsap49chD01FXy+hLzS/6WnZt4hChaP4Q9DCEjMM=;
 b=iHjg2HULZyQ4kMMDvtbGaO46OmPrMRti4CPvXN/+H1j7HQZRuQHwm+5dsbugd54oaR
 qRawFbtkD6uHrqNnKz06KWu/G6uBSnUYC6kxLV8LfoYgmfr1D/GOzOmAoiiWAincbvnj
 ylUILs3L7qFKKXawx3Hl7M4M3ZfTwA9Hcar1ZrYt0FUbLKZxryvXmKvKeeMT37vw3wxL
 n9Y90+sgWWk4xOP+ZsOpnppe1BVRuUGsB9fikJKn87Na/nyVzdPx7mTAf7yuCROBAURM
 cbpHoB7amgJGk9SjyJLZaulpvlW8kpi9ysIZ8FCcA/tX/ksCVAR4mDKsdKRLFNF5jY4J
 7+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787519982; x=1788124782;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l7RZsap49chD01FXy+hLzS/6WnZt4hChaP4Q9DCEjMM=;
 b=Zqun/eYFo31bNcYjBCFOzQdW+rmEu0foSL2c5mjj2gnSuAM2PM9TcNE76I5myecfOB
 Ab7qDkiu8Lkk7mKvqgy7SOxAX1KiE14frqZZ0uwIPPbUrp18WWN5T8BztwG0MJBie1H6
 VBj14iU11uNqy/HRdkJRBiyUXu8VZsoHblb23ZFLx5NCojQsb/0a9CwTFv5c6IL+DWVs
 dO26aGpsGs4POjJ4rCxOBVZIutSq8+iqIhg+KZG9x4FxkPc15ccMl6Jq3nlEHbYooK37
 oQ0O3rbH3aAQwNt6X4z4XcMlMYlo5/lrd8RENu5usuWccwzmpFs3RmaRG3l9NMXaJsdW
 sd/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPm/4BfgeVI2dYfN+yaZgZ50DNDj/Tgda929nYnrbteksqatt7On9I25EICF2BlKiElcJvQdehboA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lqWRhixflN+FZL6hpnt9RNpx8jR129zvnMvlbNT+HuOP9Sa3RH
 XJ99qFcwqDaPebQRQVIEMqITH04uM+Nm3CJTVulyTdiYPLKY1wJXaVFYQqy21BrgE1+FpMQr/39
 Cqi+pxZXXv/dge862Ib+60LJy5Y8KPQ6gZ/PfBhNZEvGjjaZ1N7k+v5wqcwWoSMCdiK8ePxo=
X-Gm-Gg: AR+sD13xUWhE6hHTqyn4SJk5OYVU8m1+9J/6XlpIfCOwFEVirkx7Xr1z3gOErXsSwru
 u6dVN30SmkjXo7t+2FIFmmaSwZdnIKqHY8g+LS6catIQBctyA6GUYylvGXP0P1+osOQyV7d0AGY
 E/eleNw71/idkl3Gl38IwUnLTK/5yN5EQYM5UEWvSWn40RfmRKkpTTDqoySs1zegj4GMHvz4B6Y
 /w1uMkBmUWteLB8pyUg2WI9cdU24fgUXgQ6b45/PXP/kxMP3OQrwB54Y6ZxwQ6SyyN5+/bFjChH
 k3+ElySIomkZDYSVfimSukjBnvcMunVQnNtQQeM/1i5bVevcmZA3WAJkhmBBgyBaoNzfOwZdoR3
 8IMkDP2xZNJZSJpvSB10Uz6DOIBO5eACJI0QN58UgKQU/P6iv2CtQ4rCmzhvKRdiZ74ZTiIk0Fm
 2d6M/LzJxhHQL+
X-Received: by 2002:ac8:5cd1:0:b0:528:583:a6ca with SMTP id
 d75a77b69052e-52df5741738mr218248931cf.14.1787519981845; 
 Sun, 23 Aug 2026 14:19:41 -0700 (PDT)
X-Received: by 2002:ac8:5cd1:0:b0:528:583:a6ca with SMTP id
 d75a77b69052e-52df5741738mr218248731cf.14.1787519981388; 
 Sun, 23 Aug 2026 14:19:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b48cdfdc49sm1246625e87.41.2026.08.23.14.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 14:19:40 -0700 (PDT)
Date: Mon, 24 Aug 2026 00:19:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 70/70] drm/crtc: Remove reset
Message-ID: <yjm52tuppz73qhmqvlbod6s2zxkmtjutmazgkwqg6oolrn7mqg@owea27yrpg5v>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-70-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-70-fb793475c05a@kernel.org>
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8b63ee cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=15lF2q8AZfmMG3c9NoEA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDE5NCBTYWx0ZWRfX9KWIx+0PzRt3
 FQVoIw5rJuT3ZS0RiDVlXMDXeg/EDo5KY4oaOWW1x9Q0Psl9lAh+cBQ5Qqq/A/8z3fwvFGmQvSd
 TKUNNHY/tJ7FiR1dCEdam+jigCvNx0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDE5NCBTYWx0ZWRfXyKBHPKOHP6PC
 A4XoTbN4pnj9CXMsKIn1d04ASVSdACAdxIrJdz5xl/TPca70S91UXOncUhpsz7ZcHSZoesa+2zr
 rkD30oATJrf+eFFvDnqwSy+osK1M8sBRx6WxtJfX818Q4yIDGcIuxeAewqf8h+A+BC2QIJXraBj
 +DpOYf1M4gkg9MXzGXXnEICx5FVwzvwmYB8M5+mo/cu0eNl7egR4Flr9AILEMQZp9FpFIP/aumZ
 Wo8GPBC6uxM+5Yo9DAJ0NfGcD0aqqI/lKJJdGArhXfqdWFgEvxR+RfH2F8J+CmJWBPlHsxt/M5+
 ssLs/86CrcN0mjp88FrPANQEWKjowcYiZ3rhZvl6s6h7EiJMCvKqC6vYqUTXfP6YeCormGxxSJE
 t7nmxXRXLsIhiT1iuvt4ozK5OG0UMP0PtEiq8ack1/HUPbw/yEmlK41QUZvwP5mRGlqJLTlTsaI
 W05JaGKAcqjd+oCiufQ==
X-Proofpoint-ORIG-GUID: k6zZULAkyU_aUDyGVsC7TH96uQDLhuGo
X-Proofpoint-GUID: k6zZULAkyU_aUDyGVsC7TH96uQDLhuGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608230194
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

On Fri, Aug 21, 2026 at 04:39:46PM +0200, Maxime Ripard wrote:
> All crtc drivers now implement the atomic_create_state hook instead of
> the reset hook for initial state creation. The reset hook conflated
> initial state allocation at probe time with hardware and software reset
> during suspend/resume, making error handling difficult since it is not
> fallible.
> 
> Remove the reset hook from struct drm_crtc_funcs and the associated
> call in drm_mode_config_reset().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_mode_config.c |  4 +---
>  include/drm/drm_crtc.h            | 10 ----------
>  2 files changed, 1 insertion(+), 13 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
