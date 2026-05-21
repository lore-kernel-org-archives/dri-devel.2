Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2D6CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 02:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4730310F1AD;
	Thu, 21 May 2026 02:19:55 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DEC410F1AB
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 02:19:50 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7dbb6b95836so15691597a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 19:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779329990; x=1779934790;
 h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CzDENP6IjMuE+dFgbF5yX5xWJgBQqW+B+xC/YsKt82Y=;
 b=j+D3R4FwLD08mTCQXyCA4mKx+Vh2shAK1TtMVfOcQaWxr0QERwX5Gt/HhNSpSq9lxt
 5iLIqSkIQ/Agp1pRxc9TQNeeXPocSHKBufS1PxV8kCT7fgXC2ol83S7Imh70Ae0e8v7j
 7DQTbMoN4Ai11f+BwajEULMuV+T72GG5SCGH0p1Sxj4BSAneOKl8yG4dnzjYVmKsPjVy
 Tka/T/U3i99QKcTlJELuxQEPdV/9WfOnbx6zYlwk9wl8wieptoFJtbu162ao/pQ5zsc7
 tx4QfNF1nocKh/KEgOBmIGTHvNf1espVlhVp995H+sxqnRXHemym2vpIq/vjG3dokWfO
 wQmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82BPHL24J3nWoWUPc9ZfcTjFs7utBKQt1lEldsdL93ZNKwZFUFncs/NQ7vvNlD6l/yOlitUBHROAE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWG35y9OFUM59BPj5z1R0WAsQBD0vBWc+NlYqMVPDjPRnRoGEq
 1pPROosxYIHp+7pax24kq5hux4FzbSmbkMUhDjobqYEBGfzHXKicWFdZMo3Ize5m52jSSX47f08
 0N+U8ikU88jiZIcFZ5y7bSKWuEVb6C6vN+r+WYTVbCEqZJSup5wq+6kdhXlM=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b02:b0:696:2a7c:40be with SMTP id
 006d021491bc7-69d6edccba1mr426926eaf.10.1779329989817; Wed, 20 May 2026
 19:19:49 -0700 (PDT)
Date: Wed, 20 May 2026 19:19:49 -0700
In-Reply-To: <20260521-virtio-gpu_wait_event-v2-1-5796b3a71d03@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0e6bc5.a00a0220.396cf0.0001.GAE@google.com>
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: ryasuoka@redhat.com
Cc: airlied@redhat.com, dmitry.osipenko@collabora.com, 
 dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
 kraxel@redhat.com, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
 ryasuoka@redhat.com, simona@ffwll.ch, tzimmermann@suse.de, 
 virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
> wait_event() without any abort condition when waiting for virtqueue
> space. If the host device stops processing commands, these waits block
> indefinitely inside a drm_dev_enter/exit() critical section. Since
> drm_dev_unplug(), which is called in device removal and system shutdown
> call path, blocks on synchronize_srcu() until all critical sections
> complete, device removal and system shutdown also hang.
>
> Add a vqs_released flag to virtio_gpu_device and include it in the
> wait_event() condition. Set the flag and wake up both queues in a new
> virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
> virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, the
> wait returns immediately and the command is aborted, following the same
> cleanup path as drm_dev_enter() failure.
>
> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> Changes in v2:
> - Update the commit message.
> - Replace wait_event_timeout() with wait_event() using a compound
> condition that includes a new vqs_released flag.
> - Add virtio_gpu_release_vqs() helper to set the flag and wake up
> both queues, called before drm_dev_unplug() in remove and shutdown
> paths.
> - Remove the hardcoded 5-second timeout. Recovery is now driven by
> the driver flag instead of an arbitrary timeout value.
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
>  3 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index a5ce96fb8a1d..e4fe5e0780f9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
>  	return ret;
>  }
>  
> +/*
> + * Release pending virtqueue waits so the drm_dev_enter/exit() critical
> + * sections complete before drm_dev_unplug() blocks on synchronize_srcu().
> + */
> +static void virtio_gpu_release_vqs(struct drm_device *dev)
> +{
> +	struct virtio_gpu_device *vgdev = dev->dev_private;
> +
> +	vgdev->vqs_released = true;
> +	wake_up_all(&vgdev->ctrlq.ack_queue);
> +	wake_up_all(&vgdev->cursorq.ack_queue);
> +}
> +
>  static void virtio_gpu_remove(struct virtio_device *vdev)
>  {
>  	struct drm_device *dev = vdev->priv;
>  
> +	virtio_gpu_release_vqs(dev);
>  	drm_dev_unplug(dev);
>  	drm_atomic_helper_shutdown(dev);
>  	virtio_gpu_deinit(dev);
> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device *vdev)
>  {
>  	struct drm_device *dev = vdev->priv;
>  
> +	virtio_gpu_release_vqs(dev);
>  	/* stop talking to the device */
>  	drm_dev_unplug(dev);
>  }
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index f17660a71a3e..0bd69a40857e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>  
>  	struct virtio_gpu_queue ctrlq;
>  	struct virtio_gpu_queue cursorq;
> +	bool vqs_released;
>  	struct kmem_cache *vbufs;
>  
>  	atomic_t pending_commands;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 67865810a2e7..8057a9b7356d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>  	if (vq->num_free < elemcnt) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
>  		virtio_gpu_notify(vgdev);
> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
> +		wait_event(vgdev->ctrlq.ack_queue,
> +			   vq->num_free >= elemcnt || vgdev->vqs_released);
> +		/*
> +		 * Set by virtio_gpu_release_vqs() to unblock
> +		 * synchronize_srcu() wait in drm_dev_unplug().
> +		 */
> +		if (vgdev->vqs_released) {
> +			if (fence && vbuf->objs)
> +				virtio_gpu_array_unlock_resv(vbuf->objs);
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return -ENODEV;
> +		}
>  		goto again;
>  	}
>  
> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->cursorq.qlock);
> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
> +		wait_event(vgdev->cursorq.ack_queue,
> +			   vq->num_free >= outcnt || vgdev->vqs_released);
> +		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
> +		if (vgdev->vqs_released) {
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return;
> +		}
>  		spin_lock(&vgdev->cursorq.qlock);
>  		goto retry;
>  	} else {
>
> ---
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> change-id: 20260518-virtio-gpu_wait_event-5aa060754f12
>
> Best regards,
> -- 
> Ryosuke Yasuoka <ryasuoka@redhat.com>
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

