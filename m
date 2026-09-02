Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6819EC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C41F8876A;
	Wed,  2 Sep 2026 15:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CEhYOO2f";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8255D10E517
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788364248;
 bh=FTXyX+fojJWqGK+Vw1fyMbaNujEYnLgIYsatUW63mts=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CEhYOO2fWJHLsMwh/JijslQU9FftvUH6P00KV9MOVJi9LKLRDE8+4bgNnraXZ8ZUX
 6rEyGct0vV4f0NWSJL+2p5ZQ8SY/MNuewM67nA0qp8yJXwI8ZbMTCdrfNe7md7FUGl
 4DzDFBSftymcpt7RsHoLJltw53YloNe1GYed1ZyYqrzzQZqmKOqm/Sc2vsUYOLJLyd
 P0b8nzz1GYUfMYRirZKLlcDt6PjrLj5RzICrRGO2nmaM/FCK+7lDpyKjypzxn7fsrw
 gz4b1tqoYNNnBK9ndDxJV+HVtWZVHhT51JOvkm1B2CO4SLEhmST609udyQSjwk5Jad
 EuV2vnLEyLYIQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A2FA17E0DD8;
 Wed, 02 Sep 2026 17:50:48 +0200 (CEST)
Date: Wed, 2 Sep 2026 17:50:43 +0200
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
Subject: Re: [PATCH v7 02/17] drm/panfrost: Move all DRM device
 initialisation into device_init()
Message-ID: <20260902175043.58e68317@fedora-21.home>
In-Reply-To: <aphC0QRm5MricnRp@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-2-72a13b2c125d@collabora.com>
 <20260901134951.1e1d7fda@fedora-21.home>
 <aphC0QRm5MricnRp@sobremesa>
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

On Wed, 2 Sep 2026 16:38:25 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> > > +	pm_runtime_disable(pfdev->base.dev); =20
> >=20
> > I think you need a pm_runtime_dont_use_autosuspend() call before
> > pm_runtime_disable().
> >  =20
> > > +	panfrost_gem_fini(pfdev);
> > >  out_perfcnt:
> > >  	panfrost_perfcnt_fini(pfdev);
> > >  out_job:
> > > @@ -304,11 +331,15 @@ int panfrost_device_init(struct panfrost_device=
 *pfdev)
> > >  	panfrost_reset_fini(pfdev);
> > >  out_pm_domain:
> > >  	panfrost_pm_domain_fini(pfdev);
> > > +	pm_runtime_set_suspended(pfdev->base.dev); =20
> >=20
> > Do we have a good reason for not flagging the device suspended just
> > after the pm_runtime_disable() call in the error path? I mean, sure
> > it's not truly suspended until the clks/regulators have been turned
> > off, but it also wasn't suspended the before the initial
> > pm_runtime_set_active() call, and I like the idea of undoing things in
> > reverse init order. =20
>=20
> That was my thought when I put it at the end, although since we manually
> manage device power down here rather than going through the RPM runtime
> suspend callback, I guess it makes no difference.
>=20
> > but it also wasn't suspended the before the initial pm_runtime_set_acti=
ve() call =20
>=20
> I think devices begin their lifetime with power.runtime_status set to RPM=
_SUSPENDED:
> drivers/base/power/runtime.c::pm_runtime_init

Yes, the SW state is RPM_SUSPENDED at probe time, but my point is that
the device is actually active before pm_runtime_set_active() is called,
so the disconnect between the SW state and the HW state already exists
and is accepted. I think, as long as we manipulate the state while RPM
is disabled, and we make sure to restore the resources into their
suspended-state before leaving, it doesn't matter when exactly we call
pm_runtime_set_suspended(). If my understanding is correct, I'd rather
have this call just after the pm_runtime_disable() to respect the
reversed-init-order convention we have in error paths.
