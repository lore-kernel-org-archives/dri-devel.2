Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C50CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFA910E0C6;
	Tue,  5 May 2026 18:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LsTkprKQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F8E10E0C6
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 18:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cIHShsNDWJmn62koeyu1g39PsU0+Rb7aEMk1CkKQJ+g=; b=LsTkprKQyFFJvlyjW9nzbST9HS
 a7ZlAyBYGfV7JZtmhl2q7JcAOucD5QDQDlkLzFzWW/8MYIYKroJN4HDiPF7t69jYgSqpqzA3/hD0T
 G7s+GqQALT8NMX3o9PCywZanJ7Gq04M8XzYVZoNM+X7dK1pDNtsw0l4KM1lsgxH3OPKwJW+8EBIYR
 uiJ/F339BI5oTSolhocrLD/8oI97TkO5Pph6dgXirPasLDGEEBnXCY4Xua3RznUPoV+4PU1ylU+VQ
 +YmIrspehF9juhlAbAHovc4MdwvU+PXs0w2ya2Wq43P8I06ZV8H0PTIShls51qG/ggLca0h6ew4dF
 4pudqAtg==;
Received: from [189.7.87.137] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wKKmZ-006ZVq-Km; Tue, 05 May 2026 20:46:11 +0200
Message-ID: <f4b64049-e7f4-4d96-84f2-e8dac2cf5322@igalia.com>
Date: Tue, 5 May 2026 15:46:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: ethosu: Add performance counter support
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hardening@vger.kernel.org
References: <20260306163658.2741860-2-robh@kernel.org>
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
In-Reply-To: <20260306163658.2741860-2-robh@kernel.org>
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

On 06/03/26 13:36, Rob Herring (Arm) wrote:
> The Arm Ethos-U NPUs have a PMU with performance counters. The PMU h/w
> supports up to 4 (U65) or 8 (U85) counters which can be programmed for
> different events. There is also a dedicated cycle counter.
> 
> The ABI and implementation are copied from the V3D driver. The main

I'm planning to send a series fixing some perfmon locking issues in the
V3D driver later this week. But, to give you a brief summary of the main
issues:

1. The active perfmon is not protected against races (run_job() vs.
IOCTLs).

2. ethosu_switch_perfmon() only starts/stops the perfmon in run_job().
This means that if nothing is further queued up, a perfmon will never
actually be stopped.

More comments inline:

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
> MR for mesa with initial support is here:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40269
> 
>   drivers/accel/ethosu/Makefile         |   2 +-
>   drivers/accel/ethosu/ethosu_device.h  |  21 ++
>   drivers/accel/ethosu/ethosu_drv.c     |  17 +-
>   drivers/accel/ethosu/ethosu_drv.h     |  62 ++++++
>   drivers/accel/ethosu/ethosu_job.c     |  35 +++-
>   drivers/accel/ethosu/ethosu_job.h     |   2 +
>   drivers/accel/ethosu/ethosu_perfmon.c | 282 ++++++++++++++++++++++++++
>   include/uapi/drm/ethosu_accel.h       |  59 +++++-
>   8 files changed, 469 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/accel/ethosu/ethosu_perfmon.c
> 

[...]

> diff --git a/drivers/accel/ethosu/ethosu_drv.h b/drivers/accel/ethosu/ethosu_drv.h
> index 9e21dfe94184..57eee79e4b83 100644
> --- a/drivers/accel/ethosu/ethosu_drv.h
> +++ b/drivers/accel/ethosu/ethosu_drv.h
> @@ -3,13 +3,75 @@
>   #ifndef __ETHOSU_DRV_H__
>   #define __ETHOSU_DRV_H__
>   
> +#include <linux/idr.h>
> +#include <linux/mutex.h>
>   #include <drm/gpu_scheduler.h>
>   
>   struct ethosu_device;
> +struct drm_device;
> +struct drm_file;
>   
>   struct ethosu_file_priv {
>   	struct ethosu_device *edev;
>   	struct drm_sched_entity sched_entity;
> +
> +	struct {
> +		struct idr idr;

You may want to consider moving to XArray as we did in V3D [1].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a5b0d095bcdb219348ed8ae1c97ee99fc4913b8

> +		struct mutex lock;
> +	} perfmon;
> +};
> +
> +/* Performance monitor object. The perform lifetime is controlled by userspace
> + * using perfmon related ioctls. A perfmon can be attached to a submit_cl
> + * request, and when this is the case, HW perf counters will be activated just
> + * before the submit_cl is submitted to the GPU and disabled when the job is
> + * done. This way, only events related to a specific job will be counted.
> + */
> +struct ethosu_perfmon {
> +	/* Tracks the number of users of the perfmon, when this counter reaches
> +	 * zero the perfmon is destroyed.
> +	 */
> +	refcount_t refcnt;
> +
> +	/* Protects perfmon stop, as it can be invoked from multiple places. */
> +	struct mutex lock;

I'm not familiar with the Ethos hardware, but *if* it has only a single
performance monitor active in HW at any given moment (like v3d), this
lock doesn't enforce this restriction.

This lock only serializes start/stop of *one* perfmon object against
itself, but the invariant (at least on v3d) that needs protection is
device-wide: there is exactly one active perfmon at any moment in HW.

> +
> +	/* Number of counters activated in this perfmon instance
> +	 * (should be less than or equal to DRM_ETHOSU_MAX_PERF_COUNTERS).
> +	 */
> +	u8 ncounters;
> +
> +	/* Events counted by the HW perf counters. */
> +	u16 counters[DRM_ETHOSU_MAX_PERF_EVENT_COUNTERS];
> +
> +	/* Storage for counter values. Counters are incremented by the
> +	 * HW perf counter values every time the perfmon is attached
> +	 * to a GPU job.  This way, perfmon users don't have to

s/GPU/NPU job maybe?

> +	 * retrieve the results after each job if they want to track
> +	 * events covering several submissions.  Note that counter
> +	 * values can't be reset, but you can fake a reset by
> +	 * destroying the perfmon and creating a new one.
> +	 */
> +	u64 values[] __counted_by(ncounters);
>   };
>   
> +/* ethosu_perfmon.c */
> +void ethosu_perfmon_init(struct ethosu_device *ethosu);
> +void ethosu_perfmon_get(struct ethosu_perfmon *perfmon);
> +void ethosu_perfmon_put(struct ethosu_perfmon *perfmon);
> +void ethosu_perfmon_start(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon);
> +void ethosu_perfmon_stop(struct ethosu_device *ethosu, struct ethosu_perfmon *perfmon,
> +		      bool capture);
> +struct ethosu_perfmon *ethosu_perfmon_find(struct ethosu_file_priv *ethosu_priv, int id);
> +void ethosu_perfmon_open_file(struct ethosu_file_priv *ethosu_priv);
> +void ethosu_perfmon_close_file(struct ethosu_file_priv *ethosu_priv);
> +int ethosu_ioctl_perfmon_create(struct drm_device *dev, void *data,
> +			     struct drm_file *file_priv);
> +int ethosu_ioctl_perfmon_destroy(struct drm_device *dev, void *data,
> +			      struct drm_file *file_priv);
> +int ethosu_ioctl_perfmon_get_values(struct drm_device *dev, void *data,
> +				 struct drm_file *file_priv);
> +int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data,
> +				 struct drm_file *file_priv);
> +
>   #endif
> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
> index ec85f4156744..8bf5a3aa8420 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c
> @@ -147,6 +147,8 @@ static void ethosu_job_err_cleanup(struct ethosu_job *job)
>   {
>   	unsigned int i;
>   
> +	ethosu_perfmon_put(job->perfmon);
> +
>   	for (i = 0; i < job->region_cnt; i++)
>   		drm_gem_object_put(job->region_bo[i]);
>   
> @@ -181,6 +183,24 @@ static void ethosu_job_free(struct drm_sched_job *sched_job)
>   	ethosu_job_put(job);
>   }
>   
> +static void
> +ethosu_switch_perfmon(struct ethosu_device *ethosu, struct ethosu_job *job)
> +{
> +	struct ethosu_perfmon *perfmon = ethosu->global_perfmon;

You might consider using READ_ONCE for global_perfmon, as this can race
with the set_global IOCTL.

> +
> +	if (!perfmon)
> +		perfmon = job->perfmon;
> +
> +	if (perfmon == ethosu->active_perfmon)
> +		return;
> +
> +	if (perfmon != ethosu->active_perfmon)
> +		ethosu_perfmon_stop(ethosu, ethosu->active_perfmon, true);
> +
> +	if (perfmon && ethosu->active_perfmon != perfmon)
> +		ethosu_perfmon_start(ethosu, perfmon);
> +}
> +
>   static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
>   {
>   	struct ethosu_job *job = to_ethosu_job(sched_job);

[...]

> +int ethosu_ioctl_perfmon_set_global(struct drm_device *dev, void *data,
> +				 struct drm_file *file_priv)
> +{
> +	struct ethosu_file_priv *ethosu_priv = file_priv->driver_priv;
> +	struct drm_ethosu_perfmon_set_global *req = data;
> +	struct ethosu_device *ethosu = to_ethosu_device(dev);
> +	struct ethosu_perfmon *perfmon;
> +
> +	if (req->flags & ~DRM_ETHOSU_PERFMON_CLEAR_GLOBAL)
> +		return -EINVAL;
> +
> +	perfmon = ethosu_perfmon_find(ethosu_priv, req->id);
> +	if (!perfmon)
> +		return -EINVAL;
> +
> +	/* If the request is to clear the global performance monitor */
> +	if (req->flags & DRM_ETHOSU_PERFMON_CLEAR_GLOBAL) {
> +		if (!ethosu->global_perfmon)

In case of failure, I believe you need to put the perfmon to avoid
leaking a reference.

Best regards,
- Maíra

> +			return -EINVAL;
> +
> +		xchg(&ethosu->global_perfmon, NULL);
> +
> +		return 0;
> +	}
> +
> +	if (cmpxchg(&ethosu->global_perfmon, NULL, perfmon))
> +		return -EBUSY;
> +
> +	return 0;
> +}
