Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA3AC5DF97
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E5D10E36B;
	Fri, 21 Aug 2026 21:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="SkY99Ifx";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC68F10E36B
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787347894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pr8d0fOTk7HJ92WIwFvUNvFQngG76dHS9ck0/MtLkMs=;
 b=SkY99IfxbyfCag4EnAuLeARxMk6SOTaJxzMR+j9U7/o3Zr+jicHrCF7YIaBHLrlwLeX8ou
 5Z+xWbk22uFVLvKEBZx4ETLCwMLwchjFe+1MVqSLyYbxhB6J9ChXoFRRuyqINzfkLrr1bq
 482gGag9xlVjS/uBFmFGRY7jZhR3Gu4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-TkKWSaq6MvuOd2V5AD_jgQ-1; Fri, 21 Aug 2026 17:31:33 -0400
X-MC-Unique: TkKWSaq6MvuOd2V5AD_jgQ-1
X-Mimecast-MFC-AGG-ID: TkKWSaq6MvuOd2V5AD_jgQ_1787347893
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f1e4e0eac1so11512026d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787347893; x=1787952693;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+lJHW5Uuf0wtGywk/XA4axlvgeXcz2UVQQ73YnPogIk=;
 b=M6cSBcOpIMTwhSjC3l3moGh6r5cpKpQ+xy2YrOpViaQNBLMLDDYAwQmFWD4x4X3sCO
 MnWdxr+4ovoL/QX0+ldi7Vq9ZjxPrAm9PWSEn5YTpbijeyTz8/BTitismhh1YIEgOwyd
 6q5zX1dDJP50IHM6mY2EjVvS1S1Cghtcl8DjOvlne7z/MEelTsAfKlrYwVjwsrmMs+Bg
 /JTcrCd9GMef+T6znLaGAL5vF+FK7+hQOQvgHVK/rSULSS5EGx/F5PnEijbI13R+wDvX
 RCLjVvy7aCPOSnpx+X+NNUqQuybid9zADz7jjyY9oZkV1qwArDYFvVQjQ8vHFYji2YcZ
 sgQQ==
X-Gm-Message-State: AFuF++mm7TsYBfaZYOavLpjoS6Hs7492m7Hhs4gE3XKnnvn2uCgL3mYP
 rHINQS6IxOje9L4YSOxVr4JZlGqCSdeU12FCmLbsN7pBv/Kn62hdjpajazGTT4tfYH7FM9Grb/B
 xGxh7ARaZJd+vWGqHMfLX23cGTAU8Bw8Cw8W/ZKuUtwEIX8q+wSiTZLzmfbKQBwoiZ6GLVA==
X-Gm-Gg: AR+sD13XV5r6n2mCZyWc3WAzonuavDPaVC0V4zgzCl2OmLgrxgDM3e6nZQ8mfkCrqDJ
 vrfv/gdP+yuCg1jF9YZDGzxZhBJoZUsTUP4ilI/+pZoxRMXoVxNRzoxSlSNHy2F1i9VNi/0dE53
 0RFCHpkfufKOwJ408Lu98YnBf8rUf9SDT1QcgseyE9zSJeQAx3Mj7fqTz5Y1Vy3ZjjYFjxMCIvJ
 t/rnSM05YdcYWzNlvff67bSda9tPBtGvsvVTQDpipQrD9NQaW7a9blVDWbnNCjv10WnHx5L/YNr
 fiRo+D4NcWlFsXIDaOxd/tCkC9KLjfKxkvIwfBfAS/ERlN5EY+nMoLdsPUAtfnWpthyefziJ
X-Received: by 2002:a05:6214:cc5:b0:8cc:d29:9f73 with SMTP id
 6a1803df08f44-90c80c661f8mr90295486d6.21.1787347892624; 
 Fri, 21 Aug 2026 14:31:32 -0700 (PDT)
X-Received: by 2002:a05:6214:cc5:b0:8cc:d29:9f73 with SMTP id
 6a1803df08f44-90c80c661f8mr90295106d6.21.1787347892151; 
 Fri, 21 Aug 2026 14:31:32 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2906afsm71653306d6.25.2026.08.21.14.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 14:31:31 -0700 (PDT)
Message-ID: <e90f41a9449e13f5ace29a647af6f64c2d302655.camel@redhat.com>
Subject: Re: [PATCH v2 01/10] drm/nouveau/disp: move GSP head-timing ISR and
 vblank helpers to tu102.c
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 17:31:30 -0400
In-Reply-To: <20260820164929.17117-2-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-2-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K1TKw-K__ejLbxTvaPMrwk9DlL8-ewQvsh6RlyeYGhs_1787347893
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
> The GSP-RM display code in rm/r535/disp.c owns a handful of direct
> MMIO
> routines: the head-timing (vblank) interrupt handler and the per-head
> vblank enable/disable. They program display registers, not RM, so
> they
> belong with the rest of the per-chip register code in engine/disp/.
>=20
> Move them to tu102.c (Turing is the first GSP-capable generation) as
> tu102_disp_intr() and tu102_head_vblank_get()/put(), exported for
> rm/r535/disp.c, which keeps calling them by name for now. No
> functional
> change.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/head.h=C2=A0=C2=A0 |=C2=A0 3 +=
+
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/priv.h=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/tu102.c=C2=A0 | 50
> ++++++++++++++++++
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r535/disp.c=C2=A0=C2=A0=C2=A0 | 52 +=
+---------------
> --
> =C2=A04 files changed, 57 insertions(+), 49 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> index b642729c254f..986043e87554 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> @@ -56,6 +56,9 @@ int gv100_head_new(struct nvkm_disp *, int id);
> =C2=A0void gv100_head_state(struct nvkm_head *head, struct nvkm_head_stat=
e
> *state);
> =C2=A0void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16
> *vline);
> =C2=A0
> +void tu102_head_vblank_get(struct nvkm_head *);
> +void tu102_head_vblank_put(struct nvkm_head *);
> +
> =C2=A0#define HEAD_MSG(h,l,f,a...) do
> {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=09struct nvkm_head *_h =3D
> (h);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=09nvkm_##l(&_h->disp->engine.subdev, "head-%d: "f"\n", _h->id,
> ##a);=C2=A0=C2=A0=C2=A0=C2=A0 \
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
> index a3fd7cb7c488..722ec340e12a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
> @@ -72,6 +72,7 @@ int gv100_disp_wndw_cnt(struct nvkm_disp *,
> unsigned long *);
> =C2=A0int gv100_disp_caps_new(const struct nvkm_oclass *, void *, u32,
> struct nvkm_object **);
> =C2=A0
> =C2=A0int tu102_disp_init(struct nvkm_disp *);
> +irqreturn_t tu102_disp_intr(struct nvkm_inth *);
> =C2=A0
> =C2=A0void nv50_disp_dptmds_war_2(struct nvkm_disp *, struct dcb_output
> *);
> =C2=A0void nv50_disp_dptmds_war_3(struct nvkm_disp *, struct dcb_output
> *);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
> index dcb9f8ba374c..7b70b466fa36 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
> @@ -104,6 +104,56 @@ tu102_sor_new(struct nvkm_disp *disp, int id)
> =C2=A0=09return nvkm_ior_new_(&tu102_sor, disp, SOR, id, hda &
> BIT(id));
> =C2=A0}
> =C2=A0
> +/* The GSP-RM display path leaves head-timing (vblank) interrupts
> and their
> + * enables to us. These program the RM head-timing line (bit 1 of
> the
> + * per-head enable, not the bit nvkm's own gv100 path uses).
> + */
> +void
> +tu102_head_vblank_put(struct nvkm_head *head)
> +{
> +=09struct nvkm_device *device =3D head->disp-
> >engine.subdev.device;
> +
> +=09nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002,
> 0x00000000);
> +}
> +
> +void
> +tu102_head_vblank_get(struct nvkm_head *head)
> +{
> +=09struct nvkm_device *device =3D head->disp-
> >engine.subdev.device;
> +
> +=09nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
> +=09nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002,
> 0x00000002);
> +}
> +
> +static void
> +tu102_disp_intr_head_timing(struct nvkm_disp *disp, int head)
> +{
> +=09struct nvkm_subdev *subdev =3D &disp->engine.subdev;
> +=09struct nvkm_device *device =3D subdev->device;
> +=09u32 stat =3D nvkm_rd32(device, 0x611c00 + (head * 0x04));
> +
> +=09if (stat & 0x00000002) {
> +=09=09nvkm_disp_vblank(disp, head);
> +
> +=09=09nvkm_wr32(device, 0x611800 + (head * 0x04),
> 0x00000002);
> +=09}
> +}
> +
> +irqreturn_t
> +tu102_disp_intr(struct nvkm_inth *inth)
> +{
> +=09struct nvkm_disp *disp =3D container_of(inth, typeof(*disp),
> engine.subdev.inth);
> +=09struct nvkm_subdev *subdev =3D &disp->engine.subdev;
> +=09struct nvkm_device *device =3D subdev->device;
> +=09unsigned long mask =3D nvkm_rd32(device, 0x611ec0) &
> 0x000000ff;
> +=09int head;
> +
> +=09for_each_set_bit(head, &mask, 8)
> +=09=09tu102_disp_intr_head_timing(disp, head);
> +
> +=09return IRQ_HANDLED;
> +}
> +
> =C2=A0int
> =C2=A0tu102_disp_init(struct nvkm_disp *disp)
> =C2=A0{
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index e77733a5d9c3..8e57bb6519e5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -608,29 +608,12 @@ r535_sor_cnt(struct nvkm_disp *disp, unsigned
> long *pmask)
> =C2=A0=09return 4;
> =C2=A0}
> =C2=A0
> -static void
> -r535_head_vblank_put(struct nvkm_head *head)
> -{
> -=09struct nvkm_device *device =3D head->disp-
> >engine.subdev.device;
> -
> -=09nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002,
> 0x00000000);
> -}
> -
> -static void
> -r535_head_vblank_get(struct nvkm_head *head)
> -{
> -=09struct nvkm_device *device =3D head->disp-
> >engine.subdev.device;
> -
> -=09nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
> -=09nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002,
> 0x00000002);
> -}
> -
> =C2=A0static const struct nvkm_head_func
> =C2=A0r535_head =3D {
> =C2=A0=09.state =3D gv100_head_state,
> =C2=A0=09.rgpos =3D gv100_head_rgpos,
> -=09.vblank_get =3D r535_head_vblank_get,
> -=09.vblank_put =3D r535_head_vblank_put,
> +=09.vblank_get =3D tu102_head_vblank_get,
> +=09.vblank_put =3D tu102_head_vblank_put,
> =C2=A0};
> =C2=A0
> =C2=A0static struct nvkm_conn *
> @@ -1404,35 +1387,6 @@ static const struct nvkm_event_func
> =C2=A0r535_disp_event =3D {
> =C2=A0};
> =C2=A0
> -static void
> -r535_disp_intr_head_timing(struct nvkm_disp *disp, int head)
> -{
> -=09struct nvkm_subdev *subdev =3D &disp->engine.subdev;
> -=09struct nvkm_device *device =3D subdev->device;
> -=09u32 stat =3D nvkm_rd32(device, 0x611c00 + (head * 0x04));
> -
> -=09if (stat & 0x00000002) {
> -=09=09nvkm_disp_vblank(disp, head);
> -
> -=09=09nvkm_wr32(device, 0x611800 + (head * 0x04),
> 0x00000002);
> -=09}
> -}
> -
> -static irqreturn_t
> -r535_disp_intr(struct nvkm_inth *inth)
> -{
> -=09struct nvkm_disp *disp =3D container_of(inth, typeof(*disp),
> engine.subdev.inth);
> -=09struct nvkm_subdev *subdev =3D &disp->engine.subdev;
> -=09struct nvkm_device *device =3D subdev->device;
> -=09unsigned long mask =3D nvkm_rd32(device, 0x611ec0) &
> 0x000000ff;
> -=09int head;
> -
> -=09for_each_set_bit(head, &mask, 8)
> -=09=09r535_disp_intr_head_timing(disp, head);
> -
> -=09return IRQ_HANDLED;
> -}
> -
> =C2=A0static void
> =C2=A0r535_disp_fini(struct nvkm_disp *disp, bool suspend)
> =C2=A0{
> @@ -1708,7 +1662,7 @@ r535_disp_oneinit(struct nvkm_disp *disp)
> =C2=A0=09=09return ret;
> =C2=A0
> =C2=A0=09ret =3D nvkm_inth_add(&device->vfn->intr, ret,
> NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
> -=09=09=09=C2=A0=C2=A0=C2=A0 r535_disp_intr, &disp-
> >engine.subdev.inth);
> +=09=09=09=C2=A0=C2=A0=C2=A0 tu102_disp_intr, &disp-
> >engine.subdev.inth);
> =C2=A0=09if (ret)
> =C2=A0=09=09return ret;
> =C2=A0

