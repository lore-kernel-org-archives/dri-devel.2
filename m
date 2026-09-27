Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569A3C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2DFC10E204;
	Sun, 27 Sep 2026 13:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="icysub0a";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E3310E204
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISBthkktUHenPLe7pFeX+z0X/B1p1H3L1ZatRZOUwdYuehfVs3SAj6MALmbBWmAjsZ/oDB1JIOYkCGBnc19wapF0AoC5AO2kugHLiKm0fOlPiUr3jTTbQQaf+ifppczHneRt1mRtou7VI65vcw61NxFCtlrHMNZyV9QzKCV4OGtac53uOBKc14AmfFisO6AjpyvnEtbTY4pz4zvCFPCS2VtaqHYNyBodAXjZsib2H6lgQRS36V9TkM88CsJ1xVY/CZRRCFUZRN/McXO5BvixF7fZ/NJaqCmRB2fGLzd6CANiGzvfxFI0UglT0+S0tpaLW+n/6bB77ac7xKMbziVCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OJRAsS9F+62y0udMRmGAoTHB/3EexUYx8GoGQxcudg=;
 b=Tj4Zg3ICuc9KPJLep5cFyqwVChBdX16plNx/eQw9cGgVbPH2hojQZYAponIRqgCvoh0mSTwep/BCtaF4wp2r49omzSL0ukFrCjd7ifaIU/MroxhjtKw4WmIuzbd/FeH6idUW60bQlKnwPNtv245w5cXzOM+2eDaQ4WnFYnSeUaRJHSCY0OzNfUcwKA6BlKnn33KVtKhrc6mqT2xtGkByF3hilhLVAAiGsekI7Uu9hdkPzEMiORJBuZUp1yMrqxs/3MRsdsgku5OVg7GceXWdY0A9COqwy/vxWfPdwA2OKSnGkeegb0v3ZwvXnsLywH9rv7aO1ZpqbHfMxuJl8MMLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OJRAsS9F+62y0udMRmGAoTHB/3EexUYx8GoGQxcudg=;
 b=icysub0aTCePs21wNeYs7jAI9OiSJOwQpP5jJ17K68IMOTeozefqgrqLpwCtt+A9by5zzUkYVVzwWN09tJI308VxJwTyoVAGU371StTl1cg1C/LHsUUuimyyrVu8u0WvM3BIgaa65S1mjqBnXGezlmeEx6hmX45s385cVJzrGX0gHLvtqCNdKxsahu3wa2om5P1hUZD9fTw1s9kUX5XNGKqN4rlZWhbP9ffG2ZaIHkZpxw/SPjgV4rIXSkakxKzBV+/ZSHTHHR8Ds7kNvqz7/8qNxRaBO87GlbSItjLzX+BLuP8KruIPmQF5nQxUGtQgV/4WS8oDfQCC+NlvdJ7eAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:37 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:36 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:21 +0900
Subject: [PATCH v2 4/9] gpu: nova-core: gsp: cmdq: split the transport part
 of the send path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-4-c3f66ae73be4@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:604:24a::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc06104-ae13-4041-21eb-08df1c9dc011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J9eS0d5opyHWsuEL1YAhFrNTbS4/nSwxjIyA9RUwItejhRH4XyYBsmH/yOrBHloX0XylDh9rUgMBQSJNmnFmXSYDjZ/sR5hN6pdVIthcFNEiibzroil5tvtF1FsRuBhmJmuz/r4xHmiSUuOExGb3D49PflNeYVcYa1ErW0ykftfJDvH09ZXnGaAMyx8OXLKmMWFRUyxHH9thty/JRIo5b1gSalSyXhWzJ6esupEeL8GxT5p0y/irVGaYIwhStgTEcoTJ9bVJENyvFW4LFZWgzLhxxOQ2Rb/YMLhSa+UZ0z6OjVtWWiDmr9votuBvAveFXKJeg00Iu81B/7X/FIMK3qN1Da65CnLXxcEMF+UGehS8GeVjEJTeBjDEw8Jgj9BbpN4ef5PMvdb/9y21OJfj2aJWlox09ZbRnZZURD9aK88dxOb7cYmIC4Ax+418plgpzJ0KdDUeDU+GArTDfvhCmhKLFcaoZm26GwVbadIYEQrbLu82g2zo0OxJDjLkHmHfZuRORwKc2pU+udCCm2ZXPKsKo/tYElXm+LKb8iuu3KeCBG2u5tULzEJSoeFjbJiEAystjMIUxS49r0IjWUBM+wcCYwaqhaPUtCUV8eqIOWpmhl25qRuZLvvGvNF3VMgcZFT9/FGXOLuqw0PhYO+TuUUCiwJHfOHI2Ya9yyHCCBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnlIM3hOQnVKa3h5ek4xb0pYRkF2a3dNSlh3WTV0M1FobW5xRkJBY2RyeGVv?=
 =?utf-8?B?K2E5aHRzT3FLbnRWZjNRQ01keXBaNUhrZHhTSG5scGZRL040SURjUThRUjVp?=
 =?utf-8?B?aGFhMHRDTCtYSTVoRTZsZENVN3FiN3dFUExrdGsxYXNRUVNUWTNYdWJvQ0Y0?=
 =?utf-8?B?NXBUdmdQZTJnbEZkeVRFTHRKK3FLOWp1M0g0RFNxQ2syUDM3YnN1c2tPV3c4?=
 =?utf-8?B?OHpadWZ5TjI1bzhuclhKSncxUkJPbE1WS3AzQ2RsYVpsZzhNK0p5REZ2Wjc0?=
 =?utf-8?B?OVRSS3lHQk1peW9HNjg0VG5zRG5lRTVKQ1owU0RrZkdYV2F3VEFnNWVxSGZ0?=
 =?utf-8?B?SzM5VHVNNGkyWnRsdDlZbE5pRE41RWJGY3VRNjI1enNJMFVpQWRZQUxxRVdV?=
 =?utf-8?B?d1lWd0MxcWF2dzEra0dOekR2UGNlQnJzSVNYV05zOUlZcmdTUmxzdzNwWkVm?=
 =?utf-8?B?cTZCZnNycm5WbDA0L3JSbStoWUp3ZEY2cEN2bWdxZUZNNFlqdUdJTkF5RVRR?=
 =?utf-8?B?eWkzWVU5V1BhS29kdzBmVjc5ZVdzcmlzbEsxYmFOenVzMjdvUkdDZlhFNHEr?=
 =?utf-8?B?T2VJdTliZXljL1NnUmN5eEN6ZHhEaUlqUTJhMkVQVkFhcU02YW5KVFdxYXdP?=
 =?utf-8?B?eGNCYk82WGdCRWJIVFVzN2txT1lKNFAvdU43TTczOEt2dFJsWDJ4eXBzTndO?=
 =?utf-8?B?amluUm54bHN6a0RhcXZhMVdEdGkyRjhXQ1hFNmpneG9HQ3F1em1UWTlINmtP?=
 =?utf-8?B?RThNRFBHYWw5KzB4R3RoTURvbHFSQ0F3eWovODlrZ2FQam5ya2wzTmhJVG1w?=
 =?utf-8?B?K0RmeHk4Z01JbEhZeHI1UEpMdVdYRHErTndndlpHT2hZb1U2cjhhYXF0eVpJ?=
 =?utf-8?B?QWF4eHRnVzcyZ3FPb3BxUGJKYVpyRWhwNWpMa0wvZDI5eFYrQkZuVkRjZS9i?=
 =?utf-8?B?RE5NUWp4UE9ydXVsRXdiTFF0SUxTZkh2aXVDQ1NFVDZrRXA1bmFPMnMvQ0hT?=
 =?utf-8?B?dCtrRVE5bFRBWE5EbDJwZ0JCeFFIQ20wajJvVVc3elJVV20vdzBRV1BoaXFU?=
 =?utf-8?B?ZTlXZzRNaG1PSGFUYk41ZjNCandjVW8zRldybWJPTTBQaWpYRmZuMDZTUVFn?=
 =?utf-8?B?K3k2bk03WCs5SnRvUkVMKzZMbVYxZldGZC9naytObmFmTWFOWXRDSjlCdU9i?=
 =?utf-8?B?SDE4SE43c1JpNUZEazFsc2FMQXAyV0hPMWtFTnhYT3JETXRQajZ4TXJTa2hk?=
 =?utf-8?B?OXRsMGl2TXNNRk5mNVpJOHdzcS9oYTFmdjVFZVdZOFJtcElKQzNZVlF4RGM5?=
 =?utf-8?B?aFMwSjZJRGVPbGFDeHJRMFpnNUVJU2svei80UzU1d3J5WEI1SDRUWktlVVJx?=
 =?utf-8?B?QVRwTklJMjhMQlRjYUs3WDUxZkpKUUVPMFNERW0xOUMzaEZPNkM5SndwYTRx?=
 =?utf-8?B?TkFYVllVaS9qV29BNjlDeEZWOERhcDNwdG9HRHl6enFPaFA5QlFWRlR0Qk5x?=
 =?utf-8?B?Y01xaDJla0NOT1J6ZjRUTU1HeG5NZ2ZQbFIyYXMwc2o1RGtRUDI1RlJ2ZHpE?=
 =?utf-8?B?OFVPR2VZTEpTelVxUEFRTDcyZkY1V1BqaGEzT1AzdzV2QXVtcEVlRlVybmVj?=
 =?utf-8?B?T2ZiTVpvM25SMGdDdW0zME5rNnFkZHo1RmxqaWR5V1dBM2k3TG9aL1BDem4z?=
 =?utf-8?B?RENQRi8rTk9ML1JRSk10eHhzQnM2SjFJay96bVpBbzFGem5BaVM3dTZZSkho?=
 =?utf-8?B?WDlKUjFlY0NXdkJDNmpuTllXNnRXWG9ybTQrd2t5VktOQXFjY3lwU1JjMlR3?=
 =?utf-8?B?enMzRmFadFRObFppMTRzQy80OWtvbHpTc0JMOGJ6dTRQWGRDenZmRklGbVFY?=
 =?utf-8?B?QjQ5YlVuWllGT0VGeERuOU52SWVReDZGby93V215cEMzNm9RbkwvUFpRWGg4?=
 =?utf-8?B?QzZWODJoZEFPTWd4YXdmMFEwejh0cGZIbW45UXFLOWp5UGwzakJpQzQzYWxq?=
 =?utf-8?B?V0tRdElHT0h5WUVJQ0tmenNqR1VIUUhNTWpWKzRqQ2xvUHdFYWphQTgxMzYv?=
 =?utf-8?B?dEVVZDFsSitLbm9pVlFKcTRkY0RHekRpa0w5dHlFbldjRjl3Z200cnFGV2Zr?=
 =?utf-8?B?UTZaQnZkc0d5YjVvWG1VMERaVzA1Q0tFK0lqcisvT0ppV3phZzUrWGZOd0lF?=
 =?utf-8?B?SUhpaEtvbVhhMFc1SWZNNGFEeUFKZGFDRTg4eWUwaGJqdnNjQ0dMNEJpd0Fu?=
 =?utf-8?B?MGozakhxZFNQYkNrV3IxZlZjZ2Y1U1hGM2plTjRGWmNVZTFiQ1p1VW9iMUc5?=
 =?utf-8?B?ckJnaTlobXR5VzVTM20wUjFKTGpONy80V2pPZWxaOFFzZW5JTTAzRUlDRWlh?=
 =?utf-8?Q?RzduAsCcBlQTh+QE5Lt6l4ZdPJdeCM5VaLp1Ih8s6tdqf?=
X-MS-Exchange-AntiSpam-MessageData-1: DQdRfq5iQUliJQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc06104-ae13-4041-21eb-08df1c9dc011
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:36.8782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqdlAsidaPkr2iRXcSi6JUpN7uoFwoz/Tnih+3eDMt9PH+KmucT5Nui+sblh185u4WIIGK+o33Kj8YXy2f8yrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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

Move the transport part of `send_single_command` into
`send_command_element`, which allocates the queue slots, writes the
element header, calls a closure to fill the remainder of the command,
then computes the checksum, advances the write pointer and rings the
doorbell.

The RPC part of `send_single_command` (writing the RPC header and the
command payload) is passed as a closure, unchanged apart from its
indentation. This sets things up for moving the RPC code into its own
sub-module, leaving the transport agnostic of the message type.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 118 ++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 07e8e32c3d57..b6d50b0bd039 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -638,65 +638,35 @@ impl CmdqInner<'_> {
     /// Timeout for waiting for space on the command queue.
     const ALLOCATE_TIMEOUT: Delta = Delta::from_secs(1);
 
-    /// Sends `command` to the GSP, without splitting it.
+    /// Allocates enough send slots to store a command of `sizes_in_bytes` length, initialize them
+    /// using `command_init`, and send the command to the GSP.
     ///
     /// # Errors
     ///
     /// - `EMSGSIZE` if the command exceeds the maximum queue element size.
     /// - `ETIMEDOUT` if space does not become available within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
-    /// Error codes returned by the command initializers are propagated as-is.
-    fn send_single_command<M>(&mut self, command: M) -> Result
-    where
-        M: CommandToGsp,
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
-        let size_in_bytes = command.size();
-        let dst = self
+    /// Error codes returned by `command_init` are returned as-is.
+    fn send_command_element(
+        &mut self,
+        size_in_bytes: usize,
+        command_init: impl FnOnce(&mut GspCommand<'_>) -> Result,
+    ) -> Result {
+        let mut dst = self
             .gsp_mem
             .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
 
+        let seq = self.seq;
+
         // Fill the header.
-        let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
+        let msg_element_init = GspMsgElement::init(seq, size_in_bytes);
         // SAFETY: `msg_header` is a valid reference, and not touched if the initializer fails.
         unsafe {
             pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
         }
 
-        // Extract area for the command itself. The GSP message header and the command header
-        // together are guaranteed to fit entirely into a single page, so it's ok to only look
-        // at `dst.contents.0` here.
-        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
-        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
-        // SAFETY: `rpc_header_mut()` and `cmd` are valid references, and not touched if the
-        // initializer fails.
-        unsafe {
-            pin_init::raw_try_init(
-                core::ptr::from_mut(dst.header.rpc_header_mut()),
-                rpc_header_init,
-            )?;
-            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
-        }
-
-        // Fill the variable-length payload, which may be empty.
-        let mut sbuffer = SBufferIter::new_writer([&mut payload_1[..], &mut dst.contents.1[..]]);
-        command.init_variable_payload(&mut sbuffer)?;
-
-        if !sbuffer.is_empty() {
-            return Err(EIO);
-        }
-        drop(sbuffer);
-
-        dev_dbg!(
-            &self.dev,
-            "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
-            self.seq,
-            M::FUNCTION,
-            size_in_bytes,
-        );
+        // Initialize the message payload.
+        command_init(&mut dst)?;
 
         // Compute checksum now that the whole message is ready.
         dst.header
@@ -715,6 +685,66 @@ fn send_single_command<M>(&mut self, command: M) -> Result
         Ok(())
     }
 
+    /// Sends `command` to the GSP, without splitting it.
+    ///
+    /// # Errors
+    ///
+    /// - `EMSGSIZE` if the command exceeds the maximum queue element size.
+    /// - `ETIMEDOUT` if space does not become available within the timeout.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    ///
+    /// Error codes returned by the command initializers are propagated as-is.
+    fn send_single_command<M>(&mut self, command: M) -> Result
+    where
+        M: CommandToGsp,
+        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
+        Error: From<M::InitError>,
+    {
+        let dev = self.dev;
+        let seq = self.seq;
+        let size_in_bytes = command.size();
+
+        let init = |dst: &mut GspCommand<'_>| {
+            // Extract area for the command itself. The GSP message header and the command header
+            // together are guaranteed to fit entirely into a single page, so it's ok to only look
+            // at `dst.contents.0` here.
+            let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
+            let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
+
+            // SAFETY: `rpc_header_mut()` and `cmd` are valid references, and not touched if the
+            // initializer fails.
+            unsafe {
+                pin_init::raw_try_init(
+                    core::ptr::from_mut(dst.header.rpc_header_mut()),
+                    rpc_header_init,
+                )?;
+                pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
+            }
+
+            // Fill the variable-length payload, which may be empty.
+            let mut sbuffer =
+                SBufferIter::new_writer([&mut payload_1[..], &mut dst.contents.1[..]]);
+            command.init_variable_payload(&mut sbuffer)?;
+
+            if !sbuffer.is_empty() {
+                return Err(EIO);
+            }
+
+            dev_dbg!(
+                dev,
+                "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
+                seq,
+                M::FUNCTION,
+                size_in_bytes,
+            );
+
+            Ok(())
+        };
+
+        self.send_command_element(size_in_bytes, init)
+    }
+
     /// Sends `command` to the GSP.
     ///
     /// The command may be split into multiple messages if it is large.

-- 
2.55.0

