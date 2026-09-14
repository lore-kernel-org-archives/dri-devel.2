Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9A3C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A6D10EA40;
	Mon, 14 Sep 2026 12:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mvUKThE+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF90910ED44
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=S5ARf8UjwoiiC9BKHeLJlozUNC5PG8wxA6yusSaYoUY=; b=mvUKThE+Tv7K0OxXl27By2TqwJ
 7cSkvvAR/tBbe6RXtQi1VMuRntZ0KoQjm6GKwBAE9f6TQq0RNEijYzbH5B6ppjJqc907rlkOVvaVB
 cDmkJtxS55Gn2IHpTWbfLW0IjWk14/7U1Jcxl45FxpzoPsNbkQg0M7kul1MDO1e6kpsKDXC9TMOnT
 BEHRo8gGpGrlycgt2HIQNzHcB6Gc4vB1jCkS2aKm6XzZs+2SGknSYHqQ0w4vVzlEkZiVVzohpgKvp
 3ifnD+XrF45EzDGtxacgLTq4LwmIeSMuzlH8QyfMM09p1YRk9TFMJA/KDgk7N3IyW2kbg8cyq8JE5
 ffarSbfQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x65X6-001sHx-DZ; Mon, 14 Sep 2026 14:11:36 +0200
Message-ID: <f8ddff14-7800-451d-92c4-3f63ebba275d@igalia.com>
Date: Mon, 14 Sep 2026 13:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Free the run queues at the end of
 drm_sched_fini()
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luben Tuikov <ltuikov89@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260910121601.805032-1-donggeunyoo.kernel@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260910121601.805032-1-donggeunyoo.kernel@gmail.com>
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


On 10/09/2026 13:16, Donggeun Yoo wrote:
> drm_sched_fini() frees the run queues at the top of teardown but the array
> holding them at the bottom. The early half is on the wrong side of
> cancel_delayed_work_sync(&sched->work_tdr), which waits for a timeout
> handler that can still walk sched->sched_rq[i] through
> drm_sched_increase_karma().
> 
> No correct driver can be there, since every fence returned from run_job()
> must be signaled before drm_sched_fini() is called. Free the entries next
> to the array anyway, so run-queue teardown happens in one place.
> 
> Link: https://lore.kernel.org/dri-devel/20260910054605.634135-1-donggeunyoo.kernel@gmail.com/
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> Targets drm-misc-next (0878e6053d01).
> 
> A cleanup - no Fixes:, no Cc: stable.
> 
> The KUnit case and how to run it:
> https://github.com/donggeunyoo/drm-sched-fini-uaf-repro
> 
> x86_64 under QEMU, KUNIT + KASAN + lockdep, whole drm_sched suite, three
> runs per arm:
> 
>    before  38-41 KASAN slab-use-after-free reports, all from
>            drm_sched_increase_karma() on the timeout worker
>    after   0
> 
>   drivers/gpu/drm/scheduler/sched_main.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 6cb6f9546493..fec04c944c5e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1210,9 +1210,6 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
>   
>   	drm_sched_wqueue_stop(sched);
>   
> -	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
> -		kfree(sched->sched_rq[i]);
> -
>   	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
>   	wake_up_all(&sched->job_scheduled);
>   
> @@ -1226,6 +1223,9 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
>   	if (sched->own_submit_wq)
>   		destroy_workqueue(sched->submit_wq);
>   	sched->ready = false;
> +
> +	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
> +		kfree(sched->sched_rq[i]);
>   	kfree(sched->sched_rq);
>   	sched->sched_rq = NULL;
>   

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

