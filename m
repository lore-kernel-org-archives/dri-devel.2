Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93EDCC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8A910E054;
	Tue, 13 Oct 2026 22:17:19 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762ED10E959
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 22:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791929824; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yk4rBXovmUFk6eKK66VVbtNchh49n30GnbnkTzkiXeAA6MzAsJIrLtNtDzlq2Vp3TLMn+x2CHd0g0XKVQ7mOdLfrDLFt/bltW5Tsj4yd8C6jPyannuBrqyXMrmNXmkn5OA6VVnxw33oMsPj0GH1tl/Rk/tjLCdZB60GvpfhdPAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791929824;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hAUVqH5LFcZWXZcpTpzwv3BreH7B5rvcbLwTNqdkXLU=; 
 b=eWBhwkIRGUavkfyihRjwW2zTiQPpbDNQnxyhVG+QIxTRFfVckCZ+YzFdKum8B8jVU/r24dHiQPeLU+Rb3XIesQ55p1HxHkxMJp3pZMKzmKUTG9l5gCvvHfbYB4scedmg/Yi4MlkdcypPo7+t4FCBe2hA6B0m2G6T4GSNjQSjnHw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791929824; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=hAUVqH5LFcZWXZcpTpzwv3BreH7B5rvcbLwTNqdkXLU=;
 b=j34/J2XoLuWGhJXwlCkDxD2pQqlGy7ThbTCijUeU1P3XVx2LFCLNgwNSbaXcg3y4
 gWSWPjhIHZRf1tWyupnSNnGx/H5tVyLFhgF6AORr/UJlw9Z8IT1jRf2g9gUiZ/DeIhY
 l2F4BxSt4JdMBvDXedXSdP+/cfHcJySk5KzHvJmY=
Received: by smtp.zohomail.com with SMTPS id 1791929822632526.8167997651227;
 Tue, 13 Oct 2026 15:17:02 -0700 (PDT)
Message-ID: <537679fc-8aea-472f-a7af-b15bd3cf27fd@collabora.com>
Date: Wed, 14 Oct 2026 01:16:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Destroy obj_restore_lock on the final
 drm_dev_put()
To: Abhin Parekadan Jose <abhinjoses@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
References: <20260929070714.169412-1-abhinjoses@gmail.com>
 <asxz0Xvv5jO9gAol@home-desktop>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <asxz0Xvv5jO9gAol@home-desktop>
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

On 10/12/26 08:44, Abhin Parekadan Jose wrote:
> Gentle ping on this fix for the syzbot report.
> 
> Dmitry, Gerd, do you have a preference between moving mutex_destroy()
> to virtio_gpu_release() (this patch) and using drmm_mutex_init()? I can
> send a v2 with the other option if you prefer it.
> 
> Thanks,
> Abhin
> 
> On Tue, Sep 29, 2026 at 07:07:14AM +0000, Abhin Parekadan Jose wrote:
>> virtio_gpu_deinit() calls mutex_destroy() on obj_restore_lock, but
>> deinit runs from virtio_gpu_remove() at unbind or PCI remove, and GEM
>> objects can outlive that. An open /dev/fb0 keeps the fbdev buffer
>> alive, and the fbdev DRM client holds a drm_device reference. When the
>> fd is finally closed, the buffer is freed and takes the destroyed lock:
>>
>>   fb_release()
>>     drm_fbdev_shmem_fb_destroy()
>>       drm_client_buffer_delete()
>>         virtio_gpu_free_object()
>>           virtio_gpu_remove_from_restore_list()
>>             mutex_lock(&vgdev->obj_restore_lock)
>>
>>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>>   WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xf2c/0x12ec
>>
>> virtio_gpu_deinit() should only do hardware teardown in this case
>> related virtio, its queues and others. Software state that GEM callbacks
>> still use belongs in virtio_gpu_release(), which runs on the final
>> drm_dev_put().
>>
>> There are two equivalent ways to tie the mutex lifetime to the
>> drm_device:
>>
>>  1) Move mutex_destroy() from virtio_gpu_deinit() to the end of
>>     virtio_gpu_release(). This is what this patch does. It is the
>>     smallest change and keeps the teardown next to the rest of the
>>     final-put software cleanup.
>>
>>  2) Initialise the lock with drmm_mutex_init() (checking its return
>>     value) and drop mutex_destroy() from virtio_gpu_deinit(), so DRM's
>>     managed release destroys it. This also covers the virtio_gpu_init()
>>     error path, where release returns early because dev_private is
>>     NULL. Skipping mutex_destroy() there is harmless, since it only
>>     matters for mutex debugging.
>>
>> Either fix removes the WARN. Option 1 is sent as the smaller change,
>> and option 2 can be done instead if preferred.
>>
>> Reproduced on arm64 QEMU (-device virtio-gpu-pci) with DEBUG_MUTEXES
>> and PROVE_LOCKING: open /dev/fb0, write 1 to
>> /sys/bus/pci/devices/0000:00:01.0/remove, then close the fd. With this
>> patch the WARN is gone, and rebinding brings back /dev/fb0 and
>> /dev/dri/card0.
>>
>> Fixes: 54a970048296 ("drm/virtio: Add support for saving and restoring virtio_gpu_objects")
>> Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
>> Assisted-by: LLM
>> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_kms.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> index 1d4d3bf46a20..0ec755c35050 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> @@ -354,7 +354,6 @@ void virtio_gpu_deinit(struct drm_device *dev)
>>  	virtio_reset_device(vgdev->vdev);
>>  	virtio_gpu_reclaim_vbufs(vgdev);
>>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
>> -	mutex_destroy(&vgdev->obj_restore_lock);
>>  }
>>  
>>  void virtio_gpu_release(struct drm_device *dev)
>> @@ -370,6 +369,8 @@ void virtio_gpu_release(struct drm_device *dev)
>>  
>>  	if (vgdev->has_host_visible)
>>  		drm_mm_takedown(&vgdev->host_visible_mm);
>> +
>> +	mutex_destroy(&vgdev->obj_restore_lock);
>>  }
>>  
>>  int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
Calling virtio_gpu_deinit() from virtio_gpu_release() might be a better
option

-- 
Best regards,
Dmitry
