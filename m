Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FA3C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433D210F768;
	Fri,  3 Jul 2026 10:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hbeyUmzF";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5406A10F768
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1Lzduo80u3IM6BAGcf3zFmq0ucjZUpYWT7jniKwCoRZ0Z/i48W1aEZ7pDb+cWParIlOtt9WenucsueRJnbwKQvoDUfvYtZtdaYsuOZZERc8v0QjTrftZJP5fMcZ7Qc19oMWVtPnKSSdSrIuEyA1No55pGGKhUDpLptK/XjnYUm1qk3WK8p8QB8Bw7HCi6pmGO03FLs58vykXfdnZcmyBeG+S+ko4ZmGNtUWSZDx/GBmnDeE+Z/LS4UDZZVbTcw0T+2K8/byZPvCdno8F24Xn8l7AQmjJoMtl6bi4/7Fyhvsrsg+0TgOM9khVCC3aZc0E8Nl9YRZtz+PqzM51ILZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWn+v2jJmG0Acdn7Ovrcj8o7vRV/l0NDC9v6bhLNJmg=;
 b=ujn92EMZfa1ZzPcff7xgUqNK9BiyjYrGHuRIw/qkvXd1ar6AXw5N79s/gT5ECaUivDf7Gbo1QtUeaN/GKK+XcEYa8AQZMZCVGmzPY9cMtaBvEZwbz7VpgfQPYBSp62Em5MN+lApbeu3+Pf/t6Da2cFk/BfelLBcPMGb3+Ab8apHqTei1EFkwk20npeSOY0LTFgZqsguDJQFBWY55jtH1PaeHO704TlmbHQWPU8Pl9qamsfnBxRwG+fUz3wCqwlituB3n7A4FT9eK4hv+9c07a3MgAWvnThzDx1DIMjeUNPfwXEkTWyHpVq1T1cyC6aYO2flH3Xe/r0d245Tm36uBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWn+v2jJmG0Acdn7Ovrcj8o7vRV/l0NDC9v6bhLNJmg=;
 b=hbeyUmzFI1wRiJBe032VrSEJhSSMzMS0QvpyfW2/S34pokpSY4xtTESTSg1ZfiZoLaTy5falf2hDN0kEkfngwOdWd6osNYJQMdUOHN/7Pk6XJK91fAkz2wADTtNeDAAUQ8X5PbpAsWq5u81TmL+Qk5nrPpwkn1Zm9L+tESS+ZqhwQrUdAL78YrslHhEEDcWJrPE1d6psRdeTdNe+dy2uU14uXXOkVIUn8qM4yiKRJs14SMQJLoToeoHMH6ZujvZU1e0DEDAjyFib+LwVcQwGRKao3jbrz25hkGhWkIaiUFRrIab7gGPuwTArQSKRzESOV61v5PDBPhrfs4RuXrm1LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:30 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:07 +0900
Subject: [PATCH v2 03/10] gpu: nova-core: gsp: ensure lifetime for FMC boot
 DMA allocations
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-3-8e3d8bc32bb9@nvidia.com>
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
X-ClientProxiedBy: TY6P301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eeab95c-50b3-4c04-ef6a-08ded8ecfcf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: B/V9XIM2LK3XBsCPPBL2PPImmGm9VFRMok9vmEhbkNxTGNXtS9haW1FOKAUloC7IfqoP2uBlKxaXukgDEitmhmqKKpZ58jevP75Z3S1KQnPanEJYLAJPN2bJYDG7jrAvKbyaFp0bhoB5Dof3d6Mu+YlvmTqR0fy6r5AHx/cN04OpJzd14DOKeMhs5DqeXNWFGV4O5yG0N7FwUsXfsM/wXzhBhx4EYxZriTqUl3GuQdqbHwxVSdBLYAoCcNOEpm/CKBa7Hhy8Z+r4YgWeEwVqZeGPHGa1kN5HLZ4cGNfw6mx+dwF/XqF63KgmyRGOeMHwdTh/bXx7va6es0U3LeI2b/qU5kw9oLSc/Qrg+Snw2Wc1Vp+MbNAXoIklSNlOxnsg7pzfMBU5DjEakfoPdEBYo5agIw7p3A+WdqcUhYeZ+mHvUZGaYqAGeJilbitKiIK+B9vft/h7D6QgyICWqYfTZuru84NHyeF63ln2K3s9bUSfO3IPTVuSICLzGIzwVf02NmMY7YAF1AzTliOMalWULyH8zxPig4YekPrBWIwjqtvwMDIA4B7btt+WYrT2NYLK0STUmEtzmVHBYtjdUwmM3NK1sxCYFaGRMJPmIzDvXqH1tuh4vVJpi/8AgT1t2n1+BMLVsTB69oTNuOWL/dD6MEK3gnv5DNz9NnF5XNZ6W6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZTbkxLNzRKcDNUVHlRMzQ5QkwrTTVCdUtOYVBOK013OTV6RG1FNGRUQTN1?=
 =?utf-8?B?V1NxRENsajhKRGI1Y0tBaEpKYXNLbXExekdhQ05rMHhQYkY3K2lhcTlNTzRM?=
 =?utf-8?B?YnY3RnFPb2VvdnordHFNVDhIMHp5ajRyOW52dzRNeXduMFRjZ1JTWFluRzA1?=
 =?utf-8?B?eFIzUk8vMEdDVTE3dzFaRlhaeEt4SG1jU2NQQW1jSmhPZDRMWmVoU2E1Qllm?=
 =?utf-8?B?ZThKbVliaG1Ld3laZFdQOXlSODMzVTNtNGI2aGNoeGYrbVhZWDNsTENYTmtJ?=
 =?utf-8?B?RzNKQk8yS1JhWGRBanIwUHBtL0lGWFZuMHlMTS9OU1BWK3Q4ZUFYT0M4bitN?=
 =?utf-8?B?YVFzTmdFclZFTFVlVDF5ZlZGUi9UdXgwaTlMMDNJc2o3THMvbFNHTk9lM0Fv?=
 =?utf-8?B?NWZabVQzTGxtWFNRcU1Gd0dsRXZTczVCWUJjMkdRRzE4RGhpNVZXOWtoQTRF?=
 =?utf-8?B?R1pJTWcvc29kNmVXMGFqR0M4UU9EWjFhYndDby9sVG5OUC9TOWJDeFF5UW9u?=
 =?utf-8?B?TktKcUhldTRkRWRXUUFReC9HcElReVA2WUo2MmN0SCt1QkFURTExNHRWUHpk?=
 =?utf-8?B?V0JsM1VrTG9iUW45M2U0OVpSNlV1dmY1RlI2Q0lWNWU0aTBJSkpPcGlaR1Nq?=
 =?utf-8?B?RzVXMnFhYXlCRnd5MHlCcWE1QUdmK0ZFTDh0dVJWSDVmZmF1VVVwUnRxK3Qv?=
 =?utf-8?B?eHRCQU1veVVycCtYK09zaS9kOWtUQWFWeWpnSzVWSWRSR0RETDlpMDdhZWFH?=
 =?utf-8?B?eGtKVVVPcjV6QjZIRFl2L3hTQUtib2lZNTE2M3BOUDVWRDk4Z2RJU040V00x?=
 =?utf-8?B?L3Y3TVJ3aWMrQVZRRzBHczlqdk40cGpmUTBjeDFhN2VjMlRXM1ZNWnNnVnBB?=
 =?utf-8?B?ek5jVVQ2SDE2YmhzWW1Tdi9QRjErRUV4c214VGpEOWVCdWVUU0hiS2l1cmVt?=
 =?utf-8?B?VTJiYk1TbldYOWV6NytvZzYrWjJrMUQ4NjhtdFhnYkpabm1ocVoyWXM2VFhj?=
 =?utf-8?B?aGFnZGkvYkx4aG9tdXZPYmsxT2FpcVN6a1V0ekdzTmJsR0hVT0JoQkxxWTI4?=
 =?utf-8?B?K0l5NlRWT2x3RGM5RHZDcnp2RDB1bjNwS2RYYjc2ay9VZ2pVaGQxKy85cWFk?=
 =?utf-8?B?YzFLLytUNytwSGZVamJBKzNhZFlpK3NCd1dzR1BpZjZPQldXOVBFWjFmNEtX?=
 =?utf-8?B?d3pyYlNoOTU2dEl1Vndhb2FDSEI5U0k5ai8rQ0FHV2U0aER6U1E3cEgxVERi?=
 =?utf-8?B?Um8vR3d0bFEzTUlTdytvNERZdGw0bUhSSEFqUnRzVUIwN1hkb2J2UU1ab1BN?=
 =?utf-8?B?Z2dBWi9JckdackZTYk9ESFA1ZWJzd2tUakljZCtNSXhxaFZSd0N3YUMxZ1NY?=
 =?utf-8?B?dTc3QmxnOFczRndQWWtnbWdsZHlKWUJodi9tM0hZekhJQXoxZkM4MzM5QW94?=
 =?utf-8?B?cy9VSTQ4ZkhBUXNUdGpXZVMyWHYzbHVUNmhERmV5NWRkekN3cHBpRXZXZVY2?=
 =?utf-8?B?a3RDVHJ2eEpQUUQ2OFp1TW1RQllCT282Tlg1WVVCNWc2N0xlWTlkTnRQMDRp?=
 =?utf-8?B?ZkpyMkF5ZW43Ujh3d1JxS2xaWXQrOUJOZkF4RytiVms5WUtoQ1R1YVZqSFlS?=
 =?utf-8?B?ckJyb1lqM1p6bjIyNHJUblRycXF1VExTaDA4MjlhRnFNNE5KYzB1dDlyM0Ns?=
 =?utf-8?B?dGIyaDlSOGFKdG5mTUE5S2d0L3NmRmQ0ZVlnNUtScTZmOHFQdHIvY2oxR3lj?=
 =?utf-8?B?RXlGZzJoNXZuOFZ2QitZT3AwcVl3bDVVOTRwd3VhKy9vVXZwRjBIZWdPQzRC?=
 =?utf-8?B?SXRsc3NJQ1ZxZXlwUjRjcFBPUEpUT2NnQlIzbG8vdk0xV0RTMDFDNWdmbVVm?=
 =?utf-8?B?bHF0TWhoT3JneFp5cXBlcGY0OTF2ODRpY0laM0hIV2UxN3J6NHRhUzdvbk1h?=
 =?utf-8?B?V2M0ZGVOV0JLMHFvVWJrSjNIVnRjZHR2RXhyNjJicC95eWJ6a2MvRzdmOUgw?=
 =?utf-8?B?bXNvSTVZVFlwdnNsUmw0TEVVSnBUU3F0eDY1ZGZjeWdZZ3JzK3JjdG5Pc0lz?=
 =?utf-8?B?OTlFOWQzODRMSTUvNUd0TlNiRW1LQVprbjl5QS9KenA0a3lpKzhNenNiNGNz?=
 =?utf-8?B?NTI3d1JpR3AxZGgySHdZaDBMOHhLSVRKeHhsWEhPRCtzUXkrQ3YzUGttNzRt?=
 =?utf-8?B?NGQ4cHRjK0MxNjExWFNsNDNETS95NHJvT3VmSzRVd3MvSmhmZklJYUV1WXFT?=
 =?utf-8?B?SlN1ck9WRXdtQndoTlhDOG1XVXRPQ25TZDJBL0dPMmNNRXozTEIrZDRMa3R3?=
 =?utf-8?B?UDZiSGQ5SFJkaEJLbjhrZWkwMTVSRHFqNEQzTStnUXhhY2lEd1RRbXpXOWJa?=
 =?utf-8?Q?ExsNNASM0KTud6qp9EZ8YVYA7uJYgobDZhCZL07N0T6Q2?=
X-MS-Exchange-AntiSpam-MessageData-1: QRjeeWaKI9EkIg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeab95c-50b3-4c04-ef6a-08ded8ecfcf9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:30.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htSqQawowx7NMIZ38Xd2X+PfcXlLgybTinwusKwQltZudruhnvpsFy2+vEhY6/GhAEz0p0mL3s3TvlB/a7a8lQ==
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

Currently, `FmcBootArgs` takes DMA handles directly, rather than
references to the `Coherent` for them. This is error prone, so instead
store lifetime'd references to the `Coherent` allocation.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs           | 32 ++++++++++++++++++++------------
 drivers/gpu/nova-core/gsp.rs           |  6 ++----
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 19 +++++++------------
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index f0c595175c9c..5b782aa2e3fd 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -40,7 +40,11 @@
         FIRMWARE_VERSION, //
     },
     gpu::Chipset,
-    gsp::GspFmcBootParams,
+    gsp::{
+        GspFmcBootParams,
+        GspFwWprMeta,
+        LibosMemoryRegionInitArgument, //
+    },
     mctp::{
         MctpHeader,
         NvdmHeader,
@@ -134,7 +138,7 @@ impl FspCotMessage {
     fn new<'a>(
         fb_layout: &FbLayout,
         fsp_fw: &'a FspFirmware,
-        args: &'a FmcBootArgs,
+        args: &'a FmcBootArgs<'_>,
     ) -> Result<impl Init<Self> + 'a> {
         // frts_vidmem_offset is measured from the end of FB, so FRTS sits at
         // (end of FB) - frts_vidmem_offset.
@@ -188,35 +192,39 @@ impl MessageToFsp for FspCotMessage {
 }
 
 /// Bundled arguments for FMC boot via FSP Chain of Trust.
-pub(crate) struct FmcBootArgs {
+pub(crate) struct FmcBootArgs<'a> {
     chipset: Chipset,
     fmc_boot_params: Coherent<GspFmcBootParams>,
     resume: bool,
+    // Additional dependencies required to be kept alive for FMC boot.
+    _wpr_meta: &'a Coherent<GspFwWprMeta>,
+    _libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
 }
 
-impl FmcBootArgs {
+impl<'a> FmcBootArgs<'a> {
     /// Builds FMC boot arguments, allocating the DMA-coherent boot parameter
     /// structure that FSP will read.
     pub(crate) fn new(
         dev: &device::Device<device::Bound>,
         chipset: Chipset,
-        wpr_meta_addr: u64,
-        libos_addr: u64,
+        wpr_meta: &'a Coherent<GspFwWprMeta>,
+        libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
         resume: bool,
     ) -> Result<Self> {
-        let init = GspFmcBootParams::new(wpr_meta_addr, libos_addr);
+        let init = GspFmcBootParams::new(wpr_meta.dma_handle(), libos.dma_handle());
 
         Ok(Self {
             chipset,
             fmc_boot_params: Coherent::<GspFmcBootParams>::init(dev, GFP_KERNEL, init)?,
             resume,
+            _wpr_meta: wpr_meta,
+            _libos: libos,
         })
     }
 
-    /// DMA address of the FMC boot parameters, needed after boot for lockdown
-    /// release polling.
-    pub(crate) fn boot_params_dma_handle(&self) -> u64 {
-        self.fmc_boot_params.dma_handle()
+    /// Returns the FMC boot parameters allocation.
+    pub(crate) fn boot_params(&self) -> &Coherent<GspFmcBootParams> {
+        &self.fmc_boot_params
     }
 }
 
@@ -332,7 +340,7 @@ pub(crate) fn boot_fmc(
         &mut self,
         dev: &device::Device<device::Bound>,
         fb_layout: &FbLayout,
-        args: &FmcBootArgs,
+        args: &FmcBootArgs<'_>,
     ) -> Result {
         dev_dbg!(dev, "Starting FSP boot sequence for {}\n", args.chipset);
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index e89366b425fb..f0242126e202 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -28,6 +28,7 @@
 pub(crate) use fw::{
     GspFmcBootParams,
     GspFwWprMeta,
+    LibosMemoryRegionInitArgument,
     LibosParams, //
 };
 
@@ -45,10 +46,7 @@
     },
     gsp::{
         cmdq::Cmdq,
-        fw::{
-            GspArgumentsPadded,
-            LibosMemoryRegionInitArgument, //
-        },
+        fw::GspArgumentsPadded, //
     },
     num,
 };
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index de786871c8ec..270703d0f5c6 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -24,6 +24,7 @@
         },
         Gsp,
         GspBootContext,
+        GspFmcBootParams,
         GspFwWprMeta, //
     },
 };
@@ -55,13 +56,13 @@ fn combined_addr(&self) -> u64 {
     fn lockdown_released_or_error(
         &self,
         gsp_falcon: &Falcon<'_, GspEngine>,
-        fmc_boot_params_addr: u64,
+        fmc_boot_params: &Coherent<GspFmcBootParams>,
     ) -> bool {
         // GSP-FMC normally clears the boot parameters address from the mailboxes early during
         // boot. If the address is still there, keep polling rather than treating it as an error.
         // Any other non-zero mailbox0 value is a GSP-FMC error code.
         if self.mbox0 != 0 {
-            return self.combined_addr() != fmc_boot_params_addr;
+            return self.combined_addr() != fmc_boot_params.dma_handle();
         }
 
         !gsp_falcon.riscv_branch_privilege_lockdown()
@@ -72,7 +73,7 @@ fn lockdown_released_or_error(
 fn wait_for_gsp_lockdown_release(
     dev: &device::Device<device::Bound>,
     gsp_falcon: &Falcon<'_, GspEngine>,
-    fmc_boot_params_addr: u64,
+    fmc_boot_params: &Coherent<GspFmcBootParams>,
 ) -> Result {
     dev_dbg!(dev, "Waiting for GSP lockdown release\n");
 
@@ -87,7 +88,7 @@ fn wait_for_gsp_lockdown_release(
         },
         |mbox| match mbox {
             None => false,
-            Some(mbox) => mbox.lockdown_released_or_error(gsp_falcon, fmc_boot_params_addr),
+            Some(mbox) => mbox.lockdown_released_or_error(gsp_falcon, fmc_boot_params),
         },
         Delta::from_millis(10),
         Delta::from_secs(30),
@@ -148,19 +149,13 @@ fn boot(
 
         let fsp = ctx.fsp.as_mut().ok_or(ENODEV)?;
 
-        let args = FmcBootArgs::new(
-            dev,
-            chipset,
-            wpr_meta.dma_handle(),
-            gsp.libos.dma_handle(),
-            false,
-        )?;
+        let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
 
         // Keep the result as we want to wait for lockdown release even in case of error, to make
         // sure `args` is not accessed by the GSP anymore.
         let res = fsp.boot_fmc(dev, fb_layout, &args);
 
-        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dma_handle())?;
+        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params())?;
 
         res.map(|()| Some(unload_bundle))
     }

-- 
2.54.0

