Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3902F433DE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 08:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0216210E29B;
	Fri, 17 Apr 2026 08:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oIwRTj+C";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71D910E29B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 08:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776413981;
 bh=p8Qg+u7FXG0U0+sR4wmac5rL1X0J1pM2yQmUYCZGfYc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oIwRTj+C05g60wAK4lGlTo4FwzwqBL34l9tikxRCCS5tpctXHj4t81l98lxQUTEyb
 LcqhkMJA7eIozkBfVICmdmwqjBD2Kj2+0ajvuBBJpp0VflT/BVBj5KeQHS1S+ekY2g
 qAXy6ot59t/g5GPtS9EKYgsZUEU857PDpALn+wRBp7qm34qMmczGXyPMG8y33NwQwT
 +ZNypPuJkpD9sTjEkWfaalUYaFirg0H8idsimai9IUp8n9BrvU/aTrHkTli2+3LuyE
 28knU9zOihbSidn7goZk7HY7AnvRbHMchFlR7iEVz/FgfbfEBZuvHn42EsOeEDKuf1
 DSHjozriGX2eg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9AE0117E10A4;
 Fri, 17 Apr 2026 10:19:40 +0200 (CEST)
Date: Fri, 17 Apr 2026 10:19:34 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v7 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260417101934.7320f562@fedora>
In-Reply-To: <aeEpRJhu2b3UWbCs@sobremesa>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-6-adrian.larumbe@collabora.com>
 <20260415171247.3701e116@fedora> <aeEpRJhu2b3UWbCs@sobremesa>
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

On Thu, 16 Apr 2026 19:25:01 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> > > +/**
> > > + * panthor_dummy_bo_create() - Create a Panthor BO meant to back spa=
rse bindings.
> > > + * @ptdev: Device.
> > > + *
> > > + * Return: A valid pointer in case of success, an ERR_PTR() otherwis=
e.
> > > + */
> > > +struct panthor_gem_object *
> > > +panthor_dummy_bo_create(struct panthor_device *ptdev)
> > > +{
> > > +	u32 dummy_flags =3D DRM_PANTHOR_BO_NO_MMAP;
> > > +	struct panthor_gem_object *bo;
> > > +	struct page **pages;
> > > +
> > > +	bo =3D panthor_gem_create(&ptdev->base, SZ_2M, dummy_flags, NULL, 0=
);
> > > +	if (IS_ERR_OR_NULL(bo))
> > > +		return bo;
> > > +
> > > +	pages =3D drm_gem_get_pages(&bo->base); =20
> >
> > Why not use panthor_gem_backing_get_pages_locked() here? Also,
> > drm_gem_get_pages() doesn't give any guarantee that you'll get a huge
> > page, nor can you guarantee that the 2M won't be reclaimed and later
> > on be re-allocated as 4k chunks. I'd probably keep things simple for
> > now, and
> >
> > - keep it a 2M GEM object
> > - force the page allocation at map time, just like we do for regular BO=
s =20
>=20
> On a second thought, if I force page allocation at map time, then there's=
 no need to wait
> until a sparse vm_bind operation to create the dummy BO. I can just do it=
 at VM creation time
> and then let the vm_bind ioctl path allocate the pages.

Yep, you can do that, indeed.

