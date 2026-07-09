Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFEAC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B98FD10F3C7;
	Thu,  9 Jul 2026 06:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tg1Uu+RA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA1F10F3B9
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e88z2WBLqMis/M4ATFPymD28OkJjsWV/b0bxcSjcE8X9JG5vaPn3FU0TFXmk97rFhoQ4xAixi2S/H7+8MUr6RxPOkKakWzsPqSa1B3kAwzfsMLfC6Pwr46VC96VG/XUo3pm++23ceEH0WJqJxllRiJClRDbxHUvGT9k+LXCV7gip7V6WHUj9F0CtMnFH/UM8Bp3DtyjTAdb3Se5SGoZylo3XrdMLQtVTrTFYdswJFxB3xSOkYvv7oN39GVOnlzy3R0YPt1LT54lLjnHlwTwjJUuIJ5ZxGkpKkQpauXYlsoIZvsw2YIG1aUoBOgZhX3PRZqOyEZRQVEPdwn2pNX5S5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCMnPAEZIhT0XwIpqmHyLgnB3jhrTBPoSRokuLZhbEY=;
 b=L6abCvhH78HHqt3IlmQHbXDDFW/BQnu3TDbp7my2WLLX0d2hN+nxcM3emy+w56Yr+PY+ARVekhm8vfjYYC8F/c/PKQVmIXpj44lsvGwF5HqJTpp39SKNItH2NBSLY2fhyLoUZeIBxugWP4g6O0zDwnHnEAw3bi/YnUmcwm5iu2x/Z3KXDHE33DQfvpZN3t/z4PL/ivrj1lhaNFTytad92sqfyXIfweZqRgUmMCY6TuiQnkCVB/HUITTo0pY20X1HW8k35y4QM1Thf/NICJYNjump/FuVX1CLA02m8INyk+FBtZ4+VqXqAeHUHRnyFD3qtTUB3nyyi6FpE7S6Y1zgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCMnPAEZIhT0XwIpqmHyLgnB3jhrTBPoSRokuLZhbEY=;
 b=tg1Uu+RAvpCe/2vmFDci7ET8dBFLXzGRRD7yqWVQHN+r4d/ZX8Bzem/1JZhpYx/qjFLMx0Svjap9B3FJIhxbqEtnnKqM9wgkTKsgDxtJAqtQbOAt/pnA6w7xd3HGCxaE2HC7T+RUUQH0hsS1NmLU1qpvoKJvvBsQJhQqM0XZASzXARb75Psb8I0N4ejAW31Xejd3BIJBr5iWxNqgQru7Adj9++aQPW+454Lbai83ppcIKofgPxE0uo3kXnBltPohE5vHNThevzAaM4ckj5OMjJ4pfYA1VVp0LLhEO5Za+80fp9f/Rp+ZZ0eJ3JsMnPhcBRrr6tISAq29Sjh3gcvUnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:57:03 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:57:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:53:00 +0900
Subject: [PATCH v6 07/13] gpu: nova-core: gsp: turn FWSEC execution into
 HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-7-520cbf8b9b50@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: d978b21c-862e-47d5-ac38-08dedd87479f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|6133799003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A0yv1hzR8Tj7mJ3nKkSrNz/L1w38CEixZ3ET9EhfEJsgukMJx4axA4lSEogS+8kEYnigmOvBVYcUmvPRTff9aKzkwSondDZPKAOsThGlR1oi4junhKf33FkraEoQdAJatw5Fy0FqddzF1CYv3QhKCSMQs3kB2ffMzXVe5lG+nRcK9KVT+Fgq2PUdpKPgiD2AFLJFCj7cgaKNeLJQT++wOHm0+FXEjunS9Yq1N6SM6qMtXLrHlqWA3f7cW1dWdxK0qAvBlKHG8WfvMK0Mu9jTFa7sZGrIbIp6WEYVBre6oJGfTTr2gNTceh5g5aiBXg+DDDV5KM1rLNP3PY6Lm8E4uyr97Hbry7rtjrwKSBD+O94RlRo8emK0/gFV+CdrilSLDIWZ7poTIwp5ak5mmfurrObmf2jaCXNfOkj3NMS3EZuT0d7aU2ocj6jPmPNdusOwYqFurTuzXh1FM2Nequj+jaIDyP9DDIKf+xFVuVgDGlYFVvjtElEzTtdZcWlCkPrGnd/j4/oqjGm3zgCCFSX0jGqJPBlVtNTU1ysBS7yy+TxANez854dox0Ibl3/8dan0usdiSPp7gXQSx1SKcAooGBgI9aQaOhf/LgSJyyBVtLkyWG7SLG6JkyoD0KzmVAvJw44COGAUk0OMkB+Tg3gibTxtoHbFJj44endVhduEv/nwk0UAy1PW4EmYga5o5RZxlAbwk12eC3c1dlQPMpGFYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(6133799003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWM3WDJaSjJRcDduTjdyTlhXN1I0S1hYUFZLc3JGVEdLcUJiWFJRdnJKWjFT?=
 =?utf-8?B?TDNESjJNaDU3UUYzaG9jZUFUS3dpQVFXSk9BSjJxcGNwcU0zYXZBbm9FTHB4?=
 =?utf-8?B?ckdPT3F3ZXE3QXdRcFY0d3RBVW8rTGdONUxEMEFGY1M1MlFZS09TK0FQUUoz?=
 =?utf-8?B?cEdORVZsOCt4U0pjNkVidkZ1MHVXemlIWHpvVUQyMTk4cTNsNDlRT2Y2bnJM?=
 =?utf-8?B?WEo0aFJ5U3E2dXJHWHFDeWVSckVTRFhjVkNuMHcxUmlKVTJEVVRIeUlDckZt?=
 =?utf-8?B?V3pPcnpXcjAzdDM0b1ZwY0xyeXd1MmZoVXFOc1B5bFExYzgxS2tIQjkxQVJu?=
 =?utf-8?B?YnZ4YWppN3V2eS9iSWh1a3pIRWNqRFQwOElDbE9YWkRaNGg4OVIvaHREdi9i?=
 =?utf-8?B?NEZ4Q0FodmRQUGYzSEVCU2d4UUI4cDVKYW1VNm1DdXJQVjkwL3JidC9obUVq?=
 =?utf-8?B?MmJVWlBjNGViUTg1WkZINFc1bjFwejRqS1ZZQU1jUjFaRFZUcDhiWjRmVFAw?=
 =?utf-8?B?YkhXd1ZXbnpVa1hCMWk4N3VEdE1VMldQdkJVL0FjaXZjNkkxWlgyMUFRSUJK?=
 =?utf-8?B?bkVaZ2VOK2YrbXZoTjNwVFUzOGpJaTZEeGhaRVpEUVE1cThIS2pDeUh6NnI5?=
 =?utf-8?B?VWVGcmpIVkhjcnEyWDgwNDBvSDEvQ1hOVXR5TnRFWTUxYUVBeUp1L1VRUnBM?=
 =?utf-8?B?RVhiTEJkbFY3V2NtcTE5Z09BTG5ZemZ5Tks4cHUzb1Q3YWplQUJXR1JEMWhC?=
 =?utf-8?B?SVg3bklGeDAyWnNtRVJoYlhncHhmMzhhZ0lyRHZoVndRL2NhWEV6Z2Jub25i?=
 =?utf-8?B?Q0NHdUJVeUdUZlVPVVdsRWR5RjA2V0J0MmZESWRzOC9aYUM1dEFhZ050cjJj?=
 =?utf-8?B?L0h6OHN0YmJDNytzcnI0b3ZOdUdiVlJlQkE5UXV0RGJBdXJYdVVCcjIycS9J?=
 =?utf-8?B?NElLbzIzanJyd2xwZUdLNmtiRGMrelJGaTY2T0RYMUcxUERqMmRVZklQSFJ5?=
 =?utf-8?B?amdkaWNGOTJadjMra0xJYVFiRGNIM2xteWhVTEdzVkJkSU1IOXExMkkrMEtD?=
 =?utf-8?B?bHdqRFp4YjVLRkk4ZW9Ea2pOVFdoME9VaGhObS9xcU8rUzB1ZGxGYUJ2ZnVs?=
 =?utf-8?B?M05SRGpKVUpNeGoxWjVqcmI2YklzUVJDWUhsWkxYbHFNNXlLVUUvaStvSERi?=
 =?utf-8?B?a0ZPMWVSU2JReVcxMGRXUFJNRlI0clV2MjJWcjhXVFoxdFZuUmcvZlh4RjBv?=
 =?utf-8?B?YVk4akhaOEFCeTdCNXcyNDJIYzBWazBENWNVeEx2Tmd6U012cE4yMGVIcTU2?=
 =?utf-8?B?c3diaWRhWENjc01UYWY1cTFWYnNveWY0dnk3SFVVMHJZZ1ZkUnVMMlMrOFV1?=
 =?utf-8?B?SklLUEdIaUZjejdMMW1XWURnOWthdythZmRSUkJYNmtrbmJCSVlRVnBhV3Zi?=
 =?utf-8?B?eDhrSUJLcjVhVEZtUU9vbGt4aWcyL3p1YWlocUNlOWNTZ1hZQmNPeEtHOXE3?=
 =?utf-8?B?K29kenBwTnNNTFRFWjJla1pkeWwvTG03TkU5bXBTbzJMeVpGeWJYd3ZrQ1hi?=
 =?utf-8?B?dkNqcGwvU1pJY0h0ZlhPL1Y0Rk55N2FnalJqMTVHbGtlcGdSUG81L0lGa2No?=
 =?utf-8?B?c2NadjlvdGtZT2dmRTFmZ212TkRlNGFaQkpnKzB2aFIyRmg2M3kvK2tFa2tJ?=
 =?utf-8?B?UmNzS0kxWjdscXh2dGczRk12WGd1KzFuekh1YS9RSEtsZjlQTGdJRXhBdDl4?=
 =?utf-8?B?dzl2U2hsY0NxRC9wQ0QxWVlzMkc5NEM2Wmp1U3hsUkRYdlZMN1d5OGZKRGQy?=
 =?utf-8?B?TjQxZUhRQmNrOEJoQ1hQMDVGUW1Jc2kxYll3OXNvQW5RLzR4cWpvMmFNZkFy?=
 =?utf-8?B?WklTRGttOWx6cWltbGgzNldNWlBPcEh4VFdPN3dYSk1QMmw5bEVQL0lhcW5T?=
 =?utf-8?B?WCt2OXFLMnB3RkxadnpQQ0lsa2E2VWM4QXFlK2dnUzBmdUlVbzRqenJ4QUZ3?=
 =?utf-8?B?UmF3V3RmekNpK21RMXMrYWI5dFpuT0Y1OU1lZTUwN2Vqd3hxWTVnQTFialFL?=
 =?utf-8?B?d2ptMG40RWhXQjJHUXc0ckJsQktObXdXSUgwZVQrbHdvd1BFNzM4U2tGS3lu?=
 =?utf-8?B?SE1jbmtJTWF5YUpaQ0pKdTFIMW1tWm91VjhBRGN6NEdTNmpnaWh3TE4yR3ps?=
 =?utf-8?B?NG1IVHV3amF3dWRQZmRkTjFCQzlVcEZkTG9jYW5GWEZPWGtzbkM2UXdDbEp4?=
 =?utf-8?B?TGFucFR5OVdBaGtES3Jma3d3c1dzQmJldzI3VU4wU1JadEttK3FlbE5TWkpC?=
 =?utf-8?B?ZndZQmNRTWYvT0tNcEZ5SFJoejZWaStpQzBXTWMzQ1BtME5sS2pUdHB2NWFX?=
 =?utf-8?Q?3aQr09EJAsQmU7lGCl6rLCUsR1j/x7eELUMZba7BuIAar?=
X-MS-Exchange-AntiSpam-MessageData-1: ZiNoRV50edL5Mg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d978b21c-862e-47d5-ac38-08dedd87479f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:57:02.9345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIR9wb5IwwnfrnrSFQ3vvJpSXbxRbmY/9vBx5XfLNMxx+qKFCKFN2WXaoG9PdyMT/21JIf7nswBDSABrtutJrA==
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

Turn the `run_fwsec_frts` function into a method of `Tu102`. A following
patch will turn the "use FWSEC bootloader" property into a flag of the
TU102 HAL itself, and making this a method will allow the code to access
it instead of querying `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 173 +++++++++++++++++----------------
 1 file changed, 87 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index c8c7a4f45809..066f97c9908a 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -127,94 +127,95 @@ fn run(&self, ctx: &GspBootContext<'_>) -> Result {
     }
 }
 
-/// Helper function to load and run the FWSEC-FRTS firmware and confirm that it has properly
-/// created the WPR2 region.
-fn run_fwsec_frts(
-    dev: &device::Device<device::Bound>,
-    chipset: Chipset,
-    falcon: &Falcon<'_, GspEngine>,
-    bar: Bar0<'_>,
-    bios: &Vbios,
-    fb_layout: &FbLayout,
-) -> Result {
-    // Check that the WPR2 region does not already exist - if it does, we cannot run
-    // FWSEC-FRTS until the GPU is reset.
-    if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
-        dev_err!(
-            dev,
-            "WPR2 region already exists - GPU needs to be reset to proceed\n"
-        );
-        return Err(EBUSY);
-    }
-
-    // FWSEC-FRTS will create the WPR2 region.
-    let fwsec_frts = FwsecFirmware::new(
-        dev,
-        falcon,
-        bios,
-        FwsecCommand::Frts {
-            frts_addr: fb_layout.frts.start,
-            frts_size: fb_layout.frts.len(),
-        },
-    )?;
-
-    if chipset.needs_fwsec_bootloader() {
-        let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
-        // Load and run the bootloader, which will load FWSEC-FRTS and run it.
-        fwsec_frts_bl.run(dev, falcon, bar)?;
-    } else {
-        // Load and run FWSEC-FRTS directly.
-        fwsec_frts.run(dev, falcon)?;
-    }
-
-    // SCRATCH_E contains the error code for FWSEC-FRTS.
-    let frts_status = bar
-        .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
-        .frts_err_code();
-    if frts_status != 0 {
-        dev_err!(
-            dev,
-            "FWSEC-FRTS returned with error code {:#x}\n",
-            frts_status
-        );
-
-        return Err(EIO);
-    }
-
-    // Check that the WPR2 region has been created as we requested.
-    let (wpr2_lo, wpr2_hi) = (
-        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
-        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
-    );
-
-    match (wpr2_lo, wpr2_hi) {
-        (_, 0) => {
-            dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
-
-            Err(EIO)
-        }
-        (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
-            dev_err!(
-                dev,
-                "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
-                wpr2_lo,
-                fb_layout.frts.start,
-            );
-
-            Err(EIO)
-        }
-        (wpr2_lo, wpr2_hi) => {
-            dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
-            dev_dbg!(dev, "GPU instance built\n");
-
-            Ok(())
-        }
-    }
-}
-
 struct Tu102;
 
 impl Tu102 {
+    /// Helper method to load and run the FWSEC-FRTS firmware and confirm that it has properly
+    /// created the WPR2 region.
+    fn run_fwsec_frts(
+        &self,
+        dev: &device::Device<device::Bound>,
+        chipset: Chipset,
+        falcon: &Falcon<'_, GspEngine>,
+        bar: Bar0<'_>,
+        bios: &Vbios,
+        fb_layout: &FbLayout,
+    ) -> Result {
+        // Check that the WPR2 region does not already exist - if it does, we cannot run
+        // FWSEC-FRTS until the GPU is reset.
+        if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
+            dev_err!(
+                dev,
+                "WPR2 region already exists - GPU needs to be reset to proceed\n"
+            );
+            return Err(EBUSY);
+        }
+
+        // FWSEC-FRTS will create the WPR2 region.
+        let fwsec_frts = FwsecFirmware::new(
+            dev,
+            falcon,
+            bios,
+            FwsecCommand::Frts {
+                frts_addr: fb_layout.frts.start,
+                frts_size: fb_layout.frts.len(),
+            },
+        )?;
+
+        if chipset.needs_fwsec_bootloader() {
+            let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
+            // Load and run the bootloader, which will load FWSEC-FRTS and run it.
+            fwsec_frts_bl.run(dev, falcon, bar)?;
+        } else {
+            // Load and run FWSEC-FRTS directly.
+            fwsec_frts.run(dev, falcon)?;
+        }
+
+        // SCRATCH_E contains the error code for FWSEC-FRTS.
+        let frts_status = bar
+            .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
+            .frts_err_code();
+        if frts_status != 0 {
+            dev_err!(
+                dev,
+                "FWSEC-FRTS returned with error code {:#x}\n",
+                frts_status
+            );
+
+            return Err(EIO);
+        }
+
+        // Check that the WPR2 region has been created as we requested.
+        let (wpr2_lo, wpr2_hi) = (
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
+        );
+
+        match (wpr2_lo, wpr2_hi) {
+            (_, 0) => {
+                dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
+
+                Err(EIO)
+            }
+            (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
+                dev_err!(
+                    dev,
+                    "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
+                    wpr2_lo,
+                    fb_layout.frts.start,
+                );
+
+                Err(EIO)
+            }
+            (wpr2_lo, wpr2_hi) => {
+                dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
+                dev_dbg!(dev, "GPU instance built\n");
+
+                Ok(())
+            }
+        }
+    }
+
     /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
     fn build_unload_bundle(
         &self,
@@ -284,7 +285,7 @@ fn boot(
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
-            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
         }
 
         gsp_falcon.reset()?;

-- 
2.55.0

