Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B73DC5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 19:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880EC10E074;
	Sat,  8 Aug 2026 19:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rnq/KSe3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8879A10E074
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 19:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=ZXC4aox/NGug+WpBGlq/4L9OGZpb+/t//u4viJ/2rYU=; b=rnq/KSe3CiGymflc+z8r1Obmr1
 qxeHm2+k2DE1/NLJvnqPEylq9IK0uHGiHh8Hi9svw00D4HHLikgSDDQ8PGmnr6BjP+n+xlFTbKTMJ
 ampMVbCt4dkfxmCSwK6jEEbS668TB8bDo/Oq9qmUtKggzOU2YGWIXz/NE/XvYBeAsDPwJ+OpED/39
 MEDGt+XA99WbDKkOMGxJOkSS9mULFViWeeWbrtkVb84OYTXQrhvHpDuz+pYOKfEbCg6KyLxhAcotZ
 wAQrS0Yim4nYR4Q+kPbqmoWZlOsqFNTEhoRAMpfwBzF/E/c/neu2QAVUJQ4Xb7diB7n3uMcFieIBJ
 81mvWahA==;
Received: from [187.36.208.132] (helo=[192.168.1.103])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wsmym-00FuwB-Oc; Sat, 08 Aug 2026 21:45:13 +0200
Message-ID: <6a9f10e2-9c6c-43d3-a024-3fd2764963c2@igalia.com>
Date: Sat, 8 Aug 2026 16:45:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] drm/vc4: Add DRM GPU scheduler infrastructure and
 job structures
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-3-ed6dc4defa53@igalia.com>
 <14cc0561-7b5e-4a7e-8c6f-4126017dddd7@igalia.com>
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
In-Reply-To: <14cc0561-7b5e-4a7e-8c6f-4126017dddd7@igalia.com>
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

On 07/08/26 06:22, Tvrtko Ursulin wrote:

>> +
>> +err_sched:
>> +    for (q--; q >= 0; q--)
>> +        drm_sched_entity_destroy(&vc4file->sched_entity[q]);
> 
> I keep forgetting if enum is guaranteed to be signed or not. For 
> avoidance of doubt you could write is as while (q-- > 0).
> 

Apparently, it's unsigned... I'll switch the type definition to a signed
int in the next version, thank you for noticing!

>> +    kfree(vc4file);
>> +    return ret;
>> +
>>   }

[...]

>> @@ -289,8 +321,8 @@ struct vc4_bo {
>>   struct vc4_fence {
>>       struct dma_fence base;
>>       struct drm_device *dev;
>> -    /* vc4 seqno for signaled() test */
> 
> Why this removal?

We will remove the (AFAIU deprecated) signaled() hook from vc4_fence.c
in the next patches.

> 
>>       uint64_t seqno;
>> +    enum vc4_queue queue;
>>   };
>>   #define to_vc4_fence(_fence)                    \

[...]

>> +void
>> +vc4_sched_fini(struct vc4_dev *vc4)
>> +{
>> +    enum vc4_queue q;
>> +
>> +    for (q = 0; q < VC4_MAX_QUEUES; q++) {
>> +        if (vc4->queue[q].sched.ready)
> 
> What is the ready check for?

It's useful in the error path, to skip schedulers that weren't
initialized yet.

> 
>> +            drm_sched_fini(&vc4->queue[q].sched);
>> +    }
>> +}
>>
> 
> Overall looks tidy to me and from the cover letter it sounds it works 
> well. If you haven't already, give it a lockdep pass, including the GPU 
> reset path and then with the entity error unwind you can have my r-b.

Thank you!

Best regards,
- Maíra

> 
> Regards,
> 
> Tvrtko
> 

