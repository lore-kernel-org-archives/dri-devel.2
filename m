Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89623CA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C5910F206;
	Wed, 30 Sep 2026 07:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NokZZyjT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193C610F204
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:15:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7AF743AAE;
 Wed, 30 Sep 2026 07:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D83D1F00893;
 Wed, 30 Sep 2026 07:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790752546;
 bh=dxxUA6j1kEvyf5BoLPZW7xixqB8V2q/KSZJwuxfYh3U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NokZZyjTR0Ug/pK6bfJIk2yg6CWvunRVkZDt95BVQDT5IAwGY3/R+sKS78lx/cA9L
 VQ8ZaDnh30v55T8gBSx139TEaYMTlZmWSMdL1eZQ9oplUni8eJ6GP0hzHxVa7y8noL
 IFZ1ypevuTG6KI2Ym3/+P5elXgbaHQohaWcOvijl9CB3Ef2E9DORS+fG3u2IZSYcd2
 5cee6ZAU9z9L2ffg5naH+iv2m3c8G2U2b+tKcdL56L8Sygv1umxXL7DvW0UPvYK/Z1
 CUt5Fv/ho5pD6C8cVRk6G/Euq13DHRPzaSc6r/42UJdGQ9KSKkEBrurA5JRnjiDOn7
 XZWt49ir7VaVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/6] drm/panel: Add Hitachi TX10D07VM0BAA and LG
 LH400WV3-SD04 MIPI DBI panel driver
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260930070535.47130-7-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
 <20260930070535.47130-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:15:45 +0000
Message-Id: <20260930071546.6D83D1F00893@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/panel: missing put_device() causes refcount leak in panel_dbi_=
prepare()
- [High] drm/panel: unsafe lockless access to remote drvdata risks UAF
--

commit af85d3c58c7325c679bd0289254561bdca27049a
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm/panel: Add Hitachi TX10D07VM0BAA and LG LH400WV3-SD04 MIPI DBI panel dr=
iver

This commit adds a DRM panel driver for the Hitachi TX10D07VM0BAA and LG
LH400WV3-SD04 MIPI DBI panels used in the LG Optimus 2X P990. These panels =
are
linked to the DRM encoder via an RGB to DBI bridge.

> diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/driver=
s/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> new file mode 100644
> index 0000000000000..e78814c9697af
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
[ ... ]
> +static int panel_dbi_prepare(struct drm_panel *panel)
> +{
> +	struct panel_dbi *priv =3D to_panel_dbi(panel);
> +	struct platform_device *bridge_pdev;
> +	struct device_node *bridge_node;
> +	struct device *dev =3D panel->dev;
> +	int ret;
> +
> +	bridge_node =3D of_graph_get_remote_node(dev_of_node(dev), 0, 0);
> +	if (!bridge_node)
> +		return -ENODEV;
> +
> +	bridge_pdev =3D of_find_device_by_node(bridge_node);
> +	of_node_put(bridge_node);
> +	if (!bridge_pdev)
> +		return -ENODEV;

[Severity: High]
Does this code leak the reference to bridge_pdev?

The function of_find_device_by_node() increments the reference count of the
returned platform device, but it doesn't appear to be released with
put_device() anywhere in this function.=20

Since panel_dbi_prepare() is called on every display enable operation (such=
 as
during a DPMS on/off cycle), couldn't this leak references incrementally and
eventually lead to a refcount overflow or memory exhaustion?

> +
> +	priv->dbi =3D platform_get_drvdata(bridge_pdev);

[Severity: High]
Is it safe to cache the remote bridge device's drvdata locklessly here?

If the bridge device gets unbound via sysfs while the panel is still active,
the bridge's devres-managed memory would be freed. A subsequent panel
operation, such as calling panel_dbi_command() during teardown, would then
dereference the freed pointer:

    ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d));

Could this lead to a use-after-free, since there is no device link or locki=
ng
holding a reference to the bridge's lifecycle?

> +	if (!priv->dbi)
> +		return -ENODEV;
> +
> +	gpiod_set_value_cansleep(priv->reset_gpio, 1);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930070535.4713=
0-1-clamor95@gmail.com?part=3D6
