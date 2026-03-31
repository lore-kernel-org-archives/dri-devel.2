Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F351061B2B
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 02:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5161010E82C;
	Tue, 31 Mar 2026 02:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="CuS522qa";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2376510E82C
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 02:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774922983; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Mq49b4yEp39YKrhqmwHQRs/CeXAdK5GjIboI26aie2PTIZsZo6rJAY8Yg7wFkZZFyI3TVqKrw8q5Ghu9qrQj8sLfhtc+5rfTyBhVEIjktT0p+OCS5EXlxBk+qInLovHNae5hLB8O/mmdsO1bHnwe7bgSU7O9vF7ySlUJ7ZS8McI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774922983;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IEuGrUysFVxeLUPGjMChGPVnPmXoL/wPeAu7zXo5F9o=; 
 b=RmFnn0nE4eipNnLvfX1n4ioD/gyvTyx1sPrBCEFKclLHhi3QMa1uN+/MmE6q9g1BhuQZDmTgC7AosNArPDBlf/D2a1YbhWoMD2TtQajwiUO/9ZCrUPa1Ogykt9+jcieze3e8u5lgc5YmAlJg83i3BGpRKtYw5tHoU28llPzDeG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774922983; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=IEuGrUysFVxeLUPGjMChGPVnPmXoL/wPeAu7zXo5F9o=;
 b=CuS522qaYmc5tOdAU/F2Cr3D6pHPTCISKXRhmZ6LJFRPwNqaLYjM5lScnxv78/wh
 jUV3obk4qlUv528jiHoJPJlfR9nhVpfLRDv2JuQjMIIWfhnhaUh8kw6x7zSqN5OTO9X
 28kN2gaDlhQQF8u971l8Kpxol0kBVzVswzbYfI1k=
Received: by mx.zohomail.com with SMTPS id 1774922981566898.5670100894222;
 Mon, 30 Mar 2026 19:09:41 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 403B9181F55; Tue, 31 Mar 2026 04:09:35 +0200 (CEST)
Date: Tue, 31 Mar 2026 04:09:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 00/10] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
Message-ID: <acsoT_i-LfoMoIy_@venus>
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
 <FE1BFB774BE13241+54b8a8ce-5a8c-495d-a53f-65a2440924fb@airkyi.com>
 <acphlgK6ZmBitGJL@venus>
 <AFAEA46A791878B0+9fe68e46-8d8f-44f1-80e3-dfad2de51832@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yaujaqtrdlo2vvms"
Content-Disposition: inline
In-Reply-To: <AFAEA46A791878B0+9fe68e46-8d8f-44f1-80e3-dfad2de51832@airkyi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/274.894.35
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


--yaujaqtrdlo2vvms
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/10] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
MIME-Version: 1.0

Hi,

On Tue, Mar 31, 2026 at 09:18:32AM +0800, Chaoyi Chen wrote:
> On 3/30/2026 7:50 PM, Sebastian Reichel wrote:
> > On Mon, Mar 30, 2026 at 09:34:15AM +0800, Chaoyi Chen wrote:
> >>> There are two parts, which possibly need some discussion:
> >>>
> >>>  1. I added a dedicated bridge callback for out-of-band hotplug event=
s,
> >>>     which is separate from the hotplug_notify. I have a feeling, that
> >>>     there might be a better solution, but haven't found it.
> >>
> >> Could you explain what an out-of-band hotplug event is?
> >>
> >> Can't the drivers/usb/typec/altmodes/displayport.c respond to these
> >> hot-plug events? Thank you.
> >=20
> > That is what generates the out-of-band hotplug event in the first
> > place via drm_connector_oob_hotplug_event(). The oob in that call
> > means out of band.
> >=20
> > If you look at that function it calls oob_hotplug_event() callback
> > on the DRM connector, which is then implemented by
> > drm_bridge_connector_oob_hotplug_event(). This function calls uses
> > the normal hpd handling (shared by in-band and out-of-band) and I'm
> > patching it, so that the bridges are aware of hpd explicitly being
> > provided out-of-band.
> >=20
>=20
> Ah, I'm actually more concerned with the specific types of events.
> For example, the "explicitly" provided HPD you mentioned here.=20
> Isn't drm_connector_oob_hotplug_event able to provide those?
>=20
> I assume you=E2=80=99re looking for an oob event that is propagated along=
 the
> bridge chain, rather than at the connector. Is that so? Thank you.

The connector has a dedicated hotplug oob event callback, but I obviously
need the event on the bridge, since the DP controller is implemented as
bridge. The existing infrastructure propages it down to the bridge chain
via drm_bridge_hpd_notify(), which can be received by the DP controller
via the .hpd_notify callback in struct drm_bridge_funcs.

The problem is, that this receives events for in-band AND
out-of-band hotplug events. That's why I added a new bridge
callback, which hooks into the existing framework, but only delivers
out-of-band events and no in-band events.

The problem with receiving in-band in addition to out-of-band is
that the out-of-band signal should set the hotplug pin accordingly,
but the in-band detection also checks the actual DP link. If the OOB
hotplug signal says "nothing plugged", the hotplug pin should be
forced off, but if the DP link detection fails, the hotplug pin
should not be force disabled, as that makes any further detection
tries useless.

Greetings,

-- Sebastian

--yaujaqtrdlo2vvms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnLLNsACgkQ2O7X88g7
+prmkhAAjDm4M4nMr7eRb8BBJebGTWT4fZ5RCqQUQp2qlPxp2H7ejOzNdsIScKOy
Fg4Bkkn3ROZ7G6svVSjkAf/pN3fAZoUJd7LPILYJgemGN9mvQvR1g/WDf+L1aYqR
oPTeJkV3v5hcOpkYEPYH2nibSA8RqwUfxxGC2VLo7Sdzx6rFLMpvctM8BH4iZIfa
nKdyqVBuu+QHMIwMbdQDngjHYHxFKEtKibzShG3sL/sGwD3kMUX+QliB6PRr0B0O
BY3+aIlqWoAxBc1HKanTwYP2Syo6uRUNb1YJwZ7JG8BdQgtxSWhc+wyMMncyZead
4R+2Hdr+egKMcxpd4ISADDtsr1KjeKvA5p5AoXQKZfngCB/glGu+kTH+CG555zAr
g/vYXTs4inZfBollzyHgcqVqY/2rcNtHhD1K7I8gq8i7cAeSo5BFe4G+bnpDHE3s
kiyOfKokqgCg0Ql++qf4/Vause/0KaOY9e9VauD8FMNDzsiQ19YGihRsI1VSzeG8
UCAVauBMt7xBKSTEVS7PmUtZXa20DuhtQqwIGpGnPXuk72gmdxIDDlUM1Wva9eyt
niRqdC6KyOqrf3Dc8U1JhwPb1fxAJ7iLw3xGXIlEaFjd+yqcEVvPhKNJ2iVUNrup
GF8lP5Po5r4LXBio3AACey2f1nc6z6jBaSya5T1jmalppj+LnDU=
=iO8H
-----END PGP SIGNATURE-----

--yaujaqtrdlo2vvms--
