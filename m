Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50011C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD6710E388;
	Mon, 21 Sep 2026 08:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R7k2nXUE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0957610E388
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:41:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A7BF740ADB;
 Mon, 21 Sep 2026 08:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2791F000FF;
 Mon, 21 Sep 2026 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789980080;
 bh=3ZOvnJ8NMzdZmtMqOLxv0VP4oz5gIkCcjCWnawECxsw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R7k2nXUEPknTkMNfvUVQE5PcRUTVbM4NvHhF1z3nzjB7xi0WBoDPu9g0FF0PTkN61
 rcxRHYqjVDJU/nPez0Qk3zyMn9y6qgY5UaVmAOT7Fjxza4XlsJQ4WwKz5/cFZNE7PA
 N34/GCSs4pkPBGmP9H3nYyY/VbrodriIjOyX5xkZGDQa4kl4HJRdklAzhPbZU1t/Wg
 cOUb0wSzAREiWKafAa5AFAeChp3CNGVjHmGjz4dSTA9u0miG1V8FiGZtiTZTxMKM58
 xq17xVka7sJM//Jkc+w0dN7pvGnrAGKG7S/z/XXqt/fL4h7wnt7XO0OE0+wAzZbDs4
 1gkZ0mVsZkr+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] gpu: host1x: fix runtime PM reference leak on remove
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921082206.234421-1-lgs201920130244@gmail.com>
References: <20260921082206.234421-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:41:19 +0000
Message-Id: <20260921084120.5F2791F000FF@smtp.kernel.org>
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
- [High] pm: host1x leaves hardware active and leaks resources on driver re=
move
--

commit 91e37111242ff2cea238fc242091a8f04f7f935f
Author: Guangshuo Li <lgs201920130244@gmail.com>
gpu: host1x: fix runtime PM reference leak on remove

This commit attempts to fix a runtime PM reference leak in host1x_remove() =
by
replacing pm_runtime_force_suspend() with pm_runtime_put_sync_suspend() and
pm_runtime_disable(). It drops the usage reference acquired in the probe
path before disabling runtime PM.

> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index 7b1d091f3c090..df483ef6419d0 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -677,7 +677,8 @@ static void host1x_remove(struct platform_device *pde=
v)
>  	host1x_unregister(host);
>  	host1x_debug_deinit(host);
> =20
> -	pm_runtime_force_suspend(&pdev->dev);
> +	pm_runtime_put_sync_suspend(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);

[Severity: High]
Will this conditional suspend leave the hardware active while the driver is
torn down?

Unlike pm_runtime_force_suspend(), pm_runtime_put_sync_suspend() can silent=
ly
abort if the PM usage counter is greater than zero or if child devices are
still active. This might happen if userspace sets the device's power control
to "on", or if child devices populated by devm_of_platform_populate() are
still active, since devres cleans up children after host1x_remove() finishe=
s.

If the suspend aborts, the device remains active with clocks enabled, reset
lines unasserted, and hardware interrupts enabled. Since host1x_remove()
continues and subsequently calls host1x_intr_deinit() and host1x_iommu_exit=
(),
could any active hardware DMA or interrupts result in IOMMU faults, memory
corruption, or an unhandled IRQ storm?

To ensure the hardware is forcefully quiesced while still fixing the usage
counter leak, should this instead drop the reference without triggering a
conditional idle, and then force the suspend? For example:

pm_runtime_put_noidle(&pdev->dev);
pm_runtime_force_suspend(&pdev->dev);

> =20
>  	host1x_intr_deinit(host);
>  	host1x_syncpt_deinit(host);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921082206.2344=
21-1-lgs201920130244@gmail.com?part=3D1
