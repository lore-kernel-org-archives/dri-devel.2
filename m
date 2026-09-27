Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76287C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D860910E607;
	Sun, 27 Sep 2026 13:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KVJ4Shzr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E394810E4D2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axAFeWmOKsuqa1LTlJ+aukMaft02MbgiZvVVZMaIwqC3uYP4uLu69ZtdPTSCd/TA7MbkzSHpb7g/IIzJVQK1n66fTPuOcMrErd5g6JaZZ5sEPqWlDBmeVF5/QJ4fHO+M/dpt3oWRxZ8VbsgWf6OK/pS4eR0Ew4BFn0xTWpGddcBtlnHXo579AJGL4q2URnDLb4nsDLXsnJuC+OUVUz7VDa+y2nwJZqyUaNVxBVcuSm/jL8BPHrpummRmhzo06iQU1ovlmbT9NvwC2ZosmwGUXYf1o0ljrkVxDjVQuMwyiyVFbyR5q0gZBthtPOw9u/8+zsjZzkk4u0aeTCaw8Ir5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bs6xP+UeswLgglOOZgb+8bzujN6pIIH3v4Fzp4CTPs=;
 b=VpEvRJ2MxUcc66+c3om4fqlSzIi+DRCMH3Rz6grA128jCeKY++hGeIk+QuLXbhqol9qSi7EvWloLB53RacbRQsnRT3jR9gkHuR+VtRegNybQMG9Y7+IdKHp59RyVEkAf14HGHOgDoBW3P8C4P9LosZpNtlCZ0OkflAwKYRA4Ce3zGQfjtHB21c5UFlP42z3n0OdbhymCTNUIe9F3vtTMtNTiiLaE7iUJnlNGCRuZH+pFaslP7WOQ1+xruun9j/Zxy7uTfCIdDHArOnAuSlx6D2VLft5fkJA/Istz5AHklNxqEydEup2YuzlOzmdor61m+jTSWpM0N7YvA3uq7iiJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bs6xP+UeswLgglOOZgb+8bzujN6pIIH3v4Fzp4CTPs=;
 b=KVJ4ShzrYwZVUqQK2xNgnmOS00R+gl96t+Znly9Oq6xnR5q57f0aYJk45kTIj8wrDgj5DzGsvVt1k8mXASvxVVKXgRAxuVdVj2ctF4PIxTPOPQyzpmwKsmg3yJ6IeYPVMvND8yDmjJQ6Xsu0TpV2LO1PMbPwr9XabWkJcn3kwq0Xwt0TfSUyj9lrN7OuNWMsguP5xwGhIjUDzdt3Zm2Ca70H8KXAEV5nWguwLPSAPl4KBNNlhgO/iDMz+7JR2v+J1+DbGN+3d8BhyvRRyDBVkb6TbTLVqkzt4lFd8IuppzQhdsQADzBMzS4UKhV8/oefVbNtEXQP9GWs7lWg/022jw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:50 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:25 +0900
Subject: [PATCH v2 8/9] gpu: nova-core: gsp: move the RPC commands into a
 sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-8-c3f66ae73be4@nvidia.com>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0054.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7f8eb3-0c46-4a86-d0f9-08df1c9dc7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vbIUDq5iVCHjKCkwIPFNnXyhptFW2bI54CJd32NACy0bDbx5x8TaxWs6xuPd8a96vDoGr3wyb+k998J9fZwxTrFG4PznpWwG2ixjQPT9Bp/L+hiAzd6VwhgOzBeIn1/CjYB9K5rl0CEKXvi+yS8iGe1ZRRDpCMHVWAQ/xS/6A+u+/hlAg5dIiZawrI4ezj7m+FxsUx++8m6Bhz2el5z/Gv0F6/f6u+NcTMcQscxOmBI6au0+sUhbCLwuQI6xVxnXhTF0KYdO5bjX6T5/IhM+1py7Cahst9t6w5AbJGOEIP3hpQ50Sh8Q8Aj+Hwn/ESprkZvTq9ZlFI/vU3t7CqV6tXDo/irxK5as0Al745kIwHVVDsYNUrUXbK60pBCEOrOQ9sFv9nIhl0e/sKJ+48tSdzDeS8O5VXRmX1uR0zwXB0H4jQb8JLZVcStccCgIDdDpBOPMEqs5AAgzXf90TQqCsf4A1ezuASWIUhPwzPRk7Us7maMed/39Ggt2lcoUzLzGnPcCx17njkWm9VtYkUD2VW7hOANeKjGf4szQr4siurD2ra4rgGCq7w/6yrWJ2R/6zZ8s68Okx0r0NXJQr/o3HPXb6NkFxPMoAsDeH4uGAjIXEC8sQ8C0cHpWFsIBbwrlblKx/l18nq/fbjGZ2zg7Zr6Eme3BvDkeTo6P2Qii+es=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2lkYXFGYjc3bDhYazNDQU1vSm4xeXpjb2lkeVBJa1Q5RjByRUcwZ25La29n?=
 =?utf-8?B?OFUwdmt1ODR5MVZkNXVDRlVLdUhGODJwUEhaY1lzUnhjSWdncWF0S2kzR3Er?=
 =?utf-8?B?SFMrNGJ6K2JSSUl1ZnpCZEdnUXlDcjlScXR2aVBKcER3YXdudW94K0lXaWl1?=
 =?utf-8?B?VEt6UDM2Ujh2MFhibXhVdDVIOEl6b0UzdXdVdmpFRGNNamI3ZEVWNlBLTjFQ?=
 =?utf-8?B?QVJ5VTJLN3hjK09GQkZlMnNkUmJkc3JVS1A2bng3UW5WTWFlZDNXeGpIRnYz?=
 =?utf-8?B?UUErd1JvRnRmeUpodjRKNGV6TEg1bmhpUXhCS2lCS2luSzFJU2Rnb2NZQ0Jw?=
 =?utf-8?B?bG04Um94UXlzTE1vRElYYWwxelJWR05neUpGb0xqdUZEYUhBa0Fjdk5KVzRS?=
 =?utf-8?B?bjZHeUV2RUdnd1VKOFpTTTI0TGJoWm9MakEzb2xWNXVpQWg0OUNLWVk0bzNY?=
 =?utf-8?B?T1JUY2gvQzI4SVJScXhlODVDQkdjUDdMN2tDL1k1TVdqNTFsR0swRFlXTTRu?=
 =?utf-8?B?UVUyK2xLMmNnbHVMQ3BpNlJDaHNLeWdHaEEySk94R0VPc3hRRkhDT1ZMM0pU?=
 =?utf-8?B?YWI2a3VEZm9TeWFWaW95ZFpoQnBLQUtuL1UwdmRvTnBMNFZ6NjBwR2QvNzFF?=
 =?utf-8?B?dmFYMm5ybG94dlNzNCtZY3dsa3AwekpXNkF2ZjRNa0kwbkt5TFE2L1JKVW9r?=
 =?utf-8?B?K21jS05FcGZBWEtNeWZZOUE1cmVJWU55Wm5teEttOHlVMUt2a1ZHYjNHaW1P?=
 =?utf-8?B?dkpReG5rd2JNVmIxMFdUQ1VtdWVhRlhXcVZKN0gyQ2ZrWTF1TnBnMkJ3STMv?=
 =?utf-8?B?Nk01R0V0TFRIQklMS2h2YWVnelJsTUhsWEpTRURra28zL2VUUHIzNk11KzlR?=
 =?utf-8?B?RGlYOXJoZTJrQkMvR1ZQek5jZHdBK2Vza3ZTQ24yZkdBekJXNkJxT3o2RkZQ?=
 =?utf-8?B?UDl3WU1sRk5jam4zV3o0MFVBcXJvQy9QZnhPZE9SWEduYzRQdTVoa2VHdThG?=
 =?utf-8?B?RVRMNkgxODQ4UDNlTDZONjJjSkhqNU9xV0h5alVwNUJLTlIwRWkzcFJodDVn?=
 =?utf-8?B?VTluT0d4WnF1bE9XazNleFJhUnFteXVJMGw5Zll0MStiR0dQcXpiYlNvWkhm?=
 =?utf-8?B?ZFl0YlgrblhFT29MS0pudEhiL0ZKSDFsd1lPMGRWVm8wUytiNUJTTlRFcS9R?=
 =?utf-8?B?MFY1QmdmV1ZHeHFqNlM2NzAyNFU3bnQrRFZZbjczVDlJU1lPc0ZFUFdaT2RI?=
 =?utf-8?B?V3Z6N1l2aGF0THdxWkJQTXVzRmFlM3BNclkwTW5sTDN4cXppQkVvMGdNVEJm?=
 =?utf-8?B?TlorOURtZ21rMmRCZk1mbmMzcUVCc01lMVBSZ0d4TDI5RVo5UEpNU3Z2UlZO?=
 =?utf-8?B?NnJiY2Q3S2ZjWUNwUFdhTUR3cWNKVU1vQ2Z4WGVjRmFSZGhxK3dWTjN1R2hr?=
 =?utf-8?B?WXZCcXFLK1llbmxNSGh6cWlIUTkrZG9wSWNuSWk2SElCMEZPb3ZWTTIxYUh2?=
 =?utf-8?B?ckdoeE9zNUQvV0svS1E2akJkRUNYTkd5SUhBTVkvUXpOVHNVeHRrL2pnU0NH?=
 =?utf-8?B?NHM3YkdvVHRKWWtPaGFVNXlQdURjZXhzenBNZlovczhxK29BOUxseXpFdWhH?=
 =?utf-8?B?Y2ZXYWRITlhuYXRWcFVKUnppRHY1QmQ5dWtXbm5ZSzMyRWdmbDlmQW4zVThY?=
 =?utf-8?B?QnI3Wm94cy9xUjBPZWNTWlRwZDk5TktqR1BKRlRmTkNXdHB4TVBOUTZ5aGRy?=
 =?utf-8?B?Si9DVG10Q21CY0tSVDhDUmx6WGcwWloyNEdIaVc3Tm0zNzR0UGg2ZnF2MXRL?=
 =?utf-8?B?Yy8yb0cvbmxxT0xacjJYcmV1SFpvZTFMZDBtM0djRG5pS0xUSGhOR1F6OVVz?=
 =?utf-8?B?SVd5VXdlNjF1ZUh6M1ZFc2Zib1lDdGJCRjVJM3FPSDhuRUQ4OUtGMVp4d3hX?=
 =?utf-8?B?WmlvZGs1TFUxSXhES3lRc25yVyswUHd5SEFqc3dCSmRYczNYRjVQd0NGbHFI?=
 =?utf-8?B?R05GcldTb2JVTlRyM2kzUEgxYmNicDJueVNiN1lVTUpXTHg5UnRSVU9wK2Zn?=
 =?utf-8?B?VzJaNzVJZUcyb3Z1RC90SmM5UW5xK2srNWhYVnVVazIxU20xNVJVRGh1RFJx?=
 =?utf-8?B?V3kweHltWVprS1ZwTE1MU0hIc2ZSTEtLSlpFTW5ZMlRoUmxvcllKSUw3SFFD?=
 =?utf-8?B?S1pncmUvL3Q5MGhaSHdVQlErU05LMW5rVGNWQVdpaS9UMXhJaEQwNXpxVG1O?=
 =?utf-8?B?SG1VUk12VllFbWsrL3pEM3ZEYjRncFZVUFg5VHRVT25BLy9SNWpqa3UvbWVL?=
 =?utf-8?B?K2poY2k2Vnk2ZlljLy84S0JRUTV5N0RvQVJjWlhjRGdEZ0dwUk5GaWZxSmVG?=
 =?utf-8?Q?pu/xbYgXsk1Azg5M2sSJ7eoDvi8IPuOi42aT6pxrXSlX2?=
X-MS-Exchange-AntiSpam-MessageData-1: 7s/3Nw+si8HFmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7f8eb3-0c46-4a86-d0f9-08df1c9dc7c3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:49.8730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqQOLSr2VpqKkMuv1rg+mwcFbd/GKLcn1+bSTxKcH6bvm3lcpnqCPWlyNb1FnCxc9uxksjvZjc+78VEO8OHXRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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

Move the types and code related to RPC commands into the
`rpc` sub-module, and update their users to reference them from their
new location.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/api.rs              |   2 +-
 drivers/gpu/nova-core/gpu.rs              |   2 +-
 drivers/gpu/nova-core/gsp.rs              |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs         |  12 +-
 drivers/gpu/nova-core/gsp/commands.rs     | 337 +----------------------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs | 339 ++++++++++++++++++++++++++++++
 6 files changed, 350 insertions(+), 346 deletions(-)

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index f02c6c7c7e51..84a15265e849 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -16,7 +16,7 @@
 pub use crate::gpu::Spec;
 
 use crate::gpu::Gpu;
-use crate::gsp::commands::GetGspStaticInfoReply;
+use crate::gsp::commands::rpc::GetGspStaticInfoReply;
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
 pub struct NovaCoreApi<'bound> {
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fb6f8a86a503..2a3bd619acf6 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -34,7 +34,7 @@
     fsp::Fsp,
     gsp::{
         self,
-        commands::GetGspStaticInfoReply,
+        commands::rpc::GetGspStaticInfoReply,
         Gsp,
         GspBootContext, //
     },
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index dda58095f40b..75a3ba7d50f4 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -220,8 +220,8 @@ pub(crate) fn new(
     }
 
     /// Query the GSP for the static GPU information.
-    pub(crate) fn get_static_info(&self) -> Result<commands::GetGspStaticInfoReply> {
-        self.cmdq.send_command(commands::GetGspStaticInfo)
+    pub(crate) fn get_static_info(&self) -> Result<commands::rpc::GetGspStaticInfoReply> {
+        self.cmdq.send_command(commands::rpc::GetGspStaticInfo)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 4fb1b69ac9d5..8e446ad1eac2 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -43,9 +43,9 @@ pub(crate) fn boot(
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
 
         self.cmdq
-            .send_command_no_wait(commands::SetSystemInfo::new(pdev, chipset))?;
+            .send_command_no_wait(commands::rpc::SetSystemInfo::new(pdev, chipset))?;
         self.cmdq
-            .send_command_no_wait(commands::SetRegistry::new(ctx.vgpu.state())?)?;
+            .send_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_bundle = hal.boot(&self, &mut ctx, &gsp_fw)?.or_else(|| {
@@ -79,7 +79,7 @@ pub(crate) fn boot(
         hal.post_boot(&self, ctx, &gsp_fw)?;
 
         // Wait until GSP is fully initialized.
-        commands::wait_gsp_init_done(&self.cmdq)?;
+        commands::rpc::wait_gsp_init_done(&self.cmdq)?;
 
         Ok(unload_guard.dismiss().1)
     }
@@ -88,10 +88,10 @@ pub(crate) fn boot(
     fn shutdown_gsp(
         cmdq: &Cmdq<'_>,
         gsp_falcon: &Falcon<'_, Gsp>,
-        mode: commands::PowerStateLevel,
+        mode: commands::rpc::PowerStateLevel,
     ) -> Result {
         // Command to shut the GSP down.
-        cmdq.send_command(commands::UnloadingGuestDriver::new(mode))?;
+        cmdq.send_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
 
         // Wait until GSP signals it is suspended.
         const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
@@ -118,7 +118,7 @@ pub(crate) fn unload(
         let mut res = Self::shutdown_gsp(
             &self.cmdq,
             ctx.gsp_falcon,
-            commands::PowerStateLevel::Level0,
+            commands::rpc::PowerStateLevel::Level0,
         )
         .inspect_err(|e| dev_err!(dev, "GSP shutdown failed: {:?}\n", e));
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 25a5a8d33d64..5f1c944678be 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -1,339 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-use core::{
-    array,
-    convert::Infallible,
-    ffi::FromBytesUntilNulError,
-    ops::Range,
-    str::Utf8Error, //
-};
-
-use kernel::{
-    device,
-    pci,
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
-};
-
-use crate::{
-    gpu::Chipset,
-    gsp::{
-        cmdq::{
-            rpc::{
-                CommandToGsp,
-                MessageFromGsp, //
-            },
-            Cmdq,
-            NoReply, //
-        },
-        fw::{
-            self,
-            MsgFunction, //
-        },
-    },
-    sbuffer::SBufferIter,
-    vgpu::VgpuState, //
-};
-
-/// The `GspSetSystemInfo` command.
-pub(crate) struct SetSystemInfo<'a> {
-    pdev: &'a pci::Device<device::Bound>,
-    chipset: Chipset,
-}
-
-impl<'a> SetSystemInfo<'a> {
-    /// Creates a new `GspSetSystemInfo` command using the parameters of `pdev`.
-    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, chipset: Chipset) -> Self {
-        Self { pdev, chipset }
-    }
-}
-
-impl<'a> CommandToGsp for SetSystemInfo<'a> {
-    const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
-    type Command = fw::commands::GspSetSystemInfo;
-    type Reply = NoReply;
-    type InitError = Error;
-
-    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        Self::Command::init(self.pdev, self.chipset)
-    }
-}
-
-struct RegistryEntry {
-    key: &'static str,
-    value: u32,
-}
-
-/// The `SetRegistry` command.
-pub(crate) struct SetRegistry {
-    entries: KVec<RegistryEntry>,
-}
-
-impl SetRegistry {
-    /// Creates a new `SetRegistry` command, using a set of hardcoded entries.
-    pub(crate) fn new(vgpu_state: VgpuState) -> Result<Self> {
-        let mut entries = KVec::new();
-
-        // RMSecBusResetEnable - enables PCI secondary bus reset
-        entries.push(
-            RegistryEntry {
-                key: "RMSecBusResetEnable",
-                value: 1,
-            },
-            GFP_KERNEL,
-        )?;
-
-        // RMForcePcieConfigSave - forces GSP-RM to preserve PCI configuration registers on
-        // any PCI reset.
-        entries.push(
-            RegistryEntry {
-                key: "RMForcePcieConfigSave",
-                value: 1,
-            },
-            GFP_KERNEL,
-        )?;
-
-        // RMDevidCheckIgnore - allows GSP-RM to boot even if the PCI dev ID is not found
-        // in the internal product name database.
-        entries.push(
-            RegistryEntry {
-                key: "RMDevidCheckIgnore",
-                value: 1,
-            },
-            GFP_KERNEL,
-        )?;
-
-        if matches!(vgpu_state, VgpuState::Enabled { .. }) {
-            // RMSetSriovMode - required when vGPU is enabled.
-            entries.push(
-                RegistryEntry {
-                    key: "RMSetSriovMode",
-                    value: 1,
-                },
-                GFP_KERNEL,
-            )?;
-        }
-
-        Ok(Self { entries })
-    }
-}
-
-impl CommandToGsp for SetRegistry {
-    const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
-    type Command = fw::commands::PackedRegistryTable;
-    type Reply = NoReply;
-    type InitError = Infallible;
-
-    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        Self::Command::init(self.entries.len() as u32, self.size() as u32)
-    }
-
-    fn variable_payload_len(&self) -> usize {
-        let mut key_size = 0;
-        for entry in self.entries.iter() {
-            key_size += entry.key.len() + 1; // +1 for NULL terminator
-        }
-        self.entries.len() * size_of::<fw::commands::PackedRegistryEntry>() + key_size
-    }
-
-    fn init_variable_payload(
-        &self,
-        dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
-    ) -> Result {
-        let string_data_start_offset = size_of::<Self::Command>()
-            + self.entries.len() * size_of::<fw::commands::PackedRegistryEntry>();
-
-        // Array for string data.
-        let mut string_data = KVec::new();
-
-        for entry in self.entries.iter() {
-            dst.write_all(
-                fw::commands::PackedRegistryEntry::new(
-                    (string_data_start_offset + string_data.len()) as u32,
-                    entry.value,
-                )
-                .as_bytes(),
-            )?;
-
-            let key_bytes = entry.key.as_bytes();
-            string_data.extend_from_slice(key_bytes, GFP_KERNEL)?;
-            string_data.push(0, GFP_KERNEL)?;
-        }
-
-        dst.write_all(string_data.as_slice())
-    }
-}
-
-/// Message type for GSP initialization done notification.
-struct GspInitDone;
-
-// SAFETY: `GspInitDone` is a zero-sized type with no bytes, therefore it
-// trivially has no uninitialized bytes.
-unsafe impl FromBytes for GspInitDone {}
-
-impl MessageFromGsp for GspInitDone {
-    const FUNCTION: MsgFunction = MsgFunction::GspInitDone;
-    type InitError = Infallible;
-    type Message = ();
-
-    fn read(
-        _msg: &Self::Message,
-        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError> {
-        Ok(GspInitDone)
-    }
-}
-
-/// Waits for GSP initialization to complete.
-pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
-    loop {
-        match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
-            Ok(_) => break Ok(()),
-            Err(ERANGE) => continue,
-            Err(e) => break Err(e),
-        }
-    }
-}
-
-/// The `GetGspStaticInfo` command.
-pub(crate) struct GetGspStaticInfo;
-
-impl CommandToGsp for GetGspStaticInfo {
-    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Command = fw::commands::GspStaticConfigInfo;
-    type Reply = GetGspStaticInfoReply;
-    type InitError = Infallible;
-
-    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        Self::Command::init_zeroed()
-    }
-}
-
-/// The reply from the GSP to the [`GetGspStaticInfo`] command.
-pub struct GetGspStaticInfoReply {
-    gpu_name: [u8; 64],
-    gpu_short_name: [u8; 64],
-    /// The 16-byte SHA-1 based GPU identifier (GID) reported by GSP-RM.
-    pub gpu_gid: [u8; 16],
-    /// BAR1 Page Directory Entry base address.
-    pub(crate) bar1_pde_base: u64,
-    /// Usable FB (VRAM) regions for driver memory allocation.
-    pub(crate) usable_fb_regions: KVec<Range<u64>>,
-    /// Exclusive end of the FB physical address space.
-    pub(crate) total_fb_end: u64,
-}
-
-impl MessageFromGsp for GetGspStaticInfoReply {
-    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
-    type Message = fw::commands::GspStaticConfigInfo;
-    type InitError = Error;
-
-    fn read(
-        msg: &Self::Message,
-        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError> {
-        let mut usable_fb_regions = KVec::new();
-        for region in msg.usable_fb_regions() {
-            usable_fb_regions.push(region, GFP_KERNEL)?;
-        }
-        let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
-
-        Ok(GetGspStaticInfoReply {
-            gpu_name: msg.gpu_name_str(),
-            gpu_short_name: msg.gpu_short_name_str(),
-            gpu_gid: msg.gpu_gid(),
-            bar1_pde_base: msg.bar1_pde_base(),
-            usable_fb_regions,
-            total_fb_end,
-        })
-    }
-}
-
-/// Error type for [`GetGspStaticInfoReply::gpu_name`].
-#[derive(Debug)]
-pub enum GpuNameError {
-    /// The GPU name string does not contain a null terminator.
-    NoNullTerminator(FromBytesUntilNulError),
-
-    /// The GPU name string contains invalid UTF-8.
-    InvalidUtf8(Utf8Error),
-}
-
-impl GetGspStaticInfoReply {
-    /// Returns the name of the GPU as a string.
-    ///
-    /// Returns an error if the string given by the GSP does not contain a null terminator or
-    /// contains invalid UTF-8.
-    pub fn gpu_name(&self) -> Result<&str, GpuNameError> {
-        CStr::from_bytes_until_nul(&self.gpu_name)
-            .map_err(GpuNameError::NoNullTerminator)?
-            .to_str()
-            .map_err(GpuNameError::InvalidUtf8)
-    }
-
-    /// Returns the short name of the GPU as a string.
-    ///
-    /// Returns an error if the string given by the GSP does not contain a null terminator or
-    /// contains invalid UTF-8.
-    pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
-        CStr::from_bytes_until_nul(&self.gpu_short_name)
-            .map_err(GpuNameError::NoNullTerminator)?
-            .to_str()
-            .map_err(GpuNameError::InvalidUtf8)
-    }
-
-    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
-    /// regions.
-    pub fn vram_size(&self) -> u64 {
-        self.usable_fb_regions.iter().fold(0, |size, region| {
-            size.saturating_add(region.end - region.start)
-        })
-    }
-}
-
-pub(crate) use fw::commands::PowerStateLevel;
-
-/// The `UnloadingGuestDriver` command, used to shut down the GSP.
-///
-/// Only used within the `gsp` module.
-pub(super) struct UnloadingGuestDriver {
-    level: PowerStateLevel,
-}
-
-impl UnloadingGuestDriver {
-    /// Creates a new `UnloadingGuestDriver` command for the given [`PowerStateLevel`].
-    pub(super) fn new(level: PowerStateLevel) -> Self {
-        Self { level }
-    }
-}
-
-impl CommandToGsp for UnloadingGuestDriver {
-    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
-    type Command = fw::commands::UnloadingGuestDriver;
-    type Reply = UnloadingGuestDriverReply;
-    type InitError = Infallible;
-
-    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
-        fw::commands::UnloadingGuestDriver::new(self.level)
-    }
-}
-
-/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
-pub(super) struct UnloadingGuestDriverReply;
-
-impl MessageFromGsp for UnloadingGuestDriverReply {
-    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
-    type InitError = Infallible;
-    type Message = ();
-
-    fn read(
-        _msg: &Self::Message,
-        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError> {
-        Ok(UnloadingGuestDriverReply)
-    }
-}
+pub(crate) mod rpc;
diff --git a/drivers/gpu/nova-core/gsp/commands/rpc.rs b/drivers/gpu/nova-core/gsp/commands/rpc.rs
new file mode 100644
index 000000000000..0176ac79fb09
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+use core::{
+    array,
+    convert::Infallible,
+    ffi::FromBytesUntilNulError,
+    ops::Range,
+    str::Utf8Error, //
+};
+
+use kernel::{
+    device,
+    pci,
+    prelude::*,
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    }, //
+};
+
+use crate::{
+    gpu::Chipset,
+    gsp::{
+        cmdq::{
+            rpc::{
+                CommandToGsp,
+                MessageFromGsp, //
+            },
+            Cmdq,
+            NoReply, //
+        },
+        fw::{
+            self,
+            MsgFunction, //
+        },
+    },
+    sbuffer::SBufferIter,
+    vgpu::VgpuState, //
+};
+
+/// The `GspSetSystemInfo` command.
+pub(crate) struct SetSystemInfo<'a> {
+    pdev: &'a pci::Device<device::Bound>,
+    chipset: Chipset,
+}
+
+impl<'a> SetSystemInfo<'a> {
+    /// Creates a new `GspSetSystemInfo` command using the parameters of `pdev`.
+    pub(crate) fn new(pdev: &'a pci::Device<device::Bound>, chipset: Chipset) -> Self {
+        Self { pdev, chipset }
+    }
+}
+
+impl<'a> CommandToGsp for SetSystemInfo<'a> {
+    const FUNCTION: MsgFunction = MsgFunction::GspSetSystemInfo;
+    type Command = fw::commands::GspSetSystemInfo;
+    type Reply = NoReply;
+    type InitError = Error;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        Self::Command::init(self.pdev, self.chipset)
+    }
+}
+
+struct RegistryEntry {
+    key: &'static str,
+    value: u32,
+}
+
+/// The `SetRegistry` command.
+pub(crate) struct SetRegistry {
+    entries: KVec<RegistryEntry>,
+}
+
+impl SetRegistry {
+    /// Creates a new `SetRegistry` command, using a set of hardcoded entries.
+    pub(crate) fn new(vgpu_state: VgpuState) -> Result<Self> {
+        let mut entries = KVec::new();
+
+        // RMSecBusResetEnable - enables PCI secondary bus reset
+        entries.push(
+            RegistryEntry {
+                key: "RMSecBusResetEnable",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // RMForcePcieConfigSave - forces GSP-RM to preserve PCI configuration registers on
+        // any PCI reset.
+        entries.push(
+            RegistryEntry {
+                key: "RMForcePcieConfigSave",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        // RMDevidCheckIgnore - allows GSP-RM to boot even if the PCI dev ID is not found
+        // in the internal product name database.
+        entries.push(
+            RegistryEntry {
+                key: "RMDevidCheckIgnore",
+                value: 1,
+            },
+            GFP_KERNEL,
+        )?;
+
+        if matches!(vgpu_state, VgpuState::Enabled { .. }) {
+            // RMSetSriovMode - required when vGPU is enabled.
+            entries.push(
+                RegistryEntry {
+                    key: "RMSetSriovMode",
+                    value: 1,
+                },
+                GFP_KERNEL,
+            )?;
+        }
+
+        Ok(Self { entries })
+    }
+}
+
+impl CommandToGsp for SetRegistry {
+    const FUNCTION: MsgFunction = MsgFunction::SetRegistry;
+    type Command = fw::commands::PackedRegistryTable;
+    type Reply = NoReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        Self::Command::init(self.entries.len() as u32, self.size() as u32)
+    }
+
+    fn variable_payload_len(&self) -> usize {
+        let mut key_size = 0;
+        for entry in self.entries.iter() {
+            key_size += entry.key.len() + 1; // +1 for NULL terminator
+        }
+        self.entries.len() * size_of::<fw::commands::PackedRegistryEntry>() + key_size
+    }
+
+    fn init_variable_payload(
+        &self,
+        dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
+    ) -> Result {
+        let string_data_start_offset = size_of::<Self::Command>()
+            + self.entries.len() * size_of::<fw::commands::PackedRegistryEntry>();
+
+        // Array for string data.
+        let mut string_data = KVec::new();
+
+        for entry in self.entries.iter() {
+            dst.write_all(
+                fw::commands::PackedRegistryEntry::new(
+                    (string_data_start_offset + string_data.len()) as u32,
+                    entry.value,
+                )
+                .as_bytes(),
+            )?;
+
+            let key_bytes = entry.key.as_bytes();
+            string_data.extend_from_slice(key_bytes, GFP_KERNEL)?;
+            string_data.push(0, GFP_KERNEL)?;
+        }
+
+        dst.write_all(string_data.as_slice())
+    }
+}
+
+/// Message type for GSP initialization done notification.
+struct GspInitDone;
+
+// SAFETY: `GspInitDone` is a zero-sized type with no bytes, therefore it
+// trivially has no uninitialized bytes.
+unsafe impl FromBytes for GspInitDone {}
+
+impl MessageFromGsp for GspInitDone {
+    const FUNCTION: MsgFunction = MsgFunction::GspInitDone;
+    type InitError = Infallible;
+    type Message = ();
+
+    fn read(
+        _msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(GspInitDone)
+    }
+}
+
+/// Waits for GSP initialization to complete.
+pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
+    loop {
+        match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
+            Ok(_) => break Ok(()),
+            Err(ERANGE) => continue,
+            Err(e) => break Err(e),
+        }
+    }
+}
+
+/// The `GetGspStaticInfo` command.
+pub(crate) struct GetGspStaticInfo;
+
+impl CommandToGsp for GetGspStaticInfo {
+    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
+    type Command = fw::commands::GspStaticConfigInfo;
+    type Reply = GetGspStaticInfoReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        Self::Command::init_zeroed()
+    }
+}
+
+/// The reply from the GSP to the [`GetGspStaticInfo`] command.
+pub struct GetGspStaticInfoReply {
+    gpu_name: [u8; 64],
+    gpu_short_name: [u8; 64],
+    /// The 16-byte SHA-1 based GPU identifier (GID) reported by GSP-RM.
+    pub gpu_gid: [u8; 16],
+    /// BAR1 Page Directory Entry base address.
+    pub(crate) bar1_pde_base: u64,
+    /// Usable FB (VRAM) regions for driver memory allocation.
+    pub(crate) usable_fb_regions: KVec<Range<u64>>,
+    /// Exclusive end of the FB physical address space.
+    pub(crate) total_fb_end: u64,
+}
+
+impl MessageFromGsp for GetGspStaticInfoReply {
+    const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
+    type Message = fw::commands::GspStaticConfigInfo;
+    type InitError = Error;
+
+    fn read(
+        msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        let mut usable_fb_regions = KVec::new();
+        for region in msg.usable_fb_regions() {
+            usable_fb_regions.push(region, GFP_KERNEL)?;
+        }
+        let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
+
+        Ok(GetGspStaticInfoReply {
+            gpu_name: msg.gpu_name_str(),
+            gpu_short_name: msg.gpu_short_name_str(),
+            gpu_gid: msg.gpu_gid(),
+            bar1_pde_base: msg.bar1_pde_base(),
+            usable_fb_regions,
+            total_fb_end,
+        })
+    }
+}
+
+/// Error type for [`GetGspStaticInfoReply::gpu_name`].
+#[derive(Debug)]
+pub enum GpuNameError {
+    /// The GPU name string does not contain a null terminator.
+    NoNullTerminator(FromBytesUntilNulError),
+
+    /// The GPU name string contains invalid UTF-8.
+    InvalidUtf8(Utf8Error),
+}
+
+impl GetGspStaticInfoReply {
+    /// Returns the name of the GPU as a string.
+    ///
+    /// Returns an error if the string given by the GSP does not contain a null terminator or
+    /// contains invalid UTF-8.
+    pub fn gpu_name(&self) -> Result<&str, GpuNameError> {
+        CStr::from_bytes_until_nul(&self.gpu_name)
+            .map_err(GpuNameError::NoNullTerminator)?
+            .to_str()
+            .map_err(GpuNameError::InvalidUtf8)
+    }
+
+    /// Returns the short name of the GPU as a string.
+    ///
+    /// Returns an error if the string given by the GSP does not contain a null terminator or
+    /// contains invalid UTF-8.
+    pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
+        CStr::from_bytes_until_nul(&self.gpu_short_name)
+            .map_err(GpuNameError::NoNullTerminator)?
+            .to_str()
+            .map_err(GpuNameError::InvalidUtf8)
+    }
+
+    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
+    /// regions.
+    pub fn vram_size(&self) -> u64 {
+        self.usable_fb_regions.iter().fold(0, |size, region| {
+            size.saturating_add(region.end - region.start)
+        })
+    }
+}
+
+pub(crate) use fw::commands::PowerStateLevel;
+
+/// The `UnloadingGuestDriver` command, used to shut down the GSP.
+///
+/// Only used within the `gsp` module.
+pub(crate) struct UnloadingGuestDriver {
+    level: PowerStateLevel,
+}
+
+impl UnloadingGuestDriver {
+    /// Creates a new `UnloadingGuestDriver` command for the given [`PowerStateLevel`].
+    pub(crate) fn new(level: PowerStateLevel) -> Self {
+        Self { level }
+    }
+}
+
+impl CommandToGsp for UnloadingGuestDriver {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type Command = fw::commands::UnloadingGuestDriver;
+    type Reply = UnloadingGuestDriverReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        fw::commands::UnloadingGuestDriver::new(self.level)
+    }
+}
+
+/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
+pub(crate) struct UnloadingGuestDriverReply;
+
+impl MessageFromGsp for UnloadingGuestDriverReply {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type InitError = Infallible;
+    type Message = ();
+
+    fn read(
+        _msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(UnloadingGuestDriverReply)
+    }
+}

-- 
2.55.0

