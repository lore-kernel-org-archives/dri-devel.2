Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1544C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DC710ECC4;
	Wed,  5 Aug 2026 05:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VSdf9G/X";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D6010ECC4
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIwCP3grRwwkIFZjTshCrnaB+gUVtqR1RVUeZsiJk3gGJ59tNdTy0EyndEYj9D6s4cV9tXL4qdaJq2Wwj87JTfCnahXYvtAZpZTIYljjrIy16QB9AoI0cEipNvtNRLUIrEZSiFs6rwWvWiGOa8ZNv+3hWUgHAJnKVijAE00Z3xaduIdct321Bv2SNyYEo7XnoJuOLnD9Dk+dGYKPHC5VizpswwM++gMRedT8E3IKwOnZnlu0T4uVau5re1/tOdTlisN0fXOt05RrJ8n+dzBK1605uDj5Za5gJ3YdMSFg444LuDIO+UmjzBZi67Ak99jfT6WJlWxc9CDjRqJgAXlCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqfgYyU/GpaAmC3423pZOAtihrlCVfpnwE+RCGpNNVA=;
 b=pNPbzLk//skpzA4hSlqONbJT/9t4WAbFaZpnkI0bUe1Z6AaOSj2oW4lfE0mdvkdHkJ/EsfCLXUJOyl2VT3zj1xH6rNaWc+mkahimX5bcFY3mAMqLao1AiAboh8YYz9Ulm5aPUWNf8jDE1WpWxzGjapduJASXQ9v4ZG1kg2pyCfZ7QOMOKqEoMlQvI9/Bthaq91wHqUN8gjD5ElApf9xwa+iY2OPIWT97N78hhpO58x9P1v5jlSjZ/rfn5LGoaIAL3Kssb2XGOtBq+DK66eUwhcvIvChlI4Trt5hRSuP77rk+/a7zTLeGx2wttpPfAGF9IwcGviMul7fPfa/ZG9rZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqfgYyU/GpaAmC3423pZOAtihrlCVfpnwE+RCGpNNVA=;
 b=VSdf9G/XAn7mkNFoirV34h9KgIH1+tYZSC8M3U9KyKjcFFIjBGAlvpk8MJ3OxGEx0JZgQL4ZDQYNHv+SNPyIOy2WqVkgxsvqNfNH1A90lGAatd1k65hQzaiOmb9FLEqxGuHruLzpz9FdIkonDsubcHZ0YWIR2k9Uy+LUCumPVSOr5S73/FsvUZ4vIeWW8zwZD7oS1cwmGFWWZESfr6I8DkHdptZwFEGJ0y293Zci/pZ+PTULqV1To8j7pmW8qhiAaCFoIFIxkwya0PW17G59GH8D+9T70MyLmzXN5ChMRVDpjTMcOHTgUuOuWv7WRySk3pHz2077zoFzDrD6g+bjzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:39 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:39 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:54 +0900
Subject: [PATCH 07/12] gpu: nova-core: mm: Add the memory management HAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-7-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::17) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fac1a2-5ca1-45db-cfdf-08def2b4c787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D5KAa0rl8wn/zaR4U6aUyUwXr2iRXgWPpqNrN6pgNM5Ie3TQh51A59MB1m0lRcD7ljEYzhwKshpn3WPoTkE58bfz/aKgxcbzt36jV4LqtLgTGDU0w0BN+ZxSj2AlCM9PVzI3+rScuP3dJGpq3AHvCyEQGvPBvHVqrGFyfQnkkRxrj/JYa7cNgGUSTodZWWY4CKrqVvS68KW2Je3sNL8HvT/1iqNPh5FC5sOC7Wp0d4Ao897entrRM9Ky1B/87cBrEbPGbtCweXJ0i/H2IpWGx0/gMUPPLkcfDcWvQIjF5WcRxgm1kP0xwANMTxXVPorciEwyGatsS5xnMT59vTTmNAczGINFfR3QW7vNJHOGVX3/tYZRhGpTGYeTJWKAz3mZR0k9bvnwCN2/uT3v/8vAR4F9iMYTANhedmOJah68Fr0Xi2gZCPI9ukX3/efsrF5knMud+gZfEcEMmGDjx5cgQHV1Z5BzLBmTFkA5GuqSFyPIYqDyIuAdPeCVsLv8amd7xFdUaj7yoyELYbB8t1Q2VSGxVoistp0xsP/W+Q7bvGr3QTyLphWfbJBBB01HfA9+AJ/YKV2JbRJDqz5PfGN/TIuFmokoZvkoYL0aSEA/cnBeHznX64rsAa1ZztLIHz5P3+0fTqJwrVECequItArPTrWwfWh3jE4FJZSnmKw2v8MtI3TvqLlyRbAytDc70JNMeyj7WUctDU8q1AXrSsx40w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpEUXEwTnlLWU91VDlZRVhwcytja1JHc3hXTGQ5QnViN0k4czhNdXZzaGFx?=
 =?utf-8?B?ZnpKOHY4a0lRdXZ1Q2gvdzlzaE9taDdEeUdrVGIrWDhXUU8ydU9mcTFJRmFI?=
 =?utf-8?B?OEIxT3ozYlpHZDNRZkxRRnIyaFlzbWQ2eEh1WmdueHdQcFF2cmtKZUJhMDFO?=
 =?utf-8?B?d002V0RkR0xpSU00em55ckZBWmw3SDZKdlNJMWhvbUwzR3J5Q1RKMkFENVc2?=
 =?utf-8?B?eExZd3VVZ0RYWFJVZEd1bndlaWV1bkZxcTE5cnpuOEJVUmZ6UXU1MU5XdTgv?=
 =?utf-8?B?QXJTV2JxQkhFWVpDd0VDS3ZBV2xFd2E1TFVjSVAwRzBVcnZaMkwzYzE3RnNZ?=
 =?utf-8?B?cmM0UGEweFEzNG1mSzJqSTNtcHF4dXVRb1JxUFZ3NTkvbWhZQVpWaTBxWlFa?=
 =?utf-8?B?VXdKZlhqbDdZNHN6aDlFQUMvaDZTZlkzNnBIZU1LM3pYL1Z4c3hSVkJVYlQx?=
 =?utf-8?B?SGxkbFpsOW01Uld6N0xueUJNVjFPVUtOYnh4Uzl2MXRIc0wxUTlMNUpYQy9p?=
 =?utf-8?B?Z1JLU0RaMVErUi9IeUZKOUpHbkcxbUxqcVRmU213RHFPUnNkVmZOWSt5emNV?=
 =?utf-8?B?MzNaWGlnVGRPMjBCZitEMzlmNkpxbld1ZGxuMUNpTUN0T2dmRzl4cHcvVTdB?=
 =?utf-8?B?M29qR3FabTFlNDlxR1RjVFhEd3ZQaXlWTnRaWHIxR0FYdVdOb0dZMXJvc1BJ?=
 =?utf-8?B?VnV4Vms0OEh3MUdWR0xIQVNQanhQOFgvK2swWWREdVlncXpOQVhOb3dGQXoz?=
 =?utf-8?B?K29yaFJJaGRieTVkc3c2UEJiWHpDT2VtSUxmL015UVNIdllNNUhFNm9HQ3Z3?=
 =?utf-8?B?MWZrRUx3dHFqQUtGT3FBdnpMbjc5T2dmNEtkOS9tc3ptaUp1ZDB4ZEw3S2Fj?=
 =?utf-8?B?L3ArUDVvSC9ZdE5sSS9CblJoVWNmcTAwNjVLQXRlbEZ4Vm1CMTNlMjY4RjFa?=
 =?utf-8?B?NGwydTBUazJSaFlHQ0gwMGIzTktJT0dIWlZ2aFdwNjdXSUdrRFZwYlc3cXBJ?=
 =?utf-8?B?UnI5eFlyT1owQmR6VnFPYUtJL0lmZ3NZeU5IblhRL2JKV1hla0tlK3BpVlRs?=
 =?utf-8?B?Rys4c0xCQjZPT0FEN0RHeE9ray9zNnBFSHNVY3FkdUJGRzZoakxsNkxLWnVW?=
 =?utf-8?B?MHQ4NDBoN2dQdjFTSlpDQllPOVJiSzZQN2VJVHgrMWZXempKd0FzbkFSY2xl?=
 =?utf-8?B?MEUvd1lad3RTS0J6UUtxc0s4MEQwTEZIREhncjY5UnAwa1d5djJybGYrK2pk?=
 =?utf-8?B?eHF1Z3pMdFhwM29ZV0FOV2NhWXBOTGZVUjdVWXNKaTlpeWM5cTZPNEhUZjVZ?=
 =?utf-8?B?M2VoRktKWVlXNzJSYkZ5YVJmdjQ5aXNnd3JuRXltY05xaXlwWnR5b0I2WUZi?=
 =?utf-8?B?UUoyQ0RmRHlJTzlmM0FEN3FSWnRsY1hKb2xuZno4THA2RUo4d1ZXbFVPY1pk?=
 =?utf-8?B?MWN2VFVKc0htMFJMU3RDMmM5UG9LRitHTjVVRThoa2d2bURHRUVTTENONGN4?=
 =?utf-8?B?bXpHUTJCN3BTQ1FSMjlQTmtQcGxlTTc1ZXFVQVNKOWZqYUV5OThESkNQeVhl?=
 =?utf-8?B?Q2dBakZGaTZGc01YTzNaL1d0NlRGQzNmQnFkWHAwNkN4d210aHBQUzdLRVZm?=
 =?utf-8?B?YTN4YWk1Ym85RG5ZS2tTLzZBTjVoMU03RDZuemZOc2NnWDFyUCthVTlIeEFN?=
 =?utf-8?B?ZU1vdTkzcWFVRC9RUXlZUFp5Y2dmenh0NDNiYUpDeWR2MTVPamYrQVNjbjE5?=
 =?utf-8?B?MkFwMmFGOE90eG5teHgyK3BkRWNHanhzbmt2dFJGbEZRRUtLVy9pWUMwT3gy?=
 =?utf-8?B?WnJ5RjhnVkoyS2ZkOGtIa09iNHN2RlJ0M3kvUVhiSkNWemczUCtrczJnMytq?=
 =?utf-8?B?RGthTldEQlFrRW5FMktxM0pKc2ZyU2N2RTlVcEQwSTdjSlFxblhGMVI1N0d1?=
 =?utf-8?B?bXYyMnVxY0JEaGVzQ2tVQlByMURzakpHdENFdVN6cFNDWC9pYW5YUHFJMzds?=
 =?utf-8?B?dytiVFo2RTVCRjBCWjFSclE4YS80U3BoaEx6aDRLZVduNzhaMnRNeDQrWU82?=
 =?utf-8?B?aUdWZ1JCOEZsMzc0Nm1qc1ltRzlKSklUSkQ4SjY3MW5pbzdwN20xeVpwUlFr?=
 =?utf-8?B?azZiWngvQUJ5UEYwTDZiQ3FTRkRHQmxKdXlBajhXRlVhdWdidWxMNjJlV1JX?=
 =?utf-8?B?SlU3M3FOTXRQMUgxMHVVckpoZ0dZbCtLRmhCQ09oZzFvVnRWWFV0dzBkbkVB?=
 =?utf-8?B?ak53TkNIUDRoQjBqeHJBL1k5YnRPcmpSczRyczYyYmJBbFI5My8zeUxxNWtr?=
 =?utf-8?B?UTVxR2RjUUNyMFYyWjJVYUN6NDlmRFdmTFdsbFN6ZnVuRWdzK1hneHVlYVNR?=
 =?utf-8?Q?UPim8M81dQhG11s/Mwf8CMtOButj9+8pj3EMSFTvptto3?=
X-MS-Exchange-AntiSpam-MessageData-1: cep7QaiUOigSFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fac1a2-5ca1-45db-cfdf-08def2b4c787
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:38.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTexD6DCBd/qt17E7xRNqjvmtctFUG2VOACw8XAKey/BPZl5qyXuHlwftRt9rhaS+Pow0Ws/R13G3H8hJqSO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

Positioning the PRAMIN window requires writing an architecture-specific
register: `NV_PBUS_BAR0_WINDOW` on Turing, Ampere and Ada, and
`NV_XAL_EP_BAR0_WINDOW` with a different field width on Hopper and on
Blackwell.

A `MmHal` trait with one implementation per hardware family hides the
register choice from the rest of the mm code, matching the layout of
the driver's other HALs.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs           |  1 +
 drivers/gpu/nova-core/mm/hal.rs       | 56 +++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/gb100.rs | 35 ++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/gh100.rs | 35 ++++++++++++++++++++++
 drivers/gpu/nova-core/mm/hal/tu102.rs | 37 +++++++++++++++++++++++
 5 files changed, 164 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 7d24ad790310..07dce4ce2473 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -19,6 +19,7 @@
     },
 };
 
+mod hal;
 mod regs;
 
 /// Physical VRAM address in GPU video memory.
diff --git a/drivers/gpu/nova-core/mm/hal.rs b/drivers/gpu/nova-core/mm/hal.rs
new file mode 100644
index 000000000000..e7fd1e38bd38
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal.rs
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Memory management HAL.
+
+use kernel::{
+    num::Bounded,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    gpu::{
+        Architecture,
+        Chipset, //
+    },
+    mm::VramAddress, //
+};
+
+mod gb100;
+mod gh100;
+mod tu102;
+
+/// Trait implemented by per-architecture MM HALs.
+///
+/// `Sync` is required so that the `&'static dyn MmHal` references can be stored in `Send`
+/// structures.
+pub(super) trait MmHal: Sync {
+    /// Positions the PRAMIN window at `base`.
+    ///
+    /// This fails if `base` is not aligned to the 64 KiB window alignment or is too large for
+    /// the receiving register.
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result;
+}
+
+/// Returns the HAL corresponding to `chipset`.
+pub(super) fn mm_hal(chipset: Chipset) -> &'static dyn MmHal {
+    match chipset.arch() {
+        Architecture::Turing | Architecture::Ampere | Architecture::Ada => tu102::TU102_HAL,
+        Architecture::Hopper => gh100::GH100_HAL,
+        Architecture::BlackwellGB10x | Architecture::BlackwellGB20x => gb100::GB100_HAL,
+    }
+}
+
+/// Converts `base` into the value of the window-base register field.
+///
+/// Fails with [`EINVAL`] if `base` is not aligned to the window alignment required by the register
+/// field's shift, or if the shifted value does not fit within `RES` bits.
+fn window_base<const RES: u32>(base: VramAddress) -> Result<Bounded<u64, RES>> {
+    const WINDOW_BASE_SHIFT: u32 = 16;
+
+    Bounded::<u64, 64>::from(base.into_raw())
+        .shr_exact::<WINDOW_BASE_SHIFT, { 64 - WINDOW_BASE_SHIFT }>()
+        .and_then(Bounded::try_shrink)
+        .ok_or(EINVAL)
+}
diff --git a/drivers/gpu/nova-core/mm/hal/gb100.rs b/drivers/gpu/nova-core/mm/hal/gb100.rs
new file mode 100644
index 000000000000..3781e143dea7
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/gb100.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Blackwell GB10x/GB20x memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Gb100;
+
+impl MmHal for Gb100 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::gb100::NV_XAL_EP_BAR0_WINDOW::zeroed().with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const GB100: Gb100 = Gb100;
+pub(super) const GB100_HAL: &dyn MmHal = &GB100;
diff --git a/drivers/gpu/nova-core/mm/hal/gh100.rs b/drivers/gpu/nova-core/mm/hal/gh100.rs
new file mode 100644
index 000000000000..8af384db2921
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/gh100.rs
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Hopper memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Gh100;
+
+impl MmHal for Gh100 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::gh100::NV_XAL_EP_BAR0_WINDOW::zeroed().with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const GH100: Gh100 = Gh100;
+pub(super) const GH100_HAL: &dyn MmHal = &GH100;
diff --git a/drivers/gpu/nova-core/mm/hal/tu102.rs b/drivers/gpu/nova-core/mm/hal/tu102.rs
new file mode 100644
index 000000000000..e4fe7561223c
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/hal/tu102.rs
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Turing, Ampere and Ada memory management HAL.
+
+use kernel::{
+    io::Io,
+    prelude::*, //
+};
+
+use crate::{
+    driver::Bar0,
+    mm::{
+        hal::{
+            window_base,
+            MmHal, //
+        },
+        regs,
+        VramAddress, //
+    },
+};
+
+struct Tu102;
+
+impl MmHal for Tu102 {
+    fn write_pramin_window_base(&self, bar: Bar0<'_>, base: VramAddress) -> Result {
+        bar.write_reg(
+            regs::NV_PBUS_BAR0_WINDOW::zeroed()
+                .with_target(regs::Bar0WindowTarget::VidMem)
+                .with_base(window_base(base)?.cast()),
+        );
+        Ok(())
+    }
+}
+
+const TU102: Tu102 = Tu102;
+pub(super) const TU102_HAL: &dyn MmHal = &TU102;

-- 
2.55.0

