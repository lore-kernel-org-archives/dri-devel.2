Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8ADCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9426210E811;
	Wed, 10 Jun 2026 09:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JI0miHWR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85DbP52p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JI0miHWR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85DbP52p";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CC110E583
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:09:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 120F26AC97;
 Wed, 10 Jun 2026 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781082589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/FYGh+BzUvw1dKKLnuEpZwChjwEA3h0ra9GW6mbIIkU=;
 b=JI0miHWR5Ym/8K548OdBahy7ownVsDs4xN7MDmYJs5LuqIEOIWLrL0LZir8Xmr/OAejADX
 FgGrvnVfEaTyD8r2b7m4E8snIAsSe6olhgoj9agvD5vHzF5MBYHyQdOMqJM2Ebh93WBGND
 26w1YPXJlUxyv5+N1YJzXyCl2Axxu18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781082589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/FYGh+BzUvw1dKKLnuEpZwChjwEA3h0ra9GW6mbIIkU=;
 b=85DbP52pHRqMwz7huzoD6uZyGO98P4Y4RHBNJO9Mq3J8cY51yJZkhLEZdz4If+R/cxbGmU
 j+6D+ktXv5heZRAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JI0miHWR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=85DbP52p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781082589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/FYGh+BzUvw1dKKLnuEpZwChjwEA3h0ra9GW6mbIIkU=;
 b=JI0miHWR5Ym/8K548OdBahy7ownVsDs4xN7MDmYJs5LuqIEOIWLrL0LZir8Xmr/OAejADX
 FgGrvnVfEaTyD8r2b7m4E8snIAsSe6olhgoj9agvD5vHzF5MBYHyQdOMqJM2Ebh93WBGND
 26w1YPXJlUxyv5+N1YJzXyCl2Axxu18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781082589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/FYGh+BzUvw1dKKLnuEpZwChjwEA3h0ra9GW6mbIIkU=;
 b=85DbP52pHRqMwz7huzoD6uZyGO98P4Y4RHBNJO9Mq3J8cY51yJZkhLEZdz4If+R/cxbGmU
 j+6D+ktXv5heZRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A58D6779A7;
 Wed, 10 Jun 2026 09:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bzEwJ9wpKWodKAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 09:09:48 +0000
Message-ID: <6aaaa750-2d5b-46da-8a0f-b4462e3e086a@suse.de>
Date: Wed, 10 Jun 2026 11:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/hibmc: Use gem-shmem with shadow-plane helpers
 for memory management
To: Yongbang Shi <shiyongbang@huawei.com>, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, kong.kongxinwei@hisilicon.com,
 sumit.semwal@linaro.org, yongqin.liu@linaro.org, jstultz@google.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
 "Liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>,
 "fengsheng (A)" <fengsheng5@huawei.com>
References: <20260601114756.51953-1-tzimmermann@suse.de>
 <20260601114756.51953-5-tzimmermann@suse.de>
 <4dba90cc-edcd-45ee-b3f5-9695a5b12dad@huawei.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <4dba90cc-edcd-45ee-b3f5-9695a5b12dad@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 120F26AC97
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[15]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[huawei.com,linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.de:mid,suse.de:dkim,gnome.org:url,suse.com:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Hi

Am 08.06.26 um 15:42 schrieb Yongbang Shi:
> Hi Thomas.
>
>>   
>>   #include "hibmc_drm_drv.h"
>> @@ -100,28 +102,41 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
>>   static void hibmc_plane_atomic_update(struct drm_plane *plane,
>>   				      struct drm_atomic_commit *state)
>>   {
>> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(plane->dev);
>>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
>>   	struct drm_framebuffer *fb = new_state->fb;
>> +	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>> +	u32 gpu_addr = 0;
>>   	u32 reg;
>> -	s64 gpu_addr = 0;
>>   	u32 line_l;
>> -	struct hibmc_drm_private *priv = to_hibmc_drm_private(plane->dev);
>> -	struct drm_gem_vram_object *gbo;
>>   
>> -	if (!new_state->fb)
>> +	if (!fb)
>>   		return;
>>   
>> -	gbo = drm_gem_vram_of_gem(new_state->fb->obj[0]);
>> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE) == 0) {
>> +		struct drm_rect damage;
>> +		struct drm_atomic_helper_damage_iter iter;
>> +
>> +		drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
>> +		drm_atomic_for_each_plane_damage(&iter, &damage) {
>> +			struct iosys_map dst[DRM_FORMAT_MAX_PLANES] = {
>> +				IOSYS_MAP_INIT_VADDR_IOMEM(priv->vram + gpu_addr),
>> +			};
>>   
>> -	gpu_addr = drm_gem_vram_offset(gbo);
>> -	if (WARN_ON_ONCE(gpu_addr < 0))
>> -		return; /* Bug: we didn't pin the BO to VRAM in prepare_fb. */
>> +			iosys_map_incr(&dst[0],
>> +				       drm_fb_clip_offset(fb->pitches[0], fb->format, &damage));
>> +			drm_fb_memcpy(dst, fb->pitches, shadow_plane_state->data, fb, &damage);
>> +		}
>> +
>> +		drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
>> +	}
> This implementation uses shadow planes for damage rect updates. If the entire plane is updated frequently, could this
> lead to a performance drop or frame drops?
>
> Originally, the window system(X11/Wayland) drew directly to the hardware framebuffer, but now there is an extra copy in
> `atomic_update`.

Generally speaking, shadow buffering is necessary for acceptable 
performance of the software renderer, because PCI access is rather slow 
(when compared to system memory).

The current hibmc driver sets drm_mode_config.prefer_shadow, [1] which 
tells compositors to maintain a shadow buffer.  IIRC Xorg announces the 
by mentioning shadowfb in its log files. It then writes the fully 
composed shadow buffer into video memory. Wayland compositors do the 
same AFAIK. Related code from Gnome's windows manager is a [2].

With the patch applied, prefer_shadow is no longer required. The kernel 
driver now maintains the shadow buffer. If there's a performance 
penalty, I'm not aware of it.

All this also applies to the kernel's framebuffer console. It currently 
uses an internal shadow buffer [3], but that is no longer needed with 
gem-shmem.

[1] 
https://elixir.bootlin.com/linux/v7.0.12/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c#L132
[2] 
https://gitlab.gnome.org/GNOME/mutter/-/blob/50.2/src/backends/native/meta-kms-impl-device.c?ref_type=tags#L587
[3] 
https://elixir.bootlin.com/linux/v7.0.12/source/drivers/gpu/drm/drm_fbdev_ttm.c#L200

>
>>   
>>   	writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
>>   
>>   	reg = drm_format_info_min_pitch(fb->format, 0, fb->width);
>>   
>> -	line_l = new_state->fb->pitches[0];
>> +	line_l = fb->pitches[0];
>>   	writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
>>   	       HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_OFFS, line_l),
>>   	       priv->mmio + HIBMC_CRT_FB_WIDTH);
>> @@ -149,13 +164,11 @@ static const struct drm_plane_funcs hibmc_plane_funcs = {
>>   	.update_plane	= drm_atomic_helper_update_plane,
>>   	.disable_plane	= drm_atomic_helper_disable_plane,
>>   	.destroy = drm_plane_cleanup,
>> -	.reset = drm_atomic_helper_plane_reset,
>> -	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>> -	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
>> +	DRM_GEM_SHADOW_PLANE_FUNCS,
>>   };
>>   
>>   static const struct drm_plane_helper_funcs hibmc_plane_helper_funcs = {
>> -	DRM_GEM_VRAM_PLANE_HELPER_FUNCS,
>> +	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>>   	.atomic_check = hibmc_plane_atomic_check,
>>   	.atomic_update = hibmc_plane_atomic_update,
>>   };
>> @@ -515,6 +528,7 @@ int hibmc_de_init(struct hibmc_drm_private *priv)
>>   	}
>>   
>>   	drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
>> +	drm_plane_enable_fb_damage_clips(plane);
>>   
>>   	ret = drm_crtc_init_with_planes(dev, crtc, plane,
>>   					NULL, &hibmc_crtc_funcs, NULL);
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index 99b36de1fe13..19d3193e2f76 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -18,9 +18,10 @@
>>   #include <drm/clients/drm_client_setup.h>
>>   #include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_drv.h>
>> -#include <drm/drm_fbdev_ttm.h>
>> +#include <drm/drm_dumb_buffers.h>
>> +#include <drm/drm_fbdev_shmem.h>
>>   #include <drm/drm_gem_framebuffer_helper.h>
>> -#include <drm/drm_gem_vram_helper.h>
>> +#include <drm/drm_gem_shmem_helper.h>
>>   #include <drm/drm_managed.h>
>>   #include <drm/drm_module.h>
>>   #include <drm/drm_vblank.h>
>> @@ -71,7 +72,13 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
>>   static int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
>>   			     struct drm_mode_create_dumb *args)
>>   {
>> -	return drm_gem_vram_fill_create_dumb(file, dev, 0, 128, args);
>> +	int ret;
>> +
>> +	ret = drm_mode_size_dumb(dev, args, SZ_128, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return drm_gem_shmem_create_with_handle(file, dev, args->size, &args->handle);
>>   }
>>   
>>   static const struct drm_driver hibmc_driver = {
>> @@ -81,10 +88,9 @@ static const struct drm_driver hibmc_driver = {
>>   	.desc			= "hibmc drm driver",
>>   	.major			= 1,
>>   	.minor			= 0,
>> -	.debugfs_init		= drm_vram_mm_debugfs_init,
>> -	.dumb_create            = hibmc_dumb_create,
>> -	.dumb_map_offset        = drm_gem_ttm_dumb_map_offset,
>> -	DRM_FBDEV_TTM_DRIVER_OPS,
>> +	.gem_prime_import	= drm_gem_shmem_prime_import_no_map,
>> +	.dumb_create		= hibmc_dumb_create,
>> +	DRM_FBDEV_SHMEM_DRIVER_OPS,
>>   };
>>   
>>   static int __maybe_unused hibmc_pm_suspend(struct device *dev)
>> @@ -106,11 +112,32 @@ static const struct dev_pm_ops hibmc_pm_ops = {
>>   				hibmc_pm_resume)
>>   };
>>   
>> +static enum drm_mode_status hibmc_mode_config_mode_valid(struct drm_device *dev,
>> +							 const struct drm_display_mode *mode)
>> +{
>> +	const struct drm_format_info *info =
>> +		drm_get_format_info(dev, DRM_FORMAT_XRGB8888, DRM_FORMAT_MOD_LINEAR);
>> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>> +	unsigned long max_fb_size = priv->vram_size;
>> +	u64 pitch;
>> +
>> +	if (drm_WARN_ON_ONCE(dev, !info))
>> +		return MODE_ERROR; /* driver bug */
>> +
>> +	pitch = drm_format_info_min_pitch(info, 0, mode->hdisplay);
>> +	if (!pitch)
>> +		return MODE_BAD_WIDTH;
>> +	else if (pitch > max_fb_size / mode->vdisplay)
>> +		return MODE_MEM;
>> +
> I reviewed the AST and Cirrus implementations, and they include checks for the maximum size supported by the hardware.
>
> The hardware FB width register has only 14 bits, and the HIBMC_CRT_FB_WIDTH_WIDTH_MASK macro defines the maximum size as
> 0x3FFF. Would adding the following check make the code more rigorous?

The helper here is the general mode_valid callback from 
drm_mode_config_funcs. It should only test against devide-wide limits, 
such as the available video memory.

The framebuffer size is apparently a limit of the CRTC. There's already 
a check in the CRTC's mode_valid for the supported resolutions. [4] I 
think this should be fine.

[4] 
https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c#L223

>
> Also, the pitch requires 128-byte alignment. Should we add a check here, or does the buffer created by
> `hibmc_dumb_create` already ensure that the FB start address is aligned to 128 bytes via `SZ_128`? I’m not entirely sure
> about this.

Yes, using SZ_128 aligns each scanline in the framebuffer to a multiple 
of 128 bytes. The underlying GEM buffer is sized accordingly. And the 
GEM buffer itself always starts at a page boundary. Any GEM buffer 
allocated via the dumb-buffer interface should be correct and the ioctl 
also returns the correct pitch back into user space.

The driver later programs the hardware pitch to the value stored in the 
framebuffer (in pitches[0]). If it then does a memcpy from the GEM 
buffer to video memory, it all works out.

A corner case would be that user space allocates via the dumb-buffers 
ioctl, but ignores the returned pitch. If we want to do additional 
checks for the pitch, we could add a wrapper function around fb_create. 
[5]  This would be the right place to verify that user space does not 
allocate unaligned framebuffers.

[5] 
https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c#L112

Best regards
Thomas

>
> Of course, the original code used `drm_vram_helper_mode_valid` without strictly checking these hardware limitations.
> Thank you for your modification.
>
>
> Thanks,
> Yongbang.
>
>> +	return MODE_OK;
>> +}
>> +
>>   static const struct drm_mode_config_funcs hibmc_mode_funcs = {
>> -	.mode_valid = drm_vram_helper_mode_valid,
>> +	.mode_valid = hibmc_mode_config_mode_valid,
>>   	.atomic_check = drm_atomic_helper_check,
>>   	.atomic_commit = drm_atomic_helper_commit,
>> -	.fb_create = drm_gem_fb_create,
>> +	.fb_create = drm_gem_fb_create_with_dirty,
>>   };
>>   
>>   static int hibmc_kms_init(struct hibmc_drm_private *priv)
>> @@ -130,7 +157,6 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>   	dev->mode_config.max_height = 1200;
>>   
>>   	dev->mode_config.preferred_depth = 24;
>> -	dev->mode_config.prefer_shadow = 1;
>>   
>>   	dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
>>   
>> @@ -335,18 +361,22 @@ static int hibmc_load(struct drm_device *dev)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
>>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>> +	resource_size_t vram_base, vram_size;
>>   	int ret;
>>   
>>   	ret = hibmc_hw_init(priv);
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0),
>> -				    pci_resource_len(pdev, 0));
>> -	if (ret) {
>> -		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
>> -		return ret;
>> -	}
>> +	vram_base = pci_resource_start(pdev, 0);
>> +	vram_size = pci_resource_len(pdev, 0);
>> +
>> +	priv->vram = devm_ioremap_wc(dev->dev, vram_base, vram_size);
>> +	if (!priv->vram)
>> +		return -ENOMEM;
>> +
>> +	priv->vram_base = vram_base;
>> +	priv->vram_size = vram_size;
>>   
>>   	ret = hibmc_kms_init(priv);
>>   	if (ret)
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index cd3a3fca1fe6..dce8572bf63e 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -38,6 +38,11 @@ struct hibmc_drm_private {
>>   	/* hw */
>>   	void __iomem   *mmio;
>>   
>> +	/* vram */
>> +	void __iomem *vram;
>> +	resource_size_t	vram_base;
>> +	resource_size_t	vram_size;
>> +
>>   	/* drm */
>>   	struct drm_device dev;
>>   	struct drm_plane primary_plane;
>> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
>> index 5ccdae21b94a..86b967174b60 100644
>> --- a/include/drm/drm_gem_shmem_helper.h
>> +++ b/include/drm/drm_gem_shmem_helper.h
>> @@ -141,6 +141,10 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
>>   void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
>>   			      struct drm_printer *p, unsigned int indent);
>>   
>> +int drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>> +				     struct drm_device *dev, size_t size,
>> +				     uint32_t *handle);
>> +
>>   extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
>>   
>>   /*

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


