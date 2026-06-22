Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED03CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9C310E4E8;
	Mon, 22 Jun 2026 07:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iBzj2Kua";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F9110E4E7
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlCSRThjNjGkS9+UhOR4LpuJYlMccIAuvAPZmVit9WOgSNfHyKYJJnoYWfvfJy+p9EuQ+VQiWy//O+dcb9bBW/WX0UqdmjQ0kXEMPCODF80n+IhrcN50tk6/4lXfN6liDWxoG/iJMBZiiNh20KD6PUPLm9gNYsDX1DnswvCLEP0WcaploehNCgTFd/HO+G83jit6a2KwniGQ9SUWlcDw06zM8+/3eFI5j1K31GonqcewDzFwkIDk3d1Av+/WQeJo91J9tGYJLvuDiebzIQU5FHV+inkINd8byr8DRuZ/Qpu+p7Hkq+TaRZLQB+e+8Pduw15d7bvyJCxrF2Gw7uFKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLGJ66tshykjjK5RuyAHtbL8qAIlQx+al2pYr880zDQ=;
 b=J3iOSSF6xUBnrJVnUSzhZ2jkLE0Cfp8VAxg9rjweA36yaee9xXpd3lmUIPD7DHWT13Dxlr55SYTsJ3I9TolGX/hpROpP1iUImx4mykPKLIHyTdPcc16gNKxsjyIAgk2Dlzp/BnbZlT3hg12De4eBIhP9VzHgNQE3nX+gpuRnOf5HWhQo6COhQCh0sn3hmT7G78nbP+8C96uG5jxAFyk8N5tlU3hz9N9d57Cejnfx1wj6NMKIyr8tvWfMRlSqEZgknSReHIsMxxEifgaSLH8nE59FXWtyu9qaZQP428/KWg962oAkeJPS9PwG+bZw4nN0fr2AM+4CREU/oAFtfnx+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLGJ66tshykjjK5RuyAHtbL8qAIlQx+al2pYr880zDQ=;
 b=iBzj2KuadbDtO4hQurCkjmZxnak2CSP7mNndKTPj7yvkW9WH7dzS7KJbfg5G0UWeFMX5hqPkDLsUVM+gY/tApeypD28xbLHh2HykCcfv6VfY+b85CcB2kxyZ5sI7HfKgAyQG3GsSqR22IP+vJIdjoWX9PoZtdwUlsXO3gjA3N+0HNgGoQEeWPa6Ru2mmyFWfuCAHYlfXEpLNmuoCNl6F1sg2XAY0MCtfSuGZl5qkaeQwUrucbGxkjsTCNaFWh2e8XNp0hVBZMR02avD2w0mkeTMul9LnEJUKRmd3W8Ymz7ViMx8NvD8b3w4WZoMEOuopPcRVtjUNY0wc0CIwFcGbFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:12:01 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:12:01 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:31 +0900
Subject: [PATCH v2 09/13] gpu: nova-core: gsp: make use of FWSEC bootloader
 a property of the TU102 HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-9-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
In-Reply-To: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0104.jpnprd01.prod.outlook.com
 (2603:1096:405:378::9) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1063e7ac-63fb-4084-fe28-08ded02d8da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: q0kq8Jd7rKCKUMjwSFxDLpCqgCWhDiCtKMmGtm3cUYs4dmp7nYMtmDRD+oOlTVzdgzdXWV8ewe9btmfeaBmlHG5HHsLz2gv29Xe0L7WEB85BL/2uAnm/CxnwKr5jYFh8Tt03ax36AAx596LZMqU9y694YasJHeW7KAtjW9VAHgqSi2ha932J+SqcUO3CC7WMqPnEKJqwXUozVAaJX1aGKlWJUSQCgkQmY7EzYpWBrH+Mf503sAkV91XHFmQR2MrvS4P+dkPWME9R63TybsV3i65hLyiEN95kN208oMBHkh16lEHIZl+bfBKHtPPV04pyxTQRqLoMTh4wxnlmYWtpR1CZZGEbRHkDHmjLHtvfcmtNgFcERKl055AzeifdDS1j/KZ/eqCX42CrgGOlIjAT03ocmrIcZF9u8RsY46VHHzLJTL40iTCxD+gxMh/Ea4F7wQW6ptF6uAPew8EPjc/1Bl7Mq4a1xL/On8ImPEKP7zeeJd0VTebHmSwpDRbJfHN4/mU924cCejE1xvssE5EJR+VCdxpSm6FnfFcq7r5snktJOrCkA4gdATU8McWIR0FzhX7gpOc/zrCqFbtv0v7jnqTKpkwnCzXWxTd5OzQ0P9vsJ7LU3NgMbyiyOy3C0l2xq4iDmsbk6e1geYM+l32CCysm7/R8s0hFIjob8S7wOjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXB1RFBmcTFnazcwN2ptWndpdTN6MHFlQjd0UGhCNGRrYUR4eWpFRVV3V2VL?=
 =?utf-8?B?bTFZMlhhbmhTNitsMXdwdXgzQmJKVFppOXdRRXBqQ3o4c0t1bE5YVDNBbDZu?=
 =?utf-8?B?TWRoUUptRWVzbXJ1U2JrbHhmbHluc2VxZ2hscHp3RUFOMWpnVTVqNFl5VHA3?=
 =?utf-8?B?UlZLTjZES1BhR3NheUpFbDBneEFnT1l2RFVmbUxnRGpoNnhHWmlJV0JMd1Ri?=
 =?utf-8?B?ZnNlcVRQUUMrTWc2RzV0VzZoeEk5RmdXL0psRHJXbjZYbkhFZjYyUWtlb0pU?=
 =?utf-8?B?OFNxbmFoQ1luQmVSZUJzRGNEaW9VcE9zMFBtbktKSFhEZCsxb245YXJpM25i?=
 =?utf-8?B?VVdkYmdtTTNLSUMwMEN1bnFTQVNtLzRUcFMxUzFtU0dZak9HNXFHTW9BZFg0?=
 =?utf-8?B?TDJ6SHlQU3VsVDY5OFI2MUNqSFdnNGhCTExLQk1oRkxGVk13eDBPRTFUYVR6?=
 =?utf-8?B?TzROay9Cc0VQbzNtSzZDS0pidTMvYm4yWkhWaWVOeHM0VllMbHV5SVh0VWpx?=
 =?utf-8?B?aDd1OWE2bkRXTmFhUTZmZmZ5SlFNNW9GT0FXNDdmVXZIalh0L0RFdElvc3N6?=
 =?utf-8?B?cmxvNUFCU2NkODBPRnlGTDFyVXFjZ1JZbWZJamh2RHpaeVBFN0tXZCtSajI0?=
 =?utf-8?B?Qys1cFBzRVdtMUZURHRnZ1FPZ05xUHlTWHhtZjFCVnozK0h3WDFVM3V3S2RZ?=
 =?utf-8?B?UWp4UHluUko0YnNmSW1pazBOcW8xNU85TjZlWEs1NHY2Z0lwaGkydFlOam5Q?=
 =?utf-8?B?WHZ6dnVJYnhueEQ2dU5ucHZVdndBWTkxZVpqYndsaDBFM29INXA4Z1grVWFk?=
 =?utf-8?B?bjZwSmV3U202V1RVTmladG5MN3IrS2tiZk9HNUdGMFdpc1BxTEdsRzcyQzNS?=
 =?utf-8?B?WjhZYUlHQmQ1dVQyYXlRMzAzMllaMVM0eVdZZlZ3K0tHZUZwYVpreWJZMFlo?=
 =?utf-8?B?TUxYMGRIdXQ4NFVVNXFBR1JQZ29UdVJwZG9sd2JJb2NyVWw4SForYjNEd0k3?=
 =?utf-8?B?MjUzTVdyUXpjYnE4QURLTEdFQU50TlBSd1czeisrMmJYM2sySlo0MCtEYU5U?=
 =?utf-8?B?Y3lSWENJWmprMUhEZGVWNmNZdFF3TXRPbXlpeXdSdlNyTjA2U1FpSmIzTlpN?=
 =?utf-8?B?b0gyZjVrdGpjUmJUUU9kdXRWNjdTNk9IOTMrVU5BbUYzUVpKekRKVnZIZUJt?=
 =?utf-8?B?cktyV2VqQXIyVVo1Y3JoU3UvQldYcnV4dzhFd3VYRk1iYkhDQ1p5dmwvczZI?=
 =?utf-8?B?WkRBZVB3QXppYjhBdlMvNFJiaTQzaXAvQXErNGZMQldJaERJejFORVBKOFRP?=
 =?utf-8?B?VFZwVHQydEQrUmdsMkNzbXFCY0FLN3Bmd2NoV3g5aHozdVl5TWNINXZGYzMz?=
 =?utf-8?B?ZWdHQUpyYUhRYk1QUmhtSUlCVXJDSnNuWmFDeWNjU3NuSC9yeHVqTFlINzF3?=
 =?utf-8?B?Y09FVmNyRFBvM3Rkc0lyNWo3ekVTQSt0ejY4V0RIay92Y3JhT2MwTEhWZS9Y?=
 =?utf-8?B?YnlQTnlvcEx5NDU5V01DTlVzZGtZSWRuSFZFUHM0MXo2N0VPandzS0pRSGl4?=
 =?utf-8?B?RlZwR1dyREJNK3VUNGtZQ1IrdFJralBRTW8yLzl3ZjdwQTBIM25HYzRlK0Fo?=
 =?utf-8?B?NDgxc1Q2dG5ocGszNG40RW9IbGNsMnZ5OHlnZitWZnErLzBxWXRvNFIvNXQv?=
 =?utf-8?B?c3J1VmlYRzVJTVhDZkhNRkdraklldFZIRnJoNTJXNzB4TkdDUU04NHdoRlZZ?=
 =?utf-8?B?Rk5CSXJLejNYRnc1eWJ3Yk1jbWVWMzdYdmp3V2JESm9LVkszOUw4dm51TmtY?=
 =?utf-8?B?TlNGall2Q3kvTklaVHZBMFdYbG1hUFdqY2FpWkUxWWFWc2Q3d2dOZXVOOU9P?=
 =?utf-8?B?Z216SUY0MisxaWQ0WXBFWjNpYjRLMFN1bk9vNHY5TklhRXQ3YXJYdjJpZHRu?=
 =?utf-8?B?TnMxN0hjZWdVYWdIZnpubTRvVHZjdzJaMGpQTERjRWNUbVVDSk5UeU9KOEM0?=
 =?utf-8?B?Mys1WVlyb2pnWU4ya3J6blljTzZYczQySFAyUEV5dFBwVHFsTWd4YWJRbjhF?=
 =?utf-8?B?aWxOYmNuRUNoUG53SllNOW1aR3BRcFlhWm0rVWxKNGE2aTNuZFNwNDJmcGFz?=
 =?utf-8?B?WjhWaW1RTlE4cEpGdk14bEZHWHRZN3JUTmNyeHZEWTR4clhaaHUvY1ZydE0z?=
 =?utf-8?B?WERSRzZHb1U3RnROcTdaUks4U1g0MENUTjhyMUJZTGZ4V2FIT1M4ZzRWRjZZ?=
 =?utf-8?B?enV5K3JuMy9MdDJNVE1jd1dkVnUwcGZqdU8zcktpdExVcTJ0ZFE4M0owQllx?=
 =?utf-8?B?b3FBbjZDNnlhNXpPRm9vVlJ5SytkMFJBWXNNeklGNWdUV3RRNG9WZjdIUEIr?=
 =?utf-8?Q?oTMw9WajzYiDioIiUIINHsxuvj0EmDtvYFEdXZXW833I3?=
X-MS-Exchange-AntiSpam-MessageData-1: sn526xPjijXE4w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1063e7ac-63fb-4084-fe28-08ded02d8da6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:12:01.1987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZqB86Oo9gMksocgQmdY/IMMslM/1OxFSikBzZ9ilzsQXrOCadlNM1LkgsMDrhqPgBG150kU5m6gTlKxuHCN1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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
give Ampere chipsets their own instance with that property set to
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
index 113d445239b9..ae4c44aeddaa 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+mod ga102;
 mod gh100;
 mod tu102;
 
@@ -66,7 +67,9 @@ fn post_boot(&self, _gsp: &Gsp, _ctx: &GspBootContext<'_>, _gsp_fw: &GspFirmware
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
index fb0fc99b492b..8e732f540af2 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -126,7 +126,10 @@ fn run(&self, ctx: &GspBootContext<'_>) -> Result {
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
@@ -229,7 +232,7 @@ fn build_unload_bundle(
         // Load the FWSEC SB firmware, as well as its bootloader if required.
         let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, bios, FwsecCommand::Sb).and_then(
             |fwsec_sb| {
-                Ok(if chipset.needs_fwsec_bootloader() {
+                Ok(if self.needs_fwsec_bootloader {
                     FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
                 } else {
                     FwsecUnloadFirmware::WithoutBl(fwsec_sb)
@@ -327,5 +330,9 @@ fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -
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

