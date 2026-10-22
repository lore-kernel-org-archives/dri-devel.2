Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B5606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CZP5dgKr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11FC10E370;
	Thu, 22 Oct 2026 06:52:36 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672E211234F;
 Thu, 22 Oct 2026 06:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehtOXODKXjv0Nrf8QVcFAF7I3nidokbDlAxo8PTSyPg1dxTlQfJPmY1NhzgNDGMVuk6ICUdTScngz1CY83GJNqjRFKDAbdrZgDfyRHJNJwqc1I+iQpoqe6xCEeBsU5D6EtqEi/8TcQ3qEqgqUn31yX2bpnl31jYKqWD9UIdj6XH5jcWVPbyz7nYOphjIZVJnVbyNKjMKgjFlx42NgWWJE8h6zyoZ2H2ec4MGjpsjAcdRgsVV61QbZk1F56ifrQ4cibk29psqURmPnXK+eBDcjmEzviYFfk9c3cqXSU1rYmAXkmWudUEB/QsMr2scCNeRLkpY5qcgvhpzvGmK3xUolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0b9zlm6SPwgQArXZ4kyOayjUfGv5dGaoN9AHJizBtQ=;
 b=fL5Kw1tx812UWSuoSwrsjNM1k1CHoksyuqF7XNBuSCsH3BN0LOGugaLTdxJAU2qiZfb3o6//WNnXCTqg1/gMEFXc7H/tR/G6Hc4Io41OVJh7D//1++WdSkqcUJ8bkbGIAn4+xIEkF0TnIXNAhkv30yWMTBIPdxXyEpb8aruHtC6BpfS9N8NWKE8XQdo2Rrf3rx4ZU9oMbhvrqR7NODufjI/5zcXY827wDeHj3R3pLEDgu+CShoF9tCRp8QR2/HBcJq8J8MiQZwl2mzpU2PllCps3lakNvXr/y+bXoa5nI2Vvyh1cI5wCOvjOY0h93KJ3UQWF8wgm6ZoYXei7IE26rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0b9zlm6SPwgQArXZ4kyOayjUfGv5dGaoN9AHJizBtQ=;
 b=CZP5dgKrYoazrBXF981PSD1R4JMgGxYpJENUy3dYiZ9sMUyMAyFuRnkeBQfHh8260ddHKKPnu+KzdLyFAz9h5nb8pb+HeHIikQ5Ovm+EUBbQkJh+Nk+OSSS+C2bj85aQfiREATvuApxgESXuHrFz8TSGEmrYOYDvwTaER1/sXKRCygn0GoSsUX6wNLKYdJ9iKXqO6dx5x28H0XN55DfsvXvtDsHggdcxrxxM1AvcFsbBWKL5cSKuwwkcuRIbeLl+y4kfjgcTzyzqCmQ2PQMCPOVofcKiykWJHQl6n5s31De6S1J/qq8LZ6KJ1At8hiqsKYQS02evtTXerKQ3Fpu/Ng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by SN7PR12MB7250.namprd12.prod.outlook.com
 (2603:10b6:806:2aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 22 Oct
 2026 06:52:26 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 06:52:26 +0000
Date: Thu, 22 Oct 2026 17:52:20 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
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
Message-ID: <atmurtZOhKwwGjV3@nvdebian.thelocal>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261021123755.GL3008132@nvidia.com>
X-ClientProxiedBy: SY5P282CA0050.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::15) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6a5648-b3b4-4009-22cc-08df3009083f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|6133799003|18002099003|10067099003|3023799007|22082099003|4143699003|261009223027099003|261021121427099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yopg5lQOVH/jS3DdjPo2Z0bB0A4M9elO/8SIS1YBTxmiKJKHVSazvhoGeMljLTq2AVQPWIWDf4cGhdpMK9jN8VdWoAohsnRGXVmCmfcPj3ViZo6pbpXqE9t8UClljEjXqb04k/L2rx9HT4mvye7ArSBePyFFePmpkptm0HZi2tISJ22xZO2TKs3MiDHj1OkGFdnxOyemckhOHjYb/OHQJwpjLPo4OWEMbg1o86ESgz6m87BRNWQ583F9UGVdW9Gl+FoFmGhebCT5C/lRrRylrtKlfGJWqzS0HYwLCcdu66q2lPvc9fGtbiYvf9LgDAVABlJ7G9w7XfwzA9Hz2s/n0kDpTCGsKtoO5vGXRV/fHB9fB2QHvS70shr2OQqahHbhAshbByKsXxJue/pk3zHfMfoB0DHeViKCS5+qzV6oyN+cwIJSEcoZTt0vbWrmOlS4RFwF/TJerUQxDOPdkR9+WclSN1natV0XmiC/dbg1DfyPFuBx6n35aLNJrlBOKKre/HTYvqRI1mQtxLtzQMZV5dmCUOWsyCSm5zXCurmZTXojS0dVVEv00OLoZ0C4rk36dw1r/zRWl2xTtfqQFkQ3gVJDQgdOBlJAUMLmca0374N3DAiZqBmf28cerEqtBiqR5Degr/aFe6l8O9q7RyyzndhLWkeIZOHmoGxIdXa939Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(3023799007)(22082099003)(4143699003)(261009223027099003)(261021121427099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3dQrZXgZBLBaALfxm7F1UoZWI10WBfYglwJ+vashgoR9DUGjn1JJKZF7eQ?=
 =?iso-8859-1?Q?6Dc0ppsrE6PtCYwcNfZyGsXtg9b7eOg4O1WEQcQNoM2LFt3Ktf6BTUkcYb?=
 =?iso-8859-1?Q?MkU0itj4xJGsy9NjFlFkjj1LU7FSXW1hTwmdQgAvMysFDQMvalJqkALnNZ?=
 =?iso-8859-1?Q?g6K5kJQkZLp3norgEm3Eds8jqq5sct9dWH27V7/Nzdy/7yWpGl+F82BOjB?=
 =?iso-8859-1?Q?KenbW/7qfUCXiuOyU/UR5iLPrez+yxW0nu3b9IsRlIG4ScNwMNVvGvETcx?=
 =?iso-8859-1?Q?26HYwSU3zEUbRE873DW4PY6A0JP1KmQDwMGax18PJGFdxg9PXDoxNV2LxY?=
 =?iso-8859-1?Q?+5NI6GXTyRPGfXuGDCc4XwJXdGi7NSueeUP1tKx1iuUyyA70XaRj0y4ret?=
 =?iso-8859-1?Q?OfpopiGYOI11OiDHFVnp+vOjoQXTx/cc8Q7uhkXQIR2VQ3OIDcb077DjGz?=
 =?iso-8859-1?Q?//yqP2NUAKxfnOZUKC8gJOngzOk1kMaQ/4UZdBI5KRT1wjQ0CNdUWSSkNe?=
 =?iso-8859-1?Q?a6/s5Tghbos4ji1syPHwksWnghQ9xDW0do8kKjTCSihmvxV/b9slMTEqNX?=
 =?iso-8859-1?Q?rHRkhK1dgXzEzSDGOUOmgDF9vYXfoCSTkwj70hV4Ebk9zWSdzF90FpijwU?=
 =?iso-8859-1?Q?VjAaQ/qqDJIZ3ULG5Gv3RDz9FHyYwoIWpD88jFWrfDl3250AxGTOQd+JmH?=
 =?iso-8859-1?Q?8CyR5AwvbJRwXbm7SiayPo8Gj+74A/W45Cf8xJo/mNcQ+5PFji/Bh1Bxuz?=
 =?iso-8859-1?Q?vVzZ8QKxuRdDLlhitbGVYUM+aSMHsak2cDTfjs6p48jFMI362iV/pj/Lq/?=
 =?iso-8859-1?Q?+++fR2/Q5x5+A95fmLtvTmo4qNsf6YZ3ZA7yNwvXNihLzHQaCmn0uvz+ma?=
 =?iso-8859-1?Q?CZy+RpUgHqvDw8tf9zUJdZVvOszLl2dQJfEsI9YeY242AGKpBxkg69KzBi?=
 =?iso-8859-1?Q?6CUwbO2fNKOJoaOnEb3ZdW/3IsFM+ZAJbuv5wuESd/rTKvrCt4rAHvAHXd?=
 =?iso-8859-1?Q?Wx5fL2sFsvABy31W9WdZujl9TtEx8jE2/OzLPtrOSC8ViY3u2uyNwo1Ug1?=
 =?iso-8859-1?Q?nHD74G7EatDuoZTd4UxVmUrGo/hz8m7B3JJdhC+7S83l3BgjsK8QIUPyo5?=
 =?iso-8859-1?Q?/aO65aqIjUC53Rz2ey6SFopOaqnwjrYnXTK5Un/ls2sBIvQ52y1QKV0r0r?=
 =?iso-8859-1?Q?gg8npmyftLigIrsCnBxR6wmThQU7pa7hSgKS5bFAMFekPXttIo56r5Mm6B?=
 =?iso-8859-1?Q?z+cFDeCmTZtOfMcF7E+9VhlniOMIAVPvDqnpqOSrGQ5vcxUjDRGMvUTjO1?=
 =?iso-8859-1?Q?+ThBQHkkNb7OyrEsLN9AG3v6H6Kostcs7CNdMrE+97iGBkFA95ADmD1BVb?=
 =?iso-8859-1?Q?W0x+FnPcyYsL4iRcB4beeY7Ob7qLXRUdDZ1qs5MZ9Wi0WD9MN6lTsDp9/Y?=
 =?iso-8859-1?Q?eChMKy4AxXwk3ww45F3ar2GgjubHiLVCWVEN4yTTHqQY+gFLnMrzDPIlQC?=
 =?iso-8859-1?Q?OcivUXjqNBqrobjvUDmn7FqMUxGwoR8s4kDuDmuRVAIUzUEmD14yRQSpW0?=
 =?iso-8859-1?Q?HnmX0D6UwLIkFQREfN6V7sy8/bOsrJJ9FSXpOxtsKZAHkERChh+G2mZOyo?=
 =?iso-8859-1?Q?LHJSsyw4/GhS9l8L1C/Vr+ypzABuSRerAHPJlwWz4Ub1PMaQotpWR1dNGO?=
 =?iso-8859-1?Q?oxSG2IxzC/sXu4gPoD+rsmSNQnrCJFBLZFjvmhZfWI4kStxonRlpvNlbxw?=
 =?iso-8859-1?Q?bmokgbq+zS+4NVNiA5sEkQNNhNjq5f9BenIeBq2MHnu38iTD+hJsox4d7C?=
 =?iso-8859-1?Q?O8t6+9I1Kg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6a5648-b3b4-4009-22cc-08df3009083f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 06:52:26.1736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVRa2ylrsrNC76wfwJU/AeU6uvFTYW0n4MTZnPqXjZkoiTOmyLRlXJc2jAPcvYaR+hRulterRR+YmJiukbBEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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

On 2026-10-21 at 23:37 +1100, Jason Gunthorpe <jgg@nvidia.com> wrote...
> On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellström wrote:
> > > struct dma_buf_mapping_exp_ops
> > >    Base type for the per-mapping type exporter provided functions.
> > > This
> > >    would be the map/unmap callbacks. Each mapping type can provide
> > > its own
> > >    functions for map/unmap type operations with optimal type
> > > signatures.
> > 
> > Does it make sense to try to land this patch first, plus a conversion
> > of pcie_p2p so we could agree on what the contract should look like?
> 
> I think it would be good to focus on this patch as the main 'crux' of
> the series. The API contract is the main agreement. I'm relucant to
> merge code that has no users, so it woudl be ebtter to go up to at
> least through SGT.
>  
> > s/mapping/interconnect/? My gut feeling is that "interconnect" best
> > describes what's typically going on, but "mapping" perhaps better
> > describes all cases.
> 
> My intention was to cover more than just the phyiscal transport. We do
> really want to get away from scatterlist, so having PCIe map with
> scatterlist and PCIe map with <something else> still ends up with two
> mapping types in the system.
> 
> This is why I choose the name over interconnect.
> 
> > Location of common protocols which typically carry cross-subsystem
> > dependencies?
> > drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?
> 
> I'd encourage people to design more like PCI where the actual
> *interconnect* has its own home and there is just some minor call outs
> from dmabuf to help the matching logic.
> 
> > As discussed previously: 
> > Agree on theoretically possible matches at attach time, Match at
> > mapping time and guarantee the match is valid until
> > invalidate_mappings().
> 
> I was thinking about this some more, and I'm less sure now.
> 
> If I think about mlx5, in a multi-path PCIe configuration, it can move
> the translation around within a single PCIe path, but it cannot move
> it to another path without creating disruption for the
> application. This is a HW limitation in how the internal routing
> works..
> 
> I strongly suspect this will be the norm for any hardware that doesn't
> rely on decorated page tables to select the IO path..
> 
> So, while I agree we should support hardware that can fully change the
> path on each and every map, we also need to suport hardware that must
> pin the path during attach.
> 
> Probably this points to needing a 'pin' operation for the mapping
> selection after attach.

If I'm understanding things correctly we're expecting a change in path between
attach and map time to be rare in practice. Therefore the need to handle this
case is mostly as a fallback to not break things. So instead of pinning could
new attachments just invalidate all existing incompatible attachments on the
list by setting eg. attach->valid = 0?

Attachment could also scan existing attachments to preferentially pick matching
mapping_types that are compatible with existing attachments, thus avoiding
invalidation where possible.

Map time functions (eg. dma_buf_sgt_map_attachment) would check attach->valid
and return a failure if a subsequent attachment/event had invalidated the
mapping type.

Importers with invalidated attachments would then have to retry creating the
attachment, probably getting a different mapping_type. Would this be acceptable?
Or do some importers absolutely require the mapping_type to never change once
the intial match/attachment has happened?

 - Alistair

> > > +/*
> > > + * Match items are generated by the importer using the
> > > DMA_BUF_IMAPPING_*() and
> > > + * the exporter using the DMA_BUF_EMAPPING_*() functions. Each
> > > mapping type
> > > + * defines its own signature with its own data to make the match and
> > > attachment.
> > > + */
> > > +struct dma_buf_mapping_match {
> > > +	const struct dma_buf_mapping_type *type;
> > > +	const struct dma_buf_mapping_exp_ops *exp_ops;
> > > +	union {
> > > +		/* Each mapping_type has unique match parameters
> > > here */
> > > +	};
> > 
> > Do we really need to add all global mapping types here? Then we'd need
> > something for driver-private mapping types as well.
> 
> IIRC it is fixed size up front like this because of how the
> structure's memory is managed in this design..
> 
> If you want a driver private thing then I'd add a 'u64
> driver_private[2]' to the union and the driver can cast over it.
> 
> But this is the kernel, if you want to add an xe_mapping_type, then
> just add it. I don't know we need to do driver private things.
> 
> Jason
