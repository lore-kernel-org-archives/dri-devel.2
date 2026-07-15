Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C315C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903B610E1B1;
	Wed, 15 Jul 2026 13:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cdk23ZJx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810B010E1B1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:21:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9D9140216;
 Wed, 15 Jul 2026 13:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D651F000E9;
 Wed, 15 Jul 2026 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784121691;
 bh=m70QW291spcG/qdXLklCYJuTnaSHAGhG84TuVd2HEtg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cdk23ZJxy8GEc4OwYICSLj4OpW4oaM++jzvQGkLWGYY9kVle70tOCr6Ybb3vIu8pC
 GmzUOteO5rromHxnHx0jCyDZFx2K5t/VHt3c7thtyw4OMZaQlzrDcJzZ0BlHuOXgtw
 iNQb/NMUu/g/REEJG2c350Ndz7uFUNutt8eZ+Lv5DUzjwx/Ifgt/KapGV/61qQFTH5
 T1hWp11dXHPDrscy5sgx8CBZW42EApDi9MxegnL+znZUF4AxuUyeKiNiGCVWK1gdPe
 fthPgfN57F9lfLlrv9gClYbJfH3z7cv65b+BcypxrWsjZkOK9srnHxwSygJGcuKjWl
 DkzKNyiqQv1gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
To: "Esben Haabendal" <esben@geanix.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260715-ti-sn65dsi83-fixes-v2-2-ebc4c3fe29b6@geanix.com>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
 <20260715-ti-sn65dsi83-fixes-v2-2-ebc4c3fe29b6@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 13:21:30 +0000
Message-Id: <20260715132131.82D651F000E9@smtp.kernel.org>
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
- [High] The error handling branch patched by this commit is dead code beca=
use sn65dsi83_reset_pipe() unconditionally returns 0.
- [High] Missing cancellation of reset_work on driver removal leads to a po=
tential Use-After-Free.
--

--- Patch [2]: [PATCH v2 2/3] drm/bridge: ti-sn65dsi83: Fix error handling =
in sn65dsi83_reset_work() ---
commit da59dc684f40189c9b3344ad029c137b580d644a
Author: Esben Haabendal <esben@geanix.com>

drm/bridge: ti-sn65dsi83: Fix error handling in sn65dsi83_reset_work()

This commit updates the error handling path in sn65dsi83_reset_work() to
ensure the DRM bridge critical section is cleanly exited when resetting the
pipe fails.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index b4b220eee7909..7e73035d77986 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -419,11 +419,12 @@ static void sn65dsi83_reset_work(struct work_struct=
 *ws)
>  	ret =3D sn65dsi83_reset_pipe(ctx);
>  	if (ret) {
>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
> -		return;
> +		goto err_exit;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but is this error handling block
actually dead code?

Looking at sn65dsi83_reset_pipe(), it appears to unconditionally return 0,
even if drm_bridge_helper_reset_crtc() returns an error like -EINVAL or
-ENOMEM:

static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
{
	...
retry:
	err =3D drm_bridge_helper_reset_crtc(&sn65dsi83->bridge, &ctx);
	if (err =3D=3D -EDEADLK) {
		drm_modeset_backoff(&ctx);
		goto retry;
	}

	drm_modeset_drop_locks(&ctx);
	drm_modeset_acquire_fini(&ctx);

	return 0;
}

Since ret is always 0, this error branch will never execute. If an actual
hardware error persists (e.g., PLL unlock), the driver will unconditionally
proceed to enable_irq(ctx->irq) below.=20

Could this result in an immediate subsequent interrupt and cause an interru=
pt
storm that locks up the CPU?

>  	if (ctx->irq)
>  		enable_irq(ctx->irq);
> =20
> +err_exit:
>  	drm_bridge_exit(idx);
>  }

[Severity: High]
This is also a pre-existing issue, but does this workqueue function have a
use-after-free risk during driver removal?

When the driver is unbound (e.g., via sysfs), sn65dsi83_remove() unregisters
the bridge but does not appear to call cancel_work_sync(&ctx->reset_work).

If an interrupt fires right before cleanup and schedules this work,
devm_drm_bridge_alloc cleanup will free the ctx structure. The workqueue
could then execute sn65dsi83_reset_work() asynchronously, causing a UAF
when dereferencing ctx->bridge.

Should sn65dsi83_remove() be updated to cancel the pending reset work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-ti-sn65dsi=
83-fixes-v2-0-ebc4c3fe29b6@geanix.com?part=3D2
