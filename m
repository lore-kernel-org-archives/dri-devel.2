Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF02606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6sH20VH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0267410E1BA;
	Sun, 25 Oct 2026 11:39:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84ACD10E115;
 Sun, 25 Oct 2026 11:39:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 406A4434D3;
 Sun, 25 Oct 2026 11:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36D41F01825;
 Sun, 25 Oct 2026 11:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792928391;
 bh=cMWyryFwg6Mdq0UuaTwmq0qDSTsWM53sZ6Yt96arTV8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K6sH20VHfLQQqnp2kdYqaxi57M/OhY1VuOmNeK1fkn7zNh/axiFlp/2aQMZsJf8sC
 bqcZNPF8XYXL7iJRfKzJKzHEjAEoU7ba/BXMQTWlvYyGDppWNThgKhzIGPWQyVKsy3
 Gv9zLZeNrhxM74/0oE/B9GmUD26Javdajs+Mn/YuNfOAuWJ8f1wSXtnj1Xg4rPCG4o
 ZCf2iXqtqWjPIk7CMh2hwod1EyodaH/yPZ3DOXtL3ri7LyRkEqXIGBKMAUAX1ciZL2
 //EWNEPOqBXtEaBZnWurW3oKHgaU4P1tuATKz/bcSbnJycyfZl4H/bu8gJ2dC0AUeJ
 yHkgk1QQqDjOQ==
Message-ID: <sashiko-outbox-184196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dp: Remove redundant link capabilities reset
To: "George Karagounis" <taterraster@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261025113200.25097-1-mail@taterr.org>
References: <20261025113200.25097-1-mail@taterr.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 11:39:50 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/i915/dp: missing link capabilities reset in intel_dp_reset_lin=
k_params()
- [Low] drm/i915/dp: unused function intel_dp_link_caps_reset() left behind
- [Low] drm/i915/dp: space indentation used in intel_dp_reset_link_params()
--

commit a8d5bf6dc42f9bcd49f6371d597ac7f839e9b04f
Author: George Karagounis <taterraster@gmail.com>

drm/i915/dp: Remove redundant link capabilities reset

This commit removes the intel_dp_link_caps_reset() call from
intel_dp_reset_link_params(), assuming that intel_dp_link_caps_update() with
reset=3Dtrue has already been invoked beforehand.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index d8c0d9381471d..0e753824bc281 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3674,17 +3674,10 @@ void intel_dp_set_link_params(struct intel_dp *in=
tel_dp,
> =20
>  void intel_dp_reset_link_params(struct intel_dp *intel_dp)
>  {
> -	/*
> -	 * TODO: Remove the following reset of link capabilities, as
> -	 * this isn't needed after intel_dp_link_caps_update(reset=3Dtrue)
> -	 * was called.
> -	 */
> -	intel_dp_link_caps_reset(intel_dp->link.caps);

[Severity: High]
Are all callers of intel_dp_reset_link_params() guaranteed to have called
intel_dp_link_caps_update(reset=3Dtrue) beforehand?

Several paths call intel_dp_reset_link_params() without invoking
intel_dp_link_caps_update():

1. In drivers/gpu/drm/i915/display/intel_dp_link_caps.c, the debugfs handle=
rs
i915_dp_force_link_rate_write() and i915_dp_force_lane_count_write() call
intel_dp_reset_link_params() directly before setting forced_params:

	intel_dp_flush_connector_commits(connector);

	intel_dp_reset_link_params(intel_dp);
	link_caps->forced_params.rate =3D rate;

2. In drivers/gpu/drm/i915/display/intel_dp.c, when intel_dp_detect() runs =
on
an eDP connector after intel_dp->reset_link_params is set (such as on
suspend/resume, a long HPD pulse in intel_dp_hpd_pulse(), or RX_CAP_CHANGED=
 in
intel_dp_handle_link_service_irq()), it takes the edp_detect() branch rather
than intel_dp_detect_dpcd():

	if (intel_dp_is_edp(intel_dp))
		status =3D edp_detect(intel_dp);
	else if (intel_digital_port_connected(encoder))
		status =3D intel_dp_detect_dpcd(intel_dp);
	...
	if (intel_dp->reset_link_params) {
		intel_dp_reset_link_params(intel_dp);
		intel_dp->reset_link_params =3D false;
	}

Because intel_dp_get_dpcd() also skips intel_dp_update_sink_caps() for eDP,
intel_dp_link_caps_update() is never called on this path.

3. In drivers/gpu/drm/i915/display/intel_dp.c, intel_dp_sync_state() skips
intel_dp_get_dpcd() during system resume when intel_dp->dpcd[DP_DPCD_REV] !=
=3D 0
(and on eDP) and calls intel_dp_reset_link_params() directly:

	if (crtc_state && intel_dp->dpcd[DP_DPCD_REV] =3D=3D 0) {
		intel_dp_get_dpcd(intel_dp);
		dpcd_updated =3D true;
	}

	intel_dp_tunnel_resume(intel_dp, crtc_state, dpcd_updated);

	if (crtc_state) {
		intel_dp_reset_link_params(intel_dp);
		intel_dp_set_link_params(intel_dp, crtc_state->port_clock, crtc_state->la=
ne_count);
		intel_dp->link.active =3D true;
	}

Without intel_dp_link_caps_reset() here, won't reduced link_caps->max_limits
and disabled configurations in link_caps->enabled_configs from earlier link
training fallbacks remain stuck on these paths?

[Severity: Low]
Also, since this was the only caller of intel_dp_link_caps_reset(), removing
this call leaves the function definition in
drivers/gpu/drm/i915/display/intel_dp_link_caps.c and its declaration in
drivers/gpu/drm/i915/display/intel_dp_link_caps.h unused:

void intel_dp_link_caps_reset(struct intel_dp_link_caps *link_caps)
{
	reset_max_link_limits_reenable_all(link_caps);
}

If intel_dp_link_caps_reset() were no longer needed here, should its
definition and declaration be removed as well?

> -	intel_dp_tunnel_uhbr_lanes_wa_apply(intel_dp);
> -
> -	intel_dp->link.mst_probed_lane_count =3D 0;
> -	intel_dp->link.mst_probed_rate =3D 0;
> -	intel_dp_link_training_reset(intel_dp->link.training);
> +       intel_dp_tunnel_uhbr_lanes_wa_apply(intel_dp);
> +       intel_dp->link.mst_probed_lane_count =3D 0;
> +       intel_dp->link.mst_probed_rate =3D 0;
> +       intel_dp_link_training_reset(intel_dp->link.training);

[Severity: Low]
This isn't a bug, but the replacement lines in intel_dp_reset_link_params()
replace the leading tab indentation with spaces. Could these lines keep
standard tab indentation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025113200.2509=
7-1-mail@taterr.org?part=3D1
