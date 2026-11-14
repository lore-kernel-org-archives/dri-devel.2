Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AA606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cggeO0OW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1383010E267;
	Sat, 14 Nov 2026 18:14:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A5B10E188
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:14:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 294B960008;
 Sat, 14 Nov 2026 18:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB00C1F000C4;
 Sat, 14 Nov 2026 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794680072;
 bh=Y5H+uTbiiSWnrXDs+Y5FMkJ7U7wN86frgowRRfW7joU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cggeO0OWgeJoKcBPviD1sSYDTHYDloRMYy1OEu2RDHk3dovzR8W8I5a1nk4GYaeRM
 5QQKqxLgfX5PyYsqyBgma4A5HmMB4RpgEdUFu2VAI/Zo6XOe4Nn7rID8bew9pCJWMw
 +nCdxlJNV6l+ViQ5hGdhSJ2rdiU796EeQOLUoQctO/SKeqX1rv2z6k7APkP+2h3UzX
 fHxJAlMWmD6CAwviJRmmE10I8VUdp9XuNGqhWyUrkOJCTJBfr6qmTNRXCekLYURUL1
 Nr17qEXOo3YJp1eBdNhfU9nd5lPuQQ+ObYt4I9Sti+8c73lWty0hQDrjeyl6RT/GW1
 xpq5rVv3BfSTg==
Message-ID: <sashiko-outbox-214893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/25] drm/tests: bridge: Set supported HDMI version
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-23-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-23-20e8a33a2286@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:14:32 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] drm/tests: bridge: memory leak of edid in
  drm_test_bridge_chain_init() [1]
--

commit e45be11e80ff96e23882e09db24056eb896ea3a6
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/tests: bridge: Set supported HDMI version

This commit sets supported_hdmi_ver to HDMI_VERSION_1_4 on HDMI test
bridges in the KUnit bridge tests.

> diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/te=
sts/drm_bridge_test.c
> index 15583ade84946..a445f71c31b84 100644
> --- a/drivers/gpu/drm/tests/drm_bridge_test.c
> +++ b/drivers/gpu/drm/tests/drm_bridge_test.c
> @@ -497,6 +497,7 @@ drm_test_bridge_chain_init(struct kunit *test, unsign=
ed int num_bridges,
>  			bridge->type =3D DRM_MODE_CONNECTOR_HDMIA;
>  			bridge->vendor =3D "LNX";
>  			bridge->product =3D "KUnit";
> +			bridge->supported_hdmi_ver =3D HDMI_VERSION_1_4;
>  			bridge->supported_formats =3D (BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
>  						     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
>  						     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |

[Severity: Medium]
This problem wasn't introduced by this patch, but does
drm_test_bridge_chain_init() leak edid [1] when has_hdmi is true?

drivers/gpu/drm/tests/drm_bridge_test.c:drm_test_bridge_chain_init() {
    ...
	scoped_guard(mutex, &drm->mode_config.mutex) {
		edid =3D drm_edid_alloc(test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200=
mhz,
				ARRAY_SIZE(test_edid_hdmi_1080p_rgb_yuv_4k_yuv420_dc_max_200mhz));
		if (!edid)
			return ERR_PTR(-EINVAL);

		drm_edid_connector_update(priv->connector, edid);
		KUNIT_ASSERT_GT(test, drm_edid_connector_add_modes(priv->connector), 0);

		ret =3D priv->connector->funcs->fill_modes(priv->connector, 4096, 4096);
	}
    ...
}

drm_edid_connector_update() copies the EDID data into a connector property
blob without taking ownership of edid, and drm_edid_free() is never called
before returning.

[1] https://sashiko.dev/#/bug/linux-cc41077e-4212-413a-a83b-7a6487bad187

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-drm-conn-h=
dmi-cleanup-v1-0-20e8a33a2286@collabora.com?part=3D23
