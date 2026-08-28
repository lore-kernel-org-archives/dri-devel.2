Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93C6C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:16:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047AB10F177;
	Fri, 28 Aug 2026 09:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SZPtPrzj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4EB10F177
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 09:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWZ7ZAvEpJtVhD6EqE7NRBNzMc/qjtPUas/HJEU4gGCs6lEfu/b37aCC8zkX0DIzjr15VJv96txrRURgz5idwWdvISUjAs0518ieqUhswZX82TnyTc79WGC8BCindSWW2KJ5clCtyg5TO2H6zRUp8Sp/hTGiOQghAOtJv2RZ+bYIRXt1H9sUfkI//+W4qQRhgxz1iLhw+QoZTAwcgLehIYhqxC/5ltqbzOyKL83LkbPnVCQyiNSXgj6ImNNFrkU4FLXdns+t1ektXV1xZegxe6MtRUVhsjSv6TYYP3N+1zzdItbzX1xj83sUXXkKCXkpJBeHdN0+hsm0HwYZ+wND9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IvcpyDCEjK/RzPKIU4IfbLhVXrdRWBuYnVshRvjdwE=;
 b=XEyndqUhRkJSjZ7vBZsZ62Kv2kOZ0e+lI7BEY9v2NEJyrrIkdIl7QO7+VxCZ7EYrEFxnzIW8h00gkc7pfbYf27vtCTQ9l/r8n5E9bgwHr9V4WDJU18aNFqT7c+NUvJHwsRhZraV11tbEjstVPOR0fejCD+UwilUjXiPMsO5emQ4pzCF1u5cpSxcienf+2u5ImlunXwQfKwLWW1HdmO5yxOQVUj+qcVYUaeyBkUDHfNLFUHCyRuV+DNoKPvBi387sQyLsAkboQX9iNAo7c8ey0jUMPK/S0f9AO552R3l/ugHlIIBuHhKoOdRdg6ALFvDeJWaSoTsbWqYFU/8RZ+DYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IvcpyDCEjK/RzPKIU4IfbLhVXrdRWBuYnVshRvjdwE=;
 b=SZPtPrzj+hGzJCPMAJ992X65XrtNh0SMxJ6EEJOaNL0syAlNjrHvXkNTt8FwMzej/ENhmh/m7j8B9EHbqtHVVfvQB4PyznTab8KJC8ncx8U1L93jImChqaMC9abyLsbCW9EFZh6+eDfCcawpq99LCyAFj2OT2SqtRfTunVot4BzapjQuleOHQWJFyjyuHs4yg/z+2iXxBz5d6pdTuM+2ftxrYU9JjGr9E5ho3G0OxeDf4YaOaVYWTeClyrsnJsYMMSbWd99REA/fLgmOvX38KqrngzIX/yMB5cGZX2mE6q0Z3A0weSYvo+V01fnO+EhaNT00tcgGgxub/3418uCZ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Fri, 28 Aug 2026 09:16:37 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:16:37 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH 0/3] rust: introduce cv! macro for safe const conversions
 of integer-like types
Date: Fri, 28 Aug 2026 18:15:55 +0900
Message-Id: <20260828-cv-v1-0-48a180dfc4c8@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WO0QqDIBhGXyW8nqBm+terjBhqv5uDatOKQfTus
 zW2ywPnO3wrSRgDJtIUK4m4hBTGIQM/FcTdzHBFGrrMRDChGAigbqHQSawr4R2XjmTxEdGH1yd
 ybg9Os72jm/bl14j4nHN9OrR/vCl+6WFczGWYe6okcisQpNe64XvAmoTUjX0fpnzOamCaGYNel
 RUXCsCg9daBKFWFvu6UUsxz0m7bG8QpNcPhAAAA
X-Change-ID: 20260828-cv-8d4e952fc14c
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::17) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c4c6be-b02b-401c-98e5-08df04e50fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|23010399003|7416014|366016|921020|4133799003|3023799007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 7IXhZb8mOcsVnqcJthWlO2uzpChaIpFmtDRxT+r1PGYVUG21Wd/KqbIJsGD4i6g1oYmzhsMGWiHxFFTbjbc7avtQObtzsbFlvMKhJbUmR1l3bTPLpgmLYSdch9kqu/E5vbclO5JbYJIpQxcqvUtcsaAp2MZ68rKIpu3DfZ/UYhDDyR6/DspxFIJu76oOUl8ig+M8u6Ouwi3XfapAxgKPAXKzpBsEYXIdjT/qhP+GoMxTzmBy1RN8EJrqhlm0znNrx9EJ6C6dYH6vzB/4CwVmoiaEsr/VvVIXmqJMNmsjoHN2HsqAtr3CtNYIpwwbUEW6WtnhBpLrJ1cTdTzQ+1CUD3txCwoS5WCqGDQQeU6hod467NXdwb2xAsGgHGV+EW8GLEsiJRf5pVO5kGyhUvIlCyyud6fJSZMnTueKk2IgZO1DpU/NUhnvUzQu2dV/vcHofUwW42Z7T5mcfUzQI30vmOBidLMJGBuAt65Z7nZ+0kWzJBaF+oI62dw0hrZRqM8zbJOOk0hCLmw3xxO7zhNoRvb2bZkXTMaKRTItfx8suDeumFpFyYl0LQHnixA95tgfPgYfAl9yiOLs1fpxnHIgsUzlf/vqffwKRXQzyZ9YIMmFXBfv/q1fVXmPj/kzI9nrCduQQJtgJoPhnia/XVvxn3dtuGPhlzThsxF3VqXcDGMQpuSurc1rQ3aUo2cEiL9Qv8q5OtLTZ03dIbnX4q/Flw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(7416014)(366016)(921020)(4133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZ5eG9nQlhLUVJkNnJIVTZ2UkV1bnZvS0UrSU9HV0ttV2xyd1FCeWszWERy?=
 =?utf-8?B?OTRuYkpLUDhzUFRGcHlKZkQ5Z0NielNzek1hOVVlUWF6dUV5T0c4RnAxVWNW?=
 =?utf-8?B?TUk4SkxWSFcwK2VmMEorTjFzQlpNUTdidjREZkVDbVhaMlRQMGpQT2dSbEZ3?=
 =?utf-8?B?aHBobkp6OHRqTW9oMjBIb0FFNWg5alRsZEZGQ3VFTG5uTlplbG9jaDhtQ2Rz?=
 =?utf-8?B?cFhoMXVFRFdYWlZoTTZpWnV6ZFlxTXZ0eUhVamZYOGVRQnN6b2NrU0JBNVBv?=
 =?utf-8?B?V1FWdFd3KzhRUTBmaDFBSXYySVBkTnIzdmljLzZFZkltNmdzZmFrcnBmVkEy?=
 =?utf-8?B?REtOTHEwUGkzZXlzb2d0aklXbFRCY200Mm1LUHZhRmRtUy9JQUFjbXVYdkZs?=
 =?utf-8?B?dVFuR242UVhmRTNRazcyTk1sVHJNU1FaSXEwNFRkU2c1SzVFZWtsWFc2aXJr?=
 =?utf-8?B?R3pZckhOOGhQbzVqeFlWeDJYSldUMExPYndiNTVmNHM3WTNNWjU1TTd0dmpl?=
 =?utf-8?B?K29nRVh1K2VSTzlsRCtqZjBPOC8zbEtDRVo4eW93TFdxenFJcnZEdjZWZUNN?=
 =?utf-8?B?L2owS3NWQk9hZDVLM0RSbXplYnlFR2lnbW4wZXQ5cGRoSUJXemhadlpQMThk?=
 =?utf-8?B?a3d3bXp6cGRXcVh4NGI5Mzg0Y2NNZ25JRHZSQ0huOUxUNzRtSGlYZE5UNUt6?=
 =?utf-8?B?aWdROEZHbGJBRnNmSlEvczdYYkdWYVg5U1RWY1JSaVBiRTBHTkhuRkpFYmpN?=
 =?utf-8?B?bGsvYnlKWTRTZ3JRNjU1eVVUSzg0WWNYRXZkYWQvaEFTRldMbVlTdUlrTGRa?=
 =?utf-8?B?cjgyQXZhWTEyakZSclM2U0Y4aC9ZK1gyUm0rY05QQXQ2cmh1bW4vK0UvSWhZ?=
 =?utf-8?B?TzR3MHUyZ0h4UEV6NmdQRFNxbURiaVp4MmluSjcxZUtKalNTNGl3Yk9WUUhZ?=
 =?utf-8?B?dk1qUzJIcVhNOW16aUJvUmhtZDBMQXczUkE1cmticmpqQ0dsTW5iLzdQRldR?=
 =?utf-8?B?VllvVm1wWFRBb0xzUnB5TUJrYTgrQlhNNzNqd090Qko2MzdGYW9vZ0NmMXQv?=
 =?utf-8?B?T3FKZkdKbk1yWmJubkFHcndGaFpyaUJYVGRDTC9YVnpkL0FTdng4SGN1cDBH?=
 =?utf-8?B?ay9oQjZrTlBtVXJja2FMQWtnTnJ1eG5Cck1OYVM5RVpCSGpWL1BRWklDaGpL?=
 =?utf-8?B?clpkeExjbmp0WTdlNDVhem1GNGs2QWJJSzVZOC81dFBaUm10ZGRuMVRHU3hi?=
 =?utf-8?B?Ykd6U1ZKVUpzSms5Q091Q1NKUGZwMmg0ajNGU0xUdDJEaDNoMjdRYnJvd0tT?=
 =?utf-8?B?MFY3UXIxbmdMbklXUEZZa3RJQk5nR25DVlNEMlVBVTV0T1ZMcnBJZjZxcEo2?=
 =?utf-8?B?cTVUT1RoUWl6dExacllNQitYY1ZhcGYrN0ZseFFpTnpmQzVnVzA1LzNrZkk0?=
 =?utf-8?B?dzFJMGxJV3d3OThtRWM4ZDZNdHhBRkttY0JYek16V1FOeDI2M2JWK2dpT1k1?=
 =?utf-8?B?YlhMaDBOR1c3V2lIaWcyb3BvUnVUN0xNMm15V3pRMDcra1B2S2ZXQ3F6QVQ0?=
 =?utf-8?B?bHV1RjZMb085dE5HeWhyMndhem5WYS9xWjliTElHak0xMk5laUxNWDdLSjFK?=
 =?utf-8?B?bUx1YXB4S1V4QTFYWG8xVEVSNjc5c3F3V3JOdG5yNGhzZ08xOWN6RUgvWTNm?=
 =?utf-8?B?NjdMSU5nRHN3SmcyZURTeVlYZ1RYNm1LdzZYdEFXUFhYb2hJTlBZNWdISVJ3?=
 =?utf-8?B?azQ5bzR5UjQ3VnNwVng5R1IxVE5rNThIcXRmbk1tNlNpSFJ2OXdPMXpjWndK?=
 =?utf-8?B?QndvZUNiNVZ1VEV5aWlyY3dsK0tDcHZIeVpyS0U4SEgwVVVrK1RmeERZRTJu?=
 =?utf-8?B?azMvUzdnZSs2Z3piSlN1RWJQRktDMk1FelVPVTFPdlRPa29wMDZEZmhnSURa?=
 =?utf-8?B?Z0hEYWpOSmRna0Y5VlFnWkxQMEJBZWFRckllSXAvZ1VLOGwvakF4SXpTZWhw?=
 =?utf-8?B?NmJRTHZ0YUtxZzNEQTArRkdhMEhtWWs0MlBEcjZ3RGx0dVlrcnVIUzhiVDJC?=
 =?utf-8?B?bHpjWDltSjJnc2JkMng4MEZBVFRjMkMvb0ZXVFQweHhNYjNSbEpjOVJrcDg5?=
 =?utf-8?B?U3YyN0xHTTZWSVhjc2VWUWhteDU4ZjF1RjFCYlBPbTlXY1J0SU8wajd2SmRz?=
 =?utf-8?B?S1EwSDU2Ykdid3hCdHZ1QTkrOVdzOE9vR0FCN2J4VkZoWEVmRVVhY0xGUWx2?=
 =?utf-8?B?MlZpTXIzcTZrbUxONTFrMmpKdURNSmdVcEtjTjdOZzBLaW9TR3RPSWpFOFZ2?=
 =?utf-8?B?Z25lT3V0Yzdad2w0VlNWOHJ1eUFzQ09vMDlucHpVWmJ2V3BOVnBBZEZCTThu?=
 =?utf-8?Q?7ZG1IWvmJUrmCKFRqT3svEiRr1DewnYohd2yzSfDMMqr5?=
X-MS-Exchange-AntiSpam-MessageData-1: mllVCgA9BG2tsw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c4c6be-b02b-401c-98e5-08df04e50fce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 09:16:37.0749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1Krw0dmFVP8b9WEzDR9MMjkuV5GxxDxkKf/H7GNoXDvEjUv74ogbQHZ/aQiyYO6JauWitJHSgB1cWCm20AO4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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

This series introduces the cv! ("const value") macro for safe compile
time conversions of integer-like types. The syntax is `cv!(literal or
expression)`, or `cv!(literal or expression => type)` when it needs some
help with type inference. The result is that many expressions can be
rewritten into a compile time safe (no `as`) and less visually busy
style, for example:

```
- const DMA_LEN: u32 = casts::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
+ const DMA_LEN: u32 = cv!(MEM_BLOCK_ALIGNMENT);

- .with_const_msg_type::<{ casts::u8_as_u32(MSG_TYPE_VENDOR_PCI) }>()
+ .with_const_msg_type(cv!(MSG_TYPE_VENDOR_PCI))

- data: [[u8; GSP_PAGE_SIZE]; casts::u32_as_usize(MSGQ_NUM_PAGES)],
+ data: [[u8; GSP_PAGE_SIZE]; cv!(MSGQ_NUM_PAGES)],

-pub const NSEC_PER_SEC: i64 = bindings::NSEC_PER_SEC as i64;
+pub const NSEC_PER_SEC: i64 = cv!(bindings::NSEC_PER_SEC);

-//! let b = Bounded::<u16, 5>::new::<0x18>();
+//! let b: Bounded<u16, 5> = cv!(0x18);
```

This works by defining a trait `FromConst<const V: i128>` with an
associated constant `VALUE`. Then each implementor sets `VALUE` to a
constant expression. This works around not having const traits. An
alternative idea from Gary defined a FromLiteral::from_literal<V>
function [1]. This version essentially moves the implementation of that
function to the const block of the associated constant (since it has to
be executable at compile time anyway).

This is based on ideas from Gary Guo [1], Alice Ryhl [2], and Alexandre
Courbot [3].

One (potential) limitation is that const generic types or values can't
be used with cv!, because it requires the const generic expressions
feature. The const_as! [3] macro did not have this limitation. This is
worked around by special casing conversions to language integral types
in the cv! macro (essentially subsuming const_as!). This special casing
can be removed when const generic expressions can be used.

Some code is taken with permission from Alex's const_as! series.

The structure of this series is as follows:

1. cv! macro
2. updates to nova-core to use cv!

For a follow up series (I've already written this, but to avoid spamming
a ton while we iterate on cv!, I'd send this after):

3. updates to various other code to use cv!
4. misc updates to other code to remove usages of `as`

We have multiple ways of converting - T::from(),
FromSafeCast/IntoSafeCast, cv!, *_as_*. This series uses them in that
order of priority, based on Alex's suggestion [4].

This is based on Alex's series moving the safe casting code to
kernel::num as a prerequisite [5].

[1] https://lore.kernel.org/all/DKT6WNPI2OA5.3RCBNYHHAFAD9@garyguo.net/
[2] https://lore.kernel.org/all/CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com/
[3] https://lore.kernel.org/all/20260825-const_as-v1-0-1ce712225fe2@nvidia.com/
[4] https://lore.kernel.org/all/DKYTZNAX6ON6.1K1372FFAQOF7@nvidia.com/
[5] https://lore.kernel.org/all/20260828-nova_num-v1-0-e21f17ba4127@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Eliot Courtney (3):
      rust: num: add cv! macro to create values from constant expressions
      rust: prelude: add `num::cv`
      gpu: nova-core: use cv! for constant casts

 drivers/gpu/nova-core/falcon.rs                    |   7 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   8 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   7 +-
 drivers/gpu/nova-core/fsp.rs                       |   7 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  11 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |  39 +++---
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   2 +-
 rust/kernel/num.rs                                 | 131 +++++++++++++++++++++
 rust/kernel/num/bounded.rs                         |  20 +++-
 rust/kernel/prelude.rs                             |   1 +
 rust/kernel/ptr.rs                                 |  12 ++
 11 files changed, 191 insertions(+), 54 deletions(-)
---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260828-cv-8d4e952fc14c
prerequisite-change-id: 20260828-nova_num-64e1b2e84f77:1
prerequisite-patch-id: bdc5c281f930f98d9a94ffc093388100d4871969
prerequisite-patch-id: 2be8b479662642016bb697332ea61d58ca54cc08

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

