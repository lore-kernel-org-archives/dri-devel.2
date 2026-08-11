Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00114C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48BC610E3DB;
	Wed, 12 Aug 2026 07:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="Rj5jtiD8";
	dkim-atps=neutral
X-Greylist: delayed 91105 seconds by postgrey-1.36 at gabe;
 Tue, 11 Aug 2026 17:59:18 UTC
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch
 [79.135.106.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072F410ED16
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=3jue3prkvzdelhxqbbuuvwtkqe.protonmail; t=1786471155; x=1786730355;
 bh=Rhq8TQEyp/YkXN1pgK+No4ze40gOJy7gf5bTiXAy8xk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Rj5jtiD873I7jKzJj9eX5AUjZgOQx8tzvXszjkLAJc7kRVrn+RvP2hghKv9lY/mjD
 oXT5pIL0WEaiQR37Q5abIr/V8dxMsWHUuKG+5XCILr5rQ5gtsvKFx8q4UGDpjaJxpL
 4l0Oh74xS10wwbFt41FLj/jicUI6Srl8OLckEpKrCKIhLIuOMZjsVaZyXD+XXUKvbU
 PvgnuvTtWp5isvQtal+j0lGR0ESh5+T5xOEmce+5t7ANoEQWsvh0WII/Se2blfEFQs
 X3W8hcqAvJA1gVwwKnm/EA6Zgyyg/aBeWEM0CCJzeIytp2eDXEy0pLJ3uE+43tHaAV
 eO6ZVQcWMFWSA==
Date: Tue, 11 Aug 2026 17:59:09 +0000
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
From: Luke.Wildhardt@proton.me
Cc: Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@mailbox.org>,
 phasta@kernel.org, "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "ckoenig.leichtzumerken@gmail.com" <ckoenig.leichtzumerken@gmail.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
Message-ID: <4OmZej9WiJ6-rsJ_lFcrmwtClAwMdN4oHXWH0p8FkIrhAn4LKS4O3q36wrdZrvjZHBNS8PZsvaIvR-1aFZfF2tDiy1cdMzTYNylcbGDQN68=@proton.me>
In-Reply-To: <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
 <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
 <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
 <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
Feedback-ID: 214028577:user:proton
X-Pm-Message-ID: 33967dafe27c211d4ea346d13d616ab9ee968239
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

I want to be very clear here, I was working with Claude Opus on debugging t=
his issue. I am not a good programmer and work in on the hardware side of t=
hings, so this is only code I've tested and not of my creation, just hoping=
 to be helpful.



It appears the freezing (and maybe what I'll call micro freezing instead of=
 stuttering) was resolved after an issue was potentially identified in driv=
ers/gpu/drm/scheduler/sched_rq.c

I did a 20m play session attempting to reproduce the issue but was not able=
 to. Previously, I could reproduce this on-demand.

I will copy the writeup it created and the testing we did below. I am only =
claiming that the freezing had been seemingly resolved, not a particular fi=
tness or correct identification of the issue, that is for developers to jud=
ge.

Quotations are an output of a summery I had Claude create.

"
THE INVARIANT

drm_sched_entity_stats::vruntime is held absolute while the entity is linke=
d
in the run queue tree, and relative to min_vruntime while it is idle.
save_vruntime() converts one way on the way out, restore_vruntime() the oth=
er
on the way back in. drm_sched_rq_add_entity() calls restore unconditionally=
,
which is only correct if the entity has definitely been through save.


THE WINDOW

drm_sched_entity_pop_job():

    spsc_queue_pop(&entity->job_queue);      /* queue now empty */

    drm_sched_rq_pop_entity(entity);         /* takes entity->lock inside *=
/

No lock held across those two lines. A concurrent push seeing the queue emp=
ty
gets first =3D=3D true, calls add_entity, and restores a vruntime that has =
not yet
been saved -- adding min_vruntime to an already-absolute value. If the enti=
ty
is leftmost, get_min_vruntime() returns its own vruntime and it doubles.

It persists: pop_entity then finds the pushed job, takes the next_job branc=
h,
and update_vruntime() carries the inflated value forward. The entity sits f=
ar
right in the tree and is not selected until min_vruntime catches up, which
under sustained load may be effectively never.


EVIDENCE

WARN_ON_ONCE(!RB_EMPTY_NODE(&entity->rb_tree_node)) at the top of
add_entity(), after the rq lock, fires reproducibly.

That condition should be unreachable. add_entity() is reached only from the
"first job" branch of push_job(), and first is true only when the SPSC queu=
e
was empty. A linked entity implies its last pop_entity() peeked non-empty.
Empty queue and still linked cannot both hold in any ordered execution. Fre=
sh
entities are excluded -- entity_init() calls RB_CLEAR_NODE() unconditionall=
y.

Instrumented as a counter instead, with ring and comm logged:

  idle 10s:      0 races /  5662 restores
  gameplay 60s:  8 races / 43315 restores

  [ 192.754604] vruntime race on ring gfx_0.0.0 (comm kwin_wayla:cs0)
  [ 226.882135] vruntime race on ring gfx_0.0.0 (comm kwin_wayla:cs0)
  [ 292.226032] vruntime race on ring gfx_0.0.0 (comm kwin_wayla:cs0)

plus Xwayland:cs0 and vkd3d_queue on gfx, and many more on sdma0/sdma1. The
gfx_0.0.0 / kwin_wayla:cs0 entries are the compositor submission thread on =
the
graphics ring -- the process that dies when the desktop freezes.


CHANGE

The principled fix is presumably to close the window by holding entity->loc=
k
across the pop, which needs a _locked variant of drm_sched_rq_pop_entity().
I did not attempt that. What I tested checks the invariant instead: a still=
-
linked entity never left, so its vruntime is already absolute and its tree
position valid.

--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ drm_sched_rq_add_entity
-=09ts =3D drm_sched_rq_get_min_vruntime(rq);
-=09ts =3D drm_sched_entity_restore_vruntime(entity, ts, rq->head_prio);
-=09drm_sched_rq_update_tree_locked(entity, rq, ts);
+=09if (RB_EMPTY_NODE(&entity->rb_tree_node)) {
+=09=09ts =3D drm_sched_rq_get_min_vruntime(rq);
+=09=09ts =3D drm_sched_entity_restore_vruntime(entity, ts,
+=09=09=09=09=09=09       rq->head_prio);
+=09=09drm_sched_rq_update_tree_locked(entity, rq, ts);
+=09}

On stock 7.2-rc7 with this applied, freezes are gone against a trigger that
previously reproduced on demand, and perceptible hitching appears gone too.
The race counter keeps incrementing (35 in the last session against 295744
restores), so the window still opens at the same rate and is now absorbed -=
-
the timing has not merely shifted. Extended soak in progress.
"



On Monday, August 10th, 2026 at 9:40 AM, Luke.Wildhardt@proton.me <Luke.Wil=
dhardt@proton.me> wrote:

> Oops, forgot to reply all in my last message.
>
> I did a quick test of the patch before I left this morning, the freezing =
seems to gone, but when the GPU is under the same condition, the stuttering=
 is more uniform if that makes sense. Granted this was only a 5 minute test=
 but the freeze was rather reliable before, I can do more testing later.
>
> I know these things can be hard to describe, if that helps. If there's an=
y profiling I could do or detailed logging that would help don't hesitate t=
o ask.
>
>
>
> -------- Original Message --------
> On Monday, 08/10/26 at 06:48 Tvrtko Ursulin <tvrtko.ursulin@igalia.com> w=
rote:
>
> On 10/08/2026 13:45, Danilo Krummrich wrote:
> > On Mon Aug 10, 2026 at 10:28 AM CEST, Philipp Stanner wrote:
> >>> Reverted Commits:
> >>>
> >>> d09339388b77 drm/sched: Remove drm_sched_init_args->num_rqs
> >>> 2833a0512b4c drm/sched: Remove drm_sched_init_args->num_rqs usage
> >>> 16e7698bc04d drm/sched: Embed run queue singleton into the scheduler
> >>> 77a6809f1dc3 drm/sched: Remove FIFO and RR and simplify to a single r=
un queue
> >>> 45c211ddf92a drm/sched: Switch default policy to fair
> >>> 2462a0ce23b0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
> >
> > [...]
> >
> >> That might be the wisest thing to do; but let's hear if Tvrtko has an =
idea for
> >> a hotfix first.
> >
> > -rc7 was released yesterday; even with a working hotfix today it'd be t=
ricky to
> > ensure the hotfix does not regress other drivers or workloads with 7.2 =
being
> > just a few days ahead.
> >
> > I suggest to not wait and get the reverts ready.
>
> Yes reverts would be safer. I have them in a branch at
> people.freedesktop.org/~tursulin/drm-intel drm-sched-fair-reverts,
> mostly straightforward apart from one easy conflict in
> amdgpu_xcp_release_sched. Smoke tested on Steam Deck looks fine.
>
> Having said that, the fix for min_vruntime handling I provided earlier
> in the thread also looks fine in my testing and is simple. No
> regressions found with synthetic unit test workloads or messing around
> on the Steam Deck. But we need to wait to hear from Luke since I haven't
> been able to repro his report locally yet.
>
> Regards,
>
> Tvrtko
>
>
