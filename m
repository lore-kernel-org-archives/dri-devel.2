Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FD2C44502
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D5810ED03;
	Tue,  7 Jul 2026 13:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gsgRWu2n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD2B10ECFF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D672E43E11;
 Tue,  7 Jul 2026 13:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CEE1F000E9;
 Tue,  7 Jul 2026 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430702;
 bh=M9tvm8sIPcCxRMUXUlzw57GONPoFPcsd8Vr4faaoYa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gsgRWu2nDDm5TA1Jc7MVq1xdvwNeQR21TfG27zw+KwE7V7vBdxbViZFihKQ9rSOsD
 vf/pW06XjQYjLyXsfcQOtn9zHzDulI41pxZE9m2990L6TUlHV2c3fYlp3TM23y77ay
 V3nvvmkDUsc74DZNfyKAgKaq/Fvq11LUY4nS1fNfjEooH73QXVUmo2mg5z8Yf2LwGA
 iiZUNLSzAEBAXnqn+ilkD/xbY4c/5tklr7ZzYzZJMQvnLbuMeXR86S2kijOl5XN7oD
 alPEpfiRO6qaWRkcgJdRNAcD3r0L8xp/5tcwSH08Fmuk0hgkePzTNRoXB07ZPtIW5Q
 /s2htwetmYMDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/20] net: mv643xx: use platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, Frank.Li@kernel.org, lee@kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, mfd@lists.linux.dev,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-14-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-14-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:25:01 +0000
Message-Id: <20260707132502.42CEE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dynamically allocated platform devices are leaked during driver re=
moval due to missing `platform_device_put()`.
- [High] The static global `port_platdev` array is accessed without synchro=
nization, leading to probe races and cross-device teardown corruption.
- [High] Missing `phy_disconnect()` on the error path of `mv643xx_eth_probe=
()`, leading to a use-after-free of the `net_device`.
--

commit 286e3bdd9b38ee5d56ee5ff7b8525f2effcb4c53
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

net: mv643xx: use platform_device_set_of_node()
   =20
Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/eth=
ernet/marvell/mv643xx_eth.c
> index 1881583be5ce2..9caa1e47c174c 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c

[ ... ]

> @@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct pl=
atform_device *pdev,
>  		goto put_err;
>  	}
>  	ppdev->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
> -	ppdev->dev.of_node =3D of_node_get(pnp);
> +	platform_device_set_of_node(ppdev, pnp);

[Severity: High]
This isn't a bug introduced by this patch, but does this dynamically alloca=
ted
platform device leak during driver removal?

Earlier in mv643xx_eth_shared_of_add_port(), platform_device_alloc() sets t=
he
initial reference count to 1. During removal, mv643xx_eth_shared_of_remove()
calls platform_device_del(), which removes the device from the hierarchy but
fails to drop the reference count.=20

Without a matching platform_device_put(), the device and its associated data
leak on unbind or probe failure.

[Severity: High]
This is also a pre-existing issue, but could this global port array logic
cause cross-device teardown corruption?

This function searches for a free slot in the global port_platdev array
without synchronization:

mv643xx_eth_shared_of_add_port() {
    ...
    while (dev_num < 3 && port_platdev[dev_num])
        dev_num++;
    ...
}

If controllers probe concurrently, they could race on this global state.
Additionally, if one controller is unbound via sysfs,
mv643xx_eth_shared_of_remove() unconditionally iterates over the global
array and deletes all ports:

mv643xx_eth_shared_of_remove() {
    ...
    for (n =3D 0; n < 3; n++) {
        if (!port_platdev[n])
            continue;
        platform_device_del(port_platdev[n]);
        port_platdev[n] =3D NULL;
    }
}

Wouldn't this destroy active network ports belonging to completely independ=
ent
controllers sharing the driver?

[Severity: High]
This is another pre-existing issue, but does the probe error path leave a
dangling pointer in the PHY subsystem?

In mv643xx_eth_probe(), the driver connects the PHY (which attaches it and
stores a pointer to the net_device in phydev->attached_dev). If a subsequent
operation in the probe fails, the error path frees the net_device but never
disconnects the PHY:

mv643xx_eth_probe() {
    ...
out:
    if (!IS_ERR(mp->clk))
        clk_disable_unprepare(mp->clk);
    free_netdev(dev);
   =20
    return err;
}

Can this lead to a use-after-free if the PHY device remains active and
is later accessed via sysfs or core PHY polling routines?

> =20
>  	ret =3D platform_device_add_resources(ppdev, &res, 1);
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D14
