Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18190CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C0710F466;
	Wed, 30 Sep 2026 14:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HMKf4OZy";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7CF10F463
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmW0OCv4C332xkM+xjHPLBCHWUxGpcF59lk7aRSE3XRJ6I+88mWdltWtEeqAn6HkoZ0Z+0Cj7lCTbItSa3KYwoAhZdEELe0pn0BE5rJ9qQLrsWXK4OLBJmZZ8Bw/3w2ZofWctiuC02HQuJXuOXK7vgvCx5mHvzc2Acvkx8FFMfoKMsLTGti41KPTcNWeLrObyTrxlI64TeIcT5jQuV/P/hF9a8j7U70ucEGY40bzb/bhpsaI1lu4tzcI5u6blyMHhVwds1DJ98JJZWbRPavx5MweOIcsQdfnhdw4kYgRSV/WoUdgNZgmRS9qgO/9i6eARmq3C1Unzns0wg2wGPKHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVaCSEAHif24D0crZzcQ908tQ7Hx6ZA3QHPXv+4S2Ao=;
 b=CtRAXB8Z7dvOaaobDW8OqSK0K6BCL3pF4pPFVcnqbmICNXh/rmXucdiHqf1lxDW+wJmfvMqRq9/ZJ1bhqFJqzFnL9xPILLShENvI/P7UX49ZWDtEHkN5XStvgb1PuhmQJqZOkJIUuBAKjoPtcFoCRwARPPoJyOSBWtTAk76JNYCb6aVtAQ/VGpPj5hFGVolQKZSmC2rGmIRKhW7QtOc/zOzUa94WQSPPr5jenwa4JJQjHV5AVahNqN2dX5P4Wgu3Dyaa4yR0H+5bH1UxJ2HXuIUZ2HJqpsTysz7CmNZ/Ez8BWtXm2UmFybwcIS8ZGbTh/W1pHzIjitPvqykOBwbWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVaCSEAHif24D0crZzcQ908tQ7Hx6ZA3QHPXv+4S2Ao=;
 b=HMKf4OZycftkvjCCu0GZJwG9wfjOopXNImbWt6J2zU19ERSMR0tWSKxZEkv2QSsypf/Evejw7UbQ63PezAFr1E1dlq5pq47IK+S0baKFKTBmDS7PrLgwLpqmim+E5XXR91pwiQPauCcxPcA/d4ilUV6IBpkv8ypAIB0srONlnV7MeYF1ZXGUEfDfXtRzNwl7IwuwwcecpdNNg2yEAtgrbm+B2jQkoUaKiWjmdKKGmd7BfVCAKwIZvT0mH3/kUg+7pSF9FrSSA0gj/K+ni1Wdg07U2PxVaHjGDOdasNW6XrJJfSGFpbpIxWZj0FHShlwyFbtJbVi732rBVO1U9Te03A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:57:25 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:57:25 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:48 +0900
Subject: [PATCH v3 9/9] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-9-91613f06520b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fb2739-5dbe-4c81-126c-08df1f032389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9Mh+0OrSPcTii1qraLPQoKeY4l6e5U5pepVE/5iyNofe0YURz8BvpMAQXLI9SanRcC36e62tmhjFu5uXEVzc6A1q5NB2XIMqORzxGTqZjMSyCSlPhOdW3ZwUeGMM6r97R8+cUEKWYtKLFRAQp6iSJ/36ajuXPeZN3pVxp62J9o9PMPw33myLZHabgAwnSqIHSOBktf2NyljuFqMl7CPTDq2uEKy0v5yJXWnTteWx3162+Og5AO0OWxyTJw9zQQ2rO6H8uUVfybuYgRjhj+H07cJu75ptboyLCnmc6YwGV5Ocn+XzcRbbzB8ixg9aMeijcFb+C12PshJNhVoEJOnMP2EoOaC0S9ZmenYiYzD1yhhxekCmlyzMK80DEHZoh+CcWHs/F4XZMdUV8D+wOlSGtTCeL1AxDpvHhnfh1XdM/tzQT0WqmRT6jpJXNkZPHNYrCwtk9PCgLNEmCGdaDDU5CdZ+9+Vy0J/flZRBxQ5+uTj5goGAOawDALCG0PcntrD1E3YRNHEyksfd3H5eP+wZPiWeqolg1u9XCRooFYO90wpZSHU3QzdWjZztoyoIyNnrl5Axoo1Bil19DyMsXBsei3TwKjnfT/USfKH1islV0pLy3w4RxDuhCBeIs0/tbHHupAgCzWNt8DqcrT1uJrcjtcCB0FDH6eq3mr0SpVkO2/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFuYU0rNXJoMmZsTGZmbXFRRzdIeHprc1N0VENHMmF0WnhtTkY4YWUvR1pS?=
 =?utf-8?B?Nzc5V2p1dlo1ZGZ0TUtCN0JpT29wWE9ndlIxTE1UMnNIUE1ydUd6VWNmSmRJ?=
 =?utf-8?B?RkJ3S09wZXVOZk9nVnhVQWJYU1ZXajg2UUhJQkFpaG9YcnVrSzVxK29OWlls?=
 =?utf-8?B?cjhFc0g0NzgwbXZod1BOTjhQdU9oMCt1ditKQTJjTmhCTXd4ZmEyTXp6dDlC?=
 =?utf-8?B?VWM1S09aL2lmOGNsTHJzbjR0bGUvOEwzdUt2UnpKdTFqZHZiSytKZWF2bktz?=
 =?utf-8?B?aXI2MldpQS91Y1NDcVdPSVpNMk5YSlAwY3ZhNG9WbXFZd1V2cEZPYi9nNmdm?=
 =?utf-8?B?QVd6emh4L3Zqa1RkU1VoNWZJc1IrSjA2bTNNQlF0UHJLVURKaWdBUk5LNVdw?=
 =?utf-8?B?NGhVUGNmRGZ4QVhSaXhCMHlOb0R6NUluY2ROc2FQUmlTaTVpYnJoOFZNM1ZN?=
 =?utf-8?B?dXV4bTFwaTZQR2JBNTE2WUR3bjBBRDNaNnJadGVHdmcrNlNqRW5CTStYenMx?=
 =?utf-8?B?U3Q1NzJIdnVFdlpJNVBQaG1yaXdvckNoa3V3NmJTYnhucTlzb25DR1cvd3B6?=
 =?utf-8?B?RXVIazlkVm5OTzVKRU9XVGk1R0F4MURIT2ZuUEkxYVNUczF3U01XQ3BMTVN2?=
 =?utf-8?B?SkJJYloyUTMyUWhTV2VKSFVWWm96ay9sVzRQUE1ndlVrVU4rU1I2T01PZkla?=
 =?utf-8?B?eU9Md0QzaFRkUHRuV0pVZlVqbm5DV0s0K0ZOeEcxYmlHL3RCWGpTYUd5dnhN?=
 =?utf-8?B?TVJoN3J0LzVyOVA0TER3Nlc3dXhjWEdkS3FJSlF5MytYaVJqNXAxUWdRNSs3?=
 =?utf-8?B?NCt0d3hXc3g4UGFtYXRkdk0zZnB5VWNCZXZMQzR4UkpEcjhtelI5RFN1OTN6?=
 =?utf-8?B?SlZMN1Y2U1B6emJyeS8vRk9XQkZPd0tHYjJnSm1jWDZGbHJYT240Nk9wQjh1?=
 =?utf-8?B?YkxkUEcrcFNCanBmSFJ5MUNINXlnYnFEcXg1ZThTblY1Ny9NSFFpMlNKK0VN?=
 =?utf-8?B?RWFTUUtGbU5BYkZiRGRieHhSRFY2S1M3Wm53Ty9JREJKamE0TmpvbnBUdEVv?=
 =?utf-8?B?eENtUzFwbjM0aTJtaUNSemtDemFtQWxnM0s1SjNidUlSb1VlcXlrdmNqYTZz?=
 =?utf-8?B?K1BsZnRXUnN4NWZtREMrWkRSSVMydEFzYngvOGpBTThOaUhMYkhBL0NKR3A1?=
 =?utf-8?B?WGdrcjkrWDBxcVZEeUNYN3JGTmdSQjFob0VJTllwbkdSbmNNN0VjbXdZOWJ5?=
 =?utf-8?B?MVFKR3hXOU85emREK0JzQndVcHRrc3htYXd6bk9EZWc3b2dSU2dpUlVSTU5D?=
 =?utf-8?B?QlhMcWt6VDIxbm96SU1WVlJxRFFQeGZwajZ5N3g2TWJ3eDIwNk11dnNqYkY0?=
 =?utf-8?B?TjJSRlJjb2lTZlIvQVI0M2RVcVkzdTh4ZHdCcHo4ZzNuY28wRXNGUHB3Q0w0?=
 =?utf-8?B?R2FWSnVPcDNlNWUwVitLdnNvcytMNFBMUFhVS3dodXhDYUZLRnc4YmpIL21H?=
 =?utf-8?B?SU9zcG1sYjdqNjR6TjJDbUFhNk1WcXZsd3hMS2p3eEFqZUFYMUxnRTEyTGhJ?=
 =?utf-8?B?ODZpZStNY3VtVTVSWXZ0akF2aFpmeHRqWVVlc0xhaXB6elROTXU3WVU0Nlhv?=
 =?utf-8?B?bnA2TFBYc0VJUHRRNFh2VllWU1QvS1NsZ0UvYkRNL1NTekpDaXVKNFExSjFl?=
 =?utf-8?B?K1kwcjNiYkwwZ3NBTkV2S1l3RzF2Zk8yTTUxTTVwSjZtaUNkZEdpUTZMT09L?=
 =?utf-8?B?ZWtUVXh0STdoY0NVdXFCeG9rQ0dXU0tueEZnOVdvbURkU290ZmZMZHlza0JU?=
 =?utf-8?B?ajVFRStqODIrNjJJdVh3QWVxV2RRaHFLT0NKbmxlQUFDWXNxT00rbVFGbE5U?=
 =?utf-8?B?SFNTaEJKM211d1o5cmZaOFUwVEJkc0w2Z3IzWFdSR2c4S0YwVW5yM3pydncx?=
 =?utf-8?B?QVhNUjRyY3BmUkQvZ3didVlpVERNSm9iNjVRNVZyMzJqMlRJYkxkb0IrU1da?=
 =?utf-8?B?MU5JRVdwMXVNODYwbEhwbmJ2MGdqQXN6NGs4dEE1bW83TzRiS1JIWjAxQ0Mv?=
 =?utf-8?B?VkRCQUdCMkRuV2oxUmdDSnhzM1lZTnIxUVIwUHRnY1JZcWJDUmJYUStnOGl4?=
 =?utf-8?B?OTdoRmNjSU9Ta1VWekwvaFVzQW9Hb0FCUyt4UWVYdnRmWnVSNE9kNkZ1UUhZ?=
 =?utf-8?B?SkdqanlNL2tMSDZnOGJDZ0V0eEZhbmQrMGNWOS84TmpnK045UHFPZTRaNDkv?=
 =?utf-8?B?ZU41d0hrT090KzFYcFd5eXRjcnIvTUJMWFp4NmtCckEvaFUydnFVWTVRVThM?=
 =?utf-8?B?WDEzZndYN3NneFFjK21lanlGSnRGdnpWdjR0Wi9YZ2VTM0M4K1ErWnhsVkpW?=
 =?utf-8?Q?sTKPZOy843MlVvHv7vSK3XBFP4+tBHXPjXRhri1S/qDNB?=
X-MS-Exchange-AntiSpam-MessageData-1: Vi0laHGmnHx3Jw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fb2739-5dbe-4c81-126c-08df1f032389
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:25.2745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S14aadyeYqm2hbcnmPN8gF5cCc/XSPUB/lF9s7pj9bk1kvKx9WydJaBC53hpVH81m23KRFbJpdbNqLwjLP9NZg==
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

Since we are going to introduce a second type of message, add `rpc` to
the names of the relevant command queue methods so we can distinguish
between the two.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |  2 +-
 drivers/gpu/nova-core/gsp/boot.rs         |  6 +++---
 drivers/gpu/nova-core/gsp/cmdq.rs         |  2 +-
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs     | 14 +++++++-------
 drivers/gpu/nova-core/gsp/commands/rpc.rs |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs    |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 75a3ba7d50f4..ed7eef21e8f9 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -221,7 +221,7 @@ pub(crate) fn new(
 
     /// Query the GSP for the static GPU information.
     pub(crate) fn get_static_info(&self) -> Result<commands::rpc::GetGspStaticInfoReply> {
-        self.cmdq.send_command(commands::rpc::GetGspStaticInfo)
+        self.cmdq.send_rpc_command(commands::rpc::GetGspStaticInfo)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 8e446ad1eac2..0d0b07fafd4f 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -43,9 +43,9 @@ pub(crate) fn boot(
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
 
         self.cmdq
-            .send_command_no_wait(commands::rpc::SetSystemInfo::new(pdev, chipset))?;
+            .send_rpc_command_no_wait(commands::rpc::SetSystemInfo::new(pdev, chipset))?;
         self.cmdq
-            .send_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?;
+            .send_rpc_command_no_wait(commands::rpc::SetRegistry::new(ctx.vgpu.state())?)?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_bundle = hal.boot(&self, &mut ctx, &gsp_fw)?.or_else(|| {
@@ -91,7 +91,7 @@ fn shutdown_gsp(
         mode: commands::rpc::PowerStateLevel,
     ) -> Result {
         // Command to shut the GSP down.
-        cmdq.send_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
+        cmdq.send_rpc_command(commands::rpc::UnloadingGuestDriver::new(mode))?;
 
         // Wait until GSP signals it is suspended.
         const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 06386d1ab192..17cbed8277f3 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -58,7 +58,7 @@
 use super::regs;
 
 /// Marker type representing the absence of a reply for a command. Commands using this as their
-/// reply type are sent using [`Cmdq::send_command_no_wait`].
+/// reply type are sent using [`Cmdq::send_rpc_command_no_wait`].
 pub(crate) struct NoReply;
 
 /// Trait implemented by types that can be sent as a single command queue element.
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 7ec0fed76637..627616140162 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -159,7 +159,7 @@ fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Res
 
 /// Trait representing messages received from the GSP.
 ///
-/// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
+/// This trait tells [`Cmdq::receive_rpc_msg`] how it can receive a given type of message.
 pub(crate) trait MessageFromGsp: Sized {
     /// Function identifying this message from the GSP.
     const FUNCTION: MsgFunction;
@@ -291,7 +291,7 @@ impl CmdqInner<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command<M>(&mut self, command: M) -> Result
+    fn send_rpc_command<M>(&mut self, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,
@@ -328,7 +328,7 @@ impl Cmdq<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
+    pub(crate) fn send_rpc_command<M>(&self, command: M) -> Result<M::Reply>
     where
         M: CommandToGsp,
         M::Reply: MessageFromGsp,
@@ -336,7 +336,7 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
         Error: From<<M::Reply as MessageFromGsp>::InitError>,
     {
         let mut inner = self.inner.lock();
-        inner.send_command(command)?;
+        inner.send_rpc_command(command)?;
 
         loop {
             match inner.consume_element::<RpcMessageElement<M::Reply>>(Self::RECEIVE_TIMEOUT) {
@@ -356,18 +356,18 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
+    pub(crate) fn send_rpc_command_no_wait<M>(&self, command: M) -> Result
     where
         M: CommandToGsp<Reply = NoReply>,
         Error: From<M::InitError>,
     {
-        self.inner.lock().send_command(command)
+        self.inner.lock().send_rpc_command(command)
     }
 
     /// Receive a message from the GSP.
     ///
     /// See [`CmdqInner::consume_element`] for details.
-    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
+    pub(crate) fn receive_rpc_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
diff --git a/drivers/gpu/nova-core/gsp/commands/rpc.rs b/drivers/gpu/nova-core/gsp/commands/rpc.rs
index 0176ac79fb09..a218453d6bef 100644
--- a/drivers/gpu/nova-core/gsp/commands/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
@@ -191,7 +191,7 @@ fn read(
 /// Waits for GSP initialization to complete.
 pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
     loop {
-        match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
+        match cmdq.receive_rpc_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
             Ok(_) => break Ok(()),
             Err(ERANGE) => continue,
             Err(e) => break Err(e),
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index ebf13867746f..ab3237ed64d6 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -344,7 +344,7 @@ pub(crate) fn run(
         bootloader_app_version: u32,
     ) -> Result {
         let seq_info = loop {
-            match cmdq.receive_msg::<GspSequence>(Cmdq::RECEIVE_TIMEOUT) {
+            match cmdq.receive_rpc_msg::<GspSequence>(Cmdq::RECEIVE_TIMEOUT) {
                 Ok(seq_info) => break seq_info,
                 Err(ERANGE) => continue,
                 Err(e) => return Err(e),

-- 
2.55.0

