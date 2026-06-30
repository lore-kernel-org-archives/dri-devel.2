Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B56C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FF210EBCC;
	Tue, 30 Jun 2026 09:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ey4GOTrF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DBB10EBB6
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:18:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE55E60008;
 Tue, 30 Jun 2026 09:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013AA1F00A3A;
 Tue, 30 Jun 2026 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782811120;
 bh=/sckeJZcNQD0sYt7C1pNbjU0qMEki24aBgd1V8kmJ1g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ey4GOTrFLtGfWLYRdGZZ+9PbzDM92QkzPkfx5HAwEW56NkF1edDxE3hPHA60S++Pl
 SRTejMZfMl5FA7CT+YfDD7N1GRnhiGgPswsnz1lWicb36Z7Aa9vQtWyDdna8ReuyZf
 C2gG30E99oiUbM7uFAYqQu0NHXm/NmHIhS2udOZkTedFL8cz6qFiRAnG2QFY1uTp0L
 OumB5DtbmQwzuSEgjE++QMTVCjgo/93H8ehCcVZ/gmkowoH9nICHcndTohNvY2YNaD
 vQGSKkOuA8Wnfe1McRj20rpgTq5G+K7DZFn+8s3x+M/u55OeezjebVJJQHRM3ijooh
 TTCyFbblQNc6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/19] pmdomain: imx: use platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 conor+dt@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260629-pdev-fwnode-ref-v2-10-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-10-8abe2513f96e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:18:39 +0000
Message-Id: <20260630091840.013AA1F00A3A@smtp.kernel.org>
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

New issues:
- [Medium] OF node reference leak introduced by replacing direct assignment=
 with platform_device_set_of_node().

Pre-existing issues:
- [High] Missing cleanup of dynamically allocated child platform devices ca=
uses Use-After-Free on probe error and remove paths.
--

commit f80cbf40e80bb2e67469b487f2abcc9652b28cb1
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

pmdomain: imx: use platform_device_set_of_node()

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 42e50c9b4fb9f..abca5f449a226 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  			domain->ipg_rate_mhz =3D ipg_rate_mhz;
> =20
>  			pd_pdev->dev.parent =3D &pdev->dev;
> -			pd_pdev->dev.of_node =3D of_node_get(np);
> -			pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
> +			platform_device_set_of_node(pd_pdev, np);

[Severity: Medium]
Does replacing direct assignment with platform_device_set_of_node()
introduce an OF node reference leak?

In drivers/i2c/busses/i2c-pxa-pci.c:add_i2c_device(), the function acquires
an OF node reference via the for_each_child_of_node iterator and then calls
platform_device_set_of_node(pdev, child) on success.

Before this patch series, pdev->dev.of_node =3D child directly transferred
ownership of the reference to the platform device, which released it upon
destruction. Because the new helper platform_device_set_of_node()
explicitly increments the reference count internally, and there is no
of_node_put(child) added after the helper call, does this permanently leak
the original iterator reference on both success and error paths?

> =20
>  			ret =3D platform_device_add(pd_pdev);
>  			if (ret) {

[Severity: High]
This is a pre-existing issue, but does the missing cleanup of dynamically
allocated child platform devices cause a use-after-free on probe error and
remove paths?

In imx_gpc_probe(), child devices (pd_pdev) are dynamically allocated and
registered in a loop. If a subsequent iteration fails and returns here,
the function returns immediately without unregistering the previously added
children.

Furthermore, in imx_gpc_remove(), when using the new device tree binding
(pgc_node is present), it exits without unregistering any child devices.

Since the child devices remain registered, their bound drivers (imx-pgc-pd)
stay active. When the parent devres cleanup frees the regmap, won't any
subsequent power state transition by the active child domains dereference
the freed domain->regmap, resulting in a use-after-free crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-pdev-fwnod=
e-ref-v2-0-8abe2513f96e@oss.qualcomm.com?part=3D10
