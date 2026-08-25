Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830E5C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBB610E133;
	Tue, 25 Aug 2026 06:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fWnQt2Fv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE0410E133;
 Tue, 25 Aug 2026 06:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHdU+lU366P/D9CtCLdNPbSIN6DP2DDJL+iyOG3O6bG+/pqydBUbxAG8lHIpef76HQ6miIHIW4lJBlIFG3mrZIZL/N2s+UQm6l0LLW46S3srg6IvqZBaEZkbrfiu/FgS+dfKQ6DQ/rsf8qACqueJH0Lr5Mlb3DJbMLXi/+rRc42gJkJd/PUVBFHoRj2Npw/vxQbp2nt+y+AyHu6t/bYxrhb6awIN2ZL4B4EL34wg+vu5W8J++T9pPQRStZzdWYzWA+R+5BMDENE2wUbLo6YkfwZ9a5yBz7KRC06iqEq1aYgyZYrXrghFmtB1r3lscEGZ8iUlGNFW2axkOf0IuaJ+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPBKUY3mueL8WLjvMYrWbB66COkhjD5BmwpYiPTENgg=;
 b=jLxHX55CnlVjfJ9Y68/nR3NfIJySeQw7oZp9tv8ViPZ3gEFdWG5D5XyUV16Z6KkeWjQh1+9kNVpjCF2sHAWt4PJeZAQ6qA+iqKARzDIHsgyPK8jUikL+jZQ4j5MbJetID7bjgdCM9gXw8gM51RKj6l4lGihWkWwhAdsGW8sNnU/RIri/po5UoCeaez+eqkF2HPlHe/FuiR+86ejhvWBueA1qME+FY+2Heb1j/53/B/IejPE2YxpnBBvfn3+EenwnJaaHkVfInbdgEev8FQP/vf8f7A23laRUvdl19Ty1M/D9yb/l3ePm0WyH6gs7sggfiJL4tY+lnRPdCeK5vjhB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPBKUY3mueL8WLjvMYrWbB66COkhjD5BmwpYiPTENgg=;
 b=fWnQt2Fv2nJoGh3P3HcLt3okCDcKvy9xSE/Au8q9kk1ZaS+1srBW6fxRz+TPOuapyTc5Uawq+YytvwqTVEKdv4nD/nE3V43USmHtrLAShMBeZ7t9FRNQg07VttSw+FkA8jT9dEvBVGSR6Or4cvK/o5zcGGu3AtSI8HOaEt75tZufTuYWEGOPVPoxmlspUKDqA+u2GgDxeOrzlqSHm255vrKCp8iYR8bznXEWX9IOOix2zibWVcei9FbyyRAVLH0VYvdIbSfzEg8q/t+8xBWEx4a2Zwz8a844Wed0tnJXjg6sc7PNXT3fcs7nCed+NoD4XdPu3A19XQvrkKbXICuR3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 06:59:07 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:59:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 15:59:03 +0900
Message-Id: <DKXTWC92M16G.RRRYX44EOM55@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
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
Subject: Re: [PATCH v7 04/10] rust: sizes: implement SizeConstants for
 Alignment
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-4-a5872e64d8f4@nvidia.com>
 <DKUGEEPHSPD3.DCDP1WRYE6HF@nvidia.com>
In-Reply-To: <DKUGEEPHSPD3.DCDP1WRYE6HF@nvidia.com>
X-ClientProxiedBy: TYCP301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd64817-b3c1-45c7-aea5-08df02765b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7416014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: QO6hmrRaCWAzg9qF649EkeuIKLcQa7ju1w+ar9jymWz/vFQfvtnP0/J5PKJk+xrgB6AmoOH3xwg5GqV97nnai1OZbPiEAxT7WYK8Q3YH2j3NscZDNhz8myLELSl0NTpc+9KnfZHN9eApqA6j9lhpnH9dV/J62kiJh1YfC7Okfz91l+23Evdjui9y6YrEesMKayMcwx5ln3ySzVxPbG8Nnhgu4PLiH7Vb67hsWusV9tgFKWeOa9UOkHnhCMI+RsIYpK9zXUDjUoKTslL9ieutKlTxb5hDxGaMKISpT19ACs1Sog5xAsmNxSisx7uM92T+WQcF7yveWlBAgPlLw9OPOK+t696u3SSGkbH+pOf4xms6rccpdX7xyJMjPUTNokqupKFJaWNJrNeDf5cYCjJKThMLv9HW73gCSvP1Srh8MUOXA64v7htA5M2ESW/Ig1lGcK4rV8SxTKx8JieDUd7evV3sWYzeLHmMSUlWYpAyTPBzmGdzlm919skYaZB4VurpiKeat9BPuVWk+Dha6gyMp3neSIBPNgPbKWO1OAYUtNbNvYw6fxrBWV9z8HPFoDP0b8wM/WHSLqF8513VTK7rlK9veRNYfPDwKh4e5VMBw6aYbuZibSB83K5HYivDaPOQpLX93AqsKUDQMnyUvP55dqEHzPl5OQS+l1upXVhqpIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlBSKzZuZUJFaFhkcUMyQnFZcnY4T2lmbGdFT2NsT0JVbmpHWlRoUE5wMGdr?=
 =?utf-8?B?WGFrRE5KL3dXZGtqUkdQS2xPdEFseHhBQnNTbU1sb0c1WldzR04ySWI0TVBp?=
 =?utf-8?B?REo5RGRQTTdmMFViNDdGdEtJYXBHN2IxRWxQckI2VThVRVFza3RiSU1SMGVU?=
 =?utf-8?B?YVVkTElydklWZXNSdkViYlpGMmJnK3BsdEtucjBIcUNDYlJ0R2NxWjdxV013?=
 =?utf-8?B?bWgyRURXZU5MUzk0L3RiOHpzbmJBVnROL1NTRnltSUx5NEZFM2EwQTFzcGVj?=
 =?utf-8?B?RWd6NnkrdXc0Yy9NYTIxL3oyMUM3d0ZXZFVRZXpJSlQzdXFQSHpSVEZrZXRH?=
 =?utf-8?B?VFdBZkx1ZjlmNy9TUyswVnlZVXpnL0IxaW5OTzZDUm5BUzc3ckcxZVFjUTFn?=
 =?utf-8?B?MExFSDFZb0hmYzJyOEo5dWc1Q3QyRS96aU1UMlhOSmZqUmdOeVBhYzM4dDJQ?=
 =?utf-8?B?US9ndllFd1FGZStlVVB4Y1hGM2hsWGJJTXJBSEJUMXNpWmlLYTR0b0tZN0pP?=
 =?utf-8?B?d1MwVUVJbSsyejlBM0hiYXVDeWNqYzU0ZUt1Qkp0ZEtrQkJkUnowSUhNcnJw?=
 =?utf-8?B?di9BeUQ1dlhDWVI2YTcxb1daM3JBanVPbkozRmZQSlkyUWVBOVR3WFE0NWQ3?=
 =?utf-8?B?RTV0ZVRYaWRYUlBBRW1yMVE4TGNkYmdUODRBUEpZekJuMWZTLzJGTVUxMWNU?=
 =?utf-8?B?cjRETy9Jak0wM09HQ01HTTZaQ1lHY1dyeGVaUDNFTDBsSFpVVUdYY1VyTDg3?=
 =?utf-8?B?OWpvM3o5aldyN24vNzkvUVhwS1pKMzdUZVJyME5iOTh3TE05WlppbTJuaVBr?=
 =?utf-8?B?d244SVFXM3BTVnpxL1UwcGJWNlBKUnhUVHUvNnErRkZ0WXNlVVYwTVRNRVht?=
 =?utf-8?B?SlpIWVM5UWYvanl2SzZXTURVcGRXYU1uKzZvTUMvcFY5QSsvTlpFMzkranFl?=
 =?utf-8?B?S3BMckpTM015aldJd20rd2lrQm9UUU5ZN2tRQ3BHWlpCYUthQVU2MmFBMzFL?=
 =?utf-8?B?VHVUdlpkeDErSUozTTBLQnVkTCt2OUF2WXdGNWxyMDBJQ0Evdjd2TWhHb3d2?=
 =?utf-8?B?dVBlY2M0b1dOMTVOdDAyU3gvL3JtckFZTzdkU1IrM3g5RnlScDYxalRhelFP?=
 =?utf-8?B?WFkyZ1R6OGFZcUtTRE1IOHZmQ0tHYmVOb2tLZUtzTU9xWEV5WkJ0Y0puREh6?=
 =?utf-8?B?TG9ha0dnK2R6bjRUd3NkNk1Ybi9pSFAwY0duY2ZpbFNDTDQvNmpPNnpjd2VI?=
 =?utf-8?B?R1lBNzllUDkveTVXbXJhQnpldENML0p5SjJNa3M4cndXOUtRRXBPS3F1WXdO?=
 =?utf-8?B?ZHlUQnN1SUp3dXFJeHRzMDk5TUlmQnJHdFk5eWxKbGtXUHgyWjIxaVBuTDRP?=
 =?utf-8?B?bDVyOHIzOG02c21QYzkrL0QwUS8zZ1A3c3BGdlowNkVQRUpjQjdsVDBmSWpu?=
 =?utf-8?B?U3ViVzdRQVd6anFDY0laeEhNbTgvNkViQ1RPNFJIcS9OeUxrUHZFL1RJUXpD?=
 =?utf-8?B?aG4yc3hGWXBDcEI3MHZkTElSUGpQNi9pWmFRTzNMMERpSFIweDdLaExYY2Jv?=
 =?utf-8?B?bUJHU2VtVSthcWVoUkhmNXBQeTBvNW03bE5tU2lvWHdYcG9SMDhkQ1hhMVFD?=
 =?utf-8?B?cXJISFNxZVQ5bzFXTUxRS3ZQZTNKaEttai9pZkx4azB5WWlxVTl2ZGdzcFMw?=
 =?utf-8?B?THdIdTZhUnZHODVxeWcyWGtmc0I2Y0xuUkVFTGNkZFdONTVZMm9jY0tyZjdW?=
 =?utf-8?B?SU9vQ2hueHA5M1pYaGhZM0RxSE8yMVhmZmtVTDVmTjVia0dDWTNQQlU3K2xQ?=
 =?utf-8?B?TmVsYTlqV3laL29ZZUlLYWxzaUdmSWxsZlBXRFpvZUZUOVlMZFZGTVlYNDgv?=
 =?utf-8?B?TW1jQW9kT2V4aUpwNlJ2dkN3bTRCdnR5VFFRd0wzZS9wU2NDbDFpeGMvN0d5?=
 =?utf-8?B?THkwMCtja0gyL1hmUGhRS0pRay9tUzlnTFpBUkJyTkplWnB0SUVQZEovWEhm?=
 =?utf-8?B?M1BEMEV0U1BUVDN0UUtJbStPWDA0ak5ldHlKU09ZT0IxUzB2NWNuQnZRWEc1?=
 =?utf-8?B?YWtub3lVSUFBRUFSZVNROG01ZzdYNWdhVG9PdlBQTDJBLzRYYkVrRE91VWpF?=
 =?utf-8?B?THluejBrVVducDVsSWxjbStXbWJ3S3NPbmVTZVhrYW1zTjN4d2M0SXY3dE5O?=
 =?utf-8?B?cllqZnc2ZGdZOENRQjE0ZTY5MU9DRzNmZW40S2FmbHEvdFZMMjB5VDVhVVg4?=
 =?utf-8?B?ZlBqSTViR0VwTnNVYmwyWlI2WGtVWUFpM3BPTEtIZlo0dXBYZU8rYUt0UG5p?=
 =?utf-8?B?RnUvU1JCenhhbXprQVNsdjByVkRuNHpiRU5ocEkycG1kVFhLRjh2NDVpN2dR?=
 =?utf-8?Q?s51qwulfD92BVys1kAhAAoyDg1+ISYkw+ZHf8YR4D6A/M?=
X-MS-Exchange-AntiSpam-MessageData-1: KUu84kvrBu1kBA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd64817-b3c1-45c7-aea5-08df02765b64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 06:59:07.4352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19r09TQjjjKHVYis8uk7/zUWOaVYXfvMYBNu6P99dQpm/0eF2gqILfGbRe8GOHOZIJ4XAdQs2jfGOyEYQYZSlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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

On Fri Aug 21, 2026 at 4:46 PM JST, Alexandre Courbot wrote:
> On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
>> Currently, constructing an alignment is quite verbose:
>>
>> `Alignment::new::<8>()`
>>
>> It's unfortunate because it disincentivizes using it at interface
>> boundaries. Implement `SizeConstants` for `Alignment` and add some more
>> size constants (mirroring include/linux/sizes.h) so we can write e.g.
>> `Alignment::SZ_8` instead.
>
> These are two good ideas, but since they are orthogonal they ought to be
> in their own separate patch. :)
>
> <...>
>> @@ -99,13 +125,22 @@ macro_rules! define_sizes {
>>          /// choose the width that matches their hardware. All `SZ_*` va=
lues fit
>>          /// in a [`u32`], so all implementations are lossless.
>>          ///
>> +        /// Also implemented for [`Alignment`], providing each size as =
a
>> +        /// compile-time validated alignment.
>> +        ///
>> +        /// [`Alignment`]: crate::ptr::Alignment
>> +        ///
>>          /// # Examples
>>          ///
>>          /// ```
>> -        /// use kernel::sizes::SizeConstants;
>> +        /// use kernel::{
>> +        ///     ptr::Alignment,
>> +        ///     sizes::SizeConstants, //
>> +        /// };
>>          ///
>>          /// let gpu_heap =3D 14 * u64::SZ_1M;
>>          /// let mmio_window =3D u32::SZ_16M;
>> +        /// let page_align =3D Alignment::SZ_4K;
>>          /// ```
>>          pub trait SizeConstants {
>>              $(
>> @@ -117,6 +152,16 @@ pub trait SizeConstants {
>> =20
>>      (@impls [] $($(#[$meta:meta])* $name:ident,)*) =3D> {};
>> =20
>> +    (@impl_alignment $($(#[$meta:meta])* $name:ident,)*) =3D> {
>> +        impl SizeConstants for crate::ptr::Alignment {
>> +            $(
>> +                $(#[$meta])*
>> +                // A non-power-of-two constant will fail the build here=
 if used.
>> +                const $name: Self =3D crate::ptr::Alignment::new_checke=
d(self::$name).unwrap();
>
> Since this is a const, you can use:
>
>     const $name: Self =3D crate::ptr::Alignment::new::<{ self::$name }>()=
;
>
> Which we should prefer over using `unwrap`, even compile-time checked one=
s.

Will do both of these, thanks~
