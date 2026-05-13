Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E52CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 14:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FE210EEAD;
	Wed, 13 May 2026 14:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RJ5d2xhT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013040.outbound.protection.outlook.com
 [40.93.196.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EAF10E32F;
 Wed, 13 May 2026 14:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blUfdSYLWlTJsO3ppgpYpN5HqXWQXXiAEPEn3ywyQSNXf+yt8fTvUDMfoqOIaBR/DVzuaEyAdJS11YrpD3131MhkgZaSMDWIC5eO0jT7p1C4/pO0f0F1kul9U8mh2qNirPOyk7NBFXx4eluKpxseeTEmpjkUA1sY7iIqIVOuF8pJ2GcjktTkrJI27hTs6DStce4a0JL17pMBBPfqDyEZzC8u+008DbCe+mSZM2RNL1xii5Uw9CGa6umRvTA6QOqWpZW7B+qhbrNU2xoW4HBKfNyQhRTB7bECoVC5REWaZen5W96yXfUIFFElwl0Oq0h8cfvUW0NuIzxbKTsygK6PxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxtqTqwg31rpuv89766OLYe9dJHK3/7MeQLV7E7wh2A=;
 b=V/3dHatjnSpguGwIL+Fmg3TPH/VFtY9AovI9FKr21HCd8oZM8B8/+a3/VM8qablUmriebmba1MUxir1asEswXzcTsMUMsrCfdnZ/R2QE8VeRn8DBpkgFnv7+htLOSwzsoqVy6krHLkvKJ8ih23S6q5ydIYE6W5QoUvUimo75KRZ2JIDN9z6w8nsY+GRnxJePoID8zLXRkEpcsUTN3jIUZHH0VHLZxLUXg9xr3ITUmnRmDd77GID8uFDQu77Xgz5Ge3noKVfz8129rlJflHXJx/MayNeXsfiTHh/L27K5h1dlHZLH8SLe5bpBESNQX3MDMAXArzlMQEpdUWwIkLkZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxtqTqwg31rpuv89766OLYe9dJHK3/7MeQLV7E7wh2A=;
 b=RJ5d2xhTWTn+FFL49lYL50a5my31V7BW7rATlcdx4Gb3o+uJ8PwQnUfnvpckG+yWJsVPn1A8hquyHHt/M3iSH/1YbCvm8+oNjFJxxxQsUq7I9Is5od2DziRYswDDYi3sphfox9fHxVmPSCfvzi3pHx10czB/Na5+ywtFmb7wI4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:15:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:15:03 +0000
Message-ID: <2efb0669-d0e8-4887-86ea-cf095e915689@amd.com>
Date: Wed, 13 May 2026 09:15:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Support 52-bit PAs in ttm_place
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260512223154.18089-1-felix.kuehling@amd.com>
 <c113ce66-5712-4fc6-bbf2-45239a97f773@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <c113ce66-5712-4fc6-bbf2-45239a97f773@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0176.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: d62670ee-ec5c-4aaf-b6e6-08deb0fa066f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|11063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wBascP2Bm2AmhpTU/UMkPQzHodrjTMZ6FK4VFf7XcdGKhR8ujvnEO3CjZ80DN8VjFe8h1ZKaOViwMSnPG3zfemuCMavS1K+rJywwfldrV/1OzvI6rKGD5XPQm9g+tHI6qiqO6nqvSMY97kgN/kYRdWMbvewficrgwBEo1t9g9w5cruKcm/0VxM40IOOMVAHolkireE+u12OkOCBXnP1y31XRWMWNTlt/VQiLZWa4FO8FHcqm4KGvHAECZYKVMuVuulRfGdS4QfgaCmAwt8aX7raVHWDo8vH3WLxZEtVpViAVyl98aUkljPkqY2EIR55Mfp3ZdT2w4Pb0jIZOipkGERc77kJt97s1AU5d/AJVi2wn0Z/Bn7T2HMsxAZHr002yja3E/MbeaV5mwih4vHvjAVlmnvAE2PdzmZ7DPkXJ4Akxq2Ham5KlD5D5hEODBCOGbMHGS/WcmduJKvX4T785zFf7w4AeVdLU21AQKemo5z9jEhyAdj4RnsOZX8JSSGgF+UoPLcHmzhZzDTuToVApQx68XrqtYKlq5qtcJRQIvMf/oBjMwiq/mYPkehJl8PEo9XNZvZEcMRwXCHIPXC9tv/Xi+oSTwfCzuv6/q3j96/yWVh+jw60IL9rGhDcN44UJfhhsiN+YnzodZxAHKy0/QbdqmmNexrm9LwrLFJ+9I0gLPlTD+O4Ds45vBgMvnVgB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(11063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUFuL2c5TU9jQTRTL3JaaWFuUFJiNVRWU0h3QzZmaUlXYm1lOThIb2NwTnp0?=
 =?utf-8?B?SlR4bVVFbVY1SFhNWHFuM01tblBoMmZwOSthZ0NSWkwxeFRHdWlvVGxHNlUy?=
 =?utf-8?B?aXRudWM3VlYyWmZVVDBWbGsxNzdHRDhYM2x5NXk5dkdxcWZxcE82cm1FRnNT?=
 =?utf-8?B?dlNHcDFNY1p3SlNpYmFsUFpCb0VUT1RlMGV4U3kyWEVXUEVSZXZnNjdadFFr?=
 =?utf-8?B?TzlnMEl6WkFaSThESGQ4RVBvQSszVmNPaWRhb3ptWDVBYVhZMUZubjdvQ1BW?=
 =?utf-8?B?VGdoNWdzZnVTSVlaSnBsdGlSSW5XMm5OeTZhZFZhVlM1T2RBQWdQNGhhVyt6?=
 =?utf-8?B?dWd5KzJvcWY1dDJvcTZJY1hzQTQ1Wkp2RlI1bU1LTTN3TmNUdGQ3OERKRXh5?=
 =?utf-8?B?bmJDYWdyT2s0ZTNuc2NSOExRU3Y2M3hGemtoZXROM3REcHNtYnJiSWdwbWRu?=
 =?utf-8?B?dVpSVnA3ZDdZaHY0dCthVElDTGM3OGd0NUg2clZ5VlZnajBPLzFPS1IrcVRn?=
 =?utf-8?B?YlpBb3I3VUZJeE9BTUJteG9RcnVKenZpY2FVelVmbFBlU1ZJOVVEZnFwVG16?=
 =?utf-8?B?NEUvUHUvQkJyWUlrL1lFd3dtSjZpYzNraEJTeEpBeExpOHJYWTV1ZkM0YXlz?=
 =?utf-8?B?WWdzOEF3SXFRQ2JRc3BFT0U5UWN5ZitpYThMend4b1lZUGQrNFpFbzhPaGFo?=
 =?utf-8?B?bHlVSjZlZmVHQkwzQTh4UnR5OUhmemNYRWQxY2l0TjhiN1NxQ1BuWUcwVGUv?=
 =?utf-8?B?T0toOG10VGdFTWFMa0hPQ2RCc0tLL2gwWkttcHpZM0FJWW9OSHA1MlFCU3R2?=
 =?utf-8?B?aUdhMFJzSkRQRkV3bkM1MkxyUGFwcHUvV2hCWVpYNWN2WFZPemcxQXRMMWtV?=
 =?utf-8?B?Qm9jZmlpSXlJR1RNUnZmQ3FNcXVCaWNENFBhYWN1Qy92ZlY2WTNjUUZabVQr?=
 =?utf-8?B?OTdaWXdUUmtoN0hhVmtmY1UzWDVEZmV0WnJHaWxjLzd1RURUeXJnYXVoUVdW?=
 =?utf-8?B?ZGE2UEY1VEV6Rko0a0tFMC8yVk0xSUNpUmtWeTdTK1krRXZHaGp1am1hRXBD?=
 =?utf-8?B?TThWdDdkbFZSUVQ2TDdnbVNtTzVMSCtabXNnOVJpc29PelV5eDlnSU41T29x?=
 =?utf-8?B?ZHdCZmI4SEFyS2lsQWJVcG8vYm9KbHJKTzhTZGtkSTNPc1FrSnVRWlUyVEVu?=
 =?utf-8?B?NlFkSThBVzA0ejdRUVZwTUlIY2RLb0dFQlYvaWxyWUo2dWxybVpLcW5OK3ps?=
 =?utf-8?B?S1pxMjVNSUJJQUVwbDdzU3Uvc2hYMkFGV0oxVTJobGdaY3BhT1lQTHROVFI1?=
 =?utf-8?B?ckFUMVNlTDVreDIwL1I0T2FrK2gzMWFXUWR1bzNLMzJhekx0WlQ4NTRIOUlW?=
 =?utf-8?B?WjhkdlY2ekRweDRmRGRNeFlIZk41cnNzTXBIUVRIaDhNYkVkdnBRTlh4R21y?=
 =?utf-8?B?T1RaTkljSEludXI2S0VaeWU5UGt2YUV1RlNrQXBhNTFIai9QL3RYMFFWSitt?=
 =?utf-8?B?M242RmN5N1VsdFo0Mjh0SlZzOExET1JhT1MyaTJNa1dXdFRpMk0xTGlnWGRF?=
 =?utf-8?B?YVlCUDd6UHc3VXI2b3FKRDVFZ0o5NHgxZzRld1ZYZFh6RVozMi90SFB2d0V5?=
 =?utf-8?B?TWUrbkdHQVVTSnNyc3BKdk5YVmNQZStnVUFlcFRNZzFydS9Ma2RPc2lVT3BL?=
 =?utf-8?B?YldUT1I3MXJRd3VlYTFyZDlCZE5JZEVHb3h4MHNUNFM3Y3B3RHVPejFsa3hn?=
 =?utf-8?B?cTBNS21sRENYZ2hNLzVTSzVuSmRNSXdSOGUwMTEwM255RkY2ZmJZZE9wNSts?=
 =?utf-8?B?V05aL3gxKzF2blZteHNTZW9EczI1b0tmYld3cXdNNkViOGNPN0c4Wm85eDBP?=
 =?utf-8?B?V2R2cjl2OUVSbmpzT20rNjhkT3lid2hwangzWFcwNDAyUVJVMU0rSnVYcGR3?=
 =?utf-8?B?RWM5VlFVd2tQV3pwUUFreUVpNFVoQWpCR0o3U1gxMitzSG4xU0RlVVlJVnpL?=
 =?utf-8?B?VGJORnZJeHU2WkxTdFNqZC9MZjQ1U1ZCci9RMWFBaE5acWVONUxQL0VYa2hM?=
 =?utf-8?B?dDdpVnZSWkdGN1lvMjVwdzdzTFBhOWgzUkxkTEQzaU00NHpRMXlMZTFWMzRJ?=
 =?utf-8?B?QU1zZWM0Q0pJYWh3UHM5T1Z6VFhTelpVMkVLVEF5Z2NIdjl6K2hDYmVEaVB6?=
 =?utf-8?B?NkV3dUtPTllvRjRXMHE2akljN2JKRVVYOU8zWU5rSzlWVVdodEVFN3hKdEdM?=
 =?utf-8?B?cTlkNkdHVXo5NVI2cWxxR2hRWVVLZHVET1Z6bU5xNEhkQVBlMGY2eDFiaWhN?=
 =?utf-8?B?R3ZrQjQxUEFRUW9kcHRKRG9jMnNDUkdCb1oyU2lzeHFkRnViK3FJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62670ee-ec5c-4aaf-b6e6-08deb0fa066f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:15:03.1429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC4NzkvP9H6mIxdyYNDNWvE3zognu+UuHEC7CtpugCLVutVRLsbiNHINYRwC0ykOW4hlBddtgt3DgsfTFAKylA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758
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

On 2026-05-13 03:08, Christian König wrote:
>
> On 5/13/26 00:31, Felix Kuehling wrote:
>> fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
>> size this can support up to 44-bit physical addressing. Grow these to
>> unsigned long to support larger physical addresses.
>>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>>   include/drm/ttm/ttm_placement.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
>> index b510a4812609..3e88869c0f58 100644
>> --- a/include/drm/ttm/ttm_placement.h
>> +++ b/include/drm/ttm/ttm_placement.h
>> @@ -81,8 +81,8 @@
>>    * Structure indicating a possible place to put an object.
>>    */
>>   struct ttm_place {
>> -	unsigned	fpfn;
>> -	unsigned	lpfn;
>> +	unsigned long	fpfn;
>> +	unsigned long	lpfn;
> That should be uint64_t instead, long is CPU architecture dependent and we clearly don't want that in TTM.
>
> But apart from that looks reasonable to me.

Thanks. I sent out v2. What's the best branch for getting this change 
upstream? We'll need it on our NPI branch in the interim.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>   	uint32_t	mem_type;
>>   	uint32_t	flags;
>>   };
