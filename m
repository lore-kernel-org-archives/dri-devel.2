Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25528C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EE810EDAF;
	Wed,  1 Jul 2026 06:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="df++UbHj";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B50D10EDAF;
 Wed,  1 Jul 2026 06:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTgsGZs8f7nkjqeHivVtJ3oxCHJizPZd7WqkD5MUUC3u+OAEnkbdVT7KzYU1SnRA0TfhTt8ZkYwUwHUUETGaZa+DMJND8iK3tYsq0FnUlpvP84s1K32z7trnEob2mBWKuQ0Mjjt1XwtlXeNHDtzZ7hZGXemyB0ivzys9wBij6glRnGWOxloLbvg8k5B4+vL0DvuIu6axTUqpM5FmNlz3oKI3mZobMyFXVRWBNCfQGNgsXKpvUt9p/xQvBi0aU1K8VOVTBlcPjufgQj3YvDMNZGMpd6cjJikQnZ8v/NPjVHFLw9K9vrSDN5U0iwqbMto+UR+LlbvZOcUDRepBLNkj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv8lX0QARJQqAU2/HTEY5oPpNQfJA4WykLRzFQUGBB8=;
 b=wB3je1BjxE02zxuQkke2m1NRt1HbzAer3xq2pqLsREGc0h6coc1guqZfBz0khGR2Tpseipb31oHYfJOUOkhSAp7svtoM4tBqrQLzljI/L9MILoDgNGZ3Td6PTl+aqAl6tBlgyqa6mPV1LPr2SA+YBBkFEc/eMBYS4IbX50pHGRgG4M5rUoSMjLVaJJD/UZwqZSz+soPEGtPkAQGGsRYvpNrlkFkV9HQ8phQckdRPa3vs+1jZV1EGG9cpTrGcn8g1t5wHOJzdjhoypgvmX6JA9Tp4TKKRLbI4KcxW8vFZI9/iKCFTT5y/0FNBNYrdmBjoEDzX6oArK84lDDdSrFCr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv8lX0QARJQqAU2/HTEY5oPpNQfJA4WykLRzFQUGBB8=;
 b=df++UbHjyzwjqTTHkgiDb8dupbvi3HF7HcJVox+pWBeNIDYfwQceEuGk/2XgzOsf128WVhDvLyUfHzI70zLPwwRfdojz94en3GvRu9xLJpNNb3exmHnQGpY2Mp+AMc6WD6O5aH7R0lD59ijHQOYvT7j2JIDCUUGG2SZa0eyUmz3Qxh2p8m2mbSY7nVc/iw4HokaUSJIr3H52G18tARYV0GWQUe5xyPkU0q2pPHQdBbx+U74jLdImy5emg0JmU3Fe9H+Zq1WAf6y/JnoDm2SaJFLErk0keOGRiifG6PnwwtPpEFniuWxkLlU2SYpv5Q5dTGK2GKHF2ihrXC4ySryIYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 06:38:15 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 06:38:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 15:38:12 +0900
Message-Id: <DJN10ENXVHCP.3PDNTOXGXUZEN@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 10/13] gpu: nova-core: avoid repeated calls to
 pci::Device::as_ref
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-10-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-10-5539d8469590@nvidia.com>
X-ClientProxiedBy: DM6PR07CA0120.namprd07.prod.outlook.com
 (2603:10b6:5:330::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: e46c07b7-305c-41b4-d4bb-08ded73b5476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|23010399003|366016|1800799024|921020|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: c1LOSFYJLp0XFtF1BaXYFBETNzURqB95niCktgZRX6//ZwpE1o14nxkhDsRsLkrk6n9OLAB0/QQcVJsMoCbxh/oZIcRDyU7Pul+yC44FsYDbau8pRwmvRRSnfmfhI+ySlhSezcinnSzwGOqWYTZyXSKaqjQNVDHyjoe+Z8d2WGbAV2+RHo+ifPmNeiXiMArLSLMD0/dXQLrK8OGUUlEkQ/NKv/YLxAWc2+WXcS678EsFoQum1KhM5v8IeWHeMm44JHptEFuFHA/OP5mNtGX2v5zStlCDliwjEZc/kIGj6xgIMWN9Xf4Yua4Zf6QtyZ92B9ppm1Eb/eJut55mRA7uIikb8quMmXnoG9f87Wlk8jrvsbA8YKizvTIUhw/+pgFjfH2ARk3oaiXAoFCoMs7dQ6MrbegYT84vZLCedh3UddXX2/YN49derP9XpuDLYth3oj7wlN16Mw8pwGyqhoRimJIaeQg+53OctamP/JYT1bXAS8uFQhT1ucfVqDZ6tM7eOecjbLvBs6JzACeRzNTETkShq8FLH/Lsjs1BPJ3VaXa0qMz+Ucr9V0tylPVSxMrrGyJYg8ld+V4ZMfPVeoDzJrNH5r9j8f82IVwuMyPEV6r1zYebO4zlX5CWymBUwYzLBruxeFfeU9L3Jw5viQ0vqiVbtcgoPGc+VvdSpCsjvN3dQO5a/jpg1WabDshe3/ckNwfuFnYJXbha/NpwwAdzEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(23010399003)(366016)(1800799024)(921020)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlhLSkNjK1lYdHNUNkUwVk1QUVpvL3dxR1B6dFZMZEc2YS9ESk1Lb1dOenV5?=
 =?utf-8?B?R2YwMzBtRGZDQWoxUG80dlpva2lvdjA1Q24yNDd3TGU4QkVRejNhMnVOUzFT?=
 =?utf-8?B?cVZsbklwWWpHTWFuZXl4S3ZXdVpLUjZuSHB6bHAwMGNoSkFvNENzMU83b2tF?=
 =?utf-8?B?R2U4Z2VDbi9Pc0ZPa1FvK0U2a3h5cEdqTm04VHFZdEpwb2c4aDk1UmI5a212?=
 =?utf-8?B?cHZlSzdxTVc1Z2g5YzIwOE5TUWtDTm45Lzl4MkgzTEd3bWxKdUdlVWdBMFRa?=
 =?utf-8?B?RENEMmdJSjMvMVNWZUZscW5maTc0ZWhRUXZaanl2ZElmK1g0c2Z4YU1HWUVu?=
 =?utf-8?B?MEZsM0YrTDdQL3VMeE8xV3J1cTFaRXRvd0xLSndvSWNWQWIzNVk5OFF0WlNV?=
 =?utf-8?B?eUw4WmN4aFNWdk9nM25WL0VWVVhqd2NXa0VUMmovY3d1R2lBazczcmNZdFVz?=
 =?utf-8?B?akR4QWMrcTUwb1E4eEQ5ei9ZYjJWVHZudUZxY3BhaERGcStKMms2R3JiOUw2?=
 =?utf-8?B?TFZId21WekE3MldwNGdLT0VKT0FTZHhaQVlLU0RYZ05JUXZjYXZXWDJXWWdB?=
 =?utf-8?B?dDFyQ0k3ZjdsaVZ5N0xaRmJmVHIyeVA3SHNSc3QvdVJyMWpDelBOZHJ5dzhR?=
 =?utf-8?B?dUdKaW5nakpwYUZUcFkyRm45RGVpOXpTRms4UmhiTHA5QnZiUUY4SXVWcDhr?=
 =?utf-8?B?cHo1SzJiTlU3TU9WSjI1OFJic2dhbXduN3Nkc1FIVFQzSWRnVFRENEZrTTRm?=
 =?utf-8?B?Skd1NW9SRzF6MDhibEpsbUxXUFdIY1RUc2RPbHkydnQzODBkTnJKOFpNdERn?=
 =?utf-8?B?WXlWUWFUUHZFdnp5NEl5MVNrekxPaWtVVHk5bnhDQkM1KzIzdDJOOGlMSFBW?=
 =?utf-8?B?NEZnZHk5OG9xZUdDVXBKTE1kNzJGdmxLUUc1Nkh0YUVMQlBDY2NsemdJQVJh?=
 =?utf-8?B?R3lUMkVscmJFZmtrc1I2SDZzd0FwZjVRWnlHUVF5dENVRTJiVCtETHZFaWlv?=
 =?utf-8?B?WTlTOWV0ZkpTMU1uc1kwSkZKR3ZnT0ZCSmU0dm9SQU0rTW5KNllUWThLUjBj?=
 =?utf-8?B?U09KbHRrOHJEblErRXU3WUo1Nk1uOUZwT0p5elpNSStHd2EwQlErb2JjVnp4?=
 =?utf-8?B?YzA3Q0tvUUVYMHM1N2l0R3hxNStVaFlFeENTMU5SN3ppMW1wSnpacUxndHYy?=
 =?utf-8?B?MnlLVWFvNFBrSktlUmlFQzEvUUFZUEwxWDkrazNsakdMWWZQNUNkRGJiZm1T?=
 =?utf-8?B?dnNzZk9xZFZuU1dDajhuKzhkS0xDTGlsZkg2M1VDR0tKeWtVdmp4QmFFRnE0?=
 =?utf-8?B?VmpKcHJINGtyTjVyT29KNHZkRjhzT25PZUNVZ2FCUGRydExxa21nS04rZW9l?=
 =?utf-8?B?emhVdzNmQ2EwYWUxRWYxUEtscVJhSG9JWHBqREsvbzl6VXhpN28vaHBpaGdn?=
 =?utf-8?B?aWJKM1plTjF1d1U4WHJuazlpSUlmRmVDNkY1SmpDQUVHSzduUHhsUEgvSFRx?=
 =?utf-8?B?aDBoa1BaWm1tN0x3bHZGRk9CUlYxMWJ3aHloL0lGZEF6QTR2VFVZVEJxcXRn?=
 =?utf-8?B?QWJISE4yVWVzeHdjaFhINU0wTUdsQzdjMDhxUXlhSUlyUzlQZUR3c0VXV2ZG?=
 =?utf-8?B?enlETmdJdVdubW9vQ2I4VXFJeHVoc1E1UXBlTjRXY2dubXdvYndZaE1Bc3FH?=
 =?utf-8?B?WVhtUWc0dEdIWlRNdnFkNGFFZHJCcjZKK3Y5dUpDdzhQa3FvSDMyZWxIR0JQ?=
 =?utf-8?B?cEtmQTQ3dXBCUTBGVUFibjgvelRmVzYzdHV0VmFJSFJmeWZ5V21GS0VpSXQ5?=
 =?utf-8?B?NytpRVVKQUNoMlhJdnIyWGNtTGJFUE91RVc0YWMxRlhydkxCcnpEU0lNK0ha?=
 =?utf-8?B?NmNsRHZCaGtzUk1rL2NlNzhIRUYwWnFjRXlveEpZSzFWZEJSRnZCd3N5aG1U?=
 =?utf-8?B?WWhjaTJKRDh5ZSs3TFhEVWVEcFdIQ0lteFNsY1NSMVNMV3QzdUZ2aFY3OVB1?=
 =?utf-8?B?RU11NjBXdUVSY2RaNXJ1cWZjdjg5OG9wZjc1MVhvaEluU0J1SHlZKzRya1hk?=
 =?utf-8?B?TUtkOW02QVUyUUxDT3l5dW4yVzMyM2ZXNzg1V1g2T0ZhVVpHdlgvR1N1Sy9s?=
 =?utf-8?B?bkNTZDdCRXBLdE5zY3JoK29DYWpFSTZzcnRqNkVtWlgvUnpnRTJsTGxwN09J?=
 =?utf-8?B?dVJBQWs1WklUQTdzQk9KVlRZZ01rVzYwdXY3UytkTkZKczhGRGJBenB0bGMy?=
 =?utf-8?B?Y05IdlA1Rlk1WkRQaWdMU3g0d2E5U2pRK0VHZ2ZNMENCV2RrMnlrQUZYNUFQ?=
 =?utf-8?B?WVd1QVVUbU1tMTIyTlgvckkyY1h5NTRTcXdrQVRTaG02YjFvaTNWdXlBMVpM?=
 =?utf-8?Q?/qE6b9tD1Um6AI6EJDQQEcqCyCCtW5N0hA7R1fXkEDt3g?=
X-MS-Exchange-AntiSpam-MessageData-1: amwtAZRcwUOxCA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46c07b7-305c-41b4-d4bb-08ded73b5476
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:38:15.6535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmgetmNI6UJtht6cq7sYI8vuk2qodI3u1hqen4CJPg/rnBSN9dxAQxXIwhv+QDzCl2ozsntyD/f5CnonJbOstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
> Add a local `Device` reference created from the `pci::Device` in the
> `Gpu` constructor to avoid repeatedly calling `as_ref`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Sashiko's nit seems easy to do

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
