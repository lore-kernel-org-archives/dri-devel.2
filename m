Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62A5C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F5B10EE88;
	Wed,  9 Sep 2026 04:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YIKxN1/h";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3D910EE89
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je0Dc2nPHw/9axHfJFKbqN77inOo36vdDbgmyKrdFBAtMhSXaLTUA3pfTQB7pLWYIBycF1DXOcQ6hmru50qP5l3Pt/qr5PxlIu+83q+72m+DvhWhBekQ32yORmTWp16dCQoZfeb27tt7KGTTSs4/yA8LNwR1R/Z1Vt7iMCsn6RRt7HHH82ewQzV3DKnIQFtlUCLM2ng3MlOlQmF4cWdOEyfZLiRkITHPo7EoXXOF9ZmaGlg1nhEdy0s6XLQ309D+FXlrVcVx4AiJO3CQFdGKSQFy06/HjvBky9JGVkePc9ZdSRELxkcysv6ut+7s1+V0Ag5ROvP4xoXIIzO7UjH+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za0ewrcmC0w1PS+XN4qhFTXRlioK4XsCh7x2BAt6fhs=;
 b=nixTuxASmlH8t5XYmXnNkHPvv6hix/D71hK7myK+vcbX2SfzvM4dUWMCazzWQN4NPcPVtuq0cIQolJQmTEyDwuCVyr+FaTv0U9BknKL00w9zD/zD/6i9syLEfkYuOCxtkWzR4eeXZS17O4yQVrEEZrKQ4Rd1gY1Wtks3awF10f7WOo5InFAThETijG+YPR5R3brwG25MPj3cOI3qaDmUm2BIM8MiTBsC0mcgv+KEy7o721OgVkpEq0f92TNcCT6oC6IVOSEgapeIQse2dShVT9I0RYKrfOQwlMlAVzP1PGyr9+Mgprx0vTBj9mV8mHlBbjYvAlLDSzyaHawFoyUozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za0ewrcmC0w1PS+XN4qhFTXRlioK4XsCh7x2BAt6fhs=;
 b=YIKxN1/hWDMlIrO/zm9ytxkWoKCYxHglG2AO9WW4r0pU7SpYrJyuiXrPMpopQaSdjFF9nogTMQMesGpdRkLlyvixZfbxlzyYt0uds6Towo0C5jbW16gpx677p4xal0T9MfDqM/7neO/Rpa27osYlyQkg9tqCRuP8CAhPEquMYI4EdR195EqYBJnX+F8/wPCCPC0T6g5BZYjUeZhZ+QHSLghw7CVBEnpKyuVlwl9+TggxjSJ/Ow+xZbF8SAqpD+tIgTwz5O12AwJz/E4lXHGBVQOXp0eLBP9xS+Ytr/W04of8irM803OCVOyWWSNKv0rTChYQGYc6OGaDm9iSSsJAew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:31 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:31 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:48 +0900
Subject: [PATCH 10/16] gpu: nova-core: mm: Add page table walker for MMU v2/v3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-10-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0052.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: e99ab467-7aa1-46ba-aa6d-08df0e26e44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9evwO4kx7JVOs3Op6cCoAUS10kK4GKnhrupTyRoLX4hJawwMEK/6vnsuGxZWqUOfUvNg9rGsNEufy1QoQ+WmgakRA8IrBP1BcLR1+MGTFsZRInn0kFZYwNJu23vK56Kgy3ZFGRsHmekmqtGNkBsasuCwdL8ZUiJE8t+X6B+2ZwM3LbMsIPt9tCn8TV5Qt2lkBskeQjIaFMwFabRSclsICTjMYA4OP1waWkg3pb9kYR014HPKbCB5mZxrH8Dk8MuDyEtlFLpjeE1SAH7YLztPXKlO0pPO9IeBQux4ciwzQkx+bruiFtimyUEjSu7IKM/W73yjjaVoMrMlvSVMtHR2XrGsZMwMe5AFqBxYONojL5qDoJdppbZ5rJ6bK7ZuO5YQvxvpENV32Kbc6FWsRSc76z64USeo08U7YN1KATIEdZZPAnseM/Vv6kb6vNq+9Fe/mnrt/X+TwrACwBELhXrH8tqXX/jeKx+x6LH4YgikvNslQsLB7Fi5HAQyd3w7U+Bq2TUaQenZrPVjC0CpSf6w7HzlsECqFu17Iohr2YiFhlQZpcm3ZoyGkVBXSqX9B5olqv0FV02YeshRfN4USTvQyxQZHxcaq5MhUqjO1TmpCxy6gRk95I0dU8+LtDQlmUcDN2yHBq/nrYWih5xw675vAPnWuDrNP0AF37OV4dW/CiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5qYmU2a0g1Y1dacmprK0Njc04vR1B1dG9ER2hyM1pxanhZb2JDVFRSRVBG?=
 =?utf-8?B?TTEvYWVoU25zUXpwc25BYVhMSVc5ZE9PVkw5QmJWQmRmZ3Z3WHZkNzBvUjl2?=
 =?utf-8?B?c3ZQd01sQTI5eGhXd3ZtalFkdmRIdHZpaWVXNFdXbEErY3ZCTXU3QVB1RWxW?=
 =?utf-8?B?cEFSRTBlUjh4L0hQNTFFeW5VNXhuSTkyeFdhTWVUV2N1UERDUFl0QjBFUG4x?=
 =?utf-8?B?c3c0T1Jxd3N3SllRM1ZCQWk3RTJCazliMEFDWm5uQ2VFcXN0dmdGd3cydi9j?=
 =?utf-8?B?QUJyS2NsWGxjbkRSZWlmRWFFY1NCTm9vK2FZWlMwNGRyMi9Qd0h5RGkyZXdP?=
 =?utf-8?B?YWdsTzZJTWNINjZCOTVLM0x2L3gvY3FpVXpFRDZXTHFFT3ExQTBGQktGYVgy?=
 =?utf-8?B?Z0Z1WTlYeE0rYWdJd1Jyb2tNVGdvUlJtUm9SNkhDM0EvUDdmbjRIMjNnYkpl?=
 =?utf-8?B?dUVyaWxKb2hQZXF2MHlHNE9zQW54VDNpa3AwWWZrUHR1eVRNMWVaWmpmVWRF?=
 =?utf-8?B?RnhDcE5xeTB5RWpsbFh3SlRtTy9oek9jYXkxVnFCd3BES0NkNzI0WkV6YzNj?=
 =?utf-8?B?ZUpmaXg5SFNGRFBNc1UrMUtxMjVTTXZocWZsOXJBK1hnQU9jemVsbC94TGhs?=
 =?utf-8?B?bTVPcVovNnBwSzVmWTlqWVhDQzBEeWtPa3RNdmtJeXBJMUxDNEtmdmowQ0RF?=
 =?utf-8?B?OWRMVWhUTFBwODVRR0F3ZDd2TW9odnRhcjMyT09HT0dhY3E0UTFDVzRwRW1J?=
 =?utf-8?B?SEM3QmMyTFcrb2QxZWQxRmFYcnAvVFNGWnpwNjBEbDcxNnJoSUVXUnRjeWxo?=
 =?utf-8?B?QXNlRXVKUjEyTHN2LzFvMkhPaklNdldoazF2eHovdTJ3NE9ZbjRZS1ZmY2p3?=
 =?utf-8?B?a2JFcXFZdytad0taOVZVRVd4eE83dllZczNjYXZub2pYMWRKUDgxcGg4OEt1?=
 =?utf-8?B?VG83MGdpZVNTOFJmeG13enlJa0ZCNlh4WUJSWS9kWTEyRDNvQlJLc2UzTm50?=
 =?utf-8?B?cDE5NFk3UFZUY3lKYzh0elRoUzJGdTQxck1heW5JNzd4UWc4M29sWkhLbjQ1?=
 =?utf-8?B?aGg3YjBtU2ZmZElpaE93T2NUTjltdHNWLytOb3creEFVc1RGaEl1ZzV6YmE4?=
 =?utf-8?B?T0dJMGM4a3VhNU44cU9ZMVNONmxNVjVpUkYwNXNkWFdkQTZkMEsyaGcvWlow?=
 =?utf-8?B?RUFEcnJkTllZTER0bTZXaGUvZUNhSi8xcVljaE84L2xIRUdJMGlSblg2RmpS?=
 =?utf-8?B?ZWRjblFBQTBzSjh0UTlWU1hVTndZelptd3lpNi9zMjRPYXExK2h5STVRUi8w?=
 =?utf-8?B?dWJUak1MNzBTUDlmQWEydll3dzRLa0RNN1dCRzlLdFYvZEJsamhueVoxMGNK?=
 =?utf-8?B?aTBtUGVEeENkTDRHbnE0VkliZ0tsZjJZazlyZDhTbEYrTDZaQkxKY3NRcllB?=
 =?utf-8?B?THRRRU93VS9RbFQ1TWF4YTVEUGNhbnFiTFo0NzBjS1ZaWE1kWHVBSVpHVWJ2?=
 =?utf-8?B?RTQwWXFmUnMrMUJROWRucUdDVUl2U0htQm9GZ2F0OEJtWjNDYVU1YnBod0VM?=
 =?utf-8?B?UzVLT01SVFJnTTdMZ1EwbUtGZlp3ZE1Iejhrc1JRKzVDWW9zNGxWNk1Od2NO?=
 =?utf-8?B?SnVjekJxZW9oN1J6aE1ER2RoSWxrRlZCVEpVQVQ1NEdMUWRTMURiQ2RucEhS?=
 =?utf-8?B?RnRWRjN3V3hwd2ZTRFhSK0pWSTFhUVg5aDFpbGx1WXltWE5KR1kxLzJFbzVz?=
 =?utf-8?B?VTRIREJYTlRQMDdUU3pXWVlOaVdoMWJKOWhXeDlvZ3QwSmZ0QXNmbzRjdUZq?=
 =?utf-8?B?WHlKOTJzcGdNVzBTVE9sNzBhMU9EbThDVUVJVFVoaGxSdDFKaENzRGROaXdK?=
 =?utf-8?B?ZmRKRHIyVThlUldERVg0d2dDa0VsMVBBcmc3bVNwOGs2VFdJT2lRRDh1QTV3?=
 =?utf-8?B?OGtmUGoyN0JOSmkxWlFIU0dzTWRrUG4zc3VQZDZCMTJJZTk3K3grMjBsU01m?=
 =?utf-8?B?TVlSYTIya1I2UEJraFBaNFBGNmR0WTN3K3FJR0IrUkxFM3dLM0MxQWFYamtn?=
 =?utf-8?B?NFZuWUEyV09jRG55eGtBcUhOeGhod3VPSHp5amJZUEZlSzF6aDM5S2REbDVG?=
 =?utf-8?B?QXNCRnRMSnFGeUwwamQ5Nnh6VGlGdm5tblFHd1FEVnBtVUVwUUNMV3I0N1ND?=
 =?utf-8?B?Nk1VekZuQ2d2bmZldmtYdHpwc0R6VHNkQmpxRUNJUnR3ZTVzVHo1STZRWWYr?=
 =?utf-8?B?Znhuay9hUEFBQ3FOTXVzZUsyaTRyZGluNklpbE8xQkUrbG5kUlY0aUk4NElR?=
 =?utf-8?B?cmh1ZHpaWFZOZFFlak94bjY3U3E3OVI4d3ZJZi9kRXF4bHYveDdtKzhVR1Rh?=
 =?utf-8?Q?9edVaqsPjk7d+JNi8E542X0UW0Vl8lT5ccIES5EI0TK+x?=
X-MS-Exchange-AntiSpam-MessageData-1: QBNbhuHOIoc/XQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99ab467-7aa1-46ba-aa6d-08df0e26e44f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:31.3074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InTyCDq7wSyx7qwDw4C/LitXnuVgyaouISw42Mh1d5L6X1tUDHXwrBLYqQkuqpfa1otJIIi8h0RwAR48IAee3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add the page table walker implementation that traverses the page table
hierarchy for both MMU v2 (5-level) and MMU v3 (6-level) to resolve
virtual addresses to physical addresses or find PTE locations.

Currently only v2 has been tested (nova-core currently boots pre-hopper)
with some initial preparatory work done for v3.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: take mutable GpuMm and Pramin, not a bound device and window]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   1 +
 drivers/gpu/nova-core/mm/pagetable/walk.rs | 244 +++++++++++++++++++++++++++++
 2 files changed, 245 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index d88499ed3d56..99145846daed 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -10,6 +10,7 @@
 
 pub(super) mod ver2;
 pub(super) mod ver3;
+pub(super) mod walk;
 
 use kernel::{
     io::Io,
diff --git a/drivers/gpu/nova-core/mm/pagetable/walk.rs b/drivers/gpu/nova-core/mm/pagetable/walk.rs
new file mode 100644
index 000000000000..76c1729971f5
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/walk.rs
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Page table walker implementation for NVIDIA GPUs.
+//!
+//! This module provides page table walking functionality for MMU v2 and v3.
+//! The walker traverses the page table hierarchy to resolve virtual addresses
+//! to physical addresses or to find PTE locations.
+//!
+//! # Page Table Hierarchy
+//!
+//! ## MMU v2 (Turing/Ampere/Ada) - 5 levels
+//!
+//! ```text
+//!     +-------+     +-------+     +-------+     +---------+     +-------+
+//!     | PDB   |---->|  L1   |---->|  L2   |---->| L3 Dual |---->|  L4   |
+//!     | (L0)  |     |       |     |       |     | PDE     |     | (PTE) |
+//!     +-------+     +-------+     +-------+     +---------+     +-------+
+//!       64-bit        64-bit        64-bit        128-bit         64-bit
+//!        PDE           PDE           PDE        (big+small)        PTE
+//! ```
+//!
+//! ## MMU v3 (Hopper+) - 6 levels
+//!
+//! ```text
+//!     +-------+     +-------+     +-------+     +-------+     +---------+     +-------+
+//!     | PDB   |---->|  L1   |---->|  L2   |---->|  L3   |---->| L4 Dual |---->|  L5   |
+//!     | (L0)  |     |       |     |       |     |       |     | PDE     |     | (PTE) |
+//!     +-------+     +-------+     +-------+     +-------+     +---------+     +-------+
+//!       64-bit        64-bit        64-bit        64-bit        128-bit         64-bit
+//!        PDE           PDE           PDE           PDE        (big+small)        PTE
+//! ```
+//!
+//! # Result of a page table walk
+//!
+//! The walker returns a [`WalkResult`] indicating the outcome.
+
+use core::marker::PhantomData;
+
+use kernel::prelude::*;
+
+use super::{
+    DualPdeOps,
+    MmuConfig,
+    MmuV2,
+    MmuV3,
+    MmuVersion,
+    PageTableLevel,
+    PdeOps,
+    PteOps, //
+};
+use crate::{
+    mm::{
+        pramin,
+        GpuMm,
+        Pfn,
+        Vfn,
+        VirtualAddress,
+        VramAddress, //
+    },
+    num::{
+        IntoSafeCast, //
+    },
+};
+
+/// Result of walking to a PTE.
+#[derive(Debug, Clone, Copy)]
+pub(in crate::mm) enum WalkResult {
+    /// Intermediate page tables are missing (only returned in lookup mode).
+    PageTableMissing,
+    /// PTE exists but is invalid (page not mapped).
+    Unmapped { pte_addr: VramAddress },
+    /// PTE exists and is valid (page is mapped).
+    Mapped { pte_addr: VramAddress, pfn: Pfn },
+}
+
+/// Result of walking PDE levels only.
+///
+/// Returned by [`PtWalkInner::walk_pde_levels()`] to indicate whether all PDE
+/// levels resolved or a PDE is missing.
+#[derive(Debug, Clone, Copy)]
+pub(in crate::mm) enum WalkPdeResult {
+    /// All PDE levels resolved -- returns PTE page table address.
+    Complete {
+        /// VRAM address of the PTE-level page table.
+        pte_table: VramAddress,
+    },
+    /// A PDE is missing and no prepared page was provided by the closure.
+    Missing {
+        /// PDE slot address in the parent page table (where to install).
+        install_addr: VramAddress,
+        /// The page table level that is missing.
+        level: PageTableLevel,
+    },
+}
+
+/// Page table walker.
+pub(in crate::mm) struct PtWalkInner<M: MmuConfig> {
+    pdb_addr: VramAddress,
+    _phantom: PhantomData<M>,
+}
+
+impl<M: MmuConfig> PtWalkInner<M> {
+    /// Calculate the VRAM address of an entry within a page table.
+    fn entry_addr(table: VramAddress, level: PageTableLevel, index: u64) -> VramAddress {
+        let entry_size: u64 = M::entry_size(level).into_safe_cast();
+        table + index * entry_size
+    }
+
+    /// Create a new page table walker.
+    pub(super) fn new(pdb_addr: VramAddress) -> Self {
+        Self {
+            pdb_addr,
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Walk PDE levels with closure-based resolution for missing PDEs.
+    ///
+    /// Traverses all PDE levels for the MMU version. At each level, reads the PDE.
+    /// If valid, extracts the child table address and continues. If missing, calls
+    /// `resolve_prepared(install_addr)` to resolve the missing PDE.
+    pub(super) fn walk_pde_levels(
+        &self,
+        pramin: &mut pramin::Pramin<'_>,
+        vfn: Vfn,
+        resolve_prepared: impl Fn(VramAddress) -> Option<VramAddress>,
+    ) -> Result<WalkPdeResult> {
+        let va = VirtualAddress::from(vfn);
+        let mut cur_table = self.pdb_addr;
+
+        for &level in M::PDE_LEVELS {
+            let idx = M::level_index(va, level.as_index());
+            let install_addr = Self::entry_addr(cur_table, level, idx);
+
+            if level == M::DUAL_PDE_LEVEL {
+                // 128-bit dual PDE with big+small page table pointers.
+                let dpde = M::DualPde::read(pramin, install_addr)?;
+                if dpde.has_small() {
+                    cur_table = dpde.small_vram_address();
+                    continue;
+                }
+            } else {
+                // Regular 64-bit PDE. Use `is_valid_vram()` because
+                // `table_vram_address()` only reads the VRAM frame-number
+                // bitfield; system-memory PDEs store the address in a
+                // different (wider) field and would be silently truncated.
+                let pde = M::Pde::read(pramin, install_addr)?;
+                if pde.is_valid_vram() {
+                    cur_table = pde.table_vram_address();
+                    continue;
+                }
+            }
+
+            // PDE missing in HW. Ask caller for resolution.
+            if let Some(prepared_addr) = resolve_prepared(install_addr) {
+                cur_table = prepared_addr;
+                continue;
+            }
+
+            return Ok(WalkPdeResult::Missing {
+                install_addr,
+                level,
+            });
+        }
+
+        Ok(WalkPdeResult::Complete {
+            pte_table: cur_table,
+        })
+    }
+
+    /// Walk to PTE for lookup only (no allocation).
+    ///
+    /// Returns [`WalkResult::PageTableMissing`] if intermediate tables don't exist.
+    pub(super) fn walk_to_pte_lookup(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<WalkResult> {
+        self.walk_to_pte_lookup_with_window(mm.pramin_mut(), vfn)
+    }
+
+    /// Walk to PTE using a caller-provided PRAMIN manager (lookup only).
+    pub(super) fn walk_to_pte_lookup_with_window(
+        &self,
+        pramin: &mut pramin::Pramin<'_>,
+        vfn: Vfn,
+    ) -> Result<WalkResult> {
+        match self.walk_pde_levels(pramin, vfn, |_| None)? {
+            WalkPdeResult::Complete { pte_table } => {
+                Self::read_pte_at_level(pramin, vfn, pte_table)
+            }
+            WalkPdeResult::Missing { .. } => Ok(WalkResult::PageTableMissing),
+        }
+    }
+
+    /// Read the PTE at the PTE level given the PTE table address.
+    fn read_pte_at_level(
+        pramin: &mut pramin::Pramin<'_>,
+        vfn: Vfn,
+        pte_table: VramAddress,
+    ) -> Result<WalkResult> {
+        let va = VirtualAddress::from(vfn);
+        let pte_level = M::PTE_LEVEL;
+        let pte_idx = M::level_index(va, pte_level.as_index());
+        let pte_addr = Self::entry_addr(pte_table, pte_level, pte_idx);
+        let pte = M::Pte::read(pramin, pte_addr)?;
+
+        if pte.is_valid() {
+            return Ok(WalkResult::Mapped {
+                pte_addr,
+                pfn: pte.frame_number(),
+            });
+        }
+        Ok(WalkResult::Unmapped { pte_addr })
+    }
+}
+
+macro_rules! pt_walk_dispatch {
+    ($self:expr, $method:ident ( $($arg:expr),* $(,)? )) => {
+        match $self {
+            PtWalk::V2(inner) => inner.$method($($arg),*),
+            PtWalk::V3(inner) => inner.$method($($arg),*),
+        }
+    };
+}
+
+/// Page table walker dispatch.
+pub(in crate::mm) enum PtWalk {
+    /// MMU v2 (Turing/Ampere/Ada).
+    V2(PtWalkInner<MmuV2>),
+    /// MMU v3 (Hopper+).
+    V3(PtWalkInner<MmuV3>),
+}
+
+impl PtWalk {
+    /// Create a new page table walker for the given MMU version.
+    pub(in crate::mm) fn new(pdb_addr: VramAddress, version: MmuVersion) -> Self {
+        match version {
+            MmuVersion::V2 => Self::V2(PtWalkInner::<MmuV2>::new(pdb_addr)),
+            MmuVersion::V3 => Self::V3(PtWalkInner::<MmuV3>::new(pdb_addr)),
+        }
+    }
+
+    /// Walk to PTE for lookup.
+    pub(in crate::mm) fn walk_to_pte(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<WalkResult> {
+        pt_walk_dispatch!(self, walk_to_pte_lookup(mm, vfn))
+    }
+}

-- 
2.55.0

