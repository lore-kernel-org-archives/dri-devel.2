Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C37C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF90E10EF85;
	Thu, 23 Jul 2026 06:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bOfPXyVM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7871B10EF85
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 06:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWFIPtGHiFP2kiNHwfmZpRcD+vDVPG0cC7fK2WV4IqbRONpDCKEg2VGx+tMo5ltqhmB41blvRxaZGgPK2O2OQg1U2MkRlW5ngWLJtdq8z41P+qnry3lY0fIzBMT55ZjPeJY19Teo4vsi6qt0mFgULR2cPOBSliBBvlyDzn2EuOMSA0YsFr4sP2G5btncYn0ifE/a/Mhdq3I2V3s5Lgs/XSO7Ob1r5f0HX6kH+bfqxUwAuhKfoKQ+cQaSpCx/b7KX+YyO5lc4ukEtBm2m7jdKzcN44nZxwHpQiwDugW/7J0fY6EJpE3XCxj3jiEGx/5XTrpAtNJOyyXNbiq7/3xLh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UD1O4lOsu0SJixvLxWOszAZ9tqxh1d/Z+OI40UCm0s=;
 b=HoBFqcszAAGDtrlVSs9CCmSfbIyx6vuOzvDW7uM9tPugF8CHOS5bqdlXKVGEJCJUt9jxacK8Xr7f3h5KXTsVidcr6lalQDoF0QDVbfvw9/Gxl+oH41qh6GHn2EMRVxikQ9MpAUcQPKlQTNQg/NGwniZueRb3d3G8HnxvqQdOoOa4oEwL+TgRePN+SSsjSYbaRecRNqNXevKuhBeiXlGPAapUFMJg6Eev2fzP7oVMX9xYdQHClDsEsNowVRxtM6Qoll0UHpAAnJEh/8Ef1BCchawTFDKfeRbIJEXjUQSkJdktIHajq2sItmVEJ7T8OSTC+Da33flYdc7EWmFO/DHOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UD1O4lOsu0SJixvLxWOszAZ9tqxh1d/Z+OI40UCm0s=;
 b=bOfPXyVMl1gvO8iIFUtr+cU137iJ+cONXvT1VygIdVwTJGueALAI6NDamNtgxvtWJtfrTbu58C6Qt8eNbTM03mlqti3FOAVqN1BqZSbnECPOPwXmFeJ7i2wXSmDOIzoiQRIJoHPD1nU8+4nnispzkLqLH+M2G2BDjnlWAcnwVsS9hNE6zpgA/5oxCoQGwqS9V90VgxD6GYxMr9C79p/HgoLJV+XptG55ji8n8c26sc4fN30xESrIn4TH2HxXHOW63Fp1PyDSOk4hCmBKGajTLESSEQlPYtkBf+K/pY4YyS29Tf57mUQtMoGb87IDjmcJqFFQz43fHe6pzEwyzn75ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 06:31:22 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 06:31:22 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 5/7] drm: nova: Add GETPARAM parameter to read usable VRAM
 size
Date: Thu, 23 Jul 2026 16:30:43 +1000
Message-ID: <20260723063046.1265791-6-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723063046.1265791-1-apopple@nvidia.com>
References: <20260723063046.1265791-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0179.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2a30b4-8af7-4bab-6300-08dee8840318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|3023799007|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Fx8nbxILN2Kd/Nn5J20QkbAfBdMWTVTyTr81bIX6vNVjIGRg8oWjoynAQMUEYlV+z2IXXoDISZxuXhMBHHX9tmje7GM24vQgwU+NpyU/L/mZI96ak9mkbjIesj5L2cQM3tjue4pQm2Hb1nAv801eQFcJi3Hjsz5gJZU5JNGNC6uHWqtH6iDkuCWRKno7HezJsWzpzUr4uuvo7nN6Qmgm3ScWiOz8yJtaz5MNUVu+UIAz0LuX/c+PVF+mczhwgnbWOPpHdBc50SJTdhJzCrRPyn5zHVz6ZyryNOVxeB2bxFxi5ojkP3mfdKRI8TCXh0hUd7nfsVjJ8m4hQDMEKWjg7I8OOm2YOtd5+UQxEOirayzCiULvF4mxLbhyjXQmXXvcdKXekI9NgVymxleuwh0Cg9572Db5wOhjlxOAYvhJ7r9mc4e/WQBntGBeycu6X3nd4ODnHnrbV6wqNmDcDrJ+YudB8sfXIsdHpJMrz1DBxFlZ+WbidVO9PoqjiiEJQPLtXs2LddqRQMVihGy+rk6X/IHQi93mPTCFRMqAFczrkerSvjQaD+4i4g+swCFvPN0hr0LH3iQJ4LjLkfMGRr0unj/Np/ag7nKav3UySMPzdzofOWeDbeqF8ATBS54FtZjeNJ60bfqOjfh1sGePsk1ciWi+6bpI4GR6xNvE/OsA+vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PdzhcsD/J4iBNB6eaIszdXy/HBLA9kbPibPzUx5kGO+WdEeOLuOdh9/9mkoy?=
 =?us-ascii?Q?u4XpKVsYbIZm9waxbzchgTm+jHchUCvSJwKVtB6dz2k+acMRN/YB8f8doWwB?=
 =?us-ascii?Q?Z/ZOKc845pqgAt/ZIfXH6TYrl6uj9QBBvgg1fXqtH640JhDilZRCgqK07aWV?=
 =?us-ascii?Q?n3zFRP476873ipJKeOYgcyHpf/BlJE8KOD5YeGvzclQ9/0ZwQrVqe+D9Nr7B?=
 =?us-ascii?Q?kbvwQqBHpobnHHgFVSrjrraH8HhdPAR4FMXl+XDeah1DXzmD+pGk+NThn7OV?=
 =?us-ascii?Q?wLKwKryAaYBAF36nBA71uLaErMGoXDMc7ZmyYQnVu3fpszvOV3KLEmbnLSM3?=
 =?us-ascii?Q?MEOebtEpsuSo/8kIrUOATXgXNk+Jq3iy/Matzz6j78lCBwjsHcVWruL3qhpy?=
 =?us-ascii?Q?QPPkEw24GNncpsIPru2EZBVDvv5EIVZu2KDHf9kbBRHT+CxzM2GwQDobZsAX?=
 =?us-ascii?Q?Eq5/uh+s2FY1GEMGLNUNN+xMHOPtBUdsaPeIYEudVLUCQ+6OzFfUhhvRlZHo?=
 =?us-ascii?Q?LtVTQHDvBmU70OfxsnX0iPD7Z+t4WGLSBE/s7HhmdLoMaN0/5hw+5Ra/G96X?=
 =?us-ascii?Q?s9Urws5tCa/NJB9MnFfDPoohO35mT7c/EhbyHdBHzH/3e/1QxcG84XHg+l46?=
 =?us-ascii?Q?jLtkHTOKblml7qqXKCtsCE5zieBsBupyK2pQ1aCFI1F4zalCBf2tXPEjaghW?=
 =?us-ascii?Q?Prjs3oCDiFd9mUIlmuIlKgRa9Awv1w5oxu4j6XnzBFQOcR7KaV1aZueGBihH?=
 =?us-ascii?Q?7EByXhE6ieuCztTwwKy0wdApcseRII8V1DUVAuu9i1fpZ1RXWrg+hgHXQUAx?=
 =?us-ascii?Q?xyxFTB0hCR9KKt3OM8dauBuzU/XNkcEJskAqJeRswYbZiV6z1Pb9XsgNCGgm?=
 =?us-ascii?Q?CecRdSTmUwXFe4bbBnHOVa8oGbM9aQX1Egy+n/ZbOFn0AHIieyvuHkzNoLCi?=
 =?us-ascii?Q?JQNR1HKGkkorvOXrrnEgI6dyDdXoRxr+aTTRBEx7Z5eSWa4XpePMkz4TyRPf?=
 =?us-ascii?Q?UOEV+JG8WIFn2lX1VX1T2oxnVSZfELx8BpFo1cMXsNgULcb9pO5L4ColH6e/?=
 =?us-ascii?Q?QDOKUgKQh59LZ/jYoXRz5GgBJkF6Hr7uE0t3Pxgu/MneIE9MAEJBoZcPFM/6?=
 =?us-ascii?Q?UZMoXV5OViZfy/475o846FCev9s8YAZA22h6md2DN+5tJiyJPiotr3j5hikW?=
 =?us-ascii?Q?gH9YVli2ThOx/INip8NGTl7EAjpdHj8Liy+8h1cRCERJUeAz785n/dikvt/X?=
 =?us-ascii?Q?3naOQTF6Vh72KbMcyQ/VoD490viKx0CPeMcIzdLg1DLyGIJKSw2BjDXxacQ1?=
 =?us-ascii?Q?FjFOAJGM7PsNfAUsOTzG9K7POkPxbtzP14q+nQdevx2z59A9SeseMLS8X52B?=
 =?us-ascii?Q?Q8H6i+LhqikPvUeOM6cLBbLrm799qbqMq7WG1HOD399xROfAU1EhzAf8/qb9?=
 =?us-ascii?Q?M51XpffdhplOnCCuVuHHwDAynIDPAdbonJwM2Dgr+DQwcmCwaY/TlCEVUKw5?=
 =?us-ascii?Q?ybk3K8eCNgPfhtpUu2RmcusbtymHFuli6+Fs/E9SG8ALuLRMq1oHMYdpNj+T?=
 =?us-ascii?Q?sLJV6vFGBRQJUP/z764kK1rq+MMmUZiDRMJpoc0KjpnT0Raw21hMGX0lZYc+?=
 =?us-ascii?Q?F5KexRaiUSrU6HLv+mx+nzLlMsmTWsoyJ6fDx0BWnX6ognYgBl7nWVvIf4Z1?=
 =?us-ascii?Q?Soh1kEN+8yDcnIeaFRTO0HtlY6XPYDM7psQcoBxtRjYMQ1OZGvp+HhzwKTdy?=
 =?us-ascii?Q?Lba6GfEigQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2a30b4-8af7-4bab-6300-08dee8840318
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:31:22.0345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qc7ZC0HExgqBpR8qHTxtZyHjRsCa4gwYNpd75UCZp5zqIMBbqHakkv4WEpcCLd7BITfzYa5dtMQv1r+vnogIJQ==
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

Add a parameter to the existing GETPARAM ioctl to return the total
usable framebuffer size. The usable framebuffer excludes GSP carveouts
and other protected regions so may differ in size from BAR size and
total physical VRAM.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

 - Commit wording

Changes since v1:

 - Fix rustfmt
---
 drivers/gpu/drm/nova/file.rs          | 1 +
 drivers/gpu/nova-core/api.rs          | 5 +++++
 drivers/gpu/nova-core/gpu.rs          | 6 ++----
 drivers/gpu/nova-core/gsp/commands.rs | 8 ++++++++
 include/uapi/drm/nova_drm.h           | 7 +++++++
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 855f23877734..8c02be4f15bf 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -44,6 +44,7 @@ pub(crate) fn get_param(
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
             uapi::NOVA_GETPARAM_GPU_CHIPID => reg_data.api.chipset() as u64,
+            uapi::NOVA_GETPARAM_VRAM_SIZE => reg_data.api.vram_size(),
             _ => return Err(EINVAL),
         };
 
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
index 264fe4e65b3f..6581c91a0b78 100644
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
index c655302a40fd..0f9f4ffa5b90 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -32,6 +32,13 @@ extern "C" {
  */
 #define NOVA_GETPARAM_GPU_CHIPID	0x2
 
+/*
+ * NOVA_GETPARAM_VRAM_SIZE
+ *
+ * Query the total usable VRAM size in bytes.
+ */
+#define NOVA_GETPARAM_VRAM_SIZE	0x3
+
 enum drm_nova_chipid {
 	/* Turing */
 	NOVA_DRM_CHIPID_TU102 = 0x162,
-- 
2.54.0

