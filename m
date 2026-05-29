Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9905FCD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFDF210FA15;
	Fri, 29 May 2026 07:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iePAs5Td";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C7710FA15
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:34:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDqIbH7Fz0HVeBlh+7XNT+x/ssHLQjW2+jHAqoK/UKlQ/CVpfIbTEvCIc7x4o65dO8/jb6A9Ra6PrFA1i5IbVlRI2/sir9EVENGo7O5vHiLq3imvOSPHNLu1rjTkGCr5f2tVYqcjwAydfu+1/IXkloVIn1BRF1Qy8InqpQ3aN+StktFZ3qIO9XG5Ib9uVJY+25sYnTAIe6jWIFVusqS6jdRqAY0c9POEvSpdc1e5uKe0aUnnqPWhORRIYWOmJ03BL856evzrCYTITdX4xzB6JqERsjY5zC2VaX80mQtDU7N9KQrszSLq+XeH16ObSQm2ORNfLr50Jwyip3UGRNYo8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Legy9iHXCRpYvhmbLaoMds/W31X8HP1lt2LSyQGOlAA=;
 b=uemWeQQWC6oHhNGl6e1hfF9xo42GKnyQjfjnZI05m3ODGvHWraMePCIUC85MGyEBTgRgW5nmCTR8zs1mOJ9y46L4GKfgat0Dr6lfcHOFatU6xG77wUzRTbOFS/id4I2ffagAzH53H7Ga9J9f0kCiuykQh7coWtA71UiAme1k6OFDThewFGl4LeCeg2sNJKMaJiw2WWcdvZYh5Z315mCO+bED9Do2GYi+sTIR2Awx0nE9geJyg/cmAYdWJNgnOYjbGcFn4HPTMvCulmpvi2v2bOuvp7aSfVcExew4yn5tTx8VI/uFUF5LCjL3gjTndJ6ZRzD84se7C31dsf/Dr5EZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Legy9iHXCRpYvhmbLaoMds/W31X8HP1lt2LSyQGOlAA=;
 b=iePAs5Td0/V8ZmvKIW+PS8m6LGJ+yDtW+v4ZPOd27Vk+yNNH0uycJ10eBrJC91aNbbUzZ9DErNrj+n274AnZyIUCo0cLvfCdZ/iMaK+FfC9A6DYeyLUTpTPBEPavX8II88Eeq3+ILJDvtUzPbzCy52MFR97BXXcXCKcBGr/6t6JkgtaCpllaOzTI9LNvS1LptTlUOti7AYEoLt27ZOYLADtgddd2fwUKV2XhdqyLX6Fk9NLzKOMF0gchQvnmZZGEdvGWPlOtBmTtgIGy/ob6y6MbEqLraWwJXqFC6GByy9v5AnKNNIQxHDIkkOWsEJBgGfB3PDmnEEpCxeZuf4EDDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 07:34:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 07:34:04 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 29 May 2026 16:33:41 +0900
Subject: [PATCH v7 1/4] gpu: nova-core: gsp: move chipset-specific parts of
 the boot process into a HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-nova-unload-v7-1-678f39209e00@nvidia.com>
References: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
In-Reply-To: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cfff18-221e-42e0-26c5-08debd54a8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: RYCHXEAssoeXttCYyU55PAu6LQMJTnySlUXDwxbeUA5IfYKEN5gH9ndnEBwnTXU3ZPXM2pC4UFbJ8CedknVDU5LaFJJMsoM0T0e2MkTXxik+Bsiu0/l7OFyYRvAGrAV2t5wgTeXuOSGaUiByWPpctm/ucLjHkAy0pVheDkrM2x+VqzcpJ9dXbAOnDFqkiAsptO0E4vYhSok6JbPrPosMsbQ+1iItopPMarVJB3ykmIsMEio4o3nTOJ2FBMZFOuMNMjZ3CljUwAfl+MbZt3m3M8xywOQ2krUdOdLwFUivunTTiXKi+rShtW4brzmspRTtvI1bGvnFyUb9bXE/d5ARWe/GsLgrHXUGf/avQRUXCaZNRJZVdfMdAHTjl6vzLCtCRRZjwu07ql7IVc2FHPiNwM0QQMzQ9X0DhvL8WS+nVdSSsb5waFDF3LEuh9w4Pio1R8t248ghUusJbr/Ri/fuUPTjNMr5Fp/HK8StkZSaLxTPhECXV/kzFXSDjtrBcN83Ko8WprRun7HyumIehYwHT5Pep7/OPV7Op076yo+EKoYcFOhnSPAXzC30MXrfiiNTOWE4RL0gHRvX3Zo3jIX1ZZNyQwOtiwz1cMSQBlnfdlGuLZPrIg6AU+ZaqVZuR6J3C3rJfC30eHNpy4sNpkl514j78W3e62d+eza6y7p3gTwXoikleirB1mS+J7mVKIQi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFzYjhGQzkvWEJ5QU5VM3JIYTRoMlRGcjI1bUlYUlE1SXUwSitTajFLQXc1?=
 =?utf-8?B?a3RKSllqU21wVDBTcStaTXBLM2NlRHBFeVcrM2NjcVYra2cwT2NDamJYYmpM?=
 =?utf-8?B?MzNBNHpkdm1uRXcyVUF0bko2UU90ZVh6a1VlcU1HLzRzM2FZSFk2Qmgwa2Mz?=
 =?utf-8?B?R3JNUTAzNGtoN1BtUUxJakFzdEJrRG9EK3FVaUIybVpUOVU2T251aGpyVUpB?=
 =?utf-8?B?b3hTZ3VBOStJYlZ3NFl1aWxicm5MQmJ3WGduQk9ITW9CSHFQdktheVFyeDNS?=
 =?utf-8?B?Y1pVZWdXVWlTU3M3RmJINXVEOFQ5TUROekRvRGNmVnU4Tk9DbktYejFCRnlR?=
 =?utf-8?B?TWpFdEQzN0ZEdnZvZ1d3RWdZYS9JaVVqTE1oSzZtR0d1SzVlemJTN2RRbVVx?=
 =?utf-8?B?RHQ2RnVDcXY0KytBYUlUTkxMYWpIMllwU0xRc3VhOGRtRWZZR3hhU08xZjRt?=
 =?utf-8?B?aWNBclFhV3B3b21nREdiTUxxalQ4WlhRTW1CbVl4UnF6blNXMHQ2dnNoMUh1?=
 =?utf-8?B?bWI4M28zU2FRQlVqbVVpVnh0UG5rOVRUbGFBMnEwUVFsS25XS0piUVB6Y0pW?=
 =?utf-8?B?cVo3QWJnZEJSQjZNRUVjKzhBU1daN2MvSmhIa3JoQXBLdGl5b2F4aFVLN3Bh?=
 =?utf-8?B?eFpwdHNrZy9Sak9oQlM1cEJ4a2dCemw1WmxPVHFiZVpvRmFiYXdhbzIyZVU0?=
 =?utf-8?B?eFpMZVZwS1lFZjZXVmg3RHlXdEV3SVptUHVTQzBJM1VrUTlYaUlRaURhUE9t?=
 =?utf-8?B?L2tnL0E1UlA3M09xOC9CRFphQUZ3ek9YcmFZSmNaTU1jVDc1QmJBZ2UzNXJa?=
 =?utf-8?B?U3V6ajhpeE1iWE94VzcwRzh3bzcyRFNWVTBEbEJZYjJ0QUlVS2VLa1MwdnI5?=
 =?utf-8?B?Q0NscUZGa3dnajBVRHRqcEpOTTVKY3JURDhwWVFyWnY0OWR4MGlsZUFCWEI4?=
 =?utf-8?B?MGQ0NUF6anB3RkNaUmJ2UnlqTnRJTWFDMUhERVN3WCtqekNaalZ2SVp4U0JH?=
 =?utf-8?B?VFJvVENYaGZ2Qm9jWUtyLzdvSkhncWRSME9iSkpKTnkvbDdLUTFpQUZXd3Yv?=
 =?utf-8?B?MEIzcU05SjlNbGJRSjZKVmNTVWlqR2Q1Y2ZkY2RkUlBTNmErWmJ2eHN6QzZ1?=
 =?utf-8?B?anlUVUwwd0dQeFFxQ01aeVZWWWtFQlpMTCs3ZzY0MzFMUHZSZmpBN0RLR0Zt?=
 =?utf-8?B?SUJESURXTnJZLzdTUU5ocGUxSlZreDVzMlJBZG1uekhacmRIQ041eGF0VGt4?=
 =?utf-8?B?MHl4cFFVVllZV3JEaHJHS3RCNTJ0MGdyeVF0ODhRZitVMTBBWjE5aFcwUlRJ?=
 =?utf-8?B?eEhPTUcwUUpJRVVNN1BGRVdNVWJvT1Y1dHJuaUQ2OHFac2hlcVE0RVJrZGJ6?=
 =?utf-8?B?dnM2OGFBNEt5MVcvYWM0bU1ia1IvZmU5QkVDV3Jtb3F3TEdiWWRJY1BZOHFm?=
 =?utf-8?B?UXpRdmhMc09ySi9WMG1nNTlnb3I2aEhzdGljZFhvWjFYK2ErbFJaSkNEMXNG?=
 =?utf-8?B?c1l1b0tqajZzSEw5UFczZW91UTlpcjNGOGloRW1SdFd4U1pkdlQzLzF5akh6?=
 =?utf-8?B?d0dmNkZHYU9ycUFqSlZqdUZNUmJCMFE0YTBEN3FlWnIrenFzdW16NUJiRDVW?=
 =?utf-8?B?T28wZ084YlMrVlN4SHVlRW0xK09HTnk2VVNmeE9vV2w2cUFCMHIrWnRYUUxD?=
 =?utf-8?B?UEUzcFRaelhDbTNUWFRwNGpVckt5NlhSWVZ0UnpJVEUzcTJUY0pzcytSajlM?=
 =?utf-8?B?anNXUDZic25uM1VTYnE1R0hHUko2bS9lcE1WVDVMamdQbm9pSkdUcHBkZWdU?=
 =?utf-8?B?WTI3QStFOG9BK1VEaXNTMEkydTRBN284RXJUVndwVDJYOXhGQ1QzS215YktI?=
 =?utf-8?B?U2hPR25WV2tIV2gyL0JLUFE5a1hGWGNDMXRyODgrWERXSWFXV0Q0OXFOSDNz?=
 =?utf-8?B?SHJ5M3MxUVAxNEYzYkJVV2RCYmRzbzlqSHpnWnExUUhkWUhld1Nmc0JwRytu?=
 =?utf-8?B?VTBpR1RDN2RNZ1J4KzR2WDBDMmtQTzkwZmNPSURNZDZCVHBCUWVSeUp2aFJI?=
 =?utf-8?B?L3RiQzVPcDZkQnY4Z2V4eVU3YjVRMkQrVDhBU01vVXN3MG5QcUVVdDV3Qk1s?=
 =?utf-8?B?L0V1UUlaV0hzVWZobTBJdG1vK295NE85SzZQVW1aWGhFVlVDMDVtRm5jelFT?=
 =?utf-8?B?WkZSbytibzl6dGl5S1pVZ0g2ZnlPUmw4QW1YYUVyeVdYblhWbkUzcnh0TjZN?=
 =?utf-8?B?T3l6aGlQOTJlek1xejI2Q2ZhL2VHdmRMNE9mOGQwUDIzMHlHOUFXR0JkRi81?=
 =?utf-8?B?c2FaMjBDeVNHYkQwOHlyYnBvbnJrZVQ5Y25PUTZmaWZtaDhyMVJtQ0hJS2oz?=
 =?utf-8?Q?stZqPviUhRlv6igSCLk8iKSp8OCA432YVXC5Ah3OmaeyL?=
X-MS-Exchange-AntiSpam-MessageData-1: V5nXxT8u6axuvw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cfff18-221e-42e0-26c5-08debd54a8f5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:34:04.4529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Bg+Kk4gerPfqlIKdod7+bO+VXJgR4WMdXWdogxdRGo4B7AJvUJsN4OT6uGELCzHnwF0v/cJuB704s1mupuFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs           |   1 +
 drivers/gpu/nova-core/gsp/boot.rs      | 166 +++-----------------------
 drivers/gpu/nova-core/gsp/hal.rs       |  74 ++++++++++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  50 ++++++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 206 +++++++++++++++++++++++++++++++++
 5 files changed, 344 insertions(+), 153 deletions(-)

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
index 259f7c4d94f5..1bd9f21fc443 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -4,7 +4,6 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
-    io::Io,
     pci,
     prelude::*,
     time::Delta, //
@@ -19,121 +18,17 @@
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
@@ -149,17 +44,8 @@ pub(crate) fn boot(
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
 
@@ -168,38 +54,21 @@ pub(crate) fn boot(
 
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
+            &self,
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
@@ -214,16 +83,7 @@ pub(crate) fn boot(
         self.cmdq
             .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
-        // Create and run the GSP sequencer.
-        let seq_params = GspSequencerParams {
-            bootloader_app_version: gsp_fw.bootloader.app_version,
-            libos_dma_handle: libos_handle,
-            gsp_falcon,
-            sec2_falcon,
-            dev,
-            bar,
-        };
-        GspSequencer::run(&self.cmdq, seq_params)?;
+        hal.post_boot(&self, dev, bar, &gsp_fw, gsp_falcon, sec2_falcon)?;
 
         // Wait until GSP is fully initialized.
         commands::wait_gsp_init_done(&self.cmdq)?;
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
new file mode 100644
index 000000000000..fb3edaeb3160
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
+        gsp: &Gsp,
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
+        _gsp: &Gsp,
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
index 000000000000..3f3675f9c16a
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
+        _gsp: &Gsp,
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
index 000000000000..a6f2b2e279e8
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
+        gsp: &Gsp,
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
+        gsp: &Gsp,
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
+            dev,
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

