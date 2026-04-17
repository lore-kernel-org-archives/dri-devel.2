Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE99F436B8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E4A10EA7C;
	Fri, 17 Apr 2026 15:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bWssCTHA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9116D10EA7C
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLDDQ5S886n6ztso8KfkCGxucXN+YpsYcsi4wtQO5sVyOTB7VVwDr/6JS/LBbgih1buTg3EGmbE+xc6zOSmGeGubR5Ksiuw1WFiiIw+9qREt4+AZhFZzrQB/0grF4EFa4haw0KMBeXh5JfVvD6V9W85k3De3pl2E2N1g3CgVn1Hl/5Sd4GtwHQc3c42XVoX6FS/KPriwFGpYWBAQR/badRBvjOz/HixJ54OV/BH4Y3U17UBdh8tnOXzEgbkfLq723tC5SDOBd5tKgB3449k0//j3729GunSE4/w1zwxFscglc6RZb6W0Lz551eTHwtPpO6UbJdoYnFUe97uVYL0XKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkOra6zC8Uvl4Y/q7ktlCTsZwxeEUukVraS3BUrAG/k=;
 b=a6AuhJz3IYztBZS3RjjaWCHzj5WxCekao7/K2CDuC65KtzkJNPVoFdaW9Hkd6wCShhXSu0lXeZDCjGGEUPHA4ZFH7h9bGzPMDLsMZQ1bOxLQkAvIqlk6ukHbC1GgbSdZRqOSffaki9caPrw1dQN70St04HEeQJd/ktZLM4Ws1rE2vtVpxRdN/2Hl3/33g3rDuOS7Ly8gFCP0hPvtMvADibmh/EeCfMe9k9d1JVyCY1FXSZoDOIgI7bhjfYH24cIWG7mg0uAdLuvQEvkYeR/odqrgXHUEO4Zh6YKdlCU5QG/GvPKMXZCfUnRWVBHLc+8KonxgTVGDHg8wAjbXPYJycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkOra6zC8Uvl4Y/q7ktlCTsZwxeEUukVraS3BUrAG/k=;
 b=bWssCTHA+P28ij0w8eQJUiZdVa6tNda0RKZxxmyzTKILJ/G+HDI7yY5NO+TuamBqa0fMjVm957Ns2Gk2D5YD/8tlS/HOXruTsuZ5mxW+J8PDNuLMwGLLObP0wnbiRe6e1lltRemaRli72jUx5h1+sjCoUV0jb76i38n6EYbzff7xfmcbzaZNa07SWvtESEbmALy0zRzlWRLkcyjAndNb0p9x6P19rKuLj1jTuzLYFlZm3ZrHgjhQfra1WChsl6U3RTh6p/Yev8Oqj8g2Uz2rJh9AvDnHTL9lfVtLb9BwYLIsi2bNFStzEUc0Zv6UrICveBWN6G/no+KzhEA5tVMJHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:33:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:33:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Sat, 18 Apr 2026 00:29:24 +0900
Subject: [PATCH v4 6/8] gpu: nova-core: gsp: add types for RM control RPCs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-rmcontrol-v4-6-fda8c76dbb95@nvidia.com>
References: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
In-Reply-To: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: DS7PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::32) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d72bdb0-66f3-44b3-be75-08de9c96bc2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: R6Z7HGtJl4Z2Y0ywC8PbVpaCjg5zZg0fDMh9wrpnMDN+FZQm6lxbYbpbAVGooZPxOkGKYZrhfJEnV5xOdkFfjFa6qRAwHQ5e7GSt6ZKg6LADajPN/lR+WAinLZWx0okYZ/BjPvKuWVov8yeUyJSOfZMOWEPhh7WM+dY/NzNIm54N5UexOwrjJszlIBMwiw3vJKCxJWTmrC18nR0h/N6Q6OjGgFZDVJywMYSqPyOjcqlEeznG+g4kis21AGjjBcTgYe65IFZYfZTWXZ05dJKwnbgP6+iyfEq76oo0MNGOuZhJRvp/NqOgbXPiE4Ns608zmJjDuzvhtkEgeOyxANjIH7mL37GmLK3136a/qBNAurbqYUdOi6glkc4fDRH6bZ9ZVCmcp/nqrRqA0JM1/GQ2J0UAeZf8qW7bLLqYmhJNAZyF0kJci6yWdf/0Xhsx3syJZAcA7EPhS2FHTkMqYTsngR34hr3PP/HwjAdIYPqoLmGSMpF1yhrBwT/0XhwsHhnP/SrUgXhAtuurT81Ua6VRd//UFMCLLiXJrHSm9omg6l3i8yBnO5FviGPjvlG32C0IfZe33BfxmlNVbUo1QtWPvaEkkocP72E0eSscrpOpsoxqwKG2TQMqA42MabPg4qk15ipBym1zYNnDjKSMZCDzCsKesxUiPgxwu95XJ8dT5oSGbCIdoxqOw+2TF+axWrsNafsxcNAEk/ZPem+bDkTx1REWoUIwesGePsyyt/TLaS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXRJV2Z3ckJvSFlEWnhrRmNXVVBwVUUzaG94QjcvOXVlZWtBSzlkZzNubHFU?=
 =?utf-8?B?bFRXZlNRSDZZcTBSUDQyUDJ3d2tYYnNGUFZYRkhVT1UyemZlT3pXNWNPR2Ez?=
 =?utf-8?B?RnFlUVE4WXo4eTNBc0Jtcy8zRko3ZzdKRFVmSTVzY0htMndZcTlPWWptV2to?=
 =?utf-8?B?OEE0bmVldllGNUYvY0VmdjAwSlN0dHFRdHNHaTY0cnlBc0JIZC9pRUdkRXFT?=
 =?utf-8?B?RUhkdGI5SVg1em5yZEM5b0tpa0dpeUFoK1BIVHdZRlVZcURCR2FzSlN2TGZY?=
 =?utf-8?B?TjlnNDF1SHdFUCtkOHdLa2p0aXZvUnpoWU92MVB2ZWxCRzNRcHdOU2RDNSsy?=
 =?utf-8?B?S1FiN0ZqUWtsVnZWU29DVGdMWGtiYmtUWHRKMDgwbThKSGNmKzMwTVRhQmx6?=
 =?utf-8?B?K3BiVUY5eWNZMUcyamZIQWdWajJKWUVQQStLdjNHTkJyNDgvMmtLZTdqSmJ2?=
 =?utf-8?B?YWVreFFkTXdoK3R2dUdBbDZidXpWZUE4UmdwalhlK2FVL1BneTIxRk9CU29V?=
 =?utf-8?B?MjR5Qnl5NEF0Y2xrSVJXOTZYcDc4VGlKR1RLZWxodFhxQzZsSWxMelBDM3pV?=
 =?utf-8?B?c05xRy9RY2tUSzM4WG9RQTVkdlpISmNKQnR1TXYvVzBackJSUUFIRnpuV21o?=
 =?utf-8?B?bXBobFlRS3E0ZHlPTkc1ZEpZTGE3RUU4Z3FuRWo0QjFxSzhOdnpaSnR0RFIw?=
 =?utf-8?B?a1dyQzIrNXF2TVhSTjJTRk5BY0RDUElIaGx5U254VUtkMHREOGZsdjNzbnBW?=
 =?utf-8?B?MWJoQWJpQzFrR3hwM2o4NlhMSEZpZmdCMmNXbzI1VDVvMEJGZVNXS24yTlB6?=
 =?utf-8?B?M2V1K3lqbEd1ZUNlcWNyQW0wSGFlZ1VQczJwd0s2WUp3RHpIUDlBZVM0VmJX?=
 =?utf-8?B?QlJoNGdWT2ZxYzJxWGpwejR2WTB1NmRVYm9jSkEwNUlqMmFBaUNuSUhOQTkr?=
 =?utf-8?B?KzVFR0c1VGZJZllGTTQrMnV3RzJRSlc1N3c5OE9MUTdSN0xCWml3bVdYZ3lt?=
 =?utf-8?B?cFJ1aUFvTUZJaTkxYzFia3lGR2o1dFlJNHVncWZ3T09wZG95WTgrQnphMzRB?=
 =?utf-8?B?QUhIQ0sweXdpSmYrV1EwcWR6dEtkeCsvaWtCaEhtNkFneXRyWU1xU0xTbloz?=
 =?utf-8?B?N2M1S0x1TWprT2RRVWV0SElXL3dCM3lyQVppVkRjcnNYdll2ZGxVUEkzU0RP?=
 =?utf-8?B?a0dxY1Zpd0pvZHBkcDlWUkw2K3VzRTFKTEJ1aU4yQ1NEbjVaTmVzelRiM1Z3?=
 =?utf-8?B?UTVucCtML0NTM09laHZ1UldBWVkraHNOYk1kZVp2c3VucnVkNmJyckZXYVdM?=
 =?utf-8?B?OWJmSFl5V0VMLzBua3BOTEpmclhvTkdXU21NcWtwN0V2YndYbVBjd2hHc2lN?=
 =?utf-8?B?YnR5M1Z2emlBb09lV21INTAybVJpT1hZRUtrVEIwWHhYVmpzclV2MER3TzVC?=
 =?utf-8?B?SSt0SnVtV3E3NjZHeFVLNkZyaE8wMGNqQjhUdDVFcDBxRWNQM2ptbDhrd0J4?=
 =?utf-8?B?YlFNZXpvNlMxOXFGM08yck5IZEw5SXJuOTR4TlFld0tpRytNS004eisxT0pB?=
 =?utf-8?B?T2x2U1RhQklRUjhKdjNkNUYwVHFpeHcwblhDY2lheEZxQ3ZUMURPYXdYV0Y1?=
 =?utf-8?B?QnVBc2RTWFc5cVBORy85ZzY5MS81aEtBVmNOUlN4bHVMWjFyRFZ2a1BuYjhJ?=
 =?utf-8?B?ZXdLMTN4cStuNkx2WEZialFYYjViN2tCOUFoZjhRbnI0L20yS3JsRDBJVGhx?=
 =?utf-8?B?ZFhCYVBrREw3Um40a0lWQ0hoSWRlcHhvYitxOUl2a3lxY1YwQTcrSGZDZ050?=
 =?utf-8?B?NklMSTRwcGJ3STNtZVVKRVVrT3JITEpXdFZLVTd1aHY1RTFpYXR3Q2VLU01j?=
 =?utf-8?B?a0JyZlNoUjkzSnhRaVJaSWRIYWRXU3NYUi9OQ0dmNzlUVWJGRCs1ZlAwVzlF?=
 =?utf-8?B?cE9mRXM0MEpMNHBYWXJMN0FWeXNZMThaWU1EM0VxUXR2MmYzTGREQ2d3L3Yv?=
 =?utf-8?B?T2pGQTIxLzZWdjJFYi9ycE54WUJlQVJ2WTdyMnVQRkZZcGFQUG5zbmIrK29N?=
 =?utf-8?B?cXl0Zy9yNXF2K2xaUVZvMjQ0aTRHRUFPeFNCOFZTUjc5WDRONzFpdUNHanhs?=
 =?utf-8?B?c3E1WkRVZlg1RUVTVHFoWDUzeHQxNjk2Q1VnQXlyVE5NTXZaeWpsazBwWjZ4?=
 =?utf-8?B?OU9jQWVEZjNDY0tSTW9FVWFJV2o1NzlUQ0VlelphbitwR3Q2Vyt5VVdDOEpK?=
 =?utf-8?B?ZEtGZnRVVWZ0aFRBdEJ5Mm9qRXFJNUkrRHprRUk0UU0yZTY1VStPNE1GYzN1?=
 =?utf-8?B?QjkydEh3NlduQjdFNG9pbDcwOVNkbGwzK0dpWXBTczhzazZSTERqdG85N0t2?=
 =?utf-8?Q?+ImOOvSVOdhy10MXMIaVMo5f4CM2IBgiZnLcjL1fjJw23?=
X-MS-Exchange-AntiSpam-MessageData-1: f7Hf6I10mlH0rg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d72bdb0-66f3-44b3-be75-08de9c96bc2d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:33:55.0466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwVuPn9pGpwvPXGWLeygtBf9GcRtXBD1knGME1E5qvEe6wCYfLt7sDkPSpXkZxOjITh1+ZYExC0Kk0Ej8VapLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

Add `RmControlMsgFunction` which mirrors `MsgFunction` in fw.rs. This
denotes the type of RM control RPC. For now it contains a single
discriminant only (which will be used later), which is needed to prevent
compile errors when using an otherwise empty enum.

Add `GspRmControl` which wraps the RM control RPC structure from the
bindings.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs             |  1 -
 drivers/gpu/nova-core/gsp/fw.rs                   |  1 +
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  1 +
 drivers/gpu/nova-core/gsp/fw/rm.rs                | 91 +++++++++++++++++++++++
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 8a19ef689731..bf0e8533a71c 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -78,7 +78,6 @@ pub(crate) fn new(raw: u32) -> Self {
     }
 
     /// Returns the raw handle value.
-    #[expect(dead_code)]
     pub(crate) fn as_raw(self) -> u32 {
         self.0
     }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 5fabb815a919..1f5c61bea645 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -2,6 +2,7 @@
 
 pub(crate) mod commands;
 mod r570_144;
+pub(crate) mod rm;
 
 // Alias to avoid repeating the version number with every use.
 use r570_144 as bindings;
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 05e205e6dc58..ece31cc32f5b 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -44,6 +44,7 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
 pub const GSP_FW_WPR_META_MAGIC: i64 = -2577556379034558285;
 pub const REGISTRY_TABLE_ENTRY_TYPE_DWORD: u32 = 1;
 pub const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: u32 = 65536;
+pub const NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE: u32 = 545270280;
 pub type __u8 = ffi::c_uchar;
 pub type __u16 = ffi::c_ushort;
 pub type __u32 = ffi::c_uint;
diff --git a/drivers/gpu/nova-core/gsp/fw/rm.rs b/drivers/gpu/nova-core/gsp/fw/rm.rs
new file mode 100644
index 000000000000..e51fdcec1f27
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/fw/rm.rs
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    prelude::*,
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    }, //
+};
+
+use crate::gsp::commands::{
+    Client,
+    Handle, //
+};
+
+use super::{
+    bindings,
+    GspMsgRmStatus, //
+};
+
+/// Command code for RM control RPCs sent using [`MsgFunction::GspRmControl`].
+#[derive(Copy, Clone, Debug, PartialEq)]
+#[repr(u32)]
+pub(crate) enum RmControlMsgFunction {
+    /// Get the CE fault method buffer size.
+    CeGetFaultMethodBufferSize = bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE,
+}
+
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros
+// once they land.
+impl TryFrom<u32> for RmControlMsgFunction {
+    type Error = kernel::error::Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE => {
+                Ok(Self::CeGetFaultMethodBufferSize)
+            }
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<RmControlMsgFunction> for u32 {
+    fn from(value: RmControlMsgFunction) -> Self {
+        // CAST: `RmControlMsgFunction` is `repr(u32)` and can thus be cast losslessly.
+        value as u32
+    }
+}
+
+/// RM control message element structure.
+#[repr(transparent)]
+pub(crate) struct GspRmControl {
+    inner: bindings::rpc_gsp_rm_control_v03_00,
+}
+
+#[expect(dead_code)]
+impl GspRmControl {
+    /// Creates a new RM control command.
+    pub(crate) fn new<T>(
+        client: Handle<Client>,
+        object: Handle<T>,
+        cmd: RmControlMsgFunction,
+        params_size: u32,
+    ) -> Self {
+        Self {
+            inner: bindings::rpc_gsp_rm_control_v03_00 {
+                hClient: client.as_raw(),
+                hObject: object.as_raw(),
+                cmd: u32::from(cmd),
+                status: 0,
+                paramsSize: params_size,
+                flags: 0,
+                params: Default::default(),
+            },
+        }
+    }
+
+    /// Returns the status from the RM control response.
+    ///
+    /// This is distinct from the RPC transport status in the RPC message header.
+    pub(crate) fn status(&self) -> Result<GspMsgRmStatus> {
+        self.inner.status.try_into()
+    }
+}
+
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for GspRmControl {}
+
+// SAFETY: This struct contains no padding.
+unsafe impl AsBytes for GspRmControl {}

-- 
2.53.0

