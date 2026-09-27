Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8895C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A64810E5FD;
	Sun, 27 Sep 2026 13:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HSwgWGCs";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC7588867
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR20r1Fp3f5XcwhmXqa5gprj6d7b09XHI5OijMSYlzY+HXyuGUvZCprL5zH046xwDVDvGn6BvVzuTefK7i77QcwIckcQw8239Di73RyUp9fQx+ywodPuYf8vTqfZrToQbwYsUdi2GqD741Bq5v7pnPlCDAp40xgeHFUclnfitTP1OOCnCe2trhLV9gQj2P8yW7JJq1ccMDsDjhtooR8XAMlgiFjVyWjHbDBY2/9b8/Jq2rrYqyg5dIMlXnidW5D+pjJdrfoYKHmO7b1Ir8JSbN61JtYzyUGB3/uFbXbZ2QVahtRt52ThWJlg58YW3/J5gqwuH7p96LXATgvuCoN2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkxXRVMko7m+z/NefouxIgeNObfKv/Q4vg93+MqIf/M=;
 b=WCVbwGPoAHr47eIxWvKwVdjdtQcpMzV0YUPStzP4lThV+PT7KnAk69ulmB8/8Gs6aBHpuoL0K7UePzzebDLfgugg07wttq9JsyiBfXA1pjIboYvfMhFfZgYyKYpq9cZl9duXNLeHpiSVDJkpxq47vSdyHQTThA7BqqkTpcA0Gtlomv3uGCW9F7H6L2/RaVqi9P9Cjk+hU2ncsp4/k8ncKLvJnxf/h9y+gORs2k1tZjNiVJ5DFMepHSN6UbGULHJ1eUjhAbXb33j1ey2Q2T46KdTW2RDQPXNEUfMaWo0igoSqEbA/a8AtAgGKMJZp/ZwJhjV/30zEuIBI1EW0GA2wlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkxXRVMko7m+z/NefouxIgeNObfKv/Q4vg93+MqIf/M=;
 b=HSwgWGCsWXD3zUjqJM1c5+ba8K4AoBYtFPdlNrgUcCX3CsIjC5/ZW6zwkCIshQ4W0KYZsuoM+7EkIZygoD4k5ki679/Y05m4xFBnoF8WMRV2LnY30hDPg00VCDDI1nrlR/D8iTW3SURhU+Qw4Lu/6KQo6J+yntKKNEsH7msbBxaV1V2ccfBCkqiAJJmMEOP7fTkfWWO/C7/Kq6Hy13nS5jCfA0YEjePrstqlwflV6L2D6sqrYyNz8uQGQxxIIY3oqISJwIjvygsCoDjK3Zj8gOflw9bFd7ipO0YsutM7LymHq+cHpfRuaOr/HerpGNyCqjJLFakyqdZKvDUitCOSBw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:30 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:30 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:19 +0900
Subject: [PATCH v2 2/9] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-2-c3f66ae73be4@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0094.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6be0f4-f47a-4a23-3e21-08df1c9dbc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|10067099003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pRKuE2TFJ8KGVFd0JdcIrEuZD2SzDzj+1qUbSkkQ4hHZKv5Fsk4jrunsbOT3X3gOGX5ywDEoKwFLWcfDF/IanCwX5WBOIxs01uCUpTWLEUMHzC+LT+nh1xUL24+Iy6DvHFP6XNJzs4hIGZoRoqy0Prg30sbJxDMVLNZsPjhRe+D9t8Qb/wFiJ2IBJWp9He4mVfG4DdAhplik10t/0s+xo7oIEr7WOci6DEO5FU417brVZLdI2AGZApOFY+HDuGaxot1ijKGIsDENYJbORaZM7OupohThqmAoJ9h5BNJRTSwaxkbAWpbR9bqfLNcZajjhn/654jOU3gmwp0KpUvt+FF/E3CwQHoEsZEkk6izojKDHolGUUJPWmLTQpbdXoVn7USeKW7d545slsckIT3ZXV+tqRGicSCCm8VreWbVORFy1e3YbJ2EK0g5On7mdIhdTU5eKx1ry9vQFz82ZfqquHplZly7yhbbuD30adZQrmLgRXFPp9L1/E3d6PkBTKHK6VCqXX3aT2ZowhX3z7gc7tDB8OO7rYI/O4XfcA7A9OyyNU1Pk3is0wO3GlmdPKA4SHnJd568xJ6MYwwP8uUYplJWNNn4r1zNf+Jd5gff+SCJ7gOmpH+4DNUL4QbB+/3sS4ogqqo98+si+x5v94wAUbLho4eSJnEslPT4QrGZTsj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3UrSkpYL1dMNUU1dHpJcWxscXdtOGVCbTlUZEwwa3hSaGFRM0xnYytmN1g2?=
 =?utf-8?B?Rk1BbnRDRDNkZzd0TWhzVlZaRFY4V1c3MW1wMVhTcXJZT25uYmk1a1hac3pR?=
 =?utf-8?B?VlMzTFJnMWIwNU9xdytxRVF1eEJlYndYeG9vU055L21WZllqVStNTEtGbFdl?=
 =?utf-8?B?bjNFSS9WcG9BeXowUnVqVzBiNGJwRHUxbDBlRi9pNUd2T2lqVHZ1YlN2SHE2?=
 =?utf-8?B?S0JDZkswNFZNaFlJVCtzOWpJYk1WWVNvbWlJZHMrNVY5MUNyTFd3UUUwVkRj?=
 =?utf-8?B?ZElySG1IcTgzenIyVGpPQWNLZkdrRnFlNmhkUldnWWF2djZYbXoweWJ4NVdO?=
 =?utf-8?B?QjhzbldLNk1hVVhXQ2dWQkN2Mmc5Y09SZU1QemJ4NkU0a0kwTGU2OU5MajA4?=
 =?utf-8?B?YWxnbnZrYmdSNGRpLzM0ZitnNXZ5OUMzUGJVOWlVQ3NrRDBsdkNlNkQ1cjBV?=
 =?utf-8?B?NXVINktxZjlGbkFSRkZ5YUpybDJSOUZ5WGFwT1RlWFFDcmRLSWNyK3cyRFF5?=
 =?utf-8?B?MksyMHNzR0dLb1dEblA0a1NidU8rQ1NubmxIaHlNYVE4SERqNFgwL1d3RmQ5?=
 =?utf-8?B?bnY3RGRmb1FBZWhWOFlVQk1FZmUyNUNWMEF1cmRFaDhBeFhpRmhzOWI0QmYv?=
 =?utf-8?B?RlpUcEZxQ2lwRmNsNE1Pc1RrRzQ4RTBNN2ZVR3NkY2Rlc2tSelJJSTBJM1d1?=
 =?utf-8?B?bW1Mc3psZ0RiRlFiUGpaTjZJUFNXbEt5TDVMZ3NWOGRudkJ0Y3I4YjFoRDhF?=
 =?utf-8?B?dmNmOEh2YU5taS9qclhOdTNCTVdhVk9oSWVxMkFBeVoza1NoKzFpeTc5Vnpu?=
 =?utf-8?B?b1BReEt4V29jUTB4L1BSTTNSR3IyOFRKQS9vbzh4L1BoYnZzaTQrNXpPVURV?=
 =?utf-8?B?TUhXU2wrYlN2QTBWNFhhY2JERXlIY3ZCS3ZDTFZLb2pJRExMWjMwTUs4TVpp?=
 =?utf-8?B?YXRCaWpvOGdOZFJCVnYvYi9WQkI3ZHlySlVwZHpUaVBhbVhjRzQ0ZVBMYWE2?=
 =?utf-8?B?VUhzbEtqaENsMXV0blE0QVVCUXpOeEIyKzByMy9wSzJOMDdvZDVMcDIzSHFH?=
 =?utf-8?B?dVFGMjZkK05IWmJuQlNUVkZYTmFlQyt2Z1Yvc2ZmTTB0NDNPeHpMcWVGN21M?=
 =?utf-8?B?dE9pVjMrRHhGVDVibXhubXpUNkZjV1lFR3kwek9lWjJPcFJTalN1ckFDeVFH?=
 =?utf-8?B?ZmpZRS9ERWdnZUR2MlZCa2pEK0xIWG1wZTVVUGRrSnRuaGhKeFVOcEtBSk9B?=
 =?utf-8?B?Q3lUdjlRRVVwWldCc3NZK0ptZFpnbitHMm9EYS9BdWd5V2NtcC9XS0JlZ1Zo?=
 =?utf-8?B?YXdGOEVkdGpyRFh1MDBXdXNNMXhrUzYydUlmZy9OL2Z6b1RNVTlINWx1SHdT?=
 =?utf-8?B?RVMydTlUV1BybTM2dEwxS2tPcnFib1IvYi9tazBNMVZKNDR0c1NyRE5Bb0pl?=
 =?utf-8?B?UFhvVDdoRUtQLzhzdXUzUit6Mk9PUjRQR3NPNkw5bmdpeElJeGlNcVRNWmhF?=
 =?utf-8?B?NXRxbVdINXFlcU9sWGtJcnNwWEtBUDNFUVdBb3BWQUVKVElCUW5EWXY1TCt6?=
 =?utf-8?B?K1VaQ3NpQWduL21qb1pEUnloWkFuNTZLVzB4TUNlU3pQb3hGRE1wbE5vUTg3?=
 =?utf-8?B?K3RXeFRpM0dDU01UUkFhdzVuQ1g4OXhMSC9WYXdIZm5BQ1VjbXIwM0M2a2Ew?=
 =?utf-8?B?L0JYWWR0S0NwbnBKZHJ4Rmw0WDhXNlR2bGdWdWlzakR2Mk9GNFBqNWEvb3RQ?=
 =?utf-8?B?NFduQU9CWEM0U3ZhdXBiN2R1SHlXM2NxVTBhczVXZkdJbmIyVXIvNGJlWU41?=
 =?utf-8?B?Ynk1SGRuOS8ybTk5Y1NaZlJlUDJ6WVczVFFubFpGYkdlRytqd0s5akNMSkVq?=
 =?utf-8?B?VVN4Q0JQMTVZcnMxY3BDSis3cEo3OGoxamZYNzJ1OHZXSHFLVW5XOEJ5M2xD?=
 =?utf-8?B?WmpaMVBpeTJOcWU4QzZCUXpEK3VhZTBaV0RaRFlCZUlsU2cyZnk2V01jaHJv?=
 =?utf-8?B?eVlDSlV1RCs3U1J3TGtVTkV2d3ZJbGxJOGhQNzJleFNMZWJDTkxVaEdKZXRu?=
 =?utf-8?B?MWkzejFQa2xYbHUzOG9Pc0p4TE9PZTZzQ1lXOURIZmd6eWRGZUcwbHY2R1di?=
 =?utf-8?B?STU3cU9KYlJvZ0ZsT005MFpQWnlBVys3Z3NzWExTbE9IZVVkR0Z3VHFqazhW?=
 =?utf-8?B?YitkdStLTmN0bjJxOXZwWit0MDMzelhRNFhiQXZOTzRKbzQxYi95VzUvd3Fh?=
 =?utf-8?B?SlgveXIxWjNJS09wZW1EeEpGTTY3YzMyVjI5bEJPWXFiQVlyaUZJRDJEQ3V1?=
 =?utf-8?B?c3ZCT1NFTHFUb0ZRaitSOUxhOVFlMkF6VGRNeDc3Kys1OWQzeUF3U0lELzBq?=
 =?utf-8?Q?SUhGb6nJ+TP9Feeu1vvqlyZPUyUWZZnsuUZ37ODWfpyPi?=
X-MS-Exchange-AntiSpam-MessageData-1: HkTf55UpkAgFwQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6be0f4-f47a-4a23-3e21-08df1c9dbc20
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:30.2681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unW5lasnHbvtZSUN064zpJA+RTqkYd7IFKWnElU0Rvhlep9lVHvyH7lctpvnE3na+l8HXrC7GYNZC0slQsho9w==
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

So far, the GSP command queue transport and message layer code were
intertwined, a design issue that goes as deep as the types themselves:
the generated bindings for `GspMsgElement` even include the RPC header
at its end.

This makes it difficult to introduce the new GMC message type; thus this
patch works around these limitations to make the RPC message header more
explicit and allow it to be eventually handled by a different layer.

The `RpcMessageHeader` wrapping type is introduced following the same
model as `GspMsgElement`, and can be obtained from the latter. The
methods of `GspMsgElement` that actually query the RPC header are moved
to `RpcMessageHeader`.

Regarding initialization, `GspMsgElement` leaves the RPC header zeroed,
and the command queue code is now responsible for initializing it in a
separate call.

The only functional change is that the RPC debug messages now display
the size of the RPC payload instead of the whole message including its
headers, as they are technically part of the message layer. This metric
is arguably more useful as the headers have successfully been parsed by
the time we can print these messages.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 25 +++++++----
 drivers/gpu/nova-core/gsp/fw.rs   | 95 +++++++++++++++++++++++++--------------
 2 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d293d28b0967..3a8548a51259 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -50,6 +50,7 @@
             MsgFunction,
             MsgqRxHeader,
             MsgqTxHeader,
+            RpcMessageHeader,
             GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
         },
         PteArray,
@@ -664,11 +665,16 @@ fn send_single_command<M>(&mut self, command: M) -> Result
         let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
 
         // Fill the header and command in-place.
-        let msg_element = GspMsgElement::init(self.seq, size_in_bytes, M::FUNCTION);
+        let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
         // SAFETY: `msg_header` and `cmd` are valid references, and not touched if the initializer
         // fails.
         unsafe {
-            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element)?;
+            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
+            pin_init::raw_try_init(
+                core::ptr::from_mut(dst.header.rpc_header_mut()),
+                rpc_header_init,
+            )?;
             pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
         }
 
@@ -694,7 +700,7 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
             self.seq,
             M::FUNCTION,
-            dst.header.length(),
+            size_in_bytes,
         );
 
         // All set - update the write pointer and inform the GSP of the new command.
@@ -777,16 +783,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             return Err(EIO);
         }
 
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.length();
+
         dev_dbg!(
             &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            header.sequence(),
-            header.function(),
-            header.length(),
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
         );
 
-        let payload_length = header.payload_length();
-
         // Check that the driver read area is large enough for the message.
         if slice_1.len() + slice_2.len() < payload_length {
             return Err(EIO);
@@ -833,7 +840,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         Error: From<M::InitError>,
     {
         let message = self.wait_for_msg(timeout)?;
-        let function = message.header.function().map_err(|_| EINVAL)?;
+        let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
 
         // Extract the message. Store the result as we want to advance the read pointer even in
         // case of failure.
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 918a7ae809eb..b12034db7857 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -781,11 +781,25 @@ fn new() -> Self {
     }
 }
 
-impl bindings::rpc_message_header_v {
-    fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
-        type RpcMessageHeader = bindings::rpc_message_header_v;
+#[repr(transparent)]
+pub(crate) struct RpcMessageHeader {
+    inner: bindings::rpc_message_header_v,
+}
 
-        try_init!(RpcMessageHeader {
+// SAFETY: Padding is explicit and does not contain uninitialized data.
+unsafe impl AsBytes for RpcMessageHeader {}
+
+// SAFETY: This struct only contains integer types for which all bit patterns
+// are valid.
+unsafe impl FromBytes for RpcMessageHeader {}
+
+impl RpcMessageHeader {
+    /// Creates a new RPC header.
+    ///
+    /// `cmd_size` is the size in bytes of the payload. `function` is the RPC function of the
+    /// message.
+    pub(crate) fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
+        let init_inner = try_init!(bindings::rpc_message_header_v {
             header_version: MsgHeaderVersion::new().into(),
             signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
             function: function.into(),
@@ -796,8 +810,32 @@ fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
             rpc_result: 0xffffffff,
             rpc_result_private: 0xffffffff,
             ..Zeroable::init_zeroed()
+        });
+
+        try_init!(RpcMessageHeader {
+            inner <- init_inner,
         })
     }
+
+    /// Returns the length of the RPC's payload, not including the header.
+    pub(crate) fn length(&self) -> usize {
+        // `length` includes the length of the RPC message header.
+        num::u32_as_usize(self.inner.length).saturating_sub(size_of::<Self>())
+    }
+
+    /// Returns the sequence number of the message.
+    pub(crate) fn sequence(&self) -> u32 {
+        self.inner.sequence
+    }
+
+    /// Returns the function of the message, if it is valid, or the invalid function number as an
+    /// error.
+    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
+        self.inner
+            .function
+            .try_into()
+            .map_err(|_| self.inner.function)
+    }
 }
 
 /// GSP Message Element.
@@ -811,17 +849,15 @@ pub(crate) struct GspMsgElement {
 impl GspMsgElement {
     /// Creates a new message element.
     ///
+    /// The RPC header is left initialized to zero and must be initialized separately using e.g.
+    /// [`Self::rpc_header_mut`].
+    ///
     /// # Arguments
     ///
     /// * `sequence` - Sequence number of the message.
     /// * `cmd_size` - Size of the command (not including the message element), in bytes.
     /// * `function` - Function of the message.
-    pub(crate) fn init(
-        sequence: u32,
-        cmd_size: usize,
-        function: MsgFunction,
-    ) -> impl Init<Self, Error> {
-        type RpcMessageHeader = bindings::rpc_message_header_v;
+    pub(crate) fn init(sequence: u32, cmd_size: usize) -> impl Init<Self, Error> {
         type InnerGspMsgElement = bindings::GSP_MSG_QUEUE_ELEMENT;
         let init_inner = try_init!(InnerGspMsgElement {
             seqNum: sequence,
@@ -831,7 +867,6 @@ pub(crate) fn init(
                 .div_ceil(GSP_PAGE_SIZE)
                 .try_into()
                 .map_err(|_| EOVERFLOW)?,
-            rpc <- RpcMessageHeader::init(cmd_size, function),
             ..Zeroable::init_zeroed()
         });
 
@@ -848,34 +883,28 @@ pub(crate) fn set_checksum(&mut self, checksum: u32) {
         self.inner.checkSum = checksum;
     }
 
-    /// Returns the length of the message's payload.
-    pub(crate) fn payload_length(&self) -> usize {
-        // `rpc.length` includes the length of the RPC message header.
-        num::u32_as_usize(self.inner.rpc.length)
-            .saturating_sub(size_of::<bindings::rpc_message_header_v>())
+    /// Returns a reference to the RPC header within the message element.
+    pub(crate) fn rpc_header(&self) -> &RpcMessageHeader {
+        // SAFETY: transparent type.
+        unsafe { core::mem::transmute(&self.inner.rpc) }
+    }
+
+    /// Returns a mutable reference to the RPC header within the message element.
+    pub(crate) fn rpc_header_mut(&mut self) -> &mut RpcMessageHeader {
+        // SAFETY: `RpcMessageHeader` is a transparent wrapper for the type of `inner.rpc`.
+        unsafe { core::mem::transmute(&mut self.inner.rpc) }
     }
 
     /// Returns the total length of the message, message and RPC headers included.
+    ///
+    /// Note: this method is technically a layering violation as it is transport-layer code
+    /// accessing message-layer data. It only exists because it is necessary to accurately compute
+    /// the checksum upon receiving a message from the GSP.
     pub(crate) fn length(&self) -> usize {
-        size_of::<Self>() + self.payload_length()
+        size_of::<Self>() + self.rpc_header().length()
     }
 
-    // Returns the sequence number of the message.
-    pub(crate) fn sequence(&self) -> u32 {
-        self.inner.rpc.sequence
-    }
-
-    // Returns the function of the message, if it is valid, or the invalid function number as an
-    // error.
-    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
-        self.inner
-            .rpc
-            .function
-            .try_into()
-            .map_err(|_| self.inner.rpc.function)
-    }
-
-    // Returns the number of elements (i.e. memory pages) used by this message.
+    /// Returns the number of elements (i.e. memory pages) used by this message.
     pub(crate) fn element_count(&self) -> u32 {
         self.inner.elemCount
     }

-- 
2.55.0

