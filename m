Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FC3F46C62
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 17:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8DE10E245;
	Mon,  6 Apr 2026 17:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="b46ohCgL";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B270D10E245
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XVLXFSKDDmhhNjjQzCRj4AbzhYzUt+MT2Ws1Pn1+iq4=; b=b46ohCgLk6s3acWQG8279HART2
 KvwYkFkOV8XXvMFUViOIs65pecJVed2+8/ZPfT/LSvtMYkn+1WZoO5JRHnNPCKlYZrRSISvWbrKup
 kMfsWGUgVYahSOHL3I1LJiQlk0TMYdtP4+hJACFenbyr3JQjf0wLTXVe8jQwt3SJ75uHEC0aoYSaL
 hpjaZNwcNqi/brSFRoXV5rQWtnpwAV0TCp6BZxYo2lHlAvfyRCLIrKIA74MCJNFOU0/aO4NWTjAue
 g7J6DZOJgozzcg2c2kgacS7Ykqrll4VPjxiVs2poFFGpBjJ1A4J4UawmMKoWLksSr5Yf2BPWupJ/E
 9eFFpw5g==;
Received: from [189.7.87.169] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w9nio-00Cev4-0l; Mon, 06 Apr 2026 19:26:46 +0200
Message-ID: <c4720d5a-ee18-47e5-bac2-e3c521972931@igalia.com>
Date: Mon, 6 Apr 2026 14:26:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/vc4: Add per-file descriptor seqno tracking
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
 <20260402-vc4-drm-scheduler-v2-5-d84afd35c602@igalia.com>
 <39d288c0-8fb8-49bc-9c23-e8f90e00e579@igalia.com>
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
In-Reply-To: <39d288c0-8fb8-49bc-9c23-e8f90e00e579@igalia.com>
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

On 06/04/26 12:09, Tvrtko Ursulin wrote:

[...]

>> +
>>   static void
>>   vc4_job_free(struct kref *ref)
>>   {
>> @@ -260,6 +311,10 @@ vc4_render_job_free(struct kref *ref)
>>       vc4->bin_alloc_used &= ~job->bin_slots;
>>       spin_unlock_irqrestore(&vc4->job_lock, irqflags);
>> +    if (job->seqno)
>> +        xa_erase(&job->file->seqno_xa, job->seqno);
>> +
>> +    vc4_file_put(job->file);
>>       vc4_job_free(ref);
>>   }
>> @@ -428,6 +483,7 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void 
>> *data,
>>           return ret;
>>       exec.render = render;
>> +    render->file = vc4_file_get(vc4_priv);
>>       INIT_LIST_HEAD(&render->unref_list);
>>       ret = vc4_lookup_bos(dev, file_priv, render, args->bo_handles,
>> @@ -483,10 +539,20 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void 
>> *data,
>>       vc4_push_job(&render->base);
>>       mutex_unlock(&vc4->sched_lock);
>> +    ret = xa_alloc_cyclic(&vc4_priv->seqno_xa, &render->seqno,
>> +                  render->base.done_fence,
>> +                  xa_limit_32b, &vc4_priv->next_seqno, GFP_KERNEL);
>> +    if (ret < 0) {
>> +        /* Jobs are already queued, just skip seqno tracking. */
> 
> Why it is not better to allocate the seqno earlier and avoid the problem 
> of false positive waits?

Actually, right after sending this series to the mailing list, I had an
idea to solve this issue and I sent a patch implementing it for Etnaviv
[1]. I plan to do the same for vc4 in v3.

Thanks for your review!

[1] 
https://lore.kernel.org/dri-devel/20260402193424.2023318-1-mcanal@igalia.com/T/

Best regards,
- Maíra

> 
> Regards,
> 
> Tvrtko
> 
>> +        render->seqno = 0;
>> +    }
>>       vc4_attach_fences(file_priv, render, args->out_sync, render- 
>> >base.done_fence);
>>       drm_exec_fini(&exec_ctx);
>> +    /* Return the seqno for our job. */
>> +    args->seqno = render->seqno;
>> +
>>       vc4_job_put((void *)bin);
>>       vc4_job_put((void *)render);
>>
> 

