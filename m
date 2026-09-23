Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A42C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD7710F18A;
	Wed, 23 Sep 2026 20:25:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l900n2nz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2585D10F18A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:25:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06CEE601FD;
 Wed, 23 Sep 2026 20:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BABA1F000FF;
 Wed, 23 Sep 2026 20:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790195128;
 bh=v/q+BTbuQPzZGACLJ+Ee0jMWGzrYKkrV6xpdVhIM1h8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l900n2nzQOquk3g8ndKggWPw9Di2GMeKPKVMEKIp8IJJ8OVD1vB0WUPnMfChj+xqn
 1tgsvx5qnvlQC1aFWP07LI81V6KoirNFQYsRChISspDdHJk05JeE1HAp+FoOenmtKY
 GofYrTsOAQBqhXY7rS43wrEf0IsBfGN9F3XjBkkcRlAKaZKV80IL1LTyaFqlyd8aqo
 HwNrrOpoBQqHKzKosSdzsv9ZDO/p3ZPXFW4uj3C3XwnmPjTP8yaby2JWKB3Up02Grx
 yI5WdGQrgY3UF8q84l3PlnmmZMo+WmlPJPzmXDHRBmzmV88F42ph+4gD6dnoWgL5Rr
 dOBUUxeMdsPPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/tiny: allow a framebuffer larger than the
 panel on MIPI DBI drivers
To: "Jonathan Frazin" <frazinjonathan@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923195713.88-3-frazinjonathan@gmail.com>
References: <20260923195713.88-1-frazinjonathan@gmail.com>
 <20260923195713.88-3-frazinjonathan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:25:28 +0000
Message-Id: <20260923202528.9BABA1F000FF@smtp.kernel.org>
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
- [Medium] drm/sitronix: missed st7735r in max framebuffer size update for =
MIPI DBI drivers
--

commit 50f420ca1ad2ba6dcb54d9452d2d9f6ac5dcbc2d
Author: Jonathan Frazin <frazinjonathan@gmail.com>

drm/tiny: allow a framebuffer larger than the panel on MIPI DBI drivers

This commit raises the max_width and max_height limits to
DRM_SHADOW_PLANE_MAX_WIDTH and DRM_SHADOW_PLANE_MAX_HEIGHT for MIPI DBI
drivers that flush through drm_mipi_dbi_plane_helper_atomic_update(). This
allows userspace to allocate larger framebuffers and pick the displayed
region via the plane source rectangle without scaling.

> Raise the maximums to DRM_SHADOW_PLANE_MAX_WIDTH/HEIGHT (which its
> kerneldoc recommends for shadow-plane drivers) on the drivers that flush
> through the shared drm_mipi_dbi_plane_helper_atomic_update(), so a client
> can allocate a larger framebuffer and pick the displayed region through
> the plane source rectangle - a crop / pan with no scaling, now that
> drm_mipi_dbi honours the source offset (previous patch):
>=20
>     ili9341, hx8357d, ili9486, mi0283qt, ili9163, panel-mipi-dbi

[Severity: Medium]
Was the st7735r driver intentionally omitted from this list?

It appears that st7735r also uses DRM_MIPI_DBI_PLANE_HELPER_FUNCS (which
sets drm_mipi_dbi_plane_helper_atomic_update) but continues to restrict the
framebuffer size to the panel dimensions.

In drivers/gpu/drm/sitronix/st7735r.c:st7735r_probe():

	drm->mode_config.min_width =3D dbidev->mode.hdisplay;
	drm->mode_config.max_width =3D dbidev->mode.hdisplay;
	drm->mode_config.min_height =3D dbidev->mode.vdisplay;
	drm->mode_config.max_height =3D dbidev->mode.vdisplay;

Since it is located in drivers/gpu/drm/sitronix/ rather than
drivers/gpu/drm/tiny/, could it have been overlooked? This omission leaves
the st7735r driver unable to support the crop and pan functionality being
enabled for the other MIPI DBI drivers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923195713.88-1=
-frazinjonathan@gmail.com?part=3D2
