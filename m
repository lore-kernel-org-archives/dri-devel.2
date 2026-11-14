Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434D3606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3+T7lJa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C6F10E0A7;
	Sat, 14 Nov 2026 18:21:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3275A10E0A7
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:21:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C967605D1;
 Sat, 14 Nov 2026 18:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD88C1F000C5;
 Sat, 14 Nov 2026 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794680507;
 bh=ye8EeAqNf+11OpJEzjstYmBsmhSMRMohurKIGRYltO0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D3+T7lJaxmTivC/Qb/6+daUU2PUZjGRQd9jU9yQgBCwXHGAnlgFQguE5MjLvH7j8M
 YkeWJA0GaM6cNpqgbc64181oPOoB2n4AgqAJIv4PUOkvfOGJCuDe8mP1XEBsoqm+Yx
 LnDm5XJ8m5IpKCjWbmdr68+DOqaehWKAx8gRCUoQTSc9Z1GvvDEvqaQ7nGnRlGshAm
 e1TvZfJuUp6quELoeILU+GCanHwY05chJKtdq6fZl6N2iOXyRqtZai+bmz7yJtWWvS
 fDdbegN7NmE8iEaHOarv9M1wMYZqA/WZhoPYI0cK18utE4xXDtCxFIWommfOlxkC7x
 FYR5n8kfTzn1g==
Message-ID: <sashiko-outbox-214897@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/25] drm/tests: hdmi: Add HDMI 2.0 scrambling helpers
 coverage
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-21-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-21-20e8a33a2286@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:21:46 +0000
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
- [Medium] drm/tests: hdmi: drm_connector_hdmi_enable_scrambling() SCDC
  check fails
--

commit 352379847f7c6ceae1ef1736d628408794656e3d
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/tests: hdmi: Add HDMI 2.0 scrambling helpers coverage

This commit adds KUnit tests and a fake SCDC DDC adapter to cover the HDMI
2.0 scrambling helpers and SCDC status monitoring work.

> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 294be8f4a3076..46654d8fa45cf 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c

[ ... ]

> +/*
> + * Test that enabling scrambling for a mode that doesn't need it leaves =
the
> + * source alone, but clears any stale scrambling setup on the sink side.
> + */
> +static void drm_test_hdmi_scrambling_enable_not_needed(struct kunit *tes=
t)
> +{
> +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> +	struct drm_connector_state *conn_state;
> +	struct drm_connector *conn;
> +	int ret;
> +
> +	priv =3D drm_kunit_helper_connector_hdmi_init_with_scdc(test,
> +				&scdc_connector_hdmi_funcs,
> +				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
> +	KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +	conn =3D &priv->connector;
> +	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.scdc.scrambling.support=
ed);
> +
> +	conn_state =3D kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, conn_state);
> +
> +	conn_state->hdmi.scrambler_needed =3D false;
> +
> +	priv->scdc_regs[SCDC_TMDS_CONFIG] =3D SCDC_TMDS_CONFIG_SCRAMBLED;
> +
> +	ret =3D drm_connector_hdmi_enable_scrambling(conn, conn_state);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_EQ(test, priv->scdc_regs[SCDC_TMDS_CONFIG], 0);

[Severity: Medium]
Does this KUNIT_EXPECT_EQ() on priv->scdc_regs[SCDC_TMDS_CONFIG] always
fail?

drivers/gpu/drm/display/drm_hdmi_helper.c:drm_connector_hdmi_enable_scrambl=
ing() {
    ...
	if (!conn_state->hdmi.scrambler_needed)
		return 0;
    ...
}

When conn_state->hdmi.scrambler_needed is false,
drm_connector_hdmi_enable_scrambling() returns 0 immediately without
touching SCDC, so priv->scdc_regs[SCDC_TMDS_CONFIG] stays at
SCDC_TMDS_CONFIG_SCRAMBLED and drm_test_hdmi_scrambling_enable_not_needed()
fails on every run.  The commit message also claims that enabling
scrambling for a mode not needing it clears stale sink scrambling setup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-drm-conn-h=
dmi-cleanup-v1-0-20e8a33a2286@collabora.com?part=3D21
