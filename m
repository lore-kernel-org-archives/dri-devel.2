Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5FACD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F200B10F3F2;
	Fri, 15 May 2026 06:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FFroz8T7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012047.outbound.protection.outlook.com
 [40.107.200.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F3E10F3F2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:13:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZwF+vgQ/q+hJKXhGlCUUDgT7ehYwfL+2qKdiONLCnpARhV/IZQQY2/jS+3UcBj92vSSrStolEX3gJHtlwuuVmC9W9Dz8uw6ZwD8y4gEXNzZ+ZwaBjFCY9oMhJPs1ScrFSBJ5xoEnZK96Tu4amTRf394e0AncNYsUruGAW9x41oSnDVZ9ZaTpViYy07yvFrewIVWCi1lGcwpnXiDTY7oGZAa/skIu3L1E3jIJ2JoCTCRPt6ikEB2dWqpm5xV1/VCD/3K0O2mPuSejOFkg3dsMt7GmI+IMIbJ4F1XRORCNcTQ8ZwMvx9dW/u8c5oJFZYUiwkNVu0xnh69MzTLnAbigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHxEIopFOqSgtbANjCod7iL9p5M0ZF01HQsDlsHzOCI=;
 b=YeS9nHXl37UrheeVWMLtQUdeV/pQd7A9o/8xrHhx9iN0ZaPExdKcNZwZ1/QddHaZMXGeVv6ETRkO/5VTMaoL4NQleXsA8H3Hb2FXvUg4CCwDsMbUa65sJA8dbhWT9U+YrAQylsxYzsozTI19Abx5pyE50jb7rHui6OP++W7Jv1Bo7LcCsJFA8lPsJoVp6+f6f/WFNHAlFRw0Z/5R27SpJIZFIBfnKTieTP/cUvAKwJyEPFrf/GoVJ1usGyOSxYv2DCG4Pass1zyfOjJX6NzckNJgsF55nBSab0o3UQy5IUl8KrRXUFEaZtvoPXc0iO9fQwbw0he3VLoapcOwxMVIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHxEIopFOqSgtbANjCod7iL9p5M0ZF01HQsDlsHzOCI=;
 b=FFroz8T7y4O1n5C3f4NVqANlkGNoIghdqVO8bWXKz0a+se+4DQ08IA+w7K/WLZxMo0hJKlwQcGGdwZ95gnra7tIud2GNXMrDGuB7gMn97/MvQ0ZNg8//p5p3vvqzrlyftMsRFCS8QHHXqxm1veJ1hc6AR0jsHCQcrc+nC/ZxxNhjgqAghFt936OaKR0fUIKgpWIH0Wd1WgU87Dkp8RNDiGChdMUMX+QTlPz/G5LwnLaWxn2VABosltCOQylqI7n9t6o2alrAWK9BfuWzFEa3yFSXBJW7XDu4DJC7P+4e8fPw5HO4W85rRRiHL3J67bKFE8lVNSSA4gKWxUo8oMPA3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:13:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 06:13:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 15 May 2026 15:12:31 +0900
Subject: [PATCH v5 5/7] gpu: nova-core: gsp: shuffle boot code a bit to
 keep chipset-specific parts close
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-nova-unload-v5-5-c4d6250ad160@nvidia.com>
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
X-ClientProxiedBy: OSTPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:604:222::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0b0d1d-b51e-4aa5-996a-08deb24907f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: F4ZawI8bZ8YLB9+Nzujw8/Sa4DtM78N3C2MATG+I+GsPY2Nn13hqk9XxlommKG5nX6um8ZJ4fuQ2nv4Q5IYFV6VyLWDGzV7MvDW1ZTmeUyv9q5MkRcRABacdOMxg5YR2VfYAkzLlLIYlGCweiKRlpD9wBrUFT/7PG+xjsJ/cls5XFmXbJZoDJkRJ3yEFxcEcVT7QcLhXPIaD+lX7gEF3hiR0gvycb/RoysbDWr/vkyq7z+/urgnEubsGq5JhUYUvBcMNDwQviY3h4LuUFmzvHgq5SXTnqHLdbEiqYe2fFEhAjAowqBr0WBLfZvNPGn7xZNuzB9aD8hkLusVOl2AT/njZ99qzBp9jUUg9mb4RWZeHwZF+2KYzlGPzAcHsdffHJ9YDP9VxoL/9aYMuw1CA8I18ugqiFGWnin9FHaCOCFYntUacpeMaIicJAe3xEAae77kE3SdwBnalsk+cP98PDrt9ivCX7xaTz097RLMr++P2HIYiJh/tCn3mboMnhQf88W4+5natHvMnsV7FFS4SusPZ1mXfJZDemO1BOJJef1RQI6JbthBSoqf2bv3MlUoLRiEjHm7RF2xygguVchbnEILPG+DtJAHI80TCtTpO10xevaVW0S+cNUkqJ7AC3MNyy17R5fo3msqHT9r7USBdqORgEmyaS4vWlVSdyM0qIEJhWcjC/scONnyp3N5CqomR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXRJNHNwaG1pUWhRbXExc09xK3Zmc3lOMncvTDBBcm1yNld1RnBFbTl6WWdn?=
 =?utf-8?B?eDN3RU9FQVd2SVhjRWlQLzAyZkNIbUxQT21YVUZaQk5RU1BWZUVKdTZFQ3Z1?=
 =?utf-8?B?aSsraHl3bFZRSjRIc3JpcUU3TTVTa2gxejRLUjdhYTB0S3dJMW5qc2VSK3hm?=
 =?utf-8?B?REU5bzIxWU9Kaitoc24weXRaVUJKZGZzbWFrMG5IZmhuamdYMlIzZWtyMTZB?=
 =?utf-8?B?TVlJakNpN0VBRWJFaFNTS21HODFhM1Z3ckpIZlZpZ0d2R2d1UVJnamRGT1ZL?=
 =?utf-8?B?N1drVXlmbk11VnZoaElUVTBBcGRvT0pLMFdnSzl3bWNMSDIxdERCUXZYSjI3?=
 =?utf-8?B?d0IyM052QWxMSlRhN0orKzZ1ZURIU0FockEyNUUvRXo2akRUa2xUb1JnUFdR?=
 =?utf-8?B?WlFIZGFKYW5ENnJaeFlxN3R1L2cxeFJtTUJIL3BtTndTSW0zbGxaZ2E2Mkd6?=
 =?utf-8?B?RHdDMmNGWnJvdmI2Tnc3N0pnNFVXSGo2M1RxcmtvRXRKZHhGT3RQNEpNQ0xs?=
 =?utf-8?B?Y2x4TTdIUnZlaFhrVktIL0N1MG5ueEJRNXJyQTZyZGd5cXhYemI0SzlCMVlx?=
 =?utf-8?B?bHNhbThrR2luZW1OYW92SmR0S1RYY3prUDBjWk41TEJkUjB5Mnk2NGVGSzNX?=
 =?utf-8?B?RGd1L2xvUFB4NlNJTCtaaWFpTmJFSkRubGRCS1NnajZTeWtXVWdDQUZ2d2dK?=
 =?utf-8?B?WG9BUjBIM2V1c3VJWTB0a2h3ck1qVGdQU3ZPOFVraW85WVlTWndQZ3F1c1dC?=
 =?utf-8?B?cllYK2tiY29IcDJZUXBIeEY4NVVPVkxjWjk5MjM1RFNLQS9HZE5yQUFjekI4?=
 =?utf-8?B?Z1BtMTNQWHZCallWdUVwTDhJcUtZS1ZHY2VqdkU1WjdUVCtDeTJQbUx6S3hk?=
 =?utf-8?B?YU45N3RGaFZVQVA5cUpDWHI5UEdxcTFaQnhiS0laMVRGbkF6K2hxTzlxUmFO?=
 =?utf-8?B?MjFqa3NocVh6VytoSkFRNjZpQzFwTS9yTGxjVURwR2NwbHVvVWNBOVpPRXV1?=
 =?utf-8?B?SzMzRGtlUEU2TkdqSi9iUTN0V0lUWmVXeS81T0l6OC9iVm5oaUovbjREMDli?=
 =?utf-8?B?VzRUNXRtb0JTTkQ4UlcwN09BbWJJYnMwcWJLemUwNjRJbDVJMGd4NzJjdEhB?=
 =?utf-8?B?YzRpWFU0ZllSRFQrM2IwY3pPTXhhZkZhaGU3OThtYXNWU3RvYlJOSjZuMVAz?=
 =?utf-8?B?Y2s0ZHdYejNDSzdNSS9xZFA0UWJnQ3pEbzJjdG96OTVVbmtRMzYzY1pOWW5N?=
 =?utf-8?B?R2pVVGwxVG1ERVVEaXhFOG01Mzhrc2ZNZTA0ajYrRUcrbitvTmZkcUtFc0tH?=
 =?utf-8?B?Q2tNTTNnSkZIa3c4anZINVNkc2YvcWw2dkpTVk9ienN6Y3E3em5LUGZEUytC?=
 =?utf-8?B?Ym5mRHBBTG9QeFZlZzlNcWgvbjVFelVZVTJUMGNiZUM2YzRjWG03endJYzlK?=
 =?utf-8?B?YzFKdXE2bGhId3l1d2dCZU5OYjk4U1RsSnIvMG1iTTRLWWl6czhENUd0UEZz?=
 =?utf-8?B?U2xoV2s4eDkvcnFUR3lkWlhKTW9ZREZXdWlKNTB5ZnV5REJHZ0krK010enVU?=
 =?utf-8?B?VTZrUWMydDNTTSt2cFZNdmpPZzJXZ20vZDhZcVp0Z2Jza3dwbU5hQ0pVeStH?=
 =?utf-8?B?UVlXNk1ESmt0MlhlVUpHSzBhYUhMYmUvRzN0ODdhMkdYMkFKeUE0dlB6UTZQ?=
 =?utf-8?B?Zi9lbVBUTmdBdlo1MDkzK3dhRmRieVlqeGFpK05NTWsxMklqc1QzNktlUlFZ?=
 =?utf-8?B?MVYwK2IzaWhYczhOMWJVdVFLb2pWU3dNVFhIclF6UUFMeUNJZFdnUC8raURL?=
 =?utf-8?B?cG9NTGM3R2FBcU0yb3ZIWjUzRFNoZnk5WGZwNkNJQS8ydmt3b1B0RVMvZWpw?=
 =?utf-8?B?YXRtZm05YmJBSURGNnNjY3N2Z25GUU8rOUJNdVdDbnc5clowL2h4bWpBZ0ZD?=
 =?utf-8?B?STFLRlhHMkZyN3FjQ2RJeGM0NVBrcWNoNnZ0OUJ6Vno1cEFCeks0eXBaTnJP?=
 =?utf-8?B?UnFRcWdjNWVyVGhHR1FaZXdncDZnazVETkp4ZU9SckxWNTNieGhFeG1KSUxv?=
 =?utf-8?B?NEJzYUFXRnhzTm9SZExIeTRHL2ZJVWJSZ2JJY0xzaEpIK0ZtOW9HR0hZekM3?=
 =?utf-8?B?TGRreG1FZWY3cXJZT3UxZHQxb2lwTmFkc09ETlluQWMrcExOS2Vnam4rVDgw?=
 =?utf-8?B?MzJMQTlrRkxPQVdicmhzcW1WL0IrdmNGRnpDcXpjRDFFdE5FcWRYY3AzRERu?=
 =?utf-8?B?MnhlQWNadWtIbDJReElGWnRyQkF1Q28rd25SdXY2aFZPeUdvRWdvUlNQYW5z?=
 =?utf-8?B?ZjFURHNFeEkxeVc5ajMwblZJNG41b3ZpQ3lRZUlUUWZyUE9DNmRqME5tZEMz?=
 =?utf-8?Q?J3fZxt1jBQ0K3U2evycO/robqe01wZilUP78d/nl7d7vu?=
X-MS-Exchange-AntiSpam-MessageData-1: sXmbXI7KFmKkpQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0b0d1d-b51e-4aa5-996a-08deb24907f5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:13:07.0381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iP9S/Cl/qkRmz9q7Oovm8IMk+uEk0c2bZKT75wZp6YDwyFrdClbiItGDixKX3wXQGD4F91eQL0zwLBk8W3y8cA==
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

Some parts of the GSP boot process are chip-specific actions, whereas
others (like sending the initial post-boot messages) deal directly with
the working GSP.

Reorganize the boot code a bit so the chipset-specific parts are clumped
together, which will make their extraction into a HAL easier.

This has no effect on the GSP boot process.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e75c4b235aab..2e1401cd6171 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -187,18 +187,13 @@ pub(crate) fn boot(
         let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
         dev_dbg!(dev, "{:#x?}\n", fb_layout);
 
+        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
+
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
             Self::run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_layout)?;
         }
 
-        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
-
-        self.cmdq
-            .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev))?;
-        self.cmdq
-            .send_command_no_wait(bar, commands::SetRegistry::new())?;
-
         gsp_falcon.reset(bar)?;
         let libos_handle = self.libos.dma_handle();
         let (mbox0, mbox1) = gsp_falcon.boot(
@@ -227,6 +222,11 @@ pub(crate) fn boot(
 
         dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(bar),);
 
+        self.cmdq
+            .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev))?;
+        self.cmdq
+            .send_command_no_wait(bar, commands::SetRegistry::new())?;
+
         // Create and run the GSP sequencer.
         let seq_params = GspSequencerParams {
             bootloader_app_version: gsp_fw.bootloader.app_version,

-- 
2.54.0

