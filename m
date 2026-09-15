Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5780C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040A110F3D5;
	Tue, 15 Sep 2026 11:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ncpbOT4a";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56B110F3D5;
 Tue, 15 Sep 2026 11:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo+I8GcRtou1FmDZruZsVQbdBZDu1vgWOgJYkAoS/1GuPkcnKhhjV30N/ftLEfAF1T5s0pIr8cafAN8sKR5mn/YdqdskraR+Xyy/Sn0SPu4aocV/dRuEx8oWbC8+WOo/uTz6vD3i0YbndYiul5gsXKFCPIDw9fi0jbOYIpZBia4JSzWT/LTeD4nBNJLXo+Etp/m3hbQSEINU5seEEuCIZfj49LyY2xq+o4iRzTHUdSnDXZ8LQFmFhny190YycLcwZcX68UEu4xz04Of0IkZvuMjiwFHS08XRMi+JN+apKuYEBvo42W2JycjxGre58OfGyGX4t/mTU9u4DquVcEAEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xC1z4NLMYL/o4hNBcHKF/wGagidJ7Ie9PikmYXqA7lI=;
 b=JA4wUxPQjKAzQJgyNZce4CQh6WRx5rSDAVa2F6aOK/NPUHXJhrENuUXgX0n6m+urenHW7jYVIrT7ULkJCTnAJIWYlg9XZOMQjV+9WlCQkl61OAjkUBlC0CpXan3Bq35tmMhZ1x91raNxb/oKjiD6ly4HQqSYSwbtMlmNmNomXvKo3Jb7kRpY/wTPppq9Qs2b6ow/30PWXDYvLNZVAbyEatT2K1pBegveMCvGjmJMbNI+d8RBITXRZuj5zHZqvvQEcL4tstydJ3ze9x+mhyoKw6e/Ok10Y/xnvU0Yrst0kA6QGxYCF2YtB1ews8x/xaPxm5BmTx36vauDo3nEG0v0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xC1z4NLMYL/o4hNBcHKF/wGagidJ7Ie9PikmYXqA7lI=;
 b=ncpbOT4aHnLdOAbJWcEokmwXOgEpmTk0xdIuEgqNi7YM6W6y/vvbahqyxgt/SrlI+amW6OgqQO5Za/4KFZfshw4Rp5ZgUK8Y5061p+4Kk08uWJiWRFHzYkFyxhsdO4KH+mAl993FmMSul3ECnL94HsNaWaQFlGRRh7WJrG7UhTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 11:22:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 11:22:52 +0000
Message-ID: <fb733813-9e4d-494a-ba60-469261340e74@amd.com>
Date: Tue, 15 Sep 2026 13:22:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: don't free mapping when
 amdgpu_vm_update_range fails
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Natalie Vock <nat@pixelcluster.dev>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 kernel-dev@igalia.com
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
 <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
 <9c507259-f65c-4f18-8fc7-8e03de0c4f87@amd.com>
 <acc1e3eb-264c-4591-9f66-5fe93b96f97f@pixelcluster.dev>
 <aqkf0LE51mObdEJc@quatroqueijos.cascardo.eti.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aqkf0LE51mObdEJc@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0247.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b472ed-8085-439c-2dc2-08df131bae99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BWFeNYI/AzidhNu4fDcPdLwWunV1uECuzP5u/JZPAY6PWKW7e68K+j3NYTOcM2o9k7OVRJiaC/zxiOsvejzzUGnmYOMyAoVSGkyO8DypD8Sd1l5GIyk9AjmWNaqBviBeiLpfKGrePMtTe28djjzjRPEN22dF6wniiZfV1zVhEB7Kab7fBlonzuVONH+jggedtDIX5Jkdedj9Tnm3O6tIKqdvpOvEO8rwuMI0p8X8DkhubCJPfuQuATz0O5x0iuuVhIfm1yzE8RvjzMr+HIYEbKuqeGnQzW4eZ4IGnx+EFSFKCNgiKx54+xldZ8wJ8x2IHSIaxujTjL5td9nNEwUIX0wMgc+M29RTHH6EUlaqS49oorC+5+3lTfUnmHk9CCYudlxGDFbahgOkqZt2dV/hWs7NbPlPLBke7zXuApkJ3m/GES6/XuuLqDIt0HZPDl5ZQ5A1JxcuY3Fuel5bOWCujiZtnnKobGY6svyk0WugXsJceJn7d3QYFGtqPcON+m70j7ZsqtNOMjsmca4joid6tZSOGDnWu7FT9yHqlMGTS+vP3XmEvuh+q3JTpIf0XLUD/D9AMPrwxTKNjTkIM5buxzZq01V0emym4gQeJK7nRQXwE+ZUJktRYCqml/Joupy1x1sos9kSknG6OpJoamCw2XZky40wlIPm6w2CBBGaLQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDhJZm5MRmEvRnMwOHBibzlwbWJFcC9QR2EvL1Y0eGVHS0JXcnhGTWdBSzZX?=
 =?utf-8?B?cVU0Yk5kN0xWbjF0bk9nQ2NFZ0tDSTlOd0RBakUyRFdJbXB1VTdYQ2FsZHEz?=
 =?utf-8?B?Sk9PblRucVNrT3BiTjZnUytSbHJRRWFmdWNReEExQTQvV3B4TTRQaWUrd3dW?=
 =?utf-8?B?YzlkZDFOY1RLVGJDWEc4UThYelhMNGh5d1VRU1pTVjFJSHlWLzJEdHN3L00z?=
 =?utf-8?B?S3dFd0hJNkV4dWxrUzZsZ2VEaklwUVFaWEpEcHJ3YVJEK3lrQllGenJqY0c0?=
 =?utf-8?B?d0h4ODBJM1ZHRFovT0JSUXg4cDFrejZCbXdVaUlPT3lXWVR3ajUrbFZUOWxN?=
 =?utf-8?B?eXV1eEVXVDJKa1VqbUxhRVFNV3BXZjFUbE9IY3hLS3k3VVUvL0ltd3pORGhH?=
 =?utf-8?B?TmMxMGR5YlBid2tMWGVMY3U3a08wQ1dxWUh4WitDT2VSRnNvcDVsY2w3WnRz?=
 =?utf-8?B?Z2lWU0N0K2Y0K212OWI2MmQ3YzB1dVUzaTMxRUJaRWdOZFIwb1VWdTEyUkJs?=
 =?utf-8?B?djJjamRMSVlQbGxZUitmc0pBVXFvWDlEUnlPS0d4VTNQc1BmTEcvUWNONGdK?=
 =?utf-8?B?MjlaT0IzS2Vaenl3dWRZaUtQTzdYSXVCWEZIemhxSVFwU1V4cnd4bnJZR2dw?=
 =?utf-8?B?RFIxb1lxZXhBVVhRbFAvYXpCaXpUVUgzS2F0TjhieUdXNVBpVGt6cUlwNlYw?=
 =?utf-8?B?Ry80dkEvNllYcFlUclZ6RG5nZTFqa1BKL1NlcW14TE9KcGFRMkF5a1BHSWRZ?=
 =?utf-8?B?dEIyRi9KRFNnaHJHdm45bmR5N1NDQlJkQy9FZEY4VC81MVRZU3hoaDN4cFZB?=
 =?utf-8?B?Q0R3cWl0S3NobmVnbzJ4UU9vYy9PWFRyMVRKU29pNHVjVHA3eXNqcDZmQVoy?=
 =?utf-8?B?T3RMRmFuU2ZwMUYrUmEwZ3pONlZ3aHFRRWgyY2hFNjFHVkE4azU5WDlxOHRC?=
 =?utf-8?B?bzBzOThKdzhCZTBmN0JlSEdmM1dyOFN1RkR4WTFzbzRsMnFxaXhhMU5TL2xu?=
 =?utf-8?B?V0ZGRGx0d1pISzl5aVNoUUwxaWlndUtSWlBxUWJJd3plTzVVREFoOUE0SitX?=
 =?utf-8?B?VnFzMjVBdVVlc093Z2hYZ0paQjhQMDJOaVlmUElMRWRwQTVBc1A2K0hacDEv?=
 =?utf-8?B?ZWhYa0RhN3hCS3pPVUlxaHlWeVZIbjZoWEwvWGJDaUtCWTJoZ0pJZVFad1lN?=
 =?utf-8?B?NE10aXhFZlI2eWRUcWZFb2pxbjQzWmJYNko0RWUyY3RxTTNZeUNhb0R6cS9R?=
 =?utf-8?B?MjhnMnlVMEk0NmNXLzVkRWJtOTlPUzZsT3luWkNIS0hkZ0VnL1pvaURLSDFN?=
 =?utf-8?B?WWt1WHFpZDNmbzFHYmtBSFAyc2xmKy9rQ2pZWHQvellXUGMxYmxUY2syL2NV?=
 =?utf-8?B?Tit6V1kwOVVOSEVhaVVkMUlDMnFSZFBucFdmUUZaZEsxOGpLWEg2SUs5dXN5?=
 =?utf-8?B?Z3BibnFGd0oxa3FXdDJ4NnJHbEl3T29xRXNmQ1JnVTVVbmR2S1JaMEZWRTJm?=
 =?utf-8?B?L0dibWJCQ3IybHhrMGJrMnRPZ0J4R1g2QkdWWFJ5OGtsdE52MVFPSEJyVnNh?=
 =?utf-8?B?U24yb3ExalFqRzl1alFwUUVwNmdZakp1cmkxTGdzdVdtYXdxbTZlNEFJY1pF?=
 =?utf-8?B?TGg2VXhXN1drMTh1TjF0NjIxei90S3hQaWQ2MnNZWXY1amxtNnJsT3g4anJm?=
 =?utf-8?B?UkhtdmhFNlMxRnZpMXJtS05PTFpnNkEveDVMTHZLZlJ4L3pFK1hGSVBQb3JH?=
 =?utf-8?B?dHI3b3FIdnNHc25aQi9LTTl1YWR3K1BHSy94ZWNnMGsrOGM1Sy9iTGhCSS9O?=
 =?utf-8?B?YnB6bmx2Wm1vcGVyRFFuY2swOFRCWWFIOVdTVktHdnViTDBwZmE5bDBYS3kw?=
 =?utf-8?B?dXpWb0hHalYyZmJCR2VqemoyRU5BZlNOeEFTa05NNjFVZkJEREplc0lySlBk?=
 =?utf-8?B?cmR3dWhkaDUxMFR4RXFOV3RTenoxMFp0eWk3MkQvUFVXK3pJa3lTWVh6K2J5?=
 =?utf-8?B?Smd6MkVYcjFaUUNEUmtUdnFmUlVuRE5BdGZjcEcwZDNSVWxjQUMrSndlWVhi?=
 =?utf-8?B?RG16SFBYYlk2NXhmSm42NVVlRTZWczNQa2VLU2tBTXprd3ZFWnpCNDV6M0Uy?=
 =?utf-8?B?VFpRNS9HdHpOZVlOdVZPSXVjYTltbEd2QWdldXFIMnVERlJMU3NXSENKTFda?=
 =?utf-8?B?UnF3YmwyRGNlRnl6b2xoWVFsbDhYUEZRUE81bU5FQnJwWlo3cmpyWlRTUE56?=
 =?utf-8?B?K1A4cGNycUo0Q09yMzJzOCs5MDNrb2U4V1VwVlFsRHRBM0llWC9JTTNaOC9K?=
 =?utf-8?Q?houSGrFs57T7qJ0q2r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b472ed-8085-439c-2dc2-08df131bae99
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:22:52.6071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iT/lDfCzW21sH+6Wwxl3Wi34X1zPhqm2xTCDNDwXZzTFvzakN9vQWprJb9Nd5rT2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
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

On 9/15/26 12:37, Thadeu Lima de Souza Cascardo wrote:
> On Tue, Sep 15, 2026 at 10:53:43AM +0200, Natalie Vock wrote:
>> On 9/15/26 10:33, Christian König wrote:
>>> On 9/14/26 22:25, Thadeu Lima de Souza Cascardo wrote:
>>>> If amdgpu_vm_update_range fails when called by amdgpu_vm_clear_freed,
>>>> the clearing of that mapping will not be attempted again. Later on, when
>>>> an IB tries to read that mapping, the read succeeds, leading to a
>>>> potential info leak, or even data corruption, if it attempts to write to
>>>> it.
>>>>
>>>> If the mapping is left in the freed list, then clearing will be
>>>> attempted again during amdgpu_cs_ioctl, which will either fail and not
>>>> submit the job or will succeed in clearing the mapping, preventing the
>>>> invalid access.
>>>
>>> Same as I replied to oushinnyo <oushinnyo@163.com>, absolutely clear NAK to that.
>>>
>>> amdgpu_vm_update_range() can only fail when the device is hot removed and we don't care about clearing page tables in that case.
>>
>> Actually, how so? The SDMA update path has lots of allocations that happen
>> at random points throughout the update process (think the SDMA IB being
>> exhausted, then vm_funcs->update() will allocate a new one and can fail on
>> that, or various fence allocations. Some paths allocate from the delayed IB
>> pool which is just regular GFP_KERNEL, why couldn't these allocations fail?
>>
>> Aside from that, the more trivial failure path that I think Thadeu is also
>> talking about here is that amdgpu_vm_ptes_update will call
>> amdgpu_vm_pt_alloc (so that happens in the middle of VM updates) and these
>> allocations can fail. I'm not even sure if drm_exec can save this one
>> because we need to be ready to drop locks and retry.
>>
>> I get that failing is unacceptable for the cases inside a pagefault handler
>> (though I'm not sure if anything of what I mentioned applies here, pagefault
>> VM updates are immediate so they get GFP_ATOMIC, but maybe the pagefault
>> handler could still allocate PTs?) but for anything else, failure seems like
>> a possibility and maybe we should think about handling it in some way.
>>
>> I'm not sure I see a problem in keeping BOs invalidated and backing off
>> later, since new submissions should be rejected unless the VM manages to
>> complete all updates successfully.
>>
>> Best,
>> Natalie
>>
> 
> Thanks, Natalie, those are exactly the possible scenarios here:
> amdgpu_job_alloc and amdgpu_vm_pt_alloc might fail.
> 
> Christian,
> 
> I have started this investigation once I observed the kmemleak that is
> fixed by the other 3 patches. Natalie brings up the exact case where this
> might happen: amdgpu_vm_pt_alloc fails as all other VRAM BOs are locked as
> they are either ALWAYS_VALID BOs or PT BOs, thus sharing the same dma_resv.

Yeah and on a clear there is never a single page table allocated. What could be is that temporary memory allocations fail, but we need to make sure that never happens by using the emergency reserves and/or pools.
> Here is a log showing up that something failed during the update:
> [ 3839.556311] [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-12)

That is failed memory allocation while trying to map something which we also ignore and delegate to the next CS.

> 
> The investigation then led to a reproducer, which is able to trigger the
> list corruption that is mentioned in patch 4.
> 
> And given the kmemleak stack trace shows amdgpu_vm_clear_freed in the stack
> trace, that should clearly be where the failure has happened. Looking at
> the function, then I noticed it ignores the return code and still removes
> the mappings from the list. I was able to write a second reproducer that
> triggers the failure, then releases some memory and demonstrate that
> amdgpu_cs_ioctl does not clear the freed page tables as the freed list is
> empty.

Unmap/clear operations are also used in MMU notifiers who can't give an error back to higher levels but rather need to unmap the area no matter what.

So basically that is an operation which can never fail in the first place (except for device is completely gone and then we don't care any more).

I'm about to split the map/unmap into separate functions to make it clear that unmap operations can't fail.

When you have a reproducer and can pinpoint where exactly the memory allocation fails that would be rather helpful here.

Regards,
Christian.

> 
> Regards.
> Cascardo.
> 
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 09037df76400..5bde36754607 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>>   	while (!list_empty(&vm->freed)) {
>>>>   		mapping = list_first_entry(&vm->freed,
>>>>   			struct amdgpu_bo_va_mapping, list);
>>>> -		list_del(&mapping->list);
>>>>   		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>>>>   					   &sync, mapping->start, mapping->last,
>>>>   					   0, 0, 0, NULL, NULL, &f);
>>>> -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>   		if (r) {
>>>>   			dma_fence_put(f);
>>>>   			goto error_free;
>>>>   		}
>>>> +		list_del(&mapping->list);
>>>> +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>>   	}
>>>>   	if (fence && f) {
>>>>
>>>
>>

