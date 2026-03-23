Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D73FC72D2
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D24F10E3C9;
	Mon, 23 Mar 2026 12:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Tcq7pmRu";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020098.outbound.protection.outlook.com [52.101.196.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADD410E3C9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 12:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ+zDgQN9AgDdKjPWUqGdp5T6B6Zy7ykdrzZeGvl/8sF/8PM2q06IbzyH0+JYCKnVmBnnouTB9f1qBTLeKpczkerZpiZ5WfuJP9kSPpWL5d9Zzpcide09tPTFIRqldN4F1fqQKjRQwOhsmPWyBbKG9wJtnTyKkb60Muh6OE43HBHOCAO1oN8+GpVHgn0L8Y7pmFdQ1j9wxCD3Mx3LDG4pavRChO/itD8FNfAmvqMXFmzY5+8jyn6jvMUczNZbnSWjhsoh5U1ujVQ0y99OJVttwAB61EbjURFoLuExnlQacbwCgVamu85di8pr7KWdpklyIRAVdJHC0isfMNGQuz5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR8+u+cAuJsmmguW2NRNWGYeAwE+ccXvj69/LwsFudk=;
 b=NDxmKImb7gtjUgpc/oFAib/hlgBm42pE/OCluAYZ9xB4yekaLJA814jdTqWtCGuA+IUtJ/flppkKDezRftdj/I4DSKwlx9kuzxEnKjcH27I0HPj1rGHFXzf9ykX35h/v0C+ZYFVvMXF7YnbIp5+nXQUA7ZLKyc5DPxX5vVjlu+eG+UPIhwsfE0nQRSXrvAaQYV4KVfyKTWceonTDeRH31s8usUwEzPXLLNFJeXc0g4tIVZmQOzhaK0cFRmSsSoq/kjscB6D7vLZZWm49BPLqBipM8GgEs91ckqRkyrDUzibkMaen+nstXfkaDUCEdOCbZNQVGYeeilTfMCKHh/2O3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR8+u+cAuJsmmguW2NRNWGYeAwE+ccXvj69/LwsFudk=;
 b=Tcq7pmRufykJmUbGpXj1Bxgr0mibkygcXwFcoDMXWEfVM3lFsOUrBFJp8oFDsWuXklOeOtkZ7bOz/Ha2kRWV9JcRda/oN5mR0i1nMiViLV/emv+WN+aUtv2HOwAbAvg8CipYhF/uXfoq9mwpgQhIwwmLfbCNKkteQZfUYrNSxII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5547.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 12:43:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 12:43:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 12:43:42 +0000
Message-Id: <DHA65RY78M31.20BCCF00R67TH@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] gpu: nova-core: falcon: introduce
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
X-Mailer: aerc 0.21.0
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
 <20260323-b4-nova-register-v3-7-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-7-ae2486ecef1b@nvidia.com>
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: d8660fc2-31fd-47a7-4337-08de88d9d101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: eutzm3XoLpldZXw3974Or9zVtcwC8f1HtUxuZf0GaOPNzv0OAbghwHFntrFJRNy9B3n1RJR8HQh2p93dHxlV/31kVsFKzmfhPbWo7xEGcPjF+0X3N8LF9gTnoyZOPy1XG5og/QvZuj3hQtdfI5yfsl3sqwmoZ1MG/df8c5nrhAdQX5Hp4akiMkcwmFaX+FVBkWJNYgJX864aB0Ix8veiCrr7wTXTHdAdrpyUl+rUN+3MkTuQTUrlcJKFJoNxG8DDdYayWFWQqjIDQ5cvQZRqgPEJd7r/RE5OPOJuzMKCKpvDVJSCKieqto8pvZL+UTLEpdsdIqkyDyEw903gskEsZRb/w2hIzhg9EOXBB5FSPRqcqULxzPzC61eCh4t4/xOTaxFlBaWwn7XVtqpbS4aVWqypyL/rDtyhMzufuEJQaewWjIwGma3t2J/P4Q8lVeJrmQtw7Yj2k06yBFnGnhOmX47C85JQfDSONk/blEMvYxwPyeOCeEAcFWCQ+Tq2ifZytEpcpKqWtNatcrLpbJHRRTOOq2HX2DzBTfvfpxEA8WC9WiawsTO9z5L8ApLM5rFG7nNJ2UrfRdtz841ijgrJd5IP5GfMaL20OyQEmbxCV9zLv+d8aLeCBDlfNeUffcYW0d7uOz+p1/cVCY0EPvOmgnyY8jUDsBzFkfjbiP1FNdv2TwVmBtuBfzxiObNJLSN62wjetRgjvssrwOY5CeOSGJ/mrVsYuofb97/cPWw+ZFBc6SO/Aul0XGdHGr2gU9XX/Q1qg2tFZM+rxAiu35Wn8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1NOUVWYkdHRFR2NXFmeUd0U2R6WUJXaHZtbW9sTEJMSEhPQVoreCtiWldG?=
 =?utf-8?B?Y3FNVFdUWHJ2R1A1aisva09jUU9FMXF4QlRobU1aczB1aGIyRDFXSlR3aDAz?=
 =?utf-8?B?a0hpdmd0NW9ibStYK1gzMERiSytDTlhpVVNtRFhXYWdzeU5GSjBhWkdubHZi?=
 =?utf-8?B?TWgwOGprNFpvRlEwYlVPaVBtcnExWDdLZSsweklVbzJrTHNaTHd3MFVtMVZw?=
 =?utf-8?B?VEhuend0b0ZvK3dNUXg0eDRicG45UnNSaFkwOVVONlRBOWJpZ01kOCtzb0hs?=
 =?utf-8?B?LzJ6UEZQTUNBRENzakg4cG43MzFrZWJWQ2dRTjBUYWZyNmhvY3pkcExsbGRR?=
 =?utf-8?B?YUxMQSt2aWdHSzF1NG1ZdDBDS01mT2pUWm93a2Q3cHZLUmpnaHBad1VPTWZE?=
 =?utf-8?B?RmVzdEtXSmJwdm1WS3FzMCsvRURyRVZEYUZYN3cyaHJZYWJWdmd4Q01nMlBi?=
 =?utf-8?B?cFI5S1pGd0wwaERzUnlkMzQ1dUdiZ2hkWXJvNzMxT3k5YUZ5eDI1VVRLanJk?=
 =?utf-8?B?YWZxa3VMT0h2aFlzc3M4MTdIMVp4S0FiZEFhQ0dLMkxlUTQ2aWd2RU96Tytu?=
 =?utf-8?B?KzZKQnZEOUxsUHJFUDJGczFBSXRMSllFeG9sTTlpZkIzWm14cVZDU1p3RlJP?=
 =?utf-8?B?ancxdGpveVVSQ1p1cXNSeFBKWDFCOHRFblZtRkN4b2dlQ2NsY203THpSRmlS?=
 =?utf-8?B?UWRwYUxBRDJZUlFCLzZodXpGcE5WMkwvNXZTV2RrNHp0d0xSSG5wRHRLYlR1?=
 =?utf-8?B?eTNGVktBaFlVMVNhbnUzblJXeERaNVE5NThlbDIzNy9renlheFM3L05heEYz?=
 =?utf-8?B?Q1I5bGM1b3RCblE2SGJuWjhXbUkyWFhzTXJocFdXeGQzZlRYczB0YVNVaWpW?=
 =?utf-8?B?b2dZbERlRGRXTVFucktSQ2R2Wis3NE1pZEZpVlRvamFMeVZQVWM4bjlObndP?=
 =?utf-8?B?MUZnTjF4bXFGaGVXdzV4dEx0K1JrNmhUcXBTTGphTWV0ZXErU1hxemlrOXoz?=
 =?utf-8?B?bUJ6WHg4M1VaUHJLKzg2WHQ4ZTdldlphaW1tT1lXY0xoZE41V1g3R0tkSU11?=
 =?utf-8?B?L3lyaU4vdlNBTEZYSVNYUzJ1NEtDSU1iYTBMdDJaRUwzWFhjUjdzckNVa2Ev?=
 =?utf-8?B?bmlSRVlPcHVhU0FNM0pHZTVmZ3ZJdXpVZXRZMjJTeWxZLzExR2pYQ2N3eEk4?=
 =?utf-8?B?RXd2MS84VVQ3YmtGUVMvQmNIazlVY2hNMjluRXMvN0hzc2FRRnRLWENLZkhx?=
 =?utf-8?B?aXBnUVNjenNyT0kva1BHd05wVHNreFFEOUdpMDNlaUE5UDFieFJkRHpBY2ls?=
 =?utf-8?B?SEtlcEJ4eUhtZUlwb0ZRRmhQbFNxRGR2eXk5TzBOYitnTDZxNE9YOTN5a2Ji?=
 =?utf-8?B?cjhuN2hKTFQyY0NiWlpIRzc5eERLcjNFc2FGbmNyUDZpdHF6RERVRVJPUkJo?=
 =?utf-8?B?QUt3c25PQ0NUaU5xbnBFYXhndHdSOGVCQmRoUkhJSnd3bGNhTndQS0Fzc256?=
 =?utf-8?B?WmpnUXltR0RZVjI1MkMwR0VBVEhEQXlQQ2lyUUF4cGoxdHMxRlFZODAraGpr?=
 =?utf-8?B?S1kvMWU1T3ByWHhialU2OTlqaFJTTGhPOEkvS2JOdURnbk1XY2VZWk82cWVl?=
 =?utf-8?B?NDlTNlRmVUlxa2hlWFYyRTZETWc2bGZIZ0IvMnlCN05SMUcvOGQxT3JweERv?=
 =?utf-8?B?R2U0ZEM2UzRjRmd4VitIK3dxUzVxd3FxVmVTSnI1eEdMSEt3Snl4R2tHUWx2?=
 =?utf-8?B?RHRzekJTcUt4UEU0aklvbHIrMjk1OFl1UlZ2L3Z5UGc3OURIS0tXRjAxTlpv?=
 =?utf-8?B?bzZ6V1dpQS9hUWtPUmI0dEduT1E0d0pVdVRCbVA2azl0Zk55WHlBczM5Tm0r?=
 =?utf-8?B?TTR3S094OGVieGlNVkpJVE9vNStRcG5NR0ZTejFWRGtUQmRwZWZ4VWZ4L1VR?=
 =?utf-8?B?WU05TkNrRUo2NmRJR0x3TWVUOVFudTRzU0RjYU9aQTYwRjNtbStpOGdvS2tl?=
 =?utf-8?B?UWJBMk44L1QwakxCaWZYcjVBL2EzNUhZVEpxODNLN2xKc0VUYlVLcUdabWRk?=
 =?utf-8?B?Y0JIcGNtL0ZRNUhFUWxaSHB4blg3TkxSZ2VaMXRMbDczK3ZOQ0VkbUl5RG9H?=
 =?utf-8?B?bk9JZlB2Ujg0YlE0N25tN2RUT2NpM0F2Q01HUnlTOVNQSkpvNkJ3L0d6Tkh2?=
 =?utf-8?B?WWk3MHoyTUxrYlczMmk0aWVvS2V3UVU1eWVVZFJGYXUvVXRsWW1HNW5ZaC9u?=
 =?utf-8?B?Nm9OL2JydjdoeXBTSGFSWjhkS0N0bFQyVXlLTldLdzNnc0FyWW9nOUpYSG1z?=
 =?utf-8?B?VkhPelduczE3cmVjNkdrcXpMWEh5aFU3KzhzVllIWlY3WWVUUWZtQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d8660fc2-31fd-47a7-4337-08de88d9d101
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:43:42.9833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIhx59Pv5rxFI3Gz1nBApIaW11BVTxkdRTNHS7ATx1JFAHf+E0fMGTp65GV+U9b/7/w+NQr//shxGye1evVawg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5547
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

On Mon Mar 23, 2026 at 11:07 AM GMT, Alexandre Courbot wrote:
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
> Reviewed-by: Gary Guo <gary@garyguo.net>
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

Hi Alex,

This looks exactly the same as the last version, without out the {} and MAX=
..
change made (which you mentioned in the cover letter).

Best,
Gary

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

