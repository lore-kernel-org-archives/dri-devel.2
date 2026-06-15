Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D896BCD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ECB510E4BD;
	Mon, 15 Jun 2026 14:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KUfDohuE";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E910E10E4BF
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4UKFkKRTjhuXweV89q278JJOFwlBJkiOegbvWdAXSl/Thy4Hb+fRYVHaI1B+GYTeDzPd/9Ax++/joXC6/u+gqT8iZGo1jM8fDwOh5ZIBjjH4DGR/qnbvPn6uX8FNfrv8QVMUksqhuTY1CciYCgT9J4S9P1618mNhWSDVdIeugVtZEB55YTiEvq303dmsv3EN6kivJLcAEzgBBb5iDgtpslGFjiSRZyGJ9v1FBtYVQ8FMpzvxEF/felUkcZo/Ad+M1mZv7b9FDHEjJkrSIW5nw6kxu7lQlW2GX0PfKuIhqb4+H/g4V6tqt5DDLxzqM2g0WR9K47qhP6uj1v4FoiVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvs+X3HAYncHx9f+8iFEqtfQWXQF3i+aJsSNH+4ON9s=;
 b=hlUxdLoQBi4DJgf0MrLc9HEMRyvlJk1/hDjTQe7F4RGWQ0hFYDQszpv+vOS4uJYxxin0cWHqmfXRI4KUZ/aOY1RIVnaI4udJMvZz2EvqirYtnlWyebuHRycQbylZytMsu/QE7obi+sSG4Sc4UGd3by7WS+D2Q2XxhlY017krNaRgvPUZCUrFb6Q6ZvlWY4XLmU90PgN4IVU+zR3/Pr6LVoaWbH76E41F/q8wszT/TL49oBUb+uY3mK+ZgAuaw9GKNYhExQu9bs6ZhB0H013kZSo+doAyLASgsvHoWWp9iY370IXbJ+Ye2CeJ7EZbn8MyNvszoyo/wNeTnQcVgVuwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvs+X3HAYncHx9f+8iFEqtfQWXQF3i+aJsSNH+4ON9s=;
 b=KUfDohuEMxlxAcmHXt3pAFeovveaJHE3Dzh560Fb8+VEUVcDZxrHy9wRmz84ENTZhsS1PlGGXCXfnYNi/nKbQWjeUQXkVxwX2i0DYx7zi+krbGSRX722ubxnEG4pdOkkSRdYvIc3KnzmhSZezUNlEsWp4hZ++BetipnHS4wpi6XqUuH3iVUcIwfOx5PD9NGX4YbRtYGM3+AQbBOnrCU//FhZ7KxeNaDYtp8fs/kjk9UBEwPiegQiSVrKIE5DNCOQFXbbnT+Xe1Z3g4/ZGdYQVxSm93PpSgW3a37mjdAxOhz12aHng9tak/rUaWa1ZT6nwxe2aQ80pLv1/PMdTh9xwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 15 Jun
 2026 14:41:49 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:41:49 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:45 +0900
Subject: [PATCH 05/13] gpu: nova-core: gsp: keep FMC boot params DMA region
 alive during error
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-5-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: ee06f0e7-d726-4d83-98e4-08decaec3b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|23010399003|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2cc71d4L+iRmlJUkSISnbFJgvW7K8vBKbDgoYzjPRNuNVKLIxXg6LTAIW7xUZHVJcOIqQV9s4CBUdtz+8HzjhAxyLbKCZtXvPKAHm46TrTf0d6zmZXCQtOFaJTnlG/4DajTUhrb8s6YTH85hWCMaiec0NzSFbn9c3uCmhiS8/6oCq/w/BLvaXHnBV56fk/aZffgrMWNawLg/cObGpv9nQSBgApsSTpbnbfzNnAEX2SZmRHfZZ4iEBytpgBynx6hLA/HAlTwpyyUUySEprnfE5t1sjT5nNFMXuvTgJy+uNKrDP0Rd3sSTbnhmMynxG/bhbIIgeNzrSQ+8idpS3+aBgu5LsVvPTiXjtgfXzxLli4Nq02LX1DloQnH2U+EEFqW1Aj4Ml4+2tkY3xPoIozzQCEJL7YTcpmOKlysIF55G8KSHJ89u80YstVll7RzrFOeg3rxSHGObOYrYMXUiRAFW8Da0l9QcB03asDwZ/zo2noEOxEUWnvCj3JFVDNfbs5VFUgN3C03Ay6lMh439QHqaA33K9p1Kqqt6sp1pEnmULOzgS5B/jnanA8UmhcwrQMFdAPezxiMX7rrBR1BrONALILbXlhzuLNmnGlXHbLF4pV2ybgit2cyXGzFI6EyKTzEbBu/s9RwTH9ASqn8EfUIwwJTzVz4EonJZUSgEJNLA43M21h02Ag4+vtI+ECOu4w9i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkJnYlo3U0pLRlNjSEhjTStHQWFRbmVzeFVxSU5YckZKaHloaUl5Z0g4Q1M3?=
 =?utf-8?B?RUpNVlREYTY0RzZBL1d4VnVPTFRuNUdPZmhlQ2JBK3pjTXk1OHo5d3JNNWkz?=
 =?utf-8?B?RU02U0ZnUnVFd2VyNkNHcGNxOU12ZVNTT2hVeEY1NG5kODFyeEptajVsa2dT?=
 =?utf-8?B?VVU1M0F6ZHhlY1laRXVsM3JiSXdqOFNtTHhaNTRrSmRZbjYwYnp6dkpwcC9N?=
 =?utf-8?B?MXpiTXdlL2lOZmFLSG00YXJaa0dWSVFSYXpXVnRhc3gxVWhZazFBc1JCYWtY?=
 =?utf-8?B?VTk2cVRUQzkyMmJkeG03SzljaVBxelVkWTdIdmE0YXIrTlVpelpkMTZoMHI5?=
 =?utf-8?B?ai9Vdm9TVjJuZW5TTytPUDdlcU95S0ppYk82WUswMHpiOXltM0Z5Q3dablpw?=
 =?utf-8?B?bTZjeVhFQXhablpHbjErak5Hc2ZIQ21oV3hxOXNjeStxdXU5SFRIenZFVm5H?=
 =?utf-8?B?bk5LdmJ5V2hucHdiQ3BtNWdrYzdaZ0k0Rm8zcE41UVZEOXl4Wk0xSk9MakQ0?=
 =?utf-8?B?NnErRzZjM3BkTGFHOEMyNlNSTHY4S29oS1NrTlNvNnBTSklncnhTUTNHVFJZ?=
 =?utf-8?B?eEZIL2MyQlVEMVE1NEd4NEZVU2dVNjFKcS8rbGViT2tZZHo5SkI2SStYVWxW?=
 =?utf-8?B?dGJ0c1NVUGdRbkVxbW5PMXAveFQ2cjRGYXBqbUlJY3orK0wwdGdqQWMvdzJB?=
 =?utf-8?B?RGMzMVZRN0dyOVFMeG5PN1hMaWZJbi95T2p0SFRKc3Z2RVQ0Wjh2cENDcENF?=
 =?utf-8?B?K3NJaHlXRWhtOU5Wek9hVVBUK2VFNVNmRjFoUW55M1Rqd2RDbTFEaXE2NVhD?=
 =?utf-8?B?QTI2aEQ0SzUxdGN1VHp1ZVMydHN3NHF6bCtudTBQWHVuOHJjS2kvelJGb0Mz?=
 =?utf-8?B?OG8yTWp2TUxqc055Y0xYZkNwL3RxRUlkZTRxeFFXWXlXVzdRVlI3VS9Galp4?=
 =?utf-8?B?bXJlZDJ6alJHc29uSER5cjFaRzRGMWkzbXoyaXZnblhoSm5CZDJZYndZOEp0?=
 =?utf-8?B?SmRGVlAzdzVoV1NEOWNXbCs1ZkdjZ1RNYm9wTmpZS2JyQUI2UVVXS051eGg4?=
 =?utf-8?B?OGRvOEVVeHZ4TU9OeXZpdjd3Z3RKRExjaVNiS3NmTy9XcGdSWW1uWEVMb1BU?=
 =?utf-8?B?dEJNNnd0R2RSTGFkbExPckk4WE5JUUlyRU8vMGQvOHI3aldwNTFNWFZ0ZUFT?=
 =?utf-8?B?QUZSMzhLUDduaFdoZ2hKNTNWTkJUaDd6QXlBQkV0WlhaQWhnM2dFS2VVMFRm?=
 =?utf-8?B?ckMvaXIzVWJXSmF3YjlZbTZvRWd5dGVEVG1QdC8vazhReTRQand0YnJMazNl?=
 =?utf-8?B?aUt6akprYTJJay9qZjVmOWx0SEVYNHZSUE13SWZqR2VHdys0ZmsxbVdsNjBT?=
 =?utf-8?B?ZmNsYlY2VUdWNDlEaDBVVk5xMEs0Wnk3Y0FqeCtJeERQMENzeG04Vzh0dmhl?=
 =?utf-8?B?c3BHQmd2NHdPR29Xc1ZmWWYzdEhZOGJTTUwwWXBrTjNocVRNUm1zZm0rWVdr?=
 =?utf-8?B?TTZrRHNsQXoxZzhjNzJOUWEwRGRrQmVIeWlRNE95R3p6YjBBdkxOK2ZIYk1B?=
 =?utf-8?B?c0dKNHdONmtwSXkvSVhOOXRxS2hyWkJsMDJGVnJweG1oMTIrQ0xuanY4KzBI?=
 =?utf-8?B?dEkxMDR2bm5JaW8wdjNuNzBoS2MrSURJdStGeUFSdXJLa3Q2NjZCZXQyRUFt?=
 =?utf-8?B?VUd5amh2c0JIaFdXWmdrd1NEL1BlYkxvcUVlZEIrVm4zK1lxSHNWZTE4bG5L?=
 =?utf-8?B?dUI5ZXlRK3pPelNISzBjUUVOVGxPeEhYY083YmR0TjMyOXZQdnVIdXpvSS93?=
 =?utf-8?B?RUR4blI1MERWM3R2SjJNc0EzOUxvWkFjcmpxQU44ZFlKWVVJZGFCeGRMMm1K?=
 =?utf-8?B?TWdiOHljY2VSaHBRcmN0akhBOTV2Sm90UjU4dnNrWUdjeVRCUSt6UWVtNFh2?=
 =?utf-8?B?elk5ZThxS0hZMEZJcEhybmpkQU54OW1BNVRZK1U0czlBQm1ZQXNHUUVVaWhX?=
 =?utf-8?B?aUFldjNYbGxGcXdCSThQRWNZcHArcVZSREhVb0ZwVnZWNEFGbDVJZHZaSWFp?=
 =?utf-8?B?dXR3NDlpRHpQRk95UDdyekJPa0hHYWtZamZhNVRZaDBwUGZnYVY0ekV4WHNZ?=
 =?utf-8?B?UGFneGNBZWFrZDlFK0VWOEpmMnZMdjdsclNRdWhJdHh0WVA1dmRRNkY0SDNu?=
 =?utf-8?B?c2hrcnJNSlArQmdZbGVKOW5iY2tZMzBmU0tQWXBGYW52bnBVSzRnYUx4bzhr?=
 =?utf-8?B?VE4yWGNUeHZYb1hyZXE0SVZ6VEpteTF4R1YwYWVKeVdVb3h4dWk2WUlaZG9x?=
 =?utf-8?B?TVlFQnZ1YUpNMFF2MnBGc3NCZjU3NFlNaExpRi9ZNHQzSis2eGcybG9oNkxB?=
 =?utf-8?Q?LRRkoMJ6XqhRxM0rIEjU7evAJUMZ7ZzZAzU3zNo8YF9o6?=
X-MS-Exchange-AntiSpam-MessageData-1: ZvbR49TDSftiWQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee06f0e7-d726-4d83-98e4-08decaec3b77
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:41:49.2772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6cHysQ5444Ou2OjhV7vmOhPsQ1HD4kQOff6cAGLi4NiHxpQ8ng55AMhK/YiDQRRn2t8kuNMlqrEwnkzYbQWTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

Currently, if, for example `boot_fmc` fails, `FmcBootArgs` will be
dropped before the boot unload guard. But until everything is unloaded,
GSP may access this memory, so make sure it doesn't get deallocated.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 98f5ce197d13..b08761af89d3 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -162,16 +162,6 @@ fn boot<'a>(
     ) -> Result<BootUnloadGuard<'a>> {
         let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
-        let unload_bundle = crate::gsp::UnloadBundle(
-            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
-        );
-
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
-
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw)?;
-
         let args = FmcBootArgs::new(
             dev,
             chipset,
@@ -180,6 +170,16 @@ fn boot<'a>(
             false,
         )?;
 
+        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw)?;
+
+        let unload_bundle = crate::gsp::UnloadBundle(
+            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
+        );
+
+        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
+        let unload_guard =
+            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
+
         fsp.boot_fmc(dev, bar, fb_layout, &args)?;
 
         wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())?;

-- 
2.54.0

