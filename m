Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14386103A9A2
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519D610E6B6;
	Wed, 25 Mar 2026 02:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGAKPjgJ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7432B10E6B6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISh7wakW/f0+eQmLL12xBDp5x4DZ1XhOJCyg1hz3/stWm84D41vGAK/6LHYi6byVbsp2B+TO/odJ8rON8To2mJcZL61RkjL60ar/9dSg9d343xUV7ePVn/+1Fa6nYA9KF7aZR5fyInGWrpDxOZLOP4Oeu5murVkCmHh19qJdEAtZ+2hZ4p835GgAYlTndWzLTle6BVk8CQEG2VEdDNoZtJrYjSLJjNA2GvcZX6SKyCu/83fno9166gnIrqbwPZNv6sBweubXltIVsqpl6xh8s2vSLgqAzF0YCbbjg2aCPgrHTE0t8ksbnx6uAJiZ+cUJHDuWITZvugUWG9O6Mk1NvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEFy8P9E1Arlj4eXmeo4HyHlyXraakB7JWoSQxi7N0E=;
 b=l3MqH5yuWIeo56NXIiOZoq3wFKNf4SIqvBS2iYkFYYYFliOmc7Ah9cXFV9ZlOofHsG66sStgcIz/wa3Jgiv1PGO8GRymjNViKuLeZ1oSZqzK+5r3vmld7aJ2iJNiggg89ocqvTArakkunLRF4nei6EcutRVZp/LVk6YAoj7IPdHpSVhQwvUabiVpjbKU060fM/1ffWQpkGnrYzG/5Tp9w8oP+U2pAk5AYzL0cnwJIpZ+iWw9tgjzFzHy3gY5/hmtovd08CYCGKC6bz1Dnanhqbadref8m/0qrH5Jj2sUd5JVNyOjMT/xOWG6SpA7gNCa3T7V9IIegKxcI3GQigefCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEFy8P9E1Arlj4eXmeo4HyHlyXraakB7JWoSQxi7N0E=;
 b=OGAKPjgJ3nh0dZSuiblzfnvLj3ciPXrSZkwFSw9G6LhMbr8/uGJQm+N4zRI+/A6VLjh5ZLhXS7P1y6s078ft1Vs2saLN888/dtechT7/eDHGklu8m8GJxj/bhtIQ2KSciNsxSG+ikcUJeVtbwIooLWO93XdOl9Ik/XYfmK5TrqIjmUjlf+bKjSMf/VIgJDfdxZd1sZLfj1bbUkzsdgnVOw2DFLfCfUJczVujXox0cZJuWS+I5d4733Vfsha7hjxw4Z2pDUJrbpa5DN+FHGQihwQWTf6Lesxa0cqnPpI3d2KXiIp6Um5invcH8GvXsC0IkQSGm9fK0bVM/oBqXXAQ3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:46:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:46:50 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:17 +0900
Subject: [PATCH v4 04/10] gpu: nova-core: convert PFB registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-4-bdf172f0f6ca@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7daf9b70-302c-4bda-630b-08de8a18c3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: RFGy6GP3S/xKO62uwhLdQ/gNtRgFoH7MLglA+Ui4/qu4fmhs/nCRTV3zBhE/PNHoioKjddJGXmidI7QWGG92fpSewhnaqkXufiORmBDIUE7HRN2SD1gKLlLFtwE67znL/R8as0oHFIAiXA0jS2oF5c9lZxfyTsV+N8ImoixqrEgiRPU1v0a6EFa6oiMEEyKdnPYQFTeKoTvrLtC6DJXmXb0H5mPqdZ69I9rbCfgjFXCvlLslEme5m8WQHZXuP8zBxgoI6VxN/iXPP9wgQ4B5kKirVmj4/W+JH14i4Tsta6o0/peTnIHOD6Bctw8kgQ2+amjlqyvnwMPLQM0LjTWi3DVkOvRm8041OHwfXmAN8qYOPsmID+4ev8nQ1yfbIe2O3VOwiM9Bpss4B1RJbr/FlR/W1WGWCCjhjcLw1AvIsfTgk5YFhh+ULmZ3Q/cq76Fjw/9tjOh95EciR1x7gUjwJa7L0abwmvUK6BdId6rmbR0FD8feEWMjvC2OL6FVDOqMFPZvVEvIV3+Ss+7cyf7V615rFYmwV7kZYFNk60SQbp+PVLej+i2Di+LdQ2RflzJXlP8afnqdkd2oL++J0z2zD5UV+cmAV4nvh8ZCQEJYABb49kVY0DHsRtzloTnwt/vy8udNIaVG8yxc8FecnDhZRW88VBntoRGCXfRrFKz9QEsSr59HuQsw82IA96wSIIvguiVN3BCZxpdD29s7dJFSJUI8/+5gMCRPC8QrDht+1ZbBVfrG5kYtWHW3ICc5rV8LAMj5KacGYteEvryYdn43YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU5keklndHoySk1HSnNWWW5lQ2h2RkE1eXFZNzdxSlRCUW9RWG9mVk1iS2Jm?=
 =?utf-8?B?MW04RDFwSmdVQklLMDFoV1BzZTVPVmljRnlLQXFRQ05TR2t5MC8rRHVnWUlu?=
 =?utf-8?B?eFNMTW8xNEZHVEdpNzVmcUo0OXJxOHZSNEFRYzBpU1FSZkxlYkhIVTdFK1pa?=
 =?utf-8?B?eDhReHlMM0w2Z21YbVN6V2Q2eFArZHQxU2hVOTh6cm5xMTNPTHpYRkVwUndZ?=
 =?utf-8?B?NmlHZUdvSUdNV2p6UzliQmxvMkZTSHpqcnp3U091L2EzTDFsWldWNzJ1Vncv?=
 =?utf-8?B?RGdVN3NuWUFBaVhOVUhzVG51ckd4QzJucWU5WEJvWU9jRHNydXl6ZWRXMFpE?=
 =?utf-8?B?MjA1dHpEVXQwVE00R3ZRWFVNT3dHRkhiM1lyZ1dsQWltVG9wV0xHcDVCWVB6?=
 =?utf-8?B?Y3l0NUlncktFS1BLRHczSE5NQXk5Y3dxcW5qd3BzODBLWHkxMnJDUnBEdTIx?=
 =?utf-8?B?eWQrZ1dGb0IySmp3UTg0NUEvd3VyWlloMDEvOWNTQkJwb04xK2JMa001UllI?=
 =?utf-8?B?UmdSZHZiNGxIc1RWaHdGaEJuRFc0UmRoYWI1L0hTWm40d25EQWVpZTFDbnJL?=
 =?utf-8?B?dytYT29PcU1PeGRoYnlPbUdCRzA2MEFKaXFIWFVtaXlCM1BTWURJempZRGpm?=
 =?utf-8?B?UHhFQm41cWwwMFEvdlhkUGRzbjFOMklOYjJ3WUhXOStGU0VSSlpndHJLZXlQ?=
 =?utf-8?B?aWRvcWpXSy9wYjYzS0pDQXRMd2svZitldjE2a2syeDJ2ZEdJZTIrK0Zwa0xq?=
 =?utf-8?B?aFRUR0R1NXFKaDVJbHpHcHkrUFZyZGhiVlMrK0lrR0JLMUlmUEZaK2ZRY05D?=
 =?utf-8?B?NnFvR0h5bncwbE5MWVBBUkhETjc0Mkl2akJZUTYzQmt4cEFza1p6NVlNSm5B?=
 =?utf-8?B?ckoyL1BwQTQ1a2NwczBITjlvTi82ZVJoM1JvYlVjUUgvanE3N0dqMDRrUlRl?=
 =?utf-8?B?djByOG9DdGFqak9OdXZFYnY2c2M4djVHbXRNVVJWYUpPeXF0bDRMZWltVnpN?=
 =?utf-8?B?TlpsRkZIekdPR2tuMnl1QVV4a2JCK0VSMy9keGJVTG5aNEU5YU1tcFdNWC9n?=
 =?utf-8?B?UTZ3SmgxT3lNYnhuZzNMdEZ1VW1oT0VESk4xMG1ENnVMZHk4djZuekxURVpy?=
 =?utf-8?B?N05nL0ZMbUdVQzBMYWYzRmJveVFoUnBxNUUzbG9hYlh1ZlZrTGNTVmt0OElX?=
 =?utf-8?B?SVNMQUhaOVZzbFRMbzNpejFCNG8vcTYwYnJSZElPZ1FHRUd0YjljMmZ2NjFz?=
 =?utf-8?B?emlpd1FSSTluMlBLZUFuUW9wQytVcHhMVk11emNvY0IrZ2NaNkk0eGVzeXhF?=
 =?utf-8?B?WjlzRVcvR2x6SnVwL3pLOURnZkwxZGozbXR6T1pQR1E5R3ZBL0NaOHJHSXZS?=
 =?utf-8?B?RjVYZWJYOUM3WENwaDJ6K1NPdmlGOXJKL1kwL3dXeTdoSHBLNDQwd3JrNGh6?=
 =?utf-8?B?a3BQOEROekYxMHdwb1NHcEp5ZnU5Nk9QUnNKSVZSOWxpcUQvcnlwNE8zRTE0?=
 =?utf-8?B?TU55ZUpERDFMdldTS2JvZ3BQdDV5dkVJanRwOUt3dzdpRVN0ejhBMVgyV0Fj?=
 =?utf-8?B?cExiZUFuSHFXZkRMa2tGcHhaQlJWcmcxS1c4d1pnYXF0b2JmSW4xZDFCM3d0?=
 =?utf-8?B?L3FURTIwbWlhTEZERHZJckFEWG5ad2laa29ZUTdiUVB5dFh0d2h5SHNlTE54?=
 =?utf-8?B?bnJzL3RvOFVRZmNid3VCZGE5dDZZcHArdzlwT2lBOFVNZk9yT2ZiRkpMWFZM?=
 =?utf-8?B?bFR0R2pIcXpoUnZ6UlJ3bnpwdVVzbjdGbmdQbjNkbWx3NnNBaUlMdHJYTGYz?=
 =?utf-8?B?V2tON0xlZFVhRGthakVNOUF4eFZMeE1jMlNyUDhhQlIyRVFFSm1Kc0JtRWw4?=
 =?utf-8?B?TUcrU2ZnSnVUU1VuSWNGMTRrVVVHZW9TMHVOSGY2OHFCdkFiM2plVDZzYjBn?=
 =?utf-8?B?SDFRN3VZUWZIakhUMUpraHl5dWRCYjg5dG5DK2hzVk1kMXluK051ODNsaEZq?=
 =?utf-8?B?SlNKcTFIekltMXZJUzNMaWR3dDkyTThZTld1WEUvUVQwQmdqR3E4N2k3ZWVa?=
 =?utf-8?B?SzczQThYMkdJUHNCbmdZUVFvMjhBSUczNTZ3aktZQ1Z0dW1Ca0xPZWFzN2RM?=
 =?utf-8?B?dHY4Q2NwYTVtK0tqaSt5UTUzSFFVYXkvbHphdGlXZjFBY1hCWVo5Mm5oaCtj?=
 =?utf-8?B?bXgvN2dUa3JBRVhQeUxXd3NsaEdDcnRkVk9SYzJnT2pzYTA1eHV6SUFSVTEy?=
 =?utf-8?B?RVp2endjMTFjM1lZd2xDSXVORDR0cGE5bm8vWlp6Y0dXeXB6TGUrMTFTVjRD?=
 =?utf-8?B?ZXVIQzdOQUdWSWdMVDBCcVFMS29lbkJJQlEzdDYweGtHeHJ3RDUzWjYveVJz?=
 =?utf-8?Q?yZaH/Zn3ltnJ/9/0apfPIzXrrziN3OqPDoovS8TjbdEHS?=
X-MS-Exchange-AntiSpam-MessageData-1: nnLzXo4VKWTofg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daf9b70-302c-4bda-630b-08de8a18c3fb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:46:50.7885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fK+WvSgvgqfeleB4xMlBFZiqA8dYuqLkKFQbkzrdOCT8KnGR67v98ARBSLfspYF4nGCfm067YkdWqjXUPMMrLw==
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

Convert all PFB registers to use the kernel's register macro and update
the code accordingly.

NV_PGSP_QUEUE_HEAD was somehow caught in the PFB section, so move it to
its own section and convert it as well.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/fb/hal/ga100.rs | 34 +++++++++++++--------
 drivers/gpu/nova-core/fb/hal/tu102.rs | 14 +++++----
 drivers/gpu/nova-core/gsp/boot.rs     |  6 ++--
 drivers/gpu/nova-core/gsp/cmdq.rs     |  9 +++---
 drivers/gpu/nova-core/regs.rs         | 57 ++++++++++++++++++++---------------
 5 files changed, 70 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index e0acc41aa7cd..629588c75778 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    num::Bounded,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -13,22 +17,26 @@
 struct Ga100;
 
 pub(super) fn read_sysmem_flush_page_ga100(bar: &Bar0) -> u64 {
-    u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::read(bar).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
-        | u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::read(bar).adr_63_40())
+    u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
+        | u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI).adr_63_40())
             << FLUSH_SYSMEM_ADDR_SHIFT_HI
 }
 
 pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
-    regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::default()
-        // CAST: `as u32` is used on purpose since the remaining bits are guaranteed to fit within
-        // a `u32`.
-        .set_adr_63_40((addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI) as u32)
-        .write(bar);
-    regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
-        // CAST: `as u32` is used on purpose since we want to strip the upper bits that have been
-        // written to `NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI`.
-        .set_adr_39_08((addr >> FLUSH_SYSMEM_ADDR_SHIFT) as u32)
-        .write(bar);
+    bar.write_reg(
+        regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr_63_40(
+            Bounded::<u64, _>::from(addr)
+                .shr::<FLUSH_SYSMEM_ADDR_SHIFT_HI, _>()
+                .cast(),
+        ),
+    );
+
+    bar.write_reg(
+        regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::zeroed()
+            // CAST: `as u32` is used on purpose since we want to strip the upper bits that have
+            // been written to `NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI`.
+            .with_adr_39_08((addr >> FLUSH_SYSMEM_ADDR_SHIFT) as u32),
+    );
 }
 
 pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index eec984f4e816..515d50872224 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -13,7 +16,7 @@
 pub(super) const FLUSH_SYSMEM_ADDR_SHIFT: u32 = 8;
 
 pub(super) fn read_sysmem_flush_page_gm107(bar: &Bar0) -> u64 {
-    u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::read(bar).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
+    u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
 }
 
 pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
@@ -21,9 +24,7 @@ pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
     u32::try_from(addr >> FLUSH_SYSMEM_ADDR_SHIFT)
         .map_err(|_| EINVAL)
         .map(|addr| {
-            regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
-                .set_adr_39_08(addr)
-                .write(bar)
+            bar.write_reg(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::zeroed().with_adr_39_08(addr))
         })
 }
 
@@ -32,7 +33,8 @@ pub(super) fn display_enabled_gm107(bar: &Bar0) -> bool {
 }
 
 pub(super) fn vidmem_size_gp102(bar: &Bar0) -> u64 {
-    regs::NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE::read(bar).usable_fb_size()
+    bar.read(regs::NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE)
+        .usable_fb_size()
 }
 
 struct Tu102;
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 3a0124818956..6f707b3d1a54 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -57,7 +57,7 @@ fn run_fwsec_frts(
     ) -> Result<()> {
         // Check that the WPR2 region does not already exists - if it does, we cannot run
         // FWSEC-FRTS until the GPU is reset.
-        if regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI::read(bar).higher_bound() != 0 {
+        if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
             dev_err!(
                 dev,
                 "WPR2 region already exists - GPU needs to be reset to proceed\n"
@@ -102,8 +102,8 @@ fn run_fwsec_frts(
 
         // Check that the WPR2 region has been created as we requested.
         let (wpr2_lo, wpr2_hi) = (
-            regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO::read(bar).lower_bound(),
-            regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI::read(bar).higher_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
         );
 
         match (wpr2_lo, wpr2_hi) {
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index c853be23e3a5..2224896ccc89 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -11,7 +11,10 @@
         DmaAddress, //
     },
     dma_write,
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     new_mutex,
     prelude::*,
     sync::{
@@ -509,9 +512,7 @@ fn calculate_checksum<T: Iterator<Item = u8>>(it: T) -> u32 {
 
     /// Notifies the GSP that we have updated the command queue pointers.
     fn notify_gsp(bar: &Bar0) {
-        regs::NV_PGSP_QUEUE_HEAD::default()
-            .set_address(0)
-            .write(bar);
+        bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
 
     /// Sends `command` to the GSP and waits for the reply.
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 533d912659ba..4f5cd64c2fce 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -120,26 +120,35 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PFB
 
-// The following two registers together hold the physical system memory address that is used by the
-// GPU to perform sysmembar operations (see `fb::SysmemFlush`).
+io::register! {
+    /// Low bits of the physical system memory address used by the GPU to perform sysmembar
+    /// operations (see [`crate::fb::SysmemFlush`]).
+    pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
+        31:0    adr_39_08;
+    }
 
-register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR @ 0x00100c10 {
-    31:0    adr_39_08 as u32;
-});
+    /// High bits of the physical system memory address used by the GPU to perform sysmembar
+    /// operations (see [`crate::fb::SysmemFlush`]).
+    pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x00100c40 {
+        23:0    adr_63_40;
+    }
 
-register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI @ 0x00100c40 {
-    23:0    adr_63_40 as u32;
-});
+    pub(crate) NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE(u32) @ 0x00100ce0 {
+        30:30   ecc_mode_enabled => bool;
+        9:4     lower_mag;
+        3:0     lower_scale;
+    }
 
-register!(NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE @ 0x00100ce0 {
-    3:0     lower_scale as u8;
-    9:4     lower_mag as u8;
-    30:30   ecc_mode_enabled as bool;
-});
+    pub(crate) NV_PFB_PRI_MMU_WPR2_ADDR_LO(u32) @ 0x001fa824 {
+        /// Bits 12..40 of the lower (inclusive) bound of the WPR2 region.
+        31:4    lo_val;
+    }
 
-register!(NV_PGSP_QUEUE_HEAD @ 0x00110c00 {
-    31:0    address as u32;
-});
+    pub(crate) NV_PFB_PRI_MMU_WPR2_ADDR_HI(u32) @ 0x001fa828 {
+        /// Bits 12..40 of the higher (exclusive) bound of the WPR2 region.
+        31:4    hi_val;
+    }
+}
 
 impl NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE {
     /// Returns the usable framebuffer size, in bytes.
@@ -156,10 +165,6 @@ pub(crate) fn usable_fb_size(self) -> u64 {
     }
 }
 
-register!(NV_PFB_PRI_MMU_WPR2_ADDR_LO@0x001fa824  {
-    31:4    lo_val as u32, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
-});
-
 impl NV_PFB_PRI_MMU_WPR2_ADDR_LO {
     /// Returns the lower (inclusive) bound of the WPR2 region.
     pub(crate) fn lower_bound(self) -> u64 {
@@ -167,10 +172,6 @@ pub(crate) fn lower_bound(self) -> u64 {
     }
 }
 
-register!(NV_PFB_PRI_MMU_WPR2_ADDR_HI@0x001fa828  {
-    31:4    hi_val as u32, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
-});
-
 impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
     /// Returns the higher (exclusive) bound of the WPR2 region.
     ///
@@ -180,6 +181,14 @@ pub(crate) fn higher_bound(self) -> u64 {
     }
 }
 
+// PGSP
+
+io::register! {
+    pub(crate) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
+        31:0    address;
+    }
+}
+
 // PGC6 register space.
 //
 // `GC6` is a GPU low-power state where VRAM is in self-refresh and the GPU is powered down (except

-- 
2.53.0

