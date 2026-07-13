Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD22C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E414C10E602;
	Mon, 13 Jul 2026 13:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T6UFHAKr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34D610E9DD
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:23:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 17C9E601DE;
 Mon, 13 Jul 2026 13:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9A01F00A3A;
 Mon, 13 Jul 2026 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783949001;
 bh=u1I7KAAFJztmcwbIAGF1z+v8qO6GPhxde8Gm82PqgUk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T6UFHAKr6eM3WFJhgjzHITorm4bsPfTZA3nCVyFAYVRcJ7jba7PV8xJ3T5hIKhpWA
 hMh2XxEflDjBJA2J7uUfdcT5CxaFDKOP2EoQdrkb3kBBkPLuYjgBy/NLCeMXRs5V/n
 hZVJ5U9gqqlpStNMZ0m4EUEd6EV+0Rs5QTedtV+p9jWwVX2okAgbsM3R6s0DPOZuBa
 0R/7gSc6FpD2cpejWvPw1suH6NsdXMWj0szNmcYpmnYHHI0s3qpPeF83FGbyEbX2+y
 rdRBAtNfYS7uNwZnH7RjQKF7y4eaLjCaqOPbdAPbtD8NTeRujjMxdMpWVGseHpwRv8
 bR7S0vjBQYG1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by
 removing hotplug from dequeue worker
To: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
References: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:23:20 +0000
Message-Id: <20260713132321.9F9A01F00A3A@smtp.kernel.org>
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
- [High] Moving the acknowledgment of the VIRTIO_GPU_EVENT_DISPLAY event (`=
events_clear` write) to the end of the work function, after a potential 5-s=
econd `wait_event_timeout`, introduces a race window where subsequent hardw=
are hotplug events can be lost.
- [High] Userspace permanently misses hotplug events if the virtqueue respo=
nse takes longer than 5 seconds.
- [High] The patch introduces a 5-second stall during device removal or res=
ource exhaustion because it unconditionally waits for a response without ch=
ecking if the command was successfully queued.

Pre-existing issues:
- [High] Flushing virtqueue dequeue workers before resetting the device lea=
ves a window for new interrupts to reschedule the workers, leading to Use-A=
fter-Free on teardown.
--

--- Patch [1]: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by re=
moving hotplug from dequeue worker ---
commit 22579633647788efae56c2e855be2b742b38fc3c
Author: Ryosuke Yasuoka <ryasuoka@redhat.com>

    drm/virtio: fix deadlock in display_info_cb by removing hotplug from de=
queue worker
   =20
    A probe-time deadlock can occur between the dequeue worker and
    drm_client_register(). During probe, drm_client_register() holds
    clientlist_mutex and calls the fbdev hotplug callback, which triggers an
    atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
    waiting for virtqueue space.

    Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e4=
5c1c6e549453f224
    Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7=
baf376cc873a922e
    Link: https://lore.kernel.org/r/20260630-virtiogpu_syzbot-v1-1-0aa06630=
750e@redhat.com

> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virti=
o/virtgpu_kms.c
> index cfde9f573df6e..b4329f28e9766 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -49,7 +49,10 @@ static void virtio_gpu_config_changed_work_func(struct=
 work_struct *work)
>  				virtio_gpu_cmd_get_edids(vgdev);
>  			virtio_gpu_cmd_get_display_info(vgdev);
>  			virtio_gpu_notify(vgdev);
> -			drm_helper_hpd_irq_event(vgdev->ddev);
> +			wait_event_timeout(vgdev->resp_wq,
> +					   !vgdev->display_info_pending,
> +					   5 * HZ);
> +			drm_kms_helper_hotplug_event(vgdev->ddev);

[Severity: High]
If virtio_gpu_cmd_get_display_info() fails to queue the buffer (for example,
if drm_dev_enter() fails during a hot-unplug), virtio_gpu_queue_ctrl_buffer=
()
will return an error but display_info_pending remains true.

Does this cause wait_event_timeout() to stall for the full 5 seconds during
device removal?

[Severity: High]
If the host takes longer than 5 seconds to respond, wait_event_timeout() wi=
ll
expire and drm_kms_helper_hotplug_event() will fire using the old connector
data.

When the delayed response eventually arrives, the callback in
virtio_gpu_cmd_get_display_info_cb() updates the internal driver state but =
no
longer triggers a hotplug event because it was removed in this patch.

Will this leave userspace permanently out of sync with the hardware state?

>  		}
>  		events_clear |=3D VIRTIO_GPU_EVENT_DISPLAY;
>  	}

[Severity: High]
Does moving the wait_event_timeout() before the virtio_cwrite_le() call ope=
n a
race condition?

If a hardware hotplug event is asserted while this function is sleeping, the
subsequent write of events_clear to the device config space will clear the
newly asserted event without processing it, causing the event to be lost.

[ ... ]

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index c8b9475a7472e..e5e1af8b8e8a0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -840,9 +840,6 @@ static void virtio_gpu_cmd_get_display_info_cb(struct=
 virtio_gpu_device *vgdev,
>  	vgdev->display_info_pending =3D false;
>  	spin_unlock(&vgdev->display_info_lock);
>  	wake_up(&vgdev->resp_wq);
> -
> -	if (!drm_helper_hpd_irq_event(vgdev->ddev))
> -		drm_kms_helper_hotplug_event(vgdev->ddev);
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free duri=
ng
device removal in virtio_gpu_deinit():

drivers/gpu/drm/virtio/virtgpu_kms.c:virtio_gpu_deinit() {
    ...
	flush_work(&vgdev->config_changed_work);
	virtio_reset_device(vgdev->vdev);
    ...
}

Are we at risk of rescheduling workers if a virtqueue interrupt or config
change fires immediately after flush_work() returns, but before
virtio_reset_device() stops the interrupts? If the driver frees vgdev
shortly after, the rescheduled worker might access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-virtiogpu_=
syzbot-v2-1-2958fa37d46d@redhat.com?part=3D1
