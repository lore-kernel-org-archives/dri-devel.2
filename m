Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E06ACD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B157B113BB4;
	Wed,  3 Jun 2026 01:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Gl5uc83V";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D05113BB4
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780449808; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bBWjLPFfdelhJTEUek5hgrcIY652n0pCiJZKXoHTmsza4ozTWARH4QsuU+4B1j8VTE6AxhpDYXz1kG+vSMuUZT19yZHLxbVnCjTJkAbO2D5Kupal7CEFEGqJjn1zl9hQs7gNlYqPIvtl69qODXT1G1t5WqaCeDcBT1Wikb1Oe/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780449808;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Gsiqncmb4zY7VJvDrEmBtRQt1RVNkK3UHOmJ6NPHrF0=; 
 b=i6okNbYwb7g6vN51VDaQzoaJlKMHyZrJu3ChuhS2sp+ZFySpYsvwxwQ5Jw1jA4wKOGDuv1IzRPWXq3v+Z0Z1WXfxpb9LXfNs1EH4ueHsFG/WJ/l0uccXvb6IYkQYydz6Uao9bKTHcIzP9C6RZisrhnXxXJadb29eDS/dIX3R4K4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780449808; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Gsiqncmb4zY7VJvDrEmBtRQt1RVNkK3UHOmJ6NPHrF0=;
 b=Gl5uc83VyVlHvKrbHkgOcEdAdATJ23NXzWTdzyOfdLhxavq4ataKGX9VXwcmjuA8
 G8pe2EIpqstIWBA1p4f+Hj5swtZp8NnITEfd3d4x/ehldfUOvxaAIH+QkIOOMUTmZfd
 2rZ+gxJzjkt3LE4mzU9Uj8JydfZ/Eu0h7vmBxP30=
Received: by mx.zohomail.com with SMTPS id 1780449806177347.8316797280188;
 Tue, 2 Jun 2026 18:23:26 -0700 (PDT)
Message-ID: <16ffe1bc-46ca-45ae-a14f-667bf59a119b@collabora.com>
Date: Wed, 3 Jun 2026 04:23:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260601-virtio-gpu_wait_event-v3-1-89530517a98a@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260601-virtio-gpu_wait_event-v3-1-89530517a98a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

On 6/1/26 10:53, Ryosuke Yasuoka wrote:
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
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> Changes in v3:
> - Remove Reported-by and Closes tag from commit msg because they are not
>   related to this fix.
> - Link to v2: https://lore.kernel.org/r/20260521-virtio-gpu_wait_event-v2-1-5796b3a71d03@redhat.com
> 
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
> index 2f3531950aa4..5f7bb6cc6ba7 100644
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
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> change-id: 20260518-virtio-gpu_wait_event-5aa060754f12
> 
> Best regards,

Applied to misc-next, thanks!

-- 
Best regards,
Dmitry
