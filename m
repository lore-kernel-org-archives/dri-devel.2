Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDD5C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 002AD10EEDF;
	Wed,  9 Sep 2026 06:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KXaUJhNP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642B410EEDF
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qb8HwH5XRzm4IScdANiKcRijIelhxTtsyBX4uEJ7/FBX5bEuR2wMCecMvLCjFpHKjO71l3F7RWVlhq0pDVrIFJe9Bk4MKygY5MzaE6y6EEg7R1jFdAXB1UUQMowrnzV331UgFb3CE93XYPnlGADBGpPQGiugSGi4O8MfMNmNnQVEK/atBogrE8cWeoN6wMqu47wn68GzzWvLel8Y5kb3m92Gm/Xvg6KQ1eBSswZi4F+m6H394/uKCof3SjDdJ/MrD4x+3qJ7wGTvxbN9jNg5xhQwDndUugvkqLVO0VVij+asDu4okGX5Uyu/bB+I6YtN7/RTakFy7Ccho0DOJtZZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XawQwgg7Gfv+EjzateEoIvAsjsE0jxXD9ksCP/s182Y=;
 b=Af4Sb32qHzSb2OZZ3jU7ABkGiJA035AiNQGesaqMiyPpPw/Jd33kUb48ZBnATWqmWMvFBPdwhfNntfT5MexxteTPNp7YVD2Y77hbGfnHFvXSmpSiaqsZr100PXMII1V1f59vzZREpQKiYzUQkC/MdanG+0Y1yS6B4fUEnUfXJJLiGNOaz/AyLaLFVtMRgZO7BGJv/kpCKWBVhaOa/nTvWhZHYjQftZUcHoh31dpoL1rj9dhaoWfHB00nkfBNg7FoyYUKnPHEdKKec1Dezg94n+S8Cxm5qNCP3N3RCxfv3mziN1+ZaNEWLGl0gHs8l600fw40Yc8yTVhLqfcoqed+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XawQwgg7Gfv+EjzateEoIvAsjsE0jxXD9ksCP/s182Y=;
 b=KXaUJhNP1hFhYChhrfHCyo7sW2IH1dG96S9k9bUxck+o9NKEUgf+iZZBUhFfiY2DJ49P+OAU46yW7px14Jie1SfVVl9zHMFSkv1o/1T5gyRkc13dM2TNONVI4BPjeOCVK8ZLZAKTvCTAeUO9fQAzHaTb0pWwy64geDuPjppaFomszgDuKBSbSlc0vq/yz0+nXCE8i3cfvL5VKdpvzBtJDM/JAkCtVQUZdJ+HqRcb6s724D0GPjqynjZsceP5NFVPyMAvdDbagtuonje2XFBnJIBytgao7xVFWpLpE7+dPWeBEX8TphsEvrTjjxfR6C24OBzJaaOLNs7Dt/3xvbK4Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:20 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:20 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 01/13] rust: auxiliary: let registration_data_with()
 closures return covariant sub-fields
Date: Wed,  9 Sep 2026 16:44:54 +1000
Message-ID: <20260909064506.910162-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0104.ausprd01.prod.outlook.com
 (2603:10c6:10:111::19) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c61048f-e495-414a-8e1e-08df0e3dea59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 12duvT6xZ5qxA5iDGiAJDql/1n0FIqXtuOkNYzcf3XOQ2wcGwguwZtuU8g2UJcLFRZdjoNI4uGRbf7VqfZZjorOh0U6VMWzGJKGMDzh/zxlJNyDRQreqwWDmnJXe/kDeu1PKWKSjUD9H3PwzzMTaTX/7EsjBefsOGK4En5eLRG7gYF0hbGRuHHkB1liu8/z51FtsK7+cm2DNbWeyVt8LiJobwrACqtYPRN+3edt3BPUExnty9RRxs6xHAS5sne+PFN21xJ0M3hGJuHZHwOcxtGX8w/oSfoGaBS1pCAhiDSxn0RkY+OlDQjhoUL8voBveohTXvhzUebABVuUiZnWK5qCNldY2TJFVdRibG7PRbqdVCCq3aI9Nz58hpMateRrRVX+kvNhY+MY58aW2R3j/kmcWiWQ5brAp2AFuru5x4ig7Lue12JdRF4lViG+MYIKacXpuF/quuy+U4ULhIpyEHoZ0u6g2gIPRKHmsGLisPcM6RRlgRIiyGlWf569QZDJDfA7a59h65LednNWAmCf8rew162uSDmEYnrgb5DZpNoX4KpX952U9wxYKneHX/DaJxTPlX40ByEYjMcUlccQRa7SVdPepRivwYGOIAL4BCrC51UyXdSWnKeg4uuzlOFcpbCcR4mmDIAifxkbf4GNiRF0IlEbn9WFkmbMILHeOLng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8TZEVwEwkJb6vaOW+AKdTI+a4VqIR51+idYFPqNfy6Wxnc4IFAxnmMmx6kA?=
 =?us-ascii?Q?PEcAAF48emaEEEIcCmxQMHH3mIQ2h8sNlJClnIn8e55mG6wlhpSYdfUo9p3D?=
 =?us-ascii?Q?zZZ8Tb3p5Ejj8JJRBvaK48Gl688G2vvu4zq3SfZMKPX4vWFeBE4LKdwxCiTQ?=
 =?us-ascii?Q?PmJZvcqDBP6SBDeoLpHeYr1ZPcYPF5FZe8de6DhKBArzqwi8RomL9ukZK713?=
 =?us-ascii?Q?s/n03x8jM7Y/n2JJ555VzErhMPcy0p5YqhKOtH2mPhr5Be32nyjnO9O/b+pf?=
 =?us-ascii?Q?Uf14HUcRScBTB4XDEtcTikMAAwI4yOnJYlARx9E4Nnq4iIEV7XOEhNjVonYh?=
 =?us-ascii?Q?K+K+Hr2S4oy5jp1kfaejqPWg15PmfarToSiEtCro0Dhtps6Gf2ZCuVGOecor?=
 =?us-ascii?Q?62PFG4EZlpG7ZRcL0+s9jVX/fDq16x8Z6fMbURaSMhaMjA7kPUiIqnDYevLn?=
 =?us-ascii?Q?mpdI5l/YrsJA5tJ5PL80T9eJvE0cbb2V5SP7oCy/T3/Ce8YB46eR6MnZ+EKR?=
 =?us-ascii?Q?BwiLdAcak+2IcVq082a2ddrsYTMHp5d7NZtzhqCQPUU72/2kqdlK55si24hL?=
 =?us-ascii?Q?4uFU2n7ig2KMfGZ3FANWqWLYD6Q7FyGcC2P8XLGnEdz27UOaj76bp+YakaQ5?=
 =?us-ascii?Q?DOtc19U/bTM+ij1dL1E42cZcW4GQjvAhQFiLoKR5/8qXLerG2WRGxz2u0rQW?=
 =?us-ascii?Q?z9gQSERCF8R2cv1HQFXHVl1riTVeMHzyU3iRx5JRKE781GcrhsZlogNgApBB?=
 =?us-ascii?Q?PDpAFczyfgyHxKH0qhVRhVDER5l/YKbSB9SWOfe2CyzGNIqruFfgCWLlwOEw?=
 =?us-ascii?Q?FOF/yv2QW872yaWKFvQwqCqGwrQ+JAfds+44E5Ckjo/Jwp4B7dXwXGlePV7t?=
 =?us-ascii?Q?MH7U4/eRGvL2OhRhWVJuGdBoorirxrDwnkgJM9TngrgP01Rq61A0VFhA8JmN?=
 =?us-ascii?Q?0kZ1jz7lfDwLFhrg4mthVOviBleSmk7W6q2n8xezI2I5jcKiyTnVMJt6aW4k?=
 =?us-ascii?Q?Js3opKQ3l+j+vuauv3mVDDzc2hNzL7FXg3vDQQnXIseZVVxIorUEQrD6UzMB?=
 =?us-ascii?Q?UO/QCud6UJY1MBueCbzJn8UA097nR9aNp+10c/UhS5UZDJ8fm9jq79DXRJPk?=
 =?us-ascii?Q?4E4Uz7Tzwko687WYA5RvM5TBbEwBfa+70W+5M9iOED40E/jOfPMnd/D9lJO+?=
 =?us-ascii?Q?ATjMm9yB/wZa7L+A1rp1oFjKdyXoHqgJFtIPK1ERtodwDgHSkOVrKVJqnLcz?=
 =?us-ascii?Q?rn/kf/WCH9Hxg+rAG3W2yoJkynoMo4D9+s80HFvCqSAOTS28hfL9P2rNXd6G?=
 =?us-ascii?Q?ZXUWctZ1MnZjhXo+vFzVc0zkf7D9ZwnX2xbaJn06GBZ8ZnDaPowEDa9AXcq2?=
 =?us-ascii?Q?f5J6XDMZrwk3ZI/bvh0VrSE5QXvWPmHJmj0H8H+klOzbG5A5IjLlyQyc+1XW?=
 =?us-ascii?Q?llU0sh9lEUwYZJwap9mxlT33p2PvuGg14WllOOzo59uzjSp4+8DK97YGtP7H?=
 =?us-ascii?Q?/goeThX4TfBsMtw8Rna02+TSkIS4eZxGq1IHICmkVz1xJhb2R+BXuT5/+Yji?=
 =?us-ascii?Q?zj5+PlPBOZYKGGHHUNnIm0Fobaie7eUID6XjWG9Y0dvgTiQg1wBkPvNSO9bp?=
 =?us-ascii?Q?fb4rWjoFsvQqd7IMke6BfoTgvTEO+tA1nUhT8XkKSX1oOdOM8zt/X8Nkd6dP?=
 =?us-ascii?Q?xEkMVVIGwTcCeW35j4AxM0UF6vI0yquWMVmOV5BOjFuK0Gwa5ys2B1ZsNO8o?=
 =?us-ascii?Q?XZbf0HRobQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c61048f-e495-414a-8e1e-08df0e3dea59
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:20.0455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WaODvKz/GfJS8q5ZMYHHoGWRQuHgqqaV3kqqZudx2eoTS28bJ7jNf99ZQV0jVyahcNqQAdeD8OmELsK0bxAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

The closure passed to registration_data_with() currently receives
`Pin<&'a F::Of<'a>>` with `'a` universally quantified. This prevents the
closure from returning references derived from the registration data,
even for sub-fields that are covariant in their lifetime, because the
compiler cannot relate `'a` to any lifetime the caller knows about.

Tie the outer reference to the `&self` lifetime instead, i.e. pass
`Pin<&'this F::Of<'a>>`. This gives the closure the implied bound
`'a: 'this`, so covariant sub-fields such as `&'a T` can be coerced to
`'this` and returned directly, while invariant fields still cannot be
coerced and therefore cannot escape with an incorrect lifetime.

This allows auxiliary child drivers to project covariant data out of
invariant registration data without having to wrap every use in a
closure.

Link: https://lore.kernel.org/nova-gpu/DL3WPTVM033J.33RWYCZOC67Z1@kernel.org/
Suggested-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v5:

 - New for v6
---
 rust/kernel/auxiliary.rs | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 60dfbec8f330..06f816420790 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -305,6 +305,10 @@ unsafe fn registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::
     /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The closure receives a pinned
     /// reference to the registration data.
     ///
+    /// The outer reference carries the `&self` lifetime while the inner type carries the HRTB
+    /// lifetime `'a`, implying `'a` outlives `&self`. This allows the closure to coerce covariant
+    /// sub-fields (e.g. `&'a T` to the caller's lifetime) and return them directly in `R`.
+    ///
     /// For covariant types that implement [`trait@CovariantForLt`], prefer
     /// [`registration_data`](Self::registration_data) which returns a direct reference.
     ///
@@ -314,13 +318,14 @@ unsafe fn registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::
     /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
     /// registered by a C driver.
     #[inline]
-    pub fn registration_data_with<F: ForLt + 'static, R>(
-        &self,
-        f: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> R,
+    pub fn registration_data_with<'this, F: ForLt + 'static, R>(
+        &'this self,
+        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
     ) -> Result<R> {
-        // SAFETY: The HRTB closure prevents the caller from smuggling in references with a
-        // concrete short lifetime, making the round-trip from `'static` sound regardless of
-        // variance.
+        // SAFETY: The HRTB on the inner type prevents the caller from exploiting a specific
+        // choice of `'a`. Covariant sub-fields can be safely coerced to `'this`, while
+        // invariant fields cannot be coerced and thus cannot escape with an incorrect
+        // lifetime.
         let pinned = unsafe { self.registration_data_pinned::<F>()? };
 
         Ok(f(pinned))
-- 
2.54.0

