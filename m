Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB6FC624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7892810E63D;
	Tue,  1 Sep 2026 11:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="w3JysBQo";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021106.outbound.protection.outlook.com [52.101.100.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4939610E63D
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xs/daYLpMztpMUetYfdfkdyNpvJAPsScG4jabicxLkmCiQaN49GGyZl14FD8ljDLEnxbTW9oQeQphf3PDnmNOEAduJQ3ltHNTBP7O1P5SN/GSJNXUst+Z9rKE/r8NSwUJABNONoOUMV2GaAjOe9Gmf1nIrfGZ/5EpwpUoHgtyo4he9fYW7vGeF6JHqqMi1r/qmIy0WSfgcxqT91hL/pIu1f4SNOguuuM8s6lGAXaXXAi+JgFOIGOJNCd/2kmaQQAeyF/vGnROXkn+UY1cfJZoSNB4Kivc5yumcMiVNocovb1RunTX0jwFPq2HyEFWzt2u0wMNpcc42bSGosN8bGM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxbXMap4DLhYPj8OK4PiFVb7S4Gs3APifNRqevZFZ3k=;
 b=hanR3uwVdAf2moOAwJLSELaJQ34hcF3nTH4011WlqYqUskfAfiq/uRh+QPSl4YmjxSHHMId/rJfIHm/+dfx9hjMrmqLAjTScNQfRUOFbWQpnWQgDSZM2F38+UqSwuGwvlmM3FRcg8p3RSr4NyIOroeVAmHIEnzRRtw8bVs2G0CGW2WZ6FcEbg4X77n1T5O9PmUYdUJ6ls9+oGHBYM1pdcqUw9OZDBbaUxUvTgFzw1ODbbhsN+NklsVx1/m6V8jteKCpJ+EuO5lCyTBbDkRtjyVJ0qCTFj9RqAjYPOS8WWDdrWalM16WilPEjnnKilCLboCg+DVRzNsmttd6U3pDJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxbXMap4DLhYPj8OK4PiFVb7S4Gs3APifNRqevZFZ3k=;
 b=w3JysBQokRKVKC5hbhpDf8KJGXtlYeFD+mzgKQXPVN6QnN/mQrq915Iz1843PCJ7oOL6Vv90zRohovuIfgmDrOUIwz+Hv9CPoixtImGLSKFnaRsevqb28d5xtsAZDEpJEuGwBPZw2QYNi4SIpQy4Uxofn5bAbebI6pIQXCGt9cA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9200.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:276::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:35:19 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:35:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 12:35:17 +0100
Message-Id: <DL3Y5NJRKISV.20KKTKSXWPKVW@garyguo.net>
Cc: "Alistair Popple" <apopple@nvidia.com>, "nova-gpu"
 <nova-gpu@lists.linux.dev>, "M Henning" <mhenning@darkrefraction.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Benno Lossin"
 <lossin@kernel.org>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
 <DL3F6EKL2F6Z.2DRXPQLYLE7FM@garyguo.net>
 <DL3WPTVM033J.33RWYCZOC67Z1@kernel.org>
In-Reply-To: <DL3WPTVM033J.33RWYCZOC67Z1@kernel.org>
X-ClientProxiedBy: LO4P302CA0014.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::15) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: db924f0f-6e93-496f-10cd-08df081d1983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|366016|1800799024|376014|10070799003|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: W/7xmZ9RWzmSIyavI8Tadm38UV3slAWqwwvzQ3c8B3y6n2Wrw1bQ5nh7DOr7NZ0FVyxVD8W2mi6skzyuFbrwb1JasSIznyzQAM3vlUVQw8A3hKCgP/RhYXY8+fvClC8kDt7brKYLgy3E87s1z3vbL5L3p03v+WsAOBwWslcY6oo4+xt3vD3ZS14KbcNx6XFAdrQx7Xl7FSAxUvubzfqdjpEA1Aw54O4q2+orQipVktxzvk6Vt8rYpa246qYm6SnzheV0QonHkqdT76cgw7X3JnTVTHJ485eNY/PT5MQ77laLQD+gRLdKRRQB0g2uZprA50jZzHhmHcJmp8EUJnB8E83+PsCelqzoULxQLvhGqG6WJOwc6RfQ+8YNfP5/rdxLLitkvPus4NqxV5Kvhv1jRosVW/NRCtRv1oM2fDA7f7wxHl9wiZNa6Dtu49AXWqjpVhjI5og06AaiezVZeqLWx9QnoIr9/7qZxl+hxQYzBn1bz0Qg/uWfdezlGP1FFeOHtvHqYw4n1C0ahtee9FlbRNSClAH6/pO90KnTvHJaRB2bjMGt+FgNJagvZSqkaZ0BZDCXsx9nwtLfbtsmJNiK9/bUjrbadc6zqf23F0xwILO/GTAQ+FZ7MWmIjSN89lCiwFAV0qli72F2sbAYzQVkKI4FwwOCWHUtJ0noDf3d/y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(10070799003)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M21vR05ZSm5JTWZkc3g4dlZobklRaVROS3E4aDJCWVFNK0ZQYk5pYUpBZ0h1?=
 =?utf-8?B?QVhxNFplc0w0T09YVEJXVWd5YXFCb2crbmdVUDVRcW5abnc3MUtXTUFiNFg0?=
 =?utf-8?B?eU1FalhDWU0xWnE5aDY0dmt3QUtmL3g1azlib1pjT3RoNHlMeUpOb01UVjRW?=
 =?utf-8?B?WHgyN1BJSS90QSs4c0kyMmxqblFkSi9IZ3ZlZXcvUDc1T2tQNDZ6VWZ1UkN5?=
 =?utf-8?B?c0dicm1CcnJuSDlUb3ZiOWd6clV6eGFMZnhlYVhOd3c4SnBmMHZwOXFIcWIr?=
 =?utf-8?B?NlZoN01hdHBIV2ZjemEyQnFjOVpPczRKeW5pUEdNWjNJNmw1U2dFKys5Wm9l?=
 =?utf-8?B?dzhtS0xqeVFQbnltUlVJMUpVRUU4Z0NuL1dZekJMK2N5TW40bTl5eWUvS3Rt?=
 =?utf-8?B?TElxbS9ZYmNPaDdSSnFiMTloNVJBM0lmang3cXREWWw1QUIxcWtxbzMvSWZ6?=
 =?utf-8?B?Rk13SWs4blhnVEQrUVpZNCtGOFJxZVhxNHNMcnZGVzhzTzU1RmJhajNlSVBX?=
 =?utf-8?B?Y2NER3pPYTB2ejh4NXZKMnFqVEZTOGJTSEcwcC93OHBQZ3JnU0JrejQ3Q0JK?=
 =?utf-8?B?TnAvaThQa2NEaW9mVFIyQVp2d2daYUQwTmEwWEJ2OXVETTVqSWU3YmRjSnZz?=
 =?utf-8?B?bWdoVEJlNlliOFZneUw0bGpuZXZHK3kzVFV0cjBVdXpXWUsrb1FIZTQrQjNO?=
 =?utf-8?B?QkhKSTM3Vjkvc2ExcmNqcTVjTERwMWFvaU16TFc4ZTNDMjFjWmpSbUs3MStx?=
 =?utf-8?B?b21Hd25DUXNNQVJxZURVSFpMU1BteVd4d2ZNY3ZWd05pVkpIenh6RUMraTht?=
 =?utf-8?B?RjcwK3dRNjNhWGN2K2ltU2Rodk0xZ05SV0lLMVREUURPYVNEUXZGd3Y0MlA3?=
 =?utf-8?B?WmJ6L0VZN0kwQ29pVlNXdENYRlZWa2VBNWVjeFRHVWRhUUtNQnl2Z1J1dUo5?=
 =?utf-8?B?OVN1MWtEZ3lNSXJXOFJnb1pIb3ByZGs2TEpMZDRuRlBoRmJiQndzemxET0pG?=
 =?utf-8?B?QUhtdi9oeDVjOUJZZnRqNjBCWUxMWW82Tmk1L0EvSm1URWxGVmFydHlwL2k5?=
 =?utf-8?B?VTRuTGtHelA3eTVIdXlic1Q0V1c4TEhsM2NwTndseS9rcE5Zc09SeWJwQW94?=
 =?utf-8?B?amdTY2I3ZFQzTjlKM0xCNEo3ZlZybHZwZzZXWVdOMGFPYlc4ZlhIWlErT1BR?=
 =?utf-8?B?L0ZEOWJTcDdkc3FlM0lqQnJtUnpGRVk4c3FkbDBNOHVkN0hLZE1ESEkxSk9z?=
 =?utf-8?B?NVFtMFQzSzJyZGpLLzc2Qzd0VEVPa05yWWh6ME9wVWRiSnl3bGJnREJtQitn?=
 =?utf-8?B?YlB2YlFXYkZreFpSWVVKNXhJbnNTZmFRd0FwTXhVTUNQTWZUeUtnYklwV1hv?=
 =?utf-8?B?ZENsNktmN3hWekE5RzlBdmdaTUhmNUF3Ujd4YWVRbnR3czdrelNvNzZ6aXdn?=
 =?utf-8?B?SmlxVytCSG9NbzVjZ2NuY21tcE5yVE8waXVxUURkM2x0MzJoQjhGcVFQMWhH?=
 =?utf-8?B?YlF5YjZtdlZ6UU5BNWk5dFJqTGpGOTFDT3lnb3BHeGlQNlVxRzlUc3BUSmJ2?=
 =?utf-8?B?ZnJWdE9LMTRJT3lKdG4wOGdBbm9Yak9QUTZnR0tIUU1sc1JVZ0p4Y1RwQWNo?=
 =?utf-8?B?MEt0OHd5a3JOTDBqaFlXYWxoS2ZuSnZxYWlvL0N6dTY2SEw0SFlnLzBZWUlS?=
 =?utf-8?B?NUJ6bzA5ZnRZY1JvbkdIaG50UEJIdlJnYkJSZ3lya3M2NiszOTFuYW5nSEEy?=
 =?utf-8?B?NllBTUV1VytYc0dySWNYc2x3enJlUm9BYUpZaUhmOHBpRGZGNExnamxoNG0r?=
 =?utf-8?B?UDV5Mm9Kand1T3JmWFZXZ3liN0RqWUtOMGEwbVhkMHhYREw1OE1CSVFObTRS?=
 =?utf-8?B?dmk0QkFhRHBaVjhtS1JDVVlJb1dRdkt5SnNWUUFiNC9rUk1aS1QxNjF4NklQ?=
 =?utf-8?B?bFEzN2Y1UlJIZjQxVUZmMC83cFZMbXRHNlNZdnFtbnN1YXR6ZFc3Z3Yrajd3?=
 =?utf-8?B?aGZ5L0w0TG5mejJ3VFFrYnZpZ0Z2THNaN1YrQ1h3Zk4xNE9OVVdoU2lpMEhP?=
 =?utf-8?B?MGcyd0k5TVR0QlE0Ti9HR3l6V0JKNDd4Y2ZqUytSeFdZUmdPZGU2RFNRZFB0?=
 =?utf-8?B?ekNnT3d3cGRMYk1Tb0phK0wzMVA1NEYvM1VoaE9NTEpTMUwyQVhRR2kvT0pM?=
 =?utf-8?B?b1BDeXhXcHY5d2M1NllhdjZaVnRsWUtobjBBMFg4cGtjaE45N29mUHkzUlBQ?=
 =?utf-8?B?c3p2bFllSnVHd1JIWGRtNkg5WmEzNzJITTdpdUZjbXE4MTBpbmFBd1k4MVBk?=
 =?utf-8?B?Q056L1NrbmQrcStrelVUMWRnN2VjMUg4SzB3RzU4RUtlV3pwT2ZJUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: db924f0f-6e93-496f-10cd-08df081d1983
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:35:18.6481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKKbEXt5eJh2gdkvqDPaz7nG9Xceg6nXyM5T0ybuyuwdUKKKQymLCeVlGp6tQpE9P1QU6e3UXwLv7sOvYsXI8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9200
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

On Tue Sep 1, 2026 at 11:27 AM BST, Danilo Krummrich wrote:
> On Mon Aug 31, 2026 at 10:42 PM CEST, Gary Guo wrote:
>> I think if you change the signatue of `registration_data_with` slightly:
>>
>>     pub fn registration_data_with<'this, F: ForLt + 'static, R>(
>>         &'this self,
>>         f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
>>                                     ^ note this is changed from 'a to 't=
his
>>     ) -> Result<R>;
>>
>> then there will be an implied bound available inside the callback where =
'a
>> outlives 'this, and thus the function callback is able to perform coerci=
on of
>> any T<'a> to T<'this> provided that `T` is covariant over lifetime `'a`.
>>
>> [ The coercion won't work when doing abstract `F::Of` on the bus abstrac=
tion
>> side, but for any user it is dealing with concrete types so the compiler=
 sees
>> specific types and thus can check variance ]
>>
>> Then your projection can just be
>>
>>     aux.registration_data_project(|x| &x.field)
>>
>> I haven't tried it out but I think it should work.
>
> I gave this a shot and it seems to work out, it's a good simplification. =
I think
> we don't even need a dedicated project method in this case. We could add =
an
> alias for with() just to clarify the intent, but not sure that's worth.

Right, I don't think it's needed. It's just a typo in the example given tha=
t I
write "_project" instead of "_with". Unless you have a case where it actual=
ly
needs `&'a F::Of<'a>` instead of `&'this F::Of<'a>` (which I think is not v=
ery
likely, changing signatures of existing users should be sufficient), I thin=
k we
should just modify the signature of `registration_data_with`.

Best,
Gary
