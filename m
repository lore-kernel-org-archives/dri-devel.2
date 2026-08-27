Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0612BC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2975610E3C8;
	Thu, 27 Aug 2026 08:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cee4hXD0";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AC410E3BB
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apdz7yyP68RsCB9FEPDOxyP1k7/6V24AQ7FIvyry9eOsdIfPQlNo6H0BLMDRWOubLwbtSaFiz5WRijZFEzyejGDb9b9RCa4sImwYVpMEDGr1NQg3H1GTJ0cpmgcBKQO0l1mW+be2XjJMjV6AUbbGmfqHFIA9pMhIPI+Pq1UgmV8xMx/ZiJ8yIhezubivKFODJWQQ1maU1YxTSZ3ZpCI70qCUb3ndsDcVAOkwxu1xzNYurKr5t1gkNRwXBX+Nz8XujiIvBM7KvB9/hkqZ/Nsuly4Sz1czCXvK4TIMrl0+eIPs/qLEK47ljCNUn03SZBZTMzi/fQOjQ0tj80NeNFxlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYAUQ4Ly3AZGT9BmkfCu5w1yYBWLwzZ1p0beHwt85hY=;
 b=rxENwbeeePlF5z2V7inRAYktt0Ynvd3p9pnmUnUldK+XBuV2eybZZ4lms9ZQdX3GrfgiK0sdMe2pXP2lUTIuJV/821g1PDeOB6mwW1O0lQdbYQPBenjbOe2NMTYHiPlDlfOsGWc5E+YKaN5HsS+lz+aHWMKNuUxzETlrAXiKiu2rvZ3FztaY1U2zVMzkXPmasamoMNkwkKSq0QhL5na8FZ8GGVtuGpIHrIU3y8je/wkWX0r2VT0qIbIakDhQMIKdb487vAPGYKXEOfypMoIii1XwN1HlUyzRGgJEX7nbx0mMwGKPZENfEq7VNFUFDS4/BJdwuMK/rdK0tegmq+4sVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYAUQ4Ly3AZGT9BmkfCu5w1yYBWLwzZ1p0beHwt85hY=;
 b=cee4hXD0pLFxOz+Pt8ZStKbhI4rsr0IvMjaimzBC/eKK1mp5vXx3saur3AVRq9ZYmSt79tI3r+E25xScl1aLv4Cr/rGuxyckZzSzLrJz+Let/PKSd8mCxEJ0khk4div8L2WJkdlwWp12LCInamuCIEGjskkgYDGfJ+gEGjvhcg0p9k9vf+B6WpGocBr9CY6Po1A9ZJqa8k0H/HI4IUnGDy+3zzjrVx5SI7VF3Zi/WthGTW6wzxRjykVtjOPM+JVlqTUrq0n+8sD1DX0btQ4vB+zGbtGkMYMzG6KQGr9kLHLfm6YinsJNfyJE2QxjSIcNrjDNOCsHjsf7PKYBlJpBpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:24 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:24 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:46 +0900
Subject: [PATCH v3 05/10] rust: io: add static `cast()` method for views
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-5-24b24d7afc52@nvidia.com>
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
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5482039b-954c-4431-f17b-08df0418834e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: icuIvAS6nXzRr56700G14dBBfoR4zIXTYTJLCb42G3VL9dY7gWEZhbIEFwfLjU8/ihJCy2V6dn5zcLUT72Cbd1f5Pd9oc7/HsBeWN/Pz/Yz0egmhUMQBaq20roDAakB37edRxxPlfyf0+B9FAOV1GgcoVu94E8G2HigPvLCmOyHUOMFmX9szmkbyzbxlB9UJFtPjuK+b+VyWLz5dhvVZz2qSdJOti1RswIpjWAHJhL51pK/tNN2CNrSiIEwgjUf4xqauLEhRlSi62FhlAZDuQe+dMpMPbVZ6VZwyajIXV1maPTNxXfhEKfllAHzS4ucssA5QnS6Ei17L0Dd1i/ZNShzWMh5aVm1+Z06mt09Ro1j6yPtB7Gz9PzoRlfwPBPrbBc2J7bJU4I7Wi6EbR9uLSDf6gtroSkyHRCY3wF9bBl3sAZbI3cimZvatVA33j8ewKjB0ouP2IzmXJMQLhanVxz6GGN2hst39LsjL4X+Nxe+dPDqVtoPYIxW6gK6jXePaSc03X6vftaPZayfgr8tre8cHwFAwW6XoYlBTkIK+ODjCM3KknHiSsFZ5dIjdgeeG+Q0afsd6mlJjgcFEwS62ktWxs9GN9PvpHPr952Oi+Ap4zW7gUl0av5+R6T66HVWLY4s2R2JTB56xpASfO+ze3yj8UQNc9Xs55LW1ADpvxD4LNmgybPeWTRI9EkelopEAmJTYcXnq/TzIMwIlqP0e5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elYvNFJKV014T3IrWHhuSzBLMTViREFrVTZUSmlyYkx6cjZFUFNGaEp6QWVV?=
 =?utf-8?B?cXN0eXdMR2s3TnNJZENsUzVFWUFjcVZJaVB4TGE4eDA4OWkyUHJ3dm5yWUls?=
 =?utf-8?B?a0pCQ1IzWUVnbkxzWjZSTWFBVHh2UEY1Z3l2OG4zVHhPTzhrZTlHczBhNFVE?=
 =?utf-8?B?M3I3RjN6Vk5mN2d2T1k0TzZocnZlMzRBajJjV01zVGphR0lRVjlBRGNiSjFB?=
 =?utf-8?B?OGJJRkFmSmo5RXZpL240WTJwQllDSUlnU0pWU081Y3dWSDJoNllPYXVBOW96?=
 =?utf-8?B?TmttdElkcTBXeGNXYUN3dEp4UG5NVUxmWDRXS0loZG5lYllHcitGRGI1U0hy?=
 =?utf-8?B?QnhQR1pWcUFienRGU2h5a0plWUFPcUllWUlGa1dXZUgwZC8wbVBvNGNJVjRS?=
 =?utf-8?B?elQ5cTJQNmFBSzhYcUtPQTJ0WXBpN3lXSHVEZTNuOHpsaWZ6NWlCZjBrNzFE?=
 =?utf-8?B?dXBEK0tYc2ZQbE9DblRkc0ROS2o3cXg3MS9xRUYxTGtCREJYTXdhNGdkamZN?=
 =?utf-8?B?dE5NNHJZSnZlSC9ncmlXbmdWZU5iWXhleGNFVWp3TVpEV0dWOFp3UUhESmJa?=
 =?utf-8?B?aEY0djAzWjhUd1FJelUySzltT0pwbm9lV3dvUUNJckpGRmpLTFVNMHg2N2JM?=
 =?utf-8?B?RHN3WHkvNmVLVXh3WDFLbU53bUwvaEVZdEFSZ3pma0F1L2U5aDFrdU0rQXNN?=
 =?utf-8?B?TTNkZkFOVzNqQ3htY1hPTVdGcFM4OXlsTHFrc091dDZiM3lQb3EvdmNTN3dX?=
 =?utf-8?B?YmJjUWJoL0hlTHF2QWNGOUN4aFc5MEE5NkVHKzkzL0cwZHhmYXFVcXJlU2gy?=
 =?utf-8?B?eGhBT3hzZk16ZDN5eitLV29vZU5DNXF6Z2tleXRZMDEyRUhaUldyWUlOQ3ZK?=
 =?utf-8?B?ck1PYmFhcEVsM212L3ZNdUtGWWxuekJJaTMrSTAvR1FpS3ErOTlsMExndUgv?=
 =?utf-8?B?R3ovU01LQTNaanhudWY5M3Nud3FOdFZIcmJTWEpEaCt6bUgrc3VaMGRXN3Rm?=
 =?utf-8?B?R2Q0V0xpK0tlVS9NZm56dHJIb3FxalpBbTJJOHJxQWhSWk94V05xZXBOMnd0?=
 =?utf-8?B?MTg2aEROQ1RHTEc2ZWo1aFR4OGlOVkwySmRaRVBjVTE5ekFYWWNrYitrWVcy?=
 =?utf-8?B?bGVzOTNER3lWY0xSY2g5cFBHQjYweGpaTktGMTRhUnlHdkFnc2o0ek96czQ4?=
 =?utf-8?B?Q1JoTXJnNVRDcVcyVS93bFZlVTdnTHk4RFdWalFXN25zSU54VStlQzhpTDh4?=
 =?utf-8?B?Vm1pb2Z5VndQN3FRQ3pJU3NPOXY1NC9KWHhUS2QwRzlOUG5udHc3WmlDRFAx?=
 =?utf-8?B?R0RlZHBaVmRVMmF1QUVkUlZVQ2Y3WWJLbXh0cmFoUTYvZGtoT0dUS3Y1WGc4?=
 =?utf-8?B?eHJMUFJaZko5c3hNU3g5WHNDT0dvaS8vbUFuZlhnVzlRREhOQW1Ldlprc0c3?=
 =?utf-8?B?TkJlanVsNFBWd25yUVBuK283Wlo1U1FqL1FkSFpSOFJJM1BnalBGTkFpaUR4?=
 =?utf-8?B?d0ZaNy9YWTcxSFhtTVhPVGVBM0EvSGdKR0lsWUEyN1pPVnlqb3psMlNhb1Nx?=
 =?utf-8?B?VHV1S2FKaDNONndFbGtXQitGRXVNd1c5Y1RTNUNYK2RmOUpwbWtoUjdOT0tY?=
 =?utf-8?B?VndNdmdDM0UvMnM5eFdiOTNNNmIxK2JxdEY0K0toK1lwcmlvbTVCdGZFVStX?=
 =?utf-8?B?MUNHUmZCWlpUV0NMWTNSNGlQZjJxemN3bnF4eHBrQ1p3djdCSjg1Yng1aHJF?=
 =?utf-8?B?eHZlMDFDV2lkRlhLK28rd1RRb01nek9BQkovZlJFSVJHY1hHcEpiUjRaNUNs?=
 =?utf-8?B?WGtSZFBLSFFtMy9lakJSdjFmOStPVDJJWkxhcjlBUzFzWEltdnJTRlltTTlx?=
 =?utf-8?B?b1ZTaVFoZjBwQXc4VStrbmFITklYTlpLc2FNRGVBWDE4RGY1R05sZm5pdWhK?=
 =?utf-8?B?M0NxZDBkbnNydmd3eXBOY0JQR2gvajBBQU96SmZCQkhQY1VmamZtL2VaZWFX?=
 =?utf-8?B?cGlMb0lTbjVZeFcyY0hML1NabzEzODhHUUlzbTBuU1JHUDZxbm5vbXlkdU93?=
 =?utf-8?B?YndDNFZ0ZVVWejFBeXFpbjdjYWw1V2htTTlkUGpLZ3FJbmpYd3Q1SGdVcm82?=
 =?utf-8?B?RC9qN3hOb0ErUS8vOVpzblVFNWJvRGlxVjdwdmUvMDRBVVJHLzkzM2gwZkI0?=
 =?utf-8?B?Smw1b2lkSDhmNnlWbTNUVjVCQngyRENnZnhBQy9JV3pEc0oyWUJ5WUpWc0w0?=
 =?utf-8?B?elZwTUo4MjhUNHZSVm40ditsWlo1NGttbDFoKzBRWkEwUjg1cEd4RytXN3cy?=
 =?utf-8?B?VjdieTR2S1BHU1NRR0hXSUdUZVgvREhjWjZpWENoMEpLdjl5Y0NYOEFOcWl2?=
 =?utf-8?Q?w9tpCoFDr8C3421xeRwGAPE3vMyNl9ImRY/c3rM0ACtID?=
X-MS-Exchange-AntiSpam-MessageData-1: xT7SqnwE6U/Fow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5482039b-954c-4431-f17b-08df0418834e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:23.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgvASbgQ9n6VNJ4MZjQCHDZNBLuvBSoodgHJ+eASbvXSE4Iy8oHYQbZlrYpOD+d+aBn3KD2HXmTLUFajXNvIQA==
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

From: Gary Guo <gary@garyguo.net>

Add a compile-time checked variant of `try_cast()` using the minimum size
and alignment information.

Signed-off-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260805-typed_register-v2-1-c3ca142220a0@garyguo.net
[ecourtney: fix the doc example type and doc grammar per v2 review]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/io.rs | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 4542187d6b91..5f1be3b31acd 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -436,6 +436,45 @@ fn is_empty<T>(self) -> bool
         self.len() == 0
     }
 
+    /// Convert into a different typed I/O view.
+    ///
+    /// The target type must be known (statically) to be of the same or smaller size to current
+    /// type, and the current view must be properly aligned for the target type.
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// use kernel::io::{
+    ///     io_project,
+    ///     Mmio,
+    ///     Io,
+    ///     Region,
+    /// };
+    /// #[derive(FromBytes, IntoBytes)]
+    /// #[repr(C)]
+    /// struct MyStruct { field: u32, }
+    ///
+    /// # fn test(mmio: &Mmio<'_, Region<0x1000>>) {
+    /// // let mmio: Mmio<'_, Region<0x1000>>;
+    /// let whole: Mmio<'_, MyStruct> = mmio.cast();
+    /// # }
+    /// ```
+    #[inline]
+    fn cast<U>(self) -> <Self::Backend as IoBackend>::View<'a, U>
+    where
+        Self::Target: FromBytes + IntoBytes,
+        U: FromBytes + IntoBytes,
+    {
+        let view = self.as_view();
+        let ptr = Self::Backend::as_ptr(view);
+
+        const_assert!(size_of::<U>() <= Self::Target::MIN_SIZE);
+        const_assert!(align_of::<U>() <= Self::Target::MIN_ALIGN.as_usize());
+
+        // SAFETY: We have checked bounds and alignment, so this is a valid projection.
+        unsafe { Self::Backend::project_view(view, ptr.cast()) }
+    }
+
     /// Try to convert into a different typed I/O view.
     ///
     /// A runtime check is performed to ensure that the target type is of same or smaller size to

-- 
2.55.0

