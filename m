Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3D0C5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3691710EA5A;
	Tue, 11 Aug 2026 05:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b3DnlYyf";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40CDE10EA5A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUQYAjGrZtYUzMwevAMxNzHDoKUGlzAgbWCK1AYPDJZorKRf+Egnl84J184B37TiWxIQYEJcrdPfAAx08hhyNoL1DOk4u5zxjMrYXiNaDCge9tpoZvkQyx5sWYtC/cBclEbB714PpFca9tJL7sa9QTfGlM89pE3NNjPF9dGIOxUToPdPQL02g8v1lB9FCoosaBgLaom68y7uPbpNf5GFdbSOQG1DE7X+k22OAYNBgrOdwFg8MU1D7JLBu6LmcwwV6wVNThzasaw6Ysy+lyjoHXyYynWjQB79od/m6X/E6LM0cU+dmH9FzNn6HacERBexHi/8Qv9VwUptSjGyCnLwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb5mI8pSze5YeFenVBOD0znqcrctPCreQ1oENfNCovs=;
 b=PQ+x059a7nL82dLOqc/yPgYn753aqJZCsJWFTvaik8A5A7qBZ+NOC52FjGRQ4S/X6BzqKZJAUCGg3A0KBRaDEFLiqgSXQbBiaLEK9xg3kRi4X8cHnbSfLaAys/QgFxPzBNjsujxqM0kmsaFR3gpzYjl7L8wU3blxuh9NmUELGq6lVfPXES7i6ZeropW2GsMqq3u7ILheZEaMDISuY0qhcI//ROqW3HgyF4KhfElJRJfA/In+KDhOlhr5X4lxNyktem+kCOGK/aVtJvxuq5Il14Z3n0s4Lk9+wPCcH4VgDNhELkxMn9GbBCX2KJlsvQaU2b+p+ly0lmMiQVZOtCgsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb5mI8pSze5YeFenVBOD0znqcrctPCreQ1oENfNCovs=;
 b=b3DnlYyfUUsoKrisuyMoCEn9PWzQ6EuXbAdqN7v9AcLOSOfRxwnLpriZXBpHCJj1cZIcqCIMt2dnbAPO/9kjSO1iUUUhLDlEJ/TgEfBcO56t2wmBtaxNKO8iOqw7mdcGITksumzdeZP9BsQjDOCRAeyhsq0RcMAji43DjzwMucMJBbp/znrORonQSOa/H/D5FRRBI4bMt2gO428e/xtmy4k2I+lLW7KQ3dq2jU+h6cRnF49a0EFDG9A3k1a7O0VxKe+fgv9vMtG3CqrqpA3I6FoT9kfsQvh271JmP2Utm74FwD9OjQlulowq6xcpwmbd3o8GtBfT8eqA1gpGILCoaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:07:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 05:07:25 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Date: Tue, 11 Aug 2026 15:06:53 +1000
Message-ID: <20260811050657.646799-4-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811050657.646799-1-apopple@nvidia.com>
References: <20260811050657.646799-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0047.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ff8064-f7d8-4750-533b-08def7666ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2Hj2D5b7F7E/r3DaodbhjAK56nrzUjVyqHiGpKfFH/qpchz/lUSq7iu/Q/1YXxww/+nS9xVP4nfqLXNWhJaeL6/LwRUgOvcO4AnoGbBBMs5gQlRAqSZ+PddxDdwRcXOqCe/DsWdL6/5IQUnD2dlztUY0sMjzYAAYZgwsry1ZNz6CYGQpEgez5nZ+wp5Pvn3oWb5xxxR85GfnlnLhXcZrBTsX+8YvCbHA4AUfdsEBbqUdIkKcWncCO1ECHYDtuca0/FnWCo+mKUqeqRNNGA/YNL1XIUDCd3p9cvlN5ehmE+clZoNpSJQr0GsqLHJkV+BXWaaqp9+teDYue6AFPAbDNheyYz8RC16unqscVp3b/fX3aV8lWYD5YTmQAC6T5RW9lCEzpYmCe60ikI2gXkAFU0nHhG155wlQS7OKnfBVAAhrwSk016D4nTHg62jnTpFb4YgywqCOxF4T4bhWw4ifUhFCkM/bl7JWa8TR5AVAlaf9QI1lYTjDw2Lnv2uniGt1uGWTkO6k5aVsHj1+DrbLWbWNQ9np/itYBdDK/KdzLRaeeQhS5rfmCtLwgDKSKLVHQ4K6/jSidcoJSlWDNU7q4qiPxAu8/4prB9WVvzNzynpu9SicX8YEnGbyeo4p6lodK+xEppz7ZC82K1TUGe3AmxlJs0yX7xThr1vV1uiiEq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WjP6hMa0lDBQFFnFrrnEFqkSruh7741lyQ4GH1D1KOzvZKWGgqCwTSyf3QyD?=
 =?us-ascii?Q?EcerlixIsLm9RubW4AmoIhVDgCx9mKDugL3ILTRB/TJK/ApXRSeOJYouoRpd?=
 =?us-ascii?Q?5pSW9Rnifww0RYx9VgdHyTL/ruTMzswPKrC6ZhLdUPPbQwRxBd2QMKP4eZcv?=
 =?us-ascii?Q?C30QLR9wEPFv+Up0LdIM+eOmQPWr4UXPN0SUkt2RzUhpicPmBGPFIxo20LDK?=
 =?us-ascii?Q?AGFdxEZx0MwKtcW2M7YIfIelMJ5pxZ6wZQjqC3MOTqaypX9PqViRSA7aaKFT?=
 =?us-ascii?Q?t9nleuSmUobENju00w/GDY68iClyHztvQ1Ds6jBuSaws4xpP/Qkq4xtqtB95?=
 =?us-ascii?Q?ZhZzg73h2xhuGcMXGNtrWQRj99DnWwt8m7duPr0m8ujDDRwpRKXFEgmYbxI9?=
 =?us-ascii?Q?OpZb8rqeCND+ow+JVcqnoMS9SMgUM9fUmSEG6S85ucMfTalRdQDJ7CcT3rY1?=
 =?us-ascii?Q?e737zxRh4gin+Zy7cE9TCsXAqR5f/G3TW7sKg9EalQMU7AgbNuYsCeUybxGe?=
 =?us-ascii?Q?aCVtsXwaiq2EQOag529fzMt5kZtIpXhzFbzKPRWUX4D78RhipnDmKB8rW98Z?=
 =?us-ascii?Q?g4rieAoBPavo0b2NXt3oQYGzYZetfAVUwEayWEWgoi11blsl32eLB/IDBkOE?=
 =?us-ascii?Q?0xse/IMenAkIr4uJCBDgB8yda94TwTaOOoWhZsZgZ9DV8UkYYCXeSEIO5x0x?=
 =?us-ascii?Q?lrHn0bYnaxVDBkdeuZTCAkwVnclc+UM1M4C7kENwQCG6KS0F3rcZYzie9yl1?=
 =?us-ascii?Q?ZuUm5det1fLZMkpN1X55VGMFPVWEqRPKxejitqNPzSECsiOtpZ6e4lkex8tb?=
 =?us-ascii?Q?HlsvthxNYvEGqJ4sfrU6CpPubrsJbrxQX5/uLstDqjK9oIXSGmlvenEbS/hg?=
 =?us-ascii?Q?CxVVB4LgxiVKY4OzplUtUTHFcdtgdU5MUMm6kZDGDYeAWgREG+MAF1tZkjDu?=
 =?us-ascii?Q?/pOtMLBMbNTY+WlVmd3bTf9fZFG6MOzKhGPk6g3gxNtf/MrbpuhVSaqKnugk?=
 =?us-ascii?Q?Jb5paT/O73HoJIbI5ayNqV2rUGQo0An6T4EpwhwbMNoiwLFQ1aeISZ7EIG7r?=
 =?us-ascii?Q?k8WTHkDTkOftOSV2ZAijV5pScn2vcnS7xb5X4rsYXJytbRWv4ehix0cXD+KO?=
 =?us-ascii?Q?D8BwGQevob6Tjr4w6EF5vzNEZTlVeXa7ny2HW1Py8CZOChQZqxa+Xik1yNJN?=
 =?us-ascii?Q?ijmNbmwDQGviHKOfb1fntGyWpdlUSD7KT4N2bdweK9nBTHh2tlx8qD1BXIVk?=
 =?us-ascii?Q?bB/p+squcPEHh96dWUEfo2PHN1la8moDj9+fAIloQ5AYPY+639t6u31ufHsD?=
 =?us-ascii?Q?AqE7BUz07gT4u5J3p7tYJfsoCeIPu0gQdgr+fv/c9TTCupjnnG+NMVfaRHKc?=
 =?us-ascii?Q?fUtFnRsUWMBW06wHKBcYOXEGnMFaAF1kA6coPBmMKF8gOvykfMnr+zfsKycj?=
 =?us-ascii?Q?1GurW0FeviON2edHElRRVUPXKgkoQ7edZyFjbpGH+3UbvZYBZvXBAiFKgV7i?=
 =?us-ascii?Q?hyA+jMZJOP2e9uHfUj5itwLrdqtG1Am6TYnJQadeARyU7Uo0F2Fg35cWQKh2?=
 =?us-ascii?Q?kB5KEEJLOkLQEgjMKFngIE76eS/uS9LHvXyHS61OXOS45nvaNWKHOXW/4aWy?=
 =?us-ascii?Q?dZFEKrQiDKg140mhYK5/mOnoTs+a3L4bypEV1RPPYJeiexShlD+3O8/nX0nj?=
 =?us-ascii?Q?XoZ7fRGHyPNacSPrDCRmS8tcuA83Fp5arbUSk00F4Mq1FT7v7CJejHRfnA0I?=
 =?us-ascii?Q?5j2z2a/SJQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ff8064-f7d8-4750-533b-08def7666ec0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:07:25.1319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQCe3VGW+V331bEgMsX7qCBUQxem3S4tiBymu/OUYlBaSFWWwtbcj702vtBlbPw2YBLPFQiv5x0NFc07h3aE6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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

The chipid contains the GPU architecture and implementation and needs
to be exposed to user-space. This adds a public enum to the userspace
headers for each chip ID. Nova-core can then use this enum to define
its chipsets.

This does create a coupling between nova-drm and nova-core whereby
nova-core depends on the values defined by the user-space API for
nova-drm. However this is entirely appropriate as nova-core must be
bound by the UAPI headers as the enum values are read by nova-core and
passed through to user-space.

Note that nova-core currently refers to the chipid as a chipset. This
isn't ideal given that chipid is the preferred and more accurate term
and is what should be exposed via the uAPI. Therefore a future patch
series will be posted that aligns nova-core internals to using chipid
rather than chipset.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v3:

 - New for v4, split out from "drm: nova: Add GETPARAM parameter to read
   the GPU chipset"
---
 drivers/gpu/nova-core/gpu.rs | 64 +++++++++++++++++++-----------------
 include/uapi/drm/nova_drm.h  | 38 +++++++++++++++++++++
 2 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 442c0979f9c6..738a590e753b 100644
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
@@ -35,12 +36,13 @@
 mod hal;
 
 macro_rules! define_chipset {
-    ({ $($variant:ident = $value:expr),* $(,)* }) =>
+    ({ $($variant:ident),* $(,)* }) =>
     {
+        ::kernel::macros::paste!(
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
         pub(crate) enum Chipset {
-            $($variant = $value),*,
+            $($variant = uapi::[<drm_nova_chipid_NOVA_DRM_CHIPID_ $variant:upper>] as isize),*,
         }
 
         impl Chipset {
@@ -48,7 +50,6 @@ impl Chipset {
                 $( Chipset::$variant, )*
             ];
 
-            ::kernel::macros::paste!(
             /// Returns the name of this chipset, in lowercase.
             ///
             /// # Examples
@@ -64,7 +65,6 @@ pub(crate) const fn name(&self) -> &'static str {
                 )*
                 }
             }
-            );
         }
 
         // TODO[FPRI]: replace with something like derive(FromPrimitive)
@@ -73,45 +73,49 @@ impl TryFrom<u32> for Chipset {
 
             fn try_from(value: u32) -> Result<Self, Self::Error> {
                 match value {
-                    $( $value => Ok(Chipset::$variant), )*
+                    $(
+                        uapi::[<drm_nova_chipid_NOVA_DRM_CHIPID_ $variant:upper>]
+                            => Ok(Chipset::$variant),
+                    )*
                     _ => Err(ENODEV),
                 }
             }
         }
+    );
     }
 }
 
 define_chipset!({
     // Turing
-    TU102 = 0x162,
-    TU104 = 0x164,
-    TU106 = 0x166,
-    TU117 = 0x167,
-    TU116 = 0x168,
+    TU102,
+    TU104,
+    TU106,
+    TU117,
+    TU116,
     // Ampere
-    GA100 = 0x170,
-    GA102 = 0x172,
-    GA103 = 0x173,
-    GA104 = 0x174,
-    GA106 = 0x176,
-    GA107 = 0x177,
+    GA100,
+    GA102,
+    GA103,
+    GA104,
+    GA106,
+    GA107,
     // Hopper
-    GH100 = 0x180,
+    GH100,
     // Ada
-    AD102 = 0x192,
-    AD103 = 0x193,
-    AD104 = 0x194,
-    AD106 = 0x196,
-    AD107 = 0x197,
+    AD102,
+    AD103,
+    AD104,
+    AD106,
+    AD107,
     // Blackwell GB10x
-    GB100 = 0x1a0,
-    GB102 = 0x1a2,
+    GB100,
+    GB102,
     // Blackwell GB20x
-    GB202 = 0x1b2,
-    GB203 = 0x1b3,
-    GB205 = 0x1b5,
-    GB206 = 0x1b6,
-    GB207 = 0x1b7,
+    GB202,
+    GB203,
+    GB205,
+    GB206,
+    GB207,
 });
 
 impl Chipset {
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 3ca90ed9d2bb..ea7665383644 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -25,6 +25,44 @@ extern "C" {
  */
 #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
 
+/*
+ * Opaque chipids. These may be used to determine what chip a particular GPU is
+ * based on the identifier but the values themselves should not be assumed to
+ * carry any particular meaning.
+ */
+enum drm_nova_chipid {
+	/* Turing */
+	NOVA_DRM_CHIPID_TU102 = 0x162,
+	NOVA_DRM_CHIPID_TU104 = 0x164,
+	NOVA_DRM_CHIPID_TU106 = 0x166,
+	NOVA_DRM_CHIPID_TU117 = 0x167,
+	NOVA_DRM_CHIPID_TU116 = 0x168,
+	/* Ampere */
+	NOVA_DRM_CHIPID_GA100 = 0x170,
+	NOVA_DRM_CHIPID_GA102 = 0x172,
+	NOVA_DRM_CHIPID_GA103 = 0x173,
+	NOVA_DRM_CHIPID_GA104 = 0x174,
+	NOVA_DRM_CHIPID_GA106 = 0x176,
+	NOVA_DRM_CHIPID_GA107 = 0x177,
+	/* Hopper */
+	NOVA_DRM_CHIPID_GH100 = 0x180,
+	/* Ada */
+	NOVA_DRM_CHIPID_AD102 = 0x192,
+	NOVA_DRM_CHIPID_AD103 = 0x193,
+	NOVA_DRM_CHIPID_AD104 = 0x194,
+	NOVA_DRM_CHIPID_AD106 = 0x196,
+	NOVA_DRM_CHIPID_AD107 = 0x197,
+	/* Blackwell GB10x */
+	NOVA_DRM_CHIPID_GB100 = 0x1a0,
+	NOVA_DRM_CHIPID_GB102 = 0x1a2,
+	/* Blackwell GB20x */
+	NOVA_DRM_CHIPID_GB202 = 0x1b2,
+	NOVA_DRM_CHIPID_GB203 = 0x1b3,
+	NOVA_DRM_CHIPID_GB205 = 0x1b5,
+	NOVA_DRM_CHIPID_GB206 = 0x1b6,
+	NOVA_DRM_CHIPID_GB207 = 0x1b7,
+};
+
 /**
  * struct drm_nova_getparam - query GPU and driver metadata
  */
-- 
2.54.0

