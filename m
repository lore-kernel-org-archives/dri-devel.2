Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B2BCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D07E112168;
	Thu, 15 Oct 2026 07:56:55 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9AF10E1D6
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 19:53:23 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so39942685e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792007602; x=1792612402; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wRoKa+AOyjdQOl1cRipieu5Ib6igoe0K53YRH5w/Cro=;
 b=WDkNJdXmQO/7HZ9BN6QZTc0BgoA6HQo6xipH+bvNchciuCov9CMTzaINXUSooc3aS7
 AGiHl3tzD7u1E8L78VmN7kBf4InajIsVkkoQYK4gv2dRHxUcXUN1GxAUrdIp3yM4Q0SU
 Wag23xR0BqxejW5elgznT306s7Ii4YO7MglsxWaxLogwO2FbqKHj62VtFlleixdsORak
 wtacuga4pAvI054PmwmJKw9eYlthhRp2bai2ZX3GMIQ7XD1Breu/DdbkUgEtMG5NG6bX
 MaLYFOaSJeUnd7dqj+OIdQOFUNIPZhSv/gd3ah1cPWfYZ2Ws5adDxvDiIuRyWzQ2RKuL
 EE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007602; x=1792612402;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wRoKa+AOyjdQOl1cRipieu5Ib6igoe0K53YRH5w/Cro=;
 b=XrHgsV6h4MbSAK9luoIwc9J2M7UL7jn48K18YEB5Yg8V9bNqsKpOnhMig/Ncl81lHG
 p1UHNq6X2WVeDqB1BwoV+LYy6Jnn5oAvK6gokxo2q8KNxbGYkQYGO72l11+G1XZIchL0
 C7Sz3HEu5sj739zcccsxlo1zYbZhYjaQfdkRu5Ni7rs3lRVactZpRcGqvYXwt3DZsjP/
 rzAvNrtNjHrd2rs4lyRsxy2NX7Mq0gKqUaK8q49LKFTwZrqE6Gz846VnD+iPCzzVEQep
 sDyjYgjz5EERcOmmp5ZhL5tCrN5H/tfQLEJRWEsbnlb522Mble8/jIE8L1CDA30DXk7O
 tVvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7eNo4aM6dQsZjosfbIb64LyaSVuvmNbd6dKb6IE6hVdLiG5Hlh6lSDQmRo+P4UHhedM5CS2nUL9I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIIvQrTI1U5r1lrnzEpfnb+HOdo9a04MAsjp9DJxOYsaDJmrIY+
 8T+9/FzSiIhUeRCM4abiNc++s+jnwLIsBNUpUOAicR2tU2HXCxuag5oA
X-Gm-Gg: AYBFou2dAIwK1v9AANf8ZHAV105ppdS2Kkw3yqnFdDhqvQ43MU/F5FGDStAVjISXeCm
 EtrRzMxfzgDnOm1SEuSOHlU9d6LPMuWVHmwJazq+wUqfKPSU1LGQkEvMB3S5giDItHjdTArJ4tp
 T86hxCGEUyb9Z8S2N9Tv5UjTz12e3/JjY5WAIFHlrQTBlBSQRgoNcV+WdXCZ8N7Fd8JGrbwXtib
 sRT1Bd0dSzECwikJFhuTdShDdHb6HfEaoxdg55G0bgFHGemTdLJONtX3/clxz5ZjzcDRuadA1l6
 6hiLoxPZONoL92GShw/xSgAHtN4cGAmAIm+cqWPb4UDgJh0a3lQn34ur3A1MILnERPrHGdMkdhN
 Bkj1bMk2/G+Ub0dGcKYt7QS7XvECw/5WU5r3yFhT2fIiTg6YMgZfuTK7OBf5W744GPTkdOJiTtH
 yCs1JzHYq3hNQ63y1+ceyzhNks44njC9NplRCOQi21hUO7LButaAgtoUeE6Sa2O4IdCamlgPVGh
 iKc3Ylbpn85UJQMIsCyVEDB1kd8h42+BRPJpEnB36vl3z7PcSQ=
X-Received: by 2002:a05:600c:8184:b0:49f:ffd0:4039 with SMTP id
 5b1f17b1804b1-4a18e4f2221mr303055495e9.32.1792007601487; 
 Wed, 14 Oct 2026 12:53:21 -0700 (PDT)
Received: from home-desktop (dynamic-002-214-008-050.2.214.pool.telefonica.de.
 [2.214.8.50]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd972aebsm16638485e9.1.2026.10.14.12.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:53:21 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:53:18 +0200
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
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
Message-ID: <as_drl4kYXmgOfRn@home-desktop>
References: <20260929070714.169412-1-abhinjoses@gmail.com>
 <asxz0Xvv5jO9gAol@home-desktop>
 <537679fc-8aea-472f-a7af-b15bd3cf27fd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537679fc-8aea-472f-a7af-b15bd3cf27fd@collabora.com>
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

On Wed, Oct 14, 2026 at 01:16:57AM +0300, Dmitry Osipenko wrote:
> On 10/12/26 08:44, Abhin Parekadan Jose wrote:
> > Gentle ping on this fix for the syzbot report.
> > 
> > Dmitry, Gerd, do you have a preference between moving mutex_destroy()
> > to virtio_gpu_release() (this patch) and using drmm_mutex_init()? I can
> > send a v2 with the other option if you prefer it.
> > 
> > Thanks,
> > Abhin
> > 
> > On Tue, Sep 29, 2026 at 07:07:14AM +0000, Abhin Parekadan Jose wrote:
> >> virtio_gpu_deinit() calls mutex_destroy() on obj_restore_lock, but
> >> deinit runs from virtio_gpu_remove() at unbind or PCI remove, and GEM
> >> objects can outlive that. An open /dev/fb0 keeps the fbdev buffer
> >> alive, and the fbdev DRM client holds a drm_device reference. When the
> >> fd is finally closed, the buffer is freed and takes the destroyed lock:
> >>
> >>   fb_release()
> >>     drm_fbdev_shmem_fb_destroy()
> >>       drm_client_buffer_delete()
> >>         virtio_gpu_free_object()
> >>           virtio_gpu_remove_from_restore_list()
> >>             mutex_lock(&vgdev->obj_restore_lock)
> >>
> >>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> >>   WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xf2c/0x12ec
> >>
> >> virtio_gpu_deinit() should only do hardware teardown in this case
> >> related virtio, its queues and others. Software state that GEM callbacks
> >> still use belongs in virtio_gpu_release(), which runs on the final
> >> drm_dev_put().
> >>
> >> There are two equivalent ways to tie the mutex lifetime to the
> >> drm_device:
> >>
> >>  1) Move mutex_destroy() from virtio_gpu_deinit() to the end of
> >>     virtio_gpu_release(). This is what this patch does. It is the
> >>     smallest change and keeps the teardown next to the rest of the
> >>     final-put software cleanup.
> >>
> >>  2) Initialise the lock with drmm_mutex_init() (checking its return
> >>     value) and drop mutex_destroy() from virtio_gpu_deinit(), so DRM's
> >>     managed release destroys it. This also covers the virtio_gpu_init()
> >>     error path, where release returns early because dev_private is
> >>     NULL. Skipping mutex_destroy() there is harmless, since it only
> >>     matters for mutex debugging.
> >>
> >> Either fix removes the WARN. Option 1 is sent as the smaller change,
> >> and option 2 can be done instead if preferred.
> >>
> >> Reproduced on arm64 QEMU (-device virtio-gpu-pci) with DEBUG_MUTEXES
> >> and PROVE_LOCKING: open /dev/fb0, write 1 to
> >> /sys/bus/pci/devices/0000:00:01.0/remove, then close the fd. With this
> >> patch the WARN is gone, and rebinding brings back /dev/fb0 and
> >> /dev/dri/card0.
> >>
> >> Fixes: 54a970048296 ("drm/virtio: Add support for saving and restoring virtio_gpu_objects")
> >> Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
> >> Assisted-by: LLM
> >> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
> >> ---
> >>  drivers/gpu/drm/virtio/virtgpu_kms.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> index 1d4d3bf46a20..0ec755c35050 100644
> >> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> @@ -354,7 +354,6 @@ void virtio_gpu_deinit(struct drm_device *dev)
> >>  	virtio_reset_device(vgdev->vdev);
> >>  	virtio_gpu_reclaim_vbufs(vgdev);
> >>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
> >> -	mutex_destroy(&vgdev->obj_restore_lock);
> >>  }
> >>  
> >>  void virtio_gpu_release(struct drm_device *dev)
> >> @@ -370,6 +369,8 @@ void virtio_gpu_release(struct drm_device *dev)
> >>  
> >>  	if (vgdev->has_host_visible)
> >>  		drm_mm_takedown(&vgdev->host_visible_mm);
> >> +
> >> +	mutex_destroy(&vgdev->obj_restore_lock);
> >>  }
> >>  
> >>  int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
> Calling virtio_gpu_deinit() from virtio_gpu_release() might be a better
> option

Wouldn't that end up freeing the virtqueues twice, or using them after
they are freed? virtio_gpu_deinit() would then run from both the
virtio_gpu_remove() path and the virtio_gpu_release() path.
or do you mean removing it from virtio_gpu_remove() and calling it only
from virtio_gpu_release()?
This is only from a high-level look so far. I'll look into it more
closely and get back to you.

> 
> -- 
> Best regards,
> Dmitry
