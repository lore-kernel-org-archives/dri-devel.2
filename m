Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323C6F9936C
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE75710F0A1;
	Thu, 23 Apr 2026 11:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fDCC1W+h";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C435A10F0A1;
 Thu, 23 Apr 2026 11:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+8llv2P4m1VAHox3P41ezESbYVjzJJ4xErVWRPbUB7zq7GmNrlppIxzSacs0WM+IxAxsi7xgywioOJ9VLjV/nFY+zOfzltxZjzf2eCADQwLt0FQklw6Q4fep7dclF6bweKjFb8v0xwhDHRs6L+DMQtT26ydXmsA+b9P/E0/SyOPP0NjVok6ZpqR65Fz8qw7jpn0yPoOhbHvoi7OGjTAQk5AEij8/HRV5aH2McajxXb4Rz8MxD9SUFOVOZnDyIH96it6miknu0PXha4Vbn4wo9/zDHxRetiegPAfKm3CUcX9mr2RCLa2bk5DuHCM6ccx/teOX8/+pYLB5TjlgIvzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gry1/echDOCEWSeQrlQsxInr1ahSAn+D/Q7vZwfeNQ=;
 b=f+Vjww0ZaExpE6EzeyxUROdCfBurbZrheFGJiTZnJnrg3tEx9BzTpbkoUWIJfB6oRlYw1RxGJSLwHJWc5BJc4nkYBuinxEtTgUrD1Ud17KESlbbIkMjLQ30/OMVywUK5Slo+mk9JqplVbUejdFNgoopXIkUqPeTTX4kYicQNXISOmWQdsYU7zL9mUKW7ZnRh7zPeNuuwrP/dF6Qqif5+8jK1RcFfxI7UsjL65BgkVJUUNXay1tFV0komo5DamnzZJLLxiJTscbyb3XxOIE4mV7modyG43a+HpZgVpQyHh/RpvrVskHbP5a9glA0+Sml6krk9HVEhCxSaFpXV+hF14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gry1/echDOCEWSeQrlQsxInr1ahSAn+D/Q7vZwfeNQ=;
 b=fDCC1W+hLshD1TGA2QeNkmKQ4nHyh+J4fXNSLOG+uNCit7mGZwgfLUKsIzKisZg2RQkAmHjwV+q2uoi6gpTX1dMUmwVXwAyzStXNFJOJKcv/S55y7jn9WUQHqjo7qed3tDL1tCQa74sIaIxBac3rP+hDUyp0t0wd2d3cWorxpTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 11:04:03 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 11:04:03 +0000
Message-ID: <812102ac-906b-4fbf-bc8c-1881493a3eca@amd.com>
Date: Thu, 23 Apr 2026 19:03:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 00/12] POC SVM implementation in AMDGPU based on
 drm_gpusvm
To: Matthew Brost <matthew.brost@intel.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Honglei Huang <honglei1.huang@amd.com>, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>
References: <e21e8e1a-4d2e-40e9-bbb7-2764cf33e760@amd.com>
 <ae5fe946-4756-43b4-848f-3b545ac61ba7@amd.com>
 <abuE0KBPtAZM9Bo0@lstrano-desk.jf.intel.com>
 <098d5d68-f218-4cee-8b73-201e7012a287@amd.com>
 <acDeRhCTh/ehOUyu@lstrano-desk.jf.intel.com>
 <26186168-abff-4ce4-ad93-db9bc2fd68d7@amd.com> <acRgr7QwdULsn6G2@gsse-cloud1>
 <d2fddc5d-2628-47e3-95c5-874b3a0466be@amd.com>
 <5fb57768-35b9-4e48-8178-2e1760a93aed@amd.com>
 <aem++OfFRJqHAPTG@gsse-cloud1.jf.intel.com>
 <aenH0REel7/enRi+@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <aenH0REel7/enRi+@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0017.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::11) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: d00912d3-8e1c-48d8-3d4a-08dea1280794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6ViBGWQae/mKpZP4PD3D+5dCsk0ZLiEqDOdSehOQ6CTAzDdlwPCjnB1tQsJLbSpC4/I2/NZlt3KfAOWKRLKZwvpCkLt9YMPo+dlhVFgUF47Fe1aEk+xFOW8iUrqY4Pydrkj8ENv4sKrKfURLVszjB/P9Ot7xDpTcCbrFoJrbnF0KFt7ZecNrNB4Ik7Sw2eyZdggPGOIUIrWg69+ASpQXin4Yd/5KEv0KjkXXUvJTLWcoPLKkNc2/XIJRRgAWhdkZluiP6UlafaFOfBMPMy4z/fLJ17QIt1LTHYaRnL3Aba8yEApOUfNu2c2EXiciOBUgfMxQWiSwog/rcj2b6f9RQ8MOg1gPxVF976r0IhkF6eh6h2kpkROBXry9gHmFi0xJV0C8ax55dAeBIAz+u21sVavdQOFMw0HO2Opccw4hv4PTHmd5v4fX/GaPLSIJ/Hc+3QNtaP7c+oH8Cd+8dGrKnrxMrrjXN52cdVlGEX7gJR/i8gfrZhoTullzE9lrGmGP39QQXJAnZfRbkwmyqcKfA5QaIwIsBHGkGYZ+ifqzMI454Q2M4ND1vUE1FsplUq2aWbD3qBPGTxYCgYozYboc5VfIpxP9/fmCwdOFT/zWDhuG+XQ0A4+ustMLawuzAhwIfW9SyJ13QTv4RjHZ/MgC1eL9GeStzOmMm5wxHuyncKCdtcRl1LVN03qD8/T0JfDR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhoZVZYSGgreko1R2tDWUFuNzhnTzhaVGxIYktJTW10ZHNTUzV0YXVQNFB3?=
 =?utf-8?B?a3RiMjh3czZoSTNvREVZYWo0WDJGVVBKWmlTb3l0WE1mYXRtaC83c3BzMEIz?=
 =?utf-8?B?aE5aNkwySHd1SWlNSDlKYURCWUFrTzJ5Q3hkaExUaERmVWIxMlBVTDViTEE3?=
 =?utf-8?B?UW1DUVdBRnRrMXUvUVl1UmRuV3pGSGtqR0VjcUZoSW9Dc2NLRFNQRXpYYWgw?=
 =?utf-8?B?eW1kdTkxS3VCYW9xVE9mazBJeHFwTUhUdjNFdmcrbTZOd3NGZUJ3bzE2NWs1?=
 =?utf-8?B?T2tWSUh3YjRoWmNWMi9uNjdkcFI1ZjNtSGtUTzlWTkNyMU84YTY1S3dFeXBq?=
 =?utf-8?B?T0lvZUpOeEVxQURocEM1Yko5WGN4YlNUSm9uNldkZ3hHZ09IaGRobXFwdUZu?=
 =?utf-8?B?aCtjdlhxcm1wbGo2V1g3dG1oTGVxaWdnMWZhZmIrVjgrTStUNjYxYytxMnd0?=
 =?utf-8?B?MlNTY2I4ekkxa2JIRnJUYUk2eW5KVWx4bmtwZFhvaUN6VXRKUGxqT0h0cTJC?=
 =?utf-8?B?RWNXb08xaGVpUzhyN2Rrb2trZlBDdWVhbXlGdldta0F1WkNOZlVOZGhrUXRp?=
 =?utf-8?B?N2d5NklLY2RhUTJkc3ZTWE8rbEVCc0xobWtyZ21hRzZQZVJKZzQ5ZkJvRXZP?=
 =?utf-8?B?RWhNSmt5WUFuQVhGMEd4Sm9IMm0rbXgycVZhdkxmZk1KNGp1b1JQYklEQ0xo?=
 =?utf-8?B?eFArZnkvamFLOHhTTjlLcE1pRlUzd2xoK2MrTFV5TytaZ1E0OW5LM3Z3V0hW?=
 =?utf-8?B?SVJyRkcvK3cxaERKZHh1V0hHZCtRb2crRFFTVThvMjB6cG9vWFdhejhsb3RR?=
 =?utf-8?B?bEovRXR5dC9LWi9qcTN5eUFFdlNNZktWc2FTcGZ2NUYvdTRiNUtvczJWZzJt?=
 =?utf-8?B?TnFTUUpkNXpQcnM3YWx1cmJ2T3ByVG1yODAyWC9qckFVUkoxNXdvOUZTd2dI?=
 =?utf-8?B?WGRQRkIxa2xlUTM5UTQ3UlJxWGEyTk53ai9SM01ROXNKcUFTbVJ6WTZtRTNP?=
 =?utf-8?B?cmZMa3FFcklXSXBaWU9jdzhYQ3lVcmNyUXF4U0xhdGIvV1o4bUMwSC9tdDMz?=
 =?utf-8?B?UEIyMlFyTjNIU3FLQWJSVFdQOFA5R2h5UFFVQlc0NlMrUnl2UVZ3U3VSVjI5?=
 =?utf-8?B?VDUwL0FxTGhtMGN3ZG5rU3UwNkVJUnlYVW9KZ0o5L0h3UXg1TnBPblp6bE1Q?=
 =?utf-8?B?RHBNYm1MeWorS1diNENia0thcTV0MmhDcUd4czQvUXM3U3RlSGsxR1NtQzBh?=
 =?utf-8?B?UVV1aUpjSVdROVlva0M1dmlZdEx2dXM4TmhjQ2RkejVPa0FNWjdKZllDWExt?=
 =?utf-8?B?REVNOVltTVBzekJXNTFScHRCbzluWUphelVCNlN6djk0dXBHQnBMT3FHN3VK?=
 =?utf-8?B?ZXErb042L3V2M1kzc3ROUGNUdC81QXNPRjU0Z3lOZDd6SlNXVFJKNDJqdWE4?=
 =?utf-8?B?ZGVIM3Eyc1JkR3RHQTZGYTVCNHFra2c3WHNCcWtJT1VmUDkxNGE5SXBVRkE0?=
 =?utf-8?B?cWZyQ3piaGx5VWp0bkU3WnVvT0pmL3BRUEhQWUhWNDFncEIyaUdzUHBiSzhL?=
 =?utf-8?B?Mkd2OXF3Q3FPRG5mVGZkUVhFcERWMUhGb09Xa3VFeFhpY2ZBMW5YakxMSDZG?=
 =?utf-8?B?ZjFLRWZnbXN0UkxDTkFqblo2SEJtZlpxRFZST05oSEN2b0dFdi92QkhaSEVL?=
 =?utf-8?B?azlwSEVQNnJ3RzVuMWF6KzBNWUxZZk9pZ2NFY1B1aVVPa1AwdVI0cEFqUWQ3?=
 =?utf-8?B?WjZIU1hncmdvbUxQRDVDT1liOEhmdS9GdFVXaHFxa0x5OWppTTMvZXlQaHZs?=
 =?utf-8?B?WFpWMHpKbnl6dFAzVGw0MWJxL1pVczNodDlERk8vVFJ4QnZFM1JVRi9yRUJW?=
 =?utf-8?B?UWlsVFludlVWSG1aVlN0Z0EzVmtFdVozTmFFa1RUaTdla215dDRtNXlpU2xT?=
 =?utf-8?B?UjgvdFM1QTYyVW90RUlaMW9tQTY3OGZLVUZwQVJSK0MrdDNrc1EvbE5YL0Uz?=
 =?utf-8?B?RFJ4UFBXcWhoRWFPeUVkK3dTWlo2ZC9vMEVYc1RUcE95WmVvMUlZQUcvWFlV?=
 =?utf-8?B?RlN1QU5uK2sydnlrVjhaOVBKekZnWGRWMlNOckozb2QvTDRIMjFXdzlOUUtC?=
 =?utf-8?B?ek14eU5wZXkzZ01Fdjg2Z2tKZzVOTkdjUlJlcFlPMVA3eWNvRnZqZ3JuKzdt?=
 =?utf-8?B?QjEyTTAzMVdCT252UmdORHBHd296aEhFaUFCdEZ6OVBNbGtWL0V1SEZzd05a?=
 =?utf-8?B?QnYreE54akJaVVZjMHhSbEhYUFYxQ3c1UWk4NVc1WHdiaGNlS0xxRWd1OXBG?=
 =?utf-8?Q?gJUiHCEInfaH2pSyRO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00912d3-8e1c-48d8-3d4a-08dea1280794
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:04:03.4403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7TsOPpl0QYPE72x2IkRFMpAv23QsYRkabhmHeTEOZWQkOT/E51FsTDMSvvenB0Q6mOg25A1vV58yR/NOT07Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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



On 4/23/2026 3:18 PM, Matthew Brost wrote:
...
>>>>>>> This clarifies a lot. This is what we’d call in Xe “preemption fence”
>>>>>>> mode for a VM. Anytime memory is moved, we trigger a GPU preemption and
>>>>>>> resume. We don’t actually support SVM in this case; instead, we use
>>>>>>> “userptr binds,” which are built on gpusvm for page
>>>>>>> collection. However,
>>>>>>> we don’t support migrating memory to the device—though we could.
>>>>>>>
>>>>>>> I’d look at how we converted 'userptr' to be based on GPU SVM [2]. In
>>>>>>> this case, don’t maintain a range tree, as those—as you
>>>>>>> suggest—are more
>>>>>>> of an on-demand fault driver concern. Instead, just embed 'struct
>>>>>>> drm_gpusvm_pages' in the VMA struct defined by the IOCTLs..
>>>>>>>
>>>>>>> We could extend this to support migrating 'userptr', but we
>>>>>>> just haven’t
>>>>>>> done that yet—this may be what you want to do in “XNACK off..
>>>>>>>
>>>>>>> [2] https://patchwork.freedesktop.org/series/146553/
>>>>>>>
>>>>>>
>>>>>> Actually we need to swith the xnack mode between on and off, so
>>>>>> in xnack off
>>>>>> mode, the driver operats in "implicit  prefetch mode". This may
>>>>>> be due to
>>>>>> compatibility with older hardware and the need for UMD runtime. We will
>>>>>> further discuss the handling method under xnack off internally.
>>>>>>
>>>
>>> Hi Matt,
>>>
>>> I studied the xe_userptr code and the conversion series [2] you
>>> pointed to.
>>>
>>> I have a question that:
>>> Would it be possible to reuse drm_gpusvm_range to handle the hardware
>>> without gpu fault feature(xnack off mode).
>>
>> That’s not how we’ve done it. We embedded drm_gpusvm_pages into our VMA
>> structure and then attached a notifier. The notifier attachment is
>> open-coded on the Xe side, and this could be normalized and opened up
>> for common driver use cases.

The way in xe_userptr likes the implementation in kfd_svm: embeded 
physical pages into structure and attach same size notifier.
But kfd_svm is an implementation of SVM semantics, which supports 
partial unmap, doesn't need explicitly delete userptr ioctl calling when 
remove , and doesn't need a explicitly userptr flag when creating.
And actually there is also a existing implementation for userptr 
semantics in amdgpu kfd: KFD_IOC_ALLOC_MEM_FLAGS_USERPTR.
If the no gpu fault mode can not use the drm gpu svm fram work, use the 
same way for xe_userptr, it seems like doing the duplicate work.

I think the core gap is we are trying to use the drmgpu_svm to implement 
a SVM semantics driver for no gpu fault hardware instead of userptr 
semantics.

>>
>> The problem with reusing drm_gpusvm_range directly is that a VMA may
>> span multiple gpusvm notifiers—i.e., it can be larger than the notifier
>> size. Of course, we could rework this as well.

So the "VMA spans multiple gpusvm notifiers" concern: I'd like to 
clarify that this is not actually a blocker for amdgpu's XNACK-off path, 
because amdgpu does not try to represent one user ioctl virtual address 
interval as a single drm_gpusvm_range.

we walk the attr interval and call drm_gpusvm_range_find_or_insert() 
repeatedly, letting gpusvm pick chunk aligned ranges bounded by 
notifier_size. One ioctl interval will create N chunk sized ranges.

>>
> 
> Sorry for the double reply—I just glanced at the latest series. I don’t
> think creating a range per page of the userptr is desirable. While it
> would work, from a time-complexity point of view I don’t think this is
> ideal.
> 
> The issue with spans across multiple notifiers is real, though.
> 
> My rough idea would be:
> 
> - Give drivers an interface to create larger ranges.

So maybe we do not need to create larger ranges if we call 
drm_gpusvm_range_find_or_insert() repeatedly.

> 
> - If the range fits inside a single notifier’s size → done.
> 
> - If the range spans multiple notifier sizes → round up to a power of
>    two and create a larger notifier. This may overlap with existing
>    notifiers, which is likely fine given that interval trees support
>    overlaps (?). We’d need to double-check and test this. If overlapping
>    notifiers are not acceptable, we’d need some heavy-handed notifier merge
>    logic—it will be complicated, but isolated, so once we get it right
>    everyone can use it.

If we call drm_gpusvm_range_find_or_insert() repeatedly the drmgpu_svm 
will create the corresponding notifier correctly as far as I can see.

Regards,
Honglei

> 
> - Finally, make sure that individual userptr pages can reside at any
>    location.
> 
> Over conversely:
> 
> - Normalize embedding of drm_gpusvm_pages in VMA structs + notifier
>    creation
> 
> - Make sure that individual userptr pages can reside at any location.

> 
> Both options actually sound really similar after typing this out.
> 
> Matt
> 
>> So either way, the Xe userptr + gpusvm implementation should be refined
>> further for common driver use.
>>
>>>
>>> Reusing drm_gpusvm_range for the XNACK-off case would simplify our
>>> implementation considerably, it already provides large page chunk
>>> optimization, can reuse the existing migration infrastructure.
>>>
>>> Building these on top of a standalone drm_gpusvm_pages
>>> would mean reimplementing much of what the range layer already offers.
>>> It would also let us keep a single code path for both XNACK modes,
>>> which reduces maintenance burden and avoids behavioral difference.
>>>
>>> Would this direction be acceptable, or do you see concerns with reusing
>>> the range infrastructure for the no-fault case?
>>>
>>
>> If you prefer something like insert a range exactly here + create range
>> + notifier I think that completely reasonable direction and Xe would
>> likely switch over to using this.
>>
>> I guess my only concern is sub-userptr migration. We are trending
>> towards allowing userptrs to being migrated either via prefetch IOCTLs
>> or access counters on the GPU side - access counter we'd likely a single
>> 2M page at time migration within the userptr. get_pages() supports mixed
>> mappings between VRAM + system but likely needs some more work to really
>> make this complete though.
>>
>> Matt
>>   
>>> Regards,
>>> Honglei
...


