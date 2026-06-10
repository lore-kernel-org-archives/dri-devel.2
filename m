Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F347CD98CE
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE06110E4A9;
	Wed, 10 Jun 2026 08:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qt1Boh6e";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007DC10E22E;
 Wed, 10 Jun 2026 08:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6Rg8OV4jiy8cb4wAwTrLZR64a34pNVFIc93ObN+7PxqB2h+xIiPNZz6I7sPa2bVHOowqlVGLpGEFa3V+pzLRfJCdq45gJcfGV9s40B35xnFwJZR6wUwGhHm6wA/uLstw6tAWfq2R8upG94TkDryvjfdZk06OI1VWKG6iD9FEkniyZ+caE+pP6/joMWqlsgig0+sNvaVjGMnZRGcHysctfAeeC0SByuMWK7iMpLdRHkzaJxTzPjxUE/DkQLyyUhmqOi2R/kqRFaBtxVHQLd1XqLf7FXLJveEVia0Ucxz2txyDai73clB+XSp3UJuJoNbOzWw6g4QesaxXx4ivDuIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+Hc5m2v8Ift6ooki6S7zTeSLHCVyN+ydM4ZeblArBE=;
 b=Xxx8Lrc6rY7ET0e7bl3mdBYeF2TFyCxuA1Ul9KOmZQyUri7c1040cbtaFcLGFZWNEkzcD2KWZ3a141sbtNdD/sibukfpWan8+8CpMT3RPInarwN1tOvb1vn/fJir2x32hVPY0fE6cs69pDvHJ0BtpO0kYttb92CHb5QF2jbcSWlbVzkt6w4oaRzLOSn3nuRJCtHRkBzTeKrsRpVh2Pfc3Y9vSA5QpzRg4+xEs6pAngrxdbNN9OtjSOl5rvd/GIpvk7iFxGi0o+6xRJdM+8BDDZ1HJpptMy0jkAJC1YaxuBwk5vxLMyFDtwf5Y70jOLjvG/+lQv0/aqyBt1QyOAxL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+Hc5m2v8Ift6ooki6S7zTeSLHCVyN+ydM4ZeblArBE=;
 b=Qt1Boh6eOoFDVQHZ93NOXHyz60XJiHL76giHGD47hCQsPv5HeYUkO1+fVNuWGKMEIDMpKWuRG8G8N7scHGjBc3/uIGf/G5aPKKzGlswbDzWEug8VKVTPoQyU8dZt5it1BNTNVClu9RN4FE+kc/L4WUqcsGidevoU1BNZWZMs9Rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Wed, 10 Jun 2026
 08:59:11 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 08:59:11 +0000
Message-ID: <09d4f94b-5b8b-46ee-bbe6-0e647bd5b833@amd.com>
Date: Wed, 10 Jun 2026 16:59:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Honglei Huang <honglei1.huang@amd.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-2-honglei1.huang@amd.com>
 <aijgLr5HvqJcdYvz@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aijgLr5HvqJcdYvz@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0041.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::7)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ca07f6-a599-49ad-997e-08dec6ce89fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ZPqOVgDBxv3dpr0wyPzjznS2X8orI0l0mIuFiAVYbRxP/SJ7r3ac5KjAte1ldslgYU4hGzjTxmaD9ey2ytCFCkDW/96cKc2ltIW6rz0FA/1iTcPrwlMJWP5c2gTKbbohE6Fq4SL6CeKblISuVr3t9vAmnvuGzIz0X0NyxX5KSPm5W/hdcJAxiZSq1zu17IV2jCNzIwByrNwGcDP8EYKqnlvnnRUYK+KaMY7U+K74JwcaRYa24iwxxwIUK32RA9/Kmf0wd7eg0VUPee+WZ1JjrVf8Fbo8SM4WIiby/ccQEKpeCG9dDhu0Yh6tNW9cYpY3Hd8PNO+Wc4FCpzsxD3Fq8z5xeiVHIOXaZyIyyHPk9pX0U9hgSdpTwsN35tsXOoY5XVwdncBG3JvE8An0QBUUSWopGhfL3L+IMVC9ZWMCEuEStyK45+TQ92eDJFyGKTuLjQzo1Sf4GdMYRY4ibuIoPoym0jrLHEGCIDlAZ67ITCQWhoJidXTiq86SteaSl3O4p6QcOS498vp0w1javvoQYHY3ZxfEtavS97P3KBOj90R+xsdgRLiDUGjw3NfxfDgHlwd1DmwkqbbKEQKKktmh8sFgxvg0gmLyxHktbOBwOuSl0HkdgwcgqCEz91A8mJlFA8FU1NX6e/766NBJSbGBfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTY0SVFwMEJLc3pJRkhpS0JrNVlsRmhxWHZnTGMybEdVVmUzNkE3SHBVaVBL?=
 =?utf-8?B?QkR5U2hrNHBQWHdwYWpNYzN1bXlXcUYwUkFINWxyU1d4Ulh5L0hHaDlqSEhU?=
 =?utf-8?B?T1J4c1ZwbndZaW4vRmFZTm8rZ05iVDQrWkg0OG9BbC9xNGJsOU5sS2VQZUZz?=
 =?utf-8?B?dHRHaUtwNXhqREU3RlF6UFV2Ny8yUXZhL2IzSWd0WEZCOWFZWFZ3SHc3RUU5?=
 =?utf-8?B?VG9FVzVmV29ZdWtZZXpxeTRHMm1OT3llclh5bkw0UWRRY2hlWktLVDFiV1V0?=
 =?utf-8?B?OUlkNXlrZkZuWFRMV0Q1TnJteWJiczI3dWxPcjNGWUV0VGc3Z0lCWEFGMW82?=
 =?utf-8?B?a0twK0ZMTzY1bUZGcVB1L1V6NjlZMHAvdngzVXNaNXR6VnVqSnVxT0J4clBK?=
 =?utf-8?B?V1JoaTdKL0JYRElWWEZjS3E5RkpWT0xsaWt1OHVvV1c4WGpzQVVid2FEN25O?=
 =?utf-8?B?RnZSQ2F0aDkybk1kUTF6M3h6VFNvcVR4Z2VxUStVUVhmUmFWbEdLZk9VU3U2?=
 =?utf-8?B?MldYbUdBSVdIUThVQXJtQ293Kzh0TEJsNFpXdW9kSWU3ZXh3R3IxODBBdjdM?=
 =?utf-8?B?NW5LejBBNlB2QTdHQ013aFl2N0o5V2JjSm5mdEhUMG5qZTVjUDU4UjlKNUhp?=
 =?utf-8?B?WEc4MHJhUlNjNjN2NVZXRkwrSG5ZZ2hGSkhlTW4yRkpTLytiOGgrQWpzN1JU?=
 =?utf-8?B?dXl6ZzhsWDRZZ0JKbVhnd3JwWkRXcTZlMyswQWIybDdRREx2K1hTZDgxVDN5?=
 =?utf-8?B?Wk5LWFBjNGRlQllHcFE3RG5yTXg3MFltMXpGWGRYU05SaFFTN0VSaHl5aytF?=
 =?utf-8?B?RldPek1HMGV3SVUySVRFNEFJL3lRSnRDOUFaVWJNSmpUOXVDakptc0lrSFNa?=
 =?utf-8?B?N01iSzFBODZTaDB3RUpuWks2VHRjQ0F0c1QyMXpZUGVWclRxN3dHYmR2Y0lF?=
 =?utf-8?B?UFBmNkowM21pWjBCSXFoV0VjVWpBbnIwUnZGNTFpcjBYRXMzanNuZERkelIv?=
 =?utf-8?B?cEF4c1h1M3MrODVCRVovMkFEZDNGNXpzNi9pazZCbWRHWDRnQ3BnVExzOHFO?=
 =?utf-8?B?T2FmdmNtQnZaR00xVlFJaEFMSllTcjdPS0x4OUplVWxCUTJqWXBQamdNRkVR?=
 =?utf-8?B?MFRwSXJ4eERlek8rT1BHY255bnV4eExoUE16VGt1bjJCL3NOZm1CdDFUai9G?=
 =?utf-8?B?bkxNd2o0eDNLb2R2UjhnVk8zYzlFdmszMGNMSEFESmQwLzR1dlFRVXZmSHAx?=
 =?utf-8?B?akJRS0Y0YnZJVzEvVjBCOWxGdEs1aXNxNjMzU0dGWGdQL08wU0xKQkJDY2xa?=
 =?utf-8?B?Vk1yKytiVkkvUEd4NktzRWdnbEVWTzhrUnZlZmFmU1lRdGxYVjNndEtDRkRX?=
 =?utf-8?B?WWpIZ2lLWlJYR1hnK0ZaeTdERGkrS1Z6ekJWRlZaZVVpQ1RqaFFybEZzSm9K?=
 =?utf-8?B?Tkt0RzUwNlhMQmJJVk1RYzYxdFMyZkhxRHBDR2lrbW41eTB4RWRjbGZyaGxu?=
 =?utf-8?B?eVE2dXBuN3hUYUNIQUxEWkFYTlAva0d1bnUvRGVyOFNGY2M0NHhYSEtiVURw?=
 =?utf-8?B?VjdDeE1qc2ZEQ0o2VDBBREFnKy9pTVJLR3RMRXZpR29icDg1eDdQTXg2Zkcv?=
 =?utf-8?B?SFA0cEhXS1BEVUprcWoxV2s5WjBTMUZ0T2dHVW1uTHhYSENGRytCQk85UWZj?=
 =?utf-8?B?ejhHYVRHTk5ER0xIQmNReGNNV0FBWm00QkdnK0xJeWZGOTY3S2NrTmpMbVBt?=
 =?utf-8?B?Uk96dXQ2Mjl3S3Juc1JMRU50RVZyd05YR0xjNnptVUpOTTZrQTVYMmFzeDNI?=
 =?utf-8?B?TG9KVmxrYkRieUEyZzBTZnJEa1FFcFZyY2ZhQk5HZGRLSHBsUmJhWElZK3Yr?=
 =?utf-8?B?UXRxMDMySDV2enJCaDhIdnp6WTVPUWJGdHdBSGkySk9KZExzSktkUld6VDNo?=
 =?utf-8?B?dzl0R21ScklqZDhhVEw1WUVybFZpaE9mYzg3Q0lVb3RUa2FUZVkrWGtqZ3h0?=
 =?utf-8?B?VUd2dXBMV2ZuMDZkc0JhbzJ0cy9CNUxMQ2l5MXFBMmJPMXdmY295NXpCRjZx?=
 =?utf-8?B?bHlqc0hBYjhDZzN5U2s2b0p2TWZaU3piaFRad1QxeEE5WThzSTJ1L2lVMmNr?=
 =?utf-8?B?ZnNoeGd5MmVDZ1EvL3NENlZpU055dHlXMGVnNXVtT0pidlZzdDBoL2owRjY4?=
 =?utf-8?B?MUJ1RnFYcWFnKzB2emh1QW9Ya0FtNU1idndreWpzYWoyMCtQV3RTWHl6UVQ1?=
 =?utf-8?B?UERtTDI5S0xMVTAzbjBuMnlOVDFzZXppK3RjN2MrMyt0dGU1eG5UOHNYSE8w?=
 =?utf-8?Q?MY+6BvQz5nRlbH0veK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ca07f6-a599-49ad-997e-08dec6ce89fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:59:11.7163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pufMZ5nxxuGF20yNIV2DQAUiq2P39S7HyLuuOnq0nnhBRTl6VT6bzec3QB4ORTGz2zJa2F+KIFTokRSAUUsJuw==
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



On 6/10/2026 11:55 AM, Matthew Brost wrote:
> On Wed, Jun 03, 2026 at 02:56:16PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> drm_gpusvm_pages_flags currently mixes two status:
>>    - MM / virtual-address state: whether the range has been (partially)
>>      unmapped by the Linux MM, these follow the lifetime of the VMA and
>>      are a single per VA range fact.
>>    - Device mapping state: has_devmem_pages and has_dma_mapping,
>>      which describe the current page mapping status held by device
>>      itself.
>>
>> Keeping both on the pages object blurs the semantics of the
>> abstraction of pages and VA range. So move the MM state falgs onto the
>> range, and keep drm_gpusvm_pages_flags strictly for mapping state.
>>
>>    - Introduce drm_gpusvm_range_flags { migrate_devmem, unmapped,
>>      partial_unmap } on drm_gpusvm_range.
>>    - Shrink drm_gpusvm_pages_flags to just has_devmem_pages and
>>      has_dma_mapping.
>>
>> Side effect: drivers now need to check unmap flages in driver it self
>> to avoid handling the unmapped pages.
>>
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c | 11 +++--------
>>   drivers/gpu/drm/xe/xe_svm.c  | 11 +++++++----
>>   include/drm/drm_gpusvm.h     | 28 +++++++++++++++++++++-------
>>   3 files changed, 31 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index 958cb605aed..6000d587cf2 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -641,7 +641,7 @@ drm_gpusvm_range_alloc(struct drm_gpusvm *gpusvm,
>>   	range->itree.last = ALIGN(fault_addr + 1, chunk_size) - 1;
>>   	INIT_LIST_HEAD(&range->entry);
>>   	range->pages.notifier_seq = LONG_MAX;
>> -	range->pages.flags.migrate_devmem = migrate_devmem ? 1 : 0;
>> +	range->flags.migrate_devmem = migrate_devmem ? 1 : 0;
>>   
>>   	return range;
>>   }
>> @@ -1470,11 +1470,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	drm_gpusvm_notifier_lock(gpusvm);
>>   
>>   	flags.__flags = svm_pages->flags.__flags;
>> -	if (flags.unmapped) {
>> -		drm_gpusvm_notifier_unlock(gpusvm);
>> -		err = -EFAULT;
>> -		goto err_free;
>> -	}
>>   
>>   	if (mmu_interval_read_retry(notifier, hmm_range.notifier_seq)) {
>>   		drm_gpusvm_notifier_unlock(gpusvm);
>> @@ -1794,10 +1789,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>>   {
>>   	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
>>   
>> -	range->pages.flags.unmapped = true;
>> +	range->flags.unmapped = true;
>>   	if (drm_gpusvm_range_start(range) < mmu_range->start ||
>>   	    drm_gpusvm_range_end(range) > mmu_range->end)
>> -		range->pages.flags.partial_unmap = true;
>> +		range->flags.partial_unmap = true;
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gpusvm_range_set_unmapped);
>>   
>> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
>> index e1651e70c8f..3acfddb7c5b 100644
>> --- a/drivers/gpu/drm/xe/xe_svm.c
>> +++ b/drivers/gpu/drm/xe/xe_svm.c
>> @@ -166,7 +166,7 @@ xe_svm_range_notifier_event_begin(struct xe_vm *vm, struct drm_gpusvm_range *r,
>>   	range_debug(range, "NOTIFIER");
>>   
>>   	/* Skip if already unmapped or if no binding exist */
>> -	if (range->base.pages.flags.unmapped || !range->tile_present)
>> +	if (range->base.flags.unmapped || !range->tile_present)
>>   		return 0;
>>   
>>   	range_debug(range, "NOTIFIER - EXECUTE");
>> @@ -1136,7 +1136,7 @@ bool xe_svm_range_needs_migrate_to_vram(struct xe_svm_range *range, struct xe_vm
>>   	struct xe_vm *vm = range_to_vm(&range->base);
>>   	u64 range_size = xe_svm_range_size(range);
>>   
>> -	if (!range->base.pages.flags.migrate_devmem || !dpagemap)
>> +	if (!range->base.flags.migrate_devmem || !dpagemap)
>>   		return false;
>>   
>>   	xe_assert(vm->xe, IS_DGFX(vm->xe));
>> @@ -1248,7 +1248,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>>   
>>   	xe_svm_range_fault_count_stats_incr(gt, range);
>>   
>> -	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem) {
>> +	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
>>   		err = -EACCES;
>>   		goto out;
>>   	}
>> @@ -1507,6 +1507,9 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
>>   {
>>   	int err = 0;
>>   
>> +	if (READ_ONCE(range->base.flags.unmapped))
>> +		return -EFAULT;
>> +
> 
> This is the compile error I encountered when I pulled the code—READ_ONCE
> isn’t valid for bitfields.
> 
> Beyond that, there is a reason why unmapped was checked in get_pages()
> under the notifier lock: it’s the only way to ensure that the pages
> being mapped are valid at the time of mapping, or to determine whether
> get_pages() should abort. The HMM locking documentation [1] (sort of)
> describes this in some detail.
> 
> Since this didn’t compile and exposed the bug, I put together a quick
> fix here [2]. The basic idea is to mirror unmapped in the page flags and
> update drm_gpusvm_range_set_unmapped() to accept an array of pages,
> updating the unmapped flags in those pages as well. This also allows us
> to retain the unmapped check in get_pages() under the notifier lock.
> 
> I’m not sure how you plan to store the pages in the AMD driver, but if
> it’s an array, this approach should work for you. Let me know what you
> think.

Oh that is really a bug in my patch, I added the REEAD_ONCE in final 
check without compiling check, really sorry about it. Really thanks for 
pointing out it.

And will fix this patch according your method in [2]. It should also 
works for AMDGPU.

Regards,
Honglei

> 
> Matt
> 
> [1] https://elixir.bootlin.com/linux/v7.0.11/source/Documentation/mm/hmm.rst#L193
> [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
> 
>>   	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, &range->base, ctx);
>>   	if (err == -EOPNOTSUPP) {
>>   		range_debug(range, "PAGE FAULT - EVICT PAGES");
>> @@ -1623,7 +1626,7 @@ int xe_svm_alloc_vram(struct xe_svm_range *range, const struct drm_gpusvm_ctx *c
>>   	int err, retries = 1;
>>   	bool write_locked = false;
>>   
>> -	xe_assert(range_to_vm(&range->base)->xe, range->base.pages.flags.migrate_devmem);
>> +	xe_assert(range_to_vm(&range->base)->xe, range->base.flags.migrate_devmem);
>>   	range_debug(range, "ALLOCATE VRAM");
>>   
>>   	migration_state = drm_gpusvm_scan_mm(&range->base,
>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
>> index 8a4d7134a9a..3dba4b9516f 100644
>> --- a/include/drm/drm_gpusvm.h
>> +++ b/include/drm/drm_gpusvm.h
>> @@ -109,9 +109,6 @@ struct drm_gpusvm_notifier {
>>   /**
>>    * struct drm_gpusvm_pages_flags - Structure representing a GPU SVM pages flags
>>    *
>> - * @migrate_devmem: Flag indicating whether the pages can be migrated to device memory
>> - * @unmapped: Flag indicating if the pages has been unmapped
>> - * @partial_unmap: Flag indicating if the pages has been partially unmapped
>>    * @has_devmem_pages: Flag indicating if the pages has devmem pages
>>    * @has_dma_mapping: Flag indicating if the pages has a DMA mapping
>>    * @__flags: Flags for pages in u16 form (used for READ_ONCE)
>> @@ -119,11 +116,7 @@ struct drm_gpusvm_notifier {
>>   struct drm_gpusvm_pages_flags {
>>   	union {
>>   		struct {
>> -			/* All flags below must be set upon creation */
>> -			u16 migrate_devmem : 1;
>>   			/* All flags below must be set / cleared under notifier lock */
>> -			u16 unmapped : 1;
>> -			u16 partial_unmap : 1;
>>   			u16 has_devmem_pages : 1;
>>   			u16 has_dma_mapping : 1;
>>   		};
>> @@ -151,6 +144,25 @@ struct drm_gpusvm_pages {
>>   	struct drm_gpusvm_pages_flags flags;
>>   };
>>   
>> +/**
>> + * struct drm_gpusvm_range_flags - Range-level GPU SVM flags
>> + *
>> + * @migrate_devmem: Flag indicating whether the range can be migrated to device memory
>> + * @unmapped: Flag indicating if the range has been unmapped
>> + * @partial_unmap: Flag indicating if the range has been partially unmapped
>> + * @__flags: All flags in u16 form (used for READ_ONCE)
>> + */
>> +struct drm_gpusvm_range_flags {
>> +	union {
>> +		struct {
>> +			u16 migrate_devmem	: 1;
>> +			u16 unmapped		: 1;
>> +			u16 partial_unmap	: 1;
>> +		};
>> +		u16 __flags;
>> +	};
>> +};
>> +
>>   /**
>>    * struct drm_gpusvm_range - Structure representing a GPU SVM range
>>    *
>> @@ -160,6 +172,7 @@ struct drm_gpusvm_pages {
>>    * @itree: Interval tree node for the range (inserted in GPU SVM notifier)
>>    * @entry: List entry to fast interval tree traversal
>>    * @pages: The pages for this range.
>> + * @flags: Flags for range see &struct drm_gpusvm_range_flags
>>    *
>>    * This structure represents a GPU SVM range used for tracking memory ranges
>>    * mapped in a DRM device.
>> @@ -171,6 +184,7 @@ struct drm_gpusvm_range {
>>   	struct interval_tree_node itree;
>>   	struct list_head entry;
>>   	struct drm_gpusvm_pages pages;
>> +	struct drm_gpusvm_range_flags flags;
>>   };
>>   
>>   /**
>> -- 
>> 2.34.1
>>

