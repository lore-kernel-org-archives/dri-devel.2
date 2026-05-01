Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD9FCD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 16:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E801310E1E4;
	Fri,  1 May 2026 16:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pfx2SMgP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1B910E1E4;
 Fri,  1 May 2026 16:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtlNnzD0aPzfFKV7OlN6HnaPJ59uGnRPBHv7T5sPYUp2RCqGEr3ZURtCX9CpYsbG4pZy1iPE+OJhabfOfcNONOXEULcdr6qovABkU2HLsPBVoS2enUksRdjs1AV/pof9SAfGEUmZhSvHijuVIkFBwK+g7Vq8PaZuPTz6MW23WmNQhc+AXt+2XD+udVZuQB1pRt2gyukLp+iKLr+givgRMMPk59MeXW94/pUXYN92ICbNbBKwmkaQ7kAq3L7hnUS8ulRidSlfRELZj5w/9hXqkzkBEehTqiDFxIu03JM79W90vSo9EkMHioqLaAXycXI01P0HZRAzLOQco4zIiXf6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7ZD0odp0ca/Hli8q7PK6SdPjGhsxnT7kh4N+uwa3lI=;
 b=vwsLMyt9CsmE7WzZ1MoHdnUZ/EugU+h1HaPaO+RVw5F+0uuvH5iR9ANS/HvQ8ZPG+V8x37SrYtSAxkQ5gkJIPPyMeF2ThhT4ibvupzxW5aoK+Im2LpumoBeuXyJodzUPuTKv44hcsD0TSUOKSEqyxMoR+vGyyRW3aSB/NK7ZJiPYC1Ni4AAz/ZMYZdinJ716+UZvHCsUHP1BMaWHifrzSUTET4/0g7jVz/Ok223LnVnQF7t24pUoUn16IVnQvsLhINs64815NrkOurcTYaHqFeV+g8+NBw02HHkcRG5JOAafZp+WXh6ApTr40afA8IwDhDwyG6f+zQD+azX5IqFldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7ZD0odp0ca/Hli8q7PK6SdPjGhsxnT7kh4N+uwa3lI=;
 b=Pfx2SMgPHSORGwKlCES5YHqB29f5dL+ZkCHJI8QqqDtIe4/HXLWOXIatix6SHBinsrJW5zIkoCWVftgzsfbzJTGgKlPHeaqPmtYIpWbrjh1Rm6XzhdFlyUHMOxVpKAIXpZjSGuKRMPRfwi3+cHs5bxAsB52Fx8xX//77R+dB38g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Fri, 1 May
 2026 16:03:56 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%5]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 16:03:56 +0000
Message-ID: <8c3d52b7-6020-4905-9ef6-d141798b4caa@amd.com>
Date: Fri, 1 May 2026 12:03:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 8/9] drm/amd/display: Check actual state during
 commit_tail
To: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-9-harry.wentland@amd.com>
 <b0e0af19-a7c4-483c-8e40-4ec1cae01b9b@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <b0e0af19-a7c4-483c-8e40-4ec1cae01b9b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::12) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 850fda07-94d2-470e-737e-08dea79b3f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 6jGa7LaI2bekop/ImmtcXKVTsrJHY3El411cPJCq/t7Z6FyBbI6w3lS5tv/lUJXbYchnPjrVvt1qNaLQxtYlPVcLJIgsDJnzRxgCEt+T+U5l+Zap6u9c6JAKNtj5uy+in5wdfLBvfeNd+Ic1XcM+19YKqZh83iBIbmZ7aTj7Ta5f+iBpA+VYb3YW8L1kgnV9yHCf+q2MrwAwDgS9FykAgUxBmZQSeknLGdVzV0XS5Pwtu5qbWsq/6cxvf2SD0dSfEuTT4uv4k4c8n73BTqk2Y9BpgSXoqj6pWoNyYpjShQdK41j3r/uHDnG2dbmXLRlq+mNFR1Cqivt6qKTftRz2dw0Oi21+ZtTvNu8sjL/hiPnVULiJGNWo1KUgx4CXkogZhtbSy4hWNmwK9pkYiDq/0nJFyRtieL1IPeE5xpVXS632iF8XyMCkNekhv+oq+O/77m4KaCkD9VYQd8OW3T+o+3XC49lguBtQBmo/ksKTQhkjCuFkPDFxkk2PM0LwKMXR1uF86RyP8nb8BMR9ztL1AlhRb1qJkVqJDpAdnsnCpvwQcM76+p6rQx2wvD6ScfVMmZmaZ16UzFkOHbpLicVp/t4aJckggffA8UnS0G/RAEaTcZrvsi70Mv8hWS8E5cI6ghiLqG3/RxIDcmUNR/sit0Zg72ho4REJEDq9RXGjcEVYcBsw198agT+vEg1GMPM9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REkzK3ByWUlGU3hDZmlVdnlOVXNBLzF0czlpb0l5alpjSUh0d0VLTnJCK1Fk?=
 =?utf-8?B?QVBLVnZYVGxHY3N4OHZRVy8xdTcxNTZQc0hOSTdhekdUZGw1NTZqZ2NsRlIx?=
 =?utf-8?B?cTBvVUgxdWhoUysxNC9iNHhuQm1nUFQrQU96UjdRYTVvck5lbGdCbUVoL21w?=
 =?utf-8?B?UHoyOWkyeVJRZ0R2QmpjRmkxWDhhd1lQdzBJSUg4ZmhhMXVNL2djTHFGQWRB?=
 =?utf-8?B?VWNNSWRHaVpLZHlVVktzODJlcG02WXZSU3luUHlDdVM2aXgvd0VRKzhiNG5Y?=
 =?utf-8?B?bzJrLzZ2ZjdHR2doNVFLMWdoYUNkNHBIUEJZRmNqdHpNME5sakttbnllN2NM?=
 =?utf-8?B?U01Jd25sQ08vZHlFdjJiS2pyRWxjSHJOOWM1emdtSTRwK3ZSWkZ0NEVGSXU2?=
 =?utf-8?B?bjEwTTkvdDZZSWl4Z2taSWs5bXdhUHl6NnpSVUtMSWpZNHh5T1lsVzFCRGht?=
 =?utf-8?B?NXBiSGZYcmxuRDBla25Ibm84aVFNOEhyUFpEWjdQSUhWRkcraWFHL2R4RGND?=
 =?utf-8?B?OHI2c1Jja3lVVFJBUFRodFNtb2pmVEFjbHlYWjlCVzg5T3RUQkJDOWZwNXBT?=
 =?utf-8?B?anJ5R1dMSlRjZ0F1aGxHSmJtQTFVZzg5cjJBMTdhMk43OWxqNmFNcHlzalFP?=
 =?utf-8?B?aEZXazZrQ3hLamtkS250WkVwK0taWGFGWHU0aUJvSGo1dzNQMm1nVk1JaldI?=
 =?utf-8?B?dTIzUFJ6MVZ6R0xPamMvWTBHNmZaa1ZGRllyTnhna0hSZnVMczZLdnRPQmt1?=
 =?utf-8?B?bEFqU0syTkFTMWNROVZwdzF3OHNFNjVDNEtOSWN1VXlJRS9uS0o1K0dKRlZS?=
 =?utf-8?B?YUhiMTQxOEtKcTVGa2RyYW0rKzVlU2JLVWthb285RGxZTnVoa0s4MDExbmh3?=
 =?utf-8?B?eE5SditQaVhTOUtiQmhjaDRSL2JwbFF6VTliOGU0UjJVNFBiUytST0hTQ09k?=
 =?utf-8?B?RXZ2VElmNGdjTnQvRkMvcDJKMWNoSlhIVTZiY056aFduVGF6V0p1Tm04bkM5?=
 =?utf-8?B?WlBQcXVUcFNJekNudHhHV2tWQXE3Nk05T2hQRldvdm8xdnJIZDFNeEFtRXpF?=
 =?utf-8?B?dmFzUXpvUktOSGc5VnJ0SC9qenRHQ21YYlJYU0Y5eDVmUytCR0xkUW9ZQ0t4?=
 =?utf-8?B?bWRlU0ZWaWhNYjhkRkxOMjUxUjdCSWhaYnJJNC9na3N0RGs2L0lWY3lSaUJw?=
 =?utf-8?B?OGdObXA3SFA2bHVUaUlidEhqc2lLMXBXc3pDSmRZREE5MUpEbGdoYXdMQjlO?=
 =?utf-8?B?ZFp2Snp0MTRubGl5STFaN2dyQ0l1L3h4OE1iUE5hN2REUi9rTlFWQXpXTXB3?=
 =?utf-8?B?Y2tYSmh3cVdWVGp6bkd0eTdvR0RLUmVaNkZQdVhBayswVFBTdUQ5UjdzRVM0?=
 =?utf-8?B?ZGJZUzdwMjlhRkNTNDJmWUFTb2hoUVNFY1BzMkFWUEovSXhXbUVrL1JsdWpn?=
 =?utf-8?B?UXNWN1laR2Iwb1huenJBMkpiUCtxWnpreGJFbEVkNDQ0OGZXSDBmMnJVM1RQ?=
 =?utf-8?B?dmxUWEhtTVVHT1pmdzAwdzdaR1RnOWRpdVNxSGd0eXFOKzVWRGU2QWs2VlRi?=
 =?utf-8?B?RFZ5ay81ZG9KSzBHcVVDemtUYkZlby9OclR4U0p4Mnp2ajZ5ZHdHU0xQMjBE?=
 =?utf-8?B?aTRIWjdnb0liQ1lRMVliWk5IV2xNOVVRMlF5ckc0d1JXRmhxdnhnbzZvTVla?=
 =?utf-8?B?TEVOUWpaMFUvdDNLcGRjNjc5U0RTQXdKbkIwMTBnQ20wMjZhbHppVWhQZjh4?=
 =?utf-8?B?NkFiQnUyV252ZDdkRlV4K1BJZUVmWlUxRUZabFQ3NXlhTlNFL0xSK3ptcWdO?=
 =?utf-8?B?S2UrVWh3Y09OVkZoajRMR1NBVWR6N2w2RjJReDRjaDFJZU1hVm52UjlPaUJL?=
 =?utf-8?B?UU4vS2Nzd25uUkZjbVlyb044eS9MYWttZmJSREJPS0VPYkxzQW8rd1Jvekkr?=
 =?utf-8?B?UzQwV1JYalhLa1JIbEJtWDNyWk9vVytUWGRIVmt1a2RENkpPNWdjWTFNejRC?=
 =?utf-8?B?NDJJcVl6ak9Tc0h0ZGM1UG4vUjQxUnd1MDBHZmxUYlRueXdlSVlQeTQ1NS85?=
 =?utf-8?B?a083YjZvM3pHWmFHaGxHRWZZY0xHdFY0YXZtekgxRFUzanlRSmtZdXRvVWtm?=
 =?utf-8?B?b0tFMGc0cldPTFVURFl5Y3lJbU16bzh0M0V5Q0tVT3hWeHZZMUxTdGR6VWZZ?=
 =?utf-8?B?VGRHRlcwYzlDMW1ZVnFzZlREQ01rcGZobWhKOG5ucGJra0p4ci9tRG1oWHo0?=
 =?utf-8?B?RzVGU1ZJait5d2VYdlAwc0p3eUdCdTFDLzFtMFpYTUZ2TlRZWHAwclNxWmtD?=
 =?utf-8?B?SW9YVHk4VDBMUHp0ZjdEZSs1b2d1cDhMNXdRMEhmTnlsMVFxeHAydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850fda07-94d2-470e-737e-08dea79b3f7b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 16:03:56.1534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnG+NDZSGQ2JsnSpjr6BWg3hOjFA49iH8+pTdn7W5nAH6XeYy9el05zaWyMm8XnIL96bLXZPL2kftIAcubO7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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



On 2026-04-21 17:12, Alex Hung wrote:
> 
> 
> On 3/30/26 09:34, Harry Wentland wrote:
>> Previously we checked the plane_state->state's plane_color_pipeline
>> client config when determining whether fill_plane_color_attributes
>> should run, i.e., whether we had a plane color pipeline and should
>> use that code for handling CSC properties, or whether we should
>> look at legacy plane encoding and range.
>>
>> The problem is that we also call this during commit_tail, during
>> which plane_state doesn't have the state backpointer. This meant
>> that during commit_tail we'd look at the legacy plane COLOR_RANGE
>> and COLOR_ENCODING values and overwrite what we pulled from the
>> CSC colorop in atomic_check previously.
> 
> A nitpick - should this patch be squashed into earlier patch to address the problem earlier?
> 

That previous patch was merged with the initial color pipeline
patchset. The problem only became apparent now when enabling
YUV content.

> But that's not a real problem since the entire patchset will be merged together.
> 
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> 

Thanks,
Harry

>>
>> Instead pass the drm_atomic_state in explicitly and check that.
>>
>> Co-developed by Claude Sonnet 4.5.
>>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index a0d4ab4590e1..c3c6211d15cd 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -6006,7 +6006,8 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
>>   };
>>     static int
>> -fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>> +fill_plane_color_attributes(struct drm_atomic_state *state,
>> +                const struct drm_plane_state *plane_state,
>>                   const enum surface_pixel_format format,
>>                   enum dc_color_space *color_space)
>>   {
>> @@ -6015,7 +6016,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>>       *color_space = COLOR_SPACE_SRGB;
>>         /* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
>> -    if (plane_state->state && plane_state->state->plane_color_pipeline)
>> +    if (state && state->plane_color_pipeline)
>>           return 0;
>>         /* DRM color properties only affect non-RGB formats. */
>> @@ -6055,6 +6056,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>>     static int
>>   fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>> +                struct drm_atomic_state *state,
>>                   const struct drm_plane_state *plane_state,
>>                   const u64 tiling_flags,
>>                   struct dc_plane_info *plane_info,
>> @@ -6148,7 +6150,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>>         plane_info->layer_index = plane_state->normalized_zpos;
>>   -    ret = fill_plane_color_attributes(plane_state, plane_info->format,
>> +    ret = fill_plane_color_attributes(state, plane_state, plane_info->format,
>>                         &plane_info->color_space);
>>       if (ret)
>>           return ret;
>> @@ -6189,7 +6191,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>>       dc_plane_state->clip_rect = scaling_info.clip_rect;
>>       dc_plane_state->scaling_quality = scaling_info.scaling_quality;
>>   -    ret = fill_dc_plane_info_and_addr(adev, plane_state,
>> +    ret = fill_dc_plane_info_and_addr(adev, plane_state->state, plane_state,
>>                         afb->tiling_flags,
>>                         &plane_info,
>>                         &dc_plane_state->address,
>> @@ -9984,7 +9986,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>           }
>>             fill_dc_plane_info_and_addr(
>> -            dm->adev, new_plane_state,
>> +            dm->adev, state, new_plane_state,
>>               afb->tiling_flags,
>>               &bundle->plane_infos[planes_count],
>>               &bundle->flip_addrs[planes_count].address,
> 

