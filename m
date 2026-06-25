Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5603CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 03:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3589D10E15E;
	Thu, 25 Jun 2026 03:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TR+Zil1n";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAFB10E15E
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 03:13:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9487844384;
 Thu, 25 Jun 2026 03:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442A41F000E9;
 Thu, 25 Jun 2026 03:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782357202;
 bh=l6STr5j/hLQ7GOPpQjslrTjnZSZvuarhf4FnEqS5914=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TR+Zil1nUACkyPzebp1ccynWgj5FgMljyTb6Mtl3FOA4JM8+VkiTd5cyqJ6ky0afS
 urznvi3a5mGvfcKBb56EH5JFoWFsHsMlFWAW58es4RUjTY3LLEVuMNsp053BWSsKQB
 0+Ze7VQgRbNf0Y/UQ1pPD8Ao9u1BCIQ2ppEr4ck5UmengZLuPBTyQ1yC5Dk5/rwpQC
 qAcWI3v0FYXy6A5ui42yQ7yZKJaXbW0ueHWzT9pfaYa32FFzcv1unDx6cvn5++8Jzp
 5ivGoNuYVMUgS/diwcBDzYYAXJ5su7B6wW5AJ7Ek5jMG87csPLzJ9vVasHeUvdMztm
 wDxA0o6dKSzhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: fail init on display-info timeout
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625030202.82590-1-pengpeng@iscas.ac.cn>
References: <20260625030202.82590-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 03:13:21 +0000
Message-Id: <20260625031322.442A41F000E9@smtp.kernel.org>
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
- [High] Pending virtqueue buffers and dynamically allocated response struc=
tures are leaked on the timeout error path, causing a kmem_cache_destroy() =
warning.
- [High] Missing cancellation of workqueues in the timeout error path leads=
 to use-after-free, NULL pointer dereferences, and data races.
--

commit 81c055cf6da869ee835f7a7f8d32208780ea1dd0
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/virtio: fail init on display-info timeout

virtio_gpu_init() sends GET_DISPLAY_INFO when scanouts are present and
waits for display_info_pending to clear. If the response never arrives,
the wait result is ignored and probe still succeeds.

Return -ETIMEDOUT on display-info timeout. Because this happens after
virtio_device_ready(), reset the device and tear down modesetting before
using the existing vbuf and virtqueue cleanup path.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virti=
o/virtgpu_kms.c
> index cfde9f573df6e..31209bea97ae1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -262,11 +262,19 @@ int virtio_gpu_init(struct virtio_device *vdev, str=
uct drm_device *dev)
>  			virtio_gpu_cmd_get_edids(vgdev);
>  		virtio_gpu_cmd_get_display_info(vgdev);
>  		virtio_gpu_notify(vgdev);
> -		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
> -				   5 * HZ);
> +		if (!wait_event_timeout(vgdev->resp_wq,
> +					!vgdev->display_info_pending,
> +					5 * HZ)) {
> +			DRM_ERROR("timed out waiting for display info\n");
> +			ret =3D -ETIMEDOUT;
> +			goto err_ready;
> +		}
>  	}
>  	return 0;
> =20
> +err_ready:
> +	virtio_reset_device(vgdev->vdev);
> +	virtio_gpu_modeset_fini(vgdev);
>  err_scanouts:
>  	virtio_gpu_free_vbufs(vgdev);

[Severity: High]
Does this error path leak the pending virtqueue buffers and dynamically
allocated response structures?

The driver queues commands via virtio_gpu_cmd_get_display_info() and
virtio_gpu_cmd_get_edids() which allocate vbuf objects from the vgdev->vbufs
cache, as well as resp_buf via kzalloc_obj().

If wait_event_timeout() expires, the error path resets the device and
immediately calls virtio_gpu_free_vbufs(), which destroys the cache. Because
the commands are still in the virtqueue (and never detached/freed), will th=
is
trigger a 'Slab cache still has objects' warning from kmem_cache_destroy() =
and
permanently leak the dynamically allocated resp_buf pointers?

[Severity: High]
Does the cleanup path miss cancelling the virtqueue workqueues before the
device is destroyed?

Since virtio_device_ready() enables interrupts, if a virtqueue interrupt
fires just as the timeout expires, virtio_gpu_ctrl_ack() could schedule
vgdev->ctrlq.dequeue_work.

This timeout error path resets the device but doesn't cancel the asynchrono=
usly
scheduled workqueues.

Since the function returns -ETIMEDOUT, the caller (virtio_gpu_probe()) will
free the vgdev structure via drmm managed release. When the scheduled work
later executes, could it cause a use-after-free when accessing the freed
vgdev, or a NULL pointer dereference when attempting to call
kmem_cache_free(vgdev->vbufs, vbuf) where vgdev->vbufs was set to NULL by t=
he
error path?

>  err_vbufs:
>  	vgdev->vdev->config->del_vqs(vgdev->vdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625030202.8259=
0-1-pengpeng@iscas.ac.cn?part=3D1
