Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F84C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4D810F780;
	Fri,  3 Jul 2026 10:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fvEmR/EY";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC2410F77C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y30X8oAvSEjH2oaqQlT+zUrrdgfRh2zKL0YQI/KgkedW+rtaUfh1oM6SqlkCm/51uJ1jBDDa32qgh5Z230IFqRRosOyv7+/Mzs5fXLcDPNSoriXWqBCzYSZexIwA1SaGdgk8s2EWFVClLgvGE0KPN0HkWwtVhrfvXM6gsrI225+WFwjtRjWtAzKshZdyktTNlpmBffoEVZPPUfUp1YmayFS3vZEIFDYHOd2XXNa0vLIRE3OgNGtwaSLyulpRllFVZf7ck6RNJCLLqlrS4nIRrSO5zW7OHEd9QuqDjvo5sVLB5itMcLkYlJkDcwn2/BLiYnvPrIjcUnjlGbFYEN+MwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/ZJt4JISauRKixb/Px9qbjTqY1HK3XhC2icEiPIL1g=;
 b=QPoU7imy6tV1zcTkO2HdsCIaBGVTBrsTFdH5iYCouM6CrBBX8uLMeB28QAUxFmOAD3meMVoE8AeOjF2RvH1Hw/DPYPJ1mp3vxR2xk3SUATdbcj8kXnbHMioZR7kg2IpHzss++7MQ/ZKWV/NYypG1wB+nZLqT6kf+u6QzdqNdCfFfezIjfriEgS08cT+SfksLbiwz1bxk0qyJlPlZDW4Wq7YbwEnoppN2dZ1D+CFpb5NLb6DzQbYQMGMqKPCAAJ9pHX0zKysCrZa9mbjCycwsyy1l9+DSG+5bhfQhm906YBbqK/srejuheJenx1rY89Ojd1P3rOQaX8Hev3SMpzFfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/ZJt4JISauRKixb/Px9qbjTqY1HK3XhC2icEiPIL1g=;
 b=fvEmR/EYLUkHu0n2p5BLWDEuND01iDOk3ej/yTHlryWOEvQLIlF3gFJRvNOKXTzhRWtDNZrHM4UuU4EAMXtUbwzBxet//U5T6roDgSR3NNwLuKinMxNAg+IjFzVMa4r+UvJT0M2VY7bJgTeVzS8zpREcfbfe57aHauBQ0pK85Yb3x8li4fyrODMi9YL3bb48dcgbrhB92mBXz7ilehs9riO5uWniIIq14tdL5Qh2OPuxpmVtL2ykRDSTFSjQMKAnN+JOcxoy0Chk7982Q3yFODzpwvnp0TXhKey/36Z2fJkYw5DQt8pWDbcJO0F1+Ksz9rf3tY5HUJVhm/v922+/9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:41 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:41 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:09 +0900
Subject: [PATCH v2 05/10] gpu: nova-core: split FbLayout into FSP and
 non-FSP versions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-5-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DU2PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:10:234::22) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 170298d2-a6d4-4296-27dc-08ded8ed03a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|3023799007|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JM6MT3PEvMXjFzLyeEcC0RNSfv9tYe1/L1ZG+Sr1T6nwpwl48Qw896hW3d1OKIjO14NDKj+iNezv6F64zqPzfx9ulLv1mtoEtmWfClNx9Ff4NqnIxz4Fk0UEJ5a3FYdaUx7NYQTVTLx4KB1oXTFiFbOjFGyRi6bceNpzJVeFAp9FM5x/+2496Xjzrq/Zh0PRjk1FkX682l+3sW0ZnS4LNJY4hcVMjNcF/LJEVMwudPUG3eUv2jv97IFnIO48bPQkOjBi+Wa2xuAQ85ruBuJ2a2wSNlzk6/HVFop1Dm5kJhR8NCUt6Q6h340APxklhRvQrAPG4cH0X62Uz6dhuy0FuxbD4lECIQl212YxpOX+c6VY0Q1+3jHQyUS6QpmPVbjreo8uf28JIngRt1WnJc3ZHN852hX11aj5y5DMNbglifS4UyeOMcoJJL3k5KmJVeWwkmgHHPLZyjIKZqxeh6MBikfB1dYYRtH5RgmaChn2w3/X4VeEcrouf3hT3Px8OWu8C/LMp3y9+qQpZzSoDQ5IFqVM6hbJlUwaVeOBeEaJ92ATxa5XVEJYoOXGTE5Ggc2o7CYBV18YgTNAk00YjdL+Mq9zAfh/wzgGsGXQo78OR17SHmhB9wUxBT+ztKaP+98/hAr1PXQHQwjpUrQwb/k2Mw35yrmYuF0TsdgchhDL2bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amN3UHI3K1FSSHlHZ1NYSG16eVF1MG02N0VxQmdreWRQZlBJZ0lONkNIeEFp?=
 =?utf-8?B?YTBDN01IQ3Z5OTAxTUxMYS9XTEFNSFpQVEhuOUJ6YWZzVFgzTFoyckVCQkZk?=
 =?utf-8?B?QUZzMTJEdUFJVGtXeW5vR1FWZlg5WEg0TjVnNlRrMEZFRk9pL29NbDBSMFUr?=
 =?utf-8?B?WUdpUVdFa0l6cUg3N3FtQXhjK2JsY1k5M3RzbmNXOUxNSVNQLzQ0Z0puSktU?=
 =?utf-8?B?YklDSVdxZWtFK0ZoL01SWXNBSjh4cUdaZEtxSDQ2bktmVjNFdkFlaDFvajhx?=
 =?utf-8?B?K0g4ZnJxZlJWRllERTRGaUJxWm5MVEhDRzJYZExQbjFsclZQanFqb2FGVEgx?=
 =?utf-8?B?OWVoRDR4cURCSjdMTThzM09yQW9xTDNmUWc2MVpySGIzVUlyOFh1ZC9aMVY4?=
 =?utf-8?B?YzUwOStoS0ZUYTdtRkZFN1FSSTkranpOT2xXK2RaTnZ3N0x5NEk5YlVFTXNU?=
 =?utf-8?B?bDJRdkhuRi9EZ1laTmJTZWZuWEhhRTFyR05lMDBPdko4amx6VE45dXpjcnVM?=
 =?utf-8?B?bVVGejR6dTR1MDVLZzRVUFNxT3FteG1uOVc2SWx3dlN2aW5jNXlMcmUxQVpJ?=
 =?utf-8?B?WEErbDBRajJkVDl6RkJSUGEzMnMxazVRKzY5ano2Z0FBY21OeUljcmxTNWVt?=
 =?utf-8?B?SkIrdVU2YlJ0c0JBWjg2WGZQZGc3cUVaV2IzaDZzSUFvRVFxWDEyVENRaUtV?=
 =?utf-8?B?R3NxTEZTN0FkdEpJUThZNWt1K2NwcG15dXR2ZWJzZDlZYk9Qb3ZlWWxHZVNC?=
 =?utf-8?B?YlNDRVkvdFBObnZRaEUxUlpwUitscGVwNS9WUGpyNURKQVVMdUxmUFNER1JR?=
 =?utf-8?B?R3dOdVN2anpaZXVVYkF4ZnlVTm5HUlpuODVNcFEyQVFoSS95SVg3SzJGWEFN?=
 =?utf-8?B?ZythdmpqL2thMEJMNzRkZ1UrY2Q3YklXK3cxL08wRThsZWlFc3U4NGpTcGdC?=
 =?utf-8?B?aiszSzBqK0tLVlJXOVVGNUx6Z255UG1JU0VEVXN4MHhSWkRiblBjWGRBK2dZ?=
 =?utf-8?B?d1BlUlVYakRaR3V4SjA3M1ZEeWhDN3YxWldBSE5pbVZNaXlyTy9qM0FKVFlE?=
 =?utf-8?B?YkJTalFaRkNBaE45NWVjdlREOFBkZmZnM0I1RFRPOVU3OWNYOWphUGE3S1p1?=
 =?utf-8?B?RkhEaG5ZUWxHUkwyYWFYSHkrS1FTYytZaDBvYjhCME1FOTZabnlMakJHWCtm?=
 =?utf-8?B?SmgrNHBjV25HcjEwRWpIWnNXTXQ2cER4UG5aNDFCdW5JdUl2SmUxNkJOTE9P?=
 =?utf-8?B?bUJtcEMwWS82MW5sM2lNaHdSNkNLSVRYYnI5QVJNdC9VcWVWb1JITzU4Mm1R?=
 =?utf-8?B?SGNtbU5jVlVIR3doODZ1V3Q4a0xmZytoRDlETUhGeWRxMFI5WDZTV2hWdWRC?=
 =?utf-8?B?aTVoOTZpV2NPWHZjQUdxenUxRFVBQ1hMRllEOXZlREg4SnlqeVB0QjhuaTB2?=
 =?utf-8?B?MTY1RUMvcjU0S005VE81NzRYTVJlczFOckZ5TVQ5K09ycnJyVGJRTTJZcXZY?=
 =?utf-8?B?aVBYeS90eFhabVM4WXh0WXV4UmFhd1EyT1J4QmkraVFBOCttbTcvNFp1MWhF?=
 =?utf-8?B?My9kdWRJVlgvWDYramN6MzJuT2NuSEUzelpGa3RlQTVIMHM5Q3VERHJvb0tE?=
 =?utf-8?B?aHJiUmdOVkhSZDNyYWhMZEtSSEg3Qi9LNUVyTXNVWC9HV0wrUHRseVIvZWYz?=
 =?utf-8?B?RE1DRVpzRlpjVWpYOVhsZ0F5bDNlcFZBSnRMMWhBejVWVEpxU3ZEMHNEakR6?=
 =?utf-8?B?Q2VxaUxWMjdBbnVHSnhyQnZPTWxqU2lzWnkvRlZFZS9tWHVGWXBDNGovNVY0?=
 =?utf-8?B?OEFmdldwaTdmaDgyT3FwMWJvcldJbDRZTWNhUkdWcEtqQTNDb2poK1h0ZEtN?=
 =?utf-8?B?WXIrTVVLN0FNemhUMGZOUnRQd3hwT0huc0t5aEZTcEtYUkQyemVaSjYvL1pH?=
 =?utf-8?B?Rk5vcjBuamVlQmNKN1U1bFhzcTlhcnBhd3k1OGNTVGFoSk9STUwzUTVZSDNj?=
 =?utf-8?B?ajd2ZVJNV0dGSTUrU0tyL29NQ0RzYWlPWDFuSVpBRUkzUUNmaEdHWHA2emxV?=
 =?utf-8?B?TkV2ZjB4K1JwekQzNnJqNGVFUElVUG4zaldKT2VYV0Z2aitBM2tMVDY5QWtr?=
 =?utf-8?B?QlpGSDNZcFYvQ3pkelgrQk42Qy9OWnU4aVRvdGtFZUlHeE1mcFdNQlZVMEFj?=
 =?utf-8?B?M29EWjJwalZPei9Kb3dRaTFYL21CNVdDaUcvbjQ3cmxJNWVOMjROQmpCbWZI?=
 =?utf-8?B?Qk04U3BMOTcweERoeXYvWDhCRmdxdjBIdDNZdkJCeDdtcUNiNTVoU3owbURF?=
 =?utf-8?B?UjYwUlpKSVRHbkkrK0VsQ2F6ZG1yNTRsSWRjamt1YndQd05lWnZxSzZHREFJ?=
 =?utf-8?Q?Vi6OjDKxJkiCdf3cpP1mqyAYBau21yD8OZ7uFPXXhDGWb?=
X-MS-Exchange-AntiSpam-MessageData-1: oE06uEBeM3tqgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170298d2-a6d4-4296-27dc-08ded8ed03a6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:41.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1aioblTN6oR1+Wdd9o4z/k/iJXg/Awhr5kRgpMb5ooKsfLLXSl6Y4tGDPZYiptVrudrHxrFEQPkoTnVxEUk4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

`FbLayout` is currently used for both pre and post FSP architectures. It
contains ranges for each region of framebuffer, but on post FSP
architectures, only the size is actually used by GSP. The offsets are
not decided by the driver. So, for post FSP architectures `FbLayout`
contains essentially guesses for the offsets. Instead, make separate
types so that we only store the information that's actually needed,
rather than keeping around offsets that may not be correct.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs            | 70 ++++++++++++++++++++++---
 drivers/gpu/nova-core/fsp.rs           | 15 +++---
 drivers/gpu/nova-core/gsp/boot.rs      | 26 +++++-----
 drivers/gpu/nova-core/gsp/fw.rs        | 95 ++++++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs       |  4 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 10 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 24 +++++----
 7 files changed, 178 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 273cff752fae..fd60f93258a9 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -144,11 +144,30 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-/// Layout of the GPU framebuffer memory.
-///
-/// Contains ranges of GPU memory reserved for a given purpose during the GSP boot process.
+/// Framebuffer information required for GSP boot.
 #[derive(Debug)]
-pub(crate) struct FbLayout {
+pub(crate) enum GspFbInfo {
+    /// Concrete framebuffer ranges for host computed framebuffer layout.
+    Ranges(FbRanges),
+    /// Sizes of framebuffer ranges for GSP-FMC computed ranges.
+    Sizes(FbSizes),
+}
+
+impl GspFbInfo {
+    /// Computes the framebuffer region information required for boot.
+    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
+        match chipset.gsp_boot_method() {
+            gsp::GspBootMethod::Fsp => FbSizes::new(chipset, bar).map(Self::Sizes),
+            gsp::GspBootMethod::Sec2 { .. } => {
+                FbRanges::new(chipset, bar, gsp_fw).map(Self::Ranges)
+            }
+        }
+    }
+}
+
+/// Framebuffer ranges needed for GSP boot process.
+#[derive(Debug)]
+pub(crate) struct FbRanges {
     /// Range of the framebuffer. Starts at `0`.
     pub(crate) fb: FbRange,
     /// VGA workspace, small area of reserved memory at the end of the framebuffer.
@@ -163,15 +182,17 @@ pub(crate) struct FbLayout {
     pub(crate) wpr2_heap: FbRange,
     /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
     pub(crate) wpr2: FbRange,
+    /// Non-WPR heap, located just below WPR2.
     pub(crate) heap: FbRange,
+    /// Number of VF partitions.
     pub(crate) vf_partition_count: u8,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
 }
 
-impl FbLayout {
-    /// Computes the FB layout for `chipset` required to run the `gsp_fw` GSP firmware.
-    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
+impl FbRanges {
+    /// Computes concrete framebuffer ranges required on non-FSP booting architectures.
+    fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
         let hal = hal::fb_hal(chipset);
 
         let fb = {
@@ -270,3 +291,38 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Resu
         })
     }
 }
+
+/// Framebuffer region sizes needed for GSP-FMC boot.
+#[derive(Debug)]
+pub(crate) struct FbSizes {
+    /// VGA workspace size, in bytes.
+    pub(crate) vga_workspace_size: u64,
+    /// FRTS size, in bytes.
+    pub(crate) frts_size: u64,
+    /// WPR2 heap size, in bytes.
+    pub(crate) wpr2_heap_size: u64,
+    /// Non-WPR heap size, in bytes.
+    pub(crate) heap_size: u64,
+    /// PMU reserved memory size, in bytes.
+    pub(crate) pmu_reserved_size: u32,
+    /// Number of VF partitions.
+    pub(crate) vf_partition_count: u8,
+}
+
+impl FbSizes {
+    /// Computes the framebuffer region sizes for GSP-FMC boot.
+    fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
+        let hal = hal::fb_hal(chipset);
+        let fb_size = hal.vidmem_size(bar);
+
+        Ok(Self {
+            vga_workspace_size: u64::SZ_128K,
+            frts_size: hal.frts_size(),
+            wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
+                .wpr_heap_size(chipset, fb_size)?,
+            heap_size: u64::from(hal.non_wpr_heap_size()),
+            pmu_reserved_size: hal.pmu_reserved_size(),
+            vf_partition_count: 0,
+        })
+    }
+}
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 5b782aa2e3fd..533fb95573ab 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -31,7 +31,7 @@
         fsp::Fsp as FspEngine,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::FbSizes,
     firmware::{
         fsp::{
             FmcSignatures,
@@ -136,14 +136,14 @@ struct FspCotMessage {
 impl FspCotMessage {
     /// Returns an in-place initializer for [`FspCotMessage`].
     fn new<'a>(
-        fb_layout: &FbLayout,
+        fb_info: &FbSizes,
         fsp_fw: &'a FspFirmware,
         args: &'a FmcBootArgs<'_>,
     ) -> Result<impl Init<Self> + 'a> {
         // frts_vidmem_offset is measured from the end of FB, so FRTS sits at
         // (end of FB) - frts_vidmem_offset.
         let frts_vidmem_offset = if !args.resume {
-            let frts_reserved_size = fb_layout.heap.len() + u64::from(fb_layout.pmu_reserved_size);
+            let frts_reserved_size = fb_info.heap_size + u64::from(fb_info.pmu_reserved_size);
 
             frts_reserved_size
                 .align_up(Alignment::new::<SZ_2M>())
@@ -153,7 +153,7 @@ fn new<'a>(
         };
 
         let frts_size: u32 = if !args.resume {
-            fb_layout.frts.len().try_into()?
+            fb_info.frts_size.try_into()?
         } else {
             0
         };
@@ -339,15 +339,12 @@ fn send_sync_fsp<M>(&mut self, dev: &device::Device, msg: &M) -> Result<KVec<u8>
     pub(crate) fn boot_fmc(
         &mut self,
         dev: &device::Device<device::Bound>,
-        fb_layout: &FbLayout,
+        fb_info: &FbSizes,
         args: &FmcBootArgs<'_>,
     ) -> Result {
         dev_dbg!(dev, "Starting FSP boot sequence for {}\n", args.chipset);
 
-        let msg = KBox::init(
-            FspCotMessage::new(fb_layout, &self.fsp_fw, args)?,
-            GFP_KERNEL,
-        )?;
+        let msg = KBox::init(FspCotMessage::new(fb_info, &self.fsp_fw, args)?, GFP_KERNEL)?;
 
         let _response_buf = self.send_sync_fsp(dev, &*msg)?;
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index c347558aa8e5..14fd96084746 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -16,7 +16,7 @@
         gsp::Gsp,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::GspFbInfo,
     firmware::{
         gsp::GspFirmware,
         FIRMWARE_VERSION, //
@@ -50,23 +50,21 @@ pub(crate) fn boot(
 
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset, FIRMWARE_VERSION), GFP_KERNEL)?;
 
-        let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
-        dev_dbg!(dev, "{:#x?}\n", fb_layout);
+        let fb_info = GspFbInfo::new(chipset, bar, &gsp_fw)?;
+        dev_dbg!(dev, "{:#x?}\n", fb_info);
 
-        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
+        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_info))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_bundle = hal
-            .boot(&self, &mut ctx, &fb_layout, &wpr_meta)?
-            .or_else(|| {
-                dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-                dev_warn!(
-                    dev,
-                    "The GPU will need to be reset before the driver can bind again.\n"
-                );
+        let unload_bundle = hal.boot(&self, &mut ctx, &fb_info, &wpr_meta)?.or_else(|| {
+            dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+            dev_warn!(
+                dev,
+                "The GPU will need to be reset before the driver can bind again.\n"
+            );
 
-                None
-            });
+            None
+        });
 
         let mut unload_guard =
             ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unload_bundle)| {
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 2590931262af..3b148147cb18 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -29,7 +29,7 @@
 };
 
 use crate::{
-    fb::FbLayout,
+    fb::GspFbInfo,
     firmware::gsp::GspFirmware,
     gpu::{
         Architecture,
@@ -215,11 +215,65 @@ unsafe impl FromBytes for GspFwWprMeta {}
 
 impl GspFwWprMeta {
     /// Returns an initializer for a `GspFwWprMeta` suitable for booting `gsp_firmware` using the
-    /// `fb_layout` layout.
+    /// framebuffer information.
     pub(crate) fn new<'a>(
         gsp_firmware: &'a GspFirmware,
-        fb_layout: &'a FbLayout,
+        fb_info: &'a GspFbInfo,
     ) -> impl Init<Self> + 'a {
+        #[derive(Default)]
+        struct WprMetaFields {
+            gsp_fw_rsvd_start: u64,
+            non_wpr_heap_offset: u64,
+            non_wpr_heap_size: u64,
+            gsp_fw_wpr_start: u64,
+            gsp_fw_heap_offset: u64,
+            gsp_fw_heap_size: u64,
+            gsp_fw_offset: u64,
+            boot_bin_offset: u64,
+            frts_offset: u64,
+            frts_size: u64,
+            gsp_fw_wpr_end: u64,
+            gsp_fw_heap_vf_partition_count: u8,
+            fb_size: u64,
+            vga_workspace_offset: u64,
+            vga_workspace_size: u64,
+            pmu_reserved_size: u32,
+        }
+
+        let fields = match fb_info {
+            GspFbInfo::Ranges(ranges) => WprMetaFields {
+                gsp_fw_rsvd_start: ranges.heap.start,
+                non_wpr_heap_offset: ranges.heap.start,
+                non_wpr_heap_size: ranges.heap.len(),
+                gsp_fw_wpr_start: ranges.wpr2.start,
+                gsp_fw_heap_offset: ranges.wpr2_heap.start,
+                gsp_fw_heap_size: ranges.wpr2_heap.len(),
+                gsp_fw_offset: ranges.elf.start,
+                boot_bin_offset: ranges.boot.start,
+                frts_offset: ranges.frts.start,
+                frts_size: ranges.frts.len(),
+                gsp_fw_wpr_end: ranges
+                    .vga_workspace
+                    .start
+                    .align_down(Alignment::new::<SZ_128K>()),
+                gsp_fw_heap_vf_partition_count: ranges.vf_partition_count,
+                fb_size: ranges.fb.len(),
+                vga_workspace_offset: ranges.vga_workspace.start,
+                vga_workspace_size: ranges.vga_workspace.len(),
+                pmu_reserved_size: ranges.pmu_reserved_size,
+            },
+            GspFbInfo::Sizes(sizes) => WprMetaFields {
+                non_wpr_heap_size: sizes.heap_size,
+                gsp_fw_heap_size: sizes.wpr2_heap_size,
+                frts_size: sizes.frts_size,
+                gsp_fw_heap_vf_partition_count: sizes.vf_partition_count,
+                vga_workspace_size: sizes.vga_workspace_size,
+                pmu_reserved_size: sizes.pmu_reserved_size,
+                // When only sizes are supplied, offsets and several other parameters are not used.
+                ..Default::default()
+            },
+        };
+
         let init_inner = init!(bindings::GspFwWprMeta {
             // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
             magic: bindings::GSP_FW_WPR_META_MAGIC as u64,
@@ -237,25 +291,22 @@ pub(crate) fn new<'a>(
                     sizeOfSignature: u64::from_safe_cast(gsp_firmware.signatures.size()),
                 },
             },
-            gspFwRsvdStart: fb_layout.heap.start,
-            nonWprHeapOffset: fb_layout.heap.start,
-            nonWprHeapSize: fb_layout.heap.end - fb_layout.heap.start,
-            gspFwWprStart: fb_layout.wpr2.start,
-            gspFwHeapOffset: fb_layout.wpr2_heap.start,
-            gspFwHeapSize: fb_layout.wpr2_heap.end - fb_layout.wpr2_heap.start,
-            gspFwOffset: fb_layout.elf.start,
-            bootBinOffset: fb_layout.boot.start,
-            frtsOffset: fb_layout.frts.start,
-            frtsSize: fb_layout.frts.end - fb_layout.frts.start,
-            gspFwWprEnd: fb_layout
-                .vga_workspace
-                .start
-                .align_down(Alignment::new::<SZ_128K>()),
-            gspFwHeapVfPartitionCount: fb_layout.vf_partition_count,
-            fbSize: fb_layout.fb.end - fb_layout.fb.start,
-            vgaWorkspaceOffset: fb_layout.vga_workspace.start,
-            vgaWorkspaceSize: fb_layout.vga_workspace.end - fb_layout.vga_workspace.start,
-            pmuReservedSize: fb_layout.pmu_reserved_size,
+            gspFwRsvdStart: fields.gsp_fw_rsvd_start,
+            nonWprHeapOffset: fields.non_wpr_heap_offset,
+            nonWprHeapSize: fields.non_wpr_heap_size,
+            gspFwWprStart: fields.gsp_fw_wpr_start,
+            gspFwHeapOffset: fields.gsp_fw_heap_offset,
+            gspFwHeapSize: fields.gsp_fw_heap_size,
+            gspFwOffset: fields.gsp_fw_offset,
+            bootBinOffset: fields.boot_bin_offset,
+            frtsOffset: fields.frts_offset,
+            frtsSize: fields.frts_size,
+            gspFwWprEnd: fields.gsp_fw_wpr_end,
+            gspFwHeapVfPartitionCount: fields.gsp_fw_heap_vf_partition_count,
+            fbSize: fields.fb_size,
+            vgaWorkspaceOffset: fields.vga_workspace_offset,
+            vgaWorkspaceSize: fields.vga_workspace_size,
+            pmuReservedSize: fields.pmu_reserved_size,
             ..Zeroable::init_zeroed()
         });
 
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 46428c623087..ddd356fafc1e 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -11,7 +11,7 @@
 };
 
 use crate::{
-    fb::FbLayout,
+    fb::GspFbInfo,
     firmware::gsp::GspFirmware,
     gpu::Chipset,
     gsp::{
@@ -42,7 +42,7 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
+        fb_info: &GspFbInfo,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
 
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 270703d0f5c6..6fc6d487e4c8 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -15,7 +15,7 @@
         gsp::Gsp as GspEngine,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::GspFbInfo,
     fsp::FmcBootArgs,
     gsp::{
         hal::{
@@ -136,13 +136,17 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
+        fb_info: &GspFbInfo,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
 
+        let GspFbInfo::Sizes(fb_sizes) = fb_info else {
+            return Err(EINVAL);
+        };
+
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
@@ -153,7 +157,7 @@ fn boot(
 
         // Keep the result as we want to wait for lockdown release even in case of error, to make
         // sure `args` is not accessed by the GSP anymore.
-        let res = fsp.boot_fmc(dev, fb_layout, &args);
+        let res = fsp.boot_fmc(dev, fb_sizes, &args);
 
         wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params())?;
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index c7d5f1ab86a9..66e927a49cab 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -17,7 +17,10 @@
         sec2::Sec2,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::{
+        FbRanges,
+        GspFbInfo, //
+    },
     firmware::{
         booter::{
             BooterFirmware,
@@ -142,7 +145,7 @@ fn run_fwsec_frts(
         falcon: &Falcon<'_, GspEngine>,
         bar: Bar0<'_>,
         bios: &Vbios,
-        fb_layout: &FbLayout,
+        fb_ranges: &FbRanges,
     ) -> Result {
         // Check that the WPR2 region does not already exist - if it does, we cannot run
         // FWSEC-FRTS until the GPU is reset.
@@ -160,8 +163,8 @@ fn run_fwsec_frts(
             falcon,
             bios,
             FwsecCommand::Frts {
-                frts_addr: fb_layout.frts.start,
-                frts_size: fb_layout.frts.len(),
+                frts_addr: fb_ranges.frts.start,
+                frts_size: fb_ranges.frts.len(),
             },
         )?;
 
@@ -200,12 +203,12 @@ fn run_fwsec_frts(
 
                 Err(EIO)
             }
-            (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
+            (wpr2_lo, _) if wpr2_lo != fb_ranges.frts.start => {
                 dev_err!(
                     dev,
                     "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
                     wpr2_lo,
-                    fb_layout.frts.start,
+                    fb_ranges.frts.start,
                 );
 
                 Err(EIO)
@@ -261,7 +264,7 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
+        fb_info: &GspFbInfo,
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
@@ -270,6 +273,9 @@ fn boot(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
+        let GspFbInfo::Ranges(fb_ranges) = fb_info else {
+            return Err(EINVAL);
+        };
         let bios = Vbios::new(dev, bar)?;
 
         // Try and prepare the unload bundle.
@@ -289,8 +295,8 @@ fn boot(
         });
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
-        if !fb_layout.frts.is_empty() {
-            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+        if !fb_ranges.frts.is_empty() {
+            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_ranges)?;
         }
 
         gsp_falcon.reset()?;

-- 
2.54.0

