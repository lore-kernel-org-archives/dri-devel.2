Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AA5C61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E54010F311;
	Fri, 28 Aug 2026 09:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="orUuBMSN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5B210F311
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkeCUV9ip8OX9GgWC5CSRcYgbdlig/wX5hQKjejecItrJDfENh7KPCiEN0DU15agsk3YffN2lNs6wclshqnVeQqY0c7uS/qIJlkBwGOJWfftaTAm47y4/eY3NxUwU1cj8NuiDyNIlPpfG8DxQ5o0xkpHeCAO7o7ShKJrL9p+cdEmmORbBMT9Lz1sEok0GmOVeQf7wuKhmA5jP8xEnTVAZRsR/+0oQgujtd5fvwN5VGCQE3gcGtQE2VRaDHwxT9q/XMjoHnFaVl3tJsQmU4GLO2i41MUwo2kws0S523tQwcSFuOeIuIVBr3hrap2qrbMEAWSyUTKiXgbiZK9DS2sZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u83uyYWqCW/wy37fBp8b5+eVcUOJym9WzPsWdkmJdbc=;
 b=DT7CTR2TofBwhPdSzQyFe62l+RbmB+AeF7JkBfzKUBGJNym+vQMrkS4gtWvfNU23XQw0Jl1suHvml1mJZDrYfPfD0LCPG6AECdCzlX13WXLMe0bnWL/gFMjzgxThPgaRFvNq7ulqLpcEpq60yCvDUEoSA0rvd/4S4dKLcHri1ak5Y0SX8se62DPs6RIZ6yoOV11eUpghjIjz/KXKjr7eo0xf0NpJmqXVsyO4XRF8WyZ4hLYeRaw/I6QCMPZoGVVp+7CG4+5Bo2gC3HeFxavC4yXTg7gX+y0oeGZwjuL+s61RWTWc0jlOdJRUOZccfSxO/uvD/ZusACWNvYddQBcQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u83uyYWqCW/wy37fBp8b5+eVcUOJym9WzPsWdkmJdbc=;
 b=orUuBMSNpIHj6/BYoLrmdEL9pPCpWAN2FE/DGdVEGgRf6ISBZZ6EElvFvmIAdowrZGoxlWCWdmnpd41hkkpZU4o5Jj2ZxUl5dsBg/wnWCYAilQqXDK1vj7RGJD00pU/36Omx1r1HIF00GKYEePZPCsp8vHx3JiW5h4PFUKc25/48DjR7IhtOv7atIDHrXTPzb3FXOQAYYgCVB/c62Zg4/9+MnEd5F6V8AgAIL6FmIRuiolhK1pXnoX1m1ASB5m5Bo7lfkmcf5sMmoVt7R9eekQrBRrFlp4ZW/5ZNLzbZOErEMVVTffLgHFux5xZd+TZ1ODZPzZAf7XpkBegm211xzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Fri, 28 Aug 2026 09:16:40 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:16:40 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 28 Aug 2026 18:15:56 +0900
Subject: [PATCH 1/3] rust: num: add cv! macro to create values from
 constant expressions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-cv-v1-1-48a180dfc4c8@nvidia.com>
References: <20260828-cv-v1-0-48a180dfc4c8@nvidia.com>
In-Reply-To: <20260828-cv-v1-0-48a180dfc4c8@nvidia.com>
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
X-ClientProxiedBy: TYCP301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cbed09-10f2-4f05-efdd-08df04e511f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|23010399003|7416014|366016|921020|6133799003|3023799007|56012099006|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9Z0X7Bht564eBOlIp+RnRMHLHdOuZwsIDf2fMXHmzeJyk7eZAzQ3bypJAzG7T+Ecq3vgxKdgD0FqXWHM9QxTKahDGE7KF+sqHAX1uwWuCElVgIBnLUrNsbnQG03Agd69IVjfLgU9+MIDdeqNaA6DgvjTMnKRGvZuOUXVAys/H2Y4SqymGvqo/hndffFzo8UDfMwMjervJwnqCN2PLg+LWD7rCEEHXT40oR2A3rEo2IsAG+8qzVi6Ng8CcKSvx3fDk/X3Xa5U/PJMbqc8PEnWC46M6Zak1CvQMCyxZMtr7b0G1mt5uATvVhmeE+vtFphZEWWZE5vTnZ/0wGhSJSB7/L7vGJjvbN/aRbEmzXdFxMJ6QzpjBrtu484jBgrmxbnDjYgf95iwKnxmMvbazQ93EzRnA/c9mZZ+BfZZc6z3rg8SVstIfuFu4XDZIoQ+7/PhjPCxJ24E0NQJdiOTEVsYNqFCCWWeyLtI23ot7qPBMelpsNHf8BcUk9JRVZ3AUtk3/BjTC2hmANqkr7ukMilJi0gbFf7MuY7uJuR2GAqFNe/Mgq0+KGNnLRaH3UEn90fonqt02JFE02pkGjG4DbNTEhDgaLBF2jkO4dBFm2/VtMuatqDGAjyqxnIBJuDujKQEGgrCBGxc2g8iQ5zDFuaxkfkHpBFRXTS0FKcwPWJUcn+byGmSgVsiw8dWHwmaac22ii/0I+sCcjz/4IlTCc0WwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(7416014)(366016)(921020)(6133799003)(3023799007)(56012099006)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3Y1MEJ5eEorWm1ucmJZY2laVHMwRVJwMlNoSWJ0TjBoWWxHK0VtVGZXTnRh?=
 =?utf-8?B?T0M2bXpEYnlsZjRHMFc3cFVnUGNLV243YkdhKzNoZ3kva3pwSXJnV1M5aExW?=
 =?utf-8?B?eEVNKzNwaUs4WmN5ZG1OL0d2VUpVUFNNdk1NRERkTmEzZ2l1cXNGcWRYWGQ0?=
 =?utf-8?B?L0FQUDc2SWxaMkp2b1RQcmw1WFBCU2VqM2hNeXU2cTF3WEMyY1YzNzd2ZDBG?=
 =?utf-8?B?dnJxMlhxUVZ1TkF1RmxORWFWL2lZQnFXV0F5Q1NiTjZ3cmRuaFMvWWJTNm1y?=
 =?utf-8?B?SHZoNzNXTEFLeXovUHhGRGRqTmUxL2tvNGprSm9mRzVTcXZJWDRsL3FHY0Zm?=
 =?utf-8?B?bkNuN1hoamlQZjY1K0NTUlljRktGNWVqKzdGam5LVndGdmVqdmRRN0ZJOXZ5?=
 =?utf-8?B?OHpRTFFXV2cyeEFXTzBWRXEweG8yN3BNMVlXNkhWYmVnTmNuNU5ha2xrdzkw?=
 =?utf-8?B?MURvTVpYekhVcDBnQ1g5WW0xR0dzeVF0dk1GTDB3ZjRkZEhKZTVOU0JPWGhF?=
 =?utf-8?B?MXZhSUh3d3BGOHl1YThVQlgvakRuY0dwZ3lOS1JJN29YdUFZUFoyT1p6bG43?=
 =?utf-8?B?b255TFZ2dlBmTU5oMmUyZnE4WlJCNU1GeEVkN0ZEdG5sRzZHdUpqbGh2eXlz?=
 =?utf-8?B?bEdDeTBCSVNVL0toNzFVNDlXVnJTYXpZYjh3RWhReHFrUnkwWlRHQmhoVmFz?=
 =?utf-8?B?Rk9Vc0NOL0M2TlJacW4xQjNWOG93QmQyVFpIRWNEbElDMWZLWDVWY09USWxY?=
 =?utf-8?B?NDZPTHU0K0VVQSs5Nmh6MWVrUVQ0MmR1T2FvS2IvaGx3ZWpZZENpOTRIMFAv?=
 =?utf-8?B?SWpaMU43RnZZSVA3ZUp2emFvbE80TmNQTGUyMDcvcGY0UDFlVURjZVVQTjhy?=
 =?utf-8?B?ZGgwYXNYSDFKRDN5ZXlHYytNbnI1ajJRTzZjbzlJNWo2VnFhSkpJeHFWV0ov?=
 =?utf-8?B?WmhoQlZ6YzdNMGx3S3QzZXE1eEoxYnF4WDJWZHZLTG9tdFp3RzVHTkU4S1Rq?=
 =?utf-8?B?dWVNWVVMamJ1WjY5TjM0YXEzVk82STJsNWlpakVDdUZhSmFGZGNMT1YyS291?=
 =?utf-8?B?L2dEQmtJdm9kZS9MYXB6Z1o1Ukg3REcxUnZDbXhRV1l2SExBTjdpRHZrb09L?=
 =?utf-8?B?RzN0em5WcmFENTZ0c3h4dXl5MnN2SHhLMTRra1VlaTQ0NGZvUEVvckFRbjJs?=
 =?utf-8?B?RnhpUm54VEE3RDB0cW9mZWl5UW1ZQS8xbXhTd01mOHlHN2ZLN2NldHF4NXRK?=
 =?utf-8?B?TUc3NlgzcitFcTZrVnlNTEtjeEthQU55bUU1UHl3WDYxQVNsK1pUbG16TnJN?=
 =?utf-8?B?cWk3Ym12UWNIdTBXUlFoeEZnd2ZqNVNwcWlmOEkyTENiSU0vaXB2Sm9qa1Bt?=
 =?utf-8?B?dmx3cUtBbHhxUmRQQ2xkcmhEUVloYlpHRGNYN2p1QkRxTmowODlyUkFReEtw?=
 =?utf-8?B?Tm5BVXcwR2l4UG51K0d0dUtqMEdqSGFmMitKTXdnYnRvS2lwZ213bklzcVJn?=
 =?utf-8?B?aDAvVTB6eWFKUnVwTDhiT1c1VmRKVjVpclh3RW52WTYrbk9XcGdhQ1IraE03?=
 =?utf-8?B?K3FOcDVRT2hYaDFlN1YvbWtiOVhIbDFOSjhRM1JRU3kvU1pCeFRoN2YzMmd1?=
 =?utf-8?B?YkJXMXRvdDBYbmd0WWhiVi8zZjM1WENnc3BkYlAyZzZuSFZOL05YcG4wZ1NM?=
 =?utf-8?B?Zm5lVTMzRjUzTE9vT010cW1TOEMxOWMzZzkzTXN6WmJUQVc0QzErdndHSXhK?=
 =?utf-8?B?MjljSGF5cE9mSnJyMHZpdG9PUi9ZK05YbDl1ZE44OGZjeUtSVGpvUVBwVVRF?=
 =?utf-8?B?d3ZGYVdyZ25hbVJTOG4vcG94d21SWVVZemVNOGltZ0dHRmdtN0pySVFiSG95?=
 =?utf-8?B?NU5ZNnpHTXpZRERGaXMyZ3EyUTBucVhzNFhWbUwxNG45SmYycFhGMDdqck03?=
 =?utf-8?B?RjlTV3lwallUODhJdkQ4VDE1dFFBZi9kSThVZEhMYW05cUhkVi81bUpRUXZh?=
 =?utf-8?B?QkpwVkNVTUtmKzhCWnR3ZktzNHZZS0ljRHh0QWhMdGF5cUdmbGFtUzBreWJC?=
 =?utf-8?B?UkJEblA0TmNrT1NQWUZ2ZjJCcVpZTnBVT1dLcFFGcjBZTGo4eCtybXNLeWJG?=
 =?utf-8?B?Q0F6QzhFN0VFMlRXVXp0eTJCSTBUYUM3TUlRbzM2RWx4MjZSaDhqQi84cmxO?=
 =?utf-8?B?YnRIVk9OWXBwNk9YOGVwS2RaVWJyT0VvTmYzU2VTanRGQkNIdlFGa2ZoNmNT?=
 =?utf-8?B?N1VUdmpTdXo5UTlyZERwenVwU1hsb0gyeTIrQm0rUGttSzJ1ckw1UHlMTlg0?=
 =?utf-8?B?NGNLZmJlZTF6dWY0UDE2TnE4U1E0YTQ0Unl5bmhwdktZQWY1TVUxeElIN0RR?=
 =?utf-8?Q?haEP14hZEdXW/J8CdsqAlfLy3kM6sJ/jSW0s66t3wkDFN?=
X-MS-Exchange-AntiSpam-MessageData-1: 7zqlu1WGbJs/Mw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cbed09-10f2-4f05-efdd-08df04e511f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:16:40.6313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jg5bZsWMbj190094HWtSPribsst9/m+wg7w2LSgbS+s+AhaAvwgZRgePaHlBMubJ+cZ5UY/U2LxXY+2HBRelQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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
 rust/kernel/num.rs         | 132 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/num/bounded.rs |  20 ++++++-
 rust/kernel/ptr.rs         |  12 +++++
 3 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index dbe848e30efe..d9e4a089d128 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -2,6 +2,7 @@
 
 //! Additional numerical features for the kernel.
 
+use crate::const_assert;
 use core::ops;
 
 pub mod bounded;
@@ -9,6 +10,137 @@
 
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
index d192610a687d..b5ab77fd99cf 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -13,7 +13,10 @@
 };
 
 use kernel::{
-    num::Integer,
+    num::{
+        FromConst,
+        Integer, //
+    },
     prelude::*, //
 };
 
@@ -262,6 +265,21 @@ pub const fn new<const VALUE: $type>() -> Self {
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
+                const_assert!(fits_within!(V as $type, $type, N));
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
index 82acb531b17b..7d75a537ecae 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -166,6 +166,18 @@ pub const fn mask(self) -> usize {
     }
 }
 
+impl<const V: i128> crate::num::FromConst<V> for Alignment {
+    const VALUE: Self = {
+        const_assert!(
+            V > 0 && V <= usize::MAX as i128,
+            "Constant cannot be represented as an Alignment."
+        );
+
+        // The unwrap fails the build if `V` is not a power of two.
+        Alignment::new_checked(V as usize).unwrap()
+    };
+}
+
 /// Trait for items that can be aligned against an [`Alignment`].
 pub trait Alignable: Sized {
     /// Aligns `self` down to `alignment`.

-- 
2.55.0

