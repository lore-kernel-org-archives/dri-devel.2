Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08629606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jJdvRVqU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197A611263F;
	Fri, 30 Oct 2026 03:54:08 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB14411263F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 03:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFt7T9r9zpPhVrKP9AMTqqymW1OiEFfjZMVKz6r/HRphijPuei2vsZhsRQpWSksxflqD10u7Tx8GKBFO3iOyAyZZ0EnkAXOw0wQCOYWCdUTlAjmmD8Qkuz+iA8fwpiFBfiMKahgw58JkZJLzqTEwYhKfZBON2Gx2T/VJrLwU+SfEueaB4AiumWfF9nXZkTxINEegZUZKOaWdtMKL0tVjKf6uurtBSLPUtjhmDnedUF0nt3ZJtpV/vh98FZYdWebAALxHSg6PwrfnsLdEk7UY46Y0VGuiSihp/keUebHFvUJ/s5qsEV7ZTtSLCnM4KPuLZLvw9hwtKy+pwJ4IlzAAwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZE2/JIOtlVyfOJTMYRwkqmioOVR/gkRUiROyqYK4x0=;
 b=i/UzBjDEGpKIBqdLWvkQbxUqXDQLaFnDjdSM3pmOprf9XXviCoGtlh0FdzETBLmfOlxZ7IuSoV6qZ3PsrRTETc87TOAYR2W9lB8YtApWq5xSZhH6uGTGKyZw9bYx3pqByRQ2GctXgye8YSjpbSeHbx2m6T8hNKaB++wdNy7imuFPcu0SOKRmy/1B1u7jKFqAySIyqv+zM2UEVM+piSFSFynFw9lRaRbA+gbT2UZh7ktCOIQWE0qT20Q1Wbqm0Z62BeY9oV99m0MCHzpvh931Sf7OeNFXrb1WF1qmPiyzFQGGHISXFnXmcjgDSFbQPyhsaIDY1QyFd7dkfJxbxeGliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZE2/JIOtlVyfOJTMYRwkqmioOVR/gkRUiROyqYK4x0=;
 b=jJdvRVqUOh9vIlDul21L7PdwuyGBQchqbwV4agPpwZ3qc65lbFF6anJFyt3zhQ5Y63oHutx6G9TNUmMJXJ7b0BGgQjcdAW+j9sNCQ+9G5Dk9k91WxdY7Wh3e40kG1KTJRfHfSvReYjUBUhucd3vuz3L6shmwD579bq0QX/LyeS3I0f7RjFU/m5qoaEnAuBEBvsZxKPRq6IAkoTbJOi5rz9QCEz3yv0MdbyNNbqJrcbMCnA6kbv0sBbeIgQuVZVU8ayOe35CY7br/bWRF9AF5vi1vvFSMaRBSEnI+noAnO7KAfBFKjlPKwtgSOeeHGA2cjLgBKllZ9klA/fK2lZNHbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 03:51:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 03:51:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 12:51:54 +0900
Message-Id: <DMHV8ZWTAEVB.YC2XG5BHNBN4@nvidia.com>
Cc: <airlied@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "David
 Airlie" <airlied@gmail.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
In-Reply-To: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
X-ClientProxiedBy: TY4P286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 573c8b8b-7600-4e1b-5ece-08df363924d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10070799003|261026121527099003|11063799006|56012099006|261009223027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|261021123027099003|18002099003|22082099003|261028144727099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: CDdJ2eT3mMdLly5EeGGVdJk2syQ3KXWON0r5o6Ur9CMK3lQzjLS2tCj6Oa9Bok5tFm3ZMINpQYPqKPAKuB0a4n3EjeIWTPIOmtwStgIDVw0HVzbfFzKHwXTJLHGwvuhnWydtyDaCAjx9I1ju2wSwhI1TwGegQGclbPlZwTMzDDNsZ+aJ8MdIzVdCmtfyPNyxwZFZo87RkMhGDS17NmxCrgj2vUszDMW6SgAujCrG8h9dfJOTjq0mZh6ye83ZsEOmafVsuBRmCLoCiy0UrtE4lyQh8/CuvZnQuHG/CXoFjGT22Tb3oubZ/cp7TrfIhctL2dtTg1Eck8BYGtxFgpijse/7Ae2q2UEsLwdt4mCaM2v2h8vop6rV3HWAa91FyBCOqBIjyjrsYaialXC4woPkCoYCplbhlRacB1raqE4xzWUiqdZ61l52Y28fCB32VJq2c9b2sHdxatkAVbxkxl85VuoQL4AYRcSM1IuP2j37dEP5qiC0xvYZZVzdt6u7rK73Ly82CKMrPCXspF0osepdT16BNeHBv1kXXq4HhtpAGQFAY+d8FL5apinRca5zw53j7/OtIaUY0Jt387Jk5flyKBCPFIEvHkht6WXYdmyV5q6YzdT1ORHRkyHYkL4ppHVzMi01gugTmuayNmYYrefmNNP7uat4Wg/+bijuWQZppG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(261026121527099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(261021123027099003)(18002099003)(22082099003)(261028144727099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3pwdE5pbGg0RGg2dFV6OW9pclZIZk9BeXpNenh3a2p2czBvSXYrVGZWNmY3?=
 =?utf-8?B?NUgzcFllVU5HaE9udmNqZ1pTNGhUNGtFWERNYkgzeU9MYkR5SUVPVTlmbGVJ?=
 =?utf-8?B?WXFrQllhTHVsYnprS2VOMkl1eExMZjQ2eE5Oa1dnZHNnUkZZbmlzSXVrK2J4?=
 =?utf-8?B?dzhpbXB4OGZGTkNXVTVDREFST3gyemYxUGRDNXg2NmNoN052T0grNkEvb3E3?=
 =?utf-8?B?Z1RLZFBQSmpQbTVGdDB3WnR4VWt4SGp3MzNnL2hnS0pOTHMxbWRaQVFaRVlY?=
 =?utf-8?B?VFo4T213UWFXQTdmSjlsOWFjcXFJQnEzTVNwaGM2VzhyZU4wODRoTnhEQTlL?=
 =?utf-8?B?VXY3QURjdjlKUG5qcWNibTQ4bFdQanQrVVRUeXExdDhBQVZHL2picVdLL3J4?=
 =?utf-8?B?WkROVFU1aG9WWXJJZjRXQ2dTUzE2UElXeXBrZXNQYmMwRnpqSHNlN0grQ1h1?=
 =?utf-8?B?TW5ZUmk5RkMzTXU4dFZZMmVJSGRMSmFSaDVHbGFFNFR5WkhpQ1J3bVpNdEp0?=
 =?utf-8?B?SEJyaTY0WWdjNmVnSlh4YkF6R0VrL01nWHBZYndERHV0bU1lcXJjRHJSb1pD?=
 =?utf-8?B?ZDM3M2x0M0xxVEwxclA4WXNabDU2aWhIME9NcnhGWmovUnkwK2Y5dlFlRnVr?=
 =?utf-8?B?bnU1QXhsZkcyOGgveVVHTFYrbGlmR2NtRkdYWCtUb3Z1aUo2SkdvamJtQ002?=
 =?utf-8?B?U0VJeHF2T3VUM2V3S29XU0hEODJNajk5RXp6ak5xZFhEQnRySUZ3cGVGaDlz?=
 =?utf-8?B?RXJYVTVMVVlmaC9LeHF4K3F2NjNDTEw2Y1B0RUg1cVZTdWxiZDNzWUxJVFJs?=
 =?utf-8?B?OFZDK2NzRzFBaUZxalJSdlBVTlN2VzRKR2NlK2NvZldFQXg2TUM2bk90WGw3?=
 =?utf-8?B?NnNyTFZUSUZxUnVPLzNRUDBWZE11d0EyeVo4dk9zWkNQdEswTEw3azJoZzNF?=
 =?utf-8?B?QmUwZzc4aEZxd3pFZ2NYc2hJSlY0R3puVHZXOXpac3g0OW43YlRrZ3RMclk0?=
 =?utf-8?B?aW5sL3JiRnU4MUVqektQUWxycXB1dWVaYnVZallVRE5wUFhwQUh1YldBcTli?=
 =?utf-8?B?YUJyYWtseVBxaFh3bWcxOFNXVm8zVjlMU0NUSG4vc1ZncWpGZGRZNXNpRmk0?=
 =?utf-8?B?bGJVMkY3aDJRK1ZLUGVUUDNoTXh6NWNqRk9NcC9ZcHVpVy9jZ1QvUDJaWGlT?=
 =?utf-8?B?MVFrcDFUL2c5cjYzSE9NZXNyWkkzU0FxbmVjUm1qS3RUemFNejVtK1RPcWlm?=
 =?utf-8?B?dW1vYW5vOVlUZ1FmNzkvL2hsY09TMXFoNURobmd6VjdPUEtPOTlCVUl6aFhI?=
 =?utf-8?B?U0ZnL09VSlMwMW5STHJ1RVBQOGhEUHNMbmc4UmR2Wis4Ykw4elhxNWFFczVk?=
 =?utf-8?B?Qk56S2ZrSnFQcFNUN2ZnbGdNQUhkNnZ1WUxFY2hmU3lCcTdlTmdmUjhIaTk4?=
 =?utf-8?B?TkVURXBKdUwrYlE1WFdOWW1wWUZEazh0RHFtMFlwYkhWZ0o1b1NacTJmSkJH?=
 =?utf-8?B?NEM0UlhJcUsvYWlVakloUXg4bWNwdVZLenNVTUlmUGl3OUpxOG5jTlpJdFBO?=
 =?utf-8?B?aUZvMWhhZ1IyNUNhWkZydGhtUWZydGNsTkdKMHVIajJWcWpmVG5WcEczMFhC?=
 =?utf-8?B?VTRYK3NjekVvNEEyY3ZldzM5MUlUVnF6MFBSSWNaMlRyVDN2dncwdXZuQzNV?=
 =?utf-8?B?QW1XczAva1V5Mm56ekNKSnRHMlo4N28zN1hEbXFwYWhUam5Ec2dGT3l1TDVY?=
 =?utf-8?B?VG5CVk9FMlpZYlFOSzQvVTU1RllJSzZVeGY5cU85NXlmL1hic0F0UVBxMzF4?=
 =?utf-8?B?TEQrS0oxWWRGNnhVamxROFpWbDMrQjA4OGV0R0ZPcUxDSWVtWWNqbi9hN2s2?=
 =?utf-8?B?SFM2dUlJZW1iTFlYckhVMmJWRWIxYTRvUXo1cHQ0SGk3akVNV3pvcm5scDZN?=
 =?utf-8?B?cTVZVm45MitCS0x2aVAyZjBTYXhVUitKVFZYakJxVElNbVdwbU1BN1JuRy9P?=
 =?utf-8?B?SmpYZGhjNnROT2hid2RXQjhDbTJtYU9OOGlBbHJ0VGlLaVdDaXA3VFd0OWRJ?=
 =?utf-8?B?c0ExNEtkN2l0a1VGMjNQSlh0Qmw3TXlYRWxSZVVheUl0Qy9zY0o3K0Ftc3lq?=
 =?utf-8?B?cXhCOVZnd2pmQkxOQzhXU3N5a2xEZVBTRGpYSXpMdlZKV2grR2I1SDBYSW1u?=
 =?utf-8?B?eWRMN2Y2aFZMQ0wyNDJMY0tKclM2S2JtRnMyQjEyL1VCWTdKRmNZc3BlN01u?=
 =?utf-8?B?UWpVM3g4amZlc24yVmM4bE9ySnFiV3U5bUZUM3IxVEpuTVNDbU5YTHJuajhy?=
 =?utf-8?B?ZDNwSUV1UFIrRUt5bU84Y2REdEJIZ3E0a1RzVjM4RTRDMEJJd0h5R0xSQTlr?=
 =?utf-8?Q?yt1oUUqlAJiY8ErJB2vNZ+DL9cVXoxLKoyqhO3STp2Lit?=
X-MS-Exchange-AntiSpam-MessageData-1: NZaFRdnU5CfNOQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573c8b8b-7600-4e1b-5ece-08df363924d6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 03:51:57.0682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7qfQPRKFVrIVu6M8NzXf4KNFwJD/gt+R84s/qD1iz+9O563sCZzS3tiR4Uq0m341/yBF9kE3zf1MA2Qa2lKBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave,

On Mon Oct 26, 2026 at 1:24 PM JST, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> These aren't used on systems with no framebuffer memory.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/nova-core/gpu.rs               | 15 +++++++------
>  drivers/gpu/nova-core/mm.rs                | 34 +++++++++++++++---------=
------
>  drivers/gpu/nova-core/mm/bar_user.rs       | 14 ++++++------
>  drivers/gpu/nova-core/mm/pagetable/map.rs  | 10 ++++-----
>  drivers/gpu/nova-core/mm/pagetable/walk.rs |  2 +-
>  5 files changed, 38 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 4e59072cab50..5d53fde2cdc1 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -564,18 +564,19 @@ pub(crate) fn new<'a>(
> =20
>              // Create GPU memory manager owning memory management resour=
ces.
>              mm: {
> -                let usable_vram =3D gsp_static_info.usable_fb_regions.fi=
rst().ok_or(ENODEV)?;
> -                let buddy_params =3D GpuBuddyParams {
> -                    base_offset: usable_vram.start,
> -                    size: usable_vram.end - usable_vram.start,
> -                    chunk_size: Alignment::new::<SZ_4K>(),
> -                };
> +                let buddy_params =3D gsp_static_info.usable_fb_regions.f=
irst().map(|usable_vram| {
> +                    GpuBuddyParams {
> +                        base_offset: usable_vram.start,
> +                        size: usable_vram.end - usable_vram.start,
> +                        chunk_size: Alignment::new::<SZ_4K>(),
> +                    }
> +                });
> =20
>                  GpuMm::new(
>                      bar,
>                      gsp_resources.spec.chipset,
>                      buddy_params,
> -                    VramAddress::from_raw(gsp_static_info.total_fb_end),
> +                    Some(VramAddress::from_raw(gsp_static_info.total_fb_=
end)),
>                  )?
>              },
> =20
> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> index 8a934c55169f..9a2c73c978be 100644
> --- a/drivers/gpu/nova-core/mm.rs
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -71,12 +71,12 @@ macro_rules! impl_pfn_bounded {
>  /// GPU Memory Manager - owns all core MM components.
>  ///
>  /// Provides centralized ownership of memory management resources:
> -/// - [`GpuBuddy`] allocator for VRAM page table allocation.
> -/// - [`pramin::Pramin`] for direct VRAM access.
> +/// - Optional [`GpuBuddy`] allocator for VRAM page table allocation.
> +/// - Optional [`pramin::Pramin`] for direct VRAM access.
>  /// - [`Tlb`] manager for translation buffer flush operations.
>  pub(crate) struct GpuMm<'gpu> {
> -    buddy: GpuBuddy,
> -    pramin: pramin::Pramin<'gpu>,
> +    buddy: Option<GpuBuddy>,
> +    pramin: Option<pramin::Pramin<'gpu>>,
>      tlb: Pin<KBox<Tlb<'gpu>>>,
>  }
> =20
> @@ -85,28 +85,28 @@ impl<'gpu> GpuMm<'gpu> {
>      pub(crate) fn new(
>          bar: Bar0<'gpu>,
>          chipset: Chipset,
> -        buddy_params: GpuBuddyParams,
> -        total_fb_end: VramAddress,
> +        buddy_params: Option<GpuBuddyParams>,
> +        total_fb_end: Option<VramAddress>,

This is related to the comment made by Sashiko, but in which cases are
we expecting `total_fb_end` to be `None` here? Is this the same set of
systems for which `buddy_params` will be `None`? If so both arguments
should be merged into a new type to remove the ability to represent
invalid state where one is `Some` and the other is `None`.

>      ) -> Result<Self> {
> -        // PRAMIN covers all physical VRAM (including GSP-reserved areas
> -        // above the usable region, e.g. the BAR1 page directory).
> -        let vram_region =3D VramAddress::ZERO..total_fb_end;
> -
>          Ok(Self {
> -            buddy: GpuBuddy::new(buddy_params)?,
> -            pramin: pramin::Pramin::new(bar, chipset, vram_region)?,
> +            buddy: buddy_params.map(GpuBuddy::new).transpose()?,
> +            // PRAMIN covers all physical VRAM, including GSP-reserved a=
reas above
> +            // the usable region, such as the BAR1 page directory.
> +            pramin: total_fb_end
> +                .map(|end| pramin::Pramin::new(bar, chipset, VramAddress=
::ZERO..end))
> +                .transpose()?,
>              tlb: KBox::pin_init(Tlb::new(bar), GFP_KERNEL)?,
>          })
>      }
> =20
>      /// Access the [`GpuBuddy`] allocator.
> -    pub(crate) fn buddy(&self) -> &GpuBuddy {
> -        &self.buddy
> +    pub(crate) fn buddy(&self) -> Result<&GpuBuddy> {
> +        self.buddy.as_ref().ok_or(ENODEV)
>      }

For this kind of accessor to an `Option` it is considered more idiomatic
to just return an `Option` and let the caller decide how to handle the
error, but in this case it just seems to be a private convenience method
used only by submodules, so doing that would defeat its purpose.
Instead, can we make it private?

<...>
> diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova=
-core/mm/pagetable/map.rs
> index 77431c509a89..fd404b0734bb 100644
> --- a/drivers/gpu/nova-core/mm/pagetable/map.rs
> +++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
> @@ -81,7 +81,7 @@ pub(super) fn new(pdb_addr: VramAddress) -> Self {
>      /// Allocate and zero a physical page table page.
>      fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) ->=
 Result<PreparedPtPage> {
>          let blocks =3D KBox::pin_init(
> -            mm.buddy().alloc_blocks(
> +            mm.buddy()?.alloc_blocks(
>                  GpuBuddyAllocMode::Simple,
>                  SZ_4K.into_safe_cast(),
>                  Alignment::new::<SZ_4K>(),
> @@ -94,7 +94,7 @@ fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageT=
ableLevel) -> Result<Prep
> =20
>          // Zero via PRAMIN.
>          let window =3D mm
> -            .pramin_mut()
> +            .pramin_mut()?
>              .window_at::<[u64; PAGE_SIZE / 8]>(page_vram)?;
>          for i in 0..PAGE_SIZE / 8 {
>              io_write!(window.view(), [build: i], 0);
> @@ -120,7 +120,7 @@ fn ensure_single_pte_path(
>          for _ in 0..max_iter {
>              let result =3D self
>                  .walker
> -                .walk_pde_levels(mm.pramin_mut(), vfn, |install_addr| {
> +                .walk_pde_levels(mm.pramin_mut()?, vfn, |install_addr| {
>                      pt_pages.get(&install_addr).and_then(|p| {
>                          p.alloc
>                              .iter()
> @@ -197,7 +197,7 @@ pub(super) fn install_mappings(
>          writable: bool,
>      ) -> Result {
>          {
> -            let pramin =3D mm.pramin_mut();
> +            let pramin =3D mm.pramin_mut()?;
> =20
>              // Drain prepared PT pages, install all pending PDEs.
>              let mut cursor =3D pt_pages.cursor_front_mut();
> @@ -255,7 +255,7 @@ pub(super) fn invalidate_ptes(
>          let invalid_pte =3D M::Pte::invalid();
> =20
>          {
> -            let pramin =3D mm.pramin_mut();
> +            let pramin =3D mm.pramin_mut()?;

I'll let Eliot comment on this in more depth as I am not very familiar
with this module, but I'd like to avoid these runtime checks if
possible. On systems without a framebuffer, we should not even be able
to call these methods, so I'd like to enforce it at that level.

Ideally, we would consolidate all the state requiring a framebuffer into
a new type (i.e. my first comment, but pushed further), and put it
behind a single `Option` that solely tells us whether the system has a
framebuffer or not. Then methods requiring a framebuffer can be passed a
reference to that type and work without runtime checking its presence.
