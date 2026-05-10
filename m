Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D246CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 21:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363AC10E0D1;
	Sun, 10 May 2026 21:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="YCSMJhEt";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE5E10E0D1
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 21:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778447473; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m3hSG6VFA+VMKYC8uPHLLw+wZYxxe9fYN8ypjfVbDkigy4DKmO12uvbuxZ3FA8D9y/0lm5vQ5OwZGGw1ObfkaViBdz4nbuhTQz1UErSc1BYMDopo+8iqO1y/SUo8M0FGHNvX8HsXT+WCTOpcqw8B6Tdofyd0OQF2VKyfjR2A0uQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778447473;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dC+SQBvHA00jKA55ndpglBB83kxP2d4e2FYSPidsICs=; 
 b=kkSx1L5UJJ8bV7RIPevje+2oDORYVMfNuawEG5Afp4WyPIIOSuyYG3WIqfa+KTecYPxOpSgT+8wsL5YPULdy7JMqCtvnH5M3AykccFeLitMf7V+SmxgF8eqlEp9S3B2vGBWgh5MeJfNzvTAl4XBe3FZu47FgNLWmp1ScgpsyOiY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778447473; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=dC+SQBvHA00jKA55ndpglBB83kxP2d4e2FYSPidsICs=;
 b=YCSMJhEtdE86ILIB75QrvWALkfFwT7oSr+tZzZkTC8HGMiTMuOoDVMOfWxkzDc+l
 nrxJLX92/a4dI86I+cXxe1KfyKnDXJfBep7BXqWhPA/rHIU2kUe6aTdHE4GlDhrYauL
 YhQVdOa4/Wpwx1RYBH8K31mtabAXxEntI2AY4jaE=
Received: by mx.zohomail.com with SMTPS id 1778447470381353.01025610308295;
 Sun, 10 May 2026 14:11:10 -0700 (PDT)
Message-ID: <e1741cf2-3416-4464-bcae-741f0c87448b@collabora.com>
Date: Mon, 11 May 2026 00:11:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: check virtio_gpu_array_lock_resv() return in
 cursor update
To: Deepanshu Kartikey <kartikey406@gmail.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260510053025.100224-1-kartikey406@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260510053025.100224-1-kartikey406@gmail.com>
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

Hello,

On 5/10/26 08:30, Deepanshu Kartikey wrote:
> virtio_gpu_cursor_plane_update() calls virtio_gpu_array_lock_resv()
> but ignores its return value. The function can fail in two ways:
> 
>   - dma_resv_lock_interruptible() returns -ERESTARTSYS when a signal
>     is delivered while waiting for the reservation lock.
>   - dma_resv_reserve_fences() returns -ENOMEM if it fails to allocate
>     a fence slot; in this case lock_resv unlocks before returning.
> 
> In both cases the resv lock is not held on return. The cursor path
> proceeds to queue a fenced transfer command. The queue path then
> walks the object array and calls dma_resv_add_fence() on the cursor
> BO's reservation. dma_resv_add_fence() requires the resv lock to be
> held; with lockdep enabled the missing lock trips
> dma_resv_assert_held():
> 
>   WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
>   Call Trace:
>    virtio_gpu_array_add_fence+0xcd/0x140
>    virtio_gpu_queue_ctrl_sgs
>    virtio_gpu_queue_fenced_ctrl_buffer+0x578/0xfb0
>    virtio_gpu_cursor_plane_update+0x411/0xbc0
>    drm_atomic_helper_commit_planes+0x497/0xf10
>    ...
>    drm_mode_cursor_ioctl+0xd4/0x110
>    drm_ioctl+0x5e6/0xc60
>    __x64_sys_ioctl+0x18e/0x210
> 
> Beyond the WARN, mutating the dma_resv fence list without the lock
> races with concurrent readers/writers and can corrupt the list.
> 
> Check the return value of virtio_gpu_array_lock_resv(). On failure,
> drop the references taken by virtio_gpu_array_add_obj() with
> virtio_gpu_array_put_free() (which does not unlock, matching the
> not-locked state) and return without queueing the command. A
> skipped cursor frame is harmless; the WARN and the underlying race
> are not.
> 
> The bug was reported by syzbot, triggered via fault injection
> (fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
> -ENOMEM branch in dma_resv_reserve_fences().
> 
> Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
> Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index a126d1b25f46..ca379b08b9ec 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -459,7 +459,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
>  		if (!objs)
>  			return;
>  		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
> -		virtio_gpu_array_lock_resv(objs);
> +		if (virtio_gpu_array_lock_resv(objs)) {
> +			virtio_gpu_array_put_free(objs);
> +			return;
> +		}
>  		virtio_gpu_cmd_transfer_to_host_2d
>  			(vgdev, 0,
>  			 plane->state->crtc_w,

Thanks for the patch. Atomic update shouldn't fail due to non-critical
errors like on a signal interrupt. Could you please move this code that
may fail in update() to .prepare/cleanup_fb() callbacks?

-- 
Best regards,
Dmitry
