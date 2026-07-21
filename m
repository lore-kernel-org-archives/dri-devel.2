Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D5FC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B5D10E92A;
	Tue, 21 Jul 2026 11:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rV1gnc0A";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59FC10E916
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVt2yMmMFMNQUgaWEv0cj974zPpJGgu5RpFrXTCIcu7r/pB0FCwCZjENnnSp+2D+1ETiwch8Qmop5XLl9t9lK7p8QdiUK810KIkuRTQm6EzOj68ljfnFta2qlnh7Rzs1QRdmOpQn9FV0eKTMcNZ2TMPnt/P7FxUl7vJmQlx39s/lprFV/VLSoaZPRE8wPNro5hbhkwdz68Xp87gEQ5HsIuZOF+VbZxRV6qjLJaCt93y+sA6f5ZtDGxy6qJDVOSqHevIDHD2JS7cBmIbaEnQsIfmHcPVsUINFsANGjBF4eLhYj34NDPRenwPikQhWAxcgYYgIxBAO6qpISS8iDjl2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0uH93Hmn6DG86otbDsoaCULddw9unWdF6WEYZa6fUY=;
 b=NJpNb5NAy5NtkYNmlLNEVs0l1IXQ4qKQUghcHSIisNgoWMVrX/rCDUFaiC7wNMVAEvVNtkpaD276HDI/ggzhaZaKiF+F/CJSlxzb9Aq7mTe4croHXC8Vyaur3MoeVSLr9LsPG+yJ4zr7ecChXN/rXwpa8iKQTfkliYrwrBmX95NAOUSrfNvj6FTKpWFI1FhODMghySHRY4XkOYEZc+ptLc2bzvVuZmX4ShJv1bwjcB+H34ZtNeIEhP3RwLR/vwFcOAEBY0KDex3jZvPomY1kHULlOW5oUD+2WXxR3czt9HsmGP9eIJGiBUQmdx+q8lllEJSvU4Sv75vhZkaxg6YKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0uH93Hmn6DG86otbDsoaCULddw9unWdF6WEYZa6fUY=;
 b=rV1gnc0AOUYdKkHN6xBJn/27CKAp3ef+1ct3aHpWVSEX3gKRm7tCIIo2V1Z4rjTVnG3DbUNC6Zvj4PtQ2Jqad0JG3ymOXCDbdExS4ggf4xKWOcLCshl+wIxtho3F5PfMyM3eI3WWjV6UF9EaWGyrlTnxSKLSlH+VSmnLsPNy4a8ZyUJIQH92v3TSKGG3W01T42U9qtCU6Ozz/dtMh8r7golZlWPkdBuztNKc6oBlsgJs3RcBETQ6Cxq0dwoebiV2ebXXA4xzkUqRXHvEd+GRxmBPwA/rpt0viWT7NcLSEE0yYwJPfr7XjJhKXFqsiHeqCD+VII/hzbIFQjNSfZ4NXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:01:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:01:17 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Jul 2026 04:00:16 -0700
Subject: [PATCH 7/8] gpu: nova-core: convert relative registers to new syntax
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-registers_fix-v1-7-3711b2317e1f@nvidia.com>
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 3401be1f-432c-460c-99ef-08dee717638e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: k/WBjrljg5b/sD4zzNtut8yHDlVmfBtaPMUvlbXT/5BfWZguWNGwhEdkHn2f933s2dlE9CEq+l25QKtEXsLaavINMlzmTf5EfEpR/3WyB2OOQWJb2H6TUISGsiWM/1+R6eUZo/FOeW54Qo96CpmcQ50Gf3N3Uq49bdUBaEbzPsOLqS16mnUDIvJDUB2BafGGzNLuSPOSf2+vD8PY7MpmvXr/1djCKcnW0kcfsYU4pQ7vR1FCGxw9BIm4p9IignNK8ohQSwgUUxmY7ErI0qgvCIhbniEHFEw9a+pyHd4kdFRoMrWxnw7HQqBuW+8Iv22jOAFXWA50xMddo5gjQ/fMx/L75Sl2PHKbDIPGTUPt66754NIaHnBGO9UH0AHwOiIDJ63bcgp3PVhFNHbjuVqHOjFmeEVOLWtqPxJuZNpElTuaz6xL0NeLeh3H2VjvXt08nKKA3pVKo5AUEOB5SNMtcBZSQ2rMuoSXm0xBk/DAliP8zll0JRh/c7hqsI3E8Nk0bh8M9a57yMaGvRRpzzKW+9nhsyWEFH0xw3RDrpTwNihpkPWDGvPq8tjGkGO4JfZaGHLUVoz5hLDBztcq7b6ceQHsXGLNPGbeuJ3U/SrFYEu15Fv3j1VOtNZ6L2At9fcDjxVbp+OSW/vAecgere9bFCNAm4g292msjBBFKUmrrX2wZ9mJ5KxsvC4IuS0lqoZor6UsRy34lICiO7XK9ziTBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdZY0k0RFlUc0NSMXBiRHg0MnpaaVIzUmRUdlNrbGxtWjlnSUlsOXFDdFFU?=
 =?utf-8?B?Y3pOWXFGdDg3Z09mbFRldVhUVDRGVkY3ckxGcnRPVEF1cm5NZUhNekxIa3E1?=
 =?utf-8?B?dU5rQUlyRmVXeWdaOUlrM3N6U09UczJNREY4K21xZnpLNUxDejQzMitJZVFN?=
 =?utf-8?B?ZXQxa0x4QjJKVjV0QUlVUFFWK3J6aU9QQmsvKzQ4N1ZiZ0hjQXQ5UUNtNzNH?=
 =?utf-8?B?dG4xa2ZMSkpMdHFTVGE0R01sVnJXQm5Ham1RbjBwOEpyQmtrNjU5ckZ3dGhp?=
 =?utf-8?B?eEtudC9MQmFISTExMTByRzB6TnJEZDk4K1cxL1lvdjBmRTFiVVM2VzVISjBs?=
 =?utf-8?B?dzMwbVNFRWtWSllzNkR1ZTZVcVdiekczeFlRNDBFMTYrMWtPV0ZoV1ltOURn?=
 =?utf-8?B?RldIMlVGY0h0YUxmTXlBWDZTZkRITHltUWJJaW82QUE4b2RmVG02dmo2alRx?=
 =?utf-8?B?VkpQdm9CdDJnWWNFM3AzTGo4SXMwOWVySHVyUVRMMGJISHRqNFE3MlhhdHhI?=
 =?utf-8?B?ZnRraXZhTjI2ZHlMQUMrOEVQUG0vdk9SNk1GekJwS1VzOHltS0RCWllVbm5N?=
 =?utf-8?B?aFJoK0w0SzV6d3pqekNpWThUYUN5Yys2M3habm1qSXVYWUNjVWJDd3pPcGVt?=
 =?utf-8?B?dG5aTThQRE93cFVEZm5GbVQwV2RzaGVhMWFmdzJnN3lxUWJqRXRDYWJENkZF?=
 =?utf-8?B?YmR2NnpLZlNxMDlyeER0T2JMTWZ1a3RxaUNzTXY1a1VVVVZOTnhXd3VnSmlV?=
 =?utf-8?B?c0pBZXNoYysybVA3T0huWVRveHB4Y3RvT0ZXOVc0R0VvYUc5ZXVybi9FOWsx?=
 =?utf-8?B?dzZZNWkxbU1pQUtGRFA2TGZtc1dkbnRPQzNRdExDd1o0OHo0THBBWU1ScjBR?=
 =?utf-8?B?RlB1NEZYeUhRR1lBdHg2aTFVRDBJNkRNUkJ3cmtiNlBpdG5yZ0pWMi9MWU1H?=
 =?utf-8?B?UUtlQUNaYlhyQXNRSEI4MmFkVWFoWU1STTd5WTVmYjF5Vk5aUmlBR3E3b0tV?=
 =?utf-8?B?MjlBR3pLWk9mT3oyRExtZHluVXdYWitmUzVCbWJIdm5UUjNKRm54SlQrZUV1?=
 =?utf-8?B?WE5GNGUyUnBKSEhqNStCeHVqdlE1U2VVeTNmS3JkZXh1WkVjMFpDUFNSL2ly?=
 =?utf-8?B?S1Q5aVpNQlphc0JtZlg1eUdYTlc0TXBKWitzOFRHbU94Z1BNWHAxcUdoUXFK?=
 =?utf-8?B?bWhuMjJLQ3pXcDJNK3Y0MFZ1SnFYdzJ0eEtJUC9CNXlDSktGOUZCVmFhQm1k?=
 =?utf-8?B?dTc5dWUxbEpTbUxtS0tWZ0tUNHErQjRTdmxONmtDMVNqSWhHS3FJd0VWM1JN?=
 =?utf-8?B?eGFWdkFrVEc4cUk4dnlpK1JQMmlDZmY5UmpjNWFuUkxoNVdwcTl1a1Q0a3pY?=
 =?utf-8?B?cWtybVdYLzJ4TkhnSy84cXRwYVZ5TFZkVE1yUCtyZWlXMlJTRHhSeEp1U3Vh?=
 =?utf-8?B?OFU3RUhveGZYR1dVTWs4V3NNK041emladnhCd0RhNi9zcWRlUDVGeU5yVVZD?=
 =?utf-8?B?LzA0bHFxSUZ2T2N4Y2VveFlMQUZSZHk1d0djakNtSXhIR3dnNW9aRytOTkxk?=
 =?utf-8?B?U2RWV0Q4cWwrc0hlQ2EvLzdHeU4rRHlNd2FYT0Z0UmUxNXVuUHhxVGxFSFJp?=
 =?utf-8?B?L1FXUHhEbUMwZy9xMTE3RTk2dkFuS2d5Wm91SUZKRmtaUjFTcmY1R3FacU43?=
 =?utf-8?B?YUtoSGY1L0ZVMnkxSWR4ZGI1UjVlNjZDQmMzdEtJY2pOMlFZRG1FMk83aXhh?=
 =?utf-8?B?Y1RmSFh0czU4RkI1Q29QSmRyRmVVNGZ3aG5ubEsxVXd1KzZISHRnV1oxdkVh?=
 =?utf-8?B?cUQ2WVV5UzBpcXA4L2tYbXhVRTRtZHI3OGlxRFRlaUZFRVhhSm9RY0FzUndN?=
 =?utf-8?B?YnZla0Y3bHhwd1pkY0tvbGFScDF6NnRWSGN1WFpwRUd3ZFo0b2RTbXJtZ1NN?=
 =?utf-8?B?ZjVTWUhBSlN6eExPRXgweFdmU1NvVG1HZlMzUDltM1c3dVd1MTdWTDVPSU9J?=
 =?utf-8?B?cmc1eG96MnordUpsQXJ5cjhnWUx1Rk9Ebm1OeVhsckF0VWc5RVpNRS8rdmcr?=
 =?utf-8?B?bHoyZ3F5alplVEpqYyswQU1ta3htd0NJZzdacjhqeEk5bUhGMHVqOVRITnZS?=
 =?utf-8?B?OHVqajJhQ0g4WEUzU2lrU1RGVTNWeEtjbDVoRG5aMG5Uc29oWVQxNFRRTUZi?=
 =?utf-8?B?SzJzTU92dEhZUit0bFNsNjJpeGZxekxabzB6YnJsdGVTcFJnU1pqZkNkOWlh?=
 =?utf-8?B?cVBBeXJINEFqTWROaS9JdnZLRnRKSm93bUtKUlJPNHRsUkR1VTBBNk5hR3Ry?=
 =?utf-8?B?cDZaUmF3S2FpMWl3NzA2bVBwTXFuRnNmc2hUelU5YzFPTXNLMXJUdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3401be1f-432c-460c-99ef-08dee717638e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:01:17.5745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BA3wQNvqOHGfqYgfHiYxApK8omAeSDp0GleS6Ds2dWTg5VtJF4KidYSM0shVQarPGAGwQD8LomMQKuGjVoF2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

Convert all relative registers declarations to use the new `Base:`
syntax.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/regs.rs | 74 +++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 397124f245ee..744c6087220e 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -158,19 +158,19 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
     // through a primary and an EG (egress) pair that must both be programmed to the same
     // address. Hardware ignores bits 7:0 of each LO register. The boot path uses a fixed
     // HSHUB0 base, so the multiple runtime-discovered HSHUB bases are not needed here.
-    pub(crate) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base + 0x00000e50 {
+    pub(crate) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base: 0x00000e50 {
         31:0    adr => u32;
     }
 
-    pub(crate) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base + 0x00000e54 {
+    pub(crate) NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base: 0x00000e54 {
         19:0    adr;
     }
 
-    pub(crate) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base + 0x000006c0 {
+    pub(crate) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_LO(u32) @ Hshub0Base: 0x000006c0 {
         31:0    adr => u32;
     }
 
-    pub(crate) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base + 0x000006c4 {
+    pub(crate) NV_PFB_HSHUB_EG_PCIE_FLUSH_SYSMEM_ADDR_HI(u32) @ Hshub0Base: 0x000006c4 {
         19:0    adr;
     }
 }
@@ -323,30 +323,30 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 // PFALCON
 
 register! {
-    pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
+    pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase: 0x00000004 {
         6:6     swgen0 => bool;
         4:4     halt => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_MAILBOX0(u32) @ PFalconBase + 0x00000040 {
+    pub(crate) NV_PFALCON_FALCON_MAILBOX0(u32) @ PFalconBase: 0x00000040 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ PFalconBase + 0x00000044 {
+    pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ PFalconBase: 0x00000044 {
         31:0    value => u32;
     }
 
     /// Used to store version information about the firmware running
     /// on the Falcon processor.
-    pub(crate) NV_PFALCON_FALCON_OS(u32) @ PFalconBase + 0x00000080 {
+    pub(crate) NV_PFALCON_FALCON_OS(u32) @ PFalconBase: 0x00000080 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_RM(u32) @ PFalconBase + 0x00000084 {
+    pub(crate) NV_PFALCON_FALCON_RM(u32) @ PFalconBase: 0x00000084 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_HWCFG2(u32) @ PFalconBase + 0x000000f4 {
+    pub(crate) NV_PFALCON_FALCON_HWCFG2(u32) @ PFalconBase: 0x000000f4 {
         /// Signal indicating that reset is completed (GA102+).
         31:31   reset_ready => bool;
         /// RISC-V branch privilege lockdown bit.
@@ -356,17 +356,17 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         10:10   riscv => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_CPUCTL(u32) @ PFalconBase + 0x00000100 {
+    pub(crate) NV_PFALCON_FALCON_CPUCTL(u32) @ PFalconBase: 0x00000100 {
         6:6     alias_en => bool;
         4:4     halted => bool;
         1:1     startcpu => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_BOOTVEC(u32) @ PFalconBase + 0x00000104 {
+    pub(crate) NV_PFALCON_FALCON_BOOTVEC(u32) @ PFalconBase: 0x00000104 {
         31:0    value => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMACTL(u32) @ PFalconBase + 0x0000010c {
+    pub(crate) NV_PFALCON_FALCON_DMACTL(u32) @ PFalconBase: 0x0000010c {
         7:7     secure_stat => bool;
         6:3     dmaq_num;
         2:2     imem_scrubbing => bool;
@@ -374,15 +374,15 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         0:0     require_ctx => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFBASE(u32) @ PFalconBase + 0x00000110 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE(u32) @ PFalconBase: 0x00000110 {
         31:0    base => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFMOFFS(u32) @ PFalconBase + 0x00000114 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFMOFFS(u32) @ PFalconBase: 0x00000114 {
         23:0    offs;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFCMD(u32) @ PFalconBase + 0x00000118 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFCMD(u32) @ PFalconBase: 0x00000118 {
         16:16   set_dmtag;
         14:12   ctxdma;
         10:8    size ?=> DmaTrfCmdSize;
@@ -393,15 +393,15 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         0:0     full => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFFBOFFS(u32) @ PFalconBase + 0x0000011c {
+    pub(crate) NV_PFALCON_FALCON_DMATRFFBOFFS(u32) @ PFalconBase: 0x0000011c {
         31:0    offs => u32;
     }
 
-    pub(crate) NV_PFALCON_FALCON_DMATRFBASE1(u32) @ PFalconBase + 0x00000128 {
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE1(u32) @ PFalconBase: 0x00000128 {
         8:0     base;
     }
 
-    pub(crate) NV_PFALCON_FALCON_HWCFG1(u32) @ PFalconBase + 0x0000012c {
+    pub(crate) NV_PFALCON_FALCON_HWCFG1(u32) @ PFalconBase: 0x0000012c {
         /// Core revision subversion.
         7:6     core_rev_subversion => FalconCoreRevSubversion;
         /// Security model.
@@ -410,12 +410,12 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         3:0     core_rev ?=> FalconCoreRev;
     }
 
-    pub(crate) NV_PFALCON_FALCON_CPUCTL_ALIAS(u32) @ PFalconBase + 0x00000130 {
+    pub(crate) NV_PFALCON_FALCON_CPUCTL_ALIAS(u32) @ PFalconBase: 0x00000130 {
         1:1     startcpu => bool;
     }
 
     /// IMEM access control register. Up to 4 ports are available for IMEM access.
-    pub(crate) NV_PFALCON_FALCON_IMEMC(u32)[4, stride = 16] @ PFalconBase + 0x00000180 {
+    pub(crate) NV_PFALCON_FALCON_IMEMC(u32)[4, stride = 16] @ PFalconBase: 0x00000180 {
         /// Access secure IMEM.
         28:28     secure => bool;
         /// Auto-increment on write.
@@ -426,17 +426,17 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
     /// IMEM data register. Reading/writing this register accesses IMEM at the address
     /// specified by the corresponding IMEMC register.
-    pub(crate) NV_PFALCON_FALCON_IMEMD(u32)[4, stride = 16] @ PFalconBase + 0x00000184 {
+    pub(crate) NV_PFALCON_FALCON_IMEMD(u32)[4, stride = 16] @ PFalconBase: 0x00000184 {
         31:0      data;
     }
 
     /// IMEM tag register. Used to set the tag for the current IMEM block.
-    pub(crate) NV_PFALCON_FALCON_IMEMT(u32)[4, stride = 16] @ PFalconBase + 0x00000188 {
+    pub(crate) NV_PFALCON_FALCON_IMEMT(u32)[4, stride = 16] @ PFalconBase: 0x00000188 {
         15:0      tag;
     }
 
     /// DMEM access control register. Up to 8 ports are available for DMEM access.
-    pub(crate) NV_PFALCON_FALCON_DMEMC(u32)[8, stride = 8] @ PFalconBase + 0x000001c0 {
+    pub(crate) NV_PFALCON_FALCON_DMEMC(u32)[8, stride = 8] @ PFalconBase: 0x000001c0 {
         /// Auto-increment on write.
         24:24     aincw => bool;
         /// DMEM block and word offset.
@@ -445,29 +445,29 @@ pub(crate) fn usable_fb_size(self) -> u64 {
 
     /// DMEM data register. Reading/writing this register accesses DMEM at the address
     /// specified by the corresponding DMEMC register.
-    pub(crate) NV_PFALCON_FALCON_DMEMD(u32)[8, stride = 8] @ PFalconBase + 0x000001c4 {
+    pub(crate) NV_PFALCON_FALCON_DMEMD(u32)[8, stride = 8] @ PFalconBase: 0x000001c4 {
         31:0      data;
     }
 
     /// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the
     /// falcon instance.
-    pub(crate) NV_PFALCON_FALCON_ENGINE(u32) @ PFalconBase + 0x000003c0 {
+    pub(crate) NV_PFALCON_FALCON_ENGINE(u32) @ PFalconBase: 0x000003c0 {
         0:0     reset => bool;
     }
 
-    pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ PFalconBase + 0x00000600 {
+    pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ PFalconBase: 0x00000600 {
         2:2     mem_type => FalconFbifMemType;
         1:0     target ?=> FalconFbifTarget;
     }
 
-    pub(crate) NV_PFALCON_FBIF_CTL(u32) @ PFalconBase + 0x00000624 {
+    pub(crate) NV_PFALCON_FBIF_CTL(u32) @ PFalconBase: 0x00000624 {
         7:7     allow_phys_no_ctx => bool;
     }
 
     // Falcon EMEM PIO registers (used by FSP on Hopper/Blackwell).
     // These provide the falcon external memory communication interface.
 
-    pub(crate) NV_PFALCON_FALCON_EMEMC(u32) @ PFalconBase + 0x00000ac0 {
+    pub(crate) NV_PFALCON_FALCON_EMEMC(u32) @ PFalconBase: 0x00000ac0 {
         /// EMEM byte offset (4-byte aligned) within the block.
         7:2     offs;
         /// EMEM block to access.
@@ -478,7 +478,7 @@ pub(crate) fn usable_fb_size(self) -> u64 {
         25:25   aincr => bool;
     }
 
-    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ PFalconBase + 0x00000ac4 {
+    pub(crate) NV_PFALCON_FALCON_EMEMD(u32) @ PFalconBase: 0x00000ac4 {
         31:0    data => u32;
     }
 }
@@ -524,21 +524,21 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 /* PFALCON2 */
 
 register! {
-    pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
+    pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base: 0x00000180 {
         7:0     algo ?=> FalconModSelAlgo;
     }
 
-    pub(crate) NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID(u32) @ PFalcon2Base + 0x00000198 {
+    pub(crate) NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID(u32) @ PFalcon2Base: 0x00000198 {
         7:0    ucode_id => u8;
     }
 
-    pub(crate) NV_PFALCON2_FALCON_BROM_ENGIDMASK(u32) @ PFalcon2Base + 0x0000019c {
+    pub(crate) NV_PFALCON2_FALCON_BROM_ENGIDMASK(u32) @ PFalcon2Base: 0x0000019c {
         31:0    value => u32;
     }
 
     /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
     /// first element. Be conservative until we know the actual size or need to use more registers.
-    pub(crate) NV_PFALCON2_FALCON_BROM_PARAADDR(u32)[1] @ PFalcon2Base + 0x00000210 {
+    pub(crate) NV_PFALCON2_FALCON_BROM_PARAADDR(u32)[1] @ PFalcon2Base: 0x00000210 {
         31:0    value => u32;
     }
 }
@@ -548,19 +548,19 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
 register! {
     /// RISC-V status register for debug (Turing and GA100 only).
     /// Reflects current RISC-V core status.
-    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
+    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base: 0x00000240 {
         /// RISC-V core active/inactive status.
         0:0     active_stat => bool;
     }
 
     /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ PFalcon2Base + 0x00000388 {
+    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ PFalcon2Base: 0x00000388 {
         7:7     active_stat => bool;
         0:0     halted => bool;
     }
 
     /// GA102 and later.
-    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ PFalcon2Base + 0x00000668 {
+    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ PFalcon2Base: 0x00000668 {
         8:8     br_fetch => bool;
         4:4     core_select => PeregrineCoreSelect;
         0:0     valid => bool;

-- 
2.55.0

