Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C370C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F22A10F072;
	Thu, 27 Aug 2026 13:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QAU+oE2z";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0DA810F072;
 Thu, 27 Aug 2026 13:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U81qH69sTr3QpKAUkY6M8O+LyqtAYmlfKECloEv7s+qR23RasqkCtTqFQ987HrPiKo+d6juS0JV28CZbRjzG7LkIKMdP+Pd6uWzBENqX1R63GFgAwuKGZlvYuu1hXtwMKTCDuUeyOxJ7yC30yo+jcjVF176dmYIbIiQeGOXhlBdvjVdvBGcBMlvtUoZw0cdqkrjZt9PaAQB3QddeseursI0vWyKfPq+dHhCJGQliJ1l0MiIL68R9cXwEkV//PLZ4Bi8q3YhZEMGA7GqZahpHZV/3k3u/Qa13GeouUc5cKia0HLJvA7OMWSdLN0mJfK1jdr5iGvUwRYivkarOvVZqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNbQXb2Xa0t/eGKHGx2Xe+Mt5lKdc9ACLcfGz35AHZ8=;
 b=T/yv3pXU0+eXMCr0e3YNlPmAawlCeRE9wzS0oR5HAwx6dHiVrV9WPiTsoYpMmVjML58/vkvZL4j4Ck67k+uCa4QtuuDGqY69FPVrY6oT/1sbemNMYQV91FvdVwGooJVIQ8CdxESr5gEktM8Ti/1wuH1IOZLckZGSFXMwN8y/2NYmyNjvHIDUQgrpnyZYLWcanE7lsNs0t/GbeAp0ZPvnhNxnOKw+YHN9QtiUNaRnT2d89g16vDmjMxG8hIkPnngNVbpTAySc46Bj2FfAEfWNUyg/IjX4/06qYi7DEc86Iphy9YYA2mf7Ls5sZw14VO2m0Gry0QgB59MRImQpUrnFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNbQXb2Xa0t/eGKHGx2Xe+Mt5lKdc9ACLcfGz35AHZ8=;
 b=QAU+oE2zi7cQAtiTIDRYBFDk2esccl7bDn8tZ9anYJJ9f0e9syKrwduQVPmYE5hQFdvKmhShRA8zr/A+ZXCdWNp8Y50GwhCb2S48GegNmIY7N5K/KJIY6oHMj7VjxAx4x0c/1kTtWeFyVG8lMBLrIBF8gAhRmSJabrHJ3vLT5n/23IkJegBC5dTpZrby9eoIYzZKpkiHCjdbQGzOJYULOezXEsp6AQR9HskBJ0l6DjsxkbWfgKDeDcbJcaPPgIY8PZEdsPySXHcp7bEt9TM0vgqeiCxQjTour9ufvCa5Dp6m2SHPtnvSKD1e+FOQZKg+7QgtxSsszPGYTGziaDVSHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 27 Aug
 2026 13:48:13 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 13:48:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 22:48:10 +0900
Message-Id: <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
In-Reply-To: <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
X-ClientProxiedBy: TY4P301CA0111.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a4dc51-e6d1-49e8-e406-08df0441d6b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10070799003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: OeiEvA7usoBnNWQnEOparzFgg3Il5T0UdWnH+uedj9H/bGsvclsCfuDZpBo1hJ8rTLlidTU2bHHWitjxdIyEq4WBvRfa2Z/0bfmBtt0ridz4r3n43+zTCIslPRjC1E3PW6ykZR6DDuibj+DkjR//WGOGbMiQPgHAgvrRZwXoxTKdfkl+bN0UndGDOXkKmAzfXxLKyIFdlvCmd+bNmHbY+FL/QKfHX3jcng4eauokil4ePjFVLkWC2Z38TZbMM8JDUT4wahWYu76ON4QWynfGgpXi+Ayrohn59YacXQF/dmhljLaKrTthlqVi34ItiAsjoug5f45IOkdo2MbHd5VSQWlV+xotwSom/F7e+2ukbQH9OiAohHbwHlI/HuFL/X/bpBmNld8YH17dvTAdsU9xt3ljKcxqJ0dmNPFjoYFGf8jKDuTRF/yZEyrQaXT36YbFp4Ja0lHdTFoS0PMRnivz7byiORxZDoYb5MebZH1G1IhDS+A4NePZ3gnEK6+V7HHLONc5FGAhkVlYxgUw1b2IYKYl98YjxT5VXT2maXC/9nd01kLG/Df1w9NT5PDtCqbffmbBmeFQk2mI0JGDKs8Ma/yf2/VCrrNxuM5z5mQyYLrFnWfYsHalnRmnEzyKdrqCnBX7Q10M6lUeLMrExB0+qxgN3FP/pHBTxVaRBB/LS4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWxLVXZXeUN5WW1GRm91UnhIN2Y0N1haQmE1UHhJc3RlWUF3WjFDQ0NxcW5y?=
 =?utf-8?B?UjBiY3BDdXp0ZjFwcDZoQ3dFMzgyOVk2ZGxhNGRzaDJYMGYzYW9RMXZadVA5?=
 =?utf-8?B?V1Bpekd2NWpGTTlsdi9lazAxQW1tODdycUEzQURiNnBhTVp0OWZyak8xYUdX?=
 =?utf-8?B?OVZ3WmJRcWtEbzNsc1owYXRqWnBYVlVXZE9rdGtGSkkra0tETjdkTlNlYnZl?=
 =?utf-8?B?TnBiY3JWYlBMVXlKSXIra1ltVHVmc1AyQ0lpNU1jYzFzTkx4YXhubWV5eW8x?=
 =?utf-8?B?NFZMRmppMGV4QWd6THo4K2NlTXp4R3REbXlPdEg2ZG5RdDZLRmhUTHN6Q2xW?=
 =?utf-8?B?bnFzTFgyZG9XZGhyM09RNEdYbVNBbVR6bm14L1Bla3RVOUFaZnV6ZWY0MzV0?=
 =?utf-8?B?R1hLZUVNOUo0NUFlWEJHbm1NL0x3NzNOUVp4SkhYUll3SVd6aGhaSXh0SVY0?=
 =?utf-8?B?bHczdHJFS3ZoNUVKbm5WTDlBUUw2RFpsclE4ZlB5T2xqNHM3cTM4YlNhbkxm?=
 =?utf-8?B?QkkxWXJNY29yZHZqSnpBcnorZHlmdXEzSDI0a29nL3dVM0hZL0hiU3FaYVUv?=
 =?utf-8?B?VzZzcFZ6eHUvc1EvSFUwYWU1Vm10QWFqRVBvZGl2L0Y1bmp6VGFROCthMEtL?=
 =?utf-8?B?ME02Y2ZhU1JiR1lHaUJDc0NZVUdvL0d4TGsvS0w5aWw5dWxvcEczS0VoMUgy?=
 =?utf-8?B?QitjM3ZWM3Ywa2VaSFZ3OVk0bXJUc0xOQWppNjNQazF4SFhBYmxCVWxuUGxZ?=
 =?utf-8?B?TWVyQ1FCYVp6YlhZdW03UXNyUUl6aHpBWGk4ZEdjTXdGd0t4NzkxQTd6WnhU?=
 =?utf-8?B?ZDhyY2JrcGVRcWNsVzNJdVdZajJvUmlocXJ2R3JiR1hiTW9sVmNzNXBTaGdl?=
 =?utf-8?B?T1kzRjRyTWpBcC96TUUyVGdHaDlUZ0I5aGdydHBhL2owd2d4UXRPT3JqZ2xR?=
 =?utf-8?B?YU8xRVNGai9vQlRtUzJXQjgzNHdkVWEyWmthZnVGNzlhV1M3OFN1VGg2Z2h6?=
 =?utf-8?B?a3U5NmtTTXpSL05heUpLMXBIT0FzT1NzM3pCbW1CQVlGb1NkeXJkc21sQWtm?=
 =?utf-8?B?VHA5TTVadXIrVjBvU3NTV0dPUnpIM0NQRkMybXpXVzNyY013VmcwaHRGTUdp?=
 =?utf-8?B?N2JRM041bjVLWXlXdFRhZnF6MFdIclV4YmdXeDgyb1pOWVRsN2V3V1RtMlJS?=
 =?utf-8?B?dzV2dFY4TllSeDdnUlVHR29aZG5vOUhaYjg3UFB4RTN5TWJFcGlBSWNRdFhW?=
 =?utf-8?B?TlJFTW1JU243SStxV3hkc1ZVZ2M2Tkdkb2JrVjRvdnY4N3NaQVAzaUI0OXB4?=
 =?utf-8?B?VllwUkw4UHduQnMrTWtYeFJSby9yajI2Vk1ZNkF3VVh3Ui9SQnUyUkFOZ3Mr?=
 =?utf-8?B?UGpIUk5LVDBlelpMMFR4NmFiZ2tIRmtGeFFSeGl1Tjk0UTU0dlpOTEhrYTRJ?=
 =?utf-8?B?UDRucTJoWHlBajlUZ0YzLzRrVVZ5alNxR2VjVG5FTmZkd2tHaTVEc2NUdDBv?=
 =?utf-8?B?UUNXNlg4NS95QUJ4QnpIQTRkQVh0VTlEeXJlRCs0NTQ4TitwRitWaGZjOXZ0?=
 =?utf-8?B?RWlqSXE1MWtpOXdZWnM2amJMZGxGZjAzdU9rVk45R3VQMW1hbzJRR3haQUNT?=
 =?utf-8?B?bzVjTEJrSTgzaG9OU2xaLzF5d3haRGhHWmtlNlpWNVBJL2ZrYkJCRmIycjVK?=
 =?utf-8?B?eXNNZWZUa1V1cnlpeE1UeFE3NUJUT3lJc3c1K0twa1NHUkt4TXIyQlRjVWtl?=
 =?utf-8?B?NWZIZno4aWt1c0pSRm44akVZMFJzUGNrclp0a0NaUHBoK3NUT0VNdHpmY2FH?=
 =?utf-8?B?dkNIVTlObXBPdGZ6Sy9XQmpOditOd1U3MzZmcnlkRk9zdXNRSEF0cGVHVVdv?=
 =?utf-8?B?eXpGaU9EeWtESjhVM0JmMklObTJYS0JuemFKcWVxT0t5bHlLWDNsWDdqaVZD?=
 =?utf-8?B?ODVqS2JhanFLZ0ZOVm54Tzl3SnJOangzdzR4SUtXbDFOVEo4c3J0N0JzcUNY?=
 =?utf-8?B?TzhpR0g1bTR4WHl6d21jaUhxMnJ0UnJwdVNaN2pTalpzWkJlTGpKNFY3NnN4?=
 =?utf-8?B?ejRsbDRVQVREYlNtMTJxTG5EcGtlWEd5SUNOWlJuOW91Vk9FMEVhWEk0dm1Z?=
 =?utf-8?B?bHgzZjV6UFZsaXZYTTZrOElScTRsMWFtZ2c3ZDdyVURPOHc0S0lNUm1UQyt1?=
 =?utf-8?B?L3FpUkUvL204NmJTRUx0aEJuTlZGUkdXTTN6TlhnY0xNRW9FRzIzVnEvYXl1?=
 =?utf-8?B?SFJiejZzc0FNQmlHNXU5STh0aU5CWkVSdzNkVmM4dWpVOXBaOXlhajhDWEZo?=
 =?utf-8?B?OTBDbmNCL0Rrd0QvcHkrNHB6Y2twMXJ2eEViYUtTa1NtWllPVDJ0NWFVYjJF?=
 =?utf-8?Q?ycwPcMIDX4foNqUykQqgn1guR6ypIuwf8FUnLsMxW0xpX?=
X-MS-Exchange-AntiSpam-MessageData-1: niNpIjlbrQu2ZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a4dc51-e6d1-49e8-e406-08df0441d6b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 13:48:13.2866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMIQEEkmJalfQv9krzWmuM2FAUl75dhIT2aquiJdxm7NhYkNRTM3iEMM7UoxmNslB8YKIFDB81m4c2If/BvJZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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

On Thu Aug 27, 2026 at 8:12 PM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
>>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>>> unfortunate because it disincentivizes using it in interface boundarie=
s.
>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for consta=
nt
>>>> value) takes a const integer expression and widens it to i128 (at buil=
d
>>>> time only) before passing it as a const generic value to a new trait
>>>> function `FromConst::from_const`. The trait is implemented by NonZero,
>>>> Bounded, and Alignment and lets values of each be constructed from
>>>> constants without a verbose turbofish syntax. For example,
>>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
>>>>=20
>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>
>>> This doesn't work in const context, so I don't think this is a great
>>> strategy.
>>>
>>> I would want to use it for cases like this:
>>>
>>> drivers/android/binder/netlink.rs
>>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_REPORT=
 as u8;
>>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BINDER_A_R=
EPORT_ERROR as c_int;
>>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BINDER_A=
_REPORT_CONTEXT as c_int;
>>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::BINDER_=
A_REPORT_FROM_PID as c_int;
>>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::BINDER_=
A_REPORT_FROM_TID as c_int;
>>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BINDER_A_=
REPORT_TO_PID as c_int;
>>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BINDER_A_=
REPORT_TO_TID as c_int;
>>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::BINDER_=
A_REPORT_IS_REPLY as c_int;
>>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BINDER_A_R=
EPORT_FLAGS as c_int;
>>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDER_A_RE=
PORT_CODE as c_int;
>>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::BINDER=
_A_REPORT_DATA_SIZE as c_int;
>>
>> `const_as!` [1] should do the trick for this, provided you don't need to
>> create a const `NonZero`.
>>
>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvid=
ia.com/
>
> ... but I agree it would be nice to be able to use this in const
> context. And there is an overlap with `const_as!` that becomes more
> obvious the more I look at it.
>
> In for a penny, in for a pound of macro code as they say. Since we
> agreed on using macros, how about unifying both under the same `cv!`
> macro, with as many branches as we have types we want to initialize from
> a constant value? For instance:
>
>     // Does what `const_as!` currently does under the hood.
>     const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BINDER_CMD=
_REPORT));
>     // Calls `NonZero::new().unwrap()` under the hood.
>     const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::uapi::NO=
NZERO_VALUE));
>     // Calls `Bounded::new::<{ ...}>()` under the hood.
>     const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kernel::uapi=
::SMALL_VALUE));
>
> I.e. we would have one extra matching arm in `cv!` per type it handles
> instead of implementing a trait. The syntax of the macro would look more
> natural (bye bye `const_as`'s awkward `=3D>`), albeit it would have the
> limitations of such a semantic dispatch.
>
> Even the name `const_as!` wasn't really accurate to begin with: what it
> really emulates is a const `try_from`, and we even discussed
> implementing it in these terms in the future.
>
> I'm sure the idea needs more polishing but I think there's something to
> explore here.

Yeah I agree that const_as! is similar and if we had const traits we
could fully merge them and have it always work in a const context for
both duties (which are really a const tryfrom as you said).

I am not sure about the suggested syntax (e.g.
cv!(Bounded::new(kernel::uapi::SMALL_VALUE))), since it seems very
verbose.

Alternatively, what about just directly merging them so you use
cv!(5) (the non const context FromConst::from_const dispatcher in this
series) or cv!(value =3D> u8) (exactly const_as!), with the =3D>
distinguishing between the two?

So this is what would work for Alice's example (const_as! but pushed
inside cv!):
```
const BINDER_CMD_REPORT: u8 =3D cv!(kernel::uapi::BINDER_CMD_REPORT =3D> u8=
);
```

When we have const traits then we could remove the =3D> syntax I think.
