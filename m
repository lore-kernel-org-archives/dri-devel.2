Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0E606A334
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iwpGs71+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A42510E25F;
	Tue, 10 Nov 2026 17:17:50 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 495D610E31B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubHmZeJ94zIoo1nXP9SzQ8jPtS5W3QrlYep3NxbPxiHa+/VlwlFULiDNGOCvmrhiTleoL3zoHBlGRgIS+R+/6eBB1IUHUC6P+BQ0r9XcGi86kMxgHWvG2nKL05p1eE2Ho/ZEXB7afiYUCSnw6mUdaiaHqphruk/SIab1eySpBRyGNR0gd24+sKDOIbWVhzYRyro6a4oue2FlPYvQaU8j5w5PWXVpP3lCptPeZCDiDfh50lYKC6Qp9GVQlBfsgJY9Qu6OheOewxopG7NnkfBYzARw8I5AV6C/xlLVYBmfC5zFVXMjJBec0wW2jAzdsaWpjn7cUrnuftSD+uMn+Fta1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np30jfTbjAs7KOdDcJm8BZ6bqjB4t5fJI+6aC0zo+WY=;
 b=TiWY9txv/xz8/STGGWxjaUxoO6G8xO+VsOLAoXjPO2KCLA9x7ygMWRnguYj7ZezoVzZWvid+9NRN1HkBywg0pRjwPvM1hWa+B1zZk/TXXBXSP0AohpZAuIgEkQ0dfclIUm89eJZT1IvKtTUFDx7gOYbQGa87qW8fdxlD22l2PUwp58UE9SiVVrdyBnBLUjyXmFm5QWqyrgh5xhYLKQ1xl72eyob/+460QMD/E4CdgbNFXSGbsuI21fnas3eEspKCzXKyZHcd+acMAwlk1FMc3a1TJonwy9+bEtsF/3z7meRAYJiNUfaBJCFzD+yo8J5J0jSfasQv+A6UIQm2uk83kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np30jfTbjAs7KOdDcJm8BZ6bqjB4t5fJI+6aC0zo+WY=;
 b=iwpGs71+wMS3BWS6/J5syGWoY6GSk+B+rHXgtYrpx0MBAlWl3wdLWUxXbDO+nAxZu7LwKclNdKpgW/Fsip8trCyn+krjQJ261z1rkvHhJR5NpJZzMjmz7KjpIGvgGERdrdkxtuKwurEb3Ji0cJRU2Qo3FPhp6VNwv+9FFcPbNqf+8ftswx5PfA337uiRiQ6Va6aUPvLfJ/DmZrblHX36F1R/MB7dZ4SSvvBWtzR6cAeZuwY6Ob1G8ssVWT8RN8BDgdfkDT2169RY2bq0cPGywIqxYxJEfdDeX6s49yVt2xDWlr5Y2Dsznr77JfP4Pvjd3WI/ZUTYuDeyHrWoEPmsfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:17:35 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:17:35 +0000
Date: Tue, 10 Nov 2026 12:17:33 -0500
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
Subject: Re: [PATCH v11 1/5] rust: io: use Alignment size constants
Message-ID: <avNRlUdtK4lF8-sj@yury>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-1-082aa9bf5a91@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-chid-v11-1-082aa9bf5a91@nvidia.com>
X-ClientProxiedBy: CH2PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:610:4c::28) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 79998af1-44cd-4c61-1803-08df3f4e82d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|7416014|366016|261102123227099003|261009223027099003|261021123027099003|261021121427099003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VkwnnDO/Hy9FGeyzuIEfluiEeuOLRkEnSd6afHo6J2lUA+/qgXG/Cymn4cFOa/Ghr9PgSRsC9QJs3QjIVOVZvsbFexEeZuCjmMiM5tGEi1HXcVUOwwl3SEZ5MU0iOAPDNHEa1WM+fEPwtP9x0kk0Jl1pgBZNzYnRfK+ge/7Nh8L6ar3MjgxdPNoK0cTpF6bv83i95DtH+KoLlYit+L+4m1+ENr4hqjLNcfJBBXcwyJokbpHOxiJZKVtApDs29mFWMw+oQpryZDoIVYWCmxlL/nqw/7OLo/qUN/9r3aw2pmeNDT+GvNbUJrIgmogtSpf5Qfktygdze29r3qB/VhIiCFDlDOzEDgRG+ljoribe/MldcqxGxLD0eoTGgxX6B6/MeD5rlIUXYZU9Zpzv2Oh4oa+cLX1/gxjxzmUN4zvuVsp0x94En9vzZpx4HgDQN4cNdl7E6fMEjmJfg6qjIGuQDCjtI+chL5FW/gNyTP7RSiFE/sTfro/TLG7Xh4Si7FyBNmfiiqivjfvLPiGGXmIiOnBEHML9jFJhoAuXiOeV41v7nYyVYA0sTFupCkrgUMp4Bl1Tgn2p+cCKqqzOryKfFMLcjUOeLxBHxnFTleOgtC3hln5UGKJzj/xltC9JpDzceNvhIuHbVVLBLKU3O/FUk/RWxTxMKyzRL8EoQdpHWWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(7416014)(366016)(261102123227099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?deoHvm8A6wvmI3RGPEbxMMa5zT8krrHljaafR9Yqp8fBZH6Tki/Vijx9Yzfk?=
 =?us-ascii?Q?JLynHDJp1OLQExfHy4o3nso01XBD0oyU8+IroU2vI3Hgfjbym1nwe0LLPzV1?=
 =?us-ascii?Q?nlpgingIZPJ9ru9FZN50nVngepRP1tPHxd9Kwrb4UQ/Zrhx3rN6r4LT/uOkV?=
 =?us-ascii?Q?RZ/0FSqI9mbWERj4UvULR8VPgVcCfGb5s2vDnr36vMiCiF3vhV/lxLHyc2Cs?=
 =?us-ascii?Q?g7KpCAZCCu4FFmGmwlN/bGMwPtP4WiFkuiSKzasKrbxGAQMzwmPMN5U+iq/c?=
 =?us-ascii?Q?lCOnIQN8M/LcLUxqLTEXi+8LFUMxX9eHb4Bl/WMc0/SXI69GxHqUzj/XTZg5?=
 =?us-ascii?Q?mqc+t8KCHZpeaX1UG4q54YMhsPRQedZbmqvEQS9R5vEwImvjYQjUHids0C1M?=
 =?us-ascii?Q?VnT2X/tIbqgcCxnjXVLUIiL1YNNjC39rnDM5GZ8jjKppWmmj18lI0/xIP7Av?=
 =?us-ascii?Q?bu14At1+du6UF8WsTCHTU2a8clJatHWlfVSIn66eL/ir8auRRLcDV02s6EOz?=
 =?us-ascii?Q?xP40dwb3kqffzv8H4p2tPVnK05ZBoDYmmUxxaAUal934dBLmEhzy3PsVC+W4?=
 =?us-ascii?Q?1sF1mEcbid60lJ5rmOpvT1vQKsj13ZIChGs0kvsi7bbIAI3aGn6R01nTd+8o?=
 =?us-ascii?Q?mrNJWvD6GDf5mKQXXhx+ZHrX044hAdvmQCXzJ1++JkUInouyLwuZU4Jpmn1I?=
 =?us-ascii?Q?9a0wAHPMDISLECNNyekkvamE/aLuY8vpXiqeWuHfFsZLg3vgQmnmaqKQYOye?=
 =?us-ascii?Q?H1yiDnWBD1aGzz0xCz7KFY4wnNl/O18HiQGeLmgyAFdNjIxS6ZblZYTTc++n?=
 =?us-ascii?Q?RrOmTPT2ud3W3d8GeiUDQ2cEE+nKI/gbj3cSUANPVTJt1n34veRZdkZlpQFz?=
 =?us-ascii?Q?8WGFJtXw/smuL6vEv2jOFt0bcvCtCCYEavgDBbpEvCCIsNBPJwXa8W6/lh10?=
 =?us-ascii?Q?avhcAxTQqSw2LNqmTSDEwODPeduWGVMdqW251q6sEx6Xn16rwP2iJxIrt9EQ?=
 =?us-ascii?Q?aO2I8349gEf5SYaAi5cziSxZ0LjjrqAglTyhl9yK2DpuE0Hqn3a4ziG4a+72?=
 =?us-ascii?Q?1EESVkYoPXve9ucXR7GR6bKTxWkYU7YE6fVQUah1NoLKTjiHQzhacDmFwLYQ?=
 =?us-ascii?Q?3VjMHUAOpbejyAHwUyw9iPt5i2TLRcvV0YENzedfzOJQuqBXll+jKPmhtYAb?=
 =?us-ascii?Q?jKP9cmo66ltcs05D8ai1SVFhr6cVATh6/24kFrI79BxBlPdEm3BdMkkQMu37?=
 =?us-ascii?Q?r/dW0x83DgrXIw7BZWhUkK0CV68k/s+50qTgiGNneVeCFrPcvwsbcOC/AsJo?=
 =?us-ascii?Q?UE0u3NpT8/zo8SzVsGWwy3hr+FUNitQpya00dzsg8h8grIhKJKBqLNALoKKt?=
 =?us-ascii?Q?i2k80nEQWlcIRXOnRsGwGjs10icAkRxbggBqbDMbsMCW1CZquOhkfWQ+vYzj?=
 =?us-ascii?Q?KooC78EjCTCyRVrzj7RPHnjAYIik9wR0DqzXzZlsFXcU4eyCE6kEYyfe73mf?=
 =?us-ascii?Q?TWkBVlpaEop3iYV0ALiWyqiXmd3n6FN+9dngvqMQ8eiU2QsqxLa3FTYXX5PH?=
 =?us-ascii?Q?56JQAGwDQECifyHSJdBUDTYpXKKF/rYooMXZlQYMwqs+vAKnNNuXwFhYvE08?=
 =?us-ascii?Q?KHpjyt5rcszPIIOuhEdGBjWUHnfhFhEHpSSq7+Yd0X4crem/zcns3k52lfh0?=
 =?us-ascii?Q?WgMphuis96d8Ql6WXbioYFy3LfVAre0SDkR9oziVFsL3R2ABSvK+PifWoo/2?=
 =?us-ascii?Q?hvSkpEXEiPSTINN09ZsAj5zFL9XQNfD2nbDrFAYULBjF+Um89HVS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79998af1-44cd-4c61-1803-08df3f4e82d2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 17:17:34.8169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5cc3+MyF9bJ+YIVRnnrfUPubxQse0IK25sTqQuSDUfyoZAe+r8TvypexixJ0I8u5epdNpEv9XZga7rQeHdK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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

On Mon, Nov 09, 2026 at 05:32:49PM +0900, Eliot Courtney wrote:
> Use `SizeConstants` for Alignment that are implemented now.
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  rust/kernel/io.rs | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index a877df11a03e..31c6975376bf 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -21,7 +21,8 @@
>      ptr::{
>          Alignment,
>          KnownSize, //
> -    }, //
> +    },
> +    sizes::SizeConstants, //
>  };
>  
>  #[cfg(CONFIG_HAS_IOMEM)]
> @@ -154,7 +155,7 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Sel
>  impl<const SIZE: usize> KnownSize for Region<SIZE> {
>      const MIN_SIZE: usize = SIZE;
>      // Alignment of 4 is the most common; different base types can be added once required.
> -    const MIN_ALIGN: Alignment = Alignment::new::<4>();
> +    const MIN_ALIGN: Alignment = Alignment::SZ_4;
>  
>      #[inline(always)]
>      fn size(p: *const Self) -> usize {
> 
> -- 
> 2.56.0
> 
