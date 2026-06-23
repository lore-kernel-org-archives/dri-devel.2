Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7680CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51EEA10EC7A;
	Tue, 23 Jun 2026 20:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MO6BXShO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE19510EC7A
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:01:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B12A60129;
 Tue, 23 Jun 2026 20:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB2B1F000E9;
 Tue, 23 Jun 2026 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782244913;
 bh=abdRzSRIMzRyvEXdYQYbD4NoC24sPEJHD0qpKCIs5/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MO6BXShOWVkjWZrSXL78y0Os1in6Kjg4qeg3XWrNB1k94sKalH1dnnZ0UqC8yqh+6
 U9jK0KaAjJkAZksg2CQzwxn364nhFCmkvOPCBGfC9MO5T0srVgzugJK2krtF6Pxdnm
 OMiFHN4K1EZZ2WczWQ1qILOzVsrlsugBaic3aeh5oXnzmJ8zdfXGvIM4LyURStcYVC
 bngOQAMnh49rErK9+Em0XbOHfr2Tu3jJpoj0UHI5asUcgJAAJecHh5cnmUoQxSDGtD
 NFxVOilBCVcxJLcBiw09MuTlydoUk1U2gEt+Vc8lc9t+5jzbg93IUR8TPu2RbztOKs
 DBMCcEeO5hoEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] drm/rcar-du: dsc: Add rudimentary Renesas R-Car
 V4H DSC driver
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260615-rcar-du-dsc-v5-3-aed1a28610e4@ideasonboard.com>
References: <20260615-rcar-du-dsc-v5-3-aed1a28610e4@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:01:52 +0000
Message-Id: <20260623200153.6AB2B1F000E9@smtp.kernel.org>
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
- [High] The DRM bridge remains registered and globally accessible after `p=
m_runtime_disable()` is called, creating a teardown order race during drive=
r removal.
- [Medium] The sleeping function `pm_runtime_get_sync()` is called from an =
atomic context path (`rcar_dsc_atomic_enable`).
--

commit a8616c71b764dc9fa4ae244e47795371e7fead44
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H DSC driver

The Renesas DSC Display Stream Compression is a bridge embedded in the
Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
8k or 400 Mpixel/s. Add rudimentary driver, which currently acts as a
pass-through bridge and allows DSI1 to be operational on R-Car V4H.

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c b/drivers/gpu/drm=
/renesas/rcar-du/rcar_dsc.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c

[ ... ]

> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
> +				   struct drm_atomic_commit *commit)
> +{
> +	struct rcar_dsc *dsc =3D bridge_to_rcar_dsc(bridge);
> +
> +	WARN_ON(pm_runtime_get_sync(dsc->dev) < 0);

[Severity: Medium]
Is it safe to call the sleeping function pm_runtime_get_sync() here?

Since rcar_dsc_atomic_enable() is called during non-blocking atomic commits,
doesn't this path execute in atomic context where sleeping is forbidden and
can lead to kernel warnings or deadlocks?

> +}

[ ... ]

> +static int rcar_dsc_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret =3D devm_drm_bridge_add(dev, &dsc->bridge);
> +	if (ret)
> +		goto err_runtime_disable;
> +
> +	return 0;
> +
> +err_runtime_disable:
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static void rcar_dsc_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);
> +}

[Severity: High]
Does this create a teardown order race during driver removal?

Because devm_drm_bridge_add() defers unregistration until after
rcar_dsc_remove() returns, the bridge remains globally accessible to the DRM
subsystem after pm_runtime_disable() has already shut down power management.

If a concurrent modeset calls rcar_dsc_atomic_enable() during this window,
won't pm_runtime_get_sync() return -EACCES and trigger the WARN_ON since
power management is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-rcar-du-ds=
c-v5-0-aed1a28610e4@ideasonboard.com?part=3D3
