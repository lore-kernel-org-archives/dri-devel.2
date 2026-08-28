Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDF2C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354CE10E45D;
	Fri, 28 Aug 2026 03:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJeVF1zi";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F5C10E44B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg+xTsivGaM/OkKONfqIKJ1qYcuNG7wvUS5igWNwyprFc/RhxGZLqduCquSaBNW6M7KEnbwEemL0NaB179jL6f48vY6XVzXYrk07jmCQzu5hIesZgJZgfNrpO6ooH5i5FpFF/gUbgqM3y+0SRasQuyk8ts9IfofWpeo6Z5Ds/fZ6Tt438nGI8cd0DViyXtLqkRLb5v/XkAY6bruvlga1cBmhihoZFT359icI95olvsosIsiC+LVu5fNX6NInTVNeR0WWBwof/8+p4Ng9skW07WHMFntvTOLOzX1ILK16OKLq9r5APye/KUHcL8ggAFXaA8OdlC8pc1KXTxFG2OCZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdHPqKPwiI2A+hO9zEITUBZwyveWKVzz4D6V/c9B3gc=;
 b=e0fi+MBQVPA+AWbr/LoHPjMp1cR66Dj8aM8LcsTqyAfTDx2FoQ7OvNeABY6VfP1DjD01V+HN+id5ItSo2a3T13MEnBbh5PD4tEHGD+tDb4Kiy4ti8RNhcN/X8qydikYSVVnZOBH5It88dgmIkTA2MdCnguXMNnnOBUhE2k4btYX45rhmHEpb6GFYdwVKVDdqmT2qeDr40h9DRvKp/XlnlX2a61mdz3iBaAAZwi4D+va+09o/OHd3gZBw3bhSoQCjTFOfhCwO7/p+3ZGCSeK9mOIvVuwlk6P2yze58TmldZxdNzVuOS4WXNn+5R6aNMUHxeuxzhYCjJOG31/gpiipSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdHPqKPwiI2A+hO9zEITUBZwyveWKVzz4D6V/c9B3gc=;
 b=GJeVF1ziVjD03j621Yvx/Q8aS6nCTtoPlLpxkJ2yapPLglajq+yQQHCT49+mONZ/rjd1amLx+y6BsvEsTglrTzsI8T9WmRKdcyXMuEZO7TuVbd0LEFqFFkN3qoJ/Do/pCNVoA7KWgUIKHKanaXhHmHYjl4bXkQ4XITWEQ9nQ3J5+ExVGpMIZ2aRzkFRLRC7Q/P/WwD/z0/+xvnZQnNOxIm/Q/8swi0Db1tXpbcZ3vCZhj50FILsC/+r++A5vxhd6VqU8m6TKxQ/e7bUnPoRZiAVOssO78JJkOfxHDF4EqZIIZAatHzu767SY6THLDRLaND9uQEONZumnKLdNUw+Diw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:05 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:05 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 03/11] drm: nova: Add GPU architecture enum to nova-drm UAPI
Date: Fri, 28 Aug 2026 13:35:23 +1000
Message-ID: <20260828033531.1117754-4-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0103.ausprd01.prod.outlook.com
 (2603:10c6:10:111::18) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fdcd62-60b5-416b-ae04-08df04b57db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yxPMqg8IG34jVBQRu+oSAIpRu1lK6rFk8nB4AFBdSVAzlwCu7b4YjWiz0XUWsIM2YQIAK5GRHN4WK8uMhuBYYaVZNvPyoVVL9afKoxoJ0y/xZCPq4/Alz7SQH/kwpltJj7THyRUP1Gy3w8JtNQZlIqpSooy8cssCmIs6YPUdvrm4ZS+odppg1AlDtzkO//Qh0yHLLN5KlzcSq9V6pS6GdV3fRbAqD/tc+1UYrjluEBG4aoezwE1rX89lb/f9jj1NobmxDx5OjR/dwyjHKp/2j+u/DEhNA0mRcQ4OajMhaOiL4DF6GNctm5TmH6lLzmnIC3ztkYM9S89QuK6I5oKDM6B/yBkfDpm0+2AXDU/A+9rfkxQMgTtRtP8MtYme4Zxg26fRYr4cJd39Prf8S/6dmoL3N8Ba50cISz0gI4BGZcGUUsLjWsDwRAacChXKlWYWKOq4Y96gKEvnBwMCVqwe6snY84E0i3o9ec/GWWa/WAYlmt85JQIkyW3CoXLtVtQzTrwoYBgKkvvalop2sUM6gn9+G+ojfAEv+ZF0agaMJi7fRTB3CkF2YV+iW2lcoNKfL04iiWsr5R04+Xx7cww/g52nNUAImXV+8TIXxAwpgG1mR0Y2lDMvvlVClZIojnDuW08vg+QHCh2bHVJ0LqJvlLM9w10qYF+mDGGvCIL5y9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/59EWUKjeXg0YpqMOzsjMiLGDL4xbd/RS6YRjpE7r9qh0x8rZfiTiFQf9wRY?=
 =?us-ascii?Q?LruZpa+CFN39POCWIbBeEgGgU5gL4ZEDUgT4pJH8s8jvwvQAUN9AFa2tMaw2?=
 =?us-ascii?Q?hNe2dkhfwGPCiQaei5kQliPRnSpIzUFl81Judv+lDN7vzCxBsBv8GqSTIFY2?=
 =?us-ascii?Q?P7MQIzC3xKm/e1xZ4GFq2jkjTfPLtygxbx7Fx8bS3JwwSSRypRBebweDzQAU?=
 =?us-ascii?Q?waQWPR62L03YwYDBXXRUHLWWfCslH0fgXpQkY4+JrnazL0Da0x1HPRvpltz4?=
 =?us-ascii?Q?UBr0x1/IIwxGbTuF/nlpC8+8+nVpipbxOctXxUuKAutbTFBEKDrQvsJE0A3M?=
 =?us-ascii?Q?P3UuibtA+jUEH5Z+RLbCcFgfPKThpDkbS6xjSaEUloIsvsn43Tp2rnX/vdEF?=
 =?us-ascii?Q?5dPcnWIGbX+6ahbxwd7+R1xHjy/BhLYv0810d2kEJ5oV9SEtlC8pZYU6oXYH?=
 =?us-ascii?Q?ceahRy3o82604cEkQqEc4gY+o7geToHHz7S2pNL920ePoRYr+a3IdKmG+6AD?=
 =?us-ascii?Q?CeTnjK1U1MeQleX7M/KwgxAjNQHRrp9jIwPhC0JA95xADE+92hzLTciVz6xu?=
 =?us-ascii?Q?aRgxInDTEgEinjeaiszvvmgbT915l09P+IXSMI3CLYL4xBWzejaSzdqm5fSh?=
 =?us-ascii?Q?gJpz0o1m03XfE7IQCh4B7pdR6ejSupMGlFLLp1K+s/a/eowP0YKvQa6iRffS?=
 =?us-ascii?Q?AN4cs4swpzlp9rDmcP6aDXrouAP2vAMWtumXlPquNWBB77apqiVZWJSU7XB3?=
 =?us-ascii?Q?f1/DlQpHYWdN6xtCGYPzROmgY/LmU15MC2nk8RN3x7iU18IbG5pcvfALQ4m1?=
 =?us-ascii?Q?43uO7zIfJLVlgvWoVFzhVPz8VKJjjn2fJH9FpbYDECiQ+4HWylPt7R3pINY0?=
 =?us-ascii?Q?Ss6gAipWSSFoW2+/O2a5yh4fjadAK3C1cDqziU6YgF3d9o5LOuZ0+PojOUbo?=
 =?us-ascii?Q?jymtQ1BEYNRiqIX7yAMg9UlEYWk2GE0g4jzKAs1nZ7+moaDi/p2KFR7SkENl?=
 =?us-ascii?Q?rc5WAgbixcOoEqv+8RuDKUOCgYI45eHUjOe4gH7LgV06yIGMmOPsRJZjuFoE?=
 =?us-ascii?Q?a0quEp1m1z/g45CgtdYl/LicA28G/ftrgbuA0FVShNyLksAP2ANQBG3NXjmf?=
 =?us-ascii?Q?FKzXXTDj7SaIqzg7QBlI1h/lqd0mRd+nY1TuEEPmRsfCM7h8TbzlDcPTqgRa?=
 =?us-ascii?Q?EANfdQTaxNtkzExxRUrBZwAWhBxxn75pic4fTkQU+RQiHS3mpy09LbxgukUy?=
 =?us-ascii?Q?vUweCfxzwX7Rfi5UPaKrrcCoFESqq80OWuhyoh0STNNLLLkK8s1+OxAtR1JG?=
 =?us-ascii?Q?FCvsbocNeSv32WfTvTZSlqvsn+0/+JYgpgj2hkGQ38H4dBbQYGW+dwKDXwyF?=
 =?us-ascii?Q?VIX5QqJ3SGWGZHNVaNftU0ww7A1SN10KVplVBiubEqt9uCGQHO9F5tWQ9LYG?=
 =?us-ascii?Q?gMOOtkSvScBPYJVTQIREy6MxKP1Tg0K/lG2r+GTG4rsAlHJrcyRqQkzays9H?=
 =?us-ascii?Q?IP7VRkOwSxQ+HTfIcqRy7p+IY2MuMQoXEAY7carIfjEclse1YXYk5BIZkXNy?=
 =?us-ascii?Q?uWX5CAejm0w1LlDYszDofzpfnpJwyFlAqXg17ZNyFiEE2CYkhV7ayeOdTlAT?=
 =?us-ascii?Q?8svuah4IwGCjUHfb6uLR5KKw5BBhzipVQsqWXn77VzqV5ex/53dveNq1SbDo?=
 =?us-ascii?Q?jG4B7iWgrBv8SvP1FdWYnCnm0Mebrmpxvmvmy/CwCeI6RC7Sch8yTQ8ucrSO?=
 =?us-ascii?Q?nHQsrysHgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fdcd62-60b5-416b-ae04-08df04b57db6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:05.5392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: II2E6RdPkYQlzhtxStQ/oYHq8JyGTE9in0+T954RU9fPKn4S3ZEB/nn7rJLDxtLrkGKUE3fLVqHeNwXG6vWhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
index 9e4232645a7e..0c12ef145981 100644
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

