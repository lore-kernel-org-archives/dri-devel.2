Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FBEC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0750110E404;
	Wed, 16 Sep 2026 10:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Mm8MPuFS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812F610E404;
 Wed, 16 Sep 2026 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789554846; x=1821090846;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=xKApjCo0K2StsmcpwYO5A8UzpBFVh3yMoaYsdrmTWGM=;
 b=Mm8MPuFSwlQGb8SyyD0hQRZcL1wpt0Msfc9SyNoe4Mky7xtAz2CcNXs5
 zrnu9tQ8zKfXMrNy29Ylr4NeTAk+gGb8rQzXW90APrVvTl9s1BsseIaWv
 bN/lECVQ+uXr34D/gp6lzplFfXHqW65Z2lNfmdGDYkTFy5xSVI43rFjKf
 K09XphQWXPSr79pIBBXj8Gwx3WID9nYCbl6qKlMbcPdY0emfgiVYOiYcW
 OrXEoinON+/pSsQV4ZgZzYj+NDgMQ2eTJy8HOOmA3XPefrBha2D7G5+TH
 8++/wwrU/1MQKmTw4h5nW+68WOgyZP7YoQHzJSxMwPjZ9QUpNa5FNkayb A==;
X-CSE-ConnectionGUID: 4s5GC1tFQbaud/B9fyDEog==
X-CSE-MsgGUID: HyWg3SQmRVeZ6MmsNQ8dmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90062448"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90062448"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:34:05 -0700
X-CSE-ConnectionGUID: oMjsIiDVTTaU2FOE4aD4tQ==
X-CSE-MsgGUID: hRWTUoy4RqyZyJDyPogBjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="296792093"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:34:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Melissa Wen
 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Raspberry Pi Kernel Maintenance
 <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>
Subject: Re: [PATCH v3 1/7] drm: Move drm_timeout_abs_to_jiffies() to
 drm_timeout.c
In-Reply-To: <20260915-drm-timeout-helpers-v3-1-f2ae987d861f@igalia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
 <20260915-drm-timeout-helpers-v3-1-f2ae987d861f@igalia.com>
Date: Wed, 16 Sep 2026 13:33:57 +0300
Message-ID: <0afe707fb6005b269321aa3b8706a8f1f3cfa65a@intel.com>
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

On Tue, 15 Sep 2026, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
> drm_timeout_abs_to_jiffies() began as a static helper inside the syncobj
> wait implementation and was later exported in place, so that it could be
> called by multiple drivers (e.g. panfrost, lima, tegra and accel
> drivers). All of them reach it through drm_utils.h.
>
> Give it a file of its own, so that timeout conversion helpers have a
> home, which will be useful when we add new timeout handlers. Also create
> a drm_timeout.h header to host all timeout-related helpers.
>
> No functional change.
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>  drivers/accel/ethosu/ethosu_drv.c       |  2 +-
>  drivers/accel/ivpu/ivpu_gem.c           |  2 +-
>  drivers/accel/rocket/rocket_gem.c       |  2 +-
>  drivers/gpu/drm/Makefile                |  1 +
>  drivers/gpu/drm/drm_syncobj.c           | 35 +----------------------
>  drivers/gpu/drm/drm_timeout.c           | 50 +++++++++++++++++++++++++++=
++++++
>  drivers/gpu/drm/lima/lima_gem.c         |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
>  drivers/gpu/drm/tegra/uapi.c            |  2 +-
>  drivers/gpu/drm/xe/xe_wait_user_fence.c |  2 +-
>  include/drm/drm_timeout.h               | 16 +++++++++++
>  include/drm/drm_utils.h                 |  2 --
>  12 files changed, 75 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 1cf284e7f300..1ac08f09fde8 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -12,10 +12,10 @@
>=20=20
>  #include <drm/drm_drv.h>
>  #include <drm/drm_ioctl.h>
> -#include <drm/drm_utils.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_accel.h>
>  #include <drm/drm_managed.h>
> +#include <drm/drm_timeout.h>
>  #include <drm/ethosu_accel.h>
>=20=20
>  #include "ethosu_drv.h"
> diff --git a/drivers/accel/ivpu/ivpu_gem.c b/drivers/accel/ivpu/ivpu_gem.c
> index 4f2005a8d496..563eeffb5736 100644
> --- a/drivers/accel/ivpu/ivpu_gem.c
> +++ b/drivers/accel/ivpu/ivpu_gem.c
> @@ -12,7 +12,7 @@
>  #include <drm/drm_cache.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_file.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_timeout.h>
>=20=20
>  #include "ivpu_drv.h"
>  #include "ivpu_fw.h"
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/roc=
ket_gem.c
> index a5fffa51ff35..d981c6a93ff1 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -3,7 +3,7 @@
>=20=20
>  #include <drm/drm_device.h>
>  #include <drm/drm_print.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_timeout.h>
>  #include <drm/rocket_accel.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/iommu.h>
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e635fcffd379..7283cf87880f 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -68,6 +68,7 @@ drm-y :=3D \
>  	drm_rect.o \
>  	drm_syncobj.o \
>  	drm_sysfs.o \
> +	drm_timeout.o \
>  	drm_trace_points.o \
>  	drm_vblank.o \
>  	drm_vblank_work.o \
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index c23a5de27eff..f1d4da168545 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -208,7 +208,7 @@
>  #include <drm/drm_gem.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_syncobj.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_timeout.h>
>=20=20
>  #include "drm_internal.h"
>=20=20
> @@ -1193,39 +1193,6 @@ static signed long drm_syncobj_array_wait_timeout(=
struct drm_syncobj **syncobjs,
>  	return timeout;
>  }
>=20=20
> -/**
> - * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute =
value
> - *
> - * @timeout_nsec: timeout nsec component in ns, 0 for poll
> - *
> - * Calculate the timeout in jiffies from an absolute time in sec/nsec.
> - */
> -signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
> -{
> -	ktime_t abs_timeout, now;
> -	u64 timeout_ns, timeout_jiffies64;
> -
> -	/* make 0 timeout means poll - absolute 0 doesn't seem valid */
> -	if (timeout_nsec =3D=3D 0)
> -		return 0;
> -
> -	abs_timeout =3D ns_to_ktime(timeout_nsec);
> -	now =3D ktime_get();
> -
> -	if (!ktime_after(abs_timeout, now))
> -		return 0;
> -
> -	timeout_ns =3D ktime_to_ns(ktime_sub(abs_timeout, now));
> -
> -	timeout_jiffies64 =3D nsecs_to_jiffies64(timeout_ns);
> -	/*  clamp timeout to avoid infinite timeout */
> -	if (timeout_jiffies64 >=3D MAX_SCHEDULE_TIMEOUT - 1)
> -		return MAX_SCHEDULE_TIMEOUT - 1;
> -
> -	return timeout_jiffies64 + 1;
> -}
> -EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> -
>  static int drm_syncobj_array_wait(struct drm_device *dev,
>  				  struct drm_file *file_private,
>  				  struct drm_syncobj_wait *wait,
> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
> new file mode 100644
> index 000000000000..35e10293e0a1
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_timeout.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Timeout conversion helpers for wait ioctls.
> + *
> + * Copyright 2017 Red Hat
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/jiffies.h>
> +#include <linux/ktime.h>
> +#include <linux/sched.h>
> +
> +#include <drm/drm_timeout.h>
> +
> +/**
> + * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute =
value
> + * @timeout_nsec: timeout nsec component in ns, 0 for poll
> + *
> + * Calculate the timeout in jiffies from an absolute time in ns. The res=
ult is
> + * clamped to MAX_SCHEDULE_TIMEOUT - 1 to avoid infinite timeouts.
> + *
> + * Returns:
> + * The number of jiffies until the given timeout, or the upper limit.
> + */
> +signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)

The parameter type is different from the declaration, int64_t vs. s64. I
think s64 should be preferred.

But why is the *absolute* timeout being passed in possibly negative? And
why is the return value explicitly signed? I don't get it. Of course,
not introduced by this patch.

BR,
Jani.

> +{
> +	ktime_t abs_timeout, now;
> +	u64 timeout_ns, timeout_jiffies64;
> +
> +	/* make 0 timeout means poll - absolute 0 doesn't seem valid */
> +	if (timeout_nsec =3D=3D 0)
> +		return 0;
> +
> +	abs_timeout =3D ns_to_ktime(timeout_nsec);
> +	now =3D ktime_get();
> +
> +	if (!ktime_after(abs_timeout, now))
> +		return 0;
> +
> +	timeout_ns =3D ktime_to_ns(ktime_sub(abs_timeout, now));
> +
> +	timeout_jiffies64 =3D nsecs_to_jiffies64(timeout_ns);
> +	/*  clamp timeout to avoid infinite timeout */
> +	if (timeout_jiffies64 >=3D MAX_SCHEDULE_TIMEOUT - 1)
> +		return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +	return timeout_jiffies64 + 1;
> +}
> +EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_=
gem.c
> index 0c73860bb501..97e1dc541c2e 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -10,7 +10,7 @@
>=20=20
>  #include <drm/drm_file.h>
>  #include <drm/drm_syncobj.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_timeout.h>
>=20=20
>  #include <drm/lima_drm.h>
>=20=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 96a66d673ba6..70c05210ea84 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -18,7 +18,7 @@
>  #include <drm/drm_ioctl.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_syncobj.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_timeout.h>
>=20=20
>  #include "panfrost_device.h"
>  #include "panfrost_drv.h"
> diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
> index c0ac6b45f2d7..bee310b07eb0 100644
> --- a/drivers/gpu/drm/tegra/uapi.c
> +++ b/drivers/gpu/drm/tegra/uapi.c
> @@ -7,7 +7,7 @@
>=20=20
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_timeout.h>
>=20=20
>  #include "drm.h"
>  #include "uapi.h"
> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe=
/xe_wait_user_fence.c
> index 51eb940ceb4e..e241f3ec3547 100644
> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> @@ -7,7 +7,7 @@
>=20=20
>  #include <drm/drm_device.h>
>  #include <drm/drm_file.h>
> -#include <drm/drm_utils.h>
> +#include <drm/drm_timeout.h>
>  #include <uapi/drm/xe_drm.h>
>=20=20
>  #include "xe_device.h"
> diff --git a/include/drm/drm_timeout.h b/include/drm/drm_timeout.h
> new file mode 100644
> index 000000000000..cd9621c52062
> --- /dev/null
> +++ b/include/drm/drm_timeout.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Function prototypes for timeout conversion helpers for wait ioctls.
> + *
> + * Copyright 2017 Red Hat
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef __DRM_TIMEOUT_H__
> +#define __DRM_TIMEOUT_H__
> +
> +#include <linux/types.h>
> +
> +signed long drm_timeout_abs_to_jiffies(s64 timeout_nsec);
> +
> +#endif
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> index 7e077484c5bb..c61dee76451c 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_utils.h
> @@ -25,6 +25,4 @@ struct drm_panel_backlight_quirk {
>  const struct drm_panel_backlight_quirk *
>  drm_get_panel_backlight_quirk(const struct drm_edid *edid);
>=20=20
> -signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
> -
>  #endif

--=20
Jani Nikula, Intel
