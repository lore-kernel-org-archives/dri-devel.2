Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156E1C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4F210E460;
	Thu, 17 Sep 2026 07:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="r8X6D9XS";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9351210E444;
 Thu, 17 Sep 2026 07:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q213LX9uewB8JA3dOtKJJOQX6kwPxXKaGoNa6CXGlouCESYmK0dDrFJP8cSFC2j8fnSUPb7+8Mn39WPTR7UaXFLmn/67njM8vaQmoUZogFSCMJXaXGn/SjS3tuTpKVZXmUELaY4s1tb+R4HSlo2x+GR27MrR2KzRJIydfMRMoME/PqZbRq7wdVV0lNfwhVjFgxaZIUGJHp4vhm9VSjbr0HQ/vseXXKZhC8Fy6hWxcLqcLZVlCz1GHJh3weI/9rlWI479DkIChKyfDNfHo05ia+gUZ/YIYs0dSUTJiA5YNtDVsd8+N41AeIXq/w8RkG/SCu82IyecYdFt20RgVgmmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUDUzkZgc1iTbO2RZOnIFG4NjtMDza/Fjz8YZOKeZNo=;
 b=p/XtrxY/drfao8EpvXQatmIPC37qXp0uH63YJy3dzQg0f2ENbrea6KnMVYK6GntIuSXNUaSMlc5FFxfbLZwYT68Wmx3Zhr8dm1HtSu3MjUCQqzIAZ7LEPRQgkgMSiG5otZlLAs5mjeBEEmcaptxnFCnf6hfUW4HNrtz4cERkZSi3cqC5RcmW5hRrlUGPMqR0tL4SraMFlfKvVTuZoySGMMinKAJ/Z5Dq5p5CBqf22NJqLTO4wrJULjzkxzYpDorV+GjBZ0kIcVbHc12kK0SUkn+5d1AqvtDK2SiFFxx38b9XAHXUVr+qGvytVAyv2eVi950+hC7zz1YgiVp21IajGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUDUzkZgc1iTbO2RZOnIFG4NjtMDza/Fjz8YZOKeZNo=;
 b=r8X6D9XS0jcmuADCpiy+4CJlQW/oyLLSXxixRMpp28Fkk9WrRcaoJn3NZ4DFy4y2weqHUR07EpAi6zZuGmaDqXAQzRVBPHb8SWHQlQbz6kSX2SQaf8j/ScarUOZn0GpeMbCWcikHYBQ7xX97VDJnwxGesZRtFe7Joz98aos18CY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWXP265MB2822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 07:54:01 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 07:54:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 08:53:56 +0100
Message-Id: <DLHFGW1ISL53.3D3X360WD8HPV@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
In-Reply-To: <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
X-ClientProxiedBy: LO4P123CA0221.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::10) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CWXP265MB2822:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e3acca-623e-4595-3f2d-08df1490d636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|4143699003|56012099006|3023799007|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fn8eJyzD51Z0uJkJyLwzWsJ0SfKubrUlX+5ZffnM82yjrMdCYsgl5l9IOuHq1Jv1RdUJk9hCtUc3dx7hAF6XcXdvJFuMWj68dmAO+7Sjir27m0oSE9dqQf+t3pnxXWNkgKO1VjTacXanEmPNa2ven2cSFik2aOSB3yRlmIXQg1S0d/7a67n7i/AMocCODFLzsltgBqiSyGrnog0uaSsSm/Cdpv+ox3xiKQv8hbLXscDxa4eE8OkOULTrEP9gwEnXPRX415gbWEhEsyQ7uKA4B4YdwTy29h+js6jvwFyzZdhuNuvN7G5eoANao9xe32B7ZNei8qWcPBo1gtY77r9kdTWH1dEyZym8k6r0xVSIvpbKgLYVBy+OswFEO5IdDeYi6vNbGU2yh6nJHa3jnzCWoHthuZmovat4yryKBZM9ipoS/OgaqWfld+329HC7mbNUVsaSdwrFi1+W3N47iDv464czJZp4rsmMIZGVAQt/wS8qZPo/tAM/lL4IWIuOvmx1nSDw7NQnF8snoDdLjhZA/YbG6O0OnJB6V7ixhERNxfYWN9NOjl/6kwIUGshaXAATA836/5NO1qzfLAxU4iBC/ZH1ZHugFwHNG1S5843nAOmClAD20/GMRvEls7tRkMzdFOACD/fKHQ6H2wvDyi7o/V2tYzo8qfyKVxE0eJkeX68=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(4143699003)(56012099006)(3023799007)(10063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThZQXdoWnRoZU1hL0RvNTRSN2tvSlVSNlhKdGlQazBjU0VOV1FURzhCQzJL?=
 =?utf-8?B?a0U0TXdSN0xOcTFIK0lHUVRPcXdJR1pQTStNK2dKbEJMV3Q4MTBYSzRnUHVJ?=
 =?utf-8?B?TTBBNENlZFpTdVJIOUUrTUxPcFJ2c0Z3c2g5TnFXRVBRZW4rb2hOR2YxRHJD?=
 =?utf-8?B?OWpVRld0TGNSLzdQWGIrTjlkOFdqSlVGM2FsQS9DdHYxVFVpZTFZcCsyMFdt?=
 =?utf-8?B?UnhvTG81SmpGQzBtN2oxVkxJU0k2TytzNElJZ1I3QS9GV3JDL1B4ajhYV00y?=
 =?utf-8?B?ZVBibGwwWFZhQmhreTRqNWZLbldHR3NVeDJKUVJlZ29QNjNoeEdTZjhnYkpy?=
 =?utf-8?B?alM4VmV1b1FrNmFtUGFOeFVhbkpsZ0I0dkQvMzQ5SHhVaC9yNzJmaTNmZENO?=
 =?utf-8?B?VEZUV2psOUd5ZVFCN0s2eGtVaDdXcUxhMnc1eFY1dEtDQm5tTUVHY3BRelF3?=
 =?utf-8?B?cEcwYWl5QkFMdXFtay9zQlV4RGhaWTFHaHNtakUwZkZsOEVZbzRtUExVSDBZ?=
 =?utf-8?B?eGl2SC8vbVRSVEJiaHRXUHo3UFNMbFJ4SjgxalJhTk01cU82MkhaL1BCMk5H?=
 =?utf-8?B?TVM4VjN1Y29qSk82K2RnNE9ySUQ4TzN5RjN4Y3lpWUZudTNrdS9pOHNHUVdY?=
 =?utf-8?B?TTM3Z0xVWk9uenJlYThtQnlUVWR6WGNyWTlLTnRUMk45TFdWMmVFOUlMa3Fa?=
 =?utf-8?B?L3JJeTZXTXh3emo1NFZrUkZNNjI5blBKOFV1SDB5RVN3OXhMSFA3MEpHOGFY?=
 =?utf-8?B?OTNSaTNsL1JTZG0xODdHSTVFdDJHekk5RVFmbHErUkJEaHBmbUJKUEFVb0Zm?=
 =?utf-8?B?L0ZKME9jeVlHVFF1OGVaNndHa2hrRDRRUGVHU005QmVxVWZESkpOUWs0Z1Rx?=
 =?utf-8?B?RUdSMnpYUDIzbkxxU0h3N1FHZ2U4ZjZmUXdLMFBlUjZ5WlVYZk1ERjF4enA4?=
 =?utf-8?B?NkkvT0NIRTNOaGg5RHBIVFc0ZTY1cGc5VlI1b3ZFRm9sYWtxb0pWMldaRExz?=
 =?utf-8?B?YUQ0Y1hvOTcyemlLa0RTdWFXZEZjVXZqNnl1d3Z2RHRnY05XcFlFOXM2aEZL?=
 =?utf-8?B?WWt3dFhXUU1WOGh5RkM0a3BEUlBaSGExZ0pDc21vcVd2cXpQMkFKTzJlUlBx?=
 =?utf-8?B?UXVsVlUzemhzQjdSckxObmg3NWVqZ2xrMVY5RTlnOTVlaVlqam1vaXdNVUtq?=
 =?utf-8?B?Qzdtc0NENFRMZzgxSHZ1bEoxS1hDeE1qSzZIZ2JGOVZCbGZPTXFmUGR0M2ZK?=
 =?utf-8?B?dTFVQXVVaU5LckhHZTcwcWl6UEpuK01HeHEyc2lIVmIzYzQwWEZ0TVkvSGhZ?=
 =?utf-8?B?Q1ZWUkxHUmRxVlFiVkRRK2orSG9ZQWRYNU4yZVQzSER4M3hpWWhuM1h6bDFv?=
 =?utf-8?B?Z0NXQUhYcmNQMVlMd1V6Mzh1OVFHemQ3eDQveUpjaEg0TDNJaVpyazBCSHFT?=
 =?utf-8?B?VTN1R3owUjQyL1hML2FkSDg4dis4c2JkS3YxWXZ0RWc5NG45elBTVWxEdUg2?=
 =?utf-8?B?eW1GSnhFejFQYTRnOGh0OFpvY1ZjaTNUVWpYS3Bpb1cvUWRoUWZSUUkrajJ5?=
 =?utf-8?B?QmxCMWlNRnBNSVBFK0YrZlFMcTExbi9tb2NFby90VW9GamhyemdseFMvM29k?=
 =?utf-8?B?d3Jnd2JvOUVodU40bkNNdUVDbkJqRit0WjNzTnJQL3hYcmZwVURqOWI4Z01a?=
 =?utf-8?B?Q2lEbG1pS2NSL0xwaFEwQy9xd3FNMzUyWlNsRjc2SjlBWkFGR1dodERYOE1i?=
 =?utf-8?B?dzhJMG43UUUrUlQ1ZXZpTGZOZVdYV3ZvV2VhYk1zSm5ZVURwTmFMNHZ0R1Nv?=
 =?utf-8?B?ZUEvUGpkWXNOVXVDVStUV1R1ZjVIVEEwL3VEYmF6Y25NdXNhYlBJZmpjbU1E?=
 =?utf-8?B?Uk5Yb3diRmxSQ0I3YzlNS2YzRFdIU2ZwTE5MMXVUd3FGQ2ZuNWJHTmY0dnVm?=
 =?utf-8?B?Q3E3M0dqYVVONDM5MEFXLzdhTFBEODB3Y1Nmd2pESGxSSzhad3lnNTRrdnFr?=
 =?utf-8?B?b1dUWFRMRlNVM1hWMFhkOWM2b0xmakliK0lJTENNS08vdTExR1k1aVBkQWdO?=
 =?utf-8?B?aXdIc2hBYnRaOGNNdmF2TjFuMGdvY3lQODAwNWV3TFVYM3IwWEsrdWFicmJD?=
 =?utf-8?B?NU1DcWJ0dC9aZjZlM2Jzc2xHUzFxUDBHcFFJNGl5ZU45OVZiV0FHK2I1eCs4?=
 =?utf-8?B?ajdTOHVrVlVZQ2xrNGJLem41SjFMOHdhekhPUXNJRERwMExuS096V2NpMXZP?=
 =?utf-8?B?c1RzdVhUbWpNM2pkL3FGejYwOXBBeVgzNWE1aktET0pQeFZMa0x4N2hiK3g1?=
 =?utf-8?Q?XN1QrnwDlPHPAFb4Md?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e3acca-623e-4595-3f2d-08df1490d636
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:54:01.3975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYS9OIpKKrVwZb3qxTU5CfAWfUY6AoBKDSQeh06nxwv+J65RsKf4oM5xZ5y6b+I3ZJimftMKn9t728I0h7KrxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2822
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

On Mon Sep 14, 2026 at 7:55 AM BST, Eliot Courtney wrote:
> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>>  use crate::gsp::nvkv::{
>>> +    Array,
>>>      Index,
>>> +    Key,
>>>      KeyId,
>>>      Op,
>>>      Opcode, //
>>>  };
>>>  use crate::num;
>>> =20
>>> +/// Defines a schema struct together with its [`Schema`] implementatio=
n that decodes into `$target`.
>>> +///
>>> +/// Each member of the struct should implement `Schema`. For every (ke=
y, index, value) triple
>>> +/// decoded from the NVKV stream, the generated parent `Schema` implem=
entation will call each member
>>> +/// in declaration order with that triple. If a member consumes that t=
riple, it will stop there.
>>> +/// Otherwise it will keep going until all members are tried.
>>> +///
>>> +/// The schema struct holds the state required by the schema implement=
ation to do the decode. It's
>>> +/// recommended to use one of the existing Schema kinds (`Required`, `=
Accumulated`, `Key`, `Array`,
>>> +/// `Indexed`) for each member.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// ```
>>> +/// nvkv_decode! {
>>> +///     struct RequestSchema =3D> Request {
>>> +///         id: Required<u32, 0x0001>,
>>> +///         name: Array<u8, 64, 0x0002>,
>>> +///     }
>>> +/// }
>>> +/// ```
>>> +macro_rules! nvkv_decode {
>>> +    (
>>> +        $(#[$attr:meta])*
>>> +        $vis:vis struct $name:ident =3D> $target:ident {
>>> +            $(
>>> +                $(#[$field_attr:meta])*
>>> +                $field_vis:vis $field:ident : $ty:ty
>>> +            ),* $(,)?
>>> +        }
>>> +    ) =3D> {
>>> +        $(#[$attr])*
>>> +        $vis struct $name {
>>> +            $(
>>> +                $(#[$field_attr])*
>>> +                $field_vis $field: $ty,
>>> +            )*
>>> +        }
>>> +
>>> +        impl $crate::gsp::nvkv::Schema for $name {
>>> +            type Target =3D $target;
>>> +
>>> +            fn init() -> impl ::kernel::prelude::Init<Self> {
>>> +                ::pin_init::init!(Self {
>>> +                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>::i=
nit(), )*
>>> +                })
>>> +            }
>>> +
>>> +            fn visit(
>>> +                &mut self,
>>> +                key: $crate::gsp::nvkv::KeyId,
>>> +                index: $crate::gsp::nvkv::Index,
>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>> +            ) -> ::kernel::error::Result<bool> {
>>> +                Ok(false
>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut self.$=
field, key, index, value)? )*)
>>
>> Mmm looks like this is going to be `O(n)` with `n` being the number of
>> fields?
>>
>> This is ok for a first implementation but eventually I hope we can
>> switch to a more efficient dispatch.
>
> I thought quite a bit about this while writing this code, since we need
> the escape hatch to imperative decode (custom Schema impl basically). To
> be able to get it down to a match on the key, we need to know ahead of
> time which keys a Schema will consume. That duplicates the info from the
> visit() implementation.
>
> I thought up a few methods but it's unclear to me which one is best, so
> I just left it for now. Please LMK if you think this is urgent, I can
> try in a follow up to improve this. Here are my ideas (when I say O(1)
> lookup I mean modulo how the compiler decides to do it with the set of
> key IDs it gets):
>
> 1. current code - just visit()
> pros: key source of truth not duplicates
> cons: O(field) visit as you say
>
> 2. Associated const KEY_ID: Option<KeyId> - None if a Schema accepts mult=
iple keys.
> You can match on each associated const in the macro.
> pros: O(1) if the current key goes to a field with KEY_ID =3D Some(...)
> cons: O(#fields accepting multiple keys) if current key is one of them
>
> 3. fn accepts() -> bool
> You can match on `if F::accepts(key)` for each field. We could potentiall=
y make
> this const with Gary's const traits polyfill.
> pros: O(1) if you write an inline-able+optimizable implementation.
>
> 4. Associated const KEYS table; use tricks to concat tables
> pros: O(1) lookup=20
> cons: actually MSRV can't get this to optimize down to O(1)=20
>   if you use slice::contains(), but stable can.

Hmm, am I missing the obvious? Why not generate a `match` expression on IDs=
 of
fields? It looks like in the example all keys would have a known ID to the
macro.

Best,
Gary

