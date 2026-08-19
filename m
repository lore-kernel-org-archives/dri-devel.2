Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E82FC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BDF10EE18;
	Wed, 19 Aug 2026 12:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="LLGEE10P";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F048410EE18
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSTZNi6kscekfN+dv7djpNckU1su1XOSdLaTxqEgkfsBghkoIN7FEq1jGCZiZb2Q8mgyuovQWdhQnaMOWPIVmglYDxOhz77YO/sntppGKL+GrCVxwZrIiEVy2Ox6AYRYjQ8hp/4fgNKMX5wtgkaTl5vAkJqeqEF2q3n24UYj6qleK5b+BdV5wRNUsWWNO9iekDvbEfmUI5/VhK6SxWRGOcMA7HChjGJt2RE8BbTlIM0COc2GTlrqkPCOdryXCC6IqJUtAE2T4+1hQf1GfXosMuO4AG+/dIMVuzl0CIKw3SPuzDOauAxjX7AFKXFnDb2x6VHNYS3t4wkgSmlPr24Frw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ4iLpkBuae9Mxy4i/PnPRHeYirc0VuG0g7IO79/TmU=;
 b=NdZiuKtGlwEf5voCRZ2I0sLh4p0keAkmu52FQT3ipb2Uvt4g6R3ETM5eLtEAJy0/Bg1xkZfWy0cF2RrqtIsneXx91bJ+h/lKmsh88Tu0ZMzwvtTxS49cnrbIuWe0Q+QJ24LsSBP7wUlGm97VgXX3626Nwy8CrI3ca5Wy1cyrKzs9u4fLZpLFngFO5tYfLrseliFtCB6Ag0Wi0GX7IeP/FcbBhh+KrRPBzQplQVbr0OPQUG2aIzucP5wr5qcLtYwwIY7J/Dj4R5v7joXqxod5sNhP3b+KUpI+FKwI5vOjofYW7W9FzKLcL3IcT+Mdq62GkS1+WHmyFcqvUHSN28kZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ4iLpkBuae9Mxy4i/PnPRHeYirc0VuG0g7IO79/TmU=;
 b=LLGEE10PWyY9bxDpC0hO82/vGpoqijt9eQy479QPN6sOwiUZC+XHJ5gmygQT2F978tu+9zJjo/Mg7ctgHrxBab4f/sL/wpD6NM+2VuY6GROjSCzo9KzcErb/nNVOXaVwCrtRs45phzTXNgJbxK8xvfSqApLv3VuL7VqA59NJOXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOYP265MB2095.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 12:14:46 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 12:14:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 13:14:45 +0100
Message-Id: <DKSWUS633GRQ.2D3PDBFMZNW87@garyguo.net>
Subject: Re: [PATCH 1/6] rust: alloc: add Vec::push_init
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
 <DKSVRS7UAL9U.3RUTW74RVSEHQ@kernel.org>
In-Reply-To: <DKSVRS7UAL9U.3RUTW74RVSEHQ@kernel.org>
X-ClientProxiedBy: LO4P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOYP265MB2095:EE_
X-MS-Office365-Filtering-Correlation-Id: 062c7c77-1309-4979-b797-08defdeb7550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: S3CcyRIvCUmwmyUCTVKXNPVRqh0qHZGfDYkhQDKU9IsWcSct+B7IWYxFN8XupaUya9zAdksn4beuv/Z/Rdgo6M9ERPasBZ/4jZaqVpttlOga8vdI5lwD/ta3AGnskVYJIiSEzPeDOOrgrN5qBrqT/78prZ67V/pS4nSrzrJsy7n2uh+LxgOL7UTKe71Z9ow4I6SIdxbbP9xh0zpk4XiDEbsHWVRCPA0QW082LGFcIKqN6VkzdnLwIzB8g5aqnHbw1tGGU8HP+cl1vQ2lD5oawKutl3THj6/eGW/GLa6REqJqKiwiy4GhtIrer3DkI+y7995beP0i2p1w+B8bxG8MoGkvj6f0bs85gqYrMZ8K167v6XYC90kEKA6P3xhL+xRdvUMdwmqdBlIGzckt7D07xbIjj5AkwHLvvP3oicu6KFA1FMuSlaDLthYIFjz9Y4iskXIbjgIw+UvfUEecusHgnvwfeRE7SQbcP/tPfugdRT4IQw1TRhJ+xMxcutX8i6FZNqiTk2Fy8mJ9p8wIPgMql3ituMppeu6pOp0hhmsVLrhEaCwOZXO/bp/82ppYRUvRJQbBZSPDXBVttBpq9M8OLVzsebzZ8uD6kok85RCJXR84sJW1RNM6JxJXF3H5uX/p7ZYB4nnAWSRijHMiBtKca2xZ3VGBIX9iq2EeXTQiUj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hrci81eUJ6L2puV3VvcUkyYjM2blVERzhJbWRYNUVMVG9hcDI1WmpnL1Zi?=
 =?utf-8?B?NXErRkNPV0RlTzdrV0tqMXVJQVpYTDFJSE50NFMwTXdveXlaT0JJeVBUSTBr?=
 =?utf-8?B?YnByQmVuVCsxZVJGcGk4VGF2SnlvZkdEd2xGL0N0ZGsyMDFHVlFQODBRMndT?=
 =?utf-8?B?alRwZU9TZ21Ld2p6NEg3SFI5WkhXd2owY1VtaXZqME5WMVNBWFJhWk5SZzho?=
 =?utf-8?B?ams5VzNpTWs4N0tFbXJscDZIdjB1M3VncGU1aVpoN0hmLzlLNEZMSExsbDVv?=
 =?utf-8?B?SUtIbnJvYzU4VjUrM1drbHNZM1JVL084eTRBRUJ0dWtEZW5lZXJjckJqUDQx?=
 =?utf-8?B?RmRGZUtpajlKU0xtdnlZMDZlVHlTL2l1Qmp5VktNRDdvbDh6bjN3SlJQRlZn?=
 =?utf-8?B?V1VzaFcwNGhaWEFSUGRHRW5GYklYNkc0Y3UyU1hzdmRIbjRKYlBtL2tUa1ZP?=
 =?utf-8?B?elZjZkdIOVdMUnlNc0pveG93amwwQXRYdkFFMUwrYk1uc0psOGF3QUtZdlJt?=
 =?utf-8?B?aUVuZ1F2WXB2MFhWdjZvc29XRDhQU0d1alFla1RjMktwMFlNM25nMXNrMll1?=
 =?utf-8?B?Mms3dHNVenJQYnhvZmFMUjYwdk1WdmxOL2FBTytDK1pCZjJaTWJEWGNiYThE?=
 =?utf-8?B?bUpRVEd6c0ZHZ2ZlRzljeURWdGc5NTZmNS92ajJ2eVBaTUZYZFJuSnlpZUdp?=
 =?utf-8?B?MVlKMmJRK00rVDhvaVRHelJlUGNUaEp3NThUODBzOERrRzRjRmdXVGcwTnhB?=
 =?utf-8?B?TUZpb0xHamhiaHJEZzUwOEdYa2hkY1IwcHZZcnVhS29MODhxcHJMdU5oUUFv?=
 =?utf-8?B?a2xrRjdkR0l0eURuVHYwcHdWRUlDd3lOR3ExdGNxRGcxWjlzbTVvUTY4OEw1?=
 =?utf-8?B?Tm9lcy9wVTdNdmwzSm9rZzJtMjdDeVEza1FPWXBBT3g2OUJ4eGJ2cFEyVHk5?=
 =?utf-8?B?SUZSb25tYVQyRyszRHNxSFY3OCthY1NPSmVnYXh5ZndQZHZJeExVOW1vYXdV?=
 =?utf-8?B?blFCc0VVazhyQVFsN29qSG9KT2dJZU1sWnhKeVVLTnVYTDl3WVRYNXZWa2hR?=
 =?utf-8?B?ZnUxbEFQNWFoMnRpY2FKYWcwdUdVb2xoZTZNcnB1SGVLVS9BLzIvVHovWXJB?=
 =?utf-8?B?ZUFMUEtQSSs3UmxLN21wWUpJZG94bGlTUUxzYnMycnpNaDkxUkxySlJDWkg4?=
 =?utf-8?B?QmNxdjdXZElUT1lRbmpadFN1aGpsV2kvdzJzbmxWR2VmbS9sWFlBSGMyMGtC?=
 =?utf-8?B?M2pRRFJ5S3ZBM2VUbVVuZGVBaDdERmFRYm1LT2ExM1VEeTVDd2NOZnRsNjht?=
 =?utf-8?B?bW02MUl2d3lkb0dzdFl6YVdIU2JrbzV0Rm5weFZIZloreFd1YTNTNlRRODI2?=
 =?utf-8?B?QjFWcWd6andMdnRQUmhMcURiaDdCaHdDclkzRkl2QUE0WlczOUYzc3MyS1h2?=
 =?utf-8?B?L1BwbTV5MFNsNS9CNzBzYng4SXZkc3VOTmUvd1M5N1lyRk83MXRHcW1zSGJQ?=
 =?utf-8?B?RDV6SXBxUjI1MEdpSWk1L1FmRnlnMytYcjR2OFhYM29zV0pyaXVYWWhNSEIy?=
 =?utf-8?B?Vy9lOGl6cEo4U0wrbkZOS2JVemhhcnoybytvM3V5akxlUWt0QlBLVFI1YStw?=
 =?utf-8?B?d21Yd00yRzlQWk9FanByR3FFSGtvTVhVbUZPT0ttRDlGSGdKeDhRUVdPS3V5?=
 =?utf-8?B?ZDh3QkdabWxZcXhEbnRWZHRLZ2Y5VExONWpsOU1EaUozN04zRW5pOTVzTzFB?=
 =?utf-8?B?WGJyL1NYM2xNd1VRRGJsZlJ3ckdxUUk1QTdDZDhlMEl0ZnMrY2FZVFpQNHhB?=
 =?utf-8?B?ZTdPeDMwU1Nhc2dqa0NLaXhmOTlKYU5wT25wbG1zR0dtREYxRUtvWk1qUHNB?=
 =?utf-8?B?RFRTT2E2a0Q3MXdJTHpoMkRrR2lHQ0I2ZFc1OHBFOHhYQ01zSlQ4NnRMSFpB?=
 =?utf-8?B?T3M5ampPOFVmamo3VXpMVTZaa0ZiNnppR2FMYXVIenN3RTlmUXVDQVZDUVQy?=
 =?utf-8?B?d3lZdkd2M1YrRHJLaG1RZ2x2ZjZMaVJ0QVU0RTluYUxKWTQ2QzNlRFlXVlZi?=
 =?utf-8?B?Nm1ocGdaam5HVXVKTzZjQXhDRW9jZ0ZObHY3UnZ0R0dreG91YW1SNEhYMUdS?=
 =?utf-8?B?a0YwV0dRUDFybkRWeGQ2eGo3Z0dLV3JHQ0JUa1lQaHZCTHp2UUVReWZBWmpK?=
 =?utf-8?B?OVpxQ3VFWFVRQnVyUXFjUTIraWY0Sjl0bExwWk1DdFg5QjUvSGRScnREVVRn?=
 =?utf-8?B?ZG5YdEJaYjRLVnFobVlUUFlYeEl3Rk05SGpRaEdmMmZ0U0VqNGpzVkpCMURv?=
 =?utf-8?B?R2ZSWVNUanNmZjJmQ1BiNzVqY2VzYkJIZUJPUWh5c3JUNUhuelFqdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 062c7c77-1309-4979-b797-08defdeb7550
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 12:14:46.1400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leIpNm9e62iKblyOQIHSu0nPqQ4EES5FnY92jc9jNzGYOTP36A66Bpk9AypjpGkb6e17beknf56MgDizMpY9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2095
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

On Wed Aug 19, 2026 at 12:23 PM BST, Danilo Krummrich wrote:
> On Mon Aug 17, 2026 at 2:56 PM CEST, Eliot Courtney wrote:
>> +    pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags)=
 -> Result<(), E>
>> +    where
>> +        E: From<AllocError>,
>
> This signature rejects impl Init<T, Infallible>, which is the reason why =
we have
> e.g. Box::init() and Box::try_init() with different fallible signatures.
>
> So, if we follow InPlaceInit, it'd be
>
> 	pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) -> R=
esult<(), Error>
> 	where
> 	    Error: From<E>;
>
> and
>
> 	pub fn try_push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) =
-> Result<(), E>
> 	where
> 	    E: From<AllocError>;
>
> In theory we could also simplify it to
>
> 	pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Result<=
(), AllocError>
>
> and
>
> 	pub fn try_push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) =
-> Result<(), E>
> 	where
> 	    E: From<AllocError>,
>
> However, InPlaceInit actually achieves more with the init() and try_init(=
)
> distinction:
>
>   What init() accepts, but try_init() does not accept:
>     - impl Init<T, Infallible>
>     - impl Init<T, E> where Error: From<E> but NOT E: From<AllocError>
>
>   What try_init() accepts, but init() does not accept:
>     - impl Init<T, E> where E: From<AllocError> but NOT Error: From<E>
>
> So, with the simplification we'd technically lose out on the
>
> 	impl Init<T, E> where Error: From<E> but NOT E: From<AllocError>
>
> case.
>
> In any case, init() and try_init() seem a bit mixed up on their purpose
> regarding fallibility and error type strategy, but in order to really cov=
er all
> cases I think it is necessary.

I think this might also be solvable with a new trait? Something like this:

    /// Trait indicating how two distinct types should be unified.
    trait Unify<Other>: Sized {
        type Unified: From<Other> + From<Self>;
    }

    /// Types can be unified with themself.
    impl<T> Unify<T> for T {
        type Unified =3D T;
    }

    macro_rules! unify_rule {
        ($ty:ty; $($o:ty =3D> $u:ty)*) =3D> {
            impl From<Infallible> for $ty {
                fn from(v: Infallible) -> Self {
                    match v {}
                }
            }
           =20
            impl Unify<Infallible> for $ty {
                type Unified =3D $ty;
            }
           =20
            impl Unify<$ty> for Infallible {
                type Unified =3D $ty;
            }
           =20
            $(impl Unify<$o> for $ty {
                type Unified =3D $u;
            }
           =20
            impl Unify<$ty> for $o {
                type Unified =3D $u;
            })*
        }
    }

    macro_rules! unify {
        ($a: ty, $b: ty) =3D> {
            <$a as Unify<$b>>::Unified
        }
    }

    unify_rule!(Error; );
    unify_rule!(AllocError; Error =3D> Error);

and you just need to write

    pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) -> =
Result<(), unify!(E, AllocError)>

This looks like a lot of work to impl, but realistically this is just an
additional trait impl near where you'd the put the `From` impl.

We can even provide an attribute macro `#[unify]` so you just need to stick=
 it
on your `From` impl, e.g.

    #[unify]
    impl From<AllocError> for Error {
        ...
    }

would generate

    impl Unify<AllocError> for Error { ... }
    impl Unify<Error> for AllocError { ... }

Best,
Gary
