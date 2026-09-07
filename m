Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87991C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8D610E49E;
	Mon,  7 Sep 2026 09:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KyiRbDuz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DBB10E49E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:43:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81D46403B3;
 Mon,  7 Sep 2026 09:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08D51F00A3A;
 Mon,  7 Sep 2026 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788774198;
 bh=xWz1rKPmZUeKMlCJyxKTuEIDW/xLK1n8Aa/NAKxz8O8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KyiRbDuzUyKXLiZ6efaBf/s+pOdRZOlJGNbdgXeXuyr9KE405/4chBKsOK/TNShdH
 4MimnPwSYIdZOCmq/EPvTDd1MapLaoW8EyK/5o6VS7SE7MCwhhJy9dkehEhShsQB7V
 OqLs/QTHXwoRLx5bz9fPTw4v+iAndgn64txtsUoBIkh2VQ8mdGp3WasC8sc446Phhi
 Lyab6hrc4bRr+8/+w2krbO7XLqwOhUmRsSsw2LFyMGXuq9FCTLrCY1R0c7ouZmmshU
 mQpom1piARlSNAOMbuGfeNuMaqbOWHWwFfbDyYguBk2iOIKCpJOmsMvledjgimgviq
 H2pc54Ajihk9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] arm64: dts: renesas: sparrow-hawk: Enable
 DisplayPort by adding DSC
To: "Tomi Valkeinen" <tomi.valkeinen+renesas@ideasonboard.com>
Cc: wsa+renesas@sang-engineering.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260907-rcar-du-dsc-v6-5-f8ef711a7494@ideasonboard.com>
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
 <20260907-rcar-du-dsc-v6-5-f8ef711a7494@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 09:43:17 +0000
Message-Id: <20260907094317.F08D51F00A3A@smtp.kernel.org>
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
- [Medium] The DRM bridge reference obtained via of_drm_get_bridge_by_endpo=
int() is leaked on error paths and during driver removal.
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

[Severity: Medium]
Does this code leak the DRM bridge reference obtained via
of_drm_get_bridge_by_endpoint()?

If devm_drm_bridge_add() fails later in rcar_dsc_probe(), the cleanup path
fails to drop this bridge reference.

This means the memory for the downstream bridge object will never be freed.

Since driver probe errors and unbinds are cold paths that require root
privileges or hardware faults to trigger, this leaks the bridge reference
on a cold path.

> +	if (IS_ERR(dsc->bridge.next_bridge))
> +		return PTR_ERR(dsc->bridge.next_bridge);
> +
> +	dsc->bridge.of_node =3D dev->of_node;
> +
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

[Severity: Medium]
Could this leak the DRM bridge reference during driver removal?

Since the reference acquired in rcar_dsc_probe() isn't dropped here,
unbinding the device will leave the struct drm_bridge kref leaked.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-rcar-du-ds=
c-v6-0-f8ef711a7494@ideasonboard.com?part=3D5
