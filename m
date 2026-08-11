Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84638C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D719910EA5F;
	Tue, 11 Aug 2026 05:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="q9JPLxnq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CF910EA5F
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbzJ1Cp6Ged3xJAPKtVes4ME79cacp+NS/sdXPrRPd8ldSAfkyptVFrYzlI7KaN5YTT5ZHuZ7rkmaspfTzjyV1bDNHC203gqF2o8ScbHLgbmYXdoaAsb9InJglMXT6y2MQAAo6mpcl9ZLSzJRXf/5y1A341Lsuuupui3r8R5HXWR26RbwY+xSecBp/hXCVYIwivkhvs/Ll+Vtwl2BlIFm9TP+of0AgdcfR7xGCrSlfiExqOf2wV0VMf5761BtA6Urn2rXc4vK0bOCwswhYomxwdBmyYVxJytEOk76X1UQZzBvOImsLOX7hbvI02PohsymhW3MQn+04cOOEb5lOFOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4q/Zb5KAgM84vKRF+x3QLQ9l/Itkk0HYFjsrTgruRE=;
 b=ZLLNwEqSmXxMtmQ1CQ37qm2RLNuMtZ520Ff0aaXYU9Fw1NF2gzsz6A/25eXFHXWFg3XbkfXEpBKajLs/gzB3meZHVrDE7I9GPtN9NU1Sl6VjvLoyebxKxMFYPZ0XSLbJcKd6bezHKQpAvLDcbMqwayIkS2ubq6Kq8z46RDUzzBEx17MlF+uH+GcoPX2iKS1ZwsptVxavGhoTj9BloKQPo+D8zWG+sOqLFLzW8J1A9gUUhzIMbm1oowl8DvUvDLwXX2U5afiIg9ZdeFIok7Md3EQC/SXkAozeuVkO/NGpFMjp3TPhhnNR03H0eSLfFkNa+3aX5YYIU6KJBytChH43/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4q/Zb5KAgM84vKRF+x3QLQ9l/Itkk0HYFjsrTgruRE=;
 b=q9JPLxnqUi9IUol1n14bFVxnQg7lDWG7/0+zK7GWCs2jMMbyX0lfV+pVKbuN/Vf4vzTXPy/A4pAyBMXB1qKbpyaoW+/iYh27Ea9Kg6N7OLzixRkl6p9ordbEU5xvGqA8FL66IrBznlTDhOxDnT5aSXOHXd2lYpAbQbD9bW2jTOu3rr/w5CZzri8YBkwqE82STO3d0BKgOmf8FirsbkN3cg4Bslw7oK5qg3IUoYgeoJYNKVQ2xPfAQWzznABM64s7JsCBPAlvKdnVQE2ZnGep0b2mtqJwxnFxB6YBPeAeT9+GbhQNujMmzcHPWF0ALpod2VGe5bqOsIQ9r3CEXgBseg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:07:36 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 05:07:36 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 5/7] drm: nova: Add usable VRAM size to GPU info ioctl
Date: Tue, 11 Aug 2026 15:06:55 +1000
Message-ID: <20260811050657.646799-6-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811050657.646799-1-apopple@nvidia.com>
References: <20260811050657.646799-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0065.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d466f0-c1b5-406b-63e2-08def7667506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KiVySVgxAh9q3ZdwvCRhWTT5MgquxyPm2TSghKZm2WpCXp+mWeyTMw5Y2kXrZQoIwnK4DWdLQywp4ABKW9LplF69xGzA64RpRiX799klkc/ahavJjxumGOG+Au95bYLigfkLybrOaWo43UKrH5gxFxKWoEuPpsHWq3lZo8yMvk2X1ihQcIBfXuhTMpkHZHvTeKbX6n5WHS/eqrmHc0UV0it8/cOtmxUu3Jokb7ZRlfcT4YZmY+HBLH8wC35Z/gowG13JQuwkI40lyjj3a1GR1W1gwfBlBlVB7CLd9s4/4CFUxDHzGDf6wO4ZWcc4bxm2jMb7+M/TXL3WHgO91tX6AZCTJW48PPpqLavfvRcP6CO46/bAwA75AQXZ5x6JQy0NO9FICEhwJz4YFzcPKYli9nbCfHvA+ub6ETw3WBbBhE+A5O9P3jlkFuqzwhWymTOBfMo91flSYejWXdP147R3WAz4uizxFUSALqFByn4Olmkx+zI4+l0SjMh1r3KTKPxy9Vx2JIdn0O3qy1BH7a+wMchy/7L5ys7UBUSyoNPWsawhbmBYLS06D+ZdycoZytxIHAZMxe7YmgchyuPU064S/xplVVSzURiGEuDqp2SeXiT7k8U6a7EPVswXq89jCNrVq1VxAOlrllxtgIP5IA5C7ryWFwlUFBCCqCWX9TP3E7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjfXfz4CH7St2yQc7VqReRZ4+ADLRnsw7+UNd8lgjLuxF/C0mYlchR3Dgzu/?=
 =?us-ascii?Q?bepJsfx/Qg9NDZm5/ajsd2zfJs4b975w0pClGbhlq2Ac0b3yVxPuxVo3RGbp?=
 =?us-ascii?Q?vJciqCQZZg+YGCnRlmbRauEbgZveA7RFcDRJplPVGhSefnOWAev501ZXoHFQ?=
 =?us-ascii?Q?aZi5fWzp6r5xCfA5si7oCayiT///Sd4XDjhhbxwYzHc61xD4K9FiFdYIDXBU?=
 =?us-ascii?Q?dIWreYmY9+0Y0p4tSSnpiiidYoBbS5jSr4nUvEGAfHwi90gfIhv7IkgrGbCK?=
 =?us-ascii?Q?Mtywd3WMuknxFGPGsP65k65Hyy5xPPhZxZXA7g3zroUa7/bUX5d3hsisdEBS?=
 =?us-ascii?Q?OIFriJ1CsE01zlk5IaaBWcXk+/jc4c3nsJSaD8VFi6AforNW6laQQEItzfyU?=
 =?us-ascii?Q?3NjKx9G05EJ4OfGlI7/3Z7dX6k7lsoMHeH4cKTdqZxYSYe3Zt1Gryskcrour?=
 =?us-ascii?Q?PCvN/nkuEKxmYL6PENdfKMxfC/UdTSTFdWSoxKear5ztbPQA6/Yaa7OQOQfk?=
 =?us-ascii?Q?aLElnGGYUagttoF/WxlHZ7bKkE05rT3TeErORVu6uWuSCj4OH4xy+37xX8kv?=
 =?us-ascii?Q?nt2L6jAF7C4pTgyRgV5GPz/wa9gdSIUEXAG0nRLWiHzGBjioqX0HlSLUqHHz?=
 =?us-ascii?Q?+CJTt1eiEVrprzzoEIagiATkTfnSjyuJupFcSqgFoXIrNqkKr5fQ0agCc3Jc?=
 =?us-ascii?Q?KurTevd+si0bj9ZIXDztqZfH6I6aVI0Yp692rqmrpgszH1Hg0BhcGsREg5eg?=
 =?us-ascii?Q?sWA4d/CukE/asYbHn9B7OneQ+KXZa94qPb/jltDHdbCfONzWgo0x8EV9zuXh?=
 =?us-ascii?Q?+61yBZ7Uy+J06gcM1dj7Tty+0BxfxZWFJso//mZ0gINd6535fqttSZo72zZB?=
 =?us-ascii?Q?c7X086rYaeFzT3fdEiLUhxdLxGqi0UbXpRD8sV3lNeSekJwKrxxOwzhlwPuU?=
 =?us-ascii?Q?X73QNBgcXR9r/M8YbibLDNeYifeoQLz3lpMmgIPKF5heoAcjjyz6rarQAQck?=
 =?us-ascii?Q?gvTTBs9EuygyxL3nMDLmq71zI1ye3GA4RspfoQrktpoouRJ8QXdmaJ3CAacZ?=
 =?us-ascii?Q?FaPg2lhPquUv9eAJ1TaR3zVQYbckGnPiVMo2HC2zLwZHeauSqRmShvUxw5/L?=
 =?us-ascii?Q?pbI7eYVTbpOwEovsUEP+kRGd5iJyQv9Q1d6WlCiVd+xzqE8NN5yhVzTPhJ7B?=
 =?us-ascii?Q?lCWxZsnOUAvRGXCj+V4IJuR6x2oJ9axXrgo2iby1gk0x5s7Ufsn74J8LGmC2?=
 =?us-ascii?Q?KOONoMklzBxFBT/P9gSmZXuWUhitVBe/LFhZvy7u7VxI1mIaBQR0z8le+y8S?=
 =?us-ascii?Q?ZDBBKOwk9UI6It0D4AcGSeGMJCgfRqLEngWb8mxITWQnEFvVtRPtRBprL2VS?=
 =?us-ascii?Q?I+gCxpwOVuR5IJf8FAeIrQ+cOOBCzhVjKNS9TW7igsR5ij5Rj3Uev/WAqzFW?=
 =?us-ascii?Q?KtijBob5H7QPPfsgLEv0tyRFECKhMDDxkSaOM6KDf75MnlTYnwO/LvlFDxH2?=
 =?us-ascii?Q?cgBd9UR9B6q7/ujH1yfqECpQn87bKOjH0yU6zF+IR8Wt35fF+5vQiwz6t7PK?=
 =?us-ascii?Q?Su1wmBQaUDi0AZVs6937eeCcqxR1qwF9FByrVT9uf/Y7mJsTIy5K2sM/p2FR?=
 =?us-ascii?Q?vXWcuZnfazD7gsLJXeeHpg6hwSzv3dwC0LG9UbYYzXF3LWTY0ByVMWUQaLXm?=
 =?us-ascii?Q?wl6CRQM1WmxX0qXTfcILJGohwsT0c4nUVRTe0Gp2qthK2AAniZDWrbByoZel?=
 =?us-ascii?Q?k/RtvJJ29Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d466f0-c1b5-406b-63e2-08def7667506
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:07:35.9052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdqdUcI3Xg+FRjBMIpPmIm8cITlUxRQlSCOQAaxTejTht/0T1yjzUXSsZpT/+ZOCN4qSKVZtTje9fvFNz0ihGA==
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

Add a parameter to the GPU info ioctl to return the total usable
framebuffer size. The usable framebuffer excludes GSP carveouts and
other protected regions so may differ in size from BAR size and total
physical VRAM.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v3:

 - Partially new for v4 - previously this used GETPARAM
---
 drivers/gpu/drm/nova/file.rs          | 1 +
 drivers/gpu/nova-core/api.rs          | 5 +++++
 drivers/gpu/nova-core/gpu.rs          | 6 ++----
 drivers/gpu/nova-core/gsp/commands.rs | 8 ++++++++
 include/uapi/drm/nova_drm.h           | 6 ++++++
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 97688edd07af..cbe45d022ac6 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -92,6 +92,7 @@ pub(crate) fn gpu_info(
 
         gpu_info.size = size_of::<uapi::drm_nova_gpu_info>() as u64;
         gpu_info.chipid = reg_data.api.chipset() as u32;
+        gpu_info.vram_size = reg_data.api.vram_size();
 
         Ok(0)
     }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 09da0b4e9103..f025df90dc5d 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -33,4 +33,9 @@ pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
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
index 34a496ec3b38..7a2037105d29 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -283,7 +283,7 @@ struct GspResources<'gpu> {
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
-    gsp_static_info: GetGspStaticInfoReply,
+    pub(crate) gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -400,9 +400,7 @@ pub(crate) fn new(
                     dev_dbg!(
                         dev,
                         "Total usable VRAM: {} MiB\n",
-                        info.usable_fb_regions.iter().fold(0u64, |res, region| res
-                            .saturating_add(region.end - region.start))
-                            / u64::SZ_1M
+                        info.vram_size() / u64::SZ_1M
                     );
                 }
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 08380de39048..49ff3f5edcec 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -252,6 +252,14 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .to_str()
             .map_err(GpuNameError::InvalidUtf8)
     }
+
+    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
+    /// regions.
+    pub(crate) fn vram_size(&self) -> u64 {
+        self.usable_fb_regions.iter().fold(0, |size, region| {
+            size.saturating_add(region.end - region.start)
+        })
+    }
 }
 
 pub(crate) use fw::commands::PowerStateLevel;
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 2604e4d2698b..e315556dac26 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -140,6 +140,12 @@ struct drm_nova_gpu_info {
 	 * @pad: 32 bit padding, must be 0.
 	 */
 	__u32 pad;
+
+	/**
+	 * @vram_size: Amount of usable FB, excluding GSP carveouts and protected
+	 * regions.
+	 */
+	__u64 vram_size;
 };
 
 #define DRM_NOVA_GETPARAM		0x00
-- 
2.54.0

