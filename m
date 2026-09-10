Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C310C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F89910F35F;
	Thu, 10 Sep 2026 08:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TK47gniZ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4157F10F35F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/M/xPB57YWmM1VoBN1l6Vav8bLrWLq6x4z33AJ3fKQIMryzNIvEAOMbW9MufgWpDvmUYuvH8hQRnZidgrO2prrAxXY4WBJWMEwQge7tV9em7GHSqxSspznwQhEiOB2l90RU/qlY/egRqfMstIlLfafaQUyJv93S4j/58WlX7suvwuuvI3VPSs781ZbDZBZXSKu1b2D19Y4RLwZPTW50F1awgDF+Z4R9okrMDUq7/hFt/8qMBUcHt9GqKe4+DOmRWeOAy+Y7xnvdlrCBlwsstnHk8ltbr7Pmgqo1yAYv1jMCzF0kiwJBoSiRHR0/xfFXcsrzx3VIx8ZWJYBgjDh52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQpCtOB9SAh50fSyvYqgYizxcpS6JcZsO5pLZOKG5Tg=;
 b=RKyDLAkrHPHBhtQELgIseeAqk6VBW5+4EJHz5jwS3Gw3xlwB6VKYH3DHKQQZpmXvQisN85ZDGlx/thGbx7Iq/p63tcW1+xQKVHUPvmUxwYGbXEiwIgayxrTxtAvkoVkeH9EQQBllnS0f4U6O1x0/iNOUA3EOXtX36Mz4b3WpXASYvqhtnxOxCb9lWHpBEjGLlGKthKoNU5krw7sFRy5euUmpOO9qPYoI+B1tMZGiOG9g4MAEfSjFJOJhaH9tPnt0aD65MbPhUFj/53iSMX3XZ7qCduRJtroDDchqWQTKoebMsuSSuNp5b39yKxUaennTJCE5JH74Y+5/74GAo/oJJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQpCtOB9SAh50fSyvYqgYizxcpS6JcZsO5pLZOKG5Tg=;
 b=TK47gniZWAPBA4X36ey5exIJz+wkFcD7XapBQWDt7VY2Nt6GSlBtaN2UyZkMP71l192ItOdxcto05yv5HU79vxa69uIAi0cZt65gZd2hn2IAySGif2Bry11GrvqvLLzctmVNvxGhchxOG7i72jB7sIZ68OzKlOfhIjUGGJ6bOcabWIoKVDrww+bjXM8lqjFRiMWlMhvedKevAdvMTw5OzrEaI7v6ScY2WGD8s3asr34EeFzyva0omzq1z1ZHAZ0K6eIY//Jx1ktXmtpLfRKxhCnlKHQiJMlmFAA3qXuvXSfRcYEJ95exofe74Bvj8d4hRAg7FSKoQzygls4BJtqtDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 08:10:12 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 08:10:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Sep 2026 17:10:09 +0900
Message-Id: <DLBHFHGH4MEE.1ZELDBMX36IQC@nvidia.com>
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
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 6/8] gpu: nova-core: add NVKV typed encoding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-6-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-6-0de9d5c8658c@nvidia.com>
X-ClientProxiedBy: TY4P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cc94fe-26d5-474b-7fbf-08df0f12efc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|7416014|376014|23010399003|22082099003|18002099003|56012099006|3023799007|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: n5GAc6rDxd31Tgi918MG9g+BVE72repeMi8gVwcEgdcLaBbreC5FMiuuJvoFR5MQNHKwM9Hp0wbDm1Br6Ify3FkUI1OL+CERf4vaFPkYVTASA1znCawu/XMhcYOh5naHOodFXdCdA97ydgkNQwOcZmPSS9LiHUrizXGpgf+ygftFj3lOZP4UbtFAjh3fhvIejkxteT1vhJmIkXRgFDgVyDyN4SRBGoIgG0z+Ofr3/rO3ektAtOa6yFkiewqhdKbu+MQh0g60fIHNn/FBhZ82FM3hecMhasY59avzEzkp+ixMxb4HcQk6EM5gf9pEohO3XqIJrOYVP8ASpTwNyVC2OIwd3ZJ159uz3jexYR9mWYdNqbWbf+zobuYNTS8TmtbwhD4eXUudTlhs4r7h8GHcXuNS+wDrP9mou4YygnhRabQNwkpxThn9uwrkXQFsAwxVF5IeMin7YH3q50QUl4UkLwaa5AyaW/c7r9qjQwpdUQnrhK1LgyBRuxFuq1FxA6bJ7xIKom+V73W+a4WWuP12FPCTOVNsOb4DhyLYXIwlf3I4g+hJ/jbbov5xbx1y8hEHL1tJTuQSy7CnnUNpYQl/OliRSo1kSDoQdEPFuA4+Rs27FM1k/40TTJEFdhvi/udgAw4P2GUZGq4CQae/4NcBkPvVA2XZMPlwX6+/dyuN5+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajV1M1ZLRHp5dmswVk80cWFUMDhMTi84bmFGNlM2Rkc2WlQwV0ErTXJQZVF0?=
 =?utf-8?B?VjY4MWdWeUIrWWZENDg2SlB3cmdFWUFnbjBCOU0rNFFDdjVEZEZFZzdHRno1?=
 =?utf-8?B?TmdRL3dobWJSZEVUQVp4aWt0VHBFZk4vbkxXMGQrdktpVkhnTjhEamd5a3VZ?=
 =?utf-8?B?WFB5RERscEUraTFCQUc3K1FSczd2QmJHVFY3T2Zza2pTV0ozU1lWbWRMdXlx?=
 =?utf-8?B?SFR2dFhrZXlkNUdTc1VDbHFydUVmYVdGMkp2Q1RzQ0FrRjdwejFvcHpSNnJp?=
 =?utf-8?B?aEoxSm43Z3F3TDJBRlBhTHpIay9pNFBBSS96djJ0dTVxSWRNT0loOXVDaytR?=
 =?utf-8?B?MXI0NFBGSHZocmJHY2lmOU0xYlUzWG8wbHd4ZXN4ZWFqSjZ4SXJyNGJTNUJu?=
 =?utf-8?B?bzZQYS84YVZUOThGSDN3TStJbnpMYzk0dmJrTktpWHp1QTZGU0psc2ZORHpV?=
 =?utf-8?B?OE5iVzNuOE9EYUlzU2NreDh0ZG0yR084ekl3Z0RsaUhaNFBKN045Q1JOeUlF?=
 =?utf-8?B?TVBWK0haK2U1V1Z0SDlYWVZ6UHgzYVhadHBvNFlRTVhQZmhxZEFlYU5iczUv?=
 =?utf-8?B?djJlb0xTOVNzN2tTUFNjNldzemduOUF1S1cxaVFyZGJPcHpRUUJnUWtlWXdp?=
 =?utf-8?B?NFNYQlY3bGp5bUNSUkY4K2JjcFcxN2RsUkpaT2wxTWQ1UFpTWjZjaUZ1MjE3?=
 =?utf-8?B?NFJueStQVW45YVVHcnBFeDlwbkpmZC80Q3Q0aFRIYThNcWFYdlpPemhBOExu?=
 =?utf-8?B?VVNRV0pXVnNUcU1KQlFTajhTcVVrbDZKN2trY0dJUGhnTWdaZ2J5UmlJYURt?=
 =?utf-8?B?cEp2WTZINnBrckRZUlNXVDM3eWJGS0xhL0UvbjdXWDBaUlQ5Mjc4ek9QZzFK?=
 =?utf-8?B?cWR2YitvT01mMnY3WFhPY0s1TVZQZTZYYnBXbWZHM0ttUHp6U0pXckFOa1Mv?=
 =?utf-8?B?Uk1YUmlvNEZJWFlBR1NsWU9WbFkyQ0duZ204VkFDMnJoMTVPcTJ1cDhQZnB0?=
 =?utf-8?B?NnNqbDlVazlzek5sZW55eERHYlFDNHRqNUFMYmxBNnF4bEl5TVB5bmVhbU8x?=
 =?utf-8?B?RWlna25sNWNPSnYwc2RlaGdlb2ZwNDdNL2JnVmYzYnFpNGtzblhEMXpCaVlB?=
 =?utf-8?B?UWZhUHlKcC9nY0ZSOG1ad2lRakFZS2tvN2RzcUREc2lxazBxUSttRUNwSFYz?=
 =?utf-8?B?cDdxemtTdC9Mc2xseElNOEtzR2l2TGdBckFrU1hwL0UzS0xuOVFyeCtwZ2to?=
 =?utf-8?B?enYxWWozd3ZLQXNpeWxPMzNxQXFkcmJnZDlZOFU0eVRvNElIQ2N2enFRQ3B4?=
 =?utf-8?B?b2ViVElqMmxzZzdCNHRob0Q0eU1LTHpZM1EyeG5mSDI0Nno1ZjB6ZDkybG10?=
 =?utf-8?B?cGJqNUVoOUlnVzFrVXZiY3BBK2VWNkEwc3FUSHRvbXF0TmU2N2EvK2c0YWhO?=
 =?utf-8?B?c3VycG0vbHZNVWZoYTFacVZia0ZGVlY5MlZrMUlTUE9PR3VKNTRuZDZKTk05?=
 =?utf-8?B?ZEV5Wnl6SXFuZC91SFZUcHQzckFwK0crdkcrRm1FQ3U0akZqUDJFU21DejRh?=
 =?utf-8?B?RlZQbTN1YzFGckZXODEvUHFua3psQUVZR1R6dWlTejEyOW1GZHp3MEtjejVl?=
 =?utf-8?B?UnQxNGZpem9xUUdlaWFkUEVVUjUyd0lEV0R4ZUJqQTdXT1ArYWRON1o4L0lW?=
 =?utf-8?B?a3llN2JjQ0lvWXVSL1kvT2xSY0EvZnhpSEhuTDdGcTl4YW1iTFRmRjI5U1Ji?=
 =?utf-8?B?ZjFOK3RHREo2blVSdWZSaEREczNnS1lqSjF0MlQyME5rd2hKRG1pMTBkTzFj?=
 =?utf-8?B?QWNJT3hYZUgyVS9kRjNHNGwwNno4WVhIU2U1NW00TE9nQmswcjVOMFZLL2E2?=
 =?utf-8?B?V0FtL3pMK1UzbzZxY2p5Z2R4ZVFEMGJ5cUpCZVI5cTlqU0FBYkJCVWUvNDV6?=
 =?utf-8?B?aHhnamlOV0xucVNPWWNIbDZoV2lreU93b0o2aXM4TEVzcldzbVQwWXk3SEcw?=
 =?utf-8?B?aVJ3Wkp3TTRkMU4rcHdYNXNRaVlGY1BSZDRiOXRLUW83Q1BuNURkUnJaU2Rz?=
 =?utf-8?B?aVBoMnZjWGhHWlRXYTdndFRpRi9QUnZxNTg0NFVKYTdSZm9uN0RGTW8zRFNy?=
 =?utf-8?B?SjUvSGVNOEJvdnA4RGJaOWNHdW00OURJVHpPUDFUVXBQSmhZaWZnNlpObHNi?=
 =?utf-8?B?N0VhVk91MFVkN0VpN3lqTjJsbWROYXJ6TTFhWmtBNVZ5cWd3WFRzQmQ1QWRR?=
 =?utf-8?B?S09LV3NzWGswRlhOUGFsOFhDUE12YnlEWk5wV0tpWEpnTEVDNVBXSjR4aUcw?=
 =?utf-8?B?TUNUK2hGdE95c1dDdERmN2xSelBTL01pMS9sZ0tRUUpjZ0NRa0dQKzZmdm0r?=
 =?utf-8?Q?vNFH+gFicR/iCjll0Yo7dfDbQ0CCw+c4pgbuwoNk7ISJG?=
X-MS-Exchange-AntiSpam-MessageData-1: tRHS0Ohn28msXg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cc94fe-26d5-474b-7fbf-08df0f12efc9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:10:11.9206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRFAAPHnIJMDYLEfYspPShmegATD3RaAcBY7oDtRc6V1Fm14Wz75am5zUQn6l42mvd0EivY7TLoq8I0gnUsJ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
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

On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
> For struct-like GMCAPI messages encoding field by field manually is
> noisy. Add some type machinery and a macro to automate encoding of
> struct-like messages. The `Encodeable` trait can be implemented by any
> type to say that it can be encoded into an NVKV `Encoder`. Add a simple
> `nvkv_encode!` macro that works on structs and encodes each field in
> order. Provide some base types, such as `Key` which statically
> associates a NVKV key with some value, to avoid having to make a lot of
> newtypes and implement `Encodeable` on them.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/nvkv.rs        |  49 ++++++++-
>  drivers/gpu/nova-core/gsp/nvkv/encode.rs | 178 +++++++++++++++++++++++++=
++++++
>  2 files changed, 226 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gs=
p/nvkv.rs
> index cbeee7f376b6..10dcbb9e602c 100644
> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
> @@ -10,8 +10,13 @@
>  //! naturally maps to storing a &str with the GPU name.
> =20
>  #![expect(unused_imports)]
> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
> =20
> -use core::ops::Deref;
> +use core::marker::PhantomData;
> +use core::ops::{
> +    Deref,
> +    DerefMut, //
> +};
> =20
>  use kernel::{
>      alloc::{
> @@ -92,6 +97,48 @@ fn deref(&self) -> &Self::Target {
>  /// The index of an NVKV value.
>  pub(crate) type Index =3D Bounded<u64, 12>;
> =20
> +/// A static association between an NVKV key `KEY_ID` and the storage of=
 its value.
> +///
> +/// Use with the encoder or decoder macros `nvkv_encode!` and `nvkv_deco=
de!` to let them know how to
> +/// map the value `Key<T, KEY_ID, As>` to/from encoded data. For brevity=
, `As` inserts an additional
> +/// conversion (`From`) to avoid having to implement [`Encodable`] for m=
any types. For example,
> +/// enums that are easily convertible to a u32 can have `As =3D u32` and=
 rely on the existing encoding
> +/// for u32.
> +#[repr(transparent)]
> +pub(crate) struct Key<T, const KEY_ID: KeyId, As =3D T>(pub(crate) T, Ph=
antomData<As>);

Does the `T` need to be `pub(crate)`? The series builds fine with it
being private.

Also the relationship between `Key` and `IndexedKey` is a bit unclear
with the current type layout. IIUC `Key` is basically a specialization
of `IndexedKey` with an index of 0. And yet `Key` is declared in the
root `nvkv` module while `IndexedKey` is in the `encode` submodule...
I'm also wondering whether it would make sense to make the relationship
completely explicit by making `Key` a newtype embedding a `IndexedKey`
with the invariant that the index is `0`, but not sure about that one so
your call.

> +
> +impl<T, const KEY_ID: KeyId, As> From<T> for Key<T, KEY_ID, As> {
> +    fn from(value: T) -> Self {
> +        Self(value, PhantomData)
> +    }
> +}
> +
> +impl<'a, T, const KEY_ID: KeyId, As, const N: usize> From<&'a [T; N]> fo=
r Key<&'a [T], KEY_ID, As> {
> +    fn from(value: &'a [T; N]) -> Self {
> +        Self(&value[..], PhantomData)
> +    }
> +}
> +
> +impl<T, const KEY_ID: KeyId, As> Deref for Key<T, KEY_ID, As> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.0
> +    }
> +}
> +
> +impl<T, const KEY_ID: KeyId, As> DerefMut for Key<T, KEY_ID, As> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        &mut self.0
> +    }
> +}
> +
> +impl<T: Default, const KEY_ID: KeyId, As> Default for Key<T, KEY_ID, As>=
 {
> +    fn default() -> Self {
> +        Self(T::default(), PhantomData)
> +    }
> +}
> +
>  bitfield! {
>      /// The op word that starts each NVKV operation.
>      struct Op(u64) {
> diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/encode.rs
> index 6c1a9cbd90e8..0047be65e8a9 100644
> --- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
> +++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
> @@ -8,11 +8,153 @@
>  use super::{
>      EncodedStream,
>      Index,
> +    Key,
>      KeyId,
>      Op,
>      Opcode, //
>  };
> =20
> +/// A type that can encode itself into an [`Encoder`].
> +pub(crate) trait Encodable {
> +    /// Encodes `self` into `encoder`.
> +    fn encode(&self, encoder: &mut Encoder) -> Result;
> +}
> +
> +/// Defines a struct together with its [`Encodable`] implementation.
> +///
> +/// The implementation encodes each field in declaration order. Each fie=
ld type must implement
> +/// [`Encodable`], which is done already for types like `Key<T, KEY_ID>`=
.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// nvkv_encode! {
> +///     struct Request {
> +///         id: Key<u32, 0x0001>,
> +///         name: Key<&'static [u8], 0x0002>,
> +///     }
> +/// }
> +/// ```
> +macro_rules! nvkv_encode {
> +    (
> +        $(#[$attr:meta])*
> +        $vis:vis struct $name:ident {
> +            $(
> +                $(#[$field_attr:meta])*
> +                $field_vis:vis $field:ident : $ty:ty
> +            ),* $(,)?
> +        }
> +    ) =3D> {
> +        $(#[$attr])*
> +        $vis struct $name {
> +            $(
> +                $(#[$field_attr])*
> +                $field_vis $field: $ty,
> +            )*
> +        }
> +
> +        impl $crate::gsp::nvkv::Encodable for $name {
> +            #[inline(always)]

The `#[inline(always)]` of this patch should probably just be `#[inline]`.

> +            fn encode(&self, encoder: &mut $crate::gsp::nvkv::Encoder) -=
> ::kernel::error::Result {
> +                $( $crate::gsp::nvkv::Encodable::encode(&self.$field, en=
coder)?; )*
> +                Ok(())
> +            }
> +        }
> +    };
> +}
> +pub(crate) use nvkv_encode;
> +
> +/// A value with a specific index that encodes under the NVKV key `KEY_I=
D`.
> +struct IndexedKey<T, const KEY_ID: KeyId> {
> +    index: Index,
> +    value: T,
> +}
> +
> +impl<T, const KEY_ID: KeyId> IndexedKey<T, KEY_ID> {
> +    /// Creates a key with the given index and value.
> +    pub(crate) fn new(index: Index, value: T) -> Self {

`pub(crate)` visibility on a private type method.

Also this constructor seems to only ever be called with an `index` of
`0` throughout the series? Does this mean we also have no test coverage
for indices larger than `0`?

> +        Self { index, value }
> +    }
> +}
> +
> +impl<const KEY_ID: KeyId> Encodable for IndexedKey<u32, KEY_ID> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        encoder.encode_u32(KEY_ID, self.index, self.value)
> +    }
> +}
> +
> +impl<const KEY_ID: KeyId> Encodable for IndexedKey<u64, KEY_ID> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        encoder.encode_u64(KEY_ID, self.index, self.value)
> +    }
> +}
> +
> +impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u8], KEY_ID> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        encoder.encode_array8(KEY_ID, self.index, self.value)
> +    }
> +}
> +
> +impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u32], KEY_ID> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        encoder.encode_array32(KEY_ID, self.index, self.value)
> +    }
> +}
> +
> +impl<const KEY_ID: KeyId> Encodable for IndexedKey<&[u64], KEY_ID> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        encoder.encode_array64(KEY_ID, self.index, self.value)
> +    }
> +}
> +
> +impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u8; =
N], KEY_ID> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        encoder.encode_array8(KEY_ID, self.index, &self.value)
> +    }
> +}
> +
> +impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u32;=
 N], KEY_ID> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        encoder.encode_array32(KEY_ID, self.index, &self.value)
> +    }
> +}
> +
> +impl<const N: usize, const KEY_ID: KeyId> Encodable for IndexedKey<[u64;=
 N], KEY_ID> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        encoder.encode_array64(KEY_ID, self.index, &self.value)
> +    }
> +}
> +
> +impl<T, const KEY_ID: KeyId, As> Encodable for Key<T, KEY_ID, As>
> +where
> +    IndexedKey<As, KEY_ID>: Encodable,
> +    As: From<T>,
> +    T: Copy,
> +{
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        IndexedKey::new(Index::new::<0>(), As::from(self.0)).encode(enco=
der)
> +    }
> +}
> +
> +impl<T: Encodable> Encodable for Option<T> {
> +    #[inline(always)]
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        if let Some(value) =3D self {
> +            value.encode(encoder)?;
> +        }
> +        Ok(())
> +    }
> +}
> +
>  /// An encoder for an NVKV stream.
>  pub(crate) struct Encoder {
>      stream: EncodedStream,
> @@ -207,4 +349,40 @@ fn encode_all_value_kinds() -> Result {
> =20
>          Ok(())
>      }
> +
> +    // Tests that encoding via the `nvkv_encode!` macro works correctly.
> +    #[test]
> +    fn encode_typed_struct() -> Result {
> +        const U32_KEY: KeyId =3D 0x0001;
> +        const U64_KEY: KeyId =3D 0x0002;
> +        const NAME_KEY: KeyId =3D 0x0003;
> +        const FIXED_KEY: KeyId =3D 0x0004;
> +        const OPT_KEY: KeyId =3D 0x0005;
> +
> +        nvkv_encode! {
> +            struct TypedRequest {
> +                a: Key<u32, { U32_KEY }>,
> +                b: Key<u64, { U64_KEY }>,
> +                name: Key<&'static [u8], { NAME_KEY }>,
> +                fixed: Key<[u8; 4], { FIXED_KEY }>,
> +                opt: Option<Key<u32, { OPT_KEY }>>,

The `{` and `}` brackets are not needed here.

> +            }
> +        }
> +
> +        let request =3D TypedRequest {
> +            a: 0x89ab_cdef.into(),
> +            b: 0x0123_4567_89ab_cdef.into(),
> +            name: b"name\0".into(),
> +            fixed: [1u8, 2, 3, 4].into(),
> +            opt: None,
> +        };
> +
> +        let mut encoder =3D Encoder::new();
> +        request.encode(&mut encoder)?;
> +        let encoded =3D encoder.finish();
> +
> +        assert_eq!(encoded.len(), 7);

I guess we should also check the raw output here, otherwise there are
whole classes of bugs this test won't catch.
