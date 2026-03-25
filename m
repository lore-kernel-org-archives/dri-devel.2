Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D9A103A9A1
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83CBC10E6BD;
	Wed, 25 Mar 2026 02:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="teUPNR7q";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CCF10E6B9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCLYG8XoZSz0GTk1Q1gT1kbSHONMmRETQ6X+P7C0jVJriZyRUFob5AzB88FKPt8Tn/z/biLBkgjXd1y4CPE2pWpGnFNClwwbgwIHaVdObzwChRX69UTfz1nlDk8hbKCvV6ZYORlerNVwK+uxKSEffVQLHMPyI9FqZyMKBvWBABaksRWstkcp/Wh8f7ImMDffme9HYTdQi9msVzmptz8uZdULflkTJAXagQY7ykRZH/vdHelDFK1AegpYVfFUNy+Xz1wx9vaD4NT7VwNHmFQKMpKtV0Ddo6ICc7kwjBKkACns3nb4U9927Mb2YGuV1lF1rNPryIII4PnV45uvlgxFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLm2aSdzoV70cjF/H/z78ceElbWDFnO322CxqZBrtT8=;
 b=mYklFkUTr9beV21l0wfQECFALIWKKb3Jc4nEnTRMA++29RRkq+LlHQNIlijCX3Bn8AQXl5hoAEdLODRnW1QjoaWw+RZJAcb0QHtIU/+QQmTtE+qJr+lfflczWDHUuxSOHSpN9577PvOeruCbD1zzDgk+oAVZVEKxmygkCRfw3TeSTGN8I5cHhncDhPha6R+VVmzeShRCwPSH2vY4JnZP4XX7lR3ILPumzPg3lqX4aY3v0R5TgEv6jpQ5CqTRA2dvswDFzVev+BOHS4fCMb5XIHaGa9pUiuq2JVPcGkSAFtad3ejRBt+lti5RgVpeu8amV3Hgqb//mYRM3MxCzHr9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLm2aSdzoV70cjF/H/z78ceElbWDFnO322CxqZBrtT8=;
 b=teUPNR7qgajHDWHxplAreE9uuYUghnZq4bOfbB/OvuO1JvdTZeyAhZGiyKvmy6lut31g7ZtMt2DdNrTni9A1w46REbmFflwrXvUhta5hokM6J8EN1Z7U0bYLTzQX49Hi8OqlRPpTcKRZXW3vXAxHsNoOYnhe9Zd0azbNxLAByLO8x59DYuXy0nHeW0ZPRWwds39kBSQrHEaSrJ9Rrjp5rabcZ6kd35NYHwI5cCjGwBU0u+Dvt9FRAEn0Qg1cXkwmSdvE6eNlFrzj/ouuPhnVU4uHC+Bq3AUF/9xGD+L3TDDEUv2XTGHNsU2zcE2kSppmM9AFGdDGLQJeK/To9Nejqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:46:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:46:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:19 +0900
Subject: [PATCH v4 06/10] gpu: nova-core: convert FUSE registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-6-bdf172f0f6ca@nvidia.com>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TY4P301CA0095.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e38260-6cc8-4240-97cf-08de8a18c86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kh5U1gTweLDRs0LR45u2qGDEj01VxxEtB29BcPg0AdZI6dXqTm2EE9W/eakfSBLPfeJ3AkkzrnpZqB+lY5Hd5hSBSWkBBCgT/qSWlCWj48R0TceQpwfJkAeyRNDGSCxVvQ9E/cj0aWaGDKycnPeU/iLE3t2nTKxVdgg1pXyIjG2XlWvI9PzOeYLgbrd3Gjxvo7IOXIxyr60K+XPTsps9E/s2N9vUFKGJloDsJQbjK0OZbE3NwgOCMEe3QwRXm/VwvzM/VPlGV7lcEEyOo9ku/Ti0W6/TNfrrA+HFqeRpyaU7s9DSSArM9S41qIk6EgGkRrfw5VUMAw3C9Os9xsLfzCvsTLs3DfwRFvejhs4iDE6Jp9V/DvUn5mcyrmKHNgJ6UWvA/HWnsdkelQRUX71m/DvP/tAq82Ycw2eqbbtDB/9ioG+SiX95js4MhtYbn9c/m+pm2UwY5fJyDqqa2za+Cd7LCiGBs6bJfoJQU2zMKmsb1G//R9K6Rkb5hm8O6ivgxyLzkqs3clcml+kKGmpIuG4JVxlGnKIOL0ZL1Ib1VN2ukOLR0uHqeOZVN+t1FyB+AEGvLd+Ck2iL9cP8yJL46xDg/LKspIj8BrIPqLXyYiYCJzyIXrnNyMXSe82rz+VN0BZ9O0i0/qs3PX8kwiNSkXp6eYMs/mB0fMOaUkitAPq20XPxwFqzAw0xCI7WoRnECCdO56pQyp8HL77j38HqEeCB5Si3pBptmqgH1AfIMB/Yoe7OFjuOVvVn28AiR2wzVrYq09O4dcn4C4RkM4wrSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dExmSURiT0tWVll2K2xqOVU1UHZPWVFidUgxTWtQclg1ekVSdkl6S1d5UmRz?=
 =?utf-8?B?Sk52dVQ5ZUZuazZWUW50L3dvK2ZiMmtUMEkzV1RiOHFxYm8wN3poeGFBc2JC?=
 =?utf-8?B?T2tQWG51eWN6eXdDQnlDUW15NFVQQWU1MDFWZUV0eTVaNTY3dytDSTRSU0p5?=
 =?utf-8?B?WVMzcUVGaWtaQU5Iem1VMFFrSzlHbTVKQUF5TkJGOStERTZXcHVxcVh1TU8v?=
 =?utf-8?B?OStweTFYUmxLdGg1UnR6ZkJoeVRCWGxubVJyMzhRQ0NUME84MTJzZkpEdEs1?=
 =?utf-8?B?OWJEQ2dXSDgyckNvdlJYTkFFb2NtNGo4K1lEYTQ0V29XajByUVl1Zkd4S1RM?=
 =?utf-8?B?ZUhoTWhZSmhReHpOT0VOVHFZUlJ0K2F3MC8rdVFXVFVWYk5sNWNJRFdHVEdV?=
 =?utf-8?B?ZjRTNDNvYzZOSCtORWVpNWRzUC9scmxjT3Rsd1drbDFFYUNwT1piSkg0NWZi?=
 =?utf-8?B?SC9NY0tkWHd6WUMraXVjVFlBQ0dNemlaVE52emw0WHVUbGVzTzdJMHA4UTRV?=
 =?utf-8?B?bWZnNzhrb0VheDNaWXdFYm0wL3pCK1VWZDNVeXphc05WQUhNa01FTmtFZElM?=
 =?utf-8?B?a2NNNmFxOGhCUTkwR2kwRGxkT3loaVhTcUYreXFnSzVsd0MvR1BMOWY1ak9o?=
 =?utf-8?B?aVBWQXBocE5EbTRaM2llWjQ0YlB0ZTF4eXRMRGpnTExacDEwZVE5UXQzT3E3?=
 =?utf-8?B?UWZ4MmdIajhldU1wWDUxUlV2LzhaQnpCVUhTYVNwMUdDTzVDQmVkckZXWWgv?=
 =?utf-8?B?T2FScG1FN0ZIVVNvdEE4VFg0WkgxTER5aDQ2c2EwT3A2NGJWcUVMeFFhZzZm?=
 =?utf-8?B?aFlJd1Nna1IvcEVwMWw0bmQ4M0d3MWEvRld5ellydFJRNitvZCtaSnZwKy9v?=
 =?utf-8?B?TEhoamhnWk0vUm5kVExpVTZEVi9KU2FpZnJCQkt2R0xUblcwRXpvUy9PZUw1?=
 =?utf-8?B?VElINlpneVc1Z29ibzR1U2hrMTgvdWlvZU94bkJuelk4QVNwRHMvS2ZOWExR?=
 =?utf-8?B?ZTZoU2lsd1pQNGE1cVh4M2JMTENVamRndzZSVjF5MExZeFpubkRCb2xSTTZM?=
 =?utf-8?B?UENsRHZjMUtYVnBnUnpSdjlEY1NnSGhyVkphL09rL29VRTdZUW8vRjBBak9L?=
 =?utf-8?B?b3pzdTJSTnBKaTRlS0tJU00vbzdiZkJTVERRRDhRK3Z1MHBjWE04cmxYTDRn?=
 =?utf-8?B?M2N4WVpQaUJjZGc1THpqRkpvT1lyRlYzZjFoalpwckkvYTNPanVLeUFrN3c1?=
 =?utf-8?B?TDJaK1U5MVQyV1RNSXhKMGplYlRmSDhnK2YySTBxQ3N2Si9ZNzdmcnQ0MkZO?=
 =?utf-8?B?RU1UaE1LL3dNMkUvbzA4RFl3blBGQ1RDaDUrUEFYaG8wa3hFeVQ5R0dva1VO?=
 =?utf-8?B?VUdnMUZHc01VS08zckxnc1VlMk5wMGVWeGdTWktzS2RyYnFkam9OM25ranFn?=
 =?utf-8?B?eGxML1hXU0kvMXZVM2VRRTB3N3huUGtNSVRsQml5cnFtQ21QVnlhV0FhemhW?=
 =?utf-8?B?cUl4c2FEelhGREVuUnZpVk1GTE5DdzN6eW9DQWZqR2xpa0FCVlJ1ekFJZmlR?=
 =?utf-8?B?R0dHU1ZydXF0REc1TFRRVVFsZFpjWURtM0kwQkU2UFVCdzZZblh6d1prbk5h?=
 =?utf-8?B?R0RJTml4dTl2MnY5QkdBazc2M3VUQkl5Q2RYOFJEOFVrYU4yOFE3QnJhZlhP?=
 =?utf-8?B?NFpia0pDSjVEYjBSZng4NDI1aHJVNUk2NnMxUytVVVZxK0YvRzcrb0FvNjNT?=
 =?utf-8?B?MG5lY0tkU0lYalBNWi9hQWxLMDFJNzhpcU8xSXIzZC9Bb1lqeFhJRytYOWRn?=
 =?utf-8?B?QVgwNDhrYVJVTC9GUGdLRi9HSXptcmpBV3VQc1oveTNYaWVXYXJQWkM1VzQ4?=
 =?utf-8?B?R2p5YTlsbmNDUEo0YjlSd2JmRzhYNDhsOVN2R1p3UjFGZUZRNHhRamN5Qndl?=
 =?utf-8?B?RVcvalNMTERPUXVpY2oyenVkWlQ3R2dVdmVteTBubGU4czdISzZONzlwWGQ3?=
 =?utf-8?B?UjQ2Sk5QMVR1dFBVcmZ5bmZkQllVMS9rc0gwYWxRaVB6bzQ1dnBYVkQ1OGE2?=
 =?utf-8?B?OEJhK3JQUUZHMHMxNkFBYXNwNXhhUTRaaWRrblRCdmFqRFdXWHdnUkNUeStG?=
 =?utf-8?B?Vmx1czhaOUpySnE5em1LbG1ZQ09JaVI3dStWVWdFL3BndWMyT1A4TW9MME1R?=
 =?utf-8?B?clFjR1EvdEhsY0pFSUhxM0pMOVg5UDQ0NDV1c0lFR3RXaGhKVnJnbjN6NHFp?=
 =?utf-8?B?UTBJK2hHVFd5REp5TDFRUFNZd1NpSG1aSDlScytPY1lzVU56Z2VNNDhBOURF?=
 =?utf-8?B?ZTBVQmhqOWczRmNIZXNiSnZZSmpGaGkrY0Y4a1FnakdaQlJzTWsxaVY5bmU4?=
 =?utf-8?Q?4pdJxYr7Y6/bjmbduGXvUZbOVBjx/TFQFnijy9tQGnhT8?=
X-MS-Exchange-AntiSpam-MessageData-1: h03955GvqqrH8g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e38260-6cc8-4240-97cf-08de8a18c86b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:46:58.1381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCh/bn/RsHFHC+BXQXe4KRwDlcJRMeDAPKXoJT/WtERp/0cnD/Xzp82xr4w05V/CvIklI40DTJqhcEpAEN4IYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

Convert all FUSE registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon/hal/ga102.rs | 17 +++++++++----
 drivers/gpu/nova-core/fb/hal/ga100.rs     |  3 ++-
 drivers/gpu/nova-core/fb/hal/tu102.rs     |  3 ++-
 drivers/gpu/nova-core/regs.rs             | 40 +++++++++++++++++++------------
 4 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index 8f62df10da0a..cbdf36bad633 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -4,7 +4,11 @@
 
 use kernel::{
     device,
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        register::Array,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -60,12 +64,15 @@ fn signature_reg_fuse_version_ga102(
 
     // `ucode_idx` is guaranteed to be in the range [0..15], making the `read` calls provable valid
     // at build-time.
-    let reg_fuse_version = if engine_id_mask & 0x0001 != 0 {
-        regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::read(bar, ucode_idx).data()
+    let reg_fuse_version: u16 = if engine_id_mask & 0x0001 != 0 {
+        bar.read(regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else if engine_id_mask & 0x0004 != 0 {
-        regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::read(bar, ucode_idx).data()
+        bar.read(regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else if engine_id_mask & 0x0400 != 0 {
-        regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::read(bar, ucode_idx).data()
+        bar.read(regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else {
         dev_err!(dev, "unexpected engine_id_mask {:#x}\n", engine_id_mask);
         return Err(EINVAL);
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index 629588c75778..1c03783cddef 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -40,7 +40,8 @@ pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
 }
 
 pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
-    !regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY::read(bar).display_disabled()
+    !bar.read(regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY)
+        .display_disabled()
 }
 
 /// Shift applied to the sysmem address before it is written into
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index 515d50872224..281bb796e198 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -29,7 +29,8 @@ pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
 }
 
 pub(super) fn display_enabled_gm107(bar: &Bar0) -> bool {
-    !regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY::read(bar).display_disabled()
+    !bar.read(regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY)
+        .display_disabled()
 }
 
 pub(super) fn vidmem_size_gp102(bar: &Bar0) -> u64 {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 6f49467e78ec..61a8dba22d88 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -270,17 +270,19 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
-register!(NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION @ 0x00824100[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+io::register! {
+    pub(crate) NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
+        15:0    data => u16;
+    }
 
-register!(NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION @ 0x00824140[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+    pub(crate) NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824140 {
+        15:0    data => u16;
+    }
 
-register!(NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION @ 0x008241c0[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+    pub(crate) NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x008241c0 {
+        15:0    data => u16;
+    }
+}
 
 // PFALCON
 
@@ -491,17 +493,25 @@ pub(crate) fn reset_engine<E: FalconEngine>(bar: &Bar0) {
 // only be used in HAL modules.
 
 pub(crate) mod gm107 {
+    use kernel::io;
+
     // FUSE
 
-    register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
-        0:0     display_disabled as bool;
-    });
+    io::register! {
+        pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00021c04 {
+            0:0     display_disabled => bool;
+        }
+    }
 }
 
 pub(crate) mod ga100 {
+    use kernel::io;
+
     // FUSE
 
-    register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
-        0:0     display_disabled as bool;
-    });
+    io::register! {
+        pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00820c04 {
+            0:0     display_disabled => bool;
+        }
+    }
 }

-- 
2.53.0

