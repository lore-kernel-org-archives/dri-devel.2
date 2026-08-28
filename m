Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF48C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C3410F213;
	Fri, 28 Aug 2026 03:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dmakCNqS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1416910F20F
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNGzOUWTlIg+lPAdN+27PeqJD+DkNeTSjv4uUwvMFUP7oipWaoxv+Fv9/FHI+gUvHh47MX0DG6aNwlAfvczXk//SfhDpAFhb/h1CsBSUQe6XkwGeBL56haIgXe8YKyFrPjj9IMLKzT4Co2UzP2Ywa3AsDXGCZ36KYeX7mwbE++taZr7yFtiVcipgcNS+YDPmGRDjRQ5MLiqEMfpBRaNLTAHG5JQZ0Xmow6e96ZeQjSDUzz2pGuwdf9d/N5FQG1gep1gN3xMWihIykIJ9uqxuSrJjSQoBGZ9HKL3irCwyo3FA6MXgD5gXNhq2sSO0BXrKN6BDlGJLMB+s4S2HcT3SRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu4pOJUCQxkI9fEGU9w4vBqmSEXMmJC2EyFHp4aAmwg=;
 b=ZpJ83i5Us1MSVLSqGpDuMs+4dvwJ7Onb32imW0KwJ8BVMLkIndBZuJUvCzgmskE9yfux8QwYByXlumT6QdBRiWvQGudyiaad46WZyk3k0DnhxO0sPwqRkqh7a82/vykYhnPmEs3j6HB51+XU+ePpWJKQWEL0p7G1wROKkJCKnOkodoH95COfCAb3CnN+hKkUgQ0sNroR/y+U8BYzvPv2QdORSUyw3ZxWvCAJM8mNs78ykPA8sYzn+rwx+K5GuANtUFzGOiRBiJ2f//Hntvb5g5wy+kSUBKUqa5XGDJHRWyN987Sj0WWJXOCFaCoc0pg/7UsKTSLbxKaIUtGKSvmN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu4pOJUCQxkI9fEGU9w4vBqmSEXMmJC2EyFHp4aAmwg=;
 b=dmakCNqSRXkru3PlfUiuTkvj5gOn6Uh3Rs7+2mYpRKgrzkI4PL6sXQDaHM/a3FTBfI5ULQpKi5o2JZizs6Zu2Z3HTc9r+LbjQ15BZ+I7QhDq6K4m+UDwfei9MhrL08+jUeX5g3mRwKiJ4dDVYqHJd+XNZBgygORaCANQzXwqt7X3EPRGy9HXfD5ueY7pGU4r3IW479+q3Fgi0VF3WFQS6MEZZp6TCxQG8hBIHMIlWaEacFN46eER07Xi7eSzhwFXyDL7kWGMTtwuHDHhzS9AvRhSFVa7Hq17/He3jRQ4qD0WstMvvmGHrukv00047HVXfajyfKWkv3uSqenv0T0dpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:22 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:22 +0000
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
Subject: [PATCH v5 06/11] drm: nova: Add usable VRAM size to GPU info
Date: Fri, 28 Aug 2026 13:35:26 +1000
Message-ID: <20260828033531.1117754-7-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0075.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::11) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: b90b9d75-bc3b-4a77-7541-08df04b58773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|3023799007|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +rRWVfJfjHVFD03gtANyXzMq1zS7e2sskLLQOnY7Nd+2ltU7FE3YvoHrjWKRuRi1xe4es9Ql+fZVE/nMYnCbF/vXlua0GPq8nScNs5C8S8gGcUKgFSO2MF+27TQiSrfRwySB8Hb1ezo070CFypL3iWU3mnIi+L3rDtfHml1m5sWC//ix3USEpNebdAmqflAbOpB8u63xxq4BeBQmlIhq+Jy0qDq3hkhfjY0C51hIrEoRGZ+/Bsi2HrHqAO2Ft4rhm5/6EJD2kIFf2GESaKoTKBY0tOCfi5m8MsJ0oV77TYb/taYasj0+l3IqNaSadlpn90z5/HS7gWg652shqc8zLiejWTY/dzoqQcf86DhehzTjjTK14/4SoI3yzclEr6Rg7NiRHNet07Itfngl/Oj0MfiX3S24EVn89fI5/PHnxxOfWM5TGJVwzDl1hh0NLn0jJafg4/TwfL+HgkIp8LMht/q/dWZl4EmW3lSGhnvcdzwLCDcv8k3jmywV3q0KKUcYZI/dxowG3JEg5CqmG6oGElya5p9Bzmzw8QB8mLBHBvuxAho/BgmP2QHy3NDVLkS9bxOQEaMmzeYPMcSG9MMGbx5EZcTyg6qF2tR4WM28HnAGM3wrVXjP5XqHpAjZ3I8oIJpyW00N8fRGQyjjzkx3FSh8terIvtVd2WXzWiLDIUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(3023799007)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9ykiPWc2i8YYGJxdhzxE6nvOjYsAVmyR/pnHNE/6HmoH7SyntJdAOpqvvt+?=
 =?us-ascii?Q?G4vPwpXRen0MQ+FwFWZpx/FAGpJug7MIRaRWXt3YNSStFFgQG6frbMlograg?=
 =?us-ascii?Q?JSv7vQtmlJRn6jc8rYtM8LxRav7X/Rpy7j2eIwYRYJkI7By1xZszCRQMnRNF?=
 =?us-ascii?Q?ZKid4qnyjyOlC4R46+DHqG0mOrVpOoU689x2z6jEXlrasqoVY9REPMJ/+haV?=
 =?us-ascii?Q?bPu4Xj616vPHwqPSY9h6IhFiLxa5au1jBCs/UFtWfa+jfAniNXeN54Bdc8sE?=
 =?us-ascii?Q?W/3PreY7CPMbCXUD2s2ywmQKCAoXs4OzYZLMipuL3N/y9G8fi93l4XAJKI0Z?=
 =?us-ascii?Q?USqH+VAEjGILRwZHFepmBJHiz2Q13J9wS3B0as1AqYM69WyjEHTQao6w/a1U?=
 =?us-ascii?Q?w87XQ4iPK/10WT6ns1fLxoSij6rzri6YnQ3vqIbhuj2DNuiHCzRHJ8lNo2Wn?=
 =?us-ascii?Q?t62zyPNA6qawvGsWUMBi5gMP10He352EaBplZS71Ko8q7Y7DRbeKkN2Cvv9E?=
 =?us-ascii?Q?dyuwy/Ikv0af0Y4LkFen6KlnoVbU4rroJzQk0BXWUv/dOQ9XHVhDWqs+/Ax9?=
 =?us-ascii?Q?ny1AUDndytC69faMRdRe+otI+PfXxgoSCIZreAom7sR6enIY5ejBfyrLCPMe?=
 =?us-ascii?Q?lW5mN34xL2j3jDxAEn1lu8m+9tPWQZ1hjjx2xJ4aGEHQnOWWtrccyqxKOZGL?=
 =?us-ascii?Q?a33YCnm5QvfYTICl4B28+sNhb161pa8qkTSyv/GwrcGR3T44BLuSkGxPccdl?=
 =?us-ascii?Q?K/qswiZtO7EsaxrMwIqvGQoRmnwdkJ9PDw9TqgADx2z25JYOFI6F9buZsp2i?=
 =?us-ascii?Q?z2XQDOClDIeaLV3QoI2ne7y5f4zKb7ZOGHpJ/DVl31I/ylw1fBvG1y4lRA/d?=
 =?us-ascii?Q?v6/Frp50REtnzlUABy3OYuPwUdUn4D2UIo1s34eAEYj6pHD3E6LdhEKdy1CS?=
 =?us-ascii?Q?vvKBS5Q6PoRJHJSTsRMjixLqBHDmNifp2htK3f6DxxabA5+ayxUuvOdGcq+K?=
 =?us-ascii?Q?hWOiIdbBa45v51Kw3MZphXReOpjd7MEmf6BMibBYOuAB4wakA842s5cGfj+j?=
 =?us-ascii?Q?wTkRoXrv9Wc690cnBQfa9ytNxzXA7OgnjaLOrw1FhKE9Feei9qEycv5zxdUk?=
 =?us-ascii?Q?NabgyhsHolBabor2vzMu6wihn1DueqvYfmOCvfieQdAHOZYkI6E5aYqyKU+s?=
 =?us-ascii?Q?h3sLH3o0vnrlUY4EpX/86FZztXbuSsZKCcAT9mRM99flWGOxRUVyZPwS8ztm?=
 =?us-ascii?Q?RMAqLMxNyXJrvpID2AsmTmTWbmgfgQQRNyCgY00yCJ3hXQMHuPIPhWjc8G7n?=
 =?us-ascii?Q?lQ3uY9OwwhNoB1zHB8a68hQH+Yr3r9wwDSW9oksax+wr1nIvZsLBokdyoQAY?=
 =?us-ascii?Q?P7ufUUm4F4gy4fpRwj4ZuDbJHJyE0au0JR3eXWOTaiwUkXQyRXJob6jCMSmM?=
 =?us-ascii?Q?k3pWpGohBPN/DlUrf/QidOMV4sYy+V+5g7sCEAADKTWyl6hzv2+pNRd5UM8C?=
 =?us-ascii?Q?B3OYilPXtIOXmwXRjChRA0zMJIgc5suo+/iNQx0qjx494QW7jY/DI7ZjWMzZ?=
 =?us-ascii?Q?K9d+ckyaVDHZ78mb9KsbM5DlUgz0/KyNd61eqDWVQET5aPHpF5WenFsWEMj9?=
 =?us-ascii?Q?EzwHD4qmxrQm4RkNDy00N+WJd+p2vLUM74B299NDjapKLSTfg63M4AwnCl5S?=
 =?us-ascii?Q?0Y4g3vjmOo7dncTNUajJ+5gq8+gPT7xb9fR4RMYfJBHiU+pnIcKBU5xxhYnE?=
 =?us-ascii?Q?9GVO7vmkmw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90b9d75-bc3b-4a77-7541-08df04b58773
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:21.9681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpF2j5pdlV2tJmH8YcCPH92k8rgbGkn2b6r2LATqkrFVcsE8eaZGJChnDkkkrZ3WymtR+qRjmYS/Nd8OoLTmag==
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

Add a field to the GPU info struct containing the total usable
framebuffer size. The usable framebuffer excludes GSP carveouts and
other protected regions, so it may differ from the BAR size and total
physical VRAM.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v3:

 - Partially new for v4 - previously a separate scalar GETPARAM
   parameter
---
 drivers/gpu/drm/nova/file.rs          | 1 +
 drivers/gpu/nova-core/api.rs          | 5 +++++
 drivers/gpu/nova-core/gpu.rs          | 6 ++----
 drivers/gpu/nova-core/gsp/commands.rs | 8 ++++++++
 include/uapi/drm/nova_drm.h           | 6 ++++++
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 097bf607485c..cd80c5402eba 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -38,6 +38,7 @@ fn new(reg_data: &DrmRegData<'_>) -> Self {
         Self(uapi::drm_nova_gpu_info {
             architecture: reg_data.api.architecture(),
             implementation: reg_data.api.implementation(),
+            vram_size: reg_data.api.vram_size(),
         })
     }
 }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index cff730a38c1d..1e73d27d701c 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -37,4 +37,9 @@ pub fn architecture(&self) -> u32 {
     pub fn implementation(&self) -> u32 {
         self.gpu.spec.chipset.implementation()
     }
+
+    /// Returns the total usable VRAM size of this GPU in bytes.
+    pub fn vram_size(&self) -> u64 {
+        self.gpu.gsp_static_info.vram_size()
+    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 740466af268d..3e074541af30 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -293,7 +293,7 @@ struct GspResources<'gpu> {
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
-    gsp_static_info: GetGspStaticInfoReply,
+    pub(crate) gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -414,9 +414,7 @@ pub(crate) fn new(
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
index ffc25fd8c47b..6453184af55b 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -261,6 +261,14 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
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
index 300285b520a3..b80bb50acaa1 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -136,6 +136,12 @@ struct drm_nova_gpu_info {
 	 * @implementation: GPU implementation identifier.
 	 */
 	__u32 implementation;
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

