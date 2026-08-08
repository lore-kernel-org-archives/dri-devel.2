Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A740C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE9F10E040;
	Sat,  8 Aug 2026 14:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A4e/XzRt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2723710E040
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:34:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37A3D6001A;
 Sat,  8 Aug 2026 14:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0701F000E9;
 Sat,  8 Aug 2026 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786199658;
 bh=zVeCiJ8tANcc1qocfD72/iLMxiPuk7WHV/Jh+NfsMJQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A4e/XzRtmx4M2zeajbyZ+dIBTsgXsWIKRGbxKDyk0qU5XyskeNBoA0UJdEiOdTo0e
 YgYz9rmYrjhr3TYS5Nn29MvTfqoLkASGy75onazDCun0hF5tH1nZf6Y/VMibfKb3XH
 Z3nC7NE3ukbuJW/lF6eFJ4KjexS/oFzgMpq5YUe4tF5kc65Fpdhm+WVkONSm+dmEJB
 najOZ+I0uQu6Vn4ediZQlc8vwJRziyeQHzI+6JZ5DZxWYkFaXGr0osPAvv+CXwqcFP
 ZTp0ebObLR5xSyNn0/yommWqr6gbBaILa6Mr9Yn6kibjLuFOsAtg944Eu6rvst93AC
 /aMdWmBuMwnFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: gr3d: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808142217.2893936-1-lgs201920130244@gmail.com>
References: <20260808142217.2893936-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 14:34:18 +0000
Message-Id: <20260808143418.7B0701F000E9@smtp.kernel.org>
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
- [High] Unreachable Code / Broken Power Management due to incorrect placem=
ent of pm_runtime_enable()
- [Medium] Guideline Violation: missing pm_ptr() wrapper for dev_pm_ops ass=
ignment
--

--- Patch [1]: [PATCH] drm/tegra: gr3d: fix autosuspend cleanup during tear=
down ---
commit 94bf3f52211b3cc132d2cfe856cc599ac46c8751
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/tegra: gr3d: fix autosuspend cleanup during teardown

This commit adds a missing pm_runtime_dont_use_autosuspend() call during
driver removal.

> gr3d_probe() calls pm_runtime_use_autosuspend(), but gr3d_remove()
> does not call the matching pm_runtime_dont_use_autosuspend() during
> teardown.

[Severity: High]
This is a pre-existing issue, but does the runtime PM initialization
actually work as described?

It appears pm_runtime_enable() and autosuspend configurations are placed in
gr3d_runtime_resume() rather than gr3d_probe():

drivers/gpu/drm/tegra/gr3d.c:gr3d_runtime_resume() {
        ...
        pm_runtime_enable(dev);
        pm_runtime_use_autosuspend(dev);
        pm_runtime_set_autosuspend_delay(dev, 500);
        ...
}

Since the PM core initializes devices with runtime PM disabled, won't this
callback never be invoked, leaving the device permanently in RPM_SUSPENDED
from the PM core's perspective? Should these initialization calls be moved
to gr3d_probe()?

> diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
> index 42e9656ab80c9..518bd21f52e2d 100644
> --- a/drivers/gpu/drm/tegra/gr3d.c
> +++ b/drivers/gpu/drm/tegra/gr3d.c
> @@ -524,6 +524,7 @@ static void gr3d_remove(struct platform_device *pdev)
>  {
>  	struct gr3d *gr3d =3D platform_get_drvdata(pdev);
> =20
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	host1x_client_unregister(&gr3d->client.base);
>  }

[Severity: Medium]
This is a pre-existing issue, but when CONFIG_PM is disabled, does
unconditionally assigning the dev_pm_ops structure create dead code?

drivers/gpu/drm/tegra/gr3d.c:tegra_gr3d_driver {
        ...
        .pm =3D &tegra_gr3d_pm,
        ...
}

Should this use the pm_ptr() wrapper like .pm =3D pm_ptr(&tegra_gr3d_pm) to
ensure the callback functions do not get linked into the kernel when they c=
an
never execute?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808142217.2893=
936-1-lgs201920130244@gmail.com?part=3D1
