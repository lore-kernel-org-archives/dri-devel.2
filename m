Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318A4C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A57510E291;
	Sun, 20 Sep 2026 15:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hePgrP6P";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861AE10E291
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 15:04:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ki0I0TlVeCX0jxCn5d6Ll3EOg+P5pOW2+NJnKg5rN6Y9g1AP0iUzVltQBk7yzMKnG0hbyX6pgxUkxQGdVZGafQJ7VesxqEHHeQUWOyqgE8G1svHBMyjBL90Pr0wTknoc2ZxHFGNW3V7vkqU4Bq4VnfCXfN8YZwNp71oyZJbsLua99EOZJgxENeModcGgdlf7GZnwBDetbT0EI+wlLMntGwHFH7zVQiYyn6wbz2Ktf8E0RnhbY/Strm51ylXjCqE0RZ/BSCMs4IBjABQt9i1fhJji9UJSXqFbVBulFhkTgZnsNBFzs0aLWw2q8df29M5AfUfvZOkbHdeGawEYqejTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc7TnKwBmZBkg+aYwHjG7GWj2EaFkMDuHhD5aSaOcbk=;
 b=Pbhw6rNQx+Uw2jHsGwdqHZpvd1YX+b/8XAWQuj5qraKumdx3P7sr8KwVS6iQ58vvaD/se39mSHaUbTrgmOJ0y/NyjBnY+VAUttqUURjLUXiyUzINf2e5ZaWN13GMNsMtqHprncjybuN9KtZhsA2WjVKA5rG4ppGfwCQt3d3zNYKgxTRXJGNuFNM6GAUn/C9Y1m/P9wg5RlmmkhRfCAWEbn8kCJ/jtAZWVPUyMTekPhulG4UVuMrtAtvINCuRlaqTate5OH/dnKPaXYPQpMBpKyvLAy0NoCSvZFkYmb1vejHJDS5pxBiNxvwyhpSB0kP3SHQaHL//Z7SFoJ6zbXFq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc7TnKwBmZBkg+aYwHjG7GWj2EaFkMDuHhD5aSaOcbk=;
 b=hePgrP6Pm8eg/NJ3WO/WfnoOrE18o2EBeZ7w+HHLfW1FylHCUZ5b2kVW3jwXBof4f+k2AVDkZ3YfP4Oc/6OtIaFsNJUbGgGSaKsJ+r3XS+ScwWjPHEoFO6WU5vOrfWKdWvFz/vDgu/G/ofSEFfljimD44ks0wql2sxhqSfU6rNhQcFA5hNlqe1zzSQ1edpkOkti1QIckOZsnZTcDIoRsFLRTrJa/3H3IdWhTPLUqef9m8PqXnAIYxEdQxQvQ3Fw/ZfnbRxf8//RIE7yD33pXi1twRV4H8WdSGzQVewZByevPJZHaM92rFWsTwnYmFz9aVY1Zaqoehn/ODxT3XJdo2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 15:04:32 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 15:04:32 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 00:04:29 +0900
Message-Id: <DLK8I686ILHU.2NE50HPZX3Z10@nvidia.com>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
 <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
 <DLHGQN9VQ3TE.JYI851RVF7VD@garyguo.net>
 <DLIN1ZH244ZA.3JVCE0YKWAQ6B@nvidia.com>
 <DLK50D524P11.3CZN924YW8HHQ@garyguo.net>
 <DLK5E4VWQNU7.1K3YYYCZO2WRY@kernel.org>
 <DLK6XHP5NIN4.37W548MAWYF67@garyguo.net>
In-Reply-To: <DLK6XHP5NIN4.37W548MAWYF67@garyguo.net>
X-ClientProxiedBy: TY4P286CA0135.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: d77ffa48-d972-4d97-f270-08df172879c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|10070799003|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: /5xJX0xJc83v3WxILarX9NtDH2lWfQxz8UqQti8KgrI53BrgiI8/ocj5T2UqGqEooZTow+nD7OrJn56dpNF4BpxXW1LoGR9TS/2GyoWHqvBc0I5NoNaphw6tq/E91zr87ly2z5RedWBby7FNo1VL6EyFwwoy7mUwQcuW5IQ07CWQc6rpJtGXDMpKKpEQYbGsvYi3wrWRjI/B4aMf7ElZ/U3zWyUGhbGdJpdMF+923/ruvWyA5+hdfrrlprGOjRuRRa3iWf7E2JFv/Duj0O3SxkP8lB42Fxp6tBatXclbgw7G/xe8dg6RCn240NjvKDnBaoo5HjA6r4W/5E27BltSNUmPdD3Q8WiV8qUK1BUIpNz986ix9cBiq9GNU4u9yWjRkpStYg435Rh3B8O2eAa8idxAMT4djL6By2vvclKjQNVcP1tWhSfRgw97wZ/j+y7Tmrm9RLXDlTvTl6sNZwjJrmEopLSBeZ8LtFjtL/LzUEwOm02BO2whLE7yeVhc9hzwbm+Tkv/PzbVF6sdHChaJpJJMRI+EIps/5dJL9y6/deiClgn7aTzCHFGvnG2KJGRBuLQcx/Jtv8mZRLehq+tWsqVHV5edM+ZDY1T3/M30LGvMGY2lbB68zZm6V0sSBDrDpedwXkQ/lS418gtv6SLEDMapEbX4L47gQoG2kPl9kcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(10070799003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZCRWZGNnlPVWtEZ2VRMkxWSzY0anJROEJsbk9ma3RySW5TaVNqdnp6SnU3?=
 =?utf-8?B?cUNicXBsUWJiMVFBMEdoYTZWOWJ0M0VMR1pqOWdXWXVBZW56WmZ5ZTdoQzBl?=
 =?utf-8?B?UDlGeDdiSTF0TG0rTktlSDdYQ2FoTFpyQUFHYWdJK21YdVFnT1d5OUg5VGdG?=
 =?utf-8?B?dlRLTTBtL3lCMWNFakc1eXJUM0NJc3c3eFh5ekJBVEx6VVJCRFVvaGFPNUY0?=
 =?utf-8?B?QmhiZnAzZFJIVXlpa1RrNWxJaFgrNEpWeXdWT3cvSWFQazVnTTdHQjlUVkEz?=
 =?utf-8?B?NytETllWam5lWUUwMHFEaEU1eGhQdXkraUhhL3MzSUtVZ2FseitwL2tnd2dT?=
 =?utf-8?B?by93Szc5ai96K1N2RWpVd2FFTGhiV2FGVmRpVVVRYUw1WWdla1NDd3ZSU25t?=
 =?utf-8?B?TnRoN09aVzB5ZkRvU3k0eENkZVhmQmdBcnRtaGFlbkgwZ3pOOVNFdmtZUnRs?=
 =?utf-8?B?dWtlVkVxTnduaWZycGdIbW5HMHdNRG5yRGlVWk1DR09PQ3V6YU54aFg2bkhs?=
 =?utf-8?B?Zms3ZERPZUVGZUxHNnBCZjUwWmR3SnN0TzBacVFvd0tPRXlwR2pVTHVkb3d4?=
 =?utf-8?B?QXYwWTV3VVBubVVKL3M0RWlMNm5FZThFQy9sR1ZBM2U3MVU5amY5NVdpZkN2?=
 =?utf-8?B?b0d5ZkhYOWVSZ2lGa2xOcE5xQlVIaEhLQ0l2T1FRZ0RWMnlIN3hScDUxM2ZV?=
 =?utf-8?B?akQ3OHd2ZHcyRWhFbVFxN0FqMzJ0MlZqNkR4VjdyYzZ0Rll3STB0VjNvZWxa?=
 =?utf-8?B?VE9xMXNLN2piZ3R2ZzhSMU9pQVZzVlNDWlBCTk53VTFzNlhLaXg2blRaOFFl?=
 =?utf-8?B?WXlFZG9KcGtMLytrTEZkRFFPc0VXZDYzd1JjR3d2d01YSkpnbEhiR0dUdEdn?=
 =?utf-8?B?NnB3THl0U3FSK3MvWUlSNGNYa2dGUXltWEZqUEtrNVd3c3NLQ0pPK2oyRTVM?=
 =?utf-8?B?eld4QWl0QkVUcFFKN1J6UEx6cjdaYkxlQUlVSFlVM0VpME4vZ0ZlQnBHb1Vt?=
 =?utf-8?B?M0dJUlo1K0t3SGJuU1h1TXVJYkJyRDY1bWcwNnNPMXllYSt5QjVveHd1Ny82?=
 =?utf-8?B?LzRnVWo5bHdKSmhUMUVmeDBGbTdKeSs4RGhDSS9KcFlIMVdQK2s0VVlHZGRp?=
 =?utf-8?B?N2gxcitDWis4SExBRFJXVk1YbkMyOXVlWFBvOXF2T3NZQWlhdk0xQ2pxTVkv?=
 =?utf-8?B?YmFlaTFmNzdwWkpINW5sUDU0S0dUcWxlUjdZa3lvd1J1dU1JTUZzL096bE5P?=
 =?utf-8?B?VjJQRnRTaThXZzBndVR0YTc3Y3hRNHhrSFh6M0RMMXpCT1p6TDV6blVobWo2?=
 =?utf-8?B?QUxFa2EvSW80YWE0cHVwUDJYME13Rm1XaHlRaTRGUFQxQ3dFMDJHcjhHNUpw?=
 =?utf-8?B?NWJ4UkRWbGNlNFVYWVg2ZDBSenRMd3dGMjZsU3U3cEllZVNGRnY1Rm4vT2xo?=
 =?utf-8?B?dkRFczFNK0xnT21IcWd5M0pNSDVDU1BEOE5OL1lJSW1MMXVtaVpjeDg5MGNj?=
 =?utf-8?B?RUxPYktCc3NQOC9wYkVCS25zdEk4MVBDMTc3TFAvbWNTdStuWmwya3dBMFN5?=
 =?utf-8?B?UE5HZEZRZVZxWHhqd0dTYS80U2hBdzAyUEF1dlJkYkI1RnRMK0hGRzFITlEr?=
 =?utf-8?B?NVF5Tkd6MVNuNzQwV09vWXUxY1lnbW90Z3lJck9iVDNvNVFybFI3QnhvY1c3?=
 =?utf-8?B?RkR4eE1na2lHQ2JXUzY2eGhsdnRDaGkvLzRYL0pmR1FtWnhMazg1aXF0dE0w?=
 =?utf-8?B?Qm5LeFhpTkdCalNKT2FjSlhHV2RKbHNLRm1wamxpVVNYQ3h2R2RDSXhyRUdE?=
 =?utf-8?B?NmdUUFNPWEwxWGI1RWhPSDhka0QyYjN5L3JtSE9ReHd1WWdmVjRxVU5XYThw?=
 =?utf-8?B?TmxSRFkwcDdSZW9RRDVINURlanpNZXhBcnQ5ODllREpwT3FTdGl5QmI2S2JH?=
 =?utf-8?B?OTZNdTVSUW5jbHd2ak1ETWhudFlNa1FpZUo3dEc4bjc2WlErNGRtcTBoa21h?=
 =?utf-8?B?TWxxUkN1djVRV1hnckFHQ2REK2R5SzdCek9heUY2bEo0NmFDdHFhZUxKZDFI?=
 =?utf-8?B?RkZyYjdpRFkra2ZldWh0Ny9XZFRvZzlRSmtSOThEVXdFNmRRNnY4Nm5PMzJP?=
 =?utf-8?B?aGtldE05alhKV0JObFo2NDhLdDlSb3ZKcnNMVWMxbVhsdVVFR0dydnFSeE5F?=
 =?utf-8?B?K2x2T0lteXBybStsY2s3U0VBN292cHkzTHFnYnJ6TVNVeHhDdnpoS3BlM0ti?=
 =?utf-8?B?MWZ4Y3owaUEzSVhxZWkzQmg4ZXlJMVprMmFnQVVYNm9lZjlYQ1Ftcm5abVFx?=
 =?utf-8?B?bkFwSFRGVHhsdkozTUlNc1VCOFdBenZtN1lWZXYxZmQyZ1ZsZlUyU2pRL3JJ?=
 =?utf-8?Q?5rUlPrzrkMDQllNe+EXp5Xjai1yr2qd7qotzjwHXHGS+n?=
X-MS-Exchange-AntiSpam-MessageData-1: SmT6civKcHk70g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77ffa48-d972-4d97-f270-08df172879c7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 15:04:32.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjaBtJZnZGJH1onM/JXU9pwpUueggvjCPewdjUQcA/5r0+gv3cLh/qDxhBInVG5ML72YGKYpbrteSi9DoT0j9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
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

On Sun Sep 20, 2026 at 10:50 PM JST, Gary Guo wrote:
> On Sun Sep 20, 2026 at 1:38 PM BST, Danilo Krummrich wrote:
>> On Sun Sep 20, 2026 at 2:20 PM CEST, Gary Guo wrote:
>>> On Fri Sep 18, 2026 at 7:03 PM BST, Alexandre Courbot wrote:
>>>> On Thu Sep 17, 2026 at 9:53 AM BST, Gary Guo wrote:
>>>>> On Tue Sep 15, 2026 at 8:39 AM BST, Alexandre Courbot wrote:
>>>>>> On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
>>>>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>>>>>> unfortunate because it disincentivizes using it in interface bounda=
ries.
>>>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for con=
stant
>>>>>>> value) takes a const integer expression and widens it to i128 (at b=
uild
>>>>>>> time only) before passing it as a const generic value to a new trai=
t
>>>>>>> `FromConst`. The value is then converted and appears in the
>>>>>>> associated constant `FromConst::VALUE`. The trait is implemented by
>>>>>>> NonZero, Bounded, and Alignment and lets values of each be construc=
ted
>>>>>>> from constants without a verbose turbofish syntax.
>>>>>>> For example, `const { NonZero::new(1).unwrap() }` can be written as
>>>>>>> `cv!(1)`.
>>>>>>>
>>>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>>>
>>>>>> I don't think we have any user but nova-core at the moment, and it
>>>>>> benefits from this in several series (patch 3 here, but also ID pool=
 and
>>>>>> later r000). Miguel, is this ok if we take it (i.e. the next revisio=
n)
>>>>>> through drm-rust-next?
>>>>>
>>>>> How about a topic tag shared between Rust and drm-rust-next? We could=
 also
>>>>> remove the old num casts API as part of topic tag and fix all existin=
g users as
>>>>> part of merge.
>>>>
>>>> Not opposed to the idea but IIRC there was already some pushback to th=
e
>>>> idea. There doesn't seem to be an urgency to remove the old num casts
>>>> API that justifies doing it now with a more complicated merge path.=20
>>>
>>> Sorry, what pushbacks? I thought that `cv!` is what everyone agrees on.=
 I see no
>>> downside of this compared to the turbofish const conversion APIs.
>>>
>>> I am not opposed to delaying removal for the next cycle, but IMO the `c=
v!` macro
>>> should be present on Rust tree so it's visible and improvements can be =
made from
>>> there, so I think we should do a topic tag regardless whether the old A=
PI
>>> removal happens or not.
>>
>> I think Alex refers to this thread [1]; there's was some more context to=
 this
>> though.
>
> Right, so "pushback" here relates to the logistics of old API removal, no=
t the
> idea of `cv!`?

Correct - sorry about the confusion.
