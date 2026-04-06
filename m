Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B49CF46C66
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4777910E299;
	Mon,  6 Apr 2026 18:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="R5+UJbV9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0004F10E290
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 18:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CQ4nb34ZwdnazJ6/5LCbhogHaUjxsLLUbK8TqzOZ65A=; b=R5+UJbV90npk2VvD+n8+K5PRmB
 gbixdqXCNDMm3WRmdCqAcCCHNntC6g5kuGIxWFJA50gVrS8ba/sg/rlwJSj+Vj0k68Q2OBKUKnfEi
 Ik8c1T8CMWtHICdXevZL7G4tbjYS1uBw7rr5e2JxXxMUCwFVHs/49YUwp6cJDefOe6269Pk/c7dbv
 GoVstn8iKdrnYrqKqJumyz8HcD5e213kHf1Lzb4aDfD/2TRttEpOyaiEnnsDtCWzd8mHdZB2fa9Ps
 +uBTSDU3MIKSRRNIXyD6NmPfC17dOL3oJ8E34Z/7N6uB85DDUXmoGkuENfE6qVPQGbn7XtuTE5UdY
 FsUB2gjA==;
Received: from [189.7.87.169] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w9oaI-00Cg4E-EO; Mon, 06 Apr 2026 20:22:02 +0200
Message-ID: <60bfe48d-a605-476b-ba20-f34d95811a4f@igalia.com>
Date: Mon, 6 Apr 2026 15:21:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drm/vc4: Add new job submission implementation
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
 <20260402-vc4-drm-scheduler-v2-3-d84afd35c602@igalia.com>
 <984bf7eb-82c6-465d-ab04-cc25bbc7ba48@igalia.com>
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
In-Reply-To: <984bf7eb-82c6-465d-ab04-cc25bbc7ba48@igalia.com>
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

On 06/04/26 11:51, Tvrtko Ursulin wrote:
> 
> On 02/04/2026 19:36, Maíra Canal wrote:
>> Introduce vc4_submit.c with the job submission path rewritten to
>> integrate with the DRM GPU scheduler. Most of this code is adapted from
>> vc4_gem.c, with key changes concentrated in the job creation and
>> lifecycle management. This implementation follows the same design as the
>> v3d driver.
>>
>> This code coexists with the legacy path until the switchover commit.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---

Ack to all previous comments.

>> +
>> +    exec->bin_u = bin;
>> +
>> +    exec->shader_rec_v = exec_bo->vaddr + shader_rec_offset;
>> +    exec->shader_rec_p = exec_bo->dma_addr + shader_rec_offset;
>> +    exec->shader_rec_size = args->shader_rec_size;
>> +
>> +    exec->uniforms_v = exec_bo->vaddr + uniforms_offset;
>> +    exec->uniforms_p = exec_bo->dma_addr + uniforms_offset;
>> +    exec->uniforms_size = args->uniforms_size;
>> +
>> +    ret = vc4_validate_bin_cl(dev, exec_bo->vaddr, bin, exec);
>> +    if (ret)
>> +        goto fail;
>> +
>> +    ret = vc4_validate_shader_recs(dev, exec);
>> +    if (ret)
>> +        goto fail;
>> +
>> +    if (exec->found_tile_binning_mode_config_packet) {
>> +        ret = vc4_v3d_bin_bo_get(vc4, &bin_job->bin_bo_used);
>> +        if (ret)
>> +            goto fail;
>> +    }
>> +
>> +fail:
>> +    kvfree(bin);
> 
> A bit odd exec->bin_u is left pointing to freed memory so I guess it is 
> not dereferenced by anyone later and it is just a convenience to store 
> it in struct vc4_exec_info.

I can add a exec->bin_u = NULL here.

> 
>> +    return ret;
>> +}
>> +
>> +static void
>> +vc4_job_free(struct kref *ref)
>> +{
>> +    struct vc4_job *job = container_of(ref, struct vc4_job, refcount);
>> +
>> +    dma_fence_put(job->irq_fence);
> 
> Ah I was looking for this while reading the previous patch, all good then.
> 
>> +    dma_fence_put(job->done_fence);
>> +
>> +    if (job->perfmon)
>> +        vc4_perfmon_put(job->perfmon);
> 
> Could the pointer to this job->perfmon be left in vc4->active_perfmon if 
> no new job was queued to reset that pointer?

Yeah... That's why we have that vc4_perfmon_stop() when destroying the
perfmons from a given file. Again, I believe perfmon lifetime in v3d/vc4
needs to be reviewed. At the moment, it's error prone.

> 
>> +
>> +    vc4_v3d_pm_put(job->vc4);
>> +    kfree(job);
>> +}
>> +

[...]

>> +
>> +    if (out_sync > 0) {
>> +        /* Update the return sync object for the job */
>> +        sync_out = drm_syncobj_find(file_priv, out_sync);
>> +        if (sync_out) {
>> +            drm_syncobj_replace_fence(sync_out, done_fence);
>> +            drm_syncobj_put(sync_out);
>> +        }
> 
> Is it okay to succeed if sync_out passed in by userspace was not found?

Ack, I just noticed that the current code fails the job submission if
the sync_out is not found.

[...]

>> +    ret = vc4_job_alloc(vc4, file_priv, (void *)&render, 
>> sizeof(*render),
>> +                vc4_render_job_free, args->in_sync, VC4_RENDER);
> 
> On the topic of void * games, I wonder if it would be cleaner for 
> vc4_job_alloc to take struct vc4_job **? Or it could even return ERR_PTR.

Ack.

[...]

>> +
>> +    mutex_lock(&vc4->sched_lock);
>> +    if (bin) {
>> +        vc4_push_job(&bin->base);
>> +
>> +        ret = drm_sched_job_add_dependency(&render->base.base,
>> +                           dma_fence_get(bin->base.done_fence));
>> +        if (ret)
>> +            goto fail_dependency;
>> +    }
>> +
>> +    vc4_push_job(&render->base);
>> +    mutex_unlock(&vc4->sched_lock);
> 
> Is it significant that vc4->sched_lock is held across both render and 
> bin, or it would work the same if it was held over individual arm-to- 
> push sections?

I believe it'd work just fine if it was held over individual arm-to-push
sections. I'll think a bit more about it.

> 
>> +
>> +
> 
> Two blank lines.
> 
>> +    vc4_attach_fences(file_priv, render, args->out_sync, render- 
>> >base.done_fence);
>> +    drm_exec_fini(&exec_ctx);
>> +
>> +    vc4_job_put((void *)bin);
>> +    vc4_job_put((void *)render);
> 
> Could vc4_job_put not work on &bin->base and so not need the void * casts?

Sure.

> 
>> +
>> +    return 0;
>> +
>> +fail_dependency:
>> +    mutex_unlock(&vc4->sched_lock);
>> +    drm_exec_fini(&exec_ctx);
>> +
>> +    /* BIN job has already been pushed; the scheduler owns it. Just drop
>> +     * our ref. As the RENDER job has not been armed, normal cleanup 
>> still
>> +     * applies.
>> +     */
> 
> What is the consequence if this path would trigger? GPU hang?

The BIN job can complete just fine without the RENDER job. Now, what
will happen to the user's application? It depends on how user-space will
handle the IOCTL failure. If the user-space treats the errno like a
failure to job submission (that is, understands that no job was
submitted at all), we should be fine.

Thanks for your review!

Best regards,
- Maíra

> 
> Regards,
> 
> Tvrtko
> 


