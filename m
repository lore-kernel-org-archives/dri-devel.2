Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A786C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D603710E57E;
	Sun, 27 Sep 2026 11:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ff4wm5Vq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DE410E567
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7s8TtmyAwTt4uXATYLRGhUnlHSTPfJjCVtJHb9FnJj9SIzG6Y841jj2voeXvWNLxoQxkOdzmKvg4CW+E19wkeEz5RiAbrvP4fVh2PiA4Dz2Eks+tlN/R9qQ20/LTguzvasIUv2igBKy+ylfct2QzP9jnIOoNQ1ai5B8M/5WgOExRRbqEMFgeOiCPG04ePvxpoMM4Jy8YcD4cSRgI1wj3NXLJJ1sMPWU/WfRmZrXfm0fwrrTlAj7Ui+CD7vEAFfeaMhB/6w2ova/atZP7DxmyWiblI4RuIS+OSvSsp/SqcCC+Pny3lqqOOZa/9F2HB5Dz3IRYkPx+xd2iefdkIeUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5xiNzIqdwdssv5Ad1FHEwVp/CX6iLgS9N55MFvLe2o=;
 b=C+WOX75AhCmdOnzld97mprsclfhWuIES3Ep62JXHlCQit9iKZpHApFJoXiZqTftzP3YGtPFkjWIp3jsaSHZP1E+4WqIG+jVYkPMg3BTgtUkD5tP0w/tr5914WrZCLuHvyaUQ4GsUqT7MVuGOPn0mLI+lUw04HKpLCHZjSCnGBGJH2vLGjfydgfYIrH9G6i1sVemg7LCqFS4zwkZVd2JH4WjW47n8kF4udmtdD1c3YJVfI8l2eRqNqQ3p+cuvcQ2jKadRRu63PJ5IU5zD6DItW6ZFG705HcBkC9GdXWd+/h+cEwHquaYiafzEHux4Btf9Dw9/dSlqEAEGTcn7YMNX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5xiNzIqdwdssv5Ad1FHEwVp/CX6iLgS9N55MFvLe2o=;
 b=Ff4wm5VqtZ2ayf6GQRLmUUkiX0E6U0x2KEo2S8s8VVbj/2j9qbGNhE1W82GNmgFJEcXpAJXWy1KjFvdcWUbJXPXeEUs+1oMI1oPa00Qka5B0/h9BAxDt7+vDidrBX9SPzP9QoryGCiP/63oxNaZLnge/5Put+WxDZy1cERztBTuVR+P+/2wrWOKGEeD8DP5lZQKrkyP7nGRDSr12mMrJjDe51FjAP4CuXfUXh6j9u2n+kRCShKoCDbOX7gzS+VeUZZJhL7bqaFo5TPjP92A1nYmcEZyCpiIr3br+0JMDzzcf1Q/Y5oZECo7ErgX5d8JPVWDNJLjwFtZW1Wu3AB2WQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:47 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:46 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:28 +0900
Subject: [PATCH 06/10] gpu: nova-core: gsp: cmdq: move the RPC send code
 into a sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-6-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0077.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f67f2e-5610-4d06-b9b6-08df1c8889c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: uFrRXrJSKvZ2NF5ZKZFb2zI3kEzmEAZm8MU3n1aJ3qzCqUInkPEJfK9gmMKb+d8YolaEJUlNmM4UCRzDRmBO0GOxtZ3wQLBjs3utNhfpVmwutuS1hXo8mKA4Hhb5jgCV01jJLCaAGamowp12BsPXhCYgR+vlflLntqK0ap95l72oM+Lm3ZO1Qe1xIRg0hofzGPwwGGptDcS34G0mCvOFTKbEypUJxKSijkjy96IR8qELq7Zp7/CgtGJ6DLy/EJwTeHGR/GB1yCUOQTvB95EhtQrhf0a2WdGWvNtr+wAsAX/BWNYV+MAfojVQa+pZej8p60/C8DtB8N0x4QgO9DhzyF6V9MbXjg/vPphqfV+EkK6wgmjgP1/OZorIlWtEiz+aJUh/q03Br09hmJeM37yHjSYtlj4cFZMaZNIc6mGz1fRiklf/Yc4nHqBDMavZFF0m4NnCzjE3rrxRIyI3K0sR7thut9jkkXhTRC0wEuP/YynbIFWdho+PQmcU3pnv9dEY9I5u5kF1UALf2CizXYQT8o76LckVmEbfySkhCszwN050xmBwGWgvRBz6PDiEDXkEOll+TIAzppZy8Gf1t+A0PxIOi9HrW8VPqR+ei2immeaTNWxbnF3fgU/5xDJ5hou0khhXt7oHYtri8u0YdQDB13qTR1zh0Vts2VE1pgLgyFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3pENjZ3Mk5lSE85NWgxdmFGM3h4VjBISXZYVi8xMml1cHZhcVBWK050OVhs?=
 =?utf-8?B?djZrbldKei82eFV1cFlqdC93VmlwR0VoMFlLakNaYTN2SnJuV2FLUlJTbXJF?=
 =?utf-8?B?T1BUYWhCT1Q4OUhjQXBpTjkwUElCRllIcnpKSkJsTTBEMjlUYXRyZ0hTdWxp?=
 =?utf-8?B?L3VmVzU4NEJVU1pFRGFPQnZ4aTBOSEhSdmlCSU1mVklpa2hSN0NtQXpocEti?=
 =?utf-8?B?eXdUNnJxOE5xKzA2ZStKVVZ0MXQxTVFPZmxySkd3Z0NRMmNWdW5JemQ3MWsr?=
 =?utf-8?B?K21CVWwySlM1cUJpS3czbzhVWDUwalZvSlErVHpGeGZDZWFwc1hpUjhFK1dh?=
 =?utf-8?B?NFgxREZXMEJhQUl6TlMvSTRGTFF3N3ljK0NZSmRVNGpJUnRGazRqRDBhTktU?=
 =?utf-8?B?SGc4bVI3NURWcTVsV2Iyai92eXhhZXVWZkswUktYVGc0ejhEbkIzenhtL3hN?=
 =?utf-8?B?OWlSUUVHVHhaU2JsRlNoaStsc2w0NlNSbCtmeCtVZ0NUSFpGS2h1cHZtanVR?=
 =?utf-8?B?V3N6V3M5M3Zxb1BWeTNSVkhxUVNybUcwU20xazVWYnVqdC9xMWZHVE02emdT?=
 =?utf-8?B?QTM0bDRQcEFOSVNEVCswSUxaaTJialJyK0o5dHlQN3pSQkJiZFVvU1loMFh6?=
 =?utf-8?B?MlR3SzJpbjVUeHU0VUs2KzM4R010aURiYTFHK0tqdVBwZ2toTERueG5lV1Rj?=
 =?utf-8?B?ZmV6ajkvdzYrT3VjS0o0ZzFranAwdFI2ZXU3djNqbFM0cHE5Y2ZZUnBZdUdt?=
 =?utf-8?B?M05jZWNPQ1d2QUgwMzhKWDN6TEZRUG8wVndwdnlzUTB3WTJ3LzRJSnBKeDgz?=
 =?utf-8?B?NEVXMjB2R2dZa056KzVZTU92UTI4V1BrUENUNVNlNGd3aWZUbWZxQ1JHSEZo?=
 =?utf-8?B?MW5KVGVjTzVlVU1lVldBUjJkYW51eDQ5VjVsMDdYYUFSN0t5REtxd2RKMVpF?=
 =?utf-8?B?S3h5NzEvam1xMU5TVElOdWtFN0pjbS9JZmE4dE9hN2E2UzdpVVBFditXSFBn?=
 =?utf-8?B?eHoxcVpsaVl5aG9jZE9HTFovakVtWFJ0UHZUNSt0TG5SRjEzbmpBY29FNHU0?=
 =?utf-8?B?eC9PYTI2U0dGTlpRRVZsTDlzK0FIRndLTDZXT3lINnNZTW5hNEM0bjBkVytB?=
 =?utf-8?B?ZkxyRFZsSUZLWGVyTjBNanR3d2dtTGdCamx2VXdZWGpyejgzUkhyVGg2M3Mz?=
 =?utf-8?B?NUJqY2ZLQ3JrMTNZQ2hkYWlUbjM5L3lGTTN3RjQrSEhXL1dzVG4vYnVKQlVV?=
 =?utf-8?B?WE1rSjgrOC9WZVJqWURvVHJibmtIS2hQMURBRW5IcjQveE5KV256NElNNWxN?=
 =?utf-8?B?TE5XWForVDlPMWFmU2Y1WWxKREg1Y0FITmhrUmJ5eWc3NUFWeXBCcmpVU1ZL?=
 =?utf-8?B?eUk2YUVRZkQ0SUw4SDE2c3BpbUNvdTgrVk1YV0FxU1VIdzlwWU1naCtGa1FF?=
 =?utf-8?B?c1crMjZLakhTSXNlcmNGb0hVSHVqdFNJUmhqeG5iUUNCQ3RLdVQ0bjZuTyt2?=
 =?utf-8?B?c09wOFV0N2NUNEgzM2JIUlpCbXRyd0NLRzByYTQzdm1Ldk5LOHgyS3lGcnVo?=
 =?utf-8?B?cjVjWFNkc2xsNnk5MXd5Yzljellza1BTbnRFVXcvbHhjUlkvazQvcGtxK05D?=
 =?utf-8?B?aUkvRjJBUXdrS1NmNWhTalpGNmN3dmpZNS9MdmppWE83SmJKRGRmd2xqb3FM?=
 =?utf-8?B?V05FQ25WYnBDWGE2U0syRDNDVFUzTG1TRThZSHg2YklyMTkwMWhYS0V3VTdS?=
 =?utf-8?B?UFh0QU1HOEZCY3JKZVlNWFN6RGlpbHdXRTMzYnE0ZmEwN3AzNUNSdE8vcHgw?=
 =?utf-8?B?d1ZIanptT05vQUp2QkV4cllXWTdHRmhtS2JRUWFNRkEwbG5INktuemtscEg4?=
 =?utf-8?B?b2Y5NjY4UG5JTVBjNWFOZzZYZCt4RzhpbDM0eTBYbEhsNzd0enhtRkkwWUt6?=
 =?utf-8?B?bERWRUdhOHB2dkVYRzg1TTF5a2VTOTQzbUk0N29kSTVnWitBcDdVblVGTWlu?=
 =?utf-8?B?c25uaSt1ekdZcEUvRERtSE5YYmhsTXlrUnRnRkZ1dDJvK0IvZGxQUGVLT1Bm?=
 =?utf-8?B?eDhWNWI1cnJIOUJRS3BPV2dpY3J1NjVWeXh2OEFQNjF1S0ZieGEzL0UydmxO?=
 =?utf-8?B?bk12Smt0UVVpTi9pWVpqWUFFNll5K1VRR0dVRUhKTEdYU0hKNGJNZ2RpdUZa?=
 =?utf-8?B?Y3dFWS9qeGZXR3Y1RUZHK21yM0dCSGlYcmhkQnRNM0pXSnA2S2M3YWdKZnNn?=
 =?utf-8?B?SXRjTURlSW9ReHlSSXZIMElsVzhHMkxqUEFLa0dqTStkQ2YwQlhkN0hXaXpy?=
 =?utf-8?B?N3hCU2o3MWZkNVZJRGlucE9lWHErajMvR3ZSdzV2VDk1K2w4RmVwdSt5SUIw?=
 =?utf-8?Q?0U/lyKAUtON0vEQjJ2wd6hKL/+64aAEuvQyeKjyVfCZMT?=
X-MS-Exchange-AntiSpam-MessageData-1: +1BM23dBSvgeJQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f67f2e-5610-4d06-b9b6-08df1c8889c3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:46.4112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD1Dvs3XmeEwIQ6xEbgB8YyAZ2QjjnRr02Rjh8Me1C1T4ojRQOXpGL+W72EU7jj3XKeJPmfnqYTKIR0TxpzNkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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
index 602824236f64..2d22ae45e990 100644
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
index e087c9e8c35c..4322a4d554f9 100644
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

