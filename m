Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE09C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC3510EB90;
	Tue, 18 Aug 2026 14:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VrxA8BwI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF1A10EBAF
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 14:07:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C34CB40F12;
 Tue, 18 Aug 2026 14:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DE41F000E9;
 Tue, 18 Aug 2026 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787062040;
 bh=Yy8jTH/XUYKHgpmPNpFnKzKIe5zreFTEPB1lpPRUu80=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VrxA8BwIw8Q7ciblrXHu4wXvkGZ3lXd+7W6tWmX6UN8/WOfpkALwRekn9lK/zso0d
 BLnApGgTimFvkadjp/fIn9qdXeesWDj0ZIMXXihc/QSOxZAqo18HRhEIQOmmC50zcx
 RXTVnJax/IS6GQzFa4xIrSMvJdZyuNXa0FpOOn6wzG0yG8cD3fH/2ooPsmxrciIHaX
 PHRyd7xoYh7h4c6zSnFiwUEMaqJpDm7w0VYzvVTNdxDalkOvU45ywJwpzOKF8J/oNa
 QhlJKDOEFnhIZweHKr7eiBDpdSTNWP67FwrczgLi+q7BjRNR9yGjlBWUoyOsoPx5/8
 HppiiZMtgYnMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: omapfb: panel-dsi-cm: initialize lock before
 registering display
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818135318.1957283-1-runyu.xiao@seu.edu.cn>
References: <20260818135318.1957283-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:07:20 +0000
Message-Id: <20260818140720.86DE41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] List corruption and Use-After-Free due to missing display unregist=
ration on probe error paths.
- [High] Premature device registration exposes the display to consumers bef=
ore initialization is complete, risking uninitialized resource access.
- [High] Use-After-Free during driver removal due to non-synchronous cancel=
lation of delayed work.
- [High] Race condition between TE interrupt handler and timeout work causi=
ng double bus unlock.
--

--- Patch [1]: [PATCH] fbdev: omapfb: panel-dsi-cm: initialize lock before =
registering display ---
commit 62bd817117921c28fba7141ddc3cf344ad0e4b1e
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

    fbdev: omapfb: panel-dsi-cm: initialize lock before registering display
   =20
    dsicm_probe() registers the display before initializing ddata->lock.
    Once omapdss_register_display() publishes the display, another consumer
    can reach a dsicm callback that takes this mutex while it is still
    uninitialized.
   =20
    Initialize the mutex before registering the display so the published
    callbacks always see a valid lock.

> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/d=
rivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> index 5e7963b4aa93c..8d1dcd4371139 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
> @@ -1150,14 +1150,14 @@ static int dsicm_probe(struct platform_device *pd=
ev)
>  	dssdev->caps =3D OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
>  		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
> =20
> +	mutex_init(&ddata->lock);
> +
>  	r =3D omapdss_register_display(dssdev);
>  	if (r) {
>  		dev_err(dev, "Failed to register panel\n");
>  		goto err_reg;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does publishing the display
globally here expose it to consumers before initialization is complete?

If a consumer like omapfb discovers the display immediately and calls
dsicm_update() or dsicm_disable(), could they trigger cancel_delayed_work()
or schedule_delayed_work() on ulps_work and te_timeout_work before those
works are initialized later in the probe function?

> =20
> -	mutex_init(&ddata->lock);
> -
>  	atomic_set(&ddata->do_update, 0);
> =20
>  	ddata->reset_gpio =3D devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW=
);

[Severity: High]
This is a pre-existing issue, but does the error path for this and subseque=
nt
initializations leak the registered display?

If devm_gpiod_get() fails:

	if (r) {
		dev_err(&pdev->dev, "Failed to request reset gpio: %d\n", r);
		return r;
	}

the probe function returns the error directly, but omapdss_register_display=
()
has already added dssdev->panel_list to the global panel_list. Since
omapdss_unregister_display() is never called on these error paths, will this
leave a dangling pointer in the global list that could cause a panic if
traversed?

[Severity: High]
This isn't a bug introduced by this patch, but does driver removal have a
use-after-free risk?

In dsicm_remove():

	dsicm_cancel_ulps_work(ddata);

This uses cancel_delayed_work() for ulps_work, which does not wait for
currently executing work, and te_timeout_work cancellation appears to
be omitted entirely.

When remove() returns, devres frees the ddata structure. If either work item
is running or subsequently fires, will it dereference the freed ddata?

[Severity: High]
This is a pre-existing issue, but is there a race condition between the TE
interrupt handler and the timeout work?

In dsicm_te_timeout_work_callback():

	atomic_set(&ddata->do_update, 0);
	in->ops.dsi->bus_unlock(in);

If this executes concurrently with dsicm_te_isr(), could the ISR successful=
ly
claim the update via atomic_cmpxchg() before the timeout work zeroes it?

If both paths then handle the frame, would this lead to an immediate
uncoordinated bus_unlock() from the timeout work and a subsequent
bus_unlock() from the frame-done callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818135318.1957=
283-1-runyu.xiao@seu.edu.cn?part=3D1
