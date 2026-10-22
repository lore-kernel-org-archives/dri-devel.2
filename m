Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762A606A321
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=v1XCxXeT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5551125E1;
	Thu, 22 Oct 2026 12:59:36 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8C71125E1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=TPXltwLQAsPQCNRcrw0xdOwjdfkToTs4/p0KQjsifUY=; b=v1XCxXeTTh88Gb5Wep8pf/75Ay
 qdxcfs/BaDOd/U2bmDRjsUjRCcDnvG3bBChvEbrdKDp+HxMZ29uIs0pNUA1AbcnUHe9JgQvASxJtR
 SUpSSGy3OmZaweb7W4RHB8dgUZrazrBL89k6ON8iD7jD8rAteLooHqSKfKoinnvEnFy7Bg3jDJ5jE
 MNdIKDaA4ZcEIqIWRCd3MoIqG1v7ndRcDbBpeaOU5sSqldS9FcJdiky4u2q0jtE36dM0zTvQVc4rn
 wwkoxRxF0wE+G5+A4BTib/UO5bDmTDJfy/Mf2fxuKPwckgm/xXSg+b9xmkRXKyTEyHauy3Qdn6XWh
 QWA4yw1Q==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chaoyi Chen <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/3] drm/rockchip: vop2: Use drm_format_info_min_pitch()
 for plane offsets
Date: Thu, 22 Oct 2026 14:59:07 +0200
Message-ID: <2024729.6tgchFWduM@diego>
In-Reply-To: <20261022071737.508-2-kernel@airkyi.com>
References: <20261022071737.508-1-kernel@airkyi.com>
 <20261022071737.508-2-kernel@airkyi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chaoyi,

Am Donnerstag, 22. Oktober 2026, 09:17:35 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Chaoyi Chen:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> Use the block aware helper instead of cpp[], the latter aliases
> char_per_block and is wrong for packed 10-bit formats like NV15,
> NV20 and NV30.
>=20
> Tested with modetest[0]:
>=20
> ```
> 	modetest -s 86:3840x2160 -P \
> 	59@83:3940x2160~96,0,3840,2160+0+0@NV20 -a
> ```
>=20
> fb size (3940x2160), src at (96, 0) with size (3840x2160),
> dst at (0, 0) with size (3840x2160)
>=20
> [0]: https://github.com/windowsair/libdrm/tree/src-pos-support
>=20
> Assisted-by: LLM
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 4cce3e336f5b..480aa8c8a8d2 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1290,7 +1290,7 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
> =20
>  	afbc_en =3D drm_is_afbc(fb->modifier);
> =20
> -	offset =3D (src->x1 >> 16) * fb->format->cpp[0];
> +	offset =3D drm_format_info_min_pitch(fb->format, 0, src->x1 >> 16);
> =20
>  	/*
>  	 * AFBC HDR_PTR must set to the zero offset of the framebuffer.
> @@ -1309,6 +1309,7 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
>  		int hsub =3D fb->format->hsub;
>  		int vsub =3D fb->format->vsub;
> =20
> +		offset =3D drm_format_info_min_pitch(fb->format, 1, src->x1 >> 16) / h=
sub;
>  		offset =3D (src->x1 >> 16) * fb->format->cpp[1] / hsub;

missing removal of the replaced line?


Heiko

>  		offset +=3D (src->y1 >> 16) * fb->pitches[1] / vsub;
> =20
>=20




