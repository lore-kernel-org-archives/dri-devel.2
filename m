Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0731CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 15:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E6510E5EF;
	Fri,  8 May 2026 15:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Gf/sXjFN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01B610E5EF
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U+GMQ4bzOWku9GQCHsNsgDCGhkLuEuVmseWU5cKAk34=; b=Gf/sXjFNGysKUS2hj16yvBw+lj
 /zvrpOV6duxgqxXY/kriHnAuLGxt5AabqC+559kP1m7vKyw4qR1WVF0WCqwtIc9SqjqgKauqduXOg
 nbMR5l5lJVvhC54Px51giZRwV0NlXVjnIx/CEB1rAO4tg/7QbzY45SHI/yFKx5nly1kQOK+A0N8L4
 1B0CMxbNokCGWDdOr0nvb0m3WnJCrS0h2bk3SKLmFjphf5Xt3tn0JQCtQDRomqSsAIKxkEzE+45v1
 grsB9fjoWFapg0KdB2MSmk9M7I4OZejXI+MEPyf9RTRLzA5H/ygG2nD7IKh9nwSokfOOXWBraabHg
 xtPuq15g==;
Received: from [189.7.87.137] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wLN7z-007weY-0n; Fri, 08 May 2026 17:28:34 +0200
Message-ID: <cdcecda5-285b-4582-93cd-0170575aa87a@igalia.com>
Date: Fri, 8 May 2026 12:28:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/v3d: Reject invalid syncobj handles in submit
 ioctls
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-6-bac63a8ceb6c@igalia.com>
 <b4ac5310-39f8-4a7d-9bce-906e100680ec@igalia.com>
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
In-Reply-To: <b4ac5310-39f8-4a7d-9bce-906e100680ec@igalia.com>
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

On 16/04/26 08:59, Tvrtko Ursulin wrote:
> 
> On 13/04/2026 16:03, Maíra Canal wrote:
>> drm_sched_job_add_syncobj_dependency() returns -ENOENT both when the
>> handle is zero and when the handle is non-zero but does not find a
>> corresponding existing syncobj (userspace bug). The driver previously
>> ignored -ENOENT in both cases, silently accepting broken handles.
>>
>> Distinguish the two: skip the call entirely when the handle is zero, as
>> there is no dependency, and let -ENOENT propagate for non-zero handles
>> that don't resolve, turning the error into a proper return to userspace.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_submit.c | 23 ++++++++++++-----------
>>   1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/ 
>> v3d_submit.c
>> index 054367ba533d..fe8b5757c3e8 100644
>> --- a/drivers/gpu/drm/v3d/v3d_submit.c
>> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
>> @@ -171,12 +171,11 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct 
>> drm_file *file_priv,
>>       int ret = 0;
>>       if (!has_multisync) {
>> -        ret = drm_sched_job_add_syncobj_dependency(&job->base, 
>> file_priv,
>> -                               in_sync, 0);
>> -        // TODO: Investigate why this was filtered out for the IOCTL.
>> -        if (ret && ret != -ENOENT)
>> -            return ret;
>> -        return 0;
>> +        /* Ignore syncobj if its handle is NULL */
> 
> Nitpick s/NULL/zero/ since it is not a pointer.
> 
>> +        if (in_sync)
>> +            ret = drm_sched_job_add_syncobj_dependency(&job->base, 
>> file_priv,
>> +                                   in_sync, 0);
> 
> Ah now ret needs to be initialized to zero (comment from previous patch)!
> 
>> +        return ret;
>>       }
>>       if (se->in_sync_count && se->wait_stage == queue) {
>> @@ -190,11 +189,13 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct 
>> drm_file *file_priv,
>>                   return -EFAULT;
>>               }
>> -            ret = drm_sched_job_add_syncobj_dependency(&job->base,
>> -                                   file_priv, in.handle, 0);
>> -            // TODO: Investigate why this was filtered out for the 
>> IOCTL.
>> -            if (ret && ret != -ENOENT)
>> -                return ret;
>> +            /* Ignore syncobj if its handle is NULL */
> 
> As above. Or perhaps even NULL makes sense as in null handle being an 
> invalid handle reads more obvious than a zero handle?
> 
>> +            if (in.handle) {
>> +                ret = drm_sched_job_add_syncobj_dependency(&job->base,
>> +                                       file_priv, in.handle, 0);
>> +                if (ret)
>> +                    return ret;
>> +            }
>>           }
>>       }
>>
> 
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> With a slight danger there is some userspace out there which relies on 
> this? Have you look at how Mesa uses it, and the history?

I've checked userspace usage and thankfully, we never relied on this.
IGT tests are also passing (which were the reason I added this -ENOENT
some years ago, as without them, the tests would fail).

Thanks for your review!

Best regards,
- Maíra

> 
> Regards,
> 
> Tvrtko
> 

