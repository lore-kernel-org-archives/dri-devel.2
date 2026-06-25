Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A830CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C170B10E212;
	Thu, 25 Jun 2026 12:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A7tVnEW/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2CE10E212
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:56:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2255C4382A;
 Thu, 25 Jun 2026 12:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4C51F000E9;
 Thu, 25 Jun 2026 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782392161;
 bh=BYEWWCm7/Qt/Xvxb80GnWbVgRMUkxitHiEBBhEGegoo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A7tVnEW/glHTvMvWMGz/+FUx8UBudnR0ex2gdTfW3zUTzuc+/xoOyPVLQMohfTTVd
 PUDKNVAepcjBh8t8Kyu1E/ZNPPdyMJ0kCzC8t6gi3H04GliZyejdjVLu5tySeAACLD
 6rUu1iqPkkaG7TtXGTFC0UK66aRMZKTzM+Unq0Y670lEWGcPE+ltGQmZCc4VR+Glp5
 6UFh1W9w0+s43ktwrw7UoBcLLN5jDicwnbhHbpdjDU6rW8tHl9c1fX2ntjAt72EWbX
 k+w7dQi2tLaK63EUAyzlmDs/gylpInwyUT/7mLqhJI78kSEgHf2x8b6XcfAgndtycO
 SbTzTFA+/vJdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] drm/panthor: Fix UAF on works queued to
 panthor_cleanup_wq
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-misc-fixes-v1-3-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-3-b67ed973fea6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 12:56:00 +0000
Message-Id: <20260625125600.DA4C51F000E9@smtp.kernel.org>
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
- [High] Calling `drain_workqueue()` on a globally shared workqueue drops n=
on-chained works from all other devices, leading to resource leaks.

Pre-existing issues:
- [High] The patch fails to prevent the Use-After-Free because `drain_workq=
ueue()` does not permanently prevent new works from being queued after unpl=
ug.
--

commit a8d1c4b2d56a32fc02ddadc07ead22f7dc20b168
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Fix UAF on works queued to panthor_cleanup_wq

This patch adds a drain_workqueue() call in panthor_device_unplug() to
ensure cleanup works are executed before the panthor device is destroyed.

Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-=
0-8836a74e0ef9@collabora.com?part=3D2

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 0b25abebb803c..a0774e28aa94d 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -101,6 +101,11 @@ void panthor_device_unplug(struct panthor_device *pt=
dev)
>  	panthor_gpu_unplug(ptdev);
>  	panthor_pwr_unplug(ptdev);
> =20
> +	/* Make sure works queued to panthor_cleanup_wq are executed
> +	 * before the device is destroyed.
> +	 */
> +	drain_workqueue(panthor_cleanup_wq);

[Severity: High]
Since panthor_cleanup_wq is a global workqueue shared by all panthor devices
(allocated once in panthor_init()), does calling drain_workqueue() here
cause issues for other active panthor devices?

drain_workqueue() temporarily sets the __WQ_DRAINING flag on the workqueue.
If any other active panthor device attempts to queue work while this flag
is set, __queue_work() will hit a WARN_ONCE and silently discard the
non-chained work.

Will this break cleanup for all other panthor devices system-wide, causing
resource leaks (e.g., VMs, BOs, groups) that can lead to system degradation?

[Severity: High]
This is a pre-existing issue, but does this actually prevent the
Use-After-Free?

drain_workqueue() only waits for currently queued works to finish and then
clears the __WQ_DRAINING flag before returning.

If a userspace process holds an open DRM file descriptor during a device
hot-unplug, the ptdev isn't freed immediately. When the process later closes
the FD, drm_release() will destroy the group pool and call group_release().

At this point:

drivers/gpu/drm/panthor/panthor_sched.c:group_release() {
    ...
    queue_work(panthor_cleanup_wq, &group->release_work);
    ...
}

This successfully queues new asynchronous cleanup works because __WQ_DRAINI=
NG
has already been cleared.

When drm_release() then drops the final device reference, synchronously
freeing ptdev, the newly queued group_release_work will execute
asynchronously and access the freed ptdev, triggering the exact
Use-After-Free this was intended to fix.

> +
>  	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
>  	pm_runtime_put_sync_suspend(ptdev->base.dev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-mi=
sc-fixes-v1-0-b67ed973fea6@collabora.com?part=3D3
