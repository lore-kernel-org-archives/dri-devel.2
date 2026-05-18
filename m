Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1740CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA4F10E8EC;
	Mon, 18 May 2026 18:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HYTV4Xw/";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B870F10E8EC
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:06:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H896aKHeZnJSAbkpepjIuX/s8zDhj+hiOJiYXQe2fgVN+4avntraWgOIoYsnBcPCMjjk+P9btQLFNaOYJv1u6MomRmgrq3pQDxXSUmw01tQDKoaMvk2OsyraSo7AM3wfAUgsEiBCYe1oIafpy7hx8lz8HqVKYqNpJsoMwVKWghIonn36n5U/yYzsoPsCJAiqQvBacHkp79XT9Oek17LuvnT1MJ6lOD6WSMZduhvyzhiUNtmrj30ULxpFPCTvqfyWDYQbY/BESh+I9z515K++8lxUvISwvPWB7PYm9BUPmTtK0p0SgUo+Fb/KM1+n5k5e1aSwE34b2dXOUReEgK3jiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y134jNDQQ4V1sO55gRveXiIwjrjDscY+dph9i/2mJ+M=;
 b=Ok0iyUfy+S7ZWIGDVy5swhQhnHOGdrlgfyreFmLa05hBzTE3iGqnm9vu32XNsPgRqeUw95hOYqBOpzokQxJWFKhlpJmlsMoKeXnzqrOFxWAD2HVi3G7PgHO1pqVGPV2P3B5ymVzJy8vAqy+b2vXM3A7GZ1neYA9pgqutH9Z+F08t6GCzEw6+nQcdjNvaPq83Z3c1DdzpDTTU4OSGv7mHEDkEtckc5y91i40c7JldW/otqBOwYILR9Vxvehf5PebLlcIcO3ZVjeuD0UR8JlSGGcVyRRBw77TznH5OOxFbkQD1FA0lJ4elKylzROzckitC+tSiw/TJtkVGR4ukYb5CYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y134jNDQQ4V1sO55gRveXiIwjrjDscY+dph9i/2mJ+M=;
 b=HYTV4Xw/rrKMaLns5yqY46QiqW+wcANWgRDroIYoRKKgLcAbEBuaSuO6cusoKD+I7m1W7zlRTs2GBmyod940Q4aTOfTd1V92HxvGyqTI6GsiFBWIpxGXJTWtWNmyZHVXF08KwmhQvsC5qmLvquAjUa9NFs75HvScE0hBk5s6E5tPoi5VQg3aZO6niYFqwfBJ0k8CnydxUkOobj/WyLC5ju5nZHW4UBhMPw5TacPfo+/D9wAvkj59kq9IZWCx0g/F4AXTWZCvdcTcKbw7GgjEUtAjcnv+/MyR90uxRhpUusuDWhv1VIiTVfZu0a4wFM5Z12iM5hoV3KH9Q8bWYyItAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Mon, 18 May 2026 18:04:08 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:04:08 +0000
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
Subject: [PATCH v1 11/12] gpu: nova-core: mm: Add GpuMm centralized memory
 manager
Date: Mon, 18 May 2026 14:03:41 -0400
Message-Id: <20260518180342.2387845-12-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c85b50-b7e5-4406-9d55-08deb507db05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: 7L5xR9ka5XtU2/JpBW3SI/dQsd7sRdJRWHx9uYaFIYXd04xLmBdEqWIGJLEFxWuO07LMcjsNQ2YGm+PPz+DQ7j+2r7q4nCNUzgrAUdswBYGBl+eISnZWGhYlsxGvLatE9XIxamVuC+4FY6I5MHx6fF0Rbe55d+L10nfgoupH0cpT90X4qzwcK6NAv8oqI5ieDP7S/ei4OmFl8zcMnnUvRZXtyuLdNgYeGzWTOXomkkmuxj8Qa0maCzCFsyuItGNab28uiVArBhv4ogiYys/vR7wKRqpA00AtkYG1DoUenVEUw4ufdidV/7j8NMcu8YH/Fw0N03dT4vJ+t59a0maUQ/j7FkecdP/KzcO33sJ9YmjRCFDV6xdh3yh3RcUO5ryh4h67OvdnuOW6dJJ1M8K5/0ul/5oopVkxosR01+DaRKRXS3HWZD7zjB5U8gYIq4HRBRvOdHOup52Bbx0lLZOO0JPRNmZI7RCTMzvVhZttoId+7e2Ku2sy/SmSv7u4hOJjTRiIDyDhdMozK+fp658odr25dsTw8crjoq+FSEsTo1i/OvSbNIvpjezsYdDa9TqrxqRx50iiNAvT1Dr5k7U4lZLt3eT/a2LgoJIsQKrmvlnUWz5Il01d5X0Ubqe2cuOnfJK5ku6Hu38ToZQIpR8HKzlJSzdFVRhNQJdc0jfZvNm5BHzilJjS8gDsum7J75oE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xkASqRudoRDYVp/qy/bVooTh3qbRvHReb7YJzmSj/em5yMWTPW42w+/gPh0q?=
 =?us-ascii?Q?K6Qha+Zzveozdr9G5TJsNvmZt3He0LinsY+wm4aZ1oY803HfAyW7l+wBh6oL?=
 =?us-ascii?Q?R2SamWuW3egLMmqpusehpCWEZWm8r2CMV/D43HP+mTLQNQPjceLRrgncpaT8?=
 =?us-ascii?Q?Rl2XAA3gpfeH2cgvclNADSGy6wv+A/T1rnSofZsfHJFTZY0xg5GWshGWveit?=
 =?us-ascii?Q?Q5/5hEQ+Ci42j6aB7KG4nLlu4X1RYceMmIzzWTpj4TZywkTjXlcvUSneSYM7?=
 =?us-ascii?Q?avJuP9Qj3iL7HXlld5m9GG50//T0eaWSgUSd7qmgKD2GtBbU08fypb+dTDWE?=
 =?us-ascii?Q?tsAe6j3tXjDTkUJi60N6LcWKmQxm1ZmKM5Y3zf5ekiXISSjpo9JgUwuAl6mq?=
 =?us-ascii?Q?AqP8kLHOg8XCp64IQ8bdyWXQS7s82JHCS2d8js20WwdPkyvOKS2dUu/jm+Hq?=
 =?us-ascii?Q?fkMFLU93cnUrycsMz/L6kQNeHzcXz/7/DN5ef3SzRpfUtIoPsdfOJreXfzqk?=
 =?us-ascii?Q?R7dt6VPN2hEFbSx7h4oYXLYZWzWtzyEDA1l3/cBXRiTLLWqH3X8msJ+fIEXH?=
 =?us-ascii?Q?zt9eK6vVvZM77t6LVdFd51NOOe/Z8e+gSWJ80GMeGUg5xzI5EVhpH9X0NbNI?=
 =?us-ascii?Q?rXKeVjAYwoEIoKBC+Kmyh9NwIDohGOqM5JMDG4I+Sh71GoeCdiIKMP+VzEr2?=
 =?us-ascii?Q?kXd3eMmWb/oJue6ylPankQvnw/t1XT/GfuYKKA/KzvhISKzguklsizuXz9ln?=
 =?us-ascii?Q?HKcLjO395t8/r7P9iaTGfTnsxKi1OlvoV5b12pmT7NiEzMQqqf6ZSWisM1vC?=
 =?us-ascii?Q?FVSebN+9Yeevj8ZGVI5XPKLCycxmvYKJc7Z8SFt4dOOExB/vTKgWygU1j/ph?=
 =?us-ascii?Q?RuFxIio3+FDRI9y2/0+UuDJgxmpD605PxWzusPjWFEhi16GiiZaiBqEqrLMz?=
 =?us-ascii?Q?ICnFgFIRocGGrNdEx6JNQJsuTp0mYVC8QamvNUgJ82k1z+vBg0kMoP4P5/cf?=
 =?us-ascii?Q?PUzXjkzhU/LL+jfE7/5Dhnc1LW9eesYRgwd91oDcw9oDXRMIp7hxSuIedBwL?=
 =?us-ascii?Q?Rhzmu+9oiehUvr/85GxD1YQzJfLTD9hLopQFnPy0G3unfew24T7eRQl+9NRF?=
 =?us-ascii?Q?yQCK6qQilrYeGJBqm7DpXEw2nzqoO5PMsY2lyk/wf/PbNHKVFoYJGcoJdenn?=
 =?us-ascii?Q?btKI6g7eJgI1l6ZyLlzgW8C+TCATUSNmFKuT2tdtXj8WduzHVKad2vj8QrtW?=
 =?us-ascii?Q?4YiczvALuF1PsEOP6gzZg0AbW9ufbC9xgx4PhKzobNaMiIg5sjonrNXXDxq8?=
 =?us-ascii?Q?HNQgOsc4vwOqvJyAqbvqv3nPBjPURenRVc9EilUg0S5e2dpbczh1rUaCeC8I?=
 =?us-ascii?Q?MTzl5ClcT4PRp2k5An5k4s/s6jY/Z2noHK/LYTyCed/603V9ysg+zfyRR3zW?=
 =?us-ascii?Q?I0x+xhUXMDT7bZC+n9tkXL43YllbyGqAN2Gd1Iroz5vQmEi24KxjTLPJSXOG?=
 =?us-ascii?Q?f0sowISEK/C6opxQ38dh3YoRkbSzbUodVFFmG+DH7mUy9d87IZd5+2SqOE9J?=
 =?us-ascii?Q?ihFXisLhxvaxZf+9FZrvp9Z51PJflT7ooSobw467cSnwLt7mif/Oun24M86i?=
 =?us-ascii?Q?7KAVZwMXT/vV+0hdI67gDzUuF3YCN0oIO4NUjmSPRaDNX+g6aCOCIL5B826y?=
 =?us-ascii?Q?6zA/9/D/fiU7iEXLztPzhuaMGvevr5LeRDeCNt6f26Tua5jYWhzOD9EXHELD?=
 =?us-ascii?Q?o37zrL2nmw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c85b50-b7e5-4406-9d55-08deb507db05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:04:07.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRPf4I4qRbnW9wGC8BMpicpBYfpZ7N6LkFmxPF+FlVdjuf7VUZZ+77jp6nIrJzvxUcxInXnKyN/nWUxl6is8fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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

Introduce GpuMm as the centralized GPU memory manager. At this point in
the series, GpuMm only owns the PRAMIN window for direct VRAM access;
the buddy allocator and TLB manager are added later when those backing
types become available.

This provides a clean ownership model where GpuMm provides accessor
methods for its components that can be used for memory management
operations, and lets follow-on patches (such as the PRAMIN aperture
self-tests) reference `self.mm.pramin()` cleanly.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 22 +++++++++++++++++
 drivers/gpu/nova-core/mm.rs  | 46 ++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index d9d1a7417a2e..38544c38d660 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -25,6 +25,10 @@
         commands::GetGspStaticInfoReply,
         Gsp, //
     },
+    mm::{
+        GpuMm,
+        IntoVramRange, //
+    },
     regs,
 };
 
@@ -261,6 +265,8 @@ pub(crate) struct Gpu {
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<Sec2Falcon>,
+    /// GPU memory manager owning memory management resources.
+    mm: Arc<GpuMm>,
     /// GSP runtime data. Temporarily an empty placeholder.
     #[pin]
     gsp: Gsp,
@@ -306,6 +312,22 @@ pub(crate) fn new<'a>(
                     );
                 })?,
 
+            // Create GPU memory manager owning memory management resources.
+            mm: {
+                // PRAMIN covers all physical VRAM (including GSP-reserved areas
+                // above the usable region, e.g. the BAR1 page directory).
+                let pramin_vram_region = (0..gsp_static_info.total_fb_end).into_vram_range();
+                Arc::pin_init(
+                    GpuMm::new(
+                        devres_bar.clone(),
+                        pdev.as_ref(),
+                        spec.chipset,
+                        pramin_vram_region,
+                    )?,
+                    GFP_KERNEL,
+                )?
+            },
+
             bar: devres_bar,
         })
     }
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index f425467281d3..5c1941d20d1b 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -2,7 +2,7 @@
 
 //! Memory management subsystems for nova-core.
 
-#![expect(dead_code)]
+#![allow(dead_code)]
 
 /// Implements `From` conversions between a frame-number type and `Bounded<u64, N>`.
 ///
@@ -37,10 +37,52 @@ macro_rules! impl_pfn_bounded {
 
 use kernel::{
     bitfield,
+    device,
+    devres::Devres,
     num::Bounded,
-    prelude::*, //
+    prelude::*,
+    sync::Arc, //
 };
 
+use crate::{
+    driver::Bar0,
+    gpu::Chipset, //
+};
+
+/// GPU Memory Manager - owns all core MM components.
+///
+/// Provides centralized ownership of memory management resources:
+/// - [`pramin::Pramin`] for direct VRAM access.
+#[pin_data]
+pub(crate) struct GpuMm {
+    #[pin]
+    pramin: pramin::Pramin,
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
+        chipset: Chipset,
+        pramin_vram_region: Range<VramAddress>,
+    ) -> Result<impl PinInit<Self>> {
+        let pramin_init = pramin::Pramin::new(bar, dev, chipset, pramin_vram_region)?;
+
+        Ok(pin_init!(Self {
+            pramin <- pramin_init,
+        }))
+    }
+
+    /// Access the [`pramin::Pramin`].
+    pub(crate) fn pramin(&self) -> &pramin::Pramin {
+        &self.pramin
+    }
+}
+
 bitfield! {
     /// Physical VRAM address in GPU video memory.
     pub(crate) struct VramAddress(u64) {
-- 
2.34.1

