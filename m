Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE42C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839AB10E3DF;
	Thu, 27 Aug 2026 10:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AGCjgI7x";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50F8210E3DF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 10:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvpWy5prUKxWVYVdcYSg5K/NWUDZp9qnCvDY3MNNZZtE4Zw9NBWteOAD9sAUyO70QJ6aY8IfGw5mlKfKGQZYeV/ylbD6+0VTV1wCzAEAY9e2/mZS3+gEEEtVII2jZXwOncjHBZJejXKnrUTj+gtGGpYFmWdpVcIc4DPzNGZrhtbRXz2f/lA6kerhQo+uYJs9yx0CoM9bM2PFEv5NxfrxJCmy9b9HOVg0chOqz7knjZbvnjJTHekOcg9+EM7kaLKAOWGSoqSpXPscRCisin0zrq/x3I3Awl/zSYBi+Ix9jy61OL0tp2Y42mFvENR0Cem0C+/F4UfzRu0IEGl9+EMcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOstUSvGvsDFm3zaSmWG+zOrPwRH8Lk+vhw21hz/bR4=;
 b=pzNYhby24CbK1zPhNCCI/1cmBvWr6ae3TRmqwivcabzcQ+a+GiGxb9J6+OQRwaG72KAAKMYNf4HwVeLEOMbfO6kC2d/fHylslB+2gZtVlUT+b05v2vH+v9SxRwrs4oUZkG1u3sulwOMjQtWt8y7QPm8DIosUP86M58RIdeG4tlUrEK/aGPV+CMNaEZRzjot6SjBn+VhuZq8ZVYxP7WZUHdK+tf9vj95zFpz2Ma7H6MyBHvpzVwwCJYmNsHFFysXrP6YCNUISqVCSCAQ7i85H9QO/m60a3bjBqZjgklYowFUBXPnw8VCT4IefEOR7sQFopKRsz6OKxNG03Eln2eWobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOstUSvGvsDFm3zaSmWG+zOrPwRH8Lk+vhw21hz/bR4=;
 b=AGCjgI7x1sUthhLxfSvCJQaka6jREL2+S20hvlCk8E5emQhl26CiehgqJQsOvxkD1CgY7NeD8PEPL8Pr1oK0u2IJ1uOhDB3HJzUqYD8guASKWA2ShodsMCvI6b2B738432D1FnsBnYDvPYoioPwrN3I2U+t2dyV9AiN4qacjEcs1g7jWwUn/0K+NyFOOboLEtErkqVnzuWIeMYAv6pSNCMlQcF04nJ6BMWwDXwe30hviAbJqSf+xpsKOCXZSwdUWzoOmPrWqRRfSO3QrNLP8S4IZft1NUQIdU7LIDBYC1r7bbyHXUSD74Nz4/qU0C/OmvilUMM5/FKHYohNWUbqebQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 10:42:39 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 10:42:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 19:42:33 +0900
Message-Id: <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Burak Emir"
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
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
In-Reply-To: <apAEK9CUZICDTL1i@google.com>
X-ClientProxiedBy: TY4PR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c35aed-671a-40fd-2fdc-08df0427e938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|366016|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: IMVrI4P4248kjOqvATHMfBXFcEOsG5ox9OuwSoELNvLtGsBtoIL3foTxuQ2XkSzENn688AUxi07d9g4PxqmLxUYiwf6TyvWUuX7Viz3Ac/Z4pi/XT8Tndp+MkuZBXCEJUhydx1loOlffq679uDWJy33rvKT+zrhI9oeKEAqQOGb3WRc59urQxCzq3jB4z3TWw6Q0DyTFpFGvkGzSxbl5n4K2dHvCBlG+G7iCfwMJQfU/TOcxK5akan4xHPN6wRSWgq0XzcaYPHeRG1TQ1OuofrJ7iVj95yjVgyu0n/MzLo1G0vKe4b8JKvbjrvBq7JkZOZMevRhkLSrrEYFYb8rhUOZyDxhcHApKL5P/H7VEZHxJEhWTCJeCSFMUq7p/O9J/8cimT+tcI/gYwpv3mAbcXlUYZNhNRnczewG5Jsbk4JQ/NaaKxAQwyCdOyJLMYRlPx+ty8glTeK4OLjzAUeJCZKFwz7AHp5Heh8aLmJVJPoLToBB1YZY4IU+m+bIAoNxi6F1BaTMwAdV0Zh0pZGseNrwMV01ISEa3uRyLx+V+whXQ/3X/orrV7eJq0qBCV/zuzKcFWdq7nchIXan2iIDIo2+77JShumuxDZY1vO2Iri+liWRXfrNWJXRrtVPL8fPjFWjO5kDr/uJx4nRDCDODL2TyvrSSRv5WsyRoyed2pM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGJuUngxT3pIdEVEMUlTUHMxQURRR2R3TnhKOUl5M0JBU0syTlcvZkNQbUd3?=
 =?utf-8?B?VVMwcDJVRHU4UEdWOWRDaU9JUWFRRmY2a0xlckp5ZXdwclIyNFZzcDE5VXU5?=
 =?utf-8?B?QlFwbTk2QTRINkJkdWxOc1dCUVVHWEhodGlXdEE4YXBNZEFUajc1NXl1ZXdF?=
 =?utf-8?B?MWwyRE5TNVpCVEk4N2xMWnY2Yis5RmNQNXFvS0o3NEtGcFhqVW9wdkZUeHEy?=
 =?utf-8?B?d2RsWFV4OUxuMjlUV2c0MDVaSWNjeXk1Z0ppOGFWL2NSMDVkbHl2d1pySUJB?=
 =?utf-8?B?bzdieTh4QitwS3BNVllVOW12ZHhjbVBxTW02V3JKNXNQSlJobU1QRG5zazBL?=
 =?utf-8?B?cUEyVTZWQkV1M1pVSDJCMlIyZHNvTjB5Vko4NENvcjdYUUtnakpzaThMbjIx?=
 =?utf-8?B?dlNacVFlMGNFWnl6cTV2ZUF4eFZPU2lka1hnR2NjVmZLUEFBRW1rV2ZuWnBE?=
 =?utf-8?B?SElITGN5cFgyMTVlRTkrWjZRSHJwMmNOWUVINTFpdlIvb3c4L1VpcXY3eHI1?=
 =?utf-8?B?Z3Vzcm1QR3lDOEIrUEQ1YW1VUFAzVlIxNWlzbVJxd1pYbTBQK3BydkI1andr?=
 =?utf-8?B?ZkVpb2JFSG9HT29NNGdaeThBa25nbjhKQTl5Rkh1SStXWUY2YmZkdzREamF6?=
 =?utf-8?B?SElGVFAxQ2FFRjFBdmlOOUpLSU8waG95TW40QXMzRGRxY1AwSnRzYlVzZnJ0?=
 =?utf-8?B?VnhabEtYNTlTNWloYlBqdTJXV24xQlpFcmppbTRFSjZHTzN5cm9XQThKTVZS?=
 =?utf-8?B?dWs4ZHdocHJhbzljTlc1WTNldDF1ZHpUeElMZG9FWDhma2UyOUVKRFJiN2ov?=
 =?utf-8?B?alVGVHV4SGlQTGJUUys1ZUZ1eUk3cHp2L3I2dFltWno0dTJpL2ZBcnpFWG9Y?=
 =?utf-8?B?VHdFMjVHTW16dnA5b3hZWlJubHBlTEU1RVFvYS9CcFNMcFhvdXdXcnVpc29P?=
 =?utf-8?B?L20xc2pSUTJ6T3NHeGI5WXlrbXQxbStkVXBnS1NUcUVTVjBZWm9HOVkzUXlN?=
 =?utf-8?B?ejBaRU1jWXVyTzFWT2RObmNDYjUvVk85NUhZWTBPQ21FeEgxSVdMbk9FUWx3?=
 =?utf-8?B?V24yWkxoamxKTzRqZGlPcnZTaDZUS213WFl3cGhYZjJXR251Yi82YTRSWlJQ?=
 =?utf-8?B?MUhnK0R2bnhzdklTc1RENkRzWFZndFRoSzJUeThZcFRjRmFvMFl4OGl4dkY0?=
 =?utf-8?B?NWlwZWxOSlVXNXcvUnBhQzdwV1ZBWUZqWEFiU3JSOURPY1p5VlJRbzdQeUxo?=
 =?utf-8?B?NWZOVC9jY0duWjMza3pEMzBBTVJ3TDJtcVZvK3lBd05GdUFSdFFEMW5KbWgw?=
 =?utf-8?B?L0lOT2dnYU5DZUVSTkozNWwyZHdnL0F0eVUzRlAzTWY1ODdCczRnZ3AyM1hn?=
 =?utf-8?B?UzlEU2NXQk5rZnpYZWZTM3RkenFnd1FxeWpacUJrR0pPSHdyRFBFckttSDhG?=
 =?utf-8?B?M29FRjZCRjFITmNjaWdMRnFtN2FDSVJRdytOTWk1MjYzQjhZbTFWR2NaZGRk?=
 =?utf-8?B?Wno1VTZQNWxIM3RVNTdiWVplWWM3eDRsQXJsRzBBMUpuK3hYUnRkNlZSanQv?=
 =?utf-8?B?cVFRWjJXb2xxUy9xOW84LzF3RDhselBOTjVvcVdiY3lIeWZXenFRK2NSRzV4?=
 =?utf-8?B?V1c0MnRmMDFUQ05OL1dEeTY3NVJFeHI3YTN3eUJJdXU3TjlaS1hvT1ZCRXQy?=
 =?utf-8?B?MXdvM2pQTUFqY0dKSGpNVnloc05zaDBsMHlxTVlsM0tVQ2dKTm5SSWpSYmVU?=
 =?utf-8?B?M2JsZUxlRVdkUU9VUm1kQzh2dUtoZFRTVEVPR2NBdnE4T2NVTnhTWlQxbjQw?=
 =?utf-8?B?Vzk1K2NoUkJzNjFaYWZQc1N5YlpPSWVpMndKdkdIR3Fmd3lpcjU5bUhQc3J6?=
 =?utf-8?B?QS9QaUxtRmdIRWVvZnB5T0c0R1VNNUF1MGpoSkZubUFIRitqRkUzUWtLQWJ2?=
 =?utf-8?B?Q24vWDVnU09OTXc5V2MyemdJTlZCVG5pb3dwdEVDL3NVVEtyL3pKTkxWSFI4?=
 =?utf-8?B?NnNDdHBlRC9xK3FicmJFdjZlT3l5Rm5iQXc4aXhBYnExdDAyd0NKdEJscktZ?=
 =?utf-8?B?VmVpb1gwTW9FTjBiTWlFUlNtUzVwelAxaWJzSkZKc0RmQW1HeURwSjJCTW9m?=
 =?utf-8?B?K1dMczlOSXliSmo3NWVLRXRBekdxT0oxOEgyTTA4MkQ2U3FkakhnbEV3Sjc3?=
 =?utf-8?B?dW41OFFmRDB2dlhOS2lYZk95UHk4UGI0S0UwMi9pQXlOZyt0ZHBBOEFZeGxI?=
 =?utf-8?B?M0lzamZEMjEwY01BNzdWbDN2NFpzNllsZE01Yml0dU4wWGRQVWRyaVhRK2Vh?=
 =?utf-8?B?UWU3dWgvUkoxbDQ0ZHFLOU03bTBlTmVYWHhCSExVOUhISnV6VzNVbmVGUFM1?=
 =?utf-8?Q?pWxBSt8RIeTIipBJydi2UVexQ32gJU/CPP4GRoNPStnp+?=
X-MS-Exchange-AntiSpam-MessageData-1: 1xcWGX8iUaLUPA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c35aed-671a-40fd-2fdc-08df0427e938
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 10:42:38.6173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnR+3KMR056TNWOMpxGoolwOcYA4qEEM90zjdkLcsTzs03tXcuv5FFzB4BMBtlGatCPehIIfm01QwtM3Zqt+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286
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

On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>> Currently, using NonZero/Bounded constants is quite verbose. It's
>> unfortunate because it disincentivizes using it in interface boundaries.
>> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
>> value) takes a const integer expression and widens it to i128 (at build
>> time only) before passing it as a const generic value to a new trait
>> function `FromConst::from_const`. The trait is implemented by NonZero,
>> Bounded, and Alignment and lets values of each be constructed from
>> constants without a verbose turbofish syntax. For example,
>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
>>=20
>> Suggested-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> This doesn't work in const context, so I don't think this is a great
> strategy.
>
> I would want to use it for cases like this:
>
> drivers/android/binder/netlink.rs
>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_REPORT a=
s u8;
>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BINDER_A_REP=
ORT_ERROR as c_int;
>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BINDER_A_R=
EPORT_CONTEXT as c_int;
>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::BINDER_A_=
REPORT_FROM_PID as c_int;
>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::BINDER_A_=
REPORT_FROM_TID as c_int;
>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BINDER_A_RE=
PORT_TO_PID as c_int;
>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BINDER_A_RE=
PORT_TO_TID as c_int;
>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::BINDER_A_=
REPORT_IS_REPLY as c_int;
>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BINDER_A_REP=
ORT_FLAGS as c_int;
>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDER_A_REPO=
RT_CODE as c_int;
>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::BINDER_A=
_REPORT_DATA_SIZE as c_int;

`const_as!` [1] should do the trick for this, provided you don't need to
create a const `NonZero`.

[1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvidia.=
com/
