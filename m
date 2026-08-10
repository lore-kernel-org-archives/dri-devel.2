Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27139C5B56D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F7A010E887;
	Mon, 10 Aug 2026 13:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AadWmrlK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F80F10E886
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xscc0Zj4ygcdij+xn8LvaQHi8U/8ScfRi9rNzmKXIfbKjl/T4wjuZ8Nb95zqzViQhHvc8mr6GRaaaFNdMWZnbQ8FRPAGAZ5ac8r4/VbBBv40Poio6c5niOcBpauMgquRq4tgFwBbcAMJkgjwck4z2R5HMYaYqOdRT9Tg0J0PiH43zoHRpr1aX5RJC0SzeZfmLYSlDEbjJf1q8DvvvtM3EnLPqXl2KvpTbfNZkEFHnO7VqCJoYcjmqEL2EwodpgcJ7v17h9aTMcU18SP8r19re7XMLOwBfWzP3FndaxICU4EC7zxu+DsybNlFVQbsxXAGwtPTaxAcRe939/rV2BSmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySLHY1auqKK2L0EotcEpJEtnXPUV7Lv3gQcIpvXHnXc=;
 b=o33Q4JPwq9q18ZAIpp/jcqX7LMWGzIgTUI+AbxiXbxvjHpoMvUO2o1o5RLT6W0aKAO4HN2zomXU/ci4xUyEBfPwOQ4sC05guDARRodobjv79zL5nLxzKn2rJ6zLg2GScnKlxdCtnPf1u3GIQabl39iS8N7SNjXoN598eVCtyS8Nkj/P1EayXTmLlMRc20XBwiIzUi/hwCw7HCmixG14oV+F3a4jcCveuXBK/2NxOdXxzV53taELqB8dAzhV+tETpIKjwWbfphNx2BNElBre17XEQREcVhoTwxWtAnrJXYh1soYWmgt8vdZBYtCsvRA3lSHkxzhfHfPJSkmA9iDiVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySLHY1auqKK2L0EotcEpJEtnXPUV7Lv3gQcIpvXHnXc=;
 b=AadWmrlK7TIVCOdRzwNAJpgfs13yYg/2eAhlHvvvFBP2Z4phOmEggvy71Q5WRtD9FYBQn/4eh23dvecpGJwtufgFsjersUUpcBLuq62xP3q2Ejd2F2jQbjhsRqH9VmHiJLgWHU7W7YEBuadaTPjMz3qLH1J9OsVRGmIIE+nQZVUTykkp1ObU5Qy/zWWQTw5lMCDxB/CDEicn9FePvAruA7pBmituCebGOBv8MR69VNzhigusChbC0Qltx25ZOQLECXjHE6s20D0CQO4gbUekxiE9ZtqV7Tj0uIB63RCNlx+jC/GibSAYTKvPSHAKUMcZKtsJpRzsKFBbCPxPs9rYNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:57:54 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:57:54 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:26 +0900
Subject: [PATCH v2 04/12] gpu: nova-core: mm: Add VramAddress type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-4-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 051a57ea-d684-4926-548b-08def6e75ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info: AzcFEIl3RBM97hIahAFp2D2cXWvqn5PCOMsnFugGqDjDM5VGU9o6CRo7jPtxq24kv6WBRpfTAJ1ZO4Eys8z9y/vWW2SEjCrB19IK2H6b8OGQp+nQ/wfpw7G/OFJ3OAcqMyqpzh2e1B845kddb9N/l9kcG/9HY/QEOCrkj5dvCHlSPHqR6xjr9uRg2y/I2Esf7fMtBFp/4TUmFBQYiY0Q9hCYwlpZd48A/UrIrLYXiFpPZ4nFHyDgws1VkepBHO++lqpz64eJL5zCQ6X/qNVbsmqo1QyZPbVVJq4Qs6CHkyMF7swMva63vp6SOTVTZKogymTZJerq97iYqjyDuYvCefJNbSQDta/dnepe0TeXItrpfURe3hY4YH1iObF90arAc+VIDBsTSRP70QK9YZXPpwgkw4w52VCLFo4Kto56GUDP08Tjrm5Zc/jHI9+kKZo2/v+Wfc1HfhSHF1FWDJIJj+Rr5bRXnMG8QK7rAclawijT+e2e53P1TLMUu+TtSra9XKy6xbPUkFrPwUNVjERfyq+G6m8q6bqqXB9v+a9YD01O/Yt/JeOVU4Wq6O+NG1KqegEDv5k+l57fwBFMlE7FWnL8LpKrnuel+3C35XNl6YJYHAGR6sRLsEDl/doKjqFLbxBIiZPdRRiQQu04K5me2vgw9Zk/ADaA/NuhzoRhwy1gdLhTgb4sI9pY1C7UyfjjNEhA2fVms8WhJtakeFqLhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNyK3FqazZ6TjlUT0lVblRPY1ZZa25zMGVvNEw1dmZCQ3N6Mnhvd3VqZFJk?=
 =?utf-8?B?M0ZmUGVhaVZpVEdTcmJUQ29ZaENJSHEvQlZodWJDc0loSFJ2OUM1UjlKZTgx?=
 =?utf-8?B?M3Q0TnMwYVFJVlNzamVrcnNBTytNQ1E1ajBMRjlBRVJvamtqZXliNjl6ZzRz?=
 =?utf-8?B?aW5od2dNbWhpQU5ibDNUTVQ5VE5OK2ZyUFpsUDNQZ05HNTdWRDNreVZudGU4?=
 =?utf-8?B?NjNjSjdDaVppTkRqRDhMMnloSVBySzBaUE9WVWE0MjlPQXVGd0w0NnBkRUpB?=
 =?utf-8?B?Y2VRVy94aHNIanpwQ0xCclkzRWgxQmZuSFhSbU5hbEp5bUZUL2Q0NFFnMTZZ?=
 =?utf-8?B?NWVMK1RycVRNcndwZmYwWk9iZkZ3dGxLQnV3cFk4dm5xdThUN0ZSeGw1bmVh?=
 =?utf-8?B?aDF5dTYzbmMyWFdxWlQ2UmlnNEpIeDh6RERMWlNFb1dxZWpMcjBMK0RvVzlW?=
 =?utf-8?B?RjVxSGVmMUhFenlHL1pxVTVhOEZjTHNMeDRIOWJ4UVFZV2FkdmE1czJkUVVy?=
 =?utf-8?B?dEVKa09MSkVwVWZxY3ZDUDFRTmhKR3RPS0RxYWpVWjRCTXZ4Y2lRMldiR1I2?=
 =?utf-8?B?dm1XSXFZMG9xUnBFNnM2SkZzZmRDYXF5K2YrQ1hLbjQwZ3BXZ2U3c2lzUm1m?=
 =?utf-8?B?djY2S3h3RkxRUU9LbC81ZW5ueHBiWCtkVlVVcUl6bjN0RTB0WUdremdSaXVi?=
 =?utf-8?B?Ry9Dd21RbldxbDI3cVFmMGxMUlM4Mm4vM2V6VjE3aXEya2FmTE1yT0owQkVk?=
 =?utf-8?B?eURNS2RSaHRiUm5PMWNsZG9SOUMzUVk1dlpteFVrNVNwYTg3a0dhelpCTUh2?=
 =?utf-8?B?U1o0YWMrVGRPbXB3alZtbmVXbmhNZkJCdS9RYUd4aGZiQUFpZU9IaDJVMEhw?=
 =?utf-8?B?KzkvS20wcEVLTE1WK3JRUHlBOFdJeTYwKzhRZlEwNHdGOXI0L243bGVmMnpV?=
 =?utf-8?B?czU5MmxLcDEraHkzcjlsT0lpS1pUV0ZTcUkvOUVzWGprbC9OUWxKdXRDMFRy?=
 =?utf-8?B?cDBOYVN2K0tZTlhGdHRCYzVBMFpsclA0djBxbzIxaGVTZ2poUWJoZ1VpNm9q?=
 =?utf-8?B?TzJ5OWVxSS8vMW1oNVlVRW5GaGtxVWxOM0kzZ3R0bnQ3WFhZdGJYd1dIVDRV?=
 =?utf-8?B?cjRmS1VHY2lWYkFqRDNQOG8wZkxxUDhkWGZpaXZSdHU3dGt4ZmNwdURtS0Z4?=
 =?utf-8?B?NzRnMlpYRXZxbFdvNldBZFVYb3NlaXdqclpabFJ3SSt4RVo2bjR0eUZVVmdT?=
 =?utf-8?B?d0V2UCtkQVpOcXMzY0lyTS9zVjlPOFdIN1FWWWN5MFdJYzI5VTFQTXREaFpa?=
 =?utf-8?B?RVBzcE9DSmdscHZpdGgxYnBsYTVpMDYvak5rT3I5NWMzKzV0VkNzZ1l6S3pp?=
 =?utf-8?B?ZjNIVGpGbVNVbzBIaU43UEpTTU9NWld5WG9FUUYvL2pHa1N2eUFTdDExa3Fl?=
 =?utf-8?B?Wm51MTlZdHhXVDl3WVpCZklJdlhPT0YwdFIwRWV0dnJ4VmxTbmswSDlsQzNo?=
 =?utf-8?B?dUdYT0tPRUhoVGJiVlk1cXU3c05MYjRzSGFrd0NpTlFSYXJrcEVHVTZCalRV?=
 =?utf-8?B?YkxDWVM2THU2T1YxdEtCUGt4OVpxTC8zT2FhM1dCTmNtL21UQ0ozUXhWcS9F?=
 =?utf-8?B?QUtXZzRvZXV4Vi85cThXVTlFRzA3VXBlTDFPSloxZlV3cXhPVzRGeHZJUFlh?=
 =?utf-8?B?akVTNElVT1ptREJvN01jSGw4L2pvTFN0RFN4ZldOblQzVCs0SDNIY2llZks5?=
 =?utf-8?B?WUlxU0hxUGpxN2hhTnEyRU5lMFZGNUlpZENvOVF1NkRTRU1iV0kvQmdjK2ZL?=
 =?utf-8?B?d082eG1KdkhVeW0xcWVFNWtKR2NsUHVoSG1HTU1kQ0lIRXZiVTRYRW91NC8w?=
 =?utf-8?B?SFhrdWpvK1lxSWtNVTU1M1hmYUYxYkV5SGJDbTIwNHh2Zml0eG96b1pONzVr?=
 =?utf-8?B?OUtEbGkrSzVDZE5pMTFhYlNFK0M5bE1GY1hxYm9UM1RIeTRBbkFiMjhJb2Rw?=
 =?utf-8?B?YzRoL1pQTkttWnV2YWd6L1FMMkc1ZHphd2hYV0xQMUFLTWlLMUdENjI0ZWxZ?=
 =?utf-8?B?Z0s2WldwUnFYVmFGR1hHR2RHRG4wRjI0dU9KaEtFM011Z1hZYmh3OXVnSHBi?=
 =?utf-8?B?Z0J1QlpaUGR1Rm02NDN2Q1paWTVpMzkzb1ZqbXg5TUtHUU9DUE1qaUxMQk90?=
 =?utf-8?B?M1ZnQ1lYK1NiMEpaRFRxK2hXcitxc1Mva3J1TU5NUDlnUG5YVTgxNFNmOHBT?=
 =?utf-8?B?OUxFek9UTXpoMVB1ZXdSNW5ud253dm1iVmNpRGNKTWJGLytqTlZtZFMvM1Uw?=
 =?utf-8?B?ZzgyRWVOSStNaHBDZGUrUkp6Qy9OV0c2UTF3eXRIR1MzVU1qdSs2aDFDTVB1?=
 =?utf-8?Q?nvl4rMiy+TtBCwzGk1a+/QlM9FHrkZfuv9AgpLOaDIBgv?=
X-MS-Exchange-AntiSpam-MessageData-1: Cz46ZIYaxSvnQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051a57ea-d684-4926-548b-08def6e75ff2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:57:54.3269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxpKhuQTBym9AQJ8J5ZFFsFvIg7qTeERWT/Ur3sxkCBmlL6e3Qf+l23Qal++7Rss4FcAMNcAtQD2O6T9EmtaTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

Add the `VramAddress` type representing a physical address in VRAM. Also
add an arithmetic helper, comparison, and operator overloads which are
required in later patches for address arithmetic.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: create mm.rs here, squashing in the arithmetic patch]
[ecourtney: splice the two commit bodies]
[ecourtney: drop the Pfn fields, open-coding what bitfield! generated]
[ecourtney: drop align_down and the IntoVramOffset/IntoVramRange traits]
[ecourtney: make checked_add() const over a plain u64, derive the ordering]
[ecourtney: doc wording, header, import, and signature cleanups]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs        | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs |  1 +
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
new file mode 100644
index 000000000000..dcd5e5e919bf
--- /dev/null
+++ b/drivers/gpu/nova-core/mm.rs
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Memory management subsystems.
+
+#![expect(dead_code)]
+
+use core::{
+    fmt::LowerHex,
+    ops, //
+};
+
+use kernel::fmt;
+
+/// Physical VRAM address in GPU video memory.
+#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
+#[repr(transparent)]
+pub(crate) struct VramAddress(u64);
+
+impl VramAddress {
+    /// Creates an address from a raw value.
+    pub(crate) const fn from_raw(addr: u64) -> Self {
+        Self(addr)
+    }
+
+    /// Returns the address as a raw value.
+    pub(crate) const fn into_raw(self) -> u64 {
+        self.0
+    }
+
+    /// Adds `rhs` to this address, returning [`None`] on overflow.
+    pub(crate) const fn checked_add(self, rhs: u64) -> Option<Self> {
+        match self.into_raw().checked_add(rhs) {
+            Some(addr) => Some(Self::from_raw(addr)),
+            None => None,
+        }
+    }
+}
+
+impl LowerHex for VramAddress {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        LowerHex::fmt(&self.into_raw(), f)
+    }
+}
+
+impl ops::Add<u64> for VramAddress {
+    type Output = Self;
+
+    fn add(self, rhs: u64) -> Self::Output {
+        Self::from_raw(self.into_raw() + rhs)
+    }
+}
+
+impl ops::Sub for VramAddress {
+    type Output = u64;
+
+    fn sub(self, rhs: Self) -> Self::Output {
+        self.into_raw() - rhs.into_raw()
+    }
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 35a8b1214b0e..8f59cfa97017 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -18,6 +18,7 @@
 mod gpu;
 mod gsp;
 mod mctp;
+mod mm;
 #[macro_use]
 mod num;
 mod regs;

-- 
2.55.0

