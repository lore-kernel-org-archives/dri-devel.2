Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DE9C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E94610E3E7;
	Thu, 27 Aug 2026 11:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q0BUPGGZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388A810E3E7
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 11:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6vvn0fAF3PYQSYK023IVrtSxMl878Kx1tX6CMKCM75DSXHj0BNBu7PiGOYV/9wv0RHiQU35suQvZvEp2fqj0shd5oCYFKVMG0H5RRW5N0xITEtRrlrS94EhdHeM38tkE1K9b6bzm2vkJs/cHQgzksVWCV2JCrYiWBjZegJGAcvvXrbwyxgbapR0zqDFbwljC2qHSdght4VguZOKriKgT9vmDWqpzyzdd1+gAj/9x8x3/GqqFt7XU991Ubw4WuL/EcG4e+zMBYsWKRKaNYfjabf0NdrDcNiXC/Uq6MuwHf8mAe9wfahkXvDEh/5oEYE6ppaS2ZRFurueWLzUckR/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEn6ctfPOrWPA6QDIIXpOE/NTpEQMLKqe5nsyKCURuo=;
 b=O+HenhOYy2KBzFQ2Cvy/46mB9eysZjXUcxJ0u697KnstAmILQ33kOBnHVQgFptx9qRuw4x7l/9BBkpL1C9kn7Ak2Pt2GzFYKGyQcEyEV/Pbd+wwXuizJPxi7GFY64aeuj9iWjtDwkW2RGyn6u1ze9m9pRta192cThkQ/P402Xjxv1qqFUPx+nqdA+fu2X5WeGj3EWKof+wO47X4ZbYm9lGe5UQJi05K7PHrNqzJ4uqEP2Ue/e/TRgiDEHUj8Rc35tsEo5vQFHDGhhJtiZIrdPDTNFFJkgfoz5bwECx51Bxf3O0Y/0NTW94di80StkYoO2uyqrq7MeT4+lGxXRV1MQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEn6ctfPOrWPA6QDIIXpOE/NTpEQMLKqe5nsyKCURuo=;
 b=Q0BUPGGZ2fxJsUVYdKrDyvnLSM0mXsk/cFUrSBi2y/oAJn9dlU9Zqfk6tVSHbpU/wB1C8RhiIAhiqEIqmol1U0drbSMc2vkwKRkX19orja2GuAnD4aCNEQhYAytn9gIq2VW5FU26DAWrJr0KWa9wj/8E/QvAACS6Zr2O9s7a8ARC/aQX5LCe3eVDJq2QYbMjuPXCFaZkl5ue8njNo07JuBN+AguX4GSmx6MMO0nm7yxJrSo3/uZL6NZHXruTqPbZ2ThxRmPcAnK6IxWIv0GgRfrTN0PNGZFo4WO05ejDrRKwASswUlgmDeHFgmX3k87tM0Ue9ifyT76hlW2opyC39A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 27 Aug
 2026 11:12:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 11:12:42 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 20:12:39 +0900
Message-Id: <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
In-Reply-To: <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
X-ClientProxiedBy: TYCP301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d48051d-1dfe-4495-c5fc-08df042c1d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|10070799003|1800799024|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Vi17sojkfXhEs57ufaA1UpwQ03oW5rEQe6oPdhLXpSngoq1DTuNek4OOlYrVyfckXDgIC6sZX6jJXZ/hmvOQ904IWFsOaTVMokJhB5TNfyiFAHHHNMU8hFDqV3jxiUFJrdMFBNfxEWfkcO33YplP7C2Cbhmjk2rjMsUD3kBIzqek7cFdZy/R+OnXgNkuxfSxlpPotmYKPaQgyaD34/agKVdYGLAuqUhrwDpomipn+dAiYZILaaBh6RR2OVOWxS3NukUeqrKsp7+RcGVWyGqu2fksacBaLAmCqrzEqux8x/liQo8nhyCOnc3oOIPCG1QbefXXwHxLItE6cx0XAgod9Dt5U8+xrRkgMDiIOdNJ83VLRkstZBTkufTj2tzejKtUCTl7FFPgbA7KZMtPLk7eoqeyXpw77WPpfTvImUQJTh9ldG1YRr0TRxQZC0hpYQyM/AVYmuT+qtx7J/kyk0woo0Ee3gRIUuu1Kq2RczQsdBIpX/X0QFrTImBxDEQ6ljbfenanInUySw3iINHZx1Z9Lh8/JtcLqn+mCW6xDpMptX5c1+EyDPbHfxfRg1BIPr2lrVy6e8wMbLGrtvDC2J5/Xsri0+cRkYAUAW6Z5v2mtpVUQ2ht6XA4lkalz94tfyJ8rzYLyCia7j5IrEJgQMHO4yVNY0119UW1ujQcI2odvRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(10070799003)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUphTFRpR2pIYmgzeTRqVVQzd3RoZmptSnArZXhWTGVPMkVFeUlZb2xhZENo?=
 =?utf-8?B?VHZhUG0vVTUrYW40ZzRCNi9EQXBCdVNKd2ZVN29YZVE3RDgwUlc3WklmOWcz?=
 =?utf-8?B?QTdHc0FQR0pGVnlIWWxkSjNkNUIyR0pEN3dGaEM0eU1FQjNVOHNSVEpYVzFR?=
 =?utf-8?B?NjdFZU9Ld1ByMjBuUE5NdDNpSjdhNGpBL3dYZE1nT0M3S2phZTlNNmJScEl2?=
 =?utf-8?B?aFpFc0pFaDNHRUNYVzE1T3ZjdytkOTFtdW9xTzQwdFpNaktCUURyZkhnNXZF?=
 =?utf-8?B?UE9zaTA0TlFSUHpVTVZtMDNKUUdpN3V3ZzhaOWZydTBzM3hqd1ZjM1AyY0Zk?=
 =?utf-8?B?dmhBLzZtSVpQS3M5dVNJUEl1M1IwQkxJY2haVHZZZVlFQWNuQ1NubUlEYngx?=
 =?utf-8?B?M2kyK0FHNHJUQXZJZXVtcCs5OVcxaEt6NXREMnFrN0NDMnlsL2VhNGovU2Q2?=
 =?utf-8?B?ZjNBc0ZXcldQTnpYeVNHWDg1YXR0ZTU5a3BBMk1EOExqbWpkL1RLRlNDajR4?=
 =?utf-8?B?WkI3bTZabU8xQkptL2J6YVZFYlhWZUtnNUN5RzYvNURxdlRFK1VvajdGRUd3?=
 =?utf-8?B?UndpemljVUxqVCtZZGNXQlZwZDNyOXpzNnYxV0grQ0Z0L1I0WmZKTWVucThx?=
 =?utf-8?B?RkJHVkZiMHBacll6UnVUT21LUzBnSmxUYnhpSnpPOUE2QnZTVmYvdWp3VnZL?=
 =?utf-8?B?Q2hXNUJTNk9DcHIrZnRIM0NTcm1VMUxmNWNCZzlsR1RzRkx4SlQ4MFVudkxi?=
 =?utf-8?B?d3lUWU1mckhnVFFxS1RLdFJDNm5MdEUxR0JLbEVVVXhXWVphdHdXeXFzWGZW?=
 =?utf-8?B?N0RqQnZ3d0R2S0Robk9ob016WkM4T0ZEbCtnZWlDSlRRYmhHaVRrVElZYUNP?=
 =?utf-8?B?bHFnckVMVk1DemFCQllmZFN3NW80UFZLZGYyZDllUjhONXBYajVPaWY5dXNO?=
 =?utf-8?B?Zll4QW9oV28rYmZxSThnM0RUa2QvTm1DVTlMNitqQ093dWpibVZoa01TRTN1?=
 =?utf-8?B?d1BZUmpPaG9LNStmU2ZqUjRMaGdVUDdUZkxXVkF3K2wvYlZzMU5LSUlSUDVu?=
 =?utf-8?B?Vk52MHJieW1QYlpzYkJSZGVIei9qSUpXVmZ6dHZicTBzeno0TnFDTE4zNzhI?=
 =?utf-8?B?Qk1lWDUxdXVEbVB6NitjcVk2R21PdXpXMkloODl6ekE1VStsTjlETzNCY2l3?=
 =?utf-8?B?MWt5R1VucVp0V3poaXd3b1Q1cDI3emYvZ08wdlFZZXlsWUdrMjk3bGowVmM4?=
 =?utf-8?B?MmFiOVJFMDZvMFhZL0FLUElOa1dYSDZnRW0vTWliWURJL2RrNXZ1YmNzcUhv?=
 =?utf-8?B?RzcwUHJrb2RjOW94YWpnZnE1cm1DVG50VVVNVEM2ZEtyMklEaEFoSCtmTjlN?=
 =?utf-8?B?a3pCL2Q2L0RyUmtYWmF5eEw0MmJubEZGQmNtb0Y2ZVhIYnUzOStaVjIrdCto?=
 =?utf-8?B?MkNIamxOOWJ4VWtJdnhTS2RhYlF2aEhKU2dlVVJkeXRySmcrakV6OXYveHF3?=
 =?utf-8?B?NFpPWU5iMnJ0bmJweEIxU2tQdWtkMUxOWHNOWlJkS3ZXWlVpN0JjTVFNczBR?=
 =?utf-8?B?bUVIVThQUlIvZG1TazBOYXExZ0tvMXFEdmsyWXhDRzlKbW4vNDVYOHJlTVdT?=
 =?utf-8?B?SElRVnVkcHh0NjdZUHpYYlhKbDRYcVFmenBYZDc2bnVwaGwxc0M5UmcrcmJx?=
 =?utf-8?B?TUQ2aEQwcWMxeHR1QVI4ZndmSWM5dkRNM3I1ZDNXZTRyMzVZVEdocHU4RTlo?=
 =?utf-8?B?MWRQNW5jeXJtM0RNRkxUdVROSFNNd3duTFRuRkFaWDl4RWxkcHp6T3phWW1U?=
 =?utf-8?B?Q0JPSFl1M1pLaGsrV1MxVWpJeW5LeHFwMkF3cjVuTk1iWGdQdGw1SjlTay9V?=
 =?utf-8?B?ckNtVWpzaWdaTkEvd2xWTXJaWXJ5bkZWQjhRNERpYWxJdVVoNUttNlF3LzBK?=
 =?utf-8?B?ajJBT3JwODJrUVlJR3V1YThIKzI1WlVkOEVQMmhEYzEvWG8yd0phM00yTkVZ?=
 =?utf-8?B?OFR5UjAzY2N0c0VFYWxxeDlzekljY29VUjl1YTE1NVd5S0VVZHNKUUxSVGU2?=
 =?utf-8?B?cmFEc0FMUTlxU2Iwa0t5WTI0UmtXbWJWQno5RW83UzhWblBDQ0ZCa1JkLzZy?=
 =?utf-8?B?Q0krenZxQjA4S1kvZFljZjRyRjFrUllDWUE2WlUxRXRFeEdCQnpDdi9yeUo3?=
 =?utf-8?B?Mnhma2lkdTVhY0hBSStyb0YvL2lwamkvSnJlbFV5YkkybVF4WFhhVEJhdUJZ?=
 =?utf-8?B?MXFIK0ZzUXVxNnJUSTdzKzk4L0VDSHFxSXplYmlidEV3aVFDd1dkWG1pcG5Z?=
 =?utf-8?B?bTdCMVRFZDdobnlCbUkxeU54cW9VMDlZTGMvRXBrUEprYjNtSGZCTFVBbm9m?=
 =?utf-8?Q?RvIVl/Y74VhDTL+OYRSLyEj4SjENaAf/N+VyDtCaHhisg?=
X-MS-Exchange-AntiSpam-MessageData-1: Yhu6L3e5OuKUBw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d48051d-1dfe-4495-c5fc-08df042c1d1e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 11:12:42.7988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkgPeInDMI8YDr0mHQBnc+FMOOtW+w51AJdWWxz/dh4dswJjzk8nkW6eCcvR1knOzbHiUSHO9kcQCfwocX/gYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799
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

On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>> unfortunate because it disincentivizes using it in interface boundaries=
.
>>> Introduce a macro to make it nicer to use. The macro `cv!` (for constan=
t
>>> value) takes a const integer expression and widens it to i128 (at build
>>> time only) before passing it as a const generic value to a new trait
>>> function `FromConst::from_const`. The trait is implemented by NonZero,
>>> Bounded, and Alignment and lets values of each be constructed from
>>> constants without a verbose turbofish syntax. For example,
>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
>>>=20
>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>
>> This doesn't work in const context, so I don't think this is a great
>> strategy.
>>
>> I would want to use it for cases like this:
>>
>> drivers/android/binder/netlink.rs
>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_REPORT =
as u8;
>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BINDER_A_RE=
PORT_ERROR as c_int;
>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BINDER_A_=
REPORT_CONTEXT as c_int;
>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::BINDER_A=
_REPORT_FROM_PID as c_int;
>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::BINDER_A=
_REPORT_FROM_TID as c_int;
>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BINDER_A_R=
EPORT_TO_PID as c_int;
>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BINDER_A_R=
EPORT_TO_TID as c_int;
>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::BINDER_A=
_REPORT_IS_REPLY as c_int;
>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BINDER_A_RE=
PORT_FLAGS as c_int;
>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDER_A_REP=
ORT_CODE as c_int;
>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::BINDER_=
A_REPORT_DATA_SIZE as c_int;
>
> `const_as!` [1] should do the trick for this, provided you don't need to
> create a const `NonZero`.
>
> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvidi=
a.com/

... but I agree it would be nice to be able to use this in const
context. And there is an overlap with `const_as!` that becomes more
obvious the more I look at it.

In for a penny, in for a pound of macro code as they say. Since we
agreed on using macros, how about unifying both under the same `cv!`
macro, with as many branches as we have types we want to initialize from
a constant value? For instance:

    // Does what `const_as!` currently does under the hood.
    const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BINDER_CMD_R=
EPORT));
    // Calls `NonZero::new().unwrap()` under the hood.
    const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::uapi::NONZ=
ERO_VALUE));
    // Calls `Bounded::new::<{ ...}>()` under the hood.
    const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kernel::uapi::=
SMALL_VALUE));

I.e. we would have one extra matching arm in `cv!` per type it handles
instead of implementing a trait. The syntax of the macro would look more
natural (bye bye `const_as`'s awkward `=3D>`), albeit it would have the
limitations of such a semantic dispatch.

Even the name `const_as!` wasn't really accurate to begin with: what it
really emulates is a const `try_from`, and we even discussed
implementing it in these terms in the future.

I'm sure the idea needs more polishing but I think there's something to
explore here.
