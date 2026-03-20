Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FC0108B915
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6307110E560;
	Fri, 20 Mar 2026 12:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ONS3vagw";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FEE510E562
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlZ+OmFROqEdRFedZLljoCmf81Rpk8JibcJAcA/GRifR613s9tExfRvOjesRg1azFhmJnvzDDID51I33QnUIqiTsp8yCQQQWZt2zPZ6BaqxL3bIFprx0KqzKsCPbX6UFrziIphogMZEX9EoHu3lzaYK6XqCaPgaVd2sr/RDMk9W1tehdTeNM5eofDf6sRoY8R+u4sxgVW3Gmd0HSzu51+0KtYONiiucb77LGqZO/INU06RvBcufwqyH/JmYxji9AQo21r2Hkb8fAV2CFVwKYNPMfiL3X4xs9sEYkuToIbWGJaL73EKkHUciIvGrQwVXGrPy3xk+T9xtDZyuk2+tQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYhy+KHySSIQOcNmHfyLsGvRddhb1WtwnvnonJrW96I=;
 b=jSOkwHYm09+D9n05k2txEXP4CgGNoqCGZyDueqTxKJmiQnO4t5fk8jLrZcpDnMV1kCYRrwN+bpYFi5vV/LSwzUlsts+NrGmronOS8ioH9UZzVtATxSP55TDdg6Jr0nurVdvbyvG9GQGmTs/stwUAaJfuWavoPhbU0tV+Nn+7WXQ3UQPgv0lHW9xZWGsa4zjUotY16KeTYuQ2hgQri3wCW9t1uZ2LLAIKuNIliRMiAbt3FZSSv7elvu00uLwzD4WKtBT1h/Q6siR4UFldO7KsnU2vYdXZn2odfxe/gw8mNxwHTptiUZiRBL9CP1TYw3jDoov2Swg0G3jJk2fEWomTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYhy+KHySSIQOcNmHfyLsGvRddhb1WtwnvnonJrW96I=;
 b=ONS3vagw+rWR2+c4ysDRzFZb3/AMW3+FMEoYtH5zzWvr8eQfzMYC/Sclf+RcNHG/R5yKUT0dVoPC0b+K2rD62Co6YrttiTOT0zo14aniyVfB3+m/i/EdYpYsboVrK8p5XJzemTntVZ+j5RjIht4RjF8jTGx3U9HM0ZiXb9EkQvjo2itgmUtnEjV7OdS5M39sjAF+BZb2LT57YN7U/6Ar2WeGqtv4gW6m+n5Ih03a+y7JLj6SFMNA064Sfjxd/PNWyschiXB3sUM35EOhEW7BVRwHYh/1A9J26RAMXEPfasNrUE7ozyToZegQ2HnDxYOv1QbW5fK/SzA3r43gOFQhyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:32 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:58 +0900
Subject: [PATCH v2 09/10] gpu: nova-core: remove `io::` qualifier to
 register macro invocations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-9-88fcf103e8d4@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d03c65c-2374-45ec-8c8b-08de867b14ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: D0iRpQZnepXWGYfye4riy53O/QCMeYEpaLjJArpjnk2eSb5kgQYK7egn93q9Sddxs6cq1d2l+6ICoRaD70oxa4OdyA+ZVwfjGupR/EYogouyS4u/vy+AGfuik7ai4Srie1Z11YmTZwHKEOPK7skGhpdr1FZXPlavb9j63yS9gmoFCoIuDABeP+WmxWoZqVL3l/d6O9uqPtMhPsipkpyAsP2yAZQ1st1RQNDmF+JlTSK9DxfdU4ZsDBT9BxA0mWutBqKMfF9ctSNoBOq399HJH6WrIslHmxGizXqBaYNbGlQmwNDoZCGckDfU1znZ4f5OBpjFupjymuWfR/DUnq9s47GcZEo5u+WC2cGn6QwifJAfz7qBt3MESWZY4plBvOb6VnMgdeGTEgpZju+nnzW7onskQjvyn4ZdKwIbNMKQJ0X5LEfnTLnBpo/pR+xXaHB+7Yx1hqpO7w8qThgXKkojIaZl1nPYIkhnMq64Ar2Eqq4VLXObJX16QGe9Q3wlGu0Fus3kIVOSrpeBfTeSDZv6TrWpruQeHYqmLXOQHcyCWoZVYOR3d4IjFeiPvf8ubvTNHO8V9eHcJfMdEviGb6972Svg/mRUN5JjCaw2u1E3mIpbLIOeZTEtv84IbMPtWcEnPYmUR2LLW7Y7Cv+l1kAX4HtEaRFLQ/lgGfcb7CF0mKDau5X5R3/bFvUuvwxwLmshHs+f+lpoQud0tjgMWA5Q9cWijcHspBUIdmeANIXDho8mCgC4t31MmG/R7ffGUXuxhs9ebp0V7gR6FxsFRshTKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elpkZzNnQUhIRkNSVkk1dzd0TCtidkZPcytubStnYmh4ZWZQY3poSzgzejg2?=
 =?utf-8?B?NmlRWEFSYjRLZkhwR04rSXpYaVdPMzduRDRVVStzNUlCeUhKUnFMY2hTTEtB?=
 =?utf-8?B?L0c0RituMXUrcXpMM1VzWDI5dFQvS3M2WmQ5N1VrcUlyemFIZjdWTDBVZVZT?=
 =?utf-8?B?RGxBdFBkQ0JXcWpQN0RCTWNpd05CclMwU2d6TENHaXhGK2JCbVM5K2U2Wldh?=
 =?utf-8?B?b0hYakQ4VGErSEwzQlcrTmJtY040RVNqSnowNjZ2Ujc4ZnB1dmFobWVVTkl3?=
 =?utf-8?B?eksvYVVsaE1zYjRITlk1QnM3OTJub0RGcmJYQ1dxY0xGMDJZZUFJNklnRDBl?=
 =?utf-8?B?MU5nZWxIZmJUVU5tTm13VWUrcHltcFltVHdlYjJFK2lzaEF1YVo4NENDNTI3?=
 =?utf-8?B?MjNJR0pqRGxvbFNqUEpkektEZTJSTXNqZDgzdG1OQ1pBSUhKYTdhQldrd2lZ?=
 =?utf-8?B?YS9BcGpmeE5VNVBDclNEN29UOEdVQ25VQW83Q2M3YlJodEo4UzZWdTNvK1NZ?=
 =?utf-8?B?U1p2ZjFGSmt3UU1ubXVGeDY0Tng1Sk9KdkNFeUxwODkxOExJQUkyd1h3YXQv?=
 =?utf-8?B?RWl4L081eWNXY2g1UU9GQTVuUkRnaTkwRzZwRWV0aG9XVGY1YzkwcjRqczlI?=
 =?utf-8?B?cHpNV0lhY01SUGgrVEszb1FKK25TVUdNcVhFRzlRS1E4RHFmUEl6VWJGNHpj?=
 =?utf-8?B?K0pKUzlYWWhGZWhoaUZhWTQwOWV0YVdMNHJHckUvd2dkUEdMS1R5eGRuVWJi?=
 =?utf-8?B?bnQ4UmFyalRsNERkb2JMeTc2eHZuR3VFWGVNcUgya1REeW9GMTRhVWdRVkVv?=
 =?utf-8?B?Q3hob0VEQjdGVU1SM2xVTkI0M2N3YWoxTmJSakRaVG92TDhUbjcxb21Qejk2?=
 =?utf-8?B?c3JkcjlrV2dFVy9kUlR3MUJyL0x2Z1hrNW1zNHRVYzc4OVJrdjFyS3VpN2Nl?=
 =?utf-8?B?eXNBSGhUR1ltdFVYZVRqMlVYOFVINUJTaGxJcDMxbHZweVFiRVpUNll5Yy8y?=
 =?utf-8?B?U0o4R0l4QUxzOEVxVTM0SU5NcnB4U2djcGFpRzBiOFp2Rjc2VDJOYjFHbTNp?=
 =?utf-8?B?MHUwenFGV0c0NEkyY0dDMytiOGp4UjNMV1hFTExwcWl3Um56dStwRU9IL0NN?=
 =?utf-8?B?RkRvSHp1K1BCTHI2eGlXZis5NXM2VG9RSUhpMGVBZHRrYml5UXBSamxieHdr?=
 =?utf-8?B?QlVITGZ2ZkxtMFJEbkVISWJObzU0TXFUU2ViV1ZDL3JUMGM2ZVRTRUJDTjda?=
 =?utf-8?B?UmRjbUJIaTZhTG1PYVpkeDlYZTZjK2w5bmZnU2RSR1JZcysxeXRZcnJzZm1i?=
 =?utf-8?B?SXBLbzFSbm1zNTBnMitUSUNTNzBUMURvZGZRdXVnR09vZGFMem5KNFRLa2J3?=
 =?utf-8?B?SHBaREtSdU5Hc28ralRhU01yclNBUWpRam5xazJ2S2dVVUh2c2gzK3JrVHhl?=
 =?utf-8?B?UWYwZStKNkl5L2FsWHIvU3doMW1Da2llZTRqOHIyUitiMEpyOFU5Rm5mZEpl?=
 =?utf-8?B?R0tra0MzV2xueUFLejFlQzYvRjZMVTRXVnYwK2kzRkhFWldJaUFmbmdFK1FJ?=
 =?utf-8?B?cFhmcVR0ODk3NFVuL0VnMzg5QTVwV2x0Ynpnejl3cG5ORURvNHBaVXNpRkNu?=
 =?utf-8?B?V2h2RGlxYjAvSTFKaHVjL0NhS2h1a1lKb0NTS3Foc1ZsdDc5Z2lXWjVSK2ht?=
 =?utf-8?B?VU9rUnhETHNQUHMwZHI0NFNKbDZkSVkwc0tuQWp3ZUxpdU05MGFsNXBQRVZJ?=
 =?utf-8?B?MXRSQ3EzOU5qblBnc2w2Rm0rZWZRN2NLd1AwZEJ4TVk3bUdkc2tyUkhOZFpR?=
 =?utf-8?B?dUxLY3NSS2tFb0Q2K1hSU1pFQkJSU3dQSHVXR0VHRGZRNlN4K2R6SzJSdjRu?=
 =?utf-8?B?aEpjcGZxTFNzOFAxeU50aU1MYUd0dVJqL3ZIeUJyZ09LdDBrMENEWVd0RXIx?=
 =?utf-8?B?cTZhN2hBSnVDRlY5L29hL0JyQ09rSENrellIbkllWWUxUTZXbkpxMDZIR3dO?=
 =?utf-8?B?MVdLK3pWVldQWlJrVVRIMnQzR2ZwK0tJS3VubmVZU0dqUUh6OTFaTlMraGNp?=
 =?utf-8?B?bW93UVo1NENUUHcyM3IzZUw3VmFxbC9aNXlrai84QkYrMUoxOStNcHQxSkk2?=
 =?utf-8?B?T3JYQmtXa2MxemlDcUhjbVZXNnNmZ3pBemplUlplcGtKZ01YbndBWjNyMlhO?=
 =?utf-8?B?b2hKM21tMTB1UkRiam5mWlpCZkw4SmtleXhaV1pPYVdrTWdnenUzWk4vamlH?=
 =?utf-8?B?VTF0MnpsQ1F3QWp3aCtrd3dsRHRGMTRuOFMrR0tWc0I2K3MrOTFLMkFHOEF6?=
 =?utf-8?B?U3hqZExCSWtiWEY3TGhIUHBra3BRY054RmxkR1BPZ0hFWHpuQUFFQk9FcFVv?=
 =?utf-8?Q?pKb9JLbdwfNFFkkNlh4BDTnocd/y0s8lxD/Rg+yN6Kkvk?=
X-MS-Exchange-AntiSpam-MessageData-1: Gp575Yk2yIyiGg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d03c65c-2374-45ec-8c8b-08de867b14ad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:32.2374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWsNEaVU4CdBQ31De875ZL9HG2FYU0ShmuKh/PHHveNwBAwsBdqziE6Y5jhIhWOHu3ETacxviIjqVc8BjUFR0w==
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

The kernel's `register` macro would clash with nova-core's own version
if it was imported directly, so it was accessed through its `io` module
during the conversion phase.

Now that nova-core's `register` macro doesn't exist anymore, we can
import and use it directly without risk of name collision.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/regs.rs | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 87c2977ba6e4..2f171a4ff9ba 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -2,7 +2,7 @@
 
 use kernel::{
     io::{
-        self,
+        register,
         register::WithBase,
         Io, //
     },
@@ -35,7 +35,7 @@
 
 // PMC
 
-io::register! {
+register! {
     /// Basic revision information about the GPU.
     pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
         /// Lower bits of the architecture.
@@ -106,7 +106,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PBUS
 
-io::register! {
+register! {
     pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 
     /// Scratch register 0xe used as FRTS firmware error code.
@@ -117,7 +117,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PFB
 
-io::register! {
+register! {
     /// Low bits of the physical system memory address used by the GPU to perform sysmembar
     /// operations (see [`crate::fb::SysmemFlush`]).
     pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
@@ -180,7 +180,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 
 // PGSP
 
-io::register! {
+register! {
     pub(crate) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
         31:0    address;
     }
@@ -195,7 +195,7 @@ pub(crate) fn higher_bound(self) -> u64 {
 // These scratch registers remain powered on even in a low-power state and have a designated group
 // number.
 
-io::register! {
+register! {
     /// Boot Sequence Interface (BSI) register used to determine
     /// if GSP reload/resume has completed during the boot process.
     pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
@@ -247,7 +247,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
 // PDISP
 
-io::register! {
+register! {
     pub(crate) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
         /// VGA workspace base address divided by 0x10000.
         31:8    addr;
@@ -271,7 +271,7 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
-io::register! {
+register! {
     pub(crate) NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION(u32)[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
         15:0    data => u16;
     }
@@ -287,7 +287,7 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 // PFALCON
 
-io::register! {
+register! {
     pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
@@ -468,7 +468,7 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 
 /* PFALCON2 */
 
-io::register! {
+register! {
     pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
@@ -490,7 +490,7 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 
 // PRISCV
 
-io::register! {
+register! {
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
     pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
@@ -516,11 +516,11 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 // only be used in HAL modules.
 
 pub(crate) mod gm107 {
-    use kernel::io;
+    use kernel::io::register;
 
     // FUSE
 
-    io::register! {
+    register! {
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00021c04 {
             0:0     display_disabled => bool;
         }
@@ -528,11 +528,11 @@ pub(crate) mod gm107 {
 }
 
 pub(crate) mod ga100 {
-    use kernel::io;
+    use kernel::io::register;
 
     // FUSE
 
-    io::register! {
+    register! {
         pub(crate) NV_FUSE_STATUS_OPT_DISPLAY(u32) @ 0x00820c04 {
             0:0     display_disabled => bool;
         }

-- 
2.53.0

