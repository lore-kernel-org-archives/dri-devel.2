Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31789C5DF87
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6049210F29E;
	Fri, 21 Aug 2026 08:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8DeFqpo";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F9910F28E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amWYJEKhhvsGtZQLmDHmmi1lyo54QUqx3SNZfTCRLJuc0v96ug4lkxNJ4OHywvYMAFmu7WrcHTC4HzWkttYwz16t1SSruxgvMuwJL+R1i+4hNj/2hFOiiktk669B+8SWp9HK+roRulumizjv2KkBcQ/3Xo8qyWIXnZ7RvB/CWcm6heMmwA0tQSYUwz8RcsgL+4QltyjuAwfNB8J6IqjmrrNWSucdsA+bOsXbtKkTOv354OJcE8uQXs+NyUWyrZBCfoYb0nTyuWd2z0sMI33QGA5kikGAVmdMFdyOVmotaGsr+qMBhZ8CTmJPqR7RpcHw/tyzs721v5kj08xRNmjPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td7GL/p8o7BwZPEwauXS735kCktgiEBUVOsRUITTLQY=;
 b=k6GQzYrHFIggUxN5o3wejykfxuPlB6/FmPbK9QPeaqx12sBFOUONReDzjjdwdOF3bzVyTHhRCZDwDiUTsazKDQvyEZVVh+wtVoIjC4FC5RIh1iPi92f2triaKpiIrsVuwZjB30pdiNY0BammAlw7uOn5WRMkZ0YG6IF2RKKCB6LJmWncqxBjM1sDY2nQm1LCHijF77V4+5WJ2ivrKDjTzIgbPufAbrZdMOcAi2yMh8xr6qlX5WsHEn4IjZRfx1qFkcYEsv8Jruja2ma8qqiPkkEWf1QXXsk2xZANKLhZakVryK1+kgMZKt457pRg/E22HCExvfsOGMAudWm97R91xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td7GL/p8o7BwZPEwauXS735kCktgiEBUVOsRUITTLQY=;
 b=C8DeFqpoU2YV8H77SX9FMbqPiw0fvNbzkTYPOQ0+BeV5lngF8/W6S1HKReBjl7EM9dzGwVLA+MvoMctpD0cQumMZ5c1wlYIRj4CalBe2j3RbMjbRUAHy778fjJOWzBcTkLwl2o8tQupmX4lLzGvaI/gLE6P8quknEmyOeQcs25KVFINtnAAuUBD/a4F5KbuzzAJFfHDM/3aZIIq6WHVTWS38PhCydWmqLyh/ceyZAik1c2zevlzrY7LN4li3eVsbYw0tv0rnR9XT7jd938i4ACpUiGjPP3okbkv7PoYbpdfTX3zX6okHp309kN8f81wyI7dEGKtN483/ou0nECLY7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 08:40:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 08:40:01 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 17:39:58 +0900
Message-Id: <DKUHJF1YTTY6.1XXC1L2SYXEMF@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 06/10] rust: id_pool: take a NonZero capacity in
 with_capacity
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-6-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0260.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: e22f2ebe-1a44-4074-74c4-08deff5fc9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: UkomfKgBS4aKUrgBltmJZGk4nsByQEINU5mdJYc4PKcOqOu87EftCINXjdDo1LDgTo7/y104SCQWaZR80w+CoGuOu5aWTU0uCv2OFObUKgTrsCXskRXp/MB79Rl25Ol5KN8Wq25eUb52MAF0Q+Ps2MC7r5jrWOfNchSJU3PYTr+keXxchz6sUQN588odoYaCQSZ4+V7KOIyRXgdnKt0SyYnYT8M5An1iIaAsrcN7FVSKd33leFU0Sq9N8/AyDjho0GsxPKWuHR6RevY3/7/tLPYSr3XHEDbLmgMqss5ONtGkJai+zLV3mYoMABtBFAzquCLOC9aMIM2vBPowiN+mjwJey9H5aJlPvFOtMSArAZS6Rjt8UTHWDJ9ezYmNT8XVUp9xfwM65rvyJXJVoBUdGZHXU1KrH9DHzRam9sbwB8JBbuWE9hOWIW00fSqJW+k2uvio1BPGLRRd6n+gqVWleQgbKy2K9ycr/mSsu0uU6FEJXuGAME6tbMN3gliFJBw1ctLTvzUInBDOcUSIa4XAAOXuLlL/TgwJBthRIIl9A5OKsFeDyRbeCVvSiYaj+UfYi/7+ONer6AwluokDh6jx9a4tqhBecUbz404Csnoxd1k4KOhGEZrkkCOLT4+OFRJhMuJD9DRhdaZ3BuV3h2hTzq4XVyziJczFK3/ONlDkh64=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3ViRjNPc1F0Q3VBaFFNeU1hcCtkd3lLRHp2dUdsWTlMcllGdTcxQzE3dlVr?=
 =?utf-8?B?QTgzZlZqTTNXNFdMUzJBSzVYZGRqTzJrQ3BhMzQ2d1NwTG16eDNCajNVeHJM?=
 =?utf-8?B?eE1Sa3A0cEVFejI4TFl6SXVDNXp2ZThJWFBpTGxXSVJpdGV4S1JBN0xVUjlG?=
 =?utf-8?B?TS9kcG1sVE9lT1dRZGdhMUZsMG4rQkMydkN6M2F4UVNKeGkrMk4zbTNjL3VE?=
 =?utf-8?B?bjNoSmIrM3A3S2dsTWJyanJ5Z2hZWWMzWng0NlVDREZWZUJTMG9mOGh5aWI3?=
 =?utf-8?B?aUw3dHAzRWJYczltRkdaSk5rSlRVeDk2QWJtTlEwdHZtYWpQMTNRYXdNOWp5?=
 =?utf-8?B?djdDODE0WlFYU2pORE1NbDZneW5iMVhwRUxuaHBlcDQwTzR1QW1aYjVkY05m?=
 =?utf-8?B?bjI5WVp5ZXR0dE13UnpvdWphSlQvcEtTOFh4bTkwRkpVQ0NHNy8rL09lRnVW?=
 =?utf-8?B?TTRtb0JvbTBZUzdEZ3B6dExHcnhrSVFhVmxGdGJicHN2SmNvdWtxSHJuMWx0?=
 =?utf-8?B?VXIrV09wc3pWZUovblZtNFE4aEowTFNHbSs4Z2VBRHFtODJ3OHAxTGVhR2Zu?=
 =?utf-8?B?cnpoanI1cFhSb0Q1UUtyb1hqMURyalRGQXdRL25WaEk4OXBGQ1pJd1pEWjlq?=
 =?utf-8?B?Zkp3bFFsTFFkU3JER1dMT2d2U0pOdWVOQkcxRk50SUI1K0oxZmFBWEV2NDJB?=
 =?utf-8?B?WUJrWDlRRG9Sc0g0YlVaaHJxS0Q0amxXVW9Pc0R6MExoa3RUaVB5bkN0eEpW?=
 =?utf-8?B?WitmNFpPN2Jvcks3eUt2MjdWSEFXbGo5U0xyZ1huSTBKRDFmd0NNN1BsMm9s?=
 =?utf-8?B?Z3dMK1dBdGFpeGl2NXhDSktaNTIvaHVobDBRT3p0d3FzdVFraUQ4WlJZNjVT?=
 =?utf-8?B?M2ZBV0puTXdrWTNJeHFTSmd3MnNtenlvejhCTDNObmozL2lEa0E5d1Awa01W?=
 =?utf-8?B?T0l4YmcyaVdIZDNKOGtWb3MyR21pdnJSVnZvZTBUdlZ4TDJrM0JiQit3MkJG?=
 =?utf-8?B?MWdZR2NaMzRPUHJLaXp0YWVzcklEQ0FuV1ZsL2Q1TVBsRE91MW82MzBuRGFO?=
 =?utf-8?B?Y3NpbVRFaTgwN0NzeWZvaXplQ0FmZEFibGIxcHJ2SXVBSiswRzFCOHM4K05j?=
 =?utf-8?B?NFJLYTNMMUMvYzlGN2FkYXBMMU9aZEo1NFUwb1pzNCt1c0NsbnkvajM5cmxq?=
 =?utf-8?B?cHY3SFRNb1JaRTM2U01pYkNKOWt0aVhEQitBa1Q4aEdVQ0p6TjVVRnl0MlRD?=
 =?utf-8?B?NnhCSFlFNzFJc0N0Q0xwSWI3ZGlyTXlPTEpFWDZ5Z0ptNzU0UzZtdjZhd2Z4?=
 =?utf-8?B?ek1QTSthOFlWazVJSmFJSGNHSmF0RXVCMUJ6VE9IZzVhU09keU1xZUVDSXhW?=
 =?utf-8?B?N2cxd0dnWlpsN3Q2N2ExM1lJWk42dDF4VkEvT2FmWXJJdjhnSVlIY1lsQlFR?=
 =?utf-8?B?RURoK1NqYUhLM1RST2FPdDB2TkFNT1ZDUDhTZlJmMXdVbStlb01yS2xFdU54?=
 =?utf-8?B?djEvTVIyR0RhTkR3RURJMEZTR3pJNDlsRUNFeTBWTE52VitYdUpOUG1iL2lD?=
 =?utf-8?B?T3ZrZnkyNENub3pFeTU5Y1hJSG1pZ2V6aG1QSElobTA2b2w2eFVFMUpXanVp?=
 =?utf-8?B?Y3hrOVd0YUpDMmlQNkpwN05jK1hKQlNxN0t3emZ0QTdLSFNBSTR3SUo4YlZZ?=
 =?utf-8?B?Q0tSM1ZBZUpzM1gzQ0p1Q3NjN2dRMWtRa1FBcElvM1VDWjFTNlJHVE9TMFRU?=
 =?utf-8?B?STVwN29rcTVlbGd3NHpVZlRxa2Q5aGlxSDluWjlTeU9DTnVPdGdpeEkrb0or?=
 =?utf-8?B?MWdvSVkyMnA5OC8rcEFBMi9oc1B6VkhiU2tCZmN5T0ZrSW5KajlUVGt6cTg0?=
 =?utf-8?B?TE5sQkJIK0kwWVJtbDJ4YWZEZ3VoTGRjSCtqeFgvOGRGT0RQc3Y4ejN2NVZO?=
 =?utf-8?B?emZ6bE9vZU9XeDA2U2JyUkJKTmpWVitUc29uQXJsWUFGaGJ2UE9kUEl3RkRN?=
 =?utf-8?B?MWNZZDhCakZJaTlLMG9RYlN6dnBGdlhibjR1Wm40NXlaV1V2KzhHNGN5WEtz?=
 =?utf-8?B?alF3VDA0UGpjNGdLajc3SG1zbjdtUUxESTBHaTZ2dVErYk5meHFtOW5wY2gx?=
 =?utf-8?B?UVFDc3hTSU9zNkY3K1c2ZmY2dk5WWWxNNGZBcE9ReWxGVHo0dVZGc0I1T2RD?=
 =?utf-8?B?L3lZc05KUERBaEJDanZFRHc3dHZNZlUvVmhQMFhQZzdUZTJlSGJWZm9BSHhC?=
 =?utf-8?B?eHFIQytqdk9tTEh5Y1VYNnI5UnFJZVZ6VWp4OWpLTEVvWGdHVTFVS1JsTTF4?=
 =?utf-8?B?ZDJLbDdHLzYvcm9MSWlxSmk1dHRIVkF3WlNoRGJxaXpPU1ZTckszajZ1WnBB?=
 =?utf-8?Q?923F2X/6pUx6RAq+WZIk9pCbGs+LzqePtSWHWq1N8HXK3?=
X-MS-Exchange-AntiSpam-MessageData-1: pRD3J5W9uPie4A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22f2ebe-1a44-4074-74c4-08deff5fc9e4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 08:40:00.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMUAw2FhnxDvMxxsQgwmvxU8yD/4rCWkT5nvoA7gBqJWFZM7n48MUr9M5tTTGaEiqu83kv6uWlQORrUdaF9QYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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

On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
> There is no good reason to allocate an IdPool with zero capacity.
> Reflect this in IdPool::with_capacity.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

I am not sure this one is justifiable; `KVec::with_capacity(0)` is
doable, so why not here? As long as it doesn't introduce soundness
issues I'd say this is the caller's business; a driver with a legitimate
empty IdPool use-case would now need to special-case it.

Now we do have an actual soundness issue with zero-sized IdPools, which
is that `find_unused_id` would panic with `CONFIG_RUST_BITMAP_HARDENED`,
but as I said on patch 5 I don't think it should anyway. Another
potential issue is that `grow_request` would not grow anything; but that
should be fixed there by handling the `capacity =3D=3D 0` case. Actually
that would give justification for empty IdPools to exist: just like a
vector can start empty and grow, so can an IdPool.

