Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D847C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311A210E3D7;
	Thu, 27 Aug 2026 09:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qx+GMBP6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D628410E3B4;
 Thu, 27 Aug 2026 09:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ9Yx0jWXpPy0uzOjRdaM0/2HIyw9FctQ0SA4bEvzlUwl6Emsw4X51t9Rx+9C2jirndpUY0/D04XptlmVra0yfP7vTx9Tptrle5CslaR/fnyyCVjJOFg+eDo0iEif6bTamj1EIHpmUml65D8bG2yG7GiOAaMvJfydUxKLLBKOMDd3xo+YO2LRaH1USf4WfwN3Vg9OyAE/q4O35OoAKpVIhcwmv41Lu2lzPfRR7NoWQw+CnfkAnC0e10SZjRF9Thg0a86+wBGUTGprgERDLw/1rG4ztfmowkLtIQX2CARkUOJAVgpxEIZQgKzutNbylHXb5ndCc0rZBmiaEMdeHsaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNpK9QC+C1Fk+f0iORlIaQfiTRUF0FeD6aPKyFdhAbg=;
 b=ZZGMbyIvzbW+n9Nx99CbONPIWvfXbkGkg9Qz8yQ7IPF+fO4UbYu9dR8rbDiUeYE6D+GonvfZsww0g+S2C+JtlIcMSl3c8KvNkmWjUND5znxrwhp5NFjuax5fGr+2Pd3v9/iSK+FumtUYtpBI/wHfJXXfrONt/VCwjcoE+q54F6r3DmQIPset5M09QG1gguuuwnd4LAjpx84lVgOW2ATgqO4ZLSyQ/uyKBwFUARuz/fD67UxCw3+viLTaowpuGYf124SQeDO//jzO2QeAGo4KK55KmiN/rGeLOBFupeXhMpbxElmet9aJDkCackqIh8kT9VRUjOKRnhJ9gUVj2UkWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNpK9QC+C1Fk+f0iORlIaQfiTRUF0FeD6aPKyFdhAbg=;
 b=qx+GMBP6d/FGMVDd5f6iod6O7cptBTr3c0985twqYzbgcgiurcovSXI2opt1VwH0Dyc/RqoDY1w5gwUFyZjsP3oSkUpNtpV5PijSHqocWJV/EE/6GPubIPfl3kdiVRGHdX1WOUoksRqShi4v1EDLcdVAKU6kXaTCfIfs2gKZKTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 09:02:52 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:02:52 +0000
Message-ID: <bcdc465f-2f83-4fc0-93e6-ed94b076989c@amd.com>
Date: Thu, 27 Aug 2026 17:02:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/5] drm/gpusvm: extract drm_gpusvm_hmm_fault()
 helper
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, intel-xe@lists.freedesktop.org, aliceryhl@google.com,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, Christian.Koenig@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260827071449.520398-1-honghuan@amd.com>
 <20260827071449.520398-2-honghuan@amd.com>
 <ao/nrkOMOllUKqyG@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <ao/nrkOMOllUKqyG@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9d80d6-6e5a-4c12-d358-08df0419f9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: YMmPTjEwlvb9zt9YHN0QyYxryBg9beoRVXyQDikbJ2s0k6IquAwqWmbZqbnOn1V4s5h412TexvJoalKAU2zC3Sr7MgNNxL6q7wbJgykk7LsKKOv+NMzemaXg0OaDCOeKGEmtkHOz8PLMtqW8JESnIHYU6D9kGb9L0qwQ4VhAb+UnpPqzfqhxfIft0rwgmNjLdFSao2b23starvJFLEmfTXC1UnAE4UWjeRRa5g6NBv8XTpNwlU+WvQTz5b9v1r/APQCDQLCWBlVIVQ3pzFPD8oYEbCkUgVgMPme6WqrJuevji2Em0AYtlgKneN5b0szq6dyzq78SV/zuXRovbGRcVfFxkRCHR3cJ1zIalHeKtxwUP8T7ZrUHucx5kLvZtHmHV+HVqAgpM52EsJxbKffgqzbxLrdKTQGVkPNI3skK3whlcHHeZvt2XIHCUJXL7/qxtGkoNGocJKcOzB7y9nQQlJ9QA9FmDYUSbpoOwC49u9JjQddM2yXmaBV4zXnFEcM3+XV6MBF3uu9NwmeBcBdYRmsHdAs1M9ilVghp/7YMJ7jtY4omda8cdFa6838YE7y2Qv1MjAC/Q+6wRhXaBm4cex5mw97Kmbr5mXTQp8a3cjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eldEN0RiTjErYWptL1orWVhGamJPcURGU3VJMlE5S081dzlBNTlGTnJEQXI3?=
 =?utf-8?B?QVVncksxS2tWRzZTa0pXNExmbGVXUTU3bnBCQ2xwZlRqT2Nld3JKOC9IVytY?=
 =?utf-8?B?MHFkRWlPdnFTTnp5WUdPM1YyM0IrOFQ1SUQ3ZEtjeVdpZlYyVTBsNkhFNnhQ?=
 =?utf-8?B?SVBTM3lVb21mVVZNTXl4aWNDdTNTNSthTzZWWCtFaTF1RkdkVGJ2bm1teVJC?=
 =?utf-8?B?aFZaclJ2VHlwZm1WVjJQd2VicFNIVytXOG9URjhyUHVUQkpJNWxSREp4V3RW?=
 =?utf-8?B?YS9KWC9BOTNtQmRVQTB4UUxSUHczcHJYdXdETkp1eUdaZlBOZXpIU3lOeXJy?=
 =?utf-8?B?M1J1bGNKRlhKSms2TEtOMFhBcXR2MWhQRnBXMnlvNmplV1lwRTg3SUwvWXlm?=
 =?utf-8?B?cWY3RnljYS9BZzcwSVNrRTVtTUlYWGRQNHhqdjV0ZkpSdEwrWU5YdTlsZEhm?=
 =?utf-8?B?ZjNETHI1SlZOejhXT0hqRzJYcGJBMzQ4bTNVMXA0TURxQlJUZ3dIM3p3K1NP?=
 =?utf-8?B?dnhwTzV2YWl3Y2dhL1FXem0zcUM5ZDd1UXQvR3E0d01lQ01KM2hhYjhUM2V3?=
 =?utf-8?B?bVFUK2JBZ01GSlRWdnViNHVyU2ZRcUdRY1YvNXJZTktCQlh3b29mNEhPdmFJ?=
 =?utf-8?B?cmhxRXQ4RVNOQkcxMnh0eDNucmdDN0Y5NXlRTlJzWG1BWGowVzBFd2NMQ3V5?=
 =?utf-8?B?N2ZXd2hCb0lPVGdOT0xmdjlwMGc5RktyN0poZDlCUVVGSExVTlM4TkFQNU1I?=
 =?utf-8?B?N3B0ZVMrVkU2MDNLZnFpSkhEVFc1MEV0TFFuRXQyL1RJR01iQkJLVDQzdWVm?=
 =?utf-8?B?aEx6MUx3SExMK0FaUVRiTk5udzlmOTdjWjgwWVRkYjBITEtGS1F2Q2tzZC9p?=
 =?utf-8?B?amhHY3hQUHI3cmxEM3NKdzFXRGRXRVVpSTBoY1ZuTlNxdUFGTlNZeXZFYVpR?=
 =?utf-8?B?a0F1blR0aWhGaFZQcEUzVGJYZm9uMlY0anl3L0IxUXNJUGJwbkZXbUk3bStL?=
 =?utf-8?B?dUpKUkEzSkV0Y0I3WGRIdUhnZ0dRWjdSdjhMVWZ0Zm1ZUUdkNWtkYUxzcXIv?=
 =?utf-8?B?ZUoxMnpxeXBTMGVlL0lYQytkS2cyS2hycHRReXpKQ3M5TzNYNlJMb21va2V0?=
 =?utf-8?B?dUdnL0NwODEyRXNGSURNdk9XVTRRQUQ2OXpyZjZzU2M4cUJoYkRaYjBXTDN5?=
 =?utf-8?B?RlZGSmtoWktNVFVOSkNiNG1mRmlGTk9Uc3N4MktvK3FsemI1WUYvaTN0bkZK?=
 =?utf-8?B?Qlh0bkNRaFNaZTJHeXp1d2J6bWFLMVBmcmFyeWUvc1g0N1pMY2NjeGJMc0Jy?=
 =?utf-8?B?TVBVY1Z6UDRXSnM4OGc0Y2szZTROWGFiVDQzNW1IM002K3lyeGRUUXBVWWZF?=
 =?utf-8?B?aHZwV2dPWGlHUFZBNWNMVGRFSEhlN0IrckYzVHpxcTduZlk0WVBPaWwzYWJW?=
 =?utf-8?B?bFVFVklXbmZwRUVxOSsxYSszVzFBbzRiRXE5enZTSnA4bDE2R0p4dnliQnMy?=
 =?utf-8?B?ai9ONTdCQzRONkFDM3FHOWRPcDFOdGdQbjMrTHUxN1NGK3k0VE14Z3ZHUkNP?=
 =?utf-8?B?a2xwaDJSNGl1V1g3T25GTTZZaTdjRCttdUxpbUx5MUw3ZkdlZXVqL0plSytX?=
 =?utf-8?B?Zi9wWUdjWVBzR2VJSmZWVG9iQzdzSTdrS095QlIyTUZOeG9uYmJlZ25RVHQ0?=
 =?utf-8?B?ZVhOcjZqTEhFMS9VeGx4VExTWEJLME4xQzRwMGtZWlAzQzRseGQrbW9rSzI0?=
 =?utf-8?B?WVNTdUhYTWlyQllVemVLL1NNakFQMW5qVlBLZDlscXM5Rkd4LzcydFA5cWF5?=
 =?utf-8?B?bUdZNDFzd2JzZ1BOeEVSMzdsS09hRnBFOEhRSkJCK1F6Skdad1Iyd0VYYmtw?=
 =?utf-8?B?cmpxaUgwUXNrM2FtM3dqMjg4V25MWit4UW1vaEhEOGIwSjcxSE1DS1hFVmJx?=
 =?utf-8?B?L25BUmtRVHE1RmZjUUVkTVcvVXc1RjRUOGt4S3luYnBmdFdUeHFLanB5TVJm?=
 =?utf-8?B?QmNuNHlZdkErWG90eTZlYWVCNVF0Q2lTL2pWT0cwRUp0aDdOQ3RxOW4wTDZS?=
 =?utf-8?B?NWMvaUlkdXhmcnZWRy9vbDBvNFhnMGxJaWhwY2hCWmtnNGtUZG1xcUw5V2VE?=
 =?utf-8?B?U0N5OThVNDJicXFMaDF4VXFSL1gvU29YMUNUVVg2TXdYQitmSG92OUx2VTFr?=
 =?utf-8?B?UFA1Y0lHelhZckQ5bHZhYVd4c2xOQTlkM1B5V2tWVVphMkY1T1FPRUtjZGhE?=
 =?utf-8?B?WVNWajJ2WXZHOFVRQzdjUFlMUkgvMUJYLzFZMUZ2RU9xcm9jSi9LMzdQRUJK?=
 =?utf-8?Q?yLfMiah/3RejBOPw+o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9d80d6-6e5a-4c12-d358-08df0419f9a9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:02:52.2339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBb6qiwGK0cr4czfXgQiICciMd9Eu6Sv91n+KoNmkYx/mIzGkcdSqcW3okclyYeNSO4PRqjw/00Oo4q3sNz7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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



On 8/27/2026 3:30 PM, Matthew Brost wrote:
> On Thu, Aug 27, 2026 at 03:14:45PM +0800, Honglei Huang wrote:
>> Make the HMM fault step of drm_gpusvm_get_pages(), including its -EBUSY
>> retry loop, into a helper drm_gpusvm_hmm_fault(). The existing logic of
>> the public drm_gpusvm_get_pages() is not changed, only relocated, so
>> there is no functional change. Keeping the retry loop in common code
>> also means drivers never have to open-code their own fault/retry loop.
>>
>> A single fault can later be shared by several drm_gpusvm_pages instances
>> that mirror the same CPU range. This prepares get_pages() to split the
>> shared MM-level fault from the per-device DMA mapping. No functional
>> change intended.
>>
> 
> I think you might want to just wait on this until Sunday for this
> series. I think this patch [1] is in the core MM tree so when drm-tip
> moves to 7.3.rc1, Sunday, we will have a version of this helper to core
> MM used in gpusvm.

Got it, will wait until Sunday. Thanks for the information.

Regards,
Honglei

> 
> Matt
> 
> [1] https://lore.freedesktop.org/nouveau/20260722-hmm-v10-v1-6-606464dd601a@gmail.com/T/#m68f663ce3e802d7692363c70e6364569134cd6c7
> 
>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gpusvm.c | 67 ++++++++++++++++++++++++------------
>>   1 file changed, 45 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>> index fcfe635bc195..507ef6f0a60e 100644
>> --- a/drivers/gpu/drm/drm_gpusvm.c
>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>> @@ -1442,6 +1442,50 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>>   	return pages_valid;
>>   }
>>   
>> +/**
>> + * drm_gpusvm_hmm_fault() - Run the shared HMM fault for a CPU range
>> + * @gpusvm: Pointer to the GPU SVM structure
>> + * @mm: The mm corresponding to the CPU range
>> + * @hmm_range: The hmm_range to fault.
>> + * @pfns: The pfn array to populate (size @npages)
>> + * @timeout: jiffies deadline for the -EBUSY retry loop
>> + *
>> + * Fault the CPU pages of the range into @pfns. This is the MM level step.
>> + *
>> + * Return: 0 on success, negative error code on failure.
>> + */
>> +static int drm_gpusvm_hmm_fault(struct drm_gpusvm *gpusvm,
>> +				struct mm_struct *mm,
>> +				struct hmm_range *hmm_range,
>> +				unsigned long *pfns,
>> +				unsigned long timeout)
>> +{
>> +	int err;
>> +
>> +	if (!mmget_not_zero(mm))
>> +		return -EFAULT;
>> +
>> +	hmm_range->hmm_pfns = pfns;
>> +	while (true) {
>> +		mmap_read_lock(mm);
>> +		err = hmm_range_fault(hmm_range);
>> +		mmap_read_unlock(mm);
>> +
>> +		if (err == -EBUSY) {
>> +			if (time_after(jiffies, timeout))
>> +				break;
>> +
>> +			hmm_range->notifier_seq =
>> +				mmu_interval_read_begin(hmm_range->notifier);
>> +			continue;
>> +		}
>> +		break;
>> +	}
>> +	mmput(mm);
>> +
>> +	return err;
>> +}
>> +
>>   /**
>>    * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>>    * @gpusvm: Pointer to the GPU SVM structure
>> @@ -1503,28 +1547,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>   	if (!pfns)
>>   		return -ENOMEM;
>>   
>> -	if (!mmget_not_zero(mm)) {
>> -		err = -EFAULT;
>> -		goto err_free;
>> -	}
>> -
>> -	hmm_range.hmm_pfns = pfns;
>> -	while (true) {
>> -		mmap_read_lock(mm);
>> -		err = hmm_range_fault(&hmm_range);
>> -		mmap_read_unlock(mm);
>> -
>> -		if (err == -EBUSY) {
>> -			if (time_after(jiffies, timeout))
>> -				break;
>> -
>> -			hmm_range.notifier_seq =
>> -				mmu_interval_read_begin(notifier);
>> -			continue;
>> -		}
>> -		break;
>> -	}
>> -	mmput(mm);
>> +	err = drm_gpusvm_hmm_fault(gpusvm, mm, &hmm_range, pfns, timeout);
>>   	if (err)
>>   		goto err_free;
>>   
>> -- 
>> 2.34.1
>>

