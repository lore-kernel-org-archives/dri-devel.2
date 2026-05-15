Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED4DCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16BF10F3E9;
	Fri, 15 May 2026 06:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8c6XSy6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FA210F3F6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/LuDsART6MdkyDV3NSdCEqWbzqjUoHM4V2B3HUHbFZ/oSTvd33nX4PVRYDk2dWwQD8LFgKtwB2qgtTuD3g9toHMmGlam1JO0X/kPAJVNkyc5JgCOfJRDJbSKr9iUKdhDCBtrdpVTWFLftbR80NIRvD64gyFiyp4lKS7E+4vdny2Bl5N2yfgB0vF+4R0Q00QU7XpuvGDaPqa3dKR02BAT8/Ahs80Isd3LTxqwZIRGAlY3t/LMEl1AHlTT7Qa/tYe2b/KVJGrLMrOdQu3uYJBNg1m3gi7wnCuYKr7N8c6LjnLqXZhM4JqEzN4oIGsnJnWFVkTGvtaGH2yFa1aQCCLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c831pKbEEtJh/HY6jpn89gbdL3R+ppcOCy2HPiVExpM=;
 b=WgfQIgWh4fTD/JgzxBCH68lE1XrBTQiU2547hTXmALJjO2QtjXb0naARVpJxrtRCj2p0tQqwe+MFJO/koB8eBHyCnqEzBd2PeYTMTmAE9WrXLZIVipwJW4qpcNgfAqqdegzftLFic1mGLMUduH7h2Qld+T5skq7+h2Xt62XNuaBjAMwFvcjjXdmwnREXTgyJTnTlKm05a4rZOplPY2IlwPXOCuR3Pdr9D8EM/mi3uCVuliZMlfIJLWogR/4Ly2zeNTaUzLFzvXR5dUvdVZFlzzZYS3tT4j+b1zWp5/0JTO9E4K7EaR72X7EYyDFGMqEUP6NXzIvodm2wYhiaHaA01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c831pKbEEtJh/HY6jpn89gbdL3R+ppcOCy2HPiVExpM=;
 b=I8c6XSy6t3Esrgt/FdlgtFRuGSXuBG15w5XinTtXma01Ik5fPMl6Ba0ViAPr4N3OTmM9VjqkMQq03nTMeIFfUC84jIqYRDfpqyVLvvdb0gI/IneTwKKvdbIksKXF6X0Q+Rr441B371LZSwXh8bKoqeOv6LFoclhmbKTOH9IWO78g2uUdtu3w9A7b9jrGx5BSOOrZvPyl92BVLMf+vJgFi6NcbEe/6Wnvfxuc0zjbBrYVtEZiAZ1RYnGU/3TtGV1Iu3GwYs1GjL+5M+YW7iOEqo1lUbpZrxHipo2KNMbUC+FvcaVirWA3ldy5X+0QbmhCDAT6I3XutgWB03wbdKybjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:13:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 06:13:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 15 May 2026 15:12:33 +0900
Subject: [PATCH v5 7/7] gpu: nova-core: run Booter Unloader and FWSEC-SB
 upon unbinding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-nova-unload-v5-7-c4d6250ad160@nvidia.com>
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
X-ClientProxiedBy: OSTPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:604:222::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: a89e90b8-6c75-4265-7bdd-08deb2490ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info: a6azDlkavdhmUJcMsiD+wVQn237USP3dK0L7IzUrkE9uMDPFmk44GAsO/W3yHfPcLJay2px9ZlaaxlsTzkN5XyBrZUZaWe08UnQyVgp3KTJMOQzJHee9HTPv8oteySwtCUrBJboAzkuZ75wavDc3yygGCb14+9tftPliUtduI8DaPp3msm55N7C1rP1bER+xbFbhuxbH0SrOBtrxjHfA919K318mkyGq7ePMVEBZfx9aW0d+KX41lmqWt6+VaoRfJHpd/4NG65UfBK9nDUGagaPi09pV1TTiA0UgEydWFAqU/RJW8OJuZrJ5O9J1HEM9tBaoCJCSVvmbhnnrDiGXfKpteLMjjhpolNkFeZXE62cr7f56R4eJgqCjy333lwzLopW395ZDNp1bX9MUozPAL6UIeERlTVgs3Zb5o8Q6+H/NX7HAbeqJNY5fBk9pL1XhB7TdsGxiKKNCX2bUf88p/04ZSEna/R7KgTANHaeT94+w7SkJioPRN+zL6fY1rTDwubJ/hHPUqmS9YWaEmcHz5TGNmu/qYTBitanD2fF4Jw3wAIw8c+p6VokvLnYZBjwP99cKRa3MMg+pqXU9QH6BHIpNJ/amcmZdL6qUqg+m2VqM/ZmnV2gdum+f6uX02YInf8tJVju8T4bnpWzuUEXxHc4RYqblSw0KQgUOEbaXxBPafDbSKH49gBDnNZHvmXKM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(3023799003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDdiQ2lYUFJkcVR0NmxYUUFidTVUTmk1R24xckR6dnMxVXZSdFRyRlhzaFJl?=
 =?utf-8?B?S2tFZVZqR2NScC84ZkYyWkZQNVdrRUVVU3NJckRrTWtKRnlFMWo4VEh3Qldl?=
 =?utf-8?B?anJGN1NsSWZoQjJRQTJNbzU0MkJ2eHpYb2U4ZWNiemIxdmNyZkxSVHVpTmVO?=
 =?utf-8?B?WlFlSnNmNTEvUXRrV2tQemFoaldhRlI5cHhtVnFkbG5WdnBFMTFZUEVjVVda?=
 =?utf-8?B?Z01xUCtiR0F0TkMvaEs2RDFnNnVRRzhSTkgrbkR0ZElKbUtFMGZvZVhuSGFC?=
 =?utf-8?B?aUNuaFlGK0FCTGdtYUp6L09vbGIwbHVESmZhNWI4Sm44aldMUGhtRUQxMDBN?=
 =?utf-8?B?RVFwQWZmZEtLZTV3Y0gvZVo0czYwK1lNUWtqRHVXNTNaMUZUQzFYM2Q3ZUhI?=
 =?utf-8?B?b0lJajZDQjFEeitqZVdkQTNmcWcvRExIc044TTFoek5WSmFRdXlnUFlqRGYz?=
 =?utf-8?B?TG9CdEtjV1E1dHRvWlFyRi9USEFSTXI4WVZhZDVYVTB6cmtMdkdsRFhFZ0VV?=
 =?utf-8?B?Sm1yQXNGZkNjMlgzRE5yalFWcFJsSGVLNGxmUjhMbkQvODFsMG90K20zeEkz?=
 =?utf-8?B?M1gyY0RFTkhPcmFYU01XZ2dqRG95dlM5elVlLzI4cDN6M0dnM0ZFYitaRkpx?=
 =?utf-8?B?QWduZ2NMd0pCNUhCNHNCOHd1MUZ6ektWWGV1ZVFIOXlUUFFjNnZZYlVSSWV4?=
 =?utf-8?B?dXUzcFdkQW5ZL1dJZjNNR1FXSmN6NC9rQUkyOUF1TWtrSlNRRkJPNTdSbk1L?=
 =?utf-8?B?dWozRjN1Z2xtQ1lxdjlrZ1FDTHByaWN4Z0kxa2ZFMnZXOGVZVXlucG9rRWNW?=
 =?utf-8?B?QmU0T3QwbHprTXZxYTNmRnN5cmVUQkhCNzcxcVNOaElWRk9pNlpFL0hNVHhD?=
 =?utf-8?B?UTVuWldzWW1Fb3UxT0tOM0doV2syTXFJaUZySHVnMnVIRXFtaDJDZGsrWktJ?=
 =?utf-8?B?QnkvZkRLMWdUOFhyV0JxUGhqMGdBM0VKSjlWNUVUcmNlY1JOZkZ1V1dCczRX?=
 =?utf-8?B?NzVTY3dRZGZsbmxCZzR1MGVFeURIdmJqdmxWZXNRYWRwVFB3all3S004NkJX?=
 =?utf-8?B?S1lrWTZnTEM1QU9Makt5d0lkbS8rNDlYT3dndmhmUkptNm5QOWt1L0d3aEZ3?=
 =?utf-8?B?VjJESGpNaElHRFgxdmY2TUZvZFlsdXQrb0xGenYyMTdHQ2NYSVB3Y1VwTGVo?=
 =?utf-8?B?K3ZZODJXa2I5clZQUWFrNmFZcnUvdHZrcTFoOFB3ZEJBcFliSXcyWVVpU2NP?=
 =?utf-8?B?cjdYck1QZVdXZGd6TzlqNFpuSkRWb0Q1REpWRERySktKYzFvWUhwQlY4VEFK?=
 =?utf-8?B?S0s1M0RaeUd0QnFKSklsdjErM3VZK1BGUkNKaWk4VCtFQnRFeXBmWWRWcjhm?=
 =?utf-8?B?TnBhSnFDK0lUTE9ZVlYwRWpocTZnQk00eHhFY0JpWkFqZVdJVnQxMllleS9U?=
 =?utf-8?B?cFRLYmFMOTg5S1RGN2FybVR4S3R4SkJqempqcHJpeUVxenhwMXNkdkdRdHNj?=
 =?utf-8?B?dkwyZ2lJVlVmKzVRSnlHbS96bVdVNVI1djVlK01nU1AwVDRaQ21OdUNBbWhr?=
 =?utf-8?B?R1VrZzVpaWpOaEhiNHhMM2FpeTl5VHhFS0MveUw3cnlmd2RIVDdwdHdkMVVi?=
 =?utf-8?B?VThHeTNvZ1lmNzhNN0FHR3RWUnFOdGgrUUdzSmc1M2lIc1JnT2ExUk5YNjFQ?=
 =?utf-8?B?bUhPZnRlWEVMSU5kWTBVSzVINmpDZXVha2M3MThCVERQYm9aUW14TnZYMkxL?=
 =?utf-8?B?UFMzZDVKU3ByVW0xOGVpTXIvTHUwOUVQa0VVQlpzakRIV0M5TWFvcUpNVWZ4?=
 =?utf-8?B?d1BpRmMvRWRLRmk0NGtuNEZTT0JBMnk4d0NZUUVZSHdlU3NiOUs3VDRsbU5X?=
 =?utf-8?B?a3BoT3pmY2VTclFaT2E3bENXVnpHUHF0NytzL0FTWlMwcHFEekFvSG5IZ21m?=
 =?utf-8?B?VnhuSGMwQkpTK2dGTnAvMXlib0N0cW5tQVorTUVHOEppSzFWcWROdXlQRVE1?=
 =?utf-8?B?UlRiQ0xXNGl1dzJ1cWlISWVob0tGS01pdVVrK1RuSXpRdnNNci9kUHlXbVpK?=
 =?utf-8?B?NHFnNUt1Vlhta3BDOCt0cjI1dlFtUWx5d05sQlNuS0ZURjhiUDh2c09pS1FZ?=
 =?utf-8?B?UFVNRU1wM3d4VUl3M0FrRjJoc0I3b2lyWFIrL1U0RXZiVk92cDBFSFhxT1pG?=
 =?utf-8?B?SE4yODBiUDVaWkhBdENUa2VienppcDNiWkVxM2Y3UnJrTzlPeTlwVnR6Lzcw?=
 =?utf-8?B?c3NQUXhWM3dpcXZuZDRtR01GcVJLcUY1REg1VHoyeDJaYytSQUVMbGxHZHp6?=
 =?utf-8?B?RDR0Y1MrdmZaWlVPVmJnNWZPcmllY1BFS3d3eWhYb1d6MFQ3T3BTaExUb0I5?=
 =?utf-8?Q?g0liAn4eTe9we9SJpJWibEUxh7284E5aGGiZoGw2oHESC?=
X-MS-Exchange-AntiSpam-MessageData-1: uaXB5uJmxzAqmg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89e90b8-6c75-4265-7bdd-08deb2490ccb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:13:15.1855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1DNHMW3k+b5ZmfqmXt13FKz5bQsxpUAIcoc79LxJeCJv30fcBqJ8Hna8KrgrNN8BLQlIMiPZ25gFfwEVnigZw==
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

When probing the driver, the FWSEC-FRTS firmware creates a WPR2 secure
memory region to store the GSP firmware, and the Booter Loader loads and
starts that firmware into the GSP, making it run in RISC-V mode.

These operations need to be reverted upon unloading, particularly the
WPR2 secure region creation, as its presence prevents the driver from
subsequently probing.

Thus, prepare the Booter Unloader and FWSEC-SB firmwares when booting
the GSP, so they can be executed at unbind time to put the GPU into a
state where it can be probed again.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware/booter.rs |   1 -
 drivers/gpu/nova-core/firmware/fwsec.rs  |   1 -
 drivers/gpu/nova-core/gpu.rs             |   2 +-
 drivers/gpu/nova-core/gsp.rs             |   3 +
 drivers/gpu/nova-core/gsp/boot.rs        |  18 +++-
 drivers/gpu/nova-core/gsp/hal.rs         |  21 ++++-
 drivers/gpu/nova-core/gsp/hal/gh100.rs   |   7 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs   | 141 ++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/regs.rs            |   5 ++
 9 files changed, 188 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index 6a41690e72c6..6f421906c272 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -281,7 +281,6 @@ fn new_booter(data: &[u8]) -> Result<Self> {
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
index 75fe1bdb80fe..bcd403781a1a 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -297,7 +297,7 @@ pub(crate) fn new(
     pub(crate) fn unbind(&self, pdev: &'bound pci::Device<device::Core>) {
         let _ = self
             .gsp
-            .unload(pdev.as_ref(), self.bar, &self.gsp_falcon)
+            .unload(pdev.as_ref(), self.bar, &self.gsp_falcon, &self.sec2_falcon)
             .inspect_err(|e| dev_err!(pdev, "failed to unload GSP: {:?}\n", e));
     }
 }
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 38378f104068..58b917172efb 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -126,6 +126,8 @@ pub(crate) struct Gsp {
     pub(crate) cmdq: Cmdq,
     /// RM arguments.
     rmargs: Coherent<GspArgumentsPadded>,
+    /// Ready-to-run GSP unload bundle, if any.
+    unload: Option<KBox<dyn hal::UnloadBundle>>,
 }
 
 impl Gsp {
@@ -181,6 +183,7 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
                         dir.read_binary_file(c"logrm", &logs.logrm.0);
                     })
                 },
+                unload: None,
             }))
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 59c1b4d030ae..61f10c0d2fd2 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -56,8 +56,8 @@ pub(crate) fn boot(
 
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
-        // Perform the chipset-specific boot sequence.
-        hal.boot(
+        // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
+        let unload_bundle = hal.boot(
             self.as_mut(),
             dev,
             bar,
@@ -67,6 +67,7 @@ pub(crate) fn boot(
             gsp_falcon,
             sec2_falcon,
         )?;
+        *self.as_mut().project().unload = unload_bundle;
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
@@ -129,6 +130,7 @@ pub(crate) fn unload(
         dev: &device::Device<device::Bound>,
         bar: &Bar0,
         gsp_falcon: &Falcon<Gsp>,
+        sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
         // Shut down the GSP.
         Self::shutdown_gsp(
@@ -139,6 +141,18 @@ pub(crate) fn unload(
         )
         .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}\n", e))?;
 
+        // With the GSP shut down, reset the GSP so it can be restarted.
+        if let Some(unload_bundle) = self.unload.as_ref() {
+            unload_bundle.run(dev, bar, gsp_falcon, sec2_falcon)?;
+        } else {
+            dev_warn!(
+                dev,
+                "Unload bundle is missing, GSP won't be properly reset.\n"
+            );
+        }
+
+        dev_info!(dev, "GSP successfully unloaded\n");
+
         Ok(())
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 4d8c1998f4cf..d9c324226dda 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -29,9 +29,28 @@
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
@@ -43,7 +62,7 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result;
+    ) -> Result<Option<KBox<dyn UnloadBundle>>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 9d7e9f4454b1..51e1099cda0d 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -17,7 +17,10 @@
     fb::FbLayout,
     gpu::Chipset,
     gsp::{
-        hal::GspHal,
+        hal::{
+            GspHal,
+            UnloadBundle, //
+        },
         Gsp,
         GspFwWprMeta, //
     },
@@ -40,7 +43,7 @@ fn boot(
         _wpr_meta: &Coherent<GspFwWprMeta>,
         _gsp_falcon: &Falcon<GspEngine>,
         _sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<KBox<dyn UnloadBundle>>> {
         Err(ENOTSUPP)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index d5da23cd8c90..c6c947696ba8 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -31,7 +31,10 @@
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
@@ -43,6 +46,124 @@
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
+pub(super) struct Sec2UnloadBundle {
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
@@ -161,7 +282,7 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<Option<KBox<dyn UnloadBundle>>> {
         let bios = Vbios::new(dev, bar)?;
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
@@ -185,7 +306,21 @@ fn boot(
 
         run_booter(dev, bar, chipset, sec2_falcon, wpr_meta)?;
 
-        Ok(())
+        // Last, try and prepare the unload bundle. If this fails, the GPU will need to be reset
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
+                .ok();
+
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

