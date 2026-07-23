Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44894C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CBB10E6EE;
	Thu, 23 Jul 2026 06:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AsM0p2Zu";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCDE10E6EE
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAsuulaQigkvCRwYi9flGxXrWBUL0fEIxS/KSU8gh1+agoIiPl+ExOZaduNT6LJ7m5vRKGtGFDnraeBms3oSCR4+Q7zVA0g6fJPdhvkCw4d7Ce9zZjARvuFY4xE6/MsjihGeoxNAAEMhYF4DdHGowvpLIhGYvxoj6bayR3yeY+zJiCpsM69hY4YyBQlZXzBBO192UBqzUa2cwljpeMcywYdvGbhDm5dYF57G9tBkDPZ5fGHEe5USRyvI5V1mewfx43y+/Ah4vq28+A/WTdNuzMH+98f9FQJRdYUcFmc6rtOVuR+3NPKCVl5TmhlespWDuVb5ztruZzOIkgWTZATOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hbOMjh2prvzGqOgFthzZJJD6DmFKL333OIaoN2fUdg=;
 b=lSY3goEHo71EBcvuwkJrV67PknRA8IjmPaHBN98DW7sCZxk62Z7M2ESS7BGhWzqtpFmyJgqAOTpzP+zYAtwYGaTpeo1U7axuuv0LVB34qb3ZBLo5gOaAxbkpJoGr3URHQDoh+JE1oNCoCqCRFz6ys2o2P5I9G6DCmLnilEM/acOtPhR5YcmsRMwSwC3gKr8jry4vK++LAeggOmY1av9eaHp9tYOIbDuBrxPc8aW6ciUhBzgIlJFTjKoDT/URBGyIwXdMBM5s5JnN6ajfLbIMqsEs2U5iLXGQy3m9KvcQhjl8bAqig/HVvgIIVOBEx//bpWCszw41iTpV0ZVIE0vULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hbOMjh2prvzGqOgFthzZJJD6DmFKL333OIaoN2fUdg=;
 b=AsM0p2Zuai0ylka3he3D9JCntekWVSN1TuS8gH4eXbQlNQVPZWvxdJR5NDwA9h3TcHJtr8KcsawE2N1PHIjIEqiVc3V8yPyG0ffuXRq+Csw3uJ5QE2LEoX9mFfgZfBNf3CgNch4L4ElIkUKOCvmCs1b+3l18e6gRbfNjQW1fuqpWUXQPGt3TFPq/YjuMAM2OX2SgYuFfkCo8HHqZe+Ln2tI7FKwrGX/PhVZsg8k+KvI95Nr4uE+6MVkKu6ouBcnu/hr5z9RNwJkJb7YyIQC3k9k9BkJieV/nbiq1SSqbnp4snOxwUJmVH8yMxZBLCwCVSqFOvEk3n6uWWf+HQ8wd7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:31:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:31:12 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Date: Thu, 23 Jul 2026 16:30:41 +1000
Message-ID: <20260723063046.1265791-4-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723063046.1265791-1-apopple@nvidia.com>
References: <20260723063046.1265791-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0099.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::8) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b454b2-7911-4c9d-77c2-08dee883fd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jp/DGwt1IewXYZffBUlS2lBjnYiOpKrvLDjbYOGPcmok+4cZIJpQsOSW+yF1B9grJEyTBLG0zWtSN0mckWRPGRJMON9Yj+ZIforTIUFoCaUnwxPWIkf/0wsyc9MWwXj0y64Bbws/ItM1VlwXPiQEjjxyB0Sp1RHt7Be6ph1kHnIXJnrnsKj++9ZBvmeOpCGmibuMgaMjYE65fV7OTxQBE6WtZTZEPkQOwMxn+5V1qSZog4vTmjksVDmZkT2UcUFKcSMTeyknyWycCSCLjVyro4PAncF9LI7BR+YRag18cIUCX+Bed39eejxq0d9GQ/Q4Z0OSG5QjcH6DChzwv7SpUA4oYA7NWINBUjK0SLhBy1tVTG6ILqt/jGj4sfq81daGXefUKxhkxhhkNx0tgrIYpX3oYa9Q2gXNWZ9myWzWVskMUJN+LA+oyk6mADy/r+CpkJSPf6NQfQOaqRbHyvpB2Vl3/zuhFTXT2qnjOYPj1HYFY/zvEOtXZKVKyoHso73kePQkzsb+6rxPfFejKxH/AovbyMegiWRfVOEvwu2hSKdgIKb8YfSkvn0Bcnlkpz6eNk49MscOfST8MMPVb+tnfweHbx586gCTJ2fpPzwZ34VKox2ffrM4K9qADxNaHec6PWOu9Z1S6Z1zuEuW2DtGd9bVM6HZzCBUADvfJo8/2yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9xttEG4ct8G7MHscsMB0mBH/suYPQQkdc41TA5EVWLj1triitAi47EcOd+3?=
 =?us-ascii?Q?2U+LZhuH+L94Tj0MdRDsAJF6qifBK5XM6WPGa9yaxYT+dhFzUpwUlEAkS8jZ?=
 =?us-ascii?Q?fZcPLKfx9mOa3cjQUOLUkpkg8gEQyB4ABb60BbaThbhHcmAChnhHHwbMM8N1?=
 =?us-ascii?Q?T5bcl+I9jI6sEhL5hErlGTILL5JbC+YlrVYItSa05GypPOF4FtrC0S9J1WXR?=
 =?us-ascii?Q?o5BY2hUjS5WIyWyFq8EiiM8tdIdxWw//3T/TeV72Fk12e/LcGLODJ+bBg+hP?=
 =?us-ascii?Q?UQmhtAC9ic9ZlHCM+/15bwZ1SisA1CMwxFRTXywd0AH+qBGlxCVij4Qte3vx?=
 =?us-ascii?Q?5i2TNTatKLDcvYHaJy1ABJ+YcIgOLxS8z0GGjEF5LWY2gUoEZe/F2VChzqUX?=
 =?us-ascii?Q?mMYbannGEerrZ+aRbdmuciYdqQMAiZpWUg4UEf9oX/trA2r7qnQUgT/4flx3?=
 =?us-ascii?Q?9QGOSI1SAIF53Bagoc8DNlmhaWCgA1WvQwAdmd/5NI51QnoI4pGJv0s62sU1?=
 =?us-ascii?Q?7jlDfCzr5Ev+GnHByJ9abzryJiN9Igi+IAtUapOotzYXV96wDVct4YI3okYN?=
 =?us-ascii?Q?a1/l2h0HIZBdFWnRV0+spl+xa/YsT8TqTKiubn2t2NOadwnhLf4nVeU0uiNp?=
 =?us-ascii?Q?A2ZQlIHxA4skyz1B2csAiplcoSA1eoA1MnJkHS+q/Ak2GJvYfR47gvGMMySo?=
 =?us-ascii?Q?MeP8KeVbnqEA43qRwVmMtHZC4Ki5V8YEBTLg3aBC5RDx/OWP2GXfTDhinW5P?=
 =?us-ascii?Q?HKTHkgsUitnyTIrFjxOwPsbWxtVnS4VnM0gL0P+0+J1nGpvnBgd55PEiZbLW?=
 =?us-ascii?Q?o8hia6ttUnLhD2jOt1bRZO2dWQuIIAtouFpn1yq1M2KrXJTzlHgHnMLFOxgd?=
 =?us-ascii?Q?GvwiiXLRtqRPM5Ubr26UlxBXHqQwUoYxFOJMnduWz2t3eQDe7mepGIEfbqu7?=
 =?us-ascii?Q?oSSQxnLwhDzfrTLWr6E1SRSfPA/Y3cpk+aZSkEc+Ik8JvH4FHRyaMSNLUUY6?=
 =?us-ascii?Q?kM+cMUl845WOeBwSPL0KSyun/z64VsRPhax41kFeihK+pYYyP4B3StX4FxtZ?=
 =?us-ascii?Q?X/T2o2UEec9rN0MMH/QTfaZkCNN6Dyv/qWrmo5GkP7dw/u6ZPvku1YLBflNs?=
 =?us-ascii?Q?CPmKg7+XpIHC+zek73IvSB6AzXRcG1fbr9uNtr9mrgnWuRlqN9+BOdu/t52D?=
 =?us-ascii?Q?1soIA/okCJZQCrJxuprrqSsbsP/vvJ2rWLkUbXz2g3SQUWWnX4+riiA5Yxpb?=
 =?us-ascii?Q?kFmNQXeTL+/sJ8x0FdW9o6bfExE47FJc6jHrYm/GJ7/gUuJgg1lzHx4rc0nD?=
 =?us-ascii?Q?whc4VaRwdASpsUVntdEV759PXqaiUTd0Mlz5KgJLC7UjAzBo7fJfFAFWbE9g?=
 =?us-ascii?Q?Poj9CXrrjN/iOx2iEKwLacDkBLoF66VNgBkPrvy+9/GMRdELzy3cOYpGYmz7?=
 =?us-ascii?Q?qK7rZDQ7eWfBVBcza1tgVUWyQwTA466nue3+nkAzC/4k07rVmk5o2friyrxE?=
 =?us-ascii?Q?Vw1Ugd9vbs97PcPCHL1b1Z6W20OwctM9aVXlu1ELTG7vDD0dkIylzCowgh8d?=
 =?us-ascii?Q?UNw7EmhHpxufAGUFCasdd5pYCP5pD0LiKvtiSahhX3G3P0bCtDtSZXxpb6Pg?=
 =?us-ascii?Q?zhjqiz/mkEtGTHsRQ54XNZSjd1wc/35jr3zgZb9Ncal0BNzpQI0uk9k6/eHa?=
 =?us-ascii?Q?UCjoipeLONY8Iws+0Yu3CSH9HDrhLUNmUkse4Az8IZLrrpKQGZpaKXZ3UDLu?=
 =?us-ascii?Q?m1hopvxWng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b454b2-7911-4c9d-77c2-08dee883fd80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:31:12.6780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5k/JwBfdk/z2pj7NyJ769fh9doOEcyi3IQ1OfNVgG2R3NSsXJZP4/FiEt77UC5ZYUGctDFBAPXwG0hfuTRqQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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
it's chipsets.

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

Changes since v2:

 - New for v3, split out from "drm: nova: Add GETPARAM parameter to read
   the GPU chipset"
---
 drivers/gpu/nova-core/gpu.rs | 64 +++++++++++++++++++-----------------
 include/uapi/drm/nova_drm.h  | 33 +++++++++++++++++++
 2 files changed, 67 insertions(+), 30 deletions(-)

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
index 3ca90ed9d2bb..cb13fba6b952 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -25,6 +25,39 @@ extern "C" {
  */
 #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
 
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

