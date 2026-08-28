Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B155C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EFE10F3BB;
	Fri, 28 Aug 2026 14:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Ru2c2rSy";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021087.outbound.protection.outlook.com [52.101.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95ACD10F3BB;
 Fri, 28 Aug 2026 14:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YladO0jmLSrtpCoT71mzgcVskuW39uB4gD9PBTaNJBjJrjQ4YFJhQwa2PmCGZSmvs5vCKz7pLvsrNj9x95diAJZ9wsx5oGYTP+4PIjC5PApOTobMeYodXQvC2tK7j9jbD60g98XWFCcVx8f3fN1AHRUfyeAvh3i9cbBLMrvM3+rZe7Ggec0J+Gs/EPcJ0Iq24aSRqpGZLvJwJzhPPFlchFim0nHUZXpFcy5yotQsur/aHyaYSAJSug5nK5PP7waT3+r7jkePH7SCqQXEdNW2lO1vj3DEPX4iKk5RRN6A0tcRYQtV77dNr33eNfclLdS3vPJ2S/hEsbQl4SlgG4soTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdyGjk843Sk8wx173J6rvqs0+wEcDFcVTdeNYUk5Rho=;
 b=ZkIE28nYli+tSxGSiO+Bgjb6OFxnT4TOy8v2Zpk7H8GUBF8mI/Bsugou3fNwABLW6fNCEj3O1jVeCH4VsjEY3RlFqOwY4OtqR0qhmAGNTQWB3xkgvGrJNOlKHXRExJr04Dn5czmKhKMhE3cQYNLhcm/Dzypt4o06RoR6sb4g6uQLBvk6DbXB9NCHIyUq3d21Sd0zXaf2ehwO1NRLxxEtT5isHKrp/Ew9AshGE58AZqmcmvRg5IS54U6vOkViSuHPSRFaCSvUrig39IrxEOtfr555nU4IDz55z6j6i6kO6okPIKQex1FxfE/hJZP/B1cEG8lQe8CO1q8/R9huK9y6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdyGjk843Sk8wx173J6rvqs0+wEcDFcVTdeNYUk5Rho=;
 b=Ru2c2rSyCOv23Kc1yB8fD2PwdIcN1FbEOndfJsxOtYtOlYpJv9Kr/PI0t/ePItZVcjTV/zez6x87Lgr89DNyFZv0oG6DQLqFrZTQ1mKshb7M3sYYcExHVxFfU8OZ0sVIqjtxudhX2oRTlH8Nu2YRb0qkPghz5WczAKseqBUfS1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO0P265MB2987.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:183::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 14:01:17 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:01:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 15:01:16 +0100
Message-Id: <DL0MR8UA653A.2UW85DQ9H0HXQ@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Gary Guo" <gary@garyguo.net>,
 "Burak Emir" <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
 <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
 <DKZSPZS1CQ29.11DHEBVKWF21O@nvidia.com>
 <DKZSWB7OFDRY.1QKAIFC1QP9RA@garyguo.net>
 <CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com>
 <DL051FB1HOBY.2UC911T3M9AIS@nvidia.com>
 <DL09JQ5CRJLA.4Q6OTGU4CMWN@nvidia.com>
In-Reply-To: <DL09JQ5CRJLA.4Q6OTGU4CMWN@nvidia.com>
X-ClientProxiedBy: LO4P123CA0492.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::11) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO0P265MB2987:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e76b95a-eb52-47fc-253b-08df050cd490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024|23010399003|6133799003|3023799007|10067099003|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DoOZGb0x8ekJMPeoRZeAX440pdKw4+yScXWm+ukS2QfiGaJnTXgFiN0yV34ERc7FoEHPHOgbfOcGv3CfP+4QQSt0CYMgFgtTt56ekFSA6auEZ0POYzCDEFZkfVsTYtwlAxDFatk4jNrQcmKHv+zt0cBCk98v5P+eb9GbfnIjvh1ubso7F8zuMht7wj1wVgisSq1IuQxaPVB4zAe6PPDyZXZaPFvkW2zilnEKtGTF2DolFp5EFnGGw639g+a4cjg/0cRc9aBcrJ3uT0hIRajujNDlIb06t7xEPfymeEj9QM6kSpnJUvBY6aNGAS3lUhVvkv7Q07KFHQvQ3/hMrvR77ve+Gm9Gd18YAokPI12fXLfDu6x1M1cNLVU6jyz+YRbuLvYDBwpXloyOijfgvXxmUBZRGCn82yU2PKiZZdpU1fgF850qY/FADlrqRNRu5lL4DjlrdFeBkzlclau1rUvlDypE5tCWfSR6TlAnYs5JLbs26qV+DdC9Kii9WMfp/ZGwy5tG6Q3/BAnMFQsvnig3NykXIDCIhpnIWapLmevNGAhbjEnLZgyIzc5ofgUWQnCqaTAwgpunFonoJaLBhS7gIhSc0QJ+BiYz7Y2GeOR2CW6nhNQnU/HGInrP+wNmqiq2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTBxWGNmYUNaR0RON3ZyQjB3QzBWVGVGb2ZTUEVqNEZLTUdzcVg0NDBNZm9M?=
 =?utf-8?B?UDRGUnZJNHZvUHozOUVZN1FJWWcvSXR4ZXluY05ObXZpRkFKU0lGbXRIR0RC?=
 =?utf-8?B?RE94UXN4MXJvTzN6Q2hOWkxFa1lKWjNvUFI5U3VJeGtmbDRiZ0x1bG9BVTdQ?=
 =?utf-8?B?Y0c2eWxiNU0wNmtVbFZiWDU5alNRQnFEMnVjOXlPUzFNVGwvZ0wwVkg5ZmM0?=
 =?utf-8?B?ZVJCc1dIQW9oSVhsbGRSYWVQeDByZ1F4UW9lTyt5WkdZdU03YzNJUVYydUQw?=
 =?utf-8?B?UTdYSWd3K0VDdC9UbmYyZ1BmbTc2cTdnNHJ5YkJvdWl5OThpOE5vM0EzenQ1?=
 =?utf-8?B?TWdCZzFLbTZKbXMzRVNmRHN1TFozMkJDaWttZjNIWmg2N280VEJoTUlycEUx?=
 =?utf-8?B?ZWJZZ3oyMWx1cmhHSCt1cDgvUlBiVG9HMWUzRlhBWGcwRjJOVWsvNGVTSVps?=
 =?utf-8?B?ZXhiTTdCMGM4TmN3c0hkK0dldkVFV08xTzArRTRzQlVORUoxeVZ5bUlWTWoy?=
 =?utf-8?B?cnNFSW9QUTNBVHpDWnJZc2N4VXg4a2FqRGFEY1o0ZWIrbWxOdEhRYnpUOFZL?=
 =?utf-8?B?emMxVzFGZnA5ckJqN0FYUGc2RlV3R2ZWbkJJTmN2dlk2N3FWeS9iUWZ1eklE?=
 =?utf-8?B?MFcvbHBkYXk0UXhnQXZZZEtXOE4wZnB1RGY4MGplbXJuTGRvaTJ3VVVnZlFO?=
 =?utf-8?B?RlEvdjRjWHk5VmZIRmZXY1hGbGk3ZzFBckg3TWtobSswOWdvSUpxak1zMnlz?=
 =?utf-8?B?TFNLQXRKdk5PcnlZbzh5ZUJEZUxIQmp4RU5uMVRjclA4UVpUa1FseDY3ajJ3?=
 =?utf-8?B?MFY2MnBUOWc5ZXhYb2ZRbnZmT3VyNW8weXUwQ1pibmlKcTZDdVlmbkNyNFRW?=
 =?utf-8?B?dG10S2FtVUVBcWVmeXIwTFoxczJRSnYwcTdsSC9mSE1sclpPR25CREdrZkVu?=
 =?utf-8?B?cXJCdTMyYm9ZNGNjeENLcGxjMDJXTVZsS0JwT04wKzdEdnBaRnlqMUZycU1F?=
 =?utf-8?B?SlJPcnJCT1F3bGIyc3FUK3FXN0NYRXlRV080ejRNQTROZ1ZCNWhNblNINk8w?=
 =?utf-8?B?eEVOM3J0RVBBK3ZoT1NDZU5YT3A0RDNuMHZkMS9KaXlWdU5tdG44YkZURU41?=
 =?utf-8?B?dXRrLzJkM0s1TDVzcGJpKzNFWmI2d1NrZEpsb2Y5d1JBVGpwd0tFRGNpdkcr?=
 =?utf-8?B?MVQ0bzdQQWZmR0ZnaFlhTjk0VFg1aURUcStRSmdJRGxUVTdwQ1daVGtZVVNM?=
 =?utf-8?B?ZGM0bGtLVEVJUTM5aXVvTlBXVnliSjZ1NE9sNTdxVFhVNFJaTi9oT1VRY3Yv?=
 =?utf-8?B?NjVJRy80TmNISEVLUUVTaFRhZ1BROVA5WmZSTmdCQkQ3dVJwMGgzTTV5WG14?=
 =?utf-8?B?K3BGdjU2a0RHQ042V1ZVY1NhRHFWUWlFUEpUVFVDaVRIL1p0TkRVSkt2aXlS?=
 =?utf-8?B?bG1ERVhOUjV5eGY3ZXNvWGwzT0tKM3duTi9YZHJrbitBWEZVMk1RN1dObHdD?=
 =?utf-8?B?eUlHNGdKc1phNWdERGZ6aDZMemdDWk5XQmdSb1ZnL1pUQmRHNW1lQnAyVzh6?=
 =?utf-8?B?WWZlOVk0NXNQVEtTZ2IrM3ovOVZHcnphMjl0UG1EQnMvQjFRS1QrcVBraEhz?=
 =?utf-8?B?UkF2NkZDTjA4cmRmYXhEQzdsZ1VQQ0hYMHZtWGtQcGU0d2g2bndIblpMY2ZK?=
 =?utf-8?B?Mk92VUx1R0JBaldlRlZnOVZUaWdjRFE3RzA5Ui9TNUJodHRLOXUrU1M4Vkpp?=
 =?utf-8?B?UVNVeENqSnpVN1o3S2RzdWxvaCtuZHdQYzZCSHh5STBSOUtNQ1pQMjE3dnVD?=
 =?utf-8?B?QUhKWjBjYlJGNW9ZWXJidnFJUTgyZlhzME1YNld5SXMrMTJsNldCb2lmaWRv?=
 =?utf-8?B?NW5PT21YdWp5S0daVUpLWDdvSGQxbmlia0QraWtZVkdOR1ZwMVZNYURwaWhP?=
 =?utf-8?B?eC9JZnBpVDFpSUNFRlg0NFh1YmtPZWhDRnprU29SVzlQTGFhQ29jUnZxcmRI?=
 =?utf-8?B?WWVGcmN0bU8zYW85VlVsU2ZucFJUTVpJbjhIV0xlMTNYZlRqdUViTDgyZEcx?=
 =?utf-8?B?ZzU0VjhJellEaG9KWmtUWTlPT1BoaCs0aUdBWVBBSDRxTFgwdUdQZ20zSktp?=
 =?utf-8?B?cHptbG1ORkMwWDl4aS9USnJ1ZXM4ZFR4eGVzQlFCVEkzdk5UVjJnMkxYS2Na?=
 =?utf-8?B?K2RkUkovS0J1eDB3TVVFMFB4UUk5eFF1YWRwemZuTDI3ZWNrUHkrN2tieTdK?=
 =?utf-8?B?dFpTWURab2pOOGRoU1d6MzhQYlZFQ0lOdHovd3AxZ1p4MDg2aWUvcXZDM1kz?=
 =?utf-8?B?d1ZWTzlMakQzMW9iek9Ic3ZnM2F4QURBbWppM1V5cVlmRFcyS1V4UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e76b95a-eb52-47fc-253b-08df050cd490
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:01:17.5235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piwJl61HYgf0Ima2+W8Kd99VojBb4ZCMmDahRsh114pA5Y4ld8quAQwOXdHQR01YLhJeuNhnInQ9Mfgba2CXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2987
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

On Fri Aug 28, 2026 at 4:40 AM BST, Alexandre Courbot wrote:
> On Fri Aug 28, 2026 at 9:08 AM JST, Eliot Courtney wrote:
>> On Thu Aug 27, 2026 at 11:55 PM JST, Alice Ryhl wrote:
>>> On Thu, Aug 27, 2026 at 4:37=E2=80=AFPM Gary Guo <gary@garyguo.net> wro=
te:
>>>>
>>>> On Thu Aug 27, 2026 at 3:29 PM BST, Alexandre Courbot wrote:
>>>> > On Thu Aug 27, 2026 at 10:48 PM JST, Eliot Courtney wrote:
>>>> >> On Thu Aug 27, 2026 at 8:12 PM JST, Alexandre Courbot wrote:
>>>> >>> On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
>>>> >>>> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
>>>> >>>>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>>>> >>>>>> Currently, using NonZero/Bounded constants is quite verbose. It=
's
>>>> >>>>>> unfortunate because it disincentivizes using it in interface bo=
undaries.
>>>> >>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for=
 constant
>>>> >>>>>> value) takes a const integer expression and widens it to i128 (=
at build
>>>> >>>>>> time only) before passing it as a const generic value to a new =
trait
>>>> >>>>>> function `FromConst::from_const`. The trait is implemented by N=
onZero,
>>>> >>>>>> Bounded, and Alignment and lets values of each be constructed f=
rom
>>>> >>>>>> constants without a verbose turbofish syntax. For example,
>>>> >>>>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`=
.
>>>> >>>>>>
>>>> >>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>>> >>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>> >>>>>
>>>> >>>>> This doesn't work in const context, so I don't think this is a g=
reat
>>>> >>>>> strategy.
>>>> >>>>>
>>>> >>>>> I would want to use it for cases like this:
>>>> >>>>>
>>>> >>>>> drivers/android/binder/netlink.rs
>>>> >>>>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD=
_REPORT as u8;
>>>> >>>>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BIN=
DER_A_REPORT_ERROR as c_int;
>>>> >>>>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::B=
INDER_A_REPORT_CONTEXT as c_int;
>>>> >>>>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::=
BINDER_A_REPORT_FROM_PID as c_int;
>>>> >>>>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::=
BINDER_A_REPORT_FROM_TID as c_int;
>>>> >>>>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BI=
NDER_A_REPORT_TO_PID as c_int;
>>>> >>>>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BI=
NDER_A_REPORT_TO_TID as c_int;
>>>> >>>>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::=
BINDER_A_REPORT_IS_REPLY as c_int;
>>>> >>>>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BIN=
DER_A_REPORT_FLAGS as c_int;
>>>> >>>>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BIND=
ER_A_REPORT_CODE as c_int;
>>>> >>>>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi:=
:BINDER_A_REPORT_DATA_SIZE as c_int;
>>>> >>>>
>>>> >>>> `const_as!` [1] should do the trick for this, provided you don't =
need to
>>>> >>>> create a const `NonZero`.
>>>> >>>>
>>>> >>>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225f=
e2@nvidia.com/
>>>> >>>
>>>> >>> ... but I agree it would be nice to be able to use this in const
>>>> >>> context. And there is an overlap with `const_as!` that becomes mor=
e
>>>> >>> obvious the more I look at it.
>>>> >>>
>>>> >>> In for a penny, in for a pound of macro code as they say. Since we
>>>> >>> agreed on using macros, how about unifying both under the same `cv=
!`
>>>> >>> macro, with as many branches as we have types we want to initializ=
e from
>>>> >>> a constant value? For instance:
>>>> >>>
>>>> >>>     // Does what `const_as!` currently does under the hood.
>>>> >>>     const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BIN=
DER_CMD_REPORT));
>>>> >>>     // Calls `NonZero::new().unwrap()` under the hood.
>>>> >>>     const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::u=
api::NONZERO_VALUE));
>>>> >>>     // Calls `Bounded::new::<{ ...}>()` under the hood.
>>>> >>>     const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kerne=
l::uapi::SMALL_VALUE));
>>>> >>>
>>>> >>> I.e. we would have one extra matching arm in `cv!` per type it han=
dles
>>>> >>> instead of implementing a trait. The syntax of the macro would loo=
k more
>>>> >>> natural (bye bye `const_as`'s awkward `=3D>`), albeit it would hav=
e the
>>>> >>> limitations of such a semantic dispatch.
>>>> >>>
>>>> >>> Even the name `const_as!` wasn't really accurate to begin with: wh=
at it
>>>> >>> really emulates is a const `try_from`, and we even discussed
>>>> >>> implementing it in these terms in the future.
>>>> >>>
>>>> >>> I'm sure the idea needs more polishing but I think there's somethi=
ng to
>>>> >>> explore here.
>>>> >>
>>>> >> Yeah I agree that const_as! is similar and if we had const traits w=
e
>>>> >> could fully merge them and have it always work in a const context f=
or
>>>> >> both duties (which are really a const tryfrom as you said).
>>>> >>
>>>> >> I am not sure about the suggested syntax (e.g.
>>>> >> cv!(Bounded::new(kernel::uapi::SMALL_VALUE))), since it seems very
>>>> >> verbose.
>>>> >
>>>> > A bit, but what I like is that it looks very close to what you would
>>>> > naturally write if you had const traits (minus the unwraps), so you
>>>> > don't have to learn a new syntax. As long as it's not *more* verbose
>>>> > than natural Rust, I think it's fine.
>>>> >
>>>> > It also has the benefit of relying less on type inference, i.e. `cv!=
(5)`
>>>> > requires the caller to specify the type even with a `let` statement,
>>>> > whereas you could do `let v =3D cv!(NonZero::new(5));` and it would =
work
>>>> > as expected.
>>>>
>>>> Even with const try_from we'd still want `cv!()` to avoid having to wr=
ite
>>>>
>>>>     const { Type::try_from(...).unwrap() }
>>>>
>>>> I think having `=3D>` syntax is great because it is a good place to *o=
ptionally*
>>>> require type annotation.
>>>>
>>>> For enum repr for example, I think it'd be great that
>>>>
>>>>     const BINDER_CMD_REPORT: u8 =3D cv!(kernel::uapi::BINDER_CMD_REPOR=
T);
>>>>
>>>> would work directly. It might need some tricks, which I have hard time=
 coming up
>>>> as I'm not feeling very well today, but I'll give it a shot over the w=
eekend...
>>>
>>> One could potentially define a trait with a MIN and MAX value
>>> constant, and then implement cv! like this:
>>>
>>> 1. Verify that the value lies between MIN and MAX.
>>> 2. Cast the value to uNN of the same size as the target type.
>>> 3. Transmute the uNN to the target type.
>>>
>>> Since the trait has no methods, this works in const eval.
>>>
>>> Alice
>>
>> Using an associated const by itself appears to work - I tried this which
>> is very similar to Alice's suggested approach above:
>>
>> ```
>> macro_rules! const_assert {
>>     ($condition:expr $(,$arg:literal)?) =3D> {
>>         const { ::core::assert!($condition $(,$arg)?) };
>>     };
>> }
>
> Any reason this cannot use the `const_assert` already in the kernel
> crate?
>
>>
>> trait FromConst<const V: i128>: Sized {
>>     const VALUE: Self;
>> }
>>
>> macro_rules! cv {
>>     (@widen $v:expr) =3D> {{
>>         #[allow(unused_comparisons, unused_assignments)]
>>         {
>>             let v =3D $v;
>>             let r =3D v as i128;
>>             let mut back =3D v;
>>             back =3D r as _;
>>
>>             ::core::assert!(
>>                 back =3D=3D v && (v < 0) =3D=3D (r < 0),
>>                 "value cannot be losslessly widened to `i128`"
>>             );
>>
>>             r
>>         }
>>     }};
>>     ($v:expr =3D> $t:ty) =3D> {
>>         <$t as FromConst<{ cv!(@widen $v) }>>::VALUE
>
> nit for the actual posting: make sure to fully qualify `cv` when calling
> it recursively (and make sure all symbols are fully qualified).
>
>>     };
>>     ($v:expr) =3D> {
>>         <_ as FromConst<{ cv!(@widen $v) }>>::VALUE
>>     };
>> }
>>
>> macro_rules! impl_from_const_int {
>>     ($($t:ty)*) =3D> {$(
>>         impl<const V: i128> FromConst<V> for $t {
>>             const VALUE: Self =3D {
>>                 const_assert!(
>>                     V >=3D <$t>::MIN as i128 && V <=3D <$t>::MAX as i128=
,
>>                     "Constant cannot be represented by the target type."
>>                 );
>>                 V as $t
>>             };
>>         }
>>
>>         impl<const V: i128> FromConst<V> for NonZero<$t> {
>>             const VALUE: Self =3D {
>>                 const_assert!(
>>                     V >=3D <$t>::MIN as i128 && V <=3D <$t>::MAX as i128=
,
>>                     "Constant cannot be represented by the underlying ty=
pe."
>>                 );
>
> Let's also have a `const_assert!(V !=3D 0, ...)` to provide a better
> error message than "unwrap on None" if users call this with 0.
>
>>                 NonZero::new(V as $t).unwrap()
>>             };
>>         }
>>     )*};
>> }
>> impl_from_const_int!(u8 u16 u32 u64 usize i8 i16 i32 i64 isize);
>>
>> impl<const V: i128> FromConst<V> for Alignment {
>>     const VALUE: Self =3D {
>>         const_assert!(V > 0 && V <=3D usize::MAX as i128);
>>         // The unwrap fails the build if `V` is not a power of two.
>>         Alignment::new_checked(V as usize).unwrap()
>>     };
>> }
>>
>> const A: u8 =3D cv!(200u32);
>> const B: NonZero<u8> =3D cv!(5);
>> const C: Alignment =3D cv!(4096);
>> const D: u8 =3D cv!(200u32 =3D> u8);
>> ```
>
> That looks like it could work! IIUC it even supports something like
> `cv!(x =3D> NonZero<u8>)`. The only limitation is see is that this cannot
> take expressions using generic parameters, but we can probably work
> around that.

I posted a version [1] that works with const generic parameters. It is made=
 of
dark magic, but I think it's as close to actual const trait impl that we ca=
n
actually get without actually having it. I used some extra trick to make er=
ror
message very good, but the code could be simplified to not rely on method
resolution order if we are okay with a less perfect error message.

What I like is that the trick is pretty generalizable to anything that need
const trait impl, as it does not have limitation of generic const expr or c=
onst
ADT (i.e. anything that is const-evalutable can work, not just integers tha=
t
does not involve generic params), as long as concrete types are present and=
 not
just `T: ConstTrait` (which would actually need proper const trait impl).

[1] https://lore.kernel.org/rust-for-linux/20260828-cv-v1-0-694a695ff17f@ga=
ryguo.net/

Best,
Gary

> I guess you'll want to split this out into its own series so it doesn't
> remain hidden within the ranges/bitmap work. Basically as a replacement
> for the `const_as` I was driving [1]. I'll recycle the `const_as` series
> to just switch to the kernel converters, and will follow-up with using
> `cv!` once it lands.
>
> Since this is going to be a multi-cycle effort we should probably keep
> the legacy `*_into_*` functions around for now and remove them in
> another patch once all users are converted.
>
> [1] https://lore.kernel.org/20260825-const_as-v1-0-1ce712225fe2@nvidia.co=
m


