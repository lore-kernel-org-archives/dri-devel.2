Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07328C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3747810EEE6;
	Wed,  9 Sep 2026 06:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbcPmavN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF99E10EEE6
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyouNmBtVOqg4lzytCW+4OtfZZNcjE+eaQKr5AQ8hOQHD6N+qoQMfxm+l9O2RxQgbBqVF76Frs4rmNdReEpkOXfZ7tulBA4F1fBFeongyngo375HK80ZSseL48xQ4T2a2XMQ6t3mC/sLFGZtoCIlBhohqoT0wBiwd7LLMxOvaCfK5YOV1rkN56ve5k2KhakQaE/1ihlmLKEcGieK8XcP0sKFF2mteC9Xf7ReZlUc1iM9Ub8GcgtQ05NbkGf9WGw0GwO1iJdqSyuEZZ4zn2ypbGpx5ucPv1AGQAXk1MHMEgEPl78yfMqLTQr3MIFpX8u5Wwzet5HhfnhDgiwMKjKpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROVtYBEgtvQrGKNPqxBaT2WjdsoOAe4GTKdl/CNlVnY=;
 b=syjMRtiF1g5QzBcUL8Czt+y1jB4GMzT+g6qcviCf2N1TG/f+epWMTaeuuKNEnmzLtaUGQpgWJNMhoG5YthJs0nWEUxUbderA0xa8RPeTZr93pt/lPQ6SM8lu37BCATdS70m3oUuBkZJKkU8oTv9IDAebEke0rK0OOCgakYv86/LbgASxv+b2cvTCh9DiahaUXNKwiM+jC+jA9CekEwFbxSKPZ64+mWJ3RDDDi4ht9yT+QPv24BvocRHgq1r1MZv1ifPvjLUYNZbI9f+vSjJcsrkkJHaaUPwawVgTS5ohkeUn1KqC/PGuMIjEk7hzpTzesiYgEnuca2YlDUaumC4cZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROVtYBEgtvQrGKNPqxBaT2WjdsoOAe4GTKdl/CNlVnY=;
 b=XbcPmavNWKZKvtDiJOylbBSnwz5jE5GajWX6i0PdxhWL/1+Z0AQFqc0+I/ovXF6JrixmdubiuJS6o7kUr8LyUy86p6rUx5CvHDpiU7Qxx9WHYdvtB/rqHp/Lsz/J/V1eV2IjKARj3Cm/V5YhsvgYJNpFXTDHd3m6arlAlAUApOQMYAYsMkxV+MtzwuVyAQdBNsm++iCkXsuP+Pw67XdDo+E4v55JQDFUXJCOrLqFi6KzezKhD0T6NgYWSHvptB+pHn0JKLCiqJkzf8T4slQc5mvPcpw3BDcvKRLkmaABUpWlXU1u5ChKKiRvQNkji4XDgV07wBrfYqTc511DYiE72Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:36 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:36 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 04/13] drm: nova: Add GPU architecture enum to nova-drm UAPI
Date: Wed,  9 Sep 2026 16:44:57 +1000
Message-ID: <20260909064506.910162-5-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::12) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: b2acf4ec-7bfb-4c24-4873-08df0e3df432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FLf6limySHLRl25mMrCxsKIrq8MUbCjXX3gnzcCvsTtziqH0FsWryFQrvL4uaZIgSBnpadUY2eQ8W5aoDkPUecopWjMbA2WjwddOokD3aPn8roUe8S+D9M+vy/tvcHcOrNm/MGfWqz2metpSogHy/9ezrJstuxfzg0ooWP2tmmSwRRSn0HJuuTkeKaS8GxRyspyUckNKJtSkjMANa3f7u4N0OTjHYUdKKnhekcux5Ko2kLuVz5gDx1mNv9l6TUZzaAs30mabaI8/rw708CJjC8G0opPmmTZ4yGrDAIt/RGAvhFJhPCuHITR00MqytOZtBOtI4K5P9WdHioix6yu9qUCWGDfoFHRcecv3KYNYCmtT07VAkg3TkR75ziWH3pUFkbiIiIxA7LMLesy470CCQMT1e7/9Fq7wNErJnIwY1xteEK3ahIBk56tewCQStsv/K8KdVLH7DmKFFQPufKj+jRGyLfML6TQcAxXQItWT9fYa4FbQVsXzJFpZ+ZeUad4Th6FNmFggpEvmYeD1NthexPG+F0idbyg/Ti01vllATNLBwJFRL7kGEE+1UdSl7Bte8fXqaTpuJrFXuBGFGCJcmWGbdON8bWERFz4NkszQJw/OjkzAaTiYdbrCNuFGv3LnQT/mvyCiYqONmv+H7EIg0xmPEi9aeSSWff7U0Enj0hI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vdo2XYlBXwXw5Q3zMkglR0upXt0Y4cDTe9nadXUx0SIiJ9MtrE981gOq9rTt?=
 =?us-ascii?Q?vyHat8JLfX6q8Lasdrtt3pw233bUGBloXEVnNBIizYt4KwotU8KPmUGqBcVL?=
 =?us-ascii?Q?d2TC1KFT2G9rPrAb43QJ5dZQd7QR3L4v6Xum+YXKRCwDW1upOtB4G7aV+2U0?=
 =?us-ascii?Q?Zi21Axl1ugez7ER2Stbb8BgfUmfxqwUVWpuFKK4VH88Y1pF7qRDLSS3WF1nU?=
 =?us-ascii?Q?LwnKVGrUuwPhn5JVEZ5H2QxIwkDhNu0U+0j0z+RjKUtAMVPDETh/yEvIJJdc?=
 =?us-ascii?Q?a3FpA6jwhUFX//lx8vfHc/clGM5hPb2rqqrtjmR+Suv6ujm6AtAhuRYat1T8?=
 =?us-ascii?Q?GLRWbuO5Et6F2pUa7E9PBQuvVgbSZewOsHiXSRL5XOawUdnvEDcxzVS82DaT?=
 =?us-ascii?Q?+/G/SSj6ccPMSGT/OGpnD5Mb3O6axSzXycHrPjAyMJuaajq3hz3wCAzAVC/m?=
 =?us-ascii?Q?aLehr9YME+Z9udzUv35nsso6L4/QYsZS3eLm1OYvMorEtmvzwl7VvtAxJSIx?=
 =?us-ascii?Q?9iV/DWvhuysR7/frefk0243Juyf2nv6iMZwVI2p6wdajx5+oRJphaCiAxDyH?=
 =?us-ascii?Q?ulOyoxRQKKTVYSrnMOa2CcsNG34vBaebPVGqt2ZEEb31EtHFYvzTHYaHh7cK?=
 =?us-ascii?Q?N+pJc6KNYzYml3vWB8A2gv6AksI7ImFVP6qz18W2BMBtwTJXbzkNJmeAGgvg?=
 =?us-ascii?Q?kBC/cbG53A+CedhD7WztqkWqZmxg88PIY410Kn0BOLQ5J/emS7Z9JuuFUbQn?=
 =?us-ascii?Q?SkCq2Lj8PseV/L1Od4WlKaViT22ziq5SP6o+qG3joSLRhv9z+KoOZ/ksO9Rf?=
 =?us-ascii?Q?87zmfDpu/yGp7vjNF+ZVMy3odREoSbtYFRkXk+dEctvh6cTU7y0HplgsVKhr?=
 =?us-ascii?Q?3LqJd1IRTTBofpVvxTl8nU3PoCZ7hZYa+YZfKWCO7VL3RyDDhQ0oHdrmtpUd?=
 =?us-ascii?Q?MyiNj1VxU0vO4uprJZcpHAl+Jdl+lX4rbZqWb+zK8b99LtlBe4jDlXzIDMlE?=
 =?us-ascii?Q?9uEgyC0Tj8QKM5DeE0bi5XchrQ2K4l1ZqWKmL2l713fYvK/2HIOVY8cSbnQM?=
 =?us-ascii?Q?5H/oeBClavZAZP0Kxlo15MNgdX+cLLCv9EIBnBaYLq62ssX8nOlZXrJu3BwZ?=
 =?us-ascii?Q?qtrx7WmtTQ+6YywOGPXEirS82uOFl5iWA6Jo6BU5/hy1mWFphrccc8zBbuL3?=
 =?us-ascii?Q?XE3VDhYlLJPnvMkih3otET1pv3EFZ7EIJXVoGuu89D/M62E2Fhq9fOzD6EIg?=
 =?us-ascii?Q?L5IaP6pmzhS7CqZavUsFcKfQo8tThYAviUNRun8/InUvmilikfrU64pfMPA7?=
 =?us-ascii?Q?YOnAGoGrVpnEqi04kyMyJTfYukzkPNkK/9V+Y6xM4IT0Y0lEmA3qecrJ0Qaz?=
 =?us-ascii?Q?ny8nASW1MwNSrLJreioxSvI1O+3fQeumcEvLFlb3FI6POL0bK3VDXy6hwy8j?=
 =?us-ascii?Q?8jH0DFXM4C/c9S4sb9xYDALUlOrI4h1C7IzeYwgqZpzlbfPy9IUPoJV3Wn4C?=
 =?us-ascii?Q?CCRBKKCGWyJXwgzBmlPxFnnl6paANrUf3m+5gtX2YmzoRKAv131s7r0fvRZT?=
 =?us-ascii?Q?VYlNLTLvkNtL3cw1zM/TlB4MqdI6bvye/+pqnmG5swS8x7lCHkcwjzQdhAIv?=
 =?us-ascii?Q?28vkGlxqYVY1gFrwR914KYfq7rQ0hZPiBgLdMcjJkEYfp26e1PrJypIAWYdw?=
 =?us-ascii?Q?DIjKt/9Cot/32gEeXemmAD+Qdt9vdwZDdTu0grKctWtxEKgSEr+OY2r3pPCo?=
 =?us-ascii?Q?OlOiy3awLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2acf4ec-7bfb-4c24-4873-08df0e3df432
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:36.4007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbEQZs+BYSiI2eSD42bE7myHpbMClQ/kL+SFyrsuj8AA/BYgo8FHiayIDhTjEuyD20Kn4ROjrUV5v1K9cfPgHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

The GPU architecture to be exposed to user-space. This adds a public
enum to the userspace headers for each chip architecture. Nova-core can
then use this enum to define its architectures.

This does create a coupling between nova-drm and nova-core whereby
nova-core depends on the values defined by the user-space API for
nova-drm. However this is entirely appropriate as nova-core must be
bound by the UAPI headers as the enum values are read by nova-core and
passed through to user-space.

It also requires a minor change to the bounded_enum! macro to match the
architecture values in an expression context.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v4:

 - Rewritten for v5 as exposing chip-id was dropped.

Changes since v3:

 - New for v4, split out from "drm: nova: Add GETPARAM parameter to read
   the GPU chipset"
---
 drivers/gpu/nova-core/gpu.rs | 28 +++++++++++++++++-----------
 drivers/gpu/nova-core/num.rs |  2 +-
 include/uapi/drm/nova_drm.h  | 12 ++++++++++++
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index e1ac8ee9ba4d..8726beb4f693 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -10,7 +10,8 @@
     num::Bounded,
     pci,
     prelude::*,
-    sizes::SizeConstants, //
+    sizes::SizeConstants,
+    uapi, //
 };
 
 use crate::{
@@ -36,8 +37,9 @@
 mod regs;
 
 macro_rules! define_chipset {
-    ({ $($variant:ident = $value:expr),* $(,)* }) =>
+    ({ $($variant:ident = $value:literal),* $(,)* }) =>
     {
+        ::kernel::macros::paste!(
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
         pub(crate) enum Chipset {
@@ -49,7 +51,6 @@ impl Chipset {
                 $( Chipset::$variant, )*
             ];
 
-            ::kernel::macros::paste!(
             /// Returns the name of this chipset, in lowercase.
             ///
             /// # Examples
@@ -65,7 +66,6 @@ pub(crate) const fn name(&self) -> &'static str {
                 )*
                 }
             }
-            );
         }
 
         // TODO[FPRI]: replace with something like derive(FromPrimitive)
@@ -74,11 +74,14 @@ impl TryFrom<u32> for Chipset {
 
             fn try_from(value: u32) -> Result<Self, Self::Error> {
                 match value {
-                    $( $value => Ok(Chipset::$variant), )*
+                    $(
+                        $value => Ok(Chipset::$variant),
+                    )*
                     _ => Err(ENODEV),
                 }
             }
         }
+    );
     }
 }
 
@@ -158,13 +161,16 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 bounded_enum! {
     /// Enum representation of the GPU generation.
     #[derive(fmt::Debug, Copy, Clone)]
+    #[repr(u32)]
     pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
-        Turing = 0x16,
-        Ampere = 0x17,
-        Hopper = 0x18,
-        Ada = 0x19,
-        BlackwellGB10x = 0x1a,
-        BlackwellGB20x = 0x1b,
+        Turing = uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_TURING,
+        Ampere = uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_AMPERE,
+        Hopper = uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_HOPPER,
+        Ada = uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_ADA,
+        BlackwellGB10x =
+            uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_BLACKWELL_GB10X,
+        BlackwellGB20x =
+            uapi::drm_nova_architecture_NOVA_DRM_ARCHITECTURE_BLACKWELL_GB20X,
     }
 }
 
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6eb174d136ab..f4169235bc24 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -263,7 +263,7 @@ fn try_from(
             ) -> kernel::error::Result<Self> {
                 match value.get() {
                     $(
-                        $value => Ok($enum_type::$variant),
+                        value if value == $value => Ok($enum_type::$variant),
                     )*
                     _ => Err(kernel::error::code::EINVAL),
                 }
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 3ca90ed9d2bb..f0dcbca1908d 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -25,6 +25,18 @@ extern "C" {
  */
 #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
 
+/**
+ * enum drm_nova_architecture - GPU architecture identifier
+ */
+enum drm_nova_architecture {
+	NOVA_DRM_ARCHITECTURE_TURING		= 0x16,
+	NOVA_DRM_ARCHITECTURE_AMPERE		= 0x17,
+	NOVA_DRM_ARCHITECTURE_HOPPER		= 0x18,
+	NOVA_DRM_ARCHITECTURE_ADA		= 0x19,
+	NOVA_DRM_ARCHITECTURE_BLACKWELL_GB10X	= 0x1a,
+	NOVA_DRM_ARCHITECTURE_BLACKWELL_GB20X	= 0x1b,
+};
+
 /**
  * struct drm_nova_getparam - query GPU and driver metadata
  */
-- 
2.54.0

