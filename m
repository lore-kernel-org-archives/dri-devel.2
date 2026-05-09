Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D11CD343F
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 13:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B3810E2D1;
	Sat,  9 May 2026 13:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GQ3wYsKp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C9E10E2D1
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ggwm+ZpuEOFftqh15QOSOO329SlvX0mDqr+EbgeQxE4=; b=GQ3wYsKpezmZ/GPWJT/l/OXwI/
 bqdZZIUhqfZFhC3kiWfKoODIymnGwngWQPqrCMiXAPFTp6WadoJbzgrZnCEwnzH2GlG6M7EOdvj6S
 oCbgq64V3Xe+O0+1JiCxjPgHsBsYxZXvDtuTt45lKFT3wp1Ax5J7MVr3RhVwXW6FVaR01QFiYVytG
 2O7RI/qdcFRRAciVSMsbthQeYs47qDgdzPzrD3IQrL4GupswvJjBhpxfX+XQQ2udIMbk915yZ9fRB
 CNe0KyieqVBsNkG3JjTpyvp+QAHPk6Db96XuAvXPpzcV4tpNf87aI1JisrxP2pROzwdTziTKwUOHg
 zFADEOmw==;
Received: from [189.7.87.137] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wLhoI-008Jj2-LT; Sat, 09 May 2026 15:33:38 +0200
Message-ID: <9cf60e24-7451-4501-801a-93c1ccb70bf7@igalia.com>
Date: Sat, 9 May 2026 10:33:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] drm/v3d: Refactor CPU ioctl into unified submission
 chain
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-9-bac63a8ceb6c@igalia.com>
 <b597c7f7-d7bb-4ea3-bae2-ac6dc03bbaf6@igalia.com>
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
In-Reply-To: <b597c7f7-d7bb-4ea3-bae2-ac6dc03bbaf6@igalia.com>
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

On 17/04/26 11:38, Tvrtko Ursulin wrote:
> 
> On 13/04/2026 16:03, Maíra Canal wrote:
>> Restructure the CPU ioctl so that all job types, including indirect CSD,
>> use a single struct v3d_submit chain and a single DRM exec context.
>>
>> Currently, v3d_get_cpu_indirect_csd_params(), which is the indirect CSD
>> parser, not only parses the ioctl arguments, but also creates the jobs 
>> and
>> locks the BOs during extension parsing. This breaks the default 
>> submission
>> flow and creates a nested job submission.
>>
>> This refactoring turns v3d_get_cpu_indirect_csd_params() into a pure
>> parser. Now, job creation and BO locking happen in the ioctl function,
>> which appends the indirect CSD and CLEAN_CACHE jobs to the same struct
>> v3d_submit and locks the union of all jobs' BOs under one drm_exec. This
>> eliminates the second drm_exec, the nested submission, and the 
>> conditional
>> two-pass fence attachment that the CPU ioctl previously required for the
>> indirect CSD path.
>>
>> For the refactoring, change the functions v3d_lock_bo_reservations(),
>> v3d_lookup_bos(), v3d_setup_csd_jobs_and_bos() and
>> v3d_attach_fences_and_unlock_reservation() to take struct v3d_submit
>> instead of individual arguments. The BO locking helper now iterates over
>> all jobs in the submission and locks the union, instead of only handling
>> the last job of the chain.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_drv.h    |   9 +-
>>   drivers/gpu/drm/v3d/v3d_submit.c | 341 +++++++++++++ 
>> +-------------------------
>>   2 files changed, 121 insertions(+), 229 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/ 
>> v3d_drv.h
>> index fc12e5215fb0..071d919fe860 100644
>> --- a/drivers/gpu/drm/v3d/v3d_drv.h
>> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
>> @@ -422,8 +422,10 @@ struct v3d_indirect_csd_info {
>>       /* Indirect CSD */
>>       struct v3d_csd_job *job;
>> -    /* Clean cache job associated to the Indirect CSD job */
>> -    struct v3d_job *clean_job;
>> +    /* Indirect CSD args, stashed by the extension parser and later used
>> +     * to create the CSD job from them.
>> +     */
>> +    struct drm_v3d_submit_csd args;
>>       /* Offset within the BO where the workgroup counts are stored */
>>       u32 offset;
>> @@ -438,9 +440,6 @@ struct v3d_indirect_csd_info {
>>       /* Indirect BO */
>>       struct drm_gem_object *indirect;
>> -
>> -    /* Context of the Indirect CSD job */
>> -    struct drm_exec exec;
>>   };
>>   struct v3d_timestamp_query_info {
>> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/ 
>> v3d_submit.c
>> index 5b519a892985..36402fc25c10 100644
>> --- a/drivers/gpu/drm/v3d/v3d_submit.c
>> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
>> @@ -20,28 +20,42 @@
>>    * to v3d, so we don't attach dma-buf fences to them.
>>    */
> 
> It the comment above (not shown in the diff) still accurate?
> 
>>   static int
>> -v3d_lock_bo_reservations(struct v3d_job *job, struct drm_exec *exec)
>> +v3d_lock_bo_reservations(struct v3d_submit *submit)
>>   {
>> -    int i, ret;
>> +    int i, j, ret;
>> -    drm_exec_init(exec, DRM_EXEC_INTERRUPTIBLE_WAIT, job->bo_count);
>> -    drm_exec_until_all_locked(exec) {
>> -        ret = drm_exec_prepare_array(exec, job->bo, job->bo_count, 1);
>> +    drm_exec_init(&submit->exec,
>> +              DRM_EXEC_INTERRUPTIBLE_WAIT | 
>> DRM_EXEC_IGNORE_DUPLICATES, 0);
>> +    drm_exec_until_all_locked(&submit->exec) {
>> +        for (i = 0; i < submit->job_count; i++) {
>> +            struct v3d_job *job = submit->jobs[i];
> 
> As per v3d_lookup_bos only the last job carries the initialize job->bo 
> so is the loop required? Only for reserving the fence slot?
> 
> [comes back later]
> 
> Hmmm, or is the csd submit the special case where two jobs can point to 
> different bos?

Exactly. In the indirect CSD case, the CPU job points to one BO array
and the CSD job points to another. That's why this rework was needed.

> 
> Sorry this is a monster diff. I ended up applying it and am jumping back 
> and forth.

I'm thinking about splitting this patch into two for the next version to
ease the reviewing process.

Thanks for the review!

Best regards,
- Maíra
