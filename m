Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18620C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7649310E5CE;
	Thu,  9 Jul 2026 08:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SlFLCWHn";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012015.outbound.protection.outlook.com
 [40.107.200.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDD710E5CE
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFV/fzTGd4p4eFbTZ9zqhgQbOIeVUyv/tSqRhh/z3KmG1rr5iX+t1CuRsoQ2ijMl9iuyRmnzTD9XPeaZ2NLzaKqVXeNs4CdjpTpTzCdbft4PEZ1IGTiei1o4+4JwUGCJm8VGCkS50Satatt48P5NHb2rP+gh0AHYmcwPI2+GzHCct0s+7eHSkSqWt8JagXsle4HP1bytXdaC/GbhX81ETx+ikyVvhpO/1FPWSw0emGzwn7rG3yNgMyzDvRf/ufdq+e2efuBHjZmJ8UefQx4HNglBIKwEbxCjFFZd98tuDW2WkXmgw/IsyEsr491IIwhOiv+LROXz21Q+13QzIWLk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zWj9YnywTEJkHxINXU4DO5dwwfr/1xRYfquC7YnndM=;
 b=iJeeg6tb/nzEDiK6hignwwc/aKvQHQ4S6OjgzuMUaWnhbdrL4ACiulIX9SdsW+IYCtOuTpacrLYBQKJB78cTdjLQdY5IJ4W3M27t9l44WNpQTneRDhQQox10PrcaE87qVkQLi7g1EzXQ047Bd9HRvSerOOpUUxmsf07W75glsryeCe+jYxkBvjz9tT33X1LWap8YDIcIGQaF22vFy71RjUtD9FUtwKPrBmPcJHiu5e0JkjUJtUCn69ZIcg2Z0vBNobSxkEvEwcib7ELU9454pe7hlIxhXvpphyVz/WGoxbPli2aanzncMd3/bErPteyRmHSkcTD60FTyq8QzCHkuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zWj9YnywTEJkHxINXU4DO5dwwfr/1xRYfquC7YnndM=;
 b=SlFLCWHnMOUVu+TdzGrMor1N/OAwEgWozvkSrDJAydLhKN3c0OF8///D3OSUzWGx90OH5G+A6Q0svRuSuZDP54O9L32ilxGZAWsi8bE3rdAoQpOHODQ/hPMPCNpmb0v5Yr1bt0Hdi4SwK03yojQmQNUvu07f7WKXV1z5Fmmb7ZZJ+7glSnFYdm7AyEI+Z9+MiFPdE+9fveevzgGzRvMzqPiW/H3bATpDcaB/u2R8qjp8j+nxkYVC58WYeM2sD/autoyjhvjRmfeQWaoXgqqLmO6qh+cTv7YmxqOjVJuAQGvVrgObuIfjg75JOucC9UWAhAwQ0qT8+EXokne+DjFwVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DSVPR12MB999283.namprd12.prod.outlook.com (2603:10b6:8:41c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 08:52:33 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 08:52:33 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 4/5] drm: nova: Add a GETPARAM parameter to read usable
 VRAM size
Date: Thu,  9 Jul 2026 18:52:03 +1000
Message-ID: <20260709085204.565159-5-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709085204.565159-1-apopple@nvidia.com>
References: <20260709085204.565159-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0067.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::18) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DSVPR12MB999283:EE_
X-MS-Office365-Filtering-Correlation-Id: 565f3b84-d29d-4cf2-0a79-08dedd976a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: D2rPJHHEbXFBrOjYPYce8Y+0rqV9wcylnkjYzO45E3jRqKHqaQhYwOmcaZlrp0wVLaxaLkg7H0ebzv6/oCBTpjTk9dBk0ZO7RzqRPxNStGzTtzoIvXNKS5TM1Raq8kDgAr2hsOj15aq++0+le5auTKa9OFE/TlO9gHBSyXnRlU7UAHErTHSfqFploeidjla6/aM9UqzbqxoelpnzBBrAvfR6Z18weM3HVDt3O1MJHcz59mYoQ0PiH5uDKmZDPGcyzLRhsn4HF92v+5DGDDnfzuNl9r7rgGhCXi7pmfHa+uE+rQyBSY2YR3JTV8q2Vm45KtT29oqnN/YBOuTwsLdYnTiRsMe4netDRbBBo1ifnLqeol8q7vvUFOSacetZJaXmKs2EAesD6xpXpGuiJA4bay5gqUMHFUvVSk8HYVzoM4fHrdkAU+1lKBARY4E+OfI1pEiuQvAH6Uit7sOibHTP1n6w6XImMCE2jQbY+yM+/32e+2LKekIAW4oqVGdpB01hMQt0vWQC3SExje1lzV5fMc7vOrkjewoLonK58qkYFah00JdlK7njA+Jp3BYUv26DeCv0R2E0+VZiQ3+UOOzxaa3c0/XPuPY+QMXFiOEJxBnq0Qx9ynvvvXLcbo3v4aJQK19qyB0O2rnx5dQSaQSn1u9X1bwUTkG5JXUGtg9HFko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+42EYl+wUczhGH05YQcB1DPgcIiH7Ctkr28W2QrSD5kSR+AYd/R3lbIzl9g?=
 =?us-ascii?Q?DSF+6Quivwux7AQV3Kots6kLrogaGqYIivOJO9E0pEdPmBRoKWVJuQ7pFARu?=
 =?us-ascii?Q?FXDlGaubOUMa2WbkX/n+Wd7ViGLxkHQN/9wAoXoamU8o33HYFV0mIBJ8inS1?=
 =?us-ascii?Q?ZS/VRTUrr5soYlzJiqjT3upXXV4/XaKGdrny9uEVY8ezu0ARdZZj/naEjYOk?=
 =?us-ascii?Q?GBh96kM4GiEHjWwlbWxKDoxLMt4piUg/6GKqcKVbvKxbTAWy9Lt6NCC/rcP1?=
 =?us-ascii?Q?+UTB1tBQuASNHkHwZLU3cSlv93pohm4KuwmoVfP0et7oOdYoGmo42g9tj5KB?=
 =?us-ascii?Q?2UPBV2oGFqmjhw9m/dzAfZQE2PiJh20ue11kvhky5Xm9COPpUpy0hCgGeyop?=
 =?us-ascii?Q?uhQ10eQ9IJ0NFen/TBzsKP0AETwtc7ywRVLROm8arjPQl00/TpuXzpaMKlHP?=
 =?us-ascii?Q?BFV8vCxros0JojF/M+vKYOPamOVmH5XRIKyxYh2mwwRPbuLkpJUMehpnOS7t?=
 =?us-ascii?Q?RXsLV1wiQClRNGS63/Hhtgq1pg0olzXJjwhOR0tkKuQjQ/i8pJd1dfkRH/qe?=
 =?us-ascii?Q?FJ8mmUptIJ/WWWs0Tlv3FW+ojNnzftbzpBCnQwBsXx43ULOG2CdkEze8nplQ?=
 =?us-ascii?Q?czavMCHyaOJCSA05TJ083JNFBW2/43e4rcJL27GHGZs7LfHRH3tmUCTSURvz?=
 =?us-ascii?Q?bQ/O8WdWeoQhOacNPhP/uPYqoXQHHcO4uFYoh0DXMLLXhWl4/ZUae++FU8cP?=
 =?us-ascii?Q?NKTs7EJpESdXaX/fTiZ9VOpvvZdyILC+l18eaxxiaVx1F+5SvrFT2UhTIhDi?=
 =?us-ascii?Q?ciC3+dSVRjOySZLSR4CqOYbHiTxe1FX8VC/gtBUSaf1KWhV77K33snK/SM8Y?=
 =?us-ascii?Q?cqbUlOaQ8S7iTmx8AhUAISml9R1NwCeawYSuM5wyzOl1Iua/kIWn1udGh633?=
 =?us-ascii?Q?2kJDpgwYx6W+UUjfIpgtVPgYWcA7jIQFGHMnnXpOx/EvZI80Lcmk+H5PAfey?=
 =?us-ascii?Q?CW9kKqrXCYVSir5pHhkWq6c2iUuycfPmIZenA+ApDEvGwvc/xGh4fWMKOkHr?=
 =?us-ascii?Q?lGXkHrM0v/hDRWSVwzHPXHG3gnS30XmxF1RZ6LvWMJbuTnGlHI+5qLDu7+ql?=
 =?us-ascii?Q?COfvmSVOtGND5raz/n6W37S6ON+AEv5LCwa7WX0AHmDK+5qLh73mWbEOEN+n?=
 =?us-ascii?Q?yBEMXBKmez+SGVt3fCIA3pFeWc34NF8Yd2zQGUGK37YK1SOHwcmh4cLt5auQ?=
 =?us-ascii?Q?7H72laAD1jABWwTf5Oxssj2+7mmly9G9Co6/gKJFJJfqVMByifhJCciWS34C?=
 =?us-ascii?Q?bE9kAvOzJzzlVWJY+SbhG55LlymBD1Zn9BJbePbxncLR2ABVi0CLqFyKQzAl?=
 =?us-ascii?Q?uXNEoohQrXtNg2NZjlaBS76PqPr1mc4omYAGYFHKKsuX6Z1cR5UH+8kI3d0e?=
 =?us-ascii?Q?Ppgpigj1pG0juyzTW8ZRGCWkqi5WUZKxPpqmL2SIRGejFVkF3NRQ7aYTiVei?=
 =?us-ascii?Q?d4eh3l0zzTm3wP/V/gFDda9jWPFOV4hUOtl0/4mwPZN0FUwzCsRxr5S2wMvm?=
 =?us-ascii?Q?eeR1rrgN45p6Myie6rDTSrDRdKXuKGXPUmeNZkPNpulXuKxorLIrBrqIxnFC?=
 =?us-ascii?Q?tT0z4Rtw456E0O5QGpr/6/cgT3ao/AByZ4PQ2oxDJiJWJxzUUw1ShgHKmXF6?=
 =?us-ascii?Q?T3o90uc+XXntU7+IbRQarFc9K77abMHCsf7ibTwq3cXn0fzrVXqU1cUXwLYf?=
 =?us-ascii?Q?c3DjnqG2dA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565f3b84-d29d-4cf2-0a79-08dedd976a76
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:52:33.4700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aoEBhFGb54SnG/WsG+1ImlqfdaUn1BUqFXuWJ+P4pc/nhyos1D/OUDerNnTqMUxDyZj9KSJBnQigQ1CoZ2q3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999283
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
index 1e5364c619ed..31aea3283474 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -44,6 +44,7 @@ pub(crate) fn get_param(
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
             uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
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
index 1f4c5f3aa8ea..202adfbfa176 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -289,7 +289,7 @@ struct GspResources<'gpu> {
 pub(crate) struct Gpu<'gpu> {
     pub(crate) spec: Spec,
     /// Static GPU information as provided by the GSP.
-    gsp_static_info: GetGspStaticInfoReply,
+    pub(crate) gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -389,9 +389,7 @@ pub(crate) fn new(
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
index 86a3747cd31c..d1569acb7b92 100644
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
+        self.usable_fb_regions.iter().fold(0, |size, region| {
+            size.saturating_add(region.end - region.start)
+        })
+    }
 }
 
 pub(crate) use fw::commands::PowerStateLevel;
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 0382a4a70640..ffc34dfa1535 100644
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
 enum drm_nova_chipset {
 	/* Turing */
 	NOVA_DRM_CHIPSET_TU102 = 0x162,
-- 
2.54.0

