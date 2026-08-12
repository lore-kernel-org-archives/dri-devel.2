Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523E9C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7663110F14F;
	Wed, 12 Aug 2026 22:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="moO8e+th";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A20D10F14F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 22:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz5kTPoLaCMIu/g/XcBVB4UhB5DihB4y27YqurmPNceH3bftA5FUK558BnbIYxNUf+zyy+7u/f3KbNEXz3f8perABr2M/BIaixl8QkC/GmVBTQ287iMQP7FI11FCymEIwDBh1zl99zhjCrCXkNWXRCGXn0Tia2gxhHQIwz/jAovbPUhenrzRyZxdEAUDiChOroJEv3rI64FDSBM8KsFXAsNAgV+gjTnOAyqKVcV748XbCjACysFCEP5mUb0yToYYYeGpBZpBDU2QL7YD+Wchh7G8QnZu+MzLN0pwFkep5DWB5LUbTqpyt2TeFPe+2j2l37ByWUyzVGkEPJXhZKvtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvfCkjKxQ+FzsTwmuHyD4fqtHQy3TuuvRPbmP5meh4o=;
 b=ELtu+VfW7QGYTkEJCE7O6csECZ9/CxErfva60vljCevfTM7ovgbDTDB84Hf3yNjRM2JJNkz8gcEzEJ7U6bl2Bf+xUfd1ny+qBLpsHs44rFIXmcEgnCGahE7Qi+9YysrUqWbWyjEWJ7c/W8ggoJ/DDLsloc6/M0cIqJK6IrofrdcNQ9iYb2FyM07QrQTAictCnoYX6i0PQrM8vo9u4crFrXKmknb0Lh/iqThvi9aGrUXU3yjE+pf/JfOfHsJOX4t2KKwZxmG3vLgxKWUWtidNW7foQFOfpuR/JLceNaPfeNNLauTfA7QUEIHEsetTvXUF0eH3v5mdjW8a+owKJ/hFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvfCkjKxQ+FzsTwmuHyD4fqtHQy3TuuvRPbmP5meh4o=;
 b=moO8e+thWyL26dtVkRjxoCV4HfybnFp3l51QkYOE5hkqzaq78bbJEznhgQpP2YQdu+ABEfZcPKCqnK0qdXe9sR5nnyWTvrbV5uRxmbnUQfdIw/xQ7ZI/kcxDPc35VNiB21goHAy/ToegwDjvuMs4RdfIMe2SyZFjjcfvq7B/kwnmnNtiYgOuMNxMeQX0JvGNY/O7Q9slzSaW1goYpI6ck9DBmvbjxBwRbTAKFDOybZYk2lbMxBHJuj0wRb181i+DUTwNhb1oNx/ToHWRuFDdKyyiF4G0PNqosTUQuZulwd6uAbwE+tiVRRCXW0DfZEK8n8PXbABwNLjSemR3YpQ3Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 22:23:16 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 22:23:16 +0000
Date: Wed, 12 Aug 2026 18:23:13 -0400
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
Subject: Re: [PATCH v5 1/5] rust: bitmap: use function-level cfg on kunit test
Message-ID: <anzyURqQkllsQdui@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-1-6c767770b3f4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-chid-v5-1-6c767770b3f4@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 9686c136-f68d-462f-f04c-08def8c04df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BUT8WUW02+VNpgNdJC1DfSMvTpTBOtqmRT418Ao7Fna1vzoil1r1FIditDNC19lqGlhoWYOUVQv6hugegYEwm2YtasdQb7WY7iTIER+GtsE3fxuy1zYbbb9Uxbd3LTHFI9WqoQlWagXIh3ssvOaGXOXaEpP6dn4JvgkrBS9R14RwzgckA3OktJOkJDz5brCjYb1iKNHx+Wd7iDuMXkKXMOtEIWXn8zvByYBEa5CEi5p+Oq8Oq3oLRsC7tT+rQW83LFY94vDpfwe3gubDoxtDpE705Fep10sBL8vAc358ExatfhLyl5vV0IYt3LX+yn2sBnZJt/tJQwOuQH6c3bYQWXlh9j7am6AP2nAB6XGntjfbmu15Dq3G7ld4RX2y+AqJ3oDHXS0n+oMh9JKx+zURyAZcYE16rf7XJZkDQ00vkci76xosaP+zwgaM+wRX+xt9Awz8PbmSRwf0ZYG9mTGqSlLZtdo4IjMEMB4fMdipUpqeuTmfTSarYyI861JuYl0wBdaa9zipjWkm1b7p4DEUNBe25dN180rAKzhpFGQL29mdtIDZZjXNOCouiDgyMmg20yKo8mXHkTxhSZkgUfnhwXp7xzLp2wnuilgHa4xLSOaXMdv2/DnI0In1xKJnekrBT4kAGdFgcKI/o0Gk97t5qZb+o8CYwjp7G35Z5GDyfjI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I9GFX33uOga44Nz6xXaEKLr7oO//BQUrTVZ46/zF6IzGO0F/836VPo9VBG7V?=
 =?us-ascii?Q?f+gsYP9/0KyXoGMq3U5FfdYxRTsKdrc1ho5ekX/0yLh2xrkJVyTLdqgsVqMB?=
 =?us-ascii?Q?ImW7bFXGHbgXBf3ZurGENZNtwQMk/Ns41qHE7H7NuQ3+G/xNrjMOCFhYtB89?=
 =?us-ascii?Q?SoH2gKfPAxXRm73fxGxbvn0ignxQNASBjXIH/FDgVKkoPwjidrk3ObfLMHZa?=
 =?us-ascii?Q?c0dpPWjq6C40n4gZffIFT5J+ch9tMzdIpSU8q2c7IsJyDDpPtfXj+B1SAVM5?=
 =?us-ascii?Q?11jSbbamz6P3DpGVKfO87I2wmJuFJO/ye47RiNrGzgsIbBIxv16f+APVJU3J?=
 =?us-ascii?Q?/Ob7pT9wU5PQ4OQa5KCLBaA6Q/209OQ4zYZXmuwhdD1QpLSoHIw31IM8pkUC?=
 =?us-ascii?Q?zsU8QzggNpGPSeYUb59lhhSSrAsBncxpz767vL4ilKloVUJmD4V3YaIdAYoc?=
 =?us-ascii?Q?p2UxYCAsSaqGpKtfrFVD4FvkT8J39vPlwIxCuzZqYsYU1kCMDAPsWMCHTpGk?=
 =?us-ascii?Q?d6IRi1qtdkBpxMSa/TKN5jK1hRuYn6o7fOom5uUJmxM3XQCfgaj5o1sVBcp1?=
 =?us-ascii?Q?CkjGyAqJ1xiMYpf3DnEkjxcgtmsaHOknIUEL3DYPLgJrpr+eqsCrBekAIW+Y?=
 =?us-ascii?Q?lfSuSiziMT2/Y2fCJOmQX5o/n9ON9hzkQj/zKBk/bSrnTbwW+bMGYURTAXOT?=
 =?us-ascii?Q?wCOpMM8phAlDc/7P1plbuH10d41kvRHPhkSNzFuC7WS3tl8smo7JGfKxOQjC?=
 =?us-ascii?Q?MZITKe496ed4qoYRbVOADdixs2hBLCXGOK0fFFRtj/7Q8kUxilYpKyF8BHqi?=
 =?us-ascii?Q?9KdOrpBA0dtPBoTUel1l0ihsiXDFYyeWeJLY54/3/08KZXL13Ejo92+MKeB5?=
 =?us-ascii?Q?vVSEpmxUNBtTXmRnSbxxKtjEtHQdUKNQaZvINxxyL5RqTQe6b2Q9LuQUTe1y?=
 =?us-ascii?Q?jgskxry1puJISC8s4GbX7ldUFqTP+pLeh7LH2jhAEllNOs6gKJhmS0gTCtx8?=
 =?us-ascii?Q?ec2JVrU+pnXulYE32obcp8pDGCmHVFVsUUV97StZxSHSBvWeZwvCKkO082Hg?=
 =?us-ascii?Q?PvLCNEXpuZQ28gxVUxjojF+zhif5lnOSDx208mJkYoW/HYVhvRIMgdMaYbjj?=
 =?us-ascii?Q?Hbn93j96hi2Unt9wTUxZXQfD0xcwit6uzHDF3miUAGq6INAz++Khg7gFdmlT?=
 =?us-ascii?Q?AB+X06h957w4eacbkFj3J7JxEuwF5PIbblyKSPkARXUqvy9ninm7BcyOA49x?=
 =?us-ascii?Q?LXW3nEgopp3ZbaAK1EF9FPqlxxJactTHxrNyjCokDTeMXQvlADqojmZd3QsT?=
 =?us-ascii?Q?gwcwSqTojIN7o8ExPwwzhujiNZZqHO1TAkFOHjZl94BDRa0xIqM7I7MXA86I?=
 =?us-ascii?Q?z8rGQDZB40fKTmuNUeuU5UZPZC481xoC/D9jiwQcpmcS7e/x0pjLgEoJPjGO?=
 =?us-ascii?Q?1wgjC9DIYQ8o99SAQJf4PmILp25+lJXi9Kxim7fcOAo2ZBflG+G0KigIc8W3?=
 =?us-ascii?Q?ko0g38ed1Q0xgSKBIjsnF6zKEDX5gz6OmjgfA8jASdQaVgkDmK59N/vQH66J?=
 =?us-ascii?Q?YgtU4NqdkNJWthdnaCLxlBq+vUtKgmsFp3ueBEb6N+Ca7P4eMG8QZQgj5pJh?=
 =?us-ascii?Q?tSC9HAOZPv0o4SHfmk5r9A9toHAky+CLMCBgs7NecL6xhjwZNsdYIJ6WWYOx?=
 =?us-ascii?Q?AJZJw1wEKB9VdZzFJmS1V0mrsnHCROdCG+didSUXKyMhLXvNAYtpyoIhY9fl?=
 =?us-ascii?Q?64Xkyj7N9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9686c136-f68d-462f-f04c-08def8c04df8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 22:23:16.2321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+9jtRqtB0C2+SWANGeUXoEeReO4HRA+2tDNd9tQR+mRy5CYOUh5POaVkSmZIV+AWWaCYZGQjYMW4wycXkV+gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651
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

On Wed, Aug 12, 2026 at 05:51:21PM +0900, Eliot Courtney wrote:
> Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
> we no longer need this workaround.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  rust/kernel/bitmap.rs | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index b27e0ec80d64..a43bfe0ec3dc 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -572,24 +572,21 @@ fn bitmap_set_clear_find() -> Result<(), AllocError> {
>      }
>  
>      #[test]
> +    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>      fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
> -        // TODO: Kunit #[test]s do not support `cfg` yet,
> -        // so we add it here in the body.
> -        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> -        {
> -            let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> -            b.set_bit(2048);
> -            b.set_bit_atomic(2048);
> -            b.clear_bit(2048);
> -            b.clear_bit_atomic(2048);
> -            assert_eq!(None, b.next_bit(2048));
> -            assert_eq!(None, b.next_zero_bit(2048));
> -            assert_eq!(None, b.last_bit());
> -        }
> +        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> +
> +        b.set_bit(2048);
> +        b.set_bit_atomic(2048);
> +        b.clear_bit(2048);
> +        b.clear_bit_atomic(2048);
> +        assert_eq!(None, b.next_bit(2048));
> +        assert_eq!(None, b.next_zero_bit(2048));
> +        assert_eq!(None, b.last_bit());
>          Ok(())
>      }
>  
> -    // TODO: uncomment once kunit supports [should_panic] and `cfg`.
> +    // TODO: uncomment once kunit supports `#[should_panic]`.
>      // #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
>      // #[test]
>      // #[should_panic]
> 
> -- 
> 2.55.0
