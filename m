Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99099606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Hhkj6+jC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54AC10E7DF;
	Tue, 24 Nov 2026 06:23:25 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A68110E4BC;
 Tue, 24 Nov 2026 06:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh9IZe2V8hpiaW/Rf34l0P7yQ08jlEFwQ4jv8jIgTwPkZuZRPouJZyEz9v8CUUHc++6ePK+F0KCquVEaRymabVz8GTc6trOJSpuf1+QfKxi1Kg2mvVhmad8jkgpE1ZbIEnxbrOAlKSGgjx3DPdPmXlgbuZpYzWra1Rb256+wKF7NE755FUWJdwZZO7ltUdTAlYlSTlKDmrzgnBqhfpMiJO3rZRX0MDYztphrBRmZjlJOEPxsME2m8Oau0l9rrxHFr9wGeDgk8mliHOzZ9nUOfoMvb3rXx9fsyFRqnb5SamxkRJi84U1ab3NnrYrjaC3AAKRcg1tzfYi1TZB0yyR7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqi+R+vu1GIxiTyBYta7xruWzQf7XYaXeCi8UHJQINU=;
 b=c5/xP/NYc0UsS0yKnPFxC4IIDFSeRE12QBW4DgOl7F0ddKuKg7O5C+faFfVVFv0aao+lb5b9+15eTjF8TQOy1ADPWroaQAOEHxajHwe+qVg6W9boRs/ck39yWV79tn4LGy2+6Ffzhlz/LmQNOvZnnIpoL8Ir4x+DF1XkTQ1W8KvAZW5+r1tY6jtfT5lyn8QiCCeQ74Y7ah3BnMjk90HWhWcY+9g0veY632kwRpSKbIk6dbH6LPt2DI/ZIUTEhFYnrngZIWxtYb/XrK0eYOig1N+5bNusXMYZ0QTKLciOblvTKXifQ3bAyXWoDhfFP3v+dm/eq0l1Lx4MctrUGpRaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqi+R+vu1GIxiTyBYta7xruWzQf7XYaXeCi8UHJQINU=;
 b=Hhkj6+jCtOVPHAmaDHWu1Q+4vRkKKr1fgeodbYMoLMF7kQqzsWQm2JqmslyMaez7JGRkxSN5oqhuulkZfFpy4vVUQ2txGiYzZzCI78m3w6Z9pg/4y3C5V36LJLh6eQKjDaGziumscKhcAN2CJuK7bOThdlaRqqu+1i5aD5f60wlvFoQrxgiP8gtW/mOHixOqiEykwTQoM6z0/AYtXJHZ7IMhXFUczIS/pAG36h1JHzh5QyHVxXBSquuxHOwxbDIYXDk7SmGZTl6mjaZNiLaMqF1XzmnTx/86F0AlXyg95UKz6V0y+VASDqvsNr5XoGkuv0guXbq/W/RJoaH+xspQwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by DS6PR12MB600903.namprd12.prod.outlook.com
 (2603:10b6:8:4d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 06:23:12 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:23:12 +0000
Date: Tue, 24 Nov 2026 17:23:07 +1100
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
Message-ID: <awT8prWsj11TBdmP@nvdebian.thelocal>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
X-ClientProxiedBy: SY0PR01CA0003.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::13) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|DS6PR12MB600903:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a3a7c7-7004-42cb-939b-08df49f36ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|18002099003|22082099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261026140227099003|261022115727099003|261022075727099003|261028144727099003|56012099006|10067099003|4143699003|261102130727099003|11063799006;
X-Microsoft-Antispam-Message-Info: 22+9zj8L8mjHXaQmdlfm1aZq7Q2pWCNNassGBIULYKSRSUoDHYFUhX1NPfhL3ijriZ01zRFjJDyPMZaYEctsXeS8h2/dBu6/k5SChDxPS/tdp73yYCp5ZmIGNuId7a2QEpCHeeJB7mC9u7Qe18K4/k6vT91cAJpzNGT9QtM8n969YPNQbGWeGcv/w9V/K5K36WgVwhdROp4lGKqTPcbTrkxKIJMPWoshIdMV+oygXkBPM0cNT2R0pgPpYXVyLyue8yhnijsIjC/1AYXn2QfLWbz9LXbTyve253iPbrHrl5lr4mTpI+eW40zEpbvOLLxzjG0GRCbstDk4fvfJVQjLQ1JJYxQc3DPTJiOBOS24oEpwvtjdPuJhu0WK2oPCtDo9tvB0UWtFCJSxZ4df5yd6hCl0+pBpO2U872A0w2Nj+O7UvJ2j2q/NCy8MVtS2ldfxlirAhuf7647GTmOordWkv6uTaqQM7dFT0ccwdtZ7TPPx1K7jlpDYn8mCoTfDaPOaqrdH3t7gJBJ35vMpRDRz2RnycpOkdSouMbi2zpr2gHpVw8h5xUfFmWatlRJHIbZo1xUTwpu72sHYr5f5nxmWm/hIX/l4IcyDfmVgj25n+9yHmto5GeG8UO303xvgE8XQUpbAGach78FgSB6C9N4uxBPxT7wldnyF8SQyY2ayZtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022115727099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(261102130727099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OQw3WeM1bqlw5xW/4CLTp40EaiuOqI6HDAQDxBP4epVt1puF0fZMDSTy+0?=
 =?iso-8859-1?Q?D/FNfy03+nlG5DozEsd57laR2wt9lUA53OhhvC0HALY8GhR9d2uiYwWk7+?=
 =?iso-8859-1?Q?WFAIDAD37TyXmZoBkn4O9qq1ppx6BIZ8ZGiu2dDBZZmLpQcRIW3B4fEw7F?=
 =?iso-8859-1?Q?nOsT5Q+WlVhQ8lUs6l3fTJuAFnnOfN1MGhwbbC5hZbe3gYlhgIDA8PxKgm?=
 =?iso-8859-1?Q?41vERdR+JB6BRoeUvBerqReg/+AmoyBlSl/sV6Mb4gTJ2jayWP4TxvticE?=
 =?iso-8859-1?Q?G7xHNh8MrbjALCEgE3rbW64ZQHxu4lsS5yU4S6QFZnlKlLUl8pa/kok5K1?=
 =?iso-8859-1?Q?vWp6NoH5y/oUpDSVwLlX93ZGtN9BGWeNsTmPzKKIEmuTexVDJhpyZ/2AeN?=
 =?iso-8859-1?Q?sUMuryszAgHQI2dUOyPTlpNIf1vwmnCrnXgWvKL7LeJp+A6ExAHqAwNBtU?=
 =?iso-8859-1?Q?yw2q1eOMifJnHoWWR1r/eQLgH+M8nrI0fJMMJ7IVcUrtattzoKHpz+H/pE?=
 =?iso-8859-1?Q?P5Vw1RfFmdtq4U+3MMAqfhPN2jSN+7QvUHW5z5PeeAnzFljGI6/ziZg+sg?=
 =?iso-8859-1?Q?F6lL6uhjqtzhQWx27+aqnYnAZg1tL971joUPRSBeWXnlkx3Ma3DnIKCrI6?=
 =?iso-8859-1?Q?g5ZRSRqg20e96WXpV2+5oJTE6XKruuiBXqkbcFXyYf3buyakn3PgAjONWp?=
 =?iso-8859-1?Q?mnLzuHf1mwQo4kDbqjyGxxY3vCz6RrK90WhwFm6gwEaMma8295ehyQUdnw?=
 =?iso-8859-1?Q?N/SKhwJzLTFPUILA+klWb0inI4LmcCwQpnI05VYEDtmeMZBPeIY6qT/8I7?=
 =?iso-8859-1?Q?tcxg9Zo50hFKPGTYkHf9HUFpKZsdhahhPqtGH5HskLbs76RTyEkDqNzEs+?=
 =?iso-8859-1?Q?yZkAaGDZW+YioZ/v0/NSk2z2BDl7EwFT3BBgr4+yw5nsJRXU22+bWBZxwG?=
 =?iso-8859-1?Q?QgKsaE/++Iv5t8iuUhdBNHygdmXLprrf9YM8xkXZtBNNGjspaeB43PyAtL?=
 =?iso-8859-1?Q?rEu9D+uBH6pXmdHowFR9OXPtmcqXaBVTms7/X/pahvdo2Z67WDEnmQGltt?=
 =?iso-8859-1?Q?iplJ9g3E4XBwOLkQrGWYpFErEN71cb95G5Gv4FFzkxcfsO0zhZbc6kXzqs?=
 =?iso-8859-1?Q?B9XbEtbJuFPTLmsgeClL1OH5xpdDOQ/m2RT740+3GSL8otjWk0Tl9jXKrB?=
 =?iso-8859-1?Q?18IxhF8WmiYx9sSW3DxD3hWamjrREfdpizh/dJJ6bWEHXIwgbIoQ0pERDM?=
 =?iso-8859-1?Q?ER919CXZlWRaryAXjFpgExBnD81/6PQYNtFQCplfkozzbA/RDqQD2ALgl3?=
 =?iso-8859-1?Q?kUrVa6kHFtGUNxqxb0g5qJgUovKrBvpH+YAqiXNVkiMaZOTZgZF0K5tEGO?=
 =?iso-8859-1?Q?QTZFkB5A+bkvn44GloF9QNzOQ6T8/NJoEidJodjx6tHhybQXS+M2wVm6iy?=
 =?iso-8859-1?Q?fMRsrcGy2ojLTDWFkysf/MbFLF6/YP7LtcuHa45cBDL6iBFwfTOKEk6802?=
 =?iso-8859-1?Q?uNoL9yfIH19XoNLE7bm/vU2l7/2O7JntH1krsrfLvXfwxMAEAFJGDhhi2t?=
 =?iso-8859-1?Q?cuC3NU/xgruC56ITyLy1NfFXwotXjWIgWoJZYrPmCaOtQKJECD4mwAUA6g?=
 =?iso-8859-1?Q?L6EgYrPs3XqWgF9k4ybbHKqI6dz7S+8ER4Tuyy8/Av1KFiV+GoOQweYKde?=
 =?iso-8859-1?Q?j6dxzfKIt4Mmjx/VUj1GrOh6eZEYObiJFWFPqUEzUCS4U7SfN6UatEi+hs?=
 =?iso-8859-1?Q?nE3nr2QwB8qkIKjwYMCrqnENG2c9IeD5OMdhyQZf8gonvG2MmQb2AavgBQ?=
 =?iso-8859-1?Q?ZhbcW5g9tQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a3a7c7-7004-42cb-939b-08df49f36ab1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:23:12.6799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhVN8An1EdqAJGWf5Jp756wpzRcSn3YjfGu7IsXxtPiraDD4ymmAFnNnuws+cdqAMn6/b15l8ZMEB79hEfu0IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB600903
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

On 2026-11-24 at 05:37 +1100, Christian König <christian.koenig@amd.com> wrote...
> On 11/23/26 17:57, Jason Gunthorpe wrote:
> > On Mon, Nov 23, 2026 at 02:36:46PM +0100, Christian König wrote:
> >> On 11/20/26 06:55, Alistair Popple wrote:
> >>> From: Jason Gunthorpe <jgg@nvidia.com>
> >>>
> >>> The SGT (Scatter Gather Table) DMA mapping type represents the existing
> >>> sg_table/scatterlist based DMA mapping. For now it continues to use a
> >>> sg_table for map/unmap, but this will allow a future patch series to
> >>> convert to using a different data structure for importers without having
> >>> to convert all at once.
> >>
> >> I strongly think we shouldn't have an SGT mapping type in the new DMA-buf mapping API.
> >>
> >> Instead we should have something like either an array or an xarray
> >> of DMA addresses.
> > 
> > My plan was always to get there, but I don't think it is reasonable to
> > start there? There are too many places all over the place that are
> > just hardwired to do SGT right now.

Right. There are around 70 drivers upstream that make use of the sg_table handed
down via a dma-buf import, so I don't think it's tractable to convert them all
in one go. So obviously we will need some way of phasing this in to give time
for each driver change to be implemented, reviewed, etc.

Obviously some of those will share a common structure/helper and conversions
will be similar, so that is an over-estimate. But based on an initial poke
around there are plenty of drivers that bake the sg_table more deeply into their
data structures.

> > Part of the design of this series was to allow the conversion away
> > from SGT to be done incrementally without breaking compatibility.
> 
> Do you know the joke from the hitchhikers guide to the galaxy where the dolphins are happy for exactly the same reasons?
> 
> I'm pushing against this plan for exactly the same reason because I think it will make the conversation away from SGT even more problematic than it already is.
> 
> > So it is effectively this:
> > 
> >> The framework should then either connect the SGT directly if both
> >> importer and export are using the "classic" interface 
> 
> Yeah but that should not be a separate mapping type, it's rather that we just convert back and forth from DMA addresses to SGT for compatibility reasons.

Right, I think this is actually fairly close to my plan, which is to provide a type
for each address class an exporter can produce - either a CPU physical address
or some device context + P2P/MMIO address but in future could be some other
interconnect type.

The core then negotiates compatible types and adds converters between them,
and having SGT as a type is what allows that. It only exists for unconverted
exporters and importers and eventually goes away once everything is converted.
The idea being we don't have to convert everything all at once, whilst also being
able to add support for different interconnect types. Are you ok with the SGT
type if it is just transitional?

As discussed a bit previously types also add enforcement of the rules around when
the exporter type/location can change.

I do have most of this coded up, so can post a mega series of all patches if
it's helpful to see the overall direction in code form. I didn't do that because
this conversion of exporters to not return sg_tables makes it quite a large
patch series, so I was going to post them as separate RFCs building on top of
this. Not sure if you have a preference there?

> > And this:
> > 
> >> or convert
> >> from DMA-addr array to SGT and back if either of them are using this
> >> new interface.
> > 
> > Is something I imagined as a followup series.
> > 
> > As this is actually quite complicated and needs discussion exactly
> > what it will look like.
> 
> Actually that is the easy step I think because quite a lot of drivers already convert the SGT to a DMA addr array outside of the DMA-buf framework anyway.
>
> The more complicated one is then starting to come up with more bus types and doing optimization work.

Individually the actual data structure conversion isn't that hard, but there's
a lot of them and the mapping types allow you to do them incrementally without
breaking some unconverted importer importing from a converted exporter.

That is also why I think adding the types now rather than later is reasonable.
The rules for when an exporter may change type or placement are what most of the
previous review discussion has been about, and I didn't want to drop them.

Thanks for looking.

 - Alistair

> Christian.
> 
> > 
> > Jason
> 
