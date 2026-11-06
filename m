Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11347606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCvJrte1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA5F112D91;
	Fri,  6 Nov 2026 13:44:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DAF10E414
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0805243CBE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AE81F0089F;
 Fri,  6 Nov 2026 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972656;
 bh=T88vpNF0KSrF1iDPt4AshSEdItr8kppJ2L9jTRTXuW0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aCvJrte1b2dB1lFmFNf8+NuUuglVxK0mscPafLwr64yOm5pBEeJxT/cSzGGHgkPjR
 Y1nxW9vdztCkQgpbloH6UmEyyU80V2Z4TAJM1ePshV+z9itIYQyBuk6U2C04mJUV4v
 l+towOpVONm2NIa9gvUaGRsG7MevFtvk34pzojvodOjLqUI/z6Ex1R/E+COf6ClWBG
 jBHUPMcLlyt2ETdLmuAGydE3WC2dex4bnNrM9iRk5kHJl7XS7NW/Ofec4WsJJeYq1Q
 Vr3i8Fh6/14+6J+ARLUbfc2uRMS3P2dW4CoWIYBvHwmqFEvwEWXWqyvNrGBHl0oSsf
 wU53PvzcHgRSg==
Message-ID: <sashiko-outbox-201490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 25/39] drm/atomic-state-helper: Provide
 atomic_compare_state helpers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-25-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-25-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:44:16 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/atomic: false plane mismatches in
  drm_atomic_helper_plane_compare_state()
- [Low] drm/atomic: missing crtc return in
  drm_atomic_helper_connector_compare_state()
--

commit 5ada4d3fe0db996674c95e2287875ccd802a0470
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-state-helper: Provide atomic_compare_state helpers

This commit adds default atomic_sro_compare_state helper implementations
for planes, CRTCs, connectors, and bridges.

> diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/=
gpu/drm/drm_atomic_state_readout_helper.c
> index 4156f3a27f049..57376c9d4014b 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
[ ... ]
> @@ -788,6 +789,311 @@ int drm_atomic_helper_sro_readout_state(struct drm_=
device *dev)
[ ... ]
> +bool drm_atomic_helper_plane_compare_state(struct drm_plane *plane,
> +					   struct drm_printer *p,
> +					   struct drm_plane_state *expected,
> +					   struct drm_plane_state *actual)
> +{
> +	bool ret =3D true;
> +
> +	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, plane);
> +	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, crtc);
> +
> +	/* Both disabled, geometry is meaningless. */
> +	if (!expected->fb && !actual->fb)
> +		return ret;
> +
> +	/* One enabled and the other disabled, that's a mismatch. */
> +	if (!expected->fb || !actual->fb) {
> +		drm_atomic_helper_print_state_mismatch(p,
> +						       plane->name,
> +						       "fb",
> +						       "expected framebuffer is %s, got %s",
> +						       expected->fb ? "non-NULL" : "NULL",
> +						       actual->fb ? "non-NULL" : "NULL");
> +		return false;
> +	}

[Severity: Medium]
Does drm_atomic_helper_plane_compare_state() report false crtc and fb
mismatches when a plane is clipped off-screen or its CRTC is set to DPMS
off?

During a DPMS off commit (enable =3D true, active =3D false) or when a plane
is clipped off-screen (visible =3D false), expected->crtc and expected->fb
remain non-NULL in the committed state, while the hardware plane is
disabled so hardware readout produces a pristine state with actual->crtc
and actual->fb set to NULL.  Unlike the connector, bridge, and CRTC paths,
neither drm_atomic_sro_readout_and_compare() nor
drm_atomic_helper_plane_compare_state() checks whether the plane is
visible or bound to an active CRTC before comparing crtc and fb, causing
drm_atomic_sro_readout_and_compare() to log false mismatches and return
false.

[ ... ]

> +bool drm_atomic_helper_connector_compare_state(struct drm_connector *con=
n,
> +					       struct drm_printer *p,
> +					       struct drm_connector_state *expected,
> +					       struct drm_connector_state *actual)
> +{
> +	bool ret =3D true;
> +
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, connector);
> +
> +	/*
> +	 * Both unbound, the routing and the negotiated properties are
> +	 * meaningless: a disabled connector keeps the values it was
> +	 * last enabled with, while a state read out from a disabled
> +	 * pipeline is pristine.
> +	 */
> +	if (!expected->crtc && !actual->crtc)
> +		return ret;
> +
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, crtc);
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, best_encoder);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, link_status);
> +
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.select_subconn=
ector);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.subconnector);

[Severity: Low]
Should drm_atomic_helper_connector_compare_state() return false right
after checking crtc when one of expected->crtc or actual->crtc is NULL?
Continuing when one state is unbound compares negotiated properties
against stale or pristine fields and logs spurious mismatches, unlike
drm_atomic_helper_plane_compare_state() and
drm_atomic_helper_crtc_compare_state().

Also, only tv.select_subconnector and tv.subconnector are compared here,
leaving the remaining struct drm_tv_connector_state fields (margins,
legacy_mode, mode, brightness, contrast, flicker_reduction, overscan,
saturation, and hue) unchecked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D25
