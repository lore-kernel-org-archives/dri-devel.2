Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD711C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA05E10EC8D;
	Thu, 17 Sep 2026 08:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="legmDCaW";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020138.outbound.protection.outlook.com [52.101.196.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDFC10EC8D;
 Thu, 17 Sep 2026 08:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7qB66o7KRZOI90v5YiF7e7aGqYITan3QkXriR78/YGXRoR/P1K9nL7YVXCytoPqyYPgSZwyiIhCM6s5/AnqdXkzAclgyaYmWFRL8FsT75dYkG5wDeKlI/ZiEfAKqNzhklU6IpVAHvMFnF1CU0Kj4fUWxyzkrVj/A4cd/5NME6rC1wuA7UAMJFI21akmPxGVwy8BnwZOK2a5tQPavf1ybsgmBPK90DvZE4ii7RnZoNPOHJXQ8axK0g1HPSvr2u+3mOY82YaOyi3YgrJXGelyQ6uJnBHosLDJEEFqJncElaDMJiZC9EiLQ5/SHhJJpcepOdf6WTeyNwlZtjH/LhYeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF+W25bL92aYfExeOBaCwfgrueV+lOXfU4GDHva6TFk=;
 b=VZOq3twPQWsjmUtwUffcCGAGm85qsCeqrR4yNdRYkheIhL2X6WfL72RI7yypub9GBPW1KmZpg3LHvz+klj8v1TIi0xOo/2c7QpspA/8LbNpQGx0V1vjoDGPZxNxFUC65hcEHYfRiFLtYoXnnHB3Mf9PDjrawSQabwBUPdT4LOCVp9Q5vX0MjyCFnfgRyjByUt1VpCbJfXTQKFfEISgPghL8dLJ0bUhcA0MLUzevAxlD2yyaSyYVYpObGIQFi1kRv8HH0YkOgAg6aBtZqhmVk9xyUsv77JhiAgcRBYFcbFmAbsWW8+9qqpC1X4xme2c2mKbtsjE8L00MnR1F6mgF7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF+W25bL92aYfExeOBaCwfgrueV+lOXfU4GDHva6TFk=;
 b=legmDCaW6c+TbBd2TJeRngw6aV6MmeB1Bm8Sx+y+nP/7a67XAFLsiDqE5sot/hSkfh63fnnCG8o3+hYFI1dwORZthmE7eTcCzz3I7kWSsdllOe/3yOQIhbNVobf+BaZblO2Oy74LUI9HB2piM7cpoCXy6wEEzBvrLNR4zbiLQDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by CWYP265MB9397.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:29b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:52:09 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 08:52:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 09:52:06 +0100
Message-Id: <DLHGPFAO0A8J.TU9XW1AZ8XAK@garyguo.net>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
 <DLHFGW1ISL53.3D3X360WD8HPV@garyguo.net>
 <DLHGE0SNY9CO.1OPWR5QXKJLAZ@nvidia.com>
In-Reply-To: <DLHGE0SNY9CO.1OPWR5QXKJLAZ@nvidia.com>
X-ClientProxiedBy: MA3P292CA0064.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::16) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|CWYP265MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 506fd7c0-7d76-48c2-fdb3-08df1498f54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|7416014|10067099003|3023799007|18002099003|22082099003|10063799003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: WQrDLwmX6SAu8v3BRMbd2nEh1Fx9DPHJe6a5ur4zvk9kmkea71qGwthjt8K9KdDYm/RNwZBr6qBQRNvsSiNGh2rI2liXt5f6YJcBqi+sxR4mnsL2nNCiGb5uA635XqZZhFTzyBfrYbIhhm5IPBWEad4megU1Uan18fLRM8tsCokFn8VXlzqWSTKHptGOGZ3MYFdexJEt/QkMjR6cJ9x+MjM9X+LHelGPclode5lvNr6VdPXv00RaRaTHgXG0JW/WZojo7sjx3w06sthL8ha38/tD87qHnEf5Z+Yw5GR+L8OrVu9DDtibHHechgclEWAgJnprKGruIty63W4u4MzmjesbE85Vde5TB3lUQYRjOPqAIn106TOeMgcz9EDKvSpjBxsuSGVav2ByIS5dCUG9pkq0bppJXroXrwWMnkHpjAZnQnoRy+n4IwQrTmahSABHmSgTMeZCGGxRTK4iXOMegKw+ifQ8PUJCwkRT2yHKINN8f08vZaI6ENZ+PaR8ks+Qk07tcq8TnNo+EMb+8J9JgcMMkOPELrNJdVFFq8oG6IyHAIzhP95ykXT6BWG2XjI0zG5kyXwHdUr72LEoDkIDEQ9RXwUJzbyxrLpR/oCE1qA54RWKsISXZdhHnIOOeZ2HT+JN+6G6TZKr+KEsqn556U8NDUcfPnbL0d+4rGcGOvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(10067099003)(3023799007)(18002099003)(22082099003)(10063799003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkl5czFxUkRTVUR0T1cwaFYzNm9vd2VnNFRoQldYZTZuWWN4TEU0RDNEaEFP?=
 =?utf-8?B?cldrVDlCRy9oUC9ETlZBbkRTS0NydG9ndmsyR1p0cXRmdGFlWE4yK3pVOHFY?=
 =?utf-8?B?bUsvV1RBbk1yaHExV2QybXJ5MEZFZFpEWjRyK252bWhXTUdiTmJmaEFwZVFL?=
 =?utf-8?B?TS9RZmFnTytkTDRhY29YZ25tdjRSWEN4aDRqL0QwcFlubm5tdFdHQzQvY0JG?=
 =?utf-8?B?T0Z6V0hBYk5BVXZjSlV3QkM1U3hwckZIbGczUWVjMEJFcHp1V1ZkRE5YOVBB?=
 =?utf-8?B?akNjRVRmcEx5SkJNYmdrMW1LMTQzbm9adGFxUmphZ1l0S1lIRjRhMEx4NVhR?=
 =?utf-8?B?TWpjYVowU0o1STJiWmcrZE0rWlJUS3hUN2J2Z3RKTXRHTmtLUkVvOS9GNzNU?=
 =?utf-8?B?UlhtaldMN1lXdEIzWHRUOWFuT3VMbU1zbmJFajZHY3QxL0VMR2ZKNDU4dG4r?=
 =?utf-8?B?d3MrcVU2TWhncUpNYW5DaE41Z0JJOVN2aHdQVGdMQit3RFlLVHZJKzFDNUxO?=
 =?utf-8?B?dmxOSjFHeERKT2NmWW5RNlRIVjI2a2tUOGFYUUNSdHc5T2V4dStmNDc2MC9C?=
 =?utf-8?B?VnlPMnZJNEI4U2FzRzdPTnY0ektyU3p0OHgxOFQ0MjZvWnYyUzR5Y0h1blpJ?=
 =?utf-8?B?YldFcnFlOEZvWWpOUzlNdVJMUVhTWVViakxXVmc0YkJpcmp2RHBIcjNLdms3?=
 =?utf-8?B?aW5jUE05NEl2MmZLajkrZTRPalF0ditaS1ZZVkdYVTZSeDJpUDg2YWpnT3Ew?=
 =?utf-8?B?b1ZIOFNrbU5YaU1EeVlFYlpiWnkxaXQrQW9uNEtZNlREVlorVmJRekl6ZFFa?=
 =?utf-8?B?UTBhQWdNdUpLdG5ncG9ybWhHZlhneTdWam1ldXhHVTM2M215ZVdnRFM2VlI3?=
 =?utf-8?B?QWNaRUhFU0RIMWNyNkNTS0lRREEzWElHRXFOV3FPVlZ2RWhZcTBadWNvQVJW?=
 =?utf-8?B?SHBTRWtacUNvb0NyNmhxSG5YR0xTaE5WQm0xMUtqZU9qNlh5QjNCRG84OFk5?=
 =?utf-8?B?K0szanBITjBESU9Yclh6TVZBMFhCWEIyWkhCNlFsSXZjYzBQRktQaFJYK0hn?=
 =?utf-8?B?NmVwc0NsVkNnNE16YU5oRnp3MDJQVEV6aXlybzlsaG5KeFFPV0RPMXVidHVH?=
 =?utf-8?B?dk9VMkJlM01yb0FnVzR5YXlvd09JSUVrUmpjV3B5a21hZEFVNVEwVUg5OXNY?=
 =?utf-8?B?WnJ1Z3Q3dEpjMGozaHhEWDhDOFJrYnFZRFNuK2JrSUw5TmlwWkU2cWpzbEtC?=
 =?utf-8?B?bUk4eWxSUlV1VVd3R0pLTy9FSnlROS9FZjhEYUROQlR5NHN2YmYvTXF0UHg3?=
 =?utf-8?B?QndWMXhwdGpJcG56eVdoemRDNVZDbm5xZkc4K0E2Z2pPSTFwUFpXM0h6YVJx?=
 =?utf-8?B?dTZtYXJJekJ4NnpRNDJlNDlnc2RReEx1SkJQR0lueUR5bHFiWXZZVHY0RVlE?=
 =?utf-8?B?YjlvV240R1QxS3VrL3lGa1FhRGdIU1BDdlVpVjBIUnJvWWhzUk9GeTNSRUFF?=
 =?utf-8?B?TW9wT1NzTkkxMWh2Sm8rSkVxcmluNllmb1BqSGhITTZRVW1tYUt6RG90L2hI?=
 =?utf-8?B?cGs0V3I1c0NTU09MU2hhd1RLdXFpdjlDaE0zY3dDNGtSMWxGaDEvSWZBMWI3?=
 =?utf-8?B?T0syS2JnMVRZaythSnBiM1BMdUpja2dCdkhteDlmNmZBWDBrdm9VUGM5MDZq?=
 =?utf-8?B?RkswRHJlczF4cVJPVXVMZ204ZXNxTUo3blo1WnUwWDdIc0Y2czE1SURYbDdW?=
 =?utf-8?B?cnZUV2prMzk5cDA5MXh3b3FSRXdXbEJHZk1YdDNPbjdCdlJQRXFldlRkM0pY?=
 =?utf-8?B?a01lNlZUQ0dKUE1SeGtJeHdGQVBwczVNOVBuUVZ1MVJJRFA5K1pqcEJldWly?=
 =?utf-8?B?d25kUVJPYXUzWDc1OE5leEhNd3QwcVg3OGVYeGlUa2ZTSlR0SDlWRlhJdVky?=
 =?utf-8?B?QUxFeWFUOHhUZ3RVV3JiNldGMmhTdVl3U0dXdEJ1RUlQaHpuRllvWVcya1d4?=
 =?utf-8?B?S1gyU0NJRWJBWXJEZW9Bci9QUmZ0cGJRRjZyZkJUR2dqSFI3OWUxMjd1dTRk?=
 =?utf-8?B?emQzbmhSV1V4Vk9pZTdzMkg1VURWdm4zaVRxejY1QmE5M0xHQ3ZYWENGYSto?=
 =?utf-8?B?MTZueHBuemdQVWRHRU5tVmVDNGYvZEtSQW8yNmZPV0dWZHg4VTUxeXNhSk5p?=
 =?utf-8?B?TDRPMncyemxhbjdybmZLVDhCeDFTUVVXWTBOWkdzZ2U4ZW56OU5PVWJjWXYw?=
 =?utf-8?B?VzFjeGVMV0x1MEZpWFl5VDNvYSt1ZXpUYmlENllmYUM0NERDaDg3c0JlYU9l?=
 =?utf-8?Q?+TubYWKhM/6EvXU9oC?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 506fd7c0-7d76-48c2-fdb3-08df1498f54a
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:52:09.4155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +do1zHx5EaCJB3QivBhsCjzFFTRlVuKSK8tOS18zPcWu2N6/KekZLurAP0zw6r9oslW3OaxRTS3kRDwe1mJ0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWYP265MB9397
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

On Thu Sep 17, 2026 at 9:37 AM BST, Alexandre Courbot wrote:
> On Thu Sep 17, 2026 at 8:53 AM BST, Gary Guo wrote:
>> On Mon Sep 14, 2026 at 7:55 AM BST, Eliot Courtney wrote:
>>> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>>>>  use crate::gsp::nvkv::{
>>>>> +    Array,
>>>>>      Index,
>>>>> +    Key,
>>>>>      KeyId,
>>>>>      Op,
>>>>>      Opcode, //
>>>>>  };
>>>>>  use crate::num;
>>>>> =20
>>>>> +/// Defines a schema struct together with its [`Schema`] implementat=
ion that decodes into `$target`.
>>>>> +///
>>>>> +/// Each member of the struct should implement `Schema`. For every (=
key, index, value) triple
>>>>> +/// decoded from the NVKV stream, the generated parent `Schema` impl=
ementation will call each member
>>>>> +/// in declaration order with that triple. If a member consumes that=
 triple, it will stop there.
>>>>> +/// Otherwise it will keep going until all members are tried.
>>>>> +///
>>>>> +/// The schema struct holds the state required by the schema impleme=
ntation to do the decode. It's
>>>>> +/// recommended to use one of the existing Schema kinds (`Required`,=
 `Accumulated`, `Key`, `Array`,
>>>>> +/// `Indexed`) for each member.
>>>>> +///
>>>>> +/// # Examples
>>>>> +///
>>>>> +/// ```
>>>>> +/// nvkv_decode! {
>>>>> +///     struct RequestSchema =3D> Request {
>>>>> +///         id: Required<u32, 0x0001>,
>>>>> +///         name: Array<u8, 64, 0x0002>,
>>>>> +///     }
>>>>> +/// }
>>>>> +/// ```
>>>>> +macro_rules! nvkv_decode {
>>>>> +    (
>>>>> +        $(#[$attr:meta])*
>>>>> +        $vis:vis struct $name:ident =3D> $target:ident {
>>>>> +            $(
>>>>> +                $(#[$field_attr:meta])*
>>>>> +                $field_vis:vis $field:ident : $ty:ty
>>>>> +            ),* $(,)?
>>>>> +        }
>>>>> +    ) =3D> {
>>>>> +        $(#[$attr])*
>>>>> +        $vis struct $name {
>>>>> +            $(
>>>>> +                $(#[$field_attr])*
>>>>> +                $field_vis $field: $ty,
>>>>> +            )*
>>>>> +        }
>>>>> +
>>>>> +        impl $crate::gsp::nvkv::Schema for $name {
>>>>> +            type Target =3D $target;
>>>>> +
>>>>> +            fn init() -> impl ::kernel::prelude::Init<Self> {
>>>>> +                ::pin_init::init!(Self {
>>>>> +                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>:=
:init(), )*
>>>>> +                })
>>>>> +            }
>>>>> +
>>>>> +            fn visit(
>>>>> +                &mut self,
>>>>> +                key: $crate::gsp::nvkv::KeyId,
>>>>> +                index: $crate::gsp::nvkv::Index,
>>>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>>>> +            ) -> ::kernel::error::Result<bool> {
>>>>> +                Ok(false
>>>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut self=
.$field, key, index, value)? )*)
>>>>
>>>> Mmm looks like this is going to be `O(n)` with `n` being the number of
>>>> fields?
>>>>
>>>> This is ok for a first implementation but eventually I hope we can
>>>> switch to a more efficient dispatch.
>>>
>>> I thought quite a bit about this while writing this code, since we need
>>> the escape hatch to imperative decode (custom Schema impl basically). T=
o
>>> be able to get it down to a match on the key, we need to know ahead of
>>> time which keys a Schema will consume. That duplicates the info from th=
e
>>> visit() implementation.
>>>
>>> I thought up a few methods but it's unclear to me which one is best, so
>>> I just left it for now. Please LMK if you think this is urgent, I can
>>> try in a follow up to improve this. Here are my ideas (when I say O(1)
>>> lookup I mean modulo how the compiler decides to do it with the set of
>>> key IDs it gets):
>>>
>>> 1. current code - just visit()
>>> pros: key source of truth not duplicates
>>> cons: O(field) visit as you say
>>>
>>> 2. Associated const KEY_ID: Option<KeyId> - None if a Schema accepts mu=
ltiple keys.
>>> You can match on each associated const in the macro.
>>> pros: O(1) if the current key goes to a field with KEY_ID =3D Some(...)
>>> cons: O(#fields accepting multiple keys) if current key is one of them
>>>
>>> 3. fn accepts() -> bool
>>> You can match on `if F::accepts(key)` for each field. We could potentia=
lly make
>>> this const with Gary's const traits polyfill.
>>> pros: O(1) if you write an inline-able+optimizable implementation.
>>>
>>> 4. Associated const KEYS table; use tricks to concat tables
>>> pros: O(1) lookup=20
>>> cons: actually MSRV can't get this to optimize down to O(1)=20
>>>   if you use slice::contains(), but stable can.
>>
>> Hmm, am I missing the obvious? Why not generate a `match` expression on =
IDs of
>> fields? It looks like in the example all keys would have a known ID to t=
he
>> macro.
>
> Some keys may come from embedded structs, which the macro has no way to
> see.

You can match all keys that you can see, and delegate to embedded structs i=
f
keys are not known.

This is essentially the same pattern that `#[serde(flatten)]` uses, just
replacing identifier names with keys.

The keys don't need be part of the type system, and it just additional meta=
data
for the macro to generate correct impl.

Best,
Gary
