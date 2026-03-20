Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62A3108B912
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A7EB10E1F4;
	Fri, 20 Mar 2026 12:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jPELCTIV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECB610E113
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNykxwGIwPiEG37PNxLDrqHz3sdd7QAkH4VYtq5/3I+Dt/dSZadMg/Tb1xqmnqW4GO5vnpueB4AeRhRzYjfAGlRyJuidvtrmrthQSNoCrZjYlbS3W6+7m5H+MIPGq9Thoxz0CgiElML86Mm8JYH0upY7Gps9nq7IOEl2YyDlZ+qq1CDcmsC/Xlj2EmL+ePmuqsQSYtMGN5AIQaGSq0v5uZuxaeGDvCUA4l5UEoyHIP4rxWe2gCXk7aVYAzL02EWcBIoYPUo88eOcibpaqIXngQzMfyzdSbCtYMGUv1NwgX4vHcuLxVCr5xLxqjZ3+01zqmjw/xJRokLPcIv4M42sbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7OTRh+oV7I8omwin++Z0gOb4aQtwOecYvUAHEfyPzQ=;
 b=bEnB3LBnm2M0CsLT1wryWVWb2vMzjHsbBYxwyD8xh0RScSqXmP+0FxKkyaQtxWfaQ4OlpnbKuY/W/VL7fEChL8ffv+PbY3CWZajAeLqYzmoalzMoao1ZVts27FnHgk4SP3gXta4r3MOyuBVfTbLBs0RmOOCP1WnwCJXvaLvJLS6JV6XlpkUi9rPBRPMU+pwTC9MzG2gXsgZsVvF5r1+eVq223aCJ6E47VLecn7KHmnsTmBz1ZegX5JpdMNFaRhpUgNOrHibxcfyY4P/alRTuSxvGxCBSfnbVXEVNx5YefqU3alSo79mmweMSocNsQOYA9mTKaoCjs2KRqExMjazZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7OTRh+oV7I8omwin++Z0gOb4aQtwOecYvUAHEfyPzQ=;
 b=jPELCTIV5bOjYVTApSS3s/ycA26P2H69DoL5zX/g/LHpSFknm4nXoyBxJBFrC7gg6vpVOHzLNRpNaT3I9xzrGXYIwvhaUr8z2TDGXvmNCHzCR/Omnz/FghIQb/sftLN1OR55yy54XWRGY7gJuQkwUbC/w0uGn6TjC9U+w0OXAgAdFhrqtDbRhxmST0U5ZTJs3orM/yzmYiPx6hza1GsBqcQu4la6foJvobT9KIc7Fe8viRRXRvGZqJxSBfwup6psooaXGMlOVDZbDiLnmCP0kktZMUzSgTg6imeNFVL/1ScII7D6R5dCfNIctuS8a9DlZ8y/tUmEZt7a3iOnRg5+lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:50 +0900
Subject: [PATCH v2 01/10] gpu: nova-core: convert PMC registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-1-88fcf103e8d4@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9afbdc-203d-4b41-1ac0-08de867b02cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sW/JuDPKy3rKdAuyrubmW6I+m0QwXTTx6snaDQ2mIjqKOalg7NXoqNjzLX6+1mvcij1JQQoumzTDYVXIs3fmQjEkVoUl8hVDtv8k+01vAqacsgH3ot8PEDAa9VvGXPv57RTxCFO3ZSncm2nFFGXriGPidHPQut4riGlkI5igaTxgEwCis9d2mKNhn/px0aVmOa/0OaoAL+6hy3vk6pgPRvye4REUF2EEYmVVevP3cyECyNo08IQSDD4/RzcOajxtZBPchWa4XYQj7hK/R6sanUmYLntGHvh8IecN4oB1IiUkwd1/MKQDv1ltyxqiUwQwdCBkfiAnKjpMsNv/sSu5nC3yaTv8pFj3fL3NiQ1kd0/HVcofGfaJwX8E7NhL7DiwbOGnPP9JZ6vjc+TmC1yL98ANgIQpAbF+539m24aRwLcBUCxmrJs0dHUyThsC4OIplpMvsH5gvWjVnJmYgdR0nLemfDwa59QHgfbUN0nQDDqNmi1ZMU1UZjUX2A4LNTSRIij0Gof1IAb1+Z53B9J4qk5JVAXXh7+i8TnY1EsJt9nSxD2O1Q1pl3Am6kqXQYvDXmBfKO4dpqKUp9/OgboyMrU4pbnx5YtPXys7cst0Gbmo52s0Jo8WSChUv7OZ/pQ7pZXmoSzP2RvQqrcGG+dA8N1FSP0m9nB4yEBqSrBwmMQa/X57CREMuPDdF0K2+05rWbnpUz0wymSYvxXZrGT04u44BWAV8zJtkCvWdWUQITirifLL4WjDFRH5SU4uabd1q6lMpa5fAikqF3XD1pFnhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZCVzlTRlkrOXNZTnJOMy81bm1UNVBQcC96STBlZVZRQ1NEUk12ejR1bUlQ?=
 =?utf-8?B?bllFRkRmZ3R2MXJ6a0pDNDJJcmhKU0wvU3VQdml4S1RQUzZWS3FtS1B3emgz?=
 =?utf-8?B?Sm9wd25uOU9jbnlqM0FDbVlObDA1OVZPWUVSZDM4c3loSEFJbWp4azZQcTBn?=
 =?utf-8?B?bmhRQjdsTThOL0VZYXV4TWxwUjIwWHZCRnJwQVZuNFFXWnlCUUs5RDNZNEdz?=
 =?utf-8?B?U1VJS1pUZ1ljdjdVdDBNWFlnM0JEVEFhWEErV0EyaVBsdndaV1BrV2RmQ0tw?=
 =?utf-8?B?VzhTdnJEakdmUkVaYVdEc3NkL3RhaFBPNDBiak9EZ0JwQ2pTaU81d2ViRjlG?=
 =?utf-8?B?RmllUXBTY3doU3Zwa0laeEVJNVBOQ01ZNTRZaE1QVTZLQ25DUlZERkdKMjYz?=
 =?utf-8?B?RjBtTkVKUEZpUm53Z0RRa1dsY3ZmeTdZL25Ka1FEVVpYUVpLcjRGeVVKc3Vy?=
 =?utf-8?B?NmtZMGtJSnlqLzBSMmlxajFKb0kzdGQwNVZaQmFuNHdRVzRQbTh0a2ZHcWN4?=
 =?utf-8?B?V2FaSlZIS1gzV2tRYkhhQitHQW9wbUVLeHVkK25waVIxRmtycDdzRHBCSmIz?=
 =?utf-8?B?c3k2UG0rK254OWNXeTdTbTFVWHpIRUJBR2RPU1FLMmFHSG9sODk3YW5nOTBh?=
 =?utf-8?B?NDdzVVRMWXJFZm1HNFdvSTVtb2JqT1ROd2RpVVJDMi9sZE5IMUUwZmRMMlZX?=
 =?utf-8?B?eDQyVHZlWXQxOTYwSDcrdFpFWGpKUG5oR1NXM0ZLQ0IvcVIybXNRZEV5VFl4?=
 =?utf-8?B?NGJpbVA4WTdtM2E2TmJYVlg1dGlDV1RlcDhMUmFtYVJjcTFHbUZqOGhYUzJq?=
 =?utf-8?B?UTYxbmpwNGlNd2N1QitNQlduNVFHdEgwc2h3R0JBakc4SkpRM0ZUMkJyMmIr?=
 =?utf-8?B?K2t3a294aitHQ0h6bUxad2xnaUhzeDBKRWRiQVhqK3F4dkhCcVJiaEJUL29H?=
 =?utf-8?B?VVRHeURHMG1xallIRWljN2pKYVpZVUdnc3FMdWNicXNFU1VkTSt4eFg4VXIr?=
 =?utf-8?B?VjlXTWlna3BSa2ZyS1k2M1ZubTZOcGlKd1BwNTUwYTRMQ1N6SVV1a3dxU3A1?=
 =?utf-8?B?cENWTExqK0tDMlE4V1lVeVNEbDJLWmJLRmJXeEhHcDNadWY2c3YxQSsxVUM1?=
 =?utf-8?B?SEd2b1lLZ0xIYmFFU3hoaWVQZk5GRXpXUHd6KzJCZk9QUnU4MDRiaW5xNnFI?=
 =?utf-8?B?cjhNd3F2bG5FeEZKUHl2S0JjUlY1VTV1L0Jwc2Z3MDZKWWpIcmlIZE5nc1ZG?=
 =?utf-8?B?bE5MUFMwNXIvTTNKYi8xODZnR3EraXZSM21hK1hENXhDeXBWVTI3T3kvcG1Q?=
 =?utf-8?B?dGhVQkFGZ2Jzdm04RXJvT05aNWxGZGJqeWx0anVmWDZKRGpQQ0RoMm4xalE2?=
 =?utf-8?B?SnpHcmtJYVNBb2MvcVVnMU4vd2J4SlVISk9qY3VKM2dGMS9ZSG5DbEIvMGJm?=
 =?utf-8?B?bFNvNHFhY25GWFVsTnd1WDh4RFJQakhtUzlLM0ltTndBMVZveDRtZkQ0WGQ3?=
 =?utf-8?B?YjJ0UHpESHVoSWVkbGtsanhYeHl0RXo4cHNuQXFUUGVIVnBZeWx6cmRzdG5V?=
 =?utf-8?B?bXpSRXZXUXM2NDZ2cVpMb0c1ckZvbUJyRUVOVkozNEVSb0Y4Ny9DRTIvT1la?=
 =?utf-8?B?NTFKckdDSEhIRG8wNjdlanNCTmM3N1dGWXFOczZ1N3RTTXdTV1VQK0FWTC9i?=
 =?utf-8?B?N25aR1JZOGh4VGQwQWVBMWo4VG9KOXNkdVhYN0l5bmRnYm5RNnlCNXVWeVNt?=
 =?utf-8?B?b0tqaWtub2R4K3ZyYjZ5VFloUHJvQ21wQUpOZkFsU2Z3RGo0RDJHREMrdita?=
 =?utf-8?B?OVlLWG1BaGs3bmhxeTNDWnMyejE1S3Q1L2hpdVcyc3k5R2JncUtjU28wbm0y?=
 =?utf-8?B?NzQ2Z0xicThSRHR6ai8wUXdRb3NpU2ZmUEl2alZBcFNIdFZrSzVUTTNoWFhU?=
 =?utf-8?B?RVFISlIvaWJIQm1zajg1U29mYXM1S2QrcE9ObXV4YnNBQlhVbFphbisyWmVm?=
 =?utf-8?B?SG1DRVg2NS9yV0grQi92UHY3YlI2QXZ5VTlOWTRzMWV0cjQrK3JjRndRdHFE?=
 =?utf-8?B?VHhlUm80RDhqRlRXS1o4aFlMYUd1YlVqYjhkSzE0dE0yUGJIU2wzcUlUNlpu?=
 =?utf-8?B?KzZ4c0Nxa0RpS0I5ZjJIMjV1bjRjdVliMSt5ZkVHR1k1M3p5UFZWcjNvOFJt?=
 =?utf-8?B?VE05VGxKY3AyVGFDYWlSc0tkOVIyTVNyaC9xc2ExWE83cmlQeGhhUjJxMzFm?=
 =?utf-8?B?aWhnc0RkeFBya3VOMExKajdrMjRUdTQ5ak4zL083VmJvL0ZXaHdxRDJkamtN?=
 =?utf-8?B?dTNwemJtamFiV3IrNDNmUzYzaVVXUGFtc3BUS2xyQUdOUitKZEV4U3ArbURz?=
 =?utf-8?Q?InBVGJ/Kw0gBvicdq8BjG3In4zqQnOvcgoBM7oGSJb6Kr?=
X-MS-Exchange-AntiSpam-MessageData-1: p3kdEcXMeOceKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9afbdc-203d-4b41-1ac0-08de867b02cd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:02.0822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLBBzePyRsNa4SjqLLcNGjAPAAONEivRAQxA2U/D+5JyvLzowiv401lkqgk0+KkK9coOg6n6PQDw0Up3C000Xg==
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

Convert all PMC registers to use the kernel's register macro and update
the code accordingly.

nova-core's registers have some constant properties (like a 32-bit size
and a crate visibility), so introduce the `nv_reg` macro to shorten
their declaration.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs |  7 ++++--
 drivers/gpu/nova-core/gpu.rs    | 37 +++++++++++++++---------------
 drivers/gpu/nova-core/regs.rs   | 50 ++++++++++++++++++++++++++---------------
 3 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 7097a206ec3c..5a4f7fc85160 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -13,7 +13,10 @@
         DmaAddress,
         DmaMask, //
     },
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     sync::aref::ARef,
     time::Delta,
@@ -532,7 +535,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.hal.reset_wait_mem_scrubbing(bar)?;
 
         regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
+            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
             .write(bar, &E::ID);
 
         Ok(())
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8579d632e717..cb549c8b254f 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -4,6 +4,8 @@
     device,
     devres::Devres,
     fmt,
+    io::Io,
+    num::Bounded,
     pci,
     prelude::*,
     sync::Arc, //
@@ -129,24 +131,18 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 /// Enum representation of the GPU generation.
-///
-/// TODO: remove the `Default` trait implementation, and the `#[default]`
-/// attribute, once the register!() macro (which creates Architecture items) no
-/// longer requires it for read-only fields.
-#[derive(fmt::Debug, Default, Copy, Clone)]
-#[repr(u8)]
+#[derive(fmt::Debug, Copy, Clone)]
 pub(crate) enum Architecture {
-    #[default]
     Turing = 0x16,
     Ampere = 0x17,
     Ada = 0x19,
 }
 
-impl TryFrom<u8> for Architecture {
+impl TryFrom<Bounded<u32, 6>> for Architecture {
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
+        match u8::from(value) {
             0x16 => Ok(Self::Turing),
             0x17 => Ok(Self::Ampere),
             0x19 => Ok(Self::Ada),
@@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
     }
 }
 
-impl From<Architecture> for u8 {
+impl From<Architecture> for Bounded<u32, 6> {
     fn from(value: Architecture) -> Self {
-        // CAST: `Architecture` is `repr(u8)`, so this cast is always lossless.
-        value as u8
+        match value {
+            Architecture::Turing => Bounded::<u32, _>::new::<0x16>(),
+            Architecture::Ampere => Bounded::<u32, _>::new::<0x17>(),
+            Architecture::Ada => Bounded::<u32, _>::new::<0x19>(),
+        }
     }
 }
 
 pub(crate) struct Revision {
-    major: u8,
-    minor: u8,
+    major: Bounded<u8, 4>,
+    minor: Bounded<u8, 4>,
 }
 
 impl From<regs::NV_PMC_BOOT_42> for Revision {
     fn from(boot0: regs::NV_PMC_BOOT_42) -> Self {
         Self {
-            major: boot0.major_revision(),
-            minor: boot0.minor_revision(),
+            major: boot0.major_revision().cast(),
+            minor: boot0.minor_revision().cast(),
         }
     }
 }
@@ -208,13 +207,13 @@ fn new(dev: &device::Device, bar: &Bar0) -> Result<Spec> {
         //     from an earlier (pre-Fermi) era, and then using boot42 to precisely identify the GPU.
         //     Somewhere in the Rubin timeframe, boot0 will no longer have space to add new GPU IDs.
 
-        let boot0 = regs::NV_PMC_BOOT_0::read(bar);
+        let boot0 = bar.read(regs::NV_PMC_BOOT_0);
 
         if boot0.is_older_than_fermi() {
             return Err(ENODEV);
         }
 
-        let boot42 = regs::NV_PMC_BOOT_42::read(bar);
+        let boot42 = bar.read(regs::NV_PMC_BOOT_42);
         Spec::try_from(boot42).inspect_err(|_| {
             dev_err!(dev, "Unsupported chipset: {}\n", boot42);
         })
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 53f412f0ca32..58fb807605dd 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -8,6 +8,7 @@
 pub(crate) mod macros;
 
 use kernel::{
+    io,
     prelude::*,
     time, //
 };
@@ -37,18 +38,38 @@
 
 // PMC
 
-register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
-    3:0     minor_revision as u8, "Minor revision of the chip";
-    7:4     major_revision as u8, "Major revision of the chip";
-    8:8     architecture_1 as u8, "MSB of the architecture";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    28:24   architecture_0 as u8, "Lower bits of the architecture";
-});
+io::register! {
+    /// Basic revision information about the GPU.
+    pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
+        /// Lower bits of the architecture.
+        28:24   architecture_0;
+        /// Implementation version of the architecture.
+        23:20   implementation;
+        /// MSB of the architecture.
+        8:8     architecture_1;
+        /// Major revision of the chip.
+        7:4     major_revision;
+        /// Minor revision of the chip.
+        3:0     minor_revision;
+    }
+
+    /// Extended architecture information.
+    pub(crate) NV_PMC_BOOT_42(u32) @ 0x00000a00 {
+        /// Architecture value.
+        29:24   architecture ?=> Architecture;
+        /// Implementation version of the architecture.
+        23:20   implementation;
+        /// Major revision of the chip.
+        19:16   major_revision;
+        /// Minor revision of the chip.
+        15:12   minor_revision;
+    }
+}
 
 impl NV_PMC_BOOT_0 {
     pub(crate) fn is_older_than_fermi(self) -> bool {
         // From https://github.com/NVIDIA/open-gpu-doc/tree/master/manuals :
-        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u8 = 0xc;
+        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u32 = 0xc;
 
         // Older chips left arch1 zeroed out. That, combined with an arch0 value that is less than
         // GF100, means "older than Fermi".
@@ -56,13 +77,6 @@ pub(crate) fn is_older_than_fermi(self) -> bool {
     }
 }
 
-register!(NV_PMC_BOOT_42 @ 0x00000a00, "Extended architecture information" {
-    15:12   minor_revision as u8, "Minor revision of the chip";
-    19:16   major_revision as u8, "Major revision of the chip";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    29:24   architecture as u8 ?=> Architecture, "Architecture value";
-});
-
 impl NV_PMC_BOOT_42 {
     /// Combines `architecture` and `implementation` to obtain a code unique to the chipset.
     pub(crate) fn chipset(self) -> Result<Chipset> {
@@ -76,8 +90,8 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 
     /// Returns the raw architecture value from the register.
     fn architecture_raw(self) -> u8 {
-        ((self.0 >> Self::ARCHITECTURE_RANGE.start()) & ((1 << Self::ARCHITECTURE_RANGE.len()) - 1))
-            as u8
+        ((self.into_raw() >> Self::ARCHITECTURE_RANGE.start())
+            & ((1 << Self::ARCHITECTURE_RANGE.len()) - 1)) as u8
     }
 }
 
@@ -86,7 +100,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
         write!(
             f,
             "boot42 = 0x{:08x} (architecture 0x{:x}, implementation 0x{:x})",
-            self.0,
+            self.inner,
             self.architecture_raw(),
             self.implementation()
         )

-- 
2.53.0

