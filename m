Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF4BCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABDC10E312;
	Thu, 11 Jun 2026 11:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S+bEAs8j";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3901410EE98
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xgcD6COU+kZagJzmXfAaNmEQozLIuFB+qvYXXbTxbsw=; b=S+bEAs8jefLO7s5zBHoov0bnn/
 NkIBVxWoRXwALrqR8vKAr6z+tL1adgaKvcU+G0TS3tHjlmnQwa+9ORbvxo7QYg3oE63luZrNGDzFP
 t/WmGsVoi1mGYY6oRWJoFGjb65qP6AXJxTbwwgXn2MFKCGiETMXor3yeyVWF21k2f1VukNKXUMQ8f
 aRAlbRTGMGHIYq6Wa+C7yhfOC3+xuL2RdBDdK8ChD5ruC5M1WOu03NwPUr/quyOS9dHcYBW+SyGNc
 ssLwDdc4NlA/23U02MKyGsoqwhZWslUz9vr2EA+ctj7wvXJq83t5XeaAm9nElsve6+jYNjwLPbUw5
 dB/n2SKw==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wXdug-00G5iT-EB; Thu, 11 Jun 2026 13:49:34 +0200
Message-ID: <37a44215-4fd5-4569-a619-a5677e4b19fb@igalia.com>
Date: Thu, 11 Jun 2026 08:49:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/v3d: Associate BOs with every job that accesses
 them
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 Emma Anholt <anholt@igalia.com>
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
 <20260610-v3d-cpu-job-fixes-v1-1-0d9c88989edc@igalia.com>
 <4a83fb4434459846c2e2936e4bbd297b75d70af1.camel@igalia.com>
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
In-Reply-To: <4a83fb4434459846c2e2936e4bbd297b75d70af1.camel@igalia.com>
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

On 11/06/26 03:17, Iago Toral wrote:
> Hi Maíra,
> 
> I have a couple of thoughts here:
> 
> 1. The original code seems to very specifica about targeting this only
> for the last job, which makes it look like a very intentional decision,
> so I wonder if there is something we are missing here. I am adding Emma
> to the CC in case she has any thoughts about it.
> 

I have the impression that this is a consequence of several design
changes that the driver passed through the years. Initially, the v3d
driver only had a CL submission and attaching BOs to the last job meant
attaching to the render job. This was fine, only considering the caveat
mentioned in commit dffa9b7a78c4 "drm/v3d: Add missing implicit
synchronization": "we currently only implicitly sync for the rendering
pass, not binning -- if you texture-from-pixmap in the binning vertex
shader you'll miss out on synchronization."

However, with time, we added the CACHE_CLEAN flag to the CL submission
(so the last job could be a CACHE_CLEAN job) and we added CSD and TFU
submissions. Then, attaching the BOs to the last job wasn't the correct
approach anymore.

> 2. I am not aware of any issues despite not having implicit sync for
> all the jobs in the chanin. Like you mention, this is because user-
> space is already trying to handle job depedencies, so I wonder if we
> should instead work on the opposite direction and try to drop implicit
> sync in the kernel entirely. Would that make sense? What are other
> drivers doing in this regard?
> 

Maybe some one who has been around for longer could bring a historical
overview about this topic. From my understand, I don't think we can drop
implicit sync because it's part of the dma-buf synchronization contract.
If I'm not mistaken, v3d_submit_attach_object_fences() publishes our
fence so a consumer (e.g. compositor, KMS) can wait on us, and
drm_sched_job_add_implicit_dependencies() makes us wait on other actors'
fences already on the buffer. Mesa only syncs within its own context,
but it doesn't sync shared buffers cross-processes.

We can think about creating a EXPLICIT_SYNC flag for the BOs in the
future. We can talk more about this idea privately.

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
>>   drivers/gpu/drm/v3d/v3d_submit.c | 41 +++++++++++++++++++++---------
>> ----------
>>   1 file changed, 22 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c
>> b/drivers/gpu/drm/v3d/v3d_submit.c
>> index ee2ac2540ed5..3d6582dfb1bf 100644
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
> 
> Wouldn't it make more sense to have this function take the submit like
> it did originally and loop through all the jobs in a chain instead of
> calling this multiple times for each job in a chain?

We don't want to attach the BOs to all the jobs in the chain. For
example, I don't believe we would want to attach BOs to a CLEAN_CACHE
job.

Best regards,
- Maíra

