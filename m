Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C8BC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609B410E57D;
	Tue, 28 Jul 2026 10:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="GGua9EmJ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2999910E57D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785235472; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TS0P/0Nn92hCK1UO819Km2MemRUN+2D33lo2frqf//bJxFnoJIr7T65oIx0zivNwVD1r5lraVuz1EoSw34DwqAG5d1qClgsDfKhat0jYsUEqdTMMGe1OwmGOyCInP+3Jz2LUDnuH/d/4/8EEiLKnhm3bU2ZYqCgdqjYgTnEpPHE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785235472;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=J5NLQiylXqrWyBPL2yr2b7NQ7oFXg0+MPXbRfux3ho4=; 
 b=IRXdtf59S7jGJhi8MXAh58hXoH8k/EH3GaQHA69kv0T6DNaI8cDTvrSfqduMO7QptuzQ5jcrKxfIkxxeLNrs4rZweTIo+Fi31iaXVoE8CSgfd+tFCSdDJjJRRXf+4/tYkggGyayV1WDcR+J09IUYcpeGoA62PXAgt6NSPXLlNsI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785235471; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=J5NLQiylXqrWyBPL2yr2b7NQ7oFXg0+MPXbRfux3ho4=;
 b=GGua9EmJpb0QbnYEztrILvP8aRP7TwU3zXt41VIPig6tUXnnHf9Y8hCXp5NS8CCa
 5gDr3hllYE6vRrSsLBaP3kDAj+d+kwNwy/4TIQvWH8/TTPDzUbQ3aOmFaQgrxi4EHNI
 98OWGiPzqBJaw8WYVhjwwMX9GAeUhBsYwVS1hUas=
Received: by mx.zohomail.com with SMTPS id 1785235470064180.6244091784373;
 Tue, 28 Jul 2026 03:44:30 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id E2EBA181F68; Tue, 28 Jul 2026 12:44:23 +0200 (CEST)
Date: Tue, 28 Jul 2026 12:44:23 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 0/5] This series is split from the v15 "Add Type-C DP
 support for RK3399 EVB
Message-ID: <amh1sK_4KnD5zTlZ@venus>
References: <20260727064408.101-1-kernel@airkyi.com> <amgMXujurBrB5B0L@venus>
 <e22072d9-7fee-4f83-9ae9-5428e45c7507@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nrz2q7rk3saejmon"
Content-Disposition: inline
In-Reply-To: <e22072d9-7fee-4f83-9ae9-5428e45c7507@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.228.97
X-ZohoMailClient: External
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


--nrz2q7rk3saejmon
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/5] This series is split from the v15 "Add Type-C DP
 support for RK3399 EVB
MIME-Version: 1.0

Hello Chaoyi,

On Tue, Jul 28, 2026 at 10:33:48AM +0800, Chaoyi Chen wrote:
> >> Changes in v4:
> >> - Link to v3: https://lore.kernel.org/all/20260717072323.96-1-kernel@a=
irkyi.com/
> >> - Scan the entire typec_bus and attempt to register the hpd bridge,
> >>   so as not to miss devices that were already added during initializat=
ion.
> >=20
> > While that may help with the module being loaded late, it does not
> > help with triggering the module load in the first place.
> >=20
> > The module does not have any MODULE_DEVICE_TABLE() helping with
> > that. So basically any system relying on the automatic hpd bridge
> > registration and using a modular kernel (e.g. the arm64 defconfig or
> > the kernels usually provided by Linux distributions) requires
> > manually loading that module to get any graphical output.
> >
>=20
> Thank you for pointing this out. I will add it in v5.

Add what exactly? As this code is quite generic, you don't have
anything for a MODULE_DEVICE_TABLE() (i.e. no OF, no I2C, ...).

One solution I see to keep the notifier design would be to add

MODULE_SOFTDEP("pre: aux-hpd-typec-dp-bridge")

to some other module and piggy-back on it. Alternatively integrate
it directly to some other module, such as "drm_display_helper",
which already has DRM_DISPLAY_DP_HELPER and DRM_DISPLAY_DP_TUNNEL.
Adding TypeC DP AltMode as part of it seems sensible to me.

FWIW I suggest you test booting your patches work with the arm64
defconfig before your next submission ;)

Greetings,

-- Sebastian

--nrz2q7rk3saejmon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpoh/wACgkQ2O7X88g7
+po6mg//Ul+tqXSZBMWv39myTySZkpRAFl7a7wi9guXnO1l8taMD1Dut/6OI7XSh
9YwrPNaNV91Ky5SlMl/Yj3/pjT/FIk10Ltd3EREWrrWJoPlZMVOVM1Rv3Rg4mzgg
jZ7IowUe3zwG9xnITCsQ/bZ2dQkmHrnGnUoUNkcuws1QZqbUzMke/eTG7mHVeS0x
sWTMLSyLvXQPKnDVF7/Iu7wuKUs8Ia5N6BgLqLoXIuBogrpy960yu1zyNCKNkQaH
i6PxgcYmfo8+J9+tSxnYwCZBATn1PUDUPrDrthYSlr/eQyNKmVU6xHf4OTjRd2jG
q4BAXrZRu1bzbYaqFbaeRJ/DSnPDnTiB2aWKT4OtMqvfDOC2aSBCxa86DaSp8ehl
aPvi3CiBe+shpteIdY8dy4T7NUFSpJCN+ihGO5cjRuaIrHto3yyLIa4hpl8apeqn
tyzvk60TmL0Sjnrq+K8DjuLgk5yM0Y7zb3iur+XYnzVvwifcBvqcbMWSiNzrMiau
2GyY3PP2h0B6ExG8edpIu7vqhSlmStw8HtLNOattN4PZvqdRDg/1JEFu0V6a5Cdt
FDwKKKwht1Kshkl41y0eGBPN3i5ym7bIeoE5GreW/1dkV+7UQlXZj473tagywHuy
P51/AQYyjVWv51g7bhF8ZWQszkCaov53iUKMyjlWpVYA3XSYmaw=
=ZCR1
-----END PGP SIGNATURE-----

--nrz2q7rk3saejmon--
