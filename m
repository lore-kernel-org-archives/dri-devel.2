Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3267C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5026510F38C;
	Thu,  9 Jul 2026 06:27:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iMs1dZB2";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9626610F38C;
 Thu,  9 Jul 2026 06:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIisxYiqHHVd/omAvfXbYaRagkJFDa7Zbmrx13FT7DN1daYX6+fFYpYgwlXKOw4oYsuqNWXM0poMe+MaDmEdanQC1lm6m5bOIHGsjApi9G2D3M+x5o8loKXqP5TosGvvBbn11DUhH7ccG4AU3UAVNkaZDO9ujk2jRsUTLoPPPLTX+x/lzcEiZNtwV6aF3V2ZfD2uakNNWFtOurHCdDS2QGentoFVTbREVHQW65q98d1g3i1rccjfEYRdYRW1cX9aO2qtitm07YPYdlM79v9O+/nUR1+KVO81U31/Bxtx3x+pjlSrrd7XsQV9V1mttDpyWKE4CYB5hI8cCv4STgfouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ5/Z6QjkQhzF/SXGyeSVLxt/l5TzmLalkK0aEknHk8=;
 b=O/cWlytPh+NXs4Hwwm50zyHdVssHG8jtnIith6e7Qp7R4KDcWC0nzne/vKII99lvI10WLO7EScyoZGDRx0m7jglTmWxI290JWcKBV0GeQ2LCSXMJzqZWKR3G516WweHIf+ZGtcSfelj5UhLaifAjOHK8uznFxSFfCs/53/DyoDI7coI3H2F5MiPj+8hinHhW6e2dNPhG6tYDF1G6s1xAQdZ6nqjQ4H/m7rCPonsjl5vWXc92XbQZoyw6AR6M3TPqUEKjeXfOSY+HttgOnvAyQntOtSgTJwsYWI3sRPsmlvieI7t8I2ybtrtgGvccLFAx53pMEmPKQimt1NHeen4stA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZ5/Z6QjkQhzF/SXGyeSVLxt/l5TzmLalkK0aEknHk8=;
 b=iMs1dZB2vvlAlDEJZQy+76qI7kLM67vbceNgjVZZ7WY2TekAztP2PIBZXlZQVQ35WyojLsX1gvR/eY4RXeCHzK+r+LukCkEwe77KutVK36bdpJ+H83xB6OHm6Jf8wtMWlg9uyfW2/7/wTy5hmLEuVINK33936wylXKpwGImTudaA5fUdbcDBIBFJCYnZlLbxm0jFnhWUpR+TkHdNKymAhtpAo1fBFql02hgks4bCk53sGjzL9VulPYfOQ6JzfRHFUxAvc3lOCzIMkXqqzBrEzvQ8jbUI72AVqi+oHnBKd65OloMr81PtZfq4FZj5oYH3iWx4ygclCIoRqqbneUpHtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:27:14 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:27:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 15:27:10 +0900
Message-Id: <DJTTSBBHIIOF.3EQLS5MCBROFE@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v5 03/13] gpu: nova-core: gsp: replace BootUnloadGuard
 with local handlers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
 <20260707-nova-bootcontext-v5-3-ecad9346387f@nvidia.com>
 <DJS6M2YBO8RS.33T3S32EFHL1Z@nvidia.com>
 <DJSCTKZ97STM.2D8YP8LIVELH2@nvidia.com>
 <DJSDMDHQVBAR.SSK7451SWXO5@nvidia.com>
In-Reply-To: <DJSDMDHQVBAR.SSK7451SWXO5@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::17) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: ba56a7a1-f45b-43ce-4a9b-08dedd831d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 2E5sUlQLOYoIHHYKtvWph7E7mN7X8SDIdZHWddT5HjwBvgl0waqCOABf14W+Mjch9of6NktJYz73HYqL49mon9Xi0ssketJXqR6USsnPG+YHDUeRrX0a7JoIn5YlJ1ROJYRl0DIiZsSF0ZnOjG8ZNu5WRKEuPjjwNfICz92BBOqQi0ZikSWrjW13+13LcUAlWA/uWGLoMjSPEz4wyTawX1BIEzIG6DPxFA0o1zBVnJe8Nd24SLIIX5r/q37cqzwdCsX+eNW1jCbepAw8Weif/+puWgXZqXDQxz5u8shwbyKE8tQ6rNN7PVMMXV0GqZYhyePW25Np2acCRX0HswKFtqE1UvD0C8/FcMN+rJdEe1fxfspR/M0IQMMzaud++Zylu1l0U2vASs4CWJ0GI+7ShEv4XVVnJ4CinAC0vMNdjZ/Hs/ZJ4d86bzSAN9mLvz6qA0TyQrxw0bmkmnNpl9w1gCs43aBqaVwCWMBwU8COXSdQVLSCZsN2I39I3bu75LHYIa1kmTOrV8f9z0ii6mA/ipSM/0VkB7+vyPqRu7G66lGaVGMP8Nraa16J5SKSFxrvhuvMVs5E6Q8FFPAfctxZ+MQhIVpH6EqFgCVZfOG/MbLibwyJPNmnEtAtQUOL550MFZzyPaMKBULVzlKc9a743izIDek1ol3daw4RL7mQk/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3h4Snl2V1JJK3lUUnhBQWlIOWtacHRwbzJSTHp1MTRFd2tQSXhrSDRrZ2hs?=
 =?utf-8?B?ZHlZaTBXZit6M2ViVFFGanM3VFhhVDVDZmk1Y0llalZUdXloTUg2eDlHTHdV?=
 =?utf-8?B?WUZlS1J6cDl5eTBpcEdkN0Y3VG9oQ2JjWUszWVJnTWtDUGxJOU1vd29vU1B3?=
 =?utf-8?B?Rzg0NEV3K2oxRjFqd3ZybldZUFh0d0pRNkh4ZjJKaWJTUkNoc0VNT0h0Yy9Z?=
 =?utf-8?B?Y1RJeVljZ2k5MWFHVENUREtFSHNidU5mcG5nbE9PR0F3SDhYMWduaUJXbC92?=
 =?utf-8?B?UCtIcFRvZUVOOFdyTjBoR3RzUjhXdUVza0cxSVF6c3hkeFlweDIydS9zUGhN?=
 =?utf-8?B?YkhmOW43RzdtTFFpL2Mzc0lUeHV4NCtnMDZHSkRCSE05cUxwMnZ2M0xTNGVF?=
 =?utf-8?B?ZmFFb1Z3d0hqQXdOOCtHUU9aZjdJbjlRSkROZm9ERjVmbElnTHR6WHg2cXRK?=
 =?utf-8?B?K1RYT3A5MUFzVzVSMzhHaUxTYXFLM1JGRmRMSjlTZHh2ZFBiRS91ZzZKaGVj?=
 =?utf-8?B?cjBNWXA4bEQ4MXMzV2FyR3BPMjArVVNHK3Q3elBrYVNNT1YrdmpkUnQ5OWlm?=
 =?utf-8?B?c3huRWMrdmFPRzYrR0RBNi9aUFhnN0tVQldGRFB6ZXN1V2Vjc0VMMzdFdUNp?=
 =?utf-8?B?czc4WVp3Vk9hTDEyRjRlUzdXVE1mT3NFbkF5QlkzYSsvQnUzc1phNCszd29n?=
 =?utf-8?B?djFsUWNORjJPU3hpdllGSEhIbGNkaURoaUZWdEdZeXordFlOQ0Zjc3lXWG1l?=
 =?utf-8?B?SGNPMHNYVFFLWVJVUG1XYXUwT3RvNnp0Nk41bUZXdjJOVGdlSGppTE96MU4w?=
 =?utf-8?B?K2VmNFJEWTlNczhuazBUM2ZhalFjbnp4cVJhTG9lcWcrV2tGSytDc1VHRTZn?=
 =?utf-8?B?bkVJN1FlWklET1V0cllCQXhHUmhJOE42NThSYTJrcER2dFY5TlFLa0ZIdDlH?=
 =?utf-8?B?M0Q5OG1RR0RYaGlQSDdIdHp2ZzAveVpHQ2gvRVlQWEt2V3FuMEZTbCtiVEQ4?=
 =?utf-8?B?QjFVWjRyNWphNTFnbXNhWGVDczJDd0RBYmJPM2RBNHJ3aHRYa1NvL1Nkc2hZ?=
 =?utf-8?B?OExUbnpyWmFRRTFYOWpYaTA1ek4vUWNaVkk2VkdCTllVUm1EUXJ2bitFb1dw?=
 =?utf-8?B?MU83eE4ycU5iQlF0QitjeTlIZldpdXExb3hTdXp1a0dqTDQwZ2QyeU9tWnhp?=
 =?utf-8?B?T2hrMFFmd2FEdmpMSzM5Y3FvV2UxWU00cHp5QzR3dW85VHZkbDdTRnlab3l0?=
 =?utf-8?B?VmRKTnlTOUxrVS91QW81d2EyTjNSNEs2ZGVLNTZ2V0F6ZWUxbmhTd1hRVktV?=
 =?utf-8?B?YXhwdFZKU3NCYjBpZ0JLOU52VFBYSGxtOHo4WmpBMGExMUlRSUYwYXBXV0pp?=
 =?utf-8?B?OWZsQ0ZsaXNCN2FLc1VGWGpFdUJNV0lTcXZ6YTQySEtXaE9jaWVlMGxoWkFS?=
 =?utf-8?B?b1hOTHkyaFJUUG1ZOUJWclpwcm1lVjEvc1owT1pTRDlLaXFseDkxY28zSzZD?=
 =?utf-8?B?a2xDZ2xrTVRBK1lhMDA3MjRKL21TQzdtSjlQT0xhSTBJWXlFbHdSQWxreVBu?=
 =?utf-8?B?OENXeGdBbFk1aHdUMSs5REt0Q0MvcnUvazllQXloTXZOWGhzd0hiaC9mc01r?=
 =?utf-8?B?OEVwODVMSDBFbGVKaHBPN1FXVHBTd1l2Yll4eDU0VWZTeUJRWEhnSWVleWZl?=
 =?utf-8?B?MVVJa0Noenp6QVlwZmI1TjIxTFRSR3JWd3lSZzFmc3Y2dDYxdDd3KytyUmlp?=
 =?utf-8?B?dW1XL3B5OXNqU2dpRWRqOGdHVGhIUGd2dUR4ZWsvT3l6UVJSSnBVMDkyZzlv?=
 =?utf-8?B?ZlBINjNnMUZrYnhoUFBzeHVwMG1YUHVNN1VzTTRUVmJFUUNDMDZZYi8xS0oy?=
 =?utf-8?B?a3B3SjlaeG45Q1d2TU4rNnFvL2NYRW0xSHJIeFBPTm4yQVBGMHlQbzFJM1FH?=
 =?utf-8?B?VFFWdDFseDlRVjk0ajZiczZUK0ZHTWI1ODJrVFpwL2ozWmtXcnJhVnhuYlF5?=
 =?utf-8?B?bVI0UCtxQVN3cFNRWk5CS2ZhSTRIZW9MRzJ3UXJrcXhwKzZVUkhmNHdPT2hD?=
 =?utf-8?B?SWtNc3VtaWZLVHMxMjk4aUJVTnR0TG9aclVlVGoxYjVGQjFuVHNrN09xbStS?=
 =?utf-8?B?SWM2cXl4S3c3bkFCR2lIZzhXUUU1SVZhTWNoVlNBdDBCOFBRWUg0NWZUMnpa?=
 =?utf-8?B?eWpPTUFhVmNmZEY0TnZhcXhYdHd0cVlJKzF4WS9CbXpWM01DYkNpS0h6Sjhh?=
 =?utf-8?B?YU1rOGZMTkkyWXZoR1U5aDIrSEd3YmVidVp6OHM0bUtNak8ybTRhNXpONEdN?=
 =?utf-8?B?eEw0VGhkNExlMloxWXdTdWFMS2J3UnhMYjdaZG1ZSC8xUlAxZXBFQ2ptT1Bu?=
 =?utf-8?Q?MvnUOJYvBjXK+CBHM5yvizA4zr8QYpGophQVu7By0y42K?=
X-MS-Exchange-AntiSpam-MessageData-1: Zo5TnLy+iG0HqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba56a7a1-f45b-43ce-4a9b-08dedd831d48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:27:14.5008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b99ZfPWTXHro3+xF0PQ398eVvtpz5kY7n/rTiD8R2daFKxOaObVceu+1KtUpB3ZJ1F4c/n+XVWb2hvSS7RZkOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441
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

On Tue Jul 7, 2026 at 10:34 PM JST, Eliot Courtney wrote:
> On Tue Jul 7, 2026 at 9:56 PM JST, Alexandre Courbot wrote:
>> On Tue Jul 7, 2026 at 5:04 PM JST, Eliot Courtney wrote:
>>> On Tue Jul 7, 2026 at 4:21 PM JST, Alexandre Courbot wrote:
>>>> When adding the GSP unload capability, we introduced `BootUnloadGuard`
>>>> to automatically call `Gsp::unload` whenever an error occurred during
>>>> the boot process, in order to try to reset the GSP to a valid state.
>>>>
>>>> This approach is not well-suited to the errors that may occur in HALs:
>>>> by definition, an error occurring in the HAL means that the GSP is not
>>>> booted; yet the first thing that `Gsp::unload` does is queue a shutdow=
n
>>>> message to the GSP, which will inevitably result in a timeout when don=
e
>>>> from a HAL.
>>>>
>>>> Furthermore, `BootUnloadGuard` is problematic because it holds
>>>> additional references to the boot context, notably the `Falcon`s. Thes=
e
>>>> extra references stand in the way of making some of the `Falcon`'s
>>>> methods mutable, since those methods would require exclusive access. A=
s
>>>> this behavior is only needed in one place, introducing dedicated types
>>>> for it is distracting and unnecessary.
>>>>
>>>> Thus, remove `BootUnloadGuard` and adopt a two-level error handling
>>>> strategy:
>>>>
>>>> - HALs are free to handle their errors as they see fit (most likely, b=
y
>>>>   running their unload bundle if it is ready by the time of the error)=
,
>>>> - `Gsp::boot` uses a `ScopeGuard` that runs `Gsp::unload`, since the
>>>>   GSP should be up and running by the time `GspHal::boot` has returned=
.
>>>>
>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/gsp/boot.rs      | 67 +++----------------------=
---------
>>>>  drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
>>>>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 31 ++++++++++------
>>>>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
>>>>  4 files changed, 44 insertions(+), 90 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core=
/gsp/boot.rs
>>>> index ab0491b57944..536f2e341c01 100644
>>>> --- a/drivers/gpu/nova-core/gsp/boot.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/boot.rs
>>>> @@ -30,66 +30,6 @@
>>>>      },
>>>>  };
>>>> =20
>>>> -/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
>>>> -///
>>>> -/// Stored as their own type to avoid repeating a long and tedious li=
st in [`BootUnloadGuard`].
>>>> -pub(super) struct BootUnloadArgs<'a> {
>>>> -    gsp: &'a super::Gsp,
>>>> -    dev: &'a device::Device<device::Bound>,
>>>> -    bar: Bar0<'a>,
>>>> -    gsp_falcon: &'a Falcon<'a, Gsp>,
>>>> -    sec2_falcon: &'a Falcon<'a, Sec2>,
>>>> -    unload_bundle: Option<super::UnloadBundle>,
>>>> -}
>>>> -
>>>> -/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
>>>> -/// [`UnloadBundle`](super::UnloadBundle) when dropped.
>>>> -///
>>>> -/// Used to ensure the `UnloadBundle` is run during failure paths.
>>>> -pub(super) struct BootUnloadGuard<'a> {
>>>> -    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
>>>> -}
>>>> -
>>>> -impl<'a> BootUnloadGuard<'a> {
>>>> -    /// Wraps `unload_bundle` into a guard that executes it when drop=
ped.
>>>> -    pub(super) fn new(
>>>> -        gsp: &'a super::Gsp,
>>>> -        dev: &'a device::Device<device::Bound>,
>>>> -        bar: Bar0<'a>,
>>>> -        gsp_falcon: &'a Falcon<'a, Gsp>,
>>>> -        sec2_falcon: &'a Falcon<'a, Sec2>,
>>>> -        unload_bundle: Option<super::UnloadBundle>,
>>>> -    ) -> Self {
>>>> -        Self {
>>>> -            guard: ScopeGuard::new_with_data(
>>>> -                BootUnloadArgs {
>>>> -                    gsp,
>>>> -                    dev,
>>>> -                    bar,
>>>> -                    gsp_falcon,
>>>> -                    sec2_falcon,
>>>> -                    unload_bundle,
>>>> -                },
>>>> -                |args| {
>>>> -                    let _ =3D super::Gsp::unload(
>>>> -                        args.gsp,
>>>> -                        args.dev,
>>>> -                        args.bar,
>>>> -                        args.gsp_falcon,
>>>> -                        args.sec2_falcon,
>>>> -                        args.unload_bundle,
>>>> -                    );
>>>> -                },
>>>> -            ),
>>>> -        }
>>>> -    }
>>>> -
>>>> -    /// Disarms the guard and returns the [`UnloadBundle`](super::Unl=
oadBundle) it contains.
>>>> -    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
>>>> -        self.guard.dismiss().unload_bundle
>>>> -    }
>>>> -}
>>>> -
>>>>  impl super::Gsp {
>>>>      /// Attempt to boot the GSP.
>>>>      ///
>>>> @@ -107,6 +47,7 @@ pub(crate) fn boot(
>>>>          let bar =3D ctx.bar;
>>>>          let chipset =3D ctx.chipset;
>>>>          let gsp_falcon =3D ctx.gsp_falcon;
>>>> +        let sec2_falcon =3D ctx.sec2_falcon;
>>>>          let dev =3D pdev.as_ref();
>>>>          let hal =3D super::hal::gsp_hal(chipset);
>>>> =20
>>>> @@ -118,7 +59,11 @@ pub(crate) fn boot(
>>>>          let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta=
::new(&gsp_fw, &fb_layout))?;
>>>> =20
>>>>          // Perform the chipset-specific boot sequence, and retrieve t=
he unload bundle.
>>>> -        let unload_guard =3D hal.boot(&self, &ctx, &fb_layout, &wpr_m=
eta)?;
>>>> +        let unload_bundle =3D hal.boot(&self, &ctx, &fb_layout, &wpr_=
meta)?;
>>>> +
>>>> +        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle,=
 |unload_bundle| {
>>>> +            let _ =3D self.unload(dev, bar, gsp_falcon, sec2_falcon, =
unload_bundle);
>>>> +        });
>>>> =20
>>>>          gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
>>>> =20
>>>> diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/=
gsp/hal.rs
>>>> index d3e47ef206de..851d1f24c137 100644
>>>> --- a/drivers/gpu/nova-core/gsp/hal.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/hal.rs
>>>> @@ -24,7 +24,6 @@
>>>>          Chipset, //
>>>>      },
>>>>      gsp::{
>>>> -        boot::BootUnloadGuard,
>>>>          Gsp,
>>>>          GspBootContext,
>>>>          GspFwWprMeta, //
>>>> @@ -51,15 +50,15 @@ fn run(
>>>>  pub(super) trait GspHal: Send {
>>>>      /// Performs the GSP boot process, loading and running the requir=
ed firmwares as needed.
>>>>      ///
>>>> -    /// Upon success, returns a guard that runs the GSP unload sequen=
ce if GSP boot does not
>>>> -    /// complete.
>>>> -    fn boot<'a>(
>>>> +    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use=
 with [`Gsp::unload`], if one
>>>> +    /// could be created.
>>>> +    fn boot(
>>>>          &self,
>>>> -        gsp: &'a Gsp,
>>>> -        ctx: &GspBootContext<'a>,
>>>> +        gsp: &Gsp,
>>>> +        ctx: &GspBootContext<'_>,
>>>>          fb_layout: &FbLayout,
>>>>          wpr_meta: &Coherent<GspFwWprMeta>,
>>>> -    ) -> Result<BootUnloadGuard<'a>>;
>>>> +    ) -> Result<Option<crate::gsp::UnloadBundle>>;
>>>> =20
>>>>      /// Performs HAL-specific post-GSP boot tasks.
>>>>      ///
>>>> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova=
-core/gsp/hal/gh100.rs
>>>> index 1d06405a32f6..18c889f9f413 100644
>>>> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
>>>> @@ -23,7 +23,6 @@
>>>>          Fsp, //
>>>>      },
>>>>      gsp::{
>>>> -        boot::BootUnloadGuard,
>>>>          hal::{
>>>>              GspHal,
>>>>              UnloadBundle, //
>>>> @@ -143,13 +142,13 @@ impl GspHal for Gh100 {
>>>>      ///
>>>>      /// This path uses FSP to establish a chain of trust and boot GSP=
-FMC. FSP handles
>>>>      /// the GSP boot internally - no manual GSP reset/boot is needed.
>>>> -    fn boot<'a>(
>>>> +    fn boot(
>>>>          &self,
>>>> -        gsp: &'a Gsp,
>>>> -        ctx: &GspBootContext<'a>,
>>>> +        gsp: &Gsp,
>>>> +        ctx: &GspBootContext<'_>,
>>>>          fb_layout: &FbLayout,
>>>>          wpr_meta: &Coherent<GspFwWprMeta>,
>>>> -    ) -> Result<BootUnloadGuard<'a>> {
>>>> +    ) -> Result<Option<crate::gsp::UnloadBundle>> {
>>>>          let dev =3D ctx.dev();
>>>>          let bar =3D ctx.bar;
>>>>          let chipset =3D ctx.chipset;
>>>> @@ -160,10 +159,6 @@ fn boot<'a>(
>>>>              KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn Unloa=
dBundle>
>>>>          );
>>>> =20
>>>> -        // Wrap the unload bundle into a drop guard so it is automati=
cally run upon failure.
>>>> -        let unload_guard =3D
>>>> -            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falc=
on, Some(unload_bundle));
>>>> -
>>>>          let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset)?;
>>>> =20
>>>>          let args =3D FmcBootArgs::new(
>>>> @@ -174,11 +169,23 @@ fn boot<'a>(
>>>>              false,
>>>>          )?;
>>>> =20
>>>> -        fsp.boot_fmc(dev, fb_layout, &args)?;
>>>> +        // Keep the result as we want to wait for lockdown release ev=
en in case of error, to make
>>>> +        // sure `args` is not accessed by the GSP anymore.
>>>> +        let fsp_res =3D fsp.boot_fmc(dev, fb_layout, &args);
>>>> =20
>>>> -        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_para=
ms_dma_handle())?;
>>>> +        // Wait for GSP-FMC to release the GSP lockdown, indicating t=
hat `args` is not accessed
>>>> +        // anymore.
>>>> +        let lockdown_res =3D
>>>> +            wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_=
params_dma_handle());
>>>> =20
>>>> -        Ok(unload_guard)
>>>> +        match fsp_res.and(lockdown_res) {
>>>> +            Ok(()) =3D> Ok(Some(unload_bundle)),
>>>> +            Err(e) =3D> {
>>>> +                // Wait for the GSP RISC-V core to halt in case of er=
ror.
>>>> +                let _ =3D unload_bundle.0.run(dev, bar, gsp_falcon, s=
ec2_falcon);
>>>> +                Err(e)
>>>> +            }
>>>> +        }
>>>
>>> IMO we should just ScopeGuard here too (after args creation) to run the
>>> unload bundle. It will avoid manual manipulation of results which is
>>> error prone (since a ? added later will break things) and also halt
>>> happens-after gsp lockdown, so it's a natural sequence point. Also I am
>>
>> ScopedGuard here is reasonable - do you mean only for running the unload
>> bundle, or would you also duplicate the lockdown release there so we can
>> avoid using `and`?
>
> I would skip the lockdown release path on the error path since AFAICT in
> every case halt happens, we would have also gotten
> `wait_for_gsp_lockdown_release` to return if we had executed it. So it
> doesn't buy us any additional waiting/sequencing, and we still need to
> wait for halt anyway. So concretely I think something like this is
> simpler and as robust (conceptually to me it also seems odd to wait for
> "gsp lockdown release" when boot has failed):
>
> ```
> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/gsp/hal/gh100.rs
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
> @@
>  use kernel::{
>      device,
>      dma::Coherent,
>      io::poll::read_poll_timeout,
> -    time::Delta, //
> +    time::Delta,
> +    types::ScopeGuard, //
>  };
> @@
>          let args =3D FmcBootArgs::new(
>              dev,
>              chipset,
>              wpr_meta.dma_handle(),
>              gsp.libos.dma_handle(),
>              false,
>          )?;
>
> -        // Keep the result as we want to wait for lockdown release even =
in case of error, to make
> -        // sure `args` is not accessed by the GSP anymore.
> -        let fsp_res =3D fsp.boot_fmc(dev, fb_layout, &args);
> +        // Wait for the GSP RISC-V core to halt in case of error. We cre=
ate this guard after `args`
> +        // to make sure that boot args are kept alive until halt, in cas=
e they are still being
> +        // accessed.
> +        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |u=
nload_bundle| {
> +            let _ =3D unload_bundle.0.run(dev, bar, gsp_falcon, sec2_fal=
con);
> +        });
> +
> +        fsp.boot_fmc(dev, fb_layout, &args)?;

After patch 13, `fsp` is borrows mutably from the boot context (which is
also given to the unload bundle), so we end up with a double-borrow
issue. I could solve this by passing a tuple to the ScopeGuard, and
borrowing `fsp` from it:

    let mut unload_guard =3D
        ScopeGuard::new_with_data((unload_bundle, ctx), |(unload_bundle, ct=
x)| {
            let _ =3D unload_bundle.0.run(ctx);
        });

    let fsp =3D unload_guard.1.fsp.as_mut().ok_or(ENODEV)?;

    fsp.boot_fmc(dev, fb_layout, &args)?;

That's something we will need to do once the falcons become mutable
anyway, so I'll use that approach for v6.
