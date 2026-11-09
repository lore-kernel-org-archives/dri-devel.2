Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C5606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hG3X4S9R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3233710F0D1;
	Mon,  9 Nov 2026 08:33:39 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF8710F0D1
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 08:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCrgSzKzjRAQFLJw9GIpUBQkMs3wHjqcuy7VR4wyDBg4rzjpL/UClr6XkqWe4TJtPa6ksi4gY+dVf35jigoe6WX4ty4yTtzQfZ7G9HH28vrJrfHCifi8HpRPMhpREfQ1ynvvCq8HS1ICVclU6hXr9e2m18s+ar8JHmla8Egc2EFflZCTHlb5qM12ADdJY6LkZXN1dEW9SaFJv0FIUpYwuaZrwQrYPVhdqa/6e8WfNjlKKQ/oz/3CZ1dO9MAcpr5axMYbKev7EVVX9G4vOwjq/jd2XNxlj/uLyz1jvP2iN+iO6C5a/9/HquNBfDwH+2nZ1GfV1XoXGL3PRdW3/BTK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNPnymYnORIC15vqHFbXKXXt0kQA4/nJoUBhP55I0Do=;
 b=XXIqDwiecXBs/YMwNjcaZG2jN1Wblj+iVGxHT+A7TMYOjYAl3ih48f6h3h5GBPgiVM6BChwQ9kCJACHk77NEYDrjf1owm6pojxmtGifFPJwDLh1CVFuO/BptVCplRcD/2YVk9kRqi4elsuUMXPO9wU18twvEIqCGA9Vl3eoUR08S4SUJhSh3fEKOJvIYnca3FC7ivRP2PeACkXi0QsHlPjjuAwz9kJdfHcoWjL8bnTKoIN5fwYuI/u+oFF8+iwoJ5rtnR3VMURlW3LepLPGkGTwHSMk2IAswhUj4EYgowPHviioCS8inXaphp2YJ4GyrzydcenoVppPIUV50WgKGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNPnymYnORIC15vqHFbXKXXt0kQA4/nJoUBhP55I0Do=;
 b=hG3X4S9Rfqops2upnnxCAlxeJH3WJiP6oXWzrxo4BuKJ0ajKxUuyZa5duW99A+muw3ag4q1e4EyGsCDB2/xSU0Bf/XZiIvzIUolC8e0OgdZCVbRs7K+mLM14I8Ue7hgTDldGCv85M0TDQbYnks9GQiz/sdtX+NTdyAcfb87oZ5kY1Z3Dhxq1pPU/jAUrLNUGj4pBQvHZ9MvubVXnieBsL57yu3M7PMjYBl12Wq3iibPmXwVFNqSOcA7w/9rCOGQQDMcMYCjsi0TnioMWacC4ov85HV/+KIKN9V7gI8XN4tAqfgX1bwQD+uvI9bdhVb/sKQUIwqpwHA+ponluWJ0ULQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 08:33:22 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 08:33:21 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 09 Nov 2026 17:32:53 +0900
Subject: [PATCH v11 5/5] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-chid-v11-5-082aa9bf5a91@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0244.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: 10290ecc-01ec-4cfe-fdb8-08df3e3c1d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|10070799003|376014|22082099003|18002099003|10067099003|921020|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261022113327099003|56012099006|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: F9ZDnU8DXL0zxWZ+msG/GG/eseTP7xsYGAdM5SZMnhDBg9TMZZqtMS4nCXofmJpzBxIt/3OIVtJyn4wnofp1J6kAfmv2WvzBHbqRniJC9Y1o2RIGcxjeSMc0llCO380ZqyUnLe/A9gT5M0+QPEKaZVLqomj8JXeAni5sDZDolkO8/fgG9RTg7n4AJdr+hfqm/T8tCa8eaMmo26OazmICtpHoJP3oLx7QtQVnXGIjzf8OpfmScnNO3yL8JkgnF0UTv4DwXGriZqcmIPh7U9UT/RZ3vCyGj3UDBRd88iMSfeJrMuJ3UIyx1fzCBFaVZJtT/nbve5UqLhdJy4+L4MgSDGPY3M/BF9vAyqxbv26X19FqXwQQidCaCDsd/QYIBynRttCrLSfamEz2c/vTHJ6GoT5yaWDAJctC7qmbCgZS0FuwVNYq7ccUKOQizvtJmucY+EtqHQcqj7pBtpBv4UaNzvPgnHt1zH73FKxXS0lYAavNbd+sNMeBB9g2mjSRGkCip/oiK7PJMknptol1bk0QlWiR//P/bS54dcb+OyKh6/1JeoG+mKumC65U0LHo8cbzlc1S0fJv+qEPfk5r2BwFxPCknhurD6FuheS56OjT/XYEPs+hkMZWYwlZ7WBiyJ3IzJQj7ZWZ7451so2dPG+6Ifk4dTFNfnrS3GhFF1D2SQ6HdBUAes5nzCHY35lIkgqb+gXYF8TRTEelTr5U0jiSkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(10070799003)(376014)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022113327099003)(56012099006)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21PTGx4bW1uMzl1R1RvTkRGbnk4TnZhZW4wSXJGcFlxK3lJcEpReklPUkJr?=
 =?utf-8?B?VVpKcUluOHg5ODBVOEVVNWYrQy9UQW1XNHZKanUvdytncTRVUWs0bWRKZjNN?=
 =?utf-8?B?VEtGN21vV09qZ1N2WThma0NiZ3NkQXVCQldqYnNETkFWVWJta1VlTzM3OXFr?=
 =?utf-8?B?SmlKVXhyMVJaQlErZE1vckUvQlArK3RqQWRZSnZkbTRrQVlMdXJGblNDbTk5?=
 =?utf-8?B?ZVFUSTBVbno4WEM4d0xXaGF2bkNVNzZIb0kwNXRzUVNkK1NDWFNxSzdlK3lQ?=
 =?utf-8?B?dXpvOGxydEFFSmdEOW5xU2N0SEgvU3dySlNkclNJOUZIWUp5SnBhcHdzZjdJ?=
 =?utf-8?B?bHNGNnArQkhrOVZDWGdFYXd6MGc1RVIrcjBYMnN1bmlsblJhUExqM01IaE1n?=
 =?utf-8?B?V2JQVmM5YnNBdkRPNkdQeExnL2VyanZWYnVhSjUyMVhZSHhuU1U2clFaeHVh?=
 =?utf-8?B?RUcxQlkrOFRlM2YyQkhkSmJpZmlrOXpuNGM0TmxFTWt0bW9mWE1DZ2RSU2pX?=
 =?utf-8?B?czdFb2NDTzJ1ak0wdnB4ZllILzVUUnl4M090cVRvRzN3cStuVHAwQzhnZmJE?=
 =?utf-8?B?aHFUNkZsZjNaTm8vR2VnZU5DUzV4dHBZTFZ6NXBxYnl2KzZSVTNtWFh3aksv?=
 =?utf-8?B?TGhDK0lYREx0S01tTFdGSXJZR1lMYXc2eDdJVmJRMmhkWnQzT3JLcTR6bnV1?=
 =?utf-8?B?OGw4bU16UkRUTUZ5SmV5bW9WWWp2MEc2TE5rSFdCT1lQVEJJa2RUaFZScVpr?=
 =?utf-8?B?aXVTTkU4ZGZScFZQZWlNMStrMndDTUMvbjh2LzZUR2wzaG9TbjNjemNjT2FC?=
 =?utf-8?B?MlJrSTArSWhjUjBxcnIrZFBEY05pbHpPbTgvWUtldEhKbzBWY1FaTEMrZHlL?=
 =?utf-8?B?VitrZWtLYmtmZU5jazd5TVdMMjd2UUlMdURxZkRDcnl2UjZPS2dMdE05blRB?=
 =?utf-8?B?RUg1ODdQcm9pZ1R3cGdEa1JXUEJtRHgyb2YySE8xYUxGUGxDTGU2VS9JTVp2?=
 =?utf-8?B?YkFGa2UveGI3ZkU3ZmtBUkk3ZWNHcnovcjRzQ3hBTzNMeG9pZTRUUEFjTkJU?=
 =?utf-8?B?SEV0bGh5Z3RsRnZHSXFNUFJnVUFFbWNMV0dicHJLK0d1eFR4TXdIbFhVaVJH?=
 =?utf-8?B?N044ZG56Rlh3VGJDWVpkQUxsT0NMSktOYTIzb2NzU0R2dXpiZXpxWkgraUFQ?=
 =?utf-8?B?c296R0hEQmNYTVE0c0V2dkJZbEZnVlY0dk5PNHhqdExiVTNHRzRPQ2lNbjMz?=
 =?utf-8?B?MTJsUnZQMTRBdzJvZ21MSGhDenVxNUk0UWpZempWUGJDQVNTbVhiQzNzYlBv?=
 =?utf-8?B?bmxqVnZKVDhVUlZCcUxTNHAxTTFsKzlZb01CRk9sd09sZnVnVjBTdG9ta1Vs?=
 =?utf-8?B?elRvWnhoaE5zL0RBUWRHRkZFSTUxTmFZbDMxSTQ3Qmg4U0JUcnExSXRTWHVZ?=
 =?utf-8?B?QXJsd0wydjRDQUU0YjJYNDh3VGo0RWFhaHl5dC9DL2l6c3BkZTNCN2RrNWtV?=
 =?utf-8?B?MmowTVhGanBsYnhnbWpjeWh0ZG9nbGRBWjVDb3gyYVE2Lzg5MEhZbWo4UEhC?=
 =?utf-8?B?Z1JJWE52OWp2VDVEQ1BFUGxlQmlNN2ZBbkEvUCtuM3V3U24vQ25PK0djK0JG?=
 =?utf-8?B?QjdmeDJiNWdMbkNLUkdCUUdlN3l2YkZCdGJIU0RqQWwzLzZuNGp3dEo1cU5y?=
 =?utf-8?B?bzBtcVFPRDBPYzhtTWtzUnRvZDVkUEZyOTdxMUlWRFErcTF0RU9RUUpKYXBa?=
 =?utf-8?B?WFhTbnNSMUNPR0podFU2RFNwVWlCVTRQNmtJazA4bG5ocjRSc0owWjA4UDZk?=
 =?utf-8?B?ampNam43TWV2dC9sa24yc05qeHhrUVY3RmllVDN2YTFYTDRkN0RBUTdTQ01p?=
 =?utf-8?B?Tjl2Z0Yydmc1b2J2WndHQ1dGZ3RZSzRHV1pGSk1QRHQ3c09RKzBubGg4QjdE?=
 =?utf-8?B?YkR3YmNpY3RVYnExeHJiNkFqY291YVQyODJSTGp2c3dESUQwVTNHZXR1RlV1?=
 =?utf-8?B?MjlzUXBEZ3UwTDBmZzN5YW91WU9zblEyS3luM0p0KzNqMDFSUjJIeWcxK21O?=
 =?utf-8?B?Y1NtZmxrcmdQamxUTmc3bGNXeitXeGxxRVNOcXdPRENOdnBwQ1p3LytnczlP?=
 =?utf-8?B?R3FRRWFLd0x1c0RoSEcxdHIwTStBNFlNUlFrUjFyZjFMUG1SaSszN2Z3MmhK?=
 =?utf-8?B?d1JEUHJzbW1rN0lLdklCV0oxek45KzJJVjQwRDlybXJwb1RETVR4eVBNeGsz?=
 =?utf-8?B?bVczNDMwNmFQOTJUQklMUWc4c2l6ZnZnY2xrNXpHSmpnWGpMb0F2TGxKRXlN?=
 =?utf-8?B?NTJVcFNOalc5TFdwS1pqZVpvSUhudTBJWHVmQVozUDlSU3lhdEFGckFlOEpj?=
 =?utf-8?Q?0/rI09VtYYbbvZXGefMmL1HbwSsJru7d66WhVNeNfZCfO?=
X-MS-Exchange-AntiSpam-MessageData-1: ErP1K43MaGzbtg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10290ecc-01ec-4cfe-fdb8-08df3e3c1d0a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:33:21.8414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0726Jn+DRDhW45u53Q8zKL8IVExISRkfqb4uaoW+4MJIYWGaVx172CJ6yNJZsutDevokUEsi7xjz4T+MVP6PoA==
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

Add `ChannelIdPool` which adds automatic tracking and releasing of
channel IDs on top of `IdPool`. This is necessary for apportioning
ranges of channel IDs to be used in e.g. vGPU.

Channel IDs are allocated as a contiguous sequence with a specific
length and sometimes a specific alignment [1] for vGPU. The ID space is
small (limited to 2048) and allocation is not on a hot path, so a
bitmap-backed `IdPool` is a better fit than IDA/xarray (which allocate a
single ID within a range, not a contiguous sequence) or a maple tree
(where aligned allocation needs an alloc_range()+erase() retry loop that
essentially reimplements bitmap_find_next_zero_area()) [2]. It is
also faster than maple tree [3].

Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/ # [1]
Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/ # [2]
Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/ # [3]
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 198 +++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index d185e927233f..90b1d24cdf00 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -53,6 +53,8 @@
     vgpu::VgpuManager, //
 };
 
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+mod channel;
 mod hal;
 mod regs;
 
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
new file mode 100644
index 000000000000..485efaba059d
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Channel ID allocation.
+
+use core::{
+    num::NonZero,
+    ops::{
+        Deref,
+        Range, //
+    }, //
+};
+
+use kernel::{
+    id_pool::IdPool,
+    prelude::*,
+    ptr::Alignment,
+    sync::{
+        new_mutex,
+        Mutex, //
+    }, //
+};
+
+/// Pool for tracking reservations of channel IDs.
+#[pin_data]
+pub(crate) struct ChannelIdPool {
+    #[pin]
+    inner: Mutex<IdPool>,
+}
+
+impl ChannelIdPool {
+    /// Creates a pool managing `num_chids` channel IDs.
+    pub(crate) fn new(num_chids: NonZero<usize>) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            inner <- new_mutex!(IdPool::with_capacity(num_chids.get(), GFP_KERNEL)?),
+        })
+    }
+
+    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`,
+    /// returning a guard that releases the area on drop.
+    pub(crate) fn reserve_ids(
+        &self,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Result<ChannelIdReservation<'_>> {
+        let mut ids = self.inner.lock();
+        let range = ids.reserve_ids(0, count, align).ok_or(ENOSPC)?;
+        Ok(ChannelIdReservation { pool: self, range })
+    }
+}
+
+/// A reserved contiguous area of channel IDs.
+///
+/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a
+/// sleeping [`Mutex`], so the area must be dropped in a context that is allowed to sleep.
+#[must_use = "the channel ID reservation is released immediately when unused"]
+pub(crate) struct ChannelIdReservation<'a> {
+    pool: &'a ChannelIdPool,
+    range: Range<usize>,
+}
+
+impl Drop for ChannelIdReservation<'_> {
+    fn drop(&mut self) {
+        self.pool.inner.lock().release_ids(&self.range);
+    }
+}
+
+impl Deref for ChannelIdReservation<'_> {
+    type Target = Range<usize>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.range
+    }
+}
+
+#[kunit_tests(nova_core_channel)]
+mod tests {
+    use super::*;
+    use kernel::sizes::SizeConstants;
+
+    #[test]
+    fn chid_reservation() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(2048)), GFP_KERNEL)?;
+
+        let first = pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, first.len());
+        assert_eq!(48, first.end);
+
+        let second = pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(
+            first_start,
+            pool.reserve_ids(cv!(48), Alignment::SZ_1)?.start
+        );
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_drop() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(8)), GFP_KERNEL)?;
+
+        let a = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        let b = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        let c = pool.reserve_ids(cv!(2), Alignment::SZ_1)?;
+        assert_eq!(0, a.start);
+        assert_eq!(3, b.start);
+        assert_eq!(6, c.start);
+
+        drop(b);
+
+        // Only have space for 3 IDs right now.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(4), Alignment::SZ_1).map(|_| ())
+        );
+        let b = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        assert_eq!(3, b.start);
+
+        drop(a);
+        drop(c);
+        drop(b);
+
+        // Everything was dropped so the pool should be empty.
+        assert_eq!(0, pool.reserve_ids(cv!(8), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(4)), GFP_KERNEL)?;
+
+        {
+            let a = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let b = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let c = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let d = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(
+                Err(ENOSPC),
+                pool.reserve_ids(cv!(1), Alignment::SZ_1).map(|_| ())
+            );
+        }
+
+        assert_eq!(0, pool.reserve_ids(cv!(4), Alignment::SZ_1)?.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(5), Alignment::SZ_1).map(|_| ())
+        );
+
+        let head = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        assert_eq!(0, head.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(2), Alignment::SZ_1).map(|_| ())
+        );
+        assert_eq!(3, pool.reserve_ids(cv!(1), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_aligned() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(16)), GFP_KERNEL)?;
+
+        // Alloc 0 so the first fit for the next area is unaligned.
+        let pad = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.reserve_ids(cv!(4), Alignment::SZ_4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.reserve_ids(cv!(8), Alignment::SZ_8)?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(4), Alignment::SZ_4).map(|_| ())
+        );
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(1), Alignment::SZ_32).map(|_| ())
+        );
+
+        assert_eq!(2, pool.reserve_ids(cv!(2), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+}

-- 
2.56.0

