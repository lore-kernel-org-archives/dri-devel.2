Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C581098782
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0195310EB01;
	Fri, 20 Mar 2026 13:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UhusO7Ir";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D193A10EAF9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 13:09:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A84E8443E5;
 Fri, 20 Mar 2026 13:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3263CC4CEF7;
 Fri, 20 Mar 2026 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774012191;
 bh=KtyqkgdW2N+tGuiRRGwfaJSw9/wwP3BDlPbzeD6Tf8s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UhusO7Ir2EBydsGHlZyj5vew5uqx3LL62vko5Nvx7uYqnN8LXpvVu0HBg4Jb3rN11
 6S73M9ojHqYjBNhrbqF5Hh7jyCfzHErGHu3L1R6mUu7iSqAUdNpYycA6t0Y2JGCu7I
 azCPpzorM0ShT1moymtT/RU9iLPZHEFywsckNnX3po4/g+RkOux39sHfuVFqfrhI0x
 6K5iBG0kBNAiB0VJi3u6qKegr8Nd04DhRa7oBU/Df5hCAnlurweBz5L4KTZSQstN+h
 7+aKbBVLQnUQbRckkQHUOiKXHr8jcSwXklaf2DF4sTPlOxHzV7mqlaSl370vp3i1VV
 OQBJzASK6ggNg==
Date: Fri, 20 Mar 2026 14:09:48 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Albert Esteve <aesteve@redhat.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/8] dma-buf: heaps: Turn heaps into modules
Message-ID: <20260320-cryptic-industrious-otter-5b696a@houat>
References: <CGME20260303101320eucas1p2eb4fea499364ef20825d0d73585a2555@eucas1p2.samsung.com>
 <20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org>
 <c60a3f30-6fc3-41ab-835a-2fdd887e18fd@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="zs66qpw74bbg7irl"
Content-Disposition: inline
In-Reply-To: <c60a3f30-6fc3-41ab-835a-2fdd887e18fd@samsung.com>
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


--zs66qpw74bbg7irl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/8] dma-buf: heaps: Turn heaps into modules
MIME-Version: 1.0

Hi Marek,

On Fri, Mar 20, 2026 at 01:24:18PM +0100, Marek Szyprowski wrote:
> On 03.03.2026 11:13, Maxime Ripard wrote:
> > The recent introduction of heaps in the optee driver [1] made possible
> > the creation of heaps as modules.
> >
> > It's generally a good idea if possible, including for the already
> > existing system and CMA heaps.
> >
> > The system one is pretty trivial, the CMA one is a bit more involved,
> > especially since we have a call from kernel/dma/contiguous.c to the CMA
> > heap code. This was solved by turning the logic around and making the
> > CMA heap call into the contiguous DMA code.
> >
> > Let me know what you think,
> > Maxime
> >
> > 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wikl=
ander@linaro.org/
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> I'm okay with the kernel/dma/contiguous.c changes. I only wonder how to=
=20
> properly merge them. There are other pending changes to=20
> kernel/dma/contiguous.c file [1] and if they finally get reviewed, I=20
> would like to merge=A0both via dma-mapping-for-next tree. Then I can=20
> provide a stable branch for merging the remaining dma-buf pathes. Is it=
=20
> okay for You?

That sounds reasonable to media
Thanks!
Maxime

--zs66qpw74bbg7irl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCab1HHAAKCRAnX84Zoj2+
dtHjAYCni65LYJfONrHzX1+dmTg8jR62Up22RXPxSlYyod1hB1tdIw9izCD0G6Yd
tTFaIwEBgJvjLz3SwBA1sbRbznr8PQjslZc5ZJNJzdGupJIT8b7KJryJWaeGjrY9
oc+2U5qZsA==
=0xTf
-----END PGP SIGNATURE-----

--zs66qpw74bbg7irl--
