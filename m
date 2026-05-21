Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B696ECD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 12:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BCC10E499;
	Thu, 21 May 2026 12:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2YWBfu4G";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A3110E499
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 12:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/WHCUxg7uqsHKzKA8Sj7k/XN1w8BbNFe/EXi5G+micd3lIXAg92BmgFtYSFsEpkxvw6c1M4U0qVb6uQrrUOGpL/S+jZX2P3Bp+0MEkXf6I4J3G8DBq1ZNLNaPNcGHBkwESlNxgJL2DJ3ACFzYJWLR4DajOF1A8oP0nJ+wGZC++Fl2Eg3E2JCW0G85edvQ6WcRYG6qMcFiJJAuGCyf4C12FWLMNVEGoyuXlxxSn4quOTlIFqxKmHUu53B5A1SJOAtxxEv9v5bYI1VmfrXTS6p0atAuTQgtBYibnqUco8X7fUH0j4W6sw4ax5fwHnQedW8MWDRP/HM+sEg2kAxxUIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq1j5axLZP6I8uQ7fCZBjWPF/2TSBgqr8zLjjoBZbSA=;
 b=NqadLA9czqwJWqoOl8OlVpdT18VTys96mKB74mbLBoNiFplEpeErzslmkgLLCXOqx25wOU2XsaaugA4PyUtq62k99gS0i+VhhqqIp2xMZX7C9l9h+7+Wkr/3wWNcFyaYevYTekbpLUKcxkeyvvn2SJE1E36P6It6OftDXSZqyKIqufAQe/rgOQ3iTc5mzgvWNBv3tsGg3gqty9RjY+UIdVoY+M7COZIBuvOTAdZWY9w5knHtO0HoZ/BehlysxICvaftPBltgREATZFKRxvndo4Egj9F3fvN8GVtY3MbNds9fSOIcVgU9eK0PnCt+3YicRFmdmPWBr2TZIZZ7h0mKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq1j5axLZP6I8uQ7fCZBjWPF/2TSBgqr8zLjjoBZbSA=;
 b=2YWBfu4GpZjuNCP5JUZ4ctgLeLv+B46JGspfcMxTmedVsLgSeqCixBVqdja3hUXlIVWFCFoxa/sMRgiB7tUmYT/CZQP45a40BGsDmi+vX7ld2eqj3TOnKvuLbK0gMj261X1/CLA56wutemga8UROzFsv4ckD9J5Q0rRmEkw/GQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 12:19:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Thu, 21 May 2026
 12:19:16 +0000
Message-ID: <219d9501-c46f-4d20-be92-a19965e64e5c@amd.com>
Date: Thu, 21 May 2026 14:19:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dma-resv: Define guards for context-less dma_resv
 locks
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
 <03a57011-e734-4a74-aef2-e3a6016e15fc@amd.com>
 <20260518111456.30ba9bba@fedora>
 <a9ee80aa-0c9b-4bd7-87bb-d3e228357b18@amd.com>
 <20260518161531.331cab2d@fedora>
 <d793568d-9611-4174-b9e9-c71ffec5ae93@amd.com>
 <20260521105402.4bc4b1e5@fedora> <20260521110100.598baadb@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260521110100.598baadb@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d947266-98fa-40e0-088f-08deb7332d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: +FpdX3vH/6BsMB/b4r6AJNBWFfKvmgSBIyVbHIO+kynR1FiKUXpamWRg9faDvEXD2/9G6XHMLP3uy06gGCnZMEaEJZj3RDC3+VmiR9f09DsoVEhtsJbw9dyDehs6bCws5NcrgqJeqk7YbKzYNpl27zhGBEJFlr66trWNDsWKtiWfbJiZ+Wy4BAWjfRdolFTVGtDkC9hkCy/PMVsUjS71lR19SOhOvzckxajBIGmdW6mRMQbNYfr25PppFeNGqYqgcSmYzyiEQdFga2phmyddOT4Ww/Raf63xe0yDjlfOX183c49dd8KQ10NbrvGl+NKoT8xVgKaxnPKH72jMcm4r2m7asUXRkDAOPztOiwabNRMMlf4L07OQt17NlFrI0A3wKvbf3B1TM+3+dBwMR1OSUjvpROewJtZk21++aRE9L0LvjLBIHsrl8uy5WIAbn8hwmNN0BG4xH9T8DI9csMEPrNEt809c69UyI/3wTiKMAQfUDWudGfqZiyXUnlLpYVLWzz12UvYR1FQpqLL/t5iPc6I95UAzHSWWlfG5IiFMhVBo7M26DpgNwi53AqJoWpe5g2oYEf1UsWRYxsx5KqqUWy9bw1B6COPK+Q7DBo2+IeeAU/HQQuOvZmwmzVl58lpqZN3F4KK1Hg4P+/kVocN6Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHVteW1kV2VZc3U3WWluREtXQ0c4SFVyYmdjZmVtMlp2RU5EcGFoTXdaMFFv?=
 =?utf-8?B?S0NUUVNpTTRGOWg3SHg2WmEyb2FGOG1vZFl1VEpVZGZ3YWRiY3djS3pwTHE2?=
 =?utf-8?B?eGluNk1CZVFlaTZLdFA3cHdwYk9iNGRIVFdTSjAyRkhidnJ0bGEzR2FKQnZ4?=
 =?utf-8?B?a2srMXB2dXNzaVltYzliU2E2UUdxTEdWMlFITVUzNldoTFE4UzFpa21ZaFBy?=
 =?utf-8?B?dnVmUVluMEg5eEwrcjhUVTZuMnhzMlNGMTJXSVBRYmZlTVJzdWZkOTVwYzV0?=
 =?utf-8?B?SXNEdExJTnNIYWZ5UVEweG1TR1MycldTWWVBNjJxVmxEdFZDN1hFV21FZW93?=
 =?utf-8?B?eU9BdFRMclFlVXNRMHJIZ3BIUTROK1J5YjV1SGIzL1YrTkpHVEh5QkpvYWJS?=
 =?utf-8?B?U3A1d3g4Si9uWVkrbk54MzBGSmZ6N2JrL01HSmp3TlQveHd2R2RwaEM0bkhV?=
 =?utf-8?B?VWZoL3cwczIzNVUwbjRGVXNEUkNjU2RxQklybEpnYk9JU0lheC9jcVQwdUlV?=
 =?utf-8?B?dDJFQnV3azdrN09vcWlUeFErUHRtYXE0ZFVXYVN1UnFsbGV3WWUvS0RSWVBm?=
 =?utf-8?B?QzFVRnhhRnI1QmR4dHVuTzFzeWpVbm0xYWFxQk41VlJBdDk5ZVp3VWs3UFFP?=
 =?utf-8?B?R0FpWWdUNkJPcElNMk1pQ1dtRk1TQmF1dU9NMUlvMkt6TXdFSHZvbWo1VFdG?=
 =?utf-8?B?R0ZMaVRFMHUyS2RSeTd4VWRJbE1maUdvU0VnR3BxbnhkVDhkVHh3Y1FCUmJ3?=
 =?utf-8?B?ZjRsU2orZVQxOEpqYUZMMjZFNXhvUXVHdlR5ZURZVytzUzZYaXorbFUzbEhJ?=
 =?utf-8?B?MjN3SlgyY0J3Y2tuSUxrNlNyVVN4UzQycUEwRmM3Ump1Y25mY2RoTkxmcEo2?=
 =?utf-8?B?eUxENlF0L3ZMSDMrcERxMmlVMkgxOEpaYzZueDRpN3hJd1Y4bDlqem1tVE5i?=
 =?utf-8?B?Q1VUVlN0NnNrdWYxUWVvdHNYNGJ0bk9OMGh1MUpRbUhDS2RTcFNlb1k0ditu?=
 =?utf-8?B?NnMxSmMxdzVlTC9NQWhtdVd4ZEJNZFFrMnR4emlVYndlTloyMGs4NGsxWkxT?=
 =?utf-8?B?Y29rOVJmRCtySHRsRE1waEJLRERwN08rejFDWkY0OFozdjdoRnhMQVltcThy?=
 =?utf-8?B?d0E2TnNKNGQ2TEJoUWlrUDBIemVTVGQ3QUtIa1RCQU4xU0VWOHMxd0JFMGtG?=
 =?utf-8?B?empTUHgxVGZrYjMwUkk5ZGkyZjFXb0JGZjNQT2EzdVNla05Yek12a3piTU9X?=
 =?utf-8?B?S1pnUm1Ed3lJUVgwNzdkN2JGZGc5Q3MwZmxuUkZ2SGx3c3hGZHlaN1JxSERS?=
 =?utf-8?B?Y1FkcW9OK2gxbE9xYWtEWEdEY0pScHM5TThMMWN0TkdzUDU0Ti9WWjRjOCtJ?=
 =?utf-8?B?eURiL2NpT0NNcXk5ektSd0NUeHZYdGxrVFM4QTVjR0lTUHQvaVZ1SFg1MzBk?=
 =?utf-8?B?R21NNjMwcEhkQzVqeVhyYm15T280Z1YwV3JBY1JBTkluNjNGMHUwampWU3FE?=
 =?utf-8?B?cmR3SEttaW1GbE94QWxKYVJxbzZ3T3FhcElCUGZKa3B0bmV6WW82N1NpYlZB?=
 =?utf-8?B?ZXh3UHVoUFRlcktJdzVuMjBBYitrTDVrM2M3RU11Mk1udGJ2SldhRzB2K1pV?=
 =?utf-8?B?a1Fpdm5yMWpVMWRBZXFPUEhRSjRESi9uTjlZdEo2OVhOeEJRUnJsa2tMS1F1?=
 =?utf-8?B?LzRWR2tHTWhibzd2bm5tY2FBWXE1M2tGcUVhS3RWY0dkc2laNmY0MWNVcWwz?=
 =?utf-8?B?TzVOWkJEZWZpVVlZV1N4c2lZVEt3QzN1UlVHL2dpQTBJTXhyUVBvektQbWtE?=
 =?utf-8?B?RFY5bTZNU0RKNWRaMW8rSDllaTV6NlFpVlRoUXc3eld6dFNBdCtJV0lPbk4x?=
 =?utf-8?B?UlJESzRhYnY0N0VGMU5mei9BSnJOYW5QU1dPT1I5RGpEcnR2SzdkRStYbktJ?=
 =?utf-8?B?OWg5dmlUdmxJYy90VFZEc3ZxNHY2bzdSMmI2VE1aNkJIdTVMQU5WQlo1MXV3?=
 =?utf-8?B?MDExYjBlcncxUy9NS244U3M3MzdabGxVK3drNlBiV0VxeE93ZkNaZGt6WnIv?=
 =?utf-8?B?ZFlKNVY5KzcvV2piZHRuV3BhWjJEaHdWWVk4MWt3eDFWWUl2aFNPYll2bVp4?=
 =?utf-8?B?bkR5eXJPMFpIcUsrWVVwaThYODUzZVRHT25OQlJObm8vSElubjNPekpDaC9k?=
 =?utf-8?B?TDdvMDhkL2FBbldMZGhWS29tejlucUszYXhJdUIzOTh1SWxZUkYyNDVZVS9o?=
 =?utf-8?B?a0xsVy92SHdYaVU5N0tLYkFiN2RHV2YxbkRpbWZINGlTaHIzdFNZckNMb3ZY?=
 =?utf-8?Q?0pM7cEpkEwejUe2Kxx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d947266-98fa-40e0-088f-08deb7332d4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 12:19:16.6048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKCPDV5Db0U/izFa4hcdpMXczfP+kaa1qfeE93ZjbTDks4glmWJYuS/zFmRgozSA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
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

On 5/21/26 11:01, Boris Brezillon wrote:
> On Thu, 21 May 2026 10:54:02 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> 
>> On Thu, 21 May 2026 10:36:47 +0200
>> Christian König <christian.koenig@amd.com> wrote:
>>
>>> On 5/18/26 16:15, Boris Brezillon wrote:  
>>>> On Mon, 18 May 2026 14:18:41 +0200
>>>> Christian König <christian.koenig@amd.com> wrote:
>>>>     
>>>>> On 5/18/26 11:14, Boris Brezillon wrote:    
>>>>>> Hi Christian,
>>>>>>
>>>>>> On Mon, 18 May 2026 09:10:23 +0200
>>>>>> Christian König <christian.koenig@amd.com> wrote:
>>>>>>       
>>>>>>> On 5/13/26 18:58, Boris Brezillon wrote:      
>>>>>>>> When used without a context, dma_resv are no different from regular
>>>>>>>> locks. Define guards so we can use the guard-syntactic sugars for
>>>>>>>> explicit/implicit scoped locks.
>>>>>>>>
>>>>>>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>        
>>>>>>>
>>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>>
>>>>>>> How do you want to upstream it? My preference would be drm-misc-next, but I think I can live with a panthor specific branch as well.      
>>>>>>
>>>>>> Everything Panthor related goes through drm-misc-next, so drm-misc-next
>>>>>> also has my preference ;-). But I'd like to wait for more feedback on
>>>>>> the other drm patches, and there are a few things I need to address in
>>>>>> the panthor patches anyway, so it's likely to take a couple more weeks
>>>>>> for this series to hit the drm-misc tree, unless you have a good reason
>>>>>> to fast-track this specific patch.      
>>>>>
>>>>> Well the DMA-buf code itself uses dma_resv_lock/unlock    
>>>>
>>>> There's no use in dma-resv.c that can be converted to guards. I gave
>>>> dma-buf.c a try, but just like for panthor, I don't really like the fact
>>>> it's halfway through (other locks still use manual locking), so I'd be
>>>> tempted to convert everything at once for consistency. If you're fine
>>>> with that, I can give this a try.    
>>>
>>> Well depends on what everything means. I would only convert dma-buf.c in one patch and nothing else.  
>>
>> By everything I mean all type of locks, not just dma_resv ones.
> 
> BTW, I actually did more than just dma-buf.c [1], let me know what you
> want from there and I'll ditch the rest.
> 
> [1]https://gitlab.freedesktop.org/bbrezillon/linux/-/commits/b4/panthor-guard-refactor

Yeah looks good, just reorganize the patches by scope and send them out as patch set grouped by lock type.

Thanks,
Christian.
