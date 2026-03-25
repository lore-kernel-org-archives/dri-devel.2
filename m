Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D6106B50C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459D510E896;
	Wed, 25 Mar 2026 12:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/Yo6Q/G";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2979510E895
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhKZLNv3NO2bUx7D5FWTfAJby8VPpEn9LLQsEtmMJ4w+AuzaqZo09h18O+fW+70+Tu4sUzVSSSNTyTOeU7LbdV5PLS/kKAilsUS0orVdD5AcLjwHUZAaw3h7ocSgVfgT89s6FiubweCEZmReA5HJqnXOovj0bz1f8/0XH316l2KrK4pp8j84GC86FKEnn5cbnvnTVWDAo+RaeA5QDITusNJb3MScymxrN6LXCo0Bfs2VfYswcxDC0XI0LBLCEKi8+QDj0q1XicRfEpMM+VyI7hBZdpS0lX2xj/DmjNVg8pY1YsOEOXWq1YH1SWXgh5Sa36CgiArjUhxC33DW2GPLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fiWpj5+EcbEQvD+iFSp51aqmCk0SqRXqdleZFjLSOU=;
 b=LEq2xm7BLQFhNt75d0wHwJRF02Sk6bz1tUgbP+i29Aw6pSSI5xYsqXlZlr0U663slUKkWGHc+DNCdnZRlseM1Fe1N3nzXDnaEkBzOM5pR9A7mLzlVeMxvHXyieTDH2KXGC1OtXUIAbKEQwr2KSluqDTMGTIO6tKGeBFl452CrG/0NSnIAdXUxhTWUxgYT1+3A7U1aCxMoeONNa8+/7bnakmgli2EcPpxb9biT3BpMWMOObIbRn1M4R9IOEba+1YcE4bOaeP0XB4q+sokRXUdODYZ6IE15LaMi2HNU9iYpAQpqwhqDFpqXHx32j2GmY7MJLNTO45QVNP05SXIgbLBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fiWpj5+EcbEQvD+iFSp51aqmCk0SqRXqdleZFjLSOU=;
 b=B/Yo6Q/G2Uq90orxSq9J5xmco6VTwncQBCjwyh99GlA/GBP6eQzCjRBB3XuIUGaQPp+sVKVcjWLnyRfhtJ14XON5V0ooVfJ+FgBg4TQMYkWJgYtpAPH9aIN11Yc0i0c6ch0uhBudO3PGvpcGpI+zcuxv3KR7SuNiB6cHjSa2olEtmA06XlpQIX5jLvMyDrG+vrBoqFZrYrzMgnyZFn8oJ6zl0Do7Sskx7sg3Ob6YmOnUKJjn71oVDnB1iSWHk9K2JUhR0kVYkpoK0o2ntv5NN9TMCl70yBL8LZgcYr9NQpzonzh8lj6n9M8g0NN1FNTG6FYNzEmJofjbp97HqL+z8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:14:07 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:14:07 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:43 +0900
Subject: [PATCH v3 5/9] gpu: nova-core: gsp: add types for RM control RPCs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-5-f3101093484e@nvidia.com>
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TY4P301CA0092.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: c55653ed-d02d-44e0-e9dc-08de8a680381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gQwm3GVfQTMjDibxBtXNLnM8d4BEyR1CMou0yvA7isLuwVCQzG9fbZAb7sZ0JgkWwmoH9n3loCuzjxW78WPJEdasSQyFqdpR6rOqJ0ed6IDgphoch9uV5GoK/BLLuage585ZiZTDE9UK4fZ5kr+R97BC/1ihqU2ER0fPEi1xbctBoW0xRAxOVJMvZ/jSTaK8L0P3reZmDqX1hcVBlr0LWxrQVN98/YLGlIFGS/mDLnLeaL5EBEmKSuDXOLXfCQEFsVAaWy/1aw25KUogjdLQ4l29QD7U4Dmk2YqtkUxMngfXN0SOwgXipLN3NTKf9nMluUNuKuURr7tZSW+Fme3orRs49XC+hpFx0+PRpdjYfNOy05OAPlP2aTEDSU7mHKPl+kp8ruMdyWpgAYqRYkePtSY01ACd06otS4Uo+BtoNnPHw1MbIzlFQnkFDNVYWCds7ZkA+Nr4qU0IjKwva9ieLV66ApsesmyPLnrt3yd71FzWTB9QqNtZLuhz528c7SVEw/GlId/+eivShSFBvLs8KWnsOU9x6M8+Ac8I+VDqBc7KugGbbpQamVrmeayFBxFjSAAvqBwVuEYh6iqdO5YSBcw8akxM2JmGdlVoCNTflgcFLlEzuTRktH/MEkHzJsu5qat6z0wiH6mOJ/wA4ZCrA377n5iCS+qNuKidNIWkGHVJxrwhJ48sk02hzBO+7NZr7XsHkWoUbR4+GFw6dSpBhN1GhzCs/y87h5vy9m5NpLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZKcUx3UEdtQVFwSEtoQXd6YWt5TjFlQllETFN2NHdwUGpBRXVDVE9YMFpl?=
 =?utf-8?B?cExrZGxEZDE4TkVvRE9jeWhxcTdxejZmTkFMUzFKdncvS3JmSFBmRytRRmdH?=
 =?utf-8?B?OGFKVnFmYjdJelFOQlpVY0RXR2hNRWYzUUpMSXJlc21QTWJnZ3JuZEFxcFV5?=
 =?utf-8?B?aytHNkRDWVBKZlU2YTN2bmp1SnpHc1cydVRaM01wT0t5YS9adCtNMmdTczl6?=
 =?utf-8?B?eGJZVVZtcTVDNzFMSXVNWWdKWDZLYlNVNVdodnFRMlByVC9aUTh5RFRMelRt?=
 =?utf-8?B?MU5GbzNpdXM0SUphQ0hHWFI2bEt6dWVPUEpZQk5hOE9oTlFES1lVUEs5OVNB?=
 =?utf-8?B?NGdpeVRLdnVONVdiU21NaWF2M2g3blRreU5yMHIzVHc0SDNIWmZrVXRRNDdC?=
 =?utf-8?B?RWZwemVxeWFBRUxKRitjaGpsUXRIbWlGZkZRUi9YNFI2T2RiSHB1MU1ucEhu?=
 =?utf-8?B?SU56TXRtdmQ4aWdKVlFwRllwSkhWRzErQk5Dbm90ZjU5OEwxeFVyV2F4UW1s?=
 =?utf-8?B?Wkl2eWN6YnhTeTFyS1ZxZ1FUMFRJVXhyVzI1SmZIK09uMmxWZWY5SlBqcmhQ?=
 =?utf-8?B?REFFeXQrUWVoUzRIa0xkUTNoSC9rSEk0NHBnL1JXQlQ3bXNKQlBZRnRoUzI0?=
 =?utf-8?B?RjJyQllwU2I1LzJ1QWE5cGsxNnR5MklCQnllOENzNllvSkFkaGRldGIvTzhR?=
 =?utf-8?B?bzNLWDByc1RodHJYbk8xMWltZnA0SEJSZWlrOVlGc21pYjRGZkhmZTkyZnd6?=
 =?utf-8?B?WlZkU2JybTdLaWN3cDN5VzVrSXdVYU5XRUNnaW9qYktQL3dINm14b2dJSHJt?=
 =?utf-8?B?aEtoT0o5WTZlTFdkTEtNNzluVko1RktFWjFJMzgydnNjMTBhdTJNUHZpWXAz?=
 =?utf-8?B?dGxUVENkaEY2aW5EdGIzeWRuc0xUWTVPS3BMVDBNdW4yc2t2Vlp2aFlMTFhq?=
 =?utf-8?B?Y2kzNEhFVHB6dVVTaUd5V21SVnN5QU1oNHVuMW5BUlRMbEI3S2N3ZDdoV2x1?=
 =?utf-8?B?Zk1BazJUMk5SYkV4bEpBZUVPZWR5M1FmdGFTVk0rWkV5a0JGOWhXSzRSNnA0?=
 =?utf-8?B?bGt5eGVsTlJrc2k3cnJMa1V2cVFTYmJFbitHeTRzd1N4emtGSnZiR3JOdlM5?=
 =?utf-8?B?M0FKUElzVVU5b1FlZTdXS3V0Zkt2ZktOV3VpV2lFTUVrY3dtQzlMcjdYTmYw?=
 =?utf-8?B?a0NSSko0L1hTcFRlMm0zTVMrS2l3ZXF2aUN6cFZUSjVmTEZGQ2EvK0RaRisx?=
 =?utf-8?B?NlNML0FUQWJuaDY2aVNSTHduTVdwV21qZXdKWm9aTEpSSVd6ZXdhYWIxNSt0?=
 =?utf-8?B?QmErYUk0dXB4NXZNQ1I1UTVob0pOSzNzeDNFMVI0SVdhSG9KdmlJV3d4ZWFG?=
 =?utf-8?B?SEpRQ3ZhRG1vQlVyYXY2b1ZzVzVxRmlWYndNWnA3cnJVNGRIbG16aSs3R0Vr?=
 =?utf-8?B?K2xETS9BKzNJTkNmRWVXL3BFVzNnMEtORFV4TWorcWNUNFBmZHVtaFRmbEM5?=
 =?utf-8?B?MXdlalNHa0MxVVdRYkNJUlpzM2ppS2xWWHEyZU8va1B4Q2VqVjFpV000Smw5?=
 =?utf-8?B?UXJtcEQwRm1SbXJnaElEN0FsazhyZE5pUGtzeld3TzV2d091emNoU0h6OVRy?=
 =?utf-8?B?NjlLUkdaTkVUM0tpeXhQV2JDYlpsbkw3OVJtVjBucFhvUDFZeEM2ZzZCbnVL?=
 =?utf-8?B?WHRSMHpodXhnam9hKzl6ME9TbEo1cWUyVzJWb1FTYU1TaTBOczBvaXljeXpZ?=
 =?utf-8?B?Q25uY2dzVVh2WnFmUXlzaEFmR2RERjNCRzhHdFRCcE9WblpCRXBGaXdKRGFP?=
 =?utf-8?B?T2hWU1I0bWgrdjdXS21ON1FMVCttTUI5N2hOREhrcit3S2taMWl1UFU2cWJI?=
 =?utf-8?B?Q1orRnRUNGxQeGxJWWE2eHdPSDV4aUw1bHdzNEtCaHJQNUJoNlpwUjZ0R2dQ?=
 =?utf-8?B?R1lEY0RhQ3RxZm5mU0hKclNTL2xIcWFkYm1ld1BoU1g3NjhySHRPdUJZL1pO?=
 =?utf-8?B?b1l3SlBTMkNYMHVZcWp5YjROaWVKZjdNL0orOVlzdEZYbnNOMGJudTB3QkRL?=
 =?utf-8?B?Rmg3ZGhhTjNINXB2b1JvaDN0am1xL2hoQ1pFWHN2TENoTDZhaEp2ZkdDNUV4?=
 =?utf-8?B?bThCazl1M1FGUDNzdENxMFhFazJPR2ZSbzJlbE0wbXo1Wis3aXZMMWNVcWFz?=
 =?utf-8?B?aUo1NHRqdG1DbnlTbldkWkxXWkNtSzJ6Wk5DODIxNnJhRnVId2F1UmlycE44?=
 =?utf-8?B?WnJrcmI1TlVPUlltQkdlTUdiVHBoei9lVWpacDBNQkU5OXovYkdWbWZiT1Mw?=
 =?utf-8?B?aHQ4NWxlYnBPaERBZzFiSlJSMm43V2VmNkNEenV3d2tBZ1B1T0FLUzAwYld4?=
 =?utf-8?Q?vdLIRMc388vW2QpLmSyMY60p8ooxEHTXdohdIwlkPzdkn?=
X-MS-Exchange-AntiSpam-MessageData-1: zdjzdf1nA9QdVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55653ed-d02d-44e0-e9dc-08de8a680381
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:14:07.4289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCtee/cOqCS64J+q3YwC5TOzc3mnAlBqazzo9yjCHaGST1xWYKMGkBICnR+gP55VrJ0Gq4Da1HxgdQGl6uW8cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

Add `RmControlMsgFunction` which mirrors `MsgFunction` in fw.rs. This
denotes the type of RM control RPC. For now it contains a single
discriminant only (which will be used later), which is needed to prevent
compile errors when using an otherwise empty enum.

Add `GspRmControl` which wraps the RM control RPC structure from the
bindings.

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs             |  1 -
 drivers/gpu/nova-core/gsp/fw.rs                   |  1 +
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs |  1 +
 drivers/gpu/nova-core/gsp/fw/rm.rs                | 88 +++++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index f3566f3ea6a7..8c9599aa227b 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -77,7 +77,6 @@ pub(crate) fn new(raw: u32) -> Self {
     }
 
     /// Returns the raw handle value.
-    #[expect(dead_code)]
     pub(crate) fn as_raw(self) -> u32 {
         self.0
     }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index cb4bda253193..bee7169fd4ae 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -2,6 +2,7 @@
 
 pub(crate) mod commands;
 mod r570_144;
+pub(crate) mod rm;
 
 // Alias to avoid repeating the version number with every use.
 use r570_144 as bindings;
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 05e205e6dc58..ece31cc32f5b 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -44,6 +44,7 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
 pub const GSP_FW_WPR_META_MAGIC: i64 = -2577556379034558285;
 pub const REGISTRY_TABLE_ENTRY_TYPE_DWORD: u32 = 1;
 pub const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: u32 = 65536;
+pub const NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE: u32 = 545270280;
 pub type __u8 = ffi::c_uchar;
 pub type __u16 = ffi::c_ushort;
 pub type __u32 = ffi::c_uint;
diff --git a/drivers/gpu/nova-core/gsp/fw/rm.rs b/drivers/gpu/nova-core/gsp/fw/rm.rs
new file mode 100644
index 000000000000..4a4f97d88ecf
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/fw/rm.rs
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    prelude::*,
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    }, //
+};
+
+use crate::gsp::commands::{
+    Client,
+    Handle, //
+};
+
+use super::{
+    bindings,
+    NvStatus, //
+};
+
+/// Command code for RM control RPCs sent using [`MsgFunction::GspRmControl`].
+#[derive(Copy, Clone, Debug, PartialEq)]
+#[repr(u32)]
+pub(crate) enum RmControlMsgFunction {
+    /// Get the CE fault method buffer size.
+    CeGetFaultMethodBufferSize = bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE,
+}
+
+// TODO[FPRI]: replace with 'FromPrimitive'.
+impl TryFrom<u32> for RmControlMsgFunction {
+    type Error = kernel::error::Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            bindings::NV2080_CTRL_CMD_CE_GET_FAULT_METHOD_BUFFER_SIZE => {
+                Ok(Self::CeGetFaultMethodBufferSize)
+            }
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<RmControlMsgFunction> for u32 {
+    fn from(value: RmControlMsgFunction) -> Self {
+        // CAST: `RmControlMsgFunction` is `repr(u32)` and can thus be cast losslessly.
+        value as u32
+    }
+}
+
+/// RM control message element structure.
+#[repr(transparent)]
+pub(crate) struct GspRmControl {
+    inner: bindings::rpc_gsp_rm_control_v03_00,
+}
+
+#[expect(dead_code)]
+impl GspRmControl {
+    /// Creates a new RM control command.
+    pub(crate) fn new<T>(
+        client: Handle<Client>,
+        object: Handle<T>,
+        cmd: RmControlMsgFunction,
+        params_size: u32,
+    ) -> Self {
+        Self {
+            inner: bindings::rpc_gsp_rm_control_v03_00 {
+                hClient: client.as_raw(),
+                hObject: object.as_raw(),
+                cmd: u32::from(cmd),
+                status: 0,
+                paramsSize: params_size,
+                flags: 0,
+                params: Default::default(),
+            },
+        }
+    }
+
+    /// Returns the status from the RM control response.
+    pub(crate) fn status(&self) -> NvStatus {
+        NvStatus::from(self.inner.status)
+    }
+}
+
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for GspRmControl {}
+
+// SAFETY: This struct contains no padding.
+unsafe impl AsBytes for GspRmControl {}

-- 
2.53.0

