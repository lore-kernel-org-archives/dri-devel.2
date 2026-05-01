Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8E1FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 06:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E61810F4DC;
	Fri,  1 May 2026 06:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIeyjLMf";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA36610E4FD
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 06:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDqJ6Xf9OsAdDtLbfZi2+pXPM0C93URiXGHkUp7gJX+RmLqYWaXWHqt0tH199l3QmIfvBjCGy+FRQukrTmFIk6A9LWUWJt4HqyPc/Uz7URZddIrSbiGDM3MX2Klti5QYOh5NvIMEYSU1OSOUzp5Pj3BZpBrmrIcEoQ2K12GSGJUDW8mqUoWpJrf3JYIT1TmHh9/TxxyGzyCEUNBW1foy/qmE9sYKd6ZYMTv1xJ3xCZ4UHUGlwarp5l4XmXNPiyCdO1lS/mehq3CDmujIekbA6ffUnhKheL4fu2Qo8a3QcoLOQ1CTeJv4UpC4voYZuw6I+A08kCJr4Jk7Ry0Pc09VEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUxiu4cFXb5IbHpHnqs90WzEmq9T2gX+pYZnKDI45Ho=;
 b=KD+TlgOVefeqajpzco21vFus/6zL5kQ8F3wOT80E6CQI8KNBWSy/RCxLMNdg0WbI+cwltJCMsEcsFb6vB3RR1ZZfo0XeDNugJe+NMaIRGR4Ayoo6O3pO5GcOppDsA8gnkuvoVZb0HOUbteFfnrzQNlFRzel/Hb17FVTIFsETftNP40drfR3ieE0QM59ezXj8XIzkqtcWFAIN+5qEcE/+Ng4/XjRszA84cc8YG+a6QueK+oAXG5ahzvQIdHHvmH5xiOBPHsAwcRzsrvJ4+duK37I11kw2z+AqZij1BuJ/nCLUop5CzfsnKSzLqfiG68v7Qu0Qg3Gr1/pulaMN3Qr6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUxiu4cFXb5IbHpHnqs90WzEmq9T2gX+pYZnKDI45Ho=;
 b=cIeyjLMfDqW1GUteQNfK/Yd6Ojrm8Oc+kOlht+HenRersRjmkWnn908n6LCP5vz3ZECKcSWGSjcb5McFuPI0mgomFMFQIIUTAEpdDfH+/p5zJtnm6sr8TAvDtICWYshB+7TVVlrpD/05QYohLH2qsIn/i4WP5F2OT+szbsjlbgapQ3ShEa/NDTdA/MwXjn5mFqTeMNY2cH1nBTsHCE0+qCk0lsJMzI1BCU0Y5bkMjJngVmE9ea8YajUMVDdNyW9rbP1tiCmPxEX9eX6eajYSkUrGYfnsGxrwIUqC7oGznaEJ61JllwdM8zlPPfaQ/oKFdzegp1Ze7nm/0dOW2HLqgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 06:07:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 06:07:16 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 15:07:12 +0900
Message-Id: <DI745FZNMA6V.CS7N0HL4L5IN@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/3] rust: extract `bitfield!` macro from `register!`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-1-23ac400071cb@nvidia.com> <aeA80WHkFBNTvQFz@yury>
In-Reply-To: <aeA80WHkFBNTvQFz@yury>
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a526131-e3a8-4208-4505-08dea747e4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: l0E9hbrD9UdAQ2QjluABzanw0/ACHnbEGffzF3vMMT8Dup8mF++WKCXSiXOXKcQlsh2lxKh10ulPuwQtTJAHP0gfVaaW9KJPZUV1Ig66BkUh8L/RVE6HW3y/tDxD0jar7kepxMUb8wCIq43MyHzSFdzCgoSktaoPEr8tnWP2sR1RsjsOaXr7WormayaS4p3KJPaBK8F9mhMjw/6XB+cEgoLciSVcYWmGMwkMG04YPPOA+myxgp4AMNEg0TwFVbQpW3kwx7u/db8cOAN8vlsFeo5TDHcz8x0jvTJZWHBIMTC/p/AMpyo8P49tqfwibLNVCS9MlrQHG2AHDXeLxvv0AZWak0EOMKZhY8tIARnjfHdTfUXTgxRTM5cNYGO5yL9nkZsTJcUiNl9XxR10GZKBxXR/JZQ4Aq7Oc2itos9JOOO3kCH75hIpi20ep2amefMtti3U7CI2EzzmuOuNYHKsFRpJNsJmZb3SbgRiDMSSRiHfQFwIgeSwDhZ871KcwbC/SPzvNIJBmi4rOSHmDdNrhLbS2ln1Ou8ycRbBo6FEOH2ixJ5/BIxGrjKCchScFLeUElyc9GnJW+RjebTeBAU3DSF3sZxQ4I+pMssJLwqG0A6q6spoxqdqGQi3wM0Ptedlc8kCocyEWN9kOt350IoTaZONZVjNvCb+5DLjShz8gwBh8NWkqI9JnZv5RnGD1a3s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlhDVDFHN1RjWHhtaXpKK1NoVmc3a3hsNjdwUGRYT2FZN3FrT01UVG9zZGdm?=
 =?utf-8?B?dFhBTHA2d0wwcnJiRjJLWWJ1bVFRb25VZmE0ZU1CRmt1WUh1VTF0bk0zc3Y3?=
 =?utf-8?B?UzVicStuNTJ1eFVMTHZhRU40UlF3UHFTa3RqZU9UN2ZCNGY0dHlwQi9QTHhP?=
 =?utf-8?B?MTAvMnRINUhaWlZQRkllM1FnbzlJZndmamphSGtPbDlJL3B4QWpjak9VZVEr?=
 =?utf-8?B?Zko2ZFA5WE1lcDdvdWt1aTVLYXZWR1IraEZCbU5CNkN6S04xTUtJcjdWZlgz?=
 =?utf-8?B?bEk2Rm0zVGk4MDNlamJqOThTWVk0R3F0Z2t5K2VHb1BZeHZpZUhtV1NURm8v?=
 =?utf-8?B?KzlJZmFJanZ1R2RNUVpmYkxUL0pQb2d2TUo4TFJiV3U1dzJsa3JFTUdZdVda?=
 =?utf-8?B?YnhWejZ5L1A1Mll4enlzeEZTTzZ3eHR1R2pvN0JYODg4VEZTNHYyUVZHWHNp?=
 =?utf-8?B?dloyTDJ5akF5OE9RWUl4MXoyK00yemxyUHgzVmFSZGlJWldiMkdoTGRPVzdG?=
 =?utf-8?B?Y3pFcTRHWFFIazA5azNWMnBhZm0rUkNTNiswSTNPQWhoc2IvWWFBMUxRK3pl?=
 =?utf-8?B?MnZWZVBMQTNzdC9QbjRhdnJiMEVaclZFWnFLQnE4YmY4Y05OUFd3NWtTQ3Az?=
 =?utf-8?B?aDJuVUxaZ3hFcDRzV1JpMGIwYTMxWnFIQkpWc0ZZRWF5LzlPRGdRSUJvYnJq?=
 =?utf-8?B?aDdGMHBRNDlSSFNTZjJ4ZVlrWkk2WXE0SzdjKzNta3h2UW9GYjh6QnNtMFBH?=
 =?utf-8?B?eUVrdDROY0Z0dmE4aVlBQ3Z4eGY1NzRza1llNTNUUlE2bzRGajdtSkNlWXpD?=
 =?utf-8?B?L2I5R3hVZmlHNXYva0Fhang1TVAwcVh3ZFplMTUzRFd6NWs4TlQyL1o3dHpz?=
 =?utf-8?B?SENDYmZ4VUloSVpkR1k1WTBpcm93ZTZQUFlQWUlMOUFkUHZOVm1BSlQrOFll?=
 =?utf-8?B?ZE8wc1I0aXFCMUd2d1ZQaUdVK21uT0FPOHR1M011YXYycFBYK1U2T3J2OVNh?=
 =?utf-8?B?ZlUva2lXNGl2eHFWWEdScDI2RjI0WUR2OTk0NmYxQjVHZVJVOUlDUXJKSkhN?=
 =?utf-8?B?UDhtZThJOEx0WmJ2R1NVSnlGZUt4a2p2Qi9FMFhRc2I3TzdHWWF4cFVPSGhx?=
 =?utf-8?B?WlRhY0Y2aFo0RUtkKzM2M20vend5VTF0OTUva1JFKzRTQVMvWHdoYkhDbktP?=
 =?utf-8?B?cmJHZ3NiZ2puL2N5ajFHbDR5VDk1dkZSUDZqeW9scFBVeUN0SHE4TzdJL1hq?=
 =?utf-8?B?Z2dHOExIdDVqR1FUUnNUSkVEYVdET3FTUUc2WklmS3NuVkUzNmJjM0YxRWE1?=
 =?utf-8?B?ZHk5ZXFsSVRCVEp2MGlvckFRQVdwb1dPL1VLYmNmZEVvc3UwdkI4MHVrZmcz?=
 =?utf-8?B?dWZQWDFFaDRLS2QyNVJPeU5Peml6RlVuNDgzMWlLa1kyTmlMM2xIMUd5VlRB?=
 =?utf-8?B?VVg1NzFqZ1Axckh6cmY1OHdKNGJNckE2bHBWbkh4di9XTGRFYXJJNWVVRFN0?=
 =?utf-8?B?Slc4Ri96VXZwTFI1bmxVWTZlNVVLZHpzakVKOUovSkcyQWZUQ0xIaW5OL2hi?=
 =?utf-8?B?YmFRN2NWQ0JMQXVKa0JEc0hBejJrNFAyU2ZXZzZod1p2MUhZVGxuWG5IbG1Y?=
 =?utf-8?B?aGtVaHptTElxUS84QTlCalRYMkJNVlB4Z3hOaW1kazM2STJCVFVOYU1QVUNX?=
 =?utf-8?B?ZThCMVArS1FtMmJqYjZsZVRsYnVIUDZOM3g5bUFYSkJ6bGRoaWR6R0pRak1x?=
 =?utf-8?B?d09BYlM2SkxCOCtSNjBOSC9VMXBybm9iRGZLZVltVUl0RFNpbENkQzdjVDdl?=
 =?utf-8?B?cFl0UlFsYkJtVmJTN1daS3JLTldESHBGa1lhK2ZiZytNVTd2TUJpRkJqMnJG?=
 =?utf-8?B?VjFHMWlVbS9jdFdxblY0dU92MTZhOE5TRVFhTnVmcjg1MVBmMTVmd0RJUW5t?=
 =?utf-8?B?a3J4QkM0WTNqTGpUbkxtTkVBQTh0Wk1GcFZKMnpIZ0dTQlMzVlo0cmJlQk5K?=
 =?utf-8?B?aU40bjVYYnpoaHN4UFh6V3NJaERmMG1MTEZMaWhBR1JIblByYlVJWFh4VDBR?=
 =?utf-8?B?S0tyVno3L0R6azZSVFdkak5sVC9TTkthWUFBbnlsMkJmWFFGVzZPZ3F1U3Zx?=
 =?utf-8?B?YTdRQjNFM1N2bXBRZEJkNzRsQm9uSHRjNFljNVpVaTJkOVk4c3FhN1l3TmFT?=
 =?utf-8?B?cVVwQkQ5dlNTMDBiNDJHMzZlUTVCZnRrdmJSU3FxcDNsUkhqZE8yK3R3K1BW?=
 =?utf-8?B?MXI1Vks0YzlmMEp6WXA0VWxGNlNaUXlqeDQxdDFnOXVkeDlYMngzcmNiWVFp?=
 =?utf-8?B?bGg4bGRvbWQ2OXZiaW52eEF3UloxS1g4RG81STRjUHZyMGJrUEFwcU5ERDFL?=
 =?utf-8?Q?pzKjU0MWlmY88n7zusNivVA9agpX+HmCyrM1buPIBhSC1?=
X-MS-Exchange-AntiSpam-MessageData-1: AXgKL0E5ubVM9Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a526131-e3a8-4208-4505-08dea747e4e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 06:07:15.9033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sykgV5igVzfWrv0i72az/gE6ZtxEWAxP6oEF05M7pRqkQiBWjTRiohQv6UN9pE69PsWiElNwiDtpJtAlD7o5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

On Thu Apr 16, 2026 at 10:35 AM JST, Yury Norov wrote:
> On Thu, Apr 09, 2026 at 11:58:47PM +0900, Alexandre Courbot wrote:
>> Extract the bitfield-defining part of the `register!` macro into an
>> independent macro used to define bitfield types with bounds-checked
>> accessors.
>>=20
>> Each field is represented as a `Bounded` of the appropriate bit width,
>> ensuring field values are never silently truncated.
>>=20
>> Fields can optionally be converted to/from custom types, either fallibly
>> or infallibly.
>>=20
>> Appropriate documentation is also added, and a MAINTAINERS entry created
>> for the new module.
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  MAINTAINERS                |   8 +
>>  rust/kernel/bitfield.rs    | 491 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  rust/kernel/io/register.rs | 246 +----------------------
>>  rust/kernel/lib.rs         |   1 +
>>  4 files changed, 502 insertions(+), 244 deletions(-)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b01791963e25..77f2617ade5d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23186,6 +23186,14 @@ F:	scripts/*rust*
>>  F:	tools/testing/selftests/rust/
>>  K:	\b(?i:rust)\b
>> =20
>> +RUST [BITFIELD]
>> +M:	Alexandre Courbot <acourbot@nvidia.com>
>> +M:	Joel Fernandes <joelagnelf@nvidia.com>
>> +R:	Yury Norov <yury.norov@gmail.com>
>> +L:	rust-for-linux@vger.kernel.org
>> +S:	Maintained
>> +F:	rust/kernel/bitfield.rs
>> +
>>  RUST [ALLOC]
>>  M:	Danilo Krummrich <dakr@kernel.org>
>>  R:	Lorenzo Stoakes <ljs@kernel.org>
>> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
>> new file mode 100644
>> index 000000000000..f5948eec8a76
>> --- /dev/null
>> +++ b/rust/kernel/bitfield.rs
>> @@ -0,0 +1,491 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Support for defining bitfields as Rust structures.
>> +//!
>> +//! The [`bitfield!`](kernel::bitfield!) macro declares integer types t=
hat are split into distinct
>> +//! bit fields of arbitrary length. Each field is typed using [`Bounded=
`](kernel::num::Bounded) to
>> +//! ensure values are properly validated and to avoid implicit data los=
s.
>> +//!
>> +//! # Example
>> +//!
>> +//! ```rust
>> +//! use kernel::bitfield;
>> +//! use kernel::num::Bounded;
>> +//!
>> +//! bitfield! {
>> +//!     pub struct Rgb(u16) {
>> +//!         15:11 blue;
>> +//!         10:5 green;
>> +//!         4:0 red;
>
> Hi Alex,
>
> Can you please describe those implied naming limitations we've
> discussed on the previous round, like with_blue, BLUE_SHIFT etc.
> in a separate top comment?

Yes, that was missing indeed. Added for v3.
