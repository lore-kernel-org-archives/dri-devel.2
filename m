Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C718606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LCAwCTm8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B0E10E6A4;
	Thu, 19 Nov 2026 10:11:34 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013063.outbound.protection.outlook.com
 [40.93.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF0010E6A4;
 Thu, 19 Nov 2026 10:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/eP7bUSGbXDWWk4aCJQwsTWjQS4eco04fRQYLGXcrONKeGX2ZcaFF4tjaLqK0Kfqp56lLQ8NYuZr1PuYoGWhkbhe2jqf0xsnaWTNLih29I+pvTuOdWf12XrQCtBbSbZPOWCZnxm6GZVWlxDppTbixsEUp5KbjnHlfARkKcuZVGsU6Qq5eqrOrp6uek5FHBM3P/NNsWcy4yKRdc+pp1S05kupDA7nUtXP8qll2VEKJOkyTPZi7jKGbb8hPGvrTO3FJldJ4LN3XGZWpsxDU2l3c9LJUSwe+M94+F82c+fKeYTvJxjRyKzuauUfCJ8MURNeZ/Wx2GSfAbu+OI8OrX4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyiOVdMxR+UdKhiNbABiLDhj6XMj54NSSPWqz1WHwQY=;
 b=d64Qe772uZZY6vwpxA5nXXN+Wlzcm4ihGijiDFKbMNzyEhC5BnqNe39jbQaQ7gAgl5deMTjq7/8VQeLRzFL9UmSh+C1Ge9yyu8I9HgpuXZ7ubyksnVcAzz911Gi1LmGMxekV6ybe0oKcb2fb+DaaweeKVAts4iHDaUD6Li51cI+o/fhyz754oPGJkUGW/3WVg1qHqn4XOETx8jQ6F7m960p+bL6S+7ayTAf2lggPqQxK8Gc7MhcHGcJ98AkP6FCqpyAheKsj7Z2coGBTYIeBFDkib14h2YWB1pS/28FkbRN/8emdCciOKgNqdYOz78sme2sBD+Oz46QySDfW2uzEOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyiOVdMxR+UdKhiNbABiLDhj6XMj54NSSPWqz1WHwQY=;
 b=LCAwCTm8VymJkVQ4TgZtZnup+P1vvyary2l3/49ai288e0mFXp28KFSYbM0R9u634VyfHWirqvRo+HsjKbi9KtIgeiOrItmsq8CzgDAGrNOGpgIQ1wAY7HST2B3/NdI/Evz7tCcMR2S37/NS+rURc0+UNccd76LqP2BuSNFHJZT3xqi1DgNN8hVIUVUKZ91Y6UPiGp7hSgDTVYUT4eLONUiVF/NCD7jQ11TZZmZTmSoa3Urg/UfwPfbEWHTHBifcyr7UbBzjCuQiI5riNnxn03Rs2xm8BpqjyH0pTRPKbC2Ip99vhMgDHba5wqzyhyPyLjMQJF/BXB2qWWwgtQKx5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by CH2PR12MB4071.namprd12.prod.outlook.com
 (2603:10b6:610:7b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 10:11:16 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 10:11:15 +0000
Date: Thu, 19 Nov 2026 21:11:10 +1100
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
Message-ID: <avuS0WUOwkW2mBeA@nvdebian.thelocal>
References: <20261105-dma_mapping_type_v4-v2-0-78b8dc9ae80a@nvidia.com>
 <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>
 <au7mBMbRC8q6NILj@gmail.com> <avE0QsqV5RZoaWc3@nvdebian.thelocal>
 <de268b0f-19fd-4e05-a8d2-e0f436aaedfc@amd.com>
 <avqgQ1k8zx0_N4rM@nvdebian.thelocal>
 <8768b2e1-e944-46a0-8508-84a9ff491412@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8768b2e1-e944-46a0-8508-84a9ff491412@amd.com>
X-ClientProxiedBy: SY5P282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::17) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: a6838286-aaeb-4991-6274-08df4625725c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|5023799004|261028144727099003|261022105027099003|261026121527099003|11063799006|4143699003|56012099006|261102123227099003|261102130727099003|10067099003|261021135927099003|261021121427099003|261022075727099003|261009223027099003|261026140227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: HlByy2VTPIaLdnpsXoNjC9lhEkYSTJZc6vdxTrZjL0pxutmlJIyJOjiMSxGwhwmxxCY/3JwaUUE6UkIsbs0PqfAC4+DSsKyOTlbuko2tpcr1OK1TYbI9v4GKnVR0r5N2SoFmByEXINO8/DibxppQkT8O4BohrNdPnavOgFtMX50BIxhU+m0Pnj1MWE3Um91zBxVg0HAEtGGvLO/Bky1nwe8//WJ0lIpp0jvHVFVkWlQNcDqztX5rWfxgWVkFQEODx8IAfdYC6dKg3tanvhByP2ZcDuoYsC/kQLJsPd7J80EDYWhxdx9XZh5IaL9G/iej+ddq8YhQaVD93QG7KRLeRlLYJkXWD/t5kCctpWCFcNcYlwBubCjYTd2s8fB4Rq6oIBx44aml9Yjk29aTE3L9szgeTuIfWiqO6hcnsFnoQYuKoct7PjLJXcXyPrbDnaRmn6oHHr8GXcPcJPzO2K9tXRu/oKRyQPKSdNPt2Y/2bdUrHhDyHZmAmZl1UtOuUc6RwqL1XvmJCdoZUChGlIjbczEjw3WMGzxEgQnXVAdL/qJiUewFy9aWjfkpJsuqAs0K1D9pTLLpgTb6bh4Odo9v9lM+H60PD/gYVU+0s0R7USmp5WStFOatLjSMIcmutGoTm6seRxE+3mNDU7KEbXLa6tFRxqbmcigW1CxCAivhvek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB598757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(5023799004)(261028144727099003)(261022105027099003)(261026121527099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261102130727099003)(10067099003)(261021135927099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026140227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SVkWiKQ7SfHf3WQ2Y3umn65FlHJdJTFg+GZB6fCTyvPzpaVtNzmO1lU615?=
 =?iso-8859-1?Q?WiDP4eL5Rnj9c43MnaA/PVdQTPdCluE8NeKpruWFP13V1E5ADgihwiP7jl?=
 =?iso-8859-1?Q?B4X7j/V7wADhoXCS+imnlnyNyPLJ1XyBgWau/lNKe7fpKVklasmDuPGpan?=
 =?iso-8859-1?Q?8L1qO9nEgdmFJ2ByTCmiSTZRRJ6wvGMcw05HkXBLDKLeHG1xKBI57NhsyT?=
 =?iso-8859-1?Q?j0E9FfuZJCd5C8EcdGn9tn+e6Iea94ITtd3MlQ2fhq70g8nJu19YyZmH8p?=
 =?iso-8859-1?Q?I5Vn6letcCbppiq1h0dyfthYQj84v3sKpI+X+jXf4daH4r05pqrmdNrMAZ?=
 =?iso-8859-1?Q?f4gJL0Nu8ZBCIBrMNKAmrFrI1wZxVw8uM6sZQYyaSweUM1hj8SF4PmQxkQ?=
 =?iso-8859-1?Q?yCyRBbev+0IbMvIlf8FUUJWoI5CEAw7SDgUjlg/gZ9vMZdoK/r6kO5M8q0?=
 =?iso-8859-1?Q?AvAu3FmdxjlLfFYD2kBv43rsjOSdB36IzRieFZRWS4CUirdnfCHhrX+i6b?=
 =?iso-8859-1?Q?bOjKEOUmgOml66CtDghB3sg7yIRe0aePO1tzhRIjL9WJI/x1bTLJZbrooy?=
 =?iso-8859-1?Q?+bj+ARIfyZRt934vJ9Yn6zB07acb70/eldoGGjhO9FLh6sX8EwKEcz3foE?=
 =?iso-8859-1?Q?haJ88wkWivN+P2/67+E74e9YbZ4ptIOoSRNvT/Dvn8lWqugyYVoDdw7K8J?=
 =?iso-8859-1?Q?Zz7zhxFpxDNtgRJ+AzG4LGIJPWtMxL2zEDvuQSiN9XXJYMbRPpKn90/17k?=
 =?iso-8859-1?Q?aUW2IpnsgHKxEFqEJrT7rZpVNU91VSwt84DYZty3n990RMHBHhDJb0FAjd?=
 =?iso-8859-1?Q?D3SWH8/EQeGesptcJoG+OwGX8MD3wDoG5OJDxrX9+dxeGNRkzTnFNQBPTW?=
 =?iso-8859-1?Q?Z8+SrxkwJjtHgBSNUmmTLRHbxU4VuNLVy6HpE9ZcB5ByOG7WgEf4YirisI?=
 =?iso-8859-1?Q?O2b95O+ZOeW03j8/+lsQAnwgcM1JLMQsRogwh7TTm4Js/XgYxMdjrOdAoU?=
 =?iso-8859-1?Q?Zcr4K7OgkgyRGlWkCXFrLShNcBdlDvsbvc1zz5dRhaTGpyvvGS/XFC5ZmS?=
 =?iso-8859-1?Q?lN5OpEi7i5IqEVGDTyNqMxB3EJEcY37L5ov5Z5dhTVao1hQJhMd4VvsMy9?=
 =?iso-8859-1?Q?RNi/IRJ4xSxQ6e1ilUWkJkqMtr5/VD3I17Lk0j23bjXoagaqxr3unAKnum?=
 =?iso-8859-1?Q?X1u4hhUCAM1NINO0eApXPy/L2vwzYjYoABX5ItkmFSLx3SX9rW2PZAajOd?=
 =?iso-8859-1?Q?vcp285GmjfOtY1Lnph1Hpr/uWen9H7o3wzx3oSL54ZPYvXcNA5m0RrrWjs?=
 =?iso-8859-1?Q?0ueW/2ma1h4qa5BrJXIPZmsduAWMnrDgu8UMC7tAJ12+m+YIXZ1BnBP1fE?=
 =?iso-8859-1?Q?BtBQ0cdBC1MEiDsBT11vC9c0GXyXbig7dfsoI81zxUW3XiFKk1A/r+YRrS?=
 =?iso-8859-1?Q?2tT+V8/c1WaXmPHVMPhQ0qXnXkcx3IrLphED+a5vU3K6+h2odzlEX1/HPc?=
 =?iso-8859-1?Q?aF1vwL6NN27tIkTkglrHCvRCU6RNddtahAQMiRd3w/KcbgPJz6r9ODy3xN?=
 =?iso-8859-1?Q?qk+/zKGujqYtQ1Q+6bH27dtwLIWoFj8LhJFyPxrFfDsmcA7TSXG1ZtQ9uc?=
 =?iso-8859-1?Q?9vHVcj1cAAF0UNYLAmbASowYi99uYSkVLZpIT+rYYof1Fu9KT9+pyo1M6J?=
 =?iso-8859-1?Q?U752rzeVpsTHKtB2xALdbxsImgKxsHsnUQAfemFEgEviL7CRXlWPVlRf2Q?=
 =?iso-8859-1?Q?9kElOKsAzwtvgdm0DBGhxWJCmAXGQbWJDZwAfWJhrpHpXS8TMm9HNd6pVD?=
 =?iso-8859-1?Q?WIfPLmVdpA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6838286-aaeb-4991-6274-08df4625725c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:11:15.8999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qm5PF52qxhyUw91qMHF3LMIm+/EdsjbS3wDSew2pc0dcoEwBTVshiDBJsdfBdZkMmfb6uMfBvqrW/INakY7/fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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

On 2026-11-16 at 23:57 +1100, Christian König <christian.koenig@amd.com> wrote...
> On 11/16/26 07:27, Alistair Popple wrote:
> > On 2026-11-09 at 21:59 +1100, Christian König <christian.koenig@amd.com> wrote...
> >> On 11/9/26 03:58, Alistair Popple wrote:
> >>> On 2026-11-07 at 19:57 +1100, Karl Mehltretter <kmehltretter@gmail.com> wrote...
> >>>> On Thu, Nov 05, 2026 at 05:40:41PM +0100, Alistair Popple wrote:
> >>>>> + * A pin or map that fails after dma_buf_mapping_select() may reopen the
> >>>>> + * choice only if it was the one that made it. A selection that predates the
> >>>>> + * call belongs to a live pin or mapping and must survive, otherwise the next
> >>>>> + * pin or map would reselect under it without an invalidate.
> >>>>> + */
> >>>>> +void dma_buf_mapping_unselect(struct dma_buf_attachment *attach,
> >>>>> +			      bool was_selected)
> >>>>> +{
> >>>>> +	dma_resv_assert_held(attach->dmabuf->resv);
> >>>>> +
> >>>>> +	if (was_selected)
> >>>>> +		return;
> >>>>> +
> >>>>> +	attach->selected = false;
> >>>>> +	attach->selected_idx = 0;
> >>>>> +}
> >>>>> +
> >>>>
> >>>> After dma_buf_invalidate_mappings(), attach->selected is false while
> >>>> attach->selected_idx still holds that mapping's entry for a pending
> >>>> unmap. 
> >>>>
> >>>> If a pin/map fails before that unmap runs, was_selected is false and
> >>>> dma_buf_mapping_unselect() resets attach->selected_idx to 0.
> >>>>
> >>>> A subsequent dma_buf_unmap_sgt() then uses matches[0].
> >>>
> >>> Actually there's a bigger issue here. The contract at the moment states that
> >>> mapping type may change after invalidation. However that doesn't account for the
> >>> fact mappings can outlive the invalidation.
> >>>
> >>> This could be dealt with by switching everything over to the generic
> >>> dma_buf_mapping_map/unmap() path, but that requires an allocation per mapping
> >>> just to track the mapping type.
> >>
> >> You need an allocation per mapping anyway to identify the mapping anyway.
> >>
> >> We currently abuse the sg_table for that, but essentially the idea of having a structure/object to represent the mapping needs to stay around as far as I can see.
> > 
> > Oh right, I see that now.
> > 
> > Do you think it makes sense to convert all exporters to return a mapping type
> > specific struct (eg. dma_buf_sgt_mapping) rather than the sgt directly?
> 
> No, we essentially want to get away from the whole sgt approach.

Right, I meant as an interim step. Basically a "no behaviour change" patch
series that changes exporters to return some map-type specific data structure
from their map_dma_buf() callbacks rather than an sgt directly.

Initially that is a dma_buf_sgt_mapping embedding the sgt as I don't think it's
tractable to convert all importers in one go. Then we add map types for each
address space and start converting importers to use those instead of sgt.

My rough plan to get there is an almost no behavioural change patch series
introducing the map-types and the selection contract/logic. Essentially that's a
reposting of this that converts exporters to allocate and return a type specific
data struct, minus the p2p bits.

Then follow that up with a couple of series building on top - one that makes
PCIe P2P it's own-map (as I think Thomas suggested), one implementing the
IOMMUFD bits that tries to address concerns there and another that shows how we
can start converting importers to no longer get an SGT but instead some other
type (eg. a list of DMA addresses as suggested).

Let me know if you have any thoughts though, or I can just start posting the
code and let people take a look.

> The whole purpose of DMA-buf was to exchange DMA addresses between drivers and sgt is problematic for that job because it mixed both the input as well as the output of the DMA mapping operation into one structure.

Yep, so broadly I'm hoping I can try to keep the exporter specific stuff in
the attachment map type, and the mapping struct can hold only what the importer
needs/gets to consume (and nothing more).

 - Alistair

> What we need is the functionality to either say map the buffer at this specific address in that address space (IOMMU domain, internal address space whatever) or just to return DMA addresses plus the information in which address space those addresses are valid.
> 
> Regards,
> Christian.
> 
> > Ie. change map_dma_buf() callbacks to return *dma_buf_sgt_mapping instead of
> > *sg_table and convert exporters to allocate that instead of a *sg_table.
> > 
> > I've taken a look at doing that and whilst it touches all the exporters the
> > changes are fairly mechanical in nature, with only two or three annoying
> > exporters that have slightly different patterns (one of which is buggy).
> > 
> >  - Alistair
> > 
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> The alternate is we update the contract to say mapping type cannot change until
> >>> after all importers have unmapped. Enforcing this would require tracking the
> >>> number of live mappings/pins per-attachment, but I think this is the better
> >>> solution so will add that for the next version.
> >>>
> >>>>>  int dma_buf_pin(struct dma_buf_attachment *attach)
> >>>>>  {
> >>>>>  	struct dma_buf *dmabuf = attach->dmabuf;
> >>>>> +	bool selected = attach->selected;
> >>>>>  	int ret = 0;
> >>>>>  
> >>>>>  	WARN_ON(!attach->importer_ops);
> >>>>>  
> >>>>>  	dma_resv_assert_held(dmabuf->resv);
> >>>>>  
> >>>>> -	if (dmabuf->ops->pin)
> >>>>> +	ret = dma_buf_mapping_select(attach);
> >>>>> +	if (ret)
> >>>>> +		return ret;
> >>>>> +
> >>>>> +	if (dmabuf->ops->pin) {
> >>>>>  		ret = dmabuf->ops->pin(attach);
> >>>>> +		if (ret)
> >>>>> +			dma_buf_mapping_unselect(attach, selected);
> >>>>> +	}
> >>>>
> >>>> dma_buf_mapping_select() sets attach->selected = true before ops->pin()
> >>>> and the map callbacks run.
> >>>>
> >>>> In patches 14/15, xe/amdgpu migrate a VRAM buffer to system memory
> >>>> during pin and map when the attachment does not accept P2P.
> >>>>
> >>>> That migration calls dma_buf_invalidate_mappings() and clears
> >>>> attach->selected on every attachment, also the one being pinned/mapped. 
> >>>>
> >>>> When the callback succeeds, the attachment stays pinned or mapped with
> >>>> attach->selected == false.
> >>>>
> >>>> A later map/pin on the same attachment can then reselect without an
> >>>> invalidation.
> >>>
> >>> Argh. Thanks. Will fix.
> >>>
> >>>  - Alistair
> >>>
> >>>> Thanks,
> >>>> Karl
> >>
> 
