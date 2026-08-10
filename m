Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513D0C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD03A10E7D6;
	Mon, 10 Aug 2026 11:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="dDi3YCFA";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9031510E7D1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:36:53 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5218927884fso16991281cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1786361812; x=1786966612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SXRcPlyRBlzOQgIcCkcRdarCPll4g6nyvpn9WQFz5cU=;
 b=dDi3YCFAHpq8GRdGcaVW6GcZ5rMsR23lEx2hQd6zyIJjqvrc60Xk39UjnTCQa80K/d
 87GV3ameELWWxES0RKlJMTEC5Nr1ofsMQP6flhKCplVz0mZLGOB0jlwMmlpLduOFxzYW
 04wHXG7rAPDbZtm0bXgawQVAJSSXzwt89arzek5iIXxH3kgwnwhBMwbqA+0V5TseCIJm
 l0OAjbpI40/osw+Fcr1wJQhULaxTuJX94EFdW8YZhs0MLBCTjwiLhPSDBs2+WOHmHigm
 1DlYTWWBfRnUrJCukFbz8QKp+VqIMDn9rUxmP0a2PAzlibF/zbu5Ir6NA6MgPOTWWOw/
 hogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786361812; x=1786966612;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXRcPlyRBlzOQgIcCkcRdarCPll4g6nyvpn9WQFz5cU=;
 b=MCv49TLwqUXB6G61LsSW6W3zJq5Biud+Mr84gAkXwzxnhptO+f2HhueFYcBvsclZPm
 rljQ+FXnxLUpKoL1wV/byfkV4LqhR3TUmEbkiCVzfnY942ScUF1Rg4+WcDlHuK3EhLV8
 7qveESA51iGNzzATAUG+4EMExND8Z5yZ6QTSf23i5u1WyyxFob3HrKcZoZqXuEA4pqnN
 ML7H3L3CK3rSeH0P46Azr3EZV+WcgFAcQzKPPYczQO+lW2S0WBezIDA1xMzbPLb0rKhD
 lEezw79/q9bu99qg5cShRUQXdlP0qFNTi+Ds7bNWsgdbMwgFPIgtZguEgL6s/W6D1emn
 eUXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrR33xFBuAOtb3wg0dFen8wp2hSSCh3FkxWsSfeeMnNCAwlxpGYBFyQqY+NRBuStn6LxmfmiSq9cD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMhobxdXfmOVKz7Ta+05cYRhJ6OxQyIBZbDV0sdFYxP0dP8l0Q
 zfEd8CVL3XzDwVB7EiYcGK9VCvUNjfxxaRaSKm+MYJEqjjrnHzVSEDW3kMgpcP8yNmo=
X-Gm-Gg: AR+sD132VpKBg2MOnrm75wi+7wNfDAh7v3UvfSmBhJdInzeneBWrj6OTQAiPIt6ujlD
 E63i3coBGZVzsGR8vzccHj/OecJstOxRn5PYv+LUUq1NCcwJNxF4Fyvv353opoBsT7C+tFGb3Rg
 Sn+Vuk1RPH6pHAW4ceccXcNdC+U60b6vldA2t/bxbQuYRIeywAyx6gRFEkHPyyWHreTGEQRbl/r
 JrLmxor+9e2TcLuwz25FozDvo3S6nPvWuV7wHbWjbQ5pC1+Tb6jAPPnjPLTmbGYQo3RaQ4kUCeq
 970f7gm1BXb1mSJexlwbbdfvW1f/7Zq7/X63iliy/u/5R9S5R7lfMmFU1Dnmb4UhSoAuQTctY0B
 bU3+HdZetEllOTuIeo5FOWJjSLwV+5FvUHNwc2nwYITpSbNVRcocdgon+3e/ZJaJ9EDQiI6m2rO
 0XgtJUa05X+zeKMUhtfs70KQjx+g7Pl2JimomJM/aYGfqs2OWz9aU543j04E5g6lFEubiIToV7Y
 IC7fDJ83NjHqWzIXdWkWA==
X-Received: by 2002:a05:622a:1449:b0:51c:404:af7a with SMTP id
 d75a77b69052e-52d4bc9a5aamr7898791cf.31.1786361812300; 
 Mon, 10 Aug 2026 04:36:52 -0700 (PDT)
Received: from [192.168.0.116] ([90.249.211.112])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d165efd05sm69318071cf.20.2026.08.10.04.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 04:36:51 -0700 (PDT)
Message-ID: <1bf21e40-908d-4e66-80fd-7548a7a748c3@ursulin.net>
Date: Mon, 10 Aug 2026 12:36:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
To: Luke.Wildhardt@proton.me,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "dakr@kernel.org" <dakr@kernel.org>, "phasta@kernel.org"
 <phasta@kernel.org>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
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


Hi,

On 09/08/2026 00:33, Luke.Wildhardt@proton.me wrote:
> Since the DRM scheduler default policy was switched to FAIR in 7.2, sustained 100% GPU load in-game on my RX 9070 XT causes severe performance degradation. In the example title running through Proton, Project Silverfish, the foreground application degrades to roughly 10 fps or freezes outright while audio continues, and the KDE Plasma Wayland session can lock up entirely, requiring a reboot or killing the compositor to recover. The problem is not limited to games. Running the game in the background + alt tabbing, then playing a YouTube video can also cause the entire desktop to freeze.
> 
> Then, if the game starts to stutter, either alt-tabbing, or opening up a menu in game (which reduced the load on the GPU) immediately stops the stuttering.
> 
> The issue is reliably reproducible under sustained GPU saturation, although the time-to-failure varies. Increasing shadow load (which decreases in-game frame rate) substantially shortens the time-to-failure.
> 
> In game, MangoHud does not reveal any frametime discrepancy.
> 
> Bisection / test matrix
> 
> Reproducer: Project Silverfish (Proton) at settings that saturate the GPU, with a second GPU client active (browser video). Other titles show the same symptom under sustained load; I have not yet re-tested those specific titles against the fix.
> 
> Kernel	Result
> torvalds/master stock	FAIR (default)	FAIL
> same as above + reverts below	gpu_sched.sched_policy=2 (FAIR)	FAIL
> same as above + reverts below	gpu_sched.sched_policy=1 (FIFO)	PASS
> 7.1.5 release	PASS
> drm-next	FAIR (default)	FAIL
> 
> Reverted Commits:
> 
> d09339388b77 drm/sched: Remove drm_sched_init_args->num_rqs
> 2833a0512b4c drm/sched: Remove drm_sched_init_args->num_rqs usage
> 16e7698bc04d drm/sched: Embed run queue singleton into the scheduler
> 77a6809f1dc3 drm/sched: Remove FIFO and RR and simplify to a single run queue
> 45c211ddf92a drm/sched: Switch default policy to fair
> 2462a0ce23b0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
> 
> 
> 
> Kernel (failing):  7.2.0-rc6 (stock), also current drm-next
> Kernel (working):  7.2.0-rc6-default-revert-00006-g7e5de9b07e3d with sched_policy=1
>                     7.1 release
> Distro:            Arch Linux
> Session:           KDE Plasma 6.7.4 / Wayland (KWin), Qt 6.11.1, KF 6.28.0
> CPU:               AMD Ryzen 9 9950X3D
> RAM:               64 GiB
> GPU:               Sapphire Pulse Radeon RX 9070 XT
>                     03:00.0 [1002:7550] rev c0, subsys Sapphire 1478
> Motherboard:       ASUS (AM5 / 800-series chipset)
> Mesa:              26.1.6-arch1.1 (RADV, driverVersion 26.1.6)
> Vulkan:            instance 1.4.357 / device 1.4.354
> 
> 
> 
> 
> On the same reverted kernel build, changing only gpu_sched.sched_policy from 2 (FAIR) to 1 (FIFO) changes the result from reliably failing to passing extended stress testing.
> 
> 
> 
> Possible mitigation options
> 
> Given that 7.2 is late in the release cycle and 77a6809f1dc3 removes FIFO/RR as selectable policies, there is currently no runtime workaround for affected systems.
> 
> 
> Revert 45c211ddf92a so FIFO remains the default while FAIR remains available for further testing.
> 
> If necessary, also revert 77a6809f1dc3 and dependent changes to restore runtime policy selection.
> 
> Alternatively, fix the underlying FAIR regression if a suitable fix can be identified in time for 7.2.
> 
> 
> I mention the revert options because the justification for removing FIFO/RR included the absence of known regressions relative to those policies. This report appears to provide at least one counterexample.
> 
> 
> I am willing to test patches responsively and collect data if necessary.

Initially I thought it could be a missing wakeup but I couldn't spot 
any. Then I thought about the clue that the regressed/stuck state 
happens after some runtime, and is accelerated by the competing clients. 
So I thought could there be an accumulating error in vruntime handling 
somehow. The only problem I found so far is that I think the 
min_vruntime handling has a bug where if an entity never exists the 
run-queue it can get penalised by its' vruntime only growing, while the 
re-joining ones get the pull ahead of it. I think the fix is to make 
sure min_vruntime is strictly monotonic and strictly follows the last 
popped entity. On a re-read I also think that aligns with how the CPU 
scheduler does it.

Could you please test the below diff against the tip (no reverts):

diff --git a/drivers/gpu/drm/scheduler/sched_rq.c 
b/drivers/gpu/drm/scheduler/sched_rq.c
index 044546bcb5f8..6b40f0c44fe5 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -95,6 +95,7 @@ void drm_sched_rq_init(struct drm_sched_rq *rq)
  	INIT_LIST_HEAD(&rq->entities);
  	rq->rb_tree_root = RB_ROOT_CACHED;
  	rq->head_prio = DRM_SCHED_PRIORITY_INVALID;
+	rq->min_vruntime = 0;
  }

  /*
@@ -117,28 +118,6 @@ static const unsigned int vruntime_shift[] = {
  	[DRM_SCHED_PRIORITY_LOW]    = 7,
  };

-static ktime_t
-drm_sched_rq_get_min_vruntime(struct drm_sched_rq *rq)
-{
-	ktime_t vruntime = 0;
-	struct rb_node *rb;
-
-	lockdep_assert_held(&rq->lock);
-
-	rb = rb_first_cached(&rq->rb_tree_root);
-	if (rb) {
-		struct drm_sched_entity *entity =
-			rb_entry(rb, typeof(*entity), rb_tree_node);
-		struct drm_sched_entity_stats *stats = entity->stats;
-
-		spin_lock(&stats->lock);
-		vruntime = stats->vruntime;
-		spin_unlock(&stats->lock);
-	}
-
-	return vruntime;
-}
-
  static void
  drm_sched_entity_save_vruntime(struct drm_sched_entity *entity,
  			       ktime_t min_vruntime)
@@ -148,7 +127,7 @@ drm_sched_entity_save_vruntime(struct 
drm_sched_entity *entity,

  	spin_lock(&stats->lock);
  	vruntime = stats->vruntime;
-	if (min_vruntime && vruntime > min_vruntime)
+	if (ktime_after(vruntime, min_vruntime))
  		vruntime = ktime_sub(vruntime, min_vruntime);
  	else
  		vruntime = 0;
@@ -271,8 +250,8 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity)
  		list_add_tail(&entity->list, &rq->entities);
  	}

-	ts = drm_sched_rq_get_min_vruntime(rq);
-	ts = drm_sched_entity_restore_vruntime(entity, ts, rq->head_prio);
+	ts = drm_sched_entity_restore_vruntime(entity, rq->min_vruntime,
+					       rq->head_prio);
  	drm_sched_rq_update_tree_locked(entity, rq, ts);

  	spin_unlock(&rq->lock);
@@ -318,6 +297,7 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity 
*entity)
  {
  	struct drm_sched_job *next_job;
  	struct drm_sched_rq *rq;
+	ktime_t ts;

  	/*
  	 * Update the entity's location in the min heap according to
@@ -326,18 +306,17 @@ void drm_sched_rq_pop_entity(struct 
drm_sched_entity *entity)
  	spin_lock(&entity->lock);
  	rq = entity->rq;
  	spin_lock(&rq->lock);
+
+	ts = drm_sched_entity_update_vruntime(entity);
+	if (ktime_after(ts, rq->min_vruntime))
+		rq->min_vruntime = ts;
+
  	next_job = drm_sched_entity_queue_peek(entity);
  	if (next_job) {
-		ktime_t ts;
-
-		ts = drm_sched_entity_update_vruntime(entity);
  		drm_sched_rq_update_tree_locked(entity, rq, ts);
  	} else {
-		ktime_t min_vruntime;
-
  		drm_sched_rq_remove_tree_locked(entity, rq);
-		min_vruntime = drm_sched_rq_get_min_vruntime(rq);
-		drm_sched_entity_save_vruntime(entity, min_vruntime);
+		drm_sched_entity_save_vruntime(entity, rq->min_vruntime);
  	}
  	spin_unlock(&rq->lock);
  	spin_unlock(&entity->lock);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 363d13fc929f..892ef474c5c1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -252,6 +252,7 @@ struct drm_sched_entity {
   * @entities: list of the entities to be scheduled.
   * @rb_tree_root: root of time based priority queue of entities for 
FIFO scheduling
   * @head_prio: priority of the top tree element.
+ * @min_vruntime: Minimum virtual runtime for the run-queue.
   *
   * Run queue is a set of entities scheduling command submissions for
   * one specific ring. It implements the scheduling policy that selects
@@ -263,6 +264,7 @@ struct drm_sched_rq {
  	struct list_head		entities;
  	struct rb_root_cached		rb_tree_root;
  	enum drm_sched_priority		head_prio;
+	ktime_t				min_vruntime;
  };

  /**



Regards,

Tvrtko


