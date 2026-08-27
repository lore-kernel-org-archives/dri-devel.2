Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2ABC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F34810F0AE;
	Thu, 27 Aug 2026 14:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X9Kp0Z4X";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB7A10F0A4;
 Thu, 27 Aug 2026 14:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAqVO0eQYeVFTkVHh89N4ST+rpQCDcPQRWutf4snDKIJ3EFNxv7qrV5VCcBT0Ooqcc6Cm7LFTPnMhg8vElEoOmgkX0CKT8GE4ImEPfELz4TqxYU8I2yNuHfGpHNWEV6coCBowpWoUHc7ggcA+b9C598uQmSaKbTJ+iDQ0S2XAaSWSM9bZBa/KdI+vtXti9dJl+Y3XNeOYs76atfN0GiyJ0RT48XxVJgQftS57Y8E8XFoSKUKSnFv4kf8wEIFLSDhose8pgJzas1c7TuoxTT2SDDPsz3abHb1GGpL5GEwrDiMXljHth24Mujbibt17DJEz385kXHq+g0C+kxt2djjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPm6CPL/VgBth7tkV8IKMtY7jVpgG33ERp3iac3qKSA=;
 b=AAeSebDphSmMHMV96+waNeCCCRjiMrqnCdH+4ozY4mMTCKX6q2RxLcQYLk9AkOFcz+R7aP95Tsh+z4nR+/BmPOPkWnFEPX0/6OkH2374d1GwiFp1MOiQ9iS4qMpuI/UIO/8qS2/67ttX0vl7blihLxKvWHVj/Z5znQ8QWrZEtWkDg8ydRnx0wZz12IOEw/SE4DJ+wUdf1nfALnNpwC/OiFBacTOjPjHuaJWWEArr9ufawVZRgcgAAEhiQxWdX5KxRRZ0tzfR0udC6yG2axPRxpFShHQFNoaaj0X/8/oAa1c9loRa+2hgv4XUH0xvzENNWPDpD7zrbbJbJiylR1jlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPm6CPL/VgBth7tkV8IKMtY7jVpgG33ERp3iac3qKSA=;
 b=X9Kp0Z4XkpzDqY9VuZr9pW0zem8DfgEWGH/0Arg4hwjhFWVV//0RFHNn8/4HJJuiqni4aeLjRfZwxiHiUHjIYKaUK2/9tgp8zvu5yOhyJ4KufPSxw6H/1TPYs7PEfo/r+3IDBKXCX0cC+MZetLrOlVfwBGvhk9lZlzVikDuOH1d83yV60Fj4CfdsWkNC4/iC8SgubrPER4Uz3ZfhFtsLxWuHMotEW41lj1IrvA42+8rxMJoZamv/A6MPWFsPHt2numXnJAU6k9x9ePYXdShtx798N5Kb9cqp79NgKzwHdoJTEFK6Qm7RtC/9EfMroFXNLhZrdwXjPk5LCYnASPNl1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 14:29:08 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Thu, 27 Aug 2026
 14:29:08 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 23:29:05 +0900
Message-Id: <DKZSPZS1CQ29.11DHEBVKWF21O@nvidia.com>
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
 <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
In-Reply-To: <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fb29aa-2362-40d7-35a3-08df04478df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|56012099006|10067099003|18002099003|22082099003|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: upk8NEFyBPrYU79baXk/QZsc7SXgQzqt/dbRvVo/Lvy8RCmrxzC7nzUWiePwt5oMAdyiUZ7xmAa3OfHv/NCrloRATTB4PyC7mEd9CqsO6ueeTqlct04XjLIQJWhLuxPHvQQMzZ0N717OjJBTn3nMqQpSxmYuSJcrkDFqcjzpKeatMW5V9SlRXe+QHkxLfg0jiRo9Pxq9gMsqcquezavWCOpT2HUAhbRB1XsH//mupxqG+TgEMrFVjTyB0RfFto8kBmQn00apXephmMKRAHQmc7JbJAEGppYyzr8hpEoUk/mqvADUGQDkb8UYadv6jk1HOjRTthRIdogccfuFXR/9oJ/q08gFOhyoFET1kK7SPrskZHBiqsWUQfVEBDjPp6VIvBTphCCiEkJVSBZ2tbMrXVB6i/Tp6GfPBnFgWqaoZu7/0Anmk7ssnS0yvW9DVeKaKGa/nJ0xxJvJVsgrT+nHrkjXi9rkF3R71SPqgbuoXdgwzvJDTIe8jgZ/YepjHig0wDSDiYRW6zY6gwa2KweoSNIcay3sHhAxzraBz7GMzATAXzVWUajSbSgoqvWCOcfrrho5MwuJIjKfcgYawn6eHpLUhV2khUEjh3gH8W/Wjc542Tt+i+ZQrWu7QpufaTRdG9YGpft76a3/95C5cKoENc9I/qZbtjkZUyknYmYTk5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(56012099006)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlFkK1h6Q3d1elhTcDZDM2JmK3JvbDVkTE1YaWYyVHNUNDlrNWNLN3hWbHRD?=
 =?utf-8?B?VnJRc2ViMHFTMEVaZHBkS3pSSGl1bmxheFlDTkJiVURjdTZaQnpuUWQ1cDNX?=
 =?utf-8?B?aGpSaFlzTEdWT29UZUJQWm1veG5QWm1SZHJ1STBkNitVOEpPMHBoN0hzbGVD?=
 =?utf-8?B?YWpIc0p5RnVWR0ZwK1lWV011VTJwYnlWMk92RzhHYTVRemFsWEo1N3NCeWtY?=
 =?utf-8?B?OXlEcU9wMjM5cUwvZE1jN1JZZTNFNThFZ3UwRTZ0Qlp2VTgzMmZDakROYjFp?=
 =?utf-8?B?Nnd0QldPNElJeE5vcXY5WXIzMkRXS1l4bU1Jbk4zTXJhdTNRSXdPa3RZTmhk?=
 =?utf-8?B?TUZnQXRPWjM0OFl1V1FCbG84Snh3OWphN09TMk5FMk00S01adnlyTUpKQXZY?=
 =?utf-8?B?UWM5Vy9GUW0wMVlTYzN1NzRqZDVDeTBsd2hVL2UrM044VFhDbHRPdGNFbTNj?=
 =?utf-8?B?L3I0TU80Mmxpa0h6WUtQU01WT2hhWnBucnl5NGpZNzZYZnQ1SDhOeUV5b3la?=
 =?utf-8?B?aC96Q0djQWk2ZHF1akRYMitZQndoaUxXMUJncDhwUTZ0SUN0RXk2OURWQ2ov?=
 =?utf-8?B?K2o0aSsxaE9YYzFvWlRJNjdmQ3hwQ0NlcFM1dWVWWmU4UFVRaXo4VXN0bjh2?=
 =?utf-8?B?WUNPV1dzUm1FbHNYeVFpUEpwTWQ4VG8wa2R5YnhzT2p4ZW1sT2xpVUsvMnJl?=
 =?utf-8?B?TklwSkxpdmxuSnRZR1BNWnc0NjBlUkdFYWRLaDZyb3JPSVk0bEprRTRQVnUz?=
 =?utf-8?B?OGNBVzB1Y3JSZmJ0dmJ0d0lyVlZ6ZXBDWVl4TlkxeFBMWDJUc3AzSk01Vmsx?=
 =?utf-8?B?RjFNUmVXdlVxYjF1TGRXVTZvQkcxbzBhNzcwNVVWQVZCWXRmaUl4TUxNVWdt?=
 =?utf-8?B?SjFCQi82WDUyOTZ6ekg3REtlbEIyQzJpYXg4L2RxdWZIVVRUd1JNWXk0Zkc4?=
 =?utf-8?B?RkNiVWx0L3lxeHlEWnk0WDRYdkhCemVGT28vVlZVZGViZEhmNjUyNW5UMGxV?=
 =?utf-8?B?Tmd5RWVFWlJQQ0JDSnN5eU94Z1NjTHY1Z01DMEpSZG52KzhXQ0FwYjh2Nmli?=
 =?utf-8?B?WS9nVUJhTzVra3JMOHdMVzcxSklvYTVLU3hhejlwU1Rxc0pNRVE1Tk9IRk9R?=
 =?utf-8?B?VmdEdVZJYjUxblpURnZuK1JYSVJVT2U5U001SFljb05Kc3l3REFmNUcrWUFh?=
 =?utf-8?B?cjJNdG53ZGR4R2dXMkNsakU1TWhTellTa2tpazRmSTJwVEhCY1BzZEFUY2VS?=
 =?utf-8?B?dmtjWS9TQzRQZi9DNWNWWkxKaUc4WjIwS3d1UElOMFlMZGlZckJDRHE4enBF?=
 =?utf-8?B?cVhBc29RTUhiZXBUMHEwNUFKbHBXU052M0h4cnBLM216emJ2Vmp5dzVCZmtL?=
 =?utf-8?B?ZUtyYmlDdHpENEZ6dGJmbXNOMFpOd2Q1TDl2TEhjSzdWa0p6cUE1dWdIbkFI?=
 =?utf-8?B?Z0o2SkVub0ovQndZQ1ppMW0vSVRIUHNNSWg5SjVHcFAwbTlNcnQ4Zk5NZ2Zh?=
 =?utf-8?B?dTJhS3FQTzN5S3R2cnE4dkZSVWZSWlE3VitvYVdGa3lub0hnTUtCVHZOVmFW?=
 =?utf-8?B?UzN5clprdzIxa3hIRHQrbGRhRzZ1NlYzVmloQkZaWHVMR1dhbWhYRzdkOEx3?=
 =?utf-8?B?THQ0azJjSmgvU3NVVVJjMWx5aDFKZERicHhvODlVU0pSa0YzeGNrSkF5cHZ5?=
 =?utf-8?B?MTk4TGYrTWZENHdhS1hBTzRaSHdDYW9icVRobUJ0NGtyYU1OdkI0NmJoNGlR?=
 =?utf-8?B?SmI0UG5rUXZGNnRrdHRjeTZSbHJaMHBOdWVYRlZRU1dLTkIxYTRZZGV3Ulgy?=
 =?utf-8?B?bVJkeVVsR2dscFlXVElDdWxvY1FDWklGZXRZRURVZHF6d3ZrejBJVG5LL3hq?=
 =?utf-8?B?NEM1cnB3SGhiUS8yR0xBd25vb3VVQ3FGL0tISEpiaU9vVWRhbGhoTnRaa2lM?=
 =?utf-8?B?MER3eDU0eXIvay9Qd2RBZmxhTEg5TWhoaGdNRjFndVF5RGdxVjhuc3lXSGlW?=
 =?utf-8?B?YkxzdGk3K1lPUElDeDlEY0FpMnNVR1NOZjUybkFSMXhEVGpUYlppbi96OUpM?=
 =?utf-8?B?M20yVXRQMlgwOEw4OStiNzZGejJDdks4Y0FTcE1xRFlrVTlERkhKM0tMWXdp?=
 =?utf-8?B?WWcyd1l0RjJrSkxGZ000Ty82ckVhN2xzS1RkZXZqY0oxWDBoTVlzV0ZqUHFQ?=
 =?utf-8?B?V0w5U01JT29TQ0diRllqRlluenBVYW9TRWVCdlllUEd4cnFmSEVnMEh3a1Qv?=
 =?utf-8?B?MEZjWWVUOVlib0pnZVk5ZjhXMlV1THNCbDhMcXVDMFc5aVVZaWZMNFREU3lh?=
 =?utf-8?B?NUM5aGR5bEtiWjZiQ0srWnE4SjEyWmZmMGR4QmNDSkd1cDJlTXNEenZUUGww?=
 =?utf-8?Q?uKg3P6zlHtUbgqhi6P5fYKZrnbt/f57u7py0xY05EoJhw?=
X-MS-Exchange-AntiSpam-MessageData-1: 3grq3BtRkJc7DA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fb29aa-2362-40d7-35a3-08df04478df7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:29:08.3562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QzJNRBMaxcUrVJlEoBlW6W7ybLAq6aUDB1moAZdgtB3TBtEmflSoB2FsWt0eE+oJmK0Y4oNEcwIKs3c+i6sYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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

On Thu Aug 27, 2026 at 10:48 PM JST, Eliot Courtney wrote:
> On Thu Aug 27, 2026 at 8:12 PM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
>>> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
>>>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>>>>> unfortunate because it disincentivizes using it in interface boundari=
es.
>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for const=
ant
>>>>> value) takes a const integer expression and widens it to i128 (at bui=
ld
>>>>> time only) before passing it as a const generic value to a new trait
>>>>> function `FromConst::from_const`. The trait is implemented by NonZero=
,
>>>>> Bounded, and Alignment and lets values of each be constructed from
>>>>> constants without a verbose turbofish syntax. For example,
>>>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
>>>>>=20
>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>
>>>> This doesn't work in const context, so I don't think this is a great
>>>> strategy.
>>>>
>>>> I would want to use it for cases like this:
>>>>
>>>> drivers/android/binder/netlink.rs
>>>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_REPOR=
T as u8;
>>>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BINDER_A_=
REPORT_ERROR as c_int;
>>>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BINDER_=
A_REPORT_CONTEXT as c_int;
>>>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::BINDER=
_A_REPORT_FROM_PID as c_int;
>>>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::BINDER=
_A_REPORT_FROM_TID as c_int;
>>>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BINDER_A=
_REPORT_TO_PID as c_int;
>>>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BINDER_A=
_REPORT_TO_TID as c_int;
>>>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::BINDER=
_A_REPORT_IS_REPLY as c_int;
>>>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BINDER_A_=
REPORT_FLAGS as c_int;
>>>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDER_A_R=
EPORT_CODE as c_int;
>>>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_DATA_SIZE as c_int;
>>>
>>> `const_as!` [1] should do the trick for this, provided you don't need t=
o
>>> create a const `NonZero`.
>>>
>>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@nvi=
dia.com/
>>
>> ... but I agree it would be nice to be able to use this in const
>> context. And there is an overlap with `const_as!` that becomes more
>> obvious the more I look at it.
>>
>> In for a penny, in for a pound of macro code as they say. Since we
>> agreed on using macros, how about unifying both under the same `cv!`
>> macro, with as many branches as we have types we want to initialize from
>> a constant value? For instance:
>>
>>     // Does what `const_as!` currently does under the hood.
>>     const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BINDER_CM=
D_REPORT));
>>     // Calls `NonZero::new().unwrap()` under the hood.
>>     const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::uapi::N=
ONZERO_VALUE));
>>     // Calls `Bounded::new::<{ ...}>()` under the hood.
>>     const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kernel::uap=
i::SMALL_VALUE));
>>
>> I.e. we would have one extra matching arm in `cv!` per type it handles
>> instead of implementing a trait. The syntax of the macro would look more
>> natural (bye bye `const_as`'s awkward `=3D>`), albeit it would have the
>> limitations of such a semantic dispatch.
>>
>> Even the name `const_as!` wasn't really accurate to begin with: what it
>> really emulates is a const `try_from`, and we even discussed
>> implementing it in these terms in the future.
>>
>> I'm sure the idea needs more polishing but I think there's something to
>> explore here.
>
> Yeah I agree that const_as! is similar and if we had const traits we
> could fully merge them and have it always work in a const context for
> both duties (which are really a const tryfrom as you said).
>
> I am not sure about the suggested syntax (e.g.
> cv!(Bounded::new(kernel::uapi::SMALL_VALUE))), since it seems very
> verbose.

A bit, but what I like is that it looks very close to what you would
naturally write if you had const traits (minus the unwraps), so you
don't have to learn a new syntax. As long as it's not *more* verbose
than natural Rust, I think it's fine.

It also has the benefit of relying less on type inference, i.e. `cv!(5)`
requires the caller to specify the type even with a `let` statement,
whereas you could do `let v =3D cv!(NonZero::new(5));` and it would work
as expected.

I also feel that we should be able to support const items with `cv!`
today, which is not going to be possible with the trait-based approach,
so if we switch to macro dispatch we need differentiating syntax to
decide the arm.

>
> Alternatively, what about just directly merging them so you use
> cv!(5) (the non const context FromConst::from_const dispatcher in this
> series) or cv!(value =3D> u8) (exactly const_as!), with the =3D>
> distinguishing between the two?
>
> So this is what would work for Alice's example (const_as! but pushed
> inside cv!):
> ```
> const BINDER_CMD_REPORT: u8 =3D cv!(kernel::uapi::BINDER_CMD_REPORT =3D> =
u8);
> ```
>
> When we have const traits then we could remove the =3D> syntax I think.

Agreed that they should be merged in any case, even if we keep the
current syntax of `const_as`, the macro itself is hard to justify in a
world where `cv` exists. And `cv` also corresponds better to the actual
purpose of `const_as` (which is not, as I initially thought, a const
`as`, but rather a `try_from`).
