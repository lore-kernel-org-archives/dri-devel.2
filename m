Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4016606A332
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IhA7A7f0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494AD10E264;
	Wed, 25 Nov 2026 07:18:55 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B465F10E251;
 Wed, 25 Nov 2026 07:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7yhvK0h4QLu/LBOv8WVEjBZGyEceVb5NjiSlJplEY4WDtAGDH+oZEJLMld2Jnek5giRsgBorG6fHibU5SwVuzXtsUpytv6b0fqFjRTDZTRnuHlBQNsYpAjNmqmPsIHppqfWrX1fF2nn71ns3nhtt5GmqzMc0RCH5uCGLTRDYngpMO9Jz8+CNDWwzEN5AORhmDqxFTHIPxeNEKulYDHrBVaSoquHOch8PsMCcyj23wRNUwyByTUfCJql1Y+kVXCX3PPoMSzjO06xY9SiulLxYGdQUAl4YMkjEqHF7Lh7aFJpGl2n8SOQtzNXH6O/EoW25LWiwjHMHiiJajUCQRxFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tq3RABYeE4eCXP+OQXl36DAvRSgVT8xYLbUpu+MTAU=;
 b=DmYPbGOXBfYg3L9etHr5Q+jHFF4NOu8PQz0MLC2LHMVC1MEQ+tWbL57AILMU7fG/FouZUDR2BW0T2QyUrKCq6aUM6tkBaAYTQ9bajX7zH35MdhI8/pkTnIuTKcLDpSuGH5456Ml+FQryO5CiQlLWcqMYc21MNOBLfj/AnbKmJ8WJUBtumHeQ4S0GJFDY5T6n6EUwe+iqg6XzVmh2Oqae9IXj1DNdy1ljeO12eeyjTodRbXim4TdtEAFD29Eikw6yhWMsiik/nNjxTSj2pMGxze1kelxMXFxQEtPaxlggsIUYmyhkHUq1l9yCus/dyIB/tZRbZeedwPFORjxWmVbyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tq3RABYeE4eCXP+OQXl36DAvRSgVT8xYLbUpu+MTAU=;
 b=IhA7A7f0YsBh7hEum73pRFiftm70a26GkxwrYCuPPY4CpbAttGY3qKK6JlqZK1yGhUYrxEoOeqqB09FUsXv77u+ai/p60ozmOUpna/40cqkq5Fl65mG0yQ3KJnchZUyYhs3bvXOVof5nlogQyBJklBpYce+NoIg8GLJmlBwlqJwyPiLuLeX0ShLdv+2AuG6Bqcu1G+iRFaq+eYvsVo33NdXmpA53cy3bZJStp/f58Jj6WgyGAbbkYlgQooOyfAmR+ghxvqEZ7p8q8dwnzWt78c35bVjYzTVpKvuG/ZebXWY2nRKaJNQzhC32izO2/xRKsj51xP6CFvpsJbi0hWZtxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 07:18:45 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:18:45 +0000
Date: Wed, 25 Nov 2026 18:18:25 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
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
Message-ID: <awZ_Os1pXelOGaFP@nvdebian.thelocal>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124194618.GC114530@ziepe.ca>
X-ClientProxiedBy: SY5P282CA0120.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::19) To DS4PR12MB634945.namprd12.prod.outlook.com
 (2603:10b6:8:514::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|IA6PR12MB893085:EE_
X-MS-Office365-Filtering-Correlation-Id: 302344bd-3d0c-41a5-4f95-08df4ac456e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|6133799003|4143699003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261102130727099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: UyjTERNUz5jYg0A0gF5hBQTz6KOvHcmbb9XRoDrdhjr9TgJRe3pfzYTtJfy1VMWRs6epjqGjJNF+CES2D1nzVlk1uG8/HGoH8M6iZet2fDcWJT4pj++tix3u8hNwnXOq2J9eP60pOWXeuOv3AyR3zYy5et8hegZosSHhIeYekiGjFyHGlXOSYsIFSvCHporpuFPLFjVQtAYWEblG5tz9vPaNaQlig/8EfO5PtT5/+qmUSJQh9kuLxaQZV2djyCLbZPMbu3zlJptkhfDXNZFJbc3hKk8tuXfK4UhZDPGVGA3K4aRYsTP9+rrEXW/eb7L5Xta0xw7FWH0woJtsokdEg5VBg5rHdo5Mo01IPP3haaf1lhlG3yeWId248fGfN8i9q/PigTAEw1fGNlQLfAnrNjQWA61evbk5qqQcO5xgLIzA/sC2xPyk94XDRX4pL48/ed+441I0YSzptEeguyNnLse5E19ARaV68Brfbqwh4TCnaVM5nT3eScwDAj6SsaxTmDW94WFgMU78wwLxR89oTrl9ZyXLJuuFoQsLhwpYnA8gYmZYF2N9ZXCdjBaCAeY1Xh3BdpjpkpjW2MJdJaXgZTRFIMfHBX4JrPeZWJV7/Dv1fgfC4p70mx3cR/vkb/Fq06wCJ34ZVL0vwTXRKp/yqBJGQV4fYgFBo+Zx/ogLAT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(6133799003)(4143699003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wSz7w4aM0rKWINO/x6thZ09VL+DJWjjG/42b7oc1AxliNWQ9E3x54i+Y89?=
 =?iso-8859-1?Q?+TTziu9pPLpLd/G56W2xcg+rNzeDc0Zv7AQfuZdPvA5ITEmZXth3IvNYM4?=
 =?iso-8859-1?Q?YJmKebHoVdiZVIvQc8jDpuecl0nMdMRhlmzv/Dk8V6wJhGXEYBtCxjyESk?=
 =?iso-8859-1?Q?9AzEONiIGPUeGxkY02Xh9dFhPPmPBxBZu10KJv6/aJKIXLO1DyJ9NMUrcu?=
 =?iso-8859-1?Q?pz6TDhL/pESFbUbJcdG2bb/9NzmBww+HrXwSUH1LxZEk2h1zDdUJZs96BD?=
 =?iso-8859-1?Q?qRDsp837ia5f3+lS8vXeKzn/32tfmNGuJofIWJ+OaFy2zwBr2hhDbubiOM?=
 =?iso-8859-1?Q?1Dv3eRb7++XXyKTCEBmoRSgGxujL+t0lVxuOW/HCM7Ba6xgb0iJK6afnlJ?=
 =?iso-8859-1?Q?Z8YOFLUc1ITBnVqxqZxk5rDcoApdzdePr22Xmn0zY4cdSgaIDZ9NZoCl46?=
 =?iso-8859-1?Q?ymfgACHcSCiHAHngERNjNaKu/jfI9z3l5OtkDdJPl6HtNBAjfaTQlBtC/D?=
 =?iso-8859-1?Q?8V7wo5Npmeh5YDCZmW48EHXkRMreV3fZmFqKpIgyPbNnffMlL6H6rIriRg?=
 =?iso-8859-1?Q?Bw9ZLs7jGckqUdrtNAYF+kUpDi5o1bwEQwNqb3SpA98Qno6LjEwWlikTJf?=
 =?iso-8859-1?Q?xVLcj7ZBmFvdtbI2BZGNdioB8wyArvNBfBanDDIzdvo1p9YDycrP6nOUWq?=
 =?iso-8859-1?Q?Cr808rrT1i0bS5BZPvIdhk9HkXv7UJU/UNCFEr6fdTTTOMlmWep++miZ9B?=
 =?iso-8859-1?Q?rY7Z6YFelXxh7q8ww9b/Q42riFDlabW2QOf/NT5fSB1V8bgmzg0zcLWP+v?=
 =?iso-8859-1?Q?K96872XIMumD4Lg01xp6a3btbMbMLyhtpeOvPUV8lELAnevibsl/CKtdus?=
 =?iso-8859-1?Q?7eHdzb3FN/U7E0TeP4cSCEMFdBOW5IJZLoJWRvw5zsfD4ECSYchVGN+rzK?=
 =?iso-8859-1?Q?rvYgoGLCEH0MGg3ks3xO5Zwr+ji7BsCEPFpqLkFJQ66f7vY4vaRHq/N0NX?=
 =?iso-8859-1?Q?3j2Alr07OWs4zUAXKiyIxWHBFZJsPIN2vzK5wHC+pS37gzOviS97IVgTu2?=
 =?iso-8859-1?Q?r8rwvvuq+N8KhV3vQGSxuLE4VZotRxstO/e+axQqnGIyXhLS9gXROVQwTN?=
 =?iso-8859-1?Q?tNW2NiWVHmALj7BSeFK+3Kw4Takwle2q+UxMqIAdAO2x6al5Ht/wq91JGR?=
 =?iso-8859-1?Q?/uYq3eUyfGXLQX5iIWiMzewWoUmsuMqJMnjvWsNxNxlxafvPIa5JC7SG8E?=
 =?iso-8859-1?Q?u7eiwwPMlXq8eFNQ8hDup0qXHLe10ddwOEwEZn34bBudZm6Rab639oPweB?=
 =?iso-8859-1?Q?VrTeNU1JJF0HvqILu7jgFIKnlogW23tzQV685MDe0vPsKR71oMKA0oaojw?=
 =?iso-8859-1?Q?ldvkDCJ6tPncDA4OQtuSw9gIwKK6sOysd4QcfyLqlZ4WsyWlCuNMTHwZu6?=
 =?iso-8859-1?Q?XcDCfuYS1b9OhFT3weL9qe1d5cub46C35CLC11dmgDFLPq7xg2+9/jZcUG?=
 =?iso-8859-1?Q?lcNpasMiFUSHETnWgFrx3hvNWXxmd8oGbmql1vl8s6Cc1d39ggGPATje4u?=
 =?iso-8859-1?Q?sbEKHh0K8kDurwDteMxCNcelTEfyL58oF5n8WZNNvxcdf86f3QSfq6t4mz?=
 =?iso-8859-1?Q?b/Y8eXPVkBI0oX9cHPZI2t6Fy2XNVr/crB/y8RT6nZ+UE1/JzI5Vf5OLx2?=
 =?iso-8859-1?Q?JXJem6clY0sWdYk85AU7tfo8qfJX+iWHfhgRavVDWaRSxwmvKy63pK7XEn?=
 =?iso-8859-1?Q?mJE3WxdkUcw3yKLAyb5KBBz708xycC8vOW05mGnbodyUVWF7z6KVHdF1an?=
 =?iso-8859-1?Q?i7NQMOFp8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302344bd-3d0c-41a5-4f95-08df4ac456e5
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB634945.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:18:44.9128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbXPCafiP8Qxc9vHRcwQzyC1Fh+UQq3Mgy0GS+H+OYjpOiGzUQV+YnAqCOrhoWszDNFIHjivXsOqIk4Bc2vRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB893085
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

On 2026-11-25 at 06:46 +1100, Jason Gunthorpe <jgg@ziepe.ca> wrote...
> On Tue, Nov 24, 2026 at 05:02:31PM +0100, Christian König wrote:
> > The whole conversion from phys_vec to DMA addresses is something
> > some API should provide based on the data the exporter/importer have
> > negotiated (e.g. p2pdma_provider for example).
> 
> Yeah, probably, and this is exactly why I think it will take some
> time. Building a new something in lib/ like this is not a
> straightforward task.
> 
> But also, this:
> 
> > > You need to negotiate the actual C data types too, especially if you
> > > want to do that nasty idea where dmabuf populates an iommu domain.
> > 
> > Yeah agree as well, but to be honest that task is negligible. We
> > first need to figure out where to put the code.
> 
> Means you need to get the phys_addr_t into the dma-buf code so it can
> do this conversion.

We all agreed that open-coding DMA mapping of buffers in every exporter is
something we don't want to do. The disagreement now seems to be where the code
converting between physical locations provided by an exporter to DMA addresses
usable by an importer lives.

> I'm still absolutely NAKity against allowing any DRM driver visibility
> to an importer's iommu_domain if we do this hack.
> 
> I don't see how to meet all these concerns without making dma-buf into
> a "converter" framework...

Right, something has to do the conversion and we've agreed that shouldn't be
in either the exporters or the importers. The main objection seems to be having
dma-buf do that, and instead having some DMA/library code to do it.

If I drop the type/placement negotiation for now and focus on SGT removal I can
simplify things a lot. Plan would be something like:

1) Introduce a new C data type (dma_phys_list?) for exporters to pass physical
   location info and context for mapping.

2) Introduce two new dma_buf_ops - map_dma_phys_list() and unmap_dma_phys_list()
   - which are replacements for {un}map_dma_buf that converted exporters use to
   return a dma_phys_list instead of returning a sg_table.

3) Move dma_buf_phys_vec_to_sgt() somewhere other than drivers/dma-buf and
   rename it dma_phys_list_to_sgt().

4) Update dma_buf_{un}map_sgt() to call the new map_dma_phys_list() ops and
   dma_phys_list_to_sgt() to create an sg_table for unconverted importers
   importing from a converted exporter.

5) Add dma_buf_iommu_map() taking a IOMMU domain/iova/offset/size to be called
   from iommufd for mapping an attachment into an IOMMU domain.

6) Add a new C data type (dma_map_list?) containing DMA address regions
   an importer should program HW with and new dma-buf functions to replace
   dma_buf_{un}map_sgt().

Names are really just placeholders, so easily changed if you don't like them.
Let me know what you think, thanks.

Regards,

Alistair
