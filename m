Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24BBCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357ED10E4C0;
	Mon, 15 Jun 2026 14:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jgBbeH+2";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6232310E4C9
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfPdP+pkYNQc+Vd44z43bRzbm66K0zviseS9bvSbI1uMuGpRgE6cfY6VxNVW4RB12ZeR3piVx5KKdPD/5mGd+dbTTclA9rNfxqlQXawl8LKsdrRpklz1qknH91Rglw5/B5hjipZyPPwWQEDHyf9Pz6LfKLEQl+zW7HdlExtNgIqOvLTOMkc25l2GRvanygwO50ccSrrAcZJwR+xichgAZERvEx6dqqSbQcxoD/FiHmQfyfLfnDNm2L7uuO9yvpKtxSagfjwsz6MdGWhQf2o0H+sP6cp944XLNrQ/N+ZV3jEXOuPocgJrN60v0NJUr8x4NN4lY99nzktLycKLE0RS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1OcRMIWioTOLU+Zp4UtrVvoiM61Cq4w3w9XHpzYyAI=;
 b=rHT7VQRIIm2uwx2al+SwPD8rUoq8mhny0FLH55DXoxjadS5JU3JALAA16kU9HcekX1vUm/VZyp0o+TmW1y2mMHnvKdLFpHBOoeow1JjGVCoiya4XLKWcxsGDg8MvzhFF28t0HWP24A5PjXhtlL60sDsrD7K3nMVdEOkE55ekU9+Lc3RiXorEWe98e8KSaNqqGApO+3sJT9wJiJbB33zinjn74Ni2YJLSBl3/yMPEZn0gtrzNzAtvbClydQONsRMj9thZNJCR7F9zS9HAG8caKlrjblDKrJ15PKRiPkE0KPJp8L+dQ+LNZdfJyubiNzmcpNLWBvPu06+gwB1oFzdPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1OcRMIWioTOLU+Zp4UtrVvoiM61Cq4w3w9XHpzYyAI=;
 b=jgBbeH+2iXhFnzIyoGx7IMMOw3xEHzb7lwNb0dR8jLRptPGG8OQDjKgih1hNRfSZ0w4Gl1TjxKmeeASuJyo2VRTxgcdnZ0ZJP6MCVK12xgQDhCxUWDa/QAhoN4ayKzwU3W4tgHrU9WdHJuHTrotm1pdIKhJ+ZDf8ispPWLYQ3owJhrvm6ExUngZinq6oMR4rrYlq/OtTh3NWpiEdbBWEwrJga3JmXSBNqTVDMXoopOq25Akz4W+7+pGM7XQ6pbeReln3wd8eJeN1BlstZ0vutNTrPZlIcfqCHfDgGxPEzgRttjiNpOyHM2Xr/7WrJxtvHmUCSTEwdzX3aZ1hVdHZAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 15 Jun
 2026 14:42:25 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:42:25 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:53 +0900
Subject: [PATCH 13/13] gpu: nova-core: return non-WPR heap size as u64 from
 HALs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-13-f2853e49ff7d@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8cd150-be40-4825-e2a2-08decaec5107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A+9aozrwyYMWO6afQKS6JGb/McFp/gqbIwaMEZnzUQy+jOEcjDY7nSjw6zQ9N01d1LGJMrdHKAjqDIrCXQHk0xhyd/tjIKrWVH3ANWwJeiLaROuWEqOgnEKegDwP/mZPKO00N9XbgR6xN65RSbhfgQ701nFE56YwSMyOsruKbppEQP/FdzJr78TEva4Je+G7azVEgLJT+tWFmW3EhdfjSZ836FDubUgXxJ8+jUj9zVkI6g21NEsxpn4Vx3shpLPv0wu/qfdO9mLih83dRNlpwToWuCwNPZWDg5vVHp4esOSy6qglGNLwO8RFElK6hDcCyA+Svs+zrqoeLZDUmvoV6i8/6LUeCHnO2rEc7uiF5jJy0lTO9LOvqFYuhTGUUyphlttFUU53Ps429u+iHOTD8T01MxqFdaWWMInjYcKcel3EED4p2gyCtprasmlniCaH/iOFpGC4KzO+JcFPtBeWdMXYjxrV3r0gEyqGJW6yYFbaCMCRtaVuIcf6klV9iI+PfBC1NXlzwHFArZarlEXkGlHqwecv2CRHi4lJnZWX0dMKv4zNgIqzu/GXn2VM3NXEEI2geBRPSSGLSL90A3xUbyw/pSePh0aYzaeLmnQ3yG0Wg/skRtt7B2YSOcl6AKbbdqUlwhZms0+rNb+rd0TIqwKk7Qld+XS1qiXeNNkUG+F9e94ekYsYoU2ndM01Os6u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elY1L2ljYVpNak1najlPVFgvdzNXSkF1ZFZuVDBkZTR3N1FqeHg0OERwZ0V5?=
 =?utf-8?B?Q1Blb2pZeWJacExjSGdka3ZmRUFxWkRPcXlQcjJMQ1U4cEp1cnZwQjVMSUVJ?=
 =?utf-8?B?SWN3MFE3RTl6Ly9EVVM5N0ppUjE2K2J1RElnb0p6Y0hMQmE4TDB2aCtiSDdr?=
 =?utf-8?B?Q01QZjRKcjd2elhWbWNTWklHZlN2b0FFV2RGYXpiWHc3NmN0dTBKL1RNOTNq?=
 =?utf-8?B?M1ltS2E5R1B2aTJuOXU3SGdvM2gxSlh4cjF1T2IyVzl5d0w5Tjc5UWEvOXF6?=
 =?utf-8?B?UXVZU1dSRHJiK3UwSHBvdDA5eTlHdVVuREdUS2lDc3JUQk1ZTHhRWHV3eSs5?=
 =?utf-8?B?S1pmdkgwY25ZZzQ5ZnNhbVNYQmE0aER4NEJSdXd4am4wL3UwRDFhallQcXpK?=
 =?utf-8?B?WlV2N0w2d3JpRTVRVUFUTlFKVENHOXBoV1VYRlgremJzZzg5amFPRmt3UTl6?=
 =?utf-8?B?ejBkR3JON01wUGhsYkc0ZkxNb1RmSXpPcHpJN3F5WGhWcUs0TmswSjBBaXFO?=
 =?utf-8?B?NFZIaUpEMnN3Q2NWWmF1VmJ6eHlpNHFaZ096Q29neDQzNVAwWHYrTnRZbDZz?=
 =?utf-8?B?emNGUjZFa1VPMWhYWUZGQkVKM2VFaFYvZGlvU0V5Y25lREduOUJJZldEQkJk?=
 =?utf-8?B?dkJtSnhRZGRaS3FPTjBYSU5CS283aHRUZ3orQ0tRUlgzMGwwMmhoZUdSTWtu?=
 =?utf-8?B?WlZKc0h3NCtOWjRob3E5R0cxVnU4Zk1yS3RGK2I5amFUUU9Id0VHNUsvRDRC?=
 =?utf-8?B?eXVFMkcrdE9qa205ZVZ0LzZXd1RSL3NINEd5MVJWRmM3UWtJbTMyVk4xSGpi?=
 =?utf-8?B?RnF3Ni9UZjZDRDNSYUhIRzI0TU85V0x1UFZmN2F4b1A4eXBDQnpOQ0tMd3hW?=
 =?utf-8?B?MkhLMnY0STNsWFprak1sbk1OeXFma2tUUmlQYUErMjlGQk9DRlpFZHpzVmJE?=
 =?utf-8?B?UExjUlhWLy9UZTVYUGlDYjBJcFJpWVNPV2RleXFmWG1jbmFrYTdQeVFidkpx?=
 =?utf-8?B?OG9wRE5tS2w5eXl2MDArQVRZaWF5UmVFZ3R6a2FXWHE5REFNMHR1QkNHQWNy?=
 =?utf-8?B?cEk3SFYwS2JJV3oxaG9CQllGM0tWd3VSSzZkc0g3cEN5M3I3dW9IMDdVbnk1?=
 =?utf-8?B?SG5qd05EUmNZcnNoMlh1TXlZdlE1MU8rVEk0SkQ0NEpOSFFJR0IxdG53YkRW?=
 =?utf-8?B?VzEydGhuVG5vakE1eG9PTUoxaER1amVmYmhOQU9HT0puLytydDBweEo3WkVZ?=
 =?utf-8?B?SHhUMU1rcHFPZkxRMlU4NGwwb1VBbDc2eGVtQUJhYXlreXRpOXNvd2QvUUNy?=
 =?utf-8?B?ajVES3NyMjY1cldHOUJNeTNteDYyTzRCZ2tPbkM5Q05MNndnUmcrWGRKalZ4?=
 =?utf-8?B?ZkY0MW5iUUpEc2Z4VkpVWXdGK2hVOVR6VzIzamQ2VHFneUNvTXROc3poNnJK?=
 =?utf-8?B?b0dkZ2xrbGlYTFQ5YzlHdlF6RzFRdTVSOGxzeUV4ZUdnNHJHa29vd0RKZVFk?=
 =?utf-8?B?TmRjcXh4d0pwL3ZvQndWMEVuUGliVmUvT0ZvaGFhb0U2S2RiQzkvS3gxRktP?=
 =?utf-8?B?SjVibVIzZVFhSUc5cUZsaTdLRmtGZFh2S0IrUytEbUtOdldHenVLUjZKcGxZ?=
 =?utf-8?B?RExxeE1Od2tmZFB3blNOd0hYMFl2NW9SMVJ2YlZlK1QzeEMxK281ckozM2s3?=
 =?utf-8?B?OHlKSU1LTENHeDUyN3VCU2JBMnVuelY5UGVNNGlvSjlMciswakk4UlYyejFo?=
 =?utf-8?B?cFQ2a2pQbU1PWUlDVlhYRDM0OHBtWFZSbjR5bFpKUHFqVHlwL0t3SFlDcjVh?=
 =?utf-8?B?anZLaGd1RnBhdjlaWnNEdFVLMEcvYVEraThiQ2I1anFUc0czaDZKTlE5YWxw?=
 =?utf-8?B?amZUZzRzYUVNVGlIMWZ5Z1czdUZTbndYelk5bE9TUy9mbWRtdmt0L2dMNUY1?=
 =?utf-8?B?Z0JMaXN3djVaYkRKOGZRNkFjODJ6ZE0rMTFkN2VYUjljdTdSY293NmFDOVlQ?=
 =?utf-8?B?SUtuVzAwZ3B2ZWttNVZUQjJhSU41ZjJHTTZrSStPS1dXcTBXQWYxck8reXFK?=
 =?utf-8?B?NEpWL3F3Y1Nnc2ZneFlDWUZaWXJUT2FUTWR2UTBTbVFqY1d2U1JUd3ZVbTdB?=
 =?utf-8?B?N0IyUVRTMHFyNWZGTHhCanlGaytpeHY1MDJyclg0dW45UnVFeHVBRzYybGNh?=
 =?utf-8?B?Smp0RHpyMHA3dkxsZGR1dW1pT1Y3b2kwY3dXNFJ5RHdPWVlNNDFNL0UwclFj?=
 =?utf-8?B?MWRkRDg0ZnNWRWhWYTFla1R2Qi9VdlJ2cm44LzBOYzFFUURhYmxTS1hKTXVW?=
 =?utf-8?B?bjFjNkw2a1VZOGFIVXk0TW9ZTWswRlJpSTE0aWFXOUtpWGFSdC9XNGp3L004?=
 =?utf-8?Q?5y7A6Svr9ygjBzqkg0VorvDIDnxpA9TEcG2sccrjPJ3PC?=
X-MS-Exchange-AntiSpam-MessageData-1: EER9DtQN80VmoA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8cd150-be40-4825-e2a2-08decaec5107
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:42:25.6061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBLltOShjEMMBIJVy6CH2TP+aq1NuOMPWGFOBgtY11So6k/vDhLLDtCmeEZF2xTC+MOXO0j7I3A+yTvhewMmpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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
 drivers/gpu/nova-core/fb.rs           | 4 ++--
 drivers/gpu/nova-core/fb/hal.rs       | 2 +-
 drivers/gpu/nova-core/fb/hal/ga100.rs | 2 +-
 drivers/gpu/nova-core/fb/hal/ga102.rs | 2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/gb202.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/gh100.rs | 4 ++--
 drivers/gpu/nova-core/fb/hal/tu102.rs | 6 +++---
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index ca831a36aedc..0829ef25527b 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -272,7 +272,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
         };
 
         let non_wpr_heap = {
-            let non_wpr_heap_size = u64::from(hal.non_wpr_heap_size());
+            let non_wpr_heap_size = hal.non_wpr_heap_size();
             FbRange(wpr2.start - non_wpr_heap_size..wpr2.start)
         };
 
@@ -322,7 +322,7 @@ fn new(chipset: Chipset, bar: Bar0<'_>) -> Result<Self> {
             frts_size: hal.frts_size(),
             wpr2_heap_size: gsp::LibosParams::from_chipset(chipset)
                 .wpr_heap_size(chipset, fb_size)?,
-            non_wpr_heap_size: u64::from(hal.non_wpr_heap_size()),
+            non_wpr_heap_size: hal.non_wpr_heap_size(),
             pmu_reserved_size: hal.pmu_reserved_size(),
             fb_end_reserved_size: hal.fb_end_reserved_size(),
             vf_partition_count: 0,
diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/hal.rs
index aa50534550eb..ff05292a3a19 100644
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
index ce544cbafa2d..16ef0e0d2c05 100644
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
index 82b4c6034c4a..8653d0d404d8 100644
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
index a53932eaf483..93fe708895c5 100644
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
index 1233df4303f5..e6b259fd72a4 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -81,10 +81,10 @@ fn pmu_reserved_size(&self) -> u32 {
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
index 892c75ef26c6..bb56ed15bab7 100644
--- a/drivers/gpu/nova-core/fb/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gh100.rs
@@ -36,9 +36,9 @@ fn pmu_reserved_size(&self) -> u32 {
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
index 8bafbeec9807..d98974827373 100644
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
@@ -79,7 +79,7 @@ fn pmu_reserved_size(&self) -> u32 {
         pmu_reserved_size_tu102()
     }
 
-    fn non_wpr_heap_size(&self) -> u32 {
+    fn non_wpr_heap_size(&self) -> u64 {
         non_wpr_heap_size_tu102()
     }
 

-- 
2.54.0

