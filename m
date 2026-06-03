Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C21CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1388410FDE6;
	Wed,  3 Jun 2026 13:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jnFFTPPf";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3272410FDE6
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2ZNGzKJNXN5rsxyBgbZO3QseJBddXcd4gnDNxIxGmH8=; b=jnFFTPPfFq049jaNlbQuNk2ZBT
 kvt+i+R1OJDEBkhL3o8aURRfOLawVaS0XpsLK4svXMRqc8cUBzNXMfQqCIuFXed7UMFU9j+9FYzfu
 WWmsHzmRvLsHwFisYV0pyjRTYbg0DSONWyHJAIcwH2CQfI8FZxuu2/8PkXzqYglUTt8AZ84UGQDDI
 xalmcVJkxk5sp+Igvs4j+dbSq/RzwQC1KsJN4TtvKONa20mYXkZ8dzClYKy9ItUxMzvgox2Ff0I5s
 3yy5miDgG68rxjY3TskswWyHxvzlpz+tu0DmaCCaIg0cmmQZb/az6VhETSJ+il7o6LWwCF7WxpkoK
 qAeymmfQ==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wUlTZ-00CBVi-Tb; Wed, 03 Jun 2026 15:17:42 +0200
Message-ID: <ccb31615-a395-4491-8055-0ab7a87574d6@igalia.com>
Date: Wed, 3 Jun 2026 10:17:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] drm/v3d: Introduce struct v3d_submit and convert
 CL/TFU/CSD ioctls
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
 <20260510-v3d-sched-misc-fixes-v2-8-ca4aba343ef6@igalia.com>
 <060b3060-6f6a-462e-9956-78fa5dfb6dc7@igalia.com>
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
In-Reply-To: <060b3060-6f6a-462e-9956-78fa5dfb6dc7@igalia.com>
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

Thanks for review!

On 25/05/26 09:29, Tvrtko Ursulin wrote:
> 
> Would it work to pass struct v3d_job **job instead of the void 
> **container? And add like:
> 
> BUILD_BUG_ON(offsetof(struct v3d_bin_job, base));
> ... for all job types ...
> 
> Callers can then pass in like:
> 
> ..., &bin->base, sizeof(*bin), ...
> 
> Slightly nicer and safer I think but up to you.

I'll address it in the next version. As I'll change this function, I
won't add your R-b.
> 
>> +    *container = kzalloc(size, GFP_KERNEL);
>> +    if (!*container)
>> +        return -ENOMEM;
>> +
>> +    job = *container;
>> +    job->v3d = v3d;
>> +    job->free = free;
>> +    job->file_priv = v3d_priv;
>> +

[...]

>> +
>> +static int
>> +v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
>> +{
>> +    struct v3d_file_priv *v3d_priv = submit->file_priv->driver_priv;
>> +    struct v3d_dev *v3d = submit->v3d;
>> +    struct v3d_perfmon *perfmon;
>> +
>> +    if (!perfmon_id)
>> +        return 0;
>> +
>> +    if (v3d->global_perfmon)
>> +        return -EAGAIN;
> 
> This check ends up quite deep in the submission chain so I wonder if it 
> makes sense to pull it out and have it earlier? It appears racy in any 
> case since AFAIU userspace can mess with it from a separate thread. Or 
> perhaps can keep in simple just as well.
> 
> But it possibly warrants a READ_ONCE too to document it is elsewhere 
> managed by (cmp)xchg.

I'll "ignore" this comment as it's addressed in a much complete way in
[1].

[1] 
https://lore.kernel.org/dri-devel/20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com/T/

[...]

>> @@ -933,131 +1044,82 @@ v3d_submit_cl_ioctl(struct drm_device *dev, 
>> void *data,
>>           }
>>       }
>> -    ret = v3d_job_allocate(v3d, (void *)&render, sizeof(*render));
>> -    if (ret)
>> -        return ret;
>> -
>> -    ret = v3d_job_init(v3d, file_priv, &render->base,
>> -               v3d_render_job_free, args->in_sync_rcl, &se, V3D_RENDER);
>> -    if (ret) {
>> -        v3d_job_deallocate((void *)&render);
>> -        goto fail;
>> -    }
>> -
>> -    render->start = args->rcl_start;
>> -    render->end = args->rcl_end;
>> -    INIT_LIST_HEAD(&render->unref_list);
>> -
>>       if (args->bcl_start != args->bcl_end) {
>> -        ret = v3d_job_allocate(v3d, (void *)&bin, sizeof(*bin));
>> +        ret = v3d_submit_add_job(&submit, (void **)&bin, sizeof(*bin),
>> +                     v3d_job_free, V3D_BIN);
>>           if (ret)
>>               goto fail;
>> -        ret = v3d_job_init(v3d, file_priv, &bin->base,
>> -                   v3d_job_free, args->in_sync_bcl, &se, V3D_BIN);
>> -        if (ret) {
>> -            v3d_job_deallocate((void *)&bin);
>> -            goto fail;
>> -        }
>> -
>>           bin->start = args->bcl_start;
>>           bin->end = args->bcl_end;
>>           bin->qma = args->qma;
>>           bin->qms = args->qms;
>>           bin->qts = args->qts;
>> -        bin->render = render;
>> -    }
> 
> Is there a particular reason why you changed the order of render and bin 
> job creation? I don't think it makes a difference to be clear, but just 
> checking in case there is some subtlety I missed.

As we now have v3d_submit_jobs(), we need to add the jobs to the array
in order of dependency. The BIN jobs depends on the RENDER job and
that's why we need to add it first.

Best regards,
- Maíra

