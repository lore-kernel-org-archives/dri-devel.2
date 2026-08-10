Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA56C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE27B10E18B;
	Mon, 10 Aug 2026 07:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OsRzgBRH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E925C10E18B
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:29:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0B7C42E2A;
 Mon, 10 Aug 2026 07:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A391F000E9;
 Mon, 10 Aug 2026 07:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786346995;
 bh=KaOEqGGQvnEIyJ4KASCLDmu7+xitlf30L6MDYtGk6DY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OsRzgBRHLSa8M7BINsndjJ2wrQHIN0s3UTTv9ly7+Jsyp4jy6erolvqpzHF7IqZfE
 es9o1zlU/QDK3MX25YR0UkuR+JagAAYuNU0KSeaFJdMFqCn7cDdeniBWYYtm92u0rk
 PyiZugfuHyxCkStxhXZLA9S+SK2BvAnopOxz0Zh/QKXJAlnbbO7RaTk815aurhAiGG
 zuWSMa1twQ6EcSw4DkyK0INe0n9P+ZuETdOrID2cYe/KjmNfJyutLtPU1JkoYYdAWH
 8xxfS7mgjFqztQZxsKWGnHaIauDa+5JNozjD4Dk8P0OHw/i+hyNA62jht8qN2+e22P
 kP4EAfbVlujVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
 <20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 07:29:54 +0000
Message-Id: <20260810072955.72A391F000E9@smtp.kernel.org>
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

New issues:
- [High] Unconditionally re-enabling the interrupt after a failed hardware =
reset introduces a severe interrupt and workqueue storm.

Pre-existing issues:
- [Critical] Missing workqueue cancellation in the driver remove path leads=
 to a Use-After-Free of the driver context.
--

--- Patch [1]: [PATCH v4 1/3] drm/bridge: ti-sn65dsi83: Fix error handling =
in sn65dsi83_reset_work() ---
commit 9e0c74443fddb87d6c513a0e21cb5c153b2b2c3a
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()

This commit changes the error handling in sn65dsi83_reset_work() so that
enable_irq() and drm_bridge_exit() are called even if sn65dsi83_reset_pipe()
fails.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index 42b451432bbb6..0ccfff401b2a6 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -417,10 +417,9 @@ static void sn65dsi83_reset_work(struct work_struct =
*ws)
> =20
>  	/* Reset the pipe */
>  	ret =3D sn65dsi83_reset_pipe(ctx);
> -	if (ret) {
> +	if (ret)
>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
> -		return;
> -	}
> +
>  	if (ctx->irq)
>  		enable_irq(ctx->irq);

[Severity: High]
Does unconditionally re-enabling the interrupt after a failed hardware reset
introduce an interrupt and workqueue storm regression?

If sn65dsi83_reset_pipe() fails, the hardware IRQ status register
(REG_IRQ_STAT) remains uncleared because the reset sequence did not
successfully reach sn65dsi83_atomic_enable().

Since enable_irq(ctx->irq) is now called in sn65dsi83_reset_work() even on
failure, will the hardware immediately trigger the interrupt again? This wo=
uld
cause the interrupt handler to run, disable the IRQ, and schedule reset_wor=
k.
The work runs, fails again, and re-enables the IRQ, creating an infinite lo=
op
that could lock up a CPU core.

[Severity: Critical]
This is a pre-existing issue, but does the driver missing workqueue
cancellation in the remove path lead to a use-after-free of the driver cont=
ext?

The driver context ctx is dynamically allocated via devm_drm_bridge_alloc()=
 and
is automatically freed by devres after sn65dsi83_remove() returns:

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_remove() {
	struct sn65dsi83 *ctx =3D i2c_get_clientdata(client);

	drm_bridge_unplug(&ctx->bridge);
}

The teardown path never calls cancel_work_sync(&ctx->reset_work). If an
interrupt schedules the work just before removal, and it hasn't completed w=
hen
remove() returns, the scheduled work will run after devres frees ctx.

The work function sn65dsi83_reset_work() then dereferences the freed ctx:

drivers/gpu/drm/bridge/ti-sn65dsi83.c:sn65dsi83_reset_work() {
	struct sn65dsi83 *ctx =3D container_of(ws, struct sn65dsi83, reset_work);
	...
	if (!drm_bridge_enter(&ctx->bridge, &idx))
		return;
	...
}

Should cancel_work_sync() be added to sn65dsi83_remove() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-ti-sn65dsi=
83-fixes-v4-0-ae9c95c8d162@geanix.com?part=3D1
