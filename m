Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A971606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDBUAulE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C4010F937;
	Tue, 17 Nov 2026 20:14:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3178210E70C;
 Tue, 17 Nov 2026 20:14:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7161A611ED;
 Tue, 17 Nov 2026 20:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A1E1F000C6;
 Tue, 17 Nov 2026 20:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794946477;
 bh=77Or3aUVlp2K3fOc1tpElYdL+2OVUy4cKf0CceowiV0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bDBUAulEJIBL7+IhD0JZa7ZxXksElIQwscPfbSyMPFGCO1EQoGkWF3TDwYEZ79EeR
 derQRV9fvC051vGHsronwEqKid5wKNJKG0rUIp8lB/HxyZEOEQ0vbDxjcbeVchT6UN
 A6nA/CoF2u3lDElE9CZ/oHb5gplLcOkDXBUtwKdHa+iLx7NIQRZuUqpY5GCZgoAzIU
 R0T1uVymVZ4a0G0ryXs49J8Lb7pN9WbSS3P5isMckdrZWTjq+PbpNKKPlk7uWrcyiz
 Nbu0sGsx/Gx/hFsJ/WYKXT7tFg/wT0GzXoLmyS4EsxVML0cEVlgVkcS1Mg2aUap3Dh
 VNEpWtJCqthEg==
Message-ID: <sashiko-outbox-219583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] drm/atomic: Store the device in drm_crtc_commit
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261117200253.27078-5-ville.syrjala@linux.intel.com>
References: <20261117200253.27078-1-ville.syrjala@linux.intel.com>
 <20261117200253.27078-5-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:14:36 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/atomic: missing Fixes trailer for drm_crtc_commit_wait()
  NULL deref fix
--

commit 433f54d3266af0158d7292f32d2620e6b84e2e85
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

> drm/atomic: Store the device in drm_crtc_commit
>
> drm_crtc_commit_wait() gets the device for its timeout messages from
> commit->crtc, which is NULL for the fake commit that tracks unbound
> planes and connectors. If waiting for the fake commit's hw_done ever
> times out we oops instead of printing the message.
>
> Store the device in the commit and use it for the messages instead,
> and also print the CRTC when there is one so the messages say which
> commit timed out. Document that drm_crtc_commit.crtc is NULL for the
> fake commit.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

[Severity: Low]
This fixes a NULL pointer dereference introduced when
drm_crtc_commit_wait() was converted from DRM_ERROR() to
drm_err(commit->crtc->dev, ...).  Should this include a Fixes: tag?

  Fixes: 6e22dc358377 ("drm: get rid of DRM_DEBUG_* log calls in drm core, =
files drm_a*.c")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200253.2707=
8-1-ville.syrjala@linux.intel.com?part=3D4
