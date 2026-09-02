Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33162C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD5610F2A9;
	Wed,  2 Sep 2026 16:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ks5gZv40";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77DAE10F2A9
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788365681;
 bh=ecFBkyFZccABJRqAESuQE6U2cXFICI8XbP0tX2LNPKU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ks5gZv40I9HZPmpD+V7dkdK9YwIIFZ/JHu+qSBdFyTopTFRIgJFeaIR4LI88/6zjc
 0n6do6SjtvNwT09jLWJzATcr/JWv3eMhVGHDmVNlp0oobJKARvcYfWgOFS3QKadNpq
 fnEf2axcvHrM01WQ6GHDgDtLoGyJ5l5oVyLxQvF7+RHH2+iLAHYtO9GVLbiTWCcOsC
 YnVMbPGPChEg0j04Q1xMaiOIcc466GyyoqEf1mNj22qBEmoHyzp/J1GYNMf4T6Elii
 r13duPNrXa0cCwUmfe5hLHNuIp4CQBIJotxwV3+u4dFnu4vGBfrI3c3rvkXuwPFHq+
 YTI2GyvIM1iQw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6F0E117E0DD8;
 Wed, 02 Sep 2026 18:14:40 +0200 (CEST)
Date: Wed, 2 Sep 2026 18:14:35 +0200
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
Subject: Re: [PATCH v7 09/17] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
Message-ID: <20260902181435.342c364e@fedora-21.home>
In-Reply-To: <aphDworPxx8fDJ_Z@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-9-72a13b2c125d@collabora.com>
 <20260901151856.433920b6@fedora-21.home>
 <aphDworPxx8fDJ_Z@sobremesa>
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

On Wed, 2 Sep 2026 16:42:12 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 01.09.2026 15:18, Boris Brezillon wrote:
> > On Fri, 28 Aug 2026 21:56:49 +0100
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
> > > To fix the above:
> > > - Manually adjust the PM refcnt at device probe and removal time.
> > > - Ensure pm_runtime_dont_use_autosuspend is called in the wind-down p=
ath.
> > > - Call pm_runtime_put_autosuspend() when device is ready to accept jo=
bs
> > >=20
> > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > > Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> > > Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload") =20
> >=20
> > Because of how things are currently ordered, this won't be backportable
> > without patch 2, which doesn't have a Fixes tag, so, either we put the
> > fix first, and then we move code, or we make it a single commit. =20
>=20
> I think I mentioned it in a previous reply. Maybe it's best to fix the ou=
tstanding issues first
> and then moving code into panfrost_{init|fini}().

I agree it'd be simpler to do that.
