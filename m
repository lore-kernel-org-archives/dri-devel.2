Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DDDCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600F710E985;
	Mon, 18 May 2026 18:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TO11GI2c";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 506DE10E999
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOtQOOG3CKTeyKb2j4UbPbCMZajEGAX0cb9Asrq+vvo2mcj68FP65Xm0E18Uh9cl1UEh67xQ3VT/z6vGqyLlKQI2um1rVVr2+NX70azKMJdRDspl5O3tWHF++IVdoiAhx/hgQbcOk+IA/OBZn3+wsN5T33oKLSFuwmBk7lE39A1SZlNxcsCGWLzqP63AOsgklFKEENOajQJjwSWiwjUrWpoAvDpD7yBu6uIxv/Dmn+p1A4DAhSbG5HhjW5BZacJMWEdvak3rqKPyzzQCd80GDQyJbvHEa154wx+6Q5tvBxlZknhg86XYVK7ULfabaWUDBcjrXLpYhSa0OKeUDlEhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Id9s1aMBy2OHBhcv9XUsi/3IQrb67NnqS06G3BGUco=;
 b=Si5YFUSXkJXcRcpVhEfdaHFzVs/mAnLjZIp0heUax/AHtKE0nxDV3iVeEnYI3ZBws85VQ2yKHnlQBdknkJrNVhMWKdm8zQK/XHGZpxdZazVb+GnrjfgQCkfERGpk8SRmBmUgJVGSU+3P+GRks+sDw+yvDv0zQBJwmBj14wZlumFS+mmjNHqHNdqBdfx6tm8/UsYwPbXUXWjZ+I3wrRvZuozjmjUwxAS07U+ngISHE8SZzm5FAbkL5oHV8dwTEQkNVH3UqWrWKBbpTP4VVbaYXoa1vX+iIO5Mtuw6HlNbNXp2mmdlilLTeOaAB7/3HNnwT6KA4nYRbYyUwC8PDhRoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Id9s1aMBy2OHBhcv9XUsi/3IQrb67NnqS06G3BGUco=;
 b=TO11GI2c7kfvPhWzyujGFUl4CQGPaAFc+jSrUUX7xT/MSZwjyR5gS4oEgR0xwZARWwGqjMZZsZ20BqritEzwM0fVvAk0n4gl/y7JYYIAf1hkq82vIjKK8C9BNe9hNZQ41XwYd7HfYqaJKn6vyuw28tML82WzA5wnFGBmpDmS6r7aZG1R2v3DuWkFykkMXlUnl6gcCd3cwcoyrZuBiUoRJZ2enxvoAyBm8ePQIdRlw6LUwtZdKyr03+31d8FyRgiSbxHF6kGHrfuo0rr1nHagsj/K6ESzwt0AI+xGWqn1eSIWfRAZ8blvMFdYSlzBQztrg3Rc3DrPCOYzd9wiqt8VYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:11:54 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:54 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 15/16] gpu: nova-core: mm: Add BAR1 user interface
Date: Mon, 18 May 2026 14:11:24 -0400
Message-Id: <20260518181126.2493572-16-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0322.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 6177a3c8-3037-4ead-1436-08deb508f034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: LX2XwuW6jnziYl2Qy9dWDsIPROhhLTh/1CxrmR3Zj189xWKFr7P9153AHd2cXBfh5UsuCa0Aa3FJ8dj7FKNWNXGv6u7tU6+D5R8CTUDCEOLX1W26uyknt6PazUCoNTW1K7ZccdFXoyXH8Q7UFsJZsOw6TV5bm7o/Ksz2rpublcSRLKQo7BKGIr825VKaNlxf0shhITCgFEu9uLXSjkPwRCIhn5lUOL/hAV16QqsV/1gMA3Kx78oKP/IHQnhJUPTx3lMlWHVjuNaOwwtLn7qEuHhcpEFR6+v0L3T7S9O7NrkOT4Mm3fBTzXsJpDobQzL4A3l8JWA8fHMqIbAWuQs5x4gGov3VomY6gs1QG87lEapCHtcwNR1oXxOP25jBhhhBV9mSpdT9nbh+uoQS1d3bHu2fBfaExclxk9azri9xTG/dqLvqy43K/2A+u5Fo1VPouFUTJ0BUzmBau0/Un7+0oLBOJdDRF9+FAoPIB58BOz13rcxteTVohSSP5UwIVgzOsLXXEsYGLOoxoLu/J0T461dMoUQLIF0U2GCMgxYjQU6l2szI5HTr8EATC5wQtB3Wv7rP+fW37jhUPu99V9J1vwa0AkgSXsIXFaA8S8KqqEAo1iY6EB3UypUHqxTBPfnfL8Va+nu1G8+n0y9jow6XMP4r0Vqg3jQrSeb/h0lfmIOW8LrJ6z/KGGcWaKesvYyP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVLrZK76hlk8tuditqulCzOREe3RXI1Ua2G67FWifmdnPANLRZa0KvLKXPjB?=
 =?us-ascii?Q?wL1A9FZgaJ3P5q9FcrOAmv42t+A25Kc2n48TYNNm1wa//l4Fkvwnth1g5cKc?=
 =?us-ascii?Q?WJLJmilAeaaFEWjNBz3DGA23+tK9DtCMMRI9YwrOKhLDmYlRznYN9Qv3TN/v?=
 =?us-ascii?Q?G2qXBjjvcRkS1MCz3ByP0RALVgDh9AHP+WcMzZ/IblSpb7XOE5Ppjj1jhs77?=
 =?us-ascii?Q?K1xSfwknHVz0vBZqx8hqSWZB0vtFnJINsSIMRaAhcMCPNIznwC9Wy5OX+rYs?=
 =?us-ascii?Q?6neEpjRecKoSE5cU0dsHs/lnoMz9HZWK7PUOeqnJIcJ+SStVRrh40FzUN5DO?=
 =?us-ascii?Q?ooWqlGdpS0yvwMfVAXPF6blsOMQADDEO4ye9g/aW3luRefBSIfm+2WxSU97P?=
 =?us-ascii?Q?5feyNf1qUR/U/hC8jtK0/rnq04O7LS+8HQD4kztAdqtnNuclOkBxvFormNn2?=
 =?us-ascii?Q?TUcIJZPfMF+MkB/BemqfeqZIwivwPE59MOmh9cqKEPsAa7xNXtodPHhpoOuM?=
 =?us-ascii?Q?doI+R2bT+geX9fvdcekiUpVGKTKz+mpFMp8l5bvkgooS+KcGN4ZqpK/br7gd?=
 =?us-ascii?Q?Fogfm5l85HfrMOKvhFJBhErHMT+DB+eq92ITgLJCgXGzvhx8PmqTLuBpXG02?=
 =?us-ascii?Q?7BG8Uxn+JzdEnMzdbnYKN/l8JkM9/sUfJxuEHhpQegoj1imxoQ+QDAzO5xJp?=
 =?us-ascii?Q?oHlRGwPUxhYzx09fvJmBzckHSY3jBhIIyQSuk4aFgSIqwDbceIkD9n4Tf1Ml?=
 =?us-ascii?Q?RN2VVNOPq06KPqdYOqsG/zbM6szwI8Wkx8ULTPUx1AiIern/lNyfzg/0B/UC?=
 =?us-ascii?Q?mmOrA7uRBS3lYpslAMWdw6ktbc5PnVQjtAr63YYGs8NwPPSoNJRIYRleKx2W?=
 =?us-ascii?Q?UDWpo57s20IPplrwt6e9oWfKeETEUWPS5N9Fx5SONaz7VvWGL+QRKWH+Kh0S?=
 =?us-ascii?Q?gRrR0VmagrEwF3U37rtAcODy0vioPKq2S0Y2XpcNv1DZXYcK1W9Hi3qSj4lK?=
 =?us-ascii?Q?DenuadXgUuHv8g9xXqdbgDz4FfioAKVwlvihG0OE+adWBj3AN18lHm7b4TA5?=
 =?us-ascii?Q?1TWgWG7mz9m+5W05LpOXo79hfe0MuNczcbMAO3LsPx6E1X3ZiV3yNMxgcHZI?=
 =?us-ascii?Q?PN37BUOi/BiwkrU/v4Bx7rmDz5Ngb8jGmUdX3YOfPZ/YVQEqgAZUSeeR9lCW?=
 =?us-ascii?Q?+vCDlLoxexSG7mqfnhLJnYVD0TE9vuMVvkawzTTFQRn0s2N73NOuQ6PRqorp?=
 =?us-ascii?Q?/I9wLVNVPSxeyDuzLTYkI9nppBS8gwYj+OFRhX++7ifnFZhrXFYi9SWQRz/Z?=
 =?us-ascii?Q?ysvcwNTOwdSDTvVVhel0oGijTgnV7QpdCBiENTz2M1kaTp5EJ7sIDisIvGgs?=
 =?us-ascii?Q?omXf4W6IhgOgUmDY2lk0BA05J8EdsoVC1jfqyYQUSnQmjSyEbR1SXlWGnMTO?=
 =?us-ascii?Q?nRI7KhWuIr+JbBL/d80/Sok7mfEh8L715/a4wf/3gXC/T0Qpf5DdjCSsQ+Bf?=
 =?us-ascii?Q?P5ronDObUcm+aVFjOZ5eccgCyVTzbAjgMNchVxc50y06f0fR0iusHWjTBanM?=
 =?us-ascii?Q?yJd31q5W+5q9PGAGb3ROL5LA++Do7xEB940KcxdtxZq6/N4R3292J2J3hcwJ?=
 =?us-ascii?Q?vxu3nEEghawvQj4Uv4CQbPf7Nv/HqGEXnCKoac0201WUnTZOG69O3ENvFGKW?=
 =?us-ascii?Q?O9mD/XgsPUwVrY4t12bT848JtsyswD+9/PdYN/xfygePIPrOxrGWCMKUDjHW?=
 =?us-ascii?Q?rrDgmb8bLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6177a3c8-3037-4ead-1436-08deb508f034
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:52.9167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BD9fgww8rIijvCDqJ1XGDTq2HT8jY+gyeLnYK76B2t/P6QaMRbBXJwj1otjGpSG8OsW/qiWvgLxxB8uCueAvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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

Add the BAR1 user interface for CPU access to GPU virtual memory through
the BAR1 aperture.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       |  22 ++-
 drivers/gpu/nova-core/gpu.rs          |  41 +++++-
 drivers/gpu/nova-core/gsp/commands.rs |   1 -
 drivers/gpu/nova-core/mm.rs           |   1 +
 drivers/gpu/nova-core/mm/bar_user.rs  | 194 ++++++++++++++++++++++++++
 5 files changed, 255 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/bar_user.rs

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index b14d4b599783..207ba164cf4e 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -2,10 +2,12 @@
 
 use kernel::{
     auxiliary,
+    device::Bound,
     device::Core,
     devres::Devres,
     dma::Device,
     dma::DmaMask,
+    io::resource,
     pci,
     pci::{
         Class,
@@ -47,9 +49,27 @@ pub(crate) struct NovaCore {
 const GPU_DMA_BITS: u32 = 47;
 
 pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
-#[expect(dead_code)]
 pub(crate) type Bar1 = pci::Bar;
 
+/// Returns the Linux PCI resource index that holds BAR1 for an NVIDIA GPU.
+///
+/// On Maxwell through Ada, BAR0 is a 32-bit memory BAR occupying a single
+/// Linux PCI resource slot, so BAR1 lives at index 1. Starting with Blackwell
+/// (and on some Ampere GA100 / Hopper SKUs) BAR0 is a 64-bit memory BAR that
+/// consumes two consecutive resource slots: index 0 holds the low 32 bits and
+/// index 1 holds the high 32 bits (with no `flags` / or size of its own),
+/// shifting BAR1 to index 2.
+pub(crate) fn bar1_resource_index(pdev: &pci::Device<Bound>) -> Result<u32> {
+    // Probe the `IORESOURCE_MEM_64` flag of BAR0 as a robust way of exposing
+    // if BAR0 and hence BAR1 is 64-bit.
+    let flags0 = pdev.resource_flags(0)?;
+    if flags0.contains(resource::Flags::IORESOURCE_MEM_64) {
+        Ok(2)
+    } else {
+        Ok(1)
+    }
+}
+
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index f789d956cc49..b0eebe6406e5 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -19,7 +19,10 @@
 
 use crate::{
     bounded_enum,
-    driver::Bar0,
+    driver::{
+        Bar0,
+        Bar1, //
+    },
     falcon::{
         gsp::Gsp as GspFalcon,
         sec2::Sec2 as Sec2Falcon,
@@ -31,8 +34,11 @@
         Gsp, //
     },
     mm::{
+        bar_user::BarUser,
+        pagetable::MmuVersion,
         GpuMm,
-        IntoVramRange, //
+        IntoVramRange,
+        VramAddress, //
     },
     regs,
 };
@@ -145,6 +151,11 @@ pub(crate) const fn arch(self) -> Architecture {
     pub(crate) const fn needs_fwsec_bootloader(self) -> bool {
         matches!(self.arch(), Architecture::Turing) || matches!(self, Self::GA100)
     }
+
+    /// Returns the MMU version for this chipset.
+    pub(crate) fn mmu_version(self) -> MmuVersion {
+        MmuVersion::from(self.arch())
+    }
 }
 
 // TODO
@@ -263,6 +274,8 @@ pub(crate) struct Gpu {
     spec: Spec,
     /// MMIO mapping of PCI BAR 0
     bar: Arc<Devres<Bar0>>,
+    /// MMIO mapping of PCI BAR 1.
+    bar1: Arc<Devres<Bar1>>,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
     sysmem_flush: SysmemFlush,
@@ -276,6 +289,8 @@ pub(crate) struct Gpu {
     #[pin]
     gsp: Gsp,
     gsp_static_info: GetGspStaticInfoReply,
+    /// BAR1 user interface for CPU access to GPU virtual memory.
+    bar_user: Arc<BarUser>,
 }
 
 impl Gpu {
@@ -348,6 +363,28 @@ pub(crate) fn new<'a>(
                 )?
             },
 
+            bar1: {
+                let bar1_idx = crate::driver::bar1_resource_index(pdev)?;
+                Arc::pin_init(pdev.iomap_region(bar1_idx, c"nova-core/bar1"), GFP_KERNEL)?
+            },
+
+            // Create BAR1 user interface for CPU access to GPU virtual memory.
+            bar_user: {
+                let pdb_addr = VramAddress::new(gsp_static_info.bar1_pde_base);
+                let bar1_idx = crate::driver::bar1_resource_index(pdev)?;
+                let bar1_size = pdev.resource_len(bar1_idx)?;
+                Arc::pin_init(
+                    BarUser::new(
+                        pdb_addr,
+                        spec.chipset,
+                        bar1_size,
+                        mm.clone(),
+                        bar1.clone(),
+                    )?,
+                    GFP_KERNEL,
+                )?
+            },
+
             bar: devres_bar,
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index bee7539eff60..301c95686efd 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -194,7 +194,6 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     /// BAR1 Page Directory Entry base address.
-    #[expect(dead_code)]
     pub(crate) bar1_pde_base: u64,
     /// Usable FB (VRAM) region for driver memory allocation.
     pub(crate) usable_fb_region: Range<u64>,
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 502c7fdceba2..4741ef60593b 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -31,6 +31,7 @@ macro_rules! impl_pfn_bounded {
     };
 }
 
+pub(crate) mod bar_user;
 pub(super) mod pagetable;
 pub(crate) mod pramin;
 pub(super) mod tlb;
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
new file mode 100644
index 000000000000..bb9742c036b7
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! BAR1 user interface for CPU access to GPU virtual memory. Used for USERD
+//! for GPU work submission, and applications to access GPU buffers via mmap().
+
+use kernel::{
+    device,
+    devres::Devres,
+    io::Io,
+    new_mutex,
+    prelude::*,
+    sync::{
+        Arc,
+        Mutex, //
+    },
+};
+
+use crate::{
+    driver::Bar1,
+    gpu::Chipset,
+    mm::{
+        vmm::{
+            MappedRange,
+            Vmm, //
+        },
+        GpuMm,
+        Pfn,
+        Vfn,
+        VirtualAddress,
+        VramAddress,
+        PAGE_SIZE, //
+    },
+    num::IntoSafeCast,
+};
+
+/// BAR1 user interface for virtual memory mappings.
+///
+/// Owns the [`Vmm`] for the BAR1 address space.
+#[pin_data]
+pub(crate) struct BarUser {
+    #[pin]
+    vmm: Mutex<Vmm>,
+    mm: Arc<GpuMm>,
+    bar1: Arc<Devres<Bar1>>,
+}
+
+impl BarUser {
+    /// Create a pin-initializer for [`BarUser`].
+    pub(crate) fn new(
+        pdb_addr: VramAddress,
+        chipset: Chipset,
+        va_size: u64,
+        mm: Arc<GpuMm>,
+        bar1: Arc<Devres<Bar1>>,
+    ) -> Result<impl PinInit<Self>> {
+        let vmm = Vmm::new(pdb_addr, chipset.mmu_version(), va_size)?;
+        Ok(pin_init!(Self {
+            vmm <- new_mutex!(vmm, "bar_user_vmm"),
+            mm,
+            bar1,
+        }))
+    }
+
+    /// Map physical pages to a contiguous BAR1 virtual range.
+    pub(crate) fn map(
+        self: &Arc<Self>,
+        dev: &device::Device<device::Bound>,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result<BarUserAccess> {
+        if pfns.is_empty() {
+            return Err(EINVAL);
+        }
+        let mut vmm = self.vmm.lock();
+        let mapped = vmm.map_pages(dev, &self.mm, pfns, None, writable)?;
+
+        Ok(BarUserAccess {
+            bar_user: self.clone(),
+            mapped: Some(mapped),
+        })
+    }
+}
+
+/// Access object for a mapped BAR1 region.
+pub(crate) struct BarUserAccess {
+    bar_user: Arc<BarUser>,
+    /// [`BarUserAccess::release`] [`Option::take`]s this; `Some` at
+    /// drop time means `release()` was never called.
+    mapped: Option<MappedRange>,
+}
+
+impl BarUserAccess {
+    /// Tear down the BAR1 mapping using a caller-supplied bound device.
+    pub(crate) fn release(mut self, dev: &device::Device<device::Bound>) -> Result {
+        let mapped = self.mapped.take().ok_or(EINVAL)?;
+        let mut vmm = self.bar_user.vmm.lock();
+        vmm.unmap_pages(dev, &self.bar_user.mm, mapped)?;
+        Ok(())
+    }
+
+    /// Returns the active mapping.
+    fn mapped(&self) -> &MappedRange {
+        // `mapped` is only `None` after `take()` in `release`; hence unwrap()
+        // cannot panic here.
+        self.mapped.as_ref().unwrap()
+    }
+
+    /// Get the base virtual address of this mapping.
+    pub(crate) fn base(&self) -> VirtualAddress {
+        VirtualAddress::from(self.mapped().vfn_start)
+    }
+
+    /// Get the total size of the mapped region in bytes.
+    pub(crate) fn size(&self) -> usize {
+        self.mapped().num_pages * PAGE_SIZE
+    }
+
+    /// Get the starting virtual frame number.
+    pub(crate) fn vfn_start(&self) -> Vfn {
+        self.mapped().vfn_start
+    }
+
+    /// Get the number of pages in this mapping.
+    pub(crate) fn num_pages(&self) -> usize {
+        self.mapped().num_pages
+    }
+
+    /// Translate an offset within this mapping to a BAR1 aperture offset.
+    fn bar_offset(&self, offset: usize) -> Result<usize> {
+        if offset >= self.size() {
+            return Err(EINVAL);
+        }
+
+        let base_vfn: usize = self.mapped().vfn_start.raw().into_safe_cast();
+        let base = base_vfn.checked_mul(PAGE_SIZE).ok_or(EOVERFLOW)?;
+        base.checked_add(offset).ok_or(EOVERFLOW)
+    }
+
+    // Fallible accessors with runtime bounds checking.
+
+    /// Read a 32-bit value at the given offset.
+    pub(crate) fn try_read32(
+        &self,
+        dev: &device::Device<device::Bound>,
+        offset: usize,
+    ) -> Result<u32> {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.access(dev)?.try_read32(off)
+    }
+
+    /// Write a 32-bit value at the given offset.
+    pub(crate) fn try_write32(
+        &self,
+        dev: &device::Device<device::Bound>,
+        value: u32,
+        offset: usize,
+    ) -> Result {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.access(dev)?.try_write32(value, off)
+    }
+
+    /// Read a 64-bit value at the given offset.
+    pub(crate) fn try_read64(
+        &self,
+        dev: &device::Device<device::Bound>,
+        offset: usize,
+    ) -> Result<u64> {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.access(dev)?.try_read64(off)
+    }
+
+    /// Write a 64-bit value at the given offset.
+    pub(crate) fn try_write64(
+        &self,
+        dev: &device::Device<device::Bound>,
+        value: u64,
+        offset: usize,
+    ) -> Result {
+        let off = self.bar_offset(offset)?;
+        self.bar_user.bar1.access(dev)?.try_write64(value, off)
+    }
+}
+
+impl Drop for BarUserAccess {
+    fn drop(&mut self) {
+        if self.mapped.is_some() {
+            kernel::pr_warn!(
+                "BarUserAccess dropped without calling release(). BarUser address space will leak.\n"
+            );
+        }
+        // The inner `MappedRange`'s own `MustUnmapGuard` will also fire,
+        // identifying the leaked VA range.
+    }
+}
-- 
2.34.1

