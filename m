Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D43FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632AE10E49F;
	Sat, 25 Apr 2026 21:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ILN9yDMw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DAsrU4q2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593A910E1CB
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:46:51 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PKaUeD2696065
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=janQVdjbdXtAjA0DFdCMJpfH
 QpM66VqlFeO9eJvVBI4=; b=ILN9yDMwF8wUHsCGp+pNUzVbMv3oTD4SDxW+tjqD
 miakJ6elDDagBjyVKs5AFTUHXMZ1IibLBC6FLk12oRLzVYA/e6BvgEfZoV4p0qpn
 lhVeZBstYy2o0aKc9TUWX4him591jM5FBzhwo2V5E8zw1xyCd6cNJbGJpfwqTTRk
 tF5+OqpUfzH7Vc0yCdBEd2q9EzfJWl+NiS8wao84FYZyodrjnyssHkfwucbzWpWD
 7ZXZT3uCCxHBa9d6iVv8MWNPD9b0YCC9Q+a5M9vY3yWdTYTKftyfz5cMWkRTwW7B
 r7OXUbC436wUrvi+3i7EIiWmKBlXrveIOwtC0hNB1I+DvQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnnf1qmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:46:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so239645701cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777153610; x=1777758410;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=janQVdjbdXtAjA0DFdCMJpfHQpM66VqlFeO9eJvVBI4=;
 b=DAsrU4q2aIILNVBCxCuh7Sv5NdYxO0VOrnWcUkDb64Ph6jssbIpDM6QQQmgf3cL2ON
 RrByLzEAw3UlJN9Ot1t6Dy9EbNsyk1Fzu9i21ehe58c0xLobedyKiZQUmxDf2gV5wb7b
 RMSioJni5cWhmQaQnQp68e3gdxRoqRZhVv/MhDGNjphwaBmtOoIBsKf8yCPtNLKwmgiZ
 DQXMWHYv3R6idRjVa/C8nEQe1aPfuo9pN/5QTppXOkzb5cwnv7LqDcqTMzbZUyrQaDQN
 hv0sKkpxXDZvhiRHg0w4FEU+ez56w9HyLpFVXExrMFwEKYnJEAPNKgbc0yMDi0UWcca+
 jCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777153610; x=1777758410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=janQVdjbdXtAjA0DFdCMJpfHQpM66VqlFeO9eJvVBI4=;
 b=lH0aS8V+qV5eV6xaRDr4GnCm09QjGgWasF7ztN8ZIClq3BE7yyXuEqptoUXgBMxUso
 o9Uqv7NpYwMhUTQK+h3T64SPAfTy/znT6aMl8YC0usOYs+FaU8AgbmjrucwflajYlNX9
 HJVGfCFwjxpIIK2+kKxPlbn8ujMVdLQWl83hXMQXuFU8LA/VQvBta48NGl1jAG8ytI2M
 Wm74Y3MEmVCA15qZLOD3hmiZpAmUqTKgdLM5eb6d08R5Phtk8kYEWKA7+cWMX3z4StI0
 4wFRpaUHakGyrZob7Xn0o4HPsPA2tJnCKmfAgrQs2lHSz2/CPjlewa+nmCTtvQpAMJZV
 kvTw==
X-Gm-Message-State: AOJu0Yw2id4NpU+EsFyl4C2hD34YaLdmFMYM1DIDAaRu2EOCkHADHApr
 Z81k2YnHAqpsst5onVrgOLqyuydMhqHQS1MH/WW1mdhqIU83a9tSWjo7st3jix6s2NExLgbYngd
 BRAYfAKbcrGOQwR9jM3QFSsccPcH+wlZ3d2+2FfZMY8RZ1qC2qCI2n8iQ8A5tP+L9TKJnqXs=
X-Gm-Gg: AeBDies2WLQ2llBxQlvNYKOUkoHJakPDWXLdoLRv6ivZBI1/m7znD/XNl7IXX6fqO22
 e1TGi3rx/hldjXspJj1Z85DqrXvx34EJHJrxUaryur3cZ2jZm/wlYLY5czUo4Fidgx52yXogtkH
 umy2BudQQYomvjcx++tmcU60GvZPKdOY6kcukqUzO5p1jY4KNRjhz89wXP8V16nb10yVVJrVeLl
 23/9Dpn1wbkMlwJnc8jr8Ob22HzgoLcF4B2+DAZ8a9hu3jUmaIaiH86QsucHAdeq08ASpfa8Dhr
 QHI7iXXi3DP04HbmwS4g1PEn5mD3oRTd//5ESMqu/kCtAeU19gk2pkgvpJoPPGg8vl/VNhWDOhv
 7qy6pSSET2aAz2eFvp+ZGeALaGISV+A3GF9Yw27O/I6KVpsKbGATXqTeoTtCYKZAcielR9pacwt
 LHkjCuSxJxPfAIeVnaV88pnG1xsPE47+dF1HpX8XYofDPDDg==
X-Received: by 2002:ac8:7d4a:0:b0:50f:aeaf:b127 with SMTP id
 d75a77b69052e-50faeafc0a0mr353887191cf.53.1777153609568; 
 Sat, 25 Apr 2026 14:46:49 -0700 (PDT)
X-Received: by 2002:ac8:7d4a:0:b0:50f:aeaf:b127 with SMTP id
 d75a77b69052e-50faeafc0a0mr353887021cf.53.1777153609140; 
 Sat, 25 Apr 2026 14:46:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a41a238563sm6801345e87.55.2026.04.25.14.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 14:46:46 -0700 (PDT)
Date: Sun, 26 Apr 2026 00:46:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 3/8] drm: link connectors to backlight devices
Message-ID: <ngcy43m43k2e7wfvngmpdlefwr4i6l7z2ipk2p6frtd4itpxbi@yvod57mmsxdq>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-4-mario.limonciello@amd.com>
 <k632yfxvm4od52pnnbclclffo4l73c3ztwysrwnkp5lfgpddfq@4ddwbap7o7vt>
 <bec9ab80-cbb5-4e2f-afcc-e20221a365a2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec9ab80-cbb5-4e2f-afcc-e20221a365a2@amd.com>
X-Proofpoint-ORIG-GUID: XJC0Xmng_hOQwxeLRFhqerpOnK4RHhkZ
X-Authority-Analysis: v=2.4 cv=Y5rIdBeN c=1 sm=1 tr=0 ts=69ed364a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=zd2uoN0lAAAA:8
 a=tMRYVEbYVSoKfAMIh7oA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: XJC0Xmng_hOQwxeLRFhqerpOnK4RHhkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDIzMCBTYWx0ZWRfX2l4Q1Nvaa2zy
 pDjUxjtedgjkHBxK5QJOpttj0lsUjdn5JwMaiUTmi/yjbD9wJl4RFbYxjOBNCyK3fNvAXPxJfBC
 OWwCdcNQP0BVsvrI/uiLY9ramxjvmlMu2XAvcEh5SHeMv7Zmi9nOxR7lBGbSBjuwaEpFn03MFO+
 pKCATagGTOmc13fRkC20qspxnuWMO6BXGO7C5KLC+NkwquiMIUcCVgbL0tpHO18Z2PpT5E6FPSn
 DHxZGHMl1IYu77Yp9vWYSa/1yX1JjI28LjG9NmKG7c/UKiBED0wfgRUCyaR/Rif8ARGWQjkQIzH
 d1E+Ze7HD1r8TernIi0E5V6XaSIRcP84F7epRFzIWv1Bp+U7SdL1QSoHcDyJZYQKa8u633FoMZY
 4z4S2eHt+zYdaWrIxl8oTX0Io5DNukU7NId3uzHWTIbcsIfZzyfOKtQGYMuUmfEdsEYtCfSOhwx
 +W4LnqTxYoDVs/ZZJLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_06,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250230
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

On Sat, Apr 25, 2026 at 09:40:50AM -0500, Mario Limonciello wrote:
> 
> 
> On 4/25/26 07:41, Dmitry Baryshkov wrote:
> > On Fri, Apr 24, 2026 at 05:09:48PM -0500, Mario Limonciello wrote:
> > > This adds generic backlight-device support to DRM connectors. Drivers
> > > that need to link backlight devices to DRM connectors can use the new
> > > helpers to create a backlight property and link them at runtime.
> > > 
> > > Also add a brightness changed notification so that sysfs and DRM connector
> > > can stay in sync and handle property updates around DPMS.
> > > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/gpu/drm/Kconfig             |   1 +
> > >   drivers/gpu/drm/Makefile            |   2 +
> > >   drivers/gpu/drm/drm_backlight.c     | 406 ++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/drm_connector.c     |  12 +
> > >   drivers/gpu/drm/drm_drv.c           |   8 +
> > >   drivers/gpu/drm/drm_mode_config.c   |   7 +
> > >   drivers/gpu/drm/drm_mode_object.c   |  66 ++++-
> > >   drivers/gpu/drm/drm_sysfs.c         |  54 ++++
> > >   drivers/video/backlight/backlight.c |  17 ++
> > >   include/drm/drm_backlight.h         |  45 +++
> > >   include/drm/drm_connector.h         |   3 +
> > >   include/drm/drm_mode_config.h       |   5 +
> > >   include/linux/backlight.h           |  13 +
> > >   13 files changed, 637 insertions(+), 2 deletions(-)
> > >   create mode 100644 drivers/gpu/drm/drm_backlight.c
> > >   create mode 100644 include/drm/drm_backlight.h
> > > 
> > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > index 8f5a8d3012e41..8c00f534d50b8 100644
> > > --- a/drivers/gpu/drm/Kconfig
> > > +++ b/drivers/gpu/drm/Kconfig
> > > @@ -17,6 +17,7 @@ menuconfig DRM
> > >   # device and dmabuf fd. Let's make sure that is available for our userspace.
> > >   	select KCMP
> > >   	select VIDEO
> > > +	select BACKLIGHT_CLASS_DEVICE
> > >   	help
> > >   	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
> > >   	  introduced in XFree86 4.0. If you say Y here, you need to select
> > > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > > index e97faabcd7830..9912306e94950 100644
> > > --- a/drivers/gpu/drm/Makefile
> > > +++ b/drivers/gpu/drm/Makefile
> > > @@ -78,6 +78,8 @@ drm-$(CONFIG_DRM_CLIENT) += \
> > >   	drm_client_event.o \
> > >   	drm_client_modeset.o \
> > >   	drm_client_sysrq.o
> > > +drm-y += drm_backlight.o
> > > +drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
> > >   drm-$(CONFIG_COMPAT) += drm_ioc32.o
> > >   drm-$(CONFIG_DRM_PANEL) += drm_panel.o
> > >   drm-$(CONFIG_OF) += drm_of.o
> > > diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
> > > new file mode 100644
> > > index 0000000000000..cbc6a855ed332
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/drm_backlight.c
> > > @@ -0,0 +1,406 @@
> > > +// SPDX-License-Identifier: MIT
> > > +/*
> > > + * DRM Backlight Helpers
> > > + * Copyright (c) 2014 David Herrmann
> > > + * Copyright (c) 2026 Advanced Micro Devices, Inc.
> > > + */
> > > +
> > > +#include <linux/backlight.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/list.h>
> > > +#include <linux/math64.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/notifier.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > > +#include <drm/drm_backlight.h>
> > > +#include <drm/drm_connector.h>
> > > +#include <drm/drm_device.h>
> > > +#include <drm/drm_mode_config.h>
> > > +
> > > +/**
> > > + * DOC: Backlight Devices
> > > + *
> > > + * Backlight devices have always been managed as a separate subsystem,
> > > + * independent of DRM. They are usually controlled via separate hardware
> > > + * interfaces than the display controller, so the split works out fine.
> > > + * However, backlight brightness is a property of a display, and thus a
> > > + * property of a DRM connector. We already manage DPMS states via connector
> > > + * properties, so it is natural to keep brightness control at the same place.
> > > + *
> > > + * This DRM backlight interface implements generic backlight properties on
> > > + * connectors. It does not handle any hardware backends but simply forwards
> > > + * the requests to an available and linked backlight device. The links between
> > > + * connectors and backlight devices have to be established by DRM drivers and
> > > + * can be modified by user-space via sysfs (and udev rules). The name of the
> > > + * backlight device can be written to a sysfs attribute called 'backlight'.
> > > + * The device is looked up and linked to the connector (replacing a possible
> > > + * previous backlight device). A 'change' uevent is sent whenever a link is
> > > + * modified.
> > > + *
> > > + * Drivers have to call drm_backlight_alloc() after allocating a connector via
> > > + * drm_connector_init(). This will automatically add a backlight device to the
> > 
> > I'd like to point out another kind of devices which might have been left
> > w/o notice here: the panels. In a plenty of cases the driver creating
> > the drm_connector (frequently through drm_bridge_connector_init())
> > doesn't even know if there is a panel on the other side of the chain or
> > not. Likewise connector creation doesn't involve any panel-related
> > operation. Some panels provide backlight controls. Others don't and rely
> > on the external backlight controls (see drm_panel_of_backlight() for
> > example).
> > 
> > Can we work towards simplifying possible support for DRM backlights to
> > the setups with drm_panel in place?
> 
> But to userspace it would interact with a connector not a panel directly
> right?
> 
> So doesn't the current design work well enough for this?  When there is a
> panel backlight control it could be added; and if there isn't just do
> nothing.

No, I wrote in the other email, why. 

> 
> > 
> > > + * given connector. No hardware device is linked to the connector by default.
> > > + * Drivers can set up a default device via drm_backlight_set_name(), but are
> > > + * free to leave it empty. User-space will then have to set up the link.
> > 
> > This sounds like a definite no-go. Think about any phone or any laptop.
> > Do we need to involve userspace to let the kernel know that there is a
> > connection between the DRM connector and the backlight present in the
> > system?
> > 
> > What is the usescase for having dynamic connector<->link connections?
> > 
> 
> Allowing userspace to setup the link was something in the original series by
> David and Marta that I left in place.  I don't have a problem with dropping
> that concept and requiring the driver to do the linking.

Well, I don't want to loose something actually useful. That's why I'm
trying to understand the usecase.

-- 
With best wishes
Dmitry
