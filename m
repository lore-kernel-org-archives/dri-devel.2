Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D8AC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0CC10EA5C;
	Tue, 21 Jul 2026 14:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xHuj3Lf/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA6410EA5C;
 Tue, 21 Jul 2026 14:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z36/sLUmn9nEd28FNI93vqUouDUYyNRhiDp22lV9ZtzlUV611WL4mbW+vRdkUEIjdkKjgRWCriuYrcnTYRM5B7N703jQGUjTUU662e/eDgz7n6vissUQVY77dYlPOaH8b3FbVGeGsoODeEHBOx1NUXd26arJ6zRyx8R0Vgd/3LXXLP9KUPGJMsUZkp92blGu9DHU8hM/Ondc/WDpeLmzSRHueKHY9ItCMR3kaTGc/H3ZG3k47dI4b7l/hSVRX8vO6aToiBgUg6S00QMQ5vfcKm0Kfd7zThxhq823hzXXaJGBUxxSQIlcEqWOvFwnqyCLq2cfD5xyBSgx6YGx7sqZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Px5xoDgSRAwDpjI4lKFNkd45i6dCDJqQ5jGnywxKGDs=;
 b=AF7ohTQyOwNrwkedli59JuqwPgWmS4DjQPbRZcDUL74qQjeJGTbU+fJlhBsf9yhxq/Y0Nnq0BblRl7+vMbKMUPeqeEHwnMGi6p2tYdE/9hI3r1tmGQXKM8xnBkvdYNyvCwk2pygYP1qtI8cGoKxpeMgLX5ns9Ty242JksPx22Hp7cxeWvz3MHIqxg4EbLQO74I+iuprjxVdFAcW+g9DG35vIQmFr0UlwKvGb3xIa7cQYuT7llGk5quUJQQmUXnZNpxcgllpAdUb81yqW89SFPO67o9G8Zv4IzMofNzslEE0/Gl5E1J7Vx4/MbRru3w3mZ8GAdM8YV52bADIYHijKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px5xoDgSRAwDpjI4lKFNkd45i6dCDJqQ5jGnywxKGDs=;
 b=xHuj3Lf/sR+AnKFzS0TdvacD89am9yHCUfA+3ynJasa3x7W2BQeWIaFxIKsppToYn6qWLtxKSHkBwwmSrQICuBXpnklhFFpY90kPFfmYHXIXvkvKYclh+7em4sLoQQSfJ7lNIK8YSG5A9J5g+w8V8Ym67WJnFbEBZT5BKBs7yao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 14:39:32 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 14:39:32 +0000
Message-ID: <c18739cd-0b66-45f9-8637-67ac1f95b29b@amd.com>
Date: Tue, 21 Jul 2026 10:39:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
To: Robert Mader <robert.mader@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Daniel Stone <daniels@collabora.com>, Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260703073230.19982-1-robert.mader@collabora.com>
 <6d8806b8-fc71-4699-82c4-7189a0ea2284@intel.com>
 <bb5918f5-a6da-4908-9332-18e0df39c005@linux.intel.com>
 <7d58b289-eabe-4d68-9080-c7202b0f60a0@intel.com>
 <d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com>
 <361dfc91-94e8-4289-9b3e-5280803d9257@collabora.com>
 <a7887776-c26c-4f6d-a662-2d8ef005ff4c@linux.intel.com>
 <2fa23cb1-b4c9-459b-a0dc-31960313a243@amd.com>
 <b670d594-0582-4c91-8264-88d1de5de1d8@amd.com>
 <9339663a-a0ed-4b7d-968e-1ced87db7c65@collabora.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <9339663a-a0ed-4b7d-968e-1ced87db7c65@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::33) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a2add6-9008-4fd3-06c9-08dee735e0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0cz48jAVSg5CdGtHSbq+ICu9mb/x1uR/61Xjaod6CiAjBzWujEQZX/6kmKnmZBVVEk5ltU+CJTtAk3lbmPTJZVytl7H3vJrOTkHcs9ZDuhzis90qLssjG6f2A0rQt8rUPSGVAi4+4ls8gOaHLLpEVfXErZzMOoBgSR6BrqCBkX8ugOLu3JbisaY9LDxuyLtPe2tWMv98Oxw4XGS7rmY818KlvqhZw/mUUvYQ2SQTAQe0DwNhTmOB9/c1o8M7cRAzcrFJ4geJpbTpPpqCRHXsF5HoxgTYokIICFWm1xEbStaqtwRaq6CfQc8Ob65c4LaIqA/sEiEncCEU/JvC/eSplI4RxuLemaM1dh2mqKQG2CqkDWSdktgNrjdMEWz2+thw+ACx1+h2gOXOSWDmEpViNJMmflR+J619iyrWLKGJggQESty3lTQUu9Cwh7czaPfh7RxobUFaqjeiggTV3mMWcp5SCHvc1J+Znb6KAJZw812ZfKAWbvzeWqLNy2rwTad5gyrxmEZC8SXV32sK9pFPjaKAfX4JFaRUdVY5iyPpzitOycGTzsxiBYMRkcyCTmTGNeeW9aXx9DizQpDFQUuOFJ0F/jSeozWHoPriEiLc4SYLPoCb6cv+5y9g3jMhgR7KCJLRAK33Nz+YDjKQn4KilrDG4HougG2vjo3c/j51nwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7003.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUh6aTRwK1ZLMHlHRjJPTkl1aVN6WUY5aU0xTkpKdHl1M2xZYXlwelRRRzBy?=
 =?utf-8?B?Rk5GQlZjZE1qRWFHa0FKWkNkTzI0Mk5RQUhPUFNUbEtselVtUmtFakxqYTRE?=
 =?utf-8?B?UDdudU5ZMGMvUkx2T0VhSXVuSkhkMjZob2swdEdhOFNGRm9kKzFCMVc3ZEFQ?=
 =?utf-8?B?UzkxOC9zdjAvZTE1L3J5Z3cwZ1VLS0Z0N1VtN0JPb3hJOWZFRSt0UE1wL0J6?=
 =?utf-8?B?cDRTdEZXcUpuN29xVnM4dGhnaWJpN1B2THBvZkJtOGl6K0t5Y2RZNUJ2TGM3?=
 =?utf-8?B?MEloUXJtT0RSSmRQSkpCN3pXd2ROUks5blIxSkgzVm14ZW8wVDk4L2hUcWNt?=
 =?utf-8?B?YWhQUlV1QzBIVHJ3OVpZL1E2cm1weWNXelg5MTRsT0RncGlrNzhMUHpIZ3pI?=
 =?utf-8?B?bTNpOTQzcTRLdUtmd3BScHd6UExwWGJzVWtiZ3FWN3pwZk9WMlQ3eGpOTzN6?=
 =?utf-8?B?VWZmUU5TS3BVTjBqanQ5OWZnTm5pdFVRajNEOWxvVFozOGx3Rlg1OUQ2SWl2?=
 =?utf-8?B?MkVnTUxZOE8zY2M4aDBLSmdRZmlXTTdzQnFPM2JtWHFMT25uRmtGaGxsKytL?=
 =?utf-8?B?ZDNpeitxQWxNUlBjandPL1J3TXdMbG1ESHc1V1Q2L3VRQ2lPSlhnNXlTT2li?=
 =?utf-8?B?RUFUcXNKWDdPUWMza1RrMHB2TTU2SDZSRFpPbUJPVUo5WGVUeXV5REllUjg0?=
 =?utf-8?B?cWdRa0haZzdOTzJIb2JYT3lRMWV0NDdMZk9nckhZRkFWZWJUT2hxSmFBeHpC?=
 =?utf-8?B?L1czRXAxMEMwRE5GYWpSYTN3Z0hMckZCYnFKS0lrbG44a1JjWmxqcWFaV2tE?=
 =?utf-8?B?bG54aXcwa28ya3dqVnBOZVlRVUcrWVpEZDI3WjhwT20wRU5jMnpLVHBEVmpV?=
 =?utf-8?B?WHcyMHNlV2ZJVTJabXliem5WWWhFdHladEJuNmMybUtCWCt3U0ZhODk1am8v?=
 =?utf-8?B?QWZYQUgrcDV4QTRWekREL1JDbFZ0cUtuSnJFZ00zVWU0bER3SnVoWEkxUVg0?=
 =?utf-8?B?d0lheWtScDRWNE1ZL2xNK29JdWtHNVFlaVhTL1Vpbmt3ZXhseG1pZ0Jyc0RU?=
 =?utf-8?B?bk9ybUdkNDJNeW5SQjZEeHVockdyMXgvTkpOdFptMFljT212bE1UUTdwVGY4?=
 =?utf-8?B?amFxQXc3Tmx6eDNpb1VDK2NmT283UUxtdXd4a2NEaSsySncwNFNXRG5Tdjcx?=
 =?utf-8?B?T0R2bUNiMU91dTNNNVhYMTgzVlpmZFBvMW9zR3F3eENDZWZhZHNQYUwrYVlt?=
 =?utf-8?B?eWhUSFljVFlTL0NYUE85Tm9CTVRoSDByTlBDM0FzSmQ1WHptZUxyeFJ2RHMv?=
 =?utf-8?B?Y0F4bDQ4NUxHV0hxRHNxb25Iekk4WFY5RmZBNDg4OWhPM2R5ODNvMlNQNEFR?=
 =?utf-8?B?U0l0S3dCMDZuYzRDTEkvVWk2elpONFNBQnJ3N24ybXhaOXNQdDNSS2R2Ylls?=
 =?utf-8?B?SmlZOVZucnhWMm5kaG1Pa2RiYVNtclVzMGh1OE9DOU80M0hDajB5ZlplcFdQ?=
 =?utf-8?B?REFnS0t6SXJYS01oRW1BWXlvOE1VRGU5UWZYbzhCMEJBbm1CekJYUHJoZmd0?=
 =?utf-8?B?SlVNWmpxOUZwbkJSRFhUUDZ5Um9NSmNuMFpqUHFTY3BBUEV4bldnUDN5UHRM?=
 =?utf-8?B?NjNuZVhyZExhZ29MMzZhcXhOYldSRUc2ZUF4MWxuNlhoQllNV0lobHE3akE2?=
 =?utf-8?B?dmN2a1lNM1ZjbFNoeFNpMThDcDl3UzdaUkQ5V1RQa2p0bXF5OE5yMUV5WnlU?=
 =?utf-8?B?QjYxSnZvdWJFbXM2ZnV4RWUxVjc2ZWpyL1JOdUM3QkFyWmFLQzROVysyUGlk?=
 =?utf-8?B?K2dZQVRNcFNQTVc1dnI1NGFUOXR5VGtWK3ZDUE5WNzVhTTY0dFNaZXNvdTFB?=
 =?utf-8?B?NEhCb09JNzdoQTFoU2pZc0lPTmZOazJYMCtyMmorcTFDemdDSEMrQVR1dnpF?=
 =?utf-8?B?dFBHY0JuUjdRRzN2c2hVV0dyZlF4a2lqUkpUQ0dWNEhZNTlnOGxaNHJuTXAz?=
 =?utf-8?B?TnU2NGZZakVIZmdRVzk3c09DQjFGYVlqQW5VaXU2anRoZGJaMGJpWTdvTWVR?=
 =?utf-8?B?T0Z0WXBRRnI2SjVDTmp6a0o0V0tXK1FPYVh6Ty94Mnl1Y281S1VVWVphZnd1?=
 =?utf-8?B?WXFqRm9FNytiMy81bzVqa0RFTU9PWXhac1FHdGRKanI1dEdvd1RUZDFGb2hY?=
 =?utf-8?B?Lzhpcnk4ZTVOMmZTQW50bUMwR0pGMHhjdnlXVXVyQ0d6S2MwRjRDRW02eVZW?=
 =?utf-8?B?dXg2TmVSV1JCNEFObjZJaElMLzlDMzg1MlkrRzhSTG1waTd4MU8va2N3dVpV?=
 =?utf-8?B?Q1VXQjYxS2s4amZpS21RNE1CUnkvaHk5SVV5Qk44UjdaZDRZdklwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a2add6-9008-4fd3-06c9-08dee735e0b7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 14:39:32.5735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n842ZFbJfIwkCTzme/QCKwSdec5rDi6dxzpA1B8q7h1dPTol2nfVihFT1d3hxA+/Zs8rdCNWcMykEVhgzwXhag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
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



On 2026-07-21 10:15, Robert Mader wrote:
> Hi Harry,
> 
> On 21.07.26 15:55, Harry Wentland wrote:
>>>> ...
>>> If I understand you correctly you suggest to map legacy COLOR_RANGE and COLOR_ENCODING to the new FIXED_MATRIX colorop in a generic way, instead of having drivers advertise them separately. Do I have that right?
>>>
>>> It's probably a good idea. It should be easy to make that change after merging the Fixed Matrix series with YUV support.
>>>
>> I sketched this out but both VKMS and amdgpu have HW generations
>> or configs where no color pipeline is created. For that we still
>> need the current way of COLOR_RANGE and COLOR_ENCODING handling.
>> Because of this the code to create COLOR_RANGE and COLOR_ENCODING
>> based on the color pipeline is not really simplifying things, but
>> merely adding more code.
>>
>> At this point I am not convinced adding helpers to create COLOR_RANGE
>> and COLOR_ENCODING based on the color pipeline is a net positive.
>> Maybe in the future that equation changes.
>>
>> If anyone is interested I'm still happy to share the code. Just
>> let me know.
>>
>> Harry
> 
> thanks for taking a look! I'd be very interested - mainly because in my understanding the "both VKMS and amdgpu have HW generations or configs where no color pipeline is created" should be fixable:
> 
>  1. For amdgpu every hardware generation supporting COLOR_RANGE and COLOR_ENCODING should be able to create a color pipeline *only* exposing the corresponding FIXED_MATRIX colorop, mapping to the exact same hardware block internally. I hope that shouldn't conflict too much with the current architecture?
>  2. In case of VKMS the "enable_plane_pipeline" config could be adopted so that - if it is disabled - the plane pipeline is still initialized but only the FIXED_MATRIX colorop is added. Additionally we would need to disable DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE - possibly by a driver cap similar to v1 of this series - so that userspace can't enable/use the colop-op directly. As a result, VKMS with enable_plane_pipeline=0 should get the legacy properties via your helper, be able to drop explicit handling of them.
> 
> Does that make sense / do you think that could work?
> 

That makes sense and yes, it could work. If I have time I
might give that a try.

I'm worried we'd be still adding overhead by creating this
fixed-matrix-only pipeline, but once we have code it'd be
easy to see.

Harry

> Best regards,
> 
> Robert
> 
> -- 
> Robert Mader
> Consultant Software Developer 
> 
> Collabora Ltd.
> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
> Registered in England & Wales, no. 5513718
> 

