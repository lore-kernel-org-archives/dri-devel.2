Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5CACA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA2110E449;
	Wed,  7 Oct 2026 11:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AOi2Wl2e";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8444610F519
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf8KQw6itM98Ib8tMl23PNkB9XfO9Ks58LzrQsBTKitF/j+WYN4hZzy04ErEUQuNMEo110z+5T8P7ru6+xw+m6wZXxwopluIIe6YQq1CIQa5HrPJ/uCV5+rKA76VPViFxRHtNUGN2FMCNDE112b7Ws4RT0qE5U+MJZRf+UjcZtMCGQo7fwzM2bwod/y7wS4+gU1s4JAX3bdDGRWy7PAWqw0dJNRNKd8Uk44ImFrJKvykREr0J0e61t5dTiz7oNI5sg2a/RP9szGzkPpe2RRKaEUsoG/DpYgcPl6yRLHeUWwbL0d7WPcP2CUbKWATcLABsqlfZ3Yn1AjkiRPvuiiT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVlMrOFywEY5UGh+Bgm+KMVfdCsi8dWhSailTaQSa9k=;
 b=Qk1jdwNzoCdimAiZ3/+Rbux+UbilJAwL24H7dxZHmaDq+/SbewisV8+bccfmu7rd5KnGyUtF3s15SWE/7pByPy2olBk4D7vXQxgnxgOZEsbtZcJSWpATGHnWO+JNKAZ4T8WDCdrcHdolWR0xHVtrukf7jOB4/XrgjbNcpYJY2sDvjUm8ijFAiomqo3h2vkRlDok8GNyWkGaTiLrcjkGrA4iwq3iMk87lXjQeo70oY+S1nKnK0EtSVf0J3QJilPfWC9JI15VVNQPic2EwqbwbgDmlvoBPrks6EYZQlYsHfS/n0Njkmxxd0tVgrKPFj0TmQlgAOZo5Qqf0Ye3fo4kP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVlMrOFywEY5UGh+Bgm+KMVfdCsi8dWhSailTaQSa9k=;
 b=AOi2Wl2ew7r8Xq87QryVE+9jMVp4srpyVVXw7D9El4pb6RZ7eIhzecsTtKZjFbWECeseKmaxa8P2Xw6XXVQFWOnfPZd3DjbOaJ/fM1inObL7cHZZkLNYhIrnt0/eaQEJvvgcknfevgs2nxwzKhaWIyDGLr1Bpvol73AfeCuQFCsfQNgntNHvNk9oS3SjmUVKrDaZmFwrMZnFAvU65OP2Y1CItUypVgOpITylJvWGfxOzmi601ZjxV3y4ZWuK2Or72p/9RIGm/Z5NZf+nSkdr/9jRIzfWt22rwQIIqrU9NmLRi5FehYo3nX2zt3Rq9w/kg8AmSiMNLKQJDoLm74+LbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS6PR12MB851160.namprd12.prod.outlook.com (2603:10b6:8:416::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:33:50 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0472.015; Wed, 7 Oct 2026
 11:33:50 +0000
Message-ID: <4ac83051-6ac3-4919-b230-bfa059ff956f@nvidia.com>
Date: Wed, 7 Oct 2026 13:33:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] gpu: nova-core: add NVKV encoder
To: Alexandre Courbot <acourbot@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>
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
 dri-devel@lists.freedesktop.org
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-4-f04504c262c2@nvidia.com>
 <DLYAO1NDXB2L.3NUUCWAWFK188@nvidia.com>
 <DLYARWONCNC4.16TY7TATZG2DX@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DLYARWONCNC4.16TY7TATZG2DX@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::18) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS6PR12MB851160:EE_
X-MS-Office365-Filtering-Correlation-Id: a94978ba-22c2-4f92-3d62-08df2466dbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JY4+ipOQiQ0aAKAOiX5r6O/0U4wBhoHOWcYOoA5skjZoLnv2zJftUDGb3CA6tou2bNLMJDXEuroh+rp0uBuSXs6ArMKkEe9lSqFCOOzdvku4IVL8/dwjQIG0xy7LXKW0XhQumM0bYIfntxpPcewFYIOPS3uw+o6jwoU0RRfHPWly+dnpGoSP0yauLcYEnIIV/0h5StZqWe6BKtFfLGVixXxe/E8w6x+djUeVjHW7pmgDbLXKHKPqJ4BFt52H60uOi28Pf9IU/58rg6dhuwaKVialaXW7FT/ppDW9UqM6nxNd2f/lHXPIWjhLdcp1al6Hn1LB1uBvd1scZ7stqLwdVuNzDVP9BZQdmkT3F8hmG/gBykoYSZEA11If9Cm7ajdY8a3kEkCjUs9ndnDzMgehxjwDbBnBh1p19kmk0V45Hzi49E5mmNmeZNn/YUKSsm9taAdExXIaeSWAhOtoVip4a7N4QMhTe5ELBXe5ZpDHRnnu1TZK0MIsMAWDUbOlE/51AdB8cX1T8TiAbq+wXnr7/ZyXoqPN4A61VD5c/aOnKDhQTNyHs+bTTN++PgDtKQwrXu/OlLmj5h/37gL/OlVuDJ16IL8hVcsUe4MvICjKQ8w7Aw2RCbpY2LX5NxtMkqFqJ2fNxBLhnC/GHIQvG8rtvIAnhwuKxckDAY/OsQp7Hm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3UyOCtpSzlId2xjZXY5aThuY2gwZVU1WWJ2djhjT2NSMS9BRDJsOFNWRTBK?=
 =?utf-8?B?UVBldy9KOE4rMDZ4d1EyMURlWVBYSWxpUGxIZDZjWHFKRnRUc1NXWTFDSUZz?=
 =?utf-8?B?aHEvd0pqSGp1VzFGRVdHcFM4T2JBOUdHOVgzRE1qeXUvOVQvVDlPaHBDaTFI?=
 =?utf-8?B?RmJQSFJNWHhuazNYRk9ZU2s5QXJXSjF1Vi9xK0RiN3hFcGc5ZUU4R0pSU0pm?=
 =?utf-8?B?MnhTWGRaZUpXc2RXUzE5NlhISjU1OEhJWW5rOTVXcTU3dkFFWkZlRHIzajUx?=
 =?utf-8?B?SDdqT2haMWNQM2FRYlQ1NURtcGpVdDRHVHhCNkVaWE9qeXpybVE5TC91RFJR?=
 =?utf-8?B?Rk5nK1ZoK2ZpTC8yYWV4L1gyaW5ZZG53M0d4ZHNnSTM3REo3Sld6aGRrNnNx?=
 =?utf-8?B?eU15NkVjZzhUcHpWRk9yY1g3d1FEbkg3Y2tKbGs1TXpuRGVOQUxGOVdTdkE0?=
 =?utf-8?B?c0RzZnU3Ymt6WU1rcWlENGhOT0s4SHhnemZGQW9OMjJDZ0dlT2owSXF5dG0w?=
 =?utf-8?B?d1lFc0I3VjZJYnREOWZ5SnI4UnBoVkpWd1Q3dUJVcGFxNDNPeWMydDl3WEZ3?=
 =?utf-8?B?OHp6c1FWTm1JN1JnQ09nWjN4M2krRE92TWZZNlgzb1htZkRMMmdXd3JFMldp?=
 =?utf-8?B?cG92VExtRnRjbUxmUnBPUVZUMTNDcDVmUFFuUURJcWFvdFBKd0o1N0hrUXc3?=
 =?utf-8?B?c05vZEtlL1pHbnVFeFMyeWdXaEw5SU5hUzEvK2IySG1lRllCc0NHZVB0TTNH?=
 =?utf-8?B?NjREMU1YSkgvV3hUcTk5Z1kvaEZaL3gxNmo4UU05QWdwZ0dPMy9sbkRlWENJ?=
 =?utf-8?B?SkhyQlR2emVDWkhYVHh0dldwK05IK2tmUFg1SkhaelZxMUUxbDhYazJ1WmJm?=
 =?utf-8?B?RzFmL2ZraUg5Rm0xSDYzQWcwdmtlTUtUNkJjeGo0Sm1YYTRxc05UM2N1NDFY?=
 =?utf-8?B?bTlBRDVVM1FyVkNZdDMxd1hWckV0cjJ2YVEzaXoxUTYvVlVydFNkeU9Relk2?=
 =?utf-8?B?eDRiUUZCMGFXUkJnSkJiM3R6SWlZT00yL1VQdHkrZjNCVnBCQTl6VThISFQ0?=
 =?utf-8?B?WXRVSGZwYWFRcG45R0VLd25hMUFuek10TDBlbkNOVGJibHczS1AwUGFJT3RL?=
 =?utf-8?B?ZGJxMFhZWFBtamxMTGJUSEVRS0RpdW9pNWs0d01GenZSdC9zRGQ2ZkRlcUxa?=
 =?utf-8?B?WCt0elprRVpMUzIrT0dNeU9OOGlYZmh5enE0cnFBZ2lMUEN1SHIxdHhST3R6?=
 =?utf-8?B?a3c1MHB1RVY0R29mQVdIbXJDdGRKbVZKZm5YZ08xTG0xcWwrdllWNUlyaGNo?=
 =?utf-8?B?TWlUUEhPTDZNTGNoU0tlVVJ3clhWaElScEduOUtFWU5lQUkrU1EvdlhOd3cx?=
 =?utf-8?B?dThKZU9nTW1jWkkwc05rYUpUdzBLQXBmMDNpbEtmcnJMWkF2RUg3c2cyVlBH?=
 =?utf-8?B?d04yaWlDajVZVU1Tbm9RcTVUbzdoU1V1TUJKMHlVbFJYODJKL2FYSnFSSVNL?=
 =?utf-8?B?Vk8yK1ZaMkZIS3Z4Zm1HNmptZHFpRi9jWlNOZytQczhjU2NJajh6M0ptK21r?=
 =?utf-8?B?eWxBSXU1eDlVbnFnMXVqaEV3MHM0c0V0VzBRSlBZTndmSGtwQ3hQaDVWSE5T?=
 =?utf-8?B?WUtMZG0rUXUzZVY1TS9CSFI1RHpvMk0wK0liTmhvaEppU2xqSHZONW5UMzBn?=
 =?utf-8?B?RmlCN00rS1RwQjYxV0lIVUxxNmZGV3lCMWU1SXZ5V3RBM1d0WnZ5L3F3VWx4?=
 =?utf-8?B?Vm1iZWNJejRnTkZLUU5EK0dnajViWnpFMVJudEZ6bVE4TUJJRFB0c1RvL3Zm?=
 =?utf-8?B?R2F5dG5ZZERmK3pUSHBBeEV4QjI0dGRnUXVtRVFXYTlUdUdHUnJtcDc1c1Ry?=
 =?utf-8?B?QWxLQmxSZWszQS9GaGJYTWVYMzUwbDJ6UDdtd1F4WU9qNnVMbHUvMWJqNGNI?=
 =?utf-8?B?VTZnaWM2Q2RJb2IvMXZ6WUtEWjdMS1BxNXdSQU1vRGltVFR6bUtJVmJCWE91?=
 =?utf-8?B?eHpYYmVrdEgzQ0dSL0ZGMXJRWVVmN0M5Z25kZzliRXFKYzhvYWhVV05vd3U2?=
 =?utf-8?B?c2FOV1Z4MC9FNExjVUVXalhDcE1haEN0UGRNekVzRGhZRTI2TnRPR2pxOUNR?=
 =?utf-8?B?VCtscWRvSThOakJDN0pNbkdLRGUvM3A4YU5kbFA4V1BFQWNWQXRCT01sWU1r?=
 =?utf-8?B?WEtycXNzaGdPcWNKbkJjcFVRcm1TeWVWMVpoVTRNczlJeGEzRlNqd1JWdkhU?=
 =?utf-8?B?Skw4R1o1cXZERndENzFYdjN2TGZKRU9DL2JJaDZ5dG1OY2VtZFVGOWhTZmJa?=
 =?utf-8?B?SWU2U3pER0tvbXRiSW00cXpXSWRmMHNXSGhCbUN2VXZNLzFKOG9rUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94978ba-22c2-4f92-3d62-08df2466dbba
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:33:50.4197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qmp6JsQIkG5K7EJrGq/oWmCG9CAdOwbnx9gOm9Xf5QdO5wgrJQ/+hnAKo6+UPphk4R11GbmMPcxiImuWn1WJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB851160
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

On 10/7/26 5:48 AM, Alexandre Courbot wrote:
> On Wed Oct 7, 2026 at 12:43 PM JST, Alexandre Courbot wrote:
>> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
>> <...>
>> ... and that's all I could find on this patch. I particularly like how
>> the examples have turned out!
> 
> ... although maybe the Sashiko comments are worth considering too. Nova
> does depend on little-endian, but it probably wouldn't cost us much to
> e.g. call `to_le_bytes` instead of `to_ne_bytes` to make the code more
> portable.

I recall having this conversation before, and I've tried to consistently
say "no". It's not a real thing, and if it ever becomes one it will be
a very big deal, not something we would overlook.

thanks,
-- 
John Hubbard

