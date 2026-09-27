Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F39DC9833E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 391AD10E574;
	Sun, 27 Sep 2026 11:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="S46B0tOA";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B516B10E54A
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+mq/wru7UyrJ8wOvAE0+UR98y8ubYnUgO3gNXGntgduuJI0PYdzPUtxJXrL7AakeGw/PklEa3rgbnoZtFV3pP73E8o6zQ3wBpAX11GY3hXZy+t4q7WuQ5GMnRkr90eZCJQrnIgxlI0EfJoHfSktquKH4tpTCl7kEupIJcZtafnpK6VXClaGcHQT+Kag7IzeNVyCD67aYLHx5HZiRc0tmQd/L5b2cdrDoN+pNYVm87+WNPFmTIzI3Lw+JLvz2g1p2vtL+vT8C64c2ddDcFE14pWmRWIH9+iLzVgOZaM5rHQ6grq/3XIeoBW3esEOLb48zbVfaIgoOn7OwQgIaCHD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNQAQ3dUUr+A7BSyUP/UNoODH67iT3pTv0FPNQTmacY=;
 b=fIWfAf9L2tmUXpuhoTOauQhvsZllQDRdS0nsUuWyYQUVutsKd4a+qw7YkPja4bpEQCQvUrw/3wrqME/IL4/gyQ4qUYyAC+r7XvDaTowYmZotP2clfBF00GyY2Ss2ESdsqMzgBcsAgvJV8IKw4g2Vlb7+NDVjlo4gLz8Ffu7Pf9bQ+taRhJIhbVzILGKMQknUc/fkWizId6uUMDxBgpVUVmMSIqofsmVlKB5Ogi3+n2HonkV2rpbAjpoHOM5oPU0RAeyun/1ExDty9lP3s/UCUb0t19XqYansYSdHY/MHYQii60jPpBQsLN5neQ+qgDHhLJL+I3ZHgF5yHjDbJ2O58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNQAQ3dUUr+A7BSyUP/UNoODH67iT3pTv0FPNQTmacY=;
 b=S46B0tOAxtCASnaJ6werWQdWa/ffoTos9p7UCs5Kakjt54ioewbmnmccUGOMeuKamecQP9pXS169ZIs9z2W5igD1XUAigSxacPeDyMNRiFwF8rGUXujrMBUzi5pUiMK3YIOUT7tKeebXOH4K3ofKH0wntuY6KSA/YY9AK46ZpzF7rV3UNvwhEHVKx5Ggk2q4PFBeuPupgFTmgd+FYHDlIaaQS3rag9uVQ7dB544vitDg+S2ezVsy5a4O7Qor6z+l2uGRW3d5dT4nZD6zFOFLdOKXEBTLURgf+ZH5kE+mkdMuTwmjRWE/MLZjYrpgrpefkfbbYmUtJ6YWvU1hGrDwlA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:42 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:42 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:27 +0900
Subject: [PATCH 05/10] gpu: nova-core: gsp: cmdq: split the transport part
 of the send path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-5-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ea5923-f3e0-4916-6bc4-08df1c888728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CMlgtb6hBZTGZ3AZX8b+0p8h5xvG9M6uS1brB+Wkc9TRoBxZ7JqG90fFXPoLBKa6jOXiwNucUuRAHT8B7zTYLpK3ZNSHAqQ9pG/wJqw7ceJWkM2jdS0CmjyhfaVDseCjefLHC1/GVqOFNnPyfbFGmVtZpvrDiVew6ab2eNP54AsaT7XGfYUsVgmyxuuEoONgSyjXbNqy0ltBydTAxFvUOp9cWyFAGG40GmuemHSZQt7AiYLlyAjt/kPWSerL7qU53Qpmg0Y/eBu/3fjvp06A6ara2bvR7TR8kBlSyeeC7iSIn0+7UnNbWf5WwTyBTFFAd4QvHEFTOOrnSStb4HiWyXkEUOY2gzRAZceJQSqo7oblFaiEXIIZmrXBx6o74V95hu8XF6IeDvg+DsbpfJayLe+zQQyFJih2C2xmirQfsIgOOTGRSDhi3I7nUEYsWPy0iqLuVjdFbJKVHoudTVBudlsBPFBh9qT63QbYtF6k5HAwO0Cm+S2REtaxxByrcQcposuFSoHNOG08JRJcI+KL2T6VvNHdM/5OlTx9GE+qoZcpjwokX/yZa1GemGgeRp2m1hZAh4KDji3+Wu/ExXF49OA1ho8mQnV3hgmXOBflvUpPdl/PAvVv+MlC4x25+HYhx0PahjOppa57MGHRR/UNCqGPI5WHT3AT8v/exxRpLFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzNwUGdVSzJ6NFRjK3d1d1N2RmEvZU5ZUGFTYXVsTll1REhjaityUlllZG9m?=
 =?utf-8?B?TWw4eWVoQkh3cGFJRFFQNHppSHNsdFZVbEFta3U2aWpoYXROaDAxQ2dwMVNy?=
 =?utf-8?B?ajZCTmpkaTFGWTJ5M2ZoMlQ5QW5IbXhzNmZTU1hKOEhKcDNHcThlVGxnd3Qy?=
 =?utf-8?B?YmEyV0VGdFpvbVpWUjBRREhwQzkzNzlLYWRuYmo4OHFkVnFZUGlVR1NUUTVw?=
 =?utf-8?B?d3EvK2ZlNWdRUW5wenp6SDJlRnc3M2FKenMrYUxQeER2MHpkVWJoS0RtMDFl?=
 =?utf-8?B?UVhzVTVhRUV2amp0SDJBRlAxOGV3MExhdnZYRUdvbXZpMFpvbnc0QThHeFN6?=
 =?utf-8?B?eDFEUUxXcGNxMllWd01Id1YxWkgrWHhHdHgvWXgvUmNDWlBobDgwMGZtSlpn?=
 =?utf-8?B?K09KQUZhYXBvNDNPSlo1bzZQUFViaThia0ZGQVdRbUsyY1gzVXNONTZMZGZY?=
 =?utf-8?B?UEE0YThQb05zSjZEZmZyczNNc2pIcFpGN0ZRajRMSTRoRkhzejJNaFhXZjhw?=
 =?utf-8?B?SzBCVWxuU0RhM3VHRGdHcDB1cW9xQVZjMG5LSVhCZENQRzhDTkp3YlpRN1RH?=
 =?utf-8?B?SzRnQzJVeEhHS3hYQ25IMmduUGxiRjVkQllDR3pDRit5NWF3cW1NaUg3Ym9y?=
 =?utf-8?B?QlpsMUEwVEZiRXc4elN2UzRaSmZON0M3dDUyUEhxUlhLMHRnNDNGUDNtb2Nm?=
 =?utf-8?B?WVJNU012Tnh2c0J2Wis1ZVZJOW91d0g4OGVDNmoxRGhCWjJtR1RKRVhHNlFr?=
 =?utf-8?B?S2dXQzFsb3BDTHhCTDVnUGpaWWJtVURHdTJmS1Y1UE4xSUZOc1hCekF2YWRR?=
 =?utf-8?B?Nm5wS2tUcDZwSUdkVCtWd1JoSzUxTm5yNUN6bVZFK1J1dk94TlFyY2dJMzVI?=
 =?utf-8?B?MmRJdjRzcG1yb21CK2pQSmx6c2VwVXQrTzhYNjZtMlkwYnY4elF3SXY3SnRH?=
 =?utf-8?B?d1NKV3RFdEdQVUFmdHZrQ1dFT25rK0ROYmVrNnk5eWdMM3Fucjlka1RTRHEw?=
 =?utf-8?B?QjJjUE9QdFNVYUZYcnppL0JNNjNuU2wvNFkvMkJVc2hOTzRWR0VablN6TkRR?=
 =?utf-8?B?S00xSlhyYlRhblROdWIyaFdOOHR3VEVBaGVHaVVNNUovSmp4d29qWmVyaCsx?=
 =?utf-8?B?T3ZtMGw5U0srR3ZPM1dMc0tMRzF0Nm9DeDR6dUJuZm1xYzE5ZlFVNGVDdHJm?=
 =?utf-8?B?UHRtSFpuRWo2b3NQL0VNU2hSZ2JSWE50eUJQaVdUNytLekxrbFpNSFdLOW9K?=
 =?utf-8?B?Y2ZtRGEvWjdFSEtJZlVJRmFVUkVyL0phSTd1aWpXamlOWFpRTUdyWVVNZXd4?=
 =?utf-8?B?OE5tN3dZRllmaWdxQ1g0dUxPUi9KQ25HeHNxeWkxU2dmVE9LeUFKR1FZQmpy?=
 =?utf-8?B?WUNmQ2sxbmRiWDVvS0g1OHdnWTdSQjNlcm5CY3QvaUZLMG10UllhT3V0eHA2?=
 =?utf-8?B?dGYxc1VyN1dVVHRlTHNwUlFIZElINzA0a1B6RFZ2UkpiNjJ2V09PSThadzgw?=
 =?utf-8?B?cjNiZTF5SWZsT2hUajhUbnAxekRxcncwd1UwNlZFUzZCYWhYcXltYW1EWlRv?=
 =?utf-8?B?YlRoSS9wTkIxUTVzYzdhRTlWNVJJQitqSW0rWVRLcDhQS1ZmaDBublhrT1l4?=
 =?utf-8?B?ZWhQODZmSHRwb0YrcTZtMmxPVGNveTBzYzllVVlKd0JCZkxGWWRJOW1SZTdw?=
 =?utf-8?B?a2t3OGJhV2pJVzhjL01BQVhMaHYrK3BYL0huSnN3SHUyR1o3UDhnUE9STFdy?=
 =?utf-8?B?N0krWXh2RFI4RTV2RmJ6Q1daTFpZVFBlQVNXSk9ldjZ4dFJtVDNTSFFBMHB3?=
 =?utf-8?B?eUJMRHBwOFZ5V003TzJzN2k4UVRsWGVhdTBXZWllaGR4K2FabGhIY0tSVFZG?=
 =?utf-8?B?UlBmYndHeHFQckFQNjlDSUZwRysxOUlyZTBqVHNnNnZyd292a3NaQmhDRDMz?=
 =?utf-8?B?K3crQklwdy9jRHkwb25lTzVMM0Z6RWwwZzZ3a054SzBPeTl6YU50RE9TWG9n?=
 =?utf-8?B?RTRYMExkR291cExHZnZ2S0d3MVhTb01VY3ppMXBmVUZVT1QzYWNjMG4yZlVn?=
 =?utf-8?B?ZTlmSmFXZWVpaThVQTduR2NoeWJWR3N1dnorS1lwZHJBTmJlM3EvbHhDa2xO?=
 =?utf-8?B?cTJXWDl6VE41aGZja0hsdndYZU1IaFJNMkk2RE9iT0t3U0dBdXFOL0RQajNY?=
 =?utf-8?B?VUtzWUJsaXc3TU5XVEN5bmF0emJWKzdaRVpDeCs2eEJBcHJuQmptZHlzc2VS?=
 =?utf-8?B?MHNoK2dENDI5VXJIVjI2cGpSelNwQUR6bmQzTzVRV0dwRFp5eGRDZk55Y05Z?=
 =?utf-8?B?TzBnYlQ0QWZHdW1udjhYeGo0bjRsSGN6REN0dUZEcW5FMDJlZlZQdnU1KzJi?=
 =?utf-8?Q?AGGNzjXqZFJGYVHyb6fbzUFFanUK3ZNFB9juFWRpbyLPq?=
X-MS-Exchange-AntiSpam-MessageData-1: FOU/uiIta36jmA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ea5923-f3e0-4916-6bc4-08df1c888728
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:42.6169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2SUzCMIw6OzuuQRYbFDVWx+EGR9ZmgO2T5zoemhBj1tJFZBal3OrcccXoUcbwoLy9WAn+Ssl0Tf31EZpnZ3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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
index f0e4f8f5228d..602824236f64 100644
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

