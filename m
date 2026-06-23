Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07F2CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F08010EC97;
	Tue, 23 Jun 2026 20:37:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gI5FM0sp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1487210EC97
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:37:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EB0560125;
 Tue, 23 Jun 2026 20:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD151F000E9;
 Tue, 23 Jun 2026 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782247035;
 bh=Li6xbg/V83Rks1Bkfq2CEL6SwT7EnyIuPl2BL5bWe2E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gI5FM0spp6rSlaoycupWq3QEUVYtoXpqPSPnD3b1bqtTyiHFlYVPAxyhFJ2f4S4/s
 XkTChjVAE2uIAUmFFBK7tg+LJINdd08TCAAkuGzRvS6DfXbfOtpaUXMZrk38DcbAjZ
 iHNk4kbGCkdWkRPKLZjxF+VDkVIOD87JCbHbC/nXbhmH1t+KBHZt/Rglh401UEpTNO
 gt3X2z3/UEEtXIbYIpoeWK5+19zLBPqsw245SST4NQ8CUU5tTgqtqPT63KxHDELiNH
 BxI+3foQzcyxhKvcv+B3DlmzzoEU/a+b/eWpiwYFy5lw9wo5xMUuyqwXZ3sEteNy0V
 l0PEwwKVln3tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/7] arm64: dts: renesas: sparrow-hawk: Enable
 DisplayPort by adding DSC
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260615-rcar-du-dsc-v5-6-aed1a28610e4@ideasonboard.com>
References: <20260615-rcar-du-dsc-v5-6-aed1a28610e4@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:37:14 +0000
Message-Id: <20260623203714.BBD151F000E9@smtp.kernel.org>
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
- [High] The rcar_dsc driver ignores the `resets` property from the DT bind=
ing, failing to deassert the DSC hardware module's reset state.
--

commit a8616c71b764dc9fa4ae244e47795371e7fead44
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H DSC driver

This commit introduces a rudimentary DSC bridge driver for the Renesas R-Car
V4H SoC. The driver functions as a pass-through to enable the DSI1 pipeline
and performs VESA DSC encoding.

> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c b/drivers/gpu/drm=
/renesas/rcar-du/rcar_dsc.c
> new file mode 100644
> index 0000000000000..362e683289d69
> --- /dev/null
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c

[ ... ]

> +static int rcar_dsc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct rcar_dsc *dsc;
> +	int ret;
> +
> +	dsc =3D devm_drm_bridge_alloc(dev, struct rcar_dsc, bridge,
> +				    &rcar_dsc_bridge_ops);
> +	if (IS_ERR(dsc))
> +		return PTR_ERR(dsc);
> +
> +	platform_set_drvdata(pdev, dsc);
> +
> +	dsc->dev =3D &pdev->dev;
> +
> +	dsc->bridge.next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node,
> +								1, 0);

[Severity: High]
Does this driver fail to retrieve and deassert the DSC module's hardware re=
set
state?

If the reset control isn't retrieved and deasserted, the DSC hardware module
will remain in a reset state, breaking the display pipeline functionality. =
It
might coincidentally work if the bootloader has already deasserted the rese=
t,
but could fail on suspend/resume or when the bootloader does not initialize
the display.

Should the driver use devm_reset_control_get_exclusive() here and deassert
the reset state during probe?

> +	if (IS_ERR(dsc->bridge.next_bridge))
> +		return PTR_ERR(dsc->bridge.next_bridge);
> +
> +	dsc->bridge.of_node =3D dev->of_node;
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret =3D devm_drm_bridge_add(dev, &dsc->bridge);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-rcar-du-ds=
c-v5-0-aed1a28610e4@ideasonboard.com?part=3D6
