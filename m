Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F27C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC4410E562;
	Wed, 19 Aug 2026 12:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NDRcyut7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5545310E562
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Hk5Lsu4WomfbukMoxZbKQtgXiEaQgcxX2X6gOLqJkjc=; b=NDRcyut7UsyYADzLl84k/UK+vy
 4xYS/CZk3NiDZgEFqXcCduxaRf/MU9+Amwm0AnHn9sOAgupbusMvLTowwpsRv9DUjB1hHLki8MA6j
 P6Aa1kFpESZq0IFHvNHQv89wyCfbKJcG0TYa9ltFq0jWh21r7VRxwgRFpW5TvKL//fdlQIW2KvGvc
 jcl5R7duFQuDAVOONyYjRUHr+U3qzdNwfwJKhr7xKqq2kmwYOTCZ3+S6QmAAoTf+ajtInX72p6D4Z
 7XkUugBBCeAcowFLp03wusoW7VZLMEc+tlSMUeNjNpVVa1i6SPtmE/skxqa5RWUN6bVEak/W7vUG9
 ARgQjcAA==;
Received: from [179.105.94.163] (helo=[192.168.0.6])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wwf9B-0065Io-7s; Wed, 19 Aug 2026 14:11:57 +0200
Message-ID: <71474cf6-e0f4-4961-8302-7b893143ef98@igalia.com>
Date: Wed, 19 Aug 2026 09:11:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sysfs: Remove drm_class_device_(un)register()
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260803132706.1497980-2-mcanal@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260803132706.1497980-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

Gentle ping for feedback.

Best regards,
- Maíra

On 03/08/26 10:26, Maíra Canal wrote:
> The last usage of the functions drm_class_device_register() and
> drm_class_device_unregister() was removed in commit ed89fff97382
> ("drm/ttm: drop sysfs directory").
> 
> Remove such functions as they are no longer used.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/drm_sysfs.c      | 32 --------------------------------
>   drivers/gpu/drm/ttm/ttm_module.c |  1 -
>   include/drm/drm_sysfs.h          |  4 ----
>   3 files changed, 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index ef4e923a8728..7b16d32b6ff6 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -589,35 +589,3 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
>   	put_device(kdev);
>   	return ERR_PTR(r);
>   }
> -
> -/**
> - * drm_class_device_register - register new device with the DRM sysfs class
> - * @dev: device to register
> - *
> - * Registers a new &struct device within the DRM sysfs class. Essentially only
> - * used by ttm to have a place for its global settings. Drivers should never use
> - * this.
> - */
> -int drm_class_device_register(struct device *dev)
> -{
> -	if (!drm_class || IS_ERR(drm_class))
> -		return -ENOENT;
> -
> -	dev->class = drm_class;
> -	return device_register(dev);
> -}
> -EXPORT_SYMBOL_GPL(drm_class_device_register);
> -
> -/**
> - * drm_class_device_unregister - unregister device with the DRM sysfs class
> - * @dev: device to unregister
> - *
> - * Unregisters a &struct device from the DRM sysfs class. Essentially only used
> - * by ttm to have a place for its global settings. Drivers should never use
> - * this.
> - */
> -void drm_class_device_unregister(struct device *dev)
> -{
> -	return device_unregister(dev);
> -}
> -EXPORT_SYMBOL_GPL(drm_class_device_unregister);
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
> index aa137ead5cc5..3daace105930 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -34,7 +34,6 @@
>   #include <linux/pgtable.h>
>   #include <linux/sched.h>
>   #include <linux/debugfs.h>
> -#include <drm/drm_sysfs.h>
>   #include <drm/ttm/ttm_caching.h>
>   
>   #include "ttm_module.h"
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 96a5d858404b..7695873a9456 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -3,13 +3,9 @@
>   #define _DRM_SYSFS_H_
>   
>   struct drm_device;
> -struct device;
>   struct drm_connector;
>   struct drm_property;
>   
> -int drm_class_device_register(struct device *dev);
> -void drm_class_device_unregister(struct device *dev);
> -
>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>   void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
>   void drm_sysfs_connector_property_event(struct drm_connector *connector,

