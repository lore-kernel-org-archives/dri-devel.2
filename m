Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ECDC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB06F10EBC0;
	Tue,  7 Jul 2026 08:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJr78ElG";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8B910EBC0;
 Tue,  7 Jul 2026 08:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3mV/R5iAs1hT7pAODchoxRYIyhkyP1kkOIopmCgwpzAs8IUderGxWZO07O6MDTcfY57OdQJzW/obOG96mnXntS6c1Qsh2q1cp6dk/Qrqc+W6AyviA3Op94vzGWfF/ow/upUIzSV7kOE3KUOjdEP2QSH1osOF0Mjfnfpr5Dz3wk84ARLpR0C3lYEh98KDdEKFrbjrv+RRVBcyZVqlJ9OfVP09R8+i24ekhdsSIBPHu0QTftD7swL568L5K6lNrRFVruX9+cA04pXeB6SeBbB7zNCTTfdHF7vKa5wKbsWzFkBYCi87xLtBeEjkJTqp6KZV/13aVDrn9vHeMdZTI7BGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipDclMNQamfbku/jCrOnL9T7UeRAwsiDmwMW07MeO3o=;
 b=F9nUhmfEhU6YdPQTlVCvIFY7AOFPLNzfeXyfi8CQt2gWpRScuIb6YS7dHZ5cvs/RTEEMhAsGEaMN7QFTIBhVIPgmRXHH8qzFV3w5qegL3jhqPzPr8r/KQdBTw5OpMO3ejM8uILS3ob0mBpdcYrleqSGens6lEtfYgfd/DLNvFqFggmwb6eTlShdfrTuo/w1NdCoIgdJcNTbOZ3eA/TUlR00il0ZCvhXGHMRLJxgmzm0FoyLMbUEvFOup94QMx0aohBm6m+v2k26DguNIva3BB4NptLS5eJlygzT3QnUlJ0D7qFP81Kny8MlUeQiGUxDYMXypn1UWT+BhOO8DVsSayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipDclMNQamfbku/jCrOnL9T7UeRAwsiDmwMW07MeO3o=;
 b=RJr78ElGJfMy6Svap+iX/a33b7j/pBo7GrdSEfgDW0H1+SkC6a8BQOaJ3XMXYqTZt0PH0YcQ0TEKgpxHomX9+S3ioq++b8Gx3dZjODslffmmQNUUArzWT0AiOsqE1pD02UqOR/zGv2nOxx+VAZ/Mm+rtXxCCGJPu1E9GjCOzRWxl4sB7GHf1GzDoHrqJB4qhBIxY3HZt317rvwbzYuyYxXYLQ1YT7Vu7GZ04pm/a1lchdIn7SVH2B9Lm6Tc8vq+NNh3S3FEWNjTrgr7DXqRnPE0dH0mopEgTmjUvc96XBkrhagmULT1uyFDQtktQs3D3yF9Mez3e4eiVS0wGvKB9qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LVXPR12MB999195.namprd12.prod.outlook.com (2603:10b6:408:3dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:05:00 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:05:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 17:04:56 +0900
Message-Id: <DJS6M2YBO8RS.33T3S32EFHL1Z@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 03/13] gpu: nova-core: gsp: replace BootUnloadGuard
 with local handlers
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-3-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-3-ecad9346387f@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:405:378::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LVXPR12MB999195:EE_
X-MS-Office365-Filtering-Correlation-Id: 139115ba-cb0f-4de9-4321-08dedbfe70ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|921020|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: TuRLXm2J/ijitG7JeG1BBMk6U658UoQ8gAR3X7AEH+jxfsiagv5IWHp/nCzqsFxwrQmRCaylIZINegE3Nk9hxSjIyzWqm3FBv5jkf1wBfvUtBWA27xsW/ndlFV5+Yf2nzyY/IvINpZEuLs3xidcII9pWV4J696jtxqfJFeolnaDyX6kClNQQpegfk/DOhALzcaqNZD7y8YA9uOan1Ephrk2oSBfXjDzy8W589YsLYpRwVlpBxxlgO0rMbKtzt663skor5fbBgo7RRpPgBRWAX0oScD1Ywi+DPssq0PGuoNtQdT1IX4ShVOrSPpsC8klJVx64smM9NnU7BkLcNZXYYjnQF/3XGHUF5PHjY+eN8GULDKnblyYry3lXmnoHT0U9xYa7XrgYX0szoHLodf+7vum+CIOMWFMscDZ46kR2J1c3XEn4PUQUfViW523/pTizsQ13CRyW8BvHXZ2BixLpW6wlMfX5DVS64Fzv0Z8RtO9stf2QVh/vlRoEakMJW4x7ME8pT0yq6zg/aIjxB+Jxsq+c1MyIVHJSibkwgzZ9+/NnbkRk3imnn7iFmJyFq7hZLaVrJvsxNJ81oBqW+jqheMZlylhImVlq884cM0Vu5g5xmYKoC3UaU5D3Fzag6qZnrpj05Rr+4y21m24OVEjV60b9RdtLQ78PCIXIGwUjd5n16wngKU2rulP5cRLBHQ2YUizV05SPzwtJP8Pv5/FxqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdLZGpnY3lJTjJkV1BYNnBrUFIySWFlUURBS1lrY1o4dU5PYjhtWjRLNkNM?=
 =?utf-8?B?K01rYnJhQlFTY1Z6VDd0QU5jS2RRcVFNaU14NVc2SmhjQ1FmbUxmQVAxSlBs?=
 =?utf-8?B?eERZNTlSaEpMbW1GYWxUZHkyalFESkl3TmVXbUNmaEZzbFlPRzNFZkIzVlpv?=
 =?utf-8?B?dzVZM2pLNG5UL0JtMlFIY0VwMXA5Vm9KT2dvaXdxMTdFMGpCaGxtN0Y1UXF4?=
 =?utf-8?B?b3hUb0dYNnVLYk50bTdpbnFjNXNUVTk0dnNNT1FsWlBXeHJiRjBnZG01MHBB?=
 =?utf-8?B?U1lDODV4Y3NZSG1pRXYrM0VsUS9ML1hCQ0Y0UHVIanh3MnRJeGJuNzAvWm55?=
 =?utf-8?B?SEFqcVhudkwvQlc5c1BOdVFFczZER3NEOWRlMXJpRlpJUDZRcW9vc2tXUGg1?=
 =?utf-8?B?NmpVNnNmMEhidWhBQURnQlVGVEhmZEhNVmpybmVmR2JlOXk0Sm5HamZRYWhq?=
 =?utf-8?B?ZkNTTWFPNjFJenNEb0xOZVdlWFFQdFpvTWhKdHFra2hDQVdYRHUzWjJ3RTZ5?=
 =?utf-8?B?WDFheTZaOVloZHdTM3FWOWd6bHEwVk42RzY0ZDRkejNZM29CbkVCUXQyN3l1?=
 =?utf-8?B?ZUw3VjJZR1pqN0tUb1dBMjRPVENQS2ZhYWdXVTJBYkZaZ2JDSU9yTHQ2N3Vp?=
 =?utf-8?B?aWVEZ0JOR1Q0Z2JRQkZ2YmJzY2lyWXpzTG9JWFFDdFNWWEJ2a3JKb204VHBG?=
 =?utf-8?B?OGZwVEZaMjNZVkVaWEFwYy9ib1NLb1JLQnpRK0V5THlJT21YZEJvZmpVNkJD?=
 =?utf-8?B?U1RManpLOE1FU2swUmNQYVMyQTVzbUlDL3FheEhxNEhZSG1ObCtqZG9nbEFE?=
 =?utf-8?B?UXl6eXJ5YUpqSUVxVUFGOG1pZmpIaTdhWFVZMUI2S0xRZUU4UU9jTGtQL2Er?=
 =?utf-8?B?dVNlOXFDbUV5SndvWHgrYzlQUlFtdmdNZzZpSFJZaXV6MFJ5dU1ISFlqV2lC?=
 =?utf-8?B?akY4K1FSSTBxMzJxdWJKVDRsaGwvMUZlMlN5UGVSLzVONHRpUWNDUjl3ZHds?=
 =?utf-8?B?aE1Fa0kxZVBVUzF1bzJwRndGeUJEenloems4MGo2MUJoNGlXWnNZc0JORTA0?=
 =?utf-8?B?VDZOU0FsRTVoYzBSU2ZTa2xhRlpBZVZtYjFjNm9QeFozcmEvUytBTVY1NDhQ?=
 =?utf-8?B?NlF5VjRRZEJRZzBEMlpSQ2tuNVAwMW5EZXJ5TmNINUxWd2N1cERwaXFhMmVo?=
 =?utf-8?B?WDRQM2RnWndUU2hxalRqR1Mxc0tobXhnREM1SWFaWVFRUHlKZWVtdXp6WWhh?=
 =?utf-8?B?dzhWcVYwU1k4QkF3UjlxOTNsVnpJaTdDY0xaai90STR5VEdyYUZyK1F4VCs5?=
 =?utf-8?B?b0RyNTN2TWZDT1lHRVJqaGFlSmlVYW1ZSVVpcGtDQURKOEFsajJ1KzNYamM4?=
 =?utf-8?B?Uy9JN25oYld2ZTlLY2xYS1hGTjRBeXFZSDMvZ21vZDkrYXdlbituMFY3YkJK?=
 =?utf-8?B?dnNHcTgyc1k5VSs5NWd3cDRJRHFnTy9abFJyUFA4bWp5NC9BbDYrSnExVHhH?=
 =?utf-8?B?d3hZWVc1K2IzM0ZUTWtkc0lYd3A0QTVqTlhhNzcrOExwalNoSFNPdGVrVitL?=
 =?utf-8?B?MnZtdEFENlVxWDhWQmhuczJENXdUVTFOZFVMSlgwdy9mMkZHcXo5bVQ5czdN?=
 =?utf-8?B?UW0ybUtrbFJ0RWFHeHJwQU1rejN2QXZEMENyY29ZTTJCQVh0bjZ1SkpmN3Q3?=
 =?utf-8?B?NG9BYzdkc2NpdmZRVFFSK2N3SXVYNlNiREluWWRiOGR0WmpzNjFTeDI4UmVK?=
 =?utf-8?B?VmN5U2lRYTNkV3puRDlnbkJLVHNuSVJrN1V6TTRCeWhxUnFrSzBUY2wyWTI1?=
 =?utf-8?B?enpVTUxHalllVDkyWGpzUm5KLzBWUERNUFhjUFdiUFJoc05xaXhVNlJzMEFp?=
 =?utf-8?B?dlZpZ2lidFBSQVc0M0luZGQ2T1ROMGVsSGlOWHNXdHJiUjhKSG56QVFvbXZn?=
 =?utf-8?B?WE9MNDFUbitINmsvazloTURwZnNENVFnVnk5Y1FlQ1FjZVUvOWw5OHpiM2Rs?=
 =?utf-8?B?RHVTV1VGdUczcUV2QVlXN0ZJRjFiQ2tTdnNpMFp2WFBTbTFkdFNvTmltZXp2?=
 =?utf-8?B?RXhqTkZaN0tROE1FeWhsUWdsNk5CRkhWOVZZSFVLdlNnamQwNDh2cE8yOVhK?=
 =?utf-8?B?TUZXNTJuTFBqK2NReTFvUFBBZW14N2JwYUFkQ215bS9GTktjV1dDZlZ3RUlT?=
 =?utf-8?B?Yi9NMUtPZEVCZkw4UTN4WnB4SFlsSkJpMExqREt3VjQwVHQrVXNKZDd0UEda?=
 =?utf-8?B?WndVUTBMZUIyVzdhWGNua1JMQThuK2htUDNWZ3NKVDBGVjJEQkJqQjM3YjU4?=
 =?utf-8?B?OUVFcVQwalpuOExkS2h3NHBkZ093eS9uUS9PUFRIVW5PQjhVM2RQSUpqTVVj?=
 =?utf-8?Q?QhIrnKYnorahp6pY2+djP0J3ZQXqjQtklNmhEzbnGP0xN?=
X-MS-Exchange-AntiSpam-MessageData-1: fKBRt3+UGQMEvQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139115ba-cb0f-4de9-4321-08dedbfe70ff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:05:00.0138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfqXeTdZj6ILBGEwCBSxEU3CA8gJPsWxiVMKyDen0F5xkHp9lut+UsdE6tdu2TjBXLroQTaMopfCAi6uWS63nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999195
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

On Tue Jul 7, 2026 at 4:21 PM JST, Alexandre Courbot wrote:
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
>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 31 ++++++++++------
>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
>  4 files changed, 44 insertions(+), 90 deletions(-)
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
> index 1d06405a32f6..18c889f9f413 100644
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
> @@ -143,13 +142,13 @@ impl GspHal for Gh100 {
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
> @@ -160,10 +159,6 @@ fn boot<'a>(
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
> @@ -174,11 +169,23 @@ fn boot<'a>(
>              false,
>          )?;
> =20
> -        fsp.boot_fmc(dev, fb_layout, &args)?;
> +        // Keep the result as we want to wait for lockdown release even =
in case of error, to make
> +        // sure `args` is not accessed by the GSP anymore.
> +        let fsp_res =3D fsp.boot_fmc(dev, fb_layout, &args);
> =20
> -        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_=
dma_handle())?;
> +        // Wait for GSP-FMC to release the GSP lockdown, indicating that=
 `args` is not accessed
> +        // anymore.
> +        let lockdown_res =3D
> +            wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_par=
ams_dma_handle());
> =20
> -        Ok(unload_guard)
> +        match fsp_res.and(lockdown_res) {
> +            Ok(()) =3D> Ok(Some(unload_bundle)),
> +            Err(e) =3D> {
> +                // Wait for the GSP RISC-V core to halt in case of error=
.
> +                let _ =3D unload_bundle.0.run(dev, bar, gsp_falcon, sec2=
_falcon);
> +                Err(e)
> +            }
> +        }

IMO we should just ScopeGuard here too (after args creation) to run the
unload bundle. It will avoid manual manipulation of results which is
error prone (since a ? added later will break things) and also halt
happens-after gsp lockdown, so it's a natural sequence point. Also I am
not 100% sure but I am not fully convinced that
wait_for_gsp_lockdown_release will correctly detect all errors if they
occur.

With ^ change,
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>


>      }
>  }
> =20
> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-co=
re/gsp/hal/tu102.rs
> index 87ceb8878f01..f78e2489f5a6 100644
> --- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
> @@ -6,7 +6,8 @@
>  use kernel::{
>      device,
>      dma::Coherent,
> -    io::Io, //
> +    io::Io,
> +    types::ScopeGuard, //
>  };
> =20
>  use crate::{
> @@ -32,7 +33,6 @@
>      },
>      gpu::Chipset,
>      gsp::{
> -        boot::BootUnloadGuard,
>          hal::{
>              GspHal,
>              UnloadBundle, //
> @@ -259,13 +259,13 @@ fn run_fwsec_frts(
>  struct Tu102;
> =20
>  impl GspHal for Tu102 {
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

