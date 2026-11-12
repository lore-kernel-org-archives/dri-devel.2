Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE6606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=eU7tMJiT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6906112159;
	Thu, 12 Nov 2026 14:09:52 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C953D11217B;
 Thu, 12 Nov 2026 14:09:46 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jQMhl5r53zMlL5;
 Thu, 12 Nov 2026 15:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1794492583; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmpbvxhqufdtRVMryu+ho3EOV8ZMnvgHsUDI7nScZBI=;
 b=eU7tMJiT2PsaJpqB0lERUx10JPv7uTONSwlRiDXXMCqKzgPK024hhOao//ZldwYIdOZaDi
 sEeE9BX7HjMAMDQev7rFymFMo2JAz8sWY5rcnaUZvLK8DHT1aNXPAXnFKDbXCPQ0+vyFhQ
 0KY0YZyZ+C71aBRUb7oKPm0DGxPSd/wetulFmqXJaymSWGGVl7kUvS1g85t0H3z9bSM1t8
 afxQY8+TbojtMarx0ami2PiETZeOkVChuN/5Ptc8z3dR7f7sLbsKM9ib9JSKq/mmpafft8
 Upnk9mgrcEvpP6MliVfzGW6agdXxNqlglll3bAXVxc4aKcHCZxV2ifl9LU+Lyg==
Message-ID: <019c8094079a02f582804e735fd73058d5189225.camel@mailbox.org>
Subject: Re: [PATCH 6/7] drm/sched: Replace the SPSC queue with a list and a
 spinlock
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>
Date: Thu, 12 Nov 2026 15:09:41 +0100
In-Reply-To: <f5e91cef-a9af-4839-b7b7-45351d59d881@igalia.com>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-7-tvrtko.ursulin@igalia.com>
 <c3e0decc799da64c09689b85c3db49b0b0a437b4.camel@mailbox.org>
 <f5e91cef-a9af-4839-b7b7-45351d59d881@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: bff49bcf0a05f426723
X-MBO-RS-META: 3bqe4er3tp8p8hiqjgypk8rd9b46fmkz
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-12 at 12:59 +0000, Tvrtko Ursulin wrote:
> Since this is a lock inversion site we cannot lock

Which deadlock-circumvention strategies have you tried?

Pseudocode:

bool drm_sched_can_queue(struct drm_gpu_scheduler *sched,
			 struct drm_sched_entity *entity)
{
	struct drm_sched_job *s_job;

+	lockdep_assert_held(&entity->lock)

	s_job =3D drm_sched_entity_queue_peek(entity);


drm_sched_rq_select_entity(=E2=80=A6)
{
retry:
	spin_lock(&rq->lock);
=09
	walk_tree(=E2=80=A6) {
		if (!spin_trylock(&entity->lock) {
			spin_unlock(&rq-lock);
			udelay(20);
			goto retry;
		}
		ready =3D !list_empty(&entity->job_list);
	}
}


It appears very undesirable for someone to re-walk that tree, I get
that. But do we even know whether that would be a measurable problem in
practice? How often would it occur?


Alternatively, all the other paths that do entity_lock -> rq_lock could
be tested with trylock-patterns. They might be less impacted.

In drm_sched_entity_push_job(), for example, only occasionally are both
locks actually needed, when a job is the first job.

>  but truly have to have an unlocked solution.

How do you know that?


> This is effectively replacing one unlocked read (spsc_queue_peek) with a=
=20
> different one (READ_ONCE(entity->job_credits)). Something unlocked is
> unavoidable here and I think this is more elegant and simple.

Code full of ACCESS_ONCE and RCU that is not RCU is most certainly not
elegant.

This is elegant:

spin_lock()
list_del()
spin_unlock()


With ACCESS_ONCE, manual barriers etc. pp. no one ever knows what's
accessed where with what ordering and why. It would then be better to
have the problem remain centralized in spsc_queue.h

As you say yourself, this here replaces the half-locked hard to reason
about spsc queue (we don't even know whether that thing is formally
correct) with a half-locked "locked" linked list.

It's no improvement in any way regarding our shared goal, which is a=20
consistently locked codebase that finally rids us of the race
conditions which are plagueing this system for >10 years


There is really no other way than either redesigning drm_sched so that
the lock inversion disappears altogether, or to address the inversion
with strategies well established in CS.

>=20
> And because it is an unlocked read it has to be annotated with=20
> READ_ONCE(). Which means the write side, even though it is done under
> the lock, is paired up and marked with WRITE_ONCE().
>=20
> 2. drm_sched_entity_pop_job()
>=20
> This is not a lock inversion site but needs to call sleepable things=20
> while considering the head of the job queue (->prepare_job()).
>=20
> This one is the only remaining reason I used list_add_tail_rcu and=20
> list_del_rcu, just so from here we can safely touch the first entry=20
> while elsewhere more are being added.
>=20
> It is possible to do it, as you suggest, by dropping and re-acquiring
> the lock. Note however that too would need a big fat comment why it is=
=20
> safe.

Sure, one can write code comments. No big deal. The job is not in the
list anymore. The list is lock-protected. No one can race it.

There's only one worker popping. This must always be that way, the
entire drm_sched design is founded on that principle.

>  At which point, since both cases have a big fat comment explaining=20
> the same thing apart from the implementation details, I do not see the=
=20
> advantage of pointless lock cycling. READ_ONCE and WRITE_ONCE you=20
> dislike would still remain.
>=20
> As a side note it would be really good to eliminate the prepare_job=20
> callback

Yes, the user should prepare everything needed before even submitting a
job. Maybe we can begin by marking it as deprecated.




P.
