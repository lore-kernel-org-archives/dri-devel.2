Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84627606A321
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7UTCPtb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEE210E442;
	Mon, 19 Oct 2026 21:52:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8743810E442
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:52:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FC2043C80;
 Mon, 19 Oct 2026 21:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E789F1F000C6;
 Mon, 19 Oct 2026 21:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792446721;
 bh=+xsrfD132LCghfGmAZuLV1aPfjPlVZkzLHxK/CLgteo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z7UTCPtbbnH0H9KvtJL6wJYiIUWfpFl12xMgA35rb5Vp+buzzy8tRRQ1QMr11zeZ0
 aExZstuhu7JYqc6Kg5GFGBDNq9JNHie0K6Ha1qb7vzVGTu78thHazOORgInKqQJhog
 g8HABoAuAKa40EvVyeih9kIPNiGDZoIl3V92Cf7WoKo3CCq6WZeVRIWsHsQUeC19NO
 aGp1BGM6u+NaJZAsej7T1+cYfScXqdw+ATfF0mUPzcm0Tx4+WmhDMblsTJRkx/w1tZ
 wSyWbfovED5dA3K0UGpsVIHJCY3weI0b3g31PhYtMZuPpA3fsPx1x96t3X2qKB3TAI
 xms8sdlG3kH8A==
Message-ID: <sashiko-outbox-178277@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/14] drm/solomon: ssd16xx: Expose color mode as
 plane property
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019213726.4145532-10-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-10-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:52:00 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/solomon: ssd16xx: commit message contradicts v3 color_mode b=
ehavior
- [Low] drm/solomon: ssd16xx: dead red_supported check in atomic_set_proper=
ty()
--

commit 52cffe8373e1c5de5f3a1dd257828d014890e4a4
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: ssd16xx: Expose color mode as plane property

This commit exposes a color_mode plane property on ssd16xx panels that
support 3-color display modes, allowing runtime switching between
black-white and 3-color operation while rejecting partial refresh when
3-color mode is selected.

>     drm/solomon: ssd16xx: Expose color mode as plane property
>    =20
>     Add a DRM plane property "color_mode" for panels that support
>     3-color (black/white/red) display modes.
>    =20
>     The property allows runtime selection between:
>       - bw (black/white): R1 format represents black (0) and white (1)
>       - 3color: R1 format represents red ink (1) on white background
>    =20
>     The property is created on all panels with "black-white" selectable;
>     panels with red_supported =3D true also expose the "3-color" option.
>     The default is set from the panel configuration's default_color_mode
>     field (typically BW for monochrome panels).
>    =20
>     Signed-off-by: Devarsh Thakkar <devarsht@ti.com>

[Severity: Medium]
Does the commit message still match the v3 implementation?

In drivers/gpu/drm/solomon/ssd16xx.c, ssd16xx_plane_create_properties()
returns early when !device->device_cfg->red_supported, so monochrome panels=
 do
not get the color_mode property at all, whereas the commit message states t=
hat
the property is created on all panels.

In addition, ssd16xx_color_mode_enum defines the enum names as "black-white"
and "3-color", while the list in the commit message refers to them as "bw" =
and
"3color".

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> index f53c67ae7d317..6037717635a48 100644
> --- a/drivers/gpu/drm/solomon/ssd16xx.c
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c

[ ... ]

> @@ -1516,6 +1523,18 @@ static int ssd16xx_plane_atomic_set_property(struc=
t drm_plane *plane,
>  		ssd_state->refresh_mode =3D val;
>  		return 0;
>  	}
> +	if (property =3D=3D device->color_mode_property) {
> +		if (val > SSD16XX_COLOR_MODE_3COLOR)
> +			return -EINVAL;
> +		if (val =3D=3D SSD16XX_COLOR_MODE_3COLOR &&
> +		    !device->device_cfg->red_supported) {
> +			drm_dbg(&device->drm,
> +				"3-color not supported by this panel\n");
> +			return -EINVAL;
> +		}
> +		ssd_state->color_mode =3D val;
> +		return 0;
> +	}
>  	return -EINVAL;
>  }

[Severity: Low]
Can this !device->device_cfg->red_supported check in
ssd16xx_plane_atomic_set_property() ever be reached?

In ssd16xx_plane_create_properties(), if !device->device_cfg->red_supported=
 is
true, the function returns early and leaves device->color_mode_property as
NULL:

	if (!device->device_cfg->red_supported)
		return 0;

	device->color_mode_property =3D
		drm_property_create_enum(drm, 0, "color_mode",
					 ssd16xx_color_mode_enum,
					 ARRAY_SIZE(ssd16xx_color_mode_enum));

Since drm_atomic_plane_set_property() only invokes
ssd16xx_plane_atomic_set_property() for an attached, non-NULL property,
entering the property =3D=3D device->color_mode_property branch already gua=
rantees
that device->device_cfg->red_supported is true.

[ ... ]

> @@ -1869,6 +1903,23 @@ static int ssd16xx_plane_create_properties(struct =
ssd16xx_device *device)
>  	drm_object_attach_property(plane_obj,
>  				   device->refresh_mode_property,
>  				   device->refresh_mode);
> +
> +	/*
> +	 * Color mode: only meaningful on panels with a physical red plane.
> +	 * BW-only panels get no property at all rather than a one-value knob.
> +	 */
> +	if (!device->device_cfg->red_supported)
> +		return 0;
> +
> +	device->color_mode_property =3D
> +		drm_property_create_enum(drm, 0, "color_mode",
> +					 ssd16xx_color_mode_enum,
> +					 ARRAY_SIZE(ssd16xx_color_mode_enum));
> +	if (!device->color_mode_property)
> +		return -ENOMEM;
> +	drm_object_attach_property(plane_obj,
> +				   device->color_mode_property,
> +				   device->color_mode);
>  	return 0;
>  }

 base-commit: d0de3a73194a250a2e5ffbf1dc604c0bcbb16e8a
--=20
2.52.0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019213726.4145=
532-1-devarsht@ti.com?part=3D9
