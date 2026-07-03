Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E065C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECAD810F773;
	Fri,  3 Jul 2026 10:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aOZ4AB9r";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12EF10F773
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUOxGudKiU+QSLeihStK3LW9kf/YT/5fMSFPPOcYJJ0Ta/fJ1KLMU7U3riUcsVZ+PTkT5op4HpB3cWmZwsjJfrer7Np7g8zf4ZfTQrUrfQ8lrpihIYyZ46e+rTpMRq/gIxBhl02HdFtT4hlcHayvmOPJouZHn7zX/tipiU0kNMl4B81qW3txdI1xdG+PmzEZkwASeyaTI13VxzCGHHr9vUGkHTRQXwXk/EAA5Vpzp/U4yhYiJbEFH/6BEzFyuxdGlg8ct/oV5xHAJ7tTJr1ijKfZ5y3Mq7sXOtJ7+QBuCW0qFI8pZbk9oEQPYt6oMezMYKtuCwB0/9TFXOdV7GpDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfr8aLwqtl+gQAKPfu87i/QLHpiDui35nojCpqc1tGo=;
 b=o+060IDm9kh5eM6mnH2lbwiIdewQJVV9nLgeCWAauqwhP/hWnCJYXM0+v9HeRozxiCbqyPKJsLpEo1cLfRr/vK201jKkc+NI4B4NdY/Z82qoM/FZqYDCkhvzd/p3LrQJg8ivac33LXEK6/5fU+K2jyjEKApoGjU31yenc9Xn1NCaBfm68/ikrkFFTf3VsRvCslWeSQR8D5iNEbgOup+oxD7lzDkwpQB/osUgYFlHK0XliOxNMx9JONGiWQ3Gtw8a/QAQQ6P2WFw99prXqBFiIk5/E7jv8f8h6pYg7oEUWheRN6wATKuNFbwYzSbv9sDmQjbXXXKq2AWuJzL5RcPfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfr8aLwqtl+gQAKPfu87i/QLHpiDui35nojCpqc1tGo=;
 b=aOZ4AB9ritbUnV2g6A+bp09z2lrUFFuvL5kPx5CKI1ADNQBIFBe+beNdbTT0iJPI8RhyiuZN+jDlM97fJ8DGA0priZgAG4itvdL3znaOTshey/uIwYROnvkEMhsG0UwUtdR2QOvbKadTG+RiFJETM/lSCqws9/DxMUm6O90Lv9HmQMb6fHCXT4lWU+6+pOufa+c5w9/k6Nuh5GRm65JNjs/GsOf4ekikipvJQSkOFoKMpMWpTHtvRzweB3NkShU+tOJQYIljvHSQOf36V+FLtjBnc+an79zrIk79ADHMJ6Cb+z2oUFRecwnyn74W77sHy5TO/DUCB67FgzkacS8eOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:08 +0900
Subject: [PATCH v2 04/10] gpu: nova-core: gsp: ensure LibOS DMA allocation
 lives long enough
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-4-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
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
X-ClientProxiedBy: DUZPR01CA0235.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1ba1aa-0eaf-4e56-98d3-08ded8ed0053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gaRy64RMq0v9EspSm2ejYJWvlaZG9vYaZyZHpztmWt7zWHHPBOlBCZetcMAKe5yLvzu7NFiqOqdgMHrICa/RLmVW/m4oe7+kDVuzKlE+E6IlZOyE+39aCKI1yozzaCcm9FpnUbEc+Z6lWRQksU3LMGgnNv17cF3Spdzo3Q2mfSrNxQvCNF0/4C5HOdp8t7uZFBDDnOWDXE7Yvw5wnP3CYBlstX/DxP8TBUl47yKaJnIPQXxt4egLKpbJIHF1mjHj8K33goZHL65YPx7S+CqAgzjjXSNbwgGz69L4zey0lS3Azy+sq4/4s6FxCxbsZNfPqMVtBGKcp7/tYvHECDCO0ZBIUjry8jup0hKlypT1anMHfu73Q1ueEkKJEbxPrpseLLH4nqWWdt0IpyjRoxOTLZo9xy/LiB6b6mvS4JXwHYMPBRqQI9xaE9lgVZdyTgdoRy4T6r2EqDaN++NhX9bnLWdaQ0UA4hlJqvgyoepq+kOT6BccE9dlPN9TMr1wqWexnNvivkLI9Benne72wDqEieNcYy1g2aUWPH2WweKeH5I98gpOVNWuuF8pXY2sipsjq6/CWov4fIoGjb7djfuHf4YVbEQJrKxwJ5q0nVMQWMdR2BL5QoeJm8EDnWEEOJhdxRR3/c8x/aQV/MJwwh86m0o9GkJp6jAKJjo/uDpKk8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkFVcFdhTG9valpuc1JFS2t1ekoyOUhiOER2NytFWER3c01rUXg5Z1JLSmNw?=
 =?utf-8?B?NnFzZ05jeXEyNUQ2NnltMWh5SjBBK1UydGNPWGEwV1FRNngyOElSdXV2TDA3?=
 =?utf-8?B?T2RJVWpiaHVpeEEyY3hlN255eHlwV0RSWlZEaVBVME5VRStMM3VPRHdKN3Q0?=
 =?utf-8?B?amtvZWVxOHo4SE5XbzZDeGJ0YzBPaHJCU0NaNkNlaDUxS1BvcWVvdGxCU3lR?=
 =?utf-8?B?bVI1SDdHYmZaeTVLc3dyajBVb05JVzMxTC91VWNZY21xdzJidW9lWVp1bXNG?=
 =?utf-8?B?b1ZsaHJGSXozenpzYzhpY1FHelFlbDFxVk1sejBSRk1vb3BVWVl5TmdaUEJ6?=
 =?utf-8?B?RWdOZWlxTjVQZSs4R3UvUWNRaVhMejF2aTE2SFNMR1ByT1YvZm52bG1MQzlH?=
 =?utf-8?B?K1ZrMzJsR2tRbWF0blFUVkdTOE5tVU1aNzJVb1Z5dHdIaHd3NFdMdk1Tc3NY?=
 =?utf-8?B?ZjBNaDczVXl4SFZTYk1XcjRrY3BLSXRTY2dkdmZ3ZE5VRVYrQ1JkWHAySC91?=
 =?utf-8?B?dDJaaEpGMHlmd0lMd25rVU1RK0tiajF1T1dWaE5sU2VVN0p0RGVXTVpHVWh6?=
 =?utf-8?B?eGRIeUc2eUdqa0Q2QWM5T05nbGF2U01Lb1N0UTBYejk4ODNDTjNJWnFXaEdq?=
 =?utf-8?B?OGpuOE9CZHBucXdnZkp6NzNQUDdvLzRtRXMvbXdzTmdxdnJud3Q5YnZzL1oy?=
 =?utf-8?B?Y0hqMWVXWGtTL1hEZnNOM1ArUURBS0ZxZE1SeG0zcW5ON2xYRzJoRE1KOWJ2?=
 =?utf-8?B?RHpuRmwxTGhiTWlKWTJDZlEyWEttRGtoMFFnOVBVVTFoUkh1Q0pDaUp3eEg5?=
 =?utf-8?B?bGJCTSs5aHNSbVR4QStVY0xJVGlUaHA3SHIxVldHVm90enJkVjVQWWxRSHFB?=
 =?utf-8?B?QVN5RVh0Qlo4NW9sUWJKTllDU1hRMDRDNmVOYmM1QkNCZ3M3UGZwaTVmOEtp?=
 =?utf-8?B?V2c2QTZnQ1Q4S0NGcFFLZTgzYTI0emxuUmpmZ2NWV1ErMFJBSW94ZmpDb1NW?=
 =?utf-8?B?WG1qeUxVUzF6WlZlNHBvdjFoUVlaQ21PMDlQZ21hZW5VaDBGUmNnTlRUZURp?=
 =?utf-8?B?RllUMm0zR1VOaFB3MFpPZ1NzZGI2RzJkUWM2OFZiNFAzY2xVVEZaczViY0No?=
 =?utf-8?B?UnhPQWhFVWtpdnJ2TWdiQVdUVnN4N1hvanRJay9vaksrQThuZmp1K1dLeHVN?=
 =?utf-8?B?RllKeisxQVYxNURDdi9aWTdtUXJPTnVLM1R5eFlrWjYrR0J0YWtZcUZhQW1Q?=
 =?utf-8?B?WmlvNTZDaXZaQ2NmZXMrR1ZJUU8zK2VYQVlXR2pZZkNxcmpoVkRjeFhjRHRC?=
 =?utf-8?B?dHUyV2dackdVdy84eXg0dWl1bXQ4dTc0N2ZnSFBEb0JlMDJpNUlKMW9PZkh3?=
 =?utf-8?B?U05pL1hQVkpabGNlS0kzNXRyZk9pNEdLK0huamlZM1AxZ0ZtR08vWTgxSGFW?=
 =?utf-8?B?cmNEY3JGay9tbTRoZGRMclpOdFNKdElCcDZuMytYQ3F4bWh1dmU5YjBzMGtz?=
 =?utf-8?B?OUxqK0tNTEFzeUJwZEN4MEhYbXYzbGZtTzFiRXRFR0grQWdId0FWaWp1T2pS?=
 =?utf-8?B?dU1yRjJLNjc3eERTQjRBZUVvenVSdWtZZ3BJS1VnbXZhNVdmNnJkZjBFRTRO?=
 =?utf-8?B?Q2ZzMUljejFBaGtQSElGcUZxOWRDbThJZFgwSEF3NEhGQlJ4cW5iQXhVMzdZ?=
 =?utf-8?B?SVdMWXVsa010NllkSVVXU0FuSXlmN0hkMVVickdGWkY2SjU3d2s3bm11VGEy?=
 =?utf-8?B?MGVYa0VxVWNteDlvNjQyZ0c2S3pZdlg3UWNZbEpSWTRwcWdqVXlLeS92N2dv?=
 =?utf-8?B?UnBmaWMrVGpMSkQzcDcrV1JnZklCMkN3UlMwQmE4TVVZaEo3OEpzSWFERDRi?=
 =?utf-8?B?YUhXV290Z0Zyb0VmRkNuemlWakFLRGxNS0VhVU05YlVHTno0SGxYcFRGY09k?=
 =?utf-8?B?TmVTR01VdGpOT0dsdVdRclV1NGQwZDYyMHVrODFXM2Z4NmRNaFhzUFUxN1Ux?=
 =?utf-8?B?ZUlpR3JWNTUwdHZHdHVTZ0Rld2FLbDkyVHVYVTk1eG43RlFPMC85T1E5eWdR?=
 =?utf-8?B?RnY5bnBucEY1ampLeVF5MHV4S3c5V2FnUzZDMkZkb3diZmNSUkh1T3p2emFB?=
 =?utf-8?B?QUJQblJKN3R4V2tOTmZObkNjNnRNNEQvT3JnMEY0dno0T3FoOFhZWm5yRE5K?=
 =?utf-8?B?Q3JTeUEyUkhldzJhZmxOQWpWVFRqenlKdTQwZ2dOZG5nTXZFMXI2U3Z1TmZj?=
 =?utf-8?B?cjJDNG9XMW8xQU4wOE5sQ0RqNEpacXl0dUJpMGlsZ0RxN2ZHZmVBVnFrYnVD?=
 =?utf-8?B?TmkyS2pQdzR4UllEUUJQVS9icXpqQldNTTlqbG1pbDR2NElpN0RkQkhHWVZ3?=
 =?utf-8?Q?0VUHNDspDC8zWSVZUQIK9l9ZZQJ75PCtxDe7RDdrP6abU?=
X-MS-Exchange-AntiSpam-MessageData-1: FCTZveIzbGxldQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1ba1aa-0eaf-4e56-98d3-08ded8ed0053
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:35.8365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiGYJcJF/mE7jq5y9EW3jK79Qe26xbKnbIzFnBKBOlFl8J/2gMBh3v3vdbvUzhkSBHKdYHOrgB16JiEIdU3K6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Currently, `GspSequencer` stores a raw DMA handle. Instead, store a
reference to `Coherent` to statically ensure that the allocation lives
long enough.

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs |  7 +------
 drivers/gpu/nova-core/gsp/sequencer.rs | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 2b489df6d0aa..c7d5f1ab86a9 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -322,12 +322,7 @@ fn post_boot(
         ctx: &mut GspBootContext<'_, '_>,
         gsp_fw: &GspFirmware,
     ) -> Result {
-        GspSequencer::run(
-            &gsp.cmdq,
-            ctx,
-            gsp.libos.dma_handle(),
-            gsp_fw.bootloader.app_version,
-        )?;
+        GspSequencer::run(&gsp.cmdq, ctx, &gsp.libos, gsp_fw.bootloader.app_version)?;
 
         Ok(())
     }
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 422a74f9ecbd..5e1ec7e59ab0 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -6,6 +6,7 @@
 
 use kernel::{
     device,
+    dma::Coherent,
     io::{
         poll::read_poll_timeout,
         Io, //
@@ -31,7 +32,8 @@
             MessageFromGsp, //
         },
         fw,
-        GspBootContext, //
+        GspBootContext,
+        LibosMemoryRegionInitArgument, //
     },
     num::FromSafeCast,
     sbuffer::SBufferIter,
@@ -135,8 +137,8 @@ pub(crate) struct GspSequencer<'a> {
     sec2_falcon: &'a Falcon<'a, Sec2>,
     /// GSP falcon for core operations.
     gsp_falcon: &'a Falcon<'a, Gsp>,
-    /// LibOS DMA handle address.
-    libos_dma_handle: u64,
+    /// LibOS memory region init arguments.
+    libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
     /// Bootloader application version.
     bootloader_app_version: u32,
     /// Device for logging.
@@ -232,10 +234,12 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
                 // Reset the GSP to prepare it for resuming.
                 seq.gsp_falcon.reset()?;
 
+                let libos_dma_handle = seq.libos.dma_handle();
+
                 // Write the libOS DMA handle to GSP mailboxes.
                 seq.gsp_falcon.write_mailboxes(
-                    Some(seq.libos_dma_handle as u32),
-                    Some((seq.libos_dma_handle >> 32) as u32),
+                    Some(libos_dma_handle as u32),
+                    Some((libos_dma_handle >> 32) as u32),
                 );
 
                 // Start the SEC2 falcon which will trigger GSP-RM to resume on the GSP.
@@ -336,7 +340,7 @@ impl<'a> GspSequencer<'a> {
     pub(crate) fn run(
         cmdq: &Cmdq,
         ctx: &'a GspBootContext<'_, '_>,
-        libos_dma_handle: u64,
+        libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
         bootloader_app_version: u32,
     ) -> Result {
         let seq_info = loop {
@@ -351,7 +355,7 @@ pub(crate) fn run(
             bar: ctx.bar,
             sec2_falcon: ctx.sec2_falcon,
             gsp_falcon: ctx.gsp_falcon,
-            libos_dma_handle,
+            libos,
             bootloader_app_version,
             dev: ctx.dev(),
         };

-- 
2.54.0

