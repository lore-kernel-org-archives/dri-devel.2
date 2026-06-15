Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66413CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51B110E4B8;
	Mon, 15 Jun 2026 14:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="L8FjoZy9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39F110E4C2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4TnMOblsykUkK1EeSEVTmrubUi7N/CQMwR87Ckh251DnnvRr1TJCr81qOp2ryg7ca1Dj84XnMUHu5vDXTlfJuUeFeOVjW4G3JnB2dl6M8lTI3JTcBpocaFs4Scoy3Sm3mf3Niq8hNOB6+b+U3Pmzq2okl5G8Qy37LceA3TCSbpBEf85PKKO+0v8bnRIab5dzT+Aw3oEvoVFFcSTvJWlFNdg1Xy96xNkOswT8O1Z7+NGYJtqj+TVaiWarJJgsVsdwIaqhqHfo8oXo6jtzp2NXa/QOLe1NlsdWp74RJcOvxDJHIgx03PFXmOOXJtWc243t3nskkjBag9r1d5ApPUYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEx6B+8g2e/E9AtnPwrse5AjZ78Sm3X5V1NFdLkPTKA=;
 b=SPlBLCOIRuFwImDphPvcJDKtZp7mb06fVyvJMG/NocekdnqCa7OPaTbpfFcK1srqovVVRIv2LzmLIn3JDH4tKp3o12mUllJbT3TqRIxWXw2ovrc08acsPxg4DO4WBaYAZdfVkeUd7jrD9pTLYv6OFyBYiq8lsfnnYTZlCJLJ/v0VxYZ833FCWDWR2Ezy5F0lhc8cX2e7jXul7/Z3J5pieDLBjj9AppNe8O1mlujHHMBD+y5NEtlBLtCOUMUOfjbyHzKba5gtIg58ystouTvKy1REnFPYiTxBlvrEtCWdLVIYxQWCgq+gQTE2vDoeZU6N9lcEqJBtHwB+xYJU4UhcJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEx6B+8g2e/E9AtnPwrse5AjZ78Sm3X5V1NFdLkPTKA=;
 b=L8FjoZy93bXnYwz+jA/k/eMzzSdNLqm4K4i7qYRCCSqyPxvwbvDkhy/yE0piwTnJ8FBtWSyluGD6pc++buKGopxqxbdgJgnX/dIjnod2YAKswmmyoPGmU33EbkKq3zQnUfx+kWpkzWtKa+ThnNTshzgQAzz6zUCia3YFBQtRlbhlmGfQ9XDnYlRzj413oQuSVVHD+ORCGeJXYl0YPxy2gNwfJH25am9OjB1SOMs0ypwrtRpECJEIqhfo+79qYjQFNVNigGA8Tukbvcpb9AeEyArEQI5arLNKWStbxB6RvDAADFGpGaPjHDEmVNmkl8UUY3mXegOwLS40m9dstnfzmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 15 Jun
 2026 14:41:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:41:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:46 +0900
Subject: [PATCH 06/13] gpu: nova-core: fsp: move FMC firmware loading into
 wait_secure_boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-6-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DB8PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:10:110::28) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b62852-0fb9-410b-1396-08decaec3ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: s8ShKDLAgCz/BbPzeqvVVEvMS9+xWnkrpoqPSYlkNoQnKNCSPf7IboMVuCV7ObtCvMhiMjT8xOnZ1y2ohNZ8uyIfZxPiA5unjCdaS0hIovR6STKQBY3rkZ/m0bTFlfj6/L29KeOzAbZ736NyFvLCcHpLEnjWFSBwR+9zG++i1jqRag7zQNWh6RVcF75KdMOYQR4j1YosII1bs9j64GfrXmYLjjYOlFliVWzSwBBajNxmNsts26diu8wuFVbukZvGUXwtziVVibquRrDjCvtfXOTGXFAvQ154oaziP9wLa5z+JVgAELeXl4JHyOMZCTw43UIbNK5LTgr3rM3zTE/3sr3NHGY5mMyg3HRuJ+XQbzVUoGzP8T/y5NPGuzKFriqH5P6aNQwYM7HTLOq5n7r+rbOJRLA9LdK9dmQFcC9VAAt8dLkIsgs0hd/o8S1vfGrIDsJ+z/vFWbp7/gmzwNQfVgAVGsK+9hzDphIsLbpgpeGDIazlp1DiDiRbyWHttj8Kn5ua8uwNvs+5ZBZf5smpfVuhn/oiXdF2Ma5CUuyLRW4PcWdBjOmc/AmUlQ9vH/paaDYRIrunqGI68gvPCqc0nAEqsbFDuiXOsejhZW9APBkHmlMHU20Ww+8ytb1u1JrqIFWGHlGckG02fLbYqFvgPPKK0YYpiLAO2JOWP6NdaFC08sYsgmwvi4Q8mJVK1sgw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjJDc1RZc3ppM1MvSngyYnF3d0lpdXF1eHNLWEQyZjJTZFJQTkJHWitQQ3hX?=
 =?utf-8?B?ZlpQakRFdEVTdUFpYmI4QnEwMUVLb0c0ZDNLOUNoa0pKMlVPMWdoZnFpYnFt?=
 =?utf-8?B?MTQwSGhHbTg0STlxUXJ5QVRwTVk2VUZpbnNwTGN4RGhCSCt2NnNIZi8wYUt5?=
 =?utf-8?B?NW9TeGVzNGcxT25Tem1pMGdaMUpIbjZ2RHZXanIrTTlsSEVwcjZ6ak9sVEZv?=
 =?utf-8?B?a3lqaUFFRjNuSmk3S2w3MHpST2UwS2U4MzNMbEJ0VzltYVA1bW96MzZGNWdX?=
 =?utf-8?B?MS9CRDd5OU1QdlBiRGU3SDNwMnRSUGE4a2tZNnFpNFphcDF0TlhEVHJDSjZI?=
 =?utf-8?B?cXY3Y3NteFhWN1FTTlpuRFJzOUNmK1BCdTNuVVFPSkk4VkxPRk9vMjBicUt6?=
 =?utf-8?B?MTg4aEQzWHBudnNlV0lwU0c1N0FIUUIydzdWY0JvQTZqVDN5ODRKMVN6ZGE0?=
 =?utf-8?B?TmRud2JIQXpOaUFvRURmWUtCMW84T3cvT0phVFRVbGsrVDhDSVZCbjJyNmlC?=
 =?utf-8?B?TVA4UzF0ZlU5Qk5VWnBac1RvVGJHWCsxQ0dKSktqUDFpMExpMkNWMXlFMnJS?=
 =?utf-8?B?VVlzSWp5MzZhR0d6ajBOWkQzenE2NUQrM0VMQnhibkFYVzFBakM3M1lDcmNx?=
 =?utf-8?B?TFBiSWlwM0xvSzM0SzV2TWpJOEpVYkdaVENkZGRGUXhpUUNJMTNDUzNQMmdy?=
 =?utf-8?B?ZFpZeWlyQlIrUnV3R1pSTmtDTlJncTZMNmZOVHc1ZTZnMVFzQVJ6YkROZmFZ?=
 =?utf-8?B?aEowRktTVkNadzN4N0FIdFV4WS94b29PM3lQT2dMdnVtSURPN0dSMERNeHNO?=
 =?utf-8?B?TGErTUpna2l2azB3N0R0OWN3UHF1U1d2dGQ5bE5YSnFBRWVQRER0dG8zb3Vl?=
 =?utf-8?B?L2cvc3FTYk41NzIxZHFGM2hMNERrR3pzaFEzYmowSTFQR0F1YXl6b1NCUENt?=
 =?utf-8?B?ZDBjOE83U1FOR3JEdFk3cDZwQXhrazhxNmdic2FTdHVQWmVMSlVsL2cxN05x?=
 =?utf-8?B?dWk3N0NuR0dzdmdtMjY3b0R2RFRxa2dUdjN5VHMrMkVZTHJHdmh4czVudndE?=
 =?utf-8?B?c3J2MlZtT1BhYUk5K1VvZWJWekF5K29pREs4d0p1aWpUeXUyc24yMTl4NDQ5?=
 =?utf-8?B?WnVHeS9SMjVOY0NRa0VaKzg5Q2MwWW9pMzU1MjZLRERUeHpuc3ZvZmpoTVVZ?=
 =?utf-8?B?RU1xRmpaek5QRXRGTndyeFlQUmJPVDdmcmZJYXlKNGQxcnRQNWxhcDhDS3pu?=
 =?utf-8?B?TkxTVTl5K3NxeDRDeWZlK3d0ZXBnYk9HWGVWb2Z5TGhoemhPaHk0cFdDUHJF?=
 =?utf-8?B?MnBsR0prMjBuUENzZHBadlNFNFBSS2Zsb3dkcnNUVHQ4djJzL2hFKzdiQVNw?=
 =?utf-8?B?bDJBdUtRdi9rQ29way9XdDlvcVlBR3dyTmJTVW96cUNGWXNZK001ekFOcXQ5?=
 =?utf-8?B?dkl4MlhoSFdCdlQ2OEhDa2ExV2hlZEhuejM4YkgrdXgzNVpWSjArZ0JrY3Yw?=
 =?utf-8?B?UEl3b0hnSFYyeUdsd0lqd0F5Y0xFODhTdGlsRngyK1ZweDZtY1U4dU9qY0RM?=
 =?utf-8?B?aVFEZmd1K3RVeEpneThMQ2ViTU5CdXJOdmRMWCtmbkovRnhnekIvMUN1aFRG?=
 =?utf-8?B?UjI2LysxTkQwbjFhcVBTdDBNQ0UyWDhwY3ZVY2pkNnRmYVZkS1ZiS0FWV0Ez?=
 =?utf-8?B?ZG4wNGpVZFJuRDFBMll0YWMyenplZmVqRmFwVlZmbEs5Wmc2c2lISVRkUmgr?=
 =?utf-8?B?U1dEWUxNY215OFFxU0VmUkQ1YmpKcWhaNkVzN3hkWGZpY1pVWVdveDVWbnp4?=
 =?utf-8?B?RGRTd056Ni9aK1I5VXU4ZmsrOFh0dG4rRWRTL2kyeCtkNFpWaG1Kb3hiN0RU?=
 =?utf-8?B?UXRtZTJLdGJ4RXVNVnJ6OVF4SWpUWWYzNDJrTVduU1RSbVBUSWNaUjI2aUdl?=
 =?utf-8?B?UHY1YmJhUGJ3d2NMTDdTRWQ4UWVUTmVPOUNkSGpKeHVOeW1USWtxZGZ3czV1?=
 =?utf-8?B?SzBUaDVaakQ5UlE0TGVWbm1WYnRZQUg5Rll1Z05NaEcrMlRSVmErRFBRQXp3?=
 =?utf-8?B?YkZpUllVcFByTWFqMHk2a00yZDdEaDB4NndHeWRnT1k4UitlaVlCRmcvSXA5?=
 =?utf-8?B?d05YaWJaenhZa0NabDE2SVVXM3crQk1jMWloWmltdVIwanZtQVhvWnNQTGpi?=
 =?utf-8?B?dGVvNUxJeHY3bmhHN2x0SXUxakJXQ25kU0pwS3VFT0Jsa0dvYlJSVGJvV2ox?=
 =?utf-8?B?MUxUcEh2UVJjRWYxWkZPSlhGbnRKd2NmcVc4S0lqTGJZSVFlS3ZWL21hMkN4?=
 =?utf-8?B?VTRDNEZQRzNLRDdOYWE2ZVJraDZ0K1pRVlZzS25qbUJnRDNOUEpaWUErTldj?=
 =?utf-8?Q?CXx8yijTAyt8eA+/4RXzMWljXLH9scPOQGsN3hKEC/Fhx?=
X-MS-Exchange-AntiSpam-MessageData-1: bSTOJI201PzoVA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b62852-0fb9-410b-1396-08decaec3ef4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:41:55.2537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+YzwNibdn2OgcbyFlMeE0CLsZZrNOZl8PbPIlz7TE5i3Rj8J0ww4RTy2j4/7M6i8YG2jhw6h26dtJeSuQ87Fw==
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

`FspFirmware` is constructed and immediately passed into `Fsp`. It makes
sense for `Fsp` to ask to load its firmware, so move it there.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs           | 11 +++++++----
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  8 +-------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index d949c03dd304..4b97d1fb505e 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -31,9 +31,12 @@
         Falcon, //
     },
     fb::FbLayout,
-    firmware::fsp::{
-        FmcSignatures,
-        FspFirmware, //
+    firmware::{
+        fsp::{
+            FmcSignatures,
+            FspFirmware, //
+        },
+        FIRMWARE_VERSION, //
     },
     gpu::Chipset,
     gsp::GspFmcBootParams,
@@ -236,13 +239,13 @@ pub(crate) fn wait_secure_boot(
         dev: &device::Device<device::Bound>,
         bar: Bar0<'_>,
         chipset: Chipset,
-        fsp_fw: FspFirmware,
     ) -> Result<Fsp> {
         /// FSP secure boot completion timeout in milliseconds.
         const FSP_SECURE_BOOT_TIMEOUT_MS: i64 = 5000;
 
         let hal = hal::fsp_hal(chipset).ok_or(ENOTSUPP)?;
         let falcon = Falcon::<FspEngine>::new(dev, chipset)?;
+        let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
         read_poll_timeout(
             || Ok(hal.fsp_boot_status(bar)),
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index b08761af89d3..3e499563c9bc 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -18,10 +18,6 @@
         Falcon, //
     },
     fb::FbLayout,
-    firmware::{
-        fsp::FspFirmware,
-        FIRMWARE_VERSION, //
-    },
     fsp::{
         FmcBootArgs,
         Fsp, //
@@ -160,8 +156,6 @@ fn boot<'a>(
         gsp_falcon: &'a Falcon<GspEngine>,
         sec2_falcon: &'a Falcon<Sec2>,
     ) -> Result<BootUnloadGuard<'a>> {
-        let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
-
         let args = FmcBootArgs::new(
             dev,
             chipset,
@@ -170,7 +164,7 @@ fn boot<'a>(
             false,
         )?;
 
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw)?;
+        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>

-- 
2.54.0

