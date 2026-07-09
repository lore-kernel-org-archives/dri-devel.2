Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8E5C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9AD10F3C0;
	Thu,  9 Jul 2026 06:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aD+39UvG";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE7710F3D6
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvAAqOGQrdMTNfG5cWRFe8URsSl5NQHK/WG2+sDIGI7AAY76O7R9ERlT19l81SkcPMxF3yHggGYZfA9HR8WocX7nLXVVYidYQHn08gbkUf7SzCmivp197WexWSIl/2oBng5aYmQ/S5a6fJIfP+p7CR94+ezm2tmsOVMifOSiA9VqswO6/+gtMYt3212bRc+a95I9QwLHmdbN4XFDB/X/YRwDb2PFr6aFOuYkDzjY1J5W7wfXNKYOWR1R9fHY2Ud8rh97CnKM3XrcPuHzfY/kgEUeSEfHW5qez1rz6skZYmO2KG8xJMBR5xhgh858PsEqYmfxud6wzbV6NoXy1XOhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rVUzNbaQfI14D2lQ5cApoiaxgZxPG1uISN1+9krlMU=;
 b=eTaql9o9EuGhQwpBi7aJBn4sanCHxxevTeb804OxF+Iz/CJfq/SFBH2VnmKfkeoeulr5q4ID2VZkWIVmwB7/W1RwuxPaEobaaNaefon07pHUyd3LsbrdJMFqE6r2CZtaVyJbWtR5OjRIi0zPMzJc7UyHpX9Ghz2hJ8VZ9+v0FrtQz9X/yNM9vydEz7OTDKIpaJ5QktyMQYvRbMou/gMwtdX7TkfDmcxJsT8OxmhVbAOk5UH4LXL87FUS/tg9OsqaT8BBXu5hqXcdCvTV66MPpRrSPY302gxGRvEyGAA2ij1kUViuweZ+ftPYmkXFnudvsKH/jfoB2wXBcrPx1gjrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rVUzNbaQfI14D2lQ5cApoiaxgZxPG1uISN1+9krlMU=;
 b=aD+39UvGXCx/DLwSSKELdQUqyqgzd0xHZYv3IlHErQJEn5wb/WK/XkryrCCIBfKkkZMQcgGxqDRQjt14zotcgOL7tZ2NWIKE52mN67Mwa2SEJOa2QbW4xBnCu7RR+UFkLCMECvJ2KjHIY8xRnwl9CV4RhLJpVX4mvnSxtsAKp0SSuhgt0rRM6qfyFlavuhq5eX3GByzOA7DQp7632XjEUbwo+cB/FYV16EXVMl8TlYJBP0Jsq54JI9ipRZrQDOjGRkuM2yzlhQ4533lCcbbHRpf+YvUl/DFNRAkggdhx7ehsRLxktwflwsSdMjpfT+FL/zqmCqxGUOa0lxX6BYA5nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:56:58 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:56:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:52:59 +0900
Subject: [PATCH v6 06/13] gpu: nova-core: gsp: fold TU102 unload bundle
 construction into HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-6-520cbf8b9b50@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: dfef1018-dec4-4b2c-158d-08dedd8744e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lx0jDog8Aquw0XG7YYaH/TrS5OlByrX8z3TjGZUMwnxnd+HcMbcJuE8+ZINZOZ0bVU81jMLblQMk+KhFoahY4TtLmlhpIiVpyWJwjcgMlP3xYAbY6c0PpA2OSDtFdzdoYc/hqu6FF4dKWmqyzFD4HUHxSCWfyQPaMR2NTKnPB5dVfN8RiuhTOyEUlhpQ0MfoUS5s1/ZZZh2AsICkpdOrLOaKI9y1a6g/gBp00URKExyGH4pEE6rkMicHMaxNB9msBPp3UD4JG5rVW3QHuJl8azjeuRBZ+9yLDCmQiweWph3F/5FcVOjyOfAcQ8H16FeeJEUs8TvIuByexbwqOhrGyMgzauIi++buehfX14JHVQpy2qAWcBxyCvvzQQK8xb/iNMSAyCc7M4u72mJomvhxeU6zhuAWFQfau05LWL9plzSLRi1ZKgZMK3RXKW3rPvV+C7VRmv10CoJFbxyJouHfYmQ5Nk84U6lucgW46kI9PQ6c0mxpaXGzFrRtPgt0swxjVDvaHLU2u7tCd/iC8csZ0w04uXRJhYkRfg5wMzGZRcQWPZQur8MMM+gEowJeXc+alUZ5M/GkTAm7PDYj8NZjevSj4q72oPm15YQy5Vkj0xRpV7Rayh/vem3tRAnJ+9UdxBWp+e53SLzGeZp98vSJFwpBIoTnZGOxw0SwgAtyeqJtsC1v6KArEuxgDszuWDpdDLwOG42UYJG5xh5aahqeEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCtxWlp0U0xMbXV4amNDSG9rUWVKT25ab0JXa1F6dkhMRzl4YWFDMFA1bzB3?=
 =?utf-8?B?cGhPS2ZCUVVJT1ZISUtBdEUwWFRpQURrWXo3SjM4SXh2SjJCeS9ZUjhGTWJp?=
 =?utf-8?B?THZPZU9PaUJkbjdNYlpjRmgzRWxFc092SmFqOVJTLzR5YkZTMGJaNTBEVlZx?=
 =?utf-8?B?Y2MvNTdoZnNnMmJEUTA0cFJiQ0VNSGY1Wi94R1RGQURTVGs1V3A4SVBXQnFO?=
 =?utf-8?B?Y28yMEMvOGNraDZJU3NzdXhRa3REOUhiQzdQM2FvSGhic1UzL3M5ZXAybkxy?=
 =?utf-8?B?YmZuaDJJSmJWY1FUbytUZDh6ZmsyZkliTFk3NnpuSUtpQjJzN3V5S0VWenpE?=
 =?utf-8?B?QjdPVWdIV3NIYVZ4Q0lzK2kvbHBHbGovZDVZS2NHWlRFNVFLYzhwb1BvTkV6?=
 =?utf-8?B?SDIrd3lKY2FQU3hGOFpWT09rZTk5dnNveldDUVdIL0NEb013R2dRaUFFbmVE?=
 =?utf-8?B?enhLcXdqWFNhVDVFQWUrSkFXekJKVy9WcnREa1gvSkt0ZEZMRU5aRXhORnZ2?=
 =?utf-8?B?T0FyTTZIWmZJQlpXRGVVb3Y2TUxxOTBmcHlvaDMxS2Q0OGtTcFJidGRkRU5C?=
 =?utf-8?B?Q3BsU3FiR05TZmR6b3NwZkU1S3UveVYrdkVOS2NtdGNTRmVOWDR1MWt0azA5?=
 =?utf-8?B?VllqSVhOMk1ZeEZ1d284WXF1NEdmelkzb2N3dFFhL2U2aXdLekhYMC9MYjVY?=
 =?utf-8?B?bFloTkJWd3Q2SjdSV1VzZGNQa04xQnNjeW9Edm56YjhEa0s5TkN4MlJvQU9t?=
 =?utf-8?B?bUNxY1QySHRxSG1RQlpTbUM0dnhGV0EveTBzTFdCZFRWQVNQRXo1cUQrRGFD?=
 =?utf-8?B?eWxzU0s1ay9LSVBuU2FWb1g3SDFZTkVDV0lHa0tWN2wwZ3J5RVdYaDZ6c29i?=
 =?utf-8?B?UEg0U1BEbklQRTZFRUVBNzhWbXArckFDeFFpOW1pU0RqazRXUXloMlJCWmt4?=
 =?utf-8?B?enBRSVJtT3ZmWVU4Q2RHNHZDYzdZOVc4a3RPTHNXNlc1dm5id05iZkMvVUtN?=
 =?utf-8?B?bzB1SWxabm9XVlpJbTZRMTNwN2JMa1NMM0V4NFZaMDI1ZmdrU1VQbE0xRFpR?=
 =?utf-8?B?S2J6alIybjJzY0JQRTRWV0pBaUtSM1hYU25oUHlkZWI1WXBGdG5VaFU5ZnU0?=
 =?utf-8?B?a2lXZjRHeWZWbmd3SUwzemhRQWRHUE4wVTBoNHkvR3ZvSEdnR25zaWs4Zi9B?=
 =?utf-8?B?eFg5K0N6QzBmZ2pxcmdDRVYrekRvUFNsUEtEWVlvY0t6ZjFEUFJncm1yYkhJ?=
 =?utf-8?B?Y1dXbjZFbnJYUmpOM05sczM2TExySERJNXhYeUYrdUs5SmJyL1Q5NVJZUXhP?=
 =?utf-8?B?VE13eVhsWXZZOW9mUk81TlFYQ05Tck40WmZaTStiUU10ZGlqMGVLcHFMcjN3?=
 =?utf-8?B?b2sveUVDZTJkbjJBdE1RZEV5Z0N4dHlJYmlmZVNTWis5Z1BQdGNnSEpJMlF4?=
 =?utf-8?B?a2tkdFlHd1ArMnBsMzlCY2c2cFROYTR4V2VCY1M5QjdHTnZyY0dobzE0UFZa?=
 =?utf-8?B?c2JuUzlxWEhtNzF2cldLOU1XSlhsZGlNdXRFRDhtb3EwMmN4UDZIckFEYlc1?=
 =?utf-8?B?WTJMaDhHYW1TTGJteG0rNndmUFYwN1lIWFowdkJGcFBicnZlRWdhT3dTT2Fi?=
 =?utf-8?B?K01kd3J2WURRdnFpcEphbVJuWGI2R2ZDK0tNeTczSFRhWWp4aHpBT2pZd09i?=
 =?utf-8?B?YnhZTGZ1dUF3bWZjS29EWFg3bmV6SktENitQUnF3cDJVcGU5VGtqM241cmpX?=
 =?utf-8?B?dDh4ZWc5cXNZZEFabk85RCtzRWNIR0ZhRXBnc3JSQ3NkNHYvTjFlV2NDWkg1?=
 =?utf-8?B?VE1YeFRDZTN5a3ZyLzlpZTNGczlZMTgvbnlhQ2syVGRrcituSjdaUnB4Q0N0?=
 =?utf-8?B?Y2UycFhHa3Myanh3Vnhza05zdy9DQlRHOVF2eVU0elZpZUdwNklJL3lwV2Fu?=
 =?utf-8?B?dnE2NDUwQWZCSTB2T3Y2WXZ1WjJWRHFLWHdISWRLRVJTeXYrSE1qb3RncVRS?=
 =?utf-8?B?YThkdmgySVpuNTl5djBFNnZjL29mRU13WlFmTkZsVTVWK2hEKzRidUNJWnda?=
 =?utf-8?B?TWRWdlhiZll0U2Q5ek50Qnhibk14b2RqR1VIczZBdmNTNlZod0IxelRGUUZa?=
 =?utf-8?B?TXk3RW9BbUsrWEhBMHdLZGtmQUZuLzQ5U2RSWEF1N0t1ZnZsQTlQNWhySTlG?=
 =?utf-8?B?VDNQV253L3lRbDBadC9yVkxWZ3RSczFONFpaZU0yRHNabFoxV2FObHVLZ0hh?=
 =?utf-8?B?QjM1Y1BWY0ZBeHI2aktteG9pRWlnWTF0U3JQaEllc3Q4YnhEOU5kcFRqamdo?=
 =?utf-8?B?djVMdU40aXQ1dktKU2tLY010OXcxL09CRms0SnZUM3BPVERtTUlBd0lKNzh2?=
 =?utf-8?Q?Eq80m11ztsKK/thrWXLqsFNgKraZqzMaI6kDaYaeKV9bi?=
X-MS-Exchange-AntiSpam-MessageData-1: j73XuzPVQ+HRBw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfef1018-dec4-4b2c-158d-08dedd8744e1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:56:58.6689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOGchDGGqMAMcaaoOEw45DY0CpfA9lWvunm7+NDVnVfv4l090+gSJUXVZ+3fTY/ISKJaX+bV9+dwnuOtoQirCw==
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

The construction of the unload bundle is currently a bit convoluted and
could be done in one function instead of two.

Additionally, turn that function into a method of `Tu102`. A following
patch will turn the "use FWSEC bootloader" property into a flag of the
TU102 HAL itself, and making this a method will allow the code to access
it instead of querying `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 85 ++++++++++++++++------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index ef465b99af05..c8c7a4f45809 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -56,22 +56,6 @@ enum FwsecUnloadFirmware {
 }
 
 impl FwsecUnloadFirmware {
-    /// Loads the FWSEC SB firmware, as well as its bootloader if `chipset` requires it.
-    fn new(
-        dev: &device::Device<device::Bound>,
-        chipset: Chipset,
-        bios: &Vbios,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-    ) -> Result<Self> {
-        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb)?;
-
-        Ok(if chipset.needs_fwsec_bootloader() {
-            Self::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
-        } else {
-            Self::WithoutBl(fwsec_sb)
-        })
-    }
-
     /// Runs the FWSEC SB firmware.
     fn run(
         &self,
@@ -93,33 +77,6 @@ struct Sec2UnloadBundle {
     booter_unloader: BooterFirmware,
 }
 
-impl Sec2UnloadBundle {
-    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
-    fn build(
-        dev: &device::Device<device::Bound>,
-        chipset: Chipset,
-        bios: &Vbios,
-        gsp_falcon: &Falcon<'_, GspEngine>,
-        sec2_falcon: &Falcon<'_, Sec2>,
-    ) -> Result<KBox<dyn UnloadBundle>> {
-        KBox::new(
-            Self {
-                fwsec_sb: FwsecUnloadFirmware::new(dev, chipset, bios, gsp_falcon)?,
-                booter_unloader: BooterFirmware::new(
-                    dev,
-                    BooterKind::Unloader,
-                    chipset,
-                    FIRMWARE_VERSION,
-                    sec2_falcon,
-                )?,
-            },
-            GFP_KERNEL,
-        )
-        .map(|b| b as KBox<dyn UnloadBundle>)
-        .map_err(Into::into)
-    }
-}
-
 impl UnloadBundle for Sec2UnloadBundle {
     fn run(&self, ctx: &GspBootContext<'_>) -> Result {
         let dev = ctx.dev();
@@ -257,6 +214,42 @@ fn run_fwsec_frts(
 
 struct Tu102;
 
+impl Tu102 {
+    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
+    fn build_unload_bundle(
+        &self,
+        dev: &device::Device<device::Bound>,
+        chipset: Chipset,
+        bios: &Vbios,
+        gsp_falcon: &Falcon<'_, GspEngine>,
+        sec2_falcon: &Falcon<'_, Sec2>,
+    ) -> Result<crate::gsp::UnloadBundle> {
+        // Load the FWSEC SB firmware, as well as its bootloader if required.
+        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb)?;
+        let fwsec_sb = if chipset.needs_fwsec_bootloader() {
+            FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
+        } else {
+            FwsecUnloadFirmware::WithoutBl(fwsec_sb)
+        };
+
+        KBox::new(
+            Sec2UnloadBundle {
+                fwsec_sb,
+                booter_unloader: BooterFirmware::new(
+                    dev,
+                    BooterKind::Unloader,
+                    chipset,
+                    FIRMWARE_VERSION,
+                    sec2_falcon,
+                )?,
+            },
+            GFP_KERNEL,
+        )
+        .map(|b| crate::gsp::UnloadBundle(b))
+        .map_err(Into::into)
+    }
+}
+
 impl GspHal for Tu102 {
     fn boot(
         &self,
@@ -277,10 +270,10 @@ fn boot(
         //
         // If the unload bundle creation fails, the GPU will need to be reset before the driver can
         // be probed again.
-        let unload_bundle = Sec2UnloadBundle::build(dev, chipset, &bios, gsp_falcon, sec2_falcon)
+        let unload_bundle = self
+            .build_unload_bundle(dev, chipset, &bios, gsp_falcon, sec2_falcon)
             .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e))
-            .ok()
-            .map(crate::gsp::UnloadBundle);
+            .ok();
 
         // Run the unload bundle to try and recover the GSP if an error occurs.
         let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {

-- 
2.55.0

