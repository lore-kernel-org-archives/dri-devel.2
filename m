Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E73C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A146510E84D;
	Tue, 18 Aug 2026 20:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MMrSEbEz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB21A10E84D
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 20:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787085853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HB/YnK1KWHdngHO2stPdwCjOSwkNzhG1abbXEQOhXco=;
 b=MMrSEbEzsOFquVU6nru61So+zsdCqba6bQ7UdwzssKA4c34d72Ns4bM+y9LNBNLmClLwC8
 6Myin6K+pyTtKTbO02R/uEhvi//HpXZPvZbwqSbDHX9rhvvNfZ4en1yU+4Qm+Zulj9kE66
 nRGFR1DEUY+x9z6r8S3OElh5zHAjtBk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-1neF4whbMDKDvjnL57Kj1w-1; Tue, 18 Aug 2026 16:44:11 -0400
X-MC-Unique: 1neF4whbMDKDvjnL57Kj1w-1
X-Mimecast-MFC-AGG-ID: 1neF4whbMDKDvjnL57Kj1w_1787085851
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c083f1818so3181581cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085851; x=1787690651;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IrRWDLtIAaM5eStqn60ea6A/t2RWeOJ1hays+yS0yG0=;
 b=d63MPojKefkPUp+XAiZZWzbGc6vVBJxs0wlp5vBoPrnAPMV4FWx251nUCVsBZ61QTI
 Q1qHA8FxvLp5iJujZyvh58z1EyvL9M5APC1WRCTXLhWaIlI2Jbh6phjO+A/SJxjnVacf
 85b2fKcVzgE7PAVmNldzpKdItfpkPNYie1pkIh5ZmI+ErPynK5tYL8RSGsQD0OIZzsi4
 rIXCF5g9cVrHtJ3NIGN45XbWbx+JH+RLS3lrQjdoGARFj44GdQlm+is6ij/q7yo0cDBM
 xEc8czOuFImdzFpWh35VGdhGAbw+bCeTZaZYOoTWElxmxdZsmaQ7FLXUoIMZPBIEp0RF
 QPtg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8o3uEnv71fHYy7KFrO1G6AhuvOvRtFm5FEerhdq89lPcS6vhTr2lL24Nt/zxb7JioN3dg2+vmA8Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwW1wAPVu0Ue4/FGhlSGSEWjVINleL6Ny5MyguNCpEiGb83BBgP
 BTpLFaCH7cmSEr6c+WHHgiyyR0Ydfx1Wtgb6LcvD/FoMc6OcKM0wAbZwdoim/pMj/h0MNT3OZPa
 t6xVQsokNk4oGYFCquMXYMrXMCFWvXsVV/tW0+grjRTxJ9VW/ffceTj/x6LUJJmwNCkjrJw==
X-Gm-Gg: AR+sD119tcpf+nNN7VjY4aDWPRH15v/Lk2owBPypzyV0bw5UhF0UiQ2H1q5fMVMp8Ip
 EU7j0y8dQkDDa45h1DFJGoaBWtTrDkKFhmHy5nx/IoPM9UjZmXwm54XliVpqGZrzwOtDDEXpUoF
 Jo0rP0Wbw322iSUpG+WTbbYzBZujM7zpHy7gaeRkug9UvCiC+zRZInHhN2cdmaUikkRBrLjNETU
 9RWQyMUD6Y8iQnngIDCWQo0JsKafxF99ESr5Qor1zOgGDdQ679mliJO4NpPTT+edHVi1uxRQtK5
 pHUV+aCIX62Rk9ZqlkNR7jUgJnAfVE3l7QBKsG9K31bSog8LjPgVW5ZSzz9TJUUQiA3W3xAr
X-Received: by 2002:a05:622a:410e:b0:51c:7d0:7ed7 with SMTP id
 d75a77b69052e-52dd3313d61mr8945801cf.39.1787085850603; 
 Tue, 18 Aug 2026 13:44:10 -0700 (PDT)
X-Received: by 2002:a05:622a:410e:b0:51c:7d0:7ed7 with SMTP id
 d75a77b69052e-52dd3313d61mr8945411cf.39.1787085850093; 
 Tue, 18 Aug 2026 13:44:10 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db610b491sm47319561cf.8.2026.08.18.13.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 13:44:09 -0700 (PDT)
Message-ID: <e428a3e8d4c0500c112d8deb756fdec884790623.camel@redhat.com>
Subject: Re: [PATCH v4 2/2] drm/nouveau/kms: guard NULL crtc in
 nv50_sor_atomic_disable()
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Tue, 18 Aug 2026 16:44:08 -0400
In-Reply-To: <178688574402.522643.5471719764843371376@gmail.com>
References: <178688574400.522643.6695278742335367229@gmail.com>
 <178688574402.522643.5471719764843371376@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 84Ts5dlCe4tALxvpNm2dUt3M46jZCg6MQY0Hf5I4rVo_1787085851
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

This isn't correct

On Sun, 2026-08-16 at 15:09 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> nv50_sor_atomic_disable() unconditionally computes
> nv50_head(nv_encoder->crtc) and dereferences the result a few lines
> later.=C2=A0 nv_encoder->crtc is nouveau's own shadow pointer, set in
> .atomic_enable and cleared at the end of .atomic_disable.
> Commit f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder-
> >crtc)
> checks in ->disable callbacks") removed the NULL check here,
> reasoning that the atomic helpers never call ->disable without a
> crtc.=C2=A0 On NVAC (MCP79) under Wayland sessions (observed with Weston'=
s
> DRM backend and with labwc/wlroots) we have hit the NULL case in
> practice during session teardown and VT switches: disable runs
> without
> (or after) its matching enable, and because nv50_head() is
> container_of(), the NULL does not stay NULL but becomes a bogus
> non-NULL pointer, so the subsequent head dereferences fault and the
> kernel oopses.

In the future you should probably put a backtrace if you've seen this
in the wild

>=20
> Restore the guard, as drm_WARN_ON_ONCE() instead of a silent return:
> a NULL crtc here still indicates a state-tracking inconsistency that
> should stay visible.=C2=A0 Return without touching the output; in this
> path
> either enable never ran (nothing to tear down) or an earlier disable
> already did the teardown, and the encoder release is handled by the
> commit_tail release loop in both cases.=C2=A0 (That loop then rejects the
> release of a never-acquired output with -EINVAL in the nvif layer,
> which is harmless; the vanilla code oopsed before ever reaching it.)
>=20
> The same inconsistent-state path can also leave the encoder without
> an
> old connector state, in which case nv50_outp_get_old_connector()
> returns NULL while the backlight teardown dereferenced it
> unconditionally, so the oops would only have moved there.=C2=A0 Hoist the
> guard above all of that and look at the old connector only after
> checking it.
>=20
> Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder-
> >crtc) checks in ->disable callbacks")
> Cc: <stable@vger.kernel.org>
> Tested-by: Fab Stz <fabstz-it@yahoo.fr>
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c | 30 ++++++++++++++++++++--=
-
> --
> =C2=A01 file changed, 25 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 364227f5456f..f532b0ed8880 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1565,16 +1565,36 @@ static void
> =C2=A0nv50_sor_atomic_disable(struct drm_encoder *encoder, struct
> drm_atomic_commit *state)
> =C2=A0{
> =C2=A0=09struct nouveau_encoder *nv_encoder =3D
> nouveau_encoder(encoder);
> -=09struct nv50_head *head =3D nv50_head(nv_encoder->crtc);
> +=09struct nv50_head *head;
> =C2=A0#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> -=09struct nouveau_connector *nv_connector =3D
> nv50_outp_get_old_connector(state, nv_encoder);
> +=09struct nouveau_connector *nv_connector;
> =C2=A0=09struct nouveau_drm *drm =3D nouveau_drm(nv_encoder-
> >base.base.dev);
> -=09struct nouveau_backlight *backlight =3D nv_connector-
> >backlight;
> -=09struct drm_dp_aux *aux =3D &nv_connector->aux;
> +=09struct nouveau_backlight *backlight;
> =C2=A0=09int ret;
> +#endif
> =C2=A0
> +=09/* nv_encoder->crtc is the driver's shadow pointer, set in

It's actually an outdated variable from the pre-atomic days

> +=09 * .atomic_enable (and by the boot-time hardware readback)
> and

We don't set nv_encoder->crtc at the boot-time hardware state readback.

> +=09 * cleared at the end of this function.=C2=A0 NULL here
> +=09 * means disable-without-enable or a double disable; bail
> before
> +=09 * container_of() turns it into a bogus head pointer
> (checking the
> +=09 * result would not work, container_of(NULL) is never
> NULL).=C2=A0 The
> +=09 * encoder release is handled by the commit_tail release
> loop, so
> +=09 * there is nothing to clean up here.
> +=09 */

this is way too verbose

> +=09if (drm_WARN_ON_ONCE(encoder->dev, !nv_encoder->crtc))
> +=09=09return;
> +=09head =3D nv50_head(nv_encoder->crtc);

this isn't the bug, the bug is that we're reading nv_encoder->crtc at
all here.

> +
> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> +=09/* The same inconsistent-state path can leave us without an
> old
> +=09 * connector state, so check before touching it.
> +=09 */
> +=09nv_connector =3D nv50_outp_get_old_connector(state,
> nv_encoder);
> +=09backlight =3D nv_connector ? nv_connector->backlight : NULL;
> =C2=A0=09if (backlight && backlight->uses_dpcd) {
> -=09=09ret =3D drm_edp_backlight_disable(aux, &backlight-
> >edp_info);
> +=09=09ret =3D drm_edp_backlight_disable(&nv_connector->aux,
> +=09=09=09=09=09=09&backlight-
> >edp_info);

This doesn't need changing either if we just fix where the encoder came
from.

I'll send out proper fixes for this in a moment

> =C2=A0=09=09if (ret < 0)
> =C2=A0=09=09=09NV_ERROR(drm, "Failed to disable backlight
> on [CONNECTOR:%d:%s]: %d\n",
> =C2=A0=09=09=09=09 nv_connector->base.base.id,
> nv_connector->base.name, ret);

