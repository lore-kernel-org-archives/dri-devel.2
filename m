Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A0AF436A0
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1218710EA0A;
	Fri, 17 Apr 2026 13:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OuU/G+hV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Kso4GLZs";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A4310E2B8;
 Fri, 17 Apr 2026 13:21:23 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fxwWP49msz9v1l;
 Fri, 17 Apr 2026 15:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1776432081; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvRXgzD6+ssvrwhuL/u05Ihx+sCA1sq60lkpNgmwME0=;
 b=OuU/G+hVtWXLxRkLGaurEiJl9PDraLyC5LC10HxGHeM63vipZOTs3bsXztW8+Mcz6E9CLV
 1ndTvfOVPIP6sPvi38KZnH2oALLXIg+ZvfVm8M7Qq0Z8vR3FnVRmi35ZrUuidD7z9tqjV+
 /kWhRuiij6Yl88jRW8vxa/JqaFE/kUTvn3ofta1xgJisal+sKYkCUOZ63ZqY9FBaLDAuzt
 G8o1QrQBKCm/GMojOeiRXN9S06YYgPUHWCsHHHvcNioFCPbITpPzzY32wRMtX11IaMsXxW
 lFyTUj7Hojy6Y44nH9B9fXkjzThTl2s7DSDpl3drXahVyo3GDIjoBzt0JSBNxQ==
Message-ID: <b59eb5afb036b0357ce7d5f6d0c9fda7aee17bfa.camel@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1776432079; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvRXgzD6+ssvrwhuL/u05Ihx+sCA1sq60lkpNgmwME0=;
 b=Kso4GLZseJPFIMAyms84QQMqb+KUJpl2Af+p4nGhll4LMEGmU9Iuun6Owd1ZfXakNgucPP
 Ci6P/CQG/5Uh41QXDAf3ExhyR8SieXLzDPLuIiDUeXlr+4pO21ulTXUuhmodYN7OUIgvw2
 1RpNpMHM9ViQqAQiyqQ0ogzA+JEsXXrAsMkfT1mrYx6ObsWIMZlL/5KUlEQ5XnrEkhVF9d
 DXErWucZ3cv4CE+kHHB4SFeQ0aBEyrJCJkVOUpC/3Edjzo2o8cXQBz1ybBF23bmKPcdmcL
 ACLAnej7HumNm1N/aLObR1C59vOPPfXqNCyi4w/GoPVzLHOYTtd7ipSlzXzfGQ==
Subject: Re: [PATCH v8 00/29] *Fair(er) DRM scheduler
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org,  dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, kernel-dev@igalia.com, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Leo Liu
 <Leo.Liu@amd.com>, Lucas Stach <l.stach@pengutronix.de>, Matthew Brost
 <matthew.brost@intel.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Michel =?ISO-8859-1?Q?D=E4nzer?=
 <michel.daenzer@mailbox.org>,  Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Boris
 Brezillon <boris.brezillon@collabora.com>
Date: Fri, 17 Apr 2026 15:21:11 +0200
In-Reply-To: <20260417103744.76020-1-tvrtko.ursulin@igalia.com>
References: <20260417103744.76020-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 64c3f30d8a62795b568
X-MBO-RS-META: 6xdzcz81hrwsu48ni489rd63se8mi3yh
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

(intentional top-post since I refer everything below)

+Cc Thomas, Dave, Sima, Boris

Pushed to drm-misc-next.

Thanks a lot and congratulations for your hard work and endurance,
Tvrtko! Good to finally get this significant cleanup in.


dim, however, does report a merge conflict with drm-tip. I looked at
the diff and at first and second glance it doesn't seem to be caused by
this series? The diff I see circles around panthor_gem.c, drm_edid.c,
amdgpu_dm.c.

How can we help resolve it?


P.


On Fri, 2026-04-17 at 11:37 +0100, Tvrtko Ursulin wrote:
> [disclaimer]
> Please note that as this series includes patches which touch a good numbe=
r of
> drivers, I did not copy everyone on everything. Assumption is people are
> subscribed to dri-devel and for context can look at the whole series ther=
e.
> [/disclaimer]
>=20
> As a summary, the new scheduling algorithm is insipired by the original L=
inux
> CFS and so far no scheduling regressions have been found relative to FIFO=
.
> There are improvements in fairness and scheduling of interactive clients =
when
> running in parallel with a heavy GPU load (for example Pierre-Eric has on=
e
> viewperf medical test which shows a nice improvement with amdgpu).
>=20
> On the high level main advantages of the series are:
>=20
> =C2=A01. Scheduling quality - schedules better than FIFO, solves priority=
 starvation.
> =C2=A02. Code simplification - no more multiple run queues and multiple a=
lgorithms.
> =C2=A03. Virtual GPU time based scheduling enables relatively simple addi=
tion
> =C2=A0=C2=A0=C2=A0 of a scheduling cgroup controller in the future.
>=20
> There is a little bit more detailed write up on the motivation and result=
s in
> the form of a blog post which may be easier to read:
> https://blogs.igalia.com/tursulin/fair-er-drm-gpu-scheduler/
>=20
> First patches add some unit tests which allow for easy evaluation of sche=
duling
> behaviour against different client submission patterns. From there onward=
s it is
> hopefully a natural progression of cleanups, enablers, adding the fair po=
licy,
> and finally removing FIFO and RR and simplifying the code base due no mor=
e need
> for multiple run queues.
>=20
> Series is structured in a way where we could apply the first 12 patches (=
up to
> and including "drm/sched: Switch default policy to fair") in one kernel r=
elease
> and then follow up with the rest of the cleanups after a release or two i=
f
> things will be looking fine. Until the remainder of the series would be m=
erged
> it would be easy to flip the default algorithm back.
>=20
> Onto the performance evaluation. As a headline result I have tested three
> simultaneous clients on the Steam Deck:
>=20
> One instance of a deferredmultisampling Vulkan demo running with low prio=
rity,
> one normal priority instance of the same demo, and the Unigine Heaven ben=
chmark.
>=20
> With the FIFO scheduler we can see that the low priority client is comple=
tely
> starved and the GPU time distribution between the other two clients is un=
even:
>=20
> https://people.igalia.com/tursulin/drm-sched-fair/fifo-starvation.png
>=20
> Switching to the fair scheduler, GPU time distribution is almost equal an=
d the
> low priority client does get a small share of the GPU:
>=20
> https://people.igalia.com/tursulin/drm-sched-fair/fair-no-starvation.png
>=20
> Moving onto the synthetic submission patterns, they are about two simulta=
neous
> clients which broadly cover the following categories:
>=20
> =C2=A0* Deep queue clients
> =C2=A0* Hogs versus interactive
> =C2=A0* Priority handling
>=20
> Lets look at the results:
>=20
> 1. Two normal priority deep queue clients.
>=20
> These ones submit one second worth of 8ms jobs. As fast as they can, no
> dependencies etc. There is no difference in runtime between FIFO and fair=
 but
> the latter allows both clients to progress with work more evenly:
>=20
> https://people.igalia.com/tursulin/drm-sched-fair/normal-normal.png
>=20
> (X axis is time, Y is submitted queue-depth, hence lowering of qd corresp=
onds
> =C2=A0 with work progress for both clients, tested with both schedulers s=
eparately.)
>=20
> Round-robin is the same as fair here.
>=20
> 2. Same two clients but one is now low priority.
>=20
> https://people.igalia.com/tursulin/drm-sched-fair/normal-low.png
>=20
> Normal priority client is a solid line, low priority dotted. We can see h=
ow FIFO
> completely starves the low priority client until the normal priority is f=
ully
> done. Only then the low priority client gets any GPU time.
>=20
> In constrast, fair scheduler allows some GPU time to the low priority cli=
ent.
>=20
> Here round-robin flavours are the same as FIFO (same starvation issue).
>=20
> 3. Same clients but now high versus normal priority.
>=20
> Similar behaviour as in the previous one with normal a bit less de-priori=
tised
> relative to high, than low was against normal.
>=20
> https://people.igalia.com/tursulin/drm-sched-fair/high-normal.png
>=20
> And again round-robin flavours are the same as FIFO.
>=20
> 4. Heavy load vs interactive client.
>=20
> Heavy client emits a 75% GPU load in the format of 3x 2.5ms jobs followed=
 by a
> 2.5ms wait. Interactive client emits a 10% GPU load in the format of 1x 1=
ms job
> followed by a 9ms wait.
>=20
> This simulates an interactive graphical client used on top of a relativel=
y heavy
> background load but no GPU oversubscription.
>=20
> Graphs show the interactive client only and from now on, instead of looki=
ng at
> the client's queue depth, we look at its "fps".
>=20
> https://people.igalia.com/tursulin/drm-sched-fair/251008/4-heavy-vs-inter=
active.png
>=20
> Here round-robin and round-robin rewritten on top of FIFO are best, with =
the
> fair algorithm being very close. FIFO is clearly the worst.
>=20
> 5. An even heavier load vs interactive client.
>=20
> This one is oversubscribing the GPU by submitting 4x 50ms jobs and waitin=
g for
> only one microsecond before repeating the cycle. Interactive client is th=
e same
> 10% as above.
>=20
> https://people.igalia.com/tursulin/drm-sched-fair/251008/4-very-heavy-vs-=
interactive.png
>=20
> Here FIFO is even worse and fair is again almost as good as the two round=
-robin
> flavours.
>=20
> 6. Low priority GPU hog versus heavy-interactive.
>=20
> Low priority client: 3x 2.5ms jobs client followed by a 0.5ms wait.
> Interactive client: 1x 0.5ms job followed by a 10ms wait.
>=20
> https://people.igalia.com/tursulin/drm-sched-fair/251008/4-low-hog-vs-int=
eractive.png
>=20
> All schedulers appear to handle this almost equally well but FIFO could s=
till be
> the last while fair has a slight lead.
>=20
> As before, I am looking for feedback, ideas for what other kinds of submi=
ssion
> scenarios to test, testing on different GPUs and of course reviews.
>=20
> v2:
> =C2=A0* Fixed many rebase errors.
> =C2=A0* Added some new patches.
> =C2=A0* Dropped single shot dependecy handling.
>=20
> v3:
> =C2=A0* Added scheduling quality unit tests.
> =C2=A0* Refined a tiny bit by adding some fairness.
> =C2=A0* Dropped a few patches for now.
>=20
> v4:
> =C2=A0* Replaced deadline with fair!
> =C2=A0* Refined scheduling quality unit tests.
> =C2=A0* Pulled one cleanup patch earlier.
> =C2=A0* Fixed "drm/sched: Avoid double re-lock on the job free path".
>=20
> v5:
> =C2=A0* Rebase on top of latest upstream DRM scheduler changes.
> =C2=A0* Kerneldoc fixup.
> =C2=A0* Improve commit message justification for one patch. (Philipp)
> =C2=A0* Add comment in drm_sched_alloc_wq. (Christian)
>=20
> v6:
> =C2=A0* Rebase for "drm/sched: De-clutter drm_sched_init" getting merged.
> =C2=A0* Avoid NULL rq dereference from a bad rebase. (Maira)
> =C2=A0* Added some kerneldoc throughout. (Maira)
> =C2=A0* Removed some lockdep annotations not belonging to one patch. (Mai=
ra)
> =C2=A0* Use dma_fence_is_signaled in "drm/sched: Avoid double re-lock on =
the job free path". (Maira, Philipp)
>=20
> v7:
> =C2=A0* Rebase for some prep patches getting merged.
> =C2=A0* Dropped submit all ready jobs patch.
> =C2=A0* Fixed 64-bit division in unit tests.
> =C2=A0* Fixed some more rebase and patch re-ordering mistakes.
> =C2=A0* Preserve entity RR order when re-entering the queue.
> =C2=A0* Fine tuned the queue re-enter logic for better behaviour with int=
eractive
> =C2=A0=C2=A0 clients.
> =C2=A0* Removed some static inlines.
> =C2=A0* Added more kerneldoc.
> =C2=A0* Done some benchmarks in the round-robin scheduling modes.
>=20
> v8:
> =C2=A0* Rebased for upstream changes.
> =C2=A0* Added assert for reverse numerical order of DRM_SCHED_PRIORITY en=
ums.
> =C2=A0* Fixed head of rq priority updates.
>=20
> *** RFC -> PATCH change log version reset. ***
>=20
> v9 / v1:
> =C2=A0* RFC -> PATCH for the series as agreed during the XDC.
> =C2=A0* Updated interactive benchmark graphs.
> =C2=A0* Improved handling of interactive clients by replacing the random =
noise on tie
> =C2=A0=C2=A0 approach with the average job duration statistics.
> =C2=A0* Document in code why we track entity GPU stats in a reference cou=
nted structures.
> =C2=A0* Document the new structure fields added by the fair policy.
> =C2=A0* Undo some tab vs spaces damage.
> =C2=A0* More accurate wording in the fair policy commit message.
> =C2=A0* Default to fair policy in a separate patch.
> =C2=A0* Renamed drm_sched_rq_select_entity to drm_sched_select_entity and=
 make it only take sched.
> =C2=A0* Fixed kerneldoc after removing scheduling policies and renaming t=
he rq.
> =C2=A0* Reversed arguments of drm_sched_rq_init and cleanup callers. (New=
 patch)
> =C2=A0* Removed unused num_rqs from struct drm_sched_args. (New patches)
> =C2=A0* Unit tests:
> =C2=A0=C2=A0 * Added wait duration comments.
> =C2=A0=C2=A0 * Data structure comments.
> =C2=A0=C2=A0 * Better name for a local variable.
> =C2=A0=C2=A0 * Added comment to the short job duration assert.
> =C2=A0=C2=A0 * Added comment for cond_resched().
> =C2=A0=C2=A0 * Tweaked some comments
> =C2=A0=C2=A0 * Added client_done() helper and documented the READ_ONCE.
> =C2=A0=C2=A0 * Clarified cycles per second calculation.
>=20
> v2:
> =C2=A0* Dropped the sched_rq_init() argument re-order patch.
> =C2=A0* Pulled run queue management consolidation patches to start of the=
 series.
> =C2=A0* Drm_sched_rq_get_rr_ts() renamed to drm_sched_rq_next_rr_ts().
> =C2=A0* Added DRM_SCHED_PRIORITY_INVALID local define.
> =C2=A0* Added locking around the ktime_t vruntime read.
> =C2=A0* Expanded comment relating to the unlocked entity->priority read.
> =C2=A0* Expanded comment relating to the unlocked scheduler average job d=
uration read.
> =C2=A0* Various kerneldoc tweaks.
> =C2=A0* Undo some tab vs spaces damage harder.
> =C2=A0* Undo one empty line rebase damage.
> =C2=A0* Reworded commit message for the FIFO and RR removal patch.
> =C2=A0* Various commit message spelling, grammar and typo fixes.
> =C2=A0* Unit tests:
> =C2=A0=C2=A0 * Various style changes.
> =C2=A0=C2=A0 * More descriptive test names.
> =C2=A0=C2=A0 * Print legend for measured metrics.
> =C2=A0=C2=A0 * Check for memory allocation failures.
>=20
> v3:
> =C2=A0* Marked fair policy as default in the correct patch.
> =C2=A0* Further improved comment in drm_sched_rq_update_prio().
> =C2=A0* Moved DRM_SCHED_PRIORITY_INVALID to gpu_scheduler.h.
> =C2=A0* Added description of the GPU time to vruntime scaling factors.
> =C2=A0* Recorded more collected acks.
>=20
> v4:
> =C2=A0* Rebased, collect ackes and r-b-s receives so far.
> =C2=A0* New patch in the series for handling the new ethosu accel driver.
> =C2=A0* Bump lower priorities lower down in the run queue when they re-jo=
in, in order
> =C2=A0=C2=A0 to penalize them a bit more than simply making them second i=
n the line to
> =C2=A0=C2=A0 run as it was in v3.
>=20
> v5:
> =C2=A0* Rebased, collect ackes and r-b-s received so far.
> =C2=A0* Fix lost return statement introduced in v2 refactoring.
> =C2=A0* Use virtual runtime based on average job durations when placing t=
he re-
> =C2=A0=C2=A0 joining lower priority entity in the run-queue.
>=20
> v6:
> =C2=A0* Renamed drm_sched_entity_stats_alloc to drm_sched_entity_stats_ne=
w.
> =C2=A0* Moved drm_sched_entity_stats_job_add_gpu_time to sched_entity.c.
> =C2=A0* Improved kerneldoc for struct drm_sched_entity_stats.
> =C2=A0* Explained GPU accounting placement in the respective commit text.
> =C2=A0* Removed duplicated sched list assignment int the embedding the ru=
n-queue
> =C2=A0=C2=A0 patch.
>=20
> v7:
> =C2=A0* Rebased to catchup with upstream changes.
> =C2=A0* Dropped the two amdgpu dependencies from the series - they have b=
een merged
> =C2=A0=C2=A0 and have propagated to drm-next and drm-tip.
> =C2=A0* Applied acks/reviews received since v6.
>=20
> v8:
> =C2=A0* Checkpatch special edition:
> =C2=A0=C2=A0 * Typos, double blank lines, missing SPDX, broken line align=
ment, kerneldoc,
> =C2=A0=C2=A0=C2=A0=C2=A0 repeated words, bare unsigned type, kzalloc_obj.
>=20
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> CC: Leo Liu <Leo.Liu@amd.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Michel D=C3=A4nzer <michel.daenzer@mailbox.org>
>=20
> Tvrtko Ursulin (29):
> =C2=A0 drm/sched: Disallow initializing entities with no schedulers
> =C2=A0 drm/sched: Consolidate entity run queue management
> =C2=A0 drm/sched: Move run queue related code into a separate file
> =C2=A0 drm/sched: Add some scheduling quality unit tests
> =C2=A0 drm/sched: Add some more scheduling quality unit tests
> =C2=A0 drm/sched: Implement RR via FIFO
> =C2=A0 drm/sched: Free all finished jobs at once
> =C2=A0 drm/sched: Account entity GPU time
> =C2=A0 drm/sched: Remove idle entity from tree
> =C2=A0 drm/sched: Add fair scheduling policy
> =C2=A0 drm/sched: Favour interactive clients slightly
> =C2=A0 drm/sched: Switch default policy to fair
> =C2=A0 drm/sched: Remove FIFO and RR and simplify to a single run queue
> =C2=A0 drm/sched: Embed run queue singleton into the scheduler
> =C2=A0 accel/amdxdna: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 accel/rocket: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 accel/ethosu: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/etnaviv: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/imagination: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/lima: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/msm: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/nouveau: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/panfrost: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/panthor: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/sched: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/v3d: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/xe: Remove drm_sched_init_args->num_rqs usage
> =C2=A0 drm/sched: Remove drm_sched_init_args->num_rqs
>=20
> =C2=A0drivers/accel/amdxdna/aie2_ctx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/accel/ethosu/ethosu_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/accel/rocket/rocket_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 27 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_job.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 8 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c=C2=A0=C2=A0 |=C2=A0=C2=
=A0 8 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +-
> =C2=A0drivers/gpu/drm/etnaviv/etnaviv_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/imagination/pvr_queue.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/lima/lima_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/msm/msm_gem_vma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/msm/msm_ringbuffer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/nouveau/nouveau_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/panfrost/panfrost_job.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/panthor/panthor_mmu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/panthor/panthor_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/scheduler/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/scheduler/sched_entity.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 162 ++--
> =C2=A0drivers/gpu/drm/scheduler/sched_fence.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/scheduler/sched_internal.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 70 +-
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 351 +------
> =C2=A0drivers/gpu/drm/scheduler/sched_rq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 383 ++++++++
> =C2=A0drivers/gpu/drm/scheduler/tests/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0.../gpu/drm/scheduler/tests/mock_scheduler.c=C2=A0 |=C2=A0=C2=A0 1 =
-
> =C2=A0.../gpu/drm/scheduler/tests/tests_scheduler.c | 882 +++++++++++++++=
+++
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/xe/xe_dep_scheduler.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/xe/xe_execlist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/xe/xe_gpu_scheduler.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 44 +-
> =C2=A033 files changed, 1498 insertions(+), 481 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/scheduler/sched_rq.c
> =C2=A0create mode 100644 drivers/gpu/drm/scheduler/tests/tests_scheduler.=
c
>=20

