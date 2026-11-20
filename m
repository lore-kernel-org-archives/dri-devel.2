Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE6606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C/OjQ8fI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C621810E193;
	Fri, 20 Nov 2026 06:55:16 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E21C10E115
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 06:55:10 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-71ab5e64742so362587eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795157709; cv=none;
 d=google.com; s=arc-20260327;
 b=FNHmG9vS006y2mAJ4ZfUYqzKAXtZpUMlB/Jg4BtsxKlNAPRU8YsUzaM8FeWkkoeRjz
 9Xw73If2p1Pc7YeS3dihrskZaYA/WrRUuKWA5NZLT6+fxqvgGhw59hhPNUCbmwnLfWz+
 SV4/+1TtQHttnGAXRFG1wl2K4JS+DOc9E0Ij23Y62giD/NffRBrfL8McjE8wFH2lJU+W
 WKBTlKeKljv+X8h12YrM7s3DqXVflAntfdFUXfb1O3RfCsBFlI9q/WvfGn6ejhHz9c4V
 13AuThoY+Mj1cM3QjZNlGgFpD8PnzzgBsnUeHR3JDEf6r6ozP9G7E9tWwQuyuCxbTZBR
 NJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yUqc+7I9fkDNqG0gHFeWHQ2EttT+25aZhma/FvBj/3o=;
 fh=G/+gfVlfYAN8qW1cBZYMjtNt4jkkgOXi6EoNHYedSq8=;
 b=C0iJRTaQJy5soeR38+jro4ZumM8xB8KDGzQ3vRya6H67ZwJFIzFDPo/ZpZq582ZbxP
 Y0HtnUBUdIOdNx3ZjWYAhl5Q5okfJtdoIdYdihoCgUhnDg4qKfGMsr1nbsGCM4YCSmTg
 H5NrAHjraAOlJ41SNPz2ZhgDNYW25vCVCLcODAvDKmAWQ/eLj6tLgfpJhgIdM1xPe457
 QBLUylqtbYkM8gQFIgcDkKYo1hKnc0gsrdA7Pl7jBbJGtaIFknWAP3s1qBBl/0DYbRHa
 ZBr1tZnzPWRN0jvm5nc+GIdWdpbumkmBvOik0uCi1y/ANuW/USptBP6l4gFZmjJPZtJ1
 XmSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795157709; x=1795762509; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yUqc+7I9fkDNqG0gHFeWHQ2EttT+25aZhma/FvBj/3o=;
 b=C/OjQ8fIGa8WURAheZsM2ZZgPxx/i4OdHxM58Mx+8fiA7BLX9BdjUxX+/jYx9Aah5S
 754Kqg60QLLHdajWriDQmURGC9iha/1NEqnfxVejI1PJjO0PIN8K0YKQhEV0Y0A8UYBd
 OMachFhsYo6TQqHYFD0Jn5jPnAvoglktVNrG7svTCWBWdso/rqgZxn2f5Bt+9N6h2F/h
 Jj/gRY7YAI6EMmFUxYyr1S/AqLFoJWpgG2IBYa3s1BUAvwFOgtlcsQeU7z8XEP+uzQJP
 W98uAAno7t4a7vHqao6t6X0lkfkPgrpph8XLXLlwD5r/v6PumolW0SHCYcroww9+ZhQm
 ZJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795157709; x=1795762509;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yUqc+7I9fkDNqG0gHFeWHQ2EttT+25aZhma/FvBj/3o=;
 b=SQ4sMPZblBLvfG0M7wyKNUVPj707FJgpJYVkbSQS9YPBkMUncHjG+dYCak0W0rqRKy
 OGVU8E/a9ujbum1BFfWJsKNwCQKpXIuNaZv5Yy7+WjBJNA1EcNyRfuD/tWR/Ze8NDAIm
 EirnjwXFLwZRhs+0LLLpA8pcswvxuVhBjkm86LS2lODFbSS4Zc8yqJlnYcFnJGnlZ9QN
 NBKwTjQqS7gd3Z4g0m1ZP7A6CVabspAv9v9QdIj62HoeAMfTChGiLDfn81+eVjTxGCrY
 /urA9Sq15pmHFl1VGPlkqkgCWZEB9tkfILO3OUqqWnALj4bBFNJfATEav9Gj37rdWofp
 erYw==
X-Forwarded-Encrypted: i=1;
 AL+hErG4YQDmjMzjDiRynFJQ4nIIXRpuy5G0oBgf4aGPzf5y0/IlFqr0xcbHFyAMlc0LWxotJPtpHC2v9ek=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9kCdlc2vW6A+UUqqG5RsURYgltctQ9R5mDmoKDIbZJ2onSQJa7
 yYG7gaa9M+/T4WHp7A8w8D1SKbT8x1M1zTBbxN0myaGEBmZ1cwXZmeMB8TcXH9Fdh9uJ23Ag7ud
 4wp/6UKJh4/sgTU4inlWJKmyMR0m0V6o=
X-Gm-Gg: AYBFou2mWWXitiA3CuBvq4kKsb87qEesIU0/BGYicvQjZAc/faMErs7/NrQAZsyJV43
 +rMG6AsiZtXqDl3qYuACV+xMSrsZyit7xBaXArE97+mNlOx/diemhqCr+OPH+8Gww64kwv/CqPl
 gcE0sUYPwzM8WiTLNXuaBNJZzkniBigHnftbMsqkVTcFH3hkf4qGwgAglG4/jPCT0O3gw1xUPL3
 Gp8N9vmyxCe/qEc1MTstrIM+KQGQPEwc5F3vnwm9rwxteBHVrC5Dc4m4laj4P+XElYMlpqE2IfG
 fLFcWsoJOrc9qFS6Q0Ws26Ek+FZgLkYHVYC+owJw7I3+Yknz0AoLJH2fx9dVYAwjHRbKvp9P9X6
 DkZcdVPFkiqk6AL/3OCVQO+JtBtQ1BlD17E4RQljmuk/cjZOoBfx2k7biWolF0Z2y1uIF72ZWs7
 1KD6cvctP2NrQgHu8tQzSpWoYw/jXGrCxK
X-Received: by 2002:a05:6820:a703:10b0:71a:e9b1:65e3 with SMTP id
 006d021491bc7-71b39631876mr1261642eaf.81.1795157709033; Thu, 19 Nov 2026
 22:55:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-11-tzimmermann@suse.de>
In-Reply-To: <20261119142114.152052-11-tzimmermann@suse.de>
From: Jie Feng <hjf3108@gmail.com>
Date: Fri, 20 Nov 2026 14:54:33 +0800
X-Gm-Features: AclHuK_zcsvJVWcd5lOf-LUFaTbb1PGsprsSd6oBG8EPOYJIPRPC_ZTuRDkP7uc
Message-ID: <CABOQOSVdsELGDEiJu95e5RQ1uRiWLkcwz4TB9xfbQe9qbD7WrA@mail.gmail.com>
Subject: Re: [PATCH 10/11] drm/udl: Allocate URBs on demand
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, sean@poorly.run, tiwai@suse.com, 
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 14:45, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Remove the limit on the number of URBs in flight. Allocate URBs as
> needed. Keep once-allocated URBs in a list for reuse at later frames.
> Also remove some bogus debug output from the affected code.
>
> The existing synchronization in atomic_begin() guarantees that udl
> does not send a frame over the USB before the previous frame has been
> transferred. This avoids overloading the USB. If the USB is saturated,
> page flips delay and the compositor reduces the update frequency.
>
> The allocated URBs remain in the cache until the driver is being removed
> from the device. In a later update, a regular worker or a shrinker could
> free the URB cache when needed.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/udl/udl_drv.h  |   1 -
>  drivers/gpu/drm/udl/udl_main.c | 123 ++++++++++++---------------------
>  2 files changed, 44 insertions(+), 80 deletions(-)
>
> diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
> index 420166bdc4bc..68bcf0222764 100644
> --- a/drivers/gpu/drm/udl/udl_drv.h
> +++ b/drivers/gpu/drm/udl/udl_drv.h
> @@ -45,7 +45,6 @@ struct urb_list {
>         spinlock_t lock;
>         wait_queue_head_t sleep;
>         unsigned int in_flight;
> -       int count;
>  };
>
>  struct udl_device {
> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
> index d0195bd4213d..adddcf4b3451 100644
> --- a/drivers/gpu/drm/udl/udl_main.c
> +++ b/drivers/gpu/drm/udl/udl_main.c
> @@ -25,13 +25,10 @@
>  #define NR_USB_REQUEST_CHANNEL 0x12
>
>  #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
> -#define WRITES_IN_FLIGHT (20)
>  #define MAX_VENDOR_DESCRIPTOR_SIZE 256
>
>  #define UDL_SKU_PIXEL_LIMIT_DEFAULT    2080000
>
> -static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout);
> -
>  /*
>   * Try to make sense of whatever we parse. Therefore return @end on
>   * errors, but don't fail hard.
> @@ -216,25 +213,41 @@ static struct urb *udl_alloc_bulk_urb(struct udl_device *udl, size_t size)
>         return ERR_PTR(ret);
>  }
>
> +static struct urb *__udl_get_cached_urb_locked(struct udl_device *udl)
> +{
> +       struct urb_node *unode;
> +
> +       assert_spin_locked(&udl->urbs.lock);
> +
> +       if (list_empty(&udl->urbs.list))
> +               return NULL;
> +
> +       unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
> +       list_del_init(&unode->entry);
> +
> +       return unode->urb;
> +}
> +
>  static void udl_free_urb_list(struct udl_device *udl)
>  {
> +       struct drm_device *drm = &udl->drm;
>         struct urb *urb;
>
> -       DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
> +       drm_dbg(drm, "Waiting for completes and freeing all render URBs\n");
>
> -       /* keep waiting and freeing, until we've got 'em all */
> -       while (udl->urbs.count) {
> -               spin_lock_irq(&udl->urbs.lock);
> -               urb = udl_get_urb_locked(udl, MAX_SCHEDULE_TIMEOUT);
> -               udl->urbs.count--;
> -               spin_unlock_irq(&udl->urbs.lock);
> -               if (WARN_ON(!urb))
> -                       break;
> -               /* Free each separately allocated piece */
> -               udl_free_bulk_urb(urb);
> +       /* keep waiting until we've got 'em all */
> +       scoped_guard(spinlock_irq, &udl->urbs.lock) {
> +               wait_event_lock_irq(udl->urbs.sleep, !udl->urbs.in_flight, udl->urbs.lock);
> +
> +               urb = __udl_get_cached_urb_locked(udl);
>         }
>
> -       wake_up_all(&udl->urbs.sleep);
> +       while (urb) {
> +               udl_free_bulk_urb(urb);
> +
> +               scoped_guard(spinlock_irq, &udl->urbs.lock)
> +                       urb = __udl_get_cached_urb_locked(udl);
> +       }
>  }
>
>  static void udl_urb_list_release(void *data)
> @@ -244,71 +257,16 @@ static void udl_urb_list_release(void *data)
>         udl_free_urb_list(udl);
>  }
>
> -static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
> +static int udl_init_urb_list(struct udl_device *udl)
>  {
>         struct drm_device *drm = &udl->drm;
> -       size_t wanted_size = count * size;
> -       int ret;
>
>         spin_lock_init(&udl->urbs.lock);
>         INIT_LIST_HEAD(&udl->urbs.list);
>         init_waitqueue_head(&udl->urbs.sleep);
> -       udl->urbs.count = 0;
>         udl->urbs.in_flight = 0;
>
> -retry:
> -       while (udl->urbs.count * size < wanted_size) {
> -               struct urb *urb;
> -               struct urb_node *unode;
> -
> -               urb = udl_alloc_bulk_urb(udl, size);
> -               if (IS_ERR(urb)) {
> -                       if (PTR_ERR(urb) == -ENOBUFS && size > PAGE_SIZE) {
> -                               size /= 2;
> -                               udl_free_urb_list(udl);
> -                               goto retry;
> -                       }
> -                       break;
> -               }
> -               unode = urb->context;
> -
> -               list_add_tail(&unode->entry, &udl->urbs.list);
> -
> -               udl->urbs.count++;
> -       }
> -
> -       if (!udl->urbs.count)
> -               return -ENOMEM;
> -
> -       ret = devm_add_action_or_reset(drm->dev, udl_urb_list_release, udl);
> -       if (ret < 0)
> -               return ret;
> -
> -       DRM_DEBUG("allocated %d %d byte urbs\n", udl->urbs.count, (int) size);
> -
> -       return udl->urbs.count;
> -}
> -
> -static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
> -{
> -       struct urb_node *unode;
> -
> -       assert_spin_locked(&udl->urbs.lock);
> -
> -       /* Wait for an in-flight buffer to complete and get re-queued */
> -       if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
> -                                        !udl->urbs.count ||
> -                                        !list_empty(&udl->urbs.list),
> -                                        udl->urbs.lock, timeout))
> -               return NULL;
> -
> -       if (!udl->urbs.count)
> -               return NULL;
> -
> -       unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
> -       list_del_init(&unode->entry);
> -
> -       return unode->urb;
> +       return devm_add_action_or_reset(drm->dev, udl_urb_list_release, udl);
>  }
>
>  struct urb *udl_get_urb(struct udl_device *udl)
> @@ -321,9 +279,18 @@ struct urb *udl_get_urb(struct udl_device *udl)
>                         return NULL;
>                 ++udl->urbs.in_flight;
>
> -               urb = udl_get_urb_locked(udl, HZ * 2);
> -               if (!urb)
> -                       --udl->urbs.in_flight;
> +               urb = __udl_get_cached_urb_locked(udl);
> +       }
> +
> +       if (!urb) {
> +               urb = udl_alloc_bulk_urb(udl, MAX_TRANSFER);
> +               if (IS_ERR(urb)) {
> +                       scoped_guard(spinlock_irqsave, &udl->urbs.lock) {
> +                               if (udl->urbs.in_flight)
> +                                       --udl->urbs.in_flight;
> +                       }
> +                       return NULL;
> +               }
On a usb contention or stalled device, this might allocate memory unboundedly
if the udl_sync_pending_urbs keeps timing out.
The number of URBs could be limited based on the size of the worst-case
full frame update. The entire urb cache can be cleared on a modeset,
so that maximum memory usage scales with the frame size.

>         }
>
>         return urb;
> @@ -395,8 +362,6 @@ int udl_init(struct udl_device *udl)
>         int ret = -ENOMEM;
>         struct device *dma_dev;
>
> -       DRM_DEBUG("\n");
> -
>         dma_dev = usb_intf_get_dma_device(to_usb_interface(dev->dev));
>         if (dma_dev) {
>                 drm_dev_set_dma_dev(dev, dma_dev);
> @@ -419,8 +384,8 @@ int udl_init(struct udl_device *udl)
>         if (udl_select_std_channel(udl))
>                 DRM_ERROR("Selecting channel failed\n");
>
> -       ret = udl_alloc_urb_list(udl, WRITES_IN_FLIGHT, MAX_TRANSFER);
> -       if (ret < 0)
> +       ret = udl_init_urb_list(udl);
> +       if (ret)
>                 return ret;
>
>         ret = udl_modeset_init(udl);
> --
> 2.56.0
>
>


Best regards,
Jie Feng
