Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5B606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsKpBAav
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6EE10E2BF;
	Thu,  5 Nov 2026 17:53:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F9110E953
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:53:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7243C60181;
 Thu,  5 Nov 2026 17:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0141F00A16;
 Thu,  5 Nov 2026 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793901205;
 bh=YPqBysafpcPfu4ssltHyj984FPfpeh4/6vYcfcqDPms=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QsKpBAavPhYdoitOF0OPDRRiD02bwwvvOki2lSI9PzTeN7uxgqTXpZfNmvu6MTR7e
 rk+Odb08z2Tg/bCcow2XbFXiy+t8Vp0UhkGz599KuR6mEY6jOv99RPlFg/j28WbsEU
 v4AGl4QMO97OSWiRbTQR3j+Urxc1LLsdX7P4pDRIaTfpQ0t3RVXiZ5yrHB0U6pgIve
 ypIvkFAROiITYjhFNYPTKBQS5KVyQGzfk3ahKMdMeYhOP1LZtuI/GWMl4uCk0mP3rh
 v0QcGve0P7WsNnBG6VVJOb5UiqgmfIe0RtVTck+crvMsAO6DDfWzqf2pTB6UiEnD5y
 /tFo6vG8n7M5A==
Message-ID: <sashiko-outbox-199667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/27] drm/connector: hdmi: Add QMS state validation
 and computation
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-20-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-20-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:53:24 +0000
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
- [High] drm/connector: hdmi: NULL old_conn_state->crtc dereference in hdmi=
_validate_vrr()
- [Medium] drm/connector: hdmi: QMS rates rejected in hdmi_validate_qms() w=
hen vrr_max is 0
- [Medium] drm/connector: hdmi: mismatched QMS checks in hdmi_validate_vrr(=
) and VTEM path
- [Medium] drm/connector: hdmi: broken vrr_state->dynamic tracking in hdmi_=
validate_vrr()
- [Medium] drm/connector: hdmi: unhandled VRR_DISPLAY_MODE_OFF and ungated =
cinema_vrr check
- [Low] drm/connector: hdmi: missing @conn_state in hdmi_validate_qms() ker=
nel-doc
--

commit ca0c861772300673280d14b0f18ffdb23766fd49
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/connector: hdmi: Add QMS state validation and computation

This commit adds validation and state computation for HDMI Quick Media
Switching to hdmi_validate_vrr() and introduces hdmi_validate_qms() to
verify target frame rates and compute the signaling byte.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 892079e41a0fb..ef08a72e33f3e 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c

[ ... ]

> @@ -992,6 +1013,66 @@ static int cmp_fraction(u32 a, u32 b, u32 c, u32 d)
>  	return 0;
>  }
> =20
> +/**
> + * hdmi_validate_qms - Validate HDMI QMS state
> + * @crtc_state: pointer to a &struct drm_crtc_state to run validation on
> + * @info: pointer to a &struct drm_display_info of the accompanying conn=
ector
> + *
> + * Validate that the drm_crtc_vrr_state.vrr_min_numerator and
> + * drm_crtc_vrr_state.vrr_min_denominator are acceptable for HDMI QMS, a=
nd check
> + * that the display is HDMI QMS capable.
> + *
> + * Returns:
> + *  - Negative errno on failure
> + *  - the corresponding QMS signaling byte for the target frame rate oth=
erwise
> + */
> +static int hdmi_validate_qms(struct drm_crtc_state *crtc_state,
> +			     struct drm_connector_state *conn_state,
> +			     const struct drm_display_info *info)

[Severity: Low]
This isn't a bug, but the kernel-doc comment for hdmi_validate_qms() omits
the @conn_state parameter, which triggers a kernel-doc warning when building
with W=3D1. Also, the comment body refers to vrr_min_numerator and
vrr_min_denominator instead of the struct drm_crtc_vrr_state fields
vrr_min_n and vrr_min_d.

> +{
> +	u32 rate_n =3D crtc_state->vrr_state.vrr_min_n;
> +	u32 rate_d =3D crtc_state->vrr_state.vrr_min_d;
> +	u32 min_rate_n, max_rate;
> +	u32 g, i;
> +
> +	if (conn_state->vrr_display_mode !=3D VRR_DISPLAY_MODE_MEDIA)
> +		return 0;
> +
> +	if (!drm_crtc_helper_vrr_is_fixed_rate(&crtc_state->vrr_state))
> +		return -EINVAL;
> +
> +	if (info->hdmi.vrr_cap.qms_tfr_min)
> +		min_rate_n =3D 24000;
> +	else
> +		min_rate_n =3D info->hdmi.vrr_cap.vrr_min * 1000;
> +
> +	if (info->hdmi.vrr_cap.qms_tfr_max)
> +		max_rate =3D info->hdmi.vrr_cap.vrr_max;
> +	else
> +		max_rate =3D 60;
> +
> +	g =3D gcd(rate_n, rate_d);
> +	if (g !=3D 1) {
> +		rate_n /=3D g;
> +		rate_d /=3D g;
> +	}
> +
> +	if (!rate_d)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hdmi_qms_tfrs); i++) {
> +		if (cmp_fraction(min_rate_n, 1001, hdmi_qms_tfrs[i].rate_n,
> +				 hdmi_qms_tfrs[i].rate_d) > 0)
> +			continue;
> +		if (rate_n =3D=3D hdmi_qms_tfrs[i].rate_n &&
> +		    rate_d =3D=3D hdmi_qms_tfrs[i].rate_d &&
> +		    cmp_fraction(rate_n, rate_d, max_rate, 1) <=3D 0)
> +			return hdmi_qms_tfrs[i].tfr_byte;
> +	}
> +
> +	return -EINVAL;
> +}

[Severity: Medium]
What happens in hdmi_validate_qms() when info->hdmi.vrr_cap.qms_tfr_max is
true, but info->hdmi.vrr_cap.vrr_max is 0?

In include/drm/drm_connector.h, struct drm_hdmi_vrr_cap documents that
vrr_max =3D=3D 0 is a valid value (and occurs on sinks that only support me=
dia
switching without game variable refresh rate), and that qms_tfr_min and
qms_tfr_max fall back to monitor_range:

	/**
	 * @vrr_max : maximum supported variable refresh rate in Hz (optional).
	 * Valid values are either 0 (max based on video mode) or >=3D 100
	 */
	u16 vrr_max;
	...
	/**
	 * @qms_tfr_min: If set, the sink uses 24/1.001Hz as its minimum rate
	 * for QMS. If unset, @drm_display_info.monitor_range.min_vfreq is used.
	 */
	bool qms_tfr_min;

	/**
	 * @qms_tfr_max: If set, @drm_display_info.monitor_range.max_vfreq is
	 * used by the sink as its maximum rate for QMS. If unset, 60Hz is used.
	 */
	bool qms_tfr_max;

When qms_tfr_max is set and vrr_max is 0, max_rate becomes 0 in
hdmi_validate_qms(), so cmp_fraction(rate_n, rate_d, max_rate, 1) <=3D 0
evaluates to false for every entry in hdmi_qms_tfrs[] and rejects all target
frame rates.

Similarly, on a sink that supports media switching without game variable
refresh rate (where vrr_min is 0) and has qms_tfr_min unset, neither
hdmi_validate_qms() nor hdmi_validate_vrr() consults
info->monitor_range.min_vfreq, leaving min_vfreq_n as 0 and failing validat=
ion
at if (!min_vfreq_n) in hdmi_validate_vrr().

Should hdmi_validate_qms() and hdmi_validate_vrr() fall back to
info->monitor_range.min_vfreq and info->monitor_range.max_vfreq (or
mode_refresh) when vrr_min or vrr_max is 0?

[ ... ]

> @@ -1129,8 +1210,17 @@ static int hdmi_validate_vrr(struct drm_connector =
*connector,
>  	if (old_conn_state)
>  		old_crtc_state =3D drm_atomic_get_old_crtc_state(state, old_conn_state=
->crtc);

[Severity: High]
Can old_conn_state->crtc be NULL here when a previously disabled connector =
is
enabled in the same atomic commit that enables variable refresh rate on the
crtc?

In include/drm/drm_atomic.h, drm_atomic_get_old_crtc_state() indexes
state->crtcs using drm_crtc_index(crtc) without checking if crtc is NULL:

static inline struct drm_crtc_state *
drm_atomic_get_old_crtc_state(const struct drm_atomic_commit *state,
			      struct drm_crtc *crtc)
{
	return state->crtcs[drm_crtc_index(crtc)].old_state;
}

Should this check if (old_conn_state && old_conn_state->crtc) before calling
drm_atomic_get_old_crtc_state()?

> -	if (!info->hdmi.vrr_cap.supported)
> -		return -EOPNOTSUPP;
> +	switch (new_conn_state->vrr_display_mode) {
> +	case VRR_DISPLAY_MODE_GAME:
> +		if (!info->hdmi.vrr_cap.supported)
> +			return -EOPNOTSUPP;
> +		break;
> +	case VRR_DISPLAY_MODE_MEDIA:
> +		if (!info->hdmi.vrr_cap.qms_capable ||
> +		    !connector->hdmi.qms_supported)
> +			return -EOPNOTSUPP;
> +		break;
> +	}

[Severity: Medium]
How does this capability check interact with
hdmi_generate_emp_infoframe_vtem()?

In drivers/gpu/drm/display/drm_hdmi_state_helper.c,
hdmi_generate_emp_infoframe_vtem() still returns early when
!info->hdmi.vrr_cap.supported:

	if (!info->hdmi.vrr_cap.supported)
		return 0;
	...
	case VRR_DISPLAY_MODE_MEDIA:
		if (!connector->hdmi.qms_supported)
			return -EOPNOTSUPP;
		vtem->qms_en =3D true;
		vtem->next_tfr =3D conn_state->hdmi.qms_tfr_byte;
		vtem->m_const =3D !vrr->dynamic;
		break;

On a sink where info->hdmi.vrr_cap.qms_capable is true but
info->hdmi.vrr_cap.supported is false, hdmi_validate_vrr() now accepts the
commit, but hdmi_generate_emp_infoframe_vtem() skips generating the infofra=
me.

Conversely, when new_crtc_state->vrr_enabled is false and vrr_display_mode =
is
set to media mode, hdmi_validate_vrr() returns 0 early at:

	if (!new_crtc_state->vrr_enabled)
		return 0;

without checking info->hdmi.vrr_cap.qms_capable or updating
new_conn_state->hdmi.qms_tfr_byte, while hdmi_generate_emp_infoframe_vtem()
still runs and sets vtem->qms_en =3D true with an unvalidated 0 or stale
qms_tfr_byte from a previous commit.

Should hdmi_generate_emp_infoframe_vtem() and hdmi_validate_vrr() check the
same conditions for media mode and crtc_state->vrr_enabled?

>  	mode_refresh =3D drm_mode_vrefresh(mode);
> =20
> @@ -1145,7 +1235,10 @@ static int hdmi_validate_vrr(struct drm_connector =
*connector,
>  		max_vfreq_n =3D mode_refresh;
> =20
>  	is_fixed =3D drm_crtc_helper_vrr_is_fixed_rate(vrr_state);
> -	if (is_fixed && info->hdmi.vrr_cap.cinema_vrr)
> +	if (is_fixed && ((info->hdmi.vrr_cap.qms_tfr_min &&
> +			  new_conn_state->vrr_display_mode =3D=3D VRR_DISPLAY_MODE_MEDIA &&
> +			  connector->hdmi.qms_supported && info->hdmi.vrr_cap.qms_capable) ||
> +			 info->hdmi.vrr_cap.cinema_vrr))
>  		min_vfreq_n =3D 24;

[Severity: Medium]
Are there two mode-selection issues here in hdmi_validate_vrr()?

First, in the switch on new_conn_state->vrr_display_mode above, neither
VRR_DISPLAY_MODE_OFF nor a default case is handled. When
new_crtc_state->vrr_enabled is true and vrr_display_mode is
VRR_DISPLAY_MODE_OFF, hdmi_validate_vrr() no longer checks sink capability =
and
configures crtc vtotal adjustment even though
hdmi_generate_emp_infoframe_vtem() leaves vtem->game_vrr_en and vtem->qms_en
disabled.

Second, in the min_vfreq_n check above, info->hdmi.vrr_cap.cinema_vrr is not
restricted to VRR_DISPLAY_MODE_GAME. If vrr_display_mode is
VRR_DISPLAY_MODE_MEDIA on a sink where cinema_vrr is true and qms_tfr_min is
false, min_vfreq_n will still be lowered to 24 Hz.

Should VRR_DISPLAY_MODE_OFF be rejected (or handled) when vrr_enabled is tr=
ue,
and should info->hdmi.vrr_cap.cinema_vrr only apply when vrr_display_mode is
VRR_DISPLAY_MODE_GAME?

> =20
>  	/* If the VRR target changed, make sure to reset the error accumulator =
*/
> @@ -1176,6 +1269,19 @@ static int hdmi_validate_vrr(struct drm_connector =
*connector,
>  		return ret;
>  	}
> =20
> +	ret =3D hdmi_validate_qms(new_crtc_state, new_conn_state, info);
> +	if (ret < 0) {
> +		drm_dbg_kms(dev, "Invalid QMS rate: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	new_conn_state->hdmi.qms_tfr_byte =3D ret;
> +	if (!old_conn_state ||
> +	    new_conn_state->hdmi.qms_tfr_byte !=3D old_conn_state->hdmi.qms_tfr=
_byte)
> +		vrr_state->dynamic =3D true;
> +	else
> +		vrr_state->dynamic =3D false;

[Severity: Medium]
Does setting vrr_state->dynamic purely from whether qms_tfr_byte changed wo=
rk
as expected for vtem->m_const in both media and game modes?

In hdmi_generate_emp_infoframe_vtem(), vtem->m_const is set from
!vrr->dynamic:

		vtem->qms_en =3D true;
		vtem->next_tfr =3D conn_state->hdmi.qms_tfr_byte;
		vtem->m_const =3D !vrr->dynamic;

When media mode is first enabled or its target rate changes, qms_tfr_byte
differs from old_conn_state->hdmi.qms_tfr_byte, so vrr_state->dynamic is set
to true and the infoframe is generated with m_const =3D false. Because the
infoframe is only generated during atomic_check and is not updated after the
rate transition completes, won't m_const remain 0 on all subsequent frames =
of
constant-rate playback unless another atomic commit is made with the same
target rate?

In addition, when vrr_display_mode is VRR_DISPLAY_MODE_GAME with a fixed ta=
rget
rate (is_fixed =3D=3D true), hdmi_validate_qms() returns 0, so both old and=
 new
qms_tfr_byte are 0. This check then sets vrr_state->dynamic =3D false even =
when
the fixed target rate (vrr_min_n / vrr_min_d) changed in the commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D20
