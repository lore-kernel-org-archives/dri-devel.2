Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3069C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 517A610F9C2;
	Fri, 25 Sep 2026 10:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="pd5UJsxx";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021080.outbound.protection.outlook.com [52.101.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB93A10F9C2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQJWtpyAZOym/wJdICELh1wDLPdlVRA4I/oohZZZFo+jl/Z7aEqtc/PRbNdn3q9LuQr444WqvvIoyZjcqc0+5x5D1fyeCJYpwa/pTpXIq+cvdsncbxj9fbWjnmiKRyPPmJgv1+DBKha+sFdRjYb75pQX4GVTpsu75SB8kgnviCsxQHA4YLkBcCh7PjiqxXCjJTDdlhvlB0bp9L/svPcj7Ltutv/lMfE4KZMFH0/bpyBMbFVpNrG8Jn2eAW1U0MBcZ9KW/f/u+YFHW/MfD2GxmTnRz/f8zwtMHI54ckUIDktHN9U9LCZiBftAALpIVlc/9P+1z13Q7jB0RDyGTX96eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxjsxFHoYdELjeP4Y2+qg2AfABHp+CmZcqUvVsK6i4g=;
 b=T5C6vudqPaDmUzJJrv5sqM7h+D4Dr8U5w/SdDQiGvkvFzqwCVocn8Tt8wlzr/5wHvwdgSF9ace/UEWsxLWFPeH/d06WCFWnd2nHYqcAEEojRCpZzNog6hhgHCltL7XwvyHd/u1t9buTRQV4CFDwl4/PJkNlJi1SV3oiucjJClsxOSDIwWIaFBUkQwOZ/2gHDe8S8Ob6jCZMb5Gj1yOGZqat0IKv6zDIqgtv2BlPNHN+rmFxpHbr0Uloi4GTzkB0v1uzFhEVOBvnSZVgFoCSdB4R4BSAPcLGQqJqAWNIQoJMQ0xGV5DcUJeIujotXcC2TsCoB6TuJ5CujsZ11s8xJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxjsxFHoYdELjeP4Y2+qg2AfABHp+CmZcqUvVsK6i4g=;
 b=pd5UJsxxTXdUNQlMPxu4n3zvrCZ0/kYWZtsU/FNVtVbLxnn55QqLJs85o/Fas5gqTi6E4Nt3rSvR3yL96nxg16VOjfkiUPw/yYdHxiFP8laV00A4+xSIXJ3OVnJMoJKKzFXk/23aXJfU0/YVGIM/kAloytJvrL0yQlwhgC8Mn+w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7405.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:219::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:29:11 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 10:29:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 11:29:07 +0100
Message-Id: <DLOBS2HQYSWS.2W0JMY91EZ48V@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/tyr: safely write GpuInfo to userspace
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Deborah Brouwer"
 <deborah.brouwer@collabora.com>
X-Mailer: aerc 0.22.0
References: <20260924-b4-gpu_info_intobytes-v2-1-1b05e33df8a4@collabora.com>
 <CAH5fLgj=h_riWoOvEX_TOH3+0FNbKBtjO1OrxzwHDQq7uzXg_A@mail.gmail.com>
In-Reply-To: <CAH5fLgj=h_riWoOvEX_TOH3+0FNbKBtjO1OrxzwHDQq7uzXg_A@mail.gmail.com>
X-ClientProxiedBy: LO0P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: a90e7ecd-6a1e-4831-c60b-08df1aefd530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|56012099006|18002099003|4143699003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: qK46F+gLzoN/ZXmeLCI4psc0u9KaCdbJPLDQxuTspiFqfR+qtyArIa04cl7q3kxqFqhhVEo/OOwj9+w9SrVSHa0kZ4gViSiCijMLvDiC1tLL3vgUqw/m8GYPRDdHdB7awUxQTKkLfU++b/lxy84BR72PqtNsG+b21mG3ILEP8hldsMMLKOdHfUPR5eoawVKAutJ8JSgSn/njW2hk8n98hyKhPyppYwAv+o4K8hIpBtZp0p+vI0hs6dSYE1yTAW8bOMiurZ8KhwtvPuL+nCbtW5x6MAdSNJftbQmBwUxc6FuuCqnFfNvtHmi8O6wGceMzrBMVHZtqTh2qSDubw41vJ1X8g5e+EfGtL/EeQvyFBhQOZ1+TSApT1QpemBeAwFqJApC3k0UIcDogQkEKfKhYNd1+FRc5sPNZsGooqZ0eDosXekletCxt2D9bcoZQqC/cm6zgGbPl0561inYMfJLhOXcv/X6HQ15ZobMbgJBTmU00T8n71d3GV3e/wD1gqgTza1Y6LKL2wzs1cN+QimDYci1GZb72H4KkMLRxQxqdc+WgGKoC9UoBIrIQLqgVk0C6Tm9aWBRUlOyYe5otI9gmPJZ/x5G1QEZMxSiqAlWs/SPow2GIaAOTFeEFsIlUXxxIoYJuxwX/WIROdOHctX9sHP0TQT6GI3fADBn741BJZoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(56012099006)(18002099003)(4143699003)(22082099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE8ycDZYZmVvT2dMcUJTYlpvOFdQUDVSZGJaMXJRckFPbjNOcVgyOW5XQzJU?=
 =?utf-8?B?cElrWnhsWWpZVkhPOUNMc1NUaDB6NFpneFZFek5Gejc4N1V0bE4zWTA1eHp6?=
 =?utf-8?B?Y3hnU0t5RGg4QUF0am9xVmxmWGRaTDk3T24vRG9CSXk1c3ppMHVyRjVIdUY2?=
 =?utf-8?B?MlJwK1N6Y3c3VmhBWjM3ZG9vTGc5bFFGTmFxODk0Z2xzM01MaFlIM216d1NL?=
 =?utf-8?B?T2pLa1YwSEZOWEF1akNIbDhteWRwZHVvTEFLeExXNVNrUVFJZVBnOWdrVE9P?=
 =?utf-8?B?ZUlBQ01vTzdNQjkwS3Bpd21EVjUzQTJRR0Q5WXNHTFAvYitVR3FLQTJzaG9B?=
 =?utf-8?B?dVRNd2xGdWw3b240SVdzN093N2FycUV3Zzl1TStoZ2pTSGdRTTMzUzJ3eURQ?=
 =?utf-8?B?YlZteXJ1RlhwRWRXdnB1Qlh4UUtjd2hEeWZ6dWZWQ01yckN6ajBETUF3dW1Y?=
 =?utf-8?B?aHBBaGlVOHM1ZTJEYXhIcWNhODhTKzlDVDFCWjVXQXg2dFFsVVlpRzJ3Njcx?=
 =?utf-8?B?cUs1OUw0L1JQRFpXUlVMWTY4dVI0OTZyTUxYaWpMVFdPRXB1V1hWbVlGUjlv?=
 =?utf-8?B?dlRWbk4yQTQ1TW8zc0tLSWZ1enV6d2RxM3JrSmdUN0lSRm4vYzlvdXZSck1D?=
 =?utf-8?B?dm0wTGV6M3ZWNG9jWTNYa3RGMHlYRWZ4aE5QY2czajVzd3VqOThFa3FnK3Nj?=
 =?utf-8?B?SUw4UUtlMDVmZWZ6ZVV2dDcraTZaVGUrL3YyeXQzTFhldXN0WDNJU2gxTGxJ?=
 =?utf-8?B?bHRhbG9uU3VjWVVLdnRCTU83VUl4c2JnMmtvbDA1Y1hvSUZHalhJWERKVmNr?=
 =?utf-8?B?L1JuR1J4dktNTzZwcVRHYWE3OTBaV0Y2ZDZkV2thZVVrV0lGMUhzSXlkWFNZ?=
 =?utf-8?B?YmFRaC9DUEVoUUpWWDVIQ0FBQldhOWhkNjdJdmdzcXJpL2Noa0VWYTZrdFZj?=
 =?utf-8?B?ZUVxek9LVHBuQjhiSUtReVNEb1NvVSt6L2JtbHVwSUFDK3JRQ25qZjdBWFRS?=
 =?utf-8?B?SEdtOUlxTHR3Q2krZ0ZHeHN1ZGNqb0ZvZHpQODQ5WFdxYW5NN2thL2xra1M1?=
 =?utf-8?B?WURjbUt6Z0laZzFsSjE0NWo2QUUwSUM1MnNod0h2YXQ1K1RNMzlWZzJqbjBO?=
 =?utf-8?B?aVFEVTVWMmNVbXZuTG5yZHVmRjRwTmlld0hzSWFmTS9MaGdMZ25zNXpIREZm?=
 =?utf-8?B?WXYvOENuTURsdklIa0o5QjA4ZkZZWXBLN0RlVFNKNW5BeXlsZDNqbFRoZkZC?=
 =?utf-8?B?WEs1WmI1MEJxV0tiQ1BaNThCeHRZRWx1eHpIbHp1YzA0ek96ZGVtcVdYLytE?=
 =?utf-8?B?czMzOEh5Ykd4SkxpQkpURVJhZDdsamdiTUpKcEMvb1lWZEpxbFBwdEF2NHRi?=
 =?utf-8?B?QmY2MzNockZzWVdOT2tkck1oMDI3MjhiNFFjL3lqd0F4cGVrMFk1WUtHbHdL?=
 =?utf-8?B?dC83QUtWWXhBK2FqVnprT0MzTUliVXowVERKZGI3Uis3eVlHSnNwcEJyQ0RG?=
 =?utf-8?B?OXlDL1lORHhEcnFzdklBTEZUNDBxMmdpK0FUYU5LWnRTajE0YkxZR1IyUHMr?=
 =?utf-8?B?TG15Rm1XNXpIT0NrOGpISUkyNU1TQVNEcGVwYmphYjBZTE9mUnorNWE1RUhN?=
 =?utf-8?B?ZHdKTXJXN2hiS0FqMjljVmRHa1pvWjdmN0JUdEVOMFJMNGJRWC9LKzFoSVEx?=
 =?utf-8?B?Zll6Q3pDeE5NODliQTVXZUYyd1U1SEFkaDc3NXVnTVU3YlpGSkEzMjVqS1hY?=
 =?utf-8?B?OWMxTUFQMzl2UVBzbjVNVGNmNS9MSDZZeVY5OElTMDhoc2dPNXpVRXR4OGdy?=
 =?utf-8?B?WnRMNFkyemF6bnI0UzlFMWVhQTVyd0JjVUpCeGJ4Q2djMjF6WVZaWS9tSHlt?=
 =?utf-8?B?d3VzdFU3bFovQ1BuWjlROVBmN2hTZW9kcFplSGNha01YRGZRcFBHdVo1Mk95?=
 =?utf-8?B?Q2J1YlcvVlBVTHBoUXhEOURYaTQ3Ymh5MDBhSEZRTkUwL1JCNmFBOUNKNEVw?=
 =?utf-8?B?SDZRRXlwN1pZTnhSalV3WjBkc0ZneHRSUVRXZHRNejBncksyR1c1eXRmbUhJ?=
 =?utf-8?B?MTQvUVRPT0Zxc2NKMVZTTStHMTh1K2k4Rk13eWlVNXFPeDdHcTJwQ3ZMTUNO?=
 =?utf-8?B?VkJpRHhNcFNYUDR4VnV4d3ZFUSt4enZvOENjMU94K2lZeC9DYXNDaGplWUZk?=
 =?utf-8?B?SFhKSE5KM3ZISld6WXEwWmFxL0lWSUxHQWswb2dQWUJYY0VIbkxVVHFEdmwy?=
 =?utf-8?B?eWhKOWRBb2tqL3Q4UDhKMmN6VzI0QVBxbWxMMVFUUm92WC9VNnoyNzZSUFpi?=
 =?utf-8?B?S2hxbTh4VXNRc1ZFMS9vR0Uwc1NjUjFpVlNrVXNkUHh6MjY5ZkM2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a90e7ecd-6a1e-4831-c60b-08df1aefd530
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:29:08.6951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUbiSRso30hyDTbCt6Bwt/4TLgiVlulkB/5dPG7YSMVgWXsOjvv+eFcFmPEhaVBgMACZHQssp7NRTM+goIV8pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7405
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

On Fri Sep 25, 2026 at 8:56 AM BST, Alice Ryhl wrote:
> On Thu, Sep 24, 2026 at 7:22=E2=80=AFPM Deborah Brouwer
> <deborah.brouwer@collabora.com> wrote:
>>
>> Tyr creates the struct drm_panthor_gpu_info from the Panthor UAPI
>> bindings. It initializes this struct by querying the gpu and then writes
>> the struct into userspace memory faithfully byte-by-byte.
>>
>> Currently, the struct drm_panthor_gpu_info does not have any implicit
>> padding, but if implicit padding were added in the future Rust does not
>> guarantee that it would be initialized. Then when Tyr writes the struct
>> back to userspace it could expose uninitialized kernel memory.
>>
>> Tyr implements the unsafe trait AsBytes for GpuInfo whereby the develope=
r
>> guarantees that struct drm_panthor_gpu_info does not include implicit
>> padding, pointers, or interior mutability. This allows Tyr to safely cop=
y
>> the struct into userspace memory. However, relying on the unsafe trait
>> AsBytes is fragile because if the Panthor UAPI changes, the SAFETY
>> guarantees may no longer be accurate.
>>
>> Instead, use the derive macro `zerocopy_derive::most_traits` for struct
>> drm_panthor_gpu_info. This macro will attempt to implement the zerocopy
>> traits for struct drm_panthor_gpu_info. If the Panthor UAPI changes so
>> that the traits IntoBytes or Immutable can no longer be implemented, Tyr
>> will no longer compile.
>>
>> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
>
> So this looks good to me
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> but needs Miguel's ok since it modifies the Makefile. And I imagine he
> may ask the commit to be split into two.

FWIW I do think this should be two commits, one making Make changes and app=
ly to
both uapi and bindings, and the second adding the Tyr-specific parts.

Best,
Gary


