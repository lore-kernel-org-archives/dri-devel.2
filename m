Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302DFCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AB610F597;
	Fri, 12 Jun 2026 14:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lICRTf8g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9962210F588
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 14:56:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C201B600AB;
 Fri, 12 Jun 2026 14:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBB31F000E9;
 Fri, 12 Jun 2026 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781276213;
 bh=dwjTbYV1+maZ04usytIv4qkuSpThfHBbJfbQOP67CjM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lICRTf8ggf4/bOeab8gtUtwm+dtbExqYHfPrzT2lbX5kRqAo4wdOKSF+KeiyUhrxH
 Wl/ShOHoSvaM6l2nQrc1X8Q4eNmb5UPvG6H1CsNL62fZPrC/DTzZYfhUwiOpvBivv2
 thmI87zZkog9k7qm1wBt53AdOmdDyk6PHPBd4b33JoyFXB6uUeECjulBa8GJI5EJb4
 NnOH/UmOplt1XKGRZGwiC0tYAkBomUDYuYBIzB5I9zW7udyfRnaXm1taOIm/eW+rru
 TYriInHtmhHy0KwkU6EQld+AfL60KXo53ZpH62DqUtnAX1kK2SY5U2lNnz9xwFuquq
 G3sRc9OXJtggw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/i915/panel: Attempt VRR based refresh rate
 change for !allow_modeset
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612144203.31715-5-ville.syrjala@linux.intel.com>
References: <20260612144203.31715-5-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 14:56:52 +0000
Message-Id: <20260612145653.5EBB31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] `_intel_panel_fixed_mode` can select a fixed mode with a lower=
 native refresh rate than requested, causing `vtotal` to be incorrectly shr=
unk below `vdisplay` and programmed into hardware.
- [High] VRR-based seamless refresh rate fastsets fail because `is_vrr_comp=
atible` incorrectly rejects stretched modes due to a mismatched `vtotal - v=
sync_start` offset.
--

commit 41ed53116263d4e38c4aa61dc4fe28e6a92d7c3c
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/i915/panel: Attempt VRR based refresh rate change for !allow_modeset

Adjusts the panel fixed mode selection to consider VRR-compatible modes=20
when userspace denies full modesets. This allows refresh rate changes via=20
the fastset path by adjusting the vblank length.

> diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm=
/i915/display/intel_panel.c
> index 6c539987f0a3f..a8af6a4d35bc5 100644
> --- a/drivers/gpu/drm/i915/display/intel_panel.c
> +++ b/drivers/gpu/drm/i915/display/intel_panel.c
> @@ -82,16 +82,37 @@ static bool is_best_fixed_mode(struct intel_connector=
 *connector,
>  		abs(drm_mode_vrefresh(best_mode) - vrefresh);
>  }
> =20
> +static bool is_vrr_compatible(const struct drm_display_mode *mode1,
> +			      const struct drm_display_mode *mode2)
> +{
> +	return drm_mode_match(mode1, mode2,
> +			      DRM_MODE_MATCH_CLOCK |
> +			      DRM_MODE_MATCH_TIMINGS_VRR |

[Severity: High]
Will this check reject valid stretched modes and prevent the fastset?

drm_mode_match() with DRM_MODE_MATCH_TIMINGS_VRR requires the offset
between vtotal and vsync_start to be identical between both modes.

However, the VRR logic in intel_panel_compute_config() stretches vtotal
without altering vsync_start or vsync_end. This means a stretched
vrr_ref_mode will have a larger vtotal - vsync_start offset than its base
fixed mode, causing is_vrr_compatible() to return false.

If is_vrr_compatible() returns false, _intel_panel_fixed_mode() fails to
find a matching mode and falls back to intel_panel_fixed_mode(). Since
allow_modeset is false, this fallback causes the core DRM modeset checks
to reject the commit, breaking the intended seamless switch.

> +			      DRM_MODE_MATCH_FLAGS |
> +			      DRM_MODE_MATCH_3D_FLAGS);
> +}
> +
> +static const struct drm_display_mode *
> +_intel_panel_fixed_mode(struct intel_connector *connector,
> +			const struct drm_display_mode *mode,
> +			const struct drm_display_mode *vrr_ref_mode)
> +{
> +	const struct drm_display_mode *fixed_mode, *best_mode =3D NULL;
> +	int vrefresh =3D drm_mode_vrefresh(mode);
> +
> +	if (vrr_ref_mode &&
> +	    (!intel_vrr_is_in_range(connector, vrefresh) ||
> +	     !intel_vrr_is_in_range(connector, drm_mode_vrefresh(vrr_ref_mode))=
))
> +		return NULL;
> +
>  	list_for_each_entry(fixed_mode, &connector->panel.fixed_modes, head) {
>  		int fixed_mode_vrefresh =3D drm_mode_vrefresh(fixed_mode);
> =20
> +		if (vrr_ref_mode &&
> +		    (!intel_vrr_is_in_range(connector, fixed_mode_vrefresh) ||
> +		     !is_vrr_compatible(fixed_mode, vrr_ref_mode)))
> +			continue;
> +
>  		if (is_best_fixed_mode(connector, vrefresh,
>  				       fixed_mode_vrefresh, best_mode))
>  			best_mode =3D fixed_mode;
>  	}

[Severity: Critical]
Does this loop inadvertently select a lower refresh rate mode that
later causes vtotal to shrink below vdisplay?

If userspace requests a transition from a lower to a higher refresh rate
without a full modeset, is_vrr_compatible() filters out the high refresh
rate fixed mode due to a dotclock mismatch.

The loop then evaluates the lower refresh rate fixed mode. Because this
is the first iteration where best_mode is NULL, is_best_fixed_mode()
unconditionally returns true and accepts the mode, bypassing the
requirement that fixed_mode_vrefresh >=3D vrefresh:

intel_panel.c:is_best_fixed_mode() {
        if (!best_mode)
                return true;
        ...
}

Later in intel_panel_compute_config(), the driver shrinks vtotal to match
the higher requested refresh rate using the lower dotclock:

intel_panel.c:intel_panel_compute_config() {
        ...
        if (is_vrr && fixed_mode_vrefresh !=3D vrefresh)
                adjusted_mode->vtotal =3D
                        DIV_ROUND_CLOSEST(adjusted_mode->clock * 1000,
                                          adjusted_mode->htotal * vrefresh);
        ...
}

Since both refresh rates fall within the VRR range, update_lrr is set
to true, which bypasses crtc_vtotal validation during the atomic check.

Could this regression result in programming a vtotal that is smaller than
vdisplay, leading to hardware hangs or pipeline underflows?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612144203.3171=
5-1-ville.syrjala@linux.intel.com?part=3D4
