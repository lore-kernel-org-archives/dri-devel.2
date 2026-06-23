Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D97CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C8410EC91;
	Tue, 23 Jun 2026 20:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hET9RZbT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED9810EC8E
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:20:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8856C4091C;
 Tue, 23 Jun 2026 20:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED321F000E9;
 Tue, 23 Jun 2026 20:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782246049;
 bh=c8nseoNIV5gZ3hdWNPvbbFq+a0wMTbH76ovYSYd8KH4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hET9RZbTzGsltX/blv+JB6AW/VzZlX/qZjqQOTxGS3bNq+PoOj9ZK6kIF4fmz6ip8
 lWl1rxAtuWDFcSjuEvispZ0dbRYv5fiXsAgtYQfFWOuTJVHiVNscQgvkAoORsIGH/V
 rLpDMyKkeocYR3PvtP6CSV9hmY4iCn4okqdaZas/nr6OTRA+PfhmLJwknjXSB2sR+M
 U6OzDApZTGfCtVcXqSZK4nLikl6UCvq9vD2ZgcN3okMNBeKml2+4SNe62a6VqAB5bK
 PNgYPjv/ksVp89iZI2Rob3gzcTcUXUhZBBcyjvxwQfe2ameyNnbEYOXVPswC/yQhoE
 FKirUBFJpJtAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: warn when virtqueue has no free space for
 too long
To: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-virtiogpu_add_timeout-v1-1-dc36cef609d9@redhat.com>
References: <20260618-virtiogpu_add_timeout-v1-1-dc36cef609d9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:20:48 +0000
Message-Id: <20260623202049.4ED321F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Replacing `wait_event()` with a 5-second `wait_event_timeout()` lo=
op defeats the kernel's hung task detector for this wait, breaking automate=
d recovery mechanisms.
- [Medium] The `wait_event_timeout()` loop will generate severe log spam if=
 multiple userspace threads block concurrently.

Pre-existing issues:
- [High] The `virtio_gpu_object_array` (`vbuf->objs`) and its contained GEM=
 objects are leaked on error paths where `virtio_gpu_queue_ctrl_sgs()` fail=
s to queue the buffer.
- [High] The virtio-gpu driver sleeps in plane atomic update callbacks, vio=
lating DRM subsystem guidelines against sleeping in atomic context.
--

commit 736ae781cca53398969e63f0d5a23d6e3f738db0
Author: Ryosuke Yasuoka <ryasuoka@redhat.com>

drm/virtio: warn when virtqueue has no free space for too long

This commit replaces the bare wait_event() in virtqueue command submission
with a wait_event_timeout() loop. The loop prints a warning every 5 seconds
while the virtqueue remains full to help identify unresponsive host devices.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index 68d097ad9d1d0..a546130d3b6a5 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -410,8 +410,13 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_g=
pu_device *vgdev,
>  	if (vq->num_free < elemcnt) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
>  		virtio_gpu_notify(vgdev);
> -		wait_event(vgdev->ctrlq.ack_queue,
> -			   vq->num_free >=3D elemcnt || vgdev->vqs_released);
> +		while (!wait_event_timeout(vgdev->ctrlq.ack_queue,
> +					   vq->num_free >=3D elemcnt ||
> +					   vgdev->vqs_released,
> +					   5 * HZ) && !vgdev->vqs_released)

[Severity: High]
Does this 5-second polling loop evade the kernel's hung task detector?

The kernel's khungtaskd detects tasks stuck in TASK_UNINTERRUPTIBLE by
verifying their context switch count does not change over the configured
timeout. By waking the task up every 5 seconds, it will continually context
switch, causing khungtaskd to see a changing context switch count. Will this
prevent the system from ever flagging these tasks as hung or triggering
automatic recovery panics?

> +			DRM_WARN("ctrlq waiting for host: no free space for %d secs\n",
> +				 5);

[Severity: Medium]
Could this cause severe kernel log spam if multiple userspace threads are
blocked concurrently?

Since the 5-second timeout and warning are local to each thread's wait loop,
if multiple threads attempt to submit commands while the host is unresponsi=
ve,
will each thread emit a DRM_WARN message every 5 seconds?

> +
>  		/*
>  		 * Set by virtio_gpu_release_vqs() to unblock
>  		 * synchronize_srcu() wait in drm_dev_unplug().

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak the
virtio_gpu_object_array and its pinned GEM objects?

When vgdev->vqs_released is true, the code below this comment calls
free_vbuf(vgdev, vbuf) and returns -ENODEV. However, free_vbuf() only frees
the buffer and does not unreference or free vbuf->objs. Since the buffer was
never queued, the completion callback that normally cleans up vbuf->objs wi=
ll
never run.

[ ... ]
> @@ -592,8 +597,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gp=
u_device *vgdev,
>  	ret =3D virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>  	if (ret =3D=3D -ENOSPC) {
>  		spin_unlock(&vgdev->cursorq.qlock);
> -		wait_event(vgdev->cursorq.ack_queue,
> -			   vq->num_free >=3D outcnt || vgdev->vqs_released);
> +		while (!wait_event_timeout(vgdev->cursorq.ack_queue,
> +					   vq->num_free >=3D outcnt ||
> +					   vgdev->vqs_released,
> +					   5 * HZ) && !vgdev->vqs_released)

[Severity: High]
This isn't a bug introduced by this patch, but does waiting here violate DRM
subsystem atomic context rules?

This function is reached via the plane atomic update callback:

virtio_gpu_cursor_plane_update() ->
  virtio_gpu_cursor_ping() ->
    virtio_gpu_queue_cursor()

DRM plane atomic update callbacks execute in atomic context where sleeping
functions are forbidden. Using wait_event_timeout() (or previously
wait_event()) sets the task state to TASK_UNINTERRUPTIBLE and schedules out.
Could this scheduling while atomic cause system instability?

> +			DRM_WARN("cursorq waiting for host: no free space for %d secs\n",
> +				 5);
> +
>  		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>  		if (vgdev->vqs_released) {
>  			free_vbuf(vgdev, vbuf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-virtiogpu_=
add_timeout-v1-1-dc36cef609d9@redhat.com?part=3D1
