Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E855CCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353E210E54A;
	Thu, 21 May 2026 19:02:58 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79D210E532
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:02:56 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7dcc8f071b3so16983043a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779390176; x=1779994976;
 h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
 :date:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0krv0nUw1/ioDEFf9ZMQESopIiNp/OLFryuhF9m9kKI=;
 b=L1p2XLfIs/EPaH9nE4Gp0NuU6YVt7dIXROo46sIOBtb+5R32IZDRlxyicLODrzJEf8
 zdTsbr+7m6Db7+qQcFMhzZqqKKrDM3Q7fO8gm+y/Ubw7TrfPwaMDkXj0g6DYCw7zM1//
 cjwZV/mXG8svUvVtNgZtot9vvL+g3NfN13QcCixLHH03hNxTeN1wp63O7KUAVAJ65eXg
 sRm7Quz3OPvLWTlFztAqX+eIhFQoisf3hhWdiZAkTZviVYFcnOwyCYS48oOY81hgzURJ
 mLbn+5GwP9VjlV++yLYLSDGB4jiSGCej7gIKOtOiIfEiwyolg1Lg0qUIDGaMWbCwv9Qb
 svMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hlMa36/bn/d+61KBKZI5tUbrPnwz8LSm3ZYx49eyFh1OyoKIkqhW7wUpCKLNFDADxwJ91izafKy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxomceI8WAaHNeHfoAz9XnOclq3FtJplyWykMaB3qyM2qeXpY3C
 3jUuDz47Lc3nmoRaaQURb6cieQcihxucFVLd5zQJuUAX1nfPIRXjioOSDRGOgTGpgrO0htpRr7C
 mI+4/liI2PRzq9F4YpubQ/MpQOxG6wnXNjDu6+j3OfsjyIDmtcPxxnNlAg7E=
MIME-Version: 1.0
X-Received: by 2002:a05:6830:2404:b0:7e3:9d19:1e47 with SMTP id
 46e09a7af769-7e5fef3460dmr257848a34.25.1779390176067; Thu, 21 May 2026
 12:02:56 -0700 (PDT)
Date: Thu, 21 May 2026 12:02:56 -0700
In-Reply-To: <4bc3709f-21bc-49f5-8fcf-972dec1397f7@collabora.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0f56e0.050a0220.31b25.0001.GAE@google.com>
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: dmitry.osipenko@collabora.com
Cc: airlied@redhat.com, dmitry.osipenko@collabora.com, 
 dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
 kraxel@redhat.com, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
 ryasuoka@redhat.com, simona@ffwll.ch, tzimmermann@suse.de, 
 virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> 21.05.2026 05:19, Ryosuke Yasuoka =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>> wait_event() without any abort condition when waiting for virtqueue
>> space. If the host device stops processing commands, these waits block
>> indefinitely inside a drm_dev_enter/exit() critical section. Since
>> drm_dev_unplug(), which is called in device removal and system shutdown
>> call path, blocks on synchronize_srcu() until all critical sections
>> complete, device removal and system shutdown also hang.
>>=20
>> Add a vqs_released flag to virtio_gpu_device and include it in the
>> wait_event() condition. Set the flag and wake up both queues in a new
>> virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
>> virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, the
>> wait returns immediately and the command is aborted, following the same
>> cleanup path as drm_dev_enter() failure.
>>=20
>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.a=
ppspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e45=
c1c6e549453f224
>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.a=
ppspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7b=
af376cc873a922e
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
>> Changes in v2:
>> - Update the commit message.
>> - Replace wait_event_timeout() with wait_event() using a compound
>> condition that includes a new vqs_released flag.
>> - Add virtio_gpu_release_vqs() helper to set the flag and wake up
>> both queues, called before drm_dev_unplug() in remove and shutdown
>> paths.
>> - Remove the hardcoded 5-second timeout. Recovery is now driven by
>> the driver flag instead of an arbitrary timeout value.
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
>>  3 files changed, 37 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virt=
io/virtgpu_drv.c
>> index a5ce96fb8a1d..e4fe5e0780f9 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> @@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device *=
vdev)
>>  	return ret;
>>  }
>> =20
>> +/*
>> + * Release pending virtqueue waits so the drm_dev_enter/exit() critical
>> + * sections complete before drm_dev_unplug() blocks on synchronize_srcu=
().
>> + */
>> +static void virtio_gpu_release_vqs(struct drm_device *dev)
>> +{
>> +	struct virtio_gpu_device *vgdev =3D dev->dev_private;
>> +
>> +	vgdev->vqs_released =3D true;
>> +	wake_up_all(&vgdev->ctrlq.ack_queue);
>> +	wake_up_all(&vgdev->cursorq.ack_queue);
>> +}
>> +
>>  static void virtio_gpu_remove(struct virtio_device *vdev)
>>  {
>>  	struct drm_device *dev =3D vdev->priv;
>> =20
>> +	virtio_gpu_release_vqs(dev);
>>  	drm_dev_unplug(dev);
>>  	drm_atomic_helper_shutdown(dev);
>>  	virtio_gpu_deinit(dev);
>> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device=
 *vdev)
>>  {
>>  	struct drm_device *dev =3D vdev->priv;
>> =20
>> +	virtio_gpu_release_vqs(dev);
>>  	/* stop talking to the device */
>>  	drm_dev_unplug(dev);
>>  }
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virt=
io/virtgpu_drv.h
>> index f17660a71a3e..0bd69a40857e 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>> =20
>>  	struct virtio_gpu_queue ctrlq;
>>  	struct virtio_gpu_queue cursorq;
>> +	bool vqs_released;
>>  	struct kmem_cache *vbufs;
>> =20
>>  	atomic_t pending_commands;
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virti=
o/virtgpu_vq.c
>> index 67865810a2e7..8057a9b7356d 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_=
gpu_device *vgdev,
>>  	if (vq->num_free < elemcnt) {
>>  		spin_unlock(&vgdev->ctrlq.qlock);
>>  		virtio_gpu_notify(vgdev);
>> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >=3D elemcnt);
>> +		wait_event(vgdev->ctrlq.ack_queue,
>> +			   vq->num_free >=3D elemcnt || vgdev->vqs_released);
>> +		/*
>> +		 * Set by virtio_gpu_release_vqs() to unblock
>> +		 * synchronize_srcu() wait in drm_dev_unplug().
>> +		 */
>> +		if (vgdev->vqs_released) {
>> +			if (fence && vbuf->objs)
>> +				virtio_gpu_array_unlock_resv(vbuf->objs);
>> +			free_vbuf(vgdev, vbuf);
>> +			drm_dev_exit(idx);
>> +			return -ENODEV;
>> +		}
>>  		goto again;
>>  	}
>> =20
>> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_g=
pu_device *vgdev,
>>  	ret =3D virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>  	if (ret =3D=3D -ENOSPC) {
>>  		spin_unlock(&vgdev->cursorq.qlock);
>> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >=3D outcnt);
>> +		wait_event(vgdev->cursorq.ack_queue,
>> +			   vq->num_free >=3D outcnt || vgdev->vqs_released);
>> +		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>> +		if (vgdev->vqs_released) {
>> +			free_vbuf(vgdev, vbuf);
>> +			drm_dev_exit(idx);
>> +			return;
>> +		}
>>  		spin_lock(&vgdev->cursorq.qlock);
>>  		goto retry;
>>  	} else {
>
> What about other wait_event in the driver? Why only these?
>
> --=20
> Best regards,
> Dmitry

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

