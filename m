Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8571FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D285A10E48E;
	Sat, 25 Apr 2026 21:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPRZDrIl";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570E410E491
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oige6T1KYqxlKfK6zp/NImzFEz5vwfM9RuAbpktP/SSGqhKNBHRp2ZQhe9BJnBjzNwxYWVmm84BJu11t8qMV9NBaVJ47DZMgQNicX7D4Pe4igdzM0hS5vX87MljeY4IMaz2KbagJqP/D00KXoH1ivLlomQ60oHNtZdrnjpDG9S0ZSq3q6+Z9cEYievMzXTnad76QiraCVX4I2LVpAWmMAiYpW7UeYb0bgDb7sHHS5RceV17mzRX1B1MzkzJYIwTGW8VdFnDcp5U+K+bNbd531tT2f0uUEXnQKfSfgzN9/FVJe4P2be2q67xuHxFf5Q19OkltvDkUF5Nx0O2BRMaPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i6cMuz3y+YTpa/qrswfQtcNjOr7agSy8V9BvqL6QeI=;
 b=f8WpqGLk0qiPk7P5TwJgBZuYexbduKuWnnT0Zxzs7IdCAlPWTV1jotojdChZiYqpKDwVogn/R3Dj976fW0yPWnIWToDGhS6wWhGL5ZDr4Hu2OO+Jj0Ktr+mRAOeBoMn1gdKxB8YMvvn0LsMyI3HOy/fNzKYQb8xLR/YvvKYIjUvbL9hG70u4cbvGLefgoW0ssX628nZe1E82aRDW+6la8ZsZNopM+Lr/Rs5cLMW+Jt5e+GYHr8K+DPpAaMrxTC6g4RNalwsvC6Laobpkr8QCbDHU4ZbTbiISe7d27OiKS3tUtel88FKKEe04Jl8pkiDPyyrMbepgPjiXQXxdtZ9K5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i6cMuz3y+YTpa/qrswfQtcNjOr7agSy8V9BvqL6QeI=;
 b=EPRZDrIlwnfRHE+5uVumiV+1oBhIN0TSUFgzbSNyNpxVzvYR5vhzgEaw6GHgQoppe5kmQhp6XLAIyYnpFjgyJM89QSE5lsURJjp1B2utlHkcyxNw3NQVbDG+YNCMQZamB36AUJOj6Q0egeQ8xMU6remmjR1/C5jM1l31Sf5AHKkJMiCjzNt4qgqpnrnns5AKIdH1oMs6r0KIjmRM8w+FpJFxC2dU9NIGxtNzcV/IaiENKudpwE0Z+ww2NHNtPmMbqqkIi2vZJhT4w/9Zry3Po4ZLrHoSPIxmxcE0hDnQd5rsKiyH3mc7xiWZF+bCwMNPMXA0TI9Lp9i1pMZJnipa8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:25 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:25 +0000
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
Subject: [PATCH v12 08/22] gpu: nova-core: mm: Add GpuMm centralized memory
 manager
Date: Sat, 25 Apr 2026 17:14:40 -0400
Message-Id: <20260425211454.174696-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ee::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bc66a7-2b43-4be0-1d62-08dea30fc483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NlCP956tPzEZLB76kCgBLJUrK2r4tC2goiLlMoUlP0PIOzJ+CQCErJieVwL7D3wZyKf6qFY+WVZrUlSSlXf/tgOh3iu5I2rd+OUkAr0D53XRrWl5LXlFV2FMjQuzilOix9ZPEuqbJZ3JQOUy0fu1QC4eSaQPtFMlW6KBlthkrRT3JAd34L13+IPTGoOn78cTHzZ+LjswghfDjZYtRmih1vBgvWTPQxKAEDCL6HR9Hf8oEgzm0LQMkJMXPskhj7pmb+OEjoF+NVC1rx8BbvA+lB/5PBFG08WTgp6JlTnzn8Tf6rr6/WPB/33Wn34vgHyOTFEvTUeo3FePtssaUKnjBATxdVGwSYW8xBMmxLMeYMRi9zuSyf0L3frabFJJ8MJh44Qph+lQlkSKCIk7jivr6Ctb+Tiot4EYt6biOz5K/Yo2L9Pw1O2Zu9FzdhIvEBiKafmJ2ua3WWDiVVK2SxmyCfPjEL87s0X8J/hO+WaRD3RcMyLDyM2RhWTwpYfpcjiBLnVagQbxehZtP/h/DXUdn66hdZOvOMMHA0neEcCxuEQiX3q1Vzjtw66686KLsuFYfhR/uPV0OtGVxUPPYuoHsbYE6dOP4m4tU1llA67LkYirnasKUcCUUuLvh82B3b/m/4h6KRYbETwdUWEByIH5k8geNZWrkQ9IwsNMxtnxcTQF2mIEbEc7KQtx16Qxi2dyFftZTKm6zGCzyzvIb6x9Mn82t55piRxzVQ/pwJNnuWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WFVGhEZVgQxdciDBXLMIihUSVetFOyAvgyMUA0WWiv74YJFamwEI+0SeSdT1?=
 =?us-ascii?Q?Yr4dvQKb4/PyETq82TeJFnAZwnkqOasGwrAegSABkOQFsJL1pNrmHlNuQnRb?=
 =?us-ascii?Q?wTJSW36yj17kkCtBcVxzhTjs0JvhYnQa08YRrFvnhFLxxkr8G8GUZdlB01/0?=
 =?us-ascii?Q?QBZ8+WtvCq/L58TG39R6I0748ol2swRNGYXciB2WnUMdRoaLsP3RGmG0wwJJ?=
 =?us-ascii?Q?fU1egkmEvJK5PniN8s74ZFLPszsqopE1ApP37vAJKIiRRAML0Ea0ytiDoh7i?=
 =?us-ascii?Q?Znj2rUaSkCojgNwO3p+y0HCVS1xBPqrrhRE48HESXtSILL8SbjsRHGgkPB6y?=
 =?us-ascii?Q?VEKjK1vTjUmGlcMLxtmeplG8D+oDXzzJlAOwIpg5yZkvvlkVBITGV0B34oHv?=
 =?us-ascii?Q?as1qWL/YWJF3oJkHsUEJL0hD5kFM8+pa+LOz97vpBwTXRUrvkgD5evGOwEdL?=
 =?us-ascii?Q?tD6IrnYkc6DuhgLE6skUlC730ZrN9nsGBLhmvfF9m7cu0VKqaVJbchxGis+F?=
 =?us-ascii?Q?VGwGK0xgrZ8wJw0PXF9A4rt26MlOY5j40/q66HpJqpUrOJM3UrKTkg/kEcXE?=
 =?us-ascii?Q?HW73bJJ3+6sbmfNRvYelS0KzHTHyIr438hY6VILbKCb3Kg7+xGyb4NNBt7Q2?=
 =?us-ascii?Q?ILb8O7yv6kbLT0ZJsJWMVax6WScnTNQR63dNBeneGq1ARRisitSQSlb7X7A2?=
 =?us-ascii?Q?Rke1tZXefVkScENFAnaa0O/6XZIQfHi1PgcG3QLkiwCq3yas0waZ9EdyL8LG?=
 =?us-ascii?Q?XQrXzZgZ/sCZii95/smEth1ZVKa27XwfMlm6h7uEJKEXTB11CX2sFcmXL2IR?=
 =?us-ascii?Q?yvZVBXoncJTqu5/5ABrLaJ6h+uP9N8TTJeIMnrEBvW3WWlZc3dPhrtbNg/qt?=
 =?us-ascii?Q?Y9UhFt4e5TH31cCDBWJt7RZz0FylxaMxrgnx/j2rby+BAduAc2F/LD/E8dMX?=
 =?us-ascii?Q?Xms6JXnyHO18vRkiMbJPYa/cffYxAmrMr6KkoaiYynwMYscjNhE7Q8D4BkEf?=
 =?us-ascii?Q?LuNestHVbC6MaGxvqVnPha9JJgJYHZiMsG5QXWXSlQNRKF2pCc6VkOf5+jy/?=
 =?us-ascii?Q?7GBsMIjU1REHwNFuVzyFbsOX+esKq9lhYvlpcglssz3avYsf8QHSpdmp6jnU?=
 =?us-ascii?Q?+oRo1zLeFqHwd/EIWWwJUTKtTUKYgXOSsO07rVgaUpySDfgZb0VvsLi60/Fe?=
 =?us-ascii?Q?FaboVz/jXS8TKX9NkiZSRWYhbCaEjUGnbK5asXgbE4TxQOowkl7/hVY0d+Ma?=
 =?us-ascii?Q?82akE+1NccUFJ6gHjhry3b65t2D11xJwa1SVvMDvHWqiSQxUwHe3vaTDAoxe?=
 =?us-ascii?Q?cCMZnlqZBJr/tS9NhM7lCb/EInWDkNFyp8stq3Fv/+XzGzDf7EOxSkcrHb9x?=
 =?us-ascii?Q?VmgnNaCP4CwJnZlyc1K2I6qirZIKqshAJXkDZtMFHHkpQ3jb6FwzC0VG4Kkt?=
 =?us-ascii?Q?8DC95Eu0aMClFTsd7DxcvsSNUsT7lokgQAtvahU7rRWwIeDgp2kSEVqQD9LS?=
 =?us-ascii?Q?Sbirg+qDwHTVY2koCr4ZQj9u/tAIuBOdmUSheix/qwIBP/Fa4QZ7hLCQYT1D?=
 =?us-ascii?Q?fnq2YfDJ865hq1zZlk5Rj1Bcx9rG2ZnQSe0NAyQfJoVcydAzOCHYONoHTL31?=
 =?us-ascii?Q?edulF9Df/Zqb1yfYkohqKAFQZmFI3u6asDmppIPH8B8a8s4tEfndofC/Km3F?=
 =?us-ascii?Q?bZGcX1BvV7XLLhltHq2QzQ3A5f/ywm8IriamBWS1NOjVakS9R9QFQmGD3kgZ?=
 =?us-ascii?Q?8NekCld2sg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bc66a7-2b43-4be0-1d62-08dea30fc483
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:25.1338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIKt1360IR6gOun7CLBpUYY7hzOIiMg9wmqHSX5djWC2qKSuQOeQsJ1fwue4RBi9uWSBswjyz+Kzk1Fmq+EtFg==
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

Introduce GpuMm as the centralized GPU memory manager that owns:
- Buddy allocator for VRAM allocation.
- PRAMIN window for direct VRAM access.
- TLB manager for translation buffer operations.

This provides clean ownership model where GpuMm provides accessor
methods for its components that can be used for memory management
operations.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/Kconfig         |  1 +
 drivers/gpu/nova-core/gpu.rs          | 28 +++++++++++
 drivers/gpu/nova-core/gsp/commands.rs |  1 -
 drivers/gpu/nova-core/mm.rs           | 69 ++++++++++++++++++++++++++-
 drivers/gpu/nova-core/mm/pramin.rs    | 20 ++++----
 5 files changed, 108 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index a4f2380654e2..6513007bf66f 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -4,6 +4,7 @@ config NOVA_CORE
 	depends on PCI
 	depends on RUST
 	select AUXILIARY_BUS
+	select GPU_BUDDY
 	select RUST_FW_LOADER_ABSTRACTIONS
 	default n
 	help
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 675a0676f032..fce05e9d1a89 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -4,10 +4,13 @@
     device,
     devres::Devres,
     fmt,
+    gpu::buddy::GpuBuddyParams,
     io::Io,
     num::Bounded,
     pci,
     prelude::*,
+    ptr::Alignment,
+    sizes::SZ_4K,
     sync::Arc, //
 };
 
@@ -25,6 +28,7 @@
         commands::GetGspStaticInfoReply,
         Gsp, //
     },
+    mm::GpuMm,
     regs,
 };
 
@@ -238,6 +242,9 @@ pub(crate) struct Gpu {
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<Sec2Falcon>,
+    /// GPU memory manager owning memory management resources.
+    #[pin]
+    mm: GpuMm,
     /// GSP runtime data. Temporarily an empty placeholder.
     #[pin]
     gsp: Gsp,
@@ -276,6 +283,13 @@ pub(crate) fn new<'a>(
             gsp_static_info: {
                 let info = gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?;
 
+                dev_info!(
+                    pdev.as_ref(),
+                    "Using FB region: {:#x}..{:#x}\n",
+                    info.usable_fb_region.start,
+                    info.usable_fb_region.end
+                );
+
                 dev_info!(
                     pdev.as_ref(),
                     "Total physical VRAM: {} MiB\n",
@@ -285,6 +299,20 @@ pub(crate) fn new<'a>(
                 info
             },
 
+            // Create GPU memory manager owning memory management resources.
+            mm <- {
+                let usable_vram = &gsp_static_info.usable_fb_region;
+
+                // PRAMIN covers all physical VRAM (including GSP-reserved areas
+                // above the usable region, e.g. the BAR1 page directory).
+                let pramin_vram_region = 0..gsp_static_info.total_fb_end;
+                GpuMm::new(devres_bar.clone(), pdev.as_ref(), GpuBuddyParams {
+                    base_offset: usable_vram.start,
+                    size: usable_vram.end - usable_vram.start,
+                    chunk_size: Alignment::new::<SZ_4K>(),
+                }, pramin_vram_region)?
+            },
+
             bar: devres_bar,
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 40b4ef72169d..eeecf81a0ffd 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -194,7 +194,6 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     /// Usable FB (VRAM) region for driver memory allocation.
-    #[expect(dead_code)]
     pub(crate) usable_fb_region: Range<u64>,
     /// End of VRAM.
     pub(crate) total_fb_end: u64,
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 2a8b228b1916..8b8a86980bb6 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -37,12 +37,77 @@ macro_rules! impl_pfn_bounded {
 
 use kernel::{
     bitfield,
+    device,
+    devres::Devres,
+    gpu::buddy::{
+        GpuBuddy,
+        GpuBuddyParams, //
+    },
     num::Bounded,
     prelude::*,
-    sizes::SZ_4K, //
+    sizes::SZ_4K,
+    sync::Arc, //
 };
 
-use crate::num::u64_as_usize;
+use crate::{
+    driver::Bar0,
+    num::u64_as_usize, //
+};
+
+pub(crate) use tlb::Tlb;
+
+/// GPU Memory Manager - owns all core MM components.
+///
+/// Provides centralized ownership of memory management resources:
+/// - [`GpuBuddy`] allocator for VRAM page table allocation.
+/// - [`pramin::Pramin`] for direct VRAM access.
+/// - [`Tlb`] manager for translation buffer flush operations.
+#[pin_data]
+pub(crate) struct GpuMm {
+    buddy: GpuBuddy,
+    #[pin]
+    pramin: pramin::Pramin,
+    #[pin]
+    tlb: Tlb,
+}
+
+impl GpuMm {
+    /// Create a pin-initializer for `GpuMm`.
+    ///
+    /// `pramin_vram_region` is the full physical VRAM range (including GSP-reserved
+    /// areas). PRAMIN window accesses are validated against this range.
+    pub(crate) fn new(
+        bar: Arc<Devres<Bar0>>,
+        dev: &device::Device<device::Bound>,
+        buddy_params: GpuBuddyParams,
+        pramin_vram_region: core::ops::Range<u64>,
+    ) -> Result<impl PinInit<Self>> {
+        let buddy = GpuBuddy::new(buddy_params)?;
+        let tlb_init = Tlb::new(bar.clone());
+        let pramin_init = pramin::Pramin::new(bar, dev, pramin_vram_region)?;
+
+        Ok(pin_init!(Self {
+            buddy,
+            pramin <- pramin_init,
+            tlb <- tlb_init,
+        }))
+    }
+
+    /// Access the [`GpuBuddy`] allocator.
+    pub(crate) fn buddy(&self) -> &GpuBuddy {
+        &self.buddy
+    }
+
+    /// Access the [`pramin::Pramin`].
+    pub(crate) fn pramin(&self) -> &pramin::Pramin {
+        &self.pramin
+    }
+
+    /// Access the [`Tlb`] manager.
+    pub(crate) fn tlb(&self) -> &Tlb {
+        &self.tlb
+    }
+}
 
 /// Page size in bytes (4 KiB).
 pub(crate) const PAGE_SIZE: usize = SZ_4K;
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index 57b560ae1e85..cc393f1509d7 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -94,12 +94,12 @@
 };
 
 use kernel::{
+    device,
     devres::Devres,
     io::Io,
     new_mutex,
     num::Bounded,
     prelude::*,
-    revocable::RevocableGuard,
     sizes::{
         SZ_1M,
         SZ_64K, //
@@ -137,7 +137,7 @@ pub(crate) fn $name(&mut self, vram_offset: usize) -> Result<$ty> {
                 self.compute_window(vram_offset, ::core::mem::size_of::<$ty>())?;
 
             if let Some(base) = new_base {
-                Self::write_window_base(&self.bar, base)?;
+                Self::write_window_base(self.bar, base)?;
                 *self.state = base;
             }
             self.bar.$name(bar_offset)
@@ -154,7 +154,7 @@ pub(crate) fn $name(&mut self, vram_offset: usize, value: $ty) -> Result {
                 self.compute_window(vram_offset, ::core::mem::size_of::<$ty>())?;
 
             if let Some(base) = new_base {
-                Self::write_window_base(&self.bar, base)?;
+                Self::write_window_base(self.bar, base)?;
                 *self.state = base;
             }
             self.bar.$name(value, bar_offset)
@@ -188,10 +188,11 @@ impl Pramin {
     /// `vram_region` specifies the valid VRAM address range.
     pub(crate) fn new(
         bar: Arc<Devres<Bar0>>,
+        dev: &device::Device<device::Bound>,
         vram_region: Range<u64>,
     ) -> Result<impl PinInit<Self>> {
-        let bar_access = bar.try_access().ok_or(ENODEV)?;
-        let current_base = Self::read_window_base(&bar_access);
+        let bar_access = bar.access(dev)?;
+        let current_base = Self::read_window_base(bar_access);
 
         Ok(pin_init!(Self {
             bar,
@@ -204,8 +205,11 @@ pub(crate) fn new(
     ///
     /// Returns a [`PraminWindow`] guard that provides VRAM read/write accessors.
     /// The [`PraminWindow`] is exclusive and only one can exist at a time.
-    pub(crate) fn get_window(&self) -> Result<PraminWindow<'_>> {
-        let bar = self.bar.try_access().ok_or(ENODEV)?;
+    pub(crate) fn get_window<'a>(
+        &'a self,
+        dev: &'a device::Device<device::Bound>,
+    ) -> Result<PraminWindow<'a>> {
+        let bar = self.bar.access(dev)?;
         let state = self.state.lock();
         Ok(PraminWindow {
             bar,
@@ -231,7 +235,7 @@ fn read_window_base(bar: &Bar0) -> u64 {
 /// Only one [`PraminWindow`] can exist at a time per [`Pramin`] instance (enforced by the
 /// internal `MutexGuard`).
 pub(crate) struct PraminWindow<'a> {
-    bar: RevocableGuard<'a, Bar0>,
+    bar: &'a Bar0,
     vram_region: Range<u64>,
     state: MutexGuard<'a, u64>,
 }
-- 
2.34.1

