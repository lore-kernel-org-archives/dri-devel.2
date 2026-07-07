Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98246C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25B810EC82;
	Tue,  7 Jul 2026 11:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="krQ6jR68";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50AC10EC6B;
 Tue,  7 Jul 2026 11:53:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 589F16001D;
 Tue,  7 Jul 2026 11:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FE61F000E9;
 Tue,  7 Jul 2026 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783425206;
 bh=LdGStCb5UVcLDPRcPuraOk9pal84IV7d5axrwrI8p8Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=krQ6jR68sHSUwbKKl9wNL5oUT+7BXwUycr43sgVmxv4puH1T5y2oeh4S92AfQsUaV
 ikzoTol6gRvFZm/31shNM2nwiq1cx0u9pCvuQ6yy7HMNP2chqdjpCD/uM/vP10cTEN
 TQTv7N8Wzu8XKkA9VyuPTP3wl+I3GoiLpAO3nYPPmLvGAFH6DRPyaid7mkdE9GLTU4
 /ZZ+FLXrN03gqytti4yDiZcndzMI9O6ZKAcf/o8oWCt36aOB/XHFB9wRz4YSY3FJ7g
 FQgLxVr1qjSzepQQS3U0T+IFwZqW4nHoJzukKGosGAbWtq/p+0m83YZnZ4WaYtBE5r
 hKV3AC0lberQw==
Date: Tue, 7 Jul 2026 13:53:23 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com, 
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v6 03/10] drm: link connectors to backlight devices
Message-ID: <20260707-impartial-fierce-vole-fd0e35@penduick>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-4-mario.limonciello@amd.com>
 <20260626-warping-quizzical-cuttlefish-beb8be@houat>
 <8a4356c5-de49-43a4-a4ee-cf771ed65f18@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="5rkfw3icdmipz47z"
Content-Disposition: inline
In-Reply-To: <8a4356c5-de49-43a4-a4ee-cf771ed65f18@amd.com>
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


--5rkfw3icdmipz47z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 03/10] drm: link connectors to backlight devices
MIME-Version: 1.0

On Fri, Jun 26, 2026 at 04:40:56PM -0500, Mario Limonciello wrote:
> > > + * Drivers have to call drm_backlight_alloc() after allocating a con=
nector via
> > > + * drm_connector_init(). This will automatically add a backlight dev=
ice to the
> > > + * given connector. Drivers must then link a hardware backlight by c=
alling
> > > + * drm_backlight_link() with the registered backlight_device. If no =
link is
> > > + * established, the DRM backlight property reports an empty range and
> > > + * brightness changes are no-ops.
> > > + */
> >=20
> > It's not clear to me why we need to dynamically allocate them at all. If
> > we're using the backlight subsystem we'll already have a handle to it.
> > If we don't and want to implement something like DDC/CI, then it just
> > becomes a hassle. Why not treat it like i2c, add a backlight field to
> > drm_connector, and create the link at registration, add a new hook to
> > set luminance, and then provide helpers to either use the backlight API,
> > or anything else if the driver wants to.
>=20
> I did envision that later on we can have displays with DDC use this
> infrastructure as well.  But I didn't want to hold up the series
> implementing that.

Oh absolutely. My point wasn't that you should support it right away,
but rather that the architecture you work on would be extensible enough
to accomodate for them later on.

I'm exagerating, but for example having an architecture built around
having a backlight device doesn't work, but having one where you have a
set of helpers built around the backlight API does, because then we can
easily create new helpers to deal with DDC/CI, MIPI-DCS, etc. without
reworking the core part.

Maxime

--5rkfw3icdmipz47z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakzosgAKCRAnX84Zoj2+
dongAX9//gIADQVQqqONzAdFXTEzGqC7dQFSe7z+w1uXx9/QxHpU/LZSRoTuTiL4
rsysrjEBgO8JD2jaiBpgfisKPCE3M44O9APxt7O7m5OkUr7kkE1DeikBerCgTEIO
7d3ece0tqA==
=30uc
-----END PGP SIGNATURE-----

--5rkfw3icdmipz47z--
