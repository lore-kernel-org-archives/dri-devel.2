Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77669CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CE110E379;
	Thu,  1 Oct 2026 13:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q0pCHXCP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0AC10E379
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:25:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5530040F2D;
 Thu,  1 Oct 2026 13:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B421F000FF;
 Thu,  1 Oct 2026 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790861120;
 bh=7uDSSXgHpLPmo8DtUMbDbifSXys+MSfcOxbXoyquKd0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q0pCHXCP3dRBOSooWVpP+fIYmx5Jz9k/Rjg5H5R3aO67oua8HQL2oP6WsXEBv2aTv
 vEncs0fH1RmEVVlFs4xlzWeag3nNVFCQSG2gjoNIpIq3T//uJS0PBvFNwiRKJ3v7R/
 0/vx5wXHbF9jysZLaqpYPGtPnnnoEWF95tdst+A4I8oQb6CAh6IjbF016hfwnjHo5t
 knbST85GnQ2b8PgrOIvFTWNUEp00MFBV+zPltUs4wG1iusV1RdRzdDPw9G+XjL4JJU
 +mmlgH4BDVKDIRStE9xOsKN4Ua4qimw/b8ha93XsIpN3UuLObB6gXl7zk6ppAWqCMX
 dugO9ZagzDt3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 21/24] drm/bridge: ti-sn65dsi86: implement
 .get_next_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20261001-drm-bridge-hotplug-v2-21-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-21-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:25:19 +0000
Message-Id: <20261001132520.00B421F000FF@smtp.kernel.org>
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
- [High] drm/bridge: refcount underflow in sn65dsi86_get_next_bridge()
--

commit ed254bdda2bfa941d8761ef842227d71a55ce971
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: ti-sn65dsi86: implement .get_next_bridge

This commit adds a get_next_callback function to expose the next bridge in =
the
ti-sn65dsi86 driver.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 48b83df9aed61..e981d98a39b96 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -743,6 +743,13 @@ static int ti_sn_attach_host(struct auxiliary_device=
 *adev, struct ti_sn65dsi86
>  	return devm_mipi_dsi_attach(&adev->dev, dsi);
>  }
> =20
> +static struct drm_bridge *sn65dsi86_get_next_bridge(struct drm_bridge *b=
ridge)
> +{
> +	struct ti_sn65dsi86 *pdata =3D bridge_to_ti_sn65dsi86(bridge);
> +
> +	return pdata->next_bridge ?: ERR_PTR(-ENODEV);

[Severity: High]
Does this callback need to call drm_bridge_get() on the next bridge before
returning it?

The get_next_bridge API expects the returned bridge to have an incremented
reference count. Callers of drm_bridge_get_next() will clean up the returned
bridge using drm_bridge_put(). Because this function returns the pointer
directly without acquiring a reference, the subsequent put operation will
decrement a reference that was never acquired.

Could this lead to a regression involving a use-after-free of the next_brid=
ge
structure during pipeline initialization or hotplug events?

> +}
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D21
