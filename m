Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0BEC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B4E10E372;
	Wed, 16 Sep 2026 08:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jGtTJXHO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61DB10E372
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:01:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0678602D1;
 Wed, 16 Sep 2026 08:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849081F00893;
 Wed, 16 Sep 2026 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789545696;
 bh=Vga96SjtpOH32QtIM/sWVzo0nxOjSPDD9ZaWDSObAHc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jGtTJXHOnQjT14qz6KWG1qr3hq879W9xLv0bGz6S/aMmwDPq3FKjFpUBI/iPV2aO3
 Sk3bvY68EGDw5JkdtOyRh+xQcSKHToNq0zMsFWn6HBEGEPBomCvLnkhHxElm1EqqTd
 y0O1xS7joew4He/VeZwuagvLm1oe8q3BpOQVnfTGZqBOJc+mFDcJ1ka9vwoL//+vF+
 +2OngTqri5ZBXOo+Xv5OkdQhapqBngFJxl1mKH1LLETlZG4D/EjwxR7kkbS3+R9xqY
 PwTF9S+m6xpFYYCdNjfIB4/dpyRfX4Yzd82NRlkF4fDCEhVL1IH7wbXrVd2qLBMJXS
 HWmUobmfrjqIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panfrost: add missing
 pm_runtime_dont_use_autosuspend() calls
To: "Joshua Crofts" <joshua.crofts1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916075051.1353-1-joshua.crofts1@gmail.com>
References: <20260916075051.1353-1-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 08:01:36 +0000
Message-Id: <20260916080136.849081F00893@smtp.kernel.org>
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
- [High] drm/panfrost: fatal SError crash in probe error path due to synchr=
onous suspend
--

commit 0a02f30e746f195b71331259b1584b0eadbe399f
Author: Joshua Crofts <joshua.crofts1@gmail.com>

drm/panfrost: add missing pm_runtime_dont_use_autosuspend() calls

This commit adds missing pm_runtime_dont_use_autosuspend() calls in
panfrost_remove() and panfrost_probe() to prevent potential resource leaks
on teardown or failure.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 96a66d673ba60..67652f6c8647d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1012,6 +1012,7 @@ static int panfrost_probe(struct platform_device *p=
dev)
>  err_out2:
>  	drm_dev_unregister(&pfdev->base);
>  err_out1:
> +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);

[Severity: High]
Does calling pm_runtime_dont_use_autosuspend() here cause a synchronous
suspend of the hardware?

Since pm_runtime_get_sync() wasn't called in this error path (unlike in
panfrost_remove()), the usage count is 0. Clearing the autosuspend flag
triggers a synchronous rpm_idle(), which executes the runtime suspend
callback and disables the GPU clocks and power domains.

Right after this, panfrost_device_fini() is called, which touches MMIO
registers when attempting to power off the GPU:

panfrost_probe() ->
  err_out1:
  pm_runtime_dont_use_autosuspend()
  ...
  panfrost_device_fini() ->
    panfrost_gpu_fini() ->
      panfrost_gpu_power_off()

Will accessing these MMIO registers while the device clocks are disabled
trigger a bus abort (SError) and cause a kernel panic?

Would it be safer to call pm_runtime_get_sync() before
pm_runtime_dont_use_autosuspend() in this error path, similar to how it is
handled in panfrost_remove(), or perhaps move the call after
pm_runtime_disable()?

>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
>  	pm_runtime_set_suspended(pfdev->base.dev);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916075051.1353=
-1-joshua.crofts1@gmail.com?part=3D1
