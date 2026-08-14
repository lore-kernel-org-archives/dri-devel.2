Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C64C5DF66
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F029110E1B8;
	Fri, 14 Aug 2026 02:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QrsdSZmE";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A335B10E0BC;
 Fri, 14 Aug 2026 02:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9CQZnFGcl+CQAD2klIJ/opZcCoi3G88KfFlmrj8/nIhXoTJHIWKGkhiJfRgfrJR76LZnzU8ZnDCtoCUUpOK8UTvWctaU2JjsXcgvxXOQLUjkh73oeYSUvQIM1zf4HCAm7fFwxC7fBNOb8pB4Ab6ML5bK1fchpPlZicEGPN/ZwwgyF1772QSu9Sb5qsPZH9oTW+Bdq0Xksw89mimALLlJfoveYxd4If//aQfjwlX2CWqh6nEv50EgMZPo8xiEnffIJp0P5qhlm3w45a8JE+NPYBwR3pudWt4K7p+aIHprtbaNhxDERHiyT/C1G0MxxoH+3QCxfwfEE40eBuO2I9wtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhUhkbY9qYsrUtND8GPd4yGaujQ0blEMKU2qjEDksfM=;
 b=b3gHFY5JKkXzq9v+aijz10OSHRfY6YIcmfQJQY4gW2mUvZa3peHmDT8jR1rV1JOrrTgpYw4HH4KHyelrvLEWPx3xR7oDovFg8BXZpvMmmuGsqM9TMSxu+V19yNvZl4X1iKC4XnnIE+GCUYa/H8FznLnuZNL8hJfVsThjlSBBEbSs9rF0i8Ux5+nThpMqsFjfd/HKpApfj3N2vTHrAxw3CPHVO1eSrjKOOC4bVNWHVgqM86K+STYtNoPzlUksh8pF0iLTMS8y+ihqUVuWa4onokNhZFLBYzEfJTjbc7day4CvAv0g42D/sEGQFZ1CxNwxoaYp0wUjk5ZhPxC8zr6gGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhUhkbY9qYsrUtND8GPd4yGaujQ0blEMKU2qjEDksfM=;
 b=QrsdSZmE7nesrEqwiBMkFuBVxnPSBZk8Byf9amfRiYSTOG2tDa4qGsCf3UiZETwVjaFr3c62x2vDkvrl37LhAPFkZfPWQ8L7Fq9f3/MhLzASwLCctyqPAtdLu3YtNF11lVxJpNUK8jMkX1Gb/lJSSAExuRZ/jJ41QEobgYmP0c4+DTnPRnCkk0naxOjV6W4CAloxv/VYY3+NYZz8+S3BIXGFKg+YRkDf4/KO43pR4lN8kZCEOpD2iC8SGO1834oOw67ek9E/5Xd247Jb8RtJBISsF9lfZTGYr/f006dJjOndcr3HJ9+TRAfqgLgP5fyxJsKp3O1cJwGm/8BF3EypUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 02:14:13 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 02:14:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 11:14:09 +0900
Message-Id: <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
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
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
In-Reply-To: <an4xDp29VX8Am0uR@yury>
X-ClientProxiedBy: TYCP286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a5b28e-ea7a-4ab3-619d-08def9a9bc02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|23010399003|22082099003|18002099003|11063799006|3023799007|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: V94MfIiIMcqwEKjCsqERhcC78TF+4skxuRQ8cZ/FuXpRABbMO/r6q+9U9nIz7ba4Zbn4MmTlTVQvDAtrQZTGa53swGTHmTyj8vxSaJxff8gAyHsO9hGQKUZdlRb8RlCS/GXVJ40GQldP/Faz/7HCEmuM7jp7cLioEVVeF63vwja7gXf5JZTSa8xecox85CiA5bonIJFnrd/zFpSC6I1na4a4Lzs/TUgLTk03XaUVaupU02YN00OOGTUmmssUV6+Q8iTWcVlAp8K8FSoNu2ssufchezxKzuPKnHpdWZ9rsWMnvKU579vR/zaaSuuwfc/6HlpsfTfnDTvhn19yzA1okNTeZqlgCSCAoIbA57PYirsNeE9aukI5MDzZUX2L0KqUYIGFZNCtvlZue+KQ61XJ/MeMMaPRt0XKMwYNy4LPjd4nXyPgv5Lpyu+O3U5eTqtM93b83r4WB7Cyx8ErU4qr4IfEqvXwzghIAj1SilM/Yg2VZUaUsemvk3ns4rav8jiT9Htk78C/xd57QMx4x/mgzj+3ZopDM1iFpsanixi0XgERyyxH45Z4c+v/88Ujr11yrmeWnKdfL4Wc7KXGtUVtdlt3EDfBEtwd182EywI1Qa7G3ytvL1SB3JCdnLZdD48LBRbFTYrvSY5oARCtHZFoKGYlmoH65ARgwJSO0RnKZI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(3023799007)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZLZjR3cDVpK1FPdFVXclJHZnhvYzI2U01qM0lRREtFN3hPM1RTd2hVQzBP?=
 =?utf-8?B?ZnMyTENHbWNVNldvcUp3b2dyV0JQZTdvQkdTTXRCNUowQUpreTEwVURlZVd1?=
 =?utf-8?B?WVZEWmFJVUxJYUhOS3d2RStKYk5xeGpLNDZlZExFc3dnSGRFSEZjUUV2VmNJ?=
 =?utf-8?B?dDQ1djRvY2ZsQk56T0lsM0thaTRwcEVwVENhRW8yTjFXUFVWTnlQWjBGdW92?=
 =?utf-8?B?Y3IrdjVDaWl4WVZLdGptT3lvNnczb0NvTlRsc2Qrc0FKUmxZV3k3d2dsZy9n?=
 =?utf-8?B?QmozM3FIMlBEOUNuS2wrSFlFZy9EOUdhYUFwWFpWbkVPTWNaQ0lsMmh2MU1V?=
 =?utf-8?B?blJPZk5GMTN1aXpTQzc2SVpoQWNNeDcvSFhMVzl3eEUxZ2UzWXNwVDBrb0VK?=
 =?utf-8?B?alpSci9ocjBDdTBPVU9XWGZlWCt0UDZsTGVySXE2d2YveTBqMkl3VXZnQWNm?=
 =?utf-8?B?cUlhV0QwSGVrRU5XVUx1UXlJWVVoZmZ3cGtoL09ta2tlSHppRmgxbkdOeW0y?=
 =?utf-8?B?MVg5REN5Uk1jZzlGTnltVVZyc1RLZzcrakpqd01sYzkrMklYQWF3T1BDZGpi?=
 =?utf-8?B?UGw5bFBadllZcUFxL05EREl4VTdUMkdVaVROOGhpTVBHajRKMG1XTzZEREhl?=
 =?utf-8?B?eHhRN01GZFVlMXdSZ0h1YUpMVm9YZ3Q5VEI0bktvcTZOcmNNd09pU2IydkZ3?=
 =?utf-8?B?a1Brd0d2RVNROHBYeTZldUYvNDhsTlMyU0kzblBydk9tMWY2RE1tT3JrSitF?=
 =?utf-8?B?VzlhbUhjMkhmSGxQTXROOHpIUWRrUkYycUV5alpURk04Yy9OTUExUXJOcU1w?=
 =?utf-8?B?UmZEeE0vTUo5ejZrQnA5cndWRnFSYVI4YXpLV1pzcCt1L1dMditLTDEzc0l4?=
 =?utf-8?B?czYyYk03NTBFZnFad25ZbFRJa285VjlIMWFuWFlRL09iazg4Y1czc3VEQWF2?=
 =?utf-8?B?WlU4NWcxRnVGM0JpRmZGcWVFZ2dzaXR2VVlTdmtMb2pIbHppVWwzVy83YnhH?=
 =?utf-8?B?blF6cExwaHRFOC84KzlaU2FWMW1GQ1V5Uk4yaGhRK1Z6eE5paUNlVEEwNXVx?=
 =?utf-8?B?VWtDYnNQTk1xVGdFTm9UTk5QM3hSL1AvS3c0VW5uRzgzS0FFRVZ6Uzc5Sy9G?=
 =?utf-8?B?N0hBdEwyYWFKNzFUbWs2b08rTlloWHpHS0VXSFAyeW1PTHM2SFFic1N3ZUJ3?=
 =?utf-8?B?Sks3amIyRzVMdjZwS1RzcmJXR2NySC9TZTBaY2ZzQjJUaUlXcXdNSzlxdU1n?=
 =?utf-8?B?MkpvY1lOR0YybjB2a0tVallpRkM2L0dXZTEyL3JlWnF1cGVjTE9LRmJTRTh0?=
 =?utf-8?B?bWRFUHRuTkJyWk1GallGUXdNaVJ0TU5kSUZHYi9Qd3RCcytNZDd6QldyMTd2?=
 =?utf-8?B?MzZrcEZxT3dhWXZTd3RKMVJkS0NwNTlWYlNHQzM2Qm1TZFB3Vml6UjU4THRR?=
 =?utf-8?B?M2oveWJNOWlVOHlXZUZNRUFLK05nYUNqb0dpeVN4YVhzamFQalBiaERRVk9E?=
 =?utf-8?B?VXJOWHVhMDArampTZmEyQmFXakRHeHUrbHNqOHMzL3ZiUElKZC9YV3FwZ3Ro?=
 =?utf-8?B?dUF5QVpHUVJ5TmpJYTBkM2J4ZFU3SXVHdU1HMXowa0lRSVI2dlMxMWtqaitw?=
 =?utf-8?B?blF5NlFvOThYSDlaTGhHOEJmMXFGd05lWjQxcXdhdUJsNGtXZkdrWWNuWGxG?=
 =?utf-8?B?aERFRFFvRlBPK29oRkdZbzJUZmh2TEI2VE82MHhjbWdoYmhLaG41c2NlTHVw?=
 =?utf-8?B?bmhvWW52MkZzU1N6QXJpak9MYnhNM3F0UDZVRk9JOXJ0VGtzZUZoSkZINGpm?=
 =?utf-8?B?YTFRSnlpU0dHUmQ0SmwvYWJkUUVmUnJIL1BZcUx3cy83VGZKdTduOVhXVk4x?=
 =?utf-8?B?UWZuZS9iMktmemVuYUozd3NmV0diS0p3OEw4TVJDMjBpUGVkZ3VKbk53bHZa?=
 =?utf-8?B?TGFRTEI0RHpFUDhGWTJQRVpRczRubm9Vc3dDWUhWdXlZK2pLSmZUVDh6aGxJ?=
 =?utf-8?B?OENEc2xXWjhSZTlHWTg0OS9BRXhBWE56T2EzZlFuL09EaXpGOGw0NjgyWC96?=
 =?utf-8?B?TGVXWUdsL3pHeWM4dWdMbDZFdktxZUVhT3V1SkdIbFdSV0tRL0tPb3ROL3RX?=
 =?utf-8?B?dFA3NWVjcDNXQVZWWkVaM25IaTMxNjYweE42UFBQOTN0V0YyRkN1bHY0VEt6?=
 =?utf-8?B?MWlpMW5IU3BvSVZvWC9sRWZkWEdkKzlzRkdmOENoVzFic2VQclhWQzUxRDN4?=
 =?utf-8?B?UEI1Skk2QzNDQVBQT3ZFTDFpb1M2WGZWWXNuUVhyUW10cG5IZVJuTHh6M05Y?=
 =?utf-8?B?a2JjM0xrS2NkWG12ZUFqd1k0WVB0RHFoZ0xFU2pvQ0tjZVJYaUFRZytNYkVV?=
 =?utf-8?Q?ON3zWFOkDOPZgZBffU48za67vb6YGJ1t6EBaFZVisJ5Od?=
X-MS-Exchange-AntiSpam-MessageData-1: jiLswT2v/YKHMQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a5b28e-ea7a-4ab3-619d-08def9a9bc02
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 02:14:13.3817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eY2fKecrcip7iWzUDLqhYXBbUKqz34IICzcq6Q47jiE6/P7tqvFhfi7GtCdbBCWnBd/wSXYJoIOCxJ0d6oHnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

On Fri Aug 14, 2026 at 6:03 AM JST, Yury Norov wrote:
> On Thu, Aug 13, 2026 at 10:48:50PM +0200, Danilo Krummrich wrote:
>> On Thu Aug 13, 2026 at 8:32 PM CEST, Yury Norov wrote:
>> >   pub(crate) fn alloc_area(
>> >       &self,
>> >       count: usize,
>> >       align: usize,
>> >   ) -> Result<ChannelIdArea<'_>> {
>> >       let count =3D NonZero::new(count).ok_or(EINVAL)?;
>> >       let align =3D Alignment::new_checked(align).ok_or(EINVAL)?;
>> >
>> >       let mut ids =3D self.inner.lock();
>> >       let area =3D ids.find_unused_area(0, count, align).ok_or(ENOSPC)=
?;
>> >
>> >       // If the pool is small, the backing bitmap may be rounded up to=
 a larger size.
>> >       if area.range().end > self.num_chids {
>> >           return Err(ENOSPC);
>> >       }
>> >
>> >       Ok(ChannelIdArea {
>> >           pool: self,
>> >           range: area.acquire(),
>> >       })
>> >   }
>> >  =20
>> >   let area =3D pool.alloc_area(8, 4)?;
>> >
>> > See the difference? You still check the parameters, but don't make it
>> > the part of interface.
>>=20
>> Miguel already replied to this, so just briefly adding to this.
>>=20
>> We usually want the arguments to already carry the invariants we require=
. If we
>> make the arguments unconstrained, we may end up in situations where we a=
lready
>> have types that provide certain guarantees about value constraints and y=
et we
>> have to give up on them because the API takes unconstrained arguments an=
d
>> revalidates.
>>=20
>> The code from Eliot does actually already takes advantage of this. In
>>=20
>> 	pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
>>=20
>> both arguments are already validated at compile time, whereas with uncon=
strained
>> arguments we're left with a runtime check.
>>=20
>> Yes, nz() does not actually validate it statically, but it easily could =
(and
>> probably should).
>
> Alright, I'm not against the static checks, and I don't insist on my
> version. My complain is about readability and unnecessary complexity
> for end user.
>
> let's find a way to convert this beast:
>
>  	pool.alloc_area(nz::<8>(), alignment::new::<8>())?;
>
> to something more readable, ideally:
>
>  	pool.alloc_area(8, 8)?;
>
> We were able to do this for bitfields, and I don't think we should
> give up here.


At the moment I can think of two ideas.

1. Provide a nz! macro to create constant non-zero things. Provide some
   constants for common alignments

Potentially, we could use build_assert! for cases it is provably
non-zero but not a literal (although tbh not sure this is a good idea -
at least not do this initially).=20

So either: nz!: const { NonZero::new(value).unwrap() }, or, nz!: some
build assert gated construction of NonZero. A general nz! macro could
also help ergonomics for other use cases too.

That looks like this:

pool.alloc_area(nz!(8), Alignment::AL_8)?;

I actually do not like pool.alloc_area(8, 8) because you can't tell what
the parameters mean. Having to write `Alignment` is useful, IMO.

2. The same solution for bitfield, whcih was to provide a separate const
   method that takes the values as const generics. That looks like this:

pool.alloc_area_const::<8, 8>()?;

That said I think this form would mostly only be used in tests.

I personally prefer option #1 because it will make NonZero easier to use
for everyone (I already have a few copies of the nz::<>() function in
unit tests) and because it self-describes what the parameters do. And it
doesn't have any turbofish.

What do you reckon?
