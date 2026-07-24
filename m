Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D909DC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE4E10F2DA;
	Fri, 24 Jul 2026 06:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CaB8mmnw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFF310F2D9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIJdo0NNwglM8c86ilwbxHMLi8PtH+1QjuK9MK1cMIsrOdsyUN7TTCVhmsSFRXzW29EH8ITK6zZsQLN9EsJS7ClTdaTGoDmN882OZ8I++MW/b4Zo7waH3LGJXn1npMPy5e58jl0MjP6sjnXit5axenJWUe6V0WUfkHidEZj6mNNGsVktwdZFMwAClYd7Ym2cGoLjpheCdgwQT6e49uvzJlVezVolLRgOH1bVoF23Qou3r9ittoPqHSH3B+qI4aJ4XZ5zJICyb0Mpyij1lP5lnowbnBn4jSQ9x/RhV76kWwDyS2d/t42z4jZ4qJPq0o2ZBWXNgOEWtNA+ruIhPxCi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAfBRe3lBlOcnFEhgO8l1qWKuuE0GbaaKOj4DSsHjDs=;
 b=KprLAm7SHswXlu32tC3hQwu7Urct6moQiH4zzq3JN3mDJugpVu9qgDY5Ka4uNDaPlzRI8qXmvCpmHJGOs9k0EpKru51cd+d30u0kjEEcHvQAUHGw6FhqglOkXyv2t/EraRu3im3uk6UAktdirA/8hyDvGTUeDDjtkCyMtoY4otfcyyd45kUXoMvMr9KYWG2oF7jRifxgwGS+COyIcVjzEV/35vBXqhMrVgUkDqivIAFB7UagTzUA4MxbWfxrjzY4ZAnGybN2ui6Ykgc4/ZRsUnZ4ah91CCFQ4ehGR7DSBPIQg6wqif4fa7Xbenyp/K3n8nFphSu/pEsH3WSLu+5esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAfBRe3lBlOcnFEhgO8l1qWKuuE0GbaaKOj4DSsHjDs=;
 b=CaB8mmnwe6pltsxidA9k0sDfqyr8DfZB42hbD7oXM+HoBhBTSpHaj3O9XCOghXrqE6xps19ob+iixu+iQpGdiy12oSGLXM+RSmJOROOpFNUy9tktai6TjF9ciKrdmefHbYHlhRRQB3W2ys3vbU4ihHJ0vlhhdO5CS5Pd01IWMOPyL4pWfEsKyFqZVvXyyKOXmqWU3cbKtiiaM8tAy8mMabXmvyGoNz5y8WMAmS25JxjxDrzA1kqBdOyUpNmBBAht/koV1RwzLlORa4VMn8k42rW3QYlV7BR+4V6tL8v7g2mSydfz5JddFQPiTOzQvowykodCgSAvbpK+rrwzmlqi9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 06:56:39 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:56:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 24 Jul 2026 15:56:24 +0900
Subject: [PATCH v3 2/5] gpu: nova-core: rename heap size field
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-blackwell-fixes-v3-2-01aa6a54e3fd@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e79d94-863a-4093-f93e-08dee950b5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yzNXXvcFvxcYolbgRXK3UZHZUN3bERPv7XkMcIEykKfsAkVpBEPVLpjMTR7YgFIU47Iob1Wu8a0wuCxlr+dwiVVlIoSI4BBUh2+/aY0L/ED86edVUT5IbcYbK1DcY+VZ1CUdE8Z+QGnrNZOp33jI2NVEcv+uPAWPjdRmqplPe6hKogY5egAA6KDP6DqldZo1gVyaKnnpHElhT8xRlvkLcG4See6N2o/WDnxw+K7pv/PHtkINMAysoN9nxFkNSTE3mQJruehzIDTRk+9ozXQRUtd/Is12R8tBwU3lrtQbLyJV01iOKWN0IYWTBJP6KM6mXX2J1SZM+q/1qz37q7eTjT+ffAhQW6QCH17BJipPnptydSJ8Iom27o2yKkmUVlvP1O/S1BS3vg5PzvzV16uFQURpZ8C2Aj5iwvIS4wVhS2GnNj5zGfFYpAoR/O5aiHZfSqR0MJw3kwVbnH2JaROawqxWlwy2wK1bEOZvICM/AlRV5u99cbpc8CrdS9ruEB8jQOkyaum1EfU7+wK/dWiC/kpdN/mhaw03G7GWorGj1qhfeExwWhRIi2opWeP0lWCkuNWC1hGhp7i/x2KE+NX4dV/9KcUcH75D2I3Qf9eEzAguTlgYWwlltTKrQC8yYUuVfYtCHLOjLlQWh1nh2YD7AH/gA+K8lxHz7siHSA7dDGk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXJXb2RNM3FRUXBSL3N6NHlLS3JWUGpXOUtOQzFGd0tLMDZKU0xwUUZHZXZL?=
 =?utf-8?B?ZXovWWVmWDQ5SEVZdFJxckV1d2VzdE1aRlF1QmFhenhtR1EyWm9aVTRtU1Iy?=
 =?utf-8?B?djRtZ3NXN09GWHhaWGNhaWNQWUNGcytRdys1dFBrb3p3RjhNbzVkN2paTjZp?=
 =?utf-8?B?M1dnS0tMYmpRN3U1VUwzTHZQcEFVdEJyQ0FNemtFRmh2S1F0cmNpUjFEV2Er?=
 =?utf-8?B?aUw5S0pQa3Evd282OTNNcjJOYkI4eEhoV0NEQWxoNlNLNWNOS2poSWFObStt?=
 =?utf-8?B?YU4zdWIrcXFUTG1WMnhoOTNoUzBDRzJ4Yk4zZ3dzRlVtS3JQM3Z2cVdQNXBZ?=
 =?utf-8?B?b2RTQXZQZDlMZ2MwRWlKMmpUMHpYUE9VZWxYOEVXQTZsbTVwODM2ajkrRERG?=
 =?utf-8?B?WExMRm43K05BNDdlUkxxYklIVTFXTzRJWkIzeUQ0SUtqR1hZYnBZQkJOdWpp?=
 =?utf-8?B?bjFrbmZVK096Q05NOCs3L0JkMVFDYVRCc1FHUE9UUzBocGJpRjR2N2tUYVFU?=
 =?utf-8?B?TElXWEQzN0h3NVErSEgxWXJSU1ZKd2dNMVBnakgrSGJvRDZEcmFibzZIUDlH?=
 =?utf-8?B?eklzWGJnbGwxVi96a3A4VWxYRXZWNnh4VWRjS1hrdVhYNkVaOUtmakJSM0x0?=
 =?utf-8?B?Wk1saHYxWUhvN2E5em5jUS8veDVuTzVBZ3ZROHFmS09aMXVnZmM5QVczVUVJ?=
 =?utf-8?B?YWMvYnRSUWtSbThMVllydFdZOFBBaUs1MWc1aGxkMXhzVnJiVjNkWkJndWhi?=
 =?utf-8?B?RUxPVW8xREdiL0d0WENuZDdoL3NKYmtkdlFnbDIwOHQyRmsyYWdLaFRXcnc0?=
 =?utf-8?B?YkZTdEVWN2YwRUNUK0RSbnBpVHdUYzkxdWpkMmVwZFJiOVdZQWx6OXRDU1Y5?=
 =?utf-8?B?Z1lLb3M2NjNmOWxMa1pQUysxNlN1emt2ZnlreE1La3RTSnIzTFhqVUcwcFBk?=
 =?utf-8?B?U3lSejNFNGJvVS9RT1pUWVYvNGM2WVBqSU42QmtramlvejVCdlRGemxYTDgx?=
 =?utf-8?B?QkFOSWNKMTRpdktYMUNoM0hPL0FxbTU1MzViSUpBYjNSU2x2TEQrbW5Od1BQ?=
 =?utf-8?B?eVAveWppZnhSMFNyR0tqa3oxQlhwc0Fwakxib3pMMmkrQ1lwQVlDLzExK1B2?=
 =?utf-8?B?TjZDdWxWdnRsZ0t6RVRsbW5PM0lUN3IwY1F3aTh4dEE5VFg4T1V2SUZWV2RX?=
 =?utf-8?B?M3VBNXBZL3N2RUtzS3lvVi9sYnhGbzY0SDJ0U056TUYrWFZzUnJ6T1ByL2w5?=
 =?utf-8?B?Myt0dmNSaVFCUDdpQ2dieStZYWlCMXlUMU1OQU44OUJLZTRyRXpEVFJkaVB3?=
 =?utf-8?B?V3BGeGhMdTBvVTU2M0FDWER1cGdPWVc5MDJpdURPS2RMazd0T1ZqcmdzcU16?=
 =?utf-8?B?cWNsSk5BTzZmU0hTOElhQURYaXFtTzNRZXJNZ0xaS0YzeU16YTBodUN4YXlp?=
 =?utf-8?B?VkxLZm93eEZtWWNMYXM2SmlMY3JuSkc4dzQzQmVLUy83WVROUXpJOVVlcFVR?=
 =?utf-8?B?QmoxSGdINkg0VWxRazVSdVI1RFdIazlmNUFyRDl1Si9mMkEwSmYyTzhkbXVs?=
 =?utf-8?B?aWd3aUJhNktHMmtwbHA2aE4xREIyU2VkZ0szQklURTVDTmFqRTFmS0V5RmxV?=
 =?utf-8?B?MXhPelNMd3RQRWd0TEJtSjRmOFFFSDdCc0J3dW42WHdZNEJjODVyV2dtR090?=
 =?utf-8?B?WHQyL1h5TDF4RmlGMjVLLzR5SzdSc3BBM3pBanQ4UjJXWktFMFRFRmdzWlRu?=
 =?utf-8?B?dU5jM1Z6U2JIZ2lIQXZNZ0xpZnpyT0FvZmVDVVA4VG91aUFFWnU3VmR3NVNk?=
 =?utf-8?B?eWJkVE56VEhNZWlUZlZVcmhGa2lNOTVtUXpzSTJLWWZITWtEa2VoelpzalNS?=
 =?utf-8?B?UHM4czFsNHQ2SGlQZURqSi9kY3VqUVNtUW4zOVkrRlIrdVBsVmJCWXpsQVhw?=
 =?utf-8?B?RDVHcmwzNUtwYnR1S0ZzRlVXUUVpYStPaUxYRGNzbXBCMnRBeTJFWjZpdGtP?=
 =?utf-8?B?MmRoMDdpdWxRb2FTd3NoMVNjYWpXTDdybVF2SFdCSUdNZXRIY25iUGpSVnZJ?=
 =?utf-8?B?UnVKZ3ZxSDdFZlJBK043UlRhbzF4M1VNVFZaaXNubDdKMWpTRDJkQVEwU3Nh?=
 =?utf-8?B?VmVpVjlQNFljOGdmdXJIWVNaVnB3czNrZnRnRzMyaWhtb1cra1FZYS8wRzRL?=
 =?utf-8?B?RWZYUUZCb1NRaHJGTE9GRkNSZTNmTnRMQXJmSCtET1lPRVNKcnZPN3gyOE9v?=
 =?utf-8?B?Tm9DOE8wekU2bFVFb3UyTW1zNVVnUFZDSU9EV0ZwL1dSb3R4MTV0Rm11cHpq?=
 =?utf-8?B?OHNjVTg0bWQvVkxSSnlFY2k2VVh5T24zM2ZWcDduS3dlKzZRRXhXclFCai9t?=
 =?utf-8?Q?xGXuwcx6Ojc4OBMnlwizoLRJ8RFFlC1LFunfh1gAZfgdf?=
X-MS-Exchange-AntiSpam-MessageData-1: 0JtWXT/Vroc7VA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e79d94-863a-4093-f93e-08dee950b5c7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:56:39.0504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5MCybHIkHGECs1eKpGRUVAnsuL7NyMaG7ztTZKUzVzZFL7MukH7sLb8ef/BPuruTSPpREW9FRYzKI9RCumr0Q==
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

This field is called non_wpr_heap_size everywhere else. Unify the name
to make it more obvious which heap it is.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs     | 10 +++++-----
 drivers/gpu/nova-core/gsp/fw.rs |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 273cff752fae..1f7b6a69e4db 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -163,7 +163,7 @@ pub(crate) struct FbLayout {
     pub(crate) wpr2_heap: FbRange,
     /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
     pub(crate) wpr2: FbRange,
-    pub(crate) heap: FbRange,
+    pub(crate) non_wpr_heap: FbRange,
     pub(crate) vf_partition_count: u8,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
@@ -251,9 +251,9 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Resu
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
@@ -264,7 +264,7 @@ pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Resu
             elf,
             wpr2_heap,
             wpr2,
-            heap,
+            non_wpr_heap,
             vf_partition_count: 0,
             pmu_reserved_size: hal.pmu_reserved_size(),
         })
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 166b0c69edb7..93f2125dbbfb 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -191,9 +191,9 @@ pub(crate) fn new<'a>(
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

