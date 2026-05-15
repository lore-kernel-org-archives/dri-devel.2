Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7104CCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D9210F3F8;
	Fri, 15 May 2026 06:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JxEEdGrT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA01D10F3F6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxZom4zaYiekgrdqxfAFZ6ofJj/mu5Wf8nuzZRPtjtYiiY4o/SZlzelRZdgZkaL2CqWhl+aMc+imVXPljGwreImwBEDmWKe3JOtC0Z+sxqvNcyGa+t36GzMTd+TKX+2C9kL0PYqTIa5dctRn18k2Ry9h0BnErnkDnVS44pYYp18yeH0ahOgto4T33jB1NxbQhlDEnYf4GKO2aNDXDwxlKBbE4ods/zlw+koU/lrW0PScpv4gJopOlGrm8xJwE0X59I1WYUCIww1WAe/ERSlj2D122B8eIQobaL/T5VM5vqVoa8q3oY8NxJdK/5jDF1Uj8D4cQsfyATeRrQCFNT4Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRkdTz0tW4DuzIcjvwNB1HEkGZLvafa/rJpD8fbhehY=;
 b=VLLqZ/Sg9aiVlmySDuOCjTk/eXtUzllcTJ4aagxADZJwhW1wPUQMpX/4DQ0IXmvpoPOXZbl578qaOFto9ZiBIWp+ICtpkjAEFaaAHwUhTGlJlQ4Gmegco1rwKNT4fCdoNvjSFEkze48uNJt0IdFZrVz1/FkAbiRe/cqngICmPvzPwcodrUSAppXs8Fcee8zcxZsySdyKDtqmtWhFqB5peibmNV7879MSEjEXIWHGqhr/sTE2dCTlXv4Lo+9FYD398YUb4g9amKu9L9KFTx9Nzzj5NC1hxZRbygAE9yf2U/jRrKLDDuX3bJKMhVIgIo0kOzrMkZXt3u6iHER7oxAc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRkdTz0tW4DuzIcjvwNB1HEkGZLvafa/rJpD8fbhehY=;
 b=JxEEdGrTLa4gcfRB4Lho3w+1o+Dg6QVFrCaUaT1FRddVhpiEyzG3n4XAPEoomCIoMLmvHqw+FiNEsA8QfY2ILTxbtwQH83hJkQCe4ZJTdkk69Np4ywSLkaVFH8snv/yGDwI9A4pb8cEGdX44w7R8I0pV2Pd6He3JtX72u4NQOMswWd1aHOsYkqyTYo8WUjYk9Za1UYYPXDagG3mGbcYvPq53tnnxiJXWPCJdN+bBPGmTQlt4m6hSmYQ802wblH8rV6H6oW2rS/9W6LjjFrwK7hihfjNvfd7xSDm7bfD6p5dv+Gv9tgR8eZPe/ZPKf73UNJCb7zyr8g8WoodZYEvmHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:13:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 06:13:11 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 15 May 2026 15:12:32 +0900
Subject: [PATCH v5 6/7] gpu: nova-core: gsp: move chipset-specific parts of
 the boot process into a HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-nova-unload-v5-6-c4d6250ad160@nvidia.com>
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
In-Reply-To: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS7PR01CA0120.jpnprd01.prod.outlook.com
 (2603:1096:604:258::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 45078b12-e7dc-43db-d1de-08deb2490a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: afOKTwX8BpROJPJAu5FI1ncM42OqZkXmZI0vVUi/aNI0XOHE6fCk+8cOmXDCnC5W5Q6K0sBvn/eW+MTZ5kJZwuvCAHg760Go5u7nkW79hmO3vcVJgsXM/mGlISJ8sKPgcBn0Jjj8kCgkm8edswHg2raP3oEdDiouQMT5d6swZgkaKygIu2xoJslybuGZ6NRDDlzz4zc03Xxt6Zy6P4M5Cbxn+E5Qm72ADL1ioOMQ4r9n9pBhZI7IjGaVBKqhZ1AmrUNFQ9QHEzWfbYajfE9mJMcKdYPHY7DoZwqqbqV/A54x2EC34YNZ6MSV3cwRDBsgJzJfQVJx9w07UGz5M/tvJkMBOOFRV1sUBzqxy22RpuvgrgxymXI213NmpswFfnVcyNROQDzteUeKRic9OAWKc1NflztW6z4K/BOaQ+lxHK2d+/FuXLge1CsUhjw0c77qoqpjSpMXLcjB9sGDNVYfj6jKoktzYm/W1QN6eIf9z64Q+N0H/7uNU/dduhmkmrd7OjT7tDPuvnkAM5ucNVqdyujpmTCzS1dB1rJ4VLyikCwPuTMD25rTH3J+i0mQOXN0MY580N+/uMqDCh2gm4SxAxEJc+7CLITTrWFW980YGFKZ6u+GwoE5TC2blMqVK5EFc2Kvv3d3K0jtPEv/iZSQTTQus/fgArGuomvCPxZ2LbMcM8kHCkjEVtIlyDL8Kx8Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5XVHRTVVBLVXpFOGI0L056b21BZXRwbkh6ejN0VUZEeGtYY0QrVG1XcHov?=
 =?utf-8?B?eDE4V1FQODhjVzlDc29QbktVS0IvaHBod0JGTm1rNHFmaksvZ1RCSkNuZnM2?=
 =?utf-8?B?VWlmSVk0YW9yMmFpREdPU29PZDlsU1dzUXRWcnNlQkgvY2R6TkZ1eTJESEw0?=
 =?utf-8?B?SzR4c1UweFVheXF3bXJhb3BJY0hyVVRNTUxONHVXRG1rT1VsaDRobVlUemhJ?=
 =?utf-8?B?R21lckYzNTJCcXYvYVQrQUdWOWRDeDBKYVpEV3A0Qi8vR1BuaHd4MVNGKzM5?=
 =?utf-8?B?OHkzamd2cnJpK2NZcUJFcjlBeWhGYVJZRHgyT1JaSlJmeGx0ekUwbTZhaG9w?=
 =?utf-8?B?ejkrUnRmcDBvV0YvYlVJekNHVUtpb25CalkyY1Q5YlFYekd4Zzg4TGZGNTZt?=
 =?utf-8?B?L2NmTkJoVFRYSW1JL09XdHBPSWRZME9EV05ZbUNGVTEwQnd4VEJLdHFRRVVT?=
 =?utf-8?B?TVB5c3dlc0dlSE5DUm90VWlITGRja1dSa2RlRzJYY1kvWGxUNjkvT0ttU3JE?=
 =?utf-8?B?blI5VWtsanhKSzZaU3M2Q0g4Q2N2OFpsT2gxbVpEbXBVMHRUVWY0K0lycVVl?=
 =?utf-8?B?OGpLZXQ5S3o4RkFrQ3VSaUVHTGZCZWx6K2xHU0M1K2NrM3VtWXRrR0F5NDhk?=
 =?utf-8?B?QS85MUgvWmhTRXk4VmxZbEx2VW9kR2ZkZ2RHcWVyYVFwLzJpU1NwanlpOHJV?=
 =?utf-8?B?YmdSV01CVGVCMGhBMzg4Yy9GNDRvOHRqZmtKTHJtS1VldmFwZTB1bHpjUFF5?=
 =?utf-8?B?TkZUT01NejVyMldIRDcyN0lqd3FhSTdUZTF4SXBVcWpYcWRISis3c1JpaDBV?=
 =?utf-8?B?TDBQZ280Sk9hZUxQcmlXcDlNOGQrZXRXbVJGQ1pWMnJBWTFuQ1drRUcyUmcx?=
 =?utf-8?B?cTdVZUxmc0Fjd05jWUprMEcyblNDcXlNelhQSDVabGlUV3NKdFhia2dqVWh6?=
 =?utf-8?B?VGo0dDQ0bmU1Zm5QWFFkK1RNUkt6cHdGR3FzS2d0cHhjR1lKQUlrMHNmRnhE?=
 =?utf-8?B?SEpnbHdiVVJndkhRRGZKU3RDbnBLMUpaQ0orMkdIOVpoYU1ENnFkV0FsN25S?=
 =?utf-8?B?VzM2VFh0SURNS3FpVXBGb3A4NlBlUWp5TEN5dEJpWkhBTnV6b3pZcldWcU03?=
 =?utf-8?B?V1J1MnVsTlFIVHVRd3BwVjhpV0ROMkZHdG5QYVhJdmR3Yi96clhMUGZraFlx?=
 =?utf-8?B?eDNYRGdJbVlZUVhZWTE0U0wyOHVMcnNkbUtneHRuS2hVaytWOEVhZ3ZMdzBB?=
 =?utf-8?B?dXdWbUdrN2FqcERXRW9EZko1eEx0MmlJUmRZTXc0VmZrNzdRMmlVOHZ3Z1Rq?=
 =?utf-8?B?NmRyNGlJNnVBVDJDSTR0bEFOTXRYVHd5TnFacEpSRG52b2xlMEY5UGZiOFYy?=
 =?utf-8?B?RlFDYXlKUWxZNENFUSszcWhvMThGRHJ4TEZEakhvOU10RUluOE1qYTEyS0tH?=
 =?utf-8?B?b202RTRLN0xvOE5GY1ZvZ1NNTExjbGxBL0dvSU50WXZpbDNnVUR1Q3dqa2VB?=
 =?utf-8?B?dStzSjEySHJiUjlMM1ptdFFtaDc5Vm90TWFoOVg4WnJwS1FHanliVnhZb0F0?=
 =?utf-8?B?TlpYS2xWcnN2QXFrOWZkMUZpZ2NLYWR0eCsrWGRqYkdNNmlwaVdmRkp4SDJS?=
 =?utf-8?B?VlBzZGEvYVlSeTIySml0YW1abU9WeWpJYTNVTlc3czZha3RHYTM1dHVKcFpK?=
 =?utf-8?B?S29iNzd3a1lnMmp3Y1ZLOGZybXdnVFJYL2xRakdvSjlQcCtsWEtwTjNzV1h0?=
 =?utf-8?B?M2ROZTJVclNQUTlhWGxXa1ROQ0FvVEtMT29qS05KOEdXait1SVBGTWYxYUhZ?=
 =?utf-8?B?RHc3WmRxY0h4T0xmc2Q5SUY4c2FRdnRqYmlEck5BZUljdTdHWTBzU2ZyZStT?=
 =?utf-8?B?MFAxK0FqUFpGSEw2U0pyMXN6VlhRcmxnRml2VFM4bG1uTWlkcUZTbmc4MDBP?=
 =?utf-8?B?aGlRV1ZpeU50SHJjcFZpSDE5WDdVNk8wbEZFY0tVcmlnZ2VTK2VRclBBQjFN?=
 =?utf-8?B?Mm53OVVSZ2RNcDFsQVN3VkJudzNoZW9FTXpoU29OdHNheW1sd1E0Znh3UXFj?=
 =?utf-8?B?TzhKLzlLaXpTdlVGUFRoRlpvM0tPNW53TEIvRWtBbnVIMnEvVXIwL3V4Tkxi?=
 =?utf-8?B?VVloZGhFNnBSbCs5cHU4RS9KUGlsQlpNWlRQaHkzV2NhVWNGMnpJdTVUSWU0?=
 =?utf-8?B?cWNQeWJRVGRjS3lWWWZJcDNVanh4VnptL0Qyb0FDeUpHVXJSU0lJRTNqMldB?=
 =?utf-8?B?VTZ6anVycXd2U3NTU1VrQ05YM3ZHWlNmMWRuRzJGM1pOL0JpOHlNSGdIbW1K?=
 =?utf-8?B?cXBkZ2pQSGE4OXdnalFTNW5WK0k2NXplQUNHUGh1bGd1Rzh3SmdURytWSmtv?=
 =?utf-8?Q?IeD7La29mnMS9MOuKqEeDndw3dyDpTN7R+zo+qOBNO9ED?=
X-MS-Exchange-AntiSpam-MessageData-1: fPa19eonI/n74w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45078b12-e7dc-43db-d1de-08deb2490a4f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:13:11.0479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhJDbm4PuLSSPTIsOyqfaXkygIFsMdX5g5TBHJ+wqFqkdTMB4Zg67BBVhLM3lRoMrno/aincGTH3qpvn9SZDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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
---
 drivers/gpu/nova-core/gsp.rs           |   1 +
 drivers/gpu/nova-core/gsp/boot.rs      | 179 +++------------------------
 drivers/gpu/nova-core/gsp/hal.rs       |  73 +++++++++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  49 ++++++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 216 +++++++++++++++++++++++++++++++++
 5 files changed, 353 insertions(+), 165 deletions(-)

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
index 2e1401cd6171..59c1b4d030ae 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -5,7 +5,6 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
-    io::Io,
     pci,
     prelude::*,
     time::Delta, //
@@ -20,141 +19,18 @@
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
-    /// Load and run the booter firmware.
-    fn run_booter(
-        dev: &device::Device<device::Bound>,
-        bar: &Bar0,
-        chipset: Chipset,
-        sec2_falcon: &Falcon<Sec2>,
-        wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result {
-        BooterFirmware::new(
-            dev,
-            BooterKind::Loader,
-            chipset,
-            FIRMWARE_VERSION,
-            sec2_falcon,
-            bar,
-        )?
-        .run(dev, bar, sec2_falcon, wpr_meta)
-    }
-
     /// Attempt to boot the GSP.
     ///
     /// This is a GPU-dependent and complex procedure that involves loading firmware files from
@@ -163,24 +39,15 @@ fn run_booter(
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
 
@@ -189,30 +56,21 @@ pub(crate) fn boot(
 
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
-        // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
-        if !fb_layout.frts.is_empty() {
-            Self::run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_layout)?;
-        }
-
-        gsp_falcon.reset(bar)?;
-        let libos_handle = self.libos.dma_handle();
-        let (mbox0, mbox1) = gsp_falcon.boot(
+        // Perform the chipset-specific boot sequence.
+        hal.boot(
+            self.as_mut(),
+            dev,
             bar,
-            Some(libos_handle as u32),
-            Some((libos_handle >> 32) as u32),
+            chipset,
+            &fb_layout,
+            &wpr_meta,
+            gsp_falcon,
+            sec2_falcon,
         )?;
-        dev_dbg!(pdev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
-
-        dev_dbg!(
-            pdev,
-            "Using SEC2 to load and run the booter_load firmware...\n"
-        );
-
-        Self::run_booter(dev, bar, chipset, sec2_falcon, &wpr_meta)?;
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
-        // Poll for RISC-V to become active before running sequencer
+        // Poll for RISC-V to become active before continuing.
         read_poll_timeout(
             || Ok(gsp_falcon.is_riscv_active(bar)),
             |val: &bool| *val,
@@ -227,16 +85,7 @@ pub(crate) fn boot(
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
index 000000000000..4d8c1998f4cf
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
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
index 000000000000..9d7e9f4454b1
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
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
index 000000000000..d5da23cd8c90
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
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
+/// Load and run the booter firmware.
+fn run_booter(
+    dev: &device::Device<device::Bound>,
+    bar: &Bar0,
+    chipset: Chipset,
+    sec2_falcon: &Falcon<Sec2>,
+    wpr_meta: &Coherent<GspFwWprMeta>,
+) -> Result {
+    BooterFirmware::new(
+        dev,
+        BooterKind::Loader,
+        chipset,
+        FIRMWARE_VERSION,
+        sec2_falcon,
+        bar,
+    )?
+    .run(dev, bar, sec2_falcon, wpr_meta)
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
+        run_booter(dev, bar, chipset, sec2_falcon, wpr_meta)?;
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

