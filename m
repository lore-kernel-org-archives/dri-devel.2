Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA20DC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF4E10E461;
	Tue,  7 Jul 2026 07:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XrohCaDt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 912A110E461
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBxRGMQ0cG7Ez94KON4CB0biHtGv149+vq6fSOC99POIj5QYfmLTZasYAyVVSIzP6JTt0buduIe8ywVqWy+WcjVWonU3w+NyRgTYLaRW0FOQES6XLl0UCRyGsweX+cNnLguJO0z6l8OE4ddSyMSOrS7eYMpJYtFW5VF5AytlkXCBgEqS8iMWN6oXisln79P1CQgfD1cd+C5aOnySDTO8/r3EljDf0rE6QwY7wU35bhgENM2KBU2/uMQObR91olr88Tlmb85mJn7aubR3//NW4pV8Sj6/VdUFGaOlx7pUAIYn06W+nIdnBm50oPn3lU//I1G69thsHJkfQydAKwjTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW/mVCrOYID4cv74f9ddDW39MBwS7DCloQxVay6hS2w=;
 b=BN8ebQR2Vl9N6SMjp4F1x/uCf7Nt04JtFifbXW1LT3lFSmlE4Vz6XOp8Uvilg2tZltHrqITArqra9YkmZ3t1qGGEpfEQap7noWKnyqDoMC3EKQN3W5yWiF1F2UCfwVSh1OmgLMiruehPZiFlo0hUbzBftyINFWRHucglSB39gcT9i184JrYsW0Q1rk6vLMCiYhcxTdFH4qAuS8TyAZl+lnweSZfXReJyUfQIIxHUCCmR3jviZv010/6tjsOIF2rHu2VR+xiOQEvpfocC9JveuS/SIKVF87bWWN9Joml5LxLLUd2N6ypZ+XNAb4jcA7jBowerz0g2KO1Z4As2CZ6Jaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW/mVCrOYID4cv74f9ddDW39MBwS7DCloQxVay6hS2w=;
 b=XrohCaDtyO5m33IpBMlOD9b9BbNkZCppZWOr0BaRwPTapIcPbwrKlBypja2zYZL3QXc4kBMB5XRU9HZ0rYzv7rXz7vYA5OUlYwl49vMDorc70glxJ2H7JOYa1WwWzP1nHHCB95ZPB0QAN/jOcPLrwG3HYr/8gC06SKqDrRk9UsXL9UfMj+VQtlXQEkjmgYzTe0rZvesYdfnr0GirdADJkGWyKPu8OCHarHAipIjeWGw4/NxtpXkR1YoCeWmSWDkRwMEN9aOqfvDaFUQAIGSqUmGxjBmkYNigm539uaJPKxeBlQ4QHkSGmu+fVeBNWSm6J4aYKkre/V+9N9lh/dLVzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:25 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:41 +0900
Subject: [PATCH v5 08/13] gpu: nova-core: gsp: make use of FWSEC bootloader
 a property of the TU102 HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-8-ecad9346387f@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0060.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f03d2f-9acc-41ad-2f26-08dedbf87e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0Pzu1ZpZ8UNA92D7lQazYxKFYTRR4tGn67cdc/uo3WPUAUpAIK+DBeWj4RFJ53/dGcfiy0TFbrPECj2knH/KSb2bMWNcWqiKTstr/NEiWS6zgin8+2aZfoJvfMOKOftfkN/OKSy7aGbFLfn7zgc0aWbkWAcXOVwhU329p+3rRbyWMALe4ogrjzu10spMYHpmsjtSXMBetL4heVxaHLeazV+MGL6irGkBxSsD3cU/nR3owu32by+4CeSRBiiKIelKiKGQ8iMOYehNkhnBGfpQYjdpOkugMLtvFHBMHjrCdUAW6t6MLHxtEttZvJK42QxnnwAzfnf0AT4cWZcDmrppNokEZESFJjS+vV4VcXFuNLJykl7/3D42ZFGY8jz1CGgkLJPRqilp1BHCozYhT/F0WtuXtLITEO4/4elk4X7oHECAdEInBWF3doBRmwUh0HW5t+FEYc5B9s+ocOQkjf83wv7Z5ck4OQbdTIfA55CjIQJC2E/ZLjTCpz6gdFnOORXR1ztbOmxJsIrUf8QGrswy4RKSPMgtiHfE7aLF9gfiwV6UIumim/W7L+eI8Vyl5CzKy/BXEDNiXM4VTACC5KUfcitRHwRTuu+AmZCaQ0sr369hykD9l8zcwILcnFRjhbH+Z55Wv9rRjO1eDmkbRMcBjPMCzowYULDlnK7E2vOMbji9SH0v+yZ6BUTMl9z4SCbzCK27TyS8bBI6iJCwLOM/Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUI5YnUwUVpVTzZ0K3lPdVhVNVJ6VHhIaDN1N2ZYVmdSdmtCYlc3VUVhcHB2?=
 =?utf-8?B?NnN3OTc5NDlEdDFoOUJjS1hNZitNYmZjbFlKbjhCRCtwQlpkWlRiS0E4MzV1?=
 =?utf-8?B?dWxqVGh3d3QrV2tFRFp2YlRWVWx3SWlubHBFWDBSMCtoZ2tNcURWMlRUNDFm?=
 =?utf-8?B?TWFxdnJrLzVlMUxQcXZlajlQUWxLeWRidzFjVWh0SU0wVFplMlpHSHZZRjZF?=
 =?utf-8?B?SWcvdnhEOXptVlZ2UytZVDBEZXhhUDFidGxzNWdobXoyMlE5cHpXeUxXcVZZ?=
 =?utf-8?B?Sk4wU0lFU0tKQ01SOW82eW9VT3psWlE0N2k2VUQrcGY4OWNhNnN2Znd0Qy9m?=
 =?utf-8?B?am4zbGZOUEsrRHZ0Qkp1Umt5cU9YMzV1V1JzUzM3dUQ4RHZNbEZ1Z1gza2JY?=
 =?utf-8?B?YUt1eGxnd2FkRzlqeVdMR3hzdEdMVVZMd0tTeUJHZkcxWmhpNTdZRW85T2x0?=
 =?utf-8?B?QWtDdm1pei9pSFBySmgrdklyZ2c5bEVicjNSMld5VjYxRWFCSmI1VjNVTHFh?=
 =?utf-8?B?Tk5JS0hHWFNlR0pGMUE3L0Mwckd0YmhBUERnQ2NETENUWm05OXBDbURrbkFT?=
 =?utf-8?B?b3NJY3RlRWlRNHJxWTdKdG5Ndm1ieG9CS3FRdGh5VjNFaDE2cWdRY3NhQWVo?=
 =?utf-8?B?UHJLWlljcG4zd2J0OVc3Slc0UkdPcnN6cFVrU21QNDRHMmdENk1zRFhOWjln?=
 =?utf-8?B?TlRkQ1FGcjhZb256UGJVR2hFcUdyNjd0SHFZcnQ2Njh6aXVneWpJTTBObWdR?=
 =?utf-8?B?MzR5MFd6S2h3VnNmRWtKSVdPMWZwQTlKM3hoVmVOckhNeExjemNqNzdNRThM?=
 =?utf-8?B?UmVucXRINmVwME5nTEhMM3p5TkQyeVYxNW9JdW93RnhxbUhBakRsaXVpbFFh?=
 =?utf-8?B?aGdMSkNMZDJDSHcxSWRSVHduRlgrUzYzTGRSd0x1ZHc5UlkxemFZT0xRRi85?=
 =?utf-8?B?ZndKOTlOcEgzQkphMTJOQUpsTStYUjlaRFNrYkhMYjJYOEt1UFRCM2Nadkpr?=
 =?utf-8?B?MzhtYTBScEZSd0pjaHRrYlh5Y2x0amNWeVlJSi9FV1dScGh2UzliSGNlZ3dX?=
 =?utf-8?B?TTRlbktKYzh1RGtIbjF0ekJvcTlCSnJWRFFGTDl0YUdBa1NIb0VMTGF3amNa?=
 =?utf-8?B?b0Vpc1NKWHJOMURJZDFIQU9BcjErancxZ2lsaXQrS1Zoc3N4R1FVOCtFQjFh?=
 =?utf-8?B?RlZ2Vmd5OGpsN1JYcGMxMnVBL2djZTdzOUF1NW5CS3pJdjRDYjBScEdrblNh?=
 =?utf-8?B?dWRsazB5VkcwYUFYRXBUbEx2SkRtcnV2WFdhb2JEWTU5bFdaTG8xNUplTE1R?=
 =?utf-8?B?WnRINHhXZVZvZVMvcldMYldhUlQ0YUhwdW9welJ2YnlTNzl5NFpURFBZK0hq?=
 =?utf-8?B?azdRaXdmOWlacEVVUjRRTjZVNzFKalEza2RGOEVrWWM1SW5KMTcva3JqTWdy?=
 =?utf-8?B?MnlXYjZLZC8vYW9MbXo2bGRuUVBpUUFydWRwR0cwSDNMblVLTzF2Q0wvcmk1?=
 =?utf-8?B?S1NpLy9RcGZDazF4TGJ2ODNRSTIrRk9tbmZwZWhEM1U3ZE0ybm0va3A5N25E?=
 =?utf-8?B?K0R6aCtmbTZNQWdGSU8rMlBzRUU2SlhWVG1mRFZkM2hqRUcrbXpSRjhCWWc5?=
 =?utf-8?B?ek15eWNmWkhXY3JyYWxGSGJvaHd4RWlydmNWZEd5MmplaW8xMzlhd21IMmQr?=
 =?utf-8?B?VVpBZ1NEN3kxRWJVWXoxbDg0SWlRbWd4SjZMYllPVlBrMlNVQXBIYmVxT3M5?=
 =?utf-8?B?MnhDNm5rNUlkMmNhSThGYzBFTGJ6NmhTMlEzQ0taT0dTZGNJSGNkU3BXSmxF?=
 =?utf-8?B?Z2NoVVBDMlFFME1TMUZvTGp4M0t2SXU2N3NXZUwrZFZnRFBoNW85dVBKUkV1?=
 =?utf-8?B?OXJlaGNNOUxmWDg5cEVYMEFmdVVTVGswMHR3c29mR3kyU3NmMGNNTWtoTE1U?=
 =?utf-8?B?YjhNanM3WldQelJhcjZhcnpYQ2FxVXR6eitJOXk0VXRNNFZrKzR0NW41VGQ4?=
 =?utf-8?B?YllhZ0FqSGNDUVpvSEt2SmtIdXlQVmtzWTl0OGowamlnS0xudit6NTliYS9l?=
 =?utf-8?B?Uk04OVRkS0RZRyttMVlWWm9icVZ4UVJheThTRkpCZ0VLQk9ROVFRSklZRDdR?=
 =?utf-8?B?V3l5NmNVMUJvOXhuckJOa0ZTbVhkN2dQK3Y0NGprbHd6WDd5cUc4TVZwL251?=
 =?utf-8?B?MEg1ekpjVkg0b3RGN3Y0aE5FZHJqSUp0UytBd3dhcXdGRURKekQzajJ0T0E3?=
 =?utf-8?B?ZHM4VUhwbTlzWU42RDluQ3dCdXNteWt6ZVdGNTVMbHNMcmR4RU1SZ0lEODRV?=
 =?utf-8?B?UUZJdThoUTF4TDJWQ1FEWTk4a3ZpNUV2ekUwU1c1YTZVcjBFZDE1Y0xaWUVR?=
 =?utf-8?Q?kfrz4eL1vPYXc5Qz8FwhMAQ4D6iagFfw3/cRDeWTWr2JM?=
X-MS-Exchange-AntiSpam-MessageData-1: Ehj3s+n7PcIjpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f03d2f-9acc-41ad-2f26-08dedbf87e6b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:25.3848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPRWMtD3ns3YTY1drNCbEz3sGIzYnUYHzHDoMgHdxVZqih+VYzjtW6pRqz6vyHI755bEfwatktJeFyUEA9ASyQ==
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

By being in the TU102 HAL, we already know that the GSP boot method is
the SEC2 Booter, so the only variable is whether the FWSEC bootloader is
used or not. Since `Chipset` also includes the variants that boot FSP,
querying it for that information introduces a potential code path (a
chipset that boots via FSP) that the current code doesn't handle.

Turn the use of the FWSEC bootloader into a property of the `Tu102` HAL,
and give GA102+ chipsets their own instance with that property set to
`false`. This removes the invalid code path and the only use of
`Chipset` is now to load the correct firmware files.

This also removes some uses of the `Chipset::needs_fwsec_bootloader`
method and prepares the ground for removing it.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal.rs       |  5 ++++-
 drivers/gpu/nova-core/gsp/hal/ga102.rs | 14 ++++++++++++++
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 15 +++++++++++----
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 849ca224085b..eddb4e8bf510 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+mod ga102;
 mod gh100;
 mod tu102;
 
@@ -59,7 +60,9 @@ fn post_boot(&self, _gsp: &Gsp, _ctx: &GspBootContext<'_>, _gsp_fw: &GspFirmware
 /// Returns the GSP HAL to be used for `chipset`.
 pub(super) fn gsp_hal(chipset: Chipset) -> &'static dyn GspHal {
     match chipset.arch() {
-        Architecture::Turing | Architecture::Ampere | Architecture::Ada => tu102::TU102_HAL,
+        Architecture::Turing => tu102::TU102_HAL,
+        Architecture::Ampere if matches!(chipset, Chipset::GA100) => tu102::TU102_HAL,
+        Architecture::Ampere | Architecture::Ada => ga102::GA102_HAL,
         Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
             gh100::GH100_HAL
         }
diff --git a/drivers/gpu/nova-core/gsp/hal/ga102.rs b/drivers/gpu/nova-core/gsp/hal/ga102.rs
new file mode 100644
index 000000000000..ceb3eb39d138
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/hal/ga102.rs
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+use crate::gsp::hal::{
+    tu102::Tu102,
+    GspHal, //
+};
+
+/// The GA102 HAL is like the TU102 one, except it doesn't use the bootloader.
+const GA102: Tu102 = Tu102 {
+    needs_fwsec_bootloader: false,
+};
+
+pub(super) const GA102_HAL: &dyn GspHal = &GA102;
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 066f97c9908a..8480e2eb456f 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -127,7 +127,10 @@ fn run(&self, ctx: &GspBootContext<'_>) -> Result {
     }
 }
 
-struct Tu102;
+pub(super) struct Tu102 {
+    /// If `true`, then the FWSEC-FRTS bootloader will be used to load the actual firmware.
+    pub(super) needs_fwsec_bootloader: bool,
+}
 
 impl Tu102 {
     /// Helper method to load and run the FWSEC-FRTS firmware and confirm that it has properly
@@ -162,7 +165,7 @@ fn run_fwsec_frts(
             },
         )?;
 
-        if chipset.needs_fwsec_bootloader() {
+        if self.needs_fwsec_bootloader {
             let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
             // Load and run the bootloader, which will load FWSEC-FRTS and run it.
             fwsec_frts_bl.run(dev, falcon, bar)?;
@@ -227,7 +230,7 @@ fn build_unload_bundle(
     ) -> Result<crate::gsp::UnloadBundle> {
         // Load the FWSEC SB firmware, as well as its bootloader if required.
         let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb)?;
-        let fwsec_sb = if chipset.needs_fwsec_bootloader() {
+        let fwsec_sb = if self.needs_fwsec_bootloader {
             FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
         } else {
             FwsecUnloadFirmware::WithoutBl(fwsec_sb)
@@ -323,5 +326,9 @@ fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -
     }
 }
 
-const TU102: Tu102 = Tu102;
+/// The TU102 HAL requires the use of the FWSEC bootloader.
+const TU102: Tu102 = Tu102 {
+    needs_fwsec_bootloader: true,
+};
+
 pub(super) const TU102_HAL: &dyn GspHal = &TU102;

-- 
2.55.0

