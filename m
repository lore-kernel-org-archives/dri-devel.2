Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D94AC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CA9310F4BD;
	Fri,  7 Aug 2026 13:04:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="EFQ6JLjv";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020123.outbound.protection.outlook.com [52.101.195.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F1510F4BD
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DilOBHx85W39MvYrcAqyaHD/BAdVWzRAkdVp4KkaFF1yLjxMebZh6G7Dp8G8Z8gpKXTuyT2VJgT3DXV7mw0MC6ONV7ZWbUhd+XaK4uXZSeAQIzzUq8YZINwAiif5IOxBcPfjjXt1dvVikWY0d1OHkgnkTXPHkq41emjhwc6UKwbOzuF9uYJmsi0iSscPIm0afRB7tjJz7XZVB9ekKoXDJKgzRHQZRkHxeeg0yQImAyT/w930XUp8vIoU4bkY6pxEkEBRgGHnOshtiWM9Ot/uevbg3qVZnvesn9689IQ4KxvfPKG+J53Wwjdcwc3mdihBYL4LBfHfzNwmx3X3RjuI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXNHqTSFBgxyG395OO7kUtvj/6MRDCuk5ijMENUwEY=;
 b=axJnhOBnOl9R8kUbYDVph3kABvegR8Jhen2oJTTyzyaITQ+vYrTKr52/qpR9wxLk0O526gefJefyUrjUSag08yyqrBvdetBSiBHL/FRfwmsHF/9LR/4btJGiJCqcTqIGiZxsKbCSsPHu5/wh1rDIAEZxFWmmuL3mKa7vJjBLFgcs/MMK5itkI9Ix2UcjQ/X/+phvUmfnqMynQZGsl+nrQZoU97Ol1s7V0+ZIDYnCdQeOCvIKDVCS4ILnpUmiAQ7kQ7qY+GF+ahJ0EVA82qMsiL+MIkJF1fXv3J+7jZi9wdC8j7OfuukM29UakCCfBoJ/pCKgQKzwZ3UuaFskl47t9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXNHqTSFBgxyG395OO7kUtvj/6MRDCuk5ijMENUwEY=;
 b=EFQ6JLjvkxpe+kcgQyHUUNpX6WyfXP17tqdoMdIs7neOl2GG29lzkT5wDDzNYURgI6Cn0ZH403kzsdG7E/YW0hunOvb1EH0NagaV7ft1DPXcll+MkiBG55mtOBxIef5AWwgpplyLnt3MuCdHyzAelYAe7S4vy+eKwAGyxGxQR0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB6623.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:302::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 13:04:48 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 13:04:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 14:04:47 +0100
Message-Id: <DKIQEJX6H5A0.1D3POLLNZB9YS@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] rust: dma: rename dma_handle to dma_address
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>
X-Mailer: aerc 0.21.0
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
 <20260805-falcon-dma-projections-v2-2-4cc9f3f13ee9@nvidia.com>
 <3a87960b-8a20-4947-a8b5-d5197174317c@arm.com>
 <DKHATVF1WAE7.NGVXJQD12XQ@kernel.org>
In-Reply-To: <DKHATVF1WAE7.NGVXJQD12XQ@kernel.org>
X-ClientProxiedBy: LO4P123CA0626.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: ff94e2c5-8c3c-4605-dd98-08def48475a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: nsLf+0eGfyFmtSaKY4Ak2BBDOshBwSc5z5xKvGSsJmJCxMxFFmJAooblPl4dlrXpMh4I0Mq1oCJkbLtkxlk4YL/oTXHNyFsIbBlmsaeHDDf2z9HWd9UvdKKljMTqZCpnIXtzaRLrN1/JXv416IfYfUVJwtaMsUubISrV5TJUjwoF9gio7sXbMN/G2xUzm+yLbDm0r/6oQ67fRmQugGYk9kpYu/fhtGf/6/5FiTXDcmuV/Qy5kcRGQiNZ7N0Rt10tNzSJ9SnQGQjhEw0n7dhKaYRtyp6keFqJdiu9hfkGDFOiYSa5hSQ+W9bnJeMOux5iVjkdsxSzE/SNZ2DwwR0DNX3n7HSLrwet6K+vCMlGP0oJ9HIExWUbCKU36XFsSFEnF9jbacMTYElKGXH3ALWFrM2AU30v7SUBPDbRpBcUdfq+rB0lluickQPXS9y00YI98xsj2EpyMhDeV2dzTmARUFWuHCgwR6CBXi0MJ5vOkUxXFH22AExegDucOLQED7JkDSXtnjwqXH3hVoQTqmqzDGlscl4bjL5IajefcUzT0b6RxPaYs8iGl2Lw522T3q4F+8dQj3yjiYVBcDgmj+5oaJopb9wKmJIe1eRps+s6WSlGYS4iVZzcTKP+3MOeOVjLDlMio7JYGTortf/8shqAPmPdcWiyAvNfQd2UxnUvRTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmw2NGQwZXhEY3hiTHI4OHdQd3FxL3l4QTBTOXBRSG8wVGYxMkJPajkxL28z?=
 =?utf-8?B?Y3c3bmRhK29RRDVlU2g4RWFnZFpsZlRwclNrZnRaeGdoSEpjMDhsNC9YM1Rj?=
 =?utf-8?B?SEJqZWt2Z3RpR0RZU2VjRkhoa29tSjZiMmd3THhJZGhoNkdmaXVZQ29TK2FO?=
 =?utf-8?B?NmFtbExUUDIzYWJyUU44L0VPNTdhMlRidVZQNU5ES1NGVlVPNy9uQlM0TEt3?=
 =?utf-8?B?eGZoc3NudEFJV1c2dFo5Zm01eVQyeHdsZlA5U2tZVVJDaldWMVorcFJFS0Q3?=
 =?utf-8?B?dWxOdFI0eVR6cFg3VFpsY3pZaWk1SjRSTWI3aUJ5OUFvL2RQNG84cWw0YXA4?=
 =?utf-8?B?VTJjZ1Ira0lZNmN0WnIraldNMWg5dndUVGtnWGxoVFgxcVl1R0hGV2x6ZGV5?=
 =?utf-8?B?dzMrSVNJVzFTZkdiVUNudlMxT1l1aEVtMDBBOUZpT3J5SHJsNUM3dHI2MTFP?=
 =?utf-8?B?OWZHNVltYW1xRXByZzZtZ09qVXpYZkl2QXlxa0QrTzBjcmUxWHhNTGo2QzJK?=
 =?utf-8?B?TG9NM0s1RzFxTVI0T05QNUNyRk5yOEloM2xsWTk5b09OTmZBT3dMRkJmYlly?=
 =?utf-8?B?RHo2NzN5L2lUakFaTzJBT0hRc1NKWGdnVkhtbVhRdlpmdjVpUk5nNHczaGFx?=
 =?utf-8?B?OHFWNWhwOERyQ0dVd0V0Qjlsek1ieHArUjJHc1NlUHFGOFNzMGNCSUJUZTJX?=
 =?utf-8?B?QWlSckhrM1Y4ZnYvd0V1TEZvZ3FBVFlnaFQzS2NGUitZanZLSzJ1ZWc0LzFD?=
 =?utf-8?B?TWYySzNzQ2Z2WnFLbHlGYWxVT1BIRGFheUVQRTN4VEszOVpNWlRPbXRxNWt2?=
 =?utf-8?B?YUJyMDc5S2R5UnR3YlRtZlNGTWJnMlFDbmlTb2tHa1ZidVEvYk9VRkE1eTZK?=
 =?utf-8?B?R0hsaHVVZnRwaEdqZjJKS24vOVlTeFZwYkxFV0YyZGh5WGVXcG5SSFZCSGh3?=
 =?utf-8?B?M0FPMlB5NmZFZE82WFhySnlCalpvSHBDUXVDRXFWUjBNTWNJNy9XWFg2aWJO?=
 =?utf-8?B?VmdwVDVOYzFHVEcxb2UzajFJamVNNEpYMExJNDRIc2N0MUd0dDZJSWJzTmh2?=
 =?utf-8?B?cmRUMGdWM2xoaXJ6VzYvUG9IUFVsVjZsWlVCTTNiTWt2clQxSDBMaTZ1MzZq?=
 =?utf-8?B?b0JIQTlKSUM5TlgzbWZMeFpFbXhsRzEwS0ZYa3BmaEpJemQvYWVWczdXRTZP?=
 =?utf-8?B?VzRRelBCcWJlZUtta3ROeFR4NG1GU0hZR2ZiRE9Wc0dkZVZTRXZzbk5kNlZs?=
 =?utf-8?B?Q0RYSld4S3ZzaHB2NVBxM2VmbTIwRDNDUGF6cm4vcVhOSGlzYTM0WjBhWGVZ?=
 =?utf-8?B?d3h6VXVaK2lpTis2Z3NEV3pyU0ZHaEloOFkwQmY2SERUakhpc1htYk9zdFJx?=
 =?utf-8?B?V2FQMXg4K0FtMzAweklwTm9iU3ZpZjVYd1B3TEgzWGttRzBYVWJkcGhKb0pN?=
 =?utf-8?B?UUtxcjZxbjBUV29pOFpuamExUTErdU5jRE5SMW5IVEVwaTBQSGYwMFZwUmZP?=
 =?utf-8?B?WHpkWVlaMEU0d3E3TzBNQklyZVJ6WEpHMDNROG1nM01PbFJ1M2cxT01jcWpK?=
 =?utf-8?B?V0p2TWNMODJzOUZVbDZYUE5BUmY3WEtCK0VWczBOekthSDNTN0dIQUVRV0wr?=
 =?utf-8?B?eTBnaXBpMjdmbFB2aUZtakFlaC9JUjNwZXdBbEt2YUFEeVp3NHphQ2Q1SkJV?=
 =?utf-8?B?d29UaWFQcTRLRUJSOXJScllwYThaVXhDSUlhSFplcDRRWVJHNWJmWXZqSktM?=
 =?utf-8?B?TjhaMjYrUmd3eHVwd2FiemVBam5qL01tWGI1NEVVQnZSQ3RLR1pOZXZ1T01n?=
 =?utf-8?B?bFViUlVoeTA3Tnk0TVo4NnFjL1ROY01EdkM4UGgxU2ZKeDNDYUt0UDRIMytp?=
 =?utf-8?B?Mmd0OFJ4dWQ0QTlKMnhWcnE2SWFhbGoxeWwrTW1DWnVJcERWMEFTWUNKQ1VD?=
 =?utf-8?B?LzkrdU5oNlZ4aWtGTkU5Lzk3YUxFV3NtZnEvWjR6c1p0K2ZaRFFRa293ZC9U?=
 =?utf-8?B?RFJKbmU5RWwxbHhENWVVMDh6WjcrTWhwM3FZSFIzYjhHQk9iQ2ZHZkVmdmxO?=
 =?utf-8?B?WE9ncWRIdFlqSEJHVjc1dU1CK1Vpd3p3KzRVRTdCTnlBaGIvSGg2NXFFTHo4?=
 =?utf-8?B?c3crTGxjTTVyUUp3UnJXZWZ0VnZ4Q3hwRWtwRzJacmlXeTd6cmFLYStjT1Bm?=
 =?utf-8?B?UElSaCtzeDhHVU1mTUpXTHVzak16Z0ptbzFQbzl6VUlJUkJTc3Y5NnBwM0ky?=
 =?utf-8?B?MllDVmtZc1NTa0xhU3I2cEt3ZnNtaVRoODhSMThxYTdmZERKaHhiaEpnK1ZU?=
 =?utf-8?B?dFFpVUd2TExiVkFwdGwxTitXR282d3dEMWMyTC9sb0Q5SkxPRm1wUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ff94e2c5-8c3c-4605-dd98-08def48475a1
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 13:04:48.0457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap1daCNplDeLHXt8ziqRKARpzKK0utaqbRAsRmJdFtVq3YeDLJrx9DFHli9OjOR0JBSNaz5JRUVUsGL5YoypOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6623
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

On Wed Aug 5, 2026 at 9:39 PM BST, Danilo Krummrich wrote:
> On Wed Aug 5, 2026 at 1:32 PM CEST, Robin Murphy wrote:
>> To be fair, that is sort of the intent in the C API as well, to be clear=
=20
>> that DMA addresses must not simply be treated as physical addresses, and=
=20
>> aren't necessarily address-like in general e.g. comparing two=20
>> dma_handles is pretty meaningless, since they could have different=20
>> values but still refer to the same underlying memory, or vice-versa.=20
>> Adding or subtracting offsets within the bounds of the original=20
>> allocation/mapping size is pretty much the only arithmetic that _is_ val=
id.
>
> Yes, I did suggest a dma::Range type [1] for this purpose, such that only=
 this
> kind arithmetic is possible to do.
>
> The dma::Range type should have a method returning its embedded raw value=
 which
> then can be used to program registers etc.
>
> This patch is only an intermediate step, that clarifies that intent of th=
e
> current usage of dma_handle() (or now dma_address()), which is not to ser=
ve as a
> handle.

I suppose with I/O projections now it's rarer that people need to operate o=
n dma
address directly? What do you envison as the use case for `dma::Range`?

Also, I suppose we can also represent dma address ranges as `Io` views that=
 does
not implement any accessor methods, so projection still works on them.

Best,
Gary

>
> [1] https://github.com/Rust-for-Linux/linux/issues/1248
>
>> However at the Rust level, the abstraction itself can convey (and even=20
>> enforce!) most of that, so for the sake of clarity here, particularly if=
=20
>> Rust programmers are likely to have their own expectations of what=20
>> "address" and "handle" mean, then I'm inclined to agree.
>
> Yeah, as mentioned in the link below, the handle that represents the allo=
cation
> are the DMA container types (such as dma::Coherent) themselves.
>
>>> Link: https://lore.kernel.org/all/DK75LUA4NLGI.3P29AIZQE20V2@kernel.org=
/


