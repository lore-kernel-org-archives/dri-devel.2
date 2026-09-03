Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DCBC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815BA10E2A8;
	Thu,  3 Sep 2026 13:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oNt6g5Ta";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9452110E2A8
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:41:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F66D40678;
 Thu,  3 Sep 2026 13:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A868A1F000E9;
 Thu,  3 Sep 2026 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788442879;
 bh=kFvZWT/OUUzeMqSSgVtf6sqt5zDZQ2VdnfM6WeaS3IY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oNt6g5TaldbvnOrcAcM8G3od0vg1//utaZr43m/Yi3w+QwEzaYRDQ5gfC7Ly1CXFS
 qT7GSoRjjLpCCrFAJdgO9zxFuxqPj8RsiGaWduGIUrHfa7mKX5+PjOZmNhKz9LdNXZ
 Sxe7Q9riU7vGXokMAe5s9bmE9T9fs8BcMWLIzxbIfWoTqzaSSfYDVBIbVfD64JcVVX
 sALm1armQY0U8hJWEt3TR/ov4qrpSzWap2XhCxxv2cMaGrdERiPUNZTdKpJD/12ZFB
 vVozSsBaD8MKMhs09QOYfzdO0IWkRk4Fy0ciBJdeJgzBiCE/RTl1HwB8KVFPvC29nZ
 5c9DqQAomyiVw==
Date: Thu, 3 Sep 2026 15:41:15 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, 
 p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, 
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org,
 kishon@kernel.org, Frank.Li@nxp.com, lumag@kernel.org, aisheng.dong@nxp.com, 
 agx@sigxcpu.org, u.kleine-koenig@baylibre.com, marek.vasut@mailbox.org
Subject: Re: [PATCH v9 00/19] Add Freescale i.MX8qxp Display Controller support
Message-ID: <apl4rkHIs9QFuUTE@houat>
References: <20250414035028.1561475-1-victor.liu@nxp.com>
 <20260714193627.GA9616@francesco-nb> <alh4a66fEro05ShA@raspi>
 <20260716062612.GC9973@francesco-nb> <alh-6sI4J7vq2drz@raspi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="o4ooto37lrg6lqir"
Content-Disposition: inline
In-Reply-To: <alh-6sI4J7vq2drz@raspi>
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


--o4ooto37lrg6lqir
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 00/19] Add Freescale i.MX8qxp Display Controller
 support
MIME-Version: 1.0

On Thu, Jul 16, 2026 at 02:49:14PM +0800, Liu Ying wrote:
> On Thu, Jul 16, 2026 at 08:26:12AM +0200, Francesco Dolcini wrote:
> > On Thu, Jul 16, 2026 at 02:21:31PM +0800, Liu Ying wrote:
> > > On Tue, Jul 14, 2026 at 09:36:27PM +0200, Francesco Dolcini wrote:
> > > > On Mon, Apr 14, 2025 at 11:50:09AM +0800, Liu Ying wrote:
> > > > > Hi,
> > > > >=20
> > > > > This patch series aims to add Freescale i.MX8qxp Display Controll=
er support.
> > > > >=20
> > > > > The controller is comprised of three main components that include=
 a blit
> > > > > engine for 2D graphics accelerations, display controller for disp=
lay output
> > > > > processing, as well as a command sequencer.
> > > >=20
> > > > ...
> > > >=20
> > > > >=20
> > > > > To follow up i.MX8qxp TRM, I changed the controller name to "Disp=
lay Controller"
> > > > > instead of the previous "DPU".  "DPU" is only mentioned in the So=
C block
> > > > > diagram and represents the whole display subsystem which includes=
 the display
> > > > > controller and prefech engines, etc.
> > > > >=20
> > > > > With an additional patch[1] for simple-pm-bus.c, this series faci=
litates
> > > > > testing a LVDS panel on i.MX8qxp MEK.
> > > > >=20
> > > > > Please do NOT merge patch 14-19.  They are only used to facilitat=
e testing
> > > > > the LVDS panel.
> > > >=20
> > > > What's the plan to conclude this work? What's the latest status?
> > > > I am looking forward to have a way to use the i.MX8QXP display with
> > > > mainline, but to my understanding some required changes on the SOC =
dtsi
> > > > are not merged.
> > > >=20
> > > > Can you help?
> > >=20
> > > I planned to add display controller DT node after prefetch engine sup=
port [1]
> > > is picked up so that the prefetch engine could be enabled together wi=
th the
> > > display controller.  Just want to avoid a DT that only enables the di=
splay
> > > controller or bypasses the prefetch engine.  It makes the display con=
troller
> > > driver simpler.
> > >=20
> > > [1] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c=
6d4941@nxp.com/
> >=20
> > That series is from October 2025, is there anything blocking to move it
> > forward?
>=20
> It lacks a Reviewed-by tag(at least a Acked-by tag) from a drm-misc commi=
tter
> for every driver patch in that series.  Also, it seems that Marek(Cc'ed) =
is
> not a big fan of [1](See i.MX95 display support discussion[2]).

I was just pointed at this series, and I'm not sure why it's blocked. It
looks like you were waiting for a Reviewed-by by a drm-misc maintainer,
but I gave mine already and I'm a drm-misc maintainer, sooo... :)

Maxime

--o4ooto37lrg6lqir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCapl4+wAKCRAnX84Zoj2+
due1AYCLc2tJQwDF9c4iRI/++4KTTdF3kVz0NHVdo8/5oeYCWXx8fVEF7hVkt4Ra
wo5XQHsBgOtcOEuQUzP9eFI6ZXk4Osh1GNXCdmzBpFn3otlHi4Jyo0MDwTymjy9b
xyO5RX/Wgw==
=aO6C
-----END PGP SIGNATURE-----

--o4ooto37lrg6lqir--
