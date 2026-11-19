Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g0LJr9rX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F8F10E250;
	Thu, 19 Nov 2026 23:17:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6810110E250
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:17:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A3114652A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA21F000C6;
 Thu, 19 Nov 2026 23:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795130272;
 bh=c7g8uLcby/zDo7ExrTQ/ZZeJQGBkjxYG9mEdj4/bA6o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g0LJr9rXx0+uHdpJwTP6Hs0hTpNmJJBRBhWWH5lrNpLHn/orbx2O+lVDS3IAH2TSA
 n6ZoLSrLcQeebN0eVBquCgIgxqOosmAbPIfgQQufT60FZtgfZeLGEYNoSTJ4RuaM7d
 l8SMyFrUZwWy/BZEgwi1XQWi75cLSueVaeI4w6nvsIOyXGxM31y9kxVrDpSe0yRLCM
 YLTZyDG1wo0nDqwRCF9L1hBlP5NE6CKiW/eJULY1Dus5ZOgjtO1LeM5ORtcyMJYGy4
 MrnBxJbo8MWHtV6tk9sQt57OoJqlY14/sw84C145Ni9fR0MNueMoJS99AKejkdK3bd
 aGCAGjOHsXf4A==
Message-ID: <sashiko-outbox-224178@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] backlight: aat2870: Initialize properties before
 device registration
To: "Thorsten Blum" <blum@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119230733.790573-6-blum@kernel.org>
References: <20261119230733.790573-4-blum@kernel.org>
 <20261119230733.790573-6-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 23:17:51 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] backlight: aat2870_bl: NULL pointer dereference in
  aat2870_bl_update_status() [1]
--

commit d325449f615b625e1f4a4a3e7a3f53db9a33c1e2
Author: Thorsten Blum <blum@kernel.org>

backlight: aat2870: Initialize properties before device registration

This commit initializes the backlight properties before calling
devm_backlight_device_register() so that max_brightness and initial
brightness are set before the sysfs attributes are exposed to userspace.

> diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlig=
ht/aat2870_bl.c
> index 5af36d3784f11..fa854827e5580 100644
> --- a/drivers/video/backlight/aat2870_bl.c
> +++ b/drivers/video/backlight/aat2870_bl.c
[ ... ]
> @@ -120,9 +124,10 @@ static int aat2870_bl_probe(struct platform_device *=
pdev)
>  		goto out;
>  	}
> =20
> -	memset(&props, 0, sizeof(struct backlight_properties));
> +	if (pdata->max_brightness > 0)
> +		props.max_brightness =3D pdata->max_brightness;
> +	props.brightness =3D props.max_brightness;
> =20
> -	props.type =3D BACKLIGHT_RAW;
>  	bd =3D devm_backlight_device_register(&pdev->dev, "aat2870-backlight",
>  					&pdev->dev, aat2870_bl, &aat2870_bl_ops,
>  					&props);

[Severity: Critical]
This problem wasn't introduced by this patch, but can registering the
backlight device before initializing aat2870_bl->pdev cause a NULL pointer
dereference in aat2870_bl_update_status() [1]?

devm_backlight_device_register() exposes the sysfs interface before
aat2870_bl_probe() populates aat2870_bl->pdev (and aat2870_bl->bd,
channels, and max_current):

drivers/video/backlight/aat2870_bl.c:aat2870_bl_update_status() {
	struct aat2870_bl_driver_data *aat2870_bl =3D bl_get_data(bd);
	struct aat2870_data *aat2870 =3D
			dev_get_drvdata(aat2870_bl->pdev->dev.parent);
    ...
}

If userspace writes to a sysfs attribute such as brightness right after
registration, the backlight core invokes aat2870_bl_update_status() while
aat2870_bl->pdev is still NULL:

CPU0                                CPU1
aat2870_bl_probe()
  devm_backlight_device_register()
                                    brightness_store()
                                      ...
                                        aat2870_bl_update_status()
                                          aat2870_bl->pdev->dev.parent
                                            <-- NULL pointer dereference
  aat2870_bl->pdev =3D pdev;

Initializing the driver data fields in aat2870_bl before calling
devm_backlight_device_register() would avoid this race.

[1] https://sashiko.dev/#/bug/linux-9a61532b-5d7a-467d-b3d1-d6420978c8f3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119230733.7905=
73-4-blum@kernel.org?part=3D3
