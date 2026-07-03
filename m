Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158CAC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CFF10E612;
	Fri,  3 Jul 2026 15:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="d97HccQb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF3610E612
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6+CoVQuM4REaS4+8QGcMfPaRbPcFafOihS7pbGLHW+E=; b=d97HccQbuMsWj+x4O2FA5gHAU7
 l1QvbC8/TXGfrdZhnWWWViNpbry/tGygMel6ZOdFKHaw5umGKCpSafTz/hoHa1vqr7OQbfsDwquY4
 xnQLblcrYmi6oZIxvNvHyVjzKHMOtPwdKh1rqEKQBRshdQCN1bzXJDisfSeChKnNaNcd4yvp2J6Q4
 jGldQz6Spa/PFnlWBBwCztv9kp49nm/TggOX3inYj813JJMwV4CJoyQ2qJ5VeHZf4TnTQVeLqqvJ3
 SDGU5545FtjT9k1BFFhVZfMvFzgWIMtdfagp2hB2RqG0m0N8GdsCSFKTwDfwjmw7Dxvi29IUPm7Hw
 YFFbh8uw==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wffNT-008X89-Eo; Fri, 03 Jul 2026 17:00:27 +0200
Message-ID: <03a876e9-d204-4f93-9c7d-71948f186da7@igalia.com>
Date: Fri, 3 Jul 2026 12:00:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/v3d: Associate BOs with every job that
 accesses them
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
 <20260618-v3d-cpu-job-fixes-v2-1-fec132484fc4@igalia.com>
 <9e7d8d8da55c7cae9f56c8af3a8e2a527aeedae1.camel@igalia.com>
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
In-Reply-To: <9e7d8d8da55c7cae9f56c8af3a8e2a527aeedae1.camel@igalia.com>
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

On 02/07/26 03:44, Iago Toral wrote:
> I think we probably want to add a comment in v3d_submit_cl_ioctl when
> we setup the bin job explaining why we postpone looking up the BO list
> until the render job.
> 
> With that, this is: Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
> 

Thanks for the review!

> Also, unrelated to this patch: should we not use the same
> v3d_lookup_bos helper in the TFU submit path instead of having a loop
> looking up individual BOs one by one?

TFU uses a fixed BO array with the handles (__u32 bo_handles[4]) instead
of a u64 variable that points to the array. That's why the treatment is
different.

Best regards,
- Maíra

> 
> Iago
> 
> El jue, 18-06-2026 a las 12:03 -0300, Maíra Canal escribió:
>> A submission can expand into a chain of jobs (e.g. bin + render +
>> cache
>> clean), but v3d_lookup_bos() only looked up the user's BO list onto
>> the
>> *last* job of the submission. Every earlier job was left with
>> bo_count == 0 and an empty bo[] array.
>>
>> As a consequence, when implicit synchronization happens in
>> v3d_submit_lock_reservations(), earlier jobs get no implicit
>> dependencies at all, as the loop is gated on job->bo_count and
>> earlier
>> jobs don't have any BO attached to them. With that, the RENDER job
>> could
>> therefore be dispatched to the hardware and read a BO while another
>> context
>> was still writing it, leading to data corruption.
>>
>> Fix this by calling v3d_lookup_bos() for each job that references the
>> submission's BOs, so every job carries its own bo[]/bo_count and
>> picks
>> up the correct implicit dependencies during reservation locking.
>>
>> Fixes: dffa9b7a78c4 ("drm/v3d: Add missing implicit
>> synchronization.")
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/v3d/v3d_submit.c | 36 +++++++++++++++++-------------
>> ------
>>   1 file changed, 17 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
>> b/drivers/gpu/drm/v3d/v3d_submit.c
>> index ee2ac2540ed5..18467e448c91 100644
>> --- a/drivers/gpu/drm/v3d/v3d_submit.c
>> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
>> @@ -68,7 +68,6 @@ v3d_submit_unlock_reservations(struct v3d_submit
>> *submit)
>>   /**
>>    * v3d_lookup_bos() - Sets up job->bo[] with the GEM objects
>>    * referenced by the job.
>> - * @dev: DRM device
>>    * @file_priv: DRM file for this fd
>>    * @job: V3D job being set up
>>    * @bo_handles: GEM handles
>> @@ -82,23 +81,19 @@ v3d_submit_unlock_reservations(struct v3d_submit
>> *submit)
>>    * failure, because that will happen at `v3d_job_free()`.
>>    */
>>   static int
>> -v3d_lookup_bos(struct v3d_submit *submit, u64 bo_handles, u32
>> bo_count)
>> +v3d_lookup_bos(struct drm_file *file_priv, struct v3d_job *job,
>> +	       u64 bo_handles, u32 bo_count)
>>   {
>> -	struct v3d_job *last_job = submit->jobs[submit->job_count -
>> 1];
>> -
>> -	last_job->bo_count = bo_count;
>> -
>> -	if (!last_job->bo_count) {
>> -		/* See comment on bo_index for why we have to check
>> -		 * this.
>> -		 */
>> -		drm_warn(&submit->v3d->drm, "Rendering requires
>> BOs\n");
>> +	if (!bo_count) {
>> +		drm_warn(&job->v3d->drm, "Rendering requires
>> BOs\n");
>>   		return -EINVAL;
>>   	}
>>   
>> -	return drm_gem_objects_lookup(submit->file_priv,
>> +	job->bo_count = bo_count;
>> +
>> +	return drm_gem_objects_lookup(file_priv,
>>   				      (void __user
>> *)(uintptr_t)bo_handles,
>> -				      last_job->bo_count, &last_job-
>>> bo);
>> +				      job->bo_count, &job->bo);
>>   }
>>   
>>   static void
>> @@ -446,7 +441,8 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit
>> *submit,
>>   	if (IS_ERR(clean_job))
>>   		return PTR_ERR(clean_job);
>>   
>> -	return v3d_lookup_bos(submit, args->bo_handles, args-
>>> bo_handle_count);
>> +	return v3d_lookup_bos(submit->file_priv, &job->base,
>> +			      args->bo_handles, args-
>>> bo_handle_count);
>>   }
>>   
>>   static void
>> @@ -1085,6 +1081,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
>> void *data,
>>   	if (ret)
>>   		goto fail;
>>   
>> +	ret = v3d_lookup_bos(submit.file_priv, &render->base,
>> +			     args->bo_handles, args-
>>> bo_handle_count);
>> +	if (ret)
>> +		goto fail;
>> +
>>   	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
>>   		clean_job = v3d_submit_add_job(&submit,
>> V3D_CACHE_CLEAN);
>>   		if (IS_ERR(clean_job)) {
>> @@ -1097,10 +1098,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
>> void *data,
>>   	if (ret)
>>   		goto fail;
>>   
>> -	ret = v3d_lookup_bos(&submit, args->bo_handles, args-
>>> bo_handle_count);
>> -	if (ret)
>> -		goto fail;
>> -
>>   	ret = v3d_submit_lock_reservations(&submit);
>>   	if (ret)
>>   		goto fail;
>> @@ -1359,7 +1356,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev,
>> void *data,
>>   	 * the CSD and clean jobs in the case of indirect CSD job.
>>   	 */
>>   	if (args->bo_handle_count) {
>> -		ret = v3d_lookup_bos(&submit, args->bo_handles,
>> args->bo_handle_count);
>> +		ret = v3d_lookup_bos(submit.file_priv, &cpu_job-
>>> base,
>> +				     args->bo_handles, args-
>>> bo_handle_count);
>>   		if (ret)
>>   			goto fail;
>>   	}
>>
> 

