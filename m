Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926B3CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8FA610E4C9;
	Mon, 15 Jun 2026 14:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKiHwfn3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A08E10E4C0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLh1ba9r1Tj9zDKLf3DLCu8q63+8ZWvC6mzqsL5kGqY0WAyWSvKsQTO/zLWciOt4/GhnLtRhMhMSLJOlmJaiu23z4GrToMatnZPiwO7szNTDGG5BCK43/Fyp74+RpJYWAsgFy7PEvatM5U2ECpGgytaOILRf0uTVlxyx5nzeAcbHy+3batMCjew+K/i+cxzdqBzYAb7DkUg85/2bW8QpMHqyPLDZTA0vj8BPxwy05uJglscNbvXXWydOsmVwnszkd2eoe0USiYraAx1XwGo5yYiqdB5vnLSWWfTLr16ZL0hRrgWF0lUEAytElinF3a8134AzeeiXWli9WzbZHFI3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2oNlxx5SjSPNqNH8kdKHOjnlNvzwmDiu0BZjM969lY=;
 b=IT0Z0/Lwf7M2kwA16TPI85lPw9xtk7OT7EDihmJruYmlcWvGx7jrUf4CXPvpp+M5/szeguhK6MutcjjStPzPBhgwNJ060dz8eanwaiTk+T+401mHntJzResuaW+i+T06CXrwSwumtEE9RiMituOGxtYD2rilKkzb71rdKXf18TW+na5LljSSoNgFg4kZfVh86nhby1etNjbXo6HrT8ntnc340sCTn9UZgc13GziHv0UsoFPgHc/ABaNVlRr0Qt6oC8NXH9GrTRQu0xOAk47M3BMUvwpHG7WSI4aelTukRX5xUyIT/2ed61js6JyouUZE+qW5KmleD1VoUwOCL3+cwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2oNlxx5SjSPNqNH8kdKHOjnlNvzwmDiu0BZjM969lY=;
 b=DKiHwfn30UQYXNuDzs5wlkZG8hvLUlo2zUQl+Wj0ZgaVjjIOvdzyG7aSogd7JqCidGyODlJ8eQFnz0Iu1QPvLGxQ0gMlSboH6HBZQ2cGiVpaQuHxSh0vZwVkFvFIvVP1HGPHI22Wj48e/D9RkeCry0CyNmuTE2u9M6jienBih0g5fE1Uvxs0q8gvZ+gXXzA3xOMRsS/BgxyKO3yV/OStom47K/d8RelUJlaALFvhf9Dv5uVN+7b+pDXIPgVCtJ+opcyR6pCTuORdEuvJ6pD+0rnC37725lfMh4HRccQJgMhnQOfwVkn/USxRbO6zk4wyce+k9hPznWd3/6XJJoasfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:42:22 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:42:21 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:52 +0900
Subject: [PATCH 12/13] gpu: nova-core: rename heap size field
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-12-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: d0225d8a-27f5-478f-e5d7-08decaec4eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Wmjo88M7ftsIaaZJTjh5csyc52gG/3EzWNrJ8pXalK4h8Rk6veqRyEHGVcia0hUhgVt3uN2yH7Eja6debIZpKEqn7YsNdtAnEc3+KRTvkrBEFewbbkSUC86zvvxRGNT6prP2PLUruvLVgB0Ywap1kwW85g9Wfs0WbUTmIYb0Jbdna9C6O0cvErsoh0vUVsyOVsEUYgGE3zFB0dXGXjrm52bOYPAunpnMsBGSQ1VECqdaFqPiGbFa353XAGs6dHI+KmO9/6jD/vplV0vxW3jOsP49nDrV1lqOhaq/RmCi96bq/v6t/mXIlHC7OMzWn0gj4RsWaUtI5k51R0IxF6QDeqn0oKvVchfolcVSHnUDNu9eD8xTe13ZdH5Is419e4j7IIcAi+hfmqcFVVIUhKur+VoTpN0DTU4eoH5eaenJSt21HDFR0wqkvI7hkoxPP5QkiURhokxIlLEgvVowQdsj8It4cicP10iT9+7ntnBK8YjB0pqjVquk6xPKrhlNhhwmt/e6NLYnLnWN0XvONvam2HbU7chvAKlBzjTGy7dPCy8hzMLc50VyoFf7tEE/SM3OAbuaXX0cYGWsOHB764lxw3E0ZJP/kFdn6nDMu94P6qxst0jVypNHgY0DJrOI6HyfyJujuJZRQMbQDnGXxn1KASWFktQjr9Zvr4NTNRyy/ey7iiIlflj+yhfkGDUuIKh1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3k3SC84dm5xWWVidkM4ZDc4dzFWSXZhU016RGNTNzJNVzBLR2FtYmx6czVV?=
 =?utf-8?B?QTNxMzlnclc4Y2NMdlV0dXlVMFJiL0VrMENpOG13OUJBTWVoa3VVQStWejFv?=
 =?utf-8?B?dTBxd2d6ME9vczNqNlo1dXJGaTdpTmJlczZTQUs2YjRjV1lOeEVUbVN5VXNQ?=
 =?utf-8?B?OUI3N1QrNEdtKzM2cmw5eWF3WTJENk9JU3JCVTJNWEZIeHF4K2cyc25DMUxL?=
 =?utf-8?B?bldNSURlRnhIRncxc2E3WW1jcE5ZMjZQVSt6aTRNMHI2S25yTEdTeWpTQkVj?=
 =?utf-8?B?RjR6RmZQZ1MrRzVXc0JXdVBjeGtlTGJjRlh1Y3ZzNkY3Ymttd2xCNlBHVzlU?=
 =?utf-8?B?SzZBV3VlQkpWSEYrU1hsVHM5VThFc2pncUdiMFNqMjRzYnh1R0NqK0c4aDAv?=
 =?utf-8?B?bUN5V09GT1d3czYrVDIzTUhuV0x0dHJnZS9rRHJxS01heWlGT2FNdkUxV0tk?=
 =?utf-8?B?dU5ZVHg3djVNTUpGQjVPZDk0VGRKOXh2TytneGxPTHIzRWxGSkV3ZFhocFQw?=
 =?utf-8?B?Qml6ODRlL2tZcThZL1lUUXF1a1haTEdVNitxelNGZnRCZXkyTkc5SWw4VVFi?=
 =?utf-8?B?bnR5L0RuQ210cGs4dk9vWTJaVlVGdE9Pbk5WWUhLK3c1QklCQVVSUG5QV1kx?=
 =?utf-8?B?b1F2dzV5blp1bm1qNzJ5MTErcWhWSGE0Wmd1VkoyVlRxTTdsNUFyYjk1dGV0?=
 =?utf-8?B?YzRGRmZWN21wcnBpeCt3akplaG9rNll6Y0NvYVNUYUhWZEZtcG80Mi9tUDJN?=
 =?utf-8?B?bVl0WVZJOFowTDQyb1VxYkNyZ2kwWENHR0tWZzVKTHRNaEhRSG12c2daSVFM?=
 =?utf-8?B?eitSb0pTYS9KSUhKTEVjdUwyNmRPS1Z4UXU1Q0VEM3RCZkFIMkc2WmUwRUNM?=
 =?utf-8?B?VElPNDM3YXVGdTJiOW85L0xjZCt5TXNCcEhVTDFtK2NCR3lKMVMrd1RGU3Bi?=
 =?utf-8?B?K21idzhWeFNpTnNValhIN2JJMzVwTHJHY0dRejFxd2pJMEtZeEpScFBmNjky?=
 =?utf-8?B?YVNVOEFlM0ZZK1dMSy9IZ1poVXVKM29VaDJKU2NPbDY1MUU2ZEpza1lVOGtD?=
 =?utf-8?B?MVc3blljNUZjVFRNVDVHcmdSNkovSStWWmJ5QkFKOG9oMGpkZzdka2pYUUdK?=
 =?utf-8?B?dzlrb1YvNEs4VXF3Z3YwY0MrMzRtTmtSYjhsWElramZrbnRJOUdrc1JNRG9S?=
 =?utf-8?B?Q2s5WVNpa2F1NEx1UU1rUXhyMVhTZW9OeXBMR1IvRFlQcklWajh0WmhiTEJQ?=
 =?utf-8?B?SEhVdGlTczBDZnc5VWRuUXlBTWFFY2hPR1dhMzVkdUF1bFNaa0RsUEpRV1VF?=
 =?utf-8?B?Uzh2VmY4bWtvNTFvaUxjSWdwUVpUK0drdG9JZXFZUnFJR1RmR1Y4OEFNSHlB?=
 =?utf-8?B?ZStjd3RVMDA5RjFRWEF0aTJ6ZkMyQi94TktzZENMek9OL3JlY1l4S0RBdHRP?=
 =?utf-8?B?aDVqMVFwN0h3bThHbkEyR2diWUxxZU0vSHhtcHJ6UDFSd0IvSUhTVmhVTGtC?=
 =?utf-8?B?czBlakk0Q2hEN2RIaWNYSHIxWEJhSU5vRDBNOXVhL0pCVnJ2enM0NEZSbUxq?=
 =?utf-8?B?L3ZCa2FWNGRXdTBZbXZzbnUvYW1SdnJLM2dsWWQ0RDdHV1k2T1UwVGoyUmc3?=
 =?utf-8?B?bmJSUjEwTlRrVkNiaFlSNCtHSnhhY3k1WVpUeUFOQXp1bWg2V1pJWUVpdEZ5?=
 =?utf-8?B?Z0I2Q3JhblNwUTFKQ2d6b1NDQUtQYnJIOUJpQXVUVEN1R0EyWEV4MVl1VjFR?=
 =?utf-8?B?N2Mwb01ZZG1PRlpncWZFMFVDNllFeU41dE81VW9uYmF3VXQyUFk1dnllWnlW?=
 =?utf-8?B?VFBKMS8yUWtlTHhTdW9LVXRHa1RaSnlJbW1TV1UwYVkxVmNVN0JWWGJpU3RZ?=
 =?utf-8?B?M3FZNWlTeFdHK1BMYkZzdmhnRFhYdHdaUEo3d0RYR3FaNjVnMTB1elRlWFdU?=
 =?utf-8?B?d2ZkNVJ3Sk9RNFdvSFg2Y2dybG41YXc3NVlwVkFNSU9NakR2UXowOHBXaW1W?=
 =?utf-8?B?ZGpXVDEvRHArS1QzZXloYVMvNzZsYnJBanRyOFBHdEw5VXJyUUkrMHRYbWl2?=
 =?utf-8?B?NUsrUnF5Z1RKRTQ0SUxwemJDdnlTNU9MYVNMWGR4UFZYcHVtVXdsd2x0M3F1?=
 =?utf-8?B?ckM3dEpmU3p6MktYU1IrVWd1aXA1YUhzZkJsMU5TeUQyaXBwdmxOSDl5d0dX?=
 =?utf-8?B?QzF1ZDZDRWlqbVZXbFVLY0JmRzZIcVNMTUpZOE5LVks5NGt5b0xsZkVKWU5w?=
 =?utf-8?B?TXFTalNwMm42SmlwVUFmY3JTZWRrNHBTSElkMDVuZlhMN0tWU1BqMnAyU1la?=
 =?utf-8?B?b3FtNzhrTS8vaUluc0NHdTJSMjVGWFZ6YzlzTG1vWnBDV2Z3VDBGUG83Sk50?=
 =?utf-8?Q?vEr+7wjLAsSVgFK7GTrQkDY8xT/zBlbe3v3FKKdT77jLf?=
X-MS-Exchange-AntiSpam-MessageData-1: YWHaN9R54Pt3CA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0225d8a-27f5-478f-e5d7-08decaec4eb3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:42:21.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDxnQaAZKDoVUBn5hCxRYiEgPpSNxFrbTAuR/U5lHaZHNaWUYfWszUZN2O6D5exG4Viomg53tpbgi8AD9sbspg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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
index 2089fa1d7a22..ca831a36aedc 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -182,7 +182,7 @@ pub(crate) struct FbRanges {
     /// WPR2 region range, starting with an instance of `GspFwWprMeta`.
     pub(crate) wpr2: FbRange,
     /// Non-WPR heap, located just below WPR2.
-    pub(crate) heap: FbRange,
+    pub(crate) non_wpr_heap: FbRange,
     /// Number of VF partitions.
     pub(crate) vf_partition_count: u8,
     /// PMU reserved memory size, in bytes.
@@ -271,9 +271,9 @@ fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
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
@@ -284,7 +284,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
             elf,
             wpr2_heap,
             wpr2,
-            heap,
+            non_wpr_heap,
             vf_partition_count: 0,
             pmu_reserved_size: hal.pmu_reserved_size(),
         })
@@ -301,7 +301,7 @@ pub(crate) struct FbSizes {
     /// WPR2 heap size, in bytes.
     pub(crate) wpr2_heap_size: u64,
     /// Non-WPR heap size, in bytes.
-    pub(crate) heap_size: u64,
+    pub(crate) non_wpr_heap_size: u64,
     /// PMU reserved memory size, in bytes.
     pub(crate) pmu_reserved_size: u32,
     /// Size reserved at the end of the framebuffer. This is architecture dependent and used to
@@ -322,7 +322,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
             frts_size: hal.frts_size(),
             wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
                 .wpr_heap_size(chipset, fb_size)?,
-            heap_size: u64::from(hal.non_wpr_heap_size()),
+            non_wpr_heap_size: u64::from(hal.non_wpr_heap_size()),
             pmu_reserved_size: hal.pmu_reserved_size(),
             fb_end_reserved_size: hal.fb_end_reserved_size(),
             vf_partition_count: 0,
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 042b0122e98d..0b94202a7e2a 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -241,9 +241,9 @@ struct WprMetaFields {
 
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
@@ -262,7 +262,7 @@ struct WprMetaFields {
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

