Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5DFC9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF78E10E5FA;
	Sun, 27 Sep 2026 13:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mF2xGDQL";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32AA310E204
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeMLtMJfpwBS3g8ry1UyGIwv3jclLLo8q6e7mGcOorIVURqm3UEevgAKc+Ygd4kw89ydNL1vSTrpqvGfPJAaKsSBoGtxWfuyYVglzam7wpDLVWY3zqjVV+KLAIaBa8+7WV4lJZ1p699XpzCIR92NlH3Rlg+SXsWcywFOdMmM8+T2ecJ5g0LrUJYawvRWxUe6bEqPsPfy1Ok4L9h2yt8H9/9q9bK9xdaUi25LaBzTokp3ug8rabtqTkwrBnDdU41aW+qxDuRK6ofnoDdaxnHXL+S1Hr2NvCryU7CzAvJf309ApRpqYIjTpURBxhL9g8D0xN4uE42EeRdcf5ASSg3R1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud6sl+dt4fZFQbJdK5wMiGMIa0Ewr9O2EuG6KYxFQbc=;
 b=bTwqwcHYQ+Jz/6eVHcoc8CPxcRVNhvgGwnwmyevOancYfuFlyvc7AILzPGWxx54CBww/ziXlKuCvXusavzee2/sIylbUaz7q0TbPaUMMZtulO02K7f7cPSYwDA57VmSHDgwrfG5xUdgKo0D/VqSnkx3bTTCAA5N66Chh+pd9Gjz9notx7Vib6+SDqv/4FUBBTo5O3dfyjDGkYMiwMnQV/52D50VS6vqjL6opXCyfO0e6SLS98GApcp45/uaeAUS+tL2pFbRv7ny7gZFLNPxXprasakSTo0p4tdCmmBwDNRUnqaub/rR9kQV9LmYa6KKvxSrV/Z4sDB1TjbqT/YEFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud6sl+dt4fZFQbJdK5wMiGMIa0Ewr9O2EuG6KYxFQbc=;
 b=mF2xGDQLRyoI5lOEt045XRknLBg8KN8waih9DWv+fAEiwR3lP57EYTs2tH3lqun2wPcPE961p5k1828ahMLepmljp/T54fUXLMnEv4oleest3d4n9ZNhBr85B0TQpg/FEYUiSCkyIU/YULbb2vpoi+4iS3Ns9KlXk+ZtZrSOGl0naeD5DdNRdmP/3JU5t3c4VQibA28zf9zV79eqzYMcyaMlhTjeMKoDqyaL6Be7gYH+v4EsAjmZQkjDvpl/enr9uol++i3dH/t8WRXJ9gJTzv5aNh0xzOVKyzJQq3CrERe05Bb/+u/bmM7CGJDUVVN0A9nQW5qQc3qMCJzavmdZNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:33 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:20 +0900
Subject: [PATCH v2 3/9] gpu: nova-core: gsp: cmdq: group the RPC-specific
 part of send_single_command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-3-c3f66ae73be4@nvidia.com>
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
X-ClientProxiedBy: OS7P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:26e::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: a0af46f7-4be0-4a20-e639-08df1c9dbe29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7jwTkpO+HlWgO9unA+7BfRb/XlouK1AlRsiEh1NV6LNjHmUmJLm7O0t27DU94vnrzExa01at+zbbwfdrTF/itzPlysPC8GR4vGLNly9wsGvOpSfUvnA/xG0V8XCnNmnEHGw7fTZOxB+W6oWIK/oYzUA7mRCHVhKyQSit4MT4bQy+sJsvQzyHK6tIRbwQHwmRXO0sBRacDYUGskyRQg0aKhcjsKqM3xBViqc4HJmv8/znvtoarctpuUQYqxDlnfOMZIP40zW1i/gMolOhC55y/11ZE4k44awyh01UoYiyPF2Z5u/pJplpKIWyVpmUMVJVLbt5/BdHRUmqlRjfPYr90QZqs7TYT7+OgbP9sWDyqhybjw0PmzPgAXVQi/7R55cU3rq92768S6TZrFGVlXhG2JHJLVtBbhe9YNdrfeGYb079hCKbKi3YtbmjMrY7CYghWZLAdExQR4wtfve+Juf50Zm2H7fWzU25enq7onKIUF9sM+PbSSs4rhLqfzcw81Fe4qxDjhJ9hLT4rnpPe9A8XYKGIIveKmmEQymlBP30o7oBE9m7DlwUAAxpqScqmIxIyIvoNt6ael+gXt5RYhRSXcL92F07YNDzC810PDlyqoQMtpR72kZUbyzYcVwWGIUD4ctwqIVu4RXtYw6+RAOlDi27PTevIRQz5YypF/0uL1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0M0TlpQSll5SUR4Rjc5ODBrby9nTlMyb0pxaE9EUjUxVkp0dFN6amtvZUpa?=
 =?utf-8?B?cGJneFIveGFTMmFEeFlRbUwwUzRVRHhhaDhZU0JqcVNHMUk1ajBkQzVaNElD?=
 =?utf-8?B?NW9aSkpJMy8xMktXc3k4SXYvUUlsSjczK05CbDBrR2tlV2lLME50WG10eGlm?=
 =?utf-8?B?Y1dkb05PS1g1TlJIWE5FdzVHVG95akQzbDIzSHM4N3h1UDhETzR6NDhCamNG?=
 =?utf-8?B?N20zL1lLdGw0MStyVUcxRGtzMjZiNDlYekNMdllvb0RmZVdwVTBLUm5JU1h1?=
 =?utf-8?B?bGZUWGtrZGpLMSs5QXlTWENwc0NqV1NhQ2ttS1RRcUFxdUZFbFFRSjEyMVJx?=
 =?utf-8?B?QklNYjZ2azNLVlRJKzltWHdtdEp1dERzakRtb3BhZjR3azNzVzNDa1g0QmNK?=
 =?utf-8?B?dTZSV3VXYTdydmVIMkJuTktGYVZRQXNBTXhEWDl3V3UwWjdiUjJqV1hNdldW?=
 =?utf-8?B?bVYzVjBkTSticjRFdW1iZytCQTU4elRWdGhxelVsUXBaL05yZzlmMi9HcVUz?=
 =?utf-8?B?WUhhVjdDVHlVMnFJclJ0cnlNM0tmeWhHdmswSis3MnBjNHZaNGp5TkNCQVZ0?=
 =?utf-8?B?SXVOcEtsdEZ0aDlFWEpFNkdGblFkWjdJZWJnWlBVbWVnOCtZUkl5QlliRWJo?=
 =?utf-8?B?YURXSEtQVnBUOUJRaGJaZG5Kbmhia1dyOGMwai9rSkFyOXY5Z0JIQ1ZpcUNJ?=
 =?utf-8?B?MjZnZkxVVzMwVysxWWlWZGNLZFVpS1RCT2FtNDVTUVNWUTdXWXI2Vmh5ZFpO?=
 =?utf-8?B?SkdGY2tEd3ByN3QzRktIekI1Mi9kZGNiZ0RPRFU4S0JRK3gwdlRZWW9iajVo?=
 =?utf-8?B?MHRPMmpqM3ZhN045dW03NFJGL1pTcUMwQTJscmxNRDhJQi9JbWFPblNMbTZD?=
 =?utf-8?B?V3p2RGxQcW9lN1U0SjJmcE04SDk3UmtEdmZ4QXRURXVrdUhJRTRpSVhTNTNK?=
 =?utf-8?B?QlBzY3VYeGFZa1IwV3ErZGFvc0pOeDNtQUdmUjYxczFPMS9uLzlzNmlQTTc3?=
 =?utf-8?B?WEtaODJXVit1dDdaSGxYNFJXT2VXSVErL2dzeVd1ekpnSk5PdE9oQU5qdzQv?=
 =?utf-8?B?b3Y2SUkvTGRUN2ovKzVpOTdIRisvNHYyT09yR2YyZHAvMUh1aW01T1BFQURK?=
 =?utf-8?B?bXlIVHRuZ2hrdjFaY1hKV1R1bGVZdWUvMHVXcGU0USt4UTVNMEFPcUdwRkVD?=
 =?utf-8?B?eS9jR05hOWhjVVVSVkFlZVNSS0x5K0UzbWhucE4xRTBIdzIrZi93OUhtNE5k?=
 =?utf-8?B?SnVtT0dkeE9UNDN4SmM2UENwcnNDS3hYaXhVQ1F1dzZERlF4UVFHK2hLZy9M?=
 =?utf-8?B?U2ZzQ01MelhLTHpXeFZnaTBMbjdTZGJaTXRkNzR4U1Q1YUZWQkxVdlo5NVh6?=
 =?utf-8?B?bnY0S0QyQ0tpU3NaN3h1Nk5lVW81NUh6TjlybmdQVFJ3UEFiWS9wdDNzZWd3?=
 =?utf-8?B?M2cweTFaQ3dBVE1xOGlSUWRob1E0amdwR0xXYmdCRUptdkRPdnRCZUsyRVM4?=
 =?utf-8?B?MWRudGJIeWFGalF0TDZsWjFBZmFlRFhBUkhNU0wrNTFMN3lOTjJMTHRMWHFW?=
 =?utf-8?B?S0hTYUR1ZDB2OTVQMVVqN09yaDR0NGdib2w3a0tESXFqMkdiWmNLeHE1MEd6?=
 =?utf-8?B?U3NSeTNuVHZ0SjNIMUhwRDhrZjZiN0ZibG9ZSCtsdno1aXoxaDZrS25wdjN3?=
 =?utf-8?B?YnZZMlZrREZNSmN0emVJRVlnZHRGYjlZczVjODhsWTZ5eEowbXJWcDlpaXdZ?=
 =?utf-8?B?RGRzWUlZQ3loL2NEcDBXdWVOd0ZIU0tlUEhyN05HU1BzdVhFRW5IVThtM1RF?=
 =?utf-8?B?bTZ5a003b2JsM3h1Y0FZU21ITkVVK2x3ZjF3Y1Q5T3BjOW8wMlBHd3ZpUGJi?=
 =?utf-8?B?VUQrNDByMGxxWkN2VklIbXpkZ25lZmFsY2xPS25lN3BoeWZOOTRXTDdYcEVT?=
 =?utf-8?B?VDQ5SWUwVkhPZkUwTUVhRWUzYXYrVlpRNUFiY3JMZmlpdGlJMFA0YmEwa29p?=
 =?utf-8?B?NDZHZU4zcHp4T281VXA3RkR6Y2NFV2tGY2M0NEs3SncxdVBIUU1JbHcydTFN?=
 =?utf-8?B?RHd0V01jd1BYUTNJZ2ZjRzlQUitGdVpQblRDbXIvNTIvbTRoZ0lDejlTSmRK?=
 =?utf-8?B?UUcrQllDdVBqRXoyZVRTejJxMEpHelVVY3V5dElBSWxrNGtnR1JMcEZBaWti?=
 =?utf-8?B?MWs0MVQwSGlIay94eFJrMjYrTXlXQTVCYW1IRG5VaFdzSjNxcFVsOWNyMWsr?=
 =?utf-8?B?UWhNaXovbTIvSmNPc28rNXkrdXZid0VNcnBMNEd4VXNGSWRBcWdxYmdWSVBr?=
 =?utf-8?B?bi8rbU11d1JQdUF0b2xvcHQrcWxqYkZCZUxQNUdSZmNuTGlxTitxbmh4N0FT?=
 =?utf-8?Q?dkxLWZGhXZGTPaibK12xmOQoOWQ6Cnoyc8WvsE9Imbx6K?=
X-MS-Exchange-AntiSpam-MessageData-1: dzcKpTkWP3TFPA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0af46f7-4be0-4a20-e639-08df1c9dbe29
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:33.7066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/4R/4eR/SHElbPBXz6PVpwrRzgxAIO54XEfEtTKk4ETSkI8isXGHrHvujeaU/73gfNuFEkciNLDuA9cXTTCcQ==
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

`send_single_command` handles both the transport and message layers of
the command, intertwining the logic of the two.

Reorder the code so the message layer logic is within the same
contiguous block of code, so it can easily be moved.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 3a8548a51259..07e8e32c3d57 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -659,18 +659,21 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             .gsp_mem
             .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
 
+        // Fill the header.
+        let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
+        // SAFETY: `msg_header` is a valid reference, and not touched if the initializer fails.
+        unsafe {
+            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
+        }
+
         // Extract area for the command itself. The GSP message header and the command header
         // together are guaranteed to fit entirely into a single page, so it's ok to only look
         // at `dst.contents.0` here.
         let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
-
-        // Fill the header and command in-place.
-        let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
         let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
-        // SAFETY: `msg_header` and `cmd` are valid references, and not touched if the initializer
-        // fails.
+        // SAFETY: `rpc_header_mut()` and `cmd` are valid references, and not touched if the
+        // initializer fails.
         unsafe {
-            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
             pin_init::raw_try_init(
                 core::ptr::from_mut(dst.header.rpc_header_mut()),
                 rpc_header_init,
@@ -687,14 +690,6 @@ fn send_single_command<M>(&mut self, command: M) -> Result
         }
         drop(sbuffer);
 
-        // Compute checksum now that the whole message is ready.
-        dst.header
-            .set_checksum(Cmdq::calculate_checksum(SBufferIter::new_reader([
-                dst.header.as_bytes(),
-                dst.contents.0,
-                dst.contents.1,
-            ])));
-
         dev_dbg!(
             &self.dev,
             "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
@@ -703,6 +698,14 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             size_in_bytes,
         );
 
+        // Compute checksum now that the whole message is ready.
+        dst.header
+            .set_checksum(Cmdq::calculate_checksum(SBufferIter::new_reader([
+                dst.header.as_bytes(),
+                dst.contents.0,
+                dst.contents.1,
+            ])));
+
         // All set - update the write pointer and inform the GSP of the new command.
         let elem_count = dst.header.element_count();
         self.seq += 1;

-- 
2.55.0

