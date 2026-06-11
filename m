Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A09CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF7910E750;
	Thu, 11 Jun 2026 09:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="PS9yNbVw";
	dkim-atps=neutral
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9313F10E750
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:12:33 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=O7lBxJmBzLVHr7j4V1LP+8g77C7g47KBsdDJ1r85kJM=;
 b=PS9yNbVwFTfWv3lYMqdaHswJDfAs7MJMVN2G2y1YGFTeteti8hVY/20i4gTrZdqHJCMXJ6Klz
 +CZvvOB5GAcTlCkvCClMEn3Gx6oZKD6ayaxWlHMdfW+fzDrqRDwWQXg8kNO8s/fedVnD7PfYaU+
 DOGOIooorTfkR86ZTNVnZMc=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gbcCh08vCzmV7F;
 Thu, 11 Jun 2026 17:04:32 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 1ACB540565;
 Thu, 11 Jun 2026 17:12:28 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Jun 2026 17:12:27 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Jun 2026 17:12:27 +0800
Message-ID: <3f0ba6f2-abda-4048-ae02-3ede58469ba6@huawei.com>
Date: Thu, 11 Jun 2026 17:12:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/hibmc: Use gem-shmem with shadow-plane helpers
 for memory management
To: Thomas Zimmermann <tzimmermann@suse.de>, <xinliang.liu@linaro.org>,
 <tiantao6@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
 <sumit.semwal@linaro.org>, <yongqin.liu@linaro.org>, <jstultz@google.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, "Liangjian(Jim,Kunpeng Solution
 Development Dept)" <liangjian010@huawei.com>, Chenjianmin
 <chenjianmin@huawei.com>, "fengsheng (A)" <fengsheng5@huawei.com>,
 <shiyongbang@huawei.com>
References: <20260601114756.51953-1-tzimmermann@suse.de>
 <20260601114756.51953-5-tzimmermann@suse.de>
 <4dba90cc-edcd-45ee-b3f5-9695a5b12dad@huawei.com>
 <6aaaa750-2d5b-46da-8a0f-b4462e3e086a@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <6aaaa750-2d5b-46da-8a0f-b4462e3e086a@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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

> Hi
> 
> Am 08.06.26 um 15:42 schrieb Yongbang Shi:
>> Hi Thomas.
>>
>>>     #include "hibmc_drm_drv.h"
>>> @@ -100,28 +102,41 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
>>>   static void hibmc_plane_atomic_update(struct drm_plane *plane,
>>>                         struct drm_atomic_commit *state)
>>>   {
>>> +    struct hibmc_drm_private *priv = to_hibmc_drm_private(plane->dev);
>>>       struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>>> +    struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
>>>       struct drm_framebuffer *fb = new_state->fb;
>>> +    struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>>> +    u32 gpu_addr = 0;
>>>       u32 reg;
>>> -    s64 gpu_addr = 0;
>>>       u32 line_l;
>>> -    struct hibmc_drm_private *priv = to_hibmc_drm_private(plane->dev);
>>> -    struct drm_gem_vram_object *gbo;
>>>   -    if (!new_state->fb)
>>> +    if (!fb)
>>>           return;
>>>   -    gbo = drm_gem_vram_of_gem(new_state->fb->obj[0]);
>>> +    if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE) == 0) {
>>> +        struct drm_rect damage;
>>> +        struct drm_atomic_helper_damage_iter iter;
>>> +
>>> +        drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
>>> +        drm_atomic_for_each_plane_damage(&iter, &damage) {
>>> +            struct iosys_map dst[DRM_FORMAT_MAX_PLANES] = {
>>> +                IOSYS_MAP_INIT_VADDR_IOMEM(priv->vram + gpu_addr),
>>> +            };
>>>   -    gpu_addr = drm_gem_vram_offset(gbo);
>>> -    if (WARN_ON_ONCE(gpu_addr < 0))
>>> -        return; /* Bug: we didn't pin the BO to VRAM in prepare_fb. */
>>> +            iosys_map_incr(&dst[0],
>>> +                       drm_fb_clip_offset(fb->pitches[0], fb->format, &damage));
>>> +            drm_fb_memcpy(dst, fb->pitches, shadow_plane_state->data, fb, &damage);
>>> +        }
>>> +
>>> +        drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
>>> +    }
>> This implementation uses shadow planes for damage rect updates. If the entire plane is updated frequently, could this
>> lead to a performance drop or frame drops?
>>
>> Originally, the window system(X11/Wayland) drew directly to the hardware framebuffer, but now there is an extra copy in
>> `atomic_update`.
> 
> Generally speaking, shadow buffering is necessary for acceptable performance of the software renderer, because PCI
> access is rather slow (when compared to system memory).
> 
> The current hibmc driver sets drm_mode_config.prefer_shadow, [1] which tells compositors to maintain a shadow buffer. 
> IIRC Xorg announces the by mentioning shadowfb in its log files. It then writes the fully composed shadow buffer into
> video memory. Wayland compositors do the same AFAIK. Related code from Gnome's windows manager is a [2].
> 
> With the patch applied, prefer_shadow is no longer required. The kernel driver now maintains the shadow buffer. If
> there's a performance penalty, I'm not aware of it.
> 
> All this also applies to the kernel's framebuffer console. It currently uses an internal shadow buffer [3], but that is
> no longer needed with gem-shmem.
> 
> [1] https://elixir.bootlin.com/linux/v7.0.12/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c#L132
> [2] https://gitlab.gnome.org/GNOME/mutter/-/blob/50.2/src/backends/native/meta-kms-impl-device.c?ref_type=tags#L587
> [3] https://elixir.bootlin.com/linux/v7.0.12/source/drivers/gpu/drm/drm_fbdev_ttm.c#L200
> 

Okay, I get it. Thanks for explaining.

>>
>>>         writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
>>>         reg = drm_format_info_min_pitch(fb->format, 0, fb->width);
>>>   -    line_l = new_state->fb->pitches[0];
>>> +    line_l = fb->pitches[0];
>>>       writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
>>>              HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_OFFS, line_l),
>>>              priv->mmio + HIBMC_CRT_FB_WIDTH);
>>> @@ -149,13 +164,11 @@ static const struct drm_plane_funcs hibmc_plane_funcs = {
>>>       .update_plane    = drm_atomic_helper_update_plane,
>>>       .disable_plane    = drm_atomic_helper_disable_plane,
>>>       .destroy = drm_plane_cleanup,
>>> -    .reset = drm_atomic_helper_plane_reset,
>>> -    .atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>>> -    .atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
>>> +    DRM_GEM_SHADOW_PLANE_FUNCS,
>>>   };
>>>     static const struct drm_plane_helper_funcs hibmc_plane_helper_funcs = {
>>> -    DRM_GEM_VRAM_PLANE_HELPER_FUNCS,
>>> +    DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>>>       .atomic_check = hibmc_plane_atomic_check,
>>>       .atomic_update = hibmc_plane_atomic_update,
>>>   };
>>> @@ -515,6 +528,7 @@ int hibmc_de_init(struct hibmc_drm_private *priv)
>>>       }
>>>         drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
>>> +    drm_plane_enable_fb_damage_clips(plane);
>>>         ret = drm_crtc_init_with_planes(dev, crtc, plane,
>>>                       NULL, &hibmc_crtc_funcs, NULL);
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> index 99b36de1fe13..19d3193e2f76 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>>> @@ -18,9 +18,10 @@
>>>   #include <drm/clients/drm_client_setup.h>
>>>   #include <drm/drm_atomic_helper.h>
>>>   #include <drm/drm_drv.h>
>>> -#include <drm/drm_fbdev_ttm.h>
>>> +#include <drm/drm_dumb_buffers.h>
>>> +#include <drm/drm_fbdev_shmem.h>
>>>   #include <drm/drm_gem_framebuffer_helper.h>
>>> -#include <drm/drm_gem_vram_helper.h>
>>> +#include <drm/drm_gem_shmem_helper.h>
>>>   #include <drm/drm_managed.h>
>>>   #include <drm/drm_module.h>
>>>   #include <drm/drm_vblank.h>
>>> @@ -71,7 +72,13 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
>>>   static int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
>>>                    struct drm_mode_create_dumb *args)
>>>   {
>>> -    return drm_gem_vram_fill_create_dumb(file, dev, 0, 128, args);
>>> +    int ret;
>>> +
>>> +    ret = drm_mode_size_dumb(dev, args, SZ_128, 0);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    return drm_gem_shmem_create_with_handle(file, dev, args->size, &args->handle);
>>>   }
>>>     static const struct drm_driver hibmc_driver = {
>>> @@ -81,10 +88,9 @@ static const struct drm_driver hibmc_driver = {
>>>       .desc            = "hibmc drm driver",
>>>       .major            = 1,
>>>       .minor            = 0,
>>> -    .debugfs_init        = drm_vram_mm_debugfs_init,
>>> -    .dumb_create            = hibmc_dumb_create,
>>> -    .dumb_map_offset        = drm_gem_ttm_dumb_map_offset,
>>> -    DRM_FBDEV_TTM_DRIVER_OPS,
>>> +    .gem_prime_import    = drm_gem_shmem_prime_import_no_map,
>>> +    .dumb_create        = hibmc_dumb_create,
>>> +    DRM_FBDEV_SHMEM_DRIVER_OPS,
>>>   };
>>>     static int __maybe_unused hibmc_pm_suspend(struct device *dev)
>>> @@ -106,11 +112,32 @@ static const struct dev_pm_ops hibmc_pm_ops = {
>>>                   hibmc_pm_resume)
>>>   };
>>>   +static enum drm_mode_status hibmc_mode_config_mode_valid(struct drm_device *dev,
>>> +                             const struct drm_display_mode *mode)
>>> +{
>>> +    const struct drm_format_info *info =
>>> +        drm_get_format_info(dev, DRM_FORMAT_XRGB8888, DRM_FORMAT_MOD_LINEAR);
>>> +    struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>>> +    unsigned long max_fb_size = priv->vram_size;
>>> +    u64 pitch;
>>> +
>>> +    if (drm_WARN_ON_ONCE(dev, !info))
>>> +        return MODE_ERROR; /* driver bug */
>>> +
>>> +    pitch = drm_format_info_min_pitch(info, 0, mode->hdisplay);
>>> +    if (!pitch)
>>> +        return MODE_BAD_WIDTH;
>>> +    else if (pitch > max_fb_size / mode->vdisplay)
>>> +        return MODE_MEM;
>>> +
>> I reviewed the AST and Cirrus implementations, and they include checks for the maximum size supported by the hardware.
>>
>> The hardware FB width register has only 14 bits, and the HIBMC_CRT_FB_WIDTH_WIDTH_MASK macro defines the maximum size as
>> 0x3FFF. Would adding the following check make the code more rigorous?
> 
> The helper here is the general mode_valid callback from drm_mode_config_funcs. It should only test against devide-wide
> limits, such as the available video memory.
> 
> The framebuffer size is apparently a limit of the CRTC. There's already a check in the CRTC's mode_valid for the
> supported resolutions. [4] I think this should be fine.

Yes, the CRTC's `mode_valid` function ensures that the resolution falls within the valid fb width range; adding this
check wouldn't really provide any additional practical benefit.

> 
> [4] https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c#L223
> 
>>
>> Also, the pitch requires 128-byte alignment. Should we add a check here, or does the buffer created by
>> `hibmc_dumb_create` already ensure that the FB start address is aligned to 128 bytes via `SZ_128`? I’m not entirely sure
>> about this.
> 
> Yes, using SZ_128 aligns each scanline in the framebuffer to a multiple of 128 bytes. The underlying GEM buffer is sized
> accordingly. And the GEM buffer itself always starts at a page boundary. Any GEM buffer allocated via the dumb-buffer
> interface should be correct and the ioctl also returns the correct pitch back into user space.
> 
> The driver later programs the hardware pitch to the value stored in the framebuffer (in pitches[0]). If it then does a
> memcpy from the GEM buffer to video memory, it all works out.
> 
> A corner case would be that user space allocates via the dumb-buffers ioctl, but ignores the returned pitch. If we want
> to do additional checks for the pitch, we could add a wrapper function around fb_create. [5]  This would be the right
> place to verify that user space does not allocate unaligned framebuffers.
> 

Thanks for the suggestion. Yes, since the kernel does not trust user space, a check could be added in fb_create.

For windowing systems like Xorg or Wayland, I believe the pitch is typically handled correctly.
However, for some simple or buggy DRM clients, if the driver does not check the pitch, it may result in misaligned or
distorted screen display.

Thanks,
Yongbang.

> [5] https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c#L112
> 
> Best regards
> Thomas
> 
>>
>> Of course, the original code used `drm_vram_helper_mode_valid` without strictly checking these hardware limitations.
>> Thank you for your modification.
>>
>>
>> Thanks,
>> Yongbang.
>>
>>> +    return MODE_OK;
>>> +}
>>> +
>>>   static const struct drm_mode_config_funcs hibmc_mode_funcs = {
>>> -    .mode_valid = drm_vram_helper_mode_valid,
>>> +    .mode_valid = hibmc_mode_config_mode_valid,
>>>       .atomic_check = drm_atomic_helper_check,
>>>       .atomic_commit = drm_atomic_helper_commit,
>>> -    .fb_create = drm_gem_fb_create,
>>> +    .fb_create = drm_gem_fb_create_with_dirty,
>>>   };
>>>     static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>> @@ -130,7 +157,6 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>>       dev->mode_config.max_height = 1200;
>>>         dev->mode_config.preferred_depth = 24;
>>> -    dev->mode_config.prefer_shadow = 1;
>>>         dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
>>>   @@ -335,18 +361,22 @@ static int hibmc_load(struct drm_device *dev)
>>>   {
>>>       struct pci_dev *pdev = to_pci_dev(dev->dev);
>>>       struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>>> +    resource_size_t vram_base, vram_size;
>>>       int ret;
>>>         ret = hibmc_hw_init(priv);
>>>       if (ret)
>>>           return ret;
>>>   -    ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0),
>>> -                    pci_resource_len(pdev, 0));
>>> -    if (ret) {
>>> -        drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
>>> -        return ret;
>>> -    }
>>> +    vram_base = pci_resource_start(pdev, 0);
>>> +    vram_size = pci_resource_len(pdev, 0);
>>> +
>>> +    priv->vram = devm_ioremap_wc(dev->dev, vram_base, vram_size);
>>> +    if (!priv->vram)
>>> +        return -ENOMEM;
>>> +
>>> +    priv->vram_base = vram_base;
>>> +    priv->vram_size = vram_size;
>>>         ret = hibmc_kms_init(priv);
>>>       if (ret)
>>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> index cd3a3fca1fe6..dce8572bf63e 100644
>>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>>> @@ -38,6 +38,11 @@ struct hibmc_drm_private {
>>>       /* hw */
>>>       void __iomem   *mmio;
>>>   +    /* vram */
>>> +    void __iomem *vram;
>>> +    resource_size_t    vram_base;
>>> +    resource_size_t    vram_size;
>>> +
>>>       /* drm */
>>>       struct drm_device dev;
>>>       struct drm_plane primary_plane;
>>> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
>>> index 5ccdae21b94a..86b967174b60 100644
>>> --- a/include/drm/drm_gem_shmem_helper.h
>>> +++ b/include/drm/drm_gem_shmem_helper.h
>>> @@ -141,6 +141,10 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
>>>   void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
>>>                     struct drm_printer *p, unsigned int indent);
>>>   +int drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>>> +                     struct drm_device *dev, size_t size,
>>> +                     uint32_t *handle);
>>> +
>>>   extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
>>>     /*
> 

