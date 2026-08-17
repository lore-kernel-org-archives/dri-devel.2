Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EA0C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCE610E698;
	Mon, 17 Aug 2026 07:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IAVsWFg+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD5310E695
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIgnXb4u/FODxp9usXlb40WC9aNN9OfFuGzVSg2mNe0TP+1twe6O9lAAu+iHCy8cr7N6TfXqL5QviMlaffxVEpUwmCW84E0FNTrpNEGiAfr2ggJ25sYP1/I+T1r96nKMwDV4ZkwcKV4gExXObxxzJLHF/smbxGBx7DcWIArnhRvAl5MDQH+RKRrylfV19VoJIHfFES4hvrKzMsG2jG+CZHS75KWZL4hyLWJQMaAIZQt41lRAZFZs+/Xzph90Uonj412p+kjzY6+KYmtJ7ITZTxJpP/PbgitbTEmRTu6b6VvhGaVlhbQpaWfycb67NHj4zC2znCnLt56K39OUHaHiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVFD3ekeQZ3HCJW/cqvzrJCSuIxLY37s9Pwo2Gm0VTg=;
 b=KUL2hSiJ+A8EeZMuaoZRty7TjfkQbdYkEmdLNrqp1tQDjfxcGgkcg8jtfNSR1Sc4Hhm+HhhGWQrjlJU8FHkViGRyr0BrOSpqtLk1CMy8RYSOckJ7cy+Q0R6mEnswOwdCmRGnWvv98Sm+NzSLhm1BHfPxhyPCzg7hqf4S5eOHJxxpF2Fx65cnud0GAxBK4pPb60ytqrhKH41VJl95QFjcl5af2ClstXei0CB566fXUN/PXxlkm4hSXL+LeuE/LxVmb7GRFRyYlASlDBSyedKO6lobv5SCFQDpJ5MRFhdEPP0rS5YXln/j9Faj51h9KLT24F1ivyM/JP0xf4JWnsJ2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVFD3ekeQZ3HCJW/cqvzrJCSuIxLY37s9Pwo2Gm0VTg=;
 b=IAVsWFg+0/wgiZRMfPD1diye1dy+FjIyh8KXs5pu1LH7CuLDpPPUxSOwgSlTiNzEvxCX9RwPQ2Gwt40rojYZW0Li4YPc6e2mDeDwl9uAA7ohXRgv8beBgx3fRafb7aqCxRpI45JwghNcW5onEZVacREkdTnIQH2pdrkMMW0f/7CQFZT4zwn1F3la1EhHwnK803wQaVV9G6qy2ZazY2I5mHBbrM2Hh5IeqVzc9E2mH1mWy/ms9Cfp1sZuFPimwZOtT1PbfVy9jqIgXVFsGGT0lZN5jaUDuPIw3OL9YWViQac5u9kvz/l5Up6zeKqDqgMht7CUO3x9baM4aryWMaOUJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:05:02 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:05:02 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:24 +0900
Subject: [PATCH v7 10/10] rust: use Alignment size constants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-10-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0133.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ae94f6-6c88-428c-5cec-08defc2ddbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FpJGLxx3NGUa5FrFfLT/GtxCk+uusUe5grJnXJDO5odwgk/TsI8XcEKWFXx7TLdJ4F28imXuHmiNqwl0TvIy1ZH8/IKoJ6Ml1qc2mn+WnmniwHyMQzv84WHY6x0tTRzwsFDC92SZjovk924FD11nKFgUIhJQOyqc0F22PFcThn+45ZMFDC+EqT/Sre6mYKyPKIIURJmg3adFoweD8ldKkJCGbuu+BjboLxBNFMlUWeP134DN4eMx/5fvdPDNIGO/xEAVFQeSW83PUgottD10YTS/+3wEyj9vFC5KPULv5wTVaHbGE3/tRGgg+Z2L2XDVE4w33gcaPpw/TBvvp9FddVIzeVBvuhtkPcI1gxQIvEpqUCAx3askxdg2fvXYEKFYNNUMCX/pV7UhOVqr7gd5OhCscDUE+xBcNjfS+lgr1jkpBORejw2mNpLkoUNsv1cSDtgxRjGMZDx8LZWu9KeypasKOkvIscpTu6itUlQjrGsSOKmcr+Yh29evPBr019ZUQd/fZvlswf+0GlOU7YD+OxYABf7ukS7fVhZJgUjRBba3d2MvDmE4R5xRs8A84CGNfIvXAtGMW7dILNwNoDuov1p0l5fzyzdoCJRIG761bKGV2VpuoxRNs54+lVfl6a5O5Ms+RvNMXGoV+RsWZYi11k636NSgJkjxWWPPk2xjDubNm3s+OuZYZuhXpvWocR9XsnGNK/GJdev6833sOsUXdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RklnRzcvR2xCdzBlSktUMlozbUduWUJJdzhHbjUvc1d0ZDVTcksxeTVQNXVz?=
 =?utf-8?B?ZXhnSHQ4SWNxZEFSOTdOWWpBclNEVm5zL3BxTDY5NnVIZkpCRi81THdEZCtO?=
 =?utf-8?B?L2thb2U5d01EMElKd2tKVm1xWEJudVZ6ejAvTVhDYkxWMjc3MTlDV0xRblZu?=
 =?utf-8?B?cm1DN3NIT0NqNHlMVFlKMWk4N245dHBOTXRzckRic3ZFSlVWYmtVdGRuS0do?=
 =?utf-8?B?TUFscXlJUjZ2UGNjTXVQbHptU3R4MTFQU1FNSDFJZFhPYmNZcFRYWkxobmpZ?=
 =?utf-8?B?bGxBSXJqaFVpMzZ2UlpMeHpqVlJoYmZJdkdhbHlwQlBNY1FhbncwSHNlZ2to?=
 =?utf-8?B?Vm9nUXFxRGFDeU9yV0xFZXpEK2ExSW9zOXJFbnhtM1B6Uk5hTWV5NUFQS1A3?=
 =?utf-8?B?Q2NNd0hPTm5paE5UQ1U3R3hCbXNFWTZQS0tRekpwUDVvVzM2NGUzMTJTSDgr?=
 =?utf-8?B?TmlycUtpRVNEN0lFbEtjaGV3VzNDNnBpWnQ5a09ERHFZOENCQjJKRk9BSGFG?=
 =?utf-8?B?S2FXZFV6YUZabkwvMk9UVS84QnphV3pNRlk2Q1hsclIrbnFiOGIvbEFIdllC?=
 =?utf-8?B?M2V0TkpBdFJDZU45VzBrNldGbi9nVXFaQUFjK25jZHpyajJ5L3QwL01mb0VF?=
 =?utf-8?B?bysvSllkeHdoMVZ4RzlGRnRUa2J3YndoUEdjTm05dzRnNkd2L2VCV2RvMngr?=
 =?utf-8?B?TEpyZFpNUk5sWHplZGg2ZkdTNzBCQ0JXM3JMRFpvMjl5VndFdjNFeUF1OXBq?=
 =?utf-8?B?L2NlaSthRWx1WkVLdXNqaHJ6VTdldWVUc2ZLQ3RCMEVGaXhQbEhyTVZkYmJz?=
 =?utf-8?B?NHMwbGNwK3FpZWtQQkkzMVprM2ZoS1l2WU5ab1lBSE1aR1RqakFNRWlBdExH?=
 =?utf-8?B?bzJ4ZEMrM0JFSUo5dDJ0MkwyeDhDS3YyUkhCcjN2RU12U0QrOWczbTk0Nk5E?=
 =?utf-8?B?QUM1ZlIzNWlDd09hcTRibmtNeVdobzFsd1NJNnpKeHp2K2F0UnJpcFJ5UVJ2?=
 =?utf-8?B?MGdJS2lUQWN5emozNitzbmw0TUN4aXJEdDF1dkZGTWd1WHdFTDdDdWo0Z1Rj?=
 =?utf-8?B?SXRINTN4V2s2dHpYZ3dCZlFScUpUekt0aGVsUzE1SjhRQ2FCMDJ6WWlhYVd3?=
 =?utf-8?B?VUN4UTJvS2U4T1pNRlBMbnBzSEtDRW1ZdFJUakVaSHhRT0dzbXJDbXpCS0V0?=
 =?utf-8?B?eVp5TjdxSElEdktPclJOc2c1cUdNdU1CTC9IeVlUNXQyVUcxT21zTE0vTHg5?=
 =?utf-8?B?TkJvdzIxYVF2aXFEQ0xHd0wzenVuN2pHeVI2WWc4eW90bjBjN3J0UDFtZnlG?=
 =?utf-8?B?NEJVS1NycVRFdG8wR0FBaEtIbGtzWjhHYVN4eVhjS1grVHgzc0w2eG5QdDRU?=
 =?utf-8?B?enN5OHkySGI5SDVsNFMyQ244aHduNW8zZXowUWFFbmRFOTljQ2xMakJBMktO?=
 =?utf-8?B?c1BnZkxadi9IdytXUFpGUi9Mbm03MDRrb0JFdWpHLzBPbnZCNkgzM2J2bWlu?=
 =?utf-8?B?QUJTK1NOZktzdm1hYTI0S2d6NkxTRDVGMnRteEtiVERQZzdPQ3pSYVlDdWV5?=
 =?utf-8?B?ZGpubUJaaEczZi9DZGtUbTFzZW1PVTZ2Rk5xM2tyV1hWQXI0aXljV09mYnk4?=
 =?utf-8?B?YWlzekU1NHU4b0ZsWmFvVTgzOHFrWFphUURac0tva1RvSDFmVHJKK2E2TXlq?=
 =?utf-8?B?QnZsaWdQYkxzWVlXNUZvTVdFTlJWY1BKWWJxUFE0cnMwRFVQUks3MU84c2h2?=
 =?utf-8?B?Q3JBckZiUDlJRE5SbzZLbkxRWmFoak45MEgrZnR2MWZYYUtxR2lCZDdwSU9a?=
 =?utf-8?B?OTM0TTdQN21MR2lack1tTmdVNGx4WkpTYTVHQkpDRzNlcFVaelRZNy9JakdU?=
 =?utf-8?B?Y3BkQzhkVEN6K1o2Vmg1bU9kWjRLazNocWdKL1lKa3BBb2wvZjIrd3NmNThU?=
 =?utf-8?B?YTN4NkpPS1lFYWFMRlJ2TUw4ZHNIVVJ2OHRVdndJdUtXS3ZvZXhSYi9GMGJD?=
 =?utf-8?B?MmFWZEx3RGtMYUszdlE1RWowcHA4ZlAvd0h3akhYVTQ0OVpzbEUrTVRrSkM3?=
 =?utf-8?B?VUh0MlBtcjkrRDMyWEV3Z21wTkVzUXlIVzB2NDV5b0ExbGtuSWttUkUvbktZ?=
 =?utf-8?B?bUpMRVlVdHNGa0lGZTRCMHRNZzhTWGtTMnplVmdBR05qME9XKzYzaEVLSytH?=
 =?utf-8?B?bFFtTkdGVWpOS0xnK3VmYk1qZElsSCtRZGdYMmFtQ1k0UlFxRHV0SWNCa0VY?=
 =?utf-8?B?bDMzc0tvRXBRK0g4cEMzOG5UcFg3VGFhSkxRNnVvV0NKTWdHTUxhYXh0Rjlp?=
 =?utf-8?B?WVEvM2ZoRE9VMjRNVVRlZUczUHI1bFU1ejNFa3o2YUtzM1lKcEJXL2Z6ajhR?=
 =?utf-8?Q?sZzYRbMd5y0nCu5vPFupFdAHGqNIIcjigev+qZPfYXtkB?=
X-MS-Exchange-AntiSpam-MessageData-1: 51KLXj93PNbLVA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae94f6-6c88-428c-5cec-08defc2ddbb8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:05:02.4185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlyzK0DBAFGiecRy7RLLhUgG98wDKb2FFTJ+WjeYiIalyGLpC+mdUKa6XnF1u9YNOv3p/YJmDf1MD/XMPyRzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

Use `SizeConstants` for Alignment that are implemented now.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs           | 10 +++++-----
 drivers/gpu/nova-core/fb/hal/gb100.rs |  3 +--
 drivers/gpu/nova-core/fsp.rs          |  4 ++--
 drivers/gpu/nova-core/gsp/fw.rs       | 12 +++---------
 drivers/gpu/nova-core/vbios.rs        |  7 +++++--
 rust/kernel/gpu/buddy.rs              | 26 +++++++++++++-------------
 rust/kernel/io.rs                     |  5 +++--
 7 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 1576399389b1..70493c4a07b7 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -219,7 +219,7 @@ pub(crate) fn new(
         };
 
         let frts = {
-            const FRTS_DOWN_ALIGN: Alignment = Alignment::new::<SZ_128K>();
+            const FRTS_DOWN_ALIGN: Alignment = Alignment::SZ_128K;
             let frts_size: u64 = hal.frts_size();
             let frts_base = vga_workspace.start.align_down(FRTS_DOWN_ALIGN) - frts_size;
 
@@ -227,7 +227,7 @@ pub(crate) fn new(
         };
 
         let boot = {
-            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::new::<SZ_4K>();
+            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::SZ_4K;
             let bootloader_size = u64::from_safe_cast(gsp_fw.bootloader.ucode.size());
             let bootloader_base = (frts.start - bootloader_size).align_down(BOOTLOADER_DOWN_ALIGN);
 
@@ -235,7 +235,7 @@ pub(crate) fn new(
         };
 
         let elf = {
-            const ELF_DOWN_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+            const ELF_DOWN_ALIGN: Alignment = Alignment::SZ_64K;
             let elf_size = u64::from_safe_cast(gsp_fw.size);
             let elf_addr = (boot.start - elf_size).align_down(ELF_DOWN_ALIGN);
 
@@ -245,7 +245,7 @@ pub(crate) fn new(
         let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb.end)?;
 
         let wpr2_heap = {
-            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_heap_addr = elf
                 .start
                 .checked_sub(wpr2_heap_size)
@@ -256,7 +256,7 @@ pub(crate) fn new(
         };
 
         let wpr2 = {
-            const WPR2_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
+            const WPR2_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
             let wpr2_addr = (wpr2_heap.start - u64::from_safe_cast(size_of::<gsp::GspFwWprMeta>()))
                 .align_down(WPR2_DOWN_ALIGN);
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index d9e4d62ae632..b37f11c9a891 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -82,8 +82,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
-    )
+    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::SZ_128K).unwrap() }>()
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index ab685fb4168f..6bac5206a836 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -17,7 +17,7 @@
         Alignable,
         Alignment, //
     },
-    sizes::SZ_2M,
+    sizes::SizeConstants,
     time::Delta,
     transmute::{
         AsBytes,
@@ -257,7 +257,7 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
         if fb_info.pmu_reserved_size != 0 {
             offset = (offset + u64::from(fb_info.pmu_reserved_size))
                 // The 2 MiB alignment is r570-specific.
-                .align_up(Alignment::new::<SZ_2M>())
+                .align_up(Alignment::SZ_2M)
                 .ok_or(EINVAL)?;
         }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 05f54fee6186..6b92e0e0a2a9 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -25,10 +25,7 @@
         Alignment,
         KnownSize, //
     },
-    sizes::{
-        SizeConstants,
-        SZ_128K, //
-    },
+    sizes::SizeConstants,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -63,7 +60,7 @@
 enum GspFwHeapParams {}
 
 /// Minimum required alignment for the GSP heap.
-const GSP_HEAP_ALIGNMENT: Alignment = Alignment::new::<{ 1 << 20 }>();
+const GSP_HEAP_ALIGNMENT: Alignment = Alignment::SZ_1M;
 
 impl GspFwHeapParams {
     /// Returns the amount of GSP-RM heap memory used during GSP-RM boot and initialization (up to
@@ -209,10 +206,7 @@ pub(crate) fn from_ranges<'a>(
             bootBinOffset: ranges.boot.start,
             frtsOffset: ranges.frts.start,
             frtsSize: ranges.frts.len(),
-            gspFwWprEnd: ranges
-                .vga_workspace
-                .start
-                .align_down(Alignment::new::<SZ_128K>()),
+            gspFwWprEnd: ranges.vga_workspace.start.align_down(Alignment::SZ_128K),
             gspFwHeapVfPartitionCount: ranges.vf_partition_count,
             fbSize: ranges.fb.len(),
             vgaWorkspaceOffset: ranges.vga_workspace.start,
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c03650ee5226..de46e3399ff8 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -11,7 +11,10 @@
         Alignment, //
     },
     register,
-    sizes::SZ_4K,
+    sizes::{
+        SizeConstants,
+        SZ_4K, //
+    },
     sync::aref::ARef,
 };
 
@@ -282,7 +285,7 @@ fn next(&mut self) -> Option<Self::Item> {
 
         // Advance to next image (aligned to 512 bytes).
         self.current_offset += image_size;
-        self.current_offset = self.current_offset.align_up(Alignment::new::<512>())?;
+        self.current_offset = self.current_offset.align_up(Alignment::SZ_512)?;
 
         Some(Ok(full_image))
     }
diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
index d502ada6ebbd..691bb40629d4 100644
--- a/rust/kernel/gpu/buddy.rs
+++ b/rust/kernel/gpu/buddy.rs
@@ -31,11 +31,11 @@
 //! let buddy = GpuBuddy::new(GpuBuddyParams {
 //!     base_offset: 0,
 //!     size: SZ_1G as u64,
-//!     chunk_size: Alignment::new::<SZ_4K>(),
+//!     chunk_size: Alignment::SZ_4K,
 //! })?;
 //!
 //! assert_eq!(buddy.size(), SZ_1G as u64);
-//! assert_eq!(buddy.chunk_size(), Alignment::new::<SZ_4K>());
+//! assert_eq!(buddy.chunk_size(), Alignment::SZ_4K);
 //! let initial_free = buddy.avail();
 //!
 //! // Allocate 16MB. Block lands at the top of the address range.
@@ -43,7 +43,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Simple,
 //!         SZ_16M as u64,
-//!         Alignment::new::<SZ_16M>(),
+//!         Alignment::SZ_16M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -74,14 +74,14 @@
 //! # let buddy = GpuBuddy::new(GpuBuddyParams {
 //! #     base_offset: 0,
 //! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::new::<SZ_4K>(),
+//! #     chunk_size: Alignment::SZ_4K,
 //! # })?;
 //! # let initial_free = buddy.avail();
 //! let topdown = KBox::pin_init(
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::TopDown,
 //!         SZ_16M as u64,
-//!         Alignment::new::<SZ_16M>(),
+//!         Alignment::SZ_16M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -114,7 +114,7 @@
 //! # let buddy = GpuBuddy::new(GpuBuddyParams {
 //! #     base_offset: 0,
 //! #     size: SZ_1G as u64,
-//! #     chunk_size: Alignment::new::<SZ_4K>(),
+//! #     chunk_size: Alignment::SZ_4K,
 //! # })?;
 //! # let initial_free = buddy.avail();
 //! // Create fragmentation by allocating 4MB blocks at [0,4M) and [8M,12M).
@@ -122,7 +122,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -133,7 +133,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -145,7 +145,7 @@
 //!     buddy.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_16M as u64),
 //!         SZ_8M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -178,14 +178,14 @@
 //! let small = GpuBuddy::new(GpuBuddyParams {
 //!     base_offset: 0,
 //!     size: SZ_16M as u64,
-//!     chunk_size: Alignment::new::<SZ_4K>(),
+//!     chunk_size: Alignment::SZ_4K,
 //! })?;
 //!
 //! let _hole1 = KBox::pin_init(
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(0..SZ_4M as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -195,7 +195,7 @@
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Range(SZ_8M as u64..(SZ_8M + SZ_4M) as u64),
 //!         SZ_4M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlags::default(),
 //!     ),
 //!     GFP_KERNEL,
@@ -206,7 +206,7 @@
 //!     small.alloc_blocks(
 //!         GpuBuddyAllocMode::Simple,
 //!         SZ_8M as u64,
-//!         Alignment::new::<SZ_4M>(),
+//!         Alignment::SZ_4M,
 //!         GpuBuddyAllocFlag::Contiguous,
 //!     ),
 //!     GFP_KERNEL,
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 95f46bb75f9e..10fbb27a1998 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -15,7 +15,8 @@
     ptr::{
         Alignment,
         KnownSize, //
-    }, //
+    },
+    sizes::SizeConstants, //
 };
 
 pub mod mem;
@@ -85,7 +86,7 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Sel
 impl<const SIZE: usize> KnownSize for Region<SIZE> {
     const MIN_SIZE: usize = SIZE;
     // Alignment of 4 is the most common; different base types can be added once required.
-    const MIN_ALIGN: Alignment = Alignment::new::<4>();
+    const MIN_ALIGN: Alignment = Alignment::SZ_4;
 
     #[inline(always)]
     fn size(p: *const Self) -> usize {

-- 
2.55.0

