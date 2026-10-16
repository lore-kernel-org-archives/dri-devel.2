Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C9ECCA46B
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 02:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C54D112571;
	Fri, 16 Oct 2026 02:06:21 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E883112580
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkKlQz+wpp7A/tgmQectvo+LA36GJtpa9yMVinTavi+Ottf2FIb2tcVl3UcvDOF/ps5GWXaVvawFiIcSQTkRvvJeWMyIJY5JZZqG64zDLb9Ymx6oHNhi+y3EZNosPxLg+6HlIXZAU0b9el7iTOqWAfiU84HljgE1xO6L2mwmrKzP7Cdxvr4t5DSf+Ua+AGdKICgqfFxNh3XZGvtPvWf/8bfIbqHSZHNrSzQHVqff14+Kk1s8vNAM1MY2pLZHSKPQbNfy03Q3ft9cYWBdplWqYEgjfZ+3238YsbdUSVS+f3KEu+uBZLBw9J48iebR40SFjgEeGPz7GwnHOnn4HVtCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmsNO/jJfPSqxqsQ+ME1UOg8B812GKnkY7Zywp66qy0=;
 b=mCFK84rEcDUFt5YzoO+hi/gAZpW1PDR8kOs18g69Duk1666w6DiG3SKUASGbgHONkSo3FywLh5I7ofVBJv36ZVvSzhdTPv+RtYHIufXWVTF+vKk5suCm6Cec8kU/CqEEMYos22qvy5AL80MmhtDfRsslCjo+zaNhU3vEnwwprTWYSYS4D+D8PAo6e4q/9XUKbrchAbaIhH9ndELlrpQ6YGEgIkhS3akiC3KgGYnz4/nI0cmdH+3jzzu3CD+OJ4P2tEu+libqDkcJvCleI9s+UT4GLyMN5B9GSbOdZMh8af0dCK8VzJPd5lbb5AMoJ5QpnakrteJnC0RP8M5VUIelyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmsNO/jJfPSqxqsQ+ME1UOg8B812GKnkY7Zywp66qy0=;
 b=gmroptr1yR35bi7/5BmUu+xLFm5mRE1hCSg4F2j+vreueKRTBDFz7gzAfPpg9BA5IVbDdYxpPCs1PcCmgJUdeGBI2iLV6Lyoc/yhst+nJnPr6mE5oeNZ9ESXsKhFu2tloViU+7LLsQt65IS/b8K1iJ+jAYaRalIk6sA/8KA1gvIrGTgAbYNShgU+bFwXobLn/P5Moj2O5ZdOG6VVQXNKl5n9g5ucBTDn3aGMULAv481jCSK0C6EMVLrhIoeagpkYh38imjy1s8UxeT2yj/CEXIJ7RpLkshGtOOKOBf9JmG1Rcjjrkb21rUPm2wOhpcIg92ziR5uyEdTKY2YIrQNUTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.20; Fri, 16 Oct 2026 02:06:05 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0496.017; Fri, 16 Oct 2026
 02:06:01 +0000
Message-ID: <db71fe6b-bc96-4d02-a139-2bef73f568a2@nvidia.com>
Date: Thu, 15 Oct 2026 19:05:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] gpu: nova-core: add NVKV decoder
To: sashiko-reviews@lists.linux.dev, Eliot Courtney <ecourtney@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
 <20261016-b4-nvkv-v4-4-e8b92b91aa5b@nvidia.com>
 <sashiko-outbox-173606@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <sashiko-outbox-173606@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:510:f::29) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 250b09bd-f6f4-4fc4-34f6-08df2b2a06ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|921020|6133799003|22082099003|18002099003|3023799007|261009223027099003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 1y6YB/UkcqKIgtnNzqP3OWOkIy92D4SdGDujc1t023kaOLlWtSnygvfVrghbh9Wv+jX9BSKZLIYQ6S9q3KAAk1QRk7tQR059/NyflLsvmBQuAf9CEjH40kiIyeAxwVMXnAihHcmK14UC+TbWtnQQBfCOGnYtSJng4BdReN8EQ/Py9vCx6kfF/9/secnCVbOQRc09u4E/L9vwBe7YxuKW+qoWhUrjTQjN+CCLPYYrOiyCg+XGoXM18bX1Im0ttP0POAZ6x7L1HcY0B3Dn7575EH1tFgpTxZjqJEU2DPZlreiYKhjVJwCoiNSquaW4DUGvriTIpWRY1hPaHGmRGRKh6n6TLhI2QvgZm80GZsjDKE9QM1e5vhBn59o5rM7bP0wcvtHolK7mQhQDuVYlEsYQZZ0zFgFmKNnj3WSOkfZHOKtyNtKCW54XKkL00VqseYAStLZxSw8m1/SK87D8JbUltIRKG6yJG/yMWub1pTiLm0W3uk9KQ/20awOc+kVyUC879nYE3AZXBQjLqEzgSrGXJVW2U5MwcGe+WvjD/JgKnIz8tgErsq41qqyzPy2z+kQwal2+zxAMIq6Jp6TS2CIX++Ot/r9HWhdBvXwTWNzV7WhVwWW+qAHRqVdh9bbF8BDykRqbXw0R19uW04m//63SyPBwpoohKxPIQL6dwIFSvMD3C57O46h+aa08XydjPytOqHNIGD+doOoimHjJ9fDKAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(921020)(6133799003)(22082099003)(18002099003)(3023799007)(261009223027099003)(10067099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjNMTzRBbjZpQlJTYmlCa3ZIenArdFBlNDBtRnQwbGlTNThCZHFNc0hCclhB?=
 =?utf-8?B?TTUxeFl1Mm1yVmJpclJQYUhFV29GNDdBdEhudDR3TVd0SUU4UkpwS2hoY1pW?=
 =?utf-8?B?R3A5b0dpcmZwNWoyckRvQzBqTW0zSHpRdkVsMGFZeHhLVHdha3BLbWxiZ1N3?=
 =?utf-8?B?Rkl1RmdUWkFTSmh4L1NQQTR5NVpPMk9PMGNoVXEzemxBSldNUlp1NUd2amtt?=
 =?utf-8?B?dW8xOG9zNnRUeFIwYW1EMXBBQXRidXVEcVBlVVQzbWplNlpCZ3VEbFl4d01q?=
 =?utf-8?B?b1dpc0h6SWE3K3VoZWtpL2lDME5XZHg2SlJuY2RnOG9CN1BjN09MRDBPWEZW?=
 =?utf-8?B?bWJrWmNzOUh5dDV3SXNVUm5GWkNtUENTWDVYb0h1Wm5PaWFabTlTZEtua0Zr?=
 =?utf-8?B?OTNnclZPNGxiYkwxWWJ6RSszYTN0NzJsM3NwK2pTRGd0ZjdPdkc3WWZaajhC?=
 =?utf-8?B?ZnRTb0RWdFdLU2ZGUmxyQnVKdyszNE9RdC9vU0l2Nm5TWm9tSHRCYVFuVlFq?=
 =?utf-8?B?VzZYTGx1UTl0cmFhTjNBVk02dVVoRW9GbFNJZmNzZ1BjRGp1ZE8vNDhNZjhP?=
 =?utf-8?B?MXR5ck0wYjlaaVAwaEIxd0FNWlJLWHorUkFoclNmR2NuZ1VqUXZzNlM4Ulgx?=
 =?utf-8?B?YzVZYUd1M3ZFaUQwblI3RC9kL0JCaFFySndBRjNDbzFsUFpWbktPNFRmdEdP?=
 =?utf-8?B?L1MvNnFrYSswTmxZVGxwMkxuQTRTMjZ3R29mL3YvNzFvcGhnRWtUcXRud2Rw?=
 =?utf-8?B?SFozTHJ4NkIzV3lXQko2dEJuV28rQ0ZJVnZHUkJiVk85VFd3YjByUERQeFdU?=
 =?utf-8?B?RDdXRGR1QTlkMUVtZ21YU29OUlZqM05lQUlRMi9VSktHUDkwY2hRY0NDOXBO?=
 =?utf-8?B?SENESFpxMFpWWUZFbVgrQUFkZkUyMVF2NDMyRi8zeG85c3R2WWdvaG5VcjE5?=
 =?utf-8?B?MkpUcGZHM3BNV3ZLeGQ3QitCUTQybEU2UU1UbUNWK0pBaCtReUJrbi93Nnlu?=
 =?utf-8?B?bDZjNUpqT2pDdVBDbzVSUklyRW5CaFd0bXF6bEtFV1Z3OXg5ejhCMVVraCtY?=
 =?utf-8?B?QnJ5Y1B6V0ZSYlorMGwyQXU2L2FJaVk3UmJmTUhNY1ZnNUYrYWhnTUpnWEsw?=
 =?utf-8?B?ZjB3ZGhla2ZBSncxV0paSkh1azFZYmZLUmF4MEV1a0xtZEl6d2htWWY5alkz?=
 =?utf-8?B?OWRhcHlCMU4xSVRFNUlxZVJSeFUyZ3V2M2M3dFRvT0VDU2NoWkNEQjZNVmhr?=
 =?utf-8?B?dlFmVGxyemhmTkR4R1BIZzZrcEhWNEdHK1B3TkdIYUpBUFY5TnphNk0zcFJz?=
 =?utf-8?B?dnYyOTQzUXhJQWtrcW4yMTF5ajFobDJSWkNEVXU5b0k5ZVJNUEZRM2NDY0Zm?=
 =?utf-8?B?dzdwbFVGYnVQZkhJUTFCbUdhRml6Yi81RzNhN25DYmpOSlhhNUZWWlFYVGZt?=
 =?utf-8?B?K0l5WkMzcnUrOFZncllvTm1Oc1c4NDZLT2FIMkJUUGkwT1RaVitsTnJoRHh5?=
 =?utf-8?B?Q2U4RS9IK3cwb3luNDJ5bGJZL1Vvb1YrdkdrckhmQzNWWlZSajREaFZjckZT?=
 =?utf-8?B?OWVXTUEyNmV2T1BsajJkSjFrV215a2VrZW5rWGZFbWkwNnhuQUhzTE4ycVQy?=
 =?utf-8?B?UjhoMDBkSFY5QVBSWld0bDlwVWQrQ1VnbDVsa2I1dVRmZDl3aDBsTkdIZ2xy?=
 =?utf-8?B?UnBxRDJoaFVJSlUrdjF3SHF2VXhvMTJqQlBSL3hmSUFaR2pYdmNGZ2ZvK0Zi?=
 =?utf-8?B?YU9tRml1amQzbmcwWE9rTlFPUmFTS3p1M1RzUzY5UXZpbWFSdWNXa1FUdXBu?=
 =?utf-8?B?VWJuRStNZExTbXRyb3BYT0dOdkE0VXNSQ3NxUS9RL1VSTVA2dXVkb0c1WWtH?=
 =?utf-8?B?SnorZ2ord2xaOU9VYUgwSno3cVJkREJHTWliK1ZLVDJvbHlnNlVhOXk1QXhl?=
 =?utf-8?B?Ry9JQ3c5NjA0RTVpRlgyNnkxYVEydUtVZ1hjU2w5YlNYNzh4ZlA0bWNRQVNa?=
 =?utf-8?B?ZmI0VElHVjlWckIvd1hBTXdLOXgzQWY4c1pmS0FucFAzZmIybzh3OWtXSXEy?=
 =?utf-8?B?aW5Zd0hQR3E1V1BHbXE5d09keTVFUFhaUzFuUWlpdFN3ZXFSd2granNIcDU3?=
 =?utf-8?B?aG1jVkdrV1NqRDk0cXNsYmZFTWZHVzUzT1REbXdJcXppMGFTNEFnVHVaSytl?=
 =?utf-8?B?UytDOHQ0c1ZuVDhQZ2hRQ09iNVVxSjJURTB2aGV4NVFJNnlWbkVxalR3S2M4?=
 =?utf-8?B?MzcyUzVhK1NrcFNkd2JJRjlOd0R3dWZhMStGWEhMUWlGVjY0TnVsTURrbE10?=
 =?utf-8?B?aU5mSHkwaDhwaitWdGZYcmpxekl3Q1o1MlhESjRNRkxGeVZhZndlQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250b09bd-f6f4-4fc4-34f6-08df2b2a06ee
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 02:06:01.7181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWkv9aw1rFIldm+H9RtnMKh8dbYd9pqCsLA/qkXkUT/0xGl+otQkxIS99v9xT9PL7pEdNLUhhaxvyUB3c5Cuag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
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

On 10/15/26 7:00 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] gpu: nova-core: endianness bug when extracting u8/u32 arrays from native &[u64] stream
...
>> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
> [ ... ]
>> +    /// Takes `count` bytes. If `count` is not a multiple of 8 (`u64` size), bytes are discarded up
>> +    /// to the next multiple.
>> +    fn take_u8s(&mut self, count: usize) -> Result<&'a [u8]> {
>> +        let values = self.take_u64s(count.div_ceil(size_of::<u64>()))?;
>> +        values.as_bytes().get(..count).ok_or(EINVAL)
>> +    }
> 
> [Severity: High]
> Does casting a native u64 slice to bytes extract the wrong payload on
> big-endian architectures?

Roman, or anyone who knows,

How do we update sashiko to make it stop reporting on this issue, which
we have decided is a non-issue (Nova is actually configured to only ever
be little-endian)?


thanks,
John Hubbard

> 
> Because Cursor::take_u64s() reads host-native 64-bit integers, using
> .as_bytes() reverses the byte layout on big-endian hosts compared to
> little-endian.
> 
> For example, if a 3-byte payload is stored inside a 64-bit word, a big-endian
> host will have the payload at the end of the word and zero-padding at the
> beginning, causing .get(..count) to extract the zeros instead of the actual
> data payload.
> 
>> +
>> +    /// Takes `count` 32-bit values. If `count` is not a multiple of 2 (`u32` values per `u64`),
>> +    /// bytes are discarded up to the next multiple.
>> +    fn take_u32s(&mut self, count: usize) -> Result<&'a [u32]> {
>> +        let values = self.take_u64s(count.div_ceil(size_of::<u64>() / size_of::<u32>()))?;
>> +        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)
>> +            .map(|(elems, _)| elems)
>> +            .map_err(|_| EINVAL)
>> +    }
> 
> [Severity: High]
> Can this result in swapped 32-bit words on big-endian systems?
> 
> Similar to the byte array extraction above, passing the native memory
> representation through .as_bytes() to recreate a [u32] slice will swap
> the order of the 32-bit halves on big-endian architectures compared to
> little-endian ones.
> 
> [ ... ]
>> +    /// Decodes every pair into `schema` and returns the result of [`Schema::finish`].
>> +    pub(crate) fn decode<'s, S: Schema + Visit<'a>>(
>> +        &self,
>> +        schema: &'s mut S,
>> +    ) -> Result<impl Init<S::Target, Error> + 's> {
>> +        let mut cursor = Cursor::new(self.data);
>> +        while !cursor.is_empty() {
>> +            let op: Op = cursor.take_u64()?.into();
> 
> [Severity: High]
> Does this misalign the operation bitfields on big-endian hosts?
> 
> The 64-bit operation word is read as a host-native integer via take_u64().
> If the NVKV stream comes from a little-endian GSP, parsing it directly as a
> native u64 on a big-endian host will misalign the key, index, and value
> fields inside Op.
> 
> Should this explicitly handle endianness (e.g., using little-endian read
> functions) instead of relying on native host integers?
> 


