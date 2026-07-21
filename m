Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7158C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B8110E16F;
	Tue, 21 Jul 2026 15:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hgr1fzpD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FB410E16F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:52:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6629600FC;
 Tue, 21 Jul 2026 15:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6971F000E9;
 Tue, 21 Jul 2026 15:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784649157;
 bh=h6uylTyQbcKSlWJQLFHty6e3odjgJ89cgxQqIrfbTmM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hgr1fzpDOj5uXf2g0ISXT3WT+ThDQUeLVA4IBGzk+PBtBp7lm1S+/n3cdEQfrZaFy
 2O1QvYuxrp2czEgXMVbdlOMZPblrBmWqC/uK2+3WaVfEKRkU9RLg/MmZTjrObkuOO6
 Uk/3an8JQrAEr9GGYrHBpFZmTJEcxp5gS1sYHY8eY1Im7I0zzQ9IeWoPJEkzRy4u2A
 +wADBI2hR+rm9Sxd8ZVs7Hoy5kWPNESMNkUQSFj1L9g3WYxCHROqUEJoM5wqCnBCYK
 ayaaAYcAe/M7LlYASBdlb0ycQr1B+5qHeH51eFUbyVXMR+W9GGaIBauXLRdB/PPw2K
 Da3vXZq5NtFLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vc4: hvs/v3d: Fix null dereference in unbind
To: "Gregor Herburger" <gregor.herburger@linutronix.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721-rpi-vc4-fix-v2-1-b813dcd01dc7@linutronix.de>
References: <20260721-rpi-vc4-fix-v2-1-b813dcd01dc7@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 15:52:36 +0000
Message-Id: <20260721155237.3D6971F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Using `devm_request_irq` and `devm_clk_get` tied to the component =
device in `.bind` callbacks causes Use-After-Free and probe failures upon d=
river unbind/rebind.
- [High] vc4_v3d_unbind accesses V3D hardware registers without ensuring th=
e device is runtime-resumed, which can cause a bus fault.
--

--- Patch [1]: [PATCH v2] drm/vc4: hvs/v3d: Fix null dereference in unbind =
---
commit cc969bb21d635b7be43b137c578d450d8b1564f4
Author: Gregor Herburger <gregor.herburger@linutronix.de>
drm/vc4: hvs/v3d: Fix null dereference in unbind

The hvs and v3d drivers use dev_get_drvdata(master) in their unbind
functions, which can fail with a null dereference error because vc4-drm
gets removed before its dependent drivers. This commit uses the passed
data pointer directly instead to avoid using potentially freed memory.

Link: https://patch.msgid.link/20260720-rpi-vc4-fix-v1-1-6073a96a5773@linut=
ronix.de

> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c

[ ... ]

> @@ -1752,7 +1752,7 @@ static int vc4_hvs_bind(struct device *dev, struct =
device *master, void *data)
>  static void vc4_hvs_unbind(struct device *dev, struct device *master,
>  			   void *data)
>  {
> -	struct drm_device *drm =3D dev_get_drvdata(master);
> +	struct drm_device *drm =3D data;

[Severity: High]
This is a pre-existing issue, but since we are fixing unbind crashes here,
does the use of devm_request_irq() in the bind callbacks leave us exposed
to another use-after-free?

For example, in vc4_hvs_bind():

ret =3D devm_request_irq(dev, platform_get_irq(pdev, 0),
                       vc4_hvs_irq_handler, 0, "vc4 hvs", drm);

Because the IRQ is tied to the component device (dev) rather than the
master, the IRQ remains active after vc4_hvs_unbind() returns. If the master
drm structures are torn down and an interrupt fires before the component
device is completely destroyed, will the handler dereference freed memory?

Also, on a driver rebind, does devm_request_irq() fail with -EBUSY because
the old handler hasn't been detached yet?

>  	struct vc4_dev *vc4 =3D to_vc4_dev(drm);
>  	struct vc4_hvs *hvs =3D vc4->hvs;

[ ... ]

> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c

[ ... ]

> @@ -494,7 +494,7 @@ static int vc4_v3d_bind(struct device *dev, struct de=
vice *master, void *data)
>  static void vc4_v3d_unbind(struct device *dev, struct device *master,
>  			   void *data)
>  {
> -	struct drm_device *drm =3D dev_get_drvdata(master);
> +	struct drm_device *drm =3D data;
>  	struct vc4_dev *vc4 =3D to_vc4_dev(drm);
> =20
>  	vc4_irq_uninstall(drm);

[Severity: High]
This is a pre-existing issue, but can accessing hardware registers here cau=
se
a bus fault if the device is in a runtime suspended state?

The vc4_v3d_unbind() function unconditionally calls vc4_irq_uninstall(drm)
(which accesses V3D_INTDIS) and later writes directly to V3D_BPOA and
V3D_BPOS.

If the V3D component clocks were already disabled by autosuspend, is a
pm_runtime_get_sync(dev) needed before writing to these hardware registers?

>=20
> 	/* Disable the binner's overflow memory address, so the next
> 	 * driver probe (if any) doesn't try to reuse our old
> 	 * allocation.
> 	 */
> 	V3D_WRITE(V3D_BPOA, 0);
> 	V3D_WRITE(V3D_BPOS, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-rpi-vc4-fi=
x-v2-1-b813dcd01dc7@linutronix.de?part=3D1
