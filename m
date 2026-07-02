Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507F7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BE310E08E;
	Thu,  2 Jul 2026 07:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="koxLJQ7X";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F91E10E08E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoKI6SIwBADvE0NbsHBH9noyoz07ryG0Qs2B9/cgXPZKlA3OlUGKhbPUNNaGjZ/btf/1SQw0AbEEwutQgN2ns1hN8DPZ+zd8B4eRP01XCDADaHBeKxKmRrH870POMCpENvFfSx1iZy6rgKCNeqbLigPq3kiE/ViltY3c4Tdj7lFZkj3DJUsyMcjTjIChLSBh0dAq0stdf8Ap9sTuuIABxp5HykewYaIWi5Lb2BJDkIh7N8LmzaeMqqMfUXjK0h9C5NsyPoi7W89q02DRNo8XL0IOgJ1V4/2+AZCONKnYD2EM1xfx1gWIOQQ1OVH4DssEAKwWfkUBQK7dA0qQi/EKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tho7tB/n4PWVqoRXsxMA8wFkHYfC/9K75SSToBobNWA=;
 b=RHPyJItsECIHBxy5c/aOqd9mUxyyxSJsiOYNvBVeI2zyrNM+e9FgY46Pf8ZcyL7geUdszDCCiyQI0pu4/fVmghN1krnmGbM0z3I9wd8S3zasZCVEmXRCRXNjog937iH4RAZpqEfMrNzm1PLx/aB0MD3f8beY0fN6URCg0xji/dyhmJy25iAK0tc763u6yYMn6DmE2QxLnS/UuzYKq0ZoCFJIyTKj1hFkInaPI+lcBynOBOvDFLP2CxsjJQlYWG+jaLVjVcBWLOe6PGRNJtt7Wy1LW6HDsAvcxInW4a7S4jbTvPJduKdCUfv02JjUrDH4tRqLNW7sHFXIj2bq0Et4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tho7tB/n4PWVqoRXsxMA8wFkHYfC/9K75SSToBobNWA=;
 b=koxLJQ7X6eUVVZOUawZH3wRj0vzRP0+ncsV8WSJqdUP6SSNzMzq/LuZuXGiQoSvGLEIpX7F/UtIGEPVQ1veWSdf+m4ukWUrQaoHwsp8FnQ2vNVng/0SVTsC4MvghhrYR/3D30KejLIKjQKI0vWs4ZDPAFf+DfYVTUcLs6EwezRWFRlEuEGXmHEbhJkZZXwElsXlBIQxA409Z/V2eW8Xg23UqGh2txN/ljKV1yq1oBZ5Pg+PLgYvPzF9gCjElpALfs639hvUOtrlCEK+3xH5LU1pEd8Bdu8F4M6YeRNWQW2/Au514MTkqie/6vCutkWxIOCYApxgrKnsv/5m/5PdULg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:18:35 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:18:35 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 16:18:31 +0900
Message-Id: <DJNWHTGYG1T0.3LNIHIL24WDRI@nvidia.com>
Subject: Re: [PATCH v5 17/19] rust: drm: Add RegistrationData to drm::Driver
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-18-dakr@kernel.org>
In-Reply-To: <20260628145406.2107056-18-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b5a8b86-3d57-4136-d254-08ded80a20d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|6133799003|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: B+ZdfZeRsLtVmc6/wyDcAeAZKo47PI9t5qKkNCttl+X275i1oekd+qCHUsNqpUcAyiTQnq7Jsa+SNLAbVCGzXv28GduxedeSl96axygYaOHQLGviM/cOqvtzGLFUde01l4ySr6fS3trKPxxHxg8cuEc/tE+LwWZEBvWrDIl2gSt9dQbqd4qKREk2/lvUqPqYXyH2or3kfcmv+YxUH7Mda7J+OLhKd0w0O/BSBmByjUXHEdYT00XQ4eXAsVsXbpNgaGwXoQuNAUJdbrLOfHeXrnykgaJ53FOEZRrbGhyDcURTw2aNNU+Y7O0I/MTMlfj8mA+EkZmlcU+/NoojFoTqa3c3I6/xX2w0eU/ncQUeZ4b7FsXBqPR/1fZHjdEGBzf5aX6blszdDuHVnawVkWKDh0bvoVezGCCOx26mU1QXUrYSvt+KW07v8uHdZ6446d9APTsrEUa4BZXO6Gg48csC41KJopSMwSZaBYjG8373QZkgSfxvIM6UVIxPYNjPr5aU2nSmhGdQLdskMOpmJsO+o5c+dT8yDn9+bO8oQBdTG7i5M6OhwDI+c/oEOskq3Kasnj5pePby97tZh8O6sS8v7fnhEDOkfKYFrI19J5Z82MRP0XFEXh45TFA0A0s5VAlimxu/EDa6orJnvzFrs9JFpX4ssIfllWPutCws9gxyBDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(6133799003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmM2citmWDdLc2NVYmpRZGlkekJzSUNmMkMxdmMvWVNhdDRqNUFSbEdtTVZ0?=
 =?utf-8?B?MWRzd0k2TFEyUlNJOWhEK1pibVJqZldkUG5FZmVwdU5SZXRvOWJ3Vk1IZzRK?=
 =?utf-8?B?cFd6NGhtVTBsTGtpa3VjeWVNa2lHQ2ZvYU1NWTF3WFlyWm5GNm1DTUFoM00v?=
 =?utf-8?B?RGo3NFV1VGRFaDZKenhxWlFqUzZzZDN4T3BqWSs5cHFlMzc5am0rMDAxUzdP?=
 =?utf-8?B?SStwanhvWFFISSttbDk2QkIwbUI5YldTNzU4Y1preGVyMklPbldmU3pBMlRG?=
 =?utf-8?B?MngxN3l4VEwvQWNSL2FKSGhORGFHZSt0OWpjeGU4dXFHeUE3OGZRNnlybndD?=
 =?utf-8?B?c1hpdFMwSlA2STNlQVJkcHlIMW9yS1FLejVrMmdpaVhpeCtjYUdWQldGbTJS?=
 =?utf-8?B?QWFHR1Z4TGxva0k1T3pCOUVTYWNTcVprNWZxcU5oNTNRVTRubmlRMm1WZnc3?=
 =?utf-8?B?cWRQSkorOEozTGRWK3NQajlNWmQxTTNUNEMvbWIrYWRkSmhrVXNMWVNxYU1P?=
 =?utf-8?B?T081UVF3MmkvZi92Y2d4VURoc2RpZXo2VncyeHV3Wnp1U0pCUU0vWExBdnRN?=
 =?utf-8?B?cWQwQitTeUhWR29WZXBUczVPZG5wUFdXR2dDODRhNDZlTGxaRzNmZENVTmR0?=
 =?utf-8?B?YnFkbFJqVjJFaUx0TzdncFVpcXNmRTViTU52SzBaaVZPcEZBcFovYVZzeWpv?=
 =?utf-8?B?aXltcUFtbUpCaWpEZ1VKZXlrandmbXE3Tkx5YzRtUUNVeHpIcnZZSEluSE1o?=
 =?utf-8?B?dlVCODcwYkdVYWdIckFzc3h5VENXZGQ4Vi9yN0llRWoyaU5CUi9Ddyt5clpn?=
 =?utf-8?B?VlNGZURkaEJvdzkwek9aSWJ5amtibFBYSFhjQzNDZWhiaFlCRExXUG9obDB4?=
 =?utf-8?B?M0ExbEw3UHo2Q3VRczNKcXZnYldubjV6SHNrTTNiclpNZCt0Qng4MlpRYnVM?=
 =?utf-8?B?YTNwNmxVWXlHbzE1UE1YNGh3UERiMzJlbVkzMlVnUmlVWFRUVklrQzNPSXo4?=
 =?utf-8?B?WVlsU1VDY3lDVkZBdjVxdmgxNUxSWkZIOFZzczd6QWdKVTdmWTlrNERsRE8y?=
 =?utf-8?B?aThRZFo3bkRDcWVmQ3czT2RDUDlPKzJSUE1RaDRWTlVpaFZYVVJ5Tmg3K0hF?=
 =?utf-8?B?SWM1R2dwam1XcXY3TDNkbVUxSllINWFFUm1tblFEREtpQjgxZW55QS9NQlNm?=
 =?utf-8?B?Wkp0MGhSSXZkN3cxZGJvclA4NVFzQWgybEdyaElubmhXT2hKRmg3UFA0dlBK?=
 =?utf-8?B?dnowNU9Zcyt4Y081OExIekc3S3M5amVNbXp0YXpydS9sd1hReGlubDhDaFl4?=
 =?utf-8?B?dEl5TWJGZEFrSVNJaGdPdm5ZUHdEcGpCMjkySlVLc1VLUGtlWTJHMVk1VGRk?=
 =?utf-8?B?UEU5aUFVNW1NRDJHWlRuNnFNTEFnbmxYQkhpY2RBOElya1lzMmg0SEhaNHFn?=
 =?utf-8?B?dy9XUTZHM243TVZIbGNlSGdYTVoxS2EvS1dlS3JTTUkxN214MzdhYm5ldzRy?=
 =?utf-8?B?R2FVQlMzcXczZUthZDltZTloT3ZSMnZzMkNEaHQxVFlzWDFhRE1wVUFRK01x?=
 =?utf-8?B?QnBRbmhic3U1OUdwTFdsQmFiNXZ5cG9vbElQTFh3bFZmU2pGQ0RoVkxaWGI3?=
 =?utf-8?B?VDBMZUNmOUEwUjdZekQ3aXlCZjI1dDVzcHlENGVuSEVZUTh6UUhqcHVDcHlH?=
 =?utf-8?B?UUhoWnJOOVQ0Zk13L25oRlJoQ2NNQTZtcWtnWS9wczlZVG9NNzFxQ3h3WHRo?=
 =?utf-8?B?QXRzNk8rQjc0bjZ5NXdHQzNRWld1b0ttMmlpS2ROUFRXeXJhRDUvaVhZRS85?=
 =?utf-8?B?dW9yZHBmbjY3NXhvcnU3Z0MyT1MzU0I1eDZaMGZNci9aS0JxSFVycGdJQy9w?=
 =?utf-8?B?WnY5RnNvaEV4TEsrTTJHa0tBQ1pLQllnbmJBeURncUNwbEZLbVBYWGlyRHlG?=
 =?utf-8?B?MkpscEV4OEpqbDRncVNlbHVKVnNpQVFvMDBQWG51ZWEwbU9sWmVMRXd3OVpP?=
 =?utf-8?B?YmtROXVuZGRrL1J5ZkRVZW9ZT3B0ZkJtWUowY3BsRW5VUzIwWDZGSkFOdnZH?=
 =?utf-8?B?QUF1eENDRWtsenIvN0dJTm95VkFMTG9yOW9RaDFpQ2pKZFBvMnZaaFF6QkE2?=
 =?utf-8?B?dC9DeFpSd0NxZk9ZbWRFQlNhQ2FSY0pFclpvUk8zWEwrTlpmdVVxaWxQOFdY?=
 =?utf-8?B?STM5ODZIeE90V1Vrc1hCVzRvS2JRZzZvZ3JZVHA1UlZ5TlF0M1RHOVd5Z2lj?=
 =?utf-8?B?bTdBMXhQUnllcm9wZ2NZZHJIZm9ydkNobHVIYlJJNE1MbUJWbkdpNGFQL2F3?=
 =?utf-8?B?T21sRGpHc1daVElLNThSMDBKQ0NSQ2VQUGorTGREZ3Z6c0dlbTVBVlVwbUcr?=
 =?utf-8?Q?dyRLw5vi28ilt3avYUD1BmKeiNBW6EJ+hh4D2NNduOCmf?=
X-MS-Exchange-AntiSpam-MessageData-1: OrYvIJck3GnSTA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5a8b86-3d57-4136-d254-08ded80a20d1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:18:34.8866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ft3oLIvbQ7+nSek/zjZa6GSeD7xKkR1oNN21iKBZ2nA2xZj9xuDQ6zufm9SqoSDreLncQ7tUGrzDWv4zQhGKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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

On Sun Jun 28, 2026 at 11:53 PM JST, Danilo Krummrich wrote:
<...>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 5e8b75dab0a6..7a3a0e21e955 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -32,6 +32,7 @@
>  };
>  use core::{
>      alloc::Layout,
> +    cell::UnsafeCell,
>      marker::PhantomData,
>      mem,
>      ops::Deref,
> @@ -247,6 +248,9 @@ pub fn new(
>          // SAFETY: `drm_dev` is still private to this function.
>          unsafe { (*drm_dev).driver =3D const { &Self::VTABLE } };
> =20
> +        // SAFETY: `raw_drm` is valid; no concurrent access before regis=
tration.
> +        unsafe { (*raw_drm.as_ptr()).registration_data =3D UnsafeCell::n=
ew(NonNull::dangling()) };
> +
>          // SAFETY: The reference count is one, and now we take ownership=
 of that reference as a
>          // `drm::Device`.
>          // INVARIANT: We just created the device above, but have yet to =
call `drm_dev_register`.
> @@ -270,6 +274,7 @@ pub fn new(
>  pub struct Device<T: drm::Driver, C: DeviceContext =3D Normal> {
>      dev: Opaque<bindings::drm_device>,
>      data: T::Data,
> +    pub(super) registration_data: UnsafeCell<NonNull<T::RegistrationData=
<'static>>>,
>      _ctx: PhantomData<C>,
>  }
> =20
> @@ -278,6 +283,28 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_de=
vice {
>          self.dev.get()
>      }
> =20
> +    /// Returns a reference to the registration data with lifetime short=
ened from `'static`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that:
> +    ///
> +    /// - The parent bus device is bound (e.g. by holding an active `drm=
_dev_enter()` critical
> +    ///   section via [`RegistrationGuard`]).

In practice, `registration_data_unchecked` is only ever called from a
`Registered` context, so can't we move its definition to an `impl<T>
Device<T, Registered>` block so this invariant is enforced by the type
system?
