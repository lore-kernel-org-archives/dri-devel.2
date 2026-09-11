Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7990C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0583A10F31C;
	Fri, 11 Sep 2026 11:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pI8eYSHi";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A63A10E2C1;
 Fri, 11 Sep 2026 11:18:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/pGyHraacd7SvYI6u/GrCv1QtbdBt2QUYhSgaYYNPsp1SLaBpXUbOsjoh/lmQnu537yh4qcnX0nAQlIUnci2bRn3USFfouE8dlyfb0Fz9c6bRBeOEPuv+SNLjTcxwET4s2pe9f4K2ZizVMnZp6IHPV+RrX/PH7U5pm168WCKg3Ozwra9Wh+sH0Hgo08TevpHeWk6osmVt1j4rXyCN1aisoG0Ky+68Bu/nfsKRupINEp266eVmHbuTVebNgiroJxtQ2Icxd5I0bioPMCIT2DERZVK+9q1QsKuqQzIY1XQujLHDABz4z59LV24b3mii8aClnItKvng2ntrDEkPAiWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hafCoMGT2yi/aNJd3ECDQBlQRBJosGNrkmau4HUUGYE=;
 b=gmiWE4589Aa5q83DBMGoLP3WB57IE8r6249pmiAhHWTOhIIVlIIMH6m66k/Ig6KHd2hgAFpFmbFvdAELooBJ0VCZ7jZIEV3PuaI1S8MRXwTJas58ek11G8A+9ztAjhM994xRlLCiT1qxV1bN2mEpJ6mkcN2Z8WOPdnZDNmEQ1h9w8q7TpWPdebk+y2kT/3oPhSP04vPmeZkTEdMC8BdHhw393lKlWjlZEaRwxtgbBIQnVxzgkWagMYFci83vY0OhDDhrSB+4dsccHaPtTskRWKR/BRQ+7InVeD0W51v75M8eAIy1D9G1a5MN8/P1UCoNYmoNiuLKgUilgiT2THjQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hafCoMGT2yi/aNJd3ECDQBlQRBJosGNrkmau4HUUGYE=;
 b=pI8eYSHiCQk3Kn0Bvy69FyJOeQbFAyuTbpd/vtr0XLYG15vtxWajsGsd+3I7rNAiFl6cCxzwpMILhCI+SsqmdAl5nqOheKMJgtl7wK1xfCpcGDRcXo3Fy+hviHtCC1+EQxLb2xIbKdDdUMYvua8UZwnerLRIKj3tbxrCbwJ/kr/KW8LLhdDzKUIKrvuTvQT2nqdjHp62roScQoELpG+iU9MI6e3ZRejMnwiWV5Xmp2xrJUw6pCqf9W4g4UYLYMIcqVg2Nb1ZTDYjZneOd7pqW/QdnkdZTOSWgvHsaJnhyF35+1H9uiRlP0h2kgy9zbXADqPnYwzgb7VtR3t3eFyM8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 11:18:19 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 11:18:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:18:16 +0900
Message-Id: <DLCG22C6X96C.3A8EKCQAZ37FD@nvidia.com>
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
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-6-0de9d5c8658c@nvidia.com>
 <DLBHFHGH4MEE.1ZELDBMX36IQC@nvidia.com>
 <DLC8DZY8QM5N.5Q8MS71R0VKQ@nvidia.com>
 <DLC8MGO86DKV.3IIHPUADV9IRY@nvidia.com>
In-Reply-To: <DLC8MGO86DKV.3IIHPUADV9IRY@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d3b4bf-c564-49ad-8602-08df0ff661b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|10070799003|1800799024|18002099003|22082099003|3023799007|5023799004|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: BBpTYrKKc+L9Hf7h6nc5TJpIdY/wJNXTi6L1gOTfbqKAI87UW1z52Zoi+0Ho6wQezEvhrdV6Riexi8OEkRSizYS7H4X6QqDAXwRZy6rO7LkIkrEbn4hdz8KkKrOroN0xpqeOfHPk96L7NfGy39G3UaO4bQDGVkr9l09UYUoHSJsv0zPaFU/rlhWfDve9DMwU+rEEbpBIVpLurR8CJ1EQGKL1lGRNoDqP5ledHiORa7MJocfxd4XGfu+1Gwv80KA2nXwnd5wF9wBqvJf8VC0iqmJtNlcmFYWvfxx9NmibfPq8AjpeRdRBF/SXHlzVGg1hBZFMiQ3XK4d84QaXrPPk9TdEFmjLMaPDg+F3WoqhomgWaz8fgcgfpKz5C1RoUS3wCeYhRWVrVKRTpeG6ehY8MPsIDDzSoZzUmoOMrGh0zUSg077qXV+WRpeIFTsvHAm69ppxdgysMctsUEQv4GIAu7i1ZdRIsXVJV7A4dLf39WlTGLAHqNrp3e9x0aymkacHaSbkqpMR12Wfv/hutX/mmlrjwtF0oBbrzgkwEv9OPw8/OrUNeGW3gIF35+subJCuqhhutvCGAx/1AefnGYGmxcfAb8vrXiMnYYb0CUhDpDVCRCJPCynmfLSu49bjqFhclSIvknAi8xEPyZx3aqDzc+NWRPZeQ4oAs+FL+yRJpCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(10070799003)(1800799024)(18002099003)(22082099003)(3023799007)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXoxQkU4VGZvOHRlbXd5V040azZaMzExcjlwZlp6R1ZDaGNtN0VXU0NxbFh6?=
 =?utf-8?B?OTcvMjdJdlpqOXo3TWJreC9UQktCaGRacWcyY3RYVG1qUFJmeWJ2UklLVVpS?=
 =?utf-8?B?TXdySzBxaHFIT1R3VHcrYS9abXV2R3V6QWZTeDRnbWVSTU4vZ2pIbTdzR2hl?=
 =?utf-8?B?NDlPYzRHL1VRY1lFRUVCKzhEZVVFMmptZ0o0R1l3OGxXc1lONEsvM0R3UUg4?=
 =?utf-8?B?Z1ZSakp3K1ZMRXUxTENPVldONU5tMFR2b0J1Q3JNRStmQ0dOWWRZZ05yTDMy?=
 =?utf-8?B?MVozS1pjN0FVMTJVNkI1MUI1TlkxZEZhbStRQ0M3QzI2VnJCR1F6MUpNQjli?=
 =?utf-8?B?WG5DeXFQNlhiLzUwZlNYYytBNFVleitBQVJTRWRCelhxRHExSzhRbVU0OTYy?=
 =?utf-8?B?dEhsR3dueW9wcHpiQS9tcUQ1cmlmM1ViTUlHU1BPai80UFc1N1VBaFZKbEdi?=
 =?utf-8?B?SVptd0RFTVM5bGdmcUJaWjhxZjRRZ1docWFDc05WR054eS9jUVJsMFRZZlB0?=
 =?utf-8?B?RU1RQXBCRnorSnNmcjB1eTl3NHNwMXB5K2M2cEhEdCtXU0ZkNTY2aFVYOHJ1?=
 =?utf-8?B?c2lYNGt0eldLdkRxV01keTNCOXdBdVB4bGM2L3VHMmplUk5rcGtyL0ZsU2k3?=
 =?utf-8?B?NmE4SFdIUW9uUnhvR2JubUE2STFhUVlsSFZ0NFRoaEFoeEo1TjE4aWdIVjBH?=
 =?utf-8?B?Y1hlQ0ZEYS9GT3ZJSExTOHRTU2txL0tJUzlCRUNhZi9DZU9CMjNYZFNOOEhY?=
 =?utf-8?B?b3hyOHZBTkZnQ1dGZlZoMi81MmFCa09DVWhtQ2RWdk9FN2M5bW5JM0FiTEVn?=
 =?utf-8?B?UlVIeXBERGs5R2RFTDRURU9zWWhaYU1PWmZWNWhTNHNPWno4UGIrTmJTby83?=
 =?utf-8?B?VU83NmhVMUNxSE8vMXZBWkptVnZENzNUYk9IL0Q5QTcybG41WVdpamYwbTY2?=
 =?utf-8?B?UVErZ0JFLzBjcVJTb0NjUml3clNmSy9aWGh2SWlHYTQ0dGE2WVVQb1dhVk9x?=
 =?utf-8?B?dkJiWjhZYVRnQlUwUWg4OEM1bEpJUzBPOEI5ZUd5VVNuZ1VJT1hoZmRwQWpW?=
 =?utf-8?B?NHh0UDJDYkppS1RZWk5neXVabWJpS3dFbk4xODFLbUJpcDJBTHlKZktuMThF?=
 =?utf-8?B?TUR2WVV2eEx4eEVibk9NL3kvd1VlcysxNFBVdHBkbkdlUjZlQVJ4ekNmYy85?=
 =?utf-8?B?R3NMUUpVWTZKbVYrWStNdTFIQ3NFK2FPcU9NTHcxNmxGa2xtZXJGMDlxNmVq?=
 =?utf-8?B?SFdIM2ZPVUFEbW9hRTRCc1dFWnZPSHVlMkdoR1N5Nkd1QVdoU01Fd2ZPamI1?=
 =?utf-8?B?KyswOW1Tc3lLSmhMRDh6Ynl2eTlPM0N5NFNuQkdlQ3BoMWErNmtUK0Q4blJn?=
 =?utf-8?B?ZWk2UWlqOVVKSWUyY0h3ZUR4TzdpcGwwOW83Y2RSY3BSSFk4SGFzcUNNUVNm?=
 =?utf-8?B?aWFLVGxOSzA1NVFRR3RJSHJQR0pPRzk5SzNVRjkvZVFFNnFPUFFqbnQ0c1lh?=
 =?utf-8?B?NXNZUE1PbW5tK0o3SEhzV25Cam1LVkxnTVUreGdUZ1lxdmU0VERrV3M5RUZ5?=
 =?utf-8?B?RTNiMlI5NTRBcTM3dFJrdEF3dGF6KzJhWnRXaGVWemhaZExwV2o3VUJnSGJ2?=
 =?utf-8?B?UU5WY1lsR0orelpmbVJpWEQxaVdValBXZzd4b1E4TlU2clJCWEF2Q2JSZWx1?=
 =?utf-8?B?T05qYlFoenRHanhHMWpWQUhvWXJ2eW1QWVFKQ29Mb2Yvak1XajBoSU0vcnZ0?=
 =?utf-8?B?dUZ0blEycW4vRkRKVTQ2K203WXQvaERvTVZRTnNzNTlnZVQ2NWc2bmtwaTVi?=
 =?utf-8?B?ajZ2TG85b20vNEoySVQ2NU02MDI4cTI0NFh6RE0rLzQ3aXhiWi96MW5ibWZS?=
 =?utf-8?B?Wi9qY1Aycm4ybVF0OWNoejBCWkQrbGpJMHBBRG1qU3BOZUtCdC9tcUh0Wk5T?=
 =?utf-8?B?Vi9vQkRLZnZ6MXhHaDBqeHVzNnZWN0N5ZW1NTWdCbVFmVDdwK0VZY2RPNHpl?=
 =?utf-8?B?YTRnZkdkMEZiVmxZMXR0UjM2RWpEbVZYY1lVR3h3TVdOSDl5RVNpNUc5Z2pV?=
 =?utf-8?B?b0R4VEVZcS90MmhaMlVEbExwN3Rxd3FGeFFjdXBQckVvOUdpdFlHZFR5bFFn?=
 =?utf-8?B?UXplbVJRVEJKRnpRZytlbDRCZ3JtUmg1MHh0WFNrM0o3SWM1MlRTQmpWeG80?=
 =?utf-8?B?U1YyK3FPbHQ2eTNGNVBxYjk2bnhEVjNFZ1Z3NjY1SFNxSXpvZWwzcXk3eXM3?=
 =?utf-8?B?cXg3dXo4THlONUhPdU5yN0FGN0dFNHdkSzZPTkpXSk82ZXlybnFBZkZ5MXBU?=
 =?utf-8?B?MENMZEJXeDBoUDEvVDF0d251VGxyM0VUeHAveTZ2Y2NUSndwVWNyZlVnK1V6?=
 =?utf-8?Q?61UaA7uPZ+kBzdgcZ5pFQP8O12BxpjH3rZ0gPnZbJKorY?=
X-MS-Exchange-AntiSpam-MessageData-1: AXXBKRh/UYgj8w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d3b4bf-c564-49ad-8602-08df0ff661b1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 11:18:18.9283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMEgTxkRg3ok7g1okTlLnnBTophYx8OQuoTbASANSYHG2DUiFSlJNBiUxX1ogEd1ZrcVnNP2Sx+zMhudW4ORfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
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

On Fri Sep 11, 2026 at 2:28 PM JST, Eliot Courtney wrote:
> On Fri Sep 11, 2026 at 2:17 PM JST, Alexandre Courbot wrote:
>> On Thu Sep 10, 2026 at 5:10 PM JST, Alexandre Courbot wrote:
>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>>> For struct-like GMCAPI messages encoding field by field manually is
>>>> noisy. Add some type machinery and a macro to automate encoding of
>>>> struct-like messages. The `Encodeable` trait can be implemented by any
>>>> type to say that it can be encoded into an NVKV `Encoder`. Add a simpl=
e
>>>> `nvkv_encode!` macro that works on structs and encodes each field in
>>>> order. Provide some base types, such as `Key` which statically
>>>> associates a NVKV key with some value, to avoid having to make a lot o=
f
>>>> newtypes and implement `Encodeable` on them.
>>>>
>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/gsp/nvkv.rs        |  49 ++++++++-
>>>>  drivers/gpu/nova-core/gsp/nvkv/encode.rs | 178 ++++++++++++++++++++++=
+++++++++
>>>>  2 files changed, 226 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core=
/gsp/nvkv.rs
>>>> index cbeee7f376b6..10dcbb9e602c 100644
>>>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>>>> @@ -10,8 +10,13 @@
>>>>  //! naturally maps to storing a &str with the GPU name.
>>>> =20
>>>>  #![expect(unused_imports)]
>>>> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
>>>> =20
>>>> -use core::ops::Deref;
>>>> +use core::marker::PhantomData;
>>>> +use core::ops::{
>>>> +    Deref,
>>>> +    DerefMut, //
>>>> +};
>>>> =20
>>>>  use kernel::{
>>>>      alloc::{
>>>> @@ -92,6 +97,48 @@ fn deref(&self) -> &Self::Target {
>>>>  /// The index of an NVKV value.
>>>>  pub(crate) type Index =3D Bounded<u64, 12>;
>>>> =20
>>>> +/// A static association between an NVKV key `KEY_ID` and the storage=
 of its value.
>>>> +///
>>>> +/// Use with the encoder or decoder macros `nvkv_encode!` and `nvkv_d=
ecode!` to let them know how to
>>>> +/// map the value `Key<T, KEY_ID, As>` to/from encoded data. For brev=
ity, `As` inserts an additional
>>>> +/// conversion (`From`) to avoid having to implement [`Encodable`] fo=
r many types. For example,
>>>> +/// enums that are easily convertible to a u32 can have `As =3D u32` =
and rely on the existing encoding
>>>> +/// for u32.
>>>> +#[repr(transparent)]
>>>> +pub(crate) struct Key<T, const KEY_ID: KeyId, As =3D T>(pub(crate) T,=
 PhantomData<As>);
>>>
>>> Does the `T` need to be `pub(crate)`? The series builds fine with it
>>> being private.
>>>
>>> Also the relationship between `Key` and `IndexedKey` is a bit unclear
>>> with the current type layout. IIUC `Key` is basically a specialization
>>> of `IndexedKey` with an index of 0. And yet `Key` is declared in the
>>> root `nvkv` module while `IndexedKey` is in the `encode` submodule...
>>> I'm also wondering whether it would make sense to make the relationship
>>> completely explicit by making `Key` a newtype embedding a `IndexedKey`
>>> with the invariant that the index is `0`, but not sure about that one s=
o
>>> your call.
>>
>> Ah, I guess that's because `IndexedKey` is local to `encoder`. In this
>> case keeping it there does indeed make sense. After complaining about
>> the visibility of other declarations, I should have noticed that one
>> too. :P
>>
>> What worries me more is the fact that no index larger than `0` is ever
>> created. This looks more and more like a bug to me.
>
> We currently don't send anything that wants an index other than zero.
> But, in the future we will. The way I did this so far is by having
> 'IndexedKey' which represents the most general thing that can properly
> encode anything accepted by the NVKV format. Since it's cumbersome to
> and rare to use, I added Key as a wrapper on top. It would be possible
> to hard code 0 in the index and only have `Key` but then we'd just have
> to change it later. Since nothing wants to set a non-zero index
> currently, it's private to `encoder`.

But surely we should be able to test the non-zero path, even if we don't
have any real-life user at the moment, right? As this is part of the
NVKV spec, we should ensure this is correct.

If `IndexedKey` is supposed to move down one module when it gains a
user, I think we should place it in its expected destination from the
get-go.
