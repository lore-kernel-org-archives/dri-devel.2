Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C0CC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005EC10E3F9;
	Thu, 27 Aug 2026 13:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="YaHFpyP1";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022094.outbound.protection.outlook.com [52.101.96.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D341610E3F9;
 Thu, 27 Aug 2026 13:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W248hF9dwwz2/n64Ggdb553VXSre6Saytp4WMMxKMAeBpcBr3b8J2KUpZB/hFlJChGwzgfUcsc62pAqX/P4390zVwrT4Rs78dzPa1eT7gFgp1alGBYWT0WgvBhG/pihEtE6qDQ6EkJadneU9LNKr5cQK4jrr/kRFsv3wlEGzjnAtKEGUdKudlIYh8q4NceyrRH7r/IuNBcguSj0CZKmYpHruNj++QoqPwx4j0h7RF3UBkcCLe0HiPKFvSVd5roIr/OaB9NnWercLDKlNYZ5v8gTMjpxqZxcZPEw4+wltnVDRSAOVG6KQMTBbrQT4OY5dIGtwfpkWYxRzzybNFJhM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg6v7L4n57XP3L4C62biOpoWe9Evdhv+mXXVRpL9j0w=;
 b=X5HG+feRmvDD2RG+SIzc7VujYoCjbky0p2jQTqo5nBQJ7d2+qfoCoGfYPI4t5aLUtfn6pmc74Pj3UaRl98+CC5mI26IQLUwQxHbFs65tbqOcMoPd5rmxYCU+Nu702QQYkaWBmjBocdX3BMIUsu+dz91RAN7g5txXyN4P1l8VWXwrNVfCanIJIIS1sNWaswFFkDIxk1SGx4MxfnVoLuYCkXx6awiavd/YmeoHIYTMfnCdWtD2RNrhDZMtW+iBFnywjrO+bdulIUtlIMqsjR+rG05yMeTnr6CmwW+u+fkJ88wj1BQZl01ZpsVoBXBG3WJkH9Lg5bP2dCEBHy1WVg4z0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg6v7L4n57XP3L4C62biOpoWe9Evdhv+mXXVRpL9j0w=;
 b=YaHFpyP1fZ0t5WJ/KIHzdwaXghvYm1NuabthbOOSVgkVvpqW7Qu+9c1Euh6ZHilOfCR2ieyCQApIkG90QYwiy6N1JorFZwejzP0Vf4Gq6b7V7EPALjaYyemxwQ1IGYRGy9km7CxrViyzeekZhyIeGTaAfBQokP7Njv3N9quLOrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB7984.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:464::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 13:59:38 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 13:59:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 14:59:34 +0100
Message-Id: <DKZS3E7Y2G2O.WYBCRQJR63AE@garyguo.net>
Cc: "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.22.0
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
 <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
In-Reply-To: <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
X-ClientProxiedBy: LO4P123CA0615.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::17) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: ba64d1b4-76f3-45ab-f8b9-08df04436d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|56012099006|10067099003|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: haEGKySxzN9Lf9nBHlf0t4DVbEaENuVzCl7hBw8XtVMh1RrySgwenBim88I5cpEYEbRge/vbZ43Oujmh/Kc1GIfz7TmGQiGoUS9xtWWJawqeeuPYmPx7zw5sgYYRQwqxzx8hCD8ujkwxvRMZ9cpY4eSb1AcqKsmoH8PXN9hf0KdnPiEpilv/78gqnGkJSTs6KQwqOgiQF2WmMxx8EmHcQz4b6khlSLFE1zGhnBYp7tXZk0nuex0q1CWSbBwkRFx0w8Bc3g5V+5GsY9hg0z0IzJmLflxm3TNS3e4KH3ru7lTjSPpyhSMXk+S1DT9rRbmwhlB9VEvqRIpTzOSTgwTjqQF2iO+4TKHzcMQI5nrKQ5WyhNgfPoAfEIeK/W/uEALZPBMGIVgAlr/3t11sj2T2fzodk273Xd+NLT6ep+5skOlpBWDIZ9kPlIaguWkQBNtVSZy4uo5YqNrydEGROsKd37fe8dlthe2z1PC/Smh1tNqh5/XrUhqIH+S0kTZZ7OQTNbTeIuGnppDIEI9ak2BqUeOAG6ob5AghYcfTe39+QsgsI6ZnRAWeOnIAAcE24nBtyeC7jqomoC8lYMGjkg+VqYjDmeJvJ9EuS0zTP2zKSXE+nQGi2judZv5cfm5X6OYmHiYSvJh8gC+c0WFMTC9hQw2/RKMbLGlmtMjkeIsxE3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(56012099006)(10067099003)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxkbEtXRTFMWnlsZ0t5amJ6ZWd6bGZiSUFnUDJGVnl3THBYZEhTSWZENHhp?=
 =?utf-8?B?djZXVFRZWFZVUEJjRlh4QzE4ODdEclhtNmY2Wlk5djlaWFkyUUI0VzQrclBO?=
 =?utf-8?B?eVlUbFRSNUFGSEcyMjgxWnNoQmx6NXlEZGhIOE9EM3dKMWF6VEhmTkZUTDM4?=
 =?utf-8?B?WXJMOVdqVmltT240VTdoQXF3Q3NkaEhuZFpLckRmRVhTSDFLNUhyZitmUzdE?=
 =?utf-8?B?VGVpckd3Z2RJbzVDeHBuWG9oUlllZkhzQzc3WGZTdTZpMk5YM2g3M1JERVhm?=
 =?utf-8?B?MjAvRk04dS83NG5LeHNPTXJZMEJMcE1LR0pheU1Kek85eTBmY2dUOHpaZC9w?=
 =?utf-8?B?SGVBSVYrVktrZjJVaUx0cFZRQWdKTURxazVBN2RPUFpmTEEyaUo2dFNJeW84?=
 =?utf-8?B?bUJmaDhseGxoODhlWGRIdUlLQ0djSTJsNEY5VURkOGZGL1lCOFZYcHhsKzVL?=
 =?utf-8?B?MEZaWkE3OXFYVHJ0Z2Z5V0MwbmE5T1Fnc1BBQ0VDYUxrSnNSK1JaekpzRFFP?=
 =?utf-8?B?OG1LN1BIV3dDVlp5NzM1TzdydWk4bXptcGxPTGQvVjBUZ05BcENrRzdXWXk2?=
 =?utf-8?B?cnFQT0FVczdOZjg2d1hPYUp1a0p6TExBRXZlUlNuKzlETURJTWVSNDVDdklU?=
 =?utf-8?B?UUE5NlZyNEJnL1pZSEkrUDk2OGRla3ZUb29hWnoxbmNkRDhXZk9iSTZudVV4?=
 =?utf-8?B?SmNFbWovYlBlcFJtbCtiUUNNaGhpcUhUM2NWZmRFSzd5L3A1R1FML1hTL3Ix?=
 =?utf-8?B?UFBGM0hNMml6TnFlSGlEbFFiQ2Q5cm9ZUzJreWd3c3VqbUQxRVNodXdjbGh3?=
 =?utf-8?B?Z1UwYVF5V2JqaWJlZkJndWt2QkxGYkpTYTFqS0VPQkFvbUFXTGpHNGpyTGh4?=
 =?utf-8?B?alh0dEFtTTlCRVI5KytINGtwamhKbkJFNG8rYlZvazkrekVaMnlVVmN3blV0?=
 =?utf-8?B?Y1hubXJld2NBcDVUdmxOTzNCVllQYWxSTDBZTUM2UkNlUWZCZ1JrWWVtUU1G?=
 =?utf-8?B?ZGlQRlVBaGtoTUtFSHJxUzR0SEZJTzQvWHJ0WGZBS29ydHBHaXlBeVRTK08w?=
 =?utf-8?B?SHVaY0VHQlh5L01lQkRIb3k5Y0k5REFOZDVBLzdRRDNsTEtDVjdsYVczd0xQ?=
 =?utf-8?B?cUR4bFhrTDdRNDlLV3VmSTFtM0pzUXpNUmlJYWgwZmtVTWVXcnJxUW53TSto?=
 =?utf-8?B?Y1NneitqTEpaZjlKMVFrditYVWhhbzdqMlU4VzU0eDZDRldEb1U5emZOem95?=
 =?utf-8?B?TzdzZmM4UElpbDFuWmVadCtxbzU4bGVRN2hoK3FNaHhoaHVBY1labVVWL1pu?=
 =?utf-8?B?TnpEOHRhQzR3aFBCWlkxSWdhQWcwbmpRZStZTDlOOHZZeWd5RzdLMXl0cVZt?=
 =?utf-8?B?ZkMvY3FsLzFPbjNnakRnYnRuYUxGRDNhTVlrbEllVnBGZEhpZHhpQWg0ZjVx?=
 =?utf-8?B?WkxhZTJnSlY2Qkwxem1CRXlyd3hTZDhjWUNIMmNzTjBGM0dEY1Fmak56cyt2?=
 =?utf-8?B?cVYwN2FXeldaTUVXSmRFWEZMUzhmbUt6UENxeElYMDN2OE51RjZReUFyNGE0?=
 =?utf-8?B?LzJQcWdOQmxuR2szc1c3TktNVlN6WFJhWkwrb0ZqN3BYd3lLUkdwdGluY0lU?=
 =?utf-8?B?RDdhV2FSM1ltalBjSWxWeDZDT2dLOTJPUk1CMUhwQmVaN1p4UmQ2Q1dXaDRa?=
 =?utf-8?B?RFBmVytYZWYzaHIyRmtsdXI4aG94TDM2TVRKeXNYYzlOdG1rTk5uWXBQOXZ3?=
 =?utf-8?B?WllBRmdNV1NpS2gweWhKMVQvanFjYm84Z1g2ZVBoVGIvSnNyQWxLa2l1OHl6?=
 =?utf-8?B?VmFpSk9sM3Exdk1QekNGVGFRZHY5MTJFQ3dWZmpna202NmJmUnJxOGk1NWdo?=
 =?utf-8?B?RkxINkw2eS9BZi9yZkhFcmRmKzZYY2VqZ0RmaWI2UjJSZzl4akRRWmtJM2hU?=
 =?utf-8?B?U1UxaWE3NmhCQi9IYk9kRlpxT2FFWTJiOGNWQmJKdEVDaUFvYlBDekRieGJl?=
 =?utf-8?B?eGEwTFBBQkZvOFliY0lPS1hseS9Tb0k5MVZQeXBZT3RIcVdPMUluMVRqamNO?=
 =?utf-8?B?c3E1MmI4VXo4V0FQMkFVaDRhbzhtNkNoTDYzaTlVOFNhbGFxLzdZUWl0dUNX?=
 =?utf-8?B?U3RkY0VpdlRKUEJJU010ZlhhYmMzWnNTMEk5VlU1bzhSQmhXbkRwTGFoRUho?=
 =?utf-8?B?eHQwMnZXaVFpT0Q1ejlpTkdyNVRFRW0rRVZjRThjL2VuRWdZSnlZMVBrRVJk?=
 =?utf-8?B?TFlneG01R1dQQnZZc1Faamlya3MvTXc1VUw4OVNRaDJERUdRRmZVNExFSGNr?=
 =?utf-8?B?UDBGL1RyN2F5RG9IeTRwci82NzlzeTZtTHdjc1ljV2ZBb1Q4eEZkdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ba64d1b4-76f3-45ab-f8b9-08df04436d91
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 13:59:36.0722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5/+cJRb1NV3Rf7tqt9T9NN6rQs5bQoGQ/hVRUpOWRSbvD2DMxH1czK1cEg8zlBO0IWmZkAChXgktbJlS8evOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7984
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

On Thu Aug 27, 2026 at 2:48 PM BST, Eliot Courtney wrote:
> On Thu Aug 27, 2026 at 8:12 PM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
>>> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
>>>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>>>> unfortunate because it disincentivizes using it in interface boundari=
es.
>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for const=
ant
>>>>> value) takes a const integer expression and widens it to i128 (at bui=
ld
>>>>> time only) before passing it as a const generic value to a new trait
>>>>> function `FromConst::from_const`. The trait is implemented by NonZero=
,
>>>>> Bounded, and Alignment and lets values of each be constructed from
>>>>> constants without a verbose turbofish syntax. For example,
>>>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
>>>>>=20
>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>
>>>> This doesn't work in const context, so I don't think this is a great
>>>> strategy.
>>>>
>>>> I would want to use it for cases like this:
>>>>
>>>> drivers/android/binder/netlink.rs
>>>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_REPOR=
T as u8;
>>>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BINDER_A_=
REPORT_ERROR as c_int;
>>>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BINDER_=
A_REPORT_CONTEXT as c_int;
>>>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::BINDER=
_A_REPORT_FROM_PID as c_int;
>>>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::BINDER=
_A_REPORT_FROM_TID as c_int;
>>>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BINDER_A=
_REPORT_TO_PID as c_int;
>>>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BINDER_A=
_REPORT_TO_TID as c_int;
>>>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::BINDER=
_A_REPORT_IS_REPLY as c_int;
>>>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BINDER_A_=
REPORT_FLAGS as c_int;
>>>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDER_A_R=
EPORT_CODE as c_int;
>>>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_DATA_SIZE as c_int;
>>>
>>> `const_as!` [1] should do the trick for this, provided you don't need t=
o
>>> create a const `NonZero`.
>>>
>>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvi=
dia.com/
>>
>> ... but I agree it would be nice to be able to use this in const
>> context. And there is an overlap with `const_as!` that becomes more
>> obvious the more I look at it.
>>
>> In for a penny, in for a pound of macro code as they say. Since we
>> agreed on using macros, how about unifying both under the same `cv!`
>> macro, with as many branches as we have types we want to initialize from
>> a constant value? For instance:
>>
>>     // Does what `const_as!` currently does under the hood.
>>     const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BINDER_CM=
D_REPORT));
>>     // Calls `NonZero::new().unwrap()` under the hood.
>>     const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::uapi::N=
ONZERO_VALUE));
>>     // Calls `Bounded::new::<{ ...}>()` under the hood.
>>     const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kernel::uap=
i::SMALL_VALUE));
>>
>> I.e. we would have one extra matching arm in `cv!` per type it handles
>> instead of implementing a trait. The syntax of the macro would look more
>> natural (bye bye `const_as`'s awkward `=3D>`), albeit it would have the
>> limitations of such a semantic dispatch.
>>
>> Even the name `const_as!` wasn't really accurate to begin with: what it
>> really emulates is a const `try_from`, and we even discussed
>> implementing it in these terms in the future.
>>
>> I'm sure the idea needs more polishing but I think there's something to
>> explore here.
>
> Yeah I agree that const_as! is similar and if we had const traits we
> could fully merge them and have it always work in a const context for
> both duties (which are really a const tryfrom as you said).
>
> I am not sure about the suggested syntax (e.g.
> cv!(Bounded::new(kernel::uapi::SMALL_VALUE))), since it seems very
> verbose.
>
> Alternatively, what about just directly merging them so you use
> cv!(5) (the non const context FromConst::from_const dispatcher in this
> series) or cv!(value =3D> u8) (exactly const_as!), with the =3D>
> distinguishing between the two?
>
> So this is what would work for Alice's example (const_as! but pushed
> inside cv!):
> ```
> const BINDER_CMD_REPORT: u8 =3D cv!(kernel::uapi::BINDER_CMD_REPORT =3D> =
u8);
> ```
>
> When we have const traits then we could remove the =3D> syntax I think.

It'd still be useful to allow explicit specification if user prefers. I thi=
nk it
makes sense to (ultimately) translate

    cv!(val)

to

    const { FromConst::from_const(val as i128) }

and

    cv!(val =3D> ty)

to

    const { ty::from_const(val as i128) }

I think there might be some tricks possible to get it working without const
trait, e.g. for `Bounded` and `Alignment` we could simply add an inherent m=
ethod

    #[doc(hidden)]
    #[inline]
    const fn __from_const(val: i128) -> Self { ... }

but I'll need to think about how to make it work with core types.

Best,
Gary

