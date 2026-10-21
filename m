Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D39606A321
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=UqdNR6iB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF8A10E074;
	Wed, 21 Oct 2026 10:59:44 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C13110E074
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=EZGF2Rn+xGpbkoHxpw4caWn7Qkf8XmHK8YqDyB0mmTQ=; b=UqdNR6iB/jS77K5xbQgQaKcaWB
 Sd/o22Tu7Mq3aby2MbVTBu+CdNeNQDp9JN/2PQxYo47nLH4pSHokorFEvba6Ev0Lr4L9iLaN+MlGY
 ms7eR1EeDlXW1d9LQLQhv8Q5l3iAFGuQhvJAXVslYVrds11sd5sX5+6gCDtvmB/BILU5Lhg8yIoBa
 KtKuuJxAOwPV3FF87mhIhQWdHXHkvUXrCpN/bA3C+x9uvi7DnXmP0+9WPXAlY6SNh0oCpAD1V+axv
 nldKu67wyKribnYGbtuchdp7zQWD9qbYu+1fwdYLup44BJmiRNMl7bc3lGn6DrTIof4xZpIYMWVG9
 RHapZFbw==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJU2h-005YEC-6C; Wed, 21 Oct 2026 12:59:35 +0200
Message-ID: <3748ac1a-3afe-4293-8c20-48fcc4cf5f94@igalia.com>
Date: Wed, 21 Oct 2026 07:59:31 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] drm/sched: Disallow initializing entities with
 un-initialized schedulers
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
 <20261020154123.33631-3-tvrtko.ursulin@igalia.com>
 <sashiko-outbox-179327@kernel.org>
 <c32a1931-c0de-4d63-a8c8-2189c35137dc@igalia.com>
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
In-Reply-To: <c32a1931-c0de-4d63-a8c8-2189c35137dc@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tvrtko,

On 21/10/26 05:08, Tvrtko Ursulin wrote:
> 
> On 20/10/2026 17:02, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>> - [High] drm/sched: drm_sched_entity_init() breaks v3d_open() on V3D 3.3
>> -- 
>>
>> commit 607520d70e20fa56f0a8fa9eade2db9f019b764f
>> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>
>> drm/sched: Disallow initializing entities with un-initialized schedulers
>>
>> This patch updates drm_sched_entity_init() to reject schedulers whose
>> run-queues have not been initialized, returning -EINVAL instead of 
>> logging
>> a warning and continuing.
>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/ 
>>> drm/scheduler/sched_entity.c
>>> index e12709b7bd0c3..95bb79b3d003a 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>> @@ -119,9 +119,16 @@ int drm_sched_entity_init(struct 
>>> drm_sched_entity *entity,
>>>                 unsigned int num_sched_list,
>>>                 atomic_t *guilty)
>>>   {
>>> -    if (!entity || !sched_list || !num_sched_list || !sched_list[0])
>>> +    unsigned int i;
>>> +
>>> +    if (!entity || !sched_list || !num_sched_list)
>>>           return -EINVAL;
>>> +    for (i = 0; i < num_sched_list; i++) {
>>> +        if (!sched_list[i] || !sched_list[i]->sched_rq)
>>> +            return -EINVAL;
>>> +    }
>>
>> [Severity: High]
>> Does returning -EINVAL here when !sched_list[i]->sched_rq break
>> v3d_open() on V3D 3.3 hardware (V3D_GEN_33)?
>>
>> During probe, v3d_sched_init() in drivers/gpu/drm/v3d/v3d_sched.c only
>> initializes the V3D_CSD and V3D_CACHE_CLEAN schedulers when
>> v3d_has_csd(v3d) is true:
>>
>> drivers/gpu/drm/v3d/v3d_sched.c:v3d_sched_init() {
>>     ...
>>     if (v3d_has_csd(v3d)) {
>>         ret = v3d_queue_sched_init(v3d, &v3d_csd_sched_ops, V3D_CSD,
>>                        "v3d_csd");
>>         if (ret)
>>             goto fail;
>>
>>         ret = v3d_queue_sched_init(v3d, &v3d_cache_clean_sched_ops,
>>                        V3D_CACHE_CLEAN, "v3d_cache_clean");
>>         if (ret)
>>             goto fail;
>>     }
>>     ...
>> }
>>
>> On V3D 3.3 platforms where !v3d_has_csd(v3d), those two schedulers are
>> never initialized via drm_sched_init(), leaving their sched_rq pointers
>> NULL.
>>
>> However, when userspace opens the DRM device node, v3d_open() in
>> drivers/gpu/drm/v3d/v3d_drv.c unconditionally loops over all
>> V3D_MAX_QUEUES queues and fails if drm_sched_entity_init() returns an
>> error:
>>
>> drivers/gpu/drm/v3d/v3d_drv.c:v3d_open() {
>>     ...
>>     for (i = 0; i < V3D_MAX_QUEUES; i++) {
>>         v3d_priv->stats[i] = v3d_stats_alloc();
>>         if (!v3d_priv->stats[i]) {
>>             ret = -ENOMEM;
>>             goto err_stats;
>>         }
>>
>>         sched = &v3d->queue[i].sched;
>>         ret = drm_sched_entity_init(&v3d_priv->sched_entity[i],
>>                         DRM_SCHED_PRIORITY_NORMAL, &sched,
>>                         1, NULL);
>>         if (ret)
>>             goto err_sched;
>>     }
>>     ...
>> }
>>
>> Previously, drm_sched_entity_init() logged a warning via pr_warn() and
>> returned 0, allowing v3d_open() to succeed. With this change, won't
>> every v3d_open() call on V3D 3.3 fail with -EINVAL?
> 
> Oh well, guess I overestimated the general public sensitivity to weird 
> error messages.
> 
> Given the submit side is guarded with the same v3d_has_csd() as the 
> scheduler init, so those entities are not reachable after open, I think 
> I can just add a patch which adds the same skip condition in the 
> v3d_open() loop.
> 
> Maira - does that sound like it would work?

I wouldn't worry a lot about this error. I'm planning to remove V3D 3.3
support in 7.5 [1]. Anyway, don't worry, most likely nobody uses V3D 3.3
with the v3d driver. If it doesn't break V3D 4.2 and V3D 7.1 (which have 
CSD), I'm okay with the changes.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7ffcc4fffb45ee98e7a9683e109050246dc194af 


Best regards,
- Maíra

> 
> Regards,
> 
> Tvrtko
> 
>>
>> [ ... ]
>>
>>>
>>
> 

