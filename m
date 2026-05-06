Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257AEFF8855
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7728710E2D4;
	Wed,  6 May 2026 13:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AKPmIlxB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E8810E2D4
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 13:12:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CF457442CA;
 Wed,  6 May 2026 13:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326C0C2BCF6;
 Wed,  6 May 2026 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778073160;
 bh=6zgK85Psgb7v1JIE4C66zEivfyBHwwFQ3efCNdsjulc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AKPmIlxBPl17FHX9eU6Y03CHlL1kHunU2HwcFaSaH7T+ZPqg/w8f6/nqgMzptpyAk
 YzL+yGG906Pkp/5O9MHKzS/q/vR9Pirlwr1Mi0px1zIV+12NXOblyIJDbutm/B6yFx
 d/Bt9+6yqS4clBaG5KurgIRzPtVHcGu2iBYyMdxk9EG6t1IgvRSKsLj/P5ZT88jMcK
 WLmkjfwR7rHlHfEPs9MzFMJjTIUedHJZSuUwNTwChx4j0WvKOt2JZytfozCOPYnwuK
 FPW9ukJ/NsyFAiLq9AhI4BXd0at+zUD5J8gnR85dxwqEUsxVYfdvfT3Cm60m6PKBh4
 RXLmaJ4fIuPRg==
Date: Wed, 6 May 2026 15:12:37 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Ketil Johnsen <ketil.johnsen@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Florent Tomasin <florent.tomasin@arm.com>
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
Message-ID: <20260506-golden-python-of-aptitude-ff972a@houat>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260506-energetic-azure-pig-2b6ec4@houat>
 <20260506125015.0108ef44@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="jsgwzb7lbdee6dei"
Content-Disposition: inline
In-Reply-To: <20260506125015.0108ef44@fedora>
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


--jsgwzb7lbdee6dei
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
MIME-Version: 1.0

On Wed, May 06, 2026 at 12:50:15PM +0200, Boris Brezillon wrote:
> On Wed, 6 May 2026 12:08:24 +0200
> Maxime Ripard <mripard@kernel.org> wrote:
>=20
> > Hi,
> >=20
> > On Tue, May 05, 2026 at 04:05:10PM +0200, Ketil Johnsen wrote:
> > > From: Florent Tomasin <florent.tomasin@arm.com>
> > >=20
> > > This patch allows Panthor to allocate buffer objects from a
> > > protected heap. The Panthor driver should be seen as a consumer
> > > of the heap and not an exporter.
> > >=20
> > > Protected memory buffers needed by the Panthor driver:
> > > - On CSF FW load, the Panthor driver must allocate a protected
> > >   buffer object to hold data to use by the FW when in protected
> > >   mode. This protected buffer object is owned by the device
> > >   and does not belong to a process.
> > > - On CSG creation, the Panthor driver must allocate a protected
> > >   suspend buffer object for the FW to store data when suspending
> > >   the CSG while in protected mode. The kernel owns this allocation
> > >   and does not allow user space mapping. The format of the data
> > >   in this buffer is only known by the FW and does not need to be
> > >   shared with other entities.
> > >=20
> > > The driver will retrieve the protected heap using the name of the
> > > heap provided to the driver as module parameter. =20
> >=20
> > I know it's what dma_heap_find asks for, but I wonder if it wouldn't be
> > better in the device tree and lookup through the device node? heaps are
> > going to have a node anyway, right?
>=20
> I'm not too sure. Take the PROTMEM (name=3D"protected,xxxx") dma_heaps
> instantiated by optee for instance, I don't think the originating
> tee_device comes from a device node, nor is the underlying heap
> described as a device node. The reserved memory pool this protected heap
> comes from is most likely defined somewhere as reserved memory in the
> DT, but there's nothing to correlate this range of reserved mem to some
> sub-range that the TEE implementation is carving out to provide
> protected memory.

Maybe we should be working on a dt bindings for heaps then? Something
simple like we have for clocks with a phandle and an ID would probably
be enough. In optee's case, it looks like it would map nicely with
TEE_DMA_HEAP_* flags too.

The only two that wouldn't be covered would be the system and default
CMA heap if not setup in the DT, which shouldn't be too bad for this
particular use-case.

> > This would allow you to have a default that works and not mess to much
> > with the kernel parameters that aren't always easy to change for
> > end-users.
>=20
> I guess we can have a default list of heaps that we know provide
> protected memory for GPU rendering if that helps. Right now this list
> would contain only "protected,trusted-ui" :D. The other option would be
> to make this list a panthor Kconfig option and not expose it as a module
> param.

My main concern is that firmware builds are board specific, and thus its
capabilities isn't something we can reasonably expect to be consistent
across boards, SoCs and platforms. Kernel images (and the kernel
parameters) however can be made generic and unreasonably hard for users
to modify once you start playing with things like secure boot or
measured boot.

The only thing bridging the gap between the two is the DT.

Maxime

--jsgwzb7lbdee6dei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCafs+PAAKCRAnX84Zoj2+
do/dAYCsFzskHm3rONL7gbWKGNrMZhZjrhqTYx/ppxLU2/mdI1esaru0x+30gIoH
nAbsF0cBfRycq8wqS/81+OsbptnyvCrcfE8WBuuTjYVh1soyjUZwMGn7aT+MO70j
Za2ft8aPZg==
=ON6G
-----END PGP SIGNATURE-----

--jsgwzb7lbdee6dei--
