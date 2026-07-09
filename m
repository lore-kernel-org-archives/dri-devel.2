Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D603C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C884010F3C1;
	Thu,  9 Jul 2026 06:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="h8WYZ1NJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD9E110F3C1
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnfPfXMSideTs63wmpYxvqNlc/daG39z40RQn56oxu+HGNMKH5ZmGhE67pPvPiDDMywsgVvkyNZ0M+RAfo3tiiMA6DYhhCDrlZsfeQEOlmDAxcCW5NBGlT4fp4+GCuJl8YFcbjn66ozVI7vMIdh0qGiLVN60+JB1Fsu2ND2Qhp2MtXbdbh6LrmA5tXeykBM6IaEWtZu7jkd817nPpsdkk5D7q0M+Db1ADTr9K/N9berlwhE3cwUnaRRTwNuVFu5M0gfsuw6Gjhfq0LuaKZBrXIT4z9TjUYyBRqj5NJBhCI354bKm/ksAOsDYZHesqvQfvswPr0T9D5Rnj2HfwSQKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k68YiBO9j6N4gJ0k18kx5MAZhF7ZKNQc6l7KzH+34bY=;
 b=l+k9FNsiLgXcL/AQMyaoPoJSh3ND3jKznqHWCUPPh0TdsqYztozJrc+CeTEsiMGhMEQAOVUsvDznk+Nf1x41PJjCaJfvPDiGWOFJe4o/vyBs91U6EacsrxA5OVKeRqrkrcm8vuNqMCMFAGbX54SO7+dIEVcG+6OK/4hEjtqe/63MCtHGaDCObjFg+Yu4bnHWMqXBZhkcN6HtOx0n1GR+++3QjuSNOoEFAhuvDpy8f+wiHlwEFv3y7B0I0/nwBRyuN76h0Wt2fNlCX/GRq/QltzmLSnE4jjo7EY0xETb3TcpPZAJ+A1p0eA0NIqFxbHQN33sXp5g3sMmAAdniQmpeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k68YiBO9j6N4gJ0k18kx5MAZhF7ZKNQc6l7KzH+34bY=;
 b=h8WYZ1NJ1O5DfiAfSC0H3e+1Il5eRAAvVklTcYbuVMCDJ2av25FKmNA8MQ/R4O7cQzdAgbQg07S1PRKOexiJl1KKpcwLUtDI6M99ebBZdVaCWaCOWXyMa21pA5IhiPRPkjbUu1W+Ow+I1IJq00lYxzv1O0ioUoqNAH+dCWXYdJwoLUg1UAfygR+SMHt28wR1PBEPXKGIUYRXpzVQg8YP+OSLU5u0qufoyJa6PXR6Q3K1BSPN3zvsbJ3il3/UYZzgIRLkEiWvU8URjoWvW7VrlplL+Hvs+yLKJUu+a2iYpjtHXuzcCQ/DHZs4niB11/dyN5ei8y/MLL388xN0RFqzug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:57:10 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:57:10 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:53:02 +0900
Subject: [PATCH v6 09/13] gpu: nova-core: move GSP firmware files decision
 to GSP HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-9-520cbf8b9b50@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::7) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 39edc05a-6c2c-43cd-8f57-08dedd874c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|6133799003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hK/sVdI+shfiwQrOs5Xpvyd/jPACUrXoroLqE6LF76rM2UxL5JX52rnoCcvt8HtaS75XnJ8FhYFWDpZKcIIjR6jFauN/XgMvohVfQxs+rNPDJkltF8HnL8G59PPIMqGCCKNyK8UqiZvi1jm56JvaHG+FTsfUIxKWbSBe0zdPbUdJinLFSWMrGHZk1HjGKlH5T1avfweoDjLW6kWWoatsShaBV3jmN+uwHYw+hs+jlfM58UEGIv0OYFYd7OSRqRcixFOjtFyQz8GTp4AxAUgKQ8dw/i11IRe3/yUTSjWzhmHBrrlEsZkWAqO5gIiApqxl51/+jixdU4QaBrwbd6uc5XXyHLYEeoJ4PKmpI4svZNPWR11FsTXTDx9JABDfi2c3z58+w7r4dGnA95BhVDPAVLmFkrlXz161PpWiK6OOEIC0vGsCfpkoDn3naZO3wXE/4e6eACKm5M+tStA1Z3ApB+w0Va2UVww4+qo8au+QkhVnxrYFEKm9Xk+/EwwboqAWoYM+BWP2Goljk3IOmvd/gBFk0boSRurSpfqe7t203VhPFuq0PpFNonRtH30ECiHApDFnvsbEFTR+D8dDKS6tpKkjBu2K9iKFyT/UyTc2C8hFYumC6wgcz+cag+rxso8FlPTa0+Mi99eH9MFltYObo4BX43/LymKPBLpEqL/YoZPQgJ6vLaKwo0zdCS82/NBNNL6YkNIP2qZYA+DdenUE5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(6133799003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNVMmNYL25YSmFpTURTRTNpelNPWWxudGdzOFBvaytOQU9ialcvYmdmUERU?=
 =?utf-8?B?enBSMWVXMHN3RUpiTE9qOE5JdzFJL2xZUmxWMzBxRnJQN3Q2OHZJNmlDK2NZ?=
 =?utf-8?B?UDFVeFlWSmJiYTR3WGtyNVk1bHZoL2pkMmJDQWlhWTJQMWdGUkt6Q1Z6YWpv?=
 =?utf-8?B?U09rdEVkR3JPSnRCTjFodC80WCtWMHQ5T21seVR2QS80SVVnSEdIQXFaaVdD?=
 =?utf-8?B?VTBJUW00TmdKVnlySUhGNnUxMXdGOHRiMzlHL0ZJOFFnOFBOeVNJdnB3bFpo?=
 =?utf-8?B?UlZGNk44eGVZSFJoSm1LM0NaTnQ3VjR3ME5UWGgreStHSmlCOUhETXFzdEdi?=
 =?utf-8?B?WVN6VHBZRURYTVJDTy9MdTg4cGhjb01ldSt6dlFoQjlGK09nMkMvbnBNeUlo?=
 =?utf-8?B?TlRybHhTcmNlT1ZKNU9ydUxkclNKOUF2eldBTEgrTkpOMjNMVmhKVXM1K09T?=
 =?utf-8?B?aER1UzROcUkzcXZVQzNHaHBWUjA4TEtteG9mK3FmaXFRQWJ4clB3TFh0c0tC?=
 =?utf-8?B?RkNtaXFIVnB4NFBPWWFzS0N4VjRQaU5oVDdFNzNwTDNNN1BGbmdCU1cwZ2U0?=
 =?utf-8?B?Y1JEK0dSY2FZeG1ldDUxMmZpR1RIbFR2dVY0aFl3QThvRVh0b0hFSDVWbUx4?=
 =?utf-8?B?ZHV2QzFIZlVUSFV2eHEvN0RaZytaMHVpalBUWlN3ZUVyVTNQODZ0QlJEUkYv?=
 =?utf-8?B?TGRsbVdnZnpFNVNUOGpPTnpud1RDOWFJQUxXektxeSsyU2VHRkpxZVZKemlF?=
 =?utf-8?B?RlR1aWFHTTZRZmNWY2E0MlJLRWZsbXJtdVhMV2JZSTlhbTE4OWdLNjVMSm9P?=
 =?utf-8?B?MTJEMWs2RXgzWUVoR2Q1VVhpSk1ETTBxNFRHMFptOVNpc2RlTUxodTlVMURB?=
 =?utf-8?B?RXJPT2tKdU5zUEUwVnNHZjV4SFc0SGJoQWUrNUdrYnlWUHVRVHpYSW5YQjZM?=
 =?utf-8?B?VnFHeHRuS2hISU1hZDRsQXVWMlFpK1F6TU9yR3hORXpNN1REbjlVMmtSTitz?=
 =?utf-8?B?UTFvTVFhZ2tsY0haWG00UUNlelc2SjRkWm8vR2JEd1NQV3R3NnN2eGhKQWho?=
 =?utf-8?B?OTdUU1JYeXk4ZHdOV3NsYS9sS0t4c2FOcUEyRFI2d3NUb0FxZXV1NmErYkN1?=
 =?utf-8?B?RmE2OVFuUTBtK1B2MGlrMmFnN0d2SjhmcE02ZSt3SkZXYVgyUFNjNW1zanRn?=
 =?utf-8?B?S1ZFUmVLZWg2OGxEd1o3R0JHNHFtWlN4Z2U2UVhpZzMxSzV4dnVoS3hhZUUw?=
 =?utf-8?B?L0N6V0JvQ2ViSDFQMDZ3Q3lnKzR4VWpFTDN4dTNJcjcxTDdiVDZkUTdaeVM0?=
 =?utf-8?B?MmhSalJJR29VTlZPcW9HUXZPaFNoVHR3Yk5Yc3lveGR0V2pJV1V0b05rTG1C?=
 =?utf-8?B?emttWUprLzExS0REQkxJZWpBSHMvbEpNbGtZTTMvb2U3bXJreWRpMGNJemdK?=
 =?utf-8?B?NEM0S1Azc2hyd0M4aVpyYitxZ00wUFg3L0RsblVDWkJVZEpHOWpBR01IVU1O?=
 =?utf-8?B?YmFkMExpVUUxc3hOUm1iTy9LRkNZbFBqRjJwRXg2TGVpRnp2OFVDaGc1N1g5?=
 =?utf-8?B?bWlnbzVtVVZtZzRkOGJ1Qy90L014Nk5weG42VGJBUUZZejdLSlZGSHIrMEVR?=
 =?utf-8?B?TTdjVThSRWVJU2ZlVCtuV2pYQzZvOHA5QWVtOWN6VnlDaU1XN1NQR2ZySEUx?=
 =?utf-8?B?Wjl5bFExNUJUTGdreWVPalgvZmRORkF0SkdkaU1CTVg4L2d5Q3pLRUpMV1J1?=
 =?utf-8?B?eVNCWEZSRDZ2b2VySVd3VDQyL3Z6bTVDOUZSTURibEtLdFdOSFVpZ3UyWGZN?=
 =?utf-8?B?ZGkxYUV3MnhaaFpscXQ5dEErUE1OdFVMb3VMVVNqVGd2SGRhVVV0RWxvVita?=
 =?utf-8?B?MzI1d2IyVGZkMmUxak1zSHZrRUYvWnhGU2d2dzZSa21aTERlSHBIejVFSmJU?=
 =?utf-8?B?SjBrNmFOMkE4a2w1RzBhU3JvNFlobGJwVWNkREhCYTYreUZWcTVrRzFjSUVj?=
 =?utf-8?B?MEpncFZPb1I2cWx1M0lsQzFVa3AxMmoyOE83SEhxazA5c0FoUXJvSkg4OXRG?=
 =?utf-8?B?NmlGZTFWUUpVbUJJU2hLcDNzelNVZ1JLL2ZVcjhDM3BJQ2VlNTFaSTlqNmpi?=
 =?utf-8?B?RHhpY0Q5amRIRUZJeWxCOStLSlh3dG1qbTAxVFFpdjhiNGxFZFMxVENIK3Ax?=
 =?utf-8?B?eW9XY0RhVXlYdFhWMFNxUFpsUFpxSmR4Y1QrQnpXYjcyVHNBN3E0cjNNRzE4?=
 =?utf-8?B?L005SENKV0JlWVRVNW5wTzdSNjhJYXl2SVA5SUxlNkhGQ29iUVZVbktqRUww?=
 =?utf-8?B?c2Z6R0Rsc1FVMEV0N2ZNanJtVGVFSHlKQ2F1eU9XSDhvR0Q0dW40aTkzL2I2?=
 =?utf-8?Q?pfApuEKLR2x4YORbhKhrpU4i3yITnrzhBW2pL+qh7i8c0?=
X-MS-Exchange-AntiSpam-MessageData-1: aPkv1WEOTMUZPw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39edc05a-6c2c-43cd-8f57-08dedd874c87
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:57:10.8531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Goe4zXRRqUxulxgCv2yKGio4CuvDmCAbIh2wgnfru20lWBL/KT6BnvqsO8p9LtkwJDMDlWijQds1ODGMbpsHDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
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

