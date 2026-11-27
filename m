Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4072606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iGJhuIMe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B4410E0AE;
	Fri, 27 Nov 2026 04:10:21 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CE010E0AE;
 Fri, 27 Nov 2026 04:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDsrVj6ps9/Ed5wNGIpH7tfLFK/8pYpp1VxOI/Rv57ywkqrHLG7NOlfJjKRqkYv23zX/LWN7IxbMVRzOh5lOEWmF92K04jshQvXsPJAOWWTixEH9fT6dr8QUOkW2DD9E/ORq8KAQOxUzPrZnwQ0yHdKMIJ+wHAYtba99Hb5VrEllVc3LYTaSBDRzaK6kNkyw5Qnq/tWcbKUA3LAPb3myC0FPqldCtQKYKNOXCV5FtI1p10sU76R5QH4gROIgkJGWpMXRMal55qTU+YspB8NxtIf46aFlv9gL2Kp1XHbaCA7qqGdDqUbT9XE6BPwTIh17skyWQxode++yFg/S6ReOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYuk9pixKcgOMz4JXVNGssmBBmziMxDyOPR47RrLA/o=;
 b=gcI+iyoNv9IiOgMSVkpcV+nleE86s3CDcwjJ6bDbusKx5RRWjLZUJxsaVFyVYLvpzs/xBAloOveYrKODpY+D5Q3blUJDy6rI82t8LM0IFWKSLAcCieGsrKuar8uZ1fGna4R67H4sqcsBTHH0DEHMoLGqUNLx+HKJGztdro1oHpKhis/1YNsW1axxgsLDAcRBs4vQhtHnPr5ppkECbClKwaJrxnENZTzGbppUn+phn0PJOd+afeU0LjWlUbjPlYdrOQcJ41LgZwwOx3U/H3fFIb3oS1l+Bwdtrsu/I5qsoEFygrva0kwc5YtrR0q5OBcWVucOtiiCtuSgkJiK5PbVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYuk9pixKcgOMz4JXVNGssmBBmziMxDyOPR47RrLA/o=;
 b=iGJhuIMeqBNXN4SBeSRHtOpAOU4qYWzXPB6aFIJL1ND6Dwq54BE5UXFO4VOSuZH0eNhgaEYk1XW4kte5uvCaWBp+WDWAVuvtxBafx0TwSdOTFgOfZkh7sXvUNVsn0/s4LmEQsgJkPkjnBsMG6/WBIwuAM5gQEgL3TP/mP/5rC8rGBYcQ+xCdozcAlLtxA/gnQ+JO9lnHqP7g12uwptk79nMjUqcjD8BzduT9AcVoAjoLjAtDLuufn/4x2m8n5ARB4I4uqqzcxUpMuvk3i33yCsG5pAK1dkjbw+x2RiHTx2UDZlfnO4ocjcLAP4q1gJ4DdzhN1PKEL9a2g19UuJ53mw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by SA1PR12MB5659.namprd12.prod.outlook.com
 (2603:10b6:806:236::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 04:10:09 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 04:10:09 +0000
Date: Fri, 27 Nov 2026 15:10:03 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, 
 zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com,
 chaitanyak@nvidia.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <awkB4CYbM7zHJNMw@nvdebian.thelocal>
References: <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
 <20261125155559.GL246011@ziepe.ca>
 <5fb8bb60-7d9f-49b1-899c-40a890fdc14b@amd.com>
 <20261125190705.GN246011@ziepe.ca>
 <awfMy1d8ICL6mr9i@nvdebian.thelocal>
 <a8c00bbf-dddb-4207-bcdf-af58d27116c5@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8c00bbf-dddb-4207-bcdf-af58d27116c5@amd.com>
X-ClientProxiedBy: SY5P300CA0074.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::13) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb97444-4411-4a9a-6626-08df4c3c533b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|261022105027099003|261102123227099003|261026140227099003|10067099003|4143699003|56012099006|11063799006|261026121527099003|261021121427099003|261021123027099003|261028144727099003|261102130727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2O7gLJ1yYm4U4fkXK3huGNJMTK9zjxBB+D+2Dc5V2W5HmfGt9rm+gQFxMTi1B+mu9LLipy64kQKk2zseVLvARCuZBmJr4P791xHaJV+zFC2GNaGMfjTrwJ4s3oI0A18HFRZRgxceQswsFfxvLdAisBRgyVfclmzFAC9i/ZNzao0J11FuQxnWzC+gBOeX5PZ59nzWc/GRlv5YZLAowP05tzrcyxugmOIcdF0kh9xg5xHbuoyIgWMB/eVl51xxyUFfyS9jDOde4rVpDCnB8zN2vXKWwFV879yDCvPSx7GDuO3IOEBFpz2cZu3jIALzNddTm0j5DxkeIX5UschFrIOSDy0mMLtdYlspacVjFFKfIdYIE/ecZE4rZvFo7/O3Yhurv2jWHfda8TVjH+/ikwP4BhjIA2pU0F1yUNcW22nHG561Q39iybEptjsTyYbBvaWmfL18z9soWlMRcJ2SFuMCiuPE62heiNBksxe8ARN9raKmULNPWuiK7O1WWMXiEnWU+SQFyhRNj/AAy7Md7cjIpnh0BcSVh5gjiu+a+zVWcAfvyIMp/2gXW2ujKjy4yNlA1U5I9P8k+RgpoX8BAMN+CQUa0W7t74FdjM1JPV6RPJbb+9gCI7y+NPIDEvtzAiU/5zhto+WUXY0dlJKAICR3b5FaSti/dPunj1wmakA3Kwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(261022105027099003)(261102123227099003)(261026140227099003)(10067099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261021121427099003)(261021123027099003)(261028144727099003)(261102130727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?FkxrK5ULGz4xlVPryrsy62Sc99ip+6+M5CFEcKtmHBHgXkoe9tzQ0Ve0GS?=
 =?iso-8859-1?Q?VayLF4Qi1dn3BLLw0NfMpAlQwPM/QKPtabNl/CmTuL9g7BFMpZKdT58TnG?=
 =?iso-8859-1?Q?7oHumDdqOR/SUsfVlBQv7BG/umaZTy3XMU1ki1lsYQodapo3wRLuYZ5kOk?=
 =?iso-8859-1?Q?3DLIVq8GQtAkeqUeHkdK7tQTpOuFkQ6aAkQr7uPUebZgNB7L3gtAxbbrNg?=
 =?iso-8859-1?Q?/V/bCuVP+GBK+HUacr/ayAq0mkKrcwCTX51gOdRc3lhUK1yFB0BKuXczHP?=
 =?iso-8859-1?Q?0VVoyesn3JEAM0epJBbqmf9p1H5LYHIRHPk/UDNUe/YMFAjQrzqEvmSJ1g?=
 =?iso-8859-1?Q?J3fh7PK1uCcnxeLvtbFEAXql3BrI0xt25zn7ENnqmSDCUJ9M7EnlntElLx?=
 =?iso-8859-1?Q?Yu8VR+3OXIiq8KRdAkAMDJRGyVQ/jY7+YfxMjEP147NPmNmvzCGRW8MxBq?=
 =?iso-8859-1?Q?UiOd0FLDXt/Si+1iZQuqaILXjdcwhbJkLLadTxO8leuvcOLBEaFwwOK75o?=
 =?iso-8859-1?Q?oznM4PxsKzNlKdzS2u5IcnZyVwmLNk0L92z06rRCx4vnygjH+7SHxUFhii?=
 =?iso-8859-1?Q?dbOJZYhzRlyXA/PcA0S4Fi2xxKorX/ldCg0ethFJjQ6KR/6JSpCJ4cwhCc?=
 =?iso-8859-1?Q?vqgeO+iA4i7tJ+h07YdINDOIYYTqV+J7fEUNmiewcmBXW0yFqE6pIzqble?=
 =?iso-8859-1?Q?vNoc3fMTXIfDViu4hrpdnoQ9HZRqkDlRw/aob3uHWPZzkCDoK6lI0P0gFK?=
 =?iso-8859-1?Q?GOJVmaJKdrS+7fbTLUbsT5P4/fYd3B7qq06j9MxeY8xMy2aJ4Br3ma0JTM?=
 =?iso-8859-1?Q?f6pI80ofYvrm/10GIoAZoT5kW2bJzI6rrKXw1+Vv39Z0y+Hi+FVXbBTmln?=
 =?iso-8859-1?Q?oBtbcfaVNzpCWHSpZcLBXN47FpaJ+Sh/o4bbiaV3nYuOyyGibMQLo8DBnn?=
 =?iso-8859-1?Q?dijV5P50pAScZQ4B0lYi1oz8QZEUAVJWpuSeD+1THiaVBw1aainwgQY2aI?=
 =?iso-8859-1?Q?ZTzim2396efKnDHP6FQ976wURHysWhjg4IuBhbv8olcFZfmgpQsVkk+MJd?=
 =?iso-8859-1?Q?avyWnnRH7sHKtSpL92mqjO3urSdJkld+lPRvEgv/ekLBMSbaACNkZQkHZn?=
 =?iso-8859-1?Q?OHSvBao+jZxl9xUDs/WcG/QI8x1LVCJGpbWIVQHE1Bcx4HElGFiDC3lOod?=
 =?iso-8859-1?Q?c0BzdqyW7Ef4EKSy2QIo2xYcbiS87T4+5lJ+9iLH1r0KSz20mv0zoOy5xO?=
 =?iso-8859-1?Q?80xO/wVFC1/pvpLDHd9U4M3N23iZaWyhAokqx3dUateLZz7w8xCBC4QTSh?=
 =?iso-8859-1?Q?WkDTZv+c00weZIYs2E8Skoq/TVh4B2wPp452S72tfTwJkCuy4Ml/KmP5H2?=
 =?iso-8859-1?Q?LQGFOnAqIKVe0ORw9A9LmP8YUPbb4nTiSBG/28EvqfgOgoDbcOtYH/A5Xj?=
 =?iso-8859-1?Q?+G/nxGq++WEzfCSYeqR/DkdrMmUgVprEyTo1q8rivITbyq/I5JkJb2Ff8N?=
 =?iso-8859-1?Q?uH049mrHuxHaEZXJaaR52LPf/orrYY1Ajq4iqHE/J6wo66eES86H3nF9pM?=
 =?iso-8859-1?Q?LvsyHIyMkoNVz1ixIFHovRnsTiR7vAToCidpi2lrWfjLvEB2dj/OBzGsdi?=
 =?iso-8859-1?Q?laBZ81PMpg9BjzFusg6g8GIroWSNxE/+0cvRtz1ykBbp4oHaP1UAtKDSnH?=
 =?iso-8859-1?Q?fMgfq/dXzKpqrKNZ2WJP7obIUNbL9NNaJnvUMXgJCP2wlZF38OmQiDBSsU?=
 =?iso-8859-1?Q?NKCPoNuSS59avMDoy2R1FO3SlifmK2hhpGfy6ZHbE4fhzDNOev39VUWazF?=
 =?iso-8859-1?Q?ZdHckWFzHg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb97444-4411-4a9a-6626-08df4c3c533b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 04:10:09.0525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEDkRJgXF2aWDh+qOQkuc9hvlvlT5TxN8VS9KbWQnDnyjLN42sKz5mpzpCRkZWmP9LN3zcw2Tu9ebZPFlvzu4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-26 at 20:58 +1100, Christian König <christian.koenig@amd.com> wrote...
> On 11/26/26 07:24, Alistair Popple wrote:
> > On 2026-11-26 at 06:07 +1100, Jason Gunthorpe <jgg@ziepe.ca> wrote...
> >> On Wed, Nov 25, 2026 at 07:17:51PM +0100, Christian König wrote:
> >>> On 11/25/26 16:55, Jason Gunthorpe wrote:
> >>>> On Wed, Nov 25, 2026 at 12:19:08PM +0100, Christian König wrote:
> > 
> > [...]
> > 
> >  > > We cannot disconnect this from the DMA API, ie to use an iommu domain
> >>>> or ualink, if exporting drivers are hardwiring calls into it.
> >>>
> >>> Well the plan is to not disconnect it at all. The exporting drivers
> >>> just says to the underlying API here is my buffer please map that
> >>> for this importer and that result is then given back to the importer
> >>> through the DMA API again.
> >>
> >> DMA API will only do basic PCI DMA mappings into dma_addr_t.
> >>
> >> It will never handle iommu_domain, it will never handle ualink/etc.
> >>
> >> Give us a plan for those if you don't like any of these ideas.
> >>
> >>>> Fundamentally the need is for the driver to get the phys_addr list,
> >>>> exactly like today, and then pass it to an op which formats that into
> >>>> the right data structure for the importer. Be it dma_addr[],
> >>>> iommu_domain, or some ualink_addr[] - or whatever.
> >>>
> >>> No, the phys_addr type should only ever been seen by the DMA API and
> >>> not by DMA-buf.
> >>
> >> Again, I don't care how you label things or what "library" they live
> >> in, I can't tell if we are nitpicking names or what.
> >>
> >> But there needs to be some kind of abstraction that takes in
> >> phys_addr_t and makes sgt, dma_addr_t, or iommu_domain depending on
> >> what the importer needs.
> >>
> >> Exporters must not open code that.
> >>
> >> Obviously DMABUF is involved here *somehow* since it is the only thing
> >> that knows an importer even exists.
> >>
> >> Would you be happy if we made a 'dma mapping for dmabuf' library that
> >> did all of this and DMABUF just passes its type opaquely and drivers
> >> just call its tightly abstracted functions?
> >>
> >> That is the component Alistair is proposing, he just prefixed it with
> >> dmabuf_* as the namespace because, lets be honest, only dmabuf needs
> >> this weird looking thing.
> > 
> > Right, I don't really mind where and what things are named. I'm fine with this
> > being a separate library somewhere or building it all on top of opaque/private
> > types. But I'm having trouble understanding where exactly the objections lie and
> > what the path forward is.
> 
> Would it help if have a call on Teams or similar services to discuss the whole thing?

Yes, if you're up for it I think that would be really helpful.
 
> That might be easier and especially faster than by mail.

Yep, especially as our timezones are almost completely out-of-sync. I will reach
out privately to arrange a time.

Thanks for the offer.

Regards,

Alistair

> Regards,
> Christian.
> 
> > So given no one outright rejected the plan I wrote earlier I'm going to go ahead
> > and post the series implementing it (I was hoping to do that today, but it's not
> > quite ready).
> > 
> > Hopefully that will help by giving us actual code to ground the discussion on.
> > 
> >  - Alistair
> > 
> >> Jason
> 
