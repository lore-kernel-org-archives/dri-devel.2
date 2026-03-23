Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D79EC01CE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D6510E3EC;
	Mon, 23 Mar 2026 11:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pszez0pN";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA12710E3E2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnF1aSRQOXodxdmQN+V64cu1nbmSQWzn8FgUsMENN4rX42kjW/zBTj6IJN3KpJMKeRc200CwyO8s8K1eTLAhuBJj/Q8/EOaXeW86yujHjY6t93U1gEMZmD14RckcQBtYgT4265THgESlleydB8U+JiQdD63gAjFz/khz4B9Pxa7IFinbn8iznVL40+wHFeRg52u977vykqmRY4GfCtlc8J9trIXhwNyeJco/SYKD1UUrU6mRJKEcrztRIRM/kV7St02otKS3VgOSL9XIBLqow/+O+V8oAjHYJWEtw11PkEBkd9a+XE/htaDSbo6SvIPCeVSFv2NvyVvBCsMAJE1LxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykVCc0j3So4riy+gGSU5VyVeBQPVYbZlHj/DSi3QZKE=;
 b=G6c55q2vKRWUGlNO1RTXl5bdfJVW6mUOZ8cSW25KJcf/ywLJYJfhLWzHoh4lwD15cUMWW5djw4oT8AtJggWcBHqTyk6jTsnZFGX3C4zLgb/B0xOzydKlskf/eg0F7y+LGrSTa5JiJDjpnHPyTVYi3gUcVwEVShuBlwzAyPs2uQXS4jPA3dNDKGIFhJ+GUVKe8kE/leEwffgZdsgKG6Pe9kKusvyKw7D9OAotqw+7g5qw0dnDjnXVEgv9ZjzF3rUglwql+F6uFXOV9e6S3zk+8sVrVvZS9pxBiFpPNRbgU3L8stJRsM0Ya+ZnH/IXrMukqM3T6mDacnT2dGtmOVofJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykVCc0j3So4riy+gGSU5VyVeBQPVYbZlHj/DSi3QZKE=;
 b=pszez0pNgq7vSc/L15hYbRkp4S8+jomZEOhoz9XottiOkdSEdyYh8HgePAMdVJjsovAtSPoUnCN3/JZymYYCZpwiqaayI3H1vPr9b1g7ohxtc/1SSf1xg4TDV4ZI1Lj/tBAnlTSgJ2kcGxsbV8rXbWLTS1vff9jXtm7DRiboGf0BGhkQkNOJxD+L0Y6CAhDDvTJhUMTBPCn5Fg/c3XqduL4ZLRDE+QuspdeQnEbkAUxy+ssw97xv21PIo1s5+AEt0TAfOvb4xO2kanYOmS9M7r9lr35ZjhiKF0ZTKo2ei1fbTyeRr1u92DYIqOvmhdOsewnvGa6I6lFGmPJg2V2u2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:07:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:07:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:38 +0900
Subject: [PATCH v3 03/10] gpu: nova-core: convert PFB registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-3-ae2486ecef1b@nvidia.com>
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TY4P301CA0051.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba0b6b8-322a-4ddb-08e0-08de88cc7179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: mjzruoWgHTkNTPmvlqRQPweNWQ4+iqnkd+0kW5f63ZU15DFFS1buOPzNs/t4v1jB+HlecOwOxEkj7hvWeNwqCSv7J//OXKY1GVfccLmpQrPO16yBRQJQnYC8+dbpXYMNU42zUlNWfuS9Ii5l1wH34K74chViMUFMu7rBI27wpi259zAqvLOySVgAKvu4p9/SZzCRPzLWKVD9sYajJFe6a5Slv69EKSY4eg1txjgIFA+oDc8XOgKpOP+JiPtCrpO1wz5jF+JyYtFoaLdIQscdQin8FhcAmPBfIgzqEHbLDk/30Oc3XLNlw9f0jtC9O1RmAuuSL/e/gDmCmDysstqiNuKb3QuUlUP9/QHhKPPPdkczjnid0JzZ7e8dZWlyOJoghiUUtxpEGRM0+vyyktWZ2RDF6NtvzrwTU/pMA9p77fnSwOw5hZY6QujIFngNNzr9EI4vuEsZssJDh84Gyu4h0dsjv9286VoSKSIcNNNp80mrYLkwfK7TSZv8lKAiqZEVz9oOrp4k8TWYASw5th+cMt3uzZLq+mIj5YQaKYrsbBsHIqEnUK7SA8uKNZKY0IWNMd8Q33jstgmJKegra5sDnW6bEognlJ5wcmBuAhlfxGyZSL2Y4WZMUXzvqDXNRz2yXph0a1TxDZja41NpgyMPJh/Hk3hek+T8/PwGsMbU/ixXaqElKV2Od4RHa9Qjh0BweBDfWA+Zw0GjC5lcoKS3tXwHRmq1MRsAYN3P/bJR4OGMVFiLyN+Uuozs7tfTMplrlQS9f2dQeyQ6CuRtjJ4V/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGZnSHErYmlQMkRVYVZsc1ZLZXBMTDRjL0F5NjJsV0VrOCt2TldVZEoyc1RB?=
 =?utf-8?B?Zmw2MnVTTXNzNGVWTC9QMGo5eFhjNys0NUxNc2s0TjBvMEFGa0h6Uno4cDln?=
 =?utf-8?B?SlhINGJaOUtuZXRjTlBzc3ZENUFyM01EYUZmRGRLek42MStPYnhCa2N6OVBq?=
 =?utf-8?B?dkIyZ0crY2lsZ3dock53SGhnWG1XaUlsSXg2SzR3OXA4OVdmL2JOV29yRi9M?=
 =?utf-8?B?WUtnd2VNbWd3cHlzTEYvMnlFdDhndXNXMmJ2UGlKYU00UWVjU0draUQyL01E?=
 =?utf-8?B?ZE5yekRQMm1jZGI4TUwvZ0dZbnRCUlg1MWF3bXV2aVhJeW5BV1hldVRRQ0k5?=
 =?utf-8?B?TkdmdW9SWHhHNW1NRkwvNWVhdHVQc2JYN0ZmclEzdXhGZUlQK1AyT1RIelR5?=
 =?utf-8?B?ci8waG9JdGNnSDl3N1A2VXN3T1Qzd3NaZHYyU1pkMGozQXh6ck0xNjhjOEVk?=
 =?utf-8?B?QlNocnNXNS82MThwVGFDVHBURGkzWVQvUGNqMW82VkFIcW1FZzFSVWl1eG10?=
 =?utf-8?B?OXdiRjhmVmd6ZHRIekZieVhxOUdEbWpMcUlBNzFGQWpoMUF2QlpNZG9hSjJC?=
 =?utf-8?B?WU5BcVBYY0xmaCtiZDlLNEJLakgzYTkrclVpTm50VXo5a0lPVUs1OGtPbm0z?=
 =?utf-8?B?amVIZUZwbXRBUG5UOE5TRG9nTVp5SkkraitsZzhSa3FJSHo1VWd3SUJ1Mzcv?=
 =?utf-8?B?YVFGRkhtYXBSMzZyL0lzUklWbzJrVlpaQ1FjQUdNRmg0alhBWGFYZitjRUJp?=
 =?utf-8?B?cUdsK2E2TlJnT1FKY08vRDgzeHNVaFJ4ZkxLSXEzUmNFeUErb2pGeUtmS3lY?=
 =?utf-8?B?cXFhNUkzWHhBTTgvMVNhN2dDSzh5WnhKaE1PYnUwampEcVV1M20zczg0SVd4?=
 =?utf-8?B?N1BMcG5sWFhKbE5KRzBlV2VpMDRDZFNpT2R3M003a05wbWRpOU84SDZCOGM0?=
 =?utf-8?B?a1JQQUYybWdBRFQyZ0hpNVJlQWlwcHpmTDBnT1NDTXJZZVMzcXovcEhoc2pq?=
 =?utf-8?B?R0E3eDNyZExvaXRMWnphYVArNm01b3BYeWEyYlZVTWp0WDlDRzg1NmZOeGw5?=
 =?utf-8?B?ZDVBMDdTRGRWZTBCNXpUamgyV2llc3ZFNWhNQkpXSXhoQ2xhTlRCV3F5WHEw?=
 =?utf-8?B?eTNOZXppSENldk9DUFJsN21aMndCMm5GbE0rdFFxY0h3OXQwRHJpcUxEZXJZ?=
 =?utf-8?B?cWl0enlvYi9TVjRyZ2ZBbUEzOFRIR1hraXFxV0Z0MGNqaDRJVTRwZy90Q0RV?=
 =?utf-8?B?S0Q5cnJHOVpYMURmOXZSc3crV2hjbXV2Z3dZQ29wZHJjSm5WTURLaTBEeGhm?=
 =?utf-8?B?TlBLVnJaNjZtVGQrSFhPOGZFT3pUa3BiY1RkREZnNVl2bFVSUDJ4ZW9oOW9k?=
 =?utf-8?B?azBBNEIrSWljcVoxZ2wxVnJMWUd4enJXYzlFd0REWmZVL3V6a0VPYXNSY1hO?=
 =?utf-8?B?VUtBQVB0a3NDdkpZaDlOc09hRWRPbHh2SDNPSEt5VDhsdWlVVkRjcURBdURh?=
 =?utf-8?B?S0xuMGlKNmlubTJQc0FHRW9lZ1B0TG1tTGpIREtsaWdSSjVPUnQ1WEUrSlEx?=
 =?utf-8?B?R2lld3RhTHExcDlqSHpmamhqQVM1VEdOWEQ0WXV3eUFVR214Q1QxNXljSmJO?=
 =?utf-8?B?dlBKbVBKMVpzdlczUllCd2xoQzBjVk5DbjNFTWV3T3Z5U2M1MnZMdFJjaVFF?=
 =?utf-8?B?bHk2UkU3Q0ExS1JPUmJneFA2aWtzWU9UTDRyYTZJZXJJVHVBUTluSkpVSlNp?=
 =?utf-8?B?OVRXS3c1em1SeFlxL21NM0htdHl5ODFyTE9sem0zQ3l0UmJmdHprSXhlbFVU?=
 =?utf-8?B?SzNnMnF4YnNWcCt2M3pXeGlwYnY0ZStzVGpQZ1dERUp4OThhSzBaYUI1Rk82?=
 =?utf-8?B?Yi9sV1NyU3NBTXJUeUNtTk8yd1loU2JiM21NZGI4N0EzV21NNEZCOFFyQ0VZ?=
 =?utf-8?B?c3MraDF6L0FPaDZabXFiQ0hWN0xkWFhEdjcrc1JKdnhvQ1dwTzl1cUFBbnlC?=
 =?utf-8?B?Tkltb2tmdGFtU1lmUFFKWHhVTkx6SWdRcVo4VVUzSmJLeGhFUTh4T3JTcU95?=
 =?utf-8?B?bE5JMnd1SUR1L1RQNmlmVkk3UWFIcDZkTjZtMHUxcDVOME8wRDNGYXFSWlll?=
 =?utf-8?B?dWp1M0puYmFJTGU5ZzN6Um1yS01qbVYzeVNpbnJHRG9QRytVV1JkRkhBTTI5?=
 =?utf-8?B?UUp0TDdhZjZCNXZTbExieDZPNHgyZ2h4cTNoNWRXMHJtM0JKMkJzNE9HQVMw?=
 =?utf-8?B?T0Z0WVMxa3dURlloQ1pFVmFJVzZwUFNaWGM2dlU5dlg3RS9HQ3JSTnFZVG1N?=
 =?utf-8?B?NVR1NjRTbUhTQ2VzZGlZbXFPcTJMZDVHNDluRnc3aWNXNWZ5TTZ3a0IyMnRu?=
 =?utf-8?Q?EzMmGNi9kB+p1p8LA7CChkwk1okyLB5Tb52T2k8s8rezw?=
X-MS-Exchange-AntiSpam-MessageData-1: y7Eg7kR0zdP+yA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba0b6b8-322a-4ddb-08e0-08de88cc7179
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:07:59.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVnsm/706dpBBKQXCjJYO/mB/sBijPWPDsBlSy14IdMCsiNg4mtMBZEFoAGyZ5qS2U3Y6C4RurDuLjtAFuOsMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

Convert all PFB registers to use the kernel's register macro and update
the code accordingly.

NV_PGSP_QUEUE_HEAD was somehow caught in the PFB section, so move it to
its own section and convert it as well.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/fb/hal/ga100.rs | 34 +++++++++++++--------
 drivers/gpu/nova-core/fb/hal/tu102.rs | 14 +++++----
 drivers/gpu/nova-core/gsp/boot.rs     |  6 ++--
 drivers/gpu/nova-core/gsp/cmdq.rs     |  9 +++---
 drivers/gpu/nova-core/regs.rs         | 57 ++++++++++++++++++++---------------
 5 files changed, 70 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index e0acc41aa7cd..629588c75778 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    num::Bounded,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -13,22 +17,26 @@
 struct Ga100;
 
 pub(super) fn read_sysmem_flush_page_ga100(bar: &Bar0) -> u64 {
-    u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::read(bar).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
-        | u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::read(bar).adr_63_40())
+    u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
+        | u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI).adr_63_40())
             << FLUSH_SYSMEM_ADDR_SHIFT_HI
 }
 
 pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
-    regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::default()
-        // CAST: `as u32` is used on purpose since the remaining bits are guaranteed to fit within
-        // a `u32`.
-        .set_adr_63_40((addr >> FLUSH_SYSMEM_ADDR_SHIFT_HI) as u32)
-        .write(bar);
-    regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
-        // CAST: `as u32` is used on purpose since we want to strip the upper bits that have been
-        // written to `NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI`.
-        .set_adr_39_08((addr >> FLUSH_SYSMEM_ADDR_SHIFT) as u32)
-        .write(bar);
+    bar.write_reg(
+        regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr_63_40(
+            Bounded::<u64, _>::from(addr)
+                .shr::<FLUSH_SYSMEM_ADDR_SHIFT_HI, _>()
+                .cast(),
+        ),
+    );
+
+    bar.write_reg(
+        regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::zeroed()
+            // CAST: `as u32` is used on purpose since we want to strip the upper bits that have
+            // been written to `NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI`.
+            .with_adr_39_08((addr >> FLUSH_SYSMEM_ADDR_SHIFT) as u32),
+    );
 }
 
 pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index eec984f4e816..515d50872224 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -13,7 +16,7 @@
 pub(super) const FLUSH_SYSMEM_ADDR_SHIFT: u32 = 8;
 
 pub(super) fn read_sysmem_flush_page_gm107(bar: &Bar0) -> u64 {
-    u64::from(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::read(bar).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
+    u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
 }
 
 pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
@@ -21,9 +24,7 @@ pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
     u32::try_from(addr >> FLUSH_SYSMEM_ADDR_SHIFT)
         .map_err(|_| EINVAL)
         .map(|addr| {
-            regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::default()
-                .set_adr_39_08(addr)
-                .write(bar)
+            bar.write_reg(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR::zeroed().with_adr_39_08(addr))
         })
 }
 
@@ -32,7 +33,8 @@ pub(super) fn display_enabled_gm107(bar: &Bar0) -> bool {
 }
 
 pub(super) fn vidmem_size_gp102(bar: &Bar0) -> u64 {
-    regs::NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE::read(bar).usable_fb_size()
+    bar.read(regs::NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE)
+        .usable_fb_size()
 }
 
 struct Tu102;
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 06b8313c1219..55d8aef5ff1e 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -58,7 +58,7 @@ fn run_fwsec_frts(
     ) -> Result<()> {
         // Check that the WPR2 region does not already exists - if it does, we cannot run
         // FWSEC-FRTS until the GPU is reset.
-        if regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI::read(bar).higher_bound() != 0 {
+        if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
             dev_err!(
                 dev,
                 "WPR2 region already exists - GPU needs to be reset to proceed\n"
@@ -103,8 +103,8 @@ fn run_fwsec_frts(
 
         // Check that the WPR2 region has been created as we requested.
         let (wpr2_lo, wpr2_hi) = (
-            regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO::read(bar).lower_bound(),
-            regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI::read(bar).higher_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
         );
 
         match (wpr2_lo, wpr2_hi) {
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d36a62ba1c60..b8b0edba5afd 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -11,7 +11,10 @@
         DmaAddress, //
     },
     dma_write,
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     new_mutex,
     prelude::*,
     sync::{
@@ -503,9 +506,7 @@ fn calculate_checksum<T: Iterator<Item = u8>>(it: T) -> u32 {
 
     /// Notifies the GSP that we have updated the command queue pointers.
     fn notify_gsp(bar: &Bar0) {
-        regs::NV_PGSP_QUEUE_HEAD::default()
-            .set_address(0)
-            .write(bar);
+        bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
 
     /// Sends `command` to the GSP and waits for the reply.
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 533d912659ba..4f5cd64c2fce 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -120,26 +120,35 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PFB
 
-// The following two registers together hold the physical system memory address that is used by the
-// GPU to perform sysmembar operations (see `fb::SysmemFlush`).
+io::register! {
+    /// Low bits of the physical system memory address used by the GPU to perform sysmembar
+    /// operations (see [`crate::fb::SysmemFlush`]).
+    pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {
+        31:0    adr_39_08;
+    }
 
-register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR @ 0x00100c10 {
-    31:0    adr_39_08 as u32;
-});
+    /// High bits of the physical system memory address used by the GPU to perform sysmembar
+    /// operations (see [`crate::fb::SysmemFlush`]).
+    pub(crate) NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI(u32) @ 0x00100c40 {
+        23:0    adr_63_40;
+    }
 
-register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI @ 0x00100c40 {
-    23:0    adr_63_40 as u32;
-});
+    pub(crate) NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE(u32) @ 0x00100ce0 {
+        30:30   ecc_mode_enabled => bool;
+        9:4     lower_mag;
+        3:0     lower_scale;
+    }
 
-register!(NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE @ 0x00100ce0 {
-    3:0     lower_scale as u8;
-    9:4     lower_mag as u8;
-    30:30   ecc_mode_enabled as bool;
-});
+    pub(crate) NV_PFB_PRI_MMU_WPR2_ADDR_LO(u32) @ 0x001fa824 {
+        /// Bits 12..40 of the lower (inclusive) bound of the WPR2 region.
+        31:4    lo_val;
+    }
 
-register!(NV_PGSP_QUEUE_HEAD @ 0x00110c00 {
-    31:0    address as u32;
-});
+    pub(crate) NV_PFB_PRI_MMU_WPR2_ADDR_HI(u32) @ 0x001fa828 {
+        /// Bits 12..40 of the higher (exclusive) bound of the WPR2 region.
+        31:4    hi_val;
+    }
+}
 
 impl NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE {
     /// Returns the usable framebuffer size, in bytes.
@@ -156,10 +165,6 @@ pub(crate) fn usable_fb_size(self) -> u64 {
     }
 }
 
-register!(NV_PFB_PRI_MMU_WPR2_ADDR_LO@0x001fa824  {
-    31:4    lo_val as u32, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
-});
-
 impl NV_PFB_PRI_MMU_WPR2_ADDR_LO {
     /// Returns the lower (inclusive) bound of the WPR2 region.
     pub(crate) fn lower_bound(self) -> u64 {
@@ -167,10 +172,6 @@ pub(crate) fn lower_bound(self) -> u64 {
     }
 }
 
-register!(NV_PFB_PRI_MMU_WPR2_ADDR_HI@0x001fa828  {
-    31:4    hi_val as u32, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
-});
-
 impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
     /// Returns the higher (exclusive) bound of the WPR2 region.
     ///
@@ -180,6 +181,14 @@ pub(crate) fn higher_bound(self) -> u64 {
     }
 }
 
+// PGSP
+
+io::register! {
+    pub(crate) NV_PGSP_QUEUE_HEAD(u32) @ 0x00110c00 {
+        31:0    address;
+    }
+}
+
 // PGC6 register space.
 //
 // `GC6` is a GPU low-power state where VRAM is in self-refresh and the GPU is powered down (except

-- 
2.53.0

