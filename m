Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC9EC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2C510E51C;
	Thu, 13 Aug 2026 20:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="FyjV6vlS";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022101.outbound.protection.outlook.com [52.101.96.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A15310E51C;
 Thu, 13 Aug 2026 20:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuDhNzN+HZC/auUrXiBhEFkBrkCb9v5NsNpJN8YrDE9rEHwYhKYYzxjxg2BfB4zxt/mn7mOxAO8YMUOgNj6bO7nLVAKWOYCobWc06ZfMul7d5bKacjH8zIQzWSnTnwTpO/ZdHxDatcuZS+W3yWbdpMufh78rrS5CavL5W0cZWAMf5JBx8RtOVqHwYOTtritdefDmErMo9FfUDRG02ONvA54dSiQRITgDoXlEyWV2joocqJDS4PRG8fMsT24GoGsU/8z6lcH6Dh4Gq6MDWUKuWWX4KKAAhWNibkwb1O7vpon09e6SQeMx+t+tUsK/el6ag2q/1n7nMY/GMqrOfg2kOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSEd5AmJT5UNbEr/W+5ncpmXrZK5a+KPDyXI5eXseEk=;
 b=Tzwh/MPZZMcJRG+wwYRCwn5jsEYNkHiK39Y0VPzNo7eCik6AoaqRYBgTkVEUzqHcYcXqVj1mya2/YQ6vChn3eCxUJU6XxJ4n23y3sIjr93EAPl1bFyl2uG0ctO5JGwesZNsGeDzkNoYo+GJl4b9bJHuEKLoARfrtuox19KtsLAl7K0MfRpZGWTplCa3SY5qssRmHAPzzgtZec8IZ6mTgPIAE3R5t94sDN9a331sBBM/zJgI1cpjoAQhpsKiZpNii3ym6c4yf6uk1wT3tj+AC+FxErZ9Cd5qwPtcz7Rzwm/GFc2+EvYjXdNUpPNQKLKfnUuVSbj1gGLLQsdG1FHVc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSEd5AmJT5UNbEr/W+5ncpmXrZK5a+KPDyXI5eXseEk=;
 b=FyjV6vlSUuwkw2oqRNnDAmmSjYCcKaYXoc3Ggsbz6GVVn8bBHt8eEKUJBb3d28WHThRWuv+WHc35oGiB3qfl/IfyUbtmgNzCphbb4eDrrf00NTUBkbR0OdKIkQi/gqz3NxVtYT+XEssA2uRtDertZeOu2237PXkeE5+FyFYUYrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO3P265MB2219.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 20:58:43 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 20:58:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 21:58:42 +0100
Message-Id: <DKO48OG9DU2S.16YBDI113DR4@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Yury Norov" <ynorov@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
X-Mailer: aerc 0.21.0
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
In-Reply-To: <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
X-ClientProxiedBy: LO4P123CA0293.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO3P265MB2219:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0b6481-903e-4ac5-0992-08def97da8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|10070799003|4143699003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: GiKeZCMgd/H6LW9Z34fFreQe03A/rrQv1cjRhmTD1TeTUdy+JjPWoGoOnHhhrXwiTPaXcZo1Oq9r6YtCA0U7OtQ0bJqhZtc9Paij6YbXHDRSWnLq2UBSPwHxImqXgKCy/9AhkT2oUvnaJZR7KTtx9p+4sJ3oF1i5jNotm86SMkhYlebq8/dnoovVR+ndIjyrazF/kE/RXrBENzHv1sPFUm5ipkFDe9GPbTWUnPMVM38ji2eeleWI4pOzvDgM+CFcV7f8ROKz5m2MLsuXMocmIWtMXT8PLEPCFUcdb/i3iCWTu+1onOZeS4phn8GmkJXJJ6JVPSUVoNER4oDqQc4WQP/OY/UM4+ZVXpl/bXldzAuSz4c1nNOn2012qr/458dGGVKXfkdtEHLBljPnEpfu2q32wIxdZ+qc6gW7adq/8o8p7EGqJwOeolIpmj2fBglFZ0LaVPyUx6XCl37V4A53kJ3AKM5fitWkBodzNK1ge7SWPCO5kycIQO7LKnGQv5NWUfPa+hpSES/dfcYhbmUbX1WZkI0DbJuq8UedJCYi0fJfghr0XiR3RZ+zU+6aOGGamFYdczwFAg1QhYWHIqFDkBXh57crVmcn72XZyW/91Q+ABvpSN6nYu/Vy7dmeuoGcNjnF8sdrkSREq9ZofvqNTFXTR2CA6tnxvXuntxtRBAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10070799003)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlYTWlxa3BCZTE3RWthYnF3bTY2SUk2aGV0WUtSK2FEM1BtbXAvOFU4dFor?=
 =?utf-8?B?a0V3MjJRWW1BOUYyZmxHTmRiaGdFREpHOFRDQXhNNXUvZGtSN3oySCttYXU3?=
 =?utf-8?B?Zkd4WlFGTmUwTGNxVloycnhRakV1ZURUbWliZi91YnMxMzBKQ2VDM1BXMDh6?=
 =?utf-8?B?NlNQMDdFL29hOUxLcnpVK1p0OVd1amtBWUpCbmdLbkp5UERuWnczS0QwSGVl?=
 =?utf-8?B?YlpnSWppUmdYdTVMUVhoVlNpN1V5UVQ4NS9yTWhHbi96OVNKdHVHYitCOS84?=
 =?utf-8?B?T1NxQmVNS2FFUk1wVS9IemhhWEpWQTI1ZE93THpILzNZdDE4bEpIWm85bERo?=
 =?utf-8?B?ZHI5SmMzb1VLTmxuS0w0UWlGZHpGVE15aUVTZGk2eE94amI2RTFOSXpuWkhY?=
 =?utf-8?B?YVZoa2lRZHZmNHpMT1Z1M0w0MXVsNyt2QlVnLzRRSUY2NkM0QkV2eWpYUjlK?=
 =?utf-8?B?YXduNXoxUDBuODh2V2hzOHJ0ajRvVG5TejVkdW5YMWc1d3JPMEVudU9SZGZ6?=
 =?utf-8?B?KzRJdlBtekw0OFhxZ3hINWpGYUprQ0dMbzBQWXJ2R0dnbmNBN2k1Um0zR0RX?=
 =?utf-8?B?N2JXRE1aTmlLNEVNMkREd3ZmUVVHQ004VWpuNXdzQk05d0JLL0Z1dU4xcEph?=
 =?utf-8?B?ZmhzYlRNUWwzUlZaL1lidWRGT3JzUlh2VlJGTGpmaUduaThORU5ZdCs2c0ZS?=
 =?utf-8?B?ODFBdUlIcWpiQkhicDNsa3NrUlZlNzJWdmJiL3VYMFh4ZnBLWDdPYWQxalZX?=
 =?utf-8?B?dlI5dE03ZUl3RWxHd1NmcWdpcUs4T04yMVZuU014RFByV3IvZ1Z2Q0ZjZDBY?=
 =?utf-8?B?d29CdnBYNVV1ampDdndXVEwrYTZVaGJxbEx0NGZaT2hmTnBFL1ZsSmtmTzJM?=
 =?utf-8?B?WVFRQmdTTUsvdFdRQnpCbEgrK3R3RG15ZkdFREhjd2VkclRZTUx6bzMyZHI3?=
 =?utf-8?B?b01zdFJybXF2QW92akozWmk1d1VUdHljUGhuZGFTOEwrKzN2cFJFTTBSdURh?=
 =?utf-8?B?SDk3ZW5mL2t6TXJ3TXNySUJnZVJlaXREOXhVZE9sOU5LcWhFOG9Gc1R1K0Nu?=
 =?utf-8?B?S04wZEdSK0U3VE95TmprV1lkVU8yWnRCMnVxOGdTbFRsY04rL29ZTHlXd09L?=
 =?utf-8?B?U3IwbGxzaDVrWFpTZXUvTmwxeEFuakY3bmplamYycEk3RDI0UExwYmYwU0dB?=
 =?utf-8?B?UmVHQmtyUXNyc2ViYWMyWU9WUXVuVnZlbk5NUlFJcEZ4a2t1S3BWVUJVVXNn?=
 =?utf-8?B?VFBrVVR1Nkg1Nm1SaGhWZ0l2QUJtOUxjT1Fhd2RPUWE0MXRzNkNZeXdFai9s?=
 =?utf-8?B?UUpQaTNrem1MbHl0TmJKRG1IRGFZWDZMTTlUd054YnBMWkllaEg2Zks3NzA3?=
 =?utf-8?B?ekRDWjJUeXhmdmYxd2MzZjRkSnRXU0sxbGYwalFhcGc3Wlp6UzJyeXFUZElv?=
 =?utf-8?B?cmh1ai9lTDdDbXhQK3Yzd0RaL2dPVmVyNjcrQW1qSGNWRWx5N2pydHFyMVd5?=
 =?utf-8?B?cjhRRUR1OW82UjRyZ0ZVZXdUWGt4M09lYXJNSllMeTRTL0NJUWd3c25mQjFP?=
 =?utf-8?B?dDlWUXp5cGdoWlVjWXpYaFBnWDhCMHdqekh2bUFLMmZvL3dTY203ajNVRFVM?=
 =?utf-8?B?UUhRSGcwUFhhWnp2QWQ5OEQ4L0hPdkhYSFRIK0RNWGEyZFFScUx2dlhVVWNz?=
 =?utf-8?B?R2xkZUs1ZzNLWlJoYXpmTmlQYURzLzFxRitpbEdlV3JvV0VyTEF3QlltUm96?=
 =?utf-8?B?clR6aDFIOVBQU3VBSTRqY0FSTGM4cUxEZ2o4MDc4TkJYTjFUNWFGSDJIUHdT?=
 =?utf-8?B?OUE4QzUveitWTERycUw1MUlKRmRNMEdSNm5DME9zdTdEQ0NVaGs2UnZQNjBZ?=
 =?utf-8?B?dkk2NEl5eGhzMjZwZmhhcUVaUnIxY050em8vNHhkemJ2WVY3U3NxbFNNU21x?=
 =?utf-8?B?RWxPU09CalJDemFOVnp2QldYYjN0TmlBY0VOWCtWRWJ1Zm1vUTRzaTNOUlR1?=
 =?utf-8?B?RWMxdHMycFQ3Q1F4RUErdE5aUkFVVVZyT3JLdityNS9PUHRsekUrSk5Rc2I3?=
 =?utf-8?B?aHJWUHhGeUtFMTNkR3hLQzh6QlFUUVdJcFJUUEc2ZkgvRlJlQ3ozaVc2Sy90?=
 =?utf-8?B?ejVoL1ZBemx0WkRMMWxEVGtqRnRvemlsMGhaY2hJTEdtTkxJQWpmTDZNNFo0?=
 =?utf-8?B?VTF0V2dDQ3Nhd0d0OGJlSlhjbXVKbXNISVhHWXZlV2JaMjBrN1JUTzI5RFk4?=
 =?utf-8?B?YW0yd0kzWFNUZjFyV3dvRXI4aUIzbElYQWIrV2d0UG1Ba29nQkdoc0tIeTIv?=
 =?utf-8?B?Yjc3L00vbEljanhBaG0xK1B4ZmxEOGRyK0J0WG1kOWZJWnBYRGVWUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0b6481-903e-4ac5-0992-08def97da8bd
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 20:58:43.1202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDuwQkPioOEDllAv0pm4QMdYXOKWb+2xUvsCE6kvaizbD7Lresd+pjeVX8MHcOAqx2FcjkXB/BXqvyZGVrxtwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2219
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

On Thu Aug 13, 2026 at 9:48 PM BST, Danilo Krummrich wrote:
> On Thu Aug 13, 2026 at 8:32 PM CEST, Yury Norov wrote:
>>   pub(crate) fn alloc_area(
>>       &self,
>>       count: usize,
>>       align: usize,
>>   ) -> Result<ChannelIdArea<'_>> {
>>       let count =3D NonZero::new(count).ok_or(EINVAL)?;
>>       let align =3D Alignment::new_checked(align).ok_or(EINVAL)?;
>>
>>       let mut ids =3D self.inner.lock();
>>       let area =3D ids.find_unused_area(0, count, align).ok_or(ENOSPC)?;
>>
>>       // If the pool is small, the backing bitmap may be rounded up to a=
 larger size.
>>       if area.range().end > self.num_chids {
>>           return Err(ENOSPC);
>>       }
>>
>>       Ok(ChannelIdArea {
>>           pool: self,
>>           range: area.acquire(),
>>       })
>>   }
>>  =20
>>   let area =3D pool.alloc_area(8, 4)?;
>>
>> See the difference? You still check the parameters, but don't make it
>> the part of interface.
>
> Miguel already replied to this, so just briefly adding to this.
>
> We usually want the arguments to already carry the invariants we require.=
 If we
> make the arguments unconstrained, we may end up in situations where we al=
ready
> have types that provide certain guarantees about value constraints and ye=
t we
> have to give up on them because the API takes unconstrained arguments and
> revalidates.
>
> The code from Eliot does actually already takes advantage of this. In
>
> 	pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;

I have to say this looks quite ugly, compared to just `.alloc_area(8, 8)`. =
In
this case I'd go with something aesthetically better...

While keeping invariants with types is generally good, for primitives I'm n=
ever
a big fan of `NonZero` and `Bounded`... The turbofishes are just ugly and t=
hey
are must harder to use compared to raw primitives without typing a lot of
symbols.

Best,
Gary

>
> both arguments are already validated at compile time, whereas with uncons=
trained
> arguments we're left with a runtime check.
>
> Yes, nz() does not actually validate it statically, but it easily could (=
and
> probably should).


