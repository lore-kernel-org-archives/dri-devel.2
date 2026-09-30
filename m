Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B1ACA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA47C10F450;
	Wed, 30 Sep 2026 14:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="diPuZcFG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6BA110F430
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBzfWkBw2G+07ItUM4lpv1U58a546fb67QhGPml0Tq/Lm+ET9cIZNhYMA5dnnzQNXaxQzTiFGncbdvh6pGzD+qNzDAzz+Ajd1bpucXaXQBKJ8y402nVKNiZ9z3kDGLD2fI20ZifXiIjzKHdHKrhPfmTkWB9fV6l+lsjRhb1U+jznPFjcZRJpJEAqex6R1uNjdlaF9qlk/JCswLE3dCOD5o5TdLAHJABRDO25WgaO14eEm8r1BZz811iV9psB4xHO7AyHISdYQF7QmG7UmxwKogOUSuksmilBBQShvQ66vGqxAclY3MUIIW8rZF0UHNOBHgzy8Xy/oZKoocGx5Kw60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoyVnWrV5hvUReCMrmaO9OBwSXuPEHyuTohTg/B6Imk=;
 b=HOk9MmRn5dKkMTk9vYw1sDcIgO4BXIyGyaDu/z9Tmf9NwLsux2rhNuetGulgSUdEs3juoeGVFy0Gcpy6FCnxlepZRsk0dh/NXoAML33ppS0qlboZVndw++W5ZIvJOBKH6y+L4fn9uLDOVJ7tgCr6qL0bU26bQHmRXO1vmHe9ALAr38Er0E20JVqMwXHV00ASRWGJLobp8HhS6ekpNTo+YPKRp10yZcpSrkKHS3isr1Np9BqqC5Qi5fkvDxnLcQXRGI5LW9EEe/MZo1gK3UwAqpyfNOsQ1F3wZ3GWoJPOU9q/UCVbmsYU1fd34fr7PVjOnX9Yl45kNwfBSPRKjC29Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoyVnWrV5hvUReCMrmaO9OBwSXuPEHyuTohTg/B6Imk=;
 b=diPuZcFGdY5wa7YswWwRcMHcq23bcm3PqTvLNrSDHK30P7E5dmnsbcgd6fpnGWc5pRS1bji/ZNjYjYwMF6l1Xv3hvfHVtCjeh4k7jOjcpihk23OdJHnXzjTI/fS94V6QszMgu7j4LnkGuXAvuwYivLWCOBnk1vH/gLtoDvcyGnjNqQMGAW9dNoF+yr1FGKa6faSxlY+MT+MdRyjY8+GH7HUo2bTh/OTtpjdDTGltGolFac17LYc29/goKSI3bNowwHTtB7SwmMB+kqFWzC7lmcNEOFsjVBG9qTx6JmxP+Y89Sd2Xx75X+tdNEGltTeK/9RlGuP4lCDR9+dmi77oz3Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:57:01 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:57:01 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:41 +0900
Subject: [PATCH v3 2/9] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-2-91613f06520b@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0097.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: a5182ccc-d200-43de-54a1-08df1f031530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DioJugK6U/SJhnBWF6Qy6eawlsWKEofJ3gQCP8Fnvw7cgtEgqK7S9kHE1EP5Ccw/PnDkjPF1dOb+f7vEKl1ykMEKjxfUAoRBM+TuinV7WZ2jtGLeal314wy1Zyih7S2owDaHR0u7WArDEMsFiiSdq4DfbBnlNqLa1BWb2pU+iDc7jPbVqbMB/5fu+GP0JVTCgTPR2xZjuCibSXM/j3VTZJff8u4lciLFuOoHAi8qh8Te7TDKdfKbtDwT6ycoA5gLIBFf5YE+YQDzJ+G/oyzuGmD72CprKdMjtXsG7t0dBc0jKAHOclzn/a17IApSyq3xax8E311ReNG9iTRVYMd9jGsN2aqytiBQml5c9GqzZ9n2aGXwAsBUY91CmaqmFMmvplXcrhs8HY7cOFJxzPPE9BJAnFzfJTbvCKiB8dJM5ee3kvwGUj6kArgEKHhZtBeQHeiiK4cLCyZz7AlUHYXPJfan+Qe0KrvCGYNZVdp5EQ44KHTaui8EtNoiSjjVReevSqnGfP4CH5ow7+HImM4ecxkv621A/klzy5rPVUo5Si8DkFiVdAJGKIHvUj+yBVRGrKpnoQxAxhbnKkQKSdauAPYwIxq4uV6MAEarCFOzlxbEnz0IeMnJO88FoKiZKxyEViuKEgC1K3BYDhb6zX0QuNITgdNnHRMnj3H78Giz41w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUp6eDVpUVRSM3pnYzY1MUVKMWlPQ2dUSGRxT2tWeFljYkY4Z1E0S1dPYUVQ?=
 =?utf-8?B?bENXTVdNWUV3N2FwbHpkZ0dSemlxc1VsQVFHNXY3QTEwMThGY0ZGZ2FLaGJj?=
 =?utf-8?B?MkdPYmJydjNXdkZOTmFVWU5XMlExQkk5MVcwUDlDLzB5ck04OUpMWlBtZFhV?=
 =?utf-8?B?L3paSm9jMHk0R0lYcWR6TTREbWV4N2J1TU96dzV2a1loY0hvQlMzY0x2SGhF?=
 =?utf-8?B?KzU4QTVnYWl5d2hrdlBGSk9kYjRZSDVrRnh5cnBQWitwN0Rma0F4dEkyT3o1?=
 =?utf-8?B?U1UrVjUzanJrQnlydU5vUjViYTN3NXhqQTVhN0RMeFBsUFlSeXNXcWFjVVEv?=
 =?utf-8?B?R3JWS1U2RW1tR0tRSDlWQmZwVXR3aEllQzNJUlRXVmt1RlZSU2YyZ05NbzJo?=
 =?utf-8?B?NVc1cFRlV2daZXRNSmZjdFQwK2lCT1dHREhlQW5xWm91QWxSd25qQ29JUVNL?=
 =?utf-8?B?OFRTQmNaOStxN3JTUjVCY1NXcWhCWTIra0RybVVNeXp2eS9uZ21uN3Z5aWhN?=
 =?utf-8?B?cE1Bd0lnTDFjZ0VqS1VvSnlVazlUNHVDaE9Jb3hTejEyM3M2cXViQzRSbC9j?=
 =?utf-8?B?amZnalJkQmp1S20xYUNaYVh5TmgvSHpnODcwQkVGTTViWFFWbW1OTmowRVFI?=
 =?utf-8?B?bE9hRkNTSnRuQnFVaUJTNkE3dDlIWS9yV0R0dXlmOHVwQWNMcjBQMHVaYW9j?=
 =?utf-8?B?d0JncHd4bXBmRGZ4SS9qU2g4YlBYdGl4R1JRUzhtNGhrQTNES2dRVndEOUJp?=
 =?utf-8?B?WlNDZEJZQjY1Y25xOExaVWpEb3RqdmlhWjhaRDdEWmZxd0JjN3ZJWm00QU9n?=
 =?utf-8?B?M2syYnk2TDAxMkJPNXljRVJDTzB4VE9QRFhiV05IVFlXZEczdmlPK2ZwQ2l1?=
 =?utf-8?B?Vjk5aXdQZHpaek5sekVzWS9ia2R1d3lwaDVoUyt5NFF1dlFSeXpHT2Z6Um9Q?=
 =?utf-8?B?cWZsZGJXbGlXdjNOTXZvN1hMMFBaZWJlWlQ4N1ZwUXFGWmVsaW5rVHNqeWFz?=
 =?utf-8?B?RGtHN05TZDJKS281ekFiRmNjT1dZYnQxdWxPTk13SCtySzdwVkNUVjFON0FU?=
 =?utf-8?B?VHhRUzlxQ3pBL2N3a0grT1ovUGN6VHRLOC8rRDhIb3lrVnlOUkFObzNrbFFv?=
 =?utf-8?B?cWMvU1g5MW9tSWlVMXFyQzBadUFQbmM5bm5UN2xRYUp5MVEraEhvTWFRQkh0?=
 =?utf-8?B?TWhqcGdldmFmSldiVW5WVmFqVjVLbU1yQ3RKOTRMMnFyWkNvRGt4dzduK3pX?=
 =?utf-8?B?RlZpVDc5TFBCNEEycndSSndYQkJPL1hvaFlKN2FFWEgvS1dwNU9icVQrOVJF?=
 =?utf-8?B?Z0REU0k3OEhyWUVHSFduMjVhZStCMUdSVHZpem9mRk9DOWZzU2dLZWc4bHo0?=
 =?utf-8?B?ejlZQVgvdldxUURld29iZDR5MlMyZDhTWjdzazVoUDBLSUhmbXg2M05IaXRa?=
 =?utf-8?B?Q2ErMTkyQ3U4WFdraHhYMlQxU1QvZG9nV1BNUkkzb0ZPY0g1cXNGQVl4dGRt?=
 =?utf-8?B?Ky8vMDBjVVR4cEVySWFqa2FTeDFHNXRDKzJkbERva3JWNDdzNVhKczVKS1Jp?=
 =?utf-8?B?MWdzOFc0djFTL3RUTkovNFI4T3EzN2xsU0RCZEpaVERaZktWNjRYb244THY2?=
 =?utf-8?B?Rll5QnlxaEx3dVhEM0YxTm40WjFWWTV2K1BuTEdmWjRYdzJlc1dwTERic1ZD?=
 =?utf-8?B?Z01qeFpkOVlya3U1VFBBNXpNYlNjUnc5MitBajJ3UWNaZzFTMEI5dTdxeGtH?=
 =?utf-8?B?WFdPbjA4eTJhbEh4ZVdoUkZKK2JoZUtRQVUrQ0gzempBb0xCVy82Vy9neVVr?=
 =?utf-8?B?VmVENDFaVVhPaHNWUjM1aWx1aFhLYVpSTU5JdXY2V21YU1VzcnZZa3daRW5J?=
 =?utf-8?B?V3AxL0Nkd1JkbzE2NXFRQnFhTk41SVZOYytZSjVaMFZwQWV5eFV0SVplNVVu?=
 =?utf-8?B?U3VRMVh6Z1UyR2xSMDlNeUgxWkVmYk5EcTk1NmgyUTJRYWtadnZuV3YreC9m?=
 =?utf-8?B?OVBhaEFPNTJEdE92NnZFRVZWYU5OZ3RCeXVRM1RkVjREWlBtSkxaaTIwVEZN?=
 =?utf-8?B?elRENXRQdkNxeC92VjU0MHpTOHZ0WHB4V3o3V3dISnVJa1JQUkEzcm9IRnlP?=
 =?utf-8?B?aE94OGdIUDRuaXVSeExBeElZbmdFVUNxTExqc3E3VjVYNGhxMnQ3ZTJYYy85?=
 =?utf-8?B?T0tLTVZtR0ZyTjFqTHZvZkRJNmJ5M2Y1VDlaRnlVYk9GZFhqbDZPVXkrZ2Rz?=
 =?utf-8?B?N0l5bENDRjg1Z1d2UHNBMVZwYmRvdm5BYzBHNnFNNWw4NW9xNGpGdTExbUhn?=
 =?utf-8?B?SXdjUWNCQi84ejR2dXlKSmxFN0NMRFhzalRVWWZGTzN1UXFPYmtwTG1hMFd1?=
 =?utf-8?Q?A3IH90RWvIUNjyEyXHpxm4qJPk31ChJSAfV7DFGzR3DrP?=
X-MS-Exchange-AntiSpam-MessageData-1: JOk2D5Q/d/ZWeg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5182ccc-d200-43de-54a1-08df1f031530
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:01.2059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7U9SFIENi1QV4goyy6RvwDpoGPcXQai7pOc75K+cLbuUyfz647HvdMms+QFdvoIRrVuSN8VZVPpYBNlYz/mPA==
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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 35 +++++++++++-----
 drivers/gpu/nova-core/gsp/fw.rs   | 88 ++++++++++++++++++++++++---------------
 2 files changed, 78 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d293d28b0967..b40d45bf0a92 100644
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
@@ -664,11 +665,22 @@ fn send_single_command<M>(&mut self, command: M) -> Result
         let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
 
         // Fill the header and command in-place.
-        let msg_element = GspMsgElement::init(self.seq, size_in_bytes, M::FUNCTION);
-        // SAFETY: `msg_header` and `cmd` are valid references, and not touched if the initializer
-        // fails.
+        let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
+        // SAFETY: `dst.header` is a valid reference, and is not touched if the initializer fails.
+        unsafe {
+            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
+        }
+        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
+        // initializer fails.
+        unsafe {
+            pin_init::raw_try_init(
+                core::ptr::from_mut(dst.header.rpc_header_mut()),
+                rpc_header_init,
+            )?;
+        }
+        // SAFETY: `cmd` is a valid reference, and is not touched if the initializer fails.
         unsafe {
-            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element)?;
             pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
         }
 
@@ -694,7 +706,7 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
             self.seq,
             M::FUNCTION,
-            dst.header.length(),
+            size_in_bytes,
         );
 
         // All set - update the write pointer and inform the GSP of the new command.
@@ -777,16 +789,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
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
@@ -833,7 +846,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         Error: From<M::InitError>,
     {
         let message = self.wait_for_msg(timeout)?;
-        let function = message.header.function().map_err(|_| EINVAL)?;
+        let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
 
         // Extract the message. Store the result as we want to advance the read pointer even in
         // case of failure.
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 918a7ae809eb..58ae82dab5e5 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -781,11 +781,18 @@ fn new() -> Self {
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
@@ -796,8 +803,32 @@ fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
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
@@ -811,17 +842,14 @@ pub(crate) struct GspMsgElement {
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
-    /// * `function` - Function of the message.
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
@@ -831,7 +859,6 @@ pub(crate) fn init(
                 .div_ceil(GSP_PAGE_SIZE)
                 .try_into()
                 .map_err(|_| EOVERFLOW)?,
-            rpc <- RpcMessageHeader::init(cmd_size, function),
             ..Zeroable::init_zeroed()
         });
 
@@ -848,34 +875,27 @@ pub(crate) fn set_checksum(&mut self, checksum: u32) {
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
     pub(crate) fn length(&self) -> usize {
-        size_of::<Self>() + self.payload_length()
+        // Note: this is transport-layer code accessing message-layer data, which is only ok here
+        // because RPC is the only kind of message we handle, and its header can (with a stretch) be
+        // considered part of the transport header.
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

