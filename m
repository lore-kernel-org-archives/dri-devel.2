Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D1BC55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BDDB10EF68;
	Thu, 30 Jul 2026 14:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kmAc9mAt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B11C10EF68
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785422465;
 bh=mdTc5rjthYe6OBOSeP3TClZU1ojn4OYqc64zIAcSwkE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kmAc9mAtaVvr3cFAyqmzFONsWN6cgwzMkEqQxrA6QwKhQsNmmxH26l0ERRRpQ91f2
 mvV9MiJentZA3A4vHEsb6Jco1lms29x14sYDAG5MomX1bEyWv8zbkeyoFiXAVO4f+X
 ay+C9xtTzEkhWa/PNXEQFK6RyolSkt3ssXWPCFNaGq6TDAPe+BQVBVDVrWLY3fpCEy
 O9zLncmZ898Gp4ehym9jphIrZAwZ54zF8td4vDQaUX5UuocXO1+HsUY6K3Z875UeOv
 fAiPcTqLg3e2elXnKEhg+jmWvyvNNaUA7I0t8g+UlLwswLyhLwA5HTmkpeyaN7DgTy
 OD3FZrnn8peZg==
Received: from fluorite (unknown [100.64.0.208])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested) (Authenticated sender: pq)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B42117E0213;
 Thu, 30 Jul 2026 16:41:05 +0200 (CEST)
Date: Thu, 30 Jul 2026 17:41:00 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Robert Mader <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Daniel Stone <daniels@collabora.com>, Harry Wentland
 <harry.wentland@amd.com>, Jonas =?UTF-8?B?w4VkYWhs?= <jadahl@redhat.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <mdaenzer@redhat.com>, Sebastian Wick
 <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, Victoria
 Brekenfeld <victoria@system76.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/atomic: Clear plane pipeline for legacy clients
Message-ID: <20260730174100.017a1b5a@fluorite>
In-Reply-To: <20260709115855.53725-1-robert.mader@collabora.com>
References: <20260709115855.53725-1-robert.mader@collabora.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OMHslgD.2KbRLIGyomXP+fZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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

--Sig_/OMHslgD.2KbRLIGyomXP+fZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  9 Jul 2026 13:58:55 +0200
Robert Mader <robert.mader@collabora.com> wrote:

> Clients that do not enable DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE and try to
> apply a new plane state currently have no way to unset/reset an existing
> non-bypass color pipeline, resulting in unexpected behavior.
>=20
> As we can be sure that such clients do not expect plane pipelines to be
> set, let's reset the later for them, ensuring clean bypass-only pipeline
> states.
>=20
> This is a less comprehensive but more backward compatible approach compar=
ed
> to a DRM_MODE_ATOMIC_RESET flag (link) that is currently being discussed.
> Considering the simplicity and clearly defined behavior of this case,
> this change could serve as an additional stop-gap solution to smoothen the
> transition to the new APIs, resulting in less breakage on systems with
> existing clients.
>=20
> Link: https://lore.kernel.org/all/CAFZQkGzw2MZGivy=3DoyYgZE3_dmxu-z-NbDgz=
h9uyqSsj=3DMG=3D2w@mail.gmail.com/
>=20
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
>=20
> ---
>=20
> If an approach like this was previously rejected or clearly goes against
> API rules (or is unacceptable for other reason), please excuse me (and
> just let me know).
>=20
> The main motivation for the patch came up during testing the Weston
> implementation (link) for the fixed-matrix color-ops. The test there chec=
ks
> both the color pipeline and legacy property ways of offloading YCbCr
> buffers and the current reset-less situation results in the legacy one
> failing once the color pipeline test ran before.
>=20
> Link: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133
> ---
>  drivers/gpu/drm/drm_atomic.c | 3 +++
>  1 file changed, 3 insertions(+)

Hi Robert,

this sounds reasonable indeed.

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>

Thanks,
pq

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 735ab7badc2e..581fde90dbd8 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -656,6 +656,9 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *=
state,
>  	state->planes[index].new_state =3D plane_state;
>  	plane_state->state =3D state;
> =20
> +	if (!state->plane_color_pipeline)
> +		plane_state->color_pipeline =3D NULL;
> +
>  	drm_dbg_atomic(plane->dev, "Added [PLANE:%d:%s] %p state to %p\n",
>  		       plane->base.id, plane->name, plane_state, state);
> =20


--Sig_/OMHslgD.2KbRLIGyomXP+fZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmprYnwACgkQI1/ltBGq
qqc9NBAAjd+8qJIov3iv9e/hSncWRbtA/6mrQ2FKhV2B15dRjfyj/X9Y4rJcXVKo
yRghJ3oPNZO3zpJKKUVTHhAnXZ/qsPxUAQGUbC2tlVD95NEMowaSftNRXFbjTaI5
b/TEgb4iau6lHYQzUWRrmB0kExnkVwZZCisWeMBC0etN+fdsr01bzFvMXuK0Hj3J
ImFCfua5YxHm65to7VTKbBGWLqNQ6DYMZ+831gbkhZ91Ht5utBg/ntnndn39h6Bf
Z3tCXKcBTLTDSeSKRRhfDQV9LjedHAVoTx8ZfCi1L7yhyspqWpaqAvAubqEIM1Ee
Z9F/iyZLRR7drV7GyCfDXt0nbrPyWDoYkbGqwk1HcPq9ubul47dNPdnYl6FFLdFF
gL7lK1UTBEuo5HBpJhjGdgFOEV0c190IRkETCoEN1fj7W2Rqp3LThpJRsCLfXbb2
+6khGzvORJyUsoXSe0ktskAH7vjEsblzyEWuF4ID3EVJWuIYYycZI8Woyz8/N8N6
YP45QG+TObIzOybDZsOiwxkToynd6GJOq4FrLdHRGqvdpG65/UZjvJ2X+RLqssml
tZm+Hp1NjKicw5BrEm1BBpCjvUfRa7PLAIRWy0QRzRyZ2ON2mm15HYksBo86z9cd
00xCf9rmJQiuI1bnC/cJCKDtC5yOLclAx1rqx+lWgxBg+HfN5dI=
=zoKo
-----END PGP SIGNATURE-----

--Sig_/OMHslgD.2KbRLIGyomXP+fZ--
