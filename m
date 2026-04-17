Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9105F8E499
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E9F10E276;
	Fri, 17 Apr 2026 03:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bc0Lo8L4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1672710E276
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufGaTKd+KoWDrPnpU6+Tz/LpwtVOd+b5Z97JmPyd8p9FawRoLecza5+Z4HNInbKg33h62rR8oXM3G11dTs4MW1E+NcKQYVIvPGJkknfggne71PCblkUKnh69nvGcKK1SNIC4+UaczkOC915g7jOeyvjzMT02KY5m5ZAT8VdIKia6sjri1V0knd4S3OtkZfpS2T1+DlOBl2nPqFcK8xe7+0C916C17d563lDB/f+aiQSD8e9NM1694GXq1ovD6nXGbZL8ZHWRjM68WAWIp452cYBB3wDR6rfvhJzWmY7DoSTaJbuWeNtAHrp1sYjd14ez/1EGSoOtYK8yNbguOoLhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW7NZJMnVgBx8JQUsjT/OqtGY/G45kduIw36bjIX6+4=;
 b=yi7V4bq8y74ybSID5rn8sJ5lW9HZQG8TjyTv+MbJqHeEWTwAVbDpoMeVUBGP4u6N8dEi6W0obu7Kiz2j7TjN76NvqZFc096dlAl6qHuGg0eVIqMqt5tjOn14Ggmu3TjyxXBKBmVCeluhK+WnmpZwvLFMAXz8sW6JvboO0Qr88GbGifiCv5Q2D2UD8tp3Cp3jgwHsAf4XE7dIakA165DJ1D6bDAG5ck1dZ7f7LZT9wp1Jacq9gNtxLJbCKD7Zs+wfjrUJuey09+Q53DuXELX+tcStYdboOdwDfNYymR3c7PVsGe5AHjI4+2azS7mZXIVAnXTIHVJ4Zc3DXtlB7/IlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW7NZJMnVgBx8JQUsjT/OqtGY/G45kduIw36bjIX6+4=;
 b=bc0Lo8L49lOYwe3CBe++qgEN6jmrzifOG0bFDo6h1GPrHdw3eGcoXSmSUItyvVIYfMkkWR172rS4iDUBFG86swJ6xwc/0py2k4ZCyc1BYM7FauNeNdCTrhOJMOFzalh2XI5EMc7f62ezZS7jRogWdQSlRjgwuVwfyAntCOONRIIc3+Z8DWHioI3VbsPYUrPRtLv/UymkfVKgxQG5gSkkJV/T8lVg1BqKVDIil1RftOnlMzWA4ze3Nen5SIgCSmaYsskLfNt+02h1B9oZzoET9oNeRNmq9UgQQG7SBV9SfQLMBAgH4F9yQHSaRmOCkF2OkzdqSeTXcsfI9If1xpeL/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH1PR12MB9624.namprd12.prod.outlook.com (2603:10b6:610:2b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 03:11:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 03:11:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 12:11:15 +0900
Message-Id: <DHV3N3R9NJU3.2HXR63MP02NPO@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
 <DHV1K1097C27.33XRWLMZM6QZA@nvidia.com>
In-Reply-To: <DHV1K1097C27.33XRWLMZM6QZA@nvidia.com>
X-ClientProxiedBy: OS0PR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:604:27::30) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH1PR12MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 5733882f-e7ae-4825-4d83-08de9c2eff29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: OnQ4haJf31JUfBSGG/mcB2yrYnP9Y5Lj+nhbbv8tQEDYkTK7dYarhDA1zI2l7wkYQS9Sv6Kp7vi1VZM539MMOEpy1ttD2aQf9ue43etPzdUwuhOeMIWtV+IP1JRLy1+dP6aQI1vGU39LT2+bBRZXv3HPEEGFoEHELaRGENfVrKbSonSCodcHcRPL+gJsTgEuKcAcG5YYOlUyCo0xsTSMUq/TTAECLC7mBqEsVWM5aY4XAT0NxVj5TFwMIyA+yiHqDjmaTMW29BKAQOrN/MeCQpxsIU5QPHDKdoDHazI9R0FDnCaret+wzGwFvHHESeLgYX9FjFihpCCy6FGvFPkgdwbAvfHbUVZX45nguD8byDebFquhwfB23o0CZqQob5zZsg1eLQDo0GMK6vrD5XJeHt+Dv78X/Y9jLB5KaN+Kq9dBgtc2p4bNa/6hOl4qnNxUV3ouHoODarmA2LFCdnOhnxRskFJpzI6KjyAf+gdiE76AoJnECD4pKSx7ohxQKEGyIkS8FN/aM81Rwt/RW0rZZHrTpM6GF4lkYuRb6I7PKurHOtHfEE/MGNHjFHCcsAa5OZzutt6Bgyl+JseHYZ5/cKPY3Mxw2ZtJnVC7z0n/9xqeP2bRM4j3vizSp+eX0RUVP18lBSzHdCzu4QSZG6nL+XZjZdZoRp8/PaduDIvNEJWqn789U7NqL/kkBVe8HteEH/DAPKFi0+bTsVfrtD50rsHoExPhf7stixrqrtEw4Mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5ma1Zzb3RWRSthTzBUZ201WWJrS29qNFIxeUJxNU1DZVF6UGxhL21DY3VV?=
 =?utf-8?B?aWUrNTZESDhNYzVVNXhZdG52V3FkNWNIWDFyNnpRSk8rU25GRmpxQk1vdVYx?=
 =?utf-8?B?VUlJcnJEN3piTnk5Vld4c1l3MFJBWnNwVDg3bHF6eHFjOFRNbkRYNjVWUlNh?=
 =?utf-8?B?bXV2Z245NytLUEN6SkMvYVQwN2xnTXVQMWJ5UGUxdmUxYSs1dXArUk9BTHRo?=
 =?utf-8?B?VHpXSS9Nd2FFdVFrNlN0d2NKYU1xbjNYbk1OclFLTGdZeGlOSmYzS1ZXc2hH?=
 =?utf-8?B?NElpUHZOQTNBcThRbmRaQVE3T3RiSXZWSVlmOTNZTDFWa2ZJclVaZm9xVE5Q?=
 =?utf-8?B?SStFa3Z4NUIrTFVXVzdQV09JSjh5RkZ6NDFvS0V3MDN3ZkE4NExZbjZ2Z2lD?=
 =?utf-8?B?Tnp1aWdkUXJ4VXBUckM5Nnl4eFJaMXNST2tPYWhmcDZMUWJDV1lNRkp4aFVF?=
 =?utf-8?B?Y3Jqb0d5OGd2UEFFbWhKZEJsNXFUaXJNdDg3RkU1RWR2K2VIcTR1Zjk1cmNp?=
 =?utf-8?B?d1ZXOU5sZUJiT2o4RnhNMUlJTG52dkVkMTY4RTZ6Ym5nSVVSaXJrYmk5c0dq?=
 =?utf-8?B?L3lCbnQ4QlQwc2tqdEoxMVNHWGtFQTlMNXRpc1N2OE93VXorUWFVUmJtZEJM?=
 =?utf-8?B?TXlqYTZoTXMwazhkc3hRck4vZjMrN2diNXptVVlnbU9qc0ZGTklESVUrS2E1?=
 =?utf-8?B?Q3pGRlg4V2p1cDVmTWJxaXA0VmoydkhWcjg2b2J4cS9BTlVMWlhGWVdtZnlW?=
 =?utf-8?B?bmUzVWtqWU1vS1J6ZnlhN1FJaXgrRmpCZ1JrcjQ2NjdwSmoyN0RabGZFdmha?=
 =?utf-8?B?K2d0MnJ2Nkd6WXFNS1lZSXNweXpQUVk0Uys3RU9QdVRxZzBNTVVObDFiYmxK?=
 =?utf-8?B?bjZzSmluaVJPdHduR2JRRDdsSUNDWFc2UnhSTEFBYk9RTjNHYXdiaHdiNURx?=
 =?utf-8?B?ZjYxWDZFNEtqNnB3TVZRZk4vS2duN1QyNTN6blhzckxMVGUwZlZxOFp5VzBa?=
 =?utf-8?B?TFBLaHhvRGErUWp5a0xiek9ibThrYVZFZXhPMFNHN0Z1bGZ5QyszbFFOdVNI?=
 =?utf-8?B?M0lxQlJwSmRlNENIM2J0S0tCYmNCZEJKL1NuK3BGOUl5ajRTYlJxVlVJOFg3?=
 =?utf-8?B?Tnl2Q21nMWdtVEJPRnpyY0EvUE9jSnZZSHNZNnkzUExDNEUzZGJVL05jNmF4?=
 =?utf-8?B?REdKRDcxc2dUMWpMb0pSV05zUjZPZkxlRkZSUDN0SFRBQWZDZUpNM2xyd1Rt?=
 =?utf-8?B?ejF6cnFrTlJaZ08zL3A2OG0vMHY0R3kwOW9PenlIcUxMc2dsVFcyTnNqbmdj?=
 =?utf-8?B?YncrZlVEaW9qeWNZNUVqdGYzZmZwTjAvamcxM1Z6M2NSNUJkbWZXREhUanRu?=
 =?utf-8?B?WDFYK1dUYzNBWTNJMWw2TFY3a2ZmNDBza21pa2IvVU9xWlk2aWNqZ2xkWXFz?=
 =?utf-8?B?dlcrMW56MVhkR2huMnhZYWdDREpuMFFKbDBZZnBlUTNIcSszRWpsZlJJaGhY?=
 =?utf-8?B?Nks0b3VtTFpobDhEWFdvRnNLdEloUnVRN1R2MVgzUk5YbURId0tOeVI1TjJV?=
 =?utf-8?B?RFBxVjNkZWQremNlNXFoSTZMRkY3bklJM0M2TzVwc0Jvd1NVV0w5NXJFalF0?=
 =?utf-8?B?THJJcEdLUjlhVU5jZFlSc3pET292a1FvQitWZGpWOUQxeXcxSVNVM2lGbXEx?=
 =?utf-8?B?d0lZcy9TSmtrdkFVQ1VDVUZGYkRlc0pKbng1aHZ4WE9iT05vVTZVazhSSG9L?=
 =?utf-8?B?SjlwMnpDRFZBbzFtaVhSWFdxZXVLRnZvM1MyMlpwQkErTjdvZlhZTnlTa1U0?=
 =?utf-8?B?NzhlOGpFY3JxK0RPUkRlekdMYllZQVNBZkFRNTNoam5acml1U2VzK3hjU3px?=
 =?utf-8?B?ckJSemprSC9vSEhCOUdpa3A4QjBtMHZKSXNZRnM5NFJxTGh3U0tYNmdBSjAy?=
 =?utf-8?B?aGNVai9VS2R4WjFrS0JDS0daZkVXbDJNUjFvdXVTa29VMStXeVhaOHgvKzBW?=
 =?utf-8?B?bDRLQUVvU2oxNFFtdU9mL1F3Skhsd1I5NTlBYjYrUzRPK1lKNnhyZmtZNGZR?=
 =?utf-8?B?MmtzeEN5NXJncTNMYm53R3NrSE1UQlc3a2dBcS85WGlEeDVHVlVoUXo1Nm13?=
 =?utf-8?B?V1gwYW5kMVU5Y1JyV0NJYkZZbzdGbk9zWjgwTE9nNFBEemRGdmpMTzk3elVB?=
 =?utf-8?B?MHUva1VlSGFnVWxXcHhDT2FvN0ZlL0JUT3JVY3QwRW92S01RR3FieUVraytz?=
 =?utf-8?B?Z0lxWXlqbmtlbGQ1Yk1oelZyV1VOZHB3UG1DZW9JeHlqZW05Z2hhNEZjTzYx?=
 =?utf-8?B?ZzVVajd0b2FxbTZhWjRodG16Rnl1R2J6VVc5enVRMnJOS3dkYWpKQm44MVJF?=
 =?utf-8?Q?K6wopbc8/oZViQoiV/87udwJzNVDO6zKR0p1NrfIPSgCx?=
X-MS-Exchange-AntiSpam-MessageData-1: gLGR6kqZbwgHqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5733882f-e7ae-4825-4d83-08de9c2eff29
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 03:11:19.8255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUG8PQkjiOyG31UFNkfmdm7HSk2xidqFvibm+tBhVBGs5686EJpn0Coa+OKRO6fnFytE8zXLQi+mMcRMVHX0Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9624
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

On Fri Apr 17, 2026 at 10:33 AM JST, Alexandre Courbot wrote:
> On Fri Apr 17, 2026 at 7:18 AM JST, Danilo Krummrich wrote:
>> On Thu Apr 16, 2026 at 1:22 AM CEST, John Hubbard wrote:
>>> Can we please put this into your drm-rust-next-staging ASAP? I don't
>>> think we have any comments that would really need to hold that up.
>>
>> I would like to see the first patch being split up and we also need to a=
gree the
>> merge strategy for this series and obtain the corresponding ACKs first.
>>
>> That said, I'm not a huge fan of the drm-rust-next-staging thing. It sta=
rted out
>> as part of Alex' (private) process of staging patches he's about to pick=
 up
>> (which is fine of course).
>
> Yeah, if we added this patch it would then become a mix of "things to
> push when drm-rust-next" reopens, and "things NVIDIA depends on but are
> not ready yet". For the record I was a bit slow to reply but would have
> suggested carrying this patch outside of `drm-rust-next-staging` to not
> mix things up.
>
>>
>> But now it seems to develop into some semi-official "shadow infrastructu=
re" for
>> when the drm-rust tree is closed after -rc6 and during the merge window,=
 and
>> it's not part of the official drm-rust workflow and other maintainers do=
n't have
>> oversight of it.
>>
>> So, in order to not motivate workarounds, starting from the next cycle, =
the
>> drm-rust-next branch will be open for new features at all times.
>>
>> Consequently, all patches applied to drm-rust-next after -rc6 do not tar=
get the
>> upcoming merge window, but the next one.
>
> If that doesn't add any burden to you and Alice, then I think that's a
> definitely an improvement to our process.

Actually thinking more about this, this might not be the improvement I
expected at first.

Take for instance the current time of the merge window: both `rust-next`
and `drm-rust-next` have been merged into `master`, which provides us an
ideal base for sending patches that will target `-rc1`.

But if we keep submitting to the pre-merge `drm-rust-next`, then we are
in a situation where the extra patches sent to `drm-rust-next` need to
be rebased when `-rc1` is released, with a clear potential for
conflicts.

So at the end of the day, it would still be cleaner to use `master` in
prevision of the `-rc1` tagging and we would be in more or less the same
situation as today. `drm-rust-next-staging` is currently based on
`master`.

I guess the problem is that my internal process has leaked a bit, when
it is really intended to be a temporary convenience (both for me and for
NVIDIA contributors) and something drm-rust maintainers can completely
ignore.
