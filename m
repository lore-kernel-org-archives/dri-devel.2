Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E98CA9ED0
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 05:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9521610F488;
	Tue, 13 Oct 2026 05:58:34 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34BB10E075
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMCV5yFjW2L/N6noK5WoMXPGk0yauPF9O17zTWfNh/CkzBpS4QuL32t4Iz1yG10eeHrmhiVDlwkibGF6EERx0sWUchUTzR7dbz8GWIkeAUHWf2Hmna0DA9gGZW2TwPe/tvTKoNCTZ2I5fCeFPNcmB58nQ9ZmldPC83zEli275S3RpziXyS2wDx0tomzws6mm8Ap7CfAYQxHL14yqMqvAVOxXe8lWyP7ia2czuEbkCGsuP3wPuh21DTh0RHHaUhQAN7PmBxtViXNuYsydMh+sVJqR8Mr+7XJ42hQikPMbLEVtYEjmSEQCQ9EiGLGWjuJcfLFVRywwbYsLTf93uHTquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Hn1vDp8gn2ngJrt7oLlr1fwfFl/dPE7PC0iGG5T7lY=;
 b=B0OfVmbVDy5cQ15cvn4eP4+91kGeOX+rqxxjFY0AYg9Aq7gjhLU4N48jYbgoCbksQ1VSY4giN/zjgn+pgmHDTahhXIsUt8GRewZjnz99FsRVeM0q6FM1bizhGaugaBoNV7RD5kGRKTaqfJljMH0Mycie1WAhJpuPbvLvbZyx/p8mM+ho0m3xu/k0qf73rdW+p5MyKIJ1gFytMAKeAYkex2NCuD7kY8dNm8xpzwtlK8L42H0cWMbCh8tsmqYleuqP+Q4i36NdksTcpAnw7Yx7rSuM2oe52Pi0bkTl3DYMilKSTZz1j1BcKba5Y67UnyjbFWhYsUl81I8Hvmi1fwjxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Hn1vDp8gn2ngJrt7oLlr1fwfFl/dPE7PC0iGG5T7lY=;
 b=ImHMgTa805evse4deD4B5/Ac9xEVyAhh/ElM4zHKhl/P1qgYNBVvf+TDyOtsGVOqwRTFhFY9aoZPKpSffHhwlW/QTQDoFvheFW+pt+RjYUwGfk6/BGfRXdA4T8aJhCEOTVlxWfNd3GVSJ2wEbCwKfNUYPPOtZ4QBItIRE2jEaQ5VUA8F06c7Q5wY9jsM21nBnQBWLRjD0GqVI0poh74CQLez+I+0yXYXWr5nbLL9e1/bCNp1bINAfTfMi1Bvv3Z0jkpXvA6T8EXPmmY/Rvhu8xFzec/Ds+WY/Ulix2el9CEavs+GzBzyZrYs780sKzkbYHJ8PhFwfnGqK3a5rWN4Cg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 05:58:23 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 05:58:20 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 13 Oct 2026 14:58:06 +0900
Subject: [PATCH v5 1/2] rust: num: add cv! macro to create values from
 constant expressions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-cv-v5-1-113a538dfaef@nvidia.com>
References: <20261013-cv-v5-0-113a538dfaef@nvidia.com>
In-Reply-To: <20261013-cv-v5-0-113a538dfaef@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9204d57e-1b0a-4b91-1d0f-08df28eefbeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|23010399003|921020|11063799006|56012099006|5023799004|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: liw1yz67uOTOBFoXr7V88Nm8N8mbA45D/15D690Z5nIkSCh7bt/Z3N3tMEWfE6e4inO35Ze+p88NA3wxhffsOLiNtrCa/oqbgjvSJrlYlwOFKi5MaOLU6U8WaCBiZduMrJFsi6Sxeo9O5TiIfYzXQlMX0OKs663unwG/C/3pP1lHNOIAG5eAoWrYI51YBmjIQFP2WND7KZacFo6uZh3zbgQYvFx8La2/Kom1FDliB/EOlQ+379YIBLSQziHtAfhmmZaRszeLWfULlBqI1FuGhWROXve1uJ0dSttevE6s4eO3UgTDQgsj4LxgVju//hNa2LvG1GEmuXm8jbdKv8XwN7brHoM9A99n2jcpo0k3XguF71pFHy9s8+CWYBnrqS/r2svev2yX9XXCltk0aGr3Y0ffLJKZE/PkfRqP5P9sCT8Uuqbp6+BTBcR1KTOd9Lv1wZs08zJCW//QoJuoe0L80LFKQ3/uu5tBLLcNO+hv2ZUvSnlLZsXW8RT7HYj8ejDFK8bvqjB/yDEFVIbWAm/zc26X/0cibFogzVFbXoNNJ6JZaqeQEubG2o5TlkdUmtqmFgdtwWJTd2qWlaLblbGuoCQ6MeER5OUCJbGebOYEuA9QQUuo84qhDNmuY6OO0uV3C5vSGcIOurQQYz16gYn/pqNo5ZLUJvh320RoHlEHDKnDtnYdI6DJH1DGVU4w/VHdtE9Ts/OxiH9k/SIho+wiqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(23010399003)(921020)(11063799006)(56012099006)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkpPdlkyc0dwZFdVTDdwdkY1OWJZOFFqdFhIOEF6eldROWgyVHNORVkwejZm?=
 =?utf-8?B?clhuaVljR09ZTVRCakQrUERSRFNFOHpYTnIxak5WVVErN0llRSs5MDc3bHFY?=
 =?utf-8?B?aW95ZDhRZ0hWQ1BwdWxJMVl1MDdKOFNEaE9kaWNINVgzMlhwTzJCb0V4K3lI?=
 =?utf-8?B?ZFl3Vk5xNHBBbllLa1d6MkRGSjc2ZUMxTUI0eXY0eGVSTzZIbTFJcHNDNjJ6?=
 =?utf-8?B?QUVwR0N2OFZuNGVzMGtMSnJzbGh0OHBPQTJyV3FNQ0ExSGx3Z2FUTFhPOHpQ?=
 =?utf-8?B?SSthYlhJcnRKRFYwaHNLT0ZsSGZ0ZkY3SndhWVVBZzRtL3Y3eVhLUFExY3ht?=
 =?utf-8?B?REpUQ3ViYXpuVzlTemtjYTlTSFZrcmdhZUhMRUZka0VyRzVRSGwwVlZOQ3dj?=
 =?utf-8?B?WjZxbEpRRTVMSXhrOThpTHJTeXMvRXBuZjAxcFhIa2lza2FNSEgrb1FvKzVU?=
 =?utf-8?B?MzRiZW84TUhmcTNMbDZ4MXdQdllTNXpwdVQrZ3oyT2V3MXg0cWk4ZFk1NDN4?=
 =?utf-8?B?eUhKL0Q1cWE2VzYwWXNlRDBBbUY5L1NTeCtyS3JlRDhJMFdJdG5ZTlVMaFFJ?=
 =?utf-8?B?MWRtYkM3eHJoVFR4TDh4bnJ2eFdkTFVZbEQ3Q2pJcC9ZWm82UVo0SW1vYUtw?=
 =?utf-8?B?S3pYdW5oaVVhaEZWa3RucjBLejNRUHVuemRzUzdFZmJMQlNRd1lwV1ZodGVa?=
 =?utf-8?B?T044R0hMUm85WFNvOUVWdzk5MGV3STIzNzZvcjduYzc2VVpnYTNOWUtsTFVv?=
 =?utf-8?B?THJrYWdZL1Q5aGMwTWNIZytDSjU2clkyWGhYSFJOb09YdU5PdFRPRU1qQzVN?=
 =?utf-8?B?dXNlbHNIUnh4TFVTZmRqV2d3T1RnV3FyMzlVTWlZRWVVR3NGMGRZeDdRZ0Jk?=
 =?utf-8?B?alVhVXRlVXRsTHMvVWRuU0ViOE5ZcDRxTWVXRVcrVks5TUlqS0hxWU1oZnZO?=
 =?utf-8?B?b2d3cmp6NDg3WGZKdko3djZLakpjb2JLWjJTVE9hMCt5bFY0K1dRS0R2V1hE?=
 =?utf-8?B?YmR0TUkrSm5vSWxDWm1sRkdYQVRyeTg3NFdOUjVqblVWcXFZYUdSUFlpa3BM?=
 =?utf-8?B?S2RtWGQzUitNd0NIUmM5d0JEeVpoWDNEV3lLUzY5elcxbUdrQi9LdktUMjRX?=
 =?utf-8?B?MlJZOEYzUGs1Vm90eXB2aXJvZjFxSDhCeENmbHNEVEJOOUFRN2JPTTU5Wk43?=
 =?utf-8?B?cm1NYW54S21mckpWQUpQZ1NEaDNIQ0lvdTR5cHV0MVZnYlk5b3grQXBJTktV?=
 =?utf-8?B?T0Fzd3VGOENxTzFVTzFuK0VaYU0zVUVhbGh6d2VmS2JFRU9jQXNzMGp5dnd1?=
 =?utf-8?B?TkV2ODkzWGs0NzFWRmNKb3owS21uWGV0QTFmRmhkL2tUSUpUN05qR2RZM0Ev?=
 =?utf-8?B?MGZtY0R1RjVGaWdKUEhBYzJmTFd5cW1jM0V3bDFzbHdpWmc4LzVOSWVuVTFP?=
 =?utf-8?B?c3NvSit3Y2tkdEJQbi9Bem91YVI2WFo1bEJ5UTZjWmFDTElaU0c4REVRRGF5?=
 =?utf-8?B?aS9jUS8wT1R5ZC9LOGQrYmNvc3pxeVdzNnp2and0V1MxbWhrWkV5VVo2anVu?=
 =?utf-8?B?L1Q1RUVOeUFreE10VXU3NEdaTzQrYmJJaE5vRCt2V1dRczJ4U1dpK2IvUUps?=
 =?utf-8?B?TDJCZm15OU91S3RVQTdsN2IzREp5bDVRZGxJNHBEYmE1UWM1QlQzejhRZ1BK?=
 =?utf-8?B?ZmFvajh3RmVZcm5odEhmMVRzdnV3eUp1N1YzeFpkY2FVQ2hweXJxL3E4V1pk?=
 =?utf-8?B?RVhOZkMva2lZNmZJaWpyRUpLcmR3ZkJqREZ3K203NEVUcVR5Rmlpbm5peEk0?=
 =?utf-8?B?YVpCUDZ3V09WWWZ3V2FnbVVaaTZ3T1BCVEZOK0dqaFFNa05nN3pJR2prb2t5?=
 =?utf-8?B?eEtpaTVqNmlUQ29Xem9PSjRxZ0tIMThMWFcyTE9WUDBKdUJoVUF5K1Bpek81?=
 =?utf-8?B?Y2tGRDlmWXJLQjNUWlhkNXFtWVZOZnU5S2Y1d01oTGNOZ2M3UGFJYmNuWVE4?=
 =?utf-8?B?UGVWbTVkSzFyakNWTVNGaXdrNm9vM1QrMjNUK3l0VEVFU0JHdVZ5WVp1YUhO?=
 =?utf-8?B?S3JkcUZORUFweXdqRkx5NUI0MWpzSlg2Nk92WHVaVVNFWkNBcDdiOWVkV3Qv?=
 =?utf-8?B?R0R0eUQ4M0JQTmE4YUtZdHZQSWlzMlN0Zm1XZjQwcThZVWYwZzlvSzU1Y0VP?=
 =?utf-8?B?c1JFR1dqZjRXbWV3anhXeUxuTGRvSEg0dkVvamJncTZPbjBRMkFNSDVBRjc0?=
 =?utf-8?B?UENnU0w4QzhoWlRNeHR4eDdFRWd1TFVaS1N6U2R3OEpUSEpBVHltbkpzMHlu?=
 =?utf-8?B?UXB2K3BVSHVtdWF0dFVSQTE3R2hFMHN3YTRwM09Cc0lSYXJkMCs3L05UNUVv?=
 =?utf-8?Q?sjwEah2oyTrP0sT8jRtqMuEpdtqA4ISmYcpC6cYPrKnQv?=
X-MS-Exchange-AntiSpam-MessageData-1: g38FasD6PWycng==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9204d57e-1b0a-4b91-1d0f-08df28eefbeb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 05:58:20.4847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Maww2FhYbYUdn4oGuzme0hkj2bvNftsR29eSAIkMnb8faBvivLERn3XuGUCk2cQX2GAWDfoyLhVSqYZNr/f9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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

Add the `cv!` macro to the prelude so it doesn't need to be imported
explicitly to use it.

Suggested-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num.rs         | 149 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/num/bounded.rs |  16 +++++
 rust/kernel/prelude.rs     |   1 +
 rust/kernel/ptr.rs         |  12 +++-
 4 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index dbe848e30efe..a387a94e97e7 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -79,3 +79,152 @@ impl Integer for $type {
     i128: Signed,
     isize: Signed
 );
+
+/// Creates a constant value ("cv") from an integer constant expression, with validity checked at
+/// compile time.
+///
+/// This works for any type that implements [`FromConst`], with the target type inferred from
+/// the context, or named explicitly with `cv!(value => Type)`. It can also be used in const
+/// contexts.
+///
+/// # Pitfalls
+///
+/// Only the target type is inferred from the context. The expression passed to `cv!` is typed by
+/// itself. So, unsuffixed integer literal expressions default to `i32`. For example `cv!(2 << 31)`
+/// does not evaluate to the same value as `cv!(2i64 << 31)`, since `2 << 31` is treated as an `i32`
+/// before being widened to `i128` internally. Literals and arithmetic expressions that overflow
+/// `i32` are a compile error, it's just left shifts that require care.
+///
+/// # Examples
+///
+/// ```
+/// use core::num::NonZero;
+///
+/// use kernel::{
+///     num::Bounded,
+///     ptr::Alignment, //
+/// };
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
+
+    // Using `FromConst<V>::VALUE` means const generic expressions can't be used, since it requires
+    // the `generic_const_exprs` feature. Provide a special path for each primitive type that allows
+    // const generic expressions.
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
+/// Types that can be created from an integer constant expression validated at compile time.
+///
+/// Implement this trait to make a type usable with [`cv!`]. Use the [`cv!`] macro, not this trait
+/// directly, for creating values.
+#[diagnostic::on_unimplemented(message = "`{Self}` cannot be converted from a constant")]
+pub trait FromConst<const V: i128>: Sized {
+    /// The value that corresponds to the constant `V`.
+    ///
+    /// Fails the build if `V` is not a valid value for [`Self`].
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
+                // CAST: The macro is only used for types up to 64 bits wide, so `MIN` and `MAX`
+                // widen to `i128` losslessly.
+                assert!(
+                    V >= <$type>::MIN as i128 && V <= <$type>::MAX as i128,
+                    "constant cannot be represented by the target type"
+                );
+
+                // CAST: The assert above confirmed that `V` fits in `$type`.
+                V as $type
+            };
+        }
+
+        impl<const V: i128> FromConst<V> for core::num::NonZero<$type> {
+            const VALUE: Self = match core::num::NonZero::new(<$type as FromConst<V>>::VALUE) {
+                Some(value) => value,
+                None => panic!("constant cannot be zero"),
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
diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
index 2a2b0a4bca5e..0b32f4343922 100644
--- a/rust/kernel/num/bounded.rs
+++ b/rust/kernel/num/bounded.rs
@@ -14,6 +14,7 @@
 
 use kernel::{
     num::{
+        FromConst,
         Integer,
         Unsigned, //
     },
@@ -272,6 +273,21 @@ pub const fn new<const VALUE: $type>() -> Self {
                 unsafe { Self::__new(VALUE) }
             }
         }
+
+        impl<const N: u32, const V: i128> FromConst<V> for Bounded<$type, N> {
+            const VALUE: Self = {
+                let value = <$type as FromConst<V>>::VALUE;
+                // Statically assert that `value` fits within the set number of bits.
+                assert!(
+                    fits_within!(value, $type, N),
+                    "constant cannot be represented within the given number of bits"
+                );
+
+                // SAFETY: The assert above confirmed that `value` can be represented within `N`
+                // bits.
+                unsafe { Self::__new(value) }
+            };
+        }
         )*
     };
 }
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ca396f1f78a6..5facf8f7af90 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -106,6 +106,7 @@
         Result, //
     },
     init::InPlaceInit,
+    num::cv,
     pr_alert,
     pr_crit,
     pr_debug,
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index 82acb531b17b..2c12e4fd4572 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -11,7 +11,10 @@
 };
 use core::num::NonZero;
 
-use crate::const_assert;
+use crate::{
+    const_assert,
+    num::FromConst, //
+};
 
 /// Type representing an alignment, which is always a power of two.
 ///
@@ -166,6 +169,13 @@ pub const fn mask(self) -> usize {
     }
 }
 
+impl<const V: i128> FromConst<V> for Alignment {
+    const VALUE: Self = match Alignment::new_checked(<usize as FromConst<V>>::VALUE) {
+        Some(alignment) => alignment,
+        None => panic!("constant is not a power of two"),
+    };
+}
+
 /// Trait for items that can be aligned against an [`Alignment`].
 pub trait Alignable: Sized {
     /// Aligns `self` down to `alignment`.

-- 
2.56.0

