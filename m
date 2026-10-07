Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7ECCA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3AE10F879;
	Wed,  7 Oct 2026 23:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h40icKZF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D11410E501
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 23:55:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B015840B42;
 Wed,  7 Oct 2026 23:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C311F000FF;
 Wed,  7 Oct 2026 23:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791417351;
 bh=htWf0CDyelntfU57L+UyafHld7yPcypOd4lchWh4G7A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h40icKZFGo7AyC9nejBP6KDOl8MaUfPmbOs1UjWyx7xM38zU+i+53i/Iv8jKkFgp5
 R/0OFG0Ur9vieOAwuxgtqGr7bzZqxv/uQw/I4848f881Y2Dv1+6xtjhW2tHcI4L8cd
 wvT5uQoO8JSBHj1I0YmMUKk+jNZVqTWcUc9AfKFhLveAPxw4qJrGAi28aVyRFRWf+s
 tdVN2sPiFXwmHeio2eUddxWXdIa8PJoKiaDJzTdwkHoEaqf8WoXj+UTdoZ/i+vJ4BR
 9SmWS/xrKGvTpbLVPF48k2XbaC26iqRT8A6xCrhYW0RjGHyd3GGp7KB2bV6y6jxir+
 7EgkDWKvEKgSQ==
Message-ID: <sashiko-outbox-163441@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/15] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-claude-fixes-v13-6-d6a493185860@collabora.com>
References: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
 <20261008-claude-fixes-v13-6-d6a493185860@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 23:55:50 +0000
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
- [High] drm/panfrost: missing error check on pm_runtime_get_sync() in devi=
ce removal causes SError
--

commit c158c940eec9a323d868411adbbd13b59c6449b8
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM refcnt and autosuspend issues at device probe/remove

This commit fixes issues where the panfrost device PM usage count was left
at 0 after probe failure, or increased monotonically after every module
reload. It manually adjusts the PM refcnt at probe and removal, and ensures
autosuspend functions are called properly.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 55fc22e8d4d4e..907d4a14a0b55 100644
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
Does ignoring the return value of pm_runtime_get_sync() in panfrost_remove()
allow the driver to write to unpowered hardware?

During device removal, if the power domain or regulators fail to resume the
device, pm_runtime_get_sync() returns a negative error code. Because the
code proceeds unconditionally to call panfrost_device_fini(), it invokes
panfrost_gpu_fini() and panfrost_perfcnt_fini(), which perform direct MMIO
register writes (such as to SHADER_PWROFF_LO and GPU_PERFCNT_CFG).

Accessing these registers while the hardware is physically powered off can
cause an Oops due to a synchronous external abort on ARM architectures.

Note that even if follow-up patches attempt to address this by wrapping the
call in drm_WARN_ON(), that does not abort or bypass the subsequent hardware
accesses. The system would still crash following the warning.

>  	pm_runtime_set_suspended(pfdev->base.dev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
> +
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-claude-fix=
es-v13-0-d6a493185860@collabora.com?part=3D6
