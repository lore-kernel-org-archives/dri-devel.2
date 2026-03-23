Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF69EC01C9
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E3510E2F7;
	Mon, 23 Mar 2026 11:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QLkSrFIR";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013026.outbound.protection.outlook.com
 [40.107.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7578910E2F7
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:08:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azNXmfiwqacwHaEmxryS8MSyUv/n/hP8s7Bjue8LSoYeeQAAM1t1zd5QUOok+TIIKeW5yqhekbVEzU4RHC/D0XkfM5rJf87MSmF3jmHZc92Ax4DtM0v2D6wt7G0pU2aL8+mPx9KR9iw6tfQ+Xq7h+2Hk7+1TYs4SMtIzxk6UnTfM2llg0OhlFiJFFMwT+dArCVk5zrP/GWEB9UfUPae+xjf3ltWrJuOpmZl93B1wmWZBY5x/wGpVzybOYuqisdc53vmx2y0JzHPWxtpJk1xrU5hcB68faVw8QoSVP+MFIMnVeOyqC4orySXgZt+42ye8A6pb881ABw5xBWy7oLaclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NizFbIeOWh9pSXnmgRWrGIXaJkeSfaxOQX2GLShQrOA=;
 b=KvaGwjGJc0SzouTxJ8IsfmIgUwO9SVZcGiwZk5ips2on5HX1fayOFkx/8n/ZNrRZH3NHF7yrjmVvZlI8c7u+i/kOhGNyWn41ySLcbB7FC0IQSPGtRwsXiMTYxBrwE4mNxEHCTLqQZSmvov8lftZxw2zape3Q9LnnsD547AMFUwnr1IiuBjE68vKKfTXrU3WpVMJgn4ZE/A2+H12xO98+EESqDWR/3O0u/ZN+Tr7dgCB6+QH0F5Jp+n6Nl0OHvytAtJjC57TabgY74qpOK+RukLPQb3N8qI4hrL7g1V0J//xka+2yz2HseDj/iq7b1uvO2SVobQfv670TIsN955Q1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NizFbIeOWh9pSXnmgRWrGIXaJkeSfaxOQX2GLShQrOA=;
 b=QLkSrFIRw57FusPSW/nICOEo+jiTGfgvjpQAB07CR8v0HtUmtUqWtKvs2NYh2fZTIp+rvaYf0KfS2tMRAYeacpb0N8kypjLamIOii/vEceUT8GaFgXyREErAF3VDm8WqcFd1M+33T9jivMPdV1eVGjex8EXuKLrgLux+q0nsapSoSROuloZDOhtLx8afyqe+U2f/KYuUAT2gv0dRJRBfdNLeCicZXpBNfQGC8kwaJpcHo++i6vzX5JN37e+MzAT7q0+J9K3VzS64ABRYD8x4kXDJj8tjxzlDd+UQcsiqHmetoNUYLIWbvAY03QeSdOPp8dyfOG+YPwQUgjecgvtg9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:08:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:08:17 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:43 +0900
Subject: [PATCH v3 08/10] gpu: nova-core: convert falcon registers to
 kernel register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-8-ae2486ecef1b@nvidia.com>
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYXPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:403:a::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c4a7a8-9b53-4174-7b46-08de88cc7c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: XHP7mzJmYxFMP6lqegZyWNuVZYCgdlrtzZDxmVBgWB29av9hXxQ6SAWLVarCZa2+avE03/ELGzjyZNyLN2iko3ZUaiwqSO4CdIiIhpm3vBBC7pfJhRMwtpPPbXy7ko1F2dDZRRr1dzORut07A+Fy9mLUReGqM/iNIMrPQ+EOvmwKj5rJ1AIz8OpCRdJUTZ8anffcE4/NoSJPtUIYdZKHwzZInVlK5DMpfxtAzQOB/4xBeHUTnqagVwFuqk609XPs7L6BlB6ydSvjEZ37q7w6OAcrSDEe69abO/tIOUMlpaz1usdS/srQKQUZSRocaxrWNvkR2Nq/OwIvh1bLRVNEOp0SImqYGHkAxTIHRi3itT9Uq89J4d38lfFXB1FmjoTVOaFjF4tMdor0O1x4mlKp4+qZ1LD9SDgpoeD8bobjTu01iG39o+kz+KXe0VeJlHnUpjGMlC3pG161m4WmyUeSM5eX43EVhQaKSs0cjcUP+n1w8oX7eSpdpi2LdCpyihbmQs+Qwe9qeBPPLpOREY+dny9i3pdHJmJ+PVW8/Y2NdQDhOAfUOXKTEiW8o8gCqiqxIAvYSaZpm58O9uTRXADOK76od9a5zGKDEEs/bdkh32A3KdezuAfMiNOYO5Q0KJ69lJKYK3Hzp0PH4GldFcZOnI1Vencaf57/nioCCPJ3SyzNndj6sogAjkbWxZPPOsAU4Qvry90UniAAjEO45OZAYIy9oqE/hclT1IoDMoEJHN+zby1YqIu7aXtrh8rI5bE2fiQK0NibW5gMtOppi/jy+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNqY0h0aHorTk5SdGFiWFRxUm5hTXFRTm1ZcmNOMEFma2M1Ykk2eE1vdmtz?=
 =?utf-8?B?bGJHazRraWlBcFFyakNWSzRaNHlza2lRUU1ld3Z1R0I0dXVxWGJMS0prbGl4?=
 =?utf-8?B?RHFKdmRlNC9sYnhsSDJIQXpFTkgyNnlSSFZwWm5sQVY4UTk4Rjc1aUQ3WjRv?=
 =?utf-8?B?VFF0MHpGcXRlUDMzWFR2MkVkcjRqSnZyVHBJQ2RaKzVYUzVRalNmaG5CeXA0?=
 =?utf-8?B?RzN0TnZ3N0lmejQ2YkNZa25TK3pKN3UzclBJTHVZMlQvNW8wTUxnRk9PQnJr?=
 =?utf-8?B?MktHNnN1OHFsK0QyOXJXK3NaV3JQUitsbGFYVnJjZ01wMjNUT052NVpGS1NU?=
 =?utf-8?B?TjREUkRLUU1rOHptQ0g4Vm5vQm0wSy92VlpWTk5ocTNVYWdXL3lUUDlENTNs?=
 =?utf-8?B?SkpMcXRnUktma21xS0Y4QmxKQ24wT1FucHlsQ0ZNS2dHZmpYV3ZwYXNlUEho?=
 =?utf-8?B?RFhpS0NlSGhUZjNZUXh3eXpZSnFFd0wvcElUellIN2hJd09NSDd3UFc4M2hu?=
 =?utf-8?B?ay91U1lSU2puU3NJOUlQcTNOYVBsWXJ4MmYra2VaTENHWjFLZDZXQmdvRWZm?=
 =?utf-8?B?UWhaTDQ3cG91K1Y1MnlVVk5yWVJtajN2eUNReXJtSnp2d1BPZXZ6Z0xpS3Ix?=
 =?utf-8?B?d0tudTA4dHFYbVFyT2YyQWRTZ0lWVmVsdHh3dWVscCtqcDVtWmlPeFdxVGFM?=
 =?utf-8?B?Mnl3eUtMMFdUWDlVck92cEpDcDFJVktVWVRoZkJ6WlAxSFdLZ2NCK3Q0M0dl?=
 =?utf-8?B?VE9vOWMrVUx0alVleTN6MDhHTTJnVUFnZFJ3T1l6eVFsbVFPOS9DL2lKUWpX?=
 =?utf-8?B?VDRjcnA0RW5uMng1ZmZwbHNzY2t1Z2ZxL1dHcEVabmNRQmtTVlpaTmRWcFRY?=
 =?utf-8?B?MWkyME5xUDVjOXhrOUpVSHBLcmc1b3J2R0RQRHczMEJYdDljdEY5STgvLzZh?=
 =?utf-8?B?L2R5bXVuT0w3eE9qOGRrZ2dJWE0rMjZaeElNLzRCdzVpTjBaMk1VVURCSlc2?=
 =?utf-8?B?Ym42bDVmNklMLzNBYVNiWGNlWC9icGllVWlKWThuVjUvS0E5NmNuMUpjd1Er?=
 =?utf-8?B?NXI3cGozL28ycUdaT20vWjJLU084WHllTVFPblNOZWtRTk5qMGtmQUdhNUdG?=
 =?utf-8?B?MjlkaG0zQnlibW81YUFDbDVXdXFqSWZYVkJka3RVZmJUMUdaREFrc3NyS09z?=
 =?utf-8?B?bmRTVE1LL2s5R2xrd3laeGZZS0liVzRPb0dRbzlmZVgxeW9nTmcxVVpoMmc1?=
 =?utf-8?B?L2hPNTF0SUJNN1krZnVYeXErZTIwYk1lNUdFQm0rZDJiZGVONHVweEp5RlJz?=
 =?utf-8?B?QmM3MHBzZkdwRUFsd3pxSTVyTnYySkk5VTM1ZTJFMzA2UGhqK1lkTldMeEE0?=
 =?utf-8?B?dmp4eEJNWEdqZk1naTA2Nk55Q3NUQWpLMmFKa2FnY1cwbmtvL3lWY3A3NnpU?=
 =?utf-8?B?LzA4RG9odlYrNTNFN0h5ekIwM3FSOWRMZ1ZJZkhNVm5BWnZQUUVsRG1ESVVj?=
 =?utf-8?B?bXZDWEIrbit0Tk53eHYvbFUrcVpnNHg4TXVxS0g5am0zUjBoYjlyMDNXdzkx?=
 =?utf-8?B?alBYUDViQ0dPbWp4K0Y1cnlHc2Q1djIvK0dVMVJwLzVjRlRZYXg0KzJNUHVQ?=
 =?utf-8?B?NUN4Zi9hYVlVV3N5QUFqSHNtTkU3RXFWeWJsWmg0NHk0Zy9kNVBDMVAyT0FE?=
 =?utf-8?B?VlhqQncxSHY1c2VGeGN1Rm9FV3FIN05qTm5KeGlRZW41R2pZK2hPVW5SYTRZ?=
 =?utf-8?B?Q2Z1ZW9lRk9ENVpSaGtmSmtmaERybHE1YVBBZ2xEZ0R0dEZVVEt0VmdleHp0?=
 =?utf-8?B?ME5QcGYwNlJjcTA5YktXeEF1QVg0ckRaQkFYOVhVZ3ZaRE52bGc4KytuWkVQ?=
 =?utf-8?B?cWZadkU1NDlZSS9tMVZIS2RoejRqNzhBUHF4T1NLbURuNDhYUDlsd0l0YU42?=
 =?utf-8?B?clRSY3Y4RkZIR25vWHgvQm1yczlWUG1HYmNFeU01T2ljZDU5dCtZYm96d3M1?=
 =?utf-8?B?YWdHOGFaeE0vVENjWStjVkJSYWUyT3FXN2VKOUZScGF2YmhaeGxQSTdpZzQ0?=
 =?utf-8?B?Q0FCMEJqb3lxT2kwRmVlVlp2T3ZuMGo1TXJLTGxhdmQwSS9KNzlUWDl2Sita?=
 =?utf-8?B?VjFucmJxZEFEZVJpQXdPRmhpU29NbFdWWXdEN1JnQThxT1ZlTC83VDNnVHBj?=
 =?utf-8?B?MnkxQzhSb25oWHF2L1Z2Qy93MTA3RFVMVlhsTk41MmtOQmVyUGtuenpDT2Rl?=
 =?utf-8?B?bXpXbW0wUEVuS1V3WW5BMVZJUjNFQy83WFo2NUxzR3hLZEVmWWFQd1BjMUMy?=
 =?utf-8?B?dGlaaE1YUlp0c3NLMnRDM3VNUGVvUzZFMW9nSjhvQTExRlpWbmdCeUYxd1ha?=
 =?utf-8?Q?zKdS8I3s9/RUhZ2PjBPdX8EpQ3IzvBqmrIjb9I+Sv8dm8?=
X-MS-Exchange-AntiSpam-MessageData-1: uvKjfmlkLf1OUg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c4a7a8-9b53-4174-7b46-08de88cc7c1c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:08:17.4424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPrZg9f2P7tU8nbTi4ufbKoXEzzb/ccJ3RUaL8nQ+jgQk7KoCo3uqtr2Ym0WBv0yzCSgfNnRHstGSI+MbwPpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

Convert all PFALCON, PFALCON2 and PRISCV registers to use the kernel's
register macro and update the code accordingly.

Because they rely on the same types to implement relative registers,
they need to be updated in lockstep.

nova-core's local register macro is now unused, so remove it.

Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    | 530 ++++++---------
 drivers/gpu/nova-core/falcon/gsp.rs                |  22 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  55 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
 drivers/gpu/nova-core/regs.rs                      | 353 +++++-----
 drivers/gpu/nova-core/regs/macros.rs               | 739 ---------------------
 8 files changed, 454 insertions(+), 1293 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 5221e4476f90..f0b76289c311 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -15,8 +15,13 @@
     },
     io::{
         poll::read_poll_timeout,
-        Io, //
+        register::{
+            RegisterBase,
+            WithBase, //
+        },
+        Io,
     },
+    num::Bounded,
     prelude::*,
     sync::aref::ARef,
     time::Delta,
@@ -33,7 +38,6 @@
         IntoSafeCast, //
     },
     regs,
-    regs::macros::RegisterBase, //
 };
 
 pub(crate) mod gsp;
@@ -43,22 +47,10 @@
 /// Alignment (in bytes) of falcon memory blocks.
 pub(crate) const MEM_BLOCK_ALIGNMENT: usize = 256;
 
-// TODO[FPRI]: Replace with `ToPrimitive`.
-macro_rules! impl_from_enum_to_u8 {
-    ($enum_type:ty) => {
-        impl From<$enum_type> for u8 {
-            fn from(value: $enum_type) -> Self {
-                value as u8
-            }
-        }
-    };
-}
-
 /// Creates an enum type associated to a `Bounded`, with a `From` conversion to the associated
 /// `Bounded` and either a `TryFrom` or `From` converting from the associated `Bounded`.
 // TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros
 // once they land.
-#[expect(unused)]
 macro_rules! bounded_enum {
     (
         $(#[doc = $enum_doc:expr])*
@@ -78,7 +70,7 @@ pub(crate) enum $enum_type {
         impl From<$enum_type> for Bounded<$width, $length> {
             fn from(value: $enum_type) -> Self {
                 match value {
-                    $($enum_type::$variant => Bounded::<$width, _>::new::<$value>()),*
+                    $($enum_type::$variant => Bounded::<$width, _>::new::<{ $value }>()),*
                 }
             }
         }
@@ -106,20 +98,14 @@ fn try_from(value: Bounded<$width, $length>) -> Result<Self> {
         }
     };
 
-    // `From` implementation from associated `Bounded` to enum type. Triggers a `build_error` if
+    // `From` implementation from associated `Bounded` to enum type. Triggers a built-time error if
     // all possible values of the `Bounded` are not covered by the enum type.
     (@impl_from $enum_type:ident with From<Bounded<$width:ty, $length:literal>> {
         $($variant:ident = $value:expr),* $(,)*
     }) => {
         impl From<Bounded<$width, $length>> for $enum_type {
             fn from(value: Bounded<$width, $length>) -> Self {
-                $(
-                    // Ensure all enum values fit into the `Bounded` type.
-                    const { assert!(
-                        $value < (1 << $length),
-                        "Enum variant doesn't fit into assigned `Bounded` type."
-                    ); }
-                )*
+                const MAX: $width = 1 << $length;
 
                 // Makes the compiler optimizer aware of the possible range of values.
                 let value = value.get() & ((1 << $length) - 1);
@@ -127,201 +113,90 @@ fn from(value: Bounded<$width, $length>) -> Self {
                     $(
                         $value => $enum_type::$variant,
                     )*
-                    // We land here if the match didn't cover all possible values for the
-                    // `Bounded`.
-                    _ => build_error!("Enum doesn't cover all values of the `Bounded` type."),
+                    // PANIC: we cannot reach this arm as all possible variants are handled by the
+                    // match arms above. It is here to make the compiler complain if `$enum_type`
+                    // does not cover all values of the `0..MAX` range.
+                    MAX.. => unreachable!(),
                 }
             }
         }
     }
 }
 
-/// Revision number of a falcon core, used in the [`crate::regs::NV_PFALCON_FALCON_HWCFG1`]
-/// register.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
-pub(crate) enum FalconCoreRev {
-    #[default]
-    Rev1 = 1,
-    Rev2 = 2,
-    Rev3 = 3,
-    Rev4 = 4,
-    Rev5 = 5,
-    Rev6 = 6,
-    Rev7 = 7,
-}
-impl_from_enum_to_u8!(FalconCoreRev);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRev {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        use FalconCoreRev::*;
-
-        let rev = match value {
-            1 => Rev1,
-            2 => Rev2,
-            3 => Rev3,
-            4 => Rev4,
-            5 => Rev5,
-            6 => Rev6,
-            7 => Rev7,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(rev)
+bounded_enum! {
+    /// Revision number of a falcon core, used in the [`crate::regs::NV_PFALCON_FALCON_HWCFG1`]
+    /// register.
+    enum FalconCoreRev with TryFrom<Bounded<u32, 4>> {
+        Rev1 = 1,
+        Rev2 = 2,
+        Rev3 = 3,
+        Rev4 = 4,
+        Rev5 = 5,
+        Rev6 = 6,
+        Rev7 = 7,
     }
 }
 
-/// Revision subversion number of a falcon core, used in the
-/// [`crate::regs::NV_PFALCON_FALCON_HWCFG1`] register.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
-pub(crate) enum FalconCoreRevSubversion {
-    #[default]
-    Subversion0 = 0,
-    Subversion1 = 1,
-    Subversion2 = 2,
-    Subversion3 = 3,
-}
-impl_from_enum_to_u8!(FalconCoreRevSubversion);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRevSubversion {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        use FalconCoreRevSubversion::*;
-
-        let sub_version = match value & 0b11 {
-            0 => Subversion0,
-            1 => Subversion1,
-            2 => Subversion2,
-            3 => Subversion3,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(sub_version)
+bounded_enum! {
+    /// Revision subversion number of a falcon core, used in the
+    /// [`crate::regs::NV_PFALCON_FALCON_HWCFG1`] register.
+    enum FalconCoreRevSubversion with From<Bounded<u32, 2>> {
+        Subversion0 = 0,
+        Subversion1 = 1,
+        Subversion2 = 2,
+        Subversion3 = 3,
     }
 }
 
-/// Security model of a falcon core, used in the [`crate::regs::NV_PFALCON_FALCON_HWCFG1`]
-/// register.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone)]
-/// Security mode of the Falcon microprocessor.
-///
-/// See `falcon.rst` for more details.
-pub(crate) enum FalconSecurityModel {
-    /// Non-Secure: runs unsigned code without privileges.
-    #[default]
-    None = 0,
-    /// Light-Secured (LS): Runs signed code with some privileges.
-    /// Entry into this mode is only possible from 'Heavy-secure' mode, which verifies the code's
-    /// signature.
+bounded_enum! {
+    /// Security mode of the Falcon microprocessor.
     ///
-    /// Also known as Low-Secure, Privilege Level 2 or PL2.
-    Light = 2,
-    /// Heavy-Secured (HS): Runs signed code with full privileges.
-    /// The code's signature is verified by the Falcon Boot ROM (BROM).
-    ///
-    /// Also known as High-Secure, Privilege Level 3 or PL3.
-    Heavy = 3,
-}
-impl_from_enum_to_u8!(FalconSecurityModel);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconSecurityModel {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        use FalconSecurityModel::*;
-
-        let sec_model = match value {
-            0 => None,
-            2 => Light,
-            3 => Heavy,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(sec_model)
+    /// See `falcon.rst` for more details.
+    enum FalconSecurityModel with TryFrom<Bounded<u32, 2>> {
+        /// Non-Secure: runs unsigned code without privileges.
+        None = 0,
+        /// Light-Secured (LS): Runs signed code with some privileges.
+        /// Entry into this mode is only possible from 'Heavy-secure' mode, which verifies the
+        /// code's signature.
+        ///
+        /// Also known as Low-Secure, Privilege Level 2 or PL2.
+        Light = 2,
+        /// Heavy-Secured (HS): Runs signed code with full privileges.
+        /// The code's signature is verified by the Falcon Boot ROM (BROM).
+        ///
+        /// Also known as High-Secure, Privilege Level 3 or PL3.
+        Heavy = 3,
     }
 }
 
-/// Signing algorithm for a given firmware, used in the [`crate::regs::NV_PFALCON2_FALCON_MOD_SEL`]
-/// register. It is passed to the Falcon Boot ROM (BROM) as a parameter.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone, PartialEq, Eq)]
-pub(crate) enum FalconModSelAlgo {
-    /// AES.
-    #[expect(dead_code)]
-    Aes = 0,
-    /// RSA3K.
-    #[default]
-    Rsa3k = 1,
-}
-impl_from_enum_to_u8!(FalconModSelAlgo);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconModSelAlgo {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
-            1 => Ok(FalconModSelAlgo::Rsa3k),
-            _ => Err(EINVAL),
-        }
+bounded_enum! {
+    /// Signing algorithm for a given firmware, used in the
+    /// [`crate::regs::NV_PFALCON2_FALCON_MOD_SEL`] register. It is passed to the Falcon Boot ROM
+    /// (BROM) as a parameter.
+    enum FalconModSelAlgo with TryFrom<Bounded<u32, 8>> {
+        /// AES.
+        Aes = 0,
+        /// RSA3K.
+        Rsa3k = 1,
     }
 }
 
-/// Valid values for the `size` field of the [`crate::regs::NV_PFALCON_FALCON_DMATRFCMD`] register.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone, PartialEq, Eq)]
-pub(crate) enum DmaTrfCmdSize {
-    /// 256 bytes transfer.
-    #[default]
-    Size256B = 0x6,
-}
-impl_from_enum_to_u8!(DmaTrfCmdSize);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for DmaTrfCmdSize {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
-            0x6 => Ok(Self::Size256B),
-            _ => Err(EINVAL),
-        }
+bounded_enum! {
+    /// Valid values for the `size` field of the [`crate::regs::NV_PFALCON_FALCON_DMATRFCMD`]
+    /// register.
+    enum DmaTrfCmdSize with TryFrom<Bounded<u32, 3>> {
+        /// 256 bytes transfer.
+        Size256B = 0x6,
     }
 }
 
-/// Currently active core on a dual falcon/riscv (Peregrine) controller.
-#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
-pub(crate) enum PeregrineCoreSelect {
-    /// Falcon core is active.
-    #[default]
-    Falcon = 0,
-    /// RISC-V core is active.
-    Riscv = 1,
-}
-
-impl From<bool> for PeregrineCoreSelect {
-    fn from(value: bool) -> Self {
-        match value {
-            false => PeregrineCoreSelect::Falcon,
-            true => PeregrineCoreSelect::Riscv,
-        }
-    }
-}
-
-impl From<PeregrineCoreSelect> for bool {
-    fn from(value: PeregrineCoreSelect) -> Self {
-        match value {
-            PeregrineCoreSelect::Falcon => false,
-            PeregrineCoreSelect::Riscv => true,
-        }
+bounded_enum! {
+    /// Currently active core on a dual falcon/riscv (Peregrine) controller.
+    enum PeregrineCoreSelect with From<Bounded<u32, 1>> {
+        /// Falcon core is active.
+        Falcon = 0,
+        /// RISC-V core is active.
+        Riscv = 1,
     }
 }
 
@@ -337,64 +212,27 @@ pub(crate) enum FalconMem {
     Dmem,
 }
 
-/// Defines the Framebuffer Interface (FBIF) aperture type.
-/// This determines the memory type for external memory access during a DMA transfer, which is
-/// performed by the Falcon's Framebuffer DMA (FBDMA) engine. See falcon.rst for more details.
-#[derive(Debug, Clone, Default)]
-pub(crate) enum FalconFbifTarget {
-    /// VRAM.
-    #[default]
-    /// Local Framebuffer (GPU's VRAM memory).
-    LocalFb = 0,
-    /// Coherent system memory (System DRAM).
-    CoherentSysmem = 1,
-    /// Non-coherent system memory (System DRAM).
-    NoncoherentSysmem = 2,
-}
-impl_from_enum_to_u8!(FalconFbifTarget);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconFbifTarget {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        let res = match value {
-            0 => Self::LocalFb,
-            1 => Self::CoherentSysmem,
-            2 => Self::NoncoherentSysmem,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(res)
+bounded_enum! {
+    /// Defines the Framebuffer Interface (FBIF) aperture type.
+    /// This determines the memory type for external memory access during a DMA transfer, which is
+    /// performed by the Falcon's Framebuffer DMA (FBDMA) engine. See falcon.rst for more details.
+    enum FalconFbifTarget with TryFrom<Bounded<u32, 2>> {
+        /// Local Framebuffer (GPU's VRAM memory).
+        LocalFb = 0,
+        /// Coherent system memory (System DRAM).
+        CoherentSysmem = 1,
+        /// Non-coherent system memory (System DRAM).
+        NoncoherentSysmem = 2,
     }
 }
 
-/// Type of memory addresses to use.
-#[derive(Debug, Clone, Default)]
-pub(crate) enum FalconFbifMemType {
-    /// Virtual memory addresses.
-    #[default]
-    Virtual = 0,
-    /// Physical memory addresses.
-    Physical = 1,
-}
-
-/// Conversion from a single-bit register field.
-impl From<bool> for FalconFbifMemType {
-    fn from(value: bool) -> Self {
-        match value {
-            false => Self::Virtual,
-            true => Self::Physical,
-        }
-    }
-}
-
-impl From<FalconFbifMemType> for bool {
-    fn from(value: FalconFbifMemType) -> Self {
-        match value {
-            FalconFbifMemType::Virtual => false,
-            FalconFbifMemType::Physical => true,
-        }
+bounded_enum! {
+    /// Type of memory addresses to use.
+    enum FalconFbifMemType with From<Bounded<u32, 1>> {
+        /// Virtual memory addresses.
+        Virtual = 0,
+        /// Physical memory addresses.
+        Physical = 1,
     }
 }
 
@@ -406,13 +244,10 @@ fn from(value: FalconFbifMemType) -> Self {
 
 /// Trait defining the parameters of a given Falcon engine.
 ///
-/// Each engine provides one base for `PFALCON` and `PFALCON2` registers. The `ID` constant is used
-/// to identify a given Falcon instance with register I/O methods.
+/// Each engine provides one base for `PFALCON` and `PFALCON2` registers.
 pub(crate) trait FalconEngine:
     Send + Sync + RegisterBase<PFalconBase> + RegisterBase<PFalcon2Base> + Sized
 {
-    /// Singleton of the engine, used to identify it with register I/O methods.
-    const ID: Self;
 }
 
 /// Represents a portion of the firmware to be loaded into a particular memory (e.g. IMEM or DMEM)
@@ -606,8 +441,14 @@ pub(crate) fn new(dev: &device::Device, chipset: Chipset) -> Result<Self> {
 
     /// Resets DMA-related registers.
     pub(crate) fn dma_reset(&self, bar: &Bar0) {
-        regs::NV_PFALCON_FBIF_CTL::update(bar, &E::ID, |v| v.set_allow_phys_no_ctx(true));
-        regs::NV_PFALCON_FALCON_DMACTL::default().write(bar, &E::ID);
+        bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+            v.with_allow_phys_no_ctx(true)
+        });
+
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
+        );
     }
 
     /// Reset the controller, select the falcon core, and wait for memory scrubbing to complete.
@@ -616,9 +457,10 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.hal.select_core(self, bar)?;
         self.hal.reset_wait_mem_scrubbing(bar)?;
 
-        regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_RM::from(bar.read(regs::NV_PMC_BOOT_0).into_raw()),
+        );
 
         Ok(())
     }
@@ -636,25 +478,27 @@ fn pio_wr_imem_slice(&self, bar: &Bar0, load_offsets: FalconPioImemLoadTarget<'_
             return Err(EINVAL);
         }
 
-        regs::NV_PFALCON_FALCON_IMEMC::default()
-            .set_secure(load_offsets.secure)
-            .set_aincw(true)
-            .set_offs(load_offsets.dst_start)
-            .write(bar, &E::ID, Self::PIO_PORT);
+        bar.write(
+            WithBase::of::<E>().at(Self::PIO_PORT),
+            regs::NV_PFALCON_FALCON_IMEMC::zeroed()
+                .with_secure(load_offsets.secure)
+                .with_aincw(true)
+                .with_offs(load_offsets.dst_start),
+        );
 
         for (n, block) in load_offsets.data.chunks(MEM_BLOCK_ALIGNMENT).enumerate() {
             let n = u16::try_from(n)?;
             let tag: u16 = load_offsets.start_tag.checked_add(n).ok_or(ERANGE)?;
-            regs::NV_PFALCON_FALCON_IMEMT::default().set_tag(tag).write(
-                bar,
-                &E::ID,
-                Self::PIO_PORT,
+            bar.write(
+                WithBase::of::<E>().at(Self::PIO_PORT),
+                regs::NV_PFALCON_FALCON_IMEMT::zeroed().with_tag(tag),
             );
             for word in block.chunks_exact(4) {
                 let w = [word[0], word[1], word[2], word[3]];
-                regs::NV_PFALCON_FALCON_IMEMD::default()
-                    .set_data(u32::from_le_bytes(w))
-                    .write(bar, &E::ID, Self::PIO_PORT);
+                bar.write(
+                    WithBase::of::<E>().at(Self::PIO_PORT),
+                    regs::NV_PFALCON_FALCON_IMEMD::zeroed().with_data(u32::from_le_bytes(w)),
+                );
             }
         }
 
@@ -671,16 +515,19 @@ fn pio_wr_dmem_slice(&self, bar: &Bar0, load_offsets: FalconPioDmemLoadTarget<'_
             return Err(EINVAL);
         }
 
-        regs::NV_PFALCON_FALCON_DMEMC::default()
-            .set_aincw(true)
-            .set_offs(load_offsets.dst_start)
-            .write(bar, &E::ID, Self::PIO_PORT);
+        bar.write(
+            WithBase::of::<E>().at(Self::PIO_PORT),
+            regs::NV_PFALCON_FALCON_DMEMC::zeroed()
+                .with_aincw(true)
+                .with_offs(load_offsets.dst_start),
+        );
 
         for word in load_offsets.data.chunks_exact(4) {
             let w = [word[0], word[1], word[2], word[3]];
-            regs::NV_PFALCON_FALCON_DMEMD::default()
-                .set_data(u32::from_le_bytes(w))
-                .write(bar, &E::ID, Self::PIO_PORT);
+            bar.write(
+                WithBase::of::<E>().at(Self::PIO_PORT),
+                regs::NV_PFALCON_FALCON_DMEMD::zeroed().with_data(u32::from_le_bytes(w)),
+            );
         }
 
         Ok(())
@@ -692,11 +539,14 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         bar: &Bar0,
         fw: &F,
     ) -> Result {
-        regs::NV_PFALCON_FBIF_CTL::read(bar, &E::ID)
-            .set_allow_phys_no_ctx(true)
-            .write(bar, &E::ID);
+        bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+            v.with_allow_phys_no_ctx(true)
+        });
 
-        regs::NV_PFALCON_FALCON_DMACTL::default().write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
+        );
 
         if let Some(imem_ns) = fw.imem_ns_load_params() {
             self.pio_wr_imem_slice(bar, imem_ns)?;
@@ -708,9 +558,10 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
 
         self.hal.program_brom(self, bar, &fw.brom_params())?;
 
-        regs::NV_PFALCON_FALCON_BOOTVEC::default()
-            .set_value(fw.boot_addr())
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
+        );
 
         Ok(())
     }
@@ -779,36 +630,42 @@ fn dma_wr(
 
         // Set up the base source DMA address.
 
-        regs::NV_PFALCON_FALCON_DMATRFBASE::default()
-            // CAST: `as u32` is used on purpose since we do want to strip the upper bits, which
-            // will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
-            .set_base((dma_start >> 8) as u32)
-            .write(bar, &E::ID);
-        regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
-            // CAST: `as u16` is used on purpose since the remaining bits are guaranteed to fit
-            // within a `u16`.
-            .set_base((dma_start >> 40) as u16)
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
+                // CAST: `as u32` is used on purpose since we do want to strip the upper bits,
+                // which will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
+                (dma_start >> 8) as u32,
+            ),
+        );
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_DMATRFBASE1::zeroed().try_with_base(dma_start >> 40)?,
+        );
 
-        let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::default()
-            .set_size(DmaTrfCmdSize::Size256B)
+        let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::zeroed()
+            .with_size(DmaTrfCmdSize::Size256B)
             .with_falcon_mem(target_mem);
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
-            regs::NV_PFALCON_FALCON_DMATRFMOFFS::default()
-                .set_offs(load_offsets.dst_start + pos)
-                .write(bar, &E::ID);
-            regs::NV_PFALCON_FALCON_DMATRFFBOFFS::default()
-                .set_offs(src_start + pos)
-                .write(bar, &E::ID);
-            cmd.write(bar, &E::ID);
+            bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_DMATRFMOFFS::zeroed()
+                    .try_with_offs(load_offsets.dst_start + pos)?,
+            );
+            bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_DMATRFFBOFFS::zeroed().with_offs(src_start + pos),
+            );
+
+            bar.write(WithBase::of::<E>(), cmd);
 
             // Wait for the transfer to complete.
             // TIMEOUT: arbitrarily large value, no DMA transfer to the falcon's small memories
             // should ever take that long.
             read_poll_timeout(
-                || Ok(regs::NV_PFALCON_FALCON_DMATRFCMD::read(bar, &E::ID)),
+                || Ok(bar.read(regs::NV_PFALCON_FALCON_DMATRFCMD::of::<E>())),
                 |r| r.idle(),
                 Delta::ZERO,
                 Delta::from_secs(2),
@@ -829,9 +686,9 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
         let dma_obj = DmaObject::from_data(dev, fw.as_slice())?;
 
         self.dma_reset(bar);
-        regs::NV_PFALCON_FBIF_TRANSCFG::update(bar, &E::ID, 0, |v| {
-            v.set_target(FalconFbifTarget::CoherentSysmem)
-                .set_mem_type(FalconFbifMemType::Physical)
+        bar.update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| {
+            v.with_target(FalconFbifTarget::CoherentSysmem)
+                .with_mem_type(FalconFbifMemType::Physical)
         });
 
         self.dma_wr(
@@ -845,9 +702,10 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
         self.hal.program_brom(self, bar, &fw.brom_params())?;
 
         // Set `BootVec` to start of non-secure code.
-        regs::NV_PFALCON_FALCON_BOOTVEC::default()
-            .set_value(fw.boot_addr())
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
+        );
 
         Ok(())
     }
@@ -856,7 +714,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
     pub(crate) fn wait_till_halted(&self, bar: &Bar0) -> Result<()> {
         // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
         read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_CPUCTL::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())),
             |r| r.halted(),
             Delta::ZERO,
             Delta::from_secs(2),
@@ -867,13 +725,18 @@ pub(crate) fn wait_till_halted(&self, bar: &Bar0) -> Result<()> {
 
     /// Start the falcon CPU.
     pub(crate) fn start(&self, bar: &Bar0) -> Result<()> {
-        match regs::NV_PFALCON_FALCON_CPUCTL::read(bar, &E::ID).alias_en() {
-            true => regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::default()
-                .set_startcpu(true)
-                .write(bar, &E::ID),
-            false => regs::NV_PFALCON_FALCON_CPUCTL::default()
-                .set_startcpu(true)
-                .write(bar, &E::ID),
+        match bar
+            .read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())
+            .alias_en()
+        {
+            true => bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startcpu(true),
+            ),
+            false => bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(true),
+            ),
         }
 
         Ok(())
@@ -882,26 +745,30 @@ pub(crate) fn start(&self, bar: &Bar0) -> Result<()> {
     /// Writes values to the mailbox registers if provided.
     pub(crate) fn write_mailboxes(&self, bar: &Bar0, mbox0: Option<u32>, mbox1: Option<u32>) {
         if let Some(mbox0) = mbox0 {
-            regs::NV_PFALCON_FALCON_MAILBOX0::default()
-                .set_value(mbox0)
-                .write(bar, &E::ID);
+            bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox0),
+            );
         }
 
         if let Some(mbox1) = mbox1 {
-            regs::NV_PFALCON_FALCON_MAILBOX1::default()
-                .set_value(mbox1)
-                .write(bar, &E::ID);
+            bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox1),
+            );
         }
     }
 
     /// Reads the value from `mbox0` register.
     pub(crate) fn read_mailbox0(&self, bar: &Bar0) -> u32 {
-        regs::NV_PFALCON_FALCON_MAILBOX0::read(bar, &E::ID).value()
+        bar.read(regs::NV_PFALCON_FALCON_MAILBOX0::of::<E>())
+            .value()
     }
 
     /// Reads the value from `mbox1` register.
     pub(crate) fn read_mailbox1(&self, bar: &Bar0) -> u32 {
-        regs::NV_PFALCON_FALCON_MAILBOX1::read(bar, &E::ID).value()
+        bar.read(regs::NV_PFALCON_FALCON_MAILBOX1::of::<E>())
+            .value()
     }
 
     /// Reads values from both mailbox registers.
@@ -966,8 +833,9 @@ pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
 
     /// Write the application version to the OS register.
     pub(crate) fn write_os_version(&self, bar: &Bar0, app_version: u32) {
-        regs::NV_PFALCON_FALCON_OS::default()
-            .set_value(app_version)
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version),
+        );
     }
 }
diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index e52f57abc223..df6d5a382c7a 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -3,7 +3,11 @@
 use kernel::{
     io::{
         poll::read_poll_timeout,
-        Io, //
+        register::{
+            RegisterBase,
+            WithBase, //
+        },
+        Io,
     },
     prelude::*,
     time::Delta, //
@@ -17,10 +21,7 @@
         PFalcon2Base,
         PFalconBase, //
     },
-    regs::{
-        self,
-        macros::RegisterBase, //
-    },
+    regs,
 };
 
 /// Type specifying the `Gsp` falcon engine. Cannot be instantiated.
@@ -34,17 +35,16 @@ impl RegisterBase<PFalcon2Base> for Gsp {
     const BASE: usize = 0x00111000;
 }
 
-impl FalconEngine for Gsp {
-    const ID: Self = Gsp(());
-}
+impl FalconEngine for Gsp {}
 
 impl Falcon<Gsp> {
     /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register to
     /// allow GSP to signal CPU for processing new messages in message queue.
     pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
-        regs::NV_PFALCON_FALCON_IRQSCLR::default()
-            .set_swgen0(true)
-            .write(bar, &Gsp::ID);
+        bar.write(
+            WithBase::of::<Gsp>(),
+            regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true),
+        );
     }
 
     /// Checks if GSP reload/resume has completed during the boot process.
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index cbdf36bad633..8368a61ddeef 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -6,7 +6,10 @@
     device,
     io::{
         poll::read_poll_timeout,
-        register::Array,
+        register::{
+            Array,
+            WithBase, //
+        },
         Io, //
     },
     prelude::*,
@@ -29,15 +32,16 @@
 use super::FalconHal;
 
 fn select_core_ga102<E: FalconEngine>(bar: &Bar0) -> Result {
-    let bcr_ctrl = regs::NV_PRISCV_RISCV_BCR_CTRL::read(bar, &E::ID);
+    let bcr_ctrl = bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>());
     if bcr_ctrl.core_select() != PeregrineCoreSelect::Falcon {
-        regs::NV_PRISCV_RISCV_BCR_CTRL::default()
-            .set_core_select(PeregrineCoreSelect::Falcon)
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PRISCV_RISCV_BCR_CTRL::zeroed().with_core_select(PeregrineCoreSelect::Falcon),
+        );
 
         // TIMEOUT: falcon core should take less than 10ms to report being enabled.
         read_poll_timeout(
-            || Ok(regs::NV_PRISCV_RISCV_BCR_CTRL::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>())),
             |r| r.valid(),
             Delta::ZERO,
             Delta::from_millis(10),
@@ -83,18 +87,23 @@ fn signature_reg_fuse_version_ga102(
 }
 
 fn program_brom_ga102<E: FalconEngine>(bar: &Bar0, params: &FalconBromParams) -> Result {
-    regs::NV_PFALCON2_FALCON_BROM_PARAADDR::default()
-        .set_value(params.pkc_data_offset)
-        .write(bar, &E::ID, 0);
-    regs::NV_PFALCON2_FALCON_BROM_ENGIDMASK::default()
-        .set_value(u32::from(params.engine_id_mask))
-        .write(bar, &E::ID);
-    regs::NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID::default()
-        .set_ucode_id(params.ucode_id)
-        .write(bar, &E::ID);
-    regs::NV_PFALCON2_FALCON_MOD_SEL::default()
-        .set_algo(FalconModSelAlgo::Rsa3k)
-        .write(bar, &E::ID);
+    bar.write(
+        WithBase::of::<E>().at(0),
+        regs::NV_PFALCON2_FALCON_BROM_PARAADDR::zeroed().with_value(params.pkc_data_offset),
+    );
+    bar.write(
+        WithBase::of::<E>(),
+        regs::NV_PFALCON2_FALCON_BROM_ENGIDMASK::zeroed()
+            .with_value(u32::from(params.engine_id_mask)),
+    );
+    bar.write(
+        WithBase::of::<E>(),
+        regs::NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID::zeroed().with_ucode_id(params.ucode_id),
+    );
+    bar.write(
+        WithBase::of::<E>(),
+        regs::NV_PFALCON2_FALCON_MOD_SEL::zeroed().with_algo(FalconModSelAlgo::Rsa3k),
+    );
 
     Ok(())
 }
@@ -127,14 +136,14 @@ fn program_brom(&self, _falcon: &Falcon<E>, bar: &Bar0, params: &FalconBromParam
     }
 
     fn is_riscv_active(&self, bar: &Bar0) -> bool {
-        let cpuctl = regs::NV_PRISCV_RISCV_CPUCTL::read(bar, &E::ID);
-        cpuctl.active_stat()
+        bar.read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
+            .active_stat()
     }
 
     fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 20ms.
         read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(20),
@@ -143,12 +152,12 @@ fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
     }
 
     fn reset_eng(&self, bar: &Bar0) -> Result {
-        let _ = regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &E::ID);
+        let _ = bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>());
 
         // According to OpenRM's `kflcnPreResetWait_GA102` documentation, HW sometimes does not set
         // RESET_READY so a non-failing timeout is used.
         let _ = read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
             |r| r.reset_ready(),
             Delta::ZERO,
             Delta::from_micros(150),
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-core/falcon/hal/tu102.rs
index 7de6f24cc0a0..c7a90266cb44 100644
--- a/drivers/gpu/nova-core/falcon/hal/tu102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/tu102.rs
@@ -3,7 +3,11 @@
 use core::marker::PhantomData;
 
 use kernel::{
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        register::WithBase,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -49,14 +53,14 @@ fn program_brom(&self, _falcon: &Falcon<E>, _bar: &Bar0, _params: &FalconBromPar
     }
 
     fn is_riscv_active(&self, bar: &Bar0) -> bool {
-        let cpuctl = regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::read(bar, &E::ID);
-        cpuctl.active_stat()
+        bar.read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::of::<E>())
+            .active_stat()
     }
 
     fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 10ms.
         read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_DMACTL::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PFALCON_FALCON_DMACTL::of::<E>())),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(10),
diff --git a/drivers/gpu/nova-core/falcon/sec2.rs b/drivers/gpu/nova-core/falcon/sec2.rs
index b57d362e576a..91ec7d49c1f5 100644
--- a/drivers/gpu/nova-core/falcon/sec2.rs
+++ b/drivers/gpu/nova-core/falcon/sec2.rs
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use crate::{
-    falcon::{
-        FalconEngine,
-        PFalcon2Base,
-        PFalconBase, //
-    },
-    regs::macros::RegisterBase,
+use kernel::io::register::RegisterBase;
+
+use crate::falcon::{
+    FalconEngine,
+    PFalcon2Base,
+    PFalconBase, //
 };
 
 /// Type specifying the `Sec2` falcon engine. Cannot be instantiated.
@@ -20,6 +19,4 @@ impl RegisterBase<PFalcon2Base> for Sec2 {
     const BASE: usize = 0x00841000;
 }
 
-impl FalconEngine for Sec2 {
-    const ID: Self = Sec2(());
-}
+impl FalconEngine for Sec2 {}
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 342dba59b2f9..3b12d90d9412 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -12,6 +12,10 @@
         self,
         Device, //
     },
+    io::{
+        register::WithBase, //
+        Io,
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -33,7 +37,6 @@
         Falcon,
         FalconBromParams,
         FalconDmaLoadable,
-        FalconEngine,
         FalconFbifMemType,
         FalconFbifTarget,
         FalconFirmware,
@@ -288,15 +291,15 @@ pub(crate) fn run(
             .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware: {:?}\n", e))?;
 
         // Configure DMA index for the bootloader to fetch the FWSEC firmware from system memory.
-        regs::NV_PFALCON_FBIF_TRANSCFG::try_update(
-            bar,
-            &Gsp::ID,
-            usize::from_safe_cast(self.dmem_desc.ctx_dma),
+        bar.update(
+            regs::NV_PFALCON_FBIF_TRANSCFG::of::<Gsp>()
+                .try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
+                .ok_or(EINVAL)?,
             |v| {
-                v.set_target(FalconFbifTarget::CoherentSysmem)
-                    .set_mem_type(FalconFbifMemType::Physical)
+                v.with_target(FalconFbifTarget::CoherentSysmem)
+                    .with_mem_type(FalconFbifMemType::Physical)
             },
-        )?;
+        );
 
         let (mbox0, _) = falcon
             .boot(bar, Some(0), None)
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index b051d5568cd8..87c2977ba6e4 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -1,14 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-// Required to retain the original register names used by OpenRM, which are all capital snake case
-// but are mapped to types.
-#![allow(non_camel_case_types)]
-
-#[macro_use]
-pub(crate) mod macros;
-
 use kernel::{
-    io,
+    io::{
+        self,
+        register::WithBase,
+        Io, //
+    },
     prelude::*,
     time, //
 };
@@ -290,60 +287,147 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 // PFALCON
 
-register!(NV_PFALCON_FALCON_IRQSCLR @ PFalconBase[0x00000004] {
-    4:4     halt as bool;
-    6:6     swgen0 as bool;
-});
+io::register! {
+    pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
+        6:6     swgen0 => bool;
+        4:4     halt => bool;
+    }
 
-register!(NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase[0x00000040] {
-    31:0    value as u32;
-});
+    pub(crate) NV_PFALCON_FALCON_MAILBOX0(u32) @ PFalconBase + 0x00000040 {
+        31:0    value => u32;
+    }
 
-register!(NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase[0x00000044] {
-    31:0    value as u32;
-});
+    pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ PFalconBase + 0x00000044 {
+        31:0    value => u32;
+    }
 
-// Used to store version information about the firmware running
-// on the Falcon processor.
-register!(NV_PFALCON_FALCON_OS @ PFalconBase[0x00000080] {
-    31:0    value as u32;
-});
+    /// Used to store version information about the firmware running
+    /// on the Falcon processor.
+    pub(crate) NV_PFALCON_FALCON_OS(u32) @ PFalconBase + 0x00000080 {
+        31:0    value => u32;
+    }
 
-register!(NV_PFALCON_FALCON_RM @ PFalconBase[0x00000084] {
-    31:0    value as u32;
-});
+    pub(crate) NV_PFALCON_FALCON_RM(u32) @ PFalconBase + 0x00000084 {
+        31:0    value => u32;
+    }
 
-register!(NV_PFALCON_FALCON_HWCFG2 @ PFalconBase[0x000000f4] {
-    10:10   riscv as bool;
-    12:12   mem_scrubbing as bool, "Set to 0 after memory scrubbing is completed";
-    31:31   reset_ready as bool, "Signal indicating that reset is completed (GA102+)";
-});
+    pub(crate) NV_PFALCON_FALCON_HWCFG2(u32) @ PFalconBase + 0x000000f4 {
+        /// Signal indicating that reset is completed (GA102+).
+        31:31   reset_ready => bool;
+        /// Set to 0 after memory scrubbing is completed.
+        12:12   mem_scrubbing => bool;
+        10:10   riscv => bool;
+    }
 
-impl NV_PFALCON_FALCON_HWCFG2 {
-    /// Returns `true` if memory scrubbing is completed.
-    pub(crate) fn mem_scrubbing_done(self) -> bool {
-        !self.mem_scrubbing()
+    pub(crate) NV_PFALCON_FALCON_CPUCTL(u32) @ PFalconBase + 0x00000100 {
+        6:6     alias_en => bool;
+        4:4     halted => bool;
+        1:1     startcpu => bool;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_BOOTVEC(u32) @ PFalconBase + 0x00000104 {
+        31:0    value => u32;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMACTL(u32) @ PFalconBase + 0x0000010c {
+        7:7     secure_stat => bool;
+        6:3     dmaq_num;
+        2:2     imem_scrubbing => bool;
+        1:1     dmem_scrubbing => bool;
+        0:0     require_ctx => bool;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE(u32) @ PFalconBase + 0x00000110 {
+        31:0    base => u32;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFMOFFS(u32) @ PFalconBase + 0x00000114 {
+        23:0    offs;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFCMD(u32) @ PFalconBase + 0x00000118 {
+        16:16   set_dmtag;
+        14:12   ctxdma;
+        10:8    size ?=> DmaTrfCmdSize;
+        5:5     is_write => bool;
+        4:4     imem => bool;
+        3:2     sec;
+        1:1     idle => bool;
+        0:0     full => bool;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFFBOFFS(u32) @ PFalconBase + 0x0000011c {
+        31:0    offs => u32;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE1(u32) @ PFalconBase + 0x00000128 {
+        8:0     base;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_HWCFG1(u32) @ PFalconBase + 0x0000012c {
+        /// Core revision subversion.
+        7:6     core_rev_subversion => FalconCoreRevSubversion;
+        /// Security model.
+        5:4     security_model ?=> FalconSecurityModel;
+        /// Core revision.
+        3:0     core_rev ?=> FalconCoreRev;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_CPUCTL_ALIAS(u32) @ PFalconBase + 0x00000130 {
+        1:1     startcpu => bool;
+    }
+
+    /// IMEM access control register. Up to 4 ports are available for IMEM access.
+    pub(crate) NV_PFALCON_FALCON_IMEMC(u32)[4, stride = 16] @ PFalconBase + 0x00000180 {
+        /// Access secure IMEM.
+        28:28     secure => bool;
+        /// Auto-increment on write.
+        24:24     aincw => bool;
+        /// IMEM block and word offset.
+        15:0      offs;
+    }
+
+    /// IMEM data register. Reading/writing this register accesses IMEM at the address
+    /// specified by the corresponding IMEMC register.
+    pub(crate) NV_PFALCON_FALCON_IMEMD(u32)[4, stride = 16] @ PFalconBase + 0x00000184 {
+        31:0      data;
+    }
+
+    /// IMEM tag register. Used to set the tag for the current IMEM block.
+    pub(crate) NV_PFALCON_FALCON_IMEMT(u32)[4, stride = 16] @ PFalconBase + 0x00000188 {
+        15:0      tag;
+    }
+
+    /// DMEM access control register. Up to 8 ports are available for DMEM access.
+    pub(crate) NV_PFALCON_FALCON_DMEMC(u32)[8, stride = 8] @ PFalconBase + 0x000001c0 {
+        /// Auto-increment on write.
+        24:24     aincw => bool;
+        /// DMEM block and word offset.
+        15:0      offs;
+    }
+
+    /// DMEM data register. Reading/writing this register accesses DMEM at the address
+    /// specified by the corresponding DMEMC register.
+    pub(crate) NV_PFALCON_FALCON_DMEMD(u32)[8, stride = 8] @ PFalconBase + 0x000001c4 {
+        31:0      data;
+    }
+
+    /// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the
+    /// falcon instance.
+    pub(crate) NV_PFALCON_FALCON_ENGINE(u32) @ PFalconBase + 0x000003c0 {
+        0:0     reset => bool;
+    }
+
+    pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ PFalconBase + 0x00000600 {
+        2:2     mem_type => FalconFbifMemType;
+        1:0     target ?=> FalconFbifTarget;
+    }
+
+    pub(crate) NV_PFALCON_FBIF_CTL(u32) @ PFalconBase + 0x00000624 {
+        7:7     allow_phys_no_ctx => bool;
     }
 }
 
-register!(NV_PFALCON_FALCON_CPUCTL @ PFalconBase[0x00000100] {
-    1:1     startcpu as bool;
-    4:4     halted as bool;
-    6:6     alias_en as bool;
-});
-
-register!(NV_PFALCON_FALCON_BOOTVEC @ PFalconBase[0x00000104] {
-    31:0    value as u32;
-});
-
-register!(NV_PFALCON_FALCON_DMACTL @ PFalconBase[0x0000010c] {
-    0:0     require_ctx as bool;
-    1:1     dmem_scrubbing as bool;
-    2:2     imem_scrubbing as bool;
-    6:3     dmaq_num as u8;
-    7:7     secure_stat as bool;
-});
-
 impl NV_PFALCON_FALCON_DMACTL {
     /// Returns `true` if memory scrubbing is completed.
     pub(crate) fn mem_scrubbing_done(self) -> bool {
@@ -351,147 +435,82 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
     }
 }
 
-register!(NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase[0x00000110] {
-    31:0    base as u32;
-});
-
-register!(NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase[0x00000114] {
-    23:0    offs as u32;
-});
-
-register!(NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase[0x00000118] {
-    0:0     full as bool;
-    1:1     idle as bool;
-    3:2     sec as u8;
-    4:4     imem as bool;
-    5:5     is_write as bool;
-    10:8    size as u8 ?=> DmaTrfCmdSize;
-    14:12   ctxdma as u8;
-    16:16   set_dmtag as u8;
-});
-
 impl NV_PFALCON_FALCON_DMATRFCMD {
     /// Programs the `imem` and `sec` fields for the given FalconMem
     pub(crate) fn with_falcon_mem(self, mem: FalconMem) -> Self {
-        self.set_imem(mem != FalconMem::Dmem)
-            .set_sec(if mem == FalconMem::ImemSecure { 1 } else { 0 })
+        let this = self.with_imem(mem != FalconMem::Dmem);
+
+        match mem {
+            FalconMem::ImemSecure => this.with_const_sec::<1>(),
+            _ => this.with_const_sec::<0>(),
+        }
     }
 }
 
-register!(NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase[0x0000011c] {
-    31:0    offs as u32;
-});
-
-register!(NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase[0x00000128] {
-    8:0     base as u16;
-});
-
-register!(NV_PFALCON_FALCON_HWCFG1 @ PFalconBase[0x0000012c] {
-    3:0     core_rev as u8 ?=> FalconCoreRev, "Core revision";
-    5:4     security_model as u8 ?=> FalconSecurityModel, "Security model";
-    7:6     core_rev_subversion as u8 ?=> FalconCoreRevSubversion, "Core revision subversion";
-});
-
-register!(NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase[0x00000130] {
-    1:1     startcpu as bool;
-});
-
-// IMEM access control register. Up to 4 ports are available for IMEM access.
-register!(NV_PFALCON_FALCON_IMEMC @ PFalconBase[0x00000180[4; 16]] {
-    15:0      offs as u16, "IMEM block and word offset";
-    24:24     aincw as bool, "Auto-increment on write";
-    28:28     secure as bool, "Access secure IMEM";
-});
-
-// IMEM data register. Reading/writing this register accesses IMEM at the address
-// specified by the corresponding IMEMC register.
-register!(NV_PFALCON_FALCON_IMEMD @ PFalconBase[0x00000184[4; 16]] {
-    31:0      data as u32;
-});
-
-// IMEM tag register. Used to set the tag for the current IMEM block.
-register!(NV_PFALCON_FALCON_IMEMT @ PFalconBase[0x00000188[4; 16]] {
-    15:0      tag as u16;
-});
-
-// DMEM access control register. Up to 8 ports are available for DMEM access.
-register!(NV_PFALCON_FALCON_DMEMC @ PFalconBase[0x000001c0[8; 8]] {
-    15:0      offs as u16, "DMEM block and word offset";
-    24:24     aincw as bool, "Auto-increment on write";
-});
-
-// DMEM data register. Reading/writing this register accesses DMEM at the address
-// specified by the corresponding DMEMC register.
-register!(NV_PFALCON_FALCON_DMEMD @ PFalconBase[0x000001c4[8; 8]] {
-    31:0      data as u32;
-});
-
-// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the falcon
-// instance.
-register!(NV_PFALCON_FALCON_ENGINE @ PFalconBase[0x000003c0] {
-    0:0     reset as bool;
-});
-
 impl NV_PFALCON_FALCON_ENGINE {
     /// Resets the falcon
     pub(crate) fn reset_engine<E: FalconEngine>(bar: &Bar0) {
-        Self::read(bar, &E::ID).set_reset(true).write(bar, &E::ID);
+        bar.update(Self::of::<E>(), |r| r.with_reset(true));
 
         // TIMEOUT: falcon engine should not take more than 10us to reset.
         time::delay::fsleep(time::Delta::from_micros(10));
 
-        Self::read(bar, &E::ID).set_reset(false).write(bar, &E::ID);
+        bar.update(Self::of::<E>(), |r| r.with_reset(false));
     }
 }
 
-register!(NV_PFALCON_FBIF_TRANSCFG @ PFalconBase[0x00000600[8]] {
-    1:0     target as u8 ?=> FalconFbifTarget;
-    2:2     mem_type as bool => FalconFbifMemType;
-});
-
-register!(NV_PFALCON_FBIF_CTL @ PFalconBase[0x00000624] {
-    7:7     allow_phys_no_ctx as bool;
-});
+impl NV_PFALCON_FALCON_HWCFG2 {
+    /// Returns `true` if memory scrubbing is completed.
+    pub(crate) fn mem_scrubbing_done(self) -> bool {
+        !self.mem_scrubbing()
+    }
+}
 
 /* PFALCON2 */
 
-register!(NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base[0x00000180] {
-    7:0     algo as u8 ?=> FalconModSelAlgo;
-});
+io::register! {
+    pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
+        7:0     algo ?=> FalconModSelAlgo;
+    }
 
-register!(NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base[0x00000198] {
-    7:0    ucode_id as u8;
-});
+    pub(crate) NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID(u32) @ PFalcon2Base + 0x00000198 {
+        7:0    ucode_id => u8;
+    }
 
-register!(NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base[0x0000019c] {
-    31:0    value as u32;
-});
+    pub(crate) NV_PFALCON2_FALCON_BROM_ENGIDMASK(u32) @ PFalcon2Base + 0x0000019c {
+        31:0    value => u32;
+    }
 
-// OpenRM defines this as a register array, but doesn't specify its size and only uses its first
-// element. Be conservative until we know the actual size or need to use more registers.
-register!(NV_PFALCON2_FALCON_BROM_PARAADDR @ PFalcon2Base[0x00000210[1]] {
-    31:0    value as u32;
-});
+    /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
+    /// first element. Be conservative until we know the actual size or need to use more registers.
+    pub(crate) NV_PFALCON2_FALCON_BROM_PARAADDR(u32)[1] @ PFalcon2Base + 0x00000210 {
+        31:0    value => u32;
+    }
+}
 
 // PRISCV
 
-// RISC-V status register for debug (Turing and GA100 only).
-// Reflects current RISC-V core status.
-register!(NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS @ PFalcon2Base[0x00000240] {
-    0:0     active_stat as bool, "RISC-V core active/inactive status";
-});
+io::register! {
+    /// RISC-V status register for debug (Turing and GA100 only).
+    /// Reflects current RISC-V core status.
+    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
+        /// RISC-V core active/inactive status.
+        0:0     active_stat => bool;
+    }
 
-// GA102 and later
-register!(NV_PRISCV_RISCV_CPUCTL @ PFalcon2Base[0x00000388] {
-    0:0     halted as bool;
-    7:7     active_stat as bool;
-});
+    /// GA102 and later.
+    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ PFalcon2Base + 0x00000388 {
+        7:7     active_stat => bool;
+        0:0     halted => bool;
+    }
 
-register!(NV_PRISCV_RISCV_BCR_CTRL @ PFalcon2Base[0x00000668] {
-    0:0     valid as bool;
-    4:4     core_select as bool => PeregrineCoreSelect;
-    8:8     br_fetch as bool;
-});
+    /// GA102 and later.
+    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ PFalcon2Base + 0x00000668 {
+        8:8     br_fetch => bool;
+        4:4     core_select => PeregrineCoreSelect;
+        0:0     valid => bool;
+    }
+}
 
 // The modules below provide registers that are not identical on all supported chips. They should
 // only be used in HAL modules.
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
deleted file mode 100644
index ed624be1f39b..000000000000
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ /dev/null
@@ -1,739 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! `register!` macro to define register layout and accessors.
-//!
-//! A single register typically includes several fields, which are accessed through a combination
-//! of bit-shift and mask operations that introduce a class of potential mistakes, notably because
-//! not all possible field values are necessarily valid.
-//!
-//! The `register!` macro in this module provides an intuitive and readable syntax for defining a
-//! dedicated type for each register. Each such type comes with its own field accessors that can
-//! return an error if a field's value is invalid. Please look at the [`bitfield`] macro for the
-//! complete syntax of fields definitions.
-
-/// Trait providing a base address to be added to the offset of a relative register to obtain
-/// its actual offset.
-///
-/// The `T` generic argument is used to distinguish which base to use, in case a type provides
-/// several bases. It is given to the `register!` macro to restrict the use of the register to
-/// implementors of this particular variant.
-pub(crate) trait RegisterBase<T> {
-    const BASE: usize;
-}
-
-/// Defines a dedicated type for a register with an absolute offset, including getter and setter
-/// methods for its fields and methods to read and write it from an `Io` region.
-///
-/// Example:
-///
-/// ```no_run
-/// register!(BOOT_0 @ 0x00000100, "Basic revision information about the GPU" {
-///    3:0     minor_revision as u8, "Minor revision of the chip";
-///    7:4     major_revision as u8, "Major revision of the chip";
-///    28:20   chipset as u32 ?=> Chipset, "Chipset model";
-/// });
-/// ```
-///
-/// This defines a `BOOT_0` type which can be read or written from offset `0x100` of an `Io`
-/// region. It is composed of 3 fields, for instance `minor_revision` is made of the 4 least
-/// significant bits of the register. Each field can be accessed and modified using accessor
-/// methods:
-///
-/// ```no_run
-/// // Read from the register's defined offset (0x100).
-/// let boot0 = BOOT_0::read(&bar);
-/// pr_info!("chip revision: {}.{}", boot0.major_revision(), boot0.minor_revision());
-///
-/// // `Chipset::try_from` is called with the value of the `chipset` field and returns an
-/// // error if it is invalid.
-/// let chipset = boot0.chipset()?;
-///
-/// // Update some fields and write the value back.
-/// boot0.set_major_revision(3).set_minor_revision(10).write(&bar);
-///
-/// // Or, just read and update the register in a single step:
-/// BOOT_0::update(&bar, |r| r.set_major_revision(3).set_minor_revision(10));
-/// ```
-///
-/// The documentation strings are optional. If present, they will be added to the type's
-/// definition, or the field getter and setter methods they are attached to.
-///
-/// It is also possible to create a alias register by using the `=> ALIAS` syntax. This is useful
-/// for cases where a register's interpretation depends on the context:
-///
-/// ```no_run
-/// register!(SCRATCH @ 0x00000200, "Scratch register" {
-///    31:0     value as u32, "Raw value";
-/// });
-///
-/// register!(SCRATCH_BOOT_STATUS => SCRATCH, "Boot status of the firmware" {
-///     0:0     completed as bool, "Whether the firmware has completed booting";
-/// });
-/// ```
-///
-/// In this example, `SCRATCH_0_BOOT_STATUS` uses the same I/O address as `SCRATCH`, while also
-/// providing its own `completed` field.
-///
-/// ## Relative registers
-///
-/// A register can be defined as being accessible from a fixed offset of a provided base. For
-/// instance, imagine the following I/O space:
-///
-/// ```text
-///           +-----------------------------+
-///           |             ...             |
-///           |                             |
-///  0x100--->+------------CPU0-------------+
-///           |                             |
-///  0x110--->+-----------------------------+
-///           |           CPU_CTL           |
-///           +-----------------------------+
-///           |             ...             |
-///           |                             |
-///           |                             |
-///  0x200--->+------------CPU1-------------+
-///           |                             |
-///  0x210--->+-----------------------------+
-///           |           CPU_CTL           |
-///           +-----------------------------+
-///           |             ...             |
-///           +-----------------------------+
-/// ```
-///
-/// `CPU0` and `CPU1` both have a `CPU_CTL` register that starts at offset `0x10` of their I/O
-/// space segment. Since both instances of `CPU_CTL` share the same layout, we don't want to define
-/// them twice and would prefer a way to select which one to use from a single definition
-///
-/// This can be done using the `Base[Offset]` syntax when specifying the register's address.
-///
-/// `Base` is an arbitrary type (typically a ZST) to be used as a generic parameter of the
-/// [`RegisterBase`] trait to provide the base as a constant, i.e. each type providing a base for
-/// this register needs to implement `RegisterBase<Base>`. Here is the above example translated
-/// into code:
-///
-/// ```no_run
-/// // Type used to identify the base.
-/// pub(crate) struct CpuCtlBase;
-///
-/// // ZST describing `CPU0`.
-/// struct Cpu0;
-/// impl RegisterBase<CpuCtlBase> for Cpu0 {
-///     const BASE: usize = 0x100;
-/// }
-/// // Singleton of `CPU0` used to identify it.
-/// const CPU0: Cpu0 = Cpu0;
-///
-/// // ZST describing `CPU1`.
-/// struct Cpu1;
-/// impl RegisterBase<CpuCtlBase> for Cpu1 {
-///     const BASE: usize = 0x200;
-/// }
-/// // Singleton of `CPU1` used to identify it.
-/// const CPU1: Cpu1 = Cpu1;
-///
-/// // This makes `CPU_CTL` accessible from all implementors of `RegisterBase<CpuCtlBase>`.
-/// register!(CPU_CTL @ CpuCtlBase[0x10], "CPU core control" {
-///     0:0     start as bool, "Start the CPU core";
-/// });
-///
-/// // The `read`, `write` and `update` methods of relative registers take an extra `base` argument
-/// // that is used to resolve its final address by adding its `BASE` to the offset of the
-/// // register.
-///
-/// // Start `CPU0`.
-/// CPU_CTL::update(bar, &CPU0, |r| r.set_start(true));
-///
-/// // Start `CPU1`.
-/// CPU_CTL::update(bar, &CPU1, |r| r.set_start(true));
-///
-/// // Aliases can also be defined for relative register.
-/// register!(CPU_CTL_ALIAS => CpuCtlBase[CPU_CTL], "Alias to CPU core control" {
-///     1:1     alias_start as bool, "Start the aliased CPU core";
-/// });
-///
-/// // Start the aliased `CPU0`.
-/// CPU_CTL_ALIAS::update(bar, &CPU0, |r| r.set_alias_start(true));
-/// ```
-///
-/// ## Arrays of registers
-///
-/// Some I/O areas contain consecutive values that can be interpreted in the same way. These areas
-/// can be defined as an array of identical registers, allowing them to be accessed by index with
-/// compile-time or runtime bound checking. Simply define their address as `Address[Size]`, and add
-/// an `idx` parameter to their `read`, `write` and `update` methods:
-///
-/// ```no_run
-/// # fn no_run() -> Result<(), Error> {
-/// # fn get_scratch_idx() -> usize {
-/// #   0x15
-/// # }
-/// // Array of 64 consecutive registers with the same layout starting at offset `0x80`.
-/// register!(SCRATCH @ 0x00000080[64], "Scratch registers" {
-///     31:0    value as u32;
-/// });
-///
-/// // Read scratch register 0, i.e. I/O address `0x80`.
-/// let scratch_0 = SCRATCH::read(bar, 0).value();
-/// // Read scratch register 15, i.e. I/O address `0x80 + (15 * 4)`.
-/// let scratch_15 = SCRATCH::read(bar, 15).value();
-///
-/// // This is out of bounds and won't build.
-/// // let scratch_128 = SCRATCH::read(bar, 128).value();
-///
-/// // Runtime-obtained array index.
-/// let scratch_idx = get_scratch_idx();
-/// // Access on a runtime index returns an error if it is out-of-bounds.
-/// let some_scratch = SCRATCH::try_read(bar, scratch_idx)?.value();
-///
-/// // Alias to a particular register in an array.
-/// // Here `SCRATCH[8]` is used to convey the firmware exit code.
-/// register!(FIRMWARE_STATUS => SCRATCH[8], "Firmware exit status code" {
-///     7:0     status as u8;
-/// });
-///
-/// let status = FIRMWARE_STATUS::read(bar).status();
-///
-/// // Non-contiguous register arrays can be defined by adding a stride parameter.
-/// // Here, each of the 16 registers of the array are separated by 8 bytes, meaning that the
-/// // registers of the two declarations below are interleaved.
-/// register!(SCRATCH_INTERLEAVED_0 @ 0x000000c0[16 ; 8], "Scratch registers bank 0" {
-///     31:0    value as u32;
-/// });
-/// register!(SCRATCH_INTERLEAVED_1 @ 0x000000c4[16 ; 8], "Scratch registers bank 1" {
-///     31:0    value as u32;
-/// });
-/// # Ok(())
-/// # }
-/// ```
-///
-/// ## Relative arrays of registers
-///
-/// Combining the two features described in the sections above, arrays of registers accessible from
-/// a base can also be defined:
-///
-/// ```no_run
-/// # fn no_run() -> Result<(), Error> {
-/// # fn get_scratch_idx() -> usize {
-/// #   0x15
-/// # }
-/// // Type used as parameter of `RegisterBase` to specify the base.
-/// pub(crate) struct CpuCtlBase;
-///
-/// // ZST describing `CPU0`.
-/// struct Cpu0;
-/// impl RegisterBase<CpuCtlBase> for Cpu0 {
-///     const BASE: usize = 0x100;
-/// }
-/// // Singleton of `CPU0` used to identify it.
-/// const CPU0: Cpu0 = Cpu0;
-///
-/// // ZST describing `CPU1`.
-/// struct Cpu1;
-/// impl RegisterBase<CpuCtlBase> for Cpu1 {
-///     const BASE: usize = 0x200;
-/// }
-/// // Singleton of `CPU1` used to identify it.
-/// const CPU1: Cpu1 = Cpu1;
-///
-/// // 64 per-cpu scratch registers, arranged as an contiguous array.
-/// register!(CPU_SCRATCH @ CpuCtlBase[0x00000080[64]], "Per-CPU scratch registers" {
-///     31:0    value as u32;
-/// });
-///
-/// let cpu0_scratch_0 = CPU_SCRATCH::read(bar, &Cpu0, 0).value();
-/// let cpu1_scratch_15 = CPU_SCRATCH::read(bar, &Cpu1, 15).value();
-///
-/// // This won't build.
-/// // let cpu0_scratch_128 = CPU_SCRATCH::read(bar, &Cpu0, 128).value();
-///
-/// // Runtime-obtained array index.
-/// let scratch_idx = get_scratch_idx();
-/// // Access on a runtime value returns an error if it is out-of-bounds.
-/// let cpu0_some_scratch = CPU_SCRATCH::try_read(bar, &Cpu0, scratch_idx)?.value();
-///
-/// // `SCRATCH[8]` is used to convey the firmware exit code.
-/// register!(CPU_FIRMWARE_STATUS => CpuCtlBase[CPU_SCRATCH[8]],
-///     "Per-CPU firmware exit status code" {
-///     7:0     status as u8;
-/// });
-///
-/// let cpu0_status = CPU_FIRMWARE_STATUS::read(bar, &Cpu0).status();
-///
-/// // Non-contiguous register arrays can be defined by adding a stride parameter.
-/// // Here, each of the 16 registers of the array are separated by 8 bytes, meaning that the
-/// // registers of the two declarations below are interleaved.
-/// register!(CPU_SCRATCH_INTERLEAVED_0 @ CpuCtlBase[0x00000d00[16 ; 8]],
-///           "Scratch registers bank 0" {
-///     31:0    value as u32;
-/// });
-/// register!(CPU_SCRATCH_INTERLEAVED_1 @ CpuCtlBase[0x00000d04[16 ; 8]],
-///           "Scratch registers bank 1" {
-///     31:0    value as u32;
-/// });
-/// # Ok(())
-/// # }
-/// ```
-macro_rules! register {
-    // Creates a register at a fixed offset of the MMIO space.
-    ($name:ident @ $offset:literal $(, $comment:literal)? { $($fields:tt)* } ) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_fixed $name @ $offset);
-    };
-
-    // Creates an alias register of fixed offset register `alias` with its own fields.
-    ($name:ident => $alias:ident $(, $comment:literal)? { $($fields:tt)* } ) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_fixed $name @ $alias::OFFSET);
-    };
-
-    // Creates a register at a relative offset from a base address provider.
-    ($name:ident @ $base:ty [ $offset:literal ] $(, $comment:literal)? { $($fields:tt)* } ) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_relative $name @ $base [ $offset ]);
-    };
-
-    // Creates an alias register of relative offset register `alias` with its own fields.
-    ($name:ident => $base:ty [ $alias:ident ] $(, $comment:literal)? { $($fields:tt)* }) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_relative $name @ $base [ $alias::OFFSET ]);
-    };
-
-    // Creates an array of registers at a fixed offset of the MMIO space.
-    (
-        $name:ident @ $offset:literal [ $size:expr ; $stride:expr ] $(, $comment:literal)? {
-            $($fields:tt)*
-        }
-    ) => {
-        static_assert!(::core::mem::size_of::<u32>() <= $stride);
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_array $name @ $offset [ $size ; $stride ]);
-    };
-
-    // Shortcut for contiguous array of registers (stride == size of element).
-    (
-        $name:ident @ $offset:literal [ $size:expr ] $(, $comment:literal)? {
-            $($fields:tt)*
-        }
-    ) => {
-        register!($name @ $offset [ $size ; ::core::mem::size_of::<u32>() ] $(, $comment)? {
-            $($fields)*
-        } );
-    };
-
-    // Creates an array of registers at a relative offset from a base address provider.
-    (
-        $name:ident @ $base:ty [ $offset:literal [ $size:expr ; $stride:expr ] ]
-            $(, $comment:literal)? { $($fields:tt)* }
-    ) => {
-        static_assert!(::core::mem::size_of::<u32>() <= $stride);
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_relative_array $name @ $base [ $offset [ $size ; $stride ] ]);
-    };
-
-    // Shortcut for contiguous array of relative registers (stride == size of element).
-    (
-        $name:ident @ $base:ty [ $offset:literal [ $size:expr ] ] $(, $comment:literal)? {
-            $($fields:tt)*
-        }
-    ) => {
-        register!($name @ $base [ $offset [ $size ; ::core::mem::size_of::<u32>() ] ]
-            $(, $comment)? { $($fields)* } );
-    };
-
-    // Creates an alias of register `idx` of relative array of registers `alias` with its own
-    // fields.
-    (
-        $name:ident => $base:ty [ $alias:ident [ $idx:expr ] ] $(, $comment:literal)? {
-            $($fields:tt)*
-        }
-    ) => {
-        static_assert!($idx < $alias::SIZE);
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_relative $name @ $base [ $alias::OFFSET + $idx * $alias::STRIDE ] );
-    };
-
-    // Creates an alias of register `idx` of array of registers `alias` with its own fields.
-    // This rule belongs to the (non-relative) register arrays set, but needs to be put last
-    // to avoid it being interpreted in place of the relative register array alias rule.
-    ($name:ident => $alias:ident [ $idx:expr ] $(, $comment:literal)? { $($fields:tt)* }) => {
-        static_assert!($idx < $alias::SIZE);
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_fixed $name @ $alias::OFFSET + $idx * $alias::STRIDE );
-    };
-
-    // Generates the IO accessors for a fixed offset register.
-    (@io_fixed $name:ident @ $offset:expr) => {
-        #[allow(dead_code)]
-        impl $name {
-            pub(crate) const OFFSET: usize = $offset;
-
-            /// Read the register from its address in `io`.
-            #[inline(always)]
-            pub(crate) fn read<T, I>(io: &T) -> Self where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                Self(io.read32($offset))
-            }
-
-            /// Write the value contained in `self` to the register address in `io`.
-            #[inline(always)]
-            pub(crate) fn write<T, I>(self, io: &T) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                io.write32(self.0, $offset)
-            }
-
-            /// Read the register from its address in `io` and run `f` on its value to obtain a new
-            /// value to write back.
-            #[inline(always)]
-            pub(crate) fn update<T, I, F>(
-                io: &T,
-                f: F,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                let reg = f(Self::read(io));
-                reg.write(io);
-            }
-        }
-    };
-
-    // Generates the IO accessors for a relative offset register.
-    (@io_relative $name:ident @ $base:ty [ $offset:expr ]) => {
-        #[allow(dead_code)]
-        impl $name {
-            pub(crate) const OFFSET: usize = $offset;
-
-            /// Read the register from `io`, using the base address provided by `base` and adding
-            /// the register's offset to it.
-            #[inline(always)]
-            pub(crate) fn read<T, I, B>(
-                io: &T,
-                #[allow(unused_variables)]
-                base: &B,
-            ) -> Self where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                const OFFSET: usize = $name::OFFSET;
-
-                let value = io.read32(
-                    <B as crate::regs::macros::RegisterBase<$base>>::BASE + OFFSET
-                );
-
-                Self(value)
-            }
-
-            /// Write the value contained in `self` to `io`, using the base address provided by
-            /// `base` and adding the register's offset to it.
-            #[inline(always)]
-            pub(crate) fn write<T, I, B>(
-                self,
-                io: &T,
-                #[allow(unused_variables)]
-                base: &B,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                const OFFSET: usize = $name::OFFSET;
-
-                io.write32(
-                    self.0,
-                    <B as crate::regs::macros::RegisterBase<$base>>::BASE + OFFSET
-                );
-            }
-
-            /// Read the register from `io`, using the base address provided by `base` and adding
-            /// the register's offset to it, then run `f` on its value to obtain a new value to
-            /// write back.
-            #[inline(always)]
-            pub(crate) fn update<T, I, B, F>(
-                io: &T,
-                base: &B,
-                f: F,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                let reg = f(Self::read(io, base));
-                reg.write(io, base);
-            }
-        }
-    };
-
-    // Generates the IO accessors for an array of registers.
-    (@io_array $name:ident @ $offset:literal [ $size:expr ; $stride:expr ]) => {
-        #[allow(dead_code)]
-        impl $name {
-            pub(crate) const OFFSET: usize = $offset;
-            pub(crate) const SIZE: usize = $size;
-            pub(crate) const STRIDE: usize = $stride;
-
-            /// Read the array register at index `idx` from its address in `io`.
-            #[inline(always)]
-            pub(crate) fn read<T, I>(
-                io: &T,
-                idx: usize,
-            ) -> Self where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                build_assert!(idx < Self::SIZE);
-
-                let offset = Self::OFFSET + (idx * Self::STRIDE);
-                let value = io.read32(offset);
-
-                Self(value)
-            }
-
-            /// Write the value contained in `self` to the array register with index `idx` in `io`.
-            #[inline(always)]
-            pub(crate) fn write<T, I>(
-                self,
-                io: &T,
-                idx: usize
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                build_assert!(idx < Self::SIZE);
-
-                let offset = Self::OFFSET + (idx * Self::STRIDE);
-
-                io.write32(self.0, offset);
-            }
-
-            /// Read the array register at index `idx` in `io` and run `f` on its value to obtain a
-            /// new value to write back.
-            #[inline(always)]
-            pub(crate) fn update<T, I, F>(
-                io: &T,
-                idx: usize,
-                f: F,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                let reg = f(Self::read(io, idx));
-                reg.write(io, idx);
-            }
-
-            /// Read the array register at index `idx` from its address in `io`.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_read<T, I>(
-                io: &T,
-                idx: usize,
-            ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                if idx < Self::SIZE {
-                    Ok(Self::read(io, idx))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-
-            /// Write the value contained in `self` to the array register with index `idx` in `io`.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_write<T, I>(
-                self,
-                io: &T,
-                idx: usize,
-            ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                if idx < Self::SIZE {
-                    Ok(self.write(io, idx))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-
-            /// Read the array register at index `idx` in `io` and run `f` on its value to obtain a
-            /// new value to write back.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_update<T, I, F>(
-                io: &T,
-                idx: usize,
-                f: F,
-            ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                if idx < Self::SIZE {
-                    Ok(Self::update(io, idx, f))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-        }
-    };
-
-    // Generates the IO accessors for an array of relative registers.
-    (
-        @io_relative_array $name:ident @ $base:ty
-            [ $offset:literal [ $size:expr ; $stride:expr ] ]
-    ) => {
-        #[allow(dead_code)]
-        impl $name {
-            pub(crate) const OFFSET: usize = $offset;
-            pub(crate) const SIZE: usize = $size;
-            pub(crate) const STRIDE: usize = $stride;
-
-            /// Read the array register at index `idx` from `io`, using the base address provided
-            /// by `base` and adding the register's offset to it.
-            #[inline(always)]
-            pub(crate) fn read<T, I, B>(
-                io: &T,
-                #[allow(unused_variables)]
-                base: &B,
-                idx: usize,
-            ) -> Self where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                build_assert!(idx < Self::SIZE);
-
-                let offset = <B as crate::regs::macros::RegisterBase<$base>>::BASE +
-                    Self::OFFSET + (idx * Self::STRIDE);
-                let value = io.read32(offset);
-
-                Self(value)
-            }
-
-            /// Write the value contained in `self` to `io`, using the base address provided by
-            /// `base` and adding the offset of array register `idx` to it.
-            #[inline(always)]
-            pub(crate) fn write<T, I, B>(
-                self,
-                io: &T,
-                #[allow(unused_variables)]
-                base: &B,
-                idx: usize
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                build_assert!(idx < Self::SIZE);
-
-                let offset = <B as crate::regs::macros::RegisterBase<$base>>::BASE +
-                    Self::OFFSET + (idx * Self::STRIDE);
-
-                io.write32(self.0, offset);
-            }
-
-            /// Read the array register at index `idx` from `io`, using the base address provided
-            /// by `base` and adding the register's offset to it, then run `f` on its value to
-            /// obtain a new value to write back.
-            #[inline(always)]
-            pub(crate) fn update<T, I, B, F>(
-                io: &T,
-                base: &B,
-                idx: usize,
-                f: F,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                let reg = f(Self::read(io, base, idx));
-                reg.write(io, base, idx);
-            }
-
-            /// Read the array register at index `idx` from `io`, using the base address provided
-            /// by `base` and adding the register's offset to it.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_read<T, I, B>(
-                io: &T,
-                base: &B,
-                idx: usize,
-            ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                if idx < Self::SIZE {
-                    Ok(Self::read(io, base, idx))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-
-            /// Write the value contained in `self` to `io`, using the base address provided by
-            /// `base` and adding the offset of array register `idx` to it.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_write<T, I, B>(
-                self,
-                io: &T,
-                base: &B,
-                idx: usize,
-            ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                if idx < Self::SIZE {
-                    Ok(self.write(io, base, idx))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-
-            /// Read the array register at index `idx` from `io`, using the base address provided
-            /// by `base` and adding the register's offset to it, then run `f` on its value to
-            /// obtain a new value to write back.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_update<T, I, B, F>(
-                io: &T,
-                base: &B,
-                idx: usize,
-                f: F,
-            ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                if idx < Self::SIZE {
-                    Ok(Self::update(io, base, idx, f))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-        }
-    };
-}

-- 
2.53.0

