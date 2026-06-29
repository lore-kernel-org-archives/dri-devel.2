Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A88BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE00B10E912;
	Mon, 29 Jun 2026 14:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GcjONnQK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F1410E912
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfvKrtzumcqKIrkf85JRhSStiAxxP116sewTQ6zMS2d8KCe838Hjk9qRLgvlARUarmODpMOWrG4Vlzoq2Ns6T4oeAfUk7I54jSKHW6cmunI9Tb2UrTU6OMBVlOj0wdCQ7fMIBwiofLwuRd6rYYgUa6rCf89qLjn7dHg0PJHGkszAycuQ4F+A+HNuf7GImG2pdZO57vuDD2dNSFv/LxzU7ZXh6E8C4qto4USJExz1l3HeBBfNrj/hcl4pRnrP+1E9fkuyUTOL2+y9RSrqojVhsZs9TCqlhwhDvsI8hxZ7DbUutJobvp7C1PA3Ei5aQoSV9xmzn6u6FvTFLsLQ/ML1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLZ/jd/9kGtUnTglezGWbBIWygWmNTCVRqCYWEZNnFw=;
 b=nKkHJFrbs/ROTJNWRUfG9IDob8u5h7McV8uVnpLEw5edOM/shsVrKf7AS2Ttb8X2toi9URq5D3cdy3o5avE6FgCyM8XpE56VLprRLEaVLkgbHbDkc+bQQAuiNBH6/y6E7yWaQqTh/MDLeXZonhPjLKqM/lOghEG2LAkZszDjiaW+ZZ1txusI0z3cSWLEtI/jmGWud2wSZBENzebtKtUH5Ee8b2Gd73UM7f7dU4+tDQEYhEtzzDBFRjtQp2cpPswp9meanR/n+cKSKzC2yyF2lA0qqxKRYAizQbh3OQrkm/Dm4ydu58repUHE1bX8xhds6XC2V4zcmHp6CBJQLARgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLZ/jd/9kGtUnTglezGWbBIWygWmNTCVRqCYWEZNnFw=;
 b=GcjONnQKgyZVTzrzNyzZYy1dsF3MQW5UiobVhfMq/LfpWC1PZ7hGqJrw+kbNIf6c9clrnxt3ElVlbYhOyhhihv9p4ncDNqPlSt8wRPG7/JY4P+UWEvblMZi/47BKN7S0gjs+y5eKt9Yv/vQBeXjNLoOUL451E2jUmq5+5owq5zLDD8/uD4mtUqkiZ54lPJ4t6z6c/0DlpOyBAQ/KHQ93iIcXPcB9HdKUf/xak6APG+wOZN30fl4TuuhOOv5pu6KR2mMgPKtZVwkQikeoRQVupwaG+IzNV54/SfKKVsB717iNOrb1CXI4ieWbnzUAMTJ8mn0uXDOTceFx6PYZebmrGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:18 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:40 +0900
Subject: [PATCH v4 08/13] gpu: nova-core: gsp: make use of FWSEC bootloader
 a property of the TU102 HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-8-5539d8469590@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:604:24e::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 247f97eb-b44e-4dcc-e048-08ded5e82604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: i4lT6pjzyAroCC9ndX+j87LmbeRizavb5EtE9PpAafZOWatH6QmoDfO2lmuYfQYbrkUPxUv4E6FzWZt5k+N9JtzbZBSm9yJnhdAtKyZADc4xLsY71cxSvkaGVBv4rgmlOleRr8MMYph281029FnnU1dFUqCiSUEsRQXaVm+K96Ua0P70Xywk7fMtugpHqN+2V8cL1IxkEKUIm2P8u6vJCt6ruM6QK5rMlvKLtT8E/eGsr0pvnmZK4TyUyF3Bhjujs7GLtBYr4fhbz0EfqXNH9NhV/OxzRRykz+0rD8pVHOIRdY4voinKEKDEeXKE3PGgIgPd+v4IB3fhdsOOxkHqjr8JW+z2rjyiRi01cfcgojNIRu7ZeoWuioCvZ8Y3eqnA/nVIapWg5BvUUaFpWZ/bLcDUUl77hQSG5H4rM5+c70kPP8bisXrcGoW4o7ZRNKQxaEPCQzxXipbqU4dIT6MrCVvzBeztoqtuQ5GdGW0IkG3V5Jq9QXCNfpe7JbaP4sHAOIhPy8/r+8Oc4mOI2ezMmHxeON9I2XWB7ACpdb+POuDGnGI3WbR1BbcLXB0Mhp6jGA/v/dTZq9QVPJCjBGrnVy4LDXfxAFm7PF7vrXZIg0RO9jD6NXc0MVRYvYNcLG3B+TvP5s4XBoHgUiim5fQ6wnVCe0/u3dJayliUKcGHdItkgLh1hg6lmx6xUFtVfprBaQa5G9+3zpoEcRLP6Hduyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW1RSXpQcmRCUE5TSlFPV3AvYmo2NFdwUDdlSFZtNXpLYUtlZzdDSzFleUVl?=
 =?utf-8?B?TDQ1ZHU5Zm1mRDlNbXJjN1ErMXAvdzlaSW14YmhnRitkRDYreTNvMG96dERq?=
 =?utf-8?B?aHVuV3liTGNQVnJ3cXcydmxKNUcrZ2orcHdic1pGc2gzb2QwSDdMckxIRTdQ?=
 =?utf-8?B?Tmh3WlNBVXJSaGR2U2ErTUhhUGZpN3dkOWx5N0dYUmJGREpnWm93cEZHaW43?=
 =?utf-8?B?dVRhR2RtR0ErSlp5RytzQVFmcmszZXlaT3p2OU9OL05YZEtGaUltUkIrNnlk?=
 =?utf-8?B?Y044TERCRk5WbmdCUlZ1YkQwbS9GWEJwOU5pTHBtcjcreEYrMG5NU1RyeWd4?=
 =?utf-8?B?M0d5VSttSUk5aGRKVFJPK3JRaDE3aUN6dFdtTGNLYmxRcHdXUndqakVNVmFW?=
 =?utf-8?B?cTlqM0NUaXF4V2J1cDBYU1lTdEhYRklwdHI2RmpXcFBLWG5wc0d3Mkp5cnFS?=
 =?utf-8?B?b3EycFZxYVFldklKMy9ZN0U2alZiWlkzbDdHU2NrODkzL2ljeWwrNE9aRklu?=
 =?utf-8?B?R3ZqYlU2U0FZa0V0b3hwTk83YWIwamZtNXpabXBjSzBtUVE4TFZ3dnVlbFZL?=
 =?utf-8?B?MHhjcXZ6OEpleUxlWEtGVjFVM1pGOTQvY3FRWHdwaWhzdzhCN1BQeEtkcm9n?=
 =?utf-8?B?TEVacU9GRnNpKzNReW5TQmhVRncxaXhHd1dkSFcrckJYNTYxWEUxVHZXbWlW?=
 =?utf-8?B?Y1JaNXoxM0k3NTlKVy9RUUUrdjFlaTVzbHJ0R3FrMUhBR2NhZUtwd1NmWkJl?=
 =?utf-8?B?enZLaUdQQmRVa2NPUlQ2aDhLZitqakZ3bzZOb2VVWnFNbXhSQzBNV05mL0dQ?=
 =?utf-8?B?Y3VJU0Q4M0puNWdyVm1ZOTAxSGRsbmQ3RTJlSThDQTN3TEpDYTFBTGRDV25u?=
 =?utf-8?B?MnhZUjhMU2Q3VHAxZ1VlUnVPVWJmYjFQL3J4S0FOV2dEVG41SGwwSDFWREVr?=
 =?utf-8?B?Qi9FczRaYVFkRmVIMHpxazlPeVBsWk9FTnk0TzkyQlNJNFZIUDI1ZlhFNHh0?=
 =?utf-8?B?dHN0R2xja01QLzVncTQ5WC96V0NXWGVCd1dXVjBsN0JPSFBaY3ZsT0tySjlz?=
 =?utf-8?B?RVpXQVlPVysvMkZsRE5YeTV6ejZzd3BGVkUvdmVCbHZXbjVXR2F3UDM0ZzNZ?=
 =?utf-8?B?cW0vRmNINmNtc0podmZ6ajF1QTV6TDNYY2dwdG43WXliRUgxRUtQcTZtTlUy?=
 =?utf-8?B?OFRWVU85U0xIeDI1ci9YeWZoeFJFdFdSUVJMVS9nU000NzFCdnExYXNOZ05M?=
 =?utf-8?B?SklSNUMybXlOU1NhWFB0VnFDMzF6Qk9reEpwVW5qbmVpNWVuT2JqdmR6Tkxv?=
 =?utf-8?B?eTB6MUdVK2poeUkyTmRraCtubVVLRWFLZlBGZE5TOEJYZmM5K2o0b3pMWHM0?=
 =?utf-8?B?WW1vc242SlJWekxBd1R3Q3hKazM0SnpZNWt2YjhSREw3RytLbFdOSFgzOUpB?=
 =?utf-8?B?NVA1dXZlYllFMjZvajN3WFpJY21lTmpBdmJNdkRKVDNPcVRhT2h2UU9ObEE5?=
 =?utf-8?B?a2NrNy96UWpPZGxYbU13bjVqemVERnZkY2hncm1SeWxFd3VQSytjK2lZVk5D?=
 =?utf-8?B?NG9rU3ZyRStUdVV6UFl3azgvWDlPcHlVL1B3OGdodm1pZlVyTjVBcitkbVNC?=
 =?utf-8?B?b2NvbE5vNFpURGlPWjNzZ0FIS2VMOWxHUnAxYU01YUxzdzljYVQ1cVNXakZH?=
 =?utf-8?B?WStDcjVUOExJNjhCTDRpU0N1TjRMWTd5TFdaSkhhR3BkTklEbGRhWmU0bkJP?=
 =?utf-8?B?MGo0aE1Ya0lCUWpnWnEySUNHUURJVi9oQm5vSnEvRHhZVlExd01WRVMwVHB3?=
 =?utf-8?B?STJhRWhudU9aQk9WaFpITThRRGlZcHd5dWx4VEF5c2FZN00vLzdiWmgvRmoy?=
 =?utf-8?B?RmFOSjJkSWFlSWFMZlRCSWFVOWV1Q1pEem1xK1hZeTZ0YkpQMWtqYm9PaXN2?=
 =?utf-8?B?ODhaeEd3Rk9BdmU1aVdUazR4UFErQ1hLR0c2S2hZaENuMC9nVkVya0E3WUtt?=
 =?utf-8?B?MEpCVnpNOUQ1UE9sVXpac0JKNTZ6R0tSdTBxTnI1bVVZNitYYllBc1hDTVpD?=
 =?utf-8?B?MDZ2MUhjazl0NzdRbWRKUmQwSFZZQW9ScEZ4My9jY3NZSVRYM0RHa25aa3Z0?=
 =?utf-8?B?S2dlZUdCQVVPaVg2Y29JZGQvdHVBaE5HekQ2TmVPN3FoZ2VRb2k3R2lZd3Z4?=
 =?utf-8?B?MW52ZVBzOTRmOHJ0NDVVdVhtais4SG5DSmVNOC9UaVBnaWlaN0QrTUpCQnZr?=
 =?utf-8?B?dDl4YjFRMG1rL3BiekFKdTdCLzIvT0Q2NzZQOEdxM2VrZUVtRXI4SFlmR2RP?=
 =?utf-8?B?YmE1b1hqaSsxczVyTU5DL1lSaUdrKy9tcjMyc0ZKdTJ4MmVzOERBY3p4b2Rt?=
 =?utf-8?Q?1OmhJ/wy2Oo55H4XSjuWfOLa88Vrjir1iraYm5WvvjsdX?=
X-MS-Exchange-AntiSpam-MessageData-1: miXdQs1B3bsFTw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247f97eb-b44e-4dcc-e048-08ded5e82604
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:18.1661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRhnwjKgSLZX85GjA3HzhaVX3m9dfTuoyuE6+KojRxphSLlvZUSF8UCMSD1MCgticSHzaNLY1w+MBuLl4i9NnA==
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
index df3d773bd354..68274367c70d 100644
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
@@ -228,7 +231,7 @@ fn build_unload_bundle(
         // Load the FWSEC SB firmware, as well as its bootloader if required.
         let fwsec_sb =
             FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb).and_then(|fwsec_sb| {
-                Ok(if chipset.needs_fwsec_bootloader() {
+                Ok(if self.needs_fwsec_bootloader {
                     FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
                 } else {
                     FwsecUnloadFirmware::WithoutBl(fwsec_sb)
@@ -325,5 +328,9 @@ fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -
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

