Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE97606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NdI1FTWA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D1511266F;
	Thu, 22 Oct 2026 13:58:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A74A112654;
 Thu, 22 Oct 2026 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792677479; x=1824213479;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=vqFHmZHGB7nmSDfdqVWuVwioVVKAAt1/3ZALRMmBees=;
 b=NdI1FTWA3UnJqP58nEo1aBHbwwDFmt1pEJoq8wO9ZzhTV5bJ+FR2MXch
 GUgMJVq5CWvvPeEGm0Cjn6DxdNHeVyv5V91+oto4eDHwWEg0PuPArgLoh
 uNyb64dAy4nTmCYHPDvB25z/w9CgApkuIxJOci9FQLFUkWbadW6LfNtpU
 BiVcJWuBIB54V087FsA+HFQqGc8hbXf4ONWXTPT908gH5Abv2E1eQ8bkH
 Z25PJXnD42/UtMXlmhZqcNw/6XSvdqRYDJNiWx7dyLUIAqd+Hi/oXPt+W
 fwoEaJWxHOJzS9qs1HsUQzFjbnm2V1ysclKLxQOteLJlc/aflYjmow7q1 A==;
X-CSE-ConnectionGUID: coiksT86RkSqaUjEqhNAeQ==
X-CSE-MsgGUID: Ss3GLv2kRVSAUBdHDQpsDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1434194"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1434194"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 06:57:58 -0700
X-CSE-ConnectionGUID: h8qbDZZqT7m+FJdo3bpTiQ==
X-CSE-MsgGUID: 9Aa4p+p9RrGgAGD31BNOeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="5211010"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.180])
 ([10.245.245.180])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 06:57:55 -0700
Message-ID: <76d5115564d88428ce2a67447075582b5da78c9a.camel@linux.intel.com>
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
Date: Thu, 22 Oct 2026 15:57:52 +0200
In-Reply-To: <atnkjQNkgXTmfecD@nvdebian.thelocal>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com> <atmurtZOhKwwGjV3@nvdebian.thelocal>
 <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
 <atnkjQNkgXTmfecD@nvdebian.thelocal>
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

 * On Thu, 2026-10-22 at 22:17 +1100, Alistair Popple wrote:
> On 2026-10-22 at 18:25 +1100, Thomas Hellstr=C3=B6m
> <thomas.hellstrom@linux.intel.com> wrote...
> > On Thu, 2026-10-22 at 17:52 +1100, Alistair Popple wrote:
> > > On 2026-10-21 at 23:37 +1100, Jason Gunthorpe <jgg@nvidia.com>
> > > wrote...
> > > > On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellstr=C3=B6m
> > > > wrote:
> > > > > > struct dma_buf_mapping_exp_ops
> > > > > > =C2=A0=C2=A0 Base type for the per-mapping type exporter provid=
ed
> > > > > > functions.
> > > > > > This
> > > > > > =C2=A0=C2=A0 would be the map/unmap callbacks. Each mapping typ=
e can
> > > > > > provide
> > > > > > its own
> > > > > > =C2=A0=C2=A0 functions for map/unmap type operations with optim=
al
> > > > > > type
> > > > > > signatures.
> > > > >=20
> > > > > Does it make sense to try to land this patch first, plus a
> > > > > conversion
> > > > > of pcie_p2p so we could agree on what the contract should
> > > > > look
> > > > > like?
> > > >=20
> > > > I think it would be good to focus on this patch as the main
> > > > 'crux'
> > > > of
> > > > the series. The API contract is the main agreement. I'm
> > > > relucant to
> > > > merge code that has no users, so it woudl be ebtter to go up to
> > > > at
> > > > least through SGT.
> > > > =C2=A0
> > > > > s/mapping/interconnect/? My gut feeling is that
> > > > > "interconnect"
> > > > > best
> > > > > describes what's typically going on, but "mapping" perhaps
> > > > > better
> > > > > describes all cases.
> > > >=20
> > > > My intention was to cover more than just the phyiscal
> > > > transport. We
> > > > do
> > > > really want to get away from scatterlist, so having PCIe map
> > > > with
> > > > scatterlist and PCIe map with <something else> still ends up
> > > > with
> > > > two
> > > > mapping types in the system.
> > > >=20
> > > > This is why I choose the name over interconnect.
> > > >=20
> > > > > Location of common protocols which typically carry cross-
> > > > > subsystem
> > > > > dependencies?
> > > > > drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?
> > > >=20
> > > > I'd encourage people to design more like PCI where the actual
> > > > *interconnect* has its own home and there is just some minor
> > > > call
> > > > outs
> > > > from dmabuf to help the matching logic.
> > > >=20
> > > > > As discussed previously:=20
> > > > > Agree on theoretically possible matches at attach time, Match
> > > > > at
> > > > > mapping time and guarantee the match is valid until
> > > > > invalidate_mappings().
> > > >=20
> > > > I was thinking about this some more, and I'm less sure now.
> > > >=20
> > > > If I think about mlx5, in a multi-path PCIe configuration, it
> > > > can
> > > > move
> > > > the translation around within a single PCIe path, but it cannot
> > > > move
> > > > it to another path without creating disruption for the
> > > > application. This is a HW limitation in how the internal
> > > > routing
> > > > works..
> > > >=20
> > > > I strongly suspect this will be the norm for any hardware that
> > > > doesn't
> > > > rely on decorated page tables to select the IO path..
> > > >=20
> > > > So, while I agree we should support hardware that can fully
> > > > change
> > > > the
> > > > path on each and every map, we also need to suport hardware
> > > > that
> > > > must
> > > > pin the path during attach.
> > > >=20
> > > > Probably this points to needing a 'pin' operation for the
> > > > mapping
> > > > selection after attach.
> > >=20
> > > If I'm understanding things correctly we're expecting a change in
> > > path between
> > > attach and map time to be rare in practice. Therefore the need to
> > > handle this
> > > case is mostly as a fallback to not break things. So instead of
> > > pinning could
> > > new attachments just invalidate all existing incompatible
> > > attachments
> > > on the
> > > list by setting eg. attach->valid =3D 0?
> >=20
> > I agree, (although I think the "invalidate_attachment" needs to be
> > discussed). In the end the importer should be given a choice,
> > either
> > pin=C2=A0 and accept that subsequent attachers might see errors or
> > accept
> > app disruption.
> >=20
> > >=20
> > > Attachment could also scan existing attachments to preferentially
> > > pick matching
> > > mapping_types that are compatible with existing attachments, thus
> > > avoiding
> > > invalidation where possible.
> >=20
> > Current design appears to be that attach only determines the set of
> > theoretically possible mapping types, disregarding other
> > attachments.=20
> > Taking other attachments into account is also problematic because
> > the
> > dma-resv lock is not held.
>=20
> Oh I see. Do you foresee any problems just taking the dma-resv lock
> to walk the
> current attachments? If so we could probably resolve it with RCU, but
> I'd rather
> keep it simple if we can.

It looks like dma_buf_dynamic_attach() actually takes the dma_resv lock
to update the attachment list, so that should work. Provided we want to
take existing attachments into account already at this stage.

Need to take care, though, not to have the resv lock held over the ops-
>attach callback into the driver.

>=20
> > Looking at current GPU drivers, what you describe above is
> > typically
> > done at pin() time, but if some importers want an early very likely
> > decision on what mapping_type to use, one could introduce a
> > separate
> > function that match the mapping_types, but that would be very
> > similar
> > to the map() function but without returning a sgt/mapping, or a
> > pin()
> > without actually pinning. One could reuse the invalidate_mappings()
> > callback to indicate the mapping type is no longer valid?
>=20
> I did wonder about that, but a callback for attachment invalidation
> seems like
> it might be a pain for importers to syncrhonize with. What I'm
> thinking, which I
> think is similar to what you describe, is something like the
> following:
>=20
> 1. Importer gets the likley attachment by passing a list of mapping
> types in
> prefered order to dma_buf_mapping_attach() which returns the
> dma_buf_attachment
> that would work based on current attachments and what the exporter
> provides:
>=20
>=20

Something like this sounds OK, although given Jason's use-case, I added
some comments:


> attach =3D dma_buf_mapping_attach(...)
>=20

Just filter out impossible mappings.

> 2. Takes dmabuf->resv lock.

dma_buf_match_mapping_type(); Determines a mapping that is valid until
the next invalidate_mappings(). NOP if a valid mapping already exists.
Allows masking mapping_types.
This allows Jason's use-case while keeping the attachment as a
callback anchor.

>=20
> 3. Pins the attachment (if required):

dma_buf_match_mapping_type(); Determines a mapping that is valid until
the next invalidate_mappings(). NOP if a valid mapping already exists.
Allows masking mapping_types.
This allows Jason's use-case while keeping the attachment as a
callback anchor.

>=20
> rc =3D dma_buf_pin(attach)

This would implicitly pin also the mapping_type, but question is what
happens if a link is severed? Then we'd want an invalidate_mappings()
to re-negotiate the mapping type, but a pinned dma-buf that receives an
invalidate_mappings() is revoked by definition.

>=20
> DMA-BUF core revalidates the attachment is still valid (ie. by
> checking the
> match again or via some other mechanism to detect the attachment
> path/location
> has changed such as a sequence/generation number).

Since the resv is locked, nothing could have changed since
dma_buf_match_mapping_type();

/Thomas


>=20
> On error the importer can either fail or try to create a new
> attachment.
>=20
> 4. Map
>=20
> rc =3D dma_buf_[sgt|pcie_p2p]_map(attach, ...)
>=20
> Follows the same revalidation process as dma_buf_pin().
>=20
> Thoughts?
>=20
> =C2=A0- Alistair
>=20
> > /Thomas
> >=20
> >=20
> > >=20
> > > Map time functions (eg. dma_buf_sgt_map_attachment) would check
> > > attach->valid
> > > and return a failure if a subsequent attachment/event had
> > > invalidated
> > > the
> > > mapping type.
> > >=20
> > > Importers with invalidated attachments would then have to retry
> > > creating the
> > > attachment, probably getting a different mapping_type. Would this
> > > be
> > > acceptable?
> > > Or do some importers absolutely require the mapping_type to never
> > > change once
> > > the intial match/attachment has happened?
> > >=20
> > > =C2=A0- Alistair
> > >=20
> > > > > > +/*
> > > > > > + * Match items are generated by the importer using the
> > > > > > DMA_BUF_IMAPPING_*() and
> > > > > > + * the exporter using the DMA_BUF_EMAPPING_*() functions.
> > > > > > Each
> > > > > > mapping type
> > > > > > + * defines its own signature with its own data to make the
> > > > > > match and
> > > > > > attachment.
> > > > > > + */
> > > > > > +struct dma_buf_mapping_match {
> > > > > > + const struct dma_buf_mapping_type *type;
> > > > > > + const struct dma_buf_mapping_exp_ops *exp_ops;
> > > > > > + union {
> > > > > > + /* Each mapping_type has unique match
> > > > > > parameters
> > > > > > here */
> > > > > > + };
> > > > >=20
> > > > > Do we really need to add all global mapping types here? Then
> > > > > we'd
> > > > > need
> > > > > something for driver-private mapping types as well.
> > > >=20
> > > > IIRC it is fixed size up front like this because of how the
> > > > structure's memory is managed in this design..
> > > >=20
> > > > If you want a driver private thing then I'd add a 'u64
> > > > driver_private[2]' to the union and the driver can cast over
> > > > it.
> > > >=20
> > > > But this is the kernel, if you want to add an xe_mapping_type,
> > > > then
> > > > just add it. I don't know we need to do driver private things.
> > > >=20
> > > > Jason
