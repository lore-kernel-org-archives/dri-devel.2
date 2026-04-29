Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDFDCCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52EA10E004;
	Wed, 29 Apr 2026 18:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZiKs4+Ko";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61FB10E004
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 18:50:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 349D36015B;
 Wed, 29 Apr 2026 18:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEF6C19425;
 Wed, 29 Apr 2026 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777488600;
 bh=SJYZ4NAfB0jKA2r12K3oUXg2EYSzdPCWQ44kjGJMgLo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZiKs4+KokO+v2SHr7cJRFjeswZtDWAzjDIi7YJZLFDicOWa42t0FtJ97scrmoiUiL
 YsjvGJNaROhTcz31Xxw3IN36HhQVVkTcvWofiM/u+JdnNoCJi51qAjuL9iY8yXa9Cz
 Lb9/EVcoz/DZ+6UJcQJsHcrbjdeaCuXDVqP+XDLo6nc+fEiZO+5RR09YgxNVqmsRE6
 f2xwQcVnUTNF42WTKHXUSjGizaJUfdHMQHie5vUwjbIFkMu4R84ualDCvczf7C1DBq
 GgfoEPpj4WRW5lJCJtmyi77fcvlk4IwucF/VAif6QEZdu8VOln9b5y5Cz4cpHWGcEl
 285blVyaIgMGw==
Date: Wed, 29 Apr 2026 20:49:58 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Maxime Ripard <mripard@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Mike Rapoport <rppt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 06/10] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <afJSQbArB8USb6mt@orome>
References: <20260122161009.3865888-1-thierry.reding@kernel.org>
 <20260122161009.3865888-7-thierry.reding@kernel.org>
 <20260123-meteoric-butterfly-of-imagination-fd691f@houat>
 <aY3nov29aBGWw93Y@orome>
 <20260218-voracious-orchid-malamute-febce0@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d2myfaz5io3m7bs5"
Content-Disposition: inline
In-Reply-To: <20260218-voracious-orchid-malamute-febce0@houat>
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


--d2myfaz5io3m7bs5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 06/10] dma-buf: heaps: Add support for Tegra VPR
MIME-Version: 1.0

On Wed, Feb 18, 2026 at 10:42:22AM +0100, Maxime Ripard wrote:
> On Thu, Feb 12, 2026 at 03:50:09PM +0100, Thierry Reding wrote:
> > On Fri, Jan 23, 2026 at 02:30:14PM +0100, Maxime Ripard wrote:
> > > Hi,
> > >=20
> > > On Thu, Jan 22, 2026 at 05:10:05PM +0100, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > NVIDIA Tegra SoCs commonly define a Video-Protection-Region, which =
is a
> > > > region of memory dedicated to content-protected video decode and
> > > > playback. This memory cannot be accessed by the CPU and only certain
> > > > hardware devices have access to it.
> > > >=20
> > > > Expose the VPR as a DMA heap so that applications and drivers can
> > > > allocate buffers from this region for use-cases that require this k=
ind
> > > > of protected memory.
> > > >=20
> > > > VPR has a few very critical peculiarities. First, it must be a sing=
le
> > > > contiguous region of memory (there is a single pair of registers th=
at
> > > > set the base address and size of the region), which is configured by
> > > > calling back into the secure monitor. The memory region also needs =
to
> > > > quite large for some use-cases because it needs to fit multiple vid=
eo
> > > > frames (8K video should be supported), so VPR sizes of ~2 GiB are
> > > > expected. However, some devices cannot afford to reserve this amount
> > > > of memory for a particular use-case, and therefore the VPR must be
> > > > resizable.
> > > >=20
> > > > Unfortunately, resizing the VPR is slightly tricky because the GPU =
found
> > > > on Tegra SoCs must be in reset during the VPR resize operation. Thi=
s is
> > > > currently implemented by freezing all userspace processes and calli=
ng
> > > > invoking the GPU's freeze() implementation, resizing and the thawin=
g the
> > > > GPU and userspace processes. This is quite heavy-handed, so eventua=
lly
> > > > it might be better to implement thawing/freezing in the GPU driver =
in
> > > > such a way that they block accesses to the GPU so that the VPR resi=
ze
> > > > operation can happen without suspending all userspace.
> > > >=20
> > > > In order to balance the memory usage versus the amount of resizing =
that
> > > > needs to happen, the VPR is divided into multiple chunks. Each chun=
k is
> > > > implemented as a CMA area that is completely allocated on first use=
 to
> > > > guarantee the contiguity of the VPR. Once all buffers from a chunk =
have
> > > > been freed, the CMA area is deallocated and the memory returned to =
the
> > > > system.
> > > >=20
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > >=20
> > > Aside from the discussion on CMA, it doesn't look like the heap defin=
es
> > > anywhere the attributes of the allocated buffers this heap provides.
> >=20
> > Attributes like what? Where would you expect the driver to define this?
> > I don't see anything in struct drm_heap_export_info that sounds like
> > what you expect, nor does the allocation ABI provide any means of
> > reporting attributes.
> >=20
> > There's also not a whole lot to this, other than that the memory
> > allocated by this can't be accessed by anything other than a select set
> > of devices. You can't have any CPU access to these buffers (the hardware
> > will refuse to let the CPU read from this memory) either, which is
> > hinted at by the fact that no mmap() operations are allowed.
> >=20
> > Can you elaborate what you're looking for?
>=20
> Are the buffers you're getting when allocating cacheable? uncacheable?
> mappable? physically or virtually contiguous? etc.
>=20
> See
> https://docs.kernel.org/userspace-api/dma-buf-heaps.html#heaps

The CPU doesn't have access to the contents of these buffers, so
cacheable or uncacheable aren't really meaningful, but I guess they are
unmappable in that sense. The buffers are physically contiguous, but I
think "protected" is the right name for the heap since it most
accurately describes what the purpose (and access pattern) is.

Thierry

--d2myfaz5io3m7bs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnyUtYACgkQ3SOs138+
s6FR+g/+KsYWfQUZ129aKCUNsoLuGu/cyN7j8T6Z/3ilgL0EC9R58tbva6UNIcs8
8r2onzdPn4w0huB+6STgpihIyHcmj/Uz+Oe99KMc9dtsU9ZJQ3ZXimgI74FU+Rpw
etJC0iu8ZzUj4E46mO2wUxhq1Hw9v/+ozBlejV1Z2+07PrfxYANnB6AfrJctpWfR
oHSChS/KXwfgBN4VJUcDr9Oe9ldyzolQp/8zUNYjfIn7U8y/RzJrm/qk6llDpqmX
JVnqBG6sPty/tCi48FH6zyrD3xTi83Od3oxpLVTPk/wIOJANhJ1EMDXWicQwrWLc
eeGvG0WWTNx7+8Ej95VB/LPguytkBN3QwJwZb9d9gBOYKewiKLM41fSMhSpIjz+j
3g0DhGqKSSlk4mVqw1BQik6+wIBGCSQSZxXnqjtwOoCy7XREJbU+POiSKnczfm7/
5+YVt7Se5070nu3fc1Pl9m0vlacUB6PfYKpR47BJE8KbT5hcyDUpAK96Spo4d1L0
B+mC14GNVj1/cAV9X82JR8MhB+IsZLgWKoXV7VKQOmrQmmN7WF78iCiiYWQ0/1CY
f98vLHUgPFfpyp2laMldeuILA1YYOX73cANruKUqSz2baWdNV/YEAkShnVJxDynq
sUPyc9EarzQeCDHok0jWlg+/+IlZJoXgOHIt3ToaY3R0kns97JI=
=hyUh
-----END PGP SIGNATURE-----

--d2myfaz5io3m7bs5--
