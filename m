Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A16C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4F410E6F9;
	Thu, 17 Sep 2026 13:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cs8v+9Pj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD2510E6F9
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:01:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E72C60204;
 Thu, 17 Sep 2026 13:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE401F00893;
 Thu, 17 Sep 2026 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789650093;
 bh=gYNmfPf7J/3gOSKChjjGwo/GCeD+RBLAUEZdD/lp1kk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cs8v+9Pj2sQT7SmrCmfx/uzikgncfYe2UInEemdiMq/ZIK9URa0CkD4++FF8IqoOI
 1gQ7ECfjPCNnUStiGSxQa0ccktjKIG9TwAV0sCF/f2prD4YGfP0NzeDRyD/BeFDK8Z
 JhZpYAcWn9ydZ8CSbZ2vsFRkOE2ql4H2Rn85mHiaY1vCJwtAqGVFTOb9yTQMP+nJVu
 yF4k8kqwq/v0GASbVc4Wuxhc9I7KHEB5bByeGyGMu5nEwFe96vK4LNJBWOxWGJ6An9
 VLrN8xc/0c3R/Z0ZveMyOgui28KD6fEBk7hXoYxjMmx+QhN9InrVNutXx/Sk6jmsJh
 RJsuzNciDskYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] drivers: gpu: drm: panel: Add BOE NT51021 driver
To: "Nickolay Goppen" <setotau@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260917-qcom-novatek-nt51021-panels-v4-2-30afbc35d70c@mainlining.org>
References: <20260917-qcom-novatek-nt51021-panels-v4-0-30afbc35d70c@mainlining.org>
 <20260917-qcom-novatek-nt51021-panels-v4-2-30afbc35d70c@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:01:32 +0000
Message-Id: <20260917130132.CEE401F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm: panel: novatek-nt51021: UAF and crash due to premature devm_d=
rm_panel_add()
--

commit 32c00aa725aa38b42eafcacc07a8f05495f7ed3d
Author: Nickolay Goppen <setotau@mainlining.org>

    drivers: gpu: drm: panel: Add BOE NT51021 driver
   =20
    Add driver for BOE NT51021-based 8-inch and 10-inch DSI video mode
    panels used in Xiaomi Mi Pad 4, Mi Pad 4 Plus (xiaomi-clover)
    and Amazon Fire HD 10 (2017) (amazon-suez) tablets.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt51021.c b/drivers/gpu/=
drm/panel/panel-novatek-nt51021.c
> new file mode 100644
> index 0000000000000..94e7d6aaf0cb9
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt51021.c

[ ... ]

> +static int nt51021_novatek_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;

[ ... ]

> +	ctx->panel.prepare_prev_first =3D true;
> +
> +	ret =3D drm_panel_of_backlight(&ctx->panel);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get backlight\n");
> +
> +	ret =3D devm_drm_panel_add(dev, &ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	return devm_mipi_dsi_attach(dev, dsi);

[Severity: High]
Can this sequence lead to a use-after-free or kernel crash?

By calling devm_drm_panel_add() before devm_mipi_dsi_attach(), the panel is
published globally before DSI attachment completes.

If a DRM consumer discovers the panel via of_drm_find_panel() during this
window, it takes a reference on the panel. If devm_mipi_dsi_attach() then
fails, the probe function returns an error and devres cleans up the allocat=
ed
GPIO and regulator resources. However, the panel memory remains allocated
because of the consumer's reference.

When the consumer later calls drm_panel_prepare(), the panel driver will
dereference the freed GPIO and regulator pointers, causing a use-after-free.

Additionally, if a consumer calls drm_panel_prepare() before mipi_dsi_attac=
h()
completes, it will trigger DSI commands on an unattached device, crashing t=
he
DSI host.

Should devm_mipi_dsi_attach() be called before devm_drm_panel_add() to prev=
ent
this race window?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-qcom-novat=
ek-nt51021-panels-v4-0-30afbc35d70c@mainlining.org?part=3D2
