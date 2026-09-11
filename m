Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37ADC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D727910F5C8;
	Fri, 11 Sep 2026 12:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S3ccw/Yq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9CA10F5C9;
 Fri, 11 Sep 2026 12:53:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09A396020C;
 Fri, 11 Sep 2026 12:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ED71F000FF;
 Fri, 11 Sep 2026 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131202;
 bh=Th0XY13Yvx3ysarn7ce65X3mSKTtBrILLJ8hVYlvSF0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S3ccw/YqXYLhuVlXgUsBP8Nj52LE5FLRtSXPblQgAC/GjkKy5Z85BI5V39rVreLfc
 DSqlDmKelqol3h+KhuFxTmysDNWoOMUF4tlH5KnbUWatrBoJsO9F3eoYEA9U4tqZsx
 OnKT4+gukweWqnLHk3vuQb8iUx1okYtgVjfjnuPZFNV/voabEetRs9AQ0Ajm0fdLAW
 R5Qvtwd0FM2CJ8FTJkDlWkJAWubxfsRf0bYgSFmREq72uVurx/VGpbceroEwJ8/bzq
 oWzMXFF4PupV0A6xQGmmxjsM3XHnY9mABqrsCxLEGw3PUx+Wl1UGrHHXisHXXnkFF3
 5c7cZ89khTs3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/14] drm/panic: Split draw_panic_plane()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: Frank.Li@kernel.org, intel-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev, ojeda@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, gary@garyguo.net, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260911124540.279841-10-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:53:21 +0000
Message-Id: <20260911125322.17ED71F000FF@smtp.kernel.org>
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

> Move locking and parameters from draw_panic_plane() into the new
> helper drm_panic_display_panic_screen(). Call draw_panic_plane() from
> there.
>=20
> The new helper drm_panic_display_panic_screen() is now the DRM core's
> interface for displaying a panic screen. The code remaining in
> draw_panic_plane() still does all the heavy lifting. It will become a
> plane helper for DRM drivers.
>=20
> v2:
> - use panic_type argument in draw_panic_plane() (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D9

