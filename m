Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4B606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a8ER9OFI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E1B1123A2;
	Thu, 22 Oct 2026 07:29:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D453F112394;
 Thu, 22 Oct 2026 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792654173; x=1824190173;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=iTNmgRNbwvR3yKajP5+NPQHqD/ADmHr1tlEg7gAxXD8=;
 b=a8ER9OFI8kW2khz6T96ZsCGHoMrihDKvGn+vIbTwtKjxkNSbd6sVLoOD
 0E4+dpkW9waFESokGv6rfcpmopgFhO5cmpvZbN/Ppq/p5luCosCorvssF
 Bdp4YV+5KHRyFgOyRMpsf7iOHSfHSWWnIaDmwLUime++QoXjhnLt9qrcj
 VXpxZJwpl3dJqNyicA2ghlNJOx4Iu6JSYh8G1Gf85slFR4aF0RjZ2Lhyy
 GxjiurD8ERVT8vdw8e5ncCiX6tRfCmxEzw4Vw2MTAWqEWjlMrBQh16opk
 z18hUd0BJNmKV5Lb9+HE1skhndqZs417uK4MJ6nRlFACsmz3WEpL0UNZV A==;
X-CSE-ConnectionGUID: bG7UbYKER2Smpd6O7Kb2wg==
X-CSE-MsgGUID: JDFAGgnuRLiW00/WpK/ybA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1267522"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1267522"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 00:29:28 -0700
X-CSE-ConnectionGUID: 3sdOY2nIRCideIdpdGyCtQ==
X-CSE-MsgGUID: GMvpY4WSTKWy+XXTgqVlhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3176651"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.180])
 ([10.245.245.180])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 00:29:24 -0700
Message-ID: <299044eebbc363b2100b09ce64450b4bd47b61a5.camel@linux.intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Christian Koenig	
 <christian.koenig@amd.com>, Dongwon Kim <dongwon.kim@intel.com>, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky	
 <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org, 
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vivek Kasireddy	 <vivek.kasireddy@intel.com>
Date: Thu, 22 Oct 2026 09:29:21 +0200
In-Reply-To: <atm2X5E-ta4QfGnu@nvdebian.thelocal>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com>
 <598bc83d8070c9bcb364a336b91d1e6c6fff4256.camel@linux.intel.com>
 <atm2X5E-ta4QfGnu@nvdebian.thelocal>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-10-22 at 18:20 +1100, Alistair Popple wrote:
> On 2026-10-22 at 17:59 +1100, Thomas Hellstr=C3=B6m
> <thomas.hellstrom@linux.intel.com> wrote...
> > On Wed, 2026-10-21 at 09:37 -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellstr=C3=B6m wrote=
:
> > > > > struct dma_buf_mapping_exp_ops
> > > > > =C2=A0=C2=A0 Base type for the per-mapping type exporter provided
> > > > > functions.
> > > > > This
> > > > > =C2=A0=C2=A0 would be the map/unmap callbacks. Each mapping type =
can
> > > > > provide
> > > > > its own
> > > > > =C2=A0=C2=A0 functions for map/unmap type operations with optimal=
 type
> > > > > signatures.
> > > >=20
> > > > Does it make sense to try to land this patch first, plus a
> > > > conversion
> > > > of pcie_p2p so we could agree on what the contract should look
> > > > like?
> > >=20
> > > I think it would be good to focus on this patch as the main
> > > 'crux' of
> > > the series. The API contract is the main agreement. I'm relucant
> > > to
> > > merge code that has no users, so it woudl be ebtter to go up to
> > > at
> > > least through SGT.
> >=20
> > I agree about unused code, but wouldn't a pcie_p2p conversion to a
> > mapping type be a valid use-case?
>=20
> In some ways I think having both sgt and the pcie_p2p conversion is
> helpful as
> it demonstrates how different mapping types are used. I agree the
> important bit
> is settling on the contract though. Adding a pcie_p2p conversion on
> top doesn't
> look too hard though. Thomas would you be ok if I rebased and posted
> some of
> your patches[1] adding pcie_p2p on top of the mapping types + SGT
> conversion
> v2 I'm getting ready to send to demonstrate usage? Or would you
> rather do that
> after I send?

Please go ahead and use them as you wish. That was only a quick mostly
AI-generated POC.

Thanks,
Thomas


>=20
> [1] -
> https://gitlab.freedesktop.org/thomash/xe-vibe/-/commit/7452df0fc858a7dc5=
ccac0e2037852cb7ab64d61
>=20
> =C2=A0- Alistair
>=20
> > > =C2=A0
> > > > s/mapping/interconnect/? My gut feeling is that "interconnect"
> > > > best
> > > > describes what's typically going on, but "mapping" perhaps
> > > > better
> > > > describes all cases.
> > >=20
> > > My intention was to cover more than just the phyiscal transport.
> > > We
> > > do
> > > really want to get away from scatterlist, so having PCIe map with
> > > scatterlist and PCIe map with <something else> still ends up with
> > > two
> > > mapping types in the system.
> > >=20
> > > This is why I choose the name over interconnect.
> > >=20
> > > > Location of common protocols which typically carry cross-
> > > > subsystem
> > > > dependencies?
> > > > drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?
> > >=20
> > > I'd encourage people to design more like PCI where the actual
> > > *interconnect* has its own home and there is just some minor call
> > > outs
> > > from dmabuf to help the matching logic.
> > >=20
> > > > As discussed previously:=20
> > > > Agree on theoretically possible matches at attach time, Match
> > > > at
> > > > mapping time and guarantee the match is valid until
> > > > invalidate_mappings().
> > >=20
> > > I was thinking about this some more, and I'm less sure now.
> > >=20
> > > If I think about mlx5, in a multi-path PCIe configuration, it can
> > > move
> > > the translation around within a single PCIe path, but it cannot
> > > move
> > > it to another path without creating disruption for the
> > > application. This is a HW limitation in how the internal routing
> > > works..
> > >=20
> > > I strongly suspect this will be the norm for any hardware that
> > > doesn't
> > > rely on decorated page tables to select the IO path..
> > >=20
> > > So, while I agree we should support hardware that can fully
> > > change
> > > the
> > > path on each and every map, we also need to suport hardware that
> > > must
> > > pin the path during attach.
> > >=20
> > > Probably this points to needing a 'pin' operation for the mapping
> > > selection after attach.
> > >=20
> > > > > +/*
> > > > > + * Match items are generated by the importer using the
> > > > > DMA_BUF_IMAPPING_*() and
> > > > > + * the exporter using the DMA_BUF_EMAPPING_*() functions.
> > > > > Each
> > > > > mapping type
> > > > > + * defines its own signature with its own data to make the
> > > > > match
> > > > > and
> > > > > attachment.
> > > > > + */
> > > > > +struct dma_buf_mapping_match {
> > > > > +	const struct dma_buf_mapping_type *type;
> > > > > +	const struct dma_buf_mapping_exp_ops *exp_ops;
> > > > > +	union {
> > > > > +		/* Each mapping_type has unique match
> > > > > parameters
> > > > > here */
> > > > > +	};
> > > >=20
> > > > Do we really need to add all global mapping types here? Then
> > > > we'd
> > > > need
> > > > something for driver-private mapping types as well.
> > >=20
> > > IIRC it is fixed size up front like this because of how the
> > > structure's memory is managed in this design..
> > >=20
> > > If you want a driver private thing then I'd add a 'u64
> > > driver_private[2]' to the union and the driver can cast over it.
> > >=20
> > > But this is the kernel, if you want to add an xe_mapping_type,
> > > then
> > > just add it. I don't know we need to do driver private things.
> >=20
> > I guess it's my wish to separate components. Couldn't this lead to
> > excessive includes and unnecessary dma-buf recompilations when
> > mostly
> > unrelated headers are touched? Except possibly for memory size,
> > core
> > dma-buf shouldn't need to know about this, it's a mapping private
> > thing?
> >=20
> > /Thomas
> >=20
> >=20
> > >=20
> > > Jason
