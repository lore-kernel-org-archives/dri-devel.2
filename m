Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4841CC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942E110EA0E;
	Tue,  8 Sep 2026 04:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hLOdAZ7o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4597610EA0A;
 Tue,  8 Sep 2026 04:54:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DD7A601DB;
 Tue,  8 Sep 2026 04:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC41F00A3A;
 Tue,  8 Sep 2026 04:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843290;
 bh=nqee3SlBMvj85N6wOqXw9hAmAK+6WFLhCa7OAtgvoxM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hLOdAZ7oYpioR4zGlbNbA+ojEFKgEO7YNzcaL8EkeadCJbmkqVqdscq6dyfTvFKqp
 4bodUmDZvRnwHHL1+UM33uThRCUjKs+EM+jnbmQAUUoyIOTPaemX8mbaUBsoPSmQoK
 IcV4/L+SgrfHn/y1HOH3oAraeQjfuoxdxA5igdrsRcvKZxgEEyTFfQfdLk0XLZdTf6
 Wu/pSjxwyTX96lFC12Am9G/FiQd6iUx1j9p4de6HxcCLUbI2894nAmpIVFPVqg4MrI
 Sx5Ys/gmpLAI1DeLya5WagCUsf7wHSK8oaj/EmjtmZPzozyoNyouO0v9qrifV0bzjg
 Gcs98bBKdMHdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/14] drm/property: add a per-connector luminance flag
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-4-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:54:49 +0000
Message-Id: <20260908045449.F2BC41F00A3A@smtp.kernel.org>
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
- [Medium] Meaningful code and commit message mismatch regarding the remova=
l of a legacy pointer comparison.
--

commit 80b70d62f813789e09813bc2993a201bc254a202
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/property: add a per-connector luminance flag

The upcoming per-connector LUMINANCE range property needs to accept the
value 0 (to turn the display off on DPMS-off) even when its advertised
minimum is 1. The existing check special-cased a single device-wide
property object, which does not work once every connector owns its own
LUMINANCE property.

Add a kernel-internal is_luminance flag on struct drm_property and key
the value-0 exception off it instead of a pointer comparison. The flag
is not exposed to userspace.

> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_propert=
y.c
> index f38f2c5437e68..adccee10cfde4 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -952,6 +952,12 @@ bool drm_property_change_valid_get(struct drm_proper=
ty *property,
>  	*ref =3D NULL;
> =20
>  	if (drm_property_type_is(property, DRM_MODE_PROP_RANGE)) {
> +		/*
> +		 * Special case for the luminance property: allow 0 to turn the
> +		 * display off even when the normal range starts at 1.
> +		 */
> +		if (property->is_luminance && value =3D=3D 0 && property->values[1] > =
0)
> +			return true;

[Severity: Medium]
Does the commit message need to be updated, or was a code removal missed?

The commit message mentions replacing an existing check and keying the
exception off the new flag "instead of a pointer comparison."

However, this patch only adds the new check using the is_luminance flag in
drm_property_change_valid_get(), but it does not remove any existing legacy
pointer comparison from the function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D3
