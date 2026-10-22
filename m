Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3217606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Af9/KSV/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2440F112397;
	Thu, 22 Oct 2026 07:20:39 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6F1112394;
 Thu, 22 Oct 2026 07:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJAB5X3lcBe+yYelZMWC299HCLkoL9rWuLn6QWAbagvz1Udkd0sP1Upjubd/uGA95RfkCWkY7+X6hTU+m1jVDSN8l2ew69JIPEmQWRHl/Ey3qUsnslIaRQDfhweSrdryzpauilVHBkOXT/XvDWKgJpJoHBMsYADI/nALAeD55Bm5laRz2hpaoJPfSXfysP6dUgR05a40GjSuwNhkcLonXpFcL6JPK3/5C26RDynzYTe4ls2eDD2DMB3VFpVHDw2+Z0zJ60yZ8ryYWAbXNmlDwAMeO4qiEGZYKOco0cOVDUgy37pqo80Pe2LEaqWV+qMNXkmgA5UPN3hSD3at33Vxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nUE4dWqrVI376CCzmVpx4FgAOTP2DrxTkKoHgpBZww=;
 b=goOvJHt0gZdYrPRwIaGEkdlFjqhsaRpKDWAVe+qtlUrwAfBGF2SkPSKpTd37AeBwRSFYdSkD629/Y/nl0wnnXotFugO4foZDj8FimYB73InKMTe646B4ksdVJqfBgJ4rNVStIXV6EoYUhzh6uJuZwRmU6zYaBmN1ub+Ru7CtIEP+Ggf+Won6GmtJQ5NDnFraKaSkXRgwfxejhdNRGjOMVY+IQ1DZ8yxK0BNntpekzxK338Aa7TJneEtYxe5qmE7r6AW7Eoqdz97q2IPcqcTPkLpzz2kdC4jqxxGmDQqNFRQ0vMIjU5vWIr36oPRsTY9k0IgpMcp/BCP6xBWNbx6mCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nUE4dWqrVI376CCzmVpx4FgAOTP2DrxTkKoHgpBZww=;
 b=Af9/KSV/ckpSncgBWPJQuaX4uadI7gxkTFDHuiQfK+XeoPFaWM+TT3FxnSSPg5XtXqIyb3n5WSKEG4+DT+Ab2MDNhp0dTdQvPXdGQH4sy/aB8eyJCZI7oaI4tZaDekO28T+I38OFouNATw+wYTnMBuIz3qLq68z6r1EW8GEA2vHIng4V91aOzqOXlqcPCJGd3wO3XEarJCjOOvQW+FmkHcl7IbRrC/9dd6R/FzuUjJW7rCyhrXHRSndZajE0cWSDqrsO9fVXd/QzHfzSJElQC4aANL61ZiME4denlPuH32KFpAFOOZGMgZSikKgxaApSRFKCtZbBu68v6sPgW6ARNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by SA0PR12MB4496.namprd12.prod.outlook.com
 (2603:10b6:806:9b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 07:20:28 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 07:20:28 +0000
Date: Thu, 22 Oct 2026 18:20:24 +1100
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
Message-ID: <atm2X5E-ta4QfGnu@nvdebian.thelocal>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com>
 <598bc83d8070c9bcb364a336b91d1e6c6fff4256.camel@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <598bc83d8070c9bcb364a336b91d1e6c6fff4256.camel@linux.intel.com>
X-ClientProxiedBy: SY5PR01CA0085.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::12) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d35e416-5a81-427b-1a35-08df300cf321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|22082099003|3023799007|4143699003|11063799006|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: WumyKlOtM5NA2aqY6/DTXJtEe7UVAzqFhk4RNDemfFEWoQ5K5wwkTNk8310RKNpyUR3JHngyG7aGFkB9fn9BqZadgtZ7eLfm3M+TdhjOUmOwQ0JGzWuFX8ikgzEUpMxWgml9DjAeVqaHu/LLUInI91+uxCH4Ey1Enuvik9eMe967IdRtaWB8Pbz7MTqKFnmEUmhSN62Iilr4WTOzBGcyWzBxqiKHoHM7es9YQRZjrz+5VnNBelSojhTQ45ft0PBviN4HK/ZYdpAP+dCSkHeIoHcZY6/oVto+Uq7S++ZO9dxzs4NEcZDeQogAlGi6KUYkfZh2Js3wId3SbX4DwPMZ5vq3/Vc434Czixsm4zLDpoaFwwpE0RnmCHeu3Zo+PEeLfA9rlLdZu/WGNWubeVvObqfnk0tswAKHOsoWh90T6sYCW6ud0vB+5rdjj0X0UQ3hv8Wlf54BfRBCMLyBhB5ymEk8LUYpcr1sntYcLRW0zC+Ujd90ow+/o0KBC+mNVhk8Z2yw8ZC7+eb7CeYT2LbIZzNUXi/KS+U2L0BY7Sr7oFAQ6x/hrD7+p5RgaoGymRDMW0JPbuiJc0OhdW3bV9ec8zQWz3BI4JdB21XwqseSuIgjlAJXGhbqOECKeyYS/k9zRzdo2nUJJFwSItJ9F7dlXfwKMcu27wvo4pxHEccn6rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(4143699003)(11063799006)(261009223027099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1s0W7IWGPkDNF3TcRAuYN/0jns4K2gYr9luh4Hf08xNkflnpnx7rg0qtzv?=
 =?iso-8859-1?Q?jIq5HzMqEM2X0khjM5c3YfojFUbMb6FK8+3PYu62yXZnQcjEC4B9fcLh8F?=
 =?iso-8859-1?Q?0wgfif3zKK0euyInwtH+IzSeV5k52mbkXuQ3WGtPMuETGHQe6q4V0sxPdV?=
 =?iso-8859-1?Q?ltK4l8k8bPQaA/948Iu1zEuzwpC1ZBjVMiy+p1mD+Unu2mY3FnI1ro75VU?=
 =?iso-8859-1?Q?rigx88ZkaFQBqm5oLquREyCGOEUP14OVVARAbxQPf4en5eF/CHhUWpfo/v?=
 =?iso-8859-1?Q?etPiXqbv7u5ZKGfXEFu1evcyvkOCZzr28QmfGpv73NFDMuUGIJSjbersgl?=
 =?iso-8859-1?Q?T5dezmvefZkcI2/2GbNLkSdwsufw3th30SmtwAu7t/bJmzE8Ue4Wp089aG?=
 =?iso-8859-1?Q?TdHO3eg7shmXz/86pNH3OwSZ2qgR1YkzMdxUQcV01aDH/NrKWVn4I9ogLp?=
 =?iso-8859-1?Q?Z5fgrJdfgAGPVWATIisHpnaBZ59fD/GF02bAgj3S4AI5yXTaeeloBCN9XI?=
 =?iso-8859-1?Q?D7vMtSYiEby9Z/eK1UF6EvZYTNDeQ4tEV2kiqpuM9LkrJYIaboYa/9NxKS?=
 =?iso-8859-1?Q?nZzb6r4VrE68XWrb54s/Zd60U88OLktLjbLO3LcoTotPXKyHTTdtVmbkFp?=
 =?iso-8859-1?Q?ZrE70qWHDWSUKjfAghZbRXQn4+pK+yKGJinkfEfSYsqnC2cUCPALrbokuN?=
 =?iso-8859-1?Q?u+87O7m+Uvlbyff+aF44eQa6PaDiechBq23H10YTjAw6yiDNb5EXymepBN?=
 =?iso-8859-1?Q?AuOm8lGF3npQewtZRVdHR8RMTvqLBl7aOmBpoapbVcGEM28yzg+GEenHFc?=
 =?iso-8859-1?Q?IHPBY85xn6s4++hLIWvKaD6EZ3e+isA+UGJDKePBlbDdFV6pTnbbhGN0i4?=
 =?iso-8859-1?Q?B87Dbm9I6mweFdVpyq8XoAqLf0orxpR3fw/3cskNB/KoscR+JPxRiI6nUw?=
 =?iso-8859-1?Q?oRX/688h0BMtpnUMnxCQKfoJG+sXpK4ukm6YGWYTUHsHqzYOATVSWztahA?=
 =?iso-8859-1?Q?D97XKof6/M4Tcel4+soJCSpYhbk78N2R9lxFKRrW7akX99rC9t0Md1rBQU?=
 =?iso-8859-1?Q?09JmDbdXFy6vPMBk8qUpxgryfXRHIYLlr0WyhFu7MCFtRlqy/R5FLsh9YG?=
 =?iso-8859-1?Q?M/wljP+ljnI/ncd4pMR3/55Xc/mIE7sMnGtmeodTAruLYeroOqVU8nSu+2?=
 =?iso-8859-1?Q?K4WCV4l5xSzN8UVBfXJO3747zjtsSJ0hDSMVUiSjzQS6MehPBobVcFduS0?=
 =?iso-8859-1?Q?lzcHcY+DiojlIggz3dUFHiv3mj1mtWJ+1Eu0eh7cfjwpM8lXchwtfXU5cX?=
 =?iso-8859-1?Q?UhWNBv1CL8wUY6AevR363uaVTYd1gdPtrsYGOYmXrd4jkpY/VeFrBGFbRX?=
 =?iso-8859-1?Q?CpvF1EEfM9rHkoXK3BS7uwl17uuxdtg92+YvZUgvJn7Ycl8fzqTmg2Xz9F?=
 =?iso-8859-1?Q?DfJEyIanA0WR+ydbaPrU6A0MCtQnLJI3+IZJIGWQPnmuETQPg9Z307YvFw?=
 =?iso-8859-1?Q?oIEjJKB7O/efA4QwKD0LMF3MtfYIDdCiy9IdsfJibKXs3vM/2U5HBqCM2T?=
 =?iso-8859-1?Q?MlcBaZVgyHHKOadT1JcHFVIFHNZP8/dvIPhd8BvsUqt6fmGc5vTQTlt08+?=
 =?iso-8859-1?Q?GpqNdvRcAJBeblA1Zg9ckTHJvHCVSz0n8nLIBVfigBL06StP07LOyggbN6?=
 =?iso-8859-1?Q?gCRnCo7JaKfshdrcH1di1SDRB6xpzFDcY2q9qgzwHTGm1FjjfkgrxXIrjC?=
 =?iso-8859-1?Q?TKUgUeBxoFoiUxf9IKBlBWGgEupnmv0mQw+qH5oj1tiHQQANC1kql/XUWT?=
 =?iso-8859-1?Q?52d6Fzm4Lw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d35e416-5a81-427b-1a35-08df300cf321
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:20:28.7371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B50GR9A7+yl8p2mmtsSnhsF3PpsNwZh1sHZTY64jwYnIr3NJ8Z/YTrO+6yRAkMe5Yuly8oZTFXoaV7gMuMQVHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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

On 2026-10-22 at 17:59 +1100, Thomas Hellström <thomas.hellstrom@linux.intel.com> wrote...
> On Wed, 2026-10-21 at 09:37 -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 21, 2026 at 08:24:40AM +0200, Thomas Hellström wrote:
> > > > struct dma_buf_mapping_exp_ops
> > > >    Base type for the per-mapping type exporter provided
> > > > functions.
> > > > This
> > > >    would be the map/unmap callbacks. Each mapping type can
> > > > provide
> > > > its own
> > > >    functions for map/unmap type operations with optimal type
> > > > signatures.
> > > 
> > > Does it make sense to try to land this patch first, plus a
> > > conversion
> > > of pcie_p2p so we could agree on what the contract should look
> > > like?
> > 
> > I think it would be good to focus on this patch as the main 'crux' of
> > the series. The API contract is the main agreement. I'm relucant to
> > merge code that has no users, so it woudl be ebtter to go up to at
> > least through SGT.
> 
> I agree about unused code, but wouldn't a pcie_p2p conversion to a
> mapping type be a valid use-case?

In some ways I think having both sgt and the pcie_p2p conversion is helpful as
it demonstrates how different mapping types are used. I agree the important bit
is settling on the contract though. Adding a pcie_p2p conversion on top doesn't
look too hard though. Thomas would you be ok if I rebased and posted some of
your patches[1] adding pcie_p2p on top of the mapping types + SGT conversion
v2 I'm getting ready to send to demonstrate usage? Or would you rather do that
after I send?

[1] - https://gitlab.freedesktop.org/thomash/xe-vibe/-/commit/7452df0fc858a7dc5ccac0e2037852cb7ab64d61

 - Alistair

> >  
> > > s/mapping/interconnect/? My gut feeling is that "interconnect" best
> > > describes what's typically going on, but "mapping" perhaps better
> > > describes all cases.
> > 
> > My intention was to cover more than just the phyiscal transport. We
> > do
> > really want to get away from scatterlist, so having PCIe map with
> > scatterlist and PCIe map with <something else> still ends up with two
> > mapping types in the system.
> > 
> > This is why I choose the name over interconnect.
> > 
> > > Location of common protocols which typically carry cross-subsystem
> > > dependencies?
> > > drivers/dma-buf/mapping_types? drivers/dma-buf/interconnects?
> > 
> > I'd encourage people to design more like PCI where the actual
> > *interconnect* has its own home and there is just some minor call
> > outs
> > from dmabuf to help the matching logic.
> > 
> > > As discussed previously: 
> > > Agree on theoretically possible matches at attach time, Match at
> > > mapping time and guarantee the match is valid until
> > > invalidate_mappings().
> > 
> > I was thinking about this some more, and I'm less sure now.
> > 
> > If I think about mlx5, in a multi-path PCIe configuration, it can
> > move
> > the translation around within a single PCIe path, but it cannot move
> > it to another path without creating disruption for the
> > application. This is a HW limitation in how the internal routing
> > works..
> > 
> > I strongly suspect this will be the norm for any hardware that
> > doesn't
> > rely on decorated page tables to select the IO path..
> > 
> > So, while I agree we should support hardware that can fully change
> > the
> > path on each and every map, we also need to suport hardware that must
> > pin the path during attach.
> > 
> > Probably this points to needing a 'pin' operation for the mapping
> > selection after attach.
> > 
> > > > +/*
> > > > + * Match items are generated by the importer using the
> > > > DMA_BUF_IMAPPING_*() and
> > > > + * the exporter using the DMA_BUF_EMAPPING_*() functions. Each
> > > > mapping type
> > > > + * defines its own signature with its own data to make the match
> > > > and
> > > > attachment.
> > > > + */
> > > > +struct dma_buf_mapping_match {
> > > > +	const struct dma_buf_mapping_type *type;
> > > > +	const struct dma_buf_mapping_exp_ops *exp_ops;
> > > > +	union {
> > > > +		/* Each mapping_type has unique match parameters
> > > > here */
> > > > +	};
> > > 
> > > Do we really need to add all global mapping types here? Then we'd
> > > need
> > > something for driver-private mapping types as well.
> > 
> > IIRC it is fixed size up front like this because of how the
> > structure's memory is managed in this design..
> > 
> > If you want a driver private thing then I'd add a 'u64
> > driver_private[2]' to the union and the driver can cast over it.
> > 
> > But this is the kernel, if you want to add an xe_mapping_type, then
> > just add it. I don't know we need to do driver private things.
> 
> I guess it's my wish to separate components. Couldn't this lead to
> excessive includes and unnecessary dma-buf recompilations when mostly
> unrelated headers are touched? Except possibly for memory size, core
> dma-buf shouldn't need to know about this, it's a mapping private
> thing?
> 
> /Thomas
> 
> 
> > 
> > Jason
