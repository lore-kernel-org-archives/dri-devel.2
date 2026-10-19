Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9BFCCF2E4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C32510ECBE;
	Mon, 19 Oct 2026 12:43:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49B3A10E11C;
 Mon, 19 Oct 2026 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792413815; x=1823949815;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=238uZAb8Xby9vgq722b7Q+enZtERPQOtoIL6OY7D3AE=;
 b=ACqZDARd2XwG8fzVgwwSO+DDCxhI8hU2/XIVJPWDCYuDOBaNM3E/qnxj
 dqh98M1kL97yGBNwhU8ugOguJsxk/x6F704ICJln+XYQwKXhPzEug2/32
 KxrzgFrTQt9k/WjIsTRdGj3+T6bEDxMMWB/eO3YncRjMbAmYUzCVuS01R
 oaoSVSApgSv0kBBx9J8TK9d7aeNvEMeTG+o7S8vRhDRLp0YHD01K1G/oQ
 uyuQRvp1QIJ1mumuahpOz7rcxr6068xQTK8idd2IH5eRMns4k37AGTy/+
 9+BBsJIEwPJ4hK0QxurzAWihOcvqgR1NOq3gnUZ8eXpZVo/8xN9naYjfx A==;
X-CSE-ConnectionGUID: Wx2TDdxQT36s+oH5Gmpy6Q==
X-CSE-MsgGUID: O7yP3NeoRvCxwzBh0MWcbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1094069"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1094069"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 05:43:35 -0700
X-CSE-ConnectionGUID: S3iMLuh3RcmBMkb6/mvuVQ==
X-CSE-MsgGUID: Zy3Lz4VLRX2BAPtjuNm+OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2891613"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO [10.245.244.14])
 ([10.245.244.14])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 05:43:32 -0700
Message-ID: <8d4cb20b70ac4c3f36d8d631769757158af2ac8e.camel@linux.intel.com>
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Karl
 Mehltretter <kmehltretter@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, Dongwon Kim
 <dongwon.kim@intel.com>, 	dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, 	iommu@lists.linux.dev, Kevin Tian
 <kevin.tian@intel.com>, Leon Romanovsky	 <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, 	linux-media@vger.kernel.org, Matthew Brost
 <matthew.brost@intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy	
 <vivek.kasireddy@intel.com>
Date: Mon, 19 Oct 2026 14:43:29 +0200
In-Reply-To: <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <20261016202653.97339-1-kmehltretter@gmail.com>
 <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
MIME-Version: 1.0
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

On Mon, 2026-10-19 at 10:35 +0200, Christian K=C3=B6nig wrote:
> On 10/16/26 22:26, Karl Mehltretter wrote:
> > On Tue, Feb 17, 2026 at 08:11:34PM -0400, Jason Gunthorpe wrote:
> > > +	match_args.attach =3D attach;
> > > +	if (dmabuf->ops->match_mapping) {
> > > +		ret =3D dmabuf->ops->match_mapping(&match_args);
> > > +	}
> > > +
> > > =C2=A0	attach->dmabuf =3D dmabuf;
> > > =C2=A0	attach->importer_ops =3D importer_ops;
> > > =C2=A0	attach->importer_priv =3D importer_priv;
> >=20
> > I may misunderstand the intended contract. match_mapping() runs
> > while the
> > attachment is still zeroed and without dmabuf->resv held.
> >=20
> > Patch 11's amdgpu callback needs importer_ops and importer_priv, so
> > its XGMI
> > match cannot work here. Patch 12's VFIO callback asserts dmabuf-
> > >resv and
> > reads priv->vdev, which cleanup changes under that lock.
> >=20
> > Should the core initialize the attachment and hold dmabuf->resv for
> > match_mapping(), or should callbacks avoid attachment and lock-
> > protected
> > state?
>=20
> Right. This completely misplaced.
>=20
> The matching can't be done at attachment time, but rather needs to be
> done before creating a mapping while holding the resv lock so that
> the matching decision can't change.

So question is what exactly should the contract be?
Looking at the pcie_p2p negotiation today it looks somewhat like.

1) Importer and exporter agree at attach time what mappings are allowed
pending placement conditions and other attachers.
2) At map-time the mapping is negotiated taking all constraints into
account.
3) The negotiated mapping is valid until an invalidate_mappings()
callback is received.

Following this would allow a re-implementation of pcie_p2p as a mapping
type and would allow a controlled link-severing to send an
invalidate_mappings() notifier and the mappings to be re-negotiated.

Importers requiring an early hint as to what the actual mapping would
look like would need to be prepared to re-consider at map-time, with a
reasonable assumption that the reconsideration and re-mapping would
happen seldom enough.

Thanks,
Thomas



>=20
> Regards,
> Christian.
>=20
> >=20
> > Thanks,
> > Karl
