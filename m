Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3B2CA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B6410F457;
	Wed, 30 Sep 2026 14:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="K8+YoYja";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E84910F430
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFU216zpxNs936JcUL3XJ1Ju401Q6Gngp0cBjDcf+ErejwudSfcCwHTnS4+RHP5ObROkORM5WEKINS8+Nald9xbQsBFOlrLHKq/fSvoQlyNdUMWsJVbq4FmtVYAnnkUojj6ukDiPmtL3Lwwu3zMRF/YiVYgiooaMP98uHliQjx/ks8xrgnM6+UQcjDGfd4ycPMz12L4uAAsZAP9PIDoQYvVADHrP7MpJeCmKu7XfinqKI2a+zm9K7fxAG1X6ojUAnI1UE6cmfPi2RQMiQTknu+AL44vwgtCVRo2MB0Vkb0l3PQMUpEAsvyI1A7o3ZwmQ57U8ssPz0k0QANu88DTltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUlf6ymj9zm3KR0dDgoqueXKuPajA+kXGNbmKglmIV8=;
 b=jVaXnBLjV7frRQQKyjpXMYepHSmgRtoX4Wegh+niA81srZemTBY3GQt4u1P6KSqOe+1gyrll8HUiXhJpqyNSHnQvETL9B51q2EjYq1EVDMFe1sTcGtHvUwm55Nb8B08/N+fIlrSFB4YnBQMLcqy28p8ud8s3cPlEizkzDf4mf7HVM7Tsy0jqaIGfFedLtBLpNmb9x1eONFGSq80qDKUzilFQgjY6+yqYWelcn6f9ZB2ylZQTWyihH76lQO5/FRiQC4YFaFInEw34NF0h2NhNYAyhhjwODtxby2HBoCZzULp3mT2WhtmuC0GlBwFnvG2e53X6x803ImJzvm9S2GrJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUlf6ymj9zm3KR0dDgoqueXKuPajA+kXGNbmKglmIV8=;
 b=K8+YoYjaHVXFj10pyeHa79uY1JFW3WI5PmCAK/wKDPTX8bfYuvZvBlL2z4S4x+bQrBRDxpfV8bVD529A9tVHN6evTFgdR0V/YF/HTMJe2VqM2DJp8b8EBV5zDvd9jZBKEe+SpMsHaqMevWms62AZA5SodNEBQgr9Ve36i6HvKJUPajIG6FQhkNroGcdNYEX2twVshwiNjWTqEq5pdxmhQHcJnb3dxESEpCBwzGuQZQx34wms49Y7kpkgScRNaAGGR5YGxqbXFeQqFp8Arz0h/eXo8Xz9QpViFYEIkVEAzvMruarDEkhUJSTf2ZSLax9giYisgF6jxap6DIIcXXYMSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:57:07 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:57:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:43 +0900
Subject: [PATCH v3 4/9] gpu: nova-core: gsp: cmdq: split the transport part
 of the send path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-4-91613f06520b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0351.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eac7398-7a4b-41f5-4bd6-08df1f031901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lpCrKdWVfWaTei4G1l5AkvIfOiFt7kxT8rOEoOd9hL1o/m8aD71Rr+EXMGMlNinvnl4qaa69/S6QTTX4DG2X7RZCd2mKUiJROm/0bQqy9/KLJYx3dS3P3soVBDZI43ix3mlURK5O/pUQnuTvef7Dd4bE0GynBiY/G5eg43JKRaJmvm/E5TA2OLXeVKe3nWsNFyjRycEIOjlqPFrgYebAfNt6Sh/sty/Mhm70kfYO851/37dFLgSf0KG9NKzZIpMbeuZJiyTc06KNCruX55gkn0HhUyzDYgD0FkpPVUoD7M3hKGJZOazjN/U8YrODONhkOF2R6+olNpg70/Z5PDPb/KyGcPq57mERDkDHQq8Q/OhrPZOrRcs1dMEFszZr73vYDc1L4DFcrrSXbfb8KGyXJ+f5Ax5HWgZsr6LjAahgIYW90vFzJAzEtJc0Sj94CnOqlulkRhhp19RqEnS3lrFRvFfZp335iaZiM1O85u8y0wkVIHd8O75SPonbWHmvu4Bo1Clcv147ww+NnNzTGAvj7ePgvxl7HelXFL0VT0hNjZ4HhzQDAb+gwHHMPCXm4FlO9bmprQeQKL3VjcKanJUpuuoiII05y0jDw+BE/pisO8e7InE+2wLLF/pLXfZDd5MJRKMWS4rjm95YGb/Vu8rZh5sja5HSG8JHY/FxhNKaW1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkl1cWVxcDdFckJuMm44WE11ZHlMd2lhTEVvcjNjL0gzMFpMQVpPSlJITUxo?=
 =?utf-8?B?Tmp3OXVNVEczOThIb29zcVU5QzM3Ujd6dGlHZjluUjRqMFBSUWZxbGFyaXlV?=
 =?utf-8?B?cGVtYWdxTTJJci8xa0c1ZXJYbENLOXNJT3lhdXJ6UE1SekRSMEk5dExVOG03?=
 =?utf-8?B?a3dTQm5kU3E4Y3dVZ3hTY1puejFQUmgwQmZXWXZ2cldGU0E3UXJNeWVaS3Uw?=
 =?utf-8?B?RTlrQlQxbXF5MSs1U1ZtbzJFZitWV0gzMmljdWJGY2VUR0lpUlY5aXZabTcw?=
 =?utf-8?B?L29yMUpZODRUUVVZbUc0SUFOZ3NTdTNQVE1KYzBvU1NXUkdoc0ZnbGZWWFZV?=
 =?utf-8?B?NCtNTC9neWhiSVI5Z0IwcjlTTUQvWU5PL1Z3b25RRGcvdGpyTGw0dkNuQmNQ?=
 =?utf-8?B?WjZTUEhWeTRNeTI0WFdNdlhZT3VkWHZTc01RR2VlbU9MN0g3UFV2ei9ZS1lv?=
 =?utf-8?B?OXFib1VmZmY5WXpKb2N3M3JaWEozRnhnZlJlemtCSUp5VlBDbHpWNWdTR0t4?=
 =?utf-8?B?RHNKR2hOZlRLREtneHB6Q0xIVkNYOEE2a2Jvbmo2TjJXVVdzQ21mWTdER2cz?=
 =?utf-8?B?Q1ROUXR2WjI0S3lSbGg2b1lQS1c4OXk0bjNHSjlyeHkwWUYvYkl2cVRPTlBh?=
 =?utf-8?B?cFZIeDlWaXd4Zi9tbjhiVG8wVUdSOFBOOG9VN3F2QTR3QzI2Rm5uaTJBVWdS?=
 =?utf-8?B?Q3JUdTREQU1INTUyY0poY2ZVWElQSzJqQ3JOVFhWSWpGMFpvUWFyclgxcGZO?=
 =?utf-8?B?MTBQT3B6U1krb3hKckJZTk9XbXZ4NXloTmc0bERMYmlGVDd6NGxscVRMZS9p?=
 =?utf-8?B?Q2psUVZmWmVXanRhZ3JQUE9JaER3L2ovL3VRZGUwdFRkY25LZkRDdG01YjBs?=
 =?utf-8?B?L1JNUEF4N1NER1ZXeEhsa3ViT0hzQnFtZExyL2FWSlBNNGdsdDUzTWxoNTRW?=
 =?utf-8?B?eHI3Q282MG05OUZNa1prOWxQUkx3TDcvTW50eWlYSnRTb1AzR3BFdWt4alM2?=
 =?utf-8?B?b2s4c2pnTFFncGl3TzIvOEpGNW1iTnZsYUM5d2dGZVpBQkdNVFl3Vk01NlF5?=
 =?utf-8?B?dTgzK1lzMzlCRDYvTTVYc05aMnhoOFVxdE91NkhQYi9PUW16Uy9HcmVkclNI?=
 =?utf-8?B?Ym04akt6T1VSSVJzTVcybDlBSE1iVGlYS1BkM3hvRjdQeXJ0Rmk2alVqRjB6?=
 =?utf-8?B?ZHJtNU0ralNNb0tBeVdVUDhZM3MyMy9ZajJpUXFWaC9yR3pDTmpKRWZ2ZlZ3?=
 =?utf-8?B?eFE4LzZQWEJxUDRqTy95bkVxeCtUZUMwMkRJdjZlSDIwcytudms0UVczd2N4?=
 =?utf-8?B?aThyOXAyQTNIVVQ3SitaNU9UQWlrcHF4K0JYN2JRQ0o3WG1heWE2dnQ2bnAr?=
 =?utf-8?B?VzlLclFuZjJJVFVmdVpGUnNldEg0dG0vemxDMjkrakxaQVF5MHVlMHl2Y0Rz?=
 =?utf-8?B?QmcvOW9tUkFEdnNlSkliOVNEQTg4MEozVDVobkR5eEwrR0FYUGYycGVvV0dk?=
 =?utf-8?B?VWNPYTh4MmpuVEN6OENFOU9PeDZRM2tLRXJXVHV3dHYwTzJXRTNCTksvWTAx?=
 =?utf-8?B?bHdXeCtKTXg2UWFSU3FRektmb0s0MElTdmpaZk1QeWVVV3IwUld0SE4rSEpq?=
 =?utf-8?B?VXhSaTAyaUo3VUZOOW9pWnZCOWo2Q1NscG1XTGQ4bUc4dklmS1ZvNTM4ZDdR?=
 =?utf-8?B?NkNBKzNoSjNiWXlndU56Uk1ObjVQNEt3MHNhc1lodTJBTEkxN0xMTThWbk83?=
 =?utf-8?B?NW5OU2d6S2N3Uy9pMmVDY1FWajVkNU5QOXd6YS9kZnpldEdzcXhEam5xVXZS?=
 =?utf-8?B?OWVadEpQdHcwT1E5b29NeXdVbUxOSk1zSXJsZ3dpN2RaMnRVL3F6bUluaDZO?=
 =?utf-8?B?cnJCQjBQNUFyNGNhalQxN2ZQbkp4OEF2c1lYMnF0OGowejB2SHdoQXNvQ3Bj?=
 =?utf-8?B?WGVTeUY3QzJrRlRFV0hIb1ZUbjNWYnQ5Z0hLNzNYRzRTYTdFRmJnWHRYMkg3?=
 =?utf-8?B?N0ZNd0lkeG50RG1SSDhBZWc2a1VWV0FtWHlrNisxVE9UNUtUUDkxTDl6YWlw?=
 =?utf-8?B?UzhTMHh4eFVwYndZSGxCTndPT1pCVTY2UUwyN3llU2VPdndOckVuYzBUYnln?=
 =?utf-8?B?ZitHQ2RUOHRTakJGN0srK2FrMm9jYmJWUHpCYndrUFZhNVEvY3JiQy9ZZ2ZJ?=
 =?utf-8?B?ZDhlbUpjalA4emZVOEhPNVdpUXlnWVhJaU5Ya1c0UWNJY3ZCb1JWV3pOc3c5?=
 =?utf-8?B?UG9mWEJaY0l5Nys1dmNnekYyMjByalcvSEtFUXdCZ2lheHUwL0hpR2d6eHdp?=
 =?utf-8?B?dHhZTzlIVk5LcnV0SmxCOVVYTFR0OHNUZ0wxaTQ3cTBuMUVDRVhhV3REakZh?=
 =?utf-8?Q?3AB8VnUF1HJKqNhvxIUrT4pLXzllBvHITRJq3+xDJgQZg?=
X-MS-Exchange-AntiSpam-MessageData-1: W70O7V2UKmevKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eac7398-7a4b-41f5-4bd6-08df1f031901
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:07.5762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fy7DZayjcgfbRiFcI+UuLmg6R7o4gMJJC6zPyDPK2/FtdUBVkkmm7FLHc2SSNOPe+xmoilt7QxQSq4spOwLXg==
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

Introduce the `CommandElement` trait and `RpcCommandElement` wrapper
type to define how messages (independently of their type) are sent
through the transport layer. `send_single_command` becomes
`send_command_element`, which allocates the queue slots, writes the
element header, and delegates the writing of the message itself to the
implementation of `CommandElement` before computing the checksum,
advancing the write pointer and ringing the doorbell.

The RPC part of `send_single_command` (writing the RPC header and the
command payload) is now part of the `CommandElement` implementation.
This sets things up for moving the RPC code into its own sub-module,
leaving the transport agnostic of the message type.

No functional change intended.

Suggested-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 133 +++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index bda79f23626d..d8a7716fc500 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -35,10 +35,7 @@
     },
 };
 
-use continuation::{
-    ContinuationRecord,
-    SplitState, //
-};
+use continuation::SplitState;
 
 use pin_init::pin_init_scope;
 
@@ -67,6 +64,19 @@
 /// reply type are sent using [`Cmdq::send_command_no_wait`].
 pub(crate) struct NoReply;
 
+/// Trait implemented by types that can be sent as a single command queue element.
+///
+/// The command queue allocates `size()` bytes after the `GspMsgElement` header and calls `write()`
+/// to fill them.
+trait CommandElement {
+    /// Size in bytes of the element, not including the `GspMsgElement` header.
+    fn size(&self) -> usize;
+
+    /// Writes the contents of the command into `dst`. `dev` is the queue's device (to be used for
+    /// logging), `seq` is the sequence number of the element.
+    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result;
+}
+
 /// Trait implemented by types representing a command to send to the GSP.
 ///
 /// The main purpose of this trait is to provide [`Cmdq`] with the information it needs to send
@@ -129,6 +139,62 @@ fn size(&self) -> usize {
     }
 }
 
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
 /// Trait representing messages received from the GSP.
 ///
 /// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
@@ -638,24 +704,18 @@ impl CmdqInner<'_> {
     /// Timeout for waiting for space on the command queue.
     const ALLOCATE_TIMEOUT: Delta = Delta::from_secs(1);
 
-    /// Sends `command` to the GSP, without splitting it.
+    /// Allocate enough send slots to store `command`, initialize them using
+    /// [`CommandElement::write`], and send the command to the GSP.
     ///
     /// # Errors
     ///
     /// - `EMSGSIZE` if the command exceeds the maximum queue element size.
     /// - `ETIMEDOUT` if space does not become available within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
-    /// Error codes returned by the command initializers are propagated as-is.
-    fn send_single_command<M>(&mut self, command: M) -> Result
-    where
-        M: CommandToGsp,
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
+    /// Error codes returned by [`CommandElement::write`] are returned as-is.
+    fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result {
         let size_in_bytes = command.size();
-        let dst = self
+        let mut dst = self
             .gsp_mem
             .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
 
@@ -666,40 +726,8 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
         }
 
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
-        drop(sbuffer);
-
-        dev_dbg!(
-            &self.dev,
-            "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
-            self.seq,
-            M::FUNCTION,
-            size_in_bytes,
-        );
+        // Write the message payload.
+        command.write(self.dev, self.seq, &mut dst)?;
 
         // Compute checksum now that the whole message is ready.
         dst.header
@@ -735,13 +763,12 @@ fn send_command<M>(&mut self, command: M) -> Result
         Error: From<M::InitError>,
     {
         match SplitState::new(command)? {
-            SplitState::Single(command) => self.send_single_command(command),
+            SplitState::Single(command) => self.send_command_element(RpcCommandElement(command)),
             SplitState::Split(command, mut continuations) => {
-                self.send_single_command(command)?;
+                self.send_command_element(RpcCommandElement(command))?;
 
                 while let Some(continuation) = continuations.next() {
-                    // Turbofish needed because the compiler cannot infer M here.
-                    self.send_single_command::<ContinuationRecord<'_>>(continuation)?;
+                    self.send_command_element(RpcCommandElement(continuation))?;
                 }
 
                 Ok(())

-- 
2.55.0

