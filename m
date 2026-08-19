Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F4C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:08:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A6710E561;
	Wed, 19 Aug 2026 12:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="FI7vWFNw";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021090.outbound.protection.outlook.com [52.101.100.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B9110E561
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pF82LnlbDQbL4K2UYAX4QeAdIAqcFIn/UwSHqRxL5TsBCp+tL3ohDB6sD/JC/yYGlhEr9T4VDDQ4ObniQH/kP13yWLTGwwkklxk0dyrcGQ6DV9qHf8g7ellDK3QNUdy/i7DdLUJYlDKeNNJeo1OH4oAJ+ryX1YGbQ2J1LrEuu6/XQyJMrv3FYj8YSsJpgh3hGE8NKq829cGochjQi9uJSp3n5BBbU+oWxyDsHTeBXtrzp/F6+WYomz56LB45Sg70NWsoLuGRQeRAzcFev8mz9eKnVuHBom0mLrbphM0HfUjifQAf07U8ZzONjURPvsTLZK0oE8BQzOFJETUoR9LlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6tSsOn9o7S5dOZcptD3ZUbsWJkyws62X3PjOy8lmLg=;
 b=TEWyAr5Cp6Gg0j7ksbQzN5yfLHRe5cGvVbQu63SXBcb19kzuzsrCJUuLoS9zgXDwJw3/FoWgcN8y5uH2ErKB9LrAySeFnXNOYJlrUGPjaVD6iqnn0wkz7DBtucXqLZvhVbiZN7HlqukJScZ4yChaNXw9FaIuxUPh+Lyx0caQfkaAnor8VbILazCZN0S1aJmQjLHb3m90bCx51By0s36QSD8aIuHnHqXjcyiR4+/iu8mkNBaUOiBC3NhmomeUGYHtNZWUptc9ijmZUT3xupH4CNUzrUEoCWkVbjNOHhnfpUWJYzkgsWOrYJeZ6LAQsQJJJDCNw/Ao1RhOozV/MJplIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6tSsOn9o7S5dOZcptD3ZUbsWJkyws62X3PjOy8lmLg=;
 b=FI7vWFNwCu5dv4X3vKuj5O3Ud3pP191piDtH3DpF9OLUV9uFQwpO3sqHMtAQ/hQu14S3gWoFB+UkvQLbrS4i5NSW8/CS++AjR4TS5EiqamxV6x53tCZRPQ6VHtNKjM2L0JPAlOsjkn9c82fOaCqtWiwywudouqImNiML1y5w75I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOYP265MB1886.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 12:08:54 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 12:08:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 13:08:52 +0100
Message-Id: <DKSWQA542X58.3N48L8WCDBJR0@garyguo.net>
Subject: Re: [PATCH 1/6] rust: alloc: add Vec::push_init
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.22.0
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-1-b84db5e84b67@nvidia.com>
 <DKSVRS7UAL9U.3RUTW74RVSEHQ@kernel.org>
In-Reply-To: <DKSVRS7UAL9U.3RUTW74RVSEHQ@kernel.org>
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOYP265MB1886:EE_
X-MS-Office365-Filtering-Correlation-Id: 564b5009-cb82-4ca7-ca36-08defdeaa36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|7416014|376014|22082099003|18002099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: EHpsxpIPAP5rYCd3TZCo1YLQLC7vUOunckr9sC4gjcZ0sFxguNP8gg1/yM+VNaL0krbQJUq30Fj8LOJQgfTxQ/2N05P86uiOI8/Q5M0Sapgh9lvFqNb7golu08tYAuVOUO1j/+U+osoy7wL3bO0HDhY1FI7ykO0f2sSoIGhZCPkuWxJ73B0QqSEX099/EElnyCg+Mc82/RdOz3RYmH+56DJISb757jp026q9YCWwm4lZi60Q2so3yR/WK28ufseBFf8JVY+XKPKbQdV0Seq2+cm/Zs2I4IBUPs+4vWCLK1HIszMK9z+BaTAizdzHFtrFPM7JwYm1jLdiznb65EijC2eGTxSeriEv2plfXVOdZWyPunoLoD5UeULvfWAjp1/gk3a/N8OqnS/UFgifRSWFq4H0xYpQXmeS9d5xt/eNZaxEdn+YHmQR0cFQ73T4lQ1Xcfzso5SW+5cDYGn6BPYzEfte9gCzwzOOyAGodptTy6l29KkDbPZ2l11O2Cf7MeYEBErQBB1+fA6VCVPR1gBj6E3tllBD9lU8ds19nT+W71VvAAHoY6cH6I590Ya9gZVsbXzg/R9eyVii1bil3sPNjr9ArELdf/l4A091cKGbX8DkLiKqCUgXpRpKUYDSBrN4kpvsZaiWivq38mDg0tuz8o7Zgm49uOO3IxJ6LHOgyBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejM2LzNIakJjeGY0QzJwZjY3NXFPbnZYMWZwWGpkQU0xek5LYno4N3FOTll5?=
 =?utf-8?B?VWgwdUhQbmpDSURMa21XYkVpOVhGSjIrVVp4Q2R5QmRtalVVZVZzSmdxc0dT?=
 =?utf-8?B?Uk0wR2N0ajNwVytndGVqQ2tZb0tzOU5SOFgxNndtTGhya1RXL29uTzNsOUZP?=
 =?utf-8?B?dVBZa0ZDcEpiSG9sUnFhMlNSOStLNkp3RkJ6K1BMZ2JNQ3cyL0szU0gvWjc2?=
 =?utf-8?B?VkQwYjlwWTN6RXBXdm01aUZDU3ZZR2phY0FLUVFUUGpWNlk3M1FpMjVnTkg5?=
 =?utf-8?B?aDJPUzlKWDdQN1FnNDFqK3dnN0kvdVkvak5WUTVUVVJTcGVlRXk0S0p2MmE4?=
 =?utf-8?B?MmtVL2V0a2hLUzlNOWQ0dmZPdW15VnpxdUsvSWxSUjVYRm9VOEFCSnpJeklh?=
 =?utf-8?B?M3czcHl3dDg5dENGRlVVamphQlhsQmtQVWFIdGk1TERLZTcwaE1XNE9sMXk5?=
 =?utf-8?B?VUNRSnZuWjlyRDhoZGM2aHZ0RUVVc2QvMi9rZDNyN1ZlWGZQRHlDNWd3TVpF?=
 =?utf-8?B?bXRXKzczZGM2cU9RblEyME4yajhKYzB1Z2MzbU9kYTBhSVhaenVoTWRUWmJM?=
 =?utf-8?B?MEQ2TlNKTTkvUFR5WXk1Zlk0eVc3TGNCbnBoaWVtRllVRHZRbEFESDVMWEUw?=
 =?utf-8?B?MHhXeU9xV1JkRFlHNFAvRnR1c2g2aER1VXRuaTdmckovSk43REgvM29HL2ZT?=
 =?utf-8?B?NzJsM0VXeXpucDVKWkFIQ3A1OVp4a2g5Z3phMmJua1lKRkJGcnlhTTdrRHJT?=
 =?utf-8?B?SmRvc2lMd1A2cW5mQWlCNlZES1ZabEZ5YkgrdHRtSzdzaFhCWkgvRGNxNkFm?=
 =?utf-8?B?eXl2d2RvNCtSeXV6SFNxRGdTRmkzOHVITUtKL3Q4MDhHL3RtQ0ZNQmxjTHpu?=
 =?utf-8?B?K1ppTHlHQTU5MWlrTU9ZQVBWcDhTRlQ5U3pXdjN1czRtaVBJM1RaUVlUbTlu?=
 =?utf-8?B?WkRQSWtxRlJyTy9Hb3gvaTFjbmFTU1hLd09yb2I0R0FmUzNnaTBOd1BvLzFu?=
 =?utf-8?B?SjlyUkxUbFZHS0ZqUXhpS2JMTkpGRjU5cW5xdlhZTGc4NGhpVEVpWWQrTmpj?=
 =?utf-8?B?SXo1K1A5K1JpdHdDR0Jqd0RTeHBVYnNPYjB4RldFRXlrY0pHN3J0cFBzQm9H?=
 =?utf-8?B?UzZBdFdFYjRqMmwyOVduV2JXNk1PcDR2SFVXOHpQaGNLdUkxbHBzTVpxcXlq?=
 =?utf-8?B?ejBwMnZsS2NaaStpSDF5MzZsdzNzTExDMHJLOVBGZ3phZlhKWHBiZjlKV04v?=
 =?utf-8?B?K09wVkcvNDIrbS9tNEJ0OWl6VmNXNGRFYUM1OTV6S01IeXJ3RDdhcjdRbUVF?=
 =?utf-8?B?MUxtMm82U0FzVWJTYWpqL3pQMEc3NlNGenpGbWN5akxDNWVGQ3g2Z0pRMDl3?=
 =?utf-8?B?QTIyMjBWN0d3K3VBYldlcXBWVXNFU3hzREY3Y1huL0hRaDkyRFlHemNSaEh6?=
 =?utf-8?B?V044WmlKYlNhc2IvWkNyaXNXRDhOYlZib042ZnJxL2RaUWVtZHAvL01Qdk9Q?=
 =?utf-8?B?d2tVc0FZWktDMzQ2bEVubTRLVVNSSUhlS3FKamt0L0FMMEV5TVA5WDlZQ29i?=
 =?utf-8?B?bThzOUgwUlQrUVVzdGs3cUVIZGFoRG9BNENCNHZQd3JOd2ovME5tUlFkZWVW?=
 =?utf-8?B?QjJQaG9raE5WZk1iTzZnVnBWWkhFOExldWJsajVSR1YrdVc3T3NHZWMyTTU3?=
 =?utf-8?B?d0Q3bjhxTEhEaXl6WGJjR2Z2YUtWZk5HWG5ZNjBsZFFWeTViaWRmZHF6MWta?=
 =?utf-8?B?TDZtMTZQT3hmUjZlZWlBN3crTVJTc3dqK1E4YzdnWnhPWHZSclRZdmlLTWRV?=
 =?utf-8?B?UUZrM3VVUEJiNXBzR25CQ3B6RCtlVitVTEcxOFRDSkNPTktQWW9zWHVML05p?=
 =?utf-8?B?T2ZuZm5CTThCNW90Mi9icmExQlVGbUxRbVJaakt1ZTNrVTVnQUExL1M2M1Qx?=
 =?utf-8?B?VXMvSGpheituM1lYTk9uUkgyWU9pRkpLT3g1bTFTYXdPY1JhRk9yYU12MmJW?=
 =?utf-8?B?d3ZrMndOZDFHRmNZUGZPUTQwemFXN2U2NDBpbjN0cnF3YWVHVTlteHVoeE45?=
 =?utf-8?B?WkY1WkdwZFpmdmt6MitIb0Fpelc0R1NPV3JHSXhLZk4rVGtLZ1Y2TmYyQ1Bo?=
 =?utf-8?B?YnZBNjFwZk8xMFdGaWFjSE15MmNCT3dCQ3NsNGtkOGhWS1dkeCtTb2pnZDBm?=
 =?utf-8?B?SVljdW8wdGNCVmFxcTlITnVydTQzeUEyeXYzbm4wZEZKMjVaYktKOFVPczVy?=
 =?utf-8?B?ak83cEFVK21sUEYyM2RlSnV3YUFXaGJhbGVqZjJuL216Tm15aitlMk5hMlZC?=
 =?utf-8?B?RlhyeGhTQ1lSR1dLZ3Q2TEg1SEVVUlZVRnZVckxIc0RyRG1DRTErdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 564b5009-cb82-4ca7-ca36-08defdeaa36e
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 12:08:54.0446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHxCl+f9yP32AG/LkwCIlagbb2xQRaP+n2soTP2UfSBy5x9sLGoVj+681q9uwjHzgNzR5Z20knNueNdfmDEjIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1886
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

On Wed Aug 19, 2026 at 12:23 PM BST, Danilo Krummrich wrote:
> On Mon Aug 17, 2026 at 2:56 PM CEST, Eliot Courtney wrote:
>> +    pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags)=
 -> Result<(), E>
>> +    where
>> +        E: From<AllocError>,
>
> This signature rejects impl Init<T, Infallible>, which is the reason why =
we have
> e.g. Box::init() and Box::try_init() with different fallible signatures.
>
> So, if we follow InPlaceInit, it'd be
>
> 	pub fn push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) -> R=
esult<(), Error>
> 	where
> 	    Error: From<E>;
>
> and
>
> 	pub fn try_push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) =
-> Result<(), E>
> 	where
> 	    E: From<AllocError>;
>
> In theory we could also simplify it to
>
> 	pub fn push_init(&mut self, init: impl Init<T>, flags: Flags) -> Result<=
(), AllocError>
>
> and
>
> 	pub fn try_push_init<E>(&mut self, init: impl Init<T, E>, flags: Flags) =
-> Result<(), E>
> 	where
> 	    E: From<AllocError>,
>
> However, InPlaceInit actually achieves more with the init() and try_init(=
)
> distinction:
>
>   What init() accepts, but try_init() does not accept:
>     - impl Init<T, Infallible>
>     - impl Init<T, E> where Error: From<E> but NOT E: From<AllocError>
>
>   What try_init() accepts, but init() does not accept:
>     - impl Init<T, E> where E: From<AllocError> but NOT Error: From<E>
>
> So, with the simplification we'd technically lose out on the
>
> 	impl Init<T, E> where Error: From<E> but NOT E: From<AllocError>
>
> case.
>
> In any case, init() and try_init() seem a bit mixed up on their purpose
> regarding fallibility and error type strategy, but in order to really cov=
er all
> cases I think it is necessary.

This is one of the reasons that I suggest the entry-like API. This way the
reserve and the push are separate operation and with their own failure mode=
.
`reserve` can only fail with `AllocError` and push can only fail with whate=
ver
the error the initializer can fail.

The most simple case of just reserving one element:

    vec.reserve_one()?.push(fallible_init)?;

the only requirement then becomes `E: From<AllocError>` and `E: From<InitEr=
ror>`
where `E` is the error type in function signature, bypassing this unificati=
on
issue.

Best,
Gary
