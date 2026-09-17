Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F952C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 754B710E2E7;
	Thu, 17 Sep 2026 05:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hl1cedLi";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BED10E2E7;
 Thu, 17 Sep 2026 05:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqGEebaoNzGJFHwJkfLsXxW+q2Qrog1WlaF1Hq1Bx98qSR7m2uaeg6FI3jHgqNI5oRWXeK+akXl2yl/XJEaiYlhW+47a63vbsgmqf4nvs4trnbt4JH5NN6PblxXREs/bovaDx6N0q+2x8/LkY3qs2DBTrvq3sOb72u+JmaVbwpjLRUY7EUYw/iTiRrRS4AHnHnB7CF+ZZ2Tt4YpmflGaqKN3uuA6CMGWWWOqEdwsE6EXbxbGDLgNHWh5UWz2ZMagZBnU22qq2h/sIoBIHy8anooHbIVvoUy1PSl11NZpJJFLiwxu2F53Lz7m0Sr3KZPq4GGqoTxkr/G7fqU067T/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWN/N/UJGozXbiZ2OO9yZq+UHyPJWxI32Ooua6116vw=;
 b=r1MaAh1aZGFirzNR4wLLpB/2NJJn11QRMuROsf0WGR/DzRfG0HHRPhlDOQey71PyrR0jwmmbQneVWlGTgEjAzvZVm/zC4Sfwe4G2GWJ2i4bncqbGxW9qKc/kDaklGcAuvm8HRuEzu0+IokpVLisezI749WT33Z6heSB1xOLSoPYrnRuJrV4v23KycOF+uQbH9ipYpaF9ycOOv/6ohfaxpFhGJVuAKz9ww0WIxs6tpE2tXZEWEm6aX8+HIO/iZ6GU1pYCWC/CKpLPym2D0+cZ3vUGCxM/QW6Wsua48nnfGZqohYbPXG+/v7K2n/gOT1rzldrZ0Ywu5W8uiuP1kETWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWN/N/UJGozXbiZ2OO9yZq+UHyPJWxI32Ooua6116vw=;
 b=hl1cedLiaFrL7E3HnfOYeeCU1Y7c0ihfzIPwFWnFgi8RkNTJIiJikiKpdBlGyc+pdfanWgCNlniG4fH3HT09qx+qOxFzdnG65gPDDK0l4nA2YSEGvZxQr3Ttc4AtjXeXDGa8vp6LRGuuUhZzHl0Kxc5bk7SsEYjDYGym9tImvF4FrzFWcBiSvfCZT2Cdfhxmy1sPpa8V+0wwal7GkJEiuZz7RHDu6IoiScZFoIT0VmhVuVx0jSQEcgkYVAXAiIsPPE8+Vosw+2jgKuCOafT8DED5WwIXz9B9EvJHg85BOZxKu4P4vJuEJg38+QZvk7+goInoGD5+zbvxcvJSlkKORA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 05:02:49 +0000
Received: from IA1PR12MB6411.namprd12.prod.outlook.com
 ([fe80::b29f:6f15:4ece:5b5e]) by IA1PR12MB6411.namprd12.prod.outlook.com
 ([fe80::b29f:6f15:4ece:5b5e%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 05:02:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 14:02:45 +0900
Message-Id: <DLHBTTDIILUY.36G30M01MWRMA@nvidia.com>
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
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
 <61f1f28f-d76d-4231-b99e-4dd4a18b4fbb@nvidia.com>
 <DLEUSN5KTTFU.1OWYCOS7KC3NJ@nvidia.com>
 <DLF0YP85CHDT.3244P899RJ1ME@nvidia.com>
In-Reply-To: <DLF0YP85CHDT.3244P899RJ1ME@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::11) To IA1PR12MB6411.namprd12.prod.outlook.com
 (2603:10b6:208:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6411:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcb7b39-ccd2-434d-0fc0-08df1478eb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|10070799003|7416014|1800799024|10063799003|11063799006|4143699003|56012099006|18002099003|10067099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: nKuJwVtOnXn4m+qHe4S/Dap+syXylAmQFgd11bfnx1TsVgT8Rp6/8Yk2CKP6/s9NSRar8kHftlPNOXC+xbPSLwLLXzwSVBCI8JRuCg8j+wVlDi+CxnjY7SeTUokmfrCwI8dXi5OI7BYeUxaND/kQxJ2Xb9KsXll1ptSQnY8XjFGjW/D5k/KbgHsPyeZ/b/JAYkrwip/9w+U7bKeG4PWlidpwlgH78Am6nwStNpTw8GAebyB6iFjcbbsvcTsRiWwd70nI9hRlt/7AvB8IKXml6KjSI1xHLhcsgynnrgE/b7edL3nhueuFdTvVBJJ9o+/thR0FMdtF0tVc2C0mV/kKXC5DyM1+CTAM381gySBu6GFKYR9Wm1vBrPmYwFeL/pfL0AQ/i0GPn664O7mO4e/Tc9WJksBgKLmoKYq1Q5DebyA+E56l6MlTgOvFbJwmOZtS0HFVm2yIR98k5DZpd2QSBpjmEXP3xfx0fD4s8KtJx1VxKovCTwj6ojdTgtovRAFFCxQFO2dKfK5gOOqM9VNJ6+rQbaU9H8HCKCHQfZYYHu6Ye/LP/bD8xcnAhqogfG/FBbmbE8VbN8B+CQscAoSnVoBi0IhBMR3dgsngGByKGySU2MXMbNZy+NF/kGWDFz6oePnk+Pcoewead9c4tCZmKFaTodwOt6bZ0HIpK2wyP10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(10070799003)(7416014)(1800799024)(10063799003)(11063799006)(4143699003)(56012099006)(18002099003)(10067099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFJXYXlBMkpFTVNQNFdpTnh5bWpKRS9GRmt6dnBxRDR6UXU5cnJpc0tjOW1B?=
 =?utf-8?B?Zy9JVXlkbHJTdGFkTTVNQXk0Um9tOEN1WUhFSG1jVW0rYzdhVmg4ZlJoRk9z?=
 =?utf-8?B?T2pjclBFeHl5UFpERVpnNWdNb1REWUtlTFlQSWc5SzVZcUlWWFZjSmp4ejdk?=
 =?utf-8?B?WGxaeExpVHlXQnVRQ1ZPTlk1T0Q1RmpnRzU2SCtRdXFoUnJOaXFPOE1jMkdS?=
 =?utf-8?B?ZnA0UFhIZ1dLc3JQamdSUW5Fem5kUDNZUk4vbC9lbVVucGdsMkl2UTNRWHpj?=
 =?utf-8?B?blpNaEVSRTlNT2lRMkNsdTB3dkNJbEdzUXdkWXBsS1lIc2hyOS92b1RrZEth?=
 =?utf-8?B?QmR0d0tvU1dmaTQvT21DS1k5b3hxZWIzNG1sZmVGMVA4Um1rMG1KaGQ4Uk1N?=
 =?utf-8?B?aUs2cmNnMCs2TzFjRldtc2xsT3VKME9STGc4RUQzR3dYU3MwRG9vbWROSTZ4?=
 =?utf-8?B?Z3ZLa2xoWk1QOFN0bER3ZWlLNFZWR21UQ1hFMzBWSm00MWJSV0E4QWIwOS9S?=
 =?utf-8?B?b2RqZkNCYnRlZVErYldDUm5qMG4yVUhoL2E3YXBKUXE0WmdVYkh2VGpNWWNX?=
 =?utf-8?B?Q1YyWjR1UDBWcmpNYnJNN1FpSFNOYTVVWTMwTU9XWkcxWk9wQTkyb1ppZUxR?=
 =?utf-8?B?QitxS0lvdjlnMlJwTSs2eUNYS2NYcnZtTE1PL3RvcTMzby9MT2tDd2o5VkEw?=
 =?utf-8?B?TTVjMGNmeDFmRjhwVzl1QnRWUk84RXBPWUFNdHFXaTA1enpDdk9xcEE0Y2w0?=
 =?utf-8?B?UGI0RGRHUkdqQm9JR2Q3NG5WN1lPVXM5emRNVjJDejBxSERucG9uejJxOHoy?=
 =?utf-8?B?dUxiVVFsSWU3MHpOd29MWVJPeTVDU0FlL3pPTUx3dG9OMFZTTDMxeU1pcFFs?=
 =?utf-8?B?LzVBYS9XVHFGUVpZckt1WUh5eG5lbW8yOFZNa0M3WFFyL0lvK3N3RUcwbi9t?=
 =?utf-8?B?eVV2Mkh6OGFHSDBocGZ1MjlsSWQxUjAxM1pHYWdBQzJuV2kwWlJkd1EwVW1N?=
 =?utf-8?B?NXRsOUwxL1JOeWwzcEg4MWZtR25oMnkxT3lWd0hsK3hRTTltK203KzFFbkRF?=
 =?utf-8?B?OUZ2T0lydFNuYTlIK0tGSEpZbFExNXRib2xVZGV1UmRmRFZ4bFV3MVZqYkpC?=
 =?utf-8?B?M29YbmNWM0VsZ2t0RC9WeUtmU2F5YmNSMzR4MG53WDllTmhTcks5WUVjU3hl?=
 =?utf-8?B?YVBnMjR1aFpjelFFSm9YeXFRWEYrYkkxUWJMVTRhZHRBa1R4VWNlb0djZ3Ex?=
 =?utf-8?B?aENDOUl0VVVQdzJSWmpnZ2xCRUNaRGszR2JERGNBbFBrOXg1bk5YeXd2UG9C?=
 =?utf-8?B?cTFEb1RMK0h0ODFwbi9aYms3eE1FVzJSMlBMWEhYL3BwdlZRanZEV0lMbTRK?=
 =?utf-8?B?Z0RGLy9uVXhhelR2ZFUyOTByMWNReU9BUUVTLzdpd2JuR0NFMzJkQXcyaWRH?=
 =?utf-8?B?SmJKbktUS1E1R2JXclFiYVZpYTNDaG14MkxmekZIK3RnQlRuOHRJSE8vUER2?=
 =?utf-8?B?OTh1dFRYRGFoeFNvM3ZFaXBSSE9VNzU1YXE5aXppa0FiVTQ1a1JVL3dqMXU5?=
 =?utf-8?B?eFNUa3Fyei9ZSkcxYjdsdGtXaFkyTVJOR0FpYmJpNmUwV3JmbzFuN2VXS3Jr?=
 =?utf-8?B?VFF4bnJ3S3E1QWo0eFVEejNGbjJ5VWtiS0k2UU1SSVIwZ1cwOG52NVVMbkNw?=
 =?utf-8?B?UW1DUEExZzQyNWtEc3dldzhrRStNd3ZITjBxbGUvbkg5UjJ3SGN2dUtYSlkw?=
 =?utf-8?B?N3N4TzJyVi94dlpzc3VLLzdQT0ZwM25XWFJ1djlSc29XNXovZzlvR2tpSmxm?=
 =?utf-8?B?eGxtdGo3Rm90dWt3d2MwZUNibWJWN1gvWGpKL3NjUEpBY2NOUE1SaS85UXhK?=
 =?utf-8?B?cTI3NWF1cmlya25zTUJIM1ZGcEErcVVmT1dFMzNOYmtJMEwrWkJNenBZUGFD?=
 =?utf-8?B?NTA5OStycy9qUm8rcjJJQjROS1Q2cDBsUGNMS1ZOSXZIcGJpNmVzTS84cVV2?=
 =?utf-8?B?bkZuNHRDNUkyUkZ6bU8yeGU0TWJ0cGlYNzBnTDNVcjRZeEtDZm9Nckc4UnZL?=
 =?utf-8?B?UVJGbDVMWktRR0V2aEgwSUk4aUtkWVp5Mnl3TU96aEZYNkNycTFFSElpZzZF?=
 =?utf-8?B?cmVtamsxdEFtVGdWeENFa3FzaEYxS0ZKc2ZzSjJ1U3NESWVpTDhCRGhLbjlq?=
 =?utf-8?B?R0JYK1QxK2JJYjZ2MDEyM3RTRTBNZHYrNjgyc3ROb3Y0Y1lzWnBrbXNDZ2hH?=
 =?utf-8?B?YlZzMDRUNHJHUnU5QUp1WWR3L3pUTktPZHYxbFVZMWdqVjVkM21NZ0VMTkkr?=
 =?utf-8?B?ZWQyeFJqZlNHY3Y2c0pmWjlNV0dTY1NJdkMvdTVVNnNReFlvUnNhcDArU2tJ?=
 =?utf-8?Q?8mc1CBcfGWIFj6cI1Rgortw6XKc0iGmSX6v2kNI136AA8?=
X-MS-Exchange-AntiSpam-MessageData-1: jIIbspPe9vqW2g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcb7b39-ccd2-434d-0fc0-08df1478eb2b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 05:02:48.6775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1zAylLRPrRMf9vf6tRJPb8SupygG+PDaQIS0635SS0CiD9WE4t+kzQL4934Q8TWPfoqgSMntwXeBm/cVmp4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
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

On Mon Sep 14, 2026 at 9:06 PM JST, Alexandre Courbot wrote:
> On Mon Sep 14, 2026 at 4:16 PM JST, Eliot Courtney wrote:
>> On Mon Sep 14, 2026 at 4:04 PM JST, John Hubbard wrote:
>>> On 9/13/26 11:55 PM, Eliot Courtney wrote:
>>>> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>>>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>> ...
>>>>>> +            fn visit(
>>>>>> +                &mut self,
>>>>>> +                key: $crate::gsp::nvkv::KeyId,
>>>>>> +                index: $crate::gsp::nvkv::Index,
>>>>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>>>>> +            ) -> ::kernel::error::Result<bool> {
>>>>>> +                Ok(false
>>>>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut sel=
f.$field, key, index, value)? )*)
>>>>>
>>>>> Mmm looks like this is going to be `O(n)` with `n` being the number o=
f
>>>>> fields?
>>>>>
>>>>> This is ok for a first implementation but eventually I hope we can
>>>>> switch to a more efficient dispatch.
>>>>=20
>>>> I thought quite a bit about this while writing this code, since we nee=
d
>>>> the escape hatch to imperative decode (custom Schema impl basically). =
To
>>>> be able to get it down to a match on the key, we need to know ahead of
>>>> time which keys a Schema will consume. That duplicates the info from t=
he
>>>> visit() implementation.
>>>>=20
>>>> I thought up a few methods but it's unclear to me which one is best, s=
o
>>>> I just left it for now. Please LMK if you think this is urgent, I can
>>>> try in a follow up to improve this. Here are my ideas (when I say O(1)
>>>> lookup I mean modulo how the compiler decides to do it with the set of
>>>> key IDs it gets):
>>>>=20
>>>> 1. current code - just visit()
>>>> pros: key source of truth not duplicates
>>>> cons: O(field) visit as you say
>>>>=20
>>>
>>> Something about the visit pattern has always concerned me, and I think
>>> it has to do with the fact that people have been told to use it in
>>> all kinds of situations. But it's really only ideal for a few situation=
s,
>>> such as updated a bunch of objects on a display, for example.
>>>
>>> It's not a good fit here IMHO.
>>>
>>> Is it hard to do one of the other choices, up front? If it's easy,
>>> it would be nice to skip this visit entirely. :)
>>>
>>> thanks,
>>
>> It's not too hard to do one of #2-4 now, it's just a bit of extra
>> complication which is why I left it out. The performance gain is kinda
>> minimal since this doesn't happen in a hot path.
>>
>> That said, all the options I mention here still use `visit`. #2-4 are
>> all about adding extra info to help avoid having to call `visit` as much
>> + let the compiler have more info so it can generate a jump table etc.
>> That said, if you have an alternate approach, happy to hear it.
>
> I think it's ok to go with the current approach for now and grant us
> some more time to think about an optimization. As long as the shape of
> the `nvkv_decode` macro doesn't change, the switch should be transparent
> anyway (and even if it isn't, it's not a big deal).
>
> Sure, an O(n) complexity doesn't look great, but we won't be dealing
> with an exponentially growing number of fields to handle, and the host
> CPU can be assumed to be blazingly fast to the point where optimizing
> this is more an exercice in good software engineering than a practical
> necessity.
>
> Still, I want a very visible `TODO` so we don't forget about it. :)

Yeah, I think with the current shape, an optimization would be additive
(e.g. the discussed `accepts` idea) and not affect callers at all, just
implementers of Schemas.

I'll add the TODO. Note that all the optimization ideas I've suggested
so far have negative points w.r.t. good software engineering practice
because they introduce the footgun that your Schema must correctly
declare the keys that it consumes and underdeclaring will cause wrong
behaviour. Since (I hope) we will be mostly gluing together existing
Schemas using the macros, it should be fairly hard to hit this footgun
though. A non-visit based solution would need to handle the regkey case
(nvkv is stateful, so it's hard to handle it in a purely declarative
way). That's why what I suggest here is essentially an imperative core
with declarative handling bolted on using macros.

thanks all~
