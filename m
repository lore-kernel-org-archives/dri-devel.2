Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C43FCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E4B10E983;
	Mon, 18 May 2026 18:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DjDXsJj7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1391010E983
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtcXk4bXiIO7C21q3m5z0w7JERuhuOg7QUstUD7WCGdWTWem/rIfJEKJZ50m4CbOPzl2duUy0V+sGv2w4ahi0Up90lOySot5YoxpOaCMDtLc0VcQ1sWmlFi+yytQ4mNbQ7Od6EvES61mtZFwaN+mQpCVhB8vVt44Jz7v2c4vVkdocLWaP2WXx7KpLwjweQWDJNEP/3WsS5GmJ4adNd3TD+I3T+3T07rBbeIPIYmfxGVNc4mRYTfy7o5jY/Nnn9ZIiy5RCb8qvcXByzx2JyFmILPoO1ZjK+Vbe21iBDoX2AFOX+LNzuJrBvPnWuQypdjy4tTgNs28mfHDWarBrY62IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcmHqh+sfCiW26fyVek/N/pz6fMFcmQVfdoiGw99cTg=;
 b=XslubChKwUfYUJlqTBpETwaNGKdRhW/xPPvggYJceaHJC2ZZvTtestJ3/GAp43YIUqFH/q/KP3FKTi3+ZnrX39EYTR06oTnC8xkvkVg3rLzuod/oTgjycyNy+n0PEo7zN3zx6yZlSxrq2UP1ub7sqWMJCnKsew2Hkd3jRzNufm4RhoZ6knQ5pIqupd8HBZlsZuXTtbVUy9J+kFQTX3s9EUxC+LwPjD16Zu6scw4Cvimoe1nzHMWyjahUjy+bTJz66mAaS4i9QienLUrWWSue8wA08Ss3VKvrPGDY+kdNu+4XOW390oaKS8so+kyFJ5lxUOTAoSo5MJF8t8xLb+7/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcmHqh+sfCiW26fyVek/N/pz6fMFcmQVfdoiGw99cTg=;
 b=DjDXsJj7qC9KPao2aK8njY3/67S2rtxcuJskthrqott1patiqPvzRalnJzApn9w2kc3oNdVqNksebp/spisKrO3crEnRRYGylurvdWNzYxc8idaYvatjVd/o2eRUEHJET3dz8ot1rBwNNCkmShOlJJ+pIPQnQfYTVa1FFh3tT4zsZlE6PCNxwqklVXETByJSfh9OcI5TVflmGNvR5LscsLxnHflivycf/nUcHV4h6j3Kbh5A96mAfmXgO1Gn4FcFzxaEetM1ssGoCX8yVwu5x4nf1/dFjXoxG0WKiHp/tQQFNkeiTKzsBe++vdpIiMwKCAcODvLPEMZ/o7R7biLi5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:03:59 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:03:59 +0000
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
Subject: [PATCH v1 09/12] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Date: Mon, 18 May 2026 14:03:39 -0400
Message-Id: <20260518180342.2387845-10-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:32b::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: c707cbba-0f40-4dfd-bd23-08deb507d59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|22082099003|56012099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: jZbyx3Q15ym2PBv1wMDyyunZvMuxFDZBLcsWv6fjxXAHV07vDDMhbrV1Nxv0OXMt0hV4LsBEQCm2Zbm04s9RX5tCBfBaRd3lbKFzOmt0OZkJNZImJexSOfSxxC+ZevdBWKWiWrGv865JAXch4C4ennb0caftQN3+TJubmGXeD0ZuKcPQPbCSAb7hO8Zy/LeiP3EO32QHxJW400gD2Q5kLo2KMraRFj0Lx3ddqowMWktxjq5qW+ZlQ2dYa0H711RVPQLUMxLEyqRlBbdYnt2BqEYZbpWxBZWwgCLlbxp4ILkBRAGhc6vYrIPy8SL/ZyNOoK2LRlGYbNSo1hWQb9dZXMP+yWobVs587gI6SK5RABkAGTXTIMqH3HwQmofYAkhbpz2d0rHjuUWk9vdk1rYX/AxMoDGW/Djjb082ruh1C4B/sRqZ2I0znXrOqFQj/rLb43sBFhEwEYfU6fUyedV8Nr62avxkZqZb8BsVZKoMjqdvRBeAygTbW0OeWE8Pj0eTMreixwWHdTSy3Bi9tuYdVVTM9CVB2BKS6d0mnsICU4ThHWGzSeHrENqRuMXO7nuDhyyn99QfmJ3pO31022BQJXPUWmTJ+vhzorh5Yl9pRuIEKd0PXrPeZgqh8k8oDl6XyrNs5Xa2KcvflG4uQHg4fUFsR8Zf+o6SQUnLHbWgEqrqux9Bhb+ub3lfoNAVDcSC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(56012099003)(18002099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?doYigDxeTJgFNWQtjHInITNdW/sX9ZRrVy6jrcNtrG/TY4oo78wM09et131N?=
 =?us-ascii?Q?YuEk8g1JW9rXPga1EpO/INKPhqJpexj1arUz7zBvU+8zDzJM7U5tozjq+4fu?=
 =?us-ascii?Q?xWF0ei/uq8OuI8iOnAoLbDHuKNs9YfpMhRuKJrWGsEWLPCgDkA7fRFAbjjQ4?=
 =?us-ascii?Q?1pCDqeWN5BTbcHgeLrZRQYOv1fbnR09/wztoHKvstuLdLRGd7wb1fBp+Z1bx?=
 =?us-ascii?Q?KtbtjN0MdgkqYAaCibULn1oRfrQWEqF3mzXzG3DiPAa6XkBNZuZeSBBhspam?=
 =?us-ascii?Q?AwjTA30rb/w3jQ2xw7Vjx4FhdpPO+24fX5vjXucAX9LSj0l8hG99gm2eNdIF?=
 =?us-ascii?Q?Znmb/rUS+1e0JNMCGbHsNycQeXjIJ9OResciIGwuBfBGBndMdU/4jDa4msMK?=
 =?us-ascii?Q?czBldBTS/eRh6GVC3mdb9aY2IdWlIfYAPtMx9DbMJHE8qmSkF7Nw43vswXyC?=
 =?us-ascii?Q?gf0O398kMfaQG+vKBPx0ZTgOmhm8nUASStUrDQJEzA3mugijxoQuWEPrH+FC?=
 =?us-ascii?Q?YYBRpLn3MSSIHbifmNQPQFnx5p+Cx5uZJAeA4i6bTrm+dTvB+psOn0gJeDvx?=
 =?us-ascii?Q?gkFCvtnRq+zGGtqmslmmlMLg8j1uOZKsr4GAtOfEe0umsnXHrac2wlsJeF/t?=
 =?us-ascii?Q?BhQoWbJeyeEFjQL71HJPF8gpRAD5iaPTvuN5t0L2grJzTAyNZ3v5roJOIwfL?=
 =?us-ascii?Q?5OYWKMpg5xZgzZ1EH0HVmpledC4hw8MVSrSAIDX6s/vHm4XMI4gR/7+MEyiZ?=
 =?us-ascii?Q?yHfrqqGCzCBwVIJzLz0WpGR9Uo+H/i2iZpDpK7+tpkIBpOycTufU3CtgLlDe?=
 =?us-ascii?Q?L0NdI8UEUo3hlfZRBb3YE0Fp7aPAJrGZZp+SEXvkBYOEoQYoFqrThC3MAAwF?=
 =?us-ascii?Q?nM3SFsbmPLfgdu2tqYvjXTF1/1VnE1WahVS3Mu9aB0ooJyeZ0n26DMBLKT7h?=
 =?us-ascii?Q?5BU9MTaq0c0vmPr/Hj+DThQncAFKQAAWrnVKKr71GFwsR42mEI4pvEQzVE1V?=
 =?us-ascii?Q?7YZQuIePPvtpw0jRXgv3x83yJgaw8fmCABoGzNqHBz1J5BkwQeYtLOi9BU9L?=
 =?us-ascii?Q?QBicyL0e41f2nzoK4TRIWuPXKbHNx/tAjtrwsO0/mdLb2IpFfFCQKOAY4tHV?=
 =?us-ascii?Q?Pc4BN9jnnI7onfA+E/vyQJ3HgEOa3gkpJxaLWRTvZMFEarTcSX+ys6GqjPFQ?=
 =?us-ascii?Q?YVUk1BrYxcba9D4bUeOBTIwdBvqnzCQzKxOfYAZFyc+YZ/iWq29RNoApUavn?=
 =?us-ascii?Q?1Cgbpic7t4PXVLVszsMgtAp+HyBIusONAv7s0yzepADsVKQA207fQFj4OIlQ?=
 =?us-ascii?Q?lIHcaC8y7JaZQQOQ1UfToEAug0YKtOn3oP8zzTx/zs1qrzVbPytJYY58wu1I?=
 =?us-ascii?Q?+/wzz+pZ0CALkEy1DjHg0Uz5Plcm3FKrB3ziqxg0pGJ2h3pCiQ3AgPgMUsCX?=
 =?us-ascii?Q?8WXmRUOwpwjYys6WpAtyh+u6VGHL9x3MeZcjvZgek4trF49IW+OdIOLo9kRU?=
 =?us-ascii?Q?U73tdAdHQgbrYsAdJ69tv7bxTjYUuJynvnc+cOJTIF9Wkm7eL8Muh8dTiUH8?=
 =?us-ascii?Q?AOSU6OjFTLImY3Q8FlAFalc3BUneoug2Yj8R4B9ZrpjJ4dwLOcdIIv8Jc+RP?=
 =?us-ascii?Q?khh4YrdQSqtImPFv8DwXCHuN1+FPS9mAdLX+Sz8+IlFqeBLhMy3z4MYu5MP9?=
 =?us-ascii?Q?3XqeQ3aCwyPdrPMuoX20ARHSQIsv5fYs7kwx+Ej/NXob+Zn79CLxyDoD5Orm?=
 =?us-ascii?Q?h6Lx+1CGtA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c707cbba-0f40-4dfd-bd23-08deb507d59a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:03:58.8988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNyA7Vod7bOmIrCK6Pc7fczcpslHkMZhY4Ds5wQjHtM0jHfZV/GgnikikW1XsujOw46GaYGdjsWpRx5RhD9ByA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

PRAMIN apertures are a crucial mechanism for direct CPU read/write to
VRAM. Add support for PRAMIN windows on all supported GPU architectures:
Turing, Ampere, Ada (via `NV_PBUS_BAR0_WINDOW`), Hopper (via
`gh100::NV_XAL_EP_BAR0_WINDOW`), and Blackwell (via
`gb100::NV_XAL_EP_BAR0_WINDOW`). Architecture-dispatched
`pramin_window_{read,write}_base()` helpers in `regs.rs` encapsulate the
per-arch register selection.

Hopper/Blackwell window-base dispatch is based on Eliot Courtney's
offlist reference patch.

Cc: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs        |   2 +
 drivers/gpu/nova-core/mm/pramin.rs | 298 +++++++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs |   1 +
 drivers/gpu/nova-core/regs.rs      | 122 ++++++++++++
 4 files changed, 423 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm/pramin.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 3bc9befab397..f425467281d3 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -31,6 +31,8 @@ macro_rules! impl_pfn_bounded {
     };
 }
 
+pub(crate) mod pramin;
+
 use core::ops::Range;
 
 use kernel::{
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
new file mode 100644
index 000000000000..38758ca971be
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct VRAM access through the PRAMIN aperture.
+//!
+//! PRAMIN provides a 1MB sliding window into VRAM through BAR0, allowing the CPU to access
+//! video memory directly. Access is managed through a two-level API:
+//!
+//! - [`Pramin`]: The parent object that owns the BAR0 reference and synchronization lock.
+//! - [`PraminWindow`]: A guard object that holds exclusive PRAMIN access for its lifetime.
+//!
+//! The PRAMIN aperture is a 1MB region at a fixed offset from BAR0. The window base is
+//! controlled by an architecture-specific register and is 64KB aligned.
+//!
+//! # Examples
+//!
+//! ## Basic read/write
+//!
+//! ```no_run
+//! use crate::driver::Bar0;
+//! use crate::gpu::Chipset;
+//! use crate::mm::{pramin, VramAddress};
+//! use kernel::device;
+//! use kernel::devres::Devres;
+//! use kernel::prelude::*;
+//! use kernel::sync::Arc;
+//!
+//! fn example(
+//!     devres_bar: Arc<Devres<Bar0>>,
+//!     dev: &device::Device<device::Bound>,
+//!     chipset: Chipset,
+//!     vram_region: core::ops::Range<VramAddress>,
+//! ) -> Result<()> {
+//!     let pramin = Arc::pin_init(
+//!         pramin::Pramin::new(devres_bar, dev, chipset, vram_region)?,
+//!         GFP_KERNEL,
+//!     )?;
+//!     let mut window = pramin.get_window(dev)?;
+//!
+//!     // Write and read back.
+//!     window.try_write32(0x100u64, 0xDEADBEEF)?;
+//!     let val = window.try_read32(0x100u64)?;
+//!     assert_eq!(val, 0xDEADBEEF);
+//!
+//!     Ok(())
+//! }
+//! ```
+//!
+//! ## Auto-repositioning across VRAM regions
+//!
+//! ```no_run
+//! use crate::driver::Bar0;
+//! use crate::gpu::Chipset;
+//! use crate::mm::{pramin, VramAddress};
+//! use kernel::device;
+//! use kernel::devres::Devres;
+//! use kernel::prelude::*;
+//! use kernel::sync::Arc;
+//!
+//! fn example(
+//!     devres_bar: Arc<Devres<Bar0>>,
+//!     dev: &device::Device<device::Bound>,
+//!     chipset: Chipset,
+//!     vram_region: core::ops::Range<VramAddress>,
+//! ) -> Result<()> {
+//!     let pramin = Arc::pin_init(
+//!         pramin::Pramin::new(devres_bar, dev, chipset, vram_region)?,
+//!         GFP_KERNEL,
+//!     )?;
+//!     let mut window = pramin.get_window(dev)?;
+//!
+//!     // Access first 1MB region.
+//!     window.try_write32(0x100u64, 0x11111111)?;
+//!
+//!     // Access at 2MB - window auto-repositions.
+//!     window.try_write32(0x200000u64, 0x22222222)?;
+//!
+//!     // Back to first region - window repositions again.
+//!     let val = window.try_read32(0x100u64)?;
+//!     assert_eq!(val, 0x11111111);
+//!
+//!     Ok(())
+//! }
+//! ```
+
+#![expect(unused)]
+
+use core::ops::Range;
+
+use crate::{
+    bounded_enum,
+    driver::Bar0,
+    gpu::Chipset,
+    mm::VramAddress,
+    num::IntoSafeCast,
+    regs, //
+};
+
+use kernel::{
+    device,
+    devres::Devres,
+    io::Io,
+    new_mutex,
+    prelude::*,
+    sizes::{
+        SZ_1M,
+        SZ_64K, //
+    },
+    sync::{
+        lock::mutex::MutexGuard,
+        Arc,
+        Mutex, //
+    },
+};
+
+bounded_enum! {
+    /// Target memory type for the BAR0 window register.
+    ///
+    /// Only VRAM is supported; Hopper+ GPUs do not support other targets.
+    #[derive(Debug)]
+    pub(crate) enum Bar0WindowTarget with TryFrom<Bounded<u32, 2>> {
+        /// Video RAM (GPU framebuffer memory).
+        Vram = 0,
+    }
+}
+
+/// PRAMIN aperture base offset in BAR0.
+const PRAMIN_BASE: usize = 0x700000;
+
+/// PRAMIN aperture size (1MB).
+const PRAMIN_SIZE: usize = SZ_1M;
+
+/// Generate a PRAMIN read accessor that takes an absolute VRAM address.
+///
+/// `$name` matches the underlying [`Bar0`] method (e.g. `try_read32`).
+macro_rules! define_pramin_read {
+    ($name:ident, $ty:ty) => {
+        #[doc = concat!("Read a `", stringify!($ty), "` from VRAM at the given address.")]
+        pub(crate) fn $name(&mut self, vram_addr: impl Into<VramAddress>) -> Result<$ty> {
+            let (bar_offset, new_base) =
+                self.compute_window(vram_addr.into(), ::core::mem::size_of::<$ty>())?;
+
+            if let Some(base) = new_base {
+                regs::pramin_window_write_base(self.chipset.arch(), self.bar, base)?;
+                *self.state = base;
+            }
+            self.bar.$name(bar_offset)
+        }
+    };
+}
+
+/// Generate a PRAMIN write accessor that takes an absolute VRAM address.
+///
+/// `$name` matches the underlying [`Bar0`] method (e.g. `try_write32`).
+macro_rules! define_pramin_write {
+    ($name:ident, $ty:ty) => {
+        #[doc = concat!("Write a `", stringify!($ty), "` to VRAM at the given address.")]
+        pub(crate) fn $name(&mut self, vram_addr: impl Into<VramAddress>, value: $ty) -> Result {
+            let (bar_offset, new_base) =
+                self.compute_window(vram_addr.into(), ::core::mem::size_of::<$ty>())?;
+
+            if let Some(base) = new_base {
+                regs::pramin_window_write_base(self.chipset.arch(), self.bar, base)?;
+                *self.state = base;
+            }
+            self.bar.$name(value, bar_offset)
+        }
+    };
+}
+
+/// PRAMIN aperture manager.
+///
+/// Call [`Pramin::get_window()`] to acquire exclusive PRAMIN access.
+#[pin_data]
+pub(crate) struct Pramin {
+    bar: Arc<Devres<Bar0>>,
+    chipset: Chipset,
+    /// Valid VRAM region. Accesses outside this range are rejected.
+    vram_region: Range<VramAddress>,
+    /// PRAMIN aperture state, protected by a mutex.
+    ///
+    /// # Invariants
+    ///
+    /// This lock is acquired during the DMA fence signaling critical path.
+    /// It must NEVER be held across any reclaimable CPU memory / allocations
+    /// (`GFP_KERNEL`), because the memory reclaim path can call
+    /// `dma_fence_wait()`, which would deadlock with this lock held.
+    #[pin]
+    state: Mutex<VramAddress>,
+}
+
+impl Pramin {
+    /// Create a pin-initializer for PRAMIN.
+    ///
+    /// `vram_region` specifies the valid VRAM address range.
+    pub(crate) fn new(
+        bar: Arc<Devres<Bar0>>,
+        dev: &device::Device<device::Bound>,
+        chipset: Chipset,
+        vram_region: Range<VramAddress>,
+    ) -> Result<impl PinInit<Self>> {
+        let bar_access = bar.access(dev)?;
+        let current_base = regs::pramin_window_read_base(chipset.arch(), bar_access);
+
+        Ok(pin_init!(Self {
+            bar,
+            chipset,
+            vram_region,
+            state <- new_mutex!(current_base, "pramin_state"),
+        }))
+    }
+
+    /// Returns the valid VRAM region for this PRAMIN instance.
+    fn vram_region(&self) -> &Range<VramAddress> {
+        &self.vram_region
+    }
+
+    /// Acquire exclusive PRAMIN access.
+    ///
+    /// Returns a [`PraminWindow`] guard that provides VRAM read/write accessors.
+    /// The [`PraminWindow`] is exclusive and only one can exist at a time.
+    pub(crate) fn get_window<'a>(
+        &'a self,
+        dev: &'a device::Device<device::Bound>,
+    ) -> Result<PraminWindow<'a>> {
+        let bar = self.bar.access(dev)?;
+        let state = self.state.lock();
+        Ok(PraminWindow {
+            bar,
+            chipset: self.chipset,
+            vram_region: self.vram_region.clone(),
+            state,
+        })
+    }
+}
+
+/// PRAMIN window guard for direct VRAM access.
+///
+/// This guard holds exclusive access to the PRAMIN aperture. The window auto-repositions
+/// when accessing VRAM offsets outside the current 1MB range.
+///
+/// Only one [`PraminWindow`] can exist at a time per [`Pramin`] instance (enforced by the
+/// internal `MutexGuard`).
+pub(crate) struct PraminWindow<'a> {
+    bar: &'a Bar0,
+    chipset: Chipset,
+    vram_region: Range<VramAddress>,
+    state: MutexGuard<'a, VramAddress>,
+}
+
+impl PraminWindow<'_> {
+    /// Compute window parameters for a VRAM access.
+    ///
+    /// Returns (`bar_offset`, `new_base`) where:
+    /// - `bar_offset`: The BAR0 offset to use for the access.
+    /// - `new_base`: `Some(base)` if window needs repositioning, `None` otherwise.
+    fn compute_window(
+        &self,
+        vram_addr: VramAddress,
+        access_size: usize,
+    ) -> Result<(usize, Option<VramAddress>)> {
+        // Validate VRAM address is within the valid VRAM region.
+        let end_addr = vram_addr.checked_add(access_size).ok_or(EINVAL)?;
+        if vram_addr < self.vram_region.start || end_addr > self.vram_region.end {
+            return Err(EINVAL);
+        }
+
+        // Check if access fits within the current 1MB window.
+        let current_base = *self.state;
+        if vram_addr >= current_base {
+            let offset_within: usize = (vram_addr - current_base).into_safe_cast();
+            if offset_within + access_size <= PRAMIN_SIZE {
+                return Ok((PRAMIN_BASE + offset_within, None));
+            }
+        }
+
+        // Access doesn't fit in current window - reposition.
+        // Hardware requires 64KB alignment for the window base register.
+        let needed_base = vram_addr.align_down(SZ_64K as u64);
+        let offset_within: usize = (vram_addr - needed_base).into_safe_cast();
+
+        // Verify access fits in the 1MB window from the new base.
+        if offset_within + access_size > PRAMIN_SIZE {
+            return Err(EINVAL);
+        }
+
+        Ok((PRAMIN_BASE + offset_within, Some(needed_base)))
+    }
+
+    define_pramin_read!(try_read8, u8);
+    define_pramin_read!(try_read16, u16);
+    define_pramin_read!(try_read32, u32);
+    define_pramin_read!(try_read64, u64);
+
+    define_pramin_write!(try_write8, u8);
+    define_pramin_write!(try_write16, u16);
+    define_pramin_write!(try_write32, u32);
+    define_pramin_write!(try_write64, u64);
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 38b8aeb750ba..8bff10dbf327 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -16,6 +16,7 @@
 mod firmware;
 mod gpu;
 mod gsp;
+mod mm;
 #[macro_use]
 mod num;
 mod regs;
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 6faeed73901d..fb42d96a59b2 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -6,6 +6,10 @@
         register::WithBase,
         Io, //
     },
+    num::{
+        Bounded,
+        TryIntoBounded, //
+    },
     prelude::*,
     sizes::SizeConstants,
     time, //
@@ -31,6 +35,10 @@
         Architecture,
         Chipset, //
     },
+    mm::{
+        pramin::Bar0WindowTarget,
+        VramAddress, //
+    },
 };
 
 // PMC
@@ -115,6 +123,15 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
     }
 }
 
+register! {
+    /// BAR0 window control for PRAMIN access.
+    pub(crate) NV_PBUS_BAR0_WINDOW(u32) @ 0x00001700 {
+        25:24   target ?=> Bar0WindowTarget;
+        /// PRAMIN window base byte address (40-bit FB addr; bits 39:16 stored in 23:0).
+        23:0    window_base as Bounded<u64, 40> shl 16;
+    }
+}
+
 // PFB
 
 register! {
@@ -537,3 +554,108 @@ pub(crate) mod ga100 {
         }
     }
 }
+
+pub(crate) mod gh100 {
+    use kernel::io::register;
+
+    register! {
+        /// Hopper register for PRAMIN window.
+        pub(crate) NV_XAL_EP_BAR0_WINDOW(u32) @ 0x0010_fd40 {
+            /// PRAMIN window base byte address (38-bit FB addr; bits 37:16 stored in 21:0).
+            21:0    window_base as Bounded<u64, 38> shl 16;
+        }
+    }
+}
+
+pub(crate) mod gb100 {
+    use kernel::io::register;
+
+    register! {
+        /// Blackwell+ register for PRAMIN window.
+        pub(crate) NV_XAL_EP_BAR0_WINDOW(u32) @ 0x0010_fd40 {
+            /// PRAMIN window base byte address (39-bit FB addr; bits 38:16 stored in 22:0).
+            22:0    window_base as Bounded<u64, 39> shl 16;
+        }
+    }
+}
+
+/// Common interface for all PRAMIN window registers across GPU architectures.
+pub(crate) trait PraminWindow {
+    /// Reads the current PRAMIN window base address from this register.
+    fn read_base(bar: &Bar0) -> VramAddress;
+
+    /// Writes a new PRAMIN window base address into this register.
+    fn write_base(bar: &Bar0, base: VramAddress) -> Result;
+}
+
+impl PraminWindow for NV_PBUS_BAR0_WINDOW {
+    fn read_base(bar: &Bar0) -> VramAddress {
+        VramAddress::new(bar.read(NV_PBUS_BAR0_WINDOW).window_base().into())
+    }
+
+    fn write_base(bar: &Bar0, base: VramAddress) -> Result {
+        let bounded: Bounded<u64, 40> = base.raw().try_into_bounded().ok_or(EINVAL)?;
+        bar.write_reg(
+            NV_PBUS_BAR0_WINDOW::zeroed()
+                .with_target(Bar0WindowTarget::Vram)
+                .with_window_base(bounded),
+        );
+        Ok(())
+    }
+}
+
+impl PraminWindow for gh100::NV_XAL_EP_BAR0_WINDOW {
+    fn read_base(bar: &Bar0) -> VramAddress {
+        VramAddress::new(bar.read(gh100::NV_XAL_EP_BAR0_WINDOW).window_base().into())
+    }
+
+    fn write_base(bar: &Bar0, base: VramAddress) -> Result {
+        let bounded: Bounded<u64, 38> = base.raw().try_into_bounded().ok_or(EINVAL)?;
+        bar.write_reg(gh100::NV_XAL_EP_BAR0_WINDOW::zeroed().with_window_base(bounded));
+        Ok(())
+    }
+}
+
+impl PraminWindow for gb100::NV_XAL_EP_BAR0_WINDOW {
+    fn read_base(bar: &Bar0) -> VramAddress {
+        VramAddress::new(bar.read(gb100::NV_XAL_EP_BAR0_WINDOW).window_base().into())
+    }
+
+    fn write_base(bar: &Bar0, base: VramAddress) -> Result {
+        let bounded: Bounded<u64, 39> = base.raw().try_into_bounded().ok_or(EINVAL)?;
+        bar.write_reg(gb100::NV_XAL_EP_BAR0_WINDOW::zeroed().with_window_base(bounded));
+        Ok(())
+    }
+}
+
+/// Reads the current BAR0 PRAMIN window base address, dispatching to the
+/// register variant appropriate for `arch`.
+pub(crate) fn pramin_window_read_base(arch: Architecture, bar: &Bar0) -> VramAddress {
+    match arch {
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada => {
+            NV_PBUS_BAR0_WINDOW::read_base(bar)
+        }
+        Architecture::Hopper => gh100::NV_XAL_EP_BAR0_WINDOW::read_base(bar),
+        Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+            gb100::NV_XAL_EP_BAR0_WINDOW::read_base(bar)
+        }
+    }
+}
+
+/// Writes a new BAR0 PRAMIN window base address, dispatching to the register
+/// variant appropriate for `arch`.
+pub(crate) fn pramin_window_write_base(
+    arch: Architecture,
+    bar: &Bar0,
+    base: VramAddress,
+) -> Result {
+    match arch {
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada => {
+            NV_PBUS_BAR0_WINDOW::write_base(bar, base)
+        }
+        Architecture::Hopper => gh100::NV_XAL_EP_BAR0_WINDOW::write_base(bar, base),
+        Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+            gb100::NV_XAL_EP_BAR0_WINDOW::write_base(bar, base)
+        }
+    }
+}
-- 
2.34.1

