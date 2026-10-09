Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1300ECA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7053911214C;
	Fri,  9 Oct 2026 13:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="beW/k4Pg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16D2F11214C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:24:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CEDE60DC5;
 Fri,  9 Oct 2026 13:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86D61F0089C;
 Fri,  9 Oct 2026 13:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791552238;
 bh=t46+aEFXXPpgTz0iOLiT1XNZR7fitLVfwA4EKjmsyT0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=beW/k4PgLlJOQeOxkNrV6p1U6KikCViN2nDmKR81Hgvv154HMy/8644paNcOSuUAM
 7c7z6IMLTPxqQSLttMoAvIMK6vGTd+yZ7n1Xz5IOzZAtkkycHeKEztpvbia8WmuG80
 EyL4Yv38rNcuvqEXpeShfhX3YDMFzI41N8R5mMx7RhKlzRL5iF/QbOTYDRcTNK3Lzg
 OI6x2hTrVb8ziix9t4aSUwV08ybLvXZIMCI9ptmFv2xS57kvtS16ATFHg4vGk9HZb1
 NYKQ+El6dNnGmM3WK97Fitta8IMpe934qz7vmFunQNrTOsUVeQSi7Dsor+LKCUYCCZ
 n9+whaSTucJ+Q==
Message-ID: <sashiko-outbox-165626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/15] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-claude-fixes-v14-6-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
 <20261009-claude-fixes-v14-6-cb743b3b973b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:23:58 +0000
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
- [High] drm/panfrost: fatal bus fault on pm_runtime_get_sync() failure dur=
ing teardown
--

commit b75b37397a751cf9b55bbc2c3a99131de6b299ec
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove

This commit manually adjusts the PM usage counter during device probe and
removal to ensure autosuspend works correctly. It calls
pm_runtime_dont_use_autosuspend() in the wind-down path to fix devfreq
spam and job timeouts.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
[ ... ]
> @@ -884,9 +892,12 @@ static void panfrost_remove(struct platform_device *=
pdev)
>  	drm_dev_unregister(&pfdev->base);
> =20
>  	pm_runtime_get_sync(pfdev->base.dev);

[Severity: High]
If pm_runtime_get_sync() fails here, could this lead to a fatal bus fault?

In panfrost_remove() in drivers/gpu/drm/panfrost/panfrost_drv.c, the return
value of pm_runtime_get_sync() is ignored. If the resume operation fails,
the device remains in a suspended state with its clocks and power domains
disabled.

The code then unconditionally calls panfrost_device_fini(), which executes
hardware teardown functions like panfrost_jm_fini(), panfrost_mmu_fini(),
and panfrost_gpu_fini(). These functions read and write MMIO registers.

Accessing unclocked or unpowered MMIO registers on ARM SoC architectures
triggers a fatal synchronous external abort (SError) or data abort, which
brings down the entire system. Should hardware register accesses be
explicitly skipped if power could not be restored?

> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
> +
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-claude-fix=
es-v14-0-cb743b3b973b@collabora.com?part=3D6
