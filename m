Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA3606A327
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SJuGIK6k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B51C10F4AE;
	Tue, 20 Oct 2026 10:09:26 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB8310F49F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdkUEIQ1I6gZrioL2KoIbZHnQ+as5PY5O9KEJ0syKiUX/oLaqe9ojYKh4Z2ipA8WxvC4G2IcBOh64yoboOSWI8hBdy1jIO4Jun1fIbRmyXkUAKf+l0XhERDOZ3JUqwo04G+64AVfGrkTTBkwM2XC6ph1yeKbuolbXi/HlwepoDkioRvS4M2vqc0sUeL1fGc6Z/jLZ3XzLbD8H6Oar6bIGDWxoH2LLqcmwjyHN5LgE/ipu5H5PilZOVG9p5UDA8etJDVrNoLQF1MSeI0bpATPzsnOQqj2+63NkrxzYc405fuxttNBq5tKaXXNcFHUd0oDouxy1P4X6ZUBjk7Lrphoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylL8bb5PKKrFVqlYMoRMp4V/h7Xt1iFQVSccb595qgk=;
 b=uOLyCCSNe8OfNI8ep3T6n3Fy/96zIurIWJoOgwBiOM7aXLpxU7WZTYIzahXG5GpH36Jm+LgoNaV4KTYeuHayJnhkLiTo216K5TGhkFh8bVgJ4fa8X1QlaNbiFFbyhDPf7HAWQMWQMHIs+Oef+9ZoTfiJDjiSogtTjRoADkSg6LhdiSZLi7Hx1gI4gM9fR0mh5uH8LY3g0bfKumWe22n8FHfmeznqm/VfGypO/IprczNREUKsrrJ5F6OPEbpNAT2vHcPXLaUFHWbaQmTo+9Jr2LbTIiPggGyukzEUPI8TH0pRGstgbD18L1j2O44Lu886DaJAp/sDkiYtne5KBvkxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylL8bb5PKKrFVqlYMoRMp4V/h7Xt1iFQVSccb595qgk=;
 b=SJuGIK6kZUmuSqaHp1aC7ht0232UE1pfbYpu+VZBOkVf4l9stub9yloY3Smh3C7Ws4ZNV40hFpH2VuzAHQNag0U/T28tdCWPD9Q3X4H64mqqmrJo9brFUh8dEWNNWreYtpym0ppBU5EmnIfFTTlEEm1qYRnMe8wQdVdrCW7J6BftF1xMcMURMKhXeuNBjFSHAwCNi0KA5kMMw13Z+70I5E8L9NfcwXYmfmMxkpRZJ8K6rPAezgR/xS4N+88xkWuFlpUycrx3Z+YNztK/STMbjCLNCoqgCbQJxCcNRsJpTenfYs/hDV8z3KRLNBhoQTQHMFuAz8KUWPoxe/pPxoQJcg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:09:06 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:09:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:33 +0900
Subject: [PATCH v5 12/14] gpu: nova-core: gsp: cmdq: move the RPC code into
 a sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-12-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TY6P286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2d8d1f-3034-4191-e1f1-08df2e922cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: TvTp27vEvrEFVDRHwdb6ysw85iEnhXyvZ0HdrtmNZj0/bYYQpGdtc3ea3mjiOIRzJcwFR77ezbSedNjHmPhXH/el28s8Bgl07tfZsEFZE7L01aT/1YFBqUQYkYyuhRr8PTN0xvFoMCFAyMcVFiDmmoHow1rDpywbGx0Ylkfqf8G+Xqin6NXuWWGabN2uGsISJpd6SomoXBEuLMktGehXj9DGRXaOJTly+zfSunoCvGx89edmQ9Ap5qShhmG2S2v+FMD848E8tVv252lyHnD/HVoXsB3y8fP9nFiR9R8IkCbFERrM87nT8aawZP+aMdt74+PEgyzf8wVCly63Toz1Fj7rfvo1TDbMQhqA/GxWDykq0wH7JRO/qqbCHmStFE/V7OqcI4UtfcDmIS8P82Lu7YJGICugqtWt9fgki41meuiKkOLK5Tq4/tB0jbULzdK1Ej0dAAzhU+yw+SMGY7osIZRn4t7XcTsINrJH14C9bT/48LaLclhNcu8DBO5Ez+FboRckVgaMz9jbev7F+zkUExTRNhHgjIhQlpJ4ShKUyQJ6fe7reBUb+4D3mzol+qv2x9xkknYjSnAe3AQ37AoJSVecwCtVQXt94KkSSNMsYdlb8pzZ8U7l5X0wyEUTydVkgXKKSX70QCl3GV+4u9XpOGKtpIE8g/hTg6xs2OAlTuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRkQjIySUJOVmw0RjN6NWp3WmlzMEQ1RndIVVYweW1TUGxDM09IdWQ5cEpl?=
 =?utf-8?B?WnJxWTh6d0FtWG1tQUgrZEJCVUpvQjREVHZCZ0FzT0hBTzlKSDA1dHhnNjJx?=
 =?utf-8?B?aUhUaXpZbmk1d1IwbHVpK2xOdngzc1JFZkdid0Nya3NNYUNxYXJINUJBcFlW?=
 =?utf-8?B?dU1iNVdEeXBwcUNTaWZvd1FpQnBsYUNjajJqY1BvNEpnZ1FQRFIxOEF5bEo1?=
 =?utf-8?B?K0h4aWJTT3dVd2ovM0UvRENjSFdTOGN2Sk5NdkZRcVVVU1FVelJmaTlhbVpK?=
 =?utf-8?B?TFJLUG5HajJ0OW4wNFF2dk9sNm9FdVN2a0l6MXhqcGhhajdJTUhTSHgxdi8v?=
 =?utf-8?B?NEJSUEszYmNoNXpqZGZaWE8wNGRzWFhHT1Q5K3VYSXE5RHM1ZFFVY2xEeEc3?=
 =?utf-8?B?c3ZaNUlmL0srb1JzRHdoWEpvNGV4cXpBTmhPZnJMMEV2RjAvdFg1WWEzR3Jz?=
 =?utf-8?B?eFhGTGhaMlQ0UEYrdjRxQXRmUWZMdXZkc2hwMzl2NXhiLytnQ05DQTBkeC9a?=
 =?utf-8?B?ZlcyM0VBYnpTc25iTEJPN3lPaDJNbE4vODNLMEErYmMvTGNKb004VGNEOHpY?=
 =?utf-8?B?QzN1bStuWVBISTJodmk2dm0vTzV1VzlrZU9PVzlMaHlVY21lQTIzWUlTLzBI?=
 =?utf-8?B?V0RVZ0VxQWNKbk1iblRSdDcxQWhkRHA0a2ExclNzR1d4OVBHemV6ZzduME9U?=
 =?utf-8?B?Ujl5c245bGFDcTV1UlQ5LzRWZDkxLzZyblJreTFoZnFwRkpadFJ0c3VVeC9y?=
 =?utf-8?B?dE1MN1lwd1YrQ3NRbzhXUDdwNFByVVF1U2RUSDJXbzB1cEN0QnZSeWpVaVlY?=
 =?utf-8?B?UFNjUDR0YTdnbktxN2pUd0hEN2Fib2l4Rko0NzJJQTlNeW9hVUNzVENISUx4?=
 =?utf-8?B?V3dhL3VVV0VVbVI0UkdWNUtYd0hFNUU5M1dDT0ZXOURWWFk0TWkvVEJoRWg0?=
 =?utf-8?B?WHM3dGdGOFZiOVIzYlhMZDk3SU91Yk00N2hqenM0MloyR0tPU0ROM0UzZmpS?=
 =?utf-8?B?NTdDR05Ccm1UdTJBK21HYXc2WjgyZ3NhYWt3UG1wWlY2amF6bnFiQnVaZlBs?=
 =?utf-8?B?d1J0WnR0cmVGS1c3VzNDNFM0RVQ5ZmQ4OFB1clJjcHh3eTZBS1hWU0xUcUZ4?=
 =?utf-8?B?Z0Nsc0htSFNkTXJyZUNYNDh1WVdJRFFiUllzSklyUkNIbUg4SVJWMXRsSHdm?=
 =?utf-8?B?MzhneHdUcUdRcHlYaHk1dmpWREFQb09FUHRwU0tmS3NlSXdFTVozb2RFNUwy?=
 =?utf-8?B?R1RUa1dlNi9XbWJSa2ZpeUdDM2g4eEdzZkZiWjJuUDFvNWJmdzlCTmVNRFIw?=
 =?utf-8?B?TDhDT2ZwVVA5aDlrTzZZcUU1VXVUUmV6eThpR2t3MDFHVUs1YWQyY0VGbWMr?=
 =?utf-8?B?OGVnZ1IzbTBiUXZWcllySEQ1eGtrdmh0TFpYa0xxd0w5clhWRktqRjV3cFhX?=
 =?utf-8?B?OStqcDhPcnphVnlHK1pjcjRGbXJTdVB1L2lnbVFxZERWb2RrRGdoRFg3SHQ1?=
 =?utf-8?B?YlVTQjlFcjN4TFJTaTZhMlovVWl3MlJYM3BSRzhnOW9nbVFiMUIvRTNoTHA1?=
 =?utf-8?B?VlhOZ0R1VHV3VU5jdE5rcGVndUdnUndqRVRGSXdSRDl4T3VRcVN4UWNXekVj?=
 =?utf-8?B?aVRSS3o5ZmNzRzhyS0RiWU9lc3lxNGJONGpqRFBsR3ZFVlBtSmlZdTdaUkNi?=
 =?utf-8?B?QWt3YXVITFdoTTJHR201WU9rdzRSV20rKzNKc2F2WnFaVi8vYmppdnRBTnBK?=
 =?utf-8?B?TGt2eG5VV1NscStlZnBYcERVTDY0aGpUcG9UZUIxNEs1WlJISjZrZHIrdkIz?=
 =?utf-8?B?WktFeklQMEpwb3FFSXR3amcrRE1ZRlpocVRvV0hCM20yTzI5NURGUEpSOGdE?=
 =?utf-8?B?eDA0SWZWY09QRU5LbHBFV3dNTmZOUFBlUjc3VThHbGd2OGlJZ2o5YWoySHVM?=
 =?utf-8?B?M3paSjcyYjliMzI1UlBmTW1BMXVzZlIzS3Z4L3J4ZFJqTWFMdUhINmYzMDYv?=
 =?utf-8?B?SEZ6by9mR1IyaWF5ZDBvNDBEVjVuTHB1c21YbjF5dTZ0VWxlaExpNTQ5SjlW?=
 =?utf-8?B?OTRTWEhOVkhHYmdLWmsrVVFNeVgvZnNNRTlKRkRDSWk2UytvS0hsd2NLNDhP?=
 =?utf-8?B?RStBOUxSWVUveW5GUkdtUVY4cmw5RVQ1RWpKREpSd0d4V1h5bmp4bVF1Qjhq?=
 =?utf-8?B?Z1Rkc1FCakFERUdISzBTNnJsSXVET0J3R29nZ055elpZWFd1RWJDSVA5NDZ6?=
 =?utf-8?B?Qm1RaDBhRzc5MnJrYTJoZzRuTndGb0QrN1BQT0MyRjFsR2NQbFZISE1DMHB3?=
 =?utf-8?B?UzNmQ1Fuc3Y5N3VYWTRZU1NFcUsrbi9tNWI5SU5tRnZRUkoxV0xJK3lsUWFX?=
 =?utf-8?Q?awk5VVnJ3quaru+jcuefbqncyDIrCgSTjThQcoS5S0oOH?=
X-MS-Exchange-AntiSpam-MessageData-1: 7GMEgook7R4eyA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2d8d1f-3034-4191-e1f1-08df2e922cbc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:09:06.2743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0pZPMadKWtgXi91HI7R9hbpopcesF3sqyFngoaF/tJJwmN26sap3+e7VaYFwes5k4fZoSPjjo50NU7+JCToug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

Move the types and code related to sending and receiving RPC commands
and messages into the `rpc` sub-module. The methods are still declared
as members of `CmdqInner` and `Cmdq`; only they are now in their own
sub-module.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 387 +------------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 415 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              |   6 +-
 drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
 5 files changed, 427 insertions(+), 385 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 54e87fd7158c..c5a2f08cda94 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-mod continuation;
+pub(super) mod rpc;
 
 use core::mem;
 
@@ -28,8 +29,8 @@
         },
         Mutex, //
     },
+    time::Delta,
     time::{
-        Delta,
         Instant,
         Monotonic, //
     },
@@ -39,8 +40,6 @@
     },
 };
 
-use continuation::SplitState;
-
 use pin_init::pin_init_scope;
 
 use crate::{
@@ -48,10 +47,8 @@
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
@@ -81,149 +78,6 @@ trait CommandElement {
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
 /// Number of GSP pages making the [`Msgq`].
 pub(crate) const MSGQ_NUM_PAGES: u32 = 0x3f;
 
@@ -559,96 +413,10 @@ struct GspMessage<'a> {
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
 /// A message whose protocol layer has been parsed and validated.
 enum GspParsedMessage<'a> {
-    /// A [RPC message](RpcMessage).
-    Rpc(RpcMessage<'a>),
+    /// A [RPC message](rpc::RpcMessage).
+    Rpc(rpc::RpcMessage<'a>),
 }
 
 impl GspParsedMessage<'_> {
@@ -731,73 +499,6 @@ fn notify_gsp(bar: Bar0<'_>) {
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
@@ -871,36 +572,6 @@ fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result {
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
     /// Wait for a message to become available on the message queue.
     ///
     /// This works purely at the transport layer and does not interpret or validate the message
@@ -970,7 +641,7 @@ fn consume_element<R>(
             })?;
 
         // RPC is the only type of message supported for now.
-        let message = GspParsedMessage::Rpc(RpcMessage::parse(self.dev, message)?);
+        let message = GspParsedMessage::Rpc(rpc::RpcMessage::parse(self.dev, message)?);
 
         let res = f(message);
 
@@ -1010,52 +681,6 @@ fn await_msg_with<R>(&mut self, f: impl Fn(GspParsedMessage<'_>) -> Result<R>) -
         }
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
-    /// - `EIO` if a message fails framing or checksum validation.
-    ///
-    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
-    where
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
-        let f = |message: GspParsedMessage<'_>| {
-            let GspParsedMessage::Rpc(rpc_message) = message;
-            let function = rpc_message.header.function();
-            if matches!(function, Ok(f) if f == M::FUNCTION) {
-                let (cmd, contents_1) =
-                    M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
-                let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
-
-                M::read(cmd, &mut sbuffer)
-                    .map_err(|e| e.into())
-                    .inspect(|_| {
-                        if !sbuffer.is_empty() {
-                            dev_warn!(
-                                self.dev,
-                                "GSP message {:?} has unprocessed data\n",
-                                M::FUNCTION
-                            );
-                        }
-                    })
-            } else {
-                rpc_message.log(self.dev);
-
-                Err(ENOMSG)
-            }
-        };
-
-        self.await_msg_with(f)
-    }
-
     /// Logs and consumes every message the queue holds.
     ///
     /// # Errors
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
new file mode 100644
index 000000000000..13baf4398632
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -0,0 +1,415 @@
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
+    GspParsedMessage, //
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
+    /// - `EIO` if a message fails framing or checksum validation.
+    ///
+    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
+    fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
+    where
+        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
+        Error: From<M::InitError>,
+    {
+        let f = |message: GspParsedMessage<'_>| {
+            let GspParsedMessage::Rpc(rpc_message) = message;
+            let function = rpc_message.header.function();
+            if matches!(function, Ok(f) if f == M::FUNCTION) {
+                let (cmd, contents_1) =
+                    M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
+                let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
+
+                M::read(cmd, &mut sbuffer)
+                    .map_err(|e| e.into())
+                    .inspect(|_| {
+                        if !sbuffer.is_empty() {
+                            dev_warn!(
+                                self.dev,
+                                "GSP message {:?} has unprocessed data\n",
+                                M::FUNCTION
+                            );
+                        }
+                    })
+            } else {
+                rpc_message.log(self.dev);
+
+                Err(ENOMSG)
+            }
+        };
+
+        self.await_msg_with(f)
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

