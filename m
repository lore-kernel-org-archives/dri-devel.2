Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0431606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CURVziVm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF6C10F8C5;
	Tue,  3 Nov 2026 22:55:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7931E10F8A7;
 Tue,  3 Nov 2026 22:55:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0E2160D81;
 Tue,  3 Nov 2026 22:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4AD1F000C1;
 Tue,  3 Nov 2026 22:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793746532;
 bh=l8S3yCpol7+fNafZtUXxIzEBjIkQvusToH7ukbIbSIU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CURVziVmaDenQBwzrpeEmOR+vhQsKYQoNMr/jq4D+Yf+/uuOJfFcV6lQJG7NISuNw
 XJN0I3YTtUzB2PJCIgHt0dLG4XedLrkTZvB56q/pccRMW+q1mZ4myZZii2PDv/uUIu
 4yQvGzo4hgR+ATcsw3drTONHo1phAoCXyePWq30inxdZvTFummQDgh0w8I/k22Oz+y
 SgY6a6nOAKrRMs6Cyqn9VHABooaXkEIhWQyUEoS28DIJpwPGom98350mdoL+DN+LUm
 pKFZxcVch7eS0yzj2eNQJY+bPxRhQ700Z8fDQDGrcBmZI86o4cbxNYLiRo9NHf1Bkj
 rBioXzY2Q8dLg==
Message-ID: <sashiko-outbox-196162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/12] drm/panel: add connector luminance forwarding
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261103-superm1-backlight-property-v11-7-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-7-00cce7b2ba22@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:55:32 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/panel: premature and redundant backlight update in drm_panel=
_set_luminance()
--

commit 7712bf002ce98036567ec37ca544f1c1930a93be
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/panel: add connector luminance forwarding

This commit adds helpers to expose a panel backlight via the connector
LUMINANCE property and forward connector updates to the backlight backend.
It hooks these helpers into panel bridges that create their own connector.

> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 74c96da45b7a5..bbd0e14401c18 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c

[ ... ]

> @@ -169,6 +184,19 @@ static void panel_bridge_atomic_enable(struct drm_br=
idge *bridge,
>  	if (old_crtc_state && old_crtc_state->self_refresh_active)
>  		return;
> =20
> +	/*
> +	 * Program the committed luminance before drm_panel_enable() turns the
> +	 * backlight on, so the panel does not light up at a stale level.
> +	 */
> +	if (panel->connector.luminance_property) {
> +		const struct drm_connector_state *conn_state =3D
> +			drm_atomic_get_new_connector_state(atomic_state,
> +							   &panel->connector);
> +
> +		if (conn_state)
> +			drm_panel_set_luminance(panel, conn_state->luminance);
> +	}
> +
>  	drm_panel_enable(panel);
>  }
> =20
> @@ -873,6 +901,71 @@ void drm_panel_disable(struct drm_panel *panel)

[ ... ]

> +/**
> + * drm_panel_set_luminance - set a panel backlight's relative luminance
> + * @panel: panel whose backlight is controlled
> + * @luminance: relative luminance level
> + *
> + * Updates the backlight brightness without changing its power state, un=
der
> + * the same lock as brightness changes made through sysfs. Turning
> + * the backlight on and off is left to drm_panel_enable() and
> + * drm_panel_disable(), so a level set while the panel is disabled is ap=
plied
> + * when the panel is enabled again.
> + */
> +void drm_panel_set_luminance(struct drm_panel *panel, unsigned int lumin=
ance)
> +{
> +	struct backlight_device *backlight;
> +
> +	if (!panel || !panel->backlight)
> +		return;
> +
> +	backlight =3D panel->backlight;
> +	guard(mutex)(&backlight->ops_lock);
> +	if (!backlight->ops || luminance > backlight->props.max_brightness)
> +		return;
> +
> +	backlight->props.brightness =3D luminance;
> +	backlight_update_status(backlight);
> +}
> +EXPORT_SYMBOL(drm_panel_set_luminance);

[Severity: Medium]
Can calling backlight_update_status() unconditionally in
drm_panel_set_luminance() cause the backlight hardware to be programmed or
unblanked before panel->funcs->enable() runs, as well as trigger three
consecutive backlight updates on every modeset enable?

During a modeset enable, drm_atomic_helper_commit_modeset_enables() runs:

  drm_atomic_helper_commit_encoder_bridge_enable()
    -> panel_bridge_atomic_enable()
      -> drm_panel_set_luminance()
      -> drm_panel_enable()
  drm_atomic_helper_commit_luminance_enables()
    -> panel_bridge_connector_set_luminance()
      -> drm_panel_set_luminance()

When panel_bridge_atomic_enable() calls drm_panel_set_luminance() before
drm_panel_enable(), panel->enabled is still false and panel->funcs->enable()
has not yet executed:

drivers/gpu/drm/drm_panel.c:drm_panel_enable() {
	...
	if (panel->funcs && panel->funcs->enable) {
		ret =3D panel->funcs->enable(panel);
		if (ret < 0)
			goto exit;
	}
	panel->enabled =3D true;

	ret =3D backlight_enable(panel->backlight);
	...
}

Because BACKLIGHT_POWER_ON is 0, backlight devices registered with
zero-initialized props.power and props.state (or left active at boot) are n=
ot
marked blanked prior to the first drm_panel_disable() call, and several
panel backlight callbacks (such as visionox_r66451_bl_update_status() and
rad_bl_update_status()) send MIPI_DCS_SET_DISPLAY_BRIGHTNESS commands in
update_status() regardless of blank state. Calling backlight_update_status()
before drm_panel_enable() can therefore access or unblank the panel before
panel->funcs->enable() has completed its power-on sequence and mandatory
enable delays.

In addition, if an external caller invokes drm_panel_set_luminance() while
!panel->enabled, calling backlight_update_status() immediately does not mat=
ch
the kernel-doc comment stating that a level set while the panel is disabled
is applied when the panel is enabled again.

Once drm_panel_enable() runs, backlight_enable() calls
backlight_update_status() a second time to apply backlight->props.brightnes=
s.
Immediately after, drm_atomic_helper_commit_luminance_enables() sees
drm_atomic_crtc_needs_modeset(new_crtc_state) and calls
panel_bridge_connector_set_luminance() -> drm_panel_set_luminance(), which
calls backlight_update_status() a third time even though
backlight->props.brightness already equals luminance.

Should drm_panel_set_luminance() only store backlight->props.brightness when
!panel->enabled (leaving the hardware update to backlight_enable() in
drm_panel_enable()), and skip backlight_update_status() when
backlight->props.brightness is unchanged?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-superm1-ba=
cklight-property-v11-0-00cce7b2ba22@kernel.org?part=3D7
