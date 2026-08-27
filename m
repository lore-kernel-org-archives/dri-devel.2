Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D68EC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CAE110EF11;
	Thu, 27 Aug 2026 08:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RxXx1JAM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011033.outbound.protection.outlook.com
 [40.93.194.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB56C10E3B7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCcn4gOSk1milM0rvTV8GUN2Xp+UudaNWhJd5L3zfs74OpRjZIYzFQyBCeTICKb3JFLflPJTohY9w6vMpCXM9/f3SdaVMJWm5O6qLF/KywvH548wPZU9S39spNmeE3ZG0d/ML6LoD5nTvOpvlmr4yWz7IONju/GrbacHRuLtHCcVGvbMRxNWH32+QNFrb+KLU6tbUukPL3BRQuak+SVJYZgwNLZK0R7iBhRtXe13HddNB4BOCPELId1Tmzo5C6xkUfFhcKQaVJc2M1ArvtpLBfut9JvGOgrOnKCwHi75viXIiYMd3p7w90F+jowyxU8Vfh8slAqcT1dj3yvpdqC3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySLHY1auqKK2L0EotcEpJEtnXPUV7Lv3gQcIpvXHnXc=;
 b=JvxaGJ0PxVikvFiT/Ab+05JKQ6ciZdOkQFVZf8Ribip8J0S3Zo9vynX6RSMMhe4wp/ayY4GS7Iich8PA81z1RrULiCHxSJ5KkOf+xLa9dAlYoc3j1VIg6Do2wc1GZWALi+XHRY/YNVbCNi5vQLXhh/q10MvVKsfkRY89UtphgUwXqrK8oW+o1nHvLj9LVRn31bvvPhfLdLeBA9LeoSXgumfBCs3CvYv2Oar3UAjhnPER7/r30priwfgzceL+ENELCuHa5jEGqX6ajl9sD4ARhDlt83kjJpCKnXqJPjEpawq8TGEc50Opwp2FeeVFdQEOZdcwrTPQyeqfKWjUsKfP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySLHY1auqKK2L0EotcEpJEtnXPUV7Lv3gQcIpvXHnXc=;
 b=RxXx1JAM47M9aOwtPx9fhdRCQVsxsDcnIl4sq0qP70EqyYBcVHgnXyFLZhZ9xBIxbJdBBoUA8bfSsXqc2AFnWqNVgfQP3cqnhbRqpvzJBmkubjRIh+buLpCDep6fS8818m+pJp+GRSNSkTy71lp4+3dOiKHw7n0BzQXy1I+bjac7tOGQ5q5WluExA2oqEw0U7I89t5YnN9tzkb3N/CjlZzNZKghBg/KgsCJvR8EHFVXWcQ6MmiXO1AoFCUYcFS/n4fhlak8WJJFf2YAKufTsPj8hmt4SGotkelnG9aLo/Kn9ykI41wwVpe9acKTtZWQvpwXjjYtyzbJu+qKWKFMSgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:10 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:10 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:42 +0900
Subject: [PATCH v3 01/10] gpu: nova-core: mm: Add VramAddress type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-1-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a414b7-7b35-48f4-387a-08df04187b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 7H2cwEEr8mVGf/QqEymYubX/NzZEuM5so1v4lqyXAXUBecVhaPnpnPL/dEaLu9XFf76ccKV654BuSqGu7h7tbZ/+30BFYHaTEpDy346H8zSSGAsjdh/iAhjI1EUwLAns4xEHnfa/SABWaEPl1X7k3CQdRJ/IIKMLdUk9f/UDO81SZOQVSLcZ7ydd+/NloFoyDSDbWN4h0Ls7yD3jDdxpX1j83Zpic2GQkgOB2Cc8bD2buj2Kj67xMfErIieafI7ZpxPg/ngxksQzOPTWgFPWU83K+rpAwu1G2xaq7uJHzq96VBowOTBSN4CbA+R5D0wgYwDCSq5zo+pGGxSmkwJ4X3WcMdF0HmLb6cb3LfMFjGiP5H4nviCCrm1gcC5gkTKGu0pxKP4xErB3R72bg6BCEh5kmUHUPBhx1LwDvQ4S84nUR08zr55p13lGWPAWmpEaATYEyxVngbYr1pM/i4yUSZ+m/o+sEd8LVMX38BfN+JWEqI2vfEjp8WjhGsHH+gigqbFS/klZwE4SWNt2XEYu3zuvhXWhyQFCrlnBH6c2CbEwtcu1H6zrc+v/nLylqLyrnNPxyoQ4qWzjOVFL9tvHl41VwOQysFaPZN8FfZHJphoV9aay9o7p4HmF1h07R1yvyl7O71/xkQWlCuizxW+NuCjS0ys4fDMlhBgKAZJm0Natl7yvsZ4TIaal+X3n0uTTdSTDDtyWjITt+sGZXmyhsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE83VEVqa05PMmZVR3VJTVB2dnZMYTYyTzVDUTFtNDM4YUdBYTNYQ3RQemtC?=
 =?utf-8?B?S3htaUJOcUg2anRGVkNpNlJUQXliT2RSelBXVjhXc3BzYmkxU1RjbDNjQ2VV?=
 =?utf-8?B?cTlTaHFCbmtzZUQ0M1hSR0wzWGxQMmNNT0xySEhjN3czdGthY1FsWmNkbGtS?=
 =?utf-8?B?U2hiQURKc1h5MnprS01SbnEwTUx3eHJ2L2tEeG1MeXY5cURvNi8zTlV4Z2M5?=
 =?utf-8?B?QzNQcUNlT3I1VVJSTXV6MjJSOGtuQUFtcXhDRm1LQTJLYUx3cXhXRnpkU1JI?=
 =?utf-8?B?cjlGbC82UWJ2K0ZKcWV4dTkyRnR3NzlhamVFUGJJOHp0MjlDeVBqcGJaTUVs?=
 =?utf-8?B?THpkV1haVFpsdzhRdVp3VWpuY09BU2FMMERxNUlhdGlTVVI5MXBhQktYc0lR?=
 =?utf-8?B?Q05IcFg0aDFIL2UxMFpRM0wrUVdoSm1WOEtHK3dMb2twcFVmaVN4aGdQbHBw?=
 =?utf-8?B?REVqdlhhZkpza0lXR01lVXE3QytjTXZIZC90VUtseWVKNmlKdmthbUR5SjFZ?=
 =?utf-8?B?MytLQ1BoeUs3TzdiUFljOXJDN1BkUUFBUjZwV2l2ZStYQXJiKzlqM05pQmZG?=
 =?utf-8?B?bzNTOTZvVEp1REJBVE4yWDhPNWFkZEtoZTV3czZOaFFMTDdSTjBDOTZiZGNI?=
 =?utf-8?B?eTNTemsybkpja0RHekROV2tCRU45L1hPY3JnVTI4aTNWUzdkd0k5S3c3Q212?=
 =?utf-8?B?RUVpUEgyYUxHUlVvdTZ1OGwwT0hxNEd2b3drUWJQRW45Rk1uNHZSbzhGMjR5?=
 =?utf-8?B?aDc4VUtTMWZ2QWdaR3M5aUZMUVhuY1Z4TmFVcEFxdnl1cG1LSmhsMjRQdURr?=
 =?utf-8?B?cndZR1E5MkFza0FjMkpqM1EzS2ROWWZtaUw5TDhzWVNObUJzeVBsUURadmJl?=
 =?utf-8?B?aXhveEhlRDAyMzNRemJEZitCV05jWTJDb3ZSZmV4aTQwejN6elJMalA2UnUr?=
 =?utf-8?B?NGtPenk1eFJhU3dRYzVGdDZObnZ1YStrN2hKRndIV1E0UW1NY3RSYXlJTk55?=
 =?utf-8?B?QjVzbTRSM2xkRzFpMEY0LzV2OGErNnRQczhQQjA4ZmMwdmxUcFZlYml5NGQy?=
 =?utf-8?B?ZHRicGpWWFlDSzN3Vy95VVZjQmR3MDgyTXpGLzUvbTQ0SkZ1TGRWbFlpN1Nz?=
 =?utf-8?B?c1IxS0E3cGN0M2RWcjNwYkExeFhLaUNFdmhRdUYzeWRjbk9uKzUrKzRoOE9m?=
 =?utf-8?B?SHZHd0JhWnZCR25KeW0wenkrL1VGaWRETU9FNXVNVS81YTgveW5TazBqdFVY?=
 =?utf-8?B?THZub2RUWVhFTUEvTGwybG5EU0I3RmNoZGZCblJQaGVWWHpXZXNaUGF6M3NB?=
 =?utf-8?B?WmE3RVFPRDNzU3JZMmlSSWJzUlhsRkRZRENVeDU3U2xOY29IVGUwWDhnUzNw?=
 =?utf-8?B?ZXZNZ0pRR0hzWi9hUUk4QWdZeTQ3Y3RaVHBCSDBCSGFGcE5CcEZXc0Y2L2hm?=
 =?utf-8?B?bG5qTS9TYjdtZ2dJL3RHZVczbVBKUTNqYWowUFY2K2xNQW00T3krRVZVVk10?=
 =?utf-8?B?NmxUUmVxcGdTTi9wZW1QNFpPTThWSk9TMldlS25lRWwxNzlvTnVYeUc2NWZ6?=
 =?utf-8?B?bS9yVUdOb2l4bnN3ODhnMW1lb0VWckZCeit1cmhZNWp6TnZuYzFWbTFodG5Q?=
 =?utf-8?B?VElvQVNmYWxZL2dnQStXUGljNTVzVlRjVWxPNWZXT09PZFgrb0lMR01jODN1?=
 =?utf-8?B?RXNzblhpdlBBSXRFcnQwSy85N3JwZlVQOFNQZ2czT3VXbThUVGRQV3JXM2Vk?=
 =?utf-8?B?eUYxQUNLbHAxakRoV09PcC9BdmltUUQvYUM1T0NFKzdtTVNjd3JsS1dhQlpV?=
 =?utf-8?B?T0JLazE4WVNuL2t4ZmpFYXFSS1duZG1GcFNUd3RQaHRDZjlTY2hYZHdNN3RR?=
 =?utf-8?B?dS95dWM5SVE1WkJXNWtkTURlakR5M0FBb1lZOERLZEoxbmEzLys0aFFNSXlm?=
 =?utf-8?B?bDlRaHpxdUtEODFiTTNJci9ObTRxUTJUM09mMXFldG9YOHlKbTNENDhmUWdn?=
 =?utf-8?B?U3Rmb0JBWXF2ZElUOGduMEo2OEJCRVJWLzhyNVh4MEoyWEJweTR0UkRDWUEw?=
 =?utf-8?B?NVVxMlk4SkgrN1UvaHRGaWNsbHNpUFVhTklnYXEyZlBLcXhDV2hPU2NUWjRM?=
 =?utf-8?B?TkN5OTJoNDRpRUVrSENlL25QMUVEZkQ1Sm96K2kxWW14aitJUEJSd1EzRERN?=
 =?utf-8?B?ZXNHcnBSNlAwbjBFbjJ1UVRQVnVSdEdOdENrV0VFL0tTc1BlQXlGU01yS2JP?=
 =?utf-8?B?STJyTVowdkNsREwwTGJrZFR2cDNGdzVOOXAvNC8wemxTdjdpaU5GeldGME44?=
 =?utf-8?B?eDRGSnYwUVAvT0F3RUJNUUpxZ2tNZUl3QUx6SXkrM1ZxOXpHSXFmZHhwWjR6?=
 =?utf-8?Q?hlaLiH9e6zoiSJKskGE/jfxTfPyMXTFMTrssOZX84R3cV?=
X-MS-Exchange-AntiSpam-MessageData-1: uTz5s4sdtJvRBw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a414b7-7b35-48f4-387a-08df04187b3d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:10.5547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj1s9+rlYS2QLSt6mRqvACxeltuDhrMOdwP0taBGwUKGY0qmoY98coSTrvagJq2dft16a7lE+un+TTvbQ5aoRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

