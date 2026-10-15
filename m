Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC9CCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 01:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49ED610E1DB;
	Thu, 15 Oct 2026 01:33:24 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03EF710E1DB;
 Thu, 15 Oct 2026 01:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agTpnnZgoNiLLTbqsRrs94BRwzqTz4kQB6XVKOMIxAJegqZ/3WJvmWAaYWBoaqWc3ptwaokXKl1Ev9vYJaiyUT70danSGQ+5+ADfUmClFTHav8L1d28eqZGFvZ9bW0iPU4JMYMHGRedRMCAS51yPUibFnYgRIRpiMDHiw8aHTCJInso/IjQi8tbHAUmqKXmWASplB+aNQ3CiQj4d+o4VJZB20ubrGcAR2v+Q5WDtnLcBZ45ai1PILASaUl3+ujfyI55Eo+9uy0Lt99LSxFlo38GXCaXxYyedlHkcEVO4JUO3YynYWyCt9M/yfW5cGtraVhT8UDd6EtTACh1FxlNihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0py5ZYysNLER5TCYw/drBkHoJiFxfW5uxO7/toLiW/Q=;
 b=uuPbRYcdZy/fZ6YrlkpE16uBYA0QhhfShlXx2NYeXKFd0boW5C1PDt+dZm8uKQ3GUYi9476lOZoyBGsML5ged/s8PyQlt0TlvEw9u9nWerVtzXPcmwccxVekraIKa/IxXCPHioefaYx2+LC26c/f5DDu2qpjWBVQ3uOT5NBPMsSDkHaVjI/9ZjSGGlF8h0Tqlbz1YqZWMsPuXK+Q8UVyIWlsotFr9yQ5x/BeKWqkSVlTSqpNRAQ3ImZbXU8TqK6rNWaFxvhj5tURnLAOy2dVjc0FDCnioS/caBGREaLTjRDsc8IYe/R/mfz5pNTHGUr7F8e9lniW+UNsgNUj/W/Crg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0py5ZYysNLER5TCYw/drBkHoJiFxfW5uxO7/toLiW/Q=;
 b=DhveExgtO+uYtC3Ii+vB/1vtTvfIB7XaQkZJEY3aFtdiAsy94O3ECFUN2KqZO+md+1ZyIzg6/jt0pHrIm3ABztWxHZKuCHChNOXiVV7PJGOpejhZQNENern2mb4QCniOQGdm9JKce8TxO7qmCp/Pe/WBe82SHVVfbmCCqqulTCeIzSW3S8SsO7piXXsvJX71XLPFOU4fYWvr7oWVnnv74kt/rVBLpzb8IB5qN/a1xsqfUCCAVOafUIxcz5wVch2TSMn+Nk7/Gv3BxEtU6gikri1RvwnDZn3FB+UmeRMy0BdpZvFOo7PKpGbkzvysHOmgtnkJ3WqEEFVpxNvdxmNx7w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH2PR12MB9542.namprd12.prod.outlook.com (2603:10b6:610:27d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:33:10 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 01:33:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 10:33:06 +0900
Message-Id: <DM50WK54LKD7.1YGZ0JEZ9KMG6@nvidia.com>
Subject: Re: [PATCH v3 6/8] gpu: nova-core: add NVKV typed encoding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
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
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-6-f04504c262c2@nvidia.com>
 <DLYE7KKATCU6.CUH7GIJJJ9PW@nvidia.com>
In-Reply-To: <DLYE7KKATCU6.CUH7GIJJJ9PW@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH2PR12MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 315038e9-41fd-4126-cff1-08df2a5c459c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|7416014|1800799024|23010399003|56012099006|11063799006|4143699003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4J+nQlEfqKROK/2YPlGDKRDeqFIQgizy9qUHF1S88tSzdp9fwR62oWYLTBwjhwNVr7DgkkbN4ZMFjhfvqPuGT2shRna0oFeC7bdiAUoy4yKjbm4CGFWhf1gM5RDBV7Of2w2vIB6Nd3+ArY3NsCCT5c7x8bTkY2pqs3aFtaqH8k5kqtgVY7gF0YS6tUJgEObuXAf+eq2jVlyJ1qmndmIT3L7cqDrxVi/13IfnCwryVpABz7POec39lv6XrR+ajs3Oy9ZCEfJeSlh70KqbVySGmf3z39roEHKJ+zZCikMzevgyIq4t5hAIyDNQvmUKUSXq5BU21fUbyIJI5qWhc4/tYNkRJUEIbgj8A4nudumir+IGYmMK1nB90akY7VvLj9lcceJvsVfmXJZ87te3ge608NO9vzTFVBzuLgUlrRpSAKhtqLrD8Rn1/vOJUhS/zz3s2rsG5Okk7Wwkj6rWFOnSvWCTfz9b8KnvycYa7KANfLLM13J3l5UD6NwhZLvLNNo4XaCm+UUvJkvWxBaPpKmP+yhogvHUCJcvblaR1Z9GglownkxEVVd9hqU8iZWT7ZE6501tCFaLcTVwzJkZKK25BHPqRnDM/Z2zHfAy2rQ900qBu8F0igilVP9Lu+i38SpO9KVX0JENgIaHSnCWTiI99+BpDY8qirYGkymeOuuv+tU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWREcGMyNURoRE9xQnBuR3dvRVVJNUZCVUZuY3RYamRFcDJjQUxZVjRZaUtJ?=
 =?utf-8?B?RFJxamZVV2ZYM2VyQlkvM3E1VkpIYTNGYmxCNHJManR3RW0weTNYbTg2NlhD?=
 =?utf-8?B?RE92OUdxUXZ4TUdQdytQdVErTkJQWk43VjAzdExaK0xIckJYdnBwMHUwQ00z?=
 =?utf-8?B?K21VWncrTTNGREZlTzZaWTAvbmpTNzMvSGtIRkNOVG1DcGpGTkltRGFocG04?=
 =?utf-8?B?NkJLeHc3UnNCUHpNRFk4T3h1Zm01MGp5WHdWVUdSVUdGMU11Vzc4OVIwR0lv?=
 =?utf-8?B?eU1Sa3FNeTcvZ3JMeDZ2QWQvak5ENzlqdmpmQzB0V09JR0pieWVxbFowWVl6?=
 =?utf-8?B?dFNtYXByTzhOTzZxQTcxMitQdGY0UUcwRndmdXF5SWR2Y0NnN3dUUEJmNTRZ?=
 =?utf-8?B?aW52Nit0MWpuY1h5eEwydC9NTjd0NG9DQUdMWFBCTjIrOHRyUTFvMm9pYWh5?=
 =?utf-8?B?LytWZTZRKzJJTGhxS0V3ZmZ3eVlCUnIvVzE0QW81TThjTXQwbFBQYnNsNlNn?=
 =?utf-8?B?cWRza1JmM20reWZtS1hUcXM2WDlrRjhjOGw0dEZIaGdKaC9kNm1LQWY0SXVI?=
 =?utf-8?B?TUtkN3laM1Vta05JVTNZOGdsSnBoMmRnR0k5WHRXdGc5OUR5OXlmQ1VGcFBq?=
 =?utf-8?B?OGxYbnRDejJEVWhpRGJueUZ2VnI0VmlsMFpFaTUyUFkrN1Rtdkx5UnRwZWFY?=
 =?utf-8?B?bytGU1paYTFIbVEzYitJRGVMMEtLeGc5UWx3dno3emR0NGVJWGpGU0VUZ0Uv?=
 =?utf-8?B?UG9IY2VKOGEzN3lIMjRSNi9pd0ZxTjcyTHd4RC9yTTBMYklGa3RSKzg3Y09K?=
 =?utf-8?B?VUdXSkNaUWQwZmZZOFVteURTT0JEbk9WQURqTkdmaEQ2VlEyQ3dSMC9vSDhF?=
 =?utf-8?B?aktRSGF2ajEvNjcvWVg4azlBL0JiUkJtcndLSFlmcG8zRWs4RUIzeTVGTDFI?=
 =?utf-8?B?TzVRM0tORi95ZWRFNHltZVN6dTUxUkJVOWJ1UGFrOVlhTG8vYjlmTlMxYVY3?=
 =?utf-8?B?Y1IyVStUb0Y3SUdBVWdzUVFOL2lRbjc0N1ovYlM1K042TU53WEdqLzdaLzFl?=
 =?utf-8?B?MW5DS1dtZ1NQQ2tPMHFlenE0VnVjWFB2ZlRSS0NYMWNjbVZDcUVRNzl1ZGNm?=
 =?utf-8?B?bUhraEdNcWphclJ5MjVvT2RHcTRtYm1UZUdJdWh1RG1SWXVlYytuRXcraTVt?=
 =?utf-8?B?V2x1TDRLNlNyT01LcEw5V3BWSXphQlB1VFJtaDRmOU95WHdIZ1JzZU1ab0xC?=
 =?utf-8?B?cmovSTNQOEgralpycm9OcWZPaXFoVDBRRDkwdEs3YW5VMEpMMTNwQmhCemor?=
 =?utf-8?B?bkJnYlkzbVFWZGNrcGF3VHRHenlLby9zZ2RSK1dUaDZYcjB0aDVQREI3YVBB?=
 =?utf-8?B?MForbGoxTGx5a3lwdzBidi9DZEs5SGF2czMrNU1DakN2Ky9YbUpIQTBwdVFN?=
 =?utf-8?B?YmI2Q1BRemhScUFsUjh4WWp1QUVUb2p1UGRGYTlCcWdkT2twMFVsaldBSjcx?=
 =?utf-8?B?TDRHaHptcG0ydGd1Ym8wYUpxekdabUZGbFkvbU1KeEErUUZqZ01Fc290enFB?=
 =?utf-8?B?Q3dwUGhONHdCWXpTUDJ6ZFNDVnlxa3BlUERWazZDdTdFQnBad3IrODh6Nmsw?=
 =?utf-8?B?SStTY2RKS3RiTDduZ0NGdE9EOEtyRVQreEJyVjdLWnZrek1CUGpUd2RuaUs3?=
 =?utf-8?B?OERjSmNuWkExOG95YnprTFhjM1d5cERoMW5zam9uSERJejM1SlFaeHhIcEs5?=
 =?utf-8?B?aUR2TjlKVWdUM0FDNEdCdHJMcE14QXBwZTZvYk1rM3c4MElkZjMzWjNKa0l0?=
 =?utf-8?B?VkdxYm9GRnR0UmxDOU1RZXc1M1JqOG1hSkNBVWYyYS9nR2N3VWFRc3lZWXA5?=
 =?utf-8?B?MVYrbWJxTWNRN3NiaDBzQURBZVFtVjFKVzdxVWIxZWJyMjdSYk03Nzl6Ry9p?=
 =?utf-8?B?VllFaDRWNzlVckRaVUp6ZStnV2cvMkUzaHBGOS9Lc3RmQk9CM2NQZlhPYnRi?=
 =?utf-8?B?bjBkOE9Cb1hzeFV6M2dFcytRMVkrNjgyQmNEMC9IQmM4NWcwNHQyb1dzbDZs?=
 =?utf-8?B?VThwcU1tamVUU0JkZERjV3I5UWgrZDJIVHBKWEJnZ3Rua3l2VnMxTDRWWjYw?=
 =?utf-8?B?dnBabDh6Q1ptTndGbDVxOUFTZTV6MFNKeHhZUCtNa2t3b1pGUWcvQ1NkUWlT?=
 =?utf-8?B?bVZPLys4ZGtZY2tad3hXRUN2UnlpVzBNdmVFeFdGZVJSUERYekJNSGRNb3Ny?=
 =?utf-8?B?YkxsY203cTkzMGJLcVNyUU9BVEpRcHVYUWFGa1dRQnJmcXVjaEFZc3FxdmJJ?=
 =?utf-8?B?SUdoQjBCVXNld1VaYTljT2tvLzRqSERMZzAxbXY5K0pzUE4rc0MvT3RpMUpq?=
 =?utf-8?Q?g6+92rXH+ZIppZGNNy6Eh3TlV6ZDxHjs1e788BzJekpp0?=
X-MS-Exchange-AntiSpam-MessageData-1: FxO3gMRTnsluRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315038e9-41fd-4126-cff1-08df2a5c459c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:33:10.5180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSkPWYYmDArAS+1+Aa0wfWNAbTKxQ789wuz1OYFvWhygrCW6uhSwEgvV35kwo/AOAjjfR7IQjjeifp28GFjDDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9542
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

On Wed Oct 7, 2026 at 3:30 PM JST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
> <...>
>> +    // Tests that encoding via the `nvkv_encode!` macro works correctly=
.
>> +    #[test]
>> +    fn encode_typed_struct() -> Result {
>> +        const U32_KEY: KeyId =3D 0x0001;
>> +        const U64_KEY: KeyId =3D 0x0002;
>> +        const NAME_KEY: KeyId =3D 0x0003;
>> +        const FIXED_KEY: KeyId =3D 0x0004;
>> +        const OPT_KEY: KeyId =3D 0x0005;
>> +        const INDEXED_KEY: KeyId =3D 0x0006;
>> +
>> +        nvkv_encode! {
>> +            struct TypedRequest {
>> +                a: Key<u32, U32_KEY>,
>> +                b: Key<u64, U64_KEY>,
>> +                name: Key<&'static [u8], NAME_KEY>,
>> +                fixed: Key<[u8; 4], FIXED_KEY>,
>> +                opt: Option<Key<u32, OPT_KEY>>,
>> +                indexed: IndexedKey<u32, INDEXED_KEY>,
>
> API question: `IndexedKey` is module-private, but this use of
> `nvkv_encode` looks like something that driver code could very well do.
> Should it be crate-visible? If so, why not move it next to `Key` in
> `nvkv.rs`?

It's not used immediately, but I think it's fine for it to be crate
visible since it is fair game to use it.
