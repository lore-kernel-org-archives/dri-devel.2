Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E5B1099B35
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 19:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B2E10E161;
	Fri, 20 Mar 2026 19:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="W6wn7blq";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020100.outbound.protection.outlook.com [52.101.195.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7363310E161
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 19:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lin0FognQAQjTosVbwWMcmjDP+N2lfShCF3dEyJS8BY0kjzvgde/mdj4Zg8/sLBFNrm6nW74VlzMp3E5AzzABG6GnsF2YG+fBfOIWPZ6ixETff1qnJQJROwVLMuR8kXHiU7tJ5o3pYF5r3DB6BC3v2Zo0C0C1TA1Q/6vxWJ4vibNSA7v8KqijsCRVkt8uLoBJP/fvjeh+JSljmOXNSu7JUW7CF2AgLy6OoRzmwioTgdJ+DOEK0nQ2jJTi5RsioOIceT9Bdck296waY34J7490Qsu8B6EsY0xQB/arIu3pVhIToMCj1lxAraWnGvMY0ENiiFqrBoQfW2s8+ZyfvA1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/3cY/59i6MG5kFyiHxdyi9ZDgj76x2aQFf/1WTRbos=;
 b=c5KUDVwz+wGklC6J2zJDWyI11nojmsmX96thkbvUGRi750jyda5Uv/PygevtAYjmM+DzP0r1x/LYNxWsjPyheqBqFxife14qy1S1xBI3CAV2xCyl4qps3isCnTAUqkBeaHLgcQDQ81PO8W7G26jtixalZ58oKkHnuOSrHUh2tOFNUa6oP6NGh7LPTZBGbA+oLLxvaWzodkrqMwqgO6DfxHSPEkeN7gzBRyHMLFjl9ePjJaeHOrsQjzg3SMlXc/Sy9mVAMvZH6GEy43JYim1bEKSzpQ2vCaoNrWMEUe9Z7uk4emJPc/XGN0bTet7yfTzTM9fFmch5Wi6SweDGnWcOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/3cY/59i6MG5kFyiHxdyi9ZDgj76x2aQFf/1WTRbos=;
 b=W6wn7blqFZy2TmOdPEGNRSGaGoF/DgVuNGiJHxCAI2CTTAqHeOoMz6wbcyF2GbFVu0qCgfoSeDGuQoKwVmfHdEzCnfVvMNB7GPXxuoRMBSKbu2vfoPu3VwSffX5CnBEwtzGZ9n+mmjVPGY7TuAOy7iDfWPmU59xO7yp6JysFdHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6349.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 19:08:55 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 19:08:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 19:08:54 +0000
Message-Id: <DH7UH2ITPZDT.E1DWRAW8891O@garyguo.net>
Subject: Re: [PATCH v2 07/10] gpu: nova-core: falcon: introduce
 `bounded_enum` macro
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
 <20260320-b4-nova-register-v2-7-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-7-88fcf103e8d4@nvidia.com>
X-ClientProxiedBy: LO4P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 494b424d-9acd-448f-7304-08de86b4218f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|10070799003|7053199007|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 2EyKXAdZ8W90GivhK6jvhUUrJtEtla8lm5fbVT8KACzIUmI8TtHRds9EAMIvUQw4QFB+T9h0jxndz0zfrKzCy52gFsSFkt/y5ZrZ6iTqh3AmcpWor+uxFacDf+/zAoaCdllRdbMf1p9QowEICZFkogwODKQdljlwY5+R7xvJNA8Qf+ENOWrNWK6lu1FziJqxEVS2u402d6e+7VTnJXPms9DU9AI/AYWKWZMCwDwfzWst5LxBxz31StqMEC1kvhZEQUgWLIx1c7vdoPtgEQ3IwYS4ibKkobFdp59quhRiNFxTIxjDWDjQqjn1v0UMLFuFAMSgWj1YIZ8WuYF/wT6Romthm96f13gEn2YsO76Pqs2tFbOkYoV9HdF+aSaE7FD6cXLSQ+PhVGpkpXBdekc4MprpISrIgAJBRI0EinOdGO6sdB2cXKEdJhN1qRlPvuXDS5jUK6ULlU9Z1amGcNh/Jog5jo75rOgnOW2NU27kQf4bwUgpx+BGZBfr7Tq8FA573Mrg9kfz56pMw8CtS/lF3LTA6XvGLyB1Krk9usEj5Br/Hu/fMLeRLuoW9cQwH2hG2j2EaQ+SXBMZocoHFhZe8EhMD3HhXbPqJkyoWrKRFFR57PZksY/K6jggQNOBcGsTKoky4E4mj4+EDCFqhKy1+CRa1vYsTrB4A9RiwIQC5EUO4TpYz0GTDo1H7Q9EQq1c4Rfey9gSTZP92qd4MeH+qhJgiiIrJVM1zD1qveVQW6D4jfod9lCSYVnRU+knhPUE4oD9BrgAYwoiY555YwPymw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(7053199007)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0JoYjhHTFBDTXJCbndRL3RERG55ZVhoRXFLT0JUb3dPMEo2T3FESC8xb3I4?=
 =?utf-8?B?L3hreTVZRHU0N2t2R2hMZkN1RFJWdXU0SGZad1Q1cVhOOGQyeHZYc3N4VGtY?=
 =?utf-8?B?U0tvalIrYXAxSi9raTUvN3Q0d2dWL0VrMFZ1aXFPMjVGOUcwbGFKRCs2YnZI?=
 =?utf-8?B?UDl6ODFtZWF5QldjSjdpZ2pncktOcUY5dzRxeFhURmY0a2VwbWxwK0t1bGxv?=
 =?utf-8?B?cFVoN2F0R0RMTnE4cEg1bTVnSE1Pclh6WW1SRGNWZisyM0Z4Tm9Pak4yeWJi?=
 =?utf-8?B?a25IZUU4Z2g3ZnYzcVRwMVhYTzJPcTlZMkk5N0ZKSW9pemZVVVNzaFNrV3BX?=
 =?utf-8?B?azZFOUhYYUJpSmMwOXV5Ri93QjJ5NTlaNEw4cVlVUWwyR29ZQW9ONHM5ZnhI?=
 =?utf-8?B?azN1RkEzOVZkQzJzeWk1dVhzbHN1VktnOTJINHNZVnRyU3IvcDVUcWJ0UEh1?=
 =?utf-8?B?aEZ4WlRaaTVOSWRGc1hOSkVTN0hqZ3RiSE8wVU5sZmx0NnhWNHg2VVM5NW9I?=
 =?utf-8?B?WCs5VU4ySDRTVUw5UzRnb254Vlh4bVJqSmtLdWhoYUJ1Tkt3dmhxN2tRRm05?=
 =?utf-8?B?MHNackRqV0cxb0JxSkQ2NVcvTjRTZ1V2UjZRYlE2WHBvS0l4MXMxU250cUpi?=
 =?utf-8?B?d09ZdXNvOFMrZTE5cHpiSjZQbHJOUm5iYXVzQWx2NU1GeS9ISlVTUTF2U3hU?=
 =?utf-8?B?NVBMdUlJN05zMVZFcFdNelExYjVCWG1EQi85TGNKRWROQlNPSkVXVVlzZEFQ?=
 =?utf-8?B?QTNRT1RQWXQ0Tnd2TERsdk4vdWFlK0FYSU8xNXZMcHc5dk5HQ3ZydDF5bVpz?=
 =?utf-8?B?bU1XNlF2ZjM0WVU5d3YyUmVEQTdVNmNUL3dOTzJrc2FjRWc0YVozb2Exekd5?=
 =?utf-8?B?dGRzd1RUM1V3N0JMT0ZGeFQwSnorTEZYTFZjb2FXSGFJTjcxSkowNUk5Vk9w?=
 =?utf-8?B?aTJTdmZRM0F0NGF0Wk9Qd2pDRHhoOXc4TG9aeTIvOFI0UWs5eDJzS2cyeU9k?=
 =?utf-8?B?bHlhcUIzWHB2VFN0cG9SN1RUZ2QrUGhrZHZUejJsRVliN3pOOENrVUp1WFdt?=
 =?utf-8?B?VW9zV2pRMWc3azk1dHkyZ3VhdGdqT29YUzVaMXFCb2lrd3dObi95WWpIZDF6?=
 =?utf-8?B?RjY1enZpbkxCNkVWNzBwZTFqN24wOWtMSnNMVTZSbWJBekRPeW1zSStzbVVX?=
 =?utf-8?B?d2Jhb3gzQWNKY2dvMmE1bU5YcC91di9LQ2tQTnl0ZWdoTFBKbUJUSFZPak9y?=
 =?utf-8?B?Z28reTUyZXhtVXJ2R3BHTWc1WHp2TkpWb09wcm9idStWQmNsdDE4aFZJdGFz?=
 =?utf-8?B?RStEN3REaUVkeXVlRlhWVisrWXZ0VVM4Mmx4UjFJSGJRSGpudU1lY245aWls?=
 =?utf-8?B?ZUpSc0xXZU9QWHlLTWRwWTZBSjdkbk1ybzcvVWVvNHlUaWMyVzVabnQ5a0FV?=
 =?utf-8?B?RWdpU1dQRXpESk5ZVCtOaGNUVEJLUXp4WDBnU1R6aENZNWRPaGY1a0ZGME5U?=
 =?utf-8?B?dHo5N0V5QVFvOUtqbmRqL29TcDgzbWxJREVUTGZFR1VVVnlPRThkSWw4eFln?=
 =?utf-8?B?dE9vVndjYTVsSUJsYWRvQW9VU1VlcncvNm5QV1VRSC9hWWFyMjlCditqd3RH?=
 =?utf-8?B?cnhqMTJZcnJ2RjNYTHRid2pmZmUxV1VmM3VMc21xUWFxT2RxSWlMbFVLVmdY?=
 =?utf-8?B?QzlDazlGMm5mM1RQa1ZkUmRvUEZlZWVIcDY4aUIzNTZ5OVlJRjRLVkdMN3Fk?=
 =?utf-8?B?Sy8zczN5NW8zQk03VVVGenFJWlc1ZE5pVkt1QnEvZ2tjaFJqVjBOYzh4UUdR?=
 =?utf-8?B?NS9oU2NJZnYwUEtjYVB5cm8xb1hGY1I0TjAxYi9sMkVkREF3WldHZ2JyS1pK?=
 =?utf-8?B?VWE5VmlaL1dVV1RJTFc2anIwQUNLVWRzR2NLSDdnNTY2SE5MS2JDemlxdnRu?=
 =?utf-8?B?NGU0RHlXcmsxL1RqeUlKeEorb1Zmb21tMFIvdkJ4NUp1dTgvWHVMZmxiaUxi?=
 =?utf-8?B?SlpTa3lKaWVYN2NQVitpMlkzSHU4aHRjbjk5S2RNd2lxNS84T3M1OXBXbHJ2?=
 =?utf-8?B?TjhWVkJkZ2lXNWxWTVpDYW5FMzlqdGt1eGEwcWtQcEMxNk8yZ1dDRTFVSkR1?=
 =?utf-8?B?enRtRkdGVHNXOG8vRmNobDFmU3BldjJ1OUF5RExCNi9RR0pneHlEZStCSVg1?=
 =?utf-8?B?UlNhVkN1SUFLR2ZESERXTGpJdStzcXc3WTIzREVLOGk5ZGRpU2tqVFBjVnNQ?=
 =?utf-8?B?K0FhVFV5dy9jY3dvSTVSTTE2dUhOcGp5aGt5MEgydnR6cTlqUXpOVUpOanFW?=
 =?utf-8?B?USs2dWVucDh5QWp5NDJpZUt3SHlKZXR4ZFlvUUxtNnA0eFdtZVFxQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 494b424d-9acd-448f-7304-08de86b4218f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 19:08:54.9496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHjTpn8Ke68yQy52PVmWus4izQ7Bx+MohL2V3zbv/DO7SCFxhy4wa6VQ8CG1Yyxxw2JbEZWROJ/tQO/kMsXnoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6349
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

On Fri Mar 20, 2026 at 12:19 PM GMT, Alexandre Courbot wrote:
> Introduce a powered-up version of our ad-hoc `impl_from_enum_to_u8`
> macro that allows the definition of an enum type associated to a
> `Bounded` of a given width, and provides the `From` and `TryFrom`
> implementations required to use that enum as a register field member.
>
> The next patch will make use of it to convert all falcon registers to
> the kernel register macro.
>
> The macro is unused in this patch: it is introduced ahead-of-time to
> avoid diff mingling in the next patch that would make it difficult to
> review.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon.rs | 82 +++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 5a4f7fc85160..5221e4476f90 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -54,6 +54,88 @@ fn from(value: $enum_type) -> Self {
>      };
>  }
> =20
> +/// Creates an enum type associated to a `Bounded`, with a `From` conver=
sion to the associated
> +/// `Bounded` and either a `TryFrom` or `From` converting from the assoc=
iated `Bounded`.
> +// TODO[FPRI]: This is a temporary solution to be replaced with the corr=
esponding derive macros
> +// once they land.
> +#[expect(unused)]
> +macro_rules! bounded_enum {
> +    (
> +        $(#[doc =3D $enum_doc:expr])*
> +        enum $enum_type:ident with $from_impl:ident<Bounded<$width:ty, $=
length:literal>> {
> +            $( $(#[doc =3D $variant_doc:expr])* $variant:ident =3D $valu=
e:expr),* $(,)*
> +        }
> +    ) =3D> {
> +        $(#[doc =3D $enum_doc])*
> +        #[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
> +        pub(crate) enum $enum_type {
> +            $(
> +                $(#[doc =3D $variant_doc])*
> +                $variant =3D $value
> +            ),*
> +        }
> +
> +        impl From<$enum_type> for Bounded<$width, $length> {
> +            fn from(value: $enum_type) -> Self {
> +                match value {
> +                    $($enum_type::$variant =3D> Bounded::<$width, _>::ne=
w::<$value>()),*

Given that you're having `$value:expr` instead of `$value:literal`, this
probably should be `::new::<{$value}>`

> +                }
> +            }
> +        }
> +
> +        bounded_enum!(@impl_from $enum_type with $from_impl<Bounded<$wid=
th, $length>> {
> +            $($variant =3D $value),*
> +        });
> +    };
> +
> +    // `TryFrom` implementation from associated `Bounded` to enum type.
> +    (@impl_from $enum_type:ident with TryFrom<Bounded<$width:ty, $length=
:literal>> {
> +        $($variant:ident =3D $value:expr),* $(,)*
> +    }) =3D> {
> +        impl TryFrom<Bounded<$width, $length>> for $enum_type {
> +            type Error =3D Error;
> +
> +            fn try_from(value: Bounded<$width, $length>) -> Result<Self>=
 {
> +                match value.get() {
> +                    $(
> +                        $value =3D> Ok($enum_type::$variant),
> +                    )*
> +                    _ =3D> Err(EINVAL),
> +                }
> +            }
> +        }
> +    };
> +
> +    // `From` implementation from associated `Bounded` to enum type. Tri=
ggers a `build_error` if
> +    // all possible values of the `Bounded` are not covered by the enum =
type.
> +    (@impl_from $enum_type:ident with From<Bounded<$width:ty, $length:li=
teral>> {
> +        $($variant:ident =3D $value:expr),* $(,)*
> +    }) =3D> {
> +        impl From<Bounded<$width, $length>> for $enum_type {
> +            fn from(value: Bounded<$width, $length>) -> Self {
> +                $(
> +                    // Ensure all enum values fit into the `Bounded` typ=
e.
> +                    const { assert!(
> +                        $value < (1 << $length),
> +                        "Enum variant doesn't fit into assigned `Bounded=
` type."
> +                    ); }
> +                )*
> +
> +                // Makes the compiler optimizer aware of the possible ra=
nge of values.
> +                let value =3D value.get() & ((1 << $length) - 1);
> +                match value {
> +                    $(
> +                        $value =3D> $enum_type::$variant,
> +                    )*
> +                    // We land here if the match didn't cover all possib=
le values for the
> +                    // `Bounded`.
> +                    _ =3D> build_error!("Enum doesn't cover all values o=
f the `Bounded` type."),

Given that the length is actually fixed, you should be able to use the
exhaustive check instead of `build_error!`:

    const MAX: $width =3D 1 << $length;

    match value {
        ...
        MAX.. =3D> ...,
    }

This way compiler will complain about non-exhaustive patterns.

Best,
Gary

> +                }
> +            }
> +        }
> +    }
> +}
> +
>  /// Revision number of a falcon core, used in the [`crate::regs::NV_PFAL=
CON_FALCON_HWCFG1`]
>  /// register.
>  #[repr(u8)]

