Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3679DC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8131510F1A7;
	Thu,  2 Jul 2026 07:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JLn3PXCx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DC210F1A7
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8mF84KGg5RF4djm1PAVcpddEU/o5Yo+iSUqFoqjNCTlmSHgSqQwDyMSOXHX8SXyH/XbdH3FV2yPZ6APrQvofztwSUJ3I8QIOiEdS5liyF4iEA+lRTufneS+9onaYkKX/VdzzieRAa5JiN3zxujsb577rnLwHzIVxJVCjokv/vWtJ0ruvuG60oQ+zi71ntvnUdVaHs2hAlt8xOVuxzMWtxUvywG+Z39kEZ1zQBYam8LF3e+1elnVcJ9ApOrJgbv4P96hy7t62h4wh/ZaLtadZmd+Drx56RnCSPS/dbwfEg47+9UIiGOfSHGqrVv24yYcg7iFk65Kd2f81UfFkqf6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tQ2VDhUjamM0umg8te1SX/25rlz/uxBX3PwZsCYKFc=;
 b=cA1sdmIY36UpLRdyVqF+G7e78rbWPoYKiVBAjTE1QPx/1SrN2jeKL+RKwwI2jW/CB/8UXW5Rd4oeBUUVopwN6jmtI/TWd4tBiIqN0hqdJ7ym2/VLAumi1bV40RmRREtaorilaEwF7mBS0LkMRnwKCBxEc9kkEbLJCr8BHnb/IZoebJBla86x91sJrXemo/PdqBd6H79URmd0wH6FM4AYvo3LEsiHfGtVlRS94oEm2TIESECCb96Cf195xrVgECefdqtkkTIpcNiIXUY4IO+DzwdVfV/1JpCC6xyoyqdmC+602AVsHhfpMp2v6QrUb5mQ3cZUurllYf+simxby4jwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tQ2VDhUjamM0umg8te1SX/25rlz/uxBX3PwZsCYKFc=;
 b=JLn3PXCx+psPLijcF93ig37navzSX6TOg91YHrWI+wz2nE5wl3ICA2p5GYJIrzkOCaNe+ymw39Pb2W0DJ8EiOHjgSwHbzbszNh0E9PMNcsm7/IqvZKNyTDlMIWBcocxQLk9Q7oee55GVRXdARE/b3tBA/D3qMTpRtgKWWrJzl6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 07:24:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:24:31 +0000
Message-ID: <df5a6d42-6731-4597-9416-c933c52a601d@amd.com>
Date: Thu, 2 Jul 2026 09:24:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma_buf: change unsigned int and int types into size_t
To: phasta@kernel.org, Shahyan Soltani <shahyan.soltani@amd.com>,
 sumit.semwal@linaro.org
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20260630160401.67544-1-shahyan.soltani@amd.com>
 <9650c30654db85e393217fde419a966d312e4a43.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9650c30654db85e393217fde419a966d312e4a43.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 47bb95c1-9cd0-4be2-384a-08ded80af52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 5JkJwMK0aze1zUo2RMdaX+4MECyWUvbsL64ScDv0v8UXe5MA7UvhoYbfW776WKJdC/AvEAOtOyiyFyyLQW/dhimpsllyTBJ1nn75KerQ8G5cPJQ8cZL4SNH2XwHfaHUYP2UQWizF0HZlHrI01VNBv6TByyBahc/29os3HtWQ3T21C3+zeBAcbTp5XveyBjpQfDeujVCrspc5W0jlKymBcbTFkdE62jaw1L3y7CTO7Hs88UfyPyJMKfyfUWydYZxfgZsTLZIVMU9iwfzKwKSEA1B0Ux46jTc6fgVWQG2cCC197kGm0RtDKv64PO46+ceRIGoMSbUeAPHaBEwEsn03W8l872S+kyllNgVuMLXzk0vEYMntT7MddVha/BA2olpCbG/GrBZLmukTQDnLKtO1Qlr+0P46tQhE3UOQgnbV5N3v7uGqYOk/AB6iJnj2Wg97SQPkS/Qh/m9Mzs8UcdBGfJgXqdETxA9K77bQCIeXjfwxV2zJoMEwZr/sLU9IC885EbdLWDXig508i/rjX11uzdwCND6AeZOaEriQXuEvrmMGMXED6TpObt8DHXYkCp3STdcsht94Vfblx2bX8wRQnZqsBq2wBac5p4MF2daws62vka826fii8jCuVCZxSB+2Xjz+n0+66ACuuI4Weg44t+bnpy6JdsVqJ/ZQxZbod1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFpSThESzQ1Z1IwZ2pDRWxyS3JXUjdvRjQ2OFUxUzY0WEhhQjFacXA5R3lP?=
 =?utf-8?B?a1RxM3NpdHZGZUw0eVEvYVVPWm1LYllrZ3dFRVNjL2UvYm9rMVEvb3ZEYTE1?=
 =?utf-8?B?bUFzZjBUd1Rrcnpyc0dvSXVPVVlGOVRqZUx3SWE5YU12STE3UjIxWXRjeHB5?=
 =?utf-8?B?aSsrUVRxRzlBOWo0YmE3WjdHS05nMlBWTnZZNE54ZUZCWXhTcDhXNHlKWVE3?=
 =?utf-8?B?eGNGNHcrdmRhVU5CWU05WDhnaFB3eSt2ckZ0NlpodzlCdXdDWG5EZXB6VXYr?=
 =?utf-8?B?L3k5M284VnVXQnlWSWo5VGhUKzVHQmtlUGdVN3Q1d3VxWE5ieDhyeHpiS1gy?=
 =?utf-8?B?NXhPTHNsOGE5TS9CaVJ3MnNNUHpkWlBhRisxT2R1M2JEVHQ2Q0pLRkpLbURR?=
 =?utf-8?B?MmNMTnhWMlFoWjltYmdPYkMxRE05Q0cvY1hFcTk3UjZQSmdiT1JySnJseWRO?=
 =?utf-8?B?NVNmcEV4dDk0ejlJZ2Vtb2JFV1ZZdGZvV3duZndKQ044ZTlPVXhTd2xzQnNa?=
 =?utf-8?B?T05xL1g0Y2Nub0kvQ2tyWnVYR1ZrOUp2K2hlSGhYUENEZG9leUxQYUorVkNG?=
 =?utf-8?B?cXB4bmFpcnVYZzFGUFArOHVxZiswdWtxb0czUUdYdXVTeFFsVFZFb0VCZDQ5?=
 =?utf-8?B?SjdoSk84ZjJSeG5icFFIK0UydG1UazJrTlgwRDJrZ2xVdGRWWkhQc3NRdFo3?=
 =?utf-8?B?YkFPUWtEc3RYUW9meG41TzJMVXhPNjdjd3pqODlhanQ1TTNEUE9ZTktmemx1?=
 =?utf-8?B?d1FQSlM4eXIrdSszbTludzRvN1I4eUFNOGw5MlM4SjRNZ2xmT2swK1ozSjl1?=
 =?utf-8?B?QWIvK2M4eDJEWDVDN3JBSEZuakJaK1R3ampNNFgrUjd2clQzTi9Fd0UrOFhK?=
 =?utf-8?B?RjU1RzlxY3RSR0ZibTIvaDFKWTZVUlZrajJDOFJBM3d4TnhxVWJaU09GaGtV?=
 =?utf-8?B?NUJGSWJiUm8yclBsa05EU2o1akIyOE1PT0lmZ2srRG9QMHN3eFFFbCtWWERr?=
 =?utf-8?B?Zk02ZW9YbW1hNHRwc04zNjVLaXBvUXBkdktUQVV0Zzh6aUN2V0taUmMrbU9z?=
 =?utf-8?B?WFJJako1OVNWSHh5SDNFQUk5YmRwcHV5Q3BsWUNFMlBWS0xqa1FnVlVFYjNp?=
 =?utf-8?B?L3dQZjlJMk5UVjNNQ1VYOEc0ajlGNlVmZTVhN1ltQ3N6RmxVOEoxRDlDMGJS?=
 =?utf-8?B?WEh0b3lydnZPZGNmT0FoNmM3dFdrSEpzQ20vdHlyZVVTak5hanlUU0FUWWtN?=
 =?utf-8?B?akZIQUxlbG5aSGh4Wlg3OW53QUJ4eFppUWRTQXg5ZWJzTmpEUW82aFpKT2pv?=
 =?utf-8?B?aVJsaXB3Y29JWXlQd0F3SjNQM3BWTk9CSjZXMURKbFNyeUorYTJ3KzRsR0E4?=
 =?utf-8?B?VzdrSm1maWpWdHh2TmpINXZrZXExekpEQ0hnZFcxczl4L00zREw5Vm5QK3dH?=
 =?utf-8?B?K05yQ2FyZzBoZW9LUFVBbjVTcGJiTFVzVnBGdW92aHdsNk9oYkdHMjNsTkp3?=
 =?utf-8?B?N29jOTNRdEhFdVpFTE5DelVFRlZsVDExM2VqY055M1lUNUxNMWVEaWU3NWhi?=
 =?utf-8?B?bzc1cmFxTlBua25iZDMzNm96cGp2RVEwMUtXdS9ESDB6NVp0aUZ6b0E1S2c2?=
 =?utf-8?B?c0ZlNExYbVBVQlJTWGlqVElDdEJ6SXR3YnV2Rmp3STJpS0RadGxLOThKUUFk?=
 =?utf-8?B?OEdoNGZ0c2FaNjIrV1BEck5Hd3hiMEQ2bWhHaWxCNnpsL3ozNFp5REcrUkYr?=
 =?utf-8?B?WW1jV3M2Zmh5R3lUWGIvU05qV2RNQzZMUFJpMk02SkkvanRFa1BVOUcveEtH?=
 =?utf-8?B?R010dlA1TGYvbUd5aDZxaW9IcVNhN3VndTRpYUNzZXh1SlVPeDRBaTV6Y3Jk?=
 =?utf-8?B?bGY3NFh1K2dTQmh0ZEpGYVFBa2dPYklRYzZuUndHcktqcWhLMGluTkY2Y0p4?=
 =?utf-8?B?OWhnKzdTUWM0dm5iNXppR3dpVGE4bER4a2h4TXRqNmhvbVA0ZExkRWxsdmw3?=
 =?utf-8?B?OWJhMCt2VFhTM00zcFQzcUJzbE1ab1lWSURHY0dqM2tqNEw2MSttc21ESHF5?=
 =?utf-8?B?ME50RFpoQUR4ZGNhZzJaL0JZUzcxL1EyRno5OVhJM1pZd0dTdCtqb1htYlli?=
 =?utf-8?B?TFBETGE1WHNLSlRyK2JUaEp1NlNNV2JDaHpQQTVWaW05SmRTSVlRUWlvYjUz?=
 =?utf-8?B?dXE4UllMdTR2cHRpRmY0ZnRGWEZmWjRMaVY1ZlRjcTlVMWJRcXlMRUxEekRi?=
 =?utf-8?B?a09nOHpTM3FjMkcrS3lHa0E0RDVSakExYVFpTzM4QS9aYXkxaXFmcm9naXhz?=
 =?utf-8?Q?JXURkq1PMxdo96ynCL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bb95c1-9cd0-4be2-384a-08ded80af52e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:24:30.9382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDv8dV1us+kKDU+Z/s7DUvf3yhTqRdmafYl7hQ3/GmHlp5bhlbAc2C1aLjjr0KKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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

On 7/1/26 08:52, Philipp Stanner wrote:
> On Tue, 2026-06-30 at 12:04 -0400, Shahyan Soltani wrote:
>> The num_fences, count, i, and j variables in dma_fence_dedup_array() and
>> __dma_fence_unwrap_merge() have inconsistent integer types, mixing both
>> unsigned int and int.
>>
>> Use type size_t consistently for these instead, and update the return
>> type of dma_fence_dedup_array() accordingly.
>>
>> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>> Suggested-by: Philipp Stanner <phasta@mailbox.org>
> 
> Thx for fixing this, cool work
> 
> Reviewed-by: Philipp Stanner <phasta@kernel.org>
> 
>> ---
>> The rest of the subsystems (dma_resv_reserve_fences, drm_exec, drm_gpuvm,
>> xe, nouveau, etc) uses "unsigned int" for num_fences, for example the
>> amdgpu caller in amdgpu_userq_fence.c.

Good point.

> 
> You mention that because you can't / won't change them?
> 
> My suggestion actually has been to go for `unsigned int`. Christian
> opinioned that it should be size_t. Shouldn't be a big deal, though, my
> issue was just the possibility for negative numbers.

Yeah, unsigned int would probably work as well. But ARRAY_SIZE() returns size_t if I'm not completely mistaken and I have seen size_t being used elsewhere as well.

> 
> Christian, would it be a bit better to be consistent with the parties
> Shayan mentions?

For the amdgpu use cases I don't care much because we limit num_fences to 16bit anyway and don't allow larger allocations.

The drm_exec and drm_gpuvm should definitely be fixed as well. Not sure about XE or Nouveau, 

It should just not be a signed type anywhere, cause that can indeed mean trouble.

Regards,
Christian.

> 
> 
> P.
> 
>>
>>  drivers/dma-buf/dma-fence-unwrap.c | 8 ++++----
>>  include/linux/dma-fence-unwrap.h   | 6 ++++--
>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
>> index 53bb40e70b27..65e87d263c3a 100644
>> --- a/drivers/dma-buf/dma-fence-unwrap.c
>> +++ b/drivers/dma-buf/dma-fence-unwrap.c
>> @@ -93,9 +93,9 @@ static int fence_cmp(const void *_a, const void *_b)
>>   *
>>   * Return: Number of unique fences remaining in the array.
>>   */
>> -int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
>> +size_t dma_fence_dedup_array(struct dma_fence **fences, size_t num_fences)
>>  {
>> -	int i, j;
>> +	size_t i, j;
>>  
>>  	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
>>  
>> @@ -115,14 +115,14 @@ int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
>>  EXPORT_SYMBOL_GPL(dma_fence_dedup_array);
>>  
>>  /* Implementation for the dma_fence_merge() marco, don't use directly */
>> -struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>> +struct dma_fence *__dma_fence_unwrap_merge(size_t num_fences,
>>  					   struct dma_fence **fences,
>>  					   struct dma_fence_unwrap *iter)
>>  {
>>  	struct dma_fence *tmp, *unsignaled = NULL, **array;
>>  	struct dma_fence_array *result;
>>  	ktime_t timestamp;
>> -	int i, count;
>> +	size_t i, count;
>>  
>>  	count = 0;
>>  	timestamp = ns_to_ktime(0);
>> diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
>> index 62df222fe0f1..7bfacdf79de2 100644
>> --- a/include/linux/dma-fence-unwrap.h
>> +++ b/include/linux/dma-fence-unwrap.h
>> @@ -8,6 +8,8 @@
>>  #ifndef __LINUX_DMA_FENCE_UNWRAP_H
>>  #define __LINUX_DMA_FENCE_UNWRAP_H
>>  
>> +#include <linux/types.h>
>> +
>>  struct dma_fence;
>>  
>>  /**
>> @@ -48,11 +50,11 @@ struct dma_fence *dma_fence_unwrap_next(struct dma_fence_unwrap *cursor);
>>  	for (fence = dma_fence_unwrap_first(head, cursor); fence;	\
>>  	     fence = dma_fence_unwrap_next(cursor))
>>  
>> -struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>> +struct dma_fence *__dma_fence_unwrap_merge(size_t num_fences,
>>  					   struct dma_fence **fences,
>>  					   struct dma_fence_unwrap *cursors);
>>  
>> -int dma_fence_dedup_array(struct dma_fence **array, int num_fences);
>> +size_t dma_fence_dedup_array(struct dma_fence **array, size_t num_fences);
>>  
>>  /**
>>   * dma_fence_unwrap_merge - unwrap and merge fences

