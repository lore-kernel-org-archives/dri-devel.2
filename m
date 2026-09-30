Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B040CA5FCE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF4B10F467;
	Wed, 30 Sep 2026 14:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FjcUe38V";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B536710F463
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMVk1fUFmeujVZzvkWjkEdtE7FLDg2eafWs00UPYIUCFyXMbyuvi2GNoW1idk6rKzDL4e6n5HvJL/8NV7sXYR4avzKOTl2RRSzXiHYUd77E4FmOxp7VEwsZ3eeTbxgIwnPpd+4Y9AqrWMigZsaRhV2GeFy19UeoiVmVhNeCx2T2IXQiIzKDXWAy+/VfE7QrDuL4L/lYCmYOgZ1qjdBl1HgNZKrY94cg7WZbg43YM0H8fBaqGhC15KfJTs0g0JawEqdatmipr07GukeyD4Y7kHkzbFCdPoak/XWcHjOLxaOs9Wfdiw5/3R0unjYIlabWXyWBr3qz9LEleQjtJpdIA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op71oAxOgY8EKLxnPBpw/nQYbOxqNN8+Jl2rNuFA+Cg=;
 b=dWgW1NyV9UgbdLMV+kgG4lOsJHExJsWRc5Fr16MTCdJnDdQoc+OPnqEzJTAUS6PSwXcZTFWHguB15WUbKpYCl+VO7jpjYW0Jc2k18N8pIaMtBwF6hlQXq/b02cof7Jr52TEbnUypBYoVTUyGM4ntKBmK3c91uJfQwTeWZc7Lrl7c6m7xdogSpMZ5TjcaRFzg/3UgVDMiv1KlN1wHAN18HYZO0lrBN5miysMRDDZFYAA48kOuH5zgujWONNY3jTYb2h/nJmWqnP2nO7zenTymSvxQP3mFRK/zMd7N2L+M/gZPCurCCMLyks6I25B3P18SWZZkM58MYp3Grjx3KykIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op71oAxOgY8EKLxnPBpw/nQYbOxqNN8+Jl2rNuFA+Cg=;
 b=FjcUe38VBzq7i9eFr95ceFbj5UDIXvBpcwg3BPOjyQsJqnN1iP3usZpJs548xGo/FiMnoKGk4q9y5aeZyGTh7kIx++H44SMGUKNKRXeC26l7b+1yT62d9NZmWE92cZzGsIG8PibADEZEpXMkTm65DFxUEJd+5qUaOpIwR7j2pfof66uiH8If6YkD9SOLZ995xt1Md4GAQfMskCDOpVcATynAfUSwdfoFUT40cce+xQnv5Ta3xguVBdw4sZMeBsUZWwOW2SsV9i/JXkGk2c0ME1cWIXlzBR8j8XHDmwd7mfTz/lLamZQZHm76RxrxXaaA/2pvB1wrtIfQ3ybFQVzDtg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:57:16 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:57:16 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:46 +0900
Subject: [PATCH v3 7/9] gpu: nova-core: gsp: cmdq: move the RPC code into a
 sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-7-91613f06520b@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d89862-f066-4a54-011f-08df1f031e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|3023799007|56012099006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GisXqM3DFrfVUjhvhgWuVPoB+tghtqjRHVnaiOSnViPv8X6O6uCWJFvdZShtvDHnrX+F8XYWWMa5uZOZLdUsDblnIxyo6wEWLmSVWKiLb5hOWKvRCn9rZ0FPRPjZVZCXDI67zMOZGl/5CVPkw3rP/08OG7//CrOeRIUfHOz5TZkfZPY9tYiY3/qlF4+xS2qQZWXQcBIMaaY+TAPX7uu2J+layqSsaySkTMEoWT3U3Y6f5tZhzUQv5ZMLutNWaU6aq3m1KaqDE3odf70BH4owT6IZEcRKB0VNnpBT8x5HhonQwJNp5W1DnVXLP7yN+YCsuXv2DjdPpI9A78myoIGNV3nQY1YjRnMEtT8ymSwRCgvnTPqjCoCoBhjIIS13JzcQdCwFuO1eKCHbR79q0cIqYt45dHpAO3R8nlKOZy/1KtGdIYrwL7io6t+5mBwYyZBH/yElDaIYE6QglddwZFyAmwkDL+pRN66nV082nbQtv9qfhAJuaio1x9SzxEf+39Nw2KoKWIvB2dtGvZMDdjXgdblay6tYWZCj2ar3Q7BAFW33ZEgdF2LEcYvN5jfcObMHMF97w/bUiyj1iU1ABRqjBkPw+GXkiVnNCkhUFHzV8FpLOR+6HOPNF07d+Z0nocn+2fXnp7MsV5kowek610FFgmrvPxuelcIdjAW8sx7aDx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(3023799007)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjAyc3hGcjZvcEJyVm9zL0JjN1M4d3hqRGIxUnMxdml4bGFsa2swYlFFZld3?=
 =?utf-8?B?SmpJNnE2NTdKWmxkNFhDVjhBS1NHV0szV2xBU2xpTGpPRFpuOU1WdkJLdGUv?=
 =?utf-8?B?dkdja1hYc2tnOFFTbENHLzJTWnphdk1ZRW85eDExb2QzSFl2SzJGeDFRemVS?=
 =?utf-8?B?OHFhVnNETkRuQmltMENuSjNKQWZ0QnVRRGVXTklGTlEydzBGVzFVK09Pd2VJ?=
 =?utf-8?B?em51SDlOQWlzaGtYRzVCNVNQZ2Z5dUJKclM2VUd6SWxmWEFDV2R3c1oyeERI?=
 =?utf-8?B?MytQaG91dEFFNWE3NW5QaGs0cmkydjhPSHVTTnJyaTg4YzRvdWVtTUhwV3hZ?=
 =?utf-8?B?VklqRWpVdjhTSk5QbUhrc0xoMUxRY2RIY1F0TEpKNHgxWE9jOHE5TmY4UE45?=
 =?utf-8?B?TUFJZTZxRGRnaFZLempaVlZvRzRmdmIyQ0ZUNFIyWTRvQmFzRmJteDhJQThF?=
 =?utf-8?B?YnEwYzRWQXdyMVpDM3dXc1NMakVNQnVoNnBibDFoR09zc3lvYi94WXo5b3J3?=
 =?utf-8?B?SzNjNFoxSW5PQnhDaGN0YUhDQXJIL0RaLy9lY0dOeWJRTzF2dnZEYlR0bEJU?=
 =?utf-8?B?cFNXQW1wRHp4NFg3dE9lUUNrRTdTL21pZXdDQ0t6V3JjYVU5NkdiZmgwdzdQ?=
 =?utf-8?B?UEtlUHlIUEFXdkNlTHRVY2Y3dzg3ajJVdVBlUDdtd1RxTU81Ulgyb1QvU0Jv?=
 =?utf-8?B?TFVUbzh0RHVqeFo4WEdhOUZBQzZkL252SFdOc05qdkN1bTA2NTkzdDJmSXNQ?=
 =?utf-8?B?OTFGWUZTcGRjb0t5SXJCdG0ycjNGb25WWExTR0NzUm5vancvQUNoY0dTUVhG?=
 =?utf-8?B?dVJwbU05Z242K1J5VDFvK25iakVkckpSdGZrSVA3bVZMYWgvSjd5UGRvZGVq?=
 =?utf-8?B?MHlmaG90U0M5VVNpb3JqS05yZThEVCsxRGhmbGlubmlBZzAxVzNkK1BPZ05p?=
 =?utf-8?B?VGNqcHQxZEVqcThodXoyRWFSb25NdmlHelpuZ094L2t6MjcvNHg4eGRzWkJz?=
 =?utf-8?B?aDFTV2dvbTVJdzcrN0hFSDdLVEovQi9EaFhnU3UvTWFadmpnWjZVVmFaNFp3?=
 =?utf-8?B?M25SM3AyS25tSVR4L1IzeXZNemZ4MGMvbzhpNjNBdG1qNGxsOHhNejcza2t6?=
 =?utf-8?B?TlhYbytibENLUkFpNkNmNFk3MkZTOXNvZlBjcTQySXNTLzBtbHB0Yno3MFJ6?=
 =?utf-8?B?b21Bd25KdTk5UEd2RUZyZXQ1UjNTYU44MjBMNEsyRGU2ZmZScmQ3NnRGaFhw?=
 =?utf-8?B?ejFZSCt2UVp0eTl0TzhSMU9pWnEyaEQ3YU1pWTduczBPSFM0R1k4RXl6SDlP?=
 =?utf-8?B?VGNRb1AvY3paL082bHNDbExYdWZNV3FDV1ZzaHJDd3RLTkxUUEJHWC9xUk1M?=
 =?utf-8?B?bVMyeExmU0N1aHpoM2xKREhGbGMwSUhlVzdqMHhkZU5pbXkrdjVoSWV6Z3A2?=
 =?utf-8?B?ZnozNWtaSyt2V0NDYnhzQTBTVXZlMHpIWmJmbkNMeGtSQVBiLzhoaFo4dHFB?=
 =?utf-8?B?cUZ2WDk1MXhZUXlwRHluZDBkeEVwakJiMjREK0ZobzRDS251Z2pteGU2L3Aw?=
 =?utf-8?B?bENaRXpyalZUcWdxY3hZMnVuZ1ZRRkpVZjFUemUyOVYzRjNZWTFBWEtmVGJs?=
 =?utf-8?B?TW5ZRldvQ0ZHWEJTcjF0UzEzU2tsZ1hYNE4rNWl0ZXljeVQyZER6Qk92c09w?=
 =?utf-8?B?cFdYYVRBQUpkMHB0MFpTSUo1a2FJKzh1Vm52SXhmUTRoS1RjcUtQYVFqeWVq?=
 =?utf-8?B?eEVoay8wU3p1WWJEMUx6OGJrZVVSWjRlemp2d1UyK0hvM1loeTNpdkV3alc4?=
 =?utf-8?B?U2xuSkwrYlV3a2M2TDBxNGdvWU5WU0Z2YnNGeVdhSXR3dkgzMy9FQ2JuTHR5?=
 =?utf-8?B?STVGR1hBRys3YzFoSWl6THd5NlhLbXdNL05ZRlJOUHp1TmMrMzh5UnlqMVl6?=
 =?utf-8?B?Ri9Jdk1lT0NTamtuSGFPdG0zMjN4ckdseGs5VjhqZlVDQk1GbEt2UXhtZGJa?=
 =?utf-8?B?TUhSdG5ZRGFMS2IrRWNFVXZXMW53SDF6MFlyWGtlM1IxT1ZiTnpiRUxrVDlj?=
 =?utf-8?B?SnVpZXV0a3VkSzJMUDFvNC80ekZnZ0UzcW9ocS9IL0pONjNRNHFVaVRsMmQy?=
 =?utf-8?B?OWlrcys2dzQrYmF0b1VXbWhwM2EzMi9OdVZHekMyN3BKVTZNbG9QZng4alUz?=
 =?utf-8?B?eWR4Zy83WlRGTElKVjdTL3dLYnI1RjhGY0dEd1Y5OWRNalZoeUY0ZVhrY09u?=
 =?utf-8?B?VnViMlhNMXh2elBJZDBlSTc2ZEcrclVuVCtqYytuOW5YbHM1QitTcHU5eHht?=
 =?utf-8?B?TURLbTdORlpjWW43SkNYL1hJSzFDVlpIa05UOFgvVjFnUW5LZDArdHJtM3NO?=
 =?utf-8?Q?rAu77QsGOMTTNuj+Ry6oMZtkS4/123SOhKKNun9F6YJph?=
X-MS-Exchange-AntiSpam-MessageData-1: B0XM/sw1aFU5SA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d89862-f066-4a54-011f-08df1f031e26
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:16.3208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osj4tQExwjn0dQ1kkFQvGmRfyf9tLeRRMAOPKH0wx+MAIwq+/o7a07PIBDo+suwchz9eNW5aZWzMogWs6hhTiA==
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

Move the types and code related to sending and receiving RPC commands
and messages into the `rpc` sub-module. The methods are still declared
as members of `CmdqInner` and `Cmdq`; only they are now in their own
sub-module.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 343 +------------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 380 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              |   6 +-
 drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
 5 files changed, 388 insertions(+), 345 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 07036972dbec..06386d1ab192 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-mod continuation;
+pub(crate) mod rpc;
 
 use core::mem;
 
@@ -35,8 +36,6 @@
     },
 };
 
-use continuation::SplitState;
-
 use pin_init::pin_init_scope;
 
 use crate::{
@@ -44,10 +43,8 @@
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
@@ -77,124 +74,6 @@ trait CommandElement {
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
@@ -204,117 +83,6 @@ trait MessageElement: Sized {
     fn read(dev: &device::Device, element: GspMessage<'_>) -> Result<Self>;
 }
 
-/// Trait representing messages received from the GSP.
-///
-/// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
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
-impl<M> RpcMessageElement<M>
-where
-    M: MessageFromGsp,
-{
-    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
-    /// to the RPC payload.
-    ///
-    /// # Errors
-    ///
-    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
-    fn parse_rpc_message<'a>(
-        dev: &device::Device,
-        element: GspMessage<'a>,
-    ) -> Result<RpcMessage<'a>> {
-        let GspMessage {
-            header,
-            contents: (slice_1, slice_2),
-        } = element;
-
-        let rpc_header = header.rpc_header();
-        let payload_length = rpc_header.length();
-
-        dev_dbg!(
-            dev,
-            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            rpc_header.sequence(),
-            rpc_header.function(),
-            payload_length,
-        );
-
-        // Check that the element is large enough for the message.
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
-}
-
-impl<M> MessageElement for RpcMessageElement<M>
-where
-    M: MessageFromGsp,
-    Error: From<M::InitError>,
-{
-    fn read(dev: &device::Device, element: GspMessage<'_>) -> Result<Self> {
-        let message = Self::parse_rpc_message(dev, element)?;
-        let function = message.header.function().map_err(|_| EINVAL)?;
-
-        if function != M::FUNCTION {
-            return Err(ERANGE);
-        }
-
-        let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
-        let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
-
-        M::read(cmd, &mut sbuffer)
-            .map(Self)
-            .map_err(|e| e.into())
-            .inspect(|_| {
-                if !sbuffer.is_empty() {
-                    dev_warn!(dev, "GSP message {:?} has unprocessed data\n", function);
-                }
-            })
-    }
-}
-
 /// Number of GSP pages making the [`Msgq`].
 pub(crate) const MSGQ_NUM_PAGES: u32 = 0x3f;
 
@@ -650,17 +418,6 @@ struct GspMessage<'a> {
     contents: (&'a [u8], &'a [u8]),
 }
 
-/// A RPC message ready to be processed from the message queue.
-///
-/// This is the type returned by [`CmdqInner::parse_rpc_message`].
-struct RpcMessage<'a> {
-    // Reference to the RPC header of the message.
-    header: &'a RpcMessageHeader,
-    // Slices to the contents of the message. The second slice is zero unless the message loops
-    // over the message queue.
-    contents: (&'a [u8], &'a [u8]),
-}
-
 /// GSP command queue.
 ///
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
@@ -731,72 +488,6 @@ fn calculate_checksum<T: Iterator<Item = u8>>(it: T) -> u32 {
     fn notify_gsp(bar: Bar0<'_>) {
         bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
-
-    /// Sends `command` to the GSP and waits for the reply.
-    ///
-    /// Messages with non-matching function codes are silently consumed until the expected reply
-    /// arrives.
-    ///
-    /// The queue is locked for the entire send+receive cycle to ensure that no other command can
-    /// be interleaved.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply is
-    ///   not received within the timeout.
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
-        loop {
-            match inner.consume_element::<RpcMessageElement<M::Reply>>(Self::RECEIVE_TIMEOUT) {
-                Ok(reply) => break Ok(reply.0),
-                Err(ERANGE) => continue,
-                Err(e) => break Err(e),
-            }
-        }
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
-    /// Receive a message from the GSP.
-    ///
-    /// See [`CmdqInner::consume_element`] for details.
-    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
-    where
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
-        self.inner
-            .lock()
-            .consume_element::<RpcMessageElement<M>>(timeout)
-            .map(|m| m.0)
-    }
 }
 
 /// Inner mutex protected state of [`Cmdq`].
@@ -857,36 +548,6 @@ fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result {
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
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
new file mode 100644
index 000000000000..7ec0fed76637
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -0,0 +1,380 @@
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
+    time::Delta,
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
+/// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
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
+impl<M> RpcMessageElement<M>
+where
+    M: MessageFromGsp,
+{
+    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
+    /// to the RPC payload.
+    ///
+    /// # Errors
+    ///
+    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
+    fn parse_rpc_message<'a>(
+        dev: &device::Device,
+        element: GspMessage<'a>,
+    ) -> Result<RpcMessage<'a>> {
+        let GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        } = element;
+
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.length();
+
+        dev_dbg!(
+            dev,
+            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
+        );
+
+        // Check that the element is large enough for the message.
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
+}
+
+impl<M> MessageElement for RpcMessageElement<M>
+where
+    M: MessageFromGsp,
+    Error: From<M::InitError>,
+{
+    fn read(dev: &device::Device, element: GspMessage<'_>) -> Result<Self> {
+        let message = Self::parse_rpc_message(dev, element)?;
+        let function = message.header.function().map_err(|_| EINVAL)?;
+
+        if function != M::FUNCTION {
+            return Err(ERANGE);
+        }
+
+        let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
+        let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
+
+        M::read(cmd, &mut sbuffer)
+            .map(Self)
+            .map_err(|e| e.into())
+            .inspect(|_| {
+                if !sbuffer.is_empty() {
+                    dev_warn!(dev, "GSP message {:?} has unprocessed data\n", function);
+                }
+            })
+    }
+}
+
+/// A RPC message ready to be processed from the message queue.
+///
+/// This is the type returned by [`CmdqInner::parse_rpc_message`].
+struct RpcMessage<'a> {
+    // Reference to the RPC header of the message.
+    header: &'a RpcMessageHeader,
+    // Slices to the contents of the message. The second slice is zero unless the message loops
+    // over the message queue.
+    contents: (&'a [u8], &'a [u8]),
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
+}
+
+impl Cmdq<'_> {
+    /// Sends `command` to the GSP and waits for the reply.
+    ///
+    /// Messages with non-matching function codes are silently consumed until the expected reply
+    /// arrives.
+    ///
+    /// The queue is locked for the entire send+receive cycle to ensure that no other command can
+    /// be interleaved.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply is
+    ///   not received within the timeout.
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
+        loop {
+            match inner.consume_element::<RpcMessageElement<M::Reply>>(Self::RECEIVE_TIMEOUT) {
+                Ok(reply) => break Ok(reply.0),
+                Err(ERANGE) => continue,
+                Err(e) => break Err(e),
+            }
+        }
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
+    /// Receive a message from the GSP.
+    ///
+    /// See [`CmdqInner::consume_element`] for details.
+    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
+    where
+        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
+        Error: From<M::InitError>,
+    {
+        self.inner
+            .lock()
+            .consume_element::<RpcMessageElement<M>>(timeout)
+            .map(|m| m.0)
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc/continuation.rs
similarity index 100%
rename from drivers/gpu/nova-core/gsp/cmdq/continuation.rs
rename to drivers/gpu/nova-core/gsp/cmdq/rpc/continuation.rs
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 59d7d7fb15e8..25a5a8d33d64 100644
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
index dae34c11eb05..ebf13867746f 100644
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
2.55.0

