Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE893CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B69A10F431;
	Fri, 26 Jun 2026 09:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RW23D/nJ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F083510F3E1;
 Fri, 26 Jun 2026 09:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSvrRO5Qs38NlJADCVepeG4oca3pWFQ7/gObQmqR2Z/+Rs+DirN6GDChYx3cBKG14g1Ck80bcdCN08mpwM1vq2pvcsk6ml2hsbsJuL7TD7mDzknSn5RO+tA1uQRwhunGF6sRBL9ZdWAcnDy/JOMnTCNW5xNy1tV449PuDd/LjjEX1FBcf0qxx4KEfTZQoQwQj6jblLavEeSilPFrPZo9Yxy6bpl4Wzx9/RC3lVyyi1kOvgXtsE2st0EuYAdLb19GBUvKErJDdCOlALXT0Jl/poEbdcWEN9uiZNI8eEdisAb0Ar2fuitsR8gamQG08iU8V4gFIJJa5mdD2G8awzZn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNg/43D7ez9d0qIlS8YY54ACPK+I3iYiMnYvNefBFYU=;
 b=YPqbpMqEU/3d49564eiwXLPFAPmKgcwAy+xXstzBLZkw5Fc062z6Lh3RSaSwuzRvYDenHyMy2SSF3+qZtCwhCPPBgkowLI4AKgCzfdJTbF1vkIaa/V1QTHgtoXpZM1gV4KOZIwSJcl/VwLJG2v6+qnPTrF/McHJz/Iw05CWProTtMYMe9oCEQ3Nu56A/LXZVvTMyn5dYTPCdv1U2S6YpLTqSPxxXa+GX3id6tBYWR7U4h4Wp7wZHJdHPpY0KtrF9moyTyofdqrlcALMRCa56h5cStR7ooKCLVNdyNCFyVl5YMGd0Po/PKWvkW28febKZzuUEWZfn2XnecMMzu+jwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNg/43D7ez9d0qIlS8YY54ACPK+I3iYiMnYvNefBFYU=;
 b=RW23D/nJ20dtYvrTfRzTPOrzu49crm26MmSC3a6ck8LVmgh2HRHMFoW2QQ/e3F5+y1lxhVU+nOCTmfugTDELEcm7qLwnEAFmVQd9BohS6w71eP3KL0r5gafl12tDaTjaO44UiQmp46T+mD4ZuN+x2Ithgu95wOO+sMAfaXuWOfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Fri, 26 Jun
 2026 09:02:46 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:02:45 +0000
Message-ID: <576d2330-8178-4f04-b81d-c340cfb6a8df@amd.com>
Date: Fri, 26 Jun 2026 17:02:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] drm/gpusvm: split MM and device state across
 gpusvm/range/pages
To: Matthew Brost <matthew.brost@intel.com>
Cc: sima@ffwll.ch, rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
 dakr@kernel.org, aliceryhl@google.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Christian.Koenig@amd.com, Oak.Zeng@amd.com,
 Jenny-Jing.Liu@amd.com, Philip.Yang@amd.com, Xiaogang.Chen@amd.com,
 Ray.Huang@amd.com, Lingshan.Zhu@amd.com, Junhua.Shen@amd.com,
 Yiru.Ma@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <aj44TkLKQIqrY9S9@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <aj44TkLKQIqrY9S9@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f17368-cb67-4932-754c-08ded361b028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|22122799003|1800799024|376014|366016|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h2TPUD7dBq6CNk57BT03OLLUOHQkODM0Vdoko3VjLb8iorhD/pq/axsQkUoP0toQJS4g8ueAsi1Foj8xWLUdnTi4SykAUPgWVt+Yn/QFJOrMNK8UKKO9AHrsEP5/svtdBRZ/532zBx7BSgZY+SbSXG6T1TFHTweJ93vttwNrGNdJahwMTuV0RAom0uZQi467GLI1ZEyLzddpNFiJRbUTgXsUUxepoTMyaSqX6MvWqp7ZEwvoj/hzpV8IHyp/mSEP0ezJoWxynAMgTHqFgdCNHPgagqraoocCQWEOeYiAtaMqkSgwKBJqkpDqM+s/LgzYvhHjn5/1/fecT8mqU/mbmM0+mTJebU7f9Zq7UCQCK4n4jRY3WMi5/1grVb3wvSlfZW1LOBYZ9vbke40SomJoprOF+DYik77lipZEgpNSoyMfcgFVHwajeI591Vn/413rKdXUXnBw6X958ys7skGfkqJ9d254rLMGaXYNrws8YVwrc7bmRpj8myu5ZPJzGfFUGo83GTjwE2Kl30xxcZaV0gECHBh8q6ajTXzkL6wqVsjJf+zmsOOcljtiSPor/P7XNAvROuHRVbHx89NvgZZAy1ojWPrg7vH6t38tiOCDsybwb1+c0aEmZVZc6zMYxsPp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(22122799003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHdHSXhxZWQ0YmRDMDZjTFZLcXVBVDNBOWFuOXpUK1VjdzV2L0ZvT2YxQ1N0?=
 =?utf-8?B?RU5zdXlXRXN3OW81bS9ZSjNFMlkyMG5lTU55S2hick9yM0I4WU5aejhqSkZk?=
 =?utf-8?B?Ri9NMVVpTWR4OHRvRzltaC9PZk1LU0VONHNqd1I5alEzaFMvK0Nrb0pwTkNV?=
 =?utf-8?B?SXUwL1VrTXRMNHJMVGVFMVYrUktQSS9XdVU5QUhGSEphU3Bmd1kzWnRLVFdF?=
 =?utf-8?B?UEp0bTJlZThTSUJJTjNMNFBsUTZBSmJKeVVEc3NEVzVab0hUTTVsQXh4eDE5?=
 =?utf-8?B?Q3pjTDdiNU1JOGdsZWh6OGFqdjZMZG1weHdZemNaODU4cm4wUWpyMkRVS2J4?=
 =?utf-8?B?MTE2a01wWnh3S3l1V0d3bTV3eVRJa0RDZUJBcHJZV0V2VFkrWmpSQ0QzdkVJ?=
 =?utf-8?B?QUVnSzFSWERDVHpwRUdqQk93L0tiQURhelVzaUpqc1dBWE9HSEQ5UVNTSEdW?=
 =?utf-8?B?SHBHb1lPaTZZWnZOOVlhVS9KWCtzZVRUNllwdUdGNzNKV0ZiSStIbWsvamc4?=
 =?utf-8?B?emNLNjlkTW5BVit4UXBScldRQzRmbnNuRHhaTjY0d3RCZERJNWN6RGlTbW5M?=
 =?utf-8?B?VlQzdWZQMDdwNjJ2cUEvLzZXQVNUMmpBTWNLaVVCMXk4TEhRdklsSS8vdkpT?=
 =?utf-8?B?Lzh3UVBZZnl3REd4NldGWVRZMW1FNVFYTHk0TmJNeE5ub2xlUTdENjdoVVRp?=
 =?utf-8?B?VHc4VDAwRitCSllUMHYvTCsxZnJwR3V1T1VneVdWQ3k0VncvVmhyZXM3UFE0?=
 =?utf-8?B?cHdnOFJpNGN5WjdPNVdkazkyNzBFWEtUMlo3azB6T2ZIeG94cWE1b2dmOFRw?=
 =?utf-8?B?ZGw0VDdZRUcrMnZOTGUvZzNzeVMzQ0FsTnBoTUxNMi9KTU4xUmZLb2Q0dTBW?=
 =?utf-8?B?eWFNTzV6dkhVa2kxRmIweXhhNlM1OFBlZm9pU2ZjdE9QekxXMlNycGFCK0JF?=
 =?utf-8?B?anpuNkc0SXVLL2ViTFBvby92enJ1OGVybEQ0U1NHOThZKzRTVnpXZXpSeFF5?=
 =?utf-8?B?Zng3UDBkb1g0OTFvR2FTam1ET2E5TGI3QmdiakMxSUxvOVd5YVU4Q3lvak93?=
 =?utf-8?B?a1BCU0pBdVZCV28wSDlzV0wyZTRqNmhJVFcweGNvZnNNdWJoa2N4Z2NPN2hE?=
 =?utf-8?B?dVMwV3B2eURCa0s0QzQ3RHBFamVDY0VPWDFqcWxCdDVwOEFwNlJZdGFmR2h0?=
 =?utf-8?B?R1VUamVER2k1TytRTGdLMVlia2FUZ09zOWk2QXFmMy9BR1hZZU1DZHpVOWJs?=
 =?utf-8?B?QWZPSDlnS1lxdGo1TzJRVkt5L1l4TTVlZE4wYXd1dGZtL01SdVozT0JCN2k4?=
 =?utf-8?B?eCtTNXh3SkY1S1dpcEErYUtiZHBaU1NsNlJaVCtWUjh1Zys0ZzlLS0hmVUd2?=
 =?utf-8?B?ODBhSUFkTUVhSTBjYmt4K0MrU3ZjVFhueWhCL1N2ZUNvaEZzdy9LM0wreDlM?=
 =?utf-8?B?QXpKSkhzeFlpR2dHVjJwd09vQk5PZFhYd2lRNU5BYUV5UGJkSXNHT1RrMkdk?=
 =?utf-8?B?L3E5RUoyei9rRitZZkxpNjZZWGtMc29zYWVOZW43RUgwbndFNmdIcDlmMG9B?=
 =?utf-8?B?TFo1a1NacGJWVXlZMnpVL0ErVVJtSExpVHptZVM0ODVWeVB2cXc3bGYzQjFR?=
 =?utf-8?B?M0lUck14OVdLQkpzZEx5RFpONmZIWUZFYXhRbWVYL1JteUJhOUJqMXNxdC9G?=
 =?utf-8?B?eFVWRkNDby83QmVnOHVvTjdwSmlNcHBaVXpHMXVJS3pOTzhncWRvWXd5ZGVH?=
 =?utf-8?B?aG1UOUZSRHcrSDRaN3ZaNjFVOEdHUTN3d3dTZU5nWCs4SXhNVVNQTDNjYUZ6?=
 =?utf-8?B?QWR5WVZ1d3lnTDdzKzF0eWtPeEV3dUtRd1VJYzRRMkNSWXM1cWdXSit2YXlY?=
 =?utf-8?B?elhtSWJnbm5NZ2xVRDd6Ni9TdFJWdEs5SDB0M1NJTlkwYis0VkdGK213WFh0?=
 =?utf-8?B?Zzc3ZU9sZHJUUnhCNWZrdnBYQjI1am1HcVJON1dJNkFDTDJzS1ZlN3AyVStD?=
 =?utf-8?B?bDZOUEs2MkdNaTlzT1dWWThVdVo2dlUvakcyWEc5SnY3c3ZhRUgxd2ZqeFl6?=
 =?utf-8?B?ZFE3elI5YVBVL2NULzNTSjJsbTJ0REdLVjA5MFlmVHBNWVoxdlV3cEZnKzEv?=
 =?utf-8?B?ZVR5SVdNbU1LYkhKcE1zSURMVVZRUmdDNmNqSXhMSW9mVkM0WFlkWEdGeXA4?=
 =?utf-8?B?cUpHbzJXVGVhSFVFa3MrUE1sY05pMFRlNFpXMkJqZm5FZm4wb0dnZ1BxTjZ1?=
 =?utf-8?B?bHVvZUZLZ3h3Q0dwTW0ra1Q4bjdKQXgyYjNQM0JRTVlSTFU3RjJIS2grUm05?=
 =?utf-8?B?MkNmenRWdDlqRG42eVhkWkZqTVc5aHpDMVY3MWdQRUpMRzJteVdoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f17368-cb67-4932-754c-08ded361b028
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:02:45.7188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbRbKa3xT5SxZfZ6lvxPykyWSpZWWdH6Db+2yXDTz4oVOjF9aJNb0Tk54HXlxnFBLJO3bd/4sQ84V51H1qS1KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
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



On 6/26/2026 4:29 PM, Matthew Brost wrote:
> On Thu, Jun 18, 2026 at 04:08:57PM +0800, Honglei Huang wrote:
>> From: Honglei Huang <honghuan@amd.com>
>>
>> The intent of this series is to make drm_gpusvm more flexible and give
>> drivers more freedom over how they assemble the MM related and device
>> side operations. It implements the direction Matt suggested in [1]:
>> Mirror MR in gitlab: [4]
>>
>>    - Move struct drm_gpusvm_pages out of struct drm_gpusvm_range.
>>    - Embed a struct drm_device in struct drm_gpusvm_pages and drive all
>>      DMA through it.
>>    - Drop struct drm_device from struct drm_gpusvm.
>>    - Have the driver's range structure embed one or more struct
>>      drm_gpusvm_pages in addition to struct drm_gpusvm_range.
>>    - Drop the range-based helpers (drm_gpusvm_range_pages_valid,
>>      drm_gpusvm_range_get_pages, drm_gpusvm_range_unmap_pages) and update
>>      drivers to use the drm_gpusvm_pages helpers instead.
>>
>> In essence the series does only two abstractions, plus the xe
>> adaptation that follows from them:
>>
>>    - range vs pages: split drm_gpusvm_range (MM / VA range state) from
>>      drm_gpusvm_pages (device physical related), so the two sides can
>>      have independent lifetimes and ownership.
>>    - drm_gpusvm vs drm_device: make drm_gpusvm pure MM level and push
>>      the device side down onto drm_gpusvm_pages, which is where DMA
>>      actually happens.
>>    - xe is updated to fit the modifications, no functional change
>>      intended.
>>
>> V3:
>>    - Fix a kernel-doc/Sphinx warning from the kernel test robot: use
>>      ".. code-block:: c" for the drm_gpusvm_pages example in DOC: overview.
>>    - drm_gpusvm_range_set_unmapped(): use WRITE_ONCE() on the whole
>>      pages[i].flags.__flags word to pair with the lockless READ_ONCE()
>>      readers and avoid a data race.
>>    - xe_userptr_setup(): call drm_gpusvm_init_pages() before
>>      mmu_interval_notifier_insert() to avoid exposing uninitialized
>>      pages.drm to invalidation callbacks.
>>    - Fix per commit build of the set_unmapped() pages.
>>
>> V2:
>>    - Followed in Matt's v0 review fixups [2]:
>>       - keep unmapped flag in pages structures.
>>       - add pages_count to drm_gpusvm_range_set_unmapped() to set the pages
>>         unmapped flag, so the framework can check unmapped status in
>>         drm_gpusvm_get_pages().
>>    - Add drm_gpusvm_init_pages to init the drm_device and sequence number.
>>    - Remove drm_device from drm_gpusvm_get_pages() parameters.
>>    - Reworked the DOC: overview and usage examples to describe the new
>>      model: struct drm_gpusvm_pages, the 1:1 / N:1 driver layouts, and
>>      examples that operate on a driver embedded pages object by the
>>      drm_gpusvm_pages helpers and etc.
>>    - remove WARN_ON_ONCE in __drm_gpusvm_unmap_pages.
>>    - Dropped RFC.
>>
>> Follow-up (not in this series):
>>
>>    - modify drm_gpusvm_get_pages() to support one time hmm range fault
>>      and multi drm device dma mapping.
>>    - Add no dma device support for drm_gpusvm_get_pages().
>>
>> tests:
>> AMDGPU:
>>    based on amdgpu adaptation patch in [3], but still SVM:DRM = 1:1,
>>    1:n is on going needs many modifications and testings.
>>
>>    Tested on gfx943 (MI300X) and gfx906 (MI60) with XNACK on/off:
>>    - KFD test: 95%+ passed.
>>    - ROCR test: all passed.
>>    - HIP catch test: gfx943 (MI300X): 99% passed.
>>                      gfx906 (MI60): 99% passed.
>> INTEL XE:
>>    Waiting for the xe driver git lab CI result: [4]
> 
> Sending to the Xe list (intel-xe@lists.freedesktop.org) is enough to
> trigger CI, and the results will appear in the Patchwork link [5].
> However, I am not seeing this series there, even though Xe was CC’d.
> 
> Perhaps the patch must be sent *to* the list, rather than just CC’d, to
> trigger CI?
> 
> Anyways, I think you will need one more spin here, so hopefully you get
> results in the next rev and then it will be good to merge. If not for
> some reason I'll apply the patches and give it a quick test run.

Really sorry about that, will sent to intel-xe@lists.freedesktop.org to 
trigger the CI in next version.

Regards,
Honglei

> 
> Mastt
> 
> [5] https://patchwork.freedesktop.org/project/intel-xe/series/?ordering=-last_updated
> 
>>
>> links:
>> [1] https://lore.kernel.org/amd-gfx/acRgr7QwdULsn6G2@gsse-cloud1/#:~:text=I%20think%20roughly,drm_gpusvm_pages%0A%20%20helpers%20instead.
>> [2] https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
>> [3] https://lore.kernel.org/amd-gfx/20260603065030.2554403-1-honglei1.huang@amd.com/
>> [4] https://gitlab.freedesktop.org/drm/xe/kernel/-/merge_requests/360
>>
>> Honglei Huang (5):
>>    drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
>>    drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
>>    drm/xe: have xe_svm_range embed one drm_gpusvm_pages
>>    drm/gpusvm: move struct drm_gpusvm_pages out of struct
>>      drm_gpusvm_range
>>    drm/gpusvm: let the drm_gpusvm core context purely MM level
>>
>>   drivers/gpu/drm/drm_gpusvm.c    | 230 ++++++++++++++++++--------------
>>   drivers/gpu/drm/xe/xe_pt.c      |   2 +-
>>   drivers/gpu/drm/xe/xe_svm.c     |  37 +++--
>>   drivers/gpu/drm/xe/xe_svm.h     |   8 +-
>>   drivers/gpu/drm/xe/xe_userptr.c |   5 +-
>>   include/drm/drm_gpusvm.h        |  66 ++++++---
>>   6 files changed, 209 insertions(+), 139 deletions(-)
>>
>>
>> base-commit: b9297d19d9df5d4b6c994648570c5dcd1cac68ff
>> -- 
>> 2.34.1
>>

