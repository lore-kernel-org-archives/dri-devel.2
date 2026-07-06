Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC810C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A29910E746;
	Mon,  6 Jul 2026 05:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rto/5i4P";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 267EC10E746
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUVWNqJQ70nTJB+PTwvX1LgL1NuhlRE1zfw1aHLEH/UgaHvq7Wyg98zFMdIig30UFjVgYGQ/tdlsHGkTAwoFbs75OIKqCBgYK7J7IpgFC5SCSqUO6Au/cOHzIKrKU/yU2KWY1vGx68l/M0FS9H4Zdklxt7TTytcQa0m7tGbMwyoqghezw7ZNiSPnAhcY4W2Cu8W3p+sN0HYHM/M14nXVLtPUtIzPbr5aLWVFi2PF/RF4tK4NYz1L0Aw0zwC7ZCl+PK0LZkJ/v7bwyDFdt0tNqG5ZpgFiB7XXZywoQk98QrS6frGUFqdpZVq8HjQEsz8ZM97XdHqgN2uS68ZvdQ2gUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4uCgTpDmGRmz0MKJbv6LA6bPRmqbns720AYeeJeroM=;
 b=jCXy0xg9jQhKGeSsoId+2gJCrrkV+bGwK/DxcEvTUWn8gxw8Asoz+6kgcpe9KeuS3765Tz49F7RiU7B7uqx6QX/3sa2jr4tli7z3mxK/RzjYqXJS0xkrcP5yA1+DNbGbjL0tXexT9cH0/dqcLA3+tY4GWYG75IKo+5YP5qD29Bzf+0hLFf5agGpOBN3jusj3f6zV4T7CvAzQga7ZMGFu8lXSRR+QSNlCfhsxwm9Kbx/Qn25w58MFZhJUjACzHzvj5ElEFArLXRPDnt46IgYmNMlmE+YAbRzhJmHS/aYq9iiYPab4QVhJTS2MW2y3gAqMg0c/9+9tI+NA9nf++ZwQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4uCgTpDmGRmz0MKJbv6LA6bPRmqbns720AYeeJeroM=;
 b=Rto/5i4PW7RJXjk3AAyVnM+IAFkHCxjjnChPzB8u5r7DcmqbdQeVK5Dtbi6BtQcpzvMNn2rLvoCvhUEizAKqOXecPXnYAFwmcKFBJVYqOY6EIMy1hvXCLaZblIi+iODu75A+9trd6KQq38A8ShbtRuVRUsaDJixQEBJvoMNVYqZGXiR2ReyjxmxzLUdSCV1749XtE6s0IFQa0W5l3SLgPMRqsR9cvDDCM80PlJ3Pum52mM2y6hN1MrjdZvTEb7huNvcRzFkQVYZ6cbNkzzjhEha2raSkj6+woGMvhUoDbScTlUw3DxLvnYksZsYBzfbs5wSLWCb9mFUW3Gf0EjERMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Mon, 6 Jul 2026 05:35:03 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 05:35:03 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 4/4] drm: nova: Add a GETPARAM parameter to read usable VRAM
 size
Date: Mon,  6 Jul 2026 15:34:12 +1000
Message-ID: <20260706053413.154135-5-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706053413.154135-1-apopple@nvidia.com>
References: <20260706053413.154135-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0004.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e68de5-12c6-4408-ea15-08dedb205469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: q1yR1pmY6KmjP/BPdySiy/QjWfmO62onQpz6XKOeJWeNMrHmm/CQSKBzhSyv1eukZ0jdfyi+kIGj4E+S8itfLwkQ543gppwFjGK208VNERIkjhBXsXSWKdZT2GLyeKhxDmf7Vy39wdBqAo7jUP8hL7XiGR99exQEs0KDLf3z9k/8+fQVmsxi/FxpnFKobyPYZVu6188WangDgRrTH8wlGConYjyuyJeD94vdLaMGg5fT2rveF6Rq+6ubJ1lrnzGHIQIlhfxN06TvE9OTsaq95WaImVz1yj4Ge1UL+/d+bscC70sS4yaEB7v+++CVEAcZ1GvPFt0tzhiQ5efZ8jDZnszkIvic1ctYuUEiG1L1ZCC/BbtEbZhguc89lTRK6WpN+LbkKeOUXfeflhW1UGWloOsWYGlV0fFh1PWPDwDiHlfqv44juP5qwsHD43hWKQFf+8g53sD1gVTAZ9GI+X3v0z/fNXWH3nRdiDLUxhZJsqGC8mJIVbWeWcxXRPq15qAiqFftT1UWdow5plafVVhQIvE91g3vqC4oDymgPBwl8FyOb6yTm0NTVPWmBUHgxONu/JY7yC96jCknn2TAVKRRbhCRR6Bfnb6b2uEB1c/R72LgzudVVQm3fLw2KZRFKWYdLARUTpciCe7evtsCo1MIduKSe1TFRjbVmtjCfxBBKhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AsQlVc3Q1vEzBSQKYfcK/knPpMu3ma9+F18Cmvw0QPVP54rJzuQiOI874Wcj?=
 =?us-ascii?Q?Mxnz8AEQEz4xvxkCBzBIIas2zPLgS7jb127BNCXNcDVa1MsT6TZCgmDhM1cK?=
 =?us-ascii?Q?PTm/Jr/Cz3jBVjBSFEiANwNtSLxObRqLVA2sDCHjFBzodhAbJsU/s5pHk7GB?=
 =?us-ascii?Q?G4LevlLLojgbXoiyxhEUCKjza084f1WObKFlVUzt/kUSds7APShGWwQ6eZ6d?=
 =?us-ascii?Q?6ipdQPIKeK1aTPLJ/GkNmZIX24AmWJ/yi6T+Y+T/g7t0atG1kqX/969tyrlL?=
 =?us-ascii?Q?P+PmYTb9ayoxmx3ZB2VuDBE5GBWLA9DlFNceNe7+zqraiThSuy7Zv/709HqF?=
 =?us-ascii?Q?I1TNowztzApVe3u/TXt90UCJRgK74C7jDgAkb3iB81ERzqIMAmgHolLugSi/?=
 =?us-ascii?Q?OqBJ+6jyb68lFxw3u5slzLaXeqCSJiO7Up8UiPR+JOg8ZDT5PUgo2jI4iFIF?=
 =?us-ascii?Q?7288WqZHuY7sYGAEn0VarKijC69Evo+B8hmCROXoScXFyZKRGQgc/Sbv7848?=
 =?us-ascii?Q?VV5jgtIcZBotJkrcBcUX44DQ0iEsLQ7mw+R9sXFYPnZYxswo7jkYltz6W6Tt?=
 =?us-ascii?Q?WDkj13S5jntuxuw7Zyel+GbGh4bS3rCGVNcmUwOWrjv7rZSnGsY9FOj/63Et?=
 =?us-ascii?Q?sLAT8Kd46nHvPslZ1pXJnZNezykssK1YMPKloiuuJ8iAYNAY1LmdRON1tZpK?=
 =?us-ascii?Q?QrEILGGC8LbeVZBfpKXy77QbtXkNrQ7RQUamHK1p8k94LgU4r7FuHWGc/Osf?=
 =?us-ascii?Q?DdyI7qTbiy+8xu9HieEybkmvbEWSxWRUKKsf4dqouI5GbwoqVBNCxTFPHZic?=
 =?us-ascii?Q?Zy+4geKY4ZqhtZQamxa0YXZjwmOUP0jxtxL+wSMO1q3hjCO+X/JbKu9jL5RN?=
 =?us-ascii?Q?CUrvzywPC2mqpWRWZcvEH5WwL4+6sIpIRRhlP6jcA/4Kg6qb/u4LeJXgFPTb?=
 =?us-ascii?Q?mhL3eNxUpezjt+UO4Ix08+BMhjtXmjdUHd2i0hnCP1EF01GZtoyD3O+cSSmf?=
 =?us-ascii?Q?244cLZVZ6ckzgfLNBfyhi4qZEgVpKp1ZAINLVSCMmfF9BoSW7HeuyxEi7+CM?=
 =?us-ascii?Q?yEc62i34PIzXFAAcEvhF6U0KxRRiMm1XbMbpmbrOaLGT8kjacJYIadUhxRym?=
 =?us-ascii?Q?9jn8+HmvrPMpQ2PFTUKmPyXZI1wfr6aPTH5e0R4D180gOdvWTYOTKuG1ufk9?=
 =?us-ascii?Q?ZaRVwQWs/wacZeHWGrrAs7/u3q0vP/OytADp9xPD+tU7FDwz/DH7Smk6nrZ+?=
 =?us-ascii?Q?0WXdgM6gXUby1NFr+bZzM0yzvwRD+ruj8Lx1Qq2BEfQfEdefv7jaYfzqRihv?=
 =?us-ascii?Q?5zbbE+aIxrefSnGUaqjVnrI4n1t3n7ryOWwg/dY2JZKfWHtTm/oN1IJUSRZ0?=
 =?us-ascii?Q?NMs2upS2/ZYCOxGsS4d21K8p75NGPWRaLlsbv9FYrarh09Wn7ZgU2OFlyY1n?=
 =?us-ascii?Q?JbWj/X/XpSn/RR5qESWQjRxsTlc1t24EcBBGXWNFoqPNiSh1OQLOahtEaV7B?=
 =?us-ascii?Q?KwhQ8xZ5Q0C/xYn91vQZHceoBhoAgdu6DJ7OHt6efNI40D1FLcD1bAS3AeFl?=
 =?us-ascii?Q?zfp+T4l6HKQnpcbf6W8l7nBLPNt/Y8mE4FgTjiElTZh9/YPCmUv1Iksjgu3j?=
 =?us-ascii?Q?JARnU/IjfVjLv3mnTnvyfhzWF/QUbZy7FVAmgQgsbPwb1Tnc3XT/4lM6DYA7?=
 =?us-ascii?Q?1YOeTb9MC51a74bhhOAwCWtlgx9EfxVmJxvwyq6YvfFV1EDe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e68de5-12c6-4408-ea15-08dedb205469
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 05:35:03.8153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T4VIi3PKO7SLa8/IwaWhqfbo1+Tf9Ze3y6UjQljSMrwKZ/52xKI5tsPj2oEQs+IATlZZfTC64Hbron+MPWiuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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
 drivers/gpu/nova-core/api.rs          | 5 +++++
 drivers/gpu/nova-core/gpu.rs          | 6 ++----
 drivers/gpu/nova-core/gsp/commands.rs | 8 ++++++++
 include/uapi/drm/nova_drm.h           | 7 +++++++
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index e573be34bb96..26d7bc198c30 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -39,6 +39,7 @@ pub(crate) fn get_param(
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
             uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
+            uapi::NOVA_GETPARAM_VRAM_SIZE => reg_data.api.vram_size(),
             _ => return Err(EINVAL),
         };
 
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index 14ca26e257d3..f55226afbd3b 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -31,4 +31,9 @@ pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
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

