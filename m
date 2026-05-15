Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA86CD4F46
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3459510F3E7;
	Fri, 15 May 2026 06:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pp5WzkxP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1636110F3E7
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZbopw1MJx9qLj/C3kLBEozstVPN+IYP2tQImgdM76WCUTeGUu7wLgT2tTupJMjfJ3jl5slCov0PC/LEEZ36dnntBxxQMFucPHPB+enKfjiw/V1wPc3V38UBjCyxxXkDCjanIMp8IOXDg8OQjO6lWMybBwXW21iqKy9doFNAHTldDisUlkOiC4Q9S6qAdb6hMxiQ6gM4Rd1d1VO1Rccw/bxdnmx9QsVk61701+nqsIC6QmDmBtgVNfsGBo4QPxLRz++B3llLX4NoHBnrN+d2drlcVMH5PYEeY+hUxWmWtIa6O2fcGRTl2+SC/UILcTP++qlSY29Gjf03hmwuj6AxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63i5zMXmVf6hfSIJAfaq/QFEtBwCIZwtiH2SfBjYDV0=;
 b=GOCa3it23bunDbk0AE/Z+GBT6FKJ+bsj5Xvd9JN241LipQilJxBc03s7IjZA359aVfPGpqaHCli/xuNf8gf6/C+vLx+pkTJwGbonj0fAx4mZtIBFDAU6UnEovFNxoMUXnL5BXQWIXjuDSOkJz1zjQN5l1aSMxkE5ozE3gzUh6T1DgzywG/6junuIRJe6fTg6xos3ToD5whLkd0KaIMmvKOyr/YIcjIOsx303p27WF+/vS/wG6lMfffDYKqikQLV0UcsZojvoaDO+ecLdf7g21Jjrof4bP+g4ivEvIl1yJ4O/h4QM0+kYyz7Q4P7+aFDy5m6P5JbK/oLcRgK1lZKnEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63i5zMXmVf6hfSIJAfaq/QFEtBwCIZwtiH2SfBjYDV0=;
 b=pp5WzkxPv1/3jLiWpWn4W4De/AUdIEz+yKEVul2t84xL/o6nRDLt4WkgucLQ4hwufptfdXt41XufI4Lqph+vVLrCt0ZXqixgH4jgFJFuQOBUxPm39k6kIVoPsMowpyoJUZaVQHvP2q1XV1lf/sfd+k6kkyht1lx8cXI7/pTYG3XbpfzqfckcottBxGkyQJikybtTVPJUVI0NlCw9pBDyqMySrp+bKIdDLhkqsAHQaP5/yQaEXelbNM/YyekX6SgQxKGqhQXnjYFpWjYz7mkyzXY6YJXWBvR0c3SG6ZOg/E+4YJoPaUgrYk8Y6krX9Z7m5iwZ4LMQD/bVSQ069Fq/ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:12:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 06:12:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 15 May 2026 15:12:29 +0900
Subject: [PATCH v5 3/7] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-nova-unload-v5-3-c4d6250ad160@nvidia.com>
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
In-Reply-To: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: be3df2de-e3bf-43f8-f052-08deb2490325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: PBrvO4THhzMyYeHKGNNru6zou9EXtaH9QxHxChYdZ734PSNXF8oevlFIE9kF/5420jWdbGTf2yNMhICnJPY6lT+Rsa7HylJYEHusOEdd/yiG8+0kA1TF76/mzSC0GoExe7OSMVJ/AbdRnAQOEawry4ENsznZRa8N8DdoCvDK7lQiLRMC594t6Enzy+NFKc2eIf6U8emHw+7dk1paNo1Nnzk2kk9i5MXx580tdknqWQxIxY285HWsVZd5SV5Zx0VxPdx8nRv6Qv9UNZEWA5s2zHgf84BfwuazcmzAPeNcuGuWn6bDJXJEJUptxrwQmcXXy3GjbS+OSObwuOcR+WSuF6wH8DHfv3UBjCZh9FH9X3cAbX4QNKNgS2JWsU9NmsAp7+X4hSxy7YxNye6p73FAf//4WoR/Fd53df+VoEIyifnNHf0yCADXLXlK/YMcIaFDdkQjYiJ4GhtELOF7cgJUMsa/7y/fUvNzdHIn+a6JKQQb8lyUlBibwVAAPEzFM+MwofczEHKmGwa66a7E0kEHjLbJP8zkAzlVhmLaSJynUlglp0wMYx/CJqyYzr3vXmjzpShaNslXIlJpnXwzCj2t5fTod0CajvsWQSRD/VXbxqd5WguncbDu71ivNxQMjma9oVwIFzN3PU4GAHKaOrhTjD4TgyaVthVdqBj6TVt8bvMifaUD38b63GEojv1Tp5P7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWhhVzFWQXpwSmdreWJZd1p2dXk1SnhzZUhFa2JsUlJ5S1hQSmUxSTJ4ODRa?=
 =?utf-8?B?ekR5YUhCMDhGdWZObnFOSS9ZK0dVSS9jY3ZFZlloWFNlNWdhaW8rdml1cXBh?=
 =?utf-8?B?VFFhU3dRMTIwdi9LbURjUUltL1lNZ1lDMVQvZS9pSnFqOENrVUZqTXFCTHN5?=
 =?utf-8?B?TU5Ib0ptQW15S29vTW4xQlNyYndrc3YrZG51d2EwT2NJZERWaDg0R2VHMXZ1?=
 =?utf-8?B?N3pIZkVNUXgxYTJpa0ZZT0cwakEzNGFHRU5Xc2orV1J6VTgybHp6UUhlc1g1?=
 =?utf-8?B?MTY0TkszWmlxRW0vYkhobzM4OS90V25iWmQwZ3gvVVBiSmZJbzJEWEhNS1A5?=
 =?utf-8?B?YVdoWHo0T0pyY3g2R0Ftd2lIUDdUVU5sSlhRNXpiTWxuTkFJTURrbXBDaDVS?=
 =?utf-8?B?VVdVQ3pTNXRhTmg0SzV5R1AvdjB1SU5lMkdmNTgwbjVVd3dYZU9VOGJCVVNY?=
 =?utf-8?B?TmYwTEZUME9JdUNxeXl6ME0xdVB5MjJMM05YQXlCSWRqdnFHNEovWDNnb0xu?=
 =?utf-8?B?ZS9ROVhQeVFWSEdBZE92VFFwT3pZeGdGZ1hGcHpXMW8xbkhmUVJlZjNlUWJP?=
 =?utf-8?B?WlhwRUNpaHlVMC9uNk40eUR3M1R5MUt5NWN2SExIYmladEx2YURlV3dkRUUw?=
 =?utf-8?B?eEtyZm1FN1VQQU5tT1NRV2pDR1RZaEdYb1kydWkxRUVzcEVjYnlvYWx2dW9z?=
 =?utf-8?B?VnBNZmdPWXR3RDJxYS96WnNQd1B1VVB2clE3cE5NVVBxelkrdkVTRGtxdTBO?=
 =?utf-8?B?czlFY25ESy8ydDdTbjh0YlhVU2l5NGFnbzJ4aFRzYWs4cm1CbDFlaTZWaENa?=
 =?utf-8?B?SlFLTWo3a2dWWU9YaTU0OHNHU3EzMUhyUFY0RVllUE5PT1NnUU5zeUJwWmtC?=
 =?utf-8?B?Q21XcnQ5bmRyWndzb2xHK1dxTnZYZGlBUDVBc1QxOEZSamZiWER0VjBIMXht?=
 =?utf-8?B?LytkMEVOU3A4ZjJ4TThkRlRKcGxxZUI1MUNaYmJkQTV1dFVhdDYrVWR5SUxu?=
 =?utf-8?B?OFJYSDZvaE5tNis3NmhoT2JBZEk0NDl5Y3hFc2ZVTTZhRWJNWDk0M0lCQjJq?=
 =?utf-8?B?cmVTYnpzY0J3SFFMWi9haE4xaG1VTHcreW43RTJTd0cwNE9WeWZyRml5bi92?=
 =?utf-8?B?dnFJcVhyd2hRVWU4WmVBeGlCUnFBREJoZGlLZUo5ZmduZXNFYVNpY3F2LzNX?=
 =?utf-8?B?bDJQTEdjVkk4VUFmOTRVNUU1T0p2eW5yZExodDlMOHhBWFp1aHJUSXJoa3JY?=
 =?utf-8?B?NlQ4VGxoVllndGZsbTVYcVN2WGFZVXp6ME1MOTF5K29OZTYwRXBRSCt3R1ky?=
 =?utf-8?B?QzZ2Znk5RFhlWFNMN3dTdkVCaG03ZHM4M3Qrbi9aRzdxbm54R2dtdDlnbTVs?=
 =?utf-8?B?QldaNXRTczVyOGRLMWVwTytpdEM5YXRsai9DRFhrdHdBckZOTndITVh2cWtD?=
 =?utf-8?B?MVplenJFQ2QzdTZYejZGRWFjTGdqYm9Zc2tid1gveFhPeGxON0ZqWjhXMzh0?=
 =?utf-8?B?UzVQaVIxUjJUdGpGN3k3WHZFTityQ1haWGczODZLL1JPNlFvSnMyK3prZFpv?=
 =?utf-8?B?MGlVZU00LzN3ek9pNmVTd0g1MVh3OE0xMmxQRWt2RUNKMXhldmVDb1JnaXhw?=
 =?utf-8?B?QnFMNStWMkFqYTBVQ0szNjRUK2kvOHYreGx6U3hPcHMvRm01Uno0eEx3QmlL?=
 =?utf-8?B?bU85NE1LbDA2TmF5dSs3SU5nRFpZVTlwVTRubEhqTHFRRk15ZUZDblcrSEN2?=
 =?utf-8?B?Vjd2SEZ0cTVxNWEyRmI5KzVFcXdoWXc5T0hhakFad2hlVnY5c2crZnl4ME5U?=
 =?utf-8?B?SW53RlVLMWQ0bGtxWTRoTm0wb200L2ttemVPYm5NRWlLbVg4ZXI0RlF2M2My?=
 =?utf-8?B?bC9KTFdiQ1VaVWkwcEE4Q25RK3owN2tPUFJLTk9RNm5sNTdxRXMyNGFrMXd5?=
 =?utf-8?B?cU1iUngxclgvOERXRE5IL3k5ZlIweVlXMWZpK0ZDN0RqaUw0SEtnTHlyTkxS?=
 =?utf-8?B?eFd2eEJ4b1dTL2lvNTVWaUZzdWxCN1V3TTRJMlhsTkJHeVRnNVAzdU5sRTVh?=
 =?utf-8?B?RCtiMEpKNHV5M2tWMU9OQTQ3TWVFZW1YRUFnNXY0dVVHQjNYZmZpZzJmMFVT?=
 =?utf-8?B?Vk9MaGZxVEsyeElmemlna2txYlZVTWdnWHErdldsOFJ3UGs1L3BvNjdJMFJK?=
 =?utf-8?B?bGNhQTVxdEw3VEVUNStIWGlkMmhSa1YwamxrdUNBQmpJY0FiV01IMkJsbkN4?=
 =?utf-8?B?ZmYzMkxpU0kwZERDRFBtYzF5NnN4OUlWQWdwdWg3OCtQSzhWZEROTnA0ZkpG?=
 =?utf-8?B?YTNDRlBZY0E3Myt4RFVMOExQS1F3eGQrVTA4WkNGdE9Nbk1NQmtNeEx6Um92?=
 =?utf-8?Q?OkuN8zYentFn56gkm9B7TmF7JxzAv2K/ipAspF+Xac/I9?=
X-MS-Exchange-AntiSpam-MessageData-1: eANAU+dqPIev6w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3df2de-e3bf-43f8-f052-08deb2490325
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:12:58.9771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1DnmE2vtJcFM00Ure2qATi+rvTUQaS9mAp5rODhHraD7yKxOmM455Y/T/dHYvawh5hTUY59znEZymcrl1bTFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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
unbind sequence in a later patch.

We make use of the `pci::Driver::unbind()` hook as we need access to the
device in order to properly unbind.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs                   |  4 +++
 drivers/gpu/nova-core/gpu.rs                      |  7 ++++
 drivers/gpu/nova-core/gsp/boot.rs                 | 44 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/commands.rs             | 43 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                   |  4 +++
 drivers/gpu/nova-core/gsp/fw/commands.rs          | 44 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 11 ++++++
 7 files changed, 157 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 31d2a8dadb7b..9a2a0e68e542 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -111,4 +111,8 @@ fn probe(
             }))
         })
     }
+
+    fn unbind(dev: &'bound pci::Device<kernel::device::Core>, this: Pin<&'bound Self>) {
+        this.gpu.unbind(dev)
+    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4c329ab40955..75fe1bdb80fe 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -293,4 +293,11 @@ pub(crate) fn new(
             _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
         })
     }
+
+    pub(crate) fn unbind(&self, pdev: &'bound pci::Device<device::Core>) {
+        let _ = self
+            .gsp
+            .unload(pdev.as_ref(), self.bar, &self.gsp_falcon)
+            .inspect_err(|e| dev_err!(pdev, "failed to unload GSP: {:?}\n", e));
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e838d61bef50..d39da38c8918 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
+    bits,
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
@@ -36,6 +37,7 @@
         Chipset, //
     },
     gsp::{
+        cmdq::Cmdq,
         commands,
         sequencer::{
             GspSequencer,
@@ -251,4 +253,46 @@ pub(crate) fn boot(
 
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
+        // Command to shut the GSP down.
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
+        Self::shutdown_gsp(
+            &self.cmdq,
+            bar,
+            gsp_falcon,
+            commands::PowerStateLevel::Level0,
+        )
+        .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}\n", e))?;
+
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index e78bf94bc5b0..8e7c55c97445 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -231,3 +231,46 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 }
+
+pub(crate) use fw::commands::PowerStateLevel;
+
+/// The `UnloadingGuestDriver` command, used to shut down the GSP.
+///
+/// Only used within the `gsp` module.
+pub(super) struct UnloadingGuestDriver {
+    level: PowerStateLevel,
+}
+
+impl UnloadingGuestDriver {
+    /// Creates a new `UnloadingGuestDriver` command for the given [`PowerStateLevel`].
+    pub(super) fn new(level: PowerStateLevel) -> Self {
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
+pub(super) struct UnloadingGuestDriverReply;
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
index 3245793bbe42..33c9f5860771 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -279,6 +279,7 @@ pub(crate) enum MsgFunction {
     Nop = bindings::NV_VGPU_MSG_FUNCTION_NOP,
     SetGuestSystemInfo = bindings::NV_VGPU_MSG_FUNCTION_SET_GUEST_SYSTEM_INFO,
     SetRegistry = bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY,
+    UnloadingGuestDriver = bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER,
 
     // Event codes
     GspInitDone = bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE,
@@ -323,6 +324,9 @@ fn try_from(value: u32) -> Result<MsgFunction> {
                 Ok(MsgFunction::SetGuestSystemInfo)
             }
             bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY => Ok(MsgFunction::SetRegistry),
+            bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER => {
+                Ok(MsgFunction::UnloadingGuestDriver)
+            }
 
             // Event codes
             bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE => Ok(MsgFunction::GspInitDone),
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index d3ef7ecdd73e..88ef3c0fbc01 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -131,3 +131,47 @@ unsafe impl AsBytes for GspStaticConfigInfo {}
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
2.54.0

