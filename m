Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E938C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EBC10E423;
	Wed,  9 Sep 2026 13:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W05s4Wah";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013039.outbound.protection.outlook.com
 [40.93.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E2410E423
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVxGlTCOOqkkK+0A8jRvx0u8IL6gO/oO4E2h5xKqypZvptyHfmQLPd1lewnVYWZLiC7m8WaCDs52WAw4QKoajaFKoQlVRIxDCB27wx8ehDeXF+2UD5nXTtOM4G1UCWKVqlvN3jz01QTy9DIg7Bf3EyHhmYLy7d1jsiVGeVuKgNC+v8/8yv8rn6touQt1f2E0znGhGdBCaLTEQriFJ8rWAQuD4nUL9nXIQgoYPq+7JiompM02Sc51mV0q35SdgOa/6/Bacfc8h1mjTl4gfjpVn/Uy2c6s9DWPiUnEJfHe6uyGF0/pDz2+X7949MbwITBX9WnNLrrPAUk1VEtiMNgREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3VMbNmywhVlar9ZuhJoEpWNBCtC2idH5q8rDCnOAA0=;
 b=AFSww96QkgCd4hpaSsHuTPHJQ/8saX40vXpwETa5l9gveMfEdwxZNALXpoGE9McDd6Dlow6gCr+9LjxVA3A7ITALJZYzxdp7HPz6vRQ2mk2OBba+TXAyyzLGHMq8eJQWVw4HHmF9N6qof8SQKCElKBkiwddVytE3+XhbX1Q+nX0LdUbjaycDuirmRsgnUHgxDlyBvsRjqhkUcYPmhqkifa80Q4mAVkzKZGHOXioamDRSpPW+zBmlHjWHns0LALxJixJhwvFKdRxzzNsIwGPtWLBw13JGlMM9X9Xq0kEAjIL5BUCi7CWF+xYfv6DjKe5Skh160o83LK3PQnAcBsHwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3VMbNmywhVlar9ZuhJoEpWNBCtC2idH5q8rDCnOAA0=;
 b=W05s4WahjUwSjTCyjz4p0fT48dw9DNF92+V0vzHf17FtVmXS92/h5HaNbnNS+k1BIhnZcq4tH0CP0sf/F4RSG10Qnr4ir/FjB+dRTs2TI5O1ggDS6l36JlhMvM7tJ+swpe2+vqM06uX03gFk5BrQWhlCaGfAY2dw1KMEW5o0XYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 13:57:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 13:57:12 +0000
Message-ID: <5cfbf5d7-8729-4924-8ed6-eabfb53600cb@amd.com>
Date: Wed, 9 Sep 2026 15:57:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/sched: document the RCU dependency
To: phasta@kernel.org, malhyuk97@gmail.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
References: <20260909131808.2201-1-christian.koenig@amd.com>
 <20260909131808.2201-3-christian.koenig@amd.com>
 <9dedaa001c468be2afaf6ab19cd4f8cd96d0a8c7.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9dedaa001c468be2afaf6ab19cd4f8cd96d0a8c7.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 2268aa04-491f-4c97-6c06-08df0e7a3fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tKR+dVCZmyqCeAArqU7FvN66/MDbTf7wlyzmz1om5o9Qbv/Jz/K1CsQwatxIqRw0RUW7+YVtBaae0+zMxLW56GY9GQsf1xbPMbBcawbIFvnGyT5QgQtngvMr0I4E6G2S2OkKP4d20a2hXgq/+fmmHwUeOO3tCB0LBrBaVr/2nZ/wpEWmzhEbXSbvvZUbr0CYZoZAKwfRObYdqY9kV2yiaK2z1hQVDuIOkxbJoQMTk0cs2tm5OEamuuHRHqGIN9AhLLo4SIdV9gEXjH+R+Qdp/R3vxk7bLQSisKL2c1ayBjYDuGJIu21/oFT3KQawiUjsE1diB35bLT5FfV5fANpIgVQsqwAgp7apF2AayC1xsHJTVDz3Nkw3HQ6D9u5qBQniUoiPi0XByjg6YUyuOHvZXnD89AUBQ67DkbMEzhlbg391/lZE09IR+oCdDkJWeVH+WeSdJPqRICzi3cd+kLh54O+vEDLAzGPx769C0cDVwHgoPqfKrGYm+pJylUyrd89c8ikP2vfAGkqcgMfnyBVfdkqlfgbtREwdd5m7/RqDhVhIOb/NGJeI+ZXGdqVfx8V/URYvNUpaDaIh620WDDIq6M6rzsGP9CumuWWbEbymuRGdzQUC0wUBXmQn1ls45hYJAx9DW+fuo75M5FGoqACodvP0Yjlr4nNq7TtyUYpeDAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2JoZ2ZOck1hT2FMbXFYTzRzMlNIdEZJdG5rdWxlZy9pYnFacFhDeGczNEp3?=
 =?utf-8?B?cVhFYWRLcXB2cFFndllmb3VPSkE2M29YUThWWHRqeGJJY20xV2NnSW1YWm9Y?=
 =?utf-8?B?WFlXVGhOWXJTVDFvWTNFcDNZalkyeHRJakFkT2FYOVhSVVVqdG56UnIyWUFI?=
 =?utf-8?B?elF5c3VTZ1RLQ0pqNDFPWEorWDB6WXVIazZIbjdaQXBLRFk3VGFkalNaUGlm?=
 =?utf-8?B?Q2hXcFo5a2wwejJ5WXRwUjlZK1dwYmpjRjhLYjBYMmVsR2MwRXh1Tk5yZlBJ?=
 =?utf-8?B?SVF0aVdhSDhzNjlkM0E4dkVwTkRsdkp2cEVmWDVWV2txQStXOTdaQVBDV0dL?=
 =?utf-8?B?RmpSdHhzZTloVmpBM2YrWmg5SU5iZjdPVFplellYWEhBL1JKZ3NqT3JGS2lw?=
 =?utf-8?B?YmY4ckc5ZjZWOXZkYjZVelpvODE0YnNUU0txbE1TYU9LNjlCbWNRVTA3bkJD?=
 =?utf-8?B?dlZhU3RlbHRLQ2t6VXZJUzZHaVRWZGZCSmYzeVpheThrV29JWUF0bGwxeDhV?=
 =?utf-8?B?U1BIZEYydEtnbC9VbDFCWG05SVovZVJScDZuSmN4dmlQVEpqR1Fjd0IwckNH?=
 =?utf-8?B?M3p0b3JlWjJzaTMvajFYOHZwNlB2T3BETC9ieXdBZHVKekxMZWJaMWRPeEpX?=
 =?utf-8?B?WFFHU3p6SGRVK1lCNGI3ZlJla1hsbzFrQkZ0Rmo0dDl6NVRqK1ZpWVJ3V2Nz?=
 =?utf-8?B?ODNuOCtqRWttWk5XUUVpbHVQcGVDWFBNZWErSFZEb3JiQTY4Vmc0UGVzSEp2?=
 =?utf-8?B?Uk55eGlFbi9ZN3VZYWQxRlpoSWlWc0NOZ3lpZTdaKzBraHhNYkpIbWhNVExE?=
 =?utf-8?B?UWhyek53ZENsVjBoVmNObFY0Q3RTcnRWVmtXNXZOa0lhdnIvdXdwcFVIU0xa?=
 =?utf-8?B?dnEwUThtKzc1elRRNHl4VzZpekg5QkJSUVpUc1NJZjFPYjZmTEhnY1ptL3lC?=
 =?utf-8?B?NHNLZmpxRE9JdHU0akJSamkwNXNxaDRCVm9FMnpGSU5GM1lYbStHMVEwcmZZ?=
 =?utf-8?B?aUprTjBxU1hsL01OTEIzbUR1dm05RWdPR1B6amN6NlkvZVRMa2NCM3lhQlAz?=
 =?utf-8?B?aEpGZHBzWktxcHlmYVhOSkZmYTJ6NnRUeXpXWm55N00xVTMyRWlUWHQzTEsx?=
 =?utf-8?B?WE9yck5QSUI1THAwa0FiNzRqOXZwUExEeVg4aGROVXFvRUVKYmwrZHVrRlJH?=
 =?utf-8?B?N2sxeXY2b09iQjFWT0R4ZDZjakYrdW8rQUV1eVJickovczExYXhlVDBSWXhZ?=
 =?utf-8?B?ZGFTRTBtWEZ5elBHRjJaZVppUFROWVorN1R6cE1YYmdWaExEUTF1M2ZjTGRL?=
 =?utf-8?B?YnBaRFNmUDJGeVFpQVA2RTVrUW9vdEExKytEMjczZ0w4eWs2aFYzUC82L3l1?=
 =?utf-8?B?MFo5djk4Ym4yb1BYSWVNMlZHM2lxekJZN0FRSHpyQ2tSME9Qdk1tV1BndXdw?=
 =?utf-8?B?VDhENXFSRWdtdm9sMjZZa1FZaVRxWlh4V1g3TjgvNkNINkFMQ0JEeW1wTENu?=
 =?utf-8?B?NUVBMVFXM3BEUmpNbEt4TjJNblpQZVliWGt4K2NNYWlRZndkMVc2U3ZRUE50?=
 =?utf-8?B?endSVkdlV2JtWjR6YXVkdC9PMG9VT2lUVWxBdHFwQkU1YjE3OTNycHVLeGln?=
 =?utf-8?B?dmFZMkVDMzd4WUVKUTh0dlllb3N2ZlduYlJwNi91Y2NKSWx6USszSjZFTjFp?=
 =?utf-8?B?blEwb2thUnNLUmlQSmNRZEFIeVAwaUU3ZVFPY0lFRUdIUUh0MGJyejdSUkpV?=
 =?utf-8?B?THprd0xWSnovVERSR3VwWjl2RW9YN2l6WTJUa2ZqR094RmdtcWFIVElaM1NC?=
 =?utf-8?B?dXVXOVgvY21CMnBWYTZ3MlFGRDhaSGtORTZTbnlwejFrNXFpRU1yOU9qVFRx?=
 =?utf-8?B?dlRiVkRKN2tJdXhadU1vNDgybWxHalkrM3k5cEZMYVgvWlU4bjBOdFRJaHRE?=
 =?utf-8?B?Ri9uUnN6UVRyQTlYK1B4N001VlhIMnN2clQ5bzAwRUJQTnV0STVDakRjeTRV?=
 =?utf-8?B?ajZGVmRFUEZia1RRa1NEU3lvbWpSWW5vNFZHSUxQNE9yWVBxbnYrSU5jLzBP?=
 =?utf-8?B?cjNJV0hnVFBkK241QzcwNlhNd2t1Z0UrV2g5L3hySnN2NUVmNjdsU0luMkJp?=
 =?utf-8?B?eGJvOG9kZWc0bHhJdE5Ub3JZYnQyLzkzRUNoTjhXVXF3RmZhOVIrU3p5Qmsv?=
 =?utf-8?B?LzBQcUxWWmlBVzE4dGZLaTRicXlWNUxBTnROWjVXRjNZUWkwam50bXdrYkd3?=
 =?utf-8?B?TU9zZ1g4bWZ1QlI5ZTd5K1NGa3hBWnU0WGpZRjQwUWFaMitwRmp4ZGFIN08r?=
 =?utf-8?Q?mr9YYs+RdIGcIme+ip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2268aa04-491f-4c97-6c06-08df0e7a3fac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 13:57:12.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdgQrj+AwwW9lG2axU2bF1FZK8vaqQfoFBaCyP5qWuJk5+F0wu611iTJc/l/RwZ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
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

On 9/9/26 15:55, Philipp Stanner wrote:
> On Wed, 2026-09-09 at 15:14 +0200, Christian König wrote:
>> Tvrkos patches added RCU protection to the returned strings from
>> get_timeline_name()/get_driver_name() callbacks of the dma_fence
>> backends.
>>
>> This fixed use after free problems for a couple of drivers, but we never
>> documented the consequences for the drm_sched_fence.
>>
>> Add a few words on the function documentation to note that we need an
>> RCU grace period between signaling the last scheduler fence and
>> scheduler teardown.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>  drivers/gpu/drm/scheduler/sched_main.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index 6cb6f9546493..22103cb07782 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -1203,6 +1203,10 @@ static void drm_sched_cancel_remaining_jobs(struct drm_gpu_scheduler *sched)
>>   * is implemented, all jobs will be canceled through it and afterwards cleaned
>>   * up through &struct drm_sched_backend_ops.free_job. If cancel_job is not
>>   * implemented, memory could leak.
>> + *
>> + * The scheduler fences timeline name is returned protected by the signaled
>> + * status and RCU, so an RCU grace period is necessary between signaling the
>> + * last scheduler fence and tearing down the scheduler who originated it.
>>   */
> 
> The API user does not signal a "scheduler fence", typically. Are you
> referring to the hardware-fence?

Yes, of course. Signaling the HW fence then causes the scheduler fence to signal as well.

> 
> The user must signal all hardware-fences, which will cause all
> finished-fences (which are at the root of the addressed problem) to be
> signaled.
> 
> So what you probably want to say is "The user must wait one RCU grace
> period between signaling the last hardware-fence and calling this
> function because …".

k, going to fix that.

Thanks,
Christian.

> 
> 
> P.

