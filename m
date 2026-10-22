Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA2606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qNDR2IFo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8BE112524;
	Thu, 22 Oct 2026 12:11:53 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C892E112524;
 Thu, 22 Oct 2026 12:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH0JILgyQ+1Gn4tXch6+8KGMP728y4x0TXqoaG2G4ON+Wh7KhETkCpcxsGHGeeVqJ5PjIP7kPogPN037qCAfFSqgeNqa9MaXdHJKVWUXKRuQW3gm3x7F0jrIdccSNQ/PSjoWX2gEYCqBB8ZQyiKBG+CTIsxZlg+Ft02vzwIWG6TDhmsyuftayuUypPavluK+2EqUfANyseJuvmlBEz+OwQLPlfoW0m233x60cH1JBZD7965/xhb/uWeO3S3Uvg+E4lNA5P+mjE7YkBnJrgYreETaEf+zoaqvQPTYq7GCkSRG+3O0Cs2UuMqTwObGuNyHRSBsSCsgHX91j6ChdnCnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjM40ADWAxroLwOJkpTmQjoJeljxZWNksgf/MNDZKj8=;
 b=LCoaPmjLgufveYnF+5TKmfW928dteFIELefpv+ZLBgnnkqZ8aTr5dbFsgXRvEUK5ggyGxK015KYKG0JxJH742MhEocUWBrHypBagCRpr3FLpSzvGgd0048O+Ag6bAA464ToZJ2T7f0oDHeN+qN5UUtC0IigtiwycJGgTzs1RBzcnSkQUTFziWFkogciiKgGHBa9LKgtxseQun8VqAdYT3c0K7ro1wUhb8W/nxTR103Y2PVaVW6FRJrevxTncQ5DAdID7+6zAk8jugrW+FIPDk3VSbfRzVh1AYG2jvRq2RG5Y6pg4p3ICCZSjbY6QwIxBwvPb24cmiNXcdFAQLQardw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjM40ADWAxroLwOJkpTmQjoJeljxZWNksgf/MNDZKj8=;
 b=qNDR2IFoQWh2O7gVEfep8OPX+Gd1CF8WuhnyPzqgG7TgI3XDkYqtkTDZWIHhneeFLpCkLu5V+SjK2234nvcxIdMx7jDLwFtrrq0FQWpEZEmwvoyfokHixt5iXGgMn3WmVGmQx5SVfin10Yb0/eSW8Lk8iL34OX0F7+yvFFlbXuESBi3v5LU7q2UA8Ywx1/IzD0tuGSU0eO7HelWyN9dvyC9Xbs0s1H5wTt30QVnH3ZwlKN3gnISAHriRNbbN2OVq33O7FV7MyOrohGZ3BzoTfLjLXOzL5sHiUaj+Qv1ntTltXMFFAYqk42nxvHyymjVDjY1IFIa4wbLn01spjTvREA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS0PR12MB8503.namprd12.prod.outlook.com
 (2603:10b6:8:15a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 12:11:37 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 12:11:37 +0000
Date: Thu, 22 Oct 2026 09:11:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
Message-ID: <20261022121136.GZ3008132@nvidia.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com>
 <atmurtZOhKwwGjV3@nvdebian.thelocal>
 <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
 <20261022115239.GY3008132@nvidia.com>
 <995d4ff6f8ba968c75ef3ac70e1dc0a60b6cbc14.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <995d4ff6f8ba968c75ef3ac70e1dc0a60b6cbc14.camel@linux.intel.com>
X-ClientProxiedBy: YT1PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: f86ebfff-c30a-4f1f-0ae4-08df30359f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|22082099003|18002099003|10067099003|261021121427099003|4143699003|11063799006|261013131602099003|56012099006;
X-Microsoft-Antispam-Message-Info: tJvcikzcIv5ZPgPwQMDO6XkMYbN6helFuvo20r2WNqAxmhn6uassOlfqNAKIStDvZz4I9Zn9rRUoXH4bT+GfCylq3UfSgQlAU0cI1qAuGQn3yBrvUu4+Tv1spBuTgF4u1Bva6e26WbPELvuluIfyBV010oy+eC0QZ/t5GLeII1g4F/XE7nbaey6XQRjOSQ7XstBwpxyFEBpxPz0/l3OKTOPoYL0f9g+HlntCfOU1BjL7mAQO2yPG/PFZ5MHZSxVek3DulaQ1JIJldxOrWv80zS0RB5pqUaZss46jzeW9JTxIk+BvJ3/o0Sj53PwBjENGyVnGfjmXgfKwgh+ifsC37TIpxsxy+Y+VegmedypvPykx/WforK/EX+fBF+MH+0fqQQUpyGy3ZxDqUyg00vN7tkU/WFVdF24rCVhTjGmwOA8tKuQmBUTsPotY6v1xQd4mx8V4MhZNBKUZChopwVFqqFyPMXFmw/I5GlZ/3fOEMcDIy7m+S6hEzedWdKOQ5ff1gIXqw1Ioj0FRxCJCf0O/0Vv/gQLrXnvA0LRwJOV7PoNOcYhVBUO+cN+zk9xW1nWJzjyqjaCOe653l3fwGx/CYNzWkIOvilajQiOVE7Q+USzeQoYKpFA09TdZwAmkKP75pz8PQ4w+6q1zqZ980epkIzjtpzhsqGnnkF7+K4JwIkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR12MB731189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(10067099003)(261021121427099003)(4143699003)(11063799006)(261013131602099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0ZiTTVSNDY0c204bW1QVFZrcERiQ1NjKzRzdkN2REpsM0c2YWhIMXZpNHNw?=
 =?utf-8?B?eVk0dVlOa1ZSTTRiN2JWZkg1cGJtUkhzaVk2RE90MlJVTWpHUTFWTElWYkhB?=
 =?utf-8?B?NldnZHhhYXVTamJFbEdsVUFnRlJycE1KdTBCQkpIZ24rTmllc2pkNXJOTXlF?=
 =?utf-8?B?bFRXc0RRZThQZGNlSFdiV3k5WlJlTDluOFEzTW9wZW5aS3NKSDJnMDRjckx4?=
 =?utf-8?B?MU5tRFFLNXVWTkYxYnB3UU9VL2hiZmJaMWhMd2JBK3JQYWc1MVBlU2FMMzR6?=
 =?utf-8?B?SEovOXpMbkNLR2pwNFVocWluK3QvTnpVQjVGOXp0aHhXSlFjeGRwaFVmcnZx?=
 =?utf-8?B?dHo5OTYraTY1eWxTeCtUdW9Jd2NQOEprcGhqSTVqUHg3RG1GK1VubEFqWUJC?=
 =?utf-8?B?WnhJNmYrQm9QKzJ5RFQ2WGo4cG9PM0FITlFFK1FhQUo0ZVRncXlPbkE4ZWVH?=
 =?utf-8?B?S1ROMDYxSFBJeVVCcHV6a2dhV3J1ZVNIK1ZnTHZHNE95MjBray9tTkxBdm5B?=
 =?utf-8?B?SkhvQjY4aWE1cFo4UjhtaVBUZnRwRnJxTFJ5bjkzS0M3RmxJTFQwUkRHY2ZV?=
 =?utf-8?B?QWpoOGw0Y3hiS0FPQXlxY3A3R0w2amdndzcrL2tDMEF2UXRRaVdtWlV5aWVY?=
 =?utf-8?B?RVFHYVAxTUQxMmx2Z3RhcU45U1laaHNTWUV6NDM1YUMwdnVGOGZzQzFlSEJa?=
 =?utf-8?B?ajZ1eUZneUNiNENmMTdseXMxTElkVnRtU0xLZjYwdnBoaWVsNGtEak9XS0JN?=
 =?utf-8?B?VjlKQVk0dUFoU1VaZ2hNcWJZOTV5cDFxRUt5RUd0Y3hoZERwR2RIWTBIRjFE?=
 =?utf-8?B?b0dNMGFUQ1A1ZkVQWUhydGV1VGNhWjEvamh6TXN0dU14T01nWGYxS0h3bEFj?=
 =?utf-8?B?VGNZU1IvY3czZ1VhbHk1WFVMaTVaUXdKVTlPbTVsZ3JEZ1hLV2tycHRVdlhF?=
 =?utf-8?B?OEJiL3g2UDNON252QWd4V3hyZVFzdzhlT0dqTWd3bkRKN1JJUERKTmFoQjRs?=
 =?utf-8?B?QVcwYWdHc2Y5TFZsMDA2cFJLMERSQ1lCeEtmdHpxMWRNQUdhZW5kaGJPdWFW?=
 =?utf-8?B?dUdoUkthTkZtY0NyTGxjL0lZc3Yxa0c0b29LL2RkRVQzV0FZNlZ6OE5nRWdS?=
 =?utf-8?B?a0VRWWdiSEh1QXpQdm04VUUxUGhVbGFEVXNSUUVyeWxDSlRIL3VqWHZRTGlp?=
 =?utf-8?B?Zkdvc085eG1MK2VWbk5GNStEVWhtSVp1T01TVUFqa25FeEJsKytZNDNqZnJp?=
 =?utf-8?B?OHhra0FSTFJ4cVdVZlFJYjBBWWxMZnkrOHc0bXpTUlZGUGVQNUphY2dmb3Rq?=
 =?utf-8?B?SGRlNjdENUphYUxKYm81ek9pYk5FU3A1ekl1N20ySnNuR0RvbVZMRk9SRUdi?=
 =?utf-8?B?QTBUc2N2MlpzWnAreDdBRmFoS2x2c01tY0d4Z090Tzc5V0FMeVYxRndTVWEv?=
 =?utf-8?B?TGQzSFgrSWt4SW5ZcUFQc0psYzcyc29JbkxhM0lqaDduK0hLcDBGdGJ6a2xr?=
 =?utf-8?B?YUltc1JlQkQ5Q2FGckRyWkZhZ0lla1NldW5xTDdhcy9GMHZESG1ZOG4yVVlw?=
 =?utf-8?B?NGc4bEgyOE9HWWpBbTB6c1V2VktKZWNjb2kybEw1UkZYVENQdFhqUTVmWndu?=
 =?utf-8?B?ZWw2VkUwdkhkYVpub0pYRVpxVHh4T3JiVGszcldiNGRCcyt2eWk4UzlmRzFp?=
 =?utf-8?B?NEZOZmllcEtKeCtUYnkvODEyeCtNWm52QzRhMTRGUWZDamZSZlRVNWpjQzN6?=
 =?utf-8?B?UFRwZnJET0lIeGZIb0IzYjAvWVVUdDc1L0wzb0pxTEU4dUh6bGxMTUpuWWV1?=
 =?utf-8?B?Wnhhayt3cS8xcWNPWnVYM0NnN1A2bmowZlRCSHV5TVJDaXplUVZlQkNwWGRT?=
 =?utf-8?B?YURUUWJFV2MvOFE1K3F3aml0MzBFdEZjUCtFMkpmdkJDNTQwQTJZdVhRQUF6?=
 =?utf-8?B?WHlrUU9CUmVhbGNTTjd0ZzRCZ0M3UjFGMXpKWStQcjN0M2lsV3h2Z0lmOW9U?=
 =?utf-8?B?N2VVVlJHK3dhNmxzazlQVVd0WGlEZm9vV1ViRHV5ZXRJOFViQWJKOTR4VWI5?=
 =?utf-8?B?REp6d2NnVHVDbFhRR3NRWGhld1E2UE5aeFltZFNOWEZJNDJmdlowemt4NkJT?=
 =?utf-8?B?cG9PYVZ6RHVEQXVLVTdiVmc3eXMxOXd6ZXJDRzFHaGlCNWRWTGNRMXhUV1FG?=
 =?utf-8?B?ZXl6RksyeU4ybFFsWkF6S1Q5V3NPblVDRE5CcllwWG15OWpsNENSc21RNU56?=
 =?utf-8?B?NVRkTGRkSUpQK0xMaGpKZmk4WUNEQk50eDIxNVAxc3Z4dk54aEtUbnE4L08w?=
 =?utf-8?Q?D0kyk/R+Q6NvDOyltG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86ebfff-c30a-4f1f-0ae4-08df30359f4a
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:11:37.4543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nib1nYUOp2z8cc1J3ZxchM1BciItq4nl9sEXUP9hnnDKMRChSaIUukSMbeErtlXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 02:05:30PM +0200, Thomas Hellström wrote:
> On Thu, 2026-10-22 at 08:52 -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 22, 2026 at 09:25:55AM +0200, Thomas Hellström wrote:
> > > > Attachment could also scan existing attachments to preferentially
> > > > pick matching
> > > > mapping_types that are compatible with existing attachments, thus
> > > > avoiding
> > > > invalidation where possible.
> > > 
> > > Current design appears to be that attach only determines the set of
> > > theoretically possible mapping types, disregarding other
> > > attachments. 
> > > Taking other attachments into account is also problematic because
> > > the
> > > dma-resv lock is not held.
> > 
> > Stating my restriction in a different way, the attach may start with
> > {ualink, pcie} as options. Then we do the first map and select
> > ualink.
> > 
> > Then we get an invalidation and do a second map. Here we need a way
> > to
> > change the mapping type options to {ualink}.
> > 
> > The exporter would have to make the memory visible on ualink to
> > succeed the map.
> 
> That sounds like detaching and reattaching with a different set of
> options. Would that be a fit?

I don't know. The attachment is the anchor for the invalidations,
having it get replaced may create complicated races. Today we don't
destroy it while HW is active..

I'd probably look at keeping the attachment and replacing the mapping
type list as a first try before leaping to replacing the attachment..

Jason
