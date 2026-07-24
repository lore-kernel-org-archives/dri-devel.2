Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504E1C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C13510E237;
	Fri, 24 Jul 2026 06:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQlXCYsN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FED610E237
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7J75Cb8Hvh8dTsp3TnDCSG0JIY8Le2MszQteoRJ0w7IoeoxYElXWUANJV5DkW5YlqgRP6sozkhOzdGflSDHjH/IfhdYeFn8SZT9Tw6yttF15u+mknnPOw3jivGnjfxp20l6ZBVlLg1ohEDFyNoLuEI9DL0+pqcxZ3VLJJfpzg/wctUFgW2ecLCfNEnUMLMgfJmpm3qv++aUzi3+/7hWgqZWXo7Ml6W6UyFVjYdFgYdAcoBbiPVed2UDzDl6Ry3g3Ek+KVgjgYrFn4Sg/N5DLSATkr+05kL8Rvzdwqos+d1EOMleD26iL4VJlLWhzPsB82h03xOMpFLTgrhrozIvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGg2T1AA4Q8HK/vz8DrlfR8UdY0xNSyvnFAHwnmS9gI=;
 b=GkKanUPfrLE9TqGv4i3AQNfdYoEXQssDaaZc0MtQ6Z7orBV3mE3OebfJ/r+G87WUSR5iLn127QWub29Oj1g9DI60TwFZ1WoVCRuhJK/k217vCZmu3dSw4nqVBThkMkyb4oM1XdPjq/fdZbFrn7KT8fxEgc3QvTMngV2YNkWcG9FgN2rQ2UQO9a7ZxV/t1ljDdbWr5rHZ8zyi0Imf74LDmrwqxc/klh7QpU+MynJzUV7fwKbZOpI1/4gweo8F1ZT09CMbDMAje1THx2VF9XyfahV5grF7YElMJtRvn8DSLIUjeobUj+AtH9FiEnKNRocHHRYIprqHMwD92Ua9bNpFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGg2T1AA4Q8HK/vz8DrlfR8UdY0xNSyvnFAHwnmS9gI=;
 b=hQlXCYsNoz750ovHVEBduehhke1pVm/8R2SzE+hlt3P9/Lg0lnvhL3s10M0V887/FXip4OnZ0b5eSVjJDDYrluUAIOH0A+a8dPXlwwLbdxOKMa5+uM4TYh/snOgFZZX0A4knuay44d7ylczmMk6q625j7OBYA3h7FRnHYNo3o0VwEK3SCfcfZgakISa+e+taiCOY3JqRNATzTZR2OTunyuCzmjOcqgcbN+7i65/Cz1p1GL9Oqd4nq/5eSKK9Bw3l7GqopuGddNAiz8yzefe7yZmQaQQ6kqjKSizZVafMy2SxW+5CwwQb1riWdTbufY8Dd4x3ndv2ypNX41h8mt7nxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 06:56:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:56:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 24 Jul 2026 15:56:23 +0900
Subject: [PATCH v3 1/5] gpu: nova-core: correct FRTS vidmem offset calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-blackwell-fixes-v3-1-01aa6a54e3fd@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: f998ba13-7653-4b6c-df0e-08dee950b3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|11063799006|10067099003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ap/ZGlc5FMiF1GP+OuCeT6zbOWY+E7BM/2150+euSfnW+L8ttZuIe4ixKvSsX65+dDQ7aQxaz8nEyzY9AxeQkBE7x0K5bHyj61XnXBc1REA8Q50QoSYf81TeZE0mpZH3rjnxGdBUkmnGjQaWEsjlCwxnWid6N75+fV2TTcdanPenIEZ0ZaYpcHBnop8CSvr4Wb4SAIseBr16rXXipmXqMgwuaOFQKDE/6bmGhgLLatMebWCP2XG4yL9Uv/HMNQoq6xQ/qrUdrn2oCpBTt7IEC3v2D0Vp/mFLRDI4UTPJCaFY9qSAChDwfDLSqqVKBafmDo4Q/jKTplEDrClme0Tyrjc/otBqp0JpP6ZGHoYYFWO7StZVpld94vzfS6doDF7daFRO8EwLZZYKJt7Bu4eO3ri3FQ5dpNt/bE/Ec/8ZYqth88XP5HaoM1uq6HSD4Tpz253JJ6hDvbvT/vcqmaSCWSrCiNV7mSzeXIo4JR5ZdD/b90Go9yfxIfVpkYqmwh/YNM1Jtnncy5zwchbyYIuZIagzLYdF7mo0xKE/z7DYNCqAo6puc80hdEU4BF5WH1WrjvOZn3HuBV9qw+5m38PvYgADSv3KqpfZEPRrWrqCKjbxTQkY270nq35P6meWVnrudDdCTsPuIl5bZNcHTyyn2u+ColxQD2tapfcRUuM83bQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRyRUtmY3pZdDFjNHR2bEk1aTV0aXB6Uk9wN0JXY3JLaG1mTDNwZ2pXc00v?=
 =?utf-8?B?SlEyL1g1cG9FK3NKK3ozY2dwOWxEWnRhNXNDOUg1UkFvUGRKZkcvZmwzSGZy?=
 =?utf-8?B?WDEvOGQvS29NQ01KU3BKQlAwWldtbWZmWE83TEh6MTN4bU8rZWNuOCtzbEts?=
 =?utf-8?B?eUJaM0JIVkE2RE50cTN2cEJVVUpGWk90Y3dtNkg0OEhNR1l4NUt5NGgzWVBF?=
 =?utf-8?B?TDJsOEdkTENhR3YyQkdVQUZqTjR6Nk9mUDR6TjR2RExCdGYwYzJYTkdHd1l0?=
 =?utf-8?B?RUQzTEUrRHBudDVoZHdtR29YZ1V4aXRsbkdsQ1hyZldRdHF2WmtLWHZVK2RP?=
 =?utf-8?B?MWQwSG1UWHgyQXpYeGNIeG1JajBpV0lUdWtuZUJPd3FrdmRWUW56SS93ZU01?=
 =?utf-8?B?VzBuZ0ZSZjdzMjBaaGt4NlVyODZqODVOM2U4UkNQYVljanh2TTYxaTF4SHh3?=
 =?utf-8?B?dHYzYlZKelYyTjVTd2FoZVVySkdBQ0NkRmRWV1dla01MTGhOVlo0Y1JITzlU?=
 =?utf-8?B?LzVhNVFDSlNVeXVrVGk1TzI4a0M0NSt0VzNjMUhOVm8zT0FEeGF1Mm44dUgy?=
 =?utf-8?B?NEFmTnFVZFlJM1grSkRFNDJkU0kwSWpUT3JWNktjaWZZODQySWZEaFQrZGgz?=
 =?utf-8?B?cFJBUEF3cW1mcHV4QlBrcVA4ZzBEbVptYU1SU00yZXdpbEwzTS9Tdk4ySmZZ?=
 =?utf-8?B?N0Nzc2pNYURHeGpjVU9LeDgrRE5CMnBCNEtyR3Z4eWFDVjJQaFhQM293N1N5?=
 =?utf-8?B?YU5QS3V1VmVDT29GckpsUElLaEtsV0EzOE1MM0dtWFhjcXlIOUV3bDJ0Tlgx?=
 =?utf-8?B?ek0ydGZ1NXlmemVFSkEyVC9jSW4xWjNYc0Y2SEhDaUdsSXhyY1BHYk05bnYr?=
 =?utf-8?B?STI3R1JRNTVic2tsWSsxU0FIejhvbzVzdGRvS3BWYUxtTXFjNjRseitibGRN?=
 =?utf-8?B?dWROS0xCZDVnditXR2ZZNnQ1SlREdS9aU3dGU2E3UVNNdm95djI2Q2ZLd0tl?=
 =?utf-8?B?R0FENkpaTlB5d1B6ZGVrOVdFaXJxQUZndFNodmZUUjA1RmVJNmpXaUpEZGYx?=
 =?utf-8?B?UGxwUkU0b0Z4MFlUeFczVWdkejhPRTlVK292QXlVdlJQVXBPVkJCbTkrUVZy?=
 =?utf-8?B?QW94d1ZXcDRVb3hzMzMxQ2owbGhDVHBOOTdGZGRaK0poT3M0bUNIYmxiRVo3?=
 =?utf-8?B?dnhXMGZDU090Rk9vcnlBOFg3MStPeTNaK0pJdEpLTHBKSHJRWHN1b1RrR2oy?=
 =?utf-8?B?bDlJeWdhZFVrbjRIWDk2S285TlZiL1F5Qk1qUXVacHRCV1dpb1Jnb0FOT2li?=
 =?utf-8?B?alhUaExwU1Y2SDB1cUF2SWhvUDg5WFdYczludEFra3JkODRTUUYyQjJaemND?=
 =?utf-8?B?U2RnU1NueHF5dFpqcmhtaTYydUkrTlpQcUpDQmlQTm90U1IzTEozWjEvS3F2?=
 =?utf-8?B?bmQ5K0YrL3k4ME1wVTNRQzF1ZG9DMGtEKytpYmd3bTgwTnY0TkZiTmFvVUR2?=
 =?utf-8?B?TnhxMDlLZEZCamJqRlZDMGd0WTE0VmwvYUl3TEFKeUFhRFVrcW1xZ2lDMVJv?=
 =?utf-8?B?RVJod3lSc1I0SEE5cVdrUlVaRkpyODVjVG9UeUNseEs3ZTNBZFgxTDlSOVRk?=
 =?utf-8?B?YW5TTHFqSHA4bkh5UzRBeEkydVFZcGtrKytwMFpFZkVmSVBObHVuYTNzZjB2?=
 =?utf-8?B?V1dERmpPMzVJSGpVZXQraUYzbjdBQTNqMmY0K2VPa2VSbmZNVXZkYk9aSlVp?=
 =?utf-8?B?Vkc4anEzcm02cGM4VlVQU2VObHlJQzRnUHpyc3BGR3czQk5TOVFQNGJNdDlZ?=
 =?utf-8?B?YUQ2TWFZK29mczdSUDJlbDRKb2RMbkFXR24wQTFuNzF0ZGFFa0RlV2xLbHAz?=
 =?utf-8?B?cDBiYnRCVC9CSDFLZDdQaWxsUy9qeXBRSm5mWUlORlgxUDZXNE1xcWUzMGNG?=
 =?utf-8?B?eldLeGRkMXIvREhpZ3IvVkVsdlJUcE1RN1BLZExjejBYUUxsS0dnRHJ4TDZn?=
 =?utf-8?B?bTM4TzJycllnZm5CVFZ1RUQ2cm5UMVVMWUFNbVZmelhmZHJtWGRGQVVleWZC?=
 =?utf-8?B?RUp5VjBNdVluR2wwZGxRVlY1QW5ZWkJBR3VJZWk5bmMxc1g4TjNidFVrbGc2?=
 =?utf-8?B?c21GNkNlMFJLaWMrMkcxalpvNmg0dkp0YVpyYTF6OXFmZHVjQm5WYW9qTmRF?=
 =?utf-8?B?aFEwdm42YjNGalhwZ21iRTB5Y3djMFF6amdJRVBYdDFIRHdpY2xKTHpoRnZV?=
 =?utf-8?B?YWdUbkdoTzMwblNLVXNZcTJDVHNNU1lYU1pPUXNtODlydE1wQWpXYnVLRDdM?=
 =?utf-8?B?L0FNdVBQaHp4bU5vYmY2cEY5MDY0Uk51WWJLZFVxbEVKS0tsb1E2UGxYNnVm?=
 =?utf-8?Q?ghmbF5MnhwqBvPCH4AZZ9uX/lF3RKhrqscrqf6q+6HdVR?=
X-MS-Exchange-AntiSpam-MessageData-1: K0abTUxcdDI+7g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f998ba13-7653-4b6c-df0e-08dee950b3bc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:56:35.6489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9PBDAZcqLwNeyyCkinnUrI+lx9A4FedtPWggVD8oWir+c0e9iHFsHe7oDNaMn51p6VD0zPWWqua8tiypScloQ==
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

Currently, the frts vidmem offset is calculated based on the non-wpr
heap size and pmu reservation size, but this is not right. The layout
actually looks like this:

| non-wpr heap | WPR2 .. FRTS | PMU reserved | ... | VGA workspace |

It's just by coincidence + generous alignment that the values happened
to match. Instead, define a per-architecture reserved size at the end of
the framebuffer and use this plus the PMU reserved size to calculate the
frts vidmem offset.

Fixes: d317e4585fa3 ("gpu: nova-core: Hopper/Blackwell: add FSP Chain of Trust boot")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb/hal/gb100.rs  |  1 +
 drivers/gpu/nova-core/fb/hal/gb202.rs  |  1 +
 drivers/gpu/nova-core/fsp.rs           | 27 +++++++++++++++++++--------
 drivers/gpu/nova-core/fsp/hal.rs       |  4 ++++
 drivers/gpu/nova-core/fsp/hal/gb100.rs |  6 ++++++
 drivers/gpu/nova-core/fsp/hal/gb202.rs |  9 ++++++++-
 drivers/gpu/nova-core/fsp/hal/gh100.rs |  9 ++++++++-
 7 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index 6e0eba101ca1..51bd0c0bede6 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -78,6 +78,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     );
 }
 
+// This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
     usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
     )
diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-core/fb/hal/gb202.rs
index b78e0970f66d..8ec30afcf701 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -71,6 +71,7 @@ fn pmu_reserved_size(&self) -> u32 {
 
     fn non_wpr_heap_size(&self) -> u32 {
         // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, GB202+).
+        // This size is r570-specific.
         u32::SZ_2M + u32::SZ_128K
     }
 
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 1475485bded3..30e53df81aa2 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -134,20 +134,31 @@ struct FspCotMessage {
 }
 
 impl FspCotMessage {
+    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. It is measured from the end
+    /// of the framebuffer.
+    fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_layout: &FbLayout) -> Result<u64> {
+        let mut offset = u64::from(hal.fb_end_reserved_size());
+
+        if fb_layout.pmu_reserved_size != 0 {
+            offset = (offset + u64::from(fb_layout.pmu_reserved_size))
+                // The 2 MiB alignment is r570-specific.
+                .align_up(Alignment::new::<SZ_2M>())
+                .ok_or(EINVAL)?;
+        }
+
+        Ok(offset)
+    }
+
     /// Returns an in-place initializer for [`FspCotMessage`].
     fn new<'a>(
         fb_layout: &FbLayout,
         fsp_fw: &'a FspFirmware,
         args: &'a FmcBootArgs<'_>,
     ) -> Result<impl Init<Self> + 'a> {
-        // frts_vidmem_offset is measured from the end of FB, so FRTS sits at
-        // (end of FB) - frts_vidmem_offset.
-        let frts_vidmem_offset = if !args.resume {
-            let frts_reserved_size = fb_layout.heap.len() + u64::from(fb_layout.pmu_reserved_size);
+        let hal = hal::fsp_hal(args.chipset).ok_or(ENOTSUPP)?;
 
-            frts_reserved_size
-                .align_up(Alignment::new::<SZ_2M>())
-                .ok_or(EINVAL)?
+        let frts_vidmem_offset = if !args.resume {
+            Self::frts_vidmem_offset(hal, fb_layout)?
         } else {
             0
         };
@@ -158,7 +169,7 @@ fn new<'a>(
             0
         };
 
-        let version = hal::fsp_hal(args.chipset).ok_or(ENOTSUPP)?.cot_version();
+        let version = hal.cot_version();
         let size = num::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
 
         Ok(init!(Self {
diff --git a/drivers/gpu/nova-core/fsp/hal.rs b/drivers/gpu/nova-core/fsp/hal.rs
index b6f2624bb13d..aa2f8bda59d2 100644
--- a/drivers/gpu/nova-core/fsp/hal.rs
+++ b/drivers/gpu/nova-core/fsp/hal.rs
@@ -19,6 +19,10 @@ pub(super) trait FspHal {
 
     /// Returns the FSP Chain of Trust protocol version this chipset advertises.
     fn cot_version(&self) -> u16;
+
+    // TODO: consider moving this into the TLV firmware metadata when ready
+    /// Returns the size reserved at the end of the framebuffer, in bytes.
+    fn fb_end_reserved_size(&self) -> u32;
 }
 
 /// Returns the FSP HAL, or `None` if the architecture doesn't support FSP.
diff --git a/drivers/gpu/nova-core/fsp/hal/gb100.rs b/drivers/gpu/nova-core/fsp/hal/gb100.rs
index 42f5ecfc6400..f601b5d7bf61 100644
--- a/drivers/gpu/nova-core/fsp/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gb100.rs
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+use kernel::sizes::SizeConstants;
+
 use crate::{
     driver::Bar0,
     fsp::hal::FspHal, //
@@ -17,6 +19,10 @@ fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32 {
     fn cot_version(&self) -> u16 {
         2
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        u32::SZ_2M + u32::SZ_128K
+    }
 }
 
 const GB100: Gb100 = Gb100;
diff --git a/drivers/gpu/nova-core/fsp/hal/gb202.rs b/drivers/gpu/nova-core/fsp/hal/gb202.rs
index 1091b169a645..b022d298195a 100644
--- a/drivers/gpu/nova-core/fsp/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gb202.rs
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-use kernel::io::Io;
+use kernel::{
+    io::Io,
+    sizes::SizeConstants, //
+};
 
 use crate::{
     driver::Bar0,
@@ -21,6 +24,10 @@ fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32 {
     fn cot_version(&self) -> u16 {
         2
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        u32::SZ_2M + u32::SZ_128K
+    }
 }
 
 const GB202: Gb202 = Gb202;
diff --git a/drivers/gpu/nova-core/fsp/hal/gh100.rs b/drivers/gpu/nova-core/fsp/hal/gh100.rs
index 291acaf2845a..002f7ccdca3e 100644
--- a/drivers/gpu/nova-core/fsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gh100.rs
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-use kernel::io::Io;
+use kernel::{
+    io::Io,
+    sizes::SizeConstants, //
+};
 
 use crate::{
     driver::Bar0,
@@ -26,6 +29,10 @@ fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32 {
     fn cot_version(&self) -> u16 {
         1
     }
+
+    fn fb_end_reserved_size(&self) -> u32 {
+        u32::SZ_2M
+    }
 }
 
 const GH100: Gh100 = Gh100;

-- 
2.55.0

