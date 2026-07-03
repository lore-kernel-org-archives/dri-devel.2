Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCDCC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36CCF10E587;
	Fri,  3 Jul 2026 06:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TuDdf7WR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4346F10E587
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:45:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alA5xfTbhfEOlvoCXKJjmmQbrI4Fu/cjhXaB9ikSBiSnI+1uAKpve4b+aHbk/YXoiE66jMvgtM+Y1iB6tAq6OawewWny23FsJHoWzvv/eWTDMo9VJjZTZAyp5znI54xdPt50fbn1IGOxNHP8ulmWXm0QtwaUEOq79JmqSUCc/TZ/jxK+H+eo7tiUH+3yL+E639CVATNBQ4EblbrX3+AeTigVGzkCfh90q6Z7lSkwCxPOh6QpAj8iVgDwvaQKvenIkKkVYXL0j5eOutW+UXna1BFgOvkQujHGNYWflO/zJ9NvOnjNeDQSk/UaQ0ZEkdqto2tNRXPEUVeDBCEvkWu/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gazZfLbOEHbNdQObfLhaN9fdGuRRm3X5EG2vJHtOEk=;
 b=jLLhJOFcHXKMstcCQfjIwY1VxI1ErST+lVOrBrFdiL6YCySfFjQBr3WXvmHMUwqeeE8y3p9uaG668jbzCMCqkDYYnq7PYT9MXnfrSnOj/f2BmExQKeAoFuvladtw4wKubNcL3BaVPBG2iDDxgSievAqRvsXBNrdX7Y97EQfzity9jV5XiJJumulKpYy4LMP9ZF8WrRSlyE/B0235gTbvceQokZnlqdyeP8zvaBE4hkYW+x3mHx3AaBmDVTVJeyKkLe1086Ml/Wk5xelD8PooLg88LYTmHJOADdNQxTDr+OqekCsGULdTQPPfM6IcicQZmpbuLutSxZUBTvJJNP694w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gazZfLbOEHbNdQObfLhaN9fdGuRRm3X5EG2vJHtOEk=;
 b=TuDdf7WRRSpz9k2SRDcV1wTlNy+nYR41KdDPlMWlhj9y6yBYcYuZSyQ6XftnUPftL4kRWgik380n8IPCu6rAikpt0Na6kDrNDT8+TtKeClRVKuQf/ZAj0IDxoQA8E/y9zRwu8vyY8DlYExbcauj8gwC2eV5a9uucY0wpv24tFiPunuOHhb+P7N0iQm9nmyqw37b6VkDfmSPve36B+yL5i8p2Y6tb37cgYRhy+r39xxPgM9NepeykscF9wgOYo21LTmoo2NLcxSxOCPq+vXwZJRKpCOhxXB+tCNzbu0J8AvHUiJirZ1IYWTsn8zfgjkz51YHN8X6AW5iDBM23FlLw8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:45:53 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:45:53 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC 3/3] drm: nova: Add a GETPARAM parameter to read usable VRAM size
Date: Fri,  3 Jul 2026 16:45:26 +1000
Message-ID: <20260703064526.3630668-4-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703064526.3630668-1-apopple@nvidia.com>
References: <20260703064526.3630668-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0064.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6c3422-c6c8-49f2-1b29-08ded8ceba08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: JcWoMFbjmR3INTVHE033hfkwWc299fizrFxITp56DHhfNjMgHSvtjJYOucaMm0+TLvwdhMscSXe3cm3C88bbRyr8kCdMruWqH+xd9Tt7Xrwe5YSfQjXUNkVzrrOeFf/BR7Yioa3Q58EP/zE5lx1rDKx7MCit5Q/Bt4Jw+8ok2pe42N69iWX6I/mYt4iw0ZGhT3hDPTAWFqhY1iY7G0BaIFygNPYnCE5lKNPy+zUoHJA+mCdwJGSEbadKy2FvKvbNuSDil94t2cTRrm0HDUzvZseGIsQBsCN/RHh/ky2qW3S/1PMutA60TnS8mLDq3YPzRF1WIJQToQROmXxjTTNgVqfmFwFUaI3JcmECiNcGu6MYNvKtyV+TTWJFRsbcrTQDJIQgdmHySEdce9T2qJSu0BHY4ciR0Mrb5C/eTiBoSZhZ4nPI7/sXbYebgQ0FXMFKxXYaMCwH2lYjAKR/SVne1J1r8S+DfWmIMcdd4Cu8geZCOOcV59Wtfx/BfL31/jU9XrV+SAie7H4bTVC0Qvn+7M2OtaNUPPZ9XQSjRQL94B5oTm2GfqvwD9JxFjOMqU+Jyd8K1EbGjvRf7VL3zUG6cyslwMR04Q7e2HT2BVk6qSMC69GdovxPTmas8E6B+dBj84714pygQWxoaMByMKAZsZF8qT6V2Y6i4D445xfGYhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PxzRz8gQgZfozw7ChWvin4inpANvViFgXysKGS9x/HmlMshIQc98pi9MFj9z?=
 =?us-ascii?Q?Ep4qFGGV4QDL7vPdIP1jiZjUqdizB77FncoNmEQaLesHPTI/7kLqd5FCy0lg?=
 =?us-ascii?Q?TXZwFVUg91afvAENBNDVBr2F1XN1q0IIaX0e3aS12soL2uUGnDpEQqRKkw1+?=
 =?us-ascii?Q?+3fbcMpG/7CIbZadX1jxnzPy98g+jOIqxO9jsq87K3/vQ5TJGikfbbCG+ztu?=
 =?us-ascii?Q?gs65iUXC/9WNhtw+V1RFhS8Nhf+IfIEi8qCXmweHdbMio4h4Vbp8w1dfRvJp?=
 =?us-ascii?Q?vo7KGFXruN9QMtWwIVFub2O7izOsYXdio63y4NpPE+k/dFFxkKPKFws0hoeZ?=
 =?us-ascii?Q?2wod0rMrbzZVMQaSRpeOC2GWdIJDIWuVvPXp4RK3ZzVB/069vNHtcDZ+hEFN?=
 =?us-ascii?Q?gdYk1kqxsfpfxsIoDoBYaNrVZYnhaHTu92FfnUckcJ633bchnh3QrNMWjWKR?=
 =?us-ascii?Q?GBi5cX5GODr69ik32QMM26TOOUf+aYz13JgxGqKSow2Xsc/ZXFBxSlwZ3gAa?=
 =?us-ascii?Q?Vxk/bBku/mr7j5ox64BvNcKtpleXpEgddGzLme8WiwM514xxPhd6eUQ0FWmA?=
 =?us-ascii?Q?0a97tJlqa21Ymh7EgMkHzf3yAfzdNgXUkzDU2DDbti1Phs6z6gpNh1l/4G3s?=
 =?us-ascii?Q?xV8Z43Tgsm2MohNWjagKcX8Kd65LosQ61E02JlkC/b4dMgDtgJfS4z5/OILV?=
 =?us-ascii?Q?MF39S5mqakYOTB22CSxBuKZHYARaGjTtB3aImgLiFu8TaC8pPwOomm7w0Qvl?=
 =?us-ascii?Q?zAr7oXR8yFS/J+3jnyh+UcLrVRp/EiEio5o2Z945sjQXhZUlJ1Dku0HAVkEE?=
 =?us-ascii?Q?IaGMKKerWa2r888Df7dXQG+T/zmMJZnSqAy2SEP1lAzvv9I6jpaw5s2DQ4KE?=
 =?us-ascii?Q?08grfkNG7Y3twnEG0JUi1JAddtNh33NXr2D+qmXvC5tibYyOmzMMW1ps20fY?=
 =?us-ascii?Q?o5Lamf2ZL0dWl5TmxFMIEvMC8Cco/JOxw8IVwvWzO775n80uCM/Ik/driPcR?=
 =?us-ascii?Q?SqNmdLXTmxgQRi9Tbe0U6D/1McPIch+5RRo38tyjWW4YIJHj5HdyHgkVfrYq?=
 =?us-ascii?Q?VS/2Qti8Fk75mDPBFxt92SrWSGnmKubB1sEVu8pL5QCTExDkQd6oBdd7cQxr?=
 =?us-ascii?Q?jtvJgz06+2XH1WXOCTF4P9zoJLVSQSqqnp3wxlQNP+YqBhZHvx8QYtdlsNDo?=
 =?us-ascii?Q?RF2YvilGlz7Gdt9m7k1oBo/8eeoGHwlz5i7RQluy2QJjgspKHh3w5WZNEkuK?=
 =?us-ascii?Q?nbv9IGDxWOtKeHSPu41zcpI+5UFyjQFEIhmbIZH26/09u6lnfk9jdqRInSAr?=
 =?us-ascii?Q?m0dztHrFh3wEmcI4r0GelZG7GAcRz/7qgBBhGBKNAFZdhWU7/7Tzy4cC8SrR?=
 =?us-ascii?Q?ye6xSw1jZ77xyWsiShUzm3rjwlAxruhrdiFy4JNB5+aVFL1iT4Mf79bSl8ZQ?=
 =?us-ascii?Q?BUqETs69B5HVFve7r0glvyAxYv4feTuQQJw1QhauVLTO+Ga9pfKvcbuJEwml?=
 =?us-ascii?Q?gI8mxJamVEhohr/BtbPqj53y4sYwbiMdyghGIR4YKBLkbRvXLP50O/vBCxSn?=
 =?us-ascii?Q?dl95wAv9x7iiTYFYd1wZ2/cajTQD0HYvYSH27DoFbRpRvLAejY48/xa6kuKf?=
 =?us-ascii?Q?EOBbTjVhdeTins9m1+VQmxSa5QjpwtLuPzOeNegYHv3LXZn9SOvlE2w8beQV?=
 =?us-ascii?Q?EdDcA9rzziKuH2lcvwcpyxY9hElhewcgIVXlZ6B5IZVwWwnuXwPlIZbcA2wt?=
 =?us-ascii?Q?m7MNnVvV5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6c3422-c6c8-49f2-1b29-08ded8ceba08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:45:53.1109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wy3wj+nxjP5A64fwaS82ZRsDR/XJtSr4eniwg2uUp+3lUZxlV1QYNm/QEueVzS9DSS8hK+8cmu8QtEBTisx2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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

Add a GET_PARAM ioctl to return the total usable framebuffer size. The
usable framebuffer excludes GSP carveouts and other protected regions so
may differ in size from BAR size and total physical VRAM.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/drm/nova/file.rs          | 1 +
 drivers/gpu/nova-core/auxdata.rs      | 5 +++++
 drivers/gpu/nova-core/gpu.rs          | 6 ++----
 drivers/gpu/nova-core/gsp/commands.rs | 8 ++++++++
 include/uapi/drm/nova_drm.h           | 7 +++++++
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 8147dfb366d8..d6f7e21fbc48 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -44,6 +44,7 @@ pub(crate) fn get_param(
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
             uapi::NOVA_GETPARAM_GPU_CHIPSET => data.chipset() as u64,
+            uapi::NOVA_GETPARAM_VRAM_SIZE => data.vram_size(),
             _ => return Err(EINVAL),
         };
 
diff --git a/drivers/gpu/nova-core/auxdata.rs b/drivers/gpu/nova-core/auxdata.rs
index cd8a3511293b..0a07a10da327 100644
--- a/drivers/gpu/nova-core/auxdata.rs
+++ b/drivers/gpu/nova-core/auxdata.rs
@@ -17,4 +17,9 @@ impl AuxData<'_> {
     pub fn chipset(&self) -> Chipset {
         self.gpu.spec.chipset
     }
+
+    /// Returns the total usable VRAM size of this GPU in bytes.
+    pub fn vram_size(&self) -> u64 {
+        self.gpu.gsp_static_info.vram_size()
+    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index d4a71a1be6f1..a089843f6d0a 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -288,7 +288,7 @@ struct GspResources<'gpu> {
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
-    gsp_static_info: GetGspStaticInfoReply,
+    pub(crate) gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -388,9 +388,7 @@ pub(crate) fn new(
                     dev_dbg!(
                         pdev,
                         "Total usable VRAM: {} MiB\n",
-                        info.usable_fb_regions.iter().fold(0u64, |res, region| res
-                            .saturating_add(region.end - region.start))
-                            / u64::SZ_1M
+                        info.vram_size() / u64::SZ_1M
                     );
                 }
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 86a3747cd31c..e41227fc015d 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -242,6 +242,14 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .to_str()
             .map_err(GpuNameError::InvalidUtf8)
     }
+
+    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
+    /// regions.
+    pub(crate) fn vram_size(&self) -> u64 {
+        self.usable_fb_regions
+            .iter()
+            .fold(0, |size, region| size.saturating_add(region.end - region.start))
+    }
 }
 
 pub(crate) use fw::commands::PowerStateLevel;
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 63440f5dca9b..eb98817906a8 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -32,6 +32,13 @@ extern "C" {
  */
 #define NOVA_GETPARAM_GPU_CHIPSET	0x2
 
+/*
+ * NOVA_GETPARAM_VRAM_SIZE
+ *
+ * Query the total usable VRAM size in bytes.
+ */
+#define NOVA_GETPARAM_VRAM_SIZE	0x3
+
 /**
  * struct drm_nova_getparam - query GPU and driver metadata
  */
-- 
2.54.0

