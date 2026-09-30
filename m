Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D893ACA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 112F810F463;
	Wed, 30 Sep 2026 14:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVtilEKO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF2810F462
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSc9/NyzzGkyVTEXttyhjAC0yIdXGhllavmD4VKD4v9KghHT0YXhbXBnIEKxZ5j601vmmiTA3uBDE/jaxUPDBkDnJHB18NNKoz8Libb3l/FAWFQBpNrKxGKtK400iTIbIAgauHSmnH+orbCE1mNiX35OZjk1I+pLwrcEXqBpsy4qZhlOIyrXKelKVeBgMdGHXIOe9LBtJHwjsul6LAtak4kqkBZUvmcvTim2QzP5jQk75FOD5Ukm0FLVK+g57jlbQDu3+mf8bQw9f4KL9lBatRqsRb0mr+aX58w9F0dIaTBHHu258OVl5yMgvg4l5u7jX2vrO0t92oA4A2MRXFyYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmrgaoOAZLHM7TLhShr1Mwticud3ygZFKvgLZB2BFUw=;
 b=NoWNHkQYmTYkh2HMfUIF5dl4EUPP+4yExkNrFHlAy6CObyWsTYs1CG3itXZVWFHjmc9t4wz/g4ylO2Rac2On0QbdUsp9/QEPPMbGXWgTfbGddbMp2+bM7T4W2kmdeg1tgqQn82haljmNxWdiOu8s6rpsZaBUifqDUA5RLc/MsQsrLPsQ3W+v4eLNFddJue7cNkSqNwn/+lsstAWYDKS14lhEZq1FgPS37u8AZ1+yV74zPQUbLCuq1HeAxvuwFDwBGVoXbvkBUChO0nikGOgBu5vpz1QWaFTWd+uzscPM/POlfsOgPGQFlM43pNj2hbIz8Pn2l4lUd/YAzZ/3SIlmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmrgaoOAZLHM7TLhShr1Mwticud3ygZFKvgLZB2BFUw=;
 b=UVtilEKO8ID787L/UabmQULs3jQX4AwWvUx0k+udFieK+aA7pVPmV8DUjixQcPFWykFj+S41RdMr5+mK/3WthL3ezOZBZQkZ4Xx3F72PtJCs/Ui7OsdrWoj2OIvmrjxel5Tp9yhESnWZesSNJaDMX+PU0rwfjwmvjASkS0bLXgetwE1ONX0QI764puMgQxVGY9xexbAtuxGWu8V4LQ0QN4Kqj27kpZKGeVScYhxHKOBlQoGutIOX7mlfr5+TU6XDYjXyD/VOboLTXmiy/Tzc+QGLFRhzQymBf/Zhz0X7uNPyul5luSZIdzru/NULmSLFW5QBPo1CBdgJqgywZeVW3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:57:22 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:57:22 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:47 +0900
Subject: [PATCH v3 8/9] gpu: nova-core: gsp: move the RPC commands into a
 sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-8-91613f06520b@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0201.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfac45d-0198-49e5-2f78-08df1f032197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9SqWuV0cyfrEu/yL0DPzOd+AjF18fQ2g5v/2oH7BZygfsaU0Hvy94rk8bhP4tpxfgPkXH5+m5cwQoHG/AF5VrmNWI3WiX4AkCB1TGbRzffRqVAmmiezlltraeCRTq7DA21GOs2nlZcn9IYGltJuPnF6cg9OlxnxnBdFEYexAnqTU4Csmxb+Ew4P5Iqpt1CC2SYVa5kIMU31OKP5a4Qov/9tfqfqQ6LeIHuVjmoGJq4TsGwM7SO7uI4ui7x2CbUI7IgOWSsiJQWRVrUrPD6bGqGKZ8rooesqzLT1r5U1YLujdR6M6yfmDjXBLfKndQoQszfhdfHwxflWF7ArdgVV6ODKacWeAxwTEbR6TG/zSF0RZAGUvLJAWx4VjX5v8XVcX/0d+RuUAUOS/7iCG10yO5wLcLnajJV+N1DUtK7Pw62DwSp3X1W0OKE3H9NWbYEy1l7MO2hVu3w/xgj+vMBoCb4HHM8vCAaoHVNOPcnC3LYZmI3iczpwdabUbMRFbNSfOsQR/KPgD95RqaF9J8KXdLd9e/3PCRYckT6MqHs0NCI44jcy9YiueIjzfbmY3E4EX/qSZTBeKhQVFLOPIau9SAuH/xElwjpA8fikpRLBAT0uI6HmEHv6aV6PjTxkrK9wkviYX0VACe6tK/2S3FiJHVioIpJr45mG3hpPufCH9yDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEN5V20yb1ZqODZ4aXA3elFiWjdPbEk0aGc2cUt4cXpiWXN5TmNoNEdqRVVo?=
 =?utf-8?B?a3R0dTVhSURLcE5kS0UyMVlsdmtiUmQ3V0VaUWdLY2tGV3o4QWcxMDJrWGlB?=
 =?utf-8?B?Y0ZHVForT3RNdjNxOWNTMFJLSlJ2Y3JBSzdOVjRTYWRTMkMvMUhOMFViWTJi?=
 =?utf-8?B?SWxXcmdjWlI4VE1RYU9sdVRyR2JlVXQ2MHkrdW5yVHRoNzdXbGdoOE5iUUpF?=
 =?utf-8?B?bVBka1VqbnU5NCtGQllYZEhnakZFT0E5UkZWUlRUZkxtRE1WMHo2S294c3Z0?=
 =?utf-8?B?Y0hZbmRwRmVNN1M4UGphY0hIWXpuRHRjb1RjOEhVM0pheDQ4c0cwTGk0TEI4?=
 =?utf-8?B?OWYxWlk1czhxUEtMWDZwRnQ0eVFQdzdjM2pQekhLY3lXZmdoRTlqRUJ4Tmw3?=
 =?utf-8?B?cnJRUzNka3dBWkxhcTRCeUpiYldRTU5RYythMDRiNy94SVExR2NTQUhza0lV?=
 =?utf-8?B?SGZUTWxTMTN1MGU5QWtLRnZQUkswamR1ZUE4UnpkYmNQbjM2K3RLMVRVNkZ6?=
 =?utf-8?B?a1pzZEJMNDNiREFnYlFjV3FjekNoS2x0VlpZS21UUnBYSGhBVTNycG5GaG14?=
 =?utf-8?B?T2dGeXk3ZnhOSEhraDlTZlNjUmJpR3hlY2NtK3Jna1JQeUZIVnVuN3BrVitQ?=
 =?utf-8?B?TjRRdlVEM2NTMEpLS0lma0NsM1dnR0F4Q3R2NGIwZ2lIRzNZTFVHU0ZtYWZB?=
 =?utf-8?B?RXNNNmI3ZHVqZUN0M3ZVRTdKb2VPVVNkQ3BmS2g2eitZMDV1K0xUcFFYWVlX?=
 =?utf-8?B?MjRBVU9qdWNVRlRkdzh6cWdab01JNyszMzBlcXdGMUNjSHlnNFE5TkpzajYv?=
 =?utf-8?B?VDNYcG9OTXFMTWFyK0FEaTBhWGdHUWdWaUJTdTRUbGV0ODdWRmIyUUI3VFdK?=
 =?utf-8?B?VGMvbUZvWWhvaWYrM2szelRLaVptUUpyb1ZzZjlMS0NTZnkxVk1OZkl3NlR6?=
 =?utf-8?B?R3R1UG1uWGR3VVM5VGRLUVNBb0FmSVNHeHgrVmdDVVZkRlpVNWJYMUdpdytI?=
 =?utf-8?B?QUJRNGxCUENBL2ZpSXRLVUk3T3lUVHM0VWV5dlVrdy93QlB2MDVrdEZlOHFv?=
 =?utf-8?B?Q0F0U2VwczlZQkdEZVE1STd2ak5RZzE3Y0VuNEFObWhzcHRKZm5oT2w2R01k?=
 =?utf-8?B?UG94Y3pqVmovRkE4UXZualVUOW1MREpnczBINUJYR0pIdUpwWFhvVVVWL2Nu?=
 =?utf-8?B?a1VpdTFlYWp5eDZyUzhFNWNCV3pEa1VjcU5kMVN5bmdkV0VLUzUydDN4QTZM?=
 =?utf-8?B?QWp2TnRITDhHeHhqTEtVUkQ1N0IzSFBsaldwTi9PbXRIQ1I3UElrZkVWVk5W?=
 =?utf-8?B?OHA3Uk0rcDhsVlZRZzE3L0QwSTBQV2hYZ0JtWmsrVmJ0ZFpWZEZvNXllUTA5?=
 =?utf-8?B?UjFQVW9iNysrcjI4RlJaam1kd1dGMDFWY1g0TEN5b3FBNFVoUTYxalF4Zmha?=
 =?utf-8?B?UUZiTFFZU1llRU5Vdit5VXB5UWk5WHNrYjdyTGRJeXh2YjBmV3BPTnBMb09Q?=
 =?utf-8?B?dnFVcjludEdYT0lwU05hNkVTNms5dWtSUUp6SjduZE42eW1tQ01ZN0tBWitZ?=
 =?utf-8?B?MkwrSk9KZ2ZGV2Y4ZDlHNCtySUhFM2IzbFFEV3dkOU5LVzFEeExiK3E1aENF?=
 =?utf-8?B?SzZLaHNERVVTcDVQSVgwYStkRlF6S1k4a1IvZnhQc3JDNFdSTnlMd3JFZzE4?=
 =?utf-8?B?dksyb1JtVWNWb3IzQ2RLWmdiaDNHa2N6R0o2T0hmZnpoZ2JOcVpwQ3RSa2d2?=
 =?utf-8?B?c0J2ZmM4bWpadHBDZ245b1BXdjRETkRlOUNCNWIxZytJMGZYRDJXQWR4OGgr?=
 =?utf-8?B?VUVvTFExT2p5TWliUmZNc2hlVldDbzNiTFM0SGYyMHBKUDBRZjc4MFpPbW56?=
 =?utf-8?B?U3pzd2FYSlY4K3dhaFhXSDVlYTV4TWd6eDVOQ0JZYXQ3azBLSHE1eVk2NUxN?=
 =?utf-8?B?b0hKWTdWTFVQd2pDcDMzQmZ5VGhDc3hyWDkvVGpLR2VsQmlkbndZd1VPRy85?=
 =?utf-8?B?Tlc1eU5uZUl1VjBDelNDaWVBSlpzYWlzcjliRVFrQ0FoNjdxR1BmeXkxcGhJ?=
 =?utf-8?B?NEhwOVBsTkMxWEtML04zc1FTWEl3c20zbkRhR0JjazByM052R3NWd0c0cGJt?=
 =?utf-8?B?TUhRSnNoUURkVTdwTzdrU0xFalNORW92TFN6UU5XZnZkL3didnlOck9VN2JC?=
 =?utf-8?B?TVRycURnQUVzeVpDSlRGVE93UzhtTm9xd0NxaW1QdGNYNWtadGdMRDVlczVw?=
 =?utf-8?B?dmNHTTBrTHo0N2svQ05EZndzOUhpMWRzQU1ORStWeVBVNTBwN3F5WCtiODNY?=
 =?utf-8?B?bElFWkdDQStWcGI4bmZXeWNFU3p6UHhyK3dCMWxMNzZybFZIZURidWg0Wmdy?=
 =?utf-8?Q?6F5QPNzgvG8PWP6ch4eGKmt54NdvQeU5lGO1w/Zzg0GOv?=
X-MS-Exchange-AntiSpam-MessageData-1: sKuknSmqCHo5/g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfac45d-0198-49e5-2f78-08df1f032197
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:22.0924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yqnn6h/HAtvEG6RktDzw1uHDVLqgCyLLsjkuew30mXzlkaUt+L79bONBZ2DqSih9DUcmlwSToS7d7t9jLtrG5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
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

