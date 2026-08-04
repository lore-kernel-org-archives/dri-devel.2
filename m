Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536F5C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FBF10E123;
	Tue,  4 Aug 2026 05:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ijDaVreU";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244D810E123
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nokAB0PcRCnw0vuRTBB7VtbZii2J8xXPIrNxgRESHrCiiLNAdRJHbq3YYkDiWewuy6th+/yrszETy/kcfyOCxMy3yYBM8mjp+lkljT3urTT46GJUpnJEwqZk7DTdWZvLPLPJ/vd4qyp5LMOYglsallbE3727I1K5zA7bHc9w7hke1gAKYs2SnWfAmZuQl7lbPTvpUYIiNbb0TsIfxGc+YN08otxdwP0iOB13Fo1iuGSX6yFRls7dOpTZ8HoDp94oTsjFVYPNYmuqXBopUR7d0GcE1hAMRr3l1NUqHnJFAZuxvr6WhnosM8raib31j5pPsjI4DHoZUPKl+wjC0HjgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkTm9Ld11cyoyG4ipCgReXRbDhCljXq6cA3/EWHTOlg=;
 b=SzWAkuyZDJ9cjdCkvGEtVC7nynPgPxgRtOfRr9gJ7klZYYaeHmLA6OxdqF2L1dVnVUESYzw2u0RqEO8G8/FaQpz13TsqG1pceIVEw+PR8lWP/1zO4NhMSQoeIxVveUl3mNym53XZ4/ZENwR55Ht0mj/Wg/66Y9BrImd+8tkM59w+C5Fsi1KsKuNNq45uI379A1DgD8eLAxKaA7+XMUVZPZ5rhKTpsHS3D9r6/++A6rkPhmi663TpVUmPTb2xHr06bZ1u9X2sEZbS+vZvP8xzGttK1bzn2L5Lkfj+D/+kc1/yTtji/gG7w22HrI5ZSow7EetZmlZ9mFstLok+Ej5lpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkTm9Ld11cyoyG4ipCgReXRbDhCljXq6cA3/EWHTOlg=;
 b=ijDaVreU+QOM9/BEltpd6iSWKOsPBt1njnzpoDuxE6Crr+A+vm2LEE789hEwdeU1K11ORkZ1Q+7QVyLRH1WnLEZ/wE5YHq9IL1B719R7cGg+UZdGsfo7e2e1aXSbVpVdrgYdlOeGzP8r+mR8WPJmqEohfOOjdk3uuX/6DkyoHvBuUSlH3RpfRwyiOWIh98BuGjmfBScXrBe1Ze9LpRTV4rmX2Lyg8wAp+GjkyVFmVU0yjFRZWloUmWlmO+aNq3+WdVouUSbR4tcFy3qtdnNBEzUAojPqP0HTVVw6rzAIyZlmZiSh1O0o2X8NRtzcXYx+KYHK3KuwqeWLj3ViyK8p+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 05:44:43 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 05:44:43 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 04 Aug 2026 14:41:13 +0900
Subject: [PATCH v4 2/5] gpu: nova-core: rename heap size field
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-blackwell-fixes-v4-2-ac858b6a1935@nvidia.com>
References: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
In-Reply-To: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0078.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d275952-c562-43c7-617d-08def1eb7b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Yow1NPjCK5lZPvfeUtRbN9IjqJUSFYPmn3CPP3no2oTobbmGvHOVBmo3VgGGovlqqep+x4Rh66hFfOGfcEBJBntwS2bX+zxvO7aLM53Fm7eZByDwTc7DzbTbG59kCdoBDve+R7j714J4zZbdm/QlTTVMxeyeg4P+Vcl4E7vc2oIFx1NoRGK0rzaBgzbyvu2+khLM2VNbN2oOfuLf+0mOAqqKQljh4T2UAe1MSpqPNuIyKc6TF3ODcFP2PQviEwTcsJPJ2lg+gaUey2KxLxfW52J7RWwuXNV7TixVXipt+r4uFM7xIBKU3fNqLlWFhSXHnAssJv6IG5X+vP5DsKtm0IOn4Ssv0mrVMCjFDhwgOZ8EEuyhlR7JdVlZx6D96R+sD1P0eSuZybGAApKjMQ3RAhLXaT/KU55HMWScHp1D7iiGD2LB1VUkm6JGxzxFk7mXjBfXa+8sLupPXRJY4UviRhskQeWWTmXLH0mTWktPu5v2Ter2ewbZRad23NiixgcIk3/MWABDdKyhuBSpHvf915GGoq360zc289CpIDh94j0px0OOZddqrORH9b0+szBQHI6w3tpqRGDItnn9W3kEh2o1qxHcFFsWx/CPc5vfo4w2SVXP2NflUBCfuSK0nYa5Gmt54u8+HBUPWSTgXoP/NxgjPycMbkmw0VUY4g54LoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1piMFFlcUROZVc5SUJZYSszYnhabnQrSURKbUpTRkp0RkJqU2hPN0k1Q2M5?=
 =?utf-8?B?Zm1BRmI5WTBtZ2FQSkJtQmJnSWhSdzUzUTFTZHMzdUo2eTg4Y29lYWRSK2RH?=
 =?utf-8?B?OVREWlRyeGQ3eTJLZmcxRXlSMjBUbXhyMGFlOHAxNXpaZXhzNUttUmhaMzB0?=
 =?utf-8?B?SkdnYmxKenlzdm1KVmIvRXRUY0FyTU9Ba1ZtaE5qeTZNOCtPUEVRU1kvck04?=
 =?utf-8?B?V1dsMVNTK3BMMW03c3o0MVNNUWdSSGdSd2Z1N0lvbmNnTXFwS3Nxa051akhJ?=
 =?utf-8?B?dkhjMmY1N0JHbHZFWmJaUjFGc3NxYnZoR1VhV3FMN2h5WFZQRk1KTndnS1Ex?=
 =?utf-8?B?Mk0vTGhzSFd4cjJLK1dWWXlDSW5JZENHUHNvNWg1QWs5S21OZE9tUzJPY0lp?=
 =?utf-8?B?MlYwL3JMa1dQUnhmYUxiWE5MTEtwSGx0eWxaVE4ybGlrN0ovMXRSRm5lem1E?=
 =?utf-8?B?bXZIcE1CZ0N4SUd0UWg3bFNVT3hRVzVZNDNZYTJTdm9DYjVJNGpUbWlSdFRO?=
 =?utf-8?B?cnE4UExsZXVuSEkweDd4RjkvM1FWdEtVTy8vcG1Ic3AvS1J2TGVBa1dKZ2Y4?=
 =?utf-8?B?T0NETkcrV0pxWEo2WGxuc1pJYWF3UHVjeUd5dXFRZTl3bW1Tbzdna1FzV2Nm?=
 =?utf-8?B?V1JtcUJxNlRoT2pTdFdTWUtmTWhCWkF5ODZOUWhWWHA2bzFLdlE1V2k2c0pq?=
 =?utf-8?B?K2ZVVGZ0L2phcVBCZjg3K09YZnZIM2ErNzFKa2tpNkVpaksvbllGNlhCSTRk?=
 =?utf-8?B?OGNzTFpSdUJRRVhtdUlVV3lERnpLSVRXZ2RQdjNlbHpMRS92MGdGbytJNTc3?=
 =?utf-8?B?cXQ2RHFjdXVxTlgwbU96Rld2akRYa29TbXlsZlh6OVN0U0RxaXFPTmVTdDQ5?=
 =?utf-8?B?RTJMNC9OTDlqOXRYaUdieEVGUExTRWorWi8relh0Y2hkeno5V1RBd25sK3hv?=
 =?utf-8?B?ajg2SXFuRTNXeTMvcVBqUHhVVVkrR2s1VGJJQVJuanloV1E5U240MFpmNUxj?=
 =?utf-8?B?clNXNnYvT2NqVm1hL1lCb01rV1Zzak1sb3duazdzeW05NVk3MVI5UFhXSnJV?=
 =?utf-8?B?OGVvOGhPUjVCZ2tXWVdtVzEvb1owbzc2bkJ2V1BxaEdHK0FyT0ZVV2hVN3lm?=
 =?utf-8?B?S3I4d0VrR1hBQkdzbTdKcloyWFY0dEpNcEpjQWZ0WGU0VG9xNk1HRmc2Ulhh?=
 =?utf-8?B?eFpCSUNKZDFjbmQ0SjhVaXpCOE5sWXRqdDNYUm5ibmcvNVYzRGVWeldmUWFo?=
 =?utf-8?B?M1Z6VG5HVzJHd0VKMTc5ZGR2cG9KZ0gzMVlkODFaMVJsbk05UVZIdm5JcXQ2?=
 =?utf-8?B?MDQ1U0NvSExNb0YwdWo1Vy9MMjI2bnVCT0QyVkg0ZlVOYmFOY1NxZW40MWJm?=
 =?utf-8?B?SEhvMkttUlJqU1loRkFlTjJuZmtKYStocXQ5QnFxZGV2cG9SRk5xV05oN1dj?=
 =?utf-8?B?VEFVb0RlN0hJaDlQdVVEQkVTMytzWjhIenN5NS9SSCtjcGJ5MUcrWDdaMmVU?=
 =?utf-8?B?bms4MkFtcWptQUdBK29NekxJRTJybXBHbTlzNVpyR3V3WHkxb2RrOVg4Y1Fy?=
 =?utf-8?B?OW1LOE1tcVpmT2FISGxpL3VHYnlIcDNDNEJFaDdOM3p2cWt6Y1FMWllsUTdP?=
 =?utf-8?B?SG5YTDBFSnBseGJoVzd6bnZUUVdxczJTN1RyZEVPYnhWeHhjUUhMWmJMTnNS?=
 =?utf-8?B?RkZONjl4M0pNL2JZNjhvVWtweDJhTCs2cnFDOGlQbXlhU1VQVHpKc2pFamtw?=
 =?utf-8?B?c2RIYUNMY21oS1dKTDNxVFlFbDI0N2gvc2YwOG44bmN5dEFFNlVOcktmOWQr?=
 =?utf-8?B?YmdVUjRaU3RHcEsxM0tPRFNVSnUzNGo2UmdWWHpkUlJxdjM3YTcwd1NDM01F?=
 =?utf-8?B?cW9QLzhSMS9UNEdZNDN6MnN4Ung3K3o0QWNjZXpBOHRxK1o5UVd1SjU1TXdl?=
 =?utf-8?B?SFF4c09WU2xWNmRsYTl3MmM1aE14ZmhtbFBudDFBUU5rZUxKMUlPWXBxN1RK?=
 =?utf-8?B?ZUxqQnp4dTZBbU5VVE9FZDNvd0piTXJxZ3pMRW02c0xwSmVuWjJ1YU53bWlP?=
 =?utf-8?B?NWtjdWNFRG1vYnFCWlpxdDl5QXJLb1pLS3ZDQjdrdzIwTHJyZG1BZ0UyQThi?=
 =?utf-8?B?aUZuMjhpcVdBL0dKcWJrN3BUOElaM045bDBMVUh2WTNONk9Td3dReHI1Z3lh?=
 =?utf-8?B?VXBtTDlzcXRnd1NLV0tKclZlUzd0WmxHUk51aS81WnhMS2Npd1VwUXlEQzFL?=
 =?utf-8?B?eS8xNlZaaVFHQzhJZ1ZoOUxtcnlmQjJGUDE2dlZiL3R6cVFHa2JwcEpqenMz?=
 =?utf-8?B?RWl1bURxcXp1djRVMXJ1WTFXRDBOSm1yN1RKYkJJRlVUTHJKdGRhQVR4TmZk?=
 =?utf-8?Q?apCzoXcKYlshOeWqjjj5G9JLUmO+GE6JqlANsWQalG+FY?=
X-MS-Exchange-AntiSpam-MessageData-1: jYgWfq/wTd//7w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d275952-c562-43c7-617d-08def1eb7b14
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 05:44:42.9555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoAIlRuTcEtvTwUaYWBzMOLh8fcC9ARcl3Fwv4GUFMqzwUgsKzNx4oQwzS4Icm3U5P6EzwPmkvFY8u3fvXbjfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

This field is called non_wpr_heap_size everywhere else. Unify the name
to make it more obvious which heap it is.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs     | 10 +++++-----
 drivers/gpu/nova-core/gsp/fw.rs |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 9e475efb1150..4a1be29cf5fb 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -164,7 +164,7 @@ pub(crate) struct FbLayout {
     pub(crate) wpr2_heap: FbRange,
     /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
     pub(crate) wpr2: FbRange,
-    pub(crate) heap: FbRange,
+    pub(crate) non_wpr_heap: FbRange,
     pub(crate) vf_partition_count: u8,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
@@ -270,9 +270,9 @@ pub(crate) fn new(
             FbRange(wpr2_addr..frts.end)
         };
 
-        let heap = {
-            let heap_size = u64::from(hal.non_wpr_heap_size());
-            FbRange(wpr2.start - heap_size..wpr2.start)
+        let non_wpr_heap = {
+            let non_wpr_heap_size = u64::from(hal.non_wpr_heap_size());
+            FbRange(wpr2.start - non_wpr_heap_size..wpr2.start)
         };
 
         Ok(Self {
@@ -283,7 +283,7 @@ pub(crate) fn new(
             elf,
             wpr2_heap,
             wpr2,
-            heap,
+            non_wpr_heap,
             vf_partition_count,
             pmu_reserved_size: hal.pmu_reserved_size(),
         })
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 6e8e7d822ef1..a7637bf3f3df 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -196,9 +196,9 @@ pub(crate) fn new<'a>(
                     sizeOfSignature: u64::from_safe_cast(gsp_firmware.signatures.size()),
                 },
             },
-            gspFwRsvdStart: fb_layout.heap.start,
-            nonWprHeapOffset: fb_layout.heap.start,
-            nonWprHeapSize: fb_layout.heap.end - fb_layout.heap.start,
+            gspFwRsvdStart: fb_layout.non_wpr_heap.start,
+            nonWprHeapOffset: fb_layout.non_wpr_heap.start,
+            nonWprHeapSize: fb_layout.non_wpr_heap.end - fb_layout.non_wpr_heap.start,
             gspFwWprStart: fb_layout.wpr2.start,
             gspFwHeapOffset: fb_layout.wpr2_heap.start,
             gspFwHeapSize: fb_layout.wpr2_heap.end - fb_layout.wpr2_heap.start,

-- 
2.55.0

