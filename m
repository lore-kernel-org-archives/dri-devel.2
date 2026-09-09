Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BF2C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4927110EEE7;
	Wed,  9 Sep 2026 06:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8iYl4KB";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62E910EEE7
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFH+AXcRGchDS2Yj0d8upUAScTkFmPiqWnTvijlm1rNFs5wIG4+TG2PcfpZa71YAvuSksEaMAzMyD/Ommairu/RQFiNeMPZTkb3dBMQNAPpz2krQZsa7CTKj6G9NlDfQLtBLBvy4FAswY0dcPf2V4VUfS7IKhONvGgoMkOXpwoe28w0kQSO/d2w+PqE/CluvR2dPwolGOZA7TZk3HVM1AxqhEvYHSY3WsSTGor1yCkeDyRl9EqAJ88j2NyOqNXq4ON+DpYFmO0aiXnM/mLBPVghSKwHlhS9F3qSBlkdVyjhFltT2+r76+G4KBv8k2G33JUqMPcxphNyU7NYj+QbJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmetVQ+9xph/TpUjLXl4ZSrq7cho9/8+2PqfzdFbQwk=;
 b=ZGiLUswfT3594WLmjJQ7NvMPCfTFFCLsX7eGjv8uifaNBpfxYHMM36UaKmMauCkZXDi62mdVBurylDZ/PuPqwAwlo1fW2zKYmC1hbbkfb5YQaS2ABfqMzWp03+wGSayvc+aPqxWZh437nMNj+vUHQOEmOTJaQl4lDjHiH86pCL//bvKB7QzgOcd7RFOCVIehSWWHZtEeKTIXEKQvMlCTf5goCK+36TDm6VjDQKESvQGyfzVF4maZefKCkj4rfgGtQUyUkTgFwpsEBgYBKZdjuEHz4nVLJOOBuocejHS5ZHZKcyh153Gio01YoaWsjvmHSZuIiqXcr63GfR5fvsc5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmetVQ+9xph/TpUjLXl4ZSrq7cho9/8+2PqfzdFbQwk=;
 b=f8iYl4KBJDGeLoEHbOGpuCUAvzMpPHT8pE+r3PvpYBfoOS4wiqsAHFEI9khwW8ie4cy6kBWanwRKFFpEM4U9nJZC0tpUyz1fRcb8dBGuZC3TU6X50PK7K1+HbOAdaQf2vzZx9QELkswUSi10T3suLiSNZ1gFYkxb6t1adz5NXPJpZKrp15R+zp8nEBzNXffSfuf+X4WTsw5y01VzzjnJAhn0gkw3VJFZJ41+mZqXc6e699DNsFPaGCWHFAz2Da+n+Rjmaay9pMDNTXoaxyxJw0cZnv8HhDx1A/6pU6X1WberZkOQGm6LoFCcHhAjUiENHCpiOuKZZ4OCn3L1yQ4OIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:41 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:41 +0000
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
Subject: [PATCH v6 05/13] drm: nova: Add chipid enum to nova-drm UAPI
Date: Wed,  9 Sep 2026 16:44:58 +1000
Message-ID: <20260909064506.910162-6-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0038.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::17) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eed68b9-2105-4c75-534c-08df0e3df752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VEphPvU2IpYovLucNqyZGupFdZTkwMphiMZtfz7Fm/f4TyGmKqS6C/Sd21cDYL5/uO3cHEwZdmKCrCRSqNWv2qz9UKxwR5qkFF/yrmVvgsOR+5rYLhKIoanTEcbTiItV5NjSFjhf3paN0Acbam0nT/Dz1Cagq8m5zDW3Udg/cPs7jGwiQQIGIJp5Or/G2l6wJWulByNyhAbE6yA2NRKvLS4ZOKrz4kbzSbgi9pJysF0naXQb+UNgSX33qSy8lZQHGJI+Ejyzdufc/yPPJq7WcxTrFadsgfb2W4zOzSpp0scvKY0Po920M63GYuqyJXfZF8ea9tyoCkQNWWjdOYOLw/ERhGvRsookOFvoJVXNbFtjzjrlerQy97q689v3y05qwzZQQ91467T+KrOF28nOcDXZNCcofOzGZ3YwyL1dUMqvnQ8RyU/p8sGeF9OmijzsARgph3PF1gBllfjFBo50mh2qMB5BGAHmT10vMSubvuwoblQ8EQbMXcN+ETDfAFMxqjJ79lul9wXP368T3cVElOiKloPVX8x5hei/ZLt0p5X0k7gHdc9VHSSkhQfnxfGNB0Oxu6qpkI1HRks6/JgCxAs9ffJmHki+0gTJmew9IqyBSFxXIrItbQbHBl6334gu9eWEarHQTTgMUGZnIW4Xc7ZSEAL36221P/pugI+v4Us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g8gXbrBu+Zyr7n4kq//1QSclH9FCJUuGQZpYUg7LMFlal7S+ygDAYt+//QUm?=
 =?us-ascii?Q?Qy1BzcD08AeG/NtfjTgtEZyy9YyuXO4ao8751eP9fQSe1PKg7tLOAH1bL6x7?=
 =?us-ascii?Q?Iy6oHZrN667w5VeYJ3S+9o0FrBLr467BFx7F+Ntk0u4eKdbeYpyaZzY+tmA9?=
 =?us-ascii?Q?L/JZX5jeOp5y/+GOKgU19KY1bNchDZrpQ4+W+8sFd9n8VrRzDznjJPBD0UaS?=
 =?us-ascii?Q?Z6Gx2m7lt+1U3FdESkpV+JVxEQQaphn8PZuMII5fZRqPYkPU0JH0+QfVBDib?=
 =?us-ascii?Q?aIgdyE+mcFKnLLkhhN0xNyXowLjURC2prg4t8wh2w0BbSEWEetzUGW+iZuhV?=
 =?us-ascii?Q?rUm4Ls7RJ7Q+zB8S5CkxoJY5lzVRDRDbb0C0p6w5yq7nrjuEEI09FdKImSBA?=
 =?us-ascii?Q?mOlyurCb4ZcN3/9jN3jVEEtYQkfXJuUDbfvy+PAjLdgGUzF/tLm7MMmQXf/M?=
 =?us-ascii?Q?8wKyOk3CkaZHpCfMofBbtRTOp7Wejqe9HfskHbFwnrDJf6vQYDzVYtkMG44Q?=
 =?us-ascii?Q?WHT7pt4dNYMltQbwCrVFZ2tDoSo4SyLTjrSFD4BepxSmwpDKQ6a5u6tHEk2B?=
 =?us-ascii?Q?7z4bkCJ/mEU8Q/WlQAhUn3gFNmgHPTToM8yBU9q9IJ+9Z7vHlGCFHsmrNofw?=
 =?us-ascii?Q?DFdI4OTkHYdy3HAzxLR2UJXNbFdcNh0ggdyuVF1fnr/Ts6N6jHzJNEO50BST?=
 =?us-ascii?Q?FMbdQIChRZMf23Z3pE3hAgq8aPvxbaeHAbVqwVrn0MRT1J6/mHx/X7vFhxLL?=
 =?us-ascii?Q?+7IgBxgirZmmOOsx2z1HlpVmb3opKhMDh3JFcvJNyu4LudBg2vig/L2troG/?=
 =?us-ascii?Q?o5DnqFi+cY1q51dtsueBs8bZLU19V0VILWVcpvWCtUjaezEi63sbAXh+kJwF?=
 =?us-ascii?Q?wr//NpdYm/p4Tvi4TIR7klUFmNIbhEiylxRS0LnIHlFwEjC7pJRThP+G3wUX?=
 =?us-ascii?Q?EpR4P6V1bJ56RWAG8GArouACsCjaJIsCXGThOtpHo4tmadX0MkGjc6wwJYDh?=
 =?us-ascii?Q?41/1KUfYVpuE4x/2f2CkBHxkWEdHT/gUm0qx9r4NebronjJN9Gic1S8vf60v?=
 =?us-ascii?Q?RwO+yumtV4oKOE6+GuSukziHasPAw+63ZY9mXWkLihl5DR+wGAr2DLtfsC2m?=
 =?us-ascii?Q?PIlFBN1klFTgixtGmTupEXohjKnXLNiQSQlyppcP3t8+25kVS+gvuUnlaKyt?=
 =?us-ascii?Q?Cr8kmhH1nBMU/WsGgYsOJ7PAzv7alWabczZC96UuKmP+4rmpmK+fLehqgkBO?=
 =?us-ascii?Q?OGhKFTgxLMssq4k9d/selUjt4DYOQXWgFVuRH18HqTP1Ci7LgfW/fL246s0A?=
 =?us-ascii?Q?9rmiHcFMXhm7A4opBqnICQC+kNa/b8o74ya4T2cMYlHzQzuu2i+12oCEXdmE?=
 =?us-ascii?Q?W2hGntceYtmMkuz3Dx7nwOO9g0ZdKwPbJ+xcqHCvucU4ghqF6BQJjrikaR0i?=
 =?us-ascii?Q?04HPhOg3WKovvJWJTQyDKC3mI2riEuEykLDb67sE7DpkOTL66RJ5uAjd7HBX?=
 =?us-ascii?Q?h7eUuXJhqxLyUBG3YCFE1Ia5NyKr0/2SPmEgrJXvHHm5ajWhC/EkjU3ANgkR?=
 =?us-ascii?Q?rpY6S8b6Jb2ywBSbg8T1xaY8twBhNe6Vk1n1x/oG3TpXC6Vf/GuNgsU4l6D6?=
 =?us-ascii?Q?HjcMUYX1UINtgcx9GMAFxMviPN47q2yV3a7PksjSjgFKJSOu4uZJLtEQ8lsi?=
 =?us-ascii?Q?4s+02onw9y7w2JwrEhN+R8Yv7Kyizr35e9CktYZo/H1S73ooDyu23kYJfl2Z?=
 =?us-ascii?Q?5SvVjGsqiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eed68b9-2105-4c75-534c-08df0e3df752
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:41.8018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlIw8dzqLhBZWeg1iSlBwuJovsSdJOsC3eWANFbFdpvLStvDQbnBPiSznRZWpqFp1wgeYhh+70v+Q9RWHuTCvg==
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

The chip identifier uniquely identifies a GPU chip and needs to be
exposed to user-space so it can look up chip specific properties that
cannot be derived from the architecture alone. This adds a public enum
to the userspace headers for each chip ID. Nova-core can then use this
enum to define its chipsets.

The values are opaque to user-space. They may be compared against the
enum to identify a chip but user-space must not assume the values carry
any particular meaning or encoding.

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
Assisted-by: LLM

---

Changes since v5:

 - Re-added. Following discussion an opaque chipid is exposed alongside
   the architecture in place of the implementation.

Changes since v4:

 - Dropped in favour of exposing architecture and implementation.

Changes since v3:

 - New for v4, split out from "drm: nova: Add GETPARAM parameter to read
   the GPU chipset"
---
 drivers/gpu/nova-core/gpu.rs | 57 +++++++++++++++++++-----------------
 include/uapi/drm/nova_drm.h  | 40 +++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8726beb4f693..933bd3657db1 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -37,13 +37,14 @@
 mod regs;
 
 macro_rules! define_chipset {
-    ({ $($variant:ident = $value:literal),* $(,)* }) =>
+    ({ $($variant:ident),* $(,)* }) =>
     {
         ::kernel::macros::paste!(
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
+        #[repr(u32)]
         pub(crate) enum Chipset {
-            $($variant = $value),*,
+            $($variant = uapi::[<drm_nova_chipid_NOVA_DRM_CHIPID_ $variant:upper>]),*,
         }
 
         impl Chipset {
@@ -75,7 +76,9 @@ impl TryFrom<u32> for Chipset {
             fn try_from(value: u32) -> Result<Self, Self::Error> {
                 match value {
                     $(
-                        $value => Ok(Chipset::$variant),
+                        uapi::[<drm_nova_chipid_NOVA_DRM_CHIPID_ $variant:upper>] => {
+                            Ok(Chipset::$variant)
+                        }
                     )*
                     _ => Err(ENODEV),
                 }
@@ -87,35 +90,35 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 
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
index f0dcbca1908d..e35f09a1ebe8 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -37,6 +37,46 @@ enum drm_nova_architecture {
 	NOVA_DRM_ARCHITECTURE_BLACKWELL_GB20X	= 0x1b,
 };
 
+/**
+ * enum drm_nova_chipid - opaque GPU chip identifier
+ *
+ * These values identify the chip a GPU is based on. They are otherwise
+ * opaque: userspace must not assume the values carry any particular meaning
+ * or encoding, only that they may be compared against this enum.
+ */
+enum drm_nova_chipid {
+	/* Turing */
+	NOVA_DRM_CHIPID_TU102			= 0x162,
+	NOVA_DRM_CHIPID_TU104			= 0x164,
+	NOVA_DRM_CHIPID_TU106			= 0x166,
+	NOVA_DRM_CHIPID_TU117			= 0x167,
+	NOVA_DRM_CHIPID_TU116			= 0x168,
+	/* Ampere */
+	NOVA_DRM_CHIPID_GA100			= 0x170,
+	NOVA_DRM_CHIPID_GA102			= 0x172,
+	NOVA_DRM_CHIPID_GA103			= 0x173,
+	NOVA_DRM_CHIPID_GA104			= 0x174,
+	NOVA_DRM_CHIPID_GA106			= 0x176,
+	NOVA_DRM_CHIPID_GA107			= 0x177,
+	/* Hopper */
+	NOVA_DRM_CHIPID_GH100			= 0x180,
+	/* Ada */
+	NOVA_DRM_CHIPID_AD102			= 0x192,
+	NOVA_DRM_CHIPID_AD103			= 0x193,
+	NOVA_DRM_CHIPID_AD104			= 0x194,
+	NOVA_DRM_CHIPID_AD106			= 0x196,
+	NOVA_DRM_CHIPID_AD107			= 0x197,
+	/* Blackwell GB10x */
+	NOVA_DRM_CHIPID_GB100			= 0x1a0,
+	NOVA_DRM_CHIPID_GB102			= 0x1a2,
+	/* Blackwell GB20x */
+	NOVA_DRM_CHIPID_GB202			= 0x1b2,
+	NOVA_DRM_CHIPID_GB203			= 0x1b3,
+	NOVA_DRM_CHIPID_GB205			= 0x1b5,
+	NOVA_DRM_CHIPID_GB206			= 0x1b6,
+	NOVA_DRM_CHIPID_GB207			= 0x1b7,
+};
+
 /**
  * struct drm_nova_getparam - query GPU and driver metadata
  */
-- 
2.54.0

