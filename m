Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F0CCD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B11710F626;
	Fri,  1 May 2026 20:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JtEddoBD";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE61D10F627
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2Xg3rfeLbFrw0HihoDejubM+5lAVJCLE0f/invU39l9+P5VAPuwSgvqELfY4avOfzumuh3bfd7HMg2IIXp6V3cZ1+LeH07HnGVyYAS8Pw2VymD8GheS3IVsrqasonhzMuC1Ssn9AO56l928TlxoEsUaKdKrCDBSrOZT9LebJqtIusjh6lOx49XaYd3PUstI0z2cpYQ04LzKLJJs/U/0lkuozebyMI5pWkHMDDY5yZGyhzwT+L0vW9amS/b/VQsBjiS/vctkl1MYhz4t70W7S6Dt+T9x3kAXpknzPb0vXI3q/zb8EezuSfE0jOLlfCGVL9wNWRUdVgY5NFmyvQHtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVBI+4VSp5YEwqsKxbsVHZ0JGOtowztY3yhpUn1ULjU=;
 b=ZseHTwgDi4NlIfIRCoM6on9njWFOM7t+ZH55IjavEnmLXHB0qrajF5eo4xQtNlFPz40GbV8qbbL4mV1Gwph2QgyTckQItZthbiY8g+kylqvWD7nRFch18hTn+V60XNfFGQbDxD7AoGhYSuaJvJw0gSrF5x6sZk6PTNQRnaj19G2ljFexpME0oYWzUQYnrSQwhmvlSW2G9+L3rdhqlIrhayuQJKlf3+KkEBnYbAYOkPuftNDbMJZnaTvpq3N7gjngtm3rLDjNsTmsm1wZHsUHeQtY7Gopqo38kUGmf2LPKFGl2mdFd6klqg9cz+5Q8CxmHKPDFnLaUbx8q3uE8FPd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVBI+4VSp5YEwqsKxbsVHZ0JGOtowztY3yhpUn1ULjU=;
 b=JtEddoBDyB0DJAy1PzDi+UzBOVsSzO6UQSCYWm848W9kn56j8bb/GogbxAWhA7TYAjw6lvJ/cnKd0fbRm2S4AX/o1lPQdFJ69ZT38oXL1DP1t577pvz24zK+GFA4Mn6JgmJKm8VyvRc1ZPD8gApzUCNjoX7xUsV7UwowuIk6ayN64deGvpIqUu/vzEYPwd7D7iEpr0ZhuFmcoEW8frxomUDRTXcn8YySukPG8Mqu2icD15yMyzAc4t+iSUk6KHbRd6MvpIiFA4aJyF3Py2aGRK2+UsmUsi21mldH3n0u5YkXnNj95knZq7MxLI80dYiZYi+3+NGXsq4mLyWABizcvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Fri, 1 May
 2026 20:58:44 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 20:58:44 +0000
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
Subject: [PATCH v1 6/7] gpu: nova-core: add CPU doorbell IRQ self-test
Date: Fri,  1 May 2026 16:58:24 -0400
Message-Id: <20260501205825.73614-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501205825.73614-1-joelagnelf@nvidia.com>
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 02868934-a825-4b16-bc80-08dea7c46e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: D6ArKFjfQfYSI/N6qoHZ1RKU1XQOGo9jYQwjJQZMeY09hzwUYquvLpQskhYxD23ZerSn4nN5NoXRjaAU7J4hYQHIBw/ZeqUXM6SHXrOsQpKEynCxVIhQ/eBxtUwNX5Ea9DmEL3rKKgktvXbRBWITh4rBlRo0WI4R27Giuzjc9KSXZn8aQ5VtGLBaPJi1Vtp90YX5G+KJn5IgmOFhKgkPZPD5UaWpNnjZ0E9DI5cKecT2wMtzge/kYVHUwK3amY3XParUUT9e/XRUv0Bs34ycpHkhBSKCYgS8ll9MGdBygOF2q8XgfdW5T3zauctDowncaQnT2NvzzLodKlRKobl/lMinahVhKD8BxqnHy2pAfTpt7K9q7pA/Z8cWrKlCiObtTlScBK6/aTu1/BhYmxL5yS4H3Ixktg7ah0QeV3AXADVoHCKMeaJIqyeyKAn1pcaAEx6e2/42upE3bJHyGkBAspNgnX+YzSNr6w/Fk3N/taQEfDytDFXwXKWXOgq+u0rmTFiuJyTEu8WKb8a1PLE7qxk7HX9V91dMTXNDRiQ4w5plYv9pibsXYCi0+P84HG8kO8hygd2pTiqyoUUHit9HsSkV+ttpSBzQTHQ+ruOXi49SL2M+8BTFzoj+w9rjCH4t7KOonyrDsgqgTSiStGZ0dsFxjx6/mCdxVjDPFSf6m7MuVhBuF6LxyRs/R4r0+lJe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6eE3KXtgJQFXyf16mSomgK0HsuH/Su7IimChQBq7N3+PVJZk1KrdYgP1tQG?=
 =?us-ascii?Q?zJ/1IOjem9jzD/m59bHZSbUy2VBmY/r4NHu1sV9BR3D8dxhXRdcvySCxUD8d?=
 =?us-ascii?Q?QtK3dNaAqPu/dotsnGIfAD8IbL2oTWG7VUuXIARGftHMNnI1vX+JmHKpei++?=
 =?us-ascii?Q?9F0FWWC0zM3c9CMKrKkwmozZ36HXWgu0JwuXq6gN5jRxUzlODjpN7cwv6g5z?=
 =?us-ascii?Q?PscheEAoPJBh1hTaMWP/mGck3GlcwqM0+pwxYTAuUbjB+mAPVmL1derFdkK3?=
 =?us-ascii?Q?ogOxMSOEEbCSFg+HWlafXOW8O2nLKxApAosGoWwfraLR4+zxkf7nMdmw1kYZ?=
 =?us-ascii?Q?C3AZMxjanHJkDmnhaZzekajVd+Ddd1h4n32eO6RnvXSWZ99av1M7Hv5ZfWax?=
 =?us-ascii?Q?gbmnY2eTVvwtx3vxMX3tn+qh1+kXysRGdj663+jr1TiUdBz1UnKEFnis+5SL?=
 =?us-ascii?Q?HPQRs2mVFb3l2kirO/lhI6Gptza2T4UufTejTBq8NtdDHheLgDSG3WmsE6MM?=
 =?us-ascii?Q?2ud6aPm7Ryj1UZjcdngTMD7oTczdDzQtA4rMBPnkP9+eIRi1REUlNwhnfZZc?=
 =?us-ascii?Q?u3erJ5aEjj0f1EwuvZCA9g7oOxit8sQNXW5WqzGeFLxK3LsffRk/TM7PsQW+?=
 =?us-ascii?Q?/9GSGO8TrThqnLPDsBmTMDBPAdf304yqs2MaqjKzIhwOqvhrM9ejyIt1TpuZ?=
 =?us-ascii?Q?y/RFn7WtKvYNictMlJdEWZLwYuVPnAJxqkYK/OHx4I2qhzI0wDl176ps2cta?=
 =?us-ascii?Q?qhcx8K2cqMPmMdHGDa15wgQbOxSPCJHe7QIovAP+f/fuOZPlCPRGb1gWtj03?=
 =?us-ascii?Q?HPT4eEvyRb8gdgd5s2PSak0LvwVm3T0n5tWmj+WIeuDqmn8NsEFsfN27kxED?=
 =?us-ascii?Q?jJh4HCkSs8ihEmZvLPSi2u13C7BQXw0R54Vb5govbu/i60UMunHpGPpUYCV+?=
 =?us-ascii?Q?ywuyFkiIuXvdl6fwCKaboHTTf4a/8v3P4NKciNYq/2G0zQ4gYpAHYcrf5loS?=
 =?us-ascii?Q?INQN5KAGl2+sqmqxX5MZwDg/us9dEQ1CjytT00v6ftPQfCQvpcCcxOdRAxSR?=
 =?us-ascii?Q?dq3g2gLl50MN+aCE0Iq3pN1ms6atYgq+DzH8HKLTXcIQrCos1hAmyjoz9aCH?=
 =?us-ascii?Q?ZTBXIp/vCnp98fqHKcOe5xOc4acHk6ezDjCVsqXeXWcihVey8q7qB151LGQD?=
 =?us-ascii?Q?MPDAfNT4GieUIaRYwOgwIB1hOGNaqAdLhE5/BGh35o3dlhNoolHhlCINPxP8?=
 =?us-ascii?Q?/bZIl9Vx+UDRDqeJhMw2JqMM1bkmhxl+nii6WUYbZyJ5lGaD8bLPhHtFgZdR?=
 =?us-ascii?Q?An8MItVXghudYSnV7ubrYcRlAJeY7ExfnaClSL5uJE3/USXhvzboAvudz2pk?=
 =?us-ascii?Q?g0T6zTRlPS5XbOMhq0QnfmYh9CU6oI6TjN1PeXxxsy5OJcsdR/nLTgmxTwro?=
 =?us-ascii?Q?M+qcJ+wbIyPBri6W52A4a8abMRs9gAFKahSoyWSySkjWhn5cr9CqN6EIR3p9?=
 =?us-ascii?Q?xmhD6D/3YH3Nxdr/+1SX45S9ZdWfFzZ5MT3c4Jimvr04J3rpBNRLdXzoe221?=
 =?us-ascii?Q?8wJ1wB5+AZCSgQ6jB0S2eaEC8W40O/ZgKE7/OMF2PtQsjc+IY7YA9mApp9Rw?=
 =?us-ascii?Q?Ri7wXLC/kSVpHGYPHUsO29hC6Zau4z2uE0ah6SAhZWemFXap6hMCCERtFUUg?=
 =?us-ascii?Q?RnhI+FwAOZV7ZEGpX9sYuC0jJXm+SQX1gH1Kji7NebQr0/0KRQFh9jq6XxRf?=
 =?us-ascii?Q?/Busf2D8Uw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02868934-a825-4b16-bc80-08dea7c46e4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:58:44.0346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNY4vx5kjMq/Ehvn4vfMYBBVgvYU3CSJyEYqTBQfGdVfDeqYK0gOstJNMMqAOQrRsDp6KRAx5B23E2+3nY4eow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
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

Add a CPU doorbell interrupt self-test that runs during probe, after GSP
boot. The test validates the full MSI interrupt path from GPU through
PCIe to the CPU interrupt handler.

Tested with qemu + GPU passthrough on GA102, with dmesg as follows:
  NovaCore 0000:00:06.0: CPU doorbell self-test: PASS (irq_count=1)

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig              |  13 ++
 drivers/gpu/nova-core/gpu.rs               |   8 +
 drivers/gpu/nova-core/irq.rs               |   2 +
 drivers/gpu/nova-core/irq/doorbell_test.rs | 203 +++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs         |   2 +-
 5 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/nova-core/irq/doorbell_test.rs

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index d8456f8eaa05..e2c8a090c7ff 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -15,3 +15,16 @@ config NOVA_CORE
 	  This driver is work in progress and may not be functional.
 
 	  If M is selected, the module will be called nova_core.
+
+config NOVA_CORE_IRQ_SELFTEST
+	bool "Nova IRQ self-test during probe"
+	depends on NOVA_CORE
+	help
+	  Enable the CPU doorbell IRQ self-test that runs during nova-core
+	  probe. The test triggers vector 129 (CPU doorbell) and verifies
+	  the interrupt is received through the INTR_CTRL interrupt tree.
+
+	  This validates the full MSI interrupt path from GPU through PCIe
+	  to the CPU interrupt handler.
+
+	  If unsure, say N.
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 3b45bce6738b..f6e02007ef8f 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -305,6 +305,14 @@ pub(crate) fn new<'a>(
             // Allocate a PCI interrupt vector.
             _: {
                 let _irq_vector = irq::alloc_vector(pdev)?;
+
+                #[cfg(CONFIG_NOVA_CORE_IRQ_SELFTEST)]
+                irq::doorbell_test::run_selftest(
+                    pdev,
+                    &devres_bar,
+                    spec.chipset,
+                    _irq_vector,
+                )?;
             },
 
             bar: devres_bar,
diff --git a/drivers/gpu/nova-core/irq.rs b/drivers/gpu/nova-core/irq.rs
index 01ae638bf494..f4ed4593e795 100644
--- a/drivers/gpu/nova-core/irq.rs
+++ b/drivers/gpu/nova-core/irq.rs
@@ -10,6 +10,8 @@
     prelude::*,
 };
 
+#[cfg(CONFIG_NOVA_CORE_IRQ_SELFTEST)]
+pub(crate) mod doorbell_test;
 mod intr_ctrl;
 
 pub(crate) fn alloc_vector(pdev: &pci::Device<Bound>) -> Result<pci::IrqVector<'_>> {
diff --git a/drivers/gpu/nova-core/irq/doorbell_test.rs b/drivers/gpu/nova-core/irq/doorbell_test.rs
new file mode 100644
index 000000000000..fb4e039ac032
--- /dev/null
+++ b/drivers/gpu/nova-core/irq/doorbell_test.rs
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    device::{Bound, Device},
+    devres::Devres,
+    irq, pci,
+    prelude::*,
+    sync::{
+        atomic::{
+            Atomic,
+            Relaxed, //
+        },
+        Arc, Completion,
+    },
+    time,
+};
+
+use super::intr_ctrl::{
+    IntrCtrl,
+    Leaf,
+    LeafIndex, //
+};
+use crate::{
+    driver::Bar0,
+    gpu::Chipset, //
+};
+
+// The following are constant across all architectures.
+
+/// CPU doorbell vector.
+const DOORBELL_VECTOR: u32 = 129;
+
+/// Leaf index for the doorbell vector: 129 / 32 = 4.
+const DOORBELL_LEAF: usize = 4;
+
+/// Bit within the leaf: 129 % 32 = 1.
+const DOORBELL_BIT: u32 = 1 << 1;
+
+/// IRQ handler for the CPU doorbell self-test.
+///
+/// Performs a minimal interrupt-tree drain cycle:
+/// unarm -> read TOP -> iterate leaves -> ack -> rearm.
+/// Signals completion and increments the interrupt counter on each handled interrupt.
+/// Records the leaf index and pending mask observed by the handler for verification.
+#[pin_data]
+struct DoorbellTestHandler {
+    bar: Arc<Devres<Bar0>>,
+    intr_ctrl: IntrCtrl,
+    #[pin]
+    completion: Completion,
+    /// Used to confirm the number of interrupts handled.
+    irq_count: Atomic<u32>,
+    /// Used to confirm the mask observed on the doorbell leaf (leaf 4).
+    doorbell_leaf_mask: Atomic<u32>,
+}
+
+impl irq::Handler for DoorbellTestHandler {
+    fn handle(&self, dev: &Device<Bound>) -> irq::IrqReturn {
+        let Ok(bar) = self.bar.access(dev) else {
+            return irq::IrqReturn::None;
+        };
+
+        let top = self.intr_ctrl.top().unarm(bar).read_pending(bar);
+
+        if top.mask() == 0 {
+            top.rearm(bar);
+            return irq::IrqReturn::None;
+        }
+
+        // Record the doorbell leaf mask for later verification.
+        let doorbell_leaf = Leaf::from_index(LeafIndex::new::<DOORBELL_LEAF>());
+
+        for subtree in top.iter_subtrees() {
+            for leaf in subtree.iter_pending_leaves(&self.intr_ctrl, bar) {
+                if leaf == doorbell_leaf {
+                    self.doorbell_leaf_mask.store(leaf.mask(), Relaxed);
+                }
+                leaf.ack(bar);
+            }
+        }
+
+        top.rearm(bar);
+
+        // Increment the interrupt counter and signal the completion.
+        self.irq_count.fetch_add(1, Relaxed);
+        self.completion.complete_all();
+
+        irq::IrqReturn::Handled
+    }
+}
+
+/// Run the CPU doorbell IRQ self-test.
+///
+/// Registers an IRQ handler, triggers CPU doorbell vector, and verifies the
+/// interrupt is received through the interrupt tree. This validates the full MSI path:
+/// GPU -> PCIe -> CPU -> handler.
+pub(crate) fn run_selftest(
+    pdev: &pci::Device<Bound>,
+    bar_devres: &Arc<Devres<Bar0>>,
+    chipset: Chipset,
+    irq_vector: pci::IrqVector<'_>,
+) -> Result {
+    let bar = bar_devres.access(pdev.as_ref())?;
+    let intr_ctrl = IntrCtrl::new(chipset);
+
+    // Clear stale pending bits before enabling the doorbell.
+    intr_ctrl.drain(bar);
+
+    let handler_init = try_pin_init!(DoorbellTestHandler {
+        bar: bar_devres.clone(),
+        intr_ctrl,
+        completion <- Completion::new(),
+        irq_count: Atomic::new(0),
+        doorbell_leaf_mask: Atomic::new(0),
+    }? Error);
+
+    let reg = Arc::pin_init(
+        pdev.request_irq(
+            irq_vector,
+            irq::Flags::TRIGGER_NONE,
+            c"nova-core",
+            handler_init,
+        ),
+        GFP_KERNEL,
+    )?;
+
+    let handler = reg.handler();
+
+    // Allow doorbell leaf.
+    let doorbell_leaf_idx = LeafIndex::new::<DOORBELL_LEAF>();
+    handler
+        .intr_ctrl
+        .leaf(doorbell_leaf_idx)
+        .allow(bar, DOORBELL_BIT);
+
+    // The doorbell bit must be clear before triggering, otherwise the test
+    // cannot prove that the IRQ came from the trigger below.
+    let pre_mask = handler
+        .intr_ctrl
+        .leaf(doorbell_leaf_idx)
+        .read_pending(bar)
+        .mask();
+    if pre_mask & DOORBELL_BIT != 0 {
+        handler
+            .intr_ctrl
+            .leaf(doorbell_leaf_idx)
+            .block(bar, DOORBELL_BIT);
+        let _ = handler.intr_ctrl.top().unarm(bar);
+        dev_warn!(
+            pdev.as_ref(),
+            "CPU doorbell self-test: FAIL (doorbell bit already pending, leaf[{}] mask={:#x})\n",
+            DOORBELL_LEAF,
+            pre_mask,
+        );
+        return Err(EIO);
+    }
+
+    // Arm the INTR_CTRL top level to enable MSI generation.
+    handler.intr_ctrl.top().arm(bar);
+
+    // Trigger the CPU doorbell interrupt.
+    handler.intr_ctrl.trigger(bar, DOORBELL_VECTOR);
+
+    // Wait up to 1 second for the interrupt handler to fire.
+    let completed = handler
+        .completion
+        .wait_for_completion_timeout(time::msecs_to_jiffies(1000));
+
+    let count = handler.irq_count.load(Relaxed);
+    let leaf_mask = handler.doorbell_leaf_mask.load(Relaxed);
+
+    // Block the doorbell leaf after the test.
+    handler
+        .intr_ctrl
+        .leaf(doorbell_leaf_idx)
+        .block(bar, DOORBELL_BIT);
+    let _ = handler.intr_ctrl.top().unarm(bar);
+
+    // Verify that the doorbell IRQ fired.
+    let doorbell_bit_seen = leaf_mask & DOORBELL_BIT != 0;
+    let pass = completed && count == 1 && doorbell_bit_seen;
+
+    if pass {
+        dev_info!(
+            pdev.as_ref(),
+            "CPU doorbell self-test: PASS (irq_count={}, leaf[{}] mask={:#x})\n",
+            count,
+            DOORBELL_LEAF,
+            leaf_mask,
+        );
+    } else {
+        dev_warn!(
+            pdev.as_ref(),
+            "CPU doorbell self-test: FAIL (completed={}, irq_count={}, leaf[{}] mask={:#x})\n",
+            completed,
+            count,
+            DOORBELL_LEAF,
+            leaf_mask,
+        );
+    }
+
+    Ok(())
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 6d0e4b2f53c7..5fce7068db03 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -19,7 +19,7 @@
 mod firmware;
 mod gpu;
 mod gsp;
-#[expect(dead_code)]
+#[cfg_attr(not(CONFIG_NOVA_CORE_IRQ_SELFTEST), expect(dead_code))]
 mod irq;
 #[macro_use]
 mod num;
-- 
2.34.1

