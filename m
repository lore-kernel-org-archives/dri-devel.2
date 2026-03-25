Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB6F103A9A1
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB38010E6BA;
	Wed, 25 Mar 2026 02:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUYNb0LP";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D3810E6B9
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvHA89TERTsK7APRL6p8LJi3B/mex+0zgxYXpUKI/I0pqG7xLfFbV32cL+FpiYWPUN0s+SI6AtnNDaudK9Fx6+E0sYJDt/Jqrd21g3oENmGtc32huM7MizLpU5QA3kiJtOQr7KLMm4m9krcCFwhNiJBG1dpvUKyylkWuLzBmHaWbqG9cqv5Dl2N1Spx07B1kSMyguYmNbxZDLsvjLx7F7DEbJWyXvUGUGHPPuWYF8ysdVhQJcDjfgzr6Sr/p4Dp17/Z4QskbY02E/mcpLlCvPoEVh2PtjAbRV9ooo1OPbwspaXHaA4xWqi7QOsVgFQoTF+jehzPnKeXoRYUPDkMQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njKVJzFsnGP+sjNyJ2knpbzHaLUkKatE3tX4O5dIiDU=;
 b=lcB0vi6bsaKE4/NfGxsAdGBgqb+tDRrXkJrH9JrWBwwUym6ym6qt+jFC5HnhCorsNZRnd1t4BCiNhBcWKqsNoLSNsOdkM8m99jyUKmd64cUMoIxR5dtl2w1XXA0g0QncDUDNDJ1LAK+FsaZRmJvN6xPUad03Rf4iBMHZ3IuUaToIGNTpMVSs9oDc59nYGq3APlM4WfTzHuxP0Z2pCDnLXi5TU4zR9QgXkWuE+cdaENfCW2WIvpOD91j5YqVb9BlRqlTUKIYRJClpbrraGxhwa4L2VC4+YUC+ZK8bEucWjb7gKEusD8NT9gu3KHzNhwTzmFp8Vd2blsR1MYJgLcdwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njKVJzFsnGP+sjNyJ2knpbzHaLUkKatE3tX4O5dIiDU=;
 b=dUYNb0LPLQspTGhhRSCEBWgLdPb1dcIHgR0Vog195m36esLAiGW6fq9onljveSGe1cOz44ydDHu3gttzKelADQZiZ1ejyJmpYTPiXmvAgfwBMm3uRue53DwKvnGWSRIROUo1/Lre0vjahUyyV7ty0+MAPDGjfdzNeGnVzDOmtlboQco2Tj183nN7Zgj83/CO2QSh3OHsust58XAXHSZiVmSnRXbhtXlzEEqWwO6mUpw9FjW31OA4SiQ/vIpjptWNA/ajya4WLuKWF9OF9ErfdBifpCJo62yuGTJ++mBA3RcyGBanR5+glG2nlEQKQ+1rXzvQTlifcOaW/hahu7/Hxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:46:54 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:46:54 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:18 +0900
Subject: [PATCH v4 05/10] gpu: nova-core: convert GC6 registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-5-bdf172f0f6ca@nvidia.com>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYWP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c840cf-c63c-4054-b4f8-08de8a18c63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: NaiegoRvABhhBjFYB2yOMkCLcBs/+X16kmaTDchYeGCEZrp0sSZanuy6b3Kxc1XXMRVHcnCM5vrUiAgU94AEzlmkC5Rf2d3P1fhGBC59UglL+BWiVfHAds4WO8t3joAN4I1yiJzqf59X5HrG02YYYT3ijL22YmdBF0OshiUCUHagUfXVn0nn8HYO9x13LAXPlfR0mxq8vpS+OcC32RoEPTjAbriglJnJAErMWtbCmKJfn9GaFwL1dapBUPjOPW9SSYHRoiWG4/NJ9mYVHzRWgyvIxhIK5utD5O+RrvlS+BH3uk4b5IaJ+4TwU7o8l4YNQdOuDdJMPvpYpcnmdb11vFJDv5uIXet4u9gNs7YZO3QYhJVJ+fUCuN8ROj81ooAidhl96oDc1GO/ngUHz4NsAiSjivlZ4HcXjNp3pgoK41n//IX/iyO6RGeFy5gZYK66V6EB1W+82N5BAzGcEmZ5WV9SJyaekil53ZdfqhfWaLjHkyS62MuJKYp/yRO04hCtmpLhkeIQZg3S1ejDWgXjK/tpzXvtIWx4Fm9cpV5psKKRLPtnCQLPPZ87YRaQsOpPfWgBJkPa/MThAYHXBIORUMe2AeTg1r5aNVd/zdHOOTwylKOnaZ1GX8d3MhcOXg8oOlptCJHS4W4mMhE11Vveqksr2Pu2hFvQ2MPFoy5NtZZg9J3WVtgL5i8CjF68ryhEUqZtUzILJMM63z2LsypouQ2Q8wrKpTh8Xc8+YpbkRvGVqYDeD/aaDCFALb24ZgqF/GC+e8AX0X3CkmtwdMcdIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0NBQ2hXVGV6enR3eWZHWS9NSDV4c05Qa2pLN3I1L3I5cm9oalVxQ2xXUU5P?=
 =?utf-8?B?Y0x2SUE4RDFKSjk5YlErNzFtdGZJbFpDam5ZeVplcGtWVGxOd3NMY0djRDgy?=
 =?utf-8?B?bDNoWC9OeEtRenlBSXVNd2ZRMVZKMVpiQWNGc2hQYlVnU1o2dW9jd2JjOEsz?=
 =?utf-8?B?amNtdk5RSWdKMk5UQnkxTWNoWnlSL05qRVFCUmtNU2QxL2JGNTBOYjZEdjl1?=
 =?utf-8?B?WUF3M2NqeXhDcGwvZDVRWjd0QmlRZjYxU3oyT1hxb1ZvamlVOFpBKzRyV0FL?=
 =?utf-8?B?ME1Qa0hOQzJObXJHWmZLYUdrbG9FWmkrd3QzMW82cmdaYUt0SzNNRzB3Zzd6?=
 =?utf-8?B?SDF6eC9QTlR0VU1CdHdwRzZPQ1dKU0NQOG01b0VNZ0NLNTZOZEZyTndGelZt?=
 =?utf-8?B?ZkxkQ1JYRmw2Nm5lKzQ5bHA4MlBZQm9YVGVzZFlTK21YYmxWUEVtYzBWM2dh?=
 =?utf-8?B?bVFGVjh4TlhVUk1QbVJHK0tuTG5sTVJTbTNHS1VHZy9sWlA0cUl2ZkQyQjVo?=
 =?utf-8?B?ZHltNElNaDhSbmhQZG9HbWpUMml2aERscmwxT0J5UncydHh4N2tBeUNMcEIw?=
 =?utf-8?B?Ly9qb2VhZk1DNUJuVzNRMHVUdVd1RGV6OHFhMVVQWS9hUncrYjB2MXh0cGtu?=
 =?utf-8?B?NEltNmZBNm9GelpFekNYQ21FRU91NWpSSHNJNGtaaythTGc4VTcvVkNyekpQ?=
 =?utf-8?B?ZHZ0QkVDVHN5ZjRHRmFvSDdudE1oV1plaWRnK2hOM1Z6Tk9jSTRDUGF6NWpX?=
 =?utf-8?B?K1kyR3pVUW93aXR5MkM5OEk2cGYyNUtIQ1h6UG9xRmdrMysxenNMblhLNmpp?=
 =?utf-8?B?aEk5UEhPUFRPTUVDMVE5eVJLTDV5Y2lpenhkTlduVVlvTlRpeFdpamhrc0Za?=
 =?utf-8?B?VmtLMTZHZlNYMFEwU0ZrNkZWcG4zVkxZbnR1MzN2SjlleTdQQUJoUkZ1a0E2?=
 =?utf-8?B?L2s5OUIyUXdxZXFIdVBZWFoxS2orclp0QUlDdE0wWjhhSmcrNnVaS2xscElW?=
 =?utf-8?B?OVBVcEV5ejFzRVFFWkp3d0M0MnR0ZDF6Zm5hdERiRHBJQ3NrQy8wOVNUSGdr?=
 =?utf-8?B?V1BGamQzbkczTGJVaGQzTmw5ckp1NWRPczV6c2YwNUY3Mkh6MTdXaWF5Z3RU?=
 =?utf-8?B?WWl4b3orMVRZckF3V1p6emcyakRsZDFNbkVMSkcwUXJINWd0R3FyNFZTRVd2?=
 =?utf-8?B?N3VYL0U4RVdoWUJ0VDhseFczdjZQVHpBL3l1czg5K3ExemNldFlNeWZsV1pV?=
 =?utf-8?B?ZlorcXZsZmZoYnlvVEZSNlZiZURPWG1nL1EvL1g0cXpkTXdEYmtWY3lseFhF?=
 =?utf-8?B?NWtGUnY0dFROWURtQndEU3NRQ1ZzVCs2TGlvTGo1RDltRkkvRitWV2IwbXM0?=
 =?utf-8?B?VmdqaDVUNDUwZFBsRHkvTXprczhXT2dvUHE3R2hoaWdJY2dHL283K3hmZ1Ev?=
 =?utf-8?B?TzJQUUhzVGptYWw0NHo3a0RGK0hiQVJTSGR0cFZDejF1ckFRQkdnSlpGTnAy?=
 =?utf-8?B?alcvdTBjbUtocS9OUFdrL05rOHJWNEgvK094d05ZK0ZtUlhSNkYrVFBvRnlx?=
 =?utf-8?B?TkprTlJLS3htVjVudXNIVklDUjRNNXpBMko1TjhTeDJEOXFpaWtQei9zL0Ex?=
 =?utf-8?B?dlFST0dxSzNWVFBOS2I5azB6UFRxY0lDcVBVRWVQUFMrY1lJdlQxVkRqdkNP?=
 =?utf-8?B?c0YzVEx0WGVDbFFJRDY3RmVwSjJnZXVJb0xHZ0xDcitnTWFTQ2Z0aWIwRyt2?=
 =?utf-8?B?MzM2VWl2VEpvTUZEOW93NmNyNXFnTHJmTjVXNmZkTFBTS05yYlFBcmZwakZW?=
 =?utf-8?B?SGQzcENibll6RWNWdkNqaktJQWRYSTFGNlRqcllyUURZWHJRaWorQTZzb2RG?=
 =?utf-8?B?UlpMeHl3Sk9KeFFkQXlvTlpuR2Rkekt6VUYyS1JDSmhuL09YdHpoQkh0b1Vo?=
 =?utf-8?B?MHIyQS90eDVveUh1RkFlSEtRT3RzTERIL3FZR01MM0VEL2daMHBDazh6TUNK?=
 =?utf-8?B?RWpZZEloY0ZlRzZ6K0x5VG9ISEs2bjRzeHQyZDU2bGhTb0NEMDAxWVJsMFBO?=
 =?utf-8?B?YTY5TzQyVFByKzVMeXdsT2RiQmRSSXU0cjdRRFBGSkYrd1ZmUEpCcUhIVHM0?=
 =?utf-8?B?OTFZclorY0NYa3pRTWp4S2ptRHBaSGJQZWk1V0NIOXorOExIQ0tQbXR2T0tG?=
 =?utf-8?B?eTF1NUtNVEQwdVJZRk85bVlmT1ZKSEJXWGJqMW8rKzFnV3ZTZjI4VlhRL1Bt?=
 =?utf-8?B?YUJ4OGFPRXBVSUN4TXo1c2dIMXNTRDRhbUJHWUhTOHFWNUxqTHdzWlNvWFRL?=
 =?utf-8?B?RUZaUmJwZFQ4dFlyQlpGTTUyaHBpaHRQcm40M0JqTFg0N3hyZ3F5cDdadGIr?=
 =?utf-8?Q?KSxYxUKJS0LYbmbklHeTs3uci7PAYDkGcUivn00L2S4pm?=
X-MS-Exchange-AntiSpam-MessageData-1: yAr5ISrJk1xzBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c840cf-c63c-4054-b4f8-08de8a18c63d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:46:54.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKduZx8Gf6QDvOnUpCblDsKh62xEJE4Yr8oOibGDVI4KOdvCKrkKJeML90vrqGxuu+Obs3pqkV6IZoRHWHYh+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

Convert all GC6 registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs   |  7 ++--
 drivers/gpu/nova-core/fb/hal/ga102.rs |  7 ++--
 drivers/gpu/nova-core/gfw.rs          | 11 ++++--
 drivers/gpu/nova-core/regs.rs         | 67 ++++++++++++++++++-----------------
 4 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index 67edef3636c1..e52f57abc223 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -47,7 +50,7 @@ pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
     /// Checks if GSP reload/resume has completed during the boot process.
     pub(crate) fn check_reload_completed(&self, bar: &Bar0, timeout: Delta) -> Result<bool> {
         read_poll_timeout(
-            || Ok(regs::NV_PGC6_BSI_SECURE_SCRATCH_14::read(bar)),
+            || Ok(bar.read(regs::NV_PGC6_BSI_SECURE_SCRATCH_14)),
             |val| val.boot_stage_3_handoff(),
             Delta::ZERO,
             timeout,
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index 734605905031..4b9f0f74d0e7 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -9,7 +12,7 @@
 };
 
 fn vidmem_size_ga102(bar: &Bar0) -> u64 {
-    regs::NV_USABLE_FB_SIZE_IN_MB::read(bar).usable_fb_size()
+    bar.read(regs::NV_USABLE_FB_SIZE_IN_MB).usable_fb_size()
 }
 
 struct Ga102;
diff --git a/drivers/gpu/nova-core/gfw.rs b/drivers/gpu/nova-core/gfw.rs
index 9121f400046d..fb75dd10a172 100644
--- a/drivers/gpu/nova-core/gfw.rs
+++ b/drivers/gpu/nova-core/gfw.rs
@@ -19,7 +19,10 @@
 //! Note that the devinit sequence also needs to run during suspend/resume.
 
 use kernel::{
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -58,9 +61,11 @@ pub(crate) fn wait_gfw_boot_completion(bar: &Bar0) -> Result {
             Ok(
                 // Check that FWSEC has lowered its protection level before reading the GFW_BOOT
                 // status.
-                regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK::read(bar)
+                bar.read(regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK)
                     .read_protection_level0()
-                    && regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT::read(bar).completed(),
+                    && bar
+                        .read(regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT)
+                        .completed(),
             )
         },
         |&gfw_booted| gfw_booted,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 4f5cd64c2fce..6f49467e78ec 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -198,29 +198,41 @@ pub(crate) fn higher_bound(self) -> u64 {
 // These scratch registers remain powered on even in a low-power state and have a designated group
 // number.
 
-// Boot Sequence Interface (BSI) register used to determine
-// if GSP reload/resume has completed during the boot process.
-register!(NV_PGC6_BSI_SECURE_SCRATCH_14 @ 0x001180f8 {
-    26:26   boot_stage_3_handoff as bool;
-});
-
-// Privilege level mask register. It dictates whether the host CPU has privilege to access the
-// `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
-          "Privilege level mask register" {
-    0:0     read_protection_level0 as bool, "Set after FWSEC lowers its protection level";
-});
-
-// OpenRM defines this as a register array, but doesn't specify its size and only uses its first
-// element. Be conservative until we know the actual size or need to use more registers.
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05 @ 0x00118234[1] {});
-
-register!(
-    NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0],
-    "Scratch group 05 register 0 used as GFW boot progress indicator" {
-        7:0    progress as u8, "Progress of GFW boot (0xff means completed)";
+io::register! {
+    /// Boot Sequence Interface (BSI) register used to determine
+    /// if GSP reload/resume has completed during the boot process.
+    pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
+        26:26   boot_stage_3_handoff => bool;
     }
-);
+
+    /// Privilege level mask register. It dictates whether the host CPU has privilege to access the
+    /// `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK(u32) @ 0x00118128 {
+        /// Set after FWSEC lowers its protection level.
+        0:0     read_protection_level0 => bool;
+    }
+
+    /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
+    /// first element. Be conservative until we know the actual size or need to use more registers.
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05(u32)[1] @ 0x00118234 {}
+
+    /// Scratch group 05 register 0 used as GFW boot progress indicator.
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT(u32)
+        => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0] {
+        /// Progress of GFW boot (0xff means completed).
+        7:0    progress;
+    }
+
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_42(u32) @ 0x001183a4 {
+        31:0    value;
+    }
+
+    /// Scratch group 42 register used as framebuffer size.
+    pub(crate) NV_USABLE_FB_SIZE_IN_MB(u32) => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 {
+        /// Usable framebuffer size, in megabytes.
+        31:0    value;
+    }
+}
 
 impl NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT {
     /// Returns `true` if GFW boot is completed.
@@ -229,17 +241,6 @@ pub(crate) fn completed(self) -> bool {
     }
 }
 
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
-    31:0    value as u32;
-});
-
-register!(
-    NV_USABLE_FB_SIZE_IN_MB => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42,
-    "Scratch group 42 register used as framebuffer size" {
-        31:0    value as u32, "Usable framebuffer size, in megabytes";
-    }
-);
-
 impl NV_USABLE_FB_SIZE_IN_MB {
     /// Returns the usable framebuffer size, in bytes.
     pub(crate) fn usable_fb_size(self) -> u64 {

-- 
2.53.0

