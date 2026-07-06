Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11383C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEFA10EA18;
	Mon,  6 Jul 2026 17:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nCLYqWUv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB4F10E3E0;
 Mon,  6 Jul 2026 17:26:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A19C415B4;
 Mon,  6 Jul 2026 17:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160F11F000E9;
 Mon,  6 Jul 2026 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783358804;
 bh=6Q0tvr2GvB7IdKSisCRev74pEI09lUCKAJRHUpFa0u0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nCLYqWUvGJM2k6XDnnND9naY7BS0FeW4Fu5CyITqesk4/FYtYFs2v+CdsAT/O073Y
 GtZ8t7rZu7alxOIECS486DbL4kafAvJYppDKfefXQcxPJWSm50Z5xEB87XflCdnqI0
 dI9I5Vp+VbNytWapWIsBYtTNmQpIQ3PSkrb5u0vxywEuxj1U2BwNjyu/B89xGJdNtD
 G/Odw4daeVaAAUZb5GsfrnhN7yZ/7dsR9qtpRXxY65g9kYlYkQBfw49iWquOtCkMjk
 tJfNZXyAVgeg0oDBCZxb/20tfctRWrUO672g92oAd9zuNBOetu0kFzrqAf+966bE2y
 VRCYCAEaqRrlQ==
Date: Mon, 6 Jul 2026 18:26:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
Message-ID: <e40d0bd0-0e3d-4c01-bffc-8e0075213c45@sirena.org.uk>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
 <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
 <akvOo2EeERLYPh72@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FWksib/oYWGW6VVm"
Content-Disposition: inline
In-Reply-To: <akvOo2EeERLYPh72@ashevche-desk.local>
X-Cookie: Did I do an INCORRECT THING??
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


--FWksib/oYWGW6VVm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 06:49:55PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 06, 2026 at 04:39:00PM +0200, Manuel Ebner wrote:
> > On Mon, 2026-07-06 at 14:44 +0200, Bartosz Golaszewski wrote:

> > I removed Mark Brown <broonie@opensource.wolfsonmicro.com> from recipie=
nts because:
> > =E2=80=9CRCPT TO <broonie@opensource.wolfsonmicro.com> failed:
> > <broonie@opensource.wolfsonmicro.com>: Recipient address rejected: Doma=
in not found=E2=80=9D.

> Perhaps he needs to send a patch to update .mailmap?
> Cc'ed to Mark.

If it's for something that old I can't imagine I actually care.  If it's
important enough I'm sure someone can work out how to get hold of me.

--FWksib/oYWGW6VVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpL5UUACgkQJNaLcl1U
h9D67gf9GIugTh4PUXTgcv4IEO00hqfPt914zzGolWrW61nvCfBK/txok59PvoKw
vaWiJIxtHNcqLXDHoH9/3oPWkqxrKq0RGWEX19nr124zN/T2SihiMa5RjzAr4UAG
G9JAS2GOF29xF1Ml9KH8x5l5WduP6RUHVJqKK9vuJFpCloREcnnpMQVxJVgKEKpI
TrKQpiKRZtTm5InBsTccxeXVDL2+bhnLHZaD4LbIziWok/tCyYnCw9VEJ/iUb7PJ
bFLwu3JxUS7p7Kr/hStWapPyxi5fyw+V/ZQ8u+J5GE8g493f9A3rBarS4fJCZi8e
cIRN6GhgNtdUL6L3p77EqAzlsDTheA==
=WSwF
-----END PGP SIGNATURE-----

--FWksib/oYWGW6VVm--
