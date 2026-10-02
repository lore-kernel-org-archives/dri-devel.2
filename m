Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F38DCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC5D10E475;
	Fri,  2 Oct 2026 11:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrQ9YVpv";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F00010E475;
 Fri,  2 Oct 2026 11:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM8jVP6+ggq4/MRduzlTalNXADtx6prqOwdH2eb7hCSm7dU1uIMggkKmgRw6AFyoB22e6hmUPj8Kf/jbrzC49xpjF9GKGaGzfHbY256wdm6sKNBiL5/4WvXmOXr1N3Idkj5MwgjmQbW3KsCr58LMjZrXZdHRsH0FFiXdkb8U309C60XR1daln1qmx9JxgIvW4wQ/m37tncjqcRftaIz5bSaNjjRGT7mIVRZV+m9m0l56K1OAPqqUBZPes+uW32CQmzNPkccftTPfvfAI18NGEf4U1FAyInQIp/tblUiBm3zPQsie8y7uttr7+LDuK4WfBZhZtrnTAYU1Bhs6WFLnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+8XcIFpfpFrdJlo6MVKvZW9tgq3EkUyF9na3lZs8Kk=;
 b=ulc3FLVYCVWAAqjnMLK+XND0wulKqrSjrc9UKXhU2vnVQzd1pMontJsi2mbLhETcLXgNOu8SF50KcUNMrd2VsEjsaWzQjJXLrMTbROMh9P6JyU+jLOv2Pzq+xhg39s4FAzcK/NBrpbCorcSjSo4/p2EAs3OVkPm+06vs65WQmdihcuVt3aXE9lTwJFkKrlemQ5Blk6pE9ZayDHh6zNZe6mvh+7OR+C2EU5+WRXWQhpyldf9r4hxeWC6tWtGX3YbU0DvNDYUYRHa9jl4WeHjRVylfxr2YWJwJFw5JFO3kiCv2abpcaK+nVzb/hFLVAZtc8BhljuLQ2QPUPOQLZbhx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+8XcIFpfpFrdJlo6MVKvZW9tgq3EkUyF9na3lZs8Kk=;
 b=nrQ9YVpvYxlDva1u1oWsgSHqOvDx12ryXGc9Np2JCkymEFymttEcg4tbZIs208TCMkA0vUdfApwyfYfPUKCO7CwLE558zLEq8fEDIMNKheNujffZkZVh+flFYZ7AGhYuL8kb+iU5hEfTFXzqhLu3DfycLhJPxF8e4HLRlwxYqX0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV1PR12MB999306.namprd12.prod.outlook.com (2603:10b6:408:3f8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:35:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:35:41 +0000
Message-ID: <9b363165-9e1e-43be-bd54-b1c420e047ca@amd.com>
Date: Fri, 2 Oct 2026 13:35:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/exec: track the first few locked objects inline
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20261002003816.3233277-1-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261002003816.3233277-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0441.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV1PR12MB999306:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e17298-0cc6-49ee-69fb-08df207949d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|23010399003|1800799024|376014|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: I5pQlgrD/fj/lRdAO4W5EugrV/oslbMUdZm4XGNYIqNAfaGBgXPJLKdlTVMKLcnoxKr06CDdlt3lbsae9vsdjEg/telJoZttph+szgFQ4lOBvY7YUQxKJXO2s15cJlToKJbGJUmLxFRhlhk3PTsfIa9K4zO+iFEMKqOuzfHIkQGg/LOji+RpIRB5WDvyzyXK6XJ/HX7jTIV/NKtF2s+Q5Y+p6h3FvTwubAONVhI+CYMBdJqcPV27DtXm58+AkOQhlcoab3tDhXWfGQS4+HEWkn8NL00MEMKqthvO+cbDOIIalxAw+vhZd4+rH3JR/owKOO1JHQTZwCZtLaPWewgd+wG4y0VUgZSyS8aD85rNRNGW9Ub96Sgw/kGSgdOHa1atKyBN+oTErKCiy6RECXK8sEQxFuIW97FZpvsPO5mzHz1EZnQKyjr/18dbl9uyVCF3+C/AEzgzG+Hgpsfkfe+GNC4i1CjL3A9Wb5l7fely3TpKCOINq3tUvaQMY0jpXNa3+4wPRVkrj9ZE79L+N6a8JTFQ9RmR7o/UJ/Q96imZMi6xXEuvOSnLJvbfCHP2hb/UWiCi4+e2XiwLgI0tnxC+9gKroCYIC6zYFRAcIATYEa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9rQ2trdTV2MWZvWlZDVVRaR1U5MWQ0TU9IZ2s4Ym1nVHd6cjlqTkw2WjBm?=
 =?utf-8?B?eThHOERPVStYUmNHd09pSjEyM0FpNzRQY1N1cjZ6TlpINzdDdkJqa01vdGVL?=
 =?utf-8?B?R05NSk53Q1lJdXlNbE50a0xBWUg1bTE0cGpVVzRwTEp3UHVNZnFOcXRJNTU2?=
 =?utf-8?B?N3ZITEhlQXVUaWN3Z3ZxRStHNGF0RlQ3QkFFY2IrSTNya1F3ZjU0TUFOelpw?=
 =?utf-8?B?bXNRN1lFODJDR0NvOUJhaHgzOElneGtaY3JmOVVTbEhoQ3Uwc0ZYRFc3alFN?=
 =?utf-8?B?eE9wVFZqS1lTK25xaTRJZzBWOU0way8vT0Z1Qjg5SEhjYWNaTGdBVUsrSHIw?=
 =?utf-8?B?dHczcTZEbXJadEhPblcwKzJJRG9iTjRQNXd4UVB1TmlINGw4SXVReHA2MC92?=
 =?utf-8?B?L3pMVGlKVVRVOUUyMTJKNWtHdVlEVTlra01ncFpTZDVWeXJXN1VLb1VDSWh2?=
 =?utf-8?B?SGxhNHQxbzlNUTdRd1RvT1lRUHdWNUlHTFMxOVJyWmE2K2hKN3ZiS3NTdmRI?=
 =?utf-8?B?aGE0NnY3YXlKMjRHYS96ZVN4UytRZXltT0JyOGRJdmlPcFR1WUliaEZCQWx0?=
 =?utf-8?B?VWN4Q245QmhXYXZRL3M3M1N1OHh2LzZYYUtHdmEwcENrVUo0RGxZV0xrS21o?=
 =?utf-8?B?VWRhUkJhYVVNVjNVSUtiT3ZjVURDNEtPU1RKUitjY0ltUmlLbGR6WmpqOFdx?=
 =?utf-8?B?WDE0QzBXR0NFQm1yU2dTOEJsSU0xQzJ1SzhDMkg2RXpJUllhYVRPR0tyNjVk?=
 =?utf-8?B?eGtqWXFBbTBib0RTQ2RsM0hDYi9KVmR1MnV6WWlGU0NWRHY4L3B0NTE5YXcz?=
 =?utf-8?B?cXdZYUZidXRsUTJoUzJTcUltU2VoRms2dnBXQlZtL2tVYVpVMDZQZ2lHL3Er?=
 =?utf-8?B?R09CM1NDNUNyYng5bC8vRnRHdW9xcm5XZWkrUDMyRnh3YTZJQkFDRUFQRm93?=
 =?utf-8?B?Y1J5bGRhUG1ldHdPYndrdlYwSUQ0b05pZ1Y3RkFTZzNMbHplSG5zQzd1OTdo?=
 =?utf-8?B?cEVyazVUT1JyZmI4RFgydHhCQ2RKZzhMdHMySFEvQ1drUzVLRDExdjNSMVBM?=
 =?utf-8?B?U2dZeVh6VjJnQWhyTjBhWFZ0UmFmUlFib3hRMWE5V1RwQzFMOUIyRkRxWE9K?=
 =?utf-8?B?YklzcWhVeTFnKzlRS0p2MjBRK2FwYkYwZmVyRU9aWUhJS0dsdkRWQTI1emZW?=
 =?utf-8?B?aC9weTViN0dXMTlQL0MycERYTEhHdFlheDZESDVPbkZJNDNpSFduamlGbDdQ?=
 =?utf-8?B?Ulc1V1ZseDRHeXNmT1l1dmlzNGtDdk90K0tLUWlRUVFZNkNuSFIrVERsb3Mv?=
 =?utf-8?B?NUs5QTNTNVhOL1hVZ3JVckwyL0V0UG9nM2xtVkhPNk16cnZpUlY5Ulo0eTA3?=
 =?utf-8?B?MUtSODdKR00xZVhtMEMvckVIUTBJTlcvS2RUaWRpWTZOSlFNbUd2SFNnbjls?=
 =?utf-8?B?L0J5aTE2UW5MQVJDZWQ5ZTIxVnVrMS9BYUZBVDF1TitORnU1Sm5jeXdaajZL?=
 =?utf-8?B?NUFhT2hJMHdGQ2ExcVI5M2g3K011cDRueExvNHhCYVM3RDg0ZW5NdjMyUkJ2?=
 =?utf-8?B?NjhJU0hRSnZVdVhWeXhyRWJyYkU5RTlqLzYxTWJHZVlrUGQ2T3FxWlY0REww?=
 =?utf-8?B?bXU0aHhrU2NZaVpTWFE0RUNoc09IaEd2RFJvTFdVOXA5aEszdkZ4KzFqOTZ5?=
 =?utf-8?B?RHR1YnZQTFZmejVaalQxbGJGNXYwbTFYcFRURzBLNU5yRER5Vk9XeVR6RHRB?=
 =?utf-8?B?UHNaYmpJWVh5ME1WOGR6Zk9UM0RrOGVKWUlEYlhzSkY3SGt4VWdPZFBwdkVV?=
 =?utf-8?B?cS9hUGRROHY2Qzh6eEJDY2w2cVc3amxyQnZrRm9CQUtxRkt0Y0xvVmIxeGxu?=
 =?utf-8?B?UHZUeFpvOThzM3NMWG1PMjk5ZTBLT2FEd09nZWs3SkUyelpLVHJpRUpwMmlN?=
 =?utf-8?B?MUZJYS93ZUxxZ0FEMDJsQUVmd0NNR2drSkJKQVVsZXdPV0hjbGZnVytoU3VO?=
 =?utf-8?B?RjJmdFNCakU0ZGV1TTF0TFR1UVlkM3VBeFhKMUE3THZaSm95WTc1bm8wV212?=
 =?utf-8?B?WGZ1UHBFOFVBdnpNekV0aXY2U3ZqaWJYUDRRbk5qUDBRdDdRT0xOWnZyUHh5?=
 =?utf-8?B?dFRUSE5IYXJnU1hwZFRQRkx5bFVMUGlpNHY0SERCeTR2aCtzYktVSkNuV3BI?=
 =?utf-8?B?KzZWLzFUaHdjeDFDTFlobVB6ZThuTGdUZXl5aGRpNDQzRXlZb2lSRGlZNkM3?=
 =?utf-8?B?UUF6elM0OUxLbVdWQ2c2UU13SUZJZ3k4UUVHN25obWpOQWkvWGpsZnkzbGVo?=
 =?utf-8?Q?9DZ/zWovCWBahPNMJC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e17298-0cc6-49ee-69fb-08df207949d3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:35:41.3705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aj+l9ZSJa1NVJBkEUHRCSUHw6RFsEw17AZ7/pbPwdDTVE6BbnkYXFk3nsQM/Lifq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999306
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

On 10/2/26 02:38, Matthew Brost wrote:
> drm_exec_init() always allocates the table of locked objects, a whole
> page of it unless the caller asks for a specific size. Many users only
> ever lock a handful of objects, often just a VM's common dma-resv and
> one BO, yet still pay for an allocation, and any of them can fail with
> -ENOMEM. That is awkward on paths which can't fail, such as dropping
> what may be the last reference of a drm_gpuvm_bo, which needs both the
> VM's and the BO's dma-resv held; drivers end up open coding the ww_mutex
> dance instead.
> 
> Keep room for DRM_EXEC_INLINE_OBJECTS (8) objects within struct drm_exec
> itself and track the first locked objects there. Only once more are
> locked does the table move to an allocation, which then grows as before.
> A caller passing nr larger than that still gets an allocated table of
> that size up front, falling back to the inline one should that fail.
> 
> As a result, locking up to DRM_EXEC_INLINE_OBJECTS objects never
> allocates memory and cannot fail with -ENOMEM, and callers passing
> nr == 0 no longer allocate a page they mostly don't need. The cost is
> 64 bytes more of struct drm_exec, which typically lives on the stack.
> 
> Since objects may now point into the struct itself, a struct drm_exec
> must not be moved or copied after drm_exec_init(); no user does so.
> 
> Add a KUnit test which locks one object more than fits inline, checking
> that the table moves out of the struct only then, that every object is
> tracked across the move, and that a large nr skips the inline table.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Assisted-by: LLM

I Was considering that as well at some point when I found that using an xarray is actually quite a bit slower than just pre-allocating using kmalloc.

No time to review that in deep, but feel free to add Acked-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

> 
> ---
> This came out of a Sashiko review of the two-pass GPUVM series [1],
> which flagged a nouveau cleanup path dropping a drm_gpuvm_bo with
> drm_exec and silently carrying on if locking failed with -ENOMEM.
> Grabbing a small number of locks on paths which cannot fail is quite
> common, and drm_exec should provide a ww transaction wrapper for that
> which can't fail, rather than drivers open coding the ww_mutex dance.
> 
> [1] https://sashiko.dev/#/patchset/20261001220632.3190896-1-matthew.brost%40intel.com
> ---
>  drivers/gpu/drm/drm_exec.c            | 39 +++++++++++++------
>  drivers/gpu/drm/tests/drm_exec_test.c | 55 +++++++++++++++++++++++++++
>  include/drm/drm_exec.h                | 18 ++++++++-
>  3 files changed, 99 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> index 2453ec41360f..bdc9c79359b3 100644
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c
> @@ -70,19 +70,26 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
>   *
>   * Initialize the object and make sure that we can track locked objects.
>   *
> - * If nr is non-zero then it is used as the initial objects table size.
> - * In either case, the table will grow (be re-allocated) on demand.
> + * The first %DRM_EXEC_INLINE_OBJECTS locked objects are tracked within @exec
> + * itself, so locking no more than that never allocates memory. If nr is larger
> + * than that, it is used as the initial size of an allocated objects table
> + * instead. In either case, the table will grow (be re-allocated) on demand.
>   */
>  void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned nr)
>  {
> -	if (!nr)
> -		nr = PAGE_SIZE / sizeof(void *);
> +	exec->objects = NULL;
> +	if (nr > DRM_EXEC_INLINE_OBJECTS)
> +		exec->objects = kvmalloc_objs(*exec->objects, nr);
>  
> -	exec->flags = flags;
> -	exec->objects = kvmalloc_objs(*exec->objects, nr);
> +	/* If allocation here fails, just delay that till it is needed */
> +	if (exec->objects) {
> +		exec->max_objects = nr;
> +	} else {
> +		exec->objects = exec->inline_objects;
> +		exec->max_objects = DRM_EXEC_INLINE_OBJECTS;
> +	}
>  
> -	/* If allocation here fails, just delay that till the first use */
> -	exec->max_objects = exec->objects ? nr : 0;
> +	exec->flags = flags;
>  	exec->num_objects = 0;
>  	exec->contended = DRM_EXEC_DUMMY;
>  	exec->prelocked = NULL;
> @@ -99,7 +106,8 @@ EXPORT_SYMBOL(drm_exec_init);
>  void drm_exec_fini(struct drm_exec *exec)
>  {
>  	drm_exec_unlock_all(exec);
> -	kvfree(exec->objects);
> +	if (exec->objects != exec->inline_objects)
> +		kvfree(exec->objects);
>  	if (exec->contended != DRM_EXEC_DUMMY) {
>  		drm_gem_object_put(exec->contended);
>  		ww_acquire_fini(&exec->ticket);
> @@ -140,9 +148,16 @@ static int drm_exec_obj_locked(struct drm_exec *exec,
>  {
>  	if (unlikely(exec->num_objects == exec->max_objects)) {
>  		size_t size = exec->max_objects * sizeof(void *);
> -		void *tmp;
> -
> -		tmp = kvrealloc(exec->objects, size + PAGE_SIZE, GFP_KERNEL);
> +		struct drm_gem_object **tmp;
> +
> +		if (exec->objects == exec->inline_objects) {
> +			tmp = kvmalloc(size + PAGE_SIZE, GFP_KERNEL);
> +			if (tmp)
> +				memcpy(tmp, exec->objects, size);
> +		} else {
> +			tmp = kvrealloc(exec->objects, size + PAGE_SIZE,
> +					GFP_KERNEL);
> +		}
>  		if (!tmp)
>  			return -ENOMEM;
>  
> diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/tests/drm_exec_test.c
> index 7a374e462348..434ab9c59878 100644
> --- a/drivers/gpu/drm/tests/drm_exec_test.c
> +++ b/drivers/gpu/drm/tests/drm_exec_test.c
> @@ -204,6 +204,60 @@ static void test_multiple_loops(struct kunit *test)
>  	KUNIT_SUCCEED(test);
>  }
>  
> +static void test_inline_objects(struct kunit *test)
> +{
> +	struct drm_exec_priv *priv = test->priv;
> +	const unsigned int count = DRM_EXEC_INLINE_OBJECTS + 1;
> +	DECLARE_BITMAP(seen, DRM_EXEC_INLINE_OBJECTS + 1) = {};
> +	struct drm_gem_object *gobj, *obj;
> +	struct drm_exec exec;
> +	unsigned int i;
> +	int ret = 0;
> +
> +	gobj = kunit_kcalloc(test, count, sizeof(*gobj), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, gobj);
> +
> +	for (i = 0; i < count; i++)
> +		drm_gem_private_object_init(priv->drm, &gobj[i], PAGE_SIZE);
> +
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +	KUNIT_EXPECT_PTR_EQ(test, exec.objects, &exec.inline_objects[0]);
> +	drm_exec_until_all_locked(&exec) {
> +		for (i = 0; i < count; i++) {
> +			ret = drm_exec_lock_obj(&exec, &gobj[i]);
> +			drm_exec_retry_on_contention(&exec);
> +			if (ret)
> +				break;
> +
> +			/* Only spills out of the struct past the inline ones */
> +			if (exec.num_objects <= DRM_EXEC_INLINE_OBJECTS)
> +				KUNIT_EXPECT_PTR_EQ(test, exec.objects,
> +						    &exec.inline_objects[0]);
> +			else
> +				KUNIT_EXPECT_PTR_NE(test, exec.objects,
> +						    &exec.inline_objects[0]);
> +		}
> +	}
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, exec.num_objects, count);
> +	/* Contention may reorder them, but each must be tracked once */
> +	drm_exec_for_each_locked_object(&exec, obj) {
> +		KUNIT_ASSERT_TRUE(test, obj >= gobj && obj < gobj + count);
> +		KUNIT_EXPECT_FALSE(test, test_and_set_bit(obj - gobj, seen));
> +	}
> +	KUNIT_EXPECT_TRUE(test, bitmap_full(seen, count));
> +	drm_exec_fini(&exec);
> +
> +	/* A larger initial size skips the inline objects altogether */
> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, count);
> +	KUNIT_EXPECT_PTR_NE(test, exec.objects, &exec.inline_objects[0]);
> +	KUNIT_EXPECT_EQ(test, exec.max_objects, count);
> +	drm_exec_fini(&exec);
> +
> +	for (i = 0; i < count; i++)
> +		drm_gem_private_object_fini(&gobj[i]);
> +}
> +
>  static struct kunit_case drm_exec_tests[] = {
>  	KUNIT_CASE(sanitycheck),
>  	KUNIT_CASE(test_lock),
> @@ -212,6 +266,7 @@ static struct kunit_case drm_exec_tests[] = {
>  	KUNIT_CASE(test_prepare),
>  	KUNIT_CASE(test_prepare_array),
>  	KUNIT_CASE(test_multiple_loops),
> +	KUNIT_CASE(test_inline_objects),
>  	{}
>  };
>  
> diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> index cc2937185a9f..ddbdd745efd9 100644
> --- a/include/drm/drm_exec.h
> +++ b/include/drm/drm_exec.h
> @@ -15,6 +15,12 @@
>   */
>  #define DRM_EXEC_DUMMY ((void *)~0)
>  
> +/*
> + * Number of locked objects tracked inside &struct drm_exec itself. Locking at
> + * most this many objects never allocates memory for tracking them.
> + */
> +#define DRM_EXEC_INLINE_OBJECTS	8
> +
>  struct drm_gem_object;
>  
>  /**
> @@ -42,7 +48,8 @@ struct drm_exec {
>  	unsigned int		max_objects;
>  
>  	/**
> -	 * @objects: array of the locked objects
> +	 * @objects: array of the locked objects, either @inline_objects or
> +	 * allocated once more objects need tracking than it can hold
>  	 */
>  	struct drm_gem_object	**objects;
>  
> @@ -55,6 +62,15 @@ struct drm_exec {
>  	 * @prelocked: already locked GEM object due to contention
>  	 */
>  	struct drm_gem_object *prelocked;
> +
> +	/**
> +	 * @inline_objects: storage for the first %DRM_EXEC_INLINE_OBJECTS
> +	 * locked objects, so that locking only a few objects does not need to
> +	 * allocate memory, and therefore cannot fail with -ENOMEM. As @objects
> +	 * may point here, a &struct drm_exec must not be moved or copied after
> +	 * drm_exec_init().
> +	 */
> +	struct drm_gem_object	*inline_objects[DRM_EXEC_INLINE_OBJECTS];
>  };
>  
>  /**

