Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF75CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C686610EA07;
	Tue, 23 Jun 2026 08:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="PpMac4kh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wER/v2e+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ym23nZ0v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LiYrJONR";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5066010EA07
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:42:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8616370CFD;
 Tue, 23 Jun 2026 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782203021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y3zd5lSKoXLu+EGE/nC1n0o6YyGde/DELMkM89CcqEg=;
 b=PpMac4khD0S3h76Uk5pPO4sUcLWExqDNs4fxSHtcpkrh4GOkXFAaRB802FWNdNBKYTvkfK
 L4wCIFgcnSxwgjj/EC+qpnSOf7f79HVIrp0XYWMAHRrNzF6zhumS6oQ5HemhqHAVR7PPhe
 t5LKEI2cFXOElsbHkozJgu21p26hBrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782203021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y3zd5lSKoXLu+EGE/nC1n0o6YyGde/DELMkM89CcqEg=;
 b=wER/v2e++Hb/eTkJxNX0RoPcmOqmAFlp4Qaw+ZIlsijrsNr4GzrD6MWvrX+2Lfk/JU4L+q
 6xrjN2WFdrqJIwAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782203016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y3zd5lSKoXLu+EGE/nC1n0o6YyGde/DELMkM89CcqEg=;
 b=Ym23nZ0varD2OuA57TYnN9G4yKF2E2OieJrkD2WkVwp+hc8SaHH+LEOJM8uDCCGIHvdAOa
 k708o+cIglSAy/mEhI1q563rnXRBikBSiunM+sEPwLxwNUbajMV+7frrFONctoN1wwD9uk
 O/3bEkgUWrF+WDjvh6ivNmSDsRYkv7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782203016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y3zd5lSKoXLu+EGE/nC1n0o6YyGde/DELMkM89CcqEg=;
 b=LiYrJONRWb8aqYN+DCjfg/tZkYLqbr+ik611G47Elbost0nsgSrD55Qb9GNYz/SKqJHl+f
 vHQ4Rxs21Nn0w5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20331779AB;
 Tue, 23 Jun 2026 08:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hj6fBohCOmpjRwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 23 Jun 2026 08:23:36 +0000
Message-ID: <6fe9c03a-4104-4949-9e9c-af750b360e09@suse.de>
Date: Tue, 23 Jun 2026 10:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] drm/hibmc: Use gem-shmem with shadow-plane helpers
 for memory management
To: Yongbang Shi <shiyongbang@huawei.com>, tiantao6@hisilicon.com,
 kong.kongxinwei@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 "Liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>,
 "fengsheng (A)" <fengsheng5@huawei.com>
References: <20260618123142.92298-1-tzimmermann@suse.de>
 <20260618123142.92298-7-tzimmermann@suse.de>
 <368398d6-e4a0-42a2-9226-1200b783bd1e@huawei.com>
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
In-Reply-To: <368398d6-e4a0-42a2-9226-1200b783bd1e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SEM_URIBL_UNKNOWN_FAIL(0.00)[huawei.com:query timed out];
 FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[huawei.com:query timed out];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Am 23.06.26 um 09:16 schrieb Yongbang Shi:
>> Replace the gem-vram memory manager with gem-shmem. Makes the driver more
>> robust and enables dma-buf sharing with other hardware.
>>
>> Gem-vram was created from various drivers that used TTM for their memory
>> management. All these drivers have meanwhile been converted to gem-shmem.
>> Using gem-vram is deprecated because it has several problems.
>>
>> * TTM requires significant overcommitment of video memory for reliable
>> page flips. There needs to be 3 times the size of the largest possible
>> framebuffer available or page flips can fail. This leaves the display
>> dark without further warning. Hibmc hardware with 32 MiB and a maximum
>> framebuffer size of 1920x2000 is at the limit.
>>
>> * No dma-buf sharing without GTT support. Neither gem-vram nor hibmc
>> hardware support a GTT address space. This is required to share buffers
>> with other devices via dma-buf interfaces.
>>
>> * TTM requires hardware-accelerated rendering into video memory for
>> optimal results. As hibmc hardware cannot do this, hibmc renders in
>> system memory and copies the result to video memory. This can be more
>> effectively implemented with gem-shmem and DRM's shadow-plane helpers.
>>
>> Converting hibmc to gem-shmem and shadow-plane helpers.
>>
>> * Replace gem-vram entry points in struct drm_driver with gem-shmem
>> equivalents. This makes the driver allocate struct drm_gem_shmem_object
>> for its buffers.
>>
>> * Use DRM_GEM_SHADOW_*_PLANE for its plane funcs and plane-helper
>> funcs. The shadow-plane helpers map a plane's gem buffer objects into
>> kernel address space during a page flip, so that atomic_update can
>> copy them to video memory.
>>
>> * Handle framebuffer damage in hibmc_plane_atomic_update(). This updates
>> video memory from the plane's framebuffer. It automatically synchronizes
>> shared buffers with other devices. Create the framebuffer with
>> drm_gem_fb_create_with_dirty() to trigger the update on each page flip.
>>
>> * Initialize the plane with drm_plane_enable_fb_damage_clips() to limit
>> the damage updates to the framebuffer areas that changed. We don't want
>> to do a full-buffer memcpy if only a small area has changed.
>>
>> * Test display modes against the available video memory in
>> hibmc_mode_config_mode_valid(). We only want to announce display modes
>> that fit into display memory.
>>
>> * Map the display memory itself into kernel address space.
>>
>> * Do not set drm_mode_config.prefer_shadow. This would advise user space
>> to install a shadow buffer. But with gem-shmem, the gem buffer object
>> already acts as a shadow buffer for video memory.
>>
>> We use these patterns in many other drivers with similar limitation as
>> hibmc and its hardware. With these changes in place, hibmc is more robust
>> and better integrated into the overall DRM framework.
>>
>> v3:
>> - fix coding style
>> v2:
>> - do not select TTM symbols
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/drm_gem_shmem_helper.c        | 22 +++++--
>>   drivers/gpu/drm/hisilicon/hibmc/Kconfig       |  4 +-
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 38 ++++++++----
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 62 ++++++++++++++-----
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  5 ++
>>   include/drm/drm_gem_shmem_helper.h            |  4 ++
>>   6 files changed, 100 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index c989459eb215..22ec52e2ffb8 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -473,10 +473,23 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gem_shmem_vunmap_locked);
>>   
>> -static int
>> -drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>> -				 struct drm_device *dev, size_t size,
>> -				 uint32_t *handle)
>> +/**
>> + * drm_gem_shmem_create_with_handle - Allocate an object with the given size and
>> + *	returns a GEM handle
>> + * @file_priv: DRM file structure to create the dumb buffer for
>> + * @dev: DRM device
>> + * @size: Size of the object to allocate
>> + * @handle: Returns the GEM handle on success
>> + *
>> + * Allocates an shmem GEM buffer using drm_gem_shmem_create() and returns
>> + * a GEM handle to it.
>> + *
>> + * Returns:
>> + * Zero on success, or an error code otherwise.
>> + */
>> +int drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>> +				     struct drm_device *dev, size_t size,
>> +				     uint32_t *handle)
>>   {
>>   	struct drm_gem_shmem_object *shmem;
>>   	int ret;
>> @@ -495,6 +508,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
>>   
>>   	return ret;
>>   }
>> +EXPORT_SYMBOL_GPL(drm_gem_shmem_create_with_handle);
>>   
>>   /* Update madvise status, returns true if not purged, else
>>    * false or -errno.
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
>> index d1f3f5793f34..adf4516bf8f6 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
>> @@ -5,10 +5,8 @@ config DRM_HISI_HIBMC
>>   	select DRM_CLIENT_SELECTION
>>   	select DRM_DISPLAY_HELPER
>>   	select DRM_DISPLAY_DP_HELPER
>> +	select DRM_GEM_SHMEM_HELPER
>>   	select DRM_KMS_HELPER
>> -	select DRM_VRAM_HELPER
>> -	select DRM_TTM
>> -	select DRM_TTM_HELPER
>>   	select I2C
>>   	select I2C_ALGOBIT
>>   	help
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> index fe73b365e547..b4ab53db1c08 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> @@ -15,8 +15,10 @@
>>   
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_damage_helper.h>
>>   #include <drm/drm_fourcc.h>
>> -#include <drm/drm_gem_vram_helper.h>
>> +#include <drm/drm_gem_atomic_helper.h>
>> +#include <drm/drm_gem_framebuffer_helper.h>
>>   #include <drm/drm_vblank.h>
>>   
>>   #include "hibmc_drm_drv.h"
>> @@ -100,22 +102,35 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
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
>>   	if (!fb)
>>   		return;
>>   
>> -	gbo = drm_gem_vram_of_gem(fb->obj[0]);
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
>>   
>>   	writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
>>   
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
>> index 55d175028c46..4d85c89f3f88 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -19,9 +19,10 @@
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
>> @@ -72,7 +73,13 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
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
>> @@ -82,10 +89,9 @@ static const struct drm_driver hibmc_driver = {
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
>> @@ -107,6 +113,27 @@ static const struct dev_pm_ops hibmc_pm_ops = {
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
>> +	return MODE_OK;
>> +}
>> +
>>   static struct drm_framebuffer *hibmc_mode_config_fb_create(struct drm_device *dev,
>>   							   struct drm_file *file_priv,
>>   							   const struct drm_format_info *info,
>> @@ -119,11 +146,11 @@ static struct drm_framebuffer *hibmc_mode_config_fb_create(struct drm_device *de
>>   			return ERR_PTR(-EINVAL);
>>   	}
>>   
>> -	return drm_gem_fb_create(dev, file_priv, info, mode_cmd);
>> +	return drm_gem_fb_create_with_dirty(dev, file_priv, info, mode_cmd);
>>   }
>>   
>>   static const struct drm_mode_config_funcs hibmc_mode_funcs = {
>> -	.mode_valid = drm_vram_helper_mode_valid,
>> +	.mode_valid = hibmc_mode_config_mode_valid,
>>   	.atomic_check = drm_atomic_helper_check,
>>   	.atomic_commit = drm_atomic_helper_commit,
>>   	.fb_create = hibmc_mode_config_fb_create,
>> @@ -146,7 +173,6 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>   	dev->mode_config.max_height = 1200;
>>   
>>   	dev->mode_config.preferred_depth = 24;
>> -	dev->mode_config.prefer_shadow = 1;
>>   
>>   	dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
>>   
>> @@ -351,18 +377,22 @@ static int hibmc_load(struct drm_device *dev)
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
>> index b2c23af628e1..bcbb92f3fe9b 100644
>> --- a/include/drm/drm_gem_shmem_helper.h
>> +++ b/include/drm/drm_gem_shmem_helper.h
>> @@ -142,6 +142,10 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
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
>
> Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>

Great, thanks a lot. This is the last r-b needed. Maybe I'll go over the 
series one more time or I'll merged it.


Sashiko had a number of comments that might be worth addressing in 
follow-up patches. Those two look more sever than they are:

- [Critical] Missing bounds check on framebuffer size and pitch allows 
an out-of-bounds write into the memory mapped VRAM. The largest accepted 
framebuffer is 1920*1200*4 == ~9 MiB. And the minimum size of the video 
memory is 16 MiB , right? So we should be safe. Addressing this issue 
might later be worth a general series that goes into all of the related 
drivers. - [High] Sleep in atomic context due to manual call of 
`drm_gem_fb_begin_cpu_access()` inside plane atomic update. This is a 
false positive. The atomic update doesn't run in atomic context. It's 
named 'atomic' because it's an all-or-nothing operation. Best regards 
Thomas

> Thanks,
> Yongbang.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


