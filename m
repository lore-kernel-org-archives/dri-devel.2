Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5CCF31E25
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5E510E801;
	Thu,  9 Apr 2026 14:20:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="h/3wWWoa";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A1410E801
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acMJkJCz22gJut95X0iVEaz1NLofN0ms67T2v+z1UQcWHlH/e/ZUSQk0WS9I3apbGdbsh0vlsZFa0m0i8qc2snu1+wI8SL0aI08HXoNUZgWvSZsgHdfT8WRehTKlfyXnSJjb7mHcDWYETzS/MDhLJSUTpoM1ttc2aOE5rYuyTNfgTg1gA4/u+FoQ1afLRyUL0W65WE6hO1r3kwknt2aRDnIytGlI3bx2zT0tCHNkGDadQnx6KUcTIWDUnEakjkNq2UxmkInRlZ1Mu4gpO1DGvJaSya174QbFddudd91vQnINniW4aaIYKxBhmHoICdOj7SI+++ggdgk2XQFVdSEY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHMj9mQte9gKqvV2Q5n4Q/8LqPMPIUf6V8aIta/nHKo=;
 b=tcBTISzgHlDA/kqpglLBDpfytwv5FoOLfuVA/d+PZ56nM2CxqOzP8MkvYMErRBXemh7jBf6HUrSVBj+VHwoiF5Om38b9qNHAgkBgMUEDl0NygTyAjyeXC/db/kUfStIIUW+3imF4Va57MjZZ/Ccvmtdkkgbxnk0tjVDy8O/cI8F5qsbmSZr+sSBKENn7I5JZ/M2XDha//d4XJD0L2yxuNRWXuolBNCji727OfXqfyci2Ccnnd8SqeIZTDEJmWmLzkl5IOvNK2fsP++irRDceVdOvPx128zS/dkV6vgzn6hPQwtHagHmCZnoV9n9sJH4e+1jhgibLazkgahU6GnGJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHMj9mQte9gKqvV2Q5n4Q/8LqPMPIUf6V8aIta/nHKo=;
 b=h/3wWWoa0l3ZM8fGd99iH4HGNelU/l0bqfRYgMEujFKM8qWq44m7tc/5sjspri5/tCn3BaDrEsiO7bu83tzJ0jDVVGV8hAnMYgh+j7Ih2z+ahPZztUBrAqUP66gIymdCazK76TCVYRPDg9H35UtUiuXhRGu1hlmV+NBmmiiOA/7gpSw6Tjk2nAfSw1y7EXk88b3zWsrT1SGeUfllLlOWzORh9LvZHc97hU70/8ulMd1/fhT6Pxt7goS73TYvOwe8m17nU5LWik7T9WefPCyXF1i/RAcUVJoH0A36CYk1jBVw2IR4fGWRo7vh7HaaD0bU9tvQAkdJEhF7Y/p2QartmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 14:20:05 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:20:05 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 09 Apr 2026 23:19:40 +0900
Subject: [PATCH 2/3] gpu: nova-core: add Architecture::uses_sec2() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-blackwell-unload-v1-2-0f5a2ff838dd@nvidia.com>
References: <20260409-b4-blackwell-unload-v1-0-0f5a2ff838dd@nvidia.com>
In-Reply-To: <20260409-b4-blackwell-unload-v1-0-0f5a2ff838dd@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TY4PR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:405:379::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b0f61f-7bbb-4641-bd4b-08de9643188f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: b93+zHrJwpDySIC6ECMEsNzfFVszAFgycivor9O1aSleP6tclp6FmYdn8Fi0IeBdoUzdYZiRge5ISmOdsKvUXKrcDVDNPnZteCaKfaursQ+oiTs5mr3YP+2XGji9YOWP1R1LtwygR7onIlezfWKY6EyCsIz4lWM4SoUU0+6jgpCY/7jmC4SMDAEZe7yRpVLL0jOn6XaPb2t5FAOib//ZbpbQ88JVzcBj++wTsd92nQIWlqT+l+qquRXtKquh4PoBGtSMjnQcd5HpPXuHnYgczzigG7nXacdWqhd7Dv9CS+fGjWG8OH0C7v0nCyjhyMYHJHAD8DTnnUVtuWlbobs16HzabFxA9zEdVnmCaUyRRrveU0mJbjxcMlBA61loejbkpXwpLPlqwqxcGLjD7n+Oe6Vy2MIhbodl1Nyav+QhnHn2KhNACRh80t5fBFMxLc4VR1g8DV4xMFZIsvhYvNgNiMUla0rMnwyfHzZ5BqDz06lR1YiokVq30Gw6NUCNf//BdPom7qfELsI+FGaTGwLuXfgSqXJ7jnV5OJ9uGDQYeG69830JIa4xEa9AlIzgAmJn3QfS8HcRj5OdvqOOrTKIS4u945bNorU7C9KPzc+FLiYIwQM/JpbiNKOXXB0Z3ZYpCrS8ZFAbVaTjHRkH91SMwlYXGZQ0JEfsMaBFtO+zURPc+QOAn3D6Lt2s2BeqSJVeq5g6PDKDSueiNXjbmMASH2rE4OzMvEB+YL3dxtsLLEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk16b3g1NEVlekp0YjllZU1yd2NPblhFUGtqcFJoRXhGTTBKU2pDUG9nQkVH?=
 =?utf-8?B?VnR2eEVJbjlod25PTFdnRUlWY29IZGJYaDNOY1YxQllCSlpkVWJQL2lVTDd0?=
 =?utf-8?B?SkZKMnY1QUV2UGl4d3lvMnV4ZGkyczhNeGtiMFA1aFJDcFdsUkp1eDk3MWxt?=
 =?utf-8?B?bzMwWkhMS0Y5OU9JUVpzc0MzY3pqM3dMWDZ4OW55dm1TemxYNy9kMDdFSnZV?=
 =?utf-8?B?Q0lPRFJxelNuNFBraFozNWZNRUk5bzR5OHlZRm5XdGdibm03cFltVVhSTlZP?=
 =?utf-8?B?NjR4enlyRUR5bDRwU2ZjK3RtTlZSZzQybFBNMGhvMlcrQitiQ0VOR0xNdWpN?=
 =?utf-8?B?QXpLeUpBZW9RRG1lZlNwOTdDUUphZnVTR0NQcEZ1ZFhSYnU2K0htTi85Vjds?=
 =?utf-8?B?U0JTK3hCT3YyYmFuNXh2RHVuWWVUQjVRL0dwZU1uQmk0Y20zMFBlanIzWjJ6?=
 =?utf-8?B?Nm43TFdpMEUza0FNd3ppamhCS0dkZmNwZ1YxKzlMcjAwOHdUNFZ5UFJLeDVG?=
 =?utf-8?B?MmJTcWpHTEpld0RNR1lrckNBRkhsOEJ1c29LbjFUZE5ScmtLQWhuNXArRXkv?=
 =?utf-8?B?VWRoeXpTQzV4YzZJZUYwNDF4Vk1Zei9EUGN0K3Nna3FrRnN1cjdiTnVadjIr?=
 =?utf-8?B?em5NTDBJZTV0Rnh2WFY0SHMxUEwzT0lDaDRzWEtudkZEU2VOdnEvU1FPQy80?=
 =?utf-8?B?d1Mxa3dVTVFyN3hQMUJNc3hKa0dRZjQzOFRlU3NzYlEzU1NNdUsxSUFkcmpi?=
 =?utf-8?B?dnNMU1EzOTM1WGZyb1BxeXJPM0h3bmlHSktZVmRXYU95SWRycG5TbkhXM1Z3?=
 =?utf-8?B?aTNFbGRXU3VGWnJKMDMrczk3eS9pYkpZZWdiNkxqY3VCOGFzaU5PYmNWS1Mw?=
 =?utf-8?B?NC9xaStNdXZWWTdsZXo2ZlRURUE0L3RjSzM4OE53V3dIb2ZHV2hHUTlLSWc5?=
 =?utf-8?B?emhNbDJNQmJsOVpyK3pHNzl5WHF0Zzk0WnJ6RHI2cjk0c1hEUGQrT3pOTW03?=
 =?utf-8?B?RStUd3BhRUkxc0RGY0FWVWlvWXRIUUJLTGpOclVjZ2xIZzBRUDhYMGxyNVZV?=
 =?utf-8?B?b0Foc1dYVjZ1eHRyLytCeW8vb1FKNmpmOHE2emcyUEt3SlNDbFVuZjM2bmFK?=
 =?utf-8?B?NVVvWDhIelk4OHFheFNya0tpd05Mc3lsVUZlSG41OUFFT1dsc3g3aGtLWnNp?=
 =?utf-8?B?ODFsbDNSZTJ0K3VPVGsydTRVNEpvWjRpS0RFOGtiUzNsaHp1RENzSHM0Y042?=
 =?utf-8?B?K3I4QmdwSmpGSGpIWWhHUVA2ZkJYcE5tYkM1TTUvYU1UNDdOR1EzL3hZMDNU?=
 =?utf-8?B?Z1ZnM1dyS0s0WjhIZGVZL2I3aVdmVzVRRG5DMVVxWkRIUDVuQURFS01JSGpt?=
 =?utf-8?B?V3lTTEM3Zk9FSHFhY2pVa1plK1RBdGxrYlllSU1iOTBhTytDb3YwRHFRQnll?=
 =?utf-8?B?MjdFUHFQeUpRL216bGthRkQ0QTV5ZXorb1RWL2NidENleHNiYitkK3Z2RldD?=
 =?utf-8?B?M01yQnRObnhsVVlkU1FNZWN2N3JGTEJzMWJOckxubDZBVWV0bGdiOGdxUEpl?=
 =?utf-8?B?UEpNdzVjOFZydUplNGtOcUdLRE5kellVM2RobUs3ZlFvQUFlRmFhUnh1eCt2?=
 =?utf-8?B?NFB4NlIrN2VZcnR3Q2loV0U5MldGNXJTUXNodWNONTM4bkZGQjVydzNZYVFB?=
 =?utf-8?B?OGxIS0licWVHWmdvLzE1SFJKZzVkdGIrbkplRnNWZFRiUmZMR0Y4NXBYSmYy?=
 =?utf-8?B?OVZ1K2RaRmludUpqaVlxdFowckd2alZFWWM3aEZFNTdKNTBJSEpaYldzeXJK?=
 =?utf-8?B?bDkycjJnemtodGRUcm9ZZnZKb3phSnBDanRneDBnZ0cwa3J4YUE2b3R4SUZt?=
 =?utf-8?B?NHVLTU1MVE1ONDNnV29oQ04wK01xWUpXbEVpS0lrQkdKVG1JTW9XSU41L08z?=
 =?utf-8?B?eUIrN3RjelJVQzM2YkRuWi9PSTQyNk9IRWE5cjd1UHlubk9pTDczRExRR1VL?=
 =?utf-8?B?ZVdQYTRaNGo2UXorZXRLclY0U1lpcmNXY3RqV2RoclNpRWZPNXpxc2RaUWFo?=
 =?utf-8?B?anI4WWtoNmI5dkRhaVpjOWJtQkVHZEVWRDRNVm0xa3BGOE9MNFk2d0NHbHBR?=
 =?utf-8?B?TTZ2TXc3T1BSS3pBcXRkdUQveXQ2R1ZEVFlLYnRTSitSUUMyUEh5aFhUWnlY?=
 =?utf-8?B?cDRoS3pOUzF4V292d1A2bzdUeDM3U2xUY0NhajNST2NoZXlJandzK0VJM01U?=
 =?utf-8?B?SzNrUGdZcFlQUWNyczAyV2ZJL1BsSVJTeVlKWDY2aHdSOVNHSlBHRGpsT2hJ?=
 =?utf-8?B?T0ZqcUVabk0rUkgvb2h4NGdXcWljY2R1QnorNnEwS05qSHQ4RGc5VDJVQWdG?=
 =?utf-8?Q?5Gji3wKOOyMLHTISszEk+BT2o2z3qJubT0UVU+7GPYEcC?=
X-MS-Exchange-AntiSpam-MessageData-1: ZlE7qHUut1z/IQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b0f61f-7bbb-4641-bd4b-08de9643188f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:20:05.3800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvpvmivhMVJS8eY3vzslomj7UJx4GES9kpRPgNPLBN24AR+nLwS1yWhMcXjyIr5wRadP1fMiG8uldOEyeyIRvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
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

This will be used in the following patch as common logic.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs      | 7 +++++++
 drivers/gpu/nova-core/gsp/boot.rs | 5 +----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 2bcaa7bc5125..674dc286162a 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -180,6 +180,13 @@ pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
 }
 
 impl Architecture {
+    /// Returns `true` if this architecture uses SEC2 to boot GSP.
+    ///
+    /// Turing/Ampere/Ada use FWSEC + SEC2 booter firmware. Hopper and later use FSP instead.
+    pub(crate) const fn uses_sec2(&self) -> bool {
+        matches!(self, Self::Turing | Self::Ampere | Self::Ada)
+    }
+
     /// Returns the DMA mask supported by this architecture.
     pub(crate) const fn dma_mask(&self) -> DmaMask {
         match self {
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e6d8b848ec46..1aac634c3b67 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -332,10 +332,7 @@ pub(crate) fn boot(
         sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
         let dev = pdev.as_ref();
-        let uses_sec2 = matches!(
-            chipset.arch(),
-            Architecture::Turing | Architecture::Ampere | Architecture::Ada
-        );
+        let uses_sec2 = chipset.arch().uses_sec2();
 
         let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset, FIRMWARE_VERSION), GFP_KERNEL)?;
 

-- 
2.53.0

