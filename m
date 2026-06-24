Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51FACDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC50610E07E;
	Wed, 24 Jun 2026 11:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NZ3EYI40";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5080F10E07E;
 Wed, 24 Jun 2026 11:38:35 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4glg1M49jqz9vGR;
 Wed, 24 Jun 2026 13:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782301111; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HV2lLqgXjOl+Lxo/8p13Wzs0cePcH00ansQo1+4Niw=;
 b=NZ3EYI40wV11NVQY3x+H8q3+RTUhftybHWSHPj8robJhre4p5i3eVvDRHcXB1CVQc8Ogvr
 hYS1kWl4VKPG/Pj/T4XGgP0pr0QukSZH5Dhj0UGDu9Q0IsVjsD9aVyHUSzTYmzHch0IJqG
 Y9RT0HMmVyeaBR9je/9KBGwkE0AjjsiwBaWDyFa1H7KKn88fZNsce5hGGyAvFKNWrJauhH
 qSjFZymChl1TEZYNoDykbSVVcCQ9OdIRoJoKHQS94SVbigK3iiX2ugj5p5yBhZUIMHK+Ii
 hNYTwCPcNvZrV2nxe/0aozEkOWzC3VaqbkPraPGJFe9i+DJDyH2Wr366IXc7nw==
Message-ID: <27d0f7c4d1c8c3beaa0ef1732d2cc4c773826575.camel@mailbox.org>
Subject: Re: [RFC] drm/sched: Replace completion with a flush
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Matthew
 Brost	 <matthew.brost@intel.com>, amd-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org
Date: Wed, 24 Jun 2026 13:38:28 +0200
In-Reply-To: <fd5e55f6-c6be-48b4-8b87-c3d6d6d0a6ff@igalia.com>
References: <20260611123423.39819-1-tvrtko.ursulin@igalia.com>
 <ba8ea856526d54753da68deefe7b77f15c908fa3.camel@mailbox.org>
 <fd5e55f6-c6be-48b4-8b87-c3d6d6d0a6ff@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: 31ueit5ouojyds81y79rjgsi9gsab7ac
X-MBO-RS-ID: 923db6dc4facddbe1ff
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

On Tue, 2026-06-23 at 08:19 +0100, Tvrtko Ursulin wrote:
> On 17/06/2026 09:38, Philipp Stanner wrote:
> >=20
> > > @@ -576,6 +578,13 @@ void drm_sched_entity_select_rq(struct drm_sched=
_entity *entity)
> > > =C2=A0=C2=A0 return;
> > > =C2=A0=20
> > > =C2=A0=C2=A0 spin_lock(&entity->lock);
> > > +
> > > + if (entity->stopped) {
> > > + spin_unlock(&entity->lock);
> > > + return;
> > > +
> > > + }
> >=20
> > Seems unrelated? Why wasn't this needed semantically before?
>=20
> It solidifies the guarantee drm_sched_entity_kill() expects that the=20
> scheduler assigned to an entity cannot change after entity has been stopp=
ed.
>=20
> There we have this sequence:
>=20
> =C2=A0=C2=A0 spin_lock(&entity->lock);
> =C2=A0=C2=A0 entity->stopped =3D true;
> =C2=A0=C2=A0 sched =3D drm_sched_rq_remove_entity(entity->rq, entity);
> =C2=A0=C2=A0 spin_unlock(&entity->lock);
>=20
> =C2=A0=C2=A0 if (sched)
> =C2=A0=C2=A0=C2=A0 drm_sched_flush_run_work(sched);
>=20
> That is, without that check, in theory, an evil driver could race=20
> drm_sched_entity_select_rq() (via drm_sched_job_arm()) and=20
> drm_sched_entity_kill(). I am not sure if any driver can actually do=20
> that at the moment but it felt sensible to express it in code.

So, I was mentally in my Rust code the last weeks; re-evaluating this,
I see what you want to achieve.

I think this is then a valid robustness addition. However:

 * entity->lock's documentation currently does not state that entity-
   >stopped is also protected by that lock. That needs an update.
 * Separate patch is desirable
 * That patch should investigate whether entity->stopped can
   consistently be locked, i.e. drm_sched_entity_is_idle()
 * It might be a good opportunity to document the idempotence status of
   drm_sched_entity_kill() :)


P.
