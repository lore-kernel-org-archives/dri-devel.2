Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB03BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A7A10E799;
	Mon, 29 Jun 2026 09:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jff1AA11";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C11010E799
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P58839D0efgulknsEBsbdT+uZ8di+bIKKJsXAFLyu9VH/t3/z/bBBfoz2rRUkMtOZbskWtgwB9XsJ1WRkX9V1NmMciWY58vyBHLEiSw0W/o+vxEoSdq6/Mac64LJteBr2+O9PHcNzdex4mjqE9rChkILyCQJ+ZrUrlz+4g5fUVb3IUbFhDXLQiQOFEEqiXRSjTwF4MDayfPXiayekByAd/caB+dfIr0Ldf2kEzYHW+JuMx5h9TZ1l2i/MiFHgMpP+Bpy4tT9k7KEgq7X/1inYCLaufMxH9pbkcIYYiVODwMFjUcuHu9/Kt0UwfKTBmfywtc7RP5eFH1L5o2h8lUQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zwCWDl56huYpWyV0Y2fwl0Z2ZAV8E/g7gcd18kQNqQ=;
 b=D5hdPIeME8JPvW8/FYg07vZ7pnF47waZIjaTR5kOlgoOpGnfVfMVYDH0c8uqtNyXjTS8QTB4ohmSf+WupCayrn0ipfGuxH5GEAVpPSme4ej1S/FruVNeOd5IUf/gZsuMnq5vQ9QnIOd+yrFZFmV/tZ+xOtT/zoAZot0JIqViMlIrOsnIgVuPbsdEJGnbD0bjL1JT2mTwK73MTMC1l5lUUPGSPmoeQnykjbqXKkNvCl+KyzilRnFEwuGNi0Tl9VqdAbWzCqO0hxUkTsXdhdlnKldCDYrvx3fF8GJVy220ZeT/9CTGcZ+H98OtRQuuP09pGbnBW33MidDxE539kecm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zwCWDl56huYpWyV0Y2fwl0Z2ZAV8E/g7gcd18kQNqQ=;
 b=jff1AA11cRzVw4pTMgUfd5TnjvLL3zPAgs6VXHD46wwRkrl00H54KqbUqcqZz1xoOD5fGhc/OxdHz8mWZW6OPiWv7GZsnN4ZJx4veNt48271DDuzD1MS0Zz/0QPZSiXnpohxL2d3S2IzpDDEcwBqMyTXP3Hz2WnVaw7TRf2krYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Mon, 29 Jun
 2026 09:23:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:23:33 +0000
Message-ID: <f59bb996-a46f-4b5f-9229-bce5dc1a0685@amd.com>
Date: Mon, 29 Jun 2026 11:23:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: dma_fence cleanup/rework
To: phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org,
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <c9d8f3a762601f352bd176d4ae5c7977edaeab11.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <c9d8f3a762601f352bd176d4ae5c7977edaeab11.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f4f797-4646-4658-8b41-08ded5c016cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 0gaa/VHcFdkTk5BSNzokVnaoFZfOsvDBUzvvxRcCiM84D6LBa5+q6pGzDyZOvoTioDWMiLYRmKGxV2e86UCmxpkTHL0AF2YZxTeTSricPuHy9Vku+3niy/XteF+6jEKLd9cupNHWGhhpcyVseQ7Kkkzy7ueYe/ZB4K71iOT+LvyVkqFQu8y1cwuy17zrO9UYPcX/xoICZsFQCJwDdYafZ+C7FJ+fDwOWESFiANpbul1PxHI8X4hGLAEbwzfD9NeZZ/RwvBYbobCH/9KLSpo48M6V5zmdfIdA83Z3YfFqJfXotLm42oHUNOpMgLgRTtzfGBMhgP6+MZBvLGj3jR2I322th/hAqLsiYhqSqnHuMVjjEwC4zZGbs2J/pjgU1VjfWd5gXaYrII5NLUDTiBGbneCGOtKnDz0yF7TYvgWoTjBEZiVlLTt8CO5RXstEHCzQD0q9fOgnOEy5e6kp+lxT6Or3Vq8qGl3bDsEe6+1+Li5IXNI/5c32w2e8PG7xKIl3QIwEfizri/g3OKA22QNcR7a8t11Q1MdekXNRNck/Mwy8GJbuHVzooL+pv/j30Y7nVubNYaDgjiFyz9HwQY/1K505vQrFrorvxxOTkNKswi8Ph/Z9BxS8dX+mhg6u15iWRgjuEnuEfRFOuoxTABfmypavtGtnJ3NzLb4iSUs6T9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9XYWNwZGxYYSt1NzNxeDZlYUlLaHBkTXN2VlZHS2F6eUlYL1JQM2grK2wy?=
 =?utf-8?B?RVA2SlI5OUlhWTBvK284UWJ1bnQwWkp3eE5WTUc0c29XK2lFQjhVZStkREpT?=
 =?utf-8?B?cE1Ec3BvcUNCUGFJN1N6eS9oakN4bC9DbjQvV2FFdnZJU3RIQXFkSE5RZlVU?=
 =?utf-8?B?eDUzWVBFUmViVFpGWjhoRXNyYnZ5QjlMQThOMUF1UFdxanRYM1h3aEFOY0ZU?=
 =?utf-8?B?SHhFby9NV1FVTXE0SDhVU2tqK2JJVzJZME9uVUJqTVgvQVBtREREZ3gwUVRh?=
 =?utf-8?B?ZW53WGZ6WFhsd0RvUXB2cGZVRTF6WWZGVFhiTlg2ZVNLWmZnNVJUbEVITW1D?=
 =?utf-8?B?anN0T0FoU0EvMDFNU2FLS3NnblBrVlptbE5RN3JnTVFHSEx0bmFzcFNLdU1k?=
 =?utf-8?B?UXpxZ3FOOFJzUU1tMWxjK2NyRDlWeGczTFdmcG4vZWJQUnNMR0ZsM0w1ZHln?=
 =?utf-8?B?eDJlM0d1dWxvN3ZuQUtqTUpWTHlIMEZDdFRqT2xEcW9RcTR6QTFrZEQreGpT?=
 =?utf-8?B?VjlFQ2ZUQjhFcWJ5aDBweStkRktSdFRzM1BaRWU0b1c1V0tZYmJwblF5ZWZF?=
 =?utf-8?B?Ymo2bDZQYk9LeVJFVEdzaVFIR0tpSVpIcnFHamNBVDhMUjBjNjVjcXpSODdS?=
 =?utf-8?B?dFEwcGFrK0dtemFYWkpTTnVSVElFWVppcmxRZXNXZTdBaUp0WGt4L3NvY0Jn?=
 =?utf-8?B?NkRjZ2FXSW91OE95aEtYaC9ySWU0TzhDTGg3OWMxZnpWdDVuZG5LZGY4cWNn?=
 =?utf-8?B?cFFXamdmd1JrNkZVZWNNMVZ3MCtGbjhUWTlaR3I2SjB6UElzWGZ1Q2dvUWE4?=
 =?utf-8?B?NGtvRCtONk1YQTZmNXhpcmsvMVA5SXkzMmpiNWtWcWU3bXJkeE1PMFRZd0Jw?=
 =?utf-8?B?MFBzWFowZDM2VngrZmRXS2pORzI5MHNuOTJKYVZ2Y3lXYnE2enBlU3ZuVU4x?=
 =?utf-8?B?NjlYSHJuRkpqNlZYZE1UdXoyRldyTml6UzZqSC9FR1JrOXE3cGc2MFRCM0pm?=
 =?utf-8?B?andSR2dzcjRLQVViUVloSlFNUHpseDM2MDZCeEFnQUdTcDF5dzNWYVJpbEtB?=
 =?utf-8?B?TjlreC9ZN3hYOS9YU1d0a3VOdVEvUk9wWVBnWmUyVUswMjBJV1J0cklWNkhP?=
 =?utf-8?B?Q29yVndVTHc3TUJ2MmRCck5IdGpZTW8zU1Vlb1d4V3pXTVlZZUxnWXZVdVNv?=
 =?utf-8?B?NE42SHNEeFVQdjh6dHE1MTliaDd1SGM1clRNRlNYRXMyVDF1QjBJVnJkRm5p?=
 =?utf-8?B?QWNBMkNxNXFHcFJ3NFlwUHNqQmJITFRiT0xmWS9DZnpHTDhlTjIwMU8wNnpW?=
 =?utf-8?B?ak85TCtIZk1VMFhncGtuRUQ0ZHFKaDAzdDdWV2hYSUJEbjdmRGpyeGViVkxN?=
 =?utf-8?B?Nk1nVGhnODdIOTZ6NlFYNVBMdWloOW05TVg5ZnhjVnVEbnhhNWxpSVMvbkhk?=
 =?utf-8?B?TVFNWk05VU1QZmZFa09rTmw1eDVUTkRmU3dEamhOek9vRGtuK0VaWFlwbmRM?=
 =?utf-8?B?a3hrZHBnT0VwYk50ZG93ZTgwWUxGUzF1RUlSbVdCS0VlRGhkSGVWUzVIQW9L?=
 =?utf-8?B?bzVaTitwM0hZYi8zb0JNMGp2NkdzUExKaHg1M08xbGczaVN4Z1BNMEZhUjc4?=
 =?utf-8?B?aHNOTlBrZUswZ1pRZDhQRzZjcmxtU3dON2tmaDlwNFltclgwemw0b0NZbEIy?=
 =?utf-8?B?QklnRkw3M01kcEdGTEY4aVBWQjV3aElTQnFMZ0lDY0ZDMFFoRTBKcVVEWDN6?=
 =?utf-8?B?RlhoUksvUlNkSVFqQU10VG1Icy8wVXROdUdzSXRDbVFINC9pamtnb0RzNmRn?=
 =?utf-8?B?VkpPK2lySm01RnNPa0oyVmQ1UHNlZWNCSHRXbEVLdDlaQVBHVTBiT3MyUTF3?=
 =?utf-8?B?Y2hBMnZxU1hZZDJBMHkrNW5SU1hQU0ZQWXVGaWZHTkdMVFRWa1JYSGVtNzZJ?=
 =?utf-8?B?UFdPUWdYVUhiRmpQYUtLWXVkbitxUFlhWDdORXpvenNNTFJCREUrdUx0S3d2?=
 =?utf-8?B?ZjFvV1ZydEhmalAybzhraTB4bHFtSzRIS2ZaTzRvRTlndm9pQWZUY3I3c2tY?=
 =?utf-8?B?S1U4VkdPZUV1cWZ0ck9UMm1HVzdnLzFEbTV3RWRoU2dMNjNaTzhJaUZKaTRh?=
 =?utf-8?B?V08vaEpZNXRZeHlkeU50cFhmMFNlMGt3K0Q3dnJHdExxU1NFSUtGL3o1bnRj?=
 =?utf-8?B?VFArYlUwR1luQUZPT1NPZmpKZnhxcTBoOFd6UXVFMGVXdDJKZGJFbFBtckNY?=
 =?utf-8?B?R3RWUHZWSFNiTmhoMkRlcjFNNC9oOWdXK1VwYWxHcVlUM1VhVUdEZWhnUytx?=
 =?utf-8?Q?v1x7jZkbm3BbI4Mtoz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f4f797-4646-4658-8b41-08ded5c016cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:23:32.8967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR+b0VKbixsYybSNhlJNYwDaJWNvku5i0NodG45M3BcGziz9UjtEghaMLpaCalAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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

On 6/25/26 09:25, Philipp Stanner wrote:
> On Wed, 2026-06-24 at 13:13 +0200, Christian König wrote:
>> Then the last piece is dropping calling enable_signaling callback with the
>> dma_fence lock held. This makes it possible for backends to acquire locks
>> which are semantically ordered outside of the dma_fence lock.
>>
>> This is necessary to allows using the dma_fence inline lock in more cases,
>> previously backends used some common external lock for their dma_fences to
>> for example make it possible remove fences from linked lists.
> 
> Hi Christian,
> 
> thx for all this work! I will review around a bit during the next days.
> 
> For completeness, let me ask here:
> Is there any relation, or any work in the pipe, which you would
> consider a good solution for the race conditions described in these two
> threads [1][2]?
> 
> 
> Regards
> P.
> 
> 
> [1] https://lore.kernel.org/dri-devel/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org/

Not yet, this is just the stuff we previously discussed so far but never merged.

I was thinking about adding a flag which prevents setting ops to NULL for implementations which don't desire that.

> [2] https://lore.kernel.org/dri-devel/fa0dc9757bf8343516c4b156a2b70ec91b64ef8f.camel@mailbox.org/

Yes, it should be possible now to rework the handling in nouveau to not rely on such behavior.

The key for this is patches 8 and 9 in the series. Which allows you to have the cleanup directly after dma_fence_signal().

Regards,
Christian.
