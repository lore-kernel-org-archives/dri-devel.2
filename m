Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE01FC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE33210F1D9;
	Thu, 13 Aug 2026 07:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hdc/TYsG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D3C10F1D9;
 Thu, 13 Aug 2026 07:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=uyRKfejl5js6NDDDEUB7U7M5f2j8gaDH5+HlJp1OK1Q=; b=hdc/TYsGDH0NDLOjNwuULY7iR0
 LYnTlgCPFWxGsKWLRynPKYKRe4p+CdLURJBUM3wQ9IpzLpryIN4RV/PUE0Lcvu0ncdtzuuxd9lXZW
 mLz5G5CDJjRNolvT43BU7PMWMFkAbytoyRWz41PnAi8pJDWmRegq3KCoOIBcRmRHRpDuWOKVVvslx
 h8zbWxwVMtsk4qs0YFrtP8/FdtRYV8m2hK4EfGKHo7wlnE9pDoxz4ANz39VHNv+oDt/um0zmrvPQa
 4QYCxumAksNYP+C0XL6eSVrLmP2kPPoSXvrICw3DmOUbiQo/JNkH2J0pKyC/efPnr/kZ3ypLFpb8l
 zdetznoA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuQKu-000koQ-2G; Thu, 13 Aug 2026 09:58:48 +0200
Message-ID: <61a96635-e143-4d69-b0f7-0f312f5a3a3c@igalia.com>
Date: Thu, 13 Aug 2026 08:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
To: Luke.Wildhardt@proton.me
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@mailbox.org>, 
 phasta@kernel.org, "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
 <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
 <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
 <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
 <4OmZej9WiJ6-rsJ_lFcrmwtClAwMdN4oHXWH0p8FkIrhAn4LKS4O3q36wrdZrvjZHBNS8PZsvaIvR-1aFZfF2tDiy1cdMzTYNylcbGDQN68=@proton.me>
 <a9ee4edb-e763-4fd7-a510-32191df0cf8f@igalia.com>
 <Wgbhe0iRVno6QTXUasXAw96sdk1GzzJ8DW_Yw8EyCtxvwV4-EfRTaUdaF9vYeMYsMyfLVVTmXBOB1Br_d-l8b87D_2CMFyYSJi34eaaGGW4=@proton.me>
 <ylme_dYqb7yeNvmFl3ZeH3v8d_46-oAWr6t95wEZTYGiLMdbNTzXBFoV1zueOeHcKXcFrMMsoF0s_57Hzj0wwEfxDRjPhmu-xquKmeXKehg=@proton.me>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <ylme_dYqb7yeNvmFl3ZeH3v8d_46-oAWr6t95wEZTYGiLMdbNTzXBFoV1zueOeHcKXcFrMMsoF0s_57Hzj0wwEfxDRjPhmu-xquKmeXKehg=@proton.me>
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


On 13/08/2026 07:42, Luke.Wildhardt@proton.me wrote:
> Ok, after a lot of A/B testing, it appears that trying your "drm-intel/drm-sched-fair-fixed" branch, the stuttering is still there. It's definitely paced differently though, I will attach a video. It's "choppier" when it happens. I tested in a few different areas / times of day, in case you notice the scenery isn't the same; this is representative of what I experienced in other places. I will note, that I tried playing 4 times, 3/4 times, shortly after boot. 1/4 times I left my desktop to idle for about 30 minutes while I did something else, and I didn't encounter the issue at all in 10 minutes. Not sure how significant that is, or if it's just noise.
> 
> https://www.youtube.com/watch?v=GWyIVEuhooM
> 
> To make sure I wasn't insane, I went back to the patch Claude gave me, applied against a clean 7.2.0-rc7. At least again in a few sessions after boot, no issue. I'll post that exact code below.

Yes, I had a brain fart yesterday and had only pulled the lock out on 
the pop side. I have now pushed the updated branch, with both the add 
and pop side made symmetric in lock taking aspect.

If you could pull and re-test once more that would be great.

Regards,

Tvrtko

> If you need any other info from me let me know.
> 
> 
> --- a/drivers/gpu/drm/scheduler/sched_rq.c
> +++ b/drivers/gpu/drm/scheduler/sched_rq.c
> @@ -2,6 +2,7 @@
>   /* Copyright 2015 Advanced Micro Devices, Inc. */
>   /* Copyright (c) 2025 Valve Corporation */
> 
> +#include <linux/moduleparam.h>
>   #include <linux/rbtree.h>
> 
>   #include <drm/drm_print.h>
> @@ -9,6 +10,32 @@
> 
>   #include "sched_internal.h"
> 
> +/*
> + * Diagnostic counters. Not for submission.
> + *
> + * dbg_pop_stayed  - pops where the entity had another job queued and so stayed
> + *                   in the tree. No save/restore of vruntime occurs.
> + * dbg_pop_left    - pops where the entity queue drained, so it left the tree
> + *                   and drm_sched_entity_save_vruntime() ran. Only this path
> + *                   arms a later restore.
> + * dbg_add_restore - calls to drm_sched_rq_add_entity(), i.e. restores.
> + * dbg_add_race    - restores where the entity was still linked in the tree,
> + *                   meaning the vruntime being restored is still absolute.
> + *
> + * Incremented under rq->lock, so exact per scheduler and only mildly lossy
> + * when summed across rings. Writable so they can be reset between runs:
> + *   echo 0 > /sys/module/gpu_sched/parameters/dbg_pop_left
> + */
> +static unsigned long dbg_pop_stayed;
> +static unsigned long dbg_pop_left;
> +static unsigned long dbg_add_restore;
> +static unsigned long dbg_add_race;
> +
> +module_param(dbg_pop_stayed, ulong, 0644);
> +module_param(dbg_pop_left, ulong, 0644);
> +module_param(dbg_add_restore, ulong, 0644);
> +module_param(dbg_add_race, ulong, 0644);
> +
>   static __always_inline bool
>   drm_sched_entity_compare_before(struct rb_node *a, const struct rb_node *b)
>   {
> @@ -266,14 +293,40 @@
>   	sched = container_of(rq, typeof(*sched), rq);
>   	spin_lock(&rq->lock);
> 
> +	dbg_add_restore++;
> +	if (!RB_EMPTY_NODE(&entity->rb_tree_node)) {
> +		dbg_add_race++;
> +		pr_warn_ratelimited("drm_sched: vruntime race on ring %s (comm %s)\n",
> +				    sched->name, current->comm);
> +	}
> +
>   	if (list_empty(&entity->list)) {
>   		atomic_inc(sched->score);
>   		list_add_tail(&entity->list, &rq->entities);
>   	}
> 
> -	ts = drm_sched_rq_get_min_vruntime(rq);
> -	ts = drm_sched_entity_restore_vruntime(entity, ts, rq->head_prio);
> -	drm_sched_rq_update_tree_locked(entity, rq, ts);
> +	/*
> +	 * Only restore the vruntime if the entity actually left the run queue.
> +	 *
> +	 * drm_sched_entity_pop_job() dequeues the last job and only afterwards
> +	 * calls drm_sched_rq_pop_entity(), which is where the entity is removed
> +	 * from the tree and drm_sched_entity_save_vruntime() converts its
> +	 * vruntime to min_vruntime-relative form. A push landing in that window
> +	 * sees an empty queue, takes the "first job" path to here, and would
> +	 * restore a vruntime which is still absolute -- adding min_vruntime to
> +	 * it a second time. If the entity is also the leftmost one,
> +	 * drm_sched_rq_get_min_vruntime() returns the entity's own vruntime and
> +	 * the value is doubled, placing it far to the right of the tree where it
> +	 * will not be selected again until the run queue catches up.
> +	 *
> +	 * A still-linked entity never left, so its vruntime is already absolute
> +	 * and its tree position is valid. The concurrent pop will update both.
> +	 */
> +	if (RB_EMPTY_NODE(&entity->rb_tree_node)) {
> +		ts = drm_sched_rq_get_min_vruntime(rq);
> +		ts = drm_sched_entity_restore_vruntime(entity, ts, rq->head_prio);
> +		drm_sched_rq_update_tree_locked(entity, rq, ts);
> +	}
> 
>   	spin_unlock(&rq->lock);
>   	spin_unlock(&entity->lock);
> @@ -330,11 +383,13 @@
>   	if (next_job) {
>   		ktime_t ts;
> 
> +		dbg_pop_stayed++;
>   		ts = drm_sched_entity_update_vruntime(entity);
>   		drm_sched_rq_update_tree_locked(entity, rq, ts);
>   	} else {
>   		ktime_t min_vruntime;
> 
> +		dbg_pop_left++;
>   		drm_sched_rq_remove_tree_locked(entity, rq);
>   		min_vruntime = drm_sched_rq_get_min_vruntime(rq);
>   		drm_sched_entity_save_vruntime(entity, min_vruntime);
> 
> 
> 

