Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3B606A336
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=chud3Y22
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBFC10E07D;
	Mon, 16 Nov 2026 06:28:06 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56F410E07D;
 Mon, 16 Nov 2026 06:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afLs1xhRvSgik3pj4Q4AajAdfy0fmkyZZkzZmSciUZL6UpY525nxhxe7wdclMsax+YmSjdGNYCifBSe6DuitIgRAi3GKPGa7wJlhhO+faZweBY13tflKgt3wsQofh7AH6Y3d/lSum6OC5rnG53Xz4YE8vDbTmh5CkYEpK/2d6ZScLIqaDdgAvvTrSZYRpQau0fRA5lcBfHR95kuzruhYLL92UODZoxS7n9v9GMg5Eq3RYx9CL8tYYg0o5Mz7N857kXMmQXjxpkBbOonOPublP7eS57l5gKLVa4+uMnGEGF01pUmJZ35Cr2wAoRObok5016kzCjDJLESZucN7+/ow/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPn6zXiR1zdkW49ycBaHrxF0rY0XFOYMEdyhk7a0u20=;
 b=FrMdfA8ANJJy12uP1OziiL/2EM2JIBI9p/fhGjsA1Yy7FCACq8oreRFgrlf7+/r1iF7dfAlbuoxb5GPgFX59LNnCswNDRQcl/bruOGA75UwoZa9SeGHy3rrjdyG439+D6Js3ZOKU9B1G5yVplbFdfmpRsIx859m3vXTFm2B9YKWABb1bLZDCPQr2F49mqk40S9TPdq5yBqkhqLLj3QzdsXGiW7xZ8Jopa6R3/lmPmjM+ifMU8lItg8y6caZihbHNzuALAmV6ZYNltevo6LIypyx1WmaH2BQR3k+Ij4nK0A0WhizFAYr0FnjWhxfi24HdXND8LKulRumkM7X8sEOIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPn6zXiR1zdkW49ycBaHrxF0rY0XFOYMEdyhk7a0u20=;
 b=chud3Y22c2XADrRIIYsFyHmJm7ZAKw6jNoKqDc6Gm9To1eoKCz5XBEryuArbM0yE9eJ9kSiDFmo3PfrwJ44YwRx4RYlAzPGCj1wpuxHYgfmfJwKdf8CyUlQZ6LHNXMO7gaGAEoXw1PF9ar3HZd93iWgGTzK+Y+5S9FBNg8j/LBvGPeQUNpNrpzSlyK6QxbwMzG7OA74OE6LJkAj1q0dPA7C7aNkgswQ5uCrx9wH5uTDZgk0PccpGCIAQMs2wRFrE7nXJnmTF/NUc38IncgKMWxngv2cmNccajxoc4rGdF9ivJIn0C/y1qzZur5JGhvC/1U1oaQyLN2UjI8vFlYilCw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by IA1PR12MB6529.namprd12.prod.outlook.com
 (2603:10b6:208:3a6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 06:27:52 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 06:27:52 +0000
Date: Mon, 16 Nov 2026 17:27:46 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, 
 iommu@lists.linux.dev, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, 
 zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/23] dma-buf: Let the exporter select mapping type
 at pin/map
Message-ID: <avqgQ1k8zx0_N4rM@nvdebian.thelocal>
References: <20261105-dma_mapping_type_v4-v2-0-78b8dc9ae80a@nvidia.com>
 <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>
 <au7mBMbRC8q6NILj@gmail.com> <avE0QsqV5RZoaWc3@nvdebian.thelocal>
 <de268b0f-19fd-4e05-a8d2-e0f436aaedfc@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de268b0f-19fd-4e05-a8d2-e0f436aaedfc@amd.com>
X-ClientProxiedBy: SY5PR01CA0073.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::10) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1874ae-2af2-40c3-f1ba-08df43aabe1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261022105027099003|261022075727099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bFdaIHIv9Ay15dynOY+VnnnK7Hn6h2naHyxswsp9q6LbesERbNdu47kTA6RBM6dphBkUbVArKSNrATohgsgKcbYo7Ij81JieMk/OSK6DYeJGVoIKiSZ+p5QfhV08te+6MUst5zitIxmwhPn09ql9Cqsd0IXWkTFQKZ7U3EWe2i+BKiEtDcOQlQ4b/NAgZNu1WWisU7AWTrPRiVOqvvcMCoDEdeuwq2BJUIVF8nSc1zxPvTpih7y41btM42hYLD2HBuGEfy0renm+cNV1qX4kvwxr+vUwmhS9Ld524OK8uckpsXCluBmLQZI+HZEfJhV3oFuZ0iFhGyP3yuFHN1hsO3dBh8Cd43O6q1BVi+KZOvZUij00pECHuesoMzAewSOCHjofCVUaV1IQH2KNUFscnOM6cSW4/fKNhbRXwprrZRuqLy/0ZbKYNulTlqUd7Nwl706zjmFYXaV9GkLzEO1V2uTf1JbJhypPPLQdAPR0TiM3q0kD4ZVOuSH9QL8kBVm9tp0Z96vVtH2KNksU1u017rdborqlmKBxeslP7Bqakifs2PQBPz+OJXxzKanYiWBEQhqdqL831fQlXSU7TYFBWLb1W1/huwfFrJjvbHtzC+CK2X+3LynVOGlY3xLYgEBTi4yoSAeTMSGyXccd80XmYpp1vgtju2Sg/zpHfat1Gj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8qkTANP/E0j2bQ6SCpvScJALxn1sPREWvkLH7s9UA+iQC/+mAKXTn4TKiA?=
 =?iso-8859-1?Q?aVcS3mfHB+dIIX47egZJx3vwoC6Loh7iIQ+PHJiRRXngI3qhpAUzE6TCaf?=
 =?iso-8859-1?Q?RFYJZ11rF8kXaYUjmO3/C0VfblslLVOl9lgUk6kSAzIRDNiooEvtDOtyBA?=
 =?iso-8859-1?Q?rJAqZ1KxPRQKmkm53Stf++agEuGC/v4ER4gWNcgxz6+trQCS5Nf2pRZs7y?=
 =?iso-8859-1?Q?nr5Pc4o1TJ2937Jo1zXbc9aXtfQ7rC5i1c652pYz/hEYp9FqUfTTGi8NS9?=
 =?iso-8859-1?Q?arj996dYw5WpgZZDHalZOVU/ylvc6C/5C5d/QYStHkDwhbe0z9hFAhn93f?=
 =?iso-8859-1?Q?uixla9o9xz0BjI1/o+MwjCH7FOWH/EUSezGTFpF0oiAvcn5wONREKgXY1R?=
 =?iso-8859-1?Q?sELiEW4k8lxn3q5EpFO6bjqxLPEhNqXUSRUgqG5XhawBiVInnfZ7dU/im4?=
 =?iso-8859-1?Q?eK+izJPCINAM9JKg+b5ITDysSfSLCO+VAFwySI+5BBz0nOJm8q6WJCktxv?=
 =?iso-8859-1?Q?LCdYMGVxDaAYIfSOWwlDjO0NiHkvC7WNveVtvciVNQkwpyqAW9Nx+JA3tN?=
 =?iso-8859-1?Q?nTofwlT3Bxe+omolA47QGZF+wwoqoiiYp7hJr0gFC+JcuJgJ/zr0Ujpsyv?=
 =?iso-8859-1?Q?g4xqDUvHTfR6X5w5Heix3Vw5lJ/UszK+u370xw49+uw+TXWktnOkWuDygB?=
 =?iso-8859-1?Q?E2Do0AsV+0QdosoyD2ZTMZvrJSDqGmJAylJ0ShHkThiYpB6L4bO9Kj5e7a?=
 =?iso-8859-1?Q?67HY6BruEMnp7a5ku6U3vEsF1BTg13oS1YI3SO/U9IYIrp+DClVBDLpcGN?=
 =?iso-8859-1?Q?ke9dpzbXGaEWha+NPPjQIdstjmYzfj1c+BZhDbNIIQaMDoQyBZvoRAZsP6?=
 =?iso-8859-1?Q?WcmcU0Qbf9QqNWoHB2VWnyTKfjRAB9+0/mBaeYVY273TSkllw+mncJvgU9?=
 =?iso-8859-1?Q?6665bAKSSHzXbtXr6kL7V+jz11luLavvU3wttI/P/YcpfiSCJbp5EmG5sh?=
 =?iso-8859-1?Q?Z7aBi7zb+VsKyvC2hAmd3DiEJ8KlHWnS+DezxCYl/xCiBXwZpGBIF561T0?=
 =?iso-8859-1?Q?Zsr6sJJzR0CG6WurwsSGpaHXk6q65yL12njILk507Lg/6ZHMl6sI7FX1Lm?=
 =?iso-8859-1?Q?E/YTkTYtaWfZKZpZDqB5/7FhAeyIlwloEGMkE2L7GKJI2lVw5O6XcCv0Fy?=
 =?iso-8859-1?Q?IbwN5W+sDvoup4i7oUrT+T6zUeScc2C2OG0JRBWKdpJ0PMBgfwVYJueT/k?=
 =?iso-8859-1?Q?45jjbKuLObGz6JMGTKKAF9/e+67J8uaSnCWQDYQ7hEU2x595z2lY/g599P?=
 =?iso-8859-1?Q?TAiiDD/BiZpptbCNn6GwBzfsXdNEknfkk0Si3qLCzZSzNHw+OizPkPPTc9?=
 =?iso-8859-1?Q?UGoACRfZ7klemGt8JZQ9RxakhuP6CAToa9RPTF/+k/KOX3Qb2S713OsAgR?=
 =?iso-8859-1?Q?jCjAqeEE9cMXXG4Pq2IA7219LgaFtKX94scVfSX+PHCUJfhU6mIfx8Igc4?=
 =?iso-8859-1?Q?5pT+gTOLJPViWWXt2Pk4ytDTrD2UKe6t4eYe4N9kcbmhpLQoxNpS/Va+As?=
 =?iso-8859-1?Q?GhLEFGZBX+/4+YvXoXAT+a0jWwRmTaWLck33CjoyUNqhM9LFIgmYhwrTfQ?=
 =?iso-8859-1?Q?n9u96dq9AlQhSW9b8oofA79/+Q2ny9d6vuUWafdPQUKbR7uUU4tYupbRDK?=
 =?iso-8859-1?Q?2//y0EU3tAbZEZ0KXcjEL4XZ/zsFSq1WcY/YV6vi7D7sowhbH+9YLCBju7?=
 =?iso-8859-1?Q?midexDvCmMwMyFdxE83uPR9OUF1nTISFSOrh/rHc/8IcJ6n/Ybl4UQgelH?=
 =?iso-8859-1?Q?3i2i4D8EQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1874ae-2af2-40c3-f1ba-08df43aabe1b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:27:52.5528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGgLEuTOqPbeX/usVH3mWbP8leelJtlJCUyEL5JhWXo+h0QzEusLtKl+aBjPKIR/WpinYmT3RkmsDB5aX1nDrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
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

On 2026-11-09 at 21:59 +1100, Christian König <christian.koenig@amd.com> wrote...
> On 11/9/26 03:58, Alistair Popple wrote:
> > On 2026-11-07 at 19:57 +1100, Karl Mehltretter <kmehltretter@gmail.com> wrote...
> >> On Thu, Nov 05, 2026 at 05:40:41PM +0100, Alistair Popple wrote:
> >>> + * A pin or map that fails after dma_buf_mapping_select() may reopen the
> >>> + * choice only if it was the one that made it. A selection that predates the
> >>> + * call belongs to a live pin or mapping and must survive, otherwise the next
> >>> + * pin or map would reselect under it without an invalidate.
> >>> + */
> >>> +void dma_buf_mapping_unselect(struct dma_buf_attachment *attach,
> >>> +			      bool was_selected)
> >>> +{
> >>> +	dma_resv_assert_held(attach->dmabuf->resv);
> >>> +
> >>> +	if (was_selected)
> >>> +		return;
> >>> +
> >>> +	attach->selected = false;
> >>> +	attach->selected_idx = 0;
> >>> +}
> >>> +
> >>
> >> After dma_buf_invalidate_mappings(), attach->selected is false while
> >> attach->selected_idx still holds that mapping's entry for a pending
> >> unmap. 
> >>
> >> If a pin/map fails before that unmap runs, was_selected is false and
> >> dma_buf_mapping_unselect() resets attach->selected_idx to 0.
> >>
> >> A subsequent dma_buf_unmap_sgt() then uses matches[0].
> > 
> > Actually there's a bigger issue here. The contract at the moment states that
> > mapping type may change after invalidation. However that doesn't account for the
> > fact mappings can outlive the invalidation.
> > 
> > This could be dealt with by switching everything over to the generic
> > dma_buf_mapping_map/unmap() path, but that requires an allocation per mapping
> > just to track the mapping type.
> 
> You need an allocation per mapping anyway to identify the mapping anyway.
> 
> We currently abuse the sg_table for that, but essentially the idea of having a structure/object to represent the mapping needs to stay around as far as I can see.

Oh right, I see that now.

Do you think it makes sense to convert all exporters to return a mapping type
specific struct (eg. dma_buf_sgt_mapping) rather than the sgt directly?

Ie. change map_dma_buf() callbacks to return *dma_buf_sgt_mapping instead of
*sg_table and convert exporters to allocate that instead of a *sg_table.

I've taken a look at doing that and whilst it touches all the exporters the
changes are fairly mechanical in nature, with only two or three annoying
exporters that have slightly different patterns (one of which is buggy).

 - Alistair

> Regards,
> Christian.
> 
> > 
> > The alternate is we update the contract to say mapping type cannot change until
> > after all importers have unmapped. Enforcing this would require tracking the
> > number of live mappings/pins per-attachment, but I think this is the better
> > solution so will add that for the next version.
> > 
> >>>  int dma_buf_pin(struct dma_buf_attachment *attach)
> >>>  {
> >>>  	struct dma_buf *dmabuf = attach->dmabuf;
> >>> +	bool selected = attach->selected;
> >>>  	int ret = 0;
> >>>  
> >>>  	WARN_ON(!attach->importer_ops);
> >>>  
> >>>  	dma_resv_assert_held(dmabuf->resv);
> >>>  
> >>> -	if (dmabuf->ops->pin)
> >>> +	ret = dma_buf_mapping_select(attach);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	if (dmabuf->ops->pin) {
> >>>  		ret = dmabuf->ops->pin(attach);
> >>> +		if (ret)
> >>> +			dma_buf_mapping_unselect(attach, selected);
> >>> +	}
> >>
> >> dma_buf_mapping_select() sets attach->selected = true before ops->pin()
> >> and the map callbacks run.
> >>
> >> In patches 14/15, xe/amdgpu migrate a VRAM buffer to system memory
> >> during pin and map when the attachment does not accept P2P.
> >>
> >> That migration calls dma_buf_invalidate_mappings() and clears
> >> attach->selected on every attachment, also the one being pinned/mapped. 
> >>
> >> When the callback succeeds, the attachment stays pinned or mapped with
> >> attach->selected == false.
> >>
> >> A later map/pin on the same attachment can then reselect without an
> >> invalidation.
> > 
> > Argh. Thanks. Will fix.
> > 
> >  - Alistair
> > 
> >> Thanks,
> >> Karl
> 
