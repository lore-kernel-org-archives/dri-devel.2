Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA2DCD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E69B112A03;
	Thu,  4 Jun 2026 23:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YStExl2T";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B86112A03
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 23:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwHwK8/3UQuXS/Si0Qr50AHwgMg0o3EsNR2IdAUkgR0ZfKOreWlyGAF11y+hLEHHa121woX4UbcqB7eCNj4gqzebPfaaDwMst7alSowLB7UZcohb7K8cTvBaW5I/uAo1W06FxlEuo5I+L5SoQt0Uf80MKZqzcQuwkpuHRBv+LP0m+t0WY4wzmPYLm1aZ5Ejzhrnvnlcu2byC+OA+GwkjSEpz2lnhnaSPScK+YF4Hff8uLVtFzk73ks/uwVfXGqhSj1s19NwyDhz0NVbgTHJ8PfbVrMGAox14bpfAcq4qFhBmMJM7khV8bWWYfIvmYPdsJzsdQD9+EUPVHjjO8zZeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJhOkig7ewpkqV0k2awznuM7qOGRh1iGRiezc0IrdNM=;
 b=S+da0IWidZC+kMNiFEw4j1JZtI00SbxUCUzIbYPA81lmSmoD1rJclLD8ec7OVqG2Asl/KKT4FS8F1tHphqPLH38Bg6DVP/HADwlrpBToEm9/o0rRxG8ajGmnuS6Pr6Hpb5kLkPV9qwhiAeDc9ttgohFQv998riOmFs0KZSh+SN/nu2U4DUNg/TsjUSlHc7/YSxsu0F8+QzV9w8D6mZ8q5fjJxfUO+WrJISTwLAACXCxN7riPy/OFak1N6Tn9/njBSqGZrFQIZHf6idkq7pkJcgO1iYd5N4ieTqbmOPwAvAxPsATESer1yAcFbNV1yEKrr216VB/auDkyrXN/SGOSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJhOkig7ewpkqV0k2awznuM7qOGRh1iGRiezc0IrdNM=;
 b=YStExl2TqkJhbUEipRPofCfFfRio4hHDZ8ZomGMOwBlomprt61r5XIeRlZKIbUXYZGTuOlABRMEW+qEG4a1Vl4m7cn5flUPqMDy3Su41EKMe9zw0oGq8dgCfVmUQWclSHhfFTmBA6QEwBjTiNxmXW8gbG+F2EnY68ta6rYYcXcDd5Wr2NNSTLHt2DEOx5OCPMZu+TVF3lZt50h4ZS+E49rHSDD3Tub7RavlaFQ0G83YbaQ0QPiPVle+3+FmB+mPfRjkqdJ2oU/DLUvvGyUxELXQARVvA7a9HixyQRcu097FNHo1RsqLqlpBW+n1Bb6aSsUzWJMKsQWJcF42D+xGHpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 23:42:04 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 23:42:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 08:42:00 +0900
Message-Id: <DJ0NVKXECCUY.2SX5BTDZ7P7M0@nvidia.com>
Subject: Re: [PATCH v2 2/6] rust: ptr: use `match` instead of
 `unwrap_or_else` for `build_index`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
 <20260602-projection-syntax-rework-v2-2-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-2-6989470f5440@garyguo.net>
X-ClientProxiedBy: TY4P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c34a13-43b1-44bf-993c-08dec292e16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|10070799003|366016|11063799006|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: AObYbTAn8IOljBYdsUy8Pt+zNtkIXHzHDa4+OFVP6z51+UufhOs2zgI6But27HRY3EBDtelScJ+65rW78AzH0DjcB2LTBmKSPksahNQZLUJGMstCXu/tslcI/P0DJcRIi9KZl4+VuA4EyPoDJ3Tt10xhF89Ir5CbAeHx/djFx9SGlofORPFwadjjdkIOCO6yroSp5JzdJ6GECQoB4h4F9cQyJ5Hq2GIlqIEdULcZL7lOhPjuLPEtuTHwqR2cKUZWS39/TwvAcMeerDz5GRtpZNdIRU9k1IUwuYBviFmdJ2S10Ztv6BpbxgUA3M/IJdNkTB3Gt/kpzh3cdT39p1hek1CLG0kt2oiRfMHGE5vuQ1PyIpfn6rMznJ5TGLcWQvp1yOf5cqN1dpGgeBSI3sKAeqvBP9rhbycOVlzCxcNoYy6GVrU9EiaQRvNDVCjw+65HkLvtxa7iOKjPc04Mt6bTmLiFljsk3goiXQ3PLLokNX6V5NQwgE+R6p2pHcdC9KRXpNLyoilFTScyMltuagkN87AVdAk2A2XIeEdbtXVM0+uyTePdQlmThm0i6T6OTjJvG4xhiL28u5ZP0Ogy6bIxiidaTRRP6+T+ivI/em7i4zuVexcxo8Rg9txDu0j6HUs9PxVwaAFJ0gch7noHIsmUs/LVJ22iAlaX6WpXJecuRL1+oATAaqlfSjzG9PyW1VZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhkVWRhYUFrWi9CcDZvamRYVlp6QTEyQmRRb3hneWFqMU9YNjlCU01MdGJG?=
 =?utf-8?B?TTFxZGVkUU9yc1Q3RVdPT3hsajNDMnlHdjVoNVlpOWRWSXhHN2Nuc1cveGJP?=
 =?utf-8?B?MyswTEViN28wblF1ZWwydWpRYkJpVVVPam9XNE9ackJrVlVuckxxdEhHaUhE?=
 =?utf-8?B?cTdXMHA2VFdwcXZleGl0eHhIT2h2T3FFYVBMZkxqY1BwVTUyeURPNDhxMlla?=
 =?utf-8?B?OXd1R3IzOGQwbkNnaGE0WmVLUGdqeWZLSytWSmJjNktCenppbkVoKzZ2ODZO?=
 =?utf-8?B?VUJrclRtRUp4anlTTnZTVi9ubjdKaXF1WVZnMWJ6aXJvVXNudFMyOGV0WGRP?=
 =?utf-8?B?Y2RrN3A5NHlzTmVsUWh5RFI1WS91RGpqaUUxVWlSclQyVC9ObGF1MjVJQUlM?=
 =?utf-8?B?NkU3VUtXT3ZEbXY1SzFaQWpCait2ZGk0QVc2MDFGTkFJM0VqUDhvaFd5Q3Vy?=
 =?utf-8?B?NzhzOUtIUlFOcTRRZUNaN1cyV2R6Y0NzOHl1cVZSTkYxVy9pQUtocFhkclpz?=
 =?utf-8?B?eno2VHNOWm0wbEVuYkkwWGo0Z0ZuZjEyaENZY054OTRHUnVMNC9sa2dBVCtE?=
 =?utf-8?B?UUxJcEFzK2JBenhpaklLNHpmL1dzKzdSK0RKT2szMVJ4M2ZMQnZiNnNpcWVO?=
 =?utf-8?B?T3ZqUUp6ZWNmTEZ6NWZDTGo2cUhmRlFuOWNVV05sSU5LdkJnTVB5Qk5NR3VB?=
 =?utf-8?B?cFBrVVFUN2gvSkcvTG1pZExLcjlYU2NuZC9HdnkwK2F1YTVIdk1nMHVUT1B3?=
 =?utf-8?B?N0ZUU0x6VHVJRGNwL21EUUJhaGd6S1pvb1RGZWxtelBlTTJxN1V4SGtYTUp6?=
 =?utf-8?B?eEZhaEZKRlRvWGxOT2NjKzROZG9VT2Q2Zjl0K21WT2NockN3Y25lSzdaR3RD?=
 =?utf-8?B?UFpjM0RnaHlrQkNNbjBjbUpYb1BOTTlRbzNmRENjU0JIUDZyRjZPei9abVQv?=
 =?utf-8?B?RlRiTVFocFN2UVRWTzNScUUzRzYzU1AvNHBwMFlLeUI4Z3pMc0RYY0hBeStu?=
 =?utf-8?B?UnV5TittWVF6c3RKNDJNNzk1VGg2cVZ1OXJ6SXNJTUZyc3NRY2xONXlLaG8x?=
 =?utf-8?B?bUVMdWtvL0tpREpHdDhET1pkMXVOL2tQNnVVNlJOUXRva0dzR1NDLzd4K3R5?=
 =?utf-8?B?bmR2V3V6VVV2QjNJc1Rlb0lPdzdLUDlocE0wM1BzZ2ZQQ2srbFhsWU55NXFS?=
 =?utf-8?B?MkIvRUV1R0h1a2hBTWd6QUxvSXh2MzBGemMvOWJBUUJKTG1vcjFtQ0RsdytM?=
 =?utf-8?B?QzMwVVR0cFRPVndCOE9QQ2NiYXQ3MWpsMnJCZ2I1a20yOFFyK0hnQnlXeE1K?=
 =?utf-8?B?eStOd05hU2xnNkVkeFpVTGdUUmVkcmFRME9yV2xpUnpUeDZsUWF3VXdmaHpk?=
 =?utf-8?B?dklUaWN6cVNxKzBTd29rVzNRS3hqV0NRdng3bzFxYkJnNEc1Sm1WR3A1Uy9m?=
 =?utf-8?B?M1dKQXVYaS9ISWxuNzh1M2hGbzZNQjJ1YjMvVmlENXpGem5GcU9GUnowZjN1?=
 =?utf-8?B?SGxxUWVFeDNDSExKYWhBRGlsS0grVlVtem4weko0UXY4WExVbHh2UjNiU2dG?=
 =?utf-8?B?Yi9haytZT2pnd0M0WC9CMGhSRkhpeXVEMkdLUTBsYmhUVlFrSEM3WWZXZEFP?=
 =?utf-8?B?bE9MZUVNbmgzNDJqMmI4ckwzOGhNcFVFWFdWY2t3WklvNHI5YlZaTUlHbGdZ?=
 =?utf-8?B?Z0FqSkYzNC9mZ2c3UHpVQjRlS21MYTNTbWwrUkVmRHMvSVJSLzlwTjZpZ3pl?=
 =?utf-8?B?QWJxNE1uMzFBbm90WTNtVm9zelE2eXBYRVdKRVZnMGJWeERwZFNkU05oOTZO?=
 =?utf-8?B?WFJjeDNrYWhxU0pabGpNekR3NlNsSUJ0TXNMc3BXUXpBNnBaM2dOOG1meUg0?=
 =?utf-8?B?M1k5Z3dNczEvc3dTWmJ4eFc2MlZ4b290TzhVdFZFcDBrWG9rVWI2UzZGZFRZ?=
 =?utf-8?B?L01FbDRvWWZiTmhJTkI3U2ZSY3g3ak1RK2NMWHRWR0tDOCttWW9nY0lPYkNK?=
 =?utf-8?B?Z1h1VzN6dHZUc1pSUFVsaFFEZkgvdWw2OURtK0N2THl1QVErSUtUV05ZcTFi?=
 =?utf-8?B?UHM4Y1VFL1hHSmRKQU13NTdadmNPajh4NmsvbzcybGZteVRWbmdYZC9kYXFP?=
 =?utf-8?B?amh6VUhrQzRtYVNSS09Bb1hCTk51ZThsZW1mNEFMaGFiZHhIMGhRRXlBZ2ox?=
 =?utf-8?B?TWVyUmZsWXFhZDV3YkVtdFpIWFRISThHbjdmSmF3WVNxOHpnNmthL1FKcUJs?=
 =?utf-8?B?NDY2c0ZyeDYvZHoxaUdxdzZaRHNRVVpJZVlVczBPKytpeC9FREhWRm9iSEp4?=
 =?utf-8?B?cXFqUUQ5UWdQcUlQT2VheDJ1SHhoK0JnN0dBUjVmU3NFVDZweis2aDgvc1Q3?=
 =?utf-8?Q?9z0JPpMp3nap7qW90t2ZvXVsL7Q8w45btl97u3aNWcspy?=
X-MS-Exchange-AntiSpam-MessageData-1: AX6W0NM3QxiAeg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c34a13-43b1-44bf-993c-08dec292e16d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 23:42:03.9366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N4pxU0Jd4M/saK7Q8bNSmAz5r0jB5iK2Z3cgu+YVovujUe3ZyzqYg2K5XiOjN4X/65EncPkrf28YAuYNfq9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

On Tue Jun 2, 2026 at 11:17 PM JST, Gary Guo wrote:
> Use `match` to avoid potential inlining issues of the `unwrap_or_else`
> function.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/aeCKlut-88SbNsyW@google.com/
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
