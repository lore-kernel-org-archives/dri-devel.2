Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD5606A339
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwhMsQeJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05ADC112A54;
	Fri, 20 Nov 2026 13:26:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61676112A54
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:26:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48AC245B27
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CA51F00A19;
 Fri, 20 Nov 2026 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795181191;
 bh=7zEer7UghG830v4Bqe9AaiUhqZKHl6JfJTtHfzHVsao=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VwhMsQeJlejLO4ZFVZ0n2OmLlHbVCxhfbTNk90jDY5Z7YYMKQq4ktpX7J2sCDYO9h
 +NHD5daN2fwIABdFGCjKidmc4/2hEa8AXr0JcReUDxc9PTUPIXxazKtBMRwNlouP9S
 BlLJePGeMFtpYYVqLQuNKyBV/dwSbZ01Fi7IX3+cKK+KZF4IkUaJraZG0LVFhIGTc4
 1jneURjXw1FdXudL8AziWDQqacsRXeTfsNOV5dR3cwOSvrG/fG5S7WOLesBaZzw62/
 kx+EpKJ7YDaUUoipxTHoULERsiekqo8KCRuPugcpOW5UJhBUqhkj17HjBax8ZJa47e
 vezFM+xH5sj5g==
Message-ID: <sashiko-outbox-225231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 38/42] drm/bridge: sii902x: Implement hw state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-drm-state-readout-v9-38-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-38-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:26:30 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/bridge: sii902x: unconditional reset in sii902x_init()
  wipes hw state
--

commit 863c5900a85de3bb77ecf66aba575b8561a6f743
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: sii902x: Implement hw state readout

This commit implements atomic state readout callbacks for the sii902x
bridge and connector and enables DRM_BRIDGE_OP_CONNECTOR_HW_READOUT.

> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index 6eaf70aeb0e37..4fb639e72c7e7 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c

[ ... ]

> @@ -537,6 +539,128 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
>  	return MODE_OK;
>  }
> =20
> +static int
> +sii902x_bridge_connector_readout(struct drm_bridge *bridge,
> +				 struct drm_atomic_sro_state *state,
> +				 struct drm_connector_state *conn_state)
> +{
> +	struct sii902x *sii902x =3D bridge_to_sii902x(bridge);
> +	struct drm_connector *connector =3D conn_state->connector;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_encoder *encoder;
> +	struct drm_crtc *crtc;
> +	int ret;
> +
> +	mutex_lock(&sii902x->mutex);
> +
> +	ret =3D regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902=
X_SYS_CTRL_PWR_DWN);
> +	/* I2C error */
> +	if (ret < 0)
> +		goto err_mutex_unlock;
> +	/* Device is powered down, nothing to read out */
> +	if (ret)
> +		goto out;

[Severity: Medium]
Can SII902X_SYS_CTRL_PWR_DWN ever be clear at readout time when
reset-gpios is provided in the device tree?

During probe, sii902x_init() unconditionally calls sii902x_reset() before
registering the bridge:

drivers/gpu/drm/bridge/sii902x.c:sii902x_reset() {
	if (!sii902x->reset_gpio)
		return;

	gpiod_set_value_cansleep(sii902x->reset_gpio, 1);

	/* The datasheet says treset-min =3D 100us. Make it 150us to be sure. */
	usleep_range(150, 200);

	gpiod_set_value_cansleep(sii902x->reset_gpio, 0);
}

Pulsing reset_gpio restores all SiI9022 registers to their power-down
defaults (SII902X_SYS_CTRL_PWR_DWN =3D 1).  When the KMS driver later runs
hardware state readout, both sii902x_bridge_connector_readout() and
sii902x_bridge_readout_state() see SII902X_SYS_CTRL_PWR_DWN set and treat
the bridge as powered down, leaving conn_state->crtc NULL and
crtc_state->encoder_mask and connector_mask clear on a firmware-enabled
display pipeline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-drm-state-=
readout-v9-0-a67c2b45b8ec@kernel.org?part=3D38
