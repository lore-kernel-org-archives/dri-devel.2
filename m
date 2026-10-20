Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE02606A320
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:49:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7966F10EB83;
	Tue, 20 Oct 2026 09:49:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50D110EB83;
 Tue, 20 Oct 2026 09:49:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 028C060229;
 Tue, 20 Oct 2026 09:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9801F1F000C4;
 Tue, 20 Oct 2026 09:49:32 +0000 (UTC)
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id 6962D1AC57D0; Tue, 20 Oct 2026 10:49:30 +0100 (BST)
Date: Tue, 20 Oct 2026 10:49:30 +0100
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
Message-ID: <atc5KhqlzczEhQ-z@sirena.co.uk>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <0bf04f71-cec7-453f-af5a-d121277eb51e@sirena.org.uk>
 <40844e94-c9d8-430b-90b0-66032e66060f@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7MXv3ziPad81FTm5"
Content-Disposition: inline
In-Reply-To: <40844e94-c9d8-430b-90b0-66032e66060f@ti.com>
X-Cookie: You buttered your bread, now lie in it.
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


--7MXv3ziPad81FTm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 12:21:20PM +0530, Aniket Limaye wrote:

> I am planning to send next version in a few days... aligned with Andy's
> suggestion for a separate driver. Would like to get your reviews once I do?
> Let me know if you had something else in mind.

That sounds great - I'll look out for your patches.

--7MXv3ziPad81FTm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatc5JQAKCRAv73Ows9A4
iYwBAP0fR57EuTGYO1X/nHi6gn4+pwM+iujcwDxQ6pJcelO6OQD8CcYHayy1MrWw
AWtEDnzEuwqiJFF9/1t/q9bZumUYBws=
=MPCv
-----END PGP SIGNATURE-----

--7MXv3ziPad81FTm5--
