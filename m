Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2616CC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878C610EE82;
	Wed,  9 Sep 2026 04:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QEBDylgx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D8010EE82
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgkra/KRqqEQ1DcON27n7sJxZiAKuwJjIZ8prRNidYd++ngs3Wj/qyaSq9KOPcHQ6Vfe5utdlHt9e/OU6rX4GFAPbNUERiig9dNvxdFBox9vsY511zYs5Qn7Yr8SjMTSMzFIFomSlfWpTQKGZQfgJgKSptvxvUEZXbcQr/pghmPi3euGuawBylmR8WuzNQrVX08Jw7zcMmWUdb6PJlNogcfPINcss7q85FXjtwafGlT2Kirkwc9kSmh7PnO4UCEk9QgABcFp404MgwS/DxhFtEUzlPWD1CeQ0UeU6CGlrGufVl1BxOSukiPtvkqRMu/8+i2D/U1IkYJ2isRm91lgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmIFw/eodPAV3vr4OEmuhzdcv+p+yzWvHEbfI/QoUA0=;
 b=AxSjXBuWv0yXKn8dRuSkUDVba07cGrpYbKbAgoFbpNHtTeZOCqrIXUkkwIJJeAMIF5JpAU7gHBIHvDFtiKg/bUuyvB1HeC7udYAzAhufiSHB6RQFsSn08zmVl8aIGH/NK/k/WlXZOmQWkHF5i3hcr2OOrMxr9RDH9DXiBmWsM9MnPW1R3ZF7UTCuIRHFGmM+ZYAuF+CGA4GzEXtVVREfwy/fLACJI5NAwyh6GM8r9vJbORAtsaI+QEUsb7sYnCaPWDFO5jap33X4YS9SzMJaxPYU+VEzIAQ6sqcd+p39Z/g5nIrtjlHR1kGJj7UNmPOvWkM2Oh5pp2iTFO5F2ijBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmIFw/eodPAV3vr4OEmuhzdcv+p+yzWvHEbfI/QoUA0=;
 b=QEBDylgx1fvU37eotBhozm+pDag3f++kPiEX6mP1KRTxexf70JDSKCAxCDNtPzRHC9N71+ibpdWQ97UndxF3hIfjAWVmGj4kMX1ri99pRmAtUB9xVWjWZNkQvkU3JDsy4Fho8iTkFC9ZBCUf66aAIwP8he4L7UUc4+g4iOlSUYvZC8QLIjWuvKSo6kG7SlJbGMReQP4kJaQ+tjM/0S5mCvhaERJRK6IlKXQtKgZ3cRUuGO50G4R8LVY1UCSza5g1vUPInYWu8VGPpnpGOzwPb9BNUtrszSpmWIU1LxR5HaIzPL1jS61UkHmu58CX6bUJ4K9VwGX8EmtQAykxBMGQfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:24 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:24 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:46 +0900
Subject: [PATCH 08/16] gpu: nova-core: mm: Add MMU v3 page table types
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-8-8dd5d4225d2e@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0105.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e14154-f6d6-4741-838a-08df0e26e02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bRXwPFXI29yiFiCqfXgXlWBCrVrzjoaRgMXAHhiKZZMzcADbVwsnoWY9wUiLpQL8P6b+jmfikVqCPRxJ7AKi0Hd5ExhGMM6TnUB4YKiqBSJx9lashc1omhykgwVA2OwVZqt87mRKhWuXGjkHAu+pXZuLhIsCY2vM1e2GoyiduwWSTW+rVZ5Dx3vIz00cbMygMdno3rEfo+AtnLUlrMnmZe1AZ54QWR2/LwcqQ70pv58sm4bvgzeNeN+N5DmpZGvbFTJwmDI8FY//O+jdUW0F1bg19TqAZlxpqBdRyNYNDR53Ifvbmf9po8oDfUbNo5GVTUnsJcUBagkoog14KJOIZ+QFbfObRMplRxVl8oX/amfPW9nQHmXRmHNZkK728pG0CeklYobMHvZD9GvJS38cGrhbRJWcJ/3tbpr9lfMVLcCAL42Kx3L4uHXc5rQIeumNegczCZPEpNqxXq+yzjlgDKP57o0hpvHbGiRI8qwtPVO5EkKzQWUcWPtcNBLrRLEAV0MSWri/7s9z0A9xcUo5pVFXqSvqWegBldvljWxWqN09IYfvsiMjm/uBbgkCXd5+Boomv0yc3jBVPs+1fTfkoVv59VcOvLkFtXjvVsQ/FOVUPPFUtLE5flpOiYC9CJo7i8DwlMi6zq3L33XXMDjifQ5UNEvsVDZaxcZyuyuJzFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBrdC9LN0VvZTU5YjNCZSsyM1l0Ti96SkVuUkJKUU51NkNvc1EzMzdMNkVS?=
 =?utf-8?B?YWF3S21KdGM1Sm5BLzQ2UDN4QTltdjV5b2VpWE0xUlY1VXVUS05yWGZYRkhY?=
 =?utf-8?B?aVdncTRuYXZmVENpd0FXU3FGbW5OWUI1ZTI0UkVscy8xV0Rrc29YNHhkaGE4?=
 =?utf-8?B?NFczcUpadmhoVzlMUnU1ODdIdzhQZ0szWlRuZ3lGVTJpeXJRRFVabXhIQnZC?=
 =?utf-8?B?SEhpTmR1ekhhL2xRMmRzSmZhOE4xMTlUNHFGYVJCMmNUVGw2SmRvdW00S0dR?=
 =?utf-8?B?Z0lXbUNpQXlnbnVtU0R5elpOckRWOWdUdkxGenVHSVJsamxNd2hFU0gzZnVH?=
 =?utf-8?B?WU1lQ09UOFQzY1dORFozZmRLNE4yTm1BTE9XVDFoNm0rekNSQks1YllZaHJh?=
 =?utf-8?B?Y3VVR3ZxdlFSZFNuUm13WkNKZE1TaytUcGpxVVRjcmlKUWlBcGR2dWR6amZs?=
 =?utf-8?B?Ym9rYWVFQVZGeDBYSUdXK20vdFN4Ykh1cXdDNWgwaHVqMk1LdHo1eGxkaXFG?=
 =?utf-8?B?Q3pjQlhqK2FmSU5TdGxkUlZOajFwMENoQUQ0MHRVcE8yTHB0UDRISk9iWm9D?=
 =?utf-8?B?NTV2MFh3NWo4VkxDVGk4L1lGd3RTN0YxdzB3Q0NvVXlrSTJvSHlzTGF2NnJX?=
 =?utf-8?B?ak1vZkRkdUQxYVFXRVJZamtseWJ5UlptaFhrbVpzbi9iOEhzNlV5L3dBeXB4?=
 =?utf-8?B?dVB0aWRzSVd4R055YVZtdHhSSTQzelNFMnVaa3ZoYTg5YWF3WWdMUnJuR2d0?=
 =?utf-8?B?Zm9xMzd0V2w0TEdSSHJmYVFCRzdxWmVzQU1sMlJJL3VSbkJwR3M5dCsyVUt4?=
 =?utf-8?B?RDFSbUZqUGxyUXBvaTNSNjBJQjVoaUFHdG5pVTlVZk9zVFhOcTlDcktoeXo0?=
 =?utf-8?B?TWw3UVhDL1hnNjVoTFJkaGo2TzByN0dzRzdzSDE1R2N4SjNseFY4aEtQeUw0?=
 =?utf-8?B?aTQweFZURC83U1VRb3NTQXZoSEhXYnZNanZDdjVXeTROQXFFcmhlYlJieEkw?=
 =?utf-8?B?MTZ5L09wdWd0endkTlpFd3dqcTFJdVhrc1VZR2s1Z2t6NUpSVWtLSVY0UXNp?=
 =?utf-8?B?eG5hU00ydUFISEpMcHpNS1BJTzkxY2tzaDJKZzVueldaT1lzaW5Fck8xeHdV?=
 =?utf-8?B?bjZYYVhUOUNPZ1F0K2hwTm1yK3dHOFg2TUZmMTJ0U2REQVlIK05TaXJjWEZS?=
 =?utf-8?B?YnBUOStISmk0NDhOcFVwOERacW5FV045MGFRdHg0RlRGVk11U2tJTTNVRnI3?=
 =?utf-8?B?N1NGbFRYZFlwclFPZnJmTENOOFZRUHJCZmsxNVZEdVdNSEdTbHBkekZnRWRX?=
 =?utf-8?B?d01OU1ROMHdsUHVZSnlEczBxUHNTRXArVzlBcXZ5b1Z0S0ZGSjRpOFdtVWdC?=
 =?utf-8?B?Y2p2Q1RZd2ZGWUFZOGFqdjROT2tzR291YXltWjB2RFh5OXh3cmV3eTBmQ0lE?=
 =?utf-8?B?cFY1ZUJwelhiMVN3eURtTlZXREFjQzFUMUJpSmo3ZDY2OEtoZVh5Mm1GNkh2?=
 =?utf-8?B?STk1Tm5jZGZ3UzZXc3N6aUM0Qk1SSnM0ODNtYlN3SmxDZFFSWlFpL2RGcjZi?=
 =?utf-8?B?VFZxdGR3TWtObUNUdTNCdDRMZExqY2ViaFhrVGs1NEF5RVVza3ZBU0cvN3Bu?=
 =?utf-8?B?RHFBZnBLUVpjSC9UcnhDaDJsdHU2Z3Q3U00ySzlWY1FKYlZwaVdoSFpCMjBx?=
 =?utf-8?B?NVdYUmZGZHhIZlJuT1FHUDRXS3gzZ0gzckF4WU1PaUJEUmFoNm1ycE9PTHhz?=
 =?utf-8?B?UGtBTUorT1NITEJoMSs1azRWQldGNnVGbWJaUGxOeVlpdE5vMGUxclZrVzA4?=
 =?utf-8?B?M2hFendLNmFjb2w0OC9mNk1weit4SUpjS0pRSmhIdmpHWVdUQmpCbU5mYUdK?=
 =?utf-8?B?NEFJRk52S05peTZXZVdWOTlxYU15RVRra0ZpNk5BdkJMZSthRGdMcHNZd3VP?=
 =?utf-8?B?RG9xbitreUdDZUlEdVNYOU5LTTJBdWtyOFlYR0FvcFZWREp1WlkrRmttWVdn?=
 =?utf-8?B?TkY4aU5mTTFqQjJpWVBKZGZGcytlTkRUZm9qVjMzTG9TdUJnQ2RiVE1ZeDVB?=
 =?utf-8?B?VjJQWFEyTVNiTGc5NFlRdFhzWVdBZ1FCSDJqM0RVajlyWU5xd0Q4T291TTBV?=
 =?utf-8?B?RzRCODBaanlnMnJLNC9kY1RWbytuMnc2VWMxbFFlb3ZmT3RQVUlteElMVFdp?=
 =?utf-8?B?LzU2VXJDMGR6TFNKb2xEQ1ZSMW1Rd1c4ZDlFV0hZVzVLYkRnbmNVWG1XL1M0?=
 =?utf-8?B?TDArT1NWUTVDaXNPNjd0aXkvMXJ5SWRVYzBlRllKcHNqT3pCNWpKSUpqWEdy?=
 =?utf-8?B?d3czOHFVSnIyT0tlZTFGNkI1WFczKzZLVlJGZlZwM0lhcXdLRlpnN1RGVnkx?=
 =?utf-8?Q?NCYe+yy8p8T/HLslTNZnCWIZ5MJsjWRLCKcrZwt3RMhKV?=
X-MS-Exchange-AntiSpam-MessageData-1: bkCJ2Wg6Ref2/g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e14154-f6d6-4741-838a-08df0e26e02c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:24.3750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaEKg6qEO2Kyj4xaFShJkSilIU2pvCDGxno0C2DnJIPBwTAeVf5g/F0tns0/rZQ6EYqBXtioTkO9h2SCxhvi1Q==
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

Add page table entry and directory structures for MMU version 3 used by
Hopper and later GPUs. The `Pte`, `Pde`, and `DualPde` types each
implement the `PteOps`, `PdeOps`, and `DualPdeOps` traits introduced
earlier in the series, providing the version-agnostic API used by the
forthcoming page-table walker and mapper.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: update for the VramAddress raw API, apply rustfmt]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs      |   1 +
 drivers/gpu/nova-core/mm/pagetable/ver3.rs | 417 +++++++++++++++++++++++++++++
 2 files changed, 418 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index df8e7e7d7327..128bfc0d277a 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -9,6 +9,7 @@
 #![expect(dead_code)]
 
 pub(super) mod ver2;
+pub(super) mod ver3;
 
 use kernel::{
     io::Io,
diff --git a/drivers/gpu/nova-core/mm/pagetable/ver3.rs b/drivers/gpu/nova-core/mm/pagetable/ver3.rs
new file mode 100644
index 000000000000..80c06463de88
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/ver3.rs
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! MMU v3 page table types for Hopper and later GPUs.
+//!
+//! This module defines MMU version 3 specific types (Hopper and later GPUs).
+//!
+//! Key differences from MMU v2:
+//! - Unified 40-bit address field for all apertures (v2 had separate sys/vid fields).
+//! - PCF (Page Classification Field) replaces separate privilege/RO/atomic/cache bits.
+//! - KIND field is 4 bits (not 8).
+//! - IS_PTE bit in PDE to support large pages directly.
+//! - No COMPTAGLINE field (compression handled differently in v3).
+//! - No separate ENCRYPTED bit.
+//!
+//! Bit field layouts derived from the NVIDIA OpenRM documentation:
+//! `open-gpu-kernel-modules/src/common/inc/swref/published/hopper/gh100/dev_mmu.h`
+
+#![allow(dead_code)]
+
+use kernel::bitfield;
+use kernel::num::Bounded;
+use kernel::prelude::*;
+use pin_init::Zeroable;
+
+use super::{
+    AperturePde,
+    AperturePte,
+    DualPdeOps,
+    PageTableLevel,
+    PdeOps,
+    PteOps,
+    VaLevelIndex, //
+};
+use crate::mm::{
+    Pfn,
+    VirtualAddress,
+    VramAddress, //
+};
+
+// Bounded to version 3 Pfn conversion.
+impl_pfn_bounded!(40);
+
+bitfield! {
+    /// MMU v3 57-bit virtual address layout.
+    pub(super) struct VirtualAddressV3(u64) {
+        /// Page offset [11:0].
+        11:0    offset;
+        /// PT index [20:12].
+        20:12   pt_idx;
+        /// PDE0 index [28:21].
+        28:21   pde0_idx;
+        /// PDE1 index [37:29].
+        37:29   pde1_idx;
+        /// PDE2 index [46:38].
+        46:38   pde2_idx;
+        /// PDE3 index [55:47].
+        55:47   pde3_idx;
+        /// PDE4 index [56].
+        56:56   pde4_idx;
+    }
+}
+
+impl VirtualAddressV3 {
+    /// Create a [`VirtualAddressV3`] from a [`VirtualAddress`].
+    pub(super) fn new(va: VirtualAddress) -> Self {
+        Self::from_raw(va.into_raw())
+    }
+}
+
+impl VaLevelIndex for VirtualAddressV3 {
+    fn level_index(&self, level: u64) -> u64 {
+        match level {
+            0 => *self.pde4_idx(),
+            1 => *self.pde3_idx(),
+            2 => *self.pde2_idx(),
+            3 => *self.pde1_idx(),
+            4 => *self.pde0_idx(),
+            5 => *self.pt_idx(),
+            _ => 0,
+        }
+    }
+}
+
+/// PDE levels for MMU v3 (6-level hierarchy).
+pub(super) const PDE_LEVELS: &[PageTableLevel] = &[
+    PageTableLevel::Pdb,
+    PageTableLevel::L1,
+    PageTableLevel::L2,
+    PageTableLevel::L3,
+    PageTableLevel::L4,
+];
+
+/// PTE level for MMU v3.
+pub(super) const PTE_LEVEL: PageTableLevel = PageTableLevel::L5;
+
+/// Dual PDE level for MMU v3 (128-bit entries).
+pub(super) const DUAL_PDE_LEVEL: PageTableLevel = PageTableLevel::L4;
+
+bitfield! {
+    /// Page Classification Field for PTEs (5 bits) in MMU v3.
+    pub(in crate::mm) struct PtePcf(u8) {
+        /// Bypass L2 cache (0=cached, 1=bypass).
+        0:0     uncached;
+        /// Access counting disabled (0=enabled, 1=disabled).
+        1:1     acd;
+        /// Read-only access (0=read-write, 1=read-only).
+        2:2     read_only;
+        /// Atomics disabled (0=enabled, 1=disabled).
+        3:3     no_atomic;
+        /// Privileged access only (0=regular, 1=privileged).
+        4:4     privileged;
+    }
+}
+
+impl PtePcf {
+    /// Create PCF for read-write mapping (cached, no atomics, regular mode).
+    fn rw() -> Self {
+        Self::zeroed().with_no_atomic(true)
+    }
+
+    /// Create PCF for read-only mapping (cached, no atomics, regular mode).
+    fn ro() -> Self {
+        Self::zeroed().with_read_only(true).with_no_atomic(true)
+    }
+
+    /// Get the raw `u8` value.
+    fn raw_u8(&self) -> u8 {
+        self.into_raw()
+    }
+}
+
+impl From<Bounded<u64, 5>> for PtePcf {
+    fn from(val: Bounded<u64, 5>) -> Self {
+        Self::from_raw(u8::from(val))
+    }
+}
+
+impl From<PtePcf> for Bounded<u64, 5> {
+    fn from(pcf: PtePcf) -> Self {
+        Bounded::from_expr(u64::from(pcf.into_raw()) & 0x1F)
+    }
+}
+
+bitfield! {
+    /// Page Classification Field for PDEs (3 bits) in MMU v3.
+    ///
+    /// Controls Address Translation Services (ATS) and caching.
+    pub(in crate::mm) struct PdePcf(u8) {
+        /// Bypass L2 cache (0=cached, 1=bypass).
+        0:0     uncached;
+        /// ATS disabled (0=enabled, 1=disabled).
+        1:1     no_ats;
+    }
+}
+
+impl PdePcf {
+    /// Create PCF for cached mapping with ATS enabled (default).
+    fn cached() -> Self {
+        Self::zeroed()
+    }
+
+    /// Get the raw `u8` value.
+    fn raw_u8(&self) -> u8 {
+        self.into_raw()
+    }
+}
+
+impl From<Bounded<u64, 3>> for PdePcf {
+    fn from(val: Bounded<u64, 3>) -> Self {
+        Self::from_raw(u8::from(val))
+    }
+}
+
+impl From<PdePcf> for Bounded<u64, 3> {
+    fn from(pcf: PdePcf) -> Self {
+        Bounded::from_expr(u64::from(pcf.into_raw()) & 0x7)
+    }
+}
+
+bitfield! {
+    /// Page Table Entry for MMU v3.
+    pub(in crate::mm) struct Pte(u64) {
+        /// Entry is valid.
+        0:0     valid;
+        /// Memory aperture type.
+        2:1     aperture => AperturePte;
+        /// Page Classification Field.
+        7:3     pcf => PtePcf;
+        /// Surface kind (4 bits, 0x0=pitch, 0xF=invalid).
+        11:8    kind;
+        /// Physical frame number (for all apertures).
+        51:12   frame_number => Pfn;
+        /// Peer GPU ID for peer memory (0-7).
+        63:61   peer_id;
+    }
+}
+
+impl PteOps for Pte {
+    fn from_raw(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn invalid() -> Self {
+        Self::zeroed()
+    }
+
+    fn new(aperture: AperturePte, pfn: Pfn, writable: bool) -> Self {
+        let pcf = match (aperture, writable) {
+            (AperturePte::VideoMemory, true) => PtePcf::rw(),
+            (AperturePte::VideoMemory, false) => PtePcf::ro(),
+            // Sysmem PTEs use uncached+no_atomic PCF for cache coherency.
+            (AperturePte::SystemCoherent, true) => {
+                PtePcf::zeroed().with_uncached(true).with_no_atomic(true)
+            }
+            (AperturePte::SystemCoherent, false) => PtePcf::zeroed()
+                .with_uncached(true)
+                .with_no_atomic(true)
+                .with_read_only(true),
+            (AperturePte::PeerMemory | AperturePte::SystemNonCoherent, _) => {
+                kernel::pr_warn!("MMU v3 PTE aperture {:?} not supported\n", aperture);
+                return Self::invalid();
+            }
+        };
+        Self::zeroed()
+            .with_valid(true)
+            .with_aperture(aperture)
+            .with_pcf(pcf)
+            .with_frame_number(pfn)
+    }
+
+    fn is_valid(&self) -> bool {
+        self.valid().into_bool()
+    }
+
+    fn frame_number(&self) -> Pfn {
+        Pte::frame_number(*self)
+    }
+}
+
+bitfield! {
+    /// Page Directory Entry for MMU v3 (Hopper+).
+    ///
+    /// ## Note
+    ///
+    /// v3 uses a unified 40-bit address field (v2 had separate sys/vid address fields).
+    pub(in crate::mm) struct Pde(u64) {
+        /// Entry is a PTE (0=PDE, 1=large page PTE).
+        0:0     is_pte;
+        /// Memory aperture type.
+        2:1     aperture => AperturePde;
+        /// Page Classification Field (3 bits for PDE).
+        5:3     pcf => PdePcf;
+        /// Table frame number (40-bit unified address).
+        51:12   table_frame => Pfn;
+    }
+}
+
+impl PdeOps for Pde {
+    fn from_raw(val: u64) -> Self {
+        Self::from_raw(val)
+    }
+
+    fn new(aperture: AperturePde, table_pfn: Pfn) -> Self {
+        match aperture {
+            AperturePde::VideoMemory => Self::zeroed()
+                .with_is_pte(false)
+                .with_aperture(aperture)
+                .with_table_frame(table_pfn),
+            AperturePde::Invalid | AperturePde::SystemCoherent | AperturePde::SystemNonCoherent => {
+                kernel::pr_warn!("MMU v3 PDE aperture {:?} not supported\n", aperture);
+                Self::invalid()
+            }
+        }
+    }
+
+    fn invalid() -> Self {
+        Self::zeroed().with_aperture(AperturePde::Invalid)
+    }
+
+    fn is_valid(&self) -> bool {
+        Pde::aperture(*self) != AperturePde::Invalid
+    }
+
+    fn aperture(&self) -> AperturePde {
+        Pde::aperture(*self)
+    }
+
+    fn table_vram_address(&self) -> VramAddress {
+        debug_assert!(
+            Pde::aperture(*self) == AperturePde::VideoMemory,
+            "table_vram_address called on non-VRAM PDE (aperture: {:?})",
+            Pde::aperture(*self)
+        );
+        VramAddress::from(self.table_frame())
+    }
+}
+
+bitfield! {
+    /// Big Page Table pointer in Dual PDE (MMU v3).
+    ///
+    /// 64-bit lower word of the 128-bit Dual PDE.
+    pub(super) struct DualPdeBig(u64) {
+        /// Entry is a PTE (for large pages).
+        0:0     is_pte;
+        /// Memory aperture type.
+        2:1     aperture => AperturePde;
+        /// Page Classification Field.
+        5:3     pcf => PdePcf;
+        /// Table frame (table address 256-byte aligned).
+        51:8    table_frame;
+    }
+}
+
+impl DualPdeBig {
+    /// Create an invalid big page table pointer.
+    fn invalid() -> Self {
+        Self::zeroed().with_aperture(AperturePde::Invalid)
+    }
+
+    /// Create a valid big PDE pointing to a page table in the given aperture.
+    fn new(aperture: AperturePde, table_addr: VramAddress) -> Result<Self> {
+        // Big page table addresses must be 256-byte aligned (shift 8).
+        if table_addr.into_raw() & 0xFF != 0 {
+            return Err(EINVAL);
+        }
+        let table_frame = Bounded::from_expr(table_addr.into_raw() >> 8);
+        match aperture {
+            AperturePde::VideoMemory => Ok(Self::zeroed()
+                .with_is_pte(false)
+                .with_aperture(aperture)
+                .with_table_frame(table_frame)),
+            AperturePde::Invalid | AperturePde::SystemCoherent | AperturePde::SystemNonCoherent => {
+                kernel::pr_warn!("MMU v3 DualPdeBig aperture {:?} not supported\n", aperture);
+                Ok(Self::invalid())
+            }
+        }
+    }
+
+    /// Check if this big PDE is valid.
+    fn is_valid(&self) -> bool {
+        self.aperture() != AperturePde::Invalid
+    }
+
+    /// Get the VRAM address of the big page table.
+    fn table_vram_address(&self) -> VramAddress {
+        debug_assert!(
+            self.aperture() == AperturePde::VideoMemory,
+            "table_vram_address called on non-VRAM DualPdeBig (aperture: {:?})",
+            self.aperture()
+        );
+        VramAddress::from_raw(*self.table_frame() << 8)
+    }
+}
+
+/// Dual PDE at Level 4 for MMU v3 - 128-bit entry.
+///
+/// Contains both big (64KB) and small (4KB) page table pointers:
+/// - Lower 64 bits: Big Page Table pointer.
+/// - Upper 64 bits: Small Page Table pointer.
+///
+/// ## Note
+///
+/// The big and small page table pointers have different address layouts:
+/// - Big address = field value << 8 (256-byte alignment).
+/// - Small address = field value << 12 (4KB alignment).
+///
+/// This is why `DualPdeBig` is a separate type from `Pde`.
+#[repr(C)]
+#[derive(Debug, Clone, Copy)]
+pub(in crate::mm) struct DualPde {
+    /// Big Page Table pointer.
+    pub(super) big: DualPdeBig,
+    /// Small Page Table pointer.
+    pub(super) small: Pde,
+}
+
+// SAFETY: Both `DualPdeBig` and `Pde` fields are `Zeroable` (bitfield types are Zeroable).
+unsafe impl Zeroable for DualPde {}
+
+impl DualPde {
+    /// Check if the big page table pointer is valid.
+    fn has_big(&self) -> bool {
+        self.big.is_valid()
+    }
+}
+
+impl DualPdeOps for DualPde {
+    fn from_raw(big: u64, small: u64) -> Self {
+        Self {
+            big: DualPdeBig::from_raw(big),
+            small: PdeOps::from_raw(small),
+        }
+    }
+
+    fn new_small(table_pfn: Pfn) -> Self {
+        Self {
+            big: DualPdeBig::invalid(),
+            small: PdeOps::new(AperturePde::VideoMemory, table_pfn),
+        }
+    }
+
+    fn has_small(&self) -> bool {
+        PdeOps::is_valid(&self.small)
+    }
+
+    fn small_vram_address(&self) -> VramAddress {
+        PdeOps::table_vram_address(&self.small)
+    }
+
+    fn big_raw_u64(&self) -> u64 {
+        self.big.into_raw()
+    }
+
+    fn small_raw_u64(&self) -> u64 {
+        self.small.into_raw()
+    }
+}

-- 
2.55.0

