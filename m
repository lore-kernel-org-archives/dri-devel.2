Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC92C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB95110ECF7;
	Tue,  7 Jul 2026 13:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m6V9pTFE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6669310E4D0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EFBF40D75;
 Tue,  7 Jul 2026 13:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C41F00A3A;
 Tue,  7 Jul 2026 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430698;
 bh=F9wf81DUrFRYlTgbDUYEac7HMXcil+UOZENGoJcInJg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m6V9pTFEiov7ozZFACq6/OJ49HW+A0rUKcqJVq8EKHjrZRuHZAufmYtBK3RiApU9T
 yiD+ybowTG+NbFpcCcPHFN5RrtA2GTHIBcoW4C05eygAY7mK1X1woN58Vm4xzH4igY
 q7xafcgDoJgN1p7j5OzBRKMnualElX0vhPIAn/atcJJ85NQJApDj/6Wkf7LCEJg0e/
 umoYOcldjA8ueepLrYwouegTHhB5D2JS00ecdrTpQf6jg4HqERGjfgHv/uwaAA/uhd
 IYXhi/hj9alA3jQpnLlsc2y8iNBApxAeVp5Nc2g7QXUFv5PrOVY0y5VFI5WgqE575R
 q0HMMOEWvGlhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/20] net: bcmgenet: use platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org,
 Frank.Li@kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260706-pdev-fwnode-ref-v3-10-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-10-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:57 +0000
Message-Id: <20260707132457.B23C41F00A3A@smtp.kernel.org>
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
- [Medium] OF Node Reference Leak due to missing of_node_put() on the resul=
t of bcmgenet_mii_of_find_mdio()
--

commit 3b29ae0c601cb855b049f7da529812b74080533b
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

net: bcmgenet: use platform_device_set_of_node()

This commit encapsulates the assignment of the OF node for dynamically
allocated platform devices using platform_device_set_of_node().

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/e=
thernet/broadcom/genet/bcmmii.c
> index a4e0d5a682687..0f0dbabfaabbc 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
[ ... ]
> @@ -490,8 +490,9 @@ static int bcmgenet_mii_register(struct bcmgenet_priv=
 *priv)
>  	/* Retain this platform_device pointer for later cleanup */
>  	priv->mii_pdev =3D ppdev;
>  	ppdev->dev.parent =3D &pdev->dev;
> +
>  	if (dn)
> -		ppdev->dev.of_node =3D bcmgenet_mii_of_find_mdio(priv);
> +		platform_device_set_of_node(ppdev, bcmgenet_mii_of_find_mdio(priv));

[Severity: Medium]
Does this leak the OF node reference? bcmgenet_mii_of_find_mdio() internally
calls of_get_compatible_child(), which returns a device node with an
incremented reference count.

Previously, direct assignment allowed the platform device to consume this
reference when it was eventually released. Now that
platform_device_set_of_node() is used, it acquires its own reference
internally.=20

Should there be an explicit of_node_put() to drop the initial reference
returned by bcmgenet_mii_of_find_mdio() so it isn't leaked?

>  	else
>  		ppd.phy_mask =3D ~0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D10
