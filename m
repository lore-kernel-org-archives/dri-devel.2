Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECF4F9D0CA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4359310E60C;
	Tue, 14 Apr 2026 13:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2PCTKpD";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010056.outbound.protection.outlook.com
 [52.101.193.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A4610E605;
 Tue, 14 Apr 2026 13:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k91bh9kj33k8roArHGMuaPXo84IdWyYSbAn9Sj2fGy3s6COxzn6BDynIt0TRHqiXfZehqfPFri9z6nXuEFcJ5y+Py+Vh/BTKSdMCbWwt+aPkmGgsAk47db0kFcR855Uta34yztvLyFLEiPol7zAddd7+eJLASmojMWVA6tye0j8Cpygl+bH68xZtmYmKNx9WePqJHTsJoQiHjYBokCceyVl/qCXdSVJtWEwUHB6jA8E+tOFuc10G2zqlRx88Mpe9hn3LZ/ItBt9qcGx3iofaCD7I+UuNcZKDIT4/OolptPDma39WoejONXg81zFdDMHUgmlTqhoU1xXnluOaNZ4IwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMIAxykypxFxRhnsq2e6vEQasWXwYbtxRt8gANr0KWI=;
 b=YnIBlmFygw7XwhoMyC7BKo30Kj8MaY55quZ9CyJW8y268b3b3qE1pYlnco0cXp3nrzNMkDADGNN9unexwpr6v9sl2KpZQjXo3Zg90pQb1/buTi3hoUFe0cN0sAcZ2gh4NSZe3LqdGkbCLC6YRSMbrffh8gQTyXnp3TLy0XDBF4BEtdP7T9cJyhebA/NChTTulmuRYPH8DR4tCBfy83UjeXNVOEighQSASbrDLg7nWlwZlOVp0Yu9XIE+/rS7XSvpbLhaMrtIc4skvnjehszF6ha98PakAkDIcFYhw4XSIn7FMCUJjo/egNIG1L/y2Op5ZqU3uq19k8rVmL9OTv3kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMIAxykypxFxRhnsq2e6vEQasWXwYbtxRt8gANr0KWI=;
 b=B2PCTKpDTm09mbrx5oAKP9q4Dqo/zyjTw85+HwpKH1Ttuvyw2C9Z7A7/ZxizCgQuZF6MUvD0EOt6FRunIXCjFDkzqf56O46U8Ft3Jjz/3imNREOVVmwKr8v9F2pObO4/E+JNbD5qOzv72JKhb3BF+PXoNqoDjolriRTCI2pQjKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 13:41:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 13:41:13 +0000
Message-ID: <3cea6823-5c18-42c9-bfab-877951dd5b70@amd.com>
Date: Tue, 14 Apr 2026 15:41:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: fix root reservation in
 amdgpu_vm_handle_fault
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260414122523.3645-1-pierre-eric.pelloux-prayer@amd.com>
 <2990351b-f3d8-4a6f-9902-9d558c444449@amd.com>
 <5b68bfbd-1821-46b9-8ac9-552735474a05@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5b68bfbd-1821-46b9-8ac9-552735474a05@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: b10df3d4-262a-4570-cef3-08de9a2b7ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: o/RUxl1bgz7Q4a3CxrZIvXxYjbEWLzLI9KnGy4vhuiwQuOQ/h/rzPWcI/t3ZwBhYapsyiHKxwzEA5ALbTxasUQcbq2TDpI8rnT1sgqy0cjcAXDXlN4jRgz4Zcaj2Gq/6+uR2rT/fCarqE4m63Boosnx5HP2jXs7tMglvNcXeblb2WWJQUTz5+COYb2YrTIxl/sODSlaUpbyMhZbimPtP4S886qRDBcfXoK5xZ6GTD0VB9VaNJ+YcwmVhDP7T0Mxvo4A/Yxl/kNVg6lApqN+XxRW6cvrhLFJaLCeg20jc7gyA7hOAGo8o3iAUsKYz2W61j6CJ+VxtF22xZxF8RFWQMRVkQr5xjKacV0tCB7Vf1ekxKBXtpddmukq2KtyfNpuS7vo/EMugu/1eEItQBQIxqFB2nidD9om4iTjrNZfe8GDFjCb/gwQ2wdrJwzuILLEccjB9vo2BxQ+wnIxReVIUoBKmVmsNNTgpjFNLNfJq7TqFBvyhfTo9jAAFlhbncVKxEntF035AMon7wbWPC5u7bW2QDDiIG0G/qpHhFQxq0/4fBQO4kn81vVj/JRilSb6Nc72MnKIWgRcNN5I2GTdzP1GyzmslgDn3FJHAcqBSHFRWvuNhx2g7zG3BrxuHMr6xYPY07dr5h64FjoBQDYTzrfAu0Tauyr7KtflIFnK/7nKLMdP/Vz+kBYyh9p8dd5SES0A1xTnAE6Jd6miLIueLT8b+vcmKU1B7ABv7WczNfH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9rclJ6YTMxWXo3MzRiek1sTXNLNVhHVlpLbWIxUXVKdVY3U0dFZGtpYjNp?=
 =?utf-8?B?N0t1dDF1WjBZWnh4YXlwbmFXSjZwS1hPbXh5VWFCVGJVUEtRM2hQSk5uMXBU?=
 =?utf-8?B?WmdRTHpaU25pRTVpTEhqdTZhL3pxVDNmcUtEV2pyMTVnallvZFFEYjVxeXVJ?=
 =?utf-8?B?aWp4Nyt1N2p2czRvaWtKUTdZRkcwaEtWZStqcktwQk5MR01GSGZCVHpRNU1w?=
 =?utf-8?B?a3M5NTlQTEdmV1NIbmp2OXc3SUhYWTdMVXlqRVl1Z1JLZTZ1UFBrVG5sclJ3?=
 =?utf-8?B?WUxrZnJISjZ3Sm54MXRDVTNTby9ibzl6MXN3RTVJTXh5dVlTSTFrZmJQYmtW?=
 =?utf-8?B?dVJUeCtHK1lFdVZReVlqTjltRG1CODd6V3pyVk8zR3VtakNMRmpwRjVycnFv?=
 =?utf-8?B?OGN1OWdFRzVnY3JOL1ZCVm9HZnlnbVZIZW83OXFNSEN4UFQ1VVNsWm1WSlNh?=
 =?utf-8?B?c1NTcWllelVrQ1BLdjVqMUt5UlQ4dGd3bTJFdWVLaENGNXdaSE50amdTc1Fy?=
 =?utf-8?B?LzV6SVl2eW1FWTlIR25sMGxCZmNteUd5LzRRTExSMXNQVHdJZUZrNkJjbEZ5?=
 =?utf-8?B?cUIzaXh4OWI1Rnk1a00yMk04QXVkOVBoSnR3TUFkQ3FDdCt2Vm00aC9ZUG4x?=
 =?utf-8?B?WmtuSituVGMzLzdtNUVpaUt4RU5sZjJ4NGV2RW02Y2dlMGhyTlY1TUZrVU5U?=
 =?utf-8?B?ZG1yU1pFUnBFaVRjVTdVR2lYMk1tZGozVDg2TmFvVHdEUU56cEhOb3h2a2JN?=
 =?utf-8?B?T1lFWHFXRTZaVlprNTlpVllYNDQ3Yld6cE9lN21STHdaRktmaXFudGZtdEg2?=
 =?utf-8?B?Wm5oZmtVc3haejdUcy82dk5KODI3L3VOMDFyanBoMXlBa011N0N1dmJvZTVY?=
 =?utf-8?B?eTFvSFdOSWlZb01IaDI4eERjRUhLaDNpQmwzKzBiamM3UU1ram9QRStBUkRz?=
 =?utf-8?B?bVhoTUpZWi9IRmJUb0JXbEY5VGtuNXUwUmQ5SHBDN1loWk5TWXlyb09JTGps?=
 =?utf-8?B?bGZZTG11NUhMWUx4MU9LM3ZxS2ZlNk1saGZFZ0ZrWFFWVVp1N05TQ0l2Y0gx?=
 =?utf-8?B?MCtremMzZjhGbmV6WlZVVkVDSHdka1E1TjJoK2hORG4yMkEvNHE4VlRpVCs0?=
 =?utf-8?B?M0p3TDhKblpQSHk4ZjZXZitvYk1yWWV1RGJsNFZYQ05HSDFKcEs2MWxkZnhm?=
 =?utf-8?B?Yy90amhUaDVOUHEzY2pJMjFrL1c4OHRFU3VHOWFmNGVMQzVUOHkrQUw2RXFo?=
 =?utf-8?B?YUhDaWN5TmV0eElLQzlVODhLVjdLaWV3WURGaEhhUnlSclhaQ3laZHlCQnhl?=
 =?utf-8?B?b2tubXg4SEJ0NVNBL1IzZUZXQWg0bWZyNnhUcHZJRkJjbEFJcUdrTkFDUVgx?=
 =?utf-8?B?QjBzTHpxcnFkVkJsbmFWWDBUSTlRYklSODd6eDN0WkFUWG4vKzQ4N1AwRy9i?=
 =?utf-8?B?cU1STkthMTVZVldZQytKd1FQY1JKckl3U1ZsaFBTN1c3bnUvK2JVVFlibWdO?=
 =?utf-8?B?QWRuSUEwYUY3YW9Vdi82UDhaOTY1b3g0cTAyRGRiUXpaczlMK0dJcjdTbW1Q?=
 =?utf-8?B?Z3QvQXdHUktCUXUwRklzT2hzTTd4bTVWcXZ6andXam90TjRQQ3JzeDNPcUls?=
 =?utf-8?B?d0lSdXd5TFBGb0pBUFUrbWF3NkFSZllyU1BybWJ1OFc2YzNiN1FubmpxUUtB?=
 =?utf-8?B?USs4QTdSVlVqUTRjeUoydkw2MCt1U1ZBMWc4MkozeWRJZFFtNEsxZk1IMHc5?=
 =?utf-8?B?QzhsL2FxTzQvZnU1SGw1WjBlNUw1K1dpeEpYdG9RY1MzSG9XU0orT0I0RmFZ?=
 =?utf-8?B?Wk50TGZ0S2ZyekZLTGtQa0ppVXVMbFJVK0dmV1lCOC9VNlpuSk1EUWdEVHdX?=
 =?utf-8?B?MFFJOFBZZWtkcXczMWFHdFp5dWY2MExwS3ZNQ0Y2SjUxQk0yZUNqQ1NYMHBv?=
 =?utf-8?B?RlptZ1kwZ3lmNWFYbmFraUw0U2JpR3Y4WkZaa2Y5eVh0ZEtkWE9iVnlhdmY5?=
 =?utf-8?B?VkdEaVc3UzBQMk9PM0NkYTZscmw0anQ5bklKK0RkMXpTM2R6ZXZBTU5aRjZZ?=
 =?utf-8?B?SS9PSzZYRW9DTElWOUU4QUtwS0VQdXBuTWh4Y0lRV3YxL2RZbGZxTWY1Vjkw?=
 =?utf-8?B?RkdkcVVDUCtUaWEzbTUyVWFrbjd6b3RnQ1VqRTFRWW5zbXcrMU1WZzJVSEN6?=
 =?utf-8?B?aE9KcWVpMTVIVmd3WmVtNXlEaFgzY2hVb2xYUEVjSmpFZzRJWFk1UUUvenRZ?=
 =?utf-8?B?WUl2OU8zNEdTdkprNmtubW9velBTUHdYcTlFazgzSEN5UzNtRTNMNEZUZGxQ?=
 =?utf-8?Q?GZXarnFGOZ8mnGUMTA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10df3d4-262a-4570-cef3-08de9a2b7ec7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:41:13.6222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tsiBK1fI7t1/4Ym+3YI0pX4AheWrX2vmgq7TdbJVCkT+MToYG4twIhxz9ElLrqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

On 4/14/26 15:35, Pierre-Eric Pelloux-Prayer wrote:
> Le 14/04/2026 à 15:30, Christian König a écrit :
>> On 4/14/26 14:25, Pierre-Eric Pelloux-Prayer wrote:
>>> svm_range_restore_pages might reserve the root bo so it must
>>> be called after unreserving it.
>>>
>>> The code checking that the VM still exists can be moved in the
>>> "if" block, since the VM can only be removed when the root bo
>>> is not reserved.
>>
>> That won't work like this. Dropping and reacquiring the root BO lock is a pretty big nono.
> 
> OK.
> 
>>
>> I think we need to fix svm_range_restore_pages() instead.
> 
> Alternatively I can modify the code from amdgpu_vm_lock_by_pasid to only reserve root when
> "vm->is_compute_context" is false (or to never reserve root and leave that to the caller).

That sounds pretty awful as well.

General sequence *must* be:

xa_lock_irqsave(&pasids...);
vm = xa_load(...);
root = amdgpu_bo_ref(vm->root.bo);
xa_unlock_irqrestore(&pasid);

amdgpu_bo_reserve(root);
/* Double check that VM is still valid while holding root lock */
vm = xa_load(...);
if (!vm) {
	amdgpu_bo_unreservet(root);
	amdgpu_bo_unref(root);
	return;
}

go on update the page tables...
unlock(root);
unref(root);

When the svm handling doesn't expects the root BO to be locked (because for example it needs to lock other BOs) then we need to unlock the root BO before calling the svm functions.

Regards,
Christian.

> 
> Pierre-Eric
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Fixes: 32b486e8541c ("drm/amdgpu: extract amdgpu_vm_lock_by_pasid from amdgpu_vm_handle_fault")
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 35 +++++++++++---------------
>>>   1 file changed, 15 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 63156289ae7f..d86be0108913 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2975,25 +2975,12 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
>>>           return NULL;
>>>         r = amdgpu_bo_reserve(*root, true);
>>> -    if (r)
>>> -        goto error_unref;
>>> -
>>> -    /* Double check that the VM still exists */
>>> -    xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
>>> -    vm = xa_load(&adev->vm_manager.pasids, pasid);
>>> -    if (vm && vm->root.bo != *root)
>>> -        vm = NULL;
>>> -    xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>>> -    if (!vm)
>>> -        goto error_unlock;
>>> +    if (r) {
>>> +        amdgpu_bo_unref(root);
>>> +        return NULL;
>>> +    }
>>>         return vm;
>>> -error_unlock:
>>> -    amdgpu_bo_unreserve(*root);
>>> -
>>> -error_unref:
>>> -    amdgpu_bo_unref(root);
>>> -    return NULL;
>>>   }
>>>     /**
>>> @@ -3026,11 +3013,19 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>>         is_compute_context = vm->is_compute_context;
>>>   -    if (is_compute_context && !svm_range_restore_pages(adev, pasid, vmid,
>>> -        node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
>>> +    if (is_compute_context) {
>>> +        /* Unreserve root since svm_range_restore_pages might try to reserve it. */
>>>           amdgpu_bo_unreserve(root);
>>>           amdgpu_bo_unref(&root);
>>> -        return true;
>>> +
>>> +        if (!svm_range_restore_pages(adev, pasid, vmid,
>>> +                         node_id, addr >> PAGE_SHIFT, ts, write_fault))
>>> +            return true;
>>> +
>>> +        /* Double check that the VM still exists. */
>>> +        vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
>>> +        if (!vm)
>>> +            return false;
>>>       }
>>>         addr /= AMDGPU_GPU_PAGE_SIZE;

