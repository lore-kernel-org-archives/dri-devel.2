Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9AECD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 14:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F8010EEB2;
	Wed, 13 May 2026 14:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nsEvDXgB";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4401910EEAF;
 Wed, 13 May 2026 14:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC/YhTrjqzSNYisXp8evJo/poNOY28uND7C5gpdECWW/DPJWOOBFsZ9xbGpzoKjnTRErakEuTPTOMppS8+w0AWg050r+f4ZPHUqwOdaYcmlQ8pV1i2ApEQDqCbFgOdnfDBkIHUSKNYjmEzmj6DOAuShQl3cyuuyGg6LbNblBOjalq2E7qPGDF3wvyqyHIYEBuAQa2pDdZfZXd9LfP9EGC59Le+Q4j64YbiX15qzZXrwvHL2GNF4H3wS8eoSk1hLkdTvWJqZ2VDbSUjhXbJJ/wJY9MmRog4Yp2T2lsZYALROXS25OvPBjHIGAdAIkJCkN8svKj2+YyVBt0hbBnbtzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEFVcw/g+2rDOMfzAKRz45coPnKpegcy60CHCLH8bDw=;
 b=X/hIzyXVdY1kjhO2gss9oZJ+8hXY5dRZotKMOQuPIebzu/AE+fLv0sTl/+LQTzrjZ/3oMTx4lMNMJ34zep7hQ0A0aUqQDhrA8h+M3JOdpYMEA3OzPviHJ+CTSTTZG7Z2Rm7KV9DRkXvMEHnuGPVPTc4fMyGQTU/lVWkJR9RkEY+Y3YG5wNO7WuCykRHTwcbdYnxdtTK0+OAqtJgIBQcLl8sKGLrC4GvCDe7CGcvLOCVIxbx0Q/kRw3KaSscaYDQnhljavTjil2jInf3NgEkwr5fh7/pdjJkltslY9BxNjlIh47TQZB269wBp6Oz72Ls9489z6IzGXKk7pqlnVSTZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEFVcw/g+2rDOMfzAKRz45coPnKpegcy60CHCLH8bDw=;
 b=nsEvDXgBV6MsTKROCZfeFXlpSvC5QB29uFz+FcCyMUk3737YGzLM9E4z+c6hPd6vIXrwN9u7/4FREFuhkb+712CHnQSPEGyOBDZGVtf2TJbMGuSk82Mh5RxvngOssWrsNwjppBLKg2MWpT6QdHwq62dhvmf3RsUMUOAngc5ZMCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:27:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:27:31 +0000
Message-ID: <6dc1e113-c06e-466d-9db2-4e2a2b34ff83@amd.com>
Date: Wed, 13 May 2026 09:27:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ttm: Support 52-bit PAs in ttm_place
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20260513141253.20410-1-felix.kuehling@amd.com>
 <4a91b7cb-e395-4ecb-854f-3dbdc6ae0a42@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <4a91b7cb-e395-4ecb-854f-3dbdc6ae0a42@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0093.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 948705e0-b682-43ab-bf38-08deb0fbc460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: qaEqphRbcyV7NHF+Tq1YxadSBiTftI8rfwMnQm7K17GFcoUNAYmYbjI9Iv4cf+7mXK4HVrv3yIJr7xf5Aau48BXC9Xojk9PJf5EYH52DSMNBKvWh1L2fo+yPGsmm6Zb35yTJd7mLyO7+3kIpI3r8BFj2bCG4TDV9hRB7R6XUvxe9Y3Wjr8ihikMT94BbSSY2kfVvAr/8EJTfVxGjVkIrkCnyciakdBnPpIX+/+Lf3K4h+Ji2drJ0GsU8WfrzE5PSmo/KjRUVDIve/mQCKqjKbCgYOgc+z0brVuZg3TzL3Jhm56JhBJjTW4jUnm+nzDg+G369uoOBAJEVhBRnh+hWv6X3I/Xp/TR+Ws2ndfabUCuk570nmkCn4zFr/hLc8/3G877YTaKaBjkY8mvlnDJ5X/9c4B+YJaD8SBTQcgWA0BNN33mbT6q4semF4mbo8+llPMpp8lza51ZjznCiCit2z2ZSWmMZzFVRGm1aFIZ9Y543h2rxVPFxfH7WB9c8Pn9hAPEa1BxR5Mlzn4u8aBEHO7gR2cyCFnGx1MNUv583oRTgDHUkbtTRC6GPCAVHsn+ULpSclNBDW6jSjVTWevsfamnWd2qXxiejqdezkNXVxZ9sdTETBELw3ygDhvuzIPnG91lBeY+xKk1weJOFuf1NPceIpGTWLqfeVo9YF2T25HkrQwmbSx3sKjffqSET5raQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXlib2FidzNINUhUK1Q2NkthbEE3N2NLNisyc1M3Zlhjbzd0ZWswVm1wVFRu?=
 =?utf-8?B?WTBKeG5mTktpM2JFdGlUZWJsVlpaVFFDSjQyZWMzeTlvZDlUeVQ4eG12U09X?=
 =?utf-8?B?cGZuUC9GWHBJbFk0Q0lub3ZoczZUYnV2ekZLaGpvMU54aWR1Vm1UUzRTa1RL?=
 =?utf-8?B?UC8zTm0zTnoxSEFSL2ZmMG1JcVV4bEgwMDlnSndSV1NOY1dESGgyWTNvRlBa?=
 =?utf-8?B?OGFjNExab05ueStucUQyNWc0UEg1QnlRRG90eGd3d2QrT3Vjd1hhWlNnY3Nw?=
 =?utf-8?B?bE5wUWJ4N1pzQU4vdjcxbitHOCtlVTduekpadWk3MGJUKzJrOHJocUplMUpy?=
 =?utf-8?B?Q2ZEWk00YTlpbkFGaXlVWmV6SUxrdmtRK1ZuM0JQTEtPNzg5VUtYbGRXOFFs?=
 =?utf-8?B?d0d6Ylp3T3dVbkFsZEJzZHFMWFd1WGVQdTQ4eDd4RVRRR3hSTUQ5K1RKcHlo?=
 =?utf-8?B?bzJNNWsxQ0txdWdzdDdVZmlHN0xuWmRsaktNUFpORHFZc1lNYldKNXlCTEJr?=
 =?utf-8?B?bTdHZjZRWEpTSjZjd1g1Mll4RHJ4RVlRakxHelVFckJtWVNER2FpUDFiWlQw?=
 =?utf-8?B?Rm9rMjZOZ2JSc3dEZGo2cFgzMFpGRWh3Q2VKb3pqN0Z4b1JyMWZsd1lNaUNV?=
 =?utf-8?B?cGgydW52V09DazRPTFJaN1JWUFVlQWhmQWtxbzVGWkMzeWsrbFc0eEtEc1Nr?=
 =?utf-8?B?ck1pYlg4U0NGalpxWWtNL0lnNTNUdmlPclV3M2xYbEpNOHp6Mm5icFNQL091?=
 =?utf-8?B?eDlaQnloTkVybG1GVWRickM4SFh6WkVVdHBBWmkrQ1ozeThrRFR6N1BrQUFn?=
 =?utf-8?B?YzJNV3FyMWJ4MGlMblNNcURJeHZTRERvb01yUEF0TmJsY0VWVklBenRKcE80?=
 =?utf-8?B?UFdOcXZhTkd5ME5BVGNXWUhxdE5reThGdHdqWVJIWHZCSVlubVQxeEhyU3Fm?=
 =?utf-8?B?ajI0dzhKaEVhTGZCV0xKdExjQm5LWjJ4OElqRkZqV2JycE43bGhoNzJRSHR2?=
 =?utf-8?B?MEdXcUlKc2RJR2Nkb05QQ3ZLVTAxaVFOdWh0azNOc3pvS3Qrc29CQ0cyOHBO?=
 =?utf-8?B?YVRLMWgyUzJETlZhTi9EY3ZYbGlEdGhSR3ZUeVhmUU1kc25WaGFmamRpZWR4?=
 =?utf-8?B?dzEvTURZTGE3d1BBcW8vWVh3c05TNVhaUG5UeXZpRkNubTd5bC8zdkJCNTNV?=
 =?utf-8?B?SW9MNVIxR01haisveHdJQVFlT1RkdForUXIrMHlwbHNoTXk2NWxSVUx4MW93?=
 =?utf-8?B?RUZEY0FnY1RCNkhTdlNnbld2QmVkYmovTmF0K0l6bE8vdDBMQUZobTloSG9l?=
 =?utf-8?B?V3BoUC9Ra05WMVdlbnc4UE5HNlZsVytJVTRKSEZmL1hVekJ0Q2ZISXg0RlJi?=
 =?utf-8?B?TVUzNEU5YkhkRFJobWkwNm15TkNvTWQ4bmYySlBvNlh3VWhsMXNRS0R0cVRR?=
 =?utf-8?B?WEkyd0dWb3FaQVo1cHg0cVl1R2UrT2d2OStKOS9zY0FZTmhrY2w3ZHVKRnlp?=
 =?utf-8?B?NlEzN0VJTHlwZDBXUGFsaVBPY1gxLzRDQ1p6WkNGVVZoWVg4T0FyTUxkRG9q?=
 =?utf-8?B?anFqQjVXVWx1UUF4Z2ZVd3NSMTNxTG0xZ0Ztdm4zaEszcmN3SWJxMFo1UzBj?=
 =?utf-8?B?YTVYNDF0cVdFNllxVitZbjE2cnhQNkZ4WTlncUVVYklXSnlMZDhGaUVOZ09Y?=
 =?utf-8?B?aGIvaS9uWGc0V05ueUFOZWJCR2hwRTJKbWVwSWpqNDFRT0FHMFVuTHNXT1My?=
 =?utf-8?B?SUJVSzU0YVRMbDJCNHkvSnhXeVg4N2lMV3hkVGtrU2RHSDBsYmNUUWpOcWJU?=
 =?utf-8?B?SG9HMkhzZ3dEbk1LOU5oRXNiMlBjTFNOeStyTVc3Q2RyK0UwRVJyLzgycmVT?=
 =?utf-8?B?VlJRS045eWdyOG03a0FwK1o3aWNwSnNXaWF3clovT2plRDhlb1c4WUJ0K2VJ?=
 =?utf-8?B?Y2NpOWtURUgrd2V4OW43ZUEybGRWdExqRE92U0NFeDFMRDBKUDc2NU5tZ0to?=
 =?utf-8?B?c3RGaHRPakkrd1UzL3FrTm45SnFaVjdPTkcvaElnWlNnWG1IMVNBRnlsZCta?=
 =?utf-8?B?M05QcXJZTG9EeTdza2I0eDNsaDhrMUNUQlV0NXQwQ08yVERYbEdUMm9ESE5v?=
 =?utf-8?B?U2VzVnBkUFBHUlkyMDRwUFVIdXg0ZWp1Sy9yWUxUWjN4NWw2SEZsK0lwNkdC?=
 =?utf-8?B?VENzMVpqVktlVEx2Z0xIN00wanRQYmQrN1hhaUlCZGRkRVg1OUJhalpKcWhX?=
 =?utf-8?B?UVQ2NUY4MTM0MFNlbXZSSkpDbHBQZFc4Tm5RWkNieHhDc0hKL05iZ0lITXFt?=
 =?utf-8?B?ZUlYWVdQdFlaT1BYQzJ1Qi9odE91TEYwTHNFTXJicjU5NHpZWWlidz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948705e0-b682-43ab-bf38-08deb0fbc460
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:27:31.2571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syrZWhiO5vdd0HwsgrzIqca5U+kGLAeYCc7n1GK6HOJg868Fr0Q7tirSyqMemTfTToTt41RMrgayxSCXTWvXvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
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

On 2026-05-13 09:19, Christian König wrote:
> On 5/13/26 16:12, Felix Kuehling wrote:
>> fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
>> size this can support up to 44-bit physical addressing. Grow these to
>> unsigned long to support larger physical addresses.

I forgot to update the commit message. It still says unsigned long. 
@Arun, can you update that before you push it to drm-misc-next?

Thanks,
   Felix


>>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> @Arun can you pick that one up and push it to drm-misc-next?
>
> Thanks,
> Christian.
>
>> ---
>>   include/drm/ttm/ttm_placement.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
>> index b510a4812609..ab2639e42c54 100644
>> --- a/include/drm/ttm/ttm_placement.h
>> +++ b/include/drm/ttm/ttm_placement.h
>> @@ -81,8 +81,8 @@
>>    * Structure indicating a possible place to put an object.
>>    */
>>   struct ttm_place {
>> -	unsigned	fpfn;
>> -	unsigned	lpfn;
>> +	uint64_t	fpfn;
>> +	uint64_t	lpfn;
>>   	uint32_t	mem_type;
>>   	uint32_t	flags;
>>   };
