Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0395CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5421120CA;
	Fri,  9 Oct 2026 11:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ob3bL1Ef";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16461120A9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3/+2sZbEZI+Z5/+lZAXfjvl+pWysmeyVytsAF8urbiTlo47KUl0DLhNjEMdNquD3apVf728YLVYDuL2+t7FAzS8Fu0yablSHfkW0C8ikh6NxxBuOwgCEEaYXK5gGKDPjiWbGEWWCsUa3ei7+5PfUI+CyPMsaRGl+OYfo7p8g4ECIWT77CI3rWqU/wbpon1/sjXgCyxVAIY+tYl4R9cMbSuoX3FqTg1aNrk2po1wFGzeyECtAlpX+3hnL3jnRjG/c0MadsQAeTXu8/hADBV5fiK60OKBkrYq3xsCB1jAiz6MU6YQLUGu4h3CsQywceEayU0JKKxfaMmNuxhTy8LIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/7wFEXEAC3W8v665DTK4IepSonraj2lGkCDXgsMIw0=;
 b=Ygv3lHbqhC2q6bFqKF7aNk806TXT6K8r+923u34Zqj5sejCEzCIGv4rWd0vRB/nOQ3nsQkT5EMAHTD+ql9/bMt74+4HzSd1gKiUWFMi4JJicVWSr5ZEZbu2/jJqerf8FTeyN1nrEuGE9WSM8onj9LuEMypuy8FDyhwBixXA5/lLa+Z0nVd56mSqu4d67HT3AgWn/75ZGeBaa9MLHI/dvubEWWPDkFtjluwB5I4a5lqAgpvO1b2XtkUmUPbyakoSyQoui1gfGSacGJLctG9sq/Zd065cLj3/8eIwvgdrvtO7ikax3FhTyJ9HLT1XRiQ5u74juXIoVcLiRYcgE3c8q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/7wFEXEAC3W8v665DTK4IepSonraj2lGkCDXgsMIw0=;
 b=Ob3bL1EfLv96QuZA7xzbhZrHZX92HvLIO64bBbAKG1P+mLlFbFLJPg7iSGghyQI/l7DbtAFGCggWv9fTQqfmoxycHg7ltkVTn+BuRqX4pWHNYXY/dd1TKmfML8KZW1tEYRT28R8WzPNF7jPFvFud/ksqSOakW1JZAquDYGD2uTGAL46siuoFdeE/J/k5n3d9uXRV3WMPYdG1EP/vYghkMvkYqTEu8eNqEmlyljPXoX7Ou6DjRpI9soeHBvnunD4ENz/i286inCCMeoNiAsykKnCRIqGSpDMt8mdCI2vgnQ0ciCkxffpV50gClG8pSI7jyi6a66gTAxp2MQQueJDtbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:30 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:30 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 09 Oct 2026 20:54:00 +0900
Subject: [PATCH v4 04/10] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cmdq-rpc-v4-4-c9ab8de1d3f2@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: 127fa709-aad4-4328-beed-08df25fc13cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KzuxHM6JDbt3OGQeF+cIVqABbIOrvrwSv5/kfJDl92DgJyIi0lJueIcps6PJS3Twnt+uZdG0dVXwKI9KbgLSNew2Pypfo9nE+fjjJIvc4DMVefmOQV1rlvHs2tdLA3N2K8f8A1oVoBDiVu8xFEOFdHlRe+oNYqjglEuCRfZ4jSPlY0igMhZ7oP448tOev8y1M87kVkJ8fWTtOwoUCUn8bKVhZA8VpQarRxgCEtCg5cHvHhYu4uo3VXANKJy7aHuvimybS4MkFsg675oEfqGvP0bR5zv8cKjr8VtL9iqTLZPvF/JO02BH+RdF8tf5IkuGuCQXup3Wg6cA24PiPOnCIBzAl7f4NsrmBE9Vyi4Il4Z3BVjqr906nq/J/hz9UQp9K7FfKvh4RmVmagSQOBW6ozW6ZlAZesQADFCtU8pmDwy223mq4HZfVgg3iPOniZeh5ny5IavgyOTB2xa3vjajPhNe/SfVaSnTzC/LbYbpfglnqPeRlQUwi5u8i+2O35zUlK78zWGdsB9tQb8Pjdgh85CJYLPI7PalEcfSqube+w41wxsITfYaMM/QZiZy2Yf/2UIXMw8Mtg8X4VgtxE8o7Twwk26EH0hb3DLzPOXp6J5q2umYheAykUd3m221n0wNSKY+fOhPO1YRMlQjM2wDZvC9rscI933GuQBdk55Jcuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9YS0ozVkhxc3k1WUx2ZjJ5QytMa1ZxMndNVUNpWFlnWTBDZnQ2ZkhlcUVx?=
 =?utf-8?B?cEhyQ0xhRmRLSUYzRlBkOS9DLzlXNTgyWGZUNUNJVlN0cVBkb1RmaGhYWUYw?=
 =?utf-8?B?a0lHSDl6cXZzRWJMcWJuWnRzS2JrU2cwYjltQ0NLWGNIaGtWTDFVWkpjZEVt?=
 =?utf-8?B?TmlUQ2lHVWdmWFRnb1poRkNsK3RKRlEzZVRVemJxNVpsNFJ2TEJzSE1zSndC?=
 =?utf-8?B?aE53eWpsbTJ6cWhSaFVPdmRTSGxNN2R4MDVDMFEyQTlRNWszSWk5cHJvemFU?=
 =?utf-8?B?SFJJeks2ZVNxeHowWDV3OHdOLys5QUFqcE9rb2ZKQzQyQkN0Y0luMHhma09n?=
 =?utf-8?B?L1NMaFlqQ0l4enlYbnlCRDF4dU1lNkFLYnZuLzd6eGJiMEhMUG9aNC9SUkVr?=
 =?utf-8?B?VnA4SUs0b0p6aVhudjVNL1BiSjFKODlRVkRyZ05rdTk1NzNYbHBOSXdsc1Jq?=
 =?utf-8?B?RmZPZ3RqcDNydk05bUlMRi9RR0tMdXB4MlV3RkRLYU5XUXNWbDFRcmJ1WkZi?=
 =?utf-8?B?a09nNUZWWkVVZVBNci91Vk1IS1dTVG40VGtjeklJeTBMa0tZQ3Y0d2QxUFVy?=
 =?utf-8?B?d3NyalRWZ0IvaS9Ec3RjUTRLM3lyK3RDdVpMMkJWUDZnT2l2YVFtTzBtd29H?=
 =?utf-8?B?VE4zbHVsKy9YOThnWmEyais0dlpJb29tL0M2TDU3MGlhSVp0NUc3MlpmV1pJ?=
 =?utf-8?B?UzE2Zkk3VnAzQjdWN0d0eTdYQ2dvNi84LzNEbmxZR2ZoZ2RBMmh6NXBENnh5?=
 =?utf-8?B?NU9YeDZBckFFU0lwYnI0Q2lwdkx3STNVK0F5R3V5WE44bHJYSjl5WTVEWWEz?=
 =?utf-8?B?YkxHOTBPVUJkUTJqK2VHY1JlV0F5eEJIYzMvRnA5SVJEVFNhK1UrazQzQ1Ur?=
 =?utf-8?B?RVlOa2FkQ2I2LzRiNkltV0luSlk5WjNJRzBSZU1naHJaeWQwcXhKVHRaUjV2?=
 =?utf-8?B?RVRwR3BPUCtVWnVjSmtzamNrb2EwVUN6MlEwUTVjQzJhSzVGSzlZdGVid1Y5?=
 =?utf-8?B?eWFKK0ZoaEpGYlQ1K3FkTy9uTWJNbVIzU1Npa3d6NDljK1kzajdYRGNVejFo?=
 =?utf-8?B?dDVZS291Q3B4R0x5SFBWRHBtSU9KeExEbmxLOWdndXA1SE5TRjBBdW9rM3cr?=
 =?utf-8?B?S05qSWYwWTRuOWtrMTZ3bVMwcU1sdEZmQ1R0UEg2NXBoSncvWUVwY0RYdGx0?=
 =?utf-8?B?MUZxMmdzakxKdjJJN0Q0RXV0VHlMdjB1TUtjaFRRYmtGRmE4clhXMXBCU3RT?=
 =?utf-8?B?S0t2NzQ5aEQ2dVIxeDZMOXJUYzVTb2tZMUpFM2RncFNOSHpuZEFkanc2bHdl?=
 =?utf-8?B?SHVPR052V2NtaTlPc2lCQkN6a2IxUSs1bUt6WURIclltSGhDdjFsd1Y4Q09u?=
 =?utf-8?B?MTYvbS9zeTllMUVka1hoeFhlVGFISG13d0VYY0tqNEphL0xtUXFhQ211VXRT?=
 =?utf-8?B?SURPLzlaQi9XSmpNeGVpM2xDMkZ2MjA4dkJpUEhuUGZ1ZzI0MXpoU3pHekZm?=
 =?utf-8?B?c05ZNVFVY3dlb0xVTk5pSUR2UDhMYVIwdEpBbCttYUJsTStOdS81d3Y4TVg3?=
 =?utf-8?B?bndZU2R3Tnk4QnpkZzF3VjVRT1hTN25pTnp6SXc1blV3U08yME9sR1pRU3N4?=
 =?utf-8?B?eFVzUE1HcU1LWlplWWpnQko0em9pZWxWc2pmYWhJcmNqWndmYXNacmh3eG5U?=
 =?utf-8?B?RUJFTUNGNEIzSDFSZjNjODJodlRRREE5d3Q4bTY5TEJNbHMwL2JNOFpmckZ0?=
 =?utf-8?B?VXMxc2YzZ2cvTWp4OS9raytuaFR6YjZIcWk2SDlxQWZPR0EwMVB3WUlEeHJw?=
 =?utf-8?B?YS93dHgwRW5MUk5uU3FyQ3pUNjBiVzVSdXUzUnBMMGp4L1F3OVNEemZBZnVP?=
 =?utf-8?B?ZWF2SVYwOUVxYlpoekJ3WnlWK2hjZjFjYWxRWUxSVUhTMnkvYXdSNFd1V3RZ?=
 =?utf-8?B?bDBob0dHR2Q3Z0lxOGhlYmxWRXhmNUR4eXRvS0cyblYzRUtiL3pqU2NadjhQ?=
 =?utf-8?B?YnR2MEI4RWNpSExDeEhWdVJqNUppT1BrZW5oZEtUeTdTS1lVVlhzZXpWdmVr?=
 =?utf-8?B?Q1ZUS1laWWtiZVV2bzF2cW9mOEJxUzBrZmFpblNYTXVoaEhZcUtISXFvZzZB?=
 =?utf-8?B?dlZiU1p6ZVpleXo5UEI1NzBMV05JdEs4L1dnMXNNMllpL2x4azdMbENEZnVQ?=
 =?utf-8?B?dEUrWHZ6dnFlWkM1Zzc3MzlmYkxFeUg1OWlCMEcxc1hwdnRyRW1uLzlid3Jw?=
 =?utf-8?B?cWlEd05paDZJbElpT0lOYTE1YWZ2NmNseFFQd3BnUlY3em40cGxGME9vWlRl?=
 =?utf-8?B?Q1VpQ3MxUzU0Wi8wTEpOdmgveFkrbjZpaFphdUJhalBBZjFaMFJ5eGNxYlZN?=
 =?utf-8?Q?mm0wQkUawwqEuYRUuLhmZRnn7fahMmi/dhlzqz9apwkMu?=
X-MS-Exchange-AntiSpam-MessageData-1: Iq2e8l4oRCQ1Sg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127fa709-aad4-4328-beed-08df25fc13cd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:30.5821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRuMpDJc1VCkUNFV7XDeH0LPhk/cF/7jzpGoGCUaPc2At76yrJc1DKkgU/BDL6F2LkZAwzit9FDO+PM82imlHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB473522
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

Introduce the `CommandElement` trait and `RpcCommandElement` wrapper
type to define how messages (independently of their type) are sent
through the transport layer. `send_single_command` becomes
`send_command_element`, which allocates the queue slots, writes the
element header, and delegates the writing of the message itself to the
implementation of `CommandElement` before computing the checksum,
advancing the write pointer and ringing the doorbell.

The RPC part of `send_single_command` (writing the RPC header and the
command payload) is now part of the `CommandElement` implementation.
This sets things up for moving the RPC code into its own sub-module,
leaving the transport agnostic of the message type.

No functional change intended.

Suggested-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 133 +++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index a27b0b41b593..dee2520d3124 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -39,10 +39,7 @@
     },
 };
 
-use continuation::{
-    ContinuationRecord,
-    SplitState, //
-};
+use continuation::SplitState;
 
 use pin_init::pin_init_scope;
 
@@ -71,6 +68,19 @@
 /// reply type are sent using [`Cmdq::send_command_no_wait`].
 pub(crate) struct NoReply;
 
+/// Trait implemented by types that can be sent as a single command queue element.
+///
+/// The command queue allocates `size()` bytes after the `GspMsgElement` header and calls `write()`
+/// to fill them.
+trait CommandElement {
+    /// Size in bytes of the element, not including the `GspMsgElement` header.
+    fn size(&self) -> usize;
+
+    /// Writes the contents of the command into `dst`. `dev` is the queue's device (to be used for
+    /// logging), `seq` is the sequence number of the element.
+    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result;
+}
+
 /// Trait implemented by types representing a command to send to the GSP.
 ///
 /// The main purpose of this trait is to provide [`Cmdq`] with the information it needs to send
@@ -133,6 +143,62 @@ fn size(&self) -> usize {
     }
 }
 
+/// Wrapper type for sending a RPC command as a command queue element.
+///
+/// [`CommandElement`] cannot be directly implemented for all [`CommandToGsp`] with a blanket
+/// implementation as it would conflict with other future command types.
+struct RpcCommandElement<M>(M);
+
+impl<M> CommandElement for RpcCommandElement<M>
+where
+    M: CommandToGsp,
+    Error: From<M::InitError>,
+{
+    fn size(&self) -> usize {
+        self.0.size()
+    }
+
+    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result {
+        let command = &self.0;
+        let size_in_bytes = command.size();
+        // Extract area for the command itself. The GSP message header and the command header
+        // together are guaranteed to fit entirely into a single page, so it's ok to only look
+        // at `dst.contents.0` here.
+        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
+        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
+        // initializer fails.
+        unsafe {
+            pin_init::raw_try_init(
+                core::ptr::from_mut(dst.header.rpc_header_mut()),
+                rpc_header_init,
+            )?;
+        }
+        // SAFETY: `cmd` is a valid reference, and is not touched if the initializer fails.
+        unsafe {
+            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
+        }
+
+        // Fill the variable-length payload, which may be empty.
+        let mut sbuffer = SBufferIter::new_writer([&mut payload_1[..], &mut dst.contents.1[..]]);
+        command.init_variable_payload(&mut sbuffer)?;
+
+        if !sbuffer.is_empty() {
+            return Err(EIO);
+        }
+
+        dev_dbg!(
+            dev,
+            "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
+            seq,
+            M::FUNCTION,
+            size_in_bytes,
+        );
+
+        Ok(())
+    }
+}
+
 /// Trait representing messages received from the GSP.
 ///
 /// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
@@ -662,24 +728,18 @@ impl CmdqInner<'_> {
     /// Timeout for waiting for space on the command queue.
     const ALLOCATE_TIMEOUT: Delta = Delta::from_secs(1);
 
-    /// Sends `command` to the GSP, without splitting it.
+    /// Allocate enough space on the command queue to store `command`, initialize it with
+    /// [`CommandElement::write`], and send the command to the GSP.
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
+    /// Error codes returned by [`CommandElement::write`] are returned as-is.
+    fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result {
         let size_in_bytes = command.size();
-        let dst = self
+        let mut dst = self
             .gsp_mem
             .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
 
@@ -690,40 +750,8 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
         }
 
-        // Extract area for the command itself. The GSP message header and the command header
-        // together are guaranteed to fit entirely into a single page, so it's ok to only look
-        // at `dst.contents.0` here.
-        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
-        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
-        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
-        // initializer fails.
-        unsafe {
-            pin_init::raw_try_init(
-                core::ptr::from_mut(dst.header.rpc_header_mut()),
-                rpc_header_init,
-            )?;
-        }
-        // SAFETY: `cmd` is a valid reference, and is not touched if the initializer fails.
-        unsafe {
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
+        // Write the message payload.
+        command.write(self.dev, self.seq, &mut dst)?;
 
         // Compute checksum now that the whole message is ready.
         dst.header
@@ -759,13 +787,12 @@ fn send_command<M>(&mut self, command: M) -> Result
         Error: From<M::InitError>,
     {
         match SplitState::new(command)? {
-            SplitState::Single(command) => self.send_single_command(command),
+            SplitState::Single(command) => self.send_command_element(RpcCommandElement(command)),
             SplitState::Split(command, mut continuations) => {
-                self.send_single_command(command)?;
+                self.send_command_element(RpcCommandElement(command))?;
 
                 while let Some(continuation) = continuations.next() {
-                    // Turbofish needed because the compiler cannot infer M here.
-                    self.send_single_command::<ContinuationRecord<'_>>(continuation)?;
+                    self.send_command_element(RpcCommandElement(continuation))?;
                 }
 
                 Ok(())

-- 
2.56.0

