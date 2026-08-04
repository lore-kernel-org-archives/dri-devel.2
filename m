Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D66C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 16:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0665B10EB08;
	Tue,  4 Aug 2026 16:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ESNcoHTs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0751A10EB08
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 16:01:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13FBB60A83;
 Tue,  4 Aug 2026 16:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8021F000E9;
 Tue,  4 Aug 2026 16:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785859285;
 bh=pxt/+ajdG75cb8ZE2lOHuYLdHm6cxAU0nUcvwO75wnA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ESNcoHTso9aVAr4ELvTcyRUXGz6XFzRl9yF3Lc5XAiUMV4MH5KhiKFjX2g5q14u6R
 CgkOceY34cu5iqO2Acz9V/vPsjAyZRbEdPgFaSlb40hY6DOQgkQYg0k89Dfa7I/sSq
 cYyquRN5hlE7hAqmZhb4fjMhITyPQ1IRJ5EBjm2/JdTJTqY+ZIqOfpZQDxh4I0mRvw
 xetIt8XI/W3YB9Vop0X+k1u0w8J/fzxXlVoybvfjcEavrzzgzO/fQgVaNluF7+GKyj
 X8mgW9cdAk+JBIeG3QuFZcZM1Z/JuebXWgQdcpBg5UnrGVkc03NsU05Ar5tSD+CJHw
 ebRia0tBBmnNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] drm/panthor: Fix unplug in the reset path
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-panthor-unplug-fixes-v1-12-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-12-abbbd2d41b13@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 16:01:24 +0000
Message-Id: <20260804160125.5B8021F000E9@smtp.kernel.org>
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
- [High] Concurrent execution of device removal and a failing reset work ca=
uses an unrecoverable AB-BA cross-thread deadlock.
--

--- Patch [12]: [PATCH 12/12] drm/panthor: Fix unplug in the reset path ---
commit cac1a79672cc7dc4544f4f69a02f107969842cb8
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Fix unplug in the reset path

We can't use disable_work_sync() if panthor_device_unplug() is called
from the reset work or we'll deadlock. Pass a from_reset_work bool to
the panthor_device_unplug() function and lower the disable_work_sync()
to a disable_work() in that case.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -189,13 +192,16 @@ static void panthor_device_reset_work(struct work_s=
truct *work)
>  	panthor_hw_soft_reset(ptdev);
>  	panthor_hw_l2_power_on(ptdev);
>  	panthor_mmu_post_reset(ptdev);
> -	ret =3D panthor_fw_post_reset(ptdev);
> +	if (ptdev->reset.fake_failure)
> +		ret =3D -EIO;
> +	else
> +		ret =3D panthor_fw_post_reset(ptdev);
>  	atomic_set(&ptdev->reset.pending, 0);
>  	panthor_sched_post_reset(ptdev, ret !=3D 0);
>  	drm_dev_exit(cookie);
> =20
>  	if (ret) {
> -		panthor_device_unplug(ptdev);
> +		panthor_device_unplug(ptdev, true);

[Severity: High]
This is a pre-existing issue, but does this sequence still leave an AB-BA
deadlock if driver removal runs concurrently with a failing reset work?

If CPU1 is running driver removal via panthor_remove(), it calls
panthor_device_unplug(..., false). This acquires ptdev->unplug.lock
earlier in the function.

If CPU2 is running panthor_device_reset_work(), it holds the SRCU
read lock via drm_dev_enter().

CPU1 then blocks in drm_dev_unplug() waiting for active SRCU readers.

CPU2 encounters a reset error, calls drm_dev_exit() (releasing SRCU),
and unblocks CPU1.

CPU1 continues in panthor_device_unplug() and blocks in
disable_work_sync() waiting for the reset work to finish (since it
holds ptdev->unplug.lock and from_reset_work is false):

CPU1:
panthor_remove()
  panthor_device_unplug(ptdev, false)
    mutex_lock(&ptdev->unplug.lock);
    ...
    drm_dev_unplug(&ptdev->base);
    ...
    disable_work_sync(&ptdev->reset.work);

Meanwhile, CPU2 proceeds to the error handling path and calls
panthor_device_unplug(ptdev, true). This attempts to acquire
ptdev->unplug.lock, but CPU1 already holds it:

CPU2:
panthor_device_reset_work()
  ...
  if (ret)
    panthor_device_unplug(ptdev, true)
      mutex_lock(&ptdev->unplug.lock);

Could this cause both threads to hang indefinitely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-panthor-un=
plug-fixes-v1-0-abbbd2d41b13@collabora.com?part=3D12
