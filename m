Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56800CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A81810F5FB;
	Fri,  1 May 2026 20:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lcDJwZXS";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013004.outbound.protection.outlook.com
 [40.93.196.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC0210F627
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P84dK9jfgDN0hoWSmvNCTFnqiky1LYxaScyD9J70da8Zt8A3bv7HHBpZVKENYtdrww4sQfEz5aJsP3QMDGxDGA4HisbZSNaJiP9zVX3KgnE6zW9m8Jh9e0BmGOFJ1hyST4H3wzjtH60PpGc/F3leq8+3i+pemLXZ6p49bwaxESNzU7IrVsePvVz1Bm6NstCi7th2RqlizYRqUtlt2Hm8Bz6ysvVvs+ZMmrmgkdGjWkFh4Ko2tN0yKI7+SOUtOFXdmUiuk3INMnautA77/iWNaM7uCos+rQX/ZSpdc05yGZJJGUbsC02iT7LQQLhibk0e8z08BqPZGKTHui2G/bO5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LwlaBGokPzIs/y5INaKsNbjGEpGbuJiixxNCC61W8I=;
 b=EEldlUE3MkBTmPbzyOVDIE/XyAuJbVWmjRZuK5f2FAm5IKYkWlfZSU1RvIpTzr7YF5i4TIQ95pG1O1MTIRHHo6rrv9Veas3eyoU8/8H2UAt6Tpi4BT7rL0TZzyfX53VVXI3gl7U6nS1Ycm6wetyjuIXtHrqfi+95Z85wA5mbnExjxaNx4iFr0XT1Kx+CGrFC1/HsxGxFTCwUI2I7swPeN1d4iurQ8HtmKsX/TZGESIS3eEHoWiVz0W3zjZRw9BzkvAav8jRx0vJv9Z9e+ipfWAaVqAcH+WRTez5jNGKc6amGXX7ejAgP8QVwfPzK3hfQxqBczyGcN62dHP0euZRl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LwlaBGokPzIs/y5INaKsNbjGEpGbuJiixxNCC61W8I=;
 b=lcDJwZXSupZix/Uu5ImxAyo/2Ia6UtP12Uh2IpjOUeAa5z3BIyloXglgbtEzXj/5Hda4TvYsAMwMBrsnZg9iV82rQARANR0k6hAJgS+PHvcx4GlbQWWvJkZoZs29yTVx5Vj5si1b4QFFXnINDHVkHZpLfSOm1hKIC23jhep7eOaqWfjnQSl53FluGS9VTMoUCjrHxkQnvuOWtMDGVKJiH7/UheP81rLT2uZF0nzzZIBQCWZGFJB2gfapp4eRPQoH/1GQTxVZ/HR1aqmXPV3jZtyfnjCV230KVMDtKPV9UoxOQFtNeuciHlE3tflGRy5D+DojWKTxa+AeVtu6DbabWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 20:58:42 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 20:58:42 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 5/7] gpu: nova-core: add INTR_CTRL interrupt controller API
Date: Fri,  1 May 2026 16:58:23 -0400
Message-Id: <20260501205825.73614-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501205825.73614-1-joelagnelf@nvidia.com>
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 469ddcd9-b4d7-4548-3c49-08dea7c46d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wG0nN4RCXV0aAlNlhKMylx7XR05AC5gJm/CBvW1E1hVqdOaPsuYYaUJHTe7wFPsDoRfn6E+QJ3VXH2cgseR4OL5VAYXeUmKkzPEkt+qde9T5/jOayqYkT4OBU8pe+cuWloL8s9NmfIDhKEipHQQ5uyCs+XE62gnPFcZkD4wZjY2aFWYMJawZQTwG2gKag30cZIDVj2/6/J0hjd9M4FeSDLZ/OucD6eX4lLKTpB36wwTf2YCxNXzrCHTYPnB1s9SjHSUMn2q5M21PthNzP9RDwZwRxQiorCRkRsI5WE4KhM2E5BJErSaz4jJ+OSIV5jLWC49eGrinecZI09sUcpisomcsoGelt/p0HKUimWFDR09ZYkue13Ntb8+2T8FalmXpVVxc5o6pMAByOqwx1uCDQBwR6LBU/ue+PgwrKwiOdbs4lLi10mwlxVekhzCFDID5a/jgSwvO+LnuXllZBLl9fBkItCwe/vL2p9uSCU+xg+B+2FL42zjrqCPAT16aP43c58ThgOF1UhFkvRUQSNz86xgz9r1N9/GpH2dABnmiEm6hEo2utHn8DgEkN03G1GzDTfe9clepSOeyXHrXRTS1Q+pGBzltrcqMT4D50VwXeacsqCgCf9Qpg+gvqr4wc01ZI4tPBAJ1De7Am3DfFWRvHBRb7obyw6MKfIMRcUrfRE4ehjmIEUpc1MxjT2V8MFuW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYlqWOsIZBaBJ7PaJrJfpooKF9KJCoWFB2EL2eBcEoxCtmV9iHUh9CdEmfSo?=
 =?us-ascii?Q?y9yU5aN6ut6CjxcOHxgM7mINKJEKjdQ02BJ5QfwDYKcuI7Bxz8MxYfoR0scv?=
 =?us-ascii?Q?eyuHr0DiKestgtrtLSWN2gFBXXiswrdyyx6GUew+7JzqWiVuwG3TbGDob0Wt?=
 =?us-ascii?Q?RxuBszVpI/w6iHvcKPmlP9n+P3hcTFpQHWFR7vgsuc2L+YGpGbk9R5lWOMWY?=
 =?us-ascii?Q?oY7QZ/P7MN0/bOToZICtDUYgQHK+q/JQKIJ/v5ICwzfr29LJ/ryMkbkLdIoT?=
 =?us-ascii?Q?/2FAFJiyBf0sN3hXWdhXoPpoTUSs5WLWRew17zEvuU2NuhMNCSFSmo1pGAlf?=
 =?us-ascii?Q?QbqTN+XVBcZNjVP5y3YFNP7DfUMEUi5hyQcHZ0aFP/PV7AZVDzEuhb/vM8a6?=
 =?us-ascii?Q?FuAkOXQBRZuN75IDTVCgLPPnaR03ctVFiljp7Z8z/DBvgQ00CCG48dVxP43F?=
 =?us-ascii?Q?u4BBUVOWV1yyDjrb0lmBhlTa4ytMMCBg5XOxoOkzPr4bVpgH3wKF0laOO17n?=
 =?us-ascii?Q?/itPOqIEyyMg2xI+TRDgbnViYpogMov8BUh5COF1yuVpYqFMVGm/bOWamtTO?=
 =?us-ascii?Q?wa4SdpQhwD8WZoizoQhGfNsJw/Xbbuq1Fn6wRgaXGAOmuancJ5LpJ7RV0tjO?=
 =?us-ascii?Q?KjUboVbrbhgZz95Obqc7tnZjmxbDhZBiUyioIwi1LIgAZSIfdwnWzIht3xij?=
 =?us-ascii?Q?9S81Osd2Zuvo5FL0FnK5Pct3hBMecBA5E7mg8qA5Ku7HyLeHKl7iyRfpJLVk?=
 =?us-ascii?Q?ma24Lw6TwrAtqwqHRqkPoG7CLxjVtj+EldVw7bJnUlbPmNxqg27vVxXMvDBt?=
 =?us-ascii?Q?aVn7Rb00p3Psexn+81sM2GgzHI6sZIcAIPalX3dWIkQaauE62TP6f96DRNs0?=
 =?us-ascii?Q?isXaroMj3+sE66OdaU8K4yw9cZA8+ExuE59seIsedomlTkuPubKJQ6ZFurTr?=
 =?us-ascii?Q?HHSaScBjyy/fvk5d5f8rKZF/iJLQ0w9V1eixvt9dViWwFZsL2ny7KHX8f95z?=
 =?us-ascii?Q?g0UEzvxbuuD5Cn3qQYCp5rvsbBvJ9hpRy1jXK0wD8h2QE5dwsfts2VceNPm/?=
 =?us-ascii?Q?3GyfgHs/uSex4wrMrD3BwNDyy38lEYx35RfGahxxwtgS9yu4Z5cBTCiY3K51?=
 =?us-ascii?Q?2sruis3A6frG2uHjgeHZfOal44onvjqV4xrEDGAFs2PVLYX5hoI17MZ7eLx9?=
 =?us-ascii?Q?7o/ORG+1WLQkEESCmFImzaVmIYU2lkGMLK21TtDzdaKqYKfbB325GIT1YPQu?=
 =?us-ascii?Q?Y0CMNqoIdv45RCimwNGLOorDF5fl1pc6HBumDnbx+ygdcbJSogt/FDFlw9DK?=
 =?us-ascii?Q?NarMVeLeMV9Xb1fdZ0EOauXLAp9YAwtmHa6/94d2GK54hk0NZIs/t5ECbQEp?=
 =?us-ascii?Q?9xsm1MTOcT89YLPGC5DhaKUoGZHmbneH+BZNM3m3NQqpcBWYkr7toseqCl7+?=
 =?us-ascii?Q?BsnNX1X204Gs0UHUr3tGLLnsHopqBr7fc4afYl5jOY4qgfwhSo9xE1l/qE7Q?=
 =?us-ascii?Q?oeUxMsiJ8W7oLSXEkCrYofmhMNHsmTZXUBaWNw8GsCEuh/iDqNBtF+ulx50c?=
 =?us-ascii?Q?U1rQTE3Q7ZGylT78vSKICzKigy09/ZmkQYHEhlxtxrYlb/ioxs5W9cNTbONv?=
 =?us-ascii?Q?AnbcReBiLRgTYxYoD0cSAFZaAKZdLKdgXFKSLFNAkB2r62YB7T24zG4aN+AS?=
 =?us-ascii?Q?VYZXIcu5TUNW52DA+cmEKB7syjGMkKLMX5IJk5yRNK/NIJSFbWRcwp7y6LUs?=
 =?us-ascii?Q?kH1hIcMTgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469ddcd9-b4d7-4548-3c49-08dea7c46d2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:58:42.2171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPeokRTVgytLj7wLhZet1S1r955bO0g6uoUfzyIa8ujrcZ+tHYqDeqk9WRvan4NilgL/FppB7xixoONyXdoeow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

Create the irq/ module with a type-state INTR_CTRL interrupt
controller API. The IntrCtrl struct provides factory methods for Top
and Leaf objects that use a sealed State trait with Idle/Pending types
to enforce correct usage at compile time.

The type-state pattern ensures ack() is only callable after
read_pending() has cached the hardware state, preventing mismatched
masks at compile time.

The later CPU doorbell self-test will make use of it.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/irq.rs           |   2 +
 drivers/gpu/nova-core/irq/intr_ctrl.rs | 281 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     |   1 +
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/gpu/nova-core/irq/intr_ctrl.rs

diff --git a/drivers/gpu/nova-core/irq.rs b/drivers/gpu/nova-core/irq.rs
index 3a2a40519f11..01ae638bf494 100644
--- a/drivers/gpu/nova-core/irq.rs
+++ b/drivers/gpu/nova-core/irq.rs
@@ -10,6 +10,8 @@
     prelude::*,
 };
 
+mod intr_ctrl;
+
 pub(crate) fn alloc_vector(pdev: &pci::Device<Bound>) -> Result<pci::IrqVector<'_>> {
     let msi_types = IrqTypes::default().with(IrqType::Msi).with(IrqType::MsiX);
 
diff --git a/drivers/gpu/nova-core/irq/intr_ctrl.rs b/drivers/gpu/nova-core/irq/intr_ctrl.rs
new file mode 100644
index 000000000000..dde77cc1f42f
--- /dev/null
+++ b/drivers/gpu/nova-core/irq/intr_ctrl.rs
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! GPU interrupt controller support (INTR_CTRL).
+//!
+//! Each PCIe function (PF and each VF, also known as a GFID) has its own
+//! interrupt tree. In this module, we only interact with the PF tree.
+//! The VF interacts with its own tree (which appears as a PF tree to it).
+//!
+//! See `Documentation/gpu/nova/core/intr-ctrl.rst` for detailed documentation
+//! of the INTR_CTRL architecture.
+
+use kernel::{
+    io::{
+        register::Array,
+        Io, //
+    },
+    num::Bounded,
+};
+
+use crate::{driver::Bar0, gpu::Chipset, regs};
+
+/// Type alias for a leaf interrupt index, bounded to valid values 0-15.
+pub(super) type LeafIndex = Bounded<usize, 4>;
+
+// Type-state for `Top` and `Leaf`.
+//
+// `Top` follows Idle -> Unarmed -> Pending -> consumed (rearmed).
+// `Leaf` uses Idle -> Pending to catch.
+//
+// This catches issues at compile time where we perform an operation
+// on an object in the wrong state (example, rearming `Top` without reading
+// pending bits first).
+/// Sealed trait representing the interrupt controller state.
+pub(super) trait State: private::Sealed {}
+
+/// Idle state: TOP_EN may or may not be armed; no snapshot held.
+pub(super) struct Idle;
+impl State for Idle {}
+
+/// Unarmed state: TOP_EN was just cleared by this Top handle, snapshot not yet read.
+pub(super) struct Unarmed;
+impl State for Unarmed {}
+
+/// Pending state: interrupt mask has been read from hardware.
+pub(super) struct Pending {
+    mask: u32,
+}
+impl State for Pending {}
+
+mod private {
+    pub(in crate::irq) trait Sealed {}
+    impl Sealed for super::Idle {}
+    impl Sealed for super::Unarmed {}
+    impl Sealed for super::Pending {}
+}
+
+/// Interrupt controller for a single PCIe function's interrupt tree.
+#[derive(Clone)]
+pub(super) struct IntrCtrl {
+    subtree_mask: u8,
+}
+
+impl IntrCtrl {
+    /// Create an `IntrCtrl` configured for the given chipset's interrupt tree width.
+    pub(super) fn new(chipset: Chipset) -> Self {
+        // Each TOP bit covers 2 leaves; subtree_mask has one bit per subtree.
+        //   Pre-Hopper:  8 leaves / 2 = 4 subtrees -> 0x0f (bits [3:0])
+        //   Hopper+:    16 leaves / 2 = 8 subtrees -> 0xff (bits [7:0])
+        Self {
+            subtree_mask: if chipset.arch().is_pre_hopper() {
+                0xf
+            } else {
+                0xff
+            },
+        }
+    }
+
+    /// Return a [`Top`] handle in the [`Idle`] state for this controller.
+    pub(super) fn top(&self) -> Top<Idle> {
+        Top {
+            subtree_mask: self.subtree_mask,
+            state: Idle,
+        }
+    }
+
+    /// Return a [`Leaf`] handle in the [`Idle`] state for the given leaf index.
+    pub(super) fn leaf(&self, index: LeafIndex) -> Leaf<Idle> {
+        Leaf::from_index(index)
+    }
+
+    /// Trigger a CPU doorbell interrupt for the given MSI vector number.
+    pub(super) fn trigger(&self, bar: &Bar0, vector: u32) {
+        bar.write(regs::NV_VF_INTR_LEAF_TRIGGER, vector.into());
+    }
+
+    /// Drain any pending interrupts on this controller.
+    ///
+    /// Walks all enabled subtrees, reads each leaf's pending mask, and acks
+    /// any pending bits. Useful for clearing stale interrupt state, e.g.,
+    /// state leftover when GSP booted.
+    pub(super) fn drain(&self, bar: &Bar0) {
+        let top = self.top().unarm(bar).read_pending(bar);
+
+        for subtree in top.iter_subtrees() {
+            for leaf in subtree.iter_pending_leaves(self, bar) {
+                leaf.ack(bar);
+            }
+        }
+
+        top.rearm(bar);
+    }
+}
+
+/// Top-level interrupt controller view.
+pub(super) struct Top<S: State = Idle> {
+    subtree_mask: u8,
+    state: S,
+}
+
+impl Top<Idle> {
+    /// Arm the controller (write TOP_EN_SET). Use for one-shot initial
+    /// setup before any interrupts are expected. The ISR's normal
+    /// re-arm path goes through `unarm()` -> `read_pending()` ->
+    /// `Top<Pending>::rearm()` instead.
+    pub(super) fn arm(self, bar: &Bar0) {
+        bar.write(
+            regs::NV_VF_INTR_TOP_EN_SET,
+            u32::from(self.subtree_mask).into(),
+        );
+    }
+
+    /// Unarm the controller (write TOP_EN_CLEAR). MSI is edge-triggered,
+    /// so this stops the GPU from firing redundant MSI writes over PCIe
+    /// while the host drains the tree. Consumes self and transitions to
+    /// `Top<Unarmed>`, which can then `read_pending()`.
+    pub(super) fn unarm(self, bar: &Bar0) -> Top<Unarmed> {
+        bar.write(
+            regs::NV_VF_INTR_TOP_EN_CLEAR,
+            u32::from(self.subtree_mask).into(),
+        );
+        Top {
+            subtree_mask: self.subtree_mask,
+            state: Unarmed,
+        }
+    }
+}
+
+impl Top<Unarmed> {
+    /// Read the TOP register's pending bitmask. Consumes self and
+    /// returns a `Top<Pending>` carrying the snapshot.
+    pub(super) fn read_pending(self, bar: &Bar0) -> Top<Pending> {
+        let mask = bar.read(regs::NV_VF_INTR_TOP).into_raw();
+        Top {
+            subtree_mask: self.subtree_mask,
+            state: Pending { mask },
+        }
+    }
+}
+
+/// One subtree in the INTR_TOP pending mask (covers two adjacent leaf indices).
+#[derive(Clone, Copy)]
+pub(super) struct Subtree {
+    index: usize,
+}
+
+impl Subtree {
+    /// Yields the two [`Leaf`] slots covered by this subtree's TOP bit.
+    fn iter_leaves<'a>(
+        self,
+        ctrl: &'a IntrCtrl,
+    ) -> impl Iterator<Item = Leaf<Idle>> + 'a {
+        // Each subtree covers two adjacent leaf indices for all architectures.
+        (0..2usize).filter_map(move |offset| {
+            // self.index is 0-31 and offset is 0-1, so idx is at most 63.
+            let idx = self.index * 2 + offset;
+            LeafIndex::try_new(idx).map(|idx| ctrl.leaf(idx))
+        })
+    }
+
+    /// Like [`Self::iter_leaves`], but keeps only leaves with a non-zero pending mask.
+    pub(super) fn iter_pending_leaves<'a>(
+        self,
+        ctrl: &'a IntrCtrl,
+        bar: &'a Bar0,
+    ) -> impl Iterator<Item = Leaf<Pending>> + 'a {
+        self.iter_leaves(ctrl).filter_map(move |idle| {
+            let pending = idle.read_pending(bar);
+            (pending.mask() != 0).then_some(pending)
+        })
+    }
+}
+
+impl Top<Pending> {
+    /// Return the raw TOP pending bitmask snapshot.
+    pub(super) fn mask(&self) -> u32 {
+        self.state.mask
+    }
+
+    /// Iterate over all subtrees with a pending TOP bit set in the snapshot.
+    pub(super) fn iter_subtrees(&self) -> impl Iterator<Item = Subtree> + '_ {
+        (0..32usize)
+            .filter(move |&bit| self.state.mask & (1u32 << bit) != 0)
+            .map(|index| Subtree { index })
+    }
+
+    /// Re-arm the controller (write TOP_EN_SET). Consumes self so the
+    /// pending snapshot cannot be consulted or re-iterated afterwards.
+    pub(super) fn rearm(self, bar: &Bar0) {
+        bar.write(
+            regs::NV_VF_INTR_TOP_EN_SET,
+            u32::from(self.subtree_mask).into(),
+        );
+    }
+}
+
+/// Leaf interrupt controller view for one interrupt leaf.
+pub(super) struct Leaf<S: State = Idle> {
+    index: LeafIndex,
+    state: S,
+}
+
+impl<Left: State, Right: State> PartialEq<Leaf<Right>> for Leaf<Left> {
+    fn eq(&self, other: &Leaf<Right>) -> bool {
+        self.index == other.index
+    }
+}
+
+impl<S: State> Eq for Leaf<S> {}
+
+// All `try_at().unwrap()` calls below are safe: `LeafIndex` is `Bounded<usize, 4>`,
+// guaranteeing values 0-15, and all INTR_CTRL leaf register arrays have 16 elements.
+impl Leaf<Idle> {
+    /// Construct a [`Leaf`] handle for the given leaf index.
+    pub(super) fn from_index(index: LeafIndex) -> Self {
+        Leaf { index, state: Idle }
+    }
+
+    /// Enable the bits in `mask` in this leaf's EN_SET register.
+    pub(super) fn allow(&self, bar: &Bar0, mask: u32) {
+        bar.write(
+            regs::NV_VF_INTR_LEAF_EN_SET::try_at(self.index.get()).unwrap(),
+            mask.into(),
+        );
+    }
+
+    /// Disable the bits in `mask` in this leaf's EN_CLEAR register.
+    pub(super) fn block(&self, bar: &Bar0, mask: u32) {
+        bar.write(
+            regs::NV_VF_INTR_LEAF_EN_CLEAR::try_at(self.index.get()).unwrap(),
+            mask.into(),
+        );
+    }
+
+    /// Read this leaf's pending interrupt mask and transition to [`Pending`].
+    pub(super) fn read_pending(self, bar: &Bar0) -> Leaf<Pending> {
+        let mask = bar
+            .read(regs::NV_VF_INTR_LEAF::try_at(self.index.get()).unwrap())
+            .into_raw();
+        Leaf {
+            index: self.index,
+            state: Pending { mask },
+        }
+    }
+}
+
+impl Leaf<Pending> {
+    /// Return the raw pending interrupt bitmask read from hardware.
+    pub(super) fn mask(&self) -> u32 {
+        self.state.mask
+    }
+
+    /// Acknowledge all pending bits by writing the mask back to the leaf register.
+    pub(super) fn ack(&self, bar: &Bar0) {
+        if self.state.mask != 0 {
+            bar.write(
+                regs::NV_VF_INTR_LEAF::try_at(self.index.get()).unwrap(),
+                self.state.mask.into(),
+            );
+        }
+    }
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 837aa2d36a0e..6d0e4b2f53c7 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -19,6 +19,7 @@
 mod firmware;
 mod gpu;
 mod gsp;
+#[expect(dead_code)]
 mod irq;
 #[macro_use]
 mod num;
-- 
2.34.1

