Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7016C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6FFB10E50A;
	Fri, 11 Sep 2026 05:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VnjBaSK/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E986110E50A
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 05:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1NVaFCoDPo9u+hZlTGsoiNDJ/7Or2uz4zPOflUvBMx7320rIb/qhhotkDax37L0kRU01STiE0iAie5JY/K0r51la/c4dVB/5lL4NHNmUYfnEjpvnwR2FjzV7NX9N+oUfHWOu6YFdQYbBNAwL/0Cb2rNRgYBVBJEAm9NlOSMsma++P5SVb4GYLrNebmFYRUprjWgxaz1jyxpISvLv3LjRwXjp9MVOPLVEmR1ir1WUNMODK1mryi36TUE5W+ZYW6iDf3PnWtjIrabjjW7Qi1GYkvtx7n5GlmC9WOPe9utzqHntfecVL0KB9k8C0na6a+ys0iPJo8dXkblnoNd+ohcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8R0xFlqmIVkN82QB54kepPu/7BaJDSPHjt6Om7WK570=;
 b=hy0uts31juJqNt5r5LWHpaXnVsmlglaPvdaWYfHOxo3uCZQUv8JBpsoRRGabLs7ZusjUqMsY5aCInCKHYCiqOjLaK/xEa/DVa4/axYmnGNmF55q6B121ik1F6LtmbLIhwc2jXjEp91YffF7N7LKJNZUmXSGckz1r0GW68CDqN3SpRFwNnj6WxbEmlAQcQluxA6ZuKwELySXa4U/ohUrwM+oR4gvjhxURaoB2ruzAHGsb6zgzbPfzWRTJuHzgOkKfi9YdhS6gX54vGNQBSacVT7xC1/gQfZHp7sNTiWLa3cqh3ncLtwFF0r9eO9h9IDAxtN22uHX8AlF3kZmfdtce0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R0xFlqmIVkN82QB54kepPu/7BaJDSPHjt6Om7WK570=;
 b=VnjBaSK/n6NwTbpeDz99Ara/Daxuijv2i9A5AEMpVNJ4fASARvVskpbev2tHWtlUxQpsP73t6sfGYNIomdemm2IZ9w9SC7SqHL0jgF6fwFZsk1ScIMnOFsGNEGSweH62wJYZt/6ZllVsN2IrjYrLp8TtLIxAkRuTYZYhkHeeo+GNvfFFnj9BM6E4qzM85GpwJS0qV2vQQUN4os5wuZUzT9StvwHCsPtSJtbuks3iDVAbspmbTq8dz+X4DeJy5QdR4fGZI0SL7QJhHf2G++zKHzjg+IGtrNzWBxUSLV14NlyK/ryAiRIRJCVm1IZAD8W5gdMJRxaccOQpE6DWK00Ouw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Fri, 11 Sep 2026 05:17:45 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:17:45 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 14:17:42 +0900
Message-Id: <DLC8DZY8QM5N.5Q8MS71R0VKQ@nvidia.com>
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
Subject: Re: [PATCH v2 6/8] gpu: nova-core: add NVKV typed encoding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-6-0de9d5c8658c@nvidia.com>
 <DLBHFHGH4MEE.1ZELDBMX36IQC@nvidia.com>
In-Reply-To: <DLBHFHGH4MEE.1ZELDBMX36IQC@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 80950415-c480-49be-258a-08df0fc40328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: MfyjK/o8ORqCpMNJ4HAM5lEUjoG8N5s9XQidS7rBVdcwtwzl6fLWU8VUL49NlPgwxZ1OcPelso7Aq6PyZGyFZK99IijmKKrosDelt5aHXjjGGJ07x4jl7PnupUALj50haepNTnVrEjr5sE63jQAkquO9fijo7oIpk9JV2steHXanvnG/ea9gLRep6LCFDh5cKQNnpmC8w9wJuAqvkVS8op6NHKC9YHk0mcH+Yt23IqmFPa4yJsieF2HBKGELcEruSqKgwF3Od6hiy25QDml0y7SqgVetePlOQPzUrlKiZqtMT0T2zpiL2pLzH3YTG3Q/VTm18lBVSUKK0zN0fAlE0qizaYOv6RwtmasBTiFeFK7k9kKojii03tG4gVHuFWvsRWC5rjvtkFB3v9D6nGNO6Gw4PS7lm9o2eCikb+/YL14WjtnxpicqQVmC7/XFj8fWACgSYSKlYL5+pamsCRIOdXq0Q2+vQS53nqHUdI5r2Mcmtqd678CN6nOCTCfocrqgvNiYQdAZtIxXxY9pbqnGn0k0q0FgFY706sF0EFb8P2i5AhxjBZbYF8ZSJZ2RhRlUmwLgZPPz4PyBct9aJ5qhjDuqCOxFgEP2wZ5ixQ5Clz/EUUjnqwrcyqbzOeEa/NDMWOPhkWuk1rwfZf1ENGh1OlkRnazdURIF9yLIKeVntFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkIxaTYxajhlUFlLRm1qZEs4US9KUnVOUG5JQXBGUDBOOUtxV00rNzBsOHlY?=
 =?utf-8?B?UjFNUm04bGdmcEVNb3AzMy8vbWpyOGd4SnptT2FLNThDRUoxSVZ2Rk1Tc3Ev?=
 =?utf-8?B?QnZCM1VoUmRDNzh4MmlUbWRUd3FwcFNobHFnZitsZ1VoWGNkYVVlb3RkbDdr?=
 =?utf-8?B?bUtKem1teXhxbmtVbWhEWFVFODVDUzcrNHFzL2NDTklESFdoVDZtZ00zRXZZ?=
 =?utf-8?B?ZHNRVkIrUGZZekNEM0xjZWFPdzRyekxTUGNqRkFRQUxpbjJyc1ZoVFRic3Qw?=
 =?utf-8?B?VEU1bzlUV1A4dUhzaW9Ocit1MkxpQnVtd2wwd25CTlRzaFR5RjNRVXpWRUgw?=
 =?utf-8?B?ay9oV3VPRU5wdEJoUElkdDVkMktLVXNvTjdoV2o2TDFRb1BMRVZNV08vVW5B?=
 =?utf-8?B?T0dHM2N2TGo5TTZHalhRWlEwZVluOTFXem1iSzVvT0lUWFhyb3RjeXlzdzZN?=
 =?utf-8?B?WWNiMTlUWmttYmo0OEEraXEvS2RXQTd1R1o5WVg2Q3FXNWs1aXJNRi8zN29W?=
 =?utf-8?B?Y1gzSkVGcmhFNWdoYUx2NzdFT0hnREhDUzB1SUhoNXJnRVRVa2k1aHA4d0N3?=
 =?utf-8?B?SExvTjlPTmEyT3E3Mm83dE5zOE51amdoQVNMT1RJSmlvUHRVQ21DR3NoNVJN?=
 =?utf-8?B?ZUxhakNPS1czbG8zRldSZEtqaUk4SUxXZ3hMR1pDN05rL1ZmRTJmNm9mZDd1?=
 =?utf-8?B?NDMvSU1QR3dVSGUzRVZ6YnBjMk1tS25MWVhkZzdiVXVQVjFHbks4cVNpbFBU?=
 =?utf-8?B?VjBpRUNacHNuM2wxV3NGaXgyU3pZc2NjS1dXRDZGL2hKUjNkcVRsRWo0VE9E?=
 =?utf-8?B?ckJJaHhtZXA0bFc2UEJwOEhjeks0VTR1WTVVT3Z4RUdmWCtkMlFNRnRMUzFP?=
 =?utf-8?B?aDllVFhzM2c1L211aVozam8xajcwNHViUEh4Z2V0eGlKNFppMXU2N1k0aEZV?=
 =?utf-8?B?MEhvMkNjY2JkblRPZ0JsNmVoR01MVUNVcEpFRHNTamZRQW51SGhGVTF1Y25V?=
 =?utf-8?B?ZmJHMXhTaDNmL250c2x6Tm52b095VDhLV1JNSEhydUpBc1NLM090Z0Rxald1?=
 =?utf-8?B?K3ZVZzF3YUUvOEdUK3Nobi8vQzMxdTdLY1ptenoyRDJ5ZUNBQVdFYXVUMGor?=
 =?utf-8?B?ZFVoQWNNS1pZQnhERTZJVXJpSHNBYTh0M1pNaDJGUU13NWxoYkY3ZW5yQlBN?=
 =?utf-8?B?M0F2Rno4VWlzc2xUak9Kak4vcGVzYWZ4K3lrOUcxN2QzMC90VzlZQkhtUmJX?=
 =?utf-8?B?L0pQMmRJWGJaK2ROZGEzUHJXNFN5REV0MjhXWHN3c1dRckVsclpQbDBUUTVX?=
 =?utf-8?B?aWFVMFpVckJTTVIvV3VjQnR2UmxOZHdkQUpTVzdzajZFdWhZT2R6UXVDQ0Iz?=
 =?utf-8?B?aWJYaUplQllOaVVPeTcyNHEzTUtRSGUvVUpqVGZZTzRTMjdPRUZ3NGJYamhp?=
 =?utf-8?B?dHRRT293bWlpSWRRbWlHNG95SFJKbmNhdTF4eW5VVFVOMUVGaDE5emMyZGN4?=
 =?utf-8?B?QmJacnlDWmNyVk5JRFQrU3JDeXNzaDlHb2VBdmtiWnNTTGp6QThzWWdpQW0z?=
 =?utf-8?B?cG5jUDZpZEZSOEpyUWtrb0ZoOUtJK0lmaWsyYW1iNzBNeG9YOGJjbUlMaGZs?=
 =?utf-8?B?VnFLWk5MQzAzRjRodUR2b0hPc2c5bWFleisyWWgycWxaWFp1ekFYcVJpSStL?=
 =?utf-8?B?OVhzYzhOWURzbjhEemNsV2cyeitkRVA5VG03UWxUSlp2MzV1S0xsR2p6R1dD?=
 =?utf-8?B?dmVQT0Zwb0F2S1hsVzczc1VIN2JBd09IQWFyMXYrRElVQUhERVM0SWJ4V1Mx?=
 =?utf-8?B?SjNjNGdPYXhXdTRORnVzUmV5RndITVpUdlQ5YU81ME9WRFl3MWhqd3FOZDFw?=
 =?utf-8?B?dHF1alJhOWNnbjhyWDZSVjljY3g1ajRaNUNPMGtDK0NaS3k1S0JjNnlFbDI2?=
 =?utf-8?B?aE1iVkpaaFFkWkFyK2VEUGg2SzJJVlhNR0JrZEQ0Zlh4Q2FRbHRSR0lURFBP?=
 =?utf-8?B?WlppVC92d2ZUN1owWTFyYXFKRDhJYVN3Ry9LbUNwazlTeW9HSEZZN1B2SWpz?=
 =?utf-8?B?WmlRZnhCSDVZeDViVE1QQ1pxYkswcEcwbUkwaEUyVUtucXhnangwOW1vVXhr?=
 =?utf-8?B?cmRzaFdOMlJ0NFpmQkN3enN6Zkgwa3BSRmZ2dVNjSDBqN04yampVaE8wV1RB?=
 =?utf-8?B?OXB2VFd6SWZrMUNJZHFJZFllbVFRTGUyRExtSlNKL1NVWVBtVU5LU0JuaVJC?=
 =?utf-8?B?cWNIeHArRWxscVg1WFlnRnpHR0xsejZzNitPSGNVMnBaYU8zeXBJNmdMemlL?=
 =?utf-8?B?MGlUOCt3TGliWWswK202eTBrRXNZdldhTEUwdCtidDZ4UUNrSlErVGRTZVdp?=
 =?utf-8?Q?JGgiFibCy1k7VsuI2l8FQEArr5CJlN9pVHe8ilr3LkSFO?=
X-MS-Exchange-AntiSpam-MessageData-1: q/s1f3c66Xa2tQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80950415-c480-49be-258a-08df0fc40328
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:17:45.2794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jF0oq1M9JIacX5BYiVsg9MSVEjFMqzAHNDiJWWdW95ONjdg2iMxZjP3hVjDs4Bq2yql+zY1IUc/Lyumn0O/nPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814
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

On Thu Sep 10, 2026 at 5:10 PM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>> For struct-like GMCAPI messages encoding field by field manually is
>> noisy. Add some type machinery and a macro to automate encoding of
>> struct-like messages. The `Encodeable` trait can be implemented by any
>> type to say that it can be encoded into an NVKV `Encoder`. Add a simple
>> `nvkv_encode!` macro that works on structs and encodes each field in
>> order. Provide some base types, such as `Key` which statically
>> associates a NVKV key with some value, to avoid having to make a lot of
>> newtypes and implement `Encodeable` on them.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/nvkv.rs        |  49 ++++++++-
>>  drivers/gpu/nova-core/gsp/nvkv/encode.rs | 178 ++++++++++++++++++++++++=
+++++++
>>  2 files changed, 226 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/g=
sp/nvkv.rs
>> index cbeee7f376b6..10dcbb9e602c 100644
>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>> @@ -10,8 +10,13 @@
>>  //! naturally maps to storing a &str with the GPU name.
>> =20
>>  #![expect(unused_imports)]
>> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
>> =20
>> -use core::ops::Deref;
>> +use core::marker::PhantomData;
>> +use core::ops::{
>> +    Deref,
>> +    DerefMut, //
>> +};
>> =20
>>  use kernel::{
>>      alloc::{
>> @@ -92,6 +97,48 @@ fn deref(&self) -> &Self::Target {
>>  /// The index of an NVKV value.
>>  pub(crate) type Index =3D Bounded<u64, 12>;
>> =20
>> +/// A static association between an NVKV key `KEY_ID` and the storage o=
f its value.
>> +///
>> +/// Use with the encoder or decoder macros `nvkv_encode!` and `nvkv_dec=
ode!` to let them know how to
>> +/// map the value `Key<T, KEY_ID, As>` to/from encoded data. For brevit=
y, `As` inserts an additional
>> +/// conversion (`From`) to avoid having to implement [`Encodable`] for =
many types. For example,
>> +/// enums that are easily convertible to a u32 can have `As =3D u32` an=
d rely on the existing encoding
>> +/// for u32.
>> +#[repr(transparent)]
>> +pub(crate) struct Key<T, const KEY_ID: KeyId, As =3D T>(pub(crate) T, P=
hantomData<As>);
>
> Does the `T` need to be `pub(crate)`? The series builds fine with it
> being private.
>
> Also the relationship between `Key` and `IndexedKey` is a bit unclear
> with the current type layout. IIUC `Key` is basically a specialization
> of `IndexedKey` with an index of 0. And yet `Key` is declared in the
> root `nvkv` module while `IndexedKey` is in the `encode` submodule...
> I'm also wondering whether it would make sense to make the relationship
> completely explicit by making `Key` a newtype embedding a `IndexedKey`
> with the invariant that the index is `0`, but not sure about that one so
> your call.

Ah, I guess that's because `IndexedKey` is local to `encoder`. In this
case keeping it there does indeed make sense. After complaining about
the visibility of other declarations, I should have noticed that one
too. :P

What worries me more is the fact that no index larger than `0` is ever
created. This looks more and more like a bug to me.
