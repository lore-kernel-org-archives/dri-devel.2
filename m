Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9B0C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE9989D39;
	Mon, 14 Sep 2026 07:16:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NkAOHbxh";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D958F89D39;
 Mon, 14 Sep 2026 07:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLpuHYVSPK0q45gUwqDtXHON5O8MA/cAIClKl5CbbRImqC/oJ1/H2bQ2O09xdPpEODvzTa0x95uIYr0MkWQfHpSItCX+20fyM4OArmQnBjxehsZXOuiX+1aIkJ1I41VENC0suKeOs6hV+z7eIKmyZyh7o/6MMmtMRB/kQG/t0A1HIyOdvTjONZxC4LXec7tfa8y46gFrlLD1jXJILXzINIOSS+s9HwiYEMY8JGUAyVC+yUZEVtWRwRd9UYzynK0qwU00LU99j/Z8DHz0HCnIeKBJj+R95j+yIu/n6RxL1oLp5C+wUV99wtTj4DioTb0NBHvuu+YmcNTFYladqJh44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a0BwSPxivy3jFGs2kCTXh/7p6GYOTmkbMRkZ1Bdjto=;
 b=YfT7oHZsiL1GVyiOmimj8Tj9ZhqZIiSdOYC8tuMmpRf0P23Rsz4MYEcpz1XqR+1sNJfIHEXcMVNBzJFfQh4JoxFfuxRyHoZW7f4MBqNYIjxLajMAhl6Zr8ZQdWpokwDmtauoCMU8oPXFbMWM0uS7wKI6OZtYACMKWaOH8RYvxmpwm/wJsl/VRTP4Zw5aokaqD5B2LXFmYFKnxvb2zl/KnQbhw3QKetB7r9r+TOk0I+htcpYuNQ9Eqy6D2afj8Erh/K4MHq6107eT6SPuKXM+0XFMH/TbClGgtUPfVEhS8yVaxG/tFt7kC06V6zXQrQeRLZNFiSkBDCa3aSXJwoW2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a0BwSPxivy3jFGs2kCTXh/7p6GYOTmkbMRkZ1Bdjto=;
 b=NkAOHbxhneuPrQ2GAwZuXdE9kC+pbzrFiR4Naugh1nnpBCTbPAGiyMFmtk3EoXS3Mx0HMTzrKlZ6giRX42cjb5MPIUY63vHFGj3Ct5375mi/Cyj3cdHNMS2fOUaphv5iQ/5N2rK/rWPkSHxl5Dux7uJFM20hv2wpc2N6H6sOsdAY8LgWo5rZIdD4OxOQfHlnJAAaTAFbG+j4OTpfditVpSdicKxknbH89E/UKzoDKYt7ym0a4Aa/OeO1HodrRgk4ObFKCGFxFQKbgQ6n5Wq9Ouv1dAX3Td03Mi0MYzJHE+cDVEnIze747uxZYc95rZT1ipuDuvZff6oIqbUGozPJXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 07:16:37 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 07:16:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 16:16:34 +0900
Message-Id: <DLEUSN5KTTFU.1OWYCOS7KC3NJ@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>
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
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
 <61f1f28f-d76d-4231-b99e-4dd4a18b4fbb@nvidia.com>
In-Reply-To: <61f1f28f-d76d-4231-b99e-4dd4a18b4fbb@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::6) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: cb12f7dc-7b8e-439d-03e7-08df12301da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|23010399003|10063799003|22082099003|18002099003|3023799007|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: flJkZbDmgaF7pq8lOnDYbD8ntt0/7TBDWVzdWkGqt+AYRlNNLO5+fY+TCwFY6E3SFfQ1jWVQYj9wxNDiCAJJiMeTY9nRs3TIQeDZn9lFfy04TMXUuO1rtdI8FqT5L9QApCVWd9cjaadyyc3Wstro+MVlhWJNeEs/KhGwaoirWdkoeJgIvNJzH96zYFDjcDvAzl3Az3vL9VycehwX1u7L2SCTzSLnr96CPBYfWsEey7yOfWAjuGR/Ih06pMRXMV0KBaURU2ZEolbba+sdi5v6+PYEb5Tg2c4gd8nIbJIiTjS6WDt1l0YpHP8o3iG+mLUH90LiIdP9VmhMGxoa3xedFwSgs55YF6KGdf3A9cf4zSa/QRYvKkadifW++vF7LvnPIIsbC/itFIeSHMvMpfMgy2HHgYEdV88poAsfQODXlUQRIzjvWXB0PHPKck8u8l+14JPvJ70UrcC1ZZx2LuiXv3NYAqsZ6oKQjYJzdaR2qyaXbPDCfR9jgkBYhCC6skaKA/wUWjXBngA393bMk+em6ozoD8+D1oafiYjQD6aHOzIeiPUaZ5q//rHyN7pbuXtbVgKu7q0Ah1i0JT/lFJqEQzQ5Yu+SsIj2ueH5LQr1i4KaLN7G+ehP/vaSQTUAcljKYJ4nPWt60gxFA6UGYZ0Q2IICAS26wzf/7V9xcKBmSps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(23010399003)(10063799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFdNaWxXUkRYTTVLWEhoUnlySWRaNHdtSnFWMGhzSjdJMmtCUXAzUEF3NEt4?=
 =?utf-8?B?UHBXUk1WZjJ5bzRNU1FUeC9qRU9oNUtnMU9qWm1mdytWMVV6LzQ3aDN5NE5T?=
 =?utf-8?B?KzdYTjRkMmxuaHltblVlc1FJK25mR25KWUE1RURUOHZkNXYxUHlXbEtHQTBB?=
 =?utf-8?B?ZVdXTWJqRjVSQVFqbWZESXovR3ZBTDhiZDJZRStaMUVVZ3hPbzZjb05ZYzZP?=
 =?utf-8?B?OGJLUUpkb1V1aG85RVp0NTJZcnB3Z1lJZUpLUkRqZVNwOXF2RmpyRlRxbWdN?=
 =?utf-8?B?ZzJyNndWL2JJRUViSGhpYUtybHA0QTZBWG5TYzV0KzVRUFF2ckFNL2p4MHBM?=
 =?utf-8?B?MFNvcXpvQWRpNGdwZmpmSHR4TkpMUDdIZFBFdzFFVFpmMVNsNDRMMUFPNlhS?=
 =?utf-8?B?VjRRSHdRSjN6djl5Vkpqd3pxVkVQVy9jYnBlck80SDJGT1JUZkkwZS9EMmFF?=
 =?utf-8?B?TGtoNmkvekFNWERSOWU3cEp4aUNLa1NGWVo1WkJxRFdFN2tVRENFNHRUbEt0?=
 =?utf-8?B?UENKaWszSzZOdDdER1JNUkVmcjBuSUJsTXRkMHFIV1k0d1E4UkM5Y3ZXWFBS?=
 =?utf-8?B?MzEvWkZIZzdoanpRdmh3NHVxTnhyL04wcE5IYys1eFhHamdvVExuejVnbHJY?=
 =?utf-8?B?bGt3RXNIQjVXTXlpMVJCbm9lZHQ0bjg4S1dRclZyYk1aTkhGVEJuNGw0Y1ln?=
 =?utf-8?B?MXBITFY1Ymdya0pTZkNnZTZsMnp4dXVuV0FkNzRveXdndEdLREJ5QldLOUFW?=
 =?utf-8?B?dHFvcmNyY0xmUkxLbXFobE5hZFphaXpDcm9iMDN3cDJrQTFuTUl0RDZXaFJz?=
 =?utf-8?B?bFRkK2VwWVZpQ1Q2TWVtVlZTZDU5ZVlIbDBURlBJWkpSQUdBWUhyNFNBTHhD?=
 =?utf-8?B?WEJ5RG1VNnQvbjcrUVZ0YnRtbmxiRjVxWGFtdWlucG9qVWNvMkFUL25vM1Vj?=
 =?utf-8?B?bWhwenJ1Z0IxZ2hZQ2N4WE1EcHFkOXFaRm5ZeWRzM0s5OVllRm9MVHBRMHJN?=
 =?utf-8?B?QlFicnIzYkh6YUovTi9zT1djUnVsTlFiWHlDNXRVL09rd2lSb2cxRFlrbEdV?=
 =?utf-8?B?emlaekZJeThlNjl2VDFBYjdZQjlWUXZvSVJweGxlOW1iOThkbGFvcFg3d3Bh?=
 =?utf-8?B?V1lBQnFDQTRURUc5VEJ6dHVyU1BYejFhQWdSRzFDWFpzMmFDbGN6ZHpkUUc3?=
 =?utf-8?B?N2R0aU1PRG0rUFRVZlp5VGZmZXVrRGRMQ3RJSVZNVVhRbzNJM0R0c1lBK1RI?=
 =?utf-8?B?aG1BUWJLTGxWNnltaEp3YzVkbGZ3MjJzRVdzcVhIVjJYYXBnZzB1c21LM1Y2?=
 =?utf-8?B?ZzJMMTRLb3RMSU14Q1FheVdiZDdGMUxaMHBoQXNVTk82Vm41cTRPWnFZcE44?=
 =?utf-8?B?VlllbGprVW5PSTJxek1pYU02NEJWRTQyT29jL1ZvSWVHV2VjTSswamJpYzJK?=
 =?utf-8?B?Z2VyV082eU4vOXlZbzRDdlJYc2c1VHJabHZPV3FRbHdtWDZBK0sxN2dFSndO?=
 =?utf-8?B?azhBSmkvTFJkL3kvbXpwVW5yMDZRM3FRVlp2RzMrQUMrVTA1VTN0dVpZQjJw?=
 =?utf-8?B?VjBZVkhXWmxCZE42aUNib1BVUXZjMTFFdzJoK1N5MVQrZkoyd2JYTTdpV3hj?=
 =?utf-8?B?RGNxMDZsaHFTMkxzTHo3ejN5eHM0cnJVSVltRG45bWdOeHlkRmVjY1RhK3Vn?=
 =?utf-8?B?QlB4cGVtaGhjYTBIR1Ridkh4akxkTFYzditpZzBHZHE5aDYyTk5FQ1lBYjU2?=
 =?utf-8?B?R1BTbVhJL040OXN5Q3FldEVKc1NkTmhDS2dtRzRzamtQMHU1VTM5VU5mMmg4?=
 =?utf-8?B?c3dyRHhDRzRTK0cyRnlTNHNKZVdTdlRzT3ZrRTA3QzN5dUN2TDlmWTIrbUJD?=
 =?utf-8?B?VjVQMEZCUXl5bU5kZTlNWnFiNFk3Z0hsWnQxTWZYdmNuVnFlTWFsdldoSlVq?=
 =?utf-8?B?QWZJNWJGc3hMeEhjc1RxZmgxMVVRWlROWm52SStMYUNBckJQcUFYdmNnazhZ?=
 =?utf-8?B?MmJDcE5vQithNmtlcm50aGxQVXBaeVFSTXpvaGJtYzBtSjBTbG9OeFNwK0FF?=
 =?utf-8?B?NHh6bGtsTUFJQWExMXB3d25ZSVpSWFRCN2o4dmQxcWNGSUcrUWpYN3AxUVlj?=
 =?utf-8?B?TFVhZlpTYUtWTVJYMEo4bkdiajRoa1ZXNmJIOWI4WVFXbVdRQ2NHLzl1eENC?=
 =?utf-8?B?UUxTbmk3RjFVSVcxYWVMNHdaM1ZaSmZXVFpUYkkrTi9CY1IvcVJvM3dxNFhj?=
 =?utf-8?B?N2UyWFJLSStSWGpXY2I0cTgzSkV6R29xZWVQZERUcjBqbFZZOEVTUGlsTHI1?=
 =?utf-8?B?V25UL2k4L3BnMWF1b01oR0NzbXhSMU1NMlk2aVJIR1Y2eGd1M0pVbnU0R0Vn?=
 =?utf-8?Q?4LJPWuzxI68Id6AiV9g5CWjHmsNJS1OrswfG9TYjod0xO?=
X-MS-Exchange-AntiSpam-MessageData-1: +AdrGg+3xsA2+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb12f7dc-7b8e-439d-03e7-08df12301da2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 07:16:37.5782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfvjIB2OIFQOGMMJBjqousodmmIgiHh8Ho3jX92HO8MevHncqY9x0NlDTL53ziNKoCz1tn0ZZ0P+BUOKJ5gIhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

On Mon Sep 14, 2026 at 4:04 PM JST, John Hubbard wrote:
> On 9/13/26 11:55 PM, Eliot Courtney wrote:
>> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
> ...
>>>> +            fn visit(
>>>> +                &mut self,
>>>> +                key: $crate::gsp::nvkv::KeyId,
>>>> +                index: $crate::gsp::nvkv::Index,
>>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>>> +            ) -> ::kernel::error::Result<bool> {
>>>> +                Ok(false
>>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut self.=
$field, key, index, value)? )*)
>>>
>>> Mmm looks like this is going to be `O(n)` with `n` being the number of
>>> fields?
>>>
>>> This is ok for a first implementation but eventually I hope we can
>>> switch to a more efficient dispatch.
>>=20
>> I thought quite a bit about this while writing this code, since we need
>> the escape hatch to imperative decode (custom Schema impl basically). To
>> be able to get it down to a match on the key, we need to know ahead of
>> time which keys a Schema will consume. That duplicates the info from the
>> visit() implementation.
>>=20
>> I thought up a few methods but it's unclear to me which one is best, so
>> I just left it for now. Please LMK if you think this is urgent, I can
>> try in a follow up to improve this. Here are my ideas (when I say O(1)
>> lookup I mean modulo how the compiler decides to do it with the set of
>> key IDs it gets):
>>=20
>> 1. current code - just visit()
>> pros: key source of truth not duplicates
>> cons: O(field) visit as you say
>>=20
>
> Something about the visit pattern has always concerned me, and I think
> it has to do with the fact that people have been told to use it in
> all kinds of situations. But it's really only ideal for a few situations,
> such as updated a bunch of objects on a display, for example.
>
> It's not a good fit here IMHO.
>
> Is it hard to do one of the other choices, up front? If it's easy,
> it would be nice to skip this visit entirely. :)
>
> thanks,

It's not too hard to do one of #2-4 now, it's just a bit of extra
complication which is why I left it out. The performance gain is kinda
minimal since this doesn't happen in a hot path.

That said, all the options I mention here still use `visit`. #2-4 are
all about adding extra info to help avoid having to call `visit` as much
+ let the compiler have more info so it can generate a jump table etc.
That said, if you have an alternate approach, happy to hear it.
