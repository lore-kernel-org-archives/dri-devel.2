Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC3D108B916
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C669D10E113;
	Fri, 20 Mar 2026 12:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhAtEA1a";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B199610E560
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXPF9wSfEfesMEFbcEKWnI1N6+7U/ySXzPy20U5cQfNTywdRSZUBC99boUP42Ii2O4KRksQ+gnDUNY7F4xBlzM4b71GQ9LSDoj15/YKlfT4ls+vbYDl+UYB6UT1A5DmxSCEn14McdskbRyyl6290rrQV84d6DiGJKmXJ8+FzVMyD1RVHeIXHbEDmJQ6dekE/4Fc+q1GWWYhmHRFTspaLLYTh2qfbAqeG1oWWXdtS5hUWmghogvJQiW7GIIr0sbaYOBA6NSGzEvaL37u5+Nxhxv6/ZROkK9JRtjfET0nB6EGk/+IrhsgVPWvjsQN9Wfe42tEygtcklgUtU87j0shT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFgqPKXaOo6GXqQVjuqV3Cn89bQ4JL5XUhqcxU7yeAQ=;
 b=jwts6VZaFiyPyXl5za6IBVLxsGTqw2lyR39YI3xhZN4dsb5E5IjlSMekOfU6wo105rhUzct+X4pduJYiHib8y881+yZKfFfu8P0g9ZZOlAlVaV460jVWEUndB1IrYy/GjpmOfS0gqHR08k/RdlQufmLiK1X9T2JkQ6VijEDSn06FW8j4+KgdmQFh8wbsiAfk1hCiitvYRARLPc2g/gxG848/iao11y/7mDxeEpy+zLRAYR3pfXAr0pUAzL0gRb1DoFV3ScBa8QawHq1HtaHs09xnZOpxgRcsmtvAXC3iJhL6V5ylxa7q6g69WqtTSNleVEQKroawHpzYwjcXj6A1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFgqPKXaOo6GXqQVjuqV3Cn89bQ4JL5XUhqcxU7yeAQ=;
 b=UhAtEA1aD1lZ6PjXELOdBdoKfPQ4k8DveWQUlM0PDAVfrYi37xucQTNpC82tWM2F1Lhvc3tm1Xpfk6r/GqXyzTYH5m9K2CYdoLy0qIjCbHJNc8mKxzvWKLPxmJzmQFkar1ab7l8MykCjib7b/uvcHWzCtTfJ2FknvGjTf/vukWnQEVDSl/MWCZ669xJ+zA16WN+B80FpJ5O4EqXrC7J7eMTX5HNR+rLKVnODg147IfmHHmkYM9gdIrGyNhE7RfG4Ndizd7hnokBLeacyN/HUsTnyRZdPF+lwi7qEOnLzePpsDvkaEZgS8Iaon/BK0sN/3uQ9N8MTx4CBEo2nTAr51w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:20 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:55 +0900
Subject: [PATCH v2 06/10] gpu: nova-core: convert PDISP registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-6-88fcf103e8d4@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: a5183bbb-782b-4f5c-8c79-08de867b0de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: BFPuFdd4TqbaTuAUTyheheQ4a3mXrUtWCuo4SsX80X7ICUEGotGVO3Bz0r+YzPJCeCqeNX27lQCr0Vf8cDDXdr322NvvNs9A1/uAyF3vxspGwxIqsFCq8mn6jW0kMjqmRfxLkR1E6i2tVV0iZZn9Jyj/BlmH1RZm5p9k6JwxFUKkGDytMqt6u0gx1MxWH/ZZgDaKQTuBoyCSnLzmhPuLAiQYbO1+G6IWzfg2TNo1M10ZkcInx18HgAU5Hwz8aRmKxmRlmgd/tnbQUSZjO5YxMHacbIOhHMjzvbslKhyyOvrLVkAq/b52zhXjyBS1zeMRFD9aBNKVJ8Dkq2tljxiRmMp/d4ilkoc4Sf5P6ae+XjyrnFw40lWhSwrXuhY55O7ZxGHPs+ZOu0DG5et3XQLhQGd1b2HuwV01MVS/uaWC69shA7hSURL4XHndHCQN7QUdpEOs4YHB9IslunOve4kg6AUlmB0u/FONDpHAf3pJQq9X5VTfBv2aC6kz7r3K2vTTfng0W7VGeg68wy7QWaVbudFHBQAfp2u8E2qs9QAxLHjGbephGd+sJtiULuihoIjPx5vQ6XoNraeAIcU7RObeLZN4n957/XqCeabHnPiCW8B7oGM2VscrWou9HCp66andZgNhERwhPc76Ge+oPVnd4mmhpPO60NnakY6Vg1yzHzxRR36yrfUfuxK8gn1MRr3TWIEP3uLLaaTePp9ApvOHLVFIBHXDYzYx7v7VAAubmoDPjul7sHnIpwDsCRlXigleGPk7viz3hNcaK6l/Zj5Xow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmxEN1lLZTZnN1ZBVkkzQ3I5M2dGZTV0dzR2YVRiejdCSHZRdTc4YXRFRlBv?=
 =?utf-8?B?Tzc2eVpFZEdCWjFRTVFlL1dlNkdISlB5TkNid2crL1F0MlNpZGNtN1d6WjhC?=
 =?utf-8?B?Vm9aWUZPSUJyUXFXN3BrV1VvdFVWSmFWSEtxNklrQ2FWbEptNk42alJiaVdH?=
 =?utf-8?B?YndPTmVNckdrREpoS09PUTJrb2ZMb2Iyc0VjeHI0MmMvT3RZc0pJaStLUW5y?=
 =?utf-8?B?R3VSVjE0QkxaQ1VFamZlSE1ueklTaExwcVk5cWZSdjlBeVdja3V3YzVZalYr?=
 =?utf-8?B?dDZmUE9XS25CM0NpcmRpL0lUUHJ4MUN4SmpUWmlCcnhJcUlQSytjWkQ0SlZq?=
 =?utf-8?B?MkxycWszUzg5b1ZGM3RVejhnb3VrNS9qbVpCdDFVVFp3TllvR0FtSG01bmlB?=
 =?utf-8?B?bExlampoaFRWWXBFWmxQSHpvcEY4aW81YXMzQWUxclFLMHM5M2h3eW5hbHBm?=
 =?utf-8?B?RmQzaGxrTGZZVWRuNGxMUGJGa0NHWkJkY1lwNUhkKzZLeTJMNlhjOExYK0Zw?=
 =?utf-8?B?TGoxSkVreXNFNmNkRXk1TkJEa2pkQUI1a25kZ1htYzdKcWc1dGhyK0xncTU3?=
 =?utf-8?B?bHZZLzVUbWV0SE5vQjFoazVQL0F3cnBpUiswcXNLT0V3cU5CYm9NbW5iY2s2?=
 =?utf-8?B?U0NUak9QQlVSZG9SbnVLUEYxaS9JbGFGZG94VHNRSlBrZGtiRDBkdTdBT3dK?=
 =?utf-8?B?d01DendoU1RBZG03MXNUZERuWmtVOHRxL3JHTHMrWWUzSkEyMGF4NUZSallE?=
 =?utf-8?B?RmJJZVJ4ZHVSSXp5R3drL1AzMlk5bDBlWUdQTEM4ZUJLTkR3RjRqU1l0YmZC?=
 =?utf-8?B?aVRwcFlkaDV2VEdaQzVqdndTbGpLbHZhYkpoNnpuTDhmcXZDUmNNNmpyVktv?=
 =?utf-8?B?cUE3Y1M4MDl4SFExd1JicG5rc3RRdWswZlRURmt5cWRZZmh4KzlTK3JHcHZY?=
 =?utf-8?B?MHlkMDJ6TzRuV0F2K3g3U21QVW9BNGhiK2ZYeG14TlltMHo5ell5dnd5MWw0?=
 =?utf-8?B?YXIwc2l5SjFXK1VwT0xRS2tiMzVSZDRxNDNadXRZamUxY2dyWlFjQWZ6VHVu?=
 =?utf-8?B?ajFielhSNVBsWnQyZ3YwVU15NzdRT2kxb1N1MVBGU0s4Y2lrNlIyUDV4WnRW?=
 =?utf-8?B?MHVRNERldWFxSk1UWWFCc2Raa3BqSFZrVzJYYVBPdGF1ckp5V1A2cHY2UEw4?=
 =?utf-8?B?bW9hSlNkVmdUaEk1bGkrYVc0MVRPM3JqWVFWNlpWb0lOOHlOaHR2aWR3VXU2?=
 =?utf-8?B?VFNIZXFydk4wWGR0SnFhaFhMbGtoUEQveWJDdGRZRUtobFZWbXg2VEhFOEtN?=
 =?utf-8?B?WlViYVRVWkVpUnVqZWkySUg3UzdVYVhGWjFDSGJ4ZFA3cy9OTkhKN3g1TWVD?=
 =?utf-8?B?N1BRR3E4aE9uWllBTTZIVUNYREd4aTJ3VWJzejdJZjU4Tys2WU1OaTVscDlq?=
 =?utf-8?B?SUJ3OTRaSHNRWmkrL1c2UFhlQmtSVHp5RWM0bGV2Mk94YUFqSGFLZmN1bTBQ?=
 =?utf-8?B?aTN0VThYQVVYcDdrUFF2NmsyTUFIR05OMFM0V2dHcVkvSG14S1IrcVpab05X?=
 =?utf-8?B?ODlNQ0hwNURCRFplOE5mOCtpWlUwamhHb3dSSkduWVNvSU56Tnc5QmpTV0VE?=
 =?utf-8?B?ekt1ajRQa2ZRbmU0dCt1dUFpRFA1VUxNemYwQWxJWFJ4OVA3Y3JwNkxOUDVC?=
 =?utf-8?B?TDdUN3ZqSmg2S3B4Q2dQT0FpZFBzN3AreGFBTTFJLzNwMS9HYTlPUEJDRk9G?=
 =?utf-8?B?SUgzdndxb3FYd3RIMUNFZXpoZUxtSEQ4c2U0cVZzTlZaSTJPWlBLSFBPTVdp?=
 =?utf-8?B?VGdNaitKRit6Q3IwZklKQTJXT0Q4SHIxSXpBbkV4T1hOKzY1WmFqMXJnYkJa?=
 =?utf-8?B?S0VBSWhpTHFhSmRTcStTZkZxQ0tlT0dZZ2ZCUFFkNVBqZ2pFQWY3N29oRkFq?=
 =?utf-8?B?amFITndIK05hc2xBQzFqa2NVRWZrQXFFN1VkM3IwTi94NGRXNFYwb3MvY1VI?=
 =?utf-8?B?QlJOekhYNzZ5OVBqaUtkTGRKbDhoamVvU0xsRzl2SmU1aTBGNlJpMEtZampE?=
 =?utf-8?B?ZTZ1M0puNTJWQW1qdEtyTDNxeGxmbUlaQXIxRW5yM0VFSUdZRzdUbVVMQXFo?=
 =?utf-8?B?TlRxbFNlTkxSNUhJR1dncWJUWG5DbERrZ01kR01TVVhETk10S2paNVE1TzRE?=
 =?utf-8?B?MWNHaFpIMGZwY2grQm9jUXlHTkdBbStjVjhCaU9XMXNaWUsyWUVHZGdZODI2?=
 =?utf-8?B?amE3NXh6Sjgvc3E4UGRCajlLdE9wYnVNZUhWWFdmdTR0dmNTb29jUWUyQnZP?=
 =?utf-8?B?NytUY25jZTk1WU9hbS8rS2s4ZHBmaTlmTUc2VEJqam5Haitpc0xveHlOQkFU?=
 =?utf-8?Q?dm7wZZgVn7AGGDoFxOHkpNmNQJS/asx4WMwPhLtwljfBi?=
X-MS-Exchange-AntiSpam-MessageData-1: NzYjX0rRAXqpKA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5183bbb-782b-4f5c-8c79-08de867b0de0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:20.6430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W36vHHqMzXE5a4U7xJxlXlXZoDNBLSq6gy0eW6EPy9o4JtbS+FQiwvE6rlsRaLbgXf+QYByNQ1G8kr2IlvVEHw==
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

Convert all PDISP registers to use the kernel's register macro and
update the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs   |  6 +++++-
 drivers/gpu/nova-core/regs.rs | 12 ++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 6536d0035cb1..62fc90fa6a84 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -8,6 +8,7 @@
 use kernel::{
     device,
     fmt,
+    io::Io,
     prelude::*,
     ptr::{
         Alignable,
@@ -189,7 +190,10 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<
                 let base = fb.end - NV_PRAMIN_SIZE;
 
                 if hal.supports_display(bar) {
-                    match regs::NV_PDISP_VGA_WORKSPACE_BASE::read(bar).vga_workspace_addr() {
+                    match bar
+                        .read(regs::NV_PDISP_VGA_WORKSPACE_BASE)
+                        .vga_workspace_addr()
+                    {
                         Some(addr) => {
                             if addr < base {
                                 const VBIOS_WORKSPACE_SIZE: u64 = usize_as_u64(SZ_128K);
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 61a8dba22d88..b051d5568cd8 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -250,10 +250,14 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
 // PDISP
 
-register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
-    3:3     status_valid as bool, "Set if the `addr` field is valid";
-    31:8    addr as u32, "VGA workspace base address divided by 0x10000";
-});
+io::register! {
+    pub(crate) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
+        /// VGA workspace base address divided by 0x10000.
+        31:8    addr;
+        /// Set if the `addr` field is valid.
+        3:3     status_valid => bool;
+    }
+}
 
 impl NV_PDISP_VGA_WORKSPACE_BASE {
     /// Returns the base address of the VGA workspace, or `None` if none exists.

-- 
2.53.0

