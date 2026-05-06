Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A038FCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 14:34:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1491310EDCA;
	Wed,  6 May 2026 14:34:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IUsp6/vZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 643D910EDC9;
 Wed,  6 May 2026 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778078043;
 bh=hgvN1jV6xsRIZYoJS/nwWzGkDdd5X1ml/V1oqoZcQcs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IUsp6/vZTnL428w38dQ33J4n60kD/ExAAsffIhADT5i8y64f55SvhQtXraAGvm21A
 ntW/h7Sd5brHtRWAR5EC/b6lIsBiQPrLv0AN82sr0IeoW3KoPBrpiScSzopTUchpIN
 +q2j7tZr8KShGYv6Lii9IUW0Uue/VAA+noI7oZklTezHeG6s2/+BLOowpKDQZoyRtZ
 HIkTbEDGszR9FA8hzXAoX4KidtHXHCmxhzly1PMLwTW7CoaJmLh0BHcY5x36uUhcwS
 eYtTqP+tZ5ZRtZG2FAHSU7P+PvjXDDpOkosvB3SoTcEUdB1zjArla4/xa+rNloDyjt
 TaWtC581dNciQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4697917E0610;
 Wed,  6 May 2026 16:34:02 +0200 (CEST)
Date: Wed, 6 May 2026 16:33:56 +0200
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
Message-ID: <20260506163356.3287ce42@fedora>
In-Reply-To: <CACSVV01sJqXCK8Lx5+bSPqzbNv7ALAbcA3P2RiJEOPOX_4Jmxw@mail.gmail.com>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
 <CACSVV01sJqXCK8Lx5+bSPqzbNv7ALAbcA3P2RiJEOPOX_4Jmxw@mail.gmail.com>
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

On Wed, 6 May 2026 06:21:42 -0700
Rob Clark <rob.clark@oss.qualcomm.com> wrote:

> On Wed, May 6, 2026 at 5:16=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > The following race can currently happen:
> >
> > | Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_gem_o=
bject_release` |
> > | -                                            | -                     =
               |
> > | move obj1 with refcount=3D=3D0 to `still_in_lru` |                   =
                   |
> > | move obj2 with refcount!=3D0 to `still_in_lru` |                     =
                 |
> > | mutex_unlock                                 |                       =
               |
> > | shrink obj2                                  |                       =
               |
> > |                                              | lru =3D obj1->lru; // =
`still_in_lru`   |
> > | mutex_lock                                   |                       =
               |
> > | move obj1 back to the original lru           |                       =
               |
> > | mutex_unlock                                 |                       =
               |
> > | return                                       |                       =
               |
> > |                                              | dereference `still_in_=
lru`           |
> >
> > Move the drm_gem_lru_move_tail_locked() after the
> > kref_get_unless_zero() check so that we don't end up with a
> > vanishing LRU when we hit drm_gem_object_release(). We also need to
> > remove the skipped object from its LRU, otherwise we'll keep hitting
> > it on subsequent loop iterations until it's actually removed from the
> > list in the drm_gem_release().
> >
> > Fixes: e7c2af13f811 ("drm/gem: Add LRU/shrinker helper")
> > Reported-by: Chia-I Wu <olvaffe@gmail.com>
> > Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_gem.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index fca42949eb2b..97cf63de0112 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1660,15 +1660,19 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
> >                 if (!obj)
> >                         break;
> >
> > -               drm_gem_lru_move_tail_locked(&still_in_lru, obj);
> > -
> >                 /*
> >                  * If it's in the process of being freed, gem_object->f=
ree()
> > -                * may be blocked on lock waiting to remove it.  So just
> > -                * skip it.
> > +                * may be blocked on lock waiting to remove it.  So jus=
t remove
> > +                * it from its current LRU and skip it.
> >                  */
> > -               if (!kref_get_unless_zero(&obj->refcount))
> > +               if (!kref_get_unless_zero(&obj->refcount)) {
> > +                       if (obj->lru)
> > +                               drm_gem_lru_remove_locked(obj); =20
>=20
> if we are iterating a LRU.. and lru->lock is held, shouldn't obj->lru
> always be non-null?

Right, the !=3D NULL check is not needed here.
