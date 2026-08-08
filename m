Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A0EC5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E52E410E20F;
	Sat,  8 Aug 2026 14:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n1vexN9F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B508E10E20F
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:11:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E1326001A;
 Sat,  8 Aug 2026 14:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354E31F000E9;
 Sat,  8 Aug 2026 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786198264;
 bh=E4jBWcqnXjvJWaIuqgFU7OKfllDI2BHTZN+ENFFZzNw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n1vexN9Fd93XCskSggtU1kiUIO6YCiBPsDRBjgzTa41nEjPJMClwUWZvNQhcrUmrK
 pN3K5FC7bry3A4f5ERtury8FnAUx7D9PQL8ZRqvQxXTRSaFXI7f3W0OVHQV0ossFF2
 Qq7XtWO1H1W7e/j98Z9D6kGJAFn79c1ieWjp1YCSSUM3rIJjeq71QcyaUAwh2ix+M5
 SBVeMGXuV3Mgii05zjfk4n3qhuWpHaSbxpKdQi97n5QvBzEW+YCTqh9cB33V1zmca/
 6JeJP/JwVzCl65KazCCz9yigvcY3N/rmOFlvjG959pQdjzCKexxvSfbSw6Ad9PmjZV
 6jNj1Stdp44oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panfrost: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808135025.2872956-1-lgs201920130244@gmail.com>
References: <20260808135025.2872956-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 14:11:03 +0000
Message-Id: <20260808141104.354E31F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Calling pm_runtime_dont_use_autosuspend() before pm_runtime_di=
sable() in the probe error path triggers a synchronous runtime suspend, cau=
sing a fatal system crash when hardware is subsequently accessed.
- [Medium] Calling `pm_runtime_dont_use_autosuspend()` before `pm_runtime_g=
et_sync()` in `panfrost_remove()` causes an unnecessary synchronous suspend=
 followed immediately by a resume.

Pre-existing issues:
- [High] Missing pm_runtime_put_noidle() at the end of panfrost_remove() pe=
rmanently leaks the PM usage count on driver unbind.
- [High] Premature drm_dev_register() exposes the device before initializat=
ion is complete, risking UAF/Data Abort on the error path.
--

--- Patch [1]: [PATCH] drm/panfrost: fix autosuspend cleanup during teardow=
n ---
commit 20fb0c04bf706e7ac3773cb2ee067fc667a9f893
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/panfrost: fix autosuspend cleanup during teardown

This patch adds missing calls to pm_runtime_dont_use_autosuspend() during t=
he
probe error path and panfrost_remove(). It aims to ensure that the autosusp=
end
reference count is properly dropped during device teardown.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1012,6 +1012,7 @@ static int panfrost_probe(struct platform_device *p=
dev)
>  err_out2:
>  	drm_dev_unregister(&pfdev->base);

[Severity: High]
This is a pre-existing issue, but does registering the device before
initializing the shrinker create a race condition here?

If panfrost_gem_shrinker_init() fails, the probe aborts and calls
drm_dev_unregister(), but this does not revoke open file descriptors. Can
userspace race to open the device during this window and then trigger a
use-after-free or data abort by accessing torn-down hardware mappings
through the open file descriptor?

>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);

[Severity: Critical]
Does placing pm_runtime_dont_use_autosuspend() before pm_runtime_disable()
trigger a synchronous suspend?

When the usage count is zero, clearing the autosuspend flag causes an
immediate idle check which synchronously powers off the hardware. Will the
unconditional register accesses in panfrost_device_fini() then cause a fatal
data abort since the hardware is already powered off?

>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);

[ ... ]

> @@ -1026,6 +1027,7 @@ static void panfrost_remove(struct platform_device =
*pdev)
>  	drm_dev_unregister(&pfdev->base);
>  	panfrost_gem_shrinker_cleanup(&pfdev->base);
> =20
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_get_sync(pfdev->base.dev);

[Severity: Medium]
Could this sequence cause the hardware to suspend and immediately resume?

If the usage count is zero here, pm_runtime_dont_use_autosuspend() will
synchronously power off the device. The subsequent pm_runtime_get_sync()
will immediately power it back on before hardware teardown. Should the
autosuspend cleanup happen after we ensure the device is awake?

>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak the
power management usage count?

The call to pm_runtime_get_sync() earlier in the function increments the
usage count, but there is no matching pm_runtime_put_noidle() before the
function exits. Since the struct device is tied to the platform device and
outlives the driver binding, will this permanently break runtime power
management by blocking future suspends if the driver is unbound and rebound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808135025.2872=
956-1-lgs201920130244@gmail.com?part=3D1
