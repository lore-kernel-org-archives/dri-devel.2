Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065CEC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6174510EE81;
	Wed,  9 Sep 2026 04:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XV30cD2t";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E5B10EE82
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACZuHCDd05sHXf+rn3YEiklLQ48OVS1jNlJrz5F7WbD4AK3HxVkLnf+geo3Fd8nabRX9/bH9Co/P9Z+3TcXQlI2En4xHA5nrfrEkIu0nEYxQXtyS9TWHmw3MSEmX6OLHBIDP+tH3eqlIaf5cd98QBfPWDy+/5GF84wIsawi4J5sYVm4pWaxw//DJmYbpUvZZzTNP5eCO29ivS2KcplsB+LPQHOjpixZqgGAHQUuHhg70A5BNuVAd3N1kvhl/cuJof3I+xHzJhH0p25kfp1akhqNYcXs6C6/yAaZaKFkwNmTSvgQtbf3WqBD4EqdUuvatuOVvOwalHYMi2raYH76lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX+dhapqTB6yMbeGniaEdwx0sxAYyQ7UwaIEktbkCn0=;
 b=JKlLTsQCmvMnsr5ccsf2dLWnOA0Af6iBgTvxHV4WlHUZs7bPpy22GXldDGwe+1LbxKRwa8xOxAAF1P50mIULrcHbVE+75u7/KOe51yeDaLBykmLlLEd0wzMsLcZFoIOhYs80pPD7lrcEW8ko0pP6FJ5A/KJhfp4WKYw7welEZ3cpCOgbcYPDS0ljfyh2hzi+QpyqjQIro/KkaHOh8huEO0mTKFcjn9iMGsdIt5q8HFeU+zcejZ60kCCB29K4EByD+TWzbc/Kok5Bk2ix7TDL0kSafEOkC4RM9BImp+xb64sYvdLaTIoCM//sQ4IgNmLsm0ztdzs2EGIe41ivB67Wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX+dhapqTB6yMbeGniaEdwx0sxAYyQ7UwaIEktbkCn0=;
 b=XV30cD2tGU66c/KRWj7Zbjx8ftPoajJYsVLT3Dy0Z8+KOIX+PTrpcPg0dTVGsDofNFYtcVhGII2jer5BXuveahWc1NnytMSo9Y098IBSGBiHnvxu+EY0LLslPGAD0l2A8KIUL1nBKel4RH+yQXYtaIgOmOSnNPT2CZa0P+UxviF6Qs7X0EmWA2F/ntBj8c5frC1LXZAG/6k8rb+1yWr4qczMjcabgO0XcSyoJuEPbNxjjnmmklrnm9Hsux6KJY8PrygHXWqaj93VJPBxSSX+uqRX8b0fzi0RK9wOqlewLzbDhxS3LEiZBFY2vji6GrmC97mRK2EhIlS/4W6ebUuxcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:17 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:17 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:44 +0900
Subject: [PATCH 06/16] gpu: nova-core: mm: pagetable: Add DualPdeOps trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-6-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0069.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e75ee2-c702-4b92-6590-08df0e26dc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CpjniXI9XTSMvUc5adYcwOXBfyakrh5tQtRA0Os2EGaJXAFrJmigmKZGb5s8lFWCFbFw5qLbdAie3PXUM4fS0Rtn2z3lQ0GRr7/VkFyJfwzUbBeEbCn2FMffvos1V59mAdebrov751/HHhPdAqVNxdW8vGl9mc23HpQaIOdFdDphVpCDFpw69QA/t0PZbLrtCzugFK7V58EyMrZ9/wCOWRxoDEI7d9CbNk2s9uIK7jr6maZKVPaUrGaGoQi+D2klbPVJfeR5lYG+tWijCF3Lvw43giQEDfaaCyHvVbiMT4T3Thhuk4L7CdISBemSAqHT/xf1kgGK4cDHlCykorv3+VQ8wP6Kx0WviHPAKrSD2ZUB5roQcJA322Q0n/gqjF0ZcqSPgFf4979UTSD3DH1Xara38qQdYm6zeuVmVVoicSuKRFemXBIl543hqfMzrAgJdfqrKzsJI3XVrty82/zmr5+kv6wpZICcLIoiyktc7xknUUsoN5xN++u47Jqc6pgiP0mg6y/MQjeyZDyyxRms3DPL/y9M0EtPRfbmmtHTEV/67Y7NhwmSmzl2sNkvHFlXbKKK+/ny7mm4SunYVQUDDqW0MeL7xVFx0ugYYIgU69jwddMOc2xSc5Jqo4AgF/N0eJT7Z1YfXRrQA9VXXeTvo+G9Tfxx2YxQzJ+bbDEtDtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjFTWTlTRmJabFBjbGZRaWI3RC9WYkkvMW9WaDJhTkVyQzA1NEFBcFNxaUJ4?=
 =?utf-8?B?Y2R2d0hKcnhESG1zOWpvdmdJTVNEN1hTdUtkRlRHVktCaU0wamx6S0lXbmhT?=
 =?utf-8?B?TnFyMDBPcFRRR25KTnIzUVBVN0k2VldBaGEyOUo0OTd2a1JjbVU3cmU5bFpZ?=
 =?utf-8?B?UFpFa0tZUkhhZ0NnMGVtTVByaSswOGl1WWxFdUx4NitOVkVibWhBOFVzdWMz?=
 =?utf-8?B?ZGQ2Q3FlVjNlRVhSWFJ3R0JBWURhOTNKUGgyTmpkRDEzTGpIVGx0a0twOHFr?=
 =?utf-8?B?TlR3U0ZwWjRENFo1REc1djJhdFVMbUpicHpuRFRVdUEwVlJ0Q1JMRWR1U0Ir?=
 =?utf-8?B?UWsxaGNZZUo5S2JEVGdLRVo0UWd0RWZaeTZtNU9wbXBFVjh5aUpEUW01QzFZ?=
 =?utf-8?B?enZaMlUwYy9nLzVkcHZTaS9ZN05QUkxqc2dzYmk5SUVtd25zTTJxalozOURZ?=
 =?utf-8?B?eTBuWklmcnJZOVJ6MFBUUlZ0eGR1SklEOGVsanlMdlFhQWtTSk9xUzJjQU5w?=
 =?utf-8?B?NUs4dnkwSGYzOU9XMS9paDdRSnpsSGFEVlpyWVhYT0U1RXBwek1iSHFIOEZv?=
 =?utf-8?B?aHdxM3N6empNL3ZSRzY1THVSbVRLejRpMTNOV0M1TlRxajhYV3dBYXFpYzVX?=
 =?utf-8?B?VnM4OW15aFlhUUNUMjR6VkQyUnQ4QnVzRTVCOWlJTU0rTmIySGlOc2VENGZK?=
 =?utf-8?B?eFFUbGRNTHZhanJXVEFtdkZIMmxTWHNkZGxrWmxadWo3TytxWFVPbmY0c2Nh?=
 =?utf-8?B?T1FKaHoyMlU3NHJ0MVE4NGVyYjFxc2NuQW5OYkJtSVhTdFY2bHR6WEpUaCs2?=
 =?utf-8?B?QUduekk2czVpTnRKQzRVM1FUK0xnTlcxc1RMZThsNHhERUhrY2szd0w1YmVZ?=
 =?utf-8?B?WU4wcjZ2ZzR0ekE2clFzWnFjdGhzbi9OSFkrYVRkT1dwckowWXlIQ0ZxckJn?=
 =?utf-8?B?NndZSWlHTFBQN2ZMWmpYTXQyWk9FdG84WTZQME95V3E0Z0ZuUDhrazhJNXg5?=
 =?utf-8?B?LzAwdnkrK2JwN2VXNnFVTjJqcnJWcTdENVRYVFExZ0trRUF4VEdCZlgwYUly?=
 =?utf-8?B?TkdvcjV4dUxlWC8rc2ZKNDdkckxuK2lYZ2VwbVAzekNrRXFkb2NzYUFPMkN4?=
 =?utf-8?B?bHljVDZBN0pldzk0ZjhQbzBVUmVTcjBNNjZLNDBtMkdXaHFJbzVzV01Valhp?=
 =?utf-8?B?YytoRE1tUTBEczBUL1FaYkJieDJ5bGdSeG93NTJPRUZIb2dkKzdKL29sMDcy?=
 =?utf-8?B?V01QbDlRSEtFenhkd0xHMUlHL3kzNWJGR21ScmQ1QWIzdGFUaFNNZzRkZ1py?=
 =?utf-8?B?TWFFR0k3QlBYbjFETytUL0owZ1EyTUY3WnZsT3p6eVg0UUs4VHRJRVhTS0pP?=
 =?utf-8?B?UGtOMEpIUHRQTWhTWUFROFBzZS92Yngzb3dwM1pqNDlBWXdBL0pwQjUxUGF6?=
 =?utf-8?B?b09BYXRKUmE0c1R5ZFhpRWVMOU9OYkdxbS9Na3ppRWFzRG1LRXY3MzBWUHhj?=
 =?utf-8?B?TXcwSncwd1Y0dHAvY0tIeDhwMVhsaER1dmhLWkZ4VG1jKzQza29JZ0RxbWJo?=
 =?utf-8?B?YnYxYkRmdi9QNzRaQVlmWFNFaGNSL1F4K056TUhpdVR4cVNISUtTdmhaNTBs?=
 =?utf-8?B?dmlsR0djKzlqVk1peTBvUFJIRW5HYVlvNk1RbTdRSFptQ2REcXpaOXRJWXNI?=
 =?utf-8?B?cHFVN0QwQXRMUktGbkN0cFhJZGQ0ZU1tRXRLQ1NQNlZyaW93WWt0eUNkcDVV?=
 =?utf-8?B?U0ZRS3JTNEt0ckk2VmxwNE9iMU1JaEJLTHJiY1Jldm9mRDdsTTluSjNwdHBp?=
 =?utf-8?B?MFdQMnRQK2RVd2Zad3hSNlBGUnJuejFISXo2QVJXTHM2RUxVakF2NXdmUUU3?=
 =?utf-8?B?cTMvS0xEUmo4bXl5OE5VSUtIUjkvT0hCWXVBdU5NUGdvWm5rdUhVd05ReDFM?=
 =?utf-8?B?ZUcyZTBkcnVVL0NMYlNQMGtLejFaN2dHMVB2OEZJczF4NFd1dkc3R3UyTjZZ?=
 =?utf-8?B?Y1paUGhDZit5UE5WVER1dHYzZEtVbkhOdnVzdzlmeXRhck9FMjZxZUVkVThU?=
 =?utf-8?B?MWd4eEp5eXJBZlBKSjVmTUVZWVdmdDA2d21vL2FQcUYyZ2FQdityR2ZodFZU?=
 =?utf-8?B?Y1dvSDFRNWdNVHV0Mng5OS9qS2E5bnVlekxaVWdSeUVjWW9xSXdoZXpqbHBu?=
 =?utf-8?B?RWlQY1hoZDNoQW1DQzg1aWoycGtaWTlsdlkyUTlLTmNiMy9JcmJWOVRLaUUx?=
 =?utf-8?B?NFYzUklUMGpDNWtTRGd5ZWltK1lpcmZtY1d3emMrQVRScGYyVU1xbTVNRVlP?=
 =?utf-8?B?OFpGeXJ3YU5IWERobU5oR3E5Q1Y1elRWN2dSb0xDYk8yV3BWOHVKcG5INFhL?=
 =?utf-8?Q?ulHN58londoU0XXR+y5Px6+7kQdU2nV89UGMVZyJmGb4I?=
X-MS-Exchange-AntiSpam-MessageData-1: 1cnjRUmHeogBIg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e75ee2-c702-4b92-6590-08df0e26dc00
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:17.3472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pI2D32hN6IaEivQeoy0lnG2KUd/c2kzLUhF3r//VCQXCSaHwluOvDW/FXNtlyGbOZ0PScc6TMIUvt63Ov8gE/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Introduce a trait for 128-bit Dual Page Directory Entries. The
`read()`/`write()` helpers issue two 64-bit accesses through a
`Pramin` to load/store the 128-bit value.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: replace PraminWindow accesses with typed MMIO views]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index 14436fa6adf0..550145d56e3d 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -169,6 +169,47 @@ fn is_valid_vram(&self) -> bool {
     }
 }
 
+/// Operations on Dual Page Directory Entries (128-bit `DualPde`s).
+pub(super) trait DualPdeOps: Copy + core::fmt::Debug {
+    /// Create a `DualPde` from raw 128-bit value (two `u64`s).
+    fn from_raw(big: u64, small: u64) -> Self;
+
+    /// Create a `DualPde` with only the small page table pointer set.
+    fn new_small(table_pfn: Pfn) -> Self;
+
+    /// Check if the small page table pointer is valid.
+    fn has_small(&self) -> bool;
+
+    /// Get the small page table VRAM address.
+    fn small_vram_address(&self) -> VramAddress;
+
+    /// Get the raw `u64` value of the big PDE.
+    fn big_raw_u64(&self) -> u64;
+
+    /// Get the raw `u64` value of the small PDE.
+    fn small_raw_u64(&self) -> u64;
+
+    /// Read a dual PDE (128-bit) from VRAM.
+    fn read(pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Result<Self> {
+        let lo = pramin.window_at::<u64>(addr)?.view().read_val();
+        let hi = pramin.window_at::<u64>(addr + 8)?.view().read_val();
+        Ok(Self::from_raw(lo, hi))
+    }
+
+    /// Write this dual PDE (128-bit) to VRAM.
+    fn write(&self, pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Result {
+        pramin
+            .window_at::<u64>(addr)?
+            .view()
+            .write_val(self.big_raw_u64());
+        pramin
+            .window_at::<u64>(addr + 8)?
+            .view()
+            .write_val(self.small_raw_u64());
+        Ok(())
+    }
+}
+
 /// Memory aperture for Page Table Entries (`PTE`s).
 ///
 /// Determines which memory region the `PTE` points to.

-- 
2.55.0

