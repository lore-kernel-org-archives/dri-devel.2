Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE793CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1F910F331;
	Thu, 21 May 2026 13:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="se2s+4eL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553B210F331
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkgYJI/gEnHfKdPwXTBSkDRHNJ63yJf3x0tsljPOWh2LQPFzXJ7Y8y1WAVoc6WkTy99okTp2v2hIgMlto7A/NUBbD0ix7Uuncrj6UrwTijnm9pSn3X324x8ZmOaHWTJR0GWV9UgYEsBn0DVxn82f6JrG5okQQCppO0phLsnwliytg8eH4WTQkdZzlAbF8L0ynBO779B96qSXU4jlXmaFebDEeUsbHYZc3xlZklbF+bzhChyRKCZ/mTVTR68sgUq8a6JifuMDHUs6uPptf9SV0n02y8SuGVw0ALnoQ2puROdedloAo0hw9dDvxM4qS/jkaWDCOCsA2pHMN+p7VjkL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04wZeGjBesoYHQntXHqQPxOclu3HsRrqvXcpE48Vy+c=;
 b=W0BGOaKXwYGBNKN9AGrtEZoypziZSVjSezhWQcSrd6/YpXh2tAk/ILqfkzNjqG142McowmgSinYzByi/uYCILmGynhOP5W6a3+ZKe+OgQkUlGWhPiuJ0LBn4qz9yot3Rbs6EPStD9/7GMX3UDYcJay3zDL8RuJBrbvJvlIKJqmmQadoh7cZ+Fy7QCZ3DsQmjW5kB1QqeKMxCWYWd7AuVAqto3z8Lz5qslxaTRKg+WoDL1aBbfBhSQajldDLeJSJJs1Wgm1Bn6v8NmHwD0RiLINr1UaxBIFLQpDhmfYHkOVJb+5zQ5d0VYm5aXrDEXCMd4OliLKZykDiXmTGFhQzxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04wZeGjBesoYHQntXHqQPxOclu3HsRrqvXcpE48Vy+c=;
 b=se2s+4eLoux1IfDUOM+7syNYwk7ao40n9yDbBW5Pt8DQt6hN7eZ7sxddj/sijvkTYEpbzcXQS3vf54jMsniHoLqcUnzh9ncPHIZilW5RJpIu/Z5lBryqMPOlK+4ZPXIMzm2MMKHi3C7bXQ7ze+d7d7xkVvvJ826U2nACmg979ilShrCDwQX3/wzXKYq1cS8piz7GNe8KigOGgNDD2kvOuGlW/Goi8aj2yONcfm6m52uYj3/HdR4mzqNhuxr0+YvooE44YIcjwbUcU9x00h3ut0HekQ4ZHx0LDPtxxhwodKJsWtENCc/94jjtcm47+NIrwfgKoK/4PU55Hv96xCMnWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 21 May
 2026 13:51:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 13:51:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 21 May 2026 22:50:53 +0900
Subject: [PATCH v6 6/7] gpu: nova-core: gsp: move chipset-specific parts of
 the boot process into a HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-nova-unload-v6-6-65f581c812c9@nvidia.com>
References: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
In-Reply-To: <20260521-nova-unload-v6-0-65f581c812c9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0121.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2015df-eab6-4738-823b-08deb7400a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|3023799007|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: PxHTKLBHPvY1D3f4FSkEB9kyRe7k/HA3rIhUsekagGjLB9v809FG1+j6BaLkphoT+Ha60tsb1LPlwaGevGp1IcyZ8tW5+1orrWfQ5zo8suuwwjE9PQVa2hyhn/8JFnBzjfRlSnNk/jOVmfzlXQUdWI0bQfaxXSqB6hN/6kpMsoFoA4Fyjc4RffIn97iQcC1wKrNWydkkxA92r5key7dYjY1/RXctmnWBcyQO4IrUG2TVrDuCKrwJmKA5aLTlSzHM7HDBeJ3n05XZ4s7Yiknd7JNhz+rbpOG1jLmLLc9FHpF7kwOa0Q3j+EwIRK2LeU/oY81W4NPiCenfAvdGxZbVoYaf+mwuxj3bzGIwpR9LTcc6tIRCjXRPP+gtj55rB76jynYA2E53z5B1p7jU1eyt8GcRlclzkel6Y+lq3BFU4FqMfiUN3IyntEdC/lS1C1ltRihdaWCfqXhFJV9B/JkbTIb88MlqzxFCBKAcBNk30CMxPsjPKTQUL9w2O4pmbXAoBmgZfM33WIVpheXh/4rJ/RZ+bBcKrGv3bxglZjld+2Mxdd3WA+/GT+WbyAmuvMXFyebPOBNiMoGMt3rrVLwW3RfJ+ohlg9CD3enWNXC20YB67tr4oGgEtLx5uHe3W3eR5lEXWEisoC0yu2sR487WBU2IQ7/x3axZ32tprM+WuSHLRQ0gSA3yNlOZQW0nhZIQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVLeUt2d09nTUdqem5kVzVkdzFHbThiNmtyVVcxTVhGaDdqWXdGbWxwVmxV?=
 =?utf-8?B?TkJVSFU2blFHelpZKzJRNkJNbFpPQkdZZzdtRVNUYVAvSFJYMDRWV2pKVnFj?=
 =?utf-8?B?eVVLY2FwTHJUdStDR1ZUMGpGeFRVYzgya2h2a3FEanJ0SFBYZU1YN2xDeGJE?=
 =?utf-8?B?Q25PaHJwUUNBb0RrcVo2eFM4dklBZzVCSDV5cEZVZ1BWMzkxUXowaWxYeXA5?=
 =?utf-8?B?djkvTityU2VPY0JsN2syUHNZYUdlZ2tmcDZ2WFJkUXdIUk9KSXhqbnRYVncz?=
 =?utf-8?B?eGZSdGtYYVNRWGEwZEFqNHU5TWI2aVhPbWJWNk5QYVlyM3dIcGd6MnFEMEMr?=
 =?utf-8?B?ZWtkT2s3L2l3STBvK05vemUvL1FjbndLalhyTjZQckJTeUhBd2NqMmdEYjJl?=
 =?utf-8?B?YURRS2dWK1B2TW9HU0FNM3lkbmQ4VjlyU200WmxHSFJYbTFoTTNpMWpMWTJW?=
 =?utf-8?B?VWFteXdqZ0xQM09nZDBaOGRUdnlzdjFWUHBNRGsvaUVudmx1Rkphenh6emQ3?=
 =?utf-8?B?enpxT0gyMyt5ajJKU1R5QzVJZWtUeHJibXlGRktHQjduWXBadjNMZWtOODF3?=
 =?utf-8?B?SWswc09aelBjbzEveEp4QWZpL25WUnhZTFhrQlY0cDZmZHJqdWdQZzM2ME5x?=
 =?utf-8?B?SWRSbTd5YzlVSUdHdUhjL21zUDE5ekgrZ1RsMVdWU3JkZGJEQmxSNWdDME1E?=
 =?utf-8?B?T1JZVUNrOXdIdDlIMUM3dFhxK0w1M3hqODZNTjRoNDZLV0M3Y3Y3N0ExLzlx?=
 =?utf-8?B?MVVEbll1WDFKbG1acjFTVlpOR2dZOVRjWkRXL3ozdGgxdnllck5Zdm8rcGtv?=
 =?utf-8?B?MDNvdlU4Mm9rREpFK0swcXk5djFWMHVtdGFhOVY0aDdjUHNqbi9hWnZtVUhF?=
 =?utf-8?B?bmRuNjg0R1RXL0Nwc3k1Q1NwaWRWeC9RTkVKbnV1UnJBUlhUQWt6QVhCS1dk?=
 =?utf-8?B?UnRmbjhQYjlpc1MyTm5qQ2FmL2IzcUJ2MitRVTRwNlF6ckRDM2QzeW5sWkZL?=
 =?utf-8?B?OGhzR21XK2IveEJLUXJIdVFKRXhlY0VRalNmZXBPWThNVVZOZlBZWUdZbFNz?=
 =?utf-8?B?dmxlZEhDdkwxbWVwak4xdjdlWERtUENvUnFTUkoxdXdXRHMwU3NIUG41M2Fu?=
 =?utf-8?B?bTMwcFNiVGRGZ05Sb0VFT0pIVTR6NXc4TzR5N3FrUkM2b0lWeWh5aFovaEZJ?=
 =?utf-8?B?L3ROVmNmUlIzeGRjUHEzUnZCRWJ4R0psMkNtZjZ6T1dBeEJUSGRhOVc4RjMw?=
 =?utf-8?B?TGViQUNSQjZIWlBtbk5PL05IQ3Byb0RSV1BZOXRVNmFnTDF5TkZKbDhDeGV5?=
 =?utf-8?B?RHhSR1RrRys0Nm9wWEhsSHpjNlA5RFVMQWJsYlE1M29vVjArSUIvM2lVdWw4?=
 =?utf-8?B?U1ZvSkg5T3JBUXlpTytIUWx2bmpUSDZyTk5JRXdSQlYreFVybW1uL0Fzb0JP?=
 =?utf-8?B?TGNkRUQzbHFxcnRIZTM5em5Od2tUQ1JhNVMxZkpXTGx3eVQyQkFYVVNpZVlT?=
 =?utf-8?B?R0ZYM0Jabm1SOWFSL1ltRFlMa2FNR0lIQkJTMERSOGwwMk1DNmhqMVdMb1ho?=
 =?utf-8?B?eWx4TUw2VEV3V2F1WG1tSGxGOTZRcHI4UXJxVjJubjBpZVR3YXYrUlBuZm5D?=
 =?utf-8?B?cjJlMDkydUJmallVWGo2Njc2ZGplTndwcWtDNklkN0M5YXV0Z2Z2VE5SNEt4?=
 =?utf-8?B?TFFOUEoyVkpIdXNBaW1PRXJuT1piNUMzbDY2dHQ2QnM3QTJTODlQcDZWbmhZ?=
 =?utf-8?B?YlZVL1UyenFWalN5QkQ0UnkyK21vOWNwbnhBODR3dXkwY21Uakx6c3RGNkZs?=
 =?utf-8?B?YVZla1Z0Qk01Qm1MTDNNWE5WbmNoTnc3S2trcDkyVXBYeHNaUm9WOUNmSk5o?=
 =?utf-8?B?YUJBbWNvOUZOdnNFK2ZieDB4ZEdaK3hHZ3dZTXllQnFwRTNESXhGaTYwamUr?=
 =?utf-8?B?TzFNcW5TK3RBRndYRndqZVUzTmN6MmtsY0kxODFQTDZhaVZTQnNWTmRxY293?=
 =?utf-8?B?WFhWSVFQUzZDOEIvZDlYZ0lSNk9CUnlTckVYdG9iMlk1U0VlZmhkeG9YOVM0?=
 =?utf-8?B?STJYWDNiZ2xpR0x5WkZNRW50b0JENkp5K3NrMmdKRTB2NU1qMkRKSk9VOUR4?=
 =?utf-8?B?MWlEVmVRSXE4Nm9MdE9MWGZnWlhPRjFtSGRRODJLK0JpazVCNStNUlNGZlJX?=
 =?utf-8?B?Nng1RUt5Zk1rdDYvMUx2QlpYVmFMVmMvbmNNTVVrSHdCN1d0MERWT21KVzJn?=
 =?utf-8?B?VnhtOUdydUF5ZnVPRGEzMDdtbldTcklEMHQ4bEpUa0xvL2M4b1F2VGxuS2Jt?=
 =?utf-8?B?QkI1aVd0eFVWS1d3akVvdno5WGFhbHMvMzVjdFQ4VW5EVExjUTM2SnBoa3J6?=
 =?utf-8?Q?RfaLHzT1y/kRoQ6ejW4beR5o99RqaBVDnT+IIlJEfOoHF?=
X-MS-Exchange-AntiSpam-MessageData-1: Z7LjL60frPYkvg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2015df-eab6-4738-823b-08deb7400a5b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:51:21.4679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xY5FZi7omS1uwDbyMRtqcJM2PxX9jzhZx/ruNUkBmqX9Do8USzhMJqWoIg+e2RVkjYhfu0hkFb9FlbLbBhmoWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
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

Booting the GSP is done differently depending on the architecture. Move
the parts that are chipset-specific under a HAL.

This does not change much at the moment, since the differences between
Turing and Ampere are rather benign, but will become critical to
properly support the FSP boot process used by Hopper and Blackwell.

The Hopper/Blackwell support is not merged yet, so their HAL is a stub
for now.

This patch is intended to be a mechanical code extraction with no
behavioral changes.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs           |   1 +
 drivers/gpu/nova-core/gsp/boot.rs      | 168 +++------------------------
 drivers/gpu/nova-core/gsp/hal.rs       |  74 ++++++++++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  50 ++++++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 206 +++++++++++++++++++++++++++++++++
 5 files changed, 345 insertions(+), 154 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index ba5b7f990031..38378f104068 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 mod boot;
+mod hal;
 
 use kernel::{
     debugfs,
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 11b1cd2db8cb..447c9b083039 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -6,7 +6,6 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
-    io::Io,
     pci,
     prelude::*,
     time::Delta, //
@@ -21,122 +20,18 @@
     },
     fb::FbLayout,
     firmware::{
-        booter::{
-            BooterFirmware,
-            BooterKind, //
-        },
-        fwsec::{
-            bootloader::FwsecFirmwareWithBl,
-            FwsecCommand,
-            FwsecFirmware, //
-        },
         gsp::GspFirmware,
         FIRMWARE_VERSION, //
     },
-    gpu::{
-        Architecture,
-        Chipset, //
-    },
+    gpu::Chipset,
     gsp::{
         cmdq::Cmdq,
         commands,
-        sequencer::{
-            GspSequencer,
-            GspSequencerParams, //
-        },
         GspFwWprMeta, //
     },
-    regs,
-    vbios::Vbios,
 };
 
 impl super::Gsp {
-    /// Helper function to load and run the FWSEC-FRTS firmware and confirm that it has properly
-    /// created the WPR2 region.
-    fn run_fwsec_frts(
-        dev: &device::Device<device::Bound>,
-        chipset: Chipset,
-        falcon: &Falcon<Gsp>,
-        bar: &Bar0,
-        bios: &Vbios,
-        fb_layout: &FbLayout,
-    ) -> Result<()> {
-        // Check that the WPR2 region does not already exists - if it does, we cannot run
-        // FWSEC-FRTS until the GPU is reset.
-        if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
-            dev_err!(
-                dev,
-                "WPR2 region already exists - GPU needs to be reset to proceed\n"
-            );
-            return Err(EBUSY);
-        }
-
-        // FWSEC-FRTS will create the WPR2 region.
-        let fwsec_frts = FwsecFirmware::new(
-            dev,
-            falcon,
-            bar,
-            bios,
-            FwsecCommand::Frts {
-                frts_addr: fb_layout.frts.start,
-                frts_size: fb_layout.frts.len(),
-            },
-        )?;
-
-        if chipset.needs_fwsec_bootloader() {
-            let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
-            // Load and run the bootloader, which will load FWSEC-FRTS and run it.
-            fwsec_frts_bl.run(dev, falcon, bar)?;
-        } else {
-            // Load and run FWSEC-FRTS directly.
-            fwsec_frts.run(dev, falcon, bar)?;
-        }
-
-        // SCRATCH_E contains the error code for FWSEC-FRTS.
-        let frts_status = bar
-            .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
-            .frts_err_code();
-        if frts_status != 0 {
-            dev_err!(
-                dev,
-                "FWSEC-FRTS returned with error code {:#x}\n",
-                frts_status
-            );
-
-            return Err(EIO);
-        }
-
-        // Check that the WPR2 region has been created as we requested.
-        let (wpr2_lo, wpr2_hi) = (
-            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
-            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
-        );
-
-        match (wpr2_lo, wpr2_hi) {
-            (_, 0) => {
-                dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
-
-                Err(EIO)
-            }
-            (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
-                dev_err!(
-                    dev,
-                    "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
-                    wpr2_lo,
-                    fb_layout.frts.start,
-                );
-
-                Err(EIO)
-            }
-            (wpr2_lo, wpr2_hi) => {
-                dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
-                dev_dbg!(dev, "GPU instance built\n");
-
-                Ok(())
-            }
-        }
-    }
-
     /// Attempt to boot the GSP.
     ///
     /// This is a GPU-dependent and complex procedure that involves loading firmware files from
@@ -145,24 +40,15 @@ fn run_fwsec_frts(
     ///
     /// Upon return, the GSP is up and running, and its runtime object given as return value.
     pub(crate) fn boot(
-        self: Pin<&mut Self>,
+        mut self: Pin<&mut Self>,
         pdev: &pci::Device<device::Bound>,
         bar: &Bar0,
         chipset: Chipset,
         gsp_falcon: &Falcon<Gsp>,
         sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
-        // The FSP boot process of Hopper+ is not supported for now.
-        if matches!(
-            chipset.arch(),
-            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x
-        ) {
-            return Err(ENOTSUPP);
-        }
-
         let dev = pdev.as_ref();
-
-        let bios = Vbios::new(dev, bar)?;
+        let hal = super::hal::gsp_hal(chipset);
 
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset, FIRMWARE_VERSION), GFP_KERNEL)?;
 
@@ -171,38 +57,21 @@ pub(crate) fn boot(
 
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
-        // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
-        if !fb_layout.frts.is_empty() {
-            Self::run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_layout)?;
-        }
-
-        gsp_falcon.reset(bar)?;
-        let libos_handle = self.libos.dma_handle();
-        let (mbox0, mbox1) = gsp_falcon.boot(
-            bar,
-            Some(libos_handle as u32),
-            Some((libos_handle >> 32) as u32),
-        )?;
-        dev_dbg!(pdev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
-
-        dev_dbg!(
-            pdev,
-            "Using SEC2 to load and run the booter_load firmware...\n"
-        );
-
-        BooterFirmware::new(
+        // Perform the chipset-specific boot sequence.
+        hal.boot(
+            self.as_mut(),
             dev,
-            BooterKind::Loader,
-            chipset,
-            FIRMWARE_VERSION,
-            sec2_falcon,
             bar,
-        )?
-        .run(dev, bar, sec2_falcon, &wpr_meta)?;
+            chipset,
+            &fb_layout,
+            &wpr_meta,
+            gsp_falcon,
+            sec2_falcon,
+        )?;
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
-        // Poll for RISC-V to become active before running sequencer
+        // Poll for RISC-V to become active before continuing.
         read_poll_timeout(
             || Ok(gsp_falcon.is_riscv_active(bar)),
             |val: &bool| *val,
@@ -217,16 +86,7 @@ pub(crate) fn boot(
         self.cmdq
             .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
-        // Create and run the GSP sequencer.
-        let seq_params = GspSequencerParams {
-            bootloader_app_version: gsp_fw.bootloader.app_version,
-            libos_dma_handle: libos_handle,
-            gsp_falcon,
-            sec2_falcon,
-            dev: pdev.as_ref().into(),
-            bar,
-        };
-        GspSequencer::run(&self.cmdq, seq_params)?;
+        hal.post_boot(self.as_mut(), dev, bar, &gsp_fw, gsp_falcon, sec2_falcon)?;
 
         // Wait until GSP is fully initialized.
         commands::wait_gsp_init_done(&self.cmdq)?;
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
new file mode 100644
index 000000000000..ae16fd6ba7fb
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+mod gh100;
+mod tu102;
+
+use kernel::prelude::*;
+
+use kernel::{
+    device,
+    dma::Coherent, //
+};
+
+use crate::{
+    driver::Bar0,
+    falcon::{
+        gsp::Gsp as GspEngine,
+        sec2::Sec2,
+        Falcon, //
+    },
+    fb::FbLayout,
+    firmware::gsp::GspFirmware,
+    gpu::{
+        Architecture,
+        Chipset, //
+    },
+    gsp::{
+        Gsp,
+        GspFwWprMeta, //
+    },
+};
+
+/// Trait implemented by GSP HALs.
+pub(super) trait GspHal: Send {
+    /// Performs the GSP boot process, loading and running the required firmwares as needed.
+    #[allow(clippy::too_many_arguments)]
+    fn boot(
+        &self,
+        gsp: Pin<&mut Gsp>,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        chipset: Chipset,
+        fb_layout: &FbLayout,
+        wpr_meta: &Coherent<GspFwWprMeta>,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result;
+
+    /// Performs HAL-specific post-GSP boot tasks.
+    ///
+    /// This method is called by the GSP boot code after the GSP is confirmed to be running, and
+    /// after the initialization commands have been pushed onto its queue.
+    fn post_boot(
+        &self,
+        _gsp: Pin<&mut Gsp>,
+        _dev: &device::Device<device::Bound>,
+        _bar: &Bar0,
+        _gsp_fw: &GspFirmware,
+        _gsp_falcon: &Falcon<GspEngine>,
+        _sec2_falcon: &Falcon<Sec2>,
+    ) -> Result {
+        Ok(())
+    }
+}
+
+/// Returns the GSP HAL to be used for `chipset`.
+pub(super) fn gsp_hal(chipset: Chipset) -> &'static dyn GspHal {
+    match chipset.arch() {
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada => tu102::TU102_HAL,
+        Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+            gh100::GH100_HAL
+        }
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
new file mode 100644
index 000000000000..187fb7dbe40a
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+use kernel::prelude::*;
+
+use kernel::{
+    device,
+    dma::Coherent, //
+};
+
+use crate::{
+    driver::Bar0,
+    falcon::{
+        gsp::Gsp as GspEngine,
+        sec2::Sec2,
+        Falcon, //
+    },
+    fb::FbLayout,
+    gpu::Chipset,
+    gsp::{
+        hal::GspHal,
+        Gsp,
+        GspFwWprMeta, //
+    },
+};
+
+struct Gh100;
+
+impl GspHal for Gh100 {
+    /// Boot GSP via FSP Chain of Trust (Hopper/Blackwell+ path).
+    ///
+    /// This path uses FSP to establish a chain of trust and boot GSP-FMC. FSP handles
+    /// the GSP boot internally - no manual GSP reset/boot is needed.
+    fn boot(
+        &self,
+        _gsp: Pin<&mut Gsp>,
+        _dev: &device::Device<device::Bound>,
+        _bar: &Bar0,
+        _chipset: Chipset,
+        _fb_layout: &FbLayout,
+        _wpr_meta: &Coherent<GspFwWprMeta>,
+        _gsp_falcon: &Falcon<GspEngine>,
+        _sec2_falcon: &Falcon<Sec2>,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+}
+
+const GH100: Gh100 = Gh100;
+pub(super) const GH100_HAL: &dyn GspHal = &GH100;
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
new file mode 100644
index 000000000000..b7a88f3ecea9
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+use kernel::prelude::*;
+
+use kernel::{
+    device,
+    dma::Coherent,
+    io::Io, //
+};
+
+use crate::{
+    driver::Bar0,
+    falcon::{
+        gsp::Gsp as GspEngine,
+        sec2::Sec2,
+        Falcon, //
+    },
+    fb::FbLayout,
+    firmware::{
+        booter::{
+            BooterFirmware,
+            BooterKind, //
+        },
+        fwsec::{
+            bootloader::FwsecFirmwareWithBl,
+            FwsecCommand,
+            FwsecFirmware, //
+        },
+        gsp::GspFirmware,
+        FIRMWARE_VERSION, //
+    },
+    gpu::Chipset,
+    gsp::{
+        hal::GspHal,
+        sequencer::{
+            GspSequencer,
+            GspSequencerParams, //
+        },
+        Gsp,
+        GspFwWprMeta, //
+    },
+    regs,
+    vbios::Vbios, //
+};
+
+/// Helper function to load and run the FWSEC-FRTS firmware and confirm that it has properly
+/// created the WPR2 region.
+fn run_fwsec_frts(
+    dev: &device::Device<device::Bound>,
+    chipset: Chipset,
+    falcon: &Falcon<GspEngine>,
+    bar: &Bar0,
+    bios: &Vbios,
+    fb_layout: &FbLayout,
+) -> Result<()> {
+    // Check that the WPR2 region does not already exist - if it does, we cannot run
+    // FWSEC-FRTS until the GPU is reset.
+    if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
+        dev_err!(
+            dev,
+            "WPR2 region already exists - GPU needs to be reset to proceed\n"
+        );
+        return Err(EBUSY);
+    }
+
+    // FWSEC-FRTS will create the WPR2 region.
+    let fwsec_frts = FwsecFirmware::new(
+        dev,
+        falcon,
+        bar,
+        bios,
+        FwsecCommand::Frts {
+            frts_addr: fb_layout.frts.start,
+            frts_size: fb_layout.frts.len(),
+        },
+    )?;
+
+    if chipset.needs_fwsec_bootloader() {
+        let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
+        // Load and run the bootloader, which will load FWSEC-FRTS and run it.
+        fwsec_frts_bl.run(dev, falcon, bar)?;
+    } else {
+        // Load and run FWSEC-FRTS directly.
+        fwsec_frts.run(dev, falcon, bar)?;
+    }
+
+    // SCRATCH_E contains the error code for FWSEC-FRTS.
+    let frts_status = bar
+        .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
+        .frts_err_code();
+    if frts_status != 0 {
+        dev_err!(
+            dev,
+            "FWSEC-FRTS returned with error code {:#x}\n",
+            frts_status
+        );
+
+        return Err(EIO);
+    }
+
+    // Check that the WPR2 region has been created as we requested.
+    let (wpr2_lo, wpr2_hi) = (
+        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
+        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
+    );
+
+    match (wpr2_lo, wpr2_hi) {
+        (_, 0) => {
+            dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
+
+            Err(EIO)
+        }
+        (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
+            dev_err!(
+                dev,
+                "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
+                wpr2_lo,
+                fb_layout.frts.start,
+            );
+
+            Err(EIO)
+        }
+        (wpr2_lo, wpr2_hi) => {
+            dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
+            dev_dbg!(dev, "GPU instance built\n");
+
+            Ok(())
+        }
+    }
+}
+
+struct Tu102;
+
+impl GspHal for Tu102 {
+    fn boot(
+        &self,
+        gsp: Pin<&mut Gsp>,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        chipset: Chipset,
+        fb_layout: &FbLayout,
+        wpr_meta: &Coherent<GspFwWprMeta>,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result {
+        let bios = Vbios::new(dev, bar)?;
+
+        // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
+        if !fb_layout.frts.is_empty() {
+            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+        }
+
+        gsp_falcon.reset(bar)?;
+        let libos_handle = gsp.libos.dma_handle();
+        let (mbox0, mbox1) = gsp_falcon.boot(
+            bar,
+            Some(libos_handle as u32),
+            Some((libos_handle >> 32) as u32),
+        )?;
+        dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
+
+        dev_dbg!(
+            dev,
+            "Using SEC2 to load and run the booter_load firmware...\n"
+        );
+
+        BooterFirmware::new(
+            dev,
+            BooterKind::Loader,
+            chipset,
+            FIRMWARE_VERSION,
+            sec2_falcon,
+            bar,
+        )?
+        .run(dev, bar, sec2_falcon, wpr_meta)?;
+
+        Ok(())
+    }
+
+    fn post_boot(
+        &self,
+        gsp: Pin<&mut Gsp>,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_fw: &GspFirmware,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result {
+        // Create and run the GSP sequencer.
+        let seq_params = GspSequencerParams {
+            bootloader_app_version: gsp_fw.bootloader.app_version,
+            libos_dma_handle: gsp.libos.dma_handle(),
+            gsp_falcon,
+            sec2_falcon,
+            dev: dev.into(),
+            bar,
+        };
+        GspSequencer::run(&gsp.cmdq, seq_params)?;
+
+        Ok(())
+    }
+}
+
+const TU102: Tu102 = Tu102;
+pub(super) const TU102_HAL: &dyn GspHal = &TU102;

-- 
2.54.0

