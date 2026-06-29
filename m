Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECA2C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DBD10E89B;
	Mon, 29 Jun 2026 12:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="K15kHyEE";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A6B10E899
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yw5fzpoNyqcB4KYZNLhJfIjqQxpPkXxV9zyGNPceyJ+Y562RiZQAxsPhxSJIjHdqZ+/DHw04ZCn5wUiTwu6uWY5C1Z+9G5jZQtZqY5ypSKOi+h4AlAWbDWDzejsnrm1+WQMTThjz++cS17MY1t/VqhumB024eXXDGX3Ce6orELRo7pAG2wyuVC1QlbEXE5miz4N+9nPAiNWv3GihLTwnSK/0i2WIyunZkWYOvbJvgecY+R9VuedYT5mhonsGnSbboBmbtGLJjxdUBb+ltVqo7VSB2ykT7rhSDUL9RV1m5Y8jK48Fi0PocZk7kFTKDeem77g769GHWyINLr/6RsxO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBCjvvKquH+4CRHeLDBGshrIv1/kkfyejVHpjo1AzSA=;
 b=oB31eBK5aoqzLod8xpfykyOuHugi4iD/Kns5t/dC4mUUtQUXd1RBqanB6jiWyjvOj72RJP0REhxAtdn3vONbrTmd6oCFN3roc1ucww5v7nQwWS2eUPj9IdDYTr+R6NUW5DWmrBUj2Gm49tgRyvE55BKcr230od33IU1cA7PzoF396hU2jyK6GgcTixVutZfbHDMua25JREprFUyeO8d+TMEEG0XV6bQPsuXDPuo5SI/G43HClndkMPllCoCxp6hdnxxGRNCve32+bBhL/WUKdpNQwlo8pbhAZAAsd9WDsfIfsONz8J5k/IsMzks2yD/O3MVofkk9lxdghvoTT+CpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBCjvvKquH+4CRHeLDBGshrIv1/kkfyejVHpjo1AzSA=;
 b=K15kHyEEY/GoXyjRx7bfBZH9NdE7C3ybmhuyZd4x9Km9dfN5GFzwMjecuXO5gUQMtatPyTnYNDN58ZotwIutXnUmRNv/XcSIqjnW4e24CZjyGv+rt0PcjfYGTaARS+JMV7dS9Qp73IJy7lTQKf9+L8v5Hh1uf/ll2IIIESABybQHspjsy4bo3QV136SsKPf5srMlX0DwI6CsKcfqJJ8H9UUmn91JDrZ7BNOxMs4zA8Lt7MbTkYX1QRowRDy23/7cfgIxQtRa8U5LfzVRy97kw1SIlFLHxblHGr/0I6yzuqA5j4Bkwi2BFHrcwY4auuo3VRdv8jZvJBXgx4XmmbnA7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:32:26 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:26 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:51 +0900
Subject: [PATCH v3 08/12] gpu: nova-core: gsp: make use of FWSEC bootloader
 a property of the TU102 HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-8-26cb29ee8dee@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 39941e11-6d3b-4ed3-4db9-08ded5da7a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|22082099003|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: S9VhuGneqphhPfHoQmJ57Ki8IXXxQxay2OrVn7X3nzjaNsXwiFUPg4TRAxLDKGvJs/cNAfMgbwCRir8vR9vIILvHtgftwogNuS16qugxuiIHTqq4KGzkOpLHb805oeW2NcYVgKpMA86Yi6+KFpNwtuoeqyqslAEefHDRwlizFCvgWC9BRweKykSGocw/Arbn2fGMpnkgnTEM+Ub86PkkAEciWNITQPQTQ9feSyOrPFC7R0o3GwyshLry8KBrGGpl/NMshXGUdafmHQ541jxbq1C7uwPZqO8FmSSucD0z6G5v0k8J31QRAqRXQDbChouKuG/++7TvJ+KXVh1nzyt/f7UNjSCJPomaCrrdUI60ull17sz132v7OUh4OmLJSKt/JVtuEizEUpviIwg53MO9mPTntGuFYlA+NtchdsVGUbRovlhD6Tz7LcKemnEuYvitRRwE1CJczYqtpFqZ5O6H4gDsMKU4JA3DIFip9aS6qO/kijJZOxxdOY/LdryA7RAOGr8P1Xx0Pl12pDVdtWAH1pknpF3O37NisyqfAL62ADSePecISLdgAO5/znogTlIUqnvLGBcwARIJuRzRcRLLKqM2vQHam7GU14Cd/9Oew+iIo5VnGBEYDSXpW/Pbbmko3BaBPCL5aUtmBWN4ASUXJJ42RkghE3Cf3eO/BK3RvYGfIyXEImZBeHxkr85HdWTp7r0ko2gQUO86FJysOM4FhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(22082099003)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FZd3RhcU01cXA0YVBaN1Rra2oxK3VRRVlhRTZXcWw0bnRkTzJvZ0tBTTJ1?=
 =?utf-8?B?aVRVWFU5S2V2VzRrajFBRnVZbzRaTWwxV1JPS0t4MFZDQTlGd3RnUDZwZEsy?=
 =?utf-8?B?STZ3THNjUUttYnZEMCs2VkxVWFlFRzJ3OWR5a28xSjlsSWdnVWliL0hQWUxX?=
 =?utf-8?B?ZVRmQlQybWV5eEpjUVV4MkphMmZSUDYzNHRZdS9rSDdNRFRRZ2xYTTJ3S2hp?=
 =?utf-8?B?LzlsZW9rbzhuS2ppTkY3ZTR3SnBjU2xVV2tHVXpxS3VROTBUc3ErOTNNaWJh?=
 =?utf-8?B?bjVoWTJZeFcvSXFMd2RncGNtNmEybkRzNXdLdGVvUzZpSjZ5YWlKekJtRkFD?=
 =?utf-8?B?ZlhOaTBGMGtGcnR5U1NkUGFCS1lITWRGN0RESlRoVjNwWFQ1WGJVSHpyczhL?=
 =?utf-8?B?aHJ0RzhFclA1WEhtZmlYdWhyOWtSSzNHME9SNmY3ME10S1MrVTJLdXRPbk1J?=
 =?utf-8?B?RFB6N2xkV2tXLzFvZ2g0Q01mTWR5OVF2bXorY0xSNytNYUIwMG5FQ21QTHdk?=
 =?utf-8?B?dU1iOXB2VENacWxNQ2k1ZzVDS1NJbE1POEtDMVJMVDMrZzdCTlFDQWM0ay9i?=
 =?utf-8?B?bmxSUDNMV3kyL2gxN3Y1anZIeG5Udi9rdEQ4VmVXL05acGdJM1ErVVlxNHpX?=
 =?utf-8?B?T2ZCdnhKbnhDWHI1TWhuY25Scmx3em5URGNOVzFQQjRaa3Y2eGZ3SVJSMUVy?=
 =?utf-8?B?YzNYMmFySHd3b2VJbFRObHRQajY3MlZKOGt5dzUwYnF3RG1SQUM2c0d3cW9Z?=
 =?utf-8?B?RlFXeDk5V04zR2lqcWVPSGNrOGZIWGlpUDhIWkZCSjQ2R1Bob0JlbzFMd2Yr?=
 =?utf-8?B?TlZmV2UrKzR3NnN5S1ZvUHh0WHl6MW9LanJBaUh5UVgxK2hMQXJsQmZkR0Q4?=
 =?utf-8?B?QkdDdU42bjRWUGhNMkQrTnFJendRRnM5eTc5NWc2Sy9EUUI1UU1uNHZLd2pV?=
 =?utf-8?B?eFVMbWYzWE5IbnpRZzJwbTFBOGl6N0F3VTVBOVM3YnRURkhhRXJXei8wRTNp?=
 =?utf-8?B?eUVXdzVrdWlCOVFVOEEwLy8rZmlJamlyRlRpSmV2SE5SQUpLUzl1TG9PWXY5?=
 =?utf-8?B?MDZxdnBnamlTaG4xQ216NE45SHV4bG1vY0RmYks4dTV5VVJXZ04yN0QyTW05?=
 =?utf-8?B?WWZ1ekgyS1JxRHp4SVhpVlU4WGxyNS9ZZDNBTFB6WkxvQkVIK2Y3NlVYMVBU?=
 =?utf-8?B?OTZKYmR4QXBhZHlpMUpwQ0Nya1VqTXQxaVNKMnhzc0tSL0dDZXVTczltb1Qx?=
 =?utf-8?B?TUdvUVRZZzNJMVhWNHY3Lys0SzkvbzFVc1V1RzloMEpSeDVEd0l4UXhzcUh3?=
 =?utf-8?B?ZEdqOW81Q1gwbHhFL1dDOXFTak9NTUh4UEJ1REVlT3RHV0hVNXNsM29tT3lk?=
 =?utf-8?B?d2c4aGxVRzNZN1JsbEN4Mk5lYjFzYmtoYWRoeWo2V1JyaFVnb2QrMXpNWTc3?=
 =?utf-8?B?OGVNUmRXMGd5RkNWMzIwSFlTN2tqT1BtU2c0aXZVTVdXL0owNEVHWU85WVVW?=
 =?utf-8?B?MjNFOTNIMTlmbUIzSUZVWG1wZS9aUE5mNDdjdFUrMHEzQ3lkK0Nub2hDdTE2?=
 =?utf-8?B?YzloQ0V0TFk1UFNBbHNJaHR1MFkzRGh1b0tXTVJuY0FXSmZvbFJ5b3hyNUp5?=
 =?utf-8?B?UXhQcGRBTkFuVkY0dXlrTnk3eTZ3aVh5SDVBV3FFbk5sSm50c3NxWW4zWWtz?=
 =?utf-8?B?V21KemY5RmU4WTFNU2s3QmZENjRzMlhCbFRJdFdqa3Q5SjgzVHpBUGFCV3lq?=
 =?utf-8?B?d29Calh1SGhLUTFJdDRmOU9XYWk3TmJGeVp1K28xN0pRMXAxemhzaTJwUDlu?=
 =?utf-8?B?VVJZN3FxUk1xRDNDYkE4QVdIQXR2b0hubWtJTnJBNUg5S0o0c3F5ZTU0bjJK?=
 =?utf-8?B?ckZpaGI0Q3RtNjE5RlRSSHprc1pOdDBWTDJrRHdIM2xqbTE4VkNFNnFPWFRW?=
 =?utf-8?B?VjN3V3VwRTF0TGl5YU9kNFVtMllsSFMxbU56UTlqT0xwQnpaMzFTQytsNVUr?=
 =?utf-8?B?TElmWkNFQjhNYUMrRXlIeEVZc1NUWFRxZmJDRVlQY0lJdFJiLzU1aFF0YlhN?=
 =?utf-8?B?NjNURGpuc3o0SVJNc1FOa095WlduV09CRCtnYXI4UHBSb0J1NTE5eVgrcVNs?=
 =?utf-8?B?SVVYOGwrQzBmcWFtTzRkUCtYR1Jmcnc3K3NwRC9qRlBEcFkwK1laWGpXSWM4?=
 =?utf-8?B?ODRwNEVmTG52Vjg4cjdjcjJrZ1NTRStBS1RXN2x0aXZILzh6Uk1aWk40RDFs?=
 =?utf-8?B?WThtQUxHbmZuYnBxRkdhdkFtY0NzYjZJNmF4WUszNnBVMzFsQmJKL2lDVmh1?=
 =?utf-8?B?TU5TSUhuUXZqTDhPc3o2cHRlWGd6WmdkLysrOGtFMTRLQ2EvWnJUZkhDK0lF?=
 =?utf-8?Q?uDoGhAcSC4MhnfQrEY++cMN6ueJysr1qgJBLsNxb4goK3?=
X-MS-Exchange-AntiSpam-MessageData-1: 7Lx/tAa1WCwtnw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39941e11-6d3b-4ed3-4db9-08ded5da7a23
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:26.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4st0X7PnFRZiwDCYBxxUvY3XtPDyr/lmhkTC6IMihNpWeVYEk3Y2XLSOG6v35OaWqb0sfb2T+v6W/abP5uEDg==
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

By being in the TU102 HAL, we already know that the GSP boot method is
the SEC2 Booter, so the only variable is whether the FWSEC bootloader is
used or not. Since `Chipset` also includes the variants that boot FSP,
querying it for that information introduces a potential code path where
the chipset actually boots via FSP that the current code doesn't handle.

Turn the use of FWSEC bootloader into a property of the `Tu102` HAL, and
give GA102+ chipsets their own instance with that property set to
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
index 98b8756043f6..6a114f696c22 100644
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
@@ -163,7 +166,7 @@ fn run_fwsec_frts(
             },
         )?;
 
-        if chipset.needs_fwsec_bootloader() {
+        if self.needs_fwsec_bootloader {
             let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
             // Load and run the bootloader, which will load FWSEC-FRTS and run it.
             fwsec_frts_bl.run(dev, falcon, bar)?;
@@ -230,7 +233,7 @@ fn build_unload_bundle(
         // Load the FWSEC SB firmware, as well as its bootloader if required.
         let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, bios, FwsecCommand::Sb).and_then(
             |fwsec_sb| {
-                Ok(if chipset.needs_fwsec_bootloader() {
+                Ok(if self.needs_fwsec_bootloader {
                     FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
                 } else {
                     FwsecUnloadFirmware::WithoutBl(fwsec_sb)
@@ -333,5 +336,9 @@ fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -
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
2.54.0

