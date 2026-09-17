Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607F7C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6A810E456;
	Thu, 17 Sep 2026 08:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sTDMxzN7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD0F10E456
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAE4iAnmbK9jL9BYYDfp4tmgwM706I8gJlVntsDUUq0kpnl49ZTWx3XLtVfXhMd1UNa9Yr+G2ZKtiKZi7XEK5bujR0fR1rGM3RtgW2URQha/KCb014JLeHrxZCyY25DwneP4mk/T3VStGRCb7MaEI2ZtScCKhw86wIOZecALpKaR/A+6XAyStt7eXWSAGPOx3DchPPljQFOoLoUaw4feCDFQwTZSdbxT7Zn0Kh2Uio8FroyMANvuspEiwsfB7CSEoyv7SMPSVJ6sJTuMBFfwAPEh/ZkGlkUG8MwOITMJmWSTr1JC964F1/hx4YzvR2U3l3v676J+JoU+M3hp8T+EFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6YqSMupV275wuXtpux5PRKCTcBAtZPsvPAIJGKQjd4=;
 b=Cc7N3wDoTqjIuqJrjvmG7Gw9lot+yrB4J4AfTfMg6+Fd0CT/7F9hFlsGjqUc/etkKzs10mPYO8IuWHqRN+Dpm8AeagB8fQpd3WJBdOsd2GvvUxIz8RzRb+90qZvB1C0IUKImHdfyAHaAZpbrdXD7KDt+KToFS2qkc3czUCN10vfgl2xdc8P/466jvNf45m3uqgaBNi3MDvlBbV115In0+2sNt/VHYi/1GYlAvZW1X/3IhASPahu8QhIEifkWT8otU2w777zea9Pdl1rYqthq7xd5TarrWqloBQMAWn9EqyXV6FUPBHihAXKVASmzGERFVYXjukFGDIqeE4VN8ljJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6YqSMupV275wuXtpux5PRKCTcBAtZPsvPAIJGKQjd4=;
 b=sTDMxzN7FSLRXQHHdnlq4bFtHtqknIh9Z0wKwWTfOxVu1w+ZXgDLwkKxh5FZ7GzPgYt+SZPSdS1JJX78eQ+ksCAx4B6SqGug6ge0V6mBmivZl/rKT/psKPQxdBbyUXXd8vrEAQZcAxuHExXByQ1XTlUdJwCYfQbz5EK9p28gGw9q+jDyhRLWm+qPDqbb5srVyGzjNy3cXw6b3KbeOhsyu/5Miji5C5S3IXeDKRPmcTfuGcuFcl7/IJzw74epPRybk/SCi2I5DalvBbAsnJcyofZbaUaGKDrj/v+VB/z+iafLwjN496gbX8DTEccI94v+tMSzzS9QlGXkEm5Rl02b0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Thu, 17 Sep
 2026 08:35:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 08:35:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v4 0/2] rust: introduce cv! macro for safe const
 conversions of integer-like types
Date: Thu, 17 Sep 2026 17:34:49 +0900
Message-Id: <20260917-cv-v4-0-547ef5727451@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOwW7DIAwG4FeJOI8JHMqgp71H1QMYszKpSQcp2
 lTl3UfopHXazb/k77dvrFBOVNh+uLFMNZU0Ty2op4HhyU1vxFNomYEALQwYjpWboMjuIKJUyNr
 iJVNMn73kcLzncvXvhMsmfzYyfVxb+3JfY94V4jifz2nZD1o7QIDRaxDBKBUJNGofVJsDOO0M2
 hAjsq39lMoy56/+cZW97PG5KrngyjhpRIio0LxONYXkntux7iv8GitkN7AZpT1q2+4F+mfGRwP
 djM2IaIXeWXqRMvwx67p+AwTZnq1bAQAA
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
X-ClientProxiedBy: TYCP286CA0334.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e757e02-ad30-473b-78cb-08df14969698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|18002099003|4133799003|3023799007|921020|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: /C32hy+YhltBjVzSGaMRHlgn5ONLaBqNvG24IDmPlZwDQ3Q5rICJLkk5Rmi1lsOLjatQ062Onj5G9sbW99VDp/t2iTt5K6prLcWDBkS+9OS9UXUc67+kFovJaefMfylc8RF28Dpu3N1VY+PyK9ZeC/yWcFQVaM2siXq14FdU/rAv/ZsgLZEXZmawIMUt2vkSoTaWvdIFA8DtjzufN/+s40CaIm4EiZ6OH21EOVkvgCz8au2UQ1PVMl0Y24WDdOdpALqsKA8QAONK9CRoCc7dwmLv8+hY/C6GGDSElooh9OfpN+A5If6GkprzMqzeHpQFTFghIoPY2nPYq+aqeuqrWkdWtjmMui9F1D+3nYrfrLY7AqpX+gHKbLzeiZbtFHlm0ErnQg7gQUQpSR1frQb9e8uUXDdaDssp9i+HlUCPSG3AkrWQA+1gjr+KR+b28wDwaDKXxCY2r75rAXMjHj14plphbZgxrHCa73fz4yB71A+0+qVVKI3Nc0yyErgvlvD8OasfE7cV3MyuG7/RUBHHGh7xM6ldZZzgl4FPV5Oy29RZRt3cs4EqioiSGo0PWvGAVnMczqrWNK5vMWnwxh7Nvgy41/BfFcCt5kSJ4UT4LcuYBTl/d3nUfb17ST//5d2iJZSdNizXc7nPFhqa3tT4lgBWHnC7Ib/KMd2dayotU2ZZ9vuubGHkQSZYg0yitSzUQ2QLS4sbyIRTIWPPv9HMng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(18002099003)(4133799003)(3023799007)(921020)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHR6a2tlVmxCc1hsV1FsYmQwTHZtZWM1d3ZpTVMvWEVDc2tyVWZuL2U0T1hj?=
 =?utf-8?B?K3FaVUpDaWttL0hMS05SWmR5UkpXcnpOUkM0SkpqSXJUdWlPNTdqeHlXekth?=
 =?utf-8?B?RCtwUFpKTlpFK1V5NERkL1h4ZkEzK00xaEwwVUEwT3VWbis1cXp3TEg4K1Yy?=
 =?utf-8?B?UXh4anFwVE1jYjN5bngrOUNYdzI2UEoxOEpXNklOeUlFemczVkR6TzZLb0Ex?=
 =?utf-8?B?V293WDVmZWlHYW51MlJ0Rm1WalNwVWpvUFNkVC90aW4rOVR3eXJGdUNOTVNK?=
 =?utf-8?B?Q2dKaG5UbEpzbXJTNVhvbEppbVN1RWV6WmFWRzdoaGhDejlidk42SlRrYnE4?=
 =?utf-8?B?QlFUaVdGWVJ2YURKeklqMEJLeE54enhZYWpCaGttYWpkdWRyU1VXbzFnbUtx?=
 =?utf-8?B?OFRyOFVyU09JYzhlaTBPSXpJc2lUVEZHYlZBRE5XR3pvVFNLNHF6dVQvbGxa?=
 =?utf-8?B?b0YxbnVaRGNFMzIxTTZoVU5aWnVUUDExbDNNL2RETkpYUHA4WWVjYmhHM3RP?=
 =?utf-8?B?RytMZ3VwaXlBamhvcVdCRnRpZXhJZ2pMVVMrMkxuampNSUJwTG50U0JvZlJn?=
 =?utf-8?B?blU0ekVUczhkeW1SQnVnUmF2TlRIR3Ayd2F5VXAxNnVjUnBjVW1DT2tYSlZ0?=
 =?utf-8?B?aDh3SjR5eWROQmwrVjJ4K0hlTldGdDc2QWRranpFQjdmV0hIbDVyVjhGbHRW?=
 =?utf-8?B?Q056WHJmQmRkcHZqRUpVTDgvSGFUYW1OaVYrQ1IzVHJheFlZMnd0U0VUeWlK?=
 =?utf-8?B?MVh6MEtSZVhRMWY4UkEzSjIzdlBzcDhKRWtzUmxMTkxML2cyT0lPV0taR2ls?=
 =?utf-8?B?UEtZNmRtbFVwZzgvWGYxeFQ1Vk5FYVE0TTRpS3VNUkhOcHMzWmp0Ymo1RUh4?=
 =?utf-8?B?WmxSWHdpNzhKUHZ1SDR0WmV6cE1Oc2JoSFJOVTJ1WXBOWUNsQW5SNk8wWXF2?=
 =?utf-8?B?Z2srYy8wMXhIck5pejhuWHRWSlEva1c2VituVjFhSXpEcW4xZFJTR1BLNXMv?=
 =?utf-8?B?aGRyUU5iaVE3dmxCNVFaT3BnZFZsVHFRMU43Q3IxR05idjk3UFZFZXNKd252?=
 =?utf-8?B?eHY3bGMyemdiRzBYancreHViMEJVQ29nV0F2ME5wYmxsZ1llc09oVDNzUFV1?=
 =?utf-8?B?TmZNalJUZklkaTY1TTVnRmxhVVVGazIwQ2Zxa3VBck9nS1N6YVBXSFZCN0Mz?=
 =?utf-8?B?djRVOFdTbW80RFJsMk95WWd1aWZ3NkNQVVhmZHFiZEZabXdoTUxWNmZOV3Jo?=
 =?utf-8?B?NzZGYk9LRGJ0dThLa1cwaHZzTjF5L3RMcVMzQ3pOODAwNlJjbVdob2g3Mk5H?=
 =?utf-8?B?dzFyQ3ZFR2JjMVFUWTVSODZXZ1FzYUgvam9qaXNMM2EwVXgrMzN4cTIzbVRW?=
 =?utf-8?B?Z1h6Qi9mbmxjMzJoTjd3YjNTd016SlBuTlpacWlmZll5cGNvSFoyVUZ5dDJw?=
 =?utf-8?B?RXgzenNNWmh5aG1iNXF3WnVYTlE5T21wK0FaMzVzVDdiS0V3NVFzZU85cTNa?=
 =?utf-8?B?YUw4bWp0RTlOY2N0dVVtSmVJSzliT1JBMmlxZmpqQmxpVFhHckdEV1l3ak11?=
 =?utf-8?B?SzBXcEhBZkFjVkNteTVxRm96Yk5VWElEcWdRTWpGSDlLK3NpS0hCNlMwTUQy?=
 =?utf-8?B?MUd2enFPaHJYa1RIdVBqTUhtZk80b1FyeGplaXJVMnc0a3hQcW5TTVQxZ1Vy?=
 =?utf-8?B?ei9UYlo4NHVUck5kaVE5QjhtSGREQTRjZ1JBVWdoQlM0NUlhRXJDVTFmeHkr?=
 =?utf-8?B?UXlQWUJnUUpXamd1SlBrZnVjYXVhNXNpTDV6MVcyZGExa0cwVnNhWWRhampa?=
 =?utf-8?B?bHhmT1hiVG4xVnY5N3FhdjUxVkRzMDNIdkJMZXVVQU5hZW9paThGMDcvK3dw?=
 =?utf-8?B?MTQ1LzVrYVZZTmQ0MnZ2VCs2dVlnU0YrU3kycTBGL2M5MmVHb2k0M1lQM2RP?=
 =?utf-8?B?eldXc2xyVFNPKzhrUnpMVjZtbmt1cnNTQWVLZGd5RUQ0cHAvdTVRQmZBSE5Z?=
 =?utf-8?B?NkFqZWhraDM3eWc0WGJHU1RQSkRFOThPdjV0U1JNZHFHaXJ0czErdndsSHR0?=
 =?utf-8?B?K05XaUVNa21jdGFqenlIZm5NdTRnOURLQmk1RW1mTGJUWGZMMDRxOVBzakwz?=
 =?utf-8?B?S1ZFTVJPUnp2dTFxbjQ0V2l3bVI0ZXFsZ2FJRDhiOG1udEorZlV6NERHaUtE?=
 =?utf-8?B?Y1pDemdEbTcrOG1mMDVCeG1JaFFqUGpHUFE0QnNuNGpoUVFrcnQxRE9TbGFS?=
 =?utf-8?B?ZUtvaWNCZlBtU1liMXRyVE1ib2VvSnF1b2FVdUl2WFhiRjRyeHZjUW5aZ2Z6?=
 =?utf-8?B?bWo1RHVHU0xFNDhZT294RXJXK1FDZFgzYWxWTEZXOXRPRXBrUjA1U2JLb2pR?=
 =?utf-8?Q?gyRVaivHvwZg1waJdqPMHDNhDC0a4JoZeahLSERRynlPU?=
X-MS-Exchange-AntiSpam-MessageData-1: RtoDCM3hNKCDzA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e757e02-ad30-473b-78cb-08df14969698
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:35:11.7061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck9jXaMoCsnramO2R3hAdWiuQTiinAiDWg1ZurSU53NPWfrhXe+kaUSA2iJU73m0+wOrWeWoBYDIej445tM4qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
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

This is based on drm-rust-next.

[1] https://lore.kernel.org/all/DKT6WNPI2OA5.3RCBNYHHAFAD9@garyguo.net/
[2] https://lore.kernel.org/all/CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com/
[3] https://lore.kernel.org/all/20260825-const_as-v1-0-1ce712225fe2@nvidia.com/
[4] https://lore.kernel.org/all/DKYTZNAX6ON6.1K1372FFAQOF7@nvidia.com/

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
Changes in v4:
- Squash the prelude patch into the macro patch (Alex)
- Move the new code below Integer (Alex)
- Comment the explicit primitive arms (Alex)
- FromConst to make the primitive value for NonZero, Bounded and Alignment (Alex)
- const_assert!->assert! in const contexts (Gary)
- Base on drm-rust-next
- Link to v3: https://patch.msgid.link/20260902-cv-v3-0-0f90659e711d@nvidia.com

Changes in v3:
- Add comment about not using FromConst trait directly (Gary)
- Lower case on const assert/panics (Gary)
- match instead of unwrap() for NonZero + message (Gary)
- Add reviewed-by tags (thanks Gary!)
- Link to v2: https://patch.msgid.link/20260901-cv-v2-0-446bc69d2ade@nvidia.com

Changes in v2:
- Improve error messages (Gary)
- Remove pre-req for Alex's nova-core num->kernel series.
- Link to v1: https://patch.msgid.link/20260828-cv-v1-0-48a180dfc4c8@nvidia.com

---
Eliot Courtney (2):
      rust: num: add cv! macro to create values from constant expressions
      gpu: nova-core: use cv! for constant casts

 drivers/gpu/nova-core/falcon.rs                    |   9 +-
 drivers/gpu/nova-core/fb/hal/gb100.rs              |   4 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   7 +-
 drivers/gpu/nova-core/fsp.rs                       |   3 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |   6 +-
 drivers/gpu/nova-core/gsp/fw.rs                    |  38 +++---
 drivers/gpu/nova-core/gsp/fw/commands.rs           |   2 +-
 drivers/gpu/nova-core/num.rs                       |  55 +--------
 rust/kernel/num.rs                                 | 135 +++++++++++++++++++++
 rust/kernel/num/bounded.rs                         |  16 +++
 rust/kernel/prelude.rs                             |   1 +
 rust/kernel/ptr.rs                                 |  12 +-
 12 files changed, 191 insertions(+), 97 deletions(-)
---
base-commit: 66a2c223b620d844fe26c6bd4844d2a6a8c9dffc
change-id: 20260828-cv-8d4e952fc14c

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

