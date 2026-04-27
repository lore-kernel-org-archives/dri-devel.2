Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19B5FF8865
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4457E10E596;
	Mon, 27 Apr 2026 06:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+7of9v5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4593210E596
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4PEKipKuV/FUyAGBg9aNC8dxkXIE0e5INfyYqNRQw1beEFdSNusdluL4F82watw5UDrFM5S2P4POSXNc3Kr4RO3pmu4WRjptLL+nbzOcoAtFAyVapFk3aqeYQAbNKSMdOtzTVRus3LMdfQFLWzc+Ib1pM6Mxaq+53fDKg+0+t2ap7yq8hZyOjKtOAom9EbvkGcMDzsck2FP6gR/P8KhhxkBhwtYYwSS37MwhiaRjrcWRTfuwLsomCL6Ne2wjXpqHZOXsw3sngcBSdn6CPhYzWH+xGgHMZL6mozkOIS9AtotjnSeBzn04ApnTvIbpHDI8eXC4WyR84j4R8fkHfZJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXZsLnphd4lK9+YNEmHjOnZwGdPWXXBcV2V1AFXgt3k=;
 b=YfvHasC9wmmHUZnfLPdxgE2fUZEd75Nv4BcjbRGBo0/9ozmub3oLnrTLmQh056DHcCaWItSIJHgabCA7Wa52ga7UOb2vtYTv+8gowqagaa6CJ2O5qw5I6eV/eHJKuW/eYfUvIkRTSEd13F1P498E6lGXMhAbJLmB7oAvRCdur6vsgTei65O2CRISkV1+3tCJYAFlSUGbER7sAwEXl4kjtixduTjAgSUwJ5bJT6CZBu20e4dsLwm9VIQPX5Xo8gKI2aKcShqClkP8baWkLWpMA9QD3h8YT6KWl/MqbXH8jN/dcNzT99bdE5jqx982LYbs/KwOvK/eha8/cJuI9Hrjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXZsLnphd4lK9+YNEmHjOnZwGdPWXXBcV2V1AFXgt3k=;
 b=o+7of9v5C3gdDE1MJ5iQMOIJM7vVAKNLkrzRAZeprNy2rP9O720B7B4DNHdhbaIVno47mUq5auXiG3HF8Q8yXIna/lMm0nee9KUKegUbUPoAoP2mF8jb0HLi0q3Mc0c4KiOKScw4h5fknp0Cc7/FwDe6gXN9bjowzU+ozaql6u2u05v9JeYFHJZni8RYel777Z7G1sw78DJ77sD4saCWRISWy2oUlQWt6cRt35qYuAlEjAXPKquAbxQDt6rs3XxjmK5aLLwQlxksV3wjdpuH7+rXQML9NMVz94S5wsxJ8Novwbbc2xmTX6qNj6rLe8cHCIx1mpwJu3glco5KS/Gh8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 27 Apr 2026 15:57:03 +0900
Subject: [PATCH v4 6/8] gpu: nova-core: gsp: shuffle boot code a bit to
 keep chipset-specific parts close
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nova-unload-v4-6-e145ccddae66@nvidia.com>
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a2d6ec-4fa9-4ae1-8cf1-08dea42a41d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hAaCKpumGh3yFBcqX1hHnPu6cFTT3Ne0ukXy1e+/r2vyd+pHu+XIsN1yho3Ufae1T9/1cKkdaiJ0SdS0U/5eNXOHYa+AyEXSbzDiuoLm7R5495q/cHjyeA41nACMsB0sLKZU2+ak0MPPi1CJggKi9kbatRt0H+YFV1b67VkmFD6ylno3Zb2I8ZgzFWhmP7UKMSdea9UNQojd+LAvhktD18KIqA7rFk013GHh/+hAGRqSfCiUwVxQwJ1c9TUvOayjJJ8XXxHrSb6OLuFBN666cvruMbPacAvENlIi+bJtV737/JAu20Rn/MWUyc6cDtBKNJrSrfb9cj69uLXq5hlNFsfVZlY40iwAZem9NzU2tKGqo3EOqSFkOTxDIE7YnGmVbreguHUXo1AROdSvROlp7gxHTAcpPEQ5SCU9TUcc6JCCGfNHiK0cpGxidzH+0PkZTkuxrqEjXHCZIrVuBp3WQADjZZ5j1j4IOoZfGu7tmzq3gaF5yn8S/O5MJLkWfaWWX+o61/mUA1g+d4qqFWYBd8ylDgmnIOcjuylb6f6ktE1uX19DeXKGm6jDOIJ89V/ql+OfwY0cLFts2K88UT8zuKBvYgpgAWugFsP6ndIRvkNY7bwDROZtYV+Ox8+cfmClGfufAq9Bmlg8y+LzWVo3Mh2C5t3dG/yZnIRnKHn5DqxMJYt1cWHcVwehUbKXujI+Klot5kwyX6E0Gg+ZuuFyQhQQI1UtuOyOpNvmlwSofB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk5YRjVmVk5YeGcvYUNveUF3czlOaU9pVVUyQTdSeU1TMkJMV3RIR3NTVkpF?=
 =?utf-8?B?ZEZGZ2xpTXNqb1o2L3lUQ24yUTJ0ZkdWMTNYeHYvSHpJYytITXJVM3gvaGli?=
 =?utf-8?B?WU9uUnhvVzMrdEZPSWdJblNYamd6R01ZVHNPVHlKK0wyM1hMQzhhbnZQQ09R?=
 =?utf-8?B?TXdpM1lJcUlNaGxSTkhRM1lseEUwN2Z5amNDVmwyTkU2OWdzWjVGdUppOWxC?=
 =?utf-8?B?MlhxTkFua1grdEd4dzBsZjZZTlE4OUF5STF1emNJRk1hbDF1UFFDSitsZGJs?=
 =?utf-8?B?SjdIOVUrN2RmUnRFa2Z6Y2hsRHdCbzF6dVVRL0NTcS9odWZrZE9GMElKYmJx?=
 =?utf-8?B?dVpydVlxUUFVKzdKTEVBeFFPTWhvYWJqbjBWSVQ0WmkvNHlWVk02REZwZjND?=
 =?utf-8?B?Z0FWajJMaG5QakI2SGRxTitUT3J6U3Y2RTlDZXFkd0NXM29UZWNFOEVKUmZB?=
 =?utf-8?B?L05USE5KMGR4dEk5b250K0RxY1RJenFZLy91K3BaYldac1ErRU1NV1dJNEwx?=
 =?utf-8?B?ZUpiMWVZNFdmV2xnR3JaRjZQWkpOT3Q3NmZ2ajNTb0NCSFcxczNYaHFMZWtu?=
 =?utf-8?B?T0R6MW0xNVZyN0tWRkhnakZrRklUblFCWmhCSVFKMGpDNGszK2g4MFc1T1B4?=
 =?utf-8?B?QnNleXYyT0ZnWGtPem52N2hHYjlhb2FqUi9PcDA4Mk8zajVhSVJEd081OWxO?=
 =?utf-8?B?WExpbFZONVQ4NFpXTnc5eUJGS2s0SW5KaCtSUTZLMGtQN3B0UkNJUGFOQWQv?=
 =?utf-8?B?ZnBlUnprbXRndDJtSFlCTzdLaXBESng0VjZzY05LTmg1ajZXeVJybXJBNkRi?=
 =?utf-8?B?a3VXQWZYc0xpMmtSSlMrWSs4TkZQT28zUVlDcXl1a1BOVjdpZEw1OFhvSmNy?=
 =?utf-8?B?R0tkWS9HU1ZLUk82RjR5QllNc3VlZmM2QXBxOUpHcG1JUmNpZ1lwRjVsWHVq?=
 =?utf-8?B?eGZxNVZUQkV3VHh4SzFRaGkxd1gzdEVEek1VMWVxTGtTbnNLazFJUTJLMENE?=
 =?utf-8?B?dlAzTU1BRGp6V3VPRUtIcUEzRDlrclA0Rmt4c054Rmt0eTFqMnRiZzNrUWNC?=
 =?utf-8?B?R1Q1dVhBTERhbm0vQ1E3YU5QaVpTQXk2ems0ZXZMNzNMcnhkVXM3R3FTMTlX?=
 =?utf-8?B?MEV3b0I4SnRYV3lzRkdLU20wV0Q5dEFDaERmUnkwWUhHRktNcHpvR1A3Mjkx?=
 =?utf-8?B?Z2xPeC9qTm96TzRHeU03N3lkOW1GRzFUS1lhM3ZwTy9MaGZVUFFHWUV0c2Ir?=
 =?utf-8?B?aVRvait1R0o0VWlGTUV1VmVRdno5R0k5R0t4Nmt2Z1JYV3k1UnpXZXNzRVNM?=
 =?utf-8?B?TlNiTHY0cHlSRzNzeGRjY2UrTVpTTUpzZk0reEYwMWFyeUZWc1dIVFoxT0Ni?=
 =?utf-8?B?SXV2cncvZ2hoNmpyNTVIRGhMMWpBQVpnUzB2cldTaTJwNS9LTStmUzlrK2lZ?=
 =?utf-8?B?cm1meTk0Q09FV3JhNzRPRHR6c3V4b3hSQXFjaElNb2dvcmZHL0tPa01Mc0ow?=
 =?utf-8?B?dnZxWDl5RndFU3R4UmN0RXdZYVloSDZzK0FNRXMySmtKY0lPczJQb1FLQ3lH?=
 =?utf-8?B?UDEzYVk4eUNxZDdHQnB6QVVhbUZYYS9hUko2eDBjcFV2Zk9IQmpsd29FQ05K?=
 =?utf-8?B?eGJ5NFlxY3g3S0M4bWsyQ1hZM3FOQnJSczFXSjRkS3VIRUxvSXR6R0Radlhx?=
 =?utf-8?B?VWd6cjhkVFNHTFFsUEtkMGx6a2JRbHplR2JiZVM5d1N4ODJOMGV3K0gzNzJx?=
 =?utf-8?B?TXpXejd3cGFIbUd3SW11ZmR6d21zNHNoMlIxNHZVZjgvUCs3eEdPVlVTMVJG?=
 =?utf-8?B?OWVjU2dCMUVwTTFsdTgwR094MXRPVk55cXNJRGwwWHh3ZG1pUFNoNmV1RGVE?=
 =?utf-8?B?amtBNGNOWjk4c1NNR2dzRnFGNko3SjNhZFFiWUpTNUNQNlpiQ3hPWk16d29l?=
 =?utf-8?B?QlR0MytvRU9pVk9XZEU4ZWxjdzFqZkpvdlV1dUpVWDVLSVp0L3ZKR2t4Vytp?=
 =?utf-8?B?UWZwOXVDVENUcVdrL2VkQmkwTHFkR0QyMjA4SWQ4MUZuT2ExQU1IeWp6N2ZS?=
 =?utf-8?B?bXYrMGhidE5zMEkvVzUycW1zK1NDUXU0elk3RlNnK08waXJUb1lsOFlBTWda?=
 =?utf-8?B?WU1vQTV1RFZkQUwwbGh4aVJHMUMwYkxHWkgyRDBBNTI3Sk82UHAvUFFpbHJ4?=
 =?utf-8?B?aHk3VjRJTlNhZEtyN0pzNXRiS0ZQS0VMRUtsZWRXQmpjRkR2bkgyaDhzN2ps?=
 =?utf-8?B?UmwzUFNGN3FKc0JSa2ErSkVkYWVuSWxFQXM4NW16SnNNK1BuQVF5MEVCalk0?=
 =?utf-8?B?S1FUWjVtWUFpaXhzK0FHenRFS3BOQjk3ZXJsQzVWYnhPYnRqc2ZYMGdmSkky?=
 =?utf-8?Q?YKwjAiamh8Ric3G4BFACx3vt2B3AfqPTGM5SVIurMQ8FD?=
X-MS-Exchange-AntiSpam-MessageData-1: E+R+qrlTNFDhxg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a2d6ec-4fa9-4ae1-8cf1-08dea42a41d0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:33.4452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q84eRuP+dXgDyIVAUnZnpbNngchIJvI161uMoOnbCIYjdQjfvgpGy7tRniWSBHyzHMV3O17PLCiLpf8y+4ujA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

