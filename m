Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E951C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 13:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6C110E068;
	Sun, 20 Sep 2026 13:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="rI28Q8d4";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021125.outbound.protection.outlook.com [52.101.100.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9346C10E068
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 13:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIvXVl/sem216gK7wp/bxKR9HNZRN3zssVW0/7nWoj0BxiNktsH2LbcCV8CSC75Xyc0gqEE1FomCwq4kzrvvnxN92CcgCnFiWGeqjLzoiFEKOmVIyXNgFPap/WiZ5+2MHulsN5xz9oP+MVEITxeOURX9PjciE6E2Cec0mnBy2LjkeyYJB4NDe5iZf78Qt1ZlYAvoUGvRmRADINcfX43Xd1dEFK5VnbvRQLn3raOuvEOMekiCx6603GkfGwMnNz6OYhPQN5gZu+t4USNWdQel7e10CBpRftWjZP+1Sq0j647V70RmuakNJcFAJPphssyrGfk9w95OvgYl4VGugVbaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viqJ4MxOJ9y9JGwM6+qrbujBSNGRtp4C9GhxBdEMOw4=;
 b=kidAIYaJdGnTb1aqZzeGRVWOijJddJvhMsgFScDPfsKyWgINvXOLI8NRbR6EQcjiOglRyTBv7hLBZ27UpmeYxsd7hy8Ih7d99o90kp64fuLpymMQISVGnFCS8wu9O3HCIuXufCNfUcXA/c0FeySyCxqeMJReFn4np+xvEzroH7tARyY7/fcQJWavyiDzjFKS5kcSxw4DyHjihTSFsKHK79INlKphpAL1ANB2HzB9NNgxemf1vZb8TdbRawFCzUqaD3cR6Egae6LC6xw41MkfFTvA8D39S+67FJLSovkq0dJlJoTgPLp8els5pWayWmIdI2bmS3I4bToSup1zXGL25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viqJ4MxOJ9y9JGwM6+qrbujBSNGRtp4C9GhxBdEMOw4=;
 b=rI28Q8d4knSnp7Qr0QGUaJIJscdsHsPfQvrQTLe9ellFLDbpFX0QCCxDAJdLQFruw5N4W4zWX8JNy7OAMbqbszqDSbyRGP1w5WEjwbHK7hxdGaEkwDoMG3VvqjMlPcd5ClxI1Zs8QXXEb9kQpXqyxi2wfjhESpMkmunjUm4Shu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO0P265MB6291.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 13:50:28 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 13:50:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 14:50:27 +0100
Message-Id: <DLK6XHP5NIN4.37W548MAWYF67@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
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
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
 <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
 <DLHGQN9VQ3TE.JYI851RVF7VD@garyguo.net>
 <DLIN1ZH244ZA.3JVCE0YKWAQ6B@nvidia.com>
 <DLK50D524P11.3CZN924YW8HHQ@garyguo.net>
 <DLK5E4VWQNU7.1K3YYYCZO2WRY@kernel.org>
In-Reply-To: <DLK5E4VWQNU7.1K3YYYCZO2WRY@kernel.org>
X-ClientProxiedBy: LO4P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::20) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO0P265MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 925215e3-64a5-432c-3e02-08df171e2130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|10070799003|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +qn7qPuMdO+EQ53Kue1aDIMFw8OJgXTyPjLfy7RWfIannxie1pkgVCm51UNvAVv+J7gZyZRaVh8Nmdkyv1i9QtZGdSQDzoe4lTu6Z3Olyl+J1gXtJIH0p6MK9pkhhWne6XM9pXhClzxaE9kv17wcQyiYu9YAME0NtzB4VkJALfChLW27XrBliDwggxz+FpC8rv5YtrFg9Mo4U4w3idDJCcu8mp1HpqEECK9r90DApKg3JCsIHLpj2K4rBqvNPVnPzevDpaYcfUlzi+o2CzlOfcq+sfAQxod1n5QkIXKNANTn5eQsIoTc9xtwxUbo0UFsFK8jCLmOTHdE1atRjqqKtriDE6BG3uX+kiLLb2n/4QhwCRAQkuqDc20nlKeWoNtfhErL82O+cYk0qNg9IZUDENECUlCAxKcqAmX2+jblQ8WsBFFxrcbpG9cIamct/HcKkOKf0lsLi2+NFy+sPAcICKfyvl/5xjDZk4ryx3WQyt+Hs6P33mlxMUnbhKM/HTah6oVfrKUOw3jW33y3Oxx/A7g1kM1wz8jRdIoQeIhtz1SO/3W2GohlwxpBfVz4QoWc+rRpeJ2FrbRKDPniiXp2NKAk3LzzN1vHhw4+1Mjukj2ZrDe6YUUpL2rFyypAUxyB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10070799003)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVJwMWZEMUErVjBxUnJ4bjEzaUJRV0dqTy9DUVFzb2VvQ1ZIS2hsS0dTY1pz?=
 =?utf-8?B?N2tONG9BUXRHaEJlTm02NFozMkRqbmFiOUZObGtucGpIMG5tVm5sS1dMV0pm?=
 =?utf-8?B?MDNjTXlMMG9kb0M1M1JDeUpEZHlBQk9NOUJyUVd3Q2YwMUcreVNIYnFFL2lm?=
 =?utf-8?B?dkJ2bXFEUFlFMmtNejhyekxoNDNUNlViR3pxZFhCc0djL1hoYjNQWUl4WHNJ?=
 =?utf-8?B?TFNSR1NONVpXZUlWM2ZRZThUeE5hVDhiSkQ3YktyOFZDNnMvMllvSlo4OUNS?=
 =?utf-8?B?dmZSNTFIdUNHUFZNLzRVUEU0L3lMdlh4WGg5NThmM09ZVGdXUU9ORnYySjZ2?=
 =?utf-8?B?dWUxdGpidmVZOG5sNzBGb3BkWFpHNGxmMFdPQWlOSXBiUHNQK0IvQkNNelNJ?=
 =?utf-8?B?OUdGdGYvTWpteHJoS2ZJLzdoaEFwekJWWU5vay9Oa0NRT2R5WU9IR1hHZXli?=
 =?utf-8?B?M1YxRVYwenBDVm9Uams2c1J3K2JZbW1veDd4aWNhZ1pjUGFPclJSVVRnMDkr?=
 =?utf-8?B?T1Z4M2ZxeUVGOTNOTzhLTzBJdVN6bEdXODVkYUJWczdlRkI2R0gzS0lGVE1S?=
 =?utf-8?B?bU9SU1N3QzlRQ3ZHWFl5QnptME5uSEozeWMxbTBjLzRvZm9jRzVrWkR4NUN0?=
 =?utf-8?B?eGpWWmkwWHdYRnpkOVRETzA1MERZMi9Kd2h0Q3Vqa2RyUzIrVHltem0rNW1S?=
 =?utf-8?B?U01GckEzRnJFdElCT1FFdnJURUFYWmVXeklOUzNaMVJzcGFNQnZjNXNybEpq?=
 =?utf-8?B?MDFCQVBaTlEzWHlZZ2U1YTZYWGZxZC9RVW5pVURSYWpwYXdESFNaY3ZrcHRt?=
 =?utf-8?B?TkR1LzRpbFNvMzh1QVBEdC9sR3JMRVJzL1ViV0JjMkFkWmdJZ3h5RWNnMDZH?=
 =?utf-8?B?S2FUWWRHQjRhRnNpclZ2cU81dGE1UjBhdzBvaVN4QkZ6VUtNdEJUNnlLUi93?=
 =?utf-8?B?cWNBREtjU2JaWmt6VUZIQy9ZU09tclJsMkUxTElxNktHWndNQjNobzN1SVRT?=
 =?utf-8?B?U2pjZUdkL3Y5cTNJVDR0NVRVWThVU25RY1ptMDhSc0d2eHQ0WnpnLzRoQnpv?=
 =?utf-8?B?WXZoaldpQlM1R1N0cGNzekhxT29rejJKdS9nZEJWZHVsVlRlZmRscHJMbXU3?=
 =?utf-8?B?WVcwWUxyV2d0YWJOMCtkaldaVEZZb1FEQWt1ZndkcHNhK2lZOElLOFdCQURS?=
 =?utf-8?B?SWF5TlNrYUxtOU1tUUt6cm5FNVp4dCtmcUlNNDUwT0wyNUJKMFRhRnZqTWhY?=
 =?utf-8?B?dkNyWVBWV2FIdW0xVCtrMDRFblgvZkZab3NiOU05RE9lR2lnOFpzYkhSQmha?=
 =?utf-8?B?M2NoR2lqQ1loK3Z0MnNDc21lK05oZ1k0am0xWlpHSzVlSUoxL0FpU1ByUU00?=
 =?utf-8?B?MnF5RGlrOTFOSlhobVA2QVhUck9yZWcvZVV1VVlLYzNTZUNPMGRtMGZPZ29n?=
 =?utf-8?B?ZkhsT0dPUitMSWhNSzBpbDBtUXdYYmM0MDdraU9CKzU0RG14L29SUGd5UFNv?=
 =?utf-8?B?WXJWbkpzcEw1ZE91QnhYNHZ6OXA4QVYvUFNaRTBuL2kySGJkQ25ucU1NWWRQ?=
 =?utf-8?B?cVJlUE1ERFY3NHFOUDhTalRSVDBSZzRsQ281aXM1UzRlUVNUMlQyd2J5dm0v?=
 =?utf-8?B?VlJocjdWdGtFV1VpZVhwSjc4a3JGOUtYZnRudW8xUUd6dE51Smx4U1k2VXVU?=
 =?utf-8?B?MEVtM0VVVlVxRk1rMzJMdzhyK3NxZ21mMmJzREh0N0JBQ0NWWHlJUFpEWlJm?=
 =?utf-8?B?TjhodENhT1ljNFB6Y2Vad0NzN29WZkFiYXNocWcxSXQxZ2oyUFRGTWFDWXVS?=
 =?utf-8?B?K0ppd2RUME1RUzRHY1pWdGZFWEhXUUxwNjE5MTdYM2cxUk9NU0NMY212Tkpm?=
 =?utf-8?B?SEtYdGFlRnhmcXFhWXpQWldMdzFrNUJCRGxsTGdJbUZyc2F2ZDdpZWtCNnFi?=
 =?utf-8?B?U2pkRUxvVnNGNTRaWXBIYjYxV1FsSm9lUXlOcEtjdUtHSlByUDA3TjBLRFdS?=
 =?utf-8?B?bWQzWWxLallOWXY5WjJ3d2dGdkk5UHl6VDU0ZkJJNFAzeEhvbUNIWlQwbmFI?=
 =?utf-8?B?NVljTXBWay8rcDBYQi9rNEkxbXZodzRFM3Jka0NZdzVRWndnU21tdDBySTZI?=
 =?utf-8?B?NW5OL1NqWjE5ZjNxcEFjaFFhN1dKcDlRdTcrNGN1WWdaNU5qVkkvNld3VHVw?=
 =?utf-8?B?SDh1WllVc2ZNS2Z2Z05mQ283OTRPdDEyNFlDUVpxa0FITlBuQ1ZXYjRPRUNy?=
 =?utf-8?B?akRWMkU0RW84QWdYTGFvaUtoRjN2clFPVXkyWWJjUVBHK1BXeXh0VHhRY2xo?=
 =?utf-8?B?bSt0RjVTbGtaR2p2VnhHdUNCdEd4SFBPS3JvQ1REaVEvT2ExRGxTZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 925215e3-64a5-432c-3e02-08df171e2130
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 13:50:28.4155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4SA8ay99k3rQkg6s5H9XRnY1yvl/5Q7MP0dG8s55ov1y1DryZ0qYwWVQjkAYmB+S3+g2jLpNoY6ZHGm+aO9nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6291
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

On Sun Sep 20, 2026 at 1:38 PM BST, Danilo Krummrich wrote:
> On Sun Sep 20, 2026 at 2:20 PM CEST, Gary Guo wrote:
>> On Fri Sep 18, 2026 at 7:03 PM BST, Alexandre Courbot wrote:
>>> On Thu Sep 17, 2026 at 9:53 AM BST, Gary Guo wrote:
>>>> On Tue Sep 15, 2026 at 8:39 AM BST, Alexandre Courbot wrote:
>>>>> On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
>>>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>>>>> unfortunate because it disincentivizes using it in interface boundar=
ies.
>>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for cons=
tant
>>>>>> value) takes a const integer expression and widens it to i128 (at bu=
ild
>>>>>> time only) before passing it as a const generic value to a new trait
>>>>>> `FromConst`. The value is then converted and appears in the
>>>>>> associated constant `FromConst::VALUE`. The trait is implemented by
>>>>>> NonZero, Bounded, and Alignment and lets values of each be construct=
ed
>>>>>> from constants without a verbose turbofish syntax.
>>>>>> For example, `const { NonZero::new(1).unwrap() }` can be written as
>>>>>> `cv!(1)`.
>>>>>>
>>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>>
>>>>> I don't think we have any user but nova-core at the moment, and it
>>>>> benefits from this in several series (patch 3 here, but also ID pool =
and
>>>>> later r000). Miguel, is this ok if we take it (i.e. the next revision=
)
>>>>> through drm-rust-next?
>>>>
>>>> How about a topic tag shared between Rust and drm-rust-next? We could =
also
>>>> remove the old num casts API as part of topic tag and fix all existing=
 users as
>>>> part of merge.
>>>
>>> Not opposed to the idea but IIRC there was already some pushback to the
>>> idea. There doesn't seem to be an urgency to remove the old num casts
>>> API that justifies doing it now with a more complicated merge path.=20
>>
>> Sorry, what pushbacks? I thought that `cv!` is what everyone agrees on. =
I see no
>> downside of this compared to the turbofish const conversion APIs.
>>
>> I am not opposed to delaying removal for the next cycle, but IMO the `cv=
!` macro
>> should be present on Rust tree so it's visible and improvements can be m=
ade from
>> there, so I think we should do a topic tag regardless whether the old AP=
I
>> removal happens or not.
>
> I think Alex refers to this thread [1]; there's was some more context to =
this
> though.

Right, so "pushback" here relates to the logistics of old API removal, not =
the
idea of `cv!`?

Best,
Gary

>
> [1] https://lore.kernel.org/all/DL0KDAXUZOXD.I8FBZZ51EIIF@kernel.org/


