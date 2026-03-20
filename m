Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1EA108B912
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE78F10E555;
	Fri, 20 Mar 2026 12:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QGfb3ICx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2BF10E290
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8LOFZRVfkn5ipVKCe/jdGuDJbcHIkar+w7taiEzg/WnF81T9PxF/fx98dL4Zz9G8KGmQZqBPMYvSqMoUSAu0ioLh+EpM3DI7n6lu3Wp/Z+4J5boxBbthanCS1g0vm4DNzholF0Mr6VwbvDMeNQp6ipdVjZk9Cjl7Kvthji4kSxN1rOefs9oFm4kgWlrP9qV3MYpBlmQu1Tclh/mw74D6j9TYPKKGkXGMIj+31JjKXsN4BdKBV/zOvh3ZNffuOgZodwEtAmnczs3A9SKNCACFCz88ybuj9zIT/nlEV9WZjHeYxqFD9EggZB6KByaw23V6oTkaX64MYIkoWfiMmPDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8adSvGwjzpxpWY8VeeAkURfb9vRrrl0xH6oN4jenWk8=;
 b=PMERD+w1McR0n8Sn1NLrZuP7bOZxqtovi2c1/SPbvv79PTyYrYuScvyX/tkxxVMNxUkXLUDdQ9lnT8mVyRfS6MI0qiXlC1J6EYxm40gVkHib2VuDSgyzE/Ge4Sis0aanGCRgYWLR2xgHEB4narb9lWAvMjM8wkv4nKCox54tXj9qxYcVBfxTKmRKtA/KE5B7MuNDlRn/NWj3OAoCQYDwL+lqSYepDMmoLHCbndnNw8q+40DLUC9QyY3nP547/k+PzNEibJY9+qKcU83yrE4q1zu0BnwzvaUzkjku3wi8+PrshOpz695psBG6lmLpJtDf73cKSZUlbfM2YHMNfoYN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8adSvGwjzpxpWY8VeeAkURfb9vRrrl0xH6oN4jenWk8=;
 b=QGfb3ICx4ZvKMpTjFnq7YX8ioMDrzX6uqlgexKhu8sKdOpqriX9hgalViwsJAF8LpcZz9Cz2k5nXluNJ8T2RI4NgSUYr7tzRttdTVuIdP5Fg/t9FEuCbj4mMaXHrMdXxJbnJWdOyHu43oQ5Fl2PvPLhAKGY5h9s8JEMmly9MjfEoDthYnjUEuRzKMX2Y9m8lFzWUNZ6gbuCqbwZ4FdZDoFcSrq8APoedflt0dFEE7btFwi77bOgdMzw558G1Ki/SXJi43aN4fnrir8HjYab5OVdzO0coEaHRXhrqoyCW3M/pzs8ptZnx2K9rs4BDgkEVUxT6nRYWM7Mu7rLgtC8KXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:17 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:54 +0900
Subject: [PATCH v2 05/10] gpu: nova-core: convert FUSE registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-5-88fcf103e8d4@nvidia.com>
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
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
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYWPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e78feb-9a26-4451-0394-08de867b0bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: lYRnFqfQWOkBiAyGcukNCk6BtVSz0jmpbdjRpKpU6hvo366AboGEt90TXCOvc/6umxkehXIwNsl1UBT5LlqLhn3zDLeZZSsvFY2CrAKmFn2u4jDc3c64WwKu1mMj9jlQ+hKarin4yXucb62q3qUwOLQK4jdkHLY4+doUuB59jrj9XyNCAq8MfT8GNUwOFuZsLPjNXmIXpkJagleVyi8ivBxyno1Zlpn9wDMx0RRE54+5fEVywXcxUX3angUNfm/JCAGPcUd/utm15tXKv8NWa3gdqWNN4Y4HIW+U7giWB5Dg5rXLf/7/7MYgDVKj7RItxb1vNB+MTAPT6/TfL1cV4qVU/xJbS/b3yzKV7avLRbxtaVQcfwnrQUsBKoPi61H8WIXWau48qFQ1gMJhPSOWUS538onYIEI/Q7mW7efTyQ9fjoE7KA416Douel1C3bM/Bgr3RI4qMPUv/4eEyA+c87Tr9w/zEFxP+bI9JQjfAHL17jp0QHD4EdU6lIULxaRbJIAz8CdAXphx6OJOFxAKQwWqXQb2EaBbg+4W3m90SLKGK3m5Z45D35LLmzC1st0zzL+UjVzXsJqz2oZEJgSoaRCPSPzlbE8F0SlIfZiZIwrO/A8TgxS02mAXSqJWYxRCF7t2KWIzXLAmDInx+xDvazozvvkS4To+Xsw1cn6Vf/OP25ARgt7QR4udut4D+EX+baFbZCThOvAiw8d1DlXnePAB1np/0+9ByNT4Z2ImAC5Oq6IpOzfIaB5p88127UvpJIGusWXL9Rq9az5t521XXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXZ5RkJLR3NXSW5rMlVNems4YTJsSVc5NklPY1VoTy83eEJoM3B3UVdVRXFS?=
 =?utf-8?B?S2JNd1ZhTk80dDFtT3ZZVVBmNXRqUWo4emZqakFwWWJrc3cvYzJoOU9MQmtr?=
 =?utf-8?B?bkNYVmlncWdSbDYxVitRWnJ1SmhVNTZQYmJ1TGwvM1NXVzZ3V0V6RGVyaXR3?=
 =?utf-8?B?YjZmRnB3aWtxTHVHeTc0a2dncGtSTm9MeXpBYkpJT1hXVVdDL2ZwMnZqNkQ1?=
 =?utf-8?B?clNpVUxJbzNhYVVEZE9hMDc0M0F2b3dRZW9SWXY3b3hjV3AzMmdZS21BbTV4?=
 =?utf-8?B?MklLa1hXWFFvRFB5MURMVUhkeWpNa2pLeXRrQmNqTmxibjY1bklNOUNhbG96?=
 =?utf-8?B?bTltT1pUQmRWdFlRaUJ6azJJZy83SnFIbUJGeFBKYVFXOVIrc1ZKWnZGQlJ5?=
 =?utf-8?B?aFh1SjFobzNoTjlxcC9hdG5JL3Z3U2pjUldVM0xHczJXQW8rMVorZ0pLRTc0?=
 =?utf-8?B?WWVzYWkvSi84QmFtRVUxaFZzdWhNQnRSbWQvNG5idlVYeHU4K3F2QnQvQVZQ?=
 =?utf-8?B?VlE2bkJBc3lGK1RyNjJBTlRwRnNqc2p0OHJsRUlET3hXdzd2d1ZISVo2Zjl5?=
 =?utf-8?B?ZmRWVlNpbWZxSkNaRmJOREJjNnZpa3Q5VytNZ1JRdk1DakFLR0NabVEyQ25h?=
 =?utf-8?B?ODRHcDIwcDJsV3ZWMlRMY3ZoUGRMTXhXZXlha2pVYTY0c0FGTHM1YmVZRkRJ?=
 =?utf-8?B?T0tzVzdhRnBoUVVBVGdSdFYyVEEyVHRHR3krVXFJUndrN1BOWWFRNTd0c3dF?=
 =?utf-8?B?WlBMTUJUbFVXNmFvd05naFRZaHppbzJxMitiN3JWY0NUazM4UzkyZmQ4RXh6?=
 =?utf-8?B?bnpLRFNVZXZOUXFjbnFSK1F5bUEwOWJiQy83TnU4Q0szdXVvc1BMcDdQblJU?=
 =?utf-8?B?QzJyUVhxc2d1YjZZNWRtSjA4YVJWVVlpRVUzdVJwbjAreHlYSVRoLzc2SlYx?=
 =?utf-8?B?T2t2eGF2UjJQMXYybzhveDVSd2tFdFBwcGV4ZllLRnIzdCtCRTBZL3dBS0tk?=
 =?utf-8?B?RkMyRUY3U2t6anVreEtWclNCY2F0aEJUN1NMbWtWOXdZYlNGakk1b2czUHhn?=
 =?utf-8?B?WHZISjRvZkdkakRLOGMvelpTTlFPR2tqSFBNUFNGNEx5U1NURzlMUkE2dUxw?=
 =?utf-8?B?NTV2QU16aDQ2OEM3dlI1K2VreVVIbWRvNVBNRWQzcnF6c0hGUzIyL0JKWm1G?=
 =?utf-8?B?enQ5eVZWUE94TlBmdlVGSGVWd1hGdDYxZXZGejVKVlJIRkpoNkNvMUp0Mm4z?=
 =?utf-8?B?OVBPajBGWWZSRDk1MUdvMjJlOUxWME9pbkFRck54dHBqbWFqVmlnTklQUmcv?=
 =?utf-8?B?N2JBczhqa1NZUkl1SGM4bjliaXd4TVlkVWljOC91SHQrTVNKRjdicGxFMTRp?=
 =?utf-8?B?WVEyWk4wU01UZVFXM24rUEhMWS8wU0FHKzU2bkcwSm9TeTFQWndYT3dwNWx1?=
 =?utf-8?B?cklBc09TeUxkRGVRVXVZNHpTaHMxVHcwM0ljZnZGbEIvcE1vNHFIcUZwdSt0?=
 =?utf-8?B?WUZIdk5EQ05zOHRZdUNycFNBbDNOVS8wUGxpWktDeks4TE5OMTBuK0prMlVP?=
 =?utf-8?B?K0J1M0xwMTJtdkY5bTJVSUtlN3Bic3FDMk1qMkg1WUo2YUovNUIrU00zSTRM?=
 =?utf-8?B?L0RMMHBIRjVkbFhzaDRCVjZQdGNzbUIwcnYyVlVpVG12dEh3RHdnSk1DdkVy?=
 =?utf-8?B?UVpOVEROWHRaaFhMRjI4RnQwVEN6bHF2Zlk4NzlKSTJxTkR6NnkwYmUxVVFN?=
 =?utf-8?B?eEoyUHVwbkxnU2FlMnBWMkk0R1dNRDI3ZnRCd0ExVVNBb25BSGVia2pSZ1pu?=
 =?utf-8?B?SnJjcTl0aDlOOXF6NDBTbkZCTWNHSWhOQWJCdWNBNVg4SE9YMXlrUTJLQkZJ?=
 =?utf-8?B?OHUxOHV6c3R5bnBCZmJETzk0NTlHdnRteWpiUEZ5emR5em01OTR3V0ZJR0k2?=
 =?utf-8?B?eVhITmlxZGorbFF6UjBwZU1odHFhLzhRcVJqT2UzSEd5d1czYjkxZjNCYUpC?=
 =?utf-8?B?Y0dydnNpZkNVdWRuUjlEakFWOGgyZkVZMmp4UWJJV3llU3dKMDZtQUtLK202?=
 =?utf-8?B?bllVOEU5SHVHU0ZMYzZnQmJTZTZSZ0RvTFAzVzhJYWwzQ3d0d0JBbi9TNjBJ?=
 =?utf-8?B?bU9lY2kyN0lsRVY5cWlTZnNvZ3cyWUZ6UlZ5YSs1MU43di85dnNZaWtmQkkz?=
 =?utf-8?B?VEJ4MkZ2ayt1NEhlTnV1UG4vNGtIeUVOWlJnMUJ4SlJnWFI1VUdXVWxUT2ls?=
 =?utf-8?B?eGE0R29ubk50WFZkMkVBalZKRllaVUFPUXQvVWNQZmIzenE3OWllWWJ0MU5C?=
 =?utf-8?B?OEk3dGlIdXpaNG5XanBCM0ViNVNiN3NIUkUzNEhacHpKNHlUUjR4dUR4TWVi?=
 =?utf-8?Q?2HHLJp2Sz9WlGtGCmbJl/n0y3jJXkkE63MV0ZpshfZyfv?=
X-MS-Exchange-AntiSpam-MessageData-1: LLJUgVq8Wp/LmA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e78feb-9a26-4451-0394-08de867b0bbe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:17.0823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPO429zkRLWib553m46afjYfg40MY2leESi15dGKSBs7m8AJqU0G6K/wIZUVupvawxK00g4V5NJCPyn5AVrMHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

Convert all FUSE registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon/hal/ga102.rs | 17 +++++++++----
 drivers/gpu/nova-core/fb/hal/ga100.rs     |  3 ++-
 drivers/gpu/nova-core/fb/hal/tu102.rs     |  3 ++-
 drivers/gpu/nova-core/regs.rs             | 40 +++++++++++++++++++------------
 4 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index 8f62df10da0a..cbdf36bad633 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -4,7 +4,11 @@
 
 use kernel::{
     device,
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        register::Array,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -60,12 +64,15 @@ fn signature_reg_fuse_version_ga102(
 
     // `ucode_idx` is guaranteed to be in the range [0..15], making the `read` calls provable valid
     // at build-time.
-    let reg_fuse_version = if engine_id_mask & 0x0001 != 0 {
-        regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::read(bar, ucode_idx).data()
+    let reg_fuse_version: u16 = if engine_id_mask & 0x0001 != 0 {
+        bar.read(regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else if engine_id_mask & 0x0004 != 0 {
-        regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::read(bar, ucode_idx).data()
+        bar.read(regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else if engine_id_mask & 0x0400 != 0 {
-        regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::read(bar, ucode_idx).data()
+        bar.read(regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else {
         dev_err!(dev, "unexpected engine_id_mask {:#x}\n", engine_id_mask);
         return Err(EINVAL);
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index 629588c75778..1c03783cddef 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -40,7 +40,8 @@ pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
 }
 
 pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
-    !regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY::read(bar).display_disabled()
+    !bar.read(regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY)
+        .display_disabled()
 }
 
 /// Shift applied to the sysmem address before it is written into
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index 515d50872224..281bb796e198 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -29,7 +29,8 @@ pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
 }
 
 pub(super) fn display_enabled_gm107(bar: &Bar0) -> bool {
-    !regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY::read(bar).display_disabled()
+    !bar.read(regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY)
+        .display_disabled()
 }
 
 pub(super) fn vidmem_size_gp102(bar: &Bar0) -> u64 {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 6f49467e78ec..61a8dba22d88 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -270,17 +270,19 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
-register!(NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION @ 0x00824100[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+io::register! {
+    pub(crate) NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
+        15:0    data => u16;
+    }
 
-register!(NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION @ 0x00824140[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+    pub(crate) NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824140 {
+        15:0    data => u16;
+    }
 
-register!(NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION @ 0x008241c0[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+    pub(crate) NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x008241c0 {
+        15:0    data => u16;
+    }
+}
 
 // PFALCON
 
@@ -491,17 +493,25 @@ pub(crate) fn reset_engine<E: FalconEngine>(bar: &Bar0) {
 // only be used in HAL modules.
 
 pub(crate) mod gm107 {
+    use kernel::io;
+
     // FUSE
 
-    register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
-        0:0     display_disabled as bool;
-    });
+    io::register! {
+        pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00021c04 {
+            0:0     display_disabled => bool;
+        }
+    }
 }
 
 pub(crate) mod ga100 {
+    use kernel::io;
+
     // FUSE
 
-    register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
-        0:0     display_disabled as bool;
-    });
+    io::register! {
+        pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00820c04 {
+            0:0     display_disabled => bool;
+        }
+    }
 }

-- 
2.53.0

