Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C4CEDB7DF
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC2410E3A1;
	Tue,  7 Apr 2026 10:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BClBglEF";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010037.outbound.protection.outlook.com
 [52.101.193.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3D710E3A1;
 Tue,  7 Apr 2026 10:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orhEkqpB7LQxKLf4dZAi7z0UnLwVDdcbKr6AW3fh2/yzDEOl3YCidiQe15l4ifBbV0/g+5aSUSZyC0zbbGRIF8g46pHYfoK/3Bz810MxXf/6+tukU87yJCMoRjiE/ja4/oeEqoGS0F+ldIx4yiuwuws42ZxZj0ZF6wigNM0hUpPL0D6oJ4K6p7iegawiEfRu7i7H0bKvdAMDVKtSyH9KpLJDOX6AohDGXNomTe/Vu5bZac5wV8k7ckEJC23d2k2oeSguQWRxLTSEr5Iv6e0hlD0oQwXrvtB2GHbQcQeTK+QkQBmwyG5Ss5vnLu08ZI4HaIvMULTvjFOaA7WqDSLmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqyocgFGB8cfDRZO+tevzWa1t3868E3ymFsodkGidzY=;
 b=Mvvtl2HtDqhgZf5kusdCy45Rrj61YoAUcOXQRJjWZHOtjlhwwc4TLRIDwoXOXMi7vdPgxvIAR+D+FYPNdQiPq+dXPHJqRAcX+wAZ6VTGzQcuxBoN81Gq0KpyATp8cgdL0ynGSx5vvz5Va+ekDDO/+HglX1Z5Tbm30przJQmFnsm87nw6pglHFh1xJEeMRRSi21cypNModdChomVCkoIb4uWUEiW/UkbMqa4Ysd5/JR46fod4WM1XyFRF3zTA/UIczxIJPfOH2SS6iRUwF3TsVe9DYEyHlf6CkOr4lWmz4fID0u7BYnKLa9I5A1VjYkXtMw6uts8pnStcawno5XzNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqyocgFGB8cfDRZO+tevzWa1t3868E3ymFsodkGidzY=;
 b=BClBglEFQc+FOs+sHiSkMxkb/oYhJOCmcwIiBQ1tKBi5+iW7jyrB/uvPkUxYaFOxWoeLP2t6HsEbB5HwUCSNjDOqMpfaLkSAwh4zWqkJcP2ghFuiqyAB7vdmZo+Biq/nJ8eXkMwWwJcju6yQIssiKfIfYv9nV3iqSt6TUzxKTK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 10:05:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 10:05:37 +0000
Message-ID: <c9123064-413d-4cf3-b39f-5268cedcf92d@amd.com>
Date: Tue, 7 Apr 2026 12:05:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] drm/amdgpu: give ttm entities access to all the
 sdma scheds
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-4-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260403083602.1771-4-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eae66f0-b6da-4e9d-69a9-08de948d3760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ZbBa2oh7vplrRI2G2OOaxalxkYpTnP/kJNgJGXBlBbQ73FAXn4Tte3WhqrrwpjmA0lrTmmCqh+q5aRXmQmHxFJUbDPwHHqDGH/84DY1wLip8O/KS+kss3hZS2JlTNb2SeHP+gQgYanTrZrpWiHosF6D0Mh/4tn6RLUUo+OKLzH0+2tbMvNAD4YD2ZlPUltfnk400bJBTdKL0tLZVF4MqZDfwjdqEbtOQ+erZkkkxQ7J9SFL58lYHgzwxE2VM4Xd42IIDM8fUrlswVBprLR357dStLkMucHtxhOngdEQV8MIWmLIi1Zr3qn1PD2mPSwdZdbSo/6+eZNVz35kDCFN9riwiaOcv0o/4GNl2jI5hjfZqkdQI1rse8LudGl2UofsdxcwTQENAsvwUjD7tt/hNqwbN4lTNbg/vc5tuYkJMkclcwgte+xB8ooFDSNMlLxXrr3xTiy/LHQc99skdxJIWvzPAhlDp0xsDbRhCKM8c/HBoyAG9nFzcyLq1hya5JTuFhlaxqTEbbkQV+jsN2wCPgiRKJ4LG6CG8gxjLzfAMqt/vBwCjvwf0CBqaQcX8NyEc5Yxsy92qMIJyZowcBtskl7QCukSuHRAUuI9TRYkGQNbZJMhQv3VPjZZvPiqwT2ORrnQQX+i2fl0hiwvNyWfIAodcGO6mZuUlvWDaJUkmLe72s8zqLqR+QyqqhSOuoPclNPg/rgKSjKpsqqsHEt16UAQODN5Z63EdHxyR94h0s20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlkL0d4MmJoRnF5MVJuOHJwbTNtdm9XNkowemlZTEc1TU0yMDNaelJTdXEx?=
 =?utf-8?B?Tzk2TTNCMnZRUno4VnJHQnhhQjJ1YlhqYWE2TzlaTjVaVjZSM3IvNVFHOWZt?=
 =?utf-8?B?R0hEaWJHTXZYMGRtUDE2RkRhRk5VVm04WEhoVWRBaEhIZDJVU1Zydk1MQWpC?=
 =?utf-8?B?cGxKenI0dDllL3RaaFRadG81OC9WSWVPeE80ZzdUdHJyOWR0WTB3SG0rV3Yx?=
 =?utf-8?B?NllYTVFmdkEybElIc2ZTeFo1TXNlUURLZTJpd2JxTTYwamtXTzd2TElSOUhX?=
 =?utf-8?B?UkhxNDZUeFlpd0Y4UE1HNDBXNXlUdXc1ZmFYcGhUN1d2Yk1rSmtHa2lZQWVv?=
 =?utf-8?B?cjI4QW5DYWZpOC91YXMxYjNSV3gxa1NYL09PdURBY0FyTmdhYjQvZkloRXRV?=
 =?utf-8?B?SFIzbWFUNkI4aHFic0tMcUVXTzFjNjBDVVFUcWpOc011MTRzcFRSV2hoLyt3?=
 =?utf-8?B?MFVCNkNoTHR3MlovRGI2V1BLZGo5WVdoUDB2UXVob2JmSFA2NFFvTlN6czRj?=
 =?utf-8?B?T3BBRWl2Szg5M1plNkgvL09qNUQzMUE4RG1yb0NKeEhYSXZzakxaU3B1MENX?=
 =?utf-8?B?MVpBbHpRTi84bjI5Y3drZWQ5QU5ic3dFQTdGQ28rUmtxRys0VDhCb2JwZFox?=
 =?utf-8?B?eklQNE41emtVcFlEbldSOE1TcjZ6dERjSXBTYThrdWZMWFFrcE5GOG9scWo5?=
 =?utf-8?B?eXRLN1NvMVMrSW9mVEpwZjk4V2xHQldJNWtydUVScldFVVNVM2J5cm95eitw?=
 =?utf-8?B?ZVRkYmsrVDBxN1FLcisyY0k3MTJvOENFajBuaXBqMDluVWRMNThuOE1kSm9j?=
 =?utf-8?B?OXdhd2RPMWJUOWtNU1p4aUJZNk9CMEZrVk5xeHVGckdlUm1FV2lleG5uY2pC?=
 =?utf-8?B?QUViTXNwMkt3ajdXSjhXaTlFNGY0SnU1aFlkTzRTRW42aHBZcFAycHB4Q3hD?=
 =?utf-8?B?MjI2OUJvL0d5ajZ6S0ZVUVJQakhOVFgrRUNvUFRURzJZWmN6ZExvcGpNaGJX?=
 =?utf-8?B?OEVETy9CWVNNek85S3FMMEZLYWRMYnM0c0dlczRFblBJbGpMRlV0QmE5Q1J2?=
 =?utf-8?B?dDZrOXJKVjVXVVV5UkxibmxJbC9FNi9ZYXRtRE1YY0pFZ2F3QVVkY0lSV0VS?=
 =?utf-8?B?THgyTTdrTkZxc3RrL0xGUmdXUVNvU0F0bG01ZUpabFcyai9DUnRjN2VJeEJB?=
 =?utf-8?B?aHdIUmd5WURjWmF2RWJRQVBwOUUzcW5SVmVwcWhSd3IzQTU0MzBXNkRxa1lC?=
 =?utf-8?B?ZG1FRFFaK2VNM2FlRm9kQWpaVEZFM0F2RWIwc1NWWVBBemdCczM0U2RjQmFI?=
 =?utf-8?B?S1JtMHFzdWRiZzgzL2h3TlJLQVZ6WWJ6NmVGUmplcWZkajEwVWwyOEl2UUhG?=
 =?utf-8?B?cEt1NUdvYjhLSEErc3VkbnFOS0VDOVJ2Uk05TXVOUE1RdWJUanBBd201Sm9w?=
 =?utf-8?B?eWYrTi8rUmpMN0ZsOEN2Qk50V2E2M3hJYmdlTXJrY0xpUFVDVzc0SzhERW9G?=
 =?utf-8?B?eklZbmc0TFJIUHdKSE5NVjUrbTFCOXJQN3UzUk1FN2xPNloxZ3piQ2tGUksr?=
 =?utf-8?B?VnloZEorQmJkamR4dDJjc2ZOVDdFSlIzeDltcHgwNXEvcmZ2RzlWUWo3VlRJ?=
 =?utf-8?B?WXVIcEY4cFVLZVRmNG5yNFJaRzlxRStHT29rNHpHT2Y1WDhnVHpxYTJHZ1Jr?=
 =?utf-8?B?M09xcDVFVGJsSGY0a1NGNnpXQzJkRkFjaDRreEpwUEE0Y1dtQnFWSkJxRENv?=
 =?utf-8?B?NFV4TmcrczhBV0hTdlBHNTkxanc2NEFyQkJqOTdBcXJvNjRYYmxpc3RlSWVO?=
 =?utf-8?B?VXJROWhBRWkxZWw4RTIremUvOEFCQlBwcGM3Vk5EMlVzZWh0Y0lmdXd6ZEd6?=
 =?utf-8?B?OG5pMmtLbjY2c2VvVWV4Mkx3SktzVzBOVTZ3WWlaSWluUnZJdkNNN1RuK2s3?=
 =?utf-8?B?WU5XTDJ6OXhoTExwOElUTStDa0xUc2tpV016eTROU1VBVi9MaG9iSkdNMUhq?=
 =?utf-8?B?bktrTHUydVpCRXFqVTZBNHFBOHhBL0VxSlprQytRbWhpV0VETVlsR2tKNDBn?=
 =?utf-8?B?MFkydktBcFdFVzJNdFNjM1VVcmJ1djhxamFyTmRleGVOMGZiRlJZQlhXN2lG?=
 =?utf-8?B?SytwRTlrNVh1bmoyaDEzK296Y2MxRWtxbGlseStlT3U4YW9WcndzSXhhKzZp?=
 =?utf-8?B?aWV1a1hObjFGWGVQV3ZNNTJ5ZDVmd0xzWWtoYlJRRzM4K0drWHpGclcrMHRh?=
 =?utf-8?B?ZURGanhOcG9Va0c3U010KzMya1VaTjBJbkMyQTJrNjNCM3VuazFvN3R0VTRQ?=
 =?utf-8?Q?PUcocKCbiCF0suBEd7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eae66f0-b6da-4e9d-69a9-08de948d3760
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:05:37.5694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfE51/DtnjG+eifm/OgUuHc9uhEY+QUCrr8MwODa+zrgC0JNaessTQ+2Is9EqQdu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
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

On 4/3/26 10:35, Pierre-Eric Pelloux-Prayer wrote:
> With this change we now have as many clear and move entities as we
> have sdma engines (limited to TTM_NUM_MOVE_FENCES).
> 
> To enable load-balancing this patch gives access to all sdma
> schedulers to all entities.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 83f6d00dc3a0..648ad344e89c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2349,8 +2349,6 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>  		return;
>  
>  	if (enable) {
> -		struct drm_gpu_scheduler *sched;
> -
>  		if (!adev->mman.num_buffer_funcs_scheds) {
>  			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
>  			return;
> @@ -2358,11 +2356,10 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>  
>  		num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
>  		num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
> -		sched = adev->mman.buffer_funcs_scheds[0];
>  		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
>  						  &adev->mman.default_entity,
>  						  DRM_SCHED_PRIORITY_KERNEL,
> -						  &sched, 1, 0);
> +						  adev->mman.buffer_funcs_scheds, 1, 0);

Why still giving num_schedulers as 1 here???

>  		if (r < 0) {
>  			dev_err(adev->dev,
>  				"Failed setting up TTM entity (%d)\n", r);
> @@ -2380,8 +2377,11 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>  
>  		for (i = 0; i < num_clear_entities; i++) {
>  			r = amdgpu_ttm_buffer_entity_init(
> -				&adev->mman.gtt_mgr, &adev->mman.clear_entities[i],
> -				DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 1);
> +				&adev->mman.gtt_mgr,
> +				&adev->mman.clear_entities[i],
> +				DRM_SCHED_PRIORITY_NORMAL,

That should be DRM_SCHED_PRIORITY_KERNEL, same below.

Regards,
Christian.

> +				adev->mman.buffer_funcs_scheds,
> +				adev->mman.num_buffer_funcs_scheds, 1);
>  
>  			if (r < 0) {
>  				for (j = 0; j < i; j++)
> @@ -2400,7 +2400,9 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>  			r = amdgpu_ttm_buffer_entity_init(
>  				&adev->mman.gtt_mgr,
>  				&adev->mman.move_entities[i],
> -				DRM_SCHED_PRIORITY_NORMAL, &sched, 1, 2);
> +				DRM_SCHED_PRIORITY_NORMAL,
> +				adev->mman.buffer_funcs_scheds,
> +				adev->mman.num_buffer_funcs_scheds, 2);
>  
>  			if (r < 0) {
>  				for (j = 0; j < i; j++)

