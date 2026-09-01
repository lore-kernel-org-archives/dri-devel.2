Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B740C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C1A10E421;
	Tue,  1 Sep 2026 05:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="H9Q8LS9w";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2233810E387
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 05:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ80nmOr6hVsfYlMZmUFYjIazRwf9VL/IxsThPr4xXQ7jfiU+NiOlaWj1awO+++SZyabP2S/R+v9jqPKClhMETfuZWR3CyPQt5tCvcJ8j9dbIXW+yR+9kREZS9UvnWK21DKMAYH0WvKl2gOojBeUxDHMV5MaZmlHaiFCDmHE1l0M9jV4xee9OZlXdsu2ZWnkbwt363Yp9CV0CJBX28/rrStHma/+O1oYfZqZ2pMsrq2t+zruDFbKtZgHiVqSUv1gi7IOnWj/1xzZ5zhXy8nbo7KJDdHuhJQIKGCfJFGOuli5pxcLoDxQToBjJw/zceTTG0SkY/GKKHEote3sEOVtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx+YOVj9BOadj8fcx8ZuWX4Mp+U3Dt8u6kYXRmeN0Uw=;
 b=sLuced9qIjQIRBXBt4oGlqUGLE40d5xgeBImMXYzIx475zcm8E5PwH9m+aPCwW9RPzGqBSYQzfLkWsb4nyvJV0VvWHKTIk2KNVjklQThJdGuKNz2AJPXwUZcQnlPTPwkb1TfRVK/m+IhwNNwikvct5rqMNmK9It61jzFryhIp8rGWYWqzUYoEdB5vKwsY8nBGZWVg4xreodC0b3rtZZ4pgLhHDyS31CzOHxujhlwOI5Aj2UDU/vt18+bPQzr2MZmh5WEzjw9rBGpQP/dWYgZSHjtUi2Ufs5Fh/jGKQLOfp1ZgAQ9jvX2xRg/sCuylf6EQNgCdFl4u9QgG86sq1nEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx+YOVj9BOadj8fcx8ZuWX4Mp+U3Dt8u6kYXRmeN0Uw=;
 b=H9Q8LS9wfpbaoxTWaBDHDRhdfSpYLVM6PHzaBRDs3cy56F2hQx0G8zzwglmoC/UloIBlapFA+6y2BpvS0UCDDmHfYxTgr6uJanamnr0w8hX3QMhlMkCWUhyTV/sLNNM4rDSDycr8Et5uatbSkTYqsmSCilMfRdCRaBMUY8rMAqQVmQIlCakvarndFROQNPC+LmhDKyEl1EgN418EZ0LHx4BYrNAHtKFlfShKubxzC2ZAZm5zIp/PfAJ/G02fGKCvbsIUPtzv4P9gDTreFTwF4SAY/rx9SvVvSTGtVvoiNuzdr5NQiGZ2uNQDO9qxjHA0ZJS4nARKbYOlH3meOueyKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 05:07:05 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 05:07:04 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 01 Sep 2026 14:06:40 +0900
Subject: [PATCH v2 1/3] rust: num: add cv! macro to create values from
 constant expressions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-cv-v2-1-446bc69d2ade@nvidia.com>
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
In-Reply-To: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: da8bc651-2ee9-4405-427f-08df07e6dd34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|18002099003|22082099003|56012099006|3023799007|6133799003|5023799004|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: 8DjHlU5N2CQnuva6DIO6GKKc/S9Tg+3cEyR7smh1Peb9BfYLcNMbao9uUMdGNDtJ1IO/jM/R9m9Z5N7PbUQC7mL+q0UDlMuQqcbX2FCKay3prtJKLZ+TAUVrnCGOM/Ocqdy7+zYpMdD5wt0is7yuWBlHIxKfB+tm57KCabJU8RTNFgjoqW1/RSPt00x5YJHhubKKSI9u658JkZtiyJ3CsJCyW4oucpwKY4X2UIl5qNMjYn3hcwZM+px748OeDF083EyoJIkRo8JtdEZPY1SH+LrSTbOc6Y4SK8gych8nULQgVhr0bRzX2Yo5pZdZfFoMV5u9HwcQLCrOVoaBK8wFiKriNNjL/A41uRAmRPLl1hgmCo503iewI4oUDoJJ4bhACENuGc1pPs0OAyvG+ischyaYjqVdmhKuCK0PwoFoIuXiVf3kqiDHnV1NNdivYasKZfExwnDIt2MFZzjBVYtb9qMwYDeI23RgUrsCqKMP95GbCFcUo2c4Kzn80/cdTNDvwJAass0lC8LMmq30mCcyXqNKiTuq5pMn8BIcFhwAUkusqzRmI0MD2kx/QuBX0rhnx0JxFt8OIWyeDs/jsksR9D9fHVyBB05x6PCT334BTmiR8Rjuk/IjgkdlF0yTyQwNY36WKNhS38aovVA4F8JCUAKJLtdOLhwZjnZkxrUsEORQgcV7TaWU0NDoakwLcvafdm2p2U/rlYApsdvUhbeQuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(5023799004)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUxvLzdXdlhQQldwVFVJdlcxb3lFdENESkhmR2pqNW5MVHd6SWxmSTF1LzRn?=
 =?utf-8?B?SitnRWtUNlZsN1hvbGx1MTl0ak4yY1BKYnJFZ1IrOWNBekRSb2JpM284MnFK?=
 =?utf-8?B?UGl1TDBmaXoveGxjU0RZQ0xLUHhkUVkzcW0xMXFIWGRUUU43enhKc21mZkxw?=
 =?utf-8?B?ZnJEKzFDUm55ZS9hRW04TWxDdE95Zkg4MlZDamJiSkhWQm1hMHRCaklsOXRP?=
 =?utf-8?B?RG5XUWgrTlg0aFpQUkhvN1R4cXRHR3Rhc1k1ME5NM0lZb25HZWVwOGZINjkr?=
 =?utf-8?B?RUhTa1VkRnNldU5wcU56Q1VGV25LOTM4MU5iY3dRN2lsbWxVdmQ4L0hMRWg1?=
 =?utf-8?B?bjFVU29Td3ZjV3gxUmg4Sk4zRHIzTnpLZXdnTTlLNlVkRXBWcnFIdmQ1amJU?=
 =?utf-8?B?bVhzNTdTSzJSMGRxYVJEdlFyMStlcHczMjFLeTNLMjdpUTN2UllRTjh0TWxs?=
 =?utf-8?B?MzZhdlZ1OTBrRE05ZjBIL0MrS2VqZDdqeVJtaERwU29ZK09rdzRLQXp6dTBj?=
 =?utf-8?B?bndGS1pLak1peUJ4RVR3eENLT252VnRaR3FGNnlXT2lBMWZBamNIaDlnVHBz?=
 =?utf-8?B?RCtUbWlVck1lV29WNDlNVXI3THQ2U2J5RWZHOHhFT2hpS1kzZzhnNFhIN0w3?=
 =?utf-8?B?UGIvd0dtZllxL1RVdjhjZm55eVB1ZnE4ZGxCdjRBbS93a1dCN0VTMzhKdWV6?=
 =?utf-8?B?OEFnK05qYlZUNTYzbnd6YldmSmw4cnVjVmF5NWRwZ09lSkxBTnRObFRKZXZa?=
 =?utf-8?B?M3ZnVjNqbTlZTzdTZ2VubzhpbUY5emxvYVBYbU5uOStZWVdDcGlvM0tPUFFO?=
 =?utf-8?B?WDVUSm1Xem1KWGtRK0Y0NmFkUVBUZE9PTzB6NVN4VDBSUXVHZzlJM1djTUlD?=
 =?utf-8?B?ejllaWhvRlhMemtwdlgvOXVhUnJlVmpRSkJWRlFvSWhVQjA4WTdXQy9mUHE3?=
 =?utf-8?B?Mnp4NG4yanZQdi9WNTVWNVRCZnY2a1VLcFlxK0pNSXVaQlNYaEt5SElnc3dk?=
 =?utf-8?B?MHBIeDdlN1NmMSthSk5iaWhIc2QraXdwRVNlNHUyMjlMbEVFL1c3aE1OYmk5?=
 =?utf-8?B?OGliZkNlYVhYbW13bmNYT0xKanljVGFQdWlWNkFpOHplR0ZoNWxpdWZwQUp0?=
 =?utf-8?B?azdvQzBNL2JGTnAwMmVYYk1yWE5pc3BpY3pSaitsRVg2NFVQWnQ0ZlNBUjFM?=
 =?utf-8?B?T1RxZ3gvb1ZqSmZiMXI4MlFOVVl6cnBNY0lkM2dkSzg1WWk0V29hZVQrbFg1?=
 =?utf-8?B?Zmg2NFd0R0FMaU55ZTMrbVVhSUwyWTNrVElEa0pTbUgxV1NEZ0M4cGtUQXBu?=
 =?utf-8?B?VzdwZWlXSVN2MlliMFVYZXdZdWF6c3NiZ2R1blRxdGY2L1RpUzlVbmRxYk9S?=
 =?utf-8?B?bEw4eU0vRlJwNTVMSEYrYXBVRFpvVTdTbG0vMCt2SVlRTVNjR3BmNGZPajJs?=
 =?utf-8?B?bVVCbTBiM3FkcSs4R28xS2pnZWs2R0xOYTEwdGt4ZWYyY2M4V3VCNXVvTHY4?=
 =?utf-8?B?VTJJQzhYdnM0cXZkSUM1aHRnRVJZdGw2eXQ3WTM3eGVDZzF6eU9EcEVZOTZs?=
 =?utf-8?B?YWhFZXdsZ0NLcVV2MnlDM3gzMEJtOWZxRis1UE9QeWtYUkFpem5tMUYrd01Y?=
 =?utf-8?B?anRvMTQ0OFU1ZjVuL1JRYmNQVEtSMHZiYy9hTk9FU3JuT0YwMnVvM0NxMkhF?=
 =?utf-8?B?OUNMcUYvcE1hWVFkOWhmNE9xRE5hN1I2cjVpWW14ejFzbUI1N29ZVFpzU3M5?=
 =?utf-8?B?MTAzTDNodU9lOHpnUlRhR3hHbkoxamRkNGE3ejBzRnpxNUx5Vk9jZ3BXNzJo?=
 =?utf-8?B?Y3BCaE1xT1cvUjc0YUIvTGp1RTZTRHlLVXQ1VTNlL1ZudEpqeUVZbm1nbUVv?=
 =?utf-8?B?T3FEM3NiS2wyaDdmMmU4OSs0Tk12RnVOZWpEVlBrOEo3aUdoUkdXUkxBL3lo?=
 =?utf-8?B?dkx6MmxSRm10ZDJyM1NKemptV1dVZTdzbUxBZ3paYThqd1RWRFdXeXZhc01E?=
 =?utf-8?B?MG9KbjVVWDE5OThsMW4wUXY5QUx4cjkvRlhQb0NRN3FvbkQ1NW01UUdZNWpM?=
 =?utf-8?B?dGNkOXgzcDBZUkJ3N3EzdGxIemVRVTJva2ExY1F5M3BEUk8rVWFFQnlzbllv?=
 =?utf-8?B?RGhVWCtWME1VdGY3ZlhqNENsc0V1OERWM1dFRkpYSFNyVE5QczFSVkFoWllX?=
 =?utf-8?B?S1BiSVo3d0M3R2ZFYXNSTXBKRGd6Y1FUY0JVVFZVaW5BR2owOVB0Qi9waEQz?=
 =?utf-8?B?OXNFOEdHODV3aTZ3QkxSY1YrR25nWGZxK0tnNklhTWoycG02ejlRdEhCdmQv?=
 =?utf-8?B?cGtlQ2loUlVVTTA2U0hlcmZ3TzFHdGQ1TFpiblRYSDFnL0hJMFVRUElrd3hN?=
 =?utf-8?Q?H/X8p4bzKWpLeaRM99OggdRG/oF5ooy01QfiET4pwwR3A?=
X-MS-Exchange-AntiSpam-MessageData-1: PsixfWShU6/YsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8bc651-2ee9-4405-427f-08df07e6dd34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 05:07:04.6554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOEOLN4dfDOfEZm1Y2WH3XxSgNZMMG0ovbCC0k5EkHoyNNcz5AGtR5WhL72Rly1e+1iBnDTc2kFRzZ5QRCAdkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

Currently, using NonZero/Bounded constants is quite verbose. It's
unfortunate because it disincentivizes using it in interface boundaries.
Introduce a macro to make it nicer to use. The macro `cv!` (for constant
value) takes a const integer expression and widens it to i128 (at build
time only) before passing it as a const generic value to a new trait
`FromConst`. The value is then converted and appears in the
associated constant `FromConst::VALUE`. The trait is implemented by
NonZero, Bounded, and Alignment and lets values of each be constructed
from constants without a verbose turbofish syntax.
For example, `const { NonZero::new(1).unwrap() }` can be written as
`cv!(1)`.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num.rs         | 133 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/num/bounded.rs |  19 +++++++
 rust/kernel/ptr.rs         |  14 +++++
 3 files changed, 166 insertions(+)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index dbe848e30efe..01ae2538b3e4 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -2,6 +2,7 @@
 
 //! Additional numerical features for the kernel.
 
+use crate::const_assert;
 use core::ops;
 
 pub mod bounded;
@@ -9,6 +10,138 @@
 
 pub use bounded::*;
 
+/// Creates a value from an integer constant expression, with validity checked at build time.
+///
+/// This works for any type that implements [`FromConst`], with the target type inferred from
+/// the context, or named explicitly with `cv!(value => Type)`.
+///
+/// # Examples
+///
+/// ```
+/// use core::num::NonZero;
+/// use kernel::num::Bounded;
+/// use kernel::num::cv;
+/// use kernel::ptr::Alignment;
+///
+/// let v: NonZero<usize> = cv!(8);
+/// assert_eq!(v.get(), 8);
+///
+/// // Any integer constant expression works, not only literals.
+/// let m: NonZero<usize> = cv!(usize::MAX);
+/// assert_eq!(m.get(), usize::MAX);
+///
+/// let b: Bounded<u32, 4> = cv!(15);
+/// assert_eq!(b.get(), 15);
+///
+/// let a: Alignment = cv!(4096);
+/// assert_eq!(a.as_usize(), 4096);
+///
+/// // Checked narrowing of integer constants, including in `const` items.
+/// const SMALL: u8 = cv!(200u32);
+/// assert_eq!(SMALL, 200);
+///
+/// const N: NonZero<u8> = cv!(5);
+/// assert_eq!(N.get(), 5);
+///
+/// // The target type can be given explicitly.
+/// let e = cv!(200u32 => u8);
+/// assert_eq!(e, 200);
+///
+/// // With an explicit primitive target, the expression can use generic parameters.
+/// const fn as_u64<const KEY: u16>() -> u64 {
+///     cv!(KEY => u64)
+/// }
+/// assert_eq!(as_u64::<0x40>(), 0x40);
+/// ```
+#[macro_export]
+#[doc(hidden)]
+macro_rules! cv {
+    (@cast $v:expr => $t:ty) => {
+        const {
+            #[allow(unused_comparisons, unused_assignments, clippy::as_underscore)]
+            {
+                let v = $v;
+                let r = v as $t;
+                // Pin `back` to `v`'s type so `as _` casts back to the source type.
+                let mut back = v;
+                back = r as _;
+
+                ::core::assert!(
+                    back == v && (v < 0) == (r < 0),
+                    "value does not fit into the target type"
+                );
+
+                r
+            }
+        }
+    };
+    ($v:expr => u8) => { $crate::cv!(@cast $v => u8) };
+    ($v:expr => u16) => { $crate::cv!(@cast $v => u16) };
+    ($v:expr => u32) => { $crate::cv!(@cast $v => u32) };
+    ($v:expr => u64) => { $crate::cv!(@cast $v => u64) };
+    ($v:expr => u128) => { $crate::cv!(@cast $v => u128) };
+    ($v:expr => usize) => { $crate::cv!(@cast $v => usize) };
+    ($v:expr => i8) => { $crate::cv!(@cast $v => i8) };
+    ($v:expr => i16) => { $crate::cv!(@cast $v => i16) };
+    ($v:expr => i32) => { $crate::cv!(@cast $v => i32) };
+    ($v:expr => i64) => { $crate::cv!(@cast $v => i64) };
+    ($v:expr => i128) => { $crate::cv!(@cast $v => i128) };
+    ($v:expr => isize) => { $crate::cv!(@cast $v => isize) };
+    ($v:expr => $t:ty) => {
+        <$t as $crate::num::FromConst<{ $crate::cv!(@cast $v => i128) }>>::VALUE
+    };
+    ($v:expr) => {
+        <_ as $crate::num::FromConst<{ $crate::cv!(@cast $v => i128) }>>::VALUE
+    };
+}
+#[doc(inline)]
+pub use cv;
+
+/// Types that can be created from an integer constant expression validated at build time.
+#[diagnostic::on_unimplemented(message = "`{Self}` cannot be converted from a constant")]
+pub trait FromConst<const V: i128>: Sized {
+    /// The value that corresponds to the constant `V`.
+    ///
+    /// Fails the build if `V` is not a valid value for `Self`.
+    const VALUE: Self;
+}
+
+/// Implements [`FromConst`] for primitive integer types and their [`NonZero`](core::num::NonZero)
+/// versions.
+macro_rules! impl_from_const {
+    ($($type:ty)*) => {
+        $(
+        impl<const V: i128> FromConst<V> for $type {
+            const VALUE: Self = {
+                const_assert!(
+                    V >= <$type>::MIN as i128 && V <= <$type>::MAX as i128,
+                    "Constant cannot be represented by the target type."
+                );
+
+                V as $type
+            };
+        }
+
+        impl<const V: i128> FromConst<V> for core::num::NonZero<$type> {
+            const VALUE: Self = {
+                const_assert!(V != 0, "Constant cannot be zero.");
+                const_assert!(
+                    V >= <$type>::MIN as i128 && V <= <$type>::MAX as i128,
+                    "Constant cannot be represented by the underlying type."
+                );
+
+                core::num::NonZero::new(V as $type).unwrap()
+            };
+        }
+        )*
+    };
+}
+
+impl_from_const!(
+    u8 u16 u32 u64 usize
+    i8 i16 i32 i64 isize
+);
+
 /// Designates unsigned primitive types.
 pub enum Unsigned {}
 
diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index 2a2b0a4bca5e..0cfb3ef16a6d 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -14,6 +14,7 @@
 
 use kernel::{
     num::{
+        FromConst,
         Integer,
         Unsigned, //
     },
@@ -272,6 +273,24 @@ pub const fn new<const VALUE: $type>() -> Self {
                 unsafe { Self::__new(VALUE) }
             }
         }
+
+        impl<const N: u32, const V: i128> FromConst<V> for Bounded<$type, N> {
+            const VALUE: Self = {
+                const_assert!(
+                    V >= <$type>::MIN as i128 && V <= <$type>::MAX as i128,
+                    "Constant cannot be represented by the underlying type."
+                );
+                // Statically assert that `V` fits within the set number of bits.
+                const_assert!(
+                    fits_within!(V as $type, $type, N),
+                    "Constant cannot be represented within the given number of bits."
+                );
+
+                // SAFETY: the asserts above confirmed that `V` can be represented within `N`
+                // bits.
+                unsafe { Self::__new(V as $type) }
+            };
+        }
         )*
     };
 }
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 82acb531b17b..ecb73bdb0c5f 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -166,6 +166,20 @@ pub const fn mask(self) -> usize {
     }
 }
 
+impl<const V: i128> crate::num::FromConst<V> for Alignment {
+    const VALUE: Self = {
+        const_assert!(
+            V > 0 && V <= usize::MAX as i128,
+            "Constant cannot be represented as an Alignment."
+        );
+
+        match Alignment::new_checked(V as usize) {
+            Some(alignment) => alignment,
+            None => panic!("Constant is not a power of two."),
+        }
+    };
+}
+
 /// Trait for items that can be aligned against an [`Alignment`].
 pub trait Alignable: Sized {
     /// Aligns `self` down to `alignment`.

-- 
2.55.0

