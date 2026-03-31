Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC88DFF60ED
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2235B10E938;
	Tue, 31 Mar 2026 08:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DjdRxOzY";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1B510E938;
 Tue, 31 Mar 2026 08:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1UrMPQ6K96xH+feUbYfJp07N92cbgzFYL6U5QPU4UG3jvmhYqCqeTtEp+iOs2YrhHlStTdRVNHWQwmZWdPTvPGiytns79fLdGHkPpX80P72wmjxa/XZJjY+SZYCtMcnJThlcQlAKlpAbH98ycjs/BVLxIJlWw+jyJGh3sEnctN3YNki8/sTgzSElk6Pm/EOH9vJgtm4CHlRfA4Fo9EP47y7fkGAOMLormzQCJqNcYCVI0TkofBjLpOlXeCoEFO9SrTRstosBbpw5ekSz46TIBL3NwpkvQSZiEKIAO0pjTmiBofUCp9u82tgLK2Yfj8VrIiJVq0YanQOZtvPSHGwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIudCDIyXcdgMqWNHfD9RrjHea3rCa3wjkTIgi3tX+0=;
 b=mpjnbdUJpYCYoeA8+Ixz+h1H2ylPyWlidNbjqzwcG9VWf8CkcFu1QKujigBKcE4YRnB9LYP8jpYFyKoNFM496cpiD4Z0HfHh6KJ4sLfrKPpRqgwWvzQ1cTT/ZmYJwdZUoMGi8UaJ+ymK22l0Z7WPCSUMTgZa4LTKtRGnDQyAhKRPv+NcgOLB7kUnG76JFMnlEMYGCvyqGITC0k+kEFCQN/HeBDdqxt+y5YB1TpdjYAVRoDv9lreVz7b4S/Y2Ma98d8Nsi6IieF48pnnykwT48E05v7VjBISml0eZmhYM2fOnemYwH8edQsQSazJ8+hDTkOth7EsswCAC+9nznF2NOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIudCDIyXcdgMqWNHfD9RrjHea3rCa3wjkTIgi3tX+0=;
 b=DjdRxOzYXrW6gcid9OZlFk/jdvFP4dk+llye4wiBCHV54Ca0JqdzQlz3fuHr7z23h3fh5jEBYU2hv9M5GrVQHjyk7gYqVXuaQ/l7vT8PkmWH/xpr/ZTqOaI3MtF/kMOOqdlPTltMBA8XWHEVXir25PIt5NkI5IG8J6/XmnYoBSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:41:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:41:25 +0000
Message-ID: <d229bcbf-dbdb-4e6d-bb81-0aa40d96d406@amd.com>
Date: Tue, 31 Mar 2026 10:41:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix resource leaks in userqueue creation
 error paths
To: David Baum <davidbaum461@gmail.com>, alexdeucher@gmail.com,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260328021614.20100-1-davidbaum461@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260328021614.20100-1-davidbaum461@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:208:23d::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: f17ab27b-3197-4793-d037-08de8f014b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: VvZpnLNxUtBhJlGe4aB0QJ8ZERwGRFC5ANiHMJN33rz7FMIFJQ4bhinykLRhE9kNz0PPX4wSEvPhNu5vRcp83hd+0B+eKsX5UZNz7H/dBh6+mwnBpm8g4FzmGSC232b34wzc5mSghIrKtK5OIwvcPYVV6D4ueYNOrZwbB5TbsYejPGnaie0faU2WgnS3NSP+j+RNQdUicyZ7q8Rj47NTTZfJHzFYRwp3edr1mqUCUgZxXYCMNB/4v4ISnsF1IyTlxL5R/QtzR1BrNL55Qnei9gMdKnv6AYpcg2AdbEQw+woHXzBXmzgw3qpU44MD6cm1zWyaokwaisDI4hIWJkVJkBFTka2e0p7QIslj8bcRwFfezZO7hNvkDIzH7ke8ubkqQltay3RpzwZ1xwJ5xxenrtInOEf1u1ImU8ydg48uN408769Ijw7dIpeCJGUpiyqNFHCgYP2wIXuPFpUX/osL/VS1yb1fwdi4JlcpCC0e4ukp4uJAe+KJszKXXJUmyKTYHKvvbHC6bIRMFaw4p7WMYL0BquiJp8U1w1M/xQmG0EpJMAFlXobWjwwnfG5OJIvtBBjSGWcTWkmIcZL97yLNPE95MU9vsmad55sKHc98+Jm63BWiZMFaJ6okvBagQKGj/tXjI8inOtht3jUtvf1UiGHHsrOdi96+F4Bn05uh/bpOFNJNBrYCWsiQrhDodpCfpnPqpasa4WcDUydw1ylKmVVtgZwahlwtxTTA21abTqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmhPaG84NHFDNHBvYWxDOEF6REd6Y2NsS2F5MU1oM01aRUhNVWJSazNSUmpR?=
 =?utf-8?B?emRkcXNYOERFTVU1QzR1UWViZ1A3S3U2WW9PZkVPdlA2YWFnYTg4eEpzQmxx?=
 =?utf-8?B?NHVZcUpwYTFHcldXbmtFWThIdzMvMGF5ODEvUzVVMXZXTG9iWkZlUzYvY29J?=
 =?utf-8?B?SlZDT2p5VldVMXh0TkM2S2g3UjVFaW8vWDBaL09tdktRV0ZoSHVJUVI3MmxQ?=
 =?utf-8?B?TmFPRzhNanRWWUlZUDhkSlgzY2IvRXlhTEtaMjdJZ0V6cU51VkhOdzcwc2xC?=
 =?utf-8?B?YUJPSkN5SXUyeTdWMzlGdjVDUVA3LzZrZ3ZQQXMvNElFeWVMaUtiL1BoWUVh?=
 =?utf-8?B?enFLcXQ3T0lzajJLZ2x3U3ZVWkY2Ung5Y1dxenFEVDhYYURyL043NDRlMDdH?=
 =?utf-8?B?blFRcndkeU1ZRWV1TG0zSkV2NWtlZUlidEc4SFhraHBpdzNNMzZzUzNDQkdp?=
 =?utf-8?B?Y3dQbVpBQ1MvdE5jaFVrRDY1ZERDQk11UGYzMkVyWmd2c2lhRWFFbkkrSEhq?=
 =?utf-8?B?ZHlManVhbE11cHh3VWpoRnp3Qk1WVEdTZFE1U08rYzNsdS9jZVFPMXZoVG5C?=
 =?utf-8?B?aDdWckR2QXdmU1cwS2NKTE90NHV2YkRmMUgwSEErVjNKYXZOb1lHM01XUS9Y?=
 =?utf-8?B?YUwyUTNsdjN6TmNiRUlaVFpqZDMwTFUyd1cxYnJmSkhVY1oyWWphNXJ1Nkla?=
 =?utf-8?B?OW8wRUh3dUZyVEtPZ1RmQjYzOEdUVFR3OHN3WjQ5WnFOWllWSFJRUVl0eXNP?=
 =?utf-8?B?Uk82aVBjRzlTeDA5U0hzLzh5QThUR2JPTkNnc1Z2dTBhdUhuRlFkb292eEdv?=
 =?utf-8?B?N09xaElnakYyY2lKbzRjOGJlYXFsMEFZNHV3VlBzdkNLaDc5cVhsMEFlWURM?=
 =?utf-8?B?d1BGRGQyOUhLRzdzWDBSWUZmS2dwMHJzMUt1L09GUlhZdDdINThEWGYycjB4?=
 =?utf-8?B?eENsSVByUEFuK2dCUFQrR2JYUXZzZEhBRXRTc1JKcGVtT2ZqK2JPSGxxTW10?=
 =?utf-8?B?T2N1VjF6ak4yYm1YL2NHM054N0dJT1pUYXF1aDJLa1lCSTFueWc0REJrWG5N?=
 =?utf-8?B?SDd3SUY5VWlBSHJFdjQ5MldEeExqZWNKMDAzMjVmT3VmdDV1cTBhYThaRXNR?=
 =?utf-8?B?QVVEL0NQSUtteUFKdFk0RXZiNktXNFZRS2FXdW5EZklDd0lyMWRLekx1RmR0?=
 =?utf-8?B?eHJhMEZXWGJUVlYva3RoSTRCRXJ1ZEl2TFYxcFE0N0ZGeFJrTXVHWUhOTHkw?=
 =?utf-8?B?ZlZKMUQvc1B4YVZOcFJvY1JDaHk0VFU0ZW1oaUpxcThPY3ZVQzZnNG82VUl6?=
 =?utf-8?B?NUVMNnNHb285UFBQUmFlbm04aW82c3hTNEZNZ1BnK2UzbUp0eXJERDdXekVH?=
 =?utf-8?B?M1V6ejFwcWJuSGJ0cjVWNWMvRGZ0SzJjV294Qi95cml2MHJJbUcxZ3d2UTRy?=
 =?utf-8?B?SFZhVXBQQmdYYzdoMnRaRUJXb2Z2eUJYY214dUpEVnllSTBISDc4MEZwWXgr?=
 =?utf-8?B?M1pqVVQ0NFlBSGQ2NGhWelN4dk1BZGtyWi9ERHhlaXlnekxZYkRQb2dqYmd2?=
 =?utf-8?B?bmNneVMzUlkwK2FPb3FSVmZ3U01MUjlMRVZ5KzVhcm9NQUIzK0RZUWJSZ0Vv?=
 =?utf-8?B?UFdvOFM4akZZbk9vbnpNaUhpc05yMnZiTzZyRW1td213M1ppem5wVW9BblA1?=
 =?utf-8?B?UUNQYS9pUXlqM2MvOHlNSHFNUjFiTEpscEpRQ05NQ2NZZ0R5RmtsR3dyNitm?=
 =?utf-8?B?T0R3a2drSmFaNExKUGxNMHFXREVrc1YwbVVDZWYybU5OOG96Tm9MRGduUG42?=
 =?utf-8?B?dm8vUjJ5Wm9uempNWDlFOUpaZ1l4MzBld3ZNaitUTXBtVmQ2NHpVWEJuQ3VQ?=
 =?utf-8?B?LzhlTG1oMmJhY3JsUFRNenNsanAzcVBLY3BtWDUrUldHYXBwVXc3UWJXeG1p?=
 =?utf-8?B?Qm04WGk5Um50eUQzdjN2djVmNFA1OVJjRmVaVEhCNnRuNjkzLzhVcEE3YkRQ?=
 =?utf-8?B?S3NHY2xQTVcxdXJ0QzFoNXIwenBzNlpjazNMU3lTM0x3TUd6TExyZWpYWWtp?=
 =?utf-8?B?M3dPaHZta0Q0ZGgzOXF0andFajllVnk3dURVbmxkRi9PYzFJbHUyU0ZEUXhF?=
 =?utf-8?B?cWlrekRGRDEwdWtsUGozNm1vYnl4WVlvcHRSbDE2L2sveGNzRmVES2lGdWZZ?=
 =?utf-8?B?Nk5TY1VQb1NwcWVrck5FY1BSSmRnbnpEaFJFZWxjUlVHMjVVMEtFNDNxWFg3?=
 =?utf-8?B?Qkg2ZjRHd2Q3aUFQQTY0TWoxMWdjenVPNDR5cWkzbnROQmYxc2dwUU8zMUg2?=
 =?utf-8?Q?S/vHWFJdNG7O57O9jl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17ab27b-3197-4793-d037-08de8f014b6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:41:25.8205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddCoGTpgqUMCfPsvSJ7scQ8l7pxfKdcbF4RdL6npnXlp4ThJPVeCIlZ4QZrrFAAi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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

On 3/28/26 03:16, David Baum wrote:
> amdgpu_userq_create() has multiple error paths that jump directly to the
> 'unlock' label, which only releases the mutex. This leaks resources that
> were allocated earlier in the function:
> 
> - When amdgpu_userq_fence_driver_alloc() fails, the queue struct,
>   doorbell BO, and VA list entries are leaked.
> - When xa_store_irq() fails, the MQD and fence driver are leaked
>   in addition to the queue struct.
> - When kasprintf() fails for the queue debug name, the entire queue
>   with all its resources (xa entry, MQD, fence driver, queue struct)
>   is leaked.
> 
> Fix this by adding cleanup labels in reverse allocation order
> (erase_xa, destroy_mqd, free_fence_driver, free_queue) before the
> existing unlock label, and routing each error path to the correct
> label that matches the resources allocated up to that point.

Sunil can you take a look at that?

Thanks,
Christian.

> 
> Signed-off-by: David Baum <davidbaum461@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 +++++++++++------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 7c4503508..93c44798c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -819,17 +819,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>             amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
>             amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
>                 r = -EINVAL;
> -               kfree(queue);
> -               goto unlock;
> +               goto free_queue;
>         }
> 
>         /* Convert relative doorbell offset into absolute doorbell index */
>         index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
>         if (index == (uint64_t)-EINVAL) {
>                 drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
> -               kfree(queue);
>                 r = -EINVAL;
> -               goto unlock;
> +               goto free_queue;
>         }
> 
>         queue->doorbell_index = index;
> @@ -837,15 +835,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>         r = amdgpu_userq_fence_driver_alloc(adev, queue);
>         if (r) {
>                 drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
> -               goto unlock;
> +               goto free_queue;
>         }
> 
>         r = uq_funcs->mqd_create(queue, &args->in);
>         if (r) {
>                 drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> -               amdgpu_userq_fence_driver_free(queue);
> -               kfree(queue);
> -               goto unlock;
> +               goto free_fence_driver;
>         }
> 
>         /* drop this refcount during queue destroy */
> @@ -855,21 +851,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>         down_read(&adev->reset_domain->sem);
>         r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
>         if (r) {
> -               kfree(queue);
>                 up_read(&adev->reset_domain->sem);
> -               goto unlock;
> +               goto destroy_mqd;
>         }
> 
>         r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
>                      XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
>         if (r) {
>                 drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
> -               amdgpu_userq_fence_driver_free(queue);
> -               uq_funcs->mqd_destroy(queue);
> -               kfree(queue);
>                 r = -ENOMEM;
>                 up_read(&adev->reset_domain->sem);
> -               goto unlock;
> +               goto destroy_mqd;
>         }
>         up_read(&adev->reset_domain->sem);
> 
> @@ -884,18 +876,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>                 r = amdgpu_userq_map_helper(queue);
>                 if (r) {
>                         drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> -                       xa_erase(&uq_mgr->userq_xa, qid);
> -                       amdgpu_userq_fence_driver_free(queue);
> -                       uq_funcs->mqd_destroy(queue);
> -                       kfree(queue);
> -                       goto unlock;
> +                       goto erase_xa;
>                 }
>         }
> 
>         queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
>         if (!queue_name) {
>                 r = -ENOMEM;
> -               goto unlock;
> +               goto erase_xa;
>         }
> 
>  #if defined(CONFIG_DEBUG_FS)
> @@ -908,7 +896,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
> 
>         args->out.queue_id = qid;
>         atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +       goto unlock;
> 
> +erase_xa:
> +       xa_erase_irq(&uq_mgr->userq_xa, qid);
> +destroy_mqd:
> +       uq_funcs->mqd_destroy(queue);
> +free_fence_driver:
> +       amdgpu_userq_fence_driver_free(queue);
> +free_queue:
> +       kfree(queue);
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> 
> --
> 2.50.1 (Apple Git-155)
> 

