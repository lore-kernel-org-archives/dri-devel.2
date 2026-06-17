Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6712CCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C406D10EEA1;
	Wed, 17 Jun 2026 08:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="keYoykJI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18A3B10EEA1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:11:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 392C7600AB;
 Wed, 17 Jun 2026 08:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CD41F000E9;
 Wed, 17 Jun 2026 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781683891;
 bh=DGyTkWofSz/FPfY2ZGkAAhsr14BRhfEZM+zZ+Pxo9xM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=keYoykJId3a1bOCp5KcblSpX1qdL8vt1e5z02K120PuU6Vl/Chw1yM1WZBIyV8PPb
 wIyTeY2q8qz6vnvX3T6RnEadxsDYWHNwpjWrjzCdEvOdgCMvz5Wgietpd/cgYySr0e
 vxQtPO8Fskc1zCmJ9HTxOp8dT3juV2gHVMkHKrSORl7IWM2BBPVoiLQ2jo/Bn/bLvc
 66T4OeRj48fmUTavmbr7XYTHrZrJR/U/GHB+Citm7B3BU6ZRNt8UUsQx9ddOSdKFoA
 CtwpkBfpEGZO/087W2qOvtm1mDTIsEtXzCP1k2AZyZ17Tjq+E3SBTYkwRSd/Nwr3al
 +fcfmW5+rop9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/14] mfd: lm3533: Use dev_groups in struct
 device_driver
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260617080031.99156-8-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-8-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 08:11:31 +0000
Message-Id: <20260617081131.A0CD41F000E9@smtp.kernel.org>
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
- [High] Unintentional user-space ABI breakage by moving custom sysfs attri=
butes from the backlight class device to the platform device.
--

commit b4eaddced56809e9f87ffe143724f151f0e7013e
Author: Svyatoslav Ryhel <clamor95@gmail.com>

mfd: lm3533: Use dev_groups in struct device_driver

Instead of creating and removing the device sysfs attributes directly
during probe and remove of the driver, respectively, use dev_groups in
struct device_driver to point to the attribute definitions and let the
core take care of creating and removing them.

No intentional functional impact.

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
> index 4d6f680334802..9ef171d3aaeab 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
[ ... ]
> @@ -304,28 +309,17 @@ static int lm3533_bl_probe(struct platform_device *=
pdev)
> =20
>  	platform_set_drvdata(pdev, bl);
> =20
> -	ret =3D sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
> -		return ret;
> -	}
> -
>  	backlight_update_status(bd);
[ ... ]
> @@ -377,6 +370,7 @@ static struct platform_driver lm3533_bl_driver =3D {
>  	.driver =3D {
>  		.name	=3D "lm3533-backlight",
>  		.pm	=3D &lm3533_bl_pm_ops,
> +		.dev_groups =3D lm3533_bl_attribute_groups,

[Severity: High]
Does moving these attributes to the platform driver break the userspace ABI?

The old code explicitly created custom sysfs attributes on the backlight
device's kobject (&bd->dev.kobj), placing them in the backlight class
directory, for example under /sys/class/backlight/<name>/.

By attaching the attribute groups to the platform driver via .dev_groups, t=
he
driver core will now create these attributes on the parent platform device
instead.

Since the commit message states there is no intentional functional impact,
could this path change accidentally break userspace tools or udev rules
that expect to find these custom attributes inside the backlight class
directory?

>  	},
>  	.probe		=3D lm3533_bl_probe,
>  	.remove		=3D lm3533_bl_remove,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617080031.9915=
6-1-clamor95@gmail.com?part=3D7
