Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E526606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJXIfGae
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F291129DB;
	Fri, 27 Nov 2026 10:24:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A8F1129E1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:24:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F74D42A6F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16091F000C1;
 Fri, 27 Nov 2026 10:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795775090;
 bh=jB3mFVRpQCjA6DnTiAwzT4xkyV1h4NrOXyWyk9NtN1c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PJXIfGaeMSN/XkYcuxajrXiZBYUGS2GEtrKUi90Vs6iunsvrgTpLOJZxuYwWPM2dJ
 3ucXkQp1EVWL+YZhnQn9ExI9W9CBfJEMwjzXjptAq8C+Oh+3CxLCNIoNn1GIm+a1wi
 TMrkEHqX2383s3VpnhwX/Nwexe/4mWDLhWJyTGkU4GrkMcs+ApjnGm5AwxYiV3t2HJ
 0ZzzDCXqgjC5771AvCzF3I8XQPJ0JIOfPupO3H9vO+TnkhDQrJ5HfrunLPHfSBCVX+
 ygL8/xPYbnw3o5UVEFXzXZFKaRINFO0zplLn5c6VEyQZ7LlFSTOq+HAKF0uyO1fk/u
 I6KC60NhFPoyA==
Message-ID: <sashiko-outbox-237123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 32/36] drm/bridge: sii902x: Implement hw state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-drm-state-readout-v10-32-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-32-0259582d45a8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:24:50 +0000
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

commit 1febc97c5f2895a5e2cdde81b1c282f183b07ffd
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: sii902x: Implement hw state readout

This commit implements atomic hardware state readout callbacks for the
sii902x bridge and advertises DRM_BRIDGE_OP_CONNECTOR_HW_READOUT.

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
Can SII902X_SYS_CTRL_PWR_DWN ever be clear at readout time when reset_gpio
is populated?

During probe, sii902x_init() unconditionally pulses reset_gpio before
registering the bridge:

drivers/gpu/drm/bridge/sii902x.c:sii902x_init() {
	sii902x_reset(sii902x);

	ret =3D regmap_write(sii902x->regmap, SII902X_REG_TPI_RQB, 0x0);
	...
}

On boards that define reset-gpios in Device Tree, pulsing reset restores
the SiI9022 registers to their power-down defaults with
SII902X_SYS_CTRL_PWR_DWN set.  Both sii902x_bridge_connector_readout() and
sii902x_bridge_readout_state() will then see the bridge as powered down and
bail out early, leaving a firmware-enabled CRTC active without linking
conn_state->crtc or populating crtc_state->encoder_mask and
crtc_state->connector_mask.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-drm-state-=
readout-v10-0-0259582d45a8@kernel.org?part=3D32
