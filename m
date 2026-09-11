Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30B3C88E41
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10C910E341;
	Fri, 11 Sep 2026 05:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qe/nnwDd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012000.outbound.protection.outlook.com
 [40.107.200.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC6010E341;
 Fri, 11 Sep 2026 05:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSs7/6xjX4mzcIIc9pDnb7Z3cXm05tOFAZsoZLTwwMEKvcl+sSuLdcWrhcixG+ZOjtQsmQn5B2PTNflMref7jgrblCeOCtslJWMvy5VbMNtxZ8i2LefxktBEv64xXvqRNKyuLK8Wrux/mPdVwBNbN1UXJ/YZrd07AjMypMytrsEjIzZEHxoMirqCS+MIdFdeLY9UJn1sF74qYFa9tLaWa+TE9ejn4vxyVu8KYp7VHYo1qqQHJMqmROXxxlOmnVDX3W7rvXU2/9qRTBjFEeb79nV/x3df60rhjcl0AFcpBYVsxm98PCq+9ImpceD09tJBt+eLN/xgqllRHEvqpXDsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny+6gY/DY5IKfdoLwQ+cbbzJzM+S01EeHlV23QtwVcA=;
 b=bPHIS7vKu5saLXVw+sy3mNyHKQHy5nmaGis5+20oH1jQ19B3zd8xZY8ijeTFHaGRYFZt+I4eEelk61FtoZIrh0T8bGLGb5Uq9MHoz3ku28f6+iBRQZyfLTI9kGbrOiJMM54iNa1cQdLYJ68s4jb6DaDG6PJLQ2tbf7tV6yWEeAsOS+rJm0L0flKOF/WXFyigo0Fwz+8G4nCtun9kI04b7UwUnVKZ+tZPUwTSuf7Yv4QAzLmWqB1AM0RF6R2SJpc1hMByHnVQV0j/SOSHq/Kj6ohaOGz8Cvgpqrggi9V2lPTIG3JFlT0xeABcO1TyxHeFJPeXZEUMNvGca1g+JcMQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny+6gY/DY5IKfdoLwQ+cbbzJzM+S01EeHlV23QtwVcA=;
 b=qe/nnwDd0UKJOaFjfvAe9L12Evdt7zopnwVBURhglLA71Pgt2sRH4t/ptwFQbssSAP65fg2p0+dOiNy+YrJO7pBYlsvDUvldmDZT3Lsmu0RRL+Vu5boLzlN42a0Cch5dxVlPDqFG33m8C5YWU81zQY+KbP/76Ygl9oQAULEkpcYqhfqOMfp2l4wIjFCJ0uqw8gTVA/evvFWTfLjC2qg6iAmxT67jziwLV3pKSQDm0hk4T01KWf+II+8O54pNOXR6+IlRcdSI6aO7v+JhdX+3mbnET6/tP6E97VAR4kK0n+Kpr04HunucqlsYrJ1o74/PDMWFJ6IG5CQ7Dl18I9IMag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:28:52 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:28:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 14:28:45 +0900
Message-Id: <DLC8MGO86DKV.3IIHPUADV9IRY@nvidia.com>
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
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 6/8] gpu: nova-core: add NVKV typed encoding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-6-0de9d5c8658c@nvidia.com>
 <DLBHFHGH4MEE.1ZELDBMX36IQC@nvidia.com>
 <DLC8DZY8QM5N.5Q8MS71R0VKQ@nvidia.com>
In-Reply-To: <DLC8DZY8QM5N.5Q8MS71R0VKQ@nvidia.com>
X-ClientProxiedBy: PAYP264CA0011.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e9377c-b2c8-4c3a-2221-08df0fc5908f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|10070799003|3023799007|22082099003|10067099003|56012099006|11063799006|4143699003|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: hNoscsis7DGI5+STFQHXtcWOfHXi9h3+IgJrrUpFk5qGHyGgkXTk9f86+uNg6/gdJiOxLtk1M3cVSDoxwd6iiPvvemqbASohkaWF8nHJjG2Mwmh3cVC6tYbOLfuGqwxcwESsQ3jtMwcBNmy56tfyTx2xhFsjddZq6Woiz7Y11/3LDXYG+FJG+xv6DRTVxJgZ5wkt9YlLi9x30yVPrl0Ftma10zOo/KojYFGOk7A7umpavt8nEcq5kSHeJLgaujGL2lhf5P6m2AS06rAXe4k4ZnNEObrBTEz0HEkUuwOZ90wHMXZIc/iQSZMYPMdMwijWEsV7AS8M1xT3LlkXxFIgEclynPMSF4Ak1qHRc5V6DRsknF0MwWrjFaHQgJLogPSTkpO57ZptbJGQVUAhm/yMtrGY4lIKhy0VC2jN7UOddghqFlDBqSKtwK7d78rbEElQ1K+eUiJFWYMseQ2JZmPt/SOTtX5bdsqAKtNXgcC4Z7o2tnCRL9aonX9+tP27Z5PrIS+JWBFTdp3SZJUFacOXUSDfJOgGSkHZQHtrfdZcxGpzFpoM/mhCoJWKAXI4Ds5jIPvOsPZWQgvs0SGX2gDFL2BQmBeW2JDqP0oRjUMSZuiJNIW8/b7iAVKWdb1Mf0vDoI+jY/LpeRN4itNgdw4ymInpEs2Av/jOgeU9JqcKucQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10070799003)(3023799007)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T01FZEsxaFh2c1lDNmFHaVNmWEdhNVFFeURnTjhXK1puMjFLUFdCakJLU1pk?=
 =?utf-8?B?WEFwajVhVFFKQjFPamxWNUFYWFZHRWREU1JwZUtWSnpqTVlINm5FVVZZaE1S?=
 =?utf-8?B?ZjVoVVhhT21qZlc2L3U4WmE2dVY2QVFCNkR3VXNPTGdCdzRoNlBta0Z6VVNJ?=
 =?utf-8?B?aHRKQlpOYUJzZURWZ1BySVRJLzBGamRvS3pGZ0RocU5sbFR4WXUwemIyMms0?=
 =?utf-8?B?UVU5WERjOWRuMThELzRTMTNBTGRRR0Fvb3I4SHAxdmhHTTdabCtjSXMyaXdC?=
 =?utf-8?B?bmhjckMvOEs1Y0NtMTdZNzJnbUo4amVOaW1xZHlLUlFlZEx0SmtUQmRMNHRa?=
 =?utf-8?B?VXlyRlcvM0Z3NkZJRW9XNkRkWWtpZlB6d1lCMy9vRkpGN3Z0RmhwTWZnVktv?=
 =?utf-8?B?SmlWUG5tMmgzQ0MyajJYOTBadjUyaDRwZUUxVkc2MXdBUHIrM0ZPMXNJVGJz?=
 =?utf-8?B?T3A4SWhIWUlIM2k1cWRCVXhnUFFvRkFIcm1EQ2FlTGhMUlRJNi81d3dpaTVF?=
 =?utf-8?B?ZVdBODRtQTBxM3A0cUJJeUNXWDJGK3Nhbjhic1RMVzNJTENIdUNTVDZ5bFFq?=
 =?utf-8?B?QkhWeE82WHRVc1NROEZFUzV5VGVrQXJkMjJ5Z2RnMTc3Q2d0RXVLenJISzd3?=
 =?utf-8?B?Z0FsNml6NGdqbFRBZFNjcHE3dFRqbTlBZlQ3R3FGUUxyZGNRMHk2NjVYZ3ZQ?=
 =?utf-8?B?TTJha1l0MFhOVkdJeS9uQjdTRVkxWWZpYWkyWVlLc3owc0FzbUtkQW9BazIw?=
 =?utf-8?B?S28zWkJ5WmlWcDFJSGFJbnk2N3MvdkpObC9USGVrZHpyc1owZ0tjUmVNSVdw?=
 =?utf-8?B?NXR3UW44VjBZTE9IQVowdlQrME15ZUd2WUloS09nMDB5Zk1VQzZBZWhWSGFU?=
 =?utf-8?B?NG00SWhobVk4dVZuT0xpeE42aVRYWEhadFJwTEJOcDlDZldmTkRwcXJDbTVh?=
 =?utf-8?B?SnlWczQrbWtpbC9pZm5MaXl6Mjhhd2l2YTMyM0cvNStoZmNtL1QyS09LbkpU?=
 =?utf-8?B?ZlNMNHZyeEZzWTl1ZUFOSGV1Ky9adXJ1bmVyVmdrODY5MUI4d1lJSUF4MGgv?=
 =?utf-8?B?eEFYTTZaWEZJN0E0Uk1FeTIyWXk3NWxtL09YcCs5OVJDZGRoY3JhZ0N3VExj?=
 =?utf-8?B?Tm00Nm45aUVPU1ZCSkxyRXpGU2UwbTdqMDduV3gxUURoMkEyUmVadXdkSVoy?=
 =?utf-8?B?OUJyb3R5a0dyZ3JtRFIxN2F2YVVFWE5XZER3NFNKclhiZU1RdUZhUUV4dmlZ?=
 =?utf-8?B?RlpQOW5TOGF2bjFlWS95d2ZBa3FkQlJzNUxJaWkzQmFuSU5JRWJEMURhU2xB?=
 =?utf-8?B?bjlrenVVZzFjV05nTVZPYWNuRFA5QklWWXV2eEdhLy8zbzJlVk03azkrNXVY?=
 =?utf-8?B?ME4vdkhzU1hEQlp5eGoxcDZ6K3FoRkl2NzNpL3lDeHo1UzJCYXd2cU1NZWU4?=
 =?utf-8?B?QUVqYU9KZUh0bmRleC80Z3VodnljNzRsOXBOdjdXN0hMQUlmOGh2VWo5dm9H?=
 =?utf-8?B?K0J3bFY4d05tSFZ6ODEwanpKTG5xdGdJMHpqR2dGQ2s0dXFIS2lqc1paamNi?=
 =?utf-8?B?ZjRoOXZQckM0RkQxMmdzaUJvTUltb2JHVDFrREpjQ3RqZ1JVYjAvWXJmZFBO?=
 =?utf-8?B?UFF5cDJ3dnZrTUxUdjV1TmliYjQ4blphVFhKSzNLYnRLM0YvNjEraWpKSlF5?=
 =?utf-8?B?Z2tQNGw1Q2R2RHU5dk1PZXVQUlh5U0lZT1pUVUlyN25YMEwzNURXWE9xSmR0?=
 =?utf-8?B?RHZPTDBWYUN5QndJTXF4OCtQQVAxeFdhQ2dLQXNJUWJmSk8ydzYyTUlua2tt?=
 =?utf-8?B?Y3c1dUtDN1NITVRxaFNUUUpjRUhMYTVKRVJ2Z0pHN0hOakl5V2phWEZ3VTdO?=
 =?utf-8?B?REZROXdEZGpLMlNyYkNwcjY5d2lPd0d1N2p1NWRXaHo2NkZLa1ZLb3NqVmFW?=
 =?utf-8?B?SFM4UWVUS1MwSDNhQmc5UitNNU1pTTlvaVJzVnkzcWpuTTYwZGdkY2FYV0V2?=
 =?utf-8?B?eFFCSlFRWHM3dG51ZnBjNXFDMlF6cUFjTnFuZU56cUNVMkFKUTh4WG5LQ3dJ?=
 =?utf-8?B?eEFPNFh2SFNVQmkzOHV1aGRNWmphS2VYK3Y1eVJIQ1ViZTlZQ1lMbjg2dVM2?=
 =?utf-8?B?eTNNY3ozbDhKMUlkcGxSZXhsTFhpSmJNUFZaYnhRdkF4azVWZ1djSnFxcThx?=
 =?utf-8?B?R1RtNVNyNjhiQjVob3dQenhHRWJoTzhUZ1VNamVFb2t1WSt0WWhtRHhRNjI5?=
 =?utf-8?B?dUI1TUFKaUk4c3cwckpFeVFGTWJPVStEY096MTEvbVJHc3BSYzBYN1ZMSTBJ?=
 =?utf-8?B?TzFOQVpjYmw1RTB5QzRZdllReVpoMUZrQ1lmNTZkdzlkalBQNEpNSCtNUzIr?=
 =?utf-8?Q?iJT8UnX+xmN8PNpeyuc9kQ1lZbDGKi/eOzlMgV3YLCr1Z?=
X-MS-Exchange-AntiSpam-MessageData-1: q8/spWW88Ae/lg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e9377c-b2c8-4c3a-2221-08df0fc5908f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:28:51.9559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNEj8l/G0xBmIqEG02M8qFeEIh0X9+uj9Xra/kaOrBR0b2T6g/rxp6cVa//+dtax9PM/tgYF0Ma5VtzBzsai3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF
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

On Fri Sep 11, 2026 at 2:17 PM JST, Alexandre Courbot wrote:
> On Thu Sep 10, 2026 at 5:10 PM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>> For struct-like GMCAPI messages encoding field by field manually is
>>> noisy. Add some type machinery and a macro to automate encoding of
>>> struct-like messages. The `Encodeable` trait can be implemented by any
>>> type to say that it can be encoded into an NVKV `Encoder`. Add a simple
>>> `nvkv_encode!` macro that works on structs and encodes each field in
>>> order. Provide some base types, such as `Key` which statically
>>> associates a NVKV key with some value, to avoid having to make a lot of
>>> newtypes and implement `Encodeable` on them.
>>>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/nvkv.rs        |  49 ++++++++-
>>>  drivers/gpu/nova-core/gsp/nvkv/encode.rs | 178 +++++++++++++++++++++++=
++++++++
>>>  2 files changed, 226 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/=
gsp/nvkv.rs
>>> index cbeee7f376b6..10dcbb9e602c 100644
>>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>>> @@ -10,8 +10,13 @@
>>>  //! naturally maps to storing a &str with the GPU name.
>>> =20
>>>  #![expect(unused_imports)]
>>> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
>>> =20
>>> -use core::ops::Deref;
>>> +use core::marker::PhantomData;
>>> +use core::ops::{
>>> +    Deref,
>>> +    DerefMut, //
>>> +};
>>> =20
>>>  use kernel::{
>>>      alloc::{
>>> @@ -92,6 +97,48 @@ fn deref(&self) -> &Self::Target {
>>>  /// The index of an NVKV value.
>>>  pub(crate) type Index =3D Bounded<u64, 12>;
>>> =20
>>> +/// A static association between an NVKV key `KEY_ID` and the storage =
of its value.
>>> +///
>>> +/// Use with the encoder or decoder macros `nvkv_encode!` and `nvkv_de=
code!` to let them know how to
>>> +/// map the value `Key<T, KEY_ID, As>` to/from encoded data. For brevi=
ty, `As` inserts an additional
>>> +/// conversion (`From`) to avoid having to implement [`Encodable`] for=
 many types. For example,
>>> +/// enums that are easily convertible to a u32 can have `As =3D u32` a=
nd rely on the existing encoding
>>> +/// for u32.
>>> +#[repr(transparent)]
>>> +pub(crate) struct Key<T, const KEY_ID: KeyId, As =3D T>(pub(crate) T, =
PhantomData<As>);
>>
>> Does the `T` need to be `pub(crate)`? The series builds fine with it
>> being private.
>>
>> Also the relationship between `Key` and `IndexedKey` is a bit unclear
>> with the current type layout. IIUC `Key` is basically a specialization
>> of `IndexedKey` with an index of 0. And yet `Key` is declared in the
>> root `nvkv` module while `IndexedKey` is in the `encode` submodule...
>> I'm also wondering whether it would make sense to make the relationship
>> completely explicit by making `Key` a newtype embedding a `IndexedKey`
>> with the invariant that the index is `0`, but not sure about that one so
>> your call.
>
> Ah, I guess that's because `IndexedKey` is local to `encoder`. In this
> case keeping it there does indeed make sense. After complaining about
> the visibility of other declarations, I should have noticed that one
> too. :P
>
> What worries me more is the fact that no index larger than `0` is ever
> created. This looks more and more like a bug to me.

We currently don't send anything that wants an index other than zero.
But, in the future we will. The way I did this so far is by having
'IndexedKey' which represents the most general thing that can properly
encode anything accepted by the NVKV format. Since it's cumbersome to
and rare to use, I added Key as a wrapper on top. It would be possible
to hard code 0 in the index and only have `Key` but then we'd just have
to change it later. Since nothing wants to set a non-zero index
currently, it's private to `encoder`.
