Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B96606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBETD4Fy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C37110FFF8;
	Thu, 29 Oct 2026 07:50:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD4E10FFF8
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:50:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CD51600DA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E6E1F01829;
 Thu, 29 Oct 2026 07:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793260226;
 bh=E4FDX7VxlTFVCyRAf7ekRC0yXvZ7SqTZ3zGnuH4z2So=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VBETD4FyGoshcz8gYjbai2fuJT+yguhwnYi3ZDUcizdZYvFl/yftR/K7/180GA4yt
 TqrHlsti0w+uE6AExZTTXsfwnx9ADf6hPr350F+VN6e0Iy99eM4plAVfiwJ+0DNl0P
 7Gr0vJ+Czrn5Hkh0mJApG1URpwQRLsbtmOxsy9CeymEfVtqg4BS3uC+yFR1YnctCjX
 5odvWaIJ9hYlUVo+QzUVRMqyMCHEuKmg0NFLVBscxMc2yiQ6m59YFIFDDAlX9eglOr
 DBVW1QHc/MIsS2CTESCyQDaglGPsi0qGJsMhhXRYvwyD/2wn6FF7AoWjnmlaOw4qc2
 AOt/fjmxPtVLQ==
Message-ID: <sashiko-outbox-188905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/34] drm/atomic_sro: Create drm_atomic_sro_state
 container
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-10-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-10-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:50:25 +0000
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
- [Low] drm/atomic_sro: missing EXPORT_SYMBOL() on drm_atomic_sro_state_get=
_device()
--

commit 272e19a2c59ccd440923a43421c7657b21dcc87e
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic_sro: Create drm_atomic_sro_state container

This commit introduces the struct drm_atomic_sro_state container to hold
hardware readout states for planes, CRTCs, connectors, and private objects,
along with helper functions to allocate, free, print, and access those
states.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm=
/drm_atomic_state_readout.c
> new file mode 100644
> index 0000000000000..2f8df00e993eb
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_atomic_state_readout.c
> @@ -0,0 +1,475 @@

[ ... ]

> +/**
> + * drm_atomic_sro_state_get_device - get the DRM device from an SRO state
> + * @state: SRO state
> + *
> + * RETURNS:
> + *
> + * The &struct drm_device associated with the SRO state.
> + */
> +struct drm_device *
> +drm_atomic_sro_state_get_device(struct drm_atomic_sro_state *state)
> +{
> +	return state->dev;
> +}

[Severity: Low]
Should drm_atomic_sro_state_get_device() have an EXPORT_SYMBOL() here?

struct drm_atomic_sro_state is an opaque structure defined privately in
drivers/gpu/drm/drm_atomic_state_readout.c, and
drm_atomic_sro_state_get_device() is declared in
include/drm/drm_atomic_state_readout.h alongside the other public SRO state
helpers. Unlike all of the other public functions in this file, it is not
exported with EXPORT_SYMBOL(drm_atomic_sro_state_get_device).

When a loadable module calls drm_atomic_sro_state_get_device(), such as the
KUnit test in drivers/gpu/drm/tests/drm_atomic_state_readout_test.c when
built with CONFIG_DRM_KUNIT_TEST=3Dm, will this cause a modpost undefined
symbol failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D10
