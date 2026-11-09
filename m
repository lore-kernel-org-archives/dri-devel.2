Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D007606D812
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FAgmScmJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8411610F0BC;
	Mon,  9 Nov 2026 08:33:23 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2996410F0E7
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3Ol+Rnbv/gVWY6hsj4pA4qgDI5ZzvrjLFDdC+YjZamigRtRffIN5aBb+6Srzmk8xvexV7mGEPOz5NJa1XwouS/8qYIfW8F56c8bq00XLxKLaJJk6kkp/iv0bgvfFPvktA5EDMnreopgtQ10KmpERrrSUdc0/iQev1rBhQUCLAaM4XNIyvP5sBeuaD+06Vj3YkwihuOj6XOo3/XFb7mkb9J7Dc2ZjGU9JL8SLKvlBW/+HZA708Tb5k/4M4Sgpa6jnxPu2Y/KvLmmYBRCW3mBTfpu9w4SLTHRGtQr4skTqfe2qDq1CbugvMNzLaXn1TdEPakk2tDk6hbnw3RMw9ZgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIAjXz0niB413FvdvMNQbqZfuJNXljq2Ktm9jURqA5s=;
 b=JR8nB8eBjWwAg0EnROyyvp3RPcGR452Dq3NCVdX5OtZvItzFtahd+Qh84jxf0WqwSCk0+jnEeE87gfMzXLud9rzNLqEyoAX70ggPvxorHlS8R9ukP1ETFr306twtEZNjCml6DpdTWis/iJ0NzgcWFWPQBCSu3yGU2VN4VTH4eRHmiHt0Ed2tXrJHF3w0jfVcYQPyr80AoQQ71FP6AMU5ZTwuVu3yXbO1gSoVyauNFQSbcQMkZ7TNqMXtqj92CRj6VfrJdF61kfS/7d3gitF0OTpJ+D4uMBSrM2x0Te/3Q4LXEl8hrmsVhrilFAG+sCQfWSyenwLAWcm1F7fsP8fE4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIAjXz0niB413FvdvMNQbqZfuJNXljq2Ktm9jURqA5s=;
 b=FAgmScmJCdIpb3h9KLfLsthFVSrI3FyQ5COSWOw3XGV2rFJe4YQeHazlfDW7zDI/iIj2fU1O5kdXGN7FWfaoEji61NVTbx+0HcyCJ/q+bHhGi1o8szUhZDPqKNddTuBK/yl/3OvtBjNT0Rdwlc9gRf/2HKJEKo/pI4DsOLiVPu+lfbOQf335Mz30FsCc16oqn6IJG3tbJzzR6jgWmZwcdy2ff0bTeBJ5hNS4FGpX0zrxzzVc9PdBhThpz3K6aqd+ffCI0BXBhRRETBBnnPRDVl1R4yKjzq61CU/4f/AAjdASIxTLLQc5bw8T/E00QCwshohP7Ti9rNYhxqmsHsDI4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:33:10 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 08:33:10 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 09 Nov 2026 17:32:50 +0900
Subject: [PATCH v11 2/5] rust: gpu: buddy: use Alignment size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-chid-v11-2-082aa9bf5a91@nvidia.com>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
In-Reply-To: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
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
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0291.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d65d99-6c05-48cd-e789-08df3e3c1611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|10070799003|376014|22082099003|18002099003|10067099003|921020|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: SdMgx4Oqb41BmahisXWVmTVQzfBMOtfkGe6yqJPTH0H/23SwLIOpuMCBY839D0mG1ea6KAc2do/jIUTrU4sw8xhJplA+Ekdyp8oL3IQIC94W51mDocOTuJFN8Lbg8oIXz4aMz0VCzGVVAMAYXypkzX9wMmkoR57pw29/a3L+lVddKXo47JLvc/EYLCm3l96iEYs/X002Xa4pt2cDXIWurkXNgZUAU3oXajHTNQbDw2Nka4CM0KCVW2GUNaMJw9AiQQaPDWtochRWQZObCNqxsH8nV2H16IY3tDBnjUM0ul/ho0/tFpDwD+1Gxvu6ZVfkV8r7VvJXhXXyKQpObdpM3P2OsT2Vvla/nBXrl8AKpcw8BVJq4ITqAt91zOtCli1DjENoUHQcak2PIf9ORLpmeGZBKK5CQpvdIi/1mVvk2HVN3BCya1FJh5MHShNgytEEXlrDyehcThDZc6pRaBDJLDXUwPstTh3ed5RkgKYqRoU+jY6M6UMKjV+XHREDPu5h4GNYXjrwA4wv91Q3EeKTxpPDzlgIWZO6jdzUyC1hVv9MmqgP/8T4zsg5BUcBGJA/0rin1LgquE/sJ2kzChrDS4z6oUUYhOd/W6atSwweh6jksnIX3N/dHQgqKMSitaI3mDOe6Mh9DP7p1KG2mBA+xinZ9g43AnHQF0YxYcMnM358If5UoQnPNs2Xp+D1nJf1fSDboEQWjvQiVBfVSPSHQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(10070799003)(376014)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm4yOVh6Q0F4SWVuMGJDSnUzMFJZdkR3YlI3T005UlEwWDM5ZGxTVDJ6aVEz?=
 =?utf-8?B?ZkFieHRIYnZmM1Z4RXhHK0UvaVBoQVk0eTRGSEtIZ0trb2gwdVJUdDZrUEh5?=
 =?utf-8?B?RUdsUkxKekVYa3lGTk8rWWxuUXYvZjNETmt1MEtacFBadlV0eTVad01zYzdz?=
 =?utf-8?B?ajVTSzZidmxNc2RINURIWEk3R2FpWGFBM2hGbis2amNyL3pGOWU0WmJUQ0Rx?=
 =?utf-8?B?dnRxYzM0bXRFZTdNcW8zK0lJSkZQWXptNlpIL3A1d2lFVm1vWW9VelBUcVlS?=
 =?utf-8?B?UEJaQUd3OGtHQndTR3JrYUpBQkxiWnR3bjJQZGV5eGlyUTZ1Q1FmekNEeTJq?=
 =?utf-8?B?cVFKRFRYeDFaNjNqeTlQL2Z6Tk0vc0RNV1lrU0ZhK0pwb3lIWDZxY0hnOWVS?=
 =?utf-8?B?VlhmUTBlZWQwdU1yMHpSdjZxeXpMZ3U0SFVqWUxMMlA5aE1rVEU4aWJLSTJN?=
 =?utf-8?B?dTgweDJINjZ5emx5ZURhTGlJRXQ3NHJ0SkV5RVlVbTRocGRWbFQ3SEo2RnZ4?=
 =?utf-8?B?UUZISklGOTVCU0hlZnRNRUIxVVFGOTVGbXh3RjNLclFIWmxPdDZoY1NRN0J5?=
 =?utf-8?B?MEJJQUdoK1dwNGsxNkJEeXNXK3ZEdER4MUZOZTBuSkVvUkx4QVowNWU4bWhZ?=
 =?utf-8?B?OVRhQndySmY5MHlsV3crWTgwY3E0YUpvRlViWlZGdEJkTlREaFJNcU51QTdQ?=
 =?utf-8?B?ZnQvcDV4K3N1V2Z2by8xUmxZWWkzb3RwY2FrcjAyYnFmeFJqTVdOVmZnM3dk?=
 =?utf-8?B?Y1lESy9la2RRTngzcy9iRVFjN05uaHc4TXIwQkkzZmFHbXdVRmFWenFkQWdZ?=
 =?utf-8?B?ZmljSG0vWXVLWDVqYzM0VElKTHpGWUNXaVNPUHNVUzd0aFVySGJ6eTE1SzN1?=
 =?utf-8?B?NTFzSUZRUkNzNDJPdTdhTEJXYndEMVd4cTZaSXVLZC9MaU5aekJFaDlaSUEr?=
 =?utf-8?B?RnVIbkt1T0c1d3pQUUhoVDZyeDBNUGUvVjBKUm1BaUhTMUhZN2NUT2pNYWt1?=
 =?utf-8?B?WjBFTGFrdmN2K2w4MUd4NE1sWFFZZmJmZC9CdzhDa3B6MkJSdEdRQWVSVDNB?=
 =?utf-8?B?QzZQRGxnbzNxVjdwTG9JQlUrdk9UMnJ2QjRWQ3ZHcEowSGZXNlNqYWhuRDJM?=
 =?utf-8?B?R0w4NXNMOEdlSGUwVGM1Z2grUXJtMjViNmpVRG1YV3ZPL2JQUmxhUXRDd0JP?=
 =?utf-8?B?bkEzNjExNWR2SThXVXkwVGs0VUNyRUNRWUt5TWE0RVZvMzQ4eUE0ajV6dTFH?=
 =?utf-8?B?cm5SV29WTFdyRytEdXR3aUhqb3Awa0lYWXNDcWprTy9PS1FuR0R6czVKSHNy?=
 =?utf-8?B?NWV3V0VzUTNNN2gvRUlHckxxNTZhZm42Q3VSK25ZU0ZGK0E2RWN5NTZ0cVFY?=
 =?utf-8?B?UWxTbjA4MTQrM0RObW5TZEpYQjNNRkpyaHFyUlhIQjNKRmNVS1FRMGJFaldi?=
 =?utf-8?B?VWkzcnJyY2Q2dnMxd3lZWXBaWW13SCtvcnJFeGpNcE1MU3Q5NHpnOUR1Z0dm?=
 =?utf-8?B?Y1BuWjZhbldwZjNVOE5pSE9id243ZEFLWlE1eHRodUxJb2NkL1pTZVdYTGlj?=
 =?utf-8?B?eFB1ZzNzTGFGRTdlTDl3blFLTFZCNm9uYVhNODJ1cFRrNzBqVWo4TUpIUm5V?=
 =?utf-8?B?MnBwNDRZc3NIYUFXbWh2Wnc0TXF6V0RiYjBrU1FNWHJkVVI1MDNRZnhIaGlt?=
 =?utf-8?B?dHp6UVY0V0xrSFVCUzhYcklyVnN2WFIyaGFoYWpqSjNFd1JiWFZ1TzBPZ3R3?=
 =?utf-8?B?bFpiejRLUG5SY2x6ck9PRzFsaWhIYSt0WS9uUHZKMmhodHdtWHRFRlBrekoz?=
 =?utf-8?B?aHZqN2QrbHlNVzJqVlQvaDNwdlgvNFh6MEJxRHpjbGJ2bXgvdGFDRUN6T3Z2?=
 =?utf-8?B?Vm96RHk5T3hwZEIreGZERndaVWxTN1dUVEZpNmJZWVB0SnVYWlBTVHAzcmY5?=
 =?utf-8?B?bnErRDBjMnFic0pXL2x5ZzY2Q1lUNTFDaGU4RzhFNW00YjluMHVFeTU1Y2VN?=
 =?utf-8?B?OEYyVUNWMkFrRlkxSkZJZ1R4L0ZwSzN0M0tKbGNtUTRxTktqL1dkaUZRVy96?=
 =?utf-8?B?a0JXLzB3cmJIbm02dTFPMlZUbGNvaEpVQzBLOE8yVXAwZGN2YURhSzQ5Wm5C?=
 =?utf-8?B?RmdUQkRpTDZvU1hhSmNsWjRUTzhJaUxodjRLTjYvNVhTZm1Rc2tBZHFkU00v?=
 =?utf-8?B?clNCSzUzUmhzQ1ZpazBkU29Bdmh5WHFpWWtlaTk2ekt2THlCTFJ6UUtrbUQ0?=
 =?utf-8?B?MDFpZ1E3VWI3dHA3RXZKandsUjJMbjRoWWduQXdUMFJpdGRPaFd0RUttSHY2?=
 =?utf-8?B?MTEwaVpzWFcxTU9ocEg2TXFiZVNTejFjaFZIZGQvRnh6VER5K3Z6cFJhOFFI?=
 =?utf-8?Q?ue9wRj5ELFtjuhSmoBkZomh/R5PFDaRCjCc8DwrDQyfKp?=
X-MS-Exchange-AntiSpam-MessageData-1: 11J1u0fVhhVDcw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d65d99-6c05-48cd-e789-08df3e3c1611
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:33:10.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3JOa+pUwNix7fS6iIvbO0kL76xsEMpKd4wb2c7wVQCT0Fka+1hkEA7DfJ2EgigjnjBu4/zzeGnKOJ0xRtzapQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use `SizeConstants` for Alignment that are implemented now.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/gpu/buddy.rs | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
index d502ada6ebbd..691bb40629d4 100644
--- a/rust/kernel/gpu/buddy.rs
+++ b/rust/kernel/gpu/buddy.rs
@@ -31,11 +31,11 @@
 //! let buddy = GpuBuddy::new(GpuBuddyParams {
 //!     base_offset: 0,
 //!     size: SZ_1G as u64,
-//!     chunk_size: Alignment::new::<SZ_4K>(),
+//!     chunk_size: Alignment::SZ_4K,
 //! })?;
 //!
 //! assert_eq!(buddy.size(), SZ_1G as u64);
-//! assert_eq!(buddy.chunk_size(), Alignment::new::<SZ_4K>());
+//! assert_eq!(buddy.chunk_size(), Alignment::SZ_4K);
 //! let initial_free = buddy.avail();
 //!
 //! // Allocate 16MB. Block lands at the top of the address range.
@@ -43,7 +43,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Simple,
 //!         SZ_16M as u64,
-//!         Alignment::new::<SZ_16M>(),
+//!         Alignment::SZ_16M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -74,14 +74,14 @@
 //! # let buddy = GpuBuddy::new(GpuBuddyParams {
 //! #     base_offset: 0,
 //! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::new::<SZ_4K>(),
+//! #     chunk_size: Alignment::SZ_4K,
 //! # })?;
 //! # let initial_free = buddy.avail();
 //! let topdown = KBox::pin_init(
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::TopDown,
 //!         SZ_16M as u64,
-//!         Alignment::new::<SZ_16M>(),
+//!         Alignment::SZ_16M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -114,7 +114,7 @@
 //! # let buddy = GpuBuddy::new(GpuBuddyParams {
 //! #     base_offset: 0,
 //! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::new::<SZ_4K>(),
+//! #     chunk_size: Alignment::SZ_4K,
 //! # })?;
 //! # let initial_free = buddy.avail();
 //! // Create fragmentation by allocating 4MB blocks at [0,4M) and [8M,12M).
@@ -122,7 +122,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -133,7 +133,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -145,7 +145,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_16M as u64),
 //!         SZ_8M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -178,14 +178,14 @@
 //! let small = GpuBuddy::new(GpuBuddyParams {
 //!     base_offset: 0,
 //!     size: SZ_16M as u64,
-//!     chunk_size: Alignment::new::<SZ_4K>(),
+//!     chunk_size: Alignment::SZ_4K,
 //! })?;
 //!
 //! let _hole1 = KBox::pin_init(
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -195,7 +195,7 @@
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -206,7 +206,7 @@
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Simple,
 //!         SZ_8M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlag::Contiguous,
 //!     ),
 //!     GFP_KERNEL,

-- 
2.56.0

