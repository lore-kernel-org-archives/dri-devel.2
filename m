Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AF7CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 03:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3860910E050;
	Wed,  7 Oct 2026 03:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XNY28W2T";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0893310E050
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 03:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6OMZskZmPBb9i9Y/U93dswSxOAv3xoNFX61rFHHy71hYODos74V45vMIa1dP7azr5MyGeUBj/BxUATAZOLmn/EShsTwkyhUkzf5DV8Ia2OxT6swAbE1KgdsvPVRVg00NCKs2OqiUvaG/T8gy0p9B4ZNhT4iNzupqxcGb/mxzq0MZXaVyg37oWOWUt2/P6cWCnWZc646v+0b9mCD7aQ/V5r9OUQ7/ptSLmv9VflI9Xg74WWVR2tr980GAKimlCk0uEze/5pu7lp/SyFoEBFKIOX2viRYdZqyzCHyg3Xf4MopMU8sfe3GNMmUYgt21TCV/xq7bkaMSsa835TwWgAB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oq1u3Uav5FaySA/ie8yjDB77Lc1pQqcxJt986ERjv8=;
 b=L6QQW/EQy5k0HDnqnCuXrcHATx+qYxr/Hq6XCWN+wYJATBhAUgvy9LOSPT0hE7J1HX6QvlmJN+t3zFP7qLmN5iNWx9w7KbXPX7mb+4v4Y3+DpEkJOmO7fDWa23JK5UKfccO09ZA7yYX5nxUNqZi8NqXYB7RWO6DrQeSWj6nB+wCeOekVe7YGn5ATpYCh6Xu28ZPlGTU9xg8K3PV9igQHZEuWODBxgXyNlvpLQEf9pFB08YZIHswF8zA4S0AjtX8adez3xwg6fcwc+HemwM4sW3X3Cn1EEu6ZHCccEacXKCbyCDCRQNuDetjQibcQ3D7EZiIY2tX81hh7m/Lej3en7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oq1u3Uav5FaySA/ie8yjDB77Lc1pQqcxJt986ERjv8=;
 b=XNY28W2ToBSzCj1lmlJq3RVdnD7Ip4ve+kjmKKRwSUFtVY8w2JMJCf42zaLeute/9wTgWAbflPKxIJDcQ+KKe6tu29x9jOYsRimTx7AGFpwFOab66+5UwF1mSuSYuYivzrr33E44xEfKYdevVUSoHU7E3kq/xwTJRTbw9ivYQHOYRtAnA8HpoiRjHMLmUq1DA6pT33jTyXxB7+/jduNUTYjroQ5XwK1RK1xTGB6Isn0seBAPX1spBuSmgbBu8NAMA9iyqdel6TSTrVUJx4MZ4sTLNe62IfVv9iK+idEysFnUrpmlho2uAjcHRKAM9DobXTx+y/qDw7gS5ZIUjARxiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 7 Oct
 2026 03:43:34 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 03:43:33 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 12:43:31 +0900
Message-Id: <DLYAO1NDXB2L.3NUUCWAWFK188@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
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
Subject: Re: [PATCH v3 4/8] gpu: nova-core: add NVKV encoder
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: dc240978-8555-4eee-cfbd-08df2425295a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|7416014|23010399003|11063799006|4143699003|56012099006|6133799003|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nzbD36Q97Ch6r7rKZ5f29fWonQoXUYW6U2FhKyge2yABxAvjgT6hGAFm2vGF4A7H6QpOAfZmGP13fgYZiQ6v2g9Dya6ForrWmXcJX1fxNvU3XxtQFd4icJROtjjKKtxSqGTofS6fc57lvD86F9ly8b3DfiTiiCHV/U6ifXqvTgE7g7q3a6/JE1dvKJJQPYYwrWjw31DkW1YQL//tvdLRIr4bEIylD1mw3TO4C12IWXZKoS1WCSk4bTA5AJ/LRaSKHPc8BooyAVVeJL0pDaXFSDtAohl25UtvUtw5S3oVXsjiI40mfmQ/cl91W4G5JuV5lx1nSLY2k/F7LGXi8y1rmNmUGbi+MslHGYfpSPVBX61cLJeGsK6Ea7FIlnAv/DsJStUbaVSaJX2Xc0Hvx2Ht02MnJMFq9L6jBAtL5EdyO5TjAAOx1CsG4CzZrdSjlEi762NOa5nfvc8Zt2LeidvrGojPB56kKPfMpcqGa7pCaDtdYn5fS/hceTm01V9wuHfWeQLUJv4BKAebFyP3TJTJ6idWqbY+pS7c+ypaTymNXaDjgZDKlLddesCbTdm7LBn4VqL+AFj2ig0oGHSsHBb271zqwv4yZ++C0Ltg9NS7t4CZdxB/FKUp7IHZGhWGDhQJKts7WkJy8bc0BR2gsi1m8H4kTVJnQlA+FPH64osHGPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(6133799003)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZaYmk4b0Y1enhwZ0xkVmwrWUVueHllcjdHMEw5Z2hpUUdZQm1SY0gxSXlF?=
 =?utf-8?B?VmJSWnJpYVZSRHY2Nzk0Nm0zWTNDUitQQ2pFdzhRbGNZZ3YxSHc4UmI2T3JT?=
 =?utf-8?B?T0F5UTlWRkFoSndZOFVUVXdHVXJlRWhTZkxWcmRkWXpSRFhrUlZyT3hQQkMr?=
 =?utf-8?B?WDNOcC9VN3FrV01zQU16VXNsaGFhRUlnbHZ1SmFlZmJFa3ZHdXA1MmpnU0p5?=
 =?utf-8?B?R05FbG8waDBpeC95ekxnZnlkdG1ZSXlVVWFLRlYzeW1FMU5XbDVCU3Z4bExK?=
 =?utf-8?B?S01KN0FnZjZraDNTMU5vbkVkMVNkd1dCTU0ybmNKcHRLY1lLMWtYUTA1aVZq?=
 =?utf-8?B?R01rV1pXTnp1SElkbGd3RXYvcFJTanByVmpNS1loS1dwUC8yVXVtYUpmUDFw?=
 =?utf-8?B?NkdyVmU1b0VIYVBKMlVrSDB6REJQQ093ZUt0ZnZmVWpEamFDazYrVVJKYklB?=
 =?utf-8?B?R09PRGJzY1gvQStzL0Fmc3kxZDQ1a3JSUTFBeHprd3Vrd0phbUZjOFJIZWdS?=
 =?utf-8?B?UkcyTm9ZVkovbTdhWTVDOU9SRmIyWGVrL3Qzd25BcGdpKytLM1Z5MEl6QnhC?=
 =?utf-8?B?aklJV3M4NmEzS0JqM2dZcFlPQ1l4dmhQR2hYT3dXRm92UVlaSHBoSUN1S2Va?=
 =?utf-8?B?S3ZqT0JGaitoSnUwdGNzdG1yWUd3UnNyNFZTQmpQVUg0QnB6SFNwV2pIQlM2?=
 =?utf-8?B?eU02RUVxY3VBUWR1cHp3eDlmclA4Y1grVkt5aXZUKzBRTElQUDlrb2FEWmQy?=
 =?utf-8?B?NjVxYkpSMmNkUkl6UzJ5NnZKUkxHdGtXaFI0UVU2anBsaEJCc1N0ajhpWGdP?=
 =?utf-8?B?b21ERmowWmkrNk1wY21kcSthaDZnTHZqbTZQZEN0LzN6a1VZc25iNU9na2tw?=
 =?utf-8?B?Y2JaTDE0RE1kRU1DS2JPaVR2cEFjOUg4NVNobDl3RGZLOG5Sc0l0b1ZLZnQr?=
 =?utf-8?B?eG9hWDkvd2Y0ZVJWVWduTDVab3hGODVpSnNDRXdpd0E0T2YxOFZHZTczdzlD?=
 =?utf-8?B?dkFLUHFuVnJrbEVybEdQS0lmRGU3dUpib0wrMTV3TjZaZVR5MDkvV1NJMCsx?=
 =?utf-8?B?b005eWdEMGdPdXhPZFpaWkxRaU9OMEFuNWxzVDgySG0wbkpTRjBkak9nZWFl?=
 =?utf-8?B?SW5IWEJ2aDY3UE9OK3JXYmJIMTV3YXd6c0ZGR0dxM01PNXRQOHl0SE9MU3Fu?=
 =?utf-8?B?cjJhelk4eVBqSzh1VkRNQVR1a0RtTWZjajdQOTM5OGRwV3dUdHpJczdkRUk0?=
 =?utf-8?B?ZmFoRU1TSGpwdEI4WWEzNzFJU0h2TitiTXRtUmI2ckZuRkJ4K2NGaDJOVXo1?=
 =?utf-8?B?SDFpRStyODhkNUZBVTQ0NjNpamtzaFkxYUN2bVFScGxsbjl6TUFtRXRxR0Nj?=
 =?utf-8?B?Q2IyenZWTTgrcWZ2c29HYXJ4QnRiNFhTQWxlUTFHQTdFL0ZmZnAweWo2V2Na?=
 =?utf-8?B?WGpSMnJLbUpSV244d0IyekY1dDRVTjhlaGh5NXlROWx3N0Z4eVRrWEdkOVBl?=
 =?utf-8?B?MWozWDZEQnJLL2tUZEVjalZWZURGMlJtbExwL2JlRnVxVWhBQ1pMZ2J3aDNP?=
 =?utf-8?B?ckR3NXBMVE5LYXg4dTdlTjBJZ3llTVJkMk56L1g3cCtqRHh5OW5HNStPOVZK?=
 =?utf-8?B?NjA1aG82aXpyZ1RpaXhSenl6a1prdm5jZGszVzhuamlCNFdJdFZUSE05dEtN?=
 =?utf-8?B?ZmtPZXhWd0U3UnM5N3Y1UDR5bm5YbnNPbno4M3FyazZuYUpiMzlFS2RTQkI3?=
 =?utf-8?B?RUc1Si9VaEtLcHFvZW5Rd3pCZDFhWGpjdzlPdUlJMXhjL1UxbWFpMnhNcXI5?=
 =?utf-8?B?aHk4M0pyTXF5MFVvMU90MXZtbkJiaCszSkRBb2tSQ2xHd3dsWGdqa3BzODZZ?=
 =?utf-8?B?azI5eFZLNDg5UzlkQXpjY2YvN21RNks2UmtPUFpqTlVlWDUzR25ncDFFM0Qr?=
 =?utf-8?B?ejlvaUJvazNYWXNmbysyem1oTGduNFFoYlRRQzU1R3hsSmczQUlIdUpicFhv?=
 =?utf-8?B?YlYxTVgxZG1DWnlWRThSa0x3TlcvNFNxeTlNQ2pvSlRadHVZYjhGcFpwRGRK?=
 =?utf-8?B?MFpGSllUN2toYmNvejZMQmxheHB4SC9BTnlJbnNackxIV0dCNUhvL2ZDVzYw?=
 =?utf-8?B?bVk0MlhVQ2huZ1F0YllMdWFPc3hUWXRkREZFRmQ3eUJadHZNdURocmc3RVZ3?=
 =?utf-8?B?RHFndE1KR3laWXpqeks5WTl6K2Y2TXcweHB2NDZRbk1hUWRGZkUxTEg4U0xr?=
 =?utf-8?B?VUJ3dmdKZExlM3FWdUovVG5pVVN1cmtvTzJBTEZJVFljZThDbllsa29NMzIv?=
 =?utf-8?B?V3pLN2Vqcm1MTEdBNnJueHRUcDlkaUgrYXB5VjB3Q2VNdHd5RlVRLzJ4bGJ1?=
 =?utf-8?Q?jSZ2SOaU4QzX1bMKm8ulOq4rTLG558KN3Xjg2J4vDertx?=
X-MS-Exchange-AntiSpam-MessageData-1: 7gMksFWSPyQgWA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc240978-8555-4eee-cfbd-08df2425295a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 03:43:33.7500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F+ptX5MR/cvG3gjCH0NsWtsXYKncK9HIEutEUIAOp2kvHiSJpuo4IeTabzdyBd+7z38LAsB9z9WQq5wS0i5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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
> +impl EncodedStream {
> +    /// Creates an empty stream.
> +    fn new() -> Self {
> +        // INVARIANT: An empty stream's byte length is 0, a multiple of =
`size_of::<u64>()`.
> +        Self(Vec::new())
> +    }
> +
> +    /// Appends a single `u64` to the stream.
> +    fn push_u64(&mut self, value: u64) -> Result {
> +        // INVARIANT: Appending `size_of::<u64>()` bytes keeps the byte =
length a multiple of
> +        // `size_of::<u64>()`.
> +        Ok(self.0.extend_from_slice(&value.to_ne_bytes(), GFP_KERNEL)?)
> +    }
> +
> +    /// Appends `data` as bytes to the stream, zero-padded to a `u64` bo=
undary.
> +    fn extend_with_padding<T: IntoBytes + Immutable + ?Sized>(&mut self,=
 data: &T) -> Result {
> +        let bytes =3D data.as_bytes();
> +        let padded =3D bytes.len().next_multiple_of(size_of::<u64>());
> +        // Reserve so that a failed allocation can't leave the invariant=
 violated.
> +        self.0.reserve(padded, GFP_KERNEL)?;
> +        self.0.extend_from_slice(bytes, GFP_KERNEL)?;
> +        // INVARIANT: The padding ensures the total length remains a mul=
tiple of
> +        // `size_of::<u64>()`.
> +        Ok(self.0.extend_with(padded - bytes.len(), 0u8, GFP_KERNEL)?)
> +    }
> +}
> +
> +// The Deref to `&[u64]` relies on this alignment guarantee.

nit: `Deref`

... and that's all I could find on this patch. I particularly like how
the examples have turned out!
