Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0963CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 16:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EAF510E80D;
	Mon, 11 May 2026 16:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GMhGbuqy";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E287710E80D;
 Mon, 11 May 2026 16:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778517146;
 bh=cl29oM23banEFV70xoAD/nxliPAhOjBIv1fAGvHj1ck=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GMhGbuqyfvohtNgwiwjSNmb8BwTWD9w7ZHHD9VvSzZeG5Vf/lzHto2LGWC7UfJK01
 JMDAvznwkTTiyKRJ+uSCAiuy0tpnvURlJZpEjbO4Hy03Huf5PLTKdqMrgMICKxPH7/
 w+evAkwx/y0xhTnyKGRAxZtSyou1qU6vq2b9hnuSa0c6SRj/fdQzj/Zu6EcFzmN9gV
 BpObP8vYNTEVs7Gn5oEJAPBpQhj3Szz551Qgf7XyDabJ/crnCNjo1tE15LzumeN8SA
 b5pHVFG44ZlqTj7wFXUNPpy10mNJWbremRFy8czhHTzfEzlO8A4lhlpjk7b243iZFt
 wdpdI89941Xpg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D52C317E0417;
 Mon, 11 May 2026 18:32:25 +0200 (CEST)
Date: Mon, 11 May 2026 18:32:21 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Rob Clark <rob.clark@oss.qualcomm.com>, Steven Price
 <steven.price@arm.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Akash Goel
 <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/gem: Make the GEM LRU lock part of drm_device
Message-ID: <20260511183221.0442cae4@fedora>
In-Reply-To: <agIDYZlOpZB5eZke@e142607>
References: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
 <20260508-panthor-shrinker-fixes-v2-4-39cdb7d577c9@collabora.com>
 <CACSVV00NdUKe6-05U3g0q5X3tw4zmqO_s2gk-KZxQVykpydvAA@mail.gmail.com>
 <20260511174429.35afcdee@fedora>
 <CACSVV02HQ-ci8mHg4os7e-yaf51hdHyQ6cFa9tGOpc9=keL28Q@mail.gmail.com>
 <agIDYZlOpZB5eZke@e142607>
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

On Mon, 11 May 2026 17:27:13 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> On Mon, May 11, 2026 at 09:16:49AM -0700, Rob Clark wrote:
> > On Mon, May 11, 2026 at 8:44=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote: =20
> > >
> > > On Mon, 11 May 2026 06:18:44 -0700
> > > Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> > > =20
> > > > On Fri, May 8, 2026 at 3:41=E2=80=AFAM Boris Brezillon
> > > > <boris.brezillon@collabora.com> wrote: =20
> > > > >
> > > > > Recently, a few races have been discovered in the GEM LRU logic, =
all
> > > > > of them caused by the fact the LRU lock is accessed through
> > > > > gem->lru->lock, and that lock itself also protects changes to
> > > > > gem->lru, leading to situations where gem->lru needs to first be
> > > > > accessed without the lock held, to then get the lru to access the=
 lock
> > > > > through and finally take the lock and do the expected operation.
> > > > >
> > > > > Currently, the two drivers making use of this API declare device-=
wide
> > > > > locks, and there's no clue that we will ever have a driver that w=
ants
> > > > > different pools of LRUs protected by different locks under the sa=
me
> > > > > drm_device. So we're better off moving this lock to drm_device and
> > > > > always locking it through obj->dev->gem_lru_mutex, or directly th=
rough
> > > > > dev->gem_lru_mutex.
> > > > >
> > > > > If anyone ever needs more fine-grained locking, this can be revis=
ited
> > > > > to pass some drm_gem_lru_pool object represent the pool of LRUs u=
nder
> > > > > a specific lock, but for now, the per-device lock seems to be eno=
ugh.
> > > > >
> > > > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com> =20
> > > >
> > > > Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com> =20
> > >
> > > If every one is happy with patch 4, I'm tempted to drop patch 1 and 3,
> > > since they are irrelevant if the locking is fixed the way it is in th=
is
> > > patch. Question is, do we care about patch 2 being backported to stab=
le
> > > kernels then? =20
> >=20
> > Or backport patch 4?  It's a bit bigger, but mostly mechanical.. with
> > only issue being backporting across addition of panthor shrinker, I
> > guess? =20
>=20
> I'm agreeing with Rob here, but it makes a mess of the backport. Maybe sp=
lit
> patch 4 into the drm_gem.c and msm changes and make another one for panth=
or,
> as that is still in linux-next?

We can't really do that if we want to keep things bisectable, but I can
prepare a version against drm-misc-fixes which wouldn't contain any of
the panthor changes, and then ask drm-misc maintainers to backmerge the
next -rc into drm-misc-next and fix things up in panthor as part of the
backmerge.
