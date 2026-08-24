Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0467C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D7510E7B9;
	Mon, 24 Aug 2026 12:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJstSGwb";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8949710E7B9;
 Mon, 24 Aug 2026 12:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0dzIY4jjIIM0pX6UBxPnIzhteLLsvUvr564jMBEyXVog3ojVAMUe/Kh+6Ectp720HP31MsbBXfehgyQNEHDK3LbMihKRKInBIxSINWHIaM/7lZWapJrdkTY3uJZTE1wdUrMvg3IYoZuhyaaj5fODJA94gU9zZzPzEymI5rN3MXTN0HoXXHam+1TOWLnCXciActkMvH7+xuH3lBH3raBZkx1/ZUhKD3gN173+Dp6nf1avoyCJrNUa0aLKEYba7ma3vDS3yq1wYelpN/mPotFeNBEJJzyuWtmFa1Ng/D5gmjwCaMZjZolEU1QROAHPKjOM5KwzesPms1A9szd7SrGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn0O7TirUvvcmwAPb1tfspqguGhKuqT1OFGccybACQ8=;
 b=WYWnPXZ5YEi5hYb7uAV+b7onK8DBrTZD2wboIegD1DK7yDiFUtF5HFRKvjPyd7VTqgso7fjgT7eFoOjTDegqE51U1rn+gbGYJphGdee4idMsGFcQPqv6xMtgTYh35dZ3HW7QHmP51UsR/1OizoFVUrJeeNLKfFIcZ/n8nGJ/IX17nulwB8WR6/c/8tsQsMf0p5hucYpNTYsjYL4hB4tBxxJy4iDeuOeYZwwvcHwjegVm/fbnvEhkIn+YuN3GfxOCtddEvHiutCL/tn0euwecw/fTE1jCUx6O7Q5xye9N4N6168eCAyC+d5HC1GjDf0S2Qy3/Srp9mKanV9+tVCj9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn0O7TirUvvcmwAPb1tfspqguGhKuqT1OFGccybACQ8=;
 b=OJstSGwbU+x/ZW2/2U/wHsUMNYR7PWpdAIRXTHmP1TDvZHZommZd6jW9MM8ETm/pgJxJPz3S81rIbfVMhZSrXoqY3zvpT2pZcV7VbfAro8Tn9lzSQlMkLmjoMN0ceKWQNmLURlduKj8B8KraT+4+iXiW8uhinkTqio8Tx6OAATW19ZsJvWXx2cHWogd2UEEBrYn4bBkZrM0oKekuNWVGhXALS6Ys/mHwmZCia4Y05azPREWzRifwv6jPb9mrg2CBVhOFJ5THBeqld2+soarkm+mao43zRxGZOB4bOKkQxAE/7jDLDxMDT1QvwMl2FEpdR/uVgSicloH39dBZUdpQng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.11; Mon, 24 Aug 2026 12:58:41 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:58:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 21:58:35 +0900
Message-Id: <DKX6X2D5IG2J.13NU7YFATONH4@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/6] gpu: nova-core: add NVKV encoder
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-2-b84db5e84b67@nvidia.com>
 <DKT2C9FT6IBW.3L5PJN1J8IVLD@kernel.org>
 <DKT2NSDRJXYX.1S0H8K3Z75QVK@kernel.org>
In-Reply-To: <DKT2NSDRJXYX.1S0H8K3Z75QVK@kernel.org>
X-ClientProxiedBy: DU7P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::29) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: da924a15-8c69-4b53-ce8e-08df01df6bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|23010399003|1800799024|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 5fp/NvWB8rRRQ7LJgZ4gY4sg1Tka/oegGPNLba+t7OAX3cWKuD9MBiYnyJSfZ6J53042PY+I0GEMpTGqc0dBLL4WENB5sDtAZdpUbneYGKsb8KM/kJQQxXam0nWbW/ETEKiuYI1G8C/CJQBTMjhc5o8uTpFYbd9NdFmx7dHmA1s9y4ABDRkY1px3waQIKcM2L/zpiA2dY2NFIOLoN3QMuz6SMaJ3JY8ovDOy9Y+/4vfjlz+IGTQbBfVl1ED4k5QjZTalorr3k9K5AUAHCYBHaxSDOYfv0reD73xV2Q7MFd/3poQvlRvN2Dt7CufU5dJUnSeIQ4A0WvAZ/yOX7l4unELMjMd34s4P+Dglmd4iKdmJvxzZE7ogmi8CosXOF8EqaTxXSVKxw5goTZEl1+uvhp6J/gVxFZQT73eCexT5TgxtUgz8fyuAoi9KvKqGI72WJEQbT7YleHuiMLdkMAO+V/EhoPT2qUNmwWuj2UY4VpOvCdzQerMd1xsg1gcaQu2wk/n+1/jVZsKdwptbilAGDOj97x9SPAwOuwx31VWDponIQATxeomSpKkugcxDXPA6WIOssRjM3++hptMzGUzd6YkguY8Qd8rod8aKxzaUn43NGWjw0+yzTeLlXOSCXxxFTPxx04ke2bRowfEnj9ZZ2Rcz2brfhmOW9yyabuxQUfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGw5RzUvZGloZ1pTYU4zSm9ISm9JOTZ6Tml2dTdWL1pGU05kV3lRQi9lWEFF?=
 =?utf-8?B?K0hjN0tUZ0pHZEluR204bDFRYk0rSHM5T3Rad2RMbTZxRzJ2aXppb1NxUnlB?=
 =?utf-8?B?RkZOZHJ5S0JrUkdxNzUyeXpkcnNlSUxqSG1Ia1NSU1Q5ZWRxamk4ZjdGa3E2?=
 =?utf-8?B?UnRSMGR3YTJ0dUpGRUNMazQ3SWhrVy9GUHBWdHBKS21mdDBQMG9RS3FtNjA0?=
 =?utf-8?B?bWtHd29SdWtFOGI1eC95QldPUjBZTFZQTzVwUjJuS2JxSUZGRjZ2d21BKzNx?=
 =?utf-8?B?QnRNMHpXVWtPWHloL1FvQXJzOHZPYXdnaXh1S1Z1aU55SmkxeHBZQ0Ewa1I0?=
 =?utf-8?B?bnpycGhoWjhtUUVSSStXWFl5Q21HNmxXVllaYlVSMkk1Z0tlYVo5QVp3ajNT?=
 =?utf-8?B?blN4c2JQcTZaalkweExJWnFZck5iS2IxMGhQN284TmN6LysxOFk1ZkNhYVFP?=
 =?utf-8?B?bVpleDRhTGRTOTRFZ3EwcWRaWEh5UEpRQnY0SG1qY3RpVTM0VExJNjhyVUlV?=
 =?utf-8?B?TEs3R2taTDFxOFQ1eVRSVWpLWllpcnZoSzZMS0VlNW9paEZNMEhHSGh0ZHRO?=
 =?utf-8?B?ZDNzUkI2c0s0R0FHbVdIRGVPR2J4Sm1wbjdOLzVEZ3psdkdxeE1Md21yUWtH?=
 =?utf-8?B?US9aTlVCRUdDbVZCaGtoNFNvb3IrRi9YSHlYRTJKN2hpb3ZORUgwbzBXZmlK?=
 =?utf-8?B?Qmlodkt5cVVDTUE0MklRdEoxTG0xZERkcFFTM283TDUzSTcwbzU4OHJrdDhr?=
 =?utf-8?B?U3R6SDdmUDhXaWtYbU00V29FRnBQTWdzcWZIRHQzelRtOFhmWDFGaU92VGkz?=
 =?utf-8?B?Ykx1azR0YlpWZzdFM2l5OWNlTzcraUJRTElzd0NEQ1RBNWJMZkEyMTVSbTl5?=
 =?utf-8?B?OXFYQ2lLVkdwQWNzMXJadDZ2UDgzQ2c2MFYxN1dESGIvcnNmR3pQZzhWVlg5?=
 =?utf-8?B?N2JXWk1EUi9sQ0RIL3BseGVhSEg3TjU4NVdjR3FZc3B2NWp0NUpjTDlPRWFr?=
 =?utf-8?B?bE5ObVFSZFZMV2xVT3BqWUh3MmJMdnN4UndlYUVLcUJ6WHFkRmkxOENPdGlX?=
 =?utf-8?B?aDNJZVVVR0dWTU9ZT3lEU1BLaWhTRTVwanJCR3hRMCt5ZGhQb2M1YTZEbzF4?=
 =?utf-8?B?WHB3UldMSW1KTUw3ZkZJUnVvaXFUUitnaXE5WWtaS3NiUlM2L2JBQStHT0Vn?=
 =?utf-8?B?RExrcTRFQllTQUpoOEdPdU9uOWtXS1JLemR3NnNDYURPYlhzd0ZiZkxMNjd6?=
 =?utf-8?B?bklJUGV1eTJSaGpWWGFYZ0RLdTlhNk5OZTkwazdQT1paUXBEa1ovd1NvcWNT?=
 =?utf-8?B?OW9zd3ZLNnM0aVlqZFBkd0hzQ1c0aHI3endQMXJVVzI5QmNQN2pDa3NzcHlB?=
 =?utf-8?B?Y3orNmVGY1hsamFWMWVBWUswNU9TQUFFOXZGQ2MvQ0dWTnJBL1BITWF5Uitt?=
 =?utf-8?B?bXBGTlkvT2xLZ1FqOUo1Yk9GYjJKOGQzeXFLZ1M5VkFRaUZ5aUZVTDlTTVNq?=
 =?utf-8?B?M2lsUktEdjh4YVl1cTZLZjVkOVQrcVRWSVhRRThCaWZYMCtuRnlNdktyWlJW?=
 =?utf-8?B?VVFhQ3lNbi9aekMyRjNvRzN2NjBPekxIZmxmbXh0OXRzY3g1c2ptd3hkVzZi?=
 =?utf-8?B?QzlsMzNnbTYzY3dNajFWN0lUaFNrY3lGTHN3N05tbDJTejZCMndqTy9ZWE9H?=
 =?utf-8?B?Z2cwblJaRUtpUXhIWEdSbWJtQjJQRHhKL1ZDV3o5MnR0TGFJMnM4eHd3Y1lQ?=
 =?utf-8?B?d0FXQk02ak9zV3RTSHZCMndvUTZGQkZlU3JwNG1xWWZySWJLMUxNTmJRem5C?=
 =?utf-8?B?cUhoeXV2WCtmRVR3c2lLUnFpM1Q5QlFFTlZrN2RRWHFlVVBxdk5JeTR4Y0VM?=
 =?utf-8?B?R2QyVndka3BPV2RmSUxoV1R0OUo2b3kxQ2JZT0Q5SU5yWWJwdUQxNVBQL2ll?=
 =?utf-8?B?TDRMekR5R012ZDNhcUxZZFNQZXlVOXY1RzdFZVJvZTlIWHZ4Q3VmbVBleDA5?=
 =?utf-8?B?K3BLRnlpeW40Y3RLV0c2QUtKMm1NQnpVb3d1RUE3NjZZcDJ0U2VxdFZzQmJr?=
 =?utf-8?B?cG5nMjJuSkVObFg1WlVlTno2QnBvQ2hVdDA3aGt5OTB4ekFTVmV6eXlxbHB2?=
 =?utf-8?B?eUJVM0VzMDI1SEdhdUxsR2c4VkViWjVlMmViUGJuQUl6MzAwdU5oSW9tUGFQ?=
 =?utf-8?B?NmI1V01KQldKNHpJcGRVNTNZblJvaFJ0cUk5OUdaazRuVVdaZkNkbSt3OUk5?=
 =?utf-8?B?ODFBZi9mMkZhSWVwdllxdEZFQUZWbG5Sdm9tbVlmVVBoRFVIa3YrZWdtMWVy?=
 =?utf-8?B?K21WYWNKTWVHSmc2SkFUR1U4ZW83ZEJxWk9MWTJ3UHdkOVpteDgzK1RWN29T?=
 =?utf-8?Q?qChv0vRpe1UBklA+ybpURcQqnEUkheGBQ1jm7iAr8jz+V?=
X-MS-Exchange-AntiSpam-MessageData-1: DRY338GiqGO8Dw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da924a15-8c69-4b53-ce8e-08df01df6bc6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:58:40.9206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xy0blcwe+bltnKW+1J0ZIXMhFQqHfk+nocd2e/Qft/JtV7artkngHOGIQA2fz/JKdypm0ogFfeEGN4fWAIqqcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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

On Thu Aug 20, 2026 at 1:47 AM JST, Danilo Krummrich wrote:
> On Wed Aug 19, 2026 at 6:32 PM CEST, Danilo Krummrich wrote:
>> On Mon Aug 17, 2026 at 2:56 PM CEST, Eliot Courtney wrote:
>>> +    fn push_bytes_with_padding(&mut self, bytes: &[u8]) -> Result {
>>> +        let num_entries =3D bytes.len().div_ceil(size_of::<u64>());
>>> +        self.backing.reserve(num_entries, GFP_KERNEL)?;
>>> +
>>> +        let spare =3D self.backing.spare_capacity_mut();
>>> +        let dst =3D spare.as_mut_ptr().cast::<u8>();
>>> +
>>> +        // SAFETY: At least `bytes.len()` bytes of space are guarantee=
d since `num_entries`
>>> +        // worth of space was just reserved.
>>> +        unsafe { core::ptr::copy_nonoverlapping(bytes.as_ptr(), dst, b=
ytes.len()) };
>>> +
>>> +        let padding =3D num_entries * size_of::<u64>() - bytes.len();
>>> +        if padding > 0 {
>>> +            // SAFETY: At least `num_entries * size_of::<u64>()` bytes=
 of space are guaranteed.
>>> +            unsafe { core::ptr::write_bytes(dst.add(bytes.len()), 0, p=
adding) };
>>> +        }
>>> +
>>> +        // SAFETY: These bytes were just initialized and every bit pat=
tern is valid for `u64`.
>>> +        unsafe { self.backing.inc_len(num_entries) };
>>> +
>>> +        Ok(())
>>> +    }
>>
>> Ick! That's a lot of unsafe code. I think we can avoid this by using KVV=
ec<u8>
>> instead of KVVec<u64>, ideally in a new type that upholds the padding in=
variant.
>>
>> Here's a diff of what I came up with; note that it also gets us rid of t=
he
>> unsafe in take_u32s() in the decoder by using zerocopy.
>>
>> (Technically it would also be possible to make Cursor operate on a byte =
stream
>> and let zerocopy to the rest, as all the take methods are fallible alrea=
dy. But
>> I think the invariant on EncodedStream makes sense.)
>
> Actually, I forgot to add the optimization you made back in, here's the p=
roper
> diff:
>
> (Also used T: IntoBytes as argument for extend_with_padding().)

I think the `EncodedStream` newtype enforcing the padding stuff is a
good idea. IMO it's simpler if we keep that type private to encode.rs
though. Currently I suppose you didn't because we need some way of
owning the KVVec<u8> that can safely+nicely transform it to &[u64].

I was thinking what if we added a conversion on Vec based on
FromBytes/IntoBytes, mirroring cast/try_cast for io projections. Then we
could just cast to KVVec<u64> and return that. But one thing I'm not
sure about is the layout guarantee here though, w.r.t. casting a Vec
then freeing it as a different thing (ofc for things that have no custom
drop impl). I saw that the wording is "`self.layout` matches
the `ArrayLayout` of the preceding allocation.". The strictest
interpretation of this is that you can't change the alignment (even
increasing it by multiplying it) or length (capacity). I assume that's
what "match" means, which would prevent any implementation of `try_cast`
here, although AFAICT the current allocator implementations don't
necessarily preclude it.

So, if the above can't be done I will use your EncodedStream diff.

thanks~
