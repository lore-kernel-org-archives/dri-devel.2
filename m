Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F3606D82B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uh7Wk2ah
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4388510F807;
	Fri,  6 Nov 2026 12:10:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323C410F807
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 12:10:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE097402A9;
 Fri,  6 Nov 2026 12:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738AC1F008A3;
 Fri,  6 Nov 2026 12:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793967039;
 bh=ok4nzVjEAyulzs2BMTaD8yb49YheAsDCLG78vvfmKO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Uh7Wk2ahqQHRwfkfAMzQoiEjOLra6/YVadF+NOmmtg+TugdV9HsgkNPnmY9j9ruUw
 JdjIT/ErzzieAS/KXoycwX997OK9yPkIRM0K/Rg6j4SD4Yhh0IzBovmY23jeC6lBbJ
 uKYCHVXm0O5BwF1Jg/0TEOWQcBDOVnGMV6WDoMKjCCDByxK9oFcdRmzGEycp3gEZCV
 3du6DFF2V+3W1M2AO4JEJSXyLZPAUE3ypQ/8oxEo+fh1lOAUIDDHxI/3FL0V3JzPbz
 1hWuhBfTSZvW5Ocg549rfXLGXihzieb2S+tQtGjVUpBo9BiuUNcQEoOzPHLVn7ccTd
 5TQ8aMXmRoGrg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
 id AC19128055B2; Fri, 06 Nov 2026 12:10:27 +0000 (GMT)
Date: Fri, 6 Nov 2026 12:10:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexdeucher@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <717db488-ac4f-4969-be69-7e34ae9b79fb@sirena.org.uk>
References: <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
 <auqaZdocMvOIxN1c@intel.com>
 <CAPM=9tzu6MYQ-Y0iYK=2PLiM5=1BsEN+Q5WnmYh=hkKnLJ4b1Q@mail.gmail.com>
 <629d19bcd0f61974f3e1c94c90b4052216d2a967@intel.com>
 <DMNL1MG0A8P4.1VPON40R8BX2U@kernel.org>
 <3678ff00381a70148d6abafcf20ba3726bff2fc7@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MPrVwXwP1R0HP6vm"
Content-Disposition: inline
In-Reply-To: <3678ff00381a70148d6abafcf20ba3726bff2fc7@intel.com>
X-Cookie: Whoever dies with the most toys wins.
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--MPrVwXwP1R0HP6vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 01:08:19PM +0200, Jani Nikula wrote:

> The reason we have dim in the first place is to make us do stuff the
> same way, every time, and not forget stuff. When we screwed up, we
> addressed it in dim to not screw up again.

FWIW it might be worth having something that checks if an incoming PR
has actually been in -next at least once, there seems to be a pattern of
people sending them without waiting for that.

--MPrVwXwP1R0HP6vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau3DswAKCRAv73Ows9A4
icPcAQCNZ4CRayrdtEryWm1lyac8cKhf/2XZKOEG5zqyXCea0AEAxarfw/d6i9Q0
i1y2zMqsvvunGQjc40hLrhxqmoKPhgQ=
=4fv4
-----END PGP SIGNATURE-----

--MPrVwXwP1R0HP6vm--
