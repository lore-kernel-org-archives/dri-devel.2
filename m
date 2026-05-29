Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F00CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 740B110FA19;
	Fri, 29 May 2026 07:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKjKB4CV";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B559610FA17
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGmmo4+SZma912AX5p4EgdIA9uMjbGeS2fi6i0VGnCkeP6eLhT89c0lB+hvn2AwWltqOjowu4gF9p6u+zpI51fl67+g1kNromn4VaPym1y5lpqtITmCa/lX1prdgWTCLFQqMy4deOtLyTGwsA4LouDZid/dvX5jFEYtKuGQyY7O76R3dY2qILeujC8Uxgr/vcehTfx4htfEo7r+cxz+hszP/hQ2S1xBdVgYK1447bXTOkdyTDHEXOq8rxeXWHjmkB3h+bVG3zkvd29muIOF5RvWUotJ4rXdHmERoaWOWJ4qIWbKFTA6fHWTPUZBjkWzokNigdGmOxjXH9Az+ZLRjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NriK2fzbsKsB4meMDOdhnip5A5pRc9DXh76TGL5w0Y8=;
 b=OoIFvhHQwyNEwuuuslTPo4wcRzCOSyQ8/okzUEfaWHWlFj1qVqOA3Ckk3tzqoq7+HQRj2hcjiXhaTBGWmFfCGkDDehTOYtfB9Sue47rIxRMqO0anqoI6DtS6nzz3qGHAQ2uZ+l+38UGfDCZJoq9acDAFUIEkPgmqtpx7laRLMbAM1fB0A508zA+EHIWKbYUYeaYjcV//EeDJaH/o+2uqkTbeP2zyZH2B4wC2XG0fjN/E7/8w75RVG/Xxt8QUvLx4KCcYJfM47JL5zRl33AQ3pKaaILrk14SYqll3rvegll1QMiI2cHlWJzUXvDOFvnQ1seSpPG9hSi/WJowb0y946g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NriK2fzbsKsB4meMDOdhnip5A5pRc9DXh76TGL5w0Y8=;
 b=SKjKB4CVnsEkwqVlryjN+iRzJLwxKxwfUVowdCXSf69qSmnEHCW0ASd5SVdn0qxpuTD9FY7gRXnl6g/ZHmOIxQYDXBGhcmwOaV+rLaAGH27B+YKTkk5a4c9Wdlfv4BaZ/O/9Dkci8q00GSa5TDzTmoFq0Lzky2I0VXVYjH0CGWybHhlieEm8Fcfx2R/wAMeKqtub4FZAHsSNOMfpPhq1zpJc2cN+0zSjMAr34Ej+b9DRduorgqAG7MPJqbqhja0Ykbaq9e9qo0PAnjNPA6nmKywAHr/z8XF/MIVkm+IEkuVEW28py3O9yPmXKL/itaAcfLayeod2cslSZSix4SG8KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 07:34:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 07:34:12 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 29 May 2026 16:33:43 +0900
Subject: [PATCH v7 3/4] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-nova-unload-v7-3-678f39209e00@nvidia.com>
References: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
In-Reply-To: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: cc13365d-e64f-49c0-c384-08debd54ad9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: CpxgU4nnkaXAcey8ll9/p9cxfowBbD4LTeFsG9hewvJTIiJa0AmKeu5vVvblHDaGes89AiHaXkhfPsL9Arp3rbn4HZSeY+nsKnXQoPn91ESebpv1I5caR3lRdVx+zRF1HTsMx9SxJdLjjTg32usXnmEcU5d2Ih5tOk68N5WKr6aeukc0aPUrquxo/NCsMYrAyLHEJyTDheamHdJQEY9iTQRKsCgFlMKeu7xmC6gsmUHAWFp0geXOeBBegXcZVnbCmTSu61rpy7CfscspcRPWjlSCbb1aEBJyKd9jaH9q5mLWAHoCzOTxH4qnpf2V3Pi7Q+PZlfqLM7h0T0xBm/TvTDsb8XXYMjpfUQE+k2zY+G1CPrMaDjgFqr8mR8XyCXYq9Oi0Pzrml7OmyjVjkxr8tGr+reJsm8BzyFZeuO/aAIgkBwZSDs6qbJAPvdBc8Hq16HJqjbSDthJDd9AFFB/5crcW+YLFdirgSoVPpQwNO6emwjLRww7vfgJF2TCyP7Y7Z6sNf5brybZ4F0JVRqhFrC78iHtCNnQi9S9TYRK7npS0O4j6tO5yXbs6uLb/ph2+WfEegzTV9K5+Rhh5PKA3MaaUY77hbVzDPpPnKD23INyomRsPNu277clPo6aj67pmYyOr65835adyGSpnYsA/PPGTyg1QNoT0JLmEZ0yNeQ9S7J8T93KboCLYXyex697I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdQT2VnN3ZNOC96ckttMG5sRVVhZWlldXk4S3pDT1lKSE1KL3dqRUc0bkh6?=
 =?utf-8?B?UEZreGN3MWhCbVowTjlKSHQ5WXpzYTY1QTdWSFRkUHd5dURpdFBYV0dvT0xo?=
 =?utf-8?B?RnJNeUVRMjc5ay8ycFJoNmNhVlZ3S3pHdUJOR1hESVJsWUl1L2ZpNnUzczRh?=
 =?utf-8?B?MndOekx4cEJRdlZMRFVqdjZhQTVaL2ZzREg1ZHZPMWV6NVcyUHdnZGxTQ1F2?=
 =?utf-8?B?ZVU3cC8rdDVmYVlJeGJ0UmNqb1dUWUt3em43U2hRNEo1dWVSZzR4eXBnb0NF?=
 =?utf-8?B?amxGa1QxUU9jdkRUd0hwei9kS3ZDYWwrUTFMSy9jcU1sUnhMUGVZMzZ1MVVl?=
 =?utf-8?B?Q2R3Ni8yWDQzNVp5Ujh4WU9RNjlybmJCQ2RNbUN4Q2RUUW11LzZBTHpyMmJx?=
 =?utf-8?B?MUl5Rit6MDJvU1JaZmpaUlNpVWJCbFFHL2xsR3hwUFIyNkwwM1phWkNXSUYx?=
 =?utf-8?B?NldRdWRvRDd1aGE2Q053bmFIVE5US0NBeEJOOUdYSGwxOFduTmpSY0RaSVJL?=
 =?utf-8?B?cnU3aW1xaGV5T2pJZVRNZjB3ckRkcmcwanJJci84RFdaNGFRNnFFV2N4bTR4?=
 =?utf-8?B?aEQ2dWJIN1BNWVp1TmRqVWh5Q0NCdG4zeDRwL0duMThrVXpRdmtSa1MvcEhE?=
 =?utf-8?B?Mlk2Z3RzbDZ1aFllKzFnRjhSd09sUEtjV2UzenQzM3pyMkdyR3pZd2JwdGl3?=
 =?utf-8?B?LytlYmVjRis3ZENveFk2RkVhOG01M3pZZEl4UVJTdVkwV1FkNzhuZWQ5REVS?=
 =?utf-8?B?ZTk2SFhpaUM1ZEtvdkdOb0t5TzZzekZJMGF2eG0rSkRudVdIbTZhU0thSnRC?=
 =?utf-8?B?MlhENDBLc1NNL292bXhOSnA5ZEk5WWYrdDd4eENHcVNaR2FsalpKdHNrQzg4?=
 =?utf-8?B?cjZFVytrT1RJMWxUT2NKc1QzSy9DNUVhRE9tWEZobVl1eDVXdzYvdkU3cko5?=
 =?utf-8?B?ZGUwcU1YMWFXV3BrazBLbGt2VHM0NDZqa0puWFlqSzFQbEQ4SWdqSHpHWXEw?=
 =?utf-8?B?RnBSbVJWT082djJGV09NR1hqUGlQZ01DWUZFYkpoR0hMdGlsSThGOUR2bnh1?=
 =?utf-8?B?aFQ4eUFPcU13TTVIMGY2ZkRXZ3ZzL3FWcmJ3OGRKWHpuM2lrS0hXYlBrYkhU?=
 =?utf-8?B?TXFNNlozdHdUU0REWGZ2aVNsU0NhZktPQXR0aFp5OHR5YkZOYU1wTlRQVGdD?=
 =?utf-8?B?aHUwY1V5U0tLY1BZZzJ6RjNVL3JSOFI2N0dwblhsVjVUMnhFWFdyYkFpeGor?=
 =?utf-8?B?RWJTbGxRRzdFVmJtekFER3hDd0hMU2RKOXZrV3owT0d5RmlSQTk0Qk9wYUZK?=
 =?utf-8?B?ZFlYMHBQQUpOeElwSm1CTXZySUhDcEM1dDRRVWp2ZVNjN0dsS0RvcWs3Wm43?=
 =?utf-8?B?aTJKRVkrbnp1aklsbnVzTEYwV1I2aFRIbmYvaEhINE9MM096UGhzMlFLSkRr?=
 =?utf-8?B?R0ZEeDlLOUFyVUFmV3Z6L0xVN3ZwcURjckcwRDVoaTYxNG5HZ0FIMW96djJD?=
 =?utf-8?B?azUxWi9UdjkxTHNwSjk0ekd4UEIwVVpMYzVTZ1BXLy9LMWkvdkUyQlFacSti?=
 =?utf-8?B?VGdJQWlSR21BdXIwc2w5WlZhWEVVVXc2M2VjTkZvSXl3M1pnaHZlWU5ycWZR?=
 =?utf-8?B?OVR1LzlldG40NFJDa0JTYTFieGVreTVzK1EwT3NIOXZEamRuTkR6bUNadkxL?=
 =?utf-8?B?TVFiY2hkSS9nNjFUR1VkdkdISTBFOHJldHArZVk3N1NwT1ZVbzZOemhDWEpi?=
 =?utf-8?B?MlJwaDlRZGFrUnJYSTNuZ2RKQmZtOE1DWVorQkFyLzhFUnhjekJkbG5FWVV5?=
 =?utf-8?B?bjFVbVRXVlpZVXVxSTh4TnVWRS9vQ0lpSCtBemljdEl3WjhGMXErTlc3N0ww?=
 =?utf-8?B?U0tMbnQxMGJtM3oxRnFLYkRNWGZ5VHNIU2pKbHdFeVRnbGQxL1ovNDd1U2tF?=
 =?utf-8?B?dDg3NEQvd3RLNFE5QnlKb2w5VEorMUs1WjljK0YrRExjeG9rRkhiVWFiMk9a?=
 =?utf-8?B?dHhDU2gybGRDQXpyU0I5TEF6ZTFuQ0RnazFMOE9va1VGT1JINEliVU52VmlI?=
 =?utf-8?B?UUtjMkt1SndMbktYQkdEeVJjampoQzVrZ3hhVXRKMlE2R1Z5ZjhqbzJBa3B5?=
 =?utf-8?B?NXBtMEpXZmc4RUFjeXRuYWxWZkNWZHVlQS9XTUtvVkRybGRIbW41bU1RY3Mw?=
 =?utf-8?B?OVhEaC9CK0RhWGdXWloyZHpwTTBoZUVseTZuQm51eFJQRmlaR0EycUxHa1pB?=
 =?utf-8?B?enUvT0o5OFIvalJ5MEpjSytZRjdJQlpMMlBNSUUxcEUwZVNicm5SOU5Idllz?=
 =?utf-8?B?QjJpZ0JEcm5OL25jMWlsZlBDbCtBWTVMZ0VyQlNobzJ2UkdGYmZiQzVWaFBY?=
 =?utf-8?Q?U7MtYriFtSe4LP6JFStx1LdlA2JCU8GbbNnzltquYKoHY?=
X-MS-Exchange-AntiSpam-MessageData-1: ktlEZZaCVWVZdg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc13365d-e64f-49c0-c384-08debd54ad9a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:34:12.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tuolhc44f7LfS2S8ApftnhAv31JFJYlCvXZuEjGMzsnBfI60+tFk5XiVeOhJ4mVyW6ovgccczHuJryixclfxkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
memory region to store the GSP firmware, and the Booter Loader loads and
starts that firmware into the GSP, making it run in RISC-V mode.

These operations need to be reverted upon unloading, particularly the
WPR2 secure region creation, as its presence prevents the driver from
subsequently probing.

Thus, prepare the Booter Unloader and FWSEC-SB firmware images when
booting the GSP, so they can be executed at unbind time to put the GPU
into a state where it can be probed again.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware/booter.rs |   1 -
 drivers/gpu/nova-core/firmware/fwsec.rs  |   1 -
 drivers/gpu/nova-core/gpu.rs             |  15 +++-
 drivers/gpu/nova-core/gsp.rs             |   3 +
 drivers/gpu/nova-core/gsp/boot.rs        |  38 +++++++--
 drivers/gpu/nova-core/gsp/hal.rs         |  21 ++++-
 drivers/gpu/nova-core/gsp/hal/gh100.rs   |   2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs   | 142 ++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/regs.rs            |   5 ++
 9 files changed, 209 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index e45e5dc8d5d2..c5e17605e1a3 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -282,7 +282,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
 #[derive(Copy, Clone, Debug, PartialEq)]
 pub(crate) enum BooterKind {
     Loader,
-    #[expect(unused)]
     Unloader,
 }
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 8810cb49db67..4108f28cd338 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -144,7 +144,6 @@ pub(crate) enum FwsecCommand {
     /// image into it.
     Frts { frts_addr: u64, frts_size: u64 },
     /// Asks [`FwsecFirmware`] to load pre-OS apps on the PMU.
-    #[expect(dead_code)]
     Sb,
 }
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 011d504830e4..aed992488db3 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -18,7 +18,10 @@
         Falcon, //
     },
     fb::SysmemFlush,
-    gsp::Gsp,
+    gsp::{
+        self,
+        Gsp, //
+    },
     regs,
 };
 
@@ -260,6 +263,8 @@ pub(crate) struct Gpu<'gpu> {
     /// GSP runtime data. Temporarily an empty placeholder.
     #[pin]
     gsp: Gsp,
+    /// GSP unload firmware bundle, if any.
+    unload_bundle: Option<gsp::UnloadBundle>,
 }
 
 impl<'gpu> Gpu<'gpu> {
@@ -293,7 +298,10 @@ pub(crate) fn new(
 
             gsp <- Gsp::new(pdev),
 
-            _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
+            // This member must be initialized last, so the `UnloadBundle` can never be dropped from
+            // outside of the constructed `Gpu`, ensuring that the unload sequence is properly run
+            // in case of failure.
+            unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?,
         })
     }
 }
@@ -304,12 +312,13 @@ fn drop(self: Pin<&mut Self>) {
         let this = self.project();
         let device = *this.device;
         let bar = *this.bar;
+        let bundle = this.unload_bundle.take();
 
         let _ = this
             .gsp
             .as_ref()
             .get_ref()
-            .unload(device, bar, &*this.gsp_falcon)
+            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, bundle)
             .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\n", e));
     }
 }
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 38378f104068..1885cfa5cb38 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -185,3 +185,6 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
         })
     }
 }
+
+/// Opaque bundle required to unload the GSP. Created by [`Gsp::boot`], consumed by [`Gsp::unload`].
+pub(crate) struct UnloadBundle(KBox<dyn hal::UnloadBundle>);
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index adc66809ce83..8d6fcc35b653 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -38,7 +38,8 @@ impl super::Gsp {
     /// user-space, patching them with signatures, and building firmware-specific intricate data
     /// structures that the GSP will use at runtime.
     ///
-    /// Upon return, the GSP is up and running, and its runtime object given as return value.
+    /// Upon return, the GSP is up and running, and its unload bundle (to be given as argument to
+    /// [`Self::unload`]) returned.
     pub(crate) fn boot(
         self: Pin<&mut Self>,
         pdev: &pci::Device<device::Bound>,
@@ -46,7 +47,7 @@ pub(crate) fn boot(
         chipset: Chipset,
         gsp_falcon: &Falcon<Gsp>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<super::UnloadBundle>> {
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
@@ -57,8 +58,8 @@ pub(crate) fn boot(
 
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
-        // Perform the chipset-specific boot sequence.
-        hal.boot(
+        // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
+        let unload_bundle = hal.boot(
             &self,
             dev,
             bar,
@@ -98,7 +99,7 @@ pub(crate) fn boot(
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
         }
 
-        Ok(())
+        Ok(unload_bundle)
     }
 
     /// Shut down the GSP and wait until it is offline.
@@ -130,16 +131,35 @@ pub(crate) fn unload(
         dev: &device::Device<device::Bound>,
         bar: &Bar0,
         gsp_falcon: &Falcon<Gsp>,
+        sec2_falcon: &Falcon<Sec2>,
+        unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
-        // Shut down the GSP.
-        Self::shutdown_gsp(
+        // Shut down the GSP. Keep going even in case of error.
+        let mut res = Self::shutdown_gsp(
             &self.cmdq,
             bar,
             gsp_falcon,
             commands::PowerStateLevel::Level0,
         )
-        .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}\n", e))?;
+        .inspect_err(|e| dev_err!(dev, "GSP shutdown failed: {:?}\n", e));
 
-        Ok(())
+        // Run the unload bundle to reset the GSP so it can be booted again.
+        if let Some(unload_bundle) = unload_bundle {
+            res = res.and(
+                unload_bundle
+                    .0
+                    .run(dev, bar, gsp_falcon, sec2_falcon)
+                    .inspect_err(|e| dev_err!(dev, "Unload bundle failed: {:?}\n", e)),
+            );
+        } else {
+            dev_warn!(
+                dev,
+                "Unload bundle is missing, GSP won't be properly reset.\n"
+            );
+
+            res = Err(EAGAIN);
+        }
+
+        res.inspect(|()| dev_info!(dev, "GSP successfully unloaded\n"))
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index fb3edaeb3160..501b852dcb29 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -30,9 +30,28 @@
     },
 };
 
+/// Trait for types containing the resources and code required to fully reset the GSP.
+///
+/// The GSP unload code might run in a situation where we cannot load firmware dynamically (e.g.
+/// because we are in shutdown and the file system is not accessible anymore). Thus, the firmware
+/// required for unloading is prepared at load time, and stored here until it needs to be run.
+pub(super) trait UnloadBundle: Send {
+    /// Performs the steps required to properly reset the GSP after it has been stopped.
+    fn run(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result;
+}
+
 /// Trait implemented by GSP HALs.
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required firmwares as needed.
+    ///
+    /// Upon success, returns the [`UnloadBundle`] to be run (if any) in order to properly reset the
+    /// GSP after it has been stopped.
     #[allow(clippy::too_many_arguments)]
     fn boot(
         &self,
@@ -44,7 +63,7 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result;
+    ) -> Result<Option<crate::gsp::UnloadBundle>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 3f3675f9c16a..0a8b7f763883 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -41,7 +41,7 @@ fn boot(
         _wpr_meta: &Coherent<GspFwWprMeta>,
         _gsp_falcon: &Falcon<GspEngine>,
         _sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         Err(ENOTSUPP)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index a6f2b2e279e8..c4ab081f25c4 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -32,7 +32,10 @@
     },
     gpu::Chipset,
     gsp::{
-        hal::GspHal,
+        hal::{
+            GspHal,
+            UnloadBundle, //
+        },
         sequencer::{
             GspSequencer,
             GspSequencerParams, //
@@ -44,6 +47,124 @@
     vbios::Vbios, //
 };
 
+// A ready-to-run FWSEC unload firmware.
+//
+// Since there are two variants of the prepared firmware (with and without a bootloader), this type
+// abstracts the difference.
+enum FwsecUnloadFirmware {
+    WithoutBl(FwsecFirmware),
+    WithBl(FwsecFirmwareWithBl),
+}
+
+impl FwsecUnloadFirmware {
+    /// Loads the FWSEC SB firmware, as well as its bootloader if `chipset` requires it.
+    fn new(
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        chipset: Chipset,
+        bios: &Vbios,
+        gsp_falcon: &Falcon<GspEngine>,
+    ) -> Result<Self> {
+        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, bios, FwsecCommand::Sb)?;
+
+        Ok(if chipset.needs_fwsec_bootloader() {
+            Self::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
+        } else {
+            Self::WithoutBl(fwsec_sb)
+        })
+    }
+
+    /// Runs the FWSEC SB firmware.
+    fn run(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<GspEngine>,
+    ) -> Result<()> {
+        match self {
+            Self::WithoutBl(fw) => fw.run(dev, gsp_falcon, bar),
+            Self::WithBl(fw) => fw.run(dev, gsp_falcon, bar),
+        }
+    }
+}
+
+// Contains the firmware required to fully reset GSP on chipsets where the GSP is started using
+// FWSEC/Booter.
+struct Sec2UnloadBundle {
+    fwsec_sb: FwsecUnloadFirmware,
+    booter_unloader: BooterFirmware,
+}
+
+impl Sec2UnloadBundle {
+    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
+    fn build(
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        chipset: Chipset,
+        bios: &Vbios,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result<KBox<dyn UnloadBundle>> {
+        KBox::new(
+            Self {
+                fwsec_sb: FwsecUnloadFirmware::new(dev, bar, chipset, bios, gsp_falcon)?,
+                booter_unloader: BooterFirmware::new(
+                    dev,
+                    BooterKind::Unloader,
+                    chipset,
+                    FIRMWARE_VERSION,
+                    sec2_falcon,
+                    bar,
+                )?,
+            },
+            GFP_KERNEL,
+        )
+        .map(|b| b as KBox<dyn UnloadBundle>)
+        .map_err(Into::into)
+    }
+}
+
+impl UnloadBundle for Sec2UnloadBundle {
+    fn run(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result<()> {
+        // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
+        self.fwsec_sb.run(dev, bar, gsp_falcon)?;
+
+        // Remove WPR2 region if set.
+        let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+        if wpr2_hi.is_wpr2_set() {
+            sec2_falcon.reset(bar)?;
+            sec2_falcon.load(dev, bar, &self.booter_unloader)?;
+
+            // Sentinel value to confirm that Booter Unloader has run.
+            const MAILBOX_SENTINEL: u32 = 0xff;
+            let (mbox0, _) =
+                sec2_falcon.boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX_SENTINEL))?;
+            if mbox0 != 0 {
+                dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", mbox0);
+                return Err(EINVAL);
+            }
+
+            // Confirm that the WPR2 region has been removed.
+            let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+            if wpr2_hi.is_wpr2_set() {
+                dev_err!(
+                    dev,
+                    "WPR2 region still set after Booter Unloader returned\n"
+                );
+                return Err(EBUSY);
+            }
+        }
+
+        Ok(())
+    }
+}
+
 /// Helper function to load and run the FWSEC-FRTS firmware and confirm that it has properly
 /// created the WPR2 region.
 fn run_fwsec_frts(
@@ -143,9 +264,24 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let bios = Vbios::new(dev, bar)?;
 
+        // Try and prepare the unload bundle. If this fails, the GPU will need to be reset
+        // before the driver can be probed again.
+        let unload_bundle =
+            Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
+                .inspect_err(|e| {
+                    dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
+                    dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+                    dev_warn!(
+                        dev,
+                        "The GPU will need to be reset before the driver can bind again.\n"
+                    );
+                })
+                .map(crate::gsp::UnloadBundle)
+                .ok();
+
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
             run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
@@ -175,7 +311,7 @@ fn boot(
         )?
         .run(dev, bar, sec2_falcon, wpr_meta)?;
 
-        Ok(())
+        Ok(unload_bundle)
     }
 
     fn post_boot(
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 6faeed73901d..356fbf364ea5 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -175,6 +175,11 @@ impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
     pub(crate) fn higher_bound(self) -> u64 {
         u64::from(self.hi_val()) << 12
     }
+
+    /// Returns whether the WPR2 region is currently set.
+    pub(crate) fn is_wpr2_set(self) -> bool {
+        self.hi_val() != 0
+    }
 }
 
 // PGSP

-- 
2.54.0

