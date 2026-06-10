Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD97CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFBA10E4B0;
	Wed, 10 Jun 2026 09:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TdZ5yd15";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C6010E4AE;
 Wed, 10 Jun 2026 09:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVf10JphqUFdKCtqHxLNy0LI0L7BJLG41ewY3TMUFsA5MAFgYyxBEqQlVHeLdC9OFYuoAX88wn1KxHcRzJ4aHxEn0jrs+oB6L0wsknroJijpAEfmUwOOGlOcXDdGzbXVrhCYNhUA5ShQVVD1YlkrRhpJmNi0jsxj+UOnod5MpneF6dCIWQou1UWch8T7EDFD9GdP7R1R0tSEsaOkAvCtQ8CAO7Zjf4+5XNdLl/JbV0EMDvAlXtm1u58ZvEHu/X1gE54kxBi/UNoS3kzAByTXJiLqRSvp2NqC7Ab+OBnQDD7Upc8PhzOb5ycbzHXwv8y++rhjIAnoEXklbEU2XTlZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myPldg31JJQEaU6xrU7/jekaq82rpz7cipRyLmqryX0=;
 b=Fq548peRNKMH/VOUtZbqPNAfU4BTEemcQjl9f6xK2r+pRsLkHpTeBeYb4fd2dmsU1e5Zv1qXCyWZPp22CIWG0JotRQM3LYJdlUZloUnu7mM7Py6jbVdgSiCpcTIbl3xaeGOFSJf2gULX6F/8Im4k7O5H21KkIQuxUc9IE6CTk4+QRJE3Gscj1TBpNohBpVIsjB0/vh5VQBFfkqslRjehdWTr6sExPM5mj5zvDhAmvZeEsY3qygDK1U5ej8QNzX2v6s6ZFDj+LsfzCkJ0dbn3qSHABD/J77RLX+mWu7O84HrjKfgWQ5KIqb0lkSx0WiEHx3OUolU2tNIGH8X6XvSB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myPldg31JJQEaU6xrU7/jekaq82rpz7cipRyLmqryX0=;
 b=TdZ5yd15isxd2skEErF0Y34YnfkvayYqs7qkUh7NisDf8lSQ9PNuCugVyy74zdjkDcoL5Y27/RQhzH8s5euwqt9DzuB6cma6BfOCffDa8H86PC1SUIMa9k/0u5I8nLnV5GSISjoa3YbamSvhit/wchWcAMd2hYHzneVVV4iJPeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Wed, 10 Jun 2026
 09:01:25 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 09:01:25 +0000
Message-ID: <131fd9f5-3aa2-4805-8cc0-f26cafc49e9c@amd.com>
Date: Wed, 10 Jun 2026 17:01:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Honglei Huang <honglei1.huang@amd.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-3-honglei1.huang@amd.com>
 <aiji/CVY4WqFA3XS@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aiji/CVY4WqFA3XS@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: c74bb583-af5c-4412-7a24-08dec6ced9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: TgwnS19ejn6c0BtJo44pIISDwFmPUC7f3xFVtwycofLlj9Rrwtj67mvFL/G+NVGqaSebUnyU9yJNnWO/QdOH9uwqpzESAqwRbKiEyZ5cMcfc1brq2KYjoiDtMued77nsChsab8gyB2iAtcKpFzACAxEn2BvoiO7c6qImKp0s1QctaNwoh0hRtrf4OnvBprFdFq5KLp4kQxn/JrLW2Yk5Wup0tjoFkctWE8WvCjCfe9UJrzAAdsJjLvPZudbl5TbNAJ0zXc1RLrCmHpFycOyPtynbPgzIFmevxChHcMWPfh53TS8pqroN5REPB0z+YMZ/hSFSGVein8peBsEWMFFisE2mXzaLz2O0cYrf0khehGY82R/mM5QAikJHKT/pnobCqzHlw/Ser8VoyLacwi6+KT+rY7cxmoKXeAsFkb4ohXWwrE2aR4RqUTVPn0Iv4/q5AOckA4SOrn9NKGuk+GRdae7EeNXqQbLFFwPSm8MSXHwrPyh/+GKLOrMlDc2bDIF1OhZwWF30y8xxXMo4wTA69xCMnsiRKYje5xTiayZRBfLEYtmC993r1lRKYg9+tM+S73HkDL/H30mwu1cmMm+czlXxs1h4Pj9NKVtcrYsXxHBndqlf7LQ0r/HUGA2FLD9Tte3LGWrFO/05EbChlNvOKZ7mxrjxdnbYJpUWx0ULaPLXX9KKlAGyhxkUBbdf/rwz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDlyOTgzU0FEbEp1UkFHZ1QvVDJFNDk5K3kvNU9jQzdpTHdZbFEzZFkwU3dO?=
 =?utf-8?B?TG9LMTI4SVhBWlNiSWZERllhOUllSnBWZXU2VEpMTTRkSUt1R1RKdmFxZ29v?=
 =?utf-8?B?NHlJUVFwZGxZelR6VnlxQ0daY0M2eGd1L0xDb0dJMithazJDejhZcisybnZ5?=
 =?utf-8?B?OEU4WU5JVzE2SmVGR3l0bXRIeFNieDJ1c1ZGdnFXRDNFSnRqTmpGbkFpdnhC?=
 =?utf-8?B?MzNhbG5FRWhVaXlWTlRzWWFZMUhhaGxJOVFaSGZ3V05mUVZuSi9ZZFpTWFJH?=
 =?utf-8?B?UjMzZkhGYWJVT0lPd2s3NEwrSHgvUkxYa2M4Y3NHc0luYWNuRzFHeW5DNWhI?=
 =?utf-8?B?WW43QWJyNzRyeDJvS0hsK0ZFeVRtcFV1dzlEZGxvN3FyTUE2cFZiUmp4NGx0?=
 =?utf-8?B?VmRiS0VlV01TQXZ1dkloNDlqN01ZK3MwN3A4amRTQklpN1NWNDNpbEpUYlRT?=
 =?utf-8?B?SjdPR3JmbWljUHVxeDdtOUhZM00wTkp3ZGp3R1I1UWdYRVlJbWNrS21NRDBY?=
 =?utf-8?B?KzN4NW5TcUN2eFFkcXZzZE5qYUhqVWJkbldwdFUrYkpsM2hxNVR3V1g1UDhm?=
 =?utf-8?B?YXFzSHM4YS9SeEczcGpxVFV2dWQ5dHNUVU9zbVhySkVRQVhydWFRRDNVakJs?=
 =?utf-8?B?RlRkd0lpZm1EYUdJS09aL2NzY29sKzhwQlNmcW4vUHlZQVh6YU5FTzhkVFBO?=
 =?utf-8?B?NzkzSWVEdmk1WkZCaGFCM2hlMGpWbmFlSE1zSnFYNVdZMklsS1Z3MFlPY3l1?=
 =?utf-8?B?dE5ZeTJNSFA1NVB0THpnZWxJMEhUNSs4NWJWSFBWcjhKaUhzMHVyMlJNK0VB?=
 =?utf-8?B?ZGRBQ0ZjWG5Ya0h2M2d6S3NTOXQ5NGhoanJZcU9qVTA2bHVkaStzamhEaU12?=
 =?utf-8?B?a1B6cWpzbGJsWmVTTHBleVJoWHNZUTJKQ2RlTk91a0Q5VkNGYnk4QVlpSVBo?=
 =?utf-8?B?UHNrK0RzM1N6enBDVGcvTHFRdTczSThNaWpMWGJDWHdrVjB5MG9aZENuTFlp?=
 =?utf-8?B?d3hoNm5MVG1iV05HS0tOU3VPYy96QXg1RndSMTFQdzZCTFNTNjJUckpybEVu?=
 =?utf-8?B?YlBZa3ErZWc1TDhSb0Y3WjllbzdnU09PU1Z2cVg2bWZNOUZLdVZPbGhmcDRI?=
 =?utf-8?B?QWRvRkJIcVJBdXgyZHdVaUVaNEJmQkY0eU1HYmtxVU5HZjh5RzBKUjNMSUwv?=
 =?utf-8?B?cUtVamExQ1hHR3VQeWhYZjc2LzkxRjNsRFBWNmN0N0pFdzlJYS9lSkw0Z2dD?=
 =?utf-8?B?RjZob2FBdldwSzVKZzVGV0VPa0FaZWVtREN4WFJ5TUpBMFhwVktDS0hoNXBP?=
 =?utf-8?B?b3FBUmRnemJHUVJjN2VoL0cycDQxbUZqdnp5V05JSUxjVlJ6QkFQZHlYZUdF?=
 =?utf-8?B?TDdmTnJZZUVrVWRUejE5a3YvclFLQllmaVMvK1RiMTErb3BUSXJ3Rk4wdkQz?=
 =?utf-8?B?NVdBNXF4TjVSYWNHdFJYSCtsd2lQRXhwZVFSaEY4U1A5QkxFT3pmc3ZGODNW?=
 =?utf-8?B?MVRiMDE1UXNwNjlLR1dtbTNGVS96b1d0Vmp2SzZMMmJGMThXUGlsREwyU090?=
 =?utf-8?B?SzNTTnFRVmdUUlMzZlJFazhFMkh0STlYVzd4cVdHcUpGdGp5cW9oRFZPYk9W?=
 =?utf-8?B?dGh0YklRMkwxSG4rT0JBZlhNL0xyV1FqRTA3TFNZdGpCZWh2YWk1amhJTE9L?=
 =?utf-8?B?c2ZBNVBnemIvVUpZeHQvOXB5S282YXRMYzBKb1BwbUY5dzVIc2R5SXFmVG5X?=
 =?utf-8?B?NXQ4aithWXdhVnpaNld3bTlMaGlRQ1VBekluTVBJTC9ZL21lMFZzUHhmV2JR?=
 =?utf-8?B?VXI3LytWYUxYQ2dDdjIya3ozUnFTY2FvTU1Jd3k2RVZCVzhLOExpQU1HaWZw?=
 =?utf-8?B?RWlxU1FsRGovZ2NEQ0RDNzU5b3JOd2V1SmIrL0Rrc3p3cVZlOVBieXgrd1l6?=
 =?utf-8?B?N3dBSkx6SnRLWVhUSkF2d1Q5WkI2T05XdWNGVTQvQkswSHNhOVV3SVBnd01p?=
 =?utf-8?B?YjdrdTdzRC9zdG54RDNhVzJlT3ZoTEV6dFJCKzE5M2JjRHVLK0UyYUVNcUFv?=
 =?utf-8?B?dStLek9sVmdCZUpaYWhhSmxMNFFiK0FETFJnaTJuZklOcnBEU2lPZTV2S1Zy?=
 =?utf-8?B?M3ZkUlFTY2Npbjh6Wjhhczh4N3o2NmVWbnpkWmVzVnZRWW5yU3pUd3UyaS9u?=
 =?utf-8?B?SXpnYmV6WXJFRDQvSmJVZFVLZUh6RGNadW1BUTdLMVZMZFd2SzhvaTVpVmpP?=
 =?utf-8?B?UkVmZ1ZjTE9wSXNNWStra2lpQytMYnRPeVhjcm9MclcwM0NKREU4R2thSmFC?=
 =?utf-8?Q?be22gRnrTNAQEY/YxB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74bb583-af5c-4412-7a24-08dec6ced9aa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:01:25.5053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z41eVMBbb4fa7AlniOtzJ1va6eUW+4B7aPaOL81Hi8FBr7o1jTKJEWAZoWfzCHG+T1yLAytNrO/rjFMn4wZQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525
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



On 6/10/2026 12:07 PM, Matthew Brost wrote:
> On Wed, Jun 03, 2026 at 02:56:17PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> drm_gpusvm_pages is the layer that actually represents physical
>> pages/mappings it owns the dma_addr array, the dma_iova_state...
>> With the previous patch, so drm_gpusvm_pages is now strictly about
>> physical pages and their DMA view.
>>
>> Since now the drm_gpusvm_pages instance is inherently bound to one
>> specific drm_device, make that ownership explicit by giving
>> drm_gpusvm_pages its own drm_device handle, and drive all DMA through
>> it instead of through the gpusvm:
>>
>>    - Add drm to struct drm_gpusvm_pages and a matching drm parameter
>>      to drm_gpusvm_get_pages(); the dma device is bound on first use
>>      and immutable for the lifetime of the pages instance.
>>    - Route all DMA in drm_gpusvm_get_pages() / __drm_gpusvm_unmap_pages()
>>      through svm_pages->drm instead of gpusvm->drm.
>>    - Update existing callers (drm_gpusvm_range_get_pages, xe userptr)
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c    | 37 ++++++++++++++++++++++++---------
>>   drivers/gpu/drm/xe/xe_userptr.c |  1 +
>>   include/drm/drm_gpusvm.h        |  3 +++
>>   3 files changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index 6000d587cf2..3f076178b2a 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -1135,11 +1135,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>>   				     unsigned long npages)
>>   {
>>   	struct drm_pagemap *dpagemap = svm_pages->dpagemap;
>> -	struct device *dev = gpusvm->drm->dev;
>> +	struct device *dev;
>>   	unsigned long i, j;
>>   
>>   	lockdep_assert_held(&gpusvm->notifier_lock);
>>   
>> +	if (WARN_ON_ONCE(!svm_pages->drm))
> 
> I think it is valid to reach this point without calling get_pages() and
> assigning ->drm, so I don’t believe a WARN_ON is required. One example
> would be creating a range, attempting to migrate it, and then failing
> because the user performs a munmap() on part of the range, resulting in
> the range being freed. It’s a weird race, but it’s possible, and I’m
> fairly certain Xe SVM tests exercise scenarios like this.
> 
> So I would drop the WARN_ON, add a comment like “get_pages() never
> called,” and bail out silently. Alternatively, if drm is NULL and
> has_dma_mapping is set, then a WARN_ON might make sense, as that should
> not be possible.

Got it, will drop the WARN_ON.

> 
>> +		return;
>> +
>> +	dev = svm_pages->drm->dev;
>> +
>>   	if (svm_pages->flags.has_dma_mapping) {
>>   		struct drm_gpusvm_pages_flags flags = {
>>   			.__flags = svm_pages->flags.__flags,
>> @@ -1379,6 +1384,7 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>>    * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>>    * @gpusvm: Pointer to the GPU SVM structure
>>    * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
>> + * @drm: The DRM device that will own the DMA mappings. Stored into @svm_pages
>>    * @mm: The mm corresponding to the CPU range
>>    * @notifier: The corresponding notifier for the given CPU range
>>    * @pages_start: Start CPU address for the pages
>> @@ -1392,6 +1398,7 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>>    */
>>   int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   			 struct drm_gpusvm_pages *svm_pages,
>> +			 struct drm_device *drm,
> 
> You could also move drm into a function like drm_gpusvm_init_pages() (as
> mentioned in the cover letter). I don’t have a strong preference, but if
> we want a helper that calls hmm_range_fault() once and accepts an array
> of drm_gpusvm_pages to DMA-map, that might make sense.

Got it, will init the drm device in drm_gpusvm_init_pages.

> 
>>   			 struct mm_struct *mm,
>>   			 struct mmu_interval_notifier *notifier,
>>   			 unsigned long pages_start, unsigned long pages_end,
>> @@ -1421,6 +1428,15 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   							   DMA_BIDIRECTIONAL;
>>   	struct dma_iova_state *state = &svm_pages->state;
>>   
>> +	if (!drm)
>> +		return -EINVAL;
>> +	if (svm_pages->drm) {
>> +		if (svm_pages->drm != drm)
>> +			return -EINVAL;
>> +	} else {
>> +		svm_pages->drm = drm;
>> +	}
> 
> Style nit: If we keep this I'd write this like:
> 
> if (!drm || (svm_pages->drm && svm_pages->drm != drm))
> 	return -EINVAL;
> 
> svm_pages->drm = drm;

Got it will modify in next version.

Regards,
Honglei

> 
> Matt
> 
>> +
>>   retry:
>>   	if (time_after(jiffies, timeout))
>>   		return -EBUSY;
>> @@ -1515,7 +1531,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   
>>   				pagemap = page_pgmap(page);
>>   				dpagemap = drm_pagemap_page_to_dpagemap(page);
>> -				if (drm_WARN_ON(gpusvm->drm, !dpagemap)) {
>> +				if (drm_WARN_ON(drm, !dpagemap)) {
>>   					/*
>>   					 * Raced. This is not supposed to happen
>>   					 * since hmm_range_fault() should've migrated
>> @@ -1527,10 +1543,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   			}
>>   			svm_pages->dma_addr[j] =
>>   				dpagemap->ops->device_map(dpagemap,
>> -							  gpusvm->drm->dev,
>> +							  drm->dev,
>>   							  page, order,
>>   							  dma_dir);
>> -			if (dma_mapping_error(gpusvm->drm->dev,
>> +			if (dma_mapping_error(drm->dev,
>>   					      svm_pages->dma_addr[j].addr)) {
>>   				err = -EFAULT;
>>   				goto err_unmap;
>> @@ -1550,11 +1566,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   			}
>>   
>>   			if (!i)
>> -				dma_iova_try_alloc(gpusvm->drm->dev, state,
>> +				dma_iova_try_alloc(drm->dev, state,
>>   						   0, npages * PAGE_SIZE);
>>   
>>   			if (dma_use_iova(state)) {
>> -				err = dma_iova_link(gpusvm->drm->dev, state,
>> +				err = dma_iova_link(drm->dev, state,
>>   						    hmm_pfn_to_phys(pfns[i]),
>>   						    svm_pages->state_offset,
>>   						    PAGE_SIZE << order,
>> @@ -1565,11 +1581,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   				addr = state->addr + svm_pages->state_offset;
>>   				svm_pages->state_offset += PAGE_SIZE << order;
>>   			} else {
>> -				addr = dma_map_page(gpusvm->drm->dev,
>> +				addr = dma_map_page(drm->dev,
>>   						    page, 0,
>>   						    PAGE_SIZE << order,
>>   						    dma_dir);
>> -				if (dma_mapping_error(gpusvm->drm->dev, addr)) {
>> +				if (dma_mapping_error(drm->dev, addr)) {
>>   					err = -EFAULT;
>>   					goto err_unmap;
>>   				}
>> @@ -1585,7 +1601,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	}
>>   
>>   	if (dma_use_iova(state)) {
>> -		err = dma_iova_sync(gpusvm->drm->dev, state, 0,
>> +		err = dma_iova_sync(drm->dev, state, 0,
>>   				    svm_pages->state_offset);
>>   		if (err)
>>   			goto err_unmap;
>> @@ -1635,7 +1651,8 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>>   			       struct drm_gpusvm_range *range,
>>   			       const struct drm_gpusvm_ctx *ctx)
>>   {
>> -	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->mm,
>> +	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->drm,
>> +				    gpusvm->mm,
>>   				    &range->notifier->notifier,
>>   				    drm_gpusvm_range_start(range),
>>   				    drm_gpusvm_range_end(range), ctx);
>> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
>> index 6761005c0b9..7e28f6868ff 100644
>> --- a/drivers/gpu/drm/xe/xe_userptr.c
>> +++ b/drivers/gpu/drm/xe/xe_userptr.c
>> @@ -75,6 +75,7 @@ int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma)
>>   		return 0;
>>   
>>   	return drm_gpusvm_get_pages(&vm->svm.gpusvm, &uvma->userptr.pages,
>> +				    &xe->drm,
>>   				    uvma->userptr.notifier.mm,
>>   				    &uvma->userptr.notifier,
>>   				    xe_vma_userptr(vma),
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index 3dba4b9516f..ed228d9ff6b 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -127,6 +127,7 @@ struct drm_gpusvm_pages_flags {
>>   /**
>>    * struct drm_gpusvm_pages - Structure representing a GPU SVM mapped pages
>>    *
>> + * @drm: The DRM device that owns the dma mappings
>>    * @dma_addr: Device address array
>>    * @dpagemap: The struct drm_pagemap of the device pages we're dma-mapping.
>>    *            Note this is assuming only one drm_pagemap per range is allowed.
>> @@ -136,6 +137,7 @@ struct drm_gpusvm_pages_flags {
>>    * @flags: Flags for the range; see &struct drm_gpusvm_pages_flags
>>    */
>>   struct drm_gpusvm_pages {
>> +	struct drm_device *drm;
>>   	struct drm_pagemap_addr *dma_addr;
>>   	struct drm_pagemap *dpagemap;
>>   	struct dma_iova_state state;
>> @@ -328,6 +330,7 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>>   
>>   int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   			 struct drm_gpusvm_pages *svm_pages,
>> +			 struct drm_device *drm,
>>   			 struct mm_struct *mm,
>>   			 struct mmu_interval_notifier *notifier,
>>   			 unsigned long pages_start, unsigned long pages_end,
>> -- 
>> 2.34.1
>>

