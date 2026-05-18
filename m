Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5BACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9A410E706;
	Mon, 18 May 2026 08:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oeSn3ga4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE96510E706
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779092897;
 bh=RNTN0WeIA9v1VLUEI3zBpSvdu6mZejOVXTXs7aIWWFg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oeSn3ga4EJtfzucef4b1MZT11bwWm8YBoKn38FWkFMGN0j+jFBIcwxoP3j88YGfi7
 ioVFXfWtFkG2rx/o9zpVDo7T//JaiP4LCywUY17A2HRaeRXsvx5TnLK3sG0YuTXwQU
 0gK4Q+Fp0WJXgrayBmqYDjfg+gM2qt/ACrDncwI+4uwvmwC+4sjqaUzV92j9BjhYxk
 I//EY1TmWEJCw3BfOR2Z0vvnT0AtecSJLdZjFia1v1zsSUOZKvTv5uMRRVcu5m9P9D
 ArMhnGv1kB1UkITKo46JKC8b63MUE9OExqFQAOttSweWKd/e85GKcbtJCVQocu/sI6
 7aEBjd3PXoa6Q==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1609D17E040C;
 Mon, 18 May 2026 10:28:17 +0200 (CEST)
Date: Mon, 18 May 2026 10:28:13 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] drm: Define a conditional guard for
 drm_dev_{enter,exit}()
Message-ID: <20260518102813.50555650@fedora>
In-Reply-To: <CAPaKu7TULU6_-8eoygq0svBTbnX-vFvF3sH5hDzyi9kDP-9enQ@mail.gmail.com>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-3-f2d8c15a97ce@collabora.com>
 <CAPaKu7TULU6_-8eoygq0svBTbnX-vFvF3sH5hDzyi9kDP-9enQ@mail.gmail.com>
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

On Thu, 14 May 2026 11:34:52 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Wed, May 13, 2026 at 10:24=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > Define a conditional drm_dev_access guard to automate the
> > drm_dev_{enter,exit}() sequence.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  include/drm/drm_drv.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > index 42fc085f986d..79d1958f93e4 100644
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -490,6 +490,15 @@ void drm_dev_unplug(struct drm_device *dev);
> >  int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
> >                          struct drm_wedge_task_info *info);
> >
> > +/*
> > + * Only the conditional drm_dev_access guard is valid. The drm_dev one=
 is
> > + * here so we can extend it with a conditional variant.
> > + */
> > +DEFINE_LOCK_GUARD_1(drm_dev, struct drm_device,
> > +                   { WARN_ON("Use cond guards"); _T->idx =3D -1; },
> > +                   drm_dev_exit(_T->idx), int idx); =20
> If this is ever mis-used, drm_dev_exit(-1) seems to cause OOB access.
> Is BUG more appropriate than WARN_ON?

I actually had

			if (_T->idx >=3D 0) drm_dev_exit(_T->idx),

at some point, and I ditched it thinking the WARN_ON_ONCE()
in srcu_read_unlock() would cover for that. I can add it back, of
course.

I'd be fine with a BUG_ON() too, but every time I tried to add one I've
been encouraged to handle the unexpected case instead.

Ideally, we would have a DEFINE_LOCK_GUARD_COND() variant that, instead
of expanding a non-conditional one, would define the whole thing so
that the non-conditional variant is never exposed.

>=20
> > +DEFINE_LOCK_GUARD_1_COND(drm_dev, _access, drm_dev_enter(_T->lock, &_T=
->idx));
> > +
> >  /**
> >   * drm_dev_is_unplugged - is a DRM device unplugged
> >   * @dev: DRM device
> >
> > --
> > 2.54.0
> > =20

