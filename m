Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A730CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6239710E6B0;
	Thu,  8 Oct 2026 15:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oYLopuzg";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5A110E6B0
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 15:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOf5QF7gA5g8MZhKSMfXcIURJKkNyw0KvXtv1WJc09Iu9UxoucJpSOwnsnTCsrF7m9iv4McD8rs8TKVoYoI8wkHepR4VPL/JLaYaB2rZFDjc+tXIY+ARqM7+d7Dl3og3Ef5ILx9lPpr3NML+f+8jMf2tFCFEZVAqnMzWbEBZmtRA+ISRn4jwTQN+abtq8hKiAGioExt3p54kLPQBlgw/g42mNbU/x4d8jxVxO3KLGWUjJIe1GVU+MSHuZNwlvENg5rjqzZYIXWTlOzWXrkm6VwyFoIVSOF5eWR4wEe92QQvE0TABhA2ZqA47TfoLwUUsNUg+3PG5Tr6Q+g3Lx5hbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UQgBt2GBMxQG4lGzEE/gS1xq+2xLtU3OMb3FpxhL2Q=;
 b=ObeRiAw4GVHOwalpB2omR3oqyuhnDFV8jaV9dvPIB7y+7OhDexwWdA3o4yaileVnuH6ODw9ZmbYVTAzahJfrMZbJdoKw22ldIGToi0FJK6RbLH3aGFqjZ/IBACkw9Xboo2ALFb9ZyJGVha8lziEsQvtwa04B8NnJCc3i33YoXrRD61oncVKYohQ+bIv3mtfUfe+Dn6RYl202SzUfbCCCpfSRkLXnWBJmwQ1sT8Lj8kc/NHTWXpxGjQlSv1PzrndA1T32kmdBVCKIkWErTqw8m4u+MBsaCnTUGrN8QmGI/ETd1DJDjqCOoRwoRknp8mjj5gKuxARmXFsIn6uknulcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UQgBt2GBMxQG4lGzEE/gS1xq+2xLtU3OMb3FpxhL2Q=;
 b=oYLopuzg3iPEevna4LUAQCb66zLq+aw9fITpe9pZ3cHGRana4ffKklyez1JK0NkSJ2qrjDnMJhOCpUZJ2bMIrdM0jA7NDdn6anaaID6cAb7A3N4V+nmsd11aWiEjZuNuAGQO4EK3kUMRYgM9Oc0Kye6pHM4OT17wLZsRsb/HVS8bUisZuZH/yKlE7jZHIk0AP5kO0xT/Q/jb9r8G639UhCafPH2vmZkQ1pu3t3e1bH9+5vbZ088sYJZgYwXjQgeqNtbjobLvS4QQha3rYpODUK8gj9HZLFngF8tMBLGhzuc4+vbMc3JgFRR9jSBEdL1yRMFmnezkGajys8CH5QcuQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 15:02:55 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 15:02:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 00:02:52 +0900
Message-Id: <DLZJQQV2BFNE.UQLPM72II2NZ@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/2] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260917-cv-v4-0-547ef5727451@nvidia.com>
 <20260917-cv-v4-1-547ef5727451@nvidia.com>
 <CANiq72m0PLhT=-ODzQtX7k3jn6=XXpESDUbnHcAmR-1gFqR7uQ@mail.gmail.com>
In-Reply-To: <CANiq72m0PLhT=-ODzQtX7k3jn6=XXpESDUbnHcAmR-1gFqR7uQ@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 452d4f7b-c250-481c-94f0-08df254d3b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|10070799003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: HdMAiVUw5PuSbJ6TrujMInHESU4Y5EWch8fOCi9YlxfeXmwo82MVAM0ZpX9JwvzGsit4oMn6c2Mu/ORwe8Ts04wT8lY0+oqIQEZP3M5/W0E4Z4uifABUjbRuC8O6ez8iG7yLhSJb4LoQiGXE/SQNFTK1yElbopvQW2RHDLAi7gFFSKV9NzB4oJfInpMXiGp7Nm4Q7NImyBdLka864MlIjIz9Qpm2CKGf9vB6d3x41vC3h3wtQnt8f0OYBqySoJ/YXNIRKEuhrGOmIqd61NGJA9f8UZnGkQQPKQ5XFJEPPbKCgRG2REcxAuSsX0yXQE2iAgHyOvoBMDamoVwFNrLFVzt40j2Mb8DH9mB8JgOywdb/5pjZarx8dPru2Lox3Jq+ejCPKmjRkW+kM+YTcT3JDmMwgTz4MJv+BgSYkCy0qlEq9Eb/6hhz056aXMyZzOwzvJwu2nC8aTWozdGAvgOeS9VqMS9y8YWUQi+hEMqV2rSnRjb8Oj88CyPV6l16y4PDq/ctbxU1mkS+rCHNlffS3gkEUnDYKdZZzDHn82fNHRcKC+FTYtu1O2GOf4OvNSRckI+VLNl6K2aP+m+3JbnPNs/xrB5WaVT/52DSEDQG10OlvPRHS8e6vP92AYDp4ftgvMEnL1ctgXJ5JU1PAs0Y4SuSKaulDk46wlssXjSor0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJwc202SkZTMEozOC91OWFuek9tdXRqYVNiUkpnNFRjaFdMNHY0TmZ1S0V3?=
 =?utf-8?B?ZmYzQ2xjUkVSYk5PSmRiZHVZMjMvcjlNdzBoTVZvajhNa0Ftajgwa0s5Uk4x?=
 =?utf-8?B?Z1Vpc2hka0hpeFNQU2Q1eEVIVUhWUmxadW44T2xQNjdwTnhaNWM2c3ZRWDhW?=
 =?utf-8?B?dHMvVjlJc1Y5OWVMZ0lLbjgrdTlWcGorY0lrWFNmK2ZYQlRsbVhHd0VXOFQ0?=
 =?utf-8?B?ckR5ZHc2REMrRUVpbnBwZTRnOUE4WDl3Y3oyY09hQWgzZEJtMjJtbFB6L2ti?=
 =?utf-8?B?eGpYcmtsTGxocUZ4R3JYWEQ1V1pIcjA4dWlqWENEaG92UzlReC9WdUJVZ2Ru?=
 =?utf-8?B?UFhEY0hENS9STVYxTHRkdjdCY2Z6dWlTQldlYTFjZC9aRzkzK1hBYUNTMllB?=
 =?utf-8?B?Yld4ME1OWDY1YU9KQVhBUU5IRjRZaDhKS2NMblc5cFUzSGx3YXpXdUg5a3Jq?=
 =?utf-8?B?aXFMYmNoY09RRmJXclhoOC9rOHNzeEdROFc2VU1acFlKNUdESFJVZk1ySzI0?=
 =?utf-8?B?VkxEclJZOU9kWXJUQnBGWWhKNkloc09CVW9oTVNBb2tSRjBDRDFEMU9vbTJs?=
 =?utf-8?B?MStzTlhOQXYwTXFvMVdtUHRMT0ZXNjBoVC9QN0d1SDA4cGIyeGN1alJzUzd1?=
 =?utf-8?B?MGQyS3dzOWErdHAwYnE5Vit5L0tXbndhMWszL1dPSDB4Rkx5dDJ4eDVHVks2?=
 =?utf-8?B?cnlDdFBqbWpzTEtUWUlpcjZEK2xoeWVTRloyWjN2SzhGWWpXRzAyNjV0TnNX?=
 =?utf-8?B?dkJEUm1LckEzQ2VTdDRQd0U2eGxuc1Z6aUpzSE1pTWJvVFJHeklDdFc5dEtY?=
 =?utf-8?B?ODNvWi9nNnNnTDZLaFRGVjJuTGNsNmtUSUJQbHBnRmdjdGp5cVFpOVFQR2hX?=
 =?utf-8?B?WVNpUnVtZUxMY3dUS2pwVXQ0YU5OU0JyT1J0ejBZYUFIaXlnRFB1YVZQdWY5?=
 =?utf-8?B?WVp4ODBoQ05FZDViTWV4cXMwbjl3S2w4RjVUUG9DdFdWRDQyTWY4NlRSTk5t?=
 =?utf-8?B?VVQva0Fsa0VNeUxjZS9Vb1dxa3JqOU9GZ0V6T29CNC8wTmtNVzB1ZzRwNDE4?=
 =?utf-8?B?aDZnSjRCRnZzYUljekFiVUVWUFFnNzZlbkpwenNiQTRZTUpBUFJmcDVBOHJj?=
 =?utf-8?B?MFVTbUFTdWcwclN6c2g4dkN6Ri9MYm5kUU5jTEtPRXk4Y2FQSlJaODNVaE5l?=
 =?utf-8?B?WjFSZnU2V2RNWkttbW1VVlRCeGZTZTY2eWdLa2ljMUNoYTdzbVRaYndwcisw?=
 =?utf-8?B?bmdRQnBydVZOQWxYeWhobE85aDNweHpGbldoVU1WU3ZNcGx6THVERHI2TjlD?=
 =?utf-8?B?TUZKNEFja1NBY2hraVBxOXhRR2pucWlTcTFLYjAxQUw0WmlnVTN5UEJMV1kv?=
 =?utf-8?B?dDZQOGVVY1NleVJzTWs1ajJvUHpzdVdKQ1NNcGZ6WVJoYjJubll5VHNHOW5E?=
 =?utf-8?B?aUVIdVBvbnhKUENuS29TOWd1anpWaUFlSnpmam8rNy9KZUt1N040aWVWalVn?=
 =?utf-8?B?a0I1MytldjlRMW15UE11dGdyaE0yVmlGSlh6RmtSaGFPL21CRDg2QWxDdnJI?=
 =?utf-8?B?U0g4Q2UyeFlxdmJOZlZYV3VoQitZenhNVFNVQ3UxR1pXZmg4RjRURkFBTEpo?=
 =?utf-8?B?U1JqTG4rWjltNHdxdGdnTXFldDIvM2VzT05YamVmbE9zK3FJT2w2aEhSOElI?=
 =?utf-8?B?VzBnTThCSVhnT212VFI2eXFBRGFPcXlhbUFnMkRRbE5YWTN4em1wNnYwUTho?=
 =?utf-8?B?SHorMU1ZbXJhTlM0QmpvaE10SjRkelJrSmt2N0c1U0tBb2hCVlFvd3FVMTgz?=
 =?utf-8?B?QWlUYTVHTk1YZDZYbDk4ODRtc2l6bndOaDBEai9LbFhveFJrU3Z6U2pHbXNj?=
 =?utf-8?B?bW1qMktPRmZ6b3ZYcVRlZmpLMkRPWnc2Rmh4bUhFTUxqaG41UUIrR3lSZ2FI?=
 =?utf-8?B?bThvVS9hUmYzZUJtOEZXQ3drVU1tc3VlU3pHT0JId25aUndvd2d0MlBJUEUr?=
 =?utf-8?B?MUU2ZzhCOHY5Ly9heWUxa1FBN3FuZzBoVGwzSkV6b3I2cjJNZDhjV2xhQkNy?=
 =?utf-8?B?bVozNzI2QTZNTnpZb1JDbXBPWmtReHIzNHpjMWVsV1Vnb2RuUlErZkhOaXN5?=
 =?utf-8?B?WUlJSEZmY1NBVmNDdzlVOWVuOHlpUlQ2ZGhHaWU0VlMrWFlHTkxrRTNiTzl6?=
 =?utf-8?B?VnY0M2RIejJoamV5OU1wQjN0Q2xsaGpQMW91ZXZIK0NIQURQMUhuelE5M1kr?=
 =?utf-8?B?ZDVmSnU3L2pxKzNQR1Z3alIrL2hpVElKQ3NUQmp6bXlXb0tkazgxd1JXVGxh?=
 =?utf-8?B?TGgrUHk5dmsyY3FXMzJUN3d1bnc1eEZUVUw5UDFFZkFSOUNPcjBvQ1AxRi8w?=
 =?utf-8?Q?NAsm05Hw6r2WRCk/4JR4A7+D0BHT7FWdsNtJ1m4sTfqUo?=
X-MS-Exchange-AntiSpam-MessageData-1: SL90zpIZ+VnllQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452d4f7b-c250-481c-94f0-08df254d3b9e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:02:55.5015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaffYMYgpmUsSmSwpJxAVheNUm0XOSlmjhSfrDPzOwepfO7aAt65ReOrPcbrgqAV1HuFLqAtoQBC5wASY9tT3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

On Sat Oct 3, 2026 at 1:59 AM JST, Miguel Ojeda wrote:
<...>
> One thing before that, though: are these assertions expected to fail?
>
>     const X: i64 =3D 1 << 31;
>     const Y: i64 =3D cv!(1 << 31);
>     assert_eq!(X, Y);
>
> Or:
>
>     const X: u64 =3D 2 << 31;
>     const Y: u64 =3D cv!(2 << 31);
>     assert_eq!(X, Y);

I have tested and both fail indeed. However they pass if the `cv!` literal
is annotated with the correct type (e.g. `cv!(1i64 << 31)`).

>
> Because that is quite surprising, especially since we say "with the
> target type inferred from the context" in the documentation.

The target type is indeed inferred, but the expression is typed by
itself, so unsuffixed literals default to `i32` as they would in a `let`
statement without annotation. That limitation is inherent to the design
widening to `i128` I am afraid.

I don't know if that's a blocker, but if not, we should probably have a
`Pitfalls` section to mention that explicitly.
