Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2C6C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C202810F25A;
	Fri, 21 Aug 2026 07:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gntfjTev";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A235310F25A
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lab2WSczG+JbDb+MZ0N8CoU5x5/cK03xC5/8RkIkNEJMPLJkROOazDB29w3f/JjnEBQ0fGLnzdxT1ka7MnrF5HVuU9tLh2Lmm70o7pRqkdvSbqSfkNMiHH3c+fBydbVz5l5Lk/o2tEren6ybNSFD8Yx2rzl50Kk97sEIpjrOzQOv1yZBZCr/24PW7F3VYRnZkblU7hhp6Ewv3Wd/Hau1QYjHot7wvZfZlQ3LCk9J4+Cyf3knXDlkGRgOcECVgKc7Lsl61+oPoR9xoO7ACUQfB7ztjQY1wKk4wazWykbIKyWbliO00SalaR24HuLOhgISb1MqZVbYpq/tiRkJQGlFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYytIcZ4ySPIwsj+iUpU5j70zhpuV6xXJBAGstKnvVI=;
 b=e4j36QwaH+xK8Sb/+V0gFhC4VulTXA6Bc+rdp4bMPeQU1tiaDKV1K6lPYg5b3chww5vQPMA0SaUDT6k4eVyuxdZyKPmURQ96yMqejKUn7XsmBF5HYokvWn6fZ5d8cCKeMjfFvlaoWOJxmz3eu1zyhgWhxlD4lUKXJIbVkzW1J+jIHIysWxYsd4u5cQBTCbxLZsmVRkEDxOVyKgAf8RCXT0r7Wr5Yzm+o5Yqfu/S6nFPGtA20D+c8rToSYJL+MazBMnhN8cUhh+F9swihR/uF6lYHJ6x29s7PHxzuR3pUC3BWjZoZ6kMEBDEmpQXRoEo0Aya69jLZEcqgiYMyXTqjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYytIcZ4ySPIwsj+iUpU5j70zhpuV6xXJBAGstKnvVI=;
 b=gntfjTevS+xd3R9TiF7HG/UiGV/9tbB7btAcrist5uyCUSM4g6RoCviAGPaca7yzS1ChnjEQ411rQbI/gqajx69M4vMPp/82gy70rFmzubIKHT74xYvC9azfn2CoEf8ZgbQThPC+UgpJtNKtd9Npy05/9BhvwxL2InMncxo6EIPu4auv7sc/nqMiTaBzFhoJkWRt51CjsbzFnT9Ky9BWxbLpyDN+Eu/z9p0DtDEKy2JktFUhlpUgksFIuGmeC3wypQB2x2ymCBeJm2tKZ+HXQuHLWjO+o3S3T9GkxnYj53LtwqRTDxutzzL4YyESpFnmVHvAn1sRcJyLWttcrfW+PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 07:37:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 07:37:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 16:37:27 +0900
Message-Id: <DKUG7JW3I90C.3F2JEQLEIV54O@nvidia.com>
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "Yury Norov"
 <ynorov@nvidia.com>
Subject: Re: [PATCH v7 02/10] rust: bitmap: restrict bitmap length to at
 most i32::MAX
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-2-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-2-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3e94a1-9b00-4e03-c7eb-08deff570e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|366016|7416014|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T2lQq/CY1jzSCIG/gEPxCmXF41HZUae253ygB97eSOOISmJadjadcEZ5eLDKMj/qrksZyZuO7lK0HXpNA+dXHWAMIMm3E1evrxbeYKXBNEa11VN2GKATyNg8LTX35kxG+WqT+k2cTFHSnSlB8lUOkzyoDTbAZTou8kPwchzbitopRrGBiOI3uMpuTaqzz9sxX26b2OSj7sJA9zaLGTpUoe9bEjDMBXEKdemAfN3llw8cjxuOQcCIeTqlaYlovnY7yrswHyiWm8hqQ80lUdV1ftcueVFjvyr9nvHcjlcq4jlfMBrr7LrY1YNRi61LTfemnkZPY2ShawmWdnMTTRbldvsu8y7okiohQQGF2Ragsw9y6q8qXLdQtlE3Ge2xc6Pigk42kpgwIbe8gxKtFBT11aEcz0Mp63mLZUAvdyjzAQjzLkNf8dr4Ni0/bYYCfmnMx1DJzd2X4f9uto9eJCjmFBH7+SmXpdw9tB3NuNqNrhnTgdT6YY3fm/KCIMH1hXVnF+8DOMSpcXQ7aqX92BNl5cDZmpFMIJH+vd3NzwaMX+w5XdKRr+r8NKbWFxNaexnkV+bws7Bl/w1+9577JFqqWu4gNXqAs9KXTxi4+A2+KT8XJCu5+vWrQr1QgQvq/Dg/MFW09MZcLoiRxPkuqV8WzJgsCq6JBdSBEJ4R146IcmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(7416014)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZIMEgzUkxhTStMWWdNeUliekdjRDk4VTQ5ZlpwbUsvU3BtNm5LSGtuWUh5?=
 =?utf-8?B?YTRyTjA1bURvT09UY29OOE8yaGNmTE1DYTdXU3VkYkJzVFNWWE5jb0RVL0lt?=
 =?utf-8?B?aVB6b3FIQW9xNkw3OHkyRHNRMUxuSzArdlg0cmxTOGplTGQ3WGZSSkFwTVN3?=
 =?utf-8?B?Z3BLZ1E4Si9iTDRiWkVOYU0reEZLL00yY0tONlUzNHRJRU51ODE2WUZLc25h?=
 =?utf-8?B?dVZwWk4wMkZuRGFEVldIZDJEdTZTYUxJamlTZ0d6MHdZSFAyK2pxT3Y0akNO?=
 =?utf-8?B?RzZWYXVPblZ1dmZxdm9wYnRKSHIrSnB5cUprNzFKblBFYnlaMjZUWGRnRUYz?=
 =?utf-8?B?azJUK1g5UURTeU9WY1Z5K1M3Z3d5ekdWQzJxbE0yYTVDdGpLb29rVWpBZjc0?=
 =?utf-8?B?ZmJGazgrYzgxNE00NU5IazY1YXdVSFNNaml4NTBwLzdtdzVYNjZsWHh1Ym9q?=
 =?utf-8?B?b3NCY2llaUh3ajBaVm9UNVhMdDVpTCtUYldLVEVub1JmcDllcUdad1NiNnJi?=
 =?utf-8?B?SzFFR05WbFE0YWJ2Q1NjUys3R3pyRG9hUFg4QmRYRnFRUThiREkxYWJSY3FT?=
 =?utf-8?B?UkhFZVQrdHBzL1lpRXp2ZGxlczc0cU16SHNOUTBpNHZFMVgyNXZYRHptYWVa?=
 =?utf-8?B?TjFoYWV1Ty9YUi9SbHpOdkZGSFZHZmJZTDBjQzVGdURwMSsySk9YbW1Ga3Rl?=
 =?utf-8?B?VGd4N1M5VXNYVzRhNzBxUDNrSWd5SlJ3eUNQd1Z4VFNsWWFNNUZFYXpRTnQx?=
 =?utf-8?B?T2NUZVVjbG8yaHJkWnlVVFN4YlhPRExxTnp4NTV0bWlsOHkwQWppQmo0Zit4?=
 =?utf-8?B?TXdoM29ORDN4dXBmNDhtbmxiOE9PM1diNFlkZkJiR1ZFZTNJQXpnTEVZWFdm?=
 =?utf-8?B?TUZMc1pzT0lpR2dYUldWQXZmd3V2QnJRalVpdE8yQmJEYzBCd2htTGdYMmRJ?=
 =?utf-8?B?YVhaUEo4dCtuZlZ4cm9WdVFWaGxqZ3J6SU5WaGZJbjR3SW5RN1NyckZ2dXFz?=
 =?utf-8?B?dk5ENmV1VTJQNUZBek5vVFExYW5DSkhwTkdpd1lnUXZLWUVzd0tOWnRzNUlQ?=
 =?utf-8?B?Sm9ibUM1TFhwMVFtTE9TR09wNXVuajEwY0JLbnBHbjFzRENRTGNieFpsL3Zq?=
 =?utf-8?B?UGZwS2hmRkxSUXVObGJwRmM1TytLUENDZjJndE13WVBmallPVEJwdkd1RWwr?=
 =?utf-8?B?bmRiWmdBenQzdTRmSXRiaWZtRnhJSjZ2clhaSmxiQVQ3RmZhM29tZ1lzNHZl?=
 =?utf-8?B?MGpHK04zMEtTeExXc0psa01PM3EvZmpPaEZWODRORXh4T1NkcE96KzVsYTdD?=
 =?utf-8?B?Z252emd5MldEbWJMMENkVVVMTkhVM25FQ1NqSWQzMndyaXRvemlxQ21FcHZk?=
 =?utf-8?B?bytMSkRmSy8xUmt6b1hDWWZxaVJSSHo5TUxzMS9jc1UvVCtpNHZ3WWxFTUo3?=
 =?utf-8?B?cnlpNUhsdWVFL1lOZDFBbmhrMzE2blNuaGVmVTgxaGRNdXV3dHJ4bzEyUEJ1?=
 =?utf-8?B?dk9UUnMrWGhLRExQcjZXRjBzSFlST1QzazI5TVRZTG0xbjRwbUZLNEdXdnV2?=
 =?utf-8?B?K3BrdFNOVXIzNTJEUWdyTmxraHdsc0cwTWtTQzNDNGpYZzZsNHowb2ppR2VY?=
 =?utf-8?B?TDFUVnBGWHFta01aSndKVkdsWHB6NmE0Z2V5NU42Y1ZaYldhUk5XTmRlOUtS?=
 =?utf-8?B?clJ6ZjhuTWRUZ2tWMlFpaUVxSXdON2ZoMDJ6TmphUVI5YUdRRHJWT3JIQ2xD?=
 =?utf-8?B?SXhOQU5KbFdQV2FpREE3MUlqTjR5ZG5CSzdDVzNEY0pMQlZ6MGgvS2FNOXF4?=
 =?utf-8?B?S2RoVFNiQ3JJTXQ3Qk0wY0VabDYzNTRqZGZVd2hlbW9CdzJ3RzgzVDE3SFNz?=
 =?utf-8?B?Z2wvOWNFWEdoQmtXdHl1R2sxcXN4clNscERXZXRxYWx6bTYxRXZFOER6ZXRD?=
 =?utf-8?B?WG5pOHNGa2xVcFlzM2FiSGQ2bkJGT3ZRaFh4a2hKTTVJMWtTSzViNStmVjdZ?=
 =?utf-8?B?ZllzTGNRYmhEb09VWjRNdjhSbHF3bkl3TFpkTU9KTG1ueWNYcUhmY0hGck5G?=
 =?utf-8?B?WXU2cW55TkhIWVJoSmJyVHRWaDhMYTMrRHBBb01yVWxoMDJBUU1KbmpZYXNr?=
 =?utf-8?B?U0FpVlBLZlkzQk04Q25zOGswY1crcFBxS1pPK0U5MVdyTDFCejR4VDY4bEdx?=
 =?utf-8?B?N2QzT0VyaEowNFFlYmhZeVJpa3NwMTh0K1dSdFQ5VGtSWFMyK2dvWjNWa01a?=
 =?utf-8?B?dytSS3VIVGQyTDhhZEVqN3FoeG54amJDQjIvcW4xNW1qOGEvMDdPdFpFTVU3?=
 =?utf-8?B?eUJ1RUVOSHpDMVgxMXNGQzBUcHNneWluUkxyT0NtSC9RWG1oNitHVllsaTBK?=
 =?utf-8?Q?DCb3g7zrwIfN6Mg7XKKJbFLV9KXsHXA4fpQ+WO1vzmBVL?=
X-MS-Exchange-AntiSpam-MessageData-1: Mj1Xbn6wmFWaEg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3e94a1-9b00-4e03-c7eb-08deff570e88
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 07:37:31.0943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P4+R0J/VQ5ck5628EcRw0o9uTsidbCQYzFjG1EJMEMtiQ446tH46Yd88pUWSx3FuLaJoqwYoMHa05uXLQK2bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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
> It is currently possible to construct a non-`BitmapVec` backed
> `Bitmap` using `Bitmap::from_raw` that is larger than `i32::MAX`, and
> it is not part of the unsafe requirements. Restricting all bitmaps
> (even non-`BitmapVec` backed ones) to a maximum size of `i32::MAX`
> simplifies a few things and matches `BitmapVec::MAX_LEN`.

Can we be more explicit (if possible in the doccomments as well) about
what "a few things" is? IIUC we are doing this because some of the C
APIs take an `int`, so we can just state that much.

Note also (as a point to consider, not a review ask) that we could
enforce this requirement in the type system if we made `nbits` a
`Bounded<usize, 31>`. Currently `from_raw` and `from_raw_mut` are
unsafe, so this becomes one more invariant for the caller to uphold, but
would we have made them unsafe just for this if they weren't already?
