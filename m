Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E19C5AD44
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 19:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5165610E36D;
	Sat,  8 Aug 2026 19:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="J1AE6fVd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2955610E36D
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 19:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=P3ApS2iXCRhgB7jOCYlxfj5o3HcjkBYGTuPWJJ1Kcr4=; b=J1AE6fVd/LAUqq87u6bBR9Nem3
 HiSZWLPAjWQGCQ+j7f1O1qk4m48erLuscipl+Uw54p3i9Q449xLf+aW1q23zakJaOnLWucany9dhe
 p70+G3of7lZ/PQAlVsrbf93DBFqln65qZA+Dtl815XX0NWdJBAJvd/E+T7+NKr81aJLFhry/q31hS
 dl0XDGUS6EVtgV416G4Rpwy16zQuIod2MZjk+ti4eoSLZtKqQx6rYL5RuWXZEFGkPC/qOMj1/PRiG
 +OAVQKpoLP/3AuZipjRENTvsdM0MkOUuVlA16xkoPfFIf45Ck3LNaYCgI8yB6BfEqcsJ50dxCtlwN
 RN+u0vSg==;
Received: from [187.36.208.132] (helo=[192.168.1.103])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wsmQA-00FuTH-Dm; Sat, 08 Aug 2026 21:09:26 +0200
Message-ID: <c3547c50-b43d-4ce0-8db3-6fde11ba6389@igalia.com>
Date: Sat, 8 Aug 2026 16:09:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] drm/vc4: Protect perfmon state with a dedicated
 lock
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-2-ed6dc4defa53@igalia.com>
 <33f867c2-7f75-4127-b537-f54b1bda0bed@igalia.com>
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
In-Reply-To: <33f867c2-7f75-4127-b537-f54b1bda0bed@igalia.com>
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

On 07/08/26 05:54, Tvrtko Ursulin wrote:

>> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/ 
>> vc4_gem.c
>> index f0c711f114cf..f84d82b3bfbb 100644
>> --- a/drivers/gpu/drm/vc4/vc4_gem.c
>> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
>> @@ -491,7 +491,7 @@ vc4_submit_next_bin_job(struct drm_device *dev)
>>       /* Only start the perfmon if it was not already started by a 
>> previous
>>        * job.
>>        */
>> -    if (exec->perfmon && vc4->active_perfmon != exec->perfmon)
>> +    if (exec->perfmon && vc4->perfmon_state.active != exec->perfmon)
> 
> Shouldn't the second check be moved to under the lock in vc4_perfmon_start?

Yeah, you are correct. As this check won't be needed in a future patch,
I believe I forgot it. I'll add it to this patch in the next version to
guarantee bisectability.

> 
>>           vc4_perfmon_start(vc4, exec->perfmon);
>>       /* Either put the job in the binner if it uses the binner, or
>> @@ -1138,6 +1138,7 @@ int vc4_gem_init(struct drm_device *dev)
>>       INIT_LIST_HEAD(&vc4->render_job_list);
>>       INIT_LIST_HEAD(&vc4->job_done_list);
>>       spin_lock_init(&vc4->job_lock);
>> +    spin_lock_init(&vc4->perfmon_state.lock);
>>       INIT_WORK(&vc4->hangcheck.reset_work, vc4_reset_work);
>>       timer_setup(&vc4->hangcheck.timer, vc4_hangcheck_elapsed, 0);
>> diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/ 
>> vc4_perfmon.c
>> index f75dfd156756..2bcf6a7d538f 100644
>> --- a/drivers/gpu/drm/vc4/vc4_perfmon.c
>> +++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
>> @@ -51,16 +51,18 @@ void vc4_perfmon_start(struct vc4_dev *vc4, struct 
>> vc4_perfmon *perfmon)
>>       if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>>           return;
>> -    if (WARN_ON_ONCE(!perfmon || vc4->active_perfmon))
>> +    if (!perfmon)
>>           return;
> 
> The only caller already ensures perfmon cannot be NULL so the check here 
> is redundant. Maybe you want it for later in the series, or for symmetry 
> with stop? Will see later.
> 
> What is lost though is the second check, especially since 
> vc4_submit_next_bin_job has its "active differs" check outside the lock.
> Was that an impossible condition to begin with? Is there scope to clean 
> something up before adding a new lock in this patch?
> 
>> +    guard(spinlock_irqsave)(&vc4->perfmon_state.lock);
>> +
>>       for (i = 0; i < perfmon->ncounters; i++)
>>           V3D_WRITE(V3D_PCTRS(i), perfmon->events[i]);
>>       mask = GENMASK(perfmon->ncounters - 1, 0);
>>       V3D_WRITE(V3D_PCTRC, mask);
>>       V3D_WRITE(V3D_PCTRE, V3D_PCTRE_EN | mask);
> 
> These are mmio? How costly on this hardware are they? Lets see later in 
> the series if they can be moved outside the locked irq off section by 
> maybe courtesy of run_job implicit serialisation.

I believe we still need to guard them against the delete IOCTL and fd
closure.

> 
> Hm, does it even need to be irqsave ie can this be called from interrupt 
> context?
> 

In a couple of patches, it will :)

>> -    vc4->active_perfmon = perfmon;
>> +    vc4->perfmon_state.active = perfmon;
>>   }
>>   void vc4_perfmon_stop(struct vc4_dev *vc4, struct vc4_perfmon *perfmon,
>> @@ -71,8 +73,12 @@ void vc4_perfmon_stop(struct vc4_dev *vc4, struct 
>> vc4_perfmon *perfmon,
>>       if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>>           return;
>> -    if (WARN_ON_ONCE(!vc4->active_perfmon ||
>> -             perfmon != vc4->active_perfmon))
> 
> Not worth keeping the "unexpected perfmon"  warning in some fashion?

I have the impression that vc4_perfmon_delete() can use the return "if
(perfmon != vc4->perfmon_state.active)" in a legitimate way, that's why
I removed the warning.

Best regards,
- Maíra


