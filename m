Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF4CC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB65F10ED0A;
	Tue,  7 Jul 2026 13:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f0qNtlev";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D2510ECFB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C15C643E7D;
 Tue,  7 Jul 2026 13:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEAD1F000E9;
 Tue,  7 Jul 2026 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430700;
 bh=YR7OVTOka+yAGIFejWErZW21aVeNFMmNHnyc0lNA9gM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f0qNtlevUwAYzZhgdYvX3EbEt+Hzwb42I4TktDLWhSA9egp8hdj0N/q1JMzYo8Edv
 zpvDzI4Q940ukozD7I4KJYtBCX7KIwauWZZT4b8sUtMqc0v45p/YZJvNf4p75wbMpy
 32MVSX0i90QZgah72/D4KfTwQ+07AZ5gac94JFgjBqeqUws1/Q7cgUDwBhFDWdexpv
 lHSvZlwnuaiuKCGcjVM1xOeGWEYwOPnwT/PSeSNaZRFuIX0VxPUgK4ZNI/S5QO4wX8
 HX7Gk04ScB7ZfPGKTloWKCa4PZ9l33OTvrxzgslizbVo7rmQumiA7VLDPzZifqnfVa
 k9A8cKm8k6akA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/20] mfd: tps6586: use platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, imx@lists.linux.dev,
 lee@kernel.org, robh@kernel.org, mfd@lists.linux.dev, Frank.Li@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-12-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-12-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:59 +0000
Message-Id: <20260707132459.6CEAD1F000E9@smtp.kernel.org>
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
- [High] Subdevice cleanup unconditionally unregisters all children, premat=
urely removing MFD cell devices and bypassing `mfd_remove_devices_fn()`.
- [Medium] Manual assignment of `pdev->dev.platform_data` leads to invalid =
`kfree()`.
- [Medium] Missing IRQ domain and IRQ descriptors cleanup on teardown and e=
rror paths.
--

commit 0df04ec4b22ac2adb3b77bf67e6a1339f5fd4523
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
mfd: tps6586: use platform_device_set_of_node()

This commit encapsulates the assignment of the OF node for dynamically
allocated platform devices by using the platform_device_set_of_node() helpe=
r.
This change prepares for reworking the reference counting logic for platform
devices.

> diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
> index f5f8054466033..3cfd2f02b62f3 100644
> --- a/drivers/mfd/tps6586x.c
> +++ b/drivers/mfd/tps6586x.c
> @@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6=
586x,
> =20
>  		pdev->dev.parent =3D tps6586x->dev;
>  		pdev->dev.platform_data =3D subdev->platform_data;

[Severity: Medium]
This is a pre-existing issue, but does this manual assignment of
platform_data at line 399 in tps6586x_add_subdevs() cause problems during
device release?

When the platform device is unregistered, platform_device_release()
unconditionally calls kfree(pdev->dev.platform_data).

If subdev->platform_data was statically allocated or part of devm_kzalloc
memory, could this corrupt the heap?

> -		pdev->dev.of_node =3D of_node_get(subdev->of_node);
> +		platform_device_set_of_node(pdev, subdev->of_node);
> =20
>  		ret =3D platform_device_add(pdev);
>  		if (ret) {

[Severity: High]
This isn't a bug introduced by this patch, but does the cleanup in
tps6586x_remove_subdevs() interfere with MFD core cleanup?

drivers/mfd/tps6586x.c:tps6586x_remove_subdevs() {
    ...
    return device_for_each_child(tps6586x->dev, NULL, __remove_subdev);
}

drivers/mfd/tps6586x.c:__remove_subdev() {
    ...
    platform_device_unregister(to_platform_device(dev));
}

Since MFD cells added by mfd_add_devices() are children of tps6586x->dev,
this unconditional unregistering of all children appears to bypass
mfd_remove_devices_fn().

Could blindly casting dev to struct platform_device also be unsafe if any
child is not a platform device?

[Severity: Medium]
This is a pre-existing issue, but does the driver leak IRQ descriptors and
the IRQ domain during removal or on error paths?

In the removal path, tps6586x_i2c_remove() in drivers/mfd/tps6586x.c cleans
up other resources but misses IRQ cleanup:

drivers/mfd/tps6586x.c:tps6586x_i2c_remove() {
    struct tps6586x *tps6586x =3D i2c_get_clientdata(client);

    tps6586x_remove_subdevs(tps6586x);
    mfd_remove_devices(tps6586x->dev);
}

Additionally, if irq_domain_create_simple() or request_threaded_irq() fail
in tps6586x_irq_init():

drivers/mfd/tps6586x.c:tps6586x_irq_init() {
    ...
    if (!tps6586x->irq_domain) {
        dev_err(tps6586x->dev, "Failed to create IRQ domain\n");
        return -ENOMEM;
    }
    ...
}

The error paths exit without freeing the previously allocated descriptors or
domain. Can this cause resource leakage on cold paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D12
