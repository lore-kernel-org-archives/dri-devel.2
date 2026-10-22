Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E6606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jYrqD6rl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3686F11252A;
	Thu, 22 Oct 2026 12:05:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6D911252A;
 Thu, 22 Oct 2026 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792670737; x=1824206737;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=FXkfA/bBRHRDEgHeRdJ9rUV1p4ghzX+6hSaSjg25qgY=;
 b=jYrqD6rloUjXQ6+L+XiQfUuUWG4gnnDZoqhVJerq3aBQdbwXa+69UJOH
 wp+vRBWXdsOTYuOPzloV2SzAnrY5ZOotAU5xlS9jVYYTN+jHBrVMYcoyY
 XF2kIUr+44GHDWhouZzfTinfhT+ECsvb1VxcL2WTkK/UsLrcRcmVDotNQ
 NaGHhx1GQUEHhgn+5Wx3yaNbGjiTqpxz69IIspVqhK+e/Dy2kollkeOf9
 fQmBYN20lohKLEzdIGSIL4YS5xf3OJPonuCA47atfqNeVocQPPMw00jWA
 hXN9AHLypgp05r3kGoDLih5XXbziUmDvwn7GsTzb3kiWZmlX7qaxz9DBr w==;
X-CSE-ConnectionGUID: kacH/usKQiaKsSWt0e+wZw==
X-CSE-MsgGUID: k8aPOu+DSlyz1WG4SS0kjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1451932"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1451932"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 05:05:37 -0700
X-CSE-ConnectionGUID: MECgBnPiSzm4aUb67+emgQ==
X-CSE-MsgGUID: kbz7huL0RaaHxaUjMCr9eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3336468"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.245.180])
 ([10.245.245.180])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 05:05:33 -0700
Message-ID: <995d4ff6f8ba968c75ef3ac70e1dc0a60b6cbc14.camel@linux.intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, Christian Koenig	
 <christian.koenig@amd.com>, Dongwon Kim <dongwon.kim@intel.com>, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky	
 <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org, 
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Vivek Kasireddy	 <vivek.kasireddy@intel.com>
Date: Thu, 22 Oct 2026 14:05:30 +0200
In-Reply-To: <20261022115239.GY3008132@nvidia.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com> <atmurtZOhKwwGjV3@nvdebian.thelocal>
 <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
 <20261022115239.GY3008132@nvidia.com>
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

On Thu, 2026-10-22 at 08:52 -0300, Jason Gunthorpe wrote:
> On Thu, Oct 22, 2026 at 09:25:55AM +0200, Thomas Hellstr=C3=B6m wrote:
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
> Stating my restriction in a different way, the attach may start with
> {ualink, pcie} as options. Then we do the first map and select
> ualink.
>=20
> Then we get an invalidation and do a second map. Here we need a way
> to
> change the mapping type options to {ualink}.
>=20
> The exporter would have to make the memory visible on ualink to
> succeed the map.

That sounds like detaching and reattaching with a different set of
options. Would that be a fit?

/Thomas


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
> I don't know that anyone needs a very early decision, but mlx5
> certainly needs something like the above flow..
>=20
> Jason
