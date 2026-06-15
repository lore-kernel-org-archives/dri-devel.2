Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225BFCD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E6D10E4BF;
	Mon, 15 Jun 2026 14:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RgtDjEfN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DB110E4BF
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZZl3HSlskF8XWBm3qQqMUyLX50sPXoMynA++HMOG19WNesf5gJuqvJPRJEp/lzNhNahssdTP3xz0HHs4qgHxahU+E3kTRMp6GIyzieAu2ujo+didgr/aGxyz7DCKKbUP72+euQ6D/PH2VGV51bb4ZroP6pSKC0m84XaSBFg0I0n7ELdBkDuB40z8AULLmfdK8qsUQDc/GefYKpKaGyeAqkTcM8nikcJDdWfsm0zGYAJmBn6mUM7ix62UNKjQcb+PFs7kzxMRwIiUAHdVsB0ATxGAIT36Mn/2grUpypJ5/al+nRI5kHM7ozfxT2xf3/E6RN7n6UlZp+ZTzgW0pCrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbVRsdLzGJ9/2tihhKZuoRkm+V1nkk2isC+reHIFo2I=;
 b=j6embeasI7JXjmX9xwkPmhX7Dl4Cznredeyw+exGlzM9ajT5F+uH1yJbzU8O/kI7jlL6DXilL+ZzCa1HjIoWPoPHs6nRuZby0nEqUP+h+tP3lrNKYSVE2mFPuRTnJn9LtS8Uvby/vCuQstHaJr+cRAX8SXiJm+82uYOffMhWLJTynIcbbuSvp3WJJaadHULeOWN3m20EXTpxNhxHWnMfh5yUdSKuogZth1r8BJgq2cGYAc41Pr5nmhAOObl+rxBB448uaWFengO4EPbOUYMSvKM1UCr5ktVuQRQXN1Oes8M78RS5tC1FpYvG+PvCh34u2kAbCruSjP5U6+upPYy1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbVRsdLzGJ9/2tihhKZuoRkm+V1nkk2isC+reHIFo2I=;
 b=RgtDjEfNgGsxN0umPg6qjXMygq+Q0ZYLWiyzJNIrgHH4qvduSW+qH3Nsj+SZ17HkZsm88f1uBkuuKoE5cGGKckCdBScDv3mjQF+5suDdCdgGQMx+Wv2aSWsUyL5/XCbZgQyTRJm2wdlkT4LycxNZcr2EfoLc56pAdrlFPbQBHiWONSsRkvQJGbtcmMfD+uEemgJKGDq9hTbyuodq4dnzB855GOfypDv0IZIDUuZYcQghrZ/wIuMov6Kxw+t63B9/bBZiAh2bl8WjRyw1nZLBfTjRyckFprhmQGeyKGf1rKL7x8SJAV615nJ6IYRXlXjFxBgoF8+XSehTM6B7WzADng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 15 Jun
 2026 14:42:13 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:42:13 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:50 +0900
Subject: [PATCH 10/13] gpu: nova-core: split FbLayout into FSP and non-FSP
 versions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-10-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3fb82c-857e-4728-9271-08decaec49ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|11063799006|3023799007|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gxBbN8Yo4onONaNoZQUdc8h+6HyzdTGktFf4uAGod6/IUrk2Eko9diHUNu24fpclbyz1lPfdFpUTEOtMK9RvajZehu2APoHy4G7tM/jezYXAd3GGj3PrVaXj50HWkMSs3ZAoLgyhjYJ+i9vwu7K4LyjO/M21v5d/Et1DrjIIeDcTN57hJ0a9MM2kVwjEMvWy3g1NjJU4ODmH6m466LiU/jIcyeb9cVwEzzXj4cfr/dgGiwRV8x50PNfgNKnNpO3pP92GX77d6kcGr1i44N4aSrf4LkD68ABBWXNxUV8N+aMyeb79TcE7XMF7X8vjljghfJESJ9KghwrU7h42o04W+rqyPA9jxFNW8DengfLX0NORG1wzkXkdSRWnrThXmUraYcMbgkBL2N2Cfge7lwubqgrI3yrWwHkoXH5vLDH8CYm4uk6+Ri5tUvXtE/4n/Yz7jwRRJrLX9bJFLbtpKFkUZXPMHHChNM6LS3+s6RE+6yG+CBGtTjy2a/RdNaTJf7oTlNpVH83lfZX+JFNHbrH9qvAa5qnIvfKlf/NvsKloeLrXce1MccROBtyv6GdDBQOrZRWB99zaMfzQR66u6pj3oDyo6pj4q3gCgfqpjmfNTknBbPqhcY/zcs63Rk3wE8dJI4hUaNbM/zlpgPPlb/zXggPZrtc59YL8qkpkD/FVr8hHJaNBcP3IdvtFlezIwBRb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTQrTXYwMGMrLzM4eVI5M0JuV3dnTnJ5M1NDQzVESFNIVDZDUnRlMHJ3Qytu?=
 =?utf-8?B?cFExYlZqVjlkQ1lTZnFib2RLTXZNOTdvb04zR0dmWUw0ejBCZU9FM0FNMG8z?=
 =?utf-8?B?bjQyVEJJRFBlaEpOZksvdXpuWHRRU3ZRQ2t4OVIyU1N2cStITmN4blZsVitE?=
 =?utf-8?B?c3hqelBZSnEwbk9sK1ZPMm1KbkNPRmliRFZRbUxEWVNTcE52S0Z0aDI0SVpv?=
 =?utf-8?B?RzBTT2U5cWVYM2FPVHJBTEREeFQ4YUFNdGV4V0FldVl5T2lDVHIrVGthWEpN?=
 =?utf-8?B?Sk9ZK213Tys4NHpCbEt4SW13ZHVwS1pIMTRqWkJBTHpGMHN5UjdTYytyYXRr?=
 =?utf-8?B?T3IrSk1LTlRUV1ZJMHVRM0VIajBHeDNCVXRod0tVMnlhL1JQdFFMNzErSDY3?=
 =?utf-8?B?ZmVhRDVlNzkxRzdvSkRsMWx2ZGd1ZDByTC90WWx5RGl1YWhRN1B5ak1BQmFS?=
 =?utf-8?B?TlJPdzlzeWkveGZwL2VUdXEvK29zZHFXQk9XRThzbEV1R0ttbGlmL3RQdXJD?=
 =?utf-8?B?VkRaeXQ1Y3pmN2VhOW11VVdta0l3RG50ODQxNE5sck9XOVNKZkF5WE14S3ZU?=
 =?utf-8?B?cHBmOG1PZlVZWEJrRjhhbUFlVU5saXZJNk1jaXpvbEtYbmM1VFhnZnJzbWJk?=
 =?utf-8?B?cDArTmZSb2pBYmhkS3p1MjdiZFdHb3AvVEFmOG55eFpIbjhtSGJhVEQraDZi?=
 =?utf-8?B?QnFJVnRGWTg2TC9FTWNLUmZ6WSt2a1N3OVA5aTl6c3JhMXpTeDJ6YWNQQkMw?=
 =?utf-8?B?Q1BKeUh6VUlDL2U4cUJrQzlzTCtrcWdVZGkyc0c3KzByTTdnWkJOTnZrS3lR?=
 =?utf-8?B?bTFUTjRzK2RsV2RqV2ZzNDY0RlVmaGdPbXY4L2ZUaGJST3pNajY0QkIrYTVn?=
 =?utf-8?B?Wmp6RXBVdGI4L3lwVkRjZFphbUJ3NGFFZk4rUGk3bDg1K3kzOXJYbDlFV0d1?=
 =?utf-8?B?TjArUE9oRXhzelR5eXRaUTVvVFplOWU4eWVWTEk2bEcwajJ5OFZOSGxqUWgr?=
 =?utf-8?B?Y090T3h0U05zUzZPN0tVMDBHTm1PMkhNY2FOR3B4UEZacEsvbEhGbm9VNXhk?=
 =?utf-8?B?NWtaV2xac3BLbk82Z05Sdm8xaUlPWkRMaDFLNjVyc0w4Z3V4U0dWRnppYnVn?=
 =?utf-8?B?VEFWWW1McFhBbHZsUmovNnBQY0d1UjlpcjFVM1BKcTV3LzBlcGZqbjFaMmNG?=
 =?utf-8?B?TjFTSXdtejRqMzFMcE5MZjlaZ2hEcnZheFFlbFViNVYwQjJKUnpQQ295WGo2?=
 =?utf-8?B?V2p5bENnNlBiV2xPcTllZWZYZ3oxdjJIMmd1Y21NSEx4ZGcrSmUxZU9iR1hJ?=
 =?utf-8?B?bDBiY25uaDJtNnpTTDBLVTdUU2MybUVyQ1huL2NGbXl2TVFiME9jVzFqTVRp?=
 =?utf-8?B?aHhxTUhSUmNRWCtrSGt6MzJpbmpoSWFvZDUva1UvaTEvYWd5eW15N2FIaVBX?=
 =?utf-8?B?T1puS3ZRTFdJVm9qK1FBdUcxWEZlcW0ya0h3QTFUYWxDbjg3ZkE0OVlXTU1V?=
 =?utf-8?B?QmFaUy9yc09rTytsVjQvaThadExlZWE4NkZITCtkVWNQS2N6WHFUU2VCbHhY?=
 =?utf-8?B?dUdwOGtyb2luandOak85dWhaRzFtVmhHdWo4dGl3R1cxMVpodi9CRSs1MzhN?=
 =?utf-8?B?Uzk0OXVOaGw0NzNFVnBqY3FLTmlRKzdXMEJ3L0xGbTYwUlBWUFlYdE4vS1pY?=
 =?utf-8?B?T1g4WTVtaDIvdVVNSFMza29HSzNpV0plaFcyQThXSys0UXFZRDVSS2pXaE5G?=
 =?utf-8?B?U3A5WUEyTHFBdUlCTHFoWVdXMVRORE1lUnpxWFY3dTk2bTR5dE9ZTzZUSDFE?=
 =?utf-8?B?MnlyWFYzRGUwWWNlSGEzT0t0L0lkZE8zR0lwUVcrdmxsRVU2azNlQ2crUkt1?=
 =?utf-8?B?TWVOaTROckF1czdNMm9XWGRBYktIMGdqRmk1L2dCWllaeThUR3MzN2JBVmxL?=
 =?utf-8?B?YVFLRE9oMVRoQkNjZnhaTUwyM3dnVnZyck1vMjZDY0ZJMWVRZTd1bXRGbUF4?=
 =?utf-8?B?cWRmazJUWURha3o3MmdyclNlc0ZnYkZhMEFaMVBsWEpFTmdUbStncHI5TVpY?=
 =?utf-8?B?OElUODN1NlFKWGwvUWFVbmxzMUR1T0NBN3pTV0Jiak1ocWFzWlNpMWRtVDA3?=
 =?utf-8?B?YU1Hcjhpc0kvQmhta3V5dVlCR0JYU09pR01kQTBGK3hiYTRYYksxeHdVcVRq?=
 =?utf-8?B?VDgxZHlpRm5GaWl2UWRuelc3TXVPc3hDemt6eDN0VytWMFppZHp1ZDNpd2Ns?=
 =?utf-8?B?Wk5xT1YzbDlpRmRvZzhUU2pPeFJlOHF0RUh0MXQ2WmQ1eFoxT1lLQ1ZmYy95?=
 =?utf-8?B?U1pSVU00WGx3dUNCVlpjOWphVWFDVy81RnRIU25kbEhIQU1Cb3BXRWhHcUc0?=
 =?utf-8?Q?1S6foKHs5LkPCwZyxPd4bzOJUPijYxePhjT+7DN1UWw1N?=
X-MS-Exchange-AntiSpam-MessageData-1: f84VyQjGjBKwAg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3fb82c-857e-4728-9271-08decaec49ed
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:42:13.5812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9ZHYclxNmkglQRh3csmNHqLs+yqExGPbSzKVZHo2ygXqEpxw4bqLKqyUBKKmXoboZJpAvURu1vL31Q6USrlFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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
 drivers/gpu/nova-core/fb.rs            | 69 +++++++++++++++++++++---
 drivers/gpu/nova-core/fsp.rs           | 15 +++---
 drivers/gpu/nova-core/gsp/boot.rs      | 10 ++--
 drivers/gpu/nova-core/gsp/fw.rs        | 95 ++++++++++++++++++++++++++--------
 drivers/gpu/nova-core/gsp/hal.rs       |  4 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 10 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 24 +++++----
 7 files changed, 170 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 725e428154cf..facecb8b411f 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -144,11 +144,29 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
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
+        if chipset.uses_fsp() {
+            FbSizes::new(chipset, bar).map(Self::Sizes)
+        } else {
+            FbRanges::new(chipset, bar, gsp_fw).map(Self::Ranges)
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
@@ -163,15 +181,17 @@ pub(crate) struct FbLayout {
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
@@ -270,3 +290,38 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Resu
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
index bf0baa5ac4ae..6778e5546cee 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -30,7 +30,7 @@
         fsp::Fsp as FspEngine,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::FbSizes,
     firmware::{
         fsp::{
             FmcSignatures,
@@ -134,14 +134,14 @@ struct FspCotMessage {
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
@@ -151,7 +151,7 @@ fn new<'a>(
         };
 
         let frts_size: u32 = if !args.resume {
-            fb_layout.frts.len().try_into()?
+            fb_info.frts_size.try_into()?
         } else {
             0
         };
@@ -333,15 +333,12 @@ pub(crate) fn boot_fmc(
         &mut self,
         dev: &device::Device<device::Bound>,
         bar: Bar0<'_>,
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
 
         let _response_buf = self.send_sync_fsp(dev, bar, &*msg)?;
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 8afb62d689cb..670a94545b61 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -19,7 +19,7 @@
         sec2::Sec2,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::GspFbInfo,
     firmware::{
         gsp::GspFirmware,
         FIRMWARE_VERSION, //
@@ -114,10 +114,10 @@ pub(crate) fn boot(
 
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset, FIRMWARE_VERSION), GFP_KERNEL)?;
 
-        let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
-        dev_dbg!(dev, "{:#x?}\n", fb_layout);
+        let fb_info = GspFbInfo::new(chipset, bar, &gsp_fw)?;
+        dev_dbg!(dev, "{:#x?}\n", fb_info);
 
-        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
+        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_info))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_guard = hal.boot(
@@ -125,7 +125,7 @@ pub(crate) fn boot(
             dev,
             bar,
             chipset,
-            &fb_layout,
+            &fb_info,
             &wpr_meta,
             gsp_falcon,
             sec2_falcon,
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..042b0122e98d 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -28,7 +28,7 @@
 };
 
 use crate::{
-    fb::FbLayout,
+    fb::GspFbInfo,
     firmware::gsp::GspFirmware,
     gpu::{
         Architecture,
@@ -214,11 +214,65 @@ unsafe impl FromBytes for GspFwWprMeta {}
 
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
         #[allow(non_snake_case)]
         let init_inner = init!(bindings::GspFwWprMeta {
             // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
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
index 04f004856c60..aa41da9902b5 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -18,7 +18,7 @@
         sec2::Sec2,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::GspFbInfo,
     firmware::gsp::GspFirmware,
     gpu::{
         Architecture,
@@ -60,7 +60,7 @@ fn boot<'a>(
         dev: &'a device::Device<device::Bound>,
         bar: Bar0<'a>,
         chipset: Chipset,
-        fb_layout: &FbLayout,
+        fb_info: &GspFbInfo,
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &'a Falcon<GspEngine>,
         sec2_falcon: &'a Falcon<Sec2>,
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 35554d92fda9..ddf3f67e6338 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -17,7 +17,7 @@
         sec2::Sec2,
         Falcon, //
     },
-    fb::FbLayout,
+    fb::GspFbInfo,
     fsp::{
         FmcBootArgs,
         Fsp, //
@@ -152,11 +152,15 @@ fn boot<'a>(
         dev: &'a device::Device<device::Bound>,
         bar: Bar0<'a>,
         chipset: Chipset,
-        fb_layout: &FbLayout,
+        fb_info: &GspFbInfo,
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &'a Falcon<GspEngine>,
         sec2_falcon: &'a Falcon<Sec2>,
     ) -> Result<BootUnloadGuard<'a>> {
+        let GspFbInfo::Sizes(fb_sizes) = fb_info else {
+            return Err(EINVAL);
+        };
+
         let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
 
         let mut fsp = Fsp::new(dev, chipset)?;
@@ -169,7 +173,7 @@ fn boot<'a>(
         let unload_guard =
             BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
 
-        fsp.boot_fmc(dev, bar, fb_layout, &args)?;
+        fsp.boot_fmc(dev, bar, fb_sizes, &args)?;
 
         wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params())?;
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 1e08c482fd39..e809deb72055 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -16,7 +16,10 @@
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
@@ -185,7 +188,7 @@ fn run_fwsec_frts(
     falcon: &Falcon<GspEngine>,
     bar: Bar0<'_>,
     bios: &Vbios,
-    fb_layout: &FbLayout,
+    fb_ranges: &FbRanges,
 ) -> Result {
     // Check that the WPR2 region does not already exist - if it does, we cannot run
     // FWSEC-FRTS until the GPU is reset.
@@ -204,8 +207,8 @@ fn run_fwsec_frts(
         bar,
         bios,
         FwsecCommand::Frts {
-            frts_addr: fb_layout.frts.start,
-            frts_size: fb_layout.frts.len(),
+            frts_addr: fb_ranges.frts.start,
+            frts_size: fb_ranges.frts.len(),
         },
     )?;
 
@@ -244,12 +247,12 @@ fn run_fwsec_frts(
 
             Err(EIO)
         }
-        (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
+        (wpr2_lo, _) if wpr2_lo != fb_ranges.frts.start => {
             dev_err!(
                 dev,
                 "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
                 wpr2_lo,
-                fb_layout.frts.start,
+                fb_ranges.frts.start,
             );
 
             Err(EIO)
@@ -272,11 +275,14 @@ fn boot<'a>(
         dev: &'a device::Device<device::Bound>,
         bar: Bar0<'a>,
         chipset: Chipset,
-        fb_layout: &FbLayout,
+        fb_info: &GspFbInfo,
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &'a Falcon<GspEngine>,
         sec2_falcon: &'a Falcon<Sec2>,
     ) -> Result<BootUnloadGuard<'a>> {
+        let GspFbInfo::Ranges(fb_ranges) = fb_info else {
+            return Err(EINVAL);
+        };
         let bios = Vbios::new(dev, bar)?;
 
         // Try and prepare the unload bundle.
@@ -301,8 +307,8 @@ fn boot<'a>(
             BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
-        if !fb_layout.frts.is_empty() {
-            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+        if !fb_ranges.frts.is_empty() {
+            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_ranges)?;
         }
 
         gsp_falcon.reset(bar)?;

-- 
2.54.0

