Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD598606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nalozJRF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DCF10E616;
	Wed, 18 Nov 2026 04:01:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29ED710E554;
 Wed, 18 Nov 2026 04:01:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C466341B27;
 Wed, 18 Nov 2026 04:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9921F000C4;
 Wed, 18 Nov 2026 04:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794974460;
 bh=xuTGhM+8hjMnBgw3Am1sCsRtXx2EiZc6Vspv0gWTJPU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nalozJRFjOc/B+Ox9sRmKaF6mbri33XGYmrH8bX3clzzqfUx7t91T3jJJLS/Gqgl9
 x6ccacg9G0V07JNwpGjrLRODe1qfvOnkMJ9B9U9uhEYBlMhxRGWrXzeSSkrAB+U6JY
 qG7vKvfANHFby8jAeejWiKX7ZocC3myeF25dpkAYt3tUg58SwJglFw0J8XCYhSDAhO
 ii9RizOcRBYOSYWLbjzcMo4Sw9VQdd4/HBl9Hg2bw81QfuyCugbH1LwyBdfmGi6ELN
 YtNrZf7/l8/zXqoDXf3ZNWhs8B4lfE2pHVekZBszbht+ApM0OMckyOeqUqNHLcagvH
 oWsXqYpbANeaA==
Message-ID: <sashiko-outbox-220061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/bw: sync global BW after non-atomic plane disable
To: "Hanson Wang" <hanson.wang@ugreen.com>, intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261118033312.902366-1-hanson.wang@ugreen.com>
References: <20261118033312.902366-1-hanson.wang@ugreen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 04:00:59 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/i915/display: stale cdclk state after
  intel_plane_disable_noatomic()
--

commit cc04b14ee64b615dd833441addacb0b2def5e98d
Author: Hanson Wang <hanson.wang@ugreen.com>

drm/i915/bw: sync global BW after non-atomic plane disable

This commit updates the global intel_bw_state and intel_dbuf_bw_state
when a plane is disabled via intel_plane_disable_noatomic() so that
subsequent atomic checks do not retain stale plane bandwidth accounting.

Link: https://lore.kernel.org/intel-gfx/20261016014704.3876294-1-hanson.wan=
g@ugreen.com

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index f79caeb5a82ec..c5a043ade54ff 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c

[ ... ]

> @@ -679,6 +680,14 @@ void intel_plane_disable_noatomic(struct intel_crtc =
*crtc,
> =20
>  	skl_wm_plane_disable_noatomic(crtc, plane);
> =20
> +	/*
> +	 * Keep the global bandwidth states in sync with the updated
> +	 * CRTC-local plane and DDB state. Otherwise a later atomic check
> +	 * may skip the update when its old and new inputs are identical.
> +	 */
> +	intel_bw_crtc_update_noatomic(crtc);
> +	intel_dbuf_bw_crtc_update_noatomic(crtc);
> +
>  	if ((crtc_state->active_planes & ~BIT(PLANE_CURSOR)) =3D=3D 0 &&
>  	    hsw_ips_disable(crtc_state)) {
>  		crtc_state->ips_enabled =3D false;

[Severity: Medium]
Does updating display->dbuf_bw.obj.state here without also updating
display->cdclk.obj.state and crtc_state->min_cdclk leave
cdclk_state->dbuf_bw_min_cdclk and cdclk_state->min_cdclk[pipe] stuck at
their pre-sanitization values?

During hardware readout, intel_cdclk_update_hw_state() caches
crtc_state->min_cdclk in cdclk_state->min_cdclk[pipe] and caches
intel_dbuf_bw_min_cdclk(display, dbuf_bw_state) in
cdclk_state->dbuf_bw_min_cdclk.  When skl_dbuf_sanitize() then disables
the plane through intel_plane_disable_noatomic(),
intel_dbuf_bw_crtc_update_noatomic() zeroes the pipe's entry in
dbuf_bw_state, so a subsequent atomic modeset on that pipe sees both
old_dbuf_bw and new_dbuf_bw as zero and skips
intel_cdclk_update_dbuf_bw_min_cdclk() in intel_dbuf_bw_calc_min_cdclk():

drivers/gpu/drm/i915/display/intel_dbuf_bw.c:intel_dbuf_bw_calc_min_cdclk()=
 {
	...
	for_each_oldnew_intel_crtc_in_state(state, crtc, old_crtc_state, new_crtc_=
state) {
		struct intel_dbuf_bw old_dbuf_bw, new_dbuf_bw;

		skl_crtc_calc_dbuf_bw(&old_dbuf_bw, old_crtc_state);
		skl_crtc_calc_dbuf_bw(&new_dbuf_bw, new_crtc_state);

		if (!intel_dbuf_bw_changed(display, &old_dbuf_bw, &new_dbuf_bw))
			continue;
	...
	if (!old_dbuf_bw_state)
		return 0;
}

Similarly, intel_plane_set_invisible() zeroes plane_min_cdclk[plane->id]
and hsw_ips_disable() clears ips_enabled without recomputing
crtc_state->min_cdclk or cdclk_state->min_cdclk[pipe];
intel_initial_commit() then updates crtc_state->min_cdclk while
allow_cdclk_decrease is false, so later modesets where min_cdclk does not
change return early in intel_cdclk_update_crtc_min_cdclk() on
new_min_cdclk =3D=3D old_min_cdclk, keeping minimum CDCLK artificially
elevated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118033312.9023=
66-1-hanson.wang@ugreen.com?part=3D1
