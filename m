Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7470C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA7310EDF4;
	Mon, 14 Sep 2026 12:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PMSfWKUJ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4CF10ED65;
 Mon, 14 Sep 2026 12:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJfXlKoT8vKWj8S32XcDsq0IdqYOkiRahdiTDvV+1EP6CoUKZBBqgG8S6K3DqlnQPux399uRjFCtVrh8U1YRGDYmcVhdAgMPKivc/vN6wnWoTeBWIppAf1dP5KsvjJoBR5lHw/0j7Ru7lDNXlyVHNt+PVp8G3DlMRzp3V8MCteYGk9QxWkeKWD/W5WItFtFxDSUC3vS9VvHgSTjRvnYniqzTwuWfOZoPJO/jOQY+ajBGycPifoPk46J2Rdlvf6kgbmebtggg00huEYsS/MGopnJOhaqXceQ3kfoHiy7wGyllQj7kMJVQ5RgE/jgjkLyDvqmnfxb9PcnpjcpdJjycwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o+ins6jjLbvMDovzxScC0t5qw8SlbW162+Osq22DRY=;
 b=lRw4YV3LUOgkPEJ1GI9I6MnOgD0TcN9ti3O2w1/qQQhrPIgRquJMWn6E/QgplweYtvyX93OT7ZH0ue8SEEngRW+XFaIa4HPJCtrzj6ksnhVEuM8hSKG0Mpqkfq2Db8d40+ClpRYtWbU8Xuj0zixgBbUMiwBKRP67SCixe3ErFIiV40MEbz9avahuC2gGYWIR1fDWJuu6II5sGcKQz26mChTaCpsuHCdLee2pPXeBpABKq+UfQ0Ae4baH/h9qUZFLxuCt1XinqT233mvcm/rEPLFiGzz1pS2mEpNMhgYqYQDXHoxg3kINFj3mzoerI+qT412fGSG5YsATf2CkytOKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o+ins6jjLbvMDovzxScC0t5qw8SlbW162+Osq22DRY=;
 b=PMSfWKUJAuwh8HECfdiBeF9SGyHiUY4XI6fGbCnLKu8v0QVTgfV4b8t+yO4H6roLbD+rs/cS5BGL5+uwRpbbCQbkngzAbQeGYk6f7gr6xhLz4JXdvQecnsAOZhnuT35y9xRdgesQIe0ElR6QAD0cATgH7C+5hjVl4P7JlaBdfAPpQjeiZ/lSpsA1yUvWJZ+wDN3jekPk9glnYQEh4wqJDZQ4oCyqmut8ufVYZEW5kQ1apzjJL4sq5xCZpy1qpc3TYpMteCVjxfQpeHnje2v3nSYDYh5oN0Fj5CK3dkc6oT7gp+vZJXlXNsMvgBgZbY8VzgpUT2PnUN64GXh8T7jmrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 12:06:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:06:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 21:06:35 +0900
Message-Id: <DLF0YP85CHDT.3244P899RJ1ME@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
 <61f1f28f-d76d-4231-b99e-4dd4a18b4fbb@nvidia.com>
 <DLEUSN5KTTFU.1OWYCOS7KC3NJ@nvidia.com>
In-Reply-To: <DLEUSN5KTTFU.1OWYCOS7KC3NJ@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d3b5ff-6e26-4ae5-5d71-08df1258a35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10063799003|22082099003|18002099003|3023799007|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: oTvlWNHBjmVG5t4ievsdh81ki2RwVkJufQBuVLLqaVv+wDr3EWLRUsVYmcRfLE7Ouylpeh137hf6As9zl/P8rRQHMHaUCCp41BGngkYv3kwr0o3jt87nhl7YM+s6kHsA8gbSm7XAwwD3fIwnbpacZbMdZM890UWGpNpBnppSSFC0H/rEAIek+92dTMqkdHa2ak5VY59kzLfcG6PmpiX7IM21C38jH4+sFd3BuTjd6oD9jXv+lBycSi+minQjfztaFzfzUW9qOWiSb2AQRbn72PGqEv0G2LXX1t+5FGHr5T45dPUggTnD5s2WthKVymKETU78R7k9NgrMC/t/uCKEfaNm50W/8boA2ruQDMC6HLXtJ+cTppZ3j1vQg0571aGtFgi9HP8qkH+TugLvUvk3x+8P564gCGNP7+tI6gzUZa2qjIyq0euCDpqTmvsRJVEqmA+XjpAUrh2ZVW1QI+tZ7vMtMcZkjG99EatqeEzcCIW8bcAt4e5kPEC0G731gI1KW6SAHmOT8xX7h1AMdAewWWIxHj5qvcGgYyEJYRYCCPNi99f19ahpfGkCQVbm8uBL92EoZeit1XkaQj1Rfn5EYZf1DcxemVeTTYT3GZVkpELUSPKQIK4kWdrlYAi9sp5jbwH/kqbSiw86HlDH+yDNpnqCPptHhO+tZ1idg/pWDeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10063799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bndYQkltVDVlS0JNMUtqR0I1RElPMFdlTUt5MzR0WTZxVUFWKzZ1eEhPdHVH?=
 =?utf-8?B?T3NQWWxjNC9ReXRnMkpYRVBsUU1rYVJtcld1SGJaNnJhcjgzZUd5SE0zd1lE?=
 =?utf-8?B?TC9jeVFMVTVHNERRbHZhcXNYZmdPYysrcUlvZTlZK0E4Si9SVWg5RWtsQjB2?=
 =?utf-8?B?VkNxY2lITmpkL1Z2TVpoOWFPT1RFZUQ0eEZPU1FEZUYybllTOXBVTWEvRW41?=
 =?utf-8?B?Mk53Qnlmb1c5T1J1WHYrdHJxcWZkaFgzWWpOUlg1VXNRNVl3YlJoTFEycHRs?=
 =?utf-8?B?SnN1Y3NhTjdSVnFZUEIwRFg4YkRpY0FRSUR6U3lQNW1ZOXVuRUp5ZCtJRGkw?=
 =?utf-8?B?UXh0Z2tscU1TNHdmTHR2MHdyQ2dMNE82Ky9LNVF1ZU1FMVBKMzh1aWJBRFVK?=
 =?utf-8?B?RWhXQjRlWm5VSE5qak1WSytoa25Tbm0vY2h0cERST2NoYlJlUjJiVUFIbXBH?=
 =?utf-8?B?TkpCamo0SkNWRUZmVXpEVVEvWldueHVYckpvRUNud2doVEFsaWd4UFVDTHAr?=
 =?utf-8?B?M2REZTBndFdIQ1NleTJhcXJtdHp5Q01sdUJTdmpybm9SRThNZ2Q2am1OUlNN?=
 =?utf-8?B?ZThhQXpTSUgvRUNvVzNtQUc5L2RUZytoUnZKYi8vRk96SnFvKzdDNmZucEpY?=
 =?utf-8?B?YkhIQ1oxVDkrelZxbHR4R29FakVVRUpSSE1BQmZzUWpYVkJJakczeEcvcEk0?=
 =?utf-8?B?ZU1TaCtwTkhucXBzbW41R2IwaWNpbk00eUFkOGFjRUtHQS90a1NZa09DU1lu?=
 =?utf-8?B?NGNyQXUzeWcxVjR0NkVQS1ZLblRIRFlUMy8vdEtaWW1uUlhZQmpKUXFLWjlu?=
 =?utf-8?B?dzBXS3hLUURPYlF0NWxZUW9haVJJY01zZGpaUnJmb3RNYVNQcVdHOEZwNy9J?=
 =?utf-8?B?NHV2RHVGSlZ6Nk5Ha1pHWS84MHNXb3dNcTZmZ29aZDJSWkZiVkw5SVkvYk9P?=
 =?utf-8?B?ZUExWkpYekNDNFhyYlFOV0wvK3hlN1UrVG03dFNvcGFVNko2TGYwTzFJOHVi?=
 =?utf-8?B?YmJDOXZWelZIL2s2a0tyVHVIMXhMeEdTeXd4bDY4MENqYzYzRDhpdVM3L0x2?=
 =?utf-8?B?QjFZRWxnK1FDemE0ZE5mWXNPczRpZnppb1pBWnQ4azlUOFc2NEIycWRWWVM1?=
 =?utf-8?B?STJmU0F0clYxYTlPWjgwcVNCczhPa0V3Q203RmFvUStBdHIvVDA3UEYyU1Jz?=
 =?utf-8?B?RlFFcHYwYXhFUVdPazFZUmpUMzBCU3NWL2N2b1FieGdpRWNoQmV3VXVCcThW?=
 =?utf-8?B?UFNFWkFQQzhseEd2dU01amVnNnM2NWNISWV1UGlRNlpyOVI3L1hDejhMT3No?=
 =?utf-8?B?bzEyaGt3RVNtUFAyd2QxRGM1ckx0UWpFV21CVm5pL1lGSDdQT09GUGJBMzc2?=
 =?utf-8?B?RTlRZ0xyeE5iODJRTlBXaEZqKzNuc25MWjFsVTltTnE4Z3diN1YyY3BLMkdH?=
 =?utf-8?B?Q1lIUVg0clptRmp2YkdteEIzQlNKZnozSWdUa2xIWnNyRVFqYlBzbFBuanpy?=
 =?utf-8?B?ZC9oZVByMjhpUVV3dGtxY1J1SHoxVjVpTzh0MFpQWFpkL0Y0T2czQ1ZpOGVJ?=
 =?utf-8?B?YS9QdjdadDNJZ2kwRjhTNncvUGlCeWVlQzBmRVF2Wk54R0tZNkpjVUxabG90?=
 =?utf-8?B?Z0lDNnNYSnYrbXRvUFM2Rk9aNitpZlJZanpFY0M0MTFkVU5UMFNuUUdkMjJp?=
 =?utf-8?B?Wm5uK05YWkJCaDJYa2lKSGs4Qm93QnRpY2FtY2RvQVdpSVo1UGpqWHhDTGtI?=
 =?utf-8?B?OWtOM0h0ZkxML0lJZ0xZekJJVTgyTW91Wml1YzNYSUd5OGcvZXBkMk9QaXAv?=
 =?utf-8?B?OW9NNkRjNnRzNmRxdXkrM0JUQk4zdHdWYTc3TXN5cEcvL3ZSNmx6TW9YczZM?=
 =?utf-8?B?Y01IVzZJd2svMzc5MmpGRzVQWUVrTWtmclJlSW01QVFRdkk3QVA2eTh6Sml2?=
 =?utf-8?B?ZzdSenN0WXRIcVpXOFArY1lpSFJuS0VGUHVpK3djZE5SdjVtVFYySEpDZEpn?=
 =?utf-8?B?ZGY3NG0vZUlWT1dWWFN2ZXFRclNoeG0xZnAwbDZIUDFzVnZiZE9pMXo0b2dP?=
 =?utf-8?B?cXAzeUJ1b0RqRVNKVkRKd0l0MDQyVmNjQ2s5S1BYZkxRTzAwM1ZZanlnV2t4?=
 =?utf-8?B?c0IzRzZlcXFTYmt2Nk1jemRsbjZlTlplekszMU1VeE5zYVpRY0hhcUdnTGJI?=
 =?utf-8?B?dFRYZTVIYWlSbzQrZzF3cnc3UGZ2VG9pcHNIa1BrNWNhKzNrbmcrYWgvYW5K?=
 =?utf-8?B?aXRMcmdOcktFbUw3Yk5ib3pHTTl2bEVqNEtWTVN2YXEzejJiMm00OWZiSUN3?=
 =?utf-8?B?YkUwUXFoYTNIbllKRzBFL2J6SG1PNFJCeTN0NjFtU3NUSzloZTBXZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d3b5ff-6e26-4ae5-5d71-08df1258a35c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 12:06:42.4490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CsT1vt+JK3WoRyZsJLG/WlLjfNAkJz1sWG5AtdqTZ55YdZNGFuu0P3nXuzNVjk6/xtTf1q1V7jZ/blc/gg9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
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

On Mon Sep 14, 2026 at 4:16 PM JST, Eliot Courtney wrote:
> On Mon Sep 14, 2026 at 4:04 PM JST, John Hubbard wrote:
>> On 9/13/26 11:55 PM, Eliot Courtney wrote:
>>> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>> ...
>>>>> +            fn visit(
>>>>> +                &mut self,
>>>>> +                key: $crate::gsp::nvkv::KeyId,
>>>>> +                index: $crate::gsp::nvkv::Index,
>>>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>>>> +            ) -> ::kernel::error::Result<bool> {
>>>>> +                Ok(false
>>>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut self=
.$field, key, index, value)? )*)
>>>>
>>>> Mmm looks like this is going to be `O(n)` with `n` being the number of
>>>> fields?
>>>>
>>>> This is ok for a first implementation but eventually I hope we can
>>>> switch to a more efficient dispatch.
>>>=20
>>> I thought quite a bit about this while writing this code, since we need
>>> the escape hatch to imperative decode (custom Schema impl basically). T=
o
>>> be able to get it down to a match on the key, we need to know ahead of
>>> time which keys a Schema will consume. That duplicates the info from th=
e
>>> visit() implementation.
>>>=20
>>> I thought up a few methods but it's unclear to me which one is best, so
>>> I just left it for now. Please LMK if you think this is urgent, I can
>>> try in a follow up to improve this. Here are my ideas (when I say O(1)
>>> lookup I mean modulo how the compiler decides to do it with the set of
>>> key IDs it gets):
>>>=20
>>> 1. current code - just visit()
>>> pros: key source of truth not duplicates
>>> cons: O(field) visit as you say
>>>=20
>>
>> Something about the visit pattern has always concerned me, and I think
>> it has to do with the fact that people have been told to use it in
>> all kinds of situations. But it's really only ideal for a few situations=
,
>> such as updated a bunch of objects on a display, for example.
>>
>> It's not a good fit here IMHO.
>>
>> Is it hard to do one of the other choices, up front? If it's easy,
>> it would be nice to skip this visit entirely. :)
>>
>> thanks,
>
> It's not too hard to do one of #2-4 now, it's just a bit of extra
> complication which is why I left it out. The performance gain is kinda
> minimal since this doesn't happen in a hot path.
>
> That said, all the options I mention here still use `visit`. #2-4 are
> all about adding extra info to help avoid having to call `visit` as much
> + let the compiler have more info so it can generate a jump table etc.
> That said, if you have an alternate approach, happy to hear it.

I think it's ok to go with the current approach for now and grant us
some more time to think about an optimization. As long as the shape of
the `nvkv_decode` macro doesn't change, the switch should be transparent
anyway (and even if it isn't, it's not a big deal).

Sure, an O(n) complexity doesn't look great, but we won't be dealing
with an exponentially growing number of fields to handle, and the host
CPU can be assumed to be blazingly fast to the point where optimizing
this is more an exercice in good software engineering than a practical
necessity.

Still, I want a very visible `TODO` so we don't forget about it. :)
