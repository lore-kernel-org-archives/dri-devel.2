Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2272EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4F710EB90;
	Tue,  7 Jul 2026 07:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ANeB+JFT";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE06410EB90
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/yAkEHExd/qKQyDxzI66jmDg4F6PC+GxXT6nQBd4x7g7T1zMJEBrYEOXSP6O2UnUeWFhDldB1rQN6XOSs/71J46ozq/gjDM8zDpxxE/wqJ1WxnYT9LwroIs76c0EzSqg8PtEuv61S6E2AuRxnFgstW5uQw2/NxB48JN9kfsWQDYX/RomcgEcJk9wzp6i0mY3KKM77GZQ4DZv/MsKSC8XUOuG8Q0SwGGYgor/lOPjgPl7jyak6s1zr/yT/9bnWVpUChdUGeq6/QLWgNxF7l77qfJfVbn9t/PnSlCsbMLNt10d+FpsgH/hUUzqKiHiq4Hl2CWqfmRqYjEkR4Y3jbVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyH5KoL5XJwh9Qa4C3XlLWN27GuJ2wAuf4KWsgdDPcM=;
 b=c+N1iK9Ax/7Hfu/wKcQY1/He5L04Vzs39yppSla+epROcaC5E3wbW2BxCFR7Fu3a6g4yW1cGx1Fa04LTc33tQbwQzqIdIByjmdCC8XkqvCRET+AthGGlUf3x6gcfMxhB2HZzp1NLojserACSuS8/9MjzOsmv0y6BJdv7pTJDtiM/EPnRjh45w1tBlzs5b8uDz6hSR/Oh2sgWhR+25OyHR0wZbnJ5BqyASeP7mRZE0QQGcDUcsA+TQd8WaNPCykN05jjylRFFYO0A/OsXr7rjQAN/10ejtdvzK6uooAZjMrMRee2l/VPKx7YTHotYKvQjJrGn1l5v5ueDuvr+IrXwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyH5KoL5XJwh9Qa4C3XlLWN27GuJ2wAuf4KWsgdDPcM=;
 b=ANeB+JFT7cTLJL/8NkjLBJLzLlJOMJLS1vl6lkSNQaqANBuZlWO2Qo0AOJR5iajvDSjSc+eACIF+2jxGvTyj0t6u60OdwdRa1oPNI1jsoNNRghoNF3U0btct1oGrWismrFS1Ap423YPiQ0aa22eqbgEJXzXgwQIQG4x0n1gFupezV79ZgahKtkhwO+s1jocVJyX5Uljk3g36AvzRCIeH3T3moJVHxt4wcBARFyzgOVCvXSuAYGGQw+/odlqbYs9K11cK/CGfPKtg4jrGzjnbb3hAVOdKMJVooyI7vYG9sR/BECL28fTAfjnXdgFnQUdTJhP3qoaGDe5vPF1WJY8YTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:29 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:42 +0900
Subject: [PATCH v5 09/13] gpu: nova-core: move GSP firmware files decision
 to GSP HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-9-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 91eb61ec-7cf0-41c0-877a-08dedbf880a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: zQUliaqF4MVJX+EYDNZhRiWwHWHg2O/Dt0sFAbZy08jcHuliSL/J99+ozBZFsNK5IguRD9UxLUX6Zu2qB/U66kN6gfG88mru2TOhtdFWMOOH645us1MwlZF1joLUx2CZtMdKOFqt5RnaYwWMO0ziQjfSCJMXlYYZ5grA9pC0J5aKe0oS2EVTpvJHMaFYghBs2k4Cj6YTTfFqA07RCCIrpn8jofH3sbocx7VYa2s3LGyXT+/w5EwidxStxHvk/CNoVQy5Js48Hvbc0BtoipoCNBe/um8GNYNEJgpcSMXLmLbR5mIALqzy9OhmO6SZA2R36MtHMvLuE6H2wYR+GIEhX7iyF+lyU66mBbKFWs7ZQ54sCmNaEA9PTH43O+Loyvn0WNXRprouv0cOPyFqgOWRBuvWJ9k/wTicMaM1Q/jHJYLBcSbw3Qs5OKgnHCu57fQozniVYKiVLOMu9KQz4gqEZXiT6SprtXEY0PgmidlD9hc2F8HAyHOUlspz02hmBVSyO2zkMXBnskmHfAqWGKWwIgTum28W3SLmIvQKya+6SbwdNQCPdl2Wtzhj1mvQhcbqyx/OtsonQhCmjZuEAlzK0Hd7Mwd7Ua4Mo1lyOybWDLrfSk3j05x5k5JkkQyHnwqpXVB/Hti0pm4ClI+1pKCutJ2WJijvMlt+tJpPoj9tfQqLx1QsQrB9fZUYLS83v+62249BGd1R+PXPbw6M+IHHrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1M0bG92RUY3T0NZMzNyMUVZS2w5N1FySEFRa1BiUUNrYmwzTUxiSHNsVkxQ?=
 =?utf-8?B?R3Z5TGFSOStQeVFaT053RkpWWFRYYXhrbXdhT2JtRlVJN1JPSW9qQm9DK1Fm?=
 =?utf-8?B?V2ptOTZrYzhTcXZPQnFOcnNRVEdyeHN0a0xRdGdLUm9NT3RXNG9uNHFxam1L?=
 =?utf-8?B?bmZkemFKLzVSZStNcFY5Y1BSSEQvdlVaSksvdGRuQitVRnNramQ1eHZoeWJU?=
 =?utf-8?B?MWJxUSt0WVdLMVFoU3dMcjlnbG1xMEpVOTRCbDllUGNLWktCTitxVEY0VEJs?=
 =?utf-8?B?YUUxZHBQNkZzb2lkeG13MUF0bTBWUFBOQUk0U1JiU1lTNkprKy9kWkhwbmJX?=
 =?utf-8?B?VGYwdkFCL0pIRHFzQkg0N1pvVmVtSXcyVmMrMmIrRlZ3OXhCWHdvYkZaRll1?=
 =?utf-8?B?d3VxT1RhaHcvQys1c0pXWEQ3Z3o5QUgxNXo0ZE9JT0NzNFV3eW1vUkpEekRC?=
 =?utf-8?B?KzQ5M2pzVCs1T0dhWGxZenBRa1N0RkZpa1VIYmhWWEdSMnZpTFFXaFRSVHVR?=
 =?utf-8?B?ZWQ0RGJDcGhZRXNGTWJ0TVBDNVJGckV0eUxGRFdtQmU2eXVoVnZRRUJSbDJB?=
 =?utf-8?B?bHlBN2RTVmxMN2ppMHA4T1BHSVl0SHhxbDg1NDIydHBVemhFdGw1bk15K29p?=
 =?utf-8?B?OFJuK3pLaytSZGtmRGVBWEEzYXZ2dU9mWFFCcU4yZ0NjOGhxL1h2VkRSS1lh?=
 =?utf-8?B?ZVMvQkc3SzMyVTBEZ1cvV3AvdTZNRzFkbG9ENER3Sit6alRUd210cG5DeTBU?=
 =?utf-8?B?RjVGQTNEeW52RnJSOTV6eHN4R2QvRm1iUlpRTC9uMnBKNXFGTmdjYzNZMXZY?=
 =?utf-8?B?ZnlOZ0FNOU5hcjZYWTZOa0E3TGRJeFlRVWFvQk5IUFE4Z2MrRzdlMlpFNUlI?=
 =?utf-8?B?WFFnM0F0L1IwL2E4ZmNZVDgrUFFKZG5xTnFEaVI3UWNSRCs0QndibXRxa25q?=
 =?utf-8?B?ZzhsNkZveU14LzMwWHNmZmcwZk1xZkk2NG1NQ3F0U2ZDa2JVUnJvL2RNYVRZ?=
 =?utf-8?B?MXI4Z1pWMThqL2xYTHNLc0puWUJ3ajE5eVVnY1ZRSHR1SGhmTDZQUWtEMDhO?=
 =?utf-8?B?N1FwMEMraEZvTk1XNTZpS3VXOEphalM2TXVLRCtXOUtSRmVqalEvUDlOR3Uz?=
 =?utf-8?B?VElReDd1S3A3L0trekNqYmZ5djFQZ0d3TUN2NU1GTlh6TzU3ZVQ3NWJRT3R6?=
 =?utf-8?B?dWY0Qm1ZVityL2t4SHN4d2ZjaEZXTDB4ejZDMEJCd0Q1WitUM0p4bGkyc21R?=
 =?utf-8?B?YTNKZG40UnNraFRuWHN5YjdRbTgrRklta0NrS0haN1NzRGhFaTJ3Rjhta25u?=
 =?utf-8?B?RjFZRGd1MWdkUHNFc0VMREJXQWJQL1lVZ2JOL2R4LzR2S0JjdWwvaUZxODB4?=
 =?utf-8?B?NzFVcnhKZUF5azI3ZUJPTHdlUXRCcWd6eUE5YnNSMUNpeXgxZkxCYWhBb3hq?=
 =?utf-8?B?SldQUFBjS2RvcS9iWWpEVUx4RG5DUm5RazZUZ0k2emd3cWRtVzBYL3IxSEov?=
 =?utf-8?B?ZzJrajZ1QVlzNUZXMFNLR0tDRHZqYytSbHBIKzlBbW9YT2FlN0R6bzVwandT?=
 =?utf-8?B?aUkvMC9HUVhiNThiQ1hQOFpQbHBxbHZvbVYrcjBNWjBVa1ArcUFlRGFvckVN?=
 =?utf-8?B?Zm96TzkyNkxjZVIzdCtiUllFNTcrM2h0WHRlOUtFMnhEWGNlck5oQURvbXZB?=
 =?utf-8?B?dVJzd0Z0cnZ2U1ZDQktRRzkvcVVPWDlxcVZOdVNSbit0eEtGdDduYnRmMXJn?=
 =?utf-8?B?MHl4MVoxZzllcGdnbUw0QXhqRk5lUTBkek1NQ3JnVVlTRThiayt1RHZINXdj?=
 =?utf-8?B?aUdJYlkycTFHY3hxRXhvdnQzbmhOTjJ5czIyK1YvTU1GQ09ELzVQNXlsTjVH?=
 =?utf-8?B?TS8zUkMzck1HZ3d1cXp1SHlkZVFqMFVuZit5eDVYRld2OFhBclpiYklKSG83?=
 =?utf-8?B?RU9kS1lxY1cwYlNJVWVnSGV3SEtTVlZhN29iampDbGFSMTBLdXZmUlB6UENz?=
 =?utf-8?B?VkNMMmxkbURjbFhTckcyUU95T3B0UFFWaXIrL01iYWxJVHdzcFZRR2NUeXJU?=
 =?utf-8?B?cEpWT0ViM0cwVWpweGloRFdRUXB1b2t6aFZib1VFOFQ2YlVyVkRYZ2ZURE4v?=
 =?utf-8?B?cytndWgzWkZ6ODZOeXFLd20zNmZLdTllaW9KRmQ5UGwyT0FSNDB2U3A0T3ZV?=
 =?utf-8?B?b2Y2TUxDRnlENE0zdmxGZ2l1ay9rNk9JSk5acXF3QVFVLzN4TWpydFdHUXRU?=
 =?utf-8?B?QnBpVkJVeU5tdTZmeTUwaGlwQjk3MjZTc01vbEoyZVVDYllNR255TUFybS84?=
 =?utf-8?B?LzRqUEY0THdBT0tpdWtsSEFldWNiSU96eG5MdTYrYWZPR0xJODhxeHRBTlBN?=
 =?utf-8?Q?rsXHitKZKEUQGfVcc9iOk3tQWM3Vs+wdS4FK85qs2DCV6?=
X-MS-Exchange-AntiSpam-MessageData-1: iOYsb7/h9z2vDg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91eb61ec-7cf0-41c0-877a-08dedbf880a6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:29.1511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0qA1QR9a0cGZ8/C0fR7o20iATPsY/f5pFgksBcjT9S/bGzcoAB4sOO1YyMS4JUJgF2Z+Kf8uV+tu0yos40JSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

From: Eliot Courtney <ecourtney@nvidia.com>

The files to give the `ModInfoBuilder` depend on the chipset; this is
HAL information, so move it there. Doing so lets us remove the
`uses_fsp` and `needs_fwsec_bootloader` ad-hoc methods of `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware.rs       | 25 +++++++++++--------------
 drivers/gpu/nova-core/firmware/fwsec.rs |  5 ++---
 drivers/gpu/nova-core/gpu.rs            | 16 ----------------
 drivers/gpu/nova-core/gsp.rs            |  1 +
 drivers/gpu/nova-core/gsp/hal.rs        | 19 +++++++++++++++++++
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index a94820a3b335..20eff987c5d6 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -21,6 +21,7 @@
         FalconFirmware, //
     },
     gpu,
+    gsp::boot_firmware_files,
     num::{
         FromSafeCast,
         IntoSafeCast, //
@@ -419,24 +420,20 @@ const fn make_entry_file(self, chipset: &str, fw: &str) -> Self {
     const fn make_entry_chipset(self, chipset: gpu::Chipset) -> Self {
         let name = chipset.name();
 
-        let this = self
+        // GSP firmware files are always present.
+        let mut this = self
             .make_entry_file(name, "bootloader")
             .make_entry_file(name, "gsp");
 
-        // FSP-based chipsets (Hopper, Blackwell and later) boot the GSP via the FMC image loaded by
-        // FSP. Older chipsets use the SEC2 booter instead.
-        let this = if chipset.uses_fsp() {
-            this.make_entry_file(name, "fmc")
-        } else {
-            this.make_entry_file(name, "booter_load")
-                .make_entry_file(name, "booter_unload")
-        };
-
-        if chipset.needs_fwsec_bootloader() {
-            this.make_entry_file(name, "gen_bootloader")
-        } else {
-            this
+        // Add the firmware files specific to the GSP boot method of `chipset`.
+        let boot_files = boot_firmware_files(chipset);
+        let mut i = 0;
+        while i < boot_files.len() {
+            this = this.make_entry_file(name, boot_files[i]);
+            i += 1;
         }
+
+        this
     }
 
     pub(crate) const fn create(
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 95e0dd77746b..7a931f22f629 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -385,9 +385,8 @@ pub(crate) fn new(
 
     /// Loads the FWSEC firmware into `falcon` and execute it.
     ///
-    /// This must only be called on chipsets that do not need the FWSEC bootloader (i.e., where
-    /// [`Chipset::needs_fwsec_bootloader()`](crate::gpu::Chipset::needs_fwsec_bootloader) returns
-    /// `false`). On chipsets that do, use [`bootloader::FwsecFirmwareWithBl`] instead.
+    /// This must only be called on chipsets that do not need the FWSEC bootloader. On chipsets
+    /// where the bootloader is required, use [`bootloader::FwsecFirmwareWithBl`] instead.
     pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<'_, Gsp>) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 32bfa0be2357..c04706b60ba8 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -133,22 +133,6 @@ pub(crate) const fn arch(self) -> Architecture {
         }
     }
 
-    /// Returns `true` if this chipset requires the PIO-loaded bootloader in order to boot FWSEC.
-    ///
-    /// This includes all chipsets < GA102.
-    pub(crate) const fn needs_fwsec_bootloader(self) -> bool {
-        matches!(self.arch(), Architecture::Turing) || matches!(self, Self::GA100)
-    }
-
-    /// Returns `true` if this chipset boots via FSP (Hopper and later), which requires the FMC
-    /// firmware image.
-    pub(crate) const fn uses_fsp(self) -> bool {
-        matches!(
-            self.arch(),
-            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x
-        )
-    }
-
     /// Returns the address range of the PCI config mirror space.
     pub(crate) fn pci_config_mirror_range(self) -> Range<u32> {
         hal::gpu_hal(self).pci_config_mirror_range()
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index b4ac4156056e..d5cca3c8350a 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -30,6 +30,7 @@
     GspFwWprMeta,
     LibosParams, //
 };
+pub(crate) use hal::boot_firmware_files;
 
 use crate::{
     driver::Bar0,
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index eddb4e8bf510..9da078dd1059 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -57,6 +57,25 @@ fn post_boot(&self, _gsp: &Gsp, _ctx: &GspBootContext<'_>, _gsp_fw: &GspFirmware
     }
 }
 
+/// Returns the names of the firmware files required to boot the GSP of `chipset`, in addition to
+/// the "bootloader" and "gsp" images required by all chipsets.
+pub(crate) const fn boot_firmware_files(chipset: Chipset) -> &'static [&'static str] {
+    match chipset.arch() {
+        // Turing chipsets boot the GSP via the SEC2 Booter, and require the FWSEC bootloader.
+        Architecture::Turing => &["booter_load", "booter_unload", "gen_bootloader"],
+        // GA100 also requires the FWSEC bootloader.
+        Architecture::Ampere if matches!(chipset, Chipset::GA100) => {
+            &["booter_load", "booter_unload", "gen_bootloader"]
+        }
+        // Other Ampere chipsets, as well as Ada chipsets, run FWSEC directly.
+        Architecture::Ampere | Architecture::Ada => &["booter_load", "booter_unload"],
+        // Hopper and later chipsets boot the GSP via the FMC image loaded by FSP.
+        Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+            &["fmc"]
+        }
+    }
+}
+
 /// Returns the GSP HAL to be used for `chipset`.
 pub(super) fn gsp_hal(chipset: Chipset) -> &'static dyn GspHal {
     match chipset.arch() {

-- 
2.55.0

