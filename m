Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF760A2609
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cyc7d9wO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C058010F491;
	Tue, 20 Oct 2026 10:09:00 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42F010F491
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgrfpNpF2WrwFUp4CsEFgB64fNWNbvuBvxBxQ+6Bjnl2LxCZJkkfUZJOVkLNg0pKT2LexQzBRwl94vkHRZsKZFEqimp2pZ60ISyc7BilybWud6K1UBPoxsuvIW9wKt1Dsvt0vsvcHB5XZkuWcEnsuaHU4pbAq0EF2a9HmrxyUWeQs7tLjxrX2IIloH2bStanlgDroaLUvAr6x1TzXt61pEbq2lSWzmwXn5cFChn/IdbW95YsElKebqpNeu1Do64gAnwJIcWvP3bHG9w07yncyqt7XhEnDUGWw3OZEIuObtt+nBf7Z8OoJDrq8fSlrakDI2VPws/0jeKglXycK/WElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZajFw8j/U4KO+eSfOw+D3rk9xMfsVG1lsWEOXSfNAUs=;
 b=ItGxrfI03SZraE1P2hJAY7aV6tZhRutghQ2hChkaOL4fzwFJDVvTo/im3y96JtdZ0PJbcmpxxqLPz88uHSyJZ72RzBTYzGFTwjiCb6d5PXo+xTyXoiu4tRTgY8VF/DP/pbueYUawUSrS7svwGRVKMQG4moyiFkvWseovbMGgcPoRPlPdl+YwWMKWMjne9pHIjTj0AcMeKPRTcNf4+G+2ffLRCXps8QEEmv8vLOEM1JUflpm8iyUrRP9Q8rVkS0KhrtY69ogqRbddnhryvqzOrN643EEaWIHla2bfOJLS43L9Kv3qR2taGAWxLY14XdNWLdI3kHp4yu+8W7/Ouw9Q+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZajFw8j/U4KO+eSfOw+D3rk9xMfsVG1lsWEOXSfNAUs=;
 b=cyc7d9wOcawds4CQNT+S1OD5VfMzPlQXvyi+y735IKS6yQmlYkngmJ2sjhYDFLGOPb2x9xMc8KDHc+amqrJYfN2aScvKZ5gp9mIIUvqosYCAB3euJ3o4A8hrB/mUHwFJuP41QkGChCOu5RxLqwAyz5LSiJN9Bb2dxfPdlGDNV6E+MIC5btdHOo2+9fXe9hz8tSb2+oXq3r4vK5gg1ohl31xUCmMvMhLdp7oi5CbjhW9Rcc9om8Pe1hU0gv43AQhZiUZ+17vME+abNufRQ0Huj3fRvJyaGqZW5lF8Su61ggWsvWalCZeKFPjxMC9yk19gK82xPRBjWd87v3+rrxE8Iw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB754991.namprd12.prod.outlook.com (2603:10b6:8:4d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:08:40 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:40 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:25 +0900
Subject: [PATCH v5 04/14] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-4-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB754991:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b782834-697d-4d5f-52de-08df2e921d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: SJi6jmmDIv7nNHKdUcHfyIS5eVEWmCJwqV7HSHfQ3sFA9oGmwNmfK4J4BwEeALbHaShf0Xsn5XCf+vgIm9XLN6u5SASRWqisd4S/2HjblsaX85AUivlULTKG4EEMnrk8QsQ2Auf012JIvssdRFpCxW9CMXaKRtfgJki1bH0d+jNwElGaGc9CRDXA9P+q/YMbpE5lHT7r7A7+ppI9MmD2lqh2bLOA0Y1CWXAcgle9sOInH6VE8ZNvowcEwZ+sADc/s9DUzc9GnakMlhUseT+ulPThqnaSBRfau0AJ7gmWeEpfB7NqZBpm6rWlD2zy0kMK4QgoP4c1eBn6YKoNv6ZPAvB6vX6TFNPeCVTwrsJw+o2rMm4E0vgK3La4BsEGKhsuq4und5YnF7jnHeSiX/YfRNrHgofoHN2MSTK1Tk6j1eHOYT71kC47jSPLqXC4aCYu0Df0h86Oj/n+qqm64Q/EJvfvsZMc1hZDXmqrPySU8u++VmXVKKDINFJjHss0bn5pqCEJz2pt/uJWs8Q3q05vbo5Kl18U0uSJoIQDJnRSg5R60wDUlayHZWS8tfRpXWslB8XHBh1C+Dy/TRV5bdJt/8Drh30cXASj27CtCSE5NJxg6+2EXNxM/k5Jfp9qGijXB0lg+i5iSeXJWth4aJZJOBmKY09vRH2HuqMPaeNBqgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RStMYVhxR3FwYmllSkxMMDNjcTdKVEpDNmM3cTQ3N0dac3ZpN0N1N3pscXA3?=
 =?utf-8?B?cjR0WXFCRGRhVXlob05uTUtkdk92M0w5aGdqSiszbzBWV3VlaDZRampQWG1S?=
 =?utf-8?B?SmhpQnI1TmR3MTVkaUhXQ1prN3lxMXNLSVE1K2l5Uk9oU3Q4aHNrYUJVUXJV?=
 =?utf-8?B?bTJSWmI3UDc2Z1hNL2NkbmVWUjVHWGFlaXNuVGJlN3ZjcitCUFk1MHkzdS9P?=
 =?utf-8?B?TG5QaGVVK2JSSktsL0pZUUN1dExDZ1cyUmxGUVpNMVZHNVZaQklyU1U2L3Bl?=
 =?utf-8?B?SEFFLzVnaER4bktVWFp1Zm82UG5KNGc1aUVJZGJyVk9sUXNBSWtaaTM5REEv?=
 =?utf-8?B?RExjTzVEVFNtc2ZWL2crdlZ4R3RndnJsUDZ4RjFUUXNlTStjcGFFaUVGRXV6?=
 =?utf-8?B?dDRHc245RUt5ak12aFp0aVRQbHBrQ3Y2TmFVR0lHQVlxSGFnb0w4YzQzcThz?=
 =?utf-8?B?TE9JZzBEemgxM3dmVWlyc3duQUlPTDZaUWlESmVGeXZBZ2I1K0Z1V0ZVZXdt?=
 =?utf-8?B?emYwY1dZNW1MV015cUxKOTY5WVJrN1YweG5BMEtJS3VNY3c5cHdnV0ZtRXNQ?=
 =?utf-8?B?OWhpTFZiaGd2YURoZW1SNmJTV09kTlVDS3gzYXA2QU1jVGVvTkhmNzdnVm05?=
 =?utf-8?B?MldDVHh5aW9qMGJ5YSt4d2xRYmwrUUpybFF5bXd1NW9NQkZRbUE4SzJIWmoy?=
 =?utf-8?B?SGZyUTIvQVFYS0ZPNTNJaXcyWUhiUHdiZldmSVpsd01ZV1VJVnA0c1M3eWFm?=
 =?utf-8?B?KzhKVktLNGlmN1QvNGttN2tNNEFXaDlPZUxoS0dsazRqY2pHeEVsLzBsdmhY?=
 =?utf-8?B?d3pPdVhQZ29XQWtiOGwzV3VIRmd2aGg2TXVNZGJoNkVRbUJpV0FjSCtuUEFp?=
 =?utf-8?B?MjZEdytONFRmcmZFaU9sbjA4eE56NVJFcGRLZWl4UUQrdTNpbU1BWmtZZjBO?=
 =?utf-8?B?bmRTTkh0OHByMVJjSGs1S05ib3UxWW52RFFXQ1pJd0hTNkdxQ25mVldOL1dV?=
 =?utf-8?B?OWp5Wno0djMveUg0azN4WkhIM1JvRWJ3NUJ0d2tWa0hBN0JRK1l5K3RIeXVS?=
 =?utf-8?B?WHhvbXEvSDJZK3BKcTJ5VHFIb0k4REJaNnRHZzZiZ0IzTG5xWW9BSXJNK205?=
 =?utf-8?B?OStEK3BtVk5mMTFFMHBTL1hMejNzdmk2c0N1K2c4Z1cyb1RtdzhwZ1ZlZGps?=
 =?utf-8?B?NHdaNS9IU1VqaDh1ekRnVHhtR2tGdHY4OHJDMWc4Z0tud21KaEovc2hvVG9u?=
 =?utf-8?B?cnhkSWlNWXJQNVNJUXk3elhrYlhRWkNBckZBVkNsemllYy9YUnBJU25LRDlh?=
 =?utf-8?B?N0VSMjBmT1dEZ0U1YUx0cEJpS2EvR3BkVGdEeDlvQlNBUDR4MHR1RlducFZi?=
 =?utf-8?B?WDh0SW1OVUYzKzhZdXI2c3QwVmtxRi9TQnRLRHFGSXJCUDFSQ1JMOXNkR0Vp?=
 =?utf-8?B?Mkh4alg0ekhVT2F3TGhZT3kvcEdCQS80NmhmVWVOMDdkNm9RY1NoZ210TUVD?=
 =?utf-8?B?MUl1MGJGS2ZjK2NGbGI1UHQvaEZ0ZXdjYmdjL0hpZmU1eHQzQ0pzVWlPNjNJ?=
 =?utf-8?B?ZjBiTmxZTlNhajlBYi9Cdm0zT1dpTmE4ZDdnWVhnM2cxc3hkUUNKa28vWmtx?=
 =?utf-8?B?VkxSMCtMK1RXUXQwZUNmUVRmYVdJWWVhT3dMb25TR2xvZlZmQlRKdUluQ0tm?=
 =?utf-8?B?d3hheFp4MVYyOWVESWszTmVuMlM4UTArbmlWSmFYZk5Hc2p5YkFjdDYyQnF0?=
 =?utf-8?B?NjFuNlRMZjlPdFhUUklRRC9QSEtvRlpCWlNIczNXVGVEZkRJbHQrT2FEWDN6?=
 =?utf-8?B?NGZxcTdtYUdsTUtWM2NsODI1cGR5SUtqZXZXMW5TK0E1amVQRkYyK3ZiQ29w?=
 =?utf-8?B?ZFJsaXFVRVZoQkM5S0NJYi9YTUR2SUZaS0Y3VDJJNGg2YTdZUVVHOFpJYVdr?=
 =?utf-8?B?dU4zRDVXazVxdE13MFkzb3V0ak01U3loaHJ2am1mN0dubUlRSXB2V08rWUp6?=
 =?utf-8?B?TzRydk45QWlHZGdZR21Ra1pzMExJVEZWb1pMa0tBNnl4bkFSSnU3RUNyQVZR?=
 =?utf-8?B?ODRXWllwMUErNE9WZFJ6c050S3hUUzV4NGZPWjF2QklsR2xIdEN3OWcrV1Zq?=
 =?utf-8?B?QmxOYUNlMjJJdWRNNTd4d21ZME9EWUxXMjNrUk0zSFUrZHc3QUdMenQ5bGJk?=
 =?utf-8?B?Tzl6dUhRbWYwV21FdnFoOWhsZlMxenpHUVBIRW1hWXlibUJSMHpRdXFsaVZL?=
 =?utf-8?B?NFNsd0crbnBTb1lKV1RPV0JWTHEwMVBaYWJsRkVtbTdiSEFzdW9xZjdZMFhN?=
 =?utf-8?B?aUd5akxOb1hhZTlESDgvbjRlbjE3cElTMGZJN0kvMFNnOFV4QzJTOEliSXVx?=
 =?utf-8?Q?0tiJWDse1Rs46zxjvlJkMzHItEzFwvDIchv2GmDDj21Ki?=
X-MS-Exchange-AntiSpam-MessageData-1: wyUJWZ9/qAW/1A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b782834-697d-4d5f-52de-08df2e921d99
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:40.7691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5dIUjYuR+9FZ7uD7iu8/nkZhxgebS8Et3M80V21NeDoV8n1b5/SrxojWGUxMeWVVJtO+VZ70EFwfIr6xGvDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB754991
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 0c18a586576c..01c83a79da14 100644
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
@@ -791,23 +803,25 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
 
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
@@ -852,8 +866,9 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
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
@@ -879,7 +894,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
 
         // Advance the read pointer past this message.
         self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.length().div_ceil(GSP_PAGE_SIZE),
+            message.header.msg_length().div_ceil(GSP_PAGE_SIZE),
         )?);
 
         result
@@ -958,12 +973,13 @@ fn drain(&mut self) -> Result {
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
index 918a7ae809eb..54274913a68f 100644
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
+        // SAFETY: `RpcMessageHeader` is a transparent wrapper for the type of `inner.rpc`.
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

