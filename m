Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B17FC88E56
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD9C10F628;
	Fri, 11 Sep 2026 12:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lRqxgu/2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDF310F610;
 Fri, 11 Sep 2026 12:59:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4C0D40831;
 Fri, 11 Sep 2026 12:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE5C1F00898;
 Fri, 11 Sep 2026 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131584;
 bh=4GSlZVdim4UHhZgzdztPlxiMIor4//3/w7uuyumnHns=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lRqxgu/2JkLI3PeOol6tJ9dW7mpOXvyeEjCoKTGxIJfu2xLeTH8J/4j4FdL3OBcRA
 ncOrlOVhWVZgGORHiCqp6KNhNEGk28PfIqWjbDTg93snCFvm/GoviUlIG1AQlmnWG4
 FXpRgoOIApiLBke+RIWY1FWRsODT6ZQ3ai8A46xYMBaXtUk93qSyd9nDVENCZqB0ZB
 ym9h6YCRADgJ6ZW+jhC4/V2osHOSBozpIdjQYZKe05g+Y2Utb6eL+zxMFBlxH9XaDz
 3pEDFaQQw/DrywGtQ5Sjbj+hGAPGsLF/x8JmVH4pFJQoaUSqDVqBQhc2X9XsCWKIpz
 WxqtvI/UhWqxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/14] drm/panic: Display panic screen via per-plane
 callback
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: Frank.Li@kernel.org, gary@garyguo.net,
 "Michael S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, ojeda@kernel.org,
 intel-xe@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260911124540.279841-12-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:59:43 +0000
Message-Id: <20260911125944.1BE5C1F00898@smtp.kernel.org>
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

> Add display_panic_screen to struct drm_plane_funcs. If set on a plane,
> register a panic handler for the plane from the DRM core's panic
> handling. Invoke this helper from the core to display a panic screen.
>=20
> The new callback replaces get_scanout_buffer as signal for panic
> support in a plane. Using get_scanout_buffer is now merely a detail
> of the implementation. This will also free struct drm_scanout_buffer
> for use cases besides panic handling.
>=20
> With display_panic_screen in place, rename draw_panic_plane() to
> drm_plane_helper_display_panic_screen() and make it available to DRM
> drivers via drm_panic_helper.h. Do not change the implementation or
> functionality of this code. drm_plane_helper_display_panic_screen()
> still supports kernel messages, user messages and QR codes on various
> color formats.
> [ ... ]
> - only consider planes with get_scanout_buffer (Sashiko)
> - set callback for planes create with drm_crtc_init() (Sashiko)
> - return errno code from display_panic_screen
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D11

