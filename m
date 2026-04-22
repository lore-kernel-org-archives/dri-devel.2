Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA850F9EDD3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1286410EA33;
	Wed, 22 Apr 2026 13:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="S9kICvtJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019AF10EA34
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrPNEJkeN2HkO8Eqb1mC/Plr1Bs3EjyA1xy+v3mzDBHIR6XceOnOx0+o34EPb73PBHfVthf+0PQraZbkeUGs/qS55Im6SXEKm6d9XOk5hs7zRu2ygwZRHAA2keVYhakjagu+9cQg7XHDBKvoB/ic528s/lEr1mq7BnQGeh9wLy3Sc7NNDnqsK3/LtVVS86KQzFI2HKZTnN0MnVvWj22O5jN1zoQJHZnWU7C8VkGpuOtxnrRuafoNcutXlap23azWr7CMSEfarAuBuqav5fm/+vqeZYcZaGP27mNbXA52efAV8aF6TpnXp7sbQ7HGRC/d6pbcQHxZZhX3S8oLbYzIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quVfT2SpU81pvySJ5gTNtu1ujIf0RlidsIFMJ0Qmiys=;
 b=UhnZVJ+UoTLt7aH75eZAjVZ5L0QQiALbMq7lTBBUWQ+wDjfR25mDMYM6gohuzLAIkf+ZIBnVkeYd40uiRuyQbW3nTK7lWyhMKNgW+X/r2jQq507md8mXrZQJvtIQxOFd1ZfX6ZW85y1HboGGZJRTFnPOojFQO0HnW1+NnKZYrnHwoHrZWtFnvOmtEvBxd/ow/j+Vjw0Uneo1iRWjk+JRJs4vWPLg99KmPJwHDlz2h2e92rA4AxIFlNYAq4LDazIzV4cvXV+j57+xw3+6NlqGQENaCth95nUfDV3Z48sqAJv8BZJP1zKVQYXvfSG6X4ZXsFW4E2upCQq6IPvFFkgQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quVfT2SpU81pvySJ5gTNtu1ujIf0RlidsIFMJ0Qmiys=;
 b=S9kICvtJupl74/mzHFTbaZ/q5T+cpBykjRgJcAnk7UUbZ7pddK8w9s450lCn3ZwtXF/0/wJz1Wzx/qk5TDo8k2ngSMQe/D4n+Xg50PKSqlcppgKLI7jV2EpkuKe+ljuIJn7hRlnwOuygE8ne2Vpg1iXYPRtRkrjP0bTTceBKiLG3Mf19lg8KKyL3qxODkoti0DEsz+ohdEhNEEtO7kVpjLYubxwtPGwpuFecH6lGLOrkeTz6g2gxMeAjy1FjTJrYmApaJZmPRJbMlTifu/vP4vw/y7/+HYmCGAkCvgRlsBnf0WzbPRQNcgChQcfjIg0sNXMwf61wCd5SJYU/noimww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 13:41:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 13:41:19 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 22 Apr 2026 22:40:55 +0900
Subject: [PATCH v3 5/6] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-nova-unload-v3-5-1d2c81bd3ced@nvidia.com>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
In-Reply-To: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:372::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 412898d1-8880-4bea-304a-08dea074d594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7pvdKnmR4zN+k5qduPt9OxhIk9N5Bk/eHdq7rWUnzsGsbo75tNZnQIlAEDv4f6Jbzmq0XbZ5r1ykWTwb0McM9Sm83y5XegdTnx0kJpwoRoyn1/ucG+qUVzpy+qwUr3Ib3Y9veGNuIg1pxZZ8ZbStGmeStPJo+vN8Ss1Peq2gWODOC/wn12zOP9CboTT6+yAuccvkYvvh2OIl5aFKRU7ciy/4oJRg8lFkFErtsb5JW4baKDp9KdS6XnZ/OgfM1nXnXJYcvXl05LMTd9X/ajfjNtSBv4oUy1FWWQ76M52lbUsQNuSyBDCRkJeNUe1dD7RioEUdgS7UYOJQTw9f8mavpkq3z3k5qmJC1KfYYAiS22/qYEDsW52FXkplBqumWDEBxO8kFEcUYniKD/fJElwSyQwo/Npeo93FZWG/DqLD5SbI98KbLEA0LfPvlhaoD2F5vVlQhAn0deM5E2OmxJ+m2JFFQjxn88fQxXYV+uLRjPe4OWtHxlFoYViwdi+AAHO4UiSwbg0HAWtcwlXnqYHctoxfxvWP8NAuqdyFn88K8YNF6hbLUZPU99b6hxe14m5L5KW6Q1xvMJ7l2fU4jEN1iKh8SiSl7MUx8lhs0+ecqI1sDWx70XgxRKh00ca2Dptw24TlMwZq0ob9MNZtnBrF1y0HdapUYahIUkqbRJPb6E/j6AfJvpSPEuxLm1tm8LqnmsjM6zFCzzWqNKJv+2vnPdukrYXqGY/HBFW2Mw5FkJjGJoRFHfMpNSnBNofz25lhPSPD3d1jeIMcqCUhrCS6Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzA1QXJ2UW1mV0krSjQ1ODE4UHV3R1crRkExWFBKYXN1YlRmSndBRFpuYjVF?=
 =?utf-8?B?MFAzRFZEdHNaZ2g2eWF0djhMNmdIRldITlMyV0NsQkw4SDhQdytxaU1QaThs?=
 =?utf-8?B?QTNVSmxtQ1FpU3A5WGdQM2ZrSEJkS1ZWVktzeThFai9pb2xlU1BlSjZrUmpL?=
 =?utf-8?B?OGQrYzhaNkNyN0xHYVRyZ0JhNlF3S0lvQzk3ZXZJTEJlRjQ3TmxnRjVuNUFu?=
 =?utf-8?B?UzdPZENNWnJpc0tqVmZiUE00SGpRY1IyUmNZSThqQk50b3NCcTFOcmt2Y3Nj?=
 =?utf-8?B?TTc5NTdPejJXK2J4Snp3U1lNWC9PYmhBaXZGaURTVndCNzBGNlE1MU93dnBB?=
 =?utf-8?B?NkhCZlgrSmx0ZDlMRExHYm9rK2xIZmlDTjdlSFVyeGJnVExGNUs2MlgvcVov?=
 =?utf-8?B?SHVBZ2xyNEhTazg4Ujg3ZXRncERQWHZWOFhQQlFlR2xFSDBCeGtxMVdET3gw?=
 =?utf-8?B?NjZyNkVzeVJTY3FwcHZhbEFOS2thWThUOW9uMldtdko0THpRdjNwNStCS29G?=
 =?utf-8?B?VEtHVjh2Rkx3bEFQdURrVDBTZDhDdUEram9yTVBkVG9CNHFSN2NjRXpzbEhS?=
 =?utf-8?B?aThmSWZianhqcHFHWk5BR2t2VC93OHFtb2lxWVE2N2VrbEZBcEFNV1dDM3FM?=
 =?utf-8?B?WW40OVh0UlRKeFc3OHJWTnBZaWN2OHpWNzVRc0tBK0c3enYwWFZwTWN5eVU1?=
 =?utf-8?B?SHRheWxqN1V1UEFUd3pRSnUyV2hwMkNXOC9EanNRTHB0QWp0S2M4elFsUzMy?=
 =?utf-8?B?NjlST2xtaWVWUlE5SndtMGdub0llOHNJZUFuWXM1Y0d5VVJPSjhnR3ZpNEJi?=
 =?utf-8?B?MlkxWUhyZEwzamloRkc1ZU9jV04rdG9vSGtmY2E0OFZlTFV3eGN6eGxkRVFw?=
 =?utf-8?B?TDJ5MXg0cEVBYUdXZ3pRaUw4OEtkYzZmSTBqMmRENXJMWVpWei9Od1FURDYv?=
 =?utf-8?B?K0pYNGZNMXhhemp1b2ZENlJqN0c1V24vNGJrVm40ZVlRWE4rb0YxNW5CR2lC?=
 =?utf-8?B?SXJpRHRMOTVmMFB6anVFY3dXWlcvcm95KzdHaU5GYTFzWFEvTkRqaEE0NWNh?=
 =?utf-8?B?K3cvQzZGazdHUzhXUDBFbmwrZXRjZ2hTRElyeFhEa1hKTXcyc3hEQSthZWo4?=
 =?utf-8?B?SUY1VnM2blJiOWtqOGUvVjFrbkZ3ME5YOEpEYS9pSVdHdGRnbjc1blRzRnAv?=
 =?utf-8?B?RzBRQ2dNT1B1eVlDamNaTmNCOGNOTmRDSE5oeWRRS3hwTDZiY1ZJMnR1cG0v?=
 =?utf-8?B?UlJMZmUydjgwU080VHorZzkxWEc5VkJXNGxnQm5hMXZpUXlhaDMrVnEvYnFa?=
 =?utf-8?B?L0RKVHh3ZUJEWnUwaStRTXlJS1N0R1BGU3RRdnNkNStEeFVjL2p5RHdlcHQ2?=
 =?utf-8?B?SjZvM1FjTDdBd2tER29MdDR2aHJISDA5SmhPbTJxbWJzREZnZllGRWhrNDNC?=
 =?utf-8?B?dU1IZjgwN2x3KzdFb2kvTG1wZEdzQm1Memw3QnhDU1BVZVhuUU1yV3J5K2F5?=
 =?utf-8?B?elJYVms4dkhDbWdvblErd21OaDJaemNTajhaS1JONEU0VmdKTWZzY09FRXAw?=
 =?utf-8?B?d2Z3aloxQ2tUM1ZCVE5vZ0lreGxoa0FCeVZnTWk4OFYvSUFvbzNRWTkvYnBj?=
 =?utf-8?B?YmxhcWtDbzY4ZW9mdmg2QXhjVmI4UFBMbm8rT2VTS1FWcVZtaEl6bHYwbWZR?=
 =?utf-8?B?NEsrTkx3QW00M3JNZ2xsNkI1aFBTRks2M29tdCtrRnpJYmgxQWtFQjVyQllY?=
 =?utf-8?B?dTZjb0RPbUpnRWVEMDRzOVIzQ0FGOFhmS09XU2MrYnY3aGI0c3NOZmxWL1Vw?=
 =?utf-8?B?eURJU0lNM0FvWTBWMFp2RWcwRmtPVmFpbDE2TVZ0QVVtcEM5OWVVNlVCbUFR?=
 =?utf-8?B?QXVOTm9nS2k2TjhmSzZsQ2hhQW9NYlo3aC9rTUxiR1IxaGJMaW1ham5udDQv?=
 =?utf-8?B?dkcwZUlWWVFSa0JnS3dJdHhUWXdaVUxQbW84MDkrN21saDZmOEdRMEV1UXdM?=
 =?utf-8?B?YVI0ZE1PcWlSYmpQeWphVHlUR2xkYWs2MS9TWUVIZVVxTGs2QU1Ka3V4YUZD?=
 =?utf-8?B?Y3hRb05Xd2hkdEdyeUZXWXYwR3VZYS9mY25ZeGp1N0hTc1gzVzNUdkJyOHdE?=
 =?utf-8?B?Wk9nRzQ4eXZFUXkrT1R5ZTY3Y3E2YUtXYys2RFpCQTJnSmpkVGZQZVZRVWJp?=
 =?utf-8?B?WEs1TWJjUHg5aVJhWWxLZ01tcUw5WUdYSFQyR1ZrbnIvNHlFdkt5NDB1ak9h?=
 =?utf-8?B?Z0tTS1E1R3hhaSt2ajZyNEJaOUtrQVJQNEVwS0hVYVR3VTVOeURwWEJjemlV?=
 =?utf-8?B?OHg1VTlPMmxGclZ6N1BlYjBUUVUvd1RMN2hkZk5VZTQ1UFhSejN6cytvdUgr?=
 =?utf-8?Q?nMYUBHWL3+ny8KodiimXHl3KzGd20D4Tq+VwPA4aNCkNM?=
X-MS-Exchange-AntiSpam-MessageData-1: iLXEcK2NvJBuKg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412898d1-8880-4bea-304a-08dea074d594
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:41:19.4621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Plwu+PRsQ8c/WyluEawNCDn40FBCFkMw7piIxAceJhW0g6wZVsLCO8JzYENgkAaakFsyerNXNyXHNI4sRycw/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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

Currently, the GSP is left running after the driver is unbound. This is
not great for several reasons, notably that it can still access shared
memory areas that the kernel will now reclaim (especially problematic on
setups without an IOMMU).

Fix this by sending the `UNLOADING_GUEST_DRIVER` GSP command when
unbinding. This stops the GSP and lets us proceed with the rest of the
unbind sequence in the next patch.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                      |  5 +++
 drivers/gpu/nova-core/gsp/boot.rs                 | 45 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/commands.rs             | 41 +++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                   |  4 ++
 drivers/gpu/nova-core/gsp/fw/commands.rs          | 44 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 11 ++++++
 6 files changed, 150 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 1701c2600538..8f2ae9e8a519 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -277,12 +277,17 @@ pub(crate) fn new<'a>(
 
     /// Called when the corresponding [`Device`](device::Device) is unbound.
     ///
+    /// Prepares the GPU for unbinding by shutting down the GSP and unregistering the sysmem flush
+    /// memory page.
+    ///
     /// Note: This method must only be called from `Driver::unbind`.
     pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
         let Ok(bar) = kernel::warn_on_err!(self.bar.access(dev)) else {
             return;
         };
 
+        let _ = kernel::warn_on_err!(self.gsp.unload(dev, bar, &self.gsp_falcon));
+
         self.sysmem_flush.unregister(bar);
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 9b6f349d3339..cd11df319640 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
+    bits,
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
@@ -33,6 +34,7 @@
     },
     gpu::Chipset,
     gsp::{
+        cmdq::Cmdq,
         commands,
         sequencer::{
             GspSequencer,
@@ -237,4 +239,47 @@ pub(crate) fn boot(
 
         Ok(())
     }
+
+    /// Shut down the GSP and wait until it is offline.
+    fn shutdown_gsp(
+        cmdq: &Cmdq,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<Gsp>,
+        mode: commands::PowerStateLevel,
+    ) -> Result<()> {
+        // Send command to shutdown GSP and wait for response.
+        cmdq.send_command(bar, commands::UnloadingGuestDriver::new(mode))?;
+
+        // Wait until GSP signals it is suspended.
+        const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
+        read_poll_timeout(
+            || Ok(gsp_falcon.read_mailbox0(bar)),
+            |&mb0| mb0 & LIBOS_INTERRUPT_PROCESSOR_SUSPENDED != 0,
+            Delta::from_millis(10),
+            Delta::from_secs(5),
+        )
+        .map(|_| ())
+    }
+
+    /// Attempts to unload the GSP firmware.
+    ///
+    /// This stops all activity on the GSP.
+    pub(crate) fn unload(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<Gsp>,
+    ) -> Result {
+        // Shut down the GSP.
+
+        Self::shutdown_gsp(
+            &self.cmdq,
+            bar,
+            gsp_falcon,
+            commands::PowerStateLevel::Level0,
+        )
+        .inspect_err(|e| dev_err!(dev, "unload guest driver failed: {:?}\n", e))?;
+
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 484aeb7dfd39..5f6997cdb911 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -231,3 +231,44 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 }
+
+pub(crate) use fw::commands::PowerStateLevel;
+
+/// The `UnloadingGuestDriver` command, used to shut down the GSP.
+pub(crate) struct UnloadingGuestDriver {
+    level: PowerStateLevel,
+}
+
+impl UnloadingGuestDriver {
+    /// Creates a new `UnloadingGuestDriver` command for the given [`PowerStateLevel`].
+    pub(crate) fn new(level: PowerStateLevel) -> Self {
+        Self { level }
+    }
+}
+
+impl CommandToGsp for UnloadingGuestDriver {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type Command = fw::commands::UnloadingGuestDriver;
+    type Reply = UnloadingGuestDriverReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        fw::commands::UnloadingGuestDriver::new(self.level)
+    }
+}
+
+/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
+pub(crate) struct UnloadingGuestDriverReply;
+
+impl MessageFromGsp for UnloadingGuestDriverReply {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type InitError = Infallible;
+    type Message = ();
+
+    fn read(
+        _msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(UnloadingGuestDriverReply)
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0c8a74f0e8ac..59b4c4883185 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -278,6 +278,7 @@ pub(crate) enum MsgFunction {
     Nop = bindings::NV_VGPU_MSG_FUNCTION_NOP,
     SetGuestSystemInfo = bindings::NV_VGPU_MSG_FUNCTION_SET_GUEST_SYSTEM_INFO,
     SetRegistry = bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY,
+    UnloadingGuestDriver = bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER,
 
     // Event codes
     GspInitDone = bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE,
@@ -322,6 +323,9 @@ fn try_from(value: u32) -> Result<MsgFunction> {
                 Ok(MsgFunction::SetGuestSystemInfo)
             }
             bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY => Ok(MsgFunction::SetRegistry),
+            bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER => {
+                Ok(MsgFunction::UnloadingGuestDriver)
+            }
 
             // Event codes
             bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE => Ok(MsgFunction::GspInitDone),
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index db46276430be..e0f1cd92681c 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -129,3 +129,47 @@ unsafe impl AsBytes for GspStaticConfigInfo {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for GspStaticConfigInfo {}
+
+/// Power level requested to the [`UnloadingGuestDriver`] command.
+#[derive(Clone, Copy, Debug, PartialEq, Eq)]
+#[repr(u32)]
+#[expect(unused)]
+pub(crate) enum PowerStateLevel {
+    /// Full unload.
+    Level0 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_0,
+    /// S3 (suspend to RAM).
+    Level3 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3,
+    /// Hibernate (suspend to disk).
+    Level7 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_7,
+}
+
+impl PowerStateLevel {
+    /// Returns `true` if this state represents a power management transition, i.e. some GPU state
+    /// must survive it (as opposed to a full unload).
+    pub(crate) fn is_power_transition(self) -> bool {
+        self != PowerStateLevel::Level0
+    }
+}
+
+/// Payload of the `UnloadingGuestDriver` command and message.
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Zeroable)]
+pub(crate) struct UnloadingGuestDriver(bindings::rpc_unloading_guest_driver_v1F_07);
+
+impl UnloadingGuestDriver {
+    pub(crate) fn new(level: PowerStateLevel) -> Self {
+        Self(bindings::rpc_unloading_guest_driver_v1F_07 {
+            bInPMTransition: u8::from(level.is_power_transition()),
+            bGc6Entering: 0,
+            newLevel: level as u32,
+            ..Zeroable::zeroed()
+        })
+    }
+}
+
+// SAFETY: Padding is explicit and will not contain uninitialized data.
+unsafe impl AsBytes for UnloadingGuestDriver {}
+
+// SAFETY: This struct only contains integer types for which all bit patterns
+// are valid.
+unsafe impl FromBytes for UnloadingGuestDriver {}
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 334e8be5fde8..f82ed097b283 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -30,6 +30,9 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
         fmt.write_str("__IncompleteArrayField")
     }
 }
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_0: u32 = 0;
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3: u32 = 3;
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_7: u32 = 7;
 pub const NV_VGPU_MSG_SIGNATURE_VALID: u32 = 1129337430;
 pub const GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2: u32 = 0;
 pub const GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL: u32 = 23068672;
@@ -880,6 +883,14 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct rpc_unloading_guest_driver_v1F_07 {
+    pub bInPMTransition: u8_,
+    pub bGc6Entering: u8_,
+    pub __bindgen_padding_0: [u8; 2usize],
+    pub newLevel: u32_,
+}
+#[repr(C)]
 #[derive(Debug, Default, MaybeZeroable)]
 pub struct rpc_run_cpu_sequencer_v17_00 {
     pub bufferSizeDWord: u32_,

-- 
2.53.0

