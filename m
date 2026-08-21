Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13EFC5DF97
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 22:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A1410F3C8;
	Fri, 21 Aug 2026 22:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fae0vF4x";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B3E610F3CA
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 22:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787349738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+aF5SWpzj0IMMiUIe2sX0uwtLDyPi9UzPsNgctanKk=;
 b=fae0vF4xhjxAQvPbLUxlJICsIAAtYV8MEzZXmZtJNdPqR0ablqSjMG/G0usDFG5xFDRHxZ
 OSIZfvI1K7shNiIMTDLAN95LjqckZY08ermcd3dEQRyfWik3OvqfwP8FqYZnBkelM8+Qpi
 tTmTu2f+Ea1/V1zqowROzJ2hy+hsbUE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-VsZ5pxl9MnatTraGpUGLww-1; Fri, 21 Aug 2026 18:02:17 -0400
X-MC-Unique: VsZ5pxl9MnatTraGpUGLww-1
X-Mimecast-MFC-AGG-ID: VsZ5pxl9MnatTraGpUGLww_1787349737
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bf321d786so13552721cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787349737; x=1787954537;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7JvFgvcNT0JoaQlZJf2gAQv9c8TyqYAeQTsUG3MJuR4=;
 b=jpscGv42T6iiVWnIzT9ikorInuAZKWqMVaCkei22PZnTcGHwfB+1xDUcUublCY2XwX
 2E0BRKLbdTUgDDzPTuYuvc2vMkCwebnofvOFovksTI1zz3yFdarsvVbM52mCt0YtY0Wx
 V355W3fwHs+F885a6v2/6rs4eCajX/1o3+0ogIjKHigoI2HV9BUH9r0H9Vddqiomds9Y
 E0Aqe8JGigchYWZqQcBc4N/unhCHsdkTWOVtcx8GJvD3e0BIN3dJseLFTgq56RZHQG7c
 zCOkNnlubcmNVgoqNDl/JxuSEYuxf4aqzCOQsg7OT9L6uLZlLUKilGVM+HVAhUm/Hha9
 q6jQ==
X-Gm-Message-State: AFuF++kSEXyz+tjI6WYS24tVKYAIsAzgILT9ljpxgl7sRFK9IKbhPnx2
 L1rFxVfGhRVUuRucp2E4o2AG86wWaKZapTgBLnHGendIpU1VF3nBC7xzYAzajVTXTGXlgbHvn0n
 mF20LDQhaAFzNmKhtaIyfHh+Ohcu+6T0XohFibdl3hLPKz/N3TdYhsG7sismD+3Gf1Fyprw==
X-Gm-Gg: AR+sD116JO+/b9gx6z2mV5pneE1lvbabqQ/+C7iaosP/+l1v9jj4jGuIn31qMr8EGAX
 oq/QBRc5nYbFlYvzF7/KMURX0Km7wvug+bVMMT7Q5E0Az1AysVMSd+TbcPDuKw4U1jllv/7InVg
 fp/FSn7R8KbOMvHTZZdKZ4JVBTtnTp6vSVQ1SrbtGT42eAR2dDWtCv6PUpAX7hF6hjEWeWhKKou
 d/ORt6lSKQLV4o4UHEjpGPhouOoGqpsXd1vOIskpBRJrrmzphTpO8Om9QzdMCJPqzp0NsiTeHxm
 TFbahAaDrAfNbRuwcqOHaXD41J9WRVIEHVKJhbVdQIBvNrXhvFJ2j9XsT41C3obXyISlUIKB
X-Received: by 2002:a05:622a:5a12:b0:528:3882:386a with SMTP id
 d75a77b69052e-52df572d755mr93022771cf.11.1787349736387; 
 Fri, 21 Aug 2026 15:02:16 -0700 (PDT)
X-Received: by 2002:a05:622a:5a12:b0:528:3882:386a with SMTP id
 d75a77b69052e-52df572d755mr93021811cf.11.1787349735880; 
 Fri, 21 Aug 2026 15:02:15 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e099a8331sm3893421cf.9.2026.08.21.15.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 15:02:14 -0700 (PDT)
Message-ID: <b91ad24281d52efd681f24e7f954f684104a84a7.camel@redhat.com>
Subject: Re: [PATCH v2 06/10] drm/nouveau/gsp: use per-version
 DP_CONFIG_STREAM params on r570 firmware
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 18:02:14 -0400
In-Reply-To: <20260820164929.17117-7-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-7-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZnEx9dmdu81K5Fe8g6OfTKKY10LIIEmBw6lLODzK4o4_1787349737
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

We should probably Cc this to stable. With that fixed:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
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
> except the trailing SST.bEnableAudioOverRightPanel (written as zero),
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
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r535/disp.c=C2=A0=C2=A0=C2=A0 | 33 +=
+++++++--
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r570/disp.c=C2=A0=C2=A0=C2=A0 | 64
> +++++++++++++++++++
> =C2=A0.../nvkm/subdev/gsp/rm/r570/nvrm/disp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h=C2=A0=C2=A0 |=C2=A0 5 +=
+
> =C2=A04 files changed, 97 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index f3e55253bcbc..3a8ff621ed62 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -400,16 +400,16 @@ r535_sor_dp_audio(struct nvkm_ior *sor, int
> head, bool enable)
> =C2=A0=09=09r535_sor_dp_audio_mute(sor, false);
> =C2=A0}
> =C2=A0
> -static void
> -r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8
> slot_nr, u16 pbn, u16 aligned_pbn)
> +static int
> +r535_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr,
> u16 pbn, u16 aligned_pbn)
> =C2=A0{
> =C2=A0=09struct nvkm_disp *disp =3D sor->disp;
> =C2=A0=09struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
> =C2=A0
> =C2=A0=09ctrl =3D nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0
> NV0073_CTRL_CMD_DP_CONFIG_STREAM, sizeof(*ctrl));
> -=09if (WARN_ON(IS_ERR(ctrl)))
> -=09=09return;
> +=09if (IS_ERR(ctrl))
> +=09=09return PTR_ERR(ctrl);
> =C2=A0
> =C2=A0=09ctrl->subDeviceInstance =3D 0;
> =C2=A0=09ctrl->head =3D head;
> @@ -429,12 +429,20 @@ r535_sor_dp_vcpi(struct nvkm_ior *sor, int
> head, u8 slot, u8 slot_nr, u16 pbn, u
> =C2=A0=09ctrl->MST.sendACT =3D 0;
> =C2=A0=09ctrl->MST.singleHeadMSTPipeline =3D 0;
> =C2=A0=09ctrl->MST.bEnableAudioOverRightPanel =3D 0;
> -=09WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
> +=09return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
> +}
> +
> +static void
> +r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8
> slot_nr, u16 pbn, u16 aligned_pbn)
> +{
> +=09const struct nvkm_rm_api *rmapi =3D sor->disp-
> >engine.subdev.device->gsp->rm->api;
> +
> +=09WARN_ON(rmapi->disp->dp.vcpi(sor, head, slot, slot_nr, pbn,
> aligned_pbn));
> =C2=A0}
> =C2=A0
> =C2=A0static int
> -r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
> -=09=09u32 watermark, u32 hblanksym, u32 vblanksym)
> +r535_dp_sst(struct nvkm_ior *sor, int head, bool ef,
> +=09=C2=A0=C2=A0=C2=A0 u32 watermark, u32 hblanksym, u32 vblanksym)
> =C2=A0{
> =C2=A0=09struct nvkm_disp *disp =3D sor->disp;
> =C2=A0=09struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
> @@ -461,6 +469,15 @@ r535_sor_dp_sst(struct nvkm_ior *sor, int head,
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
> @@ -1771,6 +1788,8 @@ r535_disp =3D {
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
> index a96e31c2d80b..8a23837f356e 100644
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
> +static int
> +r570_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr,
> u16 pbn, u16 aligned_pbn)
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
> +=09return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
> +}
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
> index 0fb0e67406c6..e9ac47d86b69 100644
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
> +=09=09=09int (*vcpi)(struct nvkm_ior *, int head,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 u8 slot, u8 slot_nr, u16 pbn,
> u16 aligned_pbn);
> =C2=A0=09=09} dp;
> =C2=A0
> =C2=A0=09=09struct {

