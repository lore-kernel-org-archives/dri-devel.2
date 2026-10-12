Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BFECA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D950C10E4F5;
	Mon, 12 Oct 2026 07:32:03 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A2310E414
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:44:53 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c02782159so819051f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791783892; x=1792388692; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=btW4jQ1y+/SiqS0gs878Y5z0xH+cJraR47l5WrmrTe4=;
 b=RnuORQ+A0tGgVLj2LyLDMATBV3sqPw7kaOtzGzACzGpPxpP4kqaJPmnCbpt3+/W8hu
 t8vdVDSBI17bbc2ZsoFpRfocEKL7cooLtqyyj3c8QLRL4hXHY4HTqOWoP153+Vr4hyga
 WQVLDdfPVtgXrOmwBud/9ySoZLBXKV3ijs2lwN6LGgwZQlryIjP2goYx09IggXK3+lQp
 LM5pYvo2A15Qrivot7Ur24LcfnX0nDOt9D1iO1V6FPisFCrtw1RFLi7dMuirPIih6aYS
 goGY7c5S+bXfsb7tVsxOGbxXHVKxZJ8pLCoS6ZcqW8Vg5sSmZi28xl/guEkHI/vcFGOs
 N+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791783892; x=1792388692;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=btW4jQ1y+/SiqS0gs878Y5z0xH+cJraR47l5WrmrTe4=;
 b=CZ1BjwvSHy7wlPPHCCH5Et7uuNCpQjWrlRKkSQgbuYoJyg4xyy5cPzDx/rzVL3mu4W
 uA5AWjajx+uAFCsNw2iaA8y4SI48ABrsuhP4Lhvw9m8S+NQNAn8dqSMdnrGVe1yxJMYa
 j01NiKXtl3WMF6sSkEU/qu9Kgz+bsNhRhgxNFShf4bkC3QJEZ7jO+alXvJRBuVTD+tRy
 mfhE1UCqz59wcazjEzVyBpz8lXrXbuK4gSv8c6wBnKY3/+3N8Y7TFSXHoXTUT81Os2Uj
 +ctzoG7m5QOXkC6bBoDywhmN+h53G/CCeCahFPtE4j/YSOR19qjskMS8JwRJbDAfcEnN
 dpRw==
X-Forwarded-Encrypted: i=1;
 AKwUvByRVCNYo0T/stKK+lRbmUqtSnsB72ahyELbPrWWs0oFtuTtMXQ3HNUQMl64j9kflv+BTwzb6ZEIWdY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKPVJ0h0HP0LeaFxLZbvucPO4wCOhnal8Gw/VhFVfgoJUwKkln4
 WWwjkRYh7K+ETRSfaiwkdtDsL3NhYiARZGMhoTWNvRKutRcpn0bHu4Fe
X-Gm-Gg: AYBFou1XbCSsWaVyMXX/x5I9Zma12tFpQ0ANC/XSe01gaLSmOw299ZFvn9ars9Snov8
 wcd9SQEyU31zKPLFb+d3BNeCCP3ZNNddw8cqB/VsC1mRM8no8er9SbI1voeWPd2bPEklc0l2R6J
 vBw4ABznPUKvW5uK20TPSHZArVXvLBwB0Tox3hkccSPu3Klkk0EX/lMFNPIDUu7MEdY75j6YS2Q
 iynSAGzGDE9Myl63vrLHz22YNbVYPcwaV5W97iywbEPIn82Ylu+vZ4Jv4aSJDRaWR9erXNL9e5I
 jv+yIZ1nkXqSiGRg0+FPnjIvjamvLMXVTA3yXfUIzCZRuEfPJ/cvReGv5Hpd9nNmr1of2xbPrYk
 A6D4VctnzqAi7IWjTd+W/fc7za7NJVc3/uQ47A2sz9D8jW9ZDQyNaLuQZdA7iUQzath/yNTAd/t
 MIiZKT38suhlwyKRQI/4gt+vZneVg9p9y72S9A3TxIgPP0MpNEeW7spGzS8nlpWJ+TuUG6MZVNg
 p97bOmk9H/lU4b9w3Yhv80by8FDQEo3U9NsNdBwZIGUwXa8W4osyA==
X-Received: by 2002:a05:600c:6215:b0:4a0:eae0:b30e with SMTP id
 5b1f17b1804b1-4a18e4ca157mr133079995e9.22.1791783891940; 
 Sun, 11 Oct 2026 22:44:51 -0700 (PDT)
Received: from home-desktop (dynamic-002-214-019-128.2.214.pool.telefonica.de.
 [2.214.19.128]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf35930sm256330645e9.13.2026.10.11.22.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 22:44:51 -0700 (PDT)
Date: Mon, 12 Oct 2026 07:44:49 +0200
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
Subject: Re: [PATCH] drm/virtio: Destroy obj_restore_lock on the final
 drm_dev_put()
Message-ID: <asxz0Xvv5jO9gAol@home-desktop>
References: <20260929070714.169412-1-abhinjoses@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929070714.169412-1-abhinjoses@gmail.com>
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

Gentle ping on this fix for the syzbot report.

Dmitry, Gerd, do you have a preference between moving mutex_destroy()
to virtio_gpu_release() (this patch) and using drmm_mutex_init()? I can
send a v2 with the other option if you prefer it.

Thanks,
Abhin

On Tue, Sep 29, 2026 at 07:07:14AM +0000, Abhin Parekadan Jose wrote:
> virtio_gpu_deinit() calls mutex_destroy() on obj_restore_lock, but
> deinit runs from virtio_gpu_remove() at unbind or PCI remove, and GEM
> objects can outlive that. An open /dev/fb0 keeps the fbdev buffer
> alive, and the fbdev DRM client holds a drm_device reference. When the
> fd is finally closed, the buffer is freed and takes the destroyed lock:
> 
>   fb_release()
>     drm_fbdev_shmem_fb_destroy()
>       drm_client_buffer_delete()
>         virtio_gpu_free_object()
>           virtio_gpu_remove_from_restore_list()
>             mutex_lock(&vgdev->obj_restore_lock)
> 
>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>   WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xf2c/0x12ec
> 
> virtio_gpu_deinit() should only do hardware teardown in this case
> related virtio, its queues and others. Software state that GEM callbacks
> still use belongs in virtio_gpu_release(), which runs on the final
> drm_dev_put().
> 
> There are two equivalent ways to tie the mutex lifetime to the
> drm_device:
> 
>  1) Move mutex_destroy() from virtio_gpu_deinit() to the end of
>     virtio_gpu_release(). This is what this patch does. It is the
>     smallest change and keeps the teardown next to the rest of the
>     final-put software cleanup.
> 
>  2) Initialise the lock with drmm_mutex_init() (checking its return
>     value) and drop mutex_destroy() from virtio_gpu_deinit(), so DRM's
>     managed release destroys it. This also covers the virtio_gpu_init()
>     error path, where release returns early because dev_private is
>     NULL. Skipping mutex_destroy() there is harmless, since it only
>     matters for mutex debugging.
> 
> Either fix removes the WARN. Option 1 is sent as the smaller change,
> and option 2 can be done instead if preferred.
> 
> Reproduced on arm64 QEMU (-device virtio-gpu-pci) with DEBUG_MUTEXES
> and PROVE_LOCKING: open /dev/fb0, write 1 to
> /sys/bus/pci/devices/0000:00:01.0/remove, then close the fd. With this
> patch the WARN is gone, and rebinding brings back /dev/fb0 and
> /dev/dri/card0.
> 
> Fixes: 54a970048296 ("drm/virtio: Add support for saving and restoring virtio_gpu_objects")
> Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
> Assisted-by: LLM
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_kms.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 1d4d3bf46a20..0ec755c35050 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -354,7 +354,6 @@ void virtio_gpu_deinit(struct drm_device *dev)
>  	virtio_reset_device(vgdev->vdev);
>  	virtio_gpu_reclaim_vbufs(vgdev);
>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
> -	mutex_destroy(&vgdev->obj_restore_lock);
>  }
>  
>  void virtio_gpu_release(struct drm_device *dev)
> @@ -370,6 +369,8 @@ void virtio_gpu_release(struct drm_device *dev)
>  
>  	if (vgdev->has_host_visible)
>  		drm_mm_takedown(&vgdev->host_visible_mm);
> +
> +	mutex_destroy(&vgdev->obj_restore_lock);
>  }
>  
>  int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> -- 
> 2.51.1
> 
