Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC010FF60FB
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFAC10E908;
	Tue, 31 Mar 2026 09:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMtI/Uoo";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC1BD10E825;
 Tue, 31 Mar 2026 09:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shvPUxTnAQpkAOs3LBGt+zXGy+E9ukWXACPgVrcVN0HiMKTpLqXUS3PY+0LryCa+v7Mp0SiMaIR0C/8KdNwlR3MJnLSjJLjfoqXqlIPV0fzND0fx212VRbweu5c+s1x3frHfEpsVn2z9iwOl0/H8s1inroYo8DPoHCZg+71uczE9Xi+8N3Nvp1nhCl3/CUathzMtUlokXDg5qlfMWbAS9mDfrHlXvbirqA3AMRVgHOqI7uieZyeTDGctOmORkxX+FzDO1juS1FM24o0BEhWSI/43+rqSinxjLsJ7ex0BuqULcZHqcewB4Nik7JaOCEG6p59xcwcN0TXkyObu9fK0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWsiqcjc2b7vHJHt6TQdpGCSlxffbfJX7tcsRyDo3qw=;
 b=HsnRJbNKVK77kuYmY/HkZHaCBsit1a1Y0GyddMK6BBGw/F5tg7K7HR7yGEob2PpEV9rbvagmI3aOJf4YLYbdh1m9ULSUdURa9i+dk15stzRHdHuL4OQ0ALunjD7G99FHcb5s9ZRd//FTxK1fZ7SVuWSfVLAAtVaU0IdTYvE0h73HPkXLg4iIvqhDbPFF7HLB0xc1glS9zuLSX4/JK84s0e/uxzGZD3gAVGGpKok62POif+pgoypijCPTSN0WbUj56lZM3A31I24poh6MoRqHxigIt7AWjc1EpRUYwh718dBlUGp453t5nJ8XC+n9sh0V8WxJwyQUuBuwILcU+DDn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWsiqcjc2b7vHJHt6TQdpGCSlxffbfJX7tcsRyDo3qw=;
 b=QMtI/Uooy/Vrvu2lWyTkUOy9yb1jbQO1CTzp2OutXJzgsaBTOXyLFXCWMoq8mb8gZBDwf4sIeQd1oltdCf2+olL+ADLRYDpC10VcqQW3MzBoAnHuuETzQ9/VjUheY2DNnSbcmeHAR0H3jGI2AD+zdsvqQYGjW5K+DRvi4LC0eRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7420.namprd12.prod.outlook.com (2603:10b6:806:2a7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 09:30:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 09:30:24 +0000
Message-ID: <9ce0007d-73a7-49cf-a6fc-0c47da7522cc@amd.com>
Date: Tue, 31 Mar 2026 11:30:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] drm/msm: Remove abuse of drm_exec internals
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d59641d-84a1-430e-a2d5-08de8f082320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: yzD0sZZ5ySsnssXbP9qUEQYJ0VIfw1W7MihrwUvKGuoSi6o7bn/8+B3S9MdPOf2ay0iSqr5CZyRrv9H9R8cklP5EcaozJtYJXh3+Hg+sYhVeOTQiO+tGzbBXfROkfiGPJVApevjGKzlN58uCFgblc12C0chUrKC5D+8Ycfe2dy8ISOelYicjBhEioKfSn6L6pIb+RPXtJkJRI/r7He298b48HCUTu771kHrS9ydHtnqgH4CDnZs+rLvedyp6kcXUU4Ai7iR7ZpZ3J6MPbPIW/5MobrQR5OtYGdmOHlmD37zUZWI7AGj+IM7RaOKqvIkekzVnqoHO4PfmKIgaiT24x0vuzppbLWYQq3BJFlPP5FY0QgzZYkY8wadEDG/CJi4jw7K/MRs3DME0W21cq4p44dQzOPYAZwpQ1+4dHuclGOkANRLZ4tXtDp5E/+/5YZLl9DDqpnpI4NdRJ+bpdd/kca6X9RH8TBgn5gTtqirjPiU3N2S/26L+gRzFySDTUIYzZvuTnaC9KH5XdJ0xBezGg4ULNz3HpMhUToQSnsr8RY0o/gjkZVPi6SLnIYftgeqnmflr8dNeUghfdQp6idiUGyHa4lw42RVYNo7CRSHrjYdu5jdP6gQORrlV7Gnh9GIt2f/7qo74VcRhNjjOGtBE1/p+Lcax2zPXW9ignudCsQg6QSlZEUI8e1/dT5d2zrojR2kztQo8FXVEKN2eC+/ub6caZgYiYNHhX2XzMYOHc24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elhUZmVoSVhxZTJyUFUvS0FGdTdyVnRwczIra2tWRlJHKzQ4WWw1cExjTm93?=
 =?utf-8?B?eUEvdU56WGFSRDQrOTlPaHliejVaSVMyMzIxVjJsMGpCdWliL05MeFFpQlVJ?=
 =?utf-8?B?NlFTN2xEMElwT0N2MEoveW9lc3dNejRaemRPUWJuTzhjV3U5V3drbFM2WFZs?=
 =?utf-8?B?UGlkMzcramVRRThDSUxlcjlEdGJZOCtaMHY5TmNmNUpzNVdUcEVxSFRROWwv?=
 =?utf-8?B?R0U3VnhXMjZid2JBY3k3RUtzejkxeVNjR0lWTlRCKzlqdGI0cnhva2N4Rm45?=
 =?utf-8?B?QndiREtDTmlnUEJZNjFYN2ZDeXlXeVk3WnJhQStlNkgzM20wVVVTZ3ZLT01Y?=
 =?utf-8?B?Qm5hQW1kd3BXRXE2VVREcDQ3OCttSHRjTHdockxENGR6WTBndTVQaEVreGFQ?=
 =?utf-8?B?ZHR6VTE1blh1NjZ3SzQxci8rUzBEdWoxQUpUUWNlWTdRU1k1alVodzF3UTZV?=
 =?utf-8?B?S01TRFpxejJlcE80ckJzOWxLREIyY0NSejJLdDBjQXJ4bmQxaXhjWVV1ZkRB?=
 =?utf-8?B?OFNqU1Z6NmdhRVk3b3B2ZzJZNVdORVhoQS9sbXNPWHR1aW5PV1I1Y3lid29N?=
 =?utf-8?B?MGJmWCtJVFRXb0ZBbXdPRTFJbXBGcThQSmpzdDMzRlNYZG9zR1poVGtxMHZ4?=
 =?utf-8?B?ZUtZVkVjUDVjcnpDc2JyM3d1SnVKRmtPV3VKOTl4cjVGcGZrYmVLMzdXYlhB?=
 =?utf-8?B?S3BnZC9nTUV0bzhzTjM2blo5QUdTRkhKL2llQjlXWkhSdlpvWGREd0E2RDZ6?=
 =?utf-8?B?QmV3blEvbmhOYU9MNFVZeUNhNTZFMjE1bitTSlhNMjZ5cmdieHpxUk5uVG5F?=
 =?utf-8?B?TDdIS1p2ajN2a2c0WDIyYXJKVzRnUVFpQkdmQzB0YW1xcDF4WXVaQ2doRXZk?=
 =?utf-8?B?Y1dqaEFySDdNSmZBTVBFUkdHZjV0Wk9jSSsxZ0dHeTZUd05wazlJLzNuK2I1?=
 =?utf-8?B?QjdCSklnQzJCSkVuZ29KSnlONS9Hb3FSTDJaTVM2bXMvREpXZGNQMzNJTXVL?=
 =?utf-8?B?RFI4bml4am9pOVhUbDFLQlo0NnNvKzdyNUxwTUpDNE9ZMWVieFRpUmZIa3kx?=
 =?utf-8?B?ZFJ6QXhOWlhUa29DNyszRG1rU3pvYS9PdzFJbHZ0dGxiTGMrbGpyM0swNjBK?=
 =?utf-8?B?ems5eDBGbmRZSDRTQ1crb2hKbDg5Rkc0M0FucVVSUndaa3ViNmVWbXJKMHox?=
 =?utf-8?B?ZFdGOWlKVlM0REhLMm52TmduTkNFa0NMSmxoUysxM0JNbGFWVWtFOG5JUVR5?=
 =?utf-8?B?SVBvT3BMVGxMUkh2eW1MQmdWTFNkdm5sTlFUMWhzRFFOOVNKMjNuenovM0hq?=
 =?utf-8?B?S3g5ajNybzRYZWxmQmZtQkRRTks0NCtzK1BQcERmTGw1ZjRQTFp4dUZmRXpn?=
 =?utf-8?B?eU01RHFmT3FPcXB2R2duZWxYeEZ3UWZTbUtOZ002NXNvcWQ3aE1wazV2cG9n?=
 =?utf-8?B?S0FjcEl3anVBMEhGcWR3OVZicjk3NnFhSFcxdktyU0cxTHBlTnhSN2EvSlBk?=
 =?utf-8?B?azQ1YkJqemdDYW83SCtrYjJNUFpmNWRWTXlqcU42bkZodGxMM1R4OVJyMFp5?=
 =?utf-8?B?dy9aUkg2L2Y4M3QzYi9DWnZYeS9ZUFRaMWRKWFM1bW93ZXFZVTVvWmhWZm5o?=
 =?utf-8?B?KzF2WUEzWEhhT1ZGVTVJM2hxYkcxQmxqcStkaG5YK2R1OElpYm1tMGFLb3Az?=
 =?utf-8?B?aFlnbEpCTjBKbVIybGpZRVJKYndHOU5yWFlOblJHM1AwVFNYOUpZWVB0VzBu?=
 =?utf-8?B?Qkd1bjdQNGtVcmQ5M2ZVbkI0RTRSVWV0N2h3c0kwK2tuNmpPS0lVbTRraVNm?=
 =?utf-8?B?eTk0ZWlZcS9VYklud09iOWs2MThvS1BEa1VjZmhjM1ZjeEM2SFlKWXRTNmQ1?=
 =?utf-8?B?SkR0bCs5ZllUaXFOVGl6cSthdU5pN05oVVAyNmpEeWNNbGhwVlJPVEF6VEJ6?=
 =?utf-8?B?R0tRckZEZkU3WGMyaHBzY2kwenIzcHRxTm0yNzF1WGRFZXVqWmdQcVdlNzR6?=
 =?utf-8?B?TndSYS9ncTd1MFFXQXJjbno2RDBBUlhIa3ZCZ0VBeXNHS3RiemxEL0VObnpp?=
 =?utf-8?B?NFJWWDI3eTVFUXJLVEdTZnNvQUhOUEVrd2N5aGtGSHlTZjkxOWViaE1KcTdy?=
 =?utf-8?B?TlprWFJWQXlOTjZTcWRvRWZ3UFkyd2U3K0F5aTdzNFAxNC9XbloyWUpkc3g4?=
 =?utf-8?B?T2RnTDB2OThZd0JUYnZ5WjhhSXNPTG1wNThEdUtPcVpnU0xTMDV6clFBRDYz?=
 =?utf-8?B?Z2o3NnVjMk5aVzBqNDRaL0FzZ1RuRHRydWhIWGI3Q3FJcVpycUo5SkI4eTNC?=
 =?utf-8?Q?8zsw2evqZNphNDnySR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d59641d-84a1-430e-a2d5-08de8f082320
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:30:24.6209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMPgYn/tQs2jsydrhcjK/SjDHRG+Uu+tXsDeorWiUpazk6T6RdeTBlwZkFEF10D1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7420
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

On 3/31/26 11:20, Thomas Hellström wrote:
> The code was reading drm_exec internal state to determine whether
> the drm_exec structure had been initialized or not, and therefore
> needed cleaning up, relying on undocumented behaviour.
> 
> Instead add a bool to struct msm_gem_submit to indicate whether
> drm_exec cleaning up is needed.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/msm/msm_gem.h        | 1 +
>  drivers/gpu/drm/msm/msm_gem_submit.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index cb32093fda47..762e546d25ef 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -452,6 +452,7 @@ struct msm_gem_submit {
>  	bool bos_pinned : 1;
>  	bool fault_dumped:1;/* Limit devcoredump dumping to one per submit */
>  	bool in_rb : 1;     /* "sudo" mode, copy cmds into RB */
> +	bool has_exec : 1;  /* @exec is initialized. */
>  	struct msm_ringbuffer *ring;
>  	unsigned int nr_cmds;
>  	unsigned int nr_bos;
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index 75d9f3574370..26ea8a28be47 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -278,6 +278,7 @@ static int submit_lock_objects_vmbind(struct msm_gem_submit *submit)
>  	int ret = 0;
>  
>  	drm_exec_init(&submit->exec, flags, submit->nr_bos);
> +	submit->has_exec = true;
>  
>  	drm_exec_until_all_locked (&submit->exec) {
>  		ret = drm_gpuvm_prepare_vm(submit->vm, exec, 1);
> @@ -304,6 +305,7 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
>  		return submit_lock_objects_vmbind(submit);
>  
>  	drm_exec_init(&submit->exec, flags, submit->nr_bos);
> +	submit->has_exec = true;
>  
>  	drm_exec_until_all_locked (&submit->exec) {
>  		ret = drm_exec_lock_obj(&submit->exec,
> @@ -523,7 +525,7 @@ static void submit_cleanup(struct msm_gem_submit *submit, bool error)
>  	if (error)
>  		submit_unpin_objects(submit);
>  
> -	if (submit->exec.objects)
> +	if (submit->has_exec)
>  		drm_exec_fini(&submit->exec);
>  
>  	/* if job wasn't enqueued to scheduler, early retirement: */

