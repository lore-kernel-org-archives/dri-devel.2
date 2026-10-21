Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BC606BEEF
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qUYTNJhh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC6710E1D5;
	Wed, 21 Oct 2026 03:23:21 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBE910E1D5;
 Wed, 21 Oct 2026 03:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umT6AcT2lFKnmMlFtVjem+txcYXnUO/6xfhR587m8CbS/P8PhXUKyekU/npkthmdEUQAgx+mKJQFkniCyjAe4qSKT5R801/nVSkE0Is8t5hr5cO7Hd/NxXlwJ9dSHNzyZGQ3aljiePZM79qakZvb8FawwV9Vcx8XUOBd66Ce0PJx3dlWKEyQcDKYqhpJhO3VPG3ewldq6yrwkTHlG+Br/i+v7frjQrv+ha7AOs/Frct87nQkEYE0mPxMFzjpJI4ANZXSDIxrmHp/BhGugR27pAE/QWG1vkAt8GUNfQZIE5b40ARE9Ru/bLsQIX1hKh+sJDWQTGRrFccEMUtLNhsPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCQoUvmtuJQV2yhYxTzMWpR/g+GQ58OYLU9+AaxW3b0=;
 b=Xp0Yy0bPkXumdt6OX8+MLN4BP+R/7gRccq3SMHDBGk0E5Y4Of+QBNhAYAlxICOl8Q9EeM46UVY6HeTyfCjvAPAqSUQu8l7v+2DsTjrtQ4F1/laHYt9HypP0edH74/73vSBsfmj8UtoDsMoAW17n3bM+R5QBtC/ahkcTGFxtQUfSRabBR0VFpQ+HUwsl43uXepKOfrFQYbebmXYfOTNpnP+B3Mv2K1nLWRnqvTLX02hqG73u9n052iX1d+odeXG2nFUVPXeM8fZvEChZBbd9aA6SDluqXOmXtoiin840VjaElzR5Vb2yPhTcq/oAyUMIfS83xPV9yT221C44rIamf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCQoUvmtuJQV2yhYxTzMWpR/g+GQ58OYLU9+AaxW3b0=;
 b=qUYTNJhhwhSv6oFQcZXk2TCnOLr3XfYb4G+oV/uwslxU4NKcSQV1v72/UT3m3W8JZh+4RlDxVTXH8kcoIdOtIWoaefjSqMCRolgk4UGWZBbS24z3D1WpzSJjHbC6Vf5PrUSERO/hiTmno6VY9t7dLptEzHNTJIlCZAoss5tBGGyXRLJ3FAi3vwK8J93zvQWolFSENXYrhrK6gUxxyEtCOHa1IJaP5sb3mtF6NOiZgPiLUDPsv8TXVN8RiibbMVz56px2CjY6bErNu0sFLsa1CztzfUa0bPn4Z4YdPNC9qhfBONq81X/zqH3xJHtb382u/UghGGMCMB3gpJcGT5lFqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Wed, 21 Oct 2026 03:23:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 03:23:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 12:23:08 +0900
Message-Id: <DMA702E74W05.2L7ZRW1M6H3NM@nvidia.com>
Subject: Re: [PATCH v5 11/14] gpu: nova-core: gsp: cmdq: use consume_element
 to implement drain
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <ojeda@kernel.org>, "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
 <20261020-cmdq-rpc-v5-11-dceeb8f360ec@nvidia.com>
 <sashiko-outbox-178822@kernel.org> <DM9QI47QSJ0L.2QMRVD4AP5WIV@nvidia.com>
 <DMA6GSC7REE4.1OL8XYR8JKJ3C@nvidia.com>
 <2cedd65e-514e-493a-a8dc-cba683c84fea@nvidia.com>
In-Reply-To: <2cedd65e-514e-493a-a8dc-cba683c84fea@nvidia.com>
X-ClientProxiedBy: TYCP301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: ec90e38c-a4b6-47c6-dbaa-08df2f22a2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7416014|23010399003|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: j4J046V/29zoJxZYsk7SVe1METlfrqePgxCshOtbJ/hf7KCMgv6rELrny+033T8T8LqC3lbFMVu0bsVB5mEPSfTvIBw09eKDXea/MLC7kw0mf4IoU4ZD9wnA8h8kvDZnXoZDX8YWu1yrTlxr/9inNEDQdRgJD7gD0zw65hpOyXgcC5fl+46RHtgK7fQacgGNNOy4seq47kvCAwGzNJ4fed6BjHQ6n2icUeWy3WTHTDMr5jNyLOFQE7EPAr+dY1MrRc3trbGAXXQrVnJkurQJRcSUYDq1JuW3pSHzlDaOHJ/5dPQJKjIKgCn3ydTh0C457+oWPCkrX0iBUUlUUo3Zs7QfJd28Uef1KYyA5K5qZn6KfAn81xntW4RP9A2JxPl01bCtvixnWICknx/Al24xN/oqTbmuuMqLiSya0QQDDKTn6iOBsUL1Leb2pIrlYZ3E/2ll8DLvxuSVSt4nUtPVfvyvuisvAwFpOjMEHg/jfjadnUu+VDwpcwKzF4tfW2ApA9uGIfOrYg3G+befLDIfGV3g4zrS+8ISOyZIfEV770ZJ/zOCgXcOiDLOWsgz1Ddg05H4Gp0PjRjGyNfH5n6OuSB9tvrXU+rHzQBnyrjQo+u0ASCmVdl7JPqwNTE9wM8qnRKOEhao74LSeXMD/ikm0WsHU84CgHbLutrtBXcJD7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWhpR0ZrSFMrZGgxMWRMOExiQWl1U0RXdjlXU0FvbG43UThpb2Ntd25pc3ZV?=
 =?utf-8?B?bTdGeGUvY255cTJkNFk5enVTNTZmWnBjZmp1a1ljNUgzMGYxbjU5MUJkbW1K?=
 =?utf-8?B?dncrNzY3emg4YkxYcXBBam93ZGUxcnB1b0FGOXZRSmxRN1F2cDVrVFh2cFR2?=
 =?utf-8?B?RUw5dkFxVnBxL296NWhXcW81TDVBMGtFYkJiUDBXWVRoQmxiRnhsaC82aWJ2?=
 =?utf-8?B?cVRmMWppaklxRGw0cGNUNG9FZ3phRVV1YTVsTS9OUWd5Wkkzc2JzNUZlamRP?=
 =?utf-8?B?RlJWL0NxbllIVjNIOHpnRjl2emY0MkwvdHdtUVZBdm56dk9tU096S1htczlk?=
 =?utf-8?B?bW1wSXBMUHYrU0R0SlRWQzRwR1BaNlpVd1RxYXZNaGYvV0NlVzZMQy8wY3RD?=
 =?utf-8?B?L2Q0ZG1YSGFFY1BzMmhzYkZGK3ZNektGZDYyaythOVFYOTRBRHlzUmJ6cS9O?=
 =?utf-8?B?dTV0UWVvRTZrMDk3TWxDTGhYcXBxU1NKbmdGVWsxREgyYmFUYTBmTlVvOFV5?=
 =?utf-8?B?aXA0ZEQvSjFPeThZaVNjYzlqZ29DYWNVZW5NNzE1VGxiSTc5ak1DUU5waytk?=
 =?utf-8?B?Z0t4RzhZQTZhUU83M2lNZUxWSjVFQmRxU2pMU25XWlhscjZVbXZmWFhKQlN4?=
 =?utf-8?B?Ym1xTFhxcndSSW9WT0pHTkR6dVYxTXVMUzQ2Y3JDM3pPdUxOaEhuNnl5U1g0?=
 =?utf-8?B?YmlpaHNTbEdjampQMi94ekEvVWorcnNXbGVmNnYxTVd3UFlmS1VCVFEveWU4?=
 =?utf-8?B?VnVmMUdDQVR3aE9pKy90bGhmUDk0K0R5OFZ4YldnUG43eFZRMzRaVnpSNmt1?=
 =?utf-8?B?YU9yWDU0RC9FZURxaXhDOGtzUk14RUg3NVNUUXU5eldtcEJFSE9wZVM0VTR4?=
 =?utf-8?B?SXo0Qi92K2JwSi9EQ0trRnkxOXNacW16UG5XR3ZjTzkxc1FjaXV1UURDR05S?=
 =?utf-8?B?M2QzTXRlNGZnbmMxOFExZEJQazZqN0ZXQXplUnM0blVyYjZxMHF6cnVlM2xp?=
 =?utf-8?B?Q1FnU0Y5aThvYm9tS1NyRDViM2lYcFUrY2xEdWZqMDhCQTJJUjZQMFRHLzNZ?=
 =?utf-8?B?dkwwdklXa1hPNUsrWURWU3NxeHg4SUNUV3VOVXUzZ1dvNW9QR2RpNzY5SEZr?=
 =?utf-8?B?U0hhbHc2Y2grNFU4UTZiM3BVN2FOMGtsa0lkY2VNdUlialMvSmFoWm8xLzVZ?=
 =?utf-8?B?UlU3WnJjZkNac0lOUk9wM0ZnZjNRTUt5RmxweGJsc05KU1QreGZKZm1tOXBC?=
 =?utf-8?B?NFlxcUE5N0FJSno3c0hQMkdmUENUTFZyNHZ3Q1czcjJDN2huQ3diNklUSDM0?=
 =?utf-8?B?cm91T0RGUS9TSmJUQW1lMWgvMGhZL2lFZ2l0N2pSdjV5dHRuTER1TWhGRytI?=
 =?utf-8?B?eXBXWDBoVkNDd21DQzFkYlAxdUlKRUhISDNGSVg2YnhvUkRNQ09Oc0hGQkdS?=
 =?utf-8?B?emtUdjRrU0R3YzJZdHY5cGEyRnNBck9FUjFRd0FMclo4cEtWekduU3I0NTZx?=
 =?utf-8?B?WXdHL1hFZWttY2FrN0lNQlBaQ1c5dHBIVkJnWVVzVGM1S3UwTWNoTDV4WDla?=
 =?utf-8?B?UEtXMFQzK3Z4eUJ0aGZtak9keThKY285dk9FRm5OeklWNlJTbVhza1NuMkg5?=
 =?utf-8?B?cU1PS1o4eWs0czVsVGU4Z28ybnMwWndPYVQ0WjRyS3Z1eDVsZjU5RE1COVNy?=
 =?utf-8?B?MjVwOHhWOHcwR3FVWVZ3dUJheWZGWlY0Ym9qVzBFK3pZb3lRMnVlTlQxRllN?=
 =?utf-8?B?aWhFSEhZWFF4YndHVy9XaXRBZ0xIWGYxMmlIRWxhL2pMRzRRZVZpTjdQbXo2?=
 =?utf-8?B?UzJCZ0hMeVlTRyttQU5TaFhVUTY0SGZzeGhWYXhHL2h2ZXB5RjdJMU1KTzFk?=
 =?utf-8?B?Z1VRV2ZrZFY0VmZUMlZuWTRiVWtBS0huNVVCS3lLeS9xTDR5UHAzMThBVzla?=
 =?utf-8?B?bHRaSzBwQTRRN0R3a2VtdVVZWHY0ZWpjZEw4dmhDQncxeEtpMEQvWU1RSldU?=
 =?utf-8?B?UEdQSzVOeDBacGlCN0hMd3ZxMW5aaHE4SEMxVnB0dkxKNmlSS0Znc1NmdS9Y?=
 =?utf-8?B?cldWSGQrdTFGOHBpTVZLaUdkcXR0bmswZjdienhnN3pta1lQd2NMQ3RyVnp2?=
 =?utf-8?B?MnF3V2ZpTjRrTFBINmxjOXZxZEVheUgxaktTRC84U04wMnJrNllOQ1hzWmtS?=
 =?utf-8?B?WCtpZUYwTWl6NlRncU5qRHB1ZVZhWWZCeEtxenFUQVUzWWJ3elRObVVPZ0s5?=
 =?utf-8?B?am1pRDQzYk9TNGlERENSaStER2Qrdm1COUk5SGJHL2FIQ294Yjc4MlBINFBU?=
 =?utf-8?B?MjA3dEJrZy9RT1pqOWNPR2h0YXdzWm9FcGpWbmdod3plakN4emRtVnhUdmJm?=
 =?utf-8?Q?VD/i+0vXV40IunhHrUbPCvDyAB3yp2VXrWlZr1O59rpYA?=
X-MS-Exchange-AntiSpam-MessageData-1: /ZDnVdO3y+RnCA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec90e38c-a4b6-47c6-dbaa-08df2f22a2a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 03:23:11.5323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7X5lswJDjWNhV9s6Gvak3Wg0RMAJB1kRRiiv4aMrlDaSwtY6v52p05Va2CXQXXW5aGwSbCFn0nGkwhsfcihMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Oct 21, 2026 at 12:12 PM JST, John Hubbard wrote:
> On 10/20/26 7:57 PM, Eliot Courtney wrote:
>> On Tue Oct 20, 2026 at 11:27 PM JST, Alexandre Courbot wrote:
>>> On Tue Oct 20, 2026 at 7:18 PM JST, sashiko-bot wrote:
>>=20
>> [...]
>>=20
>>>> In rust/kernel/io/poll.rs:read_poll_timeout(), when the condition is
>>>> false, the timeout check uses a strict greater-than comparison:
>>>>
>>>>         if start.elapsed() > timeout_delta {
>>>>             // Unlike the C version, we immediately return.
>>>>             // We have just called `op()` so we don't need to call it =
again.
>>>>             return Err(ETIMEDOUT);
>>>>         }
>>>>
>>>>         if !sleep_delta.is_zero() {
>>>>             fsleep(sleep_delta);
>>>>         }
>>>>
>>>> Because op() only reads two u32 indices from coherent memory in RAM, i=
f
>>>> the monotonic clock has not advanced by at least 1 ns between
>>>> Instant::now() and start.elapsed() (for instance on architectures with
>>>> coarser timer resolution or under virtualization), start.elapsed() is
>>>> Delta::ZERO. Since Delta::ZERO > Delta::ZERO is false,
>>>> read_poll_timeout() falls through to fsleep(Delta::from_millis(1)) whi=
le
>>>> holding the Cmdq mutex (in paths like GspInterrupt::handle_threaded() =
->
>>>> Cmdq::drain() and Gpu::new() -> Cmdq::drain()).
>>>>
>>>> Would it make sense to keep the while
>>>> !self.gsp_mem.driver_read_area().0.is_empty() loop condition around
>>>> self.consume_element(Delta::ZERO, |message| message.log(self.dev))?
>>>
>>> Mmm, that's an interesting one, in that I am not sure there are any
>>> concrete implications but I'd like to fix it anyway.
>>>
>>> I was thinking that maybe we should add a special-case to
>>> `read_poll_timeout` so it returns unconditionally after checking the
>>> condition once if `timeout_delta =3D=3D Delta::ZERO`, but doing so woul=
d
>>> make the `sleep_delta` argument moot so I guess that's not adequate (an=
d
>>> the current behavior is technically correct). So I think I'll
>>> special-case nova-core's `wait_for_msg` instead.
>>=20
>> Personally I don't mind the special case in `read_poll_timeout`.
>> If you say, I want the timeout to be zero and then it sleeps, that
>> sounds like wonky behaviour to me. I think it feels weird to have
>
> Yes, it's odd behavior by the function, but on the other hand,
> it pairs perfectly with the odd behavior of the caller. :)
>
> Let's avoid special casing. Just let the zero flow naturally
> through the function and leave it alone. Special casing should
> only be added in special cases!
>
>
>> this special case w.r.t. `sleep_delta` only because we are using
>> constant values and that's a common use case. TBH I think it would
>> even be fine to change `start.elapsed() > timeout_delta` to
>> `start.elapsed() >=3D timeout_delta`, then it's not even really a
>> special case. I could try sending a patch for this.
>>=20
>> I'm also fine with special casing `wait_for_msg`, but personally
>> (maybe) sleeping when you set timeout to Delta::ZERO sounds busted to
>> me.
>
> It's not necessarily wrong, depending on how you think about it:
> "sleep, but timeout at zero" is something I've seen used (I forget
> where) as to mean "context switch away", kind of like a cpu_relax().

Here, it only sometimes sleeps ("(maybe)"), depending on the resolution
of the timer and how long stuff takes. So it's really pretty
inconsistent IMO.


