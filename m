Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F297C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043D210F2D4;
	Fri, 24 Jul 2026 06:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAv1hH49";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5180010F2D4
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8dgdwoIcbh06tuWiF7uONGpe/3eSCopuPA1d4OC8kRZXX0E5A5IgK2c/E4msVOOTt6S4oWzbDJeKAM6F+G4JAD6gqwY6ttvokcVIiigjlk1UkITJbGtrYDziIGcoapK97oA3NpGZIcwTtWa2dafc4mGk65SE73oZdpHNycePMz8wsFKqS5eNvC2Siw+yyT8PogEMuZa3v+trNdtTKHnZSJhz1gV6qoInp/ovXDYDBGWTzxeUG//aPhSD4C0L58IMnhlAhZ8tcm6aEPyfyv+FiB3i+b1Uo5VaDNHNzzpkSBVw1FrFXLfPwGaN5UX87sJHgmqA69WWbQxLSYceNBQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA1JXFeYOEaKMKiad+b+6cYoB8oj8FVYiwPptwAgzjU=;
 b=FPVP8+XYDuvMgC/ylKFM0Uf6qJ3r5jHW2bjLAb61/r4maqXX4ft0C9QcuZvcwWh41qL8ivEbRUucKyDn7hmUnCNT3tZIeMUz2rs+wOu8gzNpIFMhCIDc8mxzCIM2c/UYZ0B43D5zlS2hP6hOyI56hgYLDpbgo63dHtp5xFS5vx8MRE+XJRcnoaJeTz7qSnVm7by2v6AtnmOGjkC9xFvzdEuziECDDtiNGFrEY0IV5rS22ESBYKMe2exQbaG1Z7IgyOvz+K3GoyPBi4Bz1IE1QRM03L9gQfGjxwewjGlP6uFWj/m5PC3Ln7C8Amh+M+d3L4bi8OXf5ZiGuMYJmO6n8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA1JXFeYOEaKMKiad+b+6cYoB8oj8FVYiwPptwAgzjU=;
 b=cAv1hH49w2cAXIlQpnjqOWp8TK8NKGM0shzJu42tTpnflGpEKvsqRSUKgm42qxfGoWjQk7OB8ZNtOcq6F4JjutJGA3UnjrTQq+Xu6m5EG9O4+xi0dCWVsd+Cr48ACQAPYWaQimwrj47TqzbcaNgmvTH744X8peg+W3Tb1K3H+/KWz5aVIqrJOxZJdxCbrAe3z9dlNrOUg3Fuu3adHJp259/P0ZlBU6l9aODsm1W98Zoqq8JDafb/9FAdOmGjJywgQtx4bBth49LNW82Eg7OaFLEA2YHamEQvHWBdUDFBt/Jy2WeNQaz89xMjIx6oMn4dgE5uI7Zd6Zk2sNiPscBqHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 06:56:51 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:56:51 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 24 Jul 2026 15:56:26 +0900
Subject: [PATCH v3 4/5] gpu: nova-core: split FbLayout into FSP and non-FSP
 versions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-blackwell-fixes-v3-4-01aa6a54e3fd@nvidia.com>
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
In-Reply-To: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
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
X-ClientProxiedBy: DUZPR01CA0353.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a587392-2d96-489f-9498-08dee950bcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|11063799006|10067099003|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8+3JnTu2BnRxtKx0IvYCKl/X3bOXmyj2aVvUdaTNFYf4TNmGgC1HlavRqDRUluOh0hhc+42t6FO5DTMnnnNfHJp+Z7jKtJsZcGw276k2ND4O6jtrS66nM5atSjYU86DprJG9eZMatZLWDyXnc4PoW7XGfNWDOayhkQtONWRf6cmhyUvlzMsHHPlA251Brmr63LzOmpzdvWCJRqGAEQ3zj8dRk0DSoDEVvr97UDm2kJAGbahIKyxgxEkO1BeLxycJRUOsghY97Zj9ug5FWq/POdzcfsY2DVOPOxqEE/BHEdc32WaKdkwZlWJuoesa+c4KpK69UW1iYCwhEhf8fg5Dtbw8UkPhH3PRMb8t7spNF+7NcLoWS0HF0yPSeSJUV+3GTdv90rV3vAsB/jqQgo8AJo+1yBbbpiNzUvnrPKqYF/aM4hCykftfqhlLspUAcv3ZGkMCMpFF1RMcUiUfAEPlGoxaVr+pnqcOSh1Lt1l6lTFd1tTMc66EJpBxxjo0Eh3AbqsrKZlfsjglUuok5sTXhoigltPxKjBAzXT6jVrPFqC8QDeZ+zeBgiEZxM7IeAcNL8HwVOpuw1kfJJTnoNe8M+y7ljkSG4+PFfmhK/d2Jt4CtfIp57AqJmy5MpA091Jqa8m6TWedi4cgBQ490Fa2gLDW0bsJ6t4MxYm+WIJ211U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEUwTGcweUhsWFYrKzh2V2tSTnhlcTNnZWk3VmZsT3A1QXkyb1g0TU5mQlJr?=
 =?utf-8?B?bjZzU0g0OUFUaE1abGEzN1J6c0Nnc2FtenZkNGViWVlEOUZxRUxhOXI5K0lL?=
 =?utf-8?B?VW1YbFpHUGFndSs3NWNEVjZBZzhrZjB5R0xCK0luRXJsOWRmVExIZXpLb1ZQ?=
 =?utf-8?B?Mi9TNDd4cmFUanpsVzlNSVkzUDV2dFhaaDRmV2RzNzNVczB2YmdhbkorQ3E5?=
 =?utf-8?B?NFNGcUlISERyNWxOSUtpRTVNajNmanl1S1dFb2xFcmkwbFRzSTVQQ0xpK200?=
 =?utf-8?B?REVnMWU0RnFscGM5dFdnalRKNFl6TnBGSnhBNnRSTHo2Vkk5R0xyQXNyN0xI?=
 =?utf-8?B?WWdpZ3ZmUUQxMmZIQjI5aHBpKzliYnJVSFpQMTFYQUpVY05yanBUOUVBVnZi?=
 =?utf-8?B?MnRKSWx2Nlg5ckRRUFJuOGtwaFhZSnVRMUIrSXJQVWJpbXBqZTFFNGNESU5h?=
 =?utf-8?B?d2hZbDZab2IyYW5MZkY5MjZ5VkYrS0kwZkpoNVFuM3dCTkZnclZib2E3TGt1?=
 =?utf-8?B?QU1ZTnNiMUZoZGU0alVSMTRhUmRTYmZQUzMrNFhIWEpLaWF4bXg3c1BwTytM?=
 =?utf-8?B?NXpTd1YydkVPM1JDcEVkR1Y2aTlmUGlRd3J0dmViUEJYZzhPY3U4L3F0MEto?=
 =?utf-8?B?ODA4dFIvVFU5ZGRaRjZmY29iSUpRaUVJQ1FsT2lRem5udUF2UjRLbHdjb28z?=
 =?utf-8?B?Q0ZWdDFMY0JFdSszb2J5VXlXNzVSU3NCVjZlcGV4WnE4L0V4ZmZ0TDFmM1Vz?=
 =?utf-8?B?UHQ0MmFYa3p1cmJ6eUJvbWp5R29CREFvaERoWWVJUFFzVEFrUmFSNUFzUThT?=
 =?utf-8?B?Qzl5Y2JiQy82ZU02dVVpODdUM20ra1JaNythOU1OdjlZZFV2QmFnb3FDdFQv?=
 =?utf-8?B?ZW5UNzFyM2k2MFBvVlBCWEU0bGpNV21JRTFJWmlBb1ZMTzhjaXRuK1p1aGhr?=
 =?utf-8?B?ZHc5cWtEVmxiUDVBMDRpK05KajRReEhESGZleHRCbk5EM1hBaWd2U3lsUzdn?=
 =?utf-8?B?N3l2Vmx6WHdBWm1PbTVKSVpSaXc0S1p0Ky9obC9odyt4MHdpZVFFRmdlWS9I?=
 =?utf-8?B?Q3RTc1JtaUd3aXU3aHVaY3hZQ1JKUnJNbURsaElEb1gzYnhuclhKWGNFekFR?=
 =?utf-8?B?eWxWR092bVdkVDNiY2d3bTBLT2dsTGNNaG1YNkJRSDJrUGYxcXI2b2FxNi9j?=
 =?utf-8?B?YnJ0MzFlLzVkekh3MjFzU3RWV1R6anh5czZ4WDU0dEhPVmF3WWk5ZlplTWc1?=
 =?utf-8?B?RnBjVnk2c0kzN2h5d0xocUg5UllIRXZuM1cxT0RmTzdaM3lBRlNPNnc4Y2xs?=
 =?utf-8?B?STlVeEd0TE12ZVZXM3pQKzlTakhWRlVUWStVTzZYNzQrYnlDcGlJTXFHYmJW?=
 =?utf-8?B?azBXa25mMUpMcURoKzhjR29reTIrR0U5TlArd3hDRFhMSHZvZHV3MmlBNVc5?=
 =?utf-8?B?WEQ2b0cwaHFIWGdzNUZjdm9oT0lmMjhMUFNnNmZ6MEcxR1FvQ0ZWek9SQzFR?=
 =?utf-8?B?WktVMWt3VC94SlB6S2FucUR3RFpqQ2ZtS2x5N1RnOVFVWU9aTzJjVHkxN0pG?=
 =?utf-8?B?MTVXbWZueWp6SmQ5eXlaTUUxazk4RG5MbERuUTQ5SkxIZ2FRNEVBZVFjYmtL?=
 =?utf-8?B?aTNMRHZyRlBCaXQvV0hneVFTZXQ3aHFLcUlsM1B3TjdpRGUwbEdlbXNUMnZM?=
 =?utf-8?B?d1N4OXRyV0JBZ1Zod0kvK2E3Qm1UbVpLUHhNeFkxUHJrZmlScGxtOXk1SUNz?=
 =?utf-8?B?c1JiNG5vNWpUYzMzZlRKN01tUDJEYTJDVXo2UjdCa2lOWlNxMCt5ZFMxcURr?=
 =?utf-8?B?MzhLamJTazYrVmFFMDNUdHlqTXU5NjAyQU9nZjNoaS9GbXFLS1JYemVsNnRG?=
 =?utf-8?B?SEpJcThGVEpkQWRMT1l1VHlTQTRoSml2WFpEdUQzN2xOUFgzR1BoTit0Umx0?=
 =?utf-8?B?S3kvb0tkNm9GVWkrbE9tWWJXZVF3T0UyVUdjZi9rRXJLUlcwZUVSZTFqdkxp?=
 =?utf-8?B?ZE1VZTJLTlMweDdIZDJ1L0lxTzRaazBtYmw5RDFWQTJjTWZBclRMSXRuaVRj?=
 =?utf-8?B?U3lTY1IrTy9GNU1uL0lQeUpHbWE1UDU0TG9BUnlnOHJudHZ1VisveUg4OVo0?=
 =?utf-8?B?S2o1VWlRakpYUWFPRVJ5b2dKdnhPbWR3N1RRUzRNT2ZDc3Rjb01tUHRLUVox?=
 =?utf-8?B?VVlXUU84ODhQaG5Vck83Z0hkV1YxWXRNZ0pZN2dtT2pIYkdVVGp4RWhXZ2dp?=
 =?utf-8?B?UUc0K2I0UEk1cEN3ZG8zc1VVbWc2WGx1anIvdlJyVmU2UGQ4M3Fwc1VMN0Zr?=
 =?utf-8?B?djErTE5KR3FzWEJUNmNtMkVkQmFvWFJyMjIwOFpTYU53d0FoaTNXN09yQkJ3?=
 =?utf-8?Q?XBO+T3ki+jDyRon6b1AdyyIIRD9INT8yxCp41s2jUfAzq?=
X-MS-Exchange-AntiSpam-MessageData-1: GI+jIALo7B98hA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a587392-2d96-489f-9498-08dee950bcf0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:56:51.1863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nbg/TVN60IBenflSYpr+ENoDA9/l1j4Q3gNtiyf+kXBVpxQZRWn2ZeMuFrIKt8eWlrpA+lf2ARNOXd7MaHSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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
 drivers/gpu/nova-core/fb.rs            | 40 ++++++++++++++--
 drivers/gpu/nova-core/fsp.rs           | 21 ++++-----
 drivers/gpu/nova-core/gsp/boot.rs      | 28 ++++-------
 drivers/gpu/nova-core/gsp/fw.rs        | 85 ++++++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs       | 12 ++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 17 ++++---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 32 ++++++++-----
 7 files changed, 155 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index f5832e59de59..2336e97f7748 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -148,7 +148,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 ///
 /// Contains ranges of GPU memory reserved for a given purpose during the GSP boot process.
 #[derive(Debug)]
-pub(crate) struct FbLayout {
+pub(crate) struct FbRanges {
     /// Range of the framebuffer. Starts at `0`.
     pub(crate) fb: FbRange,
     /// VGA workspace, small area of reserved memory at the end of the framebuffer.
@@ -163,14 +163,16 @@ pub(crate) struct FbLayout {
     pub(crate) wpr2_heap: FbRange,
     /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
     pub(crate) wpr2: FbRange,
+    /// Non-WPR heap, located just below WPR2.
     pub(crate) non_wpr_heap: FbRange,
+    /// Number of VF partitions.
     pub(crate) vf_partition_count: u8,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
 }
 
-impl FbLayout {
-    /// Computes the FB layout for `chipset` required to run the `gsp_fw` GSP firmware.
+impl FbRanges {
+    /// Computes concrete framebuffer ranges required on non-FSP booting architectures.
     pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
         let hal = hal::fb_hal(chipset);
 
@@ -270,3 +272,35 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Resu
         })
     }
 }
+
+/// Framebuffer region sizes needed for GSP-FMC boot.
+#[derive(Debug)]
+pub(crate) struct FbSizes {
+    /// FRTS size, in bytes.
+    pub(crate) frts_size: u64,
+    /// WPR2 heap size, in bytes.
+    pub(crate) wpr2_heap_size: u64,
+    /// Non-WPR heap size, in bytes.
+    pub(crate) non_wpr_heap_size: u64,
+    /// PMU reserved memory size, in bytes.
+    pub(crate) pmu_reserved_size: u32,
+    /// Number of VF partitions.
+    pub(crate) vf_partition_count: u8,
+}
+
+impl FbSizes {
+    /// Computes the framebuffer region sizes for GSP-FMC boot.
+    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
+        let hal = hal::fb_hal(chipset);
+        let fb_size = hal.vidmem_size(bar);
+
+        Ok(Self {
+            frts_size: hal.frts_size(),
+            wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
+                .wpr_heap_size(chipset, fb_size)?,
+            non_wpr_heap_size: hal.non_wpr_heap_size(),
+            pmu_reserved_size: hal.pmu_reserved_size(),
+            vf_partition_count: 0,
+        })
+    }
+}
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 30e53df81aa2..48438ba21b91 100644
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
@@ -136,11 +136,11 @@ struct FspCotMessage {
 impl FspCotMessage {
     /// Computes the FRTS vidmem offset for the Chain-of-Trust message. It is measured from the end
     /// of the framebuffer.
-    fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_layout: &FbLayout) -> Result<u64> {
+    fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
         let mut offset = u64::from(hal.fb_end_reserved_size());
 
-        if fb_layout.pmu_reserved_size != 0 {
-            offset = (offset + u64::from(fb_layout.pmu_reserved_size))
+        if fb_info.pmu_reserved_size != 0 {
+            offset = (offset + u64::from(fb_info.pmu_reserved_size))
                 // The 2 MiB alignment is r570-specific.
                 .align_up(Alignment::new::<SZ_2M>())
                 .ok_or(EINVAL)?;
@@ -151,20 +151,20 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_layout: &FbLayout) -> Result<u64
 
     /// Returns an in-place initializer for [`FspCotMessage`].
     fn new<'a>(
-        fb_layout: &FbLayout,
+        fb_info: &FbSizes,
         fsp_fw: &'a FspFirmware,
         args: &'a FmcBootArgs<'_>,
     ) -> Result<impl Init<Self> + 'a> {
         let hal = hal::fsp_hal(args.chipset).ok_or(ENOTSUPP)?;
 
         let frts_vidmem_offset = if !args.resume {
-            Self::frts_vidmem_offset(hal, fb_layout)?
+            Self::frts_vidmem_offset(hal, fb_info)?
         } else {
             0
         };
 
         let frts_size: u32 = if !args.resume {
-            fb_layout.frts.len().try_into()?
+            fb_info.frts_size.try_into()?
         } else {
             0
         };
@@ -368,15 +368,12 @@ fn send_sync_fsp<M>(&mut self, dev: &device::Device, msg: &M) -> Result<KVec<u8>
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
index 6b7d00205000..028a58f2bd40 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -3,7 +3,6 @@
 
 use kernel::{
     bits,
-    dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
     time::Delta,
@@ -16,15 +15,13 @@
         gsp::Gsp,
         Falcon, //
     },
-    fb::FbLayout,
     firmware::{
         gsp::GspFirmware,
         FIRMWARE_VERSION, //
     },
     gsp::{
         cmdq::Cmdq,
-        commands,
-        GspFwWprMeta, //
+        commands, //
     },
 };
 
@@ -50,23 +47,16 @@ pub(crate) fn boot(
 
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset, FIRMWARE_VERSION), GFP_KERNEL)?;
 
-        let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
-        dev_dbg!(dev, "{:#x?}\n", fb_layout);
-
-        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
-
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_bundle = hal
-            .boot(&self, &mut ctx, &fb_layout, &wpr_meta)?
-            .or_else(|| {
-                dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-                dev_warn!(
-                    dev,
-                    "The GPU will need to be reset before the driver can bind again.\n"
-                );
+        let unload_bundle = hal.boot(&self, &mut ctx, &gsp_fw)?.or_else(|| {
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
index 93f2125dbbfb..d8f88f1665e9 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -36,7 +36,10 @@
 };
 
 use crate::{
-    fb::FbLayout,
+    fb::{
+        FbRanges,
+        FbSizes, //
+    },
     firmware::gsp::GspFirmware,
     gpu::{
         Architecture,
@@ -169,10 +172,10 @@ unsafe impl FromBytes for GspFwWprMeta {}
 
 impl GspFwWprMeta {
     /// Returns an initializer for a `GspFwWprMeta` suitable for booting `gsp_firmware` using the
-    /// `fb_layout` layout.
-    pub(crate) fn new<'a>(
+    /// framebuffer ranges `ranges`.
+    pub(crate) fn from_ranges<'a>(
         gsp_firmware: &'a GspFirmware,
-        fb_layout: &'a FbLayout,
+        ranges: &'a FbRanges,
     ) -> impl Init<Self> + 'a {
         let init_inner = init!(bindings::GspFwWprMeta {
             // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
@@ -191,25 +194,67 @@ pub(crate) fn new<'a>(
                     sizeOfSignature: u64::from_safe_cast(gsp_firmware.signatures.size()),
                 },
             },
-            gspFwRsvdStart: fb_layout.non_wpr_heap.start,
-            nonWprHeapOffset: fb_layout.non_wpr_heap.start,
-            nonWprHeapSize: fb_layout.non_wpr_heap.end - fb_layout.non_wpr_heap.start,
-            gspFwWprStart: fb_layout.wpr2.start,
-            gspFwHeapOffset: fb_layout.wpr2_heap.start,
-            gspFwHeapSize: fb_layout.wpr2_heap.end - fb_layout.wpr2_heap.start,
-            gspFwOffset: fb_layout.elf.start,
-            bootBinOffset: fb_layout.boot.start,
-            frtsOffset: fb_layout.frts.start,
-            frtsSize: fb_layout.frts.end - fb_layout.frts.start,
-            gspFwWprEnd: fb_layout
+            gspFwRsvdStart: ranges.non_wpr_heap.start,
+            nonWprHeapOffset: ranges.non_wpr_heap.start,
+            nonWprHeapSize: ranges.non_wpr_heap.len(),
+            gspFwWprStart: ranges.wpr2.start,
+            gspFwHeapOffset: ranges.wpr2_heap.start,
+            gspFwHeapSize: ranges.wpr2_heap.len(),
+            gspFwOffset: ranges.elf.start,
+            bootBinOffset: ranges.boot.start,
+            frtsOffset: ranges.frts.start,
+            frtsSize: ranges.frts.len(),
+            gspFwWprEnd: ranges
                 .vga_workspace
                 .start
                 .align_down(Alignment::new::<SZ_128K>()),
-            gspFwHeapVfPartitionCount: fb_layout.vf_partition_count,
-            fbSize: fb_layout.fb.end - fb_layout.fb.start,
-            vgaWorkspaceOffset: fb_layout.vga_workspace.start,
-            vgaWorkspaceSize: fb_layout.vga_workspace.end - fb_layout.vga_workspace.start,
-            pmuReservedSize: fb_layout.pmu_reserved_size,
+            gspFwHeapVfPartitionCount: ranges.vf_partition_count,
+            fbSize: ranges.fb.len(),
+            vgaWorkspaceOffset: ranges.vga_workspace.start,
+            vgaWorkspaceSize: ranges.vga_workspace.len(),
+            pmuReservedSize: ranges.pmu_reserved_size,
+            ..Zeroable::init_zeroed()
+        });
+
+        init!(GspFwWprMeta {
+            inner <- init_inner,
+        })
+    }
+
+    /// Returns an initializer for a `GspFwWprMeta` suitable for booting `gsp_firmware` using the
+    /// framebuffer region sizes `sizes`.
+    ///
+    /// The region offsets are left at zero: the ACR ucode computes them when it sets up WPR2.
+    pub(crate) fn from_sizes<'a>(
+        gsp_firmware: &'a GspFirmware,
+        sizes: &'a FbSizes,
+    ) -> impl Init<Self> + 'a {
+        /// VGA workspace size to reserve at the end of the framebuffer, in bytes.
+        const VGA_WORKSPACE_SIZE: u64 = u64::SZ_128K;
+
+        let init_inner = init!(bindings::GspFwWprMeta {
+            // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
+            magic: bindings::GSP_FW_WPR_META_MAGIC as u64,
+            revision: u64::from(bindings::GSP_FW_WPR_META_REVISION),
+            sysmemAddrOfRadix3Elf: gsp_firmware.radix3_dma_handle(),
+            sizeOfRadix3Elf: u64::from_safe_cast(gsp_firmware.size),
+            sysmemAddrOfBootloader: gsp_firmware.bootloader.ucode.dma_handle(),
+            sizeOfBootloader: u64::from_safe_cast(gsp_firmware.bootloader.ucode.size()),
+            bootloaderCodeOffset: u64::from(gsp_firmware.bootloader.code_offset),
+            bootloaderDataOffset: u64::from(gsp_firmware.bootloader.data_offset),
+            bootloaderManifestOffset: u64::from(gsp_firmware.bootloader.manifest_offset),
+            __bindgen_anon_1: GspFwWprMetaBootResumeInfo {
+                __bindgen_anon_1: GspFwWprMetaBootInfo {
+                    sysmemAddrOfSignature: gsp_firmware.signatures.dma_handle(),
+                    sizeOfSignature: u64::from_safe_cast(gsp_firmware.signatures.size()),
+                },
+            },
+            nonWprHeapSize: sizes.non_wpr_heap_size,
+            gspFwHeapSize: sizes.wpr2_heap_size,
+            frtsSize: sizes.frts_size,
+            gspFwHeapVfPartitionCount: sizes.vf_partition_count,
+            vgaWorkspaceSize: VGA_WORKSPACE_SIZE,
+            pmuReservedSize: sizes.pmu_reserved_size,
             ..Zeroable::init_zeroed()
         });
 
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 34b4bb82a999..11e436651a69 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -5,13 +5,9 @@
 mod gh100;
 mod tu102;
 
-use kernel::{
-    dma::Coherent,
-    prelude::*, //
-};
+use kernel::prelude::*;
 
 use crate::{
-    fb::FbLayout,
     firmware::gsp::GspFirmware,
     gpu::{
         Architecture,
@@ -19,8 +15,7 @@
     },
     gsp::{
         Gsp,
-        GspBootContext,
-        GspFwWprMeta, //
+        GspBootContext, //
     },
 };
 
@@ -44,8 +39,7 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        gsp_fw: &GspFirmware,
     ) -> Result<Option<crate::gsp::UnloadBundle>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 22b60f9233de..358dc2f25e26 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -16,7 +16,8 @@
         gsp::Gsp as GspEngine,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::FbSizes,
+    firmware::gsp::GspFirmware,
     fsp::FmcBootArgs,
     gsp::{
         hal::{
@@ -144,19 +145,23 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        gsp_fw: &GspFirmware,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
 
+        let fb_sizes = FbSizes::new(chipset, ctx.bar)?;
+        dev_dbg!(dev, "{:#x?}\n", fb_sizes);
+
+        let wpr_meta =
+            Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::from_sizes(gsp_fw, &fb_sizes))?;
+        let args = FmcBootArgs::new(dev, chipset, &wpr_meta, &gsp.libos, false)?;
+
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
-
         // Wait for the GSP RISC-V core to halt in case of error. We create this guard after `args`
         // to make sure that boot args are kept alive until halt, in case they are still being
         // accessed.
@@ -167,7 +172,7 @@ fn boot(
 
         let fsp = unload_guard.1.fsp.as_mut().ok_or(ENODEV)?;
 
-        fsp.boot_fmc(dev, fb_layout, &args)?;
+        fsp.boot_fmc(dev, &fb_sizes, &args)?;
 
         // Wait for GSP-FMC to release the GSP lockdown, indicating that `args` is not accessed
         // anymore.
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 648657e248da..7a7c7c58aadb 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -17,7 +17,7 @@
         sec2::Sec2,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::FbRanges,
     firmware::{
         booter::{
             BooterFirmware,
@@ -142,7 +142,7 @@ fn run_fwsec_frts(
         falcon: &Falcon<'_, GspEngine>,
         bar: Bar0<'_>,
         bios: &Vbios,
-        fb_layout: &FbLayout,
+        fb_ranges: &FbRanges,
     ) -> Result {
         // Check that the WPR2 region does not already exist - if it does, we cannot run
         // FWSEC-FRTS until the GPU is reset.
@@ -160,8 +160,8 @@ fn run_fwsec_frts(
             falcon,
             bios,
             FwsecCommand::Frts {
-                frts_addr: fb_layout.frts.start,
-                frts_size: fb_layout.frts.len(),
+                frts_addr: fb_ranges.frts.start,
+                frts_size: fb_ranges.frts.len(),
             },
         )?;
 
@@ -200,12 +200,12 @@ fn run_fwsec_frts(
 
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
@@ -259,8 +259,7 @@ fn boot(
         &self,
         gsp: &Gsp,
         ctx: &mut GspBootContext<'_, '_>,
-        fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        gsp_fw: &GspFirmware,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
@@ -268,6 +267,17 @@ fn boot(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
+        let fb_ranges = FbRanges::new(chipset, bar, gsp_fw)?;
+        dev_dbg!(dev, "{:#x?}\n", fb_ranges);
+
+        // Declared before the unload guard so that if Booter fails while running, SEC2 is reset
+        // by the guard before this allocation is freed.
+        let wpr_meta = Coherent::init(
+            dev,
+            GFP_KERNEL,
+            GspFwWprMeta::from_ranges(gsp_fw, &fb_ranges),
+        )?;
+
         let bios = Vbios::new(dev, bar)?;
 
         // Try and prepare the unload bundle.
@@ -287,8 +297,8 @@ fn boot(
         });
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
-        if !fb_layout.frts.is_empty() {
-            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+        if !fb_ranges.frts.is_empty() {
+            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_ranges)?;
         }
 
         gsp_falcon.reset()?;
@@ -309,7 +319,7 @@ fn boot(
             FIRMWARE_VERSION,
             sec2_falcon,
         )?
-        .run(dev, sec2_falcon, wpr_meta)?;
+        .run(dev, sec2_falcon, &wpr_meta)?;
 
         Ok(unload_guard.dismiss())
     }

-- 
2.55.0

