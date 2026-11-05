Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E36083603
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UMj6lz+O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 242A910E669;
	Thu,  5 Nov 2026 17:17:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B10410E10B
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:17:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 000CA41310;
 Thu,  5 Nov 2026 17:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE531F00A15;
 Thu,  5 Nov 2026 17:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793899066;
 bh=F9T9YpU1s2I8r/Yv7Y6GzzVs12j2WPffqcAaE6SvYiY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UMj6lz+OJ334X5aXUcQvQGzKr2OmKtg9ljXKL9j7iHYWJBRMzYGX88VViNf+uY3QL
 VthMhwf/JAJEawHU2TQU+9bZ3vwY4ByccDF1ac6baSpvu5XCeiM3MRediefsV3wo2H
 j+KNOXbobc3OKybve4HnWS6KpVvI8UlLFtAxIVj+4hn1NjuXbYxiomUOnO43OSABLe
 iAzWuAgzMWR0mrHutdPHpTLcvJhvmbrMy3EhpWqwfMfuj1/ZIUUhvMJQXTPLAaWJsZ
 JhtOY6p4gVg/PCll3Z+/3Bw/Oc7OR432SRTwCYNJOkcgziGMn2QfM0DcdARmJcW8tX
 5n/bLEMd8khWA==
Message-ID: <sashiko-outbox-199593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/27] drm: Implement VRR rate limiting
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-11-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-11-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:17:46 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm: NULL pointer dereference on old_conn_state->crtc in hdmi_vali=
date_vrr()
- [High] drm: zero-denominator WARN_ON() in cmp_fraction() from hdmi_valida=
te_vrr()
- [Medium] drm: signed 32-bit overflow in cur_err in drm_crtc_helper_vrr_vs=
ync()
- [Medium] drm: fixed-rate VRR validation bugs in hdmi_validate_vrr_limits()
- [Medium] drm: lost vrr_state updates due to in-place mutation in drm_crtc=
_helper_vrr_vsync()
- [Low] drm: redundant overflow check and unused limit_d in hdmi_validate_v=
rr_limits()
--

commit 41d8f0b98056d34444a098f24f445d7ca3d40b1e
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm: Implement VRR rate limiting

This commit implements VRR target frame rate limiting in the HDMI state
and CRTC VRR helpers, allowing userspace to restrict the VRR refresh rate
range or configure a fixed target frame rate with per-frame error dithering.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 497af307a690c..1e576dfbd856d 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -1051,15 +1052,60 @@ static int hdmi_calculate_vtotal(const struct drm=
_display_mode *mode,
>  	return 0;
>  }
> =20
> +static int hdmi_validate_vrr_limits(struct drm_crtc_state *crtc_state, u=
16 vrr_min)
> +{
> +	struct drm_crtc_vrr_state *vrr_state =3D &crtc_state->vrr_state;
> +	const struct drm_display_mode *mode =3D &crtc_state->mode;
> +	u32 limit_d;
> +	u8 round;
> +	int ret;
> +
> +	/* No limiter, don't need to validate, but reset the error */
> +	if (!drm_crtc_helper_vrr_is_fixed_rate(vrr_state)) {
> +		vrr_state->per_frame_err =3D 0;
> +		vrr_state->cur_err =3D 0;
> +		return 0;
> +	}
> +
> +	/* Don't allow rates equal to or below the minimum VRR rate / 1.001 */
> +	if (cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
> +			 vrr_min * 1000, 1001) < 0)
> +		return -EINVAL;
> +
> +	if (check_mul_overflow(mode->crtc_htotal, vrr_state->vrr_min_n, &limit_=
d))
> +		return -ERANGE;

[Severity: Low]
As reported by Sashiko on RFC [1], this isn't a bug, but is this
check_mul_overflow() into the unused limit_d variable redundant since
hdmi_calculate_vtotal() immediately checks mode->crtc_htotal * rate_n as
its first operation?

> +
> +	ret =3D hdmi_calculate_vtotal(&crtc_state->mode, vrr_state->vrr_min_n,
> +				    vrr_state->vrr_min_d, &vrr_state->base_vtotal,
> +				    &vrr_state->denom, &vrr_state->per_frame_err);
> +	if (ret)
> +		return ret;
> +
> +	/* Allow rounding up for the vtotal check below */
> +	if (vrr_state->per_frame_err >=3D vrr_state->denom / 2)
> +		round =3D 1;
> +	else
> +		round =3D 0;
> +
> +	if (vrr_state->base_vtotal + round < mode->crtc_vtotal)
> +		return -EINVAL;

[Severity: Medium]
As reported by Sashiko on RFC [1], can hdmi_validate_vrr_limits() and
hdmi_validate_vrr() allow invalid hardware timings in fixed-rate mode?

First, when per_frame_err >=3D denom / 2, round is 1, so the check above
accepts base_vtotal =3D=3D mode->crtc_vtotal - 1 without clamping base_vtot=
al
to mode->crtc_vtotal. When drm_crtc_helper_vrr_vsync() runs on frames
where cur_err < denom / 2 (including the initial frame where cur_err is 0),
it sets cur_vtotal =3D base_vtotal, programming a vtotal one line smaller
than mode->crtc_vtotal.

Second, if hdmi_calculate_vtotal() produces base_vtotal =3D=3D U16_MAX with
per_frame_err >=3D denom / 2, drm_crtc_helper_vrr_vsync() will compute
vrr->cur_vtotal =3D vrr->base_vtotal + 1, wrapping the u16 cur_vtotal to 0.

Third, in hdmi_validate_vrr(), the check against max_vfreq_n is placed
inside the if (!is_fixed) block, so a fixed target rate exceeding
info->hdmi.vrr_cap.vrr_max (when vrr_max < mode_refresh) is not rejected.

> +
> +	return 0;
> +}
> +
>  static int hdmi_validate_vrr(struct drm_connector *connector,
>  			     struct drm_atomic_commit *state)
>  {
>  	struct drm_connector_state *new_conn_state =3D
>  		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_connector_state *old_conn_state =3D
> +		drm_atomic_get_old_connector_state(state, connector);
>  	struct drm_crtc_state *new_crtc_state =3D
>  		drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
>  	struct drm_crtc_vrr_state *vrr_state =3D
>  		&new_crtc_state->vrr_state;
> +	struct drm_crtc_vrr_state *old_vrr_state;
> +	struct drm_crtc_state *old_crtc_state =3D NULL;
>  	struct drm_display_info *info =3D &connector->display_info;
>  	const struct drm_display_mode *mode =3D &new_crtc_state->mode;
>  	struct drm_device *dev =3D connector->dev;
> @@ -1068,10 +1114,14 @@ static int hdmi_validate_vrr(struct drm_connector=
 *connector,
>  	u32 min_vfreq_d =3D 1;
>  	u32 max_vfreq_n =3D info->hdmi.vrr_cap.vrr_max;
>  	u32 max_vfreq_d =3D 1;
> +	bool is_fixed;
> =20
>  	if (!new_crtc_state->vrr_enabled)
>  		return 0;
> =20
> +	if (old_conn_state)
> +		old_crtc_state =3D drm_atomic_get_old_crtc_state(state, old_conn_state=
->crtc);

[Severity: High]
Can this dereference a NULL pointer when enabling VRR on a connector that
was previously disabled or unassigned?

When a connector in the atomic commit is newly routed to a CRTC with VRR
enabled, old_conn_state is non-NULL, but old_conn_state->crtc is NULL.
Passing old_conn_state->crtc to drm_atomic_get_old_crtc_state() invokes
drm_crtc_index(NULL), which immediately dereferences crtc->index:

include/drm/drm_atomic.h:drm_atomic_get_old_crtc_state() {
	return state->crtcs[drm_crtc_index(crtc)].old_state;
}

Also, if a connector is moved directly from one CRTC to another,
old_conn_state->crtc points to the previous CRTC rather than
new_conn_state->crtc from which new_crtc_state->vrr_state was duplicated.
Should this look up the old CRTC state via new_conn_state->crtc instead?

> +
>  	if (!info->hdmi.vrr_cap.supported)
>  		return -EOPNOTSUPP;
> =20
> @@ -1087,6 +1137,21 @@ static int hdmi_validate_vrr(struct drm_connector =
*connector,
>  	if (!max_vfreq_n || max_vfreq_n > mode_refresh)
>  		max_vfreq_n =3D mode_refresh;
> =20
> +	is_fixed =3D drm_crtc_helper_vrr_is_fixed_rate(vrr_state);
> +	if (is_fixed && info->hdmi.vrr_cap.cinema_vrr)
> +		min_vfreq_n =3D 24;
> +
> +	/* If the VRR target changed, make sure to reset the error accumulator =
*/
> +	if (old_crtc_state) {
> +		old_vrr_state =3D &old_crtc_state->vrr_state;
> +		if (drm_crtc_helper_vrr_is_fixed_rate(old_vrr_state) !=3D is_fixed ||
> +		    cmp_fraction(vrr_state->vrr_min_n, vrr_state->vrr_min_d,
> +				 old_vrr_state->vrr_min_n, old_vrr_state->vrr_min_d) ||
> +		    cmp_fraction(vrr_state->vrr_max_n, vrr_state->vrr_max_d,
> +				 old_vrr_state->vrr_max_n, old_vrr_state->vrr_max_d))
> +			vrr_state->cur_err =3D 0;
> +	}

[Severity: High]
Will this trigger the WARN_ON(!b || !d) in cmp_fraction() when VRR is
enabled without a fixed target rate?

When neither old_vrr_state nor vrr_state is a fixed rate (for example,
normal unconstrained VRR where vrr_min_d and vrr_max_d are 0 in both
states, or when transitioning between unconstrained VRR and a bounded
range), drm_crtc_helper_vrr_is_fixed_rate(old_vrr_state) !=3D is_fixed is
false. Evaluation then falls through to cmp_fraction() with zero
denominators:

drivers/gpu/drm/display/drm_hdmi_state_helper.c:cmp_fraction() {
	u64 a_d =3D mul_u32_u32(a, d);
	u64 b_c =3D mul_u32_u32(b, c);

	if (WARN_ON(!b || !d))
		return -EDOM;
	...
}

> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc=
_helper.c
> index 4ffb3b0b78780..dd696f0c50169 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c

[ ... ]

> @@ -889,10 +908,21 @@ bool drm_crtc_helper_vrr_vsync(struct drm_crtc_stat=
e *crtc_state)
>  	struct drm_crtc_vrr_state *vrr =3D &crtc_state->vrr_state;
>  	u16 old_vtotal =3D vrr->cur_vtotal;
> =20
> -	if (!crtc_state->vrr_enabled)
> +	if (!crtc_state->vrr_enabled) {
>  		vrr->cur_vtotal =3D 0;
> -	else
> +		vrr->cur_err =3D 0;
> +	} else if (drm_crtc_helper_vrr_is_fixed_rate(vrr)) {
> +		if (vrr->cur_err >=3D (int) (vrr->denom / 2)) {
> +			vrr->cur_err -=3D vrr->denom;
> +			vrr->cur_vtotal =3D vrr->base_vtotal + 1;
> +		} else {
> +			vrr->cur_vtotal =3D vrr->base_vtotal;
> +		}
> +
> +		vrr->cur_err +=3D vrr->per_frame_err;

[Severity: Medium]
Can vrr->cur_err overflow a signed 32-bit int here?

In struct drm_crtc_vrr_state, denom and per_frame_err are u32, while
cur_err is a signed 32-bit int. hdmi_calculate_vtotal() allows denom
(mode->crtc_htotal * rate_n) to be any u32 up to U32_MAX, and
per_frame_err can be up to denom - 1.

When vrr->cur_err < (int)(vrr->denom / 2), vrr->denom is not subtracted
before adding vrr->per_frame_err, so the sum can reach roughly
1.5 * denom - 2. Whenever denom exceeds 1,431,655,765 (for example,
crtc_htotal =3D 2200 and vrr_min_n =3D 1,000,000), vrr->cur_err +=3D
vrr->per_frame_err overflows INT_MAX and wraps negative.

[Severity: Medium]
Also, can in-place updates to vrr->cur_err, vrr->cur_vtotal, and
vrr->dynamic in drm_crtc_helper_vrr_vsync() be lost across atomic commits?

During atomic commits, drm_atomic_get_crtc_state() duplicates crtc->state
into new_crtc_state under crtc->mutex while the vblank interrupt handler
can concurrently call drm_crtc_helper_vrr_vsync(crtc->state) and mutate
the old crtc->state->vrr_state in place. When drm_atomic_helper_swap_state()
later installs new_crtc_state into crtc->state, any vrr_state updates
performed by drm_crtc_helper_vrr_vsync() after atomic_duplicate_state()
are overwritten by the stale copy in new_crtc_state.

[1] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-14-2fcd7d011646@=
collabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D11
