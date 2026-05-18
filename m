Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9810CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4997610E76A;
	Mon, 18 May 2026 09:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lcssmPM/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE2110E2FB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779096920;
 bh=oDlIKsmjIzcjVIcTrJ/yYYgluBpXPLUOjcadrFJxADQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lcssmPM/5L8HhycTKzgHC8rkX9MHCs18A4XmTep9/XIOg98BFdjczvXpa4h9RjSkl
 wGYfsvSeNm7CCSbJ5PyPAlC313kWX87ESBpU1Bkuq67ezhxbUYwzJyz9BqMcUuGImB
 tuuWU1hrGElbNoyclhwqNWyQDQyYoSkDpGgo6ssifkzODeSGjh27dOzN9snUsc0hBT
 BwB5+oheoesjdKjjBw3KCSPgSzMbZif8bJNlvgyxeHZLLP7rpwcLwjJw6nvenLeFl1
 Ib1LNhZutAw2M5l/RPGNrzPCLV9Nh7K+u0RjAfZwZVdBZGAsZxRP7JJLMtLqV5ZebS
 6IqC8KtYDHxRA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EB35E17E0443;
 Mon, 18 May 2026 11:35:19 +0200 (CEST)
Date: Mon, 18 May 2026 11:35:15 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org
Cc: Chia-I Wu <olvaffe@gmail.com>, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 3/6] drm: Define a conditional guard for
 drm_dev_{enter,exit}()
Message-ID: <20260518113515.794442f3@fedora>
In-Reply-To: <a872ef35-6d5b-41fd-9242-bb44902fb237@amd.com>
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-3-f2d8c15a97ce@collabora.com>
 <CAPaKu7TULU6_-8eoygq0svBTbnX-vFvF3sH5hDzyi9kDP-9enQ@mail.gmail.com>
 <20260518102813.50555650@fedora>
 <a872ef35-6d5b-41fd-9242-bb44902fb237@amd.com>
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

On Mon, 18 May 2026 11:16:55 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> On 5/18/26 10:28, Boris Brezillon wrote:
> > On Thu, 14 May 2026 11:34:52 -0700
> > Chia-I Wu <olvaffe@gmail.com> wrote:
> >  =20
> >> On Wed, May 13, 2026 at 10:24=E2=80=AFAM Boris Brezillon
> >> <boris.brezillon@collabora.com> wrote: =20
> >>>
> >>> Define a conditional drm_dev_access guard to automate the
> >>> drm_dev_{enter,exit}() sequence.
> >>>
> >>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> >>> ---
> >>>  include/drm/drm_drv.h | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> >>> index 42fc085f986d..79d1958f93e4 100644
> >>> --- a/include/drm/drm_drv.h
> >>> +++ b/include/drm/drm_drv.h
> >>> @@ -490,6 +490,15 @@ void drm_dev_unplug(struct drm_device *dev);
> >>>  int drm_dev_wedged_event(struct drm_device *dev, unsigned long metho=
d,
> >>>                          struct drm_wedge_task_info *info);
> >>>
> >>> +/*
> >>> + * Only the conditional drm_dev_access guard is valid. The drm_dev o=
ne is
> >>> + * here so we can extend it with a conditional variant.
> >>> + */
> >>> +DEFINE_LOCK_GUARD_1(drm_dev, struct drm_device,
> >>> +                   { WARN_ON("Use cond guards"); _T->idx =3D -1; },
> >>> +                   drm_dev_exit(_T->idx), int idx);   =20
> >> If this is ever mis-used, drm_dev_exit(-1) seems to cause OOB access.
> >> Is BUG more appropriate than WARN_ON? =20
> >=20
> > I actually had
> >=20
> > 			if (_T->idx >=3D 0) drm_dev_exit(_T->idx),
> >=20
> > at some point, and I ditched it thinking the WARN_ON_ONCE()
> > in srcu_read_unlock() would cover for that. I can add it back, of
> > course.
> >=20
> > I'd be fine with a BUG_ON() too, but every time I tried to add one I've
> > been encouraged to handle the unexpected case instead.
> >=20
> > Ideally, we would have a DEFINE_LOCK_GUARD_COND() variant that, instead
> > of expanding a non-conditional one, would define the whole thing so
> > that the non-conditional variant is never exposed. =20
>=20
> Would it be possible to use BUILD_BUG() here?

Ah, nice! I was searching for this kind of compile-time assert that
would trigger if the code is used, and BUILD_BUG() indeed does what we
want. Thanks for the tip.
