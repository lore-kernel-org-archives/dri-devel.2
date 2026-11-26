Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F094606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4xjYGXZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B323112157;
	Thu, 26 Nov 2026 12:19:32 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16FC510E2ED
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfOGGH6Ep49EZkKv19IpcEecOO9WCLDH1hvmD2sPsRZeDqQWz4oP0Zby6gWP99kQJIwbiTug/MRZZz+AXaBbKUzWDbFrKwnq6Uibm9KxjAg8rIY7V5MBbpP0w/7fUFmGDtbZgjSKkWpC58C/wAy+9WJPh0jWzqueTioJn4m19v2bILZbOL5TMUzhQWD/Ucwk6WGKEM0oXadgzByymuJxam3Wy3EKE2/qzQJRJTTE5Y708h12wI7wBlNW5m6+mEYR6adJ6RFE7nVI/qMfB6DUM2Z8OoG/BVa9EGYsite+gYerAXhZd3f0LX9XQGvw/Xy/0nAkQS0NfBINDfZ3H4U0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ndxSdIej7FOJOtcK1BgDxqGC7LZ1xn7QI9kbX9UNkw=;
 b=XerlD7JnWPPE3MUY/eCglHHVcQ8fZVE3HkgZWCqbT7brEJWs19dW/cDMQcKHjFdnwrwVxrX8+DzldDMfzoBtV9PeTfViiee7O6Ar4PSodBQ5qPjx4bc1V37utls7I0x3T/9nP0JjW97iu9Pou2ZMVmfryAcLoCaVyhIy9UQfUWIFgtiduO6MjZQOE2VTys9gpnrveSaK2Y26I28OHtifrHBYxUTZwnjnzVV1dPvdqvWmlEE1fd/1GxOlLGiuCznWuu3byMzRo7YkRIWd/ZLaCdtexEhKEeOxXMey4Mc3phn6T8GEYLSOMJKHakL3EZIIf+Cq7k0/XAqzEQZSKqP0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ndxSdIej7FOJOtcK1BgDxqGC7LZ1xn7QI9kbX9UNkw=;
 b=4xjYGXZXras49P7Oc4/8xuRxuY5uWnloPogsJPeKcdUhZXWdXPTGzOej44Ru9qKgd60BEdKVQIgnTgeKMDp9A5NUMop4eoTVHngl+D++hLTO/tbu7y5LluQPZihn/BGxqAvfhzbE564iXD0tEe/YpFYcMstTWPDibW0KFn2ww8U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 12:19:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 12:19:21 +0000
Message-ID: <ba9e1f8d-abd7-4254-ba78-09d3b2f10f22@amd.com>
Date: Thu, 26 Nov 2026 13:19:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_timeline_signal_ioctl chains
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Fei Yu <fei.yu@intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-6-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126111117.67342-6-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0350.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c83765-d73a-408e-4ae8-08df4bb78069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|6133799003|261009223027099003|261009221227099003|22082099003|18002099003|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 7s9MKv1tcRVUrSfeEbAPCCkdFaCdEK2Gm0manIMna1AFb6W5LpontHx3EznGFzFJk9X6WUfpVxUsZgptP0K6BkRYuBX/4r/7yzXIp2Hf+uKZ0czkBga8hncQmYk6+8f8hE1q3H+Bw9PSFAt1MJtFIoiroRJi91atOehSaUus0TKNmi+h7MGX7HFQn2DOh0YfoUb5KadQZfP81beECiyCx5BzCqYtJ4ump0pZzq2az6CS04FFEG1eGHlJMQ80JhOa0Ug/QZNghqgpf0zrrTu67JGgcXls5ZjTfsznp/639iu/HYEA1/gT19v4cl2VzYPlFe3VZw/k0ovZgxoJWyEGWtJtAockGLF2D6G+Tfww1K5EviVg+aRj9fz4Bq7yeDwcxxTDXf+IeIUc6c9PxkeLXXApDtNRwbcz1SdW0asX3jVdc/iJM5kKUWGyWf3+o57JMsdYwM45bDjD2phCKIY1THCVwhJUKh3tA3bHRjcObrDV7F33apKn8+Dfnckrw1x7Lu+Ok786ltaw2pZzvlUTrqBeDow40vllpChPJmFIEUcBSRMkFOrWLEMqJ35WChajdmaE22PuyiHZ4Ah7Z3+mQRj47OM4+bv2/Blsk/A/kGTL3P7OpRsvo9fiiy/JdKMi3uT1ZKdRmODTWN6cqK7skBZWPfoDIk0yUpq4+yRdvPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(6133799003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG9uUWVPY1dMdFYyNk9aYW9pRTFPakxBblNZRlpNQmgyR2pVemx0R1J2ZVJN?=
 =?utf-8?B?cHNMa3pxSW9paGRRRTY2UXBhY0dUTUpHQXhzaEtZUjZoMnhUT09vSlhKODQ0?=
 =?utf-8?B?a3UyM0tUUDFTQjFiQVg2VnVVRWJqdytKa25KNEhkcUVWSzk5cVBQYSsyRkhV?=
 =?utf-8?B?T3liVVZUNSt6SVN0bjMvM0NXY0NxanBTUnRpMTVaZmwrWlhpMFJvY1E1ayt6?=
 =?utf-8?B?V05odko3SUFTN0lpV291Z2lqTldOSnNIc2NUbkJaTjZDTEJvNWVqV2Q5bUln?=
 =?utf-8?B?ck1pOFZ3V0RXTjdIMTIxOG84OWsxUGFRd01UNFVxRDNNSVZUTTlZQWRyeFZM?=
 =?utf-8?B?Tm1NREhkaTBjd1lxYm5HWHBXY3dEREhqOTBNRXZEUDhQZUFBaUFwa254R0sw?=
 =?utf-8?B?L21aSVZxQVJNN2ZrUVpnbnU3VFhiN2tBUlY4MFJhMi9kbHBOVGR5bGpwRVJv?=
 =?utf-8?B?WDQ3OGowNFg1cWxNL0djalhtZHNJeitwR3U4MFBTWHZhVFlIdE5aYVdSRndt?=
 =?utf-8?B?RW4yRFhBQmN3UG01ajh5UmFxZmtBc1gwSXJ1MDhZR2V5SFJYeHVVSHU2TEVH?=
 =?utf-8?B?aUNJSXhVRS96dkVJdXU1RFRIUTRtbnNoaWdOMjlBUkY0UEkxeTJqYUFEQXJp?=
 =?utf-8?B?ME90NjJrczhQY09lc0ZWU3dQVHNWT2dDTXozOXM0T0FMaHVUZDdPeXVzTitT?=
 =?utf-8?B?SlJyVFFtZVhkWWtNeTR4Z1AzTmxaQ2FJVmNVVTFVM3VWWm11Wk9jVlpGWnlI?=
 =?utf-8?B?OGpza2tNVlV1bmJjT1U3WnVaZDZjZWxwM0g2eGFKNE1mNkNaMGFEYk44MWRK?=
 =?utf-8?B?eUdsYWpicGx4T1dReC9kc01kUVM0NDh6ZFVjZFRGcXBpeHE5V0lrTndMUXpQ?=
 =?utf-8?B?c2lxcFF2bXNYZHVzY2FPUGJtbFR6QkNaVmpZNTJDdklhZklpZkUxS2xJS09P?=
 =?utf-8?B?UWwvS3ZzSlZST01PSHN4TFhRR2loTTYzUGFyTngxMnRWWW1WZFEvb0NBbGhZ?=
 =?utf-8?B?RGNTTWNQelJ6Zk14QUNJbzZLelY0a3lkTHcrN1N5aTZCUjNXN2k3ZnFiUHFU?=
 =?utf-8?B?dnJ6NFFUeGlRdUo2OFZ2Y2FRRjJxUTAvVUpJdndxMm50dmpYZ1BIYlhDZXNE?=
 =?utf-8?B?S0dCLzdmeStRSW02Wk4wU2N5Wk1VRzdyNG5Zclp2cmhMdTVLQm4xTXlRaWEw?=
 =?utf-8?B?Sk1ZN0xOMWJkczV2UkNFNmY3N0NTaXhyOWl3OVJSVEorMWxNU0M1V0FZSzV6?=
 =?utf-8?B?ckdkZVdaMnlLd0RMTzB1NkpDRDloeUQrQU5xK2N6Y3U5WU9SYjdJYndCQ1Y5?=
 =?utf-8?B?dU5TbEpPWjMyTy9KYjE3UTF6MlREbmo4Z0J4bUxpRXk3enpxaGFUOVN6UFVF?=
 =?utf-8?B?d2huWlhnSUNHdnh3blJ2Y0hWa24wUFNOTEdma2lZUEtZMjlVOGI1Y3FqaUJN?=
 =?utf-8?B?YVQ1aVk1WlUzRFJldE9ITTJHMmM0REFTS3ptMmZQZ3E2VjlYS1JsYmJFRGRi?=
 =?utf-8?B?NUdHL1EwZFdLM1hXdXRHcm5EOUdWWExIa1E4UHFleHRDYjRhRktXSktLdFN1?=
 =?utf-8?B?Vm5pSzVQR0pwRXhTSG9KTzNOcit5ZWs5L2lSQ2tWU1lIL09hN1NDb1BIaVZv?=
 =?utf-8?B?cERDamxMZ2lhZS95VjdmNk5KMk1WL3V2MVM0TkJVdFc4OVBub1VJUHdDS0Fx?=
 =?utf-8?B?TlVQTmpQOG0waVd6T2o1bS9mT1p1RUpsbWFNZGdkcWR6TmNKUDFzempHWHVK?=
 =?utf-8?B?K2RFWGEvS3hzR3lwUUdTYnhnR2FXMlAvbnFEMjZzbXEyb3JSQ2hjRGtha2xa?=
 =?utf-8?B?ZTNKWlk2Kys0ZlBYTm1sTVZIR2JSaDZhU1ErQzhpMXd4Sk5NRi94TWZsQkJu?=
 =?utf-8?B?MjBnNzlQZGIxdm85Q29uRDZmdkZ2ZVVZRk1ac3hGaHVZeWdxVEJFNzNBbWd1?=
 =?utf-8?B?eXFWeU9qaC80Z2hocHBHS0hyQVZmMnpQckFzSGlmSWFLTEdTKzAvcmg2enRG?=
 =?utf-8?B?YjQ1bmxDSHlFS2M5bzBML3pVRXRFT01zQWxpSjJaT24zMVA3cGRZLzUrazBy?=
 =?utf-8?B?cTJiOXl1ZlV2c3dnUm9pVjRSQWFtcXhXbXNibm0vblZvOE5FVk1pMkYwbHZu?=
 =?utf-8?B?TDBvNUhDa29CMFdXZjBxcTFjbmg3dlRtWXo5cmV0TXpjeFQ3QjFPcTV3UFNW?=
 =?utf-8?B?QTJlY1JaK3JVUVFzR0VEMkJWLzNJeGpacHdGMXR4bUNSYWRQNXVtK0s3MDdJ?=
 =?utf-8?B?Wm42Ky9hczlON0pkUUpxcEYrbDBiL2hNSEJ2SXlxWlZwKytWdDQyeVlsd3k1?=
 =?utf-8?Q?Nexk3z2VLNeEyVj/aR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c83765-d73a-408e-4ae8-08df4bb78069
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 12:19:21.7045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTj+CrHzO7Z4DdO1ZPAV1JGqTass4aoSQi2LrANr/V8DSKHFlQd8SkEN+NEeDSSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 12:11, Tvrtko Ursulin wrote:
> Use scoped cleanup for drm_syncobj_timeline_signal_ioctl chains array
> allocation.
> 
> This is a split out step towards converting the whole function with the
> goal of simpler error handling and easier extending with a fast path in
> the future.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Fei Yu <fei.yu@intel.com>
> Cc: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 41 +++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index e05051c3895f..da90ae11382e 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1566,15 +1566,33 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
>  	return ret;
>  }
>  
> +struct syncobj_chains {
> +	struct dma_fence_chain **chains;
> +	unsigned int count;
> +};
> +
> +static void syncobj_chains_free(struct syncobj_chains *c)
> +{
> +	if (!c->chains)
> +		return;
> +
> +	for (unsigned int i = 0; i < c->count; i++)
> +		dma_fence_chain_free(c->chains[i]);
> +
> +	kvfree(c->chains);

Yeah same here, I would only remove the kvfree and not the refcounting cleanup.

Regards,
Christian.

> +}
> +
> +DEFINE_FREE(syncobj_chains, struct syncobj_chains, syncobj_chains_free(&_T))
> +
>  int
>  drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  				  struct drm_file *file_private)
>  {
>  	struct drm_syncobj_timeline_array *args = data;
> +	struct syncobj_chains chains __free(syncobj_chains) = {};
>  	u64 *points __free(kvfree) = NULL;
>  	struct drm_syncobj **syncobjs;
> -	struct dma_fence_chain **chains;
> -	uint32_t i, j;
> +	unsigned int i;
>  	int ret;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_SYNCOBJ_TIMELINE))
> @@ -1606,30 +1624,29 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  		goto out;
>  	}
>  
> -	chains = kvmalloc_objs(*chains, args->count_handles);
> -	if (!chains) {
> +	chains.chains = kvmalloc_objs(*chains.chains, args->count_handles);
> +	if (!chains.chains) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
>  	for (i = 0; i < args->count_handles; i++) {
> -		chains[i] = dma_fence_chain_alloc();
> -		if (!chains[i]) {
> -			for (j = 0; j < i; j++)
> -				dma_fence_chain_free(chains[j]);
> +		chains.chains[i] = dma_fence_chain_alloc();
> +		if (!chains.chains[i]) {
>  			ret = -ENOMEM;
> -			goto err_chains;
> +			goto out;
>  		}
> +		chains.count++;
>  	}
>  
>  	for (i = 0; i < args->count_handles; i++) {
>  		struct dma_fence *fence = dma_fence_get_stub();
>  
> -		drm_syncobj_add_point(syncobjs[i], chains[i],
> +		drm_syncobj_add_point(syncobjs[i], chains.chains[i],
>  				      fence, points[i]);
> +		chains.chains[i] = NULL; /* Ownership transferred to syncobj */
>  		dma_fence_put(fence);
>  	}
> -err_chains:
> -	kvfree(chains);
> +
>  out:
>  	drm_syncobj_array_free(syncobjs, args->count_handles);
>  

