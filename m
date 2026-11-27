Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD6606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jQYkqbbd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E40641127DB;
	Fri, 27 Nov 2026 08:04:37 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 360901127CC;
 Fri, 27 Nov 2026 08:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APoHYCzMe0ay2dMEieUZrxMIKkoRdAjvUjxXkErNxWi9gkjbYU10T2RbuV17EeioAwOlwem2/24GE4KsBThuHm97tCAKNFk7VwGt8MK2fBsJyDqlljr2fPHj83V78hpBd/iH4wHe0Ja2W/Sr2POjpRA7HngzajK6eEDgmjvBgcr2RgbaOipUPuesh7i1e2PBEX5Py6+LWjYZuDAAOK/EMxpgByIn7ra8FKeKxr8lZ9vzeB/eJzn9/C7dXzZchnwx2AShyHdwb6C55+EgNH1RMc2M8aZlwg0OL4rLIaNbrpq2NkWqwOnABrubnDnKlX3slDc7o7xagnEM5j+NgIRFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxKfeBjzKlB3MJSl6cZqUdizHzYEFvDI2AiSFcRPJz4=;
 b=W2F0dT80cW2s1LGohMz/d9KVmGjtrUMEDADnxcwsY8wBLQEmt2MaHfNr2ZnGOdAUh/Xdwd0xgdqAJ0u34tOz1Y5KFD2srAlImseadEEgVWSRvCmtGhsoDozD0sBVzbyC1tjGB3KtpuL6fe0wavfF//2JmsFQP/kps9ozOsDvWlcPkdlDVcDP5dY8v2bc6Tm2DK5GTtuZ4ibfO4Gb0BDvJ4dXg/b3fdFXxnc67zl9zMiJqgr13epPvzOImc7weLCRjTZRUhjEbep9WeGj2vA9s8HvCQdr9IF/x4+gx5JUqWOPrV79WqeP/04sTNUA8Acfp9VdA7Dzs2w4TMWMww89qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxKfeBjzKlB3MJSl6cZqUdizHzYEFvDI2AiSFcRPJz4=;
 b=jQYkqbbdRQ13EwhZuM4C+4yirs3FCscQtdJcz8uoPcLFSH6rUfszVtu0I95K7m2sBgOtZhoU0Jc7PiOKyToEQc9nmoanEcgjD+rtgMw68ZvZvrwYX1ikVAsxkTHJ7gP4frcKquZHZOlTgnyZq/qGI5H7OT3KA3QZr86w80v/YD0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:04:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 08:04:25 +0000
Message-ID: <79d62f9a-cea8-4149-a673-7ef86942410d@amd.com>
Date: Fri, 27 Nov 2026 09:04:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
To: Dave Airlie <airlied@gmail.com>
Cc: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, treding@nvidia.com,
 jhubbard@nvidia.com, chaitanyak@nvidia.com, Leon Romanovsky <leon@kernel.org>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <CAPM=9txheaE3=fp7=n4fYh-xshxOm+Tv=eQn9wvHVAc-b1JKDQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPM=9txheaE3=fp7=n4fYh-xshxOm+Tv=eQn9wvHVAc-b1JKDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0284.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 798c53fd-32b8-4271-904c-08df4c5d0d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|261026121527099003|10067099003|5023799004|11063799006|56012099006|4143699003|261009223027099003|261021121427099003|261102130727099003|261102123227099003|261026140227099003|261022105027099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lOdQwv0xWbOemuXC5RKRoV0vVFE0fA+RKDKSOcQljsyCf+RI/nvdlhgZ50a7wN2h7h8UBGoW6DjRJsrowMEGpVZKXwLiXM3+Exv2u7RueRuaLwvAbK+WNmrcH8AB2qxPQRn5MM0TNPs6dQVAYQVOFO/8LjejYZQHolniLrBBZpNCRLKlriFKE3bFqGtxo0ajWsnZbMGEJjGIu2gbms6ctRPOgYc78sygLr8DmlZPQ05RKcey/tiyu+qyFj4E9GDfDvEXks6m1Oa0cIAhIRHPusTvXSNlpg/Rx3xtmHiJ877eIPIcfno4+885bQRvZ7tRez9pungKNAyNLD0smzk3WxMshD8OdSLJiICjachcbzpxAb72xPhNnMxwhj4dZ9fwYSpGf5aKTEgLEzXrDbXtW/WVMkvoWl5PQ++SzOd/I7FZBZOE/uJ4PumCrTVvFaQRJzGrjodWvkCyTV5bszHab4eCeW9bmb7fECkGAkcsvqigCa1xqBDFtYav0H0uD5EgQvV6WmilTF7/KdfZM6Y2k936SEh+lgsl/dgiSKKBL9wtlwG/mRMKqCK2TIJCGJNbLb61EymKfkSX2sIA3Kk28KixneuKhoLSVsYh0nQ2pwwtaZcJTTG084QcQ44zRPD5DKSgx2V2U9fC86n+TtpSPz4qOOdmX4Bxv95LuVsF3DY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(261026121527099003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(261009223027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUpqN2xOM3FxVityemxQaEI5dTFKOG5Va2ZkWlZmSWs2cjF0SWhJQTRuN3NK?=
 =?utf-8?B?L1pJYkk5cnM0WjJlSzlIaHp0d3F1OVNPTnExdUJoYXByam5UdVVrcSsrZ2xn?=
 =?utf-8?B?dXBBT1JyZUFRdG5EVWtxeUtvZFU3MkNNVWhxOGdTQkNjSGgzR2lzTjRSQ1hs?=
 =?utf-8?B?YlU4NFVLaEVtYWU5cFN3SFB5VnFYeDBNNlcwekhOWi9OZWhrcjQ1UWRIcjR0?=
 =?utf-8?B?U0pSTW5zTVRMcU04Slh0Ym4wRkZZajVJR1JKcFRXU3Fsb01xazJEd3BreHJS?=
 =?utf-8?B?WGQ3Y3RTQWlwUUJNc3U2ejgvUUdQc0RIbkNld2JKRTFMS1ZmSkM2ZUdzME04?=
 =?utf-8?B?ck00QkZNTVUyd0FscVRXNTdZR2cyUWwydk1taW9meURsUDF1SE9RKzE2Q1Fl?=
 =?utf-8?B?S0dMeFAyQis4R3M4dWNRNEkwRlBLNVhhSUV0UXFrZjRjN2VTYThjWjJRb292?=
 =?utf-8?B?dHYydkd4UG4yMUtzUWxlU1VuN2V1eHYwWjVMbGtSZC94L2xVeldWMTQ5M2J4?=
 =?utf-8?B?TEdIdEVldGtoS3pDT2dzeUpZR0lQcm92YkNNUTF3QkFtWllKbUM5dzk5T29r?=
 =?utf-8?B?ckR0TGZ0RVoyMjBsVVAwcUxOMFluaWpzZzJ1cCs3c1diOGp2WXhMOEI5UnNi?=
 =?utf-8?B?emRjaHlabjV1ZEVtai9jUmVjakRvR215SWpnM0lLN2VVeGdxQSt6VDFDeE9L?=
 =?utf-8?B?WnFxKytlQTFGN1NFcy9Eb0hBUnVmdmU4a0k0QjFhQnF3VGlUVnY4U1YrbjlF?=
 =?utf-8?B?QmpyVEx1S2VMTjZxZDlNd0JEUjZySVZEcVNaUkNWWVo2dmNTMm5EY3ArWi9o?=
 =?utf-8?B?empzc2FJZHNsc2J2NEFTcUZYM2RQakRxMWRiMVU1aEswTHU1VEhWWFdSbytr?=
 =?utf-8?B?ZUtZRU14M05kclIwbHRYUFNWS2FYOHJmL2ErbzNnVSt5ZjVaVks4dzV1eHpQ?=
 =?utf-8?B?VUkzM3dOQ3hvdzdTWFNoaXpsUFpuZE1OeTU5YW52RWwxZU9ETXZIbGpSZkM5?=
 =?utf-8?B?WlVxek1pTmZ4NXlHODN0WHNUNXdkZ2hBeU8xZlVlSVN5U1hkU2hFeWRMUEs4?=
 =?utf-8?B?cHBIakdZWlZXcCsrNCtaRlE4cFpWZXlSNTd5RWZmTVkyMFpjMldMMGRwdkpL?=
 =?utf-8?B?TUt4YmpyaVZtQXNUNzFjbUc2NUpKZWhqdHBNUUVwSGhMcWErZWcrY1JCT0pq?=
 =?utf-8?B?K3JDRHFNTUpYT0VSUEo1ZWFYa3lyblpkWlhrdGx2SjgzN1djRGJtZ2duam1o?=
 =?utf-8?B?RzBEZDJZNElVNHlLRFU2NTd5T0NhZWhPM29jNlJzY0ZUb2NYcE9aV3Erbzhn?=
 =?utf-8?B?ZWNwZTJUUmRsNC9EeDN4UEFYRDZmSHRGQlgrczBlTHczRmxQaWpsemVlRDk2?=
 =?utf-8?B?ZlR3WWdiYVU4M3BuajdacnJwaHc1MzdqeHNQMmZjSm1sckh2TWZENFBYTG5J?=
 =?utf-8?B?b1daWThPV09lbmtkMHIxTkxHWTc0R29YRjlXK1hlMldtRVd0bWtrYlVJRmFj?=
 =?utf-8?B?Y2t2MHV6T0w1ek85UnNWZEg3VDkyQTRyMkpHUzV0djRtQ1Mzci9YNENZRmFF?=
 =?utf-8?B?ZzFaUTMzdUJtRXl4WVROOWNINHQ5bXdJM2RFaW8ycjVvbGlpVk9kd2JMWUps?=
 =?utf-8?B?WlhoQ1U3ZytKMDVTWjZ1Tm1FYkxQTHptc00wdGZyVU9qQ2YxN0dFMEs4Vkp2?=
 =?utf-8?B?V0I4Z0NPbFVudHZiWTVoblEyS1dZYkpOUDVIVXBEblVkUi9RZlgxTnIzSXV0?=
 =?utf-8?B?eUJ4aXo0TFBFcE5BR1ljSHBZSXVWSXZ0ZkdRNldvS3Y0ZDVNQ0RrMHVoU2E3?=
 =?utf-8?B?S002b2R5V0dLZHZPc0VFMUtSVjhyd2JtamYxTlFuWmNFRGNjaURSUnhwWk50?=
 =?utf-8?B?bXF5anJOTDQxN3FTU3M4bUpLTkJLalZoWXJuL3dvLzFueHZ0cTdCL3l0K0FF?=
 =?utf-8?B?VlU1SFhrTFhJSit2eXhKYlRUWTZDNGxqUXJja1JGaDJGakw1a0FidmYzcmpY?=
 =?utf-8?B?a0Z3SXprRGxNRG0xUFlHNHBCbmZYK0ViYnJEaWJ5cldmUXI1QktGdlNpRmhK?=
 =?utf-8?B?L1F4Yldoa092aVd3S3gzZDAzRFFmWTVsMHdRWlBva210ZmF3NjZUTEVndGNt?=
 =?utf-8?B?dWY5TEdEWmorZXh0d28yVVBZQ2cwL0NuM1dvZ3JvTzhRYW9mdkd0ZUNZYi91?=
 =?utf-8?B?a1p0Rmh0UXFjOWw4WURiZHhHUEdtck5Ec1MzK2VEaGJrQklqMGw3bEtTOHpk?=
 =?utf-8?B?S0p0ZWI4Vk1OSmtRL3NMSXpOaGF4Kzg0QjhzY2w0RnI5ZGw2QUN1QVovQUdl?=
 =?utf-8?Q?iyTZ5F+KwD9JF8y8Ew?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798c53fd-32b8-4271-904c-08df4c5d0d8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:04:25.6404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgMXY175EuL2i8VlOGwAKyriOLkeaZi3qOKZPKJf6TLfZVf+BJtfY+7yveuPPxpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 23:29, Dave Airlie wrote:
> On Thu, 26 Nov 2026 at 03:26, Christian König <christian.koenig@amd.com> wrote:
...
>>> The core then negotiates compatible types and adds converters between them,
>>
>> I have strong objections to that plan and would potentially NAK it.
>>
>> DMA-buf should *NEVER* accept CPU physical addresses nor provide conversion between different address types.
>>
>> Keep in mind that DMA-buf is solely a container for DMA addresses, nothing else and it should not provide any mapping functionality whatsoever.
> 
> Is that because it's called dma-buf, if we just called it's shared-buf
> would that alleviate things? I just feel like there are use-cases
> where it containing CPU physical addresses might be what is optimal
> for a certain scenario, and re-creating a whole parallel
> infrastructure that ends up being 'I-can't-believe-it's-not-dma-buf'
> would end up being bad.

Well the problem is not so much transmitting CPU physical addresses between exporter and importer, but rather what the importer and DMA-buf layer should or should not be doing with them.

One of the few things which the DMA-buf design got right from the beginning is to avoid to much middle layering.

In other words the exporter is in control what is done with it's buffers and what isn't, so for example errors which come up while creating the mapping can be handled gracefully by the exporter. The map_attachment() callback either returns a fully populated mapping or an error code, nothing in between.

If we somehow prevent the CPU physical address from being casted to a struct page and/or used with vmf_insert_pfn/page/dma_map_page etc.. then there is not much of a problem with passing around physical addresses.

And if two drivers really need the system memory semantics with fine grained page faults, struct page refcounting etc... we still have memfd for that.

> If we need to shared object backings and have clearly typed and
> negotiated on what the backing contains then we should allow it.
> However I mostly agree on the mapping thing, I'd want drivers to
> negotiate and natively support whatever backings they can rather than
> having an intermediate trying to handle the conversions Not saying the
> code doing the conversions can't be a helper, bit it shouldn't ever be
> autoamtic or outside driver control.

Yes, exactly that's my concern as well. We need to avoid this middle layer trap.

Christian.

> 
> Dave.

