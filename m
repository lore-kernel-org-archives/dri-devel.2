Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0A9CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57272112479;
	Thu, 15 Oct 2026 19:39:25 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC71112464
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 19:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=PS1fSxWRBC/rwnwqDqZLeV3BjS6Q+LK6cOjT48Q1vYs=; b=bM5A/4HJmf+I4u8uQG88VoF3l6
 I99/NwW8ldtuB48vyKqZfUzdFq3i8r/l2xWXA3hDt1dkAYoNLUFrt/0zMMFwRY5wgDAuTVXXd7OEg
 V2Xp2At+Ogo8oFxaiwpejYA0hjqpn81j5f37N0YfLMCAjQYD5i/HjwltBbGam9JHDSieLrBAYtFV2
 B9FUDVvQRIs2QaBIdh94akhjmQb35Mufr4euZuVPRWhqSVE/aKr+RfpsNIzR2Z2PoKkqZmyjoonm0
 5kq4Dp4GlwiIYifVoDDoA6W7F941NLHG8G0V8rUuik1Ps0udM3UXsJCa5/szbjgxRwgXY3HBfyL1T
 28qw/l9w==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xHRIH-000hyL-Tk; Thu, 15 Oct 2026 21:39:14 +0200
Message-ID: <b794bd1a-6a17-4f2a-a5ec-cbb5459913a5@igalia.com>
Date: Thu, 15 Oct 2026 16:39:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] drm/vc4: Publish the output fence outside of
 job_lock
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
 <20261004-vc4-misc-fixes-v1-1-b763df9e33e1@igalia.com>
 <46655d67646a560ebb0cf3b4162a4bdacd59ad04.camel@igalia.com>
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
In-Reply-To: <46655d67646a560ebb0cf3b4162a4bdacd59ad04.camel@igalia.com>
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

Hi Iago,

On 13/10/26 03:42, Iago Toral wrote:
> El dom, 04-10-2026 a las 12:42 -0300, Maíra Canal escribió:
>> job_lock is taken by the V3D interrupt handler, so nesting an IRQ-
>> unsafe
>> lock under it creates an inversion. drm_syncobj_replace_fence() takes
>> drm_syncobj::lock, which other paths acquire with interrupts enabled.
>> For
>> example, a thread interrupted while holding it blocks the handler on
>> job_lock, and the handler can only make progress once the submit path
>> releases job_lock, which it cannot do while waiting for
>> drm_syncobj::lock.
>>
>> This is reported by lockdep:
>>
>> [  188.139076]
>> ========================================================
>> [  188.139086] WARNING: possible irq lock inversion dependency
>> detected
>> [  188.139096] 7.3.0-rc3-00067-gc4f3feeaf60f #67 Tainted: G         C
>> [  188.139108] ------------------------------------------------------
>> --
>> [  188.139116] swapper/0/0 just changed the state of lock:
>> [  188.139125] ffff0000054f8ff8 (&vc4->job_lock){-...}-{3:3}, at:
>> vc4_irq+0xa8/0x28c [vc4]
>> [  188.139234] but this lock took another, HARDIRQ-unsafe lock in the
>> past:
>> [  188.139242]  (&syncobj->lock){+.+.}-{3:3}
>> [  188.139256] and interrupts could create inverse lock ordering
>> between them.
>> [  188.139267] other info that might help us debug this:
>> [  188.139275]  Possible interrupt unsafe locking scenario:
>> [  188.139284]        CPU0                    CPU1
>> [  188.139291]        ----                    ----
>> [  188.139299]   lock(&syncobj->lock);
>> [  188.139312]                                local_irq_disable();
>> [  188.139320]                                lock(&vc4->job_lock);
>> [  188.139335]                                lock(&syncobj->lock);
>> [  188.139350]   <Interrupt>
>> [  188.139358]     lock(&vc4->job_lock);
>> [  188.139372] *** DEADLOCK ***
>>
>> Hand the fence over after job_lock is dropped. The job can complete
>> and
>> drop exec->fence in that window, so take a reference first and
>> publish
>> through the local pointer, as exec may already be gone.
>>
>> Fixes: e84fcb95e074 ("drm/vc4: Export fence through syncobj")
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/vc4/vc4_gem.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c
>> b/drivers/gpu/drm/vc4/vc4_gem.c
>> index 6ee4bd77d433..f4be154d4eb0 100644
>> --- a/drivers/gpu/drm/vc4/vc4_gem.c
>> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
>> @@ -639,8 +639,11 @@ vc4_queue_submit(struct drm_device *dev, struct
>> vc4_exec_info *exec,
>>   	fence->seqno = exec->seqno;
>>   	exec->fence = &fence->base;
>>   
>> +	/* The job can complete and drop exec->fence as soon as
>> job_lock is
>> +	 * released, so hold our own reference.
>> +	 */
>>   	if (out_sync)
>> -		drm_syncobj_replace_fence(out_sync, exec->fence);
>> +		dma_fence_get(&fence->base);
>>   
>>   	vc4_attach_fences(exec);
>>   
>> @@ -662,6 +665,11 @@ vc4_queue_submit(struct drm_device *dev, struct
>> vc4_exec_info *exec,
>>   
>>   	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
>>   
>> +	if (out_sync) {
>> +		drm_syncobj_replace_fence(out_sync, &fence->base);
>> +		dma_fence_put(&fence->base);
>> +	}
>> +
> 
> Doesn't this mean that it is theoretically possible that a very small
> job completes and its FLDONE/FRDONE interrupts trigger before we had a
> chance to install the fence?

Yes, the job can signal before the out_sync fence is installed, but
that's harmless. Installing an already-signalled fence is valid and the
syncobj only becomes visible to userspace once the ioctl returns, which
happens after the replace. Therefore, in this scenario, userspace would
see a valid syncobj (already-signalled) anyway.

Best regards,
- Maíra

