Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086C5C98332
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DEBB10E602;
	Sun, 27 Sep 2026 13:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dysz4hFw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6137D10E5FD
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZI9v9RptKy1mSrRzW3owT0mg7ZF5RRTVbMVNswM19WhRlB6ZtBcx9/+tAj0Pnmf8LdyEYUthJgEd1I5LlLj0BjRrzo6ys+sZrSLZZtJEGAXO/Omq1X/i/LR33CLrbaV8BD21ei0G0Z2sV5G4mHmsiWJqN3AS1gNd//7v3uXgg2s98YUPF3P2cbxJZxQFTxOOJaOIKXU874ha1n+rcAcsMQHrCCrBzem3jFx8Qjwta57hKEbdkz38SPlEiGibvgXR7eFdOm7qZGTQaetoVJPTskSH4dVRdka2txcF4OKiBzqTp0VA0EtwcfvceKsmfwokiMHw8XczZ0jkagCRFfZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z8YiKFd9kdIFtb5FEPF30kKWC83jQ4pQ7qbSa+QRYM=;
 b=vSzCrVk8+6NWA1D8SSWNCaimPVjxCLT1hzREm7rusHcVq8IWqrQnZj/mZIJGPmkDmyj0WBUn8XS7X4j204tLKD1B4saRg/8HjFsFpB5MgJY63Hdv9exXA3VzWTVyPk7wGuoG7Bf1a+v05J/8pOItnSTo19tmxOankeVnQpawiWRWFhRaDfB50aoR6J3j6M0buysf149lLqQRjnjVAkujo0AOdbKyCXEFDD6Ij7+emFCLyKpMfDyNDiDgtCSOsW+SD2dHE6eVLU1sCRBmhI3t1y4IXIn+HcH6ob2vV4Hxwa3eCcXw/gqFyds9NtXR7H98fPii5fWwTuI8DA6ZC6EgnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z8YiKFd9kdIFtb5FEPF30kKWC83jQ4pQ7qbSa+QRYM=;
 b=dysz4hFwvWwWXhm3itGxm9AfAB/TTF193+vwbxjs2mVhqfVH5w2AxSq7XAKnN7nouff1NFOp0MYFP0BGngr+z+ZIgQYYq8gBQw/OLc560PszMefqYMf/J1rJtZ2qZFOrE+yzsI3iYWA99CwsbtCR9BRXClZEvimr7E1KhgkR0xN+npAIGCNztwc7nVtPoYOxWSKM3ie3LuDUHPJDn1BGIF0LYuUjxBzI5LwwWqG6pSgdGobDPzd6TO5I6GVu3YBLOiQ2LLFcyxIonA9QaqDJbCO7VFy3LqfD1VxIhq/cxEQjlq0k+riLHp3sSlr07QPdAiVY3TL3JLHArdjHYU7CYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:41 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:40 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:22 +0900
Subject: [PATCH v2 5/9] gpu: nova-core: gsp: cmdq: move the RPC send code
 into a sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-5-c3f66ae73be4@nvidia.com>
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
X-ClientProxiedBy: OS3P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21f::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9ca589-e96f-4b7a-6b95-08df1c9dc248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|10067099003|3023799007|6133799003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JEZ5Ud3PKUY6bRAzslNHG0/7BosO901HmErAAG/0NCev0lsI/GLmP66hqMXBDEimAqkPLRlsTV/7N4SGzEozqxNlCsCBR5gNRyAy5FP84EICoFdQ5hkdNTJZOq3kRD3xk50VF/HkaFRNGI4amhrXhzQtV+aB2LmVE/+ALhrQb/AsecMWC4cIsInxW7GGFz8xOAs9rZ0RuUqZGee+CIvmxvLltcu75cObHRjysPgeKAbLqJbL1/O3t44UTYbHTbNavPXQ7gxaL3TicJCoscjprXTjmVJ+H8z7b0+COPWYLxTC1yNFxqBSI/0grT33MZqqoQsNjHwdSmpMWlLsNRe4P9pLQCb6Ic8Buum0UYKjoBMIdftbpkgVvSc4Gea8QXqHARLJMxjcKpdqIivvy5BGww7yOJIyGFEjGcNNT4pLVNGw7mu1T2OMQOhKLwtgArq1iERJikBZ+LIzBKXXJPiITctL7SKBac356fpiVt0iFsaIRZjNh5jfFSBE3JKB8EIM6euLcMJSKypjvRRP3njS7zfiFtEj1Q0LzkbCTOJfGpBNFc/XaVuS4G1FI5XBdhqRwLtg6eQIT59vqZxfJ9VcwgumBaKH5zh7TlqgpqwriNiHK++gBmsYtibfdYNAa3L5ANvf27/GRdBXyKAy+Jp1ASg06S7mdrwrmbPvaLkqoLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(10067099003)(3023799007)(6133799003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzFtSXFIYVRvc2N1V2hBOGkyb0NJcmZxVzVjSWVYNjlTcjQ5Tll0V09wcjZx?=
 =?utf-8?B?M05rY214alc1V1JMdkdPSlhQRVVIWDl3KzZUdFZ2M0RMYkJrWWtjZEIyem1o?=
 =?utf-8?B?bmthYVhYc1ZsRWVYOWFFZmJhc2pIdDdSTHIvcHh4SWhkcHFEaXgyOXY0V2Ft?=
 =?utf-8?B?MXlhakRIREVVazZ2alRwYTlkbUE4TG45RTF2TWtWR045ajYxVS9ldGNKMFhi?=
 =?utf-8?B?dVMvbFNZdDQ3MWpQYVpzWDJNQzNVaVMrT2F1dEM3NlhldzhhTVh4ZWNjMTRV?=
 =?utf-8?B?Zk9iNVR2MktaaWxPYlV5RFo4NXVDUHFQTkNsUGhTaTY1ZmQzQTZMTjN3WkNn?=
 =?utf-8?B?aGJuMU9OdHJBWStkVDRnbVA2NEFpd1IwSk1XZWc2RFQveCtPUjZaZWdMc2R6?=
 =?utf-8?B?VDFiMDd1UGJBOVY5U0JRenRtcm9mZnhKTE1wZHpZRlRmWjRsK1doL0VzMFV4?=
 =?utf-8?B?UnVVNGhveDJveFJiMEdKdGExTW0wNlBIOVRLdHVRMkZXd3lrYjJuMzcvYzNJ?=
 =?utf-8?B?bUozQ2tieGZTdXVCMHUzUnpzUUVKUzJrK3l4MkdWelVwWmxSZXZZK1lJRWtE?=
 =?utf-8?B?aUdqMU9rc0JZdWJGcXlXZ21qT3NDRnBkbTJxRkwreHlJZXdyNk9oQi93a0VZ?=
 =?utf-8?B?ejVCaE9YTUxGc3ozVzlaOHZMdnpQOWFXbXRDOUtSa294LzM5bi9jcHlXVEV4?=
 =?utf-8?B?Y01MeXFTZUdickVpbXQ5bUxlTnpMNlkwVG9VSVNwam44Q0EvR2k0RVdpc0p1?=
 =?utf-8?B?YXJsbGtWcUU0MWpJbEkzRmoxQzQ0VEV6SHc5WXNlaUZGZzc1Zm5DWWQ0RXRN?=
 =?utf-8?B?aXE5cXhPekEwUmxzMGhaUzRJVGJvQjlTeklKTmxRNDZtWjZ4RFpuMUlPMUVx?=
 =?utf-8?B?cWI4MVlnaWcwY0VuNVkwd0lMSC9wZ2QwVytRTjFlWTZQVUlsWENvQ1JmVURX?=
 =?utf-8?B?RHgyQWV5eVBYN1NBWlJPbXVFU2pOTlBEelMwZE45ZzVEWHIvbGc3KzVPclJy?=
 =?utf-8?B?Y054YVhsZ1lMTXVhN3hXaTdrZFQ3WXVJYm1PS3FKSnp4bG56MUVKYi9ldjdV?=
 =?utf-8?B?Z0o4em05WFhhbFpCcHdRczkyQWxia2xvTzA2bkdIdVY5OFhQVjRPNFprblFE?=
 =?utf-8?B?WTNzMldzQWplTDBYYUJRejNaenJ4Q0FvS2VYVFZ2VjZoTml3cTQ0bjZlQlNH?=
 =?utf-8?B?bmIranVKVUtJa3BHMFhUQ2hVeDJDVW0zQ3dJakFzLzM5cFZ1NlZCVDlMK1dU?=
 =?utf-8?B?MnJOaERQOTZOSWxQOFN5Nit5ZUdET2RmcDZGbThEYVNkYjF2ZjFUU0NkSmEx?=
 =?utf-8?B?ZWo1WmpIVUIrTEpwYlJxZGFVMFJBNk1UbjYrejNaNEI4ekE2cXIzQUxSaDNU?=
 =?utf-8?B?b0NJNS8wY0p5bmhjZE5aaURJZ1Y1aHJ1NlJrYkRTbm0vdlNTV0dBdUtua3JF?=
 =?utf-8?B?VEhxbXZYemNxWVJRK0RzRkN3YkFQTHJ1ZkpCOXphMFVyRUFtdi91NngvTmtV?=
 =?utf-8?B?VEdHMGtleVk5dUF6eWg4QmdGQmFyNFd5dURNcXpaWHNjanpEaWJzK1BqZlhq?=
 =?utf-8?B?TzFOV3hkMi9ZQUNSek1zSjNvcG1ZVjlCODh2alJ2ekZLYW5Ta2xsd3QvVnRH?=
 =?utf-8?B?MU5NSVVaQVIxSzJNdHBYTGVZai9PTStSdGQ2ek54aVlHRHU5QXRmKzFBVXoz?=
 =?utf-8?B?VnRiR0RCVkJwbDRSaVp2VWZ0UVcvU0hobDF4TXpEZjliNFJvR2JIME5XTmdm?=
 =?utf-8?B?RytmTWNFbmppNlJPOE5CcG5FOEZFeWNMNUFsd0dabUEvRFYzL2pMcFVXMUFp?=
 =?utf-8?B?ajVJNS9UV3ZCaXZLb3BZTWRFdnEzcllsU0F4QlkwRzdXcFdsSzdoemVxREVG?=
 =?utf-8?B?RmI5YUwwcUk2dkRqRXRvZmYwQkRZYUtNdGl1cUNZUDJOOTZBcDBNQkdCZG9T?=
 =?utf-8?B?dnByR2Vyb0haYjZuOTBJN2dCT29Ta2l2dUlnc0hON1FjTmhaZkV5RjdvazlW?=
 =?utf-8?B?V3NEMUFDekxoYzRBMFlzYkFnbWl6MmJRUDEza0VxOS9zc0JmaEkycHFzaW1z?=
 =?utf-8?B?Tko5RG9SbG5LdXNrYld4UG5YVHJnQ3ZlZ1dEbjc2TStsRkVhK3JGOXY5YnNs?=
 =?utf-8?B?WkU4RWRwVWpjeWt4T0k1bFpxaGVuNUJXMGdZTlVXRzRjSDQyTVNmeVdRMmRL?=
 =?utf-8?B?V2lETXMvTVdFR040ZnlFSURBVWMxTUZvOXgzSVFDUEN1VHo3NWRWUkZZYTFa?=
 =?utf-8?B?TE1IdGp3VUNtcG05NEUwa1A2M2NsTi9Wb05OVHVkY01EL054dUZXN0FBbkhT?=
 =?utf-8?B?Z2h6YzVNcnY3aXZvSEk1ZFpiWEpreFNOMmt1d0VHV0ZkbU1WbE9QdTZaNHJB?=
 =?utf-8?Q?R/QxUFoKRCVL7zLqDOtAxBn2KDBQeLGniuGKUbEnQiW7M?=
X-MS-Exchange-AntiSpam-MessageData-1: caJGjBzB/Nb11w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9ca589-e96f-4b7a-6b95-08df1c9dc248
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:40.5986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjerovkiVRbQ4pmsrRPslYm3ouksxunDlU9cftjBAggxhHISn9hNl19oeRU4P1+ADuk7DGgGulB5yatUeFGzNw==
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

Move the types and code related to sending a RPC command into the `rpc`
sub-module. The methods are still declared as members of `CmdqInner` and
`Cmdq`; only they are now in their own sub-module.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 214 +-----------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 248 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              |   2 +-
 4 files changed, 251 insertions(+), 213 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index b6d50b0bd039..640afe2e29cb 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-mod continuation;
+pub(crate) mod rpc;
 
 use core::mem;
 
@@ -35,11 +36,6 @@
     },
 };
 
-use continuation::{
-    ContinuationRecord,
-    SplitState, //
-};
-
 use pin_init::pin_init_scope;
 
 use crate::{
@@ -50,7 +46,6 @@
             MsgFunction,
             MsgqRxHeader,
             MsgqTxHeader,
-            RpcMessageHeader,
             GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
         },
         PteArray,
@@ -67,68 +62,6 @@
 /// reply type are sent using [`Cmdq::send_command_no_wait`].
 pub(crate) struct NoReply;
 
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
 /// Trait representing messages received from the GSP.
 ///
 /// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
@@ -558,58 +491,6 @@ fn notify_gsp(bar: Bar0<'_>) {
         bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
 
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
-            match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
-                Ok(reply) => break Ok(reply),
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
     /// Receive a message from the GSP.
     ///
     /// See [`CmdqInner::receive_msg`] for details.
@@ -685,97 +566,6 @@ fn send_command_element(
         Ok(())
     }
 
-    /// Sends `command` to the GSP, without splitting it.
-    ///
-    /// # Errors
-    ///
-    /// - `EMSGSIZE` if the command exceeds the maximum queue element size.
-    /// - `ETIMEDOUT` if space does not become available within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
-    ///
-    /// Error codes returned by the command initializers are propagated as-is.
-    fn send_single_command<M>(&mut self, command: M) -> Result
-    where
-        M: CommandToGsp,
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
-        let dev = self.dev;
-        let seq = self.seq;
-        let size_in_bytes = command.size();
-
-        let init = |dst: &mut GspCommand<'_>| {
-            // Extract area for the command itself. The GSP message header and the command header
-            // together are guaranteed to fit entirely into a single page, so it's ok to only look
-            // at `dst.contents.0` here.
-            let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
-            let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
-
-            // SAFETY: `rpc_header_mut()` and `cmd` are valid references, and not touched if the
-            // initializer fails.
-            unsafe {
-                pin_init::raw_try_init(
-                    core::ptr::from_mut(dst.header.rpc_header_mut()),
-                    rpc_header_init,
-                )?;
-                pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
-            }
-
-            // Fill the variable-length payload, which may be empty.
-            let mut sbuffer =
-                SBufferIter::new_writer([&mut payload_1[..], &mut dst.contents.1[..]]);
-            command.init_variable_payload(&mut sbuffer)?;
-
-            if !sbuffer.is_empty() {
-                return Err(EIO);
-            }
-
-            dev_dbg!(
-                dev,
-                "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
-                seq,
-                M::FUNCTION,
-                size_in_bytes,
-            );
-
-            Ok(())
-        };
-
-        self.send_command_element(size_in_bytes, init)
-    }
-
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
-            SplitState::Single(command) => self.send_single_command(command),
-            SplitState::Split(command, mut continuations) => {
-                self.send_single_command(command)?;
-
-                while let Some(continuation) = continuations.next() {
-                    // Turbofish needed because the compiler cannot infer M here.
-                    self.send_single_command::<ContinuationRecord<'_>>(continuation)?;
-                }
-
-                Ok(())
-            }
-        }
-    }
-
     /// Wait for a message to become available on the message queue.
     ///
     /// This works purely at the transport layer and does not interpret or validate the message
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
new file mode 100644
index 000000000000..3bafe456efd6
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Support for the RPC message type on the GSP command queue.
+
+mod continuation;
+
+use kernel::{
+    prelude::*,
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    },
+};
+
+use continuation::{
+    ContinuationRecord,
+    SplitState, //
+};
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
+    MessageFromGsp, //
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
+impl CmdqInner<'_> {
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
+            SplitState::Single(command) => self.send_single_command(command),
+            SplitState::Split(command, mut continuations) => {
+                self.send_single_command(command)?;
+
+                while let Some(continuation) = continuations.next() {
+                    // Turbofish needed because the compiler cannot infer M here.
+                    self.send_single_command::<ContinuationRecord<'_>>(continuation)?;
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
+            match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
+                Ok(reply) => break Ok(reply),
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
+}
diff --git a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc/continuation.rs
similarity index 100%
rename from drivers/gpu/nova-core/gsp/cmdq/continuation.rs
rename to drivers/gpu/nova-core/gsp/cmdq/rpc/continuation.rs
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 59d7d7fb15e8..03bd0d881934 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -23,8 +23,8 @@
     gpu::Chipset,
     gsp::{
         cmdq::{
+            rpc::CommandToGsp,
             Cmdq,
-            CommandToGsp,
             MessageFromGsp,
             NoReply, //
         },

-- 
2.55.0

