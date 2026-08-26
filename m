Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6EDC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE81C10E8B6;
	Wed, 26 Aug 2026 21:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gdZydWaT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0684E10E599
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:34:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59C9C6020E;
 Wed, 26 Aug 2026 21:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72891F000E9;
 Wed, 26 Aug 2026 21:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787780058;
 bh=RDgtg/oEfSj/k9xzGiH8+MNX18Z6xbT/9N04lbbhVL4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gdZydWaTFQ/GZZXJtg4uYBDGiPNK1otMsWeBvP3zk+C89dnE+3DjUq41+VapTBmCd
 UiAb3sLtOfBr2PXZye8iUwl8XGqCLW7MN56qZMTSYbnLLAX5jl0Fjdd8RhoRcMDZ8s
 ULtYZVxoCShxLHATCeKcLklHPE0WPt7qVSA9C1XuClhK4hUmm9OS6elD5LdbfovIRs
 Rf3WPCHrPUxNVEqNG5bCk1DrOiTvyHXyUW3GQWeoNnSLRs4ZDEUdExkC42/C04SRHy
 F4yVhT2sLeJdgkHbCCcOd/3DD8AaVhGzp6hil/GJJHClEa8QCbBGXq5DGJ10GIvdCD
 5/NQKlidg0bug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/16] drm/panfrost: Move shrinker initialization and
 unplug one level down
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-claude-fixes-v6-1-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
 <20260826-claude-fixes-v6-1-78119af409e7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:34:17 +0000
Message-Id: <20260826213417.E72891F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Closing a GEM object or MMU context during/after device unbind cau=
ses a kernel panic due to unclocked MMU register access.
--

commit 78f80dbfd319f079f4898f5d8b2af5e44a1877d5
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move shrinker initialization and unplug one level down

This commit moves the initialization and cleanup of the GEM shrinker into
the core GEM init and fini paths. It mimics the behavior seen in Panthor
and removes an unnecessary config feature check.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
[ ... ]
> @@ -1024,7 +1019,6 @@ static void panfrost_remove(struct platform_device =
*pdev)
>  	struct panfrost_device *pfdev =3D platform_get_drvdata(pdev);
> =20
>  	drm_dev_unregister(&pfdev->base);
> -	panfrost_gem_shrinker_cleanup(&pfdev->base);
> =20
>  	pm_runtime_get_sync(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
[Severity: High]
This is a pre-existing issue, but closing a GEM object or MMU context during
or after device unbind can cause a kernel panic due to unclocked MMU regist=
er
access.

When a userspace process closes a DRM file descriptor concurrently with
device unbind, it triggers panfrost_mmu_flush_range().

During unbind, pm_runtime_disable() is called here while the device is in
the RPM_ACTIVE state. The status remains RPM_ACTIVE even after
panfrost_clk_fini() turns off the hardware clocks.

Because the status remains active, concurrent execution of
panfrost_mmu_flush_range() evaluates to true:

drivers/gpu/drm/panfrost/panfrost_mmu.c:panfrost_mmu_flush_range() {
    ...
    if (pm_runtime_active(pfdev->base.dev))
        mmu_hw_do_operation(pfdev, mmu, iova, size, AS_COMMAND_FLUSH_PT);
    ...
}

The same vulnerability exists in context destruction during teardown:

drivers/gpu/drm/panfrost/panfrost_mmu.c:panfrost_mmu_release_ctx() {
    ...
    if (pm_runtime_active(pfdev->base.dev))
        panfrost_mmu_disable(pfdev, mmu->as);
    ...
}

Could this pm_runtime_disable() sequence leave the device vulnerable to a
synchronous external abort on ARM when those powered-down registers are
concurrently accessed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-claude-fix=
es-v6-0-78119af409e7@collabora.com?part=3D1
