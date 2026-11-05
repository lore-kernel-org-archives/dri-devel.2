Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE51E606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRrSev9z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1470910E2C1;
	Thu,  5 Nov 2026 16:44:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F9F10E937
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:44:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 259144344A;
 Thu,  5 Nov 2026 16:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E290F1F000C1;
 Thu,  5 Nov 2026 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793897060;
 bh=Bnwic6ZWFdQcVdLPPn7cR9TafUox5Nq4b2oC+oM31+w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mRrSev9zQNzfeUQrSYfE39JBfhBX2tESl6ZNdaAWqxjxdtNBJTrOpmYMYttFVVWYC
 US6KOCu5hRj5vMsqcS+3i5O7dx/vHb85Dex6bqhyajv01m3tdinlpNNFL5UpdESJTZ
 v9DtFvLg09EKPVckoR8+rcHzZnk3vXdVY9txUiJ3EVDKpdfIyFO2DXJpDd3eg3SfME
 5AmNjaPU2mkk3jiZoAnIecS1JtnsGdm4y5T9IQxnUT6xG7guSBjibJWF3QMcjxsiXq
 VX39whAHHPZvWOYAhP65MX0h6qRnGck6rJN5fHiC4iXh9T9zVln93FWEafVW+QGf7e
 /h8Htkh6FL8Ng==
Message-ID: <sashiko-outbox-199521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/27] drm: Add VRR state
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-1-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-1-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:44:19 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] drm/hdmi: division by zero in hdmi_calculate_vtotal() on zero denom
- [High] drm/hdmi: hdmi_validate_vrr() rejects modes with refresh below vrr=
_min
- [High] drm/hdmi: invalid VRR error returns and stale state in hdmi_valida=
te_vrr()
- [High] drm/hdmi: bypassed VRR validation and stale vrr_state in hdmi_vali=
date_vrr()
- [Medium] drm/hdmi: u64 quotient truncated to u32 in hdmi_calculate_vtotal=
()
- [Medium] drm/hdmi: rounded mode_refresh in hdmi_validate_vrr() inflates b=
ase_vtotal
- [Medium] drm/hdmi: hdmi_validate_vrr() skipped when CRTC VRR state change=
s alone
- [Low] drm/hdmi: wrong numerator variable in hdmi_calculate_vtotal() comme=
nt
--

commit e5085c76b79fa8bd381ce1216875922c59e1c24a
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm: Add VRR state

This commit adds struct drm_crtc_vrr_state to struct drm_crtc_state and
implements HDMI VRR state validation and vtotal calculation in
drm_hdmi_state_helper.c.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 7cdb7ca3dc12f..c1a84e30441a6 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -887,6 +887,210 @@ hdmi_generate_infoframes(const struct drm_connector=
 *connector,

[ ... ]

> +static int hdmi_calculate_vtotal(const struct drm_display_mode *mode,
> +				 u32 rate_n, u32 rate_d, u16 *out_vtotal,
> +				 u32 *out_denom, u32 *out_frame_err)
> +{
> +	u32 denom, result, err;
> +	u64 numerator;
> +
> +	/*

[ ... ]

> +	 *                        clock
> +	 * Vtotal =3D ----------------------------------
> +	 *            Htotal * target_n / target_d
> +	 *
> +	 * Some algebra brings us to:
> +	 *
> +	 *                clock * target_n
> +	 * Vtotal =3D ----------------------------------
> +	 *                Htotal * rate_n

[Severity: Low]
This isn't a bug since the code below multiplies mode->crtc_clock by rate_d,
but shouldn't the numerator in this comment be clock * target_d (or
clock * rate_d) rather than clock * target_n?

> +	 *
> +	 * The amount of timing error we accumulate every frame will be
> +	 * the remainder of that division.

[ ... ]

> +	 */
> +
> +	if (check_mul_overflow(mode->crtc_htotal, rate_n, &denom))
> +		return -ERANGE;
> +
> +	if (check_mul_overflow(mode->crtc_clock * 1000ULL, rate_d, &numerator))
> +		return -ERANGE;
> +
> +	result =3D div_u64_rem(numerator, denom, &err);
> +	if (result > U16_MAX)
> +		return -ERANGE;

[Severity: High]
Can div_u64_rem() divide by zero here when denom is 0?

check_mul_overflow(mode->crtc_htotal, rate_n, &denom) returns false and sets
denom =3D 0 whenever mode->crtc_htotal =3D=3D 0 or rate_n =3D=3D 0, and div=
_u64_rem()
is then called without checking !denom.

In drm_atomic_helper_connector_hdmi_check() -> hdmi_validate_vrr(), mode is
taken from &new_crtc_state->mode during connector atomic_check before
mode_fixup() has run. If an in-kernel KMS caller or KUnit test sets a mode =
on
a CRTC via drm_atomic_set_mode_for_crtc() that was constructed without
drm_mode_set_crtcinfo() (such as via drm_display_mode_from_cea_vic(),
drm_kunit_display_mode_from_cea_vic(), DRM_MODE(), or DRM_MODE_INIT()),
mode->htotal and mode->vtotal are populated so drm_mode_vrefresh(mode)
succeeds, vfront (mode->crtc_vsync_start - mode->crtc_vdisplay) is 0, and
hdmi_calculate_vtotal() is reached with mode->crtc_htotal =3D=3D 0.

Similarly, drm_mode_vrefresh() returns 0 (never negative) on invalid timings
or overflow, and hdmi_validate_vrr() only rejects mode_refresh < 0 ||
mode_refresh > 1023, so mode_refresh =3D=3D 0 can also clamp max_vfreq_n to=
 0 and
pass rate_n =3D=3D 0 into hdmi_calculate_vtotal().

[Severity: Medium]
Also in hdmi_calculate_vtotal(), since result is declared as u32 while
numerator is u64, doesn't assigning the return value of div_u64_rem() to
result truncate the upper 32 bits before checking result > U16_MAX (and rai=
se
a divide error #DE in do_div() on 32-bit x86 if the quotient exceeds
U32_MAX)?

For example, a custom mode passed via DRM_IOCTL_MODE_ATOMIC with a large
clock and vscan > 1 (which reduces drm_mode_vrefresh(mode) without increasi=
ng
mode->crtc_htotal) can keep drm_mode_vrefresh(mode) <=3D 1023 while produci=
ng a
quotient in hdmi_calculate_vtotal() such as 0x10000040dULL, which truncates
to u32 result =3D 0x40d and bypasses the result > U16_MAX check. Should res=
ult
be u64 (or div64_u64_rem())?

> +
> +	if (out_vtotal)
> +		*out_vtotal =3D result;
> +	if (out_denom)
> +		*out_denom =3D denom;
> +	if (out_frame_err)
> +		*out_frame_err =3D err;
> +
> +	return 0;
> +}
> +
> +static int hdmi_validate_vrr(struct drm_connector *connector,
> +			     struct drm_atomic_commit *state)
> +{
> +	struct drm_connector_state *new_conn_state =3D
> +		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_crtc_state *new_crtc_state =3D
> +		drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
> +	struct drm_crtc_vrr_state *vrr_state =3D
> +		&new_crtc_state->vrr_state;
> +	struct drm_display_info *info =3D &connector->display_info;
> +	const struct drm_display_mode *mode =3D &new_crtc_state->mode;
> +	struct drm_device *dev =3D connector->dev;
> +	int mode_refresh, vfront, ret;
> +	u32 min_vfreq_n =3D info->hdmi.vrr_cap.vrr_min;
> +	u32 min_vfreq_d =3D 1;
> +	u32 max_vfreq_n =3D info->hdmi.vrr_cap.vrr_max;
> +	u32 max_vfreq_d =3D 1;
> +
> +	if (!new_crtc_state->vrr_enabled)
> +		return 0;
> +
> +	if (!info->hdmi.vrr_cap.supported)
> +		return -EOPNOTSUPP;

[Severity: High]
Does returning -EOPNOTSUPP here (and -EINVAL below when the mode or sink
cannot do HDMI VRR) break the DRM UAPI contract for VRR_ENABLED, and does
returning 0 when !new_crtc_state->vrr_enabled leave stale values in
new_crtc_state->vrr_state?

1. The documentation for drm_crtc_state.vrr_enabled in include/drm/drm_crtc=
.h
states:

	/*
	 * Indicates if variable refresh rate should be enabled for the CRTC.
	 * Support for the requested vrr state will depend on driver and
	 * hardware capabiltiy - lacking support is not treated as failure.
	 */

Every atomic CRTC attaches VRR_ENABLED in drm_crtc_init_with_planes(), and
drm_atomic_helper_connector_hdmi_check() unconditionally calls
hdmi_validate_vrr(). Because __drm_atomic_helper_set_config() and
drm_client_modeset_commit_atomic() preserve crtc->state->vrr_enabled across
modesets, hotplugging a non-VRR HDMI sink while VRR_ENABLED is set causes
subsequent fbdev/drm_client console restores and legacy SETCRTC calls to fa=
il
with -EOPNOTSUPP. It also rejects commits on HDMI drivers that use
drm_atomic_helper_connector_hdmi_check() without supporting VRR, as well as
connectors set to VRR_DISPLAY_MODE_OFF in later commit "drm/connector: add
vrr_display_mode connector property".

2. When new_crtc_state->vrr_enabled transitions from true to false,
__drm_atomic_helper_crtc_duplicate_state() copies the previous
crtc->state->vrr_state via memcpy(). Returning 0 immediately at
if (!new_crtc_state->vrr_enabled) without clearing new_crtc_state->vrr_state
leaves base_vtotal, max_vtotal, cur_vtotal, and dynamic populated. In later
commit "drm/connector: hdmi: Add VTEM EMP generation",
hdmi_generate_emp_infoframe_vtem() sets vtem->m_const =3D !vrr->dynamic, so
leaving vrr->dynamic as true transmits M_CONST =3D 0 when VRR is disabled. =
In
addition, in later commit "drm/rockchip: vop2: Enable VRR" (with
"drm/crtc-helper: Add VRR helper functions"), vop2_crtc_atomic_flush() only
calls drm_crtc_helper_vrr_flush() when crtc_state->vrr_enabled is true; sin=
ce
cur_vtotal was not cleared when VRR was disabled, re-enabling VRR at the sa=
me
base_vtotal sees cur_vtotal =3D=3D base_vtotal and skips reprogramming the
hardware VTOTAL register.

> +
> +	mode_refresh =3D drm_mode_vrefresh(mode);
> +
> +	/* HDMI uses 10 bits to signal the base refresh. */\
> +	if (mode_refresh < 0 || mode_refresh > 1023) {
> +		drm_dbg_kms(dev, "Mode's refresh of %dHz > HDMI VRR maximum (1023)\n",
> +			    mode_refresh);
> +		return -EINVAL;
> +	}
> +
> +	if (!max_vfreq_n || max_vfreq_n > mode_refresh)
> +		max_vfreq_n =3D mode_refresh;
> +
> +	if (!min_vfreq_n) {
> +		drm_dbg_kms(dev, "Could not get minimum VRR rate from sink\n");
> +		return -EINVAL;
> +	}
> +
> +	vfront =3D mode->crtc_vsync_start - mode->crtc_vdisplay;
> +	if (vfront < 0 || vfront > U8_MAX) {
> +		drm_dbg_kms(dev, "Vfront of %d would not fit in VTEM packet\n", vfront=
);
> +		return -EINVAL;
> +	}
> +
> +	if (cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > =
0) {
> +		drm_dbg_kms(dev, "Target max (%u/%u) > target min (%u/%u)\n",
> +			    max_vfreq_n, max_vfreq_d, min_vfreq_n, min_vfreq_d);
> +		return -EINVAL;
> +	}

[Severity: High]
Doesn't clamping max_vfreq_n to mode_refresh before this cmp_fraction() che=
ck
cause hdmi_validate_vrr() to reject any mode whose refresh rate is below the
sink's vrr_min (such as 24Hz, 25Hz, or 30Hz modes on a 48-120Hz HDMI 2.1 TV=
)?

Because max_vfreq_n is clamped to at most mode_refresh above, whenever
mode_refresh < min_vfreq_n we have min_vfreq_n > max_vfreq_n, so
cmp_fraction(min_vfreq_n, min_vfreq_d, max_vfreq_n, max_vfreq_d) > 0 is true
and returns -EINVAL (while also logging an inverted debug message claiming
Target max > target min). That also makes the fallback branch further down:

	if (cmp_fraction(min_vfreq_n, min_vfreq_d, mode_refresh, 1) >=3D 0) {
		/* refresh <=3D VRR min, don't do VRR vtotal adjustment */
		vrr_state->max_vtotal =3D mode->crtc_vtotal;
	}

unreachable whenever mode_refresh < min_vfreq_n.

> +
> +	ret =3D hdmi_calculate_vtotal(mode, max_vfreq_n, max_vfreq_d,
> +				    &vrr_state->base_vtotal, NULL, NULL);
> +	if (ret) {
> +		drm_dbg_kms(dev, "Couldn't calculate base_vtotal: %pe\n", ERR_PTR(ret)=
);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Even at its fastest, it can't go faster than the mode, so
> +	 * clamp to avoid imprecisely rounded mode_refresh values we
> +	 * can't do anything about from ruining our day.
> +	 */
> +	vrr_state->base_vtotal =3D max(vrr_state->base_vtotal, mode->crtc_vtota=
l);
> +
> +	if (cmp_fraction(min_vfreq_n, min_vfreq_d, mode_refresh, 1) >=3D 0) {
> +		/* refresh <=3D VRR min, don't do VRR vtotal adjustment */
> +		vrr_state->max_vtotal =3D mode->crtc_vtotal;
> +	} else {

[Severity: Medium]
What happens here when drm_mode_vrefresh(mode) rounds down a mode's
fractional refresh rate?

When !max_vfreq_n || max_vfreq_n > mode_refresh, max_vfreq_n is set to the
integer-rounded mode_refresh from drm_mode_vrefresh(mode) (which uses
DIV_ROUND_CLOSEST_ULL). If the mode's actual refresh rate has a fractional
part in (0, 0.5) Hz (for example, 800x600@60.317Hz with clock =3D 40000,
htotal =3D 1056, vtotal =3D 628 where drm_mode_vrefresh() rounds down to 60=
, or a
48.4Hz mode with clock =3D 48400, htotal =3D 1000, vtotal =3D 1000 where
drm_mode_vrefresh() rounds down to 48), hdmi_calculate_vtotal() divides by
the smaller rounded rate and computes vrr_state->base_vtotal >
mode->crtc_vtotal (631 > 628, or 1008 > 1000).

Clamping with max(vrr_state->base_vtotal, mode->crtc_vtotal) only guards
against mode_refresh rounding up, not rounding down. Moreover, if
min_vfreq_n =3D=3D mode_refresh (e.g. vrr_min =3D 48 on the 48.4Hz mode), t=
he
cmp_fraction(min_vfreq_n, min_vfreq_d, mode_refresh, 1) >=3D 0 branch sets
vrr_state->max_vtotal =3D mode->crtc_vtotal (1000), leaving
vrr_state->base_vtotal (1008) > vrr_state->max_vtotal (1000).

When max_vfreq is not capped below the mode's refresh rate, shouldn't
vrr_state->base_vtotal simply be mode->crtc_vtotal?

[ ... ]

> @@ -919,6 +1123,10 @@ int drm_atomic_helper_connector_hdmi_check(struct d=
rm_connector *connector,
> =20
>  	new_conn_state->hdmi.is_limited_range =3D hdmi_is_limited_range(connect=
or, new_conn_state);
> =20
> +	ret =3D hdmi_validate_vrr(connector, state);
> +	if (ret)
> +		return ret;

[Severity: High]
Is calling hdmi_validate_vrr() only from
drm_atomic_helper_connector_hdmi_check() sufficient when userspace updates
CRTC VRR properties without a modeset or connector property change?

VRR_ENABLED (as well as the VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR} properties
added later in commit "drm: Add VRR target frame rate properties") are CRTC
properties stored on struct drm_crtc_state. In
drm_atomic_helper_check_modeset(), drm_atomic_add_affected_connectors() is
only called when drm_atomic_crtc_needs_modeset() is true. If userspace
submits a DRM_IOCTL_MODE_ATOMIC commit that changes VRR properties on an
active CRTC without changing MODE_ID, ACTIVE, or any connector property, the
connector is not added to state->connectors and
drm_atomic_helper_connector_hdmi_check() -> hdmi_validate_vrr() is never
invoked.

Although later commit "drm/rockchip: Set mode_changed on vrr_enabled change"
sets mode_changed =3D true in rockchip_drm_atomic_check() when vrr_enabled
toggles, other HDMI drivers using drm_atomic_helper_connector_hdmi_check()
with drm_atomic_helper_check() will skip hdmi_validate_vrr() when VRR_ENABL=
ED
toggles, leaving new_crtc_state->vrr_state uncomputed (or stale). Even on
Rockchip, updating VRR_{MIN,MAX}_{NUMERATOR,DENOMINATOR} while vrr_enabled
remains true does not set mode_changed or add the connector to the atomic
state, bypassing hdmi_validate_vrr() and VTEM infoframe regeneration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D1
