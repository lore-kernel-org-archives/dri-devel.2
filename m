Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766A1C5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 22:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE64F10E962;
	Mon, 17 Aug 2026 22:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PT+1vRfZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746FD10E97A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787004327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0zCqEWjUtp6OA82xeCDRDufI5MEj5TbGUEaLnvhhSo=;
 b=PT+1vRfZ7xlBrxzBuOoLT9gLnzxDRbr1cct3UZEIQlKHZxVqTrBZtZoTS7SMpHhowQvVoT
 uJqTpYh7vgO051G4lMReXkYZwuKiGZggf+RYmD86cxpkUqmH9aVEu3ypcPW/GhIGjOjFsk
 ZbzzU4SxDYAttL4BB17GySujSnuKlQ8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-oE9GD0wxMPyQ5gR7dni69A-1; Mon, 17 Aug 2026 18:05:20 -0400
X-MC-Unique: oE9GD0wxMPyQ5gR7dni69A-1
X-Mimecast-MFC-AGG-ID: oE9GD0wxMPyQ5gR7dni69A_1787004320
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ef13b61bcso560231885a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787004320; x=1787609120;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E766Td4gI7Jjb64efynVnNkp8ShDWVNTDmV+hJtlk18=;
 b=d8+mtx/cvOqk4pzkVT6onvulxbXlSPVEW16C14zvlYg3bYDaRdjL96LSJcOONo3wQ9
 f3mciwIKGPhn7fBhJZ61S/G8RaDQ3J35ldrn3YA7e/axdXarFa8zYu3OHhjC/tLf0i++
 4f+PplA48a+viL1j8EzN5sS2fp92+/expZ0Blo+nW4W2FJwHPBOCS3l4GMzBBQRuW4Nm
 lq5idk1esJj6L2DEirDwZxneyywFQElhoIyCahsMIM194Pdb6wSIm+FDvfQgpS8PNTnh
 sIQZX1/Cdn0J+QxQ0EuadL4pBQCeyF/uOEf8/60YhZX2WvlEbCwNHITckM3VpAML9WKq
 Hs+g==
X-Gm-Message-State: AOJu0YyV5uhhLcGYmVKDF02hIhmgXolZoTcB5ummxI7kReWPJjLHmKuk
 YhoFUEqWPts7CWHmxhrI3GrxUnXy8lR+Wg6GFZ8MZJT3Lzp6K6rgLa+VuKsCFcVZrV9ru1AXAFE
 EsbfrPE5Smx3I1jHolZ3UfDB7B8ONFkYa3hW9Ag9KNMIYiFhygH5OXBbaZuk5SVFHM98nrQ==
X-Gm-Gg: AR+sD12fooN3dFQqqwlBzVCy5CB6XjkrYaL3TfeQ1RBD+O0MqyVZNvUW8+OYRS8r2hy
 WXFV5KwyLeyGpxK5yrG/yP4NEZx70+UF6auiXfdTGL9HILeWp9gI2ZcPby0ceK8abDxZCoGbGEl
 0pXR2r1paxSkgbOPsLZp77R2KKPBfe1B++5EKU5kthkVICrdCuL0rUt66ef0aIbQmFQaTGUN5Px
 dDlluzZpCeDP0e848C3B+FkdVnUIk69q1J2AZyu+IPJzPX8ao9kV0yOHY+pgTXXqOpqSFv16Hly
 xJtgxCP1fdhJyfOpZb261M9oVCh9rr/A9oLy44DlVlyYBu23DL1lqZHphFGQcxEOUxdxbv6t
X-Received: by 2002:a05:620a:5698:b0:926:e8e6:3c34 with SMTP id
 af79cd13be357-936d22aa9e8mr2397228685a.21.1787004320046; 
 Mon, 17 Aug 2026 15:05:20 -0700 (PDT)
X-Received: by 2002:a05:620a:5698:b0:926:e8e6:3c34 with SMTP id
 af79cd13be357-936d22aa9e8mr2397223685a.21.1787004319557; 
 Mon, 17 Aug 2026 15:05:19 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937033ce024sm145372885a.25.2026.08.17.15.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 15:05:18 -0700 (PDT)
Message-ID: <b5842d14094d858d875d480648ae368100102abb.camel@redhat.com>
Subject: Re: [PATCH 4/7] nouveau/gsp: use per-version DP_CONFIG_STREAM
 params on r570 firmware
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Mon, 17 Aug 2026 18:05:17 -0400
In-Reply-To: <20260814235705.59132-5-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-5-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TVY8dUR3EJ8-xlDtgRf1To_OzpiWfCx4nqIdLjwyMck_1787004320
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

On Sat, 2026-08-15 at 03:57 +0400, Mohamed Ahmed wrote:
> NVIDIA removed the deprecated actualPclkHz/linkClkFreqHz fields and
> the
> whole Legacy{activeCnt, activeFrac, activePolarity, mvidWarEnabled,
> MvidWarParams} block from the SST sub-struct of
> NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS between the 535 and 570
> releases
> (compared in OpenRM tags 535.113.01 vs 570.144), shrinking the
> struct.
>=20
> Everything nouveau writes sits at identical offsets in both layouts
> but
> the size is wrong on r570, which means r535_sor_dp_sst() and
> r535_sor_dp_vcpi() are sent with an incorrect size.
>=20
> Route the .sst/.vcpi IOR functions through nvkm_rm_api_disp the same
> way
> bl_ctrl and dp.get_caps/set_indexed_link_rates already are. Keep the
> existing implementation for r535 and add an r570 implementation built
> against the 570.144 layout, which already exists in r570/nvrm/disp.h
> but
> was unused until now. Also add the NV0073_CTRL_CMD_DP_CONFIG_STREAM
> define that was missing from the layout.
>=20
> Other DP controls sent through shared r535 code did not change layout
> between the tags.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r535/disp.c=C2=A0=C2=A0=C2=A0 | 25 +=
++++++-
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r570/disp.c=C2=A0=C2=A0=C2=A0 | 64
> +++++++++++++++++++
> =C2=A0.../nvkm/subdev/gsp/rm/r570/nvrm/disp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h=C2=A0=C2=A0 |=C2=A0 5 +=
+
> =C2=A04 files changed, 93 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index f51ad7c754d8..dd632767aea5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -403,7 +403,7 @@ r535_sor_dp_audio(struct nvkm_ior *sor, int head,
> bool enable)
> =C2=A0}
> =C2=A0
> =C2=A0static void
> -r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8
> slot_nr, u16 pbn, u16 aligned_pbn)
> +r535_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr,
> u16 pbn, u16 aligned_pbn)
> =C2=A0{
> =C2=A0=09struct nvkm_disp *disp =3D sor->disp;
> =C2=A0=09struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
> @@ -434,9 +434,17 @@ r535_sor_dp_vcpi(struct nvkm_ior *sor, int head,
> u8 slot, u8 slot_nr, u16 pbn, u
> =C2=A0=09WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
> =C2=A0}
> =C2=A0
> +static void
> +r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8
> slot_nr, u16 pbn, u16 aligned_pbn)
> +{
> +=09const struct nvkm_rm_api *rmapi =3D sor->disp-
> >engine.subdev.device->gsp->rm->api;
> +
> +=09rmapi->disp->dp.vcpi(sor, head, slot, slot_nr, pbn,
> aligned_pbn);
> +}
> +
> =C2=A0static int
> -r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
> -=09=09u32 watermark, u32 hblanksym, u32 vblanksym)
> +r535_dp_sst(struct nvkm_ior *sor, int head, bool ef,
> +=09=C2=A0=C2=A0=C2=A0 u32 watermark, u32 hblanksym, u32 vblanksym)
> =C2=A0{
> =C2=A0=09struct nvkm_disp *disp =3D sor->disp;
> =C2=A0=09struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
> @@ -463,6 +471,15 @@ r535_sor_dp_sst(struct nvkm_ior *sor, int head,
> bool ef,
> =C2=A0=09return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
> =C2=A0}
> =C2=A0
> +static int
> +r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
> +=09=09u32 watermark, u32 hblanksym, u32 vblanksym)
> +{
> +=09const struct nvkm_rm_api *rmapi =3D sor->disp-
> >engine.subdev.device->gsp->rm->api;
> +
> +=09return rmapi->disp->dp.sst(sor, head, ef, watermark,
> hblanksym, vblanksym);
> +}
> +
> =C2=A0static const struct nvkm_ior_func_dp
> =C2=A0r535_sor_dp =3D {
> =C2=A0=09.sst =3D r535_sor_dp_sst,
> @@ -1828,6 +1845,8 @@ r535_disp =3D {
> =C2=A0=09.dp =3D {
> =C2=A0=09=09.get_caps =3D r535_dp_get_caps,
> =C2=A0=09=09.set_indexed_link_rates =3D
> r535_dp_set_indexed_link_rates,
> +=09=09.sst =3D r535_dp_sst,
> +=09=09.vcpi =3D r535_dp_vcpi,
> =C2=A0=09},
> =C2=A0=09.chan =3D {
> =C2=A0=09=09.set_pushbuf =3D r535_disp_chan_set_pushbuf,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
> index a96e31c2d80b..61f82e15ff39 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
> @@ -5,6 +5,7 @@
> =C2=A0#include <rm/rm.h>
> =C2=A0
> =C2=A0#include <engine/disp.h>
> +#include <engine/disp/ior.h>
> =C2=A0#include <engine/disp/outp.h>
> =C2=A0
> =C2=A0#include "nvhw/drf.h"
> @@ -74,6 +75,67 @@ r570_disp_chan_set_pushbuf(struct nvkm_disp *disp,
> s32 oclass, int inst, struct
> =C2=A0=09return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice,
> ctrl);
> =C2=A0}
> =C2=A0
> +static void
> +r570_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr,
> u16 pbn, u16 aligned_pbn)
> +{
> +=09struct nvkm_disp *disp =3D sor->disp;
> +=09NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
> +
> +=09ctrl =3D nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0
> NV0073_CTRL_CMD_DP_CONFIG_STREAM, sizeof(*ctrl));
> +=09if (WARN_ON(IS_ERR(ctrl)))
> +=09=09return;
> +
> +=09ctrl->subDeviceInstance =3D 0;
> +=09ctrl->head =3D head;
> +=09ctrl->sorIndex =3D sor->id;
> +=09ctrl->dpLink =3D sor->asy.link =3D=3D 2;
> +=09ctrl->bEnableOverride =3D 1;
> +=09ctrl->bMST =3D 1;
> +=09ctrl->hBlankSym =3D 0;
> +=09ctrl->vBlankSym =3D 0;
> +=09ctrl->colorFormat =3D 0;
> +=09ctrl->bEnableTwoHeadOneOr =3D 0;
> +=09ctrl->singleHeadMultistreamMode =3D 0;
> +=09ctrl->MST.slotStart =3D slot;
> +=09ctrl->MST.slotEnd =3D slot + slot_nr - 1;
> +=09ctrl->MST.PBN =3D pbn;
> +=09ctrl->MST.Timeslice =3D aligned_pbn;
> +=09ctrl->MST.sendACT =3D 0;
> +=09ctrl->MST.singleHeadMSTPipeline =3D 0;
> +=09ctrl->MST.bEnableAudioOverRightPanel =3D 0;
> +=09WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
> +}

Should we maybe just update this function so that it has a return value
rather than doing the WARN_ONs explicitly under the HAL? Seems more in
line with what we do elsewhere, even if the only action the caller ends
up taking in response is printing a kernel warning.

> +
> +static int
> +r570_dp_sst(struct nvkm_ior *sor, int head, bool ef,
> +=09=C2=A0=C2=A0=C2=A0 u32 watermark, u32 hblanksym, u32 vblanksym)
> +{
> +=09struct nvkm_disp *disp =3D sor->disp;
> +=09NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
> +
> +=09ctrl =3D nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0
> NV0073_CTRL_CMD_DP_CONFIG_STREAM, sizeof(*ctrl));
> +=09if (IS_ERR(ctrl))
> +=09=09return PTR_ERR(ctrl);
> +
> +=09ctrl->subDeviceInstance =3D 0;
> +=09ctrl->head =3D head;
> +=09ctrl->sorIndex =3D sor->id;
> +=09ctrl->dpLink =3D sor->asy.link =3D=3D 2;
> +=09ctrl->bEnableOverride =3D 1;
> +=09ctrl->bMST =3D 0;
> +=09ctrl->hBlankSym =3D hblanksym;
> +=09ctrl->vBlankSym =3D vblanksym;
> +=09ctrl->colorFormat =3D 0;
> +=09ctrl->bEnableTwoHeadOneOr =3D 0;
> +=09ctrl->SST.bEnhancedFraming =3D ef;
> +=09ctrl->SST.tuSize =3D 64;
> +=09ctrl->SST.waterMark =3D watermark;
> +=09ctrl->SST.bEnableAudioOverRightPanel =3D 0;
> +=09return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
> +}
> +
> =C2=A0static int
> =C2=A0r570_dp_set_indexed_link_rates(struct nvkm_outp *outp)
> =C2=A0{
> @@ -255,6 +317,8 @@ r570_disp =3D {
> =C2=A0=09.dp =3D {
> =C2=A0=09=09.get_caps =3D r570_dp_get_caps,
> =C2=A0=09=09.set_indexed_link_rates =3D
> r570_dp_set_indexed_link_rates,
> +=09=09.sst =3D r570_dp_sst,
> +=09=09.vcpi =3D r570_dp_vcpi,
> =C2=A0=09},
> =C2=A0=09.chan =3D {
> =C2=A0=09=09.set_pushbuf =3D r570_disp_chan_set_pushbuf,
> diff --git
> a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h
> index 06e972835d77..742b25a2a12d 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h
> @@ -256,6 +256,8 @@ typedef struct NV0073_CTRL_DP_CTRL_PARAMS {
> =C2=A0=C2=A0=C2=A0=C2=A0 NvU32 eightLaneDpcdBaseAddr;
> =C2=A0} NV0073_CTRL_DP_CTRL_PARAMS;
> =C2=A0
> +#define NV0073_CTRL_CMD_DP_CONFIG_STREAM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0
> (0x731362U) /* finn: Evaluated from
> "(FINN_NV04_DISPLAY_COMMON_DP_INTERFACE_ID << 8) |
> NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS_MESSAGE_ID" */
> +
> =C2=A0typedef struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS {
> =C2=A0=C2=A0=C2=A0=C2=A0 NvU32=C2=A0 subDeviceInstance;
> =C2=A0=C2=A0=C2=A0=C2=A0 NvU32=C2=A0 head;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
> index a9af94adf9ef..e0c10a7e3452 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
> @@ -6,6 +6,7 @@
> =C2=A0#ifndef __NVKM_RM_H__
> =C2=A0#define __NVKM_RM_H__
> =C2=A0#include "handles.h"
> +struct nvkm_ior;
> =C2=A0struct nvkm_outp;
> =C2=A0struct r535_gr;
> =C2=A0
> @@ -93,6 +94,10 @@ struct nvkm_rm_api {
> =C2=A0=09=09struct {
> =C2=A0=09=09=09int (*get_caps)(struct nvkm_disp *, int
> *link_bw, bool *mst, bool *wm);
> =C2=A0=09=09=09int (*set_indexed_link_rates)(struct
> nvkm_outp *);
> +=09=09=09int (*sst)(struct nvkm_ior *, int head, bool
> ef,
> +=09=09=09=09=C2=A0=C2=A0 u32 watermark, u32 hblanksym, u32
> vblanksym);
> +=09=09=09void (*vcpi)(struct nvkm_ior *, int head,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 u8 slot, u8 slot_nr, u16 pbn,
> u16 aligned_pbn);
> =C2=A0=09=09} dp;
> =C2=A0
> =C2=A0=09=09struct {

