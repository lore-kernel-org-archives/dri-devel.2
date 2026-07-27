Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7A8C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32CFE10E4C2;
	Mon, 27 Jul 2026 17:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MXHyvbpH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3BD10E4C2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:44:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A84760A60;
 Mon, 27 Jul 2026 17:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8821F000E9;
 Mon, 27 Jul 2026 17:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785174285;
 bh=lR2Tkw/Zr2PpAkkAt2FF9b3mhgVQI819vfdOawUy2nk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MXHyvbpH+ygeRsQbL0WlmdMwey6YAC9io81cvMmbZvR6mgjBvboAasJaD58SnUX1K
 7w0XcLsoXQkUcwtCNjE5uZEnxqucyIcpgsipb86ICF1w70lPEui22Cg1HNezomWSxf
 UHBa01sXGkiA9sYYGQPRKb1ylJNPDrnZ3HIr3de61WNUUccVFgXTg5Y1rExf62seyA
 aiZKH/8cWLj8jZlC8cMg0NoAOCSxGNuiEs21/Qr39+hfCHm4950jOOx+VoQxL28E9n
 BajA1cH5Ks/lXvDkOyoej31gFVPhK9p/ZMHO1uyr3PiWL+hNRY7vlfxW0+Yevt/m7M
 yE7bcy4hBTCmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
To: "Youssef Samir" <youssef.abdulrahman@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727173326.2219191-3-youssef.abdulrahman@oss.qualcomm.com>
References: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
 <20260727173326.2219191-3-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:44:45 +0000
Message-Id: <20260727174445.BB8821F000E9@smtp.kernel.org>
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
- [High] Missing teardown of registered drivers (Sahara, RAS, Timesync) whe=
n module initialization fails in qaic_init().
- [High] The return value of init_srcu_struct() is ignored, which can cause=
 a kernel panic if the per-CPU memory allocation fails.
--

--- Patch [2]: [PATCH 2/5] accel/qaic: Add <linux/device-id/mhi.h> to qaic_=
drv.c ---
commit 659a1f299787dffbb6e5f80693c0d8c629fc6ab4
Author: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
   =20
qaic_drv.c uses mhi_device_id implicitly. Include <linux/device-id/mhi.h>.

> diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
> index 0acf6cdd44f81..c1bb6db78d129 100644
> --- a/drivers/accel/qaic/qaic_drv.c
> +++ b/drivers/accel/qaic/qaic_drv.c
> @@ -4,6 +4,7 @@
>  /* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
> =20
>  #include <linux/delay.h>
> +#include <linux/device-id/mhi.h>

[Severity: High]
This is a pre-existing issue, but does qaic_init() leave dangling reference=
s if
module initialization fails?

If qaic_ssr_register() fails, the code jumps to the free_bootlog label:

drivers/accel/qaic/qaic_drv.c:qaic_init() {
	...
free_bootlog:
	qaic_bootlog_unregister();
free_mhi:
	mhi_driver_unregister(&qaic_mhi_driver);
free_pci:
	pci_unregister_driver(&qaic_pci_driver);
	return ret;
}

This error path unregisters the bootlog, MHI driver, and PCI driver, but sk=
ips
unregistering the sahara, ras, and timesync components that were initialized
earlier.

Could the MHI core eventually access this freed memory, leading to a
use-after-free panic?

[Severity: High]
This is a pre-existing issue, but can the ignored return value of
init_srcu_struct() in qaic_open() lead to a panic?

drivers/accel/qaic/qaic_drv.c:qaic_open() {
	...
	init_srcu_struct(&usr->qddev_lock);
	...
}

If it fails to allocate required internal structures (returning e.g. -ENOME=
M),
the srcu_sup pointer in usr->qddev_lock is left as NULL. If the subsequent
mutex_lock_interruptible() fails, the code jumps to cleanup_usr and calls:

drivers/accel/qaic/qaic_drv.c:qaic_open() {
	...
	cleanup_srcu_struct(&usr->qddev_lock);
	...
}

Will cleanup_srcu_struct() blindly dereference the NULL srcu_sup pointer,
causing a crash?

>  #include <linux/dma-mapping.h>
>  #include <linux/idr.h>
>  #include <linux/interrupt.h>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727173326.2219=
191-1-youssef.abdulrahman@oss.qualcomm.com?part=3D2
