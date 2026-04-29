Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5764FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FAB510EF6F;
	Wed, 29 Apr 2026 11:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hnxNaC62";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010021.outbound.protection.outlook.com
 [40.93.198.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4995710EF6F;
 Wed, 29 Apr 2026 11:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebN2azCaQ2ATQUdKwnC+V/exyU6t2m/u7lulvKnQhDnQiFH+VQ1e9G98db/TD6Jo4oudnR6NBAzW3fDFrPHiNIDKFU2I4HIsCdkaCM5+yfvchfXLikc4nNOTnXoj+G97M1lTiC4x6Uhvt1SmTfGqfOyjqLhPsReOhxmEi+oig2XHjMR35KrdLBBbAxxWWy9mNvttUSvcqioHmQ0c/UfnX5mw9rk1KDjUbuZtPeHVqtVvbxDAN67o3pWYUuMzY2QjVSYOJ1pNqYFPXDAZsV+my4MGYVXY6yi0fKuRWP9Cb99pzsF1o/8TT5siC8F6wfyf2kQRdrr/NLfNWKgmlDx1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cev2C/zxpcLqEPe6yN8LrXXzrvgQLv3KzZ2EsVngDA=;
 b=NgxGKonbQFyBbQGuc71qICm0VtOA4ZXYmY+rOPxKBkA1t5AnOIgujoCQE1zQaa8Sb81BFOGxuw+Ko96ABP1BlJRJMweVW0bcYWnkpMZZMPqCQ3loVw1ADjyFQ7+/lB9JFFmaKOmc1yTzJ6buJdOYSW0jW0NIzdztdQRlCoaJGz4Nn+kezSqpjdxDbL9nr/lT17Xhl7xKHUs+jfzQsgn+sf2kswFtybTCXW4EC5v5LMZLlNVPnV0cfBdEa6R7OIULARmsC7pg6hKcZgOF4q69J1C+fEC16TnAkR8fIfJ5vaoMfSYMIpMQPKoWakcIroaBL+tzgTe8JOTGLAJFJ7BRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cev2C/zxpcLqEPe6yN8LrXXzrvgQLv3KzZ2EsVngDA=;
 b=hnxNaC62wsWrnyg1AC0c0acoAs955hXk7HBkKHgeTH9ul6CWfi6cpuRQahBqOYLUHxn+L0JKp1unybwx7IXHSxqcMz/GQ87Hwf2gBRl4bY1RFHXitf/JuqdUn+7qpCx/WY/y1RPSk82y1A9HMVM+FllZfhL+VplwnpB55J+mkuConTLdNjRKM9SmnJdyHSk0n9+OVwmNTz5e6FbZic/NJe4F3oN0FiOSvJNB2vYbAYMGf9spOZo/9/T7j/P13VjdsYymYY6/eKPSBSvild6iHt/GFpS3IDF5ri8QGwNoHiIGh6ihmpXJjQjGSgmy4x+na2rFr8zGPt18XYQul4pAog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 11:22:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 11:22:24 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 20:22:20 +0900
Message-Id: <DI5LLN2V3XCS.34H4CG99N4MPA@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/5] rust: ptr: add panicking index projection variant
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
In-Reply-To: <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
X-ClientProxiedBy: TYCP301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: f5858971-16bd-4b65-3766-08dea5e19695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XRrPt4IUsUx19iHFl5yXFG8DvYB2Jq7fRKtYHxOHGq6t+r6L5PAQK5aMKMug78II/rjO0qv+F1sM60RvhI9AQb9dSr7otjKAIjefxWFTQUbFD3+ssrqc52G7zr6wTp1xjckpo9JVm7RkxXpu9xIlAvP62Z7ngx+xkbgITw6VbLRX2HWhmbnAd2v+a4ZudfoDKiUwY+K8rajKAL3bM/B9R1Yt6LowPstoBDHj3vdcAc/Quy0WLCC342hR9ECLRmLxhMUvljxcV0QxR6Dc6irwu/W3EFv4SG5Ri/yre8woyJe9d7FKSvO0B4HiUUkHuHIstiU9MQoNqE2rEoXsBdVg7LVRXF/qvHxfSBSOLtquF1/KALN7MFnFMgfnBSE2dlbglbg/wuCWWKKx10Apyi/S2eLYj2vkkY/WoIGkz/UASrCzgtPBhJkTc/XL4mEyCu0+e/qdFfMECtSzFWrNlUTqvTnb/Vm5EGoPUt/H5/91kc4qp2OT4ATCOEZquyaZtLoZ0tU+a9jXIOVNwg5Vs2OCpjf9aboLbdH1BjKmp7xLrWWbnUfRYpvUjg3hpq9gwQYIqwk/RwdufvqVQACC08DMIMWJj9+3jypxNbK57SS+IIliFTonXO3Jb1RpxddsIWGYfuugeYeZLAXTAOIr5TBR7MAzwmLXy0GPkRGWI1alT1lTFKv244Xin+L2aYHyatXgs9ufeIancotqsvO9A0waO1qaAT6uxhndKsb61s2zzew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mzg3RzVlTE8xMzZ2WlFVbXpzaVpuZ3V3MzJDNzVFRFJzZlNmU3Vnb096dmhS?=
 =?utf-8?B?RTdaWWtBTWZtQ1lDYzBBa3phYjJybUppWTE0VWNRYnd3UnEvS0ZoWENiQUxG?=
 =?utf-8?B?VmhqbEorY2JPT0hSV09XVkVwZllCZUJtRTN2MGpXV2ZhNGZsMWY4dWVTblYx?=
 =?utf-8?B?SzZuS040R3gzeWd4cU94bUdZWmlrNFZpWVJ4dHhnc2RsZ2s5Z3VzWFhZdnRY?=
 =?utf-8?B?VnhZbW1GQmVZZHc2YlhxZ055Y3dMRm1Vd1lMMmxmQjBKMTJ6SkN4WEFXbFdk?=
 =?utf-8?B?UDhOeDlsUTZtQXIxM0xkZDhIUDh3WmNmczkyQnhDRjJHaXplMEp6VkkwS1Q3?=
 =?utf-8?B?QnFjU3FydVBLcUdIY3VHY2w2eXpGcS9VdkxqOS9XcU0yZTFrLzQ5MWFnTVJv?=
 =?utf-8?B?QzcxVjBPVy94OUI1RWt2clVod3MrODFIZ2o2eGs3UERNSG1id1pKaTVVbVZQ?=
 =?utf-8?B?UVp5NU12OUtYdXlNbjkycnB5alQvRW5WcWE3OHVodHVnb29CWVN5SklrNkxh?=
 =?utf-8?B?YUg4aWIxcmkrQmpLcDAwZ1B6bnZyaDcwVEdGa0w3NDJPSFQ2TXdzVTgvZmh6?=
 =?utf-8?B?clJLbDJwcmNvUzg5aXlUUllDeGZJWEtPeDdxK3Zib2xkVnoxM2ltSk1FQ1JX?=
 =?utf-8?B?d3IwUXJIUFhMUXdOcDlTdng5QkRHMzk5Y2grbG1UUHJZOVZBS0FMczJLYlFr?=
 =?utf-8?B?aEMybVRWVHArWGFKUGloRTRZL0thVjVXaWd6bVhnemlqN05INjdKWklQdGF6?=
 =?utf-8?B?V3hWcUZaSTZST1dTRGU2Wkx1dGhJRzBvUTVsaTEzNGQxbENxS0xybndnSXdi?=
 =?utf-8?B?K1daak5WTEViTUtMZFRXWkZuRDhwN3VoK0NuUlRvd25sb2FGcFVrSzJRSWZM?=
 =?utf-8?B?a1JIdmFTL2pLT2t4YVdSNE4wckp2ZnpLVnQwS2lpNkVFaWM2M0ZXOFFWcFA3?=
 =?utf-8?B?RUdzZ0VNZFZIT3k0bFRhVERIdTlxRkVPT3VDQ0lMY0RFbG9INWRUeFVzNkRy?=
 =?utf-8?B?Wmg4NUhjSFg2dnBYcGNXbVlvRVk0UGFTdXRRV3dOU2JtOUMxck8wNVZ1ME5x?=
 =?utf-8?B?czg0Q29jTWxMQmFkMmlrdTR2cFZVeW9CWTEzVjVKUFVOMEhkeG9tdEdmRVM1?=
 =?utf-8?B?emF0dkdpRzYveldLUTJ6WjcvemN3cmhMYnZYQnp0K0JVaFM4SUtVRjUxSmNQ?=
 =?utf-8?B?UlcvS2JvWTFWQ3p1Yk1zZHdnajV5ck1sUWZOR1c1Y3dFd24yMkt0cEFEYlpO?=
 =?utf-8?B?TmRHd2JsMEY2cHA4ZEdxNWRJZ0Q1bEg0Y1hPQXlRdkRiUlNoSlhGcWdTTENy?=
 =?utf-8?B?bVY3dWwvZnV4cGxWaHhzSTh5QUZjekVnMTJ1U0VJbitTdzRoaE9BQXUzaVVh?=
 =?utf-8?B?M0NRUkphYWR1RHo0U0NhNWtJSHNuOTVlSkMvakh2S1BHNGtqZ251eGk3WWgx?=
 =?utf-8?B?bEJwK1JGelFjbnVuTzE5cWRyZXR4akdERkVJRjZYWDJPT1JsTWdCeFUzSi93?=
 =?utf-8?B?RnkxaG04R2Z0M05lV09kZU5rdUg4VjdZaGVRREoxd284LzhFVDR4bWZTOWxk?=
 =?utf-8?B?ai9jOHdEZERmSEQwUE1aRzEzRlcrSzFxYk1RdWd1ZmR4SWp5VUNpK2RsMXBE?=
 =?utf-8?B?WkhXaVorT2s3SU5YcElUaklKaU1RTlMrcm1JK1dmS1ZlbDErMllDMGtVcXBv?=
 =?utf-8?B?TkhWYzBlb1NQdDZSRUN1TllQTHA1djJiMisremE5SHU1QUZPVFoyeGljS1ZU?=
 =?utf-8?B?a2VseHo4b0VPZEF2d3Y3TXl6QXNRbGphdXZoNHVIckxuNlpUV3RsUndCdDdh?=
 =?utf-8?B?SmRKWHhaV2h3Mi9Td2FXT3NJaXBlaVBsV0p0cnUzR0E0MjhNL3d4UEVaVFRq?=
 =?utf-8?B?U2Q0RlZJNSsrcDdFOFNVemtGTnZaQU9lQnBtdW9rWm5DaTlsRWdFL3QxaTlP?=
 =?utf-8?B?aFZCeVc1UEdtN3hPK1MvYnRmUmhTcDUrbkxzdG1jRWVWVjBaMUxXU0NlOG5q?=
 =?utf-8?B?dXFqdUE0QmxFYTdHVElGeXErU2VlQVVyS0V3WWt0cWtqaGZpdVQ1WWJXcXhu?=
 =?utf-8?B?NStveFhNZGM3SzgyL0g4OGJ2VzRrM0NJQ2cyUFg1VG9LTUYvTkpMRE5PMFhO?=
 =?utf-8?B?MXQxTWtBcXVZZUJDakVFOHIrRDNZUVlIUnZhalZIWmIwN0ExT2hnQjB0ZUYw?=
 =?utf-8?B?L0kvbEVpL3pSNHBSSGoyRG9LTFZMT0FQM3Z6YTJkMWZlN2tHQk8rb3lZSnU3?=
 =?utf-8?B?dWY0MW5vdlU0UW8xODFIekFqVEFNNk1BUlBsV3NJQkpKMU12Z3NTYmswRlRq?=
 =?utf-8?B?NFBxU1ZiY1JZcm44VWtUN0VPb04wUEtybGZIL2dWajRUZWx6Z2FJRkQzQWtF?=
 =?utf-8?Q?GrywSYLjNnh7DybwWX3U6kOeUtn2zupkI2OqZwPhzu/XM?=
X-MS-Exchange-AntiSpam-MessageData-1: +SLFhbeHSeRvgg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5858971-16bd-4b65-3766-08dea5e19695
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 11:22:24.7051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPOYCAoIZhzTGMKWQDA8wIj6/OEOFfx788dUG/+h2GzuG9GY9loeODDVJuq25+A55s3rXF4IfSrE/Q8FfgjTXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

On Thu Apr 16, 2026 at 4:57 AM JST, Gary Guo wrote:
> There have been a few cases where the programmer knows that the indices a=
re
> in bounds but compiler cannot deduce that. This is also
> compiler-version-dependent, so using build indexing here can be
> problematic. On the other hand, it is also not ideal to use the fallible
> variant, as it adds error handling path that is never hit.
>
> Add a new panicking index projection for this scenario. Like all panickin=
g
> operations, this should be used carefully only in cases where the user
> knows the index is going to be in bounds, and panicking would indicate
> something is catastrophically wrong.
>
> To signify this, require users to explicitly denote the type of index bei=
ng
> used. The existing two types of index projections also gain the keyworded
> version, which will be the recommended way going forward.
>
> The keyworded syntax also paves the way of perhaps adding more flavors in
> the future, e.g. `unsafe` index projection. However, unless the code is
> extremely performance sensitive and bounds checking cannot be tolerated,
> panicking variant is safer and should be preferred, so it will be left to
> future when demand arises.

Review nit (no need to respin for this): this patch would probably be
easier to review if the renaming of `index` to `build_index` was split
into its own patch. It would reduce the diff, while also removing the
burden of having to keep in mind that `index` means a different thing
depending on whether the line is removed or added. I've found it a bit
difficult to keep track of this.

>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/dma.rs            |  3 ++
>  rust/kernel/ptr/projection.rs | 98 +++++++++++++++++++++++++++++++++++--=
------
>  2 files changed, 84 insertions(+), 17 deletions(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 4995ee5dc689..3e4d44749aaf 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -1207,6 +1207,9 @@ macro_rules! dma_write {
>      (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) =3D> {
>          $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*]=
)
>      };
> +    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($=
rest:tt)*]) =3D> {
> +        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [=
$($rest)*])
> +    };
>      (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*]) =
=3D> {
>          $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($rest)=
*])
>      };
> diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection.r=
s
> index 140ea8e21617..845811795393 100644
> --- a/rust/kernel/ptr/projection.rs
> +++ b/rust/kernel/ptr/projection.rs
> @@ -26,14 +26,14 @@ fn from(_: OutOfBound) -> Self {
>  ///
>  /// # Safety
>  ///
> -/// The implementation of `index` and `get` (if [`Some`] is returned) mu=
st ensure that, if provided
> -/// input pointer `slice` and returned pointer `output`, then:
> +/// The implementation of `index`, `build_index` and `get` (if [`Some`] =
is returned) must ensure
> +/// that, if provided input pointer `slice` and returned pointer `output=
`, then:
>  /// - `output` has the same provenance as `slice`;
>  /// - `output.byte_offset_from(slice)` is between 0 to
>  ///   `KnownSize::size(slice) - KnownSize::size(output)`.
>  ///
> -/// This means that if the input pointer is valid, then pointer returned=
 by `get` or `index` is
> -/// also valid.
> +/// This means that if the input pointer is valid, then pointer returned=
 by `get`, `index` or
> +/// `build_index` is also valid.
>  #[diagnostic::on_unimplemented(message =3D "`{Self}` cannot be used to i=
ndex `{T}`")]
>  #[doc(hidden)]
>  pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
> @@ -42,9 +42,12 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
>      /// Returns an index-projected pointer, if in bounds.
>      fn get(self, slice: *mut T) -> Option<*mut Self::Output>;
> =20
> +    /// Returns an index-projected pointer; panic if out of bounds.
> +    fn index(self, slice: *mut T) -> *mut Self::Output;

This looks like this could have a default implementation:

    fn index(self, slice: *mut T) -> *mut Self::Output {
        Self::get(self, slice).unwrap()
    }

I'm sure there is a good reason for now having this though, so at least
for my education: why not? :)

In any case,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
