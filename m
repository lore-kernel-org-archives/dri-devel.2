Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01F60A2600
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ak6dsWN0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D4610F959;
	Wed, 28 Oct 2026 02:21:56 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F414C10F958
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8TJGJLke7xbYodTz8FNxIWaoZ7V+elfTkQ2fQeyF2RcljpGqmURytv8oIkC/EQhm1Lp6Q5H21INSBM2qwykSkAje4l25mL5FtsNhTR9gfYwUaprC0LrnAnov27hq7tUPwQkZGtUquPU0wAKacH5tlanXCyfWaV2gA2ZitdE3ruJx6XsPkoEZ3VSQItpngHJla6Tj9eHxaICB3AA25e6NXt92FF929GM7BOcXlK8+xMqYPUMbAIznlCrNjp7E+vF+kGVo2ZwLzZbSoB19oQoYnAmuGvi+ja5Du+iMWQ9NLHX40AZuvg7KdFgj1AXb9xLYvStUcudoBBRb4/1cX86UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyWthhsXDV7YMycsyrKHh2mmdeQ2VdQC5sBbQENBsXE=;
 b=ECBIMXN/er5YKZ0ggaZj9VN8Dpb9gegE3wbDN7RlCvt9/czzUsm2p7wDu+SzRxreubSYdKewxBaSOiHiTDJpz17xl27yU1UPXl8cqgzt6EYMFzrc6f2EXsFOv8Yin9WOJ93NUBsqerLszjuyoO9e9olHRQobE4a/j35j10k2VkatvSNwQeR2xvq0QnE3oEA7TdhWP5IdyFsljc+D69B2SPVlWTUrrsIG682TFV/boP5poQCpJ2U7SCMvLFIXUxD/B0Q8W6wUvHiEJLOsPuqpTgMk3M6vcrkW+p3ZNgVX86789BhTb6xMBWpuA0ysLk+yb7RD2O5mI0Bg0WlWg3G7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyWthhsXDV7YMycsyrKHh2mmdeQ2VdQC5sBbQENBsXE=;
 b=Ak6dsWN0pqvorelnGrSbxS0SzNglbxJxMX7CTNuoat1+4YwKUTWo4pbG+995GdJkmdocT4jvOvb6/GLOwWMVOsjMiVWWGjwoYLso0Svv0kz+Nh5Zi96k3WIotiNUbuqEcZzKjUEpa2t60NwkJVJDs2xyvOiwtfdeX19z4NLTvqJZ5fC/D2zc1lbrJAM9kfk8wZV2rJtpIOjwdLtJWba2VkLx3KgSdWOhHlD/DZteUqBj+JfNXWeI7/oeOOy2ceajbuap6EirC3H0+rC0L86ndUFV7xDkUse9D6VxiYAFoIZZM6fBV8R77wC9jFw2WjWcqno/0cTLFOAfu8OqbStRWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 02:21:35 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0546.016; Wed, 28 Oct 2026
 02:21:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 28 Oct 2026 11:21:01 +0900
Subject: [PATCH v5 2/7] rust: alloc: add ArrayVec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-b4-nvkv-v5-2-ef78909b513e@nvidia.com>
References: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
In-Reply-To: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0305.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f390cdf-2bc5-4aa7-4757-08df349a30a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|921020|11063799006|56012099006|261009223027099003|261022105027099003|261021135927099003|261026121527099003|261021121427099003|261026140227099003|10067099003|261021123027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: JmwHOKcNq3C+TwWX/cKgCtzqbzuJvobe+cbfg6Awwpo85sj4g5P+JUvw1+wSglQJBTIgU3hMo5Oql6AMKsY2ZT4DWJGIAnFriCotad1//D1iGwhHOg+HpezOX3DNjAvMhdJfmUX4gAohb/5aLlpmrpABUaU/RKWJOfF5ZtDrnoetU5NHFCBoj3AWGp0tLV6PXd7HOA/Jw3MVMlI9r52UAgh/ufJ0sIfz9mtm/UoujZZZrUDTeWnUhD1tP3yRpWdOkUbNGsvoGAWRiEYwDZxilIAkwwoL9b3/AXZNXUSp+GsUoGpXsBoMMuSXZeXQFgf22PHaBzrXgpsa7QBPxsPofR+VmerJovrKzb4g9P3vXx3NK0nch2G+LazJ5ttcdTZMniAk85F1eeQGJ6LVrjaGzdC6VQpFjy4jgmItWyCMsCjS4iXJp3I4F96/mTuRhM2f/msA6gurCQNZqeWcJCuzLJKy4FPFR1OFmui/7/dTGKc0+920CAPqHZxIsbcU2Zapctz6JpAK3UwGOsFWj8VeQjhzdGeVpAWukwdRu6VK0KKIlkFtqSb31+rJOH3ZQfnM2lkj8PSJZyQFALFKufHiiAh5qX48IIdMTXR1WgOZxuy3n+pOgpr0wK6fMHiM/yTwx9CNzjPle3USmTFsJP9ygRpMg56jSq7dBt1FsSFU+UEav3x6/Hsmein3FsdiMmjbPElxH1686P4obEqDaoFPbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(921020)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021135927099003)(261026121527099003)(261021121427099003)(261026140227099003)(10067099003)(261021123027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGEvRmJlSkNrMDA1SjhZUkpOMzdZSFlnZUNjZFVKcm5iVnJUQlRTTzBuUmNy?=
 =?utf-8?B?T0RvaGNVeXkxbFE1WjNaZ2R3TlZvRTFlK3lQaWJNMUtaeTFud1J1ZnpJOGJH?=
 =?utf-8?B?YUlLV2ZoaGtoRGpidEhaaElFRzFkZ2lQeDRlL3MvL1hQb0tVcE5YdmNDOWJT?=
 =?utf-8?B?enBlRnNQaTlYTFhoWHRINlNScWNoald0TkdoS3JVc0lRdHpmSkRwNTV0OUJS?=
 =?utf-8?B?MDhRa0JLZUZxa0pHNEdmeWFsVTVjVCt4TGN6NXExbFZIdmNKckJ2QXg0N3d0?=
 =?utf-8?B?eGN1dm1DbklzbDM3R05idjJwcUt4N2NiUFNiblJ1dFdUaUNhUlRtb0N6YXg0?=
 =?utf-8?B?ZlA5MG9Yd04wZDJ1c1VhTHA4bEduRjJweSs3Ymw2ZXhva1J1WExpY2ExdVdE?=
 =?utf-8?B?QXpTRUlrU1FKMmRSVkYzKzJ2TnFVWU8zSWlIOGFWc3V4b1lwNkpTdW1wUnJ6?=
 =?utf-8?B?clkxTGxrdjV3QUxPM3RtRHdWaGplZDZwVGhmTGtibWppU2xQOU1hc1EyNVNu?=
 =?utf-8?B?VnZ6a3N1NUlWTkxHdkR0Vi9HanFhNWtrbjdqVksrb1lZd09IU0FDWm1ZbXNU?=
 =?utf-8?B?MWtDRHJoQXU2K2gyVmREWHRQbHo4VzlnZ2dvRFZLaml6KzRjRFZkSS9aY3hp?=
 =?utf-8?B?SVhDSk9FNDJ1TkZGTXE3R1ZHbW1Kd1crMWplZ1dxMGlSUjNoVHIrRWtreFZM?=
 =?utf-8?B?Nm5LTmNqVGduK2VVN3pGdU5CbjN0RnJvY3R2OFdIc1FSdkhGWUxNSjUyRkF5?=
 =?utf-8?B?blV3QmRvbHhiTmorNVU1YVB6OFlYdm42RnRwZERqOGR0MHFsMUtoWnJodnNk?=
 =?utf-8?B?Z0FBSlB3Lzd0VUE2S2IweHViRW5Oc3Y4cjZSY2dVTU9ZYzYyRmtsVE1mdEow?=
 =?utf-8?B?YitLaWd3Q01QcTZTSnFXQnh3V1FQZXprUHpiS3ErSys2NG9VTlRvL053MXN6?=
 =?utf-8?B?bVVlODEyOElZdFE2VnM0UzhLZmhsZDh3Q1dKVnI1NVBVS1o5SE9sYVUrcVpS?=
 =?utf-8?B?amV2UC9VKyt2VGtkRjdxSWs0Ym5Ydk1SWUdITG1kUnBVeUIvQjdMSW1HcnVP?=
 =?utf-8?B?VjVOdVg2REsyRE4yODZEQjNTNzczMFdSYytVbDk1ZzdEeUN0Vk1naVRiTXBN?=
 =?utf-8?B?Q2dWMWdab2JFSVVoNytCN3dSbDJlNHVXM3g3ZmhFZXcxS3ZRbEVlYk01WVZn?=
 =?utf-8?B?SWpPUnUva2FHY05ZVGNwR2NlcHd4YWdvQTdUOHdaeC9IK2Nad0NxTUxnUlhp?=
 =?utf-8?B?eGFNZUxSZnhmNFFUdTN4RkMyRE1oNW1FUTZjeEV4QytIdzFoMmlXaTROWU12?=
 =?utf-8?B?MXBMZHdZVzhEUDdVaXlMdklHZ2I3YjVsOFhsM0VxZXNmaFAybGoxbUZJMkJj?=
 =?utf-8?B?WlBsWlFGajNqTlRqTFFRVU54L0I4bEdFeGNkVWtuYWVLUzV1Tmw5Q1ZlZG9F?=
 =?utf-8?B?c2d5d2gxbDNDLzA0NWIyMndHemg2M2NuUDN1SWpzdjR5R2FjYUlLNmNRS0VU?=
 =?utf-8?B?bk1iaEtyQ21PcVUwOTBrZDcrMHRpUVZtQXJsTXNkS0d5WnBLWXhKMkxaeWdF?=
 =?utf-8?B?VnJJRUdiZGdZZzUwWjB1VSsyVE1Ucjd3S0NXKzFNbXBCUFlFRkErYkFEcmk4?=
 =?utf-8?B?RGZYWXArR0o0SXlXK25Rbk5LYTMyeG1qT0tvUnZUakNvWHUraW0veTRidnJh?=
 =?utf-8?B?ZnBrZzJkcnRoSitiYkhKS3RvWHBGM21GREtNZ0pGZ211Ym5JSWt4aEtITGky?=
 =?utf-8?B?Kzl0SnFJZnFpMEI0MWI2OFdIWTVhSXM5OHRjMGlnTUZnNlB6SS9jWEh2TXNV?=
 =?utf-8?B?SzNhcHJpcXFTZWpRSmE1aUtPMTdBT0NkQklHTjlhY2FxdGNGaDlpT3dETWZU?=
 =?utf-8?B?NURoanJudm9KMzZFUm5LcWpDam9NOEhMYXZlWFBaOVFmQjFKSkxtaUE5QjNI?=
 =?utf-8?B?N1VrYWNOcjR6OWU5TGZ5UzBMTE4wRkt2R3BOVUdvN3o4QUQyTnRiMFM5OXNB?=
 =?utf-8?B?L2FsVTk1bzliMnpQL1dHeTRaWU1ESUIwcEFmdFM2QWpLRWxvMWJ1b0tYV0E1?=
 =?utf-8?B?dG5ab3dZdkpVVitKSnJKUWNWelFoZitWaGdpMGNVS0pPWFRyQ0tCV0UzUkJP?=
 =?utf-8?B?U0pScU8vOVU0a09YbzZ2SngzK3c0MU9QUnAzenJ6TW84dW1LcVM2QklwQTB2?=
 =?utf-8?B?SE1zdFRuUEVJaWZ2WmtiS1h1STZJZzF0MERJYmhPNXFKSENaS2pwWnR6V28y?=
 =?utf-8?B?bmI4cThmNTlBMmxocStiV1NOV1pUT1hyaTBNTVFIbmwyR0tKN0dhcmNpbXQ2?=
 =?utf-8?B?SUVlSy9lR0JvS2VHKzFJbEVmdzR4anFQVWY5dDYwWlFEbFlEQUFPQUcrUlhH?=
 =?utf-8?Q?zZa6FtUWKuAdAakvMRZJTRmhwez4R9WRUKcWVCvydHwJq?=
X-MS-Exchange-AntiSpam-MessageData-1: WC4APsqjTWXvLw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f390cdf-2bc5-4aa7-4757-08df349a30a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 02:21:35.7912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnss+IyzrGd36w+o4NcuqJQX++VMsOy3TE91yT9GWJlCQocCvefHoWo9mCw8p33pLpu/ONmCA9KUqabNLWFcbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a fixed capacity vector backed by [MaybeUninit<T>; N]. The ArrayVec
is also initializable with a closure, returning an Init instance, to
avoid constructing it on the stack. ArrayVec is useful for small but
varying size arrays stored on the stack, to avoid a heap allocation, or,
for larger varying size arrays initialized into caller provided memory
but not wanting to provide an allocator.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/alloc.rs             |   3 +
 rust/kernel/alloc/arrayvec.rs    | 351 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs        |   1 +
 rust/kernel/alloc/kvec/errors.rs |   2 +-
 4 files changed, 356 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 21067bde6860..510e2c7f9f72 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -3,10 +3,13 @@
 //! Implementation of the kernel's memory allocation infrastructure.
 
 pub mod allocator;
+pub mod arrayvec;
 pub mod kbox;
 pub mod kvec;
 pub mod layout;
 
+pub use self::arrayvec::ArrayVec;
+
 pub use self::kbox::Box;
 pub use self::kbox::KBox;
 pub use self::kbox::KVBox;
diff --git a/rust/kernel/alloc/arrayvec.rs b/rust/kernel/alloc/arrayvec.rs
new file mode 100644
index 000000000000..44cc09ee1e51
--- /dev/null
+++ b/rust/kernel/alloc/arrayvec.rs
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Implementation of [`ArrayVec`].
+
+use crate::{
+    alloc::kvec::{
+        impl_slice_eq,
+        PushError, //
+    },
+    const_assert,
+    error::{
+        code::EINVAL,
+        Error,
+        Result, //
+    },
+    fmt, //
+};
+
+use core::{
+    borrow::{
+        Borrow,
+        BorrowMut, //
+    },
+    mem::MaybeUninit,
+    ops::{
+        Deref,
+        DerefMut, //
+    },
+    ptr,
+    slice, //
+};
+
+use pin_init::{
+    init_from_closure,
+    Init, //
+};
+
+/// A fixed capacity vector that holds at most `N` elements.
+///
+/// # Invariants
+///
+/// - `len` is at most `N`.
+/// - The first `len` elements of `data` are initialized.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::alloc::ArrayVec;
+///
+/// let mut v = ArrayVec::<u8, 4>::new();
+/// v.extend_from_slice(b"abc")?;
+/// assert_eq!(*v, *b"abc");
+///
+/// assert!(v.extend_from_slice(b"ab").is_err());
+///
+/// v.push(4u8)?;
+/// assert_eq!(*v, *b"abc\x04");
+/// assert!(v.push(5u8).is_err());
+///
+/// v.clear();
+/// assert!(v.is_empty());
+/// # Ok::<(), Error>(())
+/// ```
+pub struct ArrayVec<T, const N: usize> {
+    data: [MaybeUninit<T>; N],
+    len: usize,
+}
+
+/// The maximum size in bytes of an [`ArrayVec`] returned by value from [`ArrayVec::new`].
+const MAX_STACK_SIZE: usize = 512;
+
+impl<T, const N: usize> ArrayVec<T, N> {
+    /// Creates an empty [`ArrayVec`].
+    #[inline]
+    pub const fn new() -> Self {
+        const_assert!(
+            size_of::<Self>() <= MAX_STACK_SIZE,
+            "use `init_empty` instead of constructing a large ArrayVec on the stack"
+        );
+
+        // INVARIANT: An empty ArrayVec trivially has all its elements initialized.
+        Self {
+            data: [const { MaybeUninit::uninit() }; N],
+            len: 0,
+        }
+    }
+
+    /// Creates an initializer for an empty [`ArrayVec`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::ArrayVec;
+    ///
+    /// let v = KBox::init(ArrayVec::<u8, 4096>::init_empty(), GFP_KERNEL)?;
+    /// assert!(v.is_empty());
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn init_empty() -> impl Init<Self> {
+        Self::init_with(|_| Ok(()))
+    }
+
+    /// Creates an initializer for an [`ArrayVec`] populated by `f`.
+    ///
+    /// `f` gets an empty [`ArrayVec`] and can fill it in place.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::ArrayVec;
+    ///
+    /// let v = KBox::init(
+    ///     ArrayVec::<u8, 4096>::init_with(|v| v.extend_from_slice(b"abc")),
+    ///     GFP_KERNEL,
+    /// )?;
+    /// assert_eq!(**v, *b"abc");
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    pub fn init_with<E>(f: impl FnOnce(&mut Self) -> Result<(), E>) -> impl Init<Self, E> {
+        let init_empty = |slot: *mut Self| {
+            // SAFETY: By the initializer contract `slot` is valid for writes. Once `len` is zero
+            // the slot holds a valid empty ArrayVec, since `data` requires no initialization.
+            // INVARIANT: An empty ArrayVec trivially has all its elements initialized.
+            unsafe { (&raw mut (*slot).len).write(0) };
+            Ok(())
+        };
+
+        // SAFETY: `init_empty` fully initializes the slot and never fails.
+        unsafe { init_from_closure(init_empty) }.chain(f)
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`].
+    ///
+    /// Fails when the [`ArrayVec`] is full, handing the element back in [`PushError`].
+    #[inline]
+    pub fn push(&mut self, v: T) -> Result<(), PushError<T>> {
+        self.push_init(v)
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`] by initializing it in place.
+    ///
+    /// Fails when the [`ArrayVec`] is full, handing the initializer back in [`PushError`].
+    #[inline]
+    pub fn push_init<I: Init<T>>(&mut self, init: I) -> Result<(), PushError<I>> {
+        self.try_push_init(init)
+            .map_err(|TryPushInitError::Full(init)| PushError(init))
+    }
+
+    /// Appends an element to the back of the [`ArrayVec`] by initializing it in place.
+    ///
+    /// Unlike [`ArrayVec::push_init`], the initializer may be fallible. If the [`ArrayVec`] is
+    /// full, the original initializer `init` is handed back in [`TryPushInitError::Full`]. If the
+    /// initializer itself fails, its error is returned in [`TryPushInitError::InitError`].
+    pub fn try_push_init<I, E>(&mut self, init: I) -> Result<(), TryPushInitError<I, E>>
+    where
+        I: Init<T, E>,
+    {
+        let Some(slot) = self.spare_capacity_mut().first_mut() else {
+            return Err(TryPushInitError::Full(init));
+        };
+
+        // SAFETY:
+        // - `slot.as_mut_ptr()` points to a spare slot, which is valid, uninitialized memory.
+        // - If `raw_try_init` fails, this returns without increasing `len` or touching `slot`.
+        // - `init` implements `Init<T, E>`, which removes the pinning requirement.
+        unsafe { pin_init::raw_try_init(slot.as_mut_ptr(), init) }
+            .map_err(TryPushInitError::InitError)?;
+
+        // INVARIANT: The element at index `len` was just initialized, and the new `len` does not
+        // exceed `N` because a spare slot existed.
+        self.len += 1;
+
+        Ok(())
+    }
+
+    /// Appends a clone of each element in `slice` to the back of the [`ArrayVec`].
+    ///
+    /// Fails with [`EINVAL`] if `slice` is longer than the remaining capacity.
+    pub fn extend_from_slice(&mut self, slice: &[T]) -> Result
+    where
+        T: Clone,
+    {
+        let Some(dst) = self.spare_capacity_mut().get_mut(..slice.len()) else {
+            return Err(EINVAL);
+        };
+
+        for (d, s) in dst.iter_mut().zip(slice) {
+            d.write(s.clone());
+        }
+        // INVARIANT: The next `slice.len()` elements after `len` were just initialized, and the
+        // new `len` does not exceed `N` because the spare capacity was enough.
+        self.len += slice.len();
+
+        Ok(())
+    }
+
+    /// Removes all elements.
+    #[inline]
+    pub fn clear(&mut self) {
+        let elems: *mut [T] = self.as_mut_slice();
+        // INVARIANT: An empty ArrayVec trivially has all its elements initialized.
+        self.len = 0;
+        // SAFETY: There are no references to the elements since we hold `&mut self`. The elements
+        // can't be dropped again because `len` is already 0.
+        unsafe { ptr::drop_in_place(elems) };
+    }
+
+    /// Returns the initialized elements as a slice.
+    #[inline]
+    pub fn as_slice(&self) -> &[T] {
+        let ptr = self.data.as_ptr().cast::<T>();
+        // SAFETY: `MaybeUninit<T>` has the same layout as `T`, and by the type invariants the first
+        // `len` elements of `data` are initialized.
+        unsafe { slice::from_raw_parts(ptr, self.len) }
+    }
+
+    /// Returns the initialized elements as a mutable slice.
+    #[inline]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        let ptr = self.data.as_mut_ptr().cast::<T>();
+        // SAFETY: `MaybeUninit<T>` has the same layout as `T`, and by the type invariants the first
+        // `len` elements of `data` are initialized.
+        unsafe { slice::from_raw_parts_mut(ptr, self.len) }
+    }
+
+    /// Returns a slice of `MaybeUninit<T>` for the remaining spare capacity of the [`ArrayVec`].
+    #[inline]
+    fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
+        // PANIC: `len` never exceeds `N` by the type invariants.
+        &mut self.data[self.len..]
+    }
+}
+
+/// Error type for [`ArrayVec::try_push_init`].
+pub enum TryPushInitError<I, E> {
+    /// The [`ArrayVec`] is full. Hand the initializer back.
+    Full(I),
+    /// The initializer failed.
+    InitError(E),
+}
+
+impl<I, E> fmt::Debug for TryPushInitError<I, E> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match self {
+            TryPushInitError::Full(_) => write!(f, "Not enough capacity"),
+            TryPushInitError::InitError(_) => write!(f, "Initializer failed"),
+        }
+    }
+}
+
+impl<I, E> From<TryPushInitError<I, E>> for Error
+where
+    Error: From<E>,
+{
+    #[inline]
+    fn from(e: TryPushInitError<I, E>) -> Error {
+        match e {
+            TryPushInitError::Full(_) => EINVAL,
+            TryPushInitError::InitError(e) => Error::from(e),
+        }
+    }
+}
+
+impl<T, const N: usize> Default for ArrayVec<T, N> {
+    #[inline]
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl<T, const N: usize> Drop for ArrayVec<T, N> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: The slice holds initialized elements that are never accessed again after this
+        // point.
+        unsafe { ptr::drop_in_place(self.as_mut_slice()) };
+    }
+}
+
+impl<T, const N: usize> Deref for ArrayVec<T, N> {
+    type Target = [T];
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.as_slice()
+    }
+}
+
+impl<T, const N: usize> DerefMut for ArrayVec<T, N> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        self.as_mut_slice()
+    }
+}
+
+impl<T, const N: usize> Borrow<[T]> for ArrayVec<T, N> {
+    #[inline]
+    fn borrow(&self) -> &[T] {
+        self.as_slice()
+    }
+}
+
+impl<T, const N: usize> BorrowMut<[T]> for ArrayVec<T, N> {
+    #[inline]
+    fn borrow_mut(&mut self) -> &mut [T] {
+        self.as_mut_slice()
+    }
+}
+
+impl<T: Eq, const N: usize> Eq for ArrayVec<T, N> {}
+
+impl_slice_eq! {
+    [const N: usize, const M: usize] ArrayVec<T, N>, ArrayVec<U, M>,
+    [const N: usize] ArrayVec<T, N>, &[U],
+    [const N: usize] ArrayVec<T, N>, &mut [U],
+    [const N: usize] &[T], ArrayVec<U, N>,
+    [const N: usize] &mut [T], ArrayVec<U, N>,
+    [const N: usize] ArrayVec<T, N>, [U],
+    [const N: usize] [T], ArrayVec<U, N>,
+    [const N: usize, const M: usize] ArrayVec<T, N>, [U; M],
+    [const N: usize, const M: usize] ArrayVec<T, N>, &[U; M],
+}
+
+impl<'a, T, const N: usize> IntoIterator for &'a ArrayVec<T, N> {
+    type Item = &'a T;
+    type IntoIter = slice::Iter<'a, T>;
+
+    #[inline]
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<'a, T, const N: usize> IntoIterator for &'a mut ArrayVec<T, N> {
+    type Item = &'a mut T;
+    type IntoIter = slice::IterMut<'a, T>;
+
+    #[inline]
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+impl<T: fmt::Debug, const N: usize> fmt::Debug for ArrayVec<T, N> {
+    #[inline]
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(self.as_slice(), f)
+    }
+}
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index c8b312f64657..cd0c57a9ad90 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -1255,6 +1255,7 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
         )*
     }
 }
+pub(super) use impl_slice_eq;
 
 impl_slice_eq! {
     [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2>,
diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/errors.rs
index d24dfe22834a..f5c44fdc7016 100644
--- a/rust/kernel/alloc/kvec/errors.rs
+++ b/rust/kernel/alloc/kvec/errors.rs
@@ -7,7 +7,7 @@
     prelude::*, //
 };
 
-/// Error type for [`Vec::push_within_capacity`].
+/// Error type for a push that fails because there is no spare capacity.
 pub struct PushError<T>(pub T);
 
 impl<T> fmt::Debug for PushError<T> {

-- 
2.56.0

