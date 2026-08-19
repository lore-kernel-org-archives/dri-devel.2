Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541C3C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38FE10E12F;
	Wed, 19 Aug 2026 12:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ALko1TCJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E254510E12F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787142409; x=1818678409;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=vwZRgFHZ/tOhpEeyXCrt2i9ufDGJCoESeecVWMTZLv0=;
 b=ALko1TCJ+8HM+QuB9flUFLlJgmx0/M3j3uDr6C/CxWbWUK8DULoSw3Wj
 mFNMqw2V6LfykC7TIlXHUy2VMNmguXuWAo2QqTk1yDyB+0X3W7dYM6+W9
 lYPODNBesD6FkhZKbS22N79DEqmKCrWvBpQ9p9vNYU5mG0Ed/WqJdtqER
 2k9bUA3bcnVssNkay9UvMB/Q6zNn/RazqHdwQAkrTeVmcwULxParQuzEx
 dcAdhDc6DtTHLPpxKUYTVNHsw0+FuMEtRU5gqhxQ2Are1SJd1vkzmLN5P
 Y9NIXjkYEAWW9ECPr3FVNh991vYFWwLclq4yOUWR0eSmrTsHeRHD9Tbq7 A==;
X-CSE-ConnectionGUID: bl+l431tRL27dzxv2klODw==
X-CSE-MsgGUID: OuaX2l71RaKp1YT1xhqOSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87718993"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87718993"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:26:48 -0700
X-CSE-ConnectionGUID: aytcv2G6RB+XvNch3Rswmw==
X-CSE-MsgGUID: knhdRUrKS52GOWW8E7IKXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="269037710"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.152])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 05:26:45 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Thomas =?utf-8?Q?Hel?=
 =?utf-8?Q?lstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>, Maxime Ripard <mripard@kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, =?utf-8?Q?Ma?=
 =?utf-8?Q?=C3=ADra?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH] drm/sysfs: Remove drm_class_device_(un)register()
In-Reply-To: <20260803132706.1497980-2-mcanal@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260803132706.1497980-2-mcanal@igalia.com>
Date: Wed, 19 Aug 2026 15:26:42 +0300
Message-ID: <266b6c6743b2d029063c886bf36bab673bcc4df9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 03 Aug 2026, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
> The last usage of the functions drm_class_device_register() and
> drm_class_device_unregister() was removed in commit ed89fff97382
> ("drm/ttm: drop sysfs directory").
>
> Remove such functions as they are no longer used.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_sysfs.c      | 32 --------------------------------
>  drivers/gpu/drm/ttm/ttm_module.c |  1 -
>  include/drm/drm_sysfs.h          |  4 ----
>  3 files changed, 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index ef4e923a8728..7b16d32b6ff6 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -589,35 +589,3 @@ struct device *drm_sysfs_minor_alloc(struct drm_mino=
r *minor)
>  	put_device(kdev);
>  	return ERR_PTR(r);
>  }
> -
> -/**
> - * drm_class_device_register - register new device with the DRM sysfs cl=
ass
> - * @dev: device to register
> - *
> - * Registers a new &struct device within the DRM sysfs class. Essentiall=
y only
> - * used by ttm to have a place for its global settings. Drivers should n=
ever use
> - * this.
> - */
> -int drm_class_device_register(struct device *dev)
> -{
> -	if (!drm_class || IS_ERR(drm_class))
> -		return -ENOENT;
> -
> -	dev->class =3D drm_class;
> -	return device_register(dev);
> -}
> -EXPORT_SYMBOL_GPL(drm_class_device_register);
> -
> -/**
> - * drm_class_device_unregister - unregister device with the DRM sysfs cl=
ass
> - * @dev: device to unregister
> - *
> - * Unregisters a &struct device from the DRM sysfs class. Essentially on=
ly used
> - * by ttm to have a place for its global settings. Drivers should never =
use
> - * this.
> - */
> -void drm_class_device_unregister(struct device *dev)
> -{
> -	return device_unregister(dev);
> -}
> -EXPORT_SYMBOL_GPL(drm_class_device_unregister);
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_m=
odule.c
> index aa137ead5cc5..3daace105930 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -34,7 +34,6 @@
>  #include <linux/pgtable.h>
>  #include <linux/sched.h>
>  #include <linux/debugfs.h>
> -#include <drm/drm_sysfs.h>
>  #include <drm/ttm/ttm_caching.h>
>=20=20
>  #include "ttm_module.h"
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 96a5d858404b..7695873a9456 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -3,13 +3,9 @@
>  #define _DRM_SYSFS_H_
>=20=20
>  struct drm_device;
> -struct device;
>  struct drm_connector;
>  struct drm_property;
>=20=20
> -int drm_class_device_register(struct device *dev);
> -void drm_class_device_unregister(struct device *dev);
> -
>  void drm_sysfs_hotplug_event(struct drm_device *dev);
>  void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
>  void drm_sysfs_connector_property_event(struct drm_connector *connector,

--=20
Jani Nikula, Intel
