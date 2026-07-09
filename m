Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E613C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDBAF10F3C9;
	Thu,  9 Jul 2026 06:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jHMGpyjl";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010058.outbound.protection.outlook.com
 [40.93.198.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A56610F3B9
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRoIS0bzq08FRdxwMON4W/6GQEeDF25rAwAtTSWvxaib6ZCyslBj9JiwKMFixZwnMtiBL2j047ipIRgkGR6YY9+w03A6GHszoIO/b7oUenn2rM6ULPpkMWa3/mnjR2JY4AWbaF4Xe7BJjEcxdaA2trrJdiu+3h/UvvpmUOt4g5/4cPcb2bVifOle2aIqlfZPsYPhFVkKHXq45lZNRd9eaQ/4jlTZYDz28KipITW6xBXq0P9m0bCQKyxH9bOGnaJ55HI6t+FMXvKs3aP30SLyre20rrYudy5jbS5KJPZ5KbwFjnFplnSBRGE8Q9ulVaxVWuWOSUwafM511VR/mk3PaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLBp2FT0fBESRGyQeF16SeJnF+2CiWUrNSfif86Jg6c=;
 b=CWtJs6FO1n5wpqgaDkDbHUXwESUOOT/fIX30Lt+na3DSEsQNLdUHXQ5efBXVmjLI4W9DugsAP9zSPN6u7GDg8qcsyZLryNlKd9QSWxTbzWs8OcGycNxUdRZRZOVdjfXuTnK6803smJ5afW6mazo+iIwEOIedNJBqurFA0noJVXzEiHGfh67JSGv3Ei1sKa/el+wDam5cq0zA1SNNCIm91TREmte0LDAB0w3IWdSGFRuV7jc9Yyp2KqSZCuf9KPz4Zqe03xCw0z2TLWp8wmUBvQA9y/Dchh7k1rqqYB9xBzJZ2DMW9i8uXw4A4NqcHwQ7zIX1BVs1a9hs24ip1KRaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLBp2FT0fBESRGyQeF16SeJnF+2CiWUrNSfif86Jg6c=;
 b=jHMGpyjlZIJa8ZdMln/c/RYSl4Dq+2boeUIFOuypf3TboJ8+OEvKHU4/hKKWoZdyw4vT1mFxMgTHL9Y0UpNLGGGYfgn4S5CFE1Dy0yU6FMo/4hV/HtvpqDlSTreeefkjfgQwvf2IUgmrykS3Oebc409gLL5SkunnNNi2Tahj/VRpH/pWMIOHliTkUCTKG33kSjMKJ77o/jZ8jWbcCA2D7HyAsDH6DcSxMt/xngPHw2XgrHyynZ7oQrVx2IB6j0msI9H9otKs4Nmc1YXowqQaP3JDY2DUmWCn33dYtKBpO84FVz3y0uqMla3DwsVe2h7Rsuui6dzqRWlW5CVjDizoSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:57:07 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:57:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:53:01 +0900
Subject: [PATCH v6 08/13] gpu: nova-core: gsp: make use of FWSEC bootloader
 a property of the TU102 HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-8-520cbf8b9b50@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0076.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::12) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b143287-b27e-415e-2a7c-08dedd874a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xAYt3SfxGKQ0/bmerkyLJtjdn1XULbtsamRkU/qP1mUMiL9w+z/QhDdv4liPCUUN918T4U4RglgxnKiNV4HkgWAmPAwXZ34iX87SdCz6ZZfrwWji/wif2tbIqSihF4YKcw/zpt1SdVF2sfAvJqsxiriYDDv1H9ocVaqRY52uMtDDx4MJdrB0tJtEwgK1P9YjA88SdJA1XxA5oJ8uZSx4DT3iAld7siOhwRYx+S4vTXV2NB5RlNhkBYLTYu+NKjOqyvsDDxAaV9Bj64pxWPp+7a4istP4DKY/DEd39aF1CZ1Rmu3oHp0RWhef9GlgcXOcuVB2pbEzSiZWsg3hgUpKYpBIQjXNklVArOYDtiFVnBwwQXoQ1qCcWKCW49E3aBt4VE/wGVAyzMfJe9//9JiAXSxgTAsFs+AV+pXdFk4TQRhOao1SkRJWa9zXZld8Yj94uiSrjZSUzWgpNwGCJl81O1lZvGm9EoIlrf2JvnmIga16mbV2l8xxuwzsTfs1dyd1MqdfQlbYAw7BsF8fyXD5MT7ehAFTUOoYUlT1B7bA0r1WBkkE0BrfD8pmePVBm9/bww+DEMhEfpxRyy6ud062h38DaB0E7aoRby2YPowg56G3nSMQd6CB0Q27Orp0xOZHKYtmD+3MRfhV1d8utRKF6u7E3qGx9pFgpxyFiAW683MP0qpcaMFqnhkkdA4Qr73huPgRIhDoEtvDl6A6Tj4BCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9GMHVKYUhqVXJpSmJ4SE9BVGp1azBYZlZ2aHN6V0JXZDVlZVVQSzVTZWxm?=
 =?utf-8?B?c1JPUFl5Z1NjMmFFNUFaSmVEYzdINUFtNW5mZnY0T0RRODV5UEhycG1wajc2?=
 =?utf-8?B?b0lwU2V6V0RHTTlZd2NqQ2lobVI2amJLY0sxeTJnc3phelNMbUxOaDVpdW96?=
 =?utf-8?B?Njc4MU0yU3QyY2FjMHg2NnpUWUNDazJYQWw2OXF2eGlXK3RXSDQwb1RJM3B3?=
 =?utf-8?B?Qk9Fd0dFNi96N0dzdFpuTEUzVGJDa2FSRVpHbk9HT2xIMHZwZUZHQUxCUmxm?=
 =?utf-8?B?MVc2Q0RKTmIzb1liRmtmWi96NTdhZktwY0pnNjZ5SDhQVEZidm9jSEtSb2lK?=
 =?utf-8?B?TmlyaUFjcnRqbmtXZk5tNlEvSzY1Titkai9vZ241VW1ad1E1aEROb2MrRzh0?=
 =?utf-8?B?aGRlNnZkUWt2ZVJVdmRaNW5ic050MStKQ09mVXRGRFo0QlZPbU82YUd3L1FE?=
 =?utf-8?B?REpTMG4rN2k4UjJwd2hFN0xEaExyMnBPRlZvV0xJcFMxd1k2eFZrc3lZYmZh?=
 =?utf-8?B?ekt3M0cwQWJBY05VREVGQjFEais2eXQ5Ny9DaEJ5NXRkOS9pb3d2Y2VSYmdG?=
 =?utf-8?B?cFkyL2YzZFViZXBiQnJGSlF6UHY1eHBVQldSNXluVHBmZ0N1K0YwaWRzYnRh?=
 =?utf-8?B?TTNTblBQQnRwSUJQcGhKVDM1V3E0cW5uMTBjWXQ3VDlia1NMc0lONnE0RnVH?=
 =?utf-8?B?NmdjT3hoR1k3U3A4elRUeGtOQUJRWTlJa2pOTlFOQllMVlh2bDlhdlJHekxt?=
 =?utf-8?B?dmNMaFJHNWp2ZnI5N3NBdUsxNmVmdUFSVndHMVNja1VsL3E5alliUjFlTkRu?=
 =?utf-8?B?MFNnUHV0bUVIdnVock1Pb0Iva2RTRVpieGE1R0pES2NjOHdnMUJ5blQvTXhN?=
 =?utf-8?B?bEs0cUZ4MUl5d3ZqM3laMVhKQUdicTE0ZUw2NTNnNytobVZMVHA0N0lNQ1Fv?=
 =?utf-8?B?NmFPOW42TlVORHFQaUVVakFPbWROQk9GUXJTRU5rV3FqRFlGclc2TTdGakt1?=
 =?utf-8?B?UGx1RWE0OW5rRWtRVllrSGFGTC9ZcVpUeVAzMGRnb2RmOVJHWVJoeTBWODhL?=
 =?utf-8?B?eDY2Rng5SWFoNWNwMURCZ3BvSVNDNlg2d3BCZENiMk9oWENRNytnQVdPK3Uz?=
 =?utf-8?B?bnpPMmJ4NTBxdVZmZzJGbFhUMUNZdXZMUUFRMkFVK0RxN2t0K1FtR2lSQXNn?=
 =?utf-8?B?RGp2ZXVRZ1ZvMkI5d09Yblh2c1lCdEgyYldBVHMxaWhVb0pZRTF0L0dReFZr?=
 =?utf-8?B?U3FIRkoxUmx0WHF4dmN5K3IvMnJnY1hqdVB2VFlhVEdkTHk1VDQyblZoMU1p?=
 =?utf-8?B?MlNndGY4ZEhkR3lwRWtCRzJUYyt0enRiVzdSNjJ2WGJUNDJQTHUzY3RndHp5?=
 =?utf-8?B?eEV3M3JHVmY0eHVESkxvUWpnSDJ0TXpqN3pqK0NUalIrdlJuMlB4RTNScjNa?=
 =?utf-8?B?SU1hbjhKd2tjTHFEaVhWb3lwUjVzTFBibmxHUDU2RnliS25aYkZqMFJiS2ll?=
 =?utf-8?B?bVAxN2Yrc0hqeEw1UnZYeElHUllBTVRjN0hnV3dhZS9xdEFJeU9JbXNITURG?=
 =?utf-8?B?azNiZHV4SzZMMlI2dGUwTXd0dXpqVmVRU01GeVJmZ1ptV0VwOWFnRm56VkM4?=
 =?utf-8?B?QjhGWU50Uk5WTHN0b0JjOFdPRE9xTERvZ2pZM0lkcGFuOE1RZWU1czJPZEtr?=
 =?utf-8?B?SXM1ektlYUVYRU8rb3NZNzRoYU1YYnZ3aFBINFh3bmRjS2dVS3FhUk1Ic0xC?=
 =?utf-8?B?UTA3UUhQZ3I2V0ZKdy9aQ1lsSXU2dTB2am1GaGh4U1ZkUzdhMlRWOFd5SlpS?=
 =?utf-8?B?TUpNb25DWFVWZDBMVjVpbGE0RUx6c3FKQ1k2S1JGRFFMb2h0eXFGaWFCM3da?=
 =?utf-8?B?ZUZ2ZjFVVUlBKytNUmdseEg5NjlmVVBBL2ZRSUkvekkzN05jSjc5eUpvZHVS?=
 =?utf-8?B?UnEvUnZzTDY1eXNkZmQyNDJwR2tBTy9RaGpMZGp2Q0VGT0hBejQ2NXlVMDFm?=
 =?utf-8?B?QlBqQWJBR2oxUkJqVE0ybUUzUUNIclJvTFJ6NC9JWVZrdFE3WGR6RzlhU2FR?=
 =?utf-8?B?U0V4OGRrWDVCcXozSkwrK3N1aXBVTTBnd3c3UzlvZjVHSzg3Uk9jM0F0VFkr?=
 =?utf-8?B?blpMYjNxdlRidEsxNEZnN005TXNxQzFubjg2SE9HMmF4QkJSVWM5dlk5ck04?=
 =?utf-8?B?eUVEU0ZrTWJHVU5JNmpxazI0YWZreHpjRnFQaE8wS2xnT05ZUmhuOXMzS3BS?=
 =?utf-8?B?Y1AxakJsbWg1T2JzODlYaGt0cWxYRzZiN0FUK2cyMlNXY1J6aVcvL0pxcnlp?=
 =?utf-8?B?WGNNWnl4TW0rVC9mT0JQTDlLeXJ2RENwekd5QnJSb3VqMWlNZ09Ca2c3dVJa?=
 =?utf-8?Q?W0iagK9Mt+Bva1cveaqIO33kQH1hQlAPkEZDDk6jPpqLm?=
X-MS-Exchange-AntiSpam-MessageData-1: sMmW0RYJPqFOyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b143287-b27e-415e-2a7c-08dedd874a38
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:57:06.9867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACbwHtJ4dZa6DyT03fJXLsvwlbijr2K05zziDPp7rMyvhhH54p8GRsmFka9Ti+TNIXt6rl9FtlSIwuKyu2YshA==
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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
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

