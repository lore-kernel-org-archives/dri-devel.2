Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD1C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5E810E035;
	Sat,  8 Aug 2026 12:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h7O44FPJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9410210E035
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:36:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A0AE43CD9;
 Sat,  8 Aug 2026 12:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27FE1F000E9;
 Sat,  8 Aug 2026 12:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786192572;
 bh=XqzHzxTClGx0Q5x9+gP9AH6+y77X+N4qlUwY+fX+ZNE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h7O44FPJzvJX3BmI+IjIK9hnHXyPyXMNGcA+l++76j+staiMxK8IilzodJJ6K8+iV
 iIUmsxwZfKs+4Zlb6j7JuE4jA2GcnlADT5SQnQqJ5u/6+xFwtv3Wan4smp4I4NNwyM
 HPdIRn+0+RrnF+qVhHADSDs9yVNUtTCGfwCaq+gfiy9VF0hPykGUwQjAVQBnRLcCDN
 6NYmOtzbtNyg3D4EURQUL2sNJFUjgB1gWM0oUk/8KL1uFT0rWqOvpFyid0yiguHf40
 7sGmocOZTadVbr3XTQwn+ZB24lAGuxm9x2qdKeVEctpU359MhPf8SRzBHNXEZCLUkb
 JQpMrmQ8I0aQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imx: dcss: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260808122354.2825209-1-lgs201920130244@gmail.com>
References: <20260808122354.2825209-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 12:36:11 +0000
Message-Id: <20260808123611.D27FE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Double Hardware Suspend / Clock Disable caused by synchronous rpm_=
idle.

Pre-existing issues:
- [High] TOCTOU Race Condition during driver teardown.
- [High] Hardware register access while runtime suspended leads to system c=
rash.
--

--- Patch [1]: [PATCH] drm/imx: dcss: fix autosuspend cleanup during teardo=
wn ---
commit 57aed202fd27fa66b9bc5448a0fe4df074c91e5c
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/imx: dcss: fix autosuspend cleanup during teardown

This patch adds a missing pm_runtime_dont_use_autosuspend() call during
driver teardown before disabling runtime PM. This ensures the usage count
remains balanced if the autosuspend delay is set to a negative value while
enabled.

> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dc=
ss/dcss-dev.c
> index 7fd0c4c14205d..51398852cdc2b 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> @@ -234,6 +234,7 @@ void dcss_dev_destroy(struct dcss_dev *dcss)
>  {
>  	if (!pm_runtime_suspended(dcss->dev)) {

[Severity: High]
This isn't a bug introduced by this patch, but does this check have a race
condition with the PM worker?

If the autosuspend timer expires exactly when dcss_dev_destroy() is called,
is it possible for the PM worker thread to execute dcss_dev_runtime_suspend=
()
concurrently with this block? Both paths would call dcss_ctxld_suspend()
and dcss_clocks_disable() at the same time.

Should pm_runtime_disable() be called before this check to wait for pending
transitions and prevent new ones?

>  		dcss_ctxld_suspend(dcss->ctxld);
>  		dcss_clocks_disable(dcss);
>  	}
> =20
>  	of_node_put(dcss->of_port);
> =20
> +	pm_runtime_dont_use_autosuspend(dcss->dev);

[Severity: High]
Could this newly added call trigger a double hardware suspend and clock
disable?

If the device is active during teardown (e.g., the autosuspend delay hasn't
expired), the code above manually executes dcss_ctxld_suspend() and
dcss_clocks_disable(). When pm_runtime_dont_use_autosuspend() is then
called, it drops the autosuspend flag and synchronously calls rpm_idle().

Because the usage count is 0 and the device is still marked RPM_ACTIVE,
this will synchronously invoke the driver's runtime suspend callback:

dcss_dev_destroy()
  pm_runtime_dont_use_autosuspend()
    rpm_idle()
      dcss_dev_runtime_suspend()
        dcss_clocks_disable()

This causes a second clock disable and suspend. Should this call be moved
after pm_runtime_disable(), where disable_depth > 0 would safely prevent the
PM callbacks from executing?

>  	pm_runtime_disable(dcss->dev);
> =20
>  	dcss_submodules_stop(dcss);

[Severity: High]
This is a pre-existing issue, but can this call cause a bus fault if the
device was already runtime suspended?

If dcss_dev_destroy() is called when the device is runtime suspended,
the manual dcss_clocks_disable() above is skipped. dcss_submodules_stop()
is then unconditionally called, which executes submodule exit functions lik=
e:

dcss_submodules_stop()
  dcss_scaler_exit()
    dcss_writel(0, ch->base_reg + DCSS_SCALER_CTRL);

Since dcss_submodules_stop() only calls dcss_clocks_enable() but doesn't
power on the PM domain, doesn't writing to these MMIO registers cause a
synchronous external abort?

> =20
>  	dcss_clks_release(dcss);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122354.2825=
209-1-lgs201920130244@gmail.com?part=3D1
