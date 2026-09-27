Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB30C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3FF10E4D2;
	Sun, 27 Sep 2026 13:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="loSJLp6q";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9BB110E4D2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzCVbLX8LfVnCAeuoYQRs80u7FM0HrD/hJDw75bB3BUPKi4HA0UdnulfQPemAodjshNmLOOUxdwL7BSxM0BQgsG98/3VJ8p8vPQmmb04LLvtkUYIYFfDzCf2WSzQevJtM6I9b8c4kbjJ/Ze1mLWTCBIi1q6eREdBlU7Y8XEiNNaGExnhy9RZgQmzxC9gusKKlsvr0njkKt7Yrvgeh5BIJmBA6MporAfH8Qk2BAsD3Kk/XnaMdbDXZtoELFZIZQhPUdsMzlB0pjSwwPAWySirh3Il6VqSaJwJjGyfeM9ncVNW2x0ExplTJ/NzEvEAJ5lzUBwcAz700I3wGB4F5BXtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T9RVSZRy1OZ2IxmrWqmPBKyTAL6lg3FZAwYDzt/E28=;
 b=sghjRJG73A/6BfU5vm090tJP/QcxsxIkRg3FW7XwYYQjfeHbvL4S5EZh4iBn2W2v0wH0d5weae25BCVqh/F+NYfX+zuVtz/fauw6yVTqqSpSk5YfzERrN7h/b5K4v+d8p8zoCSI+laG2ng0i65aLvwRfMMfKsx//HG01pJpFeHaypuMdLxQX6apyQRjZL+b9MXOJmnU1lWM7L414sbPxZb3CdclQxpCO3ApWxSdjIYufH673KmZMdwyIvvCUP9ev61w3kiNDAkXN0kUdiLE3MflIm+vLaaQQu2xHToJPq1fmVpC6rlqnxSLtTsvxaBmd+5/7sf5P7CTtvU1QanMcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T9RVSZRy1OZ2IxmrWqmPBKyTAL6lg3FZAwYDzt/E28=;
 b=loSJLp6qEDa2cSLLHDC5+zJn3CgeGRnbVo3yzRdtRrZu6bvevEGPnQ9wjszbpr9/d0WOQxVL6EFJ83/8ZBkOgSDLp7ehTsD8X+WmrZPw8huVzSpTX1Rd6pgpRgVNMtjvv25xbl7HeRqmwM2L6XzuedzJ6jAkke3JNM1DZW39UHLKjd+h/ovF+BeI5WI57EbeN3hRV9pPi/rOk+hhjd2BuHpvLNx0MQJ7EiYGoC09MlfXkHqz2roGD3ZyhKNvVajC09XcTkneE4VViIghRNKjwnjmUASCDe4KLUrFf90+pjf+NmdgvTaziywXnswmhM+DLnMyhpd6kROn93sibeYhGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:54 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:26 +0900
Subject: [PATCH v2 9/9] gpu: nova-core: gsp: add `rpc` to RPC message
 send/receive methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-9-c3f66ae73be4@nvidia.com>
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
X-ClientProxiedBy: OS3PR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:604:de::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b55f150-50f5-480b-e249-08df1c9dca1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iTmMK6ZJGQTocUEBJrqEpEj33FKLn17X+xH9hl6Z7KWDkKNZLEEqZpgNB8UHsTwtHLTNLx4BWLbWsIVotgaLNZrI/Q3w+8H8nqZwT3JSG8IlJ26wVpChKBa7uUwxC+x1yyx1XVSkfxqgcO1kkwVwhVG1qGp8zaN+AiKxROt3qCKUrEtOJA5MxSH1X5Zz28bd3uGpxDijxOmu6ihvz+615xNIuBZvn0XgJZFJHoIisnwqmqNGRs2ViIHdpaiDqGOVQQh2ZGfRIxrpP4+QnmCvQ7+z3HODCY60jPrYMOEr9HDSd6NkD7CrDQcbyassOi3TiquBp/v95T/Kpqd6WqVZHsb5lfpPbduv11hOA5q839WjO93BMt8vyj1B5c8tKkki61oUSeSV6bJdjjbgNjtgLDEolI4iXORUBppGMcqvObdADEecRFlRC8aJfeggtcqWKAjaB0S45YAXoDDRSphEA33KUR0hnQQdhxC/KojOy9G5sh1KxZK2tR1DNIyt+4yCNR26gpjr/RNE85XkyTD2aHuryWjpd2NtniR9neK5R7MdN6ZtODhyzvqyBWxQfLkeUCo2moiuA2TATh+gnHXKdQ14RjekioBTmDs86hxsTgOYzR2tz8x2DrhEHWA2pRKcSTiYOMMzaneeeDW3N3MLfbSKW1BGrPb514wqua8kmlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjE2VkRtM1ZwQXQrd09IU09lc3B2dDViMWRiU29uSjlmKzE2ZjZKSFdQZlZv?=
 =?utf-8?B?RGF3d2Iva29VL0d1OXFkeFNFTUdmMmRLNVVTcU91OGxVRVk5ZVhvby93bEZj?=
 =?utf-8?B?dTVhejdMVnFaQlRsZUpPaUFSa0NSV0hGNXk5dUxrM2IxaENDQzlKZzB3bWxy?=
 =?utf-8?B?K3MxRGpiTHdndjNFOCtwa3orZkJxeVhianhEamNpVWRRazNRWjNYVTRYQmVt?=
 =?utf-8?B?ckNxNVltdUZrV0dXa3ppVXdIU1RBdDVFemcxSXVlTm1TWXZ6eHRvL1FHM1hJ?=
 =?utf-8?B?SWtobnVtOWFMZWNBK1lLSExLRWMzNXJ6Nkcrcnk0Tkh0eXBpYU41SDlNMXdY?=
 =?utf-8?B?eVlINDJkS2h2RHljcVpHSWtlWlZ5Y203Q3lRMXBiK3dCdklpVVdka09lNTNK?=
 =?utf-8?B?T2NwYWJDQjNmRmF3R2N1TGJnWk96N3BwZmJVZUtjRzlsQ0dvZlhwTE9sZnY1?=
 =?utf-8?B?Zy83aDBMUzdsWFZCRlh3Q25oSGNMNzFCUjNqd1pMekNsekxkSzBOcngxSU8y?=
 =?utf-8?B?R0d0QnIrQTluVEN5VFZjSFB0T0orYkdHdWdGOTltL0E3ZXdEckNDYmFrVGJs?=
 =?utf-8?B?K2lrWE9EUEsxOFhKVVNVckF2ZUxBWlA5NDVZZDhPRnEwMUlSaTl6YmpzdGdm?=
 =?utf-8?B?S1hPWHFtREo0eFFtL1FYdDVnbVFsTThTaVYyQ3RGaGlvY2NwZlF1cnY0OFMw?=
 =?utf-8?B?cVpVejBXcGZjb0Q2VGtkalRuTlhvb1Z3cFNkMVpTNEFyUDNKOFlpMlVKWm01?=
 =?utf-8?B?a2VjTHBDdjZRK3ZMVVlSSmpGVk5CeElJQmw1QmhKc05KcTRuSXd6OUkwOGI3?=
 =?utf-8?B?OHpucXl1NU91bVRJK29DeVlibUpxTENUT05uNkVuQXI4NElqcGdJZ20zd2o2?=
 =?utf-8?B?UUNEZllUVzF0bk1GbnVvTzZPeFkyU1ZGVGg5bDIwVHMwTERQUHpUWjZhQ1My?=
 =?utf-8?B?K2N0Y25KVUowc3dBV2wzM01ibUVaOFVhR3pFV3l4cTVpSFF0ek0rS21sMmtB?=
 =?utf-8?B?U3EzRFJSV1k3UDVzZTBSWDNBVGJmV0tWYmppVGdJQm0zL29qcnNDcXJ0dC9p?=
 =?utf-8?B?ZVJmNmtZUTN3SVlMT09hSjZHM25jbjhDanBydW10WHFtQWptUlVuNXd5V1E3?=
 =?utf-8?B?dmR5TWlLL1JWQXQrQkRSclBVd2owN0VmL1NqWlVhRnRzeVhWSWZpNWlHenJ2?=
 =?utf-8?B?ekVEcTUxS2ZiYmdGTXhVZ2FYZFhvUmVQbndaZ2dLQVF6WUtoODl3U3VWck50?=
 =?utf-8?B?R0lIdjZ1RGQ5RlVIdDRTS0dDcVdqVzZXRVNmOGhPVldGcW9zWWo5UEIyVDZ5?=
 =?utf-8?B?ZGNWd2kyVUh1bnhrdDIxcWd6eExybnpOWnpHbWM5dXR6K2d2NFIzK1MzR3Zk?=
 =?utf-8?B?L2FqcGh0aU83bXJqZTE2ZzkwR3dJMTFLbktwNnVyWEN4YWVYRkh2ZFdOU2pC?=
 =?utf-8?B?V2NEaHZIeGJYMFFiUjladEJsREZmSlJyN1RWR05FdHUzakl3V2QvY3dUWUVv?=
 =?utf-8?B?SGZ0R0FmcDhPeGNrYWtzbWRVcVNWcU12Q0VLbEZBdmZNcG5CVE9qYmVUaVNa?=
 =?utf-8?B?Ykl3U2NXeHg5cWlpREV2VVdWKy92THdDdVZrWGsrMTVaZGFiMHpYZzQrS2tI?=
 =?utf-8?B?RUZScnErSlcxeHhiSTNPcE5JZTBNa05UU3dNMGVjZ2F5L1hPbC9vUFVzSE01?=
 =?utf-8?B?RUV0bzQrak5FRzRudEs5YWRTd1U0OHpmV3FnOGUycXhNWHl4dFZVcWNiNGNk?=
 =?utf-8?B?Z0JHSTk0OXB3RnkwMFVnUjM3YUM4MmtzSTJ4S2VJYmFkNTlmWVpyazJxeHdR?=
 =?utf-8?B?ZFlKdDViRUpxZmtJcG1LTmU3MmZwbVZsWWhHbnhNK2ZJb2ZwaVJaRk9McGxy?=
 =?utf-8?B?akhjd2RJTVRlN2RhT2M4TGZ6NkQrMDJKdkQxcGxUOUZkTllCU1JoWERyZmow?=
 =?utf-8?B?ekxVSVNBZ2drL0Q4aDFuNGFzUlVLOVI4Y0piTGdkWldVNHRwczNvSzd0OHdk?=
 =?utf-8?B?a1E1TnM5N0IvUnpBMi9wdEFWS1pRS0pyRCt1UHB1R0Zwek5Uei9TUkpYdEph?=
 =?utf-8?B?ZENLVGQwamsxVGJPZ2ZDMDQxalNtQWhsZGppd0xuN2syUzBxY0VtTzVNbzNl?=
 =?utf-8?B?UWVRR1dOY1VscDl1cnNUTFpHNDZwb0FqUHZoV0lnZ0RRaGxIeDdzVkREdWpp?=
 =?utf-8?B?QnAzOWZWdDlhaXlTWnNtRWtrRWRHVUFxdGNYT3E4V3poSlh4eGh0RkRWL2hl?=
 =?utf-8?B?NEh4cDlHUVF6UklvVThlaTlITWxlaU82aGFrV0pkczRFK1dyRHFPWFc3TUMv?=
 =?utf-8?B?NkZpM0FwSHM3a01vcWxyZ21WaDY0QzJoWFFpdDZ5Q1VFYjN5dUM5TWZLKytS?=
 =?utf-8?Q?F89t6TOJ9VY5nSKV/KU5W8Lt0lLxnZHKF52k89WzniF0Q?=
X-MS-Exchange-AntiSpam-MessageData-1: xjX0qPOKV6XGrw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b55f150-50f5-480b-e249-08df1c9dca1a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:53.7264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCjRSmTCKGZEU00zP03FqkiQtWq8+QPEIfh24x/niOJfDAI2pyc/jdEvIlMHqSrTsWCr2GwwNjJRJcgoiCrhnw==
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

Since we are going to introduce a second type of message, add `rpc` to
the names of the relevant command queue methods so we can distinguish
between the two.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs              |  2 +-
 drivers/gpu/nova-core/gsp/boot.rs         |  6 +++---
 drivers/gpu/nova-core/gsp/cmdq.rs         |  2 +-
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs     | 30 +++++++++++++++---------------
 drivers/gpu/nova-core/gsp/commands/rpc.rs |  2 +-
 drivers/gpu/nova-core/gsp/sequencer.rs    |  2 +-
 6 files changed, 22 insertions(+), 22 deletions(-)

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
index 16e40a52fa57..4fe23a33aa8b 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -58,7 +58,7 @@
 use super::regs;
 
 /// Marker type representing the absence of a reply for a command. Commands using this as their
-/// reply type are sent using [`Cmdq::send_command_no_wait`].
+/// reply type are sent using [`Cmdq::send_rpc_command_no_wait`].
 pub(crate) struct NoReply;
 
 /// Number of GSP pages making the [`Msgq`].
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index a0e1e7e20ac3..a8bf3d6317f8 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -104,7 +104,7 @@ fn size(&self) -> usize {
 
 /// Trait representing messages received from the GSP.
 ///
-/// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
+/// This trait tells [`Cmdq::receive_rpc_msg`] how it can receive a given type of message.
 pub(crate) trait MessageFromGsp: Sized {
     /// Function identifying this message from the GSP.
     const FUNCTION: MsgFunction;
@@ -136,7 +136,7 @@ impl CmdqInner<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_single_command<M>(&mut self, command: M) -> Result
+    fn send_single_rpc_command<M>(&mut self, command: M) -> Result
     where
         M: CommandToGsp,
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
@@ -197,19 +197,19 @@ fn send_single_command<M>(&mut self, command: M) -> Result
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command<M>(&mut self, command: M) -> Result
+    fn send_rpc_command<M>(&mut self, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,
     {
         match SplitState::new(command)? {
-            SplitState::Single(command) => self.send_single_command(command),
+            SplitState::Single(command) => self.send_single_rpc_command(command),
             SplitState::Split(command, mut continuations) => {
-                self.send_single_command(command)?;
+                self.send_single_rpc_command(command)?;
 
                 while let Some(continuation) = continuations.next() {
                     // Turbofish needed because the compiler cannot infer M here.
-                    self.send_single_command::<ContinuationRecord<'_>>(continuation)?;
+                    self.send_single_rpc_command::<ContinuationRecord<'_>>(continuation)?;
                 }
 
                 Ok(())
@@ -283,7 +283,7 @@ fn parse_rpc_message<'a>(
     /// - `ERANGE` if the message had a recognized but non-matching function code.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
+    fn receive_rpc_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
@@ -329,7 +329,7 @@ impl Cmdq<'_> {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
+    pub(crate) fn send_rpc_command<M>(&self, command: M) -> Result<M::Reply>
     where
         M: CommandToGsp,
         M::Reply: MessageFromGsp,
@@ -337,10 +337,10 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
         Error: From<<M::Reply as MessageFromGsp>::InitError>,
     {
         let mut inner = self.inner.lock();
-        inner.send_command(command)?;
+        inner.send_rpc_command(command)?;
 
         loop {
-            match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
+            match inner.receive_rpc_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
                 Ok(reply) => break Ok(reply),
                 Err(ERANGE) => continue,
                 Err(e) => break Err(e),
@@ -357,22 +357,22 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
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
-    /// See [`CmdqInner::receive_msg`] for details.
-    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
+    /// See [`CmdqInner::receive_rpc_msg`] for details.
+    pub(crate) fn receive_rpc_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        self.inner.lock().receive_msg(timeout)
+        self.inner.lock().receive_rpc_msg(timeout)
     }
 }
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

