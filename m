Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8400C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061DA10F487;
	Fri, 28 Aug 2026 21:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c7b1Gc+/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EA810F487
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:09:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EA85160055;
 Fri, 28 Aug 2026 21:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E6A1F000E9;
 Fri, 28 Aug 2026 21:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787951353;
 bh=eF4qJAexfNdfN0HsUhHmEa/8frfbG0OLTffL0JOam90=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c7b1Gc+/Wldarz8BywYvE8RQYjmA4g5MNjsf/PB6Unx47tbpNTAyLkHxeN4lJVnIl
 K7NNnjGrg/ytOZUiE2FODayE9K0+eI7OaTVbGH2zaLp7FBS1n8ZlNzrNw1y7Rnt+tU
 2HA9avFcGjDbNCRJQ2wKIMddNEDk8Ln2osDLlhOQvib/k5HGPh12M3fjFz0GmjQffN
 W74HPXB7QdLRxWPY0Lp25mTkM6HIcoBDkiSSi8lvlP+qFSEw8xXZzpiDj/xSa8qJe4
 oRePLMFAfbgE9iVk8+ufPLfh70Laj2sm9BUEp8tUbTQ8wJBRnkiiQpuUYWXmnDrpzs
 rqw8XffWHkeOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/17] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-claude-fixes-v7-9-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-9-72a13b2c125d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:09:13 +0000
Message-Id: <20260828210913.82E6A1F000E9@smtp.kernel.org>
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
- [High] Dropping the PM usage counter before disabling runtime PM in the i=
nit error path creates a window for unintended device suspend, leading to a=
 potential crash.

Pre-existing issues:
- [High] panfrost_device_fini() unconditionally accesses hardware registers=
 even if pm_runtime_get_sync() fails, leading to a potential crash.
--

commit 2b42dddf42e663beb9d859051cf7ae5891d997e4
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove

This commit addresses power management reference count and autosuspend
issues during device probe and removal. It manually adjusts the PM refcount
and calls the autosuspend or noidle functions at the appropriate times to
prevent the device from remaining powered on forever or increasing its
usage count monotonically on module reloads.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 99f7da2180f92..70c8109ea6987 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -334,9 +335,13 @@ int panfrost_device_init(struct panfrost_device *pfd=
ev)
>  	if (err < 0)
>  		goto out_devreg;
> =20
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> +
>  	return 0;
> =20
>  out_devreg:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);

[Severity: High]
Does dropping the PM usage counter before disabling runtime PM create a race
window here?=20

If `pm_runtime_put_noidle()` drops the PM usage count to 0 while PM runtime
is still active, a concurrent thread (e.g., userspace modifying sysfs power
controls) could trigger an asynchronous device suspend. This would turn off
clocks and power domains right before the error path proceeds to call
`panfrost_device_disable_hw()`, attempting to write to memory-mapped hardwa=
re
registers that are now powered off, which can cause a Synchronous External
Abort.

Should `pm_runtime_disable()` be called before `pm_runtime_put_noidle()` to
guarantee the device remains active during teardown?

>  	panfrost_device_disable_hw(pfdev);
>  	panfrost_gem_fini(pfdev);
[ ... ]
> @@ -363,7 +368,9 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
> =20
>  	panfrost_jm_stop_sched_jobs(pfdev);
>  	panfrost_device_disable_hw(pfdev);

[Severity: High]
This is a pre-existing issue, but panfrost_device_fini() unconditionally
accesses hardware registers even if pm_runtime_get_sync() fails.

If `pm_runtime_get_sync()` returns `< 0` (e.g., due to a hardware fault,
regulator issue, or clock failure), the function continues unconditionally
to `panfrost_device_disable_hw()`. This attempts to write to GPU/MMU
registers without power/clocks, which will result in a system crash
(Synchronous External Abort).

Can we add a check to handle the `pm_runtime_get_sync()` failure and avoid
accessing the powered-down hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-claude-fix=
es-v7-0-72a13b2c125d@collabora.com?part=3D9
