Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFA6C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE6C310E79F;
	Mon, 28 Sep 2026 06:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y0NAvXxo";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AC210E79F;
 Mon, 28 Sep 2026 06:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv9cteuuu3Z3lXZ9s9+7FMN94PdYz6Q1gRVAhJNsbMafAJGu1gP7i6NBq1jaD4co6qR4PQrh6VDr5wQeb8Eucsai15dj8SvUfMACn7+STNT36l2gSP+tcc31Rod6I7Lbg7THfqEP33MOL4vrivB8X7b9Gt2dsgluSoIX72JKm477J6cteLD7r6rO9/lpafmK+Hjam6G4OY3hzcHppMfkZqWyxoju8Qus7iBs5mMBRy5hL1jLCwkhs4L7SdsCsU/p/igSkVXwrjuCl+bdxkGH49J9MfSYi+k1U0bwLivWKOv9IMCob9gDg+02suRYH3Iu/xZ3REdnrGs6puEKycCTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR7sfUSQkB7pHItRYFjSgaZyaC12Twgk0An9WR1aPXA=;
 b=oiiOvvjmi9LGCsKkxZ/bBue6fo3c/hvnXeQIcwvzMiYRUhU8ALDtCeia05LcKa1h5vtKXMhoEtwxDZBhl0l68Bxo1yhzSfLKYJ55DR02sSQr4/GvW/oSiIegfNxedhHF8Wznz4c8ra8wteuUorJxCXIPAV2ZS9fXHh+SLpI/BV45g0DhUuWIgkn6YZdAQhCMTHSQRINdIoOtCvu0rzPXdergKPMdvN1pGutWbxaTPMCejmQutRo41g0KN8Mg9AjVk7xzpjFoVBpz+sJRAIq/9udVemgVgpmWx2wyYMJFYLf0h5rHbGW3gSiugipnTYUnZNe9w1gnT0Vy8VvNVf8Dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR7sfUSQkB7pHItRYFjSgaZyaC12Twgk0An9WR1aPXA=;
 b=Y0NAvXxoCEgzP9Adq8L5HZx1RD/tkPZJfCWo+xuiyYwlnJLKPw1ar+GXJ7PtsOR6ttF7yyW6cDxbanqiU4k/C/n1SsFSJ45Y5Pdy8g2MS73AOtx8fCTyz+fb5ZQDSnC+00aQho7QVXg5vexBc3gfpELtUGu3G64M87WSrhwoaEXoMKW7yqsSBgNivYoBsjFSsqIEh4mob2fLzLQY9GD/aqcprGID3dfwWPQSQQqDyYtB5NA+x8/8kQTe60kyg/vI7aALykGYdlyMWaaptKqxMCUW6Dp8WSILouSLBRyY16REEfnk4v1gwrV4FyhcbuXs7bP7x+vpVHpA2DiBR8s5Mw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:22:43 +0000
Received: from PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d]) by PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:22:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 15:22:34 +0900
Message-Id: <DLQQEX4KAFFJ.1Q2ZBN0Z0R0RR@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/9] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
 <20260927-cmdq-rpc-v2-2-c3f66ae73be4@nvidia.com>
 <DLQOB23WLFC6.UKBAHKWNG7ZY@nvidia.com>
In-Reply-To: <DLQOB23WLFC6.UKBAHKWNG7ZY@nvidia.com>
X-ClientProxiedBy: TYCP286CA0356.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::8) To SN7PR12MB6862.namprd12.prod.outlook.com
 (2603:10b6:806:265::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6858:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d49fa8b-690f-4520-488c-08df1d28e6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 4OPdOG1o83/OsXOaq5S+w6j5nRuOM6fW828vgbtuzIV6Wu3lUtUPaQN1Su7jG2LedP1KxAoOrXwNXInmYIUzuDz3YBmWuRPwaJTiJykbFjOsSCcKYxFExMWD1s6u2UzNRJkGoJMZgH2N3Ya5IrmkqnD6BYbP5MuhFuTZrRzgsDaEQ9g9y+60MoZTWvYCRgJZ6yBE038s4Le4zXcblXwoo+r+yO/G9v/+eMFUXvebjLyzfXYsdUphFoqdPrDvnMh98V8SZcyHKm20QEXV2iwTLDxqXVu9a39waSMS+WTkioWF9YJ5odl4szeAzoFnTdFyyI8vKfP2DeXGnY0Hr+n5LRXumlpu0dHdRl4Bvw+OirXh5urK2wkJ3B2qLnDmJDuerFyDEIjVawLWIpFNfknYUnaZA4EnqaQP9ShricEvRWxspG/aqEgUxSVK8BAxA0MM5nhOq5/d1KU8gdanmfFNoX3jaqxl70hUuIrIURB2pCvPuYa08hybwNDZCPr5kbY3oZjATVQfs+8HpDQf/YhhLj3+T8M8852NNLg+RTgg/AZ80Gu88UDV/c3byiLN5oow8ZGA1Xy0iMrr4lN/fNNonAU0buA/IyXcp2QUzfnaNEHfFNGmLwc0ZeXs/BuRniGCbIkq0RBQoS3LO7FcLI3gDjyuBDtShkHgxASVx6bQiLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2E4NkErUjF5RUt5d3VwS21rMnRaeHc1YXdhR2xzT0NObUg4Q0ZNYm50YVRO?=
 =?utf-8?B?V2pMY2pDMTU0UTE4YisxNkFsVVNZZFJVSEYySEMya05QZUdjdUlxUkhQNTBX?=
 =?utf-8?B?d3hpVlFoc0NQeXpZc1grNEh0SGNMaEtTQVgzWEcxdXBoZnNIbGZIc2pYTDho?=
 =?utf-8?B?OUtuV3hMZGkwaFllOTRUZ0U0T1NZcHhid3Urak9WK0o5L1J2RHlhR3NZN2g2?=
 =?utf-8?B?SzN6TSt4QmpnSkh6UDN4d2tsaTBWZEFIYmUzY2crNUl1QUdHUjB1dlFqSXVQ?=
 =?utf-8?B?am9MN005azdLdFVXVFUrSFhuOHNyY2Yyd0x1Q1ladGNyYVQxLzYvWmR0a1Z0?=
 =?utf-8?B?SjR1RE53cXY0ZXowQi9YYStScTNhb3c5WUFWaEhJNy9SbkJJWTI1VWk4ZWwx?=
 =?utf-8?B?K1ppamQzaHIvODRnaHFLTlh2bzVScFBVUFdORzFYZWFZWGc3NGphSVJydUJw?=
 =?utf-8?B?dmdUc3NXeTVsNExESjR4cjZPdzFUakR3L2FPVGtYWTJuS01WYjdHUFFQc1dP?=
 =?utf-8?B?c05FaWZ3QlZjOTZNOFBtSVBLbENMY1hOMVRWVEhBL1RIQUVJQmRvMTV3N0E0?=
 =?utf-8?B?Y2lDTktxbmxvM2IzeDdHV0Q1UEwzUUxMMXE1K0hNdFJYaHRmb1EzSjMvRHFO?=
 =?utf-8?B?Y1pOQ3VLeGF1MkNtdGxBVHlZeExpZzhLNEhuQVgweUpUYlVoc2dRNytOWGln?=
 =?utf-8?B?WDBrbCtUVHZXUmpxYllUNDdxcThPelptTjhMVTFSWVNWeHJxR2pMZVdzUWsz?=
 =?utf-8?B?cTJQckFEbEVSdkJ0eERSNHZwUDZ0NThQZUNSYklWc0dtYWlObXZ0blFvZnpX?=
 =?utf-8?B?MkR1Y1hRaDQwbG5rS0kxMU5ac0dyN1lWdWh6OVpQc21SMVNiamwxLzF5OXNE?=
 =?utf-8?B?empMTTlzU3luZW1kOXRtN2JJaFhWQ1dMS1RUWW1uRmtLWloxTUlUS2RKVWFz?=
 =?utf-8?B?SkdnTEtSYXBUZUxGSmZySGc3d3kvcHpGSVluOU1hYTNlb3o2TTZaQ2hpMEox?=
 =?utf-8?B?eEQxWk1BbG0wL2VQeXYrQ3hzRkNMdzJQSHRqYXpHcEZsRjJrTWVNTlNML3FR?=
 =?utf-8?B?UUVwZThhRFZJZUJUcFhOTElRZm5KL2dIaU10dyt4Y1pubGwvSW5rbElKLzYw?=
 =?utf-8?B?dlNSYUprWHRITkhXNE1WMDg1aURLSzVvMVh4aDdwTEVVcjB6Rjhrc01Sb0Ur?=
 =?utf-8?B?M25VNUVSYW11UVFaenA0ZkhvK3ZSS1lnWTNmSzh5Z1g5NHFnMFowaDJvS0pG?=
 =?utf-8?B?NDhiVHNneDJzTFZQQlBPSkd5MmpRRitFQ1d3R1lTWEpQZVN0aEVLeVhXSzlB?=
 =?utf-8?B?WHpyc2pYaWNPaFhEY3gyYzBieG42L0J1dTlBNU5jYzNQbHZISnlIY0w5REhy?=
 =?utf-8?B?aWpWclNyb3JudGFJNnl1ak5JWTZIcDRnT1I1QzlWSEk3WmhTZWk5eU02M0ZQ?=
 =?utf-8?B?UEdkd05MQkwvWEIrV2VvZFF4MDdURG1UK1FGaHVKd1hmUXBuZTNtcGM2c0tS?=
 =?utf-8?B?b1JPWDdLN0NwNmhSUU1WVWNJYnB1SEliVFp3QmtjcmpQZTdKY2ZUUzB6UHI5?=
 =?utf-8?B?QkNzQ1lacDNjT0NYOUc3VkM4K0NrUzVQeHFyVTZXMHN5Q2dJRTZReXJ4bkpz?=
 =?utf-8?B?NWJNR0VFbTVyUnpTRE8wcW9ZVVZaUWFsL3JkbWMvOE14U09ZdWErSTRiOHhY?=
 =?utf-8?B?alhqZnVJajZ0MEhoRGFWaTFYcVJpTE04YnA1N1BrK2hsUmRMYW9ibzRhNmdv?=
 =?utf-8?B?U2xBUWR0N3BJT1BqMUdVZE9zdVhLdjEvSkJza28zZk92bldxT1loOUdKTEhP?=
 =?utf-8?B?Mkt1bEVtSTREV2ZIdXl1dERmZlNxYXl2WWpsQmlYTERyaVFsS0dVc3h6RGFM?=
 =?utf-8?B?S3FGdXA3cDgrblNVRXB2NXZPUnRLR2NsajVocjRkMDlSay83cWJqSEVmUC9I?=
 =?utf-8?B?enBuOW94bkNSUW9DRzlMZ0ZQc3dRVnRUQlNMZHgwazVqaWRxVkk1eTJtU3hQ?=
 =?utf-8?B?eHRWc3N3Rk5KTHY2YTh2N2huam9TVENUQytGZWtoZmJ0bDlkSE1QSjI0QWVr?=
 =?utf-8?B?YmhhbkVjNkVrRjJOZ04zY0FaYlVNczI4WGZ0bWhmOCtTdzFoeGo2K01FSlox?=
 =?utf-8?B?b014bk5qTFF6TVVwOWlpakNKdGtLYWJkbHk0eFFMdkN3Tm1FU1FzTkV3cG5k?=
 =?utf-8?B?OVZIYnF0RENaNmFXWEMxNmozeFpIRzIyVjNqTW83S3RKSk9QZExKSTlySFh2?=
 =?utf-8?B?aVZsUXlvN1ZYZ3NlS1NzSU1UU1RQUkowSkZrOW9CalpIOS92ZTBsYnA1STF6?=
 =?utf-8?B?clRUQ0Y3S1Z6by9pdVo2UDc5V2szYlJLWmFjb2tsRzJoYVp1Nm13Ymo0UHdl?=
 =?utf-8?Q?wWhFgFab8Qu2CRQyvLu1AkQSgtgmpVWIbQHjICrxBijAU?=
X-MS-Exchange-AntiSpam-MessageData-1: szMBnTtkyyhHBA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d49fa8b-690f-4520-488c-08df1d28e6f7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6862.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:22:42.6840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhYtHuvGGr2RPK3FwmTHKIzP7wRFZAz4eDpREq6lcFhzx52O4OyX+RqbhcS0KbSWvv8AJSQGXdVGMgXm7mfGRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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

On Mon Sep 28, 2026 at 1:43 PM JST, Eliot Courtney wrote:
> On Sun Sep 27, 2026 at 10:46 PM JST, Alexandre Courbot wrote:
>> So far, the GSP command queue transport and message layer code were
>> intertwined, a design issue that goes as deep as the types themselves:
>> the generated bindings for `GspMsgElement` even include the RPC header
>> at its end.
>>
>> This makes it difficult to introduce the new GMC message type; thus this
>> patch works around these limitations to make the RPC message header more
>> explicit and allow it to be eventually handled by a different layer.
>>
>> The `RpcMessageHeader` wrapping type is introduced following the same
>> model as `GspMsgElement`, and can be obtained from the latter. The
>> methods of `GspMsgElement` that actually query the RPC header are moved
>> to `RpcMessageHeader`.
>>
>> Regarding initialization, `GspMsgElement` leaves the RPC header zeroed,
>> and the command queue code is now responsible for initializing it in a
>> separate call.
>>
>> The only functional change is that the RPC debug messages now display
>> the size of the RPC payload instead of the whole message including its
>> headers, as they are technically part of the message layer. This metric
>> is arguably more useful as the headers have successfully been parsed by
>> the time we can print these messages.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 25 +++++++----
>>  drivers/gpu/nova-core/gsp/fw.rs   | 95 +++++++++++++++++++++++++-------=
-------
>>  2 files changed, 78 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index d293d28b0967..3a8548a51259 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -50,6 +50,7 @@
>>              MsgFunction,
>>              MsgqRxHeader,
>>              MsgqTxHeader,
>> +            RpcMessageHeader,
>>              GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
>>          },
>>          PteArray,
>> @@ -664,11 +665,16 @@ fn send_single_command<M>(&mut self, command: M) -=
> Result
>>          let (cmd, payload_1) =3D M::Command::from_bytes_mut_prefix(dst.=
contents.0).ok_or(EIO)?;
>> =20
>>          // Fill the header and command in-place.
>> -        let msg_element =3D GspMsgElement::init(self.seq, size_in_bytes=
, M::FUNCTION);
>> +        let msg_element_init =3D GspMsgElement::init(self.seq, size_in_=
bytes);
>> +        let rpc_header_init =3D RpcMessageHeader::init(size_in_bytes, M=
::FUNCTION);
>>          // SAFETY: `msg_header` and `cmd` are valid references, and not=
 touched if the initializer
>>          // fails.
>>          unsafe {
>> -            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg=
_element)?;
>> +            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg=
_element_init)?;
>> +            pin_init::raw_try_init(
>> +                core::ptr::from_mut(dst.header.rpc_header_mut()),
>> +                rpc_header_init,
>> +            )?;
>>              pin_init::raw_try_init(core::ptr::from_mut(cmd), command.in=
it())?;
>>          }
>
> nit: I think the style is to have separate unsafe blocks for each call
> with separate justifications.
>
>> =20
>> @@ -694,7 +700,7 @@ fn send_single_command<M>(&mut self, command: M) -> =
Result
>>              "GSP RPC: send: seq# {}, function=3D{:?}, length=3D0x{:x}\n=
",
>>              self.seq,
>>              M::FUNCTION,
>> -            dst.header.length(),
>> +            size_in_bytes,
>>          );
>> =20
>>          // All set - update the write pointer and inform the GSP of the=
 new command.
>> @@ -777,16 +783,17 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<G=
spMessage<'_>> {
>>              return Err(EIO);
>>          }
>> =20
>> +        let rpc_header =3D header.rpc_header();
>> +        let payload_length =3D rpc_header.length();
>> +
>>          dev_dbg!(
>>              &self.dev,
>>              "GSP RPC: receive: seq# {}, function=3D{:?}, length=3D0x{:x=
}\n",
>> -            header.sequence(),
>> -            header.function(),
>> -            header.length(),
>> +            rpc_header.sequence(),
>> +            rpc_header.function(),
>> +            payload_length,
>>          );
>> =20
>> -        let payload_length =3D header.payload_length();
>> -
>>          // Check that the driver read area is large enough for the mess=
age.
>>          if slice_1.len() + slice_2.len() < payload_length {
>>              return Err(EIO);
>> @@ -833,7 +840,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout=
: Delta) -> Result<M>
>>          Error: From<M::InitError>,
>>      {
>>          let message =3D self.wait_for_msg(timeout)?;
>> -        let function =3D message.header.function().map_err(|_| EINVAL)?=
;
>> +        let function =3D message.header.rpc_header().function().map_err=
(|_| EINVAL)?;
>> =20
>>          // Extract the message. Store the result as we want to advance =
the read pointer even in
>>          // case of failure.
>> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp=
/fw.rs
>> index 918a7ae809eb..b12034db7857 100644
>> --- a/drivers/gpu/nova-core/gsp/fw.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw.rs
>> @@ -781,11 +781,25 @@ fn new() -> Self {
>>      }
>>  }
>> =20
>> -impl bindings::rpc_message_header_v {
>> -    fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, =
Error> {
>> -        type RpcMessageHeader =3D bindings::rpc_message_header_v;
>> +#[repr(transparent)]
>> +pub(crate) struct RpcMessageHeader {
>> +    inner: bindings::rpc_message_header_v,
>> +}
>> =20
>> -        try_init!(RpcMessageHeader {
>> +// SAFETY: Padding is explicit and does not contain uninitialized data.
>> +unsafe impl AsBytes for RpcMessageHeader {}
>> +
>> +// SAFETY: This struct only contains integer types for which all bit pa=
tterns
>> +// are valid.
>> +unsafe impl FromBytes for RpcMessageHeader {}
>
> nit: these impls are not used
>
>> +
>> +impl RpcMessageHeader {
>> +    /// Creates a new RPC header.
>> +    ///
>> +    /// `cmd_size` is the size in bytes of the payload. `function` is t=
he RPC function of the
>> +    /// message.
>> +    pub(crate) fn init(cmd_size: usize, function: MsgFunction) -> impl =
Init<Self, Error> {
>> +        let init_inner =3D try_init!(bindings::rpc_message_header_v {
>>              header_version: MsgHeaderVersion::new().into(),
>>              signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
>>              function: function.into(),
>> @@ -796,8 +810,32 @@ fn init(cmd_size: usize, function: MsgFunction) -> =
impl Init<Self, Error> {
>>              rpc_result: 0xffffffff,
>>              rpc_result_private: 0xffffffff,
>>              ..Zeroable::init_zeroed()
>> +        });
>> +
>> +        try_init!(RpcMessageHeader {
>> +            inner <- init_inner,
>>          })
>>      }
>> +
>> +    /// Returns the length of the RPC's payload, not including the head=
er.
>> +    pub(crate) fn length(&self) -> usize {
>> +        // `length` includes the length of the RPC message header.
>> +        num::u32_as_usize(self.inner.length).saturating_sub(size_of::<S=
elf>())
>> +    }
>
> Suggest calling this `payload_length` because now we have to `lengths`,
> one which is the length of the entire thing (On GspMsgElement), and
> this, which is just the payload. optional nit: rename
> GspMsgElement::length to frame_length.
>
>> +
>> +    /// Returns the sequence number of the message.
>> +    pub(crate) fn sequence(&self) -> u32 {
>> +        self.inner.sequence
>> +    }
>> +
>> +    /// Returns the function of the message, if it is valid, or the inv=
alid function number as an
>> +    /// error.
>> +    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
>> +        self.inner
>> +            .function
>> +            .try_into()
>> +            .map_err(|_| self.inner.function)
>> +    }
>>  }
>> =20
>>  /// GSP Message Element.
>> @@ -811,17 +849,15 @@ pub(crate) struct GspMsgElement {
>>  impl GspMsgElement {
>>      /// Creates a new message element.
>>      ///
>> +    /// The RPC header is left initialized to zero and must be initiali=
zed separately using e.g.
>> +    /// [`Self::rpc_header_mut`].
>> +    ///
>>      /// # Arguments
>>      ///
>>      /// * `sequence` - Sequence number of the message.
>>      /// * `cmd_size` - Size of the command (not including the message e=
lement), in bytes.
>>      /// * `function` - Function of the message.
>
> nit: Update or remove argument list?
>
>> -    pub(crate) fn init(
>> -        sequence: u32,
>> -        cmd_size: usize,
>> -        function: MsgFunction,
>> -    ) -> impl Init<Self, Error> {
>> -        type RpcMessageHeader =3D bindings::rpc_message_header_v;
>> +    pub(crate) fn init(sequence: u32, cmd_size: usize) -> impl Init<Sel=
f, Error> {
>>          type InnerGspMsgElement =3D bindings::GSP_MSG_QUEUE_ELEMENT;
>>          let init_inner =3D try_init!(InnerGspMsgElement {
>>              seqNum: sequence,
>> @@ -831,7 +867,6 @@ pub(crate) fn init(
>>                  .div_ceil(GSP_PAGE_SIZE)
>>                  .try_into()
>>                  .map_err(|_| EOVERFLOW)?,
>> -            rpc <- RpcMessageHeader::init(cmd_size, function),
>>              ..Zeroable::init_zeroed()
>>          });
>> =20
>> @@ -848,34 +883,28 @@ pub(crate) fn set_checksum(&mut self, checksum: u3=
2) {
>>          self.inner.checkSum =3D checksum;
>>      }
>> =20
>> -    /// Returns the length of the message's payload.
>> -    pub(crate) fn payload_length(&self) -> usize {
>> -        // `rpc.length` includes the length of the RPC message header.
>> -        num::u32_as_usize(self.inner.rpc.length)
>> -            .saturating_sub(size_of::<bindings::rpc_message_header_v>()=
)
>> +    /// Returns a reference to the RPC header within the message elemen=
t.
>> +    pub(crate) fn rpc_header(&self) -> &RpcMessageHeader {
>> +        // SAFETY: transparent type.
>> +        unsafe { core::mem::transmute(&self.inner.rpc) }
>> +    }
>> +
>> +    /// Returns a mutable reference to the RPC header within the messag=
e element.
>> +    pub(crate) fn rpc_header_mut(&mut self) -> &mut RpcMessageHeader {
>> +        // SAFETY: `RpcMessageHeader` is a transparent wrapper for the =
type of `inner.rpc`.
>> +        unsafe { core::mem::transmute(&mut self.inner.rpc) }
>>      }
>> =20
>>      /// Returns the total length of the message, message and RPC header=
s included.
>> +    ///
>> +    /// Note: this method is technically a layering violation as it is =
transport-layer code
>> +    /// accessing message-layer data. It only exists because it is nece=
ssary to accurately compute
>> +    /// the checksum upon receiving a message from the GSP.
>
> This is also used in `receive_msg` for `advance_cpu_read_ptr`, not just
> for checksum.

Ah yeah, now that I've removed patch 1 that is indeed the case.

> Also, I wouldn't necessarily describe this as a layering
> violation. The transport needs to know the size of each frame being
> sent, it just so happens that the data that contains that is at a weird
> offset in the transport layer message (i.e. in the RPC header). It's a
> nit but I would move the comment from on the function to inside saying
> that > it's weird but the transport message size needs to look in
> message layer data to know the length; Because it's very natural for a
> transport layer to need to know the size of its frames.

As long as there is only one message type this does work yes. r000 has a
proper size field in its transport header (and no checksum at all) so
this will be removed eventually, so I'll move that comment inside the
method as suggested.
