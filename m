Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62BAE99050
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CF310E8E7;
	Fri, 10 Apr 2026 07:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlzTku97";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB0B10E8F0;
 Fri, 10 Apr 2026 07:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQRIwWVdrNgINSR3x2lBK0Ck9tr1HCl+kHXy1EgekC9YnQBkEonRIV4ahYpbjzInOP6onIuLvuL1xriMvvHE4jBFWoapADGrI7Hggq+IKXIZfBY5B6t6daDHgtyUclVloWh6yDOCmRmEEHwwZo6YdCL9KbXVwUJm77A09Aa6AfSxFrTj9K2Ftp0GwXxJHsfhoZIjhRu5R3LTeKrc/JlJSf1uvB282MdKpfKehl0X6cvbYjpKt9OuDOl33pazSc2VataNIVKuFcWG+OhcYm7nDNDU/qX37ADXwEJwEnVaTxCW1C4JHAy75nfh1QEFm8UaFPNscKN8V0PgZ+nWLp2q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OXEUGYW9Do+/K69MxrytMjWJ3zBD1kAkqZEIVep5sw=;
 b=uSl5N92pCyy5T2/B5fAT+1gMLZNCHvx2Q5tQbHilx61+27Uxx3wvfbmulPf9NaDY16E5+lXOI4zyVrkM4bdIW7DNQudkVlgFTUV9WvAkB6mqC+T8SV9bq0cED4FbItwW7yWQZR6tnTB63P7b3DLg37I7pgsTlOFrbaFiy4zW+2HoAXuhTkmkiZRtyyHe6j+YOBBxH7yHCepB4XneuFQ/QbLloTQ60QWZjMV6zId8YRjIklMxql71KojLR2ZpuqRZq/0OYjETzW7INKtb26Rdw3+ne0KFsGCXmcjHIxfYwtL29CykonMK5H0zLWh3uyrA7gSy1lfxrKLgnkYktDUd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OXEUGYW9Do+/K69MxrytMjWJ3zBD1kAkqZEIVep5sw=;
 b=BlzTku97Sb2c1qA+ssp4mTbqy4ziD8C61rQQEMyRdOEsZ6M8nsGHEUjAF4JP+LrYqJmqcYvL/QaXV0SA/JXQDdttZqUK+vL48pHsdlVCiDdlZhA/IQuDbPjGLKzImi++cj3EXT+zJU4WDPhHn3hSOAuhLRAze0kGcmCJQ57ZV8MjP++tTU77Hrrp4WzOEWhqnO/sjM6K+tzaayNdkMM5rFtK8SXtjIdmP0SbtGzBrf+K6KWVeDSvgDbN4PMW3roNEgkPiiMcq1brgbLNQmLahZo7mT3GG+DxPr9FF3yZ7NuHgzdY0NrbJXyDWqL055URrkVlyaUAXZmEiTsR6ME97w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 07:55:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 07:55:33 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Apr 2026 16:55:27 +0900
Message-Id: <DHPBAVQHIM11.XVBHOWYFRITF@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>
Cc: <nouveau@lists.freedesktop.org>, "Gary Guo" <gary@garyguo.net>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Matthew Maurer" <mmaurer@google.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, <christian.koenig@amd.com>, "Asahi Lina"
 <lina@asahilina.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boqun Feng" <boqun@kernel.org>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, "Krishna Ketan Rai" <prafulrai522@gmail.com>,
 <linux-media@vger.kernel.org>, "Shankari Anand"
 <shankari.ak0208@gmail.com>, "David Airlie" <airlied@gmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 <linaro-mm-sig@lists.linaro.org>, "Asahi Lina" <lina+kernel@asahilina.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, <kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/5] rust: drm: gem: Introduce shmem::SGTable
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260409001559.622026-1-lyude@redhat.com>
 <20260409001559.622026-5-lyude@redhat.com>
In-Reply-To: <20260409001559.622026-5-lyude@redhat.com>
X-ClientProxiedBy: TYCP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::9) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: fec013a5-e1ea-4127-1111-08de96d689b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yHBqNYUXEqyEtAoZaskLS5g393zrpSLT2Hif8VZQ9Z7UhHUaoB650TIBqfxQ5OxdzY6qCPRDqYssH2UJJLfnzvFiZxQU73gy8z0XCOUT4jMTPsUV6GEVQLm6Flog71fUkTBl9TuNG6Mma+GkLCiC6obwHbOfwnXHUSPw6KrrOYKNGyYaLNSeEhLADKJqIqdMElxrTGHTStQrQ76rPTJEuIDurgTezK4KvAQ316oYnFeWpKmNuuS4jJyhw6jvUAjxb1K3DAhb3xqNRFDssLUJd3W8bsnxaEAJh5dS5Yucw6LeXv1rris6CMrCmemYQtYSyEkfj9qzzVpG73bKTaYU2NgPnPCRWcqWDP0psswX7BdExM9cDOy2dEgb3mpsg5q1QY54JHwZbedI0jlIecUf55Q6PmcWulBwWrAGoRW2+wLttknV6qJT8rFMAsfVGYdH/fmhfVY0Wc/fgwyP0hPWuOedjXuteVa8xpcizKXejWTMy2lAOuOo3+Kiw/707ENrAXzi2hUhsjgGOkbOTxN3LSkysdKlUSkRL5KTxbImJisST/j4xcEQbY6YsigbYD8q91K2+XITUjJXy5FAErhl55W6TsgYFkp37Cx9qONb0YJcWSbDSFB52bfw9KqP4N3GGu3jZTw2sGzyY1TJcw39++0nglQGPiiF++/gwR0w6iLD+KTnWv9y0eICBq7L2hUJ2126rMS2YpXh09vzOsJKJQhJ13eVE9kK/c/JmXhBBCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmdnYVRGMTUvQXNZZ1lBU1ZpZnRrWnpRcDk3WVJVZE9xbjQ2SWRNVWU4RlJQ?=
 =?utf-8?B?aklyTmtiK01NWDRRQ2dSQXVLMHp1bFh5aHg0SEx0Ly9BNHpoQ3FMSXhPZkR5?=
 =?utf-8?B?bS94TDF6NENEaHpMTXdBLzRnZ1FzQzdwZG9RWGpJU01RWGJQeDFXeTEvVmZ2?=
 =?utf-8?B?U3NFUFFwajR6UUZ2K21ZL1VWWU1PYmNENDlBMHJxWmZJV2RVVzFSK1F1ZjdT?=
 =?utf-8?B?ckY3aUNTK0NSbVNKZk9pY1hUYUN5L1o1NnFrUHdzME5VSkh6Wll6U1pVL3k0?=
 =?utf-8?B?V0JhQ0ZMMy95SFdFTU5HUG5xYkdjVnhjb0xURWFIM3g2YTE0eEF2M1RpWG52?=
 =?utf-8?B?NFJXUDd5RHB6TWh0VUtBMEU5VVEvZVVDOHUxWmEwYllFdmQ4SExia1Vqai96?=
 =?utf-8?B?OStsZHlNK1Q1dnZOakZWTms0Y0UyUk10elpYU1ZnQnVvaVh2YzJPOFhMeVpR?=
 =?utf-8?B?SEVEUG55em5mK0ZBS1BNaWNoVlZIRWplSFF0SjhXYzQyTExhUkR1SU9JcVZO?=
 =?utf-8?B?YW54U3hKdHBaVEF6MVhhaUVhVTVEbDFqQ2RWUTVkZm5aNUMyM1pFR3E0YTJ2?=
 =?utf-8?B?SllqbzUyVWhQT3hjUDZzenloVFVRSjkxMDdxakNMMW5FenptQ0F1OWhiZWEx?=
 =?utf-8?B?UEQzOTVxMnBST09Lbyt3UTRvWDBWYjVubFl5ZWJINFM4S2MyUklLMFdtUGtz?=
 =?utf-8?B?Y1ZFMnpxZnZCZUgxdUkzVHlPcktPYkRmYi8yS2ppanc0Rk9zQlNNdVFRZHdJ?=
 =?utf-8?B?aDRTMmMvNGluWTdGY3dyOUFvSUxNODdCN3JVbWlWMGtOTDJ0a3VDdDc5WERO?=
 =?utf-8?B?djZXa1FKN0YveVlnMTRENDFRMHVJRW5nazk3Q2RFTnRqOUt5TEZKSmVWbGpo?=
 =?utf-8?B?QnByMDhTZWRUOXIrSi9jYytXTSswbnhJNUJnWFY1aUN6ZG4yZ1IwbmRSSzFk?=
 =?utf-8?B?dk5uaWtYaWdlQmFad0thd2pGenlNWGJNYWFDMEZnWUllOVFMMHpyLzlPQk5R?=
 =?utf-8?B?SWRRbm8zc0VvY29YTVdReUJNM2FwL1p2VXIwditBYUtLcDhrMHR5d2VWUGpl?=
 =?utf-8?B?UVphYWhLQS8welBidUYvMldDVk15M0wrd3Z5V1g0LzN2aEFBTjNKOHRMOUZa?=
 =?utf-8?B?dTBUM3pOSWdRS2hTUlBsM3NROWZRUlBQZ1hhQWcxVzdsK0E3VTZNRE5oQnJ4?=
 =?utf-8?B?NTRhNTJFZXV1d3JJb3FQVXYvYjFFRXFRTUtncVZHMm42TDc4aXhZKzAwdXhD?=
 =?utf-8?B?QU9hRGZzSkV0RGhlemJYN24xSUljMDBoeTdPYzFJQWN5WklXWVkvVVBGSGNn?=
 =?utf-8?B?aUVNUlM4OHlnZHZxVEZsd0QwSEMwL1hwaHRYZUFHYVBDdEpDV1ZUUXZwZ0py?=
 =?utf-8?B?cEY1Zk9KNkJ6V3FTSTdSTzZHeGRZdDZ5YWt4dGZzVkxoalA5Rzlhc0d3emV4?=
 =?utf-8?B?ZGZEai9jTUhtQVR5TEo5Z1p2eDJQWGNqR090bEY0Zm42RGhuRmM4eVpqNk9I?=
 =?utf-8?B?dnRxNjBNZHRqeVZSQWFEREsrUTRYS1Y3TnVjdmkzakxRWUtEd1lzT0YwRnF1?=
 =?utf-8?B?b25UYVU3T2QvbDhJQk93N0F0SDVVdzJxR2wxNkQzaXV2YWdMSmVMWUE0VGRt?=
 =?utf-8?B?dHFBNXhyQXJHdCtta1JGakd5NTVNdS9aVlB6dlNRZWdZVUVJQWxSekdNWTJ0?=
 =?utf-8?B?R2Mwalk4S0J0UEIyMURjalJYbjc4eW5taUxVelh4c0tGK05vN1R5REVqVjlG?=
 =?utf-8?B?VHdHTFdKc2d2M1cyY2dDaGJsZm0wRXFkaUpqQ0hrLzVTcklFT3BuaDV2TGFK?=
 =?utf-8?B?TFl3a2NxT1FUUXhIdmZXdlF1MHpLSDRxaVpJa3RqMGxkb0VUUmVuUVA4K0F5?=
 =?utf-8?B?eDZtcEhtQUVjRVpOUUM2N0lhQ09iYzB6MERpSzlGcTh2NkdiRUFpdmdaYU01?=
 =?utf-8?B?YmdjRkxleG9INW0xZGVNOTA2V1RDRmZoc3gzamZNTjViR3N6YndJTVB2Szha?=
 =?utf-8?B?ckt3TmJuNlJ4ZGlMakxGVFpIV1FJR0Q5MXdCQUlnd2xBU0NDZml4Q3R4YU5u?=
 =?utf-8?B?L3JSbEY2R3ZPU3loNS9mbGNqMmFndXI5MVU1azlHektzM2Rtcmh4V0ZsNldq?=
 =?utf-8?B?dWJrd0syWkdRTlpzOWs4T2hRKzQ2eEVzRmw4TVZxclJua2NYeVRlaFo5SDFx?=
 =?utf-8?B?d2xpYW5RcVh4TCtKTVVzcC82eU5aSlZQL2tlR2tscFU2cFdnK1JtTlloM0ph?=
 =?utf-8?B?VVNPV1BndHdSdHltWjFvcG5ZWTh2MFhZTlhuRUpsT0MwbW11L0F4dmZhdENS?=
 =?utf-8?B?MUM2Y1pYY1NwMnYweWFJNXFzWXVxZ2tJNGplK01Qa3dCeDhQQ2ZNU2tZQnJ5?=
 =?utf-8?Q?VlPNhs9BlJnCKwJIpxbbxcc0WbCzgYMCR9YekmFMCYsWP?=
X-MS-Exchange-AntiSpam-MessageData-1: H7Yg7HZ3+/pAOQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec013a5-e1ea-4127-1111-08de96d689b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 07:55:33.8316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gphHb/uU7dgx71wA582xffjXxvMCyE0CabINA0DMjieXMtwbt3Ab0UtzE1I0LtoKLTrsfimIW59HLE90N0YENw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
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

On Thu Apr 9, 2026 at 9:12 AM JST, Lyude Paul wrote:
> In order to do this, we need to be careful to ensure that any interface w=
e
> expose for scatterlists ensures that any mappings created from one are
> destroyed on driver-unbind. To do this, we introduce a Devres resource in=
to
> shmem::Object that we use in order to ensure that we release any SGTable
> mappings on driver-unbind. We store this in an UnsafeCell and protect
> access to it using the dma_resv lock that we already have from the shmem
> gem object, which is the same lock that currently protects
> drm_gem_object_shmem->sgt.
>
> We also provide two different methods for acquiring an sg table:
> self.sg_table(), and self.owned_sg_table(). The first function is for
> short-term uses of mapped SGTables, the second is for callers that need t=
o
> hold onto the mapped SGTable for an extended period of time. The second
> variant uses Devres of course, whereas the first simply relies on rust's
> borrow checker to prevent driver-unbind when using the mapped SGTable.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---
> V3:
> * Rename OwnedSGTable to shmem::SGTable. Since the current version of the
>   SGTable abstractions now has a `Owned` and `Borrowed` variant, I think
>   renaming this to shmem::SGTable makes things less confusing.
>   We do however, keep the name of owned_sg_table() as-is.
> V4:
> * Clarify safety comments for SGTable to explain why the object is
>   thread-safe.
> * Rename from SGTableRef to SGTable
> V10:
> * Use Devres in order to ensure that SGTables are revocable, and are
>   unmapped on driver-unbind.
>
>  rust/kernel/drm/gem/shmem.rs | 191 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 189 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index c643f18b20838..111be446213df 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -11,25 +11,38 @@
> =20
>  use crate::{
>      container_of,
> +    device::{
> +        self,
> +        Bound, //
> +    },
> +    devres::*,
>      drm::{
>          driver,
>          gem,
>          private::Sealed, //
>          Device,
>      },
> -    error::to_result,
> +    error::{
> +        from_err_ptr, //
> +        to_result,

nit: `//` guard should be on last item.

> +    },
>      prelude::*,
> +    scatterlist,
>      types::{
>          ARef,
>          Opaque, //
>      }, //
>  };
>  use core::{
> +    cell::UnsafeCell,
>      ops::{
>          Deref,
>          DerefMut, //
>      },
> -    ptr::NonNull,
> +    ptr::{
> +        self,
> +        NonNull, //
> +    },
>  };
>  use gem::{
>      BaseObjectPrivate,
> @@ -65,6 +78,10 @@ pub struct Object<T: DriverObject> {
>      obj: Opaque<bindings::drm_gem_shmem_object>,
>      /// Parent object that owns this object's DMA reservation object.
>      parent_resv_obj: Option<ARef<Object<T>>>,
> +    /// Devres object for unmapping any SGTable on driver-unbind.
> +    ///
> +    /// This is protected by the object's dma_resv lock.
> +    sgt_res: UnsafeCell<Option<Devres<SGTableMap<T>>>>,
>      #[pin]
>      inner: T,
>  }
> @@ -117,6 +134,7 @@ pub fn new(
>              try_pin_init!(Self {
>                  obj <- Opaque::init_zeroed(),
>                  parent_resv_obj: config.parent_resv_obj.map(|p| p.into()=
),
> +                sgt_res: UnsafeCell::new(None),
>                  inner <- T::new(dev, size, args),
>              }),
>              GFP_KERNEL,
> @@ -176,6 +194,100 @@ extern "C" fn free_callback(obj: *mut bindings::drm=
_gem_object) {
>          // SAFETY: We're recovering the Kbox<> we created in gem_create_=
object()
>          let _ =3D unsafe { KBox::from_raw(this) };
>      }
> +
> +    // If necessary, create an SGTable for the gem object and register a=
 Devres for it to ensure
> +    // that it is unmapped on driver unbind.
> +    fn create_sg_table<'a>(

This method looks like it is misnamed - it won't create the SG table if
it already exists, just return a reference to it. Maybe `get_sg_table`
is a more fitting name.

I would have suggesting splitting the creation part into a dedicated
method, but it would require the resv lock to be acquired as a
precondition so not sure that's worth it.

> +        &'a self,
> +        dev: &'a device::Device<Bound>,
> +    ) -> Result<&'a Devres<SGTableMap<T>>> {
> +        let ret;
> +        let sgt_res_ptr =3D self.sgt_res.get();
> +
> +        // SAFETY: This lock is initialized throughout the lifetime of t=
he gem object
> +        unsafe { bindings::dma_resv_lock(self.raw_dma_resv(), ptr::null_=
mut()) };
> +
> +        // SAFETY: We just grabbed the lock required for reading this da=
ta above.
> +        let sgt_res =3D unsafe { (*sgt_res_ptr).as_ref() };
> +        if let Some(sgt_res) =3D sgt_res {
> +            // We already have a Devres object for this sg table, return=
 it
> +            ret =3D Ok(sgt_res);

nit: let's use `let ret =3D if let Some(sgt_res) ...` to avoid the
multiple `ret =3D `statements?

Or maybe even better, you might be able to use
`Option::get_or_insert_with`.
