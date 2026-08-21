Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAD3C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 22:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 771E610E37D;
	Fri, 21 Aug 2026 22:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eVXHc/4r";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699C410F3D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 22:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787350350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZATu8m33dNIkK0AIGWEAmOkLpOfsVEyZx202Lm97Oos=;
 b=eVXHc/4r3gt52x0pPddQq2diVsw54RdlVusDSUao5qaJvs1JepZVPm37GYEulKWXDO9FSB
 kkuGVbe52F72WMdbDg3waGl0M2TnYS77AxYCeGx4dd+dG1ecT4CxD8LCQ+LajpJh5jh4W7
 OGsypoyWBlm4jIlHtl9XPRz9ymW6p10=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-CBc8vwgRN7KDTjV1o-Bw1A-1; Fri, 21 Aug 2026 18:12:29 -0400
X-MC-Unique: CBc8vwgRN7KDTjV1o-Bw1A-1
X-Mimecast-MFC-AGG-ID: CBc8vwgRN7KDTjV1o-Bw1A_1787350349
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so251722985a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787350349; x=1787955149;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I0eUZt+KIoHEj0to+icRP80gEEgroNZ4RZo6TFwXBQ8=;
 b=kzq9uttOGLckBITYY5BQYT7YcEfpnVm79Iur2jIFRQLWm1QcAzE0x7fcu8O0fMaHA0
 avYYcNgpJfqe6hVpoGkhzxM7Z0Zp1H8rCeFBV4kU1pFUCZBQLw4+7qm3rpJdV0KnFaWG
 rsmvHQKbO6jS4X6LGrBz9V9gZ1zQQd9aQ4hAYhPmGcFdViy9o8XFd3uW3BQ6EGyKyeAo
 6lfIWEX/5il2AODFnQf1GUt0VBU7rTDEqyZwA+QL/pyB8SeaLsAID2aP820NJVeqshQI
 fCCroEnOkPtTHDrwJXRkKIa9GuCQ3ZTnehEMwGvfsp7xl1YPY+YHuQlPij8Fpu952boa
 PFHQ==
X-Gm-Message-State: AFuF++nxBFIn014jhnUVOu0tvLeG8VKBO1NUkclTixP2dG9dZjr8EwWm
 jZeqzsY9tiy95kI2hg1eh+pAjmNOONP5sjvf4zv2f5OihD9zyHT7ujQ3Vf7N0ACm3kN0jim+xfn
 Q99ySD581mNbbRnMCGDrzTrpiyYgZ2yPhRypH9F2lE3dNMwRyzOsX/HjYiFvwSwvHt2No9g==
X-Gm-Gg: AR+sD13UGTIir7FgI82dxfx5uN2gnqeWbjlLzeKx/XNXBK8OFqYSfDrqyEdyHIINt6j
 c3xkOTsrvLTkG1FzDfS7SQwT9Xn3/Lw2gb4TQarUU1SdbXq9AVPgmVojrPslErW0WCVfMRfxtIE
 +g7ofhp7SlPMcVTbXrBZcmdGPXW9ovUfG+Zl198ghkPmw4gBc5dDnDj1iBGDOTQGetYS+Osjjcd
 adatp3NiKpy7zwFZlsr+8GKayGN+PO0IkK+scA9CPe9JRF2fQg/Asysmja/0x8olDUEQHi5Jg7S
 eMdyNT87F6FAmcyMM+66K7FZWv8Cet05PdLZPypyTKX3EcUE+iJNPMuSLdIQbJVIQctcu9bu
X-Received: by 2002:ae9:e50d:0:b0:92e:5444:9274 with SMTP id
 af79cd13be357-937395378e7mr667906885a.30.1787350348746; 
 Fri, 21 Aug 2026 15:12:28 -0700 (PDT)
X-Received: by 2002:ae9:e50d:0:b0:92e:5444:9274 with SMTP id
 af79cd13be357-937395378e7mr667902985a.30.1787350348297; 
 Fri, 21 Aug 2026 15:12:28 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93749da8294sm7974085a.32.2026.08.21.15.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 15:12:27 -0700 (PDT)
Message-ID: <33cd07ffe8f6a9c525f9d9b6d646efbf09cf76e9.camel@redhat.com>
Subject: Re: [PATCH v2 08/10] drm/nouveau/gsp: fix vblank interrupts on GB20x
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 18:12:26 -0400
In-Reply-To: <20260820164929.17117-9-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-9-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dTHLaaTvnuLl-70nU8k_xvgxZDT_TcAqMdpVZGDjCKM_1787350349
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

Some comments regarding both patch #2 and this patch below:


On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
> The GSP path programs per-head timing (vblank) interrupts the same
> way on
> every generation. NVD5.0 (GB20x) reworked the FE interrupt frontend
> around four message-based kernel vectors (high latency, low latency,
> PMU,
> and GSP) and moved RM head-timing interrupts to the dedicated low-
> latency
> vector:
>=20
> =C2=A0- The enable is NV_PDISP_FE_RM_INTR_EN1_HEAD_TIMING, 0x611ef0 +
> =C2=A0=C2=A0 head*4 (570.144 kernel_head_0501.c, renamed kernel_head_0502=
.c
> from
> =C2=A0=C2=A0 575.51.02 on, and v05_01 dev_disp.h).
>=20
> =C2=A0- The vector is reported as a separate interrupt table entry,
> =C2=A0=C2=A0 MC_ENGINE_IDX_DISP_LOW (intr_gb202.c, intrCacheDispIntrVecto=
rs).
>=20
> =C2=A0- The vector must be re-armed through NV_PDISP_FE_INTR_RETRIGGER(1)
> =C2=A0=C2=A0 at 0x611f34 after servicing (kdispServiceInterrupt ->
> =C2=A0=C2=A0 kdispIntrRetrigger_v05_01).
>=20
> The event latch (0x611800), per-head status (0x611c00), and dispatch
> summary (0x611ec0) the interrupt handler uses are unchanged on GB20x
> (kheadReadPendingVblank_v03_00 and kheadResetPendingLastData_v03_00
> remain for DISPv0502+).
>=20
> On GB20x the old code enables head timing onto the legacy vector,
> leaves
> its handler there, and never re-arms the message-based vectors. Page
> flips still complete (nv50 sends those events from the commit path),
> so
> the desktop looks fine while DRM vblank waits and vblank sequence
> queries
> are affected.
>=20
> Supply GB20x vblank enables and an interrupt handler that re-arms the
> vector after servicing through gb202_gsp_disp, translate the low-
> latency
> interrupt table entry as a second NVKM_ENGINE_DISP instance, and flag
> the table so r535_disp_oneinit() attaches the handler to that
> instance.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/gb202.c=C2=A0 | 42
> +++++++++++++++++--
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r535/disp.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 5 ++-
> =C2=A0.../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |=C2=A0 9 ++++
> =C2=A03 files changed, 52 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> index a66c820be9fe..f78669bafd64 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> @@ -130,6 +130,40 @@ gb202_head_state(struct nvkm_head *head, struct
> nvkm_head_state *state)
> =C2=A0=09}
> =C2=A0}
> =C2=A0
> +/* NVD5.0 (GB20x and later) moved the RM head-timing interrupt
> enable to
> + * the low-latency vector's EN1 block. The event latch is unchanged.
> + */
> +static void
> +gb202_head_vblank_put(struct nvkm_head *head)
> +{
> +=09struct nvkm_device *device =3D head->disp-
> >engine.subdev.device;
> +
> +=09nvkm_mask(device, 0x611ef0 + (head->id * 4), 0x00000002,
> 0x00000000);
> +}
> +
> +static void
> +gb202_head_vblank_get(struct nvkm_head *head)
> +{
> +=09struct nvkm_device *device =3D head->disp-
> >engine.subdev.device;
> +
> +=09nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
> +=09nvkm_mask(device, 0x611ef0 + (head->id * 4), 0x00000002,
> 0x00000002);
> +}
> +
> +static irqreturn_t
> +gb202_disp_intr(struct nvkm_inth *inth)
> +{
> +=09struct nvkm_disp *disp =3D container_of(inth, typeof(*disp),
> engine.subdev.inth);
> +=09irqreturn_t ret =3D tu102_disp_intr(inth);
> +
> +=09/* The FE interrupt vectors are message-based on NVD5.0. Re-
> arm the
> +=09 * low-latency vector so it fires again for any event that
> latched
> +=09 * while we were servicing.
> +=09 */
> +=09nvkm_wr32(disp->engine.subdev.device, 0x611f34, 0x00000001);
> +=09return ret;
> +}
> +
> =C2=A0/* GB20x is GSP-only. This table supplies the register programming
> the
> =C2=A0 * GSP-RM display path needs from the chip.
> =C2=A0 */
> @@ -137,11 +171,13 @@ static const struct nvkm_disp_func
> =C2=A0gb202_gsp_disp =3D {
> =C2=A0=09.uevent =3D &gv100_disp_chan_uevent,
> =C2=A0=09.ramht_size =3D 0x2000,
> -=09.gsp.intr =3D tu102_disp_intr,
> +=09/* Head timing arrives on the dedicated low-latency vector.
> */
> +=09.gsp.intr =3D gb202_disp_intr,
> +=09.gsp.intr_low_latency =3D true,
> =C2=A0=09.gsp.head_state =3D gb202_head_state,
> =C2=A0=09.gsp.head_rgpos =3D gv100_head_rgpos,
> -=09.gsp.vblank_get =3D tu102_head_vblank_get,
> -=09.gsp.vblank_put =3D tu102_head_vblank_put,
> +=09.gsp.vblank_get =3D gb202_head_vblank_get,
> +=09.gsp.vblank_put =3D gb202_head_vblank_put,
> =C2=A0=09.gsp.hdmi_gcp =3D gb202_sor_hdmi_gcp,
> =C2=A0=09/* The legacy AVI unit is unchanged on GB20x. */
> =C2=A0=09.gsp.hdmi_infoframe_avi =3D gv100_sor_hdmi_infoframe_avi,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index 3a8ff621ed62..a95f78c4502f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -1705,7 +1705,10 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> =C2=A0
> =C2=A0=09/* Chips that raise head-timing interrupts on a separate
> low-latency
> =C2=A0=09 * vector report it as a second DISP interrupt table entry,
> exposed
> -=09 * as instance 1 by the RM engine-index translation.
> +=09 * as instance 1 by the RM engine-index translation (see
> +=09 * r570_gsp_xlat_mc_engine_idx()). Their high-latency vector
> +=09 * (instance 0) is left unhandled as no event nouveau
> enables is
> +=09 * routed to it, and without a handler it stays masked.
> =C2=A0=09 */

I didn't notice it until I got to this patch, but is it possible you
mistakenly added the intr_low_latency stuff a little early with patch
#2 and meant to add it here?

(doesn't matter to me too much either way, whatever you intended works
fine with me)

Otherwise:

Reviewed-by: Lyude Paul <lyude@redhat.com>

> =C2=A0=09ret =3D nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
> =C2=A0=09=09=09=09=C2=A0 disp->func->gsp.intr_low_latency ?
> 1 : disp->engine.subdev.inst);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> index 3e391646d8f7..b45781cd0dfd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> @@ -44,6 +44,15 @@ r570_gsp_xlat_mc_engine_idx(u32 mc_engine_idx,
> enum nvkm_subdev_type *ptype, int
> =C2=A0=09=09*ptype =3D NVKM_ENGINE_DISP;
> =C2=A0=09=09*pinst =3D 0;
> =C2=A0=09=09return true;
> +=09case MC_ENGINE_IDX_DISP_LOW:
> +=09=09/* GB20x+ report a separate low-latency display
> vector, used
> +=09=09 * for head-timing interrupts. Expose it as a second
> DISP
> +=09=09 * interrupt instance. r535_disp_oneinit() attaches
> the
> +=09=09 * handler to it when the chip's
> gsp.intr_low_latency is set.
> +=09=09 */
> +=09=09*ptype =3D NVKM_ENGINE_DISP;
> +=09=09*pinst =3D 1;
> +=09=09return true;
> =C2=A0=09case MC_ENGINE_IDX_CE0 ... MC_ENGINE_IDX_CE19:
> =C2=A0=09=09*ptype =3D NVKM_ENGINE_CE;
> =C2=A0=09=09*pinst =3D mc_engine_idx - MC_ENGINE_IDX_CE0;

