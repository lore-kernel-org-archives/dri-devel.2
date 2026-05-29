Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7696CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 07:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187C910FA1B;
	Fri, 29 May 2026 07:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dq8AEDgv";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BC410FA1A
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lwo0p1IEu8z2HMMxrPWQpKEkCRxMademV0NQBYY0x0bmqyT/hAjhlKMRrFfC2k+V2YW3cHFuZu1EzhmFpcB9W4BmdYVSiqwaFVMIDn2SU5ybD8gP4RKEMtBoJoN2IugHJl2n+7Gd/7OSI9SG5s5Q2nLTNfaI2XCGw27XHDy5MDWpEdrL+vlSm6mMf8cC/ImAEgapyD4UUBJYzJtA4h0Mts0kaRYemeBFQdEnD4r+zbClBISbFwWRJ/5BvHYrbfApyuukUmIGoKXhNcTqgFloD6d3rVyGoFQB+GjADcUpmg6BsIa/qrMUas88Mcogledgoz5xFROx6z/AtqES+kBPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3gHGI4pAwsSRBxToqmdEb0B7KkEXnp5IhM3GRi4ivE=;
 b=Os6eXNt1Jkk+a55IdHmHPnBYsrw3GHn8bBtvJl4QaXXIcNzlb7UrkcoeFJK4SFtOrWfQBP9EvWyCWo4qM30wntO4Vfxkd7mJZg78xoynEci3+AdPnPZIpy8Y8EkCP85jJ3w7kEiP5HeYXjmd5sfxnh2yAq+tYdqwSPaCAMyLDWhaMUSS8t5GtfasjvW3OwD48G6m/yr2sQNbi4mIZS3MZcBAE86p7s7FDBlhHjUL260z3mZvs/GT883/YVmoH7Yz8wiX6xB41HTF5nX7N9PnqU9IOjllEXozfCQiqv3p+Qljdgm6Ea5FD8B07BTLTqu9Hky10yG27O/x5k4GybCpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3gHGI4pAwsSRBxToqmdEb0B7KkEXnp5IhM3GRi4ivE=;
 b=Dq8AEDgvFtZRG49FALDIxM0HyB6CgvyHpv3+o06McEOBN53q1JRZ8uU9+0hpAtCrJ6AC5sARHhFUh5YQQsDr7xYh6RnRKHQ0cKBs9Q3CKVdgmvpN+lm6k4Ev9bQgoajuNTWjJi3xsxXTbu+RtjCVgq18T8e70KDL1scvG1+MQkGP0k6ah+bX8JdfqvPtxVKKxwSHc4agPM27LSSH7wB77RC4HsVKo3/5hH5RN/Sv05dqREBe7S7ijayNUKeNdWM0Mjpj/1LvUOLdZGtyF4uJrmQh1RSu7n3ls3SRKQT1f+UTFE0prfoj5nKXz9EsvormEqTpma5UUAyoija/k8NOyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Fri, 29 May
 2026 07:34:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 07:34:16 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 29 May 2026 16:33:44 +0900
Subject: [PATCH v7 4/4] gpu: nova-core: gsp: run the unload bundle if
 Gsp::boot() fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-nova-unload-v7-4-678f39209e00@nvidia.com>
References: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
In-Reply-To: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0832ac4b-78de-4b4d-469c-08debd54afd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: KdrebAVxLbOcQgXmzO8yzKta4cbYG6pbj+4tounpDTFSYOF7gvY4fwZqJ3jK0n+/4ry2WPGTlKYreBR/udP/O6zys5Lg07ImX4KgYTDmUgFEqk7jBPzSiqe6uMM/EbFGxsFC9GvtKX3Iz4EcVZ7/WFq7nXkdJFro27/O7QN+KfufacV4x739t5Y+m5PC0XL4pqn3IEnqtYhj3qTN46SU6SQn/KvGftGsDHT6tdBgYpb9jECn2xy1VgU199gFSJXBE/EqdMeqxbu8fzy4i59Siu35YgD9o/jCihD4kk+aKq187hF0dPHEoW8LLa2GQsGjmXJwMBI9dnka3suT4RALV+PXrPrJ/ulkxHKhKdw4uHTccYBHvdPY+Zs0lxska0FpOpg4DeJlaFFcBbtsFlcjgUWFRGGw+I498FftSvA91LNASMJx6/IbSnv3cryVCvu1VP9ZT5R6KkFgvRgXPgKWjYLQ3vuaL4yijpillT0NekUBEuoWccBjVwteQ7Ri7vdqt/xAS+Q0kyt6oTLufZ52C+QHCKZEuZZ064+qushvSQuXlPxvBl8xH2sbCutW6gMoefmw/30/Y5t708LtZjMoVqY3eIqa3KaRUq+Sun7xGCK+WVg89v+369R0psxmGoIuMi5iYI4U+SQ/RfK4wzn8xnO+P8kLAxSBaBCJ/a5YeMiBAmS1pW45RG5YwWjUdr7F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2QxbTV6Vy82WVlja2J2ckFjWjlYOW4wOW5uUTYzbWgyM1RIMVVOOTRNQnVs?=
 =?utf-8?B?d3VzZUVKU1VGY2ZMenJ6YWpuRG93TTlwSTN5R1VDQlJhSGRZcE5SVU9UUWRu?=
 =?utf-8?B?cUtTL1pIUFdDMlZJaGdlQjd5WmRxajRXVE9vWTRBZDcwQXE1K2NBNjd3Z3RZ?=
 =?utf-8?B?UUd1TEk5eTVNZUxVdDBWd0JJQkk5Q1hOV2NRRXJRWHdkU3k3ZUhWUW56K1ZX?=
 =?utf-8?B?aEszenkrWjdSKzFxajlsenhzZ29pbmpOaXAzdVJ1dUlvR1N1UFNnYTNDd0pX?=
 =?utf-8?B?TkV3QU51YWlCTmwzZ1NSZHRUVllkYjFQaXplK2FPL1ZSMjNMemJJcDBSK0NF?=
 =?utf-8?B?MVBnVDlVVllPUEE5VnV1cENrT09BSUVCT1ViSGY4eGc0RjdpZHFGQnlhZjk1?=
 =?utf-8?B?RGt3TXdDdHlFcExKL1NmZmZFZTdsMm9ZOVlRajg4b0Z6Z3kvVjgzcDMvc2Y4?=
 =?utf-8?B?bFBabHpwRzVva0d2UXZzcjJ0bzVVOW1mK3IrUXI1bzNUbTduMFZXSWw3dDY5?=
 =?utf-8?B?MGJiVGJQU3BRMnpGZlhUUGM0V043WWErcjQxWk8rR0tKbnovQm5rTFZNU1VL?=
 =?utf-8?B?Rmk5emxMd1lvUElJZGNRc0hoZFpuTWhKZkZiQmVNVlBxdHV1QXEvZ3FGYWVy?=
 =?utf-8?B?Znd6elgzMlRBYThjMTVyRXBYdFJoZVNOM09oVmRhWTdBZ3hMT1ZQTDhyRk9n?=
 =?utf-8?B?aWpOakR4bzJ6MkRzZlBTRCtDNHIyUXZURG1pcmhRWTVGYjNGOThZL0tHV29L?=
 =?utf-8?B?WHY5dGRMNG83d21EY1FOZWNXa2xKcmhFRE0zNXNKTGlkVkluVE9MZmpQT01N?=
 =?utf-8?B?UTFNdXg2Z1l0c1FHWmdEQ0JjUUFRekdqY0FSbEs3OGZEWitYUDRxUHZoaHpv?=
 =?utf-8?B?V2RoOS9GTTkxaEhueFh5WHZCQkI4NmZ5dUROQU5PeTdCaGJoVTdXdlNkZ0Ux?=
 =?utf-8?B?UXIxdktUZmc0MGNMcHFOZjdPN1lwWVJIQjEzUTV2aVBtMFNRZjh1UkwzVEdC?=
 =?utf-8?B?MVgvNU9ZVjAxejVOSEdpZUxEL0ZqK0lybHpjdUNmb3FQdU1SZktSNE9zZC9z?=
 =?utf-8?B?Z0g2ekdCU05QNVVYUU9XYkpFbW84Tm5SNFBiTms2UXNIK3d5Y1RHRExnRm04?=
 =?utf-8?B?ZjBZallUQ3YybGxzQ0pvMjVabDNkN2lBUFFSeDlRVFRnMW9uNzhjVWR6cFFF?=
 =?utf-8?B?SGJHaE1rMkVLN0pNN1VrdFRBN2ZWdWJSS3BWK0Ezck5RVzFvVXVqMm5wd3Va?=
 =?utf-8?B?bnZTMThCaDM5NnpSTzR4T1IzbHdJeTJnZVJQU3NKVkk4ZHpNbTl6bFU1WHZ1?=
 =?utf-8?B?ZStwOUtsc3kwY0Q0UmVPckVFS0ZZYTRMUjVFOE9UMXpYcmNacklNNDh0Q2Y5?=
 =?utf-8?B?T25sN3g0QkRwM0tUZm16WWFCaStOOW9WS0tXak8yL1ZCUjArWGJIS2llYUhF?=
 =?utf-8?B?RmtyWmNQbHBaK1kxQlVaUjM3cVlhdEoyVS9iSWNqT1FZcWphYnIxRFM1N2lR?=
 =?utf-8?B?ODF3aEd2OFlwK3lDS1RBbDVmQVhqb2tjNXlnMG1xVVNBQ0hVZzZkVjIveWlY?=
 =?utf-8?B?VWgyQi9VeU5KMlptZWZoRVNsTDNja1MrRmxSZzBvUTFjaEJkd2p4OFhOdnYw?=
 =?utf-8?B?djdpZWFPUWFadTA3UmdwWkFSQStMbDJ3ZHBBdkxYS1hpVnd6aExYWmpKSlRx?=
 =?utf-8?B?Y3hzY3ZrRU5NVS9GTkNMVlkxL2NLV0pBbkc3Y1E5ZzhuM2wzQXRZZzZKWk1q?=
 =?utf-8?B?c0JHRG9tQzdEc3JUYmtDUXRzeWpubEgyeWVza0xiZGtzVFFYVDdCZVVGc1Jh?=
 =?utf-8?B?MG5FUXJPeHBOMU1NNi9KZlBDMEJIR3lDN1BiZHE5YVI0VC8vbkZvVENCYVp1?=
 =?utf-8?B?cVNGS0lXWWZVenVtaDhtUVF6OGRHcENyU2pQVk13cE1UUWphZVVDZlUrQUpG?=
 =?utf-8?B?QXpIMExZeVNqSnFpOG1qMzUzajFKeG03OUw3UTk3dEtsVktRVGdrb1gyblg5?=
 =?utf-8?B?UzFZUTVVSnFmQkdVVlNDcFQzV0lXZDRaeXpxL0d0SG9yeWwwWEthLzBsL0hm?=
 =?utf-8?B?QWxsZ002dU9aSW9SNGozYjloYm1la1NMUFIxbzJTZ1haVWxXZm1ZdWtkVFdZ?=
 =?utf-8?B?OFRUM2dEdWVSaXh3aTA5dHRXMHphcVBoRmVyVTh1M3orK3N6OGxUWnBTYjlo?=
 =?utf-8?B?Q0lZd0pVQmE4dVdqZlNVODJkdmk0V0JLUXZaUU9vVlY4ZWFBd3E4b1FlUTRs?=
 =?utf-8?B?TmtWemQ0SE5VVTVuR01xekUyK2Q4YldObWRRSm1MRUM4RXVzK2dwb25KajV1?=
 =?utf-8?B?alQwakFKLzZFa1FHN2wyY1FXYlpjNlU4allzc21tVlZBdHRVZWN0YkhWQ2ZF?=
 =?utf-8?Q?NBZ7a06QZ48R7NTqx6Pp5VRfgCmTJqDu6TWsR2j2fzUws?=
X-MS-Exchange-AntiSpam-MessageData-1: JG8+EvijQwVXtw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0832ac4b-78de-4b4d-469c-08debd54afd1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:34:16.1576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PoXZs6FMaBiOIOoUvpLoER7OPlfPOkE4/4WO4Gk4NB558SFVDIWsalKZbsJZRC8Pg2R35h8cKldtvV/UJc4jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

If `Gsp::boot` fails, the GSP can be left in a state where boot cannot
be attempted again unless it is reset first.

To avoid this, we want to run the unload bundle whenever `boot` fails to
try and clear the partially-initialized state.

Do this by wrapping the unload bundle into a drop guard up until `boot`
returns. After that, running the unload bundle becomes the
responsibility of the caller.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 67 ++++++++++++++++++++++++++++++++--
 drivers/gpu/nova-core/gsp/hal.rs       | 19 +++++-----
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 15 ++++----
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 31 ++++++++++------
 4 files changed, 101 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 8d6fcc35b653..1f83f63ceeb0 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -8,7 +8,8 @@
     io::poll::read_poll_timeout,
     pci,
     prelude::*,
-    time::Delta, //
+    time::Delta,
+    types::ScopeGuard, //
 };
 
 use crate::{
@@ -31,6 +32,66 @@
     },
 };
 
+/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
+///
+/// Stored as their own type to avoid repeating a long and tedious list in [`BootUnloadGuard`].
+pub(super) struct BootUnloadArgs<'a> {
+    gsp: &'a super::Gsp,
+    dev: &'a device::Device<device::Bound>,
+    bar: &'a Bar0,
+    gsp_falcon: &'a Falcon<Gsp>,
+    sec2_falcon: &'a Falcon<Sec2>,
+    unload_bundle: Option<super::UnloadBundle>,
+}
+
+/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
+/// [`UnloadBundle`](super::UnloadBundle) when dropped.
+///
+/// Used to ensure the `UnloadBundle` is run during failure paths.
+pub(super) struct BootUnloadGuard<'a> {
+    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
+}
+
+impl<'a> BootUnloadGuard<'a> {
+    /// Wraps `unload_bundle` into a guard that executes it when dropped.
+    pub(super) fn new(
+        gsp: &'a super::Gsp,
+        dev: &'a device::Device<device::Bound>,
+        bar: &'a Bar0,
+        gsp_falcon: &'a Falcon<Gsp>,
+        sec2_falcon: &'a Falcon<Sec2>,
+        unload_bundle: Option<super::UnloadBundle>,
+    ) -> Self {
+        Self {
+            guard: ScopeGuard::new_with_data(
+                BootUnloadArgs {
+                    gsp,
+                    dev,
+                    bar,
+                    gsp_falcon,
+                    sec2_falcon,
+                    unload_bundle,
+                },
+                |args| {
+                    let _ = super::Gsp::unload(
+                        args.gsp,
+                        args.dev,
+                        args.bar,
+                        args.gsp_falcon,
+                        args.sec2_falcon,
+                        args.unload_bundle,
+                    );
+                },
+            ),
+        }
+    }
+
+    /// Disarms the guard and returns the [`UnloadBundle`](super::UnloadBundle) it contains.
+    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
+        self.guard.dismiss().unload_bundle
+    }
+}
+
 impl super::Gsp {
     /// Attempt to boot the GSP.
     ///
@@ -59,7 +120,7 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_bundle = hal.boot(
+        let unload_guard = hal.boot(
             &self,
             dev,
             bar,
@@ -99,7 +160,7 @@ pub(crate) fn boot(
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
         }
 
-        Ok(unload_bundle)
+        Ok(unload_guard.dismiss())
     }
 
     /// Shut down the GSP and wait until it is offline.
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 501b852dcb29..88fc3e791114 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -25,6 +25,7 @@
         Chipset, //
     },
     gsp::{
+        boot::BootUnloadGuard,
         Gsp,
         GspFwWprMeta, //
     },
@@ -50,20 +51,20 @@ fn run(
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required firmwares as needed.
     ///
-    /// Upon success, returns the [`UnloadBundle`] to be run (if any) in order to properly reset the
-    /// GSP after it has been stopped.
+    /// Upon success, returns a guard that runs the GSP unload sequence if GSP boot does not
+    /// complete.
     #[allow(clippy::too_many_arguments)]
-    fn boot(
+    fn boot<'a>(
         &self,
-        gsp: &Gsp,
-        dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        gsp: &'a Gsp,
+        dev: &'a device::Device<device::Bound>,
+        bar: &'a Bar0,
         chipset: Chipset,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
-    ) -> Result<Option<crate::gsp::UnloadBundle>>;
+        gsp_falcon: &'a Falcon<GspEngine>,
+        sec2_falcon: &'a Falcon<Sec2>,
+    ) -> Result<BootUnloadGuard<'a>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 0a8b7f763883..9a4bb22578b3 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -18,6 +18,7 @@
     fb::FbLayout,
     gpu::Chipset,
     gsp::{
+        boot::BootUnloadGuard,
         hal::GspHal,
         Gsp,
         GspFwWprMeta, //
@@ -31,17 +32,17 @@ impl GspHal for Gh100 {
     ///
     /// This path uses FSP to establish a chain of trust and boot GSP-FMC. FSP handles
     /// the GSP boot internally - no manual GSP reset/boot is needed.
-    fn boot(
+    fn boot<'a>(
         &self,
-        _gsp: &Gsp,
-        _dev: &device::Device<device::Bound>,
-        _bar: &Bar0,
+        _gsp: &'a Gsp,
+        _dev: &'a device::Device<device::Bound>,
+        _bar: &'a Bar0,
         _chipset: Chipset,
         _fb_layout: &FbLayout,
         _wpr_meta: &Coherent<GspFwWprMeta>,
-        _gsp_falcon: &Falcon<GspEngine>,
-        _sec2_falcon: &Falcon<Sec2>,
-    ) -> Result<Option<crate::gsp::UnloadBundle>> {
+        _gsp_falcon: &'a Falcon<GspEngine>,
+        _sec2_falcon: &'a Falcon<Sec2>,
+    ) -> Result<BootUnloadGuard<'a>> {
         Err(ENOTSUPP)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index c4ab081f25c4..6a27e7e90279 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -32,6 +32,7 @@
     },
     gpu::Chipset,
     gsp::{
+        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -254,21 +255,23 @@ fn run_fwsec_frts(
 struct Tu102;
 
 impl GspHal for Tu102 {
-    fn boot(
+    fn boot<'a>(
         &self,
-        gsp: &Gsp,
-        dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        gsp: &'a Gsp,
+        dev: &'a device::Device<device::Bound>,
+        bar: &'a Bar0,
         chipset: Chipset,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
-    ) -> Result<Option<crate::gsp::UnloadBundle>> {
+        gsp_falcon: &'a Falcon<GspEngine>,
+        sec2_falcon: &'a Falcon<Sec2>,
+    ) -> Result<BootUnloadGuard<'a>> {
         let bios = Vbios::new(dev, bar)?;
 
-        // Try and prepare the unload bundle. If this fails, the GPU will need to be reset
-        // before the driver can be probed again.
+        // Try and prepare the unload bundle.
+        //
+        // If the unload bundle creation fails, the GPU will need to be reset before the driver can
+        // be probed again.
         let unload_bundle =
             Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
                 .inspect_err(|e| {
@@ -279,8 +282,12 @@ fn boot(
                         "The GPU will need to be reset before the driver can bind again.\n"
                     );
                 })
-                .map(crate::gsp::UnloadBundle)
-                .ok();
+                .ok()
+                .map(crate::gsp::UnloadBundle);
+
+        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
+        let unload_guard =
+            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
@@ -311,7 +318,7 @@ fn boot(
         )?
         .run(dev, bar, sec2_falcon, wpr_meta)?;
 
-        Ok(unload_bundle)
+        Ok(unload_guard)
     }
 
     fn post_boot(

-- 
2.54.0

