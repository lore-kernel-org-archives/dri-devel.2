Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8EEC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE8C10EF28;
	Wed, 23 Sep 2026 07:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qiYdWCuQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACE710E812
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790147417;
 bh=gzs/ykbYiiQK5T5opupS3eRpbDSPpyLEU1OIwR2+utQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qiYdWCuQ1wudhH1YcdizWhh87WHf1yz9g46Um3EECmndkz1lRpD5nacDwbcyM9ke0
 Jd/ToyFmST80scCtFocslGM4GcmeoytwNBRmu84yTCTf41U6Rc+IgEX2pn0zJRc0Q6
 u93NweNlWTqNCeDr1Ui6qky7lzPl5xcN6NOiFJLHKnOls5vcF+me8CtZ2muh3RhNVZ
 IEtCUeDw5QKdiYFy2IZdV9Zs8wYpzm09sFryaax5YDN3s+S8/TveBONaZHddWD13gr
 pAnN5qwRsRdIfQ8dYLBx6YFKMiXp8wWlJVZG2IVn9yEREWi+3KE/pH+UiSXjUQ2Ccg
 ZG/Tk4FEO5fFw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E44B17E0803;
 Wed, 23 Sep 2026 09:10:17 +0200 (CEST)
Date: Wed, 23 Sep 2026 09:10:10 +0200
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
Subject: Re: [PATCH v9 10/16] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
Message-ID: <20260923091010.58b8e677@fedora-21.home>
In-Reply-To: <arGKAk8ZWGOGDWEY@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-10-e588feaa61ef@collabora.com>
 <20260914113946.69936104@fedora-21.home>
 <arGKAk8ZWGOGDWEY@sobremesa>
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

On Tue, 22 Sep 2026 20:54:11 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 14.09.2026 11:39, Boris Brezillon wrote:
> > On Sat, 12 Sep 2026 00:28:11 +0100
> > Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> >  =20
> > > This will be of great help when testing potential races between the G=
PU
> > > reset sequence and other parts of the code accessing HW registers.
> > >=20
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =20
> >=20
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> >=20
> > One comment below.
> >  =20
> > > ---
> > >  drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++++++++=
++++++++++
> > >  1 file changed, 37 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu=
/drm/panfrost/panfrost_device.c
> > > index d75566a45392..0aee1d87a7ab 100644
> > > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > @@ -2,6 +2,7 @@
> > >  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
> > >  /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
> > > =20
> > > +#include <linux/debugfs.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/reset.h>
> > >  #include <linux/platform_device.h>
> > > @@ -583,9 +584,45 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
> > >  };
> > > =20
> > >  #ifdef CONFIG_DEBUG_FS
> > > +static int reset_get(void *data, u64 *val)
> > > +{
> > > +	struct panfrost_device *pfdev =3D
> > > +		container_of(data, struct panfrost_device, base);
> > > +
> > > +	*val =3D atomic_read(&pfdev->reset.pending);
> > > +	return 0;
> > > +}
> > > +
> > > +static int reset_set(void *data, u64 val)
> > > +{
> > > +	struct panfrost_device *pfdev =3D
> > > +		container_of(data, struct panfrost_device, base);
> > > +	int ret =3D pm_runtime_get_if_active(pfdev->base.dev);
> > > +
> > > +	if (ret) {
> > > +		panfrost_device_schedule_reset(pfdev); =20
> >=20
> > It feels weird to schedule a reset if the device is suspended, because
> > a suspend/resume cycle already acts as a reset. Any particular reason
> > you'd want to do that? If not, I'd suggest going for: =20
>=20
> That's been my goal all along, for the knob to trigger a reset only when
> the device isn't suspended. pm_runtime_get_if_active() docs states that:
>=20
> """
> Increment the runtime PM usage counter of @dev if its runtime PM status is
> %RPM_ACTIVE, in which case it returns 1. If the device is in a different
> state, 0 is returned. -EINVAL is returned if runtime PM is disabled for t=
he
> device, in which case also the usage_count will remain unmodified.
> """
>=20
> So (ret !=3D 0) means the device either doesn't support RPM or else it
> was in the ACTIVE state. In both cases, that means the device is powered
> so we can proceed with the reset. However, I only decrement the usage
> counter when kernel RPM is enabled (ret > 1).

Okay, I see. Can we have a comment explaining that? Also, I think I
prefer an early bail out over the extra indentation level added here.

	if (!ret)
		return 0;

Oh, and we should probably make this knob inactive in the device removal
path (with a disable_work()?), otherwise -EINVAL will be returned as
soon as pm_runtime_disable() is called, and this might cause a reset to
be scheduled, which we probably don't want, since it would interfere
with our device_fini() logic.

>=20
> > 	if (ret <=3D 0)
> > 		return ret;
> >=20
> > 	panfrost_device_schedule_reset(pfdev);
> > 	pm_runtime_put(pfdev->base.dev);
> > 	return 0;
> >  =20
> > > +		flush_work(&pfdev->reset.work);
> > > +		if (ret > 0)
> > > +			pm_runtime_put(pfdev->base.dev);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
> > > +			 reset_get, reset_set,
> > > +			 "0x%08llx\n");
> > > +
> > > +static void panfrost_reset_debugfs_init(struct drm_minor *minor)
> > > +{
> > > +	debugfs_create_file("reset", 0600, minor->debugfs_root,
> > > +			    minor->dev, &panfrost_reset_debugfs_fops);
> > > +}
> > > +
> > >  void panfrost_device_debugfs_init(struct drm_minor *minor)
> > >  {
> > >  	panfrost_gem_debugfs_init(minor);
> > >  	panfrost_sched_debugfs_init(minor);
> > > +	panfrost_reset_debugfs_init(minor);
> > >  }
> > >  #endif // CONFIG_DEBUG_FS
> > >  =20
>=20
> Adrian Larumbe

