Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEF9C79FA3
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5EE1891CC;
	Mon,  7 Sep 2026 15:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NeSlAWVs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06717891CC
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 15:36:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2384660D89;
 Mon,  7 Sep 2026 15:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498E41F00A3A;
 Mon,  7 Sep 2026 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788795411;
 bh=otIPJu+TzkOj3mNvPJg4bU2oZNf1j9J+ix1n6UG32WI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NeSlAWVsyypsF4hIil2ed2Y5sOHsUJrCS5HlU19as33dem4Pdr0UdPoHoFUbwTgKA
 OQdN2pZRQmlRgXnQyDdPlyXEhJk+QYiYKoX9lXeSNFl9OjhP6UCiaWZnbXSkZImlBt
 JmaQAktGIkLi+hKjDotKvTyfNLcsiU10gjkcszuPvXzTksdsm8nXze25H5nGg3xdxV
 VFLamu1kpet4ovM6g9fJhgzVrW7ma8RceLuoqDOtQ949WC8+Kjnkh5N3IJkjK9KYnm
 kYc87Gw+us1qpnW4rpDKRAEbsiGVkcxQmJYP9U28s5Ng+7RcYdLsSVazIJoLH3Nysr
 zM6jGpm6Y5g2A==
Date: Mon, 7 Sep 2026 17:36:47 +0200
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
Message-ID: <ap7Z3xQSavJa0toF@houat>
References: <20250414035028.1561475-1-victor.liu@nxp.com>
 <20260714193627.GA9616@francesco-nb> <alh4a66fEro05ShA@raspi>
 <20260716062612.GC9973@francesco-nb> <alh-6sI4J7vq2drz@raspi>
 <apl4rkHIs9QFuUTE@houat> <app836E0_y8lG9T5@raspi>
 <apqDKdcQrizwAv6U@houat> <apqGD7wxP0ZiLzfF@raspi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="nzpfrxwi4i53nnqx"
Content-Disposition: inline
In-Reply-To: <apqGD7wxP0ZiLzfF@raspi>
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


--nzpfrxwi4i53nnqx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 00/19] Add Freescale i.MX8qxp Display Controller
 support
MIME-Version: 1.0

On Fri, Sep 04, 2026 at 04:49:19PM +0800, Liu Ying wrote:
> On Fri, Sep 04, 2026 at 10:38:08AM +0200, Maxime Ripard wrote:
> > On Fri, Sep 04, 2026 at 04:10:07PM +0800, Liu Ying wrote:
> > > Hi Maxime,
> > >=20
> > > On Thu, Sep 03, 2026 at 03:41:15PM +0200, Maxime Ripard wrote:
> > > > On Thu, Jul 16, 2026 at 02:49:14PM +0800, Liu Ying wrote:
> > > > > On Thu, Jul 16, 2026 at 08:26:12AM +0200, Francesco Dolcini wrote:
> > > > > > On Thu, Jul 16, 2026 at 02:21:31PM +0800, Liu Ying wrote:
> > > > > > > On Tue, Jul 14, 2026 at 09:36:27PM +0200, Francesco Dolcini w=
rote:
> > > > > > > > On Mon, Apr 14, 2025 at 11:50:09AM +0800, Liu Ying wrote:
> > > > > > > > > Hi,
> > > > > > > > >=20
> > > > > > > > > This patch series aims to add Freescale i.MX8qxp Display =
Controller support.
> > > > > > > > >=20
> > > > > > > > > The controller is comprised of three main components that=
 include a blit
> > > > > > > > > engine for 2D graphics accelerations, display controller =
for display output
> > > > > > > > > processing, as well as a command sequencer.
> > > > > > > >=20
> > > > > > > > ...
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > To follow up i.MX8qxp TRM, I changed the controller name =
to "Display Controller"
> > > > > > > > > instead of the previous "DPU".  "DPU" is only mentioned i=
n the SoC block
> > > > > > > > > diagram and represents the whole display subsystem which =
includes the display
> > > > > > > > > controller and prefech engines, etc.
> > > > > > > > >=20
> > > > > > > > > With an additional patch[1] for simple-pm-bus.c, this ser=
ies facilitates
> > > > > > > > > testing a LVDS panel on i.MX8qxp MEK.
> > > > > > > > >=20
> > > > > > > > > Please do NOT merge patch 14-19.  They are only used to f=
acilitate testing
> > > > > > > > > the LVDS panel.
> > > > > > > >=20
> > > > > > > > What's the plan to conclude this work? What's the latest st=
atus?
> > > > > > > > I am looking forward to have a way to use the i.MX8QXP disp=
lay with
> > > > > > > > mainline, but to my understanding some required changes on =
the SOC dtsi
> > > > > > > > are not merged.
> > > > > > > >=20
> > > > > > > > Can you help?
> > > > > > >=20
> > > > > > > I planned to add display controller DT node after prefetch en=
gine support [1]
> > > > > > > is picked up so that the prefetch engine could be enabled tog=
ether with the
> > > > > > > display controller.  Just want to avoid a DT that only enable=
s the display
> > > > > > > controller or bypasses the prefetch engine.  It makes the dis=
play controller
> > > > > > > driver simpler.
> > > > > > >=20
> > > > > > > [1] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-=
0-4ecb6c6d4941@nxp.com/
> > > > > >=20
> > > > > > That series is from October 2025, is there anything blocking to=
 move it
> > > > > > forward?
> > > > >=20
> > > > > It lacks a Reviewed-by tag(at least a Acked-by tag) from a drm-mi=
sc committer
> > > > > for every driver patch in that series.  Also, it seems that Marek=
(Cc'ed) is
> > > > > not a big fan of [1](See i.MX95 display support discussion[2]).
> > > >=20
> > > > I was just pointed at this series, and I'm not sure why it's blocke=
d. It
> > > > looks like you were waiting for a Reviewed-by by a drm-misc maintai=
ner,
> > > > but I gave mine already and I'm a drm-misc maintainer, sooo... :)
> > >=20
> > > Your Reviewed-by tags were on the initial i.MX8qxp Display Controller=
 driver
> > > patches.  And, those patches have already landed.
> > >=20
> > > Now, I'm waiting for Acked-by or Reviewed-by tags on those driver pat=
ches
> > > which add i.MX8qxp Display Controller *prefetch engines* support.
> > > 'b4 trailers -u' doesn't include any Reviewed-by from you on those pa=
tches...
> > > I sent v6 prefetch engine patch series[1] just now.
> > > It would be great to have your Acked-by or Reviewed-by tags on those =
driver
> > > patches :)
> >=20
> > It looks like you had a reviewed-by by someone on all these patches
> > already, so you could have merged them.
>=20
> Oh, okay.  I *thought* one merge criteria is at least one Acked-by from a
> drm-misc committer on each driver patch by reading the guildlines[1].
> But now I've got the idea.  Thanks.
>=20
> [1] https://drm.pages.freedesktop.org/maintainer-tools/committer/committe=
r-drm-misc.html

For a driver, it's totally enough to have a reviewed-by by someone with
experience with the driver too.

Maxime

--nzpfrxwi4i53nnqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCap7aDwAKCRAnX84Zoj2+
doeCAX9T+LgYMTWQNSla28ip6yR0qM88eain+6vQBAG1kI/IdbDa9glAvdQEOOTv
fXTYoEIBf3QACWC1uGpzItuPa9Zyaak4mtnpldIns/xtAj3bAcQXgRWbVExWIL8G
v4gPxoV7fw==
=8ZHA
-----END PGP SIGNATURE-----

--nzpfrxwi4i53nnqx--
