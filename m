Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80032CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4C510F60B;
	Fri, 12 Jun 2026 17:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WqwK4WzI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A382510F60B
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
 In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6xKptOxkaRdU2m+AIgIG1b6ebA9/IB66ovcPFEqOg4A=; b=WqwK4WzIcw1R+2dgpp2MGaxqgi
 YnRTPcWYxLe6M94vz5YLSh06lpdciAPOQhWM5KNvurQIlOcT20Ag93b8WRGD5HX0sei/WZmNHFSOm
 lXJAwfL13yhAcjfP+53tRpld1MuQ1hAeYzm1TQH0QH1zVoDY6HWW1tHK6X8P9IRrndhYjKws1lK/Y
 fYS5RuJw2jbiDxFQ7tKBYJJ0PHIbSmpkTqY67bV4Id7y81dOvO7TqUvnMYWpkVv2h/0DXYiic8N2X
 5oPC7At5emH2Z3/k8ZxujcidgdI2c5d+e2vwfxH9zH99dVeh3/YJX0My86Kyj+GOCX9S22VeWJ/cj
 L0d+/H1A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wY5w8-00GiGQ-H8; Fri, 12 Jun 2026 19:44:56 +0200
Received: from webmail.service.igalia.com ([192.168.21.45])
 by mail.igalia.com with esmtp (Exim)
 id 1wY5w6-003WKG-2i; Fri, 12 Jun 2026 19:44:56 +0200
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
 by webmail.service.igalia.com with esmtp (Exim 4.98.2)
 (envelope-from <anholt@igalia.com>) id 1wY5w5-000000099Ms-3dU8;
 Fri, 12 Jun 2026 19:44:53 +0200
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 10:44:53 -0700
From: Emma Anholt <anholt@igalia.com>
To: Iago Toral <itoral@igalia.com>
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm/v3d: Associate BOs with every job that accesses
 them
In-Reply-To: <4a83fb4434459846c2e2936e4bbd297b75d70af1.camel@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
 <20260610-v3d-cpu-job-fixes-v1-1-0d9c88989edc@igalia.com>
 <4a83fb4434459846c2e2936e4bbd297b75d70af1.camel@igalia.com>
Message-ID: <b61d3055e59f0c83ac5b72ddc0befd04@igalia.com>
X-Sender: anholt@igalia.com
Content-Type: text/plain; charset=UTF-8
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

On 2026-06-10 23:17, Iago Toral wrote:
> Hi Maíra,
> 
> I have a couple of thoughts here:
> 
> 1. The original code seems to very specifica about targeting this only
> for the last job, which makes it look like a very intentional decision,
> so I wonder if there is something we are missing here. I am adding Emma
> to the CC in case she has any thoughts about it.
> 
> 2. I am not aware of any issues despite not having implicit sync for
> all the jobs in the chanin. Like you mention, this is because user-
> space is already trying to handle job depedencies, so I wonder if we
> should instead work on the opposite direction and try to drop implicit
> sync in the kernel entirely. Would that make sense? What are other
> drivers doing in this regard?

Yeah, you should be working toward dropping implicit sync entirely. 
tu's VM_BIND is really nice and where you want to be eventually, but
even if not, then you at least want something like
MSM_SUBMIT_NO_IMPLICIT.

I probably just didn't think about this implicit sync case in the
initial implementation, because a bin job dependency on results from
another context is just not a thing that's going to happen in practice. 
The implicit sync was mostly about render targets / texturing to be
ordered correctly with X11, and about lifetime management of the BO
(which only needed the last use).

> As for the patch itself, I have a comment below:
> 
> El mié, 10-06-2026 a las 19:50 -0300, Maíra Canal escribió:
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
>> jobs don't have any BO attached to them. With that, the BIN job reads
>> the
>> same buffers as the RENDER job, yet nothing made it wait for a prior
>> writer to finish. The BIN job could therefore be dispatched to the
>> hardware and read a BO while another context was still writing it,
>> leading to data corruption that was only avoided as the userspace
>> adds
>> explicit syncobjs.
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
>>  drivers/gpu/drm/v3d/v3d_submit.c | 41 +++++++++++++++++++++---------
>> ----------
>>  1 file changed, 22 insertions(+), 19 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
>> b/drivers/gpu/drm/v3d/v3d_submit.c
>> index ee2ac2540ed5..3d6582dfb1bf 100644
>> --- a/drivers/gpu/drm/v3d/v3d_submit.c
>> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
>> @@ -68,7 +68,6 @@ v3d_submit_unlock_reservations(struct v3d_submit
>> *submit)
>>  /**
>>   * v3d_lookup_bos() - Sets up job->bo[] with the GEM objects
>>   * referenced by the job.
>> - * @dev: DRM device
>>   * @file_priv: DRM file for this fd
>>   * @job: V3D job being set up
>>   * @bo_handles: GEM handles
>> @@ -82,23 +81,19 @@ v3d_submit_unlock_reservations(struct v3d_submit
>> *submit)
>>   * failure, because that will happen at `v3d_job_free()`.
>>   */
>>  static int
>> -v3d_lookup_bos(struct v3d_submit *submit, u64 bo_handles, u32
>> bo_count)
>> +v3d_lookup_bos(struct drm_file *file_priv, struct v3d_job *job,
>> +	       u64 bo_handles, u32 bo_count)
>>  {
> 
> Wouldn't it make more sense to have this function take the submit like
> it did originally and loop through all the jobs in a chain instead of
> calling this multiple times for each job in a chain?
> 
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
>>  		return -EINVAL;
>>  	}
>>  
>> -	return drm_gem_objects_lookup(submit->file_priv,
>> +	job->bo_count = bo_count;
>> +
>> +	return drm_gem_objects_lookup(file_priv,
>>  				      (void __user
>> *)(uintptr_t)bo_handles,
>> -				      last_job->bo_count, &last_job-
>> >bo);
>> +				      job->bo_count, &job->bo);
>>  }
>>  
>>  static void
>> @@ -446,7 +441,8 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit
>> *submit,
>>  	if (IS_ERR(clean_job))
>>  		return PTR_ERR(clean_job);
>>  
>> -	return v3d_lookup_bos(submit, args->bo_handles, args-
>> >bo_handle_count);
>> +	return v3d_lookup_bos(submit->file_priv, &job->base,
>> +			      args->bo_handles, args-
>> >bo_handle_count);
>>  }
>>  
>>  static void
>> @@ -1066,6 +1062,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
>> void *data,
>>  					   &se);
>>  		if (ret)
>>  			goto fail;
>> +
>> +		ret = v3d_lookup_bos(submit.file_priv, &bin->base,
>> +				     args->bo_handles, args-
>> >bo_handle_count);
>> +		if (ret)
>> +			goto fail;
>>  	}
>>  
>>  	render = (struct v3d_render_job
>> *)v3d_submit_add_job(&submit, V3D_RENDER);
>> @@ -1085,6 +1086,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
>> void *data,
>>  	if (ret)
>>  		goto fail;
>>  
>> +	ret = v3d_lookup_bos(submit.file_priv, &render->base,
>> +			     args->bo_handles, args-
>> >bo_handle_count);
>> +	if (ret)
>> +		goto fail;
>> +
>>  	if (args->flags & DRM_V3D_SUBMIT_CL_FLUSH_CACHE) {
>>  		clean_job = v3d_submit_add_job(&submit,
>> V3D_CACHE_CLEAN);
>>  		if (IS_ERR(clean_job)) {
>> @@ -1097,10 +1103,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev,
>> void *data,
>>  	if (ret)
>>  		goto fail;
>>  
>> -	ret = v3d_lookup_bos(&submit, args->bo_handles, args-
>> >bo_handle_count);
>> -	if (ret)
>> -		goto fail;
>> -
>>  	ret = v3d_submit_lock_reservations(&submit);
>>  	if (ret)
>>  		goto fail;
>> @@ -1359,7 +1361,8 @@ v3d_submit_cpu_ioctl(struct drm_device *dev,
>> void *data,
>>  	 * the CSD and clean jobs in the case of indirect CSD job.
>>  	 */
>>  	if (args->bo_handle_count) {
>> -		ret = v3d_lookup_bos(&submit, args->bo_handles,
>> args->bo_handle_count);
>> +		ret = v3d_lookup_bos(submit.file_priv, &cpu_job-
>> >base,
>> +				     args->bo_handles, args-
>> >bo_handle_count);
>>  		if (ret)
>>  			goto fail;
>>  	}
>>
