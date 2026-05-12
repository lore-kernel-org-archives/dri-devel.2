Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B21CD4F35
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 517F610E9D5;
	Tue, 12 May 2026 08:59:39 +0000 (UTC)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338DE10E9D4
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:59:38 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7dbe0e914adso8209503a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 01:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778576377; x=1779181177;
 h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qry07HiLRpI4moE29vwWP3imXR+DsmNoqtYT3jSQb00=;
 b=MJB+uXaTiSSWAhKONy/s6W1kyxIcxW7Ejzq1ebdK/zWF6qqnCkAzGRcLIfGKHYqQND
 5yvsYTGIC2d04JLfQgs3d+QCYi+HjpDQPYS5xeE0/LIk7C647NvfVlfpAcYNa0CyC+6L
 WPzz0fky0Q4RYwqwIVyA048NeXQqleQwOitD4YGWFycWgLHndaW/qog4EbBLDd3q/7Wz
 GyZkao91v7rY88aSPJLL2RhP5uhXfZgbW0adSppa72UA2eNF6Lrz2hBY70tA3bKYfKuC
 Zp6DtqIJdMk6BdNqJ4n+JQhoSQgc1J83jQtDYDFLXt3YSenTLDtLU/JqjYGnoh7Vi3Ot
 voqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4rKE8+iRUPUhLvhZf/Bha2yIB1STdF45Tw2IICCMmY3iJbvBp4ALu6qI9JAV5cIq0THlZRvBGIJE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZJ0X1l/hBZ8dlPb1NGwkzPvZ8isxCf2nwAWfHVWjYxwGwspJf
 RmH42I08yC+Cirm/jiaT5bEa9YvDir7pKao2IkLCEZ6VcHF9BSkbgxWTrT/OEFbSSpDM0fbIF1E
 8uHBXDaooFf+ParMA69U75hpLc47DYaeIV/CPDuoFjkV2bRdqNMH3cG0rDXM=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:220d:b0:686:d107:2856 with SMTP id
 006d021491bc7-69998d5251dmr16156255eaf.51.1778576377421; Tue, 12 May 2026
 01:59:37 -0700 (PDT)
Date: Tue, 12 May 2026 01:59:37 -0700
In-Reply-To: <20260512-virtio-gpu_wait_event-v1-1-207eb4c1a69a@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a02ebf9.050a0220.14e4b1.0008.GAE@google.com>
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
 task
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
> wait_event() without timeout when waiting for virtqueue space. If the
> host device stops processing commands, these waits block indefinitely.
> Since callers may hold DRM locks, this can make the entire system
> unresponsive.
>
> Replace wait_event() with wait_event_timeout() using a 5-second timeout,
> consistent with the existing timeout pattern in the driver. On timeout,
> clean up and return -ENODEV, following the same error path as
> drm_dev_enter() failure.
>
> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 67865810a2e7..05e816a0ae0b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -396,7 +396,16 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>  	if (vq->num_free < elemcnt) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
>  		virtio_gpu_notify(vgdev);
> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
> +		if (!wait_event_timeout(vgdev->ctrlq.ack_queue,
> +					vq->num_free >= elemcnt,
> +					5 * HZ)) {
> +			/* The device did not respond */
> +			if (fence && vbuf->objs)
> +				virtio_gpu_array_unlock_resv(vbuf->objs);
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return -ENODEV;
> +		}
>  		goto again;
>  	}
>  
> @@ -566,7 +575,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->cursorq.qlock);
> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
> +		if (!wait_event_timeout(vgdev->cursorq.ack_queue,
> +					vq->num_free >= outcnt,
> +					5 * HZ)) {
> +			/* The device did not respond */
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return;
> +		}
>  		spin_lock(&vgdev->cursorq.qlock);
>  		goto retry;
>  	} else {
>
> ---
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> change-id: 20260512-virtio-gpu_wait_event-e0cdf8675b7c
>
> Best regards,
> -- 
> Ryosuke Yasuoka <ryasuoka@redhat.com>
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

