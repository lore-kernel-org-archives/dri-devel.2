Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD44CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2902D10EE23;
	Thu, 11 Jun 2026 10:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="CM1xYBqM";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022083.outbound.protection.outlook.com [52.101.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FE010EE23
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtRIX5+qNMCN9gakVpyC1PXq+WrTyU0XR65DMCvuJoJsMZNZkn0x38t/UFLfz+s7DaBS6rpN6usb6PJUYECxlDc8z7XKHAKSHJE831WlWRUum4+8/I6UgwXKmCctY1XlGpX28dizHTKoS16PhCI/ZTma3mdiBgpjZvKONBOclIZFez0IgMEILhj+db0GqGMqzWLytGkZU9XH5vCIrvqjs8nfB5a9tsGrlp+MFKarpKtVzk6KPVYn6vPdX8gCr5Xko7lNZh8AY+lNM91ML3p4Fk3BDaJUuZMB1+qu+8CKAC4tgGCzbCVLvSFFw+Zjs3VXJDLdE26erLfJOjlYn5v7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq3k/c9XDKTj0cHQt7IDDBS2NLvXvRkU9t2WNqI/wEA=;
 b=w8ZzUEEo8IsDnJe82lxZWXANvd0UyTUqjiDWJGuznnKvhbTWEzd21rJ6bBNW3gQCVJS+opzGu1ZRaIdnkDH6XJfr+BnS/hJzrL/uVhrDlMHn+0PmtTREdNnJ4Bp8uG79jBqEV2BGxEuf9mpLP8ZVKYGIOXxErCwOiyVbkZ3/Yj5DDbD0GBspdbsKQw+6lQgvAiho3A/3vMX+NmvNC0l5S7Axb/sxqvRvDNwOvtzxYUcHSyub2mVhek2U7Ik1xviwbVcHTOzxWBYXrvemhXLgikCa4D1iLc9ULauRZG/7A97TwI2i4rkX38kaGjurzkXU3cxVUPdAypMonChCFhv4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq3k/c9XDKTj0cHQt7IDDBS2NLvXvRkU9t2WNqI/wEA=;
 b=CM1xYBqM09G8cjYkVsC3uUDfilLXMRPlPy/qwhnYsQ+DJR5wUU0j2DwTp4GYLZ3gSwFVIlCGZaUCcKHkQev2vb8BfF3C0FnaqTaorzS1t7M4NXPZk+RAqXJpcjYMUg+R2S8qFdV4r2b3pi5pWLLypdqLuK/9wfGFnXSFv5KVXL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO0P265MB6503.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 10:33:55 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 10:33:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 11:33:54 +0100
Message-Id: <DJ65HZ2867HB.2ZK56NEAURVJO@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, <a.hindborg@kernel.org>,
 <acourbot@nvidia.com>, <airlied@gmail.com>, <aliceryhl@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun@kernel.org>, <dakr@kernel.org>,
 <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <driver-core@lists.linux.dev>, <fujita.tomonori@gmail.com>,
 <linux-kernel@vger.kernel.org>, <longman@redhat.com>, <lossin@kernel.org>,
 <mark.rutland@arm.com>, <mingo@redhat.com>, <netdev@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <peterz@infradead.org>,
 <rust-for-linux@vger.kernel.org>, <simona@ffwll.ch>, <tamird@kernel.org>,
 <tmgross@umich.edu>, <will@kernel.org>, <yury.norov@gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
 <20260610072947.338278-1-ojeda@kernel.org>
 <DJ5A6AM2FDGQ.19T1Y9N1T6JST@garyguo.net>
 <CANiq72khOCLC5kG5vWhDeXpHv6n7Yo9Nv=PewNS0D73AxUDB4Q@mail.gmail.com>
In-Reply-To: <CANiq72khOCLC5kG5vWhDeXpHv6n7Yo9Nv=PewNS0D73AxUDB4Q@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::8) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO0P265MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: b4af645a-0fbc-4ae8-7230-08dec7a4f004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: e9cvsxNdrA6KhkN/jrRXMW6AyI2nq3B5ZKGetc1hRu2a9zlqxU7uuClzVBXuswr9uoc9FQu4ZM8PVbhVo3C1PMTThbVsRj4jbVLeFZNoet8xfdzFqUJOtzRZFNjgB/k+RjDRLiavzRH9W5dMk3zJE+7TDSF+N7FtoMd8AXBoRZz4MNDBzg47oiuk8L8nJGS8AXoX/RarvPDWWi8uKHAdt7iYHKY2hfzIB+WVQyCl64iBhs64sOM73M/4yRTezKzUYS1deXDo5f0RPgpm2dJM7me5tc0Fhk8QBkwI3a0bhXIVmHJFCu3lDBdqNcTANIrXlyybwDzWwIn4H88QA0yks9ZXD7wW3AhGannS0YW/6AL7XfuNF3WZHAsW43LKGJaBvb9QBmrWmZM9njlG7DPuh/PQ3jOaTuH2Yf6uSZys9jle1uAuiRciHhBQji7DhMc1WYVHb/jAkOJCHAA+JV9eeZH8PQVP+3jT1gCuiyteBpALZ6se8lKYRKjdkPu3pQW31UouC2dG0ALqOAFYYDq5Uee6jI6fkeYBh2SL+giI0PxqEkPKxj07zTiwU2cXTY3a7QvZ+cNmtpmdcWmzwmnJlIZmRNIdJDP8+sdkXSpAs0LEQimSYYOsqYVQmh7GkCtCQ775Xl0YJx5lnsGZw01JQrnhpiSOcZvUHd13zUy8JCb97iubNyGM68sJ0lZT8Oep
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWw5bm9xbU1xZjhUbWpjRHlsZ2t1WG8yNzNURmJjcnMyaUJnT2VFdjZhaGFV?=
 =?utf-8?B?N2NsTFk0cXBGbFRyZVQxa0c1dTRQbXI2Z3JjVzA3Z25WbkFhV0hwaWwyWW84?=
 =?utf-8?B?am55OVQ2Z0owU3ExaDlMWEc0UmNOWWdCeGxnN3VqQ3V2YnlHaFkvdVdMRWJt?=
 =?utf-8?B?TkNHRGNjaVlnRTFTeUVhd2RWVjF2ZEZJeEVrMVNNS1V2aVRWZWFGMFFTWGJx?=
 =?utf-8?B?d0ZXRXI0Slp2ekxHSlliTW1XdDRJTkRKS09VTk9EWTFIV0tOSmlPYlIxTDNk?=
 =?utf-8?B?YnUxUlpZeDhBdk9nVTJvZFFWVmxHRjRJRnNhN1V4Z0FBUFJsbVFJSWhyYmhP?=
 =?utf-8?B?OUh6ZTFSV2FMOHFxN09kN3I5TVdwazFHblJPYzF2TzVlRzdmYWlMYkFlUEFZ?=
 =?utf-8?B?WmQxYjlvSVk2ckRSOE5aV2FxRjF2S2JxNUtadXREajdDMzBkVTNMdk5Jc1or?=
 =?utf-8?B?cHc3RXphL21Ta01mYldDSnl1emIzV2E2TVU4Qm5hZUJEcVluakxNc3YyWEEx?=
 =?utf-8?B?bnZEUVVqM1JyNnBpRGEwVm5WNFBMRkpmSThvT3pzZDNvZFExK0xXTVExOHcz?=
 =?utf-8?B?cWxiZFFPRFBFOUZKTFNSYVZONGRlODQweXlSV2xuRDk1QkFyaThXeW42K01t?=
 =?utf-8?B?UWNNT1EreFAzNWFTU284bUV5UTRGSzI2a0FQc0p0N2xaUEpPaFIzYmQxM2dF?=
 =?utf-8?B?SzZvN1N0WWh5QUIrWEgrV2ZTMnlKTEw5UlZkK1BSd3ROMGdRcFJFdXZOMjI3?=
 =?utf-8?B?dFBUaUJxMW9KRGNwVHV6UkEyRm9GM0R5VDNBNENUYmdQdGxpenJzaGtpT0hD?=
 =?utf-8?B?TWNiTXdneHB2ajZ1L0ppemFTQWVCTVlmemk2ZDE3QVJwVjZ5aTNLN0gvVlBP?=
 =?utf-8?B?U0lRakxrWkRJNmxaWUtUQ2J0eCt1VXE3cEE5OGZoNDRQV1kzYkI3R3c0ZFp5?=
 =?utf-8?B?aTlEWWxHd0J1ZkpCTjA4SGowV3UwU3dwK2tlVWdROGVuUTVOVEFnUEk5b3Ji?=
 =?utf-8?B?THVGZzM4UjNsc3BjTkU0cVU3V1YwSWptanh1QzF1UmFkMEFOMm9veUVHNkdM?=
 =?utf-8?B?dkpBK1U2Sk9DSFhYN3NpTXAyZmlmYk1QZ283OTBBZ0M1SnJVbzBBWmExRFY3?=
 =?utf-8?B?MzQxWGJkbStYRmNtMjVUT1lxaVI3OGhNT0djdGpsbmpGSDNGTHgyaFdZb2pl?=
 =?utf-8?B?NTNEWFhkak93Tm82WnJ5cmltZmhKM0UzMWFaaGlHdmVSYWxXQ2xDZFpobmZi?=
 =?utf-8?B?M05SRXRTNU4zY2ZiR3djWnU0MDRMalhPelNoUHdaMlJSTEdWMjVyUVFvamdr?=
 =?utf-8?B?Q0g5c3ZYOXJUcE1vY2gwZktteGg4THY4cG5EcW52VjZiYmxqWS8vS1RMM1JS?=
 =?utf-8?B?NDhuZGVMVnVKVnI0LzFGc3RJTndYbjlMUUR6QTBOdTJBNXR1UHVTTDZtZGh5?=
 =?utf-8?B?WGl0U2VMeVliVGZrWS9uNkwzaTB5K1pQcDJ6WUg0MC9lOFQ5MUtaa2Z3YWhM?=
 =?utf-8?B?YVQrc09RelFDYnRHU25jZUNKREdZTGQrd1R2VTIrb25BdWhEMlg0V1hCeTFa?=
 =?utf-8?B?aWNPS3plY0krWnRjT01kL1EwTHpkRDdiRFJIdkM4RjEzNlVTbTRXaW96V0xJ?=
 =?utf-8?B?TFBsZUVMRVpHKzY4QTVKWnMyM1FpREdYSlhTS2wveHdKbnk3djlaWmZpQzVy?=
 =?utf-8?B?QmdhM3BiODhCYVhseHQ2TWdiZGs4L1dTaWV1Y01WZG5pMWlaanc3Y0svMVEy?=
 =?utf-8?B?VHQzYzRsdDg4aVhIQXpSaDNLZlQ3U1BTcXluUE5kR1VrajdSZ0VoODdFNlRO?=
 =?utf-8?B?YnArN2RFT1Z4a0FIcXFhTDEzUzAza05NUmZQSDkwZUZzandEb29kcjAzZXMw?=
 =?utf-8?B?T09rYW0ySkl6dFJLeHRLbGlONVVVckhnWmdxV3E5RHpjK3lIek9WNUFPWEhJ?=
 =?utf-8?B?MzR5VzRJc0RrdFhweHV2SXVMSXNiMmR2TWRwTGNvc2dMTzVJS1dOVTA2cmUx?=
 =?utf-8?B?YU54ejdyNnFhY1V1YURFaTRjN3JLL0JEbnB2TDhCTmViZ2E5SmpVZXlBUHlL?=
 =?utf-8?B?b0ZLbWpJdGxla2lVQkIzckJuZTBzK2srUVFhVlpDQ0lzKzJUUUlDWmhsb2xM?=
 =?utf-8?B?Wmo3SktuOUpKcUtLUkFwVGE1MW1ZdWl0NitZMk51ZVRUQzB4eTJSRmVLazlp?=
 =?utf-8?B?K2wxekZkYzdrQzBPRVd0MFZlVVYzdmtIaDNWdzhmZWg5VU5UK09ZY1V0QmdX?=
 =?utf-8?B?anl2WnVwOThpMTFyWGhFZld0VlBTbktWbTZ2MmM0Wjg2eVpPTnFvTXN3N3pt?=
 =?utf-8?B?NkNqL1RrV0ZPeCtNVlQ4UGQwTUgyN1YzazdsMDRYZDQ1THQ1UVZiZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b4af645a-0fbc-4ae8-7230-08dec7a4f004
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:33:55.0165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS34uYmEkIg7IHgEQqXwyUCmDjoYuj1SNtkoHYeTGzLRv32nMjXkOn6FZV+lstmD/YMxMTPlsePgm6i6NGpa+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6503
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

On Thu Jun 11, 2026 at 9:51 AM BST, Miguel Ojeda wrote:
> On Wed, Jun 10, 2026 at 2:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> I think if the re-export is of form "use crate::build_assert::*" then it=
 will
>> still be the same semantics but would be appearing now?
>
> If you mean a glob import (within or outside the existing `use` --
> same behavior), then that makes the glob import appear in the list at
> least, which is an improvement because at least people have a link to
> the module (i.e. but not the individual ones).

Yes, I meant this. All items of `build_assert!` are in the prelude so this =
is no
change of behaviour anyway.

>
> Or do you mean something else?
>
> Good first issue?

Agreed.

Best,
Gary
