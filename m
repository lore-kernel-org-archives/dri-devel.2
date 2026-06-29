Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35598C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DE510E907;
	Mon, 29 Jun 2026 14:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0rulwvI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A750810E913
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjxfndlARBZK/m/CoOpOMJE8aKe6dfsfiHNBwXLMjUMg9MmxZjMmHJgMy5FUKoZEpGUkhMsrF7fsG5V+8UMFX+hmR6zD0nOW5McCQ9w7PMgBIfd3PrlmCrqDUB5A5qTaNfDKI08Ns3/tB/1vsvqPSh4W3+c/Dkwa5rXbq4elL0ZBtj3RYHWU7mWUxs+Ec2WzG2QSHEFrb8k78BxG5hvK1srqvDfF+P3iiDfgFpRciJUha1SO4KZw7GJf2NNbomf1qDLlOc2wXMds/XtnOD7PGb42JGFI5104+jo/Zu/zanCo9juyyKsB+4EAJA14IcCLBKH8K7qBhaCYHVhgkkcVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vC6MwujPg8RH1XzDpjllEuZk8+x5NRex1TmShXhikrE=;
 b=M7DzHgccDjkBerwSNpqDtOsNdJHauaoRncjC3Uz59BaX8rlpHrTyzxd/DXIJ36BZ5JnfgkwMGsgXf+wI0Gv7s1hC1OdCFDBBxHiIHYACkP+1cg18SoodhlOzTQ3NJN/aDBm05OGD1NPiOKOGCxbsw77e3C+KaCR4Zx2TClEZz+vqgSfXhLm1nyHwHfd3kXg/oO6n7koEliBxsttQr8qM73ve6rZRqFxS6V11z8lNWfMykeWBB/sA0ghyUjFl6dSTZ5NOXeu/4ZksyVhPoQV91AA/6fFlqawTYthQ9XKauq2P3VW12E2reZEez7Fc2YeyYoyTXjFPJY1Rt2tDYCWpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC6MwujPg8RH1XzDpjllEuZk8+x5NRex1TmShXhikrE=;
 b=E0rulwvIKc4RYmpYEcwyVBuvZs8LXJn6Xm2tDenTSNPZnSHh9ntu4j5Zx56e20WhGHaJI0RgBzC0gJaD1JLUbQAjlaLUwuDNlNOMCwKiEekc6cmint4BW8Pp/A2pMObzmDkiugR87pdvkLbGbP0oYNhBrjja3tBjkmWufexGrrjy0y1uQ7gJEWfQ8vzzTCLI6/El7KOb/yErZOiLUJBVpVTd1xYR9pFyHtfzA5cso8XmLCilyPBtnIbwYdDLOWH53T0ZLWBwO9bmFhad87G1UV/Wvk4YYoCN6or06DsJ0WT4tr16/IZPBztbfCYA6yxrASUniKROpTYO4Jxn3MJAnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:22 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:41 +0900
Subject: [PATCH v4 09/13] gpu: nova-core: introduce GspBootMethod
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-9-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS0PR01CA0072.jpnprd01.prod.outlook.com
 (2603:1096:604:99::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 74dbd19c-02b3-4295-375f-08ded5e8288b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|3023799007|6133799003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: ijN1YHyp/zj2wRB3v2ju6EwqO9nOmzFf/KtvtxtBn1Ux6+cLfmn3DSrFHduOBz60DXVrJqfD+zb4EThHdQbvcmWCvIwKzaHQwIJ7dzcl4muj5rz8GoIOk8VsPap1F6DixcDomDhKGaBfU0LO78DgqZ4JFSqLCFWH2eVgytNp2mqiJeEceaD1gJAtRO8nFziIcK69cGZxfSmUxynZxNivOGBkBd6rOpVH/o5CURg/E4BX5wEYtxinLe2dpSmu16Yz/NL8WGYGCwjneL//D/JZoLW9EyoXFrLojS4xNpM48arIuupfb//dWpmAG53HZc8zihZRgEvKcG8A8KX80VXCQ9BCChKeSbpqhEGJ0V84WZc1LiiM6nYhFB5dayrr5KJz7IsD8LRX9m+ay/EdF5oKy6bMMVOLPCJ28zv1i52mFhpwtYvH/W0ATqwO1jW7Vuz7Bw/XthnFGbyRJGz6bG8y/3nwY8EhSdL3Ueah9+YFUCFjmU7zgmOQ8nLNZIuZbKZfZxJrLpHnF0CEEIigDw8ctM8u0FRkQxu5IsxMuLjUuxBFCo4ipjTtCvQhoXUgKaHWlfRC9IOSASMB+o0FBYtP8zsAq9VyDcUUdJTYJi5/1w2ODMsTrlWgz+YpOMbVmZZxX+/dbRl6kIfsqSpeM0wYYhmCtoD2v9Q1rCdNB2OUW5oBXVk81OtO/c6ZqioYpDaFlJZ+KHso3qJZ/WEvRO/FRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(3023799007)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNVZmlWQmJ4dmplTkJDaFFLRmNyNTYxRnY0VFpYVXpZQSt4R25qQzJjR005?=
 =?utf-8?B?Z0hZRlJMYWRQT28vZjNzblFFMFZtL2ZoemdKM1RWRnp6c0NWelZWL0ZCZ3hT?=
 =?utf-8?B?ZGhSVHpXVlJIa3lMTUdiQjhZamxuNzcwNVhLdDR2NkVmTjlEMkI0ekxEdS9Z?=
 =?utf-8?B?R2xsUmZEdDNkUDRBQ0tVblRDYmIzVTVsclhBR3U5SlRwOGNMNS9OTExycy8v?=
 =?utf-8?B?QVU4akJybnN0bjdyNFNCVTNkWDRQTWN3SU9JWWVqcXlKLzJpdlZkRnkrdHFC?=
 =?utf-8?B?cEczR0xIZWlVeDVmQjQ2N0tiby92QTN5TFg4eWkrMld0amwvTkVvcDhSOFds?=
 =?utf-8?B?NTdUWkg1OE1zUHQwRzV2VEVpQkN0OE5MVS9qM0o2ZkxreE8yZ0FqQmMyZ29x?=
 =?utf-8?B?MWNMV2dNZVBkR21nanpvc0V6NHFraktqdkV3cm11ZkFFQkx3a0k1eFM0REZa?=
 =?utf-8?B?VUhBWGdQRk9hbWRVYUE4ZTI4RUtFRmZ1alQ5ZDNSUExSVkYvRGpLY2l5Nktw?=
 =?utf-8?B?VlFyN0tzbmE3b3MwVXdFeW9FSEV1N0hWWTZ5bkR0YjYzUmNLZ3I1YkpBMm1J?=
 =?utf-8?B?djBlYmhLaEdFMXBDT0E2ZlcwNVRyNUNQdmNQSlY4aktGRGRPVHVLV1R6Z2h0?=
 =?utf-8?B?NlBaWDEwdUt6eWo5SVo3YWRLQlFPWEJqWnVwV0JIYU1MUWZHUDYyY0N5QXpZ?=
 =?utf-8?B?NzRkRS9oaFJ1MVo0Ulo1MlYxMUVZN1BQeS8yUXJzZzM4cHFhOXRtbmgzb3Zj?=
 =?utf-8?B?QWxuaXVYSUIySXFsMldna004Q3ZqdVgxODkvNEU3eENRbVFvM1NGNG5tM3VG?=
 =?utf-8?B?SEFpcGkrUE5ueGFXbTZiaXJEdHpqSElOUVVhZ2NOMFFpV1JjaXJ2UGpHdXox?=
 =?utf-8?B?R3ZsMCtsUjNnaWtsaDRGcXRiRCt5SHNuWEtURVhkS2JzV1RTNzZXc3owWXhI?=
 =?utf-8?B?SDUvaVpzNlZPdk1KUTg2R0NHTmZNc0UyU3doNkJvY3V6MDYvQ011VjRNa0Nt?=
 =?utf-8?B?bTlqcVE2SXF1QnFmZU1GbGUvRktCYXFabjBaZmg4aW9ZSDVYbVA2WFJZYlB2?=
 =?utf-8?B?c0FrNGhNTitINmw0K3hYcTY5RHdKdUVVUkZQMkFNM0ljVytjeUhBYVRwYnhv?=
 =?utf-8?B?ZENuRDY0U0x1Z3NxNC81cFBMWnJhcmRCQ3N0T2tyWko0LzJsV29rb0VUYURj?=
 =?utf-8?B?T1lhZEFWdmY2K3pEZUVtaldFeEhXWWUvVmxGaEN0RUF6cWR0cTZmQVk2Y1Zr?=
 =?utf-8?B?VXMrRUpmd1JYaTcrQXpVVVkrUDcrQk5FRElITlZVM2tDRUxJOXZ1QlBuOTdF?=
 =?utf-8?B?cE9EdGd0bmxoUk1SbmIzdWVMQUsza3FLZUJvUEdZVFhVcGFUMnJMbFJtVC9u?=
 =?utf-8?B?RjZFYmtJYXBQOWw1MDAxYVpNQUVPNlNVNkVSRlhpeTdIYzNReUJFUU81SVNG?=
 =?utf-8?B?YkYvckp5K2Z2SUpjS1RjV0hlK01pdXhxZGhMa3lkd3dnN0JxUEgwQTN2OXpF?=
 =?utf-8?B?TTFDbEk4YjlzRS95SEtCMmxTSTJWSTZpYWhTekIrZTAyVTNZU1FWb3VPeXlR?=
 =?utf-8?B?QlBOZnVrdWJzdkNPaXVBa0xWbUpLU2NuV2xkZEU3d0lBUldXU3FGWVdva216?=
 =?utf-8?B?RndETWJoV0hjZTFHL1d5RzAwL0VsdzdXZ0tkN2NZQXU5ZmJldlRUNDc0Syt2?=
 =?utf-8?B?T2VRYng1NC9TTDFYYml1YkkvV1pYSEM5YVlFcWhhSGlmMEgzKzhOR2FjdmJJ?=
 =?utf-8?B?eXdwT09GMlAyeWtlN3lmWEJJSVdEV3g5S0R6QzA2OFZTaDNaekNaUk1wQ2ZY?=
 =?utf-8?B?VitkWk5zRFZDbzdJcmdSMHdLVldoYk82dXpyQjJlNFJTTEhuRnA2dC9GMzBm?=
 =?utf-8?B?TTVjb21aVmFVWlE0UmZlS2lGRUdEems1b25GeWNQdVgzZFVIRVFROEtGYnZr?=
 =?utf-8?B?OFRzYWVrcUxjT1Riem5SVGdDUE1IT0MvUUZ0ejlvQ1UzSVFxbUMyUkNUakhZ?=
 =?utf-8?B?V1g2MU5UbjBJdzJ0QlZVQjJYWVZSalpKR0tEYktuMjl0dXg3c3dCNWMvR0tx?=
 =?utf-8?B?bW1pYjhRSVYxNnhsUWJuODgvdlphdWo1V0hnNzNYUU1sVEVaK1hrZStWUjZS?=
 =?utf-8?B?bW9qbEp3UEFZUXA5YTE5c3l1TnJScnFUUzl4aDNqSUF4MmpFa3g4OFg4b2M4?=
 =?utf-8?B?UDd2RWpNcngraDZIc3FGM010VUMyWDBEVGxPa3l6MEhoY3N3WFpMYXo2QVl1?=
 =?utf-8?B?d0UyUllUaHg5SUV6WHlLWEFrK3dwS3JvMW00RVFyRi93blhoQzRlQS92U2tL?=
 =?utf-8?B?cTY4TTlPQnEyckk2MmhqNXV6dFNBTlNQNm96b2tuVWZLcXdOQStDeHdtWCtl?=
 =?utf-8?Q?X4SdtNx3Dsm5aPn79ItIX22/MVccjya//FYqPIyll79l0?=
X-MS-Exchange-AntiSpam-MessageData-1: EoXKXlSfIKcfWg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dbd19c-02b3-4295-375f-08ded5e8288b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:22.4125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4Se9xeClMa2kou1f2h6lXsyUTPd2JigtDYxVOfBBblbk303XBly/LxHIAN0oZyDDYMrutiimYnkrYEjI+auhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

The GSP boot method is currently determined by two ad-hoc methods of
`Chipset`: `uses_fsp` (a boolean telling whether to use the FSP boot
path or the Sec2 Booter one) and `needs_fwsec_bootloader` (another
boolean valid only for the Sec2 Booter method that tells whether the
FWSEC bootloader must be used).

This is neither extensible nor sound: the combination `uses_fsp &&
needs_fwsec_bootloader` is invalid, but can still be expressed.

Thus, unify these two predicates into a single `gsp_boot_method` method
that returns an enum type unambiguously describing the boot method to
use. This ensures that no invalid combination can be expressed, which
makes matching sounder.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/firmware.rs       | 25 ++++++++++++--------
 drivers/gpu/nova-core/firmware/fwsec.rs |  5 ++--
 drivers/gpu/nova-core/gpu.rs            | 16 -------------
 drivers/gpu/nova-core/gsp.rs            | 42 ++++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/hal.rs        | 22 ++++++++---------
 5 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 80e948bf7511..7a5978f93f4e 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -21,6 +21,7 @@
         FalconFirmware, //
     },
     gpu,
+    gsp::GspBootMethod,
     num::{
         FromSafeCast,
         IntoSafeCast, //
@@ -429,17 +430,21 @@ const fn make_entry_chipset(self, chipset: gpu::Chipset) -> Self {
 
         // FSP-based chipsets (Hopper, Blackwell and later) boot the GSP via the FMC image loaded by
         // FSP. Older chipsets use the SEC2 booter instead.
-        let this = if chipset.uses_fsp() {
-            this.make_entry_file(name, "fmc")
-        } else {
-            this.make_entry_file(name, "booter_load")
-                .make_entry_file(name, "booter_unload")
-        };
+        match chipset.gsp_boot_method() {
+            GspBootMethod::Sec2 {
+                needs_fwsec_bootloader,
+            } => {
+                let mut this = this
+                    .make_entry_file(name, "booter_load")
+                    .make_entry_file(name, "booter_unload");
 
-        if chipset.needs_fwsec_bootloader() {
-            this.make_entry_file(name, "gen_bootloader")
-        } else {
-            this
+                if needs_fwsec_bootloader {
+                    this = this.make_entry_file(name, "gen_bootloader")
+                }
+
+                this
+            }
+            GspBootMethod::Fsp => this.make_entry_file(name, "fmc"),
         }
     }
 
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 95e0dd77746b..dca862c53a6c 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -386,8 +386,9 @@ pub(crate) fn new(
     /// Loads the FWSEC firmware into `falcon` and execute it.
     ///
     /// This must only be called on chipsets that do not need the FWSEC bootloader (i.e., where
-    /// [`Chipset::needs_fwsec_bootloader()`](crate::gpu::Chipset::needs_fwsec_bootloader) returns
-    /// `false`). On chipsets that do, use [`bootloader::FwsecFirmwareWithBl`] instead.
+    /// [`Chipset::gsp_boot_method()`](crate::gpu::Chipset::gsp_boot_method) returns
+    /// `GspBootMethod::Sec2 { needs_fwsec_bootloader: false }`). On chipsets where
+    /// `needs_fwsec_bootloader` is `true`, use [`bootloader::FwsecFirmwareWithBl`] instead.
     pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<'_, Gsp>) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 32bfa0be2357..c04706b60ba8 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -133,22 +133,6 @@ pub(crate) const fn arch(self) -> Architecture {
         }
     }
 
-    /// Returns `true` if this chipset requires the PIO-loaded bootloader in order to boot FWSEC.
-    ///
-    /// This includes all chipsets < GA102.
-    pub(crate) const fn needs_fwsec_bootloader(self) -> bool {
-        matches!(self.arch(), Architecture::Turing) || matches!(self, Self::GA100)
-    }
-
-    /// Returns `true` if this chipset boots via FSP (Hopper and later), which requires the FMC
-    /// firmware image.
-    pub(crate) const fn uses_fsp(self) -> bool {
-        matches!(
-            self.arch(),
-            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x
-        )
-    }
-
     /// Returns the address range of the PCI config mirror space.
     pub(crate) fn pci_config_mirror_range(self) -> Range<u32> {
         hal::gpu_hal(self).pci_config_mirror_range()
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index b4ac4156056e..cad851e68685 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -38,7 +38,10 @@
         sec2::Sec2 as Sec2Falcon,
         Falcon, //
     },
-    gpu::Chipset,
+    gpu::{
+        Architecture,
+        Chipset, //
+    },
     gsp::{
         cmdq::Cmdq,
         fw::{
@@ -217,5 +220,42 @@ pub(crate) fn get_static_info(&self, bar: Bar0<'_>) -> Result<commands::GetGspSt
     }
 }
 
+/// Method used to boot the GSP.
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub(crate) enum GspBootMethod {
+    /// GSP is booted by running FWSEC-FRTS on the GSP falcon, followed by the Booter loader on the
+    /// SEC2 falcon.
+    ///
+    /// `needs_fwsec_bootloader` indicates whether the chipset requires the PIO-loaded bootloader in
+    /// order to boot FWSEC.
+    Sec2 { needs_fwsec_bootloader: bool },
+    /// GSP is booted via FSP Chain-of-Trust.
+    Fsp,
+}
+
+impl Chipset {
+    /// Returns the method used to boot the GSP on this chipset.
+    pub(crate) const fn gsp_boot_method(self) -> GspBootMethod {
+        match self.arch() {
+            // All Turing chipsets require the FWSEC bootloader.
+            Architecture::Turing => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: true,
+            },
+            // GA100 also requires the FWSEC bootloader.
+            Architecture::Ampere if matches!(self, Self::GA100) => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: true,
+            },
+            // Other Ampere chipsets, as well as Ada chipsets, do not require the FWSEC bootloader.
+            Architecture::Ampere | Architecture::Ada => GspBootMethod::Sec2 {
+                needs_fwsec_bootloader: false,
+            },
+            // Hopper and more recent use the FSP Chain-of-Trust boot method.
+            Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
+                GspBootMethod::Fsp
+            }
+        }
+    }
+}
+
 /// Opaque bundle required to unload the GSP. Created by [`Gsp::boot`], consumed by [`Gsp::unload`].
 pub(crate) struct UnloadBundle(KBox<dyn hal::UnloadBundle>);
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index eddb4e8bf510..90f076f640e0 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -13,13 +13,11 @@
 use crate::{
     fb::FbLayout,
     firmware::gsp::GspFirmware,
-    gpu::{
-        Architecture,
-        Chipset, //
-    },
+    gpu::Chipset,
     gsp::{
         Gsp,
         GspBootContext,
+        GspBootMethod,
         GspFwWprMeta, //
     },
 };
@@ -59,12 +57,14 @@ fn post_boot(&self, _gsp: &Gsp, _ctx: &GspBootContext<'_>, _gsp_fw: &GspFirmware
 
 /// Returns the GSP HAL to be used for `chipset`.
 pub(super) fn gsp_hal(chipset: Chipset) -> &'static dyn GspHal {
-    match chipset.arch() {
-        Architecture::Turing => tu102::TU102_HAL,
-        Architecture::Ampere if matches!(chipset, Chipset::GA100) => tu102::TU102_HAL,
-        Architecture::Ampere | Architecture::Ada => ga102::GA102_HAL,
-        Architecture::Hopper | Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => {
-            gh100::GH100_HAL
-        }
+    // The GSP HAL is entirely determined by the boot method.
+    match chipset.gsp_boot_method() {
+        GspBootMethod::Sec2 {
+            needs_fwsec_bootloader: true,
+        } => tu102::TU102_HAL,
+        GspBootMethod::Sec2 {
+            needs_fwsec_bootloader: false,
+        } => ga102::GA102_HAL,
+        GspBootMethod::Fsp => gh100::GH100_HAL,
     }
 }

-- 
2.54.0

