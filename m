Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F7FCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D0510E4C0;
	Wed, 10 Jun 2026 09:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3j02Kcz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ADD010E4BF;
 Wed, 10 Jun 2026 09:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdEovS0Hwi0ulDGxi5bX6fD7PA989YTU6SXbW7LfLetQHL3SwEDvVQOAjQiRciRHNkgH13aSicuj/dEty73CwSClO6PzqSKG6J5Q7HXaALi2+gZKkiyvjgSBYBfSPj+lt0A2A7eo6JkwxhXrCsYx4di/1tLiMs+cxIXNP2J0glxMDybY3N8ZUi1QTfMwYBw0cp4R0TrSeUaPXCfBe6Ux/D287uv5BDsXW3KVrxJNti0SFOHlrNpt1VUtd1GmrbMTJEVyBL5Csezk+WMEiwPbANdcggDuTwJ1KMhv+lOmx578E5OgGn+HQ/xoxTMT95V6x2cZO0XSr1VCNkMb5BlN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F0fJCoAeh3rP67QN/OQzkmJpgxx1F0B/tSxlo8Dm0o=;
 b=SmhGWaundEPIIEobRahMSSWvnAKweTER/7CD/b/DpPTYZNDb5265P+I9tv9W2rQ+CFiM+uizV/MoiPGF2O91e4bSOPBUDWGs736Om9BaltTakA2MTxQMwSOgQH+bFPn7j8Z5RVigPHrbgW0DYSwbiFuafgliwiX8aDG344m2theKZ6NHZN4ZwdJzLFL32muQ0oSy2gontLOaf9ANY+3IBnRHNOq7FBKZ9XzjonwTeQJzwhIll1HdFYsRaMAkIqEdqlVroq1rNfCuq4Z5HMWSDYloocxORH7Srynz6ZxbuBLYnmrlufPMxa33PbfnFQOi9dcCr+WbYX9s5oBI5klAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F0fJCoAeh3rP67QN/OQzkmJpgxx1F0B/tSxlo8Dm0o=;
 b=e3j02KczRrcESIhBeOB9FOCCPOkJpN7mqB31WSj9toiDS1mn5oLEKG+btPPq7GMCEIswg2wfvgYedvTdn7l9A942eFkmJJ0FfTdxFN+jhTSzl54eUoVN8YNeaqXL2r4djNLnRit2NuO1Zz9Lq+EYVQhM6if+Peu5NMimWAFw7PU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Wed, 10 Jun
 2026 09:04:55 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 09:04:55 +0000
Message-ID: <c1c7cf59-3936-46cf-b57e-5060bf87e4fb@amd.com>
Date: Wed, 10 Jun 2026 17:04:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of struct
 drm_gpusvm_range
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Honglei Huang <honglei1.huang@amd.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-5-honglei1.huang@amd.com>
 <aijlYhfsvhxNUxja@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aijlYhfsvhxNUxja@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0037.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::9)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 119b9b38-9ad1-4c07-eaf8-08dec6cf5702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XnGjeGzOe9+TujFNnD8yHzDwLAhR6nsHueKjSdnpCXNpGBemCki593bpLa40Ya1hW7CTxmEAoPryEOo74GW6Tf6QldQQUycjkyf2YZemAFh2TRWwd+YYWJYcc/59b2gewz/nN5+kJMO7qPIUSglSGj4vvPt5mi3f5B7PpIj1D62swea2Uq9LRobFTninzTbj8GBNVI2md6rzWZggFGMrh0d440I6pbgeixJ8JEZ6/EtvnzU+RVPQ6bV/5yjhl4Z0oWmZU5TQ9vjcrBMwU0+ZNN4cfWiwjxY0Gprpczz+rIj541uzHFYvZS7iS6aWVNsToxw5wO6EWKyLhGYmQEdp6++vKTRrtROnD8uOshkvEWhrzLLIbc3puThMBsyMOeG4/XFRutFLObuFUVbK0WKobFMx+9tpEREW7K/JUAcF0tffymWe1yt598B3jbP0Gzwpys7hn21LZhS4J2PUd83cJwQqBykKDKQtncVXiQ/HVK5/N7qcfZRWOK13IchmH+INzC/dKIEF9mtQ0zm1i97hPAX/7XewuqM8qzKaHAkNdHsuFtMs9tXyYv+3vmXz6n4OCvQLEUky7nZhbbL/JiY7GJeM7lGUOIxtv6cdrayqDu9PSVYUVkd4753rRiEyn61jSYOftZy6SIgOHA1rZJbA276r5rXmqm1fSy22E0bD7x0dEWcQCvhLb2m56qcVbi52
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZJc2Mxc2I3eVI4RFAwS1BMckZwUmdScmswbkdHOFJZQW1VOWRSVFpoYVUr?=
 =?utf-8?B?ak11WjRqRDNxSWYyd0R0MTJzWUdqWUMzMWJOTjhRMEsvRVBleGRuVzcvMlR1?=
 =?utf-8?B?RVlZN2hLRFpQRjJhenI2a3JxNENoVHRxa2Mza3JrQTJXa1JlZVBDWnUvTFUw?=
 =?utf-8?B?SlRnNk9FNmVDcE5vWG15cStBdEMzR1pGOWNzWTZ4R21GVEQvTk5YTDZHQjAx?=
 =?utf-8?B?TVhCdGwwLytIeUFaYkVDa3VMc0VhWUVuZVp6amRTcEczWDdObU9NSmE4OFFV?=
 =?utf-8?B?YTdZMVJ4WDR4SUFsZzdGSFZRTVR3NW9rbG85S0tvRDlPMURSNU00YWNBSUVE?=
 =?utf-8?B?WmY4cmRCV1NOUVppRHhmOThZWDN5WXoyeHkwSGx0U3JydWwwMWlTSkxjQzNL?=
 =?utf-8?B?Tjk0NU55UDc2emV3aHJrMkVKMXVtRjJGWllZanFLVkg1Z1NQWFNsa0xPcUZt?=
 =?utf-8?B?RnVXZFNreUVmMVF5S1pnWE02OUozRG9mTnNqQUkvL2JTUlQ3VHVDSTB2MkhU?=
 =?utf-8?B?S2E5YWR0M0lqcTlBMlpLRGk3NFBkN1V4WGpvcnZWRXFKMzlmNXJCMzBIeXBK?=
 =?utf-8?B?aCtsN0UrV0wvUUZveTBqZXhnQ3pqaDNYU0xUNEFCQTVQVDdXcWhyNWNjM2Rn?=
 =?utf-8?B?blFNY0RCekdZMFkvdmtSUUxyT09TY2hpRWxONDVwb2xtc2dqRDk2MEVzOHh3?=
 =?utf-8?B?ZlRWbnZSb29Pd3hjcDVZNldYSHp2S3JITlBPbnFZVlpORHNJRk8xbmRKNnc5?=
 =?utf-8?B?QndoTmt2QU9HWHVjWlpoVFloSWhPQjJKcTNUVW1nMFp5M2J5L211WGxUczhj?=
 =?utf-8?B?U1EvTk9Wb2JMYWEvenladExRSlJPS3FpUHh1OFVlR3pzaGowZWhLQlpRMUNj?=
 =?utf-8?B?N2hnZkZvcTF6TW5leUxyaE9MUGlXcmhFQ3lZRktQUDFXT0xyenpUUDRFQkFW?=
 =?utf-8?B?amNZNDRmbkJ0cTljd1JINXNxcW5PSEdmK0tTY28vcmxIcVRiUEZVODlZSHdD?=
 =?utf-8?B?b2pMYmNpZ0ttQnJlS3hYQ2NrU2FIMFRyVkZwbHNxdHh2ZGo5NjgxL3JkK3VX?=
 =?utf-8?B?dHh4OVJ1Ty9mRldZMk0wYzMvZTlxTXZibDBzL1VkaEh1ZWZla093dE5iTnJR?=
 =?utf-8?B?eHVMNmpBYnl3VHNaT0dtN3BGcVNIanBtaVk2eXNvQWNwWjNuUG9NNnNMeFY3?=
 =?utf-8?B?UXdWbGxodURqcHBaYUg4dE5PdURCL0dWRHBCT3lMTGRwcjVnMHpVRzZCck5Z?=
 =?utf-8?B?em5BaThEUEIxZ3JJbmhHUEZnS0VNZldQNXIyR2w3dmtOeEpmTXVVV25BdmpR?=
 =?utf-8?B?S042L1lmTEV0SWJzSW4rSGNVNEhwRi9SRENyeTNpZnhsRUFvV1kxb3dJRGRM?=
 =?utf-8?B?d28yZ3N1Z0ZQSmRXTnUrakVWMTFRckhSVkNtRnJFMGtUVzIxL1M0RmJLZ0pL?=
 =?utf-8?B?MVZPY1cwUE4zeVNLbVVLcFM2S1RnWElCdUplR3NNL1U1NVdFcXlIcFN5bTAr?=
 =?utf-8?B?Tkl3K2dlQ2laMnhNaDRwbGhhMkNxOCtGZGMzUkhGa0V2K1lWazYxWmJHTXBt?=
 =?utf-8?B?RHN2NmUxVG5UWHM4eE5FNWJ6THA5TkZXM1Q1bW52L2lKcjJuQ1V2UVdIb2d2?=
 =?utf-8?B?Qmg1cDE3V3JRdk9kbXR4ZkFhWEY4eEh0aEFGdDB6Nm10ZTRRUzRiVUVHQlVQ?=
 =?utf-8?B?TlBxTkFRakpEZUpVeHZUNkUvMHNEcW14ZEtldTFiS0g2T09nVEU3ZmFaY0lR?=
 =?utf-8?B?eVZIZU9PQWxIQm1VNmYvLzBKZWF4S2gzcERMVmhrWXV3Y1B0cU5ibG5uNzZY?=
 =?utf-8?B?a3hKNVZ0bkk3TjFwd2wrZUI3SjhzcnRUSUV3Mkg3OFlJOEttNXhzcWM4SDhZ?=
 =?utf-8?B?YVVNcVIrVHowcG9ITFU4RSs0SW4wY3hTTmJ0dHFkZTJyV0lLM2Z3OUExRUJr?=
 =?utf-8?B?dWxvS2ZpMDdJNlRoak55QnFoSlRCZXJSa0JMREg1dFpMcy9Mb3VuSlF3L01M?=
 =?utf-8?B?dnhqSjFDZktLTnNGRys0VUM4Ti95VjdJeGNqcWxLcytEZW14dUNYTWpwbkY4?=
 =?utf-8?B?MHpJRE9CMi9VclZjUGNlZEEycUZYTk5Ma3lsVGc0cVRXMDJ4M1htZkp4YmtD?=
 =?utf-8?B?ZTlxS3V3cEZZNXFqakltd1VzZ3ZhdE84SElvcmVIVHh5ZmtzMUpRY2tycGtS?=
 =?utf-8?B?L3hYZWZYL1VMSHV5OU5FaFMzNW1pZUplc3pDUDI0bUpHRkZYM0lyOVk3NHlG?=
 =?utf-8?B?NG1IWUlDSHlpenBKZTdHbXRXd3UwYVljbFkzVjFTWFp3WkFUcnVUQTVKZ1N2?=
 =?utf-8?Q?D+avwWjQk2asyPlxpH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119b9b38-9ad1-4c07-eaf8-08dec6cf5702
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:04:55.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38q5RKYy8v6WMMsx9JC0rvsAKDa5LAz2b9pjgHvDhcXzFn5mBBbCfOKrUlmvaycfqXsh3O9TMa5i5CHKShnsLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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



On 6/10/2026 12:17 PM, Matthew Brost wrote:
> On Wed, Jun 03, 2026 at 02:56:19PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> Since the pages the physical pages and MM VA range has been abstractly
>> separated. Unbinding a single form of physical page from the MM VA
>> range, brings flexibility to the drm gpu SVM framework, transfer the
>> way of management of MM and device physical pages to the driver layer.
>>
>> framework's range embedded pages object and its range level wrappers
>> have no users left. Remove the following:
>>
>>    - Drop pages in drm_gpusvm_range.
>>    - Drop drm_gpusvm_range_pages_valid(), drm_gpusvm_range_get_pages()
>>      and drm_gpusvm_range_unmap_pages(); drivers should use the
>>      drm_gpusvm_pages helpers (drm_gpusvm_pages_valid,
>>      drm_gpusvm_get_pages, drm_gpusvm_unmap_pages) directly on a
>>      pages object they own.
>>    - Drop the notifier_seq seeding in drm_gpusvm_range_alloc();
>>      drivers initialise notifier_seq on their own pages object.
>>
> 
> The patch looks good, but I think the kernel documentation at the top of
> drm_gpusvm.c should be updated—particularly the examples. It may also be
> worth updating the section explaining how pages are embedded in
> driver-side ranges, including the options for one-to-one or many-to-one
> mappings and the implications of each choice.
> 

Got it, will update the kernel documents in drm_gpusvm.c for both 1:1 
and 1:n mappings.

Regards,
Honglei

> Matt
> 
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c | 68 ------------------------------------
>>   include/drm/drm_gpusvm.h     | 13 -------
>>   2 files changed, 81 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index a4b56cefeb2..55515390c53 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -640,7 +640,6 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>>   	range->itree.start = ALIGN_DOWN(fault_addr, chunk_size);
>>   	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>>   	INIT_LIST_HEAD(&range->entry);
>> -	range->pages.notifier_seq = LONG_MAX;
>>   	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>>   
>>   	return range;
>> @@ -1329,27 +1328,6 @@ bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>>   
>> -/**
>> - * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
>> - * @gpusvm: Pointer to the GPU SVM structure
>> - * @range: Pointer to the GPU SVM range structure
>> - *
>> - * This function determines if a GPU SVM range pages are valid. Expected be
>> - * called holding gpusvm->notifier_lock and as the last step before committing a
>> - * GPU binding. This is akin to a notifier seqno check in the HMM documentation
>> - * but due to wider notifiers (i.e., notifiers which span multiple ranges) this
>> - * function is required for finer grained checking (i.e., per range) if pages
>> - * are valid.
>> - *
>> - * Return: True if GPU SVM range has valid pages, False otherwise
>> - */
>> -bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
>> -				  struct drm_gpusvm_range *range)
>> -{
>> -	return drm_gpusvm_pages_valid(gpusvm, &range->pages);
>> -}
>> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_pages_valid);
>> -
>>   /**
>>    * drm_gpusvm_pages_valid_unlocked() - GPU SVM pages valid unlocked
>>    * @gpusvm: Pointer to the GPU SVM structure
>> @@ -1633,29 +1611,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpusvm_get_pages);
>>   
>> -/**
>> - * drm_gpusvm_range_get_pages() - Get pages for a GPU SVM range
>> - * @gpusvm: Pointer to the GPU SVM structure
>> - * @range: Pointer to the GPU SVM range structure
>> - * @ctx: GPU SVM context
>> - *
>> - * This function gets pages for a GPU SVM range and ensures they are mapped for
>> - * DMA access.
>> - *
>> - * Return: 0 on success, negative error code on failure.
>> - */
>> -int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>> -			       struct drm_gpusvm_range *range,
>> -			       const struct drm_gpusvm_ctx *ctx)
>> -{
>> -	return drm_gpusvm_get_pages(gpusvm, &range->pages, gpusvm->drm,
>> -				    gpusvm->mm,
>> -				    &range->notifier->notifier,
>> -				    drm_gpusvm_range_start(range),
>> -				    drm_gpusvm_range_end(range), ctx);
>> -}
>> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_get_pages);
>> -
>>   /**
>>    * drm_gpusvm_unmap_pages() - Unmap GPU svm pages
>>    * @gpusvm: Pointer to the GPU SVM structure
>> @@ -1686,29 +1641,6 @@ void drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpusvm_unmap_pages);
>>   
>> -/**
>> - * drm_gpusvm_range_unmap_pages() - Unmap pages associated with a GPU SVM range
>> - * @gpusvm: Pointer to the GPU SVM structure
>> - * @range: Pointer to the GPU SVM range structure
>> - * @ctx: GPU SVM context
>> - *
>> - * This function unmaps pages associated with a GPU SVM range. If @in_notifier
>> - * is set, it is assumed that gpusvm->notifier_lock is held in write mode; if it
>> - * is clear, it acquires gpusvm->notifier_lock in read mode. Must be called on
>> - * each GPU SVM range attached to notifier in gpusvm->ops->invalidate for IOMMU
>> - * security model.
>> - */
>> -void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
>> -				  struct drm_gpusvm_range *range,
>> -				  const struct drm_gpusvm_ctx *ctx)
>> -{
>> -	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
>> -					       drm_gpusvm_range_end(range));
>> -
>> -	return drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages, ctx);
>> -}
>> -EXPORT_SYMBOL_GPL(drm_gpusvm_range_unmap_pages);
>> -
>>   /**
>>    * drm_gpusvm_range_evict() - Evict GPU SVM range
>>    * @gpusvm: Pointer to the GPU SVM structure
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index 21baf91ec7e..250c59f0930 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -173,7 +173,6 @@ struct drm_gpusvm_range_flags {
>>    * @refcount: Reference count for the range
>>    * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
>>    * @entry: List entry to fast interval tree traversal
>> - * @pages: The pages for this range.
>>    * @flags: Flags for range see &struct drm_gpusvm_range_flags
>>    *
>>    * This structure represents a GPU SVM range used for tracking memory ranges
>> @@ -185,7 +184,6 @@ struct drm_gpusvm_range {
>>   	struct kref refcount;
>>   	struct interval_tree_node itree;
>>   	struct list_head entry;
>> -	struct drm_gpusvm_pages pages;
>>   	struct drm_gpusvm_range_flags flags;
>>   };
>>   
>> @@ -303,20 +301,9 @@ drm_gpusvm_range_get(struct drm_gpusvm_range *range);
>>   
>>   void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
>>   
>> -bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
>> -				  struct drm_gpusvm_range *range);
>> -
>>   bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
>>   			    struct drm_gpusvm_pages *svm_pages);
>>   
>> -int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>> -			       struct drm_gpusvm_range *range,
>> -			       const struct drm_gpusvm_ctx *ctx);
>> -
>> -void drm_gpusvm_range_unmap_pages(struct drm_gpusvm *gpusvm,
>> -				  struct drm_gpusvm_range *range,
>> -				  const struct drm_gpusvm_ctx *ctx);
>> -
>>   bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusvm, unsigned long start,
>>   			    unsigned long end);
>>   
>> -- 
>> 2.34.1
>>

