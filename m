Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67C0C61DCB
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A73210EF17;
	Thu, 27 Aug 2026 08:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MdM83CEf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FC010E3BB
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIlRe2rHem+0rozjgjsWdhy7sBjwei+8vsujfyPEYU9cScv7D1fjaCpUyGSVcVSmt+/nE9oEzYqnGkUR/4syNOHWBhxbSsVxT5/bTSUxdQFMjxZC+KdNpO4jPkIQWQZKlfX977sBsXabh6eaQtYmY+l02X7HiwG4JmurkSZjpSs4nBdEUmgS0rmNrPR4WJa0rxKxA83U3aTnKP2XLPI8L3DebU7GMWLk2nZKSIk+58/fwHceukuxubhq4COZP+Z491gLygqIxF5iT/xHcD6dtQ4ty9LslrBZ0UQTPClLDzwcxXhNQ9bO1/ELFW9QFnpBcm4X5JiFpvHgxyf3zRvRPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqfgYyU/GpaAmC3423pZOAtihrlCVfpnwE+RCGpNNVA=;
 b=xyIvJxZQQTE6+ftOukZgoTRtZpicPWxUeUZ/DD1Nk0yx6vZOA9lZV2UqCKyAE/wm5KTteGYVQRugrjzRggU/ZNlBKZj6D00NzCul18Mw4go0h0f5IbinQ4R2V28ZOKP+zsJ2Gu/+b0w3NQCGnc7A2cZdBKRYSO3fayIoHdwLagr1HHpXnEnOdLSP2db9jnEg5vuvmyAhQg/sT/q27FfoT6TrrLPnzutBYxFCBvx75XZ0+dHXStnR9CzlL3n4g4OICEackdlSxH7hhTl+DzARxtLhtwiJ1juLN5/UTX/AP6WRz+IzncEIFLPm3s8XBJRg8lqM37uEACb1jy0KQ4jHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqfgYyU/GpaAmC3423pZOAtihrlCVfpnwE+RCGpNNVA=;
 b=MdM83CEfZogrKwygDcHwxsAqCw3td6TmUjdyBO7TlZ6WUuqHii9V0yrHBg8xuJgt1MYUrMttHFQXWVSEhRmD0SAhWX+TYhwwbJ1O6kjILYoXNDiqKPUpShF8gQtDeZFkCsvsvEU4wCjtbgp3X0ubFS5TcbbyCFM5KPdm1hTbwY1L87pUipFuoIfW85IZXgCbvm56wnfJWdKgb1h/cLxwXKFyZ8TBR66Us4+tnAO5CD6G3Ve2qoky28xn8rxXWLXfanFcs2w3g8Jv36k6mt0IE0OAfCCi3bIFyUVv26xR3VRuDQcWF0iJeTXIBOsxPy2rvt/kXAyFQghloou+Bor1wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:20 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:20 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:45 +0900
Subject: [PATCH v3 04/10] gpu: nova-core: mm: Add the memory management HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-4-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a6d0ff-b1bb-4500-120b-08df04188138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: F/X9znbX27h4Q/7SPUfHeZLSDES8/K0MNtMz+/Yxu51iOcDoct+brsLOUVdxV4Wezw0vu3BhLAej0ISksQ7Z0xaf1t8dPAgWazL1PnbnSoJ/+nETv3VvKxbvSOoOGOn2L6MhVOOe+sYDPgL3elXOP8lDXwWpp2PAX6usVZEQeDn4ht5KepysWg0BfzL18y7YE6VxzhuyvG+S7KVZKz0+dfjYAD2J7LnJCt/KqfOcAm9VLxwX+Voe7oxe8yaddh9rflViW4ziJFpBMP+HfmYG9tc1/i0MfMgb1B3kNPKBOE0K0wqtvdGPNl5FTgYYaCnVC9KwdZgixfZSDQoD+QYi/HrtLiqrcxD/Y7+ckuWda0dpj4i/Zj0q0hFsfxOOJvR89NIrawtIrxokP6StYRp6oZfaD2qt2QBam0/HKaspaGNxAl2LIic9z1M3mTRJoDwocRuU9QoJjFZTpQ6LxL/Fht0/H3j1+OJIFw6qxKV9crCoLVK1NJfA6bGxqFg/6BZL01JdxgxtFAY0sCgGhBI7oKDwH0adrsEo1E2GArEns7wge5voSMth7JSDypkKPDaFlzoqlUk4Vm1/XNv8yNmKUI2Gv4XXgVJEuNYJm94xGHm9RddWuinFrlB/3azdFCEaEZCoRnC+95his47u1jS1tsz5HiROyEXHDJLfnLAOhdIJUWeac7Pg+mexwHIAOCVbw7xAAinAyIzFTcwHBCP2rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulc0WW9oRVV5a1Z0Zlo0RUI1U20rY0plTVpTaklkTm5jVnJlNEthNnZJTmtv?=
 =?utf-8?B?Z2pVMW1jcHlyUE5vRGtmcmFaOExXRUFydnpDSzBtT2REOWpkY2k1QndPVnFR?=
 =?utf-8?B?SUpKZFJBQXFLU3VRTGluUjIxNnpiajUxUTFTaWs5WEZkRmpqQWM2M1QxRE11?=
 =?utf-8?B?cHYxN2Z0RDRKcElwQS9rOXlIQUg4VENMYXp0dHVqN2ZWUG80MHhmd0I4T0ZJ?=
 =?utf-8?B?N0c5eEdUUGtTdmUzd0VTajNwdmoreXU1b3NnbnpVOTZtZy91NUpsRWlmWm8z?=
 =?utf-8?B?cDZjNzIvU1FBSzlRL2RaYURhQjJPSzkwOG5ZdWlLRzBmQ0hEMHMySCtsK3NY?=
 =?utf-8?B?ZUhXbC9NTERJNjRVcXp2U3Z3bUtMOUhnSHc5WHdqbXNCdHpIZExlUEJNNExN?=
 =?utf-8?B?YVk2NWhBUmJCVnp6NkZ0TXg4RWtTMnN2NkRkSkhRNXY5d3VMcnQ4QkVsMWNw?=
 =?utf-8?B?dEx0NFVza0l0Uk5MdU4vYjVDdVNadnNmT001bmRwSmEwbzRCRlkzQVZSL3Rr?=
 =?utf-8?B?Rkx5czdhdnZZVXkvcjRycnUzRTMxaEtIamsvSklMSTg5a3loODB2UHJ6RkYz?=
 =?utf-8?B?Ym1aOUJoZStyalFqRzk2aFFzcTVZeERhQ2FpY1NzYVd2MGFFSnNnM2xEcVBl?=
 =?utf-8?B?YzlCVVJuMHR6cWFoRmozek9uazNINlU0UmdOTCsyOTIvVDc0NHg1TUQzZXJM?=
 =?utf-8?B?RzY0RDNreWNlb3RWMDhIUEJucVkvdnI5SWdmNzk3QmtUY3JNRDczb2R1djM2?=
 =?utf-8?B?SGJBU2JCR2RVN0Z4Ymk5d2VHRG5PTkdBNDFpUmR6R1pHWFUxOEorV1QrdEZY?=
 =?utf-8?B?U1JvR0RVelZVZEpCbGxpL3J4bXlWaFErTGEvQUE1VzZrN1U4QkJZK1NsV3Bo?=
 =?utf-8?B?QVJjUU8xYlJ6UC9rSnBhZmZHQ0RNWDcrT0RiRFh2cnJpTHpKdGNDd29oeWNa?=
 =?utf-8?B?VzBKdEVpZWR5ZHJMd0l2cjRxQXcwTXE2blY3K2s2YlB4TmM2VGRBSzU4a29u?=
 =?utf-8?B?OUw2MC9UNzVrUElwSFY0WWFuM0tsaHkvdTRqY2daa3FvSU1iWDIwWktodmMx?=
 =?utf-8?B?QjhhL2dod3Q1Ly91Mno0T1AyWEhqRHRlTHVrOW9xMkpCcEYxVnpSU2dKR1My?=
 =?utf-8?B?TUl5OUR4c0d0OG1tRVlYbXJsb1NJcElaTEN5MmFpYzRZMFRsd284elRvYjkx?=
 =?utf-8?B?YUo4RFVMdTh5ZmJmbHVqOTVxK2FrMzhKSEpoWEhlc1c1V2gvWGZQeTFBZjBp?=
 =?utf-8?B?eHZBd0VLMlRDSFNhOUozZDdjS1hKdGVxZjBycDgxbHpDNzh2VGRobmtPZDVw?=
 =?utf-8?B?dW40SnZYZXJ3blpwS1MrSlVmMDZmVU9HdlJsNVFyV1BKSXlaV3BWM2YvZzdK?=
 =?utf-8?B?NWNLdGVyK3NvdXVBNlZ2Q2xhS1dGRmF1NG10akNiQllBWm9mb0NwbmRmazE4?=
 =?utf-8?B?OGdhU2tjM09YTG10ZGFlMHVvTDRvYzBkRXVIQmdxRVg1QXA2YzFCYW9MUnJy?=
 =?utf-8?B?aGlyTWo0V2ZEeEtNYjBWdjVIazdOVG95WlY3aEZZbTBkQkk0eE5oZjZkSjMv?=
 =?utf-8?B?MHVCdHp6UWxpMU5VKzBjLzQ2VmZWRjg3VER0enliR2Zza3NlT2JBMXlkNk5t?=
 =?utf-8?B?REJHcFAxQko5R0tyZEE5eFBWZWg1ejRNUHJTNXp6TTdTRmJvVWRrL0YwZTFY?=
 =?utf-8?B?RzNZOTVoUGFEZUQrTy9LcXVkYXo2bC9zdURJYkhQZkJacG1TNHVWTlQ0eTJ1?=
 =?utf-8?B?YW5HNzYzZVdsN0NZR1NpdUtEcEtkZWRLZkx3OWo4M0lrN3h6MzJYaXJGNG5O?=
 =?utf-8?B?SjljaFptRFJJUElEVGM1cHVqd2hKQ0cwR0o1QmZySWh2SVJkNk5oNU11Q2xI?=
 =?utf-8?B?c3M5dmcvbm1MK2ZjTmdISmdPNVd6OUhkVnI3NjAzQkF4bkdyU21wclQxNVk2?=
 =?utf-8?B?NUdNeStTUW9wSURIcExFR2lQWFBlVW8xMFVMenllR3cvSDdNbWlrK1dNY1kr?=
 =?utf-8?B?VlBMQ2w3ZGxONnBjT3Q3bUlDaFgyaDFTOVIrZ1ArV3VRU2V0NnNzUEQ3S3ht?=
 =?utf-8?B?N0ZOYWZFcjVVQUl5WEhVdG1CRGpma2g0VHdyRy9HalFIZDhzMG5UYURaQ3hY?=
 =?utf-8?B?dXYwODdLOTBwdDlhYm9xNWo2dTN3SHhUbXZ0QzhqZzhyNGU1ejBrNnlaMmZ0?=
 =?utf-8?B?R0RMR010bkNtQittYy9kVlhaOXlTcjM3aWt1RzMxcmpUWXJ2cFhvbVRFU3RZ?=
 =?utf-8?B?WnlCOE1tWGFMRGxNQUFmK2IzSHd1VGtLV0ZoSnViQWkrbmNlZ0NVRlp4WmNX?=
 =?utf-8?B?WEdBUklZR0dJMnlFRDJBTjdKUmEyWWR1TGtWNk85UG1jaW5TR0t1cFRkbkFw?=
 =?utf-8?Q?UpN3BXht2+6UMjjNhTNVPdFKMr668SfZ1AVCvCd0ArXQ5?=
X-MS-Exchange-AntiSpam-MessageData-1: wef4Ua1yDCHWog==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a6d0ff-b1bb-4500-120b-08df04188138
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:20.4503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3HSO9mvdVZLGNqnDEvh/L0fbTrIRWlHzXnnxD2xBOLSSw1wL/ZusRd0Es6gcJ5iRCKKMZ2tP4PuAUpfSS3lPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

Positioning the PRAMIN window requires writing an architecture-specific
register: `NV_PBUS_BAR0_WINDOW` on Turing, Ampere and Ada, and
`NV_XAL_EP_BAR0_WINDOW` with a different field width on Hopper and on
Blackwell.

A `MmHal` trait with one implementation per hardware family hides the
register choice from the rest of the mm code, matching the layout of
the driver's other HALs.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs           |  1 +
 drivers/gpu/nova-core/mm/hal.rs       | 56 +++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/gb100.rs | 35 ++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/gh100.rs | 35 ++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/tu102.rs | 37 +++++++++++++++++++++++
 5 files changed, 164 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 7d24ad790310..07dce4ce2473 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -19,6 +19,7 @@
     },
 };
 
+mod hal;
 mod regs;
 
 /// Physical VRAM address in GPU video memory.
diff --git a/drivers/gpu/nova-core/mm/hal.rs b/drivers/gpu/nova-core/mm/hal.rs
new file mode 100644
index 000000000000..e7fd1e38bd38
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal.rs
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Memory management HAL.
+
+use kernel::{
+    num::Bounded,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    gpu::{
+        Architecture,
+        Chipset, //
+    },
+    mm::VramAddress, //
+};
+
+mod gb100;
+mod gh100;
+mod tu102;
+
+/// Trait implemented by per-architecture MM HALs.
+///
+/// `Sync` is required so that the `&'static dyn MmHal` references can be stored in `Send`
+/// structures.
+pub(super) trait MmHal: Sync {
+    /// Positions the PRAMIN window at `base`.
+    ///
+    /// This fails if `base` is not aligned to the 64 KiB window alignment or is too large for
+    /// the receiving register.
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result;
+}
+
+/// Returns the HAL corresponding to `chipset`.
+pub(super) fn mm_hal(chipset: Chipset) -> &'static dyn MmHal {
+    match chipset.arch() {
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada => tu102::TU102_HAL,
+        Architecture::Hopper => gh100::GH100_HAL,
+        Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => gb100::GB100_HAL,
+    }
+}
+
+/// Converts `base` into the value of the window-base register field.
+///
+/// Fails with [`EINVAL`] if `base` is not aligned to the window alignment required by the register
+/// field's shift, or if the shifted value does not fit within `RES` bits.
+fn window_base<const RES: u32>(base: VramAddress) -> Result<Bounded<u64, RES>> {
+    const WINDOW_BASE_SHIFT: u32 = 16;
+
+    Bounded::<u64, 64>::from(base.into_raw())
+        .shr_exact::<WINDOW_BASE_SHIFT, { 64 - WINDOW_BASE_SHIFT }>()
+        .and_then(Bounded::try_shrink)
+        .ok_or(EINVAL)
+}
diff --git a/drivers/gpu/nova-core/mm/hal/gb100.rs b/drivers/gpu/nova-core/mm/hal/gb100.rs
new file mode 100644
index 000000000000..3781e143dea7
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/gb100.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Blackwell GB10x/GB20x memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Gb100;
+
+impl MmHal for Gb100 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::gb100::NV_XAL_EP_BAR0_WINDOW::zeroed().with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const GB100: Gb100 = Gb100;
+pub(super) const GB100_HAL: &dyn MmHal = &GB100;
diff --git a/drivers/gpu/nova-core/mm/hal/gh100.rs b/drivers/gpu/nova-core/mm/hal/gh100.rs
new file mode 100644
index 000000000000..8af384db2921
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/gh100.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Hopper memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Gh100;
+
+impl MmHal for Gh100 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::gh100::NV_XAL_EP_BAR0_WINDOW::zeroed().with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const GH100: Gh100 = Gh100;
+pub(super) const GH100_HAL: &dyn MmHal = &GH100;
diff --git a/drivers/gpu/nova-core/mm/hal/tu102.rs b/drivers/gpu/nova-core/mm/hal/tu102.rs
new file mode 100644
index 000000000000..e4fe7561223c
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/tu102.rs
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Turing, Ampere and Ada memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Tu102;
+
+impl MmHal for Tu102 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::NV_PBUS_BAR0_WINDOW::zeroed()
+                .with_target(regs::Bar0WindowTarget::VidMem)
+                .with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const TU102: Tu102 = Tu102;
+pub(super) const TU102_HAL: &dyn MmHal = &TU102;

-- 
2.55.0

