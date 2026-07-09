Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEB4C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA2310F341;
	Thu,  9 Jul 2026 00:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bmlOHfTb";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F1010F341
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKAXgNjl2fSL1hlMagiH0XRPh9UafPvwRu72k7moZ2NZ9EKkqBIHyRxKAqNFEci9lr4Tz6jMvWj1+ZSUKmlofhwtUosZgHkWnE1TTXbsgCROE6PLuXBqAjFVqaLi0iWTCN9r+RwS/yoI4jVabTP/72F3MRBpdWr7NIu6VGn3DbYWmBklc6+8jMBzRIADeVr4WdgIQ7SnPWNXBkX6ZvV/FfnP+l8WOjv6QroywnrbJmeK32calDbSIT/aU4ytUmdLC+umuQ6i48ChaB15Lid59dIAxzi5oiH+Xzfa8auUfuFGNjbMCPtFweCHvaDiN06rArutrwURDR2qP4hFv7FUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvGs4yFSkFd0YemNx7IXp+o00LXKoY1+CUeYE6XGBxs=;
 b=kYqthCdMRSyl3HoBt81Ljqr4uPIQSz8H9H2CulIu2snZffGDS8FPM0rP6cyf985XLHeCUjw2iaxr83KZDO7R//rgRq/HRm1bbXrkYA2Jm/m/SWxvRgF7dgG8/MeO7IYxNWBLYGqUbb7ZvOb32pF+x6R4VJ7xvjO6b4wOwxd+nq/L+88XM5YUJra5agY4sY38POKOf/dE7jdp8I8xGUZ/tbyQa5MrPDKJqD66wQeD6Y25oRYKVw5mN2Ai3z13nQuxU8lGahRwbKDnW65wFvY0TCMmhmJ9DRLdxNMZ6AHSl3EgheWLrvfrZiGEPtBDtbpxOB2re8crVFLOFmKhsDdkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvGs4yFSkFd0YemNx7IXp+o00LXKoY1+CUeYE6XGBxs=;
 b=bmlOHfTb12xw3+6DoxY3Vagv73SY8ehjx3m5Q4xBe0v1AM88rDpLlqqsWchcwN6tJxpSOuPoIC8oZvhT8oXVuqCO54aKm30grfOfCxoqzE+31TzN9nz3d85rLerA9RGogoDfH+GGbiKvxbNoh46EsylJUSLsYtK4KDHUD0Gu6swjlHe9wtEC5gZpbaYODirsif/diVr7ertBoIsZmWvXg+QP2s1XThFo+EtCKHASb2eIQMz2sASzSe1/48JRv5gxz1btdr0aEbCwDUOzqJ73iITpqTD5HU4kqchIk7AOqGKErHQTJIoKFFDKbxNzCA+qNvk8KKg2juSpP4mFYryEKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 9 Jul 2026 00:49:08 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 00:49:08 +0000
Message-ID: <6fe208cc-f095-4d92-b34c-ad227d2710a4@nvidia.com>
Date: Wed, 8 Jul 2026 17:49:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm: nova: Add GETPARAM parameter to read the GPU
 chipset
To: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Timur Tabi <ttabi@nvidia.com>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "gary@garyguo.net" <gary@garyguo.net>, Eliot Courtney
 <ecourtney@nvidia.com>, "lossin@kernel.org" <lossin@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-4-apopple@nvidia.com>
 <59948bff927bd4ad3af5fbe68d5d5e7565c5f729.camel@nvidia.com>
 <DJRP5QO5JKVT.Y7LCZARVCWJ8@kernel.org> <ak7lU9X4pTwx5NDB@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ak7lU9X4pTwx5NDB@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ebad8a-6fe7-4144-6a33-08dedd53e275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: I0GaGaWBKciSxiFUMwuQPKLNgq2tTS8c2RAF0KWvJ81wx26IORUNmLdCbzqZEMhJb+Vbyyk3jmzY17SaQV7qjFxVQKKHYsfEmfd3JbbiOcKjRbgslOTQxZew7ftX+mFIkwg+BBDEzrgLowrmXppH6nVR1e8Hnjh1or2TDxB17SaX4exi/Mi7349vlt0VhxDTePMKsVWwAzzZyaANiYjw7Qwf8f7UmN3XNep9AfOGF5qOsjAB2e1ftm3POzhQcCfSEu9MdWmLLtGGOrYL62/4S/G6OOiroMMm2DRnAoTtGpmZP+PZDeN63qinMlSgoWZV55Kcivkv+JXNOf3oa8oOyuNkPbD4bbd6Xhu57+Q5g9zqM+ZOBJw6Sbv2Pc970XQvMU9VA7O3CCHQmxvDx/0IGVri72+LUIywQovFj2zvUYkai9TeVY8N2JWS/gJWG/GkqKxDK2MiLb0hwLroMMQECuErEBHqP5bfYmb5FgCFwNJcyuzFlXh6RFAT/E0GZqMJwMfiIgTHn9BTqyy4z2ZpRSjnj197JL9fvy5A0dlrhrvKKFUg60EXCKpKsZW0j19V4bboJYuIrzeys2bE7mLQUdRrqWDZqc+cKFoP9F/la1ihesscUd7d48QmYj4Sw+ygSNEr19VeVXLBKrKUkuKMCe/SaA42bw0H+Dt1ABeWIaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1U3NDUwNS93YTFTUnppVEpjMlJaNTNXRUNBWmJPTmg5Sld2cDVkaDN4NUQ4?=
 =?utf-8?B?SStqR1JEYzU4T1ROWGRNY2loMy9INUt3UzBYU0poSzk4RzNMc3pOWmdwK3Ri?=
 =?utf-8?B?ZkNjZnZUN1czL1MwSDFmeVFMd1BDckQ3V0dqV0VLRm1TRk5lYms2VUszOXM1?=
 =?utf-8?B?ek1zRTFnOUp2NEpiTFNoaGVMQU1WRnZGb1VDMXA2S1U0RlR4WXVvbkhub3Bk?=
 =?utf-8?B?MDBBMUpMeWNoZXJkN1cyUEtXemJtU3ljTkZYMVY1M1FpVkh5cTN6QnBEZVBk?=
 =?utf-8?B?TzFMUjVsY0w2Tm1CZkdOVGw1YWlFZmM1U2VSWnZIMXhWeGdkdzVDZ05wbDEv?=
 =?utf-8?B?dXRxd3ZOeS9wUWdqbm1UdjFNbXJMNHB0V0NHNTlMekI4cVAybjZYc3lLWUhU?=
 =?utf-8?B?VmNXWXlTRGtPbkhtY1psQXNicHgwTjBBMnFwM09uZjhWMEs1L1BKcTdZN1Zx?=
 =?utf-8?B?R0F6VjhpQ0prNHJSd1pqVmdwcHZzeWJBbDUxQzJaNmx1UmpaNnZSWHFyUzBp?=
 =?utf-8?B?dXVQSjR2Q09jSWl3LytILzhTVU0reEcrc3JTNFJlbkF1dzUweE4yWlo2Yk9h?=
 =?utf-8?B?ZnBQd3p1RkJzQXpWYU9vMjhYczBTdUptbHpDN2x4NWNpRjRCQTk4dVcwYllz?=
 =?utf-8?B?Z01lYVo1bGplZHh0SFZOT2VrajR5ZGRKR0h4aXAxdDE4bmhsejJyQ2xBYm8z?=
 =?utf-8?B?MkpPdlN5REZEWE9SOGM2YVFqL0UyTTdHQW5MY0hEaUJiSUpoYk5vbFdoa0Vk?=
 =?utf-8?B?UTFtNnVmUCtURGUySUJGclUvOEVRQXZqbzc2WFFaNFF5M1FwaFdCTkg3MU5r?=
 =?utf-8?B?ZGpQTVY2UUVpamtiTnZiLzJyWGVwQ1lkUm8rZTZXNmZZL1dqOWZ0aGtHZmVP?=
 =?utf-8?B?TkEwMEg5a3o0NmpKcE40cHV0Y2RkK3FvS3ZzRnEwWXZFRlRmUG5ud2lmT1Jz?=
 =?utf-8?B?Y1Rpd1M2dFE2dWVKeHdNc0lpY2ljeHk0UzJSVHhCTGlwc2pRbFJDbndpRmpr?=
 =?utf-8?B?Y2JsZFBwS2x4SHBweW8zRXIrV0dzNElGTVorYVNFdUM3Y2VHajFCVGhYN1U4?=
 =?utf-8?B?SG1lREVxck4rVUV2K0J2eUVMM3JLeE5QYkQvZ3JadTBVOWR6ZTFXbGRmTjlV?=
 =?utf-8?B?dktzVTBieHVMUGIwakNNNkdmL3F0N3hZa1lTZHV0eGdSTkVrVzJNQlZLdDJC?=
 =?utf-8?B?T0tVK3Jrb0o5VGh4dnIraVQ3aURiVUlDMFQ4ekJLNWlFZHVaY3hFTVBWRWNK?=
 =?utf-8?B?VzAyS2RtRjNzc3ZzSWVrYUhBc3Y0VDQ3eUhQTXdmRmlYMVd5bWt6Nkg3d0oz?=
 =?utf-8?B?RkFGeHRVdkVJMXNmVWpuZ1dqMzJzVGhZOTVNUDcrNWMrOTJ4SnM4TUorQXZp?=
 =?utf-8?B?dWVCTmpOaHNiSkdUU2NKVncyeVVxblFTNHhtSWV1V1ZCa212cWJmRi8yTkk0?=
 =?utf-8?B?Qk5oc2xRQ0FBaW9oYXdoeTlYN25hTTUzRzNPcVBtZW80d1BiQzI0V3hWbEZX?=
 =?utf-8?B?QUEvWitUa0xBRVVNOERmV1J0UjhBaXJhdzZDOXpSelBzWmZ5LytMZlBoUXE4?=
 =?utf-8?B?aGxQSHcrM0l4MDN4bEFoMnczNmRvdDJyREJ0TFRzTDc5NjNvY3BDTzZMU2dl?=
 =?utf-8?B?UEdEVzNCaUc2dndtaXRHank3eW1FSnI5ckRzSzRYNzF1OW1IbXFMVERCVkcw?=
 =?utf-8?B?R1B1c3J6YXdDMzBhYytaeUVJWlpSd0JJOEJXME1YZW9nY1FGRUU0SnpzaWF0?=
 =?utf-8?B?dkhyekxrY1RsaHVub2ZTTk5sTVZDajVSUTdjRDZ3TjV6aTZiYmRYMUI2NGs2?=
 =?utf-8?B?M2xpYy9hNmRVaEJaUE9udExuNm1LNXl6QVh0d3BXZjVEdzIxdUV6aDRoYitv?=
 =?utf-8?B?bitHVkZ2ODdVcmxPdVVVeU5hMzVBRUptRm4vTVRYb2NYaXZRY2taeXR1bUhs?=
 =?utf-8?B?QXdnSkhzK252T3E4YThxcmk0QTJKdm56R09qQjUvNFNHU2lDMFdHOXJkYWQy?=
 =?utf-8?B?VVFwT3JtT09LeUdub1ZwWFhOYk90ckFlRnM5SDZWVlFGT1d6ZU42Y3NwaUNl?=
 =?utf-8?B?anRYUGloVTM1ek9Zc1BMQjh0ZUhvSDJHbnFOai8wNzFjSkxrSTlhM2dWV05I?=
 =?utf-8?B?T0NlNnNZQ3BMd0ZXMjFmaVd0UW05RGEyWFdNR0pXMzBYNEpoRDdrNEE2S1VO?=
 =?utf-8?B?ZXBYK1BramZrQ3hYL0hqdElZU0RtMW5mcjByWWVRckhtWmNKeHVZN0xKejQv?=
 =?utf-8?B?WUVGWDJaNzNZYXFJSE5mZ3g0R0doTVppRlZoeDVBUEFIY1Bjd0FubEMvSFZC?=
 =?utf-8?B?aVVIOEh4aUtXVzQwc3p6K0JUK3RHQWEvOE44QkU0MS9oOWl1RWFWdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ebad8a-6fe7-4144-6a33-08dedd53e275
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 00:49:08.6500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV/WrzQE7waL5qewDTAYwrtpQNXfE5j/65Qw3YcL8wHTpbiNUGA/hl/EWtS00DarXf4aQqmO9dDCPssRJSl5sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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

On 7/8/26 5:16 PM, Alistair Popple wrote:
> On 2026-07-07 at 04:24 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> On Mon Jul 6, 2026 at 7:35 PM CEST, Timur Tabi wrote:
>>> On Mon, 2026-07-06 at 15:34 +1000, Alistair Popple wrote:
>>>> @@ -38,6 +38,7 @@ pub(crate) fn get_param(
>>>>  
>>>>          let value = match getparam.param as u32 {
>>>>              uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
>>>> +            uapi::NOVA_GETPARAM_GPU_CHIPSET => reg_data.api.chipset() as u64,
>>>
>>> Can we assign these IOCtl values to match Nouveau as much as possible?  I think it would make
>>> everyone's life easier if we could use the same user-space tools/libraries for Nova that we do for
>>> Nouveau.
> 
> I debated this, for the same reasons. However I came to the conclusion that it
> wouldn't make a big difference - Nouveau only has a handful of GETPARAMs and
> we already know we're going to need a lot more for Nova given the increased
> scope of features it needs to support. The rest of the API also needs to be
> sufficiently different so I didn't see any real practical advantage to keeping a
> couple of parameters the same as tools will need updating anyway.

Unless all, or nearly all of the ioctl values would be the same,
there is absolutely no value in trying to make a small subset
match.

Let's not get distracted by this. Nouveau is sunsetted and we need
to focus on building out Nova--without artificial constraints that
don't add real value.


thanks,
-- 
John Hubbard

