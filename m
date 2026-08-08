Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482CDC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992E910E05F;
	Sat,  8 Aug 2026 15:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H5rxZUYc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E4E10E05F
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 15:02:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9F34600B1;
 Sat,  8 Aug 2026 15:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516391F000E9;
 Sat,  8 Aug 2026 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786201345;
 bh=ykjd2SeIzrlPPhMG8UNbnQRK/DgYmMZX9dGxPR7Jo5c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H5rxZUYcE7gzZBrHlM7/WDoNeT7YntF7yrd7qb/DuwhngiH1BHokGcoOC+jNFS79n
 nuA2JMhB9HwfJhkvKC2QoRgDc4aq+sr3/qVEUrwVZLYVTngPzDMZhoZSLYVe1dGZab
 Muv7O1La8HdQ15NOuHeLcp68eP0a4dWPgaWM+GQLULiKDg3LpIe9QB277Vl13W+YNk
 elm0xO7oLHDrPKivVOTzWGygsj3/J01OHPEntE3h5uafvqRotXgCi4iP31fXBicm4I
 NJxJfKEfl6jd9i4sqgXzBOSSH8j56oYBeK0X9Szetxp2BWhkZLYkbViqDpKwSHq2ho
 7r8WLcF3FtILA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808144907.2918746-1-lgs201920130244@gmail.com>
References: <20260808144907.2918746-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 15:02:24 +0000
Message-Id: <20260808150225.516391F000E9@smtp.kernel.org>
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
- [Medium] Unbalanced pm_runtime_get_sync() and pm_runtime_forbid() causing=
 a runtime PM usage count leak on driver probe error paths.
--

--- Patch [1]: [PATCH] drm/xe: fix autosuspend cleanup during teardown ---
commit 33bf65f058f06f66ae199db570fd2ab554bf8591
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/xe: fix autosuspend cleanup during teardown

This patch adds the missing pm_runtime_dont_use_autosuspend() call to the
runtime PM teardown path to prevent a usage count leak.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index a5289a9df8d25..e05290400c650 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -518,6 +518,7 @@ static void xe_pm_runtime_fini(struct xe_device *xe)
>  	if (IS_SRIOV_VF(xe))
>  		return;
> =20
> +	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_forbid(dev);
>  }

[Severity: Medium]
This is a pre-existing issue, but does calling pm_runtime_get_sync() and
pm_runtime_forbid() unconditionally here cause a runtime PM usage count leak
on probe error paths?

If xe_pm_init() fails early in xe_pci_probe() (for example, if
xe_pm_set_vram_threshold() returns an error), the error handler calls
xe_pci_remove() which unconditionally executes the teardown functions.

Because xe_pm_init() failed before it could call xe_pm_runtime_init(),
pm_runtime_allow() and pm_runtime_put() were never called to balance the PCI
core's initial reference count.

When xe_pm_runtime_fini() executes pm_runtime_get_sync() and
pm_runtime_forbid() on that error path, it increments the usage count witho=
ut
checking if initialization actually completed. Will this artificially infla=
te
the device's usage count and prevent the unbound device from ever being
runtime-suspended after the failed probe?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808144907.2918=
746-1-lgs201920130244@gmail.com?part=3D1
