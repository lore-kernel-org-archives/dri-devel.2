Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A976CDE00C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C62B10EA15;
	Thu, 25 Jun 2026 12:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vp7PtQ8b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14DBF10E9FC
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:59:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F012C443B3;
 Thu, 25 Jun 2026 12:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03D91F00A3E;
 Thu, 25 Jun 2026 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782392390;
 bh=z4LyccaNUqgtxnU3ZSm86kZKqPvA2Gy3yHNQE3bF9tk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vp7PtQ8bLl32HjDQuWNMKqIsR1kWKe0Qpl1VvWjyErG6QxJ30tg6giYUFuFpv9bQx
 NPJAV3qDWmK834IwibjU/bRiUNVGFgKKrY2ivOIiAHf9LVxYfRiiXxZb843g0wc6HA
 1bwsLUJuQtJGCHWNYiQkQd6Njav11eXHEfzGMraiQH/i9pvkwB5vOK1GM9zyNQ8k8W
 8rLOd41gGQyQ8Hw0rMl06RMrfaT1VzKEL7n0OKzYizv12bwsdUtISrQcfypP7NIC1q
 OtMLy6cLllNn49ozWdselGTBubYZm0IiqslXCDt7qFkmb+8mt0KRu6/me3SfxtBEdm
 5RDnw/8HJYEcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] drm/panthor: Keep the reset work disabled until
 everything is initialized
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-misc-fixes-v1-2-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-2-b67ed973fea6@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 12:59:49 +0000
Message-Id: <20260625125950.B03D91F00A3E@smtp.kernel.org>
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
- [High] Disabling the reset work during initialization causes asynchronous=
 reset requests to be silently dropped, permanently wedging the GPU by leav=
ing the pending flag stuck at 1.

Pre-existing issues:
- [High] The reset work remains enabled during the error teardown path if `=
drm_dev_register` fails, allowing concurrent reset work to access sub-compo=
nents as they are destroyed.
--

commit d88d89caab294e4f6ec4a893f2e535ca95fb0890
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Keep the reset work disabled until everything is initialized

The reset work will sub-component reset helpers, which might not be
ready if the reset happens during initialization, leading to NULL
pointer dereferences or worse. Avoid that by keeping the reset work
disabled while we're initializing those sub-components.

Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-=
0-8836a74e0ef9@collabora.com?part=3D4

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -207,6 +207,7 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	*dummy_page_virt =3D 1;
> =20
>  	INIT_WORK(&ptdev->reset.work, panthor_device_reset_work);
> +	disable_work(&ptdev->reset.work);
>  	ptdev->reset.wq =3D alloc_ordered_workqueue("panthor-reset-wq", 0);
>  	if (!ptdev->reset.wq)
>  		return -ENOMEM;

[ ... ]

> @@ -285,6 +286,9 @@ int panthor_device_init(struct panthor_device *ptdev)
> =20
>  	panthor_gem_init(ptdev);
> =20
> +	/* Now that everything is initialized, we can enable the reset work. */
> +	enable_work(&ptdev->reset.work);
> +
>  	/* ~3 frames */
>  	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
>  	pm_runtime_use_autosuspend(ptdev->base.dev);

[Severity: High]
If a reset is requested while the work is disabled (e.g., due to a
firmware timeout or early MMU fault during driver probe), does the device
become permanently wedged?

Looking at panthor_device_schedule_reset(), it relies on queue_work()
succeeding after atomic_cmpxchg() sets the pending flag:

panthor_device_schedule_reset() {
    if (!atomic_cmpxchg(&ptdev->reset.pending, 0, 1) &&
        atomic_read(&ptdev->pm.state) =3D=3D PANTHOR_DEVICE_PM_STATE_ACTIVE=
) {
        queue_work(ptdev->reset.wq, &ptdev->reset.work);
    }
}

Because the work is disabled via disable_work() earlier, queue_work()
fails and the work is never queued.

When enable_work() is called here, it decrements the disable count but
does not requeue the dropped work or clear the pending flag. Because
ptdev->reset.pending remains 1, will all future reset requests fail the
atomic_cmpxchg() check, leaving the GPU unable to recover?

[Severity: High]
This isn't a bug introduced by this patch, but if drm_dev_register()
fails shortly after this, does the reset work remain enabled during the
teardown sequence?

If drm_dev_register() fails, the driver jumps to err_disable_autosuspend
to destroy sub-components sequentially. Because drm_dev_unplug() is not
called in this explicit error path, dev->unplugged remains false.

If a concurrent FW timeout or fault triggers during this teardown sequence,
any concurrently scheduled reset work will pass the drm_dev_enter() check
in panthor_device_reset_work():

panthor_device_reset_work() {
    if (!drm_dev_enter(&ptdev->base, &cookie))
        return;

    panthor_sched_pre_reset(ptdev);
    panthor_fw_pre_reset(ptdev, true);
    ...
}

Could this cause the reset work to interact with sub-components that are
actively being destroyed, leading to use-after-free or NULL pointer
dereferences?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-mi=
sc-fixes-v1-0-b67ed973fea6@collabora.com?part=3D2
