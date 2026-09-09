Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17952C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F55E10EE8D;
	Wed,  9 Sep 2026 04:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U8XpV1Tj";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D480910EE8A
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOYXaqtw2thz3k/FA4EjdyJ6Dlxx+qFkgc8hNdX4YgRVeO1jatXZUXdmmNUglYhS7q4VUITwUQWfGcDL7Cgt/vLqSBaBdtvv0x7qTAYabiQDiGjIL7hzVv2g3StM3nO+IfOAL49hCbJFzoRr0MgVOyzdQmB+Pl7sLUgNucfJCCfSZSzmm65VfeosKF2GFPDkUAIWhcm+jq47KisBGpB47rJRSRqrv/lDAj6WCwpsX2RlPnV7jJMt+COQnGj3lI65T+0++X7QWvDH1LT7gJ0/2NebdKp4Ec/RPi6oe+tt8UzX9H5sidBuHFYCmGN0LXhCzS0YNxex3YQRk/nTyhuVzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMLSFf5DDxqcX7aFG3bBS/if6gxHZWvMp3adY7mnJew=;
 b=fo7LnghBDSR0rKIejA12U+eWGQK1RJwj4O3D/awZBEKJTWi8uL8Z4bT42oOXQamKRcfGjonvjv4BQnjme3VQMSaDfRBLrpwi8L5EuU/u9H/0tbUgf1sWF7Gq1pJhuOhOaqCphLrNR5m0Q9AvELuZgYBtRPDJ0mq5uJgCRQPWucEg3MTwffw5HzWzo71e/u9V2DcGFB5oC5xl/Oujdf5XbCqbPFkFlgSbM3lZsqlt95HgQC+7FXmyGzdTmYCRT8zbjp/MqoNuFDpCKyj7Yl2uDmqrhv7eX789+VwKksIAit8TiId3hc9a+rKvQbjQGASt/pcniNUqF02f4KxqRPOVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMLSFf5DDxqcX7aFG3bBS/if6gxHZWvMp3adY7mnJew=;
 b=U8XpV1Tjz0s8aYtD1J+yq1lRTyk1B9tIvVnrYyrXQaysyosp1oJptap6Ce95qamKozY70tU2Nwc7z/7SEfTvFZmfa/Gs8l8bcdDcqncy1aDYBJI1DjGmRomAtFIvmH2MQmHM9qKUO/66bZ+qrkO9r/FdxTYfleq0NgHy/0flVc+mafLWKBY6QmFgUC8KGwp4j9gcNG33Z5k4DklH6QihKveBKsAmrsUh+TF2JGQ6Aw/JSP7KvUHxxkyc84WN4hAmDeeDqed92C+WaxEjqY/Logs/vCCeeYg18SSvo14vbf0bcrYbErm8J/MKx/pHrrQ1wuTB/PXJ1P52Oz8fGBctTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:42 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:42 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:51 +0900
Subject: [PATCH 13/16] gpu: nova-core: mm: Add multi-page mapping API to
 VMM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-13-8dd5d4225d2e@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: b561070c-bd6d-4f9f-cf6b-08df0e26eadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|6133799003|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: h8fszSP49rV7UpCloLzxpIJIDBiwGtbOdNmEzAjE12+H9UblRCyN657H0xLcuAj7UNNjOpc1UgLZJC42qHAe11WIGNROhkUX6xXkN6E+RPIulGNADDL++kLSw37uESiytoWohoINWufYIfuMICOFnUREwNubyFevgcBE8otsATp2z2c6ycGekBknJwMJnVAAlBSEWYHQR4a55lxD086+Qs5RdCAzayPF3lh0MVWYBQPjAuqW22nH3mVsfmyb4EGcoG/rp5mgNaof38vpXEgRpMKXhcy07AQjn4Tbc1ru+bX4goPqm4pH7lFbhn32nQAGy7D7vNO8Ne2InOUg2S3BycdU2LRLgS6/UM6XeE5g6Vej90x9UTzZUKyya663dbEZMv5JfyvVpW1REilZJOpuePpJoGJmfoFS1tc+3bJBUKjqxo/6LUW8sr5rWztqAbrsYgNdPbFmGoY9J/natyPyfcegduY7p00T55wSJI/+hi8f+lRYAvTcJjswuHqliynRUQYvAoY6Ptx9xfVYcPt5lmuOW58O8wU4JEdEJySmaidQXktO3isxpNTBu7tJ0JWzKeM1bvf2APYj5v2LyRMVRMYcK8Mee8mrAs/GniRbUeUkVMR/A1I5jYOpjpqRazTKGTxXNnIm6wYSVOxaq4Rhgsw53kwNMpXTZAihm25ah5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk1VRXppYUwrc1diMVVvdmgzK2laWXRPV0pFOGhyRVhvbnd4MzN0ZGZYQXRj?=
 =?utf-8?B?STJ2Mi92Y1BGZGZEWWZyTG5kempIV3U5ZGV4NnBQYXBDNVdDSkdzNHBONTVn?=
 =?utf-8?B?YlMzRjh3dUhETFBBZURXTnBtR1oydjJjTGdwbVNEWGwvemFvc2xmc2ZxVEox?=
 =?utf-8?B?M2xUZ1FlODRHc0dKcWh0a1lvRVJET1VQVUVKWVZGakNiQkRRRlBYSmJwbFZE?=
 =?utf-8?B?Ri83TFF1djNnanJMQzhKck5QTWRlSEF1M096YkNFZVpKSzVjcHZUdkV5eUpS?=
 =?utf-8?B?ZmwvcVFFN3pMdkxLcXU0c1NzUlVablBWZGN6bmdMS3pCdnJIQy9rdytibkw5?=
 =?utf-8?B?bitGWHhpWmhaL0ZsTE1qK1pyMXpRbFZRTlNvc2VoR08rMFBSWlBlTDgvOXBP?=
 =?utf-8?B?bGQ4VHUyNDNQb1d3Y0pvZlFLbTEyZ240TTBocldPbE1aTmgxejNDeGtTQ2sv?=
 =?utf-8?B?bDFXZytoa25mVmI5Q3IwbTZmaUlhUUxkbUd3M093bk44WHhPSGhOTC94K0RX?=
 =?utf-8?B?cm13blNUaVdaMzFTYjUzaXk1anNTVWFEY2tkNGlNcG5odlROUUllNUdBOWNP?=
 =?utf-8?B?b2RGbW5TbXM3NEJXUUF5SEh4cDA5VmRNWUtOV2VibEJMR1hyS1lDZE5UTWpR?=
 =?utf-8?B?elNwSStuNmVMK1d4ZEZ6VnNOU3Y5d3lyYzg1RCtFdHRJK3I0OExCdC9HekJl?=
 =?utf-8?B?VnBJS21NVEN1NjNCY0tWdUl5Nm12UCs2SUppc0xYRFpaaHZkTEdrUkkxTDBn?=
 =?utf-8?B?bVc2UnZQa2ZIKzhKOGtINmxqWjVUc092Ris3dGFLYXlKVWlZeFd3Y1g5UG93?=
 =?utf-8?B?OTlsMnErcXZpYTFoZ08ySUxyOVJUd0JZQzlISkVMN25vNStHeFo2alVNNVZY?=
 =?utf-8?B?MUdFK05EUGxNQ2NQU2RuQktKMmFMdjJWMU9leWtpZWpzLzUrT3J6bTNqdWo3?=
 =?utf-8?B?cXhNOFpyNzJncER0SmVZQUo4QWtpV1EwZU1ESzQwOWQzQ0x6TS9PVjRFRThq?=
 =?utf-8?B?b1E3SWN6TXBLRDM2Wnpud2tadDYvWmltbFcrYnJUK2g2Y0phMnNvQnZZY0ln?=
 =?utf-8?B?SW1NRHBuMndiZVI0TGtYZW5zanhtaXJ5ZUhva3lKSkhObVhqcFZaYWxoMWVP?=
 =?utf-8?B?enlmYkhhNWJtdmFwSkd5eXJUUjFMell3RDJWdXdNQStLWGlWaXA1QksrbXM3?=
 =?utf-8?B?UkxXV0dOTHROcVpVVHBqRzN6bk9Lb0sxVkhqK0NvQ2F2RUhOeXY0akVSSkRo?=
 =?utf-8?B?bXA1YkF4SzBFM09QdVp2UjV1UkhpbCtXWXovWmR1aXFLa1JBQnBQb2svMjRE?=
 =?utf-8?B?bTZHT0U3L1pScjBxaUdIRFNiUkpvZThNU0wxUG9sUm5uRGZqS1pjT0JseE9D?=
 =?utf-8?B?aDkxQWJHaWhKWmJqQTNIZi9WTnRWby9UdW9aalZPeDBMeGhJNjFtNXErSW5v?=
 =?utf-8?B?eHI0ZlE3Um9mUFFUWFY0RThJQldYRmQyMEc1RGJ4ZU1ZQUptOWJKRmZRVFRQ?=
 =?utf-8?B?ZnhUVlVaQWZ5Y3NqdEh0TGpWMnBvbFJTOVYyMEcrMmlXU0pzdWpXUHkzSmRB?=
 =?utf-8?B?WDBaZmhyRWNsRHZCSWkvUHVyY3dnNlF1bmVmY1orUWNKclRXam5rWVloZzZx?=
 =?utf-8?B?MHRkbHJLYTNWeHNGaUhlMG9Xdy9GbUs4MHc4QkdNTWFmMWlQMm1rMjkxbjR4?=
 =?utf-8?B?cDlyOFk3TTA0UEp6WTc5ZTB5Y2l4UnBrSWhHckMwL09YLzlieTc3VTF6MEhw?=
 =?utf-8?B?endPVEFwbkhCZ0E1TEMxai9zSW1ycDlwNlpuUEcrOHVhTjF0NUxJZWt6RzVH?=
 =?utf-8?B?c2NCS2h0bCtrcms4emErQ2dSQWt4VFJObk8xakh6OXk0elJBQ0VxaFpnNEpT?=
 =?utf-8?B?T3hKRnJ5cVpSSWEvb2pxV2xMQW1LNlozSDNQZWNmRXY3UzQ2N2lvMXBYUVhG?=
 =?utf-8?B?SUZpWkFVUnVrSzlSYkRGbmJmQlpnMkJiU0hyUE0vOGlTRlY5U3JDenZQSGpE?=
 =?utf-8?B?TTVjVGdYOFBYWllvRkxDVmUyTi9CWlVnL2xOSnJnYmlMSkFuY3VTSmU1NjAr?=
 =?utf-8?B?aVR3ZnpBa1hZbnNseDVpU2hPU3dZS3JybzJNUEwzT3lvSkhPNVlGVDBCL0hq?=
 =?utf-8?B?YzR0WlpDRUVsc25IeEdnbGI4VzU1YnAwdGxiWkdtN0hGN1ByT3FTWTREQVlI?=
 =?utf-8?B?SzQxTkhiZWlRaWlyZ25QTS9zYjFUVTFjb2RGc1pPVWtyeFNIQmxXcjE0cFZW?=
 =?utf-8?B?aHQwZXVWVnRRWDh6cWNoeG1XREhnN0s1R3pHY3N0VEZsS0w2ZStsM2Nxa21k?=
 =?utf-8?B?UjVFcmhvU1FqZ2ZKaGhCSWh2bTlnUnN4ZkdkdVp2WXZ5OWhBTzJabGpKSnUy?=
 =?utf-8?Q?44qy11PVMBo3JIHJaSTtlLeYuOkCXL9g48BoI+zpX1BUn?=
X-MS-Exchange-AntiSpam-MessageData-1: VuwIoPYmroJyaQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b561070c-bd6d-4f9f-cf6b-08df0e26eadf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:42.3054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJjX2JNJeuqV16wOs6Coll8FakZiJYJ2JyZGSBPiKtL1Sf1szagJ0gTUttve0u/Vr4KkTC43RaGy6nwNgeCanQ==
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

Add the page table mapping and unmapping API to the Virtual Memory
Manager, implementing a two-phase prepare/execute model suitable for
use both inside and outside the DMA fence signalling critical path.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: pass mutable GpuMm, replace window guards with scoped borrows]
[ecourtney: use current raw address helpers, drop stale expects]
[ecourtney: zero page table pages through one PRAMIN view]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs     |   1 +
 drivers/gpu/nova-core/mm/pagetable/map.rs | 342 ++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/vmm.rs           | 260 +++++++++++++++++++++--
 3 files changed, 584 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 99145846daed..ffc69fbdb067 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -8,6 +8,7 @@
 
 #![expect(dead_code)]
 
+pub(super) mod map;
 pub(super) mod ver2;
 pub(super) mod ver3;
 pub(super) mod walk;
diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
new file mode 100644
index 000000000000..21fc66e7c62c
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Page table mapping operations for NVIDIA GPUs.
+
+use core::marker::PhantomData;
+
+use kernel::{
+    gpu::buddy::{
+        AllocatedBlocks,
+        GpuBuddyAllocFlags,
+        GpuBuddyAllocMode, //
+    },
+    io::io_write,
+    prelude::*,
+    ptr::Alignment,
+    rbtree::{RBTree, RBTreeNode},
+    sizes::SZ_4K, //
+};
+
+use super::{
+    walk::{
+        PtWalkInner,
+        WalkPdeResult,
+        WalkResult, //
+    },
+    AperturePde,
+    AperturePte,
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
+        GpuMm,
+        Pfn,
+        Vfn,
+        VramAddress,
+        PAGE_SIZE, //
+    },
+    num::{
+        IntoSafeCast, //
+    },
+};
+
+/// A pre-allocated and zeroed page table page.
+///
+/// Created during the mapping prepare phase and consumed during the execute phase.
+/// Stored in an [`RBTree`] keyed by the PDE slot address (`install_addr`).
+pub(in crate::mm) struct PreparedPtPage {
+    /// The allocated and zeroed page table page.
+    pub(in crate::mm) alloc: Pin<KBox<AllocatedBlocks>>,
+    /// Page table level -- needed to determine if this PT page is for a dual PDE.
+    pub(in crate::mm) level: PageTableLevel,
+}
+
+/// Page table mapper.
+pub(in crate::mm) struct PtMapInner<M: MmuConfig> {
+    walker: PtWalkInner<M>,
+    pdb_addr: VramAddress,
+    _phantom: PhantomData<M>,
+}
+
+impl<M: MmuConfig> PtMapInner<M> {
+    /// Create a new [`PtMapInner`].
+    pub(super) fn new(pdb_addr: VramAddress) -> Self {
+        Self {
+            walker: PtWalkInner::<M>::new(pdb_addr),
+            pdb_addr,
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Allocate and zero a physical page table page.
+    fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<PreparedPtPage> {
+        let blocks = KBox::pin_init(
+            mm.buddy().alloc_blocks(
+                GpuBuddyAllocMode::Simple,
+                SZ_4K.into_safe_cast(),
+                Alignment::new::<SZ_4K>(),
+                GpuBuddyAllocFlags::default(),
+            ),
+            GFP_KERNEL,
+        )?;
+
+        let page_vram = VramAddress::from_raw(blocks.iter().next().ok_or(ENOMEM)?.offset());
+
+        // Zero via PRAMIN.
+        let window = mm
+            .pramin_mut()
+            .window_at::<[u64; PAGE_SIZE / 8]>(page_vram)?;
+        for i in 0..PAGE_SIZE / 8 {
+            io_write!(window.view(), [build: i], 0);
+        }
+
+        Ok(PreparedPtPage {
+            alloc: blocks,
+            level,
+        })
+    }
+
+    /// Ensure all intermediate page table pages exist for a single VFN.
+    ///
+    /// The mutable PRAMIN borrow ends before each allocation.
+    fn ensure_single_pte_path(
+        &self,
+        mm: &mut GpuMm<'_>,
+        vfn: Vfn,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+    ) -> Result {
+        let max_iter = 2 * M::PDE_LEVELS.len();
+
+        for _ in 0..max_iter {
+            let result = self
+                .walker
+                .walk_pde_levels(mm.pramin_mut(), vfn, |install_addr| {
+                    pt_pages.get(&install_addr).and_then(|p| {
+                        p.alloc
+                            .iter()
+                            .next()
+                            .map(|b| VramAddress::from_raw(b.offset()))
+                    })
+                })?;
+
+            match result {
+                WalkPdeResult::Complete { .. } => {
+                    return Ok(());
+                }
+                WalkPdeResult::Missing {
+                    install_addr,
+                    level,
+                } => {
+                    let page = Self::alloc_and_zero_page(mm, level)?;
+                    let node = RBTreeNode::new(install_addr, page, GFP_KERNEL)?;
+                    let old = pt_pages.insert(node);
+                    if old.is_some() {
+                        kernel::pr_warn_once!(
+                            "VMM: duplicate install_addr in pt_pages (internal consistency error)\n"
+                        );
+                        return Err(EIO);
+                    }
+                }
+            }
+        }
+
+        kernel::pr_warn!(
+            "VMM: ensure_pte_path: loop exhausted after {} iters (VFN {:?})\n",
+            max_iter,
+            vfn
+        );
+        Err(EIO)
+    }
+
+    /// Prepare page table resources for mapping `num_pages` pages starting at `vfn_start`.
+    ///
+    /// Reserves capacity in `page_table_allocs`, then walks the hierarchy
+    /// per-VFN to prepare pages for all missing PDEs.
+    pub(super) fn prepare_map(
+        &self,
+        mm: &mut GpuMm<'_>,
+        vfn_start: Vfn,
+        num_pages: usize,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+    ) -> Result {
+        // Pre-reserve so install_mappings() can use push_within_capacity (no alloc
+        // in fence signalling critical path).
+        let pt_upper_bound = M::pt_pages_upper_bound(num_pages);
+        page_table_allocs.reserve(pt_upper_bound, GFP_KERNEL)?;
+
+        // Walk the hierarchy per-VFN to prepare pages for all missing PDEs.
+        for i in 0..num_pages {
+            let i_u64: u64 = i.into_safe_cast();
+            let vfn = Vfn::new(vfn_start.raw() + i_u64);
+            self.ensure_single_pte_path(mm, vfn, pt_pages)?;
+        }
+        Ok(())
+    }
+
+    /// Install prepared PDEs and write PTEs, then flush TLB.
+    ///
+    /// Drains `pt_pages` and moves allocations into `page_table_allocs`.
+    pub(super) fn install_mappings(
+        &self,
+        mm: &mut GpuMm<'_>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        vfn_start: Vfn,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result {
+        {
+            let pramin = mm.pramin_mut();
+
+            // Drain prepared PT pages, install all pending PDEs.
+            let mut cursor = pt_pages.cursor_front_mut();
+            while let Some(c) = cursor {
+                let (next, node) = c.remove_current();
+                let (install_addr, page) = node.to_key_value();
+                let page_vram =
+                    VramAddress::from_raw(page.alloc.iter().next().ok_or(ENOMEM)?.offset());
+
+                if page.level == M::DUAL_PDE_LEVEL {
+                    let new_dpde = M::DualPde::new_small(Pfn::from(page_vram));
+                    new_dpde.write(pramin, install_addr)?;
+                } else {
+                    let new_pde = M::Pde::new(AperturePde::VideoMemory, Pfn::from(page_vram));
+                    new_pde.write(pramin, install_addr)?;
+                }
+
+                page_table_allocs
+                    .push_within_capacity(page.alloc)
+                    .map_err(|_| ENOMEM)?;
+
+                cursor = next;
+            }
+
+            // Write PTEs (all PDEs now installed in HW).
+            for (i, &pfn) in pfns.iter().enumerate() {
+                let i_u64: u64 = i.into_safe_cast();
+                let vfn = Vfn::new(vfn_start.raw() + i_u64);
+                let result = self.walker.walk_to_pte_lookup_with_window(pramin, vfn)?;
+
+                match result {
+                    WalkResult::Unmapped { pte_addr } | WalkResult::Mapped { pte_addr, .. } => {
+                        let pte = M::Pte::new(AperturePte::VideoMemory, pfn, writable);
+                        pte.write(pramin, pte_addr)?;
+                    }
+                    WalkResult::PageTableMissing => {
+                        kernel::pr_warn_once!("VMM: page table missing for VFN {vfn:?}\n");
+                        return Err(EIO);
+                    }
+                }
+            }
+        }
+
+        // Flush TLB.
+        mm.tlb().flush(self.pdb_addr)
+    }
+
+    /// Invalidate PTEs for a range and flush TLB.
+    pub(super) fn invalidate_ptes(
+        &self,
+        mm: &mut GpuMm<'_>,
+        vfn_start: Vfn,
+        num_pages: usize,
+    ) -> Result {
+        let invalid_pte = M::Pte::invalid();
+
+        {
+            let pramin = mm.pramin_mut();
+            for i in 0..num_pages {
+                let i_u64: u64 = i.into_safe_cast();
+                let vfn = Vfn::new(vfn_start.raw() + i_u64);
+                let result = self.walker.walk_to_pte_lookup_with_window(pramin, vfn)?;
+
+                match result {
+                    WalkResult::Mapped { pte_addr, .. } | WalkResult::Unmapped { pte_addr } => {
+                        invalid_pte.write(pramin, pte_addr)?;
+                    }
+                    WalkResult::PageTableMissing => {
+                        continue;
+                    }
+                }
+            }
+        }
+
+        mm.tlb().flush(self.pdb_addr)
+    }
+}
+
+macro_rules! pt_map_dispatch {
+    ($self:expr, $method:ident ( $($arg:expr),* $(,)? )) => {
+        match $self {
+            PtMap::V2(inner) => inner.$method($($arg),*),
+            PtMap::V3(inner) => inner.$method($($arg),*),
+        }
+    };
+}
+
+/// Page table mapper dispatch.
+pub(in crate::mm) enum PtMap {
+    /// MMU v2 (Turing/Ampere/Ada).
+    V2(PtMapInner<MmuV2>),
+    /// MMU v3 (Hopper+).
+    V3(PtMapInner<MmuV3>),
+}
+
+impl PtMap {
+    /// Create a new page table mapper for the given MMU version.
+    pub(in crate::mm) fn new(pdb_addr: VramAddress, version: MmuVersion) -> Self {
+        match version {
+            MmuVersion::V2 => Self::V2(PtMapInner::<MmuV2>::new(pdb_addr)),
+            MmuVersion::V3 => Self::V3(PtMapInner::<MmuV3>::new(pdb_addr)),
+        }
+    }
+
+    /// Prepare page table resources for a mapping.
+    pub(in crate::mm) fn prepare_map(
+        &self,
+        mm: &mut GpuMm<'_>,
+        vfn_start: Vfn,
+        num_pages: usize,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+    ) -> Result {
+        pt_map_dispatch!(
+            self,
+            prepare_map(mm, vfn_start, num_pages, page_table_allocs, pt_pages)
+        )
+    }
+
+    /// Install prepared PDEs and write PTEs, then flush TLB.
+    pub(in crate::mm) fn install_mappings(
+        &self,
+        mm: &mut GpuMm<'_>,
+        pt_pages: &mut RBTree<VramAddress, PreparedPtPage>,
+        page_table_allocs: &mut KVec<Pin<KBox<AllocatedBlocks>>>,
+        vfn_start: Vfn,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result {
+        pt_map_dispatch!(
+            self,
+            install_mappings(mm, pt_pages, page_table_allocs, vfn_start, pfns, writable)
+        )
+    }
+
+    /// Invalidate PTEs for a range and flush TLB.
+    pub(in crate::mm) fn invalidate_ptes(
+        &self,
+        mm: &mut GpuMm<'_>,
+        vfn_start: Vfn,
+        num_pages: usize,
+    ) -> Result {
+        pt_map_dispatch!(self, invalidate_ptes(mm, vfn_start, num_pages))
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/vmm.rs b/drivers/gpu/nova-core/mm/vmm.rs
index 0bcae29db4f2..411710d03f7a 100644
--- a/drivers/gpu/nova-core/mm/vmm.rs
+++ b/drivers/gpu/nova-core/mm/vmm.rs
@@ -3,21 +3,30 @@
 //! Virtual Memory Manager for NVIDIA GPU page table management.
 //!
 //! The [`Vmm`] provides high-level page mapping and unmapping operations for GPU
-//! virtual address spaces (Channels, BAR1, BAR2). It wraps the page table walker
-//! and handles TLB flushing after modifications.
+//! virtual address spaces (Channels, BAR1, BAR2).
 
 use kernel::{
     gpu::buddy::AllocatedBlocks,
     maple_tree::MapleTreeAlloc,
-    prelude::*, //
+    prelude::*,
+    rbtree::RBTree, //
 };
 
-use core::ops::Range;
+use core::{
+    cell::Cell,
+    ops::Range, //
+};
 
 use crate::{
     mm::{
         pagetable::{
-            walk::{PtWalk, WalkResult},
+            map::{
+                PtMap, //
+            },
+            walk::{
+                PtWalk,
+                WalkResult, //
+            },
             MmuVersion, //
         },
         GpuMm,
@@ -31,22 +40,108 @@
     },
 };
 
+/// Multi-page prepared mapping -- VA range allocated, ready for execute.
+///
+/// Produced by [`Vmm::prepare_map()`], consumed by [`Vmm::execute_map()`].
+/// The VA space allocation is tracked in the [`Vmm`]'s maple tree and freed
+/// on error or via [`Vmm::unmap_pages()`].
+///
+/// Dropping without calling [`Vmm::execute_map()`] logs a warning and leaks
+/// the VA range in the maple tree.
+pub(crate) struct PreparedMapping {
+    vfn_start: Vfn,
+    num_pages: usize,
+    /// Logs a warning if dropped without executing.
+    _drop_guard: MustExecuteGuard,
+}
+
+/// Result of a mapping operation -- tracks the active mapped range.
+///
+/// Returned by [`Vmm::execute_map()`] and [`Vmm::map_pages()`].
+/// Callers must call [`Vmm::unmap_pages()`] before dropping to invalidate
+/// PTEs and free the VA range. Dropping without unmapping logs a warning
+/// and leaks the VA range in the maple tree.
+pub(crate) struct MappedRange {
+    pub(super) vfn_start: Vfn,
+    pub(super) num_pages: usize,
+    /// Logs a warning if dropped without unmapping.
+    _drop_guard: MustUnmapGuard,
+}
+
+/// Guard that logs a warning if a [`PreparedMapping`] is dropped without
+/// being consumed by [`Vmm::execute_map()`].
+struct MustExecuteGuard {
+    armed: Cell<bool>,
+}
+
+impl MustExecuteGuard {
+    const fn new() -> Self {
+        Self {
+            armed: Cell::new(true),
+        }
+    }
+
+    fn disarm(&self) {
+        self.armed.set(false);
+    }
+}
+
+impl Drop for MustExecuteGuard {
+    fn drop(&mut self) {
+        if self.armed.get() {
+            kernel::pr_warn!("PreparedMapping dropped without calling execute_map()\n");
+        }
+    }
+}
+
+/// Guard that logs a warning if a [`MappedRange`] is dropped without
+/// calling [`Vmm::unmap_pages()`].
+struct MustUnmapGuard {
+    armed: Cell<bool>,
+}
+
+impl MustUnmapGuard {
+    const fn new() -> Self {
+        Self {
+            armed: Cell::new(true),
+        }
+    }
+
+    fn disarm(&self) {
+        self.armed.set(false);
+    }
+}
+
+impl Drop for MustUnmapGuard {
+    fn drop(&mut self) {
+        if self.armed.get() {
+            kernel::pr_warn!("MappedRange dropped without calling unmap_pages()\n");
+        }
+    }
+}
+
 /// Virtual Memory Manager for a GPU address space.
 ///
 /// Each [`Vmm`] instance manages a single address space identified by its Page
-/// Directory Base (`PDB`) address. The [`Vmm`] is used for Channel, BAR1 and
-/// BAR2 mappings.
+/// Directory Base (`PDB`) address. Used for Channel, BAR1 and BAR2 mappings.
 pub(crate) struct Vmm {
     /// Page Directory Base address for this address space.
     pdb_addr: VramAddress,
-    /// MMU version used for page table layout.
-    mmu_version: MmuVersion,
+    /// Page table walker for reading existing mappings.
+    pt_walk: PtWalk,
+    /// Page table mapper for prepare/execute operations.
+    pt_map: PtMap,
     /// Page table allocations required for mappings.
     page_table_allocs: KVec<Pin<KBox<AllocatedBlocks>>>,
     /// Maple tree allocator for virtual address range tracking.
     virt_alloc: Pin<KBox<MapleTreeAlloc<()>>>,
     /// Total number of pages in the virtual address space.
     va_pages: usize,
+    /// Prepared PT pages pending PDE installation, keyed by `install_addr`.
+    ///
+    /// Populated during prepare phase and drained in execute phase. Shared by all
+    /// pending maps, preventing races on the same PDE slot.
+    pt_pages: RBTree<VramAddress, super::pagetable::map::PreparedPtPage>,
 }
 
 impl Vmm {
@@ -64,20 +159,16 @@ pub(crate) fn new(
 
         Ok(Self {
             pdb_addr,
-            mmu_version,
+            pt_walk: PtWalk::new(pdb_addr, mmu_version),
+            pt_map: PtMap::new(pdb_addr, mmu_version),
             page_table_allocs: KVec::new(),
             virt_alloc,
             va_pages,
+            pt_pages: RBTree::new(),
         })
     }
 
     /// Allocate a contiguous virtual frame number range.
-    ///
-    /// # Arguments
-    ///
-    /// - `num_pages`: Number of pages to allocate.
-    /// - `va_range`: `None` = allocate anywhere, `Some(range)` = constrain allocation to the given
-    ///   range.
     fn alloc_vfn_range(&self, num_pages: usize, va_range: Option<Range<u64>>) -> Result<Vfn> {
         let page_size: u64 = PAGE_SIZE.into_safe_cast();
 
@@ -113,11 +204,142 @@ fn free_vfn(&self, vfn: Vfn) {
 
     /// Read the [`Pfn`] for a mapped [`Vfn`] if one is mapped.
     pub(super) fn read_mapping(&self, mm: &mut GpuMm<'_>, vfn: Vfn) -> Result<Option<Pfn>> {
-        let walker = PtWalk::new(self.pdb_addr, self.mmu_version);
-
-        match walker.walk_to_pte(mm, vfn)? {
+        match self.pt_walk.walk_to_pte(mm, vfn)? {
             WalkResult::Mapped { pfn, .. } => Ok(Some(pfn)),
             WalkResult::Unmapped { .. } | WalkResult::PageTableMissing => Ok(None),
         }
     }
+
+    /// Prepare resources for mapping `num_pages` pages.
+    ///
+    /// Allocates a contiguous VA range, then walks the hierarchy per-VFN to prepare pages
+    /// for all missing PDEs. Returns a [`PreparedMapping`] with the VA allocation.
+    ///
+    /// If `va_range` is not `None`, the VA range is constrained to the given range. Safe
+    /// to call outside the fence signalling critical path.
+    pub(crate) fn prepare_map(
+        &mut self,
+        mm: &mut GpuMm<'_>,
+        num_pages: usize,
+        va_range: Option<Range<u64>>,
+    ) -> Result<PreparedMapping> {
+        if num_pages == 0 {
+            return Err(EINVAL);
+        }
+
+        // Allocate contiguous VA range.
+        let vfn_start = self.alloc_vfn_range(num_pages, va_range)?;
+
+        if let Err(e) = self.pt_map.prepare_map(
+            mm,
+            vfn_start,
+            num_pages,
+            &mut self.page_table_allocs,
+            &mut self.pt_pages,
+        ) {
+            self.free_vfn(vfn_start);
+            return Err(e);
+        }
+
+        Ok(PreparedMapping {
+            vfn_start,
+            num_pages,
+            _drop_guard: MustExecuteGuard::new(),
+        })
+    }
+
+    /// Execute a prepared multi-page mapping.
+    ///
+    /// Installs all prepared PDEs and writes PTEs into the page table, then flushes TLB.
+    pub(crate) fn execute_map(
+        &mut self,
+        mm: &mut GpuMm<'_>,
+        prepared: PreparedMapping,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result<MappedRange> {
+        if pfns.len() != prepared.num_pages {
+            self.free_vfn(prepared.vfn_start);
+            return Err(EINVAL);
+        }
+
+        let PreparedMapping {
+            vfn_start,
+            num_pages,
+            _drop_guard,
+        } = prepared;
+        _drop_guard.disarm();
+
+        if let Err(e) = self.pt_map.install_mappings(
+            mm,
+            &mut self.pt_pages,
+            &mut self.page_table_allocs,
+            vfn_start,
+            pfns,
+            writable,
+        ) {
+            self.free_vfn(vfn_start);
+            return Err(e);
+        }
+
+        Ok(MappedRange {
+            vfn_start,
+            num_pages,
+            _drop_guard: MustUnmapGuard::new(),
+        })
+    }
+
+    /// Map pages doing prepare and execute in the same call.
+    ///
+    /// This is a convenience wrapper for callers outside the fence signalling critical
+    /// path (e.g., BAR mappings). For DRM usecases, [`Vmm::prepare_map()`] and
+    /// [`Vmm::execute_map()`] will be called separately.
+    pub(crate) fn map_pages(
+        &mut self,
+        mm: &mut GpuMm<'_>,
+        pfns: &[Pfn],
+        va_range: Option<Range<u64>>,
+        writable: bool,
+    ) -> Result<MappedRange> {
+        if pfns.is_empty() {
+            return Err(EINVAL);
+        }
+
+        // Check if provided VA range is sufficient (if provided).
+        if let Some(ref range) = va_range {
+            let required: u64 = pfns
+                .len()
+                .checked_mul(PAGE_SIZE)
+                .ok_or(EOVERFLOW)?
+                .into_safe_cast();
+            let available = range.end.checked_sub(range.start).ok_or(EINVAL)?;
+            if available < required {
+                return Err(EINVAL);
+            }
+        }
+
+        let prepared = self.prepare_map(mm, pfns.len(), va_range)?;
+        self.execute_map(mm, prepared, pfns, writable)
+    }
+
+    /// Unmap all pages in a [`MappedRange`] with a single TLB flush.
+    pub(crate) fn unmap_pages(&mut self, mm: &mut GpuMm<'_>, range: MappedRange) -> Result {
+        let result = self
+            .pt_map
+            .invalidate_ptes(mm, range.vfn_start, range.num_pages);
+
+        // TODO: Internal page table pages (PDE, PTE pages) are still kept around.
+        // This is by design as repeated maps/unmaps will be fast. As a future TODO,
+        // we can add a reclaimer here to reclaim if VRAM is short. For now, the PT
+        // pages are dropped once the `Vmm` is dropped.
+
+        // Free the VA range regardless of PTE invalidation success, so that the VA
+        // range is recovered even on failure (PTEs may be stale, but that is better
+        // than leaking both PTEs and VA range).
+        self.free_vfn(range.vfn_start);
+
+        // Unmap complete, safe to drop `MappedRange`.
+        range._drop_guard.disarm();
+        result
+    }
 }

-- 
2.55.0

