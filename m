Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB58F46C66
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B1A89261;
	Mon,  6 Apr 2026 18:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jztdy9jj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730C389261
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Vg0odf4mm2+K3UQYDaajCDsXPWNgrtzm9RtTGstheY=; b=jztdy9jjZT6qSmiVR0Ruv5IZhR
 vosq/BOvcY3RmjMs57roaXMrZhbj5I3Gu+gMG0aCjyD+riVpdXWA3BucSlklgJDpPFcuRJGF0JTwm
 gSC9X074WODa+Ebh3fQxkG0nQ34OcldILEFDGfsF73Sb43oUhRFgSWsVAwiJi/06PbBNBgDe6l7c0
 qyZ/mF4sZRtKKjnYHz/jaAg2sHYjmmijicjQKarL2FgQs1c5uqExfVvZ0ejdJaBOBsDkIpf0ObcmK
 XBkGdcp7dQaviuqtaAAlwUKDgMcyupcooE+/YH+MMe+ed//LIe+nGh3UoZ1zJjTtHrQjJrrXupYc7
 VqVebNSg==;
Received: from [189.7.87.169] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w9owd-00CgXb-4A; Mon, 06 Apr 2026 20:45:07 +0200
Message-ID: <c607bcf5-448d-42b2-98c6-f23012a7cd0d@igalia.com>
Date: Mon, 6 Apr 2026 15:45:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/vc4: Add DRM GPU scheduler infrastructure and
 job structures
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
 <20260402-vc4-drm-scheduler-v2-2-d84afd35c602@igalia.com>
 <f9b615fe-697c-4e2d-910c-438ef843ad87@igalia.com>
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
In-Reply-To: <f9b615fe-697c-4e2d-910c-438ef843ad87@igalia.com>
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

Hi Tvrtko,

On 06/04/26 07:49, Tvrtko Ursulin wrote:

[...]

>> diff --git a/drivers/gpu/drm/vc4/vc4_fence.c b/drivers/gpu/drm/vc4/ 
>> vc4_fence.c
>> index 
>> 580214e2158c7dcf39253f2148dea478ffe20e68..18e8c53563d62a3f7a725c1552c3ffe3cced77cc 100644
>> --- a/drivers/gpu/drm/vc4/vc4_fence.c
>> +++ b/drivers/gpu/drm/vc4/vc4_fence.c
>> @@ -23,6 +23,24 @@
>>   #include "vc4_drv.h"
>> +struct dma_fence *vc4_fence_create(struct vc4_dev *vc4, enum 
>> vc4_queue q)
>> +{
>> +    struct vc4_queue_state *queue = &vc4->queue[q];
>> +    struct vc4_fence *fence;
>> +
>> +    fence = kzalloc_obj(*fence);
>> +    if (!fence)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    fence->dev = &vc4->base;
>> +    fence->queue = q;
>> +    fence->seqno = ++queue->emit_seqno;
> 
> The increment is serialized by the run_job / scheduler worker, okay.
> 
> I was only slightly wondering, given how this function is in a different 
> component, whether it could somehow be possible to better separate the 
> responsibilities and remove this knowledge from vc4_fence.c. Though it 
> is somewhat of a bike shedding territory, maybe let the caller pass in 
> all the data? Like:
> 
> vc4_fence_create(vc4, queue, context, seqno)

I'm under the impression this would pollute the run_job() calls. We
would need to repeat this logic for the two queues and pass several
arguments to this function that would only init the fence.

Personally, I'd prefer to keep as it is.

> 
>> +    dma_fence_init(&fence->base, &vc4_fence_ops, NULL, queue- 
>> >fence_context,
>> +               fence->seqno);
>> +
>> +    return &fence->base;
>> +}
>> +
>>   static const char *vc4_fence_get_driver_name(struct dma_fence *fence)
>>   {
>>       return "vc4";
>> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/ 
>> vc4_gem.c
>> index 
>> 614a2db245636c39855bc10727b62c00a6374f45..5af4386f4b39c7da9041c0a2ae49c91632412e72 100644
>> --- a/drivers/gpu/drm/vc4/vc4_gem.c
>> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
>> @@ -149,7 +149,7 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, 
>> void *data,
>>       return ret;
>>   }
>> -static void
>> +void
>>   vc4_save_hang_state(struct drm_device *dev)
>>   {
>>       struct vc4_dev *vc4 = to_vc4_dev(dev);
>> @@ -1135,6 +1135,12 @@ int vc4_gem_init(struct drm_device *dev)
>>       INIT_LIST_HEAD(&vc4->render_job_list);
>>       INIT_LIST_HEAD(&vc4->job_done_list);
>>       spin_lock_init(&vc4->job_lock);
>> +    ret = drmm_mutex_init(dev, &vc4->reset_lock);
>> +    if (ret)
>> +        return ret;
>> +    ret = drmm_mutex_init(dev, &vc4->sched_lock);
>> +    if (ret)
>> +        return ret;
>>       INIT_WORK(&vc4->hangcheck.reset_work, vc4_reset_work);
>>       timer_setup(&vc4->hangcheck.timer, vc4_hangcheck_elapsed, 0);
>> diff --git a/drivers/gpu/drm/vc4/vc4_sched.c b/drivers/gpu/drm/vc4/ 
>> vc4_sched.c
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..5c41c83a92aaf9b0bb9eb23ba93062337cb41011
>> --- /dev/null
>> +++ b/drivers/gpu/drm/vc4/vc4_sched.c
>> @@ -0,0 +1,337 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (C) 2026 Raspberry Pi */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include <drm/drm_print.h>
>> +
>> +#include "vc4_drv.h"
>> +#include "vc4_regs.h"
>> +#include "vc4_trace.h"
>> +
>> +static struct vc4_job *
>> +to_vc4_job(struct drm_sched_job *sched_job)
>> +{
>> +    return container_of(sched_job, struct vc4_job, base);
>> +}
>> +
>> +static struct vc4_bin_job *
>> +to_bin_job(struct drm_sched_job *sched_job)
>> +{
>> +    return container_of(sched_job, struct vc4_bin_job, base.base);
>> +}
>> +
>> +static struct vc4_render_job *
>> +to_render_job(struct drm_sched_job *sched_job)
>> +{
>> +    return container_of(sched_job, struct vc4_render_job, base.base);
>> +}
>> +
>> +static void
>> +vc4_flush_caches(struct drm_device *dev)
>> +{
>> +    struct vc4_dev *vc4 = to_vc4_dev(dev);
>> +
>> +    /* Flush the GPU L2 caches.  These caches sit on top of system
>> +     * L3 (the 128kb or so shared with the CPU), and are
>> +     * non-allocating in the L3.
>> +     */
>> +    V3D_WRITE(V3D_L2CACTL, V3D_L2CACTL_L2CCLR);
>> +
>> +    V3D_WRITE(V3D_SLCACTL,
>> +          VC4_SET_FIELD(0xf, V3D_SLCACTL_T1CC) |
>> +          VC4_SET_FIELD(0xf, V3D_SLCACTL_T0CC) |
>> +          VC4_SET_FIELD(0xf, V3D_SLCACTL_UCC) |
>> +          VC4_SET_FIELD(0xf, V3D_SLCACTL_ICC));
>> +}
>> +
>> +static void
>> +vc4_flush_texture_caches(struct drm_device *dev)
>> +{
>> +    struct vc4_dev *vc4 = to_vc4_dev(dev);
>> +
>> +    V3D_WRITE(V3D_L2CACTL, V3D_L2CACTL_L2CCLR);
>> +
>> +    V3D_WRITE(V3D_SLCACTL,
>> +          VC4_SET_FIELD(0xf, V3D_SLCACTL_T1CC) |
>> +          VC4_SET_FIELD(0xf, V3D_SLCACTL_T0CC));
>> +}
>> +
>> +static void
>> +vc4_sched_job_free(struct drm_sched_job *sched_job)
>> +{
>> +    struct vc4_job *job = to_vc4_job(sched_job);
>> +
>> +    vc4_job_cleanup(job);
>> +}
>> +
>> +static void
>> +vc4_switch_perfmon(struct vc4_dev *vc4, struct vc4_job *job)
>> +{
>> +    if (vc4->active_perfmon && vc4->active_perfmon != job->perfmon)
>> +        vc4_perfmon_stop(vc4, vc4->active_perfmon, true);
>> +
>> +    if (job->perfmon && vc4->active_perfmon != job->perfmon)
>> +        vc4_perfmon_start(vc4, job->perfmon);
> 
> I think some conditionals end up redundant in this flow by the end of 
> the series. Here versus the vc4_perfmon_stop/start have internal checks. 
> Maybe vc4_perfmon_switch could be more streamlined, or maybe even moved 
> to vc4_perfmon.c next to start and stop? Up to you.
> 
> Also, is the fact perfmon stop is no longer on job irq complete but on 
> next job run relevant? What about updating the counters when a job 
> completes and there is nothing further queued up? Or I missed something?

As mentioned in other e-mails, yeah... I'll try to rework performs for
the next version.

Thanks for the review!

Best regards,
- Maíra

> 
>> +}
>> +
>> +static struct dma_fence *vc4_bin_job_run(struct drm_sched_job 
>> *sched_job)
>> +{
>> +    struct vc4_bin_job *job = to_bin_job(sched_job);
>> +    struct vc4_dev *vc4 = job->base.vc4;
>> +    struct drm_device *dev = &vc4->base;
>> +    struct dma_fence *fence;
>> +
>> +    if (unlikely(job->base.base.s_fence->finished.error))
>> +        goto err_clean_bin_job;
>> +
>> +    /* Lock required around bin_job update vs 
>> vc4_overflow_mem_work(). */
>> +    spin_lock_irq(&vc4->job_lock);
>> +    vc4->bin_job = job;
>> +
>> +    /* Reset the overflow allocation registers to prevent the binner 
>> from
>> +     * writing to a slot that a concurrent render job might free. The 
>> first
>> +     * OUTOMEM interrupt will allocate a fresh slot.
>> +     */
>> +    V3D_WRITE(V3D_BPOA, 0);
>> +    V3D_WRITE(V3D_BPOS, 0);
>> +    spin_unlock_irq(&vc4->job_lock);
>> +
>> +    vc4_flush_caches(dev);
>> +
>> +    fence = vc4_fence_create(vc4, VC4_BIN);
>> +    if (IS_ERR(fence))
>> +        goto err_clean_bin_job;
>> +
>> +    /* Release the previous fence if the scheduler is resubmitting this
>> +     * job after a GPU reset.
>> +     */
>> +    if (job->base.irq_fence)
>> +        dma_fence_put(job->base.irq_fence);
>> +    job->base.irq_fence = dma_fence_get(fence);
> 
> One ref for the scheduler, one for job->base.irq_fence. Where is the 
> latter released?
> 
>> +
>> +    trace_vc4_submit_cl(dev, false, to_vc4_fence(fence)->seqno,
>> +                job->ct0ca, job->ct0ea);
>> +
>> +    vc4_switch_perfmon(vc4, &job->base);
>> +
>> +    V3D_WRITE(V3D_CTNCA(0), job->ct0ca);
>> +    V3D_WRITE(V3D_CTNEA(0), job->ct0ea);
>> +
>> +    return fence;
>> +
>> +err_clean_bin_job:
>> +    spin_lock_irq(&vc4->job_lock);
>> +    vc4->bin_job = NULL;
>> +    spin_unlock_irq(&vc4->job_lock);
>> +    return NULL;
>> +}
>> +
>> +static struct dma_fence *vc4_render_job_run(struct drm_sched_job 
>> *sched_job)
>> +{
>> +    struct vc4_render_job *job = to_render_job(sched_job);
>> +    struct vc4_dev *vc4 = job->base.vc4;
>> +    struct drm_device *dev = &vc4->base;
>> +    struct dma_fence *fence;
>> +
>> +    if (unlikely(job->base.base.s_fence->finished.error))
>> +        goto err_clean_render_job;
>> +
>> +    vc4->render_job = job;
>> +
>> +    /* A previous RCL may have written to one of our textures, and
>> +     * our full cache flush at bin time may have occurred before
>> +     * that RCL completed. Flush the texture cache now, but not
>> +     * the instructions or uniforms (since we don't write those
>> +     * from an RCL).
>> +     */
>> +    vc4_flush_texture_caches(dev);
>> +
>> +    fence = vc4_fence_create(vc4, VC4_RENDER);
>> +    if (IS_ERR(fence))
>> +        goto err_clean_render_job;
>> +
>> +    /* Release the previous fence if the scheduler is resubmitting this
>> +     * job after a GPU reset.
>> +     */
>> +    if (job->base.irq_fence)
>> +        dma_fence_put(job->base.irq_fence);
>> +    job->base.irq_fence = dma_fence_get(fence);
>> +
>> +    trace_vc4_submit_cl(dev, true, to_vc4_fence(fence)->seqno,
>> +                job->ct1ca, job->ct1ea);
>> +
>> +    vc4_switch_perfmon(vc4, &job->base);
>> +
>> +    V3D_WRITE(V3D_CTNCA(1), job->ct1ca);
>> +    V3D_WRITE(V3D_CTNEA(1), job->ct1ea);
>> +
>> +    return fence;
>> +
>> +err_clean_render_job:
>> +    spin_lock_irq(&vc4->job_lock);
>> +    vc4->render_job = NULL;
>> +    spin_unlock_irq(&vc4->job_lock);
>> +    return NULL;
>> +}
>> +
>> +static void
>> +vc4_reset(struct drm_device *dev)
>> +{
>> +    struct vc4_dev *vc4 = to_vc4_dev(dev);
>> +
>> +    drm_err(dev, "Resetting GPU.\n");
>> +
>> +    mutex_lock(&vc4->power_lock);
>> +    if (vc4->power_refcount) {
>> +        /* Power the device off and back on the by dropping the
>> +         * reference on runtime PM.
>> +         */
>> +        pm_runtime_put_sync_suspend(&vc4->v3d->pdev->dev);
>> +        pm_runtime_get_sync(&vc4->v3d->pdev->dev);
>> +    }
>> +    mutex_unlock(&vc4->power_lock);
>> +
>> +    vc4_irq_reset(dev);
>> +}
>> +
>> +static enum drm_gpu_sched_stat
>> +vc4_gpu_reset_for_timeout(struct vc4_dev *vc4, struct drm_sched_job 
>> *sched_job)
>> +{
>> +    enum vc4_queue q;
>> +
>> +    mutex_lock(&vc4->reset_lock);
>> +
>> +    /* block scheduler */
>> +    for (q = 0; q < VC4_MAX_QUEUES; q++)
>> +        drm_sched_stop(&vc4->queue[q].sched, sched_job);
>> +
>> +    if (sched_job) {
>> +        drm_sched_increase_karma(sched_job);
>> +
>> +        /* If the guilty job is a BIN job, also increase the karma
>> +         * of its paired render job. Otherwise, the RENDER job would
>> +         * be submitted to the GPU without binner output.
>> +         */
>> +        if (sched_job->sched == &vc4->queue[VC4_BIN].sched) {
>> +            struct vc4_bin_job *bin = to_bin_job(sched_job);
>> +
>> +            drm_sched_increase_karma(&bin->render->base.base);
>> +        }
>> +    }
>> +
>> +    vc4_save_hang_state(&vc4->base);
>> +
>> +    /* get the GPU back into the init state */
>> +    vc4_reset(&vc4->base);
>> +
>> +    for (q = 0; q < VC4_MAX_QUEUES; q++)
>> +        drm_sched_resubmit_jobs(&vc4->queue[q].sched);
>> +
>> +    /* Unblock schedulers and restart their jobs. */
>> +    for (q = 0; q < VC4_MAX_QUEUES; q++)
>> +        drm_sched_start(&vc4->queue[q].sched, 0);
>> +
>> +    mutex_unlock(&vc4->reset_lock);
>> +
>> +    return DRM_GPU_SCHED_STAT_RESET;
>> +}
>> +
>> +static enum drm_gpu_sched_stat
>> +vc4_cl_job_timedout(struct drm_sched_job *sched_job, enum vc4_queue q)
>> +{
>> +    struct vc4_job *job = to_vc4_job(sched_job);
>> +    struct vc4_dev *vc4 = job->vc4;
>> +    u32 ctca = V3D_READ(V3D_CTNCA(q));
>> +    u32 ctra = V3D_READ(V3D_CTNRA0(q));
>> +
>> +    /* If the current address or return address have changed, then 
>> the GPU
>> +     * has probably made progress and we should delay the reset. This 
>> could
>> +     * fail if the GPU got in an infinite loop in the CL, but that is 
>> pretty
>> +     * unlikely outside of an i-g-t testcase.
>> +     */
>> +    if (job->timedout_ctca != ctca || job->timedout_ctra != ctra) {
>> +        job->timedout_ctca = ctca;
>> +        job->timedout_ctra = ctra;
>> +
>> +        return DRM_GPU_SCHED_STAT_NO_HANG;
>> +    }
>> +
>> +    return vc4_gpu_reset_for_timeout(vc4, sched_job);
>> +}
>> +
>> +static enum drm_gpu_sched_stat
>> +vc4_bin_job_timedout(struct drm_sched_job *sched_job)
>> +{
>> +    return vc4_cl_job_timedout(sched_job, VC4_BIN);
>> +}
>> +
>> +static enum drm_gpu_sched_stat
>> +vc4_render_job_timedout(struct drm_sched_job *sched_job)
>> +{
>> +    return vc4_cl_job_timedout(sched_job, VC4_RENDER);
>> +}
>> +
>> +static const struct drm_sched_backend_ops vc4_bin_sched_ops = {
>> +    .run_job = vc4_bin_job_run,
>> +    .timedout_job = vc4_bin_job_timedout,
>> +    .free_job = vc4_sched_job_free,
>> +};
>> +
>> +static const struct drm_sched_backend_ops vc4_render_sched_ops = {
>> +    .run_job = vc4_render_job_run,
>> +    .timedout_job = vc4_render_job_timedout,
>> +    .free_job = vc4_sched_job_free,
>> +};
>> +
>> +static int
>> +vc4_queue_sched_init(struct vc4_dev *vc4, const struct 
>> drm_sched_backend_ops *ops,
>> +             enum vc4_queue queue, const char *name)
>> +{
>> +    struct drm_sched_init_args args = {
>> +        .num_rqs = DRM_SCHED_PRIORITY_COUNT,
>> +        .credit_limit = 1,
>> +        .timeout = msecs_to_jiffies(500),
>> +        .dev = vc4->base.dev,
>> +    };
>> +
>> +    args.ops = ops;
>> +    args.name = name;
>> +
>> +    return drm_sched_init(&vc4->queue[queue].sched, &args);
>> +}
>> +
>> +int
>> +vc4_sched_init(struct vc4_dev *vc4)
>> +{
>> +    int ret;
>> +
>> +    for (int i = 0; i < VC4_MAX_QUEUES; i++)
>> +        vc4->queue[i].fence_context = dma_fence_context_alloc(1);
> 
> Bike shedding - could move the "cannot fail" steps to be last. Or even 
> allocate the fence context in vc4_queue_sched_init.
> 
> Regards,
> 
> Tvrtko
> 
>> +
>> +    ret = vc4_queue_sched_init(vc4, &vc4_bin_sched_ops,
>> +                   VC4_BIN, "vc4_bin");
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = vc4_queue_sched_init(vc4, &vc4_render_sched_ops,
>> +                   VC4_RENDER, "vc4_render");
>> +    if (ret) {
>> +        vc4_sched_fini(vc4);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +void
>> +vc4_sched_fini(struct vc4_dev *vc4)
>> +{
>> +    enum vc4_queue q;
>> +
>> +    for (q = 0; q < VC4_MAX_QUEUES; q++) {
>> +        if (vc4->queue[q].sched.ready)
>> +            drm_sched_fini(&vc4->queue[q].sched);
>> +    }
>> +}
>>
> 

