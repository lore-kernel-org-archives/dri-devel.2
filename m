Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EDECA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D32610E0BA;
	Wed,  7 Oct 2026 06:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLtsRQCv";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03BB910E0BA
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 06:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzGpo1+F0XmN7YQ4GJdNSRy9gl2WP7w68cbk5wix8k3xj9m8x6efD3sd+rxBI7kpdkchNe/7ZOyuIOB+wbHNfLkuzSWNVCDaRKG+an2umOEaiBSNdWywC9aVbsAwlRgSKz8pBzfSidxlWxgeqHTEezKztbBNNBv5n2S3ccQ7EmYHQlTUQU4c1ldgz9Rr/dKx/3R56XshxD4YmUVhjSBUI9fFISppo2vschOsiDR3mLco/6BTk7XLyqgA2dMFotTSWu0QljZNZv6lIM1+/UN60Gcpugb20Zba8lg3gOAxsrf8RORK/ywzwO4pt7/FSYD1knBuPppNvCN81ECy/bDSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB40svs2ywYVMQLuPUS/KyFdccDEUgqlw69wUlw0XH4=;
 b=vfQxhkOYNxEiKdfYR4j3KjQ9KtoP5LfJPFv1qrJsnfI7eHDm8byeDWNs/6hnZ7E+cLIzBkWSxV5fIJ2IGTCiTcjM8ihFOMSYDATjjASn9YYo0PIRLFPLYbTuqQmzNgMja1temLDxJI5gABG3PcqdHPC907TDG8ke6UsKcBmS7yaDU3Pjk0V2EwyVFaTO6pyRCSYvKRewPgP3tx6wgtXOQ1+cDYFODBGil4M4oolvB13GXdZ4S3r4QVYGAvIgWj0rQ0PXsNdvkdEl3ejoExrXR6BQY3FbATIDhmPxc2Y+J6FC1tyg1cA9rMrzjWOlTEpXesG8ucqUpriNNAalo8PlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB40svs2ywYVMQLuPUS/KyFdccDEUgqlw69wUlw0XH4=;
 b=DLtsRQCv7sM2p5jtFPjXys9Duuz5J/IoJp4sTpryhKb8/3EJijFlA4i81zY/nsVOv5Tr2tKU3Hoe7K80LXsWGMpyFj65f+76yVOhmhq2A/xoTAsfaTkepyN4lqbpDlzSI74sh680k85wJ6U4CKD4jAJA3dy64PjLZQUW43Jdriy7dF5/hQQGalsQbbqpL++kkuH6VOFJneNUqLEgr9soOMsT5a7X3bFspne/KPMtcCo5txbVTL2OvmCjuGrgnrL7ToSrLTwZydfUvz7wdLHzFKRUouD/6POA7ZnymLm5qb8NWdcd8MY+u//zrsoUtgJ3THbBbUnwkXvsGWdG3k28jQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::992) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 06:27:52 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 06:27:52 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 15:27:49 +0900
Message-Id: <DLYE5UBDLFYU.3RTMUE90DJPDK@nvidia.com>
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
Subject: Re: [PATCH v3 3/8] rust: alloc: add ArrayVec
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-3-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-3-f04504c262c2@nvidia.com>
X-ClientProxiedBy: TYWP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: dd238104-3e7b-42ee-cd75-08df243c1d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|7416014|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: oaI6uB88scGzy88mNgc6eSn4d5x/kZofMukehBkE4wN6QtzjmKktVAPd2Vwk9aKI9jELuTI6KbvXLyxkrzBAHCUQ6UQZzS6gfzlgcLk0rnebitJ5SQg/bgvI6Y5TzcS6YSqih2NPDUIc4Hd+lofA955U0PJX3jcWoy2byJeB4GlfmrBMRFtcGoJwXZ9eivyAGrYmQ0tS/UA1SgYidnMDemFlqOF9228YqdxQzzsNxzf96gq6CUZUDIedcq5UyovbdTchZTOdW3mx5QmM3J1W1lzP46jJ620w0LL57LWt76sjNETD4bqxFCNOUAWQCgnfzdVfqrfsqw3MgCgmSG9ktC7lGucFjCN21h8Ri8RkwFwBMN42D3xlDX/vQeL5ggCRRmRmuXyEDZQ6rvAAZPq8s10mwsk/slYjrCs5VjUuCAc5VAsHQXpfT56OL9wGKC2JAo4pfkOHeY0OD8qDbjJCYglgbSOM9hrDjbN/gnZcIUq10lmxbYnDTHKxnXKCtBAfhLDmE6HMME9VZC/kCeo7U8z+BS5T8+4OwgOsNEXGHwwyRuVJV6JKkGeH0k0+FGd5Y2N7pE5RrlMouzjnvdBSY5xLM6JIdUMvyi1yH4WtOqZfr5Q3e9rFtrqtROyUgyNrsDJ+MTeFNEa/YjrUi8TE5JfBgVwSeVVWirMfHYKWths=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(7416014)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDEwT2h6NVNTNzc1T0J6Unkzem9LRmpUOHhyeWUrR2VhUXE5cHkybDErOTVN?=
 =?utf-8?B?R2xRa3VsTG5tRXBzTEdWM2NIc3RyTzBFR2ljRzhiYlNjaEFUS1ZpdDk2M29F?=
 =?utf-8?B?TnZyd1RobGVhNmhiQ2VGZ0U5cWZRc0pXRDZSU0V4Y3c1MGVEM2o4c0VrUTJR?=
 =?utf-8?B?MkpXMVFKZ2U4ZTF2Rkt2SHMxU1dJaVVsODg0a3dpQVFORUs4Q1Y0QTFjWm85?=
 =?utf-8?B?Y0t5MjBkc0wxWmpieGJLNjU0OVZMQkJzdjJoWXNMSG9HVWM1MjRYU0JYekVF?=
 =?utf-8?B?MEQyVmpGMHJYOFk5b09KL1ZFYzhDMFJRSFJhcjVuSFhZNkpFalFtSXhhSU1N?=
 =?utf-8?B?bElqUU9DVzZjUE83ZU11V3Y0SVJYVTRZWVZwSjlFbWJqK0JVZmcyNi9UK1JG?=
 =?utf-8?B?K0NzUys2c04ybmh2Um5FNksxVncyUWhOei9YVmJydFcwbDRXTUcxOUdMT3BB?=
 =?utf-8?B?UVZiMHJOejlTTEs0MW0xd3V4YkcwNWw1THlFNlRlaW9KVVVTU1N6QUF3VTlq?=
 =?utf-8?B?R1FWa1p2eU9qRWg1R2kweXQ5ZHhyRHY0V09vS3E2V3dLOVJjNStyWTFqWjh2?=
 =?utf-8?B?WXU1cTZxa0dEcG4vZGdCMytiUHN4Zldua3VHWjRWN0NNWmg1cGhjNDk5NWpI?=
 =?utf-8?B?SmNncFpFWFVNeWRvaWNFUnI4V1AwUFlDRVZDMWlNQVF1RjZGSHlrOUE0Rm9I?=
 =?utf-8?B?RUJJZFpwQzVXelFWNWorR1JnQVpKNFBpRTVwemhzMzBNS3hmZEVjeEs0MmZx?=
 =?utf-8?B?cTBDSERseS9MYUJ5MHpwTVVBVzlvcCtQaDdjWTlkWmJKTWRVUnVYaCtmNUJl?=
 =?utf-8?B?V0VRdUx6aHdETUs5RkNXY2FoZG16cldRUGdxN2VHa2hSVDAwQkhDakpqSnJj?=
 =?utf-8?B?Yis0Y0oyTGpJbUE5aExybEd6WnRiUlRBL3hmMjZNY012WUF0N1VaK1JLSW1I?=
 =?utf-8?B?cm9hb3hqOVF3d08zMkxZMkRBUU5hVWY2TnVTeHBPK2VFRXY1Q213N1o0U2Y2?=
 =?utf-8?B?akxhSW5STXVKdTBvOXpoa2F1RVpJTnoxYndzbnU1eVo2bkhhQmtTMi8rZUFD?=
 =?utf-8?B?OXBlODl4NllUU0pjWWRkVndjOHk2b3BRLzdKM3ArQ05WMzZaeGlxVUtMMzFl?=
 =?utf-8?B?TzlzT1V0dUc0QzBHeHY4TXI5TE9LTGhST0tFdkxIMGpOc0NmVHM5YjlLU2lp?=
 =?utf-8?B?Nm8wVkptb2V6dUc1bVJhMFFDK25CMHZVZ04xL2RldnNOQzZMSmJHMWFpY3FK?=
 =?utf-8?B?RWQ0SU44bXBURjBiRlh1bCtpMU9zZDlkcUNFZlo2S3JhZXd0WVpiZ2piaEtD?=
 =?utf-8?B?dS9zclpjNDVVTm5Mb052bmc3V1cwS1RCWjhlTjBSd2oxMWlnKzFNUXZmdXdF?=
 =?utf-8?B?bDlzN0lIS1RaYVRXYTlXc1RkbExFRFpub1k5SEY0V0sybUFUd0VWMXpodUNX?=
 =?utf-8?B?bWlVUHhNV0MyTVgxQUM2aUJNTHBBZGkwSXJmUGt5UkhmTk55R2E2eC8rOTBv?=
 =?utf-8?B?cldORllpL2dWMTFVV21Ebm5qMGJwY2c5Vk5HTE16dW9FYUhYU2l3Tjh3Ui8r?=
 =?utf-8?B?U3F1NythcUs2eVpVbXliYi80eWhrRmgzelVUQnhyUTBtTTlzeWg1U0pwS2t3?=
 =?utf-8?B?ZkRQVGU4c2JqakxraVE2UUR6b0ZLMXZYaE9Hc25sd2R1R1g3dytqa055RTkz?=
 =?utf-8?B?dWNZTHdBMDU4ZjhZTFQ0OXVPU3VYcGFuMGU0SjMxRVl2dkZrRjdVQVVWcGR1?=
 =?utf-8?B?bFNWRjhvZUM5UUNGRFdnRkVhWGVqdmxZOWJGR3oyQkQ2MlFDQ29yTktjR2VO?=
 =?utf-8?B?aE83ZDJQL2tlc3hVRzNsMkp2VjlYQW8raTUzMk9ZZEd4M1ZaOHFIM01PR2R6?=
 =?utf-8?B?OG14T21MS0ZpbUFKYmxVSXl0ZG5IVVI1VXh3M3BGdFUwdmVtRHU4Y0ROaFll?=
 =?utf-8?B?WU5LWG1UMG54YVRwNFdBRjFCTU9SR3Z0cU9WWFpZdTJpNlhWTGdlbVFaQ2xB?=
 =?utf-8?B?WlBUZVlOWm1maXBnRmZnL1llOHgxRGc4ZU1UUTVUL250cHhJcjNNMWxMVUph?=
 =?utf-8?B?d3YyREJhZm83dzVxS3dHd3p6bWJHb1NWSHA0N2Vqc1JyMmFsVUE2aHU0dldX?=
 =?utf-8?B?K0xIeTVvQ3ZUV3VaWGE5M2dKVTBRTE5VVHA3V2svMFliYlp0MlhXcmljMDVJ?=
 =?utf-8?B?em9lYVZ1TjRySUN0amtoVUVwaFE5RUNydEl6akIySHZYUkFwUVVZMWtkTU1W?=
 =?utf-8?B?NHlDcllrWlRML2p3cjA5a1pVdHJmUGFpYm1Ud1dCejQ4SzVUKzJFNVZlOFI5?=
 =?utf-8?B?ZmpHZmZYWlV0R0E5a1NlU282dG0relphNm1FSTVHWWxVMkRPK0RUTTlLcVl4?=
 =?utf-8?Q?hdrFy7rwKpQZVH45y0upfvFJO4W9vIuF2+VtNE3VTG3sz?=
X-MS-Exchange-AntiSpam-MessageData-1: yEGQiknX6gD1GA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd238104-3e7b-42ee-cd75-08df243c1d66
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 06:27:52.1406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZUG9G3Om3Izmm6ueZkchXW/AJr1a2LMQ8azUuDtiNTGAQUmTXqt39XElialB+t1/125W0TRkcY5Gpkg95u1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
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

On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
<...>
> +impl<T, const N: usize> ArrayVec<T, N> {
> +    /// Creates an empty [`ArrayVec`].
> +    #[inline]
> +    pub const fn new() -> Self {
> +        // Clippy triggers this even if the enclosing function is never =
called, so skip if clippy is
> +        // on.
> +        const_assert!(
> +            cfg!(clippy) || size_of::<Self>() <=3D 512,

Let's make this `512` a defined constant.

<...>
> +impl<I, E> From<PushInitError<I, E>> for Error
> +where
> +    Error: From<E>,
> +{
> +    #[inline]
> +    fn from(e: PushInitError<I, E>) -> Error {
> +        match e {
> +            PushInitError::Full(_) =3D> EINVAL,
> +            PushInitError::InitError(e) =3D> Error::from(e),
> +        }
> +    }
> +}
> +
> +/// Error type for [`ArrayVec::push_init`].
> +pub struct FullError;

This error type covers exactly the same pattern as `kvec::PushError`
(even the debug message is identical), can we somehow reuse that
instead? Or at least align the names by making this `PushInitError` and
`PushInitError` becoming `TryPushInitError` to reflect the actual names
of the methods using them.

Overall there are quite a few methods here that are still unused by the
end of the series, so this patch could technically have been smaller. I
think it's fine to keep these methods as they will inevitably become
useful, but it would be nice if we could simplify the error handling a
bit, or at least harmonize it.
