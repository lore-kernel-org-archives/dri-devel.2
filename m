Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C348606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AGc3ZSTS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7BE10E10E;
	Tue, 10 Nov 2026 17:22:34 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8B210E10E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4ozQWsKoucoFMJb6ZXvmqCnM7H8bAWFcD8GOUGpxVTpVlz9uSngInABnmGSWWPIIahpD7a6rJn56+0whmEWh2LCtWpFE8l4SZap1KG+6HtZsQM3neScj5Nz3b+fyRHiudvUe4HR5qeIKIk4/5rd7zy3N2ufjNYj1EJCRyI896juOArMWuebJl/h7YHe+lFvFoz2ABXizgv5L5EHoO/eLIfRTT/EYoSz0yLJ7pZeon6FuIGEUWvs5/6BtbHDiIFGp+TpygljjofZaGC2mFN4rk1y//g2/A89/WYCfRYV6mkoUUI+BPRn5YdQP0Aye+R4ux89iIsHWwtyUPFOjDi70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aptb8DINy+86J279WxTrI+KtPSIwcQchmnBHnVEBxa8=;
 b=S6ow00c1nPg23fumIY0jLKos6U3ysqLG0qJGsrkuZFnAkoebFoZFTTEVrGZeZ9q07IZY+KfV3E/dVjLFqidMvCsGZ9WepZYU3LGY/HjzAWa1VB6VE4pEkfbXwRrd4PiC2xVY7YowkGlOeMkvmDhKbKrtjOrQE8qJbZ2dFng4BKne+yOUeYFysXX2FZY4HCTxrpr3Oh3UBzzT4EmzWn06wGxxaqKGQUjsV6BsGI0SL2JmQuQs/HZTehw44HIEuIm8TwMcAqus3FwkdMT3YRQ6kcRYpAg3gzSPrK9fuurK2/jY6E95AhZrvOLqfxGd82lOa/vayg23IbMFE9itukmvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aptb8DINy+86J279WxTrI+KtPSIwcQchmnBHnVEBxa8=;
 b=AGc3ZSTSEb0zJEhWMbNH7oMBraZE9hgfI+iT+zsaAMINQRmgUy5GmtYoW6ibLS+WEk7i9z1WE7+n4ueFEiTHKNkaYsFC3mRGw7+CleJFX0xrPeNww0/pM2M4/9Spu3BGmhin9+OsKqA3rml8B/+YiPC+ckZtCkMvptwS7Aq/FWMCcm+WXg1wQromTdqVZ84sC3zBtcdbpwWZh6gwW/rYQ1nouKpkCTZ66UU+rUlY+bdrm9BhuATBOWLPGJgDsjsUSQM7qBJ/EfwwORen66Grcdvi2KE3ra4nj+d/lp46s88ugVUBTpMqjn6ru53ISYF0DOE8oHjNbauWoDXtI+w28w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:22:20 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:22:20 +0000
Date: Tue, 10 Nov 2026 12:22:19 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 3/5] gpu: nova-core: use Alignment size constants
Message-ID: <avNSy4Q5Bw269C5e@yury>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-3-082aa9bf5a91@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-chid-v11-3-082aa9bf5a91@nvidia.com>
X-ClientProxiedBy: BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::23) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed3b775-35e9-4386-ed8b-08df3f4f2d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|10070799003|261009223027099003|10067099003|261026140227099003|261026121527099003|261102123227099003|261021123027099003|261028144727099003|261021121427099003|261022115727099003|261022105027099003|261022075727099003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d0TXFSP1VxKKzqWBPlLZaUxvQZq8Dpouxhn7CMGhGOcT/2UqCAyhSSrsOQN9qkzyfb7N3xPPRDNrwCORM91X+kmhshXRaA1tW5hLUsbQ+dJ83s6+AYM26iZJIXA0SzVGZmbT1Z7xeiqmUbgpLBhrLoy/AQxucHOkOz3Zl6BQ+g/m8G2lKYHXuOCUn6jJ2H4kE3A7ROvD7Zh9NURzeOcRUVou9i9DN6gh7HlYKydZv1bJTNRb02+siOW7E3xjMU7/eocGk/uSOtlrK0QjxY2ujbeja3hMdeJazGi1slhshzUPUjYQ2LQR0QGiqoR7wpJaTpuSmz35UYLWuNrezxHcZ7B1+K4lXFXn28TA8VGOkJ63JUd6CnB1qJa2TRO9dum97LLjUEWrPZ0ssF7K1hC+iGhntss0NhNf9pIrAQ1R6O8Nf3nGLgiwyCaEb+CkOkj+0v8qAizu/wTL9DOUKxb0oo4huRJhc71pwnppokLN4mn6tqsPUrw+JDJ3EiCeaYEzrXAv5xrFFini7/FVfn9qVjpotdixw9wxrKw1pIbzrnSI/eLqyGtm7OzA0CpLk9rBbwgue4NwdD6HUicBQ0I21iuxcBefgQeFCKxzDG1XNTZLEITZTBrok2C4c9gjp6cCxlC2yY3p1e0x5XRK8XufEU1V2m6G+MLnuDR1ma2tfMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10070799003)(261009223027099003)(10067099003)(261026140227099003)(261026121527099003)(261102123227099003)(261021123027099003)(261028144727099003)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xR4Vw19RCa66jyTXExuZOYp5Yt6n/YVdFwxeU3wWAKD9ztY37IpCPGwJaSSK?=
 =?us-ascii?Q?4TUzCRXtxKFTZx/pdqgNwrhioa/X6eJg+unCX5ntcqAcZVIl4LPSiNrbyJ+A?=
 =?us-ascii?Q?REaWYRZDbOP+puGCMK4N3/SV0i/M025dLazXNmNDL6zE0igvRhceoLiDB/mB?=
 =?us-ascii?Q?dduE99SHC28DcN7Y+eDtYTCnpCLUYG1C/32ysx9/+KuE9XDas4gyB620A6nJ?=
 =?us-ascii?Q?py7PJ/fuWuMl5zhmSBpi9DJgyZWN/SpSzs4OY0Ul2Cgwhm8t/mi/mDaexv0n?=
 =?us-ascii?Q?EXb83U+22gkIQkxOGdb88rD2a7HzgOjAdTb/32ITRrmoPnCW0XndKhhJsiSA?=
 =?us-ascii?Q?ctF1NnorBUUjWKDsBX+m3EQmcl0HDEqCNr84SVKPymPgiDqVF5MIcCHosrkW?=
 =?us-ascii?Q?cVkrACBZXGNWSNxqsz4yYqvYebOJnVTdtDpYNSb1icOxO7IbeL5IiK0ppzHM?=
 =?us-ascii?Q?LgqtrhYuZXQyKOBzvxcfkTNYOMp9EXo7jzH6Ss7seHNIbxzMbvgE427Yb4T1?=
 =?us-ascii?Q?qg3FhoLkNdKiDbKa4mG5uv9Pz275TU/7gS74xAb/H3vZwKD8BFol1XkEsdVF?=
 =?us-ascii?Q?PJOE7QoD3Uzs+eX05e2GZqADCTkAv477cCeq3bmOsw7lGuWJ/qvLqLmikohR?=
 =?us-ascii?Q?jT7IUknef5/fhilObkNyu/AtvQnB/VSvZG9I7ED8E4uRngz37/aK49jWh/Eq?=
 =?us-ascii?Q?bNQrzBRj8RDAPT79Btf6z9e9A3erQmwdIGnhF+2weiGsWXC9e0Vdda+T1YgV?=
 =?us-ascii?Q?I9pWqZ68ZAW08dWdUsuxblyzc4RpyBc20m8FhR0Y9PaRH+gIeSsNRtabLCtN?=
 =?us-ascii?Q?iCTSPYQG7QFAWbZqlTqxm4WkZojAeQ/mKaPjateJTJlgfQvnprQJ7RlLtLeO?=
 =?us-ascii?Q?XMrroYP9VDqy0GzgzMzINfbxK6sS+ZDITDq0Bg0zMnUj4TvoTVnkAGaQSnBm?=
 =?us-ascii?Q?RD/tK3GI0UFD7pQpgHf/Taz8LNOR8IVRvtdu0EFqAuv4yoDmO8PGART7aXKQ?=
 =?us-ascii?Q?vG1i+rPnoZGVxtLtYfh9RVNRY2jsS01iFBGn4ZHCvqWuHvr/QVZmwkH23qZF?=
 =?us-ascii?Q?J/WYji1XqBij/XgwmxbNe+VgURswh4Z8+YZOafgyqCCVnuLuTFTdzfnaKokY?=
 =?us-ascii?Q?xZxoJEp9EXYr8eaUKgFOTxVL+bjbltbTZuqFaaJgNVMkXTiSq5y/KjtNc65C?=
 =?us-ascii?Q?qjCF0Qc3uu23o4EgpFIS3QozwZoxX6JH4Y8XSO/OdT3DU8Ld0rBSYBJ9ZY5c?=
 =?us-ascii?Q?A7Re3dxfXyFvtufHRwZcoyQElt52Um5JAEfJfAQvUMeLuKf8wQYu5kYPULi5?=
 =?us-ascii?Q?Y6w/Iw02ju1kpQLKLV3kVvkjSZylOMFJBh8zYLQDZb0KgOqCN8dM9YKDCJh/?=
 =?us-ascii?Q?IFaAT4owu0p46ctr/Js+fUXW7Gw4TJ207rRYtfeMYqTEfydXZOi9IWxAARLn?=
 =?us-ascii?Q?5v+dAMApll5G3GtDk6RskLu7wIpypvx3BEtyEQvdmyQrcqK4mB+5622oRt5R?=
 =?us-ascii?Q?ZR4Gc42ypjy7DebgAUJ40oi4ZvG3+4haBxq6Wx3b6TRD5o0nb2UdjWcFd96T?=
 =?us-ascii?Q?0RsSqR+hcfDti2BtjvEe54kFJtLTeApJOcI/IeDeTTDmPzu4ytNbcdoth7to?=
 =?us-ascii?Q?4pmA0GjE1DnWKubt3QyvzsuxgJuXID6B+K18A3w8i0j5+SRm0ShZSwdPaCWu?=
 =?us-ascii?Q?WQvPu0uac4DSngtlyZe6sb8BcFgbHzmo0gq3z8+SeBsceJ9bh5QjYvoiAzAO?=
 =?us-ascii?Q?S6IEOEjPfxwb33GBLRsudlrnEm6ijku9kP6z2QAW0ozKVTc8dOhU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed3b775-35e9-4386-ed8b-08df3f4f2d62
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:22:20.8011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vu/X4sqo7+bUv8QiU1SS1m2W2lCCAUGKImTbDFPsdVwzuLOugnXdAbZjw/BFGpiVtSrj6QFIzmz6wUF/gYv/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
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

On Mon, Nov 09, 2026 at 05:32:51PM +0900, Eliot Courtney wrote:
> Use `SizeConstants` for Alignment that are implemented now.
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  drivers/gpu/nova-core/fb.rs               | 10 +++++-----
>  drivers/gpu/nova-core/fb/hal/gb100.rs     |  2 +-
>  drivers/gpu/nova-core/fsp.rs              |  4 ++--
>  drivers/gpu/nova-core/gpu.rs              |  7 ++-----
>  drivers/gpu/nova-core/gsp/fw.rs           | 12 +++---------
>  drivers/gpu/nova-core/mm.rs               |  2 +-
>  drivers/gpu/nova-core/mm/bar_user.rs      |  7 ++++---
>  drivers/gpu/nova-core/mm/pagetable/map.rs |  7 +++++--
>  drivers/gpu/nova-core/mm/pramin.rs        |  6 +++---
>  drivers/gpu/nova-core/vbios.rs            |  7 +++++--
>  10 files changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
> index b0c0b8fe6008..5ceb7760c78e 100644
> --- a/drivers/gpu/nova-core/fb.rs
> +++ b/drivers/gpu/nova-core/fb.rs
> @@ -219,7 +219,7 @@ pub(crate) fn new(
>          };
>  
>          let frts = {
> -            const FRTS_DOWN_ALIGN: Alignment = Alignment::new::<SZ_128K>();
> +            const FRTS_DOWN_ALIGN: Alignment = Alignment::SZ_128K;
>              let frts_size: u64 = hal.frts_size();
>              let frts_base = vga_workspace.start.align_down(FRTS_DOWN_ALIGN) - frts_size;
>  
> @@ -227,7 +227,7 @@ pub(crate) fn new(
>          };
>  
>          let boot = {
> -            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::new::<SZ_4K>();
> +            const BOOTLOADER_DOWN_ALIGN: Alignment = Alignment::SZ_4K;
>              let bootloader_size = u64::from_safe_cast(gsp_fw.bootloader.ucode.size());
>              let bootloader_base = (frts.start - bootloader_size).align_down(BOOTLOADER_DOWN_ALIGN);
>  
> @@ -235,7 +235,7 @@ pub(crate) fn new(
>          };
>  
>          let fw_image = {
> -            const FW_IMAGE_DOWN_ALIGN: Alignment = Alignment::new::<SZ_64K>();
> +            const FW_IMAGE_DOWN_ALIGN: Alignment = Alignment::SZ_64K;
>              let fw_image_size = u64::from_safe_cast(gsp_fw.size());
>              let fw_image_addr = (boot.start - fw_image_size).align_down(FW_IMAGE_DOWN_ALIGN);
>  
> @@ -245,7 +245,7 @@ pub(crate) fn new(
>          let (vf_partition_count, wpr2_heap_size) = wpr2_heap_params(chipset, vgpu_state, fb.end)?;
>  
>          let wpr2_heap = {
> -            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
> +            const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
>              let wpr2_heap_addr = fw_image
>                  .start
>                  .checked_sub(wpr2_heap_size)
> @@ -256,7 +256,7 @@ pub(crate) fn new(
>          };
>  
>          let wpr2 = {
> -            const WPR2_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
> +            const WPR2_DOWN_ALIGN: Alignment = Alignment::SZ_1M;
>              let wpr2_addr = (wpr2_heap.start - u64::from_safe_cast(size_of::<gsp::GspFwWprMeta>()))
>                  .align_down(WPR2_DOWN_ALIGN);
>  
> diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
> index 612f70333c11..37b2ae762df4 100644
> --- a/drivers/gpu/nova-core/fb/hal/gb100.rs
> +++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
> @@ -80,7 +80,7 @@ fn write_sysmem_flush_page_gb100(hshub0: Mmio<'_, regs::Hshub0Registers>, addr:
>  
>  // This PMU reservation size is r570-specific.
>  pub(super) const fn pmu_reserved_size_gb100() -> u32 {
> -    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::new::<SZ_128K>()).unwrap())
> +    cv!(const_align_up(SZ_8M + SZ_16M + SZ_4K, Alignment::SZ_128K).unwrap())
>  }
>  
>  impl FbHal for Gb100 {
> diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
> index 3a4a10487f33..637a00b2c951 100644
> --- a/drivers/gpu/nova-core/fsp.rs
> +++ b/drivers/gpu/nova-core/fsp.rs
> @@ -20,7 +20,7 @@
>          Alignable,
>          Alignment, //
>      },
> -    sizes::SZ_2M,
> +    sizes::SizeConstants,
>      time::Delta,
>      transmute::{
>          AsBytes,
> @@ -259,7 +259,7 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
>          if fb_info.pmu_reserved_size != 0 {
>              offset = (offset + u64::from(fb_info.pmu_reserved_size))
>                  // The 2 MiB alignment is r570-specific.
> -                .align_up(Alignment::new::<SZ_2M>())
> +                .align_up(Alignment::SZ_2M)
>                  .ok_or(EINVAL)?;
>          }
>  
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index ac5305d7ff5e..d185e927233f 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -12,10 +12,7 @@
>      pci,
>      prelude::*,
>      ptr::Alignment,
> -    sizes::{
> -        SizeConstants,
> -        SZ_4K, //
> -    },
> +    sizes::SizeConstants,
>      uapi, //
>  };
>  
> @@ -568,7 +565,7 @@ pub(crate) fn new<'a>(
>                  let buddy_params = GpuBuddyParams {
>                      base_offset: usable_vram.start,
>                      size: usable_vram.end - usable_vram.start,
> -                    chunk_size: Alignment::new::<SZ_4K>(),
> +                    chunk_size: Alignment::SZ_4K,
>                  };
>  
>                  GpuMm::new(
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
> index 75b98f24dea1..5c216d777dff 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -26,10 +26,7 @@
>          Alignment,
>          KnownSize, //
>      },
> -    sizes::{
> -        SizeConstants,
> -        SZ_128K, //
> -    },
> +    sizes::SizeConstants,
>      transmute::{
>          AsBytes,
>          FromBytes, //
> @@ -65,7 +62,7 @@
>  enum GspFwHeapParams {}
>  
>  /// Minimum required alignment for the GSP heap.
> -const GSP_HEAP_ALIGNMENT: Alignment = Alignment::new::<{ 1 << 20 }>();
> +const GSP_HEAP_ALIGNMENT: Alignment = Alignment::SZ_1M;
>  
>  impl GspFwHeapParams {
>      /// Returns the amount of GSP-RM heap memory used during GSP-RM boot and initialization (up to
> @@ -209,10 +206,7 @@ pub(crate) fn from_ranges<'a>(
>              bootBinOffset: ranges.boot.start,
>              frtsOffset: ranges.frts.start,
>              frtsSize: ranges.frts.len(),
> -            gspFwWprEnd: ranges
> -                .vga_workspace
> -                .start
> -                .align_down(Alignment::new::<SZ_128K>()),
> +            gspFwWprEnd: ranges.vga_workspace.start.align_down(Alignment::SZ_128K),
>              gspFwHeapVfPartitionCount: ranges.vf_partition_count,
>              fbSize: ranges.fb.len(),
>              vgaWorkspaceOffset: ranges.vga_workspace.start,
> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> index 8a934c55169f..f53886f9ed91 100644
> --- a/drivers/gpu/nova-core/mm.rs
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -317,7 +317,7 @@ pub(crate) fn run(
>  
>          let base = usable_fb_regions.iter().find_map(|region| {
>              // Tests rely on this being 8 byte aligned for checking misalignment handling.
> -            let base = region.start.align_up(Alignment::new::<8>())?;
> +            let base = region.start.align_up(Alignment::SZ_8)?;
>              (base.checked_add(SELFTEST_SPAN)? <= region.end).then_some(base)
>          });
>          let Some(base) = base else {
> diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
> index 6e9384f06f43..2e8bd2a8ed91 100644
> --- a/drivers/gpu/nova-core/mm/bar_user.rs
> +++ b/drivers/gpu/nova-core/mm/bar_user.rs
> @@ -195,6 +195,7 @@ pub(crate) fn run_self_test(
>          },
>          ptr::Alignment,
>          sizes::{
> +            SizeConstants,
>              SZ_16K,
>              SZ_32K,
>              SZ_4K,
> @@ -222,7 +223,7 @@ pub(crate) fn run_self_test(
>          mm.buddy().alloc_blocks(
>              GpuBuddyAllocMode::Simple,
>              SZ_4K.into_safe_cast(),
> -            Alignment::new::<SZ_4K>(),
> +            Alignment::SZ_4K,
>              GpuBuddyAllocFlags::default(),
>          ),
>          GFP_KERNEL,
> @@ -299,7 +300,7 @@ pub(crate) fn run_self_test(
>          mm.buddy().alloc_blocks(
>              GpuBuddyAllocMode::Range(range_base + sz_16k..range_base + sz_16k + sz_4k),
>              SZ_4K.into_safe_cast(),
> -            Alignment::new::<SZ_4K>(),
> +            Alignment::SZ_4K,
>              GpuBuddyAllocFlags::default(),
>          ),
>          GFP_KERNEL,
> @@ -311,7 +312,7 @@ pub(crate) fn run_self_test(
>          mm.buddy().alloc_blocks(
>              GpuBuddyAllocMode::Range(range_base..range_base + sz_32k_4k),
>              SZ_32K.into_safe_cast(),
> -            Alignment::new::<SZ_4K>(),
> +            Alignment::SZ_4K,
>              GpuBuddyAllocFlags::default(),
>          ),
>          GFP_KERNEL,
> diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
> index 77431c509a89..f7774b9cc972 100644
> --- a/drivers/gpu/nova-core/mm/pagetable/map.rs
> +++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
> @@ -17,7 +17,10 @@
>          RBTree,
>          RBTreeNode, //
>      },
> -    sizes::SZ_4K, //
> +    sizes::{
> +        SizeConstants,
> +        SZ_4K, //
> +    }, //
>  };
>  
>  use super::{
> @@ -84,7 +87,7 @@ fn alloc_and_zero_page(mm: &mut GpuMm<'_>, level: PageTableLevel) -> Result<Prep
>              mm.buddy().alloc_blocks(
>                  GpuBuddyAllocMode::Simple,
>                  SZ_4K.into_safe_cast(),
> -                Alignment::new::<SZ_4K>(),
> +                Alignment::SZ_4K,
>                  GpuBuddyAllocFlags::default(),
>              ),
>              GFP_KERNEL,
> diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
> index 7f89c093d591..c83b1681d241 100644
> --- a/drivers/gpu/nova-core/mm/pramin.rs
> +++ b/drivers/gpu/nova-core/mm/pramin.rs
> @@ -19,8 +19,8 @@
>          Alignment, //
>      },
>      sizes::{
> -        SZ_1M,
> -        SZ_64K, //
> +        SizeConstants,
> +        SZ_1M, //
>      },
>  };
>  
> @@ -103,7 +103,7 @@ fn drop(&mut self) {
>  
>  impl<'gpu> Pramin<'gpu> {
>      /// Alignment required by the PRAMIN window.
> -    const BASE_ALIGN: Alignment = Alignment::new::<SZ_64K>();
> +    const BASE_ALIGN: Alignment = Alignment::SZ_64K;
>  
>      /// Creates the window manager for the given VRAM region.
>      pub(super) fn new(
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 9c214b9f4dd9..a2d2d170b501 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -11,7 +11,10 @@
>          Alignment, //
>      },
>      register,
> -    sizes::SZ_4K,
> +    sizes::{
> +        SizeConstants,
> +        SZ_4K, //
> +    },
>      sync::aref::ARef,
>  };
>  
> @@ -291,7 +294,7 @@ fn next(&mut self) -> Option<Self::Item> {
>  
>          // Advance to next image (aligned to 512 bytes).
>          self.current_offset += image_size;
> -        self.current_offset = self.current_offset.align_up(Alignment::new::<512>())?;
> +        self.current_offset = self.current_offset.align_up(Alignment::SZ_512)?;
>  
>          Some(Ok(full_image))
>      }
> 
> -- 
> 2.56.0
> 
