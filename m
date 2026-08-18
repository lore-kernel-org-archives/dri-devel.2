Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB89C5DF84
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4114C10EB78;
	Tue, 18 Aug 2026 13:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UWI9TRkb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250DF10EB78
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:35:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47D83601DE;
 Tue, 18 Aug 2026 13:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD11F1F000E9;
 Tue, 18 Aug 2026 13:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787060099;
 bh=pvwulaLNeM2vxICvFkjpTG3yxBdO98nZJ064v5rzKcM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UWI9TRkbMxuiLgHDXuj++KxmWZBwXvlT4sSm+zgEm7YquXUhXZfxpRWCU3bY00vVj
 uWLRHvfLudPYXTKSSx1Ix1+SCPrvmtcUZDReI1GycSISUBC9RUyKJ34LqtAjsUrN+f
 FdgulLfRnim67136As54Miblk4v//WneqtROl+Tt4NN2DzVbwmI+dt5XnNma9mTtBV
 EReXASLI01rjTWgRYX8HvNO9LqvSUh1Z3RZKX8sqro2zOFpC74oKRQQ8gUNUQ08xYR
 OY3uHldDlCt2tUlTXQujacT5CeVLVugOynQahuzGJUMjI0ONofYVbjKOVD4asKrstj
 gFtq5mOORxsmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sun4i: frontend: fix clock leak on reset failure in
 runtime resume
To: "Jiawen Liu" <1298662399@qq.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_3AEE86932EE0F9AF7D6549FD705139A4AF06@qq.com>
References: <tencent_3AEE86932EE0F9AF7D6549FD705139A4AF06@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:34:58 +0000
Message-Id: <20260818133458.BD11F1F000E9@smtp.kernel.org>
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
- [High] Unhandled error from sun4i_frontend_init leads to kernel panic on =
hardware register access.
- [High] Plane atomic update callback invokes sleeping functions via pm_run=
time_get_sync.
--

--- Patch [1]: [PATCH] drm/sun4i: frontend: fix clock leak on reset failure=
 in runtime resume ---
commit 545a5eac90415ee6d6efb1f3f808e86b0dd094da
Author: Jiawen Liu <1298662399@qq.com>

drm/sun4i: frontend: fix clock leak on reset failure in runtime resume

sun4i_frontend_runtime_resume() can fail after enabling the bus, mod,
and ram clocks if reset_control_reset() returns an error. The function
previously returned without disabling those clocks, leaking them and
leaving the hardware in an inconsistent state.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun=
4i/sun4i_frontend.c
> index 5e9c4b97c84c3..db3fad9d8617a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
> @@ -647,14 +647,22 @@ static int sun4i_frontend_runtime_resume(struct dev=
ice *dev)
> =20
>  	clk_set_rate(frontend->mod_clk, 300000000);
> =20
> -	clk_prepare_enable(frontend->bus_clk);
> -	clk_prepare_enable(frontend->mod_clk);
> -	clk_prepare_enable(frontend->ram_clk);
> +	ret =3D clk_prepare_enable(frontend->bus_clk);

[Severity: High]
This is a pre-existing issue, but does calling clk_prepare_enable() here
violate atomic context rules?

During display updates, sun4i_backend_layer_atomic_update() executes in an
atomic context where sleeping is forbidden. It calls sun4i_frontend_init()
which synchronously calls pm_runtime_get_sync(). If the device is suspended,
this executes sun4i_frontend_runtime_resume() and reaches these sleeping
clk_prepare_enable() functions, which can cause scheduling while atomic
warnings.

> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(frontend->mod_clk);

[ ... ]

> @@ -664,6 +672,14 @@ static int sun4i_frontend_runtime_resume(struct devi=
ce *dev)
>  	sun4i_frontend_scaler_init(frontend);
> =20
>  	return 0;
> +
> +err_disable_ram_clk:
> +	clk_disable_unprepare(frontend->ram_clk);
> +err_disable_mod_clk:
> +	clk_disable_unprepare(frontend->mod_clk);
> +err_disable_bus_clk:
> +	clk_disable_unprepare(frontend->bus_clk);
> +	return ret;

[Severity: High]
This isn't a bug introduced by this patch, but does returning this error wi=
th
the bus clock disabled now risk a kernel panic?

In drivers/gpu/drm/sun4i/sun4i_layer.c:sun4i_backend_layer_atomic_update(),
the return value of sun4i_frontend_init() is ignored:

	sun4i_frontend_init(frontend);
	sun4i_frontend_update_coord(frontend, layer);

If sun4i_frontend_runtime_resume() fails (e.g., reset failure) and this
unwinding path successfully disables frontend->bus_clk, the frontend is left
without its bus clock. When sun4i_frontend_update_coord() and other functio=
ns
subsequently attempt to write to hardware registers, accessing them while t=
he
bus clock is disabled can trigger a synchronous external abort on ARM.

>  }
> =20
>  static int sun4i_frontend_runtime_suspend(struct device *dev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_3AEE86932EE=
0F9AF7D6549FD705139A4AF06@qq.com?part=3D1
