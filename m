Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6F3C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3B8410E0CF;
	Wed,  9 Sep 2026 04:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0JbQkIZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6772610E0CF;
 Wed,  9 Sep 2026 04:48:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zStoVfZaiqcZ0SUBwD0YuDaXauwOPjzuVf9HRBKVWIyfUL2chN8smHtjfNup0sOoEhoKBpyHXUrfB9Y55RJetO6QIzA0UZAsbNEPe7KY7ei/QVWu4jBKYoesTm1JnMxjCrX/Oc71onlC88ZHj9dcpfZ9R7ueQOoIPrdpAH9ZMsBL3vXn6ebWPwpm5nsY+kgrFplYIKtwOJ4LNBf0v/UbxS5DUAuNiO0e3BhjhFRtNOKf3NleIKB0BpmrK4aUA4kwKR2uHXIWR75cgg94LtvTVVYYwkI3Q+LPmeZMhOcrTace2qmVNLH+1SWf83omEnzDwndTCSScUp42QNYfkrL9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4pLmjB2LdTu6iRMarvGbGzNuMDTbRKhVIZu4BBeQWs=;
 b=Ox5sWMZS26rfjLVl6kCMxh6LP6gSmMXnJGwuqw+beE4QAWxpohv6PBft3AAFCsJujRDF8nyKUfUf/R+BAHdDyvOHKV2hYoceK7MxEQ9ErpoZ1v5rz3Eejzqah14+gL8dTJBbKPl0DtehnKRF6Z46wDHLoDkpIwcLD3naXYVJhBg12Dp0NeD3HitZ0e0JGAWXzDGn6OPIm6gmllygBd79TGQ+Sz756QCqckTbGXurgoiOD0QrcTiCMLsTxt8ghg4DFPprKsJJnQjabG/4BLg4E9TC2c8XPkzWEZUcMfyGFju15N4+Il6FzNpslPmwIDatee/gVC7NgblTFDs1lFOlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4pLmjB2LdTu6iRMarvGbGzNuMDTbRKhVIZu4BBeQWs=;
 b=p0JbQkIZXYCPRVc5vds1O9iJVUuSOF4MSdNIGb7jxnA+2ylQ5ofSN0sBSE9ps4pLCTXMldfGxqoXC7xTtZK6pF5arod2uT+KN/QQQ63eLCxJx3b/9/IRMYaACZYHthtxuk8s8tOSjVM5FERtqcklD1vDBFDcrnDcDfThqfFkb2M1dOnrNI5u6In9xwAIK5VJlyfbzhmpiXPm10N0qFRuq8wcQ/ZXIz1zCTZMxEECOiXWb2wpZKv0YGb2yJcuuFM294FF2V4hyCCm69wzqvkNdaK6+lX4VHHCffgHAjGNneKc9s4AlmsNj9EB/EF54/HHN3nhELXgb7OwbIBt1kvC3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 04:48:28 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:48:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 13:48:25 +0900
Message-Id: <DLAIIHELWF8H.3KAZJV8DOIJ6O@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 5/8] gpu: nova-core: add NVKV decoder
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
 <DLADH5QVXWSD.2FO9OVBIGYNQG@nvidia.com>
 <DLADY8BA86SI.125037GQGOEN7@nvidia.com>
In-Reply-To: <DLADY8BA86SI.125037GQGOEN7@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db309c7-6778-4c40-20e6-08df0e2d9701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|10070799003|6133799003|3023799007|10067099003|11063799006|4143699003|5023799004|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: W32EDNYSJY0Vhw6sTTD8iB9e7VYAZyDrceBf8gkmgsliTN/LcXKgO6QIrC5vdcdK0ffUoGTDdO+Dt8Y0zkEKemNHQBRFAGJSppuSUalr8SOZuJ5l4Lxqtq9siu/1SMMfhiy8VjF2nXnAQOs5vR7QsXmz+iJzyJT/h2uKnOHNWqtx9X9+ycyEoeb9RWO89GehRn2gFhF4uTIYPvPPKL0hOtUZCt+eCTtI+dWtByoqjsEK5uUK0+NzrqRxPOsJ5rG/A70OvZK4W0297NQp+CI9b4Pxh3MNG8AU9jKKrtlyx4PZyxanb6PRuDT+wJOnzijog+jo4cdyNOANdC1QSFyMqjSR7+3n2j7Y2eNArMAVAg9bp41QTwfSWa2+dLfn0Y7/WgcFcWAbYquxfibFK3CauoRRCpwyDbhGwo1CYzGlDPi5/7RIbjhqB9S2GEnosLQTqSHqdymQAS9ZSwQlsa+DTLqmb0BY94BbYhfDB3IF0wrVikzRfF/emnNfJg0tmZYODsgXrQa69wnhiy/+xLzXbQJ/EclufFnv8bbG9UUVdqnyfvprzFy4V70XocJrlJ29uuOVG0LhMK4QokuzmLMGfuSbjJxw2sKfqHHjThT9t3Grk3/rXE0RicI81r6dg3E+eHK/INYvYH9+WGz4+46ZCyNDILMtbRuJTPbuYRbvMhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(3023799007)(10067099003)(11063799006)(4143699003)(5023799004)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHVqOGZWcFRIaVgwZ2RNWmRrY1BtaHRnVEV2MGMrVk9PSXlvOWRETHo0cWZr?=
 =?utf-8?B?bFVPUjB6Zms2R2RXL09jYkxTZ2hPRXovV25UWXRxclZTOE41R0l3Z1FDZVBW?=
 =?utf-8?B?TGp0cnRoaFdHTSs3dGJwZjZkbmVzS3hRMTl4eGppWFcweEZJdGthNW9wc21a?=
 =?utf-8?B?LzZIV2s1NWpsdW1zM3NYSEIzY2RmMi9XRWJWYjF5WjB5K3RjNE5SNkQzS2E5?=
 =?utf-8?B?WTdRZG1SV3p4azIwcFpLKzJ6LzdUTExCSHJNNHVFeHFOVUNzNk5US1lxTUpW?=
 =?utf-8?B?MWZaSzJIaTlQV1ErUTRKTHBwaWNYYUhyU2NrZlB3anFxZ0dXRFJJRlJOQ1Vr?=
 =?utf-8?B?MEVYUU1wZDNFN05mNkZsTkp3YmRUaFBnZXdrT1FHMzc4S2NqdkFPR281YWJz?=
 =?utf-8?B?WUdoVjJRcDM5eUxNb0F1Tlp1dGZ2Q2xTQXpyelE2UFQ0QTJFZ1NMT0pmaVBW?=
 =?utf-8?B?Y2IyVVdwMy94V2x1MHFXUTk0MGxrL1pMZURYYXh4ODQ0N3RWZHQzR1A3UkNu?=
 =?utf-8?B?OHlBbkphRW9wdUJTUFZKUDNBWWtzdEpDMWt2c0xFWkhqRGVKbEM1anNxclA2?=
 =?utf-8?B?bHhBbjNkcUNCRzArNDJGUDlNSW1CUXhwUkluSlczbFRHaFdnUG42LzhiWm5i?=
 =?utf-8?B?MUcxK1YvaUdCSDUwalc3ei9UdC9lWjZQRCsvbUVvMDFaWlNoYURGOC9zckZI?=
 =?utf-8?B?Y1ljWXRIclpNKzVrOFVwVzNnZTRldFZuVU5ud3U3Tnp2anB4cWliTXljajlM?=
 =?utf-8?B?R01HcTFLM0I0TnlsMTNmT0c2bk9BdjFYM1dMNkFnbGFHZjBxZFFGbG9QMWdF?=
 =?utf-8?B?ckd2bXFGaiszZU5mdEZvSnQwc2xrbTM0TzdhOFZJcWczRDRsYnFSQ3BqdmhD?=
 =?utf-8?B?b1JjUVFJSEREWW9iQXdVUWp4UUYrSXN5M0N6bjdWT2xWckJuRm1aWldiM0N6?=
 =?utf-8?B?RUJJQ05xK3E3clpzZTVxckM3d1RqM1hLamlJNTNFRCs1NllFc0lOaklhL0dt?=
 =?utf-8?B?QWpzWHR5U0pSSHpSNFFOMWttZHM4VkxpdjIweDBOcGg5R1JVcWRwYTl6VEVp?=
 =?utf-8?B?SG9DQjZPb242WDVVSldESmxrcFppcjFRZEc3U2xWQ2FpMUFXT25SL0FnYmNW?=
 =?utf-8?B?SEQralo3OURacEVUa2xZaHFHY3dXVTVqenpYVGZWaHFlMmpjTHlqc0lTLzZI?=
 =?utf-8?B?VVg2N2NaemJnNnJxWmVUaThHYi9LbXFtTE53VWVLajkybE8rd0lHcFpHU0E5?=
 =?utf-8?B?ZVhFUm9YM2lnelFYZ05KWURqZTBEdkxEa2NuNHQxWVFPR2xJaVlrS3c5UXpx?=
 =?utf-8?B?TlRSS1VCLzBVZFdoTzNBRnpKUFo2M0tjM0FZdFZ3K2Zpc1d6RStCRmdCTXlI?=
 =?utf-8?B?OEVDSDN1MkNyVU1uTmcyb04xTUVnamhyb0pJT3pnMVphSENaOXlrRWI4cDJE?=
 =?utf-8?B?ZlNNVFI4eExaYVphRGlhb2hlcUsxQ2M5WVNsZzVTU0J3dE5yS3dCb0ZkbVJq?=
 =?utf-8?B?em01UHBjYVZ6UFBGQkxFMVBFeHBKaEFlWkt4V3dNOEJSanlSdS9uZ1o0VW4r?=
 =?utf-8?B?TjZ5WTQ2dzByajdXd2FhNFMyc1JDZ01VeGdyZ29reVh4cjRTVGNsNjlmQXNj?=
 =?utf-8?B?akZwMlR5eXhpTkxLRzZwTHFONlU2SkM1WUI0WHNtbjJxdmh3Q1VFTG1Da21z?=
 =?utf-8?B?cVdpelZ6ckk4QitXOEgyODRwL2doVUpUN3BTemp1Y1VKNVRiVC8zTGZLcDMw?=
 =?utf-8?B?aEx3NzR4N1A3eERQeHAyYllzVG5ubHBReTNqMDBFeXB1N0RabU1lOStOS0xW?=
 =?utf-8?B?SUllMXd5QzY1QXhKUFVHWmwxelI3a1Z1Z1BPOHZReEtJLytHN3d6S2ppTHNh?=
 =?utf-8?B?cFEvNTV1OTEzcTV4a3hSc28wMmNCVnZNYllXTDloeEErQnhnRkFLVzJEMTJE?=
 =?utf-8?B?ZHFETzFkRWJ5Z1ZLK1J5WVErR2dDTGl0NXkrTGk3dE5rSjBRMi9pNmlvd1Fk?=
 =?utf-8?B?eExMa25YVjMrYzBwQngzdHFBbCthQTdoVGFjb3Roa09qNloxWEpNcHNTbFk1?=
 =?utf-8?B?d3ZiMUg4YkFnWE51SUk1OHEycVR2N3lCam9IVmJaRFNiM0FQSCsxd0F5YitH?=
 =?utf-8?B?dldlT3dxZ2VQSG1CdkhHZ1ZPN3B5QnJjUytIUXl3SExxSyt4ZDIvN3gzMGc5?=
 =?utf-8?B?LzlRK2xYTjh4dkdlZlF5ZG02ZldXWmgvWG5NQnM4UlhGY29tTENERkwvRjhK?=
 =?utf-8?B?R1Q5SWZqNVF1MUw1WXZSN3B6ZGtpTFg4eFVFenRsZzVpT01zb1YzMVh6YWQ1?=
 =?utf-8?B?VEwrbzVWSnpEL2JZTTZDU1dVTUl1WXZjMHp5MmYrL2VUcDlWUmI5V3YxaFlQ?=
 =?utf-8?Q?3ahkas5cXLJ4R14re2ST+zvnmIbv+am8Y92r7tZrksvW+?=
X-MS-Exchange-AntiSpam-MessageData-1: hPm+OKejjT/CWA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db309c7-6778-4c40-20e6-08df0e2d9701
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:48:28.1904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1er8Ptg3FIiLWsinblG/EtDYM/DUc3KZV2bF0RZAXFjLmYiY3nX8W5xbAWSlgu6RXYmc2Pe2DX/145CSATGnsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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

On Wed Sep 9, 2026 at 10:13 AM JST, Eliot Courtney wrote:
> On Wed Sep 9, 2026 at 9:51 AM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>> Add a decoder for NVKV. This is for receiving messages from GSP for
>>> GMCAPI calls. The NVKV format essentially encodes a sequence of functio=
n
>>> calls f(key, index, value). This decoder reads an encoded stream and
>>> invokes a type implementing the new `Schema` visitor trait. The
>>> `Schema` trait can either consume the value or not, which is useful for
>>> composing Schemas. If a (key, index, value) is not consumed, error out
>>> depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok or
>>> not is per each GMCAPI call.
>>>
>>> Add kunit tests for the decoder.
>>>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/nvkv.rs        |   3 +
>>>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 265 +++++++++++++++++++++++=
++++++++
>>>  2 files changed, 268 insertions(+)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/=
gsp/nvkv.rs
>>> index a8e16687a134..cbeee7f376b6 100644
>>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>>> @@ -27,6 +27,9 @@
>>>  mod encode;
>>>  pub(crate) use encode::*;
>>> =20
>>> +mod decode;
>>> +pub(crate) use decode::*;
>>> +
>>>  /// The allocator backing [`EncodedStream`].
>>>  type StreamAllocator =3D KVmalloc;
>>> =20
>>> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nov=
a-core/gsp/nvkv/decode.rs
>>> new file mode 100644
>>> index 000000000000..ceb97e73e100
>>> --- /dev/null
>>> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
>>> @@ -0,0 +1,265 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFF=
ILIATES. All rights reserved.
>>> +
>>> +#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
>>> +
>>> +use kernel::prelude::*;
>>> +
>>> +use crate::gsp::nvkv::{
>>> +    Index,
>>> +    KeyId,
>>> +    Op,
>>> +    Opcode, //
>>> +};
>>> +use crate::num;
>>> +
>>> +/// A decoded NVKV value.
>>> +#[derive(Copy, Clone)]
>>> +pub(crate) enum DecoderValue<'a> {
>>> +    Scalar32(u32),
>>> +    Scalar64(u64),
>>> +    Array8(&'a [u8]),
>>> +    Array32(&'a [u32]),
>>> +    Array64(&'a [u64]),
>>> +}
>>> +
>>> +/// Implements `TryFrom` from the given `DecoderValue` variant to the =
given type.
>>> +///
>>> +/// `TryFrom` is used by the `Schema` implementations in this file to =
convert from the
>>> +/// `DecoderValue`s into the types to store. Provide the implementatio=
ns for basic types here.
>>> +macro_rules! impl_try_from_decoder_value {
>>> +    ($ty:ty, $variant:ident) =3D> {
>>> +        impl<'a> TryFrom<DecoderValue<'a>> for $ty {
>>> +            type Error =3D Error;
>>> +
>>> +            fn try_from(value: DecoderValue<'a>) -> Result<Self> {
>>> +                if let DecoderValue::$variant(v) =3D value {
>>> +                    Ok(v)
>>> +                } else {
>>> +                    Err(EINVAL)
>>> +                }
>>> +            }
>>> +        }
>>> +    };
>>> +}
>>> +
>>> +impl_try_from_decoder_value!(u32, Scalar32);
>>> +impl_try_from_decoder_value!(u64, Scalar64);
>>> +impl_try_from_decoder_value!(&'a [u8], Array8);
>>> +impl_try_from_decoder_value!(&'a [u32], Array32);
>>> +impl_try_from_decoder_value!(&'a [u64], Array64);
>>> +
>>> +/// A visitor that consumes decoded NVKV and produces a `Target`.
>>> +pub(crate) trait Schema {
>>> +    type Target;
>>> +
>>> +    /// Visits one decoded pair. Returns `Ok(true)` if the schema cons=
umed it.
>>> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderVa=
lue<'a>) -> Result<bool>;
>>> +
>>> +    /// Returns an initializer that makes the decoded `Target`.
>>> +    ///
>>> +    /// After the returned initializer runs, the schema should be empt=
y again.
>>> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
>>
>> Would it make sense to make `finish` consume `self`? Because "the schema
>> should be empty again" sounds like an implicit contract not everybody
>> will think about enforcing, which could be a source of subtle bugs.
>
> Yeah, it would make sense, and that's what v1 of this series did. But, I
> noticed that it forced materialisation of the Schema on the stack (and
> the Schema can be large), even if you allocate the Schema using a Box.
>
> There's two places where it materialises - in Decoder::decode and also
> in Accumulated.
>
> anyway, that's why I changed it to the valid-but-empty like convention.
> Please LMK if you think there's a better trade off solution to avoiding
> materialising this on the stack.

Indeed, I don't see a way around it. In this case can we make the
requirement stronger than "should be empty" in the doc? Because AFAIU
caller code depends on this behavior, although most of this is handled
by `nvkv_decode`, so we are working in a controlled environment here.
