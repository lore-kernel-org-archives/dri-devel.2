Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DF2CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 08:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E57610F2C4;
	Fri,  8 May 2026 08:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Jlxx5/sW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0212D10F2C4;
 Fri,  8 May 2026 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778229671;
 bh=unS38kn2nv0Yp6RKSpwQQ0vaEE/LDNJiqYgOWGcwZzM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Jlxx5/sWBA8oF05dB6TTJTcZWJBPoAhR2XlvLw9NuNtn3gWpgOz+CBsalDlBGZ06F
 ix+z9s6DwQloOd49/Jtj3QR9KJXqiS0SWtWUUz/+kJWe0J2Dd3lnGyr2ZSyYwKEakL
 H/eskDob0INuU4+6/X5LDzxKQPdiOtdG/wNfiguCK/Ws/Rc0yWVmg7VRGpxUvob+n7
 c5HWbBcsEKXeg7aL+Lfk69irz8Ti6cwYvmTo2S4QsYBL2na7ZGAJjuS1B7V0vhOP1C
 n1F387xy9izDXYYGbo3uO+PEVrIi7UnUSEm6SCT3Jx4+FZKAnByIWwqtfGsbmNSbuU
 ZX/sJliX4uuzQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E6A5B17E0E08;
 Fri,  8 May 2026 10:41:10 +0200 (CEST)
Date: Fri, 8 May 2026 10:41:07 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>, Chia-I Wu
 <olvaffe@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, Sean
 Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/gem: Fix a race between drm_gem_lru_scan() and
 drm_gem_object_release()
Message-ID: <20260508104107.055223e5@fedora>
In-Reply-To: <CACSVV01zGLN8FV3Fpw1BnW+zSokE7n2XJ2dBmDw8-n=MXBmDnw@mail.gmail.com>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
 <20260507144639.68bd699f@fedora>
 <CACSVV01zGLN8FV3Fpw1BnW+zSokE7n2XJ2dBmDw8-n=MXBmDnw@mail.gmail.com>
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

On Thu, 7 May 2026 14:38:23 -0700
Rob Clark <rob.clark@oss.qualcomm.com> wrote:

> On Thu, May 7, 2026 at 5:46=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > On Wed, 06 May 2026 14:16:27 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > =20
> > > The following race can currently happen:
> > >
> > > | Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_gem=
_object_release` |
> > > | -                                            | -                   =
                 |
> > > | move obj1 with refcount=3D=3D0 to `still_in_lru` |                 =
                     |
> > > | move obj2 with refcount!=3D0 to `still_in_lru` |                   =
                   |
> > > | mutex_unlock                                 |                     =
                 |
> > > | shrink obj2                                  |                     =
                 |
> > > |                                              | lru =3D obj1->lru; /=
/ `still_in_lru`   |
> > > | mutex_lock                                   |                     =
                 |
> > > | move obj1 back to the original lru           |                     =
                 |
> > > | mutex_unlock                                 |                     =
                 |
> > > | return                                       |                     =
                 |
> > > |                                              | dereference `still_i=
n_lru`           |
> > >
> > > Move the drm_gem_lru_move_tail_locked() after the
> > > kref_get_unless_zero() check so that we don't end up with a
> > > vanishing LRU when we hit drm_gem_object_release(). We also need to
> > > remove the skipped object from its LRU, otherwise we'll keep hitting
> > > it on subsequent loop iterations until it's actually removed from the
> > > list in the drm_gem_release().
> > >
> > > Fixes: e7c2af13f811 ("drm/gem: Add LRU/shrinker helper")
> > > Reported-by: Chia-I Wu <olvaffe@gmail.com>
> > > Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > > ---
> > >  drivers/gpu/drm/drm_gem.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > > index fca42949eb2b..97cf63de0112 100644
> > > --- a/drivers/gpu/drm/drm_gem.c
> > > +++ b/drivers/gpu/drm/drm_gem.c
> > > @@ -1660,15 +1660,19 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
> > >               if (!obj)
> > >                       break;
> > >
> > > -             drm_gem_lru_move_tail_locked(&still_in_lru, obj);
> > > -
> > >               /*
> > >                * If it's in the process of being freed, gem_object->f=
ree()
> > > -              * may be blocked on lock waiting to remove it.  So just
> > > -              * skip it.
> > > +              * may be blocked on lock waiting to remove it.  So jus=
t remove
> > > +              * it from its current LRU and skip it.
> > >                */
> > > -             if (!kref_get_unless_zero(&obj->refcount))
> > > +             if (!kref_get_unless_zero(&obj->refcount)) {
> > > +                     if (obj->lru)
> > > +                             drm_gem_lru_remove_locked(obj);
> > > + =20
> >
> > Actually, this thing is still racy, because obj->lru is dereferenced
> > without the lru->lock held in drm_gem_object_release(). At this point
> > I'm wondering if we should expose a drm_gem_lru_remove() taking the LRU
> > lock as an argument as suggested by Steve, and delegate the
> > responsibility to call drm_gem_lru_remove() to the driver. Either that,
> > or we make it so the LRU lock is attached to the drm_device instead of
> > the GEM (both MSM and panthor assume a device-wide lock for LRU
> > manipulation).
> >
> > Rob, what's your take on this matter? =20
>=20
> I don't think there is a race, because of the kref_get_unless_zero().
> Other than lru_scan, there shouldn't be cases where someone is moving
> an obj between LRUs racing with drm_gem_object_release(), because that
> means they don't own a reference on the obj they are manipulating.

Yeah, but the race I'm talking about is drm_gem_object_release()
vs drm_gem_lru_scan(), so at this point refcount is zero, and this
patch only moves the needle, but doesn't fix the problem entirely:


| Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_gem_objec=
t_release` |
| -                                            | -                         =
           |
|                                              | drm_gem_lru_remove()      =
           |
|                                              |    lru =3D obj->lru       =
             |
|                                              |    if (!lru) return;      =
           |
| lock(still_in_lru.lock)                      |                           =
           |
|    if (refcount =3D=3D 0)                        |                       =
               |
|       drm_gem_lru_remove_locked(obj)         |                           =
           |
|         obj->lru =3D NULL                      |                         =
             |
|    .....                                     |                           =
           |
| unlock(still_in_lru.lock)                    |                           =
           |
|                                              |    lock(lru->lock)        =
           |
|                                              |       drm_gem_lru_remove_l=
ocked(obj) |
|                                              |         obj->lru=3D=3DNULL=
 =3D> NULL deref |
|                                              |    unlock(lru->lock)      =
           |

We can of course add an extra

	if (!obj->lru) return;

in drm_gem_lru_remove_locked() to cover for this race, and add a
READ_ONCE in drm_gem_lru_remove() to make sure the compiler doesn't
do crazy things like dereferencing obj->lru twice instead of having
the LRU pointer stored in a register. That still assumes that the lru
we assigned to our local variable is valid even after the
drm_gem_lru_remove_locked(obj) call, which is true at least for MSM and
and panthor because they have their LRUs attached to the drm_device,
which outlives any GEMs attached to it. But it's not something the API
enforce or document as a requirement.

>=20
> That said, I can't really think of a sensible thing to do with more
> than a single LRU lock per device.  And it does make things easier to
> reason about.

Okay, I'll give it a try then.
