Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7A606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=toABl04A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507D210F60E;
	Tue, 20 Oct 2026 14:31:43 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AFE810F624;
 Tue, 20 Oct 2026 14:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPcO12wrSU1J/+4XjFPtMkBgLPMRITe7wmxIbFNhId35hO06p9/cOVDlJu9rD4/fWVg+Q0TShGAykednXr2M2mVJp+drrDvoBJaWffOCSLQVxL6eQudkXTkbDPdQ3zsCvDrLp8nmHIOeOpSnxPQd1R0qAxM8IJqpN6gML/1cNGR2boku6XGiYXYBVLr6mrXcnVLCS0WgOWAAujU10KjS0zB+mOCNfLCOuVToAqDXgHc0eg2VC7bSiLk9FCFxaVP7flnWz9sz0cDuBK+bHdJy1K6AkYIYHRVLtoIKgOSsqFujMG45j6HbYLaCCffpVX1Qp2I3f8NT0gHnEIMAXbf2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvCTX6PvMxi4ptfog3u3efkFV3irSr6g4j28/VZ8jDE=;
 b=xI6nBFPua7g5UegHXcL6rCwcWU0eXnk4MRULrOiY+wrbBrWzmMNRdZ6GPu4+qFKd/iMKeVpdvUoT9Vg/cw+Zrw7FF5aD9RzAmhgp9j+WCt1nDMXArZjJdHXuakt/l7S8B5LKXJ1soofmAohxMz5OY+rJdWbIelwyjoDNwCEbFgv4K9208aHG/DAp00SwFSe+MFYnhHyR4jzUczUJXrp71zLdf5eR8E2XhwaphLo8OQSCqW5/3NbiLOLdP5m96StO5tG7/Ov8yUQs1iewyf80YkdKUzppedaxXt9acdQs7h44tcX0NSWzZHErN2HRPZDNf+kp5ubgPlvSgYWoVmGfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvCTX6PvMxi4ptfog3u3efkFV3irSr6g4j28/VZ8jDE=;
 b=toABl04ARyyYDixD5WRIvVmeV9ygso9X3BHTzrWbvSLJjc6setRrQRVsgV5THeWeAdj2IbuMszjL5zZrPdvBA88pEgb0JIkZI3Cd7xm+BHH4HsIYD7YiVYNoZrwS7T2dzYkl+8V/e91kWHf7pjDQlETv5Jy6oXRFaTrtA+SSx6Xp5pjKaukCzXpzXOLAFizWj0Dnykm6gb4kftorfcC2qmt2IG4a75goXY3QH5WN+rS0/Msv2ZKvky5NA4dLnzmMSzTPquM5sLp+Arz2B4U7wCWLk3lJGT4KLCcVJD8asqltFc9E2q4LvFFJCnYEGQVr6B5vjwS0twhGc5e/4M+Nkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS0PR12MB7969.namprd12.prod.outlook.com
 (2603:10b6:8:146::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:31:16 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:31:16 +0000
Date: Tue, 20 Oct 2026 11:31:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Karl Mehltretter <kmehltretter@gmail.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
Message-ID: <20261020143115.GE3008132@nvidia.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <20261016202653.97339-1-kmehltretter@gmail.com>
 <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
 <8d4cb20b70ac4c3f36d8d631769757158af2ac8e.camel@linux.intel.com>
 <20261019133031.GQ13920@nvidia.com>
 <41bd4593-5918-4cda-922b-251805c25b60@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41bd4593-5918-4cda-922b-251805c25b60@amd.com>
X-ClientProxiedBy: BN0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:408:e6::29) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 989b20d3-7774-4ef2-a95a-08df2eb6cc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: J00ElV5tAFiZaM9aMUC0DS3oqTd3G/jLlWBgU3DBCE75PrubphImCK8sXcYZAut0Uj9dZDZRPlECEtwpSFxqw8qCCxg4sKtZvTyFld4wjeONTHM9PDYH0K6p7FVZx/g5b8h5ZDJBZIYeDa35sJAwA9cMCL5laHGGpzGgJO5Q26KU5H6GjPeoqeCYRFz2TNGVYyo+lsGTr7YUiYl6yj7AZAblNrTEE89pwI24KnwkYzE1o/VJsUFwZL4MgwbD9cX8fUSlD4sLq/O3yav159J85+6x7lqRCBZWjLJsjFdhbV/DhRqehXkiVXGWfh4J0l48a7BiQPmm6Sjws2rpdWrlEcp37yBrTmoxdngJ4HGT+dLm0LDSd0BY2NaSn4yOClXxzHoz49YSZzMDSx3lcvs6JhzJs1dBR2NpXSQi8q23WHU79RJTyZAXxJOejVwa6ClaVpmK2q4G3HLdqrGRDmslLrBiNsFerx3YUtfiBcLDz9pAZj/Mpt/Y7vTU60+9bTWPwuRelZGZyQNqO/85v2flO9VFRXRF/QumpoeT0t4JmeehqQyTHQwyrw9gRmtE5ziZrdVs2zKW2tnCvfboffMPhvGKn7dwlV5KLEb+aHk+rCsVPBJcU2pJR8ZdzDFE1uGF1dB6WqddDP/P1EjOOyOyntA4o/EOVGEKu2X4gY0NQw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWxGNHU1eFRYN3FKT2p5STM3cjFBRXh3SllaWjFyZm5tbUhyWWp5TXVoNXlr?=
 =?utf-8?B?dzQ5Yy9lVjVpMW53NkFhL0NRbmpsR2hMMC9JSDU1bnY2ZnE5YUgxZ0pkQWVH?=
 =?utf-8?B?cVhDWUZrZEtjRXhnNktBR0l5bmNkRmU5WXBua2xYQnB4U1ZSRUxTOFcrOThm?=
 =?utf-8?B?clpxMUlCeVRmNE5hY0ZKckxjVU5NNDBJQlpnR2R3MVc0NjdYdEpySzEzOHNN?=
 =?utf-8?B?ZGFMWWdxK0o5UG00dGoxMlhpamo4NzZhWUZnUHBtTWVlZGx3d3IzWHEyQjdk?=
 =?utf-8?B?ZkFyY3ZrcWpqbDlHVWpkRzlkTnJtSVozQnM4MUk1QkVNM212dGFNZzVhaFVD?=
 =?utf-8?B?Ymt5c05TUC9ndjM3OElsYVpGTTRUUGhXckEvUFZCM1lzRDdyMWJKY3FCUzZB?=
 =?utf-8?B?RU5ZWXdWTmdCTkVjL0RNckhMUFQySjcyTDlZcGFLekQ0M2FCc3FDQjM1cUwz?=
 =?utf-8?B?WVA5dStzNGlkS0pGN096cDJ3UllYSFNhQ2xiTEJSMnBiL3RyejhuSm1BTFFZ?=
 =?utf-8?B?WFhlM0F4TXQ4aElrS1dEQzlJMzc2UGVXUEJaMkJQVVNTZHFWL3gvT3lwM0lN?=
 =?utf-8?B?SllldFQ1ZzFIcUxjN3cwakVSTmJxLzJUTGx6YU41K2ZYTjFkT1dIb2RFU05C?=
 =?utf-8?B?dWNHTHRUNkNLbjQ4TnVjbVJqYjRHV0ZHTFBjUlU2ZGJZaUlJM1RnMDhlSytJ?=
 =?utf-8?B?WXR0d0tNRmNhdzRVWERyeUpDdE00L0E2STFHVlp2VU8wN3lLZEFUYjNTNEQz?=
 =?utf-8?B?WE1IbWQvQjlxQ3BGQzJmMFhaWW1JdWlZNjdndlFWMGZFcmxqM054alE4RFUy?=
 =?utf-8?B?YkFLK2MwSS9jQlRtUm56UHdMSHNxQ0M2RDNwODloUmR5Zi9paGt6WjloU2px?=
 =?utf-8?B?cytJZmZ5Mkxqenc0aGRVam8yTkxwQnFyalJnUUxjL0dCeDdjOXJKM1ZiMkx6?=
 =?utf-8?B?Y1BHbjUza25WemVIM3RYZlhaYjBXYmI0SWwxWCtrUFQrOUFHR2Y3VlBSRUNn?=
 =?utf-8?B?MnZocVZXYkwvUzFTSStxeUZaeTRkOTFsTkhHT1NXd0ltV28rVnFNMEFvY1Uv?=
 =?utf-8?B?YXNxK2xNaHlLM3Y5d3RTLy9YZnl5ZkMwblF1QmVwd0htSi9BbGZoYytmQ1Er?=
 =?utf-8?B?MTYwSHhxWlRHVy9zRmlXZXhBVllRejY5N2NhRStWREFKelpnQk1RZzFIYk9t?=
 =?utf-8?B?Wmc4NHI0YWFKZzVkZTg5VUVnYm1COEgwVEFLZ29EOVhDSlJIMHZSOXl2cTBj?=
 =?utf-8?B?c3dIZFNsVVJMS1lUY3BSS1VrZHEyQnhqWmg3clVKRU1WRnQ1R2VjSlZONkl2?=
 =?utf-8?B?aGhFckhLMGNvbm0zYUtGZEFDVGdLTE1waTB6MCtxY3VBZlNzU3ZsOHAzaVp0?=
 =?utf-8?B?TVVHS1VPamZMRjRYdHlOR3FueDNnV2JUeWw4bVhsSUROWktocGtFS0FieHZO?=
 =?utf-8?B?OGtnWGRZdGRQN1VyK2FNK0s3L0dDNzM3b1BINGwyMGtzZ3VqVUh0OWttMkND?=
 =?utf-8?B?a0V0dXlvNVM3WlM1SkFObUhLV3ZCdFcvdkpTWFAwYjNMMHpxb0JUNjFjMzFj?=
 =?utf-8?B?bllZNzBFL05UTmhSMklWallram9MbWxCbVdVR2NYM3JGVjhMbGw2S1l6SS8r?=
 =?utf-8?B?dG5IMVByRkxWbEF2Nmo1OVBsTzZkV2l1TnlteTZsVlB4Z0E3ZjlEWDZweXp4?=
 =?utf-8?B?OXVGQnM4eEloSy9sbFNYSW8rRkl6Y29GcnZGS0Y1Y0FOTVUycGRnVzl4UDJH?=
 =?utf-8?B?c1lSelZFdzZuaEc3V1lPaTlkcGYzemRYUlZqSmNxalVaVHhkNlVUN1JUYTVH?=
 =?utf-8?B?ZDFNdnRDTmRTWFpobk43RlUwTEY1T2VVVTNGZkJ3T2J1ZXNzM2xDL3JscWYx?=
 =?utf-8?B?VnZUQlJFNHdpckUwQ0pLMVdncFpKU3B4REhjZ0p2bUJqMHlTYUd3Q0wvNmor?=
 =?utf-8?B?T3p5SlhWSzlRcVIzaGJQZHBCOWlzZERMUFJFOG8yUVJOcERnVFRZUXoxajJE?=
 =?utf-8?B?MlJLWDl1MGtBTjRpOEpqWGRFWjdicHRVankybHhNTzlwa3d5RVhobTAvSHpL?=
 =?utf-8?B?VTQzdSs0czdlNGFQc01NRTBpUjBBNjROS1dUYzR3ZkllUDJLNHV4L1ZwMjhG?=
 =?utf-8?B?WGErc0IvQ3BYUENld094bWdnY0tSM1ZabWhjNGk0OXk4cUZKNjBEbHFUMXpt?=
 =?utf-8?B?OVFvbm1LSkFJSGlFTkROZVdhMWo5dEc1L2UvT25xdVRVNXNHZWVhK3MrUFJu?=
 =?utf-8?B?OFFlZlBGSEZ1bnRTeWlqUFFhTnZMem1ZZWVpWHVHTHJ5SjNRVFRyTWlLS3ZI?=
 =?utf-8?Q?kU+TSuBSD6VjyhYda+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989b20d3-7774-4ef2-a95a-08df2eb6cc91
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:31:16.2178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZK+9r0ZYUUo4t6MvudCKoSs5Z8Yy3gTW38F7Lngx1RfHYgUjIP1NDeXib9nasxnz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 09:01:33AM +0200, Christian König wrote:
> > Like iommufd is not suddenly going to start understanding ualink after
> > an invalidation.
> 
> Yeah but I think we can sort things out early on.

Yeah, if ther is some value thing can be excluded right from the
start.

> > Further, I had the (perhaps naive) expectation that the interconnect
> > option was not something that would change during mapping. I did not
> > think you would loose your PCIe option if ualink becomes available, or
> > vice versa. Though on deeper reflection I suppose someone could build
> > HW so you might loose your ualink option if the dmabuf is moved to
> > system memory while PCIe would still work.
> 
> Yeah, that is definitely not correct.
> 
> We have the clear requirement here that when one interconnect
> physically fails that we can still do things like let the work reach
> the next checkpoint, then it is taken of the HW, and the HW
> suspended for repair, then resumed and then work can continue....
> 
> Similarly we have on the graphics side the requirement that physical
> placement can be moved to system memory because of some other device
> attaching, pinning for scanout or something suddenly requires the
> backing store to be contiguously allocated etc,,,
> 
> So there are vast requirements that a buffer changes location when
> the mapping changes. I mean it is kind of pointless to have a
> feature like ODP to suspend your traffic if the underlying physical
> location of the memory can't change.

At least here, I am not aware of anyone actually using the ODP
capabilities to move and migrate memory. It seems by far and away the
most common use case is permanently pin things.

It seems like in these very complicated chips the placement of the
memory is a critical decision, if it moves around the performance is
so destroyed you may as well not bother.

I know this is not everyone and every use case, but it has been a bit
eye opening we built all this complex ODP stuf and I struggle to
justify it with an actual real user.

But yes, we should try to build it as you describe.

Thanks,
Jason
