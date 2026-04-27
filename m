Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F0CFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EFA10E59B;
	Mon, 27 Apr 2026 06:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EE/67Qhx";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C20210E59B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKnStIn7kL3RtUi/hGmel/UKYHiak3AD2GnCVlK1DtqaiPlSLCbV+rxHS0zvSPnmBekr+vrBd7Hu+AkzQuXenP3ZrMtoyuQdptMvTmmj5Cq9de8g6idQfHEg5aocnaqoqIvyuVKRpoA+QynJ8n/ZG3rCkFfUfXsosuw9YsxNG4zS8DAzBDf9CuPnndNVLI5j+JsKckN4z6c/xVgWxg6p9mZjLBirIflQ6GDmoNUVYDEtd98Q0N+gF4qo3jnNlrPTSDC0uVEfKzHaN8Li30Co23YduR0TkFT4/snE9BaZIxP4I9sBbiqGsuMjT7X7Q+L0N4r1xbMrtzJl/cowksu0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRkdTz0tW4DuzIcjvwNB1HEkGZLvafa/rJpD8fbhehY=;
 b=Pb6RXErUNLcdX3Al+yyOSmQ+BkK9dOWXfS8AiSzheshydYx67/qOYUpnlsFKOu6BFHNanWdBGhFtIDW4k6OXx1Tm21ozG16qIoshJPpJpOox1VTTPVRz6BZT1bFsao1pKYgDkQBfLvxScf7ofhfAr/Um843+9T0EmB0baMVWDaP1hW3onidYMRtv+bBzN9SdwOx/im4fu+y1ZzzUNqr7ZT/iVJCJbDf8PlqNNkhjM2jo+yrr+TdxrmzVKYBM2uk+waD8M3DBZmYDCPvxxrB6YXMz0f5QUzpCxoe+qsaeMqw7xcQYbhueh21b2gG4iN2BZf6Vtkleu6UiW0O3gvzsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRkdTz0tW4DuzIcjvwNB1HEkGZLvafa/rJpD8fbhehY=;
 b=EE/67QhxhBwDRZCScwN/luo7Ui56Y1At/20FpHRL3C/Iw8GP6JuOIdz292MrqjOvi7mtXkNwHhwG5ecypO2JvrVCaFST3LExfOS4pQ//oPuFC2dtXp1MqA9m7fVZq2yvM1mkjA6qDGvKU+19VRkWULgEyiWr9+oAFxsNP0+q8h7WluEcT8rsigX6SgCNbE78C0SpmAT63KOILRK19fEHSHT0oxWmiRAN0WlpaQdoh/ddZxQeDHMF+87XFs8rXsVfcOGmKD59ZDHjYsmrDWtg/t3uwrnCDW5Ffu+evODpnFS20E0tAHaMFEgBMkfA33H8ORKGvclErGbwsWvta76KAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:37 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 27 Apr 2026 15:57:04 +0900
Subject: [PATCH v4 7/8] gpu: nova-core: gsp: move chipset-specific parts of
 the boot process into a HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nova-unload-v4-7-e145ccddae66@nvidia.com>
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0301.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff76b7e-078a-403c-fa42-08dea42a4417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qao04CLpzLWBdECi+LQJgPlzZCeuVy6garIHitavQ331E5Y1Jcqr7Ii0uqNqA50HRTnopxzPIYDTVF6Vh+bkhuDAQnLo6ZuIzKw0DeaYWhvqVrmHGB8nkS7nW/jjaoLkm3lFjjZoufZ14LOSFDN1Ke8AtnGWbo4urmde/nc3hH690h+Lw1nXkQJzM6L7OpOACBdDsj+KfdJ8JNU+yLEvfXV6QjqlRpNxwgNgHLbORkMmID193AzGK9xbzHsFC0PnC9goZRSsWozk/vFgMWVmOxkS1Sd4BHAt/6pLLC6HKvPXrC3/DdAgYHWQrp7kIRLTKAoUH8IOC2LQr6ZjpjfU/yf97C0jKmt5T2SKfY/nuviGQK8zQ/uCwEmBrwMx2Z68n5EtRKY1QmZjXR5nH/bsejEI6dqGLR9nLBvNYVwMU9N0JsJWZLvU8j+s3n9Wt8Qr+gv1No49O++Ds0T6sKsqTwRl4M2IO3RQxiEzPuy/60v4T5lLer14SKrvAFGbCND5MfSNqXv9y5fC8Ia5k7NZEurqUIjcPzhaZ4iL1KKlAVzaAxbyY6vgZL6oDCJGtd60j6wOmJGQ5O93ug1K9iwDDDJit5WXNtS9ub4Bx2x3qw36rbKcb31JcQ/KQb5Sq/r9gVJs7GzMe2+sIjLQVzo1U9dwwg9mj11qR8KseKlmbAxEr7bN8W9Eyrv93himvLBu/ULPebCFaBE2vM/u5Dldw+FykGBi12fosfodFKYSs/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nzc2aWlsUllRRGNGb05sQndXaEs0OVM3di9LR3lqSmlaRUoxaDJGWXJ4Z2lm?=
 =?utf-8?B?NitaS0tjR3pOb1J3ZFV4TkJlb3c0eTJJSk5pWHVHNW53aWt6OW5ZcitIdXF6?=
 =?utf-8?B?Znl2RWNIdUhYaFA2RjRBMERQSjJCdG14TEd5RUJra0paQjNkK3p3T2hZbUg2?=
 =?utf-8?B?Z21GSjZScHZKaG55YVlhMVlEMnVhYTA3Uk9YbTBCczBLRmN3Mzl1NUhZaTNj?=
 =?utf-8?B?UFg0d1VjU0xSUTZXT1pucmQvOVBSN2xENm9kbmdzQjQ4bFA2cFh3OUxiMHdo?=
 =?utf-8?B?bWkrN1VRK0xKWGdCZVdLYVFvWUFlbzhmNUdrTm9SdzJKd2Urb3FOMW1DNytK?=
 =?utf-8?B?dXhUaE5aZWZtOGNkWkZtWmJIb0pIc1IwMXFkbS9QeGtWeHFGMGplT0V2cDBH?=
 =?utf-8?B?TnpVUnRVUk1vNjd5K25hZGx3OVh6WmxTV1pEODh1Uk0yMkJFZmYzdWhIYTFs?=
 =?utf-8?B?cFJrc2RnbFRUY0ZMVXVyd3VaVFlEMFBsQUVUUk1VaXVqb1VtakxoVHpuT1VQ?=
 =?utf-8?B?M0wxc2V3RzZua0NpZkxENElEOUVEZlpQdjkrNXBtMHV2bnRXZzUyeko3Qmdx?=
 =?utf-8?B?dkJCYnR5N0loZ1dDdGZGcUNaQnBFc1M1V0lXSmxJaUh1VjBGdFBTZ0NHMUQ2?=
 =?utf-8?B?ODJ2TW1QMDNEMk52RGgwbHY1LzZnQ2w5TjF6V0ZVZU84bG5MSytSMXJGRmtN?=
 =?utf-8?B?ZWFDcFlGZ3NxODFqaFdjOEYxQ2xlbzQ5RDRjb0o0d1BtSEprZTh5V2tqRWxq?=
 =?utf-8?B?dGJKcFZ4dTlicERBeCsrQVY4b0kzM3lNUEpIM1o0M0VRdXptVnJ1cjJZZTVI?=
 =?utf-8?B?N2srRjJXTmRHNG5pN2NtOCtLSC9ObW5PdmVMWGxvdnBQcXh6R3JKM0J3dWh2?=
 =?utf-8?B?eGQ1MFBjRjZEbVhXSDVXdVRwbmh5ak92aWxVdEt4aUUwKy9Zd05NaENRZWpB?=
 =?utf-8?B?ZE05TjBuVDZFVWhxay9RRDJSZWJrbWZsSXRENmE4VGJ5U056NGs5c1BrTksv?=
 =?utf-8?B?bUh0VFpDZmNib3Q2MDJpd0ZVVGdxNzZaZUN1UFBFckRPZ2RmRU5JcHV5MFNR?=
 =?utf-8?B?YmczelJwYlo4MWxhVm96cHFhZUFZOUp0cnl2MzUyZkY3NW0xd2hXMlo5dHMy?=
 =?utf-8?B?bzF5VklJLzF6d1l3bnJZTnJQa2lhaW1tZ3hzemVKRmEyTkV5UVdudzh5MUh1?=
 =?utf-8?B?aVVLeHYrMFMyRE8wNUExd0QvS2E0RGdLU2RkSXA0blNURWErNVNFVlJnT1Rp?=
 =?utf-8?B?VFA3SUxvVVFoNjBDUGJrZVloRzZOd3pZR3k4djRXNFQzRUszNmZWaXhiTVJZ?=
 =?utf-8?B?Rmx0bjFnbkZCZ01tbXJNb24yQWRkdGRYQlRLZXVZeFJQajlQZ2xZb3RkQ2Rh?=
 =?utf-8?B?YnRXZWJFdHZEc2NKVjdEOVhFeC90UlFVWHZRWHJ0WklyZWN5VnlHbjN4bHpH?=
 =?utf-8?B?akxibTk3NHdCQnVPSzV1WTYvWlRqM1o0VG0xSHVkNFRlVTlxVGFaWVFFMHBt?=
 =?utf-8?B?SkRDZmI1VDZvc1lJRC9uTDVpaWVQdkwvV2N0R0VRWDU5c0ZkWUJMZ3JibDNI?=
 =?utf-8?B?NW1iRUc4VEFIZVhDd1FxRU1JTDVxMXZ6SUhJemR6Q0tTdEx5R2RvQjBCeGE3?=
 =?utf-8?B?VTdSajZIbHBVaGEzWDNsRUtZTkVtTzlEL29NRTFkbE1IV2xLTTNaR0g3Wk8r?=
 =?utf-8?B?eWF0cUFiOGttTFlwMkNSMHdiUFNVYllTSnY2Q2k4ZHFKWUNrYjFQcTY5VTVv?=
 =?utf-8?B?NGFlaWZUenZ2V3ZEWG5oVTdqOEFGeDFIVnIzM3VpRmVLVVJ3bWlCQVdDSVA2?=
 =?utf-8?B?ZWs1MFd5MDZHZ1A1WWwzaXhSd0hLUjRuZDM2aGlkQ00vSXpIWkk0R3N2bDJN?=
 =?utf-8?B?ZC9XUGRhalAxU2RkbXg5MDQrbHpEQ1NnVEZwaU9RVlNvQXo0clFFdXkwNy94?=
 =?utf-8?B?cTRQWTNVVHBveDZ0MEpobTZSRmlobE9xOW5XTVgwbmZZY1ZKcy9DOFNnK1la?=
 =?utf-8?B?YXRsTUFuMmwzY2Fld0cyK1lwMDBFQUI2YVlITGREWUNSS2xnYU4wQWw1WU5F?=
 =?utf-8?B?dTEvb1VFWDhNQWJkMHVwa3VzZ09GWm9BanlFMXorZVlJNk1BMFZWbWdKMEla?=
 =?utf-8?B?UUw2ZFRJcTFNaFJYVXZMVlhidG1UVktVeE5ldmhVVCtJRmhkRXYyaG1pQ09x?=
 =?utf-8?B?Q1YzL0d4b2FhRDNBTlNScGVmcHFYeVYzSFM0NTdTc2F0d05KeENmS3ByRTZZ?=
 =?utf-8?B?c0NOMWJyRVNxb3FSZ0xicUl0cnlFWGVLYm0ydytOT3pNQjFZR0ptWGRBVXRs?=
 =?utf-8?B?NU1OZnVEOCtuT0p3RmZETWxDNXpFWlZIOGpoRGY1c1NRTk50R2QzT1ZNdk9Z?=
 =?utf-8?Q?3YJHw3vjEOjX/qvHqCLMnAPjHuBkgVVvBJyxiLWAS6E2P?=
X-MS-Exchange-AntiSpam-MessageData-1: Hriuilh/foPPxA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff76b7e-078a-403c-fa42-08dea42a4417
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:37.4281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv239NHSpqz4sHktNpvZ6Tt5HZQ0fogXMht1L8In6HF0W3sVmnvu5bjBlcrwkgdRg2NTvjo7HoPD2Y3OHU87xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

