Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C09C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F39F10F006;
	Thu, 23 Jul 2026 09:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jD8Por1S";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E1C610F006
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtV6/cw+RnOhFtYmnxsmHdxfOxdLose/mLEoBLEidGENyPmlD937psmwJd6ilBhfDEZ1ErfS4bBL0tcWH+mnmCv9fDK6tyhC7rAxn8b3d3tUmpBjs0ejfNhiMf+y9m2pgTwqZadw3agBAC0W9eYmj05hurh0R2vVp8JARGcUpW4Ie6AGm/qg2AJVpa0cZLbusNQCShQp5PR9EeTp/YV7C3qnuDV8lQcwGhC0Fu4AxHqSW729sFYDzICFBMAucXGE7vkasTVL5kfsFG3VCw/2svWIoGLrr/zWnX40UPhmMlCB0uHuxeJI1XLl8rT78iDlBAMZ1y6fNG+8N+ybDxWZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3xAFEHlpC1Rq1MwX6qKlWSgrQpXH75g7itF12MADwU=;
 b=lwpb0hq0zsud5JdPMlALeKZyTONpTT5rXjqA61DtEI8MyeVB9DSTNXlQnVUAnF4zpBJqOaK6V1kaUx4U/6rJs0Oyqy7TSZ+95q26RQUiz5ImO42jyE7fLmihMuBQCGlhtIlvfT0Twd3mlRnodjQRlFAqNinGeT/fcln+pyVbO+/HmTj8y9BpXMHTAAWud2hXnnZ3znM8sM5aS5OvAtBb8wvLNvzCfxTAZQrpR9480T6mUzK2wO2u3cBOduo6JQ57QsN8TywI7gGNrs6EsKVAZyBpq5XXcvw/GmoY6bEYVK/MlveCNB+rtuMhtxSGCjnZml88jgF2xHowMUFsM1rMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3xAFEHlpC1Rq1MwX6qKlWSgrQpXH75g7itF12MADwU=;
 b=jD8Por1SRwAKfqYZZ54q3Fu8NcSKwew/5HZGYIfFj4vYpB1cT4HUV+2+0kxdhVYiqqyeZeu8ILt2Lb7Qs8Yst+9ugF+IhSxIVNB5np1r1bwGeUFWe50NA8ZEAKHtol5ZMngukx1CJoyqDOSqBEsyDqp2lS3lfyAqPudWk/CZenkaX2N2ZCIWnV+13qbtnrxGiXYgddryio11cw8LoKq6KdlsoXS/fDMIRxxJtJJGabQB+os/ZI2rA5i8L5AvgSIgqwQ/ZkaAofRvbb/hdqzWuTSbfKabD3Acy3hAzVzZm7Lwk2RCq2LwYP3NTqFTW/mP0ULoFx1Z0eAkqJQnvBBh/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 09:01:07 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 09:01:07 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 23 Jul 2026 17:59:13 +0900
Subject: [PATCH v2 4/4] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-chid-v2-4-c35e5e9fb3d9@nvidia.com>
References: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
In-Reply-To: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 4386e8ca-8653-47ce-71ec-08dee898eeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10070799003|22082099003|18002099003|10067099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: LO7+II3nxeLV2rRZqBPi97kQTlX7Q2BNYXOQp7RRTTvSL9m0W40HU3tU+nOk+4SpnPfJS5nDCGRCvH1p/MQOGSa92tPXwnQjfRAa0gs1e2aRk5CiYQkWWZ97xpmk2YPb2dMRL5fJQ0lZ1SLUM8WDSKBq62Ra5mKHXdU72AvEL80eJNgbisQqHGGAF5MTj04g7Knn3uXewjM3h/WPZs2oBiwnDKh7UHWM+hI9QJP9TDDmV1zuilj7lCtRPtnp8Z9Pkn+Xdsg24rIZu20mYdI71dvHK4LayEMhtfgvpSKeGIDbPymyakazYrPKDkpJG9GKBdIY7mX/fNWTeogFEPEAJsVCjlpHIgkGcxHlvmcBsMsTjwQkVf9CKBZB1aoOkAZFaYgZmeaOhc2kPMbeUI4ZJoxq5IJDi3glTwv3IHSWorqadHhAc3S6kUb/GVRRUioNmj4TcquPitvjVMxzGqxiMaTCfa65Uq9cYZCmVsus9ltwhzyKwrHUAFLcuA0Cs+vwT7fo7l3+N+VPhB9sABo6MSfFs3x6RhQSNDBCvE1s/RxPjNT5ZEoVgbk/ukkNSrH5aeypLxsNUACPSy4aI9/J6TQgLaIQEr66uG/pInfLL/lULoQo0NscY/WlZ8uqZgMJ5g3zYMPlTbtetJWJkntITAKArv6rmeWCfqDTC84a/yS4J7F+h4lNW5TxpS7ztDzgUzCBCXrFwJjE68KQTRwZFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBobk5jV2ZrOU9raWNXRW9rcW01ZDNXNFpoTzVZZDh5ZERDUXQ0c0VPR3NW?=
 =?utf-8?B?eUNRR0kvbXZWa0lhSFB0Z0tFbnczMDJFMHRrTjJsdW9kVWRKUkQ0UFphTXNJ?=
 =?utf-8?B?Q29TcUVyYUNaYmxVTVlTcGdMelMzME9aazAxbjluWXI0eDlhaUwza1FhL3A5?=
 =?utf-8?B?ZW5yNFVzSnUvWDdzVnNaamM2c0JKUUJ6Q3BHd3k1U0Z4MlNIZ3BWQkIrQ3h6?=
 =?utf-8?B?cjY4bXNCUXUvN1FxcjR5VWlJcjZDUktZNk16dGRreS9vMVE0N1RFeCtBcVBz?=
 =?utf-8?B?WlllQkFXSUZRSnFWdnFPdzB6N3ZZMm9wamx4K0FLRTJYVGtKTWNWVWVwcStC?=
 =?utf-8?B?VEFDVzVzbTF4bm9nTCtxSVU3VTN2T2lkeEJwV2F6OUtWVnBwS0I3RDdnRkdW?=
 =?utf-8?B?azc5cHdxWXJiZG9VdGxzRGFoVUZVUjBoQnZsejI4YlR3Wjh4N2d0VDBTY2d3?=
 =?utf-8?B?ZE0zQVhCVndCRENwdzUvSzRWUXArRkVFaXordmhycUxjcFpsL3d1UHcrMTU5?=
 =?utf-8?B?UXd6cGJ1eHZQTDNoU3dJQjJTUGd2bHpUWW9rWUJ2bTZhbFJIRC9SU3FOTEJH?=
 =?utf-8?B?RVRscXRqMS9XRHQ2MUVxQnBCdWV5Z0VpZFFsOWQ5b2llZU03c084aTloM2Rw?=
 =?utf-8?B?cUtpZGdkT09NM0FENWRsNlFhbUM3Sk1oZTAxK2prU1RGc0E3ZHRIemtpbDFY?=
 =?utf-8?B?SEZXa01qQ0d3Z3FSQmVwejlJM0g1allXQXhHaW90QkRWaUNXc2JxNDVDSzZ1?=
 =?utf-8?B?Z2EyRzZEbWkxUlZxVFpsUGdPYnJaY28rd1FEOEU4SlRCL1NIRGZqRUU5S0oy?=
 =?utf-8?B?VVQxTkxjVTNhRnR5NzkraUJtSm9Lc0pjYUFDSGFaWDVKWm9IZXd5OHBEVGFv?=
 =?utf-8?B?NGN2U0M3dHpJNWdTSElsSUdybzcyMGc0N1RqVnVNT2hOK3pwUVpvSjNFSEpx?=
 =?utf-8?B?TFl4eGJjaGF2WDN0MXphTVVZVTNTaEsxekRraitCcFF5eHl0NnF4dERBVDhD?=
 =?utf-8?B?Q2thaE04blo4VmMrWlhPbXp4WW9ZL2FrdGRxdTR2bklDclRna1JEYy8wWVc1?=
 =?utf-8?B?UnRLTGllcm1iWXRyZno1Q1cyRlBiMzlqY2tRalErS1NMYm9ONGpLMHQxNENh?=
 =?utf-8?B?bGYrS1l4d1N1NGtIV3gwZXExSFdHa3ZkMzMzR3ZXdFV4clNKYllnYnJsRll3?=
 =?utf-8?B?MCtlMFNGMk1OQ0pRQ3BqMnphbHhaZFQ1ODVxOHNLbjlsTE5KSHJya2psQ05L?=
 =?utf-8?B?Mis2cC9GMnFwWkFRQ0FlRmc2OHRLR0UrcFJUS2RZZ2NSNElEZEpWMVpKZ1VU?=
 =?utf-8?B?WVVFVUhpcGZxYytLM001eTNybytIR0t4NERlQUtKS2V4UllQTDMzM2FBUEV2?=
 =?utf-8?B?SHdrdHZtQzNGcFFOc2dhTW94WHZKRlJZUGF3Ri9IV2RGTWJVeWpXTEcrTG5q?=
 =?utf-8?B?emFDQ1gwSm9PNC9icVMwVmNyRjc5TzdwK3RsY2krSFVIT2tiWUFUZDVPUnl3?=
 =?utf-8?B?U3krWjF1dWpwUWhZQm13aGQ3cnFtZStJdUFyS2o4am56c1Vwdmw1WHlkR3pB?=
 =?utf-8?B?N0UvdVU3QUNEOHE5NklpSzllQXRGdkN1TkdWNEovWDVhVjJJK1VPWmx0MUg5?=
 =?utf-8?B?Mm1IMnp6cE5pWFFVUDYvc2l1WUxPaXNwNzI0dzF6Tmo0MFRBYlhiWGpyZ2dE?=
 =?utf-8?B?YWdQbzRtZGZyNktQdXBXK09JT3Y0aUZQdG0wQUIwWE44UVpKQlZ6RWRWTjdK?=
 =?utf-8?B?cjFUbSt1b3QxWk83d085Q0ZVT1R3ako0ZHFXOTBkZ2RuZXQrcnJyVEROaTNM?=
 =?utf-8?B?KzE0NUtkbGRCTjc2aUswOXBQR1BTTGhLUmE0TGRMR216VDdUb0ErYVVFeDFO?=
 =?utf-8?B?NTNyTXErWUVRNUREci96UC8zTmUxSWpEMVdodEl4cEppbk40WmhSdE1VOVhp?=
 =?utf-8?B?dlI4VTJ1SFV2VTRMc1BwOGh0b3pHczFKQ2cycllDNG9lQ2s5dUQyT0EyREhi?=
 =?utf-8?B?bGNYWXRndlNIeDNpZFdWTnZlVDh3M3RxbnFaQWIyWmJSZzIrNDZuQ1NzYk5K?=
 =?utf-8?B?TENPbFlOSXczL2FkZWJYa2NUUVlFTVRzemNiQWhBa3BEZEI0TGt3WklaZHVQ?=
 =?utf-8?B?aDd5b2s3dGNlbXdwN3gvKzNBVStXU1FJcTdDQ2hZbzhKK0Y1QjFsTUJSKzV5?=
 =?utf-8?B?V2E4SHp2Ly9kQ0ZSeGdzdURROHBVNUpqUDRFQUpCQytRQ0hJejJNSzlwMlJZ?=
 =?utf-8?B?VjBEcEl6UHIrN3cwQXZBVE52RnFsaHQ2aTFVaFVqcjlwbElvVnQ4T0w4akNq?=
 =?utf-8?B?WjZjZ2dxVTRzNlY5cmh2M3hjSGpYTzlYcXphdTlaS3RuRkcyUEEvbWtzQkVX?=
 =?utf-8?Q?3FHAEA6sBKH5SBttpujjTL96cPSTLE3RwFO1qd2UriRfh?=
X-MS-Exchange-AntiSpam-MessageData-1: deLGzFaHsg06sA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4386e8ca-8653-47ce-71ec-08dee898eeb1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:01:07.3073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwIiMPE1t63Znh+ScnFt78cKdHN/GbhES5PTHti/k8NayUV888fv6NFNZQwgNjAV5dwuMT2A6EcK33rRX524mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
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
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 182 +++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 442c0979f9c6..4e58fc06a371 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -32,6 +32,8 @@
     regs,
 };
 
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+mod channel;
 mod hal;
 
 macro_rules! define_chipset {
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
new file mode 100644
index 000000000000..d3d315ba6c6b
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,182 @@
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
+    num_chids: usize,
+}
+
+impl ChannelIdPool {
+    /// Creates a pool managing `num_chids` channel IDs.
+    pub(crate) fn new(num_chids: usize) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            inner <- new_mutex!(IdPool::with_capacity(num_chids, GFP_KERNEL)?),
+            num_chids,
+        })
+    }
+
+    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`,
+    /// returning a guard that releases the area on drop.
+    pub(crate) fn alloc_area(
+        &self,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Result<ChannelIdArea<'_>> {
+        let mut ids = self.inner.lock();
+        let area = ids
+            .find_unused_area(0, count, align.as_usize() - 1)
+            .ok_or(ENOSPC)?;
+
+        // If the pool is small, the backing bitmap may be rounded up to a larger size.
+        if area.range().end > self.num_chids {
+            return Err(ENOSPC);
+        }
+        Ok(ChannelIdArea {
+            pool: self,
+            range: area.acquire(),
+        })
+    }
+}
+
+/// A reserved contiguous area of channel IDs.
+///
+/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a
+/// sleeping [`Mutex`], so the area must be dropped in a context that is allowed to sleep.
+#[must_use = "the channel ID area is released immediately when unused"]
+pub(crate) struct ChannelIdArea<'a> {
+    pool: &'a ChannelIdPool,
+    range: Range<usize>,
+}
+
+impl Drop for ChannelIdArea<'_> {
+    fn drop(&mut self) {
+        self.pool.inner.lock().release_area(&self.range);
+    }
+}
+
+impl Deref for ChannelIdArea<'_> {
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
+
+    const fn nz<const N: usize>() -> NonZero<usize> {
+        const { NonZero::new(N).unwrap() }
+    }
+
+    #[test]
+    fn chid_area() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(2048), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        let first = pool.alloc_area(nz::<48>(), unaligned)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, first.len());
+        assert_eq!(48, first.end);
+
+        let second = pool.alloc_area(nz::<48>(), unaligned)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(first_start, pool.alloc_area(nz::<48>(), unaligned)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(4), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        {
+            let a = pool.alloc_area(nz::<1>(), unaligned)?;
+            let b = pool.alloc_area(nz::<1>(), unaligned)?;
+            let c = pool.alloc_area(nz::<1>(), unaligned)?;
+            let d = pool.alloc_area(nz::<1>(), unaligned)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(
+                Err(ENOSPC),
+                pool.alloc_area(nz::<1>(), unaligned).map(|_| ())
+            );
+        }
+
+        assert_eq!(0, pool.alloc_area(nz::<4>(), unaligned)?.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<5>(), unaligned).map(|_| ())
+        );
+
+        let head = pool.alloc_area(nz::<3>(), unaligned)?;
+        assert_eq!(0, head.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<2>(), unaligned).map(|_| ())
+        );
+        assert_eq!(3, pool.alloc_area(nz::<1>(), unaligned)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_area_aligned() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(16), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+        let align4 = Alignment::new::<4>();
+
+        // Alloc 0 so the first fit for the next area is unaligned.
+        let pad = pool.alloc_area(nz::<1>(), unaligned)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.alloc_area(nz::<4>(), align4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.alloc_area(nz::<1>(), unaligned)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(Err(ENOSPC), pool.alloc_area(nz::<4>(), align4).map(|_| ()));
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<1>(), Alignment::new::<32>())
+                .map(|_| ())
+        );
+
+        assert_eq!(2, pool.alloc_area(nz::<2>(), unaligned)?.start);
+        Ok(())
+    }
+}

-- 
2.55.0

