Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F050C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33F010ED09;
	Tue,  7 Jul 2026 13:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DLs9hdDj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067C710ECF6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:25:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E1D7C43ABE;
 Tue,  7 Jul 2026 13:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490C81F00A3A;
 Tue,  7 Jul 2026 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430703;
 bh=8CgFZtrANpRpt4Jd3bJXQGOf7CaxfB7C0Ruwg1W6Alc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DLs9hdDjgaAnDehs/CKWxjwBa6kbGIevGE8N08XcnjSmETKgC4XwsFf35po4gdxG6
 nXfsEVfwbkUInpOlc5+CI6z5PvvIgN3vdHyDPR22zWeIY33GFO+olmU0pAjhm0ufpf
 rkQsqvgbvdTe2inIS0ZLApSKTO5A8T/3o9cP2TvHK228i96Rh0n39C0RhxxE/vUosa
 5D9L9dtbIeuphv8EknwE2PaPY5uIbmhwb+bQrtujlpmdrHrvH8KFc9oJz+jCuoKPXY
 OjVOcYg27qkUmEeRFvIkVMs1aaR2wMMvEEtUMQwWs5dwYLi7tWbB6DX+pkF/aQESDy
 NP/y/680hpDaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/20] drm/xe/i2c: use platform_device_set_fwnode()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: robh@kernel.org, lee@kernel.org, imx@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-15-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-15-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:25:02 +0000
Message-Id: <20260707132503.490C81F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing cancel_work_sync() in the xe_i2c teardown path leads to a =
Use-After-Free of the device structure.
--

commit 1fdde54b64291aceacb95c2a267bee6b6609b500
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

drm/xe/i2c: use platform_device_set_fwnode()

This commit encapsulates the assignment of the firmware node for dynamically
allocated platform devices with the provided helper ahead of reworking the
reference counting logic.

> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 706783863d07d..af4ebd93ad8e6 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
[ ... ]
> @@ -123,7 +123,7 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	}
> =20
>  	pdev->dev.parent =3D i2c->drm_dev;
> -	pdev->dev.fwnode =3D fwnode;
> +	platform_device_set_fwnode(pdev, fwnode);
>  	i2c->adapter_node =3D fwnode;
>  	i2c->pdev =3D pdev;

[Severity: High]
This is a pre-existing issue, but does the teardown path for this adapter
need a cancel_work_sync() call?

The I2C adapter registration during xe_i2c_probe() triggers a
BUS_NOTIFY_ADD_DEVICE notification, which schedules i2c->work. If the device
is unbound before this background work completes, xe_i2c_remove() is called:

static void xe_i2c_remove(void *data)
{
    struct xe_i2c *i2c =3D data;
    unsigned int i;

    for (i =3D 0; i < XE_I2C_MAX_CLIENTS; i++)
        i2c_unregister_device(i2c->client[i]);

    bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
    xe_i2c_unregister_adapter(i2c);
    xe_i2c_remove_irq(i2c);
}

Since xe_i2c_remove() unregisters the notifier and adapter but fails to call
cancel_work_sync(&i2c->work), could the scheduled work execute after the
struct xe_i2c memory is freed?=20

This appears to leave a window for a use-after-free when unbinding the driv=
er,
as the delayed work might dereference the freed i2c pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D15
