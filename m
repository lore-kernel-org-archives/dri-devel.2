Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC3C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA9910F2D7;
	Fri, 24 Jul 2026 06:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uhqBT98K";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB60D10F2D7
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSMtEwXNYsBqQKRBxizzPWWv5PWxPmS8lWqowIOC8LrV4zL/RStqpQtebU0S8aiXu7f3WIjdSA/ZSafA0ROO4enVtXOw/g7qrh9HB+RdPBwG0P3z8Dt4jDZ7TFEH1V7J4y4+dRgcyCeesx3V/i4bsv6p+7Bin3FynuYU8I0EwESh61F/xF29ls37R1eARHkoZyIKp7eIeo9Q+Ktnc9RAMrtpMUNqTJwd/Yg3RY3dY1atIa/teg8sp8Uhey0/TNhhQELymvABf0/x04sWyrxvfNjAnUewYhdCG37JU68SyIWWcI9kJTW62fkEfU49KPq7cAfUB5+l2YwNLawQYZDB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPXIVr5ob5FYSE1wUVrhwgMHdLRTcOpW+p/z31/oeQw=;
 b=yBFiShOna3RLgeMzFmqUAKpsVzi8w4nKlQBquhe86wNzZoYtR1MeA6feeh56NfQMuASuxSmWWXK8e0x+i4azPlMrLs2VHzfXZv1JF9K9AtCvbQMXImMB4neAVaq0n7vS0EKS8nnBT1UL1DfcBaVZkZsTNKI6CDLR+lKSx/yiTMkdnovn7wYGSjd+Cp6yeXLkmMgYNauxJsQeRtWREfBntySXOX6lQQQncbIKEcnH+uBQdOBXeIiwlQob1PzjRBpzfoAW9cmGXbEbY7w/TGvnEuHax0siMXPCPZyjORcQedHCHV1bNxohIDVBcjUxmTzxY56RY8wSYCwIXaYnF7ouTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPXIVr5ob5FYSE1wUVrhwgMHdLRTcOpW+p/z31/oeQw=;
 b=uhqBT98K+aByJWj/Wc9QoJi/+ZwoFm590j0phR6I00JPL/qbwfg3RffOnWyI8fWMRJ8cMpaDh/FqAPXhuy8o1PKlTFJY7kOzwjEc+vWAVpLROa3tt68nvXjnjTfjl+cdO1uxk3hwoJj2d2gTD3Sq6JvwG6vlou7MJlDIF+9zYCfPbLNDblyvtmevsMVwrTadId1lWIeRnv0J3Jz5ZghuVvDvmChAqpizkVbjSgrXvnM0FNbJCq7qSYuxBcRdRduJGpwtBSYfA3674e5si73sU1ezuPMnk2LjDqVINcD8NskQnnBx48NInhFvwVx8UeNcbJ/rTSSkN8rtApnXGYHQ2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 06:56:45 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:56:45 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 24 Jul 2026 15:56:25 +0900
Subject: [PATCH v3 3/5] gpu: nova-core: return non-WPR heap size as u64
 from HALs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-blackwell-fixes-v3-3-01aa6a54e3fd@nvidia.com>
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
X-ClientProxiedBy: DU7PR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::21) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aeaff6a-3207-4ea5-6e40-08dee950b94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: g41MKvGu8Ps63Attn6bzXklPfHXAHfNkM7na3YJR3WI5V3h7COFRrHWvR3OU7H+P1J1aubGF+/L4XJPBYzzGZ5Xz1LRF3Y6JXr0UXo67NGn2t4LFbqQcQfp/wuAOmZfL5bqOkvb2rP778XyaHOtRwIJarGWO0L896g8TXK5sNzLu+7g4ifr+FZOEsdefivUAPyk9MFCkKwe7ea6aKcSHP0pTy6a0vyAlhuRfUGm4l+tF35O8JdwMMDlUpbEYsLQRyOSyYlxRrPuLqyk/kZj9jLaEz4PwqGqkdinQo7YnlaPE8mhXVHG9y5W+x8lxK/N7HfcoiVVgRr/uz8pO6QgImEH7OzLG8ZFI1/kt0hTM0roCo2PFIUGq1GxsW528ThbvQX2ociy0Fc22JRWnmHYCrbfZ0hO74RI3SyncTKEgHFzcwG4uspq7Bkz06DDEv0yfkzgFkzAYu1Ux92IvUgvsme8hBuSjsZq6sD8HFP2XBBf/n3O0/sHFE2/z/4YMBmUSb3HIChwn8yp3bVw20pe5h+Qmec1tF1O8FFRRkih3UKGslWBE97+fb+iRj3Y2JvjlYacmMdZMWSWp086SWkpEPWdF5rCZE45y+4Dms48pryKnFYiEL2vwcFalu7MBON4YKAaFJvh2Es5GfqDOtgZeGRHSRILj2of4fXt74IxhAH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUp0czBPbzBwR2JyS0VCRlJ1U1o3dWdqU29tVG9BVHRzYWZHYjM2dStCWk1G?=
 =?utf-8?B?MmtzemYxb2dSRWkzdndzZEluNXVWQ3kyMTNtT0k5eUUxdTBENUlFenFGdXNt?=
 =?utf-8?B?Rk5UV0hyR1JOaloxUWEyU21wejdsK0RZN3c5QXQ1WWEvVG1aS3R0NW1ncEJ2?=
 =?utf-8?B?ZDBNZS84WElLaExpbm1keThUMFdGQmdqOXEwRHZEMTVTMUZpTXJDMnlBL0l5?=
 =?utf-8?B?MVJSRzhLak44RUlFdEYzVmpYVmpKb3h5c25FVzRHOTVGQ0JqZGFSdFNJay9C?=
 =?utf-8?B?NHNpMXpLWkJVemtzejNCeGV0SE9iZnZVZk9wVmkwem5SYmZ0bXZEcitVaE41?=
 =?utf-8?B?cGNrbXBqbGt0ckxsS1p2cXFWRjdEMTU1Q2RmYy9IYVpIbWUrQmttcDZPcU1X?=
 =?utf-8?B?OWdGd0pTanpuMWJRR3lHWWNkRkNnTTB1Z2hBTG1NVyt2c3lWcTErTC9LM0VO?=
 =?utf-8?B?SVVyTEJDRG9GeXFRdjhyaWtsYWExdkk0Ym9nQjhQZDQvY1gvYlNCc2NzWlcy?=
 =?utf-8?B?cndrWkZTSDZ2Zm42RjlaU0R4MmQ1SmVmL3NpRVZoUkRmN1FnRy9tankzbEov?=
 =?utf-8?B?TUJNWUtENW1LL0RSOFcxRXBoa0d1azZ0WmxadzhLUDZOM1k4R3JjWU9GTWQ1?=
 =?utf-8?B?blJBQi9hSEtuZ2s2UzRYcGFLdmNuVVN6bjNNZzg4YnR3QjFQTmZFSkhSNGli?=
 =?utf-8?B?VEVPVklvRnBZbEh5b3VWWkFTZ1hIQmJLYzk3RllaYXN4bHI5cCtSSEI3d1Iz?=
 =?utf-8?B?b0M5cmRGREt4Qkd5RnMyakxYQ0VpVlA5Y09sS0hMT3d4QmFLSG05ODN3YXdV?=
 =?utf-8?B?Sk0vZVZUZGlFeEx6MnhZTG50V0V6SFpMbzlDY1dEeHpySzVMeWI0dm0xS216?=
 =?utf-8?B?cm4wRS9kZXoyR0l5V1U1djFVM3B1UXd6TEpzTjkzZzJWdlRid2gwK2tldm9H?=
 =?utf-8?B?ZHRuSjNlOEhHMDRtRVdOY0FtZmtKbVRUbXp5aS92Y1U0anZCczhNNERlMlpH?=
 =?utf-8?B?UTkvVU9XblNyNEJaVG9SV3dHSmNwaU9XRzhVeHpDODV5Y1JPQ2NGeEhlVXhz?=
 =?utf-8?B?VitKQWNiUEF0azNFVDRSWGNpYllXUWFCWW9BZ01JeG1Qa3JlaE9qSEVVWEl0?=
 =?utf-8?B?Qk51YUYzOWRUbE1nSVl3Y0tDbHFZZjg0dHVLYUZMeVVmSnFvaGl2dnZXeEEw?=
 =?utf-8?B?eUNyc1JqRDBKVG50cmdUSisvcUlROERlN09Wcy9iOGJCQ3BNbzZVK2YvdjBQ?=
 =?utf-8?B?NmMxSldDK3oyYTUwL2pCcUdocGFBcDF1dTU5TzNWek9sNGVtRjdWZS9ldVNZ?=
 =?utf-8?B?UkZBejJDbVlGd21ZRWxJMEpYaTVvaG1jQWtHSGw5Wm9wYlRDYW1OOVFsaFdi?=
 =?utf-8?B?Q0liM2JIU0dzWTBnM0hWS0grY0ZwdTR6STBoMmFjY2pPaUZ3b3hEWS9HZzJt?=
 =?utf-8?B?OXB3YzBQaUlPanVXWkNtNll6V0p6VXE3TUx6V3lDdGczbUlTUVFMMUZubzl5?=
 =?utf-8?B?dlNCckRIR2REU3JPM0dnOHJ0bnhpNHdLMEhCMm9QYTNKdmNzanlSZW9BWFky?=
 =?utf-8?B?TXlOMGRtVzlLejJZVUhQdnVWZkZTVklFaGNQV1gyVWxBRVlERlF5Ly95UFVz?=
 =?utf-8?B?TERHSml4ZXJvVmpnZURUWENyOUdKR29nNmQ3Z0h4S1FkTGpKOHVPN0NWN1F5?=
 =?utf-8?B?MnBmN3c2cmhEZkJZc1BNdEFKQzYwR3p3R1hJRzQvN1AyNnlYeGNwSkdrcWp5?=
 =?utf-8?B?dFJwWTVMeUV0KzBoakNMSlFRNGtCZjR6aGxVTjE0VFh5VzNlVVJqL0hJai9z?=
 =?utf-8?B?c1JTL2N0Z21KRHg4VVNrQlQ5TTdXYTRvSEVKbkU5aERmQmd0MXQ4dFZYd1N5?=
 =?utf-8?B?ZzFVQ1ZYZHBGNnpnN09UVTRMUm1FZlFsY1llMVlxamQveGMwa0FGdWF4ZG1k?=
 =?utf-8?B?YzgreTcrT3NxVkdjbkZNV0R3MzJneHdvR2FQZkZQdDdSbDBIRWdTQkNGeHJX?=
 =?utf-8?B?RmlTaXpqWTF0RGJmZXRQNnVVZHltTDc0Q3FhMzFlcnl6cnI5TUk0dVdTYU83?=
 =?utf-8?B?VVlpb2xUSmpDb01WdmZ6NlhWQ281L0ZtUGt3L0NjbkVGbnNCQmhUaTd4U0hR?=
 =?utf-8?B?WUU3bWZLSHBxNHpwVnd3ZER6WGsxblpJYkkreVhNZHM0OGhXbmFPdUVYb0p3?=
 =?utf-8?B?RHExT3pMSjhqcHNRcDl2SHB4SzVNVVpoV0I1N3YydHl6NWpKbWV1aUtKaEcr?=
 =?utf-8?B?Z2JpWEtUUFpTcTJOWDhrbmM5RzZzSWZ6d1E4RVZEdE55c1Z5THI4blpwcXRi?=
 =?utf-8?B?ZHU1RzZKRnhjWWZPLzJoSVhGdk82Q2ZybDA0YldRK044T1JEVzJwM09rMTJ0?=
 =?utf-8?Q?ZetaVulXav4iCTF8wvexi3YLJeJ1c9Z4CqIeUeeLXyeuO?=
X-MS-Exchange-AntiSpam-MessageData-1: YS0J7g4VVDrulw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aeaff6a-3207-4ea5-6e40-08dee950b94c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:56:44.9555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/vuuGBpvqGYB75eYmZuyCeCaWLkWGIKhagreLJ4+eJKHky3gD8GttznPULnA+EmQR7/uVLbmwAslWCVU9lyJA==
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

This is always immediately widened to u64, so just return it as a u64
from the beginning.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs           | 2 +-
 drivers/gpu/nova-core/fb/hal.rs       | 2 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs | 2 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs | 2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/gb202.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/gh100.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/tu102.rs | 6 +++---
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 1f7b6a69e4db..f5832e59de59 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -252,7 +252,7 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Resu
         };
 
         let non_wpr_heap = {
-            let non_wpr_heap_size = u64::from(hal.non_wpr_heap_size());
+            let non_wpr_heap_size = hal.non_wpr_heap_size();
             FbRange(wpr2.start - non_wpr_heap_size..wpr2.start)
         };
 
diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/hal.rs
index 714f0b51cd8f..99363cfb116b 100644
--- a/drivers/gpu/nova-core/fb/hal.rs
+++ b/drivers/gpu/nova-core/fb/hal.rs
@@ -37,7 +37,7 @@ pub(crate) trait FbHal {
     fn pmu_reserved_size(&self) -> u32;
 
     /// Returns the non-WPR heap size for this chipset, in bytes.
-    fn non_wpr_heap_size(&self) -> u32;
+    fn non_wpr_heap_size(&self) -> u64;
 
     /// Returns the FRTS size, in bytes.
     fn frts_size(&self) -> u64;
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index 3cc1caf361c7..3b99028f3828 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -72,7 +72,7 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         super::tu102::non_wpr_heap_size_tu102()
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index 44a2cf8a00f1..a5eeddb8a1ae 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -41,7 +41,7 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         super::tu102::non_wpr_heap_size_tu102()
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 51bd0c0bede6..9a1fd76c179e 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -109,9 +109,9 @@ fn pmu_reserved_size(&self) -> u32 {
         pmu_reserved_size_gb100()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for GB10x (see Open RM: kgspGetNonWprHeapSize, GB100/GB102).
-        u32::SZ_2M
+        u64::SZ_2M
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-core/fb/hal/gb202.rs
index 8ec30afcf701..86b5b5613169 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -69,10 +69,10 @@ fn pmu_reserved_size(&self) -> u32 {
         super::gb100::pmu_reserved_size_gb100()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, GB202+).
         // This size is r570-specific.
-        u32::SZ_2M + u32::SZ_128K
+        u64::SZ_2M + u64::SZ_128K
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/gh100.rs b/drivers/gpu/nova-core/fb/hal/gh100.rs
index d39fe99537ed..3cffc6ef6769 100644
--- a/drivers/gpu/nova-core/fb/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gh100.rs
@@ -61,9 +61,9 @@ fn pmu_reserved_size(&self) -> u32 {
         super::tu102::pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         // Non-WPR heap for Hopper (see Open RM: kgspCalculateFbLayout_GH100).
-        u32::SZ_2M
+        u64::SZ_2M
     }
 
     fn frts_size(&self) -> u64 {
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index f629e8e9d5d5..4d30c005cfb4 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -44,8 +44,8 @@ pub(super) const fn pmu_reserved_size_tu102() -> u32 {
     0
 }
 
-pub(super) const fn non_wpr_heap_size_tu102() -> u32 {
-    u32::SZ_1M
+pub(super) const fn non_wpr_heap_size_tu102() -> u64 {
+    u64::SZ_1M
 }
 
 pub(super) const fn frts_size_tu102() -> u64 {
@@ -75,7 +75,7 @@ fn pmu_reserved_size(&self) -> u32 {
         pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         non_wpr_heap_size_tu102()
     }
 

-- 
2.55.0

