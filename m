Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5DAC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9118810E100;
	Tue,  4 Aug 2026 05:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UKMyR7ze";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A34610E100
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fK4Ux4DzPHm0ZG8kLBuDotkUt1J1mk7HoAFEo4toH+lMgMR25xduyz1hB9TJI0VefFl5AOSFAQK48tuX127CbOakHXzmGC3XKqNVcksK+K3wkwSqMjctJwVa0e5Ry/Pr/mjImdR3IfSi2Ejv4+S3QrZRuBu9Vdsepj6P1qObMVz3SToUm/bbiK2DR23KQS+syHiASwx7eU6eoS+lUUPmx9Qb1Jx+PyDSCYAMoUR2buYmIJ1mxHXsbxWWURbYn3RP3LG7U3SV6oqIQXrVKTgl3NAJo/VFwfB4IRyEnUyjQVrU1HxlnhypdS0tlGNDv1BcbHoWQTjtdOcMSZCxRNCyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/Ze0iPGExXsOdIkDGiv1HrCQAnqe8RkGSmlxcmltCo=;
 b=dy+veyuTwaAcsMWH3i5e9utZNU+5IVjkOyzZfjlzUv6CCrYyeXuDWlcod1mn+MSkN1Nf7KgFEzdzXs6kta3uQRfIPmiYeUTsk4JkWiG1LYk2+pmKwrj5ukBKBVdQs9h1pBJ5TTMWLy7N9SbgNXvu8oyF+K8oZDWwwUWsLMF2tpxCN1MGdfUKZEN38kw5jq1h+Xe5FSH3nGbtUeOwK0nkbfSCW/nmq+DmHTM1yFrQV7vFFSD32Q1xPfpwewFOPVu7qYdrZ3c5XUlzzpOPPA1c5tCSg1NJvWhKnNeMbmo+97l8hDIsHaIuMyQBkyACE6juMqn2DyCM5KdoKjS2Gww7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/Ze0iPGExXsOdIkDGiv1HrCQAnqe8RkGSmlxcmltCo=;
 b=UKMyR7ze4Zt1+vIB4jkytVpc2q1DM4a9mB9cft2/mjb2WoefHEHXxXyE8VoFjarmg4tlvbCoZ2GvP4cg18Qk9Cidlp3XzhWyQO5KsMU/jhbGwmczdk46FIZo0EZbFc5GzZMhSJT1FBhBZRcEJ5W9gauSe1o0U4F6Z7bwYnrvqVCDvukbWuiDoverxd/qLvNh7q2KbXn/zb6Hlydv3OXMM5ZIEIittWBEfAjcYmwWxyC+3aWSg72fMNqOZl2NKM8OZtcdnMzOpJrjyJW8iKNfqn1e1p2U4Equ3eT2jFh1NGiyvqeEd3yu4OVKhUmNjfXeANwCH6D5gEwt5hpN9/NXAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 05:44:36 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 05:44:36 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 04 Aug 2026 14:41:12 +0900
Subject: [PATCH v4 1/5] gpu: nova-core: correct FRTS vidmem offset calculation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-blackwell-fixes-v4-1-ac858b6a1935@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 512cf7a2-9a75-4789-97d8-08def1eb77b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 8/EdR/AGUv22xBj+PtLxKWsck+O/StZQKoXdOuVriyupmzDFXpuLVyS6nq3DqFvj5LHaiSgGyl/4Mh+9QUBppanSCAyCf5jMn9mU1gUwXX/3hU/uS9DCuzmJOV3a1r5Wsy3Nn8fDk77do70FVp4RVX9w6FWzxJ2rGFzJi1zAWL3Fhs2nfJZYHcdVYvo0bQf5dIazwvB7CGygxZ1NZcepmdobaNSH9ZnTCQk6pO1R7qf7lXxmaYQjwLoOPlc1NeCuEnbejPlXJy3RcOlA6S3E/InNlenvk2D7T6wYiFw+LPGgUQvRoo7JAjkenatfoTGUuiQyi+XzcIDQSqSDXHAahY963W36Cy/KSQFeyYk/eu/vIDP+hjsucGsO5xKaHn7M4dtLdqRZ+wpj6unzUyIYkH19nEOv9hbwDwRTSBOsS1sfHbd7gEmOwfqtwXUTZG+6Y8kH7eHX1iCxgL6DunFvTrCJ21V1Vtjkg1MaCiXNeL+dO+4BSat5q/jkvjdutQ759CejxFWHz2A5rLp9TBmdAHJlsVv51ufANts6eWntx6vhSs3UtY5iSaAONs1jqJ8EoNyynyFjAOYW9NCHY8l/83eWXaE2TcjzNpozgcfGrcG764mWhuC63Kw5vMjMOGCJTK/NNhWnDK+uzR9itcqOOmYXcXBNyUbRAkGtWszxlII=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkRnL01RY25TOC8rY0FFdDJFdjFETWxMa3Y3VDF2ejB4OWxWSFN2QkpvdUU2?=
 =?utf-8?B?c2VJOHFTejNtdTBtSVNiN3NhdjJsLzNIUlJwbjh6VEtYK1BtakI4MzZDaWFJ?=
 =?utf-8?B?NGhqc2ppSkkvZjJ0S0QweTRZcE4yKzYyQ3pQNm9wQUgrY2k1YjcyUm9BdUZh?=
 =?utf-8?B?OE1DRk1KMWx1ZWhVcGhIenN6V3JJQnR4N1BrdTB4WTJJVUVWY0E0eGt1bDND?=
 =?utf-8?B?TmxLSlU3b3FRQWl5bXlGc2NmUFNvMzNrV3lHZlVzbHo0Y3hsdlQ5SVpyMWpt?=
 =?utf-8?B?a1dMZTV6d3NzczFvejZSTHc0alNhL2hteHpYNThIMElmL2JzZ1lkcjB2N1N6?=
 =?utf-8?B?YTJzY0VKQTJmUHhYU1M2czQwY2hOWS9aeTdSQi9JeXBxUnlWT1hWZ29FZEdV?=
 =?utf-8?B?NS9kMlUyQWpNa2NyaVdtbWx6L0tJUzQ3cVdYa3dBZm5JODYxU2V3WDJ0UVBG?=
 =?utf-8?B?Nm0yRUZtK210VjdoZjJyRllDOXoxemJWWHgvbEd3TS9HaUprNUwxaFdlV2tZ?=
 =?utf-8?B?bFljUEp6YmhsNTd0Z0ozZm5MWklZOVRSUE1BNk1sZUs4Wmh2K2tva1JKbFMr?=
 =?utf-8?B?OWpyVjNpK3Q3YStaK3lJZjZEeEQwcFhtMEdYcUEvWUFpcGZUMDB4eEljZ3pv?=
 =?utf-8?B?aG01R0g5VjNjWW50TEN5cWdna3AyZVNDRDUzL29HazlSZXFDQ3F5c0FZS2hU?=
 =?utf-8?B?cXA3ajZGUkZCS0ZlUndwSFoxbXo1VSs0QXd5ekI2UWdkaFI3Tm95ZUY4a1ps?=
 =?utf-8?B?RGJBRDhaOGl4UWJoT3QyeGxmdnFZTlJiajJSMzZ4QmI0YVZLUXBKMkI5WHhN?=
 =?utf-8?B?MWQ5RlQ0RWVualhsRmwrVkhlakpvOFBDbVJrTDkyWHNzWlNic0R3bk9VR3cv?=
 =?utf-8?B?Y3IzRTU3NWRWRFI4MUFvckNwVFFjQTlIR2laVnBNWDRUbnpVai8yL3FFK1Y2?=
 =?utf-8?B?Tk9SOHg2bFowRFJkVjg3a2pDWldaQ3JvdmJiK2Z6L0xxc3hJZi9LSG5Jb3Yw?=
 =?utf-8?B?Tm9SL1BsTkpYWXBkT3J5OWpuUmtRY1U1SzlnU0JLUHFlN0YvMGNrR1JTT2pY?=
 =?utf-8?B?UEVmc3FBNGdvT2h3UmVsUmMySzducy9zMXVsb04xcmx2RkxzRk04Vnc2a1B2?=
 =?utf-8?B?aWFPWkplUDNBZmVxTFFxcVRlQ0ZMK3YwZE9HeGNGRE9BWGU2TmNiUUpmbjJS?=
 =?utf-8?B?Y2c1MWVNTmRFcmFGQ09Nd1QzMkZQNWxEZ0dVa01CWEpUUlNua0lJbmZUeGt6?=
 =?utf-8?B?eXJiKzNOU1kwM09VZU1YMFZlU2l0NFNydmVMaElFN3VkY1lINmF6bW5jTWZX?=
 =?utf-8?B?UWgvOVNDU09YR0hXUVdkQlp6Um9WYXMvQkRlOWxMbklZMmhscmpLbVlNdDd4?=
 =?utf-8?B?eEozcThVekZuWjBLYTVMT3MydVVwWnBmQ3VrMWJIS3V4b3U2R1kyU3NHNHdk?=
 =?utf-8?B?QktlUC9oNk50eUlTRCs2NzYxM01uajJHWit6b3FCMmcxeVVROE5iRWtCUkZp?=
 =?utf-8?B?cnU3MHVMZFZqdEIzV1ZoV2RoNFQxdjlGeGdNWTJKam1IdUxxSWtyQ0pvNXdN?=
 =?utf-8?B?b0lUei9IeFQ4NnJWb01TYjhMWmRLOE9DQVZ6NjZlQWVvbnNrSDM0VFd3empx?=
 =?utf-8?B?UlFkU3FUTUJFU2M2RldpY1E3Q3ZRNnJ0L3hvSkkvRUpqOTlpcGdhK01Lbkhy?=
 =?utf-8?B?bUpOMFFwZEdnalRKeWFwRkFJZ0tzaDFLTGdWQ0lDaEUzWG40VUVtaExjQmNz?=
 =?utf-8?B?RlYzMkhqOW10bkQ1UStVTVJjclNkZFgxTEl4bDRLaUFNdFJSekQxdHppZ2Zu?=
 =?utf-8?B?bFBVNnh1U2JmM3ZMbUlYMSs3OG1mV3NSdk84dFlnWGlhZjdiekJDcFZvOVY1?=
 =?utf-8?B?SVpNZWZFbk1QMk1CVm5CdlJsMlJ0Vm5BQ2xKK014OGxEeUVBbGtxbWdkTUE4?=
 =?utf-8?B?Tk9mU0JONFNaVmxoTnBsUExHZlhIemFhSlRxVVo2OU9jRlVheW5jNzh5eUUx?=
 =?utf-8?B?ZHBTRjFJVlNpMGJnZG5qVFFGZ2pOTWc5ejZlRU52d25GQzBSTDBPQ0Irajlu?=
 =?utf-8?B?K1VwczJOWTBOSElOU3M3MFdEYzh0MEgzVkdXcGEzOEV1K2hZY3ZaelFGdVdt?=
 =?utf-8?B?UHNnY1hHdm1SV3hmT3daSGt0aHc3d241M1NhSmhYck15UGlZSHMzT3QyVUda?=
 =?utf-8?B?KzkwUXNZSEZKN21XRkFSb2d3Vi8xdEJXazk5cmVYejlHMUVOMElDVys5SnJ1?=
 =?utf-8?B?b2dNN1dLZUJQenZJYVppSUlSaHdRbGFWZmtteVQ3bzNwQlVSZm1JSFVab1lH?=
 =?utf-8?B?SlZSM0lRL2x1Z1ZHeXQvN3JPWXgyU0l0c0kvZS90dnZaWE0xV2ExckVWTWxK?=
 =?utf-8?Q?RaBli8QRx1tAm5s5jh//BuNYqESaFRtbsiqNFmUzzAp33?=
X-MS-Exchange-AntiSpam-MessageData-1: +4ZP0oeOCdvgwA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512cf7a2-9a75-4789-97d8-08def1eb77b7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 05:44:36.5776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoqZ99W98E/sTK3S1Bpa0iGU/W47WdYXdZtNLMthtUVEOXWwzEP1QN4S0RGFdWYDNIYo7H/WSdcylFt8iIObOw==
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
index ec55ec3fc7e1..7e5b0e3ffc67 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -80,6 +80,7 @@ fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     );
 }
 
+// This PMU reservation size is r570-specific.
 pub(super) const fn pmu_reserved_size_gb100() -> u32 {
     usize_into_u32::<{ const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap() }>(
     )
diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-core/fb/hal/gb202.rs
index 69ba35d2ea08..c590e5b1269c 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -73,6 +73,7 @@ fn pmu_reserved_size(&self) -> u32 {
 
     fn non_wpr_heap_size(&self) -> u32 {
         // Non-WPR heap for GB20x (see Open RM: kgspGetNonWprHeapSize, GB202+).
+        // This size is r570-specific.
         u32::SZ_2M + u32::SZ_128K
     }
 
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index ba4544210e40..a81b51028282 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -251,20 +251,31 @@ struct FspCotMessage {
 }
 
 impl FspCotMessage {
+    /// Computes the FRTS vidmem offset for the Chain-of-Trust message. It is measured backwards
+    /// from the end of the framebuffer.
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
@@ -275,7 +286,7 @@ fn new<'a>(
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

