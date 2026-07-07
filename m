Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9C5C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74BA110E995;
	Tue,  7 Jul 2026 12:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cOs4NwuD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F4A10E995
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 12:35:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28493432FC;
 Tue,  7 Jul 2026 12:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592D21F000E9;
 Tue,  7 Jul 2026 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783427759;
 bh=V93acZNdO/pHKczx5FQqkEkHs7w4J4WmlYgZEQRZF7Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cOs4NwuDYL1vjFxR7poNFvwvOB8qZBFhU4nJFj7ZeZFsNe9JCbucZMiQKSSyoxdrr
 zZQG7NK0GK9c/bHCzT0TeG694j0ZClTAatwuhGa9ACm3UAa91iKWkX0XH8X53pC8OZ
 jcK/FBwAcYdFPBAo9NQq5hunm4Ep/T7H3+QtFA53VdTJsEvCY0KZ1CT1h/RWImU39H
 X8K/wAAOESR+IuXDnAwsM/W8IvL1gib4tuc7ne5KHERu/Q+ElKnj4AJFDpXkom94aN
 68VPuIDWWlNuu7mThALL0l9PGJZjioFlY66GjTNokf4SKulvOY4rH5KcsPU6QlBuvC
 nAHxKFfJARvHA==
Date: Tue, 7 Jul 2026 14:35:50 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sunyun Yang <syyang@lontium.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Mohit Dsor <mdsor@qti.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH v2] drm/bridge: lt9611c: use drm_atomic_commit in callbacks
Message-ID: <20260707-masterful-hound-from-camelot-46ffca@penduick>
References: <20260707-lt9611c-v7-v2-1-67d4f688b68d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="rpbzyppysba6jx6z"
Content-Disposition: inline
In-Reply-To: <20260707-lt9611c-v7-v2-1-67d4f688b68d@oss.qualcomm.com>
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


--rpbzyppysba6jx6z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/bridge: lt9611c: use drm_atomic_commit in
 callbacks
MIME-Version: 1.0

Hi,

On Tue, Jul 07, 2026 at 01:48:35PM +0530, Mohit Dsor wrote:
> DRM bridge atomic callbacks now pass struct drm_atomic_commit, and
> the atomic helper functions also expect that type. The lt9611c
> driver still declares its callbacks with struct drm_atomic_state,
> which makes the callback assignments and helper calls fail to build
> with incompatible pointer type errors.
>=20
> Update the lt9611c callback signatures to match the current DRM
> bridge API.
>=20
> This will fix compilation issue in v7.2.rc1.
>=20
> Fixes: 96d1cfec419e ("drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to=
 HDMI driver")
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

This commit, or driver, doesn't exist in 7.2-rc1.

Maxime

--rpbzyppysba6jx6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakzypQAKCRAnX84Zoj2+
du26AYCwAziOEGNWEW6fj+2rFqWEdqxSyf666C9wGoi89AvYrZEtGQiPJ9TFU+Zn
43g8+KgBgMsqtBS4ysmG5oFCx+ZlyKZy0MBkhCIORtUwgQO9drNr95PlH2KBq3VI
C1M13pBWjg==
=VqQ3
-----END PGP SIGNATURE-----

--rpbzyppysba6jx6z--
