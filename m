Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1F7C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B4E10EC17;
	Tue,  1 Sep 2026 09:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0KtyIYl";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7786A10E3D3;
 Tue,  1 Sep 2026 09:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHNEhRJadN2ZJv9g9m23NTAMQThne0dL3ue8bnaToL0pz8JNtbAbuKjhEAZeD8S0RZxDayXL8eQLR/DU0W6TV0aBdlMLNDYA5S1C27E1QkHP878gedwRGrluuc9YdLXWDyvDn3lbBzCc4ead3wFwhCDAa7zdaUVv7n3rrJZQKF/ZWubwGBRFURTer4ZUCrTl4KksCgVG+fKVvyxoY78ibNkCnsZcff5KLzTwCLDUJULNqRzGnH+7oosmXKahbbQSVXUFr5RqWsxi4tk6BP9HARqmKXU6zVcmGALoaz5Hqk/mBnFiQQlNshpba3TuBo8i0+yreLSu1t7n8WTo9URXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzDqacOjZT5ogzefo6Pashan+ZUiGiUtf4tuZyRw+rs=;
 b=wObmYj6CxCtt8VRtm7JuYsVxaYYwkoYq93JiOthUmvYvcK81y/HEebFFOjZkT8+f1gdi+pki4DneyLQnRAtCihwyuzfE2OTMC6BLslTHI2xsxIcZD/Gjj9kFoYFFFjFd68M222rOXmKDsdxRS5SINL7GhNxmFLBMbsvxDV0b2lENTE5Xvtx6M9pUzLcxPwfmwxTcFGJmXoT4CqtvS9OXqc5Dvyc6G8irYBFJegta02fSmOCre43uAW5PIho4XxC2C+s2PSg66b2RUuEuJS6vylqYYspmm9N53VO73WNa1WZQw9Bq37+771MS0zav9L9Qe3Y5aFh2gidbyVzhH0JQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzDqacOjZT5ogzefo6Pashan+ZUiGiUtf4tuZyRw+rs=;
 b=F0KtyIYlCkbJLGUzvh4jp1565AqQMVqUbGXLFNrWj5JkGLKBgiXXx6nC8cSyZnhyEa+22nIV4ryj73aQcY/NNGqEIzzWmlGCmwWP3EhTZKiJQsRYLtqdidwaXI6Mmk4+duM35tL6vMPncjo95e6TZnfGk5ps8DbX3Yu4llamlBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Tue, 1 Sep 2026
 09:15:49 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:15:43 +0000
Message-ID: <34d703fa-399b-48f7-b632-792cae21ed8b@amd.com>
Date: Tue, 1 Sep 2026 17:15:36 +0800
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
 <bcdc465f-2f83-4fc0-93e6-ed94b076989c@amd.com>
 <apYpDwBsczVHXGik@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <apYpDwBsczVHXGik@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::17) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4bc488-0fcd-4de5-c8a7-08df080999bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|13003099007|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2vaaT1MKMBbaEGdW7UH2MrbXyW1AAA9Wi4pxKU24Ect2zMS/sUEISzullzMFiZ0oz+L7r/38VekqNrtin9X2eOqkYuMzuE2BGOGfMnHQSAdZZVLuHM/uM85IJ6VYcMb0TKRCE/sktV7aZQK/+Rtcm8ivp0gKoBt1Bd4eAsCStbG7VR3SH3AVW2gCbjIoOxSro1oOUqcBO6ezdW+/9Tll14TWttdfrpdnnctaQ0FHGzSfNkno90mzETpboXS4pyJkdklrDxAjtDhAf5J3pjFrUqjJdgsSnbe3u6aoXbdOlGu8DJIO+jN6V9jReHXUgYIW/pVNiNiUbZTkmL8UgolN+CpSiL74J2xTpb6lozGHArIeYTwPYDIKF3iJ30BCyR5cQ63n99TjGvsz+AD3Hq6G+ubqijUFcPfyHWPdQjjLzBuQPRcRAyU3WJnKkDt92D3pRxqwX9P0G423yR7TN43GYbZy6bcEjB4H2kBVpFTfdh+x1QYyq41FUs8MUYsMW61TmV/pi/qWxlp1J2LKaYvMltsYJ2IqU+gTft/5Wt3wkNU/6n2V47pafpw/BWbqSJx4ItlTNsWYDbCfOCm/dT5Sd6puChjlgQyzA2Tr7hHJIMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(13003099007)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b05kalJSMVBYeTA0dlhSeFlwSzYzdzR1Z3dzT1EvVCtubGVPMkFZRnUvRFFP?=
 =?utf-8?B?K2FqWnBTV1hkK3RzaGRhRVNqaEJQczl2a21Hc3c2dmJoZFJiZnVpVzNuY2VU?=
 =?utf-8?B?UVBCdURMN0VSWmowSktsZUZjM0prL2NJck8raURwcStwS29oU0x5ZnNYUGpS?=
 =?utf-8?B?VXNCRkE5Rk5ESzAzZmRaQ2RuNkcwNXdnWldsWGlWWGVpYWRNVXVYR04vU2xX?=
 =?utf-8?B?S1kzb0tCMU5CY2tWMUlDWXJqZ3FGSGdWSUtabmpNTjJyWnlZMjNZSldVR2U5?=
 =?utf-8?B?dG1yVWVrU0V6MUdqVHNPczVyaERvVzJqOURKdlV0NWdjeW1ZWTJ1dDBVWHdT?=
 =?utf-8?B?OUkwbEQzVUZqUUpUVUtmekZVNjdZRE9SQi9DR2F1UkdzbVVpZ3pMdEtyS1BU?=
 =?utf-8?B?OTQxTm5vV0VYR2JpK1Y4K3N1NzlQNUVFNjAwcEEwRHZycEZvOW5VYjBtWDQ5?=
 =?utf-8?B?RW54aEtVd240ZWw2WFR6R1ZiWXl1ZE5KSk5ITlAxZkcyM3VMakdyQkhJdE9S?=
 =?utf-8?B?SUJiV0VIQ085V0xxVy9GdHhLYTg4L2pvWEx0OW5YY0REaE9mNUVtOVp6M1A3?=
 =?utf-8?B?eEJSNXhXMkdBTTU0NmJqdi9nSGI4UFN6ak42NzlYME1yYTUyMmFjYjlhMFRz?=
 =?utf-8?B?UHl6Z1BRa29Xd2NvVklndks0akk5Zmg2dnpSQTFTTFhoaWViclphekNsSUtQ?=
 =?utf-8?B?N2JVMmJreXBXZVBRMmdMclFWSWFJVkd0RlNWb20vOXI0WlBVamhQaldQUzRI?=
 =?utf-8?B?aExkYkhZa2F5dmNyRysycmxlNk0yMVhIelhpMzQ0bzJtSy81Vi8xVnRNY1JW?=
 =?utf-8?B?dWxYMWs3M0RDQWJyWFBObU1NU1gxK1VLbWhLRE9GYXlDNFd2K2JCVTVNWTl2?=
 =?utf-8?B?cktiams1RE5MY05BdDJDM2prV3g0WnI0cXlmdVBEM214b0daVFFBVGVBT3A5?=
 =?utf-8?B?VzJKNkVaQ2R6YlFoV0dxRE5oelhDOVpibzRieGNtTzBpMXI1dXl4SU1wMmZO?=
 =?utf-8?B?ZTU0WHVGYWFnTDh4TkZiQUpwN3k0YXNwQkROdUV5MFRtKzAwN0ZEVGFNN1E2?=
 =?utf-8?B?MkxxWFJJMDNnRXlkeDBrT1pXeDU2RnlxS0ZYRkpxVVllNWR2Z00zT2tvS3lC?=
 =?utf-8?B?WkFXbWdVanhZWWZzN2pFYW1RS0MwcmdqNmwzdjJUQnZ4Mkk2Qkl1bXk2cmlT?=
 =?utf-8?B?S3Jlb1JVM2tYdnNkRWZLYUNaQndsTnZMYW5VRjhTblh2ZDdNQmhucVA0T01E?=
 =?utf-8?B?Sk1QZTE1b1dkbjgyNWZpckFoYUY5NFRIWDZvZzIzVWY3a0JhM095WHlGcitn?=
 =?utf-8?B?SGp6YWlVTHJIV21vckZyQnJYOW9aV0Zvb2VxQlNINEZpa0FvY0VHMVNEckRP?=
 =?utf-8?B?d3VBeEZiNmY1TG5CSzR3blJIUWMxRzc4bzR0MitRMG9vQXM1UkN4VTF6d3VG?=
 =?utf-8?B?Qlhnakc4bzFaaWU5aVVoR1NYNDl6U2dvVG9JMk9ENC9sOUR0VVluQTQ0Lzdj?=
 =?utf-8?B?OUtVRjdVUjJQOTlhT2prTVl4U0F3UmVDNVdKWjlnNnBxbEUxa1ppS3R1Snpu?=
 =?utf-8?B?UytweXJCNllrZTJEdEVabDIxNTBHdmFsQkt0cklIbDVFRzlSWjJtcTB3UGRL?=
 =?utf-8?B?VTdIVUdQVWV0Z3BVejh0ZGdkSGd2OFNoSnRERTR3SUNsbEgvaTZsRENJYnlQ?=
 =?utf-8?B?VUd2eGFuZUNHbE9aS1pPK0c4eVE1QnV0dGRjYVkxRExxdUU2bkIrckwxdDZW?=
 =?utf-8?B?N2hQdXJzb09YZ3JBS2xBL2lkMDhnVENHK25BQis3UkR4a2UxSGxXcEZiUXZ2?=
 =?utf-8?B?RTEwSkh6OC94Vk0xb1RuNllwcytaVWRiUGhRUkNZRXIyUDlqTTFUenJUK3ZC?=
 =?utf-8?B?bnBwa3lTNGwwaWFMMFVMYTVUbjRtQXRhY2pGc1VWWmoySUR0dlRoQkQrTHZ5?=
 =?utf-8?B?TU5sd3NrUysvb0FWcVhabVYvWnk1WDlhSzg1MVF2aXY3TkNkTGE2WEQxLzls?=
 =?utf-8?B?ZFhaOHZPQkhkNjdMd0xQTU5SRkxLQnUzWHlkVTVUTkkrV0lRMHoyKzAvODlT?=
 =?utf-8?B?MnNUL1d3dXJKRlRGVWJjb0tobjhlSHgvY1U1RVRpRHFnTXhmMnVxZkF6YkVP?=
 =?utf-8?B?Vi9ESWhUanNzbjZMa0xKVDRaQ0RuRm1SbFVldTVVOXErMVpqMmJ4QkltdVZ6?=
 =?utf-8?B?T08xSFc3cUdKOXVnQmhOTnFNWUdmM3ZXczJKV0FJM1NtQ2hoaHBjUHBiMEl5?=
 =?utf-8?B?enhrelUwRVBhWDB5M2xjb2dkN3V3a3M1dXlmcHJBVzFnaGJUc2tXbnhGNkdV?=
 =?utf-8?B?MzRHdHZiYVFPSW0zZUljQ2NmOTEzUzFST0ZXNW8wRkJsS1JwTkp0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4bc488-0fcd-4de5-c8a7-08df080999bf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:15:43.8889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXv14GzgkA5mIE2RyRmgalTpfGDs1rBtH0GDcGIqs03T/ZhywdHDU7KJKWUmeUtKuvG3+wOL+KyHNSG4W+7D3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
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



On 9/1/2026 9:23 AM, Matthew Brost wrote:
> On Thu, Aug 27, 2026 at 05:02:43PM +0800, Huang, Honglei wrote:
>>
>>
>> On 8/27/2026 3:30 PM, Matthew Brost wrote:
>>> On Thu, Aug 27, 2026 at 03:14:45PM +0800, Honglei Huang wrote:
>>>> Make the HMM fault step of drm_gpusvm_get_pages(), including its -EBUSY
>>>> retry loop, into a helper drm_gpusvm_hmm_fault(). The existing logic of
>>>> the public drm_gpusvm_get_pages() is not changed, only relocated, so
>>>> there is no functional change. Keeping the retry loop in common code
>>>> also means drivers never have to open-code their own fault/retry loop.
>>>>
>>>> A single fault can later be shared by several drm_gpusvm_pages instances
>>>> that mirror the same CPU range. This prepares get_pages() to split the
>>>> shared MM-level fault from the per-device DMA mapping. No functional
>>>> change intended.
>>>>
>>>
>>> I think you might want to just wait on this until Sunday for this
>>> series. I think this patch [1] is in the core MM tree so when drm-tip
>>> moves to 7.3.rc1, Sunday, we will have a version of this helper to core
>>> MM used in gpusvm.
>>
>> Got it, will wait until Sunday. Thanks for the information.
>>
> 
> It looks like the core MM helpers have landed in drm-tip [2] but not
> gpusvm bits.
> 
> If it isn't too much trouble can you pull in version of [3] at the base
> of this series, credit Stanislav as the author, and then rebase this
> series on top?
> 
> We can then merge all of this together into drm-tip.

Not any trouble at all. And it seems like [3] has already merged in 
latest drm-tip.

So I just rebased this series on top of drm-tip. Happy
to help if there are some other rebase works, just let me know,
will do it ASAP.

And this series has been rebased  and sent out, rebase and test took
some times, sorry about that.

And I have a question about the XE CI, I always get a warning:

Warning: Your patch series was applied on top of the 
307e9559fc1b95a477f00a767ea053b78d263548 kernel commit

Actually I can not find this commit anywhere in drm-tip
or xe-next, it is very helpful if you can let me know how to get the CI
code apply base line.

Regards,
Honglei


> 
> Matt
> 
> [2] 121170831228 mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
> [3] https://lore.freedesktop.org/nouveau/20260722-hmm-v10-v1-6-606464dd601a@gmail.com/T/#m68f663ce3e802d7692363c70e6364569134cd6c7
> 
>> Regards,
>> Honglei
>>
>>>
>>> Matt
>>>
>>> [1] https://lore.freedesktop.org/nouveau/20260722-hmm-v10-v1-6-606464dd601a@gmail.com/T/#m68f663ce3e802d7692363c70e6364569134cd6c7
>>>
>>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_gpusvm.c | 67 ++++++++++++++++++++++++------------
>>>>    1 file changed, 45 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
>>>> index fcfe635bc195..507ef6f0a60e 100644
>>>> --- a/drivers/gpu/drm/drm_gpusvm.c
>>>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>>>> @@ -1442,6 +1442,50 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>>>>    	return pages_valid;
>>>>    }
>>>> +/**
>>>> + * drm_gpusvm_hmm_fault() - Run the shared HMM fault for a CPU range
>>>> + * @gpusvm: Pointer to the GPU SVM structure
>>>> + * @mm: The mm corresponding to the CPU range
>>>> + * @hmm_range: The hmm_range to fault.
>>>> + * @pfns: The pfn array to populate (size @npages)
>>>> + * @timeout: jiffies deadline for the -EBUSY retry loop
>>>> + *
>>>> + * Fault the CPU pages of the range into @pfns. This is the MM level step.
>>>> + *
>>>> + * Return: 0 on success, negative error code on failure.
>>>> + */
>>>> +static int drm_gpusvm_hmm_fault(struct drm_gpusvm *gpusvm,
>>>> +				struct mm_struct *mm,
>>>> +				struct hmm_range *hmm_range,
>>>> +				unsigned long *pfns,
>>>> +				unsigned long timeout)
>>>> +{
>>>> +	int err;
>>>> +
>>>> +	if (!mmget_not_zero(mm))
>>>> +		return -EFAULT;
>>>> +
>>>> +	hmm_range->hmm_pfns = pfns;
>>>> +	while (true) {
>>>> +		mmap_read_lock(mm);
>>>> +		err = hmm_range_fault(hmm_range);
>>>> +		mmap_read_unlock(mm);
>>>> +
>>>> +		if (err == -EBUSY) {
>>>> +			if (time_after(jiffies, timeout))
>>>> +				break;
>>>> +
>>>> +			hmm_range->notifier_seq =
>>>> +				mmu_interval_read_begin(hmm_range->notifier);
>>>> +			continue;
>>>> +		}
>>>> +		break;
>>>> +	}
>>>> +	mmput(mm);
>>>> +
>>>> +	return err;
>>>> +}
>>>> +
>>>>    /**
>>>>     * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
>>>>     * @gpusvm: Pointer to the GPU SVM structure
>>>> @@ -1503,28 +1547,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>>>    	if (!pfns)
>>>>    		return -ENOMEM;
>>>> -	if (!mmget_not_zero(mm)) {
>>>> -		err = -EFAULT;
>>>> -		goto err_free;
>>>> -	}
>>>> -
>>>> -	hmm_range.hmm_pfns = pfns;
>>>> -	while (true) {
>>>> -		mmap_read_lock(mm);
>>>> -		err = hmm_range_fault(&hmm_range);
>>>> -		mmap_read_unlock(mm);
>>>> -
>>>> -		if (err == -EBUSY) {
>>>> -			if (time_after(jiffies, timeout))
>>>> -				break;
>>>> -
>>>> -			hmm_range.notifier_seq =
>>>> -				mmu_interval_read_begin(notifier);
>>>> -			continue;
>>>> -		}
>>>> -		break;
>>>> -	}
>>>> -	mmput(mm);
>>>> +	err = drm_gpusvm_hmm_fault(gpusvm, mm, &hmm_range, pfns, timeout);
>>>>    	if (err)
>>>>    		goto err_free;
>>>> -- 
>>>> 2.34.1
>>>>
>>

