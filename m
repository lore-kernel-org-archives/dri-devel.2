Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E3606AD87
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JYx+z8Bf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BBD10E363;
	Tue, 27 Oct 2026 07:36:56 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B0E10F2B6
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQkPVyKvdSIOuD9uq+WX1SHSbr4QzifdP5hUM9yQ6BNDJ8xETgKTxnT080dMH0pWOkLlyzywcz4hGGge8A42l7rgtlWiTWBU2gV+p1ZlNmRZAcpPjSzQHy06Q8nddraNom/sOOaZFk8+QY/7esRAr6ZwXnF5UITjPV9IvcxXwM+62dpfVAkPSVZRw5gbZDOlRskAdPbsoMiJuV4zvgg2/d3Nm8Q3VudRTUPhOTNMCwmG/a0MYNgbVGPcgHyuZ4mQ3KvN3RTE/wx/2E3gbtfbwcMk/5VkR8iWprdHLfVQUAGx0iHV6MyY9u5Re4H4OGLCKji0Tt2ruor7EBYWD66h+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdG0IXJZWSOrsOTR7rYgAaIaeM+smqaWUjxIbFeVr1s=;
 b=ifdD+SUKtPjXGe5AAZ+NeWtDR3T1Wf+2iV22AuGbM1cELq8EWmv4HyjKHjkMswzCuYN78IoGsE6E+XtUqLpXMh6XiA59XSxG6UpLJoTxdJxUlaJdvidu0UdC21y0QsWm/giBH++nFXMBIdfuyI3wszUlEDJa65/aRAsOhWnVch8CNqN2PPEhUlxYpClj7oexhEyTlRorYiq+eaCJ7FhzkdjJoGwN0NUFf/pWXU6e2FaSbI/FDL440yw6xT2NArOOeEL3iD2mtM9vP5bB7ByMfUaHnLglXwSxZFtbmRuJj8SAnAF7SFKc4ey7vcT2oQsuWWrpC7emv54Tr2GPhQUXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdG0IXJZWSOrsOTR7rYgAaIaeM+smqaWUjxIbFeVr1s=;
 b=JYx+z8BfeqXNU7+bQlS9jhbno99x81qH9cgiNjsdUY0Mb+xAap3KC4AoUFgdLksGln2iOMvo9YE6PsTy/Bhwo7aeeJDUTxCmCDI7hbj43T6uamoG8iy4NgkmkG83Cc/tLqTp5nUP9k/4dO2M9HTZl3K3OsIzyRka/zVcFYM5JozzeAAj0j2xA9lVIZOsYqLX89u8VD6dTqQwXsQV5UvgS54xFtjEz1xVE2WRFx4dG/htFd2CGcaUGzrZyUPXbgeL9L/A42Diz1KQO9pImGBM3ZLCocndmPcFX1Q5FVyjVB0gQ5aalCMgFxdrGzPp199BFn6RnpAe73/JTTmAYcszxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:30 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:29 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:56 +0900
Subject: [PATCH v6 13/15] gpu: nova-core: gsp: cmdq: move the RPC code into
 a sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-13-bed9669724ba@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 790c920f-2bb3-49c3-e0dc-08df33fd03f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|5023799004|56012099006|11063799006|261021135927099003|261022105027099003|261009223027099003|261022075727099003|261022113327099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: q8aaXNxPah6BjxDfuwhB5zqfsrB2V6bIqr+jvyKphVzZUgX6dC9oLIwXPoUjWR4MXHD6BI1ScOE51Uhm/cJAs2cmZIT+mcZsZooumHMm8AMj323ybLNo+Uyy5hIS+bdCYHgQxhhKFZ7CSIcUtK7bXS/EV2MiRfp3ZOlj+Q5UpQjSq46D9DN1kx0OE/YxG6hOLYcF9/H+c/fR/sHgEsoAT9x/G6JcsOc5HYv1rtcCbtXQ93oAZ7SgX9NW7bEz57cIn6f2x2pmyVSfmchTSNJ7r2Ml9EvPyX0K+2gpUrQRM5O1/lF6zCx2fUPw9xQPnXV2dObTxKvu21A0qNtOle7VUkYiSMhuStVHGLScPzSNzis17TEy3Qo77Yvp088NqVC5CLIt2c/f1wS0sr1i5oQDMcwK0d/qIh/0ALOftAw+0MdSB1Imj58vq1y/CtsnncmMMeJt0CAtSCCVQYzoVgUUs8pLBwPHDkm/j+xnebgg6zkdMNB0iJ1w9Vy3mCtJQwHOprn51lDHWlOtfNcCT87cl6t42dyHSzFeItNiDTICKOVgdEnGYAx+VWXyJIph5wIA3J9gRkwjnG+Kv4o0II5AZAaOL7G3a2DNP4U/eg4v2cZJL4oGz3Y76jOvT0lK7jhLcAg9yXSwG0cxPa6rmDpiOP043IRM7MjLSpg74zqevaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(5023799004)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261009223027099003)(261022075727099003)(261022113327099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1B5cmhWbEYwQkQwSGpNQ3M3TVlyQVphSUZyL1VQMVFuOXMvbUdFV2pwSVVJ?=
 =?utf-8?B?b2NRTmhxUjBxQmtOaSsvN1JhUzE2STJDaWdQRHViclNrRUsyejNqRm1mMVlY?=
 =?utf-8?B?VlNvZDlYcHFlVHNMTVNNclVXekZzRlh5TWRId0EyTVBHYnJ6UE41ekJnK3NT?=
 =?utf-8?B?QURBNTdpcW9QVmVOS3RWNitnOUZ2STVxOFQ3OEt5RjJCQjU5d0YxelRBSkI2?=
 =?utf-8?B?cUswRCtYMFpxYmQyS2UzbFZZY25kSmtRYms1YSs0ZWhTVy8ramNIVGZQeFYr?=
 =?utf-8?B?ZExBUzY5am91VHNvS3VDNkdNWEh5YVZJZUNMN0RYTW1ZdmpSUmFKU0pRS1M0?=
 =?utf-8?B?WUhrNnEzbG1Udks0L1hZR3ROcFZKMzVzTHlteHd6akFoRU1DQjlDWnFJdFRv?=
 =?utf-8?B?LzdrNWNLRGNRNnQvVzNSNC91RWJCbmMwaXd2YU8rUDVCdW1lalF6QTl4NThS?=
 =?utf-8?B?ckovTGh4UEZjVGs0aEV1MWdEaGZ1bmVvZkRyb2dqbUM3VWhsaHhkQWhJUkJS?=
 =?utf-8?B?d2JjMHRObGVSRVo5VkxMbm5CRDV3TUloYmRHQ0MxUlBuNDYrQ3NUd2lMcU1y?=
 =?utf-8?B?eWhDNlYvOUdQNE9aMTA3S2lKdnBzSW1kWFcxTUhVbUtLUnU5ZnpGeWNlakYr?=
 =?utf-8?B?SU9vU3JxSzlSR0JBRHJCU2JHL2xBWUtWcUFJdXhHUXZRS1NGMmdpeHRQei9y?=
 =?utf-8?B?MUxONHZ6QW02RE4zbHBTaXFCUWVaL0NZYnhBRjNIaW1qeTJsd1RBaW0zY3Iz?=
 =?utf-8?B?SjZId21EcUtpb09KYlFwcWJGRVdXeWlsTWF3c1FvSnR4cnRXSklIMGxxa1dW?=
 =?utf-8?B?MjhaS2lGZ2pOblA5MXoyNzFYQWFhRVpmeUVaY2RscStrNkZ0NWZGNld3UzlO?=
 =?utf-8?B?SCs2cDgyeWM3REozSkN4a0tlTVpKUGVaTUtOTEFaVmMvd0k2VUQ4TzFqKzdM?=
 =?utf-8?B?bTB3Rlg4SWJRTFM2QTAyQk1kNDlGdjdYZXAwVlNsYkV1S0lsdVBaYzk5ZEp3?=
 =?utf-8?B?a3NTLzY0cDJsZTVVWURISFFSQ1h5SHlTdTh5bGhhUzNJVXhVWXVRTE9Dcysx?=
 =?utf-8?B?bFVMSVJFaWJIWFZRZmM2SEZ1U1kvUU9jUXdhWTNyL2RKWkJKVi9XWUZhRnVJ?=
 =?utf-8?B?SzVqNkhxdEtxNm51ZVpVMnpLWm9NVklHcUtPY2thNFBtdGx6SFV1Tm5GeHlS?=
 =?utf-8?B?R1F3SnZHR2ZjZWlncjRkMVFLVmlwNVlpTnlreDNvNXJnNUptMGpXakJjKzRr?=
 =?utf-8?B?Rng2NlIrWG1vZzVPY3QwdlgvMEhUYVMzazBBMjl1UXlxYU1DWW11ck5MU3pi?=
 =?utf-8?B?L3NBbmEzdXQwdGQ0UjFsVkFMS2lDV2FwUDNnaFFyUUhhdEx1N09RNGtPcGd6?=
 =?utf-8?B?enBtSlY5SnIzL2E1WWNXbUpMTEdMR3FoWFNkY0JkcjBLOVMraGhuNjVSYXhX?=
 =?utf-8?B?UjZRTDJhQVNnWURTMUU0RHppOVA4Y2NaQWFsaC9aTnRIL0NJWktWakVhLzZZ?=
 =?utf-8?B?cjhTbTdnK1Z5eVU1ejhUSDY3YTVqMHVHVjJKbUplOHFRckNsb1k5dzR5ckRV?=
 =?utf-8?B?Y0tQb1FoK09lRDZHVmFkeVdac01hYUFFR0x6bkcxZThRd2xCSlNWM0JCd1Nw?=
 =?utf-8?B?Y2M5MHRLZyt2dEtvNitYZ05oZTNGNXU5L1VsRHJxWkVjWis3NWpieXNhdUNQ?=
 =?utf-8?B?SkhWbHFjcks2MDh6UFRKWVl0OGU4V0cvOERSMnhsajYyb2U1Z09uUnMrUW55?=
 =?utf-8?B?ZzIxUmkvdkZieHVTM3hRc0c5azQ1NkhjSElQRnhIT09DWlgvKzZ0USs1enlz?=
 =?utf-8?B?SjJKTE1rZFZyc2FiUERaOWhJQy9SQzh2MlRyZXhQeXVQbk1CazZzeERudWlt?=
 =?utf-8?B?UGFMNzdrUHJZSmpOQWZ3SjhwQ3U0TjhUaVJwYlN0M3BEbEdGMmlqRFhINlRL?=
 =?utf-8?B?MnVRMGxZay9VZmRQeUQyeGFtSTFlVlBrbkxKQ3orVVg4a01qVndPSXdxSVhO?=
 =?utf-8?B?Vkh3U0FLNE44cEx3RnRRUFRONzl4MXRVNktLeURnMW1pOUF5TVNINEFTdXVR?=
 =?utf-8?B?MDVQaFdCTlg2aURCT0crZjlhN3I4V2swQmR6NUFDNW1YdFhaNGF3YUgxYmlD?=
 =?utf-8?B?bUNXN2lGK3NtVUkwamhNbDF3V0lQeTUzaGtTMUxZSG02Q2YyajByV1BMeDQ0?=
 =?utf-8?B?Y1dTYUVvaWRObW9NVmxTZXlpU1l5K1daWVY4RkNLY1ZQWjladGJWdVRRQkZQ?=
 =?utf-8?B?Qk9IRDNqQ3NGZG5LVCt3Q0NNcHNkWjZITGpheUFvSEMzR2UxakJTc3BsaE40?=
 =?utf-8?B?MDhLUDZONE9mSUIyUUxEc2tBMHAwQU9DSXdLNUVjMy9aTkJ4MXNFTWlXUjE0?=
 =?utf-8?Q?NkOAc06wGMH16dFQcVJcJgLAx8SPM+7lFEwuNaS1Sd5TJ?=
X-MS-Exchange-AntiSpam-MessageData-1: BLYkJj7TdcfN/g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790c920f-2bb3-49c3-e0dc-08df33fd03f0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:29.8112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b+dR38IqEXW8k4oR7Uantx3O9aDyRFmFMAIVYw/EXtiOmofGyfuWQQMIGFdAOSacSe1OMKgzM7AHepKXjLyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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
as members of `CmdqInner` and `Cmdq`; they just live in their own
sub-module now.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs                  | 385 +------------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 415 +++++++++++++++++++++
 .../nova-core/gsp/cmdq/{ => rpc}/continuation.rs   |   0
 drivers/gpu/nova-core/gsp/commands.rs              |   6 +-
 drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
 5 files changed, 426 insertions(+), 384 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index cbdd05385e83..ddf3f6256222 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
-mod continuation;
+pub(super) mod rpc;
 
 use core::mem;
 
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
@@ -985,7 +656,7 @@ fn consume_element<R>(
             })?;
 
         // RPC is the only type of message supported for now.
-        let message = GspParsedMessage::Rpc(RpcMessage::parse(self.dev, message)?);
+        let message = GspParsedMessage::Rpc(rpc::RpcMessage::parse(self.dev, message)?);
 
         let res = f(message);
 
@@ -1025,52 +696,6 @@ fn await_msg_with<R>(&mut self, f: impl Fn(GspParsedMessage<'_>) -> Result<R>) -
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

