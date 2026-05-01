Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69088FF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 06:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6D410F4B6;
	Fri,  1 May 2026 06:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DlD2m/yZ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3200A10F4B6
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 06:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIqtUQLC7mOIZg03jEkBVUyik3gJKwSq86p/HQTtfVog16fzNt2DG5/GGZ0Y9cTl58x+ExDLrN1V13gJtP2NurdYDIhNKMCR9fDOg5oUZgTr+ZpfeK0H42fQ55DfzAa5ConaeH8q8w5CMRXmc6SkpyZkZ9SHuW1xr2LbhhfNLg271b2R8bixa50wIBVyuY+L04nK0eYkZ0kEPItpV+VOw2bxtTjGFs+fAWPz166c/l7ErOsGTZjsTxrApcwzT7vjSV/QlXYh4n1GzokxpsdUTFNpbRuQ5rbo6HharKQcNNA51a11WVaov7EDdWwRoa0mhJSB25UOoePjRhNiTUlHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0GPm5gSWKOSEfyqtOQ2SwPkB9uUf0vrhFD3VxWtom4=;
 b=ruzlZ8YF85jdd2KRU69O94HTKoA5l36AakBhk4DciloVC39lf+3LVG0jDXLS3VmrVYg6KphoZvBiCQ4xz8yaOtZ9kYF7N8yeEqnsToESIDo/jsNkMWBgAZuZFzh5FruiIiF+jyrofynTOkJFtDxvo4ZulLcQlLlgLC45BbZ1fyUY3YKLvrgT9ygMuPb2EurM/U9horjR/yJYR1QEY5gUitpKiKGHfSJ2uixOUzGKf+IVhUzl5/ma6jQAFfVXAF9s3uEUnpdNQ4w9wmmogCz26vW0jGYmCdVZZEu6BRooE1+t1Fm6QKw/F0J9oeM8J/j9IPR6Omcd5K9n7vk+tdDlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0GPm5gSWKOSEfyqtOQ2SwPkB9uUf0vrhFD3VxWtom4=;
 b=DlD2m/yZSIBACRJJANKaI8ZOyK4W2/x4dSi43SdAb9RJ32BDG8Rgt+GzHf8Ee/GwwTBvlLOFOavn/P91lXWlQMUToFKm9K3U71pU4fWqAp+0He13w6c6W55o0aPQIN0yZ49l0FoWC2Ut9aFjEp9+ZJrCoKLFL/XIlWKyP8UnFExYosGLDnRvqzebKHXiIgZf91rhulDKHoe832mqSU9X8eu1cBctYZQW5JV0SY4+TEdCqY7z69G3Q8StbP3ALuqA76anl2cJNdDTROkHXIj91qckW0M52/5CdnCF4T2qCbXravtvznpB3pTDNMB+NbcqYBq14ZazSCNPY1RioHjTeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 06:08:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 06:08:36 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 15:08:31 +0900
Message-Id: <DI746G9QGNAL.3VELW7GHAFR6Y@nvidia.com>
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
 <zhiw@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/3] rust: extract `bitfield!` macro from `register!`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-1-23ac400071cb@nvidia.com>
 <DHRO963VKBJG.1RNNN4EJ791PP@nvidia.com>
In-Reply-To: <DHRO963VKBJG.1RNNN4EJ791PP@nvidia.com>
X-ClientProxiedBy: TY4P301CA0098.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b792c4-8a1b-4fa4-140a-08dea74813f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ib8FhsdfpW4cLdMZWeVPD2AdpNROAxNtFyadWWu6jGYXzCyrjNMKz5jEj2f2ARZpalAEtsA6XDoqaMjDkvN8Sr3icYwb42w9dUID5H2c18G1HAN6iW9kiMsaw+ZlsTu+6sfWxm6K8yaLxLOQ6dCXu3Gwb1GoqdmFO/dZxZTS4rGdFXzHNnQmzHO61UgGbkCm+wojbeSpL+l7zCLR+f08rPRYxC5D3VWP9ydKOdOfyinqSiyknDsxiSGULq9zHOEBIpi70pZRN5652hDaBKyN/b5Gb8pgf234WSdi0BVJLOy4zfuCCu+ZMBznZTszvEeHg+kOP+W/h29zJJQxMThOl93zM8a1d5g4UHoyuN+7hM+LwhS5MS3JPNs29RjbIsfZKR7JGyLvR3tQgs2O3WQMPNgiFoSPr1E++nvYd1luGRABqFVG390kgnrD96pZXoDFvm9Hj2wXOHaH9m96uXUBglHspf90guH49S28/ee4Up3293dzNh7O6o8pU8YbNwZbLinigJ+qz08mrvFBtEZHcgy5CvasSycLSpL7DvqeTNYWq30hWR6/oTNCNk2plcL1aHLCQKlaqXfFvKVYTDDaN6gY9A0QfK4GHFhUvSJTaJWKu0yvq9bBED7YT/4apW7j68y3E3ZfO4KekuJaRNrMFpL8GQYWT13s/baKSNCdusECRBVK7DY3opscTGhs6Csz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHFUZkFlZjd1Vi9pVjhvQ2ZwdEJYSUxaNTRSTHR5U1h0cCtzOHNGMFk1c2o4?=
 =?utf-8?B?VUxWTWdOVzJib2hNUnJwTjNBb1llcVlmTUZQV09IQ0lVV2I5RnhBQXRJeDZa?=
 =?utf-8?B?U0F1M1JjWnFlclU4czU5TUdZeTVZRk1xQnlvMnZlNlNqWGFlOFI0aEJZMFpn?=
 =?utf-8?B?U1YyaUdRZTdzQ0lvQThFS3VPUHNIL0E2OXVGUnBZWG1MRHpXZ0tWM2cvanY3?=
 =?utf-8?B?RmJwdWhqSDVFaVVtSUhPUnJJWmN4WDVXMytyeGJmdzRCUXppdXZybmo1N1ZE?=
 =?utf-8?B?RG14VzJKWFVZZE53M2VKN3M3R1F4RzdxbmhoemdkTGdpR1ZBSEkwOVNDQzRU?=
 =?utf-8?B?ZFRsbzNSdzJoWWxIZ3J1clFOTE1qMUF0MGFpcmxpY1diOEhVS1QrM3duaGJM?=
 =?utf-8?B?UThXVDUzZ0IvMnlqZUJyTXlNd0J2a3Fhdm9NbDNPeUo2N011VmhNZkp4b0Q2?=
 =?utf-8?B?a0lHVHdtVE90anVYbnQ1a0hnZkxIaDFZdkFsYm1GWTZUWkliNU9KN003UFJi?=
 =?utf-8?B?VGhlVXcyczROZzg3RjVUUjdsTGQ0Y1N5ejhRRWFlR0I5SmxoclZFdkV5aHU2?=
 =?utf-8?B?S3dvU1lqOGR2L2FnVDZrL0FTNkw1QWI1enAwdy81QXdUeXkwdEhHZENCQ1Y1?=
 =?utf-8?B?YWRZUEN0c1pUcXBiUE42WE4wVS9vV1ZxSGVPRVZLNXZBM3ZRK1hLWmZKeXkr?=
 =?utf-8?B?d0VmQkNMZGlvaXI5WWI2NCtLWjIyODh0ZXJZU0F6UElPK1FzeHJuMmhoRFdI?=
 =?utf-8?B?bGR6Sjlac2dmdW1rbk45bzdGODdEZmg4djFhQk5uc1ZDNVB4NUl6bHVaWDZF?=
 =?utf-8?B?TGNtbC9kUlRkK1BDNmUxeTUrbHpBN0pqcWhvSm0xNGczN29qSW9sQ25MamZl?=
 =?utf-8?B?eFFndXExbkVYUTlRVDF5blhnK1NpSXhQb0ptNi9TbE9PT1dYUmV3ckhva3Vx?=
 =?utf-8?B?ekUxTzhiZ01uTmtYRjdJWVFtbDBNNFFrOTlFOEwwa2Y0MEU2MHFnM0hUS0JI?=
 =?utf-8?B?VFZMVFFJdjcvWTNxMnkyVzRZNXN6ZWNHYy8zSFgzYkxEaGgrTlBmbW96empM?=
 =?utf-8?B?KzlhNE42MnF0a25hbU9LZEd6YzlrOFowb21xOUgrWEdWR1V6dHdwa3ZSaEE1?=
 =?utf-8?B?OFpna0dMVGlCanVuY2E3b1R3aUFGaGJ1akZpTUtCMEh1VnQ3RUplaDVhdmNT?=
 =?utf-8?B?U2IyaEducTZCNEQwTzJTNUp5cllzODJJcjA3NWhTNTVJeHB2RmIrYzlxV3hN?=
 =?utf-8?B?cm13MlZZcXlwQTEwOGxkTllGM3hqMmJFK3JGcjhPZzZoMEZOcU1IbW1aK0xy?=
 =?utf-8?B?VHNabUJjNmsrOFBOZjRaZnN5QXdxQTdYdzdMdElybzJxanQwN3NYVFVyMzBC?=
 =?utf-8?B?T25TdDd0bGo5VGgybVkzVzEvZ044aFVqUkNMRUdmdk5VeDB0QmpqTzBCdTlS?=
 =?utf-8?B?VUxKTElyVHVNc05malYxS3JIc0xFdjRDU29mbXlINVJYTW5VaEpwK0pXa0lJ?=
 =?utf-8?B?VitMbGl1NzJ3dkczNVBoSkoySG10MW9UWFBBKzBMb25yT3NQTUpVMVNKQ3Zp?=
 =?utf-8?B?Z3VSdFd3N0Y1N1lmZ0JRUUw2VU5xOStPcVVGcVRCS2xmRUE1VkZWazNtakpE?=
 =?utf-8?B?Y3czcDBrY0RGMEZPWUMrNXBFdHhwZDMyVUxPOXNlK1cwRDJudVBibGlGSllW?=
 =?utf-8?B?V0pMYXJyYkVidVlxQytqN2NCV2VUSWxWNDVJUDdwRlNpWjliVmxxc3NrV1hB?=
 =?utf-8?B?S2k1NFBxeWFYTEpJUVRKVm1iNlNnK0VzeUVOQnAwQ1IzYmxqSmFUWjNyTVF0?=
 =?utf-8?B?QTQzQ3F5U2NHSCtPK2tEa3pXbHdQWlppUG5VYzduYTdma2VVQlVZdVpOMVN2?=
 =?utf-8?B?OFVLRjk3Qmk2WDZTdy83bEpCZ2U2RG1jR3d2Q0RYV245ZnlTS0kwbVI4Rytj?=
 =?utf-8?B?cUFYRHh6RVN3V0htcVZZVG5KMmt0REZJeGgwaktxaU1ra09DTkpmV2x6bjVx?=
 =?utf-8?B?dVg0UWJpb0JZY0taQTJ3V21CWGh6WHFwd1VheWpxTTRadjBhRjVVVWRYUG1r?=
 =?utf-8?B?NmRBZmFpdFduc1lEVUsyOWs2bXdTOUdNMmNESzRod2ZZTUkrM0VvRm1yQ0l4?=
 =?utf-8?B?YVl0QitTSERWa2RKR25XejByQWpKaGZxbHdUcnBDM3BQVWZYVG9RZlhyb0di?=
 =?utf-8?B?OTlJcXI5MTVYdW8zWTM0dy9tbm1QbVg4YnVwM3ZLejJ6b1VHcHRSZVZjUkhH?=
 =?utf-8?B?REtNekE1RzhvQzZVZ1JaL1NGK1Nzd09jblFoOUUxdzdHY0o4VHFnV1BYamdn?=
 =?utf-8?B?VVcvYWt3cWNrd0RwLzlHZHF2QmUrQmdQQkFGVHAvMW1WaDVJc2pWTzViUmlV?=
 =?utf-8?Q?ro0Yho6Hu/MCxMh3V1LR1EowXssDF7CbaYr704qCa46lK?=
X-MS-Exchange-AntiSpam-MessageData-1: fbvnSTNgjx8/Lg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b792c4-8a1b-4fa4-140a-08dea74813f3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 06:08:36.6957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av9gkNJlD5J7Tr8UCoLDVLyOFWY3VzFoW1Nyq6OmgiW16Su2gEzNjVEf5FRdHb3gs5ywsHvZsHJvmzth3ngnOA==
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

On Mon Apr 13, 2026 at 11:29 AM JST, Eliot Courtney wrote:
> On Thu Apr 9, 2026 at 11:58 PM JST, Alexandre Courbot wrote:
>> Extract the bitfield-defining part of the `register!` macro into an
>> independent macro used to define bitfield types with bounds-checked
>> accessors.
>>
>> Each field is represented as a `Bounded` of the appropriate bit width,
>> ensuring field values are never silently truncated.
>>
>> Fields can optionally be converted to/from custom types, either fallibly
>> or infallibly.
>>
>> Appropriate documentation is also added, and a MAINTAINERS entry created
>> for the new module.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  MAINTAINERS                |   8 +
>>  rust/kernel/bitfield.rs    | 491 ++++++++++++++++++++++++++++++++++++++=
+++++++
>>  rust/kernel/io/register.rs | 246 +----------------------
>>  rust/kernel/lib.rs         |   1 +
>>  4 files changed, 502 insertions(+), 244 deletions(-)
>>
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
>
> nit: Should this be kept in alphabetical order (e.g. with ALLOC here
> below?).

Oops, indeed. Fixed.

>
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
>> +//!     }
>> +//! }
>> +//!
>> +//! // Valid value for the `blue` field.
>> +//! let blue =3D Bounded::<u16, 5>::new::<0x18>();
>> +//!
>> +//! // Setters can be chained. Values ranges are checked at compile-tim=
e.
>> +//! let color =3D Rgb::zeroed()
>> +//!     // Compile-time bounds check of constant value.
>> +//!     .with_const_red::<0x10>()
>> +//!     .with_const_green::<0x1f>()
>> +//!     // A `Bounded` can also be passed.
>> +//!     .with_blue(blue);
>> +//!
>> +//! assert_eq!(color.red(), 0x10);
>> +//! assert_eq!(color.green(), 0x1f);
>> +//! assert_eq!(color.blue(), 0x18);
>> +//! assert_eq!(
>> +//!     color.into_raw(),
>> +//!     (0x18 << Rgb::BLUE_SHIFT) + (0x1f << Rgb::GREEN_SHIFT) + 0x10,
>> +//! );
>> +//!
>> +//! // Convert to/from the backing storage type.
>> +//! let raw: u16 =3D color.into();
>> +//! assert_eq!(Rgb::from(raw), color);
>> +//! ```
>> +//!
>> +//! # Syntax
>> +//!
>> +//! ```text
>> +//! bitfield! {
>> +//!     #[attributes]
>> +//!     // Documentation for `Name`.
>> +//!     pub struct Name(storage_type) {
>> +//!         // `field_1` documentation.
>> +//!         hi:lo field_1;
>> +//!         // `field_2` documentation.
>> +//!         hi:lo field_2 =3D> ConvertedType;
>> +//!         // `field_3` documentation.
>> +//!         hi:lo field_3 ?=3D> ConvertedType;
>> +//!         ...
>> +//!     }
>> +//! }
>> +//! ```
>> +//!
>> +//! - `storage_type`: The underlying integer type (`u8`, `u16`, `u32`, =
`u64`).
>> +//! - `hi:lo`: Bit range (inclusive), where `hi >=3D lo`.
>> +//! - `=3D> Type`: Optional infallible conversion (see [below](#infalli=
ble-conversion-)).
>> +//! - `?=3D> Type`: Optional fallible conversion (see [below](#fallible=
-conversion-)).
>> +//! - Documentation strings and attributes are optional.
>> +//!
>> +//! # Generated code
>> +//!
>> +//! Each field is internally represented as a [`Bounded`] parameterized=
 by its bit width. Field
>> +//! values can either be set/retrieved directly, or converted from/to a=
nother type.
>> +//!
>> +//! The use of `Bounded` for each field enforces bounds-checking (at bu=
ild time or runtime) of every
>> +//! value assigned to a field. This ensures that data is never accident=
ally truncated.
>> +//!
>> +//! The macro generates the bitfield type, [`From`] and [`Into`] implem=
entations for its storage
>> +//! type, as well as [`Debug`] and [`Zeroable`](pin_init::Zeroable) imp=
lementations.
>> +//!
>> +//! For each field, it also generates:
>> +//!
>> +//! - `with_field(value)` =E2=80=94 infallible setter; the argument typ=
e must be statically known to fit
>> +//!   the field width.
>> +//! - `with_const_field::<VALUE>()` =E2=80=94 const setter; the value i=
s validated at compile time.
>> +//!   Usually shorter to use than `with_field` for constant values as i=
t doesn't require
>> +//!   constructing a `Bounded`.
>> +//! - `try_with_field(value)` =E2=80=94 fallible setter. Returns an err=
or if the value is out of range.
>> +//! - `FIELD_MASK`, `FIELD_SHIFT`, `FIELD_RANGE` - constants for manual=
 bit manipulation.
>> +//!
>> +//! # Implicit conversions
>> +//!
>> +//! Types that fit entirely within a field's bit width can be used dire=
ctly with setters. For
>> +//! example, `bool` works with single-bit fields, and `u8` works with 8=
-bit fields:
>> +//!
>> +//! ```rust
>> +//! use kernel::bitfield;
>> +//!
>> +//! bitfield! {
>> +//!     pub struct Flags(u32) {
>> +//!         15:8 byte_field;
>> +//!         0:0 flag;
>> +//!     }
>> +//! }
>> +//!
>> +//! let flags =3D Flags::zeroed()
>> +//!     .with_byte_field(0x42_u8)
>> +//!     .with_flag(true);
>> +//!
>> +//! assert_eq!(flags.into_raw(), (0x42 << Flags::BYTE_FIELD_SHIFT) | 1)=
;
>> +//! ```
>> +//!
>> +//! # Runtime bounds checking
>> +//!
>> +//! When a value is not known at compile time, use `try_with_field()` t=
o check bounds at runtime:
>> +//!
>> +//! ```rust
>> +//! use kernel::bitfield;
>> +//!
>> +//! bitfield! {
>> +//!     pub struct Config(u8) {
>> +//!         3:0 nibble;
>> +//!     }
>> +//! }
>> +//!
>> +//! fn set_nibble(config: Config, value: u8) -> Result<Config, Error> {
>> +//!     // Returns `EOVERFLOW` if `value > 0xf`.
>> +//!     config.try_with_nibble(value)
>> +//! }
>> +//! # Ok::<(), Error>(())
>> +//! ```
>> +//!
>> +//! # Type conversion
>> +//!
>> +//! Fields can be automatically converted to/from a custom type using `=
=3D>` (infallible) or `?=3D>`
>> +//! (fallible). The custom type must implement the appropriate `From` o=
r `TryFrom` traits with
>> +//! `Bounded`.
>> +//!
>> +//! ## Infallible conversion (`=3D>`)
>> +//!
>> +//! Use this when all possible bit patterns of a field map to valid val=
ues:
>> +//!
>> +//! ```rust
>> +//! use kernel::bitfield;
>> +//! use kernel::num::Bounded;
>> +//!
>> +//! #[derive(Debug, Clone, Copy, PartialEq)]
>> +//! enum Power {
>> +//!     Off,
>> +//!     On,
>> +//! }
>> +//!
>> +//! impl From<Bounded<u32, 1>> for Power {
>> +//!     fn from(v: Bounded<u32, 1>) -> Self {
>> +//!         match *v {
>> +//!             0 =3D> Power::Off,
>> +//!             _ =3D> Power::On,
>> +//!         }
>> +//!     }
>> +//! }
>> +//!
>> +//! impl From<Power> for Bounded<u32, 1> {
>> +//!     fn from(p: Power) -> Self {
>> +//!         (p as u32 !=3D 0).into()
>> +//!     }
>> +//! }
>> +//!
>> +//! bitfield! {
>> +//!     pub struct Control(u32) {
>> +//!         0:0 power =3D> Power;
>> +//!     }
>> +//! }
>> +//!
>> +//! let ctrl =3D Control::zeroed().with_power(Power::On);
>> +//! assert_eq!(ctrl.power(), Power::On);
>> +//! ```
>> +//!
>> +//! ## Fallible conversion (`?=3D>`)
>> +//!
>> +//! Use this when some bit patterns of a field are invalid. The getter =
returns a [`Result`]:
>> +//!
>> +//! ```rust
>> +//! use kernel::bitfield;
>> +//! use kernel::num::Bounded;
>> +//!
>> +//! #[derive(Debug, Clone, Copy, PartialEq)]
>> +//! enum Mode {
>> +//!     Low =3D 0,
>> +//!     High =3D 1,
>> +//!     Auto =3D 2,
>> +//!     // 3 is invalid
>> +//! }
>> +//!
>> +//! impl TryFrom<Bounded<u32, 2>> for Mode {
>> +//!     type Error =3D u32;
>> +//!
>> +//!     fn try_from(v: Bounded<u32, 2>) -> Result<Self, u32> {
>> +//!         match *v {
>> +//!             0 =3D> Ok(Mode::Low),
>> +//!             1 =3D> Ok(Mode::High),
>> +//!             2 =3D> Ok(Mode::Auto),
>> +//!             n =3D> Err(n),
>> +//!         }
>> +//!     }
>> +//! }
>> +//!
>> +//! impl From<Mode> for Bounded<u32, 2> {
>> +//!     fn from(m: Mode) -> Self {
>> +//!         match m {
>> +//!             Mode::Low =3D> Bounded::<u32, _>::new::<0>(),
>> +//!             Mode::High =3D> Bounded::<u32, _>::new::<1>(),
>> +//!             Mode::Auto =3D> Bounded::<u32, _>::new::<2>(),
>> +//!         }
>> +//!     }
>> +//! }
>> +//!
>> +//! bitfield! {
>> +//!     pub struct Config(u32) {
>> +//!         1:0 mode ?=3D> Mode;
>> +//!     }
>> +//! }
>> +//!
>> +//! let cfg =3D Config::zeroed().with_mode(Mode::Auto);
>> +//! assert_eq!(cfg.mode(), Ok(Mode::Auto));
>> +//!
>> +//! // Invalid bit pattern returns an error.
>> +//! assert_eq!(Config::from(0b11).mode(), Err(3));
>> +//! ```
>> +//!
>> +//! [`Bounded`]: kernel::num::Bounded
>
> In the nova version of bitfield we had @check_field_bounds. If we put
> in the bit numbers the wrong way around, this patch gives a compile
> error like:
>
> ```
> attempt to compute `4_u32 - 7_u32`, which would overflow
> ```
>
> The original nova version looks like it used build_assert, but I think
> we can do it with const assert!, so we should be able to get a better
> build error message for this case:
>
> ```
> const _: () =3D assert!($hi >=3D $lo, "bitfield: hi bit must be >=3D lo b=
it");
> ```
>
> With just that we get an extra build error, although it still spams the
> confusing build error. We could also consider adding a function like:
>
> ```
> pub const fn bitfield_width(hi: u32, lo: u32) -> u32 {
>   assert!(hi >=3D lo, "bitfield: hi bit must be >=3D lo bit");
>   hi + 1 - lo
> }
> ```
>
> Using this instead gets rid of some confusing build errors since we can
> also use it in type bounds. But to get rid of all of them we would need
> to do it for the mask etc and others.
>
> WDYT?

That's a good idea (and I am marking this mail to not forget it), but as
John mentioned we ought to focus on just moving the code for this patch.
Let me look at it once `bitfield` is moved and available.
