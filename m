Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989D9C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7309E10EBAC;
	Tue, 30 Jun 2026 09:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k/m9TGcY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129ED10E1C9
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:18:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C800A437AF;
 Tue, 30 Jun 2026 09:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472D21F00A3A;
 Tue, 30 Jun 2026 09:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782811117;
 bh=+rs0ZUF0if/Za3Uiro3OrWLPieYVGjbTD0wnfhoEsq0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k/m9TGcY2lNPGdxdvQg/CTDjj7CAcDHJJzGSGpe4ymRjkBosds1MY+MPV+Jx5Gs6o
 0v/ow/eHvFDgsNQBCiHGJKiTL2ctlkQbEzEIiapRyCWfPnXugtqVz08h8tzVJJDRLg
 Igq1choNcdTNjuuK5fYuYyRV78JoO5IDmuSHTNVvrpyUiWMDWKVmlyoSVsP+8sDdJN
 sXAV2wQhk6SrrWPhoLv3sU5elQbzLo2JB5CMnUSkwdT48LXXL+aF2FMJ4sEiGGGzIN
 BWkAEw3ChIQ0ZoW/0PxXUyUcF9eZKLmZ4blzWe2V1Uu9D0oYAw6FciVg3iXEzGsb3n
 0ZltdEAOGsD0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/19] net: bcmgenet: use platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, imx@lists.linux.dev,
 robh@kernel.org
In-Reply-To: <20260629-pdev-fwnode-ref-v2-9-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-9-8abe2513f96e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:18:36 +0000
Message-Id: <20260630091837.472D21F00A3A@smtp.kernel.org>
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
- [Low] Mixing goto-based error handling and scope-based cleanup (__free) i=
n the same function.
--

commit 6b5f2b27db1f7295943bada498301e27ac1e7653
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

net: bcmgenet: use platform_device_set_of_node()

This commit encapsulates the assignment of the OF node for dynamically
allocated platform devices with the provided helper. This is done ahead
of reworking the reference counting logic for platform devices.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/e=
thernet/broadcom/genet/bcmmii.c
> index a4e0d5a682687..451b23a039ceb 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
[ ... ]
> @@ -490,10 +490,14 @@ static int bcmgenet_mii_register(struct bcmgenet_pr=
iv *priv)
>  	/* Retain this platform_device pointer for later cleanup */
>  	priv->mii_pdev =3D ppdev;
>  	ppdev->dev.parent =3D &pdev->dev;
> -	if (dn)
> -		ppdev->dev.of_node =3D bcmgenet_mii_of_find_mdio(priv);
> -	else
> +
> +	if (dn) {
> +		struct device_node *np __free(device_node) =3D bcmgenet_mii_of_find_md=
io(priv);

[Severity: Low]
Does introducing a __free() variable in a function that already relies on
goto-based error handling conflict with the kernel's cleanup design guideli=
nes?

Looking at bcmgenet_mii_register(), the function uses goto out for its error
paths. According to include/linux/cleanup.h, the expectation is that usage =
of
goto and cleanup helpers is never mixed in the same function. It is general=
ly
recommended to either convert all resources that need a goto cleanup to
scope-based cleanup, or convert none of them, to avoid creating confusing
ownership semantics.

> +
> +		platform_device_set_of_node(ppdev, np);
> +	} else {
>  		ppd.phy_mask =3D ~0;
> +	}
> =20
>  	ret =3D platform_device_add_resources(ppdev, &res, 1);
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-pdev-fwnod=
e-ref-v2-0-8abe2513f96e@oss.qualcomm.com?part=3D9
