Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5EAC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CFD10F0B2;
	Wed,  2 Sep 2026 09:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUd5+pVe";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F5710F0B2
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+PvWRcgYSPnyoBSX//6zgcYyTXX036eVMaHerFsCtfNr1LSNzyAyxgxGkEV6VmO7mhI2l92cnKfnCsIkZWD9Pel3t5FI0OsGNHxy9M3VJp11msL86ZVIi1zgwfASKFu5N8qXt15T2JkCCYSq8c3LuWoGAOPvbP6H5chlhZGiabD4PaAaL6+3qJiBd8S8eZOQ3hW5XDQ8/ES5KYep7bE2jljBpc90ZEnYE8YpH5anmUoJ/K8NaQtxGlzxtVRA8f1ifOe8w33TQmlmJMUHVSU0Os/TptIH6u4Hwy21cF2nC5NlPufQmSEZcH5dMr/Ha1xgTGzKt7tq9La1W1T54UnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grBtS3F+lRjlVWXAb4lZXh4ngV4EekOYFIZzRBL8BTc=;
 b=Dk78LZL4MzG7LikMCElEUmJN0+hxQbUXdGYW4ZHcoQZklI7j47h2ZzlHl2G+a0ele+ak8AP2NFSydxgm0AW7CSagFiKowaLplIkJgSbz1jwx4ff9+Shr+rwBkrFB3giczIAw1Jd7cfyfYtJrDw8RYSKhdotTOI5ihEQbkFnnhtoJs9tAkfnaohRyr9oiCwSTJvZdRiDdHvB7BYP2Zpk/0xt4/lsNUfGnq2kYKugN44BZR3EA6/uu0oIWcmxygi1uSroEbKxQO1HKVLVyFg/mRdkm1dbmn4Jt5EjroJ+Ka5SBBv31iQaSvifoQ5Rz3NuJyrl/RshZXiX7Z4Uusp1Nxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grBtS3F+lRjlVWXAb4lZXh4ngV4EekOYFIZzRBL8BTc=;
 b=oUd5+pVecwm+BQhLjte5r1bW0tvT8Y6qy2+mhtL0SD/2MHKwt6s8eT/bhoMZclySG+ikBIjHvXsf472Y9Cgq2abQdvelzuF4QNXpGhhUc+CfRULX3Cmz752uV/6pwv6Xcgr9KWoPswHRBMDuke6TSlIdIoIG6x30hZ4NZY0M1FdjvEmUuxBP8r6zjshWAOk1HmJ3kfujVhXgPacj0z39a3X8UfXPdPGAqhNsfCRzjuWTYImFFUsqZiR23PyDSnIZgbeItFrlHnIwAVlxCS/72zY7jfn9mVLsiKPmrIG1h8tt1lBz1Zv1zzrsWhgu8m2XAlqcWazh27F/jdU5XoNXRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Wed, 2 Sep 2026 09:17:04 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 09:17:04 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 02 Sep 2026 18:16:40 +0900
Subject: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-cv-v3-1-0f90659e711d@nvidia.com>
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
In-Reply-To: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a42b66-2cb9-4b62-7bba-08df08d2f41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|921020|6133799003|11063799006|10067099003|5023799004|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 0uCx5pBB0KMs4XZA3lpAdVVsRFMIhOH+eDWl81/PkJeK3aBps19VRQheRLZTh4XKbz3YPcLZKjuTyn874z0xILMWE45kC0LYA20SDOvlpCN2cE7euiGrf/GbsKlEfJaQYwo91+3NFzqXNGxUvk3PdHH10KCbwW9kzNDMWB2K6BgzlcdzAdZtA0S/eolSn8oo4WIVb/Q5V77OOKPDjj1J+xilVHV/W4x6q0Hk7tu2J7cPnOgY9Jp2koEYDELbyxduwtZXdRWEAYsHr67yj+5lQkGyE4FYjhOe+zNk1s/scwQ4ZUd5DXmkH+rbIuBTs8X1BBu5D8BDXcE4BXEPxo1u+IQfCukLH0lbDyDbCio6YJ0asIvCSWnc+SJHY80FLEuoqRFKEfEm8D67lU37gNhrqrzi6uRGInqs/mvHYPtiWWiH78OWuGgp3rV5VCYyPbQd+jfqeBiWAdT9257H27TnupU8zfrniUrdHYHNSxUVINmUmNP/VrQwHaVdgQi3vvAZWz8iHOH8Yo0XuWOwoNAoCw9xk49E6Dhgm+3L/X9+WG9RE0Xn5q0VI6PHzNgWy3MxpYMzzIyG//9VHx4dN2abidVDOSX5FRlUWhOmXi4fP9hnxB85WHrHLIgwERl+PdkH16FCVj3gwmsqZObKhMgKOMQhBfCfUjGZKD97SQ1srwRyEcgkvMKPaCVrBE8p4P4i7UUsMeABfGN/fWlEP16SDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(921020)(6133799003)(11063799006)(10067099003)(5023799004)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHpJTTdkdjBIQklPN1FLRXZLTlJOOXU3R3pUNW9YajRoaXZBQXcvUE0zUHRj?=
 =?utf-8?B?UWxBc3FEUC9XVlJFRDlhOU02bmhTdFVvZVpjS1FETEo4ZGpPTTU5cDVoQ2N1?=
 =?utf-8?B?QlZtK1ozWEt1SnhHdnhkamZHYXM5Slg2OFV2Z2JLeUZha2RibFRHWEJNVkc0?=
 =?utf-8?B?RU16ZHEvRWVCSjU1RGlvL2RFcGNiK0FtSEh4TytVSUEzb1hZUkRUdUc4UTdX?=
 =?utf-8?B?WFNLeDlvTDNmL055aW81VnN6NGZZbnhWWWY3WSs3WnVxTUxNMnlxRkxFbjZz?=
 =?utf-8?B?K203M3EvNkx4d2lVN1RaMC9hOFJSSzRBaWx5NGlCa3Y4cXkzTDNvaDk2UGh0?=
 =?utf-8?B?d0k1cVgvY1p4cTJkZlhPUFhGTkFsd0JyNy9RUVhFakxmTTlxenUrS1dPZWdp?=
 =?utf-8?B?L1NWQmZ1Rkh1NkxQazE2TFFKcC8vTUVwOGo1VHNXS3E5SFljcjJBbktITjg0?=
 =?utf-8?B?V2tMblRlSjFmNjlUeUR6VjhWNlcrWHVWek5GTHNHMTU5WTNuSUMvNjJuOENr?=
 =?utf-8?B?UGZDRXBkSklwYXRIRUVKTnFKOG93NUY2UzVyNE55UndaRUZVSC9ORytFN0lp?=
 =?utf-8?B?TUVrOHlmbTgzc0tHanM0N1F6UGVVcUpUQllXZDQ0NWpLbzdyNDNCbThtZDRK?=
 =?utf-8?B?L0VpYXNDSU9iOG1sQUZ2SHJGRnJIOGczUWx0ZDUrc0QxK3V3c0M3bGZ3MXJr?=
 =?utf-8?B?L0ZObktiUWhDR1Z0a1lxSmYySFVySWlUUkREN1djdjRxOUVNeDJlL1VVVFNi?=
 =?utf-8?B?MUcyRnBKRVlvQlVYdTJnRE92QzNWZkMreEFOd2x3VFp6WEtLYnhaayt4R2VD?=
 =?utf-8?B?b3h4Um5FM1hubyt6RVB3TTVxb05kQ0dHTzViYjNFM2t6VXREQ1JvazUxMGVI?=
 =?utf-8?B?R0NXY3IzT2RKL3ZNblhFamZBWmRPNnI5U0pKNHp6Rm92RUowZ08vQ1IzVHFP?=
 =?utf-8?B?bFRCamhrWFFJZ2d2TDQ2MXhIYzk1MWwyYXpaaytmTGpNK1NlTDUrMnd3R0RV?=
 =?utf-8?B?VitUQnBkT1VCUGZtN3ZEaEhTQ0tnTlVkUjI0V1pqdEYvWUFRWGpBREQxVUhj?=
 =?utf-8?B?WFFCVXo4ck56NERjd1QzN1I5Z0RiZ09BdlNJMEZ0b2w3S0IvYlJicU14bGsx?=
 =?utf-8?B?NnJXK1hDTUFRbmVQWXRtQVQ5bWF1RFJqS3dtbWtxVVhMZmdOcjN1S2krNXhn?=
 =?utf-8?B?MWt3M3FrRUV1SmxKT3RxNW1aRzNpT1orN0tNZkZSQXpmVG5ZdkF1ekZrMjJQ?=
 =?utf-8?B?MC83aGkzMW1JWTZPWlhYVGt6V2prYmc4SjZHajJKaWovbWYvMFUzVVVFUjNw?=
 =?utf-8?B?NG1tcUpLMUdYWi9FV05PZERrTEt4QTlxeU5ESW9OVGN2d0x3cDAyMHBEc0FF?=
 =?utf-8?B?ekVnK1BLVk9YYW1WRXNJeVNyVGtaUG15YklzcXBBZVFLNzBadWE3amg0L2po?=
 =?utf-8?B?c2IrSm9wMWJSK21GOVdZOVc1VXRoQ2dRQUlUMG8yTTM2WEt0UDFQakQzRmkr?=
 =?utf-8?B?VFlWQTd5TGFTeTZEMVd4MlJRbWM0VVNRc1AvV0JLSU9adm1scTFrenRaNE5k?=
 =?utf-8?B?R0FQcElTRzkxRURDYWhuLzlncS9qRUhWR0dGSXdKSkJhUnB3VUlZbThxRlpx?=
 =?utf-8?B?Z1A1L1V5MzdUaEsvQ1g4UTBFYm90N2dUK2ErSTE1NFBJaWs3SnF5TG85MGNG?=
 =?utf-8?B?MllFOUdUc0FEWUdSRDhwaWhnUnRYQzlnVTdKLzJ6NEQvWWFRbHVhWm90OVo3?=
 =?utf-8?B?MlZmUklLM2l1K0ZZcmZLR0k0TThUWGhTQVArdGFjLzFvMEtuNytKWXBkRmhV?=
 =?utf-8?B?ei9uY0xMVW44bFBERDVHaXduZG9jYWtyRGJadWlxcUpOMTFpdktiWUo5N1ZQ?=
 =?utf-8?B?bUE1TStWaHBjeEtpNkNDZVdUSkNDY0RpMUJyb243YUFVYi9rWTJWWk8wYnJL?=
 =?utf-8?B?N09tWDhsQVlrRGhrbFU1a0RFR2N1R09BU0pUYUR1SDlyZFFlU2c2eHFHdGJN?=
 =?utf-8?B?K25ldmpsN1pTUTFGeTVCclpid0hMNDJxVDBBK29HcEtaMC80MCs4bmFXZTNU?=
 =?utf-8?B?Kyt3WFJaSHV3QWdtbWJqVU5DN3dHTmw2Si9aeTdIOHdRZUptZXJtK1dwVlZo?=
 =?utf-8?B?NkVyZzV4c0dQR2VLTzFITUtmWThJVkIvb3UxTXVQZnpkR3ZnbVJ5TnRhOE9Y?=
 =?utf-8?B?L29mWXJnWnlhRTRxYkFwVWlmY3E3YzVLRTcxSEdzcVhlbDJERzljSVNLQUEr?=
 =?utf-8?B?eEdkMDFwS0FnNnhXRS96QVNPTDhOZHNDTDY2ajJ4WW9YQU1OMFRDalM5UmZn?=
 =?utf-8?B?eFNHeUQwSzZyNXZPSFovQlI3TjdUaDkyUFhYRk5UL3MycmVjMU1ZMnh3bTIr?=
 =?utf-8?Q?A6q5/QUEGpwDlKCaKP6fGHQrPGlPm73FNWD+pBd8y7cnA?=
X-MS-Exchange-AntiSpam-MessageData-1: 7ZaU4d+JtaAypQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a42b66-2cb9-4b62-7bba-08df08d2f41f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:17:04.3703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeNlu86JQ2rIDZkMdHZHsST0SwlQ6/xGWMrg3TLQDqUyfUDetP0VdjFl4ps/1r1MGJ8kyd4J0wRDWdVj96f+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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
 rust/kernel/num.rs         | 138 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/num/bounded.rs |  19 +++++++
 rust/kernel/ptr.rs         |  14 +++++
 3 files changed, 171 insertions(+)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index dbe848e30efe..9435459376a4 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -2,6 +2,7 @@
 
 //! Additional numerical features for the kernel.
 
+use crate::const_assert;
 use core::ops;
 
 pub mod bounded;
@@ -9,6 +10,143 @@
 
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
+///
+/// Implement this trait to make a type usable with [`cv!`]. Use the [`cv`] macro, not this trait
+/// directly, for creating values.
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
+                    "constant cannot be represented by the target type"
+                );
+
+                V as $type
+            };
+        }
+
+        impl<const V: i128> FromConst<V> for core::num::NonZero<$type> {
+            const VALUE: Self = {
+                const_assert!(
+                    V >= <$type>::MIN as i128 && V <= <$type>::MAX as i128,
+                    "constant cannot be represented by the underlying type"
+                );
+
+                match core::num::NonZero::new(V as $type) {
+                    Some(value) => value,
+                    None => panic!("constant cannot be zero"),
+                }
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
index 2a2b0a4bca5e..f720eb44e7d3 100644
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
+                    "constant cannot be represented by the underlying type"
+                );
+                // Statically assert that `V` fits within the set number of bits.
+                const_assert!(
+                    fits_within!(V as $type, $type, N),
+                    "constant cannot be represented within the given number of bits"
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
index 82acb531b17b..ac1662c3c8af 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -166,6 +166,20 @@ pub const fn mask(self) -> usize {
     }
 }
 
+impl<const V: i128> crate::num::FromConst<V> for Alignment {
+    const VALUE: Self = {
+        const_assert!(
+            V > 0 && V <= usize::MAX as i128,
+            "constant cannot be represented as an Alignment"
+        );
+
+        match Alignment::new_checked(V as usize) {
+            Some(alignment) => alignment,
+            None => panic!("constant is not a power of two"),
+        }
+    };
+}
+
 /// Trait for items that can be aligned against an [`Alignment`].
 pub trait Alignable: Sized {
     /// Aligns `self` down to `alignment`.

-- 
2.55.0

