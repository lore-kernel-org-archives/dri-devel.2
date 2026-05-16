Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFFECD4F3C
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 13:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE8F10E098;
	Sat, 16 May 2026 13:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aUiQgmW+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F5D10E098
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 13:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hg5koSK88GNTPNtB54sLaSvXDg2Npu+cx3T1iNwNOWI=; b=aUiQgmW+Xaiiwi1wnDepzOmqlF
 aYI6mvgRCWcxxU7HAJ3ogL4r4/JzqQaSLqXP3KhmlOTacUlBiOxQGgFtbIrftn4tPUR76eTfYZV92
 q24U9GsHJZoy1AnNzDGL/woRK9Af6/7DRpfJwXXs2nEHe3rWV8kxnmOXQJNDCAg8gb/z1mCdIwUCr
 vTN6njYqg3rilqtGBNbdEJpQIACUef1kIyH69iO61MnFpIB/sM3p5W9GuIJ2vEvSR3tNVTQ46Y2Pp
 hmEvwRPodfgb0Hfy8pP8jwiRhnQ5kDMC7/s0kk//Y0cJk3xrsJU+skx9GHO0terpY2QUDxRnrhqY3
 51Cb/6PQ==;
Received: from [189.7.87.67] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wOEzT-000xR1-57; Sat, 16 May 2026 15:23:39 +0200
Message-ID: <bb4a9db8-9db1-4f92-8fb3-87415e467df4@igalia.com>
Date: Sat, 16 May 2026 10:23:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel: ethosu: Add performance counter support
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hardening@vger.kernel.org
References: <20260515032625.1880618-1-robh@kernel.org>
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
In-Reply-To: <20260515032625.1880618-1-robh@kernel.org>
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

Hi Rob,

On 15/05/26 00:26, Rob Herring (Arm) wrote:
> The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
> supports up to 4 (U65) or 8 (U85) counters which can be programmed for
> different events. There is also a dedicated cycle counter.
> 
> The ABI and implementation are copied from the V3D driver. The main
> difference in the ABI is there is no query API for the the event list.
> The events differ between the U65 and U85, so the events lists are
> maintained in userspace along with other differences between the U65 and
> U85.
> 
> The cycle counter is always enabled when the PMU is enabled. When the
> user requests N events, reading the counters will return the N events
> plus the cycle counter.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>   - Use XArray instead of idr
>   - Rework locking to use per device spinlock to protect modifying active
>     perfmon. Based on pending V3D changes:
>     https://lore.kernel.org/all/20260508-v3d-perfmon-lifetime-v1-1-f5b5642c085f@igalia.com/
>   - Add missing perfmon puts in ethosu_ioctl_perfmon_set_global() and
>     ethosu_ioctl_perfmon_get_values() error paths.
>   - Fix reading number of counters on U85.
>   - Add defines NPU_REG_PMCCNTR_CFG
> ---
>   drivers/accel/ethosu/Makefile         |   2 +-
>   drivers/accel/ethosu/ethosu_device.h  |  32 +++
>   drivers/accel/ethosu/ethosu_drv.c     |  21 +-
>   drivers/accel/ethosu/ethosu_drv.h     |  62 +++++-
>   drivers/accel/ethosu/ethosu_job.c     |  41 +++-
>   drivers/accel/ethosu/ethosu_job.h     |   2 +
>   drivers/accel/ethosu/ethosu_perfmon.c | 296 ++++++++++++++++++++++++++
>   include/uapi/drm/ethosu_accel.h       |  59 ++++-
>   8 files changed, 500 insertions(+), 15 deletions(-)
>   create mode 100644 drivers/accel/ethosu/ethosu_perfmon.c
> 

[...]

> diff --git a/drivers/accel/ethosu/ethosu_drv.h b/drivers/accel/ethosu/ethosu_drv.h
> index 9e21dfe94184..8fed43c2a7af 100644
> --- a/drivers/accel/ethosu/ethosu_drv.h
> +++ b/drivers/accel/ethosu/ethosu_drv.h
> @@ -1,15 +1,75 @@
>   /* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> -/* Copyright 2025 Arm, Ltd. */
> +/* Copyright 2025-2026 Arm, Ltd. */
>   #ifndef __ETHOSU_DRV_H__
>   #define __ETHOSU_DRV_H__
>   
> +#include <linux/mutex.h>
> +#include <linux/xarray.h>
>   #include <drm/gpu_scheduler.h>
>   
>   struct ethosu_device;
> +struct drm_device;
> +struct drm_file;
>   
>   struct ethosu_file_priv {
>   	struct ethosu_device *edev;
>   	struct drm_sched_entity sched_entity;
> +	struct xarray perfmons;
>   };
>   
> +/* Performance monitor object. The perform lifetime is controlled by userspace
> + * using perfmon related ioctls. A perfmon can be attached to a submit_cl

submit_cl?

> + * request, and when this is the case, HW perf counters will be activated just
> + * before the submit_cl is submitted to the GPU and disabled when the job is

Maybe replace the "submit_cl is submitted to the GPU" with NPU related
wording?

> + * done. This way, only events related to a specific job will be counted.
> + */
> +struct ethosu_perfmon {
> +	/* Tracks the number of users of the perfmon, when this counter reaches
> +	 * zero the perfmon is destroyed.
> +	 */
> +	refcount_t refcnt;
> +
> +	/* Number of counters activated in this perfmon instance
> +	 * (should be less than or equal to DRM_ETHOSU_MAX_PERF_COUNTERS).
> +	 */
> +	u8 ncounters;
> +
> +	/* Events counted by the HW perf counters. */
> +	u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
> +
> +	/*
> +	 * Storage for counter values. Counters are incremented by the HW
> +	 * perf counter values every time the perfmon is attached to a
> +	 * NPU job. This way, perfmon users don't have to retrieve the
> +	 * results after each job if they want to track events covering
> +	 * several submissions. Note that counter values can't be reset,
> +	 * but you can fake a reset by destroying the perfmon and
> +	 * creating a new one.
> +	 */
> +	u64 values[] __counted_by(ncounters);
> +};
> +
> +/* ethosu_perfmon.c */
> +void ethosu_perfmon_init(struct ethosu_device *ethosu);
> +void ethosu_perfmon_get(struct ethosu_perfmon *perfmon);
> +void ethosu_perfmon_put(struct ethosu_perfmon *perfmon);
> +void ethosu_perfmon_start(struct ethosu_device *ethosu,
> +			  struct ethosu_perfmon *perfmon);
> +void ethosu_perfmon_stop(struct ethosu_device *ethosu,
> +			 struct ethosu_perfmon *perfmon, bool capture);
> +void ethosu_perfmon_stop_locked(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
> +				bool capture);
> +struct ethosu_perfmon *ethosu_perfmon_find(struct ethosu_file_priv *ethosu_priv,
> +					   int id);
> +void ethosu_perfmon_open_file(struct ethosu_file_priv *ethosu_priv);
> +void ethosu_perfmon_close_file(struct ethosu_file_priv *ethosu_priv);
> +int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
> +				struct drm_file *file_priv);
> +int ethosu_ioctl_perfmon_destroy(struct drm_device *dev, void *data,
> +				 struct drm_file *file_priv);
> +int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
> +				    struct drm_file *file_priv);
> +int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data,
> +				    struct drm_file *file_priv);
> +
>   #endif
> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
> index e7b07cdbcced..5712848236af 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /* Copyright 2024-2025 Tomeu Vizoso <tomeu@tomeuvizoso.net> */
> -/* Copyright 2025 Arm, Ltd. */
> +/* Copyright 2025-2026 Arm, Ltd. */
>   
>   #include <linux/bitfield.h>
>   #include <linux/genalloc.h>
> @@ -147,6 +147,8 @@ static void ethosu_job_err_cleanup(struct ethosu_job *job)
>   {
>   	unsigned int i;
>   
> +	ethosu_perfmon_put(job->perfmon);
> +
>   	for (i = 0; i < job->region_cnt; i++)
>   		drm_gem_object_put(job->region_bo[i]);
>   
> @@ -181,6 +183,26 @@ static void ethosu_job_free(struct drm_sched_job *sched_job)
>   	ethosu_job_put(job);
>   }
>   
> +static void
> +ethosu_switch_perfmon(struct ethosu_device *ethosu, struct ethosu_job *job)
> +{
> +	struct ethosu_perfmon *perfmon;
> +
> +	guard(spinlock)(&ethosu->perfmon_state.lock);
> +
> +	perfmon = READ_ONCE(ethosu->global_perfmon);

Considering that you are under the spinlock, I believe that using
READ_ONCE is unneeded.

> +	if (!perfmon)
> +		perfmon = job->perfmon;
> +
> +	if (perfmon == ethosu->perfmon_state.active)
> +		return;
> +
> +	ethosu_perfmon_stop_locked(ethosu, ethosu->perfmon_state.active, true);
> +
> +	if (perfmon && ethosu->perfmon_state.active != perfmon)
> +		ethosu_perfmon_start(ethosu, perfmon);

Also, if you are going to keep ethosu_switch_perfmon(), you don't need
to use a spinlock. In V3D, I'm only using a spinlock because I'm
stopping the perfmon in a IRQ context. But considering that you are
stopping the perfmon in run_job(), you can use a sleeping mutex.

Moreover, I believe that if (perfmon != NULL) then automatically
(ethosu->perfmon_state.active != perfmon) as we already checked if
(perfmon == ethosu->perfmon_state.active).

Best regards,
- Maíra
