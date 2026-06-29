Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5C6C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68FBF10E89D;
	Mon, 29 Jun 2026 12:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="k8kEX2MH";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE2C10E899
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yROzYFDrhFbp250b1KAwxL510xFEUTsgvsjBuS2IpB+mT4W7tvw+SUs2tAH2C9RH+75UHJ1Wfb/1Ls0GLO2hE9sQRXKv55SuPHv78iB6pCNS2rfKrnJzSZF/6+MZxozPYJnfAKH+feGXjHGnDsrLTvv8mOfzQPnehOcBscIKtOuH6mbhTpqcraDimUmqqRhWTegvjDadt6p/qMFp4/6ZWBn/2Rr8Ys++uCHErWhgLwyR/Esthvf/wP5stPa90+Cw5x9OuJLXhTT1aH98BgZ0zqucz/Dt6lsvMQGQ1vViFGMx79Rannj+O/JNGOba6to5KzU7Z5HB68RoP22c6/sYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/TmY/8KXfWx9M/RWK49wRIuAhLqzkh4XKmvDMEJrxE=;
 b=EjEyeTA3RWGIG0oKDwb0hl/maKRfcKRh1rxi4txC/xnl0zA7VhL+iophqrlE8U23l84HECq71qG471cZ2nySBWpk/adgxuCg76Bp6X0/+/0OD76ig2YO92rNIadsiDpul/b0XC0kTg++X2NJnJMrUIaCKtE/e2klyLOXeLbQS8/2jWkyIkN6IiOlkbJFJnYZ3geDfdIKVrdaQ7eKnQ23E+E4RX0j0d68snfgqQJpVtcgtVPVsdCHO8upr3JrOEVZKuzWqJKFJpu3E9xEXF7dZdXlf3Lm8ss9/IglJ5vFwDeRli/nvoWRYBILjhyQOy9FycBPSm8jhofrVsCIngvxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/TmY/8KXfWx9M/RWK49wRIuAhLqzkh4XKmvDMEJrxE=;
 b=k8kEX2MHEnbdM7OiY2/dNJpw09fwJFUztmWprHxs/8+JHNqVAc1ygDmvHnj2lWQd417ZYMCRKMx98nA5D0PyPY9prNjHpTOgdqsHUf6oT92jx8W4zCkjYrvV6CKNALWyNXg2X0ZAZqLextPn1AIpYINqL+PLBnjh1kNG3qN1B260cv7HPr9ovC5LGllUDnTVFMQiICrHxBlXKJ6OCs/bRCvCKtQbyTBE5+hRtBN35aALvBOM3NbAWBesZCKlfYt2btW8oSIR5MQi3CD2hvzp/3mtxg0AaRzD0F4P3ObXRSuY66xE2+E8PcBmgonmB+ctCZeHUHN7G0cxW74RNy22ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:32:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:22 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:50 +0900
Subject: [PATCH v3 07/12] gpu: nova-core: gsp: turn FWSEC execution into
 HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-7-26cb29ee8dee@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0317.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 38861b0f-75a1-4151-9456-08ded5da77c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|22082099003|11063799006|56012099006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: yghKpO7jP1zJbThWrQvIa+U9TtNucGI+Q0P5Y/Ly+Eus/MDU8j2dri42LXIV7Bv5v6cGmMg9yWDNtfmp+dcHbj0FspoA8DtXGr8OYNiHqIS+qrSpLA9Ridoku+3cWbjlkzed5QisIMs025E494Wr+TUbNlHMPukAkxGCrNy2IrclJjcDRVxoPAoXu3NVui1X+LOKiYeyy0KfsUhXLVVujsysCoI3VqxlmoxiBYJT3FaQzSGyvnPiNH3k2JV2gMME0ufpZjVI478QILnFuwFOi7wcDTNYdExRnZo6RwURdvmox6Ywg3SHNSTlhz3fwtMSjs8j7flRZ6bLctFhF8Aqa4wOfyLxXbMDJGgH8LzEPjQI48pNoOfeD9BK2Xg2JtrYS9HOMDUffC6EYCpKABuInITW09Sr7QT7I9iXfwER8xNvbsAfUk797tg/LhAOobeQNbPnf7AKKmvOhDpWVyk9B1SxfhHngXLRB/AbY4rBelSpmCnXvxYfRZjxvuH/uccOYytGhj6q4Wh6utJuvDrApLS6LkKbn3hlaUM2x/4eWBS4fouHJQodIM7mJYSP/7jEhQDvGoJodbusrYpF3T7lo1p/b+94z7ScBrdmnqvHJ32/FjNKfB//xN0WMrvNuDyZ+cNOuVuGyMPea0HO86Ph8udb43+1XxO9agU4DmYLMI81zDcFiCRTWXfmAsH3EuxXWI7yXqMhhYxOg9l2s7DyWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFoyNFBid2FXTFc3ZlJmM3BBbFJlWmpIVlg2cUhBV2NDdWpqeldrNzJFTUtC?=
 =?utf-8?B?ckRsbm5ma1JBeGJzWWFzcFRheFpDNThFRk9USURCTEtpeFVWbDRCd1hoQ3Qv?=
 =?utf-8?B?bnVWWU10TUFxOUZZLzVraVdvWERySnNNMm84NnJQRXJLcVVUbENRZW1GTFNy?=
 =?utf-8?B?L25MdjRhNThSYStlZUZoTHk3SEw3YlNUWS9QbnpXc0VzeWprZGxESGxELzBQ?=
 =?utf-8?B?UXVwUncxZFhxbGlKTm9IYU9hVFhCa1hiV0NMZDUzNzZZMWdUTGJ2b0hYNDc4?=
 =?utf-8?B?d25vTUhOZlBFRHoralBudGI3ajM0RU9zZlF1NERaNkViWXBjV3Ruc1RRNEo1?=
 =?utf-8?B?VFVUL1Jlc1VtZWlkb0VURU1YU0ZhRXVNcngzU0R0Z0N1ZEV1a0xwVTFpZWVP?=
 =?utf-8?B?TS9saEw4VTNWOHJqZTRZMFZmMmJydEVUWUNWRGcyZ3JPdFBYYmdOOUtmdEpz?=
 =?utf-8?B?YzVEeThFV0haQmFUbWFFYjV3L1lNNlF4VnlaUUpBMjgvV0J5SnJ3VCtHUTVZ?=
 =?utf-8?B?NGQxNEJOeXJEMjZUOStESDNjVWVMZFRpTCtSejIrdGRzSnVtcElWME5XYUZJ?=
 =?utf-8?B?OVRBZEdhbUgyQ25udjlOVHJKeEE1NkZTcm1uVEszSGJDTldONjdMSDIrc2wv?=
 =?utf-8?B?NHlXWnRiYiszTGpwUk1JVERWa0V6TjRIWnlVa0hEM1h4cldxYUkzUkhMTkQ0?=
 =?utf-8?B?VXd6cVh6YmZPS3ZjbFpFSWpBWEJyQ3BFOUdPbVZ3bVZBU0pvdTY5OXYxYjNY?=
 =?utf-8?B?c2RubUd2Y0w0cG8reUVSbXgrLzE1a1dNQWZFRUR6eXFFMFQ2Y3I1Skx4ZkQx?=
 =?utf-8?B?NlhDYVRVWHlWVTJ4NnZBNFRUOXFWdDZ6WVhldDRySkR2azF3bmlnSEJNbEtN?=
 =?utf-8?B?dGlQQUx4MTJuRWhRRlU4SWRjbElhQWtyZlZxV0lMWVlTMGFSM1paQjJJL1F4?=
 =?utf-8?B?b1FUeTdBSkJCeWNMeHR1V001WEdjNGwzQWZDRXFyd1hmK24xZzY2dGdXUGgv?=
 =?utf-8?B?MGdGZjJMMTVOc0ExZ2lnL2x3elE0UzhXaGVzMUhqQlo1Yk9kU3Y1SzhkV0tS?=
 =?utf-8?B?YW44QlkvTTJmMlo3cEttTzJyZGNDYXNrc1ZTUzM2QmZlTDZHYk8zRVFhc05T?=
 =?utf-8?B?b1I2WFNBNWgvMW5hYkYybmVIZmlyMmE4Q0UxZ3lQeG5ic3I2Z3o3ZENad0Z0?=
 =?utf-8?B?OWwwNEQ3TmdpQmxJMmdseUtNUW5xV0VIVXczZmQwNGx6Y0RJcTNTb2puSDdP?=
 =?utf-8?B?TmtrNE5QQURZSmNPdW4rRXQyd2lhK0NGYzJDb1lNUWk1UGduSGpsNEVwS2tp?=
 =?utf-8?B?cU5xd3ZSZCtWY2k5K2hGUVZnVlVQcnRrVVI2Q253WGtqcjZ2L2xkWktEemJE?=
 =?utf-8?B?SHZrWVNqTDltUHZNSnJiSFgva0M2MDNRTGNlZEM5RHQwVy9NaTFLbmtjcmp2?=
 =?utf-8?B?U0ZqdTNLZE1LVXY1OWhjdEtUeTNRQUNEZTd6TzdNdUlxUk9WaEs4MGlDN1pD?=
 =?utf-8?B?Q1dkekk4dFpOUXJnaFQxRlg5Q1grYTdaT0cwSmpVWTVuTW1ZZXVnbHdpMkk4?=
 =?utf-8?B?cDd1RHNXakk2ckdkY3I5bUNkeElydktUbStPQnh1c1d2bWJUM0tFOGV5WjZI?=
 =?utf-8?B?Mm5tWWhGVUdjcEFrUXRERWdmY21VeFo5NGE3Q09NSXBOOVFBNkNsZGxLeGtR?=
 =?utf-8?B?RG9uaTBQZ0o4S1g4OW1ZRUlTWDU3cENJUzBOZWl6T2ZMcTA4YkVucjdVZ2Qx?=
 =?utf-8?B?d21Hb1pYMngwZmVnQlpQQzhLMC9WUkpuclJ3U1BBUkNVelJsVWNhNkgwRThJ?=
 =?utf-8?B?OU5GajMxbE5UdUZpZ0VqeGU0bCsvdDRjK05xdUt2eWJ1NXBnQUw2QjYxTXN0?=
 =?utf-8?B?TTFuL0pkRitXaGFTUU1TZ0lmTWFrVUJiTzM4eEcxei9mak81TzRaWmRmbG1R?=
 =?utf-8?B?d0JVVkdHZytXY1Vwb0V5eVE1NERKdlAzMUZQQ0RjRGlSL2V6VThGb0Zha2Jl?=
 =?utf-8?B?QjgrdnE4ajd4UXE1ejdwODJYaktKekFVbHp5L0VUQ2hBeHVISVN0bVN1VC9B?=
 =?utf-8?B?cE9SWDdVcTBjWW01cXRNM05BcU1EZzJKQ2tSVjRQSFNUOEJKcEJaR1BteFQz?=
 =?utf-8?B?Nmk0b0xiYms1SURtaFdZVktwcmQxMFMyYlBsTElrSUlja3o0TEc0UHpJbm9E?=
 =?utf-8?B?SnFubm1NeC9oWnRFeW54QkN6eXZkd1VMVEF2S0hUZWNPSkxIYjNGYzhEbkt2?=
 =?utf-8?B?NWNjdHFiTlZsTVJtL21MN3dlTTNielV1SVNGdmZQVTJUT1IxTTRlQndiVzM2?=
 =?utf-8?B?RlV6T3VuaVdSSkZjWXVwWmpGallQNUJXYUF3ODNDbnNMR2FtTjRTV1BrVUxa?=
 =?utf-8?Q?OKi7vHPsjWmc6nseaT8jtrT2HqIeor7CYwek5HvuY2BTL?=
X-MS-Exchange-AntiSpam-MessageData-1: mXzz3ktCLN2opA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38861b0f-75a1-4151-9456-08ded5da77c4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:22.4010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZzHZQcZah690VSig/DE9iavC5ErLZyoOl1mLxBJzH28Ko0aXb/AnyoBb39mVNG3gmQdVBBufiL+sR4Uzt8X7g==
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

Turn the `run_fwsec_frts` function into a method of `Tu102`. A following
patch will turn the "use FWSEC bootloader" property into a flag of the
TU102 HAL itself, and making this a method will allow the code to access
it instead of querying `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 175 +++++++++++++++++----------------
 1 file changed, 88 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 22b4927cbaa6..98b8756043f6 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -127,95 +127,96 @@ fn run(&self, ctx: &GspBootContext<'_>) -> Result {
     }
 }
 
-/// Helper function to load and run the FWSEC-FRTS firmware and confirm that it has properly
-/// created the WPR2 region.
-fn run_fwsec_frts(
-    dev: &device::Device<device::Bound>,
-    chipset: Chipset,
-    falcon: &Falcon<GspEngine>,
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
-        bar,
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
-        fwsec_frts.run(dev, falcon, bar)?;
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
+        falcon: &Falcon<GspEngine>,
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
+            bar,
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
+            fwsec_frts.run(dev, falcon, bar)?;
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
@@ -290,7 +291,7 @@ fn boot(
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
-            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
         }
 
         gsp_falcon.reset(bar)?;

-- 
2.54.0

