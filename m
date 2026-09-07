Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F07C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ECC110E74B;
	Mon,  7 Sep 2026 09:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ThXAav+V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 910D810E49E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:42:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B31B960052;
 Mon,  7 Sep 2026 09:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049221F00A3A;
 Mon,  7 Sep 2026 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788774172;
 bh=UkvRBTt8pkA8VEUwAYaOuhNKPkFMbDmktaGuHho3y1s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ThXAav+Vm7TqfWfMzyyxY2Ahg/SAvyCsqFdt4apHOU+/9J/7qB4E2gncOdRSMwe+7
 hc7j0miuCfDH7tnGZV/J0UUEPwyYfytjB8CEewiATb6jv+uKHNxga6AsLG9g309701
 CWXBAT+fYZOfNCslYKQO+TJlAQcOWhGPm3X6MYTFCqClY9DDtsEeI1VuWybzZXmGRg
 FwjSB5C1ZkmELhRzK0Q/x8W4Q2oJTVxQG5AfU5e/rMGG3hqB8ViPmadc+AvOmobotg
 ssesRkePWa/6pA8010VP+LLvd/C+AhJB4tvKHzZfdj3ahjJZYeamlANOuqxoetj6aC
 DeZSE9eN/uJPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] drm/rcar-du: dsc: Add rudimentary Renesas R-Car
 V4H DSC driver
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260907-rcar-du-dsc-v6-2-f8ef711a7494@ideasonboard.com>
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
 <20260907-rcar-du-dsc-v6-2-f8ef711a7494@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 09:42:51 +0000
Message-Id: <20260907094252.049221F00A3A@smtp.kernel.org>
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
- [High] Lifecycle teardown order inversion between manual PM runtime disab=
le and devres bridge removal.
--

commit a2a78077050a0efecae114552f483f67a6423d4c
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H DSC driver

The Renesas DSC Display Stream Compression is a bridge embedded in the
Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
8k or 400 Mpixel/s. Add rudimentary driver, which currently acts as a
pass-through bridge and allows DSI1 to be operational on R-Car V4H.

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c b/drivers/gpu/drm=
/renesas/rcar-du/rcar_dsc.c
> new file mode 100644
> index 0000000000000..1882ae34ce8f5
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
[ ... ]
> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
> +				   struct drm_atomic_commit *commit)
> +{
> +	struct rcar_dsc *dsc =3D bridge_to_rcar_dsc(bridge);
> +
> +	WARN_ON(pm_runtime_get_sync(dsc->dev) < 0);
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
Does this create a lifecycle teardown order inversion during driver unbind?

When the driver is unbound, the driver core executes the manual
rcar_dsc_remove() callback first, which calls pm_runtime_disable(). Only
afterwards does the devres infrastructure execute drm_bridge_remove()
(registered via devm_drm_bridge_add() in rcar_dsc_probe()), removing the
bridge from the system.

During this window, the DRM bridge remains active and accessible to the DRM
core after its power management has been disabled. If an atomic commit occu=
rs
during this time, rcar_dsc_atomic_enable() will invoke pm_runtime_get_sync(=
),
which will fail since PM runtime is disabled. This triggers a WARN_ON and
leaves the hardware unpowered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-rcar-du-ds=
c-v6-0-f8ef711a7494@ideasonboard.com?part=3D2
