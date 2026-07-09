Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE56BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA2E10E06C;
	Thu,  9 Jul 2026 10:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="i5BhbSTR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C51B10E06C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gp/AV6im5EMWKQGjmrzE5QHAGTp+FASLHgeGJsAKloU=; b=i5BhbSTR1/wlgUX/KmuR3m3hsr
 4vaOIlvIt1UKg+xjn+H5cFr+exYrwJN5DS+68sdVzU5IEXE3YnbXec9RyV0iFpjP8QVkC/bFq0Bo5
 kPpiJ+kacKcxIBOS7UDaBGMsovHsxtlrm6avvRCcRiY/3W+KXXO3OstI1keNxrFR6LsQYM3FWcG3H
 GyKDihHwnDupx03UUOVyMgoaF8ruRdi9po/afx4PONOm9C6iysXWRbXH0hyP/Cy3TW9jjfx2pYg8A
 5tszkc1P6NY11Hkfg/jg+tRI/ptekrbG1uMLoBDVksWo1dq+NBuUHsnoHzba5dER9H9aM3Dyg8uXx
 l6WgAmDg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1whldh-00CAxA-Sa; Thu, 09 Jul 2026 12:05:53 +0200
Message-ID: <42890d89-367e-44f8-90e8-07f2580afca7@igalia.com>
Date: Thu, 9 Jul 2026 11:05:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] drm/panthor: Remove redundant drm_sched_job_cleanup()
 from the .free_job callback
To: Steven Price <steven.price@arm.com>, dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-2-tvrtko.ursulin@igalia.com>
 <cd319413-edd9-4bd6-b393-91f48fa7b795@arm.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <cd319413-edd9-4bd6-b393-91f48fa7b795@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 03/07/2026 16:00, Steven Price wrote:
> On 02/07/2026 15:37, Tvrtko Ursulin wrote:
>> After calling drm_sched_job_cleanup(), the free job callback releases it's
> 
> NIT: s/it's/its/
> 
>> reference to the job, where the act of dropping the last reference will
>> also call the drm_sched_job_cleanup() helper.
>>
>> We can therefore remove the redundant call from the .free_job callback.
>>
>> But we have to leave the "if (job->base.s_fence)" guard in job_release(),
>> since that one not only handles the above described double cleanup, but
>> also deals with all job cleanup paths which happen before the point the
>> job was armed.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Boris Brezillon <boris.brezillon@collabora.com>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Steven Price <steven.price@arm.com>
> 
> I agree this looks redundant.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>

Thank you!

Can this patch be picked up and merged on it's own and who can do it? 
Not sure if there is any CI for panthor it maybe needs to pass first.

Regards,

Tvrtko

>> ---
>>   drivers/gpu/drm/panthor/panthor_sched.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
>> index 5b34032deff8..2bee1c92fb9e 100644
>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>> @@ -3434,7 +3434,6 @@ queue_timedout_job(struct drm_sched_job *sched_job)
>>   
>>   static void queue_free_job(struct drm_sched_job *sched_job)
>>   {
>> -	drm_sched_job_cleanup(sched_job);
>>   	panthor_job_put(sched_job);
>>   }
>>   
> 

