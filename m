Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49077C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C091110F27A;
	Thu, 13 Aug 2026 09:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="OrLzWmro";
	dkim-atps=neutral
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7D010F05D
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786547557; x=1786806757;
 bh=xNCW83yPuxMoB3OuRzgqvTYPcVSsCWORfbzZHwzCWmQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=OrLzWmrouhD0RmVRzWKZ0upY4xunqfWrY4/Hdb+JRrvAI0zJMuodlzbltGu32wSXm
 pWvb3gzktrP+x9nkoaCNeMpBuHhpQFRrGdHzWGVWPibrNZxGUOVD5RVy0ycTpfcYsZ
 gQVl8EzQzQSw3Nw90FWJAIyccz2LSFGIIyw74QOeIpDE+W/e6E6ZeX06ibvzUmw/DE
 +4KFOfJ7jbuYN5nwvBmNyTyZU4cs9F/qrlh//ENcPG+roZYTGbArUiHw9y6PepZC/C
 J3Si+yXucLn+bNaQ2r6JpDip7j5v2q0MOtzTAApvAiHQqbPc2A73KzhsrgJFT8K2vF
 LvkwNLBR6vnxQ==
Date: Wed, 12 Aug 2026 15:12:32 +0000
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
Message-ID: <Wgbhe0iRVno6QTXUasXAw96sdk1GzzJ8DW_Yw8EyCtxvwV4-EfRTaUdaF9vYeMYsMyfLVVTmXBOB1Br_d-l8b87D_2CMFyYSJi34eaaGGW4=@proton.me>
In-Reply-To: <a9ee4edb-e763-4fd7-a510-32191df0cf8f@igalia.com>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
 <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
 <DKL9VAWD2Y98.RBQPQUL7Y47F@kernel.org>
 <6e2a207e-4db6-4d47-b1f6-9cb13b8d6eeb@igalia.com>
 <enK0t0JrZ3lr9gmgPwE_YaVJDy7K355Bs0xy0YNoVwujLHCGWNRXCjDOhYfiHNGN3pPDSlEUIz3_UkXmFNAJNXxrJOIwvzAG-k8_p_D5FOQ=@proton.me>
 <4OmZej9WiJ6-rsJ_lFcrmwtClAwMdN4oHXWH0p8FkIrhAn4LKS4O3q36wrdZrvjZHBNS8PZsvaIvR-1aFZfF2tDiy1cdMzTYNylcbGDQN68=@proton.me>
 <a9ee4edb-e763-4fd7-a510-32191df0cf8f@igalia.com>
Feedback-ID: 214028577:user:proton
X-Pm-Message-ID: fb4e49e4b3c188d7504d3c23bb821a7845a7cbb5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

I will test this later tonight when I get home and report my findings.

If all is well, I do have a 6900XT I can dig out and cross validate.


Also, I attempted to find a synthetic way to induce the condition; the only=
 slight way I found to do so was running furmark tail, but the desktop neve=
r froze, only the desktop seemed to get mildly choppy. I have not yet check=
ed against the FIFO scheduler.  I was trying to find a more objective way t=
o trigger the issue, but it appears in my case I got rather (un)lucky with =
the specific game I was playing the reproduces it so well.

No problem for helping, I reported the issue and since I am capable of help=
ing at the very least test a fix and reporting on it, I feel I have an obli=
gation to, especially since you haven't been able to reproduce the issue on=
 your end.

-------- Original Message --------
On Wednesday, 08/12/26 at 04:38 Tvrtko Ursulin <tvrtko.ursulin@igalia.com> =
wrote:

On 11/08/2026 18:59, Luke.Wildhardt@proton.me wrote:
> I want to be very clear here, I was working with Claude Opus on debugging=
 this issue. I am not a good programmer and work in on the hardware side of=
 things, so this is only code I've tested and not of my creation, just hopi=
ng to be helpful.

It is really helpful and appreciated! Both that you found the regression
and that you are helping debug and fix it.

> It appears the freezing (and maybe what I'll call micro freezing instead =
of stuttering) was resolved after an issue was potentially identified in dr=
ivers/gpu/drm/scheduler/sched_rq.c
>
> I did a 20m play session attempting to reproduce the issue but was not ab=
le to. Previously, I could reproduce this on-demand.
>
> I will copy the writeup it created and the testing we did below. I am onl=
y claiming that the freezing had been seemingly resolved, not a particular =
fitness or correct identification of the issue, that is for developers to j=
udge.
>
> Quotations are an output of a summery I had Claude create.
>
> "
> THE INVARIANT
>
> drm_sched_entity_stats::vruntime is held absolute while the entity is lin=
ked
> in the run queue tree, and relative to min_vruntime while it is idle.
> save_vruntime() converts one way on the way out, restore_vruntime() the o=
ther
> on the way back in. drm_sched_rq_add_entity() calls restore unconditional=
ly,
> which is only correct if the entity has definitely been through save.
>
>
> THE WINDOW
>
> drm_sched_entity_pop_job():
>
>      spsc_queue_pop(&entity->job_queue);      /* queue now empty */
>
>      drm_sched_rq_pop_entity(entity);         /* takes entity->lock insid=
e */
>
> No lock held across those two lines. A concurrent push seeing the queue e=
mpty
> gets first =3D=3D true, calls add_entity, and restores a vruntime that ha=
s not yet
> been saved -- adding min_vruntime to an already-absolute value. If the en=
tity
> is leftmost, get_min_vruntime() returns its own vruntime and it doubles.
>
> It persists: pop_entity then finds the pushed job, takes the next_job bra=
nch,
> and update_vruntime() carries the inflated value forward. The entity sits=
 far
> right in the tree and is not selected until min_vruntime catches up, whic=
h
> under sustained load may be effectively never.
>
>
> EVIDENCE
>
> WARN_ON_ONCE(!RB_EMPTY_NODE(&entity->rb_tree_node)) at the top of
> add_entity(), after the rq lock, fires reproducibly.
>
> That condition should be unreachable. add_entity() is reached only from t=
he
> "first job" branch of push_job(), and first is true only when the SPSC qu=
eue
> was empty. A linked entity implies its last pop_entity() peeked non-empty=
.
> Empty queue and still linked cannot both hold in any ordered execution. F=
resh
> entities are excluded -- entity_init() calls RB_CLEAR_NODE() unconditiona=
lly.
>
> Instrumented as a counter instead, with ring and comm logged:
>
>    idle 10s:      0 races /  5662 restores
>    gameplay 60s:  8 races / 43315 restores
>
>    [ 192.754604] vruntime race on ring gfx_0.0.0 (comm kwin_wayla:cs0)
>    [ 226.882135] vruntime race on ring gfx_0.0.0 (comm kwin_wayla:cs0)
>    [ 292.226032] vruntime race on ring gfx_0.0.0 (comm kwin_wayla:cs0)
>
> plus Xwayland:cs0 and vkd3d_queue on gfx, and many more on sdma0/sdma1. T=
he
> gfx_0.0.0 / kwin_wayla:cs0 entries are the compositor submission thread o=
n the
> graphics ring -- the process that dies when the desktop freezes.
>
>
> CHANGE
>
> The principled fix is presumably to close the window by holding entity->l=
ock
> across the pop, which needs a _locked variant of drm_sched_rq_pop_entity(=
).
> I did not attempt that. What I tested checks the invariant instead: a sti=
ll-
> linked entity never left, so its vruntime is already absolute and its tre=
e
> position valid.
>
> --- a/drivers/gpu/drm/scheduler/sched_rq.c
> +++ b/drivers/gpu/drm/scheduler/sched_rq.c
> @@ drm_sched_rq_add_entity
> -=09ts =3D drm_sched_rq_get_min_vruntime(rq);
> -=09ts =3D drm_sched_entity_restore_vruntime(entity, ts, rq->head_prio);
> -=09drm_sched_rq_update_tree_locked(entity, rq, ts);
> +=09if (RB_EMPTY_NODE(&entity->rb_tree_node)) {
> +=09=09ts =3D drm_sched_rq_get_min_vruntime(rq);
> +=09=09ts =3D drm_sched_entity_restore_vruntime(entity, ts,
> +=09=09=09=09=09=09       rq->head_prio);
> +=09=09drm_sched_rq_update_tree_locked(entity, rq, ts);
> +=09}
>
> On stock 7.2-rc7 with this applied, freezes are gone against a trigger th=
at
> previously reproduced on demand, and perceptible hitching appears gone to=
o.
> The race counter keeps incrementing (35 in the last session against 29574=
4
> restores), so the window still opens at the same rate and is now absorbed=
 --
> the timing has not merely shifted. Extended soak in progress.
> "

Good find! I almost feel obsolete. Perhaps our new AI overlords should
make a pension fund out of the proceeds obtained by training their
models on the decades of our work so us old programmers can safely retire.

Jokes aside, I agree with the above analysis that a better fix would be
to pull things under the lock, and interestingly, Philipp had a lock
widening patch not so long ago but I don't remember what happened it or
how exactly did it look. It would possibly have fixed this problem.

Anyway, I have prepared a branch with the two fixes if you would be kind
enough to give it a spin:

https://cgit.freedesktop.org/~tursulin/drm-intel/log/?h=3Ddrm-sched-fair-fi=
xes

In my testing it all looks good. Fingers crossed.

Regards,

Tvrtko

> On Monday, August 10th, 2026 at 9:40 AM, Luke.Wildhardt@proton.me <Luke.W=
ildhardt@proton.me> wrote:
>
>> Oops, forgot to reply all in my last message.
>>
>> I did a quick test of the patch before I left this morning, the freezing=
 seems to gone, but when the GPU is under the same condition, the stutterin=
g is more uniform if that makes sense. Granted this was only a 5 minute tes=
t but the freeze was rather reliable before, I can do more testing later.
>>
>> I know these things can be hard to describe, if that helps. If there's a=
ny profiling I could do or detailed logging that would help don't hesitate =
to ask.
>>
>>
>>
>> -------- Original Message --------
>> On Monday, 08/10/26 at 06:48 Tvrtko Ursulin <tvrtko.ursulin@igalia.com> =
wrote:
>>
>> On 10/08/2026 13:45, Danilo Krummrich wrote:
>>> On Mon Aug 10, 2026 at 10:28 AM CEST, Philipp Stanner wrote:
>>>>> Reverted Commits:
>>>>>
>>>>> d09339388b77 drm/sched: Remove drm_sched_init_args->num_rqs
>>>>> 2833a0512b4c drm/sched: Remove drm_sched_init_args->num_rqs usage
>>>>> 16e7698bc04d drm/sched: Embed run queue singleton into the scheduler
>>>>> 77a6809f1dc3 drm/sched: Remove FIFO and RR and simplify to a single r=
un queue
>>>>> 45c211ddf92a drm/sched: Switch default policy to fair
>>>>> 2462a0ce23b0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
>>>
>>> [...]
>>>
>>>> That might be the wisest thing to do; but let's hear if Tvrtko has an =
idea for
>>>> a hotfix first.
>>>
>>> -rc7 was released yesterday; even with a working hotfix today it'd be t=
ricky to
>>> ensure the hotfix does not regress other drivers or workloads with 7.2 =
being
>>> just a few days ahead.
>>>
>>> I suggest to not wait and get the reverts ready.
>>
>> Yes reverts would be safer. I have them in a branch at
>> people.freedesktop.org/~tursulin/drm-intel drm-sched-fair-reverts,
>> mostly straightforward apart from one easy conflict in
>> amdgpu_xcp_release_sched. Smoke tested on Steam Deck looks fine.
>>
>> Having said that, the fix for min_vruntime handling I provided earlier
>> in the thread also looks fine in my testing and is simple. No
>> regressions found with synthetic unit test workloads or messing around
>> on the Steam Deck. But we need to wait to hear from Luke since I haven't
>> been able to repro his report locally yet.
>>
>> Regards,
>>
>> Tvrtko
>>
>>


