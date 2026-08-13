Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629E5C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 971CB10F55B;
	Thu, 13 Aug 2026 21:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZJ3MQJSA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563E610F55B;
 Thu, 13 Aug 2026 21:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFKqH6wSG/8kZrw8EujQePGZeZgHB+s5cNegexXJPBFy93VwC14JY5+ZulPHl+Cmx+LjM1+UdiAhU4tV67XVevjRbNx56+RWzgQwB6ZE/LDpc5TtoXRkPn/52W2XBDWfK7Vgo8O7MTMv24u7t6g+R6MPFbE965WRVrSXp+a9368UE5zfP8RGkEzXC50d2dbxfrjczze3y1fNpxqd+B0NX0cgHxwF/F27jeDRoyzSDN7dvZfH+8ojdMSoyW0IFz51TkOVNLHqFnGRTYlDX59ITwJrkV3ICB/S+/8uQ8+yqBASwuuOD8OQ3Bf13eeTwyjqFck9OX+AtmlHwnnDLsSdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVjbeK0pDlrzyRevjeqA3+FamE6Mset58LRYaQ34MTI=;
 b=uOpubYjJSjyEr1XYO082HlGGoJNpW/UiFBQmmtYOUd0DzdVDF3evu33VA1kknW1ybg4njYaAtisoy2ShfW+7/lE7VR5oZ4kfpor8tAxM98lYo9bNc8hiTNZqsxp99UClDYGtnbI1nzOWxuGzJaVR0Lxme1OhpU+zUTVUXLyLwgdNlo+/qmSKSNkyDClNXCTjnCoMowCQEorjffVu5HPgIQ+XS1gH2b3GjFRPC0YTT/s9a86zASuo+1deoEIIOFL9qNMIwoEiA6j2PU/F0Oh0emYycP4z3nSh/vtvBKRsFjNp20zx4bU092cJwC9hFfmdQeI6nExnsWZ+BE1J/3HpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVjbeK0pDlrzyRevjeqA3+FamE6Mset58LRYaQ34MTI=;
 b=ZJ3MQJSAFk3XKZoYGS0giTaFwT6Xb0FRYiWg001tnWvaONtPcjR/cWedmxKrIYYt+5/t5YK6Xl3qU4GLFWFerzQozgu602vtx0DCfq4CYYn5AMrLLmzUfPwhVJUF0Xg+5iRqn+RAImmSn6oxBlZFnQVcYgp1RC3p/c+TVvbJsf0/2PBc8CNaQ2tkzvwRe2+M7N814VU0mQ9d+plmrBDcMi4yjjCroM3zLSuEvJ6z5T6Irr21k88j4ecdSgGpw5FGiuILdfYB2Xp3i5UYXXqLTGscqyDDbOYotcsa1OIHRuzQW2tYpcWa0SOk20GSI4yuJMMD8yO98zBMJpZt3HyE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 LV9PR12MB9832.namprd12.prod.outlook.com (2603:10b6:408:2f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 21:53:12 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 21:53:12 +0000
Message-ID: <3c8c19e7-e1c4-4f0f-beb2-8d7cd58fb6b1@nvidia.com>
Date: Thu, 13 Aug 2026 14:53:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
To: Yury Norov <ynorov@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>,
 Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
 <DKO48OG9DU2S.16YBDI113DR4@garyguo.net>
 <c2cf35f6-7dfa-4186-acef-deab9a6f1b3c@nvidia.com> <an46vhEkOb35-oXE@yury>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <an46vhEkOb35-oXE@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|LV9PR12MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b5f9e6-f7ff-4f64-6cd1-08def9854571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iPzsFuOFyowEI4Rpsq1+hG3IkM9KaSaj+mBrzoIkLjLTPVNyw8NKR9hksq2sNJkzQRAI5YhC4HwrF1X1F1ojpLcNgV27PxRMYkZoYG9Q419643lauBA1rOBTFDu6+Mj5oRAyjCQ4pFXFcIaRM4BGVdfek1St7CUW1OBE2/mfTgmP5MfHfaUqFqkb2UhVQdZl3z/QMVxTAxFvsXm4f8acjuJC9gfgVplGZbrR8cLe/Hrlryu/QgYH8wT9u/kYU8X0YHVlOL4j5VerYkaF9gcc11hKp11mm0wKmUvUtRCBvCkTRvkQhtMfXhLlM5LDTSnomFWZTm6Yr9HQvljA6Azr49qfnLRIFyxZGmcEZpzfeFLepq6UI36NOt9lESK1IjCp2enH1tAeN29Ew9VlwIxKoM+8c/09LkpgildqGYM1/WqE68133G9oewwBirjkBeJUDpscoK2/JMxDc9szr1vwoG4I5OM7BwUwKrnoDAE9jPpLpouIzzL6211E4DIN5rOyU/IL77QAYj/iCr2vQY3k/7vYmtZLnQcPFPVN5xc4WCoOAWA80YS7mGYCmnmxKwq5ANjRh9SN03WRj5GDFkqnX5IanrK6eC/veJOXpIDeHa3QtmM5YHjgZpo/1EHL7mSy92xKzwNaO5y/h7CaAaPSx0rLYaOP4EOs5yjpCZGzyzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVxa25XS3NpYlkyVGRLdkh0SUdwZGd5U3U4QVNxN29LaHpqRWhzUkJiOGRG?=
 =?utf-8?B?RzF4R0p4S2dFVXoyWGJza0J6YzlhUE1sZnFONTZwNDk4MVY4K2Q2bW5vczI1?=
 =?utf-8?B?cGRES2JTQ05kK25WUkVma3ZjR001dC9icS9ETFlVQWRKWndKR3BmVEt3b2pY?=
 =?utf-8?B?RVFTQUdMUGFFMWhOMWwrNlhmUUk3UnFpUFBwVVdMcWc3RnZ3Q1VhbmRFallj?=
 =?utf-8?B?eGxFTHBvcy9sak9VanpjcnhESTdNQTBBamdUcHBQcW5pOTBERVRPMzFKTnFh?=
 =?utf-8?B?NXk5YUptT3d6dVhtekw4NkxMOHFxREpVeHd6U09zQjhZaTZmN2VPZEFBMjMz?=
 =?utf-8?B?WXpVakwzeWtlRzFPNStua2xYOTdVbXJSN0JDS1Z3SzhXWEdXZ29EY2Y4aW1p?=
 =?utf-8?B?bWFjR0U0a3A5VWgwSmRmakc2L1dnOERvY3pVSHBid3dvVVZKWEYzVzJXeEtR?=
 =?utf-8?B?czdTUjFEYzdjSHZ4bGNEZ2l5QVZ1Nyswby9EWFRKVW9jWWhoTHZsVk9rOG5E?=
 =?utf-8?B?bHJUazdObWo5TzUveUpINmk3Q2haODVQNVNrbi9hcHpmUVR3cVFZcTk3SjFH?=
 =?utf-8?B?d1dpajNqM3FuSlR3cVdJZnRrNHZMU1g0TEUySzBtdm9RL3FFVFhFK2YzM2xN?=
 =?utf-8?B?RmpSWk1wdURnVW9ZdE9QL1hxTEl0ZklXclVtNTdER3M1QitHTitzb0pYc29O?=
 =?utf-8?B?OG4rREI3VlBJZzg5dkcxejNteDgrcDhieWVQNTlGUEdna0lwTjNsVXRpMXk5?=
 =?utf-8?B?MzdlQzdlSThTelByUTdqT2Jud0p2T1d3aWRLZ2V6a1JhSlQwV2dMZTFCYTgx?=
 =?utf-8?B?aSs1Snl4S3ZZVC9oT21GcXErcmRQYmJCYmVrUGhzak9LSVZFMVAxdXJXUzdN?=
 =?utf-8?B?ajNoVXBEMWtsclJmWVdESVlGMXUzRUFmajMzVkRDWXlMeDNzbEtFWE16b1pk?=
 =?utf-8?B?cFdBQVFOTzhuR1ZVYmF5bkxjeUg1aURhZnZIaGNrWGdrRVl6UGpNN0t3ZCtp?=
 =?utf-8?B?elRtSSs5WnEwek41WHVlTlVSNTUxQzVyemJlOEU0S2FDT0x5MHIwZDJaNUZz?=
 =?utf-8?B?QWM2clF0dFZYcytVMVc1UnFmMzJ4dGZud0orR25PNWtiamtnemxFMjhEZjhT?=
 =?utf-8?B?T1JqUGxkK1gzdklGYmtkZTFmSXZwd1NXSmFuaUo4OWlSdkZ6SXh3Y21yRE9l?=
 =?utf-8?B?d2tQRVJNR1lyUHVrTG9JWjB4STJBelFHZS9UTWMvSStyand5OXdUNHpXWmxi?=
 =?utf-8?B?dzNsNERFWlN1cEFCMzhMd3VuZ2dtdWpYMVBvZE5GWW9PZXJGTjF4U3FCN1Fx?=
 =?utf-8?B?VkV1V0hwUHRkNmswZFdwRmZMUE5pcWY4NlBDUWZMRmZmVUc2K3k0eVFwbWVn?=
 =?utf-8?B?SGtlOEkzQzZNc1BxQ3V3Rko5bUtFd3BmejVKYUVyQnhXeXpjR2hxdXI4d0NC?=
 =?utf-8?B?QjdMUTBtL3ZMekJKRXJaenB6eXc3SnIrUjZnT0JtWFc4QkFRNko5V3J2Tit2?=
 =?utf-8?B?dy8yOGl1OVZEVEErN1lXRHMwZ2p2RUpBMFJxZklObDNzVURuZHVSK0YxTzBT?=
 =?utf-8?B?QXBtYmtFRzJzS2h6QWFZQTRhWjU4Yk9rQW1NZ2NJeTMwNWoxYVArVHBnVUZs?=
 =?utf-8?B?c3pUT3JsOFFudGVMNkxnOU13UVJSWUlseEZlb2E2bUhlQ2tBcnJuY2hYNFBF?=
 =?utf-8?B?cHRQVWZvN3Rlb2xJcUpvTWZrZkh2U0xFancwbTZDUVpwQUQrbmlqeEQwcFVn?=
 =?utf-8?B?QnJhbTJKb0xGQ3kwcmg2R3FmNkxickZEbjVmakJZTmZMN1hZQ2ltMzlOZlNZ?=
 =?utf-8?B?U1hzSFFLRnlXa01USnZWVzdqNmtKS2RlcGRDNkI1aVVyNGVlQW56RU43eXZ3?=
 =?utf-8?B?M0Ntc2xFT2JUMXQvNys0aVJoVlpkeExLY2dTRmVvZnZkU3p3M1BDRXkrRWw0?=
 =?utf-8?B?ZnpNTXpRa2tDeTJlb1JoYm9vckgzUzJIMnIwN0IyVmpHRXlqb3hFN1Mzb2NH?=
 =?utf-8?B?bXpOdmRBT0duTytMU3BCc3VpVkp4b3B5QlNiVTNTdUUzNVV2QTZqOVRrNEhZ?=
 =?utf-8?B?NEt0OVl1eXR6RUZDRmh6cU9nNC94SVlFdXZwQkcvanlkb1RZV2pxTUFubkEv?=
 =?utf-8?B?bGlud1lkVlpkcDZGbkRKVktId2xHazNhWmVhSUNoQkQxQ1N1Sm5jSTB4dzhv?=
 =?utf-8?B?Sm5XQlhTN3hHMlQ4Q2MxYkVOTlI1YlNUb3VIdVRMUGdqQnBIZ3JxWFhyQjR3?=
 =?utf-8?B?eHNEYXAyZEF3RnpJMUEyY1JrQUtPZ2NLT3haUC9lV3ZRSjl3WXpycnh3ZkE4?=
 =?utf-8?B?Qm1Sa092bkZYT1QzQ0NCemYvc1luTWozV05JQnVLZHMxRUJBN0c0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b5f9e6-f7ff-4f64-6cd1-08def9854571
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 21:53:12.5974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PjvKiZOXfLcZXPOMqT7OgG9SWzfeSIWkmK9eRaLkW/tav0cnHkUsRvZM4WjBqJS4TUHF64MkKD00lHEZMXsiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9832
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

On 8/13/26 2:44 PM, Yury Norov wrote:
> On Thu, Aug 13, 2026 at 02:38:34PM -0700, John Hubbard wrote:
>> On 8/13/26 1:58 PM, Gary Guo wrote:
>>> On Thu Aug 13, 2026 at 9:48 PM BST, Danilo Krummrich wrote:
>>>> On Thu Aug 13, 2026 at 8:32 PM CEST, Yury Norov wrote:
>> ...
>>>> The code from Eliot does actually already takes advantage of this. In
>>>>
>>>> 	pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
>>>
>>> I have to say this looks quite ugly, compared to just `.alloc_area(8, 8)`. In
>>> this case I'd go with something aesthetically better...
>>
>> In addition to aesthetics, a practical concern is that there is a
>> higher cognitive load to both reading and writing the longer form,
>> above. Perhaps that is just the price one must pay.
>>
>> However, for primitive types, I am hearing (even from Miguel) that
>> there might be a way to get the static checking *and* an easier
>> interface.
>>
>> Here's hoping you all can find a way to do that. :)

On second thought, we haven't talked about what the callers look
like here, and .alloc_area(8, 8) could simply force the mess back
into the call sites.

> 
> There's a nice postfix macro proposal:
> 
> computation().macro!().method().another_macro!()
> 
> https://github.com/rust-lang/rfcs/pull/2442
> 
> That would solve the problem. But it doesn't move since 2024. I
> recall it was mentioned in the bitfields discussion, but maybe
> it's a false memory...

thanks,
-- 
John Hubbard

