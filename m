Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD25BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E229D10E4CD;
	Thu,  2 Jul 2026 13:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bXx3Ps4Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C53210F398
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 13:46:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90C5041A3B;
 Thu,  2 Jul 2026 13:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E281F00A3D;
 Thu,  2 Jul 2026 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783000007;
 bh=3qJMtAUXDn9RpNt1LPF4J3Xl09oLERq9LyVPGpSghqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bXx3Ps4ZOSZ9QseiOa68Wf2XJmIG2ypp21x4BlQ2u1RNq02WvSk5T2wvMjOzuXzXf
 7cTcGLIEYZQm1Gjz0wLs73YzT6tT58oeXXlaBAi2Zv0iiaFv343Z2f8B5s3vPSxLH8
 Mui8YUY799Sax7adHs66K3/OcHFYtFKMOoaKiZKcm3riW6fptEqT8boSIs/pQN3Llo
 7hf1CgvOctaXCqje50lEm02Iq9dOG7KrdF+l1Z6s+Zjk6lg/POZHITm9ImODz1kZ9+
 ab26w1b0e6otPoVcF8jeDXwO20FJ5FHMGOLGRLY3dR8uSWir/iUY+p4VdhyqXJAP3V
 ZWinGwYzXbAZQ==
Date: Thu, 2 Jul 2026 15:46:44 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, 
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, 
 iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 Chun Ng <chunn@nvidia.com>
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
Message-ID: <akZkuwktaXFTrASP@orome>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
 <akYs91INHMXMTI-t@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kdpw3ftelwhct6ta"
Content-Disposition: inline
In-Reply-To: <akYs91INHMXMTI-t@willie-the-truck>
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


--kdpw3ftelwhct6ta
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
MIME-Version: 1.0

On Thu, Jul 02, 2026 at 10:18:47AM +0100, Will Deacon wrote:
> On Wed, Jul 01, 2026 at 06:08:15PM +0200, Thierry Reding wrote:
> > From: Chun Ng <chunn@nvidia.com>
> >=20
> > Add helpers to swap PROT_NORMAL and PROT_DEVICE_nGnRnE protection bits
> > on a kernel-linear-map range.
>=20
> That sounds like a really terrible idea. Why is this necessary and how
> does it interact with things like load_unaligned_zeropad()?

This is necessary because once the memory controller has walled off the
new memory region the CPU must not access it under any circumstances or
it'll cause the CPU to lock up (I think technically it'll hit an SError
but in practice that just means it'll freeze, as far as I can tell).

Probably doesn't interact well at all with load_unaligned_zeropad().

> I think you should unmap the memory from the linear map and memremap()
> it instead.

Given that the memory can never be accessed by the CPU after the memory
controller locks it down, I don't think we'll even need memremap(). The
only thing we really need is the sg_table we hand out via the DMA BUFs
so that they can be used by device drivers to program their DMA engines
internally.

Looking through some of the architecture code around this, shouldn't we
simply be using set_memory_encrypted() and set_memory_decrypted() for
this? While they might've been created for slightly other use-cases,
they seem to be doing exactly what we want (i.e. remove the page range
=66rom the linear mapping and flushing it, or restoring the valid bit and
standard permissions, respectively).

Thierry

--kdpw3ftelwhct6ta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpGa8AACgkQ3SOs138+
s6GyRxAAoXRwCQvIsIZ5khXDx6SMkmNAcO9Cg8l493HodYcUGDpoLnzmSZIuBH6O
7EzGu627WVHBzlzvdm7rW4Dix6iPF+U3Ehyr8iAUivu1yot53889neKKrC1eq9PD
+6Sz4xi37yCt4pfcPy/EWe9YYafql6PLeE3Hw0T0Tt151D1INADFoGoxNpoVcIih
Ycz/Fn0urZbUgme+pxUKTIi9ZA6mbGsQvkAVVgV7FS6NoeBO7XXr/JuLf9SdRQEj
wqGLPjfEi5yGiOAzPf5ooFKfZeczBJYU1nVrP7Pick0O8xErv2/yM51/zGFj+ZEg
9t6g/PfZ5EecBc3eS/6GNUwBG2hiV3d41NiQT1YeLHEUAqdDOJpU2pV+kIUHDH0f
cOyYPNKAAHm6yWdq4BXm+sZeIO9ULQYZfu6S4tZERgdSECiTUNFQjWcp4GXta/ag
SkK60DzHjQDDOeQ+NwA/bXJ02cVI3RMS7K/vdkbHlKrnU3gQrWNy3e2sUvl3oiuz
7gDzuZsnqiCPflZLPmYgwF4wvANcCBXsSn1QliB12LV03+muKxvZA662AtFMeiea
J+c9tkznLG8FBRWbhAyS3835rmwnxvIAte6vZsQBWnVpJQtig0tnJGkRICAS6l+E
oJ5FhyWV+jtHiSiExs+MuqQX8qR1sGnVKd7UwksFFMecrO7KvIw=
=m+eo
-----END PGP SIGNATURE-----

--kdpw3ftelwhct6ta--
