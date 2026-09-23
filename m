Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E00CC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979C689C49;
	Wed, 23 Sep 2026 08:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="KymJKbon";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B616789C49
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790150933;
 bh=u0YX7kqxcfTE50QrbukboNKBnk+RMSd/uRLrn5FN3A4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KymJKbonlZUL3ntVD7xVqYncrGkLMVxxAujDVyWQ0IdCbaOoSSc6XCmcsTkqEei0B
 3e/q79uEEmuDU6SbwvACpf5exDmY/MAHKr6E9OJhU1+ukerTodmHJzpe/JYwUB98gB
 dZWWgId+0sP6XkZaYu50aaWHAWDZWuGQ3Hzr4aW3VUKIIU6NulUYyLFfTrK/XLIFIO
 JdvDr8Lf8dyV6TjFJ3YZHsMQANUSSm5CU2BAxVxSotFBdVp9HCcK0JLuAa6Rw4P0n/
 3G5DFHuAxJYA4L6rdmW2A9QWHPNVWn9vlT3zPDrv0escsvYdkFNZxooNE8DHmQ6Qk9
 RsnB2zGqlwHJg==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 88ABC17E047B;
 Wed, 23 Sep 2026 10:08:52 +0200 (CEST)
Date: Wed, 23 Sep 2026 10:08:49 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v9 15/16] drm/panfrost: Fix races between perfcnt and
 reset sequence
Message-ID: <20260923100849.573d4d92@fedora-32.home>
In-Reply-To: <arLg_vX52EGl-AMN@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-15-e588feaa61ef@collabora.com>
 <20260914121657.2e9925c9@fedora-21.home>
 <arLg_vX52EGl-AMN@sobremesa>
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

On Wed, 23 Sep 2026 02:39:10 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> > > -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfde=
v)
> > > +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfde=
v, u32 *state)
> > >  {
> > > -	u64 gpuva;
> > > +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> > > +	u64 gpuva =3D perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > >  	int ret;
> > > =20
> > > -	reinit_completion(&pfdev->perfcnt->dump_comp);
> > > -	gpuva =3D pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > > -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > > -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > > -	gpu_write(pfdev, GPU_INT_CLEAR,
> > > -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > > -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > +		perfcnt->dump_finished =3D false;
> > > +		*state =3D 0;
> > > +
> > > +		if (!perfcnt->owns_as_ref) {
> > > +			*state =3D PANFROST_PERFCNT_SESSION_DEAD;
> > > +			return -EIO;
> > > +		}
> > > +
> > > +		if (perfcnt->reset_happened) {
> > > +			*state =3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> > > +			perfcnt->reset_happened =3D false;
> > > +		} =20
> >=20
> > 		*state =3D perfcnt->state; =20
>=20
> I'm thinking maybe we don't need to set the ioctl output state here. Even=
 if there was
> a reset, if we recovered from it and didn't lose the AS reference, we mig=
ht be able to
> go forward as usual. In that case, counters would be measured since the l=
atest reset
> rather than the last successful dump, although maybe this is not an issue.

I think userspace needs to know about INTERRUPTED_BY_RESET, at the very
least. But honestly, I'd keep it simple and propagate the state
regardless of the flags userspace might or might not care about.

> > > +	/*
> > > +	 * Here we release the reset semaphore because perfcnt should not g=
et in the way
> > > +	 * of a HW reset. Besides, a legitimate reset might be issued durin=
g the wait.
> > > +	 */
> > >  	ret =3D wait_for_completion_interruptible_timeout(&pfdev->perfcnt->=
dump_comp,
> > >  							msecs_to_jiffies(1000));
> > > -	if (!ret)
> > > -		ret =3D -ETIMEDOUT;
> > > -	else if (ret > 0)
> > > -		ret =3D 0;
> > > +
> > > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > > +		/* Either sample finished or reset happened */
> > > +		if (ret > 0) {
> > > +			ret =3D perfcnt->dump_finished ? 0 :
> > > +			      perfcnt->owns_as_ref ? -EAGAIN : -EIO;
> > > +
> > > +		} else if (!ret) {
> > > +			ret =3D -ETIMEDOUT;
> > > +		}
> > > +
> > > +		if (perfcnt->reset_happened)
> > > +			*state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> > > +		if (!perfcnt->owns_as_ref)
> > > +			*state |=3D PANFROST_PERFCNT_SESSION_DEAD;
> > > +	} =20
> >=20
> > 	if (!ret)
> > 		return -ETIMEDOUT; =20
>=20
> I was doing this check inside the guard because, in the time between the =
completion
> is signalled and the semaphore locked, another reset could come right thr=
ough.

I wouldn't worry about late signaling to be honest, the timeout is
1sec, which is way more than I would expect a DUMP request to take in
a normal situation. Now, we might want to propagate the state in that
case too, so it might make sense to return ETIMEDOUT inside the
scoped_guard, after the state has been copied.

> And then because I believed counter values were accumulated rather than r=
eset between
> consecutive dumps, it was best to notify the user as soon as possible, ev=
en if that
> meant losing one legitimate frame.
>=20
> > 	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > 		u32 new_state =3D perfcnt->state;
> >=20
> > 		*state |=3D new_state;
> > 		if (new_state & PANFROST_PERFCNT_SESSION_DEAD)
> > 			return -EIO;
> >=20
> > 		perfcnt->state =3D 0; =20
>=20
> I think this should not be here, because we're already resetting the stat=
e before
> running the PERFCNT_SAMPLE GPU command, and also we need to check it righ=
t below.

I think we want to reset in both places, especially if we propagate the
state before the DUMP too, otherwise we might leave the
INTERRUPTED_BY_RESET bit behind even though we already informed
userspace about this event in the previous DUMP request. And yes, the
following test should have been on new_state instead of perfcnt->state,
indeed.

>=20
> > 		/* If we faced a reset during our SAMPLE, the user needs to try again=
. */
> > 		if (perfcnt->state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
> > 			return -EAGAIN;
> > 	} =20
>=20
> The main reason I added the panfrost_perfcnt::dump_finished flag was that=
 when a reset happens,
> the GPU IRQ handler might've been already running in response to a finish=
ed perfcnt sample
> command. However, the reset sequence might come off first and cancel the =
completion, leaving
> us with a ret > 0 despite sampling having succeeded.
>=20
> I'm thinking rather than trying to sort of patch this up precariously as =
I did in this revision,
> I'll leave it the way you suggested and address the race between the GPU =
IRQ handler and the
> reset sequence in a future series.

Yes, that's exactly what needs to be done: reset should synchronize
IRQs, mask/suspend them while the reset sequence is happening, and
unmask them when it's done. As for the completion of a DUMP request
interrupted by a RESET, we want a ret > 0 (AKA no-timeout) in that
case, but the perfcnt::state should be updated prior to that, so that
this function knows exactly what to expect from this completion: if
SESSION_INTERRUPTED_BY_RESET is set, it's likely that the DUMP didn't
complete which is why I return EAGAIN in that case, but we can also have
a dedicated flag for DUMP_COMPLETE if you want to be accurate (when
set, DUMP is effective, when not set EAGAIN).

>=20
> > 	return 0; =20
>=20
> We still need to return -ERESTARTSYS when wait_for_completion_interruptib=
le_timeout()
> is interrupted from UM.

Oh, absolutely.

>
> > > +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> > > +{
> > > +	struct panfrost_perfcnt *perfcnt =3D pfdev->perfcnt;
> > > +
> > > +	if (drm_WARN_ON(&pfdev->base, !perfcnt))
> > > +		return;
> > > +
> > > +	lockdep_assert_held(&pfdev->reset.lock);
> > > +
> > > +	if (!perfcnt->user)
> > > +		return;
> > > +
> > > +	perfcnt->owns_as_ref =3D !panfrost_perfcnt_hw_enable(pfdev);
> > > +	perfcnt->reset_happened =3D true;
> > > +	complete(&perfcnt->dump_comp); =20
> >=20
> > 	/* All active AS are released during the MMU post_reset. */
> > 	perfcnt->owns_as_ref =3D false; =20
>=20
> I'm guessing this should go away as soon as I move it into panfrost_perfc=
nt_hw_enable().

If you reset it at the beginning of panfrost_perfcnt_hw_enable(), sure,
but I think it's easier to assume that when
panfrost_perfcnt_hw_enable() is called, the AS is not owned, and reset
it here instead.

>=20
> > 	perfcnt->state |=3D PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> > 	if (panfrost_perfcnt_hw_enable(pfdev))
> > 		perfcnt->state |=3D PANFROST_PERFCNT_SESSION_DEAD;
> >=20
> > 	/* Unblock pending sample requests. */
> > 	complete(&perfcnt->dump_comp); =20
> > > +}
