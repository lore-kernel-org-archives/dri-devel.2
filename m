Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1C606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NXzb5Rrj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F57111253D;
	Thu, 22 Oct 2026 11:18:11 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 942B411253D;
 Thu, 22 Oct 2026 11:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3FTTNFUHc7HCAkqcp6cc64LXPX4VNbdcLHTLm7uPCUBLeWp75r2A3V8yYZW0I54scwpYrsmh34ThLfbbB/7wkndxXTG1521feUk5d51dMY617jWg8NOBVED9h6TbxXrdOlRamX2bxTLcjEFyEAYu43SOlqlmrkHUdk8+XxzQp69Hd+p8C/pS+5FOb42U7VwYSe3IC+g4SeKxB9F0Ke3HbGiOvX/MjKQ6X9cfFzeuz7UYcoQN1ffQXOIOAA5VRJVXPoBiRmGlSRBPCCgUruAfco3ILI35JhWKhn2GKkCr7bWLsmRqdtnUVvIb/iOU/TgtJdJszzVaGYHTv0qKrgbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG1ouTi8qdQsUQtL62OYrnXPcwKNbhWuuvaSyYhSD2o=;
 b=jp0nC4NW9+t2RaDbmpM1lTpmXeQUJXW6j0C6BKHGVp0qoBEuO68S6/no/ws5bn9jUWq9CXUTGlXGjms58MdueG7v9XzAooQz7mZF1ejlCRGrd3usWin8IsQUzgwd/5tgvpB8051VBTt+8G5OQmVH+E1H6qrOo3nSlgas34/81YMLI5G3kZY/uU0G/GcpVLUL99JDGKycQZsW0wIe7ImCyP1glmq7B63YeE+ICsl8biuUTykNPkJ8wAwuKg3qtMXvPZdxewGGVfCGzCSFLlCOTHP+6uPRoLcvWK05s2lGqGXesxuydSyLGT7uDKBnHXwEnBLDatuCy9W5eJDST//zxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG1ouTi8qdQsUQtL62OYrnXPcwKNbhWuuvaSyYhSD2o=;
 b=NXzb5Rrj9dGMlATcEkGMr6m7Z1b9QEuXzUk4c3v0g3ziIlgKps06RZX1oQA0pJlPhMdgfgSU0iA2lSVxgj0of1LTCqsPKusawETHXPGGvGiGns8Ozngfk+gW2uDf3w4CU+JBQwnjEyOmonfDCNTLElhg6RiY25bsTwsdsqS85JtcMUpuMhuct1A9mIrQsw8iOuxMgiL2/cxjqPh0WjsRi437LaZJQ7ebefT/u/uLUL2urDKAiq9hksN0CohnK3NVjLIGGKeMSVGIJHfaiQu5hf7r4gE409eAC90BdS7Ss+GB5vzau5CbHhUPNPpRD2U+VMpi/R6fHjrUaW2j8ynCVw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by SJ5PPF4C62B9E70.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::991) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 11:18:02 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 11:18:02 +0000
Date: Thu, 22 Oct 2026 22:17:55 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, 
 Christian Koenig <christian.koenig@amd.com>,
 Dongwon Kim <dongwon.kim@intel.com>, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, 
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>, 
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, 
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
Message-ID: <atnkjQNkgXTmfecD@nvdebian.thelocal>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com>
 <atmurtZOhKwwGjV3@nvdebian.thelocal>
 <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
X-ClientProxiedBy: SY6PR01CA0148.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::12) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b225fc6-cc99-4c3a-af8b-08df302e22d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|261021121427099003|6133799003|18002099003|22082099003|3023799007|10067099003|4143699003|11063799006|261013131602099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: QALe4BDb8czNt7LqjPM4teIKv6XmOg9qxlS178bmnluzMESBfyV/9dQssurmFPLSKoLXJA36bS2bsSL6Re5Qk7qOl8D+aUysz0vvTywFsKgshS00Siifcj8drF/aUfoJHgNrF4JsU11WcnWQDNJw08o8m7NK2nQO/NLZBUu/3JoLFBJMRow7zxy6HWuzbh9vzxLZvY/m6KlJhuLUe2tthDYdtfhFUn9uh2VYvyG9OKmIH0/OzF+V1r2BrDl1INJCelULfIEBhkvgYw4GajswM6gGgfdSDYJ1X7cLwbXWW0ns6BVKeIyY7dxHPwffSa5WHZs2mgK2/u9hRTqbTLY2/3uWWFGuGoJOGQpvMq4YI0OCxnqGDYx9Huh06CkwaVtdes3q6A0jARo5gA5y4THtjXdVUZv7lqIFaBQ90nNZ7/cH5a5VolQnYoQsNYe64csEo2brdDJP3pdv6tKF6gHoR3lK1z1puBd8PGvnvZNLM7zLYaZGrGUz6x4Ov6dja0q3xOgSqixpg/bgVsy2qkfdhjPyR30yTzofF27loAcZSe4vPPaTStAm0tsoqs2tBNnE3AeeGnk5icxEn5Q+u4BJ2okDYafL7S9FVeIbbs7R5DoymmNX48+Bmo3iRjCYYH+E1OXsbEkrJh+tRjnFkKUM4lBnXUOsc3Ox4VwYDdMq+BY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(261021121427099003)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(4143699003)(11063799006)(261013131602099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?lKGySM+lL5bD5PqzJVmx7MIcoQReMDCHKAPo7/mB0hUM10ORrqDSkI41g8?=
 =?iso-8859-1?Q?mo1bVzdEfp/x9KulUbnIkrIWdu4ygEKs+clxT/mjQg/lNz25oiVg1nZL5/?=
 =?iso-8859-1?Q?EDDRVpXwmOub26fN/FyLJfXtTVwaQXPxhIt9tvSc31dWGX7BicmcrSD5CX?=
 =?iso-8859-1?Q?/Js0o/VtEkUCFghjAkY7RCG1tvMO+20EsNFF42yosfQRjE2Vs+oBZA5YEK?=
 =?iso-8859-1?Q?iyx77AZifbu5w/MHWqqm3XBSGDgxBcL47taNxKBFoQYWNmUckj/9wgkAUP?=
 =?iso-8859-1?Q?7CpI8c+o6HAr9lQBkc/4osl2Yh3R8kF+YZp4LOeWBf9QMakvgjGFCjtwWd?=
 =?iso-8859-1?Q?EqlbsTNlUYCBlURYGpKQPUqfG3IIO3xH5HCpdnCjkYvznAU/EtlKEJ07hr?=
 =?iso-8859-1?Q?lAzqhMRu7lmfNv/ZEwGN69H56yd6jcJ6GhQ2cdVERjQBQ1HloFAgDE7yka?=
 =?iso-8859-1?Q?Z8LC6P0adi98gpKzlyPRvhxojaHI+xThgEGqK7XYfgIJuczWpxjF5pZ0ZF?=
 =?iso-8859-1?Q?FRS9dSeif/ECUBpAg+qrQPbdslfJ7KR2Brf3sGqC5crw8eboihwLOtHMmg?=
 =?iso-8859-1?Q?soeAKEzXQmvGrLpak7G+PyMkuHo4x3mA/BHDasQbzwxBRsPd4u9oz3s0qf?=
 =?iso-8859-1?Q?+Df5U0RjSH/F+wryGZGFqux+wMvmFnMqy/7ZG+vBZu1vOXU4zdH4YTsGDG?=
 =?iso-8859-1?Q?NUS6P36UOeuCFJJSCXwGeDjEvrmr5NYhILCIgwj1LhKn5sCH5uI+7fWtQ9?=
 =?iso-8859-1?Q?K11LMJkCBpQB3xz9oOVOztAAMe/M6EtssS2qxxCxMWpILneKESXWX6pc6g?=
 =?iso-8859-1?Q?noze7Ug52jrSmvGTjw4oFVq4ouLgpWZLU+soTbqS6zPx6ZKpWEXNBdF85v?=
 =?iso-8859-1?Q?D0sLVyO6VgK+4of77VqiVLHMAdnorHwfmgJVZ48nOvb/9+llbYG8DmPDcs?=
 =?iso-8859-1?Q?Y/nDaUe2FIhtOc2lyFN09HxlI3FDhAFm8itB2gQJV9sQVXk8v6BfuNvs1f?=
 =?iso-8859-1?Q?q5qBLrQHhbttbIIPE3W1wcvRAE5IcJn6acCT61rg6Z236BYkYLoaVybN1R?=
 =?iso-8859-1?Q?juEdZ/n8WSzPXRWLMbZmuib/NBC7JAi9te5gkVg1FyP2erezQQynPE/IbT?=
 =?iso-8859-1?Q?b1zd906kCQnnjpuZItiVzptVSdmSzBpvNrEO+W+0tbw+ywpKgowTYam6Ky?=
 =?iso-8859-1?Q?+nFX7Y/AcS38R5UZ1fBy/bTZG3qjAvATB9SmSbGPgSGT83DHUqXdys4ciu?=
 =?iso-8859-1?Q?8wjQiIpGTFy4f6EeLF8dtQSWAQlgwRWmb2LVrKlpGdPbIIEOeYf28D7pE4?=
 =?iso-8859-1?Q?9aFVwIM3zgrPP2PrGVouPGYFmbNmfFqHBpIewm3Of4Uu/BSoVP54RpK7Hg?=
 =?iso-8859-1?Q?uc95GA5mPCVEXhs2JFzJrPuL8bsVdTEsbTDMq5WvkYum5eBDhf5NK2hfTC?=
 =?iso-8859-1?Q?A1wOuJ5P+hN4RNKiwZwAdE90qU66KqAIijqtjYc1GdQ9Q4qjvUG3ZXHKPq?=
 =?iso-8859-1?Q?uMN/DLu8RCZHHJJX58HQh/IRh+TfM7XA/hUdmZPsx0JR3N7fqTSnweJ/MU?=
 =?iso-8859-1?Q?Wo6hf01Q7mMWqmBnWEcqlU3h7pT9OhR0ytKe/Ki1Kp4wGldNMkrUVf0+1D?=
 =?iso-8859-1?Q?n1mirS48ad1JuNYz7sgN1bY+mxUEpOm2DcT1Av4uQojmzihenZyoUyM5FU?=
 =?iso-8859-1?Q?2ltlvf7HHKKoO8sOPx70WlEfzOqVfgf83Ds4DNJTFZbmgei8DlzOYF/cAf?=
 =?iso-8859-1?Q?XipBj3YXKbo6ewyD16l7jWwWURKUidTs8Roper5i1Dalq8/Ca9EQ1+OhMC?=
 =?iso-8859-1?Q?YtO2vB1kPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b225fc6-cc99-4c3a-af8b-08df302e22d0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:18:02.1446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPG741MURMIjqhByn5TlyVjQg2d2ad76mr71K7l0HNagr7qDGDtbGcmow9J6XGLU8nuZo4agbGzM68c598vD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70
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
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22 at 18:25 +1100, Thomas Hellström <thomas.hellstrom@linux.intel.com> wrote...
> On Thu, 2026-10-22 at 17:52 +1100, Alistair Popple wrote:
> > On 2026-10-21 at 23:37 +1100, Jason Gunthorpe <jgg@nvidia.com>
> > wrote...
> > > On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellström wrote:
> > > > > struct dma_buf_mapping_exp_ops
> > > > >    Base type for the per-mapping type exporter provided
> > > > > functions.
> > > > > This
> > > > >    would be the map/unmap callbacks. Each mapping type can
> > > > > provide
> > > > > its own
> > > > >    functions for map/unmap type operations with optimal type
> > > > > signatures.
> > > > 
> > > > Does it make sense to try to land this patch first, plus a
> > > > conversion
> > > > of pcie_p2p so we could agree on what the contract should look
> > > > like?
> > > 
> > > I think it would be good to focus on this patch as the main 'crux'
> > > of
> > > the series. The API contract is the main agreement. I'm relucant to
> > > merge code that has no users, so it woudl be ebtter to go up to at
> > > least through SGT.
> > >  
> > > > s/mapping/interconnect/? My gut feeling is that "interconnect"
> > > > best
> > > > describes what's typically going on, but "mapping" perhaps better
> > > > describes all cases.
> > > 
> > > My intention was to cover more than just the phyiscal transport. We
> > > do
> > > really want to get away from scatterlist, so having PCIe map with
> > > scatterlist and PCIe map with <something else> still ends up with
> > > two
> > > mapping types in the system.
> > > 
> > > This is why I choose the name over interconnect.
> > > 
> > > > Location of common protocols which typically carry cross-
> > > > subsystem
> > > > dependencies?
> > > > drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?
> > > 
> > > I'd encourage people to design more like PCI where the actual
> > > *interconnect* has its own home and there is just some minor call
> > > outs
> > > from dmabuf to help the matching logic.
> > > 
> > > > As discussed previously: 
> > > > Agree on theoretically possible matches at attach time, Match at
> > > > mapping time and guarantee the match is valid until
> > > > invalidate_mappings().
> > > 
> > > I was thinking about this some more, and I'm less sure now.
> > > 
> > > If I think about mlx5, in a multi-path PCIe configuration, it can
> > > move
> > > the translation around within a single PCIe path, but it cannot
> > > move
> > > it to another path without creating disruption for the
> > > application. This is a HW limitation in how the internal routing
> > > works..
> > > 
> > > I strongly suspect this will be the norm for any hardware that
> > > doesn't
> > > rely on decorated page tables to select the IO path..
> > > 
> > > So, while I agree we should support hardware that can fully change
> > > the
> > > path on each and every map, we also need to suport hardware that
> > > must
> > > pin the path during attach.
> > > 
> > > Probably this points to needing a 'pin' operation for the mapping
> > > selection after attach.
> > 
> > If I'm understanding things correctly we're expecting a change in
> > path between
> > attach and map time to be rare in practice. Therefore the need to
> > handle this
> > case is mostly as a fallback to not break things. So instead of
> > pinning could
> > new attachments just invalidate all existing incompatible attachments
> > on the
> > list by setting eg. attach->valid = 0?
> 
> I agree, (although I think the "invalidate_attachment" needs to be
> discussed). In the end the importer should be given a choice, either
> pin  and accept that subsequent attachers might see errors or accept
> app disruption.
> 
> > 
> > Attachment could also scan existing attachments to preferentially
> > pick matching
> > mapping_types that are compatible with existing attachments, thus
> > avoiding
> > invalidation where possible.
> 
> Current design appears to be that attach only determines the set of
> theoretically possible mapping types, disregarding other attachments. 
> Taking other attachments into account is also problematic because the
> dma-resv lock is not held.

Oh I see. Do you foresee any problems just taking the dma-resv lock to walk the
current attachments? If so we could probably resolve it with RCU, but I'd rather
keep it simple if we can.

> Looking at current GPU drivers, what you describe above is typically
> done at pin() time, but if some importers want an early very likely
> decision on what mapping_type to use, one could introduce a separate
> function that match the mapping_types, but that would be very similar
> to the map() function but without returning a sgt/mapping, or a pin()
> without actually pinning. One could reuse the invalidate_mappings()
> callback to indicate the mapping type is no longer valid?

I did wonder about that, but a callback for attachment invalidation seems like
it might be a pain for importers to syncrhonize with. What I'm thinking, which I
think is similar to what you describe, is something like the following:

1. Importer gets the likley attachment by passing a list of mapping types in
prefered order to dma_buf_mapping_attach() which returns the dma_buf_attachment
that would work based on current attachments and what the exporter provides:

attach = dma_buf_mapping_attach(...)

2. Takes dmabuf->resv lock.

3. Pins the attachment (if required):

rc = dma_buf_pin(attach)

DMA-BUF core revalidates the attachment is still valid (ie. by checking the
match again or via some other mechanism to detect the attachment path/location
has changed such as a sequence/generation number).

On error the importer can either fail or try to create a new attachment.

4. Map

rc = dma_buf_[sgt|pcie_p2p]_map(attach, ...)

Follows the same revalidation process as dma_buf_pin().

Thoughts?

 - Alistair

> /Thomas
> 
> 
> > 
> > Map time functions (eg. dma_buf_sgt_map_attachment) would check
> > attach->valid
> > and return a failure if a subsequent attachment/event had invalidated
> > the
> > mapping type.
> > 
> > Importers with invalidated attachments would then have to retry
> > creating the
> > attachment, probably getting a different mapping_type. Would this be
> > acceptable?
> > Or do some importers absolutely require the mapping_type to never
> > change once
> > the intial match/attachment has happened?
> > 
> >  - Alistair
> > 
> > > > > +/*
> > > > > + * Match items are generated by the importer using the
> > > > > DMA_BUF_IMAPPING_*() and
> > > > > + * the exporter using the DMA_BUF_EMAPPING_*() functions. Each
> > > > > mapping type
> > > > > + * defines its own signature with its own data to make the
> > > > > match and
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
> > > > 
> > > > Do we really need to add all global mapping types here? Then we'd
> > > > need
> > > > something for driver-private mapping types as well.
> > > 
> > > IIRC it is fixed size up front like this because of how the
> > > structure's memory is managed in this design..
> > > 
> > > If you want a driver private thing then I'd add a 'u64
> > > driver_private[2]' to the union and the driver can cast over it.
> > > 
> > > But this is the kernel, if you want to add an xe_mapping_type, then
> > > just add it. I don't know we need to do driver private things.
> > > 
> > > Jason
