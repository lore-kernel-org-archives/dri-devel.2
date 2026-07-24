Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483A5C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B4910F26C;
	Fri, 24 Jul 2026 00:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dY1l+6xN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E84810F26C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:13:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D639B600B1;
 Fri, 24 Jul 2026 00:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9DC1F000E9;
 Fri, 24 Jul 2026 00:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784852027;
 bh=vV8SHVjTvcYQq16HYBY/lONPVrjZ6kNVzEGGtrciPts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dY1l+6xNcFo3rz4Dt3iclqEw2EUP3Ft0aroaZGaGqL6/XjguFqJ+XWMcYGYWWfYfG
 MNfgUiONFWs7JFanWwteVGQ+kVLIA6g9/yqBElieVwGy07CjuBsdurJY3iAFJcyaGU
 C/qkzvreZslcgvgowrVZXciNyzkAakDqsTU0xfepRjyaV2dCVDqTLr7TtJD9ZMZW2B
 ceze1n/B4MKPrz2a5tBh3M1memlPANA6Vxn0aIEQODZp0MQB9tJdsee3gYulDNv1tP
 E17ArD9dgqxzy+Iu1+JINh3pn2fee9OW8j1/az4JtG/9DYjMSd0YB8I5S8v2pMckZH
 impkerrA2eyRQ==
Date: Fri, 24 Jul 2026 01:13:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org
Subject: Re: Semantic conflict between 04b177544a04 in drm-misc-fixes and
 0b6b1bb28482 in -mm
Message-ID: <93289e91-ef9f-4786-bf49-e93d91afc1ad@sirena.org.uk>
References: <20260722225605.GA1910198@ax162>
 <amFPJc1NQbuYWlSp@gsse-cloud1.jf.intel.com>
 <20260723212724.GA999236@ax162>
 <20260723160942.b58b065d771401aba117bc77@linux-foundation.org>
 <amKftG6NRZy0Ii2/@gsse-cloud1.jf.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fKoPW98d3CeKyWXz"
Content-Disposition: inline
In-Reply-To: <amKftG6NRZy0Ii2/@gsse-cloud1.jf.intel.com>
X-Cookie: (null cookie
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


--fKoPW98d3CeKyWXz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 23, 2026 at 04:11:48PM -0700, Matthew Brost wrote:
> On Thu, Jul 23, 2026 at 04:09:42PM -0700, Andrew Morton wrote:

> > I'm fine the drm people changing things ;)

> I'll jump make a DRM change so this is all worked out when it gets to
> Linus.

So should I drop Nathan's fixup then?

--fKoPW98d3CeKyWXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpirjYACgkQJNaLcl1U
h9AqhQf+KthYj9FPBRNjt7aix5PlE9HA5FGCZpsxTVHHy1cvEyiZw/wwp9hNVUTe
emIcdoj3CNZDT5pkVttPqtDC2T/TOi+CSQ4oA9tJjENnDXAsT/riLdxeagqz76Vo
hkwo1c3ixmlItxRnTmPAu2f7fK5WpXaJS+ra6FUmyv00wKd3nwqWG+Bk5xNUZVLU
z3sE4+IlkU/EXO51fH//NX0bqW77sLFRr40gSDzAITZmizC66LIXf2s0SGWRtJlE
nhYpApQ96bL9os5zg3RP38naQQa2ri5ibgSsQ6XAVs7L7XIQ5E0lNmwjSOl80BQu
fVPDJ/W9/bQkgUEFFfxGmM5eCiIBqA==
=lo9P
-----END PGP SIGNATURE-----

--fKoPW98d3CeKyWXz--
