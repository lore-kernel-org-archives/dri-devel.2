Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B969C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B76810EE7C;
	Wed,  9 Sep 2026 04:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzgWq3IW";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF1CB10EE7C
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWtYX1wCFOXkLuCQPJtH6+O/HBjkx5A6xrKSApJk9RMcOECII0yzqKSDJOFgYj8p5tnL4/S21RJpMpZ8p7DXDg67xRKyiMH3gIab8aEkSxUdXpfRV8lJxZ+ygZSI3DlNpGR8PTKfFD+y+SRqEYiF7AQg4zgulrrirJ/3EXy1pqgTg4ySadyuBQoRdRmdP7XeXCPDTq9On8V0FvBqYKhy7M5KUV2rgAKoBVvfaidjK9F4NI1hT7IrlZ0wP1nq86iIHd1KIZY6FaazhZZpL8jaGz/A4XXQQWSQMJ+4/9lOpajnuSBSc5GLrWIE8GiPhMzVi5NkNH+nTY6I8xAfyWmx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibCIauwU7qaVH7uCQs9Y2szGfAw/OArMlvmGbF1dy74=;
 b=TR+PyPv4NIdwVmMMR3hHMxsBv1K40nqM7i4vUXSKHf3LOIQdiALYmwEVL+b3Bk33apYjCp/QSd0LB9oiLF0YlOTul/+o8IE2pWeFw314mApwOTErtpNFhk82fYsLtzVVXMrwubbGdSfq89MFpclNV8bGXghiRYa59B/8kq0J4l79cxKHJ9xV8GRK3C6JHTW8shNvyNqbzT+SrfYSyQwHtXMMrKG7r2iJ9CIzi3NKV8ga2QF3cW1BSyWVrUtlCFG98dcmEjdpwKbDPIXLnmcIjjc++EXgWn/PX0ryS3+iw2H0+bb5iTBmCtjpcTn5u7j6gn/xXl3ubbAiunjODQwdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibCIauwU7qaVH7uCQs9Y2szGfAw/OArMlvmGbF1dy74=;
 b=pzgWq3IWQhZsw6wH4bqFlv2roQv/RhGwHEbRrcbvGVZgMnKy2oYPugj81J5ZtiIKygh55efzQCTxI9ea3POdKa4YEXlNDs8Pi9qIBYtyuObdbEQYz6nT07RcCuP/Oq9OGONluJ6GtYErRGBcYk4skNYOQOHCiemDfTF43T4H1stF+/JKUWg4t1L61B6k/gppciuIFwvsAkYNPJdDcX9UZtmNxpfWYtMi4Dr6N1yWfQMBNZrzA5jXMDUQ03lauxWcqiuNO4WCw7mnc6alYJPe8b/xqzOLeJ9CL9EaDxrP4A2w2gge83iNmHQqnjfgqMOUH3syMvNsk9ub2IK12Xqrdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:10 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:10 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:42 +0900
Subject: [PATCH 04/16] gpu: nova-core: mm: pagetable: Add PteOps trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-4-8dd5d4225d2e@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a38e10-20f3-4080-acfe-08df0e26d7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wBVANaYUyHGV72NAPHp/9T/VHWVuSFa5OXVSfVp8Yvk7kxXpbgOrU3R9cTv5clvH+VPK6E0g40OVKhT9f4zdoZWfI1uY8VcF/urqbge5rfRPuynPlHMQJtUrQbjApw5f5hyVO39Z1vgZnN6PyCVo6M59m+wMUZL+iIPRYCgqQ9fVZnPhFqDDMwuhvU9i+kmYknm9PHASbPd3yhyNpYNnsHPUECkcIPGZ/OgCoVumqFA6kepDPgdVQ2iDkq6vygoITDBmG4I4PbN4H/kczHQC/jyE9aRuhHi7gdzEjNXWSSFemzeUfwEInmRIGzUDU8a2y+uBjlVp/TrU9ceezLSxv6tVVTuDfGAN0oPbQ87Bl+UPeDXQDFJl22IuiP8eWT3Utj38PjGE/vfpt/aIshin9CUa8llqreqzUN8Dx/x1VlKKIDwpVlvDh3ZxQ2+fjjMGmVhItwlgXHFN8NXAfEP0estBIOWbuAPhCcJzuooVHz/z1hKkAUCnXIR3yAINxqofkXudMm7reuljBIt7XK/vYN00iO/s1afFhw8dXsD0hT5FsAGJT0D+t/w2T4nO3qr/oPL3QB6pSPGaS3G/PzbuQeN49UoR58rDAhUuVTr93bBBwCWd1xE2U6g6gMco5qaBs3ESKtFO/hlyHcb5ige4lLZxLUrv461mZlCpSCpkPnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtFZ0NCK3FnZmFNOXNRRmxUQldyODZGNmY1bG1VeDViMzljSDZOYWpSdFpE?=
 =?utf-8?B?dXMrdHovdGU3L2ovRVdwd2FNNitoTEN5dE43WDZQaWVVb0UzMHc2WjJRVW8v?=
 =?utf-8?B?TU9NVnhtUU5reVBMam9OZHlkNTV0NkR4T3h0U3NMWVRRNTZqVkhBL0hPSDlP?=
 =?utf-8?B?eUtYc0o5WkJjTHBEQWlWbmU3dFpaRG5iNEs0VTJxLzhmaGxjY1hXaVVKN3Fm?=
 =?utf-8?B?dXVrYnhuc05rek9jRU8wcDU2Ynp0TWdiL2tud1ZFM0cyS1dyOGtyMmYxNmFB?=
 =?utf-8?B?UDhNdWRVUFZaWWZZOHE3Uk9CNFhsc3VHN2MzQ3VzWk14bnpCd3BTeWlBcjU0?=
 =?utf-8?B?TitFWWx1L1ZXZFN6cEtiR01zckQ0bGNHejFLeVBLQldENzdLMjF5VkhYYlVT?=
 =?utf-8?B?QW92aHNvV1VwWlpXc3J4ZzJIajBaZDhGRjExYzdoSDRMM252QlNUV3dQRlhl?=
 =?utf-8?B?MTJSRTkrWlc5dlQ0ZUQ1bGg4SVhiRXBTN21QRnQ1U1Vma0RKL0xKSy93aS9Q?=
 =?utf-8?B?SEcwZkd6QXppOVFSV004ZVRSQ2FEZEN4cWsxNURKRmxHMlVwR21YSDVhR2hj?=
 =?utf-8?B?azNaOFkwZUdUWlRUMERiNTFwckZzUVo4UEQ3a3dCUE1GUE9aMStEYkRHMXYx?=
 =?utf-8?B?VDN4N2l2aXlDYU12blBuNlVObEZoTHBKYUFEUWdVUW0zTFc0UHRBbzN0SkhK?=
 =?utf-8?B?TlVDcUNBS3Y2bnBSRDZYQ09neUVkeE5EZHVPSCt4Y1F1Q1lVc0huYi92M2FM?=
 =?utf-8?B?ZDhSVFphWVB4cGZvRS94YXd6YjRxTTFMYUtOai9ISTBjQjliZnMvS0wwRW1K?=
 =?utf-8?B?Y1RES0hncDZDQzNKdjlvL1h0VUQ4cnN0bUpoK2lCZVBnMzNSSU03RysreG5V?=
 =?utf-8?B?S21CNWhsdlkzcWdaOVlFNWVIb2hKQVZVbUhZWEpBTkVPUk13K0Z6Ti9nc2J1?=
 =?utf-8?B?TlZWaHZTb1R2L2pKakJUeDlNeUQ0WE1sRjZKdHRXWm9oQUtDVWI0cDBTcm85?=
 =?utf-8?B?Q05CekFtMUMxelJpeU0yeFBMMHNHV0dVQ2J1SmdySkh6ejZpQjlUK3lIWGVs?=
 =?utf-8?B?dEpRdnU1MVZjTy9rU2l2bnl0dlZEZDNvcVNXeHNPSlVocGdEbDhyb1psN1B2?=
 =?utf-8?B?TGdtMGx0MkJaVko3Q1NHNVNEWHNnSXpNOTNkZU1xQzVXTks3UEFHS29sNndr?=
 =?utf-8?B?VXdwdFRYRnZJOHJUaWZpdVVGR0l5YmorQmcyS05NYlJPOXdSUFRTWjNzUXRE?=
 =?utf-8?B?ZUZEYzJCeEVQYXRFQ29TZlRFVFI5WjRZM2g4TUg5V3llZ1UrTG05UHdmdVRT?=
 =?utf-8?B?akhtaGxTV1FHejJzUFZwajVMVTVibWdlb0tSdlhCVlNreWl1SlQwYUNVdDlE?=
 =?utf-8?B?TVFjVzN1engyVTV0cTBZT3pEbmVaT09naGlvNlo2ZmpaN3Jxc05RbGJIT2kx?=
 =?utf-8?B?Rnd1VnNpZ2k2a2lobXlkNWZvSnFibVp0NGI1K1krRkhpOVpDSVREajJiNDBm?=
 =?utf-8?B?MjY4VFR1cGgrWUhpMDVkYVlqdEVCa3RDYitCVDNmU2dmbHR4ei9PeDRDaUU4?=
 =?utf-8?B?Z1l5T29QcUYvYS83NEVrSmZJeE9QWTdnWHpDd2Q1Mkt2RUp4M0hXWnJwcjdI?=
 =?utf-8?B?YmhsekpwTDFXVkxMOXcycVE3dE0rY20vZE54ZEJ5emkrSmRSWEpVWHUwWHBH?=
 =?utf-8?B?Yi9pN1dRMnFURm5CcTRYMjI0MGhTQWhjVkw1ckZmV1lua1BudjhZOC9SdC9J?=
 =?utf-8?B?U3JMOUlhYWZqZXJ4ZktlVDBNa0pYZ3JJQ3o5RnVscFE3ZTRjMEVBOGtpSkdz?=
 =?utf-8?B?UkNFOG1zS2RmdFZRWHk2aTQ0WXJXUUNtN2YvUkpDcHJoNU5wekJ4OHVrRU1o?=
 =?utf-8?B?OEZLRnVSOWpzSExvVzZ0TnkrKzFrNlhWckFDMldrRlRYd3pwV1RiQ2s2ZDZD?=
 =?utf-8?B?UDVReFk0Y3BnMWtPTDJmLzNKREUvUUovN2dJUlFnWFlIRDdhZERrMnl0QkNN?=
 =?utf-8?B?M3lsa1JnZnpsMjZRSlZOR0Q4MUpWTW03d2JPS2c1ZGg0TklDMmQwTnNxL0lk?=
 =?utf-8?B?SWtyMEhpeVFwdEN1SmhURWh4VjJHWW1hZ1B3MzJkREd0ajBwSkRleG0yaDM4?=
 =?utf-8?B?Wm5QWTI3MERxYnBTY1premhBSWxHYUZ5bG5GNTlPT0dTKzZYZjl5bHVXdVE4?=
 =?utf-8?B?ckJnRXliUi82TVJHbW5IdEZUekRYUlVVbTZ2ZmU3a0hwOUhJM2tFR096WVl0?=
 =?utf-8?B?K3c1K2RTKzc1eDNRYU9wV0hoQmZLbHI1K2hnUnVRQ2NnbCtuWVVLUjFJVkQz?=
 =?utf-8?B?VUlZL1h2L0EvU2pqNlljaEFMRTBqTzlsQ3ZJNmpma1ZQYU1GQlZ1aVJTeEQx?=
 =?utf-8?Q?fER3Jb6crh0x8k8a/yjzm5sLg5zYRPyyDTZHDceBkpmik?=
X-MS-Exchange-AntiSpam-MessageData-1: MLmjxuG24KouMw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a38e10-20f3-4080-acfe-08df0e26d7c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:10.2905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMnbG3USEdZy5U+eRLZJfuaxOj2vAZpTnNHaOwh9X87njulmwkFBk6FJOa7zG9qaSsnP0P8NuDZ3oOIRt6LKwA==
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

Introduce a trait for GPU Page Table Entries (PTEs).  New
`read()`/`write()` helpers are provided that go through a
`Pramin`).

The forthcoming MMU v2, v3 PTE structs will each implement `PteOps`,
allowing the later page-table walker and mapper to call PTE operations.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: replace PraminWindow accesses with typed MMIO views]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs | 46 ++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index ed0f3d731c63..a23370b4b62d 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -8,9 +8,18 @@
 
 #![expect(dead_code)]
 
-use kernel::num::Bounded;
+use kernel::{
+    io::Io,
+    num::Bounded,
+    prelude::*, //
+};
 
 use crate::gpu::Architecture;
+use crate::mm::{
+    pramin,
+    Pfn,
+    VramAddress, //
+};
 
 /// Extracts the page table index at a given level from a virtual address.
 pub(super) trait VaLevelIndex {
@@ -84,6 +93,41 @@ pub(super) const fn as_index(&self) -> u64 {
     }
 }
 
+// Trait abstractions for page table operations.
+
+/// Operations on Page Table Entries (`PTE`s).
+pub(super) trait PteOps: Copy + core::fmt::Debug + Into<u64> {
+    /// Create a `PTE` from a raw `u64` value.
+    fn from_raw(val: u64) -> Self;
+
+    /// Create an invalid `PTE`.
+    fn invalid() -> Self;
+
+    /// Create a valid `PTE` for the given memory aperture.
+    fn new(aperture: AperturePte, pfn: Pfn, writable: bool) -> Self;
+
+    /// Check if this `PTE` is valid.
+    fn is_valid(&self) -> bool;
+
+    /// Get the physical frame number.
+    fn frame_number(&self) -> Pfn;
+
+    /// Read a `PTE` from VRAM.
+    fn read(pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Result<Self> {
+        let val = pramin.window_at::<u64>(addr)?.view().read_val();
+        Ok(Self::from_raw(val))
+    }
+
+    /// Write this `PTE` to VRAM.
+    fn write(&self, pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Result {
+        pramin
+            .window_at::<u64>(addr)?
+            .view()
+            .write_val((*self).into());
+        Ok(())
+    }
+}
+
 /// Memory aperture for Page Table Entries (`PTE`s).
 ///
 /// Determines which memory region the `PTE` points to.

-- 
2.55.0

