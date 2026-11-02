Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28790606A905
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLpTRc0H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F5C310F0A2;
	Mon,  2 Nov 2026 17:07:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9DD10E6AE;
 Mon,  2 Nov 2026 17:07:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70E1542001;
 Mon,  2 Nov 2026 17:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228411F00A17;
 Mon,  2 Nov 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793639227;
 bh=nXHx6wSnBu/YGDLhLRoHtWqW2r7SAZqpK/XneR352Ic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cLpTRc0HfdJvWxv3FN0lc17npZ4EzI62mnZkMd5nqT8/puigvXs9kPxIEqZFRHkBP
 jD61f7K3oBU81JlgVBVS46d2xtdkHlqOAo3EB1cUEwtpaRT19OCPdMwJmiR32wGxh1
 JgaKW9NJG8IsnN39B/fB2gYIpRgIgsRJY6YEMJI6DuDXuk/iwrXPK4I5J5K05AN16S
 zHofOwBsu8pQR/rHKZloJLo8bojlbIzWWoNqVyQLP5xhAnZZ8zX8RJ3s9qSx4WywLj
 DnJQeWu5yx/zU+Q4m8k/g8f3CVPvhsJzXzKkmH55dvpB8vpTJ7iB8Cvj3LZSdFVx8i
 tQGq2bhU8r39g==
Message-ID: <sashiko-outbox-193798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/15] drm: add connector LUMINANCE property
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-1-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-1-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:07:06 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/atomic-helper: panel emission disabled on PSR entry in drm_ato=
mic_helper_commit_luminance_disables()
- [Medium] drm/atomic-helper: redundant set_luminance() calls in drm_atomic=
_helper_commit_luminance_enables()
--

commit 723bca80ec2bc6672a30925c2cb41a862300dc7b
Author: Mario Limonciello <mario.limonciello@amd.com>

drm: add connector LUMINANCE property

This commit adds an atomic per-connector LUMINANCE range property along with
connector helper callbacks to set luminance or disable panel emission during
atomic commits.

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 9d006f98413a5..1e9b7b8acccfe 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1375,6 +1375,8 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_brid=
ge_post_disable);
>  static void
>  disable_outputs(struct drm_device *dev, struct drm_atomic_commit *state)
>  {
> +	drm_atomic_helper_commit_luminance_disables(state);
> +
>  	drm_atomic_helper_commit_encoder_bridge_disable(dev, state);
> =20
>  	drm_atomic_helper_commit_encoder_bridge_post_disable(dev, state);
> @@ -1382,6 +1384,45 @@ disable_outputs(struct drm_device *dev, struct drm=
_atomic_commit *state)
>  	drm_atomic_helper_commit_crtc_disable(dev, state);
>  }
> =20
> +/**
> + * drm_atomic_helper_commit_luminance_disables - disable panel emission
> + * @state: atomic state object being committed
> + *
> + * Invokes each connector driver's luminance disable callback before a
> + * display pipeline is disabled. The connector property's stored value i=
s left
> + * untouched so it can be restored when the pipeline is enabled again.
> + */
> +void drm_atomic_helper_commit_luminance_disables(struct drm_atomic_commi=
t *state)
> +{
> +	struct drm_connector_state *old_conn_state, *new_conn_state;
> +	struct drm_connector *connector;
> +	int i;
> +
> +	for_each_oldnew_connector_in_state(state, connector, old_conn_state,
> +					   new_conn_state, i) {
> +		const struct drm_connector_helper_funcs *funcs;
> +		struct drm_crtc_state *old_crtc_state, *new_crtc_state =3D NULL;
> +
> +		if (!connector->luminance_property || !old_conn_state->crtc)
> +			continue;
> +
> +		old_crtc_state =3D
> +			drm_atomic_get_old_crtc_state(state, old_conn_state->crtc);
> +		if (new_conn_state->crtc)
> +			new_crtc_state =3D
> +				drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
> +
> +		if (!crtc_needs_disable(old_crtc_state, new_crtc_state) ||
> +		    !drm_atomic_crtc_needs_modeset(old_conn_state->crtc->state))
> +			continue;
> +
> +		funcs =3D connector->helper_private;
> +		if (funcs && funcs->disable_luminance)
> +			funcs->disable_luminance(old_conn_state);
> +	}
> +}

[Severity: High]
Will drm_atomic_helper_commit_luminance_disables() turn off panel emission
when a display enters Panel Self-Refresh (PSR)?

When a CRTC enters self-refresh via drm_self_refresh_helper_entry_work() in
drivers/gpu/drm/drm_self_refresh_helper.c, affected connectors are added to
the commit with new_crtc_state->active set to false and
new_crtc_state->self_refresh_active set to true. That transition sets
new_crtc_state->active_changed, so drm_atomic_crtc_needs_modeset() returns
true, and crtc_needs_disable() also returns true because old_state->active
and new_state->self_refresh_active are set:

drivers/gpu/drm/drm_atomic_helper.c:crtc_needs_disable() {
	...
	return old_state->active ||
	       (old_state->self_refresh_active && !new_state->active) ||
	       new_state->self_refresh_active;
}

For comparison, panel_bridge_atomic_disable() in drivers/gpu/drm/drm_panel.c
explicitly skips disabling the panel when entering self-refresh:

drivers/gpu/drm/drm_panel.c:panel_bridge_atomic_disable() {
	...
	new_crtc_state =3D drm_atomic_get_new_crtc_state(atomic_state, crtc);
	if (new_crtc_state && new_crtc_state->self_refresh_active)
		return;

	drm_panel_disable(panel);
}

Without a similar check for new_crtc_state->self_refresh_active here (and
because drm_atomic_helper_commit_luminance_enables() skips set_luminance()
while new_conn_state->crtc->state->active is false), wouldn't
funcs->disable_luminance(old_conn_state) be called on PSR entry and leave t=
he
panel dark while displaying the static frame?

> +EXPORT_SYMBOL(drm_atomic_helper_commit_luminance_disables);
> +
>  /**
>   * drm_atomic_helper_update_legacy_modeset_state - update legacy modeset=
 state
>   * @dev: DRM device
> @@ -1771,10 +1812,41 @@ void drm_atomic_helper_commit_modeset_enables(str=
uct drm_device *dev,
> =20
>  	drm_atomic_helper_commit_encoder_bridge_enable(dev, state);
> =20
> +	drm_atomic_helper_commit_luminance_enables(state);
> +
>  	drm_atomic_helper_commit_writebacks(dev, state);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
> =20
> +/**
> + * drm_atomic_helper_commit_luminance_enables - apply luminance
> + * @state: atomic state object being committed
> + *
> + * Invokes each connector driver's luminance callback after the display
> + * pipeline has been enabled. The callback is also invoked for brightnes=
s-only
> + * commits while the connector remains active. Changes committed while t=
he
> + * connector is inactive remain stored in atomic state until a later ena=
ble.
> + */
> +void drm_atomic_helper_commit_luminance_enables(struct drm_atomic_commit=
 *state)
> +{
> +	struct drm_connector_state *new_conn_state;
> +	struct drm_connector *connector;
> +	int i;
> +
> +	for_each_new_connector_in_state(state, connector, new_conn_state, i) {
> +		const struct drm_connector_helper_funcs *funcs;
> +
> +		if (!connector->luminance_property || !new_conn_state->crtc ||
> +		    !new_conn_state->crtc->state->active)
> +			continue;
> +
> +		funcs =3D connector->helper_private;
> +		if (funcs && funcs->set_luminance)
> +			funcs->set_luminance(new_conn_state);
> +	}
> +}

[Severity: Medium]
Should drm_atomic_helper_commit_luminance_enables() check whether the CRTC
needs a modeset or old_conn_state->luminance !=3D new_conn_state->luminance
before calling funcs->set_luminance(new_conn_state)?

drm_atomic_helper_commit_modeset_enables() runs on every atomic commit via
drm_atomic_helper_commit_tail() and drm_atomic_helper_commit_tail_rpm(). Any
non-modeset commit on an active CRTC that includes the connector in the
atomic state (such as updates to other connector properties like
hdr_output_metadata or max_bpc, compositors submitting unchanged connector
properties during page flips, or driver atomic_check hooks calling
drm_atomic_add_affected_connectors()) will invoke funcs->set_luminance() and
reprogram the hardware even when the luminance level and power state are
unchanged.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D1
