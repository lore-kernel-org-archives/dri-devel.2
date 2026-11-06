Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15270606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BF6shyPe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938E010E47E;
	Fri,  6 Nov 2026 21:01:45 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB3110E48D;
 Fri,  6 Nov 2026 21:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2Kb6XUQso0YpN2xSDZceixmVsQi88oKosZ2gA/6Z4OWSbNSbKMZnqKBIzrscYL3SMTRIrOVe5IL8yr8e21h3miUNzeoUnnpdu05PenT7VJKYmrYQfoZO4ipNn3Q8lIw81uXxhRBwBtrvJANI4BbejodcnYByASs8EGYN9lcYq6qQYI6F+jrrkim1Zfo+mhJI3dWL27YEZMKWEt1Nv2z+cB7zYoHEgbq/GjheqfjBs1vbDZ1Q0d219hlb6I4jHWHS57Qxehmdc9ht/lElHopepcuXBpOtHNCrTPG3joMs74XdJ5GP6s1HH/FRHIct0hb9z21OwVsY6kzHb9jQWGRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=capqZna7lVTZBYoaDRoFV9bsXi09qyu7IpCp3EoFp9s=;
 b=e2DJLP4ci+dftjFaru5CrGNGL4MsKRfhaXpNrGEglOrCKF3w4dqW76Isi/2gzRMDv+aTV02R+bF2gd9W7IRTD2ePp8wCpe3C+humQCCN9Ngl/bwLKxRaIKuiyVqnXHYJF2ozt2bZTArLqEJFp9TtOgxVvIlYxHB4u6jfTleqW3psl9kcu1f1faz8xYI0eR5dis0JxhutrMUbObwMYDovBZbTH4Nh+G7vuNsA1TieVVTs5vIm1Mu7P+l/l3ht9b7j7LQQVONjgqOlkP8KlYb7gKGSohDHkwPGTGXNQMqc6/Viqz/9vXcv1UipQHLq+J+AkkURfm66mtPZHEu4mqfjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=capqZna7lVTZBYoaDRoFV9bsXi09qyu7IpCp3EoFp9s=;
 b=BF6shyPe57pdxQTE9bnzEQUXPH4l7WjA9Q83v7wHD/u3x8iFtD2ofCH1VKQzPsgSWLhhbuRqMi30DTRekI67YRMA9SCPlOIOv0ZigbjqbvANU3oMQLSd6IO9TVEFMCNtg9HKeApuzkeTJejEE2bf8ZeWNDuJ2Xf6e5XFvy2W65U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB7745.namprd12.prod.outlook.com
 (2603:10b6:8:13c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 21:01:36 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 21:01:36 +0000
Message-ID: <8b23cfbf-9272-41d1-9fbb-365c537a2b8e@amd.com>
Date: Fri, 6 Nov 2026 16:01:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Check ownership of device pages for DMA
 mapping
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthewkrebs8@gmail.com,
 jm5905938@gmail.com
References: <20261105204748.100841-1-felix.kuehling@amd.com>
 <21354ff7-88f4-46d7-a238-4dbd20bd9ada@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <21354ff7-88f4-46d7-a238-4dbd20bd9ada@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::16) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 8742c0b8-04e9-427b-b2be-08df3c4924dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261026140227099003|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261022113327099003|261009223027099003|261102123227099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: wpeuh4n2ctHncA6o4EZOCKGBSyMMY16pgkmNSXD00/aPV7ItVi34vaM9KLvVnmoOtJ8qetvP1Lc+dBQlTcvp3uFtTCqpzb/nP4G24vLcBMOLzMfsKz3fha7CgkJojyQHQG0U5oC74IAHaFfGz7rz3QDrvbZCLzQdeK38dlAjqz7qt3i37orGaqYthro/7jzY+L4ZTinsQXaQKFTX6MaWhki35OIvjLwN/p3MxbWsRngsj30PZLMzt20WN6YTFTrL62Eikhze0er/aWyHDQBVo6XI2D3ihl2TcfYG/Z9l7U5poEmDIns+2dKd+tYujvOMMKFDpdylAsjj+tgGMAngg2ImPH+L2llDo+ruT80afl/VWp4wq7Bx+Vpr5zkuVYpNP2jowwo5118aQZqbF8vLYjxTrMIOv9VMj+NDvG97x/YdwAOdBzdEpuHwpzpCEmfvDfjqGMoj0bPqM0SQqomKwuDHtQdspQX5V32Lj9nTLRre9FGBv++kGdM7xy08pWV3zBKSdOyfVrQxC5njlZBVyfs5uzgH5q9snI+T94ZMM17XkmauB1OXCg3vHXQ8KRwcVWcSmo2Jm04ntZZ4Nbgj6QNRac3atCUCPQZXRRZDJtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261026140227099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261022113327099003)(261009223027099003)(261102123227099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlYdlVIa1NqSk1hQzZRSkk0YXlFd3NHTUg0amRLc3dibHhNYlN1WlQrN3Vn?=
 =?utf-8?B?YlNGVUhMWTdQK1gyOXlXYllHcFJNZ2RCVnhHOFJlRjJzVXFTcmVJMW9FQU5h?=
 =?utf-8?B?ZVJhTFFhUGp5RlNCbGNrOVkwMmV2VWc4azJXL2xqVUtFVWtxQzV0L2FTZ2Vn?=
 =?utf-8?B?M01yOHJId09FanR1Y0hBOVVpWVgrUjBVYzFDeDhaREtBWTZ6a3BBOVpvMGxL?=
 =?utf-8?B?dHFNbmlmUmNJRzhmUHZ6Z00vaFRQYWdaQnlJUDFmWFhuMHFENnlraTN5WnNX?=
 =?utf-8?B?NTc1NEdLZlN1bkY2N3V1ZGhIL0tuVGptaWprR0tSY3ZnV1VJM3BOajJPOTZq?=
 =?utf-8?B?dlhFL2RyZEtQV05BVEZmY0V5d2UxbTRzMktkZGVlZThmOXBmZWo5NXlRSmYr?=
 =?utf-8?B?a3c1aHJxUTFLenJBckQyV1VuVmdaNGJGL1RPdjliKzloMFVBYjl2VXp5NjFp?=
 =?utf-8?B?V1NoUVNpcGxTRHI2MzBYN2VIclNoWC9nbmlBcmxESERnWnA5U1JMaHorU2FC?=
 =?utf-8?B?M3lMOXN0eHdCeTdTcWxiM2FvT09yVi9oNDRMbktvbDNDbDZhS29TYUtXUkpE?=
 =?utf-8?B?cTF4eDdhYmg2dlcvU2IvenFpcmI0N1p0ZlRaaTh1dGp1U3FpbXZzRi95ejZC?=
 =?utf-8?B?Z1hLRGJVNXFTeWREQXJNNC9jZ0lVbUJpZUZaY1JBZm5xdHQ3MXQrK1pNdzcw?=
 =?utf-8?B?T0JXaEt1cEROZGM5b28wR1JrdExEWWx3WjV0MlBTZ2RSK1RkZ2NHNDd0Q2lY?=
 =?utf-8?B?Z01CMmN4VVdZV1FsbmtpblVmeWdYa29CMldqQWNFdmM1ZjcvZ3h1MUFwcmF3?=
 =?utf-8?B?T3lxNDFVc2h3bUJCSThEd3BFcm9sSWw0bXBjNlF0Ni9RbklVNXlSS0pDVldF?=
 =?utf-8?B?MlVWZUw3dEdCWDNDQkNscTdXY29ZMEorYThMMkI3VVF0ZmFYSUJrRVU0SmUr?=
 =?utf-8?B?UGNWNkx2NVZVdytZd29zTHFqQStLb0k2OTVhcjVVTFEwQ3VJckE2WkZuTFNx?=
 =?utf-8?B?YWJSQTA3MDFidmhFSXhJSFpibU0xN0grMS8yZnBGNnEwNm1hS0xNbXRBbVFa?=
 =?utf-8?B?SlVPSVBjY3JndGU1SXN4c1g3OS80L3MxL2NWUlVNUkExNVR2YzN6QWs2RThm?=
 =?utf-8?B?L1l1WXd6VkZjME1KcGc2TnNwODdoUmdxaFYyQytDVjNrMUZWcEJHcFdpZFdz?=
 =?utf-8?B?Mk5zK1phUmVTeDI5Y1FqTmc1MkRPaXZMdTZuR1drSlUwY1J2ZndKS1ZzdDk0?=
 =?utf-8?B?WC9qRHlVMWR5YnJ3SktiWGt5aHR2OTBzUmpxTnhsYjczbjBmV0hSa28rTEcw?=
 =?utf-8?B?UG9ONno2VTF4Vmg1aGVSKzR2VHhNOXVWeXVBQ0JtMytqTlhxMk9LbVZpdXFz?=
 =?utf-8?B?OVlBem1qc1phMnNrRWpCeW9xQUxzYlRFSm1hZ0xsZjVnTVVNb2hKNHhnc1ps?=
 =?utf-8?B?N1kwLzB1NXA1aytEM09VczdwdCtKNXQ0bm1VK1ZVb0NLSHA4bkF1MDYxdGF5?=
 =?utf-8?B?S3kzQ0FNZXorNGdRb0l3cVcveTJydHBMV094MHlNVFdWbGpmV3VpR1lteWhF?=
 =?utf-8?B?enNiK2xLdGpxeCs1dDdQTFBtNEFNaTNUcGtjRjAvWGxEOFFHVjYwTVZFRTgr?=
 =?utf-8?B?cFNtQnE4OTNoK0dSOWRxdVBKZUtJUXV1SG81Zmx6MS8xRkRCT1ViRU91UkVn?=
 =?utf-8?B?UjlhNmFBd3dseXMzYytQbHI3RGNUQmxCdFZhamhLM2xCQ0dKY3VZVVUzWnJi?=
 =?utf-8?B?RTZPdWlKdTlMQ1RuUWwrVjJHR2FEdlAyQWl0c1VTZDl4U3hEWXZlWmZsYVFY?=
 =?utf-8?B?Q05kYlVKTjlsRTdRSlp0V1B1Umt0RytuTkxkUm50YXBOc3IzQkdhbi94UVAv?=
 =?utf-8?B?SC9paGVETWh5c3F4a2NFMm1MQU1IT2xLcGFHMjJ0OWVzQmtIZmpyUWNjQUlN?=
 =?utf-8?B?M3F1NTRmS2FGTytxNm5aY3BLd1JuNVlaRStCMmxNVkcwek9GMnB2SitPTWty?=
 =?utf-8?B?aEFBczAxZzNhaklIV0VTbEplTEpkMXhVQWk1K0RyeUlLakg3YUlyZUI3UTd2?=
 =?utf-8?B?d2c3MTZnNGxMZGFmUTh6Z0NtWi9HenRhNzZCRk14SkNOdUNiZEFOUGZZem1P?=
 =?utf-8?B?TUw2em1Kc1JuNUEyRXJPR0JRM3Qvbm8vcjdrY1NYdkVWSUxVd0pWVHJPMXgy?=
 =?utf-8?B?ZEVxd3BqcVgwc0IwRURvdnVLNzJ4S0hsbnlBb0ROcURnajE5WFBGcVFjOG5l?=
 =?utf-8?B?SFRwcEY2QUhqM0wvaXc0dXR4ZGJ4dDZvT2RqK2ZwK2VKSncvUEVqY2F2ZnZa?=
 =?utf-8?B?YkNRUEVySUZZTE1sQmFEQlkvYUgvb0Z3SFpYREp2V292ZzlyNTl5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8742c0b8-04e9-427b-b2be-08df3c4924dc
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 21:01:36.0048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58X56Pd9XozFrmPOp3OUMxts7xrIECtZvOwpd+lwMp2AHSZf6ierhR+Xt2+lPgOBQQiqbWUfr4QyyBMaJ0eTmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-06 15:34, Philip Yang wrote:
>
>
> On 2026-11-05 15:47, Felix Kuehling wrote:
>> This issue was raised independently in two contexts: pages from DAX
>> devices and pages from other GPU hives or inherited from other
>> processed. This patch addresses both concerns together along with
>> Sashiko comments raised for one of the previous reviews:
>> https://sashiko.dev/#/patchset/20261103-kfd-svm-foreign-vram-20261103-v1-1-d6282053cad3@gmail.com?part=1
>>
>> Before treating a page as a zone device page belonging to the SVM range,
>> check that it actually belongs to that range based on the
>> zone_device_data. Non-private pages belonging to other devices or ranges
>> can be treated like system memory for the purpose of DMA mapping.
>>
>> Cc:matthewkrebs8@gmail.com
>> Cc:jm5905938@gmail.com
>> Signed-off-by: Felix Kuehling<felix.kuehling@amd.com>
> Tested with a forked child process after the parent prefetched the SVM 
> range to VRAM. The child's access now triggers a GPU page fault — the 
> svm_bo belongs to the parent process, so updating the mapping fails — 
> instead of crashing the driver on a NULL prange->svm_bo. This is what 
> COW should give us: the child must not access the parent's range in VRAM.

Thanks for testing. I assume this was a hand-written low-level test 
because I still wouldn't expect to see this in practice.

I'll respin another version of this patch to avoid having to take and 
release the range lock once per page. I'll prefetch the svm_bo pointer once.

Thanks,
   Felix


>
> Tested-and-Reviewed-by: Philip Yang<philip.yang@amd.com>
>> ---
>>
>> v2: Addressed code review comments from Sashiko
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 876476046926..2aade0183578 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -156,6 +156,18 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dma_addr_t dma_addr)
>>   	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
>>   }
>>   
>> +static bool svm_page_is_range_owned(struct page *page, struct svm_range *prange)
>> +{
>> +	bool is_owned;
>> +
>> +	mutex_lock(&prange->lock);
>> +	is_owned = is_zone_device_page(page) && prange->ttm_res &&
>> +		page->zone_device_data == prange->svm_bo;
>> +	mutex_unlock(&prange->lock);
>> +
>> +	return is_owned;
>> +}
>> +
>>   static int
>>   svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   		      unsigned long offset, unsigned long npages,
>> @@ -180,7 +192,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
>>   
>>   		page = hmm_pfn_to_page(hmm_pfns[i]);
>> -		if (is_zone_device_page(page)) {
>> +		if (svm_page_is_range_owned(page, prange)) {
>>   			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
>>   
>>   			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
>> @@ -189,6 +201,16 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>>   			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
>>   			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
>>   			continue;
>> +		} else if (is_device_private_page(page)) {
>> +			/* Device private memory from another driver or range.
>> +			 * This should never happen in practice but it's
>> +			 * theoretically possible for read-only VMAs after a
>> +			 * process forks, creates a new KFD context and maps
>> +			 * the same page.
>> +			 */
>> +			pr_debug("Trying to map device private page from another device or range\n");
>> +			addr[i] = 0;
>> +			return -EINVAL;
>>   		}
>>   		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
>>   		r = dma_mapping_error(dev, addr[i]);
>
