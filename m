Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C25FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D884810EF91;
	Wed, 29 Apr 2026 11:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="LmN3bwZY";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17A910EF91;
 Wed, 29 Apr 2026 11:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=das23J1br+o/GODeXzNAq4LqYcbgjlsBJSbzthLWIsQDwpqlNotD08EO7mZ4KaBP5U5UytciX7kM7d+s/xQOPkKHAfccPmEAjV7yxTkFPuSEj2uXZl5oQUXQxOJMU++CeMWSfDvS9nE8EClfM8Q55qRJRPxP0McUhUBVCb+IOi61tZ5tEBliZpMH7xrLoRq7L7ZigHaWbjfzJaSnDKULoaNfjAGrghA54xBfvv23C5rX5LiW09ZYAHILaHuhydNTbdY+QucKq/74qoBGCAQOLwcfc17l/XQSs8l77PuocRTWA08l79j/QxRe27J4s9/wambnFMSXSrP6ncP8T4smDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwOXNQGrtvpzicuJ7h0cTsziM2v0gnPSQw6LF5ho47o=;
 b=CPucrJoyVczVtAMqsuOZOPZ50lwM7jOjb2tjSw6u32LzJBSEyE51GvYOwaICGLVwVWmZHRFe/gRnwc+bdFNzhN3E+dlMzEchLuIQ+/5hoYlPrpwKtacImKMeqOvphsXkqlkVIa8IAeHJbrLxDORiov3lwgew7QjQ+/oP20liDvG4flxoamHjAbNKsOIM12Uo2d7pAUO3cJlE0YoXH6kjWTHxqm5Y5Zw3TeqX5A504527x94hUOHUyNp0iwt2gMS1UR0A6QAYxQK5BfiGvoVBppXRXR+j8/ofybOFzInhPsxWrpPgyrHviJOPgjI3MA8xRSIHYsMaDpom1jrEcghJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwOXNQGrtvpzicuJ7h0cTsziM2v0gnPSQw6LF5ho47o=;
 b=LmN3bwZYooD69eSxN6337X8FaCCbxkQ3lw5u6L1O6g3nxiSUqu2wgkYp3/yyU3hxVGIlVqD8QpX2Xu0eebbgn0PLNERjC29/QLHXb9MWDEUCy8pTRDpbc368H2mm7hT8K2gUpb16L1ByGNf/Su/p48xH2PcDIONPGOnA7AhkWlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6031.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 11:29:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 11:29:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 12:29:48 +0100
Message-Id: <DI5LRCUUKJJW.24ZCQBQYEPPVZ@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] rust: ptr: add panicking index projection variant
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
 <DI5LLN2V3XCS.34H4CG99N4MPA@nvidia.com>
In-Reply-To: <DI5LLN2V3XCS.34H4CG99N4MPA@nvidia.com>
X-ClientProxiedBy: LO4P123CA0111.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 16eeb77c-e3db-4c60-81dd-08dea5e29f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IYgha/YLa7tnr7XzUhTbQUN+E4OJO9gZNrr6X2s0BExCiW4b4Zmwy614TAmX9Kds3KMTmGlATyO27xXfZUNAf/PKFRE2xAuVBjBEY7hgbhvk2QyBEGXEXPgQIDHi52lty8aIyLezG9JDHUWxm0YDBXI20G6x6pbjqaVEnTNr5QkhSnK804CRyOHkn8e9o9SngvkdmqD5+UdywYxdY+rbrIWsCmM0c1NVRkwpFKFjaDWEzJtULDBfNR7vJ12NbimI9AMSxCXl43zI5icAwJilYabMRi0Dvzbc4YZtp8WKu+GsqwVBk3rb8iwX7NizshkwcHU6RaEe0u46gg4hrUwzxDaNTCwggz/I4KYaG+0H4ecsAMrlidj0vlqBPAdCq3KGLExqOy77xAGVg4H96lpJShCt+hiNuxeQZ7um9BPGY8X1BLebpzxshsQIwCc6PjM2kFbNW4Xwkgne1zk1TzUrfZqWlwe217Va1book6RlcYKrEgfHI6rCm+PA5TVxI8KUi4hsxHr4selVLwNCrGtVVGNyOwYNRTg9lnGnvfwETS8z117EUk++0xaA3BbpFQT9m6gbdhQXSW1mqEcQLLoisJSGreSiLwni70QZVMUzOiNURq074x3sWBEqwFeQ8dnTTa+W+jaaeAuhXcrSCmOzN6vP+WZjOiz03a7NKEEx0R/AeBT3HmVthn3zaKMMkwJXgUSuCfyu+5TQFPaAZHc8n0ui1744IeelECqgHczozrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFsbk4xRDkzeVMwdkVKNExpZ1c2cEFlTEZIMzMvbWdLZ1U3bXRrckZGOE9F?=
 =?utf-8?B?Z2V3R0lhMkorMnVraXd2czlWYUNVZ1dweDJoR0NNc0NQMnZZcTBuQTltam9C?=
 =?utf-8?B?cGRGakpBUkdGOWNGYXJHRkFReWxKTi9ieDNSaGx0RUdwMk0zaEFzSWpsTlIx?=
 =?utf-8?B?ZEpIRHFSajVDVmtrM21DOGRVZ3NLUkFvbmNyelhBVDlNcE1hMDF3NUdYU0s2?=
 =?utf-8?B?UEtBQTFJK1ZXU1NPVDdVR084TXU3aDR1NmkxTmdKNXlNQTQ2YnZQTDlTdmJJ?=
 =?utf-8?B?Z2duK20rMUJISnhmQzhBVk9LNU5XdEtJMFQ3cEZkL0k2VVE4TlFKZUVjQ29E?=
 =?utf-8?B?WDVsVWk0dHB6RUZBQ2xLMjRSMDVIVXRpSGtsb2w4aEdYcHdNT29tRVpKWk9R?=
 =?utf-8?B?MWc2TWZTMkpIMGxheVQvZmRYUFlIeHZRRFE4Y09UREM3WUY1YUd1TG1RWU9o?=
 =?utf-8?B?MmJFSFh5TXZVYzFyK0xUdTdLeUtwMGlwSFgrblRiM2h0dkYwWk5UdENlZFFj?=
 =?utf-8?B?ZGx1UFh5dFYvSWtiQTVDQUUvRXdjL1d4RStNUVovam9ZUW84YkFZamJLdFpx?=
 =?utf-8?B?bmFvK1FLczNpNlBNRmZMNnFPaGpBZ2JnK3BRTWJoMTNUdElvdkJlNllQVnlv?=
 =?utf-8?B?bVIyQ3lWQm1MN1lrM21oUnhoSGoxRWhsMEhTRFgycWhITDVWNSs3SDRkUk1s?=
 =?utf-8?B?d1gzRURkYUJuOFF4SjFVSzdtL0VETkFZVFlCWmhvbjJUTDBrV0ZRT1lySEtU?=
 =?utf-8?B?NG44NWd2UVZvWEpVOXgrK2EyVlhKRmVJSWxHQnlQWU5UN3RPVkFwY1QxYlRD?=
 =?utf-8?B?NGhLRGlqNG1IY0hPYjRVNGxXTEliSzlHYVlERHBuZXVJUFh4eTIvRWtGeU5l?=
 =?utf-8?B?Z09WeUFaVElpNVNZSTg4RmtSVDA5MUY0WXJvMTlaVjBVQzBuZWhMc3d3QUlQ?=
 =?utf-8?B?NnVmNWJPaUphOFREY0hnZVEySTA5cmVRM0M2QU9KN3BKYTBjZmJkUll1bTdt?=
 =?utf-8?B?Mlh0WmlTV0MrTUhQdkdiUVRHRHdkeDBGRk5XbitaSHNPNitScElPbFNBVDg4?=
 =?utf-8?B?a2I0T1hTb21keUVlbG1KQVdRcTBTTG1EdjhCbGlJR0htZVJPS3NCOHdvZFN5?=
 =?utf-8?B?ekVGZ1hqV1hJaEpPdWxYdnBpMzlvRHMrVkpiWEZqNG1DRUxkUDVHT2V0ZEEv?=
 =?utf-8?B?dzhZczhMejRMREx6eEVUbGJyS3NJQU5YdzJmQ1V6bDdXaktOSFU3SExRYkRQ?=
 =?utf-8?B?UFZudVdCTlNnNDI2NElFR0ZCN1JUM3hBWWZhbS8wQVpNTW84bm5jRFZXcWUx?=
 =?utf-8?B?bnFzSk1tY2N2ellyZlE5cnNhU2REU3cyR2JIeVBsb2dDZVlDOUlmamhOVFRF?=
 =?utf-8?B?ZFNucGhRQnY4MGZ1c0tCOTkyZ0JpbU10Mnd3dmNkaU9mdGw4dkVDZ1RaRkNX?=
 =?utf-8?B?NFIrekZqdjc5QmhNZW8yQndYeXk0NE1kaW1ZVE9hemFWR0ZMdU0wZGJzeEFL?=
 =?utf-8?B?THFZSWpTYTkyQ2I0MFpXcHgxa1U4M29UWFdEbVF6LzM0bFpQQ2NiUUdIRm1v?=
 =?utf-8?B?enNrT0YrVWtrMXhXeXJZcFZxakdXd2ptWmhWZXFWbXJaWDRGa1RPbFV0emo2?=
 =?utf-8?B?U2ZXWS9WVWt5V0lDN01sVVhkYVJzNXliRnM5R09GWDdrUlZBRk1YbnBYa3pT?=
 =?utf-8?B?aTJEMW9tT1JzVXFwdnRlWTN6WHBjK3VxbGUzYkU2MHhpM3BZRWpnNlkxZ0Zt?=
 =?utf-8?B?bnVYc21WeFdTMndBTGloaDl1UUxxQ1ZocHgxZ2MyYWRMK3dvSnFiQldMN0Q5?=
 =?utf-8?B?dnhNcVZDa1lJNk0wZWJjZS96aGZLS2pCVnppc3lJK2RZWnJOK21Pc2o3d3Fa?=
 =?utf-8?B?bE5vb01PT01XRkY4V1RLZUdHc1FGRmllb0ZRNlI0UUFEYi85blVWQjdKSmkr?=
 =?utf-8?B?OUhHdjYyWEp3RVpZN1VsRUlHcTB3K0hLWHVUbTdMcFZSdmlYZVo4ZDF0WGVV?=
 =?utf-8?B?TDU5Y2ZiYjd0aHJ6V05wSTVuNzBETXlJUDJPN1VtK09KL3JjK0VlM29qTVQv?=
 =?utf-8?B?MEZkazJlL3JLbUN6WDVGbENMKytJTGxiRDIvTUVSREF0ak1TQk5LZkFGMDl0?=
 =?utf-8?B?TmFHdjNiVkZ6ZU5qcTJkMlFOamxqWDNEN2FJQ0p3cXVDVTZzRk13eDBNOEtj?=
 =?utf-8?B?KzBremU2M3BKaXJUaThpMEl4am9xQ1JEVThuT29XaFJ3dXJKZXdaeFFyYmJk?=
 =?utf-8?B?WHZOU0hnYWsvV2NuU2IyWUxQdDZWdkpvdTlTMFJoSE4xK1pubnFuSzI3YUNL?=
 =?utf-8?B?a21LdFJvalhwY2xjWTJMSkdtSGtRWFMvcDcwRHZaVlVETHFYRzR6Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eeb77c-e3db-4c60-81dd-08dea5e29f9e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 11:29:49.3335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/iPSwl4IOUFWqA/1rj1k5IiNfwgfDmRhA1yMMRg8EGxhldsy6mN3jsmZGKZoFepmPSe9/rPluy0iX/AwjZMgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6031
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

On Wed Apr 29, 2026 at 12:22 PM BST, Alexandre Courbot wrote:
> On Thu Apr 16, 2026 at 4:57 AM JST, Gary Guo wrote:
>> There have been a few cases where the programmer knows that the indices =
are
>> in bounds but compiler cannot deduce that. This is also
>> compiler-version-dependent, so using build indexing here can be
>> problematic. On the other hand, it is also not ideal to use the fallible
>> variant, as it adds error handling path that is never hit.
>>
>> Add a new panicking index projection for this scenario. Like all panicki=
ng
>> operations, this should be used carefully only in cases where the user
>> knows the index is going to be in bounds, and panicking would indicate
>> something is catastrophically wrong.
>>
>> To signify this, require users to explicitly denote the type of index be=
ing
>> used. The existing two types of index projections also gain the keyworde=
d
>> version, which will be the recommended way going forward.
>>
>> The keyworded syntax also paves the way of perhaps adding more flavors i=
n
>> the future, e.g. `unsafe` index projection. However, unless the code is
>> extremely performance sensitive and bounds checking cannot be tolerated,
>> panicking variant is safer and should be preferred, so it will be left t=
o
>> future when demand arises.
>
> Review nit (no need to respin for this): this patch would probably be
> easier to review if the renaming of `index` to `build_index` was split
> into its own patch. It would reduce the diff, while also removing the
> burden of having to keep in mind that `index` means a different thing
> depending on whether the line is removed or added. I've found it a bit
> difficult to keep track of this.

This'll need a respin anyway (to merge with the IO view series) for patch
logistics reason, so I'll make that change.

>
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/dma.rs            |  3 ++
>>  rust/kernel/ptr/projection.rs | 98 +++++++++++++++++++++++++++++++++++-=
-------
>>  2 files changed, 84 insertions(+), 17 deletions(-)
>>
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> index 4995ee5dc689..3e4d44749aaf 100644
>> --- a/rust/kernel/dma.rs
>> +++ b/rust/kernel/dma.rs
>> @@ -1207,6 +1207,9 @@ macro_rules! dma_write {
>>      (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) =3D> =
{
>>          $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*=
])
>>      };
>> +    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $(=
$rest:tt)*]) =3D> {
>> +        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] =
[$($rest)*])
>> +    };
>>      (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*]) =
=3D> {
>>          $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($rest=
)*])
>>      };
>> diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection.=
rs
>> index 140ea8e21617..845811795393 100644
>> --- a/rust/kernel/ptr/projection.rs
>> +++ b/rust/kernel/ptr/projection.rs
>> @@ -26,14 +26,14 @@ fn from(_: OutOfBound) -> Self {
>>  ///
>>  /// # Safety
>>  ///
>> -/// The implementation of `index` and `get` (if [`Some`] is returned) m=
ust ensure that, if provided
>> -/// input pointer `slice` and returned pointer `output`, then:
>> +/// The implementation of `index`, `build_index` and `get` (if [`Some`]=
 is returned) must ensure
>> +/// that, if provided input pointer `slice` and returned pointer `outpu=
t`, then:
>>  /// - `output` has the same provenance as `slice`;
>>  /// - `output.byte_offset_from(slice)` is between 0 to
>>  ///   `KnownSize::size(slice) - KnownSize::size(output)`.
>>  ///
>> -/// This means that if the input pointer is valid, then pointer returne=
d by `get` or `index` is
>> -/// also valid.
>> +/// This means that if the input pointer is valid, then pointer returne=
d by `get`, `index` or
>> +/// `build_index` is also valid.
>>  #[diagnostic::on_unimplemented(message =3D "`{Self}` cannot be used to =
index `{T}`")]
>>  #[doc(hidden)]
>>  pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
>> @@ -42,9 +42,12 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
>>      /// Returns an index-projected pointer, if in bounds.
>>      fn get(self, slice: *mut T) -> Option<*mut Self::Output>;
>> =20
>> +    /// Returns an index-projected pointer; panic if out of bounds.
>> +    fn index(self, slice: *mut T) -> *mut Self::Output;
>
> This looks like this could have a default implementation:
>
>     fn index(self, slice: *mut T) -> *mut Self::Output {
>         Self::get(self, slice).unwrap()
>     }
>
> I'm sure there is a good reason for now having this though, so at least
> for my education: why not? :)

It could, but the implementation is going to be dead code.

Best,
Gary

