Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FCDCD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5F411A652;
	Fri,  5 Jun 2026 09:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JbsThr1k";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1BB611A651;
 Fri,  5 Jun 2026 09:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJUPWdp0OvADMbmhCQeRvvBOapSLioYHwbrgz/EQj/Nb3JXMm07/tYu8MH9RWZt8HEULN1OXjLGVrfJnpng/w7pYs5hqFzNdNz6W3We5G6UvEqCpdN73uWf/Q2oD8A+jO6IXc0jg8fomock178Z4MKsvoN+tGsZg4h7rjvOOugnbw7mULiL1cPJQ/3OvpRyHrSwKmTSIQ0WBQ8Q0jl73IcJxceAzR5sLqwIfzib/3qjQDH2qmGUDm12ZxyionYwNXPvKzzIIiCPWxILtedH8AouXZ2mZ96AMm4unYJ5BB3AVww0pBZTQuZjTfqxb19Hf69UbOuaCODmUTMclUWC8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reckU35fkuycGwnyaWAhjSQbZNv4vY9igvLLx7p9OEM=;
 b=p4PVi5IV9r0tQH7gjsqf7GxVu/OLSWv/fQnF4kva+E5vy9fHYAovfeCHyikHcUGIAnvH8GQsfJy650CLcdFYJdDusrgjXZtXdCm2f0U4xcISVDd7qfeJNspIGVyCn0aCmFjaAgW9kyAZ8SgbJ2wr3miik587E6GvU6W7TSmKEgroR4Z/Z6WuLlti2axGfhNLIYgkTL9qEsnXta+2JX8krewNOy/OXM79GV7fD2nexO8it18BqUjwuO45CP8F8nPS+DYMMp/Ka6h+rewXF/zi4bB70+NSe3ZZ2ch7theIhpGeuQBQwyGdxT4chKRBQMUKwC80+jPbaLaZkhAe8iZ5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reckU35fkuycGwnyaWAhjSQbZNv4vY9igvLLx7p9OEM=;
 b=JbsThr1kujg52QNoHuhPtUmoE/4BFkD3Cw+LDOkMsQwoAO6IMRxs/QS5syykXVJp0e6C72HPds1CVbqroobXi3oDv6yedvDbWtlcjOFB/Z1C4SYhzs6WqCgF183aUV8ZBaX9e75qTbWWQ3YK4X2dI4Scs/MBQpuBHL+JSqXXPZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAWPR12MB999139.namprd12.prod.outlook.com (2603:10b6:806:4e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 5 Jun 2026
 09:32:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:32:10 +0000
Message-ID: <42b82b4f-43ce-4943-bc64-d7386998473c@amd.com>
Date: Fri, 5 Jun 2026 11:32:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: clean up VA state on create failure
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Prike Liang <Prike.Liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260604063943.1412955-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260604063943.1412955-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:208:256::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAWPR12MB999139:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6c26cc-641a-43f3-0b37-08dec2e5514a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6M0g8DDLj3E70U5i2znpLl7S5bnsv7tXtPlv30D2WCJE85HxTUeexYbPPVcizYORBYDV/s9pKcuozMy7gs7G2SE5fasW0kSIkiOwb0hpTBal0I2kEKc/fFTpiK9C71Bh+zobPkUTbykwpvOy1epRou5UAi8PxgRiFkqh2jRSGgX83WTDFpqWth3ti/FHGxdu/xFZxl772lb5NNgmEdleAXER2EMMnc/hjGQ0nYA9YFo2rlhrRtheUVXv5ZGToysCPzLvQuN79LDn/gNxOMJRcjGeUX+iqnJfRTIsBCWiOj3XC6hj7XzGZ40Eb8jAN9Bt0gn0oD2fUiRy8uL2gwXzRqvZUy9tH2GmMbilRhp+kbhsil9S1RxG4XNLGZKGHR6fiJPGyIg/GGHYByzUrPjxIxY6nJpILUDKWx46dZE06W/QkNAJARIB7Kq5PxHh3xvyrXDWcgHGzCsw+0hHjE7A//sUnh5b8eUyuQwBoPp32lOqcR9tZtdpYWnQMMpOElwFgwQktsvtKnTJ+Gwuo25psH3ckCN6wvgUgLRDErkB/NocTaRCreJhuWRyjxChG47XrGTKOodHNxviLSuytof8JJsumYTrBQs9FzyG102tFOfx5m+RhNqCP4rxyRJqADjP6gsaqH06f5F4IygGpGNVxrEosrvA/oZzKudQ87EZ3iabAn0hLPIlnUJOuWPSt0CKsM2zi+p33zUzPFw+L3kXfLhOffb3IiDRfkvDKmNNlWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTFTdzB5RmpLWUxJanF3RElUN3BVdWx5OEwvUGZvWkRJSzQ2R2xaUnhLMWtB?=
 =?utf-8?B?MXN3TUkrSFM4aHVrVjNWY0pSbEZNS1hXd0hGazdoRFZyUGNVL0owNUYwRjhE?=
 =?utf-8?B?M1NnTFpybXhyT2lsTjJ1WGtmN1VYZm9WRUlZVFhPdjUyUXM3YVQyaTdQY1hH?=
 =?utf-8?B?ZUYrSzhselN2eG41ZVkwRVVXOUVSbmFpUGVORStpZDMwdWk5QW5sVUtlRUZ6?=
 =?utf-8?B?M29qWDVRWTFJSnJ5aC9WakR3RVBQLzIzUVZ4VkREZWtucmRNN0JRZUdoOGFu?=
 =?utf-8?B?UzJ1L2x3Y3FqNCs1T0hQTXBpbk4yUjBxakM1TlNub0JGL1FUVElmR2dTYTQ2?=
 =?utf-8?B?YjhBaFkveTBLa2lTUlFGdWMrU1BtU3plRHBBNm9FUUdlY3M5MU52VVB5WnBU?=
 =?utf-8?B?ckJER2JxSHB5SktwZGpHWFExNDZ5K0RGMkR4d1hoYk9iQUlyT3FMTlFDSUZ2?=
 =?utf-8?B?WEI2SHFMcjlJcGxQRWVlWDd1UUZuNDE2K0dtSDd3RG5SeG5RdnhqeFlvREcr?=
 =?utf-8?B?Ynd0U3g1bkNzeXFVSjFSQ2ZMdXhpbjJUQk9zNnE0b3dSZGhtZ0lIak9UaUdM?=
 =?utf-8?B?NVhqN0lxRFB2NE5FcEI0dmNnelROUE11dDlGTUV0bVFFK3ZrYS93a0IxaUZx?=
 =?utf-8?B?TmpaOXg4UGlJb1JmV0tUV3I4ZWZSWEpZdk1melNhOUsvVWE5VVlNSzdMb3ls?=
 =?utf-8?B?M1VrRE4vRWFjVlJtcmpydzRSWm9oSVY3V3IrUW5RTzFqTDl0YzVNNUVkVnFa?=
 =?utf-8?B?cVowdWZOL251SDlFMjF5T1Vad0hsQnc3UGNlVWVWUkM3R2k2dlIzK3VBamR6?=
 =?utf-8?B?U2Q1UFc3bE5GaVo3K2o5NS9TZGNIaXN2QlYrcFFabmF0eStKaG1NaG9ORFpX?=
 =?utf-8?B?UGdTNnd4NXZ0MENiUUlnc044WnpxWmswaWh3bUxCTDV5enMza0d5OVVrRG5h?=
 =?utf-8?B?WmNRSGVqUkdLMklCWGVUK1NBSFFabERqN3pIdERHejcwMWtZM0Z5L1dsazZS?=
 =?utf-8?B?SVlwa0ZmalVjTytVNUx2TFJMZ1pOMVF6eXZEOE9HMDJLU3FzaWVsaGpJeTVK?=
 =?utf-8?B?SzhLYXkydXZYWFZTV0d0cm11dXJVVlplc0I1cFZ6OEdKcHEzd3pKb1B2TldZ?=
 =?utf-8?B?RnpFdTV2T1oyVHFSUFpLNlpsOU1icllPaFVVTFNTL0lqUTlIaldlNmowSUhG?=
 =?utf-8?B?Tm9FOWliNk8wSDVsdUFTUFBuQ0h2cnhIRmNCRXczWllKMzdFdk4rUmsrTVdY?=
 =?utf-8?B?SmR4amtqK3VGQlB1UWNoU2Q0TEVpUVBkRDJsV1VMYVFmSGNxY1VJa3VqbGRm?=
 =?utf-8?B?cmJFeTJqajZKZXZKc2xvWThHeXBoazVNZVVwWExqWjZ4WHhJVmp6dHE3UFBY?=
 =?utf-8?B?N3BVcVpHVUxleFFlMjY0RmpzUUhuTzNnbVA5bEs0QzVsS1hZcXBYWmtHKzNy?=
 =?utf-8?B?YlJHK053c3FOS1YwN3NHZVN3RHdxWEdHN3BXYUZWUmlwSjVZZVA5UG5DcHN2?=
 =?utf-8?B?Unk3MnlOdUlqRGh0MTQxWGtlQmJ2K3laTjRuSS9nZkJuTHcvZU5WOHlPbU5I?=
 =?utf-8?B?VnBodys0SXBrNncwTGNFcjcwaEE5Tkx4ZGV6ZGVUTXZLNVpUanF2Y0oxWGN3?=
 =?utf-8?B?SVFCb0pUaWh4VGNVbHYwZjFmWHNkSEFVVWtOU01UdjhkMWd3cnM3N0dLVUpT?=
 =?utf-8?B?OEpZZkVGYlQ0NlFHOGdROE4xUkxNQ3lLdkZiUDhOcmg2Rzl6OG1IYldhNHNv?=
 =?utf-8?B?a0N1Z1dKblM3Q3VWdXVWMlZwaGVNRkZHSU1HTklPM0NLMmYrWHdEVkFYT2tP?=
 =?utf-8?B?VjQ5OGRnNElwaXNCSFM2YkNwY2M4WmNUNkJUcWx2NkhsbnRHeCtQOHB4N09S?=
 =?utf-8?B?dkNiR3lxN21maGR5dk9ZdS82SjdqZC9odldvY28zaFBlYyt0aE1Wc0lsVDR3?=
 =?utf-8?B?SmF6WitUblNFakZvMWhuaHFxdUpnLzkwR25icGZYNkFGajY2S0djZER1emNO?=
 =?utf-8?B?V3R4clNvYXBuZmdOOU4rcUpSYVRtc0pOSDJOWFYwU2JiTnV5K1RQT3l2NEFO?=
 =?utf-8?B?aGlIMUZyb3FLeFRDZlJmSENIZ2k4NGN1RzMwR2JXWDZIRVptT0EzVlJVOHZK?=
 =?utf-8?B?MFF5aEdWdisrOW5KUVNvcTNUUFZSSnlEdkl6N0dQUnhQeDUzVGtMYTFFR2NR?=
 =?utf-8?B?MXVqS1VqQ2N0d3l2QXNKM2ovNkVVT2h5cURtUXdVU2FCaWlNTzVhNEJhSEMz?=
 =?utf-8?B?OERqS09oZm81dXdqMkJzMUpHZWg4SkM0MklPWFpRWnVTSGJkY2JUbFl6THpL?=
 =?utf-8?Q?pnoLtZw8HC09Ph/tYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6c26cc-641a-43f3-0b37-08dec2e5514a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:32:10.5465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T87njxTu4XSD6+1shD2C32Lx8mYpCzOfCt/T3lNu/IR9GaiJ8+IGztaZALRAsaBg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999139
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

On 6/4/26 08:39, Guangshuo Li wrote:
> amdgpu_userq_input_va_validate() is not a side-effect-free validator.
> When it succeeds, it allocates a VA cursor, links it on
> queue->userq_va_list and marks the corresponding bo_va as userq mapped.

That was already removed, you are looking at outdated code.

Regards,
Christian.

> 
> The user queue create path validates queue_va, rptr_va and wptr_va with a
> short-circuit OR expression. If an earlier validation succeeds and a
> later validation fails, the error path frees the queue directly. The VA
> cursor added by the successful validation is leaked and
> bo_va->userq_va_mapped remains set even though no user queue was created.
> 
> The same stale VA tracking state can also survive later create failures
> after all VA validations have succeeded, because those paths also free
> the queue without unwinding queue->userq_va_list.
> 
> Route the create error paths through common unwind labels and call
> amdgpu_userq_buffer_vas_list_cleanup() before freeing the queue. This
> releases any VA cursors added during validation and clears the stale
> userq VA mapping state.
> 
> Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 32 +++++++++++------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0a1b93259887..dba0f786ae4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -826,17 +826,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
> @@ -844,15 +842,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
>                 amdgpu_userq_fence_driver_free(queue);
> -               kfree(queue);
> -               goto unlock;
> +               goto free_queue;
>         }
> 
>         /* drop this refcount during queue destroy */
> @@ -862,21 +859,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>         down_read(&adev->reset_domain->sem);
>         r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
>         if (r) {
> -               kfree(queue);
>                 up_read(&adev->reset_domain->sem);
> -               goto unlock;
> +               goto free_queue;
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
> +               goto free_queue;
>         }
>         up_read(&adev->reset_domain->sem);
> 
> @@ -892,10 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>                 if (r) {
>                         drm_file_err(uq_mgr->file, "Failed to map Queue\n");
>                         xa_erase(&uq_mgr->userq_xa, qid);
> -                       amdgpu_userq_fence_driver_free(queue);
> -                       uq_funcs->mqd_destroy(queue);
> -                       kfree(queue);
> -                       goto unlock;
> +                       goto free_queue;
>                 }
>         }
> 
> @@ -915,7 +905,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
> 
>         args->out.queue_id = qid;
>         atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> +       goto unlock;
> 
> +free_mqd:
> +       uq_funcs->mqd_destroy(queue);
> +free_fence_driver:
> +       amdgpu_userq_fence_driver_free(queue);
> +free_queue:
> +       amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> +       kfree(queue);
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> 
> --
> 2.43.0
> 

