Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCA0F8FA9A
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E46B10ED33;
	Tue, 21 Apr 2026 16:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pEJvqlW7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c0xZuM53";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A5610ED10
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:34:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LALX6L1511252
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=OG03RLbkVQGi1m7r2kUY2OMQR5crtiM3OubK9GwayjU=; b=pE
 JvqlW7R7Tmh6LF7j7YPy7aZuZtlgPRLI8/PUXp1dsthLWQt3shP3g2zxSSjmdBhW
 9q4knPSH4yjHuNI8AYqC/PAUexjXKhy9P5EfguG3yf1edcc1m1nUF+Vf85RhTuUK
 E6InWvod0PUyDNpXWdkPVWqbKdLUoXOPvxKmK4ZmbUxwFmAvBSqxXPzt7wrrqb4K
 H0FHFNhOEpret6YZ75DuhPJuEqa1WqfTbYeD/rN0pf/9P+ZlwVBeCS2nBlIQu7zW
 EZEaRxeJiFWvSKFRJxmrFO7xi2PgDC1xuMF2oviFcS/7gHCMufT3b+X0KP1A9r8Y
 ZJtGj8o543CnaGH7rpZw==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp2ak2k0e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:34:20 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-423133d22a0so7341072fac.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 09:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776789260; cv=none;
 d=google.com; s=arc-20240605;
 b=N3g+xjbNnDwIe0hM48DslmPZhg4oWhGoNxRwEgKZXx9HJN02UhGAaDcTWTAuV86rDX
 el2CW32o9mYQ11UlwqDjE0Kex6OLklQzH63VplDKtnlLItwlikLWbMtejwrX7xMlLmdX
 hQ97qd+GPvol4bYeh5JzyNqYS5wbZQoM8RyMynPMetGdkKft2rJqnm1Npdq/0S/gDu0Y
 OXS2PW+D4KfrYXA2+rXO5o/aQ3y1bVs1kGbfk/09Ds+uI4UuhjTAlt1teNaSiuq3GsxA
 eafT2BQEJcqWPf6sxun5Y+HERw5Yl4Qa3HK3T1Fw0rnJzwVrvlaKfcER+ptKCMEUZnqn
 j6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=OG03RLbkVQGi1m7r2kUY2OMQR5crtiM3OubK9GwayjU=;
 fh=3F2mAyxixVOnjxUFAAZabvosxbzVw7ooiP7G7vygsWU=;
 b=RSUK6CTUloSwkxjWEhZnCneqXYn5kbUEXjq8GzW1Kw+JkCg215llE/emWwn78JVGvP
 hD43lOht5aye01nk/+A0YIaAjR/kM5E6Xae7xnaV+buV2xfG6LoxdGGFLPtKfgTOCcWB
 4U7bl01lDORFVdX+4HFClQpHbC2v7AGW+3oMs8zdDWgMHmPbB2cIwU8naBqfWby2ipIC
 CKZ7U5ttoh7coH/yKpXCMsQ8u3XYPOSJWeKCRx5Ad+j7WMRrS1209Svx2csT4c+7SOLA
 Dskq8qPXPp4tANRZfhktGTtQLYR5VRRvTyM01YpIL47XVVWcH36y/xnBMud8p6FnPNWV
 FUOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776789260; x=1777394060;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OG03RLbkVQGi1m7r2kUY2OMQR5crtiM3OubK9GwayjU=;
 b=c0xZuM53edV6bkDrAKXHQrZv1DVqFEFodcY2kzojY0sM9nHwcclo37qqBqUdEzRkae
 krmddGlTOugjKGvE6SsrMi7ELeKbRrfefMsG9ogDV35HdA8yroL7MrizII8aTUgTeQ+X
 XQJXZadW+GgjtfPoUuta2bJV5Q+QneMoYY+rwIuqh+UVZ8vc/wAbA5Tb/YhnAg0P60l8
 /0YOLhwNgzCdcejkifvqqvBMBb5uW0s3C4BPEAmX+uqKMAoIR0Lz7tN0ZGcdd6EIcn3v
 QjVCtiTNANyyBXBZW6fsux5jfbJvU2go9fdBJo8u42Wrs/WTG+XSXep0yEsrcBlz65OZ
 jzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776789260; x=1777394060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OG03RLbkVQGi1m7r2kUY2OMQR5crtiM3OubK9GwayjU=;
 b=Tz7/kEF1WaxAclEnZYUyAP5u6v4OqRXEt8oNndPkuQbdoV/NKcgRHYRXdyQc4osUp+
 5d1lzk0jGkzlq2qw/oPgwwUwO8jvmMQ4rqwgj3236neDw716Vk621ooqSqAL712ly31F
 0Tpynykn3Wf2kPsKWKAoo5nasLJCLm1ql6mxhi1PyLBKpEtyPHlJOtB7CCxG5AqkXXCs
 jRlhlYKbVMTQbqtmZEm8bKgFgamE3b6raK8wUyz/WWd8vrR8XGo24BBZywws2aPbH6ce
 B2uBYOSJWJUAmV7fpgtlxE082xX/9PKD+z/VtesYFrLvzKhcdLsiTVegbGeVtO3qH3Fr
 kNgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iovXDyp/tNWDBM7voQrBBwYIeNzE/dgT6VxT4TNIgVzp0zDKllNRuiwcP1GWqQ0TihXhjOzCCvnA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj07r6Fwxm//AXsQQ1ylS/sLLRcvBJmRYu9HcfZSNPovo37mHH
 EeBwvhYuAh0/9iPYKvTBliffDy1WRv/RF0kT5Q1ECXmo8QNexf3xF7rWxIE9w5bB99cN5ow75Sf
 35NvjSAvvl0LFUKOjwaoDVDsIhs/Y6u5pWdQSvJiJ4kd9MEKtcLUHIcA3wTyPAwleIKSXFfzx0P
 HcLxeIip2jM2d6KqSsWm77LaYT2nAZRFgRBnnpuN3ODWQoDQ==
X-Gm-Gg: AeBDieskswwm9O4+jWRsxbrXuYGgonFDBzN/SjeDKeUqyT5798FrdzTiGat0rG2HS1M
 HOvnVb5Zg8FI9sN2JJ1ehyaC6OxR5U1wKpq42mXwYBFneMJBCP2cOI7H3qOuknphq44axGTkbcB
 xdQJOlukfnFHpqpdKVK2mFx+FkWLVeZMlzVyjHlWhGh4166okSyyj3Il6ptVQ1/QS95GheyykYs
 D/JfO/ksWhGN+vXY1AA/XPH1KFH4EHki468/zBAVadilBZO
X-Received: by 2002:a05:6870:6390:b0:417:23f2:6d77 with SMTP id
 586e51a60fabf-42abf2ecb41mr10830936fac.16.1776789259803; 
 Tue, 21 Apr 2026 09:34:19 -0700 (PDT)
X-Received: by 2002:a05:6870:6390:b0:417:23f2:6d77 with SMTP id
 586e51a60fabf-42abf2ecb41mr10830914fac.16.1776789259378; Tue, 21 Apr 2026
 09:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260421084701.24227-1-laura.nao@collabora.com>
In-Reply-To: <20260421084701.24227-1-laura.nao@collabora.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 09:34:08 -0700
X-Gm-Features: AQROBzArUGDXn57yy7hiM7ct4lrQxadoBQMLBR3Cb8jVRGpfyvO4Z6UZBx6yzNM
Message-ID: <CACSVV01Kh5w1t26FEzKAVRxnKz=GCKjRvXe4KOKSLs-FkwkuBg@mail.gmail.com>
Subject: Re: [PATCH] drm: Remove DRIVER_GEM_GPUVA feature flag
To: Laura Nao <laura.nao@collabora.com>
Cc: dakr@kernel.org, boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=KItqylFo c=1 sm=1 tr=0 ts=69e7a70c cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=3M9eerblpL4TRhbo7qwA:9 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: Yeq2KEQbXZQQyVKcxmkJbezZ0hWfeV7x
X-Proofpoint-ORIG-GUID: Yeq2KEQbXZQQyVKcxmkJbezZ0hWfeV7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2NCBTYWx0ZWRfX3En+Fu0IXmDe
 DJM2qFaniJSWM0r6j5nPYpF2195mLJExN2NRBFo5JHmo6BZtHJv7SpAujYVbaEHupPGvD4GsF9M
 iy5h+yShqYeZmwilzOClt+3RIJEqUpUXMhYIOxe0hSMSlUaGODJT+pj5kl4GzPFqAPU5jzrI4JI
 Xbf43QbCoBEq723OonR2nzcJcoLEuy+3s+4CnFO6OERBpsFAEk33PlO21GFeLBVqeZcanefkO55
 rZRu5+kLhyzalijw0mPe7eOgMty+gyERP1mmT8B43D1YjUGL4cU9PdpVbQ1M/A4P6BctMUbt9Ju
 voB8KjKBMs7PLbaHlRBUYvUjHDImCFtrVgpy3K6/iWgq+c0LU48Sh7BR6jFpRnabMnfXs4+0C9h
 GMzllbJAIKrcUgq067JL2jMm/rgIB0HYPiZ+fmdUCk8UlHbbr8pLijqeAUKAOTJJwMK63R4Sv86
 Ns5Pph+/7SpLgyHfwUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210164
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Apr 21, 2026 at 1:47=E2=80=AFAM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> The DRIVER_GEM_GPUVA feature flag is currently only used to control two
> behaviors within the DRM core:
> - calling  drm_gem_gpuva_init() during
>   GEM object initialization
> - creating the "gpuvas" debugfs entry
>
> drm_gem_gpuva_init() is a plain INIT_LIST_HEAD() and therefore is cheap
> to run for every GEM object. The DRM_DEBUGFS_GPUVA_INFO macro is only
> referenced by GPU-VA capable drivers, so clearing the feature bit does
> not cause any unrelated drivers to get the "gpuvas" debugfs node. The
> flag doesn't have any relevant purpose (e.g. gating ioctl handlers or MM
> logic) and doesn't provide any practical benefit.
>
> Remove the flag definition and drop it from all drivers that use it,
> call drm_gem_gpuva_init() unconditionally and clear the driver features
> bit in DRM_DEBUGFS_GPUVA_INFO.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Acked-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
>  drivers/gpu/drm/drm_gem.c             | 3 +--
>  drivers/gpu/drm/imagination/pvr_drv.c | 2 +-
>  drivers/gpu/drm/msm/msm_drv.c         | 2 --
>  drivers/gpu/drm/nouveau/nouveau_drm.c | 1 -
>  drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
>  drivers/gpu/drm/xe/xe_device.c        | 2 +-
>  include/drm/drm_debugfs.h             | 2 +-
>  include/drm/drm_drv.h                 | 6 ------
>  include/drm/drm_gem.h                 | 3 ---
>  9 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 0377a5fd402d..cb703d0072aa 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -232,8 +232,7 @@ void drm_gem_private_object_init(struct drm_device *d=
ev,
>         if (!obj->resv)
>                 obj->resv =3D &obj->_resv;
>
> -       if (drm_core_check_feature(dev, DRIVER_GEM_GPUVA))
> -               drm_gem_gpuva_init(obj);
> +       drm_gem_gpuva_init(obj);
>
>         drm_vma_node_reset(&obj->vma_node);
>         INIT_LIST_HEAD(&obj->lru_node);
> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 268900464ab6..80033d4cb66a 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1375,7 +1375,7 @@ pvr_drm_driver_postclose(__always_unused struct drm=
_device *drm_dev,
>  DEFINE_DRM_GEM_FOPS(pvr_drm_driver_fops);
>
>  static struct drm_driver pvr_drm_driver =3D {
> -       .driver_features =3D DRIVER_GEM | DRIVER_GEM_GPUVA | DRIVER_RENDE=
R |
> +       .driver_features =3D DRIVER_GEM | DRIVER_RENDER |
>                            DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE,
>         .open =3D pvr_drm_driver_open,
>         .postclose =3D pvr_drm_driver_postclose,
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.=
c
> index 195f40e331e5..ee38c18715f0 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -825,7 +825,6 @@ static const struct file_operations fops =3D {
>
>  #define DRIVER_FEATURES_GPU ( \
>                 DRIVER_GEM | \
> -               DRIVER_GEM_GPUVA | \
>                 DRIVER_RENDER | \
>                 DRIVER_SYNCOBJ | \
>                 DRIVER_SYNCOBJ_TIMELINE | \
> @@ -833,7 +832,6 @@ static const struct file_operations fops =3D {
>
>  #define DRIVER_FEATURES_KMS ( \
>                 DRIVER_GEM | \
> -               DRIVER_GEM_GPUVA | \
>                 DRIVER_ATOMIC | \
>                 DRIVER_MODESET | \
>                 0 )
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 5d8475e4895e..0f5f662e5429 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -1364,7 +1364,6 @@ static struct drm_driver
>  driver_stub =3D {
>         .driver_features =3D DRIVER_GEM |
>                            DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE |
> -                          DRIVER_GEM_GPUVA |
>                            DRIVER_MODESET |
>                            DRIVER_RENDER,
>         .open =3D nouveau_drm_open,
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pant=
hor/panthor_drv.c
> index 87d27c3c1456..1a1d40a744db 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1805,7 +1805,7 @@ static void panthor_debugfs_init(struct drm_minor *=
minor)
>   */
>  static const struct drm_driver panthor_drm_driver =3D {
>         .driver_features =3D DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ =
|
> -                          DRIVER_SYNCOBJ_TIMELINE | DRIVER_GEM_GPUVA,
> +                          DRIVER_SYNCOBJ_TIMELINE,
>         .open =3D panthor_open,
>         .postclose =3D panthor_postclose,
>         .show_fdinfo =3D panthor_show_fdinfo,
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index ffea4a453c01..b3acc202df76 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -393,7 +393,7 @@ static struct drm_driver driver =3D {
>         .driver_features =3D
>             DRIVER_GEM |
>             DRIVER_RENDER | DRIVER_SYNCOBJ |
> -           DRIVER_SYNCOBJ_TIMELINE | DRIVER_GEM_GPUVA,
> +           DRIVER_SYNCOBJ_TIMELINE,
>         .open =3D xe_file_open,
>         .postclose =3D xe_file_close,
>
> diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
> index ea8cba94208a..eb93512b0f23 100644
> --- a/include/drm/drm_debugfs.h
> +++ b/include/drm/drm_debugfs.h
> @@ -48,7 +48,7 @@
>   * For each DRM GPU VA space drivers should call drm_debugfs_gpuva_info(=
) from
>   * their @show callback.
>   */
> -#define DRM_DEBUGFS_GPUVA_INFO(show, data) {"gpuvas", show, DRIVER_GEM_G=
PUVA, data}
> +#define DRM_DEBUGFS_GPUVA_INFO(show, data) {"gpuvas", show, 0, data}
>
>  /**
>   * struct drm_info_list - debugfs info list entry
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 42fc085f986d..e09559495c5b 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -107,12 +107,6 @@ enum drm_driver_feature {
>          * acceleration should be handled by two drivers that are connect=
ed using auxiliary bus.
>          */
>         DRIVER_COMPUTE_ACCEL            =3D BIT(7),
> -       /**
> -        * @DRIVER_GEM_GPUVA:
> -        *
> -        * Driver supports user defined GPU VA bindings for GEM objects.
> -        */
> -       DRIVER_GEM_GPUVA                =3D BIT(8),
>         /**
>          * @DRIVER_CURSOR_HOTSPOT:
>          *
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 86f5846154f7..996aa418dce9 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -663,9 +663,6 @@ static inline bool drm_gem_is_imported(const struct d=
rm_gem_object *obj)
>   *
>   * This initializes the &drm_gem_object's &drm_gpuvm_bo list.
>   *
> - * Calling this function is only necessary for drivers intending to supp=
ort the
> - * &drm_driver_feature DRIVER_GEM_GPUVA.
> - *
>   * See also drm_gem_gpuva_set_lock().
>   */
>  static inline void drm_gem_gpuva_init(struct drm_gem_object *obj)
> --
> 2.39.5
>
