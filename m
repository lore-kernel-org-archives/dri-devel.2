Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46089CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A360C10EB89;
	Wed, 29 Apr 2026 13:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rEgPZpK8";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9DC10EB89
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKy0j2jyPMX2QhnpMjknUY4f0HiOGXKXMsDGmx5PazG5tZyohMXjZT8Q9GQzSu7aln8bhIj4w/VEqDWlHpq9IDuO/zW9iEbPNe8R1W/t/pS/SSZVOjXXFDM906ipIXkbfCB0KIMe56qcWAreME/NZ9MDZdPFzuV0tluMQ/UZeh1RONLeOHB5cc8JS3IUiCKFt9lYNESLKgIT/y8nDny6lgH+/JaEhzVsdApJf8y5hAqO4CVIQiWpFJeKS0PkFVxcMMFbTBD/r+q9JARS2yQX1AnstFT6dHKzsgEtSKYcaGLx+tMFeVju6Jl+NH0A6rFsovLOa/XyH7KjULFqQLO0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgqKm46YvZ1x2MKO/eGECjjvY7duxifmCkxMFcPkUPo=;
 b=eO2hWipYr9zCeaQb8QCh8L5kiFNLRlbyClu1wEdUfGJ2W+crPn2OxnlFTt2xhs49S83a0PS8CAdGfjR3K3MgkILQlyxdxYRP32o+MW/2f/W82UJR9y9nOeUUa0nDPD65uc8wvz7KLk5cLclmEtmlEO6grLG+oEJznCasJTD96leuY1QKFL3LBmt6b1PEpKd3Xk3zB/0uzSd12bm5llJ/Ii9KKTgo1gGLOW03168Lvy1idpDw/Z01BSymqLZPJUozNtiqV757B1YbC3GskodPtjus6jszKyckBoiNmJZRvXTZzvD6XLiEF0o5l9F/Ag7leoe+sg9WZm4jJRSmdM4s5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgqKm46YvZ1x2MKO/eGECjjvY7duxifmCkxMFcPkUPo=;
 b=rEgPZpK8jKus8P5ThIibdb34JRIUnvMSX7pFQSuthB7W/RO2xvfLCjfJEaeEK+9FIVEt2JnILsG6B1OvgZdKA8zv+H514hbrryxs5UzPMywwuckEuhuTi9qv5erEISphYxRizjs9HsEq6gFAzZ0kx5d4xpQyv94awYLcgm3Ty92ZJ0thEu/34ZRK/umd1DLjnjhd5rk4UliGc7BUm2BblaQvZgp6Q7XC6cDA0IHrbw3jJh0Sxo6HE/ZOn9UR1MR/lSK2wumY6nLHD9l73BPSC/drAUd6XsB00GnKt+NivPmc2oFY2V4rHLmBMKHGpioYP0YvvN14UA/YGhkmYguQwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 13:56:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 13:56:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 22:56:55 +0900
Message-Id: <DI5OVZXSRQ04.2QHKSMV6WDHWI@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/11] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-4-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-4-8f648aef7a85@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0170.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7e2590-2440-4b7e-264c-08dea5f72e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: s/7EC9XjYEjythGlj8aCO9JY6d1GRIqKMqtppFdkkg5updqqOMmhsu97q2f3wB58wpq07BYPpOE2enUJJfE7gHJOqxkHxB2Y7oWE9waX3tJ183CvvfyBvEmmymQ/mGN2apRz7Awt4Zlo5UvGtKjg1QZQQEx1CQt/0C9ddWfR/IjB71d95yuyryaR6ha//+BhI67pbRGmQ8SgqlqUB0ehi+FcRtRtmPRtQ4zMU17EVD+ClXQzvMNFNNOuPD+5Y+ozdomBijwmqiHyUhNVFZJe/qLQgHsaSOrW97sCisw2kRbuQBqu8AMdNznuhEkRvDQhjREVpVRSW2f94QDfMwa91SqGryKpdU6gFERLGnctY2zF95vaX9DmaErcPR23MUerJw0Z2FHfZfjSIwTGmqSWIQPMXlAx2GY5aQFp62//A6eQC1crBGKjMriw0ioqeFXTNfaj41ywYTAwK8YQ6euujYMVfSwy+jmlwgwznOk8dgQkNuGKmepMYk8wvvGObeTCDy4+rWWAzHyNDhgczJlVESRO/DsRSP9LvZY8SMBzp7ZU1iLzpbxVYY45dC6aeDmyLkr4V8t5dtpvoY4FQoUu/dUa478IbnDdOSuatjpFKwu/OTfbXlEi5sY50QLQ8e+Ia3JQ8mE/JbNx2gQDdAz3g565hJZ5tgCtTeNlpv0ka0+1xZuqcsJ96QSZM5ZYUNr6XjSRsZC4dfrSTyP/2E/v1BsOd9P+sK3ZJ8cHRhXy5tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzMrdnFkZGNoclRnRTA4TGl2M3FhVmJyK1haekh6d2pmVERha2w4ZkJBTXFM?=
 =?utf-8?B?Vng4WWh2V3NWalRKemlQaHdocWNFMlR3eWFKRFFUdDVRVGdMRGJ6NTZqcStK?=
 =?utf-8?B?ekwyaXpFWHRSVXp2OTZSeE8zbTM4eW5tRDJncFZLeFYzc2RJV0RXZ3BYV0E1?=
 =?utf-8?B?MHNTWktYRXJYZVI5Yzh4cDAvcUk3cDhBb0RuOGJTblR2TDRBY1EzaDJtbjVx?=
 =?utf-8?B?T2gvQytmNnA4bjJKTm5RZ3pXRG40RVU2bzZ6ZDBuRm4zYXhQWjB2ODFqR0Y2?=
 =?utf-8?B?TDZJamZGd25yM0RTbFE5K1Rib05KK0FYWFFJcFZnMHpkdFhWUDY4QklQTzRI?=
 =?utf-8?B?UmtZL0lHTm5GYUM0MFV3dVYxL2U1c2IxUjRsak9ReHEzeEZMUWxNdnBWbUdi?=
 =?utf-8?B?V3lmMklpRGNVNXpBNXpJV1ZhTzJ6M2x1R2JTRTdnWHh6L2YvQThGWEZkNXZ3?=
 =?utf-8?B?aHhMZlNCWkk5dUJsR1JGNnFuTjNzdERsMjZ1N1FhR2VkejlhdlBMK0JlQzNI?=
 =?utf-8?B?R2xsU1Arc2NSZUcyMlVVWTJQSFFBclZhclMyZi9ZTW5EZjRUZTg1SmRMVGIz?=
 =?utf-8?B?RkF5V1B2MGdkeHVQdHZyMG9oNW5aUncwazRYaDhyWG1YQ3Vib0M1SEJSNENn?=
 =?utf-8?B?TFQxL0lYLzc1cGdPUVRKZWhySjlBNlJoTUx5TjArTm1FVGdCWVpjK0gyK0NZ?=
 =?utf-8?B?RmZPekNZY2dUZEk2NERSS0wzaDNJM2hYd1g0TFVZS1BvTlZSR251U0o0MnR6?=
 =?utf-8?B?azF6SjlKdTVBa1JFbWdUZTFyV1BOemxicnA0ZHNaWUFQVjN4QVJGOFc4Z0xm?=
 =?utf-8?B?OUU0S29VaE1TS0RCKzBNOWRUbXFtS2FEQ1Mxd0RFS3llMCtMMEREbXFvWDdt?=
 =?utf-8?B?OFFscDNqMTMvNFVxVDdHb3gwSFdrd2lvbmdCcUtJc0JkclVkZzNIM2hxclVy?=
 =?utf-8?B?VmZ2VjVpcm44a3BnQ2YydEhVUUJjRDBmMitqd0RSQjNxQkFQaU9RZWpYSGZs?=
 =?utf-8?B?L0l6V2w1dHFMSityL0Jubzk3c1ZjOXBLRUhtaGlGWjJPMTVzeGpvU3FKcUhR?=
 =?utf-8?B?dU5ybmI4eDFaaUptL2JDTm8vdk9iOFVCNVB2Tjkxc2xLVUp5YU11U2dKb3Nk?=
 =?utf-8?B?ZTJ4Y2lQUzFsTUgwa0hUamJnaEhzVmprMUgzZytQRFM5KyswVFhvajExQXRH?=
 =?utf-8?B?c3ZjWkRmODBKd05lMWdCMDJVMnQ2YlN3emRJL1VkZGZCdWg2TFRiMTlXNTND?=
 =?utf-8?B?RFVrOGZ6MVBHQ0JUWlFOMkYrTFAxbnVYcHZVa2lONitHQVlBSmxYMkJKL21X?=
 =?utf-8?B?UzVGVXBvcEx4Wk5SK3lmV1FqNEhHNVMzUWc5clNiWW1lMmJib2ZRWWVUNFlT?=
 =?utf-8?B?Qy9kR21WZ0pxcU9NQzhHWXJhSnRUOWw1RHJDL0xxTHlCb0xTUjJEZDY3dlky?=
 =?utf-8?B?SUJaNGxmVHNnZzVJbGpkV3RvUVkrN0E5T01kU29pU0pybGxOL2h1NWRMTjdL?=
 =?utf-8?B?VXJ5SS9BbFRjMXV4bjgwRDIzRjdvajAzNHJUL0ZWRVB2bFUvWVRNTURsQ3A0?=
 =?utf-8?B?RmNjVmV4MHRYbEdMb3ZVUHM1dkV2NkRSNEd5MmhnQlIvZmVBSUlGMEVHWlhY?=
 =?utf-8?B?ZEgxa1o5YWxnT0MyQzdjZkZZcC9DRmhPaVVrTllzNFZiYzdjZGs0cFVGQ2x6?=
 =?utf-8?B?dXF5Nmp1VmVHN1pDaXBoU1RzaGdOL0krcy9naWpCSkExVTVvUVlZRzhtODRl?=
 =?utf-8?B?T2RCM01nRytFbEpyRE5YL25QbnZXM2hmZGxsUkdqaWZneG9nVk1DbFB3MUVN?=
 =?utf-8?B?RDRJNFRUaW5xZURhbkxnNEFBN0c2MHgydGJ3UG0rbGVsd3ZIK2RpN1VOZmRC?=
 =?utf-8?B?Z0JpSWVocjVIampQZ3JWaVgrRHVhVi82am42clVZZythaUtDRE4rNjdwaWZG?=
 =?utf-8?B?SlNZYXZOQUpmeDk4UEpybk1jTXFEa2tqRUozbkZ0YWxKcE5mUFZERFNxNENB?=
 =?utf-8?B?OWlEbjJubEVZNkY4Rkc1NGxobXlla0dOOWs1SVIvZmhKQW9LaDZibWJQcXJa?=
 =?utf-8?B?eUIwQlpWSXV5aHRvRG52dm5pbjV0ejFwNm1hTkI4b1VsdTd0M3BBOXgxRDJY?=
 =?utf-8?B?b0RnU2gzTFVZZXh5QU5oR1Z1eWZOWjA3YWs5SmFsd1g4YnRJZkE2VmZaZ0M2?=
 =?utf-8?B?eDZPVi9QL0ZPNjhaMDdWNjhxYXR2MU9lMVowR1R6STJIdnJJRGpicG5wTlBD?=
 =?utf-8?B?ZkY0dGc1S2o2RnZVVmZvV2hlcFlZa3NUdlJvYXJRVnBMeHZCOUkxUTJ0Nk9M?=
 =?utf-8?B?aFJ6NWFMK2hlRG5xQzVYVGd6WTZlQ2FnMVFrckNwRWVGcTBTdDI5NjhsUVZN?=
 =?utf-8?Q?vN2kXlX4NfAhFQcA5Hmlqd+lT6YFNrD74atcK5pGFnf08?=
X-MS-Exchange-AntiSpam-MessageData-1: vvwb9/OZZbuXjg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7e2590-2440-4b7e-264c-08dea5f72e91
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:56:59.3287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCc9+KHHjEO8aKannOefIGSbgz12vzyqMYmo+IGwAcNTmL5gCR1xC9QvhDSQ8jB+Cn29nSnv1qOQjBE2A1vdzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
> Use checked access in `FwSecBiosImage::header` for getting the header
> version since the value is firmware derived.
>
> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode =
extraction")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios=
.rs
> index 632c8a90ea76..bc752d135cbf 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -996,17 +996,14 @@ fn build(self) -> Result<FwSecBiosImage> {
>  impl FwSecBiosImage {
>      /// Get the FwSec header ([`FalconUCodeDesc`]).
>      pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
> -        // Get the falcon ucode offset that was found in setup_falcon_da=
ta.
> -        let falcon_ucode_offset =3D self.falcon_ucode_offset;
> +        let data =3D self
> +            .base
> +            .data
> +            .get(self.falcon_ucode_offset..)
> +            .ok_or(EINVAL)?;
> =20
> -        // Read the first 4 bytes to get the version.
> -        let hdr_bytes: [u8; 4] =3D self.base.data[falcon_ucode_offset..f=
alcon_ucode_offset + 4]
> -            .try_into()
> -            .map_err(|_| EINVAL)?;
> -        let hdr =3D u32::from_le_bytes(hdr_bytes);
> -        let ver =3D (hdr & 0xff00) >> 8;
> -
> -        let data =3D self.base.data.get(falcon_ucode_offset..).ok_or(EIN=
VAL)?;
> +        // Read the version byte from the header.
> +        let ver =3D data.get(1).copied().ok_or(EINVAL)?;

This doesn't need to be done with this patch, but once the kernel-wide
`bitfield` macro lands I hope we can use to to define a proper header
type for this and use it both here and in `firmware.rs` which does some
nasty bit masking - see for instance `FalconUCodeDescriptor::size`.
