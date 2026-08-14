Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0D6C5DF66
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EBC10E0AB;
	Fri, 14 Aug 2026 02:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rsyokx6Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B679410E0AB
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:16:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4D7A600AD
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 02:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298921F000E9;
 Fri, 14 Aug 2026 02:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786673769;
 bh=+aSz9jClKvUooOAoiRkdFg5Bob2AdB6a7gqYRkUmU7Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rsyokx6YCTAvDiuxFa0neGirHpsYc0AXM1jh38Q1REfBrSkDWwcAOsMBwceVO/0Y3
 xkE1Kj95AJWmSGj4Gc2FdAK2xqFTXjbR31i7dMheCAOkn3UXNArecuSx9WmBdhmxA7
 +qL8hG528Qjjp/gQYP7uC7jJtRCzBZ3YWmddvYKawt0i0I2BI1wiOEwJi1m1JjA4c3
 5DT004cZS6EjK2M+ioXe9VlxGJMvtRoI0qqKPh6Jn7x9O5mV7R6oSxG9HA310TsJ2q
 2L7rIsN/kZPBPJJ7ZOBVGLdxfd4OtLrzlVK6zFrmYym/KnoxbRqz16FkfmGTSbHWGd
 +sYoLV1XtbVmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 67/78] drm/stm: lvds: Switch to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-67-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-67-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:16:04 +0000
Message-Id: <20260814021609.298921F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error code assigned during DRM link parsing is silently overwr=
itten, allowing initialization to proceed with `lvds->primary =3D=3D NULL`,=
 leading to a NULL pointer dereference during clock registration.
--

--- Patch [67]: [PATCH v2 67/78] drm/stm: lvds: Switch to atomic_create_sta=
te ---
commit a0c8f236235c34b542e12fb6855c87676c94c0b3
Author: Maxime Ripard <mripard@kernel.org>

drm/stm: lvds: Switch to atomic_create_state

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated. Switch to the
atomic_create_state callback and its counterpart.

> diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
> index 50a878688e477..90a44e7220573 100644
> --- a/drivers/gpu/drm/stm/lvds.c
> +++ b/drivers/gpu/drm/stm/lvds.c
> @@ -1038,7 +1038,7 @@ static const struct drm_bridge_funcs lvds_bridge_fu=
ncs =3D {
>  	.atomic_disable =3D lvds_atomic_disable,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  };
> =20
>  static int lvds_probe(struct platform_device *pdev)

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer=20
dereference in the probe path located just below this change.

In lvds_probe(), if the device tree configuration specifies only a secondar=
y=20
single link, lvds->primary is explicitly set to NULL:

drivers/gpu/drm/stm/lvds.c:lvds_probe() {
    ...
		remote =3D of_get_next_available_child(port2, NULL);
		if (remote) {
			if (of_graph_get_remote_endpoint(remote)) {
				lvds->link_type =3D LVDS_SINGLE_LINK_SECONDARY;
				lvds->primary =3D NULL;
				lvds->secondary =3D &lvds_phy_16ff_secondary;
			} else {
				ret =3D (ret =3D=3D -EINVAL) ? -EINVAL : 0;
			}
    ...
}

The probe function then proceeds to call lvds_pixel_clk_register(lvds).=20
When the Common Clock Framework invokes the provided recalc_rate callback=20
during registration, the callback accesses lvds->primary without checking=20
if it is valid:

drivers/gpu/drm/stm/lvds.c:lvds_pixel_clk_recalc_rate() {
    ...
	val =3D lvds_read(lvds, lvds->primary->base + lvds->primary->ofs.PLLCR2);
    ...
}

Will this cause a kernel panic during driver probe if a valid single-link=20
secondary configuration is used, or if an invalid endpoint error is silentl=
y=20
overwritten?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D67
