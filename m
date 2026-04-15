Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9FCF43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F63710E708;
	Wed, 15 Apr 2026 15:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="cFy0QtH9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292E110E708
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776266827;
 bh=QvZygflp5gbv3cc6ZILJtpC0burqmrknSs/Tw3pqw7E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cFy0QtH90WS4EuWi69TwTFItQjPlgvVZquZUXAJ6YsTQEwKICxvTqaJL+UnI0CDQ0
 63GaO6Pn8dO8jy4mlofkCnRr7+snR4NkgaYOJFpERtPmiAtcfe++Hql06t+v0HyNzu
 l5XZvN4vzQY9lmr9bARNz7NlfMfS+HluGSzh4uTUt3dV+D5Ip15Ku61bVrm3ConPqR
 f6csNUzhTrTz5/5N0ypqU7ncRZqqL459sD5crmJXw9gtyR1msvpF9I5JNLXMW3I6jc
 1oFDR0invihXpGS5wHb99p1jVkKLzjQ4rMc9cbpyagDEZs7pK3ddOI1+2hy/H+DHR6
 /tXoBUaPBNHMw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B15A17E0F7B;
 Wed, 15 Apr 2026 17:27:07 +0200 (CEST)
Date: Wed, 15 Apr 2026 17:27:02 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v7 6/6] drm/panthor: Bump the driver version to 1.9
Message-ID: <20260415172702.250ef4fb@fedora>
In-Reply-To: <20260415172233.543c6d81@fedora>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-7-adrian.larumbe@collabora.com>
 <20260415172233.543c6d81@fedora>
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

On Wed, 15 Apr 2026 17:22:33 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 15 Apr 2026 12:28:50 +0100
> Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
>=20
> > Bump the driver version to reflect the new MMU info query ioctl
> > parameter and the VM_BIND map sparse flag.
> >=20
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =20
>=20
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

After actually bumping the version number, as pointed out by Jani.

>=20
> > ---
> >  drivers/gpu/drm/panthor/panthor_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/pa=
nthor/panthor_drv.c
> > index a8090bc4e33c..c8fb63ede62c 100644
> > --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > @@ -1787,6 +1787,8 @@ static void panthor_debugfs_init(struct drm_minor=
 *minor)
> >   *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
> >   *       - adds drm_panthor_gpu_info::selected_coherency
> >   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
> > + * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
> > + *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
> >   */
> >  static const struct drm_driver panthor_drm_driver =3D {
> >  	.driver_features =3D DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ | =20
>=20

