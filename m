Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D6606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dj6ibCbP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C1310F5E8;
	Tue, 10 Nov 2026 00:53:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9634110F5E8
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:53:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF9BA611D0;
 Tue, 10 Nov 2026 00:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C361F008A2;
 Tue, 10 Nov 2026 00:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794272015;
 bh=Ci8gDaCKpR+UMNAqxjlKmxrLLrkKHxKu7u3Ks4O+DWs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dj6ibCbP/8co+eFi0Xlbom1uVR9DzZuFW6eEVInLji9JfDOIBpS1+4SObo68GZ20f
 lUM7F58xlBpdKHNhm1g7xwzu4TH1Hx3yo4d20OY75ASUKYbayFmBnJGQANigcS6ZvY
 22gtz/yYtfbjodYYZXgvyKX8/uke1HwQuZt0//+gJfDMJkGS3dqKZqpnW/qXPRQWQA
 ltJoJRbQNbIz6zBkLhgW4HVufyHf+wY2r076Ha7+i67wrcYyXd+AH1yJ3LAAavGOLm
 Y8whIW4tCWjvts4S3JDIFrzRnGMFazjAlXKxzZC9/yypfdAEUi8QzHJ5+/S0Z57h6c
 nkHP5fbvshqxg==
Message-ID: <sashiko-outbox-205909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vc4-common-scramb-v4-6-eaa141a0da0f@collabora.com>
References: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
 <20261110-vc4-common-scramb-v4-6-eaa141a0da0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:53:34 +0000
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
- [Medium] drm/vc4: hdmi: stale scrambler_enabled in
  vc4_hdmi_connector_init() resets CRTC
- [Medium] drm/vc4: hdmi: boot disable in
  vc4_hdmi_encoder_post_crtc_powerdown() skips SCDC
--

commit 55672bfb001a1795d51c26644058eb362b55f702
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure

This commit converts the vc4 HDMI driver from its local scrambling and SCDC
handling to the common DRM HDMI 2.0 scrambling helpers.

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index c3636ed60d56a..d7ef47dc4b02e 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c

[ ... ]

> @@ -544,6 +419,14 @@ static int vc4_hdmi_connector_init(struct drm_device=
 *dev,
> =20
>  	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
> =20
> +	/*
> +	 * Since we don't know the state of the controller and its
> +	 * display (if any), let's assume it's always enabled.
> +	 * drm_connector_hdmi_disable_scrambling() will thus run at boot,
> +	 * make sure it's disabled, and avoid any inconsistency.
> +	 */
> +	connector->hdmi.scrambler_enabled =3D drm_connector_hdmi_scrambler_supp=
orted(connector);

[Severity: Medium]
As reported by Ma=C3=ADra Canal on v3 [1], can connector->hdmi.scrambler_en=
abled
remain stuck at true and cause a spurious CRTC reset on hotplug or connector
polling when the CRTC is inactive at boot?

During bind, vc4_crtc_disable_at_boot() returns early without calling
vc4_crtc_disable() -> vc4_hdmi_encoder_post_crtc_powerdown() ->
drm_connector_hdmi_disable_scrambling() if the PixelValve is not enabled:

drivers/gpu/drm/vc4/vc4_crtc.c:vc4_crtc_disable_at_boot() {
	if (!(CRTC_READ(PV_CONTROL) & PV_CONTROL_EN))
		return 0;

	if (!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN))
		return 0;

When the CRTC is later enabled in a mode that does not need scrambling,
drm_connector_hdmi_enable_scrambling() returns early on
!conn_state->hdmi.scrambler_needed without clearing scrambler_enabled.
Whereas vc4_hdmi_reset_link() previously checked
drm_hdmi_mode_needs_scrambling(), drm_atomic_helper_connector_hdmi_hotplug()
-> drm_connector_hdmi_sync_scdc() checks hdmi->scrambler_enabled, sees it m=
ismatch
the sink's SCDC_SCRAMBLING_ENABLE bit, and triggers an unnecessary full
modeset via drm_atomic_helper_reset_crtc().

[ ... ]

> @@ -931,7 +766,7 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(stru=
ct drm_encoder *encoder,
>  	if (vc4_hdmi->variant->phy_disable)
>  		vc4_hdmi->variant->phy_disable(vc4_hdmi);
> =20
> -	vc4_hdmi_disable_scrambling(encoder);
> +	drm_connector_hdmi_disable_scrambling(&vc4_hdmi->connector);

[Severity: Medium]
As reported by Ma=C3=ADra Canal on v3 [2], does replacing
vc4_hdmi_disable_scrambling() with drm_connector_hdmi_disable_scrambling()
skip clearing sink-side SCDC scrambling during vc4_crtc_disable_at_boot()?

vc4_drm_bind() runs vc4_crtc_disable_at_boot() before drm_dev_register() and
before connector detection or EDID probing has populated connector->status
and connector->display_info.  Unlike vc4_hdmi_disable_scrambling(), which
unconditionally cleared SCDC over DDC, drm_connector_hdmi_disable_scramblin=
g()
guards the SCDC writes:

drivers/gpu/drm/display/drm_hdmi_helper.c:drm_connector_hdmi_disable_scramb=
ling() {
	...
	if (connector->ddc &&
	    connector->status =3D=3D connector_status_connected &&
	    drm_scdc_sink_supports_scrambling(connector)) {
		drm_scdc_set_scrambling(connector, false);
		drm_scdc_set_high_tmds_clock_ratio(connector, false);
	}

If firmware left an HDMI 2.0 pipeline active in a scrambled mode at boot and
the subsequent modeset selects an unscrambled mode, the controller disables
scrambling while the sink remains configured for scrambled 1:40 TMDS, leavi=
ng
the display output broken.

[1] https://lore.kernel.org/r/45ea1610-360f-4f6b-9ea6-30b28fbe8514@igalia.c=
om
[2] https://lore.kernel.org/r/45ea1610-360f-4f6b-9ea6-30b28fbe8514@igalia.c=
om

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vc4-common=
-scramb-v4-0-eaa141a0da0f@collabora.com?part=3D6
