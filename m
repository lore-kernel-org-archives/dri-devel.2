Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35509CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4603710E46A;
	Wed,  7 Oct 2026 11:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pev4xFUX";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE7D210E46A
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXlIdblX/nl6liIWXlkVGkcHH0N+l8xEgIHn6JSknbCNeZdw9q+V8e/3VXa7HDE05aQ2FL5pKUZUaGZJh6NObnBtFJ/WCNR4UIOmwUtpZyPq5txcxdl6Nnk4vWHL5qrwjA4ueLEM3/K1dk4vfqGk5OF+iEQXou/tTEJbxKBcSMbT2OLl5zD4GnGlMmt2dA+7IYZpmWT4tH+CCZL37vk+B4Bek5Q3I83emR6CZxJuU6t/AsNHdAzzMgLtzzw8Os1IfvYge79ADQ9gYPFpmjGlqvAoTzzQSMMDtBbI8Vogqluag6c+IIerl2ouJNmEPsj74MG98vAUw50BaoDRK9ilrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR5hanKK7F6uc8XbS8lHCh0UvQ9lTTAmKLJALNwJ1J4=;
 b=YAv+tbJ71n2Ygm80ixmlP3xMpz8othH7z9MN3Ju3hFs4fhMvuBhr5gT/8RD4zB1RuOXQCS+JeM979vX1DLQ3LoREyJBUvv7U71QFEEJK3i5Oc8ClyXex8wU+HR8BSF2nmVukW8n8/6uhEWjXgGTR8vPRBOs4EJz1MKPUfP5nheh5wCE/TjworpSmqAye9j9AIckTDyKFHkqyb8LGmtid759WRajXmN78qyUoHGMeQeKr+NdTi4pWYNWnuQRRtziE99WMlD9L0k3I32eqdCGHcaxePivss8xSiTEIRea/1vz7+jBol8IOt6Ejfy6aBzWET6KMQuRE242KWFlh0o4Mkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR5hanKK7F6uc8XbS8lHCh0UvQ9lTTAmKLJALNwJ1J4=;
 b=Pev4xFUXL6Pbr4E6VombP1S4Vu4I5VWR77J8X4FzNLoTq2XBczHDD29UyDX7W+WwCxxYxEUm7fXqbEL3Vsy5bvD3LbQXuYfrUaXL/fRByRtYv/LWFDiG7dDiFieWB8FwKsIcS0Gun1AqPRhpSdSNj4m4/1u0ZpypH6V+hp4TvnJw/ogO8T+euo1EOYlNmJa2JdlaMxUDfISkmuG7EThpnKRSDfUwkjsHOZMdJPRns2ay9hT68YA1XqfVX1Y9GBzSvKGO38A/ehSFS85ZXWjjw9ihscH5yIJxXdhC/mojsqCmQ0AP9prcFK6IfbscobtVryhYa9W73sCiAnwY5iGG9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH9PR12MB995114.namprd12.prod.outlook.com (2603:10b6:510:426::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 11:56:24 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 11:56:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 20:56:21 +0900
Message-Id: <DLYL5E2GFSM7.3SMUQUX8LN0C1@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 4/8] gpu: nova-core: add NVKV encoder
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
 <DLYAO1NDXB2L.3NUUCWAWFK188@nvidia.com>
 <DLYARWONCNC4.16TY7TATZG2DX@nvidia.com>
 <4ac83051-6ac3-4919-b230-bfa059ff956f@nvidia.com>
In-Reply-To: <4ac83051-6ac3-4919-b230-bfa059ff956f@nvidia.com>
X-ClientProxiedBy: OS7P286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26c::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH9PR12MB995114:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e5663c-c09c-485c-c543-08df246a02f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jq8837+CWCoqVgrrXdf+ZDTmwaY9YrYRmE35eKZxasnrk7U2DacAxwKSmdT7bvSBg6AXMRvAiA7YD4eD66pWm+A9s6P4Wh2b+LdVwCjyJRyxZsNb9lh5b/LcOIDnM6uUt6kr38eHedRnfFNa+y/RZfqjEmofMuEmb5H3sV16FZ3SGiatSMN8iMENOKB1u1ZLN6cSLwXqg9qe+7CPSA4cUyJt3oGnTNrQTHrEZCrj393Ji6NeRa0O+ZXk3JhRSbrAAWVAuFvL9aDifUhHxPk8x+v+lWt2isml4J90HHLZ/TVQzedFt/LB2xrwgCjvWVTGhOTtSoI+tNitfkCu6nJ/thSCNIz00OuYI67uoRYhERrBHja54QVRh3gnhXZPLBu00xYosnFeb0ORz1ExNxcZZUy2a/SjxS39EmUSPqTUDb1G+Urmj/kpvayIrOUEJTDX1aiQCyRTseTt+QB4TPDww+vIA7RzagD0UwJRyOlLOSbRzIQ1RhSCXA3HUh8HwKL4/VmBaIcFk/XOZxikcuOnCOwObbNmzjNczh8NQe2GPXQD4G2aMWKy7mWqvkrzdo5Idw1ObSFvX1s2ms1uRxX5w3/tBP/CF3JsYdBfPEc0sU8yvviFR2vfnE+EU82f+xaQ36e5W+7V5/LuA3+sy7pPKXvpcHBGLbVtkmnCGAlbce8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXhMWDZtbmpOQW1oRU94YzY0bThKaG1tY3FDZkFSV1NkY1BNL1FoSDhpMkdm?=
 =?utf-8?B?Z2pZN2d2TTJXdUlFNVJwQktUMWtGSmtkaE0ySjBrL1h3Rkh1Q29HWFJBeDNi?=
 =?utf-8?B?bHBpMWNwZUxXZ1hKUUluSUxkOU81dHNmcU9hUlhIV1RzQ2ExQWxTRjZ6SzYy?=
 =?utf-8?B?em1BTHo5QWFGSXBOTHVSSTgrazVuSUtCY0pZNnhmOVhvR01HWWpNakQ2c24z?=
 =?utf-8?B?YmNPaVBvREJpRHdiMkZFMDExd1hiUmhhMTRXOFVzRDAzVkZKaHJlaStKV2Jn?=
 =?utf-8?B?My9YcGxIeHdIZ0cxcnk1U2dMdWExeHNPV0N6SFRHVk56b041Vlp0NjByZXNX?=
 =?utf-8?B?T3V2TTdOTzRpVUtEWWpiZGE5VVN4bzRxUkxoVVFoQ0NpeC9GTUVBc0NmS0Js?=
 =?utf-8?B?MWhzZnN6RlhoQkhBdnVqYWI3WmI1U3dic0cya08zSmI5TjM3LzN3ZXdLemJz?=
 =?utf-8?B?cVlOSXRYVTFRVFVwWmd3bzBGVGcvcTlCNUt0cTgwcUVQdXZOSTRudjVBY2dz?=
 =?utf-8?B?MjlpZFpRVzM1LzBVVEJJOXRLcjRHMjFlWDZxR3VsQ3g0dGVwWnVDd1BMck03?=
 =?utf-8?B?ZkhZSGNFZE9nNm5CV3dOSlhCMVQ4WVJLSk5EL21sbEdMMSs1SjlRK1ZjcFdk?=
 =?utf-8?B?Y2NzSllqQ3hXN3F6QXFTNW1NSHAvc2hVR0JZRHIzWmhCYnpLOVpHNnNDWHVN?=
 =?utf-8?B?cVA1NTJlemFBYllTTGs3MnArN1NxcHBvQVJyaVpsWE5MOU5odUJITXRQd3p6?=
 =?utf-8?B?aHp5RWNqOXQ3VHZvNzlUQjNyb1RtUXZFQVZXQ2xwYWlUVnVldjA1RkhQelVY?=
 =?utf-8?B?ZFk4eGp0eGlWVW1ZajJsQm9BaU1xNHcwTEFROEtpelR6T1hVZE1BQnpIMFEr?=
 =?utf-8?B?RnRYYlR4bHk3NEhCRG9kb0t3RGdlSzBqQmVScEJFTWU0aGFCZlhjRk5CU1dm?=
 =?utf-8?B?MGx0TkRQS2hOSmJoYnZKdHBscisyRXBBb1pwVURyNEFMMnJneU9SU2ZLVlpI?=
 =?utf-8?B?bTZwVEhnWVdEVHpQZ3ZwcnBtN2VYSkozMHVOVG9mWlhaNGR4VS9WalVXOVl0?=
 =?utf-8?B?d1c4SlMxQ25XNm5IbElJaXJFQmV2YUNyNGpSWmNWL1B2TC9wU2RPZEJubmtj?=
 =?utf-8?B?VE5qTWplSnhJQXhiTWs2RU1kUnA0Slk1bzBJeUV3MjM4RXkwa1IvM055eW5R?=
 =?utf-8?B?SG9KMXlmMDJBMXU5QW5vNzJqbWw3bGVYMHlaR1hRQjVlMzZXZkxJalhoT01R?=
 =?utf-8?B?VE9Hc1NrTW5tWEI0SERLN0l5dnoxSWtybnFaUDJxZFk2eWlIb1RQZzZXdDlm?=
 =?utf-8?B?d3paUlRBTTlTRy9CNmlTczRnY0dBZlk4SU1CRmphRjh6MEtHbjhnalB6b0Fm?=
 =?utf-8?B?OUNyeDEvTFljbG5oRlp2ZEYzOWJZWUdiT0pHb2RjbFd6RDN0NkpUWTMwWVo4?=
 =?utf-8?B?V3d2YllJRGg5RmduL2pVdDJ3dXVPSkFmZGgzMGlZNGpkcmlycFdySER5RVg1?=
 =?utf-8?B?V0VnQzJGS25oY2NUMjREWk1FVTVSRmxEQWpLZHJzTSsrZmlWS0RnSTNlbk5B?=
 =?utf-8?B?YUgxTVR0MUE5L0ttZWRFNDlmT0RQRzJBMkpKWVNjR0RmdVFVOVhlU1lFS2pC?=
 =?utf-8?B?cTU4V25VWUl5S25xOW5mN2ZUNU1wdlV5bGN6YkIvWkRnN0xGYlBmWXErbnBl?=
 =?utf-8?B?S3RZSE4zUWtwZTZhOTVBbUljekd1MjJsRklvTUJGQWVlRlAwdWc3NXpxMFZs?=
 =?utf-8?B?dkdpMFpLUHB5OCtRcmpjNVlVS1VjYURaRUU4YnR3ZVNUOUtPYXlhSWdLYWNo?=
 =?utf-8?B?RGFKaG5PRFB0aERCMk1RVis2cUtzWDdLbE02VkNVTDIraU9EZm9pZllzWkJ0?=
 =?utf-8?B?Vzg2TWNFZ2piQkg4T0UrbDI4VUxMSU9zcW5SenBSWHdDQ01IckVyRXprYjRD?=
 =?utf-8?B?N1pVRmtWVG9UMlhaTlR2QktMTWFnYlFHc0hUM3hWQ0xBQVhvZ2ZrdTNYM1Bi?=
 =?utf-8?B?bXdHa2VkMHB4amEwNTRPSzY3VXZKdGJzdUpyeVpQZmJ2RC9JMGhDMWVaVGNJ?=
 =?utf-8?B?ejA5cDRGa2l6QlF1RVJ2QnNDR2thNlZiR2hId2tFS3BWeDFjWUxpZ0ZESDVN?=
 =?utf-8?B?VDBzbG5UQ3prdmpDNG1CK3RHQ1hrNjFhM1E4cVpCTm4xRnRtcTJhT3pBS0pL?=
 =?utf-8?B?aDZpNE5yUjZtUkowS3FjRDNXcy9xc3pGckJ0Qi9aTFJuUU0rTE9KcXFzdTY5?=
 =?utf-8?B?VlJVMGl2NzNQekZRNkxySWsyNVVDOFpKYUZxenlkVGZjdmV4TzlrYWY4N01Z?=
 =?utf-8?B?ak1ocEdaTzluNlZvMEpsMFJlbms0MlAwU0tZdE50Y3FnTEM4Tm55MElTOWl1?=
 =?utf-8?Q?IdaiiS6T6/c3JjUbktiW+TRfamzEiM5N5tIQJjllUp4m6?=
X-MS-Exchange-AntiSpam-MessageData-1: 39aquEwI0o+33g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5663c-c09c-485c-c543-08df246a02f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:56:24.6135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHJ0ga4NODxz0VkuD0q7ogbH7K8PNv/nF1bGSDhhlEEVA3Yfv/+x4cRLFpMfS797tli/C4T59xx6Len/Xem98w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB995114
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

On Wed Oct 7, 2026 at 8:33 PM JST, John Hubbard wrote:
> On 10/7/26 5:48 AM, Alexandre Courbot wrote:
>> On Wed Oct 7, 2026 at 12:43 PM JST, Alexandre Courbot wrote:
>>> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
>>> <...>
>>> ... and that's all I could find on this patch. I particularly like how
>>> the examples have turned out!
>>=20
>> ... although maybe the Sashiko comments are worth considering too. Nova
>> does depend on little-endian, but it probably wouldn't cost us much to
>> e.g. call `to_le_bytes` instead of `to_ne_bytes` to make the code more
>> portable.
>
> I recall having this conversation before, and I've tried to consistently
> say "no". It's not a real thing, and if it ever becomes one it will be
> a very big deal, not something we would overlook.

I agree on principle when writing endian-neutral code requires some
extra infrastructure or considerably more code, but here we are talking
about trading a call to `to_ne_bytes` for one to `to_le_bytes`, which is
zero effort.

... although the Sashiko warning on `extend_with_padding` *would*
require more than just a method call to properly manage arrays of `u32`
and `u64`, so maybe we don't need to fix them all, or any at all for
that matter since half-fixed code is still broken code.

