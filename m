Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEB606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWLFSnDC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83CEA11201C;
	Thu, 29 Oct 2026 08:12:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFDD11201C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:12:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC543600D1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816EC1F01825;
 Thu, 29 Oct 2026 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793261554;
 bh=xFiw3q2XJSmE6+HSvlKGZlbAB2GSTJJVlN8Yf88idJE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mWLFSnDCsRmwx0d0jmcAIrVORcczQ/0QdHx+98TiniSPgyGExjn0jjiZiOs8mNasw
 gpRk7dSPYg9dMXJF21ciercDdk1fN956AsMggtff9CR/D7vscfcUu3oIHqmpZJUGrz
 zLcCaoRoiH1mJA0kKOwFzY+ux/OREyljqVLZkOJLhdphRoYtWyfD/HKb1/Q75GQ2g+
 aeZnybXeNnh2vTcHeu2e30L2OPyPwBaUO7paF42IuonA7NzH6HaOitDTpfPhh2fEbg
 XruDrf3knw2jfp+ojfgqHkYdRSvDbQ4120d6CFdUKeH8P03NJQ2eeG9mUJ2F5OLm6h
 E4NY7UYL9grPw==
Message-ID: <sashiko-outbox-188951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 34/34] drm/bridge: sii902x: Implement hw state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-34-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-34-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:12:34 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/bridge: sii902x: missing mutex lock in readout callbacks
- [Medium] drm/bridge: sii902x: ignored regmap_test_bits() error in readout=
_state()
--

commit ce74a42cab42e6bb481c531e7732368f37a0e27c
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: sii902x: Implement hw state readout

This commit implements hardware state readout callbacks for the sii902x
bridge driver and enables DRM_BRIDGE_OP_CONNECTOR_HW_READOUT.

> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/si=
i902x.c
> index e067c0636e7f5..ab5ffcf6882f2 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
[ ... ]
> @@ -537,6 +539,89 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
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
> +	ret =3D regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902=
X_SYS_CTRL_PWR_DWN);

[Severity: High]
Should sii902x_bridge_connector_readout() and sii902x_bridge_readout_state()
hold sii902x->mutex around their regmap_test_bits() calls?

In drivers/gpu/drm/bridge/sii902x.c, sii902x_regmap_config disables regmap's
internal locking:

static const struct regmap_config sii902x_regmap_config =3D {
	.reg_bits =3D 8,
	.val_bits =3D 8,
	.disable_locking =3D true, /* struct sii902x mutex should be enough */
	...
};

All other post-init regmap callers in this driver (such as
sii902x_interrupt(), sii902x_detect(), sii902x_edid_read(),
sii902x_bridge_mode_set(), and the audio callbacks) serialize access via
sii902x->mutex.

Without holding sii902x->mutex here, an unlocked regmap_test_bits() during
initial state readout or post-commit drm_atomic_sro_readout_and_compare()
can race with concurrent HPD interrupt handling, DDC operations, or ALSA
audio callbacks and clobber regmap's shared map->work_buf or interleave I2C
sequences.

> +	/* I2C error */
> +	if (ret < 0)
> +		return ret;
> +	/* Device is powered down, nothing to read out */
> +	if (ret)
> +		return 0;
[ ... ]
> +static int sii902x_bridge_readout_state(struct drm_bridge *bridge,
> +					struct drm_atomic_sro_state *state,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state)
> +{
> +	struct sii902x *sii902x =3D bridge_to_sii902x(bridge);
> +	u32 input_format;
> +
> +	if (regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SY=
S_CTRL_PWR_DWN))
> +		return 0;

[Severity: Medium]
What happens in sii902x_bridge_readout_state() if regmap_test_bits() fails
with a negative error code?

Because a negative errno is non-zero, the if condition evaluates to true and
sii902x_bridge_readout_state() returns 0 as though the device were powered
down, leaving bridge_state->input_bus_cfg and bridge_state->output_bus_cfg
unpopulated.

Should this check for ret < 0 and propagate the error like
sii902x_bridge_connector_readout() does above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D34
