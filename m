Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAFFC982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E5510E613;
	Thu, 17 Sep 2026 07:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLSPOjju";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3130710E613;
 Thu, 17 Sep 2026 07:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPV0FEv+dPbjvMpHOvhRsRsU1wZEB749iwbzyWDpfRaZOlu6oD8P8tri2/inicggqoHwbM/RRaBnlZPPrK0bD5muqo7BGTT0z52qD6Rf/gXlLbS3DAm/1Yd8l7W35OOBrWWuwRk5ihwV0e4qvzV7e9pwKWmEPwTRPGlyKBf2X42kkTAEq3YLeSzwbUTr8AvBU2ZjHE+YpxNIEWzaaGvrFnBrXul5QavVOVHexlbVP4yDx5mONiTGx9JLnpidfk3Q/7Xz5roprx56uCgzPZYXhw3bOvCFyA5+v+YFU6IemJmrmW40VHHIDKADks2I24NFKJOGy/bHsA08G5lzVBcDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae+mn0Qy3RXPcC0dQzcuQLATaMfuGCOXniEHxBa3nZs=;
 b=DQLe2tP9JWjLAG2jaFxsKBZMR+SMRLxFrQ6pNRitFINJa0L+9GbnIQPixIwzx9bgnmJ/VQFXouIYLfCJWvgqr17fMp0Siz52NLmc/S4xFTMfwnNAaSBYyiK8XLMvlWpiBv2B2W/hpRBBTa5RLBORRhPdXP6IyyyfU1B4XZqEUAbjn9mCtbH+CqC99+D/D6KrjouFkh2izqxyvwdNoz9ZQ5mi3eAXmmp4NIf9VAu2zNnrP2E/X8Rq3ll18StMNxUpx0IQxK1BkOrDXzLDrD0BCIzOe823nls/xx/aLQrbp0j5SahWNf4yktkGVZdGeAHN9HKKGHLow/Ne49ptwsiKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae+mn0Qy3RXPcC0dQzcuQLATaMfuGCOXniEHxBa3nZs=;
 b=RLSPOjjulPR7uWzOfhVdi+oBEBuleh7fi3E0fT2BCYEZZ3I9DiGXoVpxHcvXc+4QNng99u9LlUIO5GL1N2kQxJ65/pGSg2Yayz8OmYJLJvMb8RLhA9o9bEVKANAZ8AhoxHKMsiA5iFAWrN31heCJEZyz5svyOOhNMde9YLB48CUr1xTrffjGjOWXCspBaTQKK8WAqryR/WYGJHaTSeBmc51ZT/jEGXCzS3ilKHGSe2hagkbCVa2I9l5BfM7gziFpBWj/3gbVYRwAdCcaRYDoqKES24av3UfZC+7Vuhnatj/nwsGVir4RwtHi3ELk0xVwCyq6ZRe5PjV+ELauoUzlpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 07:59:08 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 07:59:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 16:59:03 +0900
Message-Id: <DLHFKT44IHW9.2QWQB0O0LJHJJ@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
 <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
In-Reply-To: <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e8095a-b313-41de-8e0a-08df14918c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|376014|1800799024|23010399003|11063799006|5023799004|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: WNKIjL4fln7NYBDW6FjVYY8ZDsWcZkncpcd2m86RupRpdOOhxFlmFLNYtmyFpB69DI88ghz59m2Geq63haPkcrSXmM64gWdmui0/SjBVm1+MNEhF1Ho/cIZtnMTaXVcPtnPCe9rprb6fVGCt7fu5cBZhwBa6PL+Vd7GZvHgFatIth9/AUu8Yz9U04EGTpzbPpnGCL0jKQ4GIjq4y5Uxnwya/ao55Yj2wYZthKhC53/5KjsTS7pWU5PRKHCuP7CDvu/MDznz8WSpn7Bjldl2fjavRVKX7CHkd8YOMaSf71jcTmp9KvGdgkLMdgvOGxk36XK8GNU32MlDg7mKRtzrdoGGilBQCG4Tu/juciqqUvr7aynkA7RqEnXprCW3jQeiwaKUsqu6NpRcxvNnndM2kNzWTC+mNSTRJLfYaIb1R+Zcy3ZZTHkTHpnqMG43Piu68vY9GMgVXhQXA3ugv2l/JX2Nu+RiJR5lzz/TPrO/sq0UqprPr4CH7I6Npm9qYNB3R/j4LFD+FBytTPhlPJHL6YH/zxnBjzCrmh+S+nDfZni8XD/LM3mrRF8Gsfyx+lWPIkdQKLZ58HHZsIwrde7QcXVjiGHuDARr1Ovvt45QxJMsxXTggpgLyW7Zh+1t1COL63wSMHBnkJvoK3VDkgDSKZF2fZJbDLTRFgz8iz5T0eWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUd3d3BiR0hKRTB5c1J5MGt2dTVUMmtpcmZRcEU5elFrU2VDUVlkbDFSWHdv?=
 =?utf-8?B?SU5leVltcmQ0WVBmUVVSQnRBMjZtUUh1MHZSaW1VSWNXdE1xSjB0bTViUzA3?=
 =?utf-8?B?OUFhTzRSaGVzMkpydCtKT0xKUFNmSTA4eTVHMXptYzZrTTArRXhxa2h1UjVN?=
 =?utf-8?B?MUc3K3FQUStQSE5iMHpxNnNSbm02RVRqbjErVUM4a0J0Q2hOSGVYVmFtR0o3?=
 =?utf-8?B?MUYwV1NiZk1oU2FnNldyYnJaQzd2TWV4WkF1cWlVeWhyWm9XVGFVT1VsckZN?=
 =?utf-8?B?UzNhVVptc09lMlNQWGVBTE42WjRLaFBzaktYaXJVRzlabzVERytOWXlOR2ZW?=
 =?utf-8?B?em1LMFQ1VHhheTFEcHVrWjlacHJCMlhtckVDVklDT045anFrTmdET2ptTW9P?=
 =?utf-8?B?R2NtYjNvdWFaMVdQdk5aS1YwSUYzSUhrTDEwRVA3Vnl0QkU3RU94aktuaXAv?=
 =?utf-8?B?YmVzYTlsWGRvZDhUQ1RvV0NMWEwrM3hDc0haeC9oR0U0VnF6cmEvTDJVUlJj?=
 =?utf-8?B?cHNGN1IzSktPMElRQXpnOHhnRERRb081ZFVJQnVEL1RJR3JGZGx5aDUvd085?=
 =?utf-8?B?MElvTkhFbGNHMllkdTZNK0VFVVlQM2gxbERWdXlFQk9qMkVkZWt6SG8vZGdT?=
 =?utf-8?B?WFRqZjJUaUJwWWNuUDl6d3lUdG0xZHh0ZXVzbm5XMXI3aFlEU3VudGpEa1VU?=
 =?utf-8?B?dHhRMnZNSzFVaXlSZkxuVUV4dDB1bU50VHVrNFJwTnExQXZkeU5FT0xoNW1s?=
 =?utf-8?B?dWlaYWdwS3o3QlVLV1Q4UFVHRzFDR0tBeGlXSjlMbFMwY2xhMEhnS0FFcEgw?=
 =?utf-8?B?QU9RamZ4bytvbjhTVE9UQkx6NWZBSVg3VW9QYUt3UmJLVThkL3FuR2h0ODFo?=
 =?utf-8?B?c0hxVFI5M3hHQkdWZ0FESjVYTkUzL1VLVGVoY2pYdjJMVStGd0FnSFoxbnRo?=
 =?utf-8?B?NzFOWVBqT1pZOXI2TllVNGtsS3NkSkNpOXltNnhlS2JXVEVva3EvR2k2WlIz?=
 =?utf-8?B?M29wNmFnRjlnVHgxSll6eDhzNU56S3c3am5sSldTTXozWXVEaTJCMmlNNUhC?=
 =?utf-8?B?RHIxUThEYjNQMTBCRkxGU0JZTDEvdFIxUTI0bnk5RlNYZGNhOEtra0xFcXpx?=
 =?utf-8?B?TDUvRHB1eWo3OXFWdll4V0wyRmN5OGVMWUdNcDl0MDczTExURkd3UmttSW5H?=
 =?utf-8?B?ZVZhbThvL2wyME0yQzI3d2ZIcXBsZWhDUkRQNWFoSHRyNXQrWWU3R3dhbHRN?=
 =?utf-8?B?S2ltRE5oSmRyNlZkejVzNVNWb05oNmtKSnYrdXRxUUE3L21RdjNHSTVRNmZh?=
 =?utf-8?B?TVNCcVJkTGF4SnRBZUkwRkxwanpDM0o0cjJoU3d3aWNXTXZsNzhJY2hic2Vm?=
 =?utf-8?B?QXdic21LcDZsR0tLUitQbnhZdEhLQVhNSE8wOFhyQ2tOUWtLRk1RZFhoVGlL?=
 =?utf-8?B?NFgweDJGRnVkb0VSb0lkOG8xWURQTXZLUlJHL1QzMW1nckliRUNwNDJBNTVx?=
 =?utf-8?B?NXBTelhWUHVoaW9ONHJDeGY5TmJSUmxRVWN2Z09laFVSWGdJQjVuMWtNdkNM?=
 =?utf-8?B?MFpGME0wSHVzQm13VjRScGFGcmhxOENoS2xGbDEzUTRYN2xDWlJkaFlvc3FV?=
 =?utf-8?B?S3daUEQvN1NwaWZFaVJ6aHVEc1p1ZXNwNWtrTUVlSFFvRi9mbEdCbGdBcm9o?=
 =?utf-8?B?UDhQYjJzclpXWWFWa2M4S0IxUXlEZklmb0VJam9jUFdRYWo3Y1Y1eDFWR0o1?=
 =?utf-8?B?eUxVZTRsbkw3MzFMM2Q4Q2tSUk16aVJGVDhMcm9NNlpyUytBNTRWRlcyUWtR?=
 =?utf-8?B?a2lmOG1ySUtMbmE3c3ZYZW9jVmkwTDIwNk9RQlZKbEpYTkdYSmdOSll4RGV1?=
 =?utf-8?B?OTRHc2tiSWVqdy9odGpCQ3BZUXdNZklaN0ZFdUZpMlRLNEs1UmowS3dXaTBE?=
 =?utf-8?B?QlJBWEVVKzVRdXp3UGpSK3I1YU45RjZCV1BPR3UrVEdQRDc0WlJxZmJiOHIx?=
 =?utf-8?B?R1pDQmh0SzFnVTdCT3UvSUJCYTQwT3lidkxad3VocHRENU50d0wvZ3FFWnJ1?=
 =?utf-8?B?VFZ1bzNsQXgyTzh4K2ZUQWxSOUhwUEc3V1hNZ0dLejBxVC9kUnd0Z3p1NEZr?=
 =?utf-8?B?WVFUbU5manVDZ0NOWFNDZmVmcXI5TjR2Zm9HNzY3SE80VXVobVp3OUd2bkFK?=
 =?utf-8?B?MDg5RHUrUUk0c0FXMjNjOVNJWHlubmQwc3BSQW9wcHdHa0lEcHFEU1I4TnlD?=
 =?utf-8?B?eEsyTjZxM2NEZTE5OWwzMTBXaUx6Q0prQmRtNWJDOElSNjNKeVkyUk00N01l?=
 =?utf-8?B?ZWo3RE9TVTkvanhDNGk4eVZFL1UrUHkwRFZuODVSUmNocXlCK1BCRXViR08v?=
 =?utf-8?Q?8QkSkKhmgmUBzke11GpI/5yfJ4e6W7OQLZTj4dNLqniWZ?=
X-MS-Exchange-AntiSpam-MessageData-1: iveIAlqmA/7EQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e8095a-b313-41de-8e0a-08df14918c8a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:59:07.3428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR25z769YYfAsYyo1MN4YuDGFOcNKIREnZ30V3s2XPT8kyGwlUGK1ofE3KCcnJ5JN1qBI2YKd+dOGDkuamHTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437
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

On Tue Sep 15, 2026 at 4:39 PM JST, Alexandre Courbot wrote:
> On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
>> Currently, using NonZero/Bounded constants is quite verbose. It's
>> unfortunate because it disincentivizes using it in interface boundaries.
>> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
>> value) takes a const integer expression and widens it to i128 (at build
>> time only) before passing it as a const generic value to a new trait
>> `FromConst`. The value is then converted and appears in the
>> associated constant `FromConst::VALUE`. The trait is implemented by
>> NonZero, Bounded, and Alignment and lets values of each be constructed
>> from constants without a verbose turbofish syntax.
>> For example, `const { NonZero::new(1).unwrap() }` can be written as
>> `cv!(1)`.
>>
>> Suggested-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> I don't think we have any user but nova-core at the moment, and it
> benefits from this in several series (patch 3 here, but also ID pool and
> later r000). Miguel, is this ok if we take it (i.e. the next revision)
> through drm-rust-next?

Will send the next version based on drm-rust-next, but Miguel please let
us know if it's ok to take through drm-rust-next. Thanks!

>
> Some nits below.
>
>> ---
>>  rust/kernel/num.rs         | 138 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  rust/kernel/num/bounded.rs |  19 +++++++
>>  rust/kernel/ptr.rs         |  14 +++++
>>  3 files changed, 171 insertions(+)
>>
>> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
>> index dbe848e30efe..9435459376a4 100644
>> --- a/rust/kernel/num.rs
>> +++ b/rust/kernel/num.rs
>> @@ -2,6 +2,7 @@
>> =20
>>  //! Additional numerical features for the kernel.
>> =20
>> +use crate::const_assert;
>>  use core::ops;
>> =20
>>  pub mod bounded;
>> @@ -9,6 +10,143 @@
>> =20
>>  pub use bounded::*;
>
> Can we move the new code at the bottom of the file? I'd like to keep the
> `Integer` definition on top.

Done.

>
>> =20
>> +/// Creates a value from an integer constant expression, with validity =
checked at build time.
>> +///
>> +/// This works for any type that implements [`FromConst`], with the tar=
get type inferred from
>
> I am wondering about `FromConst`, do we want to make it public, or hide
> (and possibly seal) it?
>
> Basically as it is anyone can implement a new type that works with
> `cv!`. If that's by design, then good, and I don't see any potential
> issue with that, but IIUC we also agree that this is a temporary
> workaround so we might not want to allow extensibility if it isn't
> future-proof.
>
> If we decide to make `FromConst` more discreet without sealing it (which
> sounds like a good middle ground to me), then we should remove mentions
> of it from the public docs and mark it as `#[doc(hidden)]`.

I think it's useful to make it public and it was my intention to let
anyone implement a newtype that works with cv!. Drivers may have some
type which has constants that is specific to their use case that they
want to use. Also, if we expect more abstractions to initially appear in
drivers then the good ones get moved into common code it's nice to let
them use cv! from the beginning.

>
>> +/// the context, or named explicitly with `cv!(value =3D> Type)`.
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// use core::num::NonZero;
>> +/// use kernel::num::Bounded;
>> +/// use kernel::num::cv;
>> +/// use kernel::ptr::Alignment;
>> +///
>> +/// let v: NonZero<usize> =3D cv!(8);
>> +/// assert_eq!(v.get(), 8);
>> +///
>> +/// // Any integer constant expression works, not only literals.
>> +/// let m: NonZero<usize> =3D cv!(usize::MAX);
>> +/// assert_eq!(m.get(), usize::MAX);
>> +///
>> +/// let b: Bounded<u32, 4> =3D cv!(15);
>> +/// assert_eq!(b.get(), 15);
>> +///
>> +/// let a: Alignment =3D cv!(4096);
>> +/// assert_eq!(a.as_usize(), 4096);
>> +///
>> +/// // Checked narrowing of integer constants, including in `const` ite=
ms.
>> +/// const SMALL: u8 =3D cv!(200u32);
>> +/// assert_eq!(SMALL, 200);
>> +///
>> +/// const N: NonZero<u8> =3D cv!(5);
>> +/// assert_eq!(N.get(), 5);
>> +///
>> +/// // The target type can be given explicitly.
>> +/// let e =3D cv!(200u32 =3D> u8);
>> +/// assert_eq!(e, 200);
>> +///
>> +/// // With an explicit primitive target, the expression can use generi=
c parameters.
>> +/// const fn as_u64<const KEY: u16>() -> u64 {
>> +///     cv!(KEY =3D> u64)
>> +/// }
>> +/// assert_eq!(as_u64::<0x40>(), 0x40);
>
> These examples are excellent.

thank you~~

>
>> +/// ```
>> +#[macro_export]
>> +#[doc(hidden)]
>> +macro_rules! cv {
>> +    (@cast $v:expr =3D> $t:ty) =3D> {
>> +        const {
>> +            #[allow(unused_comparisons, unused_assignments, clippy::as_=
underscore)]
>
> You may want to add `clippy::unnecessary_cast`, in case one does
> `cv!(v =3D> u32)` where `v` is already a `u32` (which would happen in
> macro or generic code).

I believe clippy ignores unnecessary_cast when it's generated from a
macro. At least I couldn't get the warning to trigger.

>
>> +            {
>> +                let v =3D $v;
>> +                let r =3D v as $t;
>> +                // Pin `back` to `v`'s type so `as _` casts back to the=
 source type.
>> +                let mut back =3D v;
>> +                back =3D r as _;
>> +
>> +                ::core::assert!(
>> +                    back =3D=3D v && (v < 0) =3D=3D (r < 0),
>> +                    "value does not fit into the target type"
>> +                );
>> +
>> +                r
>> +            }
>> +        }
>> +    };
>> +    ($v:expr =3D> u8) =3D> { $crate::cv!(@cast $v =3D> u8) };
>> +    ($v:expr =3D> u16) =3D> { $crate::cv!(@cast $v =3D> u16) };
>> +    ($v:expr =3D> u32) =3D> { $crate::cv!(@cast $v =3D> u32) };
>> +    ($v:expr =3D> u64) =3D> { $crate::cv!(@cast $v =3D> u64) };
>> +    ($v:expr =3D> u128) =3D> { $crate::cv!(@cast $v =3D> u128) };
>> +    ($v:expr =3D> usize) =3D> { $crate::cv!(@cast $v =3D> usize) };
>> +    ($v:expr =3D> i8) =3D> { $crate::cv!(@cast $v =3D> i8) };
>> +    ($v:expr =3D> i16) =3D> { $crate::cv!(@cast $v =3D> i16) };
>> +    ($v:expr =3D> i32) =3D> { $crate::cv!(@cast $v =3D> i32) };
>> +    ($v:expr =3D> i64) =3D> { $crate::cv!(@cast $v =3D> i64) };
>> +    ($v:expr =3D> i128) =3D> { $crate::cv!(@cast $v =3D> i128) };
>> +    ($v:expr =3D> isize) =3D> { $crate::cv!(@cast $v =3D> isize) };
>> +    ($v:expr =3D> $t:ty) =3D> {
>> +        <$t as $crate::num::FromConst<{ $crate::cv!(@cast $v =3D> i128)=
 }>>::VALUE
>> +    };
>> +    ($v:expr) =3D> {
>> +        <_ as $crate::num::FromConst<{ $crate::cv!(@cast $v =3D> i128) =
}>>::VALUE
>> +    };
>
> Can we document the arms a little bit? In particular the `=3D> u8`...
> business. No need to document every single one, one comment for the
> group is fine.

Done.

>
>> +}
>> +#[doc(inline)]
>> +pub use cv;
>> +
>> +/// Types that can be created from an integer constant expression valid=
ated at build time.
>> +///
>> +/// Implement this trait to make a type usable with [`cv!`]. Use the [`=
cv`] macro, not this trait
>> +/// directly, for creating values.
>> +#[diagnostic::on_unimplemented(message =3D "`{Self}` cannot be converte=
d from a constant")]
>> +pub trait FromConst<const V: i128>: Sized {
>> +    /// The value that corresponds to the constant `V`.
>> +    ///
>> +    /// Fails the build if `V` is not a valid value for `Self`.
>> +    const VALUE: Self;
>> +}
>> +
>> +/// Implements [`FromConst`] for primitive integer types and their [`No=
nZero`](core::num::NonZero)
>> +/// versions.
>> +macro_rules! impl_from_const {
>> +    ($($type:ty)*) =3D> {
>> +        $(
>> +        impl<const V: i128> FromConst<V> for $type {
>> +            const VALUE: Self =3D {
>> +                const_assert!(
>> +                    V >=3D <$type>::MIN as i128 && V <=3D <$type>::MAX =
as i128,
>> +                    "constant cannot be represented by the target type"
>> +                );
>> +
>> +                V as $type
>> +            };
>> +        }
>> +
>> +        impl<const V: i128> FromConst<V> for core::num::NonZero<$type> =
{
>> +            const VALUE: Self =3D {
>> +                const_assert!(
>> +                    V >=3D <$type>::MIN as i128 && V <=3D <$type>::MAX =
as i128,
>> +                    "constant cannot be represented by the underlying t=
ype"
>> +                );
>> +
>> +                match core::num::NonZero::new(V as $type) {
>> +                    Some(value) =3D> value,
>> +                    None =3D> panic!("constant cannot be zero"),
>> +                }
>> +            };
>> +        }
>> +        )*
>> +    };
>> +}
>> +
>> +impl_from_const!(
>> +    u8 u16 u32 u64 usize
>> +    i8 i16 i32 i64 isize
>> +);
>> +
>>  /// Designates unsigned primitive types.
>>  pub enum Unsigned {}
>> =20
>> diff --git a/rust/kernel/num/bounded.rs b/rust/kernel/num/bounded.rs
>> index 2a2b0a4bca5e..f720eb44e7d3 100644
>> --- a/rust/kernel/num/bounded.rs
>> +++ b/rust/kernel/num/bounded.rs
>> @@ -14,6 +14,7 @@
>> =20
>>  use kernel::{
>>      num::{
>> +        FromConst,
>>          Integer,
>>          Unsigned, //
>>      },
>> @@ -272,6 +273,24 @@ pub const fn new<const VALUE: $type>() -> Self {
>>                  unsafe { Self::__new(VALUE) }
>>              }
>>          }
>> +
>> +        impl<const N: u32, const V: i128> FromConst<V> for Bounded<$typ=
e, N> {
>> +            const VALUE: Self =3D {
>> +                const_assert!(
>> +                    V >=3D <$type>::MIN as i128 && V <=3D <$type>::MAX =
as i128,
>> +                    "constant cannot be represented by the underlying t=
ype"
>> +                );
>
> Is it possible to leverage `cv!` on the primitive type to avoid this
> `const_assert`, which is basically a copy/paste of the one in `num.rs`?
>
> As a bonus you would also get a value of the right type and don't need
> to use `as` twice below.

Yeah good idea. It seems like this doens't work since by the time you
get inside the macro, it's already treating it as a $ty and that can't
match the primitive arms of cv!. But we can use FromConst::VALUE
directly, that's maybe a bit nicer.

>
>> +                // Statically assert that `V` fits within the set numbe=
r of bits.
>> +                const_assert!(
>> +                    fits_within!(V as $type, $type, N),
>> +                    "constant cannot be represented within the given nu=
mber of bits"
>> +                );
>> +
>> +                // SAFETY: the asserts above confirmed that `V` can be =
represented within `N`
>> +                // bits.
>> +                unsafe { Self::__new(V as $type) }
>> +            };
>> +        }
>>          )*
>>      };
>>  }
>> diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
>> index 82acb531b17b..ac1662c3c8af 100644
>> --- a/rust/kernel/ptr.rs
>> +++ b/rust/kernel/ptr.rs
>> @@ -166,6 +166,20 @@ pub const fn mask(self) -> usize {
>>      }
>>  }
>> =20
>> +impl<const V: i128> crate::num::FromConst<V> for Alignment {
>> +    const VALUE: Self =3D {
>> +        const_assert!(
>> +            V > 0 && V <=3D usize::MAX as i128,
>> +            "constant cannot be represented as an Alignment"
>> +        );
>
> Same here if that works. Otherwise let's add a `CAST:` comment to the
> `as` statement below using this `const_assert` above as justification.
>
> (also realized this could probably be done for the `NonZero` block as
> well)

Did the same using FromConst<> directly here. I did add two CAST:
comments on the base FromConst<V> for <primitive> though that are
unavoidable.

