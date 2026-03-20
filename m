Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BEB108B915
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7221810E290;
	Fri, 20 Mar 2026 12:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JllCKGIV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF0410E290
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7rtPvpyORofJiFNK5/O+QR6hjggJJkqIrmB/znyj/a5oVCq8B65GPAcq68Uf/ZA472Fm4rfVOkyt57WLZle2omDN4yV1J0QhbBHLt8n1cdNOrz5gqou0olXDjPhKHuFfpXmyaRjfoMH4aRr96dgeFoSjRn2uq2gO0AT74HuMPIVMsZVeKH4YUGkbSfZ9uS41MLBOnnkIRymWWNTMGwkPyHO880bKGxwW//S1YJRa1vzm+SLM0uGrRo2o9jxMeGicFOyeN4+ngfNlHRSVQf3cz5YYpG6Rx/+mlf+Q0E4cahnKUVBbN9wl5e7vT2NSL7dQF0teROMfXxCREcnZgGe1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3M8T1sWTP9sxFgyLqFR0ZcMzo5VXqmEGaweNhIAQic=;
 b=M4vePbQKQ5fBCPKVP6ocxLLtffkoIVTyVS2ZfKZaQdES2FK5KAfbgqoADqKDC0L050fsylca8CBTASS55SJa7610QUDXx4g9Ns+8EvsV0YRrdeEjauB6fVLkdzt6c42pBy69H1r3L2OEMTSCMUHYoWWoTq2zzMgwDaandWDA0VZ4TRNu3mKFzKufL7TZL3BKyDLIxeh0rShVkd0Ey7hV8W9coTDgUEAtWlTSAAb+miLamIoAJ0Qw1MIMyI9blZ5r92HC3vb8ATtIjAF699bn0Asv2cKzd1SfVSKzrFfulFGfrG7Stkdur0xIf8HP22UGjvFJPD2kNRaPDGJTsFsGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3M8T1sWTP9sxFgyLqFR0ZcMzo5VXqmEGaweNhIAQic=;
 b=JllCKGIVI0zbUGWm4lCc9+MOAiKTXVDIFAfnZo6zlZFyjDU2OrV+p7DpwpF4e/rPvE8HTXg8QMG9FIw7pb5aj0tT/Kt8/fv3Wzx5QKNss2ccIaod0Bf2OFMtNpTYeLuOImm9Nzi4rFejGLCxbQKDyFas/dfgdPmW4KCdLeaxnCooMb/Nt7FE4SY7AvE/oTu3sfliv9ScqDuiFSzZR1+3x7/FDre39hPw2cXcyERmKT1db68HuPj1VXM/hGEho5TpWdJRXmWtrBuyb/83vDkkpA9TlshaWUTQBxhvsvgqjTPf1+N8ap+y1Ulj5ZNCWyNxouiZ7lIU8SNxLc4k0l39Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:13 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:53 +0900
Subject: [PATCH v2 04/10] gpu: nova-core: convert GC6 registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-4-88fcf103e8d4@nvidia.com>
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
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
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 3041323a-1791-4719-114f-08de867b0986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: EAGL0JQny0B4v5QCIp23/fywwciWCCWHQ0J4hWADDV2e6m3JSoXrqxoJNWr2kg1UruPVEKvlM5e13l0WppQEm8zcysdEk39Cg2vvhP78/+ENsoOSrF7cRi2Xq/Al69iHTYpRF6rdPbhNkoMrd1k5BibPB96PMPR34COGMp+2I9fEI7Fg0CMehzopZ0mVZrDI8yD6VnkR3nBYZO8jwHG1jA4r5j6NE9waKKtp03K9PgVRScjWP0Yb0sQt1n9NqgpHus4HjfZnX24oDfmkj7dZX93ysUsk0qcVzBo9pecS50+W3mtBPMIWP/cBFzp+5UpUkUJdPwvapJuT0udAYGAia0jSfLRnKJpjfgnoTTqNT21AiUIWkJkbeaY8URDJtks5ryNzsVBo5nb5X6oBhDUF+YSYhj0o/nallCA+5mOXIUDxas0AnmemzW2ETjBZUd0HNO0npYNCeKncxIiRWaUHpDfcsZxDulz+xLLbxWPIaMYEkDLOwzgXI62ycafeEYJ5XNi+TFT5vQw/YnwZsqP5SJpKZ10l/4qdQjw8V4iZ4TQL2n+QJvjr2fI0KLZ0cKVO7K2HEglGlgcTcOo9BwLOsQaR2rgU4qyi0PC2qPbeVWlEk1215wqlKY33ivoRDi5pKOP3B9ZPknvZNTmQ1oaoBAoaxXkLpkEXVsprf8kCyfkzDsLEni6GFm5R28fdoBYLU2MFGyzBDSZxq7b5HDfbT9ccR8Q2y5PgiFMhCsw0LhOoInzM/AWuiC0QsiqjNo/GKRQWw0RFzjskK6ZYi+FxzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2VyMjZ2UnZIQ3FPc1JqbUUvM2FvL1h4ZlR6Nlk2b1Z3TEVWZUR1RWxYZVlz?=
 =?utf-8?B?SU02cUxsSEZORFQ4UXk3U1R2Zmc5VXVnTG1aUDlaSFJHS1VtWkNPTmw4dzlx?=
 =?utf-8?B?RERMazhOZHMzNC9iZDg4cDdWME5HcSs2VGFXQjdCVkRKc211RnFXU1FwaWJC?=
 =?utf-8?B?eW1meXJnbkV4UHEyT0s5aEJTMnV6dEk1ekRLWm5hVGJaMlVUYklSelJxZUNp?=
 =?utf-8?B?SlNTWG9OZ0VWS3RHdTZPL2ZIcHJ6RU9GV1Joem9sTGJGbTI4QjdGVkVJOGJV?=
 =?utf-8?B?c3lEV0s2V1p4aE5za3NvYWFOS1JQaDlYeCtLbjJoOFpmOE5pMXBLckg0cjFR?=
 =?utf-8?B?ZGlkSk1kVHBtS09uenl4Ulllck5pL2ZCNGhCZGJzV1JWc1c1bnk3Wk5ML2RW?=
 =?utf-8?B?ckN4K1A3WW9ha3NkRnhNeWE1RUpyTk5YOFpMN0dtclEva016dDI3aEZNcXlU?=
 =?utf-8?B?dnF2K005VXFOaG16NFZHb1FLaVFWSWlVMzQwYklwUXc4WWpidldHV2U0cTVq?=
 =?utf-8?B?Uno4ZzB4TCtaMWhqa2pwRGhKWDllMlNTeis1cTN0eE92OE5NVGVYWGVvSVhi?=
 =?utf-8?B?T2pWUi8rOG9yZUI1MkM3SWdoYjFDMHRzemhkYmYyYkRNZFZvU1pmZEUxVThp?=
 =?utf-8?B?S1plSGpMSE1FWVUyNnFPaXAzQjlUSWR1bGZPUHB3aXg4RVFydnVhOHdmbDJS?=
 =?utf-8?B?SDk2OE5KOGYvdnV2SCtXbmxUaFNRcVd3WmVTcngwcGZUUkg0YWtCekVGbVRN?=
 =?utf-8?B?bU1ScUJSMXQ1UllGWlhyOUJPSlVnU00rem5wUm50Y09HQkk1bUd3c01nNlp3?=
 =?utf-8?B?RTBtTzJJUlpvczVwQmUybm43dkhTcjNaTGlHNWdwN1FKalBmWFYvNSt3azEy?=
 =?utf-8?B?TzJxYjJadm5naVV6TTZZNHhycEdiS052R2Z1bk5WR0lyZ0tuVVdDL0trZko1?=
 =?utf-8?B?Ni93aHFnaHRqVE1NSlJsVSszTnJxUURqaU04Z1oyaktjMnIrVVRNU2N0ZGpW?=
 =?utf-8?B?MEt2YStYbWsrczRpczRYa2h0SndhSG1XdkhneWE5aE40dXcrb2ZRa1JQUk95?=
 =?utf-8?B?RU9CWXdValB0cG9hUm5wUzh5UDAwN1hmZTVQR21UblZFei9pYlRtMjN5c0l3?=
 =?utf-8?B?VWoyd3MwUVd4ZGVHd0FQTzdncjg3Ty9NR3hiOXhLVkI3ck9wdWNPVHdOQkYv?=
 =?utf-8?B?TEk4ZExCTmZmdVd2a05uN1A0NG1NbE93VVdvRFB0d0FBMy95KzQyZEtRKy9S?=
 =?utf-8?B?dHZPbU93ellpQ2ZZS25QeVZ3QVJWMEJRek5TZktvbzBDR2J6OVJhTmRTU1h1?=
 =?utf-8?B?K0t1Rkl0bUMyRHpST3paSExBa2FEMjJIUGlMVkppU2ltcFBTSWdlRmQzT2o4?=
 =?utf-8?B?QWg5dUtoY1dWdUhPMnk2MVFoNk1ZUWJ4WXhveWFtMGdoclVSeXQxWEJYendi?=
 =?utf-8?B?YnVDOTV6VEdkeWV5Und4OS8wRFdTbVptOEdNSGpzc1FlWkt4Y1RpbHRia3l6?=
 =?utf-8?B?YThydzI1VjErakhOZ01zSjFtNEcrYkJ6bDVQK1hNY3Y3Z2xoL21JYUdvelJs?=
 =?utf-8?B?NytzWGNOM0Fod0JPNzh2dmx1VmtXYjVQSkdrVDJWZENUQnFxd2I1dUNRZzNN?=
 =?utf-8?B?MjJIL0FKQll2RUp5UDltOFNVdkphTHhQOEVYMUMyNk1aNUEvUVVmTjdJSUp4?=
 =?utf-8?B?Yk5QcFB3cHAvZHZyYTJhbGdoNEFJOVQ1NEVXYVAwcCthSDcvanY5cFo4cmYx?=
 =?utf-8?B?eTQ3REp5bnovbS9qbmxxYW1rZm9RVXFIaloxc3QyY0tjSTRiT2J3bjVyam5T?=
 =?utf-8?B?VzBoMHk0OHRYSlJnalp3cHhnOEpZeDdFOFE3NnBzN3hudzROY2MwZ21jdjJm?=
 =?utf-8?B?ZUpBU3BPNWJKZkNYeWREZUh1bDdWM3p1aEx5eE80QUtueU0zMStWS1Iwb3FQ?=
 =?utf-8?B?cHk5UEEwVEZKb2g4dzcxMkl1cy9YMmVHeUhPSXlJNmhpRTVPMy9jbkpXeldQ?=
 =?utf-8?B?cXZZN1BOV1hnb3FwaHJpeEU5VmpBTTFFMXZRZnhja0xWVzhXU3BlczZZWGV6?=
 =?utf-8?B?MWUxMWNuYnlOb2psMXp2OHFIb2NZbzV0eFpVdnd3d3AreVNHV1c5alF1aDhQ?=
 =?utf-8?B?cyszVk9BSVFQTHBrKzlzR3h3LzFGNFFQeG5oMjJlOWRvUGtUY0t6Z2YySzVC?=
 =?utf-8?B?ZWxDRTMrRzVTRFJXa2NnNWExSWdyb2h2TXhqdmZMM3BFTk1lMFoxUWtKVkxW?=
 =?utf-8?B?dzFSR1lScGsyUGhKbU9aUERiNE83enlEa3ZVMTFaZ0l0Szg0cTd4aUgremFv?=
 =?utf-8?B?Rzdib2YvRG5LT0hQQW8wNm9aQk1EbDZIZVRPclYwNnBmQzMzVGJpUzdCRmVE?=
 =?utf-8?Q?+zRd0v13yxE/J+3GEKlUZwgPOMqd6P7TDliD/Pd09bg4c?=
X-MS-Exchange-AntiSpam-MessageData-1: GkVZhwVT4BSoFQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3041323a-1791-4719-114f-08de867b0986
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:13.3441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eP6HGDmaFvtf2eQjjPRtq5SvrzQ0KS0ImW8cLhkSU2qiK7CkacKcdSVBL7Y9TjPn0ivyK9/HOhIisaeQBst6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

Convert all GC6 registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs   |  7 ++--
 drivers/gpu/nova-core/fb/hal/ga102.rs |  7 ++--
 drivers/gpu/nova-core/gfw.rs          | 11 ++++--
 drivers/gpu/nova-core/regs.rs         | 67 ++++++++++++++++++-----------------
 4 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index 67edef3636c1..e52f57abc223 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -47,7 +50,7 @@ pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
     /// Checks if GSP reload/resume has completed during the boot process.
     pub(crate) fn check_reload_completed(&self, bar: &Bar0, timeout: Delta) -> Result<bool> {
         read_poll_timeout(
-            || Ok(regs::NV_PGC6_BSI_SECURE_SCRATCH_14::read(bar)),
+            || Ok(bar.read(regs::NV_PGC6_BSI_SECURE_SCRATCH_14)),
             |val| val.boot_stage_3_handoff(),
             Delta::ZERO,
             timeout,
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index 734605905031..4b9f0f74d0e7 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::prelude::*;
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
 
 use crate::{
     driver::Bar0,
@@ -9,7 +12,7 @@
 };
 
 fn vidmem_size_ga102(bar: &Bar0) -> u64 {
-    regs::NV_USABLE_FB_SIZE_IN_MB::read(bar).usable_fb_size()
+    bar.read(regs::NV_USABLE_FB_SIZE_IN_MB).usable_fb_size()
 }
 
 struct Ga102;
diff --git a/drivers/gpu/nova-core/gfw.rs b/drivers/gpu/nova-core/gfw.rs
index 9121f400046d..fb75dd10a172 100644
--- a/drivers/gpu/nova-core/gfw.rs
+++ b/drivers/gpu/nova-core/gfw.rs
@@ -19,7 +19,10 @@
 //! Note that the devinit sequence also needs to run during suspend/resume.
 
 use kernel::{
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -58,9 +61,11 @@ pub(crate) fn wait_gfw_boot_completion(bar: &Bar0) -> Result {
             Ok(
                 // Check that FWSEC has lowered its protection level before reading the GFW_BOOT
                 // status.
-                regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK::read(bar)
+                bar.read(regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK)
                     .read_protection_level0()
-                    && regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT::read(bar).completed(),
+                    && bar
+                        .read(regs::NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT)
+                        .completed(),
             )
         },
         |&gfw_booted| gfw_booted,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 4f5cd64c2fce..6f49467e78ec 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -198,29 +198,41 @@ pub(crate) fn higher_bound(self) -> u64 {
 // These scratch registers remain powered on even in a low-power state and have a designated group
 // number.
 
-// Boot Sequence Interface (BSI) register used to determine
-// if GSP reload/resume has completed during the boot process.
-register!(NV_PGC6_BSI_SECURE_SCRATCH_14 @ 0x001180f8 {
-    26:26   boot_stage_3_handoff as bool;
-});
-
-// Privilege level mask register. It dictates whether the host CPU has privilege to access the
-// `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
-          "Privilege level mask register" {
-    0:0     read_protection_level0 as bool, "Set after FWSEC lowers its protection level";
-});
-
-// OpenRM defines this as a register array, but doesn't specify its size and only uses its first
-// element. Be conservative until we know the actual size or need to use more registers.
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05 @ 0x00118234[1] {});
-
-register!(
-    NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0],
-    "Scratch group 05 register 0 used as GFW boot progress indicator" {
-        7:0    progress as u8, "Progress of GFW boot (0xff means completed)";
+io::register! {
+    /// Boot Sequence Interface (BSI) register used to determine
+    /// if GSP reload/resume has completed during the boot process.
+    pub(crate) NV_PGC6_BSI_SECURE_SCRATCH_14(u32) @ 0x001180f8 {
+        26:26   boot_stage_3_handoff => bool;
     }
-);
+
+    /// Privilege level mask register. It dictates whether the host CPU has privilege to access the
+    /// `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK(u32) @ 0x00118128 {
+        /// Set after FWSEC lowers its protection level.
+        0:0     read_protection_level0 => bool;
+    }
+
+    /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
+    /// first element. Be conservative until we know the actual size or need to use more registers.
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05(u32)[1] @ 0x00118234 {}
+
+    /// Scratch group 05 register 0 used as GFW boot progress indicator.
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT(u32)
+        => NV_PGC6_AON_SECURE_SCRATCH_GROUP_05[0] {
+        /// Progress of GFW boot (0xff means completed).
+        7:0    progress;
+    }
+
+    pub(crate) NV_PGC6_AON_SECURE_SCRATCH_GROUP_42(u32) @ 0x001183a4 {
+        31:0    value;
+    }
+
+    /// Scratch group 42 register used as framebuffer size.
+    pub(crate) NV_USABLE_FB_SIZE_IN_MB(u32) => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 {
+        /// Usable framebuffer size, in megabytes.
+        31:0    value;
+    }
+}
 
 impl NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_0_GFW_BOOT {
     /// Returns `true` if GFW boot is completed.
@@ -229,17 +241,6 @@ pub(crate) fn completed(self) -> bool {
     }
 }
 
-register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_42 @ 0x001183a4 {
-    31:0    value as u32;
-});
-
-register!(
-    NV_USABLE_FB_SIZE_IN_MB => NV_PGC6_AON_SECURE_SCRATCH_GROUP_42,
-    "Scratch group 42 register used as framebuffer size" {
-        31:0    value as u32, "Usable framebuffer size, in megabytes";
-    }
-);
-
 impl NV_USABLE_FB_SIZE_IN_MB {
     /// Returns the usable framebuffer size, in bytes.
     pub(crate) fn usable_fb_size(self) -> u64 {

-- 
2.53.0

