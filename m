Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EAFCA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B513510E6A6;
	Wed,  7 Oct 2026 21:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZQJER1hU";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F8F10E6A6
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 21:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791409482; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VmLYWhSzgnezPjGJ4M9d9Rb5GHvw+4+TblzvznrsbQX5MloUM21hCzBhtbMDXDddLQS8xUEl/VNOAryu2//yQcXqCb85tl0p36tjKryb3fGS+GNaQPzhnPsLC57a0tNPHEf0EPxJuMrni/uD2BUvU8L8tFA0u1t335iCzndA76s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791409482;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kGvUDiLie0dPMCDwrW6Vkkj/cP8ggVC9Hknrr+6OM28=; 
 b=jLonqA0kH/5mo4SVt/L8rrQMvJtIp8D1PqZR6/pdF+21BipE1SCBRBKgN9E0qU3bQkmPGk/iROJK5XDCi5txB4D6JiH4HvUfn6Qr5pOBje9/FXSkXDV3jDGZc+u4oiGYSNV05IUhFZQ1In5zOi5fTp043Dei0cp5yag4Thw8D7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791409482; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=kGvUDiLie0dPMCDwrW6Vkkj/cP8ggVC9Hknrr+6OM28=;
 b=ZQJER1hU6AXDyit5wU9gfobSu6mZNV5z741FIzNSkqRjaO5xXdmhkRkE819HQDt+
 Kp+LSdD+XxJVFBVnEfTaF0/UUmHIw+0cO7XDXPgOETUwBoD144mMFtWb4MJxfqC4qDc
 Gj4q2UFK9GY5IinEFOw839Yv2r5UJ5aVt2wAgwLI=
Received: by smtp.zohomail.com with SMTPS id 1791409480437494.77731485644426; 
 Wed, 7 Oct 2026 14:44:40 -0700 (PDT)
Message-ID: <ce72b2f5-1343-44e9-89fe-e2de4efb7e9c@collabora.com>
Date: Thu, 8 Oct 2026 00:44:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/virtio: expose GEM memory statistics through
 fdinfo
To: shechenglong <shechenglong@xfusion.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stone.xulei@xfusion.com,
 chenjialong@xfusion.com
References: <20260922094455.1799-1-shechenglong@xfusion.com>
 <20260928133635.1835-1-shechenglong@xfusion.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260928133635.1835-1-shechenglong@xfusion.com>
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

On 9/28/26 16:36, shechenglong wrote:
> virtio-gpu does not expose per-client GEM memory usage through DRM
> fdinfo, leaving monitoring tools unable to account for buffers owned by a
> client.
> 
> Wire up the DRM fdinfo helpers and use drm_show_memory_stats() to report
> the standard drm-total-memory, drm-shared-memory and drm-active-memory
> fields for GEM objects referenced by each DRM file.
> 
> Tested on a QEMU/KVM guest with virtio-gpu. After running:
> 
>   modetest -M virtio_gpu -s 40:1024x768
> 
> the DRM file descriptor of the modetest process shows the following in
> /proc/<pid>/fdinfo/<fd>:
> 
>   drm-driver:         virtio_gpu
>   drm-client-id:      8
>   drm-pdev:           0000:00:02.0
>   drm-total-memory:   3 MiB
>   drm-shared-memory:  3 MiB
> 
> Signed-off-by: shechenglong <shechenglong@xfusion.com>
> Signed-off-by: chenjialong <chenjialong@xfusion.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 2aaa7cb0808..d43d7ddac60 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -323,7 +323,17 @@ MODULE_AUTHOR("Dave Airlie <airlied@redhat.com>");
>  MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
>  MODULE_AUTHOR("Alon Levy");
> 
> -DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
> +static void virtio_gpu_show_fdinfo(struct drm_printer *p,
> +                                  struct drm_file *file)
> +{
> +       drm_show_memory_stats(p, file);
> +}
> +
> +static const struct file_operations virtio_gpu_driver_fops = {
> +       .owner = THIS_MODULE,
> +       DRM_GEM_FOPS,
> +       .show_fdinfo = drm_show_fdinfo,
> +};
> 
>  static const struct drm_driver driver = {
>         /*
> @@ -347,6 +357,7 @@ static const struct drm_driver driver = {
> 
>         .gem_create_object = virtio_gpu_create_object,
>         .fops = &virtio_gpu_driver_fops,
> +       .show_fdinfo = virtio_gpu_show_fdinfo,
> 
>         .ioctls = virtio_gpu_ioctls,
>         .num_ioctls = DRM_VIRTIO_NUM_IOCTLS,
> --
> 2.43.0

Usefulness of this change is dubious. VirtIO-GPU has different types of
RAM, I'd expect them all represented properly instead of only shmem.

-- 
Best regards,
Dmitry
