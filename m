Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B64CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5129C10E4E4;
	Mon, 22 Jun 2026 07:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p9bBZH4P";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A61910E4E4
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:12:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rwq7k1Sy20050j0hGTcEdL1QbsATOH4UtZQcIyH3mbBfWRbP3D3TdX0oToVuG23mfKnBS0HwnPaTL2DU3Z99nVH4xJLaV5HEhgQeK6iKOrHSFAA0fAjZ2zA5KKfXKBsU+1yoxt5X5VbQg4hvz0BTqZmzFjo31d4xm4cbfY5INYyw7et4Kunfs0hsYW8EPYtyfUVDUebRWsNE2AfVris6At6IWa2AiwoidRJMO6d3tsoR8PzzlOexx7JpDpgVeg2aEYSQRb9o6hjS5uJLt2xurGOjVIKsGFgJJlS1MQtiGTaXjnVtQSGCBxBW/XtLRCUB6VpL7fpI8xc7PsB0hSsL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61ct2nEsvgntTyk+OtCr8HbBqpbqPf4c7rQNfCAGbV0=;
 b=o7nJ/Iaq4OrdKH31X5rmQfztQYZXMe3feEZ7FRJzt44OYPrVR4vZyoQ91P1FIjxIl5Ex51twJjh4juXqRu479i1iVZ9Q51UfIlqt8LVEhcTATKyEZoSr4S4RG0RCWAo/aeOCj1ppN6I74g8eZSuIaHJg/yyAhxcnkNzPbyZblce4i2YSQu60jI9v8KigMAOULVEBEI87VmFzVETs1OtBRLCSsL7BaLzjZvCYU/sZx8bcd167XpuU8ffMH1eHN2q7iS4JvJIETMuC7QZ25ReKf2D8iFGhPVXegmZsVUfAkpwI8Ob972V94ae+/Cj6Z3Vp5gfX3sCA1a9N2nwuZJt18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61ct2nEsvgntTyk+OtCr8HbBqpbqPf4c7rQNfCAGbV0=;
 b=p9bBZH4PkOhdBl2ymo+olAr2pBOTsnCvCIqNjZ+ndsVgDglh+RuOExEaXnGymOPMDoLpQpA4UG8rnqKco+YLck8qnJF0e38m08wVkNvcVyuxT720GhdFcjKPX2Y5ikqZzrKxTpawEEFvOWZO4TkWg0FQDlDabbctYfoh0N04SC8ZmoET65wf8rPOQWd9WllCWAkPsxF1TsmItQdjz/g+IbQGB3o2jfyA582qE1IpDtJTpgjy0seAGT3Gae7q2jesunNRANrWKe6UcAfsStVEfqJ13Ao1eWPfqPbR6tfpalOn11zQg/XO2mRRr21uTPdldw9+3ilYvCyly7IAdgfZfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:12:11 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:12:11 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:32 +0900
Subject: [PATCH v2 10/13] gpu: nova-core: introduce GspBootMethod
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-10-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
In-Reply-To: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::9) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abc5d12-bae8-429f-b097-08ded02d9442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: Zwb2R1Ygc1vXlS+8Rr6fn7j+lCK3yH57t9l5sl0OfZ8j9j1pesEB3Q7uLC7um+EtFBBP0DoPqUU0HDYBMQ+z4RQIbv+bsPUPlCGqyIa2MiQ3yKwA/ghZhsQxmc6WfSEFsE1eZB9IbfsIQ1zIQwY6jb1N3DxhMF9Ncq5YjbEd/4wxDSPF2T50Xcy0C9hGnS6sb+jzgbCR/oRdXEZnw9oiYy90wxmRvZ6zKdBL01KV9vvdfPwjRQ7ZQjM7fmj3ImslSEPjQYMPHaAKvVluL7Xb7X0QGD2eDN3/kbI6ts0Nl25ZwWh8yw7IWOwVQXsLKbs+0rhrG+RyjkPnuAfGq0ptCspb2buMDrMdARu6TX+oEAAhAky9i/GIhk4y0+JvLHF7SGpzmwv5STOvZOMySOF0mHOD3360WcrFS9EYBznIusDxaP+ts+zw0gen4IVpg9PPisLphSsNt5e3o82huYC1fKPu1naPt3MYUwawpdbdjzoxNFiVJihlyoBlJO8KhWtCauEFqei+VoZLOcvCNJFMYAi2ypWTfiWiBq9yfQyJOUoCG9Se/q8hD5XkCB4Ca37bdiJbvUvXgsfDKOhWogdshwZYfElfjN7h4VzgfvK1aNxselER1lQy7QagQTj7NYkooiEY7VjzxNYuhPqjq0K4IAwSoiPBNKSouQ542dFVaIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(3023799007)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhsSVR0NzkrZDB5dzFoblhoaWRueTg3V1ZCdjZNdnhCVjJEbFBhdk1MMXNu?=
 =?utf-8?B?dTNlZWV5K1BIQjltbXBwM091VmVrdHQyUW1BMmp3Z3lEQVRHVUJIRGZTTVRq?=
 =?utf-8?B?bG9Cd1YyaFFJN3AwUmJEd09mMlE2QWZnRlJGcnpPT3o2UHhlWVlINmlDYzNU?=
 =?utf-8?B?RU9LNlpUdkh0U0hQZ1pvMmRwZ3hCVjhqMDN5SEY3WnNCUGNnMmFPMmYzUmRo?=
 =?utf-8?B?bDUxUkliYkd6MFphMitCYjhXM2VQajhJSjMwaW8zaS9xQ3QxMXNZYkxiekhF?=
 =?utf-8?B?bEcveWNsek9HYldBM3krTFVLQURnMkRHWExlb2tXMWVsekFpcFppOWdYOGcz?=
 =?utf-8?B?ZmZnaWdtT2ZqU3ZPRytkNmZpOHUwaEVGNU9YU0RjdGNpVkNCdHdhV2ZiejJT?=
 =?utf-8?B?OThJdUk3RVR5bHM3OWUrbFQxRWgrY3hYR3N0VkwraERrNDdXMEZJenBySllw?=
 =?utf-8?B?d0lsd0dUbFlvSmdrVTBxSjg0b1hpUWFRN2Y3dXNuOERBUzUxYTh3Ni9taXY2?=
 =?utf-8?B?eS9CMjdqejVjWFdzeGFZbzFONmNvblgzUWhJNE1FRlJPNllaL1c0YjZlZGFs?=
 =?utf-8?B?bW5TVlNIUndBb1A3N1lBaDl6WWc1VFFHUXBNQU5haTJvODAwajF5d2xJYjZp?=
 =?utf-8?B?ZmpkL3I5L212amxlRElwSWVEN3NnYmdQNS9FUzIzL05reW95REdIVk1pOFRh?=
 =?utf-8?B?NlBwK1FmQi85WWlFZHpXQmtzRFNBNGVkRVMwRS9ta3lrYk94Z3JycGdFNng0?=
 =?utf-8?B?V3QwUTVpSXJuTTlqZzRQdFQ1V0M4U2FWL1ZENVI4ZUVnaHhSUHprMEZIU0xH?=
 =?utf-8?B?VFdCc3lGeGdDcmdERi9NZmw0NnZJdjE3cEl4bEVpVEN2dkNXWEd4Qy9iNjZV?=
 =?utf-8?B?K2RPQTRNS3l4SE44VmRGUm9WcTZuNnZlSDJ4SDhMODFYejZIS0UrN05Sa2Vt?=
 =?utf-8?B?MmtQS3N2QklYZVVUcDVvZ3pvcTc4MXk1SWQ3UU01ZDJYSWZudUU5Q0t6NGhJ?=
 =?utf-8?B?ZHB2ZVJkaUo2Q3R5cytmMUZoZ1FBckVtaXhET0lueldVNWtBV3BQWTVMM0Z6?=
 =?utf-8?B?MXJVc3dGNlpCazl6WnB1emc4cERvVWtLNEkrcmxaV3RnM3NBam5QTFhJZU1I?=
 =?utf-8?B?ZEM5UjZ4b2hEMEZyV2RZdmROMUJXVCt0ZWh1RTJNbEtKMGFZa2JqN09iZmpW?=
 =?utf-8?B?VmRoSkhJbnMxOG0rT3VoV1NUOHhkU0tmeCtrSGlDc011bDVzNk4wMm0rTWFW?=
 =?utf-8?B?L01vemlhaWs2aWdiMGFNQ1F4U2FBdWlwbEpidEZOV0doUExGV0R5eFFSM0pi?=
 =?utf-8?B?dTlRSXRDZ3NUajJSQmFRR2RPYUJsbTVhRUZSdDlwWTM3cjFiWkVabUFHR3lN?=
 =?utf-8?B?Zm9qcFFlNmk5SVlNSkxtazVJM25NUWFoOWFJL25sNGR5bkVHVlFBdXI1UW84?=
 =?utf-8?B?SWJVbm5GUFJWT2pnNzZBR3RYNHpscEd1TkduTndnVjcweGtPN0xnUzNXRDg3?=
 =?utf-8?B?ZU85cC9xUFpXV0k0OWY5S1BjWTVvL0l2RnZNeldVVWdoakVqRWlYMUQyMGZu?=
 =?utf-8?B?Yi8wSGF4MWpoQkNzam9VMFp0NlJ4OEVDU2dWUmhoUDNOTVlzUSs1L3JjK2ZB?=
 =?utf-8?B?ajBBZm1NbmoyMm40TDVzMHhZTU4veHdYZjJ0UVkwU3Roc3AvcmpnK2U5QTFs?=
 =?utf-8?B?bW44QzBEQ05iSEFrY3lUOERMN3djOGtHK1BabnVoWmFnU0tPRDNEV3lKNmoy?=
 =?utf-8?B?bWRyRXg0SHFnZk9UTnR4USthUkhVZ0wreE4rVEUvZ0MzeHV2NGZyY0w1UHBC?=
 =?utf-8?B?T2ROK3Y3TDFzb2tNK04xY1ByUW0wUXQvZS9IczdSVno5ODZnTTRubFAxaGFt?=
 =?utf-8?B?eDFPQTFRQlFQN1VPQjVDeEtkL2VjSG16bUpaMmpoZTlRSG4zLzBURGRteFRx?=
 =?utf-8?B?OWkyeXkxVUY3VW9FU0ViZUdVSEd3ZVBFOGlxL01kcDYvTm1Cc0VJTHBxY3po?=
 =?utf-8?B?QldWOUVmMUFlclNHbzJDN0dJUEc0bG9PL2NPV0xNT0xEbnJHZ0RxWUY0RlVV?=
 =?utf-8?B?MVJyeC9UVkVNNHpBSWFuNFVMTE9BWXhQTE9wMGE2TkhjeGhBcUhYR09jVjdS?=
 =?utf-8?B?L2tvRkt6engzbHg5TytlYW9nYVAzblhIYlZzTmtVY3pIelVrRWFsNWNZUXVS?=
 =?utf-8?B?V2RyYlVlU0psM01nNmF5RlM5NG5MZ2hEckFRQTNCUUVHdHdyL3lWbUN3QWZz?=
 =?utf-8?B?SGl3SFZaWlhCZTY2ZS8rZHMwSm5Cck1QYXNpWU1PSzhnd3RxYk1jYUdFZ2tM?=
 =?utf-8?B?M2dWNlZqZVArYmZZYlBKTFNxeW5yMFlla1Bud1B1N2xhbWdiRmhjVnBwbEtI?=
 =?utf-8?Q?dTa8xH3BrG3AynmyTZfSQbmIDiiht0+YbdkikjJRcIWXj?=
X-MS-Exchange-AntiSpam-MessageData-1: NYpdH7RpGERutw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abc5d12-bae8-429f-b097-08ded02d9442
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:12:11.3622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoQ0SiX6Pfo0peCphctco6zzW+xXiCWfDj6Rq1a+GcDjKnzEwzAoPNftV4zEmRmY/CpLV3on9Ii8zZvbSVXclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

The GSP boot method is currently determined by two ad-hoc methods of
`Chipset`: `uses_fsp` (a boolean telling whether to use the FSP boot
path or the Sec2 Booter one) and `needs_fwsec_bootloader` (another
boolean valid only for the Sec2 Booter method that tells whether the
FWSEC bootloader must be used).

This is neither extensible nor sound: the combination `uses_fsp &&
needs_fwsec_bootloader` is invalid, but can still be expressed.

Thus, unify these two predicates into a single `gsp_boot_method` method
that returns an enum type unambiguously describing the boot method to
use. This ensures that no invalid combination can be expressed, which
makes matching sounder.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware.rs       | 25 ++++++++++++--------
 drivers/gpu/nova-core/firmware/fwsec.rs |  5 ++--
 drivers/gpu/nova-core/gpu.rs            | 16 -------------
 drivers/gpu/nova-core/gsp.rs            | 42 ++++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/hal.rs        | 22 ++++++++---------
 5 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 15a61edaaa82..0b7047646bf2 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -21,6 +21,7 @@
         FalconFirmware, //
     },
     gpu,
+    gsp::GspBootMethod,
     num::{
         FromSafeCast,
         IntoSafeCast, //
@@ -432,17 +433,21 @@ const fn make_entry_chipset(self, chipset: gpu::Chipset) -> Self {
 
         // FSP-based chipsets (Hopper, Blackwell and later) boot the GSP via the FMC image loaded by
         // FSP. Older chipsets use the SEC2 booter instead.
-        let this = if chipset.uses_fsp() {
-            this.make_entry_file(name, "fmc")
-        } else {
-            this.make_entry_file(name, "booter_load")
-                .make_entry_file(name, "booter_unload")
-        };
+        match chipset.gsp_boot_method() {
+            GspBootMethod::Sec2 {
+                needs_fwsec_bootloader,
+            } => {
+                let mut this = this
+                    .make_entry_file(name, "booter_load")
+                    .make_entry_file(name, "booter_unload");
 
-        if chipset.needs_fwsec_bootloader() {
-            this.make_entry_file(name, "gen_bootloader")
-        } else {
-            this
+                if needs_fwsec_bootloader {
+                    this = this.make_entry_file(name, "gen_bootloader")
+                }
+
+                this
+            }
+            GspBootMethod::Fsp => this.make_entry_file(name, "fmc"),
         }
     }
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 199ae2adb664..a1cdf1aa8773 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -388,8 +388,9 @@ pub(crate) fn new(
     /// Loads the FWSEC firmware into `falcon` and execute it.
     ///
     /// This must only be called on chipsets that do not need the FWSEC bootloader (i.e., where
-    /// [`Chipset::needs_fwsec_bootloader()`](crate::gpu::Chipset::needs_fwsec_bootloader) returns
-    /// `false`). On chipsets that do, use [`bootloader::FwsecFirmwareWithBl`] instead.
+    /// [`Chipset::gsp_boot_method()`](crate::gpu::Chipset::gsp_boot_method) returns
+    /// `GspBootMethod::Sec2 { needs_fwsec_bootloader: false }`). On chipsets where
+    /// `needs_fwsec_bootloader` is `true` do, use [`bootloader::FwsecFirmwareWithBl`] instead.
     pub(crate) fn run(
         &self,
         dev: &Device<device::Bound>,
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 7918ebb508f9..d80c6dbb4cba 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -132,22 +132,6 @@ pub(crate) const fn arch(self) -> Architecture {
         }
     }
 
-    /// Returns `true` if this chipset requires the PIO-loaded bootloader in order to boot FWSEC.
-    ///
-    /// This includes all chipsets < GA102.
-    pub(crate) const fn needs_fwsec_bootloader(self) -> bool {
-        matches!(self.arch(), Architecture::Turing) || matches!(self, Self::GA100)
-    }
-
-    /// Returns `true` if this chipset boots via FSP (Hopper and later), which requires the FMC
-    /// firmware image.
-    pub(crate) const fn uses_fsp(self) -> bool {
-        matches!(
-            self.arch(),
-            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x
-        )
-    }
-
     /// Returns the address range of the PCI config mirror space.
     pub(crate) fn pci_config_mirror_range(self) -> Range<u32> {
         hal::gpu_hal(self).pci_config_mirror_range()
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 73e93403601c..771b38e6335d 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -38,7 +38,10 @@
         sec2::Sec2 as Sec2Falcon,
         Falcon, //
     },
-    gpu::Chipset,
+    gpu::{
+        Architecture,
+        Chipset, //
+    },
     gsp::{
         cmdq::Cmdq,
         fw::{
@@ -217,5 +220,42 @@ pub(crate) fn get_static_info(&self, bar: Bar0<'_>) -> Result<commands::GetGspSt
     }
 }
 
+/// Method used to boot the GSP.
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub(crate) enum GspBootMethod {
+    /// GSP is booted by running FWSEC-FRTS on the GSP falcon, followed by the Booter loader on the
+    /// SEC2 falcon.
+    ///
+    /// `needs_fwsec_bootloader` indicates whether the chipset requires the PIO-loaded bootloader in
+    /// order to boot FWSEC.
+    Sec2 { needs_fwsec_bootloader: bool },
+    /// GSP is booted via FSP Chain-of-Trust.
+    Fsp,
+}
+
+impl Chipset {
+    /// Returns the method used to boot the GSP on this chipset.
+    pub(crate) const fn gsp_boot_method(self) -> GspBootMethod {
+        match self.arch() {
+            // All Turing chipsets require the FWSEC bootloader.
+            Architecture::Turing => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: true,
+            },
+            // GA100 also requires the FWSEC bootloader.
+            Architecture::Ampere if matches!(self, Self::GA100) => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: true,
+            },
+            // Other Ampere chipsets, as well as Ada chipsets, do not require the FWSEC bootloader.
+            Architecture::Ampere | Architecture::Ada => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: false,
+            },
+            // Hopper and more recent use the FSP Chain-of-Trust boot method.
+            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+                GspBootMethod::Fsp
+            }
+        }
+    }
+}
+
 /// Opaque bundle required to unload the GSP. Created by [`Gsp::boot`], consumed by [`Gsp::unload`].
 pub(crate) struct UnloadBundle(KBox<dyn hal::UnloadBundle>);
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index ae4c44aeddaa..9abdafbdbb57 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -13,13 +13,11 @@
 use crate::{
     fb::FbLayout,
     firmware::gsp::GspFirmware,
-    gpu::{
-        Architecture,
-        Chipset, //
-    },
+    gpu::Chipset,
     gsp::{
         Gsp,
         GspBootContext,
+        GspBootMethod,
         GspFwWprMeta, //
     },
 };
@@ -66,12 +64,14 @@ fn post_boot(&self, _gsp: &Gsp, _ctx: &GspBootContext<'_>, _gsp_fw: &GspFirmware
 
 /// Returns the GSP HAL to be used for `chipset`.
 pub(super) fn gsp_hal(chipset: Chipset) -> &'static dyn GspHal {
-    match chipset.arch() {
-        Architecture::Turing => tu102::TU102_HAL,
-        Architecture::Ampere if matches!(chipset, Chipset::GA100) => tu102::TU102_HAL,
-        Architecture::Ampere | Architecture::Ada => ga102::GA102_HAL,
-        Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
-            gh100::GH100_HAL
-        }
+    // The GSP HAL is entirely determined by the boot method.
+    match chipset.gsp_boot_method() {
+        GspBootMethod::Sec2 {
+            needs_fwsec_bootloader: true,
+        } => tu102::TU102_HAL,
+        GspBootMethod::Sec2 {
+            needs_fwsec_bootloader: false,
+        } => ga102::GA102_HAL,
+        GspBootMethod::Fsp => gh100::GH100_HAL,
     }
 }

-- 
2.54.0

