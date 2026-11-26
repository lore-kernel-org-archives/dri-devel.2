Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4D606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q63tGOFV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875FA112153;
	Thu, 26 Nov 2026 08:21:32 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFF611214C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S75xGuWbWliXnz6vUVMUV/ogFy19CWNHgbg6xG/DSVKzCnMNkuAR1tcFCmf2/MoCByYd+tPhlb2nKBWH8rnmJKnMoHxX3rfL4LbqwAurSX6oJ9/AlFwaumnMfmAgc8sReYBmR9NMtfhVDKgAr83gJUR2BewMuplq5TNGtXVzqCIip46ulJp8vnoaMJVT1W2M+tQHyd4H7E/U3GQvZzlxfn81ttdAsyDMTG4krsTPjydImrCgPOXjwCuWhYgIdrdQv1h9x1JCphjq/iSCFEC24oB2855S75xLe2QrFMLT6RPbXY1uWI2tZL+yIraOQ0V09F31hSBKkkmuYOtf6U/mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s+uwgFGV2ieXYwfBbVpNNIqWG8p5AFZ8r0e9hR4i2M=;
 b=QfFXlRO7WkHD3NBtQfXPKBKnEQygfaRcspUIe08+Nlja1fxNkboPZ+eU5x5q1mVkLfrnyYHVf3qr2+gU4hu7Gtpy48scYvbxqa3Bu7r8oHk75RZGjNMSNoj8OPqxAMVMDY1erWCcAMNHyMzpKmCoLoSexCqQHGXI/qewF2zrwzF6DbI4g0/vcTwtExLl3mMRHukeEbHe/UO8LBJavK6J8GnYXKatiJ10DQTSERLfbiv3HLKRAODv3E0XlMu0NdEYve0Ro6uHh862AKVDR+hq9gpkWyA/k6f/SeXP4njJjnSKMYl+8Sz58vSwvxZ2k0icI2m1a/9hBrGuCfL4RizwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s+uwgFGV2ieXYwfBbVpNNIqWG8p5AFZ8r0e9hR4i2M=;
 b=q63tGOFVcwJp1Ww1e6L+OiF2/VQj1q6Bfffw1uXeAyQnHUAIG6wJHJumy8qyKjzjIBlTnqgh9VtDueEg1Z+HAV88pq0Y18fZ4t2CBpZjyeG8JTUVxR1E22rzh8fzbBUC/W6ocxjqcGMg4E+dsJFe/vP4/b5xHJF3AlcAKvtraKbtRoYc5BcDsQA9fx925P9Ei1vwV8g19Cfs7iaQZm9pNQtF4KftZFdeWsDAg/osb0XjgUs+lpSSIaRgHdboOilgQ4+rfURDmfuyTu/8uKiqrd5kW5n1dGdJdcytVbyPdz9SqXZS+ko1l46b9oRD79XlFozjWLiRhcxwHyLPe0h3vA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV0PR12MB248855.namprd12.prod.outlook.com (2603:10b6:408:603::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:21:03 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 08:21:03 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 26 Nov 2026 17:20:16 +0900
Subject: [PATCH 7/7] gpu: nova-core: falcon: load the firmware image in
 Falcon::boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-boot-rework2-v1-7-99a1dc6c7cc4@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV0PR12MB248855:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1929eb-dff5-41c9-9b03-08df4b963633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|10067099003|261102123227099003|261022115727099003|261022105027099003|261026140227099003|261022075727099003|261021121427099003|261028144727099003|3023799007;
X-Microsoft-Antispam-Message-Info: 4bUPDlk2WSpmMqPxg+ZfRvVJg+Igea/xI2M4JRLyNy+P7Oeye+kgo47ahG/T/zCKhAk8Rumccuer50Whx3nclB2kmyHcw/M+tWcp3LxHrH0G0gAsLZxaLheLE4E+hwFRB/tE0P/6M/4gJybbvA7ywEr8LHuXgO377uX3Hr6NzdRDG8HxB5G2zsiw8pw1uVa1JTBVaK/A8fXIfEmYm1OyWo4id2aLsQrLESMmrUlGPk05coH6IEDaMxmhkoNmGWGqTCuvuH9XZur6l1PDycPL59MQjUk0AHpTtROl2YLSf4new+P7nAnBHfFfoTQipTw2JxK/w1pEE9IEzWqog9PwILHTxy3byT4a6At08/U6c6zmjataGMDxSpmtXqPuZpNPEJ4iLfUsnIB3nO2Li+JF51LYETgz2t4SwgNAFLyXUCKLcSIWDZTsMfEZVcoQavMK80zbZ0n8hr+ILY5kuqOBdtLoMKaWLHg6+t18OeQS0Dz7TFaBMWc/lEDS9twpjPk+7HF8Nw7l+/b/N8XJ8udeMF8/kzyoo8Jqn1UHPe58BfDha6cFfu+/Hy3ZaNF3s5Gz18EBf5L1NoWYH5e2N0lY7LBlkTCe0h4qcsU7Z26NI5UoSo8QtSwAW4uGPbuzAGdzFIBuK1KHWPinZyX1AzDxN4AaZdmL3dUTDWNMl2kI6qU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(10067099003)(261102123227099003)(261022115727099003)(261022105027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlBNkR1bS9vYXZTcWR1bG55bFg5bFZ2ckx3am81azBlOWFrZC9yQ2YwMHEy?=
 =?utf-8?B?NGgzbmsyL0dkbitVYzVVWHBFZldMRkk5YXJBVFQrVVNmTWJyWVV0dmJhd2Uz?=
 =?utf-8?B?TmkzYzJxUVAyYnlDcUVyY0VVVkd4Y0pmcTVuV3laU1JrWXJGWmV5K2pZc2cx?=
 =?utf-8?B?enNrYkwrdVA2MUVSK2tNK0FpM3JiN09SdHlpY0VpNHBnUTFOSFIrWXJ2VnFW?=
 =?utf-8?B?S3hxZmNMeWN6NzV1bU5EcE5MNG91Qmp4RXNwcDJHNmxKYzdmbW9JeDVKMWNH?=
 =?utf-8?B?eFNJSEt5bEJ5UllKV2RQQ0hqdG1xdUhaa0FXKzEzOEI4UWh2bk8zY1NNQ3pE?=
 =?utf-8?B?UmZWUzlGejdkVlVSQys3SWRUTFdrclRIN3YwaEpTbW9MZE4rQTF4NytGS2FZ?=
 =?utf-8?B?WmtpMkZBMGVTciszWmo2KzdzZTFBY1NiYlUyVWRDa0tKZFh0S1JuMmlkVjNX?=
 =?utf-8?B?cXR4TVNJcTUwNFlNQk5CR01pc3VvWmNHUmM1MThPdU1CZURmVTZaQ0xaM1Nw?=
 =?utf-8?B?Y1cxVm1Nclk0bnNNbE5pL1hpSm54Wk9TazRsbWlYK0RrcXNHaEg0TDMrdG5m?=
 =?utf-8?B?Z01DM3Z3OHRrUmgyL2V2bXFQVkFUVXBTZm0rWEJFTWw5Nm1QSnpzT1hMZjMv?=
 =?utf-8?B?VEZzK1gzL1E0bW5zQkZhY3B3WG00RGR1M0MzY0xNQXdERU45Z2sxdG9CWlhu?=
 =?utf-8?B?QkR5cUxCN0JiSGRTT0NIWDlWSkgxeHYwaFFwUytjSkJxR3VURktBYzJ6enUr?=
 =?utf-8?B?RDN4NkxaSUUvbGh1NG5STHlVL0gwczVQaUREK01hUEJVWnNMZU5jUTVSN2g2?=
 =?utf-8?B?bU0vOVUwTHh5Tk9tcGQvVHVKRGROcUdBRk5EeitiVkNQeTV0Q2Y0MnEwRlVw?=
 =?utf-8?B?QjZuWWs0ZjRvUFVxMzFlYnNOUFNHQU1ZbHo1ZU01NkVFL0pieHVFNkJrQTdL?=
 =?utf-8?B?VW1KdVRNODVWNnhNMVI0cjJ2blMxR0czOGxUL1gxYUJ3YStuZmsyY3dBdm9D?=
 =?utf-8?B?MDY3Zks2VTNlZ1BrZXJOd1U0aU5UVmUvaVRhK3hUemZaeXpvVHdxRHUrUTNl?=
 =?utf-8?B?ZU9sVDlDSmMyeTc4aVN5R1l2N1B2d2hvUCtlMm94T3NCZE8zZ2VicW5hT0dW?=
 =?utf-8?B?Z0dSZGZzbmZpa3FKbUtyUkp2Szl1Nkxhblh0c1Q2aWw4czhlaWEvazhISHhy?=
 =?utf-8?B?dHFOOHI2S3VZdEpvcEhaS0E5Z2xGWHlacXZLK0FuSEpwWTczSkRLR3JId2sv?=
 =?utf-8?B?Ni9STi82RG5JSWx4RTZLSkZkTG01eUo4eTRnMkJ6SllvV0liSkQvKzlySUZR?=
 =?utf-8?B?TVNlUGJGVDlMSXBUY1FzaWxid3dFK2JYV3BVZldyZkJIZVI1VmkvZE1XOXI4?=
 =?utf-8?B?bWhVK3d5NVlveHZkaUZSWU1tNTh3bkozWktRR0c4cFRrQzZWUjdZQlk2R2p1?=
 =?utf-8?B?aTlINXFLVW9vUjVmcjFldmRRUWd1Y1k2WFVhYjF1N1p4eUxLMGE5Mm1KYVlU?=
 =?utf-8?B?VGovdXhiNFQ1YmlpU3BiQUF0Wit4cHhud2NkQmV4NTNuRlRiWWpxODFnNlZy?=
 =?utf-8?B?ZGE1a3NsVXNCNjg1NExIc0dMWXVEZGpSSTZBZExtZ29lR24zZmRYOW1WVWNo?=
 =?utf-8?B?T2w0VjRvWkwyVkcwS1grMVFRdzNCeE1EM01BWkRZY1lQYUprWDZCU255Q3A4?=
 =?utf-8?B?VEdGYVMxcVNTeCtBYXZ1N2Q0V1A0TnZsUDVXMHY1dmljNmlqVFI3azhsK3Jk?=
 =?utf-8?B?UWRyUCtCNGY0NENzU3o0dDBrSlhkWHRXcmx0andjSHd0VGJKVTF5YmREckx1?=
 =?utf-8?B?TUtQWHZNVzNMRDVZUHovKzdXa043YW0xYWFxSXZZczFFZy9lV0s3RjVrUkNx?=
 =?utf-8?B?VVNXaEdWQVh0YWtUK1dDT3BwVlBwMGh4QzZaRTZ3YUhiMEd3Vmw5NGRZNFBj?=
 =?utf-8?B?Y3pOaWx0L2h5NDU5Q1p1MlU3VU5OZFpEVnJEVVNheVBKY3RDR0xaZG52ZDlY?=
 =?utf-8?B?V0t5bnMvOXdkdWZ6aU5yUStMYng4cXJ6RTJKd05WcFI3cmZCamJJSmhlL0pR?=
 =?utf-8?B?UDFaeDNaMDFqNFBvSy8rZloydlQ4dThlbSsraEl1NFZmdndJSm9NUGU1N2lo?=
 =?utf-8?B?WWN6aHlSanFqdlhqL1pZL0Izck84Y1JDYUh6Yk12a3J4blV5NjF3TlVPejhm?=
 =?utf-8?B?dDd5bWUvU0QraXN2bUdLV3NBT0xBTlgzN3p1ZTR4d0ZhMWo5cldKdWl5enhE?=
 =?utf-8?B?dkZ5TTlkNEN6K25ZcnpKL3BZSnlHUWhZK2hxMlpYWm0xWGVnc3J6MVpVckNV?=
 =?utf-8?B?RkJNcVEzazZxSjBFUnhwRTRBb0tDS1k1K21xVXRLR2k2VHloSHBKaW1XZC9S?=
 =?utf-8?Q?G1i/oe8gyhPkSoTC9Oe5fXQUn31QI6sR/KVATFlbpxCYM?=
X-MS-Exchange-AntiSpam-MessageData-1: Uk4FufunRf4naA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1929eb-dff5-41c9-9b03-08df4b963633
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:21:03.8195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRw8UKUA/+wFtfVE6NrdXQ3a0AzX+DDPB2Dg8Tm0/yCgQZubyqMSuqyjJE+UDVB9fYyhfBSRiLqWBb9oqyw8MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB248855
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the separate `load` step for booting falcons. This `load` step
was always paired with `boot` right after. It is simpler to merge these
steps and also statically prevents trying to boot a falcon without
loading the firmware first.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                  | 12 ++++++------
 drivers/gpu/nova-core/firmware/booter.rs         |  1 -
 drivers/gpu/nova-core/firmware/fwsec.rs          |  3 ---
 drivers/gpu/nova-core/firmware/gen_bootloader.rs |  1 -
 drivers/gpu/nova-core/gsp/hal/tu102.rs           |  1 -
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index b1ba94fd2bcd..9f0550e24ee5 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -616,11 +616,8 @@ fn load_dmem(&self, segment: &FalconDmemSegment<'_>) -> Result {
         }
     }
 
-    /// Load a firmware image into Falcon memory, using the preferred method for the current
-    /// chipset.
-    pub(crate) fn load<F: FalconFirmware<Target = E>>(&self, fw: &F) -> Result {
-        let image = fw.image()?;
-
+    /// Load a firmware image into Falcon memory.
+    fn load(&self, image: &FalconImage<'_>) -> Result {
         self.dma_reset();
 
         if let Some(segment) = &image.imem_ns {
@@ -690,7 +687,7 @@ pub(crate) fn read_mailboxes(&self) -> (u32, u32) {
         (mbox0, mbox1)
     }
 
-    /// Start running `fw`, which must already be loaded into the falcon.
+    /// Load `fw` into the falcon and start running it.
     ///
     /// `mbox0` and `mbox1` are optional parameters to write into the `MBOX0` and `MBOX1` registers
     /// prior to running.
@@ -703,6 +700,9 @@ pub(crate) fn boot<F: FalconFirmware<Target = E>>(
         mbox0: Option<u32>,
         mbox1: Option<u32>,
     ) -> Result<(u32, u32)> {
+        fw.image()
+            .and_then(|image| self.load(&image))
+            .inspect_err(|e| dev_err!(self.dev, "Failed to load falcon firmware: {:?}\n", e))?;
         self.hal.program_brom(self, &fw.brom_params());
         self.pfalcon
             .write_reg(regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()));
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index 9c02a7a6a977..976885b0ca13 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -191,7 +191,6 @@ pub(crate) fn run<T>(
         wpr_meta: &Coherent<'_, T>,
     ) -> Result {
         sec2_falcon.reset()?;
-        sec2_falcon.load(self)?;
         let wpr_dma_address = wpr_meta.dma_address();
         let (mbox0, mbox1) = sec2_falcon.boot(
             self,
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index bde546c95a41..a5cc4e2e424c 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -392,9 +392,6 @@ pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<'_, Gsp>)
         falcon
             .reset()
             .inspect_err(|e| dev_err!(dev, "Failed to reset GSP falcon: {:?}\n", e))?;
-        falcon
-            .load(self)
-            .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware: {:?}\n", e))?;
         let (mbox0, _) = falcon
             .boot(self, Some(0), None)
             .inspect_err(|e| dev_err!(dev, "Failed to boot FWSEC firmware: {:?}\n", e))?;
diff --git a/drivers/gpu/nova-core/firmware/gen_bootloader.rs b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
index f2dd88d27098..6cb5292c1c4e 100644
--- a/drivers/gpu/nova-core/firmware/gen_bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/gen_bootloader.rs
@@ -219,7 +219,6 @@ pub(crate) fn run(
                     dmem_desc,
                 };
 
-                falcon.load(&fw)?;
                 falcon.boot(&fw, Some(mbox0), None)
             },
         )
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 80936194806a..2c95d178b020 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -97,7 +97,6 @@ fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
             }
 
             ctx.sec2_falcon.reset()?;
-            ctx.sec2_falcon.load(&self.booter_unloader)?;
 
             // Sentinel value to confirm that Booter Unloader has run.
             const MAILBOX_SENTINEL: u32 = 0xff;

-- 
2.56.1

