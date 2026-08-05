Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1240AC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D64410ECCE;
	Wed,  5 Aug 2026 05:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ok/XCmMt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43C310ECC0
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:46:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmETxbATtkeNqYn4gP1VI0zdaw2cjkIKU76HLb9VX2GgYLYzjF+BSdFD5qF8WlcneIEaPAvwNdFK1H+UyStexMyrC2ulKTR/SYhwqoYLCSrIpNOCcSs3EJhiL/hzxAgL+w2bou6bV0vSvh5otSuz2fuc1fQmE9LwkyKZQ4wyLBqNzTZDSTJA0gHhBZYuu42Ep4Z3jpTSkpTXoFSLyb4VpK/F0V9U0M/4b6tlWq49fKbv9wjFgQ4VMbmJgGkFh4xJriR3vqWZ2iVhNuTAcLjV++6b1RAPX1Q+Xxe+IZq34WXGDVXJQ0nbN3uHf9TFyjvgg/7G+oEVJ5fzVvLamrO7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cjmx0OTVxg3tcH7vjtbAl2D8da1oKs7y0n9wr3tw2eo=;
 b=RBKHTN9Lc0UU1s33+RabHeD64W9w6pxWBHd5ek8ER+SKMxdBrK/AUbs3qE9BjBE5wI11AMhV+UkaliVtYkNlQZTD2uezlzRaGqIQLpP9Jpufh5pvWIO/UjqvcujDdpxkc54Wv2sbk9Tk5iL/0tt7M014+CCXJYDEhnz/M2pOkwgOnEXV187vAbNIFWIMyot3/teimFUrZLuCUtYAXtgDSYI1HmGCkyjU9n82e/FqVnA2bbjDxxQl15Uyxf0sNdiAf9oVHyPuB6bAA3dsmuPl1N6wicc5+/Yv+pERqdbltKd4TTrfZACKxjF5r2NfUwEi2xBJ0goTnJgJvS5VelxZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cjmx0OTVxg3tcH7vjtbAl2D8da1oKs7y0n9wr3tw2eo=;
 b=Ok/XCmMtDXZpphXSczese8etY5xPqB4u6NcyXUle5E05RXym1j4Sl/Tm+aZ9vnmHF2qERGDUHQ1gYD7zAdXyWbaAoNc/2jx54BrxTIvT048HbRqE/It23kx19v1LQFB+CnYRmWmofb+auqeMB0hYCZLWBRyJgxaL4ue7p4pA43QnJvgS5X1ASIFOHJOoiu1Lg9hJOwuJSHckFHiZQgC982TFwJOibE5xDMW3gVSMcvWSBt74m3Giqfch6EsAEBsn5Ukkj2oE5UkrPuZizkjM8sG5mMoG9lng1tgyuz0zDhrVGXxq7ZJL3lkpcxey6SwLIkKqyHM26r0rLXTGvswjiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:59 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:59 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:59 +0900
Subject: [PATCH 12/12] gpu: nova-core: mm: Add PRAMIN aperture self-tests
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-12-ff3e84a75dac@nvidia.com>
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
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 3007fa96-4e06-4696-5c13-08def2b4d398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|3023799007|7136999003|10067099003|11063799006|56012099006|921020|11062099010|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y9d1l1wnvbcNtkcvEcDsKyAgzDL4kQQ/TX4tZE4qh6BfmwGAddYNVjTH2FMij1+Kevgl73GEJ7xkXitNA/cV6/yjgt6O+XRRKjTeoz/pBAiLGWOwOmCl+XLzxI8eWUVu1WJel8FkpJgWINgsilrY6p2Q9TrdIlitt7JqXpLg+Awi570jjhU+zGDORyGOadFBDQRei8Ikw/MybTy9Hj/Nrbr/Y4QRCvUMlEC473twvy1QUfND5bSr1agWxcth90PxOPn3qvoiH8/La7dwswCAa/mrmHLYQikw2rIrWKnzpLwPTnBXdABt4J3yzI13JJgtPoR4UoBTdlFqY1TcQ8GhaNuFjm46BlmQN9ThlnEHB2lGSsSIlv+qv22csv8qO4YIFlOkXOnH3eSq/nJRQXR9Ip+Rl6Y9ygLg7O/HRNE3NVt+hS7w3NfQdKuLuWDA8a0iIfBfcRFDoFnGW02ZILNHhpSz/C6773CcMi4bMVz/+fZBSoOBqXhStOmoExLI4vzGYl1bqClUbficliKivpw8QujQ3Gt6CV36QDFAEiKJ/C1H9W4ZkeYVkLAEKoriCS2HNfjcOYVbs/WekhyJPZcaLtSN+ZTNjtG9c5OqfOz1a/Q6ntgw/ak6+xbMD1uZYLmQVHI4OeG8i2ptRPlvOU3ClTm0lff4PR7078rTEAYLhfQUm6KT4OT53Coy3V9/D2hFdQgc/NCJxNdrhmLLkZa/Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(3023799007)(7136999003)(10067099003)(11063799006)(56012099006)(921020)(11062099010)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWVDK2RjY3BML3FVMmhjZHV6YncvSE1CSDNKaG03TnZXck5vZHk0anFkMGpN?=
 =?utf-8?B?dFhjYXp0eHZHV2hWWldKODZlKzdpWVlxL3AvUTVNT0g5ZDFuZnJTaVB2MHEv?=
 =?utf-8?B?V1dPcGhmWnNjTzA0T1hleDhhUzlKR3R1R09pSXh3T05jRldiNEJ1VnVJV2dn?=
 =?utf-8?B?bzFybUVsRmJ1Q2Z4ZzhaczBvbkVUZkNPRHdUWjVCTGpmZjB6U0lMU21MbnBq?=
 =?utf-8?B?b3NsMW0vRHJ5WStPU1dvZWgrbUEwVXgxencwc3RrUlhmYmd2dHk2anI0bVRa?=
 =?utf-8?B?QlZVNDhiM3A2T3Q3QmRrZEZXNVFOeEdmWWVQaE83cHg2TlJwVmF2ektNTDNH?=
 =?utf-8?B?Y05ZWTlLVUpOUlVyUHpaWnhqSDBUU1RndTNpcFV3OU55QVRpMTVhTXVYYVVB?=
 =?utf-8?B?a1ZENlNHNDBFV3VzbUp2OGdHbjFwTTdkdmJsYXM0R1JPa1Q3OG4wRmdBUFRa?=
 =?utf-8?B?Y3I1SzNDbVozRnFsY2R6dzhFRU05RkNEMHN4blUzdExsM1grS3p5aE5VMEFH?=
 =?utf-8?B?c3JIampTc2kxOFNDZDFWTXppRitoaWhpSStBRGxCTHFnQitsNkZMeXM4TzJJ?=
 =?utf-8?B?bUhmMkQzOHdVN2pEbXJ1Q3VOTzBaWmJFNkF6NWpuNzhkUy9kMU9sclgxaU9a?=
 =?utf-8?B?cTR6cFBzY2lMdFFxK0hKV2MzanlLMnZjaFhlMm82VnNoNk1SUFlZVkZ1Q0VP?=
 =?utf-8?B?VXBxWDIzT0YrMS9Hak1pa1FsZ2ljaERvdWYvVW1reTRPQzVrOEtZMjhXNjBv?=
 =?utf-8?B?Wk9iVlZWZ2V2RGVVNUpXempJUkR0OVorQktQRFo4VUp3TE1Kb1liWC9UVGli?=
 =?utf-8?B?dy96MFlTZGVrT1hrM3FROFRWd0xQUWVYRThrRHY1TDFlMENPRGhqOUV3MlZp?=
 =?utf-8?B?VExHZ0Jvd3d1VWpITHF3b2ZGQUxzN1RKZTdGcEpTUStVOUV5amZpdS9uNldQ?=
 =?utf-8?B?VnhiL2NacXVQa1lXNXVqRWN1enVnczFMdDZrKzhHMjZlTlFzY3VrNDBDVDk4?=
 =?utf-8?B?TWc1a0k5eWFXckpBTXY4Z1JXSSthNGVMcktlZzVVOUh5NXpNeVZUSzdzS2ZE?=
 =?utf-8?B?MEFocFg1Zk04QnMrWFpnY0FhcWJrTEQyRTREeDdlRHBVTGVFUzJXa3JVQ0I4?=
 =?utf-8?B?ME4yb3gvR2hHbkFMLzVsZ0gwRjR6QVl4ZW9rb0NNdE8zYnd3cFV2Z2J2aU83?=
 =?utf-8?B?Nk82SXYzYmhpZzFEd3FkaDRsVkZKcEdiZ3J4ZjJoV1oyNmhyWXlsSHFMaWlp?=
 =?utf-8?B?N0hNeU1rMnRMSXpmZit2ZWlRaHdXV2R0N2xHRFJpeHhkZGExVHNKMU85SGJW?=
 =?utf-8?B?Zk5jb2xJUDZya21rT29SMjJMMk92bDd3S1FDTlJNd0VhdWV4MnNTb1UrN1I5?=
 =?utf-8?B?eE9zVytNdXVJUTZoUldEbHlHc3F6ZXJPSFg5TlhZWHZoOHhQdVpJK1VNOVhR?=
 =?utf-8?B?dk03aVN1ak9lOUdIY013SU0zeGxZbEJHcFROWFo0NytiMktmcXZqdnJWaExn?=
 =?utf-8?B?S3FmTTlrVFNhMDZiSTFmTEFkWm5yUEljaDFTMzFJZ1A0Qi9pSHUyYmdhK1p4?=
 =?utf-8?B?NmRKbmQ2dmIxOWxvVTQrK2pSMS9wTDVtMGxFWjBSMDdHbVU2NlFzZEI5YWxD?=
 =?utf-8?B?Q0VBZERFKzgvNlNZQWZJZk1yN2tRQXphZU02MVJnb1NwSUxEcWdvZ1NRNTgv?=
 =?utf-8?B?d0w4c1lKNG9oKzlONkdZKzVLZ1F4TU96NFhTaFB0K3IzNGNSbEJNVVV2RmlU?=
 =?utf-8?B?UkpPNlVwcFZxYnpiejlPenM4SzdkSHNZT3lUVDRWTm9SYzAxWVZwdGx4Z05F?=
 =?utf-8?B?VlBaQkt0clIyRjQzNzI2WDdnZjAxcUFTTGI0MTExT2dRWTJYcEt3RkRFTnRs?=
 =?utf-8?B?bVNlUTRGbWZCK0dXQzQxUWtFS0V2UDhsdWtxczFlUGhBOUxZU29mbVd1d25K?=
 =?utf-8?B?amVPeDdNUEtWL25ic3NVcCtMclNhWmhwdTJOTk12ODU1Nm1xYjVCUmpMZUpj?=
 =?utf-8?B?UXZuck9EY0kxNEZKa1ZRdG40bVZiZXFTNkpYWEViYUtNdFc1blJBcXFGU1c4?=
 =?utf-8?B?SFVPTy92ZzBldlppMTFQajNqRHpDS2x2QzVoU1JYVGRVVGcvSFpVeGFBdEdG?=
 =?utf-8?B?V3RIMFFxQXF2c2NVMmdNdUNaaHFVSzJPdWZwSzVFYldZcW9hQzJtRnhTWDFt?=
 =?utf-8?B?U21xQ2JmcXRUR2RSay94cUtYei9id1l3aTdQdXdXdmYvNkRCMUNwNkpJQUtB?=
 =?utf-8?B?U0RZYVRMQmZ0WCs4bFhjZWVrYlZLMkpFdFN4bVZKYnh4ck5pTHNrL2tmQW43?=
 =?utf-8?B?eDFVNlNzblZPMHFvbXZ3OEdPSWV1T2d1Vm11eGRLbVNUNWgyMU9Ea1BHNUw4?=
 =?utf-8?Q?2hwx4VGSu5bo8x2Cl63V02CoQRXM04bC3rwex0POkP5Ue?=
X-MS-Exchange-AntiSpam-MessageData-1: eEZUJHRKQeJkPg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3007fa96-4e06-4696-5c13-08def2b4d398
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:59.3660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRG49B+meplMWgFrBsJD5jraU8mMYJ9hycN4UFMDeip3pdyIdCW20lxPFqRkLTCliIbpw62p89iFZ6hPjhX11A==
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add self-tests for the PRAMIN aperture mechanism to verify correct
operation during GPU probe. The tests validate various alignment
requirements and corner cases.

The tests are default disabled and behind CONFIG_NOVA_CORE_SELFTESTS.
When enabled, tests run after GSP boot during probe.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: convert the tests to window_at(), macros, and the new types]
[ecourtney: cfg-gate the tests and expect(dead_code), not a runtime no-op]
[ecourtney: run the self-tests on all architectures, drop the chipset arg]
[ecourtney: test within a usable FB region, skip when none is large enough]
[ecourtney: report failures without failing probe, start banner at dev_dbg]
[ecourtney: removed the mm-specific Kconfig option]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs    |   3 +
 drivers/gpu/nova-core/gpu.rs       |  12 ++++
 drivers/gpu/nova-core/mm.rs        |  40 +++++++++++-
 drivers/gpu/nova-core/mm/pramin.rs | 129 +++++++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5738d4ac521b..2c11eeee92d2 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -86,6 +86,9 @@ fn probe<'bound>(
                 // (`try_pin_init!()` initializes fields in declaration order), lives at a pinned
                 // stable address, and is dropped after `gpu` (struct field drop order).
                 gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) }),
+                // Run optional GPU selftests.
+                #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+                _: { gpu.run_selftests(pdev) },
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index e29e07488e78..04e1e30eeed7 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -429,4 +429,16 @@ pub(crate) fn new(
             )?,
         })
     }
+
+    /// Runs self-tests on the constructed [`Gpu`], logging failures without failing probe.
+    #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+    pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bound>) {
+        let this = self.project();
+        let dev = pdev.as_ref();
+        let regions = &this.gsp_static_info.usable_fb_regions;
+
+        if let Err(err) = crate::mm::selftest::run(dev, this.mm, regions) {
+            dev_err!(dev, "self-tests failed: {:?}\n", err);
+        }
+    }
 }
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 58dce211a337..9e4338c7c393 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -3,7 +3,7 @@
 
 //! Memory management subsystems.
 
-#![expect(dead_code)]
+#![cfg_attr(not(CONFIG_NOVA_CORE_SELFTESTS), expect(dead_code))]
 
 use core::{
     fmt::LowerHex,
@@ -123,3 +123,41 @@ fn sub(self, rhs: Self) -> Self::Output {
         self.into_raw() - rhs.into_raw()
     }
 }
+
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+pub(crate) mod selftest {
+    use core::ops::Range;
+
+    use kernel::{
+        device,
+        sizes::SizeConstants, //
+    };
+
+    use super::*;
+
+    /// Run MM subsystem self-tests during probe.
+    pub(crate) fn run(
+        dev: &device::Device<device::Bound>,
+        mm: &mut GpuMm<'_>,
+        usable_fb_regions: &[Range<u64>],
+    ) -> Result {
+        // VRAM span the self-tests are free to overwrite, from the chosen test base.
+        const SELFTEST_SPAN: u64 = u64::SZ_64M;
+
+        let base = usable_fb_regions.iter().find_map(|region| {
+            // Tests rely on this being 8 byte aligned for checking misalignment handling.
+            let base = region.start.align_up(Alignment::new::<8>())?;
+            (base.checked_add(SELFTEST_SPAN)? <= region.end).then_some(base)
+        });
+        let Some(base) = base else {
+            dev_warn!(
+                dev,
+                "PRAMIN: skipping self-tests, no usable VRAM region of {:#x} bytes\n",
+                SELFTEST_SPAN
+            );
+            return Ok(());
+        };
+
+        pramin::selftest::run(dev, mm.pramin_mut(), VramAddress::from_raw(base))
+    }
+}
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index 2aa1bca22fa6..1019a6e57e26 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -154,3 +154,132 @@ pub(super) fn window_at<'a, T>(
         })
     }
 }
+
+#[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+pub(super) mod selftest {
+    use kernel::{
+        device,
+        io::{
+            io_read,
+            io_write, //
+        },
+        sizes::SizeConstants, //
+    };
+
+    use super::*;
+    use crate::{
+        selftest_assert,
+        selftest_assert_eq, //
+    };
+
+    /// Test read/write at byte granularity.
+    fn test_byte_readwrite(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        {
+            let window = pramin.window_at::<[u8; 4]>(base)?;
+            for (i, val) in (0xA0u8..0xA4).enumerate() {
+                io_write!(window.view(), [build: i], val);
+            }
+        }
+
+        let window = pramin.window_at::<[u8; 4]>(base)?;
+        for (i, val) in (0xA0u8..0xA4).enumerate() {
+            selftest_assert_eq!(dev, io_read!(window.view(), [build: i]), val);
+        }
+        Ok(())
+    }
+
+    /// Test writing a `u32` and reading back as individual `u8`s.
+    fn test_u32_as_bytes(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        let addr = base + 0x10;
+        let val: u32 = 0xDEADBEEF;
+        pramin.window_at::<u32>(addr)?.view().write_val(val);
+
+        let window = pramin.window_at::<[u8; 4]>(addr)?;
+        for (i, &expected) in val.to_le_bytes().iter().enumerate() {
+            selftest_assert_eq!(dev, io_read!(window.view(), [build: i]), expected);
+        }
+        Ok(())
+    }
+
+    /// Test window repositioning across 1 MiB boundaries.
+    fn test_window_reposition(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        let addr_a = base;
+        let addr_b = base + u64::SZ_2M; // base + 2 MiB (different 1 MiB region).
+        let val_a: u32 = 0x11111111;
+        let val_b: u32 = 0x22222222;
+
+        pramin.window_at::<u32>(addr_a)?.view().write_val(val_a);
+        pramin.window_at::<u32>(addr_b)?.view().write_val(val_b);
+
+        selftest_assert_eq!(
+            dev,
+            pramin.window_at::<u32>(addr_a)?.view().read_val(),
+            val_a
+        );
+        selftest_assert_eq!(
+            dev,
+            pramin.window_at::<u32>(addr_b)?.view().read_val(),
+            val_b
+        );
+        Ok(())
+    }
+
+    /// Test that offsets outside the VRAM region are rejected.
+    fn test_invalid_offset(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        vram_end: VramAddress,
+    ) -> Result {
+        selftest_assert!(dev, pramin.window_at::<u32>(vram_end).is_err());
+        Ok(())
+    }
+
+    /// Test that misaligned accesses are rejected.
+    fn test_misaligned_access(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        // Misaligned `window_at()` start (`Region` bases must be 4-byte aligned).
+        selftest_assert!(dev, pramin.window_at::<u32>(base + 2).is_err());
+
+        // `u64` at a 4-byte-aligned (not 8-byte-aligned) address.
+        selftest_assert!(dev, pramin.window_at::<u64>(base + 0x44).is_err());
+        Ok(())
+    }
+
+    /// Run PRAMIN self-tests during probe.
+    ///
+    /// `base` is the start of a driver-usable VRAM span that the tests are free to
+    /// overwrite.
+    pub(crate) fn run(
+        dev: &device::Device<device::Bound>,
+        pramin: &mut Pramin<'_>,
+        base: VramAddress,
+    ) -> Result {
+        dev_dbg!(dev, "PRAMIN: starting self-tests\n");
+
+        let vram_end = pramin.vram_range.end;
+
+        test_byte_readwrite(dev, pramin, base)?;
+        test_u32_as_bytes(dev, pramin, base)?;
+        test_window_reposition(dev, pramin, base)?;
+        test_invalid_offset(dev, pramin, vram_end)?;
+        test_misaligned_access(dev, pramin, base)?;
+
+        dev_info!(dev, "PRAMIN: self-tests passed\n");
+        Ok(())
+    }
+}

-- 
2.55.0

