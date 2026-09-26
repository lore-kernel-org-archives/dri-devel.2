Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE0C98328
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 23:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAAA10E0C4;
	Sat, 26 Sep 2026 23:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="PS/jPXqM";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021089.outbound.protection.outlook.com [52.101.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A19810E0C4
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 23:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB870HHr59rv2WmBvftJvoT3Tscgs6h/7pKSd7DK011nASTIgsiKNg3y7za154R6tsiQ6uC96OBQOUmFVNddYjxPQXmrbOYce9auQ0VaDPVs6XGk3vwWRJkB+S9+plkmc3WuWLrN8YMjMchzlX2LRjevpLAyAEvfobxHpkQkadbW3/eTheqny92AvNQuBffSBHn+y0whoMilaO17+a3PZGqiYMf3IbzH+YNiA3k2m1eiFo2c6ZmbvcNPun7q8WjjP8MjeBjwl8U7buMiBJ5BmArgUWW0DIaJjmzKIMivxGp3lXSxqTdWpK9PSiETLXpr2zE3p0KR48TggnjbHrTr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhF50AlMrc8cLGJlvHbKidqPm9H1VtjaljR2giLpbg8=;
 b=wTIqysq+YLYBvNWCEZVl2ovG3+K0v+fpBdyQpV5SgbYxdidzgAsIsNVDN58RiU8J3RwRgEx+6+wyPw5GtIhpSW8TPjQC5HM/jaPGNt4glZQxByxvHlurCieav4tg4aWGmIDhvI5YTAtXOoSipbj7u/vEMMMItvL6yGNNcmDriOoNXrKplEa57fj1wNTIB8AeEjLNxiWh2xgnGlwa57rbgWPKngpHxvL54szl9RcAsW+RHfaiaBN2puoNU3vInzADd0T3k/UbhjbPpJVtRLGU34Qrxj7yYiWVOFAtjpWbCRlWRrpreFJjAR2da73U6IlPfZUBj3mgwoz8TcOkrQKAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhF50AlMrc8cLGJlvHbKidqPm9H1VtjaljR2giLpbg8=;
 b=PS/jPXqMnzBM/5MZcT0jaB/KP31rLiHJx0xOY7Nf1l2P2jPKIc3fk0TsvGTRrAl8nOG6igqmI7wEcaYdjDdsONpQhGKyh1qg/d6UxZvZM/XByRA4FXQIJxF+Y7aHOPJj6bFtr0bUJZIogYxqq2jHdIG9JWoEvhQS/ryPlKTZczI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7837.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:213::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sat, 26 Sep
 2026 23:49:30 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 23:49:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 00:49:29 +0100
Message-Id: <DLPNFF0JNNOQ.14JE7RL8LT79Q@garyguo.net>
Subject: Re: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
 <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
 <DLPE0D8F96DE.91C7E0MAERDS@kernel.org>
 <DLPJT1IUSKQO.1CAWHDECQAFPO@garyguo.net>
 <DLPKN532X7JJ.14Z51ZIBUIK94@kernel.org>
In-Reply-To: <DLPKN532X7JJ.14Z51ZIBUIK94@kernel.org>
X-ClientProxiedBy: LO4P123CA0274.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 05569dd3-7358-4ba4-c051-08df1c28cedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10070799003|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Tq7bWUxww0TDYWe3xrCRuY/ibZ2kcxB1j1EzOmfmsn8IapLhpL1OftWXq8nLUjlt3LWG7CZ3kxgQiBMzZj+P4c7tDu1vct+SItvu0i+1QHzDrdvxGCkYcHucn2HfLSqoLcU8v9oklOmU33QGX+rfXzCM3Rqv26h+DISKQkadnCanJcpZbmuGDC8LbZ1Ld4umVE5gIR+pIdiiF+G6ftLdpncoB0C5dFEMxY/PCXFhQG/G0LW3mxP3OZF5+3kOwpij+MrjaQqoofFf1Yg1WqiRsxfVOTXcY1RZ96uFMbzulJjKsW9DBNxsusSoPoMN9CT8vNS62xno+K9ABLuy2UVJX4gvVE8lsCFQqWWhbJpa3zIJ3p4hcncR4YLyqOXHLuqa2KsGkmFSPSIelorG9984XrF0VFiHyp83vH+IEpqqnD+XViBPhGV46hQ7Xjomvcu1kRQLH7/SKL2dnhIm920zlMCyq3/Ee/8Tg2wsn548kgnik1LBb99Fojnrk6Pa3SOXOO0mAuCA1ux8tSB8xZ4ucr+wn/9+hRQ6CdVCQx4wOB87PMMrU01U1kV6o74jn0BR6M+Y7Wi0YeofQSA92mzvKAzotX9nGWPIlYR0nAcwivrfOu4wu8dx5/aEUpU1DRiT6ZdeTauObgdZdt3UTJqSenhWMYl3ZpAywOo40xOzOzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNtT3VmSVZtK2NCL21uQVdPd3RHSXlLTWVaMUNTLzdkY056RXp5c29BTktY?=
 =?utf-8?B?OUNYdVl2bVZJNkZMTjNDTzlOOWRZWUFlQXlPdGJtZmZmNkpJRk5vRlR2aHJw?=
 =?utf-8?B?VVpjQ1kvV0RVMUFYMWhvVWYzZzJMbTRFVFR6VGFWOHY1S29YeklLNUl0blJL?=
 =?utf-8?B?d2tUVHZtRVAxU3NSaXVvTzRid1owczYwZWlLNVF6Q3Bzb1A0R2JuWG5ka3Rl?=
 =?utf-8?B?S0pZWXE2c1lPZmZBczVhUUNOQjY0Rzk5clpsNnpzYTFyT2NDRFEwWDFjclky?=
 =?utf-8?B?bWxTU1ZTVEozTjZBVHFraHhyMm96c2E3WVhVdDhrRFpuWGhlTG01RDE5cC81?=
 =?utf-8?B?QzNTK3RTWWtyOG5NR0pzOTJqQ0NMR3NXVVFDM3lOd1NUQ1p1QVNIdDZwQVZC?=
 =?utf-8?B?WmdWVnYyWG1WdmhQRDNwVTBEVnh1SDFlampLMTFRcXJ2T2dFNmJjbGpDZnNX?=
 =?utf-8?B?VjVNVnl4RDg5YnV6dnZ0M1h3RGowRXFmVEkzbm5HQm0xTE9udlhZb1BnS1hj?=
 =?utf-8?B?cXlZOEhjR2lRYU5IV3pHZW1IeGE1SEVZalMrdGZXWS9Fc0EzTTc1d0JaS2JI?=
 =?utf-8?B?TWZOVlFqcEhHZVhNZ2lsSnFyMEg4QVVXVnYzMzhMSWdaaWtTMlkxMjZLNXB5?=
 =?utf-8?B?SmVQUWcvZ0VYdGc0UktGQkZ6NC9LOVRzTEkxNVdPNEx2VkN6OUlObUlYZlRI?=
 =?utf-8?B?TEhST1UvSU1xcC9UWFZpTVRrK2hPUjFMQ1pZdTNic3Eyd1VwdG02OThobUZh?=
 =?utf-8?B?dzZ1RHZjZ2R2bHFVVlRkY2tEUXFlcG8zYVVOa3A3VXdiUzROZXRrSTlFV0Na?=
 =?utf-8?B?SFo5K0dobFJ0SjFUZ001TGJpUmo0cDh4SkZQMnBLUVlJWk5Mb04yQURESTlF?=
 =?utf-8?B?U01MSDQrNTdrbjY4aHk4dlJHNEZTYkQ5WC9acE1HejAwVWlSK2lFTStqeXBw?=
 =?utf-8?B?MHZtZTVJUUZvelR2T21LR2R1dG0rOVhWRkw1b2VQUVhlSFpEYUI3TnFpZkpJ?=
 =?utf-8?B?QnpqckpFQVpEeVBPVGMzT2twTkZEY2VwZ0p6bEgrSEgwSVFyUldGS0szRXlN?=
 =?utf-8?B?S1JLVmkzNHN2SWdpTjEwZUVmMEVvSXRIaDE0SERPTHlMM2c0ckZvZWFnTWJu?=
 =?utf-8?B?bjNLMzI5TUhyc21makFXdWdzY1c3amx5b1FzWEdSdEs3VGlIcEdUcXRVeE52?=
 =?utf-8?B?d2p2amxyT1lSVVpya2NDQjBJWm9mNE9iM1NnYWdhNnMybVRLVU51eFpORGpM?=
 =?utf-8?B?YjF2cTg3M1NUM2E2NG5LZTVsUXJ5elY2emozWEdxQlp6T2k3N0FSdDJlOUVO?=
 =?utf-8?B?YXg2ZENqVmVNL2s3VWJldHZnQUlDQnlrbFJEZ09kZnBQRXRDWmVOQnFYUHRp?=
 =?utf-8?B?dzRvNGlhRDRPNTlrYVpRdWdySHJwNVgyK1lVaXZuNHVIb1IzY3MxYktLa2t0?=
 =?utf-8?B?NENMUEpsUU4yUWhaOHZ1RDdIOFdkWHkzQW50KzNuR2xwaXBySG5jT1RheS9i?=
 =?utf-8?B?YUl0d0M2ZjYzaUhGbDRpNmdQcE1iVUJLWEVZenB4SnVIVTE0akp1Z1IxbTB4?=
 =?utf-8?B?clNqZGE0NXZDQzNzKzNMZTRSejlxM1Q2NlVlSm5nYjJnTFFQckxSdWxINEVE?=
 =?utf-8?B?d0R3UmxhR2RaclBtcVIyNW1tKzFoWWl5bjlSb2htYXQwWVFyTmpvakhZdzU5?=
 =?utf-8?B?TDlLRWYyMDlWakVsOVJoSzQxUDRtWGk2RENuSktpMzVKYnE2ZFVLbzhxN3Y0?=
 =?utf-8?B?dUdQM3V5S2o4Z2hwcXNSeDJsSjFHQ1VyemhKYnpSa21NTUt5SnBFTllQMFVM?=
 =?utf-8?B?OFNVd2VoMEpPWEJnbTY0SVZRbXRSVEc3cXdDd0dGUWh4blpsUlAxdEloTDJ4?=
 =?utf-8?B?YTI3K3VIbGVaRHFlWEFiTWRVYStrRGRQWlkwWElYWnNPeUs2RWczWFJXKzU3?=
 =?utf-8?B?RXo4RHIzM044SzNUTTJhVTg3R1lIOG8rNDZoV0F6RnZ5bVdRejh4WVJwQ2U5?=
 =?utf-8?B?aXpoR2ZSZTRWQUJ0dkhVSE9EbUtiVDdBZTZUUlcrc056WlFHT0U4L3FpUWs3?=
 =?utf-8?B?NUNZWjRQQ2g5WXpoWXN4T1FaRVJMNGVCQ2xNUVFQL0FkdEpKQ3BUa2xFQ2x3?=
 =?utf-8?B?a0s2MlpIL3JrWFBGK2w4OHhIVUdqVGJ3Nnk1NThqRGFmOWJXUUFrUjRhWm4z?=
 =?utf-8?B?OTQxYnZJSTVpYndScFJvZnlLMlptU1hMWGhJRmpuZXRCMG1HRmhkVjZQOGRZ?=
 =?utf-8?B?L2d4eXFuWjlhYkZTLzBYdzJIYlFQa3Z6UzNmbGZ5NzYybDl2bWpHQ1J1L1p5?=
 =?utf-8?B?aVNmZGxCeVJCeVh5UkRuNnRkUWNGNWdKV1I1UDB6M2NhZndacmRTQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 05569dd3-7358-4ba4-c051-08df1c28cedb
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 23:49:30.5533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGWq5dZRzRPyyD8SSGtNHRhq8P1/7aHz89C2ToZF1uM4wFwYGEfOPShumUx62fTFqckj36fu7a5O5IXszlc7jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7837
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

On Sat Sep 26, 2026 at 10:38 PM BST, Danilo Krummrich wrote:
> On Sat Sep 26, 2026 at 10:59 PM CEST, Gary Guo wrote:
>> On Sat Sep 26, 2026 at 5:26 PM BST, Danilo Krummrich wrote:
>>> On Sat Sep 26, 2026 at 5:50 PM CEST, Gary Guo wrote:
>>>> On Sat Sep 26, 2026 at 1:26 AM BST, Deborah Brouwer wrote:
>>>>> @@ -71,3 +71,6 @@
>>>>>  # Structs should implement `Zeroable` when all of their fields do.
>>>>>  --with-derive-custom-struct .*=3DMaybeZeroable
>>>>>  --with-derive-custom-union .*=3DMaybeZeroable
>>>>> +
>>>>> +# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
>>>>> +--with-derive-custom-struct '^drm_panthor_gpu_info$'=3Dzerocopy_deri=
ve::most_traits
>>>>
>>>> This is Tyr specific change and should be in patch 2.
>>>
>>> Why list all of them separately? Can't we apply this to all uAPI struct=
s?
>>
>> There are types with paddings which cannot derive `IntoBytes`.
>
> We have some existing uAPI structs without explicit padding; new ones sho=
uld use
> explicit padding though.
>
> But isn=E2=80=99t most_traits intended to handle this through best-effort=
 derivation,
> leaving IntoBytes unavailable for types with implicit padding?

I think the skip-on-error default was added in a version newer than what we=
've
vendored.

Best,
Gary
