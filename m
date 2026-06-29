Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D19EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 02:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D8510E6A6;
	Mon, 29 Jun 2026 02:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EP+I8yA9";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90C910E6A6
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO0aqj30tG+KscLyfI/yebi+S15576M3ggGOcAIwApIQd0Sg+ozNTzzbGdtGl3MKNh9Fy3p3pksMwFk69HTGoTbAlKAwlrso0QnGviiRJ3674RFVKbPOP8vvA4yFMThpBfn4Te91zW74w086IObD8mAcnYhPK1FdXPn2+rN8h+hW9zjNn1yuUXH+CD8u/7rWkIcHRAtT3h/X7ZSR9HM+8RIN6IpU8oRFoWpFmwrbhSfRD5e/wJmACZGr9XOQnShO36r1kimz5hmI7yZeT19bZ/EI1HGAeZRsSO8Ae8V3Nh9KF8ozfFqnCRD2ju1W2k4b+4QlK47YMFERWITlRgAOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkE7WvUF9zNkfsddxxmpguRfez/pfdpzvYlIgcbJtfU=;
 b=awxZb4hywOf4KMEqD8T6w8uJLNpyKhzLaoKe3FiLx2lXZqVbqptNbd25clG5gWhBnjPSGcaib/oXCsvT82Cy/QvkAdtEdaoaukw3PhZkiyDeIf7E+NrOkd6UYKtLtsK356CQaToWkO0WnL5FbPlBEFOkGrAYc+7QomlfYeRXQKyi3esghZgRSzXSgFaJD9fVheZzvaN6z8RxNebVbFQpaoEu9MxscHu7jTJKIM9NsRlUjMGAqWCOWOfqA3ahfpOCFGOISXIgHfggk046E81EWrw6LzIBIMuDb+QAyFKgSZ4E5VbhcQe8jlraGH6lSIoJqdszPOpHhw0DyWibjEgQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkE7WvUF9zNkfsddxxmpguRfez/pfdpzvYlIgcbJtfU=;
 b=EP+I8yA9+RBfjBbKnKozcKG/hkHv0d9U8833Oe2wB/63XcenA1cHAXgwaQWdaC5iocyhcpl6+CAHzavOdiIoQKh/n49Bc9c/gL1NN2BSIbOOv+0nDQgZg9mSioKlvAmr4htdT1bf61Tqaetjq+RL7MPnKNzPFXC0uKyQ9W2sBOLzffXq34SjRtPeEHHgLD6NXXVXAqeVKnBsZai2G31oXS5PAASQrZJ8GV9I0kjlQkNn0dU0hVGkVJBb5neZgrzS7JabMvBh4RNI9RRL+6TPJTD5j03Oc9NKbOq6Obt4O46J454CS9t2GCRnowyInsuc+RWEHXGvk91dPANgshaWkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 02:52:34 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 02:52:34 +0000
From: Alistair Popple <apopple@nvidia.com>
To: acourbot@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 "David Airlie" <airlied@gmail.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 "Tamir Duberstein" <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 Pedro Yudi Honda <niyudi.honda@usp.br>,
 SeungJong Ha <engineer.jjhama@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.de
Subject: [PATCH 1/1] nova-core: Update firmware bindings to use zerocopy traits
Date: Mon, 29 Jun 2026 12:52:19 +1000
Message-ID: <20260629025220.1935622-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629025220.1935622-1-apopple@nvidia.com>
References: <20260629025220.1935622-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0013.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 108a86fa-57fb-4bfb-2092-08ded5897896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|5023799004|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: Lk01vK9s/AyKl0IsIBCB8c7TmLTttuOk06Q2nc39rxe+WTIFBvVtEiPIsFVCe8XiTo5hDk+BYOUCCnEEdYS4upisUyPbXWTiHDftqW8jeKSO+yOY7yKLh59aabyfMEyB4fF69/l+89EL/ZlGON5b48TjyjemnXX4B4E1Hh4uODNU6JBALyARAAbxbcOk1IJJBJ+apU+qWqdFnMJa42bnor9idzuh6F8s/o5LM9Rfj7kGyDzK5xmHIbMFtjUxXm/ydgG1/4TDTZNZAoRWahnxQY6fy09zlzclZZu6EymfCd8XY9zrhxwes/oENqz9Bv4YZNrlZYf8pnOp4GqaKo1f80vRs3QUwon679bKwCsHYGyaAsqwiWboMRTtPL2N3PoS0ISqheXwTVSgwjJ3w+rMSV0ZLn7YWz/z8MlQDbKTGUQpTj3BQqTB3NIqWuZkG01RHple+Vc0rd35hfyOcAYV5+eRca4dZvzY+V0DZ6RxDZLCJjcDly5NU6qe3hZp7pV04znVzZDBTMyAPaaYMG/jPgeDrVBCRvndWUizFYFOVSEcqSRpshzORk8bZb8JBD2AE0sc851lLk5WKAHRCn7Odjem9aslFJr8L6/7a371vqga6OU8wpb6yrXqj80FKeEV8wI6JuYHxNQkr18SLhIkYyMhW+6b+vRaOC7ZQTZKhzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kz3UOh6GU7vC3dHpYE3NWHn5POmKpC61BauKp7Xt1Hxg5ScJm8d5ATySF34z?=
 =?us-ascii?Q?fCS27i3VkPsV+AuD/4LFMieUCsBUy1nAgU8sULEL7bVeVqMcqv1oxODEvnsm?=
 =?us-ascii?Q?U7LLHeMH9oFe9hdWeJF5sVWoTEZ3/jAeQZiSTeiT8/v6ARgTge3gs5mopVKF?=
 =?us-ascii?Q?cNCNZya7MfvWLyueHTObVBW0oCbT/OVv3Q5ylFi/QUSqA8Z6QWqPAe6/XcCc?=
 =?us-ascii?Q?e6Asw4XNQY+kJVoSrsF7BSTkAkYoBHM4wXIY1uXbrsF9NSi6RCrKV7fiWq2h?=
 =?us-ascii?Q?OJHVsr84pFhdMrSLmyyiq5Klt4dXFewGz1ZD8O0O7T6BHeUyliXTQHIKf6Nm?=
 =?us-ascii?Q?B8IcxB1z9eazMuC0vW3/HtqkJF9Ht0+VkeUCRQifR18dNkeFn0x5lDaC66lb?=
 =?us-ascii?Q?VFb/xJ/bbKqO6RayrrZTG4zN7cS2XEFIa/jr9K5ckqTZiqdPy41wr2i28BV8?=
 =?us-ascii?Q?SU9rXppSSBi22craK08X9jS0sh/aBaAKqbD7vuQT16kt0hvVoeO/RjbRezMJ?=
 =?us-ascii?Q?Qn8M5rJpZ3qmLpkb9sifz/mPZTzKV4RwgwBdo36cJbkMCRBUSNJwGzXXfuWt?=
 =?us-ascii?Q?vvcCn4GklQpumGVuRfQw5xSht2Dz/P8TFimvthBFGBLOMdmTh7oUCfqxJCJX?=
 =?us-ascii?Q?+uE/mmaRpeKiywojDScAp9KG42DI2UKAzjJkZ+uZlymnvc/MzrRJAOZN3den?=
 =?us-ascii?Q?/dpOi2rogVG2IZmr5OrSp5ZT7Kpzc2UNb68O88/aJkvfaAtMl7ogJtPC/RJN?=
 =?us-ascii?Q?L1cxxs3Bjp6vY0O7OSO5M3/5QXb9Qv/bOQjkeq8uv2ECMEQwFmVugVtn9h43?=
 =?us-ascii?Q?fJ9rjVbH8HWd+9aFrwYFEqInmYgnxiKM7gLXp4/X539l8/RiP9jBtl6SXHcG?=
 =?us-ascii?Q?egcEGW5CN+hFVNtbpP6VUkLvWKafXH9F4SKZODq4u92RvtI6riOOVXpxKIXC?=
 =?us-ascii?Q?/Cj2xTGWnA/vNZUnj66TfV17SpJCA6L0BgKRCjU0HnGSA9Mo1V+zSGclniWO?=
 =?us-ascii?Q?NQD1t7YRk4iEISg/EZu+3dDd7tu7Mz6VBVcSVIOOrjyfaFgUHXvQblmknFAJ?=
 =?us-ascii?Q?IDrMABfinfnlp31JEeCW41/Qu9oAZUFQ/1HXFDMfAW+ZXw1ZMOnOE1G1DBGD?=
 =?us-ascii?Q?zyLY0qqQwhfP478iwOyQdqjX9bYpSavw0vOdVxSrsyAxvfr2x6u1g1R3ee79?=
 =?us-ascii?Q?aLEBb3SkoR96spkBbnrlJB3+wOsnUVerlKsaGo8+QVYBx3iWUzYw4VCA0cne?=
 =?us-ascii?Q?8q/K12rCxaTlt2BPfjlJtN0GFGpuODxDf6nksKXB16PF5Q8xJKpJxX1GAWgf?=
 =?us-ascii?Q?85QKPmSTJEHncZzdIAnHyDk4A/wDeQaYQRRkgvHFLIpnNWjj7ycgsB2e2WmL?=
 =?us-ascii?Q?GufzPC15MB9m5iEKqUpOlrRK2X8+0cPKQ4/xBg1TioEg0DJg6bcI2tfyZWDt?=
 =?us-ascii?Q?awxzWHfHH5eTQb1su0mlbaBnkzz3qv6XlSdamM31UAkfNq3qwzG+3CGiyod6?=
 =?us-ascii?Q?4wcyG0+RxurUNRlvbgCyapZPW4/5ty3EFYXn3Mn27FCBZLoCbDXkfEnYu0qz?=
 =?us-ascii?Q?NpJZQEOaKbjT2/R2xUQTDw0L2dkkseknjL/rq3Hkl0SD3aLoQv25LluHZhiK?=
 =?us-ascii?Q?QwmgplqQMtr2AHvL8U0Sgy2TTQhxT4p4XEhP7r/XcvNGu6aOXv+XWNeHZHY6?=
 =?us-ascii?Q?nHC6qXyNrselSUMxlEKpw9usinvJbD8XxbmWrf+OXMaC2rSNVNBYw+zbPfhi?=
 =?us-ascii?Q?oK105vbcsw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108a86fa-57fb-4bfb-2092-08ded5897896
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 02:52:34.7457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnvP7XocHtT9AfK7HI/2C9GwAIUVtboZuC4WL7wnpUevhdm4q6Yuw90pZj7WQ8rUKyOTEkKESpLc2LDba01LUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

Currently most of nova-core uses unsafe implementations of AsBytes and
FromBytes in order to read and write GSP commands using the generated
bindings. Whilst this is generally safe in practice there is nothing
that actually guarantees or checks this.

This is exactly what the zerocopy library was introduced to do - provide
compile-time checks ensuring From/AsBytes is safe. Make use of these
checks by converting all our generated bindings to derive the required
traits for the zerocopy checks, removing many unsafe implementations in
the process.

Note this does require the use of an unstable feature - trivial_bounds
- as some bindings end up needing to derive zerocopy::Unaligned.
A work-around is also required in the bindings to make some of the
__IncompleteArrayField<T> ZSTs monomorphic as the check macro can not
prove a generic type is aligned and thus forces T to derive
zerocopy::Unaligned, which is not satisfied by all types.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 drivers/gpu/nova-core/Makefile                |   4 +
 drivers/gpu/nova-core/gsp/cmdq.rs             |  21 +-
 .../gpu/nova-core/gsp/cmdq/continuation.rs    |  16 +-
 drivers/gpu/nova-core/gsp/commands.rs         |  19 +-
 drivers/gpu/nova-core/gsp/fw.rs               |  54 +----
 drivers/gpu/nova-core/gsp/fw/commands.rs      |  50 ++---
 drivers/gpu/nova-core/gsp/fw/r570_144.rs      |  41 ++++
 .../gpu/nova-core/gsp/fw/r570_144/bindings.rs | 185 ++++++++++++------
 drivers/gpu/nova-core/gsp/sequencer.rs        |   5 +-
 scripts/Makefile.build                        |   4 +-
 10 files changed, 223 insertions(+), 176 deletions(-)

diff --git a/drivers/gpu/nova-core/Makefile b/drivers/gpu/nova-core/Makefile
index 4ae544f808f4..27a5752c4cf9 100644
--- a/drivers/gpu/nova-core/Makefile
+++ b/drivers/gpu/nova-core/Makefile
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# The GSP firmware bindings derive zerocopy's `IntoBytes` on `#[repr(C)]`
+# unions, which is gated behind the `zerocopy_derive_union_into_bytes` cfg.
+rustflags-y += --cfg zerocopy_derive_union_into_bytes
+
 obj-$(CONFIG_NOVA_CORE) += nova-core.o
 nova-core-y := nova_core.o
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 0671ee8a9960..6e79ec688983 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -29,6 +29,14 @@
     },
 };
 
+// TODO: Remove `as` once FromBytes is removed completely
+use zerocopy::{
+    FromBytes as ZCFromBytes,
+    Immutable,
+    IntoBytes,
+    KnownLayout, //
+};
+
 use continuation::{
     ContinuationRecord,
     SplitState, //
@@ -76,7 +84,7 @@ pub(crate) trait CommandToGsp {
     const FUNCTION: MsgFunction;
 
     /// Type generated by [`CommandToGsp::init`], to be written into the command queue buffer.
-    type Command: FromBytes + AsBytes;
+    type Command: ZCFromBytes + KnownLayout + Immutable + IntoBytes;
 
     /// Type of the reply expected from the GSP, or [`NoReply`] for commands that don't
     /// have a reply.
@@ -133,7 +141,7 @@ pub(crate) trait MessageFromGsp: Sized {
     type InitError;
 
     /// Type containing the raw message to be read from the message queue.
-    type Message: FromBytes;
+    type Message: ZCFromBytes + KnownLayout + Immutable;
 
     /// Method reading the message from the message queue and returning it.
     ///
@@ -383,7 +391,7 @@ fn allocate_command(&mut self, size: usize, timeout: Delta) -> Result<GspCommand
         };
 
         // Extract area for the `GspMsgElement`.
-        let (header, slice_1) = GspMsgElement::from_bytes_mut_prefix(slice_1).ok_or(EIO)?;
+        let (header, slice_1) = GspMsgElement::mut_from_prefix(slice_1).map_err(|_| EIO)?;
 
         // Create the contents area.
         let (slice_1, slice_2) = if slice_1.len() > size {
@@ -639,7 +647,7 @@ fn send_single_command<M>(&mut self, bar: Bar0<'_>, command: M) -> Result
         // Extract area for the command itself. The GSP message header and the command header
         // together are guaranteed to fit entirely into a single page, so it's ok to only look
         // at `dst.contents.0` here.
-        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
+        let (cmd, payload_1) = M::Command::mut_from_prefix(dst.contents.0).map_err(|_| EIO)?;
 
         // Fill the header and command in-place.
         let msg_element = GspMsgElement::init(self.seq, size_in_bytes, M::FUNCTION);
@@ -744,7 +752,7 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         .map(|(slice_1, slice_2)| (slice_1.as_flattened(), slice_2.as_flattened()))?;
 
         // Extract the `GspMsgElement`.
-        let (header, slice_1) = GspMsgElement::from_bytes_prefix(slice_1).ok_or(EIO)?;
+        let (header, slice_1) = GspMsgElement::ref_from_prefix(slice_1).map_err(|_| EIO)?;
 
         dev_dbg!(
             &self.dev,
@@ -822,7 +830,8 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         // Extract the message. Store the result as we want to advance the read pointer even in
         // case of failure.
         let result = if function == M::FUNCTION {
-            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
+            let (cmd, contents_1) =
+                M::Message::ref_from_prefix(message.contents.0).map_err(|_| EIO)?;
             let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
 
             M::read(cmd, &mut sbuffer)
diff --git a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs b/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
index 05e904f18097..f0c69f0760a4 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/continuation.rs
@@ -171,22 +171,18 @@ fn init_variable_payload(
 mod tests {
     use super::*;
 
-    use kernel::transmute::{
-        AsBytes,
-        FromBytes, //
+    use zerocopy_derive::{
+        FromBytes,
+        Immutable,
+        IntoBytes,
+        KnownLayout, //
     };
 
     /// Non-zero-sized command header for testing.
     #[repr(C)]
-    #[derive(Clone, Copy, Zeroable)]
+    #[derive(Clone, Copy, FromBytes, Immutable, IntoBytes, KnownLayout, Zeroable)]
     struct TestHeader([u8; 64]);
 
-    // SAFETY: `TestHeader` is a plain array of bytes for which all bit patterns are valid.
-    unsafe impl FromBytes for TestHeader {}
-
-    // SAFETY: `TestHeader` is a plain array of bytes for which all bit patterns are valid.
-    unsafe impl AsBytes for TestHeader {}
-
     struct TestPayload {
         data: KVVec<u8>,
     }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 86a3747cd31c..f3c5806f9d19 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -12,11 +12,7 @@
 use kernel::{
     device,
     pci,
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
+    prelude::*, //
 };
 
 use crate::{
@@ -130,13 +126,12 @@ fn init_variable_payload(
         let mut string_data = KVec::new();
 
         for entry in self.entries.iter().take(Self::NUM_ENTRIES) {
-            dst.write_all(
-                fw::commands::PackedRegistryEntry::new(
+            dst.write_all(zerocopy::IntoBytes::as_bytes(
+                &fw::commands::PackedRegistryEntry::new(
                     (string_data_start_offset + string_data.len()) as u32,
                     entry.value,
-                )
-                .as_bytes(),
-            )?;
+                ),
+            ))?;
 
             let key_bytes = entry.key.as_bytes();
             string_data.extend_from_slice(key_bytes, GFP_KERNEL)?;
@@ -150,10 +145,6 @@ fn init_variable_payload(
 /// Message type for GSP initialization done notification.
 struct GspInitDone;
 
-// SAFETY: `GspInitDone` is a zero-sized type with no bytes, therefore it
-// trivially has no uninitialized bytes.
-unsafe impl FromBytes for GspInitDone {}
-
 impl MessageFromGsp for GspInitDone {
     const FUNCTION: MsgFunction = MsgFunction::GspInitDone;
     type InitError = Infallible;
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..be2b4b046b19 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -27,6 +27,8 @@
     },
 };
 
+use zerocopy_derive::{Immutable, KnownLayout};
+
 use crate::{
     fb::FbLayout,
     firmware::gsp::GspFirmware,
@@ -434,12 +436,6 @@ pub(crate) fn val(&self) -> u32 {
     }
 }
 
-// SAFETY: This struct only contains integer types for which all bit patterns are valid.
-unsafe impl FromBytes for RegWritePayload {}
-
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for RegWritePayload {}
-
 /// Wrapper for GSP sequencer register modify payload.
 #[repr(transparent)]
 #[derive(Copy, Clone, Debug)]
@@ -462,12 +458,6 @@ pub(crate) fn val(&self) -> u32 {
     }
 }
 
-// SAFETY: This struct only contains integer types for which all bit patterns are valid.
-unsafe impl FromBytes for RegModifyPayload {}
-
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for RegModifyPayload {}
-
 /// Wrapper for GSP sequencer register poll payload.
 #[repr(transparent)]
 #[derive(Copy, Clone, Debug)]
@@ -495,12 +485,6 @@ pub(crate) fn timeout(&self) -> u32 {
     }
 }
 
-// SAFETY: This struct only contains integer types for which all bit patterns are valid.
-unsafe impl FromBytes for RegPollPayload {}
-
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for RegPollPayload {}
-
 /// Wrapper for GSP sequencer delay payload.
 #[repr(transparent)]
 #[derive(Copy, Clone, Debug)]
@@ -513,12 +497,6 @@ pub(crate) fn val(&self) -> u32 {
     }
 }
 
-// SAFETY: This struct only contains integer types for which all bit patterns are valid.
-unsafe impl FromBytes for DelayUsPayload {}
-
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for DelayUsPayload {}
-
 /// Wrapper for GSP sequencer register store payload.
 #[repr(transparent)]
 #[derive(Copy, Clone, Debug)]
@@ -537,13 +515,8 @@ pub(crate) fn index(&self) -> u32 {
     }
 }
 
-// SAFETY: This struct only contains integer types for which all bit patterns are valid.
-unsafe impl FromBytes for RegStorePayload {}
-
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for RegStorePayload {}
-
 /// Wrapper for GSP sequencer buffer command.
+#[derive(FromBytes, Immutable, KnownLayout)]
 #[repr(transparent)]
 pub(crate) struct SequencerBufferCmd(bindings::GSP_SEQUENCER_BUFFER_CMD);
 
@@ -609,13 +582,8 @@ pub(crate) fn reg_store_payload(&self) -> Result<RegStorePayload> {
     }
 }
 
-// SAFETY: This struct only contains integer types for which all bit patterns are valid.
-unsafe impl FromBytes for SequencerBufferCmd {}
-
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for SequencerBufferCmd {}
-
 /// Wrapper for GSP run CPU sequencer RPC.
+#[derive(FromBytes, Immutable, KnownLayout)]
 #[repr(transparent)]
 pub(crate) struct RunCpuSequencer(bindings::rpc_run_cpu_sequencer_v17_00);
 
@@ -626,12 +594,6 @@ pub(crate) fn cmd_index(&self) -> u32 {
     }
 }
 
-// SAFETY: This struct only contains integer types for which all bit patterns are valid.
-unsafe impl FromBytes for RunCpuSequencer {}
-
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for RunCpuSequencer {}
-
 /// Struct containing the arguments required to pass a memory buffer to the GSP
 /// for use during initialisation.
 ///
@@ -780,6 +742,7 @@ fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
 /// GSP Message Element.
 ///
 /// This is essentially a message header expected to be followed by the message data.
+#[derive(FromBytes, Immutable, IntoBytes, KnownLayout)]
 #[repr(transparent)]
 pub(crate) struct GspMsgElement {
     inner: bindings::GSP_MSG_QUEUE_ELEMENT,
@@ -859,13 +822,6 @@ pub(crate) fn element_count(&self) -> u32 {
     }
 }
 
-// SAFETY: Padding is explicit and does not contain uninitialized data.
-unsafe impl AsBytes for GspMsgElement {}
-
-// SAFETY: This struct only contains integer types for which all bit patterns
-// are valid.
-unsafe impl FromBytes for GspMsgElement {}
-
 /// Arguments for GSP startup.
 #[repr(transparent)]
 #[derive(Zeroable)]
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index ebdc12bcd4e3..18bb7ee2141a 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -6,11 +6,7 @@
 use kernel::{
     device,
     pci,
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    }, //
+    prelude::*, //
 };
 
 use crate::{
@@ -19,10 +15,16 @@
     num::IntoSafeCast, //
 };
 
+use zerocopy_derive::{
+    Immutable,
+    KnownLayout, //
+};
+
 use super::bindings;
 
 /// Payload of the `GspSetSystemInfo` command.
 #[repr(transparent)]
+#[derive(FromBytes, Immutable, IntoBytes, KnownLayout)]
 pub(crate) struct GspSetSystemInfo {
     inner: bindings::GspSystemInfo,
 }
@@ -64,15 +66,8 @@ pub(crate) fn init<'a>(
     }
 }
 
-// SAFETY: These structs don't meet the no-padding requirements of AsBytes but
-//         that is not a problem because they are not used outside the kernel.
-unsafe impl AsBytes for GspSetSystemInfo {}
-
-// SAFETY: These structs don't meet the no-padding requirements of FromBytes but
-//         that is not a problem because they are not used outside the kernel.
-unsafe impl FromBytes for GspSetSystemInfo {}
-
 #[repr(transparent)]
+#[derive(FromBytes, Immutable, IntoBytes, KnownLayout)]
 pub(crate) struct PackedRegistryEntry(bindings::PACKED_REGISTRY_ENTRY);
 
 impl PackedRegistryEntry {
@@ -92,11 +87,9 @@ pub(crate) fn new(offset: u32, value: u32) -> Self {
     }
 }
 
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for PackedRegistryEntry {}
-
 /// Payload of the `SetRegistry` command.
 #[repr(transparent)]
+#[derive(FromBytes, Immutable, IntoBytes, KnownLayout)]
 pub(crate) struct PackedRegistryTable {
     inner: bindings::PACKED_REGISTRY_TABLE,
 }
@@ -115,16 +108,9 @@ pub(crate) fn init(num_entries: u32, size: u32) -> impl Init<Self> {
     }
 }
 
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for PackedRegistryTable {}
-
-// SAFETY: This struct only contains integer types for which all bit patterns
-// are valid.
-unsafe impl FromBytes for PackedRegistryTable {}
-
 /// Payload of the `GetGspStaticInfo` command and message.
 #[repr(transparent)]
-#[derive(Zeroable)]
+#[derive(FromBytes, Immutable, IntoBytes, KnownLayout, Zeroable)]
 pub(crate) struct GspStaticConfigInfo(bindings::GspStaticConfigInfo_t);
 
 impl GspStaticConfigInfo {
@@ -169,13 +155,6 @@ pub(crate) fn usable_fb_regions(&self) -> impl Iterator<Item = Range<u64>> + '_
     }
 }
 
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for GspStaticConfigInfo {}
-
-// SAFETY: This struct only contains integer types for which all bit patterns
-// are valid.
-unsafe impl FromBytes for GspStaticConfigInfo {}
-
 /// Power level requested to the [`UnloadingGuestDriver`] command.
 #[derive(Clone, Copy, Debug, PartialEq, Eq)]
 #[repr(u32)]
@@ -199,7 +178,7 @@ pub(crate) fn is_power_transition(self) -> bool {
 
 /// Payload of the `UnloadingGuestDriver` command and message.
 #[repr(transparent)]
-#[derive(Clone, Copy, Debug, Zeroable)]
+#[derive(Clone, Copy, Debug, FromBytes, Immutable, IntoBytes, KnownLayout, Zeroable)]
 pub(crate) struct UnloadingGuestDriver(bindings::rpc_unloading_guest_driver_v1F_07);
 
 impl UnloadingGuestDriver {
@@ -212,10 +191,3 @@ pub(crate) fn new(level: PowerStateLevel) -> Self {
         })
     }
 }
-
-// SAFETY: Padding is explicit and will not contain uninitialized data.
-unsafe impl AsBytes for UnloadingGuestDriver {}
-
-// SAFETY: This struct only contains integer types for which all bit patterns
-// are valid.
-unsafe impl FromBytes for UnloadingGuestDriver {}
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144.rs b/drivers/gpu/nova-core/gsp/fw/r570_144.rs
index 2e6f0d298756..75f5e4a19596 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144.rs
@@ -23,9 +23,50 @@
 )]
 use kernel::ffi;
 use pin_init::MaybeZeroable;
+use zerocopy_derive::{
+    FromBytes,
+    Immutable,
+    IntoBytes,
+    KnownLayout, //
+};
 
 include!("r570_144/bindings.rs");
 
 // SAFETY: This type has a size of zero, so its inclusion into another type should not affect their
 // ability to implement `Zeroable`.
 unsafe impl<T> kernel::prelude::Zeroable for __IncompleteArrayField<T> {}
+
+/// Monomorphic version of [`__IncompleteArrayField<PACKED_REGISTRY_ENTRY>`].
+///
+/// zerocopy's `IntoBytes` derive can only run its compile-time no-padding check
+/// on a concrete type; for the generic `__IncompleteArrayField<T>` it falls back
+/// to requiring every field be `Unaligned`, which `PACKED_REGISTRY_ENTRY`
+/// does not satisfy. Specializing to a concrete type lets the derive succeed.
+#[repr(C)]
+#[derive(Debug, Default, FromBytes, Immutable, IntoBytes, KnownLayout, MaybeZeroable)]
+pub struct __IncompletePackedRegistryEntry(
+    ::core::marker::PhantomData<PACKED_REGISTRY_ENTRY>,
+    [PACKED_REGISTRY_ENTRY; 0],
+);
+impl __IncompletePackedRegistryEntry {
+    #[inline]
+    pub const fn new() -> Self {
+        __IncompletePackedRegistryEntry(::core::marker::PhantomData, [])
+    }
+    #[inline]
+    pub fn as_ptr(&self) -> *const PACKED_REGISTRY_ENTRY {
+        self as *const _ as *const PACKED_REGISTRY_ENTRY
+    }
+    #[inline]
+    pub fn as_mut_ptr(&mut self) -> *mut PACKED_REGISTRY_ENTRY {
+        self as *mut _ as *mut PACKED_REGISTRY_ENTRY
+    }
+    #[inline]
+    pub unsafe fn as_slice(&self, len: usize) -> &[PACKED_REGISTRY_ENTRY] {
+        ::core::slice::from_raw_parts(self.as_ptr(), len)
+    }
+    #[inline]
+    pub unsafe fn as_mut_slice(&mut self, len: usize) -> &mut [PACKED_REGISTRY_ENTRY] {
+        ::core::slice::from_raw_parts_mut(self.as_mut_ptr(), len)
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index ea350f9b2cc4..9c85c93f6eee 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #[repr(C)]
-#[derive(Default)]
+#[derive(Default, FromBytes, IntoBytes, Immutable, KnownLayout)]
 pub struct __IncompleteArrayField<T>(::core::marker::PhantomData<T>, [T; 0]);
 impl<T> __IncompleteArrayField<T> {
     #[inline]
@@ -325,7 +325,9 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
 pub const NV_VGPU_MSG_EVENT_NUM_EVENTS: _bindgen_ty_3 = 4131;
 pub type _bindgen_ty_3 = ffi::c_uint;
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct NV0080_CTRL_GPU_GET_SRIOV_CAPS_PARAMS {
     pub totalVFs: u32_,
     pub firstVfOffset: u32_,
@@ -349,7 +351,9 @@ pub struct NV0080_CTRL_GPU_GET_SRIOV_CAPS_PARAMS {
     pub __bindgen_padding_1: [u8; 7usize],
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct NV2080_CTRL_BIOS_GET_SKU_INFO_PARAMS {
     pub BoardID: u32_,
     pub chipSKU: [ffi::c_char; 9usize],
@@ -365,7 +369,9 @@ pub struct NV2080_CTRL_BIOS_GET_SKU_INFO_PARAMS {
 }
 pub type NV2080_CTRL_CMD_FB_GET_FB_REGION_SURFACE_MEM_TYPE_FLAG = [u8_; 17usize];
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO {
     pub base: u64_,
     pub limit: u64_,
@@ -377,14 +383,16 @@ pub struct NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO {
     pub blackList: NV2080_CTRL_CMD_FB_GET_FB_REGION_SURFACE_MEM_TYPE_FLAG,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct NV2080_CTRL_CMD_FB_GET_FB_REGION_INFO_PARAMS {
     pub numFBRegions: u32_,
     pub __bindgen_padding_0: [u8; 4usize],
     pub fbRegion: [NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO; 16usize],
 }
 #[repr(C)]
-#[derive(Debug, Copy, Clone, MaybeZeroable)]
+#[derive(Debug, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct NV2080_CTRL_GPU_GET_GID_INFO_PARAMS {
     pub index: u32_,
     pub flags: u32_,
@@ -401,14 +409,18 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct DOD_METHOD_DATA {
     pub status: u32_,
     pub acpiIdListLen: u32_,
     pub acpiIdList: [u32_; 16usize],
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct JT_METHOD_DATA {
     pub status: u32_,
     pub jtCaps: u32_,
@@ -417,14 +429,18 @@ pub struct JT_METHOD_DATA {
     pub __bindgen_padding_0: u8,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct MUX_METHOD_DATA_ELEMENT {
     pub acpiId: u32_,
     pub mode: u32_,
     pub status: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct MUX_METHOD_DATA {
     pub tableLen: u32_,
     pub acpiIdMuxModeTable: [MUX_METHOD_DATA_ELEMENT; 16usize],
@@ -432,13 +448,17 @@ pub struct MUX_METHOD_DATA {
     pub acpiIdMuxStateTable: [MUX_METHOD_DATA_ELEMENT; 16usize],
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct CAPS_METHOD_DATA {
     pub status: u32_,
     pub optimusCaps: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct ACPI_METHOD_DATA {
     pub bValid: u8_,
     pub __bindgen_padding_0: [u8; 3usize],
@@ -447,21 +467,28 @@ pub struct ACPI_METHOD_DATA {
     pub muxMethodData: MUX_METHOD_DATA,
     pub capsMethodData: CAPS_METHOD_DATA,
 }
+pub type GspStaticConfigInfo = GspStaticConfigInfo_t;
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct VIRTUAL_DISPLAY_GET_MAX_RESOLUTION_PARAMS {
     pub headIndex: u32_,
     pub maxHResolution: u32_,
     pub maxVResolution: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct VIRTUAL_DISPLAY_GET_NUM_HEADS_PARAMS {
     pub numHeads: u32_,
     pub maxNumHeads: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct BUSINFO {
     pub deviceID: u16_,
     pub vendorID: u16_,
@@ -471,7 +498,9 @@ pub struct BUSINFO {
     pub __bindgen_padding_0: u8,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_VF_INFO {
     pub totalVFs: u32_,
     pub firstVFOffset: u32_,
@@ -484,25 +513,31 @@ pub struct GSP_VF_INFO {
     pub __bindgen_padding_0: [u8; 5usize],
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_PCIE_CONFIG_REG {
     pub linkCap: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct EcidManufacturingInfo {
     pub ecidLow: u32_,
     pub ecidHigh: u32_,
     pub ecidExtended: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct FW_WPR_LAYOUT_OFFSET {
     pub nonWprHeapOffset: u64_,
     pub frtsOffset: u64_,
 }
 #[repr(C)]
-#[derive(Debug, Copy, Clone, MaybeZeroable)]
+#[derive(Debug, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct GspStaticConfigInfo_t {
     pub grCapsBits: [u8_; 23usize],
     pub __bindgen_padding_0: u8,
@@ -575,7 +610,9 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GspSystemInfo {
     pub gpuPhysAddr: u64_,
     pub gpuPhysFbAddr: u64_,
@@ -632,7 +669,9 @@ pub struct GspSystemInfo {
     pub hostPageSize: u64_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct MESSAGE_QUEUE_INIT_ARGUMENTS {
     pub sharedMemPhysAddr: u64_,
     pub pageTableEntryCount: u32_,
@@ -641,7 +680,9 @@ pub struct MESSAGE_QUEUE_INIT_ARGUMENTS {
     pub statQueueOffset: u64_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_SR_INIT_ARGUMENTS {
     pub oldLevel: u32_,
     pub flags: u32_,
@@ -649,7 +690,9 @@ pub struct GSP_SR_INIT_ARGUMENTS {
     pub __bindgen_padding_0: [u8; 3usize],
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_ARGUMENTS_CACHED {
     pub messageQueueInitArguments: MESSAGE_QUEUE_INIT_ARGUMENTS,
     pub srInitArguments: GSP_SR_INIT_ARGUMENTS,
@@ -659,13 +702,15 @@ pub struct GSP_ARGUMENTS_CACHED {
     pub profilerArgs: GSP_ARGUMENTS_CACHED__bindgen_ty_1,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_ARGUMENTS_CACHED__bindgen_ty_1 {
     pub pa: u64_,
     pub size: u64_,
 }
 #[repr(C)]
-#[derive(Copy, Clone, MaybeZeroable)]
+#[derive(Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub union rpc_message_rpc_union_field_v03_00 {
     pub spare: u32_,
     pub cpuRmGfid: u32_,
@@ -681,7 +726,7 @@ fn default() -> Self {
 }
 pub type rpc_message_rpc_union_field_v = rpc_message_rpc_union_field_v03_00;
 #[repr(C)]
-#[derive(MaybeZeroable)]
+#[derive(MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct rpc_message_header_v03_00 {
     pub header_version: u32_,
     pub signature: u32_,
@@ -704,7 +749,7 @@ fn default() -> Self {
 }
 pub type rpc_message_header_v = rpc_message_header_v03_00;
 #[repr(C)]
-#[derive(Copy, Clone, MaybeZeroable)]
+#[derive(Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct GspFwWprMeta {
     pub magic: u64_,
     pub revision: u64_,
@@ -739,19 +784,23 @@ pub struct GspFwWprMeta {
     pub verified: u64_,
 }
 #[repr(C)]
-#[derive(Copy, Clone, MaybeZeroable)]
+#[derive(Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub union GspFwWprMeta__bindgen_ty_1 {
     pub __bindgen_anon_1: GspFwWprMeta__bindgen_ty_1__bindgen_ty_1,
     pub __bindgen_anon_2: GspFwWprMeta__bindgen_ty_1__bindgen_ty_2,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GspFwWprMeta__bindgen_ty_1__bindgen_ty_1 {
     pub sysmemAddrOfSignature: u64_,
     pub sizeOfSignature: u64_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GspFwWprMeta__bindgen_ty_1__bindgen_ty_2 {
     pub gspFwHeapFreeListWprOffset: u32_,
     pub unused0: u32_,
@@ -767,13 +816,15 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
-#[derive(Copy, Clone, MaybeZeroable)]
+#[derive(Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub union GspFwWprMeta__bindgen_ty_2 {
     pub __bindgen_anon_1: GspFwWprMeta__bindgen_ty_2__bindgen_ty_1,
     pub __bindgen_anon_2: GspFwWprMeta__bindgen_ty_2__bindgen_ty_2,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GspFwWprMeta__bindgen_ty_2__bindgen_ty_1 {
     pub partitionRpcAddr: u64_,
     pub partitionRpcRequestOffset: u16_,
@@ -785,7 +836,9 @@ pub struct GspFwWprMeta__bindgen_ty_2__bindgen_ty_1 {
     pub lsUcodeVersion: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GspFwWprMeta__bindgen_ty_2__bindgen_ty_2 {
     pub partitionRpcPadding: [u32_; 4usize],
     pub sysmemAddrOfCrashReportQueue: u64_,
@@ -820,7 +873,9 @@ fn default() -> Self {
 pub const LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_FB: LibosMemoryRegionLoc = 2;
 pub type LibosMemoryRegionLoc = ffi::c_uint;
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct LibosMemoryRegionInitArgument {
     pub id8: LibosAddress,
     pub pa: LibosAddress,
@@ -830,7 +885,9 @@ pub struct LibosMemoryRegionInitArgument {
     pub __bindgen_padding_0: [u8; 6usize],
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct PACKED_REGISTRY_ENTRY {
     pub nameOffset: u32_,
     pub type_: u8_,
@@ -839,14 +896,16 @@ pub struct PACKED_REGISTRY_ENTRY {
     pub length: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, MaybeZeroable)]
+#[derive(Debug, Default, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct PACKED_REGISTRY_TABLE {
     pub size: u32_,
     pub numEntries: u32_,
-    pub entries: __IncompleteArrayField<PACKED_REGISTRY_ENTRY>,
+    pub entries: __IncompletePackedRegistryEntry,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct msgqTxHeader {
     pub version: u32_,
     pub size: u32_,
@@ -858,13 +917,15 @@ pub struct msgqTxHeader {
     pub entryOff: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct msgqRxHeader {
     pub readPtr: u32_,
 }
 #[repr(C)]
 #[repr(align(8))]
-#[derive(MaybeZeroable)]
+#[derive(MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct GSP_MSG_QUEUE_ELEMENT {
     pub authTagBuffer: [u8_; 16usize],
     pub aadBuffer: [u8_; 16usize],
@@ -889,12 +950,14 @@ fn default() -> Self {
 pub const GSP_DMA_TARGET_GSP_DMA_TARGET_COUNT: GSP_DMA_TARGET = 3;
 pub type GSP_DMA_TARGET = ffi::c_uint;
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_FMC_INIT_PARAMS {
     pub regkeys: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Copy, Clone, MaybeZeroable)]
+#[derive(Debug, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct GSP_ACR_BOOT_GSP_RM_PARAMS {
     pub target: GSP_DMA_TARGET,
     pub gspRmDescSize: u32_,
@@ -914,7 +977,7 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
-#[derive(Debug, Copy, Clone, MaybeZeroable)]
+#[derive(Debug, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct GSP_RM_PARAMS {
     pub target: GSP_DMA_TARGET,
     pub __bindgen_padding_0: [u8; 4usize],
@@ -930,7 +993,7 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
-#[derive(Debug, Copy, Clone, MaybeZeroable)]
+#[derive(Debug, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct GSP_SPDM_PARAMS {
     pub target: GSP_DMA_TARGET,
     pub __bindgen_padding_0: [u8; 4usize],
@@ -948,7 +1011,7 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
-#[derive(Debug, Copy, Clone, MaybeZeroable)]
+#[derive(Debug, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct GSP_FMC_BOOT_PARAMS {
     pub initParams: GSP_FMC_INIT_PARAMS,
     pub __bindgen_padding_0: [u8; 4usize],
@@ -966,7 +1029,9 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct rpc_unloading_guest_driver_v1F_07 {
     pub bInPMTransition: u8_,
     pub bGc6Entering: u8_,
@@ -974,7 +1039,7 @@ pub struct rpc_unloading_guest_driver_v1F_07 {
     pub newLevel: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, MaybeZeroable)]
+#[derive(Debug, Default, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct rpc_run_cpu_sequencer_v17_00 {
     pub bufferSizeDWord: u32_,
     pub cmdIndex: u32_,
@@ -992,20 +1057,26 @@ pub struct rpc_run_cpu_sequencer_v17_00 {
 pub const GSP_SEQ_BUF_OPCODE_GSP_SEQ_BUF_OPCODE_CORE_RESUME: GSP_SEQ_BUF_OPCODE = 8;
 pub type GSP_SEQ_BUF_OPCODE = ffi::c_uint;
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_SEQ_BUF_PAYLOAD_REG_WRITE {
     pub addr: u32_,
     pub val: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_SEQ_BUF_PAYLOAD_REG_MODIFY {
     pub addr: u32_,
     pub mask: u32_,
     pub val: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_SEQ_BUF_PAYLOAD_REG_POLL {
     pub addr: u32_,
     pub mask: u32_,
@@ -1014,24 +1085,28 @@ pub struct GSP_SEQ_BUF_PAYLOAD_REG_POLL {
     pub error: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_SEQ_BUF_PAYLOAD_DELAY_US {
     pub val: u32_,
 }
 #[repr(C)]
-#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+#[derive(
+    Debug, Default, Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes,
+)]
 pub struct GSP_SEQ_BUF_PAYLOAD_REG_STORE {
     pub addr: u32_,
     pub index: u32_,
 }
 #[repr(C)]
-#[derive(Copy, Clone, MaybeZeroable)]
+#[derive(Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub struct GSP_SEQUENCER_BUFFER_CMD {
     pub opCode: GSP_SEQ_BUF_OPCODE,
     pub payload: GSP_SEQUENCER_BUFFER_CMD__bindgen_ty_1,
 }
 #[repr(C)]
-#[derive(Copy, Clone, MaybeZeroable)]
+#[derive(Copy, Clone, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
 pub union GSP_SEQUENCER_BUFFER_CMD__bindgen_ty_1 {
     pub regWrite: GSP_SEQ_BUF_PAYLOAD_REG_WRITE,
     pub regModify: GSP_SEQ_BUF_PAYLOAD_REG_MODIFY,
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index e0850d21adca..99b05999c9b7 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -15,9 +15,10 @@
         delay::fsleep,
         Delta, //
     },
-    transmute::FromBytes, //
 };
 
+use zerocopy::FromBytes;
+
 use crate::{
     driver::Bar0,
     falcon::{
@@ -82,7 +83,7 @@ pub(crate) enum GspSeqCmd {
 impl GspSeqCmd {
     /// Creates a new `GspSeqCmd` from raw data returning the command and its size in bytes.
     pub(crate) fn new(data: &[u8], dev: &device::Device) -> Result<(Self, usize)> {
-        let fw_cmd = fw::SequencerBufferCmd::from_bytes(data).ok_or(EINVAL)?;
+        let fw_cmd = fw::SequencerBufferCmd::ref_from_bytes(data).map_err(|_| EINVAL)?;
         let opcode_size = core::mem::size_of::<u32>();
 
         let (cmd, size) = match fw_cmd.opcode()? {
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 911745743246..0d0f315e43d0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -314,10 +314,12 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 #   - Stable since Rust 1.89.0: `feature(generic_arg_infer)`.
 #   - Expected to become stable: `feature(arbitrary_self_types)`.
 #   - To be determined: `feature(used_with_arg)`.
+#   - Required by nova-core's zerocopy firmware bindings, whose derives emit
+#     trivial `where` bounds: `feature(trivial_bounds)`.
 #
 # Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 # the unstable features in use.
-rust_allowed_features := arbitrary_self_types,asm_goto,generic_arg_infer,used_with_arg
+rust_allowed_features := arbitrary_self_types,asm_goto,generic_arg_infer,used_with_arg,trivial_bounds
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.54.0

