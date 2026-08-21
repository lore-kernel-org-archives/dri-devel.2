Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA23C5DF97
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 22:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C760F10E500;
	Fri, 21 Aug 2026 22:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="d+/ZVGHa";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DA610E500
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787349979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwhVKlFw0C7U0qZUm2FHhHp351/G0aZVZwuOAuxRA3A=;
 b=d+/ZVGHa35UkkOp4c3we/vRz7IcM523c96SvqgQdof0G8CKVN47lRD1fl/ZHFjCOBA1dj3
 GYPs7J6Q7+8A23LKqIVCjcdwWHUvP0m1uv9x3erLSgETpVV7W98m4fOMybMSJZV/Haf3zN
 JIAWGFRkLO8avUrwzd3RvU54rK5nJDI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-FfYwgEu_P8yyG8e6-DYhhw-1; Fri, 21 Aug 2026 18:06:18 -0400
X-MC-Unique: FfYwgEu_P8yyG8e6-DYhhw-1
X-Mimecast-MFC-AGG-ID: FfYwgEu_P8yyG8e6-DYhhw_1787349978
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso20174141cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787349978; x=1787954778;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GTNrL6a76djYPY+4BIDNC1iw4ko1rS7zaHUKe36ZGxo=;
 b=IH5tF4l5BR9S3t09xJHwJL+91fpumFV4m3yVE4dcEd9wqPBzULsWYPdiZso3/pViNr
 nacnEtNb4Cyx6yHedSWOvkFNeujEhXaJLu2japBDnsghbuD96+62owEgF2EHqUD7Oq1u
 X20THtceg2UD0f30Recxuibv0CLr9Zah5OH4pbUzgowwnIb47l4nnUU6KNc0X2iqp1jq
 f6nN1e9s0osl+NMfaffoglILZY91fWobVnX0lXW5z//gvIAIdt6AuIQCg0YYZdTnMp6t
 JGMOlDFyg5IzwlHk+FPU7QzHRKWcqePqFzLm/J+bPI7YxZq3hizmkMjtpTYWU2jW2e9M
 7iiw==
X-Gm-Message-State: AFuF++n5HK+qXX9YkLBv0MuYMoHgx8V1yNv01Cao6A7uArD9wADJ5Yl5
 4LvWPZZOAo6JoKRccHOfAXswfQzLc4Y47YU0vJak64X35yKchZTBgJ6pTrZkBjU/kqjsZOtQkl8
 myywlX+C7aCCJ5lXCuHVEaB3MTDuE4yZ44ff8MDzZr49OwsFZmVHnd9OcL5h0GEARYw1t3g==
X-Gm-Gg: AR+sD107YzLrUmi7MECHx6GVtVjWOBeCT2Mkr6VGzUxqxvUA3rBjkL3IPy/ErWjwgPy
 fsNTIZTtmYq7AjOxSQlZWSEbN5ygXDDAD3bk/qYaLO9+ua3zgSvkqiA+vPoMzBf6sLqz/JE4ouZ
 cYtQKe2/ONuUZ4o3wk3v6obMGmn/biGibd/Lyv5gub1Qw/FvK1DoEcBHbBBLh10DVBYw2bFAoCu
 8wQE/npBMMof31tOyZGm28LnaYE78Of0JrUzpoAZm882BVgH/ftmwh3jIbeROfE1UX3mxn1yffY
 PhuLNpxBI0q7G8n+7nMyD8BOloVtI5hAJMHpky5IIayovg4eLqO/poSlkbVxrXXXbcyDG1Ky
X-Received: by 2002:a05:622a:5594:b0:516:d60f:6438 with SMTP id
 d75a77b69052e-52df5521abamr98361601cf.0.1787349977870; 
 Fri, 21 Aug 2026 15:06:17 -0700 (PDT)
X-Received: by 2002:a05:622a:5594:b0:516:d60f:6438 with SMTP id
 d75a77b69052e-52df5521abamr98360961cf.0.1787349977361; 
 Fri, 21 Aug 2026 15:06:17 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2b4ad5sm72819006d6.42.2026.08.21.15.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 15:06:15 -0700 (PDT)
Message-ID: <072f26a26bbba19cf8701472141590ffadd72f45.camel@redhat.com>
Subject: Re: [PATCH v2 07/10] drm/nouveau/disp: fix head state readback on
 GB20x
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 18:06:14 -0400
In-Reply-To: <20260820164929.17117-8-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
 <20260820164929.17117-8-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V7MukdRAl4jL2rWkv78GQgYEuSQpxlSSUMQPiEWueuY_1787349978
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

One nitpick below

On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
> The GSP path reads armed head state and the RG scanout position
> through
> gv100_head_state() and gv100_head_rgpos() on every generation.
> gv100_head_state() reads the core channel's state mirror at a 0x400
> per-head stride, which NVD5.0 (GB20x) doubled. Per NVIDIA's published
> CA7D class header every HEAD_SET method sits at 0x2000 + head *
> 0x800,
> while the mirror bases are unchanged (assembly at 0x680000, armed at
> +0x8000, per OpenRM's v03_00 channel-user-base HAL which is still
> used on
> DISPv0502).
>=20
> Add gb202_head_state(), the same readback at the 0x800 stride, and
> supply it through gb202_gsp_disp.
> gv100_head_rgpos() is kept. The RG registers keep their per-head
> 0x800
> stride on NVD5.0, and OpenRM's
> kdispReadRgLineCountAndFrameCount_v03_00
> still reads NV_PDISP_RG_DPCA on DISPv0502.
>=20
> Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
> ---
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/gb202.c=C2=A0 | 49
> ++++++++++++++++++-
> =C2=A01 file changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> index 4863b2b36db0..a66c820be9fe 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
> @@ -83,6 +83,53 @@ gb202_sor_hdmi_gcp(struct nvkm_ior *sor, int head,
> bool enable)
> =C2=A0=09nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000001);
> =C2=A0}
> =C2=A0
> +/* Same core-channel state mirror as gv100_head_state() (assembly at
> 0x680000,
> + * armed at +0x8000, per-head method offsets unchanged), but NVD5.0
> spaces
> + * heads 0x800 apart (see NVCA7D_HEAD_SET_*(a) in clca7d.h).
> + */
> +static void
> +gb202_head_state(struct nvkm_head *head, struct nvkm_head_state
> *state)
> +{
> +=09struct nvkm_device *device =3D head->disp-
> >engine.subdev.device;
> +=09const u32 hoff =3D (state =3D=3D &head->arm) * 0x8000 + head->id *
> 0x800;
> +=09u32 data;
> +
> +=09data =3D nvkm_rd32(device, 0x682064 + hoff);
> +=09state->vtotal =3D (data & 0xffff0000) >> 16;
> +=09state->htotal =3D (data & 0x0000ffff);
> +=09data =3D nvkm_rd32(device, 0x682068 + hoff);
> +=09state->vsynce =3D (data & 0xffff0000) >> 16;
> +=09state->hsynce =3D (data & 0x0000ffff);
> +=09data =3D nvkm_rd32(device, 0x68206c + hoff);
> +=09state->vblanke =3D (data & 0xffff0000) >> 16;
> +=09state->hblanke =3D (data & 0x0000ffff);
> +=09data =3D nvkm_rd32(device, 0x682070 + hoff);
> +=09state->vblanks =3D (data & 0xffff0000) >> 16;
> +=09state->hblanks =3D (data & 0x0000ffff);
> +=09/* Bit 31 is ADJ1000DIV1001, not a HERTZ bit. We don't have
> enough bits
> +=09 * to add the full clock in hz on Blackwell (35 bits), but
> state->hz
> +=09 * is unused and obsolete under GSP so this is fine.
> +=09 */
> +=09state->hz =3D nvkm_rd32(device, 0x68200c + hoff) & 0x7fffffff;
> +
> +=09data =3D nvkm_rd32(device, 0x682004 + hoff);
> +=09switch ((data & 0x000000f0) >> 4) {
> +=09case 5:
> +=09=09state->or.depth =3D 30;
> +=09=09break;
> +=09case 4:
> +=09=09state->or.depth =3D 24;
> +=09=09break;
> +=09case 1:
> +=09=09state->or.depth =3D 18;
> +=09=09break;
> +=09default:
> +=09=09state->or.depth =3D 18;
> +=09=09WARN_ON(1);
> +=09=09break;
> +=09}

I would probably condense this switch case like ben did with
gv100_head_state():

=09switch ((data & 0x000000f0) >> 4) {
=09case 5: state->or.depth =3D 30; break;
=09case 4: state->or.depth =3D 24; break;
=09case 1: state->or.depth =3D 18; break;
=09default:
=09=09state->or.depth =3D 18;
=09=09WARN_ON(1);
=09=09break;
=09}

With that fixed:

Reviewed-by: Lyude Paul <lyude@redhat.com>

> +}
> +
> =C2=A0/* GB20x is GSP-only. This table supplies the register programming
> the
> =C2=A0 * GSP-RM display path needs from the chip.
> =C2=A0 */
> @@ -91,7 +138,7 @@ gb202_gsp_disp =3D {
> =C2=A0=09.uevent =3D &gv100_disp_chan_uevent,
> =C2=A0=09.ramht_size =3D 0x2000,
> =C2=A0=09.gsp.intr =3D tu102_disp_intr,
> -=09.gsp.head_state =3D gv100_head_state,
> +=09.gsp.head_state =3D gb202_head_state,
> =C2=A0=09.gsp.head_rgpos =3D gv100_head_rgpos,
> =C2=A0=09.gsp.vblank_get =3D tu102_head_vblank_get,
> =C2=A0=09.gsp.vblank_put =3D tu102_head_vblank_put,

