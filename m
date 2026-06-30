Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935BFC43638
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C0D10EBC8;
	Tue, 30 Jun 2026 09:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nDN4GIX1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607D810EBB6
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:18:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4929F43DD4;
 Tue, 30 Jun 2026 09:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE2F1F00A3D;
 Tue, 30 Jun 2026 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782811123;
 bh=9OH3q4zyN12p0WjlOzyD0rZl+9v/3ZiPP5Jehec6diA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nDN4GIX1F8Ob8rJfntIJzBUXdUCidFseMnZzWe1UROIM5t3UT7nvTjlmbJjc7OQTS
 93CtTLqvn3ZliBHtch3PXjK4+jGUdQU8ggMQnVAz/W2Kk9JkCYzrvUKIu1XuP6BV66
 MoPPDwSFyzhZTymBdQjenZhBqg9zfEGsh2capCVE6hyjiGU3emFVUWYnAFcT85fa4S
 aX8Xc/oqlUoF1i/EK7/uUtRT8SbbPHnJExYnxaJP4upobPORw4NY21GnaAPmUHpKD2
 eG1oTyZqlQaC5p35ANR9+8vQipvIyIs3h/tpgufOhtaz1MIRL5ctKi2IW1MgbBGU+0
 ZUEXbUHfzDPrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/19] driver core: platform: count references to all
 kinds of firmware nodes
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:18:42 +0000
Message-Id: <20260630091842.BCE2F1F00A3D@smtp.kernel.org>
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
- [High] Memory leak of `of_node` references in platform device release
- [High] Refcount underflow and use-after-free of software nodes on platfor=
m device release
--

commit f2aa250a52f31d368fee3251e58597913170101a
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

driver core: platform: count references to all kinds of firmware nodes
   =20
This patch switches to counting references for all kinds of firmware nodes =
by
replacing the of_node_put with fwnode_handle_put in platform device release.
It also updates platform device setup helpers to properly acquire fwnode
references.

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index f24a5f406746b..bb5f5bddd047d 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -599,7 +599,7 @@ static void platform_device_release(struct device *de=
v)
>  	struct platform_object *pa =3D container_of(dev, struct platform_object,
>  						  pdev.dev);
> =20
> -	of_node_put(pa->pdev.dev.of_node);
> +	fwnode_handle_put(pa->pdev.dev.fwnode);

[Severity: High]
Does replacing of_node_put() here cause a memory leak of of_node references?

Many drivers and core APIs manually acquire an of_node reference and assign
it directly to pdev->dev.of_node without setting pdev->dev.fwnode. For
example, in drivers/base/core.c:device_set_of_node_from_dev():

	of_node_put(dev->of_node);
	dev->of_node =3D of_node_get(dev2->of_node);

When a platform device set up this way is released, fwnode_handle_put() will
operate on a NULL or unrelated fwnode, failing to drop the of_node referenc=
e.

[Severity: High]
Can this fwnode_handle_put() cause a refcount underflow for software nodes?

Platform drivers often inherit their parent's fwnode without taking an
additional reference. For example, in drivers/gpio/gpio-arizona.c:

	device_set_node(&pdev->dev, dev_fwnode(pdev->dev.parent));

Before this patch, calling of_node_put(dev->of_node) on a software node was
a safe no-op (as of_node was NULL). Unconditionally calling
fwnode_handle_put() here will now invoke software_node_put() and decrement
the unacquired reference, potentially leading to a use-after-free when the
device is unregistered.

>  	kfree(pa->pdev.dev.platform_data);
>  	kfree(pa->pdev.mfd_cell);
>  	kfree(pa->pdev.resource);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-pdev-fwnod=
e-ref-v2-0-8abe2513f96e@oss.qualcomm.com?part=3D19
