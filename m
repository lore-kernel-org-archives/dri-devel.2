Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC06BC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B7810F829;
	Fri,  3 Jul 2026 15:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Vkeam8O7";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id ACEB210F829
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:00:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A151F02;
 Fri,  3 Jul 2026 08:00:52 -0700 (PDT)
Received: from [10.1.29.35] (e122027.cambridge.arm.com [10.1.29.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C1BC3F905;
 Fri,  3 Jul 2026 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783090857; bh=16u6uLAxllWCchtj4HUWLALz1rD8yHSbBh57kk21vDs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Vkeam8O7eIYXSqjqoBxyYIFmh1zo6KXI5R5MKay+6E90qOjuLpi+GLGubwUnrgUaA
 E/aA8lopAp0AAmkuAinZ+UF2kWOsMPSi1CHml6kAZBrJ/XycyoUDJbI6IiTlY3ic31
 GpUW3hNrX60Fj3WPfEPiBl4B2Qco51Qt3XFLGutk=
Message-ID: <cd319413-edd9-4bd6-b393-91f48fa7b795@arm.com>
Date: Fri, 3 Jul 2026 16:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/8] drm/panthor: Remove redundant drm_sched_job_cleanup()
 from the .free_job callback
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-2-tvrtko.ursulin@igalia.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260702143745.79293-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
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

On 02/07/2026 15:37, Tvrtko Ursulin wrote:
> After calling drm_sched_job_cleanup(), the free job callback releases it's

NIT: s/it's/its/

> reference to the job, where the act of dropping the last reference will
> also call the drm_sched_job_cleanup() helper.
> 
> We can therefore remove the redundant call from the .free_job callback.
> 
> But we have to leave the "if (job->base.s_fence)" guard in job_release(),
> since that one not only handles the above described double cleanup, but
> also deals with all job cleanup paths which happen before the point the
> job was armed.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Steven Price <steven.price@arm.com>

I agree this looks redundant.

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 5b34032deff8..2bee1c92fb9e 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3434,7 +3434,6 @@ queue_timedout_job(struct drm_sched_job *sched_job)
>  
>  static void queue_free_job(struct drm_sched_job *sched_job)
>  {
> -	drm_sched_job_cleanup(sched_job);
>  	panthor_job_put(sched_job);
>  }
>  

