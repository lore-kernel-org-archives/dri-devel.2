Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF15C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2474F10E48A;
	Fri, 28 Aug 2026 05:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cU07Kyh7";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6874310E48A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBKquO58mOGbZVyC0SRmtYgRrQhCpIdMwkeVqAzKP0wH5VeeoKOVN4E5/3vV+SO8wiyTtoHjcs9SL92YETTeiRY+HnC35dDTaSx6BgS6nReRm7hPdWoFKU5DrQlBczqzC4PIEADrel9DlL7cK2V+JbPE+lK1ehNsQ5eLcFzXGY0MII5FkMy55WfQ8VUbinA19EGdDADeE44UH3CzdurHnmVbdnbAO/nvP7Qfl8XrF81y8/ftau6HI6EqNzQafbfUVxdw7PgX2JrDHLphL3g1Qf5IYhUbZUGV7E4WB5GOPyF+YYLKm+Nixu+EZi7E5HjoWp3DL5BnfLE07LRjZjyHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Em72i+5iBo541RzGYurqidQ1JtokiydmndZYAKpByME=;
 b=aKdcoqKgj3vkVjnBq/Cvms9RNKBDc/eTa3q54ZOXGk2nx1f1RYmqGtWjgj0E3KPc7LSJpWdlPmiRxj1D83yGXQmi6cVbmwNI0AIgNKWfveLtTweGfZM57/8MHQitnkBG+bB8Pb63WrAUB4FgTvVp/OL3RnRhHcBo1GreCJHeobb0S62glgUb2wNAbBko3BPIkeStwKotMYOenvPHI6ID/29bTBbgPksT4l6C1imCgiLtrAr1RI5yE4zEY+vhTXZKKlzy38X197Y6bRblSDVyBJqXigT/YboqukLpztpZpBoAntLhnCCoG9MqDjb0ZaMsk0l3gTXp7OMXVoKJt5song==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em72i+5iBo541RzGYurqidQ1JtokiydmndZYAKpByME=;
 b=cU07Kyh7G+EjXKkNsxxxe/4+uN2YJCoTO/TZEVyhHvwmY1rbI63XGnidJAGjdEEkjOks3DhQaberpC7rT3lHyqTP6iu+UfJ8AYh6ckOit34tsWyWdyVVUhn2TVqoK30NtmI9pRFl0xsc8xvCk4hrF6Wlp+UKm2E3scNf9okmj6G+2VKOQcx8bFXufxhfA5p1E1QL3Rm8bR5zJRraudDD9LFc9Adv+bCDLJhoxewWDHJQokEo53AuZN9V+V+h7Cv8FShDLYYNuB3TlsyNMWXVvN0lUD6nx1ew8rnQMa4XBPcATN3mB9XLk2NPgeQUWDkRKsfNU6dX00kmmXU2MpIyFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 05:33:20 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Fri, 28 Aug 2026
 05:33:20 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 28 Aug 2026 14:33:13 +0900
Subject: [PATCH 1/2] gpu: nova-core: use kernel lossless integer conversion
 module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-nova_num-v1-1-e21f17ba4127@nvidia.com>
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
In-Reply-To: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 92701848-bd2d-45e8-9bf1-08df04c5deef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gEQbRzoREUScSuMz9RUJ4JSyIDDbF1b164lL190HZbuwvuicunOdhMVPORw6J64GRlYhBPJzftmmGn09FwrkK8FNOkcxhz0UE0l++V3v1n4DBdQB4c3pTnsHHjt1lBSuoM2ILzcVzva1x3Ku5q9je5e7uNbeX9vCfhDnWGAFpg5CWoSPJ32+s0GZVZRt24SMFZPU7lRSNyFKrzX80lCzqkNe13bXXxZ6l7l8oTUu+LphyIWL+bvgWTc+eBFXG7p+mnXLq2rHty5QXGKxoCnepRsop/OtRi+zqHPWsVdRJadwZyPE/HiSYn4l1mreGdh/pJCQZGBslaRo92/50R1liTKfRJ9Sm5081z2jiaTcuvZ+sHVI5XDc4iMnCaMjiC8YLLG6U/dzKYWdx9OcpXzUG+baJN3MtQkuqI3WCLI5LwYjqRJOgv1ra3oCvD48gB7o9P/5eHQhBgZ/v9cmYAJbFjbAicsSYtyi44Oi6v0NE5LVg5/YbGLktGM78W5DuEDKQldJEPbCVJNHc6jDpsJV992F3vN+ptNG1d3Gyr4OlzDX6pT+IgIhXmNrCVmSAUnAh4mWWPxk3s6oTngNDdsLMOsEQQ5eU5J461JpOyivOwf2pOU1YE1JGQe7He3nkhtT0KLIzbR6Z08DX+w/SdXni4e13aF+x3VXlV+6LhIFp6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThFelh4TXZyWnR3TUFsS0tCNVVpblFRUEZCUi9qVUN2Q01Id3RYOEVuanph?=
 =?utf-8?B?amZuUzlickhOWUx3WGtnSlMzU2pNeGxmWWxYUGNNL1BYUldTUEQxM1JjRGFo?=
 =?utf-8?B?a0JBMmxrTHp3T3VDQlpqOVN6blFDV2NjYUgwMG90RkZnS0J5RWx3TjBuek5P?=
 =?utf-8?B?cFZ3SkJIS2d5SVVTMkFFTFhpejQzV0NxSnJDYWg0RDROZ3hPNGdZbzlyV2lD?=
 =?utf-8?B?RXBNMXFhbFVmWmNpNjZCNGRnaUMvbGJlNnZLakdTR050ZkNoZ1gwRVJqV3dS?=
 =?utf-8?B?TjBTTVJqTy9Rc1BEbnRqT1hPZGZLVy9uejJLcGFKbGtzeksrL3hBVDZETllj?=
 =?utf-8?B?dUJwelo3aXIrZjMxSHFxbnhpRitORjJSd25FTUM5T0lKUXA2MVgwWFJMdTNo?=
 =?utf-8?B?MjdKaDVwZDM4eFhWMm1QdjNTakk2cnhmUENIWW50N0M2VHdFS0lkRzFZNG1M?=
 =?utf-8?B?M1ZGMGRJRlFUT2RkU1BQR280aVNGQktjdXE2cXhNRWJ4UFdDZExIdlNZM0Ex?=
 =?utf-8?B?Z3ZQY3cycVFWYmczb2ExdDBVMU1mb1Y5VHB1UHJwVTFVbjJLbzFVMGFBdFRR?=
 =?utf-8?B?amdpdUlGc2lqeUdpbDZ4QjA0RERsOXpLSTJXT2tuRFpuZVVZT2FMOW11MjQ4?=
 =?utf-8?B?a2RFM2wzSnhWZm1UTytZSDFMYzcwN2NGRnpDT2tpNytsSE5tQ1p0a0ZRdEla?=
 =?utf-8?B?Y3ErY3preGY3c2VNZlhieXBuakkxUHpjeWFQTG44T1hVaXN1RkViUkRmT3Ey?=
 =?utf-8?B?bC91Rnh6MVM2OHRtTnlyZG1rMFFOS2JTTHdqLzZNWFJhaVBzbjVubHlGSGJl?=
 =?utf-8?B?UTl5QmVjUFJPb09wZVlLR1I3ZVgraXhhYnZ2OFVYaXdCTExnSWVYUE9UYmNG?=
 =?utf-8?B?Mk94UUFKMUdDb29xN1p4OWptVjB4aTlOMktEcnlkNVJ3RTFhREd3TGIxV2JD?=
 =?utf-8?B?R0dGT0F0a05rV3hVeWcyb0oyR2pQRjhlcGhvOVl4cm9XVHZZdGlYSGNKaFVo?=
 =?utf-8?B?QzdWRWhKZ0U2Q0JPdGRtWDA0dzhLOThHbEFPczNTcDNPcnd0VS9SVS9ieXYy?=
 =?utf-8?B?M1hES2F5aVBiVnBPc1MvU1BvWWkzYXhyOU1LSFBWK0pCaGt0NFk4MDJJZFRa?=
 =?utf-8?B?VXg5SUZiYXljd0k3N2RtMkhRU3FLbUhsNGQvbS9QQWh1N1Aya0Nlc2tyU3FT?=
 =?utf-8?B?Qk5qVVRBcmFlek5BdFdIajB5RXQvK0Z1UURseUptWWJUcWIxMkYwdFZKTWM0?=
 =?utf-8?B?QXoySUEwdy8yQ3VQbFhGL1lzSlRFdytYYkJYOThKTUxWeTRQczBIWWttOWhB?=
 =?utf-8?B?SzdRZ2JhOHZnYlZwOWU0c3hoTCswazUvYlBwM3VXekJ4TVVKMjdGMzVHSS8r?=
 =?utf-8?B?c25QaGllZXRvR1VOWERGTXRjMTdodjFDNmRqcXVZT093c3U2YkFPTStLc2ZY?=
 =?utf-8?B?U3RLVGh5UEFLOGwwS09nZ3dNOWc3TlpjNmVBVlcvbDkyaGYvUlFWUnFJY21J?=
 =?utf-8?B?aEpUVlJxVUdlRVRXRGQwd0MrSVptTi9ycXhoMFU3dWpLZk10bU4rdWhzbUVv?=
 =?utf-8?B?ZFNIL1lyWnpIeGU5OHVCbzFybGYzUU42dEFZeEcrVFVnQ2htQzRibjhHSk5S?=
 =?utf-8?B?QThlRmhtcFZ3QmlzVUpFRXVPRmJ2TG14OUJ6dlowK3ZCZG12MEpzekg3MFk1?=
 =?utf-8?B?MEF1anlkYTlKS2FoL21UNDNzSEw2bHgxQ3lLOERXekpLVitFZ0pNYU5ZVlNX?=
 =?utf-8?B?VGhHUEJYMEJWZ3E4K3Z2OXUrOUJUUXBjME0xdVd0VHg0SFQyS0tXa29QQTd1?=
 =?utf-8?B?aUFldEdEOHVFakx1MUV6UjZjb205eXpxZjExa2dKWHUwSEZnYWdTNnNEYWsz?=
 =?utf-8?B?TlAvZnNCUG9LVjNlenhZZ3RzRDQ0UGp4ZEgzTG1LUFpZYTUwdkFteU9Fa2lh?=
 =?utf-8?B?Q2RaY25kUVlXL0oyN1J2UU5IVVhEaHpBcVVieGVIYlNQcytQSmV6Y1BvRWRD?=
 =?utf-8?B?NHN5cEhBcUVsZ2FHUGdsUWpSbVNzV2xsMTdyQXJFcXptaWFkT3ZzdjFDcGIv?=
 =?utf-8?B?a3FPUlBSOUlsZVRiQWNRS1dmL2J4amhxek4yY3VHVEZNSGZrUEdhdzEzZlpa?=
 =?utf-8?B?aVNEYkJabnZPMzBmam1yK001ZGJoTytuZCsxMjU1VUVaN01uamNxM08ydEQw?=
 =?utf-8?B?Q3dQWTNVbGM0Y2JNeXpaaWgvaC9CbWt2dzdXWHlUUXVSWTkzRFQweUpFWUJX?=
 =?utf-8?B?cC84LzZicWthUHlKdEdwVlVRWWJYcmJnVks4SlV6aEw0SnYvZFVjL0tqUjhR?=
 =?utf-8?B?UkFoM0Z5RjdXQk9ldzFDTTNPeWN2c1p6R3YybTJkUXduQTlTMUVnSFh3ZFNS?=
 =?utf-8?Q?0VbszaTrIe3ua32+jZD6txWXaseIOJ08UDdUu94Lkl060?=
X-MS-Exchange-AntiSpam-MessageData-1: 0wd1TjfIZ3VGfQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92701848-bd2d-45e8-9bf1-08df04c5deef
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:33:20.7168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n+QGKmU0a87ugs88yGoMRAtsCWcPG+TIIryK5IqWOOn/vnDKYtYMLHFqyApydg2i40OuDE+2Yrj8P0l7ElzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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

The `kernel` crate now features a replacement for our lossless integer
conversion routines. Switch to the kernel version and remove our own.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    |  12 +-
 drivers/gpu/nova-core/falcon/fsp.rs                |   4 +-
 drivers/gpu/nova-core/fb.rs                        |   2 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   6 +-
 drivers/gpu/nova-core/firmware.rs                  |   4 +-
 drivers/gpu/nova-core/firmware/booter.rs           |   4 +-
 drivers/gpu/nova-core/firmware/fwsec.rs            |   2 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   4 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |   9 +-
 drivers/gpu/nova-core/firmware/tlv.rs              |  11 +-
 drivers/gpu/nova-core/fsp.rs                       |   8 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  22 +--
 drivers/gpu/nova-core/gsp/fw.rs                    |  42 ++--
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   4 +-
 drivers/gpu/nova-core/gsp/sequencer.rs             |   2 +-
 drivers/gpu/nova-core/mctp.rs                      |   8 +-
 drivers/gpu/nova-core/num.rs                       | 211 ---------------------
 drivers/gpu/nova-core/vbios.rs                     |   2 +-
 19 files changed, 78 insertions(+), 283 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 65cb12d26e2b..dfe4d2e6f82e 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -20,6 +20,10 @@
         },
         Io,
     },
+    num::casts::{
+        self,
+        FromSafeCast, //
+    },
     prelude::*,
     time::Delta,
 };
@@ -29,11 +33,7 @@
     driver::Bar0,
     falcon::hal::LoadMethod,
     gpu::Chipset,
-    num::{
-        self,
-        FromSafeCast, //
-    },
-    regs,
+    regs, //
 };
 
 pub(crate) mod fsp;
@@ -510,7 +510,7 @@ fn dma_wr(
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
     ) -> Result {
-        const DMA_LEN: u32 = num::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+        const DMA_LEN: u32 = casts::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
 
         // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
         // need to perform.
diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 0437180b8829..2470ac511c98 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -16,6 +16,7 @@
         },
         Io, //
     },
+    num::casts,
     prelude::*,
     sizes::SZ_1K,
     time::Delta,
@@ -28,7 +29,6 @@
         PFalcon2Base,
         PFalconBase, //
     },
-    num,
     regs, //
 };
 
@@ -165,7 +165,7 @@ pub(crate) fn recv_msg(&mut self) -> Result<KVec<u8>> {
             Delta::from_millis(10),
             Delta::from_millis(FSP_MSG_TIMEOUT_MS),
         )
-        .map(num::u32_as_usize)?;
+        .map(casts::u32_as_usize)?;
 
         // Don't blindly allocate more than the maximum we expect from FSP.
         if msg_size > FSP_EMEM_CHANNEL_0_SIZE {
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 1576399389b1..8d5d9480378f 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -10,6 +10,7 @@
     dma::CoherentHandle,
     fmt,
     io::Io,
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -23,7 +24,6 @@
     firmware::gsp::GspFirmware,
     gpu::Chipset,
     gsp,
-    num::FromSafeCast,
     vgpu::VgpuState, //
 };
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index d9e4d62ae632..a53d8b435dc2 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -11,7 +11,10 @@
         },
         Io, //
     },
-    num::Bounded,
+    num::{
+        casts::usize_into_u32,
+        Bounded, //
+    },
     prelude::*,
     ptr::{
         const_align_up,
@@ -26,7 +29,6 @@
         hal::FbHal,
         regs, //
     },
-    num::usize_into_u32,
 };
 
 struct Gb100;
diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index b49613a90bf0..19f13779bb30 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -9,6 +9,7 @@
 
 use kernel::{
     firmware,
+    num::casts::IntoSafeCast,
     prelude::*, //
 };
 
@@ -18,8 +19,7 @@
         FalconFirmware, //
     },
     gpu,
-    gsp::boot_firmware_files,
-    num::IntoSafeCast, //
+    gsp::boot_firmware_files, //
 };
 
 pub(crate) mod booter;
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index dc071edba331..aa830455b7e7 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -10,6 +10,7 @@
 use kernel::{
     device,
     dma::Coherent,
+    num::casts::IntoSafeCast,
     prelude::*, //
 };
 
@@ -32,8 +33,7 @@
         Signed,
         Unsigned, //
     },
-    gpu::Chipset,
-    num::IntoSafeCast,
+    gpu::Chipset, //
 };
 
 /// Signature for Booter firmware. Their size is encoded into the header and not known a compile
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 7a931f22f629..7f7ca3ba2298 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -19,6 +19,7 @@
         self,
         Device, //
     },
+    num::casts::FromSafeCast,
     prelude::*,
     transmute::{
         AsBytes,
@@ -42,7 +43,6 @@
         Signed,
         Unsigned, //
     },
-    num::FromSafeCast,
     vbios::Vbios,
 };
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index ec4d92317a93..d1fb7d2d7480 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -13,6 +13,7 @@
     },
     dma::Coherent,
     io::{register::WithBase, Io},
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -45,8 +46,7 @@
         },
     },
     gpu::Chipset,
-    num::FromSafeCast, //
-    regs,
+    regs, //
 };
 
 /// Structure used by the boot-loader to load the rest of the code.
diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index e8f9491e84cc..e75ce6fe47d8 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -9,6 +9,10 @@
         DmaAddress, //
     },
     firmware,
+    num::casts::{
+        arch::FromSafeCastArch,
+        FromSafeCast, //
+    },
     prelude::*,
     scatterlist::{
         Owned,
@@ -26,8 +30,7 @@
         },
     },
     gpu::Chipset,
-    gsp::GSP_PAGE_SIZE,
-    num::FromSafeCast,
+    gsp::GSP_PAGE_SIZE, //
 };
 
 /// GSP firmware with 3-level radix page tables for the GSP bootloader.
@@ -154,7 +157,7 @@ pub(crate) fn radix3_dma_address(&self) -> DmaAddress {
 fn map_into_lvl(sg_table: &SGTable<Owned<VVec<u8>>>, mut dst: VVec<u8>) -> Result<VVec<u8>> {
     for sg_entry in sg_table.iter() {
         // Number of pages we need to map.
-        let num_pages = usize::from_safe_cast(sg_entry.dma_len()).div_ceil(GSP_PAGE_SIZE);
+        let num_pages = usize::from_safe_cast_arch(sg_entry.dma_len()).div_ceil(GSP_PAGE_SIZE);
 
         for i in 0..num_pages {
             let entry = sg_entry.dma_address()
diff --git a/drivers/gpu/nova-core/firmware/tlv.rs b/drivers/gpu/nova-core/firmware/tlv.rs
index 7b879f13a61e..6653c10e3e0a 100644
--- a/drivers/gpu/nova-core/firmware/tlv.rs
+++ b/drivers/gpu/nova-core/firmware/tlv.rs
@@ -4,14 +4,15 @@
 use kernel::{
     device,
     firmware,
+    num::casts::{
+        self,
+        IntoSafeCast, //
+    },
     prelude::*,
     str::CString, //
 };
 
-use crate::{
-    gpu,
-    num::*, //
-};
+use crate::gpu;
 
 /// Requests the GPU firmware TLV `name` suitable for `chipset`.
 pub(crate) fn request_tlv(
@@ -51,7 +52,7 @@ fn parse(hdr: &[u8]) -> Option<Self> {
             return None;
         }
         let len_arr = <[u8; 4]>::try_from(hdr.get(4..Self::SIZE)?).ok()?;
-        let length = u32_as_usize(u32::from_le_bytes(len_arr));
+        let length = casts::u32_as_usize(u32::from_le_bytes(len_arr));
         Some(Self { tag, length })
     }
 }
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index ab685fb4168f..b9ca298dc97f 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -11,7 +11,10 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
-    num::TryIntoBounded,
+    num::{
+        casts,
+        TryIntoBounded, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -47,7 +50,6 @@
         NvdmHeader,
         NvdmType, //
     },
-    num,
     regs, //
 };
 
@@ -285,7 +287,7 @@ fn new<'a>(
         };
 
         let version = hal.cot_version();
-        let size = num::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
+        let size = casts::usize_into_u16::<{ core::mem::size_of::<NvdmPayloadCot>() }>();
 
         Ok(init!(Self {
             header: FspMessageHeader::new(NvdmType::Cot),
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 13f361406a6c..fc8648de84c2 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -17,6 +17,7 @@
         io_write,
         Io, //
     },
+    num::casts,
     pci,
     prelude::*, //
 };
@@ -48,7 +49,6 @@
         cmdq::Cmdq,
         fw::GspArgumentsPadded, //
     },
-    num,
     vgpu::VgpuManager, //
 };
 
@@ -92,7 +92,7 @@ fn init(view: CoherentView<'_, Self>, start: DmaAddress) -> Result<()> {
         for i in 0..NUM_PAGES {
             io_write!(view, .0[build: i],
                 start
-                    .checked_add(num::usize_as_u64(i) << GSP_PAGE_SHIFT)
+                    .checked_add(casts::usize_as_u64(i) << GSP_PAGE_SHIFT)
                     .ok_or(EOVERFLOW)?
             );
         }
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 6da728201281..f85fde09aa6e 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -23,6 +23,7 @@
         Io, //
     },
     new_mutex,
+    num::casts,
     prelude::*,
     ptr,
     sync::{
@@ -57,7 +58,6 @@
         GSP_PAGE_SHIFT,
         GSP_PAGE_SIZE, //
     },
-    num,
     sbuffer::SBufferIter, //
 };
 
@@ -162,7 +162,7 @@ fn read(
 #[repr(C, align(0x1000))]
 #[derive(Debug)]
 struct MsgqData {
-    data: [[u8; GSP_PAGE_SIZE]; num::u32_as_usize(MSGQ_NUM_PAGES)],
+    data: [[u8; GSP_PAGE_SIZE]; casts::u32_as_usize(MSGQ_NUM_PAGES)],
 }
 
 // Annoyingly we are forced to use a literal to specify the alignment of
@@ -235,8 +235,8 @@ unsafe impl FromBytes for GspMem {}
 impl DmaGspMem {
     /// Allocate a new instance and map it for `dev`.
     fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
-        const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
-        const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
+        const MSGQ_SIZE: u32 = casts::usize_into_u32::<{ size_of::<Msgq>() }>();
+        const RX_HDR_OFF: u32 = casts::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
 
         let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
         gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
@@ -289,10 +289,10 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         unsafe {
             (
                 core::slice::from_raw_parts_mut(
-                    data.add(num::u32_as_usize(tx)),
-                    num::u32_as_usize(tail_end - tx),
+                    data.add(casts::u32_as_usize(tx)),
+                    casts::u32_as_usize(tail_end - tx),
                 ),
-                core::slice::from_raw_parts_mut(data, num::u32_as_usize(wrap_end)),
+                core::slice::from_raw_parts_mut(data, casts::u32_as_usize(wrap_end)),
             )
         }
     }
@@ -307,7 +307,7 @@ fn driver_write_area_size(&self) -> usize {
         // `cpu_write_ptr`. The minimum value case is where `rx == 0` and `tx == MSGQ_NUM_PAGES -
         // 1`, which gives `0 + MSGQ_NUM_PAGES - (MSGQ_NUM_PAGES - 1) - 1 == 0`.
         let slots = (rx + MSGQ_NUM_PAGES - tx - 1) % MSGQ_NUM_PAGES;
-        num::u32_as_usize(slots) * GSP_PAGE_SIZE
+        casts::u32_as_usize(slots) * GSP_PAGE_SIZE
     }
 
     /// Returns the region of the GSP message queue that the driver is currently allowed to read
@@ -343,10 +343,10 @@ fn driver_write_area_size(&self) -> usize {
         unsafe {
             (
                 core::slice::from_raw_parts(
-                    data.add(num::u32_as_usize(rx)),
-                    num::u32_as_usize(tail_end - rx),
+                    data.add(casts::u32_as_usize(rx)),
+                    casts::u32_as_usize(tail_end - rx),
                 ),
-                core::slice::from_raw_parts(data, num::u32_as_usize(wrap_end)),
+                core::slice::from_raw_parts(data, casts::u32_as_usize(wrap_end)),
             )
         }
     }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 05f54fee6186..88f083ff1f13 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -19,6 +19,10 @@
         io_read,
         io_write, //
     },
+    num::casts::{
+        self,
+        FromSafeCast, //
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -49,15 +53,11 @@
         cmdq::Cmdq, //
         GSP_PAGE_SIZE,
     },
-    num::{
-        self,
-        FromSafeCast, //
-    },
 };
 
 /// Maximum size of a single GSP message queue element in bytes.
 pub(crate) const GSP_MSG_QUEUE_ELEMENT_SIZE_MAX: usize =
-    num::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
+    casts::u32_as_usize(bindings::GSP_MSG_QUEUE_ELEMENT_SIZE_MAX);
 
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
@@ -110,19 +110,19 @@ pub(crate) struct LibosParams {
 impl LibosParams {
     /// Version 2 of the GSP LIBOS (Turing and GA100)
     const LIBOS2: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
-        allowed_heap_size: num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB)
+        carveout_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2),
+        allowed_heap_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MIN_MB)
             * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB) * u64::SZ_1M,
+            ..casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS2_MAX_MB) * u64::SZ_1M,
     };
 
     /// Version 3 of the GSP LIBOS (GA102+)
     const LIBOS3: LibosParams = LibosParams {
-        carveout_size: num::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
-        allowed_heap_size: num::u32_as_u64(
+        carveout_size: casts::u32_as_u64(bindings::GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL),
+        allowed_heap_size: casts::u32_as_u64(
             bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MIN_MB,
         ) * u64::SZ_1M
-            ..num::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB)
+            ..casts::u32_as_u64(bindings::GSP_FW_HEAP_SIZE_OVERRIDE_LIBOS3_BAREMETAL_MAX_MB)
                 * u64::SZ_1M,
     };
 
@@ -681,11 +681,11 @@ fn id8(name: &str) -> u64 {
         let init_inner = init!(bindings::LibosMemoryRegionInitArgument {
             id8: id8(name),
             pa: obj.dma_address(),
-            size: num::usize_as_u64(obj.size()),
-            kind: num::u32_into_u8::<
+            size: casts::usize_as_u64(obj.size()),
+            kind: casts::u32_into_u8::<
                 { bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS },
             >(),
-            loc: num::u32_into_u8::<
+            loc: casts::u32_into_u8::<
                 { bindings::LibosMemoryRegionLoc_LIBOS_MEMORY_REGION_LOC_SYSMEM },
             >(),
             ..Zeroable::init_zeroed()
@@ -715,12 +715,12 @@ pub(crate) fn new(msgq_size: u32, rx_hdr_offset: u32, msg_count: u32) -> Self {
         Self(bindings::msgqTxHeader {
             version: 0,
             size: msgq_size,
-            msgSize: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            msgSize: casts::usize_into_u32::<GSP_PAGE_SIZE>(),
             msgCount: msg_count,
             writePtr: 0,
             flags: 1,
             rxHdrOff: rx_hdr_offset,
-            entryOff: num::usize_into_u32::<GSP_PAGE_SIZE>(),
+            entryOff: casts::usize_into_u32::<GSP_PAGE_SIZE>(),
         })
     }
 
@@ -851,7 +851,7 @@ pub(crate) fn set_checksum(&mut self, checksum: u32) {
     /// Returns the length of the message's payload.
     pub(crate) fn payload_length(&self) -> usize {
         // `rpc.length` includes the length of the RPC message header.
-        num::u32_as_usize(self.inner.rpc.length)
+        casts::u32_as_usize(self.inner.rpc.length)
             .saturating_sub(size_of::<bindings::rpc_message_header_v>())
     }
 
@@ -947,9 +947,9 @@ impl MessageQueueInitArguments {
     fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_addr,
-            pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
-            cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
-            statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),
+            pageTableEntryCount: casts::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
+            cmdQueueOffset: casts::usize_as_u64(Cmdq::CMDQ_OFFSET),
+            statQueueOffset: casts::usize_as_u64(Cmdq::STATQ_OFFSET),
             ..Zeroable::init_zeroed()
         })
     }
@@ -969,7 +969,7 @@ impl GspAcrBootGspRmParams {
     fn new(target: GspDmaTarget, wpr_meta_addr: u64) -> impl Init<Self> {
         let params = init!(Self {
             target: target as u32,
-            gspRmDescSize: num::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
+            gspRmDescSize: casts::usize_into_u32::<{ size_of::<GspFwWprMeta>() }>(),
             gspRmDescOffset: wpr_meta_addr,
             bIsGspRmBoot: 1,
             wprCarveoutOffset: 0,
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..201594fa437b 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -5,6 +5,7 @@
 
 use kernel::{
     device,
+    num::casts::IntoSafeCast,
     pci,
     prelude::*,
     transmute::{
@@ -15,8 +16,7 @@
 
 use crate::{
     gpu::Chipset,
-    gsp::GSP_PAGE_SIZE,
-    num::IntoSafeCast, //
+    gsp::GSP_PAGE_SIZE, //
 };
 
 use super::bindings;
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index bcad1421953a..fed881ba80b0 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -11,6 +11,7 @@
         poll::read_poll_timeout,
         Io, //
     },
+    num::casts::FromSafeCast,
     prelude::*,
     time::{
         delay::fsleep,
@@ -35,7 +36,6 @@
         GspBootContext,
         LibosMemoryRegionInitArgument, //
     },
-    num::FromSafeCast,
     sbuffer::SBufferIter,
 };
 
diff --git a/drivers/gpu/nova-core/mctp.rs b/drivers/gpu/nova-core/mctp.rs
index 90c642c91a72..67f64ac2b8d1 100644
--- a/drivers/gpu/nova-core/mctp.rs
+++ b/drivers/gpu/nova-core/mctp.rs
@@ -9,14 +9,12 @@
 
 use kernel::{
     bitfield,
+    num::casts,
     pci::Vendor,
     prelude::*, //
 };
 
-use crate::{
-    bounded_enum,
-    num, //
-};
+use crate::bounded_enum;
 
 bounded_enum! {
     /// NVDM message type identifiers carried over MCTP.
@@ -76,7 +74,7 @@ impl NvdmHeader {
     /// Builds an NVDM header for the given message type.
     pub(crate) fn new(nvdm_type: NvdmType) -> Self {
         Self::zeroed()
-            .with_const_msg_type::<{ num::u8_as_u32(MSG_TYPE_VENDOR_PCI) }>()
+            .with_const_msg_type::<{ casts::u8_as_u32(MSG_TYPE_VENDOR_PCI) }>()
             .with_vendor_id(Vendor::NVIDIA.as_raw())
             .with_nvdm_type(nvdm_type)
     }
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index 6eb174d136ab..3921ef6f238e 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -5,217 +5,6 @@
 //! This is essentially a staging module for code to mature until it can be moved to the `kernel`
 //! crate.
 
-use kernel::{
-    macros::paste,
-    prelude::*, //
-};
-
-/// Implements safe `as` conversion functions from a given type into a series of target types.
-///
-/// These functions can be used in place of `as`, with the guarantee that they will be lossless.
-macro_rules! impl_safe_as {
-    ($from:ty as { $($into:ty),* }) => {
-        $(
-        paste! {
-            #[doc = ::core::concat!(
-                "Losslessly converts a [`",
-                ::core::stringify!($from),
-                "`] into a [`",
-                ::core::stringify!($into),
-                "`].")]
-            ///
-            /// This conversion is allowed as it is always lossless. Prefer this over the `as`
-            /// keyword to ensure no lossy casts are performed.
-            ///
-            /// This is for use from a `const` context. For non `const` use, prefer the
-            /// [`FromSafeCast`] and [`IntoSafeCast`] traits.
-            ///
-            /// # Examples
-            ///
-            /// ```
-            /// use crate::num;
-            ///
-            #[doc = ::core::concat!(
-                "assert_eq!(num::",
-                ::core::stringify!($from),
-                "_as_",
-                ::core::stringify!($into),
-                "(1",
-                ::core::stringify!($from),
-                "), 1",
-                ::core::stringify!($into),
-                ");")]
-            /// ```
-            #[allow(unused)]
-            #[inline(always)]
-            pub(crate) const fn [<$from _as_ $into>](value: $from) -> $into {
-                ::kernel::build_assert::static_assert!(size_of::<$into>() >= size_of::<$from>());
-
-                value as $into
-            }
-        }
-        )*
-    };
-}
-
-impl_safe_as!(u8 as { u16, u32, u64, usize });
-impl_safe_as!(u16 as { u32, u64, usize });
-impl_safe_as!(u32 as { u64, usize } );
-// `u64` and `usize` have the same size on 64-bit platforms.
-#[cfg(CONFIG_64BIT)]
-impl_safe_as!(u64 as { usize } );
-
-// A `usize` fits into a `u64` on 32 and 64-bit platforms.
-#[cfg(any(CONFIG_32BIT, CONFIG_64BIT))]
-impl_safe_as!(usize as { u64 });
-
-// A `usize` fits into a `u32` on 32-bit platforms.
-#[cfg(CONFIG_32BIT)]
-impl_safe_as!(usize as { u32 });
-
-/// Extension trait providing guaranteed lossless cast to `Self` from `T`.
-///
-/// The standard library's `From` implementations do not cover conversions that are not portable or
-/// future-proof. For instance, even though it is safe today, `From<usize>` is not implemented for
-/// [`u64`] because of the possibility to support larger-than-64bit architectures in the future.
-///
-/// The workaround is to either deal with the error handling of [`TryFrom`] for an operation that
-/// technically cannot fail, or to use the `as` keyword, which can silently strip data if the
-/// destination type is smaller than the source.
-///
-/// Both options are hardly acceptable for the kernel. It is also a much more architecture
-/// dependent environment, supporting only 32 and 64 bit architectures, with some modules
-/// explicitly depending on a specific bus width that could greatly benefit from infallible
-/// conversion operations.
-///
-/// Thus this extension trait that provides, for the architecture the kernel is built for, safe
-/// conversion between types for which such cast is lossless.
-///
-/// In other words, this trait is implemented if, for the current build target and with `t: T`, the
-/// `t as Self` operation is completely lossless.
-///
-/// Prefer this over the `as` keyword to ensure no lossy casts are performed.
-///
-/// If you need to perform a conversion in `const` context, use [`u64_as_usize`], [`u32_as_usize`],
-/// [`usize_as_u64`], etc.
-///
-/// # Examples
-///
-/// ```
-/// use crate::num::FromSafeCast;
-///
-/// assert_eq!(usize::from_safe_cast(0xf00u32), 0xf00u32 as usize);
-/// ```
-pub(crate) trait FromSafeCast<T> {
-    /// Create a `Self` from `value`. This operation is guaranteed to be lossless.
-    fn from_safe_cast(value: T) -> Self;
-}
-
-impl FromSafeCast<usize> for u64 {
-    fn from_safe_cast(value: usize) -> Self {
-        usize_as_u64(value)
-    }
-}
-
-#[cfg(CONFIG_32BIT)]
-impl FromSafeCast<usize> for u32 {
-    fn from_safe_cast(value: usize) -> Self {
-        usize_as_u32(value)
-    }
-}
-
-impl FromSafeCast<u32> for usize {
-    fn from_safe_cast(value: u32) -> Self {
-        u32_as_usize(value)
-    }
-}
-
-#[cfg(CONFIG_64BIT)]
-impl FromSafeCast<u64> for usize {
-    fn from_safe_cast(value: u64) -> Self {
-        u64_as_usize(value)
-    }
-}
-
-/// Counterpart to the [`FromSafeCast`] trait, i.e. this trait is to [`FromSafeCast`] what [`Into`]
-/// is to [`From`].
-///
-/// See the documentation of [`FromSafeCast`] for the motivation.
-///
-/// # Examples
-///
-/// ```
-/// use crate::num::IntoSafeCast;
-///
-/// assert_eq!(0xf00u32.into_safe_cast(), 0xf00u32 as usize);
-/// ```
-pub(crate) trait IntoSafeCast<T> {
-    /// Convert `self` into a `T`. This operation is guaranteed to be lossless.
-    fn into_safe_cast(self) -> T;
-}
-
-/// Reverse operation for types implementing [`FromSafeCast`].
-impl<S, T> IntoSafeCast<T> for S
-where
-    T: FromSafeCast<S>,
-{
-    fn into_safe_cast(self) -> T {
-        T::from_safe_cast(self)
-    }
-}
-
-/// Implements lossless conversion of a constant from a larger type into a smaller one.
-macro_rules! impl_const_into {
-    ($from:ty => { $($into:ty),* }) => {
-        $(
-        paste! {
-            #[doc = ::core::concat!(
-                "Performs a build-time safe conversion of a [`",
-                ::core::stringify!($from),
-                "`] constant value into a [`",
-                ::core::stringify!($into),
-                "`].")]
-            ///
-            /// This checks at compile-time that the conversion is lossless, and triggers a build
-            /// error if it isn't.
-            ///
-            /// # Examples
-            ///
-            /// ```
-            /// use crate::num;
-            ///
-            /// // Succeeds because the value of the source fits into the destination's type.
-            #[doc = ::core::concat!(
-                "assert_eq!(num::",
-                ::core::stringify!($from),
-                "_into_",
-                ::core::stringify!($into),
-                "::<1",
-                ::core::stringify!($from),
-                ">(), 1",
-                ::core::stringify!($into),
-                ");")]
-            /// ```
-            #[allow(unused)]
-            pub(crate) const fn [<$from _into_ $into>]<const N: $from>() -> $into {
-                // Make sure that the target type is smaller than the source one.
-                static_assert!($from::BITS >= $into::BITS);
-                // CAST: we statically enforced above that `$from` is larger than `$into`, so the
-                // `as` conversion will be lossless.
-                build_assert!(N >= $into::MIN as $from && N <= $into::MAX as $from);
-
-                N as $into
-            }
-        }
-        )*
-    };
-}
-
-impl_const_into!(usize => { u8, u16, u32 });
-impl_const_into!(u64 => { u8, u16, u32 });
-impl_const_into!(u32 => { u8, u16 });
-impl_const_into!(u16 => { u8 });
-
 /// Creates an enum type associated to a [`Bounded`](kernel::num::Bounded), with a [`From`]
 /// conversion to the associated `Bounded` and either a [`TryFrom`] or `From` conversion from the
 /// associated `Bounded`.
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c03650ee5226..7a2ee29cbb91 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -5,6 +5,7 @@
 use kernel::{
     device,
     io::Io,
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -23,7 +24,6 @@
         FalconUCodeDescV2,
         FalconUCodeDescV3, //
     },
-    num::FromSafeCast,
 };
 
 /// BIOS Image Type from PCI Data Structure code_type field.

-- 
2.55.0

