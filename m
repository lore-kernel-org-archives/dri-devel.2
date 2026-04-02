Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313E0D3941D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AF710F0EB;
	Thu,  2 Apr 2026 13:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WSszUspE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5FD010F0EB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 13:12:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 970D843F07;
 Thu,  2 Apr 2026 13:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2097EC116C6;
 Thu,  2 Apr 2026 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775135522;
 bh=a7x/ysTtVW24aU35eMPirkt+sO+v8dpDAEKDhxuDe60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WSszUspE9dzXyP1vG2gMcdzvhWi9nAi5ipcnGtuyZonB7RZAGmX1hwDPduMtfEj0f
 lW2LoRIl2ShIjcyVDeuG1hlvOO/zqpCeA0Z146DRKKA0duBquAvj+fJQT/uscVbkZe
 2wg5nQmX87424MYUc//sb0M9cOh0Ho+XSCi8NXobJRbr+fliundDiCPi1S/NRwsAeC
 kc4nITLm01qhH8H8Sxex1i7X4/hTzJrnBqisiAgNMciIgTmVqODXmYgxMjwhE4MTBg
 w18ZXyGoeIRDg6/g/t6PcP82CKsFc0A1CC7A5a4HCiyOTIneD54u7brrQ1GJ5SK+vp
 +XGiv48Yu5boA==
Date: Thu, 2 Apr 2026 15:11:59 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
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
Subject: Re: [PATCH v4 0/8] dma-buf: heaps: Turn heaps into modules
Message-ID: <20260402-burrowing-fine-bloodhound-afcebc@houat>
References: <CGME20260331100026eucas1p19bdc2aaca4c9a48c6f6ac8fec71478d8@eucas1p1.samsung.com>
 <20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org>
 <46397de2-eedf-4e09-a83a-3b683d154fe7@samsung.com>
 <CAO_48GEFQE_FJjuq1UqP=DC6LJE8jjE3C+4FdAyB4uEZDsnFJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="me4gicdwmutl43x6"
Content-Disposition: inline
In-Reply-To: <CAO_48GEFQE_FJjuq1UqP=DC6LJE8jjE3C+4FdAyB4uEZDsnFJw@mail.gmail.com>
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


--me4gicdwmutl43x6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/8] dma-buf: heaps: Turn heaps into modules
MIME-Version: 1.0

On Thu, Apr 02, 2026 at 10:36:48AM +0530, Sumit Semwal wrote:
> Hello Maxime,
>=20
> On Tue, 31 Mar 2026 at 18:24, Marek Szyprowski <m.szyprowski@samsung.com>=
 wrote:
> >
> > On 31.03.2026 12:00, Maxime Ripard wrote:
> > > The recent introduction of heaps in the optee driver [1] made possible
> > > the creation of heaps as modules.
> > >
> > > It's generally a good idea if possible, including for the already
> > > existing system and CMA heaps.
> > >
> > > The system one is pretty trivial, the CMA one is a bit more involved,
> > > especially since we have a call from kernel/dma/contiguous.c to the C=
MA
> > > heap code. This was solved by turning the logic around and making the
> > > CMA heap call into the contiguous DMA code.
> > >
> > > Let me know what you think,
> > > Maxime
> > >
> > > 1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wi=
klander@linaro.org/
> > >
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> Thank you for this patch series; now that it is needed by more folks,
> I think we can merge this.
>=20
> Marek, I'll coordinate with you on this - thank you!

If Marek plans on sending it during the next merge window, maybe the
best thing to do for us is just to wait for -rc1 and apply the rest of
the patches. Otherwise, we can merge the branch in drm-misc.

Maxime

--me4gicdwmutl43x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCac5rGAAKCRAnX84Zoj2+
drvAAX9Gv+TrbX5Ru5iTuTfrjby3dUGZF6Vd9/L4HY+x15swwQBj44P2X43WwAnM
cMhPq+8Bf00cagtlOIBhV4Hse29yKk8z2Is7iRaewRIPe/yQho7wdJK8x1cnDkbD
NQuA+jE9OQ==
=+ZbZ
-----END PGP SIGNATURE-----

--me4gicdwmutl43x6--
