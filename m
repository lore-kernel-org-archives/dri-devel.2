Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6888F108B916
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C1410E24F;
	Fri, 20 Mar 2026 12:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gq9qRXq8";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E8110E113
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehnznGmTQBRFy53rqQe95vQ49E03ePFt0delfvUDy0zGrDzkHlFTaJGfH6zXdgChJlTLCMXo0l30jSDfZgj8P9STOYxuE3Y73XxWx71qHDGGOhjfqYJ5UQpBpXUGqpPP301KQ0hbr0zq88UFROfokNbb+AVCEgDDO8F7MXqw84oxYl4cAhqG8mHkSGv4afHMSr/j5hXahKdA5SFOp678hVrghQzQH98uz5BWSipIo93FP/w2pDmc50B+IaHj0NluFNkIPlLK3NudVA3h69lRVDlDr2nliJstrFRU+32ORDRTF1r+8iiVn99fNX3eTd0Oply1WtY/qRw+v/DKbm+wxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iIOK+1e5O6e1XqfxTr/B/QwVKvQqvyIR+/564/awaE=;
 b=D3qskkHSQThSHU2jQNSq9/7wGnATn2zN0FcPaZNfT3bhthtIwKoy2YU+X8+Asfls02Ie0UfzeiBgcH6Uq24sDiiPsbDaaIWFLTLwaml/8POmHivX0M/kxaAe2NOe/dG6ecjqY1eSyL0q5GXtjN7vDpv1SHOF7zrw+EmKzPixc2qYhs95UP7TA5yn1j/kcncG8589/Zvr0CyKdnwn+Am04cCHpBQcMQeu5Qbf68M9NNp2EM5KE7FLG1KM8RAciNnNRFNfjs3V5+0OXmspgbhxpUZqQ9ceYZ/Bo0C8A0r8vKqk3Rh5JGWx2Q8zUKmeo4bsFAKnl4MwAudredjb31xJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iIOK+1e5O6e1XqfxTr/B/QwVKvQqvyIR+/564/awaE=;
 b=gq9qRXq8k4m2//dJ12TxJeyGcrNX3YIsx6ieeh20P3Psxku7yiXq2G/qEr3YnimW/Bl7b44S1/gPUB5SBpQe7ua6Tex79duDkdBtM3PBnzhWbEIsldYJnKxnoI4PG8ZTx0i9seUY0W2V06SXqzyBEE/q6uL4w1zSxzd+D55ovBH6psBiMGvonR7pT3A0EFnXpmRAqqvu5qk6byQ5+yo1vxVQGl4En4EkGE8D+rqnGMHmmxfsLy/LzgApyiMZDh6fJr7G3Rsgk1FmmIoIsaxJerAa3JbU+PE77T+TXZUlwPbskonfV4276vsXhmGltwmEmOCYG9WgU4GhotpqcgxR2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:52 +0900
Subject: [PATCH v2 03/10] gpu: nova-core: convert PFB registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-3-88fcf103e8d4@nvidia.com>
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0372.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ca6780-1a19-477a-8f52-08de867b0742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: UKQYPbZThm6s3e4wio7by1YhSHuYTafu7kYKkZFZyWOuoxXcfLMr+Vn4LRXHvhQhbp+A9stRdpFsPFMDOyclBrI2FCZ3OIp0+bnDM3rIulXfUCGr9rArntvkxQam/XOBENXcfez07p84V/RO5TIzHbE5e29fq7Jdmt2i7uK+XI2DzyLnq+fwSLZBhSgcY+CxiH9VUgCdzNdxPM2/oxTMYtFsy95iflIHEe5qJNqi6Rcow95hUXVwX3ytnXv/YYseVzXPv5uyiOu9rySOpJzMmdNoP7p/WO4TRCyf0GM1DJE4qnfiixCkf0ekkDOPIV+szEFGDkO0kL6s2I01ghW2SMGytT7Ns006CqbtXSgvOdQPg9M1Wl2SWeRgIssu+ZjbiQ0kiOAwjqYM2FMcOOg+P6wSvtLoVJbjLtExSFuHU1ZjbpAG/eD3oRnSJIU9RtOgZxZMSKxO+KVVjYR3zy4aVEHCD+hqvSZYePbmRleOoDEDFQ4jEzXMs08lI1MxlAe8/7hVqY4WuRFGdjCPetfiIOXP65f8PpPN55tYDlcFQm0lIM60JLlAsL7sxNELLF0OTqxOm6ysOj/Fc1FagGPUtFFFx6sQVg6/AooPQ1Y5w37PE9eaEEb0ZA5V8nqxwMBtfcaFLsSoAmlmgMkwrWRoCtER4y+YB6sArHn32/yHLxXpTQ4t7jxPMwafYnubvShSncikhjgVL0oPyU3SgeGjFM/a3POjs9b1UsQ6n1sy5saMdJ6HAmIlQAuKtZIweWz2pZdiKsFUL4vV/eeL2fkahw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElGcVRnVklPUUtFdE9qRzA5TnhKZFd4SEwwUzVzRXJVT3BPbHJod0c0ck9E?=
 =?utf-8?B?dDRCTG15ZXB2SmVlUUw2NmpTWmVoMU5pOEN6TGFzcVF2V3YyNlpoMnVZOXdR?=
 =?utf-8?B?V3YzNkNXaDgzMFh1VUdLYWxINEcxZGJsMU9BWVVKczREc1RsQllPUVFUVk5X?=
 =?utf-8?B?V2IxdjdTakpyQjV2Tk5RaWtteUpYWVY5dXI1bHVXS3BCeTNMYW5YV2pqMWhu?=
 =?utf-8?B?aHBrVkNKVmlTQ1lsQTFKR0lYaFF1d1pnRk5IWkx0ZkRLSjZvbHJQNXRvYXJi?=
 =?utf-8?B?WWNVaXIxejkzVjhDS2xXVkxuVGpnem1NZFRMcGMzY0xVSzFWcjlYb0o2WDFI?=
 =?utf-8?B?ako4TUc1d1Y2Ry9yRXc5NVFGT1pGOS8wb3htY0sxTkJMRkVDQkd0dlFKQ1lm?=
 =?utf-8?B?NkxMc3p0WE9IZEtBa0x3cWFLVjZkSCtFNlpHcnp0aGZ6MGlQTzRJTzRZbUN5?=
 =?utf-8?B?NTliRlFKaGFHaisyb3NzK1dudS9ZRmJJZC94VW02TXphNWRva1h0Y0pabCsw?=
 =?utf-8?B?WGUrWlB0L2pHVVJETGxVZEdESTFhSFBjYTQyaFM3VmE0czE0aFFjc0ZWd0ly?=
 =?utf-8?B?OHZKc2JpT1QrZjBzdlpyZHVmVnBJU0hQVVVIRllBWDFaWHJUaldENHZObWVD?=
 =?utf-8?B?Umo0TDVwc0tuVmhOcHJNSXI0cnVQYXVmb251dEJYTnBLTmExNUR0NlJkOUY2?=
 =?utf-8?B?MjRsYy9zKzMxYW9TV1R2THAvS2JONFg0VTFEdjRVOHlYNDdlRHFCZE84OTUr?=
 =?utf-8?B?cjdjRU0reGNsZ1V3b3pMaHZKSFB2Y1R5MEpkV2F2NkNtVUpBdnhBQ0lybDY2?=
 =?utf-8?B?RTVGY2x5L0lES2FRTm1qRFZXYk1LclhhN3hvM3FDVWtNR2k1VXBKWUd5d3RI?=
 =?utf-8?B?NGM2YVVWSUhvNU9iRDVzREdSSVB0V3JBN1hucHFXdzVlMnNHWHRmN3Jvdjho?=
 =?utf-8?B?MURZWUgwNUVTUUdGbndrU0F1N1hoWm4xUSt0QTZkdjNrd2xxb1ArS2hpNkNl?=
 =?utf-8?B?YmxBVzI5VmI5aW1NT3FQVC9RRXU0eWtGODJIalJodkVkeVYvTGJuRTZ5WmpS?=
 =?utf-8?B?cEN6M2xYclN3dWk2cENhdnQxQ0JWWE1EYjlGNlMrUG1YMVF4ZVBPU1d2ckdk?=
 =?utf-8?B?Wk1uUkRoanBzNlBLVWlFc0F3TXliVzdGc2JWZTRxcDh0M01tN2NyaENhWUhh?=
 =?utf-8?B?WnoxUDN1OHpPOWh5bXMrVkVQMDhkalc4VmNRWDlETHZLeXRUdHJJTENtSmM3?=
 =?utf-8?B?NUxtdkZlYnN2Y0g1VERrSVJYTnVXQjVnb1o2ZzViTVVYRWVvWWNubXJCWXpN?=
 =?utf-8?B?eHlMTFBwTlZ0dXNwck0vQmhsRGZoSXpHK2IrbjJWaVN3SHhmVm5XbHV4b3hp?=
 =?utf-8?B?eFJyWWhZdTBNYVlDdEZJRkh6YllVVUYwWE5rdVBBdFgvYk1mOUc3N3ZIRjVu?=
 =?utf-8?B?KzI1eVlPMlh3RHArM25rMEtjR0Ntcmh5TmxaUTdPOEY5ZHd5dUo1SXh4d21G?=
 =?utf-8?B?SFdBZTRQQ2lCN25mSEZrZm13akhiUlZRUkVHam5PRnN6T2ZFcFdDYWM4QUNq?=
 =?utf-8?B?aU4yRC94K2dRTDdGYjh6RitONnF6SHdBOVdzc2RxMHlGMWNuTWU2d3lYZFVC?=
 =?utf-8?B?TEloenkxbjJjdTJOa2NZVDliam9ITzEvbncvR2tWNWN2VjEzRWJycWQrK25z?=
 =?utf-8?B?MG9penVRVlBacGtyTlNNVDlWTy9UQnYyaFhlb2UvelpneWU1MEFTc3dZWUhL?=
 =?utf-8?B?cWtIenhUVnNBdjBGa2phci9iZXNhSHBOeFdtVlRMRnRuRWJOblJZRzdFTmJV?=
 =?utf-8?B?aTdJM1FCVURTeTUzTmNWVjhmc3JCWmE2QnBmdVpUMEV2NEh5VnNxemxWY2Nz?=
 =?utf-8?B?Y0l4VlI0NUNkMS9KVUNVSXpsaHJIZFBTR2ZaVmpBS2ZTVVJDQ2JXSU1TZDAr?=
 =?utf-8?B?Z2xhOTBCK2RDNno0Ny8xeEFHUHllaVZWYTljdklJR01VckgrQzJGMVBNZEY4?=
 =?utf-8?B?akpsMU1DRWF1aDA0bjhVaTNuNE5PTlQ5TEhHcDZDZmlobGtrMTA0bVR0d2F2?=
 =?utf-8?B?NVFveThRc2ZObmdJK1BzdGVGUStlcGx1ckZWOVlESHZIWlpweU0wU3hVYU9y?=
 =?utf-8?B?dFRwU2xtdVlOWGRRYStYVWllODY3RU9vVU5yZkFhcDZqL1JPUmsxZXhETmw3?=
 =?utf-8?B?dDhCYWJOMG5NcFJEZm9LeWlFZlN0VThEZEN2OGVNQ0xhYlNnSDVDMEljTmUr?=
 =?utf-8?B?SGRmTy8xUVd6KytmbVlHV05SUXpOQnkwOTR6cGZZMkxJRjNyRjZKd1lSd0tM?=
 =?utf-8?B?UEUySlVTNlJ5N1Joa3UwaDZNM1J2aTgrMXFOVnJLYWRGNUl1ZWFSVmttWEJa?=
 =?utf-8?Q?jKlRuLP+xKO6czXclgW3F9/KXrmtZH7LJtVgTAZSb3FG+?=
X-MS-Exchange-AntiSpam-MessageData-1: t+85dhxks9hlww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ca6780-1a19-477a-8f52-08de867b0742
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:09.6075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAW91zR68m7YbX/f+i5XIe3hTnmcdTXUIvHonWDjYyCEYa9r8rUKYQGYbQ3SFXja8lXm7W21NxtSf1CiHllzuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

Convert all PFB registers to use the kernel's register macro and update
the code accordingly.

NV_PGSP_QUEUE_HEAD was somehow caught in the PFB section, so move it to
its own section and convert it as well.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/fb/hal/ga100.rs | 34 +++++++++++++--------
 drivers/gpu/nova-core/fb/hal/tu102.rs | 14 +++++----
 drivers/gpu/nova-core/gsp/boot.rs     |  6 ++--
 drivers/gpu/nova-core/gsp/cmdq.rs     |  9 +++---
 drivers/gpu/nova-core/regs.rs         | 57 ++++++++++++++++++++---------------
 5 files changed, 70 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index e0acc41aa7cd..629588c75778 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    num::Bounded,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -13,22 +17,26 @@
 struct Ga100;
 
 pub(super) fn read_sysmem_flush_page_ga100(bar: &Bar0) -> u64 {
-    u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::read(bar).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
-        | u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::read(bar).adr_63_40())
+    u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
+        | u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI).adr_63_40())
             << FLUSH_SYSMEM_ADDR_SHIFT_HI
 }
 
 pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
-    regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::default()
-        // CAST: `as u32` is used on purpose since the remaining bits are guaranteed to fit within
-        // a `u32`.
-        .set_adr_63_40((addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI) as u32)
-        .write(bar);
-    regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
-        // CAST: `as u32` is used on purpose since we want to strip the upper bits that have been
-        // written to `NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI`.
-        .set_adr_39_08((addr >> FLUSH_SYSMEM_ADDR_SHIFT) as u32)
-        .write(bar);
+    bar.write_reg(
+        regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr_63_40(
+            Bounded::<u64, _>::from(addr)
+                .shr::<FLUSH_SYSMEM_ADDR_SHIFT_HI, _>()
+                .cast(),
+        ),
+    );
+
+    bar.write_reg(
+        regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::zeroed()
+            // CAST: `as u32` is used on purpose since we want to strip the upper bits that have
+            // been written to `NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI`.
+            .with_adr_39_08((addr >> FLUSH_SYSMEM_ADDR_SHIFT) as u32),
+    );
 }
 
 pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index eec984f4e816..515d50872224 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -13,7 +16,7 @@
 pub(super) const FLUSH_SYSMEM_ADDR_SHIFT: u32 = 8;
 
 pub(super) fn read_sysmem_flush_page_gm107(bar: &Bar0) -> u64 {
-    u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::read(bar).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
+    u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
 }
 
 pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
@@ -21,9 +24,7 @@ pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
     u32::try_from(addr >> FLUSH_SYSMEM_ADDR_SHIFT)
         .map_err(|_| EINVAL)
         .map(|addr| {
-            regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
-                .set_adr_39_08(addr)
-                .write(bar)
+            bar.write_reg(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::zeroed().with_adr_39_08(addr))
         })
 }
 
@@ -32,7 +33,8 @@ pub(super) fn display_enabled_gm107(bar: &Bar0) -> bool {
 }
 
 pub(super) fn vidmem_size_gp102(bar: &Bar0) -> u64 {
-    regs::NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE::read(bar).usable_fb_size()
+    bar.read(regs::NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE)
+        .usable_fb_size()
 }
 
 struct Tu102;
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 06b8313c1219..55d8aef5ff1e 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -58,7 +58,7 @@ fn run_fwsec_frts(
     ) -> Result<()> {
         // Check that the WPR2 region does not already exists - if it does, we cannot run
         // FWSEC-FRTS until the GPU is reset.
-        if regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI::read(bar).higher_bound() != 0 {
+        if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
             dev_err!(
                 dev,
                 "WPR2 region already exists - GPU needs to be reset to proceed\n"
@@ -103,8 +103,8 @@ fn run_fwsec_frts(
 
         // Check that the WPR2 region has been created as we requested.
         let (wpr2_lo, wpr2_hi) = (
-            regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO::read(bar).lower_bound(),
-            regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI::read(bar).higher_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
         );
 
         match (wpr2_lo, wpr2_hi) {
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d36a62ba1c60..b8b0edba5afd 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -11,7 +11,10 @@
         DmaAddress, //
     },
     dma_write,
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     new_mutex,
     prelude::*,
     sync::{
@@ -503,9 +506,7 @@ fn calculate_checksum<T: Iterator<Item = u8>>(it: T) -> u32 {
 
     /// Notifies the GSP that we have updated the command queue pointers.
     fn notify_gsp(bar: &Bar0) {
-        regs::NV_PGSP_QUEUE_HEAD::default()
-            .set_address(0)
-            .write(bar);
+        bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
 
     /// Sends `command` to the GSP and waits for the reply.
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 533d912659ba..4f5cd64c2fce 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -120,26 +120,35 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PFB
 
-// The following two registers together hold the physical system memory address that is used by the
-// GPU to perform sysmembar operations (see `fb::SysmemFlush`).
+io::register! {
+    /// Low bits of the physical system memory address used by the GPU to perform sysmembar
+    /// operations (see [`crate::fb::SysmemFlush`]).
+    pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
+        31:0    adr_39_08;
+    }
 
-register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR @ 0x00100c10 {
-    31:0    adr_39_08 as u32;
-});
+    /// High bits of the physical system memory address used by the GPU to perform sysmembar
+    /// operations (see [`crate::fb::SysmemFlush`]).
+    pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x00100c40 {
+        23:0    adr_63_40;
+    }
 
-register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI @ 0x00100c40 {
-    23:0    adr_63_40 as u32;
-});
+    pub(crate) NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE(u32) @ 0x00100ce0 {
+        30:30   ecc_mode_enabled => bool;
+        9:4     lower_mag;
+        3:0     lower_scale;
+    }
 
-register!(NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE @ 0x00100ce0 {
-    3:0     lower_scale as u8;
-    9:4     lower_mag as u8;
-    30:30   ecc_mode_enabled as bool;
-});
+    pub(crate) NV_PFB_PRI_MMU_WPR2_ADDR_LO(u32) @ 0x001fa824 {
+        /// Bits 12..40 of the lower (inclusive) bound of the WPR2 region.
+        31:4    lo_val;
+    }
 
-register!(NV_PGSP_QUEUE_HEAD @ 0x00110c00 {
-    31:0    address as u32;
-});
+    pub(crate) NV_PFB_PRI_MMU_WPR2_ADDR_HI(u32) @ 0x001fa828 {
+        /// Bits 12..40 of the higher (exclusive) bound of the WPR2 region.
+        31:4    hi_val;
+    }
+}
 
 impl NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE {
     /// Returns the usable framebuffer size, in bytes.
@@ -156,10 +165,6 @@ pub(crate) fn usable_fb_size(self) -> u64 {
     }
 }
 
-register!(NV_PFB_PRI_MMU_WPR2_ADDR_LO@0x001fa824  {
-    31:4    lo_val as u32, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
-});
-
 impl NV_PFB_PRI_MMU_WPR2_ADDR_LO {
     /// Returns the lower (inclusive) bound of the WPR2 region.
     pub(crate) fn lower_bound(self) -> u64 {
@@ -167,10 +172,6 @@ pub(crate) fn lower_bound(self) -> u64 {
     }
 }
 
-register!(NV_PFB_PRI_MMU_WPR2_ADDR_HI@0x001fa828  {
-    31:4    hi_val as u32, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
-});
-
 impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
     /// Returns the higher (exclusive) bound of the WPR2 region.
     ///
@@ -180,6 +181,14 @@ pub(crate) fn higher_bound(self) -> u64 {
     }
 }
 
+// PGSP
+
+io::register! {
+    pub(crate) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
+        31:0    address;
+    }
+}
+
 // PGC6 register space.
 //
 // `GC6` is a GPU low-power state where VRAM is in self-refresh and the GPU is powered down (except

-- 
2.53.0

