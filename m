Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E614DC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75AD10E315;
	Mon, 14 Sep 2026 07:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YO+xGuGd";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E484E10E315;
 Mon, 14 Sep 2026 07:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLT2B6K3rQneLRDdhavrI4VBqXA7B4vAPpSobVyYCRMXsbMTHFqF6i0KBYSODn2kWYpMu+piPQgl+Icf6hB1UZWRBZq2XCHSl/v0zwXnXqDIZO+/HABCp239FtgQU9d6fsPQCqz2emX3zCteaQXSGFE8//k72mQAD8Lzc/APqVf4Y4Kbzx+OvQJjqGoyXZCo9QDyPjyAldgBKcJWu7tsy6rA84U+G/xPde2l4GV/MTwPRAHzhwCyUnJAt+uA4cYHlAKlFSqGTTdf2+lgt0pglVB6XX5H6uwvw7i7b5LTKoM9a0ySkGCR9oIPBroStwmro9R4ralQlxZZ4KJArlwBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMcqpDOZVs1dfu3wTgRKCxh1Kb2kXvC26gNsFgyzDQw=;
 b=ps3YTFwEkxtila7P8Z05OzlB+W0WSREIRzOa7yN5xgCeHKYCBGhilU/+HM8l1K6/il5o9FvO3SOE3wbMspbdyOWwutLOtIjF6LfK8wEE2sMAyr79qc1VmSMdYWdbKn6f1snFOpF1XNq6MQkffG4UurusX6J9r5+tlBHHUmCPKM+7jY82Z1gLNtqDtZx7/6GyMOZFK5XpWB5EuTkssKC/DURGhJZ3J2vaeezJQsLblFh/a1ZUxGjqMRibiyWmndLHMQsuuWILeHh31bl7N6HuFTuoPkLNiJItfxkHTLNe8S0wARjxNiu0EQgqKl5gYVG4KGyzREkKxLv//vrsLd6qCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMcqpDOZVs1dfu3wTgRKCxh1Kb2kXvC26gNsFgyzDQw=;
 b=YO+xGuGdfLU4X1Rz5/ByoxhdtehZ1wSwERj+SsTYsomRTA1rqaBWW16gBq8o2SqTvecTbkDvt+v4GwQo3iXpb9e86Q98sJMKPWfSY7aG81cfsUebvDg66jCzzQ14iLmCcn480yz0/XzD6/2pWyOxRgzgT8PZEbLiOQOYuSZv08B7n0Q+37fjU0V/9ujHoctuj7+jlQnTAyPHt8e4ybXpyOdVbi7McxtCa5uVkb2L4ZPSDtZl3MRWNWEuTH+DVgfUQcoZVVcoj/d7YoSiohq93wS79PwaRIfhc0Mqmlq5e+Maq595EIiUe115kon1t6LKD4W+1gkZ3wnDHPdof3aiKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 07:04:34 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 07:04:34 +0000
Message-ID: <61f1f28f-d76d-4231-b99e-4dd4a18b4fbb@nvidia.com>
Date: Mon, 14 Sep 2026 00:04:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
To: Eliot Courtney <ecourtney@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::12) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3929f0-00f3-4229-094a-08df122e6e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|10070799003|1800799024|23010399003|56012099006|11063799006|4143699003|3023799007|10063799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4Elejjq7nbblCE2wEYsFuJsfexWbdnCipzkaCeJfg54P+CC4qt1I4VgSar+xy+0ykBgt5UlktTXSFIaiPaZ6aOfNK6Jyp8GmMyCnKMdpEvBgneynuSiAs/cmQDXlu84KskzdV9NRHwFI4dImhBqmX8d1up9F+hW/kWhDWkn8GE/l9iFqPInnq0RkrUVWEFyoqCmb9p9rn09dPlWkQujxEfELTAhJz0kkM5A7hOlyGjFQATWqIHP93KHPa6vA8ikWxBB/8njVY/FeqYaELVl570L0aOxoFtZuE9PbZ5R0ND0EAuDYBe58m07E8aG2Euij3shLjoe8Apo8WCioj11eiFzvzixdahbdjR6ah2RmXdrnkhrqYtOjUNRBPDVzqub87knB04n1pO3tEgv7JJ/60zBRbWJLgStBN6cSof9rSRVtatkAXGKWHbg1Hk9l2KfVXm140MBJiKTqNzurPm2MTtkXI6et6YDqnd425onnbBtimAVd00SvK6cWSrlCEgnkREkcKu3TmNVNA4SVptjRY/AJuyuzJcNc7TCkxIWSs+lwsEUpkFnGt4ZQSHrZG9MGphQJMKAtbb7DD+QBbN+WRWNExwb1iDBWC1DTrls6AXZ32NqlMfdCwvLlw5e/J6rity1VO8eROnk+XWeaPfMzAFvj31rUoFU80/H5pzLoxGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(3023799007)(10063799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmc1VVJGeEJoUEpiUnFnY0wrSDN2RkVWZUUxTUpSbFZVYzgzSGdYNW9UR010?=
 =?utf-8?B?dkh3UDhITjBGYm8xV0JWNWcxMFlmb1BHTElBcVB4aWNsT01iaDZUWk5WWmds?=
 =?utf-8?B?WHNVcHZVQmh4M0FGcGNRVXQwQUt5eUFvYUtMYksxSDQ2cHVqZFJVWU9HNy80?=
 =?utf-8?B?NG5aUUhxNDZDcnR6b2sxZTdic2xsZ20xaWlHTVhqeGduWml5S2x6blpQOE5u?=
 =?utf-8?B?dTBSRzRkb1c2cnVWUllnN2hORjlRanFGcGdyQ1dwUXNtNGtUQVl0UWRtNzgw?=
 =?utf-8?B?Qnd6NUNPKzdnK2xzTGNlWms4UDBkTVV1MWdhaDM1c09PYm9wV1U5N2Z6OExu?=
 =?utf-8?B?YUpKUk8rYStsaCtFZVByeUM0TUoxc0hpUEhSNUZ2NkpsYURoYUtia00rY0Nh?=
 =?utf-8?B?UFc0TEJ6YWJWdzVnUS9EM2dFNEEwM20xZHlhT1ZtUzBkMllxOEQrQUkzWVpO?=
 =?utf-8?B?T2paSjZxT1VHU0NQZkJGN1F5dlhZQVdZU25laDBLVGFrbVZqNXd0MzZOaElh?=
 =?utf-8?B?VUNjVmkya3lsWUYzMWZQYkNLQkt6MWZEOHFzMTlNSExFNmZLWE81enQ5K2ti?=
 =?utf-8?B?VW9qL3ZYV2d6TCs5eTRJSythNnU0YU5ZczlQQ3V4ZTFLaTZ4Sm8xNHJYZ1kw?=
 =?utf-8?B?c1VZZ2VZVjJSNmFpVEY4eTkwOWdIR0h6SHljcEFUQ2FybU4zc0lxOVRIZ1Rj?=
 =?utf-8?B?emFhOENRMzlrSEExbWd1VGkzNmxuZU9ROHlNR1FZb3NIQ1o5Z1Q1YWtTNFEy?=
 =?utf-8?B?M2N6T01CdHc5RlFuUW1OMGdmWDdMbHY3S0wzMmxYMW5KZTRKVDZSUkZ5WFR3?=
 =?utf-8?B?bkI4TytXT1o3dGQ5UVI0SkhmQThOQnA5N1d5NHV6UmpUQWJPaGRKdERQMmg0?=
 =?utf-8?B?L1BzOXg5U0VCNW9ocUltN051TUxpaTJDVkM5T3NvYUw3ZEpKdVpYZVYyNFNm?=
 =?utf-8?B?bERyLzAxd1RBRlpIbkd5UytCMDhoN1NwVVN1cjNuaGNYWGJnUUxJZTBXMTZN?=
 =?utf-8?B?VmlMUlk5eFNWWE11R0MxL1FUVzJSc2hLV2VTZEtNSlBUM0xHaUdyUnBsWDlQ?=
 =?utf-8?B?d0FEMHVoSmpleHhLby9oZk9hcEhQUDZTZEFibGpxaHJpQUgrRVh3NlJYckF0?=
 =?utf-8?B?RjNXbmNJcGJHVkVkVnBNRFcwN2FFeDBEcWJNRjNSL3JoUVZ0TW4vdkVscXNu?=
 =?utf-8?B?WnBtRGRNNmpwY0dMMWx1RGdSeTNzN0VCY3phSldRbGIwMmplWVgrQkxTdUhG?=
 =?utf-8?B?WHEwSmZNNEZBY0w2WFcwSEVWTmdjTlgyL2V1V2ovMExsV0gyc2ltRkNlbjJL?=
 =?utf-8?B?d2NRa0owMGZpMHQvQUtLdlZTQWZFbVlHOGt3WWVrczkxU0NaK0J0NTdZTUhU?=
 =?utf-8?B?cVlnZnZpUmU0UWNOWUpiaEw2NUR4WkxtR1RoOHJXWGNIYjlnZVBtNzNDSGNC?=
 =?utf-8?B?YkdJV011RkxtUWY5aWhXblBPbjk4TDFMNWdQbnFMTmRDUDc4MjBQeDNNQ3Ir?=
 =?utf-8?B?dmxYYW1PVHhDRWNFVVN3dkhSUU5EcEVMUlRSNEhIcXlJNnRFL004NXFxUTU0?=
 =?utf-8?B?R0Q1anVnMXg3K3J2OXFFQUtpenlsZ1REMGdVaWtHTUR1VDZGS1BWOVQzKzNR?=
 =?utf-8?B?UmhLMURGdVVwNVhKN3U4eWI1UlBxV0w4b1k0R0taNTJ0d0kybUFxR0RUNlNv?=
 =?utf-8?B?bXBMSktuTHFIR2hvbWdTWndBUGQ0bmNCdEdYSjY5QVpVaGRoZFNnemcxYndF?=
 =?utf-8?B?T0wvbWgvRWQyZHJPQnR6MHV0ZnRldmFrZHNYRnZubTZmMEE5R1hjaVJhS3BU?=
 =?utf-8?B?QmF6WngyZ1QxRU4xK2wyaTlVbStWeXRmazlYZjgrbnhiV1N5Zy9Vejd4SXVt?=
 =?utf-8?B?NmNRVVlXVXZPZDNnRzRvS3kzeWNjRXJJZ1ZDTzdiRUJ1YnRHNzd2a2YyZk1S?=
 =?utf-8?B?Y0RFL3Q2dnRqVG92VXpURC9HelZ5Mk91ZytMVzE2b2R0OWZVajk4L2VxbmZl?=
 =?utf-8?B?eDhkT3lhUXZtUit5NVFRZFU5L0RKSlZMb1VPdmpGYXNUb2FnSHU0NzNldFB3?=
 =?utf-8?B?bXErbFdjSHZGdWlXbjJtdk44SSsvNUZRaVZEUHlvS3NPbURoZHZVYmkzZUg5?=
 =?utf-8?B?UWYxVEVtNlFNZ3NTYWZ4UlBXeGc3UFNxaXNBR2I1R04rb2ZjL2xpdXBTZ3JS?=
 =?utf-8?B?eWo1eHJJVXExWjkrdlFkdkp0RnprMUMyR1psV2lteVRvelJJK20yVDRNdjh1?=
 =?utf-8?B?bVF6TitUSmYzOHVnZlo0TG5YaGpXc3hCcG1xNytxSTluc1UxREJ5OCtyTzBs?=
 =?utf-8?B?THRYN2JvRFFpeHpVbSs2TFU4clJaRHcyMWZ2TTg3R1VPNDJEV0NabWtEdU9X?=
 =?utf-8?Q?cmkP3Z5XGtUBK/0A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3929f0-00f3-4229-094a-08df122e6e7d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 07:04:34.3055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsKtulT/X96k8wjdlMJO004KlDvrg7qgVuztbS/5JTotU4zROKYQtyt+6BeT2ZWKxZ8rmloStFx+wrJRl8yyxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
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

On 9/13/26 11:55 PM, Eliot Courtney wrote:
> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
...
>>> +            fn visit(
>>> +                &mut self,
>>> +                key: $crate::gsp::nvkv::KeyId,
>>> +                index: $crate::gsp::nvkv::Index,
>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>> +            ) -> ::kernel::error::Result<bool> {
>>> +                Ok(false
>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut self.$field, key, index, value)? )*)
>>
>> Mmm looks like this is going to be `O(n)` with `n` being the number of
>> fields?
>>
>> This is ok for a first implementation but eventually I hope we can
>> switch to a more efficient dispatch.
> 
> I thought quite a bit about this while writing this code, since we need
> the escape hatch to imperative decode (custom Schema impl basically). To
> be able to get it down to a match on the key, we need to know ahead of
> time which keys a Schema will consume. That duplicates the info from the
> visit() implementation.
> 
> I thought up a few methods but it's unclear to me which one is best, so
> I just left it for now. Please LMK if you think this is urgent, I can
> try in a follow up to improve this. Here are my ideas (when I say O(1)
> lookup I mean modulo how the compiler decides to do it with the set of
> key IDs it gets):
> 
> 1. current code - just visit()
> pros: key source of truth not duplicates
> cons: O(field) visit as you say
> 

Something about the visit pattern has always concerned me, and I think
it has to do with the fact that people have been told to use it in
all kinds of situations. But it's really only ideal for a few situations,
such as updated a bunch of objects on a display, for example.

It's not a good fit here IMHO.

Is it hard to do one of the other choices, up front? If it's easy,
it would be nice to skip this visit entirely. :)

thanks,
-- 
John Hubbard

