Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E47C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8000910E832;
	Wed, 23 Sep 2026 08:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EZJvuFK3";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A883D10E832
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790150457;
 bh=zXwNfcltf0fh2SEKI0ytJpBVxjyciMisHLld203veVc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EZJvuFK3ahsw8EuGjthmeXmkXrQEb85HQDxot2lyfZDbLoFpl2Gmge0eX/pJwix/B
 /jf/ENDsN67bqmoVnlXj9nPkU6y4jxYJgg2F+wb5D/URzIczlnRM1Q3vsYMPLP2EL9
 1ME2OKxrZDGN1p8S3flz8b9yo1ArQu7sKz46e42LIXYGWwiKNqxeB/+8WqLVfu/NSM
 YDGMD5k7XwuTuDM6ZiRktqYulpAgTovsRgB0+GWGLgkDj8r0HDN6c5nj/wdrZ+QgKC
 Zpw1vxE/LbVBStUf5RJDAeP4xjEeTDizNLWfoKGhZLRFcHsF+NCW2FUmHKalaJ13rX
 JsGJ+Kp5IRvmA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 893D217E0803;
 Wed, 23 Sep 2026 10:00:56 +0200 (CEST)
Date: Wed, 23 Sep 2026 10:00:49 +0200
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
Subject: Re: [PATCH v9 06/16] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
Message-ID: <20260923100049.6c127f3a@fedora-21.home>
In-Reply-To: <arGhZayS8zH4y-61@sobremesa>
References: <20260914112237.70dedb9c@fedora-21.home>
 <arGhZayS8zH4y-61@sobremesa>
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

On Tue, 22 Sep 2026 20:51:48 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 14.09.2026 11:22, Boris Brezillon wrote:
> > On Sat, 12 Sep 2026 00:28:07 +0100
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
> > > The outcome of both of the above meant that:
> > >=20
> > > - Devfreq OPP transition notifications would be printed all the time,
> > >   even when no jobs are being submitted. This quickly fills the kernel
> > >   ring buffer with junk.
> > > - Because MMU interrupts are only enabled when the device is reset,
> > >   the very first job targeting the tiler heap BO after device probe()
> > >   would always time out, since the driver's PM runtime resume callback
> > >   would not be invoked.
> > >=20
> > > To fix the above:
> > > - Manually adjust the PM refcnt at device probe and removal time.
> > > - Ensure pm_runtime_dont_use_autosuspend is called in the wind-down p=
ath.
> > > - Call pm_runtime_put_autosuspend() when device is ready to accept jo=
bs
> > > - Move pm_runtime_set_suspended() before panfrost_device_fini() so th=
at
> > >   resource unwinding happens in the opposite order as initialisation.
> > >=20
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> > > Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/dr=
m/panfrost/panfrost_drv.c
> > > index 55fc22e8d4d4..a3eff77add55 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > @@ -854,6 +854,7 @@ static int panfrost_probe(struct platform_device =
*pdev)
> > > =20
> > >  	pm_runtime_set_active(pfdev->base.dev);
> > >  	pm_runtime_mark_last_busy(pfdev->base.dev);
> > > +	pm_runtime_get_noresume(pfdev->base.dev);
> > >  	pm_runtime_enable(pfdev->base.dev);
> > >  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames=
 */
> > >  	pm_runtime_use_autosuspend(pfdev->base.dev);
> > > @@ -866,13 +867,16 @@ static int panfrost_probe(struct platform_devic=
e *pdev)
> > >  	if (err < 0)
> > >  		goto err_out1;
> > > =20
> > > +	pm_runtime_put_autosuspend(pfdev->base.dev);
> > > =20
> > >  	return 0;
> > > =20
> > >  err_out1:
> > > +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > >  	pm_runtime_disable(pfdev->base.dev);
> > > -	panfrost_device_fini(pfdev);
> > > +	pm_runtime_put_noidle(pfdev->base.dev);
> > >  	pm_runtime_set_suspended(pfdev->base.dev);
> > > +	panfrost_device_fini(pfdev); =20
> >=20
> > Not an issue per-se, because put_noidle() is a NOP, but I think it'd be
> > easier to reason about with this order:
> >=20
> > 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> >   	pm_runtime_disable(pfdev->base.dev);
> > 	panfrost_device_fini(pfdev);
> >   	pm_runtime_set_suspended(pfdev->base.dev);
> > 	pm_runtime_put_noidle(pfdev->base.dev);
> >=20
> > This makes it clear that panfrost_device_fini() assumes the device is
> > resumed when it's called and suspended when it returns. =20
>=20
> Your suggestion feels more natural, which makes me wonder why I decided t=
o move
> panfrost_device_fini() to the end of the block.=20
>=20
> IIRC we chatted about where to place pm_runtime_put_noidle() and pm_runti=
me_set_suspended()
> in panfrost_device_init() when one of the subsystem initialisations faile=
d. My intuition
> had been to leave them until the very bottom of it, in imitation of what =
you hinted here,
> but then it'd go against the notion that winding down must be done in the=
 opposite order
> as initialisation. And so because panfrost_device_init() happens before a=
ll the pm_runtime_*
> incantations, I thought panfrost_device_fini() should be placed at the en=
d in the error
> and driver remove paths.
>=20
> That said, I think a more intuitive init order would be one that imitates=
 what happens in
> Panthor when runtime PM is enabled:
>=20
> 	/* First thing done in pm_runtime_resume_and_get -> pm_runtime_get_activ=
e -> __pm_runtime_resume */
> 	pm_runtime_get_noresume(pfdev->base.dev);

Panthor is a bit different in that it doesn't use noresume/noidle() at
all. What it does instead is teach the resume/suspend hooks about the
uninitialized device use case, and it skips some operations when a
resume/suspend() is done on an uninitialized dev. Panfrost, on the other
hand, just assumes that clks are enabled manually before any of the
subsystem _init() helpers are called. TLDR; this
pm_runtime_get_noresume() can be moved after all the _init() without
any downsides, and it keeps all PM related-init in just one place,
which I find neat.

> =09
> 	/* Now come subsystem initialisations */
> 	panfrost_gpu_init(pfdev);
> 	panfrost_mmu_init(pfdev);
> 	panfrost_jm_init(pfdev);
> 	panfrost_perfcnt_init(pfdev);
> 	panfrost_gem_init(pfdev);
> =09
> 	/* __pm_runtime_resume -> rpm_resume first invokes the resume callback a=
nd then
> 	 * updates runtime status to RPM_ACTIVE. */
> 	pm_runtime_set_active(pfdev->base.dev);
> =09
> 	pm_runtime_enable(ptdev->base.dev);
>         pm_runtime_mark_last_busy(pfdev->base.dev);
> 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> 	pm_runtime_use_autosuspend(pfdev->base.dev);
>=20
> And then in the error and device remove path would be almost just like yo=
u suggest.
>=20
>         pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> 	pm_runtime_disable(pfdev->base.dev);
> 	pm_runtime_put_noidle(pfdev->base.dev);
> 	panfrost_device_fini(pfdev);
> 	pm_runtime_set_suspended(pfdev->base.dev);
>=20
> The only difference is that pm_runtime_put_noidle() happens before device=
_fini
> because that's the same order as in __pm_runtime_suspend().

I really think we should keep the init/fini order consisten, so
put_noidle() should be after the _fini() calls. But as I said above,
I'd probably have get_noresume() called after all the _init() functions
instead, since we can afford it in Panfrost, and it helps keeping all
the PM-related calls in just one block.

>=20
> However, that means in the commit where I move all DRM initialisation into
> panfrost_device_init(), in order to keep things consistent, I should move
> pm_runtime_set_suspended() to the very end of the error path.

It probably doesn't matter much actually, because as soon as
pm_runtime_disable() is called, nothing can change the RPM state
anymore. So maybe scratch all of my comments, and we stick to what you
had. It's just a transition state anyway, so, as long as it doesn't
regress the probe/remove logic, it's probably fine.

>=20
> > >  err_out0:
> > >  	return err;
> > >  }
> > > @@ -884,9 +888,11 @@ static void panfrost_remove(struct platform_devi=
ce *pdev)
> > >  	drm_dev_unregister(&pfdev->base);
> > > =20
> > >  	pm_runtime_get_sync(pfdev->base.dev);
> > > +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > > +	pm_runtime_put_noidle(pfdev->base.dev);
> > >  	pm_runtime_disable(pfdev->base.dev); =20
> >=20
> > Let's keep the order consistent with the probe path:
> >=20
> > 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > 	pm_runtime_disable(pfdev->base.dev);
> > 	panfrost_device_fini(pfdev);
> > 	pm_runtime_set_suspended(pfdev->base.dev);
> > 	pm_runtime_put_noidle(pfdev->base.dev);
> >=20
> > I also think this deserves comments to explain the noresume/noidle
> > dance (device_init/fini take care of clks internally, and when they
> > return the device is resumed/suspended, so all we have to is update the
> > state, and acquire a ref). =20
>=20
> I don't mind doing this, but I think the fact we're calling noresume/noid=
le
> functions already implies device power-up is being handled manually rather
> by having RPM invoke resume and suspend callbacks behind the scenes, so
> we've no choice other than adjusting PM user counter and status ourselves.

Fair enough.
