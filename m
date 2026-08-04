Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A96FC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD8E10E854;
	Tue,  4 Aug 2026 05:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UCQZujUm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A921910E59A
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 05:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTg3P3v2vTtGYoUOQqog8To6Wf2/v057caXfEbmLi7rU4aHQ9cWvOQ2ce8IvGijw2K1Y80bYQ2xFb4K+9onR0de4Ygg5Ek/J4k/LmY2dWZZw7G3z5DOO2BkUVUksZLFVWt5Z8bJVUSkz7bRS5EpigGjnnVQnbhiZIbfb9CKPv5JS8suG1r5mVkMOfouyThlYxmiU9qN/MIlOjKjzLDsKKjCDRsriiRR/YgclWCrQ0MVgBa1k3BtSIxMuObakCLdi+/w4d8WfPvHaIt7PDlGbPRjXkiT+6mzeVkMfCoNsZXLjG02nmajnpK58IhuOWMng5f8iKu+igYhAySQRBINhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZH0Ot8pq2taI9V2D2CtWXtVSQW7guweR34cqH4SxAg=;
 b=WvVG9JN3qEtCohQu3vaGbyGnZDc0Gak20kpEeMNlZ/KTx9uBVCy29Mfvh7w22WyC6s65NBeZ/6AQ126GcMiTrQwjMY1gdM7SllWJ/TB8dK/ra2tu7DYw0QlFT307+QgSsIV0F1tVh2vluZVUDq7IWxb86cixJBVJIE003PINVIOkobMzamkYy7dRvX8JS4TGDenR1H2bxjUnSjR3oYyIxgspiXr+ZQk3VpgIc9f9tCk19UcTuDZK7jRrYpsGYzhCDEaH0G/XXqz3Pxm3yZ7Q7HlWdsRSb32JX3g9ur2rbPfIFjZDA/up0huZwjy8jJQjd8nNcSUC27WqgWwhOmfHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZH0Ot8pq2taI9V2D2CtWXtVSQW7guweR34cqH4SxAg=;
 b=UCQZujUm+Ztr0GroQ3DeX9W3JgVVG1H+HCDpMULdHIRso0FTclP7H0T9ny0Qjx55OsV92p5NEukfzSzyX3bv3Wi9WyQGKohpLjrk6cQLOPFhQexvDsXfp/25knORBsD0zjmrt614G5bNYgsEfFQzirKR+H/sCksyvA0nl8kgF57oFJ0A3xZWSjYxZtFSlNmidpZvJRdFceV5m14lMP2CRisCagaZPZWUikRxUQQvuGqT4YvdmyV2sZfUpTxLx/tH8PWMRF/ZfYGCHJwOUaHYq0CQoWnYM/XWhdx/rZKHxPJA3vd2OPEpoS/r6iwXZfGv3gvI+G+OQxE2wRf07yfwog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 05:44:59 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 05:44:59 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 04 Aug 2026 14:41:16 +0900
Subject: [PATCH v4 5/5] gpu: nova-core: pass WPR metadata ownership to
 FmcBootArgs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-blackwell-fixes-v4-5-ac858b6a1935@nvidia.com>
References: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
In-Reply-To: <20260804-blackwell-fixes-v4-0-ac858b6a1935@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0339.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: cc68363e-7b4b-45c3-3725-08def1eb85bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|23010399003|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: fJ612lsSDSM2v58yx/3QPCnxmwbvqBBnT4DoKJzCc7jQfPVOz64aAixuQ4nzFLh5zW6/To+FQmrDQXKC9VQ5Y8an37YHKomJQd/shq9BOCMUH1870gzmKyXPBqzWhZxf5a9TMXBsgdQgmjQ8GM0wJwVjdMXKN22+MQ+dcn6OHGMIKFkd3Jkzwu4pVBa+Wj/r9Mx1Igtx7y2DX/vFEv0dHx8Uy64wkzwzAFlE847zVn+P8c11nh+jHj0yliCHVtYt6dmqpJQbGC/VpFAlMY9XrbUqxQXHPyp/2WRKPsRafF5CoyN06jwZmczKfuN6fsVQLDrDtDDjYogcIgdekvhgjYFcRnpoi2cOjCJ2nVTM1BDpXGc18Bwxl6PvaybA9fVNhb4cy55D5kA9f9ICjO8oA0r/mwAtZMGicj6G8oci14O5VT1DYK/LR+RDVbcc6JKMVfB9cP8IjhPRmmFsswiI0qHXOcZtUSJweug1iLuZ28jP3T2wPFBQNroT62NBPMkfsLeS6rZAAJ9szDyrtRlYZU1Rn4s9qXGsg9/a4IgEjWU3rhg5zL4polwJa8E5eCZoEH8YkAt5icjAPkI7Hf9VogTPWtUfruB/qv6CNeTBNjFllz5FlnKsOAzGnhi4QD0KWC+ThRRGvfwIZKlig+aIljcMAmnHsWc6b8jb90oL3eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K09qak5jVlIySHB6YUR3WFBocVVkVXlBbldjdGlyd09zbUd0TDNhcWVMSHk1?=
 =?utf-8?B?bWtIakhTa2QxRWlEYXN4Tzc4bVVFRElvalhNZFAvam9ZZittS1dzUHhjTkxh?=
 =?utf-8?B?NktrQ1VwNE8zTlFFeEdaUUEzYVROKzJkZ3hibVdTNzJpU1krS2FBMm45Qm0v?=
 =?utf-8?B?RGhKNDFCZkxFMW5WMG5mZ1JYV3Nud1QxL1VLN3N4NzYvVWxHSnFjZkxnRnNC?=
 =?utf-8?B?RHN4OGVLL25qMjZZdFJLWjl5T042LzZyVkhEMkxnMGUvL2ZRcTMreUZBcnFl?=
 =?utf-8?B?TDVRVmtFcktHQm9sQTV4QzcxZTlTa2FXdS8ydGhkQVp1MUw0dGg0TnM0ZHhC?=
 =?utf-8?B?d0U0VGJVS2VhdU44SjdRWjNoMUJQcnlIRy9CSXAyT0MyNmc5Q3N5NUVsZTVB?=
 =?utf-8?B?d3NCVjZDVVRXOE1qalEvTTl3WlhPMDdhalF6TnZidDh6RTZZWmJWZ1dBdG90?=
 =?utf-8?B?bVJGai9QS2c3MkZxS1BESWtaMlE5SmpOek5zVS9DdSs0c213M3Q1NW52STVu?=
 =?utf-8?B?S2Y1ZEgwUWluUWhzVDUxN2wxemZBenJocXJwekMwa2VVRkxmWEFHdnFXcTZ6?=
 =?utf-8?B?ejRvdm9VL3ZCblhvblJnT3lTS2tkQ1dtdGdrUDk0NEk5WWlHN1lxM2xJRnlL?=
 =?utf-8?B?Y0x3K3ByelB6Vm5seUxJOWQrdmVNeW9EZDVMOVhZeWtucUFEUHpDZFFzNTRO?=
 =?utf-8?B?SVNGdnBaa2xYR1I5Q0M2YlFPR0ZxNktyN01KQUlST0MvWXFOeEZHODBob1hV?=
 =?utf-8?B?dEsxeFRFdGY0eVBNYnQxUG9SWjh2M09VcUpueGNIVXloYitWQ2xiTTlQRUMx?=
 =?utf-8?B?OGdacWFCRkx2SWtoaXRmNElHb1JyWXg2b1loOUJHTHhJSThkMlkvaE9aZjNP?=
 =?utf-8?B?Rzhva3djdVV0NUR0NDk5cHdVbERkdFdxa0V0REJRZVFGblFVRVdjZkdzdkV5?=
 =?utf-8?B?aEJwaG9rTjBBMW9Fajd0ZHF6VDU5K1VyaHppSElGNTJVcU1kMmhvcVc2N2Yr?=
 =?utf-8?B?MEpuTWZ3NW1JcGptNjYxd1ZoT0hiZ0Rtdk1nL05Dek5JUVFPUDIveGdIWXFJ?=
 =?utf-8?B?Zm1pT2NSVW9Yem9udjY4NS9YYmFyUUZnTHBXY2ZoUVFGaUJLT1l4VUpqU2xG?=
 =?utf-8?B?NCtnQzVveWxmVEE0NG5yMGRRUURmVm5rTGhiR0FHMlFiY2ZzMUlFN0hZVm5U?=
 =?utf-8?B?all0dXBHNkNiTEl5cHQxZE9FWVJwejc5ZjFNTkVZOWFrR3liRjdQWDR2OWdD?=
 =?utf-8?B?eGNacEZIckFLYXlmV1c0cVY3Ykl3RjZKMEFzUysyWUtVNUZKSE9BT0gyYjNG?=
 =?utf-8?B?dnBkZVF3eHoyOGg0YzNlZGE1Qm5yL1BzbFZSdnE3SjlwRmxJK2x1TUVLdlRw?=
 =?utf-8?B?TzVXVXlseVRnQktsc0pTMllqelZrR2g2c00zdkU1Nzl2aWc0eHhia0twQ3Bh?=
 =?utf-8?B?b3FSUE1ZZHltQ0t5UFRhRUhadEFEMStHM2dHMmZ5ZmZXUUZVbnk5SUZ6NnEz?=
 =?utf-8?B?cC9CeTdQQmRIdDkwUHk5bzkzdEg2Y3UwUUg1TXcwUmRuQXYvRGwzbmlVa3Z3?=
 =?utf-8?B?OERKRGMxdk9hVjh1TGV2Vzl4WW9teHBaRk4zeExpRUxTSjEzY1RHVGZ1Rjdx?=
 =?utf-8?B?RUgxck5jbEk1L3U0M0NDQTRJWlBnOGhlNURwQnZEdzlDSGJYZXpLNWFvRnRw?=
 =?utf-8?B?cDZYbUlCa3VmZmpKcE9QQmxUZzBjRWdsZWZLVjNZeE9QNS9nVS9IS2NSekx6?=
 =?utf-8?B?VHdMVkZkODNuZEJOcm1oQWFyZ2VyUUY2RDF4dDVnc0Zzb2h6UkthaCt1dkg4?=
 =?utf-8?B?T0lvaEYyQjVZdVBTMDhqRStGYlRIeDkxSGVNUit3dVZDNDlRaURyUzBhM3Zi?=
 =?utf-8?B?S21ldC9OeUNWRHNZaHJMWGtyTElBbWN2SjBOYWNZK05IdXVmbXJKZm9NeDZx?=
 =?utf-8?B?U1NQK1c3UVhaQVhaYVJsT0g4ZnJyU0s1UnpQNS9yVWhwd29DVlNFVDFzQzZx?=
 =?utf-8?B?SmJ5K3JiV2FDVjNpeEF1TkY2Zklkc0h0NWJzcnhScHRzTFJFMUNkOVo5MXVY?=
 =?utf-8?B?TXRSQzR2SjN4TWFwV3RqdzRHVlRGbDVzWU5KRGc4RVo1MFZFZW91ajFldHc3?=
 =?utf-8?B?OTRYUWpiTHJUM1dFWXNBN0VBdGV3MzJrM252WWRnS2xIc3REMUpFbStnc2Fh?=
 =?utf-8?B?MUM0ZTgwVmdFNkFoZENobmRqcjdZazI4WkI0OGRacmw2OEwyUCs3MnVRTnJn?=
 =?utf-8?B?S1FwVVQ3L0RkMUE1cGRtRUIrcTg1eS9WcjFoWTlJZW9MN2JDdk5vWWtkVmcz?=
 =?utf-8?B?MXdFWmVpb24xdGlCYjAxY295Wmx0K1RYQUY5aDY5aEZqK3FLWXMzbERUcHRz?=
 =?utf-8?Q?eLQ2N2ATDR09r9JQ31PYJgvVnbi+XJe9ezsBOlbGWKPxB?=
X-MS-Exchange-AntiSpam-MessageData-1: HCjfike65BH27Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc68363e-7b4b-45c3-3725-08def1eb85bd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 05:44:59.8422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GmAQl3eQDv9bPf6idoZFZLvGstMI+56PsiQ4GCdrDFzF8BZZ7LwYNDL5eZH27L109vtszS3hcVDw6bsmUiGQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

`FmcBootArgs` logically owns this, so pass ownership to it instead of
storing a reference.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs           | 4 ++--
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 9add62736892..90212ecd6110 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -350,7 +350,7 @@ pub(crate) struct FmcBootArgs<'a> {
     fmc_boot_params: Coherent<GspFmcBootParams>,
     resume: bool,
     // Additional dependencies required to be kept alive for FMC boot.
-    _wpr_meta: &'a Coherent<GspFwWprMeta>,
+    _wpr_meta: Coherent<GspFwWprMeta>,
     _libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
 }
 
@@ -360,7 +360,7 @@ impl<'a> FmcBootArgs<'a> {
     pub(crate) fn new(
         dev: &device::Device<device::Bound>,
         chipset: Chipset,
-        wpr_meta: &'a Coherent<GspFwWprMeta>,
+        wpr_meta: Coherent<GspFwWprMeta>,
         libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
         resume: bool,
     ) -> Result<Self> {
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index be10d278f567..b16c2f6f82a0 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -156,15 +156,15 @@ fn boot(
 
         let wpr_meta =
             Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::from_sizes(gsp_fw, &fb_sizes))?;
-        let args = FmcBootArgs::new(dev, chipset, &wpr_meta, &gsp.libos, false)?;
+        let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
         // Wait for the GSP RISC-V core to halt in case of error. We create this guard after `args`
-        // to make sure that boot args are kept alive until halt, in case they are still being
-        // accessed.
+        // to make sure that the boot args and the WPR metadata they own are kept alive until halt,
+        // in case they are still being accessed.
         let mut unload_guard =
             ScopeGuard::new_with_data((unload_bundle, ctx), |(unload_bundle, ctx)| {
                 let _ = unload_bundle.0.run(ctx);

-- 
2.55.0

