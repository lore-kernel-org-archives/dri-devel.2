Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E490C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B90D10E7CC;
	Mon, 10 Aug 2026 11:23:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="JU7Lf870";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020098.outbound.protection.outlook.com [52.101.196.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C15010E7D1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miCxLA4Wy4J0AFavGRWgBlbjXmwbFYWqFijcFZFM5mKAgSWsoIGzBM92Gd2OEErKKxWHsp47l1E2VbzgtFaNzr7O3npzH+GjwqNO+vpfAu9gP6ig2Ot2ZoeVJerUruOuoLCAgqAy82s1FupJuhELaeKudq1MKEGAdkbYB8BCOfU6dUx3XnYagVXyoi2MfTWFiJnbkb9i+gTbO9Y60fqS4UQhCHiyJdnCFWAddzPkVmMstZEuZr0B6Sj6yQGqvq9uGbtzOI+JjvcvocVbjjEEPIuXaxzBnndArJmNnViGljtVscGUHlYkjTqe2uqtGGk4k1yG4o3r/jcnxVqaI5xBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79BmxIN8o2623bneck1RuksKKPcaREh7y9kdsZOVKZo=;
 b=YxAmrrODRg6KakU9G598VxRYma0rViOSvFuXn75J/dyWAh3aRqwC8Pa5iNJkkjlCg9/WhZgyBcErRlLEukDKfEN/EuRY+G4bTBsGMSRe5Ox8MB5Qn+urrZnSAyluRY2LNHMRDvxr/eqLzBchAEg5BAA6cJ03gNTB6oU13DUKxK6Ac8Wdlrn1C7xOvAcpyTm4osCWy+X3suo/DIcZw2O5yMKvJ4EQ3aoV+x4YkXIgEFguT/zBQvo6adQKg820X9OHm0lircXomaYvGpqOyZIt0LbTsKHZYzZwr/plaPvN0VlEcO4d4SuWn9B0Z/EVKI7iEDQGKCjBPqXeD1tvkFKL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79BmxIN8o2623bneck1RuksKKPcaREh7y9kdsZOVKZo=;
 b=JU7Lf870xmTGeVn92cFv6DPypVOQr1UIP+QYk4gy/hURui6sCZYTnK70cMoUxn9E2KUTzQ8L63vE1CK3DE5IQO2XKga3//FVUXCafOxAj44WI22q++ENWjw4SpZ0XGKeaORBad5UNme1bGwrfm8CKdybE180eHOozTxtSfi4Kgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB3108.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 11:23:06 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 11:23:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 12:23:05 +0100
Message-Id: <DKL84BFZ906T.3P5Z9WHZ4SDHT@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 03/16] rust: io: support register projections
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-3-c3ca142220a0@garyguo.net>
 <DKL5QACM4OTZ.2Y8RLMSPRCXJ5@nvidia.com>
In-Reply-To: <DKL5QACM4OTZ.2Y8RLMSPRCXJ5@nvidia.com>
X-ClientProxiedBy: LO4P123CA0594.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::23) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB3108:EE_
X-MS-Office365-Filtering-Correlation-Id: af74a506-4c68-488b-1f2b-08def6d1bfb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|10070799003|22082099003|18002099003|10067099003|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: 71WhBWNZd/e/kKi0AhJH2ep48RLtCS+n110FboC/RlgXmmFwGB5mORTrm5VgKSzEksImLw2L4IajqWmgmE0k6o116MNpuU73HV5R7iBy8RsLXtIZq4/8uT3RNGXoMZMFP8nUrXMZiEjhmGQPK/NEr3PFKtwwHD45aMszeC7yJq4FbMR4++vwDi18dyX3AMx6mq1qlHhHHZb7BFJ20foI4zlAwbvKPY2jwlw9R3zi/7HiZztnG+CpBH6ZlLA+kodWwFZVrw1OEtiZr/84Bb6fm0XA69KUYV3Ya9g/XybFLTDnIA4NOo56dSY2JexmJ+zvEa6izikngj0GYVcRdkTginfHlnnKgWcDC8pIdOgREKjEzNjddo0dJwALM/iVU32EWJJ/xBpacAbVr7HYmVxScNTZtoEj//tVemzbzVgIWteAgUFqUE1GmzhfM6RIpgFadd17jOp5YtjAO1ijd+OONt6YWDroOStDELtENXiQQHhXyEXg167qvUPRAAXP2bRJ8RAlCuVQZgokAvYGqE7CwEEJ+zif7+pPlwDMXPwu2pRXFTaVSJDouIZLbD/am1WCmazqD+0b6SeP4YJPycjUUz/eyf+l6i6MJgiHD9V54IOiO76eImVGmSq30bS0wPZGl5LxWT93fWDCm9AS8g8pV1h6heDWaGWnV4iDsyhtr1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006)(5023799004)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS91TklGMW1pOEN5T1hzMGF1clhqK2c5L3ZBZnN6dm02Y0FVb0JvRGhGN2VO?=
 =?utf-8?B?TG4vRjZLUC9JeHhGT2hoT2J2bTZwZ3BubjU1NjBXZmdQL0JBNVJhUldBWUlV?=
 =?utf-8?B?T3JBRkxyUTY0M1NFcFFONVB3cUg2ZjlFWXV0ay9YMFpzL1Y0Zk40MEQvcis5?=
 =?utf-8?B?a25FT0FieU1xOW5EUEFvSlNaeWJkblRmc2txWWd2SWpOY3c2ZUxxV1diMitp?=
 =?utf-8?B?M3dlR2dObW5PNHYvbXJzcDRkbkFTcmNQK1NQaFN3ZmptWkhrbTdlWW9RYUxO?=
 =?utf-8?B?K1I2ZGZzaWxEWk5OUy92SVR2T1ZYQWVZdm9sdlZyNWx1ajVMT2dxbnR6RXlx?=
 =?utf-8?B?SXh4YmZGcWZ4TWROUEZscGZRYjUyNUVoVFNSL2pQdFk4anZIRXQ0R1V6RTBV?=
 =?utf-8?B?N1JFQ3RQWGJGbDl6eHc2M0hmQ0ZTVjhMYzRiMXY3ZjNGYVJucEJqZjFod0RB?=
 =?utf-8?B?eGZleDF4QWFaekdVZ2doY2VTenMzNmEvRGxhUWUrVUV2UFgybFlla1VlT0Vo?=
 =?utf-8?B?UmZqY0Q3VXh0Y1ZJaVhvSmtsS2c4RHVDbEdyZDBNK1ZXRTFGU2NuWmFPRUxq?=
 =?utf-8?B?TVdVNDB4aUpoSWNCMkN0bUNDNG1BT2ZyWXJYSUVNWDBKazFOUmlVNzBHVzU1?=
 =?utf-8?B?QWxyYlIzakNiTXRCWWtWaFhJYWtrcUptT0FLdDJXMGRWNHhZemE4aHNMci9r?=
 =?utf-8?B?ejJOdUc5TjRDaEcycWl3Y3VJUGVhOERtcEhJUkdxRmtrMVh2R1d5Q1cwWWpa?=
 =?utf-8?B?dXZhQmFNbUp0VG9KWVNmekVBZ3pLUTd3M201YWRhc29USldpdGNjaDhBZUlX?=
 =?utf-8?B?ZVI0aXVidytKOG5SNzJ4Rm0wUVVMb1NsaVVEY3Z4ZytOSFdBeG9MWjNITzNx?=
 =?utf-8?B?RzByT3BZcEg0eWc1eUxuQWYzTG1BcmltbUdHQSt2ajYxaU5WZ2Q0cjZ1K3h4?=
 =?utf-8?B?dk5ZMzR4NEQzNXNxMk9KNWl6NGE0bGJqbUtONklQMXpDNDZTSyt4VlFsUkpr?=
 =?utf-8?B?QVMwQzhnWkU0MUJjNFZGQ3hxcHdHVzArTDcyU0RzM0gveG1hL3VTcmthcHA0?=
 =?utf-8?B?dzBxalBVZ1FDN0psaU4xdTdZazV4TkkyM3ZmTHJuL3F3ckJzZWtwS3l5cTBa?=
 =?utf-8?B?U1pGZ0NLYjZiakQ5QWhtMkxJdXNwdit3bFZsL2trdDQ4YkljcmIyZTdJOXdv?=
 =?utf-8?B?TVJlVmFDQUV2a0ZEblRTTlNzb3NaYnl1U2VvRW1GbTl5R0ZJYXVub01SK00w?=
 =?utf-8?B?NW82bTRYMTNabDE0RFVpZjlzM05hb2F2Q3RNUkQvTVIzYjVWenVDSXpQRW1U?=
 =?utf-8?B?Yk5IQ0lhR0RKcXQ5eGRkcXZ3SCtuWTlsY0UzOUFoeUIyQUhsVlpTbzBEZXM4?=
 =?utf-8?B?OHBZcmVXQmR4WlIwUUhqNG1NVm5paExLbHYyWGs5WWdvSXcrRFhDOXZCbVNE?=
 =?utf-8?B?cXBiUHhvZE9keWhWcDVoejYwbUlFQzRiTjUxVktXaGZZaDhta1p2TFhhb1Nu?=
 =?utf-8?B?NGlBQnVheTdIV3dMdU50ZThCck82czdxcDhYck9nSGJVdUFDdHRVbENGdXNI?=
 =?utf-8?B?clBNcGZFeUhab2d5K3FzMGVRTlluUFB6UEQ1NDBHSVlNL045cmh5T1h4MGNv?=
 =?utf-8?B?c2FtMVhhUHVUSVlyRU1rWkloWVpOcXFFY2tuSW5FcEVVcEI1YjAyeWM2ZHhz?=
 =?utf-8?B?ZzBTbGJmRHhFakx5TWVacGRxWGRURStTZTgzdFVvSUgvRUF1NVh4YndlS2Fx?=
 =?utf-8?B?ZjJXTjJ5Tks1Tk5nUzlrSHJDQkxESFBNRVgrbXJGd2R1Sjd2enRhS0QzVEFu?=
 =?utf-8?B?TEpRM0k0eE5ZTVZNVkJPUGJvNlJJRFlkVWY3eGludDh1YUpBSzhSN05Eby80?=
 =?utf-8?B?b0Rvc1pFSnBCc0xTNS9GVjRYY3BmMDJLUUlrdUJybDVZc2dXdWFLR3ZkTm8z?=
 =?utf-8?B?dXl2bi9BMFJjRXl0T0duTCsxdjhNaE1iemozUWg0NHFGYVE5anJlWmxEZ0h6?=
 =?utf-8?B?a0ttVnJKMzUxYVVSSkNwamk1bmRrYmx1UlFKV1VpbXJmVFhFMERlOTU3clMy?=
 =?utf-8?B?S3hnTi82bDBlSlBrZmZVUTlleWNocGtqTGsvajZNblVORkdLUnloUThwSGVH?=
 =?utf-8?B?MVkxN1FyUkFhd25nQ2Q5SUk4bjM1cFJFSHBzc2I0VVFPTEdHeTgxWFJLQ3Rt?=
 =?utf-8?B?U0ZwbW9qcXQzRUdYODJBeC8rY0hQN1hKN1FXeDl5Wi9LN3BISmNVZDMzMmVN?=
 =?utf-8?B?bFBaU3lsam15VUFEL0ZXSWJFc1NHV2JDNVRTdDI0ajRXTHBWQ1FDT0pMcVJy?=
 =?utf-8?B?MFNEa0dWTGJGeFR3MHh6MmkyUUlzRlNIZnNNbEJaS3czUW1oZXJrUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: af74a506-4c68-488b-1f2b-08def6d1bfb4
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 11:23:06.0362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vdxf5Kb28QPRJB4ciHMOgorKtmct8fBklZVOVaTJgjuTWODLRhguu/EpS16ykkPHer88aHsqPtCN45oha8B4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3108
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

On Mon Aug 10, 2026 at 10:30 AM BST, Alexandre Courbot wrote:
> On Thu Aug 6, 2026 at 1:35 AM JST, Gary Guo wrote:
>> `IoLoc`s themselves just describe a projection from a region to a concre=
te
>> register. Thus, support it in `io_project` macro too. Also, update metho=
ds
>> that operate on `IoLoc` to use I/O projection.
>>
>> Documentation of `io_project!` is not expanded yet as the example works
>> better when `register!` type can specify base type. `io_read!` and
>> `io_write!` gains the ability to operate on registers as corollary of th=
e
>> capability of `io_project!`. Examples are not added because `read` and
>> `write` is still preferrably used instead.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  rust/kernel/io.rs | 58 ++++++++++++++++++++++++++++++++++++++++++++----=
-------
>>  1 file changed, 47 insertions(+), 11 deletions(-)
>>
>> [snip]
>>
>> +
>> +    #[inline(always)]
>> +    pub fn try_project_loc<U, L>(
>
> nit: missing documentation

This is intentional as it's part of a `#[doc(hidden)]` type. The user-facin=
g
documentation is added in the subsequent commit as this cannot yet be used
without specifying base type in `register!`.

>
>> +        self,
>> +        location: L,
>> +    ) -> Result<<T::Backend as IoBackend>::View<'a, U>>
>> +    where
>> +        L: IoLoc<T::Target, U>,
>> +    {
>> +        io_view::<_, U>(self.0, location.offset())
>> +    }
>> +
>> +    #[inline(always)]
>> +    pub fn project_loc<U, L>(self, location: L) -> <T::Backend as IoBac=
kend>::View<'a, U>
>
> ditto.


