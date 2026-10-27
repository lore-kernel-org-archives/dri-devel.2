Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53081606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B179910F5BF;
	Tue, 27 Oct 2026 14:26:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF6310F5AE;
 Tue, 27 Oct 2026 14:26:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0148B43935;
 Tue, 27 Oct 2026 14:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784161F01825;
 Tue, 27 Oct 2026 14:26:26 +0000 (UTC)
Date: Tue, 27 Oct 2026 14:26:23 +0000
From: Mark Brown <broonie@debian.org>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
 u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
 Ritwick.Sharma@arm.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
Message-ID: <c6cd214a-e7ad-436a-b562-5effaff927f6@sirena.org.uk>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk>
 <40844e94-c9d8-430b-90b0-66032e66060f@ti.com>
 <atc5KhqlzczEhQ-z@sirena.co.uk>
 <f308e372-255b-41d8-9225-959750950780@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JhUl+OvBjkhu9TF/"
Content-Disposition: inline
In-Reply-To: <f308e372-255b-41d8-9225-959750950780@ti.com>
X-Cookie: You will be surrounded by luxury.
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--JhUl+OvBjkhu9TF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 06:44:54PM +0530, Aniket Limaye wrote:

> I have sent a v4 as a separate driver [0].

> [0]: https://lore.kernel.org/all/20261027-tda54-upstream-i2c-v4-0-ebeeaf87d181@ti.com/

Thanks, I'm taking a look now - please feel free to just CC me on
further postings.

--JhUl+OvBjkhu9TF/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrgtI8ACgkQJNaLcl1U
h9B5qwgAgXP3DXULMG5ni/vnZNu62OReCPp1K5I5Aj7kvDLw6Gx/sg/okzKTsHKd
zf45r+fwAKieOJqHCB+LCH2UocFHs5WM4xbfCjdGX6koM5s4ocAxr8zS8W9Hkas1
49hGwyEUm+j9vdN3/FusrbuotrlE14Vas9W+xdp2NcbNYskWiPskzHR50VWsRyyd
XSp5BIws/iZK+KxVIWwvnynNGUcHnzRxhzWQBwqgNKXAHjo4hEYXh/ljwX3RP0b+
ho7fQy2uC2cCXJ40azpd1MQLif50tAQblm6sorYZdgXv0ogPDnT5TPajHCseGgcj
INF6dzBZkvdke6PntU9E0KmxhASXIQ==
=SXNI
-----END PGP SIGNATURE-----

--JhUl+OvBjkhu9TF/--
