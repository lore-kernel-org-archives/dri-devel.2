Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583C3C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 975C010E408;
	Mon, 17 Aug 2026 14:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="UG8Nku38";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021127.outbound.protection.outlook.com [52.101.100.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B5410E408
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWapDe10+7AanJD7lkKTXQuP8WkZ7ELbl9gB/PfgZMgzFyXOrRT59/VK5oyQQDxsC5Qq6usie6aecqcNJ3zqWHseHWNLVJkc0Xn6xuxYfbcmFU2muuivt2Fk5KJ8Fn2oR1T9WvaPlgY9uTZGLT6pkp65dXuzM0XrzNp2fhPicLbGZY5GUrPYl8Z9t1420dbes8dqPoUC4sc7/S9Sou6hw5copmwh/ngQdgd62Vfm1G9BU/79FVmwg0sDVgp5+Z74I2btYZ59icoKjcTh1w1XTa16zH/OMHQi0NapxJ+gHBGr4Drgo+fbRhWTaCMK8RjhCKE2PrTb956aNwtLmSi3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpU1DBrrT8YE74+GZGNptSyNpq7rRwE/VfNqu892kMM=;
 b=H8ZtJQrDXsObONIWJzjQafd0UwwEbi+b6At2vWJlAXkhEsVfP8SPZ7k5K5DI0b3Qz2A2wP+I2+lJxMiWgduT1yzqQ3eW9En4qQt3K4kI2VZQYzJUsyikeFmgSt+vOPpjBV3rzaXbivgwYSC3HVO7GXB8Dnw8SsYpXtTsP57eIhufUjkd3HnJykLiij8uZkURWqy7Jb8/XZUOLRVYCAVB9XLPzJ3cmyRPphqXGc80plRXDfNIdCS1GzoCokc/7mB6FhJXRcGq/Gyv5Danv8dgPYEgUglpnh8jAQnmZHpKWV+fp2W8wBWuTFb7eOxwUPjeuXp/j6E403FeP+7zmAROeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpU1DBrrT8YE74+GZGNptSyNpq7rRwE/VfNqu892kMM=;
 b=UG8Nku38uuX/RBy7JmKJRf5lI4HGDchxMUiCY0ODv729rvUz5tU1XWufP6WvFsn0U6u8y1zZ/ScVq/pI2k8kXP9rPD8Mstltm4qfWXTeZyS9CASoO85CU5l99Cg8cEa8KJP7xcrwhm/AueQhKt6itFgADV2kAoPtji0p6+S1Kzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB7063.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:02:59 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:02:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 15:02:58 +0100
Message-Id: <DKR9WJY3WI0F.1FV4PD1J17ZFD@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/6] rust: alloc: add Vec::push_init
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
In-Reply-To: <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eea4a25-b27f-4d65-e77a-08defc683eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|921020|6133799003|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RB1fVbIlqt4hiIl71z7qq/Z5xlc8wptq8tgtNeAdAens9TFqhhMDZGkG8dZMr/+LbpUDFk9ecsBaA1bxagvHaN/cxlE7/KakrjRnKlaKBq1VnBt8HSc3wNvyCqdHvstTLCOidISrntAtZm2g9mzVXAwYoXGbM+/dw7muOJF+l6c9thR73u7TidzOI+C/BqeLw6MyfQG7KLmmVzpr3GDxkz3BeqeqesTn2/RTiQaSG/4Jrf/X3srUXBdBXYNfMM4p5Y10j5KpXSGtCF6SVT93fbQhIp47F2SPixbauXrSmLxx0wmfKvQ3uiu65HDs1bYb18j5FCbvdaD1FsGuJJVAF1tUs3Mh9jnCe3CdNXPDQoTXbxUGmqK6TSGQj4V9+zogl9Ro6lYFbgRg4wkvKbP8DXhnYrRjjcQh7k0M6YernX97Ye31J4Cgh/9YpLF31/FI9tAhkIiYx4Lr207uKGKl5BWfpE8waXDoqpag7R95fdcA9iD7ybIqbJxzXQjEQKOyOFweOrDHzS0OMh2i5ksLUO6n5EwP2xSvfm2enEchGzrcWOdHAFQdvyEFEvm2OJwodVhQNV+MosYiKCLCuT/Skl8E4Q3uu53eiiRg0ATrYvYi6s+LET6oAMSKZYHEUkFnp+5OL2H5fSzJShdwaoCqGd8EyfGBKsYoYCFjX9KlL6mgPygQxC5O/B3+DcM3ezfHjjSgzj93+Ayb/G3qiG6slQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(921020)(6133799003)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRiK2owS0FGL0lMVXo1VWU1WXVDV01aRmY3UVNwdFJrVXR1aDlNWG9rZGhE?=
 =?utf-8?B?Zy8vSzUrS3NRcEVsRys0Q1NhUHdac1JhaFJIWkVHSVRtUXRCSm03Q0U3VVNx?=
 =?utf-8?B?M3JKNzlnck4yMnpSNExyay92b201QUlsbC9XelFabmVCcy81UHlUaGRWT21R?=
 =?utf-8?B?ZU0yMVNaRTlwcVpZLzhWK0x1Mjc5Qk9MVTBKeHJFK3lxaVBRN3JOYktJNmZD?=
 =?utf-8?B?OEtPcUZOWUlXeXZ5dDZjMm5QczJaNUhjcG45Y2YzQjF3em5KTGdxeVppeTlh?=
 =?utf-8?B?RlR6c3lpREVQSXg0OE0rLzdqSW9LK1BGajdHTUpwbUpIYmo2WUhHWmd0RXM3?=
 =?utf-8?B?TmlaelhLNURyNEVSNnRrdU5mMFBEVFgyb1JXVEdsd09DK2xGcFJNcHp0LzJK?=
 =?utf-8?B?UDhYMW0wZWtzeWtDNkNJU01BTHFFamt6dVl6YlB0T1lNTnFOcTd2OHlodnRI?=
 =?utf-8?B?ZXhCakI0WTBWRWJqbGxuWDl1YTZJcklDQ3pqazBvTXl0Rit2QzgzcVdibDg1?=
 =?utf-8?B?Q3pTa2RoRFhiRFh2TkJleGFPM0t3N2M3aTRYNGlHUWtCMVZydVNsV1hML2VY?=
 =?utf-8?B?cThybDdTaXh0S0VRZEM4N3h3Z1JTanJodlZsODlmOHZIc0lwZnJDTU5VNDAz?=
 =?utf-8?B?ZkdYYjFZaGZzbGp5RDRPdVJHVkpQTkRmZGJUYStoaWY4TzVDay9aVWFrbEM1?=
 =?utf-8?B?b2VMNkpkNE80cC96UXY3OUpmOXJPOHU2QjdYQU9sZWpXdnUzdHNpSFpGUU9n?=
 =?utf-8?B?SC8xRjdaME5rZTdacE5VL1IvOEJJK1VsU3liOTczd1greXdSdWpIQWFma29t?=
 =?utf-8?B?eTM2SXN1ck5vWnZYVnkwZ1A5ZDVXcElKTWhkQzlhTnk4UTNpdm9nNk9IRjVD?=
 =?utf-8?B?cys3bXRtZlo2WmFINFYyNS9nUGcvcVRRekJITXRwN0QyZituVzUwUHVidFRG?=
 =?utf-8?B?RlNVcFNXRXQwVFlNRmhEVHJNekxKTHE3c2VxdDlnbVgxb1J0eHA5UXEwQnIz?=
 =?utf-8?B?OFVXS1hZbkNibjM0VTUyUzg3dVhBZGEyR0xFb2RkWUxDbFFTVk02VXF0ZjVG?=
 =?utf-8?B?SkRDM0NnckpQeGtXTEN0UFIwUFN3YkFiR05POHlMMm9YSkFHVW5DbzVjWDIr?=
 =?utf-8?B?d2ZqWVJhU0FhRDIwWGZDMjVzajlWMUZreXhVbE0xTjRoRWFTR29PM1JCeWV6?=
 =?utf-8?B?Y29pY05oVEhCV1k1c1dsdGwzS2txcTI4bjZ5SFV0clM4Z0ZLUGRNTVdXcXJ5?=
 =?utf-8?B?T1ArSTFsVUdadisxMEFUZXhnWWkwNHFMSlJYZVdLYmFvV3lCK0Y1bHZhcE0v?=
 =?utf-8?B?WEs3RzhmWlN0cFh2dDU5bXgrVUErT29EMUJMQm4xbTFRb3J6STRQT25SMk1Q?=
 =?utf-8?B?ZUMwMXV3TW9pMVB3N3FiZFVqckFKbVBOT2ZtbXBRbWQzRElpMEFHVkJXMTdy?=
 =?utf-8?B?NTdyN0VNQU1wWXBjQ0NtRW5MUUt5dGd6elJjZWZhS2VUMnRvUnhIVjJabXpZ?=
 =?utf-8?B?cUpmOGd2WFJlRkRwVW9vSFNZeHhpK3g1V3VMWTMrSEdJS1FKUE1kalhtTW13?=
 =?utf-8?B?YmVGdFJZWlBTaG9UVWs0UWdTQ1k0T1d6YUJtNlZNQmUzRE85N1ByclQwSWNQ?=
 =?utf-8?B?anE3SU9aNE8rYjBraklXLzdsU05pVWFlZDF4eEpuS3hEVkFnaERDNTBoSkpz?=
 =?utf-8?B?akNCSS9KSFlOUTladHpUZGVWSnhTdEREbVM1TzQ5Qjl6VjU0MktTUnhUK29M?=
 =?utf-8?B?eDhvT2FzeGlud3lDcUp1cG5jVU1SVUNCcGxuT2M2RHJVaXBJT3FKYU9HS2V6?=
 =?utf-8?B?cDJ6TVpIMEp1TlEza0p0QlJJZlZyZmlybFRDRjZKd1JTakliajM4a2ZzakVk?=
 =?utf-8?B?OTJvaHJDazN0ZllTRXdZdVRjS3pQTUtoc05wa2t1NnVGdXZwMHdQYzdZK0J5?=
 =?utf-8?B?anMvd0dFOFFUbElKT25Za3RSVDZ0MHFidG1lUXFLSmxhcm5sc1QweGl0TWNm?=
 =?utf-8?B?bExwWE1HbjdlRkpuTFQ0alI0RHFjLzhIeUZ0Sk56ZEdhalViYkdSdkRWV0xM?=
 =?utf-8?B?MlhvYjYydDBNZmdIYldqYVFNZUJRVUhxanVzblpzZ2ZNYmNwVitkSWY5V0lQ?=
 =?utf-8?B?enJKOHBjVkVDdlJ4REJqUzFicmw3bWNaL0ExZEpUL0FmcWhvV2pyT1o2WU4z?=
 =?utf-8?B?Sk9qQmZtWkVieDI2dXpNZnYrT3gvUXR0ZDYvWDdnMXEyai9iaUxuYkwzWmoy?=
 =?utf-8?B?bXY1bzBRTVZhakpIVGY2emVaM2t5RlVnMzczbjJsRit5ZmlMbHZYN3BFTjVz?=
 =?utf-8?B?TmJnWXJrZXZPMGtFbldwMmwvWHR5a09XdVZFdzJYZTZVd0RKU3k1Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eea4a25-b27f-4d65-e77a-08defc683eda
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:02:59.6672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaFKRcYKnsSWPJJvG0uA7bwKkfhJjMRjp7q4OqTGUtkCGzVWcX3N9nmcWZmz8AqFhUToC3uSco1xlyfAVBUgUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7063
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

On Mon Aug 17, 2026 at 1:56 PM BST, Eliot Courtney wrote:
> Add `Vec::push_init` which initializes a new element in place. We can't
> modify the existing `Vec::push` signature to take an `impl Init<T, E>`
> without changing its Error type.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/alloc/kvec.rs | 42 +++++++++++++++++++++++++++++++++++++++++=
-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index c7546b9da4fa..9f6f25d7e218 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -52,7 +52,10 @@
>      }, //
>  };
> =20
> -use pin_init::Zeroable;
> +use pin_init::{
> +    Init,
> +    Zeroable, //
> +};
> =20
>  mod errors;
>  pub use self::errors::{InsertError, PushError, RemoveError};
> @@ -359,6 +362,43 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result=
<(), AllocError> {
>          Ok(())
>      }
> =20
> +    /// Appends an element to the back of the [`Vec`] instance by initia=
lizing it in place.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// struct Element {
> +    ///     buf: KVec<u8>,
> +    /// }
> +    ///
> +    /// impl Element {
> +    ///     fn new() -> impl Init<Self, Error> {
> +    ///         try_init!(Element {
> +    ///             buf: KVec::with_capacity(16, GFP_KERNEL)?,
> +    ///         }? Error)
> +    ///     }
> +    /// }
> +    ///
> +    /// let mut v: KVec<Element> =3D KVec::new();
> +    /// v.push_init(Element::new(), GFP_KERNEL)?;
> +    /// assert!(v[0].buf.is_empty());
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) =
-> Result<(), E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        self.reserve(1, flags)?;
> +        // SAFETY: The call to `reserve` was successful, so there is at =
least one spare slot; the
> +        // pointer therefore refers to allocated, aligned memory valid f=
or a write of one `T`.
> +        unsafe { init.__init(self.spare_capacity_mut().as_mut_ptr().cast=
::<T>())? };
> +        // SAFETY: The call to `__init` returned `Ok`, so the first spar=
e slot now holds an
> +        // initialized `T`. The new length does not exceed the capacity =
because `reserve` ensured
> +        // the capacity is greater than the length by at least one.
> +        unsafe { self.inc_len(1) };
> +        Ok(())
> +    }

Thinking about this from a fresh design perspective, I wonder if we can cre=
ate
something more composable by splitting the allocation and insertion, like e=
ntry
APIs do.

So

    impl<T, A: Allocator> Vec<T, A> {
        pub fn reserve(&mut self, additional: usize, flags: Flags) -> Resul=
t<Reservation<'_, T>, AllocError> {
            ...
        }
    }

    /// Type indicating vector with reserved capacity.
    pub struct<'a> Reservation<'a, T> {
    }

    impl<'a, T> Reservation<'a, T> {
        pub fn init(&mut self, i: impl Init<T, E>) -> Result<(), E> {
            ...
        }
    }

You can imagine even pushing this further, e.g. have a type indicating just=
 a
single reserved slot. Or perhaps have a type that is `Vec` but with fixed
capacity and cannot reallocate (something like `ArrayVec`) that the reserve
method will return.

Best,
Gary

> +
>      /// Appends an element to the back of the [`Vec`] instance without r=
eallocating.
>      ///
>      /// Fails if the vector does not have capacity for the new element.


