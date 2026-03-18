Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32950FCD0CD
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F3F10E6F7;
	Wed, 18 Mar 2026 08:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uKIlQv2j";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B73410E6AE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdDge4uCQgM/TzGeUCksQtmYRt+bLR4AxOWjZvKVb9AUs5DEKOTAjmPRiHmZCzZ867tvR4JrwPTzQ3lhDtINLu/l1vrIzsoHMtozvdcDWnoLrWTzIQnMmWRYSj1QQOu8Drqu13Me2MkhhkL85fOKjsFeVU1LTFL9tH/QEjmKoz3blnnXQcdySw5LISVSI+vv70BKOCwsxpP5UGghcfGHKBoMX12STQSKIsVvjtwwHpZyMaq2Q1HsP6R8FWCwYY5g8Hgo63qkl0kRwtqGosscuWKRtLn7BvJSYQWrW4Vll7UDBXji+9KZ0ZfV3noxJ60OR3xuiKXkJQBNlZde+3MIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ipXqxZy9CB3B51Nlz7np5b0tULcVvSfnDNJ6O/V9BY=;
 b=G9x+4AUKl2mkGhVQENA0ycBnGwkJT8Tbzy018PhGNH77SjYyJ4d90TWR38YXc1t4/7jmpEIIGB2PqROujJXFZspqFTh1QfjPUu1yGKB1sdVBaAyCxcRZ67fPcxdIX2Dv6aF8Yt8Wf06lWqSvlTf9Z0E0b2piZZ40OanNSemYh4W3lJQfjgqasP+/bVWmgsdmXWVGEdBfWdDpSA/1WtCH2OuSuUbBi90p9tuURb6ae2IaYglGLFCxibY3YZHPBM8P/ua5T5CzF7Rf2f3XQkq1hs59JCm4/dBzTG1jTCxx74jfPRW+4QeXrNQOc3/+LiwxlWDLZumrVK8jd5Aa2s6qXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ipXqxZy9CB3B51Nlz7np5b0tULcVvSfnDNJ6O/V9BY=;
 b=uKIlQv2j0OUUnR2tQZ4T5wU2DDhfvS0BIte8RKONrGBYVA3pqLzw2esKwbIhpn3jkEvoR/rHU3b/Lg5jtvyYG+17CyuuNxMIvl3b1d2kNGKAQZf8m8HTYdLacte4DppR5aLQ69ZRv/M4wi+Oh/qSlB06V3UCILlEj7HY5gVlrprIc8xfSgQxiHv/qi1dWD8a21sOLoTqmFoVTm+EkUD2VAF8UfhxyubLRrehFX2uWkDT31jpuWl0/vq28b+d6NNg4JzRrARhypPN1cMJ0jGcaYDXHIKrrsC7RJEldQHl3Jndhh8FzhrX4IU5apQqc9HQhwAZopJff65kjoV5HgEU+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:06:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 08:06:20 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 18 Mar 2026 17:06:01 +0900
Subject: [PATCH 3/8] gpu: nova-core: convert PFB registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-b4-nova-register-v1-3-22a358aa4c63@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: ae623aa1-59d6-4877-64bf-08de84c53d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UCHz1eTVrO4HqKkacZHFjGVJ1wgCp6h3v8it/bJn1+xe0yWeiHoP3C6r2/C6iMfyRO+bUcmhjx/rrLRLk8lq0PEFcNWyyirPs1lZTNvtpn1TTEN6blZIt/bQMtbxd0KNL1mjYylXfm+k+xD8ZgAsMLXDjtoH/YXJtnoDZRzQvyQjLY0tFCao0qW2Vlx9621oWhtxCAKCsZFNzL7B6n39V+We+xn2202tREwAr2NW1LVjUL8L9Kewj+RchV9v4dM9NJUcK2GOZzYIjNtE3GEVBXIizTdhQf4TzpL3rQX4Vl+SuIIBTfowGPtOXQomvNqogwd6LCTpdrHeINHQ4s/6vzK56gJnozY/ZfOTMlLUo1g2ilVnDHoQ+zy+yyhbeykSNliy8Fvt904F9pW+sNzKMfKVigahxCBbshPS248wy9pRLKEiiSD94vYDZDB6MaK2LACi89n1OGY52eDGjTE3Kf8oC68fmSoUV4CSL30Oah0akhtwVJNIujEBDfX9M407xcSteNiHBl7nzKycSa/BLgvhiHUllsoOLz4/mv53wnwgeww9AnrYgkzHTjA1kl/XbViQ/9+NVhTgWU3Vhy8zdJ5Baj0NwkeS7X3sL4GFhmq1bMKWoFCHo39kDG1CRd6yYFC9A8ksVgvkpOWf4bJUKbzclDjFjcj3ecaMxOJu8szUiBFc/ijsfiB2nKxy5+ulPci7HZ79iwHfpxpRpodGHVY9X33MJjOtuQ2ltwUL6A+EOvwXG0EBgiaQOhxtqQ+JKQzaJcfpY3kPWJciT7Kg6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1cwN1F3NWh3TXF3dHR3UVdIZmJIS2hyelF2U0RsZFB4c1VzbmVDTWhXMXgr?=
 =?utf-8?B?UGJKNjYwSGFrZEVId01IL3JQR1ZURXJmNXEwVmFHNEVoejBqd1JaVHUvUlhx?=
 =?utf-8?B?eUZZblQrTExXUWh2Mm1UVENnbk9nc1NxTnJabVRLNVBFcVN4QW9tczRrVXdt?=
 =?utf-8?B?MkdwM1pDcEhaOWoxajJEbWJ5b1MvMzA0NWVtZEMzZDk4dW1wVlE1cDVQS1Vl?=
 =?utf-8?B?T0FsVy9UVmUyNVNLSEtNeHhOMFlaMWU4d24xbVF0SktxWGNudlVKejJidWpz?=
 =?utf-8?B?ZDlSdjVMVkpIdUVnbXQ4MUdYZGVDRzBYa0NKQzJVaUdoT0V4K3pwNnRmbi9k?=
 =?utf-8?B?OWVsUXJvL2xIN3VaWVRkUU41Umpkdmt0dHdzSFFLNm45WUZQNTJFTFA5dnl3?=
 =?utf-8?B?RS9IL2tHNy9uWEFhM21uVmN6cmxnaW8xQWNmTzkvS3pLS3h6dTlsK0lxWE5i?=
 =?utf-8?B?YlgxZTFmaTZlRWN1dTdMcjcwd2RBZDJiQTVXcEltVXRjdE1jTC8vOSsweDND?=
 =?utf-8?B?WW5kUDh4SFAzNCtNNG4yOGdHNXQ3R3dOd3V3Vk5mNmgrVFhxcWwvb3JXcGJk?=
 =?utf-8?B?eUhGT0FIaDFBR2V6cjJDQVpzVXBLUFN6Q0x5bUhEeHBGdDJoOFZuUFpJSkZh?=
 =?utf-8?B?NGRFVkVqZnBZTHNCYVplOVlVT2w3QlZKSDRRdXVYbVVJeDhxOE1hOVRBUDRl?=
 =?utf-8?B?N2dCb0FJYUdTYnZ5NEM4RDBGZ2o0Rm80OEk4MW1zMy9vVDVSdmdqUFpaQVRO?=
 =?utf-8?B?S20xUHNEQjBpeEcxNko2UytwYnBXOGJVSEFzQUttWEp4VUxGbWZIKzBTblVh?=
 =?utf-8?B?aGxuajRqMTd5bXA3M3FrZmtLRGVTV0w3SWlSWjRnM00ybkhQS21mZzFMOXN5?=
 =?utf-8?B?cTl6Q3R1aWF0eHFpUGE3eStmM01tVy9VTlhYVzlhOEpTYXhxKzNNc2pVZXVu?=
 =?utf-8?B?L3lkYWJaWDZjQjBRYWJtcGFIWEZBcWFKQnVMZFBzcEtPQ1hiYUhDMHIvN3pJ?=
 =?utf-8?B?dHMwMmF2Ky9waCtGRnA2a2tsbTU3OTZqMk9PQ29TRGEzZStzUzN4Z0czR0I1?=
 =?utf-8?B?bHpSUktTb3hyU3RsT2xWSHVMTGVXeVY4Y0JRem01dk5wYkQxTy8ySmxmd3Mw?=
 =?utf-8?B?ZmloMmxsNThWd2NHMlphT3RnTEt1cXpLTzM2Zi9kZjJUWGU3cWs2ZDNoRHQw?=
 =?utf-8?B?eHBxeE5jNmIzSGN3N09FclBFYWFNODVjQ2VpWUtFWnQyQnJ0dDgrMmNPWUxm?=
 =?utf-8?B?MENuTDZ1MHF3S04yTEdkUmJET2t3eTU0ejZ3UWNQZnNRRHMzRWF6dHVxNU02?=
 =?utf-8?B?dG9HVzFOWnJ3K2t5N0xUVy80Zks4NWpsd09OcW9zV1puYlE5YzFRYVl6eW9F?=
 =?utf-8?B?dHBSS0QvZUdnQnBMRFhSN3VqTjBDbUlaYjUxYVVnRzdTZ1BURGpVREFRb0gw?=
 =?utf-8?B?cTRxa2E5N2tIL1duL1pKUmh1Q082bXAyTlRjOFErZTAybVRQYm0zVlJGUU9l?=
 =?utf-8?B?T2t2bHJIZnNzQ2hLemtvLzVUWGFwTXNtd2NNeUFRaDFtRlZ3MWkzdXBwRjdo?=
 =?utf-8?B?Mk5JVS8zOWlzbzBETldJQkdVLzVtc0dqVE94eGNXdEt6Q3ZrTUxtU2JVendk?=
 =?utf-8?B?Z1hoRWxrc1QrU0xuZFhackJRMGd2ejZmNEtOL245ekc1MjErcjcwblFxVys0?=
 =?utf-8?B?QmVqT2JPNzFwNXJQUVpmS1UwSWc1ejlJVFFIS2QxLzFJTXRlcFc1ZUlGeGMx?=
 =?utf-8?B?Z25CdmE3V1k5ZGQ1S2h5d1hEK1M2akhpMUpGSVYvbEwxV1dJamFBNVpnc01D?=
 =?utf-8?B?NDUzeS84YWZ0SjVOci83ZUtJZkttUW02WEtLWGZVa01wdnNKYm5ubXlKSVN2?=
 =?utf-8?B?K3lSY3hEdU14TEVjUnNvL2Z3N0Z3WTZDd1d6QWp5cDRHdkpjQXVHc3NHb2Vl?=
 =?utf-8?B?eFlwOTdHa2JkdTc2TVlGZkc5YWViRXVQV1gxTHpESnR4OTRkWURVemJHMnpp?=
 =?utf-8?B?RDB5b29lWmFCTWxPaUxvUHpITG9PZVZ4TUd5d2JBaUlZSkp2eEdkYUM1MW9n?=
 =?utf-8?B?WVJwejRDU0ticE9ZaW5jaVkwaDZYNkZBd1VBT0c2YURtOHdhRExLZjRUWVA1?=
 =?utf-8?B?ZnJaT0o3UFdOTEpka1FmbmNsZThZaURlb2lqeVlPa0xBMmdNdFNyMU0zWGd0?=
 =?utf-8?B?elF0cVo0VU1qYUkrckxYenc2eE0rMlJXZlJpdm1GM0dEL0FxMkN2c0F6aGdm?=
 =?utf-8?B?LzJHeVF0emhaS1FHaTQxZG40UWsvSExtRGU5c1VzOGJzWUExRHBvYXVWbTVU?=
 =?utf-8?B?ZVU1RzNsMDM0RUpTRzl1M085Uks5NjJxdmk1L2dmYWxVeHJiM2EvNzdMZndW?=
 =?utf-8?Q?2Z4DUPtiEBvZcVAZtFSce9gZItxwgpTjh1XbGBzRsqeKb?=
X-MS-Exchange-AntiSpam-MessageData-1: iGl1UiIhydOY1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae623aa1-59d6-4877-64bf-08de84c53d4c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:06:20.7302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW8xvyF0nFjl4++h4OhaAA4LoirY0/z113qHTMuw386cYWenlvnBqKRLIoN1ZADQ2mrWZVnb9PSpZryHu1eX9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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
index d885190b6d92..18a34c8eb6be 100644
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
index efa1aab1568f..e94f677d6373 100644
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
     prelude::*,
     sync::aref::ARef,
     time::Delta,
@@ -493,9 +496,7 @@ fn calculate_checksum<T: Iterator<Item = u8>>(it: T) -> u32 {
 
     /// Notifies the GSP that we have updated the command queue pointers.
     fn notify_gsp(bar: &Bar0) {
-        regs::NV_PGSP_QUEUE_HEAD::default()
-            .set_address(0)
-            .write(bar);
+        bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
 
     /// Sends `command` to the GSP, without splitting it.
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 304fdd0c1705..6e35240fb326 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -143,26 +143,35 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PFB
 
-// The following two registers together hold the physical system memory address that is used by the
-// GPU to perform sysmembar operations (see `fb::SysmemFlush`).
+nv_reg! {
+    /// Low bits of the physical system memory address used by the GPU to perform sysmembar
+    /// operations (see [`crate::fb::SysmemFlush`]).
+    NV_PFB_NISO_FLUSH_SYSMEM_ADDR @ 0x00100c10 {
+        31:0    adr_39_08;
+    }
 
-register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR @ 0x00100c10 {
-    31:0    adr_39_08 as u32;
-});
+    /// High bits of the physical system memory address used by the GPU to perform sysmembar
+    /// operations (see [`crate::fb::SysmemFlush`]).
+    NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI @ 0x00100c40 {
+        23:0    adr_63_40;
+    }
 
-register!(NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI @ 0x00100c40 {
-    23:0    adr_63_40 as u32;
-});
+    NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE @ 0x00100ce0 {
+        3:0     lower_scale;
+        9:4     lower_mag;
+        30:30   ecc_mode_enabled => bool;
+    }
 
-register!(NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE @ 0x00100ce0 {
-    3:0     lower_scale as u8;
-    9:4     lower_mag as u8;
-    30:30   ecc_mode_enabled as bool;
-});
+    NV_PFB_PRI_MMU_WPR2_ADDR_LO @ 0x001fa824 {
+        /// Bits 12..40 of the lower (inclusive) bound of the WPR2 region.
+        31:4    lo_val;
+    }
 
-register!(NV_PGSP_QUEUE_HEAD @ 0x00110c00 {
-    31:0    address as u32;
-});
+    NV_PFB_PRI_MMU_WPR2_ADDR_HI @ 0x001fa828 {
+        /// Bits 12..40 of the higher (exclusive) bound of the WPR2 region.
+        31:4    hi_val;
+    }
+}
 
 impl NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE {
     /// Returns the usable framebuffer size, in bytes.
@@ -179,10 +188,6 @@ pub(crate) fn usable_fb_size(self) -> u64 {
     }
 }
 
-register!(NV_PFB_PRI_MMU_WPR2_ADDR_LO@0x001fa824  {
-    31:4    lo_val as u32, "Bits 12..40 of the lower (inclusive) bound of the WPR2 region";
-});
-
 impl NV_PFB_PRI_MMU_WPR2_ADDR_LO {
     /// Returns the lower (inclusive) bound of the WPR2 region.
     pub(crate) fn lower_bound(self) -> u64 {
@@ -190,10 +195,6 @@ pub(crate) fn lower_bound(self) -> u64 {
     }
 }
 
-register!(NV_PFB_PRI_MMU_WPR2_ADDR_HI@0x001fa828  {
-    31:4    hi_val as u32, "Bits 12..40 of the higher (exclusive) bound of the WPR2 region";
-});
-
 impl NV_PFB_PRI_MMU_WPR2_ADDR_HI {
     /// Returns the higher (exclusive) bound of the WPR2 region.
     ///
@@ -203,6 +204,14 @@ pub(crate) fn higher_bound(self) -> u64 {
     }
 }
 
+// PGSP
+
+nv_reg! {
+    NV_PGSP_QUEUE_HEAD @ 0x00110c00 {
+        31:0    address;
+    }
+}
+
 // PGC6 register space.
 //
 // `GC6` is a GPU low-power state where VRAM is in self-refresh and the GPU is powered down (except

-- 
2.53.0

