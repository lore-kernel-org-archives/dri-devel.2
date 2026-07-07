Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D04DC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B832310ECF4;
	Tue,  7 Jul 2026 13:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dWjqRYBT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840EF10E4D0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CE5040D75;
 Tue,  7 Jul 2026 13:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD591F00A3A;
 Tue,  7 Jul 2026 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430696;
 bh=Bx2JzCcYq82p16fL7dukcKAX14UMiQci0RtZsHYkJ2o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dWjqRYBTOy+GwmrYWh2iEDpfJJANkCDy0s7fkqR6Dk1BUxO1wGGrx/ovWY93q7/oK
 eJ2fWUfgjRblwQy1AHjcNfpWfmqBI/Dm8GUkBQLVfCy9eqgfpFiu2LQqLy6hO1AUHe
 c0wZrV1KWUwF+qFojihGFYWCWK6wFAoxufQIQmnXoeC92gtfDCDgoSNMgkpRKcYxFw
 rqQ8hmTfPfxDhXhfCYJIFhMsYilyaYCbVWyBaZZgaD1TKiXiuHueEoCVOJKhJCZoSq
 kkuacNr9Azx7yCYluaYHcu36bIwwer2JBD7JiI51+tCmuR0g58/8F5keweqF0L3e96
 /SkO/RBzTSwXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/20] i2c: pxa-pci: use platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, lee@kernel.org,
 Frank.Li@kernel.org, robh@kernel.org, imx@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-8-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-8-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:55 +0000
Message-Id: <20260707132455.ABD591F00A3A@smtp.kernel.org>
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
- [Medium] The OF device node reference obtained from `for_each_child_of_no=
de()` is leaked when assigning the OF node to the platform device.
--

commit 0b7f7e14c13b65be057bb0d2e9e1a4b953a99635
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

i2c: pxa-pci: use platform_device_set_of_node()

This patch updates the i2c-pxa-pci driver to use the new
platform_device_set_of_node() helper for dynamically allocated platform
devices. It replaces the direct assignment of the OF node pointer ahead of
upcoming reference counting reworks in the driver core.

> diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-px=
a-pci.c
> index dbd542300f800..92a0647f08c69 100644
> --- a/drivers/i2c/busses/i2c-pxa-pci.c
> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
> @@ -76,7 +76,8 @@ static struct platform_device *add_i2c_device(struct pc=
i_dev *dev, int bar)
>  		goto out;
>  	}
>  	pdev->dev.parent =3D &dev->dev;
> -	pdev->dev.of_node =3D child;
> +
> +	platform_device_set_of_node(pdev, child);

[Severity: Medium]
Does this change introduce an OF node reference leak?

Earlier in add_i2c_device(), the child node is acquired using a
for_each_child_of_node() loop that exits via break. This leaves the child
variable with an incremented reference count.

Before this patch, the direct assignment implicitly transferred this
reference to the platform device. The new platform_device_set_of_node()
helper takes its own additional reference internally when setting the fwnod=
e.
Since the caller's original reference is never explicitly dropped after
this helper is called, it seems this will leak the OF node reference on both
the success and error paths. Should there be an of_node_put(child) after
calling the helper?

> =20
>  	ret =3D platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D8
