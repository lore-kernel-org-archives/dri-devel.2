Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2D0C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 08:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD1D10E423;
	Fri,  7 Aug 2026 08:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UjnE7jgX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D9C10F408
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 08:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=qMuMxlIuxAT6brPQCIhHPoKogg1qEM9R+2rYrEk9ruw=; b=UjnE7jgXmi+rVMNl7ILD/FB1Xd
 t9aa/1q1RiWULCWBAd2qA5kCu6bN4XEzZSL6QrUnGdCLiKZrxrhNB1s1UfwDeA/r8sZyWHulPimtt
 4+gSzNd1hmXvteu9lNSmYO4LR03FIdD9flWy9gkEMlsTZ27RZkl/rdbeBG+XVYpmRiIhqJxhZWZZQ
 afGKsmViW+nbHyyQ9wyrp9yD6oznxUbjqXW78KSRYcjhd3vqUut/e4jrYTvfmQzF8zD3LdCZWcnVm
 Jy8CiJsTMNtlw3Ac0GmmBDWQvxoqGTMwVoAHBgx+2jpjYCVYKPoEN7ZVLWbKaU4jmFogvPKfVtqXe
 jFQFc59w==;
Received: from [90.243.171.171] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wsGLu-00FKlk-Ta; Fri, 07 Aug 2026 10:54:54 +0200
Message-ID: <33f867c2-7f75-4127-b537-f54b1bda0bed@igalia.com>
Date: Fri, 7 Aug 2026 09:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] drm/vc4: Protect perfmon state with a dedicated
 lock
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-2-ed6dc4defa53@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260712-vc4-drm-scheduler-v3-2-ed6dc4defa53@igalia.com>
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


On 12/07/2026 16:14, Maíra Canal wrote:
> The V3D block exposes a single set of performance counters, so at most
> one perfmon can be programmed into the hardware at a time. Until now the
> active perfmon was tracked by a bare pointer whose access was serialized
> by job_lock, which was sufficient because the legacy job queue started
> and stopped perfmons from a single serialized context.
> 
> Once job execution moves to the DRM GPU scheduler, a perfmon is started
> from the job's run_job() callback but stopped from the IRQ handler and
> the reset path, so the shared perfmon state can be touched concurrently
> and job_lock no longer covers those accesses.
> 
> Introduce a dedicated spinlock next to the active perfmon pointer and
> take it in vc4_perfmon_start() and vc4_perfmon_stop(). Snapshot the
> counter values under the same lock in vc4_perfmon_get_values_ioctl() so
> that a concurrent stop cannot expose a half-updated array to userspace.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_drv.h     | 13 ++++++++++---
>   drivers/gpu/drm/vc4/vc4_gem.c     |  3 ++-
>   drivers/gpu/drm/vc4/vc4_perfmon.c | 34 ++++++++++++++++++++++------------
>   3 files changed, 34 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index fe313027a91e..91c9c7aa8039 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -181,10 +181,17 @@ struct vc4_dev {
>   	wait_queue_head_t job_wait_queue;
>   	struct work_struct job_done_work;
>   
> -	/* Used to track the active perfmon if any. Access to this field is
> -	 * protected by job_lock.
> +	/* Tracks the performance monitor state. The V3D block exposes a single
> +	 * set of performance counters, so at most one perfmon can be active at
> +	 * any moment.
>   	 */
> -	struct vc4_perfmon *active_perfmon;
> +	struct {
> +		/* Protects @active. */
> +		spinlock_t lock;
> +
> +		/* Perfmon currently programmed in HW (or NULL if none). */
> +		struct vc4_perfmon *active;
> +	} perfmon_state;
>   
>   	/* The memory used for storing binner tile alloc, tile state,
>   	 * and overflow memory allocations.  This is freed when V3D
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index f0c711f114cf..f84d82b3bfbb 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -491,7 +491,7 @@ vc4_submit_next_bin_job(struct drm_device *dev)
>   	/* Only start the perfmon if it was not already started by a previous
>   	 * job.
>   	 */
> -	if (exec->perfmon && vc4->active_perfmon != exec->perfmon)
> +	if (exec->perfmon && vc4->perfmon_state.active != exec->perfmon)

Shouldn't the second check be moved to under the lock in vc4_perfmon_start?

>   		vc4_perfmon_start(vc4, exec->perfmon);
>   
>   	/* Either put the job in the binner if it uses the binner, or
> @@ -1138,6 +1138,7 @@ int vc4_gem_init(struct drm_device *dev)
>   	INIT_LIST_HEAD(&vc4->render_job_list);
>   	INIT_LIST_HEAD(&vc4->job_done_list);
>   	spin_lock_init(&vc4->job_lock);
> +	spin_lock_init(&vc4->perfmon_state.lock);
>   
>   	INIT_WORK(&vc4->hangcheck.reset_work, vc4_reset_work);
>   	timer_setup(&vc4->hangcheck.timer, vc4_hangcheck_elapsed, 0);
> diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
> index f75dfd156756..2bcf6a7d538f 100644
> --- a/drivers/gpu/drm/vc4/vc4_perfmon.c
> +++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
> @@ -51,16 +51,18 @@ void vc4_perfmon_start(struct vc4_dev *vc4, struct vc4_perfmon *perfmon)
>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>   		return;
>   
> -	if (WARN_ON_ONCE(!perfmon || vc4->active_perfmon))
> +	if (!perfmon)
>   		return;

The only caller already ensures perfmon cannot be NULL so the check here 
is redundant. Maybe you want it for later in the series, or for symmetry 
with stop? Will see later.

What is lost though is the second check, especially since 
vc4_submit_next_bin_job has its "active differs" check outside the lock.
Was that an impossible condition to begin with? Is there scope to clean 
something up before adding a new lock in this patch?

>   
> +	guard(spinlock_irqsave)(&vc4->perfmon_state.lock);
> +
>   	for (i = 0; i < perfmon->ncounters; i++)
>   		V3D_WRITE(V3D_PCTRS(i), perfmon->events[i]);
>   
>   	mask = GENMASK(perfmon->ncounters - 1, 0);
>   	V3D_WRITE(V3D_PCTRC, mask);
>   	V3D_WRITE(V3D_PCTRE, V3D_PCTRE_EN | mask);

These are mmio? How costly on this hardware are they? Lets see later in 
the series if they can be moved outside the locked irq off section by 
maybe courtesy of run_job implicit serialisation.

Hm, does it even need to be irqsave ie can this be called from interrupt 
context?

> -	vc4->active_perfmon = perfmon;
> +	vc4->perfmon_state.active = perfmon;
>   }
>   
>   void vc4_perfmon_stop(struct vc4_dev *vc4, struct vc4_perfmon *perfmon,
> @@ -71,8 +73,12 @@ void vc4_perfmon_stop(struct vc4_dev *vc4, struct vc4_perfmon *perfmon,
>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>   		return;
>   
> -	if (WARN_ON_ONCE(!vc4->active_perfmon ||
> -			 perfmon != vc4->active_perfmon))

Not worth keeping the "unexpected perfmon"  warning in some fashion?

> +	if (!perfmon)
> +		return;
> +
> +	guard(spinlock_irqsave)(&vc4->perfmon_state.lock);
> +
> +	if (perfmon != vc4->perfmon_state.active)
>   		return;
>   
>   	if (capture) {
> @@ -81,7 +87,7 @@ void vc4_perfmon_stop(struct vc4_dev *vc4, struct vc4_perfmon *perfmon,
>   	}
>   
>   	V3D_WRITE(V3D_PCTRE, 0);
> -	vc4->active_perfmon = NULL;
> +	vc4->perfmon_state.active = NULL;
>   }
>   
>   struct vc4_perfmon *vc4_perfmon_find(struct vc4_file *vc4file, int id)
> @@ -116,8 +122,7 @@ static void vc4_perfmon_delete(struct vc4_file *vc4file,
>   	struct vc4_dev *vc4 = vc4file->dev;
>   
>   	/* If the active perfmon is being destroyed, stop it first */
> -	if (perfmon == vc4->active_perfmon)
> -		vc4_perfmon_stop(vc4, perfmon, false);
> +	vc4_perfmon_stop(vc4, perfmon, false);
>   
>   	vc4_perfmon_put(perfmon);
>   }
> @@ -222,8 +227,10 @@ int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>   	struct vc4_file *vc4file = file_priv->driver_priv;
>   	struct drm_vc4_perfmon_get_values *req = data;
> +	u64 values[DRM_VC4_MAX_PERF_COUNTERS];
>   	struct vc4_perfmon *perfmon;
> -	int ret;
> +	size_t size;
> +	int ret = 0;
>   
>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>   		return -ENODEV;
> @@ -237,11 +244,14 @@ int vc4_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
>   	if (!perfmon)
>   		return -EINVAL;
>   
> -	if (copy_to_user(u64_to_user_ptr(req->values_ptr), perfmon->counters,
> -			 perfmon->ncounters * sizeof(u64)))
> +	size = perfmon->ncounters * sizeof(u64);
> +
> +	/* Snapshot the counters under the perfmon lock */
> +	scoped_guard(spinlock_irqsave, &vc4->perfmon_state.lock)
> +		memcpy(values, perfmon->counters, size);
> +
> +	if (copy_to_user(u64_to_user_ptr(req->values_ptr), values, size))
>   		ret = -EFAULT;
> -	else
> -		ret = 0;
>   
>   	vc4_perfmon_put(perfmon);
>   	return ret;
> 

Regards,

Tvrtko

