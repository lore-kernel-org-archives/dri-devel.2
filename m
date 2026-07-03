Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE22C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A956710F76C;
	Fri,  3 Jul 2026 10:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1b9fLv5";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8829310F76C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8DVuzuSxHrJrZUCEGarA5RV/aWupRGk5QyWadM4bPKkiXcRosrOolbIG3b+URU7yoHxn7qgGLd5tD5pMn5rsfmbZkS3d1VjmjdfdawRYby53f/lqJkda1JWZbpA9tY8yfNM4oUOWi6EIc82zxSmIzN0bYQBJqOIWjae2gIsm75vGD2dlAy7Jn+PZ+3uFQUCQFI4Cz+mL2rXZwbiaIxxdqLI426lCfXvdP+/e4onKJ4FJ2hwj6HCzvPzYspqk5otZuQSkLlpUHbKbzlQhPKOEqh0YiTXk0J/6IKovDsRwvcM7NyCV+l5C7tyJlbYKJqmHAC4w+IkSLZvmmiRUDfICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Sv9n22DcHCFlo8Kt9fY116eRKkZuvMlOZpdtDdlPLQ=;
 b=XGKkNq0kfKUKMoMXDHAPVG9rpHN3oxrY/TGYqXHWaJ5Ffm+sgAzIkEpZgq8BzfFR6wHxeRkOxCJisemlyn1q/VCgWhwStdHCL/NJFyKMjRqwqOnrvBcugh5830WfQgA8sy9KRWhCJEbb0be5UxTXxYHLLOH7Cr1g4/8pAkSOLcKYkO1RG0P1GXFGdDo32FfvPXe1sr0WlihnF9sSS1sTIhomAFOSN6PNt3N2LaONyDr7OruTbrBFaP1Y9tcjV5FYMLx2/Fu3ZPFYKVRX4ozSfOkt3ZGM5Af36bocZbY86mziBIiL+o4/mPr6CAxCGdGM7BCIvm/WAFzJ28Y4lkFCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Sv9n22DcHCFlo8Kt9fY116eRKkZuvMlOZpdtDdlPLQ=;
 b=g1b9fLv5DUsKmj2vw9mDipgnAdopjHpn5Q8Ao3FYWFWaAv5gqtesnXQ0EwQFucHXt9ARaMo8iWfyo22iGd8d90grgzBB0RDUdZ5/30tgfOicaL+ZJ7Q+qHKrGvvhYQDNgvGsy1jxjHu1I+MzY9KpI5R49eylRIjyvR+WOWmZI7V1tylznZ0HfEcQvAK1ftHJEL+Ok2Y7p3HGhLrzEM2MY130HA7NHXg/MRT3TtzaBfOaoNfYb6he1KyyKmRelESNL463xLLyoqpgL5fhLT+WV4wg/4nOKEgR7Znr55jNK6VkLee6Nn3MXN/JtNKKhWm+tDJB63lIIImq/WI50JjRMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:50 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:50 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:11 +0900
Subject: [PATCH v2 07/10] gpu: nova-core: rename heap size field
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-7-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: ce66a2ae-1310-4b73-f200-08ded8ed0912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZsOqYGo6NwCRAzAgiY2Mvr0g5ORVfqupUVG26RI56RZO82wwVmi9m1i36/fOYpCxgobOHYWqXWmNhXa4/aqMhnPKA7MFXG6BcK7kxJyFS+DXV1kK16GEH+w5RmIM1pnehIO0RP5o+ugpqAK1LPb4uLYRAmkN8kAnDiXx35YWV3yvpNRAtwwNqmf7uc9kSkBe4A+lJ02TCOUgaE224xGKOHK0/aXbfK9PGS36IRftsY18MvAQ3QO9g02oXFgCnYvd6+5vMTuszAzHMmq/Ok/zrgEvpEYoICltY6v0D0+LxRKjAp8EZhLtnQs42Wc6hr1wy7nZAHclMPye/31p+BqBefu2X5diIEqxYv7fwq1bp46gHyhOmceeGx97FVY5VcwNJA43d/V8srGxnJn/40vCjSqpbdiIy0rHxkM0zSLUyWjAlYqPFVMoMU3bkZ1eIaWXCpGOxCnH1ajkbuA1mQeQgeAf0DM9fPghaQDTUHeyDbuI9P386r9WizPOntC/WkWX2KCwjmoaoQC48s15TXfSgkCehUABbSbSIVyulNgsFkjpC27K/jg2zo2r/HP1jUkTuBkTo0hXL4X5POOpBlSCSyyKWQqFx7n5orCi7GIvfN07J3IMPl+0S/VyRrbBoAb16bjvC78wDFaKFAaOktGNptB30Pp64IVstTUaP3GquKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDN4Z2VYRzBjTEEzWmZxSDJVS21tRHVMTksvelQxMVZ0V0tUWm1QWEwxM293?=
 =?utf-8?B?TnJVZUVwTU5WOVlKZ0JUTUxqaC8yZkM1OGlxSTJaQVc2R3FjcnQyKzA3NkVr?=
 =?utf-8?B?Q0lJczVpWm9MbWcxNXIzUzIyOVJQcTFPalpENUt0Q2pocUpGdzM0dlRzL25S?=
 =?utf-8?B?LzVEc0NFQ1VmdEs1SHhHeXgwYUtXTHV1akFCNDNqYWV1MHZqaUEyMVBhMElm?=
 =?utf-8?B?TlU5RFRxZXNxVTBuWWppYnE0U1JZS3pteWZqR1NVQ0NEWk56K2dvOVZSbGp6?=
 =?utf-8?B?N0NTU3NsU2hpckVmUHJkd3BQNHlmdTNybURtaFhjcThZdjJPR0dTNWt0aVQv?=
 =?utf-8?B?QmFQb0hZa1VUR1Q2OWpHWFdnY1hOQlhNVTNPWUg1NzB3RlpLZk1oRjZLelhW?=
 =?utf-8?B?cDdJYlJURzBGSFo4ZklKaXdGZHhSYjdQTU5SV0JOL0dXemRuOTRDY1R0WmFR?=
 =?utf-8?B?aFpVd2RWZDA5L0E4MmhySUNhblI1eVZZNTBURjZqc3FtUUFSa2JXTVRDNE9l?=
 =?utf-8?B?b0JNdHJJeU1TMHFET25xZDFtWFlnZzhCMVpJaEZkSXFSUWthSmxtSmtGNVI3?=
 =?utf-8?B?dU9JNEdxQ2J1Mi81aVdPU3hURVdGVjZYa3FLYm4yZk45cWZKd2piV3ZpUjdO?=
 =?utf-8?B?NzJBNmQxSUJlVnJTYXlSMWhaZHFzbmJMMDNxNUErVmYxR09iN1BobW9Kd1ha?=
 =?utf-8?B?a21yanJVdWl0V2JqTUJGU2xnWlJhTmdoWXlycEZLdmlXWjF6aHdEOU9Vemhz?=
 =?utf-8?B?WEdMSFRtR1JqZWlid1pKMVBqdHVvbWZHQ1hWeitFKzdwelBkdTc0eUxBNW1j?=
 =?utf-8?B?ZE43ZDV5emovSStGWkJ6TStqWis5M0gzSlJsZnhRbUxRbDlFamZnaHBRU1RK?=
 =?utf-8?B?WTJ4eWRGcDJ4Znl1Qy92VWxrS0JGQUpjWUIwUGVRRkl0c0p0NGxnbHNCbnU1?=
 =?utf-8?B?Q2VudWlxWjFONkFZSENMVzdYb2JKNUpSSG1wcGVCSWs2Q0VvT0pMUU91bUdx?=
 =?utf-8?B?TGJPSnptNGdoTDlVRDRrSCtwSjJ3NVozWEFiVlZGems1UXZYQUgrVitQNEI3?=
 =?utf-8?B?QjFxNGVmR3NPUTBWUmM3alFBVWRTZzRmN3NsVmMyWWlCWU41a1JGbUFlWVNv?=
 =?utf-8?B?K05YM2tCMUcvVWcrb1d4elltcWg0R3pyblpUZTNkVzJ1ejZQbU01SHprKzRn?=
 =?utf-8?B?US9DMmJzQktZZ3hUVFEvMTJWUVVqZVNobVhyMXROcWxKN21DZXd1ZE10NWFQ?=
 =?utf-8?B?b1cwdExBd2xRN3Zsak9YVllqb2lZWVZLYUY3eUEvYjNJR05TT1FiWXQwanV3?=
 =?utf-8?B?d1FhUkxOWjlvM0lvQklWeVQwK29OOU4xengyMEZMSnMvbkZHWDM5L01yWk1k?=
 =?utf-8?B?ZUdEdDRRaFZycFlXeXdmMVJoZVArZXBOU2JGblU5OGI1UzZxcDFUai90ZXZ2?=
 =?utf-8?B?VDlhL3hHQk1aVm1hQ05yMGZLcXpvb2JUdXAwTUxpMzc3b0N0WXZnaitJQ1Nj?=
 =?utf-8?B?czJNMzRBQTIxV016WExSVTVtN0kzN3NRUzA1RU1aV3ZzelZxNmg1UnVXTkRu?=
 =?utf-8?B?V1lqY0tqMHJpTXRiUlhGVUV0TUw4VWpHWmphWVA3Z09HTjYydDY2Ym14c3BX?=
 =?utf-8?B?MjhVNHBJaW4vS0RrMStpVXVxY0U5UTBCY1pPQzArT3p2bzhYSGttL1ZHZlp3?=
 =?utf-8?B?QWJmZHR1THU3MlJIdjZEUjNhdzJaTHF4MjByK29IeEFUdlhqVWRHaEFXUEI5?=
 =?utf-8?B?VDFvL3BhK2N6TWdEWTlVRmE2R2ZZbmZ0WEZ2R1lqbklrZUdyeUc3Q3VrYU5r?=
 =?utf-8?B?Q3JXOGZpWEtHMkg0TG93cWRwVCs1ck9hMHdQYnAzRDc4eU5xSVViVVBpS0Ux?=
 =?utf-8?B?dndsa0hYOWpkUm1ZdFdVbGVWY3hiTkE0MVU3VC9BeU5qQ25OZi9yNFRvUGIy?=
 =?utf-8?B?QTVNMDIxOW52OENkdXpVdW16eDVYL1IxT2JaOVR3MFQ3YjBVbEtJdlpDYWti?=
 =?utf-8?B?dnQrdkdTN0txY0h1SVR3cHJUZVR0dEwvZm1YTWQrdDNIbll3aEx1dXlxcW9i?=
 =?utf-8?B?OFdZUmpvaGMxenhkL1crWFRSbC9ETnl4TWdnSHdnSmtPNHZDWDdpa1RuMXll?=
 =?utf-8?B?YjRPWWMxVERnbk4vbDRpNFZOYWE2U2ErZDh0aFM1MXlITTQ5MTJ1Y3E2ZHpv?=
 =?utf-8?B?ejc3U0l0UDFsZ3IrUUJvVFBDb2Y2aWtTclB3N3NvcGFhcWszdCs0amxyN3ht?=
 =?utf-8?B?Z3EraUlVaUdkODhiNVpjQldiOFQyWlMzWmlFUXdod2dOWDhRWlovRVlVTGov?=
 =?utf-8?B?alJCd3ZKU0o0TWJGWE5ETFhjbTVvaTA0K3c3TDJWRTJyY1VxYmhVL1diWG1P?=
 =?utf-8?Q?6roNDaXdsYxMeWQKam8AGYejqbTSQ0qpjn7hQ6HIP6dQR?=
X-MS-Exchange-AntiSpam-MessageData-1: yUv06uT6wvdHXg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce66a2ae-1310-4b73-f200-08ded8ed0912
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:50.6897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9nov9WdLZtiilhs4ANlvBnvTLUKXHdP/ZFSOVDjV2lwBLnvuDqPYy5vR1NPC4miPz/7zJV4GBmh408FYB6C1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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
 drivers/gpu/nova-core/fb.rs     | 14 +++++++-------
 drivers/gpu/nova-core/gsp/fw.rs |  8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 5ffe66af282f..431828cad1a1 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -183,7 +183,7 @@ pub(crate) struct FbRanges {
     /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
     pub(crate) wpr2: FbRange,
     /// Non-WPR heap, located just below WPR2.
-    pub(crate) heap: FbRange,
+    pub(crate) non_wpr_heap: FbRange,
     /// Number of VF partitions.
     pub(crate) vf_partition_count: u8,
     /// PMU reserved memory size, in bytes.
@@ -272,9 +272,9 @@ fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
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
@@ -285,7 +285,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
             elf,
             wpr2_heap,
             wpr2,
-            heap,
+            non_wpr_heap,
             vf_partition_count: 0,
             pmu_reserved_size: hal.pmu_reserved_size(),
         })
@@ -302,7 +302,7 @@ pub(crate) struct FbSizes {
     /// WPR2 heap size, in bytes.
     pub(crate) wpr2_heap_size: u64,
     /// Non-WPR heap size, in bytes.
-    pub(crate) heap_size: u64,
+    pub(crate) non_wpr_heap_size: u64,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
     /// Size reserved at the end of the framebuffer. This is architecture dependent and used to
@@ -323,7 +323,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
             frts_size: hal.frts_size(),
             wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
                 .wpr_heap_size(chipset, fb_size)?,
-            heap_size: u64::from(hal.non_wpr_heap_size()),
+            non_wpr_heap_size: u64::from(hal.non_wpr_heap_size()),
             pmu_reserved_size: hal.pmu_reserved_size(),
             fb_end_reserved_size: hal.fb_end_reserved_size(),
             vf_partition_count: 0,
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 3b148147cb18..5a2fa1a4a495 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -242,9 +242,9 @@ struct WprMetaFields {
 
         let fields = match fb_info {
             GspFbInfo::Ranges(ranges) => WprMetaFields {
-                gsp_fw_rsvd_start: ranges.heap.start,
-                non_wpr_heap_offset: ranges.heap.start,
-                non_wpr_heap_size: ranges.heap.len(),
+                gsp_fw_rsvd_start: ranges.non_wpr_heap.start,
+                non_wpr_heap_offset: ranges.non_wpr_heap.start,
+                non_wpr_heap_size: ranges.non_wpr_heap.len(),
                 gsp_fw_wpr_start: ranges.wpr2.start,
                 gsp_fw_heap_offset: ranges.wpr2_heap.start,
                 gsp_fw_heap_size: ranges.wpr2_heap.len(),
@@ -263,7 +263,7 @@ struct WprMetaFields {
                 pmu_reserved_size: ranges.pmu_reserved_size,
             },
             GspFbInfo::Sizes(sizes) => WprMetaFields {
-                non_wpr_heap_size: sizes.heap_size,
+                non_wpr_heap_size: sizes.non_wpr_heap_size,
                 gsp_fw_heap_size: sizes.wpr2_heap_size,
                 frts_size: sizes.frts_size,
                 gsp_fw_heap_vf_partition_count: sizes.vf_partition_count,

-- 
2.54.0

