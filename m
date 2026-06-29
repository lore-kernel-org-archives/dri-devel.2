Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8BFC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A92310E90B;
	Mon, 29 Jun 2026 14:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cyDM/OMY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE57710E90A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuTGLFMS5g0oRzaVtNIXyzGAd2nadvgZw3QCco6eUUxHEsVZnWiRZmD7ixk7S4bnh3YEWsz/yNiTIqEZ+etFC3FDi3kplXgmTUfjhSFuGD1ROIxKuaJQvpnG5Ps3eRi+6bNHfffm3Zo1ujQCRyRL+3MXSx7nIe2kdq9/+643vLYa8itvEOaSfjDZ2UgUNsHsNZfmo9qfSXzpFCrGVgB/3TPB5p1r+9/buE7WatU72NEgWkcCiEVY4tFpuoyUySZMcGeJeBhVgnu3arHEy+ahZ4FQ5FX2S/AZc0K7aBXmevneiH20tctB1ekXphLW9yY9dEqDbFrwA0kmDNFVhmgDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQpUQZYKsiWKXBbrkKHjBP4EBRvLErs7IH5eqzdfUOY=;
 b=FwdD7H05jynx2ZA+4cMFvYduSs0eKLAEbJCfLoyVW6k5T9nnWbYsTY16FXNeQOZ1QhwIQVwhKdl81NxqCzeUMf6QZ48DQPqFwco2FPtOiefzM1Qn37TFFAYBgrIZkFQ/DTI0Zj9sCG3RoZlrRySQUD3DsWs8xR8NxfSm0aiHsDxaDl5W3xMFwE/g1BJozsKAqP9WrMSwte8G5QLiEKN7+jLnKTZ2C2thNf1eLoP+srkY3H92xZ8fkWOuhptaqPxzo9EzsDGGMiKDVC5bORq8b1iwYRX9iDAPbz86t1dCOAWU0iSDdP3GY8kO7VbJKqaAn5LnhlPj95597eD7zG3uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQpUQZYKsiWKXBbrkKHjBP4EBRvLErs7IH5eqzdfUOY=;
 b=cyDM/OMYmNCVGsa+iaUlEWeQmBHVlhIA2XZbdpkwPLjxrgBgoHqY/MwFbBdyGSaGyptFSRntSSj480Kp5fJVVhfGsqGVm2u1d006XLIvfESqNH3GV++jSdBI/mdl2FOXnAC1TNlFnL3et4fksWvtlCvmLwQlyyHk/CXSJypgeBe5URMxhvelKx7z6tl97ZtOQwpHt0JJN2bCwF/4A9ejIYfq2W/Xdq4OrBTJGIWmEnWJu9J3mmDKuLuAfsXkrdAUqXUfO45HbDse/K2i1Slp2Vig0dcYAQHR0DiuqzVyLjfazGMfJ08e3BG1y8JSBIKmHfBYcJyhMtx3D78VBUEGWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:27 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:27 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:42 +0900
Subject: [PATCH v4 10/13] gpu: nova-core: avoid repeated calls to
 pci::Device::as_ref
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-10-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OSTP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d76612-e67a-40a1-916b-08ded5e82b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: JxrS42rAdaVQ+lNzmkHGV0X8IlYaGn0ybL4F9O93J3CW9Ngva2wYAh6zfQps6Ou2rj+A3Ty9e1Sig3wyyQOyXshjnZHax5KD/LoOQ9GO3gZNUXHAIwX1aOAPT50iCAEo+VZcPa9PGTSAsgzpMOrF05ntzgE13tpF9TUE1Z/5VVSUY4p5HivqTzfS63jir7EqIZpClgIFIIOHMTJDn1AzYFolzyRVUcsyZK8ktBC8UXpKLxxxohe4ZojuYpZ/+kDBqaj2brv6zoODwKYyMDOL7BRrthDNoYI4Ci/sHtHsEDbm7BZ6hGILNKJ8LyTrGBKROCV39ggxsYz6YS2KzKGrZoOBTkgw6RhxOsc27VBeCRBpNYzO+E1dmyUKwB1iuvmnDMuvgRjRKG8FYNg7SURZBy1sv4+BZc388udC7AQvmBkyrir27548PlE3Y1cV3hC4m7M16c5DcKvjo3ZyS7nESOlUGBq3TPZ4sacm1n1WLFY9Aia0MzA+qZXGW2jMpGocJDAbme4Cj4y5stpU5RiPG5kWMDmQIXp58FGzvjHy/2Xz84adXV4uDKlgVSnyqy5KHoQfU/UiXq5TQNvAEh52LPRBZI/oPjkKo3Je64l2rMdcvRkGSNDSF58Ysr+3otl/LQuVXMdFQQsuwofFbFMvS3UPqZAn32rK+xxwYMlv4O1zFMNGuuVz9AOhvnofFttEyEy1dcxD9db8NCciNParuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDJaSldSbHpWTldXR1BBeER2c0VIVldVSkhhTWh6NHh3c05UNkVmdFZEbGdN?=
 =?utf-8?B?cXZaYnR2ZGRiQnlqM1lYS1NaR1orcnk1RWd1ZzF1Tzg5SjBaa3ZTZkRwVTVk?=
 =?utf-8?B?UHJLeW1LQzExMWpxTjFwaVFteTNDN2FSYktBcXZPS1V4eExBMnNVN2xTSHBK?=
 =?utf-8?B?SDlnSnk0NDR2RzB6dTF2TG9zcXA5eGgwSTVidklsRkEzVkRWSENIMVJjbVRD?=
 =?utf-8?B?N05KU0tOVDZxbUk3U01LcnFSdjZVamk0ZThzQlNqY2JiaUNNVGxyZDAyclVG?=
 =?utf-8?B?RUVTblFPOGNNUCtWbkFjemhDOThNajF5RUVNc1lqd2lIT1orNzFEL0NTeUpU?=
 =?utf-8?B?bFo4SVQ2WDh6cUxQN0pBSlpIUEVlR2hTcWtBb09YQzVwbENZMU03b09kN0Jo?=
 =?utf-8?B?ZlJqcXA1QUtUQlAwbDgyTkRJQU5LYjJMNGNUTlh4RUFyRnoza2VVT0tBVlR1?=
 =?utf-8?B?cG90Nk9zRVFqU2hTSDhBdlNEN1RJbEdWTXM0NklqeW8vL1QxQmJvalZJSGpu?=
 =?utf-8?B?WDN2WlFFMjJPWHduNkZxNVlEQUUvbXo3ZDg3TTZrbHkyOEdZZHl6dndabWpI?=
 =?utf-8?B?eWp6dWprYUtGVDNEOXVPNVBIMzdOWXNYazZHbjArRjMzT1ZCSzlhUUFiNlFW?=
 =?utf-8?B?R1FxZWNaWTZ1TS91ZUtETVZCa1ptZGkzalY4TEkzZDhSWjZsMjJYY0tSRHE1?=
 =?utf-8?B?cTM5c0d5SlhwOEFZSU13U3JINDNxYnNFUmRNWkFSaDRLVk9XNk9hRzlZZ1NL?=
 =?utf-8?B?TjZoay9uQ1pJTm9vNEZkazdaVnZxN0JvcmlYMlBXZ1FqTDNDV0NnbG5HNHVa?=
 =?utf-8?B?cEp3OXBFY1E1U0RuZ2ZoaCt4Qm9DZW1ZUG1NT0taaFRUTUF2Vkc3WGw5dGo4?=
 =?utf-8?B?Y3d5NkhKRmxkcDVWcUpyaFhucXovREg2MitsTW1Tdmh0YXhKZDgrOTFJekZQ?=
 =?utf-8?B?U1NjY05HV3lzaldxeTV6QUdhS1VuR3hDZUV3WWNZVTRVbXM0dHJZMTZ5Ty8w?=
 =?utf-8?B?dC9YQkJheHluRWFTbi9DeTJ4c0dDYzRUd0dVNG9YbkswaCtBdmR1ZkpIcnRa?=
 =?utf-8?B?c2dmV0lnd08zSFdYL3lHUUE5VEFBTVBpNEUxUGZrWHpJa2VWVzE3eHl6dHBu?=
 =?utf-8?B?UEM1Qk1ERVNjS2ZOZjc5MU1Ra1VxMTZQV0s0Z2w3YWhlbDFUSStaalRYaXpy?=
 =?utf-8?B?azAybnU2UzBNVFZNbXY4ZFZBcUpjZWV4ejdoMGpxZWxKUHZnTW91MFJKUXd5?=
 =?utf-8?B?ZUhocDBtOUlxc3N3c3JQTHBHNVVQbWhONXMweWo5T2NtZFdrWm1NOTZ1d2xh?=
 =?utf-8?B?czRSblNud2QyOWVBaEEyM1NnbkFNRnkrcEwrTkhUU1FoN3pmNnIvU2w2N3JS?=
 =?utf-8?B?bzhwUTkrVEpwRVZhblFkTzFkeUhCQ2NZc1RPQ0R4SkgyT1B2MGx0QXpuTXJW?=
 =?utf-8?B?WVN3YmZPWWc1VWFEUFZrQnlwbWFKd0ZkbCs1QkVkRTE3UFRhRFJLcHNNaDE5?=
 =?utf-8?B?UU5TY3oxNkp1a1JySmdpaTdIUlZjeFpyTzdEZ2dkOVkwemdSb2Jwd2FGV3Vp?=
 =?utf-8?B?VFVSZXRnY0h3THZ4M3l2MC9xWDFLUDJvUDhlQnl5WWZWYmxmVXB2d0JFdVhL?=
 =?utf-8?B?K255VG04U21lbmQ0UnlYT3JaWTkyOE9HVjQ0YVhweXhzc0pZNTVNODBpU2xz?=
 =?utf-8?B?VFFaVW1rS2tXQklFbGZvRWpJL3FnK1ZzL3hHNTJmSDlickp4bTJpa2pZYm50?=
 =?utf-8?B?V2ZKbUVvUUY1QW9Wa3lwenBrSHVQQWtjaTRVN2pmaUFzMjVBcmVGWGZMdU1L?=
 =?utf-8?B?STh1M2kxclNJOXFEaGRFQkxEd2swczh6S21PVCtJNWU1Y3ZwTXZYT25vZmJ5?=
 =?utf-8?B?R2hSUHFlWW5GM0Jpc2J6YVU1YUpzNXFnVlRxc1g1cnJEVkdlREI2dnk2Y2tp?=
 =?utf-8?B?TVB1Z2xoWklEaWpOSVJHMUZTRElJRzRXK1h6RGtaR0JsZmdFdkdTMGpUWjFS?=
 =?utf-8?B?cVNLYVJtUUhJUE41MFZqWFFGZ3A0K0poNEdYWDRxZXhXYVltTU9qak1ud0Vu?=
 =?utf-8?B?K3lhck45RGZkQWdVVkZzeXRrYnlsT2gwaUt3ckZaYjlBMG4wdHVyK1FMa3Jh?=
 =?utf-8?B?UXVsZHNvMWJ5ZVk1aVFsdWFzRVUrZmpRV25sblJoTngreW1qZWF1NnRwMVQr?=
 =?utf-8?B?SmI1SC9xaStia0Nhd0UzOTJTQTRzajdmY1VuNXZwUkVmVmpCWHJzaysrelJB?=
 =?utf-8?B?dE94eFUvUldGUmt1NW1PK29FZ3EzaGJsZnJ5dU1jNktra0ZZUW1KTWU0SzVV?=
 =?utf-8?B?UG1qVkk1Y1hRRlpsQWptNXJMUVJQNEUzalZFL0VOcU56Wm41b3Y5MVRiMUlC?=
 =?utf-8?Q?MoQuDBWT3STe532M4O/9coWjRz5JIqo2jRWeIMKd0CI3F?=
X-MS-Exchange-AntiSpam-MessageData-1: 9SMfQTMGTZ8oiA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d76612-e67a-40a1-916b-08ded5e82b5d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:27.1906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t+1Op/6l10g8VpeWU3TAIisiS5UItRCO7rUw77giyDTwuw+OwvZYrhZdJnTp41uw16Y5CsAwfCIgGgItWGddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

Add a local `Device` reference created from the `pci::Device` in the
`Gpu` constructor to avoid repeatedly calling `as_ref`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index c04706b60ba8..663e61d0c023 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -317,9 +317,11 @@ pub(crate) fn new(
         pdev: &'gpu pci::Device<device::Core<'_>>,
         bar: Bar0<'gpu>,
     ) -> impl PinInit<Self, Error> + 'gpu {
+        let dev = pdev.as_ref();
+
         try_pin_init!(Self {
-            spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
-                dev_info!(pdev,"NVIDIA ({})\n", spec);
+            spec: Spec::new(dev, bar).inspect(|spec| {
+                dev_info!(dev,"NVIDIA ({})\n", spec);
             })?,
 
             // We must wait for GFW_BOOT completion before doing any significant setup on the GPU.
@@ -332,11 +334,11 @@ pub(crate) fn new(
                 unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
 
                 hal.wait_gfw_boot_completion(bar)
-                    .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
+                    .inspect_err(|_| dev_err!(dev, "GFW boot did not complete\n"))?;
             },
 
             // Initialize this early because `gsp_resources` depends on it.
-            sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
+            sysmem_flush: SysmemFlush::register(dev, bar, spec.chipset)?,
 
             gsp_resources <- try_pin_init!(GspResources {
                 device: pdev,
@@ -346,13 +348,13 @@ pub(crate) fn new(
                 bar,
 
                 gsp_falcon: Falcon::new(
-                    pdev.as_ref(),
+                    dev,
                     spec.chipset,
                     bar
                 )
                 .inspect(|falcon| falcon.clear_swgen0_intr())?,
 
-                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset, bar)?,
+                sec2_falcon: Falcon::new(dev, spec.chipset, bar)?,
 
                 gsp <- Gsp::new(pdev),
 
@@ -372,8 +374,8 @@ pub(crate) fn new(
                 // Obtain and display basic GPU information.
                 let info = gsp_resources.gsp.get_static_info(bar)?;
                 match info.gpu_name() {
-                    Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
-                    Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
+                    Ok(name) => dev_info!(dev, "GPU name: {}\n", name),
+                    Err(e) => dev_warn!(dev, "GPU name unavailable: {:?}\n", e),
                 }
 
                 if !info.usable_fb_regions.is_empty() {

-- 
2.54.0

