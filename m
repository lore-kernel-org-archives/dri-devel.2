Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F84AEC01CC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA3310E34F;
	Mon, 23 Mar 2026 11:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1GanWYv";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E405B10E34F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkCT/ovKIsaPJ9JoR0XSUFw+3/6uL1j4poTU/G+Ad5LZ0Dzjzwwp6bel35yWOsIGkHznullNkQfwRKWtQ43gwQCeUZVYOiS/HpZrWRHUipJVZpfxV/xdrITzLFYg2c656b9UExcqz5MVlBsubb56fYTepNSkZp0t5Zxvg3slqdFaDYAxZCrdqnYIY3/qOcmI63BEM8xmYfSIG98gdE7fpA2KeUNtFlpqwcaIwDp2ZZHRtF3iizJMJcT6fl0YoriUneMQOkWl7CZWCJa/7WraaKlNnA/VY7cDkG54lZ4YGu2bOpZsSGUOcueQeEBffQsEO/7pmLaf+RuDcBjxJQ1VQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR5CM8jm8brgWEfjHp37FArjqpHQ2OqL7tBb9FstSuc=;
 b=fLQxFnS5wcmQ+YHKUdIJLukWo/EDTsaEcwJvnA1Pg+ZxchdvtyzMjIKs7OvaIefdvlwruJm535oRQT0Jk9+jyNPHFSjCqe4Ln/HtMEUUhz0hvVOmQ0dK4qHm3Xt+O6VjbJo8YvIelgCmNLpB6w3cuiFrd4lBcLICDowUbI0UQIi8iDt7QZ+aTUw+eQbnOZlZ/3/8Jl1JzE/vDh8P/nT0iOrWFdiQiOed9YF4P5+wDwYv9ZNMGzP7Fl6QERqmjU2WpaKMxMK27x2cftVOrhSKxFRumSj6x0M9BlTg8+yHnp3kB9NKLFFQ7Z3tZ+MBNMhmqCavD05Ka3BMXT8CRxiiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR5CM8jm8brgWEfjHp37FArjqpHQ2OqL7tBb9FstSuc=;
 b=A1GanWYvLIRwegL2yi3n7+b3x2ja3zFEb14kgr3VKf7DaS+zUFzcjFVP6L99R5e0OgAVDC4lH210jaObVcpOvvybVEYf0g8wJi4Nr32S3qN6W5cmvOFccmGlgUmzVz68G6qRHwcKD5/DDXiWFK9+jII0co5xxZ3O2IWZ2QwqIeCEG7e6++RB7m/SRjrRxmRF7oqQFWqtiQ17Jb4Hpv/cyY3R12zL+QY2XLOuRNVwnih9OFudCs1P6HvLGHM2Ei3He/1OVjbyu1XClhu0h6Y5R7NEoal8Dwgr2lX/YgevKeuRg+cap4xCWdinvbVaoj5/6Fx9D/da2Q6IzzPhLBYs6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:07:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:07:55 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:37 +0900
Subject: [PATCH v3 02/10] gpu: nova-core: convert PBUS registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-2-ae2486ecef1b@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: b58eb698-56b4-45cd-e847-08de88cc6f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: OPHde0Nink8o8ACK9njxSGeOPyPcqerWMxKMAeEZSSeT3Qdc6AbXl+VBURNVk01i8xA81UHyE6SIUWhWSgkxtiW6JnF21gQHmSwYgtjaIcJfXPaiJWFucN5ndGseJFyG56PWMtZXDun4xgTuxpeJW0F8cpd9djTfGWeu9yoJRlGZAGco0L4nUl/6fEFne7XQe7Q32+FlSUfuKgYB1/lnEZwLWw6Iy7pgt3dzjQctrGUrLMPy3HJ/IUtFDY6HfhWWlkHjBDPnT9gyGJq9jztDdfJaot8NNUnHj6Pugy29Oy2DBFfJasWX3e/RlNK/TOHvH7sU0tpLnWTNrzG81UPzb4cZAbnVTn9Fcl3Fp1ZfXq2wOz8qrY3pluF4a2/IIAhik7fFrXqEsAh9l5bdPxuG3tvGztRsvAD2XMrL5JPKddkYnvRHTEvl/NOTREEIwl4NbiVJIUXmHGCKKXh6GKbOXaJqV552H38f50Nih0j9/US5zcE7gUP8ZqatrmMsv0EtJWHIZXlxEmYo18Tt+4y+NaJUrLk8MjoJA7sr58Y11Efc482LARrVGUnRkpbltX4vfvd3pu8AnWUk9arCK9OpEpOkh6ywgMzZ7hGwEzJ5dDLgyVc/JTt2bDRZ3Y+kIek9jwpmLXLFwkVRQdMTpzMEL31iGO4wio8DxDad3Wa6VyawGHcpJI3KXTF4Z/B8zW2N7MP/V10JCqok0KauDXFq9AtWDRaPkaKYbd0kaUPpB894KvKYKKfXj6CNEb7nL71eDAfLZvNADhKESLQxRrUQvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWFYRVBJY1VraHQ1YmhoTWpieHJlQ08vTklvVlpQTExvd25hUllxSGp3Wm9U?=
 =?utf-8?B?dklzREp2NmJrMURNbHRBdGM4SkFUUkcvOWVGRE50MlpOaytCajBHZjZvNmdZ?=
 =?utf-8?B?allNMGprNU9zNWdhdmV1c3BsSFFKaFREK21kZ0Jwcld6NTNndTMwdDBrUk5P?=
 =?utf-8?B?QXVyNE45TTRkaEt2UjBmS2JPcXFsbjByYUp1Y3BhR3BpekdmTjhGYVNEQnBF?=
 =?utf-8?B?SVdSZjVPb2o4YzUzRGlXM3FpNVBMZWgwUGtwMVlnKzN1dVhKdlVoWTRLdHRj?=
 =?utf-8?B?VmZXcEE5dEdyVC85Sm9GNG5TWmhURWhLa2ZrOUNLY3BtSzI2WVlUUm40L2ZI?=
 =?utf-8?B?OUcrQ1FxcktFdFBMNTF1aGh4MS9IVFBYelcrNjBnQ1ptY29ubGROMmZVamtY?=
 =?utf-8?B?ZVNFeU92ZE1LTnZwVUlWT2cwalZJaHhLYytqMm1neUg2MmlFL0V4SkZVZGZU?=
 =?utf-8?B?eTFNdXdFcmpCM1RHRVMrQWJTOHZhNUlwWWFrSDJiQzR4MWlDc2dicHpMR2tw?=
 =?utf-8?B?VnFSUm9sVjB4V2dFem9WVkFvNDIxaDE5RVdNUUk4M0VzbU01bGFGVktUNlRI?=
 =?utf-8?B?S0xRWVo5czNFQjZUYkRsU0JpbVBoaUREK0xJSFJ5bnNPUytjTFJpOHRBL3ZD?=
 =?utf-8?B?MjVTYWlxNkRNejZsdXFjM2VqcjFWUVIvYzlKaUZDNmhqT2dJOUNpZmpiSkRI?=
 =?utf-8?B?aytTd0NFMTN0cGl2eFlCOVhSYloxMjBYS2VYVjU2NU9vTlM5UzZycWtiejdC?=
 =?utf-8?B?bHlGTU0vR2xCNmVnKzVlcE5ySlE1SlJVSnlqRXNqVjhHbjJPQURGMUFvVm13?=
 =?utf-8?B?M3pPMzZ3R2pDTDM5MVhaNnl1bUp6YVpweWkxSzZ2eGlaM3BTQ3pxbXFwK1o4?=
 =?utf-8?B?UXJFbFd2UTZZa2ZNbjhBVHlza3F3bHJWREdDVS9WbWVYeW9sLzBwR0VOK1pI?=
 =?utf-8?B?SlBnNlZLOTVRL3VocTBwMVhIMzJjK1R1cm9aanpnelRtVDQ5YWNFNW55UHh3?=
 =?utf-8?B?VU1JTXFOamdmemxJTHNYRElUaEJVUC9JeTdSNXdkdGd1Sm5Bdm5hMCtZd2FM?=
 =?utf-8?B?Z1NSWkgyQlN6eHNyVHh6ZnI4bTkvMFdnZHJSN1U0SFJSaG1nZW55NFdvWmg5?=
 =?utf-8?B?dWlXbkxQb2N0bnNXampQeE1oWWJ0ZnBGNkxpMUtaalUxWjd1NUN1eDRxTXZV?=
 =?utf-8?B?ZFNJKzlPa1luT1lrWVV2UWhlUnNUd2dGaFREUTVSSUErQlBZOWp4aXJmaDFK?=
 =?utf-8?B?QWNxOWNxS1hFZ2xpMzFEclMydFZEUnd6em9JTHVuZGRDa0FHMTNzQ013cTJF?=
 =?utf-8?B?dXJCY0R5dkhqK2FsTU9IM2VJcGM4VjhiYldMYUJIa0l5cTlmYjdqNVdaSjBv?=
 =?utf-8?B?cFdwMnVrUmRsR2kwOGNmdzNhVkcvMXB0TURjSEcvUEZHQ2w1WDgzOFd6TEF1?=
 =?utf-8?B?Z0JaYXM0aVEvOGVmZ252ME0rOUUxcmlpaGZyRGV3dWFZTDhPTXUyMG4vQjhi?=
 =?utf-8?B?Q1ZVSzRlK3NJWUVTdWgvM2s0S2d5Y3cxelB0ckQ4bnJEYW50ZzZRSUVhenlS?=
 =?utf-8?B?N05YemVwRFMvRHFlVlBxbWo3aE1odmNKMkNQTHdzZnZOM1dmNmp1YVlRTWZX?=
 =?utf-8?B?eTVLU2RBU2FLMUt0OEVBb0EwVXFRVUx4TVpueW8zb3FJQ3Y1bVhXRk9CSDMw?=
 =?utf-8?B?anV5a01VNWhTcGp3Mk1OOGo5NkdLaWFna2owNDJFMWo0T2dIRWZMTEg2RzN3?=
 =?utf-8?B?V3djazhOUE9nN1gwSjVTakwyNWRheXBXdEFLVWp4ZVJqRG4zOENrKzlsSHUy?=
 =?utf-8?B?RWlsdnNteEFFSFlvZ0JJNUlYaldMcnNZcFZjRExWN05HSHU0MEtVNnVYT1pk?=
 =?utf-8?B?dnJJQ2Zmb29ReU9CRHRZVEZhczQybUpyRVRRdjU1alAxbnRneExaVzFPa1M2?=
 =?utf-8?B?aUxiUlJVR2FvYkJhODVaQnFTZ2tZeXhYc0RHMXNSb2tKT2lTOTlCcXZCdHZl?=
 =?utf-8?B?cE9sc21ZcUwwb0NKaEVuQ2JGWHE5aDMzRFZTZys4Ni9wRU9TUDVnNmgvc2lR?=
 =?utf-8?B?V2p3SlFuSWNJaENpaFBseU5HeDJ6OUhXMEFLaTM5bzBXVnJFMkpYbVdLamdT?=
 =?utf-8?B?Q2ovVkE0MHp5NXp1Nklva2VDWGN4bllZdDF6VkxvOE5xem12dVh0d0IwV1Jh?=
 =?utf-8?B?ajBHVUQvTVR3UWFkMFgwUjZveTA4Ky9pcXI4U0Z6eTFzVGdGTWJWcVFMRVVl?=
 =?utf-8?B?L1ZicEZjT2FnNkRmQzNXRms1RG93cDZyOVRWb2lGaEtxRGtXQWNXVTRSUjRX?=
 =?utf-8?B?bFBXY1huYUhJMlZxSTdnb2xDczA2aXRwblRuQURoSjU2cjVkcnBoNE1CM2J4?=
 =?utf-8?Q?u2cvupg13aUhr9euiH3eDpM+xkBd7shQPsGjHdmc7i5Qg?=
X-MS-Exchange-AntiSpam-MessageData-1: uz9R4Oz8fPOvMg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58eb698-56b4-45cd-e847-08de88cc6f75
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:07:55.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaJRSJXRs4QeDn3hABni58Gs9e5WWNYXs/vt7AsxguL5xiooZHN3agvOXtvPFwfFHOrOVWdrzsp3/2BkOiKKew==
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

Convert all PBUS registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs |  5 ++++-
 drivers/gpu/nova-core/regs.rs     | 12 +++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 5e73bd769dcc..06b8313c1219 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -5,6 +5,7 @@
     dma::CoherentAllocation,
     dma_write,
     io::poll::read_poll_timeout,
+    io::Io,
     pci,
     prelude::*,
     time::Delta, //
@@ -87,7 +88,9 @@ fn run_fwsec_frts(
         }
 
         // SCRATCH_E contains the error code for FWSEC-FRTS.
-        let frts_status = regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR::read(bar).frts_err_code();
+        let frts_status = bar
+            .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
+            .frts_err_code();
         if frts_status != 0 {
             dev_err!(
                 dev,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 58fb807605dd..533d912659ba 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -109,12 +109,14 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PBUS
 
-register!(NV_PBUS_SW_SCRATCH @ 0x00001400[64]  {});
+io::register! {
+    pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 
-register!(NV_PBUS_SW_SCRATCH_0E_FRTS_ERR => NV_PBUS_SW_SCRATCH[0xe],
-    "scratch register 0xe used as FRTS firmware error code" {
-    31:16   frts_err_code as u16;
-});
+    /// Scratch register 0xe used as FRTS firmware error code.
+    pub(crate) NV_PBUS_SW_SCRATCH_0E_FRTS_ERR(u32) => NV_PBUS_SW_SCRATCH[0xe] {
+        31:16   frts_err_code;
+    }
+}
 
 // PFB
 

-- 
2.53.0

