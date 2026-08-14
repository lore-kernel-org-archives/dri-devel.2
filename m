Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DE9C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFD210F326;
	Fri, 14 Aug 2026 07:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="NBIwpkBA";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F3F10E0DC
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786690153; x=1786949353;
 bh=RJ1WuGWXX4paNTrsGajUBJI8tK/cQp7aKLR/4ae9PtE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=NBIwpkBA/lEg6DH3z8PFwv/iXcuDFjq+9lXR2btpAAgFSOyB/tSFcOi8ysONN1JVu
 lValZmmfaudxTp9YPGPOQ8pPNH+hFasP83K8AImGXnO430a+5rg7c8DufNxA36EVvH
 XZTT8exSbPEWJGFlwo7SdLPrD6tW7n3uRVW57AmSvthUBRRDhZ/OqhBaDCBK8/AyEb
 3LsYKR7WOGPAa2Npk67FLG3cCtwYQbfIe4YCglqJ63PFHXCrhZOnqB4yFpCGYvQ3nK
 EvJM4Qt0iJ7k0UIJjBZWRElzcfsrh1gJy/fGdB9DuuV9M9WUy9mlEMKsqBBK4Je3ao
 Felrm+jdFeVcQ==
Date: Fri, 14 Aug 2026 06:49:07 +0000
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
Message-ID: <x9vF3QJyokHu2X1PgD5S4VNx2FJ_HGJhUnCacAlcLi5ORHjOjBL1hVI2O431wBgdiEnEpY6IDuyHpMxB_eg_AecH1hNT68sl5bX-9kBD7Ag=@proton.me>
In-Reply-To: <3vUDQmfKtaP3e1p0qrjrY9_5SnuA7-cIWQUk2-MElleGKbG4obs96fPT4A_F183UnGt5clbj7belPDQ5CSWLhxTkJ8oXsjN1VS5rCbocPd4=@proton.me>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
 <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
 <4OmZej9WiJ6-rsJ_lFcrmwtClAwMdN4oHXWH0p8FkIrhAn4LKS4O3q36wrdZrvjZHBNS8PZsvaIvR-1aFZfF2tDiy1cdMzTYNylcbGDQN68=@proton.me>
 <a9ee4edb-e763-4fd7-a510-32191df0cf8f@igalia.com>
 <Wgbhe0iRVno6QTXUasXAw96sdk1GzzJ8DW_Yw8EyCtxvwV4-EfRTaUdaF9vYeMYsMyfLVVTmXBOB1Br_d-l8b87D_2CMFyYSJi34eaaGGW4=@proton.me>
 <ylme_dYqb7yeNvmFl3ZeH3v8d_46-oAWr6t95wEZTYGiLMdbNTzXBFoV1zueOeHcKXcFrMMsoF0s_57Hzj0wwEfxDRjPhmu-xquKmeXKehg=@proton.me>
 <61a96635-e143-4d69-b0f7-0f312f5a3a3c@igalia.com>
 <3vUDQmfKtaP3e1p0qrjrY9_5SnuA7-cIWQUk2-MElleGKbG4obs96fPT4A_F183UnGt5clbj7belPDQ5CSWLhxTkJ8oXsjN1VS5rCbocPd4=@proton.me>
Feedback-ID: 214028577:user:proton
X-Pm-Message-ID: b6a708f853e281545c083b0ab34f664ccda63e37
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

Did a 90 min play session across the problematic titles, and also let the g=
ame run in the background while I did other things on the desktop (Youtube,=
 web browsing, Blender). No issues, seems to work as good as FIFO did on pr=
evious kernels. To reiterate, the issue at least for me was extremely easy =
to reproduce so I would be confident in calling this fixed (from my perspec=
tive).=20

I want to say thanks to everyone for the assistance and responsiveness. I k=
now these things can be stressful at the tail end of a RC.

If you need other testing done or feedback on specific activities, other it=
erations, feel free to reach out, I don't mind.



Sent with Proton Mail secure email.

On Thursday, August 13th, 2026 at 7:27 AM, Luke.Wildhardt@proton.me <Luke.W=
ildhardt@proton.me> wrote:

> Looks good, in the 10 minutes I spent this morning doing a quick test, I =
wasn't able to reproduce the failure. I will do extended testing tonight.
>=20
> I will report back later with more details, but given the issue was typic=
ally reproducible on-demand, this is looking very promising.
>=20
> Thanks for all the hard work everyone!
>=20
> On Thursday, August 13th, 2026 at 12:58 AM, Tvrtko Ursulin <tvrtko.ursuli=
n@igalia.com> wrote:
>=20
> >
> > On 13/08/2026 07:42, Luke.Wildhardt@proton.me wrote:
> > > Ok, after a lot of A/B testing, it appears that trying your "drm-inte=
l/drm-sched-fair-fixed" branch, the stuttering is still there. It's definit=
ely paced differently though, I will attach a video. It's "choppier" when i=
t happens. I tested in a few different areas / times of day, in case you no=
tice the scenery isn't the same; this is representative of what I experienc=
ed in other places. I will note, that I tried playing 4 times, 3/4 times, s=
hortly after boot. 1/4 times I left my desktop to idle for about 30 minutes=
 while I did something else, and I didn't encounter the issue at all in 10 =
minutes. Not sure how significant that is, or if it's just noise.
> > >
> > > https://www.youtube.com/watch?v=3DGWyIVEuhooM
> > >
> > > To make sure I wasn't insane, I went back to the patch Claude gave me=
, applied against a clean 7.2.0-rc7. At least again in a few sessions after=
 boot, no issue. I'll post that exact code below.
> >
> > Yes, I had a brain fart yesterday and had only pulled the lock out on
> > the pop side. I have now pushed the updated branch, with both the add
> > and pop side made symmetric in lock taking aspect.
> >
> > If you could pull and re-test once more that would be great.
> >
> > Regards,
> >
> > Tvrtko
> >
> > > If you need any other info from me let me know.
> > >
> > >
> > > --- a/drivers/gpu/drm/scheduler/sched_rq.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_rq.c
> > > @@ -2,6 +2,7 @@
> > >   /* Copyright 2015 Advanced Micro Devices, Inc. */
> > >   /* Copyright (c) 2025 Valve Corporation */
> > >
> > > +#include <linux/moduleparam.h>
> > >   #include <linux/rbtree.h>
> > >
> > >   #include <drm/drm_print.h>
> > > @@ -9,6 +10,32 @@
> > >
> > >   #include "sched_internal.h"
> > >
> > > +/*
> > > + * Diagnostic counters. Not for submission.
> > > + *
> > > + * dbg_pop_stayed  - pops where the entity had another job queued an=
d so stayed
> > > + *                   in the tree. No save/restore of vruntime occurs=
.
> > > + * dbg_pop_left    - pops where the entity queue drained, so it left=
 the tree
> > > + *                   and drm_sched_entity_save_vruntime() ran. Only =
this path
> > > + *                   arms a later restore.
> > > + * dbg_add_restore - calls to drm_sched_rq_add_entity(), i.e. restor=
es.
> > > + * dbg_add_race    - restores where the entity was still linked in t=
he tree,
> > > + *                   meaning the vruntime being restored is still ab=
solute.
> > > + *
> > > + * Incremented under rq->lock, so exact per scheduler and only mildl=
y lossy
> > > + * when summed across rings. Writable so they can be reset between r=
uns:
> > > + *   echo 0 > /sys/module/gpu_sched/parameters/dbg_pop_left
> > > + */
> > > +static unsigned long dbg_pop_stayed;
> > > +static unsigned long dbg_pop_left;
> > > +static unsigned long dbg_add_restore;
> > > +static unsigned long dbg_add_race;
> > > +
> > > +module_param(dbg_pop_stayed, ulong, 0644);
> > > +module_param(dbg_pop_left, ulong, 0644);
> > > +module_param(dbg_add_restore, ulong, 0644);
> > > +module_param(dbg_add_race, ulong, 0644);
> > > +
> > >   static __always_inline bool
> > >   drm_sched_entity_compare_before(struct rb_node *a, const struct rb_=
node *b)
> > >   {
> > > @@ -266,14 +293,40 @@
> > >   =09sched =3D container_of(rq, typeof(*sched), rq);
> > >   =09spin_lock(&rq->lock);
> > >
> > > +=09dbg_add_restore++;
> > > +=09if (!RB_EMPTY_NODE(&entity->rb_tree_node)) {
> > > +=09=09dbg_add_race++;
> > > +=09=09pr_warn_ratelimited("drm_sched: vruntime race on ring %s (comm=
 %s)\n",
> > > +=09=09=09=09    sched->name, current->comm);
> > > +=09}
> > > +
> > >   =09if (list_empty(&entity->list)) {
> > >   =09=09atomic_inc(sched->score);
> > >   =09=09list_add_tail(&entity->list, &rq->entities);
> > >   =09}
> > >
> > > -=09ts =3D drm_sched_rq_get_min_vruntime(rq);
> > > -=09ts =3D drm_sched_entity_restore_vruntime(entity, ts, rq->head_pri=
o);
> > > -=09drm_sched_rq_update_tree_locked(entity, rq, ts);
> > > +=09/*
> > > +=09 * Only restore the vruntime if the entity actually left the run =
queue.
> > > +=09 *
> > > +=09 * drm_sched_entity_pop_job() dequeues the last job and only afte=
rwards
> > > +=09 * calls drm_sched_rq_pop_entity(), which is where the entity is =
removed
> > > +=09 * from the tree and drm_sched_entity_save_vruntime() converts it=
s
> > > +=09 * vruntime to min_vruntime-relative form. A push landing in that=
 window
> > > +=09 * sees an empty queue, takes the "first job" path to here, and w=
ould
> > > +=09 * restore a vruntime which is still absolute -- adding min_vrunt=
ime to
> > > +=09 * it a second time. If the entity is also the leftmost one,
> > > +=09 * drm_sched_rq_get_min_vruntime() returns the entity's own vrunt=
ime and
> > > +=09 * the value is doubled, placing it far to the right of the tree =
where it
> > > +=09 * will not be selected again until the run queue catches up.
> > > +=09 *
> > > +=09 * A still-linked entity never left, so its vruntime is already a=
bsolute
> > > +=09 * and its tree position is valid. The concurrent pop will update=
 both.
> > > +=09 */
> > > +=09if (RB_EMPTY_NODE(&entity->rb_tree_node)) {
> > > +=09=09ts =3D drm_sched_rq_get_min_vruntime(rq);
> > > +=09=09ts =3D drm_sched_entity_restore_vruntime(entity, ts, rq->head_=
prio);
> > > +=09=09drm_sched_rq_update_tree_locked(entity, rq, ts);
> > > +=09}
> > >
> > >   =09spin_unlock(&rq->lock);
> > >   =09spin_unlock(&entity->lock);
> > > @@ -330,11 +383,13 @@
> > >   =09if (next_job) {
> > >   =09=09ktime_t ts;
> > >
> > > +=09=09dbg_pop_stayed++;
> > >   =09=09ts =3D drm_sched_entity_update_vruntime(entity);
> > >   =09=09drm_sched_rq_update_tree_locked(entity, rq, ts);
> > >   =09} else {
> > >   =09=09ktime_t min_vruntime;
> > >
> > > +=09=09dbg_pop_left++;
> > >   =09=09drm_sched_rq_remove_tree_locked(entity, rq);
> > >   =09=09min_vruntime =3D drm_sched_rq_get_min_vruntime(rq);
> > >   =09=09drm_sched_entity_save_vruntime(entity, min_vruntime);
> > >
> > >
> > >
> >
> >
