Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C58CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 15:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A355C10F0DC;
	Wed, 20 May 2026 15:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="HoeYbLia";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C63C10F0DC
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779291809;
 bh=MgOPJ3g4k/Sd1Uy5PB5GjtzudKeuPuMOgaOEFszVSoU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HoeYbLiaMxFVE1idvpGrN7Pl5Scv047VDtJDyth+rQH170g8+897HpqgoRONj3hUc
 ec2Q5jzx1oLZdluOD2yzRr6DeU6MEuxVi+RCcFXaEfh4FBiPYmeSOKRN2JtJp10oJ0
 0Vdm3vv70MyVmYLM0oIB1ZMDryeU9QabLz8bUSALuUPE89BXanfOlc6CtI8TifSrfs
 R9lYbqAkEmr4MlAURCJYuq+lV0GJ90zGx+GIoStWI/Rz6VhNrqtdIxVH6ZMG5MUIWi
 FrY0fMTzpQosmcJat7OYMNVNq2ExzrKhJIVyDf2bYhx3XTaa791wATB90+5fyTKyzo
 faSLEFj7+LvDA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 773BE17E124B;
 Wed, 20 May 2026 17:43:28 +0200 (CEST)
Date: Wed, 20 May 2026 17:43:24 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Chia-I Wu <olvaffe@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/panthor: Driver-wide xxx_[un]lock ->
 [scoped_]guard replacement
Message-ID: <20260520174324.1dfafa0c@fedora>
In-Reply-To: <6923c228-b81e-4d02-b59c-a21b2212318e@arm.com>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-1-f2d8c15a97ce@collabora.com>
 <5ab2d07c-74a4-4a2c-b145-6ed7b0060944@arm.com>
 <CAPaKu7S9WMbJERrWa=bj5qyQg72no9MPex6S1MY6t8nXoMbB-Q@mail.gmail.com>
 <20260518104356.71827224@fedora>
 <6923c228-b81e-4d02-b59c-a21b2212318e@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 20 May 2026 16:26:42 +0100
Steven Price <steven.price@arm.com> wrote:

> On 18/05/2026 09:43, Boris Brezillon wrote:
> > On Thu, 14 May 2026 10:09:10 -0700
> > Chia-I Wu <olvaffe@gmail.com> wrote:
> >  =20
> >> On Thu, May 14, 2026 at 6:24=E2=80=AFAM Steven Price <steven.price@arm=
.com> wrote: =20
> >>>
> >>> On 13/05/2026 17:58, Boris Brezillon wrote:   =20
> >>>> Right now panthor is mixed bag of manual locks and guards. Let's
> >>>> make that more consitent and thus encourage new submissions to go
> >>>> for guards.   =20
> >>>
> >>> I'm fine with encouraging guards for future code - but I'm a little w=
ary
> >>> of a big change like this - it's hard to review it and check that
> >>> everything works the same. And it's a little dubious that the mechani=
cal
> >>> refactoring produces more readable code in some cases.   =20
> >> I agree with Steven in general, although I am in favor of landing now
> >> that you've gone through the trouble. =20
> >=20
> > Honestly, I agree with you. The only reason I went for it is
> > because the mix we have right now is pretty confusing. This has to do
> > with the fact the scopes are often loosely defined unless you used
> > scoped_guard(), so it's pretty easy to mess up the lock/unlock
> > ordering. For instance,
> >=20
> > 	mutex_lock(locka);
> > 	guard(lockb);
> > 	mutex_unlock(locka);
> >=20
> > 	...
> >=20
> > once expanded, turns into inconsistent locked sections, where the inner
> > lock (lockb) is released after the outer one (locka). =20
>=20
> I think that's a good argument for getting all the guard forms available
> before tackling the conversion.

Yep, makes sense. The reason I didn't go for that in v1 is because I
wasn't sure how well the new guard definition would be received. Now
that we know there's a general consensus to define those, I'll re-order
the patches accordingly.

> Mostly I feel like it would be benefit
> from being split up into multiple patches (maybe one per file?) so that
> there are smaller units to review.

Sure, I can do that.

>=20
> >>
> >> I also have mixed feelings about some of the non-scoped guards. Their
> >> scopes are extended slightly than before, supposedly to avoid adding
> >> another level of indentation. But other than slightly slower, =20
> >=20
> > I tried to used scoped_guard()s every where the extra non-guarded
> > section could be CPU heavy (the only bits left are some very simple
> > bit/arithmetic ops, and a couple queue_work() IIRC).
> >  =20
> >> it also
> >> becomes less clear what exactly do the guards protect. =20
> >=20
> > I know, and I have pretty much the same feeling, but we've crossed that
> > bridge when we started accepting non-scoped guard()s, unfortunately. =20
>=20
> The problem with scoped guards is the extra level of indentation.

Yep.

> Personally I find a mixture of all three is appropriate depending on the
> case.
>=20
> E.g.
>=20
> int small_simple_function() {
> 	if (simple_condition)
> 		return early;
>=20
> 	guard(lock);
>=20
> 	if (condition_that_needs_lock)
> 		return early;
> 	/* more work */
> 	return late;
> }
>=20
> Here it's easy to reason because the lock is just held for the duration
> of the function after the initial early-out condition is checked.
>=20
> int short_lock() {
> 	/* bunch of work */
>=20
> 	scoped_guard(lock) {
> 		tmp =3D read_value();
> 		if (tmp =3D=3D 42)
> 			return -ESOLONGANDTHANKSFORALLTHEFISH;
> 		tmp++;
> 		write_value(tmp);
> 	}
>=20
> 	/* more work */
> }
>=20
> Here there's a small section of code which is working on the lock, so it
> makes sense to indent it to show the boundaries of it. The other nice
> thing is that the error return handles the locks for us.
>=20
> int old_fashioned() {
> 	if (lock_required)
> 		mutex_lock(lock);
>=20
> 	/* some work */
>=20
> 	if (lock_required)
> 		mutex_unlock(lock);
> }
>=20
> Generally a pattern to be avoided if possible,

Yeah, honestly I try my best to never end up with that sort of
conditional locks.

> but IMHO this is much
> better than the equivalent of:
>=20
> int dodgy_function() {
> 	/* some work */
> }
>=20
> int outer_function() {
> 	if (lock_required) {
> 		scoped_guard(lock)
> 			dodgy_function();
> 	} else {
> 		dodgy_function();
> 	}
> }

If I were to choose, I'd probably go for this version, but luckily we
don't seem to have this conditional-locking pattern in panthor.
