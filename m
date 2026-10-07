Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36411CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 03:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEB610E0B0;
	Wed,  7 Oct 2026 03:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNpvaxm0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F076B10E0B0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 03:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM8mqhDnlTnziSLeM5xn6tmYS9uOS4EeEJMtsI1pzu1OYrU+l6LKOuizCW2Ohn03XBZHU3bIWqfIUAb6wPNBBh2XCkTXNiKu0bYNBdRTPZXJF583SnWGGszn4xUAkysSGzrGESIOzlSYEEa4i9mFw/yHPMyYbmgklt3mDBMhONfZAgdPaxDe7PEa4+m2CE45v6eicwhPemSgPyfgwjFNfDbTsBHVJClORhgnGJefywKpEWim2feaH0DxBO3pZgDs+cpCBDKCTJOZVoqYvQgiYoqg6b5BghxbuG7I8cHYs+9qb+7ZaMnq2nNi9Tx5R8LKjbM1tCGL3eJ9IdFFsyjJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zPgaAStAQIEjux19u433yL9prUuWq9T4Ax4Xfdp9+g=;
 b=lcchXhsyryLuhuC0Cq7zKrvv/e1Kt89hMYyTFHOVmb4SdxHtKuUKKxDdSJenR9DFTwbxF8CU2VbXJ1HAOTuOZKtTGXH22RuvsiAjowe70lAXeozJzq+98nzRBikq9bmh+4/iRfeilDlWvjXhytmGdWUHgcEDFi7IdbMZDZQwx1NwOiK0+p6r4Qe0K7AHYvpTTi0FrpUP92poniVYEv1elZqIpNkOMcNGhu0bZlX3tqAHUAkEdJzVBhr2WPzJI6SFkBhSuXJaQuza6fSHb/k0EgLcb3s91Xr2BXi0ya08IWGsPQf8oU0NWkerlK13nNTLthH0zzJTt6eRY94G2oAWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zPgaAStAQIEjux19u433yL9prUuWq9T4Ax4Xfdp9+g=;
 b=TNpvaxm0wD/50JbnzkijlD+7wFvv04oz/kTEfIXn3OYapz5hfa8wTtt41Sstq49vJxcRK/4F/EdsEpq0NHvuVGpa4EaG7iDuLuCUnPbFSyKX9qCUOYPiNg625/Y4ARVSQVXt4xhLQm4k/1/hIJqXjInuHNhnRGLfWOccOTuA9cw3e492ZtdoKIrMsU0CcAJIJKwjlf49SyEecVtr51CVHA1qvQ63hzbTMpI0XyO4wvfk/GsEwKgN70sq1EtTwkJniaULYROeKmQu5TomLUHACuA2adDfU/7NZKkQWQnUTwJUFKXkqUged6iK4W+4a42AvxHd4Jpfs2UlEwA5bHgwZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 03:48:37 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 03:48:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 12:48:33 +0900
Message-Id: <DLYARWONCNC4.16TY7TATZG2DX@nvidia.com>
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
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
 <DLYAO1NDXB2L.3NUUCWAWFK188@nvidia.com>
In-Reply-To: <DLYAO1NDXB2L.3NUUCWAWFK188@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5bf76e-d262-45e5-14d0-08df2425ddc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|10070799003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 90M6xq9t6rMBN9k2odk0U3nOomx8ta2OFdCHJG4nNYzeSlSEoDZ/GYYK4ZwdD0YBIkAmLikxfrBUaDBFGMN3YuqDaNLCUfIMcWoRB00/Ps01sOyiXdHLqlxWRulyf7w95OygPe8UMFrZxSwo9YpE2yfWDlpoUSPaTuCUEVk/H4NWm5N6k7MpndoqMga0gmyt6WJYHAvq130I3fmBKcpdN29cgb0GkRdQ8cW4heWAqyXHJM8o5PZSYbNarTy3uKedBvxf0jABJrJXWtdEcb7dsWSrkRSkYrhL1S4FlLF49tQLP8XLQUnfSPu4E7Z+0Y8nDu/efTQ9e69FLsSiOUaBJaE7x8UzDNh0TWK164N+S9SjJFL85x/qlCKjSt1ofL6a5IK4B7YbBKCI5gd3BuDmsT5Spwr8xXZ3iAOxnHd/bV93tkPeids+70XmjPDTqvC3aCUq9z5S5cV08hyV1wc+0+eQkfMIl0SvkFpEvJBF+FFVYJmnXWak5Bgp6ObCW6PmK+u8jvlcFPAat7lmdkx8mHtW8pUnIN+gfXYC+0fvErWO82PmbmMljbKnSkmZHj4LKriOJrB2tebmHICc8BkWcLJ9thpUziVJoPz8NKR5EJK3iKf6lLOBUbbSMEXGwpkksTJ0Ixb5eITOAyy7z83FG1KNCU5399/v6qL7r84Yyos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(10070799003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVhBcUsrZnhNa1dWMHhvWndCbitxOXh4WjAyUG1CNlBZK3hlc1J0VHJ1L1Fz?=
 =?utf-8?B?Skg2WlpnczBnVDBEcmdlQVdpaCtvd2hoYWZ1WE5sVkwrMWF1Q3pGSTV4YmQ0?=
 =?utf-8?B?b0ZNQm92SG1LQWR1Sml5UVJXakNPTmFGS0lOaUhzeGNVa3gzRVVHcVFCQ0Vl?=
 =?utf-8?B?eVI0bDY3NHhycHlWdllnMG1rOUFnK0FJQlJNcU9nVm1QOFRBYUFXQ1VlUWlp?=
 =?utf-8?B?bU5kekVTMVJVUk1KQlBCVWNqV2xuaGlLaUtkZWUvWitCMDVISlRJS2pmZnhr?=
 =?utf-8?B?SmdjUFpXM0RRbVVVS0UxdDhONjRNNkxVM0VrUkM5U1d6QjloYmoxUmVVY0Ns?=
 =?utf-8?B?VERpVHBaYy8rK1c4aHdQV1VXVHRFZDhyMldFWUU0RWFEdWh5WTRpSmJpU0xr?=
 =?utf-8?B?MVRvVVVPekhQNUE0cGxWeVViQld5em5HclBuampIYVA4SHhjSU1CaHBCRExp?=
 =?utf-8?B?NW5oWXFSTXJBS1VSSVhSQWxPc2QzYlIxNTl0T0VHZEdIREhhWjYzald2ZW14?=
 =?utf-8?B?K3lWNm1RSGNsczFvYVZJclhrbHVuUUZvM0RsaEZSTzU2Y0lqZHovbjZQQUp1?=
 =?utf-8?B?dnhkN0xxUVR5bE1mYUhScGl3Zm90aTZyeTdlMldKRndvaHhOUmQxUEZpRmR6?=
 =?utf-8?B?aldMN3V6NVpMeGZjc243aVhvRnhxR1REQXU0L1ZIY1hwUnJKV0Q2a0lLdFRm?=
 =?utf-8?B?eWF1VGFadWZhZVVjWFdjODRuQVQzbnpoVk5tY2FaMUNZSndnVTJYdEdwR3hh?=
 =?utf-8?B?ZkI5ckdSZDA2eElyaWJ2REkyZC9TR1NKQVlUdTlMb2ZrUVUzeWhjOWdFTWFq?=
 =?utf-8?B?SFNXZE5OSFlOWWJYL3FoRXNjdkZrUy84OEVlUjZCZjkxa3A3bWxCNEt2dU1t?=
 =?utf-8?B?VzlkNVVBZVpmQ3JhVzl6dnBKejhLWUxyb2VlOHlMUmpDZmx6U2RTNE1ITEVx?=
 =?utf-8?B?OVVaeDdxK3VwV0FtSnRPR0NaNytYdm1yTXl6UFZEaXFwc2d6dE5od2ZNVE14?=
 =?utf-8?B?T2hSZkVKVWpBeTdieWthZlgzL2svYVdmejc0cXpsVUlSUUZCdTFmSjRYWmd0?=
 =?utf-8?B?NUwrZHRiUy9uQjhNTlN5Ym9GRmRWNTFFeUZqaUVYeFZDR0dmOTc2VG5UTk90?=
 =?utf-8?B?Q2VjbTNsdUNSWnUxblMwMXpUOTRqUzlOWjk1YXV3OUJQZTZkaThwNjdKVkdo?=
 =?utf-8?B?K1k0VVBXWVA1aXBYZ3BubExzbCtrWGc5WjdSNGYyOUZjV1RNdEZXWTR1c3hq?=
 =?utf-8?B?TzlTejV2QUdKMXBqa0xBNEN0bUMzZXpTUXowYlJ3QXhTaitSY2k2Z0N6YnJG?=
 =?utf-8?B?ZHdYUE9NaHRZK0U4K0oxRHA5c2R3SENQdXhsQ3FZVGRWY09vZWY3L3FWRU4x?=
 =?utf-8?B?K0k0T2dDK3JSN0hOQ1UxVWZrSWNVYWt2Q2wwRmgwODBoWEZvSXhYVnZHNVpx?=
 =?utf-8?B?eHZaYVozMnN2ZUVWVWtBeElldzdwUVI5ZUJ1dGRTaGY0bDlQV3dyV09rbi9H?=
 =?utf-8?B?eGhOdExIR0hLVUpnMGwvUTRsaW1lTHpYYkQ1bGpmbUlRT1JKczNVN005QkpP?=
 =?utf-8?B?TjhwLzk5U0VqS1F0aTVjbzZEV2kzU1BncUhycENJVjFaTmxmVlNrdGJ1SytY?=
 =?utf-8?B?YzFGMTRJZlZNeGhWNzRwRlZMdGxHNUZvbzV6MlJkUzcyZ0dqY3FtUHJaVzZn?=
 =?utf-8?B?MDVpTnFIT2JIbjVsMllFRUhhbWlUY095THJ4bXM2RWVIYy9PdmUrRDVDRlRF?=
 =?utf-8?B?MGR3b3dPR3RleXRVUkR5WGowRVlKRHM4QWRPK05UdUs5V1ZLc0pVRGJyVlYz?=
 =?utf-8?B?cVNYTXNwbE15VzRxMFdrVGpmZk5WVnFNeEpJMlZqM0RoY0pJQm9oQS8vdGxm?=
 =?utf-8?B?UW9rTmY3Y1MvYWRWQklQYzFKeGVENGcvVFZmdTVtRXBUNUhtV05nYjVOTFRS?=
 =?utf-8?B?YmRIdWhhSGRGelJQY3QxQnRSREM3VHBVOGtLTzVDSVZNVTk0c1VwaFRHMlUv?=
 =?utf-8?B?MlJzcUJpTzFpbktybkFLUElQQUp4d2ppNVRobHVlOHZydG9iaW5aekRmNnB4?=
 =?utf-8?B?TTZXQ1MvR2t1SWltb0RScU1rQnc5L3U2a3ltSzloMW1tUHlmWHVhaUFtbW93?=
 =?utf-8?B?b2E2L0wxaGVLVDZLT2o3ZDVIM2EwSWFDUkFMelNST3RVeDFqUWNEeENvemFM?=
 =?utf-8?B?cmxkUFNvMk9zM1hGVlB5aTdwM0dQMUs1bnUybVpxM0dvQzNDVjl4QWNJOCs1?=
 =?utf-8?B?cFY3ditlOUQxa0lMcnh0N0kvWG0rSWJmbnZyNUZtNEUvV0tzcGFVeDZCam5J?=
 =?utf-8?B?QzhlTEZ3bWRzYm9nTHdqRFYrdmluRkw1UHZGTmxkdGNZRWdkZkhNUzNUdnFu?=
 =?utf-8?Q?iUggRTd3oWogxUToMZgBEyER6LTka7vcSiapYxAZRR1L/?=
X-MS-Exchange-AntiSpam-MessageData-1: H6SoGcXXkDJ/CQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5bf76e-d262-45e5-14d0-08df2425ddc1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 03:48:36.4361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh94morPZw8xGMcg7PsvWwsR3akdRMSQjh33oK7MUB2PhzAJjzwfCPl+Fv+ZiwithwtMbiCsKXdzIfhJeyGEpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

On Wed Oct 7, 2026 at 12:43 PM JST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
> <...>
>> +impl EncodedStream {
>> +    /// Creates an empty stream.
>> +    fn new() -> Self {
>> +        // INVARIANT: An empty stream's byte length is 0, a multiple of=
 `size_of::<u64>()`.
>> +        Self(Vec::new())
>> +    }
>> +
>> +    /// Appends a single `u64` to the stream.
>> +    fn push_u64(&mut self, value: u64) -> Result {
>> +        // INVARIANT: Appending `size_of::<u64>()` bytes keeps the byte=
 length a multiple of
>> +        // `size_of::<u64>()`.
>> +        Ok(self.0.extend_from_slice(&value.to_ne_bytes(), GFP_KERNEL)?)
>> +    }
>> +
>> +    /// Appends `data` as bytes to the stream, zero-padded to a `u64` b=
oundary.
>> +    fn extend_with_padding<T: IntoBytes + Immutable + ?Sized>(&mut self=
, data: &T) -> Result {
>> +        let bytes =3D data.as_bytes();
>> +        let padded =3D bytes.len().next_multiple_of(size_of::<u64>());
>> +        // Reserve so that a failed allocation can't leave the invarian=
t violated.
>> +        self.0.reserve(padded, GFP_KERNEL)?;
>> +        self.0.extend_from_slice(bytes, GFP_KERNEL)?;
>> +        // INVARIANT: The padding ensures the total length remains a mu=
ltiple of
>> +        // `size_of::<u64>()`.
>> +        Ok(self.0.extend_with(padded - bytes.len(), 0u8, GFP_KERNEL)?)
>> +    }
>> +}
>> +
>> +// The Deref to `&[u64]` relies on this alignment guarantee.
>
> nit: `Deref`
>
> ... and that's all I could find on this patch. I particularly like how
> the examples have turned out!

... although maybe the Sashiko comments are worth considering too. Nova
does depend on little-endian, but it probably wouldn't cost us much to
e.g. call `to_le_bytes` instead of `to_ne_bytes` to make the code more
portable.
