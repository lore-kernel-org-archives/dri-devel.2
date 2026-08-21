Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37F7C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA2210F25E;
	Fri, 21 Aug 2026 07:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nVrmlfHO";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A416910F25E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if8sqheJuNpbn39nok0Cxm/vQ0BsqkdSmGreqiuz4+J05WeOf+YiKK2a+Rn/ZMxQf2UtGqrSNVAQHW1fOqaveWJOl7w9JUeMAoW2EDl043g+9Qnb3B1U9WEMzqe0sQjPuRnnQvHmYMMpfSUFovWbQ8hzIIyxGTjpRZsPJ6mE5lE+zA9jxhHGdKswCuowt8M5Z8wjZJauX/5rxnE+XIcvqPiM9AiZCdwWwAuR13kbla26WC4j4xmWIxS/6bgJz1fbCoXAnEMoFUKuFPL0raf4sRlxsYQBuEqxye3zMppDKswM2/nnxwPh+qE++Y4GQWRJk1xv0poxZr0PdZnelFIsXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnBokTQMmQwYG6edJSKb30EXcHmVHDPmzn501Wtfcfs=;
 b=V/tHUC/CJ7j2JNoFz4PCFcmf0xU2yoPBtWZ3gXcz+XMNCskHUb/Z2ws/2szEGSIyTGbQmekwBUe0751qUZNvncXxh4X5G3zMcA5NmbO5YvqeMFkyl+E4aSGNOT0PhrvnlwIIHDWGFHHqmHqi3oC9Pw/0zRjsdS7rb59RBBQMcv0LoUkP1EkSJAoaUNBzGpTDtNi+G3pv6dTVmEC+hWzT1KBJ+H79MFV64K2ko6nvQnOfORNNi46TDy1o61h1mL3VaSc4aHfI8feJhNVVBnqpPyPxn1pyaR3OonkELYWIH+IjpHcPgLtaWe9j6OmVXmrD8jDUtBE8CoB16+gOpy1agw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnBokTQMmQwYG6edJSKb30EXcHmVHDPmzn501Wtfcfs=;
 b=nVrmlfHObC9lGK6I9yyBXWK6E+fsJrDtToJNcGSfX/V7cLrjxQ7sSESS+Ir+PZjIQtYgJkoH6vmF6OJmiikx5ylDxkHqrh4LD9YYnSQG6OVyXcItJp6O8Vbyz967FiGHb2yKHr7+JDwiuuNgbmWFeITf+tP6VR4nuy+rlVcrT7Z4Eklmv3YriKJnaDdWQiE6ayYMI/+LjJpJUrjuyH9Wu9iIcJ2gk6YMZIkBlrnc0dlSNnTMA4ZBPy56B4vbOIWSz5C30P5tZVs7W6O79MfSd3K4vs7qyXVwq/wYjyU9zEu8KPItvlgZ2SVngX9MzJwU+iyd6A3EWJrgBUOPg3l8Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 07:46:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 07:46:28 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 16:46:24 +0900
Message-Id: <DKUGEEPHSPD3.DCDP1WRYE6HF@nvidia.com>
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 04/10] rust: sizes: implement SizeConstants for
 Alignment
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-4-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-4-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: OS0PR01CA0183.jpnprd01.prod.outlook.com
 (2603:1096:604:1c5::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: a863554b-6ac6-48b6-8897-08deff584ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xnBCAI/7ze/qd8DEfuPLZF3wQOjKuBPuc3AqXKJ5HPTH+Fx4wg9H2qeBO/uMlSNhnfl7LomcGIFYhb/Oc0WZb8iUQaoiRKBqnsjBkG4l/AmiQkTCZSL8RviPQsQdwz9EgrjrxDuifX+xYT8UB50o9l6isKAXTEU0jTpTR0XyH/BI+WNG33O2xbp0HJ4PsWgm7WvhczXaMLJh+G046+2kKtDed8BoGpSUUk59TWLy0kknEYeJUTDYfuGRDbjeHf9/HdjqWFV0oWhptXCpHH9g5PFHNtS+7M5UGkaEvM0vLiBt4A4NH01X/elUb4cUw54wUDXJ3YYRmdKYLBpTZlNbWctFtFQrFlcct5Yh7CK3OWn48yeGUIE4b1/fvMj024a+q4OhxrcXZsT851LtGRnw+nHf3baq7meTTkC//XexqDl/LtsXIwEohj+5lx80WSyYq3btgPYKj0mcHECCUFec2DY0O8nM4M8V/71XiDjon9gqjjUNKoKLkkRJ2McqENVjY45aEgswAU5WWHOqwOSO4A5ri1YMojLKbRJdZmMgIP07jhUwqBezsaR3bHD4FezB5/UOgGCRfJ35qLj04xyUDBXrBwpXMPAFnXvAVPaZFsKrqHp2qawvvGPhMHPT9R7NGDG8bjsRqS7gQwOw7RtLd2U2JlvSBvf+hvPNkX0VIWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2k4Y2FsbTN2UTBtaUdUclhDRlgyenE3MW1CN0NMYzJxN3N3QlA5eWF3a1pB?=
 =?utf-8?B?ZHpVQzZ6TGx1RnZDaStEUlhmTGxUdDRtcEtJOEJJMEVTc0cxQTJscTlEMjFK?=
 =?utf-8?B?b1ZwUG5pY3VVNlRpNjV0dFRmaFo0cC81TWw0Zm42bXdZdlN6L01WVmRiQ3F3?=
 =?utf-8?B?aWxTKzRlSlYyUFAvRW8vS3hFbUNhVFhBd1J1bFlrVVlJYmhYSlNpUU9oMDk5?=
 =?utf-8?B?dDRoaE4rZnpWSXVieGlzNjBld3RrQThZZVdUYnc0S1lVc1d2VFJzMjR6Tm04?=
 =?utf-8?B?SmV1bVBPV245ckZpbk8yNldMVXBDUm02UURkM3VGNUJKRThEMHVtVXdtOERr?=
 =?utf-8?B?WmhxMk1pWThxdGs2S2VyaC9EQUQxQSs2ODdWQ3Y2OUlzK3NkRUF2ZjZkWnhn?=
 =?utf-8?B?ZGozNHhlSHdEcHl4elljTjI0NWlpWFRMWS85d3IxSlpOb010SkVHemQyUVky?=
 =?utf-8?B?WU81UzJvVjVQc0lVeVYvUUQxMlFCd3pTQ01xZ09paFZOQ3gxQ2hiUEl4cUVo?=
 =?utf-8?B?eXpTQ2pKcXUrWTVrbUV5UHVud1JpcE42UCtSdmE5Mys1ZmxJZUtIRkF1K2h0?=
 =?utf-8?B?eUtROEJLN1BKOEpTTkZvL3ZzM0lFVDZSVWdZY3dnM0dINFVMTDhpbWFoQm9y?=
 =?utf-8?B?R3ZQZ0NhWGN5ZHc2OENOdDBjNitZUTMxdSt2WVZRTlJ5a29mY2dodWExdm00?=
 =?utf-8?B?dFNhdlRUR24vRXFBbXJjK1g5c0pZU09OcVo5UFZ1SWRNVXQ5ak1QejVBMDRC?=
 =?utf-8?B?blFqcmtBSkt2NTZuN2x0MlBZRXh3NEpoTWE4K1pxeE1HeVV5VGg4czd2cmhk?=
 =?utf-8?B?dTYwdE9INGNmY3lld3hLa0ZDQjJielhFTjNscVc2LzdMZTIvNGVDUzRqK29E?=
 =?utf-8?B?dE9PaDl2V2RyVDh3bGF0L0dUaEt1cS9mSUxDMXdrZ0lOWWp4N2Q5NHZmZjht?=
 =?utf-8?B?eGlGekJMY1FlYW9CbmVXbG5kejlONHRsZUJSMkpBRTFFaXN3WCsyTG1JMGVy?=
 =?utf-8?B?aytqNkYyRytQbHVmSjhZSXo3eTFrUGx0WGxRQVY5cHZXN3pEL0FDeWxUdnE1?=
 =?utf-8?B?TjIzQ0swRVFUVzVSbE15bzF1NkVjWjY5NVRjV0Q1dFFKVFNDR1J4NDcwZ2Rq?=
 =?utf-8?B?Um5heVFWSUhBZkhwbWlWcVVyV3lxS3NMWUp6bHpnNXR6eU5ndnpVdUJlaGwr?=
 =?utf-8?B?VVljZkVHSS9SYWFubjBibG5JV0M2b0JiODBYR201djAvYjlEaU54MURnWVIw?=
 =?utf-8?B?bjMxeHBKNU9GeE9iQXBWYTdSMzZ4cUdzbHVGd28wVXQ2cDFDUDJaK3NwTzI4?=
 =?utf-8?B?VldrUWFON243Sm1OMnhHL3BBeFRsOEVrc1JRL0N4M2FNRzZJVlpwandKQ1hs?=
 =?utf-8?B?QUtyNFg4OVhDcmJjS2hSaE9uYzlERTVvMy9HTjRTcVo1NCtWaC9HR095dEgz?=
 =?utf-8?B?NUtndHFmN0lFK2FlTkR2dHhrY1RHdW5keWRLTmZ3NkhjNDkwMEc1NGJPMlZQ?=
 =?utf-8?B?Tnk0R2FLaUZob3p2SEZIdkwvU09YWDloMjk4bEIyWXdhV2Q5YVFYOTB4WVZv?=
 =?utf-8?B?cEg3UHEzZHhtNVhhN09acDNUMk95U2lCNWllSzl6YXUzcWNXbEd0RVN2clVx?=
 =?utf-8?B?bVcra3M2Z1RXNElBMVlHRGUzZ3JmNlVQY0Y0YjhpQVp6RUhGbXl0VzErK05M?=
 =?utf-8?B?enRwa3lybGt3cXZMU1BIbmQyeHdFbExpclRxWUN4Um55b3d1WnpEWXg1dytS?=
 =?utf-8?B?OCtncmY0K3JpeGJPRFU0cFFGV0ErV2F1WU9Kb1ZrQWFiOTVTNFFsc2FyZWp6?=
 =?utf-8?B?cnR0M2h6UFpiSE9DV1A4ZFhOTThQM3hsTE55RWJibnVpSTVhejJ1M1J0NDFR?=
 =?utf-8?B?bDZDN3ZqMitTRzlZb2xUL2FHWHRROFJBYXRLRTFETTc1TGVwOThPUisvTVJx?=
 =?utf-8?B?akNhSVQxeitEVXl2WjV3Z2hoSnQvT2pvaUlPcDgvME1aanlRZmJ6RnRsSmlq?=
 =?utf-8?B?L1Z6OWs4TjMzc2dTTzNuMWdwN0pjcEhLMHl5YUhFUWlac2czV3ZpMFZPM29T?=
 =?utf-8?B?ZUJPYlNydzZSY1hNRzhONTZHcHV5aU1JR1lqc3EyK0QrNk0yRUtDV0E5OEZY?=
 =?utf-8?B?NnFad3oycjhTYkNSUi9CeVZKMDA0elg0Mzd1OGliSzBmcWQyRHFjM1BmNVBr?=
 =?utf-8?B?L2hXMVk0Qlc5cElxVDd5RUF0MlZVdVhoODNqMTlnTXg1YkVZUThpRzlBK3B6?=
 =?utf-8?B?YTkvc3ptSmtrRGl3b1NWM01vOHl1MnB4RVpYS0I1d25MRms0WitGWE94Y3I1?=
 =?utf-8?B?emNSSFVZVUhhWXFrVklERU00NVcxRlFJa05wcERlTlBsbWNNeExZbVNxL3hw?=
 =?utf-8?Q?v5ONM67INDstLKrC2aRSNiqYzjTAOks2Ef3wCGuoEufmw?=
X-MS-Exchange-AntiSpam-MessageData-1: BukifOjbOjcWFA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a863554b-6ac6-48b6-8897-08deff584ec2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 07:46:28.0189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3op/Fza1drF8s64QzkDbFxtre80lD/DQjCWO9+Prz9bnPgFChUj3GsGqauYz9wUOIci9y6/PTbiOw5ql6whBDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
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

On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
> Currently, constructing an alignment is quite verbose:
>
> `Alignment::new::<8>()`
>
> It's unfortunate because it disincentivizes using it at interface
> boundaries. Implement `SizeConstants` for `Alignment` and add some more
> size constants (mirroring include/linux/sizes.h) so we can write e.g.
> `Alignment::SZ_8` instead.

These are two good ideas, but since they are orthogonal they ought to be
in their own separate patch. :)

<...>
> @@ -99,13 +125,22 @@ macro_rules! define_sizes {
>          /// choose the width that matches their hardware. All `SZ_*` val=
ues fit
>          /// in a [`u32`], so all implementations are lossless.
>          ///
> +        /// Also implemented for [`Alignment`], providing each size as a
> +        /// compile-time validated alignment.
> +        ///
> +        /// [`Alignment`]: crate::ptr::Alignment
> +        ///
>          /// # Examples
>          ///
>          /// ```
> -        /// use kernel::sizes::SizeConstants;
> +        /// use kernel::{
> +        ///     ptr::Alignment,
> +        ///     sizes::SizeConstants, //
> +        /// };
>          ///
>          /// let gpu_heap =3D 14 * u64::SZ_1M;
>          /// let mmio_window =3D u32::SZ_16M;
> +        /// let page_align =3D Alignment::SZ_4K;
>          /// ```
>          pub trait SizeConstants {
>              $(
> @@ -117,6 +152,16 @@ pub trait SizeConstants {
> =20
>      (@impls [] $($(#[$meta:meta])* $name:ident,)*) =3D> {};
> =20
> +    (@impl_alignment $($(#[$meta:meta])* $name:ident,)*) =3D> {
> +        impl SizeConstants for crate::ptr::Alignment {
> +            $(
> +                $(#[$meta])*
> +                // A non-power-of-two constant will fail the build here =
if used.
> +                const $name: Self =3D crate::ptr::Alignment::new_checked=
(self::$name).unwrap();

Since this is a const, you can use:

    const $name: Self =3D crate::ptr::Alignment::new::<{ self::$name }>();

Which we should prefer over using `unwrap`, even compile-time checked ones.
