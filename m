Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF4ECDB470
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 04:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAF410E00F;
	Wed, 24 Jun 2026 04:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SqR2IaaF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865CF10E00F;
 Wed, 24 Jun 2026 04:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0NKhu7Tlska0dYNCbjB0iPXKhSQT3dy/+UJkPk2hfNH7e/jcxt5zoeaW1zzspf5nQ0qmYltciYdLIhofVvNpqSe4aAeEYI/ZcpPC3KqhO987Wq5mn6xdZPqD4aBjOy21pnn1tfwoUsUKo8exDstij3o1Y58FYLw2lmwzvJED307SOmTvjlN6+VVFvmLo4MfacipjQmt0HsDm5y6c8j5aZa/kSDDVXrwN2VMtJ8agH3akxQ34ncn42JLIKgCWCYTLd7sYUoc+rb2k1E+kyBJBxWcIFvKSlPLSSH1p2xjmzfFNlyjsigtrfVj0OiJs72qCn2F1sJlMVTMZOQxuBE7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLk+yj0MMzjvjpqEtT6p/A5a5n2TXbjCYEP6NKbvXgk=;
 b=sCgFifuNHiGh5c9V73u/SE0MuZ6AV3nF31XMhHoQli/q9ShQaJhaOj6u7cmbBoVjEr1X+RFxEFLX30AtMtKMDWGRbhvsxCr6mYG8riXGD6IdgeHlSBhk7HQnHKzufpDaT+e2j7kxM98g5fAgnbajdMZdO4P9RLokDQZaSe0hfkHBO3hCz/lsJ+JDYDDNVCrf8M4FF08FCMXVH1styGK2dGyfovFXpWCwpBNSnOaQZWVilIMg7YhYlyBE1PNB7F5NMS5YZNj7orndYCeEhZbP9yD9b+OXysfsv4qwLLnfAb5maWmldtBbe1sKT6jJo4YEm+/3YC4U9lUzVPwL76McCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLk+yj0MMzjvjpqEtT6p/A5a5n2TXbjCYEP6NKbvXgk=;
 b=SqR2IaaFn9wU42XfjNjpp4BVxT+bzYpN/IMigS8X7m99pLawRiTM15UgwOs4KvApHMsUoQNJUmHz+O2WTmCqnfL9PSjBPFg/6JmHgyJVj/ylgh/bauyHdySJiW3mByOMwkZXBlJfc4K9cyzeZYbKiiUtoLZVhwi61oBDLTcmKScRqn44+ckkzMzZulkWfoyXHMtwmMj7MEoemT1oDdX/wvNPj8xVX6q8opVrjKmtQtRz4iv5707yFNYWI4Irrz/TkC6OtiF8InWMiDBhLICjyFGNZ4Km2RUEZBF5Vyp2aN66k8SNOw6XNR2Sn4J45Vkdy0u5uT6t0XRWOWp6nXZW/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 04:30:54 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 04:30:53 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 13:30:50 +0900
Message-Id: <DJGZX2MGM1DD.3VAEGR7G5QVBE@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/6] gpu: nova-core: gsp: move boot code into local closure
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
 <20260619-nova-bootcontext-v1-3-45193cd0a2e5@nvidia.com>
 <DJFF1W6VGY4Q.2PV5MEPMFXIDB@nvidia.com>
 <DJFO5A5XN2EO.22B58J2O6D4JG@nvidia.com>
 <DJG6S20KHJK3.TKRZLBYUPGG2@nvidia.com>
In-Reply-To: <DJG6S20KHJK3.TKRZLBYUPGG2@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:405:1::34) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d95b54b-e27b-482c-6ec1-08ded1a960a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|366016|7416014|376014|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: rb5MyP7sN2v96DAvS5V77BqKdNfqozc2oKW7Ao1pKD6A4U4OG8OXkc/q6kixMLenRZGMnqDu0pGq7kxSQahAGwDuBt/Wlr3uFfCGL2aODsnCdI13lXuzVR1b8R2UpIiywp8ziG4sg8CFwfnljkeX22HR7W2KHERakfiIVvYAi+OPUP9kKG0XTIoE515vXhmEc6nhigh4tKAX+oiP+Nb2YcIHOLdETnHgAlpSvmr8w70KYSLq9ieWaLNKOlzimReqJGbIjNM/hiWUmTK17CXLUZCFHM+h6PQScxAym7Fzl0IJhhG4HEkh/UG4iRlFoIULbK+9Y2egvTuaEvHe1jI2+9D5W0cmJti6c5K0lkAB0fuWFW6i5424jy/6qEF3OvX+wvFxim0LMjqCMybQ9wT+TejgmF9J+dvvX919ny79z7W5gcDMGpq+Xm3qDgTTqz28jUUc+UjMKp3urZQtNe4SCsqqErhSmHDLdC7PsLOXL6F3xPkGYu1C4DRADgWGUGmUNnl0igqp62LAlFJEi81RGl2WG0IIb9yLMhh4gWl+KzbFWbptihMReKbpidRQ5HUubKsQzkKRTLiAM3HqNCCzUVhtMiL1pRmLsGGmB9VVxMKTnI0eSy6jx/KjrURocEaTFS0C36YyVuz2QaXZrNBFAHUO9UZf5zaVnYEB+6mNsIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmdwQXF5dU5xaWF4MGNPZ1lKdm5Ea29oYnVrN2ZIcUFjRVBZT1pVUWhMR1JK?=
 =?utf-8?B?WVlSZzYybUduc084cmNUNlZrOXVlY3VscTRaZjZpaFRXcGwwSXFvYXA5cjE5?=
 =?utf-8?B?NUdreVNNU3hXYk4xeVIrV3dnZzNLc1JQaE54Qmx2bE44SHBJVDNEN2lBcE0v?=
 =?utf-8?B?L1dtMFF2YncrWVMvODFidzduaGNGenNMdG1aK0FBbEd3a0Z6U0J2ZHRIakxu?=
 =?utf-8?B?RzQzNllaU1FnRVZ3aVJiQ1MwRWYwZk1DWWFpeXdYWGd4VkVqYnNVbFo1ZmtG?=
 =?utf-8?B?citkZjlMZWFGZ0p2RFFLd1M4T3ZoMHpEa2dVUEszZi9JZzNSUVJFT0FpLzRE?=
 =?utf-8?B?NGdVb0x3OWs0Q1FKbERwR05GSTVqVVhpZWh1MCtZWngyMStOZmNVR3ZVUllM?=
 =?utf-8?B?dURWM2VsUlZkNzM1M0c4NnFGdDRMdm91Q1V6UVdYZmUvVTFtdVNOdWtlcGhj?=
 =?utf-8?B?QU5MN1Y4SlZtOXlzR0F4Yzd2dC9LODhxMVNLbFZTUm9QcFFkQ1BSWU9rN3ky?=
 =?utf-8?B?K3dlcTBKZVNDQ1dpeVNEdGltanhQOHBKbkErT2dJNTRDdTlyR0tqcnZkbUQ3?=
 =?utf-8?B?b2pyYTNxZnNXQmNDb1dDTlhEdTRFYU9vL0ovcW9IV3l3NVAwWGxxcjZjZzFh?=
 =?utf-8?B?Qzd6YUJaQ0tZTjNIRS9lRjhtOGhyMnFuTEU3SUZjejZOSStHTThCUEk4WTgy?=
 =?utf-8?B?OE0xRFZVR3Y2RUVsZ2xWRXpURFNZQXdoRVZWN3pLcEtXeU9oR0NqS3VqZ1Rx?=
 =?utf-8?B?KzJkNXp5M0VreGhIMXNVc3BTYmdjYW1xTHNLWWxjZjF5S0k4elZ0UEZGNm1r?=
 =?utf-8?B?ZUk5KzZ6ZDV3NlNhNHF5WDdPaEZzcElUak5Nb1V2QVB6ZTBzd25aa3lXVmdx?=
 =?utf-8?B?ZWZqWjNXQ0d2WFN2bm0vcWVTdC9Zck5DeVYxTGdjOFU2ODBrdlVqcXVST1pT?=
 =?utf-8?B?VTZtOVBwb1pjdWc1bmQ4ajdpNWcydGpBYTdSVW5ycXBnYm4wcUZWSlBYK1VQ?=
 =?utf-8?B?ZWRLUkxhUUtEdnpEN2ZlOGVKcEtxSlZzK0VJcm5qcTZqMkZGaVNjekF3MWU1?=
 =?utf-8?B?a1Btcm5LZkMxcExUWkhoa2VNbFJoVGE2YXJob21Dbyt1OE51RXhhQkdHdkxq?=
 =?utf-8?B?c2tyMUhDQnRqWUZkOHd5ak1XQWNRTVBVQzJvb3R4dFJnbFB5VDRhcWRZT1VJ?=
 =?utf-8?B?UGkvamFSazZNUHUyRlpiM2E2MGs0NFNjZVlVckt0WWRBZzdQWitrYkNZUFBG?=
 =?utf-8?B?bGVHY01FM0lCeTN3L3hYc3F3MGNpSEI2WWNZZ25FdURoZXlHd3BmRUpZT2ZQ?=
 =?utf-8?B?ZHFUdTFMbGtQVEhhSGRHUlZYU0xKb0hkMm9MbzhXMEx5eXpEQUZEdnAydTdJ?=
 =?utf-8?B?ZW1jRnQ5YmRLYno4dzRldnVjbnh1Y3ZJekovdlNtQUtaSGxONWtmbThxN1FH?=
 =?utf-8?B?WEliWTNUUGYwY21EM2lrMm4wN29VWm9ZWlNsb1VHM2JUWVBsWG5ZNW5xL3lk?=
 =?utf-8?B?bnRQVUp1aFVKVHJTcnJkTnh4L0ZFUEd0L0lBNDFHSU4xU3M0WGJtZkVLT3RS?=
 =?utf-8?B?eFR1b1pwN1NkSlhNR3l6OEZTeENVY2RBRnRIZE5uY282Y2srSFFkRXJIaVVJ?=
 =?utf-8?B?SVBlMjd2eXZzMVc4cTN1Q3dXNzFtcVMzb3FWSWhNV2hqKzc0WkZ1NGwxZHQ2?=
 =?utf-8?B?ZzhvcTRrTXRoRkdFNDJJNjFTVFI3WkFzbXJzMCtkMGh5WjVsRUNIRWlFK1lR?=
 =?utf-8?B?MzB5WHFWWHdOY1Z1bXRtZ2hRaEtZUStBU1ZMY1dCd0xSU3pkeHNkbkgwT0lt?=
 =?utf-8?B?OVd3cVdBOHgyakJDWkluSXdjRk84dm1ZT0RnVVFTZFpXT2t0R1c0RnJkYU8r?=
 =?utf-8?B?TjBIZ3d1RzN5RzAzc0pZemFjdzRYY3FUVGdrczJ3TjBqNmFYaGo3eEo5WjYz?=
 =?utf-8?B?QzhBRHcxV1FwcFhGL2FscWtWUHZaeUZSSGJHS0xXdGxVejhYbVRpWmh0YUUr?=
 =?utf-8?B?cC8yWXhDZytpWm1WcS9aOUJFUUk5aEF6MEZzelpZOHJpVEJQekM1aWMyZTJQ?=
 =?utf-8?B?RUJVNkNWaFFpR3J5WXVRcERwWjI3VHhaWDJIT3VQOENMRVdWTFM2aEF0aXhj?=
 =?utf-8?B?dEd6SFNXRzBjUUozUG12Z3dQLzF5NHdta1N4SXF2bEU1NCttVDJkS2RQdmNu?=
 =?utf-8?B?TXJXM1doMmFiV1d4SCtsck1PR0hXMzVmVmxPLzNFOSt3ZnFUTExCd2U5enlo?=
 =?utf-8?B?amNCK2g2N1F1b0JsajdpMlV2cjFGekxTdkJteWxHTHJkYkpTOHJrN3QvakMv?=
 =?utf-8?B?UnpQOTF0R1BXS3RRNjRNb3ZUcVdaWUd6Mk1CdWhZb1ZWUzYzR3BCUU92L1FP?=
 =?utf-8?Q?s9Jr5IPaGB6dUC79JLSicTdPRYrpuYMkJxAhcPh5+eDXZ?=
X-MS-Exchange-AntiSpam-MessageData-1: R/QMIOP1MRKYAQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d95b54b-e27b-482c-6ec1-08ded1a960a7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 04:30:53.8159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM1E1NRuKhAWP3DSJpIdEZ99pTNvpQtSuGieN6diAYhLL44HUfDijcu2NGNE3M31uhWn0PxzXvhrUG9iBipRXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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

On Tue Jun 23, 2026 at 2:40 PM JST, Eliot Courtney wrote:
> On Tue Jun 23, 2026 at 12:04 AM JST, Alexandre Courbot wrote:
>> On Mon Jun 22, 2026 at 4:57 PM JST, Eliot Courtney wrote:
>>> On Fri Jun 19, 2026 at 10:42 PM JST, Alexandre Courbot wrote:
>>>> The next patch aims at replacing the cumbersome `BootUnloadGuard` with=
 a
>>>> more local and less intrusive mechanism to run the GSP unload sequence
>>>> upon GSP boot failure. Doing so requires running the boot code in a
>>>> local closure, which changes its indentation and would make other
>>>> changes difficult to track in the diff. Thus, this preparatory patch
>>>> moves said boot code into a local closure that is run upon constructio=
n,
>>>> so the next patch does not need to re-indent code that changes.
>>>>
>>>> This is a mechanical preparatory patch to make the next patch easier t=
o
>>>> read. No functional change intended.
>>>>
>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> ---
>>>
>>> I agree with removing BootUnloadGuard, but I think it's not great to do
>>> a bunch of lifting into closures then manually handling the result. It'=
s
>>> error prone imo (we already had several bugs relating to this kind of
>>> thing). Instead, what about just using ScopeGuard directly? This lets u=
s
>>> avoid lifting into closures (which is a bit noisy) and avoids manual
>>> result handling for failures (which is a bit error prone). With the
>>> `GspBootContext` it's fairly easy to do now:
>>>
>>> ```
>>> let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unload_b=
undle| {
>>>     let _ =3D gsp.unload(ctx, unload_bundle);
>>> });
>>> ```
>>
>> Yes, initially I wanted to use `ScopeGuard` but ran into issues when
>> trying to make the references mutable. However it looks like you have
>> been able to overcome these issues, thanks for taking the time to craft
>> a patch!
>>
>>>
>>> I confirmed that it's also compatible with the v2 of this series that
>>> has the mutable Fsp - you can stash the context inside the ScopeGuard
>>> data (then making a &mut reference to the stashed context for brevity)
>>> or have a separate unload context type that doesn't use FSP or somethin=
g
>>> (could later be type parametrized along with Gsp, for example).
>>>
>>> For example here is a rough diff on top of this patch series (you can
>>> change the Result<Option<UnloadBundle>> returns to like
>>> Result<Result<UnloadBundle>> if you want to centralise teh error
>>> handling of a failed unloadbundle although currently it can only fail i=
n
>>> one location):
>>
>> Yes, looking at it it looks like a cleaner approach than using closures.
>>
>> The only thing that I saw as a regression is that now each HAL needs to
>> call `Gsp::unload` itself in its own `ScopeGuard`. I don't think that's
>> the HAL's work - `Gsp::boot` should be the centralized point where this
>> happens.
>>
>> But we can make both work if `unload_bundle` is passed as an output
>> argument to `GspHal::boot` instead of being returned:
>>
>>     let mut guard =3D ScopeGuard::new_with_data((ctx, None), ...);
>>     let (ctx, unload_bundle) =3D &mut *guard;
>>
>>     // `unload_bundle` is a mutable reference to the
>>     // `Option<UnloadBundle>` in `guard`.
>>     hal.boot(&self, ctx, unload_bundle, &fb_layout, &wpr_meta)?;
>>
>> The boot method can fill `unload_bundle` early, and if it returns an
>> error then the `ScopeGuard` will be able to use it. Also, and that's
>> nice, the HALs don't need to use `ScopeGuard`. But output arguments
>> aren't really something we expect to see in Rust.
>>
>> Another alternative would be to separate the unload bundle construction
>> from `GspHal::boot`:
>>
>>     let unload_bundle =3D hal.build_unload_bundle(ctx, ...);
>>     let guard =3D ScopeGuard::new_with_data((ctx, unload_bundle), ...);
>>
>>     hal.boot(...)?;
>>
>> It removes the "1 boot -> 1 unload bundle" symmetry, but on the other
>> hand it also splits concerns more clearly. And it removes the awkward
>> return type of `GspHal::boot`, which come to think of it was another
>> smell that things were not in the right place.
>>
>> The main drawback I see is that we now need to build `Vbios` twice for
>> TU102, since it is needed both for the unload bundle and for booting.
>> But the solution is the same as what the v2 of this series does to
>> `Fsp`: the BIOS is a GPU-wide subdevice that is likely to be used
>> elsewhere, not something to be confined in a GSP HAL. So I say, let's
>> extract it and make it also part of `GspBootContext`.
>>
>> How does that sound?
>
> I think that currently it's confusing because we have two concepts in
> use with very similar names. We have "unloadbundle" meaning what we need
> to run to unload the driver, and we have "unload_guard" which is for
> running unwind stuff if we error. And for the most part these things are
> the same, but they might not be (e.g. in my other series where we need
> to keep certain DMA allocations alive just for the error path, but not
> for an unload later, or when we are partially loaded). So it might be
> nice to make these two things more separate.
>
> I think that trying to build the unload bundle separately
> (`build_unload_bundle`) is confusing because e.g. hal.boot() still needs
> to handle unwinding its state in case of error, so it adds a strong
> assumption that unloading in success is the same as unwinding in error.

I don't think `hal.boot()` can unwind its state properly - or I should
say, I don't think it can unwind it better than just running its unload
bundle itself.

There is little point calling `Gsp::unload` from a HAL failure as it
just queues an `UnloadGuestDriver` message (that the GSP wouldn't be in
condition to process) before running the unload bundle. So here we can
simply skip the guaranteed message timeout and run the unload bundle (or
the relevant part) directly. But even doing so doesn't guarantee that we
can recover.

For TU102, the unload bundle runs two firmwares to reset the GSP falcon
to its original state and to remove the WPR2 region. I don't think we
can/should run them selectively, as they don't undo work in the same
order as the boot sequence - or even from the same microcontroller! For
instance, FWSEC-FRTS (GSP falcon) sets up the WPR2 region, but it is
tore down by Booter Unload (SEC2 falcon). So the best we can do if
something fails on the boot path is run the whole unload bundle and hope
that we can recover.

For GH100, the unload bundle just waits for the GSP falcon to get out of
RISC-V mode, as a consequence of the `UnloadingGuestDriver` GSP command
sent by `Gsp::unload`. The problem is, that in case of failure that
command cannot even be sent as the GSP is not up! :) So the unload
bundle will either succeed immediately (if we failed early) or timeout
(if the GSP is already in RISC-V mode and stuck somewhere else). It's
actually probably better to not even try to run it in this case, and
just wait for the GSP lockdown release to try and address the DMA buffer
lifetime you raised.

Which supports your case that the HALs should be be responsible for
their own unwinding - only not by running `Gsp::unload` IMHO.

In any case, there doesn't seem to be a recovery path that we can
execute reliably in case of GSP boot failure. So making the HALs
responsible for recovering does indeed sound like the safest solution
(with TU102 trying to run the unload bundle, and GH100 doing... I'm not
sure what :)) and should address the issues you raised - but please let
me know if I missed something.
