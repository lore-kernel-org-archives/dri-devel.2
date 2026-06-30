Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59860C43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF1510EBC6;
	Tue, 30 Jun 2026 09:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P4iBgxtQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F1F10E1C2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:18:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91A5343CBF;
 Tue, 30 Jun 2026 09:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106FB1F000E9;
 Tue, 30 Jun 2026 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782811119;
 bh=4xdsDrROvnoB1hsweI9GIEXn8OFofnQBlAQ/qK9EJtU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P4iBgxtQIyk70pcwtTQD3yrgV4F74UF+KdjS3RqmemklapAx3vqgbSUy49EwNnDaN
 DRdttMszWatJrqnkaM1Ob/en8suuLR2nVMbuT1g4sTwghtyzAMr1oAdeSnWBiSP+gQ
 hjgyzAMS2EKs19znQAKbA0owk2trZtgjgTtZnv3+hjo3fY4kEUIdA+PgxOZb4tzPEt
 rfk0N+7Umn/sH+j6c3OX6xaeMl2FkjNflnrMcdPfGxjmW2KIOEmZCZOG7NmkOk+8k8
 /BLA/c8k2BRl7XGkZXB/IskONcDkNCa6iA26gPUGCOurvaDGwhG8dzWBG5wOXbKoWU
 PlU/qGmKuy8dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/19] driver core: platform: provide
 platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:18:37 +0000
Message-Id: <20260630091839.106FB1F000E9@smtp.kernel.org>
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
- [High] Incomplete migration to `platform_device_set_fwnode()` / `platform=
_device_set_of_node()` causes OF node reference and memory leaks for un-mig=
rated callers.
--

commit b1122010b53f4c5f66f9be91e300a372e6dce282
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

driver core: platform: provide platform_device_set_of_node()

This commit encapsulates the reference counting logic for OF nodes assigned
to platform devices into a new helper function. It prepares the driver core
to switch to counting references of the device's firmware nodes rather than
just the OF nodes.

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index fb9120b0bcfe0..3188d5aba5f90 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c

[ ... ]

> @@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device =
*pdev, const void *data,
>  }
>  EXPORT_SYMBOL_GPL(platform_device_add_data);
> =20
> +/**
> + * platform_device_set_of_node - assign an OF node to device
> + * @pdev: platform device to add the node for
> + * @np: new device node
> + *
> + * Assign an OF node to this platform device. Internally keep track of t=
he
> + * reference count. Devices created with platform_device_alloc() must us=
e this
> + * function instead of assigning the node manually.
> + */
> +void platform_device_set_of_node(struct platform_device *pdev,
> +				 struct device_node *np)
> +{
> +	of_node_put(pdev->dev.of_node);
> +	pdev->dev.of_node =3D of_node_get(np);
> +	pdev->dev.fwnode =3D of_fwnode_handle(np);
> +}
> +EXPORT_SYMBOL_GPL(platform_device_set_of_node);

[Severity: High]
Will the transition to this new helper cause OF node reference leaks for
existing drivers that haven't been migrated yet?

For example, looking at max8997_battery_probe() in
drivers/power/supply/max8997_charger.c, the driver currently manually
assigns an acquired OF node without setting fwnode:

drivers/power/supply/max8997_charger.c:max8997_battery_probe() {
    ...
    np =3D of_get_child_by_name(iodev->dev->of_node, "charger");
    ...
    pdev->dev.of_node =3D np;
    ...
}

If the driver core teardown is changed later in this patch series to
only release fwnode in platform_device_release(), won't these
un-migrated callers leak their OF node references when the device is
released?

Are there other drivers that need to be migrated to use
platform_device_set_of_node() before making the core change?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-pdev-fwnod=
e-ref-v2-0-8abe2513f96e@oss.qualcomm.com?part=3D2
