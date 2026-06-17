Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98AFCD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E3610EA38;
	Wed, 17 Jun 2026 14:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gzpokZJT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F7F10EA38
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1781708149;
 bh=B8jGaMu50yEU36HgLLLq39nKxPfO0ebufp/+vz+TlPM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gzpokZJTbMMowhbK2YnQVaU2HEnwVsCMj7WVbSmWz9FKrclvMP8Tgf2csaGfnLuff
 F2VWzVjnYPfYPl7sCl1Z5eFr5S/Dx7KvkQkFl298rRMeBhHHAmxHj64ezyV1L7KHy4
 XDShN9syeabVdznKsL9ZDlNWT6mNQdoE9loa5e5GWUG4t2rvTHL/OrA0LZJ/FK4v87
 tVZM3tMlOI3bOnD9Tm9/qwte61BO+urZicehZYujsK/Zvs0K6sywyFtVi8yNqT2m6q
 7cX14GB23dI5SfAfH2A/6/LIQFFiItfdfBc8TVb4kW4qMRbUX6bw0u14kkkBW2DTIC
 ioKd41KZLU5hw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D889017E091C;
 Wed, 17 Jun 2026 16:55:48 +0200 (CEST)
Date: Wed, 17 Jun 2026 16:55:46 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 6/7] drm/panfrost: Fix PM usage_count mishandling
Message-ID: <20260617165546.4777de33@fedora-2.home>
In-Reply-To: <ajGpN5x-SnC9y6pa@sobremesa>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com>
 <20260604203631.20e76f5f@fedora-2.home>
 <ajGpN5x-SnC9y6pa@sobremesa>
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

On Tue, 16 Jun 2026 21:17:53 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 04.06.2026 20:36, Boris Brezillon wrote:
> > On Thu, 04 Jun 2026 18:35:25 +0100
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> >  =20
> > > During device probe(), failure to do a PM get() will leave the usage_=
count
> > > set to 0, which is the value assigned at device creation time. That m=
eans
> > > when the autosuspend delay expires, runtime suspend callback won't be
> > > invoked, so the device will remain powered on forever.
> > >=20
> > > On top of that, failure to call PM put() during device unplug means
> > > Panfrost device's PM usage_count increases monotonically for every new
> > > module reload.
> > >=20
> > > The combined outcome of both of the above was that devfreq OPP transi=
tion
> > > notifications would be printed all the time, even when no jobs are be=
ing
> > > submitted. This quickly fills the kernel ring buffer with junk.
> > >=20
> > > Even direr than that was the fact MMU interrupts are only enabled when
> > > the device is reset, so after device probe() the very first job targe=
ting
> > > the tiler heap BO would always time out, because the driver's PM runt=
ime
> > > resume callback would not be invoked.
> > >=20
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> > > Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_drv.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/dr=
m/panfrost/panfrost_drv.c
> > > index 2d4b6aa95c66..545fbf2c8d0c 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > @@ -989,6 +989,7 @@ static int panfrost_probe(struct platform_device =
*pdev)
> > >  	pm_runtime_set_active(pfdev->base.dev);
> > >  	pm_runtime_mark_last_busy(pfdev->base.dev);
> > >  	pm_runtime_enable(pfdev->base.dev);
> > > +	pm_runtime_get_noresume(pfdev->base.dev);
> > >  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames=
 */
> > >  	pm_runtime_use_autosuspend(pfdev->base.dev);
> > > =20
> > > @@ -1000,10 +1001,12 @@ static int panfrost_probe(struct platform_dev=
ice *pdev)
> > >  	if (err < 0)
> > >  		goto err_out1;
> > > =20
> > > +	pm_runtime_put_autosuspend(pfdev->base.dev);
> > > =20
> > >  	return 0;
> > > =20
> > >  err_out1:
> > > +	pm_runtime_put_noidle(pfdev->base.dev); =20
> >=20
> > Do we really need this get_noresume/put_noidle dance, can't use call
> > pm_runtime_dont_use_autosuspend() instead like is done in panthor, or
> > is panthor broken too? =20
>=20
> We need get_noresume() because after panfrost_device_init(), the device i=
s powered
> up but that is not reflected in the device's PM refcnt. Then pm_runtime_p=
ut_autosuspend()
> will decrement the refcnt back to 0 and let the autosuspend window expire=
 before
> suspending the device, unless someone starts using it immediately.

That's more or less what I'm questioning. Can't we make it so
panfrost_clk_init() doesn't call clk_prepare_enable() on its clks, and
then have a pm_runtime_resume_and_get() in panfrost_device_init() just
before we start interacting with the HW components (so basically before
panfrost_gpu_init()). Then you don't need this
get_noresume/put_noidle() dance, because the init path is just
considered like any other path that needs to interact with the HW.

>=20
> pm_runtime_dont_use_autosuspend() is not mandatory if we manually call pm=
_runtime_disable()
> at device unplug time or when probe() fails. pm_runtime_use_autosuspend()=
's docs say:
>=20
> pm_runtime_use_autosuspend - Allow autosuspend to be used for a device.
> @dev: Target device.
> Allow the runtime PM autosuspend mechanism to be used for @dev whenever
> requested (or "autosuspend" will be handled as direct runtime-suspend for
> it).
> NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
> at driver exit time unless your driver initially enabled pm_runtime
> with devm_pm_runtime_enable() (which handles it for you).
>=20
> Panthor uses devm_pm_runtime_enable(), which makes me suspect perhaps it =
doesn't need
> to explicitly call pm_runtime_dont_use_autosuspend().

Yep, devm_pm_runtime_enable() takes care of that, indeed.

>=20
> Panthor also manages PM refcnt fine at driver probe(), inside panthor_dev=
ice_init():
>=20
> ``` c
> ret =3D pm_runtime_resume_and_get(ptdev->base.dev);
> if (ret)
> 	return ret;
>=20
> /* If PM is disabled, we need to call panthor_device_resume() manually. */
> if (!IS_ENABLED(CONFIG_PM)) {
> 	ret =3D panthor_device_resume(ptdev->base.dev);
> 	if (ret)
> 		return ret;
> }
> ```
>=20
> If we want a similar thing in Panfrost, then we should move all clock and=
 devfreq enablement
> into panfrost_device_runtime_resume() and do pm_runtime_resume_and_get() =
right before
> panfrost_gpu_init().

This ^. You probably want to keep clk_prepare() in the clk_init() path,
since resume/suspend() only enable/disable the clks.
