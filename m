Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB25606AF41
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ycr5FYO2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4C3112624;
	Thu, 22 Oct 2026 13:40:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02A3112624
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:39:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D31EC60A56;
 Thu, 22 Oct 2026 13:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1EF1F000C3;
 Thu, 22 Oct 2026 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792676396;
 bh=ckfGmlxk/j360Pa+hHTBheMqJ6vtsGxDjfVuFGw7y1Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ycr5FYO2RNEts4SPKekdNpG08NA82ErdDNVdmjHhyhCrMaT9CmcanEnEnAjfugFtv
 6+bWux3VUkAioWt6zowgykntxWAu9sJ10+oEgIPQsZdP2UAerd9KH+8N89ohT4q45c
 XIK8Yd6fNsau+ANIAWFM0R/dLRiZopy7yo26BYImLaFHOAOPI7t75J7WJIkLXnwKtF
 lfR62qY0XKumQ4tQGxJWd48zX8OuRwx1iQgrpklZYrPpJTfDZ59uYsbVRsTyZmlKiV
 d8QgNPvQHiIJnpEZbwrO0yaZl0ZqHbsAuPX0TN2jkR00k1fRgcZCNlp0HXFFE1v/Mw
 4BPQBp91wpI7g==
Message-ID: <sashiko-outbox-181558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI
 Type B panel driver
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261022132259.240717-3-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
 <20261022132259.240717-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 13:39:55 +0000
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
- [High] drm/panel: hitachi-tx10d07vm0baa: NULL deref of priv->dbi in enabl=
e/disable
--

commit 918fbda401f49537dce4afff189990897a904ac4
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver

This commit adds a DRM panel driver for the Hitachi TX10D07VM0BAA 4" WVGA
MIPI DBI Type B panel used in the LG Optimus 2X P990 smartphone.

> diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driver=
s/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> new file mode 100644
> index 0000000000000..83c2af1be9755
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> @@ -0,0 +1,297 @@

[ ... ]

> +#define panel_dbi_command(priv, cmd, seq...) \
> +({ \
> +	const u8 d[] =3D { seq }; \
> +	struct drm_panel *panel =3D &(priv)->panel; \
> +	struct device *dev =3D panel->dev; \
> +	int ret; \
> +	ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d)); \
> +	if (ret) \
> +		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret,=
 cmd); \
> +	ret; \
> +})
> +
> +static int hitachi_tx10d07vm0baa_prepare(struct drm_panel *panel)
> +{
> +	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> +	struct device *dev =3D panel->dev;
> +	int ret;
> +
> +	priv->dbi =3D dev_get_drvdata(dev->parent);
> +	if (!priv->dbi)
> +		return -ENODEV;
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0baa_supplies=
), priv->supplies);
> +	if (ret) {
> +		dev_err(dev, "failed to enable power supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(1000, 2000);
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +
> +	usleep_range(10000, 11000);
> +
> +	return 0;
> +};
> +
> +static int hitachi_tx10d07vm0baa_enable(struct drm_panel *panel)
> +{
> +	struct hitachi_tx10d07vm0baa *priv =3D to_hitachi_tx10d07vm0baa(panel);
> +
> +	panel_dbi_command(priv, MIPI_DCS_SET_PARTIAL_ROWS, 0x00, 0x00, 0x03, 0x=
1f);

[Severity: High]
Can this dereference a NULL priv->dbi pointer in
hitachi_tx10d07vm0baa_enable() and hitachi_tx10d07vm0baa_disable() if
hitachi_tx10d07vm0baa_prepare() fails to obtain priv->dbi?

In hitachi_tx10d07vm0baa_probe(), priv->dbi is left NULL and only looked up
in hitachi_tx10d07vm0baa_prepare() via dev_get_drvdata(dev->parent). If
dev_get_drvdata(dev->parent) returns NULL (for example, when the panel node
is instantiated outside a bound tegra-dbi parent, as in the standalone
OF-graph panel node shown in hit,tx10d07vm0baa.yaml, or after parent unbind=
),
hitachi_tx10d07vm0baa_prepare() returns -ENODEV with priv->dbi still NULL a=
nd
panel->prepared remaining false.

During an atomic modeset commit in drm_atomic_helper_commit_modeset_enables=
(),
panel_bridge_atomic_pre_enable() calls drm_panel_prepare(), which cannot
abort the commit on error. Next,
drm_atomic_helper_commit_encoder_bridge_enable() invokes
panel_bridge_atomic_enable() (and tegra_dbi_atomic_enable() in commit
"drm/tegra: Add support for 8-bit CPU interface"), which calls
drm_panel_enable(panel).

Because drm_panel_enable() checks panel->enabled but does not check
panel->prepared:

drivers/gpu/drm/drm_panel.c:drm_panel_enable() {
	...
	if (panel->funcs && panel->funcs->enable) {
		ret =3D panel->funcs->enable(panel);
		if (ret < 0)
			goto exit;
	}
	...
}

it proceeds to call hitachi_tx10d07vm0baa_enable() (and later
hitachi_tx10d07vm0baa_disable()), passing priv->dbi =3D=3D NULL through
panel_dbi_command() -> mipi_dbi_command_stackbuf() -> mipi_dbi_command_buf(=
):

drivers/gpu/drm/drm_mipi_dbi.c:mipi_dbi_command_buf() {
	...
	mutex_lock(&dbi->cmdlock);
	ret =3D dbi->command(dbi, cmdbuf, data, len);
	mutex_unlock(&dbi->cmdlock);
	...
}

Would it make sense to look up priv->dbi in hitachi_tx10d07vm0baa_probe()
(or guard against a NULL priv->dbi before issuing DBI commands)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022132259.2407=
17-1-clamor95@gmail.com?part=3D2
