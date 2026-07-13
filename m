Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9399AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C8210EB0A;
	Mon, 13 Jul 2026 21:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="wogCud/9";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021129.outbound.protection.outlook.com [52.101.95.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B7A10EB0A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 21:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1bJl4s/Iv2o9TiFAFNkO+my8HBOAT1JodQOqwm/0C7uPj650t6PYcCrhq645/Mbu0qcgy4USvEjZDWJi2TivqVnvNZhvb6WWsP0JMcAc0CHmQyny+RxHdUcslopWjc1wQtpcB3PsgXxscUEco7NP6nEf2exxTEMPxY01Nhnr1H4xLkkrVGktleVVjO+MeVHTHF9GB3weisXgFi0Et+2FCyqmx9bO36peMDLNbjOWdeYTd4xleSMaxor5xqy5bTrJk8dWy6N5PtBrC4hOa/BHXvqqM2EJYJ6hfqtaohcx6Mn8z/qzWj4khCTs3CkupNCQHhLmYpd6/0GWsWLa37A1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4ohUcZELmOjkAooUkYZqMJZGtdO48mcM+aO8iCD3zQ=;
 b=QAIfrBoEwa5f0QXwgvdP3Fdx77qjWg2Z3E9mRrEfrzg0PaDzt3sn+29eytQXDc4XtYSarvB5v9Y623x5T4k9BK7M/iAyyGHheGuzByjsXZeV80DX56OnhnBh9W5lvK/GxRDJoRtM+EWY3ZDdQa+iQQkc1r4v53BB8jd5M3DKASnHDpBHtGWvoE18E41WUHu6sH6xE+O/R5sul6RVzX08Opf3q5srmLRSB/CvjqBxDu6MY5pp7ZyKJ+XU83XTuLlghBGc5fuKpUj26nAPrqdFB0rPLyfYrKqBJjSMASriRRIMXalrbr8MXEx6pv6xwhVMFWR/4gEWioIjBvrgtnvx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4ohUcZELmOjkAooUkYZqMJZGtdO48mcM+aO8iCD3zQ=;
 b=wogCud/9b7OwETb7Dty938F6daO9u67YozvGGcrm//QqCdaimlYOiuwvLe9Ilco8h/5QdRjOLc0/VTTRc+YV51DGwt3zsAeNN8IGJSvmi/D85TIIaby7c2h9gEfjNYh4dc3ff5WOj/UFXjj6amaU87F0cfsxrX2/KF2zT1pKTaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB7370.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:33e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 21:03:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 21:03:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 22:03:01 +0100
Message-Id: <DJXQX3NU90PQ.2WB4WD69F3H81@garyguo.net>
Cc: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Eliot Courtney" <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: device: make lifetime on `Core` and
 `CoreInternal` invariant
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260713201455.640151-1-gary@kernel.org>
 <DJXQ72BQ9CJY.3U4YFYKGYEEKU@kernel.org>
In-Reply-To: <DJXQ72BQ9CJY.3U4YFYKGYEEKU@kernel.org>
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: ecec820d-ea55-4680-de4c-08dee1222077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|22082099003|18002099003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: zfckfl0Ayl7avm9+6lzDEtpTRyicDvnUBJDanmyuAZHMj7CZ5GUQP+nWLICXyIyp+bN3ZJDwwa6U/DU29VZWa3IPeHJGdp+vN8xGu+RkoT77B41XKBbmgSGNGEaDd11rjHHuoB+2aMJKUCrOwWUMoJjNZwSMavvLtQ45EYVc88SBMISWAL4db6ZIzfZib3UkV2wxHvWjaLOL/C+ApBVuiuQ2wnctsHG8ZmCb7JMqUYlZaJ79mGIwWgp6blzMtPtHadSgkjkGW0cFZ8rFCsd3uKwg6pIEJZRb/3NcZz+7YYl7zXMmyeELN3UrtNP2hlDs6mzdegFbe/cwGKfeBQigfE6iACOhpDnELfuj0XKuUY+OVORlLdSUsImLl/WghpAKaAdN1SdXJDfKkOBEzX4eWZhEYcCq8/YkkHoOQCaK3NL+9aToOy33u5Wl/i5FCYMoVNnuprCyqdW3KHkQH5AFR1prpWIAwlvZC09gunNMn/aC0yDVyo/AkL5NjzI+DNxdYhFHz9o4aM1o41i4TsevUGcSw0DrHY/aiVAyF29OeLSNtqE7LwSGz+SG6FxseR7MZQa7WeZ4//QuXbgGdPzkXxeaL6Lx2DDNhw1Mt1Si/AO/AiCjW/oRpqNIb5tRVFCwcnGrz+Ay3mtC4QhNvU5/7YA6+l0K6kNV5tVNjvnD8SU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmNqNWs0ajBsS1I2RDdQeXlPQTdVV1laZGdNKzk0TDZnTHZ4NDBYaEZENGJ3?=
 =?utf-8?B?RkxURHBLdTRXekd2NlZjQXlWcTJVQ0NpaWtBWUJ3MTFaVm02NGtmelZxdGs3?=
 =?utf-8?B?TDBkMW43M2QrZFZsRFlsbFVMUUFvSGlJZEZ5V01FcFhMTmV3R0RucTZiNXhZ?=
 =?utf-8?B?azF5K3dSbEE1dGpqNEluT3VnOS9nYXFEbStUdTBHWjNxaDFkMS9tSXM1SUU0?=
 =?utf-8?B?WjBrZE52bmoyakt3T1ZNTVJCaG4xbE5OZk1GT3NsREw0Z1RDQ3IyTGFXNkR1?=
 =?utf-8?B?N1RiSndlUXA3bUhuV1NkQVYwVE5vR1B0WDAzRlRLM3ZvZHFzcWpBM1ZPWjhT?=
 =?utf-8?B?eWMvRFdpeURIbzVkWHRSTFBuTUt0S1dqc2QvaVd3TDdpWWpRRWdIMVNXTU41?=
 =?utf-8?B?QmZaU2l6YWsvNnFTam9IY1cxa25YTlh6MFE4aDFrbzY3c01pWVlyVEJYV3JB?=
 =?utf-8?B?RGd5TnJBS1hXNnUwdklKRkVBUVpJYUxkUmtjYVVGWE9FSkkySldMdEgwN3JD?=
 =?utf-8?B?bE9GUEN0Vm1MSTJjL3UvTU80TksrdXpkM0psNGMyNlY3S0pOYWRiMldOK29D?=
 =?utf-8?B?bElYcTdRcW1udzFCc0xEMWd4enEwenJ2N21sZVN6K2Y4L2s5akJYUEFNQjFz?=
 =?utf-8?B?M3lrZ21ZYmE0TjNEM3JvdkRJMGdmU05hWmY2VHZiME85Z3U0MzExQzM0UXAw?=
 =?utf-8?B?eENPb3ZQeEJFV3pDRXFRakpzSElrOC9EbHZJbVh1SkdmaEJVQ0hzbUdEQXZz?=
 =?utf-8?B?Tm1IUUY2UnFva1NJS0R2TVVDRVQrSDM0Nkl2U0NTSHh3SzFPQWZZSk44cWIz?=
 =?utf-8?B?SCtNRkplYUR5MmxqVXB2ZU5Sd3JZbnduOWY3MWlCVW1RWDBkZ1g2NzNReTZv?=
 =?utf-8?B?T0pQMkxMVUFEQWplaktMeGFycFA5WTNrc1dGOVNHNSs4bjIxeENDT2VqZVdK?=
 =?utf-8?B?ZkhvaEx1cGVlTDhlaDlrWFk4SjlwRmpXK1ZERlNDZGt4SEhUQmRPaW9sZ1dq?=
 =?utf-8?B?UkExenZQYTVOcXFMNnNRejNFaFp5Nkh6RnRoQkZXdnljOE1Id1hPOXlqNm1S?=
 =?utf-8?B?TW94OXd0MkhSem5HT2NOUzFpT1A3VzRyNUZ4VDRyQUhSUlE3Zzk1TVkvcHRo?=
 =?utf-8?B?eDJsWWxBUStpN2FTbkNrc2JZaVlLZkdPRnRVT293RnVOaWg1NFZkTHdGd3pK?=
 =?utf-8?B?Rmc3UjJ2UUg0RTB2Y21jNUxmaXRMbVFweXVTYU1yaFhmQ3FUNHRwblh6d1hL?=
 =?utf-8?B?ZDVlYzB1WGNWUlBEUGl2TkRWSEd2N0FhT1pYUHZzRCtsMTFkaGFOZEFaTFVU?=
 =?utf-8?B?QUk0WVpiV2Q4TkxoSGVOR0pYc2kyK2N1M2V3aEVqbHA4VTNoa1JlWFgyb0lE?=
 =?utf-8?B?WkxDWm1lT0NFSTRpMm1oQW5VSDVFd05GcEF0U0FpN3RBNEJqYU44Rnk1elpy?=
 =?utf-8?B?V21JVnNVTU5NMGcyZ0RHYzZsRENRYWMzb0Fhd0kyNEdsejlBZXR3UlV0TG5L?=
 =?utf-8?B?VzJJYzJWd1NJazdlaHdZMXR4NW1aUTJ4Q3hPZDhZeG5zTFlibVF2TEN2OVBY?=
 =?utf-8?B?MDhOZUdZUW55WGM2YmpSN09DUEpDbmxQK1o0cUtHb1E4cStuNzl3RCtPNU1v?=
 =?utf-8?B?RG1BMjdzVTVGcmhYZ1pXY1ZuNDFoeWVkMklNWUg1QkFGQW0wSFRHS2FQSCtN?=
 =?utf-8?B?MHFTeUI4eWJCU0h2UHNsTkI1V011czZ0bit3SXJLcXVMdnNmb0FHUVRHL211?=
 =?utf-8?B?a3FDcmp3S1Z1RXZ2N2gxM0JYdEJnTXdUazk2SnA3ME9TY0RpWnUrQ1lnYUp4?=
 =?utf-8?B?bUhEMi9jSlM5NVBqY1BzWjlUQTZEUXdXcnhOV3pUZjdjLytWR29KbmJkLzd6?=
 =?utf-8?B?TEtMbmRZN25QQTg2L2hDSEhzNjVIeStLdElJU0NqQ3ZsblhnWGF0U1NEYXBm?=
 =?utf-8?B?TysvT0dLNm0xZjBaNUFNRkZRcFdYaURzVUo2Tk16UUlWejBLbUtHQXR1U2cz?=
 =?utf-8?B?YnlsLzIyRkJTOWptekRnN01GbXVhSGhScXlueEUycVNTcWhKbmVLaCttaG5B?=
 =?utf-8?B?a3ZrWVdEQ09keTJOT1ZqMU5zZyswL0dIbi9HUUE1K3VBcEZMNURISW8ydTk2?=
 =?utf-8?B?QWxQQlRDYld2Q25STFdnbENkYnJTTUlHNjlEZk1UQU15YmpzaEdPRXI4WXUv?=
 =?utf-8?B?bTI3c0tvTGNDQzdyKzE0SVltV0Yrd3ppZ01jM1lBQUthUkd4NENuQXlvZE9S?=
 =?utf-8?B?aWhWaDFtTHIrK1Vjdnh0am9MTW5aNXdLSkxzUzNRSWdTRm9mTjdMaU1td3RS?=
 =?utf-8?B?YkMxTGxpL2Z3Y0FLVUVnK3pmZXNSL0s2MFByQ0NSZzZpUnQrOXBiZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ecec820d-ea55-4680-de4c-08dee1222077
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 21:03:02.4678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9to7yLQpUHDquHocFFGIZINRfPRUlg8ku3y9HuD46fWgFKvn3xHS8EtuyLu56CsenVBKALhV+wKX7B6BCC2XrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7370
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

On Mon Jul 13, 2026 at 9:29 PM BST, Danilo Krummrich wrote:
> On Mon Jul 13, 2026 at 10:14 PM CEST, Gary Guo wrote:
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index b3c91731db45..b603b0bd2692 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -285,10 +285,10 @@ pub(crate) struct Gpu<'gpu> {
>>  }
>> =20
>>  impl<'gpu> Gpu<'gpu> {
>> -    pub(crate) fn new(
>> -        pdev: &'gpu pci::Device<device::Core<'_>>,
>> +    pub(crate) fn new<'a>(
>> +        pdev: &'gpu pci::Device<device::Core<'a>>,
>>          bar: Bar0<'gpu>,
>> -    ) -> impl PinInit<Self, Error> + 'gpu {
>> +    ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {
>
> Isn't that edition 2024 only?

The syntax is available to all editions. Pre-2024 only type parameters are
captured, so the `use` would be needed to capture `'a`.

In 2024 the capture rule is changed so that all lifetimes are captured by
default, removing the inconsistency between lifetime and type parameters, s=
o
this can just be=20

    pub(crate) fn new(
        pdev: &'gpu pci::Device<device::Core<'_>>,
        bar: Bar0<'gpu>,
    ) -> impl PinInit<Self, Error> {

The equivalent code without using `use` is

    pub(crate) fn new<'init, 'a>(
        pdev: &'gpu pci::Device<device::Core<'a>>,
        bar: Bar0<'gpu>,
    ) -> impl PinInit<Self, Error> + 'init where 'init: 'gpu, 'init: 'a {

but `use` is stable in 1.82+ so we can just use it instead.

>
>>          try_pin_init!(Self {
>>              device: pdev.as_ref(),
>>              spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
>
> I think you also need this hunk:
>
> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
> index 1f59e08aaa4b..6fe94a73c52a 100644
> --- a/samples/rust/rust_debugfs.rs
> +++ b/samples/rust/rust_debugfs.rs
> @@ -147,7 +147,7 @@ fn build_inner(dir: &Dir) -> impl PinInit<File<Mutex<=
Inner>>> + '_ {
>          dir.read_write_file(c"pair", new_mutex!(Inner { x: 3, y: 10 }))
>      }
>
> -    fn new<'a>(pdev: &'a platform::Device<Core<'_>>) -> impl PinInit<Sel=
f, Error> + 'a {
> +    fn new<'a, 'b>(pdev: &'a platform::Device<Core<'b>>) -> impl PinInit=
<Self, Error> + use<'a, 'b> {
>          let debugfs =3D Dir::new(c"sample_debugfs");
>          let dev =3D pdev.as_ref();

Right, somehow debugfs is disabled in my test build that I didn't notice.

Best,
Gary

