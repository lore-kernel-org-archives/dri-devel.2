Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD702CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C0A10E051;
	Thu,  1 Oct 2026 06:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q/e1gTPS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893AB10E051
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:50:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D07E1601F6;
 Thu,  1 Oct 2026 06:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020551F000FF;
 Thu,  1 Oct 2026 06:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790837443;
 bh=WrUdE2khAdlf1/MsWrHbA7qdAiwyidVJ+i8uJKDW1Wk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q/e1gTPSrCSD68j7AaM7kzhCj2ouy4/v4QCOpa4HPL95utDNjJDwaZcZ5yGt5FqHT
 dD9PdDvoB5wopVPaRUq1UAeYloJJeguRywdsCqjCiiKB5cxWI4vPLwYkY7+3LZtATD
 KmVg3PbwmG1y5oDsWEQPpIJPN2OQb+UI+VrOfR3kxc8KHogXvmB8fJraf4V0sqQ2Oz
 vAgJ6b627+BtkKxmUT/wjiJH6AUNYmTPfdyuQSm0oPlybPjUoP725ioqJLOgWUMbq7
 tEA/EsJoAied51k1DcbyvxC6A3+5Qr44rstP7rVsk6lSHACIUtf8vJgXinZravVGlZ
 cvLpKC2jfGAfg==
Date: Thu, 1 Oct 2026 08:50:40 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Benjamin Tissoires <bentiss@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <ar4CRTMQGs5_nGKY@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
 <arqhwHiVf00j94J7@beelink>
 <0259fe4b-3118-4ab0-9b62-55101bfd7f33@linaro.org>
 <arrAqg5n87INTHE6@beelink>
 <674314b4-6b80-4b3a-ac15-eefd31cea607@linaro.org>
 <artpBMeM13Dd0lLy@houat>
 <xlv1wls4ebjq.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <828c9108-2db1-45a6-9301-19159a094301@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="kw273bz54geum3wd"
Content-Disposition: inline
In-Reply-To: <828c9108-2db1-45a6-9301-19159a094301@linaro.org>
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


--kw273bz54geum3wd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 03:37:58PM +0200, Neil Armstrong wrote:
> On 9/29/26 09:55, Javier Martinez Canillas wrote:
> > Maxime Ripard <mripard@kernel.org> writes:
> >=20
> > > On Mon, Sep 28, 2026 at 10:36:18PM +0200, Neil Armstrong wrote:
> > > > On 9/28/26 21:48, Benjamin Tissoires wrote:
> > > > > On Sep 28 2026, Neil Armstrong wrote:
> > > > > > On 9/28/26 19:24, Benjamin Tissoires wrote:
> > > > > > > On Sep 28 2026, Neil Armstrong wrote:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > On 9/28/26 18:22, Maxime Ripard wrote:
> > > > > > > > > Hi,
> > > > > > > > >=20
> > > > > > > > > Panels in general, and MIPI-DSI panels in particular, are=
 pretty
> > > > > > > > > difficult to support and require pretty much a panel driv=
er for each
> > > > > > > > > panel produced. Most of them are pretty simple, and requi=
re an opaque
> > > > > > > > > initialization sequence that is usually poorly documented.
> > > > > > > > >=20
> > > > > > > > > This creates a tension between OEMs and distros because O=
EMs will
> > > > > > > > > typically get a new panel to react to a sourcing issue du=
ring
> > > > > > > > > production, and thus need some swift turnaround between g=
etting their
> > > > > > > > > new panel and it being operational in the OS. Distributio=
ns on the other
> > > > > > > > > hand can take years to ship a kernel with that new panel =
driver.
> > > > > > > > >=20
> > > > > > > > > To solve this, I followed the example of HID-BPF and wrot=
e a panel
> > > > > > > > > driver that will rely on BPF programs to perform the panel
> > > > > > > > > initialization. That way, we can ship the programs separa=
tely from the
> > > > > > > > > kernel, and with a different lifecycle. If this driver is=
 accepted, the
> > > > > > > > > plan is to have a userspace component started by udev to =
identify and
> > > > > > > > > load the right BPF program for the panels found on the de=
vice.
> > > > > > > >=20
> > > > > > > > This is kind of late for serious applications except if we =
manage to
> > > > > > > > solve the bootloader to Linux display engine transition.
> > > > > > > >=20
> >=20
> > Besides what Maxime already mentioned (that most general purpose Linux =
distributions
> > built the drivers as modules anyways), it doesn't have to be mutually e=
xclusive.
> >=20
> > A simple panel could be supported using this BPF-based driver and then =
a panel driver
> > added to the kernel, if is found that some applications need to have it=
 built-in and
> > earlier in the boot path.
> >=20
> > I don't see why this would be any different than HDI-BPF or other BPF-b=
ased infra,
> > such as sched_ext.
>
> I don't want to add a supplementary maintenance burden for the sake of us=
ing a cool
> technology which has serious drawbacks and dependencies on user-space eve=
n if looks
> really cool.

Spoiler alert: v2 won't. I've got the in-kernel loader to work and thus
you can have a built-in panel driver that works without user-space
intervention. So this is not a topic of discussion anymore.

Maxime


will work

--kw273bz54geum3wd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar4CvwAKCRAnX84Zoj2+
dvcSAX49Wfvd2Nx91Qlv77RICWSMxTGFolQVADy53gvu7ebfWo/lEDg2wmMLUV5U
MkA52hMBgIONoBjDpHdMNV7byAvh44CSyrq8DcktEoCEF8a0dOoxQJ5lKBLZgdH2
o+5/ElvokQ==
=5iv0
-----END PGP SIGNATURE-----

--kw273bz54geum3wd--
