Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F0FC55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A57410E9B9;
	Tue,  4 Aug 2026 10:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fqLXOg8w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38C910E9C4
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:55:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD30B600AB;
 Tue,  4 Aug 2026 10:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9891F000E9;
 Tue,  4 Aug 2026 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785840913;
 bh=IsXReCTtTCjtGADtx1IpIpcTTs+hwpa3MA/MkZcxkBY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fqLXOg8wA+pbnKSrNaJTc9HBcwIqPtDjPD7tLJw1V4X9CO1QMDjsk4bmLriuNgKtd
 PFM3KqXNugbBSCx/q9LuP6gIRbRFm0l3nqjwOe7Ag2lnL4/CmYiQGcVSAt/T1BXeIN
 wtWQsoFXaENlUGnWpbfuSSIg0HWqvXErOtyA4SgE4AZP1EwWQJbdd8quxHoo13ak0y
 USMIV6UryLjOL7MPZ/vOo1SPWNLkErljt9l3vX5Rf6up+ypdzN4a1IIsrRsKrgl78b
 CC+nHDen8fY4vt+mIZYBZYiqsMxN8DBhy0HOSOuAhJAf+BkQLiiAsI92jKvdL6G1kN
 uzGyR/v/yvPcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] drm/panthor: Flush the cleanup_wq before
 destroying the drm_device
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-panthor-unplug-fixes-v1-4-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-4-abbbd2d41b13@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:55:12 +0000
Message-Id: <20260804105513.6A9891F000E9@smtp.kernel.org>
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
- [High] Use-After-Free during device teardown due to incorrect `drmm` acti=
on registration order for `panthor_cleanup_wq`.
--

--- Patch [4]: [PATCH 04/12] drm/panthor: Flush the cleanup_wq before destr=
oying the drm_device ---
commit 87cbd87d54cc32db384d8c3b01846063a45650f2
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Flush the cleanup_wq before destroying the drm_device

This commit adds a drmm action to flush the panthor_cleanup_wq workqueue
during device teardown. It registers this action before initializing
subcomponents, intending to ensure that any cleanup work queued during
initialization or execution is flushed.

Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-=
0-8836a74e0ef9@collabora.com?part=3D2

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 7d336f160d1fd..b7c55a6f4f081 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
[ ... ]
> @@ -220,6 +228,10 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
> =20
> +	ret =3D drmm_add_action(&ptdev->base, panthor_device_flush_cleanup_wq, =
NULL);
> +	if (ret)
> +		return ret;
> +

[Severity: High]
Does this execute the flush in the intended order?

Since drmm release actions execute in Last-In-First-Out (LIFO) order,
registering the flush action before subcomponent initializations (like
panthor_mmu_init() and panthor_fw_init()) means the flush will run after
those subcomponents have already been freed.

If there is pending work on panthor_cleanup_wq, could this lead to a
use-after-free? When panthor_device_flush_cleanup_wq() executes, pending jo=
bs
could attempt to access the already-freed subcomponents. For example, teari=
ng
down a BO accesses freed memory here:

panthor_device_flush_cleanup_wq()
  flush_workqueue()
    ...
    panthor_kernel_bo_destroy()
      if (vm =3D=3D panthor_fw_vm(ptdev))  <-- ptdev->fw is already freed

>  	ret =3D panthor_clk_init(ptdev);
>  	if (ret)
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-panthor-un=
plug-fixes-v1-0-abbbd2d41b13@collabora.com?part=3D4
