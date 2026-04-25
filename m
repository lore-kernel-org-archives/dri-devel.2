Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD7DFF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 12:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9AD10E225;
	Sat, 25 Apr 2026 12:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KgDkG0Ga";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WGQpPbfp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFBE10E1F6
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:41:35 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3Rf6o2952631
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=076e/qZCEx5EhM4ddJKV+sPw
 vYTuf+X8F+hJyK2dwOs=; b=KgDkG0GaiP/u8faVq0HIvs8zKYtmlsdnXShZgUqh
 drDD+tpIM5014dYOWw3FwbjBBmGaf1QVEmRQwXU1Q5Ye4EuLQVipfUpe5pki+dI9
 /8uIJIiGWW1KdwFbnY3pNSHNLjHXXBymvaQkpdcAeChf0h/SRJuDHQuRKBdTJhRC
 q35wkluXmkgLwdAzsUgGWrWKMwySaB+k6Y96w/CZOV43K6D6TO41W7Tn90riOCbU
 7IealuuIGKem999Q452fv8aQzyJyylYQj63TwTblsp2fWQ48egXk34tkqrPAoIg3
 ZrsNKSyFOhcHrz0G7S4dH0DuKYra5qE/bwT8x3RZ4hVrfA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqrgw2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:41:34 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8aca154e2b5so132301376d6.2
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777120893; x=1777725693;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=076e/qZCEx5EhM4ddJKV+sPwvYTuf+X8F+hJyK2dwOs=;
 b=WGQpPbfpkw34hM3VmeBYad1bzkRYd5u3TL0t45mJn2iUNRHm5GxgI804gt5WqKTI3C
 wx6p3WkpybHpKwNgqWlMAOXuqNLh+WIIwZJDDMXEYYx+buhj5c03ZtQiRCn2kkqIpxNl
 1ELSMiZNDz4AG3JI6ojgtuWkVjyjHz+Uwrx8cHZJxyKZp4Q9asP4hnaq2K8kM+p4T7kO
 3AazPCQr6KLsGgaasvJOmXZA7sahjAm2VR0y9+NX7R58tjLvYMhFxdpE2wHCJwwk7P5u
 XuSpH8lIlrny49P/WpJahAWJhR6V76zp9oTj2X78tGB4rm4HmelUS8OVupKwZAjKoUlA
 ViZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777120893; x=1777725693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=076e/qZCEx5EhM4ddJKV+sPwvYTuf+X8F+hJyK2dwOs=;
 b=dSVHrrVfEZrQ04uHh5yU5gnRGbALbV8ZnuofO3XasJeEnQ9lUHn39oehhKDADhg8dY
 GwtRkmaFuryJb17I+yvTGun224bRrQR/7U3SJdWq6Rz6MEDeCDnR+9WtvrZqqewZs0Za
 db2/jgRHbGqTDIQ+1l7gVUJqElc55TNex/2k/Lo5tMc2899tAY1GQga4NTw9UcPaEXKy
 62WN8yABZaQemw/gPeWfHgalI0oBu2pKlvqLNIt27bkdnOz0T9s5KT2plGFo1lqIgcs8
 zT7fuoJyYN6hs+nJgV80Q0A0fOFmgAHJzyGtw/SchlDtxp/1YamCcZL35YH+Y92YfMGE
 k/iQ==
X-Gm-Message-State: AOJu0YxGFc4CpsCGMqSjfunzI+rNpVmc/aRMlq8n8hQ5rwaZb3bv8GXT
 dC9w3F2yDNE2J8jF44wvBnHRIGEiJ5keB8R6H7mTaGdOQED5GN2jCO1o+/VyzZkj6MIhZvMyFIA
 Nyql+T+uQiJJhzwn3eSerHriUATZcDw2j35wGsV0LJ0eWwRPmVZDUNMS+HNm7aDHWMbWcweg=
X-Gm-Gg: AeBDieve5GNS9nukeWGCqoymILviUa1Mjna1wI/kDLqqz1kW40cCPJd9Qn/PPpKIHCw
 N/LKJFEiAHVvpvCP+EseBtpGzIpl8WTYracNv857P4NPN7ntESe4rs8FirGJ1LH5S4fRbH7tXGS
 iawjR5LMwptvhTUyhPPkTR5srjNwlwB0MYmWGb4FfYgSp4rU+JfgONbACPHIdTwv73W66JsHDkB
 zg7sHFeD3w/Vw42jtfRpNFeMgvep5SUe8qASUZwdutm+mXzdVvHuGSXZ4vN3ViXgG2ra3MJcOc9
 nUGLfX93hJz8CMLHHfncH5mDTD2G8WhEjFzqV/iRcCq+ZqVpl/9LI/Hj/oIBONW7Y20dcX3z01C
 VqRNG6nqQaBmn/kRV/GgRWFMqVprZDe0azMxm8hs8bIOPVdSbwWkWr2aPAHvnxMO/5Blj8LQQXo
 cahG3A08s+4YQgLy/LQqCo8sF1ENJW/gvzRo9JCLWBN7A+gQ==
X-Received: by 2002:a05:622a:1a82:b0:50b:3e64:9b2a with SMTP id
 d75a77b69052e-50e36be5f76mr538285801cf.20.1777120893407; 
 Sat, 25 Apr 2026 05:41:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1a82:b0:50b:3e64:9b2a with SMTP id
 d75a77b69052e-50e36be5f76mr538285381cf.20.1777120892972; 
 Sat, 25 Apr 2026 05:41:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e12e0sm6711008e87.51.2026.04.25.05.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 05:41:31 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:41:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 3/8] drm: link connectors to backlight devices
Message-ID: <k632yfxvm4od52pnnbclclffo4l73c3ztwysrwnkp5lfgpddfq@4ddwbap7o7vt>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424220953.167058-4-mario.limonciello@amd.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDEyNyBTYWx0ZWRfXxBoyiN0Hd0qq
 MawRGhQT2wptnQldBQl8a6B34c7DiizPGnxRMIADxIGyAet3U5PFbIIfyv0fZ6X5/cbeDCxMObb
 MsiU74+5gcHUK+nHitFpZhK23sWA0OMxY1vEICqPGbydPBisQAwZBYZsgDgoLvJpirqyI8XAkTo
 N3FHJGT5WvzDYhibWR3K3H0aICgirh2fz5+IyduZ2pw19DMZcLcUKOJ79nQ82b+O3IQquo6cCkn
 3gMT+NGV4YmaX933n01xwXu61q4Adsm2mXPIsX5YI0gfWZxHcDyci58TRTBi8aRxNckHNZuKvGy
 dcD9PGaE+QDW6eszUYc8vnVz3XhqDHOD8CVAsTrvstL4t5By0IhRDp8AEVsQgNmhhFCaV+pP0xB
 Rlb/i3N9RwA8ir/r1/46AVwPue8xpz0zWS8xOpeCUCqNiGw+sat0x9B/kVheeNVvK6/HgZ2vPJx
 /ChkGgY7mwKQhDaK+Cg==
X-Proofpoint-ORIG-GUID: 6MsjqDje7kpfuEn-2Ke32rnLTJaeaPBq
X-Proofpoint-GUID: 6MsjqDje7kpfuEn-2Ke32rnLTJaeaPBq
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=69ecb67e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=zd2uoN0lAAAA:8
 a=2BNH_UmNNtjW6ExFAgkA:9 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250127
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

On Fri, Apr 24, 2026 at 05:09:48PM -0500, Mario Limonciello wrote:
> This adds generic backlight-device support to DRM connectors. Drivers
> that need to link backlight devices to DRM connectors can use the new
> helpers to create a backlight property and link them at runtime.
> 
> Also add a brightness changed notification so that sysfs and DRM connector
> can stay in sync and handle property updates around DPMS.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/Kconfig             |   1 +
>  drivers/gpu/drm/Makefile            |   2 +
>  drivers/gpu/drm/drm_backlight.c     | 406 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c     |  12 +
>  drivers/gpu/drm/drm_drv.c           |   8 +
>  drivers/gpu/drm/drm_mode_config.c   |   7 +
>  drivers/gpu/drm/drm_mode_object.c   |  66 ++++-
>  drivers/gpu/drm/drm_sysfs.c         |  54 ++++
>  drivers/video/backlight/backlight.c |  17 ++
>  include/drm/drm_backlight.h         |  45 +++
>  include/drm/drm_connector.h         |   3 +
>  include/drm/drm_mode_config.h       |   5 +
>  include/linux/backlight.h           |  13 +
>  13 files changed, 637 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_backlight.c
>  create mode 100644 include/drm/drm_backlight.h
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 8f5a8d3012e41..8c00f534d50b8 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -17,6 +17,7 @@ menuconfig DRM
>  # device and dmabuf fd. Let's make sure that is available for our userspace.
>  	select KCMP
>  	select VIDEO
> +	select BACKLIGHT_CLASS_DEVICE
>  	help
>  	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
>  	  introduced in XFree86 4.0. If you say Y here, you need to select
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd7830..9912306e94950 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -78,6 +78,8 @@ drm-$(CONFIG_DRM_CLIENT) += \
>  	drm_client_event.o \
>  	drm_client_modeset.o \
>  	drm_client_sysrq.o
> +drm-y += drm_backlight.o
> +drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
>  drm-$(CONFIG_COMPAT) += drm_ioc32.o
>  drm-$(CONFIG_DRM_PANEL) += drm_panel.o
>  drm-$(CONFIG_OF) += drm_of.o
> diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
> new file mode 100644
> index 0000000000000..cbc6a855ed332
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_backlight.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * DRM Backlight Helpers
> + * Copyright (c) 2014 David Herrmann
> + * Copyright (c) 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/fs.h>
> +#include <linux/list.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <drm/drm_backlight.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_mode_config.h>
> +
> +/**
> + * DOC: Backlight Devices
> + *
> + * Backlight devices have always been managed as a separate subsystem,
> + * independent of DRM. They are usually controlled via separate hardware
> + * interfaces than the display controller, so the split works out fine.
> + * However, backlight brightness is a property of a display, and thus a
> + * property of a DRM connector. We already manage DPMS states via connector
> + * properties, so it is natural to keep brightness control at the same place.
> + *
> + * This DRM backlight interface implements generic backlight properties on
> + * connectors. It does not handle any hardware backends but simply forwards
> + * the requests to an available and linked backlight device. The links between
> + * connectors and backlight devices have to be established by DRM drivers and
> + * can be modified by user-space via sysfs (and udev rules). The name of the
> + * backlight device can be written to a sysfs attribute called 'backlight'.
> + * The device is looked up and linked to the connector (replacing a possible
> + * previous backlight device). A 'change' uevent is sent whenever a link is
> + * modified.
> + *
> + * Drivers have to call drm_backlight_alloc() after allocating a connector via
> + * drm_connector_init(). This will automatically add a backlight device to the

I'd like to point out another kind of devices which might have been left
w/o notice here: the panels. In a plenty of cases the driver creating
the drm_connector (frequently through drm_bridge_connector_init())
doesn't even know if there is a panel on the other side of the chain or
not. Likewise connector creation doesn't involve any panel-related
operation. Some panels provide backlight controls. Others don't and rely
on the external backlight controls (see drm_panel_of_backlight() for
example).

Can we work towards simplifying possible support for DRM backlights to
the setups with drm_panel in place?

> + * given connector. No hardware device is linked to the connector by default.
> + * Drivers can set up a default device via drm_backlight_set_name(), but are
> + * free to leave it empty. User-space will then have to set up the link.

This sounds like a definite no-go. Think about any phone or any laptop.
Do we need to involve userspace to let the kernel know that there is a
connection between the DRM connector and the backlight present in the
system?

What is the usescase for having dynamic connector<->link connections?

> + */
> +

-- 
With best wishes
Dmitry
