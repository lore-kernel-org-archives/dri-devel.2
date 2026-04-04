Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F592E88D8B
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 12:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5560C10E0D2;
	Sat,  4 Apr 2026 12:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="xh74TMsm";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021106.outbound.protection.outlook.com [52.101.100.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08E110E0D2
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 12:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwPkOdV+Wdzk2HtOKcaMwdZoTWOnCbKkQGypig42fnxCdBFyUXRBir/+LSs+4icSyRmtt5C4OHcSC3wl+N2Q+vPASd5KCDeohTrdjKBLsVt2e+Bw+NhBh2YGYfSzvdt/6fwZ952VSs4ZXnYB9LivNcjfb8zMnxEMAdcAPc9al2zv4Ik+tnUmutQunxKrHLd2IUMnBKRqPm97KmXcbgMZ/55S/ThOAAwGY+dF4vaNotvwQVg8wBkQ8IrEsvJcduDLqrlmmVRvg57ZPm0KIjzK3Wq+WY6bnx0q+Yc4P2xeMEfYJ8/T20ovHC2AWu8tk10wU95UkyzJ758BZcb/VDOy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e53BmCzY8P7EwxjMxlY8OPFsK4Q7nGr14sbTRwWuvw0=;
 b=CVNQDmE1p5Ph+RvIcNKUChTLIiRkoDeEHgSm8j9DqwNOt/sgD17KG96Lx0S5Ye8YNdDdIG1mfXy49ECm5A9RiAhnNyWTzla7/vOv5UMbnqTrdXqLUKv457BEGV4Na2ZrqD4rWCoNd7jBrnO4OdJFmDOM3cVlimg+VpsAWopQJb77SUNNc0Doku8dcqSILU/aov+YO3jcqcKTm+PsdAVeJOM9Q2aYQX70Hom2CF9dRNVU1wHERPgpsax1SDQpSpSXW8FDLA1g9w7wO6wI3NemDQ5u1xj/F/x7s4oc+YZY9LJWeBwoO4nfjJ7dvb2t+3fKCj2wY3KyXTi/DqfHVJqDOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e53BmCzY8P7EwxjMxlY8OPFsK4Q7nGr14sbTRwWuvw0=;
 b=xh74TMsm9OTH8QhgfQgsB2I+Hd8NyUursW09nrnFEKWK0vRi12bg17AwlPrIHsupF5nWdcVConkr2qEgqNLbJUlJPQp/qanjBtc/Qb6RFL2EAA+cm1FWl1WSENEuuHbB5cb+E3xWdLsDob354b+oyjVEpJzPaBPDARwOj43/GP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6438.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Sat, 4 Apr
 2026 12:33:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 12:33:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 13:33:15 +0100
Message-Id: <DHKDGB6976SV.1AEXIZMSHY2O6@garyguo.net>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
 <20260401-cmdq-ub-fix-v4-2-a9a9cf982485@nvidia.com>
 <11466450-aeb3-48d3-a86f-934346fd4172@nvidia.com>
 <DHJXK4PAD7V0.3UYK35FDHRNIK@kernel.org>
 <DHK3C0Q5NX6J.UGQ9SCBYSCRJ@nvidia.com>
In-Reply-To: <DHK3C0Q5NX6J.UGQ9SCBYSCRJ@nvidia.com>
X-ClientProxiedBy: LO2P265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::31) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 494dff07-a146-4e0a-f424-08de92465816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: KAWabeF3qOfuyBd1MbhTbbzcIOTDC5Z08BWNECscNMqvPJYHcy7CwT97qGAow24CDSm3vfYzrBsz9Wgobz5qoDqg/0Ad5JB0Il72X1GWrdVmHqQfUlBqoF42/ymkvwHua07Hd8M8y9L/dYVuRbbLLiTG6HH455/Aw/+9JIfT0u8F5yowGjFRa4n35fxJ7raewnaNq4X4OPLavU7eL2FYsaHT9s6dgWeA9YNg6kboqfmkq24Yf+8/r04O5zI1PnsLWJoFMJDSusw9BH8b7Kuju/JMfvE19pIsHGzBiW0lOIyKSh9aDT9jtkWtUtLjV9RhUYd6c+bfh6j7dXAa8JMFNUMC7oFra4uyOekKRnpYEeZBaFxqo+97t5EQm6oPLn2xNW4/QfDxOp9UETPUOIr0JlcP5IHsZfXSefujnL5+RfW+OIYjRZ6kaBLSLYVAC9oKSiFA0HBeGXtQxNNywSngp1U6krZSxUocuqloIjOM/55yFrMgvc+r8QIHrnCNai5ovI3hcfjBV3ZrfIqTHxt8BKMiFhaot1F8yWdevD26rTUCAf6BRrbrIN9KCGKtlsfGdJmoUH+BVwXbEEbZtFUnBJCImcwWR+b/tsXJC+rYqzjbAuuR4VtM5yOAtpI73AV70l3Mx67iYyD9LQLuQJdeATSbc8tR/E1O1fTSSIwH/RnoDNJT2EJp3O6jlK5Heojm0CZafAcE0MsRG1vsjzJodz/QzqFz0MvxUREwhuqOk6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW01cUZQK2llbnFpR0F3Ykd0TEE4bjRFWVczQ2hUcjl1Y1FRVnN6ZVZZckdW?=
 =?utf-8?B?c2ZEdW9XR2Rjd3BYOHJ4NHlnZ1EyVmpSLzVuOHI2VVRiRHJ2TDBqNE40ZjMx?=
 =?utf-8?B?ZTEwZy9mbXpiNDR3LzB1dDdjVGlSUkd6QWx5K3RZdFhkYnpZam5qYVZja1JT?=
 =?utf-8?B?dnQzTGdZejg4NjlzblUzRGVON00vNmltYjlCZlNFeFlDcmVwc2RzdEdlYzNH?=
 =?utf-8?B?ZzNtUm1IcUFDWTRRQk5ncDhrRGtvVmd3R09SSk5LUmk0SVU5Q1JVMVVWV2E5?=
 =?utf-8?B?WWJhTVJEKy9MaUhVM0V0RjBwK2hEQzZhbUdjTTg5czFVekJKWnFYaXVFT2dU?=
 =?utf-8?B?K0ZONmN5Z3F4TG0zVkdVVDZienU5Zlk5M2xpYUdsK0tHL3MyVFI0RG8rdXdH?=
 =?utf-8?B?OHVJTWUxUHZFc0dkcEVYczBKTjdSa3FnbFBkU2RORzRpd2NmSzhCcU9VQW1v?=
 =?utf-8?B?ZlRxdytZVExnRU52d2FsYkJnejd2dnRtYlQzT3RRV0x6OG5CeTI5TG1vcFVT?=
 =?utf-8?B?Ykh0YldGVW0rSlFWOFRtNWs5OG9KY09BQmg2eHc3cHMySkNCbjJ6WG5rVUky?=
 =?utf-8?B?WmtUb3JFNjEyTEFaQWVrOUl4T1JKVHlEYzNQSUZWNkR2Ynk1V2QrR2V4OWpJ?=
 =?utf-8?B?WVV6TStxUmxFV3JaNWZFZ0RLcXN6N2E0d0U3VVIvQkZTckozREdyRldnSXV4?=
 =?utf-8?B?bmxuSEFuQW5heWt4MVlmZkJESHVFN0lNbnlPdTFWdFE3RkZiV3g4QXo0MmlE?=
 =?utf-8?B?YTRaUlZTYldIbklSNERqcEM1SmdROWZpbCtNZzQ5ZEF2ckE3QjNxSFRhc1NP?=
 =?utf-8?B?R25OZHRLR00rU3dCd2I1N1dFNTZjN3c5aTIrZjBFZ3k0UXRCb21sYTRTVzNU?=
 =?utf-8?B?Y2hyN0NmeEpVYkFkQytLZnFkQ1RIU2NVQVZGUkk3Y1VmdGlybVloQTZreE9h?=
 =?utf-8?B?N2M0M0NNWDJLTmdkclN0U0M3M2RqYWhxck1tRVFOWjQ2RWFXUGZMQlVKRFZz?=
 =?utf-8?B?Tkx2elJORUlnVjZlSVFFY3hOWWpVS3l2SFVxaWRhL3lwa2lkczYvbHRLWEVz?=
 =?utf-8?B?a081czlUZENwTXhFTlo1d2V0OWNJS3I0Njg0WVpXelZybDMveGVHZVZyZTdU?=
 =?utf-8?B?K1RxQ09IY2VoRFZkUkJTdWRPNWJjdXo2d2tPMUlUcnlQVURVazN0UEwwMFRp?=
 =?utf-8?B?WEpCNjRDcHhzdzFVWTdJYUFCQlE2RmxEUXlWdFdLeEFsSkVwNWVjWTZVOXIz?=
 =?utf-8?B?ejdYRjlrSmVjcnZqeUUxVDI1TXYwMkFsN0tkUVZNU1BVc09SR2dCcW9xdFAz?=
 =?utf-8?B?RmE1MkpFV2UzdHJ6M0prUDB3Nkk1dVYrc2J3aExsWXVhVzNOd3dQUlhZd1BZ?=
 =?utf-8?B?bkRWTUJOL1dCUGt2YSswcWNHcVBKdkdXTU9DL09oTlpEVmIrNHJQUzZpU0Fx?=
 =?utf-8?B?U2paT3NWMDgrZ3lrbHRxTnVxOC9FSXYxTDdOOEdDbm5SVnh3QU1OZjJoQkRy?=
 =?utf-8?B?Ni9pYjVuVDJFMncrc200anZMd1ozbU1id2FaTHJqemtXSUtscG9vQTRWTmY4?=
 =?utf-8?B?L2U4eER2b0t3a3hCOWpLL2REMmFVQk9OUjZRbGtiVXpROHdiZGxNUjZKbEkr?=
 =?utf-8?B?UVllT3pHYzliUVBVOFpzbHc4NERQL2I2NU1DY1RaVGtiMEhvcm9YcWNVOUtU?=
 =?utf-8?B?K2NXMWRXZ2ltOUJYeDJWOGFZbUpqeE9ycmt0TXFrbWw5dmxURHZoMU10VDhE?=
 =?utf-8?B?bHNYN2VlNnhDeTArWjhleXEyTkVvQXo2NXVzZGNuYnYvT2pvNVJrRERBUW5X?=
 =?utf-8?B?SXRVNjFXUlpTSm9TUmtuTTZGU0Joc1NPZFJzdnltdE51c1ZGdk15MEFsMVZs?=
 =?utf-8?B?U242TGF1eUtXc2JuWTYvUDBSK0ttTk52a3QwYVVZQVJUQVdCdDhZb0F0dWo0?=
 =?utf-8?B?dGRXOWMybFdRUFk1VXlFL2pHQnJnQ002MTdvTlU2elBVTVZqT1ZIamVJRHJ2?=
 =?utf-8?B?Z0xnTG01bzduR0tjVkRjbmdxcDB6S2MyQkIvaW1XMzVMQmM1Zyt2aUp5Z1ZP?=
 =?utf-8?B?WG1wWWV4dEgybkhWUW85a2JHSTVaYXVNSk1hNEx3SEIwOHlHVjVEcThJeWNG?=
 =?utf-8?B?SDBpWDRlY2Jldm1wRi9qK2g0NlBFclplUzN5cmhGamNkQ0VaMFdJWkpjSHRi?=
 =?utf-8?B?NTgrTTVsWElwTUFSZzl4M2J1U2xscWpZMElzMUVxV2p3c0pNZHRTQnRSenUz?=
 =?utf-8?B?WVhlV002S1k2YzkzTmRRU3BIM1BlMjFuVXVMSzdMQVJuMHhSSERuQ1NTL28w?=
 =?utf-8?B?V0oyZDJSSmxKdTJoWXJ1aTFBcm1IU0ZlYmFjSUREQlZUcXU2U3ZqUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 494dff07-a146-4e0a-f424-08de92465816
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 12:33:15.7329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PhPRC7v8cAXOpWJRWUDH3DQqnizA2Z9dppzR5kKq480Vn0Nnwhc5LMrDctp7w7pHXIjVLs7VgGEtgkp5qIGmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6438
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

On Sat Apr 4, 2026 at 5:37 AM BST, Alexandre Courbot wrote:
> On Sat Apr 4, 2026 at 9:05 AM JST, Danilo Krummrich wrote:
>> On Sat Apr 4, 2026 at 1:47 AM CEST, John Hubbard wrote:
>>> On 4/1/26 7:29 AM, Alexandre Courbot wrote:
>>>> `driver_read_area` and `driver_write_area` are internal methods that
>>>> return slices containing the area of the command queue buffer that the
>>>> driver has exclusive read or write access, respectively.
>>>>=20
>>>> While their returned value is correct and safe to use, internally they
>>>> temporarily create a reference to the whole command-buffer slice,
>>>> including GSP-owned regions. These regions can change without notice,
>>>> and thus creating a slice to them, even if never accessed, is undefine=
d
>>>> behavior.
>>>>=20
>>>> Fix this by rewriting these methods to use pointer projections in orde=
r
>>>> to create slices to valid regions only. It should eventually be replac=
ed
>>>> by `IoView` and `IoSlice` once they land.
>>>>=20
>>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindi=
ngs and handling")
>>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.=
org/
>>>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 114 ++++++++++++++++++++++-------=
---------
>>>>  1 file changed, 65 insertions(+), 49 deletions(-)
>>>
>>> This is causing a build_assert failure in the latest drm-rust-next, wit=
h
>>> rustc 1.85.0, and also with 1.78.0.
>>>
>>> rustc 1.93.0 does not show the problem.
>>
>> Odd, it did pass all the testing at my end. Anyways, it only proves once=
 again
>> that this is pretty fragile.
>
> Same here, although I did not test with all the supported rustc versions
> (but pretty sure I did test 1.78). This seems to be heavily
> configuration dependent.
>
> Gary, do you know of a way to restrict the `project_pointer` macro to
> only take constant values as indices? That problem is pretty sneaky and
> likely to happen again, so we should probably harden that part a bit.

It doesn't necessary need to be const, for plain indexing (not slicing), if=
 you
do modular arithmetic or bound-checking before accessing it's pretty reliab=
ly
optimized out. Slicing is more tricky, as there're more checking involved h=
ere.

For the macro, it doesn't really know whether you're slicing or indexing, s=
o
this restriction is not trivial. We discussed this at length in last RfL
meeting, and we've come up with keyworded projection variants like this:

    project!(p, [try foo]) // fallible
    project!(p, [build foo]) // build_assert! variant, for indexing or cons=
tants (indexing/slicing)
    project!(p, [panic foo]) // panicking variant

I'll be working on this next week.

Best,
Gary
