Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AFAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 02:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE86A10E25E;
	Wed,  1 Jul 2026 02:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2ovn2ki";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9FA210E25E;
 Wed,  1 Jul 2026 02:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNusTiGfWo5D77suVSbuAVrXeYhQm97Lr1ZDVX18nt0lIliQZxAyJ7zQVV9dIRISChXTT/NB39jMUGgVorY3kCZSIhQV56ymLGBtx3sfKVDllWuFc9aE35h7lIZA+MHOEa+eLK0O5gbl/XKYWo1BBxPs93IVEhdATRN3bn+A6h/raMSELcUTdKylEyep6KKuW2giyXokBgfFDXW/n+XNo7PBGaUmigkE6mIOhe+N05hnzQ/eoJGmBcmvIy3szzePo+Fed121LcaknUpNNeYYIOEGStn05nJTQ4bPileaQLxhV+tmOYkWR7NEFWoL7wvhuc0v9H4KFgB/IMzB6pQ9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU/3XkIK9QkQaDW4cTWBEgI4qRZGbi9nt7D0Ls7CFD4=;
 b=yoshGs2v0GcZWtHYseSgG+j5bPn9xTempWL4I8ZHqb4ChcloS8Ikg3oINK7oaqIaq6PAJrUdIBzywgDbP5YhhaeAv/EkI2eUgfTF+yiFwG5kCkJkS66z/Wa3lYceQSEuId783vrNX0pLloE+/fnpNWjzutrYLibTQ68Jqyy0ReNLrdkk15iNx9eoyINNgMHC0G3VNyRv73DIkMTk1zMAQCuGEHUkGg5Y8HqDXPkNKbLYWK63p6rub/wkBAy7h8NkioMmPt/EiW+9iulD7K1JL5adWErmSOicY2u+5G3a/NO0EQcWauWwLleyfbKUzDxQ82JMpZXk9rW1lv3IgGmYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU/3XkIK9QkQaDW4cTWBEgI4qRZGbi9nt7D0Ls7CFD4=;
 b=Y2ovn2kisZc5FuHx2+tmpxKvSIQAN1DVL5/oublFKl2Rn2jOJhKmjTUl9LgFFMUSmo3JoNwT/gw5edK4Eqgt+0qCd87/OT/KV+SDFcdnHCDSae+dy6DlUa4bAnG39u86L4oQsXsnDWHNyk2y4jsNbR5kWF1nC6FugFrnVbxXqunI2bqSbh35r5NSw38PwWXQz2FVpskXZR828DU+kQMy0vWCmz063sCUJgaQXxD9KrUYhFU1NsKtAGbZfJRYf6xXyPXCv19iohUd2M1hf/25jg0ko5je42h5xeRFJCTOIRWygHmBv597hcHxXhULKcL6JKEY3MbCEsHNjR2IIvQZPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 02:54:36 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 02:54:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 11:54:32 +0900
Message-Id: <DJMW95MDK2J2.1MWRD8I92FKW5@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 03/13] gpu: nova-core: gsp: replace BootUnloadGuard
 with local handlers
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-3-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-3-5539d8469590@nvidia.com>
X-ClientProxiedBy: TYCP286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: ae67a2f4-4c3f-49e6-3bd2-08ded71c15d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|10070799003|376014|1800799024|921020|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: G1qeJo/SnNuW3c0wr311m1H5nFQd8XByY0/huZEfwzyU8Xj8RNoLUi93AvV+rMBg2RMPMg3fJXSrLckWwJFfmGiH/hZWkk3QoaZH+OFDmipxOWXZHXPTl41oJejze9sfxN9NsD9KK6Z19mfS8e45BPZucrTwRApfX73R25hYc9SpO+xhwGw1C2gYTnUmCbm9T05mkXTKhaPywVVIHhnjTTMofhQuVgg9KjHdTwfia3pOIkXeAKSe+0iQQW3a+ef2M4v0KkP7tPEYOCYFlFSEIbP1rKC6NrWPmly5RwH/qS0aYv9PkehjyIbMl4FIuMWiiYouTkB24rI3Mh1jO6MVIaFqq29DKLRX8hqndCJLHYTZnCXU+ygchZ4R8oHA+8B1+f6o9+kTy/oYPFpw7+SH0ur06zmhQWQNBKvkEio4UjaGqZ1lZPG1AMESMAkDd8xhkWaS2XaXVIdEcJB9aLzqd/c8vwP6+nzkjw4awt1B0xwyx3eupfnYLoLRMQx9++ZjadFKrTOmrwBJiorvB2kuu6vHLXdn3g4yRtdHYPQ1xZ4WdkhiKQW3O8VnJxIzhOecaKjpVd1lEwi4KsuarTvE2WsxpLkVWx6YJ7sj1AhnMD1TigglQ6bvm8T6D5dyIAWIlJY1DLJKwJMHE/xUfZzwbS1SqwVmUF7nQmy56TjHPtto0RumOll4n1+In68FY4TZFdHLLmbBk5cxRzalVdyexw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(10070799003)(376014)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1FJcjlhV1l6NVRXQXdEZ1VzemVPb3NTN0hTNzdzd0tGQmRTS1pGY2FCL2Nt?=
 =?utf-8?B?UWdyakR0RzA1L2RsNXhINnUvTjNjVHZ3cmdXKy9wZVZZeVBKa0s1Tk5TeXQv?=
 =?utf-8?B?dERuNzhDK3AvNmRISm05bFNJZElCL0ZPd1BJWi9udmEzaWYycnJCT0tnT0lP?=
 =?utf-8?B?UjlMS2ZlWGpKdGFPREhUMmhKaGV3cUhTQlV3VlBTOXBNSklmT0pEcFlPVmwv?=
 =?utf-8?B?d0d1V3M3a0dTbHk0VmsyU0JHR0VrVEhnbzZ0dXNKWTVCUTZGU3RmdSs5TkZH?=
 =?utf-8?B?RG9IZmZGb29hUWJCdlVSdUZ2QlBaYWpMK3dxT0UyR0lQR2pGK3hDTXhlN2RO?=
 =?utf-8?B?TlFleFIxcmNsSHdSSFVyU2thd3MxS2hwbGhEZ1dZZmFGdlF1N3lQSmkwdzVJ?=
 =?utf-8?B?M1VUM3c0VmdRSURyaFpsd3d6eExzam93V3h1eko1SFM3dXVIZE9JNkxBUkJQ?=
 =?utf-8?B?cGNHY1dJdzNRYzRJR3czaEdYN3NDd2Ftb2wyWDR4Smd1dE1sbjFDT3dZU2h4?=
 =?utf-8?B?QWxWU2lURTRZb2cyTGs1Nkp3Z2JXYlJUMWhva2xGOVJlRW5sc1RUYmtaOHZ0?=
 =?utf-8?B?YTFJbTRmNk5ZcElsN0J0MERBVEUzTWVQcmh1L0JnbGVjY056RjRmeExUeUlh?=
 =?utf-8?B?cTFQWXB6ZjlSUi9LQi93NXM0SlB1NEd0YjhveUp5MDNqNHYxRytoK1BBRDVp?=
 =?utf-8?B?VjlJQ21LdzJXVncrOUhMSHZ3S3hLWG1iWWpENWhPSmVBSG5na2syc0FoVlhr?=
 =?utf-8?B?MEpnQ2pyNCtQRE1WUTJBSEZSWXJIWE93dzAxK1dYeHNYYWZWMjVTcFRadFJK?=
 =?utf-8?B?cWRFZnNBaHdabWNtUVRkWEtHRXdaUDZmZ0thODQ1eWo3WGovNTdBd3IyS2xK?=
 =?utf-8?B?SXBMZEUrTGNadllURnBYeVlqRHhPbFhDSU5uUWMxTlRHQ3NIMGFOR1llT3dM?=
 =?utf-8?B?T1V6TjJ6QU43ODZET0lyakFqS20wNnZMUTJ5NjhOS1VjanJQc2Y2MkdDZmZL?=
 =?utf-8?B?Q0MweXZoVVIzZXBrOWlsTE5GRG5mRXJEdElXYWxtdlBLVEdqR2FpM1hLUlVB?=
 =?utf-8?B?TXREcmhtRG5OUUpmNlNyTHEwOGw1Wk45M3FUT3VDR2R3TE1XK2lMSzliSllq?=
 =?utf-8?B?Tk1RMklrcENId2w5NTdaNHpTVkU4MzFaeUZHaXgzMnFuaDJZOE1xcDYweHBz?=
 =?utf-8?B?dUZQcEl6SjFwbzlWaHB1NEVadTcyRXlrK1hJajViL2Q3MWdKbkgxb05aa3ZH?=
 =?utf-8?B?SlVYSlVnZnl6RkRVMWVldHZraGFidDhBdXluUjZIUXhFYUJ6WW1vM0lVcWxF?=
 =?utf-8?B?aE5jRW9rekVVNytvcldCVVlkV2wyTFJQZTN1d3FIZFRaYXRTMWRUaGxEVkhB?=
 =?utf-8?B?cVd3c21RQ05WS2J6cUUxbSsvMTU2SDVaOW95bko2akpEQW9rTndBMmJKNXFi?=
 =?utf-8?B?MGMzWGFzSURmVWNzNmRmNEdpb0QrRXlqZ1JNTlJuVEhkcnU1MGdGR0VObTlw?=
 =?utf-8?B?RmN3R0JUZkFDdndLRmhPN2MyRk1nUFFTVWUvYTRDM3VHYVVQU2p5VDNkWjhT?=
 =?utf-8?B?VnJmS1U5bzd0VGt2R096Vm5KVTBWWEFNWU10L05PMk1VeVZzdHhCN0JHTVlp?=
 =?utf-8?B?WGo3QmpXVzhlTi9UT3lGbXdmczJVMEltbm9HQkJLWnc2TFppd2xCZWxHQ3lU?=
 =?utf-8?B?QktRTFJ1bi91VE5mWTJHQ1JFL0grMkcrWFRpR0l5QlBiQit0RG82blNEd3lB?=
 =?utf-8?B?R3Y1cHU0bXdxeE4wYVVKMFpwUFdWTkxXcmVuOHEvWllrQVZXbVFrbWRDNkEv?=
 =?utf-8?B?MFdkWmVLSjUzZDhJZS9ZQWZTclVGL05mMm5jOFJqS3R4MFFhNGFWU09tQUVa?=
 =?utf-8?B?cStxVzZJVnVmcHpFRDI5ZVROanBEbjA3cmpsNTZiQzh1a1ZjbDYrYXFWN3Fv?=
 =?utf-8?B?N1J4MnZxK0ZtaXZOQXRHc28zTWlGeG1mM3k5SXRncFc4emZQZWlSR2tXZkxS?=
 =?utf-8?B?eE5QZkdHK2tXNjk4ejVVanI4MG04VDZRSnlaZUxCdTFmUjlCcEQrVVh5aWRH?=
 =?utf-8?B?M2dmMVJkTGpqV1YvbXFsdVdBYnI4N3IxeDY1SVhpMGw4UHBnOFdBN2t4YmdJ?=
 =?utf-8?B?ek84ZjJVQjdEVXUrc1QxQlJsUzRyb3l6UXFHaGRmOXBHYWtyK3lwQ1FuODFC?=
 =?utf-8?B?Q0RUVnNjNnJHczB6RkdLTXlHSjhXYytpTmtjd0ZnZ3J2VkVWZFpJa3VCTDA0?=
 =?utf-8?B?ZGFqWVBiYlBwS3BYdzJQR3hNdVV4amh2d1ltTklVS3A4QmdUM3FRckN3dDJN?=
 =?utf-8?B?UkZ4NEJrRlV3MlM4TmNHUGltclRvN3pOWi9ZWW5tUWs5VkR0dUJnNGw2ZnBN?=
 =?utf-8?Q?oNfornCpGR2KvDUtAJ8P0nd6r1+gEsCn6TTFZlfUqrhk6?=
X-MS-Exchange-AntiSpam-MessageData-1: qhAfyYUMier/gw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae67a2f4-4c3f-49e6-3bd2-08ded71c15d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 02:54:36.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPlzvSsbxwiMZiDs9UxXpNzQzR/PxdLYr88Cj8M+hEK1IXhJgrWBkpnsfD4dHETmJECUOsD7ErzQJpnVaw0RBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
> When adding the GSP unload capability, we introduced `BootUnloadGuard`
> to automatically call `Gsp::unload` whenever an error occurred during
> the boot process, in order to try to reset the GSP to a valid state.
>
> This approach is not well-suited to the errors that may occur in HALs:
> by definition, an error occurring in the HAL means that the GSP is not
> booted; yet the first thing that `Gsp::unload` does is queue a shutdown
> message to the GSP, which will inevitably result in a timeout when done
> from a HAL.
>
> Furthermore, `BootUnloadGuard` is problematic because it holds
> additional references to the boot context, notably the `Falcon`s. These
> extra references stand in the way of making some of the `Falcon`'s
> methods mutable, since those methods would require exclusive access. As
> this behavior is only needed in one place, introducing dedicated types
> for it is distracting and unnecessary.
>
> Thus, remove `BootUnloadGuard` and adopt a two-level error handling
> strategy:
>
> - HALs are free to handle their errors as they see fit (most likely, by
>   running their unload bundle if it is ready by the time of the error),
> - `Gsp::boot` uses a `ScopeGuard` that runs `Gsp::unload`, since the
>   GSP should be up and running by the time `GspHal::boot` has returned.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/boot.rs      | 67 +++-------------------------=
------
>  drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 20 ++++------
>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
>  4 files changed, 33 insertions(+), 90 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gs=
p/boot.rs
> index ab0491b57944..536f2e341c01 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -30,66 +30,6 @@
>      },
>  };
> =20
> -/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
> -///
> -/// Stored as their own type to avoid repeating a long and tedious list =
in [`BootUnloadGuard`].
> -pub(super) struct BootUnloadArgs<'a> {
> -    gsp: &'a super::Gsp,
> -    dev: &'a device::Device<device::Bound>,
> -    bar: Bar0<'a>,
> -    gsp_falcon: &'a Falcon<'a, Gsp>,
> -    sec2_falcon: &'a Falcon<'a, Sec2>,
> -    unload_bundle: Option<super::UnloadBundle>,
> -}
> -
> -/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
> -/// [`UnloadBundle`](super::UnloadBundle) when dropped.
> -///
> -/// Used to ensure the `UnloadBundle` is run during failure paths.
> -pub(super) struct BootUnloadGuard<'a> {
> -    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
> -}
> -
> -impl<'a> BootUnloadGuard<'a> {
> -    /// Wraps `unload_bundle` into a guard that executes it when dropped=
.
> -    pub(super) fn new(
> -        gsp: &'a super::Gsp,
> -        dev: &'a device::Device<device::Bound>,
> -        bar: Bar0<'a>,
> -        gsp_falcon: &'a Falcon<'a, Gsp>,
> -        sec2_falcon: &'a Falcon<'a, Sec2>,
> -        unload_bundle: Option<super::UnloadBundle>,
> -    ) -> Self {
> -        Self {
> -            guard: ScopeGuard::new_with_data(
> -                BootUnloadArgs {
> -                    gsp,
> -                    dev,
> -                    bar,
> -                    gsp_falcon,
> -                    sec2_falcon,
> -                    unload_bundle,
> -                },
> -                |args| {
> -                    let _ =3D super::Gsp::unload(
> -                        args.gsp,
> -                        args.dev,
> -                        args.bar,
> -                        args.gsp_falcon,
> -                        args.sec2_falcon,
> -                        args.unload_bundle,
> -                    );
> -                },
> -            ),
> -        }
> -    }
> -
> -    /// Disarms the guard and returns the [`UnloadBundle`](super::Unload=
Bundle) it contains.
> -    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
> -        self.guard.dismiss().unload_bundle
> -    }
> -}
> -
>  impl super::Gsp {
>      /// Attempt to boot the GSP.
>      ///
> @@ -107,6 +47,7 @@ pub(crate) fn boot(
>          let bar =3D ctx.bar;
>          let chipset =3D ctx.chipset;
>          let gsp_falcon =3D ctx.gsp_falcon;
> +        let sec2_falcon =3D ctx.sec2_falcon;
>          let dev =3D pdev.as_ref();
>          let hal =3D super::hal::gsp_hal(chipset);
> =20
> @@ -118,7 +59,11 @@ pub(crate) fn boot(
>          let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::n=
ew(&gsp_fw, &fb_layout))?;
> =20
>          // Perform the chipset-specific boot sequence, and retrieve the =
unload bundle.
> -        let unload_guard =3D hal.boot(&self, &ctx, &fb_layout, &wpr_meta=
)?;
> +        let unload_bundle =3D hal.boot(&self, &ctx, &fb_layout, &wpr_met=
a)?;
> +
> +        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |u=
nload_bundle| {
> +            let _ =3D self.unload(dev, bar, gsp_falcon, sec2_falcon, unl=
oad_bundle);
> +        });
> =20
>          gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
> =20
> diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp=
/hal.rs
> index d3e47ef206de..851d1f24c137 100644
> --- a/drivers/gpu/nova-core/gsp/hal.rs
> +++ b/drivers/gpu/nova-core/gsp/hal.rs
> @@ -24,7 +24,6 @@
>          Chipset, //
>      },
>      gsp::{
> -        boot::BootUnloadGuard,
>          Gsp,
>          GspBootContext,
>          GspFwWprMeta, //
> @@ -51,15 +50,15 @@ fn run(
>  pub(super) trait GspHal: Send {
>      /// Performs the GSP boot process, loading and running the required =
firmwares as needed.
>      ///
> -    /// Upon success, returns a guard that runs the GSP unload sequence =
if GSP boot does not
> -    /// complete.
> -    fn boot<'a>(
> +    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use wi=
th [`Gsp::unload`], if one
> +    /// could be created.
> +    fn boot(
>          &self,
> -        gsp: &'a Gsp,
> -        ctx: &GspBootContext<'a>,
> +        gsp: &Gsp,
> +        ctx: &GspBootContext<'_>,
>          fb_layout: &FbLayout,
>          wpr_meta: &Coherent<GspFwWprMeta>,
> -    ) -> Result<BootUnloadGuard<'a>>;
> +    ) -> Result<Option<crate::gsp::UnloadBundle>>;
> =20
>      /// Performs HAL-specific post-GSP boot tasks.
>      ///
> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/gsp/hal/gh100.rs
> index 1d06405a32f6..5fe445d73599 100644
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
> @@ -23,7 +23,6 @@
>          Fsp, //
>      },
>      gsp::{
> -        boot::BootUnloadGuard,
>          hal::{
>              GspHal,
>              UnloadBundle, //
> @@ -143,27 +142,22 @@ impl GspHal for Gh100 {
>      ///
>      /// This path uses FSP to establish a chain of trust and boot GSP-FM=
C. FSP handles
>      /// the GSP boot internally - no manual GSP reset/boot is needed.
> -    fn boot<'a>(
> +    fn boot(
>          &self,
> -        gsp: &'a Gsp,
> -        ctx: &GspBootContext<'a>,
> +        gsp: &Gsp,
> +        ctx: &GspBootContext<'_>,
>          fb_layout: &FbLayout,
>          wpr_meta: &Coherent<GspFwWprMeta>,
> -    ) -> Result<BootUnloadGuard<'a>> {
> +    ) -> Result<Option<crate::gsp::UnloadBundle>> {
>          let dev =3D ctx.dev();
>          let bar =3D ctx.bar;
>          let chipset =3D ctx.chipset;
>          let gsp_falcon =3D ctx.gsp_falcon;
> -        let sec2_falcon =3D ctx.sec2_falcon;
> =20
>          let unload_bundle =3D crate::gsp::UnloadBundle(
>              KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBu=
ndle>
>          );
> =20
> -        // Wrap the unload bundle into a drop guard so it is automatical=
ly run upon failure.
> -        let unload_guard =3D
> -            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon,=
 Some(unload_bundle));
> -
>          let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset)?;
> =20
>          let args =3D FmcBootArgs::new(
> @@ -174,11 +168,13 @@ fn boot<'a>(
>              false,
>          )?;
> =20
> -        fsp.boot_fmc(dev, fb_layout, &args)?;
> +        // Keep the result as we want to wait for lockdown release even =
in case of error, to make
> +        // sure `args` is not accessed by the GSP anymore.
> +        let res =3D fsp.boot_fmc(dev, fb_layout, &args);

In the error case this no longer runs the unload bundle (which waits for
GSP halt). But, we need to wait for GSP halt to ensure stuff is properly
torn down (e.g. in [1], not needing to wait on FSP queue is predicated
on GSP riscv actually halting, to avoid an issue on reprobe, IIUC).

Separately, are you sure that GSP lockdown will release in an error
case? I'm worried that we'll just timeout here, which while it probably
works in that it waits long enough, is semantically a bit weird.

What about using a ScopeGuard that runs the unload_bundle? That way we
will have waited for GSP halt. Later, we could add additional HAL
specific common code for trying to reset GSP in case it doesn't halt.
WDYT?

[1]: https://lore.kernel.org/all/DJAZIGJQ72A9.1688NC74RA4SY@nvidia.com/

> =20
>          wait_for_gsp_lockdown_release(dev, gsp_falcon,
>          args.boot_params_dma_handle())?;
> =20
> -        Ok(unload_guard) +        res.map(|()| Some(unload_bundle)) }
> }
> =20
> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs
> b/drivers/gpu/nova-core/gsp/hal/tu102.rs index
> 87ceb8878f01..f78e2489f5a6 100644 ---
> a/drivers/gpu/nova-core/gsp/hal/tu102.rs +++
> b/drivers/gpu/nova-core/gsp/hal/tu102.rs @@ -6,7 +6,8 @@ use kernel::{
> device, dma::Coherent, -    io::Io, // +    io::Io, +
> types::ScopeGuard, // };
> =20
>  use crate::{ @@ -32,7 +33,6 @@ }, gpu::Chipset, gsp::{ -
>  boot::BootUnloadGuard, hal::{ GspHal, UnloadBundle, // @@ -259,13
>  +259,13 @@ fn run_fwsec_frts( struct Tu102;
> =20
>  impl GspHal for Tu102 { -    fn boot<'a>(
> +    fn boot(
>          &self,
> -        gsp: &'a Gsp,
> -        ctx: &GspBootContext<'a>,
> +        gsp: &Gsp,
> +        ctx: &GspBootContext<'_>,
>          fb_layout: &FbLayout,
>          wpr_meta: &Coherent<GspFwWprMeta>,
> -    ) -> Result<BootUnloadGuard<'a>> {
> +    ) -> Result<Option<crate::gsp::UnloadBundle>> {
>          let dev =3D ctx.dev();
>          let bar =3D ctx.bar;
>          let chipset =3D ctx.chipset;
> @@ -290,9 +290,12 @@ fn boot<'a>(
>              .ok()
>              .map(crate::gsp::UnloadBundle);
> =20
> -        // Wrap the unload bundle into a drop guard so it is automatical=
ly run upon failure.
> -        let unload_guard =3D
> -            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon,=
 unload_bundle);
> +        // Run the unload bundle to try and recover the GSP if an error =
occurs.
> +        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |u=
nload_bundle| {
> +            if let Some(unload_bundle) =3D unload_bundle {
> +                let _ =3D unload_bundle.0.run(dev, bar, gsp_falcon, sec2=
_falcon);
> +            }
> +        });
> =20
>          // FWSEC-FRTS is not executed on chips where the FRTS region siz=
e is 0 (e.g. GA100).
>          if !fb_layout.frts.is_empty() {
> @@ -319,7 +322,7 @@ fn boot<'a>(
>          )?
>          .run(dev, sec2_falcon, wpr_meta)?;
> =20
> -        Ok(unload_guard)
> +        Ok(unload_guard.dismiss())
>      }
> =20
>      fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &Gs=
pFirmware) -> Result {

