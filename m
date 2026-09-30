Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AC5CA5FA5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1529210E8FE;
	Wed, 30 Sep 2026 02:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X/eb0ZGV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011025.outbound.protection.outlook.com
 [40.93.194.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B62B10E8FE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0c2FFWGm/fBw73KubSQ8RLMx+JdusdIU4Fx0kng4ekNTkiP1jKv0WmIk2eFzdxu1P8XIuWitzN0ggATTEx59JpuRPumlPbdupEd/fXjM2M4uJhN47xlAY5v2fB8ymCYS99IpQuyvXiCkoZfKEA+4RLOEdgIUdMUq1GNlJOOJt2Ak3MyCfObySbrotbKIbRg+8x91P4iaDv3lu1YuhEcPRmqiBr6dTGT4eMbEhuz/6COG6YkcoZF7e1B9VV76XamGelFeC7flV+lEwVeJQkMDIWfwGanPZGSvxOGGsX8KWbP0ipR5veRaHqf96BfdBPRIcW+TvybeRUAuFrdURcuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9Nhi5RBkimph6UUpywtvH6I3UNoTyTi6kMylp0DLbM=;
 b=gQtdjgiXoGiuOCqYptGQVs0ooCi4jcuzU/sHftFM4tGq75wvQCD2aU8xoiLFTKddJao7keiN3bQw77zucoEHp23fa3h+OFg5QGPPvXjaOk452aOo/uMLf2Yj1BcYt7fRq3TxnKxxm466uliFI5J1EL/roEen33a7Urerh456MLSU7quTmfGvKWfY07TXbw0jzlGFfsLTbcJkbkXsizLJb5G7fkkhwo7otQjB6RcIMOPOpGAKjOg4g4SB75dwHCs/jEYc0uK+hqukmvPcIjuO17UTHa2Iceq8NTsSogG6hInSUqXbrk8ClsZ5KxWUmVztQrQh/cxK2Dg7wr5lqeCC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9Nhi5RBkimph6UUpywtvH6I3UNoTyTi6kMylp0DLbM=;
 b=X/eb0ZGVmoVva3hVG1bcDMjh9NinoMHffSKX9WbItEtkekXMWpbhUJWvub6Du9GP2HpAXw+ZCaNZkKgbySVF3jkdYbpWCrrJvwnvyL0pjcVtrj8r+s3f8a6jkhqUzQj9Cl6MaXWrMf96I+hL3hXP8t+jDdrCtWKHaU0Xqjr7smbnBbgHi+lYpi0rumy3AhM2HySgCLKxRPIeZ/kOHvmxERmYzByS+jE24tqnTXzqDMRBc8sO+a4aQ7mSCtW2KYtPpYuRpuJsSVt3J43x7tgk6Ho6SYwhhtfwo+neEeuhDJkalE4rBFSUsSgIZfaCt1qEMLW4bom/+1ICbBAGeMFbmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:20 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:20 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v9 0/9] rust: Add support for reserving of ranges of IDs
Date: Wed, 30 Sep 2026 11:42:49 +0900
Message-Id: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23SzU7DMAwH8FeZeqbIcb534j0Qh8RxWJC2QbtVo
 GnvTrp2WlE5WvLvbyX2pem5K9w3282l6XgofTkeauGfNg3twuGd25Jq3SCgAQOupV1JrXA5eCX
 JJENNbf3sOJfvW8zr21T35/jBdBrt2LEr/enY/dzmDGLsmyItyClyEC20TmV2qD0rwy+HoaQSn
 um4b8bMARcK7wqrIqlZs89RJr9Scqn8rGRVCETgQGKMtFLqoZyAWalxls8IJieK3q6UXiqcla7
 KkDXWWogyq5UyS3V/l6lKGIisU446ppWyS2VnZasK2llko5L7Z5ZbKLwrV1Ukq8jaBCj+quu0z
 o6/zvU4TtOOH7ex3cxh9TKG1iXFXmMmoWhbP7HaGHpua9K+nLYbAcEYlAFVcNqCMxo4h2QjCy0
 covMKJCVbx15/AXGvM6WbAgAA
X-Change-ID: 20260608-chid-18fa943c6d6c
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0106.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d833e06-8753-4af7-53c8-08df1e9cba61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|260925022911599003|260925021911599003|260925021311599003|921020|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 3pXOfayl9xTgE+vwRWu+MbkNckqX3QaMrSfCnm+khbmF3M5Ri2mKBYce+ucMeV5doEpJqNM46+COQ08WwAnD+xzWkN8Yq1hJ7vWpshOyC5XO1NjhnhSWC9NJOWtjhKy4k44YLcQlD3cqIvmDdwTO7gHAl6srSKFlh64UvXKRXFZDb88tGE1SBxgMf/fCUGIs4al37vG9TWyDJA/x4mJcPO+AdbLAZeBy4ZitNFr7twnuYXPhmsiGjLcZRZXRr4RtF411fuMekEj/Dgz7G1yufmjk9wFWDl1KAt/q4pgdZ8IkpKIXdDctOgkDAU4NNiTgUHTr6GqXA5j2NPIRSunbHiB3NPo/bb8pyzHj2eL/4bMmkHoRWRG23Nyo7CsvlxlyZKzRm9moFk8bbw/IAtKfkpQ34uSXIel2HjJOM9aXVBXEk/ovZunma64dLcR00YEssEBpHpYkYoar90EmUZDBvIQyz9CdYJqqBOYxEEXm1QbtrqZIQKXMPmI9N/6dbSAZqyaQNlt8zYBsgKp6ygfRMyPpD0z+gtGe2pR91P6fYkJNvB1v9I397D4LrjCoKRyTSr7YKGI1NgR0zqxjVdfmxAv1CvJBKPcbtOxaiPVQkeTO7jBIeXysWBPIcUWfOOa3bpV4MFOm7+3KYk9GGPxj0El+US1VldqCkdSXPCTcDPr/r3SEz6LgHwBC/w+8sOpQCc/02dceOCk4o3S+8iMK0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(921020)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JENDZxdEhDWWxsUW1VQ3hDK24yTEJVUlpGV051cUc1NjA1M0h0Wnd0NHBp?=
 =?utf-8?B?QVF4Lyt3ZVQ1czRTQjhMc1pyMHBpaHovYVBERnNFMzczeTRnVG1LNVdCV3pW?=
 =?utf-8?B?eDBVOVRmYlQ3dHAyU0tTOHZ6cG9OdVFMZHhpYUsvVytEN3dwVUEzWTk0ZzVF?=
 =?utf-8?B?MC9wUFM0WXF0TFZ2dFkxUEZtVlIzRWU3UmpMdEtKTkVEVTNKdE1YWkJHSVZ4?=
 =?utf-8?B?OUJsa2l4VnNMbm14Wk0wK3Y5amc2a1BVSkdvVGxQQ3JMWm5Ra1NFNmNZSm5R?=
 =?utf-8?B?ZHgrVjd5T3QyKzV6bmw4OFNscjBMSnpsNUV4cWRmRC9HOXU0WWQ3T2tySUFD?=
 =?utf-8?B?NXVPZmd0UThWaCtNQzJOdzNmTE1tcFBIN0ZEbTVUMi9ZYWhWZTNnbVpkaVg2?=
 =?utf-8?B?SEFtRmZyMDQ5ZmVOSERFeEVGSkpNOTFKQlY2WThmVVRzSURLSCtHZDVTSFgv?=
 =?utf-8?B?dkcyc3NJbGhVRGQ2cUFWU3JkTTNWbittNjU0ZFNsVWQ1RkVoZmpybWlJT0RQ?=
 =?utf-8?B?UkZSM2VqVjdzcnBCeGMzdW5TVytPMm5HaWphRkdtRHZqU3NYTkdRbnUxblNt?=
 =?utf-8?B?Vk1lZDJMb1JwR0tlMlpNU3RGOWl3YW9oSXZ5cHkyb1lBYWJDdTlCRTFUazVM?=
 =?utf-8?B?aFI4UkVuL09LRVNRSUU4RVQyb1R5YXdidnBMM21IK1NLbDhZOW4yZm0xQkFV?=
 =?utf-8?B?MW5YdlJnWjlValNFRjFOM0RhV1Q4aHN2eWdXSmtBK3hzL2owclU4alhwT2dx?=
 =?utf-8?B?ajVsRW5OcklKaytCdkpZbXJJTk85cEo4ZlRJS0JPMjlkWk5hbnBaNTBaMFFS?=
 =?utf-8?B?elMyS2puaG94Vkg0V3hRN0VRK1V4RHoxdEdxcEVaUG4wd0RLTldWeFRhNWNM?=
 =?utf-8?B?aHlSY1k1eWRveG5MSTBqM0huRWRuRmdGaWRBbXJPaUk4M3N3Y2k3ZnBaNWxa?=
 =?utf-8?B?Qm1ZM1B1QUlSOTRKZXpXZlZCd1luTDZZd0FuVUlMVkV2eUpYSEorK1RHL3Rr?=
 =?utf-8?B?YU5BSU5mOHpSNFNrdEFSbGNrbGdBSCsyNjZNd1lXVnNSWERTSVB0MDNFek90?=
 =?utf-8?B?U0w2d3prSm95bFJickVVWGhxTTgxWGhCelQ3d1lKVU1NeUJFVDhzUDEyWTRM?=
 =?utf-8?B?MzM3cGdmaXozQ1E0UzN4a1RJWWhoZ3d5bVNta1oyMTNidTlac1ViM2EvRkd1?=
 =?utf-8?B?YXVLR2VZYlJpcjlhTXdIaW5mU3ZWb2d5b3lIZEpZY1Y3SXRyaXMvb3Z2anR0?=
 =?utf-8?B?NVVsWS8rUDVjU2JuS1VySzdid2NzV2NqNlRpOGpyRUdhMy8zSStXZ1lvZndz?=
 =?utf-8?B?T1RhRjFWMUhqV3ZEdDcrbjJHY3ZqVnV6UTk4eDBrU2tUVjBmRzNYUllqWitZ?=
 =?utf-8?B?WEx1QzlyRmJKelJpTVFtUWREdVdxR0daSy9UcEw0bm5iWnN1alg2QmcvdWdK?=
 =?utf-8?B?NWdsUHcyVmpIcE1UQm9pYmkyV0NHYUVJYXlYZG5tVnlJYVJhZDQxZDVQaG1P?=
 =?utf-8?B?a1Z2dnJQNEZ0VjZVZ1JLeDdOKzJlZTlTNUVkR25rYmRuYlAzSnJKZzF0UUVz?=
 =?utf-8?B?eFVFNW40SUcvTE1iTFlHYk4yZ2Z1SFNXU3ZreFUvMVhxbTJQT2dnZVFrL3ll?=
 =?utf-8?B?UFU3Q2JhN2hIL2pKRlAwbWFCVXdIblBjaXZZVmhtNm1wNlc4SFFZSFZyaEM5?=
 =?utf-8?B?YmZENVRPdS8xZ3FRcW81YVBMYjZ6dXNsV01sdUJuZFZSRjBCSGlVN2J1SCti?=
 =?utf-8?B?dUlMTlRoaHRwQi95OWdOUkd1VXkzeFJROHhwMDBxZ0Fsd2E3S3dSVEFKVTVY?=
 =?utf-8?B?MXhsQ2Z5dlRiOWg3Vzk0Wk1KcjhtVEJvYXYwSW9VVmQ3clo3WmpDNzRUeUtj?=
 =?utf-8?B?WjIxK3MyaEFqaHJWQjJFSEt3OXgwSktKM2lZNGd2amJlZG9QZXFvSHdQUWdn?=
 =?utf-8?B?Smt2SG1ja01jRDV5SStNdHRNd1JSUjQzUnR2ZDloMzJKUURKZlN4Ulp3NDdj?=
 =?utf-8?B?WmFlbEF0RmFUNE45TzA1RGc2Q0ZlVFlCVkNxQUgwNXppOUE0bkZMNzhSVnJO?=
 =?utf-8?B?cUFMVGtzakY1R3pLK2VLWjVrV21TcDhSandxL0pTdVU2NTYxWUs5bzlDSjl5?=
 =?utf-8?B?QVpRdUlOTnRaVXVKek4xWEh3OEtyaGRMWUs0d2hGMGt6SjlvNjVCajlqL2FF?=
 =?utf-8?B?Ukc4RndNdWF6S2xiMWFFQmVYMHprbXJHT3hCMFp3cE1jdlF2L0pMRkEySTBI?=
 =?utf-8?B?cEwvSWFpVjdJdndTQVdoMFVrRlRobWVYRmY0RzZCWmJVOVROeGVFT1FOUzhK?=
 =?utf-8?B?VDFlcWpHd0djZzdFU1ZCQjJlL1lXRHZEVmFnUmYvREpLcGlWUTFNU0RkNGp4?=
 =?utf-8?Q?sImGb/NHi4dt6u+Bz7IFtUu/sN7IIBmB9r60bo+u00qIB?=
X-MS-Exchange-AntiSpam-MessageData-1: 8Iho2cNu/3/VXQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d833e06-8753-4af7-53c8-08df1e9cba61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:20.2486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUMjJUCBrc3oLGRpNxCHCNsxgefINXPS7Nc/1Kx+ABwhKIN3px16JK/OQP7Ong/cnEkK1EivVqSah66ZEGyMJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Add support for reserving of ranges of IDs, with a usage in nova-core
for channel IDs. This entails adding bindings for the C bitmap
API for ranges of bits, then users of that in `IdPool`, and finally a
user of `IdPool` in nova-core, `ChannelIdPool`.

Channel ID tracking is needed for allotting ranges of channel IDs to
vGPU guests, and later for regular host channel ID reservation.
nova-core needs allocation of a contiguous sequence of IDs with a
specific length and sometimes a specific alignment [1].

About the tradeoffs between different data structures:
- IDA/xarray do not support allocating a contiguous sequence of IDs
  (ida_alloc_range() allocates a single ID within a range, not a contiguous
  sequence).
- A maple tree works, but is not as good a fit. The ID space is small
  (limited to 2048) and aligned allocation needs an alloc_range()+erase() retry
  loop (plus a Mutex around it, or new mas_empty_area() bindings) that
  essentially reimplements bitmap_find_next_zero_area(). See the maple tree
  version at [2]. For 2048 IDs a bitmap is also considerably faster and smaller
  [3].
- The bitmap API natively supports aligned contiguous area allocation
  (bitmap_find_next_zero_area()).

This is based on drm-rust-next and depends on the cv! series [4].

[1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/
[2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
[3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/
[4]: https://lore.kernel.org/all/20260917-cv-v4-0-547ef5727451@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v9:
- Rebase on drm-rust-next
- Moved cv! to a separate series which this now depends on
- Reference Link: tag from the text + indent code in patch #4 commit
  message (Miguel)
- Add reviewed-by tags
- Link to v8: https://patch.msgid.link/20260827-chid-v8-0-bc74c77d0214@nvidia.com

Changes in v8:
- Clarify overflow cases in patch #2 (Alex)
- Replace nz! with generalized cv! macro (Gary)
- Add cv! macro to prelude
- Split SizeConstants and adding new constants patch (Alex)
- Move alignment size constants conersions patch (Alex)
- Drop NonZero on IdPool, fix grow_request instead (Alice, Alex)
- Add shrink/grow doctests (Burak)
- Link to v7: https://patch.msgid.link/20260817-chid-v7-0-a5872e64d8f4@nvidia.com

Changes in v7:
- Add nz! macro for compile time NonZero
- Implement SizeConstants for Alignment + add sub 1k size constants
- Use Alignment constants + nz! in this series
- Add final patch converting existing callers to use Alignment constants
- Rename alloc_area/release_area -> reserve_ids / release_ids
- Link to v6: https://patch.msgid.link/20260813-chid-v6-0-160be5dfb5bd@nvidia.com

Changes in v6:
- Take a NonZero nbits in `next_zero_area_off`, `set` and `clear` (Yury)
- Remove `UnusedArea`, `IdPool::alloc_area` now allocates directly (Yury)
- Add patch: take a NonZero capacity in `IdPool::with_capacity()`
- Add patch: do not round the capacity up to `BitmapVec::MAX_INLINE_LEN`,
  which also removes the bounds check in `ChannelIdPool::alloc_area`
- Add more testing of Drop for `ChannelIdPool` (Yury)
- Link to v5: https://patch.msgid.link/20260812-chid-v5-0-6c767770b3f4@nvidia.com

Changes in v5:
- `bitmap_assert!` i32::MAX length for Bitmap::from_raw* (Yury)
- Only run overflow check on 32-bit (Yury)
- Link to v4: https://patch.msgid.link/20260810-chid-v4-0-c9f206fdcb97@nvidia.com

Changes in v4:
- Add `next_zero_area_off` to match C code (Yury)
- Replace overflow checks to match C code in bitmap-for-next.
- Tighten `Bitmap` unsafe contract to disallow Bitmaps larger than i32::MAX
- Link to v3: https://patch.msgid.link/20260729-chid-v3-0-20cc08032bbc@nvidia.com

Changes in v3:
- Use `Alignment` type in id_pool and bitmap (Alice)
- Remove hang check on the basis that it's extraordinarily rare.
- Link to v2: https://patch.msgid.link/20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com

Changes in v2:
- Collected Alice's Reviewed-by on patch 1.
- Address Yury's comments w.r.t. using __bitmap_set etc directly.
- Address Yury's comments w.r.t. following the C names
- Additionally check for an overflow case that causes a hang
- Added more info to cover letter + patch 4 w.r.t. channel ID allottment
  requirements
- Add align parameter to ChannelIdPool::alloc_area() plus an aligned
  allocation test
- Add missing INVARIANT comment when constructing UnusedArea
- Link to v1:
  https://patch.msgid.link/20260703-chid-v1-0-84fe8259e46e@nvidia.com

---
Eliot Courtney (9):
      rust: bitmap: use function-level cfg on kunit test
      rust: bitmap: restrict bitmap length to at most i32::MAX
      rust: sizes: add sub-1K size constants
      rust: sizes: implement SizeConstants for Alignment
      rust: use Alignment size constants
      rust: bitmap: add contiguous area operations
      rust: id_pool: add contiguous ID reservation
      rust: id_pool: do not round capacity up to BitmapVec::MAX_INLINE_LEN
      gpu: nova-core: add ChannelIdPool

 drivers/gpu/nova-core/fb.rs           |  10 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs |   2 +-
 drivers/gpu/nova-core/fsp.rs          |   4 +-
 drivers/gpu/nova-core/gpu.rs          |   2 +
 drivers/gpu/nova-core/gpu/channel.rs  | 198 ++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs       |  12 +-
 drivers/gpu/nova-core/vbios.rs        |   7 +-
 rust/kernel/bitmap.rs                 | 336 ++++++++++++++++++++++++++++++----
 rust/kernel/gpu/buddy.rs              |  26 +--
 rust/kernel/id_pool.rs                |  70 ++++++-
 rust/kernel/io.rs                     |   5 +-
 rust/kernel/sizes.rs                  |  47 ++++-
 12 files changed, 641 insertions(+), 78 deletions(-)
---
base-commit: 10a6623a24a85708650efad7be15182289403cd7
change-id: 20260608-chid-18fa943c6d6c
prerequisite-change-id: 20260828-cv-8d4e952fc14c:v4
prerequisite-patch-id: b913a24359e679cb354298102cf5de13760a3c27
prerequisite-patch-id: 01ec2e5a44b393a7ce1ee820654750dd4743fcb5

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

