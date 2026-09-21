Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF924C982DA
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 03:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E2F10E069;
	Mon, 21 Sep 2026 03:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTftj8+U";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7B910E069
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 03:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx7Utdfo//81f8n85XYVR0HYhulhF4ByPuHaynOLh03QdCgTuI8xN5cqQoX0g5VJZzTL12WhETz1w+i5w20SbS7NtBMROzGqfSdeXdQpcf9Suhg9MTQNXbpJtOb8NtWnF8/Z/cRA5rnPW3tmTI/FvR0mq2pZftwiti9C9eHrT4ZAhXmlILbADU0Ni+e6LZVIqjTwLwq3hUCof7aB63hW5orbh6oM9ExCjXyZ4OB0Riu7YirQ7n1ys+J8lGGxJrRKlyVHfw8yzdZi2nzt4Z75E75EcPDvtsPAnQ+r9mFgntmlNf/bWq/TkQCkItOYCpIxYTx9wV6k0O3LBT8jahji+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cShGOt0PrgrVHYjx3SP20dejM2Zd5XxLECPi9APP9GM=;
 b=jD/GrNIki0f1Fayo02n6ke4K0ebVEQjmX8e4t42FsDwgs4E0iQ7dFmQhshfFleZ3qvIuAkRGoeg6ffYhIIQzF+QDSUEfOu+vGoDA4kKY7rB5imGwcVikGe81TUcRZ+7giLfLS3KHFxBEjzrJXeZcPhIimpPJdJOYLcigZG882Xrp/Yje9jzpAO4jkVBdaIuhhtiNvb+qMhlX0z0FbPBejryB0GtDlTj95yswrVBRCaMiLpLtQiBz9S+Q/fKaO9tG8MZRGPNbK5LekIEfHVeMoVzPq3fGJyYt0dv9KsSkbSdfP5N/+NknhJZkMYif8jipngFHz0xnZApnSxCFEwBkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cShGOt0PrgrVHYjx3SP20dejM2Zd5XxLECPi9APP9GM=;
 b=fTftj8+Uyo0gRFoLe4CqVatj/z41BCyPhi2DVGheLakyHHxbTRdr0fYrO+AA1jMGRwnZj8zwBTII+5PumdAYttA4DlWDEDimKdcj3TawkMqzH73Kor4jzbLH8P4bcJumfmhJFTl+Ygq82w6GqkojZXZfzH7f4qDXVVL8PfTXc3bVrTMz/mZfuwiOQP0OTCYaym+/lDRiqR2KIhNBOj/fDyOC4L//Y6XM3Htp09hSJmQcfe1v1SQgrKcqptq/FoXZCR/lSOG4Jk7l9CqewVnt4rg7H+HkFmq2HC2f/bvGnlFuueufRTOp32EWKBe9miVLb4PQ9EtKvsC03+/vHdoq4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 03:36:54 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 03:36:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 12:36:50 +0900
Message-Id: <DLKOI7QW5M8O.II2G717YJDB7@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Filipe Xavier" <felipeaggger@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Filipe Xavier" <felipe_life@live.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2] rust: impl_flags: add conversions for raw flag
 representations
References: <20260920-add-from-raw-conversions-v2-1-cef8e6e23ae2@gmail.com>
In-Reply-To: <20260920-add-from-raw-conversions-v2-1-cef8e6e23ae2@gmail.com>
X-ClientProxiedBy: TY6PR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1766a0c7-256e-486d-2365-08df179194c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O3OQrRPdkwGXUX4DE31+TUxEViIR4BA78eKnhu3vBlYntL9gAv5SqAckPiNwLeX9n5r9Ikg993ez+EwPtTiuxQc0z67FgKZPrx1E0g1UpUi7q5YLTXBPZAh0gBUHzxyTqGd2/YwECa/GFYDm3/s5jO3lX0dShoxbkvXxl3XTGYW73KvfVYCrLU3LF1HD7CUSnyE9fCvgA9cQhDAnGe3hAlKt9dpu7ZCQZMJyk4lRPrxmIuXVa7g++tR2dXpH8ND8RF+DzKJhxjvy/UrBoowu5wcpFBXMzdVi39utMtixCj1nY8tef1UPs/faGsunyDWZAd6BuJu9ggrbmwcbR042ZymKZa3Zs68LpHZ+kKe7C/fn1Tj2yEqIQtJMVQhT9wbgWAwFMkPmoqJ/yDTr11b4iRAZFMJxlMkZqsDwCded/kfKr0+dQKB4IxE1hlIsNQpQErQpd3H0wWtwsyr9q028Qx6zTZzDULwCEaQrZZ6YYb2ya6/MREMPa5oGPSmeK8Snd0rxOGeFNw8GOsYCQp9N9WRoG3K/3+CVyExZThwZ7kh9xwvfskInPyRaFiowtSbm1QlGWvCz0JJ4UbE+OGfAqLCkluuaJb387KOx8G3/LRE3WFcjkg7jrCg0mZ67McmC+fkYXaRaRg0jOjUK39sQ61xiYjNLxlPeVtaPrc4rReg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm5uczlheHNoenAxQ05FVjZqSmpleWt5Wk03YkFFd3pjOGJrUzNjUHpPOXFL?=
 =?utf-8?B?SlAvSVJGSVorMXFTZXBGZW9HeDVUc3k2ZzBXRFdnSXpibW1zZHVtWnFvSjcz?=
 =?utf-8?B?SEZzSFlVQnZ4ZFNzQjlCVEw1MXh1MGZzR0hBRzBDeS82UlpsQjZUWVpjSytH?=
 =?utf-8?B?ZFBvZm9kYi9jSlBTZkVVT21wamRPaTQ4d09EZ3VycXhCUVcxK3lzNm4yWFhQ?=
 =?utf-8?B?djNRQW8xWmlxcTZYQ0crd093bTFSZERkN2dUdTQ1K3pkRitKRTkzM2JaS0N1?=
 =?utf-8?B?VlAxdUtTemw0SHM2bXdkbGk0a1N2OXFUNHpyamsxaU1mQ3hlY1JOQTdjb1Rr?=
 =?utf-8?B?RUxvUG5WZTVsUGk1Zm1OZTRsMzNteDdLVEw5VjFDV0xiVUFyMUt5QUJEUlVk?=
 =?utf-8?B?dzk4K1d5M3ZSZUxtUytIVU9xdEZLaVdmamxFVExlcmQ1WXhBOEhwUFZ4Qnp2?=
 =?utf-8?B?K0FPaWw0NkR1ZjgvUlphODloelZaSEd1RDI1T2pvUCtSZXpPNHJwS2wvZHJs?=
 =?utf-8?B?ZklBdzJFZ0ZiOG9RLy9RUlQybUMyQ1RKN0NQaXVZQTJCZWh5SmlvN3pxbTdD?=
 =?utf-8?B?RkZib1BTVlI5c1pkMFFnb2pqcGhyTVE1MDJIMFlCZCtEQVNjZ3ozakFyL0lm?=
 =?utf-8?B?U2NRSW5ZTmRsMmg0T3ZicUo4eklOcWg3RGg1bUNPMWNqdXhXZmJLOEV2WUxj?=
 =?utf-8?B?NWJlYWZtcDZ4T3c5U1ZKYVVRZmZYUUlZZWphVEpBekt5TVBEdjUweWhUcVFn?=
 =?utf-8?B?WFBCakpSV1lkL3M5ODViMW1hRTZHZVFQb0w3dmg2MHVPZ010dFd1K1VYbFJu?=
 =?utf-8?B?UzlMbUY2aStqdzJtb1pralp5eDc1cFJkWnZwNlNOakk3M25kQXB4RHIzcVcz?=
 =?utf-8?B?cXViVU5ld0N4YVgzRXdtWlNNc2tRaTZNUjhaZ3lpWWNBanJYM2tKeDZlc3U1?=
 =?utf-8?B?UmtnaStnRkZwS2NiOUxlbVZGZllETFExRGNzamxqeWl4TU9uZWRGejl6WXZI?=
 =?utf-8?B?Mnh4N0J5d2E1OWtGd1gzbVhYNW4vZ0FXUGFURWtUYnJKWkw5UllvRFRtZWha?=
 =?utf-8?B?bUc1SGxuLzdRM0lSTGZjME1tRlk0UURFYVM1RXNoMHQzWHB0eWpPRDYxQUdD?=
 =?utf-8?B?SE9YaWRjbkZMSk12UkpLUGVmVDNjMGEvc0NuN0ErQnJZeHJid0VwTi9NUjdK?=
 =?utf-8?B?V3hKbm5ZT2pyMmRpa0RJUjhKcmtDdWZDa0hMc0U0QlJMR2ErQ1BmVFkyWkM5?=
 =?utf-8?B?SElQYTBsd1BLM01VR2hzSmh4MEMrMk5pUmN4c1ZmZzdEYnNRR2hSQjVpTk5E?=
 =?utf-8?B?OXhYZU5mcThyWXJ1R0RaM2JtNXdBRlZHQ0lkeFYvK2NVNGpPRHFocnFKUEt0?=
 =?utf-8?B?NHdCZmhuUERXbk1YRFNBQ3hnZzMvNGhjakcySjV4YUZhZU8vYUhhdThwdVJQ?=
 =?utf-8?B?SlhRVHEwSWYrTUdYYVJST0ZvaVRpM0d4cW9tRCtmRGlSQ3VPcEYraCtWUEJC?=
 =?utf-8?B?c0tmWEhkK3VVOXl0RUloYnhLZlpYL1JYMXpMWERSK0x1aG0rY1ZycnY5SzB1?=
 =?utf-8?B?RCt0d0JmSGdyUk10WlR1ODRjMktrcGVuS3lRdFZ2OW9XWmxQS0xlTzAwa3Jx?=
 =?utf-8?B?OW9BTFpFN3RtRDFFUnNBTlY5YUJaNEMyS0Z4cm5HelM4OGYxSEtWZEFFRnBw?=
 =?utf-8?B?dDN0RXZQMURrcC9XN0VKZzd5aVMrVnFia1R6ckZWTVVvbHBoeVJiZHUrc3JY?=
 =?utf-8?B?Y05jNE5EWTBTZFM1dWxBdlVvWE53bHdNaitPZk1rMFR6NEVXVUU5c1g1b2xh?=
 =?utf-8?B?VzJaZ20zeWkvWFowOUN1QkRQbUtRSFJnS08wcWIvLzltUVU4SGcrc2dmQmxu?=
 =?utf-8?B?VHhFK0FuYS8yaURNZ05oQk1CeFRjM1pZQTJlem93TjZxUU9JQWFybzJiUmp6?=
 =?utf-8?B?bnRuMWtmci9aZGxWaXZpUzFCckFXd2l0bnZRQU1VSStFMjBIUGp1MC9IcVNJ?=
 =?utf-8?B?OUhRWXBSbERyMkZoTXV5eXYwekVoRUIzQ1MxWUZEUjhaZjJtNy9SRWkrMFYz?=
 =?utf-8?B?eWNnL21PajJyQ0FFVGk1akk3Tno0SFVqNm1mYXF3eWFwYjhYd1NZeWJDdDk2?=
 =?utf-8?B?dkc5czhMYmt4UU1mK3FlR0ZsRWtOQnFPUGZwK2xBdGpkTUxSc3RaSkNIYmZT?=
 =?utf-8?B?cDFXVDVyOFJ2dWp2UlJRNTZHMkpzeUVTem1QUi94RVlROWNjdmFUUElKb0to?=
 =?utf-8?B?THROZXdNQzNPdTFYT2RVUGRzcldPdGtyUVJiaFpBaTNmUktCUkhiRGZydDdm?=
 =?utf-8?B?cGpMUmpUMmEyTUk3R2FrOGhKbU4wSFd4ajNOdGlDWEtDNUtSbWtEZWRCaEdV?=
 =?utf-8?Q?q5Rre3wTBmRHIfk7KwLIW+6Fn7L5ta0Z/7RyLIkSQVc1r?=
X-MS-Exchange-AntiSpam-MessageData-1: UTf+0DuAl/ldTQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1766a0c7-256e-486d-2365-08df179194c5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 03:36:54.6486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZca91Raig7MqBk+EkEK7/23azGgOh1lRiSYn7d1A8/CAtkt7ZGFKbj6/uS62zy/+0mwgTJPbAHgxTlELG/SuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179
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

On Mon Sep 21, 2026 at 4:18 AM JST, Filipe Xavier wrote:
> Extend the impl_flags! macro to support conversions between generated fla=
g
> types and raw C/UAPI integers. Implement TryFrom<Repr> for individual fla=
gs
> (exact variant match) and flag sets (rejecting unknown bits), along with =
an
> unsafe from_raw() constructor for flag sets. Additionally, add BitOr and
> BitOrAssign implementations between the raw representation and flag types=
.

This does 3 different things and would be much more comfortable to
review if split into 3 distinct patches.
