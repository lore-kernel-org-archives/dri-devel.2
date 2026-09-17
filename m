Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1D5C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654F110EEA6;
	Thu, 17 Sep 2026 12:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="YqpKqDwc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EPo3XEJX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U+OGHNBd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BYaLMfXt";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A668E10EEA3;
 Thu, 17 Sep 2026 12:39:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09E9921D59;
 Thu, 17 Sep 2026 12:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789648739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hfwml94N//0QUL0iIYXjGV7IPMWoJR+z6L22PTmzYFs=;
 b=YqpKqDwcpb91fV/E6zZPpDhG6FxCDIAzBKXRDMFvPHD3hYB9zW3hEpQxjw4pbgxUCVbwr5
 zm6Ql7sctbITTiB+7LU3pThvkw5voyej36fGRQIAbQdaVSZ3dswmga6xIOEYUn141SBcq5
 2G+8uwU/4XzO08u8GDSWxB22e0O5G4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789648739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hfwml94N//0QUL0iIYXjGV7IPMWoJR+z6L22PTmzYFs=;
 b=EPo3XEJXritQp6PGmR7TDMIVwa+VtZZxcvM0Kmw5DFm3jW5NCPnsCWxpxngzphAva/4X2m
 8KP57wmlC8RKPWBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U+OGHNBd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BYaLMfXt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789648735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hfwml94N//0QUL0iIYXjGV7IPMWoJR+z6L22PTmzYFs=;
 b=U+OGHNBdbJk6+h1fGy2DmT2dy8aZ5u1PrD5CBZ5Ww90UVR2F2slGCGVK922GszXjuJUftR
 jYlO0a0ScGWRvj6Z3yPX/9YAQ2S/yrCJL+8x/q+8A3RbK/6frsX9Z0pwD4zNGM69N89aEq
 5cGu/jdq5e5eizYXVket4GSd5jZEu3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789648735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hfwml94N//0QUL0iIYXjGV7IPMWoJR+z6L22PTmzYFs=;
 b=BYaLMfXtzOShtvEe7S8OPGref/Y4GVNT5weXS1/qdmYuiLmTqQRUDEi6elH+u7IXb1reUs
 o8j0D7PAeMC8YgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B38B134B3;
 Thu, 17 Sep 2026 12:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EiFQD17fq2q9CgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 17 Sep 2026 12:38:54 +0000
Message-ID: <e6ed76bb-e95c-48c3-b51b-99a59cb524f4@suse.de>
Date: Thu, 17 Sep 2026 14:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] drm: Allow drivers to report standardized memory stats
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Ludovico de Nittis <ludovico.denittis@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
 <20260917120444.86471-2-tvrtko.ursulin@igalia.com>
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
In-Reply-To: <20260917120444.86471-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09E9921D59
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[igalia.com,collabora.com,amd.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:email,suse.com:url,amd.com:email,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
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

Am 17.09.26 um 14:04 schrieb Tvrtko Ursulin:
> Add a DRM driver level vfunc which allows drivers to opt-in into
> reporting standardized memory stats via sysfs.
>
> Via the vfunc drivers can report a list of memory regions in a stable
> order, with the names following the memory region names used for fdinfo
> memory stats. The region names become directory names under the parent
> 'memstat' directory.
>
> Each region reports the total size of the region and its current usage,
> represented respectively in the total_mb and used_mb files present under
> the aforementioned memory region named directories.
>
> The card level 'memstat' directory is only created for drivers who report
> at least one memory region.
>
> Amdgpu example:
>
> /sys/class/drm/card1/memstat/
> ├── gtt
> │   ├── total_mb
> │   └── used_mb
> └── vram
>      ├── total_mb
>      └── used_mb

This looks simple enough to be generally useful. A-b me.

>
> Or with concrete numbers:
>
> $ grep -Hr . /sys/class/drm/card1/memstat/
> /sys/class/drm/card1/memstat/vram/total_mb:1024
> /sys/class/drm/card1/memstat/vram/used_mb:445
> /sys/class/drm/card1/memstat/gtt/total_mb:7394
> /sys/class/drm/card1/memstat/gtt/used_mb:71

These seem easy to track.  What about other, shared regions?

IIRC some systems (RasPi) use CMA areas for allocating BOs and run out 
of that quickly. Could this be represented here?

Is there a representation of 'unknown value' ?

Best regards
Thomas

>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> ---
>   drivers/gpu/drm/drm_drv.c   |  10 +++
>   drivers/gpu/drm/drm_sysfs.c | 123 ++++++++++++++++++++++++++++++++++++
>   include/drm/drm_device.h    |  19 ++++++
>   include/drm/drm_drv.h       |   8 +++
>   include/drm/drm_file.h      |   9 +++
>   include/drm/drm_sysfs.h     |   4 ++
>   6 files changed, 173 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 0cdc606af8d1..ab26cfd73002 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -54,6 +54,7 @@
>   #include <drm/drm_print.h>
>   #include <drm/drm_privacy_screen_machine.h>
>   #include <drm/drm_ras_genl_family.h>
> +#include <drm/drm_sysfs.h>
>   
>   #include "drm_crtc_internal.h"
>   #include "drm_internal.h"
> @@ -197,10 +198,15 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
>   	if (ret)
>   		goto err_debugfs;
>   
> +	ret = drm_sysfs_register_memstat(minor);
> +	if (ret)
> +		goto err_kdev;
> +
>   	/* replace NULL with @minor so lookups will succeed from now on */
>   	entry = xa_store(drm_minor_get_xa(type), minor->index, minor, GFP_KERNEL);
>   	if (xa_is_err(entry)) {
>   		ret = xa_err(entry);
> +		drm_sysfs_unregister_memstat(minor);
>   		goto err_debugfs;
>   	}
>   	WARN_ON(entry);
> @@ -208,6 +214,9 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
>   	DRM_DEBUG("new minor registered %d\n", minor->index);
>   	return 0;
>   
> +err_kdev:
> +	device_del(minor->kdev);
> +
>   err_debugfs:
>   	drm_debugfs_unregister(minor);
>   	return ret;
> @@ -224,6 +233,7 @@ static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type typ
>   	/* replace @minor with NULL so lookups will fail from now on */
>   	xa_store(drm_minor_get_xa(type), minor->index, NULL, GFP_KERNEL);
>   
> +	drm_sysfs_unregister_memstat(minor);
>   	device_del(minor->kdev);
>   	dev_set_drvdata(minor->kdev, NULL); /* safety belt */
>   	drm_debugfs_unregister(minor);
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 7b16d32b6ff6..4a8c5b0b458d 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -25,6 +25,7 @@
>   #include <drm/drm_accel.h>
>   #include <drm/drm_connector.h>
>   #include <drm/drm_device.h>
> +#include <drm/drm_drv.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_modes.h>
>   #include <drm/drm_print.h>
> @@ -589,3 +590,125 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
>   	put_device(kdev);
>   	return ERR_PTR(r);
>   }
> +
> +static ssize_t total_mb_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	struct drm_memstat_attr *mattr = container_of(kobj, typeof(*mattr), kobj);
> +	struct drm_device *drm = mattr->drm;
> +	const struct drm_memory_info *info;
> +
> +	if (drm->driver->get_memory_info) {
> +		info = drm->driver->get_memory_info(drm);
> +		if (info)
> +			return sysfs_emit(buf, "%u\n",
> +					  info->region[mattr->region].total_mb);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t used_mb_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			    char *buf)
> +{
> +	struct drm_memstat_attr *mattr = container_of(kobj, typeof(*mattr), kobj);
> +	struct drm_device *drm = mattr->drm;
> +	const struct drm_memory_info *info;
> +
> +	if (drm->driver->get_memory_info) {
> +		info = drm->driver->get_memory_info(drm);
> +		if (info)
> +			return sysfs_emit(buf, "%u\n",
> +					  info->region[mattr->region].used_mb);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct kobj_attribute total_attr = __ATTR_RO(total_mb);
> +static struct kobj_attribute used_attr = __ATTR_RO(used_mb);
> +
> +static struct attribute *memstat_attrs[] = {
> +	&total_attr.attr,
> +	&used_attr.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(memstat);
> +
> +static void kobj_memstat_release(struct kobject *kobj)
> +{
> +}
> +
> +static const struct kobj_type memstat_ktype = {
> +	.release = kobj_memstat_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = memstat_groups,
> +};
> +
> +int drm_sysfs_register_memstat(struct drm_minor *minor)
> +{
> +	const struct drm_memory_info *info = NULL;
> +	struct drm_device *drm = minor->dev;
> +	struct drm_memstat_attr *regions;
> +	struct kobject *root;
> +	int i, ret = -ENOMEM;
> +
> +	if (drm->driver->get_memory_info)
> +		info = drm->driver->get_memory_info(drm);
> +
> +	if (!info || !info->num_regions)
> +		return 0;
> +
> +	regions = kmalloc_objs(*regions, info->num_regions + 1);
> +	if (!regions)
> +		return -ENOMEM;
> +
> +	root = kobject_create_and_add("memstat", &minor->kdev->kobj);
> +	if (!root)
> +		goto err_root;
> +
> +	for (i = 0; i < info->num_regions; i++) {
> +		regions[i].region = i;
> +		regions[i].drm = drm;
> +		ret = kobject_init_and_add(&regions[i].kobj, &memstat_ktype,
> +					   root, "%s", info->region[i].name);
> +		if (ret)
> +			goto err_regions;
> +	}
> +
> +	minor->sysfs_memstat = root;
> +	minor->sysfs_memstat_regions = regions;
> +
> +	return 0;
> +
> +err_regions:
> +	while (i-- > 0) {
> +		kobject_del(&regions[i].kobj);
> +		kobject_put(&regions[i].kobj);
> +	}
> +
> +	kobject_del(root);
> +	kobject_put(root);
> +
> +err_root:
> +	kfree(regions);
> +
> +	return ret;
> +}
> +
> +void drm_sysfs_unregister_memstat(struct drm_minor *minor)
> +{
> +	struct drm_memstat_attr *region = minor->sysfs_memstat_regions;
> +
> +	while (region && region->kobj.state_initialized) {
> +		kobject_del(&region->kobj);
> +		kobject_put(&region->kobj);
> +		region++;
> +	}
> +
> +	kfree(minor->sysfs_memstat_regions);
> +
> +	kobject_del(minor->sysfs_memstat);
> +	kobject_put(minor->sysfs_memstat);
> +}
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 75f030d027ee..0c9260c85b30 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -67,6 +67,25 @@ enum switch_power_state {
>   	DRM_SWITCH_POWER_DYNAMIC_OFF = 3,
>   };
>   
> +/**
> + * struct drm_memory_region_info - Memory name and stats for a region
> + * @name: Name of the memory region
> + * @total_mb: Total available memory in mebibytes
> + * @used_mb: Used memory in mebibytes
> + */
> +struct drm_memory_region_info {
> +	char	name[24];
> +
> +	u32	total_mb;
> +	u32	used_mb;
> +};
> +
> +struct drm_memory_info {
> +	unsigned int num_regions;
> +
> +	struct drm_memory_region_info region[];
> +};
> +
>   /**
>    * struct drm_device - DRM device structure
>    *
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index b23830494ed4..a3f1906961ac 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -45,6 +45,7 @@ struct drm_minor;
>   struct dma_buf;
>   struct dma_buf_attachment;
>   struct drm_display_mode;
> +struct drm_device_memory_info;
>   struct drm_mode_create_dumb;
>   struct drm_printer;
>   struct sg_table;
> @@ -387,6 +388,13 @@ struct drm_driver {
>   	 */
>   	void (*show_fdinfo)(struct drm_printer *p, struct drm_file *f);
>   
> +	/**
> +	 * @get_memory_info:
> +	 *
> +	 * Get device specific memory info.  See Documentation/gpu/drm-memory-info.rst.
> +	 */
> +	const struct drm_memory_info * (*get_memory_info)(struct drm_device *dev);
> +
>   	/** @major: driver major number */
>   	int major;
>   	/** @minor: driver minor number */
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 6ee70ad65e1f..ebb227a91f60 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -66,6 +66,12 @@ enum drm_minor_type {
>   	DRM_MINOR_ACCEL = 32,
>   };
>   
> +struct drm_memstat_attr {
> +	struct kobject kobj;
> +	unsigned int region;
> +	struct drm_device *drm;
> +};
> +
>   /**
>    * struct drm_minor - DRM device minor structure
>    *
> @@ -82,6 +88,9 @@ struct drm_minor {
>   	struct device *kdev;		/* Linux device */
>   	struct drm_device *dev;
>   
> +	struct kobject	*sysfs_memstat;
> +	struct drm_memstat_attr  *sysfs_memstat_regions;
> +
>   	struct dentry *debugfs_symlink;
>   	struct dentry *debugfs_root;
>   };
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 7695873a9456..10ed468965b0 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -4,10 +4,14 @@
>   
>   struct drm_device;
>   struct drm_connector;
> +struct drm_minor;
>   struct drm_property;
>   
>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>   void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
>   void drm_sysfs_connector_property_event(struct drm_connector *connector,
>   					struct drm_property *property);
> +
> +int drm_sysfs_register_memstat(struct drm_minor *minor);
> +void drm_sysfs_unregister_memstat(struct drm_minor *minor);
>   #endif

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


