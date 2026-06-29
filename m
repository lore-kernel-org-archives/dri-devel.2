Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142B4C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F2410E899;
	Mon, 29 Jun 2026 12:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AxzBu+xL";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0011110E896
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=It5nzpyFq8otH7jf3BEOMlcAbXm5KigtMU13P3zcMYJMbvwbGVJkfvTX4sYwNn+gHGzGOZZOXe1zoRrD4CENoXX8AeBWs+8ROA80oYztEdjEVjn2+ZERSh7BZAT/uxqB1XT/eamwCFFNRre/fNFSLJ6ZIrXBTs7Hdi85x6dzAOASlS1KWPaaQLfwVSBgzyoAyFa4Ok8a3R854A0IFrOTjozvaAtCfs5zqVAk6Ximse7ob0lifXhkFZIhAH6lTrJWd3aFbSlEPYcQS0h1VQ46GjoFbC9+uflx1+UFJ4lhacofcatQ5Rv9+bJ06kd3cKjhEmqi+0DvyrdzFf9ltNAZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rDfO/8OsTfUXmFa4QGyreI+SWDcdgMHeaz9khwpJrw=;
 b=n6X8frGt8fAVup9hpZTdiavBUPxW6XTM33240O+RhP3nvwUzWQKIcLcUSW80/ry6O8fIPesA+BmU9NDF9G9pYPFxbXDr/kiWAOxrt5sWET0d+aeKejkcuvCDrLZwKya0AvTvYYu4JwSo7CA3WyhoRIunw2+9bzSBhyHWQD6iDyNDDC+qfhUY4pgMmu+YqwJjyXihWXumahkE+Il4AglVtk+h8YHtYpVgLnvmDiU0Hwb2eKa/dk4XImzEsNg5qdrf4MkNV74OhCXa+R7gjYifZCrQKTnZiEAnZStnpMzisx6XzKKoPvNUI7PZIlaSVZMDARf5MoJr9mK+KG0FUE8O3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rDfO/8OsTfUXmFa4QGyreI+SWDcdgMHeaz9khwpJrw=;
 b=AxzBu+xLCRf/y5S9ALsqzAK0emE5PwFmAaRgEyL6xjIy2MNqx6QnRB7UwbpS8ei98HN5K9xPaiSOamW3oljO/JWbS9jeA0ag5Xp+3eqwFYqroCl+iaIggnNdPzO5c6qichWTdBEWNYKx2lvivtrOqMKqnZ9v+LHKvNp9mZIT/0TkAFCP7Z+/J+x2KZiWlSfUDgmFwDsq9LGXnabR4FNgbIWWWPBoSvWJl6dhBvcc0XCa7iBBLHOiy+NYsaDY68Rn/KUx3MJWvoRFrNxx7fYvnjn6ABAFqafY9Tlog+R4Hi16k/8wBZAfI1Ns0Pjv99lkchDo/Xk8LD1Ur3Ds6msCzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:32:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:18 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:49 +0900
Subject: [PATCH v3 06/12] gpu: nova-core: gsp: fold TU102 unload bundle
 construction into HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-6-26cb29ee8dee@nvidia.com>
References: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0273.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c050561-acd8-4ee3-7671-08ded5da7561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|22082099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: 3noz3xBFBmXAfh0gcd8CoNKdB2KpzePzscNkY2vFUVh2dRn9QnSCA3VxhCkAHzfdIP3Epi1XHBXPHTZa6d4udqgMSzYqft4KSWbNhL2X7sV9qGB1+hs+k6DNaalihm49EXqn5krDJVAIY+FHyc+10SP186PiqdOIH0HYg2rUgNhGrMK6eSbHmKLBNr+6f2sAyPLQFU7OgKh3idcKLlvhyOEkqRhRa4Mcc61B4mWhst5WCG9EU8HIl6Xs5UlmqJhu+7p5FNW7VrxEzgEFFoHZiJNmWZtizJKSNUWUbr6SBhYeSMeUH5Y99b2iYaVNaaSVonlUXUAMp0jnm86LfZ2kOHrG/5I9F1cwt00D+ucrjOpw6AwmCNR7GwDMVTYllrbl68B4U68GLV138Vy3dXV12VEEewYLpEpFGgioTML0mspraEFJDjQ3z+PFXhsTgcGM2i+F+oLJ/XMcSkAjF11uqEQMGWdU/BAGk5GQesVcagijm41ga8avyfy8Nb0msmMU24MAKjBBeb1plzHIvaiyoFoWB7G6ouMExS2KGdlCAoSVthH4z0DPNKhqGjWhLFgG4WiQONiSZsV+iVi9fpRi+euTEldsZlwSv5ibTKVdnbcJwWISidgRuCHXQBUxeX+i+KjiRWcDV+nmYecKN9bDOgzARKRUyV1bt/O0eCf/XcsKwKxu3Cib3r/yvfPH/1/C3gsKJnguJP+04R/f+1csRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(22082099003)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnp3NXQ5WWIrd2tJOHdlSS85UnNDRklWY1YwQVkyUlFjVzlyZ0VVLzVEQzNm?=
 =?utf-8?B?QXBUcnpaa0JVRThpeEcvZVNHZDJVaHQwTkNGeU1LYVlDTXFBNTI5MEFDYXU4?=
 =?utf-8?B?T0N1N1pIeVZ5ajJqcEZscUNsYkdUaUpoeVd2U1lsVlhqRnkzNlB4WE5DcW94?=
 =?utf-8?B?UkxIbHUvdWxkVWVMTzVEeUpMVU9wejFkMEdYcmhyRkhXZkxaWWM5dE40OWlJ?=
 =?utf-8?B?OG9DS1g0NllGck91UmhYOGhTZWhIWkI2N0s4dFZkcEo5V1VnK2VrR3BtdGJ3?=
 =?utf-8?B?cE1nY2d5V0t3Y3A3Q2h4eCtDTEJXU1JHWk1uT3FSekk1czJ6eEFUamo2ZnQx?=
 =?utf-8?B?SzVVNVo0MlRBV09Mc2NwY1o0WGtaV00xaTM5Ni9NaytrcU9CRlNUcEdwUGtn?=
 =?utf-8?B?TlgvaDR3Sldwa080Y3NzYmlyZW1nVm9rQmNzc3IxYUUwdFA5Nlg2Q0h4dFlr?=
 =?utf-8?B?QW9uc3FPYzh1SVNwMUNZdms1VTR2NENTYy9HYTA3ZXJvWXI4S1VBdlY5Rktl?=
 =?utf-8?B?aTQ5akJQMkZSVVI2emYwbmpZU1RDckw3VXhzbVpLU2dsNjdDc01pNldDYnRm?=
 =?utf-8?B?WlhRaXJHYkVJNlI0dVJMaVovTUdXM25VbFdnVnp2OXAyZjFhY2M3RGJEaW5h?=
 =?utf-8?B?dktnd21oTndDUmhUdWNXb1dZZ2E5V0tKeDk5TmM0QXY4bC82ZEZVU29FYVk4?=
 =?utf-8?B?SUhFVEg0V2gwT0ZUclZDV0pGOEpPVkdsRnNXNmFQcm9ieW00N1RtWmNIc3VY?=
 =?utf-8?B?dmFndkZqYWd0Uk9OUHhGMGJUUDA2eUNsL1RKZ0FXLy84U2pjNmt6QktPNndX?=
 =?utf-8?B?aERvcHcwa05Kc0FDRnhmSSt0V0JEdUVUeDZZWGliQ2hzaEg4dlR5QzA0U0tm?=
 =?utf-8?B?MTE1a0NuM3lPTndLeHM3WXNxT2hJaXprVDlIWnRMcmFWYktvNGJvZlB6RHN6?=
 =?utf-8?B?MmNiK1BjclE0dTFlMmREaFdxQWpvMHZGUFVld2lXZExRNEt0TnVOWmtaTXoz?=
 =?utf-8?B?dktHQVhsMG1sTzJLeXB6YWZzZXVxZTVmNElrSEs5WmNCVkV0UzFnWWFQRkl1?=
 =?utf-8?B?K0NSN2Q5SlBPMUpVcWNzYlA1WDlndzZUakMvK014SDBua0pFUFAySE1wbWNp?=
 =?utf-8?B?aVR1YWpDclpNdWYrZWszTmJHR2dvTUNTTzBseld4cVRlcFBLcUwrR1ViL0pP?=
 =?utf-8?B?Vm9DcWVndm5lV2pNMU1KZ2hSUUR5T0NkUXhqei82M0ZDdU5TUUt1U0tlSWNC?=
 =?utf-8?B?d2FBQ3hxUXJnQ1psTTZsSFovdDVHU2ROVmR3Nzg0akx6Wi9LV3NISlVYc1U3?=
 =?utf-8?B?cDBUNWxLQkxuL3pFTlkzSXZoTVZycUd3MmdiTlRCdmprTTJiSDVNOUkwcitZ?=
 =?utf-8?B?Zjl2L3Boakx1QnJoeU01MmJVWll5Wjc4WUVaQUhlV1pEcW9WMG1EejBaVUdn?=
 =?utf-8?B?WHVqcVNkbmFWK3ZvajEwRytzL2gzVmFJSTd5MloyR1hJZmJROG1odlRmTHMy?=
 =?utf-8?B?TU9iSHFGR21wRFZsam5uZEpPOXB4eVYrdmtlZ1hhTUFIY1VINGU4TzVkRmlK?=
 =?utf-8?B?MnQvcWV3RE1WU1V4OTNzM1pPQzdMck1yZ2dYcEp4akQ0ZCtCdm1tdkpWYXEy?=
 =?utf-8?B?ekp6SkVHalVUT0M1MUpTMEQrNzJGWWVqZ3poWWkzV0lhaEU5ejBBRGZrcXVL?=
 =?utf-8?B?VzVmZ2VzNUFldkhxR2ZrUHZTaG45ZEJ2UGRhOUpGYmxmVzNiKzcxRGZvdk5U?=
 =?utf-8?B?OTJYM3BQaTdRcnFjeDFLajgvQ2tZcE9nN2lPQmVEYTBHcUJGZ1U4YkxkaHdX?=
 =?utf-8?B?Tll3V2NDMXFmckhKRk9RVVBUVG1RcjVoU0pUaFdYKzlQc24yQVc1OFVGUkt2?=
 =?utf-8?B?cXBqSUFUZmRDcXo2Yyt0TTl2eXZZelYxTFNNbktDbUN2dkwrUlFhNThyclhz?=
 =?utf-8?B?VGFqSFU2NjNPQnlsMGo3dEhOWXhXMEpNcDM1WDZkWkZYRkJtZE9BamVEalJI?=
 =?utf-8?B?WFljckdVLzFCUWxxU2RIM2dLQVBYUXF3eEpaUHpTOHpzcTdFazBsOW0vbXph?=
 =?utf-8?B?UUNJVWVZcUFLUGRndmtkU2o3WjFlczc4dlF1Y1o3MTVoSDBob2J6ODdUdS80?=
 =?utf-8?B?WXhJRGRFdGNISEdqWFhzQzlRYVA5OGcvdEdTa0tuRXpId0x0L1VKOGkvY3Zw?=
 =?utf-8?B?ZG95am1NM0tDQklSaVhPbENvbi9XRVhuRkcvSmRQbGRKNFZObWVNQlgrSmhj?=
 =?utf-8?B?ai9MUEdCcFRpMHR1RU9HdGZoS0hFam5lcG5jYlpMYVd0b2IyaGtXQjE1Y1VJ?=
 =?utf-8?B?Mmpvb2F1enpZQTUxdmtpL3JXSEpva3VVL2Y5eC8yNjVXaWNLcCtBcFl3UWtR?=
 =?utf-8?Q?NFP6eWvu2fskqVSYX0jBnN/OLW/71UGqwKbLXVfso5F2c?=
X-MS-Exchange-AntiSpam-MessageData-1: aeOh4+4Q2qH7jQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c050561-acd8-4ee3-7671-08ded5da7561
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:18.3223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOblAiH0Wpj809VMkpPpVko30OjHze8vwTNmjjQh/4OkFKMKSVdvaiIUdTlkmIpdfG5tkNpdXMc41BcLfsKCHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 96 ++++++++++++++++------------------
 1 file changed, 45 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index d669ce7625a8..22b4927cbaa6 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -56,23 +56,6 @@ enum FwsecUnloadFirmware {
 }
 
 impl FwsecUnloadFirmware {
-    /// Loads the FWSEC SB firmware, as well as its bootloader if `chipset` requires it.
-    fn new(
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        chipset: Chipset,
-        bios: &Vbios,
-        gsp_falcon: &Falcon<GspEngine>,
-    ) -> Result<Self> {
-        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, bios, FwsecCommand::Sb)?;
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
@@ -94,35 +77,6 @@ struct Sec2UnloadBundle {
     booter_unloader: BooterFirmware,
 }
 
-impl Sec2UnloadBundle {
-    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
-    fn build(
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        chipset: Chipset,
-        bios: &Vbios,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
-    ) -> Result<KBox<dyn UnloadBundle>> {
-        KBox::new(
-            Self {
-                fwsec_sb: FwsecUnloadFirmware::new(dev, bar, chipset, bios, gsp_falcon)?,
-                booter_unloader: BooterFirmware::new(
-                    dev,
-                    BooterKind::Unloader,
-                    chipset,
-                    FIRMWARE_VERSION,
-                    sec2_falcon,
-                    bar,
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
@@ -261,6 +215,47 @@ fn run_fwsec_frts(
 
 struct Tu102;
 
+impl Tu102 {
+    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
+    fn build_unload_bundle(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: Bar0<'_>,
+        chipset: Chipset,
+        bios: &Vbios,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result<crate::gsp::UnloadBundle> {
+        // Load the FWSEC SB firmware, as well as its bootloader if required.
+        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, bios, FwsecCommand::Sb).and_then(
+            |fwsec_sb| {
+                Ok(if chipset.needs_fwsec_bootloader() {
+                    FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
+                } else {
+                    FwsecUnloadFirmware::WithoutBl(fwsec_sb)
+                })
+            },
+        )?;
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
+                    bar,
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
@@ -281,11 +276,10 @@ fn boot(
         //
         // If the unload bundle creation fails, the GPU will need to be reset before the driver can
         // be probed again.
-        let unload_bundle =
-            Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
-                .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e))
-                .ok()
-                .map(crate::gsp::UnloadBundle);
+        let unload_bundle = self
+            .build_unload_bundle(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
+            .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e))
+            .ok();
 
         // Run the unload bundle to try and recover the GSP if an error occurs.
         let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {

-- 
2.54.0

