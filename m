Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5FAFF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8228310E488;
	Sat, 25 Apr 2026 21:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hrkWhH6j";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6123A10E486
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRsL9FZRKcUdCM7QpX3UzPNzy1rLOdl+vB6AE5+DOKyzDpMOKIXMPZV+yubrNwisd6Ed8fNetd0da9l20U3AutwWnWnvPf+pPPnJMCaWghwab+3/6jMQTrlvcnNvjjazyMZbdi8ku3NnC/Cp+Gw8/NglG3C7663GAWjPilUmJ97EvOzZcjJfvwDuulG4ozqFUZB73XhDud3TIEm0VPPn+YfI2ZGC/Cmr83IqBvOWG1d1Q3hUQSw2EZFOh9J59I/Zsu83ao8xlOoVUDv1gxMPIITD4QBLx834StCTIouAr4ygyi8xBnuNp/H3d7jD73Wy7doCUkfdBXkVAQjlp0tJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmVldFq0qhGn/M73Rg4eTp4X43//KX29nNlyJJKjXvE=;
 b=beWig5wB+shMlB0ZFl1FOkVo8rDzrrGlH2YjSOBTjNZ2kILDOm2Y6/RgSkdHFIuCACVFLHV4rKYcZv17toc5rktUlw3kr0KdlSmWP/vchRHYLk3VnYcHcd691cbU88OysnUUj32qm5FiZ1gBPT6kOrubUPKPAHCFPshwkjmKqBDNn0nBbvnm26mXPSCQv0WjoHlhbinbV4KncsNb9paKUfLbGsLMa7yKRihAvwjD+auqNIgkjeJYrVh3qyb+2LmuxNt2DKmn4KXupc5PBvZHwEhYEBa+QNSzcTVMbUxgAOK+V6Tu6w4QYJSqZBOMR8JEpJLUDzmWkkmjFCr/7KcAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmVldFq0qhGn/M73Rg4eTp4X43//KX29nNlyJJKjXvE=;
 b=hrkWhH6j6dbDktUwtoim03erfrwb6EhnCqWA6ZHZxitFsuDhI2aoJg1c1sj69IyvQB8q7rUdDmrRjidy9dq5gnHg1bzpgLmiQv5Sp4hQ1iBuIf3DaSYHyymrTXEJDefIb0GZV1cH8rwT0Sx5Yxgxu1s6Q4OjGfknekVj+3AGZvfLGdqjKqDgXU77xWWMDjiCabUeI419+2zk1hkANfaEaQQA41lA0ed30GYoKFkB4ArakUAmSIM4qYKWl1LWbBbTju02o+DqYHwbxSIOzH4QgxASkwH+lGq3ctvuA6aZlPt+u9DKtLz/752HtE4KWhgqOVt6IcRvTGwJxLVF/jH3og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:17 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:17 +0000
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
Subject: [PATCH v12 04/22] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Date: Sat, 25 Apr 2026 17:14:36 -0400
Message-Id: <20260425211454.174696-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0250.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7abfe1-377a-428a-7bc4-08dea30fbfa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003|11006099003;
X-Microsoft-Antispam-Message-Info: apXJXkfakTcR8uVYIm5B7ei6bwWZNDNHykzzjZgJzQFDeCO0tyx0hjGwJaMaVBfsROTC0hToiA9oaQ3WWcWFtzyR+W8WVJgL1EmtGtK0EX8hwPyBIYMBGjL8xs6rqub8cBWMeNzp5mBy4ZJTYKS036SqlQ5MfF8ukHWfDe05VN9T0ba7JVqHn8p/+t2I0BTZQS5ZxHXvNNHCw1voK5q+Ono5F8zgMSHmV0zu8REVk7penj51zogFSoFA1Cv9ngisE95pzxkyJm4EiOKpc3ngMHlHLTofz/uazcfMu9KFONtsLDiQpJwqxHPscq/wT0gOpE8EZ7+gkQGc5O8Yie1niIjvCrKK9cnnmJCZbcAuSDy7hf7kbJK3POY6csSX4DR7oq5Lj14liElQ4SBDcy+hk9G42n2pe0fR/smpsT80NOb7dlis48MHw7ZZ/A83ze0fzMf+2EfuM/88s9a5ZItCVZghICFIT/PYo1vNFUFVddghw7zl4dFO/Z+4CM29RqMgsXt8Q/JIB1Etr0B/rdUPBNDVZA2ObD6kUB64HKdmj8ZCYvXx+8EJdt8f2nT58hPVHS3cRd7kYekaPj9dDB/2wJhwEI+Ek44/MLqjsngVFcn6cx0e7aPXf+Ii1YuiKlqb4cYsHP27/hyGpRGHGBsUtf0dNDSAJRiX7BWoIJ+IbZx26mw+sEe4rSBEH9JWOZJ52vAK3THs1UjipkdTHoF+uq0Pm/98eGdWlLCcKuCHLus=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003)(11006099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e4UaWRCQHVtbESfHy/DdVl1w/9Ip1dHydBY/f8qDNrILdO9YRK8s1sXSA5LE?=
 =?us-ascii?Q?c89a91TPgm8KvXVtn7pORfhHBr/6C2p/MoV3icQCZphzdbUw304VfbBARwBu?=
 =?us-ascii?Q?fJiNxXsjKHUJTjVUWy7evPUAtzUpfZ7xJzFoZHEGwGFsMZ+rs2kRSMjORLyB?=
 =?us-ascii?Q?GYGWy6mY6kGBdqai6X4COJk2YIWGVKBYIZY4GC/4kd5VbgY8aoh7JWjBaQ0q?=
 =?us-ascii?Q?YG3vbQk3iu9qAEDKOX+equOUVedolteOIFXkFPnZnEYExoSl8lfNfVtizqFN?=
 =?us-ascii?Q?c/FiUijXfgvVgBrjkp4oIrA7ONEa2z7hNoGSU54Z1zN6zuci7w7gRreiQodo?=
 =?us-ascii?Q?nPrpH70u5RIdaTBz8qM2Kq9A2Ol0usOAyhdByPoZ7sc4qmVUzExSCgxxmeXS?=
 =?us-ascii?Q?LSpPB/9Vl8w8axxiSI5VhQdetPCr7qK8VYeoNtDMdi5olvjTF8RAJqxm4Rq4?=
 =?us-ascii?Q?0ZmamhlfzKazAHjzY7UHguRtxtZY1eor2WXsYQabk8odcYpLyoOFLdRlkSNc?=
 =?us-ascii?Q?EYISjXbb/PwIscgdXFlawHmXpj1sr5sMT1WIZjkEw3bh2tIRdg72+w+839Yk?=
 =?us-ascii?Q?3EnFTTFD/DBr8vmi0HmT7Fe/0LIiQsCASDuxGqIS4BmUPpct97pehhDsFRNJ?=
 =?us-ascii?Q?kxOe713U2nyNqGclPqLkEXnRB9X9u8yxY9jWGoexP8SNYI5ofbLWQ1bieMWB?=
 =?us-ascii?Q?J7ZlKh2ptieGBZ0Kb2R3uQsnU+j6kjv0Msn1C4PcCrXNC/Obq3TOEM+C1Ixp?=
 =?us-ascii?Q?M+Q2FsjAqYZFVmqm5NlCAzoFi4qTCciVuQ7VtxXe9SZc+73gR0/qk/8vf/jq?=
 =?us-ascii?Q?i0XGAxwabwX2kePZbfOxEevB2C7XWA3nZLsE9DaxwSksh7uDoRbb66PAcmgR?=
 =?us-ascii?Q?+yfVpisMHYk2rY9V1VzVgO+FRM09DodqPmiQy7iwREOFLxK3qRL2j2woUc+2?=
 =?us-ascii?Q?rurWIrSV4FjRraKP85N8hyrEzzKOcytNwv5L4B5PqLOt6jXgwKLLOOWlqz5m?=
 =?us-ascii?Q?I+20Ca+YXtaxqLkyIt0/Xn8ajfbTl4XFwWpvjQPGP8m688lj3vsLDcTVYBSO?=
 =?us-ascii?Q?ES3e99WznfDtpwO6o9QSdWKgkuUoVM3PpYHbvO/L3MWDLiO3ZWQtJib5y5if?=
 =?us-ascii?Q?fh0EO4b9U15pAXd/DEAwfXRzAcSuitj4K4Cz++WREAhaPhHJNlP1PijXefsB?=
 =?us-ascii?Q?lLyBLQygWjawYIhtXnL7aHTCBDMQwUkdxlyCKkKu8UogVNe1gax9h8VCRPvq?=
 =?us-ascii?Q?QW1Pc0lSoVemcEwHZ548m+ute3zy1eaZAkEO4YVcMIhQ0q8hZ7tT8g6R38+c?=
 =?us-ascii?Q?yibz3pYCXpSJv0op5Dabv0DuI6CaW9+3EGAYM2e0lqYT5P5Bf5XwU/2cZOV/?=
 =?us-ascii?Q?v/flD7Jk3lfx9CWUT8apWaDfv8CAruOOkYsXJXV4qbm0Fv7pCocj6cvYA3eB?=
 =?us-ascii?Q?riWhL1qQ9Z344lbGKo0bz9lKDucsvgvz8zUTRAnQe2pa79f0hjcyv+UOgB1P?=
 =?us-ascii?Q?JGKBISBzJYtRhhcC9hI3J+cQEnLTEcHIpoDdTAnU0lpVn3t+VQ0KUCKjFuA2?=
 =?us-ascii?Q?sEIftXi2rKwtn2g/ax+sauiZYFOFeQ6j+LAncbrF5+Dc3tRKwK9WIF+jNuzv?=
 =?us-ascii?Q?2ruYnDkvWUqRXmNnUzfqSwteQWVn6ndgMbjXs60BsDz/8p1HPP9Es6mdPHX7?=
 =?us-ascii?Q?YUhhudXnPPrdkT3qrx0Ze46A+q71VU8ud0GFAnRjwRE/hiuvBMbbYit0hvXz?=
 =?us-ascii?Q?dJUDKAQdMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7abfe1-377a-428a-7bc4-08dea30fbfa8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:17.0287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NITam22y1DJ+ivW3ES3hx55LBstuT4NiFmoclS1UyXiM/4PrlkpC0hJ0Q8+9GtmMe37OAbrk0tQSN+h5QyjKqQ==
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

PRAMIN apertures are a crucial mechanism to direct read/write to VRAM.
Add support for the same.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs        |   5 +
 drivers/gpu/nova-core/mm/pramin.rs | 300 +++++++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs |   1 +
 drivers/gpu/nova-core/regs.rs      |  10 +
 4 files changed, 316 insertions(+)
 create mode 100644 drivers/gpu/nova-core/mm.rs
 create mode 100644 drivers/gpu/nova-core/mm/pramin.rs

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
new file mode 100644
index 000000000000..7a5dd4220c67
--- /dev/null
+++ b/drivers/gpu/nova-core/mm.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory management subsystems for nova-core.
+
+pub(crate) mod pramin;
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
new file mode 100644
index 000000000000..57b560ae1e85
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -0,0 +1,300 @@
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
+//! use crate::mm::pramin;
+//! use kernel::device;
+//! use kernel::devres::Devres;
+//! use kernel::prelude::*;
+//! use kernel::sync::Arc;
+//!
+//! fn example(
+//!     devres_bar: Arc<Devres<Bar0>>,
+//!     dev: &device::Device<device::Bound>,
+//!     chipset: Chipset,
+//!     vram_region: core::ops::Range<u64>,
+//! ) -> Result<()> {
+//!     let pramin = Arc::pin_init(
+//!         pramin::Pramin::new(devres_bar, dev, chipset, vram_region)?,
+//!         GFP_KERNEL,
+//!     )?;
+//!     let mut window = pramin.get_window(dev)?;
+//!
+//!     // Write and read back.
+//!     window.try_write32(0x100, 0xDEADBEEF)?;
+//!     let val = window.try_read32(0x100)?;
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
+//! use crate::mm::pramin;
+//! use kernel::device;
+//! use kernel::devres::Devres;
+//! use kernel::prelude::*;
+//! use kernel::sync::Arc;
+//!
+//! fn example(
+//!     devres_bar: Arc<Devres<Bar0>>,
+//!     dev: &device::Device<device::Bound>,
+//!     chipset: Chipset,
+//!     vram_region: core::ops::Range<u64>,
+//! ) -> Result<()> {
+//!     let pramin = Arc::pin_init(
+//!         pramin::Pramin::new(devres_bar, dev, chipset, vram_region)?,
+//!         GFP_KERNEL,
+//!     )?;
+//!     let mut window = pramin.get_window(dev)?;
+//!
+//!     // Access first 1MB region.
+//!     window.try_write32(0x100, 0x11111111)?;
+//!
+//!     // Access at 2MB - window auto-repositions.
+//!     window.try_write32(0x200000, 0x22222222)?;
+//!
+//!     // Back to first region - window repositions again.
+//!     let val = window.try_read32(0x100)?;
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
+    num::IntoSafeCast,
+    regs, //
+};
+
+use kernel::{
+    devres::Devres,
+    io::Io,
+    new_mutex,
+    num::Bounded,
+    prelude::*,
+    revocable::RevocableGuard,
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
+/// Generate a PRAMIN read accessor.
+macro_rules! define_pramin_read {
+    ($name:ident, $ty:ty) => {
+        #[doc = concat!("Read a `", stringify!($ty), "` from VRAM at the given offset.")]
+        pub(crate) fn $name(&mut self, vram_offset: usize) -> Result<$ty> {
+            let (bar_offset, new_base) =
+                self.compute_window(vram_offset, ::core::mem::size_of::<$ty>())?;
+
+            if let Some(base) = new_base {
+                Self::write_window_base(&self.bar, base)?;
+                *self.state = base;
+            }
+            self.bar.$name(bar_offset)
+        }
+    };
+}
+
+/// Generate a PRAMIN write accessor.
+macro_rules! define_pramin_write {
+    ($name:ident, $ty:ty) => {
+        #[doc = concat!("Write a `", stringify!($ty), "` to VRAM at the given offset.")]
+        pub(crate) fn $name(&mut self, vram_offset: usize, value: $ty) -> Result {
+            let (bar_offset, new_base) =
+                self.compute_window(vram_offset, ::core::mem::size_of::<$ty>())?;
+
+            if let Some(base) = new_base {
+                Self::write_window_base(&self.bar, base)?;
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
+    /// Valid VRAM region. Accesses outside this range are rejected.
+    vram_region: Range<u64>,
+    /// PRAMIN aperture state, protected by a mutex.
+    ///
+    /// # Invariants
+    ///
+    /// This lock is acquired during the DMA fence signaling critical path.
+    /// It must NEVER be held across any reclaimable CPU memory / allocations
+    /// (`GFP_KERNEL`), because the memory reclaim path can call
+    /// `dma_fence_wait()`, which would deadlock with this lock held.
+    #[pin]
+    state: Mutex<u64>,
+}
+
+impl Pramin {
+    /// Create a pin-initializer for PRAMIN.
+    ///
+    /// `vram_region` specifies the valid VRAM address range.
+    pub(crate) fn new(
+        bar: Arc<Devres<Bar0>>,
+        vram_region: Range<u64>,
+    ) -> Result<impl PinInit<Self>> {
+        let bar_access = bar.try_access().ok_or(ENODEV)?;
+        let current_base = Self::read_window_base(&bar_access);
+
+        Ok(pin_init!(Self {
+            bar,
+            vram_region,
+            state <- new_mutex!(current_base, "pramin_state"),
+        }))
+    }
+
+    /// Acquire exclusive PRAMIN access.
+    ///
+    /// Returns a [`PraminWindow`] guard that provides VRAM read/write accessors.
+    /// The [`PraminWindow`] is exclusive and only one can exist at a time.
+    pub(crate) fn get_window(&self) -> Result<PraminWindow<'_>> {
+        let bar = self.bar.try_access().ok_or(ENODEV)?;
+        let state = self.state.lock();
+        Ok(PraminWindow {
+            bar,
+            vram_region: self.vram_region.clone(),
+            state,
+        })
+    }
+
+    /// Read the current window base from the BAR0_WINDOW register.
+    fn read_window_base(bar: &Bar0) -> u64 {
+        let reg = bar.read(regs::NV_PBUS_BAR0_WINDOW);
+
+        // TODO: Convert to Bounded<u64, 40> when available.
+        u64::from(reg.window_base()) << 16
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
+    bar: RevocableGuard<'a, Bar0>,
+    vram_region: Range<u64>,
+    state: MutexGuard<'a, u64>,
+}
+
+impl PraminWindow<'_> {
+    /// Write a new window base to the BAR0_WINDOW register.
+    fn write_window_base(bar: &Bar0, base: u64) -> Result {
+        // CAST: After >> 16, a VRAM address fits in u32.
+        let window_base = (base >> 16) as u32;
+        bar.write_reg(
+            regs::NV_PBUS_BAR0_WINDOW::zeroed()
+                .with_target(Bar0WindowTarget::Vram)
+                .try_with_window_base(window_base)?,
+        );
+        Ok(())
+    }
+
+    /// Compute window parameters for a VRAM access.
+    ///
+    /// Returns (`bar_offset`, `new_base`) where:
+    /// - `bar_offset`: The BAR0 offset to use for the access.
+    /// - `new_base`: `Some(base)` if window needs repositioning, `None` otherwise.
+    fn compute_window(
+        &self,
+        vram_offset: usize,
+        access_size: usize,
+    ) -> Result<(usize, Option<u64>)> {
+        // Validate VRAM offset is within the valid VRAM region.
+        let vram_addr = vram_offset as u64;
+        let end_addr = vram_addr.checked_add(access_size as u64).ok_or(EINVAL)?;
+        if vram_addr < self.vram_region.start || end_addr > self.vram_region.end {
+            return Err(EINVAL);
+        }
+
+        // Check if access fits within the current 1MB window.
+        let current_base = *self.state;
+        if vram_addr >= current_base {
+            let offset_in_window: usize = (vram_addr - current_base).into_safe_cast();
+            if offset_in_window + access_size <= PRAMIN_SIZE {
+                return Ok((PRAMIN_BASE + offset_in_window, None));
+            }
+        }
+
+        // Access doesn't fit in current window - reposition.
+        // Hardware requires 64KB alignment for the window base register.
+        let needed_base = vram_addr & !(SZ_64K as u64 - 1);
+        let offset_in_window: usize = (vram_addr - needed_base).into_safe_cast();
+
+        // Verify access fits in the 1MB window from the new base.
+        if offset_in_window + access_size > PRAMIN_SIZE {
+            return Err(EINVAL);
+        }
+
+        Ok((PRAMIN_BASE + offset_in_window, Some(needed_base)))
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
index 3a0c45481a92..d087354f03b9 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -17,6 +17,7 @@
 mod gfw;
 mod gpu;
 mod gsp;
+mod mm;
 #[macro_use]
 mod num;
 mod regs;
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 2f171a4ff9ba..a3ca02345e20 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -30,6 +30,7 @@
         Architecture,
         Chipset, //
     },
+    mm::pramin::Bar0WindowTarget,
     num::FromSafeCast,
 };
 
@@ -115,6 +116,15 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
     }
 }
 
+register! {
+    /// BAR0 window control for PRAMIN access.
+    pub(crate) NV_PBUS_BAR0_WINDOW(u32) @ 0x00001700 {
+        25:24   target ?=> Bar0WindowTarget;
+        /// Window base address (bits 39:16 of FB addr).
+        23:0    window_base;
+    }
+}
+
 // PFB
 
 register! {
-- 
2.34.1

