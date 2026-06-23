Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2EECDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 14:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4445910EBA0;
	Tue, 23 Jun 2026 14:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="G6z1fzDs";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BB810EB9D;
 Tue, 23 Jun 2026 14:48:16 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gl7Gj5QJyz9tRh;
 Tue, 23 Jun 2026 16:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782226093; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8j5nWKs6mMPZZTh957WrapzoB3bpv7u3GINWsJiiDM=;
 b=G6z1fzDsXK2fDgrCCxPdlvhRstrtzjj0wJGidvlrNAtz+S5DYoo/bHrFq20QjjV1WNBNGS
 hTVyOQiq83uRn+ldcuqdzhAOyoQb7AlMt58xLH3efKwAvP0b5L7Ogr8ptpPItEWZWCniq/
 Iv0KcCTtYpJu+wpvrRICEzF+8J4jyZY9us2avZNa+8J57gDy6pvbBLQz9J/z+PaAnmx1v1
 c7aZ7w24Mrpvpx5Mgjhu+Pcq9czVO6wHsGNT49EJEYT+D16oHn2dMStKrNvCG2a7ou/40m
 fDERGJcTvhX/ZtDOYKKuqaVvj7bXlOXV+w8+i5HEzcx4oUa+f/4VGyNVvAIz+w==
Message-ID: <ddd953feb2a326ce77851405252a8010c3b23235.camel@mailbox.org>
Subject: Re: [RFC] drm/sched: Replace completion with a flush
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, amd-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org
Date: Tue, 23 Jun 2026 16:48:10 +0200
In-Reply-To: <d505d14d-f62b-4f71-9990-c82411381f48@igalia.com>
References: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
 <ba8ea856526d54753da68deefe7b77f15c908fa3.camel@mailbox.org>
 <fd5e55f6-c6be-48b4-8b87-c3d6d6d0a6ff@igalia.com>
 <e9b876bea7a2ef33d5e4ca103721135400c875be.camel@mailbox.org>
 <d505d14d-f62b-4f71-9990-c82411381f48@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: cqahuxwfdidhgi3zrmjxt5hybn1pt5rd
X-MBO-RS-ID: 9b88dd388e103c9be98
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

On Tue, 2026-06-23 at 15:05 +0100, Tvrtko Ursulin wrote:
> > > There we have this sequence:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 spin_lock(&entity->lock);
> > > =C2=A0=C2=A0=C2=A0 entity->stopped =3D true;
> > > =C2=A0=C2=A0=C2=A0 sched =3D drm_sched_rq_remove_entity(entity->rq, e=
ntity);
> > > =C2=A0=C2=A0=C2=A0 spin_unlock(&entity->lock);
> > >=20
> > > =C2=A0=C2=A0=C2=A0 if (sched)
> > > =C2=A0=C2=A0=C2=A0=C2=A0	drm_sched_flush_run_work(sched);
> > >=20
> > > That is, without that check, in theory, an evil driver could race
> > > drm_sched_entity_select_rq() (via drm_sched_job_arm()) and
> > > drm_sched_entity_kill(). I am not sure if any driver can actually do
> > > that at the moment but it felt sensible to express it in code.
> >=20
> > The devil is in the "at the moment".
> >=20
> > AFAICS and as your explanation sounds, this is an existing problem that
> > is unrelated to the Flush RFC. So I suppose that this should be a
> > separate patch (independent from this one) which precisely focusses on
> > this robustness work.
>=20
> Catch is, and why I thought it is justified to do this it in this patch,=
=20
> is because before completion was in the entity so whats happening with=
=20
> entity->rq->sched after entity is stopped was irrelevant. With this=20
> patch is it relevant on paper so I considered it prudent to express that=
=20
> in the code as well as the comment.

I'm not sure if I can fully follow, but it seems that the stopped
boolean + spinlock now protects the scheduler pointer?


IDK, I don't feel comfortable right now.. New docu says

drm_sched_rq_add_entity(struct drm_sched_entity *entity)
  * @entity: scheduler entity
  *
  * Removes a scheduler entity from the run queue.
+ *
+ * Return: DRM scheduler selected to handle this entity or NULL if entity =
has
+ * already been removed.
  */


Isn't a removed entity by definition stopped since drm_sched can't
access it anymore? Or do we have race there, too?

If so, then stopped and entity->rq->sched =3D=3D NULL represent the same
state. IOW, the locked bool must be redundant with something.

Right?

>=20
> Acceptable or unacceptable?

In any case such changes should, wherever possible, be a separate
patch. For the fact alone that the distinct commit message and
especially the position / order of the patch within the series helps
the reviewer greatly in understanding what that particular change
enables and thus why it's necessary.


P.
