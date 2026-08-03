Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3A8C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E622710E6BE;
	Mon,  3 Aug 2026 15:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TwGOhACZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E7410E6BE
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:21:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D6F6060A96;
 Mon,  3 Aug 2026 15:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC281F000E9;
 Mon,  3 Aug 2026 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785770472;
 bh=Xvl31MolNI8xOkeDAFqr5urTIKaSbtGXHZ3ao35EM0I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TwGOhACZVyEpvz9cUzaArny/ZwcJJR06bZJpJmQ3Y1IYqtkFYt8mwZ3pFJYgYfQxi
 xc10NUryXdbhD2n1FoXQdMk78gdhD0cK1SRqWI0E5hbXbMGqc/ThcW4BnHpt5E/Djz
 FI3EHHi4xYe0gKMprZkRsTecN+w2dSze0Y2tYK5LTJ0lCWiL3hVd8RmHjbNSQsC4fq
 UdGksQQPLyP6Idxnq98jhDS04pLHXee5Vj12zCsD1pUtoFAdQl7Ju8LtGV/bOJ1cyr
 QbfWixk0rMYpm+i0ujUT+FAjl0AaUrF8rzSMSaHzTU+EKeXW/Zr+oGeugv2kQ0xsw9
 ycVY9elvFeE6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260803-ti-sn65dsi83-fixes-v3-2-9b403a405ccd@geanix.com>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <20260803-ti-sn65dsi83-fixes-v3-2-9b403a405ccd@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:21:11 +0000
Message-Id: <20260803152112.5CC281F000E9@smtp.kernel.org>
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
- [Critical] Missing cancel_work_sync() for ctx->reset_work during driver t=
eardown leads to a Use-After-Free.
- [High] Skipping enable_irq() on the error path causes an IRQ disable dept=
h leak, leaving the interrupt permanently disabled.
--

--- Patch [2]: [PATCH v3 2/3] drm/bridge: ti-sn65dsi83: Fix error handling =
in sn65dsi83_reset_work() ---
commit 58246b5ef131d7aeea7b5c2b693088e7255aa435
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()

This commit fixes the error path in sn65dsi83_reset_work() by adding a
goto to ensure drm_bridge_exit() is called when sn65dsi83_reset_pipe()
fails, safely closing the critical section.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -419,11 +419,12 @@ static void sn65dsi83_reset_work(struct work_struct=
 *ws)

[Severity: Critical]
This is a pre-existing issue, but could this work function execute after
the device is unbound, resulting in a use-after-free?

If the driver is removed and devres frees the ctx structure, the work
could still be pending since sn65dsi83_remove() does not appear to call
cancel_work_sync() before returning:

sn65dsi83_remove() {
        ...
        drm_bridge_unplug(&ctx->bridge);
        // missing cancel_work_sync(&ctx->reset_work);
}

If the workqueue executes sn65dsi83_reset_work() after teardown,
dereferencing ctx for drm_bridge_enter() might access freed memory.

>  	ret =3D sn65dsi83_reset_pipe(ctx);
>  	if (ret) {
>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
> -		return;
> +		goto err_exit;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't jumping to err_exit
here leave the interrupt permanently disabled?

If a hardware error triggers the IRQ handler, sn65dsi83_handle_errors()
calls disable_irq_nosync(), which increments the IRQ disable depth. By
skipping the enable_irq() call on this error path, the depth counter
remains unbalanced.

Would it be better to mask the interrupt source via hardware registers
on failure, and still call enable_irq() so the kernel's depth counter
remains balanced?

>  	}
>  	if (ctx->irq)
>  		enable_irq(ctx->irq);
> =20
> +err_exit:
>  	drm_bridge_exit(idx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-ti-sn65dsi=
83-fixes-v3-0-9b403a405ccd@geanix.com?part=3D2
