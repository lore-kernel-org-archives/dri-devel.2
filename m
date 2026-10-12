Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65504CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C417A10E483;
	Mon, 12 Oct 2026 15:01:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30E210F183
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 15:01:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB48560229;
 Mon, 12 Oct 2026 15:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671CE1F0089B;
 Mon, 12 Oct 2026 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791817291;
 bh=v1lY0kG2LV2wquBeSV/H2Sl5kZBXOaTXRiDxg85MlE8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Co8UqKjDkCu9Ln1bYFZ6ZecIW+UzZ5LDrlPFT0X7JiAsJ/CiByNeZMwZgVKMSEJpz
 Jw8DVZoyvtpNxYi1iObXHhYRVf3dj5JscFmtckhqInkREj3sw9ARq+/Xxv89dDbziY
 K7bND7YM2ICLMSSS0GlYE79LJcg58zvUHlztRz6eRLBwONuMKBGvE1q9aQ+SyicsVv
 vgnDOOZXPLvR5UVf7muC7TEntThmN4ycBAUVRH+Egpe0nBWTZC28RByBOo+M3mkukH
 L0rJzRBogXjQIFVMt360At1cr7ZXzdvMrsHrPFLQARmr9qYLnE9hKzlAUe5tUr7GYh
 GkJgVTVMu2rNQ==
Message-ID: <sashiko-outbox-168304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 06/15] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261012-claude-fixes-v15-6-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
 <20261012-claude-fixes-v15-6-bc0a6c498553@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 15:01:30 +0000
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
- [High] drm/panfrost: Unhandled pm_runtime_get_sync() failure causes bus f=
ault on teardown
--

commit 66f46645f69f978e0ed345266812912523ba84f8
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove
   =20
During device probe(), failure to do a PM get() will leave the usage_count
set to 0, which is the value assigned at device creation time. That means
when the autosuspend delay expires, runtime suspend callback won't be
invoked, so the device will remain powered on forever.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index dd80ad1a67004..2519d76666a98 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
[ ... ]
> @@ -884,9 +892,12 @@ static void panfrost_remove(struct platform_device *=
pdev)
>  	drm_dev_unregister(&pfdev->base);
> =20
>  	pm_runtime_get_sync(pfdev->base.dev);
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);

[Severity: High]
Does this code ignore a potential failure from pm_runtime_get_sync()?

If panfrost_remove() is invoked while the device is runtime-suspended, it
calls pm_runtime_get_sync() to wake the device up and restore clocks and
power before tearing down hardware. If this resume fails, the error appears
to be ignored.

The code proceeds unconditionally to panfrost_device_fini(), which eventual=
ly
calls panfrost_gpu_power_off():

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_power_off() {
    ...
    gpu_write(pfdev, SHADER_PWROFF_LO, pfdev->features.shader_present);
    ...
}

If the clocks and power are actually off due to the resume failure, will th=
is
direct write to GPU MMIO registers cause a synchronous external abort and a
kernel panic?

A follow-up patch 09/15 in this series adds a drm_WARN_ON around the
pm_runtime_get_sync() call, but it still ignores the failure and proceeds to
hardware teardown, failing to resolve the potential crash.

>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
> +
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-claude-fix=
es-v15-0-bc0a6c498553@collabora.com?part=3D6
