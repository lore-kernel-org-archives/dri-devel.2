Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9970FC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:58:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0494810E03F;
	Wed, 23 Sep 2026 06:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lWm0hN26";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1AF10E03F
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 06:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790146722;
 bh=a2NtTBakK0HpDmrLfulXCfgzfoYb8F4272oQHZWZOTk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lWm0hN26BVbgIR9ugmfpiVMphZWepL08U7Cv7rXQxXIJ0IgUZLSFpG/ksx0Lke1vy
 Og0B/ChtC26wQMcjE236nuoK3GaOAP9FfIK3S8EwIAXZ1hQ+iA4uWKqMv/uQL/xETG
 uddLg7WxuNWUUcW83rpmGef3t44moyV94CnUd/b0XgAKwxJGwa52vO6J1hBl+DRlPd
 d+PPOOTGwenZLbRqQ0BJTbh6h/A1FuHv8hFbtgtVL6cQsP10zqwNRyr/QifLGZT6WL
 HQHJA28TmBD65VXY90SUBOt/EC0rkXDwQXkxb3h4LuduDGxCf0dcoF4jhxYpdT+fEN
 S4cFhELwJLUpg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 882D017E0371;
 Wed, 23 Sep 2026 08:58:41 +0200 (CEST)
Date: Wed, 23 Sep 2026 08:58:37 +0200
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
Subject: Re: [PATCH v9 01/16] drm/panfrost: Move shrinker initialization and
 unplug one level down
Message-ID: <20260923085837.5e92198c@fedora-21.home>
In-Reply-To: <arFQG1AYMXlRgmJS@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-1-e588feaa61ef@collabora.com>
 <20260914103646.6f1b7246@fedora-21.home>
 <arFQG1AYMXlRgmJS@sobremesa>
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

On Tue, 22 Sep 2026 20:48:49 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 14.09.2026 10:36, Boris Brezillon wrote:
> > On Sat, 12 Sep 2026 00:28:02 +0100
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> >  =20
> > > Since the moment we call drm_dev_register() the device should be in a
> > > position to accept jobs, so it's best if the shrinker is already
> > > initialized by then.
> > >=20
> > > On top of that, make shrinker functions take an panfrost_device point=
er
> > > like other functions in the same sequence and rename them accordingly.
> > >=20
> > > Essentially mimic the init/fini behaviour in Panthor.
> > >=20
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =20
> >=20
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> >=20
> > One remark below.
> >  =20
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_device.c       |  8 +++++++-
> > >  drivers/gpu/drm/panfrost/panfrost_drv.c          |  6 ------
> > >  drivers/gpu/drm/panfrost/panfrost_gem.c          | 26 ++++++++++++++=
----------
> > >  drivers/gpu/drm/panfrost/panfrost_gem.h          |  7 ++++---
> > >  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c |  8 ++------
> > >  5 files changed, 28 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu=
/drm/panfrost/panfrost_device.c
> > > index 485349faf251..05c40d5a20b5 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > @@ -280,9 +280,14 @@ int panfrost_device_init(struct panfrost_device =
*pfdev)
> > >  	if (err)
> > >  		goto out_job;
> > > =20
> > > -	panfrost_gem_init(pfdev);
> > > +	err =3D panfrost_gem_init(pfdev); =20
> >=20
> > It feels weird to have the GEM subsystem initialized last when you
> > consider the fact other subsystems might want to allocate GEMs in their
> > _init() function. I know it's where the panfrost_gem_init() is right
> > now, and that ultimately it doesn't prevent anyone from allocating
> > GEMs, but I think it would make sense have this called before any of
> > the other subsystem init functions, still. =20
>=20
> I think we discussed having panfrost_gem_init() be called before the other
> subsystem init functions, but then I checked panthor and saw it's also be=
ing
> called right after all the others there too. I think you're right that it=
's
> best to initialise gem first, because I wonder whether other subsystem in=
it
> functions creating GEMs when the mount point for huge page-backed objects
> hasn't been created yet could lead to some sort of trouble.
>=20
> However, given how much this patch series has already grown, I believe it=
'd
> be best to leave this change for a later one.

Sounds good to me.
