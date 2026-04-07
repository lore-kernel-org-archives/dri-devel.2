Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BCFEDB7CA
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 08:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59A310E36D;
	Tue,  7 Apr 2026 08:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/sH0Nzq";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 615A710E36A;
 Tue,  7 Apr 2026 08:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3fAETse+a6I8P54Dn24nYtP+MJ7OsNEn4dc1V5aG343Qane12Tf7iSsk/OFwfqPykmBpsnbv9fdKiraC5KymK4f5+hNkHwL/aa16L7qss8WQQQkMgGVYeENNAXwIO0XEByy7MBiYueY0pezDFDDJpQn3+D56KLzgCgz5NJYbYGB4mZcl+LStG9Ft/KI94GM06l2S7IjN7rAXwRMZiA7ZeUsHaMOh4ni0nbqQ9EDLPLuJ3zl0jLbZkyUYUJ3k6AU88gEAVG+ZBLdniv7F+7+htlxMwkN8dhaFVRrurjZuVaQ4br0MOooJNgZ1vw5tKbuud7HcvXdVVyqhYcSL4Stlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebtYnV6Lx0kVkya8iCB+LjFWOd8TeQA9l8bl8n85x9w=;
 b=CkNV/6kXNmQTQ/qzWB9UZB7rO16o0r3BYb0fLsbfkEdRKSiEG3F7+dJIS/koTQTDoXe06e+5odRt9yuRbu81TxU5NjpdCC/UxlmawCeYogSfycOW/gcl4SCZ1I/V5MFQiccOVS7MgRvS24I39EpNAn5PAnv8Yk4O2grSp9gV6dKyxUpbOk+7XP3xl2qazGEeJoEn6dVg17dvDnwsv9OOd2VSDn2DxZPZF3ViFQeLzbbMEljdVee5AO7bN/gYK/yWTS3QXIm3w+IgvVo56hV42Kz9MO95zBqtebN/6cDMdeeWTIGc+UvQnU3hpvbwArhbZcmWoGx7XtHoMZsTeejeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebtYnV6Lx0kVkya8iCB+LjFWOd8TeQA9l8bl8n85x9w=;
 b=F/sH0NzqLIDApmaRj7MLOOIRv+kSPrk9JNkCsP9r3c56p9AWbAKGIu7H7TzIBatGbI1Uv2eU1t6j8yFThcokL140407MMRDjRN+iLKA4lf/CwV4fyDuTUs995senzbS/y6eh+z8+et+jbCKTmkKm6WoG5rl5iwWpgxzwQJ/YWdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 08:11:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 08:11:55 +0000
Message-ID: <e290f1b7-c1b9-4b6d-9664-8312bad6a6bc@amd.com>
Date: Tue, 7 Apr 2026 10:11:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] drm/amdgpu: only use working sdma schedulers for
 ttm
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260403083602.1771-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 475a32c4-fbfe-4a65-82dd-08de947d54f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: dL58sHBV4JBkgRVxAu8VjYRmdYb1bo/790NqATdqt4sTrjVan+j/Uy8OOpkqRcwTGGRa+X/97sNyau5mBZLDdoQOXHJiPSgLhlcyPUoo1/BZZXofbsghIFSbyy2WxcGGZzTPvwFpHtHY4KZZQ7GJk5WMe3Qvr5JwOTIcJqqVi5P7GWA7c+MXTLoG3lWa261grtLHG/wJT41D2WTIvuZhLEGrHGhwR7FVmdqJjk767YfdAm5XnO7A8BnAHwiy8ZvVrswJcx/sQgfpJSbYx9GEsk96zNDtd5RAFM2nNxxrAZNns2H+d5O17K6g6ki4VsnOEXP4xaaUOTId6vm1PqTCHDthpHX4rxCAdBxfIdDzt3WFHBcmyHWMdo6JyLafYYuUdUKJQCMLzmnt8hx6Q+Ju7cC17aI9cTmuMgDqtz/3xRr8UQw/YSanAVaOkF1AWWGr2SZOUO2MkyZ3COjPpsyU5yr7PCi1oyzeI5ppVml13IrYMXGaTAipYvpKbrkQcOQBeklNleuC6d0C6NnsR84mrfaUdibu+SfMK4QXLP8q/Hfjxp0TxXlIhm1t+eIl5cSEpXDg6rFFC+G+77ugbiXWl++/0RdD1H/F/W0nvGDoZRLo/MP7qsMelWqb60JpVdGr/TTlaKayb/gx+Jd5xgajdf39YTIBR4beWMEorkn6m0FowUJYX4b8GhjKoLaFGn71HMNbSaF8cWA2QVbZML6Q5WabJnOtkV0A0q2ifKtK1T0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW0vQ3BZV1BjdkpoYy9GRWVCVUpkdTB3WGhzMitRUm16QUZ0aTBMQkViYTYv?=
 =?utf-8?B?UlRHU1JLZUZ5TWprSUVscHVOK1FBNVNhSld5RTJYazU4bzl1UEFzT1hTeFli?=
 =?utf-8?B?R2ROOVlCd0xlRnNKT1BzL3c5aFVFUFBxZkVzN3NRczZGN3RnR1BUdGN4Mzc5?=
 =?utf-8?B?QnZDbDNzci9QbGxiQ2cxMEZTcXV0NG91TkxyTGQwait3MjRHaHFpRXlUdWJo?=
 =?utf-8?B?S2tBWS9DcnRCNlJmcURUVEoxWUpmNE5UZlhYdk8wb21FbTVrVkZRSllMTVpH?=
 =?utf-8?B?SDFzR0g0R2ttNEhLcHUxZm9XZHhvSDA1ekM1UWI2QW0zcHJYajJ0MER1UUZ5?=
 =?utf-8?B?eXdwUHZIYnVlbXVnaUxEZ1VrMVJqUGJ4cmFXdjBEeXdRdENZSVNzYXFVdllT?=
 =?utf-8?B?RGpWS1FIWGdxMWIvUVlTM1FKRndXbW1zMEdUZnc4ZmNKTFRLbnlqZzdWTEJW?=
 =?utf-8?B?N01rMno4cUpqM09pT0x2ckFGOW5XdEJXbnErM2dLN1BjS0JIOWxRR1FoTjFn?=
 =?utf-8?B?MFVXVDhTS290cjVRTERCdWRLLzNZc2FOaEsvV1E2WDdYNGxLVGIwdlJyR28r?=
 =?utf-8?B?UXBMT3MzbGJUTEV0c1dueDR3ejN1L0daeVl5REc3Z0c4WW5GYUwrTVRhZTFR?=
 =?utf-8?B?SExqVmE1TnhXVWhPdHpSTTIyOFRlbFQ5ZUpjN0kvdWpJUFY0L2RESFdpZmEx?=
 =?utf-8?B?MDdhZjl6VmRiWFNqQmhmSld4UmtoSXB3TlU4dzRFV2RNdStjSVMrZklVa3NZ?=
 =?utf-8?B?eDRpeXRJcHRTL1NTRGlyc2tQMHJNVlVIRnRzeUNjQXlWV1FhSmhRVWJiOWw4?=
 =?utf-8?B?ZnNTeUFRQ0hVTVFpRW1GN2w1RkMwUy9POEdNMXJHT0JMNkF4T3kyR3JlYVRa?=
 =?utf-8?B?M2tRTGNCT2JxVkpXSFpsYWk5Z004SS9pT3hJdENRNlA4RUZ3cEh1WTM5Q2x1?=
 =?utf-8?B?R2JZTG1jb215T0o5YnJ0bHBTMGR0Q1NwaHZoTnJ3TU5OMENHMTNqRVl3QURt?=
 =?utf-8?B?L3dnY0hYZTVwK2xadGZFbEhYbUZzRFNPRGFQeDNHRWx5Nm5OSHVJM043REpF?=
 =?utf-8?B?N1NQTmNyU0lVblBYSkZYUTRFc0M3Y2ZzZ3FyekllU041VW54T2p2V2ErL05G?=
 =?utf-8?B?SmVyMFM2eXhMT0JaWTE0UE83Nm5JZG9VM0lmZ0tUekt3UjlscGNtd2VodEFR?=
 =?utf-8?B?Qm9UWEZDdVp2ZUZPWVREZTQ2NGlLSWdPK01Cb2xvUU5oQ0JZQ3J4SXJuSTNL?=
 =?utf-8?B?a1FucFNYRHVFdDFZWkRVZHo2bHpTQU95WFVPVkJJV2Z2dmp1ZmNMUGdFQVNx?=
 =?utf-8?B?QjhyUG9Db3M1YXVxMHBMaDA5LzBvdEdjYndqV1ZxR3hDMjVMV011UHlBZDhy?=
 =?utf-8?B?bTlVVEtRTHpCelZmb05UT3FJVFdOUUtvMEkrdkl3WkIwVWNDTWdLZkxoVUxB?=
 =?utf-8?B?TkZhRFFXNS92SDNSeHl1QVdhYnVySjJOSDRSY2E3QzBwWGZLQndueUR1ZUpN?=
 =?utf-8?B?ZUJmRU5NQVRaNnVQc1RkQUZadlZVM3VwVEh0dWZvTDJTd1BIaHRDZUI2TWZR?=
 =?utf-8?B?Y1JPTk5FRUprdS9UckJBUGNSd1FZY0t0Y0s2VDk2cHZmVy9QWEJvUWEzQjFa?=
 =?utf-8?B?dm96NVl2YjAvWWgxcHRkTjNDaTByd3FtS2NuUXlDVTZPU3pMQVN4bUx3Rjdy?=
 =?utf-8?B?SExjSk9jY2dQdTQrQURNbENVYmQ5eGZIUGpqTTMycGNqczhFZGx5OFZkZmls?=
 =?utf-8?B?WU00TGtvYy8reTJyVUFaT2N2T0pFRm0zRWltUGEvYnRSbnhaY0s5WFhOMFNi?=
 =?utf-8?B?Yk1zbzk1UW5QZE1tUGtPR1RQdnF0bFpPZUJCMzliZ0U3ZHdGcnpjYW9lcC84?=
 =?utf-8?B?WkVrbVRiMG01L2UvOTl1M01xbGExSkxxUGovaW1GQXJ0UVVnU1lIdlBEdFJu?=
 =?utf-8?B?U0hpZlkxSnpzSnkzcWhRQ3lSUVFRMk1vc2ZISHlhcGFFSld1NnorQUM2eWdo?=
 =?utf-8?B?b3F0KzRuQlY4ZWlMVWw1Wk5XTkkyVi9FNWVYa0ZGTi81bHBKMDhUL29CUm95?=
 =?utf-8?B?NkJac0FURVRQM2YxZ2ZMQUpJVytBb1lLbDg4cUh4OFEzVTVJcThHZk1sYzdw?=
 =?utf-8?B?a3NYNHIrN3p1ZE80YVhmTk5wZVYzLzF4TEY3ckFHZFpIWnBOVmVxZFNsZ0NW?=
 =?utf-8?B?QjlxZGYyUWpBVUNxRm10REtkd1JFN1V2bWJERE4vclkrTmFwNVJncmtTTnlP?=
 =?utf-8?B?Ykt6aEY5QkwrTVl6NzY1eVc3UGltYm4zOVcyMlVwbEU5TG5pY3FxWDJqc3Ns?=
 =?utf-8?Q?3WLVrTOUsE/14C69+F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475a32c4-fbfe-4a65-82dd-08de947d54f2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 08:11:55.1817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAhb4axcqUlwsRM9WpOvfhzLQwjgOidEml8SH/E/RtrgoN/w1QLX0b/dSStLh8Lb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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
> It's possible that some sdma instances aren't working so we shouldn't try
> to use them from TTM. To achieve this, delay the call to
> amdgpu_sdma_set_buffer_funcs_scheds after the rings have been tested, and
> then use the 'ready' property to decide if a sched should be used or not.
> 
> Note that currently it's not doing much, because if the ring helper fails
> for any ring, the whole sdma block init fails.
> 
> ---
> v5: check buffer_funcs_enabled from amdgpu_ttm_access_memory_sdma
> ---
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 23 ++++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 10 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/si_dma.c      |  9 +++++++--
>  12 files changed, 68 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4ba7321b75e3..bd32113292ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1560,7 +1560,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>  	if (!adev->mman.sdma_access_ptr)
>  		return -EACCES;
>  
> -	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +	if (!adev->mman.buffer_funcs_enabled || !drm_dev_enter(adev_to_drm(adev), &idx))
>  		return -ENODEV;
>  
>  	if (write)
> @@ -2351,8 +2351,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>  	if (enable) {
>  		struct drm_gpu_scheduler *sched;
>  
> -		if (!adev->mman.num_buffer_funcs_scheds ||
> -		    !adev->mman.buffer_funcs_scheds[0]->ready) {
> +		if (!adev->mman.num_buffer_funcs_scheds) {
>  			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
>  			return;
>  		}
> @@ -2734,20 +2733,30 @@ void amdgpu_sdma_set_buffer_funcs_scheds(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>  	struct drm_gpu_scheduler *sched;
> -	int i;
> +	int i, n;
>  
>  	adev->mman.buffer_funcs = buffer_funcs;
>  
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> +	for (i = 0, n = 0; i < adev->sdma.num_instances; i++) {
>  		if (adev->sdma.has_page_queue)
>  			sched = &adev->sdma.instance[i].page.sched;
>  		else
>  			sched = &adev->sdma.instance[i].ring.sched;
> -		adev->mman.buffer_funcs_scheds[i] = sched;
> +
> +		if (!sched->ready)
> +			continue;
> +
> +		adev->mman.buffer_funcs_scheds[n++] = sched;
> +	}
> +
> +	if (n == 0) {
> +		adev->mman.num_buffer_funcs_scheds = 0;
> +		drm_warn(&adev->ddev, "No working sdma ring available\n");
> +		return;
>  	}
>  
>  	adev->mman.num_buffer_funcs_scheds = hub->sdma_invalidation_workaround ?
> -		1 : adev->sdma.num_instances;
> +		1 : n;
>  }
>  
>  #if defined(CONFIG_DEBUG_FS)
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> index 26276dcfd458..120da838ac28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -939,7 +939,6 @@ static int cik_sdma_early_init(struct amdgpu_ip_block *ip_block)
>  
>  	cik_sdma_set_ring_funcs(adev);
>  	cik_sdma_set_irq_funcs(adev);
> -	cik_sdma_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &cik_sdma_vm_pte_funcs);
>  
>  	return 0;
> @@ -1000,8 +999,15 @@ static int cik_sdma_sw_fini(struct amdgpu_ip_block *ip_block)
>  static int cik_sdma_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
>  
> -	return cik_sdma_start(adev);
> +	r = cik_sdma_start(adev);
> +	if (r)
> +		return r;
> +
> +	cik_sdma_set_buffer_funcs(adev);
> +
> +	return 0;
>  }
>  
>  static int cik_sdma_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> index c6a059ca59e5..93ec52c1f367 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -828,7 +828,6 @@ static int sdma_v2_4_early_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	sdma_v2_4_set_ring_funcs(adev);
> -	sdma_v2_4_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v2_4_vm_pte_funcs);
>  	sdma_v2_4_set_irq_funcs(adev);
>  
> @@ -898,7 +897,9 @@ static int sdma_v2_4_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	return r;
> +	sdma_v2_4_set_buffer_funcs(adev);
> +
> +	return 0;
>  }
>  
>  static int sdma_v2_4_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index cb516a25210d..3fde9be74690 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1108,7 +1108,6 @@ static int sdma_v3_0_early_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	sdma_v3_0_set_ring_funcs(adev);
> -	sdma_v3_0_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v3_0_vm_pte_funcs);
>  	sdma_v3_0_set_irq_funcs(adev);
>  
> @@ -1184,7 +1183,9 @@ static int sdma_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	return r;
> +	sdma_v3_0_set_buffer_funcs(adev);
> +
> +	return 0;
>  }
>  
>  static int sdma_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index d56be26f216b..8a2a4e61867e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1775,7 +1775,6 @@ static int sdma_v4_0_early_init(struct amdgpu_ip_block *ip_block)
>  		adev->sdma.has_page_queue = true;
>  
>  	sdma_v4_0_set_ring_funcs(adev);
> -	sdma_v4_0_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v4_0_vm_pte_funcs);
>  	sdma_v4_0_set_irq_funcs(adev);
>  	sdma_v4_0_set_ras_funcs(adev);
> @@ -1961,6 +1960,7 @@ static int sdma_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
>  
>  	if (adev->flags & AMD_IS_APU)
>  		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, false, 0);
> @@ -1968,7 +1968,12 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	if (!amdgpu_sriov_vf(adev))
>  		sdma_v4_0_init_golden_registers(adev);
>  
> -	return sdma_v4_0_start(adev);
> +	r = sdma_v4_0_start(adev);
> +	if (r)
> +		return r;
> +	sdma_v4_0_set_buffer_funcs(adev);
> +
> +	return 0;
>  }
>  
>  static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 67e9697301b4..88428b88e00f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1368,7 +1368,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
>  		adev->sdma.has_page_queue = true;
>  
>  	sdma_v4_4_2_set_ring_funcs(adev);
> -	sdma_v4_4_2_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v4_4_2_vm_pte_funcs);
>  	sdma_v4_4_2_set_irq_funcs(adev);
>  	sdma_v4_4_2_set_ras_funcs(adev);
> @@ -1568,8 +1567,11 @@ static int sdma_v4_4_2_hw_init(struct amdgpu_ip_block *ip_block)
>  		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>  
>  	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
> +	if (r)
> +		return r;
> +	sdma_v4_4_2_set_buffer_funcs(adev);
>  
> -	return r;
> +	return 0;
>  }
>  
>  static int sdma_v4_4_2_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 86f5eb784d57..fa02907217e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1373,7 +1373,6 @@ static int sdma_v5_0_early_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	sdma_v5_0_set_ring_funcs(adev);
> -	sdma_v5_0_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v5_0_vm_pte_funcs);
>  	sdma_v5_0_set_irq_funcs(adev);
>  	sdma_v5_0_set_mqd_funcs(adev);
> @@ -1472,8 +1471,11 @@ static int sdma_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	sdma_v5_0_init_golden_registers(adev);
>  
>  	r = sdma_v5_0_start(adev);
> +	if (r)
> +		return r;
> +	sdma_v5_0_set_buffer_funcs(adev);
>  
> -	return r;
> +	return 0;
>  }
>  
>  static int sdma_v5_0_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 3fec838374b2..f6ecbc524c9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1264,7 +1264,6 @@ static int sdma_v5_2_early_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	sdma_v5_2_set_ring_funcs(adev);
> -	sdma_v5_2_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v5_2_vm_pte_funcs);
>  	sdma_v5_2_set_irq_funcs(adev);
>  	sdma_v5_2_set_mqd_funcs(adev);
> @@ -1385,8 +1384,14 @@ static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
>  static int sdma_v5_2_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
>  
> -	return sdma_v5_2_start(adev);
> +	r = sdma_v5_2_start(adev);
> +	if (r)
> +		return r;
> +	sdma_v5_2_set_buffer_funcs(adev);
> +
> +	return 0;
>  }
>  
>  static int sdma_v5_2_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 064508cecd11..ee83d3e5978e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1313,7 +1313,6 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
>  		return r;
>  
>  	sdma_v6_0_set_ring_funcs(adev);
> -	sdma_v6_0_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v6_0_vm_pte_funcs);
>  	sdma_v6_0_set_irq_funcs(adev);
>  	sdma_v6_0_set_mqd_funcs(adev);
> @@ -1477,6 +1476,7 @@ static int sdma_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	r = sdma_v6_0_start(adev);
>  	if (r)
>  		return r;
> +	sdma_v6_0_set_buffer_funcs(adev);
>  
>  	return sdma_v6_0_set_userq_trap_interrupts(adev, true);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 60447729271e..c8343981c596 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1299,7 +1299,6 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
>  	}
>  
>  	sdma_v7_0_set_ring_funcs(adev);
> -	sdma_v7_0_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v7_0_vm_pte_funcs);
>  	sdma_v7_0_set_irq_funcs(adev);
>  	sdma_v7_0_set_mqd_funcs(adev);
> @@ -1432,6 +1431,7 @@ static int sdma_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
>  	r = sdma_v7_0_start(adev);
>  	if (r)
>  		return r;
> +	sdma_v7_0_set_buffer_funcs(adev);
>  
>  	return sdma_v7_0_set_userq_trap_interrupts(adev, true);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> index c3428d2731dc..b1ca95c2623b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1275,7 +1275,6 @@ static int sdma_v7_1_early_init(struct amdgpu_ip_block *ip_block)
>  	}
>  
>  	sdma_v7_1_set_ring_funcs(adev);
> -	sdma_v7_1_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &sdma_v7_1_vm_pte_funcs);
>  	sdma_v7_1_set_irq_funcs(adev);
>  	sdma_v7_1_set_mqd_funcs(adev);
> @@ -1374,10 +1373,16 @@ static int sdma_v7_1_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	uint32_t inst_mask;
> +	int r;
>  
>  	inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
>  
> -	return sdma_v7_1_inst_start(adev, inst_mask);
> +	r = sdma_v7_1_inst_start(adev, inst_mask);
> +	if (r)
> +		return r;
> +	sdma_v7_1_set_buffer_funcs(adev);
> +
> +	return 0;
>  }
>  
>  static int sdma_v7_1_hw_fini(struct amdgpu_ip_block *ip_block)
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> index 155067c20a0e..549708075eb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -487,7 +487,6 @@ static int si_dma_early_init(struct amdgpu_ip_block *ip_block)
>  	adev->sdma.num_instances = SDMA_MAX_INSTANCE;
>  
>  	si_dma_set_ring_funcs(adev);
> -	si_dma_set_buffer_funcs(adev);
>  	amdgpu_sdma_set_vm_pte_scheds(adev, &si_dma_vm_pte_funcs);
>  	si_dma_set_irq_funcs(adev);
>  
> @@ -543,8 +542,14 @@ static int si_dma_sw_fini(struct amdgpu_ip_block *ip_block)
>  static int si_dma_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
>  
> -	return si_dma_start(adev);
> +	r = si_dma_start(adev);
> +	if (r)
> +		return r;
> +	si_dma_set_buffer_funcs(adev);
> +
> +	return 0;
>  }
>  
>  static int si_dma_hw_fini(struct amdgpu_ip_block *ip_block)

