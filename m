Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E165EC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BAA10F610;
	Fri, 11 Sep 2026 12:59:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b1/IRq2u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E546D10F616;
 Fri, 11 Sep 2026 12:59:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3890C60234;
 Fri, 11 Sep 2026 12:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6441F00899;
 Fri, 11 Sep 2026 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131590;
 bh=yX+3ilPb20xiw8ZmOebnP4VcjHhRYW77anjC2PSUMOQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b1/IRq2uo/UurTvnX1op4KNq5KATENSdkp0JYc2lVsGM9E5jNnZCMjILGfVXMV5wU
 JLYrDeORq5/Csgv2ukR5a4dOik0cTfmGpIDqBAQ3qHi8TuC+Rt6MNnqbEvp4zC1lUU
 /cdL3PWW5Ekeg/maVEU7NulsQB77bVWYoqx/s6J4Ibsob+Pmn8rlXAVr3dZf59J8vl
 XndM5q++BzLOVQbeaSpA/NGcC1BNRxrer8Q4fkOP0ZA1GegGjoX6iX7OhuerRIo0Vi
 dH4W9Q9EehI36N9x4Z2+wQxe5dgBOINSJttdUgzCfjIXUjx3VCRiD9RP6Zb1sN5tqV
 6aPTad0ybnfbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/14] drm/panic: Move panic display code into helper
 library
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: ojeda@kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, imx@lists.linux.dev,
 wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, gary@garyguo.net, dri-devel@lists.freedesktop.org
In-Reply-To: <20260911124540.279841-14-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-14-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:59:49 +0000
Message-Id: <20260911125950.4B6441F00899@smtp.kernel.org>
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

> Move drm_plane_helper_display_panic_screen() and the existing panic-
> display code into drm_panic_helper.c. Rename symbols accordingly.
> Also update the QR-related code and the bindings accordingly.
>=20
> Link the rsp. object file into drm_kms_helper.ko. Eventually the code
> will become a DRM drawing library, together with DRM's format and draw
> helpers. This requires more preparation. until then, KMS helpers serve
> as a module. All DRM drivers link it anyway.
>=20
> Add a new section about drawing helpers to the documentation of the KMS
> helpers. List format and panic helpers there.
>=20
> v2:
> - fix dependencies on other DRM modules (Randy, Sashiko)
> - provide placeholders for drm_panic_helper_{init,exit}() (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D13

