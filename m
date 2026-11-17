Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50A2606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=e1rc8NgC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3387810F439;
	Tue, 17 Nov 2026 16:26:32 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022115.outbound.protection.outlook.com [52.101.96.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62A310F626
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQBdqCi8qA57TQY+OUvBwfR8W29oEqvALuUl9bUodt6BZ8tn++i5FqI5Y5P9XHoddEjCOQyiHrHl59Bdnr5imw8aIK22oUwKeqWmh+29I9xFHaHmwmZWMf441UkKIxcHiviIuoycKrptHeSxPWg+ZM/r6gb+jwFWTmo+xKLS+egL4EvHfADFCW7EXqseBkGh4qbDt+0LLBDya4UEHGkqa0eLGEKXkXmeLcQ6fxWnzdwaj2xEOfIYTMixNtXvuaw3lfFfeUfbeGu3Z7osxym110KPe6dtKTpBr/WSkP/dkucF7uyH5hSWWaAh2mJAf1Fy9KHeRdGyyCqoY4zXbK+2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=He+RfVvtuPkPAmzokhQfTgSCsVYhrP6LK9Eft+B2spU=;
 b=n4cQQs247BixQVUbM6/mkDsCb8xFvCL5mNtgpYrVGOWvcgqDHRYhg3aCmfjqikNaC26lCeJNS75d5NpQXRGUGNwrquq1t8JRA/PE5Ngv+TjcRW2A4FueqOK94fU2zHH8VOJcwP6DhfLIHTjKNRyH6Gll7WpxOrqf/qFFGOqS6//8/ty1IpR41gSRWAhfYZWIxSyp/MdJxdjh7njwNuaky6//R76MRSChM5LpkgyHdXDL8218e3Phlj7FEj+OgmPL/1x0AYKtqBP65keklYRh4wD2GRJaP/D3TEFzRVYJeorsxrpi5qCZykb9Scs8QXojqRDyyjiWDsbpthUEzSGwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=He+RfVvtuPkPAmzokhQfTgSCsVYhrP6LK9Eft+B2spU=;
 b=e1rc8NgCB74pA6Ui85gqJ1931VemqqqpyzFERWwu80fsJvmlKpqM1MjX6WhOpzHLCDrvC45Ma3hv0i4QFSO7ieRY8+prNpcpbHPxtYEgQBp65pwAYz+FCC9wR3JzsaQeNmUnIAm+zLaRAWPjIMUt0ltEb77S2p7VQpNp/XnAodg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LOAP265MB9014.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:499::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:26:21 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 16:26:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 16:26:20 +0000
Message-Id: <DMXMKFY5NA4J.1SPC0XEZZUR0O@garyguo.net>
Cc: <phasta@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Danilo
 Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
 <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
 <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
 <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
 <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
In-Reply-To: <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
X-ClientProxiedBy: LO4P123CA0595.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::12) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LOAP265MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f6cbf8-3723-4fa1-e8e6-08df44c783f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022115727099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: +xS/RiSp6DgwPtYXqIdTdD7vJs2nZM+R30xCz8z6n61U3xlwKWe7q2h7Klr1jdhcVsgmd7WzYJjwhTxJ8kZ4S8ithzYni2izFNASZmuV34oQEpY4o24hec/GtaaXfexjn0vHxhugqYhE0LHPz7DYfZs0gKCQKZ+R/Mvz3955oyxw/1F5x7qQdYz66qv8cvRkh2WrHo/bHMpDU+oWJ/HgRIy78sPQjRaSz0nOqzPrPYELmdWUoEJHzUdHg1Os6zbyKgKFBTtyzaWpPtAxPGFsF30yu6fTdLBwhSbJhQyiyM6FVx7TiAblciC/IuCsqFKv9M0YPCuoZZU9Fsf+y3XtsfDUXzenJ8F9ujkRXvz0RnHMVlQ0MbJQCZJ+0j5BcUm7bjk4Pl7kuzCfp8Af4i4aF418hlPu52Fezf1tll2ZQ3i6T8MT8Tw6W3o21r5TIqxVVs/dz6LrNsPUtoP9/19o5mDat+Pm1atZ0pN8kmugaB00g9Ae12M4nEXeVBcDUYG8S8Fd4lOBN45/KTrhJAwXET3I8zrqC6g78iMMR6rjc/jkHXnxOkCdv0DLleTtiZ3LGNG9G+OQYa+ghvgg7+zgSFWRP4vRua4nn5bIbOC4MJfx369ejTz909A8tbDMGJq7Ifcdwp75MeBcAUvDbG8h5SBVe7ziJLPpjdA8C84obRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022115727099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWtBcnBGTjQyOTBOdXZXbU9PNkpQdmRXdzRCNTAwWDZyY3ZFQ2toT3hRdlJ3?=
 =?utf-8?B?ZUZKK3l5N1dZd2lFQkVsWjRnbkRtTXpCSGFTRFBXa3dINlJmSXk0MkVtdCtw?=
 =?utf-8?B?L09uc21zNmRKYmVhenpLSHFPM1I4QnRHZ3Rva2JRWTByb3lyVEJTaUZKU2FX?=
 =?utf-8?B?VkNhZEZrRWZ1WHg5R01BVEhxR2JLYVY0NnROUS9VWm9OeGpYZ2g3M2F5Sklx?=
 =?utf-8?B?L2hZTWtiZHRKbFlYZE1uYTF5L0ZKYWxabXhnOXBhOEEwNUVFaDcyaHA3ZnRY?=
 =?utf-8?B?K2QyV0R6K3R0RFJFcmVJNktpTEhiS2RlQlRpa0lqOUNjMWduZ25jcHZWRlpp?=
 =?utf-8?B?VnhQMUpTc3NneXZKWUlJZE12SmkraEQvVUxMenYyN1BCUDVFcnlsQUZCRjli?=
 =?utf-8?B?bFdZMURMdGFPbml3ZTZGOWFubVc0Wk8rN292K2JocWo3WTRJYW5zdVQ4eGFi?=
 =?utf-8?B?aG16SWw1Uytuc25PWVYrZ1VOMVE3NDAxdlg3bTlvbVlycTFZOEwvKzFNMjlM?=
 =?utf-8?B?OEl5NVpURTlyTXg5WDZRTEVaZlh0ZDI3NmIzbVUyNFd1T0tXTnYyQjVnc1VP?=
 =?utf-8?B?MkQ1SUwrdDBhN01Gd1Y5Z252NEtTZUN4cGJWb0FHZ3J4ZEZ0bCtQcDErZG9U?=
 =?utf-8?B?a1V3MmxBb201b0ZVNTY5Q1piUWFLT3E2RWpobWJJSTVhT3I3VUZUNUhCTmFW?=
 =?utf-8?B?ekFudnluTmVyRUF4WW5LTzIzY0dnOWlMN1NzK1o3V2xZcHJ1NnYxR1pJdVUy?=
 =?utf-8?B?QWRmdmh2YlIrNlUzMHJIMUJYVHhtNVZuUUIwUjN2SUJaanR6MGx2WFZWVm4w?=
 =?utf-8?B?Z1Q4UEsya1NlQUNWNXlMc2tUUFRkdlcvR0ZGQlJxVkJ0MVdyeGI3LzVHNHZ5?=
 =?utf-8?B?VlQ0allzbGlSN3pEbUg1eUYyMUd0TFFVcVpaK2p2QWpXQk5WSUlQNEtIRlBt?=
 =?utf-8?B?c2xrektZbWZxMEZSbFNqOVFURGphWS9VaXNYT3dIMXRoNlhLQ3dWRmp1SStv?=
 =?utf-8?B?c24xVlVCdGlJNjJxYkNhSkh5a0I0d1dsWWxySGVRU3U1V3ljcm9pS094VEV6?=
 =?utf-8?B?ZVBUMm8ycGFFT29lOTQrV0pxNHkwcnpscHJBTU1xRmZlaTZwMHI5czc5ak9C?=
 =?utf-8?B?WmkzN2JYckNuak5VYnNYOCt0a2RIYzNlRS9QcnloVU5GQWNjbEFmclV6Zy9t?=
 =?utf-8?B?cWlSZmlnd01GenpCeDRzRHBPV3JlVzBrY2hRck1hNjU5U25qQnhvWE5teU1I?=
 =?utf-8?B?SzljaDNJOUhQK1RMMHJwZk81b1ViUWVwOVY1M3o2L1FRUmhzbFY0RWhLaHo0?=
 =?utf-8?B?ZDNaNFlxcE0wbFphR2tjSnZvQXBvckMrY0xIb2M2WkdZZmtoS2tjNmNQZEx0?=
 =?utf-8?B?Q1djemJZbnRJMlVCb1FvNTNabG4wM2Z5akF4dEVTNWprSVJvcFlYK2FVbkx6?=
 =?utf-8?B?ZE8rVlFtTzJVVm9abGk0UE1HVFJpRDNIc3lnODNTU3BhODcyMk1MdWlvNDFG?=
 =?utf-8?B?dSt3TVJvbGFOVWhLYWZ4L3R5dERvZ3hQeVZKL0Via0RrSXJWeHF5TENES2lu?=
 =?utf-8?B?azRpeUFpU1NrbVVOV3hmL0NENkt4bWtRNE5KVE9CMEc1N0RXL1FrM1EyZS8y?=
 =?utf-8?B?bXRFYW9NOUhCcFBsaDB6YkltOXFyV2sxSFlxem5BMlVMSy95TFlEWkNmM1R6?=
 =?utf-8?B?eitEcHNNaGx4SUNZcEpuVmhKYnU3RExaZjN3aWljRDBjSlRuWVExVHg1Tmhr?=
 =?utf-8?B?emhMVEZ3dmJqUWJ3TmZ3cEFLYVVBY2hhb2JuR2ZxNUVSU290ck0rSHJVdmdm?=
 =?utf-8?B?dlJqbXRtQU1VZXcrNkdkQ0RDMzNzKzFDczJyckJEZi9kRmZ6R0ZvV053citI?=
 =?utf-8?B?a3NoaENxcDE3UVRNdURNRkN2bDdyeXk5cGVZczV1djREU0JLQmttUmI5RTZZ?=
 =?utf-8?B?L3lGaU8reHlySHRjdTZIc0JlejRka2FtVGNpZjREVm9PZU1SLysrZzlzUUZx?=
 =?utf-8?B?ZEE2UjBGNlFkK3F2ZkUrQ09QWFJ5RDBoV3I3anVpUENnYlVyR3Zya1JjNExj?=
 =?utf-8?B?WTNLcGNFdUZaM3dYejBybkZSd0Nwb1YwL2I0NGlWbzdrK09CaXdUSTBzV3o3?=
 =?utf-8?B?emhtTlFnKzRZdmVoSG1xdlhvUlZoaHJ5SkVhSFdvN2VjOGRGLzZ5eVJxMHRw?=
 =?utf-8?B?TlYyaUc5aVNGZXF6V3o3VnM2Vi9Ia0RoREhNRTJja0VFU25IQmdRenpIcjZp?=
 =?utf-8?B?R2t6RDhRV1ZGOW9PQ0daRHZ1ME02bm9wcUxqV1ZoVm9ITU1MdXF6RFlJd1Rt?=
 =?utf-8?Q?3YrahLYLYxEM10Udpv?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f6cbf8-3723-4fa1-e8e6-08df44c783f9
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:26:21.5236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6oRp+eDpM74IElgAwi60XnU+m9skngN6juuZWNdJcgRD1u4HYZuV+S/ACTMQapfqSLdAf53XKHdyzo9cr98Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9014
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 17, 2026 at 2:50 PM GMT, Christian K=C3=B6nig wrote:
> On 11/17/26 14:50, Danilo Krummrich wrote:
>> On Tue Nov 17, 2026 at 2:40 PM CET, Christian K=C3=B6nig wrote:
>>> On 11/17/26 11:54, Philipp Stanner wrote:
>>>> On Tue, 2026-11-17 at 10:51 +0100, Christian K=C3=B6nig wrote:
>>>>> On 11/17/26 09:24, Philipp Stanner wrote:
>>>>>> struct DriverFoo {
>>>>>> 	f: DriverFence<()>,
>>>>>> }
>>>>>>
>>>>>> impl Drop for Driver Foo {
>>>>>> 	pub fn drop(&mut self) {
>>>>>> 		// Signals fence implicitly & automatically.
>>>>>> 		self.f.signal(ECANCELED);
>>>>>> 	}
>>>>>> }
>>>>>
>>>>> Yeah, exactly that is still a bad idea :) See the HW eventually
>>>>> doesn't necessarily stop doing DMA if you unload the driver.
>>>>
>>>> I know.
>>>>
>>>>> So just signaling all fences with ECANCELED is not enough.
>>>>
>>>>
>>>> Yes. What I was trying to tell you as that you have no way to enforce
>>>> this in Rust or C.
>>>>
>>>> dma_fence_signal(f);
>>>> free_driver_resources();
>>>> // Driver forgets to stop the hardware. Memory corruption occurs.
>>>>
>>>> You see? Neither your BUG_ON() or WARN_ON() saves you if the driver
>>>> does it like that, no matter the programming language. You cannot
>>>> prevent it.
>>>>
>>>> The only one who understands how the hardware works is the driver. The
>>>> only one who can stop it is the driver.
>>>>
>>>> In Rust, the place where a driver drops its JobQueue is the same place
>>>> where it has to halt its GPU ring correctly. Enforcing this cannot be
>>>> done by dma_fence code.
>>>
>>> I completely agree that we can't fix things from the dma_fence code, bu=
t it is our obligation to tell the user that something very very bad happen=
ed.
>>=20
>> That's the point, we can't infer that "something very bad happened" from
>> dma::DriverFence being dropped unsignaled.
>>=20
>> In Rust we use the RAII pattern, and drivers structurally embed a
>> dma::DriverFence within the struct that represents the corresponding har=
dware /
>> firmware queue (e.g. through Jobqueue).
>>=20
>> Consequently, if dma::DriverFence drops unsignaled it means that the des=
tructor
>> of the structure that embeds it (which does the required HW teardown) di=
d run
>> already.
>
> Oh WOW! The signaling state of the fence should *NEVER* be bound to some =
object lifetime.
>
> That sounds like an extremely bad practice to me. Just imagine anybody
> grabbing an extra reference to the HW state object to inspect it for debu=
gging
> and the fence not signaling because of this.

We do not allow "grab a reference" to prevent HW state from going away in R=
ust.
All device resources are tied to the lifetime of bus device being bound. Wh=
en
device is unbound (device going away, sysfs unbind, parent unbind, or whate=
ver),
device private data goes it with it and all device resources must cease to =
be
alive before then.

If driver's fence callbacks can access HW state, it must also be teared dow=
n at
at that point and cannot live past that.

Best,
Gary

>
> Signaling a DMA-buf should always be an explicit operation drivers do bec=
ause
> of some HW event and not something which happens as a side effect cleanup
> because your object runs out of scope.
>
> Regards,
> Christian.


