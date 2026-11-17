Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E216606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oRuTZncz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4964110E0E4;
	Tue, 17 Nov 2026 19:58:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C41410F5E2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:58:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 069DC61405;
 Tue, 17 Nov 2026 19:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3379E1F000C4;
 Tue, 17 Nov 2026 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794945492;
 bh=qsjU6DFACAbDOfJLMOOcz7Evb3Wx0q0vKZrTcX0d8CY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oRuTZnczPBzp7vCRPzYA8CeIO4F+D3quE7Q84dLMmiYTH5gGsx76zknj4tzRH7K0z
 JePvcwIs6FaDra2ISn07URXkOye1twBppiPGFsHwq11KFawgW7lFOh65OUgZLUmoHq
 rxGGLRk92ncO0jmA8+RSWn5NXYjfQ9XSfATotq7Ice7J5BU6SYenEm8h6RineS3umC
 8qzgaIHIGq5G0l+fr9CBckk25k5wU3czlNL7kUWUfHJv8rUPBtv+K1Zg3eQw1tnoMp
 xSWSgb7S48XToMWZg8imz9B1M5Xx7KSL5oQd+xK6kSlv2yFghm1MPS2g/kMJhhewFp
 +S4ev8sFQmT2g==
Message-ID: <sashiko-outbox-219538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] phy: amlogic: Add Meson HDMI TX PHY driver
To: "Ronald Claveau" <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20261117-meson-drm-create-hdmitx-phy-v1-4-9e0ac931381c@aliel.fr>
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <20261117-meson-drm-create-hdmitx-phy-v1-4-9e0ac931381c@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:58:11 +0000
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
- [Medium] phy: amlogic: broken rate and submode check in
  meson_hdmi_phy_validate()
--

commit 0bf49ea77c864cdcf7af96e59e1ffba5194d9636
Author: Ronald Claveau <linux-kernel-dev@aliel.fr>

phy: amlogic: Add Meson HDMI TX PHY driver

This commit adds a generic PHY driver for the HDMI TX PHY on Amlogic GXBB,
GXL, GXM, and G12A SoCs, along with a legacy helper for device trees
lacking a "phys" property.

> diff --git a/drivers/phy/amlogic/phy-meson-hdmi-tx.c b/drivers/phy/amlogi=
c/phy-meson-hdmi-tx.c
> new file mode 100644
> index 0000000000000..69833a080dc35
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
[ ... ]
> +/* GXBB */
> +static const struct meson_hdmi_phy_rate gxbb_rates[] =3D {
> +	/* 5.94Gbps, 3.7125Gbps */
> +	{ 371250000, 0x33353245, 0x2100115b },
> +	/* 2.97Gbps */
> +	{ 297000000, 0x33634283, 0xb000115b },
> +	/* 1.485Gbps, and below */
> +	{ 0,         0x33632122, 0x2000115b },
> +};
[ ... ]
> +static const struct meson_hdmi_phy_rate *
> +meson_hdmi_phy_find_rate(const struct meson_hdmi_phy_data *data, u64 rat=
e)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < data->num_rates; i++)
> +		if (rate >=3D data->rates[i].min_rate)
> +			return &data->rates[i];
> +
> +	return NULL;
> +}
[ ... ]
> +static int meson_hdmi_phy_validate(struct phy *phy, enum phy_mode mode,
> +				   int submode, union phy_configure_opts *opts)
> +{
> +	struct meson_hdmi_phy *priv =3D phy_get_drvdata(phy);
> +
> +	if (mode !=3D PHY_MODE_HDMI)
> +		return -EINVAL;
> +
> +	if (opts->hdmi.bpc !=3D 8)
> +		return -EINVAL;
> +
> +	if (!meson_hdmi_phy_find_rate(priv->data, opts->hdmi.tmds_char_rate))
> +		return -EINVAL;
> +
> +	return 0;
> +}

[Severity: Medium]
Can meson_hdmi_phy_find_rate() ever return NULL here?

Every per-SoC rate table ends with an entry where min_rate is 0, and rate
is an unsigned u64, so rate >=3D data->rates[i].min_rate is always true on
the final entry.  That makes the NULL return and the callers' NULL checks
in meson_hdmi_phy_validate() and meson_hdmi_phy_configure() dead code, and
meson_hdmi_phy_validate() accepts any tmds_char_rate value (including 0 Hz
or rates above the 594 MHz hardware limit).

In addition, meson_hdmi_phy_validate() does not check that submode is
PHY_HDMI_MODE_TMDS before reading opts->hdmi.tmds_char_rate, which shares
an anonymous union with opts->hdmi.frl when submode is PHY_HDMI_MODE_FRL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-meson-drm-=
create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr?part=3D4
