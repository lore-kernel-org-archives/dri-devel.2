Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AC5C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4F510ECF6;
	Tue,  7 Jul 2026 13:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ezdrps5t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5547710ECF8
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDA7460018;
 Tue,  7 Jul 2026 13:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B361F000E9;
 Tue,  7 Jul 2026 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430709;
 bh=sRTsZByg3jigN6FqrDwzd3A6GFnHFsVi5eGWHjMDrJ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ezdrps5t0qJIGAcRzSumhAkuU01eJSeJuBJnO4UghsHoqNwV4KISXfbgRVxsM9ITL
 QwOkB4lhFC+zaQWP8qUkoTYwwMMMpJ2C5uIduHqPguFElwcgWiN1M8m5GeGkjb+2Mp
 br//pVzcdQ2bMSsdavvV1d/Z+XAte0bKrWdO7wLyM16J+DTO/fj/Qjlo8BaDVDc84u
 aWdUizfEf5y7+UmZMx4a0/Kp4H6TX7tXMpdz8kJs4u/RzBVDGZhjS0aXp5/8GyAgEh
 WLn/kv5QuTmlj4AiIZyiNL9qKcr+l4Y65wlGh/fo9wEEO9YZPxEQY0Z/oIejkhIp70
 n8gB8cBHM+KJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/20] driver core: platform: count references to all
 kinds of firmware nodes
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, lee@kernel.org,
 Frank.Li@kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-20-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-20-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:25:08 +0000
Message-Id: <20260707132509.06B361F000E9@smtp.kernel.org>
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
- [High] OF node reference leak for dynamically allocated platform devices =
due to incomplete tree-wide conversion.
--

commit 50bc78e1d223d4a9addf4cc0c3c1d384a104d5a6
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

driver core: platform: count references to all kinds of firmware nodes

When using platform_device_register_full(), we currently only increase
the reference count of the OF node associated with a platform device. We
symmetrically decrease it in platform_device_release(). With all users in
tree now converted to using provided platform device helpers for
assigning OF and firmware nodes, we can now switch to counting references
of all kinds of firmware nodes.

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 9357942d0c79b..a71015f1d9153 100644
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
Does this code leak the device_node for drivers that haven't been fully
converted to the platform device helpers?

The commit message mentions that all in-tree users are converted, but there
appear to be some unconverted drivers still using device_set_of_node_from_d=
ev
on dynamically allocated platform devices.

For example, in drivers/usb/host/fsl-mph-dr-of.c:fsl_usb2_device_register():
	device_set_of_node_from_dev(&pdev->dev, &ofdev->dev);

And in drivers/usb/musb/musb_dsps.c:dsps_create_musb_pdev():
	device_set_of_node_from_dev(&musb->dev, &parent->dev);

Since device_set_of_node_from_dev() sets and increments dev->of_node without
setting dev->fwnode, won't fwnode_handle_put(NULL) do nothing and permanent=
ly
leak the OF node reference when these devices are released?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D20
