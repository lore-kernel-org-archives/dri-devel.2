Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D91AC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 06:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C33610F016;
	Wed,  2 Sep 2026 06:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GEjs6/Yt";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8025510E6EF;
 Wed,  2 Sep 2026 06:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQUq4Erc5ed2ZRi1fDX5IV4xeraJLeEcyHCxxnT9E0szweg66xQhWJsK2ecIENoWq82mvGy+RjfJas3IRS47W0pPN1nnqM/FT+K75wPPzG/UJp2lIokFsD6hkF/rKEMuhyE3z2H5y1d2Z/85YAmssbho/01avXPzLFBGUEYjJpafgqFqTvpo06Du1Ia32PLXF67ZhX+iw22xKwYdCKPB8iqSMsviZpXniFHqJUZe3pTAv4jNd7+RORb/5CxB5H+371dTXZEANGWF0XnY0WBRAk5lIjYMBFd4AJu929A65T5mnOEGE9kxqIZyxt4WjDtXzdUG9i+6TOsGVUzRcYKl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzpiTGcmK93TEHQ5e+q0PCiMiXrEbrFkVi1da866/Qk=;
 b=MdrYt9fF8kiEeEJPExBhASQmcEkCSsKnC5DLicxPnN+pR1D7XFIBbIQ6IeC9ZTRxhrZPRT1YISw3sljriCV4/htI1Ku4c0eP14YJGHVjwa0ad4qJFHNFaG1HEaurtQeuPDosTCwhJ4iYdF/zZ4eJzXRSMliFDw4naCpKNtzlP2QWpFe1hx+rTXLpSyn+Xd381ADDipthgEq9bC90LxC0OhXGPQ2Vf1bxH732YcKJ6v4seMirqxbHOw0IHin5Hx9xeuwSjYhR4rwMT2XpajFw7BCIqWheCqkFZgFwQW0d88lw2d5dHy5DvPvYaAWntNWYbgBfQyqAjHTGvchc2W36TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzpiTGcmK93TEHQ5e+q0PCiMiXrEbrFkVi1da866/Qk=;
 b=GEjs6/YtVJk0SH+NNrWyH7e+LYPi8NSm8MPow3hXOE/AXq+6lOm91IpQD+gacZdGIWBIAsAOnS+JGPLyXQa3+da9i9WNvFZhO/u+VYqMGZs407Dz+86jmEMo2tvLZs4Wgb8SuvqQkcs3sacxy22x3qSOH+hCZnsKUdjxFsVMmnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 2 Sep 2026
 06:23:08 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 06:23:08 +0000
Message-ID: <7d8d5f9d-afd6-4c07-bb2e-bc25677aa4f8@amd.com>
Date: Wed, 2 Sep 2026 14:22:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/gpusvm: extract drm_gpusvm_dma_map_pages()
 helper
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 himal.prasad.ghimiray@intel.com, dakr@kernel.org,
 intel-xe@lists.freedesktop.org, aliceryhl@google.com,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com,
 Ray.Huang@amd.com, Junhua.Shen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260901090100.2024933-1-honghuan@amd.com>
 <20260901090100.2024933-3-honghuan@amd.com>
 <apcq3TLb0SQ4Qs84@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <apcq3TLb0SQ4Qs84@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0008.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::9)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 85339cbb-bb3a-4d29-b033-08df08baa7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|10067099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: PCAjh3gw7/GQRpUgQl+TioKdin1ZHnjGaDQ0icjZqmAamHCtSXRq02c6+SIZP68ll5w8L1lavEf8RD7ENVwwbninzAm3CbaSuoB011+2PQXyxTHhTuzXQ8jva7Oq8tRcxvyew4h8FUUEfsDA6+cWuRp+Gw6osj14UYswZsL55HGLYEbML+Q6jw6u6tvabooHKgvGcM+148E7PC8VV35vXkfKlhuMzY//BWtPFmVbnRcV4CJfsYductZC5qmob2lEiJ8cNh9mkPskNX8ydlJM1cAGGDJBJ0+pH0S839tEMtChZ83WoQY6MtyAF599GYilyioArCPTwcfAjC3bVMZo2lcFTwz640g6VHZ5jvoro7ifJbDD+VPpyics5M5IOLRAVtjq9G85DkbD6HfbxxuE1fBHepBV4LNOCSO6EznEx2ykuVI4O3k6r7YyTVdcaeeIB5XKU/DgtTkpYscj740gRqQjCJ1SBiwYbC52tiJ6DhYcYMOeLILFe0m2ecHlMS1NgIl7jiremC2AzM0QzkSjathSLC+vq9te++LoIB/bdCCK9chPZn6wzZTxSrQgNn19UHlFkPyzA351yh+N134G5adHBLkdwye8hdVAtJ0eE5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHQ3dzhmSmVPMFN4R2RKbGhGYXg2RklJUUlpNWJuWVpaOTlDU2cvOHpxSVVv?=
 =?utf-8?B?Z0ZFNTRoNXY4eDZFaXZra2VFVytYMkFVSndJWTZxdmdPUDFPWngrVm1mNGtH?=
 =?utf-8?B?NWVVWm1USGxGRE5xR0U4UVBhbVVpbDRoVHRWRmt3VWJ1NHh3eGlHM3VSTHUy?=
 =?utf-8?B?a1JGSHNJTVlCNjdzd1FubHN0VHkrVUwvc2VDVDgwa0k1L3UvNWd2MkZkWjVV?=
 =?utf-8?B?SnR3SWRtenE1ZmxoT2oyaUpzN2tMTHV0RERXazEweXNHYmJYVTU4Y3NrSnlR?=
 =?utf-8?B?UkVneU9TalZXajZMbm5VL2wyM3BReWNVSTJ4ZVpWWkdTZHVwK2JUVUQ2d3g0?=
 =?utf-8?B?YXFjRllBSStncFM3Wk8zTVJuZjcraTdkdG1mYThmNXU5RUw2L3FFTHV1bHFL?=
 =?utf-8?B?SlFRYi9mNFFjeUp6ZWR6dXV1bTdlMXZvbkIrMGlDWndXcGoyK3hXR2NWRlZW?=
 =?utf-8?B?ZXRBYkI5MkJsa0lCWGtrZitSMnV0c2JnZXRJV29IVGpXaGl4S0k0SndSYXdl?=
 =?utf-8?B?bmNrSVBsOXVucnJ4MEdRVEgvTnJPUHlnLzZUc3ZtdUFJKzhhR1Bid3NtWk44?=
 =?utf-8?B?V1dDK2ZMTkZ6Ui9taVJMVDN5UWxJREtqZzlnSHUrMDRLcjY0SUR6K0NsYUxm?=
 =?utf-8?B?VUZGSHBCenhSU0l4QlZHTlpuVmRMdkUra3lDaE1ka0tONjN6NnVyajlJY24z?=
 =?utf-8?B?UTJNYTVvS0NJQjBUWHF2aEErOG1DVDB1UFNQYXdaaFk1S1NhRDZRT1hVejJv?=
 =?utf-8?B?eHFKVmc2UGlwVUViNmpkVFNkajF2aXlHMFloam8xVmpoSHFjNjgzVU9zeTFy?=
 =?utf-8?B?SFdkNnRYNjdnZDFzMWoycU9LNThGVVg2RUZvR3c0QWVUWkdEUHdzUGJXaHlR?=
 =?utf-8?B?L0wrb2NBejNZNHlwcGdZdDQ0Y0JiNXBtRURCcE4xcHVRZnBoazViRDd1a3FK?=
 =?utf-8?B?UUFNaWFTMHhYUFFzcmtvcUN3bTBLU3dmUWJVZ2x6T1Y0VFI1T3R3VEZSWVFO?=
 =?utf-8?B?MEtyRlRuZFNxWENHOW1mWnNaK1k2WmVnd3NKdDdwanR0MzNjcDRSVU9taHZL?=
 =?utf-8?B?RlBNbnRqeklsQTl6QWJQaXpmS20rMzhBRmZNUm0xN1IxSXJSRUtGZVlncmFj?=
 =?utf-8?B?ekROSE5ZM21Hb0pxcG9DaTFUUlVWOGVwYTA4QTM1S252YVpndXZ4S3lFVWQ4?=
 =?utf-8?B?cU1WWHEvVW1aRkNDZEZOaWEwWEt0a1dyRVJ4M2JXWGRFV2VrQTM0OFRRUGZW?=
 =?utf-8?B?SC9ZZHJVeFhGY2JJWkh1YW93cEpUUE5PSzFmS0tMMWR1NFhMeDVzR3JjOTIw?=
 =?utf-8?B?NjdaTmF2elV5RFhkNHNwbXZHb2NNV01xMVpRMXdzUFU0bllhMGJuUTJuaFZ1?=
 =?utf-8?B?RXRuUGZ5Zk9mY0x5RWZJQzNtOGx6N083M0RVMnQ1NlRLako2SjdPQ3NYZGFX?=
 =?utf-8?B?ZDh2Vnl3aTFVVHBWUmNzeGVFYlBwSVZiaTg3TlcxeXNWTTcydm9iQ09VR1F1?=
 =?utf-8?B?Ny9jNVpSZUU5MmMwWjR3WkQ5Yzdia3Z0OHRoTHdOQ0NxOVNEWWZNMWRKYldO?=
 =?utf-8?B?K0dCMDhKbzhZUy8xRVdwcnozOWVFSGZuQWFudDlGKzdpeldLZ1Q5TC9aekJt?=
 =?utf-8?B?M3BRV1RtNUtTWHdhTnJNS2hiQmQybkVTZ2w4YW1SSlJRaml3MUYrbE0rMGVS?=
 =?utf-8?B?QkdUWWlyQmJwRWdLOEE4WncwTWNxcnc1N0dXYjBZY2hpNWdyZnB5Y09hSWRt?=
 =?utf-8?B?dHN0WTRJM2k3QlFnT0lXNnJMREVuT1RDWGJEc2hBRjUvRGVYK2Y2N3FFN1Jr?=
 =?utf-8?B?T3JNUmtWME9JMm1uazJKdkM2T3BTajNnZmlzVlJncmkrYmpUU3p0TWd0YUU2?=
 =?utf-8?B?b1dnL3hwY1BJYUJTY3BXOGZKTngrUzhaSmFWRDd4aW4vVSt1RnJlS0VjbFJj?=
 =?utf-8?B?bktRQmtBcFMzMU1HVDB1emdnYWRuTUY4L0pGRnVzZnRWRm4rZFE2a2ZYMERZ?=
 =?utf-8?B?ZzV1ZHZGQmtiQlp4RkxnOWxjTG1IZEgvbC9OVElnMDFzbEY5OW1DdWpMcHc2?=
 =?utf-8?B?R3h6dlhWbmMrSkRTWUM0TmVBbXdMZ3BMYWo1c2pVM0JDaUpybmFWdXN6dDlk?=
 =?utf-8?B?V2s4K3FhZkttMm9MeWxQd1c4TmkrNVptR21JVEN3ZFJxRG1LUm1ONmF4d3Nt?=
 =?utf-8?B?MmVvRnpaS3huQ1ZOT2thR0wzY1FHZVAxdTM5VmE1NEdXMEJhaWV2Vnl4V0NZ?=
 =?utf-8?B?VVdFSVZCSHJFUjh1VkZlTlVHMGhmdWw4em54UHUwVythZ1ZxMFovZnA0SFps?=
 =?utf-8?Q?fjWZ2CD08vwo/5HzfC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85339cbb-bb3a-4d29-b033-08df08baa7ca
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 06:23:08.4935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTbnxZeiEC+iffo/RPv9Ev7WwialLqTt+ca88SOpudHgLV5SwnBIpOFx1UFXfgB0VqClS7J9Hqy8eQcTEfyRRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
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



On 9/2/2026 3:43 AM, Matthew Brost wrote:
> On Tue, Sep 01, 2026 at 05:00:58PM +0800, Honglei Huang wrote:
>> Move the per-device DMA mapping loop of drm_gpusvm_get_pages() into a
>> helper drm_gpusvm_dma_map_pages(). The mapping logic is only moved, not
>> changed, so there is no functional change.
>>
>> The helper maps the already-faulted pfns into one drm_gpusvm_pages
>> instance under the notifier lock and unwinds its own partial mapping on
>> error. The HMM fault and the notifier retry loop stay in get_pages()
>> common code rather than being pushed down to drivers, so no driver has
>> to reimplement the subtle fault and retry logic.
>>
>> With the mapping isolated per instance, get_pages() can later fault once
>> and DMA map an array of drm_gpusvm_pages plus a count, one per owning
>> drm_device.
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> 
> For some reason, Sashiko didn't run on this particular patch [1]. It
> would be good to have it run through the tooling in case I'm missing
> something.
> 
> That said, I can't spot anything incorrect, and this looks like a solid
> cleanup.
> 
> With that:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>

Will resent this series only to intel-xe@list and dri-devel@list to 
retigger the Sashiko review.

Regards,
Honglei

> 
> [1] https://sashiko.dev/#/patchset/20260901090100.2024933-1-honghuan%40amd.com
> 
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c | 225 ++++++++++++++++++++---------------
>>   1 file changed, 129 insertions(+), 96 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index b507de539e6..89c3061d8ef 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -1442,115 +1442,41 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>>   }
>>   
>>   /**
>> - * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>> + * drm_gpusvm_dma_map_pages() - DMA map one drm_gpusvm_pages instance
>>    * @gpusvm: Pointer to the GPU SVM structure
>> - * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
>> - * @mm: The mm corresponding to the CPU range
>> - * @notifier: The corresponding notifier for the given CPU range
>> - * @pages_start: Start CPU address for the pages
>> - * @pages_end: End CPU address for the pages (exclusive)
>> + * @svm_pages: The SVM pages instance to populate with dma-addresses
>> + * @pfns: The already-faulted pfn array (size @npages)
>> + * @npages: Number of pages in the CPU range
>>    * @ctx: GPU SVM context
>> + * @dma_dir: DMA data direction for the mappings
>>    *
>> - * This function gets and maps pages for CPU range and ensures they are
>> - * mapped for DMA access.
>> + * Map the faulted @pfns into @svm_pages for DMA access through its owning
>> + * drm_device. Must be called under the notifier lock. On failure this unwinds
>> + * the partial mapping of this instance before returning.
>>    *
>>    * Return: 0 on success, negative error code on failure.
>>    */
>> -int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>> -			 struct drm_gpusvm_pages *svm_pages,
>> -			 struct mm_struct *mm,
>> -			 struct mmu_interval_notifier *notifier,
>> -			 unsigned long pages_start, unsigned long pages_end,
>> -			 const struct drm_gpusvm_ctx *ctx)
>> +static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>> +				    struct drm_gpusvm_pages *svm_pages,
>> +				    unsigned long *pfns,
>> +				    unsigned long npages,
>> +				    const struct drm_gpusvm_ctx *ctx,
>> +				    enum dma_data_direction dma_dir)
>>   {
>> -	struct hmm_range hmm_range = {
>> -		.default_flags = HMM_PFN_REQ_FAULT | (ctx->read_only ? 0 :
>> -			HMM_PFN_REQ_WRITE),
>> -		.notifier = notifier,
>> -		.start = pages_start,
>> -		.end = pages_end,
>> -		.dev_private_owner = ctx->device_private_page_owner,
>> -	};
>> -	void *zdd;
>> -	unsigned long timeout =
>> -		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>> -	unsigned long remaining;
>> +	void *zdd = NULL;
>>   	unsigned long i, j;
>> -	unsigned long npages = npages_in_range(pages_start, pages_end);
>> -	unsigned long num_dma_mapped;
>> +	unsigned long num_dma_mapped = 0;
>>   	unsigned int order = 0;
>> -	unsigned long *pfns;
>>   	int err = 0;
>> -	struct dev_pagemap *pagemap;
>> +	struct dev_pagemap *pagemap = NULL;
>>   	struct drm_pagemap *dpagemap;
>>   	struct drm_gpusvm_pages_flags flags;
>> -	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
>> -							   DMA_BIDIRECTIONAL;
>>   	struct dma_iova_state *state = &svm_pages->state;
>>   
>> -	if (!svm_pages->drm)
>> -		return -EINVAL;
>> -
>> -retry:
>> -	remaining = timeout - jiffies;
>> -
>> -	if (time_after_eq(jiffies, timeout))
>> -		return -EBUSY;
>> -
>> -	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
>> -	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
>> -		goto set_seqno;
>> -
>> -	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>> -	if (!pfns)
>> -		return -ENOMEM;
>> -
>> -	if (!mmget_not_zero(mm)) {
>> -		err = -EFAULT;
>> -		goto err_free;
>> -	}
>> -
>> -	hmm_range.hmm_pfns = pfns;
>> -	err = hmm_range_fault_unlocked_timeout(&hmm_range, remaining);
>> -	mmput(mm);
>> -	if (err)
>> -		goto err_free;
>> -
>> -	if (!svm_pages->dma_addr) {
>> -		svm_pages->dma_addr =
>> -			kvzalloc_objs(*svm_pages->dma_addr, npages);
>> -		if (!svm_pages->dma_addr) {
>> -			err = -ENOMEM;
>> -			goto err_free;
>> -		}
>> -	}
>> -
>> -	*state = (struct dma_iova_state){};
>> -	svm_pages->state_offset = 0;
>> -
>> -	/*
>> -	 * Perform all dma mappings under the notifier lock to not
>> -	 * access freed pages. A notifier will either block on
>> -	 * the notifier lock or unmap dma.
>> -	 */
>> -	drm_gpusvm_notifier_lock(gpusvm);
>> +	lockdep_assert_held(&gpusvm->notifier_lock);
>>   
>>   	flags.__flags = svm_pages->flags.__flags;
>> -	if (flags.unmapped) {
>> -		drm_gpusvm_notifier_unlock(gpusvm);
>> -		err = -EFAULT;
>> -		goto err_free;
>> -	}
>> -
>> -	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
>> -		drm_gpusvm_notifier_unlock(gpusvm);
>> -		kvfree(pfns);
>> -		goto retry;
>> -	}
>>   
>> -	zdd = NULL;
>> -	pagemap = NULL;
>> -	num_dma_mapped = 0;
>>   	for (i = 0, j = 0; i < npages; ++j) {
>>   		struct page *page = hmm_pfn_to_page(pfns[i]);
>>   
>> @@ -1666,17 +1592,124 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
>>   	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
>>   
>> +	return 0;
>> +
>> +err_unmap:
>> +	svm_pages->flags.has_dma_mapping = true;
>> +	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
>> +	return err;
>> +}
>> +
>> +/**
>> + * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>> + * @gpusvm: Pointer to the GPU SVM structure
>> + * @svm_pages: The SVM pages to populate. This will contain the dma-addresses
>> + * @mm: The mm corresponding to the CPU range
>> + * @notifier: The corresponding notifier for the given CPU range
>> + * @pages_start: Start CPU address for the pages
>> + * @pages_end: End CPU address for the pages (exclusive)
>> + * @ctx: GPU SVM context
>> + *
>> + * This function gets and maps pages for CPU range and ensures they are
>> + * mapped for DMA access.
>> + *
>> + * Return: 0 on success, negative error code on failure.
>> + */
>> +int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>> +			 struct drm_gpusvm_pages *svm_pages,
>> +			 struct mm_struct *mm,
>> +			 struct mmu_interval_notifier *notifier,
>> +			 unsigned long pages_start, unsigned long pages_end,
>> +			 const struct drm_gpusvm_ctx *ctx)
>> +{
>> +	struct hmm_range hmm_range = {
>> +		.default_flags = HMM_PFN_REQ_FAULT | (ctx->read_only ? 0 :
>> +			HMM_PFN_REQ_WRITE),
>> +		.notifier = notifier,
>> +		.start = pages_start,
>> +		.end = pages_end,
>> +		.dev_private_owner = ctx->device_private_page_owner,
>> +	};
>> +	unsigned long timeout =
>> +		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>> +	unsigned long remaining;
>> +	unsigned long npages = npages_in_range(pages_start, pages_end);
>> +	unsigned long *pfns;
>> +	int err = 0;
>> +	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
>> +							   DMA_BIDIRECTIONAL;
>> +
>> +	if (!svm_pages->drm)
>> +		return -EINVAL;
>> +
>> +retry:
>> +	remaining = timeout - jiffies;
>> +
>> +	if (time_after_eq(jiffies, timeout))
>> +		return -EBUSY;
>> +
>> +	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
>> +	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages))
>> +		goto set_seqno;
>> +
>> +	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>> +	if (!pfns)
>> +		return -ENOMEM;
>> +
>> +	if (!mmget_not_zero(mm)) {
>> +		err = -EFAULT;
>> +		goto err_free;
>> +	}
>> +
>> +	hmm_range.hmm_pfns = pfns;
>> +	err = hmm_range_fault_unlocked_timeout(&hmm_range, remaining);
>> +	mmput(mm);
>> +	if (err)
>> +		goto err_free;
>> +
>> +	if (!svm_pages->dma_addr) {
>> +		svm_pages->dma_addr =
>> +			kvzalloc_objs(*svm_pages->dma_addr, npages);
>> +		if (!svm_pages->dma_addr) {
>> +			err = -ENOMEM;
>> +			goto err_free;
>> +		}
>> +	}
>> +
>> +	svm_pages->state = (struct dma_iova_state){};
>> +	svm_pages->state_offset = 0;
>> +
>> +	/*
>> +	 * Perform all dma mappings under the notifier lock to not
>> +	 * access freed pages. A notifier will either block on
>> +	 * the notifier lock or unmap dma.
>> +	 */
>> +	drm_gpusvm_notifier_lock(gpusvm);
>> +
>> +	if (svm_pages->flags.unmapped) {
>> +		drm_gpusvm_notifier_unlock(gpusvm);
>> +		err = -EFAULT;
>> +		goto err_free;
>> +	}
>> +
>> +	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
>> +		drm_gpusvm_notifier_unlock(gpusvm);
>> +		kvfree(pfns);
>> +		goto retry;
>> +	}
>> +
>> +	err = drm_gpusvm_dma_map_pages(gpusvm, svm_pages, pfns, npages, ctx,
>> +				       dma_dir);
>>   	drm_gpusvm_notifier_unlock(gpusvm);
>> +	if (err)
>> +		goto err_free;
>> +
>>   	kvfree(pfns);
>>   set_seqno:
>>   	svm_pages->notifier_seq = hmm_range.notifier_seq;
>>   
>>   	return 0;
>>   
>> -err_unmap:
>> -	svm_pages->flags.has_dma_mapping = true;
>> -	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
>> -	drm_gpusvm_notifier_unlock(gpusvm);
>>   err_free:
>>   	kvfree(pfns);
>>   	if (err == -EAGAIN)
>> -- 
>> 2.34.1
>>

