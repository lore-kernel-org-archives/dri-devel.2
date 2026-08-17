Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C4C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:02:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E82110E7BE;
	Mon, 17 Aug 2026 13:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="p3qbMrvU";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021089.outbound.protection.outlook.com [52.101.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F7510E7BE;
 Mon, 17 Aug 2026 13:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4zBIshyNEYXIcIlKjq8pMGNvnKogpj/yreGI0ie2wObu6+RLFH8wu07k0Ro2rS14Bpk7RXLIh27uCUB0C0IFQtR15nCcJ2MSWx3VnCTCnPs6jxWwFmsXLVepkd8+YPsLCqlkyu4L3KnM9WAlM/m7bMnbH8lPND83q8BgKmArk7cazzPzNrm4jyf7tuEVu2dlRHvOTAhSj4oRX9iHpcsFu0pvuJjjfDxULaRK93qgIv1OCEqIZk7Lm7Mp8n8zSP/FdyKWPDSaOW/pytbf47Cm63t3v9wQ+2iojzORII8DouM/B4Zyy+pDwQ+EOg6lPxyqsR4Gws+dPDUDXgT8D5T0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjdwkS6XpLb1fGd28nH3/yuua9S8Osv48ncMTOhPMMw=;
 b=uBChOE6hVGwFaszKpwKH+6cH3ogdxzO9c/yPImQKDCmepp7e+lB8HOW/IOurFFLxKN9VeZgL6vKmA/IlFeJptwjuDmzSsvLNHmS2pbfZ7fSkeaNDDdgkvr33dWCLp4i+tny6dH2BGQZUzGM8JNOKCKDb1WNZMAc7S5tgqz9ghEwOuWdFjoTWggHKzcOuaHOXeit6c2Y09v9ah2U0CFEY7gCkpvs+Wz18ZfMqd94miBaDTYWs2sbP4zXIFi4tdOWT1Z5zxIdraL+aCAPr7EKlnHkhlH3ive+AvkjBiMIE9WHVHIlcGUDQ4agt93xVFCaRPW7o/fI7UfmRdMkt/cpxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjdwkS6XpLb1fGd28nH3/yuua9S8Osv48ncMTOhPMMw=;
 b=p3qbMrvUgOGVzIcXCtaK4lBFZH3khiLnr7bT4h0MfMHkuVZq+u5EoF6QdhErdYRx5oHUzEjRlJhofanYEuuzpkN+q1SkyxnPPAGm33BprQbHs6L4tQKWTrKMerSYHHVFYsFw/XdmheK0cSHSNzXeDFGBbELl48G529NBFiO9dWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB6753.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 13:02:39 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 13:02:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 14:02:38 +0100
Message-Id: <DKR8MCRB76L2.1TV4D7261PVTH@garyguo.net>
Cc: "Gary Guo" <gary@garyguo.net>, "Yury Norov" <ynorov@nvidia.com>, "Alice
 Ryhl" <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury
 Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
 <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
 <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
 <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
In-Reply-To: <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
X-ClientProxiedBy: LO4P265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: bbab2404-5035-4d24-ab38-08defc5fd0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|6133799003|3023799007|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0PHoYO1i0GITt7Yswh9LK6Nz8nti7HT4L5q6a3RpHgLqNnZPzPqvZ4VSbT+LDsEKHndwRdxpeR0iXZ8cQOPa53LHFPmytgZnoa4FJEqXdbUnZTqlqqRnN34Jgyrh4gNJ2PiNBihHhfThtGzTUjirYdXekUKCBupbeB/gTveMCpcbR2YpAK4MIJv9UG4q48bQeFnRwyIYnXZq4IKfdiJa4hLGxqPmeSyNvnvaOM9Ft8Qy5e+H2z7OoGASkZmf9RbgkWQP+waoGvwcQHkA4I8HRw3GB4tox8CSx5BP00oMPeXNrt2BigJgdO0EeX8xC7wt+pkY2q4HAIyxkNhSzPgQsyjMlb1qDhAwara0wEZl14uaYNjaVMmCBq6RnaJKJ+ts4B7zHHUThZltumldHFNAEQdkE4vZXKhZ7VrTa1beG0+gIk2NWil5d1/hc3Od8kpX6rcz2D73zzHJrQ3V/0siLm8jbX+s2pG4bXjgURK6IjicXRhiBQJT+MQjj7fd9c3kd+TCHpb91s1Tn/iB6X7hePJUxc2+z/amoRaoLEHRe+dkBxshbkFa2hBzRudWo1VDL/gS50CKTx0VkxKmKfeuKFQhX60vR/YwkGo5KkD/j0iivMC8m9FwSRvolRxljBi6hwNffakc+mgcFUXZCnG1RpAcU7Z5Z0vIDgSmDpA+8k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9LdG0yMTdONSttMElLTlJNb2dURzc1SEhpYnk3UURHV1hmSFNjMm8xUmwr?=
 =?utf-8?B?R0QwM1JaOWlzQ1o5TGxxMmRrb0RaYy9mRmJGbjdweHhoaDBmYW94NUZkTXZa?=
 =?utf-8?B?ZU5VU2FMeUo3citZdVJ3NjBnd1pPZ2p5UTgrWlBGdHRNM0g2UFJiK3J5ZU5x?=
 =?utf-8?B?MXIzQStFV3prekJBS0oveXJJZVZBajYrL1JQZVhXMzFMTldGS2J3dFJVSjAv?=
 =?utf-8?B?ZEx4cWRiZW9HUXhKV2dyc1BGYXB0aXJYQVZiZ3J1NzZmRm5vQ2RkdzA5QWp4?=
 =?utf-8?B?NWt0VkRtVVAvQllHejRXUHIzTVR2ZGx2ZGVRMGEvZkdsd3M3S1V4Q3BwL2Nk?=
 =?utf-8?B?Ny9JZXBkYU9TV0FLWkFnMkVDUGh4aWlQRmxaQ2NKNzY2c0U2djBlaFdmeFZu?=
 =?utf-8?B?S2JxVjRzaGxnZnV1Z2dxRklxSkFqSDlpMkRuTEJJaGxma0xhbENVU0NYNWYx?=
 =?utf-8?B?R2dGbzZra29MdFJJWnVzTTFCTlVPdWJyb2V2bDJOOGlwcW42SmVwcDk1T1FY?=
 =?utf-8?B?SmlkbW9oRk9qaVpBZ3hVMzQvY2g3VWovYVNscUprK1psRXR4RmxCYUZLdHNk?=
 =?utf-8?B?clNFMFh5Ny92ZS9nZ0tLY1h0dTR4SGFMdXhQcTh3c2pJbmdjZ2V2Q0JMWjVT?=
 =?utf-8?B?UTNzNWVLVDZMVmhKMmZJQ2NzYmxXU0hWWFg3Nk1zL0JEN2VQc2wwdk1sSVp3?=
 =?utf-8?B?NzhqNEFxaDBTSTFhMzREUWpDRGtuMDZkenIveUJhYUpSSHpCTzVzREJLZU5k?=
 =?utf-8?B?S1ZtK3BjUFYyVFNtRHFUcnRVdEpERGExMkU5N0kxT0Vja25nOTVJTE5kbnlU?=
 =?utf-8?B?YVY0aHNXeWZ4TUNOTE1ydmdZUW9ucWxZMzQrVVBuSXlCR085OE5mK0ZET2hm?=
 =?utf-8?B?WmNBSmsrU2JYUmdhS3BXZVR6Z2F3OTdRODBxVS9KUTNTenNmcFNiY0xQVUJP?=
 =?utf-8?B?THNzRWFkbHpydmJhQk1Kb045aGovQjAwOGN1cG9YMGVwbHh5eHVxZ2tRL1Jj?=
 =?utf-8?B?L2EyaldJdXpqVzJqYStJQTVaZDBwT1EzcE1qaU04ZitJRzIvUTJpVTk2SGZj?=
 =?utf-8?B?Z2ZsMk8zUWFnYjl5VS85OWVZT2FNMXlNdmtpUi9ta09YRFVoVmRWSjk0bUYv?=
 =?utf-8?B?eDRwZ004ajJNWi92NHJFSUtUOVVWYXkyVmxsSVY5ZE50ZGdvWXhtNVpLNFFL?=
 =?utf-8?B?OW9uYzRyZEZzd200cCtNelZHWSs0ejAxMERaMisvNFd3NGNrd3hCRGJobDFQ?=
 =?utf-8?B?QUttSHFNNWY4d1NGeWxtMXB2Qjc3NE54OW15VDVTOVQ4ajVLc25mbWQxK3NC?=
 =?utf-8?B?ZG0rc2RET3ZrREgwdGt5S0hROCtsQkZDTUVGNW1IWTBNNGhqemI0N2FJanJl?=
 =?utf-8?B?QjdDTUxRbC9VQ0tUMmlSY1YxeXFhWWhudXZJUWJaWG90RisvRWI5NzN1WFF0?=
 =?utf-8?B?ZjBNZjMwejNRZkdBMkhCU2JhdFcvOXZsOVBsVWZtb0F4bVpZcllqZEJPNks2?=
 =?utf-8?B?YUdoNnlrdFMvM2xWRXY3eVNxTC85MnVRTXE3eUZkN1lWMDVnTVBEbk5Sc3o4?=
 =?utf-8?B?eUsrdzBLNy9NcmswdDlob0luRGtFRStJaEYzSjhCaEZJNk1oam5JeVBGakhM?=
 =?utf-8?B?TVR3bkljcmtyUmwvNVUxREFUVnlROUhOKy9ySUlVRk9UazRpVmVxUEpma2tR?=
 =?utf-8?B?L0hpYlVkUjBwVHVjbXhIM0tQUWlHOTltWXpiekRjdUJtTEtmZ25iMWh4bDNs?=
 =?utf-8?B?YlBnekpBeEk0L24xTkd0ZC9GdmhrZFFPZnp2aWpxaU1oY20wc0R4N1BqbHE0?=
 =?utf-8?B?YmJPelhBelp5TnR2OEhCTEFHaTM5dWhHMHJRendTeWFSM1J2WHJsQm5wZmhT?=
 =?utf-8?B?cFFyNCt5RjVoRXI1WWFnTU0wbXRpODg5L1pKRkI5eDM5djJsVnpXcTZ4M2lp?=
 =?utf-8?B?c0RCWFM3MlJoYm5VU3BZSjVOSW90ZUlVODh1UHZweU8wQWIxaTZXUlpnV0t6?=
 =?utf-8?B?YWUxQklVWnk3UmoyOE0vMVo0UzROd0RXTjRIdUZiYU5uWjg4S1NsSzNlZXRJ?=
 =?utf-8?B?UmJTMUgrdjM0cVBEb2lKTXN1SkRxSDZPQ2o0Q0RNYU1sWlNQR01CbVFOQ2po?=
 =?utf-8?B?dUp5TmJmYXdyOENKQ3FwM0hjb0I4c3BmalpNeHdRNmpKdUt4TnNVTXZQV1Rp?=
 =?utf-8?B?K3ZqWExaWnkwYTl3OTdMUWpTWEtyQmM2ZGR1MTljQi90MEF1N0RsY0kxdi8z?=
 =?utf-8?B?eUQwSWVXZWtPWFE3NnNGWEVTZ0ZxQmFnN3dPeVRTUWxibUwreE1RTitSRlhK?=
 =?utf-8?B?eVRDN0wxQlNWVnErc1lCeEsxaDNXaDFuNnp6dWowelFQbWVsV3FvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bbab2404-5035-4d24-ab38-08defc5fd0e2
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 13:02:39.0692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SExQVwTFoC05EY2QJk8AdPNE3vXqBD4Hg7fCByzUTd1xph91XiI1oDGDEfO1bQ9PAcDpVKxLoLr0QvzNvCu9xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6753
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

On Mon Aug 17, 2026 at 1:16 PM BST, Danilo Krummrich wrote:
> On Mon Aug 17, 2026 at 1:49 PM CEST, Eliot Courtney wrote:
>> On Mon Aug 17, 2026 at 8:18 PM JST, Danilo Krummrich wrote:
>>> On Mon Aug 17, 2026 at 12:54 PM CEST, Gary Guo wrote:
>>>> IMO we can just support zero-sized allocation by always succeeding, si=
milar to
>>>> how ZST allocation is handled in memory allocation.
>>>
>>> Probably, but in contrast to ZST allocations it wouldn't be very useful=
, so we'd
>>> silently succeed on something that never was a reasonable argument in t=
he first
>>> palce.
>>
>> Yeah I agree that supporting a generalised zero sized alloc is in some
>> ways conceptually nicer, but I also can't see any good reason why you
>> would want to do it, it sounds like a bug. That's also why in the latest
>> version I made IdPool also not allow a zero capacity [1] (incidentally
>> required to not have to change the grow code to avoid trying to double a
>> zero capacity thing every time).
>
> (I assume this is more a reply to Gary?)
>
>> Tbh, I feel that NonZero (and Alignment) is hard to use currently
>> because of these ergonomics issues. But I reckon they're useful, so I
>> like the idea of trying to making them easier to use. Maybe you can make
>> an argument to not use NonZero here, but what about all the other times
>> we will want to use it?
>
> Personally, I don't see the argument for not using NonZero (or Alignment)=
; the
> invariants required by the API are expressed very well by those types.
>
> I also don't see a reason to step back from using those types for this AP=
I. If
> we'd do so it would question all the other new types we have over primiti=
ves
> carrying certain invariants to a certain extend as well.

I think there is an distinction between semantic differences vs just range
restrictions. Consider the other cases where we use new types:

* flags: very natural as you don't even need to mention raw literals.

* units: for things that semantically carry a unit, writing things like
  `Delta::new_jiffies(...)` is quite natural, just like writing "2 seconds"

* addresses: things like dma addresses naturally fit in new types because y=
ou
  don't need to write literals for them.

Now, with `NonZero` or `Bounded`, we are doing none of that. The only thing=
 here
is that there is a range restriction. Other than the value restriction
themselves, they carry no other semantic meanings. How you interpret these =
types
still fully depend on the API that accepts them. Therefore, it is very comm=
on
that you'd be using these with literals, and it becomes an ergnomic pain.

If Rust pattern types become available in the future and you can write

    fn alloc_area(&self, count: usize is 1..)

then I'd fully support adding that annotation to functions. Personally I va=
lue
ergnomics higher than possibility of misuse if latter can be easily mitigat=
ed
otherwise (in this case, by WARN_ON or just support zero-sized alloc).

Best,
Gary

>
> I understand the ergonomics concern, and I also see that for compile time
> evaluation turbofish syntax is not that popular, but this can be improved=
.
>
> The fundamental value remains that it nicely separates the invariants cal=
lers
> need to uphold about certain arguments from the API itself. It makes the =
code
> more maintainable (e.g. we don't need 10 different variants of a function
> depending on whether the value is a compile time, build time or run time =
value)
> and it makes the code more readable and robust (e.g. the semantic meaning=
 of
> arguments is very obvious and confusing arguments becomes almost impossib=
le).


