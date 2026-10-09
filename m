Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC550CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484621120C4;
	Fri,  9 Oct 2026 11:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZduRURN5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CA21120A2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Znu/mPoiHsJgvkVV1B7mXj/oxhRv0XFxG1FiGD/9j65bJfbJDV8spyDXLh0QPAZ5iPec/CDbaT510+PHftAqZnmGdSnXWoDVU83KHIIYNJ0BZ87JJ23J0xR0AuleXPYsi7ltwtrmKrJDy9m3opcbfAK9M2ncPOOcLRnaUPmDHS5Eey+ZLxw6mFQjdeoszSFaBVN3hqlA+XqMao7xO6Iz81c61DVD/kI/YN9hyXdNFM3gtbRRLfnUuWlRHpdkJ+bsPdpO7VHQrnbBnM2LrUpuH/mMQF1bUT5oDJJSMLydIJAUj3+4xK+qF4vB6yXQ2t9NjVOw5mY6RAC5UDCOdvIXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWHkaZRb9fe2iRC2W3awGBfOhcARDDQBWJj/hycRlzs=;
 b=H2tvsgKxifyI7/E//yT5tYflbT9WP3IZEBVNTnNfasQtWHPmI3Eu2aOJVFk56Z1r7GyB1h6iL0yENc5E3n0mwxNQ+dpu25PD28esmlaZVSfJSo/G2auo/sZTovkaCsbGd9C7ACs62avByv06g27rgHMvsfm89jlMcS6xmuWlAgoYTsnk9R2w5zcR8QDMaPfFJcMan2BMgKoyfdc9X9e1OBwBehInSxVfDtkG3YHFvori1cM9jEjyWADIzp1phKkTsB6OalDmC8Tdt+zXjAkpcc7CCJpP7Tm8D2u+LlkOrnvI+CKrGnbxQRBvjvfLR/G8Nag2+eJKv08CQugSd4a67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWHkaZRb9fe2iRC2W3awGBfOhcARDDQBWJj/hycRlzs=;
 b=ZduRURN510TTEEjNAec7Sq4gf6Q4mJWHsfjUEoPERx+8SemO1grC/eo/vUvVZH9wvjR0IGNWG37BsRkkKCWBQWr0jXSpBqE8R5Cd7n1M1fVwreAHcwtz2ROxuysLnjXT1CLzd0bVQtORPD9o9sYhOvgXMvDDfAgunPCZhsW79F1WqHsvE29f0OxPYULLwGOEyIQtjU+tJB7q9oynoLf2TxZ/pdvrOLPKKq7JhP22Z8wpPERVSLS0w+QZy1T0pWC9ggDvhFJudnajyX4fVEly75fhfydPaMp7FidY3eXbeD2MoDnkYLeMg3sqw8B298sdMQpyNPRTbTl0t8bObB8UdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:41 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:41 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 09 Oct 2026 20:54:03 +0900
Subject: [PATCH v4 07/10] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cmdq-rpc-v4-7-c9ab8de1d3f2@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0273.jpnprd01.prod.outlook.com
 (2603:1096:604:259::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c35534-77ae-49be-26d3-08df25fc1a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iSJZLeD76LU0uypJXiFxIx0uovaT86yLF35/DaJd2X7jlL7sQy2T5p7Yqn5md519p3I7I3wNaFuE+aNrODLaxtNc/MYteReGj697LROjjIkEcnWUT0S6FcIB1eVivhuDZWCLrcY2gDysa4f/9EMEmV2HINX3gR0nyKSYdzxDkk/rbR3FN2PUO8MyypAkIVudgK0ff2ku8P52T6Cx9mZM2H6v4aQT3GOx1Snpe1CJFHyYUGTWxXvTqJAXdlBbM647jua+4wt0cCFu5v+8N+er4emLeFN4yGSy4JHVawisjxXEkQJ7nDMt57pFTNEWCN8YAzlSzT8wyXNLuN9xNj3V9qtvasd+8g3Tq5Ir7l5A1jbF0eyaD0496FoVp47VvWkvWHIK6HMarISAN+OmoVgEBEbuIpBcbYzMj0Y3s+8BTMfyUlJ7bHYe8eppZpLkcQnOXkCRHum6cnbD3JPM1jzn9c3H6GhUcBlJucG5ttYPK7IN2lWesZZ+MZvz4BTpA5jhW1fLhqF825qICyFuxopPq4//3KTjA3IA2sHj7nsgE8rk+2qE3QGaDJLwydLQfftkfMtLSwyI2/dsBaTI4++IOhD6XcZjFjGboTS+b286ftEAENrQN8Z9mUuZVDCtcz3irE+wUTp6wzb+bFcTZ1YybFZvSOKJyMTPV0v0bZv/V+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1o5b3FYenJjd3pwVCtlRitDQjZaWFRUbzYxVzhUQmtodnI1MFFSZklrY1Y2?=
 =?utf-8?B?dW05TVhCK002Ri9UaVo3Mk1laGJUaXQycjNSSWhoL0JqUkljUjVtbkphWnZL?=
 =?utf-8?B?M1QyMGdvc0ZFcWRLOUg1bzhranZ2NTVpbUw5Qi8reVZaV2ExdGJsSXhGcmhj?=
 =?utf-8?B?L2hsb3hQUnNFdWF2VmNhbndncy95Tk40OHBXTkdwVmdlZFc2YkUwMmFENUZB?=
 =?utf-8?B?a3N0N29HMmxacTV0Zmt6Y3N5ZU5NaUwvaVEyNk03RlM2WUtYdUpPelg1MTJw?=
 =?utf-8?B?YmFkemxXZ1d5S3F6ektMZENYRVZNOW1UYWxUN0Ftd1hZSXJzSmYwV2VqeTB1?=
 =?utf-8?B?a2xyNklZSm9UckJOQlZ0SzBRbCtnSlA1STA4b0dvd00yeU96VVZTcGsyaEtD?=
 =?utf-8?B?VGR3SWR3TXJiUHZPSnRSS0JCeHBBd2ZGSTdYYU5YZjN4NmFITnVZZlNveDdi?=
 =?utf-8?B?d3JpVDkwa1kxcTYyZXlKaTJveEQzTExaV1V3NEFnbVk2VHlhVlFtNjBTVzBB?=
 =?utf-8?B?U1kwYmVGNUlJRndxL25OZG9PSmtkM3BPWVFIb0dmZ3REamladi9maFpZN25w?=
 =?utf-8?B?MnFlczhXQVd6c1FUVGMrYnZvMWRaRTFZdHBTOEdqaG5GTFJtcHZSQVpoUkE4?=
 =?utf-8?B?cWorRU9tSFUveGROWEVWSGhucVNqV211WGpzR3lXWk1aYUtBMGNSRDMvMm1O?=
 =?utf-8?B?L0ZFNE9PS0NZVE45Mi9tUWQ2Q2RjMDRDOGRSUEZiR3BLR0Z3OUtwSGRVQmpX?=
 =?utf-8?B?NDF1amh0bGFkUEs4SFE2QVVyQW9DS1QyUlEyQklBU01kbXVScW9WbkhoWXFk?=
 =?utf-8?B?dGVqWWw2MFBaR0czT2VHODBDeE9BbEdEa2h1b3RvZERST1hOSG13N1hWYXVv?=
 =?utf-8?B?ZjZGMlBLSmZweDFnSjVuTkxHbnBuUWd6ZXNXVVBTZXM1ZG9YOStZR2w3ZXBj?=
 =?utf-8?B?SUlzZmNNM0VadGRwdVBPYnpOai9uSmZlazdvQ3lvdk1xUlliRGE3UFpyeEZ0?=
 =?utf-8?B?Wk5naXpROTBOQlAwcTY5dE1UQzg4TW9aUUF1a3J5OUFpK2JGNTZsVVh2Rnlw?=
 =?utf-8?B?azlrTVNnZys3ZFlWYkVwRG01YlE1aGdHMElpMWwrNkNYRE1WL3QzejdEZHRE?=
 =?utf-8?B?bWhHNFBhbytrYkRwTHpBUFZKQ3NNNjB3ckZSMVpvU2ZPSkpLNTZqUmhEVm5W?=
 =?utf-8?B?S3J1cHM3dWhkaWx0KzFRb2l5MlBZVWs1T2VPbEhwMlRyNEF1M0RFUlRld0Q1?=
 =?utf-8?B?aGxiNDlFcTdtTUlhdVAvUkhUK1dpZVlNWi9wVXEwSGRhSkVTNHhiSjJVajFX?=
 =?utf-8?B?SjRGQm93TGJNUWxEMk8yUjk4YXhVeXUvTzc4dVRCRjE4UFlxUi9CamdtTVlm?=
 =?utf-8?B?QmZScnJkaGJmOU5nN1ROZWdzZWw1VXlUWng5OFkwMXdRMEdSN2haRkNKWlFr?=
 =?utf-8?B?Y293VUdMWkpwQkpLKzVIQmtlckdsRGR0WHJMVzExZStpUDA2Y2xCUnFJVXc2?=
 =?utf-8?B?dStUK0g0T01jdGdTQ3U5c0dsMDU4bXgrc2ZMcW90NVE2cXlRKytLLzJOMWZn?=
 =?utf-8?B?eFZ1c1IvTEhGTDA5R2ZUZmNFS0JyMVFGb3dsUmNZQloxT2ZJTGgzSk9tTjY4?=
 =?utf-8?B?OWZsczAxeWRFK0ZjN3ZXdXVHL1lHeUFsSmk2UUoxNDA4cUd0MUJvN09Hem9w?=
 =?utf-8?B?ZkJFYmY5OUJzbWdHZnJhMFZSRU5NeTJNc3N1b1dwZ2wyc2kxVlpJcUdVL08w?=
 =?utf-8?B?YW5VYjNsalFSSUZFL1duemhEVEE5L2lDUmRhYnlZZ3hyMXNuTHptMWF0bmtM?=
 =?utf-8?B?a1ZJVklINGRYN2xudytNNDZEaitRT1hFeGZiUXhNSW9FMDh4STBTb0lXTVdW?=
 =?utf-8?B?TXEvcGhyRi9BOU9lTm5tcG54U0hFY2dOV3ZYYU1mM2N0NHlyUVNFdGovblcz?=
 =?utf-8?B?SjltREFydjFxa29DOUw1aW1rK1VMZlVlZVpWTnRYbkRWdjhCdnRHckE3cHpN?=
 =?utf-8?B?ajJtOWlVTDZ4b2tPeHhYWnRQM1ZHdVd6OXJlUlAza3pua0FQU2ZlODRyRGZ4?=
 =?utf-8?B?QzJxVll1NVl4Z0xyRForR3RocDJFTy9iMVIwU2x5OGtBNDNlcmlMLzRZMkwy?=
 =?utf-8?B?ZTBQc3dveTU5amQwUExndEwrT2xwWGpRTjBHU1ZDSkJJK3dGMWE5Zm11Z0Za?=
 =?utf-8?B?c3ptb1VaSGdKL0JXRWRtSU5SaXM3ZXVXWTU5OGJIek9yU081aHUxRGlxNDdC?=
 =?utf-8?B?cFZMZWtydU9tUWlLQ2hvOEhEOXBtRTRHczFCdW9qY3JuVEdFZ2NMcU5UbnlL?=
 =?utf-8?B?QUZvY01JWitwSjE1RGl6VnByN1h2b25pQjBMdXlNaExsWVAzb1l2bXc0Qm95?=
 =?utf-8?Q?Npo+3TXYlGyTbpPDXXF5lppMGv1XOTyCdSJUMPQEaZw5h?=
X-MS-Exchange-AntiSpam-MessageData-1: 6iRc+Ru9cYDYxg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c35534-77ae-49be-26d3-08df25fc1a25
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:41.1729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gK2Oc4EGP40mtr+T59yypF5n5sZyvKASdIExhugcTWtrp2aC3n4ii2tDx9srex+4VPjqF8QzC07m8o4cBXIFqg==
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

`receive_msg` currently handles both the transport and RPC layers.
Introduce the `MessageElement` trait to define how messages are
processed, independently of their type.

Keep the transport layer in `wait_for_msg`, and introduce
`consume_element`, a transport-level method which reads the message's
contents using an implementation of the `MessageElement` trait before
advancing the CPU read pointer past it. RPC messages are handled by the
`RpcMessageElement` wrapper, and the RPC part of `receive_msg` is moved
to its implementation of `MessageElement`. This sets things up for
moving the RPC code into its own module, leaving the transport agnostic
of the message type.

As a result of the new abstraction layer, RPC messages whose size is
unexpected are consumed instead of remaining on the queue.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 102 ++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index a059ce74ba2d..65e1a0b6bb44 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -199,6 +199,15 @@ fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Res
     }
 }
 
+/// Trait implemented by types that can be received as single command queue elements.
+///
+/// The command queue validates the element header before calling `read()` to interpret the
+/// contents.
+trait MessageElement: Sized {
+    /// Tries to read `Self` from `message`. `dev` is the queue's device, to be used for logging.
+    fn read(dev: &device::Device, message: GspMessage<'_>) -> Result<Self>;
+}
+
 /// Trait representing messages received from the GSP.
 ///
 /// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
@@ -224,6 +233,45 @@ fn read(
     ) -> Result<Self, Self::InitError>;
 }
 
+/// Wrapper type for receiving a RPC message from a command queue element.
+///
+/// [`MessageElement`] cannot be directly implemented for all [`MessageFromGsp`] with a blanket
+/// implementation as it would conflict with other future message types.
+struct RpcMessageElement<M>(M);
+
+impl<M> MessageElement for RpcMessageElement<M>
+where
+    M: MessageFromGsp,
+    Error: From<M::InitError>,
+{
+    fn read(dev: &device::Device, message: GspMessage<'_>) -> Result<Self> {
+        let rpc_message = RpcMessage::parse(dev, message)?;
+        let function = rpc_message.header.function();
+
+        // An early return here would leave the read pointer on this message.
+        let result = if matches!(function, Ok(f) if f == M::FUNCTION) {
+            let (cmd, contents_1) =
+                M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
+            let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
+
+            M::read(cmd, &mut sbuffer)
+                .map(Self)
+                .map_err(|e| e.into())
+                .inspect(|_| {
+                    if !sbuffer.is_empty() {
+                        dev_warn!(dev, "GSP message {:?} has unprocessed data\n", M::FUNCTION);
+                    }
+                })
+        } else {
+            rpc_message.log(dev);
+
+            Err(ENOMSG)
+        };
+
+        result
+    }
+}
+
 /// Number of GSP pages making the [`Msgq`].
 pub(crate) const MSGQ_NUM_PAGES: u32 = 0x3f;
 
@@ -886,7 +934,7 @@ fn send_command<M>(&mut self, command: M) -> Result
         }
     }
 
-    /// Wait for a message to become available on the message queue.
+    /// Wait for the next element to become available on the message queue.
     ///
     /// This works purely at the transport layer and does not interpret or validate the message
     /// beyond the advertised length in its [`GspMsgElement`].
@@ -933,53 +981,19 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         })
     }
 
-    /// Receive a message from the GSP.
+    /// Wait for the next element on the message queue, pass it to [`MessageElement::read`], and
+    /// advances the read pointer past it.
     ///
-    /// A message whose function code is `M::FUNCTION` is decoded and returned. Any other message
-    /// is logged as an event.
-    ///
-    /// The read pointer is always advanced past the message, regardless of whether it matched.
+    /// The read pointer advances regardless of whether [`MessageElement::read`] succeeds or not.
     ///
     /// # Errors
     ///
-    /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
-    /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
-    ///   message queue.
-    /// - `ENOMSG` if the message was not the awaited reply.
-    ///
-    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
-    where
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
+    /// Errors from [`Self::wait_for_msg`] and from [`MessageElement::read`] are propagated
+    /// as-is.
+    fn consume_element<M: MessageElement>(&mut self, timeout: Delta) -> Result<M> {
         let message = self.wait_for_msg(timeout)?;
         let elem_count = u32::try_from(message.header.msg_length().div_ceil(GSP_PAGE_SIZE))?;
-        let rpc_message = RpcMessage::parse(self.dev, message)?;
-        let function = rpc_message.header.function();
-
-        // An early return here would leave the read pointer on this message.
-        let result = if matches!(function, Ok(f) if f == M::FUNCTION) {
-            let (cmd, contents_1) =
-                M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
-            let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
-
-            M::read(cmd, &mut sbuffer)
-                .map_err(|e| e.into())
-                .inspect(|_| {
-                    if !sbuffer.is_empty() {
-                        dev_warn!(
-                            &self.dev,
-                            "GSP message {:?} has unprocessed data\n",
-                            M::FUNCTION
-                        );
-                    }
-                })
-        } else {
-            rpc_message.log(self.dev);
-
-            Err(ENOMSG)
-        };
+        let result = M::read(self.dev, message);
 
         // Advance the read pointer past this message.
         self.gsp_mem.advance_cpu_read_ptr(elem_count);
@@ -1010,8 +1024,8 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
             if remaining.is_negative() {
                 break Err(ETIMEDOUT);
             }
-            match self.receive_msg::<M>(remaining) {
-                Ok(msg) => break Ok(msg),
+            match self.consume_element::<RpcMessageElement<M>>(remaining) {
+                Ok(msg) => break Ok(msg.0),
                 Err(ENOMSG) => continue,
                 Err(e) => break Err(e),
             }

-- 
2.56.0

