Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76C606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dZXgciS4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1939210E459;
	Fri,  6 Nov 2026 20:34:37 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3EC10E459;
 Fri,  6 Nov 2026 20:34:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrJSdi4G6zVLRx+vkJET3oggWARhaLK5hqRI2PS7W7YHSRhXoCCV638UdGwWLJOlYg7+qV95zgrSOl5ZNs/uZHNua/6pMvZLffZp+CG6jFBft1E9UA/Sw/PKEY8Zvc2LZvscSMMsA/v5fIgnR62zwM6gYmYKvZ8KPG4+yIkELXRXkQmU55a/tuPGyAPyq3WD/yNQf3fefMdxX6r6aWL5RyLx9dzV/I28VAuu5yhQbHU/UvJ8S2VKfC9umKDZxK2TkIgHSd105mfxXFa0+TqhC4xFH6utgx+Vrpcc7zUnjUYGzVCRWAWt5lpOjlp0OdnwZw7fIPkljQRjQ1eBqaKSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYclyI2MQcE5qHEs+JjLnzvqWPq71wutwI9QVwi1B4Q=;
 b=ArRSpTsi8gU5gNE6YwcG6in1HnQuodvY+iRm+9wVWgu9njXOXpXqeu1VnyeYoFFuD4aREcrpSRebNf9orKQNfX9+uSnm+DGJvAQOZip9WhYIHkDZDjMQEPUlGZFG0irlY5Ik3nPWEPfoQcPmXc71uXsO489O60uiuCUhN8SLhWfraO+Vc2BXUoyPJzfjfLtboIlJKWDHedTziDP9HDotf6AQQQu83eUmRUKXKljcP9iAULccFRkWXqas1GFm8qptFh+TqQHPcm6D7ExasCaqPRRIPYO6q5PAH6q6iIihI1IZ4GzFoAiZ4jFZZLLkGebRDbXE2J5G8QzyddhY18jFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYclyI2MQcE5qHEs+JjLnzvqWPq71wutwI9QVwi1B4Q=;
 b=dZXgciS4/lZdpU4C3KTXp16cJ/AQCwAxBJ9dPtjhCkB44TvHpxyBRxOfUxyHCRf1/juRSJ9i721oXE2fUkvhOrjJjYsDlxF/3OdvITzLLWWOc//Osc2VeThddrGxPDk2ISVDaFb00ZWWrj8ctl7IwPn/OEfGlE4YFSfbg36PlRw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 20:34:26 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 20:34:26 +0000
Content-Type: multipart/alternative;
 boundary="------------cN2eDBL5BJMTDYSJ7aw4Cn0Z"
Message-ID: <21354ff7-88f4-46d7-a238-4dbd20bd9ada@amd.com>
Date: Fri, 6 Nov 2026 15:34:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Check ownership of device pages for DMA
 mapping
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthewkrebs8@gmail.com,
 jm5905938@gmail.com
References: <20261105204748.100841-1-felix.kuehling@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20261105204748.100841-1-felix.kuehling@amd.com>
X-ClientProxiedBy: YQZPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::14) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fbab9b-b730-4517-1cf6-08df3c45596b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|8096899003|6133799003|22082099003|18002099003|10067099003|13003099007|11063799006|261021121427099003|56012099006|261026121527099003|261028144727099003|261102123227099003|261009223027099003|261022105027099003|261026140227099003|261022113327099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: 3S9jy7bwm7TIgblqiyo9IVBZBYxk3UaJ6eHdscifX8dED3xi6h+4w0bS/yUQCQjvl0P+ia0Kt7lJ7z2BfqIDprJ1bEt9+H52YfdDA5Eqip4psx8n9YBsMeO0lssaJCVzcmtUBY4CZIpGfqcdZa6y33ZfCje2o1cSmtLCQOROIeXhYxwmrevTTI50wbevcjMIHGJuaK8Fi5jEt9tg1/tXLa3R8YNJWvDIVuBxhEe097LHbVEhFi57ycUBWQlvO1wwaXigOTKN/Kso0pPCNpTgqt+E7zoILmIypsL1MBFawOX/fjoH2ZI/ELJvalGTrX81V4vwzdpir7Joh3dzxN+WCr4J5YaanyRvp4VdOohXiRcZivJNywkIEU+83atenfXIYbBy1y+HQTSKU7Cc/lKFrNlOgZRMsptoi6LHlFBmjcTM2+5wSQry/E8RTQFipRlNM7MeW3e9H93EmEDrjup2gbyNGPKUIDPS3zVnoaai1Ojgfh/83LCcgLqq0gL5IEufRuWxMi/W/O3+N5dMPmOa3ymlGvZObwgQLAowdDBy45/n3Kn/Mf2PdjSCub9yPrBkhzgoOczU8x9ojZcNlwrklwDib6/yoOV4HvEe5jho5mM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(8096899003)(6133799003)(22082099003)(18002099003)(10067099003)(13003099007)(11063799006)(261021121427099003)(56012099006)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(261022105027099003)(261026140227099003)(261022113327099003)(261021123027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFFclJBcTE2cFNDT1RaV0MvVFpvY202MHZFbkNZYnNPMTAwTUJwenliY1ZP?=
 =?utf-8?B?ZXdXVnZwRndWSllDZkZlTlBiVEVFZ2ttSFB5TUI5RjNyRWRTSUJLc2hjVkxl?=
 =?utf-8?B?VTVUdWhGUFZzOUdKcFpobWZDTVhDeXpXaVdDR0JsamJ6ZC9YRURFV09iTTBz?=
 =?utf-8?B?N2huUUVieE4zQzYydU5vRy9VRjE2bHhLZGdyNXIrMmNQWHhGYTFqSHQ5a0Rs?=
 =?utf-8?B?dTI1VTlGWnkraE5INUVsaWlvb3d3NE12OEVaOVBHOWV6OFNOZUtqTVROak9l?=
 =?utf-8?B?ZFVucXlodlUwWkl4dEZWSU5wSmZuSXgvTzJnYmpRQnFlaE8rdFV2Y2hzTW0z?=
 =?utf-8?B?NDVwOThIL05LOWZNYk1FamFEWitDeWpQVkFHczRMNEJXQXptY2VjNEcrQ25U?=
 =?utf-8?B?YWlqMnR5K2FTZHpNODZ3eVk2bElnUm1MS21ERFltRGNjUnhRakU2MWpBMG1C?=
 =?utf-8?B?K09xMHN1MnNiUDBQNEtIdjZjckVhR1pRVUhVZDRxT2VEN3l4Vk52V1Q0U3FD?=
 =?utf-8?B?bzRsYjMzV3NUUHpOdFBMVGdNcHZCNU0xYUpheS8yL01vNHJFUE14dHVZN3Rz?=
 =?utf-8?B?RkJFdUUyNXNvZzVBb3BUTVVCWERYRm1VbnQ1amtYaWZva2xxMkxWZmZZcmxU?=
 =?utf-8?B?bGQzeXhWeXBWeGpEWnk0aEdNRmkwK3BzK1l3VFVIdzByMnlzTWViZkIvdUc2?=
 =?utf-8?B?TkVXc21JNXA4b1RXZnJVa2Fpekt1NlBsNkFVNUhwUTNLOWZrUi9nVTJJSTlS?=
 =?utf-8?B?a1gzZG16cmRNa1dSeEFReXNRRy9wNDk4SHJIckF6RXdjM0lKc0RKam8yTjdj?=
 =?utf-8?B?TTQ5dzNkQmNJSkhROE1XSTg4TnQ4dHhvUXZJY2J0NTlGTU9YNm4vZnhSb0hy?=
 =?utf-8?B?aEpjd2JiQzVZRDZSY0NwUkZBaFY1VXA0Z3p6ZUJjajcwS3MzWVpEcjlIaERG?=
 =?utf-8?B?WEFlcVlrdjg4YWhadkJhZ3N4Wm1yRzl4dVBudGUrNkd1WU9saENhTGVaOC8y?=
 =?utf-8?B?emwzUlkwTEJ0aGJFNXIrRUZLKzJyb3pGdEZ2eVV5Z09tSHpkMXpnNTlCbVp2?=
 =?utf-8?B?a3Q5K2VBMWt0QXhzdFNkbHUzZ1p2QUZhMjNBVVZQblNXc3BYbCs1OGV3eGE5?=
 =?utf-8?B?ZXFmVjIvcnV4U213TktIdlBucmxEVWpDV2dLT1M3L0h4VTlHeUhWbXVrSmxJ?=
 =?utf-8?B?WkZpTU5vQ0puSDIzdkdLWXVEWHZTajRla2JJWmZlSUQrclRYRVVCT01DaG9X?=
 =?utf-8?B?dXF4MGdvYWFvRTA5eFlhdnZHRmNVak5qa0JoVzJJMVVLWGZ4Y2Ixdi9Hd2lP?=
 =?utf-8?B?UGdpQ3ZyOXFMS256c2Q1M3cxRHloQkJ0eWFjSUpidmZmQjQwbEh3Y1hLK2tY?=
 =?utf-8?B?VnhqNkphYUVsZ2JpK1hJcDdNZXg0WFc5T0lDeXVhSEFsdHVsRFBnLzNocWhp?=
 =?utf-8?B?OW9ZNEQ4SlppSDI5Z0J3WkR6UlhrUkVMUUlIZmpuZzJwY05vMFNGcVNNVm05?=
 =?utf-8?B?VkMxbzdxT2VxZTFkaUl0K0pmVlllS2hUOWxTRFdicytDeWJlaUxtTEM4RDJY?=
 =?utf-8?B?VStHMU4vTDBCR0tuUS9RQ082dENPYWV4VjIwTkpxUUFFUENYWXhQYm1Kd0Rs?=
 =?utf-8?B?QnQ5UDF4SE9iVVlmb3RvVHVkT2hJVG0vMHNWZld5TkJSNWxLWWxMOE05UEdz?=
 =?utf-8?B?QjBNUUpjc0RUcGw5KzRBYmRBRTFQN0R2NzNNNFRsL2dwaTQ1QzF6cWFaMzdY?=
 =?utf-8?B?Qk94bGRyVXJqUngyL3VZdlZIeTNBUkxvYVhNcWM4akZTellXc2haenlVanM5?=
 =?utf-8?B?K3Z3dU5SUllmVVB0WSsrNWVzSm93U2hsenl4WUt6dEJqbVdoelgyQ3ZrODZK?=
 =?utf-8?B?VW5kV3NjWXV6U3l5SFU0Zzdyd04wUmE2cStscXRXTEJ0STVnOERrVk5mZURk?=
 =?utf-8?B?RnY3UkhJVkVZci9aNmx3K0dBblF4MjJHcGNHVDVtM2tIK1VFckNPd0gzTmVt?=
 =?utf-8?B?R0xzODIyRzlyUVdFZFV3cTZsS0hsbHVqeXlzR3lJUXFUYTFEdUNCOXNoZVNa?=
 =?utf-8?B?d3dQWTZZQWhzcXFmTWF2cmFjR3hPUy9KL3JFSklURGczV1NqeGZEc2taaGFL?=
 =?utf-8?B?RFJzSkdVejdPRFFNb1UvcDVXYUI3Q2V2ZkNpWkdUWTlNWUMxZFo3WG9MNHBs?=
 =?utf-8?B?cE13YnhWUlpjRmowSEIvWEc1RHRXWHdFd3VCOFRUc0xrRmtTWG0wSVgyN3dk?=
 =?utf-8?B?a1ZnY0VrMzRGYWZBa0ZuUVdaejhoYTBPdFE0Qk83RUEzd3BHVEtvRUN2Uis3?=
 =?utf-8?Q?rQBoquby3PyDE92otK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fbab9b-b730-4517-1cf6-08df3c45596b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 20:34:26.3325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyxNHTBEbERbY2cFX8kwLqA9e1YCjdZx9vJzr1lhkegFD14eUfuaRbsvcEyBYAgr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------cN2eDBL5BJMTDYSJ7aw4Cn0Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-05 15:47, Felix Kuehling wrote:
> This issue was raised independently in two contexts: pages from DAX
> devices and pages from other GPU hives or inherited from other
> processed. This patch addresses both concerns together along with
> Sashiko comments raised for one of the previous reviews:
> https://sashiko.dev/#/patchset/20261103-kfd-svm-foreign-vram-20261103-v1-1-d6282053cad3@gmail.com?part=1
>
> Before treating a page as a zone device page belonging to the SVM range,
> check that it actually belongs to that range based on the
> zone_device_data. Non-private pages belonging to other devices or ranges
> can be treated like system memory for the purpose of DMA mapping.
>
> Cc:matthewkrebs8@gmail.com
> Cc:jm5905938@gmail.com
> Signed-off-by: Felix Kuehling<felix.kuehling@amd.com>
Tested with a forked child process after the parent prefetched the SVM 
range to VRAM. The child's access now triggers a GPU page fault — the 
svm_bo belongs to the parent process, so updating the mapping fails — 
instead of crashing the driver on a NULL prange->svm_bo. This is what 
COW should give us: the child must not access the parent's range in VRAM.

Tested-and-Reviewed-by: Philip Yang<philip.yang@amd.com>
>
> ---
>
> v2: Addressed code review comments from Sashiko
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 876476046926..2aade0183578 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -156,6 +156,18 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
>   	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
>   }
>   
> +static bool svm_page_is_range_owned(struct page *page, struct svm_range *prange)
> +{
> +	bool is_owned;
> +
> +	mutex_lock(&prange->lock);
> +	is_owned = is_zone_device_page(page) && prange->ttm_res &&
> +		page->zone_device_data == prange->svm_bo;
> +	mutex_unlock(&prange->lock);
> +
> +	return is_owned;
> +}
> +
>   static int
>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   		      unsigned long offset, unsigned long npages,
> @@ -180,7 +192,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
>   
>   		page = hmm_pfn_to_page(hmm_pfns[i]);
> -		if (is_zone_device_page(page)) {
> +		if (svm_page_is_range_owned(page, prange)) {
>   			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
>   
>   			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
> @@ -189,6 +201,16 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>   			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
>   			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
>   			continue;
> +		} else if (is_device_private_page(page)) {
> +			/* Device private memory from another driver or range.
> +			 * This should never happen in practice but it's
> +			 * theoretically possible for read-only VMAs after a
> +			 * process forks, creates a new KFD context and maps
> +			 * the same page.
> +			 */
> +			pr_debug("Trying to map device private page from another device or range\n");
> +			addr[i] = 0;
> +			return -EINVAL;
>   		}
>   		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
>   		r = dma_mapping_error(dev, addr[i]);

--------------cN2eDBL5BJMTDYSJ7aw4Cn0Z
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-05 15:47, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261105204748.100841-1-felix.kuehling@amd.com">
      <pre wrap="" class="moz-quote-pre">This issue was raised independently in two contexts: pages from DAX
devices and pages from other GPU hives or inherited from other
processed. This patch addresses both concerns together along with
Sashiko comments raised for one of the previous reviews:
<a class="moz-txt-link-freetext" href="https://sashiko.dev/#/patchset/20261103-kfd-svm-foreign-vram-20261103-v1-1-d6282053cad3@gmail.com?part=1">https://sashiko.dev/#/patchset/20261103-kfd-svm-foreign-vram-20261103-v1-1-d6282053cad3@gmail.com?part=1</a>

Before treating a page as a zone device page belonging to the SVM range,
check that it actually belongs to that range based on the
zone_device_data. Non-private pages belonging to other devices or ranges
can be treated like system memory for the purpose of DMA mapping.

Cc: <a class="moz-txt-link-abbreviated" href="mailto:matthewkrebs8@gmail.com">matthewkrebs8@gmail.com</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:jm5905938@gmail.com">jm5905938@gmail.com</a>
Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></pre>
    </blockquote>
    Tested with a forked child process after the parent prefetched the
    SVM range to VRAM. The child's access now triggers a GPU page fault
    — the svm_bo belongs to the parent process, so updating the mapping
    fails — instead of crashing the driver on a NULL prange-&gt;svm_bo.
    This is what COW should give us: the child must not access the
    parent's range in VRAM.<br>
    <br>
    Tested-and-Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20261105204748.100841-1-felix.kuehling@amd.com">
      <pre wrap="" class="moz-quote-pre">

---

v2: Addressed code review comments from Sashiko
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 876476046926..2aade0183578 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -156,6 +156,18 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
 	       !(dma_addr &amp; SVM_RANGE_VRAM_DOMAIN);
 }
 
+static bool svm_page_is_range_owned(struct page *page, struct svm_range *prange)
+{
+	bool is_owned;
+
+	mutex_lock(&amp;prange-&gt;lock);
+	is_owned = is_zone_device_page(page) &amp;&amp; prange-&gt;ttm_res &amp;&amp;
+		page-&gt;zone_device_data == prange-&gt;svm_bo;
+	mutex_unlock(&amp;prange-&gt;lock);
+
+	return is_owned;
+}
+
 static int
 svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 		      unsigned long offset, unsigned long npages,
@@ -180,7 +192,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
-		if (is_zone_device_page(page)) {
+		if (svm_page_is_range_owned(page, prange)) {
 			struct amdgpu_device *bo_adev = prange-&gt;svm_bo-&gt;node-&gt;adev;
 
 			addr[i] = (hmm_pfns[i] &lt;&lt; PAGE_SHIFT) +
@@ -189,6 +201,16 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
 			pr_debug_ratelimited(&quot;vram address: 0x%llx\n&quot;, addr[i]);
 			continue;
+		} else if (is_device_private_page(page)) {
+			/* Device private memory from another driver or range.
+			 * This should never happen in practice but it's
+			 * theoretically possible for read-only VMAs after a
+			 * process forks, creates a new KFD context and maps
+			 * the same page.
+			 */
+			pr_debug(&quot;Trying to map device private page from another device or range\n&quot;);
+			addr[i] = 0;
+			return -EINVAL;
 		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------cN2eDBL5BJMTDYSJ7aw4Cn0Z--
