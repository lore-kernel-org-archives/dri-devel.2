Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7418C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B1210F1B6;
	Thu, 13 Aug 2026 07:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p4UFhMhY";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B39E10F1C0;
 Thu, 13 Aug 2026 07:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHm7ppds3E0Q2yeFktdqm08ZLCYLlL6AFRDCjKi0l4uHfNEYwpXnla0OYDHOe2rnBFgGeDbRtJvr8+ASjeEjA59o2Zjr36YO6UczC+KPIKE5q4e3jfrQ+SEGMXzQAsGtpvNw8+lNIhGQa2DF0W5jcjxgmm2K4MSj/M4blx3JE5bhmrzmpBdRZ5V3xeFZuvXGmzGX3rkC1vdEoaDTGWls6Wx5mjdd2Uqz99WApLjgPW65ytQBfLBNF5ysInzW2JDFGCn7MdyUM/2LevdeCotaUpIfPukOEK5+M4jpkZIiqC5ZPoTq5Xk/67seV8RC0lXfxLxSE99nG44iaKjnOUNBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wEpi1zpbN1lauXVmmIPDZSRslYdLdub6NkSZZPoCkc=;
 b=tGg77mVGZ+P+FnPZzR9eQddRAzj0dEDhxCjR8FjP4f01Zgj7XDUuOoe/jkPR0EdYMPdDnE4lnhy+QdCDXpBsWNBhQJ+ldl9XbOrEcdquDYnaSQ4TcNGMH+2h7d3lM6MEFob9WJX5dmAkZsY5Grq9o2H0IVr3sYwyDHraWXuAtpWxKIWB/i5gPokJ/s8JH1hKSVDjzJdiKMc8viwtQFkOtvknqyUaj8ky1ArjqoPg0Bkdj6OjEAi0ScY5SZmFnNmvNsnCfHMJOBTztxZ2fGq5gbWx5FbY2WnO1gsZzTyyOyzuOHMtXVEY/MtDK6cu09n318i1sm/aAelUZsZZ1uo2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wEpi1zpbN1lauXVmmIPDZSRslYdLdub6NkSZZPoCkc=;
 b=p4UFhMhYdVUiQqzLTBg9a3enFJKJwiz3sN4ZVinfxr+WheRnbeT55l9mAwMlSNIU3SGDMKKnhEMu+kn4kB8DqRLaWJ0pko8egN8rpL4r91u/1K7KS36bCx8EL6EqmTOh4LUwwH2+arROJRCcBdoHGpqgwOTGqM4O8/3mNv10scw/T4uneRgB5nAQCmJP8MmX95NelwbCc2XLTqUjixgsELnczDl39oBF/Y0rJweA8LSlx1bPJb7OXE4NA7VPG6jQdERM0KZxYew/1y2TxIqzZUFVVLdf2RYew7vMb5phkX+ZccPFO44l6ih8Gmfzqp0/m9E6YT7SnijYGnVcY8QgiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:31:31 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:31:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 16:31:26 +0900
Message-Id: <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
In-Reply-To: <anzxKO0X1OrNRD32@yury>
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: c5222f4f-1bd1-4ada-099a-08def90ce4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|7416014|366016|1800799024|22082099003|18002099003|56012099006|4143699003|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: A/mDugoRfNY3D0LO8Q76P9eMrN+RPp8Gg65VJPM+DdqZnsf6mtTWywlG43nV9UBlYWdZ9owxMJbBiNGA6s13lPrhwZtaOjGy4moWXFa9uiY3NqBCxSl9r2GBzJtXRyy7dPVJF2YdW5QQyK4Kzd1kC9wEWCHA1sBOvQ7yEc7XLH3s0vXLBKv7qpMAHMNMfjw1odzeRk4rmcAs3YCdUbznJbf/tkt4KPQYQ4qqfQakcSQcdmRwf9WVTCFg7ZuSn6YDWJfmjiycyWYwSXK67VJsctwFCvKjbDKu/imUZexW2Q42x6EnsjicuEDeF3nP1yysi6nQZKN2mhzo84K5UqavPmz8SsdUVmqysEd8nSDXDeS4Za6zZghCakyMeDpX/hAsWA4GbpLO+KJ4noOtwNuXkxPu1y04ElaucYpBwrrJnrJmbD5rBuOuRKoYnJewNYzwzOqjkHEFSVv1F+0qF3B3Xb9029SkXaCuUoCufkHAqRaBh4+VryhGU5UE9pbw586mJeHZhBGDm+OTAl/Dhm72d2/Y7qqYIte+yPestbQeCUMdcLQ4st+OdAdMnVRu2UfbexeUYURXlAVGX65aqHigDEY3M1NBU+HAjpJORmerxmzHwxU2emSiNfuSfrzSVdrnZ8cVMlNTNSoUQJ2eWL38f33FdzS5epYfhcM3v2l20Wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkU2ZEszV1lHYUZsWmFLRzJNWUY4dzhrbm1vRGFzZWQzb2wwdDFqV3ZZVHFo?=
 =?utf-8?B?NllLWWdUaU5oTkFZTXFwYmVPb1ltWWdkUmwrOHlZaHVRMkNHczltWlBCbXVo?=
 =?utf-8?B?d0xMaHBDN1RPY2JvWTJCWG9DTUNIY0dCZkJYZmllLzlJQyszWFR2OTF0a0pT?=
 =?utf-8?B?aWV5b25zWVZhYWtyRFhRQUwzd3I3RFRJTWNNMmxPcXExOXdoZnQxV2NmdFdG?=
 =?utf-8?B?eGhhbUUrQjRWMkxrMm1aS3RIK1hRdDBpVjIwMXZmYzB2RUloa245QTJPL1Rm?=
 =?utf-8?B?WlFXS3V2Y293VDBJMWd3V1gzZjNyZlQ4ckFiZjgvaHpEV1RhTkxxeDkwL1JQ?=
 =?utf-8?B?ckpTMjlpaG1UVi92dENQUm5sbUVOcVdqNDRvY2x1OXJBcHo3aTVmbEhyVTRY?=
 =?utf-8?B?NHN3R1UwVkRiQVpGc0lSS2hHT2NzM0oxaW5MTHJiSUxQRGU2TjFRbkUzZnY5?=
 =?utf-8?B?LzZreG1UcDVPbGt6Uk1Ba0k1NVcwMnhwSVRMbmJ1M245ZVdxQkhkSmM4WmVk?=
 =?utf-8?B?YVM0dUlrNG1lUzU5Z1JEMy82L3R3UGs2SzdEeXZGSEhBQ2RLVTY1ODFZRmNS?=
 =?utf-8?B?K1BPblByZXJBamsrRHcxVGM4N096azh3ZjQwNk1nd1d1NGJpYkh4cHZpbERP?=
 =?utf-8?B?bTlXdm9DMG9WMkx0cDVEYURWTzVZc2JSWkJ2UCtmT0pjNzUrZ3R2aHlIVlhl?=
 =?utf-8?B?UlIzandKVW1HbU5MUkZGMVR6NStJR1lnSkdmUmVrR2lOYlVOTGhuNWZTVDIw?=
 =?utf-8?B?ZTZ6NU9KQ3VnQ1BUcmhjTUY5NnUvS3ZlNitteHBIc3J0L0NxY04xMXFJei9U?=
 =?utf-8?B?NXRvODVhVkdmRlNqVHI3N2lLOGI1dXVyclFrbEFUaElxN0ZabWloWnAvVjhI?=
 =?utf-8?B?ZldnR2tmTXJTVXc1KzE1YTNXOGFDdWo3bkN4UXduVXVVQ0NrSW81R0dURHAy?=
 =?utf-8?B?UjFyZGhWbFhWSlFFbStHaU1uTTJweDdwSmpDZU1LQ2ZIaEsyS2JzbzZXZ0k0?=
 =?utf-8?B?elZobDBLcUl4aHZLcUQ4M2hrQjBYN0l4Ni9LUnhQVW9DTlcySTV5SVkxSHcw?=
 =?utf-8?B?SVhIcDg2Y3F3YUp6WWxRdWFjN1ZOTFNlVDU0ajdQUk45akhFenR6L1RNTlNv?=
 =?utf-8?B?UXpwVnA2MzNiMkt5M25ZdUNCcHdoejNnWUhTcmpRVnJ1OTk4L1ZrNW02MVdI?=
 =?utf-8?B?TUhLaW1vdTNrRnRMSldybGlMU3VPTDdLd0hRTTlQVzM1MGtjTDdpU1FsL0l1?=
 =?utf-8?B?cFN6Q04xT2YrMVV6dnZvR0RtK0pXVGYvTXRZOXdkc01pS2lzNXgvdmFOdlky?=
 =?utf-8?B?R2pUb0NrUEt3TkFIQU14R2orZXptRkhKZ2wydkdNRnJHdXIzN0paSE9uQjAr?=
 =?utf-8?B?b1hWUzlyVnpDZW90T3BsMUdxN1Y2eWZpTHFDRmtNcnhySlFMZXlJckI2QTY3?=
 =?utf-8?B?RFcvS3FKSzdlYVJBOFpkQlFhRVVwYUpqZ1owSDYwSGxUcGU4YTNMTjJqN2xk?=
 =?utf-8?B?ZTBwVEtqbFJBazRSeUFSd1lIWWpZVzFhd0NUSy9wa3U1M2x5SnpGd3JwNHFD?=
 =?utf-8?B?YXFYZ3JYZlFPejF1TGg5SXdpMjlvcTVmOW9wbzArUnN3REVaYkJWUFYyMStI?=
 =?utf-8?B?bmw0TFBPTCtYWDFONHo2S3dOeC84WWZRMTEydmR1SUxNWS9iRXFoT2tRMXFM?=
 =?utf-8?B?a0ZWNTIvb2JGMzllZmpDYXcwc0dHc2hkSytiSG9OVnlwMHZwT285bTV5R3hJ?=
 =?utf-8?B?d0MvaFpnamFPei9UQ3ZYVUZlVVZrVHpSV0szTzRiR2VVL29GcllKQlg1bnBO?=
 =?utf-8?B?NXdRTGMwSEJsYnZ0VlIzbGNyUzJPeUhPTklRQit0eEZzQ0w1MDh3b0FYV3RW?=
 =?utf-8?B?ZXRyL1NMdE5lSXBmbXUraDBIL2E0dFNPZTFYd0ZDKzVDNSsvMUVkQUJDZUZv?=
 =?utf-8?B?emRzR2pIMHpBemVuKzZiU1ZMZXFIQ09zZ0N0eTR4YVBuNit0ZFVQV1BndmFF?=
 =?utf-8?B?eUV3MXEwVVVSL25GYVRnRUNBMDEreThCVjRGaGJWR1Jnd0gyc2JEZGZONnpD?=
 =?utf-8?B?QnRQYmg5YmgrdkVnb0kza2VhckNjVndZWW1mdHFIUnhja0dzNkFKeExJSHpu?=
 =?utf-8?B?clNFUThBYUwxcm05b2xVcVFQQkR5b0hKOWpDbEZya1RKTWluUTBGM0MrbFBD?=
 =?utf-8?B?aCsvL3BNVm05TzJ2a2VNU1JDNTdOd2NoR0ttMDdXZ1duZm9XdmVGZWowQU1y?=
 =?utf-8?B?TlpDTW9YWitzRHJxSzI3SzREWDliQ08zZWtlOUJZOHRyMndRRFlGZGJFOG44?=
 =?utf-8?B?aWFGMXhXT2krU0puREdzSExRdjRpZzg5cXVESGJ3aFE3VHJCOW9qRS8rN1pu?=
 =?utf-8?Q?32vqYoGu5XpBtSBBwxISb9vLA68QhuNcW2pjqq3oM5oE9?=
X-MS-Exchange-AntiSpam-MessageData-1: +urjTKMRvxVpbg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5222f4f-1bd1-4ada-099a-08def90ce4ed
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:31:31.0375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66jWv4+fv9q0bqn6h7bZVjbO40IFd1aIjJ56DNsCQqPMeoLubjihiO+MdEkb4jypJgwnbLhmNiJbu4aUQEYeGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

On Thu Aug 13, 2026 at 7:18 AM JST, Yury Norov wrote:
> On Wed, Aug 12, 2026 at 05:51:25PM +0900, Eliot Courtney wrote:
>> Add `ChannelIdPool` which adds automatic tracking and releasing of
>> channel IDs on top of `IdPool`. This is necessary for apportioning
>> ranges of channel IDs to be used in e.g. vGPU.
>>=20
>> Channel IDs are allocated as a contiguous sequence with a specific
>> length and sometimes a specific alignment [1] for vGPU. The ID space is
>> small (limited to 2048) and allocation is not on a hot path, so a
>> bitmap-backed `IdPool` is a better fit than IDA/xarray (which allocate a
>> single ID within a range, not a contiguous sequence) or a maple tree
>> (where aligned allocation needs an alloc_range()+erase() retry loop that
>> essentially reimplements bitmap_find_next_zero_area()) [2]. It is
>> also faster than maple tree [3].
>>=20
>> Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@n=
vidia.com/ # [1]
>> Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@=
nvidia.com/ # [2]
>> Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.=
com/ # [3]
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gpu.rs         |   2 +
>>  drivers/gpu/nova-core/gpu/channel.rs | 180 ++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 182 insertions(+)
>>=20
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index 42a4cd7971fa..66ea697a89f8 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -33,6 +33,8 @@
>>      vgpu::VgpuManager, //
>>  };
>> =20
>> +#[cfg_attr(not(CONFIG_KUNIT =3D "y"), expect(dead_code))]
>> +mod channel;
>>  mod hal;
>> =20
>>  macro_rules! define_chipset {
>> diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-cor=
e/gpu/channel.rs
>> new file mode 100644
>> index 000000000000..b755d2184aee
>> --- /dev/null
>> +++ b/drivers/gpu/nova-core/gpu/channel.rs
>> @@ -0,0 +1,180 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFI=
LIATES. All rights reserved.
>> +
>> +//! Channel ID allocation.
>> +
>> +use core::{
>> +    num::NonZero,
>> +    ops::{
>> +        Deref,
>> +        Range, //
>> +    }, //
>> +};
>> +
>> +use kernel::{
>> +    id_pool::IdPool,
>> +    prelude::*,
>> +    ptr::Alignment,
>> +    sync::{
>> +        new_mutex,
>> +        Mutex, //
>> +    }, //
>> +};
>> +
>> +/// Pool for tracking reservations of channel IDs.
>> +#[pin_data]
>> +pub(crate) struct ChannelIdPool {
>> +    #[pin]
>> +    inner: Mutex<IdPool>,
>> +    num_chids: usize,
>> +}
>> +
>> +impl ChannelIdPool {
>> +    /// Creates a pool managing `num_chids` channel IDs.
>> +    pub(crate) fn new(num_chids: usize) -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {
>> +            inner <- new_mutex!(IdPool::with_capacity(num_chids, GFP_KE=
RNEL)?),
>> +            num_chids,
>> +        })
>> +    }
>> +
>> +    /// Reserves a contiguous area of `count` channel IDs starting at a=
 multiple of `align`,
>> +    /// returning a guard that releases the area on drop.
>> +    pub(crate) fn alloc_area(
>> +        &self,
>> +        count: NonZero<usize>,
>
> OK, here you use NonZero. Please do that in the lowest layer.

Will do~

>
>> +        align: Alignment,
>> +    ) -> Result<ChannelIdArea<'_>> {
>> +        let mut ids =3D self.inner.lock();
>> +        let area =3D ids.find_unused_area(0, count, align).ok_or(ENOSPC=
)?;
>> +
>> +        // If the pool is small, the backing bitmap may be rounded up t=
o a larger size.
>
> Not sure I understand this language. Your ID pool is a fixed-size. Or
> do you mean something else?

Yeah this is a little confusing. The reason this exists is because
`IdPool::with_capacity` will round up the size to
`BitmapVec::MAX_INLINE_LEN`. For binder, there isn't a natural limit to
the ID space IIUC so it's not a problem there.

Anyway, in this case, IdPool can return an area that is outside of the
original capacity you gave to `IdPool::with_capacity`, hence this check.
But, I had a closer look at IdPool::with_capacity, and I can't see a
good reason for why it's doing this adjusting to a min of
`BitmapVec::MAX_INLINE_LEN`. So let me try to instead remove that
behaviour.

>
>> +        if area.range().end > self.num_chids {
>> +            return Err(ENOSPC);
>> +        }
>> +        Ok(ChannelIdArea {
>> +            pool: self,
>> +            range: area.acquire(),
>> +        })
>> +    }
>> +}
>> +
>> +/// A reserved contiguous area of channel IDs.
>> +///
>> +/// Releases the whole area back to its [`ChannelIdPool`] when dropped.=
 Releasing locks a
>> +/// sleeping [`Mutex`], so the area must be dropped in a context that i=
s allowed to sleep.
>> +#[must_use =3D "the channel ID area is released immediately when unused=
"]
>> +pub(crate) struct ChannelIdArea<'a> {
>> +    pool: &'a ChannelIdPool,
>> +    range: Range<usize>,
>> +}
>> +
>> +impl Drop for ChannelIdArea<'_> {
>> +    fn drop(&mut self) {
>> +        self.pool.inner.lock().release_area(&self.range);
>> +    }
>> +}
>> +
>> +impl Deref for ChannelIdArea<'_> {
>> +    type Target =3D Range<usize>;
>> +
>> +    fn deref(&self) -> &Self::Target {
>> +        &self.range
>> +    }
>> +}
>> +
>> +#[kunit_tests(nova_core_channel)]
>> +mod tests {
>> +    use super::*;
>> +
>> +    const fn nz<const N: usize>() -> NonZero<usize> {
>> +        const { NonZero::new(N).unwrap() }
>> +    }
>> +
>> +    #[test]
>> +    fn chid_area() -> Result {
>> +        let pool =3D KBox::pin_init(ChannelIdPool::new(2048), GFP_KERNE=
L)?;
>> +        let unaligned =3D Alignment::new::<1>();
>> +
>> +        let first =3D pool.alloc_area(nz::<48>(), unaligned)?;
>> +        assert_eq!(0, first.start);
>> +        assert_eq!(48, first.len());
>> +        assert_eq!(48, first.end);
>> +
>> +        let second =3D pool.alloc_area(nz::<48>(), unaligned)?;
>> +        assert!(first.end <=3D second.start || second.end <=3D first.st=
art);
>> +
>> +        let first_start =3D first.start;
>> +        drop(first);
>
> You test the drop() only once. Can you add more tests? At least, make
> sure that 2 allocs followed by 2 drops ends up with an empty pool.

Yerp good idea. Thanks!

>
>> +        assert_eq!(first_start, pool.alloc_area(nz::<48>(), unaligned)?=
.start);
>> +        Ok(())
>> +    }
>> +
>> +    #[test]
>> +    fn chid_bounded_by_num_chids() -> Result {
>> +        let pool =3D KBox::pin_init(ChannelIdPool::new(4), GFP_KERNEL)?=
;
>> +        let unaligned =3D Alignment::new::<1>();
>> +
>> +        {
>> +            let a =3D pool.alloc_area(nz::<1>(), unaligned)?;
>> +            let b =3D pool.alloc_area(nz::<1>(), unaligned)?;
>> +            let c =3D pool.alloc_area(nz::<1>(), unaligned)?;
>> +            let d =3D pool.alloc_area(nz::<1>(), unaligned)?;
>
> OK, here your alloc_area() means the find + alloc, and it returns
> a Range - not area.
>
> To me it looks like the intermediate UnusedArea layer is excessive.
> If you just do find + alloc in this pool.alloc_area(), you seemingly
> don't need the UnusedArea.
>
> Can you try without it, please?

Yes, you're correct that `UnusedArea` layer isn't strictly required. We
are using it once to handle the case when IdPool gives us back something
that is outside of what we originally requested. But we could also
handle this just by bitmap setting the range
`num_chids..pool.capacity()` on creation of `ChannelIdPool`, runtime
checking num_chids >=3D BitmapVec::MAX_INLINE_LEN, or changing IdPool to
always create a bitmap of the specified capacity (this is what I'll do
unless someone knows a good reason not to).

>
>> +            assert_eq!(0, a.start);
>> +            assert_eq!(1, b.start);
>> +            assert_eq!(2, c.start);
>> +            assert_eq!(3, d.start);
>> +            assert_eq!(
>> +                Err(ENOSPC),
>> +                pool.alloc_area(nz::<1>(), unaligned).map(|_| ())
>> +            );
>> +        }
>> +
>> +        assert_eq!(0, pool.alloc_area(nz::<4>(), unaligned)?.start);
>> +        assert_eq!(
>> +            Err(ENOSPC),
>> +            pool.alloc_area(nz::<5>(), unaligned).map(|_| ())
>> +        );
>> +
>> +        let head =3D pool.alloc_area(nz::<3>(), unaligned)?;
>> +        assert_eq!(0, head.start);
>> +        assert_eq!(
>> +            Err(ENOSPC),
>> +            pool.alloc_area(nz::<2>(), unaligned).map(|_| ())
>> +        );
>> +        assert_eq!(3, pool.alloc_area(nz::<1>(), unaligned)?.start);
>> +        Ok(())
>> +    }
>> +
>> +    #[test]
>> +    fn chid_area_aligned() -> Result {
>> +        let pool =3D KBox::pin_init(ChannelIdPool::new(16), GFP_KERNEL)=
?;
>> +        let unaligned =3D Alignment::new::<1>();
>> +        let align4 =3D Alignment::new::<4>();
>> +
>> +        // Alloc 0 so the first fit for the next area is unaligned.
>> +        let pad =3D pool.alloc_area(nz::<1>(), unaligned)?;
>> +        assert_eq!(0, pad.start);
>> +
>> +        let a =3D pool.alloc_area(nz::<4>(), align4)?;
>> +        assert_eq!(4, a.start);
>> +
>> +        // The area skipped over by the aligned allocation should still=
 be available.
>> +        let b =3D pool.alloc_area(nz::<1>(), unaligned)?;
>> +        assert_eq!(1, b.start);
>> +
>> +        let c =3D pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
>
> Is it possible to make it somehow simpler:
>
>            let c =3D pool.alloc_area(8, 8)?;
>
> All the parameters checking must be a part of implementations, not the
> interface.
>
> We had a very similar discussion in the bitfields implementation thread,
> and many people in CC list of this thread spent quite a long time to find
> a way from:
>
>         let color =3D Rgb::default()
>            .set_red(Bounded::<u16, _>::new::<0x10>())
>            .set_green(Bounded::<u16, _>::new::<0x1f>())
>            .set_blue(Bounded::<u16, _>::new::<0x18>());
>
>  to:
>
>
>          let color =3D Rgb::default().
>            .set_red(0x10)
>            .set_green(0x1f)
>            .set_blue(0x18)
>
> Can you do the same here? Please refer:
>
> https://lore.kernel.org/all/aXCZeVqkDrBWr1uq@yury/

I think that taking NonZero and Alignment here obviates the need for
checking the parameters, since they have their own guarantees (and Alice
recommended using Alignment on `Bitmap` too for this reason IIUC). Maybe
I am misundertanding but we spent a few iterations here adding
`Alignment` and `NonZero` on various parameters -- do you mean just
making ChannelIdPool::alloc_area work with a plain integer syntax? It's
possible to just take plain integers here and check, but I don't think
it's necessarily better.

W.r.t. the bitfield stuff, yeah I agree that was a good call since that
syntax was very verbose, and IIUC that was resolved by having e.g.
with_const_red::<0x10>(). The analogous change here would be to provide
const generic args, e.g. alloc_area_const::<size, align>() which could
be plain integers. But, in practice the arguments to alloc_area are
going to be runtime values (outside of tests) that the caller has
strictly more info about. Having the separate types (NonZero, Alignment)
also makes easier to not mix up the order. I can't think of a way to
remove this verbosity without just passing plain integer runtime values,
which IMO is not great.

>
>> +        assert_eq!(8, c.start);
>> +
>> +        // Only 2 IDs left.
>> +        assert_eq!(Err(ENOSPC), pool.alloc_area(nz::<4>(), align4).map(=
|_| ()));
>> +        assert_eq!(
>> +            Err(ENOSPC),
>> +            pool.alloc_area(nz::<1>(), Alignment::new::<32>())
>> +                .map(|_| ())
>> +        );
>> +
>> +        assert_eq!(2, pool.alloc_area(nz::<2>(), unaligned)?.start);
>> +        Ok(())
>> +    }
>> +}
>>=20
>> --=20
>> 2.55.0

