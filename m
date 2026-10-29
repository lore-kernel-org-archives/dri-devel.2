Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59979606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6oR3Npd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DB310FFF2;
	Thu, 29 Oct 2026 07:46:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686B510FFF2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:46:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F1CC60202
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF18D1F01828;
 Thu, 29 Oct 2026 07:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259993;
 bh=LmsZb32yjJ50q4jcj2c2QOjehUVQIipu//l8uYih38c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a6oR3NpdDWo2muMYH921vixRfmfgWxor8ZyHzuu+laZKw7eKPzmZXF6YcUl67uk4S
 fDpFiK8bR2jPJcJC9lXloqCWbAkSAlFrzZfQU3LoUuNbAX1nrq37ThkKSQa87YIxPo
 7DwwOXDpsCIWV+qvO/3lvoqU3SB1Yd7AfaT1RAB08Rp8odNcrPsNizQnlfH01JJXlC
 v2DRkQAYtKiuHGNKukk61SPolhSOkxkMmv4SfNHMF4iO9ohFkMGdrE2F4EnMlWxD4Y
 LiAMiz+OcI+oFtczFa7U2OiUcGZO2CzQ4mSQdFmsaYuEJZqKHmy8vv5lydgS8QrtXg
 4EFxTfIh/uBfQ==
Message-ID: <sashiko-outbox-188897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/34] drm/atomic_sro: Create kernel parameter to
 force or disable readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-11-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-11-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:46:32 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/atomic_sro: missing kernel-parameters.txt entry for drm.atomic_=
readout
--

commit c7a4855501de73acc47469e5832c891678cde200
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Create kernel parameter to force or disable readout

This commit adds the atomic_readout module parameter to control hardware
state readout behavior and introduces drm_atomic_sro_device_can_readout()
to check whether readout is supported and enabled on a DRM device.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm=
/drm_atomic_state_readout.c
> index 2f8df00e993eb..e93b0e4f0839e 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout.c
> @@ -14,6 +14,42 @@
>  #include "drm_internal.h"
>  #include "drm_crtc_internal.h"
> =20
> +enum drm_atomic_readout_status {
> +	DRM_ATOMIC_READOUT_DISABLED =3D 0,
> +	DRM_ATOMIC_READOUT_ENABLED,
> +	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
> +	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
> +};
> +
> +static unsigned int atomic_readout =3D DRM_ATOMIC_READOUT_ENABLED;
> +module_param_unsafe(atomic_readout, uint, 0400);
> +MODULE_PARM_DESC(atomic_readout,
> +		 "Enable Hardware State Readout (0 =3D disabled, 1 =3D enabled, 2 =3D =
ignore missing compares, 3 =3D ignore missing readouts and compares, defaul=
t =3D 1)");

[Severity: Low]
Since drivers/gpu/drm/drm_atomic_state_readout.c is built into the drm
module whenever CONFIG_DRM is enabled, module_param_unsafe(atomic_readout,
...) exposes drm.atomic_readout on the kernel command line.

Should this new boot and module parameter also be documented in
Documentation/admin-guide/kernel-parameters.txt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D11
