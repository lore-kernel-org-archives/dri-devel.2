Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84956C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBA8210EBCD;
	Tue, 30 Jun 2026 09:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CZ+HiLWF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8553010EBB6
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:18:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EA9B43D1E;
 Tue, 30 Jun 2026 09:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E340E1F00A3D;
 Tue, 30 Jun 2026 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782811121;
 bh=3HbL/bxS5NfZBSjM72YgGg9R81gM7YXM63shB1q8IO0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CZ+HiLWFguKIZEf7sUxf0OJBO9Xufj4qK4XGI2WfBZeeAwX/AUR7eGHBZQOzzRjxY
 CoHaJJyvJEWy4/17aMeKYMBU08FNeYJbuxc7zjKZKxi7y7YeTUgrX6XYlQBXYPMyPE
 URoThKT7lMZRu8NRFfmZLK/LaVvlNR0ixY+XASrRLqnL0Jb8e9mmo5DWEWo2lf/O0D
 Cl1ehmAsNrUWMOU9VL21Y8b18/obmKV/StAsQQFQCU9+DCAQUrozk+WK7pEYo4t8D4
 WY7A5UUfyqZCyY9g3mrY2sVkXdwZQ34+/Y8axaeeE8v5Qnhb4CYfp91xIAAYyaS0Uc
 bWkrG6XZWhEPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/19] drm/xe/i2c: use platform_device_set_fwnode()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, imx@lists.linux.dev,
 Frank.Li@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-pdev-fwnode-ref-v2-14-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
 <20260629-pdev-fwnode-ref-v2-14-8abe2513f96e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:18:40 +0000
Message-Id: <20260630091840.E340E1F00A3D@smtp.kernel.org>
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
- [High] Missing cancel_work_sync() in driver teardown and error paths allo=
ws a pending background work to execute after the 'xe_i2c' structure is fre=
ed.
--

commit 1ceae3ee709a0fb69c698acf7a00cab2a5e1829c
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

drm/xe/i2c: use platform_device_set_fwnode()

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

> diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
> index 706783863d07d..af4ebd93ad8e6 100644
> --- a/drivers/gpu/drm/xe/xe_i2c.c
> +++ b/drivers/gpu/drm/xe/xe_i2c.c
> @@ -123,7 +123,7 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
>  	}
> =20
>  	pdev->dev.parent =3D i2c->drm_dev;
> -	pdev->dev.fwnode =3D fwnode;
> +	platform_device_set_fwnode(pdev, fwnode);
>  	i2c->adapter_node =3D fwnode;
>  	i2c->pdev =3D pdev;
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
involving the background work item in this file.

If platform_device_add() (called just below this block) triggers the bus
notifier but ultimately fails, the asynchronously scheduled i2c->work remai=
ns
pending.

When xe_i2c_probe() handles the error by unregistering the notifier and
returning, devres immediately frees the i2c structure. Later, when the work
executes, could it write to i2c->client[0] in freed memory?

The xe_i2c_probe() error path currently does this:

err_unregister_notifier:
	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);

	return ret;

A similar scenario appears to exist in the standard teardown path, as
xe_i2c_remove() does not cancel the pending work:

static void xe_i2c_remove(void *arg)
{
	...
	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
	xe_i2c_unregister_adapter(i2c);
	xe_i2c_remove_irq(i2c);
}

Should cancel_work_sync(&i2c->work) be added to both the probe error path
and the remove function to ensure the work item doesn't execute after the
structure is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-pdev-fwnod=
e-ref-v2-0-8abe2513f96e@oss.qualcomm.com?part=3D14
