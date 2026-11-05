Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A4606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOasGBZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F3310E203;
	Thu,  5 Nov 2026 17:30:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2651B10E203
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:30:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C8B0600B4;
 Thu,  5 Nov 2026 17:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD18C1F000C1;
 Thu,  5 Nov 2026 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793899840;
 bh=jDawEvr9dKiXAR0z+2ekYvoeS0sWwYX7ZxeOMJjgeaQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QOasGBZXmU05qVIyCVEdsNEbIpFyNiwUSzCHuHWNiRNraULLrIwt20YVr0ENE3P+X
 D6NeklcScfnc3yVgLhkg1wlkVwSPSk7dYZ/eFRabWgKkiYaULFYpx7TVTqjx4iuDA2
 S6ijlqyfAtG3vPWN+oLpZzc6cwXMy54I1WregnBS773zp8UtX3W/nrhKIXHibV0G2h
 yF6APqQRhE5xe3EzIu6yNMICxSyD6v9+Gt2qgaZ9pNjIwjNW5cCw4cFXUEk52eWG38
 zfbOTKQ5/o7+VPUgVXMo0uAUSkOZsYc3EMeJOjARHgKb5Niy343TMpeLi2jtW+7FWK
 sEY/uaGTX4vDQ==
Message-ID: <sashiko-outbox-199622@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/27] drm/rockchip: dw_hdmi_qp: Add VRR support
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-12-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-12-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:30:39 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/rockchip: dw_hdmi_qp: live VRR property mutation in encoder =
atomic_check()
--

commit cf4752529f9d39b6df9beff8735c1aec029921cc
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/rockchip: dw_hdmi_qp: Add VRR support

This commit attaches VRR connector properties on RK3588 in
dw_hdmi_qp_rockchip_bind() and updates vrr_capable and the VRR display limit
properties in dw_hdmi_qp_rockchip_encoder_atomic_check().

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index f2a1ea8dfefa5..dcde50bca36bf 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c

[ ... ]

> @@ -195,6 +198,7 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_e=
ncoder *encoder,
>  					 struct drm_crtc_state *crtc_state,
>  					 struct drm_connector_state *conn_state)
>  {
> +	struct drm_connector *connector =3D conn_state->connector;
>  	struct rockchip_crtc_state *s =3D to_rockchip_crtc_state(crtc_state);
>  	struct rockchip_hdmi_qp *hdmi =3D to_rockchip_hdmi_qp(encoder);
>  	union phy_configure_opts phy_cfg =3D {};
> @@ -205,6 +209,12 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_=
encoder *encoder,
>  	if (ingest_fmt < 0)
>  		return -EINVAL;
> =20
> +	if (connector->vrr_capable_property) {
> +		drm_connector_set_vrr_capable_property(connector,
> +			drm_display_info_is_vrr_capable(&connector->display_info));
> +		drm_connector_hdmi_update_vrr_limits(connector, &crtc_state->mode);
> +	}

[Severity: Medium]
As reported by Sashiko on RFC [1], is it safe to update the live connector
VRR properties inside dw_hdmi_qp_rockchip_encoder_atomic_check()?

Both drm_connector_set_vrr_capable_property() and
drm_connector_hdmi_update_vrr_limits() call drm_object_property_set_value()
on connector->base, which directly mutates connector->base.properties->valu=
es[]
because vrr_capable, vrr_display_min, and vrr_display_max are immutable
properties rather than transactional drm_connector_state fields.

When userspace performs a DRM_MODE_ATOMIC_TEST_ONLY commit to probe candida=
te
modes, or when an atomic check fails later in the pipeline, this path:

  drm_mode_atomic_ioctl()
    drm_atomic_check_only()
      drm_atomic_helper_check()
        drm_atomic_helper_check_modeset()
          mode_fixup()
            dw_hdmi_qp_rockchip_encoder_atomic_check()

immediately overwrites the live user-visible vrr_display_min and
vrr_display_max values with limits derived from the uncommitted
crtc_state->mode.

In addition, mode_fixup() in drivers/gpu/drm/drm_atomic_helper.c skips the
encoder atomic_check when a connector has no CRTC or encoder assigned:

  if (!new_conn_state->crtc || !new_conn_state->best_encoder)
          continue;

When a VRR-capable display is connected at boot or hotplugged while the
connector is disabled, DRM_IOCTL_MODE_GETCONNECTOR probes the connector and
updates EDID without running dw_hdmi_qp_rockchip_encoder_atomic_check(),
leaving vrr_capable at 0 until a modeset occurs. Conversely, when a VRR
display is unplugged and its CRTC is disabled (new_conn_state->crtc =3D=3D =
NULL),
mode_fixup() skips the encoder check and leaves vrr_capable stuck at 1 and
vrr_display_min / vrr_display_max holding the disconnected sink's values.

Finally, connector->display_info and connector->status (read by
drm_display_info_is_vrr_capable() and drm_connector_hdmi_update_vrr_limits(=
))
are protected by dev->mode_config.mutex, whereas atomic_check only holds
connection_mutex and crtc->mutex, which can race with concurrent hotplug
updates in drm_bridge_connector_handle_hpd().

Should vrr_capable be updated in the connector hotplug / EDID probe path
while holding mode_config.mutex, and should the mode-dependent VRR limits be
updated during atomic commit rather than atomic_check?

[1] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-10-2fcd7d011646@=
collabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D12
