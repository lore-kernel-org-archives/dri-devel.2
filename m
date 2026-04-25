Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B45DFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A67410E492;
	Sat, 25 Apr 2026 21:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aO3Bx/cq";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A77910E48C
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqlNIjgAgwlv5X/EaBO0QJSd9htQy1tGkwz+ZgYECxWMstTX9K7TZfkd1OrSxadHuxKMV9vmr77abeEyGlNl5LLEbP4lPzLoj3Rbe0zxY/fMemVIoBY2YCL+aUEdjk1Ii5h7pj9X8T7/N6bO/HEvcHsJwtHslCZaylj87+QKmsH7LDVZlu17fOF4ynLwANmkc+n8BLWLsssD60FkrPn5rYk2qmZjxgdMxEfu2g+oFlg8Epd3pJk7spmmJVDVh6bhqP1sOZ7sAfSADW/0tKRSELTzqmAjcptu3M1ifyS4+aNpPg+XajOYWl8+/uw+0XCwm681plSQBk0nD6wBHdfrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X63yzfMDngEuRkmOZnoyg1PEN695h/K0zSZFMnEE2xU=;
 b=YhlnDO9NujJq6hNYKMWk4mWaJAUZZa1DZNqbOTq/s3+09W4p/FLV2hn3XhbwvUdqp2ZtD6ePrDJPChMsNwwk0Ev2mmd33KIqrybvss/FW04CG7GsmxUqEsRg3PkudwmFN0XSf/p2t66zja6MwGexNNGU0GhkjVllB2GcrLPJ2TA5Fh7G/8ylqSiqC3OqIBOOWyBhASts5taRhC6LQSw/te3/KOkTlhVDqA0GRSNlJuCCvqgA91sHrBnk6yR0T11DSHsax4Z2Fu6e74H+qkSYdhjkYKjW4D87AGJ4BQ7CS7lv/PWQdJAA7G+GRY8P5EC3ejspqI3z/pbaBMh6SiUuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X63yzfMDngEuRkmOZnoyg1PEN695h/K0zSZFMnEE2xU=;
 b=aO3Bx/cqZYwe4I1orfgpQ6306x0xaLaQxydJY6NkwykSVVkwic9KfTYefAEra8V1qntHTPjM0ivpnL0TS6TZIQ6yrNy7bJImo5JIGpAIhU2oRyz8PTAWpCMHb14CvPd9Q1UQ9ClMlyjGdGE8Et+GCbemHzxSAGy2uVuID4yB3+zbaXVDOBCqkllNoLI3RgosjXjZfSeiMJpKOujMyvPp/tO4mUESTzfSztFB+9SRgYLo+w6obSzlajuqS5p4sH0SRj2oga/7Uaapx9PgsHLivvJPn9ohx7fYK/f6bQ4UyDYQlgHDNLyzvQOJI9Jj3IQht8nBOyxBSvst5D6Ymf9nZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:47 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:47 +0000
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
Subject: [PATCH v12 18/22] gpu: nova-core: mm: Add BAR1 user interface
Date: Sat, 25 Apr 2026 17:14:50 -0400
Message-Id: <20260425211454.174696-19-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0190.namprd15.prod.outlook.com
 (2603:10b6:930:82::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: e39829d7-2b50-4100-ec83-08dea30fd1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZKC0goAVzZZZZeRHOptwZffA0gLGHThvmpjBDf8xxPeoCIx343SrVkcac0q1qnzd3xZ0hs3ou2ygECxfLbs6qhiaJD+x7vMWcRlqtFUPQ1Oz51Osm6jgADSg/WTKoHxncg7UqZczVszPqYUI9hxR6eIqLSt90D82XSNRDny+4DMtEz3W4CboqjUHSv4wtW+9TnIB2U/QyilrIIyh5TgsMgoYsRD9dwKiaBC2gv/j4UXyp9PvPXUyK6ET/YdACrU2jXCV/hYw+suP4od0IMSF4FOI4CarOI7p2z+/MvpGOT2mG4CkoYVzPA7ndLGISoXbjxb5nav0fbt9M68HbkHhgZL8eu03i3TSmuLvORA4qcys3dOP3ZbgyOG/z7KNl77r6OppyD+PIWYBRejWbty/izsyCY8tCWLjuAkoQZi/vMsVliFkr7cRlu6/sK2O26Z1LS4D8A3fnjNsvoAypLb6c1DAp+/jyYaa+EMD2nm7Pu0gI39b7YVJ4/9t2+TnTahj26jITjL5MSc2X/1umGq4XtfP6TBUN3ZmOPLreIwBt+U3WjVG0+lAKLEPj/WlC5ccEe9RlobFKjOIAOcQVhvyjRYbx105RVXr8OqjR3KsOwA7ClP6okCrFzc/OpLhQBYSuESQsud5NnEXpZ1bZPMlRqxsfHQJhIH75Ap8xDjU+YhCLw04+QZHplaZHeRA75L0bAZKL+u1VSd/V7AqpSKxkfD4EUbfwuNjKiU5N7pEC3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?waXkh348EloysLGaDzUAEZ2woyM0KIqo1gD7Lk81T+TjafXM+dtZIangQGw7?=
 =?us-ascii?Q?iqSkjjM2D6wr6btcCv042BoqgXdW+f+ICd2QXdXb/WBfojp+TEbo3LVfS0A6?=
 =?us-ascii?Q?0/XQe5HN98MFmdTQKHcrQ69e0OcXaX7W2EhTechkB1Xpbii8PUTopbskqtth?=
 =?us-ascii?Q?j94HhsHo1j5ooAvAows1UmpsKDX5bdC+sCpCqbonZDWts8dZUJ7iv9hBUy3C?=
 =?us-ascii?Q?5pp6Hw+yLWBnDz1cpBVp7HSS1jZDzYpTGtA/NGlN0y+38hjneBZHQ45/Qz7p?=
 =?us-ascii?Q?zM9QaBts9K2NkiF/NtAqbfb/vT5rDCwwYJEyixWIt7EY5scWijFbqpRxEnOY?=
 =?us-ascii?Q?4QhzNBp7LEuklphi501WDFkABAcBJolILrLG3KyYyByOzLjcpk+oOdroAd16?=
 =?us-ascii?Q?z9fjDRWrpKo+265Z+YNjt5GXyZR+x3iOLO2fFnf8x7ca+fLloJ/GfTo6dA5M?=
 =?us-ascii?Q?5bem9jLcvBHQB1l8qDwiQWLurYYigD80vetY2HSr+JPfjr5SKO6jvPxL0um1?=
 =?us-ascii?Q?jLK/zoGaAVWeD3zvm53R0W1JvZ7cvxatuELv7dW6L/f1oM3FvIoN4b3zsasn?=
 =?us-ascii?Q?DjkHAalDvWpeM9OY4T9qflqTmk93BMYo3Vxu32vWd1BhmxDrHV2lG4GizxiQ?=
 =?us-ascii?Q?ZtX1HiFgdyx3j35kHTWhUJwAMo9CWKAErdkzKnb+fs17X4cmLx99XLh3DsG7?=
 =?us-ascii?Q?DHwxxOa6Xcm0D/UtIIgqtduNh3Hl18RGHtwfrOaLQ/I228aEh5o2s+80SPAW?=
 =?us-ascii?Q?JEu0HgfnGHPXT32bpK+LvSRnQ7lxySoxxE6JgGLO2oB8CGn5g1NYJ2eFjZUS?=
 =?us-ascii?Q?4AE9YhUUVteJaACwM0/0GpdirfWQ/ONT5mtORym9ERGVGKt1czcdnhE7SpVj?=
 =?us-ascii?Q?wfItdEw+8xU1qXIg0IDOC308SMyGiEj21D5lpiSGPH4S0YF6dpxfhRnd49Xg?=
 =?us-ascii?Q?Kh48HJ9yuvqlVe2G+eOvklyW7Y2tymaoUOrtQtBL0o5cPWVP3Q3N0lRxW6y+?=
 =?us-ascii?Q?nuHmq6II5qysvDE7YCn2agPbNC9zYNwu2ECPnz9w3xbqlCOcPBzV/UWw9lhi?=
 =?us-ascii?Q?BvlZnq6E1s6V/OIDaIl25hCan7uHDjGlqrQ5Nz1hz3pgfZLggY6CkJg9SM/e?=
 =?us-ascii?Q?1CmkB8jVN96A0YEcgJvbOodlagImPI/RPY+uC9fa33RJt/kUhm+UUbYO53B+?=
 =?us-ascii?Q?Ddx/j9BDUheq0Ul0SN7xWakrjNQx74EcOsjrKYf0U6N2D3gbQCSoyHsjXhtZ?=
 =?us-ascii?Q?F8uYpqY+mzS6+JFjpUaosj1pihWorXf+q4AAM95k8MYvgwYyrLeJ3EhhMr8e?=
 =?us-ascii?Q?jj9y4IAJsJ1KYinZiSJoIpQgbj3qD9feuNpC+WpAjLQJI6fSCt80ERJjdxyP?=
 =?us-ascii?Q?tq8cutn+VIJ3IgRECnenB3NbCEl8oAEODTiYGWWqZkjPULpfUcgJTjimlUp/?=
 =?us-ascii?Q?+6sVXeV0ZrjTtzWioDsHpFsK5TH6cZZn4UYNTs4GzKipd2sFmapOs15LIxzN?=
 =?us-ascii?Q?nteZwrdsK5vrbZZWZNUICqbitxI19hxWux6IMt0pYh0Se/nIyJOnZwlBaEXe?=
 =?us-ascii?Q?vvy+NlaBphltiKgt5j1JAhFV629epq7E8C3oK/QFaKMeEv5J6Nxkq1D3JIIQ?=
 =?us-ascii?Q?97+30c7Nbo7nEUBRTRpnwyxE1gLK2skeyA0awqLieWF8sb7mxcFnQfvkAAPg?=
 =?us-ascii?Q?FDcPWv5gKbk67OYzLHueEpBM0TEj8r2JShYRS9PhejbDhKMHpzUPh//NxdA/?=
 =?us-ascii?Q?1G4VfAJxVA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39829d7-2b50-4100-ec83-08dea30fd1f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:47.7448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUJSgeZeYDXWlBDYp7nNhwl+dXWaasPlplllqDxo9Ech5pKB/C9/TPkgJpa24b34aUoiQ+a26wHAbQmflTzBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs       |   1 -
 drivers/gpu/nova-core/gpu.rs          |  21 +++-
 drivers/gpu/nova-core/gsp/commands.rs |   1 -
 drivers/gpu/nova-core/mm.rs           |   1 +
 drivers/gpu/nova-core/mm/bar_user.rs  | 156 ++++++++++++++++++++++++++
 5 files changed, 177 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/nova-core/mm/bar_user.rs

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 597343d5da54..e78a682a7f2a 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -47,7 +47,6 @@ pub(crate) struct NovaCore {
 const GPU_DMA_BITS: u32 = 47;
 
 pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
-#[expect(dead_code)]
 pub(crate) type Bar1 = pci::Bar;
 
 kernel::pci_device_table!(
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fce05e9d1a89..73a48dba391d 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -28,7 +28,12 @@
         commands::GetGspStaticInfoReply,
         Gsp, //
     },
-    mm::GpuMm,
+    mm::{
+        bar_user::BarUser,
+        pagetable::MmuVersion,
+        GpuMm,
+        VramAddress, //
+    },
     regs,
 };
 
@@ -122,6 +127,11 @@ pub(crate) const fn arch(self) -> Architecture {
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
@@ -249,6 +259,8 @@ pub(crate) struct Gpu {
     #[pin]
     gsp: Gsp,
     gsp_static_info: GetGspStaticInfoReply,
+    /// BAR1 user interface for CPU access to GPU virtual memory.
+    bar_user: BarUser,
 }
 
 impl Gpu {
@@ -313,6 +325,13 @@ pub(crate) fn new<'a>(
                 }, pramin_vram_region)?
             },
 
+            // Create BAR1 user interface for CPU access to GPU virtual memory.
+            bar_user: {
+                let pdb_addr = VramAddress::new(gsp_static_info.bar1_pde_base);
+                let bar1_size = pdev.resource_len(1)?;
+                BarUser::new(pdb_addr, spec.chipset, bar1_size)?
+            },
+
             bar: devres_bar,
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 9bf0d32c6a7f..32df0fe4b9c2 100644
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
index 88d0b436de4e..7b68028f1dad 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -32,6 +32,7 @@ macro_rules! impl_pfn_bounded {
     };
 }
 
+pub(crate) mod bar_user;
 pub(super) mod pagetable;
 pub(crate) mod pramin;
 pub(super) mod tlb;
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
new file mode 100644
index 000000000000..ab56ecd66fb9
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! BAR1 user interface for CPU access to GPU virtual memory. Used for USERD
+//! for GPU work submission, and applications to access GPU buffers via mmap().
+
+use kernel::{
+    device,
+    io::Io,
+    prelude::*, //
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
+/// Owns a [`Vmm`] instance with virtual address tracking and provides
+/// BAR1-specific mapping and cleanup operations.
+pub(crate) struct BarUser {
+    vmm: Vmm,
+}
+
+impl BarUser {
+    /// Create a new [`BarUser`] with virtual address tracking.
+    pub(crate) fn new(pdb_addr: VramAddress, chipset: Chipset, va_size: u64) -> Result<Self> {
+        Ok(Self {
+            vmm: Vmm::new(pdb_addr, chipset.mmu_version(), va_size)?,
+        })
+    }
+
+    /// Map physical pages to a contiguous BAR1 virtual range.
+    pub(crate) fn map<'a>(
+        &'a mut self,
+        dev: &'a device::Device<device::Bound>,
+        mm: &'a GpuMm,
+        bar: &'a Bar1,
+        pfns: &[Pfn],
+        writable: bool,
+    ) -> Result<BarUserAccess<'a>> {
+        if pfns.is_empty() {
+            return Err(EINVAL);
+        }
+
+        let mapped = self.vmm.map_pages(dev, mm, pfns, None, writable)?;
+
+        Ok(BarUserAccess {
+            vmm: &mut self.vmm,
+            dev,
+            mm,
+            bar,
+            mapped: Some(mapped),
+        })
+    }
+}
+
+/// Access object for a mapped BAR1 region.
+///
+/// Wraps a [`MappedRange`] and provides BAR1 access. When dropped,
+/// unmaps pages and releases the VA range (by passing the range to
+/// [`Vmm::unmap_pages()`], which consumes it).
+pub(crate) struct BarUserAccess<'a> {
+    vmm: &'a mut Vmm,
+    dev: &'a device::Device<device::Bound>,
+    mm: &'a GpuMm,
+    bar: &'a Bar1,
+    /// Needs to be an `Option` so that we can `take()` it and call `Drop`
+    /// on it in [`Vmm::unmap_pages()`].
+    mapped: Option<MappedRange>,
+}
+
+impl<'a> BarUserAccess<'a> {
+    /// Returns the active mapping.
+    fn mapped(&self) -> &MappedRange {
+        // `mapped` is only `None` after `take()` in `Drop`; accessors are
+        // never called from within `Drop`, so `unwrap()` never panics.
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
+    pub(crate) fn try_read32(&self, offset: usize) -> Result<u32> {
+        self.bar.try_read32(self.bar_offset(offset)?)
+    }
+
+    /// Write a 32-bit value at the given offset.
+    pub(crate) fn try_write32(&self, value: u32, offset: usize) -> Result {
+        self.bar.try_write32(value, self.bar_offset(offset)?)
+    }
+
+    /// Read a 64-bit value at the given offset.
+    pub(crate) fn try_read64(&self, offset: usize) -> Result<u64> {
+        self.bar.try_read64(self.bar_offset(offset)?)
+    }
+
+    /// Write a 64-bit value at the given offset.
+    pub(crate) fn try_write64(&self, value: u64, offset: usize) -> Result {
+        self.bar.try_write64(value, self.bar_offset(offset)?)
+    }
+}
+
+impl Drop for BarUserAccess<'_> {
+    fn drop(&mut self) {
+        if let Some(mapped) = self.mapped.take() {
+            if self.vmm.unmap_pages(self.dev, self.mm, mapped).is_err() {
+                kernel::pr_warn_once!("BarUserAccess: unmap_pages failed.\n");
+            }
+        }
+    }
+}
-- 
2.34.1

