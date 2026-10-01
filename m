Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC29CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901F810E0DA;
	Thu,  1 Oct 2026 06:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hsojxg4S";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013025.outbound.protection.outlook.com
 [40.107.201.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15BA810E0DA
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N99hdi4uaiUSahVW+7NZo1NNNpy2ocQbT3lKOy8wGySR5A7JHukfLJ0K+SLd1wyzElAxbUFHS8KWIvMF/OZylf76gmXUUTULB7Zo8qEIclU6IM4+gclX7YnH+ucWYcKlJOw+XaF3jEsm5h0CgEc0hRo0YAxv2ZMsk34vKORe+lf+Q0unypPeZA6jTP494Z3eh/qUpfMVo/Rg2mbcHAtgcLukf9HUxdLpbPDEFNn6NgdvWtKYSrQdYSeJH6iFA5fUUAd0hZRKC9g7R8EUGfY0L0eV/YfnA1mgXAyihLKNSnU8aZX1gVxU4eReGuUq+8YIHgffvwToFRD+s2+4U2dqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c53cWjxIDYdNGDVSyc9BzhYlaONfEE+triWsXpdgvR0=;
 b=eZe+dYv2my03NRLQE6jhi4bYtI4z9O8EJbeP5nPtlx9z10IyA10LusCcSHQlxExylFya4fi0I/wGIg/nEcS+duQ7R7uh8+31+inGDVmTLMV0DNDOfWJq1uf2/IdiL+TzPraCsZcr00KMViFBdqpbqIqLVEqXk57iYtB6sHcaYJZ3alCm/DUbjR8NmEN8L7RPyKx48YYdabz6M4EDvEC5ontzN++UidXNrNlM6XwPBChwsuf14ADsHtqxgIxsFNDWJKj1OVR65fjgwN489U5x0+FadlHSMK6U4FvbqCMMn7wNQ17WfAn76GrDpuis2wiZwuSLMRXDYetCf5m84yh/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c53cWjxIDYdNGDVSyc9BzhYlaONfEE+triWsXpdgvR0=;
 b=hsojxg4Sctz6JYq6nBxPrZJX+q20ugux7mxfSKAUeK8erpVaJvOs8exOquvzoO2iSspxcujBKcKxNLi83fMw57CWD1s+QkhTacS6L5iEfuyfclNEnS0AF/9a6o9ROrUWQJkZ7HIGqOFhTqueug4tiRdOI4YwsDZHLZta/orKGvrAwEtkgcxzXs5M0wcD5ArjmNP6nN8HJrahQXLchYuIX3HqOmonhZU/WKN/F9ApxG6njelvAeZ01Qp0Baha8qrz8cPYx5DwP6ISUdt1ehKOa5DVSBAfSGXVG0teG9gAZuKIjhvImfer0KtJPNDEdobC5x9tCv3UD9j9A+5xwWsepw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9775.namprd12.prod.outlook.com (2603:10b6:8:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 06:20:44 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 06:20:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 15:20:40 +0900
Message-Id: <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com> <aryYkkB9j14xnWo3@yury>
In-Reply-To: <aryYkkB9j14xnWo3@yury>
X-ClientProxiedBy: OSTPR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:604:21b::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: a29370d1-2e0a-46d3-6790-08df1f841fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|23010399003|1800799024|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: Drbj6Z2rRxZIiLO+RAQvpzd3mRQtUg2+ebU+eLtsis0gmiaLJFArKHdw1r0xmspWTf+GFFVe/W73CWSbqTEo89vhccNrkE+65OrQ51pq/hR7RfdZiowJ4oqeSBbiPW04FSycbtTj2hwu0cOARnT9wpiwY2iuQoITL4/iYdiTEZZOAWFXIdpVhVvaMoK/OH/vNBYHhv8bRc5jKEIl+VHFCj09OgQHwdoACgp3ixu8sSPpZ+6r1BVJnKFlk71ORB42Ruc+ihm4enSUMV7hI7yYS2TynlT1oiZRJyZxC9S+ibqUwpwm1n7e+PteWkrFrwIlWTDexptTtMk22WvMxMsWHAua75zCncekmZ3ZZVr7WYYECTBBg0v9NPO/GEgx0QlYD5fhKXlU+dLk+eFuFelWu/Yko7yt2sonp5uEesUbeDoKdmDL2jdXbBsu4zMF62kw/hrog9w0QtQalpzh9istRQy5eCxZWFqtb0adC0DclPgW+MFGqVbyNYWQ/3lekBqf9s9gv9wDHYbSFfHh91a+V+dNArQSxt2UQdyQFTvAtug0yFOpkLEu9c7gSgqxDbANg+e2yMhocvbdhW2Q7R/IdPPJd6Ndt8/bQr8tzABxg1CjJedNCA7iaWI9+gDX5Q8z2R0oe7OA9zDd5kPo1a5ZIHA8gyHD5EGdpaBxbC4eoWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzEyTDBGb0JCaXEwekJldmNUY0M0WWE4YWg5d2NhRlhmd2tRSkdFSzUrYVlD?=
 =?utf-8?B?bDE4RUdWTngwcGErdlozRWZQNmJQeU41dkR5MmgwUHdQVzZhOXlQLzhUTTA3?=
 =?utf-8?B?Q3F6Umw2UFhvY1piZnY4Wjcwa3ZiRHNBVHlHLzBHaG5aSGFWbWY4c2lEM3RR?=
 =?utf-8?B?bmdJVmwxdm9QZE4yOGtvbGp4SG5wTTU5bSs3M0hPdzNYRVNFeGhhZktoak9W?=
 =?utf-8?B?OXFHckswZjJ4ZkxDS3hyWjJSSUhLY05LZ3lRWFpoMEZsRnpKenJYMFN1Smc4?=
 =?utf-8?B?T1laR2tpTWRCdVlPUHlDQ3prL0pqOTkrV3dWYW92TStLdUdhZVNSMHRTdXZB?=
 =?utf-8?B?NEc3dUNITnRLZW9iSDAyUzlOR3V4VFRlMUVpUWZ4MUFER3hJek9zanRnNStV?=
 =?utf-8?B?a2JNTnd2WGVVYkxCRnYvQlBIOXRueHdzZWF6YzI0ZU5YcWcrOUI3VGk5VWtu?=
 =?utf-8?B?NkE1M0ZURjFIcDhkQ0k0VnhMcVJMQlhpUG1ycFhMeUlNNGd1MlF1V1NCRGlK?=
 =?utf-8?B?ZXZrSDhIUTUzTWZSTyt5VzR2ZWRnWEtSeWViVUxEMlRIdkloNjVudTN0WWY0?=
 =?utf-8?B?Umt0QzRFY3VDdmxjTnZGSisxT1FNR3pZa3dLa1BFT09YaUZ3UVZVUFpsZ2Z1?=
 =?utf-8?B?bFZvWTAyUGNBcmN3cTJrTGVZcC8wR0prOSttUEIxWS9pV1pHZ01RclhDZENH?=
 =?utf-8?B?NjZLK2JMMTdIQVo1eWNBWm1abVBCQVhoc21BUlNReE8rNDF1U2ViQjk5L0Ny?=
 =?utf-8?B?Z0phSmpzdWR6RjA4SURuUUpMQWR1UDF6R1pORW94TUNnV1lCelE3RlVGaWVn?=
 =?utf-8?B?ditlV05yRDJyNDJLWFlXc0lvUytMYy9DOGdoUUxhQXowQlp5K29BVGdUTGl5?=
 =?utf-8?B?V3BuZisweFVWeThxc0lrczErRXFFK2NwNE5TVTZJbDRUVTh3azY5U2RIWmpT?=
 =?utf-8?B?ZGM0elJwYmZqbjA4akM2ZlQveWkrb213WTNHOXlHeCtTR2l1TlRkYXViS25o?=
 =?utf-8?B?SjlyakFxSllHSjh4RHBKS1FmWTZOMXpUcWVHMnIxZ2N1K2E0VDR0RjQ4MjZN?=
 =?utf-8?B?Y3YzZVJXWnlITWYycjdGTXlEZ3dPUHBxYnRGTnNMeWdGUDdpbFFXQmJhYkhp?=
 =?utf-8?B?ODBFZnNBeXNlYVd3bUwwbFVxSUQzWWFJQXoxcG91ckpGdjUrRmIrblV2cGR0?=
 =?utf-8?B?OUdlTmpmNGFVUG1VcXVOakhhSFhiSXFMK2pzaWordXR1SVU5emhDVkFBN1I5?=
 =?utf-8?B?bmpyNERmZVZkWHB1N1k0THZqMGFxRy9aNHJCeVJIOW9HZ2VVL1NUMEYwWC9v?=
 =?utf-8?B?REhwakgrOW1NOUdOSmpvRWpHY3VZSjMrU2VNSWtaeXBaSks2T2pWOVdQbWVk?=
 =?utf-8?B?MW5RQ2UxZkVSQWYrajRZNm5SVFE2cGdOVWVEbWZpbDc0SHhuV0tnUzBpUlJ1?=
 =?utf-8?B?cFpkaEF6TkY2ZFlwaHhQeXQzUjJCck5rVWRMZ3pBTWU3MWx3Q2ZLRGlNaFBV?=
 =?utf-8?B?aUZGbU9uMnQ3dDNGZGIyTlQ0Tjl3dHBjbHpsbTY3L3VZMlNwaWhCd2JqRFcz?=
 =?utf-8?B?MU9uK1AzVEtWdmhYTUVHNnFxTGZkOHFXM1RwTnFkVHRaWGdMVWg1SlJrRU0r?=
 =?utf-8?B?M1NHb0p1eFVTS1QxWkV3R1JpYzVoYVJwMWdFL3EyVnJFdEt2bUF2NVExV05E?=
 =?utf-8?B?SENjK293bGRDV0lxUis3dFEzU2d4MitOQzEwc2Y4NXJPU3pLc1UwclhDK0dB?=
 =?utf-8?B?dFdIYW1wRjNYWDRYN3ZLYzFUSk1qTWVPSUFaVThZc0ROdUFnVFpicWVYdEcz?=
 =?utf-8?B?UzFMRXNkWUxWZHZ1RWxxay8rbHZETEJ0emRFQVdXd2g4clZqNlNWWlVhdGQx?=
 =?utf-8?B?b2hFSzRyazFEdFFPV1laOXcrNlduZ1NKWEhmMmRaL2x5VzdFRUFlblBqVDA5?=
 =?utf-8?B?UlRjeUtYcEJVbTdPT3VyK1dSaTBtbVJaMXNLWWxTYVl4VTNsOXYzU2ZiVGUy?=
 =?utf-8?B?L2lFWjZoL2J0azB4akJKYnNkYmxGeUszWmNwUHJsY2IrMFE3cllmL3laWUU4?=
 =?utf-8?B?TEhybnpKK3pVcWpXOHhmMG5qbHk1a3E4RlREeTlVbnZKLzQzNTl1T01hVzJm?=
 =?utf-8?B?Y0VyUlE3V09OTFJFdDFZWmFqY0VkSDAwUHB2VFBGLzJEQUcrMUlXNzBqYUk3?=
 =?utf-8?B?eDFLU3RFMVJxajlrSnhoV2lySWdsNTdJaEdHYXIydCtDaEY3TWtiZytwdFZW?=
 =?utf-8?B?YjhOcGkxYkR2K3BHZk5tSCtodTQyTC9FNmZmdTFsZk04NnJjNFRCVE1zVFNq?=
 =?utf-8?B?OTlDVDhEK1dmN0RXUnZFd3BkOWcvSThEakdBZUtDUnRxaXN0VW1BV3djQ0hF?=
 =?utf-8?Q?nxXu7Fh8HFki+nwUhSqVd5IyKiuUDPB3QH0qImmrz6j+x?=
X-MS-Exchange-AntiSpam-MessageData-1: A1UolcyRdw0o/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29370d1-2e0a-46d3-6790-08df1f841fea
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 06:20:44.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuIzCRN/NQK88ZkEkZzySNmySb44mTdQrmCZeoM7TsqDsVzBr28FsL8Yr33bCuxqjmySklkiFlWp5Ej6jeTqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9775
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

On Wed Sep 30, 2026 at 2:05 PM JST, Yury Norov wrote:
> On Wed, Sep 30, 2026 at 11:42:57AM +0900, Eliot Courtney wrote:
>> Current code in IdPool::with_capacity rounds the capacity up to
>> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
>> smaller than this and still uses an inline representation. Remove this
>> behaviour.
>>=20
>> This allows specifying a real capacity of 0, which was not previously
>> possible. This breaks `grow_request` in this case, so change it to grow
>> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
>> `shrink_request`.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
>>  1 file changed, 32 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
>> index 06a4c71c4c6c..4f329249df9d 100644
>> --- a/rust/kernel/id_pool.rs
>> +++ b/rust/kernel/id_pool.rs
>> @@ -112,13 +112,8 @@ pub fn new() -> Self {
>>      }
>> =20
>>      /// Constructs a new [`IdPool`] with space for a specific number of=
 bits.
>> -    ///
>> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE=
_LEN`].
>> -    ///
>> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>>      #[inline]
>>      pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, =
AllocError> {
>> -        let num_ids =3D usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
>>          let map =3D BitmapVec::new(num_ids, flags)?;
>>          Ok(Self { map })
>>      }
>> @@ -152,6 +147,13 @@ pub fn capacity(&self) -> usize {
>>      /// let resizer =3D alloc_request.realloc(GFP_KERNEL)?;
>>      /// pool.shrink(resizer);
>>      /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
>> +    ///
>> +    /// // A pool at the `MAX_INLINE_LEN` floor cannot shrink further.
>> +    /// assert!(pool.shrink_request().is_none());
>> +    ///
>> +    /// // Neither can a pool with a capacity below `MAX_INLINE_LEN`.
>> +    /// let small =3D IdPool::with_capacity(8, GFP_KERNEL)?;
>> +    /// assert!(small.shrink_request().is_none());
>>      /// # Ok::<(), AllocError>(())
>>      /// ```
>>      #[inline]
>> @@ -198,12 +200,36 @@ pub fn shrink(&mut self, mut resizer: PoolResizer)=
 {
>> =20
>>      /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if po=
ssible.
>>      ///
>> +    /// Grows to at least [`MAX_INLINE_LEN`].
>>      /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`]=
.
>>      ///
>> +    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>>      /// [`MAX_LEN`]: BitmapVec::MAX_LEN
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::{
>> +    ///     alloc::AllocError,
>> +    ///     bitmap::BitmapVec,
>> +    ///     id_pool::IdPool, //
>> +    /// };
>> +    ///
>> +    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
>> +    /// let mut pool =3D IdPool::with_capacity(0, GFP_KERNEL)?;
>
> Allocating a pool with 0-bit capacity is wrong. Please don't put it
> in the examples. I recall I pointed that this object would panic the
> kernel if, for example, you call pool.next_zero_bit(0) immediately
> after this. Sorry, but NAK.
>
> This .with_capacity() should take num_ids: NonZero, after all...

This panic is not specific to the size zero, any size triggers the same
behavior when accessed out of bounds. A size of zero has nothing special
in that respect, so why make an exception and forbid it? We had this
discussion some time ago [1][2], and I'd recommend instead making e.g.
`next_zero_bit` return `None` on out-of-bounds accesses, which is
semantically correct.

[1] https://lore.kernel.org/all/ao2GHqop_Z_9bsyl@google.com/
[2] https://lore.kernel.org/all/ao2U1jNaT7waibJW@google.com/
