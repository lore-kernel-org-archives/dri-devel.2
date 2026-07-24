Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62144C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC16A10F2D9;
	Fri, 24 Jul 2026 06:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGiAD7rD";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C318410F2D9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPsdUTQl6TQS3R88wBlsAg5o4XIh1krTkW+hmONN/ZD1Ug0gw9N4J3tJG1QH9l0/qC++N+Fp/W6dSd6fUKW8vu3MDUDW1oRawevAwYEEfeK7JZZdqzahf1awrFvilTdNCaox/+qlt6acXFp1DYobtP7BRIK37eV22UapMryFtRJf5hXywz8NTA+zI4bDFtLPHtrq/KblmVaxM0V3VJ9+hixNGySuN7XZ+zRIMw8cb5eJcEytPtXO1JXLOy5LPTld4609V5iS4LBo3go1uuXEEZ4tYkfPaZ+BkPFMsdNhdYqB1I6M6j8WMkYjMKh/pHspt/HEwmQR79/k7L3jF+MfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC3DkmnfTPd83IgAYUAaW8UU7lVVABr2uYfbEPghTPs=;
 b=dnKjgChW3eQzmrgmlaoFBeSWhea9ejmSbkAqgeqtmzYN0GXXXkgBtTfOmOw5szSDWwxOPQfNb/aTp2KW1eyeSbId9aucIvrUVduZxoZryF1DprBjiuCRaEI0ZLopsqLEkY40qjWcetl9Oq0Y7K9nLlaiF/DDvqYTrbtp+Dtl/oGh5h2rz9pyD/HMuCs04L6w+LMW7oak5cFV+SdgWK2WFKX5/8TdZeU1X67HlUul1RjXK0l7BiboRJKwhQ0B3Bp9PeTA4N4+hmnEroMCyV12FnoX5Zhx1CaBJRcbzxOB42lVeegGKywyNuZYv8xlKArkP5/+MFIxwku1OVGl6gYeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC3DkmnfTPd83IgAYUAaW8UU7lVVABr2uYfbEPghTPs=;
 b=uGiAD7rD8hUgsav1xuc2GE1asQYqmqnMkseU4DTtjf2JdSw4b7/Zx/cLtM/R35XuMcF45QKW/T4zC0sDE1CuoGJtItVQNwfYVKhxGlYA61mAh1Zbp0bdQOy+JSOZPvTEtdzxDtXdmz32hsCm3BPwib6CA2TXqLlIrTjokpVukvz2qfhLD2KwW2h+Ei+CAhFeCLgqswfk4T/gGf84u9enlsTOaJjlnF+2UAXRykZmhcrg8DMH09U2kcIzQ08M62GbXJnXwB3f4Hzj/ufAhmkRAc09BSgj8abBmiJTJRlUgrzsSFFqaglzGbsO28LCenxQECQ7/yqA86NQsav0EdoCMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 06:56:54 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 06:56:54 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 24 Jul 2026 15:56:27 +0900
Subject: [PATCH v3 5/5] gpu: nova-core: pass WPR metadata ownership to
 FmcBootArgs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-blackwell-fixes-v3-5-01aa6a54e3fd@nvidia.com>
References: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
In-Reply-To: <20260724-blackwell-fixes-v3-0-01aa6a54e3fd@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf49efc-204f-4bbc-8250-08dee950bf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Xm0AfNQ8FT6Q61U2Q4sFgQEARV4qCetd8G0HYMWEL8xqmBXCJI+trZgat7SI/NtceDjS8GKFMfKFGGVhU/Tt6WcelgObyM/rF9+kxlDQiWB1ykp+0/K117aYwXFCwToC9Hm4aFmlliLjBhGdbaZlsY3NOfMd8/UL8+6pQeNpZ9dgS5Ml6TXAIAi/11Oa2n/W+8UqIGKoHF/gE7Y5QihHyXbDljQfx3cVHkN0vTIcgSN1G8ZGoklic7+xK5GGi9pHyblKha2zGVDW3B12mNSx2VzG31IvBDOGMQ9YFeubBDRgOmDZ54eYm2pYfQ8b8jqcd/kxJCNpOtP+vZ11bW2Rr1SDidIbqBXcfKo5sObzqJ3cc3kJphZUIg65R/9Oih/OwYq9L41NNvTQzO20rS9ovZIylqx037Nm76nNks1b7+qYRuUVgi6aOKaGwrPCWgjrydxEupswDA2SOa4gjpp6XYPNewI5cLtPMAP11hwnO7NAwVEOA/LcMk/uiXkA02lRZnufLSuCZ4uF+S8xsDvghe1jlB4C1sEtwe6OkAmIhmJp5DP3A5j70XznUiIDm1xD+6lY932FoPN+QS/4yGFrAMQjAbQuE3DP8w+tUP3r3t6Gq8w2JIvwEcH4Ka15bO2nb4JxvpEJkeum2DbMD9+kLeARwcWGwYWMjExAuNKQ2k0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXlOWDY3VkNSU1NXcTZ5TzdjWDY4MUhJMWo2L213ZVdBdFk3QlhYYkJCODFQ?=
 =?utf-8?B?QVZ4dGpBVStHVkNFNUVaT1BSMEt3bkZ3MTNEbHRaS1lmRG1FMlI3dmpjSVBq?=
 =?utf-8?B?eHNkVmJSa1EzSHBXUVE4YzMyeldYa0dROE9oaVFnZzNUeU1CWTNMVkozZ1py?=
 =?utf-8?B?UkQ2RzZjQmtlWXJTWDVvVFpCTTJ6cTVFOFpCNmJhRnhPRmZBV1ROeERod1du?=
 =?utf-8?B?djdBSE1sNWdxVnNZVXA0aWlEQUlNRVhPR2ZIWTZudm1vWW1Jck80UHAzZkJX?=
 =?utf-8?B?d1NvK25SVWRXdGJQcWZGd01SU2U2OCs3QVFEVGU4QXVpNVpXVTA2QnpqSHcw?=
 =?utf-8?B?T1hCaitNYXU2T2ZuUmFLMlRDN2JhQnBPYlJVdnhTSmRVTmZNbmlDVzBwbzBH?=
 =?utf-8?B?VGowT1VDUkRXZDFDejNLS3NyWTE2S2ZmakxOcisxMWZSdVpkRUR2WVgrVHZn?=
 =?utf-8?B?MnBJMUoyZWoyWGFER3lzWXBKN0hpN0FBT3pIVFpIZGNzS1NXZ2lORXZJZUFC?=
 =?utf-8?B?RWs1QWdmUjZpN05FNVprSUJlZmE4Vm9SWE03MzRiVlZQdk42aWpUUk0rQ0Vr?=
 =?utf-8?B?U3A1WStJWkNPSFYya1B2SkpLcXBJNUk1cGhDaGRLSnpmWXpqdEtyRHo2ZjZv?=
 =?utf-8?B?S1N0MEVLZkJLa3UvOTdaMUIwVFVOd3BITmRXRnFpQTBkLy9UbmhmS05EOVVp?=
 =?utf-8?B?N0NzeURlanhWMTBFa1pteThOb1ErbXFjd3Q1SWF6eisvcStEV1JpbTFrYTh0?=
 =?utf-8?B?THcySGpaekpDRXg0OVp3SUdrZWJWbDJuT2xWSEhWZ3R6RDFiTks5VkRqVkJX?=
 =?utf-8?B?SWRuWG1taUp3WE1YUlovbFp6djRxUTZSTkY3V0ZFZk5ET20vZWkxNElWZ25i?=
 =?utf-8?B?Mnd1RjcwT2RQNmVCQ2hGclI1ZGZaSGl3eHgzRFJRS001UlpSUVhvVXRVVFZk?=
 =?utf-8?B?MjJzOWM2WHcxeHdCcHBmdURzT3ZhUE5qWjhtN090QTZCb0IxNGl6VmN4bkJo?=
 =?utf-8?B?dnMyTW1CWmVSYUM1QzlxZWNyUFRPN0tqM2tLRzdsTXR1elBwK3JDRzhWUWhH?=
 =?utf-8?B?Uk1DbW9Da3VaNGtKZHhKSC9iTTdYUXRHeEFreUxZL2s1UE1OVGJIaTRqblpB?=
 =?utf-8?B?WGdBQ3pSNERtUm1OcDVtMGI4YkVCUWptY0t1SEI1U3NUL1NHQVkwR0pMeEpt?=
 =?utf-8?B?TTZGQW51SXViT201QVhTRE5aeHZmdUdFaWdodWNxMHBiRnVubWp3eGlWWXlY?=
 =?utf-8?B?a2FXaUV1cmsrS3Ayd3FrdnRVODMwSGpsbExJeG9GSmJuNnlKeWZEdk1SYXJ4?=
 =?utf-8?B?NWx0NjI4VFl5eWRqQ2hjemVtZGJuanB5TlBDSE1CbU9kSGwzVVNoem5sekpH?=
 =?utf-8?B?M3FFK0tOTlFkUklxdkxwZTZSOXFrYU9tOHNmMHk0R1lVZWI5RFhjSkprbFg3?=
 =?utf-8?B?azNKN25qbTh2QWZWMHVxK09NaTAvQlEvK1JwSjQxSThKTTY1bXdLcHkxS0xU?=
 =?utf-8?B?eitvTGI0ZXRaQ05tV2xjaDEzTmhwaTdUeHJubnJTR1Y0Zlp3dk9aSVUzVGFa?=
 =?utf-8?B?TXhySW5CdzRrVDlPYzVRVjY2N0JSanU3M3ZSd0VYRC93ZXJoNmxKQlpybG9E?=
 =?utf-8?B?eHhEUFhRcjJLKzVsOEIwdjdmWXE2NmtlSVpzeWVuTE81dXBKRlZjc2JWZHVj?=
 =?utf-8?B?d3RUOHBudUlSNDk0aVpXYUNvTUNhUVU5Rm1zallpQ0dPYXQzaEt6b1l5SnNN?=
 =?utf-8?B?b1pCRG85cG0xclJtQ045eWdQVFY1QmhFamcvTEhnQVVuOSsrL1gybWtjRm9X?=
 =?utf-8?B?Z0N0K2dkTnhZWWk3TThYeURmRFJJWmJrd0grS2dzMHM2cSt6TWRzbXViRXFy?=
 =?utf-8?B?bGFtV3h3MkpNSlBONlBGWEZ2Y1VyaUdTVlIrWFhlNVNJSnptTWIvSnJiMjgr?=
 =?utf-8?B?MHpITHBScUZ2QmhoUEo5ZzFIWGIzeU81U3NsTmt5aVZoTm9yZjdyVjBiTzJr?=
 =?utf-8?B?bTRJK3ZSeEp2bTd2a0hYSmhaakQzT1BWSk9JSGVUNzZqQ1psNHJWNWJtOXNM?=
 =?utf-8?B?SWcxdHBCeklCZmQ2RzlQT00rZC9oMTRuQXZ5OXBTTC9qK0hONGd4RzVTUUFN?=
 =?utf-8?B?ZHlDMEVFaG9BWDNjbVBwQVdVTHVVQURYbHUybnV0Uk9oM1NicENEMzdBOFE3?=
 =?utf-8?B?MU11ZGtpbTJ5Z1JXU1h6T015aG5RU29QRVJPRlRDSm80ZDFkc2lvOFRKVldJ?=
 =?utf-8?B?UTNGa1hpdkdTNTR3c0RQSTVETHpRQ2ptSzNwNElDbkkvQWpCcDRIUXhuUnFs?=
 =?utf-8?B?THFMYURZcUo2NkJQNzNsakJHc0lKK0NnREhnYkZHbFViSHhMSzlBQ3ZzemRm?=
 =?utf-8?Q?YgdZz67349zAwFhLh9GBYHLbHX8roS34KO9V7Uqf+9r8g?=
X-MS-Exchange-AntiSpam-MessageData-1: I8Ol/CapI2sDBw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf49efc-204f-4bbc-8250-08dee950bf1e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 06:56:54.7158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcPy2oiHzHbk5Ojqe3VV1Pj0W7n0d5cgVk1/KexAxS6h0wyyytmVV6tseWsdVvIX05xzmaESj4A9wfAWcCUowQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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

`FmcBootArgs` logically owns this, so pass ownership to it instead of
storing a reference.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs           | 4 ++--
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 48438ba21b91..67de54fbd008 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -208,7 +208,7 @@ pub(crate) struct FmcBootArgs<'a> {
     fmc_boot_params: Coherent<GspFmcBootParams>,
     resume: bool,
     // Additional dependencies required to be kept alive for FMC boot.
-    _wpr_meta: &'a Coherent<GspFwWprMeta>,
+    _wpr_meta: Coherent<GspFwWprMeta>,
     _libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
 }
 
@@ -218,7 +218,7 @@ impl<'a> FmcBootArgs<'a> {
     pub(crate) fn new(
         dev: &device::Device<device::Bound>,
         chipset: Chipset,
-        wpr_meta: &'a Coherent<GspFwWprMeta>,
+        wpr_meta: Coherent<GspFwWprMeta>,
         libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
         resume: bool,
     ) -> Result<Self> {
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 358dc2f25e26..f7e7da62ad9c 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -156,15 +156,15 @@ fn boot(
 
         let wpr_meta =
             Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::from_sizes(gsp_fw, &fb_sizes))?;
-        let args = FmcBootArgs::new(dev, chipset, &wpr_meta, &gsp.libos, false)?;
+        let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
         // Wait for the GSP RISC-V core to halt in case of error. We create this guard after `args`
-        // to make sure that boot args are kept alive until halt, in case they are still being
-        // accessed.
+        // to make sure that the boot args and the WPR metadata they own are kept alive until halt,
+        // in case they are still being accessed.
         let mut unload_guard =
             ScopeGuard::new_with_data((unload_bundle, ctx), |(unload_bundle, ctx)| {
                 let _ = unload_bundle.0.run(ctx);

-- 
2.55.0

