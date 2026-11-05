Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB99606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=t3jnPMLj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25BF11228F;
	Thu,  5 Nov 2026 09:22:31 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ECE411228F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:22:25 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1404860f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 01:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1793870544; x=1794475344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0Kd7lcxkbZIwUjBS8lUhNN+9PpJV88FFRkU7HIQmzBg=;
 b=t3jnPMLj0bwNR9DkOJGdqnu0aPQbrh5UJ+t3hegb7eOgr7DemaBZ30BOFzKDEXyEFT
 lMB5m09o4sW7guhEbWM3lOaJLxRD/3Kd+3jPWZKEVFcw7roAbnVzoBmaAL26Mg6Wdnr3
 khG3fabjx0NlLdVyVhhMOHF7wWTPaPM0Z3End7QYiX3xo4RWoVnvA7cKTxRq8SHoFqZF
 f7FiwaqGJg3bxYaMhtPnMZmKR7T+zcLXeu5OkbUaeq3gwRglPLEmzkTARro7pFPZLshm
 mZ9l9MdOxEqpokcr7URjxbt/U9VAd9D51R9pmQ8M9QcKWjFveQfUXFIq387CZbtkuAxO
 RUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793870544; x=1794475344;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Kd7lcxkbZIwUjBS8lUhNN+9PpJV88FFRkU7HIQmzBg=;
 b=bQB80i57kOVdvSZebZ9YRNbZvrz8qytpqOw3z2eb+KvNqvwwDugBeRRgIcz6UZbSBF
 UhNd4nk2ycDjK/NuLvMCS1rkjoadh9QXboLGXa3dn2K4kUr9PvjimnztCbe3GG2HAr+B
 kWLLIxDKvtBmeaJBbHSaloIwPWB9mB5vfugB44vZinEoYJmH3kY6CHraXKYXQFChmP+N
 GaK2FNSHiJ/gIyT8spsf3iJXgYxoY/oKpAXTF1PBkCz/sfrlEx2R6oThl5kCuHwIeUpB
 ZmsloU+rVz0T/CPV72x1DqimjYCXOpYyitcD0i5cJYyHmwFCYSV5yIRH3hQEQP+oi6BW
 SX2g==
X-Forwarded-Encrypted: i=1;
 AKwUvByiDIauUHhZlhWUttA4LRrQ9brFHdgOem2HB/s/2u8RG8Mdzl53+VSdphT08oRb7u+yijCzrK5js40=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8OiWWx9c/rEOnbPu8QJwIX9aSCBOhOvwaIM2smMJfvuIF1OufB
 YFdWr4AnobPwI/twXjcHbXzn1pP61IFk1E3YQil1SFteGNSm+yF/zVy8OjxZGVLDyZ0=
X-Gm-Gg: AYBFou2LNYaV+T+uHmtbfVl3569cObhgH0kFKLKpBQpIiPykamAD+xsfB7ipNMbHsoV
 48Z2614LnKJj004peYXUG1Rt0Yhzbp7nonWV0Wqno7rCkhjOsjmBeFiZcR+zAL3x/7n4XgO2wVn
 vH7JeJm/ynVK2DOoshYuiqd5EMj0hTd58owJUe3dQxLJzr4679zzMQF5XvdxTvUIzC9mFYI7CDc
 nCXT6JMObL5oOktOTQ9sgoQw61Rqa/qiTlyZ7jkX7sugdhXbtvnXeczsOnaxzNc8fP56/iVTDnS
 +M2xWlAcjGiUty6yJsgSim6Gqg/7CNSWiPJIDiJYKtH5OS9G+g4Acu6EKUd/5yix207kPc/gB4T
 eS5xKzPbn3M7wPqcRKF9nl3ckdg9COn1m3CQGpEaVENU7zWEbnmUTWIERJV7uzY9OhQN13Ss9+C
 muVtMgebwS7iNT7esTMGI8Z/Li6GGOT/t+wmWw72K+x/rdvo5hzPgttd4kY9Z5zYYOT56wgQub4
 MbJ7IuQcWesIgKvVs4wkxS/HSCvwCRHVr1zDAl+4FFT+emSX+Byol01b+RLAKlUy7+/urPDcnVz
 QNSoMHYtKipdexEvmHN6jwIXROM15RffqX+SezDY9mIb
X-Received: by 2002:a05:6000:4b0b:b0:48d:db77:d124 with SMTP id
 ffacd0b85a97d-48e6e2db9e1mr40274489f8f.6.1793870543797; 
 Thu, 05 Nov 2026 01:22:23 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm8686341f8f.14.2026.11.05.01.22.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 01:22:23 -0800 (PST)
Message-ID: <a9f016ce-f086-412d-9ca6-6608a41840e5@ursulin.net>
Date: Thu, 5 Nov 2026 09:22:22 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] accel/rocket: Report NPU usage through fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20261103155338.1949294-1-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 03/11/2026 15:53, Sidong Yang wrote:
> There is no way to tell how much of the NPU a client uses. Implement the
> DRM usage stats: account the time each job occupies a core and report
> it per client as drm-engine-npu, along with drm_show_memory_stats() for
> the BOs.
> 
> The cores are identical, so they are reported as a single engine with
> drm-engine-capacity-npu set to rdev->max_cores, the number of core
> slots. The time is summed over all cores, with an atomic counter as the
> cores complete jobs concurrently.
> 
> Jobs can outlive the file that submitted them, so the counter is
> refcounted and each job holds a reference. The time covers the whole
> period a job owns a core, so it also includes handling the completion
> interrupt and the gaps between the tasks of a multi-task job.
> 
> Document the keys in the rocket driver documentation.
> 
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> ---
> v4: Report a single drm-engine-npu key with drm-engine-capacity-npu,
>      instead of drm-engine-npu0..2, as drm-usage-stats.rst specifies for
>      a group of identical engines, and document the keys (Tomeu Vizoso).
>      The subject no longer says per-core. Gyeyoung's tags are dropped as
>      the accounting changed.
> 
>      Still depends on commit 6eff1d69dae8 ("accel/rocket: search every
>      core slot when a core is removed") for rdev->max_cores.
> 
> v3: Add a rocket_engine_usage_create() helper for the counter
>      allocation in rocket_open(), to pair with
>      rocket_engine_usage_destroy() (Gyeyoung Baek).
> 
> v2: Size the per-core counters by rdev->max_cores, the number of core
>      slots, instead of the number of cores bound when the file is opened.
>      Sashiko reported the out-of-bounds read and Gyeyoung Baek reproduced
>      it with KASAN.
> 
> Link to v3: https://lore.kernel.org/all/20261103104804.1887489-1-sidong.yang@furiosa.ai/
> Link to v2: https://lore.kernel.org/all/20261101152723.1430312-1-sidong.yang@furiosa.ai/
> Link to v1: https://lore.kernel.org/all/20261031083642.1076356-1-sidong.yang@furiosa.ai/
> 
>   Documentation/accel/rocket/index.rst  | 28 +++++++++++
>   Documentation/gpu/drm-usage-stats.rst |  1 +
>   drivers/accel/rocket/rocket_drv.c     | 70 ++++++++++++++++++++++++++-
>   drivers/accel/rocket/rocket_drv.h     | 15 ++++++
>   drivers/accel/rocket/rocket_job.c     |  7 +++
>   drivers/accel/rocket/rocket_job.h     |  4 ++
>   6 files changed, 123 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/accel/rocket/index.rst b/Documentation/accel/rocket/index.rst
> index 70f97bccf100..53c9aa7e2229 100644
> --- a/Documentation/accel/rocket/index.rst
> +++ b/Documentation/accel/rocket/index.rst
> @@ -17,3 +17,31 @@ project.
>   Hardware currently supported:
>   
>   * RK3588
> +
> +.. _rocket-usage-stats:
> +
> +Rocket DRM client usage stats implementation
> +============================================
> +
> +The accel/rocket driver implements the DRM client usage stats specification as
> +documented in :ref:`drm-client-usage-stats`.
> +
> +The NPU cores are reported as a single engine, npu, with a capacity equal to the
> +number of cores. The time is summed over all cores, and covers the whole period
> +a job occupies a core.
> +
> +Example of the output showing the implemented key value pairs:
> +
> +::
> +
> +        pos:	0
> +        flags:	02400002
> +        mnt_id:	33
> +        ino:	749
> +        drm-driver:	rocket
> +        drm-client-id:	246
> +        drm-engine-npu:	2296549300 ns
> +        drm-engine-capacity-npu:	3
> +        drm-total-memory:	24216 KiB
> +        drm-shared-memory:	0
> +        drm-active-memory:	1920 KiB
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 70b7cfcc194f..288764730d23 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -218,3 +218,4 @@ Driver specific implementations
>   * :ref:`panthor-usage-stats`
>   * :ref:`xe-usage-stats`
>   * :ref:`amdxdna-usage-stats`
> +* :ref:`rocket-usage-stats`
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
> index 2bcfe4ab3c68..e22e8623db64 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -3,8 +3,10 @@
>   
>   #include <drm/drm_accel.h>
>   #include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
>   #include <drm/drm_gem.h>
>   #include <drm/drm_ioctl.h>
> +#include <drm/drm_print.h>
>   #include <drm/rocket_accel.h>
>   #include <linux/clk.h>
>   #include <linux/err.h>
> @@ -68,6 +70,38 @@ rocket_iommu_domain_put(struct rocket_iommu_domain *domain)
>   	kref_put(&domain->kref, rocket_iommu_domain_destroy);
>   }
>   
> +static struct rocket_engine_usage *
> +rocket_engine_usage_create(void)
> +{
> +	struct rocket_engine_usage *usage;
> +
> +	usage = kzalloc_obj(*usage);
> +	if (!usage)
> +		return NULL;
> +	kref_init(&usage->kref);
> +
> +	return usage;
> +}
> +
> +static void
> +rocket_engine_usage_destroy(struct kref *kref)
> +{
> +	kfree(container_of(kref, struct rocket_engine_usage, kref));
> +}
> +
> +struct rocket_engine_usage *
> +rocket_engine_usage_get(struct rocket_file_priv *rocket_priv)
> +{
> +	kref_get(&rocket_priv->engine_usage->kref);
> +	return rocket_priv->engine_usage;
> +}
> +
> +void
> +rocket_engine_usage_put(struct rocket_engine_usage *usage)
> +{
> +	kref_put(&usage->kref, rocket_engine_usage_destroy);
> +}
> +
>   static int
>   rocket_open(struct drm_device *dev, struct drm_file *file)
>   {
> @@ -86,10 +120,17 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
>   	}
>   
>   	rocket_priv->rdev = rdev;
> +
> +	rocket_priv->engine_usage = rocket_engine_usage_create();
> +	if (!rocket_priv->engine_usage) {
> +		ret = -ENOMEM;
> +		goto err_free;
> +	}

Glanced over this patch by chance and it very reminded me of 
drm_sched_entity_stats tracking. That object is reference counted by the 
entity so I think it would satisfy your requirements. We would only need 
to add an accessor like drm_sched_entity_get_runtime() and just call it 
from rocket. Thoughts?

Regards,

Tvrtko

> +
>   	rocket_priv->domain = rocket_iommu_domain_create(rdev->cores[0].dev);
>   	if (IS_ERR(rocket_priv->domain)) {
>   		ret = PTR_ERR(rocket_priv->domain);
> -		goto err_free;
> +		goto err_put_engine_usage;
>   	}
>   
>   	file->driver_priv = rocket_priv;
> @@ -109,6 +150,8 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
>   	mutex_destroy(&rocket_priv->mm_lock);
>   	drm_mm_takedown(&rocket_priv->mm);
>   	rocket_iommu_domain_put(rocket_priv->domain);
> +err_put_engine_usage:
> +	rocket_engine_usage_put(rocket_priv->engine_usage);
>   err_free:
>   	kfree(rocket_priv);
>   err_put_mod:
> @@ -125,6 +168,7 @@ rocket_postclose(struct drm_device *dev, struct drm_file *file)
>   	mutex_destroy(&rocket_priv->mm_lock);
>   	drm_mm_takedown(&rocket_priv->mm);
>   	rocket_iommu_domain_put(rocket_priv->domain);
> +	rocket_engine_usage_put(rocket_priv->engine_usage);
>   	kfree(rocket_priv);
>   	module_put(THIS_MODULE);
>   }
> @@ -139,7 +183,28 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
>   	ROCKET_IOCTL(FINI_BO, fini_bo),
>   };
>   
> -DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
> +static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *file)
> +{
> +	struct rocket_device *rdev = to_rocket_device(file->minor->dev);
> +	struct rocket_file_priv *rocket_priv = file->driver_priv;
> +
> +	/*
> +	 * This is an estimate: the time is taken around the whole period a job
> +	 * occupies a core, so it also covers handling the completion interrupt
> +	 * and, for a job made of several tasks, the gaps between them.
> +	 */
> +	drm_printf(p, "drm-engine-npu:\t%lld ns\n",
> +		   atomic64_read(&rocket_priv->engine_usage->elapsed_ns));
> +	drm_printf(p, "drm-engine-capacity-npu:\t%u\n", rdev->max_cores);
> +
> +	drm_show_memory_stats(p, file);
> +}
> +
> +static const struct file_operations rocket_accel_driver_fops = {
> +	.owner = THIS_MODULE,
> +	DRM_ACCEL_FOPS,
> +	.show_fdinfo = drm_show_fdinfo,
> +};
>   
>   /*
>    * Rocket driver version:
> @@ -150,6 +215,7 @@ static const struct drm_driver rocket_drm_driver = {
>   	.open			= rocket_open,
>   	.postclose		= rocket_postclose,
>   	.gem_create_object	= rocket_gem_create_object,
> +	.show_fdinfo		= rocket_show_fdinfo,
>   	.ioctls			= rocket_drm_driver_ioctls,
>   	.num_ioctls		= ARRAY_SIZE(rocket_drm_driver_ioctls),
>   	.fops			= &rocket_accel_driver_fops,
> diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
> index 2c673bb99ccc..495d8b4a4d43 100644
> --- a/drivers/accel/rocket/rocket_drv.h
> +++ b/drivers/accel/rocket/rocket_drv.h
> @@ -16,6 +16,16 @@ struct rocket_iommu_domain {
>   	struct kref kref;
>   };
>   
> +/*
> + * Time the cores have spent running a client's jobs, in nanoseconds, summed over
> + * all cores. Jobs hold a reference, as they can outlive the file that submitted
> + * them.
> + */
> +struct rocket_engine_usage {
> +	struct kref kref;
> +	atomic64_t elapsed_ns;
> +};
> +
>   struct rocket_file_priv {
>   	struct rocket_device *rdev;
>   
> @@ -24,9 +34,14 @@ struct rocket_file_priv {
>   	struct mutex mm_lock;
>   
>   	struct drm_sched_entity sched_entity;
> +
> +	struct rocket_engine_usage *engine_usage;
>   };
>   
>   struct rocket_iommu_domain *rocket_iommu_domain_get(struct rocket_file_priv *rocket_priv);
>   void rocket_iommu_domain_put(struct rocket_iommu_domain *domain);
>   
> +struct rocket_engine_usage *rocket_engine_usage_get(struct rocket_file_priv *rocket_priv);
> +void rocket_engine_usage_put(struct rocket_engine_usage *usage);
> +
>   #endif
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index ce994748dd5d..e613fae133e4 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -13,6 +13,7 @@
>   #include <linux/iommu.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/sched/clock.h>
>   
>   #include "rocket_core.h"
>   #include "rocket_device.h"
> @@ -265,6 +266,7 @@ static void rocket_job_cleanup(struct kref *ref)
>   	unsigned int i;
>   
>   	rocket_iommu_domain_put(job->domain);
> +	rocket_engine_usage_put(job->engine_usage);
>   
>   	dma_fence_put(job->done_fence);
>   	dma_fence_put(job->inference_done_fence);
> @@ -351,6 +353,7 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
>   
>   	scoped_guard(mutex, &core->job_lock) {
>   		core->in_flight_job = job;
> +		job->start_ns = local_clock();
>   		rocket_job_hw_submit(core, job);
>   	}
>   
> @@ -379,6 +382,9 @@ static void rocket_job_handle_irq(struct rocket_core *core)
>   				return;
>   			}
>   
> +			atomic64_add(local_clock() - core->in_flight_job->start_ns,
> +				     &core->in_flight_job->engine_usage->elapsed_ns);
> +
>   			iommu_detach_group(NULL, iommu_group_get(core->dev));
>   			dma_fence_signal(core->in_flight_job->done_fence);
>   			pm_runtime_put_autosuspend(core->dev);
> @@ -587,6 +593,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
>   
>   	rjob->rdev = rdev;
>   	rjob->domain = rocket_iommu_domain_get(file_priv);
> +	rjob->engine_usage = rocket_engine_usage_get(file_priv);
>   
>   	ret = drm_sched_job_init(&rjob->base,
>   				 &file_priv->sched_entity,
> diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/rocket_job.h
> index 4ae00feec3b9..14aa78aebc99 100644
> --- a/drivers/accel/rocket/rocket_job.h
> +++ b/drivers/accel/rocket/rocket_job.h
> @@ -38,6 +38,10 @@ struct rocket_job {
>   
>   	struct rocket_iommu_domain *domain;
>   
> +	/* When the job was handed to a core, and where to account the time */
> +	u64 start_ns;
> +	struct rocket_engine_usage *engine_usage;
> +
>   	struct kref refcount;
>   };
>   
> 
> base-commit: a1e63ab695ad76850ab9787b9eb6aab695dc2965
> prerequisite-patch-id: 519bcdfdde80d902309c8346f749ebc4bb6b29c0

