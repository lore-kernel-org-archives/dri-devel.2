Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9CFC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 05:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7976D10E2B8;
	Tue,  7 Jul 2026 05:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sAn2YMoS";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FB810E2B8;
 Tue,  7 Jul 2026 05:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecq9T3asVxOPETR9Ecv90aG6Id2p+fQ6ULntOQNd5cW7H/R5efCxjUPMqBW0/FuYMVvG3Xa3Ne2DQXPhifU+nvuBSeDC+OCg9VHcR1L4VLnYEJw4bBQHViHpZqI84HwuXy+wsbtsPv6eTBHxS+EtnbNYaAQYd2VRpiEZ3eSAwlcj55029SA5Ab0tcaGK/ajP598ZcpcSUJC7FrI5VXjeTcfRmsXgxBJI/AQfwqAC7LuJmPE0aD74QMDOXST2T76P+uTYeTZezTioPWPQ1MUIMXaGIGIbhpEZHg0SkeFOA9Z2MEPSSq6CE2dhoyPXvt6hMsWm/lREkg2Gi7IDlVfrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5uUxfY/57wPYPQJfF1PECWXZ/Pd9z+KoqpooEHW3pg=;
 b=EiUjUk08EMXVLidipwpf1CmHS+b5G9K6/ewV9G8wybU+ISKye4LklUDecU9XR/HSIy4hzT9YflHItNrzkAqZ2gqdMfcjFTvNlXk3zpoRO1HkOuKwfxZj930eRDarDJA2NkLs161QK44whZS43JmchqFYeocKkMSjys0Qyowlx2q8Hgasmx1OPM/ZzQ9nnEX0MnFvKYDLqLcOgr1dEym0VUQD0sEwBxgDNYd0d0cjMP4ku0dG0rku/0TZEOjD5BLFiaG2MMjfpK9XvECEGwi+RUMx5So9nLoSdqMObVzT4Ofx6O8EnwjEZgQ6jWeKE+dYR+MVHjg9V1GRvZqQDfF/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5uUxfY/57wPYPQJfF1PECWXZ/Pd9z+KoqpooEHW3pg=;
 b=sAn2YMoSz3oCQ+4Z/BSbaBnB5NwL4XhRUaroqbk/miuEGzQzHaPCbkaDn4B4iYzzHLwkyNNprXoptQNYy6/i98t8D+Yzq1kyD15xuNLMSPRcoU2a4ZlYqj6lrl9pecV2zkgBP3+EkdXV6aiAu/QARTS8omchtdvOiuzf4D42YlFE/mBh/pxyh0kuZ9XT0k2qTfES8z/S7JrxlOLaK/clvlreAAoGqh5txF5ddWWPFaalFzN6XScxRIaa5zSE1u/U5IOchDwDH4hEfm3lwfivV/4xCxTOGQRM5NZn+N15nnxbgPuW8RR8t6SgFglP//FO6TkKyeJ23i8MOPj0MflKdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 05:43:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:43:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 14:43:25 +0900
Message-Id: <DJS3LQASSSI5.2CW373BX9SNXI@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 09/13] gpu: nova-core: introduce GspBootMethod
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-9-5539d8469590@nvidia.com>
 <DJNQC1A84TF0.17HUBQBCRGFZ4@nvidia.com>
 <DJRY1GRYSM2D.38JVTWHGNBXJ3@nvidia.com>
In-Reply-To: <DJRY1GRYSM2D.38JVTWHGNBXJ3@nvidia.com>
X-ClientProxiedBy: TYCP286CA0263.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 550586f5-d792-4115-21d8-08dedbeaac0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|4143699003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JxpnyY16KTEPztcAbraGCMhSXQ12v2TfgqC7YstKzMhOt+/RqVx09thGlArFDWzJMLroA3DO7OpidoAhaf8e+iIdm0tHANT2ZvD+rPjsFW0y9sNckB59sqAVVfurfqVPURiZECyCXNUyTq39GjnPhrRpuESNVkQEW8eF/oWL4yx8Q7+dFXzP3DycIojo3DsmiTW7qI1zlE03ud6Se++bnZqdDPExjQ/+apDDeBfV4lGI6EhpMoHFzg+FHKMLxyu0l8dD3xhCdqELFpfM+88eaCKWITOwduL719MM7i7QoUcT08D1/mKFz0eBklr6RNRERoiWYYKmOqWkIWFgiVRZZXkoFyNhxfEq8jLeLObqCrzfgGZ/QG5TCddMSSYS1NBWQPfJTcQCjIVw9r4eGN4pl8RgU8Cg+cj9f5Ozo/wRnqmIAHFxivI1sQ24WUwOciytwjGos2rXrJry5z5Rsjlv1R2hhXJpbJE2OimHSuZyWDEmaAaatgN3xVe9CuLpHXcUTAQqhyZ5qvE5Ly00YSrhwypkqCnk91WNb3dUvnlXDX24f0uIeA9HOr6sR43wzwI85FxdvFRS2qHFPE6t3JAcE123QGm0DecHuUjUbr1fcejcRATYOzWmzGNgdMb40m1LCJ1W5PsZu/B/TD4BpUZDd+o83W8gOwfD0nQSFTicOBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk5JcWd0L1dyRUZ4SW9JcHE0a1BLWkdWcWNmMTF1b3NUMmV1R3VhUGQ5R3BY?=
 =?utf-8?B?QkF1ajlPOGhnUmVuSGRqV3I3OFNNWS9QazhFYXhhSWN0cWlLKzFWdFJEQ1Ix?=
 =?utf-8?B?R3JKNFJFN0RTMzNNdTl2NlhZTDhQQmdFVGNrWCtCWFBaVkZuZjU4dTF3d1Ri?=
 =?utf-8?B?SjhDRXhEblg3Rm9GVU5VblR5MGJ3Q1V1NW5VYndCTUg3dDY0MmRNZlhoNUhj?=
 =?utf-8?B?KzR0cUdtM05ULzBNWHFLWnpPdVlpSDJIZ1JqRng0eEt1MEROaTZMRDk3ZlpV?=
 =?utf-8?B?MCt3ZWZOWG5ucEtZTGFxM2NjL0U3bWg0U3RYeWRsbkVxT3pvYzVRajdRRmVL?=
 =?utf-8?B?TjBYYXNRQ0dKdmJuY2g4eFl0QmtjZGRrYTFUNEQvd0hsZjVFUTVsNkRMV1Zm?=
 =?utf-8?B?b3FGZFUyUlAzS0pBai9uWlg5RTArYjZnVFM3TFl0UTREalY1eUIrS1d5UFpl?=
 =?utf-8?B?Nzd3NlM3enFmWkI4RXVYRVhFL0VPNGtFeHB4RHA0RlR0Qk1ZU3QzNVdIdVNN?=
 =?utf-8?B?QUNzZ2tGYllmYVE2QzdSSTVObGMyTHFGTTE3RUIxWGVDVzZFUEl3RnFYTjZS?=
 =?utf-8?B?SHFXU3N2TkxHa2Rvd015VHlZSmt1UXhQVWpmS2JxVDZCOWp2YVFPWGpSZ1ln?=
 =?utf-8?B?cUI0dURKajZFM2UzbURIa0p0cG41TXV5Q0dLMVlvREQ1S0VUcy96cWtCVkQ2?=
 =?utf-8?B?YkhaSGJpUkZoTTRZbG1sWGlMaSsxdU5nSGp1MnlXMGxVYnRQV3JqUDlKV21l?=
 =?utf-8?B?RjF3RzJaVVN5ZDA5Z0t4c3NzbkpSZW04b0NlVFFDSkgxWklkRlZ1S3pSanNH?=
 =?utf-8?B?VGEzV3ZvSkk0RmlmclcwK1IxN1BsNXFqN0N3YWpTZ2d6WTdzcnM0NlljYVBE?=
 =?utf-8?B?Q2s0RFo4VDN4WE1SdXdzc2Npb0lVNWtxbi9SWFJSaU9pN3ZjV1pKdDFLd2ZP?=
 =?utf-8?B?U0NJZ2VTTEk0NFhsUGdURkNwaFN0M2liQzNTRlE3YXdwWWlRYlkyR2ZGQWV2?=
 =?utf-8?B?K3R0SG5LRXhmYzlna0NCZ0p6NCtiN1ExM2NrQkFnS3JXbWdITmhZb3NucFVj?=
 =?utf-8?B?eVcxZHlnQy9zZlg5YVc4dHFtU3pVME9UdDk3ckt5OUxLaHhETlNWTHFROFRh?=
 =?utf-8?B?dUNJN1NXbVRCYXA5R2VyU0xYbUtVOVVZN3dHczVYMmIrMWNscHBRRjdodjgx?=
 =?utf-8?B?RnNJQ0NNMlVuWThFWjEwR3F3N0g5ek5LcTk2cW1Jc1drcThRN2pKRWduQTR5?=
 =?utf-8?B?UEN3cXNvR1B2ZFZjM0JTckF5cXdqSXY3bTVUMGJENHA3ZENtanNsRnh1S1B3?=
 =?utf-8?B?b2oxVHZNNk5OVWlYNUFzTnJtZWNMUFBONHhLRWMwcHd1OG1rUmtEQk1TNjJY?=
 =?utf-8?B?emk4a01yU1c3MXZiNVArK1RRN2VxeVFoWVpwWGw0V3VobU4rM2RmWVhnWFpS?=
 =?utf-8?B?SnlJRElxWnF6dlM3ek1VVEJDdnhVMXhDZmN4dEdUV1Fnek12TEQxb2I3RnBo?=
 =?utf-8?B?MnlRd1p5T2ZHZ3N5ZXFNd3J6VnRMS3hvbEFpNGVrc1pETGJQWVB3cTFwVFUw?=
 =?utf-8?B?ZzV0UHZRZnpnbzZGS2RTWXJuenUya0VGaFBJdzhnSDVTSWVmUmR5amVtcHJX?=
 =?utf-8?B?Uk1wMSt2bDlZU2xYWmY3SGVMWjBlYlo2aVN0cXE3NkJwcGx6MVB3RExwSG01?=
 =?utf-8?B?OWpFTm9yUVlDWldDZjBaNXBDQ1ZrTFFyczBlb1lZbSt1ZjFMOHZZZk9FdGtI?=
 =?utf-8?B?RSs2dlNCSWV3MlJnQVpCVllVYnIvMUpTMFpMVFI0S1ZwRW0vdkhVZno0bmQ0?=
 =?utf-8?B?UmdkZlVKSGxvRkVwUmgzR0Jkek5sRE9UYWJtMUUxT050VVZPTThtVjJyZ1lB?=
 =?utf-8?B?MDBWTzR3OHp1Nkd0azhoTzhUSTVjd0FCQzdCZHltb2IybXFvWnRWanpvSlVN?=
 =?utf-8?B?OG9ab3ZZZlBrYnEycWp4VTAzdzhLdHhyZmp3VEtjcC9acGZnaFhydTE1N2I4?=
 =?utf-8?B?Y1VSSkNOZUNGZkVMcnZwVWlPM3VzcDBLYTdudzlZRUZLS01XTDBKNVV3cnQ5?=
 =?utf-8?B?MmtLZnhxTCtjVWM2NHFHb0xqbTkyeVZIR0p1Kzh3bHVVMFFCb3NVaWxkS2l2?=
 =?utf-8?B?WmZ4TkVPRGFxZUZVTEk2K1NxdzVHaEx6WnJNVWJRT1Zoc1g4b2xCcUdGbFlt?=
 =?utf-8?B?M0JFbEFNZU5KMmZacHgzUFlPSHVNbVdaRmVyZVlXbnhVSEhQL2xIUFNYbzU0?=
 =?utf-8?B?RkZxb1EwUkdReis5TmFPM2FiSDRKemhrWE9OWmhOLy9Cb3RJd3c5ZVZaVXpt?=
 =?utf-8?B?MnJsVHU1NndhM3ZVTzFJTUxoaldPWEZmZ0J5cUhiTGVRNW4yZWN0R21LM3Mv?=
 =?utf-8?Q?NYwXVXze53HiWbxPv6VHo2p4vZ78zTxzn1TicgjGNZbfJ?=
X-MS-Exchange-AntiSpam-MessageData-1: S8vc3NRuB6HGxw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550586f5-d792-4115-21d8-08dedbeaac0d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:43:29.0679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mo6XHs8KBjhNGkhvXpYnILx2r6v0UiEabKanPCYsRQNihEDUfkNoOP1prNeBasNJQ4CdZ6LlWuWSbd/tKuaviw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

On Tue Jul 7, 2026 at 10:21 AM JST, Alexandre Courbot wrote:
> On Thu Jul 2, 2026 at 11:28 AM JST, Eliot Courtney wrote:
>> On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
>>> The GSP boot method is currently determined by two ad-hoc methods of
>>> `Chipset`: `uses_fsp` (a boolean telling whether to use the FSP boot
>>> path or the Sec2 Booter one) and `needs_fwsec_bootloader` (another
>>> boolean valid only for the Sec2 Booter method that tells whether the
>>> FWSEC bootloader must be used).
>>>
>>> This is neither extensible nor sound: the combination `uses_fsp &&
>>> needs_fwsec_bootloader` is invalid, but can still be expressed.
>>>
>>> Thus, unify these two predicates into a single `gsp_boot_method` method
>>> that returns an enum type unambiguously describing the boot method to
>>> use. This ensures that no invalid combination can be expressed, which
>>> makes matching sounder.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>
>> Ideally we would not need to expose bootloader details (needs fwsec
>> bootloader, mapping of architecture to GspBootMethod) outside of the
>> HAL, and also not have to duplicate the logic for determining
>> `needs_fwsec_bootloader` in both the HAL and Chipset. One thing
>> preventing keeping all this in the HALs is that we need to know the set
>> of firmware files in a const context, which can't go through the &dyn
>> for HALs. I also find it a bit odd to go Chipset->GspBootMethod->HAL
>> which relies on the GSP HAL being entirely determined by the boot method
>> which doesn't feel generally correct to me.
>
> So far it is a good mapping though - the only thing abstracted by the
> GSP HAL is how we boot and stop the GSP, which is entirely determined by
> the boot method used.
>
> While I agree that not exposing these details outside of the HAL would
> be nice, at least for the time being we need to - the creation of the
> `Fsp` happens at the `Gpu` level, and is now conditional on the boot
> method. Thus the introduction of `GspBootMethod`. I would be happy to
> remove this in the future if we can, but that doesn't look possible
> without more refactoring, and this series is already doing quite a bit
> of it just to move the `Fsp` instance up. I think going further should
> be a separate effort.

Need to give myself a self-rebuke here. :)

The only thing that still required the boot method leaking out of the
HAL was the instantiation of `Fsp`, and that can also be taken care of
by adding a constructor that returns an `Option<Fsp>`. It integrates
nicely with the already-existing `Fsp` HAL, and combining that with
Eliot's idea of providing the firmware files from the GSP HAL we can
remove the `Chipset` ad-hoc boolean method entirely, without needing to
introduce `GspBootMethod`.

This makes things look cleaner overall, so I'll use this approach for
v5.
