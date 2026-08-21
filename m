Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE25C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DF810F3D3;
	Fri, 21 Aug 2026 21:52:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YKxmkSFp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CA310F3C8
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787349138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxTIrj5toN2wZbiMOEAp8/1FtnWPmkO2zwot3SvJAQ4=;
 b=YKxmkSFppHTQQWO1l4+B1s2rMJ0zbdtauTwhJKciqYV8uKC07d4sQcqsh8Yz5HbD2hRUjG
 1n7xRtvXNMImnogV2vXQ8wo/8hh/YZ2K/KZfE0XlRbeLyC9sOKdzOgRG0CMBkyNmt5RAIY
 oFMdB2yfnCeJqKbMVvSOQKhfeUCkQ50=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Mhb3QqDrMNWE0uQc4I2k8w-1; Fri, 21 Aug 2026 17:52:16 -0400
X-MC-Unique: Mhb3QqDrMNWE0uQc4I2k8w-1
X-Mimecast-MFC-AGG-ID: Mhb3QqDrMNWE0uQc4I2k8w_1787349136
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93494527488so242506485a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787349136; x=1787953936;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KWxHNd99XGX0A91OcehYQd0todjKC95ynNoZwWY1F3w=;
 b=gL2wNdJisONfudlire8r9jPXDluwqy8RCgWG9tCsUqbnJOvQRAfqQd5ngXiyfKeS4m
 CC+k56yrkst9sNk6hVm/2qgrxjc3aSIUPh6XWvD4ag7FtnELMKQrGWAEK4vABDTLiPoj
 HEsgvhR/ky/jJD5UP6dTSqX3Zh5X+xkMNA7bOfu3nbcK+wIQkzf5B0A5ac228RHt2siW
 6heSotAmVT1aIyqfTuyLSVgQ+fb+W16xONwwZD4/AMx72NDb7ANJ7PLTQ7pPiIFtoYod
 KFg5c7Law37KbnztYp5GczoQ9O9CP1l25DXqRKbiws6LD1RhKXizMhuvKYevqKQsfNZN
 /H3w==
X-Gm-Message-State: AFuF++n7wM45WFc5/ukP6uQQmIM9wMpAN69hSJM2IhGR8bo3UhVsxKYJ
 sYFaHNptKJeh+ndOIJeJFecy04H+A2NIpXNRKVovkp+kqn5B/03SNRj5FFo6AVMq/YYD7LWv8O6
 Yz6ZzhAWavY0aVT2WQVkwcD4zMrKnORyeU8qs4gHrIcnQscLlWOecfBNG8xDVAQaJ5uPiig==
X-Gm-Gg: AR+sD13cHjVdTdq3rBjyT3CEeJyugv1fy+Upte0XiNigCN6vg1uvvO+rROLUIP9CjAc
 590rEh2vXMbUNPOJUSKRGIGG54OVAmEreBkzEaW7S5w6ZNUmgMTSsASpGpMXCflMOWGDeaqhHxk
 JwSzLfiwpm8GXzaOS6Epj0dUBKNl+N0SdVQW/0v1duNEanjAPRK+BQVJUOGaZVRgppInbZupMHj
 AOAaK7YzOr1iVjVH018mNT8IKN7jb4Csmkud922mF1wQT1lcvfhTvwjNJvuS/79IepIkGF0S0s6
 YeLX7w4IIOnMNCzTYbbOBPzDgC19bHXSWA5aRgtxbyy59D/tx/OkDwHLII6u/DttkWH6Nf7E
X-Received: by 2002:a05:620a:1d0d:b0:937:1710:f839 with SMTP id
 af79cd13be357-937395f9133mr938556185a.47.1787349135755; 
 Fri, 21 Aug 2026 14:52:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0d:b0:937:1710:f839 with SMTP id
 af79cd13be357-937395f9133mr938550485a.47.1787349135161; 
 Fri, 21 Aug 2026 14:52:15 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93749e9f94bsm5008085a.37.2026.08.21.14.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 14:52:14 -0700 (PDT)
Message-ID: <66c8492e4018fa32c59aaef767a975fdc8887b41.camel@redhat.com>
Subject: Re: [PATCH v2 04/10] drm/nouveau/disp: fix HDMI vendor infoframes
 on GB20x
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 17:52:13 -0400
In-Reply-To: <20260820164929.17117-5-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-5-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8VVtMe1dIAjxiUDQhhJOJJQOF9uoNY6yXveUw17COtc_1787349136
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
> The GSP path reuses the GV100 direct-MMIO infoframe writers on every
> chip. On GB20x that is only half right as while the legacy SF AVI
> unit is
> unchanged, the legacy VSI unit at 0x6f0100 was removed, so
> gv100_sor_hdmi_infoframe_vsi() writes into a reserved area and no
> vendor
> infoframe ever reaches the HW. This affects HDMI-VIC signalling which
> can impact some 4K modes for legacy HDMI 1.4 sinks.
>=20
> GB20x (NVDisplay 5.0+) reorganised the SF HDMI packet units. Per
> NVIDIA's
> published C971/CA71 DISP_SF_USER class headers, only three legacy
> units
> remain (AVI at +0x000, GCP at +0x040, ACR at +0x080), and vendor
> infoframes must instead be sent through the shared generic infoframe
> units at +0x130, whose 9-dword packet slots are loaded through the
> shared data port at +0x3f0/+0x3f4.
>=20
> Add a VSI writer using the same programming sequence OpenRM uses on
> these chips (nvhdmipkt_C971.c, programAdvancedInfoframeC971()):
> disable
> the unit and wait for it to idle, clear the SENT status, write the
> packet
> through the data port with a zero inserted in HB3 after the three
> header
> bytes, then enable the unit for every-frame transmission during
> vblank.
> Generic unit 1 is used for the VSI, matching the slot assignment in
> NVIDIA's nvkms (NVHDMIPKT_TYPE_SHARED_GENERIC2, unit 0 is reserved
> for extended metadata packets and unit 2 for the HDR DRM infoframe,
> if those are wired up later).
>=20
> GB20x so far shared GA10x's display entry point. Give it its own,
> gb202_disp_new(), with a gb202_gsp_disp table that supplies the VSI
> writer to the GSP path and otherwise carries the same hooks as GA10x.
> The following fixes fill in the rest of the GB20x differences there.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0.../drm/nouveau/include/nvkm/engine/disp.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/device/base.c | 10 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/Kbuild=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/gb202.c=C2=A0 | 91
> +++++++++++++++++++
> =C2=A04 files changed, 98 insertions(+), 5 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
>=20
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
> b/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
> index 7903d7470d19..01145db32c53 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h
> @@ -87,4 +87,5 @@ int gp102_disp_new(struct nvkm_device *, enum
> nvkm_subdev_type, int inst, struct
> =C2=A0int gv100_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_disp **);
> =C2=A0int tu102_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_disp **);
> =C2=A0int ga102_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_disp **);
> +int gb202_disp_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_disp **);
> =C2=A0#endif
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> index ea62dc97f118..96c8a5b29999 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> @@ -2846,7 +2846,7 @@ nv1b2_chipset =3D {
> =C2=A0=09.pci=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gh100_pci_n=
ew },
> =C2=A0=09.timer=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gk20a_timer_new },
> =C2=A0=09.vfn=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga100_vfn_n=
ew },
> -=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_disp_new },
> +=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gb202_disp_new },
> =C2=A0=09.fifo=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_fifo_new }=
,
> =C2=A0};
> =C2=A0
> @@ -2862,7 +2862,7 @@ nv1b3_chipset =3D {
> =C2=A0=09.pci=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gh100_pci_n=
ew },
> =C2=A0=09.timer=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gk20a_timer_new },
> =C2=A0=09.vfn=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga100_vfn_n=
ew },
> -=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_disp_new },
> +=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gb202_disp_new },
> =C2=A0=09.fifo=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_fifo_new }=
,
> =C2=A0};
> =C2=A0
> @@ -2878,7 +2878,7 @@ nv1b5_chipset =3D {
> =C2=A0=09.pci=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gh100_pci_n=
ew },
> =C2=A0=09.timer=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gk20a_timer_new },
> =C2=A0=09.vfn=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga100_vfn_n=
ew },
> -=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_disp_new },
> +=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gb202_disp_new },
> =C2=A0=09.fifo=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_fifo_new }=
,
> =C2=A0};
> =C2=A0
> @@ -2894,7 +2894,7 @@ nv1b6_chipset =3D {
> =C2=A0=09.pci=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gh100_pci_n=
ew },
> =C2=A0=09.timer=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gk20a_timer_new },
> =C2=A0=09.vfn=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga100_vfn_n=
ew },
> -=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_disp_new },
> +=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gb202_disp_new },
> =C2=A0=09.fifo=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_fifo_new }=
,
> =C2=A0};
> =C2=A0
> @@ -2910,7 +2910,7 @@ nv1b7_chipset =3D {
> =C2=A0=09.pci=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gh100_pci_n=
ew },
> =C2=A0=09.timer=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gk20a_timer_new },
> =C2=A0=09.vfn=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga100_vfn_n=
ew },
> -=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_disp_new },
> +=09.disp=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, gb202_disp_new },
> =C2=A0=09.fifo=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, ga102_fifo_new }=
,
> =C2=A0};
> =C2=A0
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild
> index e1aecd3fe96c..98d6ca5ac311 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild
> @@ -27,6 +27,7 @@ nvkm-y +=3D nvkm/engine/disp/gp102.o
> =C2=A0nvkm-y +=3D nvkm/engine/disp/gv100.o
> =C2=A0nvkm-y +=3D nvkm/engine/disp/tu102.o
> =C2=A0nvkm-y +=3D nvkm/engine/disp/ga102.o
> +nvkm-y +=3D nvkm/engine/disp/gb202.o
> =C2=A0
> =C2=A0nvkm-y +=3D nvkm/engine/disp/udisp.o
> =C2=A0nvkm-y +=3D nvkm/engine/disp/uconn.o
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> new file mode 100644
> index 000000000000..fa83aee35ae7
> --- /dev/null
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2026 Valve Corp.
> + */
> +#include "priv.h"
> +#include "head.h"
> +#include "ior.h"
> +
> +#include <subdev/timer.h>
> +
> +/* GB20x (NVD5.0) reorganised the SF HDMI packet units. The AVI unit
> is
> + * unchanged from GV100, but the legacy VSI unit is gone. Vendor
> infoframes
> + * are sent through the shared generic infoframe units instead.
> Register
> + * layout per NVIDIA's clc971.h/clca71.h, programming sequence per
> + * nvhdmipkt_C971.c:programAdvancedInfoframeC971().
> + */
> +static void
> +gb202_sor_hdmi_infoframe_vsi(struct nvkm_ior *ior, int head, void
> *data, u32 size)
> +{
> +=09struct nvkm_device *device =3D ior->disp-
> >engine.subdev.device;
> +=09const u32 hoff =3D head * 0x400;
> +=09/* Generic infoframe unit 1, the slot NVIDIA's driver uses
> for the VSI. */
> +=09const u32 ctrl =3D 0x6f0138 + hoff;
> +=09u8 buf[36] =3D {};
> +=09int i;
> +
> +=09/* Disable the unit and wait for it to go idle. */
> +=09nvkm_mask(device, ctrl, 0x00000001, 0x00000000);
> +=09if (nvkm_msec(device, 2000,
> +=09=09if (!(nvkm_rd32(device, ctrl) & 0x00400000))
> +=09=09=09break;
> +=09) < 0)
> +=09=09return;
> +
> +=09if (!size)
> +=09=09return;
> +
> +=09/* Clear SENT status, and point the data port at unit 1's
> slot. */
> +=09nvkm_mask(device, ctrl, 0x00800000, 0x00800000);
> +=09nvkm_wr32(device, 0x6f03f0 + hoff, 0x00000001);
> +
> +=09/* The data port takes the raw packet, except that a zero is
> inserted
> +=09 * in HB3 after the three header bytes. A slot is 9 dwords
> (HB0-3 plus
> +=09 * up to 32 payload bytes). An HDMI infoframe carries at
> most PB0-27,
> +=09 * so the tail stays zero, and we always write the whole
> slot.
> +=09 */
> +=09size =3D min_t(u32, size, 31);
> +=09memcpy(buf, data, min_t(u32, size, 3));
> +=09if (size > 3)
> +=09=09memcpy(&buf[4], (u8 *)data + 3, size - 3);
> +
> +=09for (i =3D 0; i < 36; i +=3D 4) {
> +=09=09nvkm_wr32(device, 0x6f03f4 + hoff, buf[i + 0] |
> buf[i + 1] << 8 |
> +=09=09=09=09=09=09=C2=A0=C2=A0 buf[i + 2] << 16
> |
> +=09=09=09=09=09=09=C2=A0=C2=A0 (u32)buf[i + 3]
> << 24);
> +=09}
> +
> +=09/* No flip ID or scanline matching. */
> +=09nvkm_wr32(device, 0x6f013c + hoff, 0x00000000);
> +
> +=09/* ENABLE | RUN_MODE=3DALWAYS | LOC=3DVBLANK | OFFSET=3D1 |
> SIZE=3D0. */
> +=09nvkm_wr32(device, ctrl, 0x00000041);
> +
> +=09/* Audio priority low (the init value). */
> +=09nvkm_wr32(device, 0x6f03f8 + hoff, 0x00000002);
> +}
> +
> +/* GB20x is GSP-only. This table supplies the register programming
> the
> + * GSP-RM display path needs from the chip.
> + */
> +static const struct nvkm_disp_func
> +gb202_gsp_disp =3D {
> +=09.uevent =3D &gv100_disp_chan_uevent,
> +=09.ramht_size =3D 0x2000,
> +=09.gsp.intr =3D tu102_disp_intr,
> +=09.gsp.head_state =3D gv100_head_state,
> +=09.gsp.head_rgpos =3D gv100_head_rgpos,
> +=09.gsp.vblank_get =3D tu102_head_vblank_get,
> +=09.gsp.vblank_put =3D tu102_head_vblank_put,
> +=09.gsp.hdmi_gcp =3D tu102_sor_hdmi_gcp,
> +=09/* The legacy AVI unit is unchanged on GB20x. */
> +=09.gsp.hdmi_infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
> +=09.gsp.hdmi_infoframe_vsi =3D gb202_sor_hdmi_infoframe_vsi,
> +};
> +
> +int
> +gb202_disp_new(struct nvkm_device *device, enum nvkm_subdev_type
> type, int inst,
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nvkm_disp **pdisp)
> +{
> +=09return r535_disp_new(&gb202_gsp_disp, device, type, inst,
> pdisp);
> +}

