Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAD2C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1BC10F0C5;
	Wed,  2 Sep 2026 09:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jgAKT0Gq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26DB10F0C5
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVIoZQEppQY9OfAaf/mmnII+nxI8oqOnJevoSKEFogn9/JIzTYU713TFIMbMat0T0Xm/rKfO8t/FOAAZR2Daq6e29zf6TGi0QxQK1/pNEBh0XA9tKjBmQuxWgquD1wMsOob7FUT07xYwokaKDONpSyP/rUUfqS6F6hqNGX3uA8gJBu1ZBEQbZNGW3zFILzGPAsthFqaD3J1Q2jNTHegIcu97y5wNZmJvppTucIGd3khamDY7/YlrKkepvzLA6XB8VbT+qBIql7f2ectCdhEJb3HjnQfTud4MYpLymNle4R9akFGxg/P/f0QlsssLDJEoPcuOaWhZm5VCRqhcK0gIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c13GYpTKUIMSxS2r4kuOiGCqk1anXCVLCxVqtXKNQAw=;
 b=h594ulUiMPhIrubcS+gpDRlBSk4tPS7dL/yD437Xi/nbFmsDJkNAp40gOev3bf6ArHOXZ+xArDRXr/HAS8vhGyZfb78wthXC4EEwbMaGXaq3WbrWPfNuGH2GSDwyYLfcvL9wOeoRlTp0omDzhLPdzFOCXfbs0nMQd4rZeM9i89uj8G19s9jURWjP1y0znVkpPV2lJJxTtVTTK2lVYiSCSDRdoPcj1g7TARRHTCDwCKAjJYmWVR4aXzgtIof8rFJFwLoWbTsAM4GM7QQp7prIUtFUsJF7PXQytlkdTStHSrvjxHIitRZA6b7B5mjN/VJpNfROF+AQKEF61fQVWQNT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c13GYpTKUIMSxS2r4kuOiGCqk1anXCVLCxVqtXKNQAw=;
 b=jgAKT0Gq17tE6DpMiS3Toz7hEZB72kfNUuOlmGkNtAvgx+oi5i1BMFmFW4s/3KjiZwdApXxtHt2SlYNePpWAJ8d1jOAi6ApcM7tkejHoWXHR4G8SOb/syPmj/S3QFXFMIbMEUNxxw2Qgw3XpCj5k2G1t1bnW9iluk4b13Sqsq+FwIDAqXXk33xoqprDAa3RUiPIvndTtkSBLfJBZMVlxQrYxk4iBcibkHFvlwq6/YxSWRMONdAYKuCexXKqwQL3UcOEN6KTSFelIJKj2QxGsxWRxdNOUWYZdjSk6Iz0ESY052F7GeMmijYyGxjtYG+U2uy9TSx3zslTNhYNYsFwBmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Wed, 2 Sep 2026 09:17:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 09:17:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 02 Sep 2026 18:16:42 +0900
Subject: [PATCH v3 3/3] gpu: nova-core: use cv! for constant casts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-cv-v3-3-0f90659e711d@nvidia.com>
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
In-Reply-To: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da14ee8-4338-48aa-3cdf-08df08d2f87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|921020|6133799003|11063799006|10067099003|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: MtI0ssmKeOfOnvV6hbUlNDHI324pzuedbIxKx2iWA1orm+wsI2lF+FCS0Wi6dArjmOm93DA7CAzgNJuNZOg51kRM0QnXokd7XAWg2ANOFUOfynunp2h4POv/EX53ZqI00hEjvwAQEBHOw5g8OqqVSDpbY4/NkkJRRgxlYrWAGf4NLbPzKbDHDWbLP4OA3UBDuVWqeUdsGR589WBCg9j6sE5b+l1i+Mqw1ZZNZSl3sx+6GqmgDXxNqN9pM7GIhxGhATSgoHJOvioFw2vDkZwn9cChyRZp7rPG7hBOuk7PwChufBBzH6vKl5i0BnPYuDqfOASxih1v1qm+3M13pnf9V70bXgHS9pAwataES1n7Z5ky5zFfrPstU7pSE9D2TTyObwxe1OCK3jDqCOhqMnL8Mt45Z/x2j/aRbmHHs6MiyPWQtt7lQzQuySaERP8Bvm5W+9LL0XSwKMa/2RZ1Thy7dl4uXNoYo7C7CsT0Yxxy+nuu8wrTElNVnZa8FRoJ3Wzvg9RGDkF3SQhux38P8cRi2Gi71HdB/Ng7BMzJauDW0bE6MO84CK9x1/0xX4qSM7uj4weo7hE0+yFBz4uTgP4ivjCHH2TFgNnxoPdiF5Lp4Ah+BRpuSbPGSvl+GOW6SLZR6V3XL24K3syDGinV8WG1J6W1n/3b8uxMHQl2sUfy2Th0kNCe8zXQ0bN+naRAd0rjoh1G1N5BmwlUOYt5JqcgfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(921020)(6133799003)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0RkTHo5eitLMEUvejRudVZ5VTlrL3F4NkRxOWlTSmcwUElPYU5MZ0RVS2hV?=
 =?utf-8?B?b0pScitreTliSFdMVmRncUNQYWhtamx0ZGMwdThaeUU0U1VjbHp0ZzUxeUJM?=
 =?utf-8?B?QVdFZlpBc01xZDlCck93bHQ5UGZPZEJzVzZmdWxvRlVUMHM5aTYyUHZTeDZJ?=
 =?utf-8?B?QUQzS1Y4TlBZVzVUd2FHbHBuS1MwSVl2N3ZBWCtsQ2NadGw4OHRVN2lSRFls?=
 =?utf-8?B?VHhQd0NhS2UyS2Fya1pRUGgyT3BpUThVbzdLaXh0aSsrMHVMVnY1NTZUckpD?=
 =?utf-8?B?dDZlbUVoL0Q3YnAzaG94djVuYldGOG1nbGtIQUZTUnpBZGdmZlhIVlhPWEQ5?=
 =?utf-8?B?MmYyVzRFREVJNjNTRG80aE9VZmF5ZlJQamJDbWp2akdxQ3RZNW9qVTRHSlhq?=
 =?utf-8?B?enJlNThwczY2K0NhV2RxL0xvdHYzdXdCRVR1V25kdXBpaldZYmtFcVJFUjFZ?=
 =?utf-8?B?SjlRbm8rOUphekxoVDViTiswYlcyVjNDclZRZXY2d1AzM0dkR0NKMkwwVnhy?=
 =?utf-8?B?TnQ4K0hNSVA5cWhNcWdTekxVOXQ4eG4reGpaVkRXZ29SZmVqZFFSb1lTVEhP?=
 =?utf-8?B?WXFOdkpUU0hIOGZ6TnBlbWdQSzVxR2hwc01NUlRjYytIa3B4NFE3R05BQ0Ry?=
 =?utf-8?B?OG90anFVc3hUeExnMEMzTWduY2lqeTJRaUhzbTR0YVc4QkNLWTIvWks5MWp3?=
 =?utf-8?B?YzlBTXdTemZ4ajJwWGdnVE80N1FJVStqaEpydmpwQ0M1S2lseTdKVDZxRHNV?=
 =?utf-8?B?VFltRXhYK1MyRjg4Y043dWZieEovVE9vOWhzU1V5ZVVyUWVKc0VIQlcrYUt6?=
 =?utf-8?B?RHN1Y3F3d3pZZVFFd3BnSUx1WEY3NklZZmZUTWdRaXVqTDBrc2s4YlBhZmFy?=
 =?utf-8?B?blVTN3pLWnpacWxQZlZIUDV3c0FhZ1J2Z3VhbFFVaXZYMGxMTjQ1SXZUU0tZ?=
 =?utf-8?B?ZEs3cDZLWVBsbHMwaG5nL0xvbWZVZWk4SWZrWW56SG4yVmpwRWhscTdOK3ky?=
 =?utf-8?B?MHpVTHFoQnNCNEdjeElpaFBjK1BGNTloMzI4ODE4aGJGeFM4MTEwSXBlSW5a?=
 =?utf-8?B?M0h0UGxWU3dGaDZhU1gwWnJFOGVhOXZOeFVrVENkR3AwbzBwdDNvaHhoeDlO?=
 =?utf-8?B?c1lobEgvWmovcGsxUE1nTFRpbEM4Q2d6ZnpSOW80a0xNYitnSWE2cm5iN3Ro?=
 =?utf-8?B?YWRXS1hLWlBPWmVrd2d0TDVJeTZFYTI3amJMelNkVHk2VmdxeXovdWJRYkt5?=
 =?utf-8?B?dEJyOFJFUlVFZE9CVWJXZ0dPcDhtbHVBWENEQlJHZ09kVzR0MHZNeDJiZVI5?=
 =?utf-8?B?S293UEhkdld2YW5YVWkxenArNkhvWE04TEZaaGUxcitkNVkvWDd3c1pGZWhH?=
 =?utf-8?B?ZUJ5Vm5WVDBvZXMyeFU3VVdmU245dFlKZ0Eyc3NDZnhwWlZocTBtOU9uZjQr?=
 =?utf-8?B?amJLaTExOWpmNG44ejd0Z21rNEMxUXVuS1NMTEQ3V1ZaTkRnMkNqajVORWF4?=
 =?utf-8?B?eFpGem1kakNuN1g4N3pVbE5tQ0svNGNQcExXVXJtYkxUQnFNNW5PRCtPSldr?=
 =?utf-8?B?TDhvbFl0RzIxNmNaRlNST3hGTWpJTm5RMVFUUXc5aGZPZHgyMnJuMnhnbnpk?=
 =?utf-8?B?Z0N3bGNtRDFqd1d2K2FLRm5IczF2WkRQRnRVWGUzVCtISk1ZSHcvNHRQTjVL?=
 =?utf-8?B?NDI1aVBua3pyVWNZTFgzODVvMytKZ0lVWldtT1g0WmZaSHFhVzJJUFBYMFdT?=
 =?utf-8?B?QmxJUzJacW9CK084NElFYVdMQnFJRkl3eGtaN2pzTy82am1aWDFuK0gvMjdE?=
 =?utf-8?B?eXB1bk1vMWQ4V2oycUg2aUxQOGlwdEZqMmt3cUtHTXZmc2wwOEZFSGlmZVJ1?=
 =?utf-8?B?Y2kvYXpOU05pQ3lMMnFvTVVPaTM5RlpSSmIxemRHYmJUbzc5MCtEclhXdEVr?=
 =?utf-8?B?dWdLN3lBcW1CUFF6MUVzMUwxWGY2c3ZERTBiOWprY29PblpsSDlndS8vc2ph?=
 =?utf-8?B?aGFWdy9YalNwaXpvOXhITXZhYmoyMk5NKzFNVjlSNTJKMmF6NDJpanZuWlNH?=
 =?utf-8?B?NGNIOFBId1dmLzRwZWZIalgwSGliNkJjdXVQNmo3bkUwSzJ1Uktwd3NjdDdU?=
 =?utf-8?B?TkpERHhLd3FZY2Q1cWo2N2RBZHJDNFJMY1J3b29XaWpSWjI5dzBGYlJIK2wy?=
 =?utf-8?B?eENuM1JQeEt1b2ZFdzJuRGZXQk1kYnpYY2JmQm9PdTdINHdwWkNIRG42ZTJ2?=
 =?utf-8?B?WVVoVzduVE52SlNzcnZxQWV0Vkx3NUUxaisvRGhyTlRpYjMxelBGd3VRWlIz?=
 =?utf-8?B?dWg5N0NueXlpMmxmRm92b1NQNW5MRnF2end2WCszUk1GRlJlbDNQVzB4NG1M?=
 =?utf-8?Q?8AvFGhVNOHXkkC7IzwGRAJYK4GqF1ZHAPfcuqAF3RTnNC?=
X-MS-Exchange-AntiSpam-MessageData-1: yJl0VgoCYAOEnQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da14ee8-4338-48aa-3cdf-08df08d2f87d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:17:11.7588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q19z+sPjHZoEflzU2wiVxcKbI0vCfLEH0mdMF9kUCXZ6DHkIgni60YCvwpAPeiJV/SiDM4Z1CeskjShGGHTiew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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

The new `cv!` macro allows safe casting of constant expressions in a
const context. Update code in nova-core to use it.

Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    |  9 ++--
 drivers/gpu/nova-core/fb/hal/gb100.rs              |  4 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  7 +--
 drivers/gpu/nova-core/fsp.rs                       |  3 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  6 +--
 drivers/gpu/nova-core/gsp/fw.rs                    | 38 +++++++--------
 drivers/gpu/nova-core/gsp/fw/commands.rs           |  2 +-
 drivers/gpu/nova-core/num.rs                       | 55 +---------------------
 8 files changed, 28 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 65cb12d26e2b..0e0383331f42 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -29,11 +29,8 @@
     driver::Bar0,
     falcon::hal::LoadMethod,
     gpu::Chipset,
-    num::{
-        self,
-        FromSafeCast, //
-    },
-    regs,
+    num::FromSafeCast,
+    regs, //
 };
 
 pub(crate) mod fsp;
@@ -510,7 +507,7 @@ fn dma_wr(
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
     ) -> Result {
-        const DMA_LEN: u32 = num::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+        const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);
 
         // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
         // need to perform.
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index d9e4d62ae632..0bf00d381607 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -26,7 +26,6 @@
         hal::FbHal,
         regs, //
     },
-    num::usize_into_u32,
 };
 
 struct Gb100;
@@ -82,8 +81,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
 
 // This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
-    usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
-    )
+    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap())
 }
 
 impl FbHal for Gb100 {
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index ec4d92317a93..b51aca619a8c 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -14,10 +14,7 @@
     dma::Coherent,
     io::{register::WithBase, Io},
     prelude::*,
-    ptr::{
-        Alignable,
-        Alignment, //
-    },
+    ptr::Alignable,
     sizes,
     transmute::AsBytes,
 };
@@ -134,7 +131,7 @@ pub(crate) fn new(
             let code_size = usize::from_safe_cast(tlv.get_u32(b"CDSZ")?);
             let code = blob.get(..code_size).ok_or(EINVAL)?;
             let aligned_code_size = code_size
-                .align_up(Alignment::new::<{ falcon::MEM_BLOCK_ALIGNMENT }>())
+                .align_up(cv!(falcon::MEM_BLOCK_ALIGNMENT))
                 .ok_or(EINVAL)?;
 
             let mut ucode = KVec::with_capacity(aligned_code_size, GFP_KERNEL)?;
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index ab685fb4168f..e15d0af95499 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -47,7 +47,6 @@
         NvdmHeader,
         NvdmType, //
     },
-    num,
     regs, //
 };
 
@@ -285,7 +284,7 @@ fn new<'a>(
         };
 
         let version = hal.cot_version();
-        let size = num::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
+        let size = cv!(core::mem::size_of::<NvdmPayloadCot>() => u16);
 
         Ok(init!(Self {
             header: FspMessageHeader::new(NvdmType::Cot),
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 6da728201281..bf8ade55b304 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -162,7 +162,7 @@ fn read(
 #[repr(C, align(0x1000))]
 #[derive(Debug)]
 struct MsgqData {
-    data: [[u8; GSP_PAGE_SIZE]; num::u32_as_usize(MSGQ_NUM_PAGES)],
+    data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],
 }
 
 // Annoyingly we are forced to use a literal to specify the alignment of
@@ -235,8 +235,8 @@ unsafe impl FromBytes for GspMem {}
 impl DmaGspMem {
     /// Allocate a new instance and map it for `dev`.
     fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
-        const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
-        const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
+        const MSGQ_SIZE: u32 = cv!(size_of::<Msgq>());
+        const RX_HDR_OFF: u32 = cv!(mem::offset_of!(Msgq, rx));
 
         let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
         gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 05f54fee6186..33ec3d983c08 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -57,7 +57,7 @@
 
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
-    num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
+    cv!(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
 
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
@@ -110,20 +110,18 @@ pub(crate) struct LibosParams {
 impl LibosParams {
     /// Version 2 of the GSP LIBOS (Turing and GA100)
     const LIBOS2: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
-        allowed_heap_size: num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB)
+        carveout_size: cv!(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
+        allowed_heap_size: cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB => u64)
             * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB) * u64::SZ_1M,
+            ..cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB => u64) * u64::SZ_1M,
     };
 
     /// Version 3 of the GSP LIBOS (GA102+)
     const LIBOS3: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
-        allowed_heap_size: num::u32_as_u64(
-            bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB,
-        ) * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB)
-                * u64::SZ_1M,
+        carveout_size: cv!(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
+        allowed_heap_size: cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB => u64)
+            * u64::SZ_1M
+            ..cv!(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB => u64) * u64::SZ_1M,
     };
 
     /// Returns the libos parameters corresponding to `chipset`.
@@ -682,12 +680,8 @@ fn id8(name: &str) -> u64 {
             id8: id8(name),
             pa: obj.dma_address(),
             size: num::usize_as_u64(obj.size()),
-            kind: num::u32_into_u8::<
-                { bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS },
-            >(),
-            loc: num::u32_into_u8::<
-                { bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM },
-            >(),
+            kind: cv!(bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS),
+            loc: cv!(bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM),
             ..Zeroable::init_zeroed()
         });
 
@@ -715,12 +709,12 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
         Self(bindings::msgqTxHeader {
             version: 0,
             size: msgq_size,
-            msgSize: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            msgSize: cv!(GSP_PAGE_SIZE),
             msgCount: msg_count,
             writePtr: 0,
             flags: 1,
             rxHdrOff: rx_hdr_offset,
-            entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            entryOff: cv!(GSP_PAGE_SIZE),
         })
     }
 
@@ -947,9 +941,9 @@ impl MessageQueueInitArguments {
     fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_addr,
-            pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
-            cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
-            statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),
+            pageTableEntryCount: cv!(Cmdq::NUM_PTES),
+            cmdQueueOffset: u64::from_safe_cast(Cmdq::CMDQ_OFFSET),
+            statQueueOffset: u64::from_safe_cast(Cmdq::STATQ_OFFSET),
             ..Zeroable::init_zeroed()
         })
     }
@@ -969,7 +963,7 @@ impl GspAcrBootGspRmParams {
     fn new(target: GspDmaTarget, wpr_meta_addr: u64) -> impl Init<Self> {
         let params = init!(Self {
             target: target as u32,
-            gspRmDescSize: num::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
+            gspRmDescSize: cv!(size_of::<GspFwWprMeta>()),
             gspRmDescOffset: wpr_meta_addr,
             bIsGspRmBoot: 1,
             wprCarveoutOffset: 0,
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..384eccf3c44a 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -82,7 +82,7 @@ pub(crate) fn new(offset: u32, value: u32) -> Self {
 
                 // We only support DWORD types for now. Support for other types
                 // will come later if required.
-                type_: bindings::REGISTRY_TABLE_ENTRY_TYPE_DWORD as u8,
+                type_: cv!(bindings::REGISTRY_TABLE_ENTRY_TYPE_DWORD),
                 __bindgen_padding_0: Default::default(),
                 data: value,
                 length: 0,
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6eb174d136ab..2e5c9937b3a6 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -96,8 +96,7 @@ pub(crate) const fn [<$from _as_ $into>](value: $from) -> $into {
 ///
 /// Prefer this over the `as` keyword to ensure no lossy casts are performed.
 ///
-/// If you need to perform a conversion in `const` context, use [`u64_as_usize`], [`u32_as_usize`],
-/// [`usize_as_u64`], etc.
+/// If you need to perform a conversion in `const` context, use [`cv!`](kernel::num::cv).
 ///
 /// # Examples
 ///
@@ -164,58 +163,6 @@ fn into_safe_cast(self) -> T {
     }
 }
 
-/// Implements lossless conversion of a constant from a larger type into a smaller one.
-macro_rules! impl_const_into {
-    ($from:ty => { $($into:ty),* }) => {
-        $(
-        paste! {
-            #[doc = ::core::concat!(
-                "Performs a build-time safe conversion of a [`",
-                ::core::stringify!($from),
-                "`] constant value into a [`",
-                ::core::stringify!($into),
-                "`].")]
-            ///
-            /// This checks at compile-time that the conversion is lossless, and triggers a build
-            /// error if it isn't.
-            ///
-            /// # Examples
-            ///
-            /// ```
-            /// use crate::num;
-            ///
-            /// // Succeeds because the value of the source fits into the destination's type.
-            #[doc = ::core::concat!(
-                "assert_eq!(num::",
-                ::core::stringify!($from),
-                "_into_",
-                ::core::stringify!($into),
-                "::<1",
-                ::core::stringify!($from),
-                ">(), 1",
-                ::core::stringify!($into),
-                ");")]
-            /// ```
-            #[allow(unused)]
-            pub(crate) const fn [<$from _into_ $into>]<const N: $from>() -> $into {
-                // Make sure that the target type is smaller than the source one.
-                static_assert!($from::BITS >= $into::BITS);
-                // CAST: we statically enforced above that `$from` is larger than `$into`, so the
-                // `as` conversion will be lossless.
-                build_assert!(N >= $into::MIN as $from && N <= $into::MAX as $from);
-
-                N as $into
-            }
-        }
-        )*
-    };
-}
-
-impl_const_into!(usize => { u8, u16, u32 });
-impl_const_into!(u64 => { u8, u16, u32 });
-impl_const_into!(u32 => { u8, u16 });
-impl_const_into!(u16 => { u8 });
-
 /// Creates an enum type associated to a [`Bounded`](kernel::num::Bounded), with a [`From`]
 /// conversion to the associated `Bounded` and either a [`TryFrom`] or `From` conversion from the
 /// associated `Bounded`.

-- 
2.55.0

