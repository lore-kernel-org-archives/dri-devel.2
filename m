Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF181CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3516E1120B7;
	Fri,  9 Oct 2026 11:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LgFJ9RwN";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FD81120A2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIobz2Bc+A0MrlmshtIDum2tBN95vj8CHPKEsuJAMABcrEiVIfraFGfWIcxnlXS5UwpgCtoP3ocmsv9VC2Vg3Lf/N+03sl0ufYee2LuIrWlj17iXZrqIMVG/mB6lTaTAG9W6qhjXjtEnR53eC79V54C0CfaT/zEOqLv0n/oFrsCTo0fgIBcbYONKScqSCjDIDXlhU+70fFXZk1QX5ibY3xUJuXMNcXGmzG9nlwZ4FJdeJ7p1SPcqha5zVIMSC7SpY1eNSaPkqM5bkVigu5La2BScthLD+NQTCe5wAqZZmyOO6m68Ia5aAvx1EuqsQrBUoMQjNfK9+e5+z2+qliwzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v3ATVEt1ARFDi9/Gg+GFU0vS4q+Lq8jYm8CXTSC1v4=;
 b=vOV2CHsYjjzuDsBTfn9MQUoXeoNbu+AuNaroP8lus8LrFZVjnDfhoXLxCPNJXX2TaS+8MmqQshLik/XxwPlPdRxKwE1y+ph84kipzbW31XF0vuKgOU6mk8cngYQqbRzvzrAWp7sZTYgSe/yVTwUhOetSsUjUnjtKVlXdtGToiWf1hOHbU9Ly/7IgLONRqcaPpjAbuMCFkjE6bwM+SdkUR7vxDmdzRVlxZmg0MJFIw7D27aeJaWpuy1Dl0LmmN3f8GG2Ul/ur7Ys5Tvqiaz+xGIlXe30NQxyNbrVJHyYKaiw2w8HbDNTb9iQRpKauOfoDn2V6kbrHyzkDehf2rYnZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v3ATVEt1ARFDi9/Gg+GFU0vS4q+Lq8jYm8CXTSC1v4=;
 b=LgFJ9RwNCBwLfHX4oqU2ackVmO3xe/iwwWnb0zL06En2JieA71tS84elNZDGSwrgLqu/0n0t5MzpaeJ/kpzCp9ArC56niZr2BqKfmKECFXiXHgvmYP+bECVAe2dFmAQMToZ1IXar2UOexU4KWxtfhoq8a8Au839aKuehDw3eCxetA7QABAivGIte4zGgCDvWn8t8Owx5AquKx0MB6Mhq04t/dAyaifiDA7/L8zzkvYtdiWd+ZzoELpJ4Vu2yVe3iDjANowZP+9DIRnTNDBWi8pLCLV5PrrA9Qq2ybul47qWnewXipPK9Vmgr5QXGGjNz2L/qIRS0kd48cc5XRZlgqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:19 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:19 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 09 Oct 2026 20:53:58 +0900
Subject: [PATCH v4 02/10] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cmdq-rpc-v4-2-c9ab8de1d3f2@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e2056e-dd4d-47fd-242e-08df25fc0d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: BsOFihqVOPP9TIiapbkRv7T4IHwd1nUeExZZZEUlw2ssZHmOQKn/T23mtbKzlQX13jxdbBITIfjfshBDzk/kXAO7qrKU+EMIeK/hA/65sGVWdE9wiFeYlv9b61szyifNi3uWzBBqYwft9qqGrgOAGhq+eaU6OscCOmhOoPhEP00qU6uYMw9EG4S6pQP1yz8Z1F60aVFnofSAsRe87YZL5yWjEJ/WE2oZXjC4LkOSaO8qzG2PVsnFRSBf6bVTriOA5TkVRnuPBXHwKoXC09450uNEzs3egTmedttvEFWH+PGyTC2ndihzNq0Ns3XEQKCwLBeibTLq0Q9hvx7Vlkz8YOyYQQChXSW0vBOPlrKgfI+p0c0hfnATth1ihTZb+2yCfaFj2Eg+NE0bhcN4ivCd6obBHOHBAKZs1Dyxf3mCYd7E2mMYOM0Rup03egb/5JfU1sugQY7B/W/TiXp1XBTTY6pcp4SNBsKXL4Xulhlsx4CwTeTPCEnm8oi0vTMnnFiMjD28fuFylTNhv1ULZcR2oMzG9qpwprCFMqgfGDgwZL4ib0WJOcsp+8ZHTLIj4b2T0/oRgZaOb5sqkr61b8adMyeVbHKPQD/XguuUJxwwmhnODJbG6m9gLv8FHoNg1G4r1oSas7af4t0TiBkc/OpXjLW2ZED71W5MRgvhKz+A/Ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk03N1hza2kvRGpNVS93ZUY4WFlnREJhVnNaaVZlMnNQTVY0R08yeVN6bm5k?=
 =?utf-8?B?MzYwVWRWZVhVTW9kclZhNENDK2p1SFF0UDhWVkw0MVpaNFMxeHpGTnBBN2ZG?=
 =?utf-8?B?Sm9QTy9JVUNUVnVPRjFsaGpDRDR4b250RXlXVlQ4eVJpNUpObFpTWVp4dElE?=
 =?utf-8?B?bHJ1dUljZ0tpMUdudE9YcnIvT1U0UFFQbUZ2V3IxR2xQbnBveWhaWnVXbVpr?=
 =?utf-8?B?VWlLSWpKVE52WVdUcFcyZUFOLzljejdqZFNjLzNLVjhGZjNTMExTeHNiYTJu?=
 =?utf-8?B?TTBZYXEraHpOWldiZXUvTHJwdTNBaEE3V2JCM2w2dFovL0MzdmE0bDJYRGIx?=
 =?utf-8?B?dm12RzZROEpQWHJQeHVhT2dyMlNrMnFvMHZJU2IrLzhQaXFsVEpQUlVoeTUz?=
 =?utf-8?B?Q0pPd0hsMGFCaHhDb0ZCVFpDNDdQK2N0VnBCVk43U2lyMjZseVEzRzNNcGNX?=
 =?utf-8?B?UzFOMStHZGZHNm1vankvSVBlY2JBeStFQVd4SG45am0xSzJ1QzljMktScTJu?=
 =?utf-8?B?RlFiSU54RkV5S3RiVlRtNk42SU1PY2ZZNHhVcUVxM096ZnJNVW5XTGhoVjlt?=
 =?utf-8?B?cFU0OFdMVmJyNWtnRVgxdGdLZW9jTHpPUFN2M1lyNEdzdHk5YlhwR21NWjg3?=
 =?utf-8?B?WDFlMDJJZHpCREZ0V0NFcEc2dkxFRUk1VzJYUkx5bndmb1IwdE5DK2QvVWln?=
 =?utf-8?B?MDYyY2JJekJwQTJJa3BGYjA2d0Y4SDZkSE91b0lQcmFGZ3BLSThIeHVta3dI?=
 =?utf-8?B?MTdQODZNbTJXZDdJV0YwdFlkYWVGdC9uY21VWlUwb0xxL05odEh3YTA2c1d5?=
 =?utf-8?B?NXZRZnJXMEhKVHliM3p5T3VGVklINXJBRjBWR3hEdHFxL1QxUW5yeXYvcXNI?=
 =?utf-8?B?R3NUbkpKT3FBOTZyaUlTUmhncytmQ0Nocy9BdU1LM0dFSnNDak5YMXMwbk93?=
 =?utf-8?B?MGx3MThhRHcrUCtvTEhzRTlTa3NmbDRwRFFVME9VZ2JqbkhlcUV4RWc5WFhF?=
 =?utf-8?B?VnpBSmU2MGR2NVQ4aEw2S2l5UENjM3hIWnJyNmRmaGFDMExrN3BZU3JEaWwr?=
 =?utf-8?B?T1NIMG83T05ETXQwbmpIcmxnQS9TZEVsL1RMZEZiQlRrcDJDcnRrMEtXVkdj?=
 =?utf-8?B?TENvS1ZnOFlUNGh4K2E2djE3SzBvQkdHTkJVM3hVWkJ2dUNRWWl6UWxXYXZ6?=
 =?utf-8?B?Tm9ld3U0NmNyVTYveVA1N085RG0rSTlFdlY3VUFmQklZazNHYUxyc0ZRTzhk?=
 =?utf-8?B?UHV3M3R0WGFTY1lMcHB6WUFtRjhSRXlpWkZORi9oYXRJZ1NpWk5IYlRhSDQz?=
 =?utf-8?B?a0JLNjMyUHgyOXFSZHUrVnFKaVBrMUNDUUlMc09YQnRFdTk4L1VhM1RWaVkx?=
 =?utf-8?B?ZWorWEpQbXlhZmxLQSt0aGo5aEQ2dzUrSCs0Y2daWVNKK2QrcU80VjB3WWxp?=
 =?utf-8?B?UnYvSWlCYXJkU2Y0NVlMMmhyQ2ZDcTA1eVpBRUc3ZEVYTjVDWXhzWFZGTTFx?=
 =?utf-8?B?NEdRR2tla21HWXpIT3kvSEZDaS9PbFJIN3NidHNQZWR4cHFMTnVNeXpyK0VG?=
 =?utf-8?B?ZDVvTVVWM0t2MUc0dmlaQkR1TWMxeWZRNm82bm5mNDJGQTNoM29UU3R0NnRm?=
 =?utf-8?B?dE1BTndGN0M0Rlo0MVN6ZTY3U3Qramk5WEZFWGwwK0QyaVFWalVmbVFOQ1lH?=
 =?utf-8?B?ajVxUFlzNDgxV1h5Z0pOejRmY3E3UU5UUTZscW4vUGc4TWg5OEgrYXFXWGt2?=
 =?utf-8?B?NHNSZUNkR3JveW1mY0ZPbVkrZUcwbmVwUlA5NVVGb3c2VG1HekVFYWRPRVhk?=
 =?utf-8?B?ckN4ekFFSGViUEo4cGxqbUltTkhQZnBCQW9DdWVJNnhwWDBJSWtZOEVJYm1w?=
 =?utf-8?B?T1hlVkhkVEVRdmQrWlE0cEFmb2lOdmczaGdiWU8rb1UrNmoxMG1WV3dONWha?=
 =?utf-8?B?bEZQZy9kRU1UVmQwcmRCOEthdXNWdkpnQzhNZnBYa2hXR1NsbDlJNHBOTEFz?=
 =?utf-8?B?aHJheTRtaXBFQy9Db0dQV2dJMmpYMi90RlY2Rm1KTXZQb0dhcHRHMHc4bFAw?=
 =?utf-8?B?YU05SWtDUkxIbEdwVitPbWNmaVdFSUdra1dCaDlzQ3RiVXBzVUM1LzBqNUtv?=
 =?utf-8?B?dUhCMFpRR0NCTTJ6QnZBa0dRc3NqMzBCUnl1bTlvL3A3cmFzNGNsckhic1ZW?=
 =?utf-8?B?UXg4OFpaV0NuSGhpaE1mVFVRUFdqd0dnay9DNGFKcS9nWThEZXdoYTBsVTI2?=
 =?utf-8?B?VGFBdlJHNUdEeGxjNjdKeS9XNFNNSGk0Q043bVdHQlNrRUlUM2pyR0pKTXVw?=
 =?utf-8?B?RXNTTWpxM2Q0c09pV2RpdUZRWEZnTms4L1EySWJ3M2IybEI4U1FFYWNPOHdS?=
 =?utf-8?Q?ku8vzuyIPgRmJBs/7NWVPDJ1VqUSviZFxD3ElDU3hsmC3?=
X-MS-Exchange-AntiSpam-MessageData-1: 65w2WuFnRDSSqQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e2056e-dd4d-47fd-242e-08df25fc0d10
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:19.3138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pq1y0d8whMKQKrxm6K1BlSuY2bCyE7JDqlkvSE7OFa63k0wknDWWko6zCnmW8yAHznZ1SK82IdojojMzcfIFJw==
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
 drivers/gpu/nova-core/gsp/cmdq.rs |  50 ++++++++++------
 drivers/gpu/nova-core/gsp/fw.rs   | 123 ++++++++++++++++++++++----------------
 2 files changed, 106 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index b1d46d6d4d4a..d89f09d3f126 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -54,6 +54,7 @@
             MsgFunction,
             MsgqRxHeader,
             MsgqTxHeader,
+            RpcMessageHeader,
             GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
         },
         PteArray,
@@ -688,11 +689,22 @@ fn send_single_command<M>(&mut self, command: M) -> Result
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
 
@@ -718,7 +730,7 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
             self.seq,
             M::FUNCTION,
-            dst.header.length(),
+            size_in_bytes,
         );
 
         // All set - update the write pointer and inform the GSP of the new command.
@@ -794,23 +806,25 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
 
         // Validate checksum after truncating the message to its exact length.
         if Cmdq::calculate_checksum(
-            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2]).take(header.length()),
+            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2])
+                .take(header.msg_length()),
         ) != 0
         {
             dev_err!(&self.dev, "GSP receive: bad checksum\n");
             return Err(EIO);
         }
 
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.rpc_length();
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
@@ -856,8 +870,9 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         Error: From<M::InitError>,
     {
         let message = self.wait_for_msg(timeout)?;
-        let function = message.header.function();
-        let seq = message.header.sequence();
+        let rpc_header = message.header.rpc_header();
+        let function = rpc_header.function();
+        let seq = rpc_header.sequence();
 
         // An early return here would leave the read pointer on this message.
         let result = if matches!(function, Ok(f) if f == M::FUNCTION) {
@@ -883,7 +898,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
 
         // Advance the read pointer past this message.
         self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.length().div_ceil(GSP_PAGE_SIZE),
+            message.header.msg_length().div_ceil(GSP_PAGE_SIZE),
         )?);
 
         result
@@ -962,12 +977,13 @@ fn drain(&mut self) -> Result {
             let msg = self.wait_for_msg(Delta::ZERO)?;
 
             let pages =
-                u32::try_from(msg.header.length().div_ceil(GSP_PAGE_SIZE)).map_err(|_| {
+                u32::try_from(msg.header.msg_length().div_ceil(GSP_PAGE_SIZE)).map_err(|_| {
                     dev_err!(&self.dev, "GSP drain: message length overflow\n");
                     EIO
                 })?;
-            let function = msg.header.function();
-            let seq = msg.header.sequence();
+            let rpc_header = msg.header.rpc_header();
+            let function = rpc_header.function();
+            let seq = rpc_header.sequence();
 
             self.gsp_mem.advance_cpu_read_ptr(pages);
             self.log_event(function, seq);
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 918a7ae809eb..3a648c52f8b0 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -781,25 +781,6 @@ fn new() -> Self {
     }
 }
 
-impl bindings::rpc_message_header_v {
-    fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
-        type RpcMessageHeader = bindings::rpc_message_header_v;
-
-        try_init!(RpcMessageHeader {
-            header_version: MsgHeaderVersion::new().into(),
-            signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
-            function: function.into(),
-            length: size_of::<Self>()
-                .checked_add(cmd_size)
-                .ok_or(EOVERFLOW)
-                .and_then(|v| v.try_into().map_err(|_| EINVAL))?,
-            rpc_result: 0xffffffff,
-            rpc_result_private: 0xffffffff,
-            ..Zeroable::init_zeroed()
-        })
-    }
-}
-
 /// GSP Message Element.
 ///
 /// This is essentially a message header expected to be followed by the message data.
@@ -811,17 +792,14 @@ pub(crate) struct GspMsgElement {
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
@@ -831,7 +809,6 @@ pub(crate) fn init(
                 .div_ceil(GSP_PAGE_SIZE)
                 .try_into()
                 .map_err(|_| EOVERFLOW)?,
-            rpc <- RpcMessageHeader::init(cmd_size, function),
             ..Zeroable::init_zeroed()
         });
 
@@ -848,34 +825,27 @@ pub(crate) fn set_checksum(&mut self, checksum: u32) {
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
-    pub(crate) fn length(&self) -> usize {
-        size_of::<Self>() + self.payload_length()
+    pub(crate) fn msg_length(&self) -> usize {
+        // Note: this is transport-layer code accessing message-layer data, which is only ok here
+        // because RPC is the only kind of message we handle, and its header can (with a stretch) be
+        // considered part of the transport header.
+        size_of::<Self>() + self.rpc_header().rpc_length()
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
@@ -888,6 +858,59 @@ unsafe impl AsBytes for GspMsgElement {}
 // are valid.
 unsafe impl FromBytes for GspMsgElement {}
 
+/// RPC Message Header.
+///
+/// The header of a RPC message, wrapped inside a [`GspMsgElement`].
+#[repr(transparent)]
+pub(crate) struct RpcMessageHeader {
+    inner: bindings::rpc_message_header_v,
+}
+
+impl RpcMessageHeader {
+    /// Creates a new RPC header.
+    ///
+    /// `cmd_size` is the size in bytes of the payload. `function` is the RPC function of the
+    /// message.
+    pub(crate) fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
+        let init_inner = try_init!(bindings::rpc_message_header_v {
+            header_version: MsgHeaderVersion::new().into(),
+            signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
+            function: function.into(),
+            length: size_of::<Self>()
+                .checked_add(cmd_size)
+                .ok_or(EOVERFLOW)
+                .and_then(|v| v.try_into().map_err(|_| EINVAL))?,
+            rpc_result: 0xffffffff,
+            rpc_result_private: 0xffffffff,
+            ..Zeroable::init_zeroed()
+        });
+
+        try_init!(RpcMessageHeader {
+            inner <- init_inner,
+        })
+    }
+
+    /// Returns the length of the RPC's payload, not including the message and RPC headers.
+    pub(crate) fn rpc_length(&self) -> usize {
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
+}
+
 /// Arguments for GSP startup.
 #[repr(transparent)]
 #[derive(Zeroable)]

-- 
2.56.0

