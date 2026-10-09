Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC105CA9EBD
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2DA1120BC;
	Fri,  9 Oct 2026 11:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uiGfa6Ma";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D501120A9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oof+ZdJDo6OyoK4EkWMYgeKNGJKhlOMsyyMLukQYK8QLUEardCUyHgPDAFnQWaTaK68qZCRdu7+kLPVfIJ5BJtMCZ/lrbrB8/xrZC6DCE75WBjcgKJiWRlPSzZH4bTN01HEH1rIKIkDefMlMxGx/ZIBHWtg8ZPsDma63JaX1vLt7D1znpV9llUW3fUCoGqLj6KVdSjgqC9Ye7pMR2+s4Kq4hLzo2zqNAg7ih46Jrl48OxVAh16kupyPD8uGjePJU3b177CvM/itmU1BWEmVAG99Zd+142NjA2Q51/jLQpP4KAL5qn22gG/wLZ5orTIsmdeUrQTkcBFoOkZU4WGY3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNLpogGtJYih9tT1rO9eY1q9VRpKDO8+xH1AMkTTBjc=;
 b=nLKO2oWHPytFTyoLtUIFp+8o9sHkjUK9g7S4YGVmpHc9e1G8cpHQDqUN4EtCNLYqGBxa2wV6nJBNjaAmk4oSSrpwxKztplAvxsbEloFaWP6WvIxd3kjqMpg/vfKc3SsgbFffzeYzUQHnz1WvHWb5SD7up6G12/w+P6dtM68/GFvDVfSzGAywhvMM1unQKcGGgrb3zU7HXXwq6NlAkgDpDsK7v0Th3p3VSHT8kOVvWv9HBzdQLOahnWqazr22gP0jThI8lS48RLk0TGUrkGVlVZL9ThpPb1B22kymR8QPRDdEqcgvr9OyLsodtX5IpQEEVO7Y2bfBdvqN79qjhcivvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNLpogGtJYih9tT1rO9eY1q9VRpKDO8+xH1AMkTTBjc=;
 b=uiGfa6Mawa1zAZ08T3nEg0whu+3+X8pcq7OiQBu4Z2RpEUunosCqBpYm0oHCIJf50gHouiUfvOAKQMgr3QeeYy9mDrKj5K0b1UlU51/S5Q1lJP8ykcnHHVzqD5G/2moCwLjRoDnmKMEsETIUdGlY2z3clpkBbZPtocIUSrcUIRa1KJSvjElmDYrOLXCBMnDU3T6xKIbdc5kBGkuaJXhOW8/h7qvpIsZfHgsDljQAOk9z1G9SEurg/SeD1/ozPcptvkHgtwhaHEajY5sZOW+w7pAFPdzcDNhFjfRTpDeJOB98+p3rvbaagN6c+LY6fwJJwPlaCLgoIYR9yApOt+Pi+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:43 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 09 Oct 2026 20:54:04 +0900
Subject: [PATCH v4 08/10] gpu: nova-core: gsp: cmdq: move the RPC code into
 a sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cmdq-rpc-v4-8-c9ab8de1d3f2@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:604:25b::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a95efe3-266f-4859-c689-08df25fc1ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|5023799004|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: AgVihotSGrgsadX5HNHcDzAmkqepHJ7zXr/iv4TpZPYkBwehCCe6AbDfWY8PfnziHFbuWFuYgXjZM00JwJL1yeZo1X4/bCFbg7QqrOk6mzFEdHRUcPf/LjypRysQHxCmnn6j123daQL6rmfZIoDqvlDAjXDkUyXwGhrUVGTs1fi2BF4+Be52WTTTx60euhl+eo++uzQud4Psyp3ALKZTNI6laegFTGga4iXyWOZpyvGcJ18VCpe1GbESzhLm5MOeBVRUoEmf+l+ePiN1ahNOuyatildHc+sO6oAF9dq18ZxdsS2wGSZwURbzSdepp8SOgnweSSEd78q5pk1JFsx5bjwwP7NpSaWO60qoRr/uL4bJ4fziI725ODCxtCanXYiSTqrHFfoIDz+izYwjjZcRYvX6E9xR/54dxYG3GHbGQ3RP0v3Kxu5fgfLs/g6c7+isFHZ4wkTF7pSPZ1kQ+bGnDXmxIZqMz6e4PJa/mWdxKLBGEoL5B+6UgX6xRNObCYBhhcB2C7v55koeCbu4DUSQjFkBbFDCTmbhK9lRYQNr1XiQUPza21b5oAkHnsRLNGFrRwn9TXpbwA9QdbPWZ/68PAvaxuYuXK5krYcDGzSDJSLz686mwkhlUdsBRFuOiJ1PxF1T0Ady675tCjp8aB/inPghYsva9jnHn4gpX6lh1UU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(5023799004)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckpxNFp3NXkrcmZtN0NSS0x2b0FNNHc0bTkxQlB0REhUakNkTmpTNE1lcCtu?=
 =?utf-8?B?bU16Y0gvQmNmQWZJMGFoU1labURSTDdZMkd3SzdTcWczSllYVlk5Mm14TGk0?=
 =?utf-8?B?UEs2cXArVnc2cXExN2s5UmpTSUwvUHpOcVlyMzNEdTVGYU1EVUNudjUyRDJQ?=
 =?utf-8?B?SEZKY2E5enFsSlBsQXBmT2F4NWo0ZEMzYmdwVmxiZlVTWVB4TXZyanp0MXlC?=
 =?utf-8?B?SnZ3ei9QdDdFeEFVVG1vc0NVY3BHNnphcnd0bC9DM0FYVDMwa09teFUyNEUv?=
 =?utf-8?B?bDY4UndQeUd1elF5dCtJZWl5ajdHOEp2VElrLzUrUDlKM1o1T3ZCMWl1U0RW?=
 =?utf-8?B?bVJ1MkNZY1pCOHBXa04rU3I1MEE5K2I3a25pR3ZxRDJpeHIyT3d6eXZOSTFh?=
 =?utf-8?B?OG92RE8xbWgzdm41eDFvdk5MR3VOaVhoVHpQZ1drbTJ3UTFTSDJWb2JYSjJn?=
 =?utf-8?B?SEo2VGh6YklUa1V6UkMwQnE3L1M5VGE0SVYvMFpOMURlVE1EbDZycEpFSjVh?=
 =?utf-8?B?YUlrcysrUC9vcE5Zak4yQ0NpOG9YdnY2bk9OaUMzdTBjQmRMRytNUmwvM0ds?=
 =?utf-8?B?NU94aThuek5rd0xXYnlqbUh6cm52QnMzR2dPcENKejlJYllnVmFmYVVPZ0FU?=
 =?utf-8?B?Um0rS0dRWnRINU5QZHd3Rk1CRnBzeU5mcE00QlR4c2NLTjRsMkRHYUl5UWNu?=
 =?utf-8?B?K3Jlb21GRkFWTWYvVDJlSTdSQWdLMGlWbHJYZmN6cVhoc2E3dTZVMlVIdEpY?=
 =?utf-8?B?K2RjZTFTaUdBK0ZvenJNNndlNDVmdEp6V3UyeGRHVEVqNWo0MWJFVS9sOWdj?=
 =?utf-8?B?cVFUWW8yZ0lsSFQyaVNVRkFEZGZweElzZHg2M09Ld0NKT1FUUnBHQmpwS3JR?=
 =?utf-8?B?WjNkVHhzL21wNHJGaFhGai9qSk1XU1hsL2RRcDQwTDlXd091MUhYMlhtRFZ6?=
 =?utf-8?B?VTFoVHJ3V1NHUnF3SEs5ajB3ckJ5RWE5ME5qQUd5eXVIZDdselIxNlR4YXpO?=
 =?utf-8?B?eFQ2Z1lnVlNkTnhjUnArcEczUGVwY2Q4QldjMkdqSlU3VXhvOEN2MElDWklo?=
 =?utf-8?B?ck1KMFBBRlU5emdweUNBcktWWnJuM0hDdTBMZUg0UllwNUVQekZSVDZ6T3Ja?=
 =?utf-8?B?RXltMEU1K2hhZHdhT05FRkxlOG5kN1I5dzlQUW9oRzNoS0VXcWdKUW1GVzVm?=
 =?utf-8?B?dmpJdDd3QWtZMTYzTFRXVGNLdGRETldJbjFSODFpOCtoSmtac1BKSlVlYnQv?=
 =?utf-8?B?cWRoTEN1Z3pqOEIyQ1FheTRiK0gwazRkM1BtbXZyWHBQUEo2WEl3cDB0Tzhs?=
 =?utf-8?B?ckU5NUhCTEFKbWI2N2RiNVE0cUVFTUUybmF4enNhN0h4b2t1Y2hCa1dnYUlK?=
 =?utf-8?B?NVEyd0JjblYxd3FRdkhGNFdxV3pRdnl1U3JYdmg2VUh1N0R5RXQ2RURtY0c2?=
 =?utf-8?B?Tng0WDExQmlabFNLeUVwN2hBbVkwVDNoRGJTY0NuVm5rK21CTDN0RnBaVjdu?=
 =?utf-8?B?bFRGYUtkajgwZk54L2hjelYvM2I2a1RybmIwQy9XOWptWFF4ajFrZDJxMnll?=
 =?utf-8?B?YnN1YjR6dTYvdzl6Q1FUVFNpVHY1d1prNXpBclpxWENIVkxNakxZaUdpOXBm?=
 =?utf-8?B?UzJBdWhtZkx5dVNJYlIyVU4zWUliSDZEL0RVSTZGRmdCckFWdVUxWlQzdlFB?=
 =?utf-8?B?cnJmcTF6QXpPTzFaeGJxQmJpWVpYSGN5blM3dUpaUFBFOXhNMG0yUS9mSVVr?=
 =?utf-8?B?bkFsOFlaTFlod3RuVy9ROUxZcU50cXJXV2xFa29xNmllUDRuU3MvQkxYWUtP?=
 =?utf-8?B?cHhqVU5mT2ZBKzBUWkFWUHk3N3VwVkhtc3YwWCs3ZDJuT21uSnFzQlF6ZnVV?=
 =?utf-8?B?YWZXYk1uOVlzakp2L0FOdGcvb1l6LzRQUlNyOEYzYVZlMEo2VWp0anovbEJU?=
 =?utf-8?B?TUFBMHZJSjNjOHdFekpJa0ZhNS8zejdEWlFSWUJhbVZ6YnpUY1FLQ3NJTXov?=
 =?utf-8?B?YSs5ZmdMVThZdk0vTXlVSTdyYzdad1dkZDF5Nk40ZzRPbVczbm1rcis0Slhp?=
 =?utf-8?B?czN0d2RPREpvdmF0V2xwdXkvS2pyYjZMWlRZbmxxYm44ODYzNUYrUHduN1Bi?=
 =?utf-8?B?TFFtT2ZRbDVGekYxUnQrQ1JTczBwNTEzOEk2U1VacHFweWN1S1lMVVV1czVy?=
 =?utf-8?B?cTIrWUZDOWZwOHpHWTNBenFUVG85a0dLSEgxZE55S2loVEk5b0s5K29mak82?=
 =?utf-8?B?c2FZOVJtZklzcnp2RE1va3JYOWVwNVZWUTltYjM0Wmgrb3luck82UTdsc2gv?=
 =?utf-8?B?NlRPQ0pNWFBEQ1Z2cDhUNWR1QkpZSWJpa0RaTG5RUHVqZm9CaVlqNWkxcGYv?=
 =?utf-8?Q?OPH/z4fone8s03GqTEJ4UGYsLkHLzpYv9L8TzYdKjoRoC?=
X-MS-Exchange-AntiSpam-MessageData-1: r7lQxm7+Q789tQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a95efe3-266f-4859-c689-08df25fc1ba4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:43.8339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4xLPaqKpzvgifltpH789lEZnMADVZMN5fEz//skYqT1lcHB79m8/x+N3/HcZwa+gvWCX4jyWoSy8UFU+DaVAA==
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

Move the types and code related to sending and receiving RPC commands
and messages into the `rpc` sub-module. The methods are still declared
as members of `CmdqInner` and `Cmdq`; only they are now in their own
sub-module.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 412 +------------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 443 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              |   6 +-
 drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
 5 files changed, 454 insertions(+), 411 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 65e1a0b6bb44..c7deb1ae58f4 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-mod continuation;
+pub(super) mod rpc;
 
 use core::mem;
 
@@ -28,19 +29,13 @@
         },
         Mutex, //
     },
-    time::{
-        Delta,
-        Instant,
-        Monotonic, //
-    },
+    time::Delta,
     transmute::{
         AsBytes,
         FromBytes, //
     },
 };
 
-use continuation::SplitState;
-
 use pin_init::pin_init_scope;
 
 use crate::{
@@ -48,10 +43,8 @@
     gsp::{
         fw::{
             GspMsgElement,
-            MsgFunction,
             MsgqRxHeader,
             MsgqTxHeader,
-            RpcMessageHeader,
             GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
         },
         PteArray,
@@ -81,124 +74,6 @@ trait CommandElement {
     fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result;
 }
 
-/// Trait implemented by types representing a command to send to the GSP.
-///
-/// The main purpose of this trait is to provide [`Cmdq`] with the information it needs to send
-/// a given command.
-///
-/// [`CommandToGsp::init`] in particular is responsible for initializing the command directly
-/// into the space reserved for it in the command queue buffer.
-///
-/// Some commands may be followed by a variable-length payload. For these, the
-/// [`CommandToGsp::variable_payload_len`] and [`CommandToGsp::init_variable_payload`] need to be
-/// defined as well.
-pub(crate) trait CommandToGsp {
-    /// Function identifying this command to the GSP.
-    const FUNCTION: MsgFunction;
-
-    /// Type generated by [`CommandToGsp::init`], to be written into the command queue buffer.
-    type Command: FromBytes + AsBytes;
-
-    /// Type of the reply expected from the GSP, or [`NoReply`] for commands that don't
-    /// have a reply.
-    type Reply;
-
-    /// Error type returned by [`CommandToGsp::init`].
-    type InitError;
-
-    /// In-place command initializer responsible for filling the command in the command queue
-    /// buffer.
-    fn init(&self) -> impl Init<Self::Command, Self::InitError>;
-
-    /// Size of the variable-length payload following the command structure generated by
-    /// [`CommandToGsp::init`].
-    ///
-    /// Most commands don't have a variable-length payload, so this is zero by default.
-    fn variable_payload_len(&self) -> usize {
-        0
-    }
-
-    /// Method initializing the variable-length payload.
-    ///
-    /// The command buffer is circular, which means that we may need to jump back to its beginning
-    /// while in the middle of a command. For this reason, the variable-length payload is
-    /// initialized using a [`SBufferIter`].
-    ///
-    /// This method will receive a buffer of the length returned by
-    /// [`CommandToGsp::variable_payload_len`], and must write every single byte of it. Leaving
-    /// unwritten space will lead to an error.
-    ///
-    /// Most commands don't have a variable-length payload, so this does nothing by default.
-    fn init_variable_payload(
-        &self,
-        _dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
-    ) -> Result {
-        Ok(())
-    }
-
-    /// Total size of the command (including its variable-length payload) without the
-    /// [`GspMsgElement`] header.
-    fn size(&self) -> usize {
-        size_of::<Self::Command>() + self.variable_payload_len()
-    }
-}
-
-/// Wrapper type for sending a RPC command as a command queue element.
-///
-/// [`CommandElement`] cannot be directly implemented for all [`CommandToGsp`] with a blanket
-/// implementation as it would conflict with other future command types.
-struct RpcCommandElement<M>(M);
-
-impl<M> CommandElement for RpcCommandElement<M>
-where
-    M: CommandToGsp,
-    Error: From<M::InitError>,
-{
-    fn size(&self) -> usize {
-        self.0.size()
-    }
-
-    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result {
-        let command = &self.0;
-        let size_in_bytes = command.size();
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
-
-        dev_dbg!(
-            dev,
-            "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
-            seq,
-            M::FUNCTION,
-            size_in_bytes,
-        );
-
-        Ok(())
-    }
-}
-
 /// Trait implemented by types that can be received as single command queue elements.
 ///
 /// The command queue validates the element header before calling `read()` to interpret the
@@ -208,70 +83,6 @@ trait MessageElement: Sized {
     fn read(dev: &device::Device, message: GspMessage<'_>) -> Result<Self>;
 }
 
-/// Trait representing messages received from the GSP.
-///
-/// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
-/// The receiver matches a message's function code against [`Self::FUNCTION`] and decodes the
-/// message with [`Self::read`].
-pub(crate) trait MessageFromGsp: Sized {
-    /// Function identifying this message from the GSP.
-    const FUNCTION: MsgFunction;
-
-    /// Error type returned by [`MessageFromGsp::read`].
-    type InitError;
-
-    /// Type containing the raw message to be read from the message queue.
-    type Message: FromBytes;
-
-    /// Method reading the message from the message queue and returning it.
-    ///
-    /// From a `Self::Message` and a [`SBufferIter`], constructs an instance of `Self` and returns
-    /// it.
-    fn read(
-        msg: &Self::Message,
-        sbuffer: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError>;
-}
-
-/// Wrapper type for receiving a RPC message from a command queue element.
-///
-/// [`MessageElement`] cannot be directly implemented for all [`MessageFromGsp`] with a blanket
-/// implementation as it would conflict with other future message types.
-struct RpcMessageElement<M>(M);
-
-impl<M> MessageElement for RpcMessageElement<M>
-where
-    M: MessageFromGsp,
-    Error: From<M::InitError>,
-{
-    fn read(dev: &device::Device, message: GspMessage<'_>) -> Result<Self> {
-        let rpc_message = RpcMessage::parse(dev, message)?;
-        let function = rpc_message.header.function();
-
-        // An early return here would leave the read pointer on this message.
-        let result = if matches!(function, Ok(f) if f == M::FUNCTION) {
-            let (cmd, contents_1) =
-                M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
-            let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
-
-            M::read(cmd, &mut sbuffer)
-                .map(Self)
-                .map_err(|e| e.into())
-                .inspect(|_| {
-                    if !sbuffer.is_empty() {
-                        dev_warn!(dev, "GSP message {:?} has unprocessed data\n", M::FUNCTION);
-                    }
-                })
-        } else {
-            rpc_message.log(dev);
-
-            Err(ENOMSG)
-        };
-
-        result
-    }
-}
-
 /// Number of GSP pages making the [`Msgq`].
 pub(crate) const MSGQ_NUM_PAGES: u32 = 0x3f;
 
@@ -607,92 +418,6 @@ struct GspMessage<'a> {
     contents: (&'a [u8], &'a [u8]),
 }
 
-/// A RPC message ready to be processed from the message queue.
-struct RpcMessage<'a> {
-    // Reference to the RPC header of the message.
-    header: &'a RpcMessageHeader,
-    // Slices to the contents of the message. The second slice is empty unless the message loops
-    // over the message queue.
-    contents: (&'a [u8], &'a [u8]),
-}
-
-impl<'a> RpcMessage<'a> {
-    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
-    /// to the RPC payload.
-    ///
-    /// # Errors
-    ///
-    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
-    fn parse(dev: &device::Device, element: GspMessage<'a>) -> Result<RpcMessage<'a>> {
-        let GspMessage {
-            header,
-            contents: (slice_1, slice_2),
-        } = element;
-
-        let rpc_header = header.rpc_header();
-        let payload_length = rpc_header.rpc_length();
-
-        dev_dbg!(
-            dev,
-            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            rpc_header.sequence(),
-            rpc_header.function(),
-            payload_length,
-        );
-
-        // Check that the driver read area is large enough for the message.
-        if slice_1.len() + slice_2.len() < payload_length {
-            return Err(EIO);
-        }
-
-        // Cut the message slices down to the actual length of the message.
-        let (slice_1, slice_2) = if slice_1.len() > payload_length {
-            // PANIC: we checked above that `slice_1` is at least as long as `payload_length`.
-            (slice_1.split_at(payload_length).0, &slice_2[0..0])
-        } else {
-            (
-                slice_1,
-                // PANIC: we checked above that `slice_1.len() + slice_2.len()` is at least as
-                // large as `payload_length`.
-                slice_2.split_at(payload_length - slice_1.len()).0,
-            )
-        };
-
-        Ok(RpcMessage {
-            header: rpc_header,
-            contents: (slice_1, slice_2),
-        })
-    }
-
-    /// Logs an event, meaning a message that no caller was waiting for.
-    ///
-    /// An OS error or robust-channel record is logged at error level and an unknown function code
-    /// at warning level. Other events are not logged.
-    fn log(&self, dev: &device::Device) {
-        let function = self.header.function();
-        let seq = self.header.sequence();
-
-        match function {
-            Ok(MsgFunction::OsErrorLog) => {
-                dev_err!(dev, "GSP reported an OS error (seq {})\n", seq);
-            }
-            Ok(MsgFunction::RcTriggered) => {
-                dev_err!(dev, "GSP triggered robust-channel recovery (seq {})\n", seq);
-            }
-            // Nothing to do for the remaining known function codes.
-            Ok(_) => {}
-            Err(raw) => {
-                dev_warn!(
-                    dev,
-                    "unknown GSP message function {:#x} (seq {})\n",
-                    raw,
-                    seq
-                );
-            }
-        }
-    }
-}
-
 /// GSP command queue.
 ///
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
@@ -764,73 +489,6 @@ fn notify_gsp(bar: Bar0<'_>) {
         bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
 
-    /// Sends `command` to the GSP and waits for the reply.
-    ///
-    /// Events that arrive before the reply are logged and consumed.
-    ///
-    /// The queue is locked for the entire send+receive cycle to ensure that no other command can
-    /// be interleaved.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply does
-    ///   not arrive within [`Self::RECEIVE_TIMEOUT`] of the send, however many events arrive
-    ///   while waiting.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
-    ///
-    /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
-    where
-        M: CommandToGsp,
-        M::Reply: MessageFromGsp,
-        Error: From<M::InitError>,
-        Error: From<<M::Reply as MessageFromGsp>::InitError>,
-    {
-        let mut inner = self.inner.lock();
-        inner.send_command(command)?;
-
-        inner.await_msg()
-    }
-
-    /// Sends `command` to the GSP without waiting for a reply.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if space does not become available within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
-    ///
-    /// Error codes returned by the command initializers are propagated as-is.
-    pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
-    where
-        M: CommandToGsp<Reply = NoReply>,
-        Error: From<M::InitError>,
-    {
-        self.inner.lock().send_command(command)
-    }
-
-    /// Waits for an unsolicited GSP event of type `M`. Events that arrive before it are logged and
-    /// consumed.
-    ///
-    /// The queue mutex is held for the whole wait, up to [`Self::RECEIVE_TIMEOUT`], so no other
-    /// caller can send a command or consume an event meanwhile.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if the event does not arrive within [`Self::RECEIVE_TIMEOUT`] of the call,
-    ///   however many other events arrive while waiting.
-    /// - `EIO` if a message fails framing or checksum validation.
-    ///
-    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    pub(crate) fn await_msg<M: MessageFromGsp>(&self) -> Result<M>
-    where
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
-        self.inner.lock().await_msg()
-    }
-
     /// Logs and consumes every message the GSP has already posted, and returns without waiting for
     /// more.
     ///
@@ -904,36 +562,6 @@ fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result {
         Ok(())
     }
 
-    /// Sends `command` to the GSP.
-    ///
-    /// The command may be split into multiple messages if it is large.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if space does not become available within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
-    ///
-    /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command<M>(&mut self, command: M) -> Result
-    where
-        M: CommandToGsp,
-        Error: From<M::InitError>,
-    {
-        match SplitState::new(command)? {
-            SplitState::Single(command) => self.send_command_element(RpcCommandElement(command)),
-            SplitState::Split(command, mut continuations) => {
-                self.send_command_element(RpcCommandElement(command))?;
-
-                while let Some(continuation) = continuations.next() {
-                    self.send_command_element(RpcCommandElement(continuation))?;
-                }
-
-                Ok(())
-            }
-        }
-    }
-
     /// Wait for the next element to become available on the message queue.
     ///
     /// This works purely at the transport layer and does not interpret or validate the message
@@ -1001,37 +629,6 @@ fn consume_element<M: MessageElement>(&mut self, timeout: Delta) -> Result<M> {
         result
     }
 
-    /// Receives a message of type `M`, waiting up to [`Cmdq::RECEIVE_TIMEOUT`] from the call.
-    ///
-    /// Any other message that arrives first is logged as an event and does not extend the
-    /// deadline.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if no message of type `M` arrives before the deadline, however many other
-    ///   messages arrive while waiting.
-    /// - `EIO` if a message fails framing or checksum validation (see [`Self::wait_for_msg`]).
-    ///
-    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
-    where
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
-        let deadline = Instant::<Monotonic>::now() + Cmdq::RECEIVE_TIMEOUT;
-        loop {
-            let remaining = deadline - Instant::<Monotonic>::now();
-            if remaining.is_negative() {
-                break Err(ETIMEDOUT);
-            }
-            match self.consume_element::<RpcMessageElement<M>>(remaining) {
-                Ok(msg) => break Ok(msg.0),
-                Err(ENOMSG) => continue,
-                Err(e) => break Err(e),
-            }
-        }
-    }
-
     /// Logs and consumes every message the queue holds.
     ///
     /// # Errors
@@ -1049,7 +646,8 @@ fn drain(&mut self) -> Result {
                     EIO
                 })?;
 
-            RpcMessage::parse(self.dev, msg)?.log(self.dev);
+            // RPC is the only type of message supported, so dispatch the message there.
+            rpc::RpcMessage::parse(self.dev, msg)?.log(self.dev);
 
             self.gsp_mem.advance_cpu_read_ptr(pages);
         }
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
new file mode 100644
index 000000000000..39fc3a9e61fe
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Support for the RPC message type on the GSP command queue.
+
+mod continuation;
+
+use kernel::{
+    device,
+    prelude::*,
+    time::{
+        Instant,
+        Monotonic, //
+    },
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    },
+};
+
+use continuation::SplitState;
+
+use crate::{
+    gsp::{
+        cmdq::{
+            GspCommand,
+            NoReply, //
+        },
+        fw::{
+            MsgFunction,
+            RpcMessageHeader, //
+        },
+    },
+    sbuffer::SBufferIter,
+};
+
+use super::{
+    Cmdq,
+    CmdqInner,
+    CommandElement,
+    GspMessage,
+    MessageElement, //
+};
+
+/// Trait implemented by types representing a command to send to the GSP.
+///
+/// The main purpose of this trait is to provide [`Cmdq`] with the information it needs to send
+/// a given command.
+///
+/// [`CommandToGsp::init`] in particular is responsible for initializing the command directly
+/// into the space reserved for it in the command queue buffer.
+///
+/// Some commands may be followed by a variable-length payload. For these, the
+/// [`CommandToGsp::variable_payload_len`] and [`CommandToGsp::init_variable_payload`] need to be
+/// defined as well.
+pub(crate) trait CommandToGsp {
+    /// Function identifying this command to the GSP.
+    const FUNCTION: MsgFunction;
+
+    /// Type generated by [`CommandToGsp::init`], to be written into the command queue buffer.
+    type Command: FromBytes + AsBytes;
+
+    /// Type of the reply expected from the GSP, or [`NoReply`] for commands that don't
+    /// have a reply.
+    type Reply;
+
+    /// Error type returned by [`CommandToGsp::init`].
+    type InitError;
+
+    /// In-place command initializer responsible for filling the command in the command queue
+    /// buffer.
+    fn init(&self) -> impl Init<Self::Command, Self::InitError>;
+
+    /// Size of the variable-length payload following the command structure generated by
+    /// [`CommandToGsp::init`].
+    ///
+    /// Most commands don't have a variable-length payload, so this is zero by default.
+    fn variable_payload_len(&self) -> usize {
+        0
+    }
+
+    /// Method initializing the variable-length payload.
+    ///
+    /// The command buffer is circular, which means that we may need to jump back to its beginning
+    /// while in the middle of a command. For this reason, the variable-length payload is
+    /// initialized using a [`SBufferIter`].
+    ///
+    /// This method will receive a buffer of the length returned by
+    /// [`CommandToGsp::variable_payload_len`], and must write every single byte of it. Leaving
+    /// unwritten space will lead to an error.
+    ///
+    /// Most commands don't have a variable-length payload, so this does nothing by default.
+    fn init_variable_payload(
+        &self,
+        _dst: &mut SBufferIter<core::array::IntoIter<&mut [u8], 2>>,
+    ) -> Result {
+        Ok(())
+    }
+
+    /// Total size of the command (including its variable-length payload) without the
+    /// [`GspMsgElement`] header.
+    fn size(&self) -> usize {
+        size_of::<Self::Command>() + self.variable_payload_len()
+    }
+}
+
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
+/// Trait representing messages received from the GSP.
+///
+/// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
+/// The receiver matches a message's function code against [`Self::FUNCTION`] and decodes the
+/// message with [`Self::read`].
+pub(crate) trait MessageFromGsp: Sized {
+    /// Function identifying this message from the GSP.
+    const FUNCTION: MsgFunction;
+
+    /// Error type returned by [`MessageFromGsp::read`].
+    type InitError;
+
+    /// Type containing the raw message to be read from the message queue.
+    type Message: FromBytes;
+
+    /// Method reading the message from the message queue and returning it.
+    ///
+    /// From a `Self::Message` and a [`SBufferIter`], constructs an instance of `Self` and returns
+    /// it.
+    fn read(
+        msg: &Self::Message,
+        sbuffer: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError>;
+}
+
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
+/// A RPC message ready to be processed from the message queue.
+pub(super) struct RpcMessage<'a> {
+    // Reference to the RPC header of the message.
+    header: &'a RpcMessageHeader,
+    // Slices to the contents of the message. The second slice is empty unless the message loops
+    // over the message queue.
+    contents: (&'a [u8], &'a [u8]),
+}
+
+impl<'a> RpcMessage<'a> {
+    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
+    /// to the RPC payload.
+    ///
+    /// # Errors
+    ///
+    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
+    pub(super) fn parse(dev: &device::Device, element: GspMessage<'a>) -> Result<RpcMessage<'a>> {
+        let GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        } = element;
+
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.rpc_length();
+
+        dev_dbg!(
+            dev,
+            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
+        );
+
+        // Check that the driver read area is large enough for the message.
+        if slice_1.len() + slice_2.len() < payload_length {
+            return Err(EIO);
+        }
+
+        // Cut the message slices down to the actual length of the message.
+        let (slice_1, slice_2) = if slice_1.len() > payload_length {
+            // PANIC: we checked above that `slice_1` is at least as long as `payload_length`.
+            (slice_1.split_at(payload_length).0, &slice_2[0..0])
+        } else {
+            (
+                slice_1,
+                // PANIC: we checked above that `slice_1.len() + slice_2.len()` is at least as
+                // large as `payload_length`.
+                slice_2.split_at(payload_length - slice_1.len()).0,
+            )
+        };
+
+        Ok(RpcMessage {
+            header: rpc_header,
+            contents: (slice_1, slice_2),
+        })
+    }
+
+    /// Logs an event, meaning a message that no caller was waiting for.
+    ///
+    /// An OS error or robust-channel record is logged at error level and an unknown function code
+    /// at warning level. Other events are not logged.
+    pub(super) fn log(&self, dev: &device::Device) {
+        let function = self.header.function();
+        let seq = self.header.sequence();
+
+        match function {
+            Ok(MsgFunction::OsErrorLog) => {
+                dev_err!(dev, "GSP reported an OS error (seq {})\n", seq);
+            }
+            Ok(MsgFunction::RcTriggered) => {
+                dev_err!(dev, "GSP triggered robust-channel recovery (seq {})\n", seq);
+            }
+            // Nothing to do for the remaining known function codes.
+            Ok(_) => {}
+            Err(raw) => {
+                dev_warn!(
+                    dev,
+                    "unknown GSP message function {:#x} (seq {})\n",
+                    raw,
+                    seq
+                );
+            }
+        }
+    }
+}
+
+impl Cmdq<'_> {
+    /// Sends `command` to the GSP and waits for the reply.
+    ///
+    /// Events that arrive before the reply are logged and consumed.
+    ///
+    /// The queue is locked for the entire send+receive cycle to ensure that no other command can
+    /// be interleaved.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply does
+    ///   not arrive within [`Self::RECEIVE_TIMEOUT`] of the send, however many events arrive
+    ///   while waiting.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    ///
+    /// Error codes returned by the command and reply initializers are propagated as-is.
+    pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
+    where
+        M: CommandToGsp,
+        M::Reply: MessageFromGsp,
+        Error: From<M::InitError>,
+        Error: From<<M::Reply as MessageFromGsp>::InitError>,
+    {
+        let mut inner = self.inner.lock();
+        inner.send_command(command)?;
+
+        inner.await_msg()
+    }
+
+    /// Sends `command` to the GSP without waiting for a reply.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if space does not become available within the timeout.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    ///
+    /// Error codes returned by the command initializers are propagated as-is.
+    pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
+    where
+        M: CommandToGsp<Reply = NoReply>,
+        Error: From<M::InitError>,
+    {
+        self.inner.lock().send_command(command)
+    }
+
+    /// Waits for an unsolicited GSP event of type `M`. Events that arrive before it are logged and
+    /// consumed.
+    ///
+    /// The queue mutex is held for the whole wait, up to [`Self::RECEIVE_TIMEOUT`], so no other
+    /// caller can send a command or consume an event meanwhile.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if the event does not arrive within [`Self::RECEIVE_TIMEOUT`] of the call,
+    ///   however many other events arrive while waiting.
+    /// - `EIO` if a message fails framing or checksum validation.
+    ///
+    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
+    pub(crate) fn await_msg<M: MessageFromGsp>(&self) -> Result<M>
+    where
+        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
+        Error: From<M::InitError>,
+    {
+        self.inner.lock().await_msg()
+    }
+}
+
+impl CmdqInner<'_> {
+    /// Sends `command` to the GSP.
+    ///
+    /// The command may be split into multiple messages if it is large.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if space does not become available within the timeout.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    ///
+    /// Error codes returned by the command initializers are propagated as-is.
+    fn send_command<M>(&mut self, command: M) -> Result
+    where
+        M: CommandToGsp,
+        Error: From<M::InitError>,
+    {
+        match SplitState::new(command)? {
+            SplitState::Single(command) => self.send_command_element(RpcCommandElement(command)),
+            SplitState::Split(command, mut continuations) => {
+                self.send_command_element(RpcCommandElement(command))?;
+
+                while let Some(continuation) = continuations.next() {
+                    self.send_command_element(RpcCommandElement(continuation))?;
+                }
+
+                Ok(())
+            }
+        }
+    }
+
+    /// Receives a message of type `M`, waiting up to [`Cmdq::RECEIVE_TIMEOUT`] from the call.
+    ///
+    /// Any other message that arrives first is logged as an event and does not extend the
+    /// deadline.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if no message of type `M` arrives before the deadline, however many other
+    ///   messages arrive while waiting.
+    /// - `EIO` if a message fails framing or checksum validation (see [`Self::wait_for_msg`]).
+    ///
+    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
+    fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
+    where
+        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
+        Error: From<M::InitError>,
+    {
+        let deadline = Instant::<Monotonic>::now() + Cmdq::RECEIVE_TIMEOUT;
+        loop {
+            let remaining = deadline - Instant::<Monotonic>::now();
+            if remaining.is_negative() {
+                break Err(ETIMEDOUT);
+            }
+            match self.consume_element::<RpcMessageElement<M>>(remaining) {
+                Ok(msg) => break Ok(msg.0),
+                Err(ENOMSG) => continue,
+                Err(e) => break Err(e),
+            }
+        }
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc/continuation.rs
similarity index 100%
rename from drivers/gpu/nova-core/gsp/cmdq/continuation.rs
rename to drivers/gpu/nova-core/gsp/cmdq/rpc/continuation.rs
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index cdbb13674f08..ceac0b0f9423 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -23,9 +23,11 @@
     gpu::Chipset,
     gsp::{
         cmdq::{
+            rpc::{
+                CommandToGsp,
+                MessageFromGsp, //
+            },
             Cmdq,
-            CommandToGsp,
-            MessageFromGsp,
             NoReply, //
         },
         fw::{
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 250adc9fe74f..9f5ab08def2c 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -28,8 +28,8 @@
     },
     gsp::{
         cmdq::{
-            Cmdq,
-            MessageFromGsp, //
+            rpc::MessageFromGsp,
+            Cmdq, //
         },
         fw,
         GspBootContext,

-- 
2.56.0

