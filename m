Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08927103E19B
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D4010E7D5;
	Thu, 19 Mar 2026 06:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nP4AAYne";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9293710E7D5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcEd+FOujuW80iQ59xV9NbRZwzG9upEPxgxE28eW16hMoEHGvJuhIEB5w2vfQONVWEyXgDbAqro1aLpxumE/uLGYs6YznC1nSELpTkm7NHJmWVbAdM3BbcZ9KGiuk+DBg17uU9u9FhfBSNrUMPPpBxJCK/Lf5vNJzYijnpilQOwynuTDFrDqVBXBBRkwDoWWn9ocitTGeXF7KyJJVOgi9uFTIlHUGmmhvpCS1Aapagtv6xXTp7A5J6vwrjnmESQuOVJQV9EyCmdfZsi0k31lIfS/kBPtpjIiuDEkcKsOAv4OmHeMc/GLDbwYdYZN7VK7i56MsiCMYTJSGC+AUv633Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eoF4VlgXd7+YqbsJ0UUroCML5MflKD812vW5seUYFA=;
 b=sxQmqDqPbkZ2OwkLenyZb/0ZQ/Gt5GsuEc6rd6ZG8avuk/0L0vtVbC370BKMU0GIPjCkwJWnYY4RvkleMFW+RbChIwkjd9BHnCi8M/YgmsobFMukHfDSQW4T+vI2iu/EPqoXGHHx9AUc03wr+i3Zi0qVyMbFDaXB2ThNbxvOlUwJYrjFvxhrM4ct+TbhHFJZnZPHyeWyyOiu+lNvhcGpmrI7RyoU43zzZjeULcd5o/PegEgqwRwrSHmfLpOu5xt8BIbBzx7j6jY/JMcnXEH9YW5iGfEAjHJPtjRz2nKFtyvh1YSUNu8j2PVaU60kcA7oAyL4pVse2QAn/ekh1riDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eoF4VlgXd7+YqbsJ0UUroCML5MflKD812vW5seUYFA=;
 b=nP4AAYne/hk4p1xJ4paxkmUHEwzu6ewl4blhTqEhlpViMvJ7hhSxKUjmBUq9VXscw0ZHGYwi686QELogStcMk2hpSHiyCEyBTaEUZLH/3tOpAnQju6QbpkAQ9j6pO52y4pELYuKUj0714vE703927ADWShveJ79IVsq+Ei3AzW8m+Elb7Clv+IkErvA8tgA7rpRNOBClfW9HDbgoKenGyYVS0hcswFCbVjq24UnQGYRkdydFwtq7DkSM9EjFtlZQNcS5Be2NxFRJBaPfFUpl4WpKEQa29vaRq+4HAbBrAlxH2c+sNpT34gOE5b7n1/eDfLodHGGol+4tjhR86KB7WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 06:00:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 06:00:44 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 19 Mar 2026 15:00:40 +0900
Subject: [PATCH] gpu: nova-core: gsp: move Cmdq's DMA handle to a struct member
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-cmdq-dma-handle-v1-1-57840b4a4f90@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G0hdCvUr4qG2UQOuLYhQ/LvF4
 8DMJIgchCN0RYLAt0Q59gyqLMAtdp8ZxWeGiipNtTI4Nug2f6HfLGbBr4yu1ZYNkVbUQA7PwJM
 8/7Qf3vcDyXWuFmQAAAA=
X-Change-ID: 20260319-b4-cmdq-dma-handle-c56ae9006104
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P301CA0104.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 2220a316-615d-42d3-b30d-08de857cdb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: TNKB0XlFHItiF8xoA6qJec2XLvvycHblrnKc+wle6CRGs8iT3Z89BBRK7pkoBc6Rr06e7UCpFrljhZnUWPAUUVseueA6KYcvzNEFhqdPNVaW+5ojwolML6pV1WIlTx4TYISd6LY5Q5Nnzkzo3WAJdRdBT0tl/pVCofk/xJPZYKT9turh1KSduu9WkmyxJ1JDCQizVdDIRXW7Tl0E6ze7Z9/gYguccs2MY0QhlzTCcfQK6E0ar6jwol7YETT/xV5PDLvdt7DpTa4QXo8P0jd6wEwUEb+YG5N/9YjhYHZJr6EZZpPrHjO0eQrh+ahywr+aY+kIN2u3IVm1xh5rGZ167/xp/tOtoHA4IUBlab4GzHR6DZj5ugXOjuM76JMvN5inkA2Zfaz6GmbuUsMy6VU8s6A24X4hxR9wrbECB9aC9fjEBFJ7BiutIQ0/vh9D/JleqIk5nQS3uIUZ1/qVoAlGuOoOcNajX63VDANznEYfdQWb3RJYPtCAWrKTDv9kJIjo71kXU2JNiqonj3h92EYb16q/QKT/hZ15oyGD/mBiqmms4F8AvN9iz1w7J2/f6uQA8q+UQAM40cLn9ih2I8gdedMrCiuMewTs0b5XSXuuHMb3SM2ug+Wy4h67nVhWBRQUJjJ8f9MvCKEzMGYYrOq++JWLYbxutDJTbXXQBkiLxpXp+32bBtlxpuKpxzriVipvQEYAn2m98BUVLKa+5gA1VZpFea8vL7c9nFGunYFhPpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklmcSs1bG43Sk5wdjYzcmZtdUhXcFdHK01ETHZDK3Z3RjNLQjc1R21Udmpx?=
 =?utf-8?B?dkMwcjZyVDJLZURSd0doWUszbS93REh3d2Z0TnZhNVoxODVFQWFFOHBzQ0tn?=
 =?utf-8?B?NUJlNkw2SUR1Mll0emVoSlhLeUJSY09scVZsTHZ1bm1XVzE5bDNxRHZPOGZa?=
 =?utf-8?B?R3RjdmdZY2pScTVFdFdrUnltN2l6UmMzM2E1RlRmSlRHRmE0WkJQMk5PZTZy?=
 =?utf-8?B?VTVQZ1FzczZLWHFsa2xkLzkwUytKYWVuTEc3QXh5QjQrNGl3YmlxbzY4TFpO?=
 =?utf-8?B?QmZ0dzV2U3V3djNiOUZEWUpkeFd6b2V1Z3BpWVFFVFp5QjhvSXBmdWJpbDVD?=
 =?utf-8?B?cWw2M3ltSFd3YzNwOGdLbk9oRG5kUlI0Rm9CSnhPL3lJWDhQdTY0dzhRU3dq?=
 =?utf-8?B?bzh3Uk80VGZJUS9ya04rYWQ4WFFndnlWMnV0VHIxUStPYWRjdHZMY2pkYUlj?=
 =?utf-8?B?MHR1S0JSci9kN0xrMzkrREZ4ZUl1b0RHRjNneWVBWFFHVzJHVGxaNFJXMmpE?=
 =?utf-8?B?ODVhV2dseFF1MWJPdVErYTJZUzVsQTdJYVlGU0MxeWRLSys0K0xRQmRaOGdX?=
 =?utf-8?B?bFNiWXpLYUlsTzdnQ3Q0ZVF2OGUvTDVyVXV1LytkbXQrd21IdEQwcjJpVW9q?=
 =?utf-8?B?OGdOL1EzdUJYekx3MUNXVndqSEJSRjBmaWZSaDRFeVNwbFAydi9wc0Nka1Ru?=
 =?utf-8?B?RTdMbjJJMjFITGZicm5zOHhMenREK1JWamNUbHllVURTV2tOSEpzK3FvVDJZ?=
 =?utf-8?B?SkR2bDZQV3ZHdFRKb2lKODVEcmI2Ny9YREIxbitSTW9QTGJUTWFmQ05WTVdE?=
 =?utf-8?B?UGZFUG83S1NoajhQQkx0dXMzQnlYeExEanU0Z1prOFlUUzlXQWlBdEY2eXBr?=
 =?utf-8?B?bDcxMjBONTJkL3VvTm5SM3RXN2VUY0hTYjNGSFBLK01FblpOT3RYZ1Q0QXFN?=
 =?utf-8?B?SW5Ma2o3VUtJbitsemN5YUtObTQ1YjMvYmh6bXh4eUFkVjhDdFVNa2pmM1Z6?=
 =?utf-8?B?OHVENTQ4amVicVU2RmFzNDRrT2RhTFJTdjRvWDkwdjQvMFE3YjZyUmtoV3pL?=
 =?utf-8?B?MUtZa0VPRmdrQWhpTEpoSnl1MFJrYUVORW1OcWVYQXR2VDJEVWNKbWMrM3N4?=
 =?utf-8?B?NmlpanllWC9Mb1RSc3lzUVJEU3hNRzFFbVhDbXMxUzVDbkltbDJudEZzQ0x6?=
 =?utf-8?B?V3BkWGlJdUUxS3Q5S1M0UVRQbjg1bU1ZU2t4d0lKSFQ0eHJaZ0xpYWNyOFFs?=
 =?utf-8?B?UjJvcWdHelMzR1UxaDk3ZG1oOTJmR3NjWC92Z3VmWldGLzZNOUlBU3I5Ny9Y?=
 =?utf-8?B?ZjJZY1lXU0U3RmVIR0gvTkFaK2NsWEFoUUVkcm1uSENVTE1OUUk5TXFRM2xL?=
 =?utf-8?B?WFBYU1RWWXU0b3k3T0dIWFNMek5zRWQ3N01SWmd5ZkVpdFoxYVlscEhaNkdB?=
 =?utf-8?B?S3gzRWtiSXRaNXJLUjhJM3ZSaTBkcjI2TmZWdWNxQ3VCdTZheW5BOHI3SjBx?=
 =?utf-8?B?WTNRRG50VlM2VUVzSktWWXZLNFcyQjhWT3ZUZDhvQWNQakVsRWlyQW5RMGJl?=
 =?utf-8?B?SFNFRGNWeVRmdVNWamJkMFhUZ3I2RXMzSmtSUHptazhMMzNGMlBYd1AraU1R?=
 =?utf-8?B?VVZZZnBsc1FsZWRmVmM1cDBadzRsRmR4dEFkQ3V6bUZuZStxRVNEbVBmNDNU?=
 =?utf-8?B?dXlKTlNVL1hiN21zaURaOHpEemYvdWNXVzhYeXNxQkMwZDFrNzVMbUU1RDNi?=
 =?utf-8?B?SnRuWnUvYVJ5SE9KUyt3M3NjbkpZS0lHbDhTUmk0VjdSMVFXc2RkcUp6dERE?=
 =?utf-8?B?a1VZUkJTMHBOQTRuOFl2TmhpWTI1YmUwVk1LcGkrTDVnKzUzL2YrdU5KUDJT?=
 =?utf-8?B?anFJV05qb200d0hCMTM3eStDWEw0QlVQNXRycVBEVzNjNlljYktKUWJvS1l4?=
 =?utf-8?B?V202WE54Wk9iYXU1UlBmODFmMjQ1WDFsdVMxTk9kbHl1ejl1STdOVmIzV290?=
 =?utf-8?B?dGp6RGdjbTY1WFdJT0hXQ0pDQ1k5YlhBb2tub0JrZWh2ZXBKRUJpYXkrcllJ?=
 =?utf-8?B?YSs2NlNaeVhHZ3YwMGt6MW9FWTRFaEoxOVFiSjVOTVFMa3BERkZGdFZYUjRG?=
 =?utf-8?B?RjNhRFdpcmN4ZGlQTDNTY256VWVlaXV0VHlSWXlNeVNCbDI1VlIwdWIrMXdK?=
 =?utf-8?B?c2YzZjcwaUdsRnQwaEhjMk1Dd2dIdmxmTElIY3NYdURjeVNKSW9lbGNwR0I2?=
 =?utf-8?B?bDZZdFY1NlhkVTJYbFRCSllSaW9UMWg3YXJwY1lsSTZyZGRGMG14RVFObjhs?=
 =?utf-8?B?NHgyaXlFYVpzYzZFRXFvTlB2aHlLOG90THplUXp1RUJkUE9mL1hyUlRwWFJp?=
 =?utf-8?Q?RX6dG4MtcEhftiooOEmgm9XUVXAVVmJJWk1QfCmrK+rBy?=
X-MS-Exchange-AntiSpam-MessageData-1: xfOXUOpbXvkcsA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2220a316-615d-42d3-b30d-08de857cdb90
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 06:00:44.0816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPMNdpGvXcBfMLlKOUY4RKHdEi9cNSLmzoCOTCdsvQbeeY3lzaXk9pP+q+sMnzlao/4BpPeGZY3kalSJswIvsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
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

The command-queue structure has a `dma_handle` method that returns the
DMA handle to the memory segment shared with the GSP. This works, but is
not ideal for the following reasons:

- That method is effectively only ever called once, and is technically
  an accessor method since the handle doesn't change over time,
- It feels a bit out-of-place with the other methods of `Cmdq` which
  only deal with the sending or receiving of messages,
- The method has `pub(crate)` visibility, allowing other driver code to
  access this highly-sensitive handle.

Address all these issues by turning `dma_handle` into a struct member
with `pub(super)` visibility. This keeps the method space focused, and
also ensures the member is not visible outside of the modules that need
it.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 26 +++++++++++++++-----------
 drivers/gpu/nova-core/gsp/fw.rs   |  2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d36a62ba1c60..03c7c2d0ea35 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -30,6 +30,8 @@
     SplitState, //
 };
 
+use pin_init::pin_init_scope;
+
 use crate::{
     driver::Bar0,
     gsp::{
@@ -455,6 +457,8 @@ pub(crate) struct Cmdq {
     /// Inner mutex-protected state.
     #[pin]
     inner: Mutex<CmdqInner>,
+    /// DMA handle of the command queue's shared memory region.
+    pub(super) dma_handle: DmaAddress,
 }
 
 impl Cmdq {
@@ -479,12 +483,17 @@ impl Cmdq {
 
     /// Creates a new command queue for `dev`.
     pub(crate) fn new(dev: &device::Device<device::Bound>) -> impl PinInit<Self, Error> + '_ {
-        try_pin_init!(Self {
-            inner <- new_mutex!(CmdqInner {
-                dev: dev.into(),
-                gsp_mem: DmaGspMem::new(dev)?,
-                seq: 0,
-            }),
+        pin_init_scope(move || {
+            let gsp_mem = DmaGspMem::new(dev)?;
+
+            Ok(try_pin_init!(Self {
+                dma_handle: gsp_mem.0.dma_handle(),
+                inner <- new_mutex!(CmdqInner {
+                    dev: dev.into(),
+                    gsp_mem,
+                    seq: 0,
+                }),
+            }))
         })
     }
 
@@ -570,11 +579,6 @@ pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
     {
         self.inner.lock().receive_msg(timeout)
     }
-
-    /// Returns the DMA handle of the command queue's shared memory region.
-    pub(crate) fn dma_handle(&self) -> DmaAddress {
-        self.inner.lock().gsp_mem.0.dma_handle()
-    }
 }
 
 /// Inner mutex protected state of [`Cmdq`].
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index a061131b5412..0506c2293e7c 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -892,7 +892,7 @@ impl MessageQueueInitArguments {
     /// Creates a new init arguments structure for `cmdq`.
     fn new(cmdq: &Cmdq) -> Self {
         Self(bindings::MESSAGE_QUEUE_INIT_ARGUMENTS {
-            sharedMemPhysAddr: cmdq.dma_handle(),
+            sharedMemPhysAddr: cmdq.dma_handle,
             pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
             cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
             statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),

---
base-commit: a19457958c3018783881c4416f272cd594f13049
change-id: 20260319-b4-cmdq-dma-handle-c56ae9006104

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>

