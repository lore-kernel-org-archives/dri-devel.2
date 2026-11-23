Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84377606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mkv1ZgAn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A8810F26E;
	Mon, 23 Nov 2026 22:58:16 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C19910F26E;
 Mon, 23 Nov 2026 22:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yollGbkAN0ehweZ7Iv5/Um9EaYcuRvgDRuFRdvt+bM4s5LQSSfPGWdWSxLeagZUrQKMYDMuRupXu9LTOzzPdBYcwPz5FzjtibgnkR5uAuAyqCGI1xmG56tJd1uPXdhPhHfbpMCJ3sLQjqeDWNdcgbXMEJdpWy5+AyvWAvOQkTOt6hCbydrEGdUT0Odw+fSUFHSqPpKQPbWHNX0Mk7hn5wUg5jvfIShtuz3L0pL1FKM8VSBBQickm4d+oroKmlzJDLcsnITfUE2mJE7YB4J49rFs4d97PlnZLNKHEdxVvTcPxzn8BPLcW8M7JLDZr29/Xojd/5G5e4XxNQ9S/lGZ0cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFDBMzlFGEIu6CgmM1DzXVdMeP80n4CdMSS+466IIz4=;
 b=KrEwnskbvZC1y6k5CrA4dZGiQ/AvN/TEslVA3MnovfYnEF4M1CZYpmK7bPbHjV/+donve7SRmXcH/zNFPB1+N62hfrwyZ3VTqU34/aRGp2jpUxJutB3ftjnqwrxFIvuMa6m0ftot9k88+k89cbeC5nNA20ZvsYu2nzxiXDrLD1FxKlopCrPEWKzPcVW7028xVwwNGddmalXZDIuywP8+szQE3t06TZM+1pZaP4n+I9ZyP0nvyS0H+XHSh0O4cfmgbiFHAsVxrf72zMmA0iGaH5Vm0fV5erwB9N4vHc3qpQQydrK528Jedi8C5khHDQ9hKCHcMiL2khU6HFYwxW/eqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFDBMzlFGEIu6CgmM1DzXVdMeP80n4CdMSS+466IIz4=;
 b=mkv1ZgAnMlFfXrlOo8v4eOGGZ+cQEWFw3JTGHTI5cH0DuUHYqPdIgTkqdEFnEqwJgPjPaHlY2R98Em+v8v5fEBYqKkhLmpyzP4Rw/c7mAyGzjMojdk61B+nsVyk8XS9DdnplSdHD1DZtYbXyrb36ufCbmjaIICMQ7JIBe64zfgLZamm1p1IRmPGmlveO9y+oXXxNrD0+m8Xe328ApRaYx8qjaRnu7dAaKWPuAZa4cHzdyA0XxLC7Gq3HHbDhHP6RYnTf+Movu9jlHIvY2rJ43Qx5wyY4dow7CGoMCjdw89MMquY4q6o9xPxZmyrMHPIm0cXW5tHTvqOyAXGVgSwKvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by DS6PR12MB324412.namprd12.prod.outlook.com (2603:10b6:8:498::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 22:58:06 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 22:58:06 +0000
Message-ID: <75df628a-fdc2-4cd2-b052-26b122d45251@nvidia.com>
Date: Mon, 23 Nov 2026 14:58:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/nouveau: add option to leave GSP-capable GPUs
 to other drivers
To: airlied@redhat.com, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 nova-gpu@lists.linux.dev
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
 <20261123-nova-nouveau-gsp-v2-2-5e8c27aa8555@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261123-nova-nouveau-gsp-v2-2-5e8c27aa8555@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|DS6PR12MB324412:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d850d00-a688-412a-cac8-08df49b53c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|10067099003|5023799004|11063799006|4143699003|56012099006|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: NhSxCHbPjUqrKO1E3dYGRvKolVpC5nIQGVIgo9n4avc+1C+pfWTpljr14eg0ewZ0QSFCaZf3blKX75RBxKpFuqfbF2qgGDdstS1gslVT3XldsBuEZ1t24BxCqBWovW05cOF/RRbUjGYZ6RZVGXFt4wo1PB/8VF98VAgrtglXBu+XatQQzTp0WWpOV8zMHyZuXiZAiYl3JURRKsq13D6v7lWsqopgU9NsmvoWHK8rQh6wp21dyak2tNuBX26tD6oZa/SVTJz26S4CwuP7vQVn2wBMw+AY2/t4qsJi3z3x8K01B/LPa5Bo8ksa+GL+mAmnz5JfWJdHyk19Nf1g3s14fpfFn2jdkkBXCSrGUaGyK7Q9b7NTzjQkOcRRI/1DEq/R1LuNTeA9CkXyXDpPnUKn4B8eu2xDuiH8gDrfwun4gtLzFg+h9vNrl6XRMBwrdKIRdzSdcp1fIo96wSfPrnWRzopP3lUbxYbeisFRB466sAoa7fRqO/uLBJET76YgrXqpiFahPBoxtwCOow2ppaF4OD/1BKFvNBMJ1jg1gMQVossZKs766ljuV48JuWEkNGHrO/1VRceWf/bcPjTDC5/oZk73NVrrQE4xAn8RE3ERQBDedusOksOSmgIKgCX+nQZfwmBtr53xXKUNh+9nDk4vLWYdvckekAWqGIVCDwknu8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEsyOG5ZMEFMaE51akJ5V3RjUGtyRXBCYW9Ra2dPM3JCUTEzL2lMb2dkU1ln?=
 =?utf-8?B?amNlU3E2TFF2UWlkend2dG1YOU9ZVFFVK1BhSUl5eU5FUGRCV3ZsamRKY0Q4?=
 =?utf-8?B?TEZWbVRiM3Q3aVhzSHVUclN2aGNFRDJSbmc2djc0L01tbTJib1hqSS9SdVY1?=
 =?utf-8?B?WFQ5OGFKRlRGeXR5REQxNUQ3dFlMMnVRTlNWei9XR2p5TENob25qSlVTU05i?=
 =?utf-8?B?a1FJdFpUdTNNRUFQRGxkQXllZzg1dU10b1NlMXhKOXhWZ1VyWXRXS3YxaDhp?=
 =?utf-8?B?UlNzWGluS2JjL1BOZjU3ZzAwc0psVWVnYzloWjZQY05rT2NaMjk5Rjl3YmEy?=
 =?utf-8?B?TFkxSDBtYU9TaUl4bEdpeWVJVFhPMnR6L2JYVW5OaXBTUXJQbGJOSEFobk9B?=
 =?utf-8?B?L1hkcnBad0hlL2d3dkFlcm9YazYrRzlRelBwaXp0OXJnMXAraEkvdEhIcWFq?=
 =?utf-8?B?VGRBTDYxWUJCYjE0d0RxUUlVSEprSldKV3pZdGoxeFdrS201KzhSemIxUTNW?=
 =?utf-8?B?RE1Odlpzd0NveTNTd3RZSlkyWmh1M1pnTzVoZStjM3ZXbkZiUWZWM04rRitR?=
 =?utf-8?B?bVcrMWJBcG51ZGRSQUlVQThWRFI2VDUvRVFMbEMyZWtRL0dCbktlajFlNVBG?=
 =?utf-8?B?WEpDQ0V6cTcyNkZBV2RvTmRkRU5EcEN5ZjJOa1Q4bkZ5ckU4Qkxid0gwTXIr?=
 =?utf-8?B?QytmLzVWK1ZVYjRVcThIcVJmb1JRVDFvT1o4a2VhWXJOdUNIK1Fub0FNNjZn?=
 =?utf-8?B?MVBjbDZuT2EwckplVGdHSEQvb0o3ays3WmNCbnV0WWtNc08zV1ZnRWRUbjFJ?=
 =?utf-8?B?cWIrNFZLdGNDcEVHUWZiemVwZm1vYVVmZzNqeS9YTTQ5L3R5Snp3WERiVktP?=
 =?utf-8?B?eVZmYTVxTHlwdU5OUzVUR2JQeWpGdGxuajRPWC9KRUo1ZTFZVWJ0bTVyczhI?=
 =?utf-8?B?aVBXK28xUXFFRmtYODI1a1VTS3ArUEFOdVhycnFDcUYvZUpGeDBXYWhOV2JJ?=
 =?utf-8?B?VVB6ZnAvVldCTHRGZ1A3YkRZNitBdnYvd2VrS2VlUjMwTDdYSjVKQnFTYXhX?=
 =?utf-8?B?TG5UVlJkbDhVVnZyVGd2UEoxc1dsaE9nM242ZXQrSTV6ZDMwclBwaVlER2tH?=
 =?utf-8?B?enJIQ1pUZzkrNFo5ZXJuMUxaMVprNzkwTnJqdHMyOGVHMTJQZndrUHVNdkF4?=
 =?utf-8?B?bndtT213ZGxUZ3FhRnBYaGxkZTBIcU51Ukh4VU84RWdyejlETzNnWUF0R1p0?=
 =?utf-8?B?UUpIMG1reVFLbG5ZS0xyWG5DSmp2Z0JodWNXUU14bEh6YitjYXZkVDBySWlH?=
 =?utf-8?B?dzhDVUg5dGEvYmZxODN0dW9FOWdLbVU2SW1ETDJGQmJoaG9ZN3VlZ1lMYnJq?=
 =?utf-8?B?R3h6VnhxblpXbithM3c1cC9qNE1ONHlXVkc4bWpYb1lUbGtvRGs3bXhIMDRi?=
 =?utf-8?B?RU81Q2Y4N1JSdFZZY29XSzQyTEMvQWpBTm5KNE40L24vSmFtRlFXY1ZjdTVL?=
 =?utf-8?B?VmRJeUpDNGgwRzlNeU1GMXRUWXJCOUUzZEorQ3Y3bmhpTUptcktsUkRsUUs5?=
 =?utf-8?B?NGpWUEJEbEUrakZTN1hOUnBJL2lsa2JsS1I4Wm9pVlpPaGRuVVdJdFV3UEpu?=
 =?utf-8?B?dnQ3K2dUUjFERlZCaUdWZzlUcGFoUzlhZllGRWNpUFdqUXNQZkdLa1FVTXdq?=
 =?utf-8?B?dUxOZVRkOTNIdU84dTZPRHZUeHJvNk4yY2VaTnlqbjFYVk4wRjlBR1NlSjJV?=
 =?utf-8?B?TnhPL1hGZmVhL3g5MmpHUkREYmY2dmZnNHpENTBuVGhOM3o2UEUyTkNLZE0w?=
 =?utf-8?B?d1hVaW1ZTStZZ3dRUlFNemViMHJaUHN4U003ZGlpR3FneGpJRDR4ejZRNHJu?=
 =?utf-8?B?RGVYVFFoLytlakFNSDR1NURrblF3K1pkaUxPN0xtQzMxazdNbmZDM0dFOTVG?=
 =?utf-8?B?YnNydjRQelhYSkpJb2lYKzZSaS9BMmVGTDEwLytQWXdVMU9oRHdWMkIzYlNC?=
 =?utf-8?B?NlZKZTJTSzlVLzRRMFFpRXBMTGR0b1ZKU3JrK2owZkpycGh0dzYxazg1NGhy?=
 =?utf-8?B?N0tuQzJsKzd2dXdNTDB3bmVLaVppaDhsQ0NPdU81T2hRaTllcnkxUkt1S0FU?=
 =?utf-8?B?dWhYbGJrZEFvS2xrOWh6WUcrL0FqMnk2UTBYUWw4Vk9jbTJGcTQxN3lnS1dM?=
 =?utf-8?B?b2gzcG1EYnVVTitpK3A3d0dZTG5tZmxveGFQWWVVSFhsY0g2OHN4OS9XMWdv?=
 =?utf-8?B?di9sQkI4YmhuUlByM245MmZhbDRYbzlpWDg3RVlObWJHWHdacTdhamNrNGRL?=
 =?utf-8?B?ZHQrdmpIdUlNZGZBdCtHaWFHUWlucDhEVE9YUDhqUnUzdUl6N2loZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d850d00-a688-412a-cac8-08df49b53c6b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:58:06.3251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSNrSuowi1/scAhdqU7+a+mwDGJECZe/y4Hcp3pLlFUjKlsUDxsByUeoUh7l7h38GKdvnWAOPfZKynFzzntKlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB324412
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/22/26 6:50 PM, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
...
> +config DRM_NOUVEAU_BIND_GSP
> +	bool "Make nouveau the default driver for GSP-capable GPUs"
> +	depends on DRM_NOUVEAU
> +	default y
> +	help
> +	  Make nouveau bind to all NVIDIA GPUs by default, as it always
> +	  has.
> +
> +	  If another NVIDIA driver, such as nova-core, should claim the
> +	  GSP-capable (Turing and later) GPUs instead, say N here; nouveau

That seems fine. Being able to set a Kconfig and leave it alone is a
nice convenience for developers, and it also works for distros, so let's
just do it and call it a win.

Some comments below:

...
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 5e1336615cf6..582eb0c91b10 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -112,6 +112,11 @@ MODULE_PARM_DESC(runpm, "disable (0), force enable (1), optimus only default (-1
>  static int nouveau_runtime_pm = -1;
>  module_param_named(runpm, nouveau_runtime_pm, int, 0400);
>  
> +MODULE_PARM_DESC(bind_gsp, "bind to GSP-capable (Turing and later) GPUs "
> +		 "(0 = leave them to other drivers, e.g. nova)");
> +static bool nouveau_bind_gsp = IS_ENABLED(CONFIG_DRM_NOUVEAU_BIND_GSP);
> +module_param_named(bind_gsp, nouveau_bind_gsp, bool, 0400);
> +
>  static const struct drm_driver driver_legacy_kms;
>  static const struct drm_driver driver_atomic_kms;
>  
> @@ -881,7 +886,8 @@ static int nouveau_drm_probe(struct pci_dev *pdev,
>  	/* We need to check that the chipset is supported before booting
>  	 * fbdev off the hardware, as there's no way to put it back.
>  	 */
> -	ret = nvkm_device_pci_new(pdev, nouveau_config, nouveau_debug, &device);
> +	ret = nvkm_device_pci_new(pdev, nouveau_config, nouveau_debug,
> +				  nouveau_bind_gsp, &device);
>  	if (ret)
>  		return ret;
>  
> @@ -1460,6 +1466,7 @@ static void nouveau_display_options(void)
>  	DRM_DEBUG_DRIVER("... runpm        : %d\n", nouveau_runtime_pm);
>  	DRM_DEBUG_DRIVER("... vram_pushbuf : %d\n", nouveau_vram_pushbuf);
>  	DRM_DEBUG_DRIVER("... hdmimhz      : %d\n", nouveau_hdmimhz);
> +	DRM_DEBUG_DRIVER("... bind_gsp      : %d\n", nouveau_bind_gsp);

There are one too many spaces here:     ^^^

...
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> index 625bb019736a..2439f0022443 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> @@ -3143,7 +3143,7 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
>  		 const struct nvkm_device_quirk *quirk,
>  		 struct device *dev, enum nvkm_device_type type, u64 handle,
>  		 const char *name, const char *cfg, const char *dbg,
> -		 struct nvkm_device *device)
> +		 bool bind_gsp, struct nvkm_device *device)
>  {
>  	struct nvkm_subdev *subdev;
>  	u64 mmio_base, mmio_size;
> @@ -3389,6 +3389,20 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
>  		goto done;
>  	}
>  
> +	/* Unless nouveau is the default NVIDIA driver, leave GSP-capable
> +	 * (Turing and later) PCI GPUs to other drivers, such as nova-core.
> +	 * Older GPUs are always bound.

Let's be extra clear and instead say "Pre-Turing GPUs are always bound."

...
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> index eb4f43287796..6d82de5b4c8c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> @@ -329,9 +329,12 @@ nvkm_device_tegra_new(const struct nvkm_device_tegra_func *func,
>  
>  	tdev->gpu_speedo = tegra_sku_info.gpu_speedo_value;
>  	tdev->gpu_speedo_id = tegra_sku_info.gpu_speedo_id;
> +	/* Platform devices are always bound, regardless of the bind_gsp
> +	 * policy for PCI devices.
> +	 */
>  	ret = nvkm_device_ctor(&nvkm_device_tegra_func, NULL, &pdev->dev,
>  			       NVKM_DEVICE_TEGRA, pdev->id, NULL,
> -			       cfg, dbg, &tdev->device);
> +			       cfg, dbg, true, &tdev->device);


Minor point, but this is a good demonstration of why bools are such
a poor fit for function arguments: the calling side is completely opaque.

Also, it's awkward to pass global variables into function parameters.

So what to do? Instead, the policy can stay in the PCI area of the code,
since it applies only to PCI devices. So we can just track it in that
struct, like this (notice how the explanatory comment is no longer needed):

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/pci.h b/drivers/gpu/drm/nouveau/include/nvkm/core/pci.h
index 075fe192b26f..6c2742f293c1 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/pci.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/pci.h
@@ -7,6 +7,7 @@ struct nvkm_device_pci {
        struct nvkm_device device;
        struct pci_dev *pdev;
        bool suspend;
+       bool bind_gsp;
 };
 
 int nvkm_device_pci_new(struct pci_dev *, const char *cfg, const char *dbg,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index 2439f0022443..f1e85e8ac5be 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -25,6 +25,7 @@
 #include "acpi.h"
 
 #include <core/option.h>
+#include <core/pci.h>
 
 #include <subdev/bios.h>
 #include <subdev/therm.h>
@@ -3143,7 +3144,7 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
                 const struct nvkm_device_quirk *quirk,
                 struct device *dev, enum nvkm_device_type type, u64 handle,
                 const char *name, const char *cfg, const char *dbg,
-                bool bind_gsp, struct nvkm_device *device)
+                struct nvkm_device *device)
 {
        struct nvkm_subdev *subdev;
        u64 mmio_base, mmio_size;
@@ -3396,7 +3397,8 @@ nvkm_device_ctor(const struct nvkm_device_func *func,
         * Reject before subdevs are constructed, as that would already load
         * GSP firmware for GPUs that are not going to be used.
         */
-       if (device->func->pci && device->card_type >= TU100 && !bind_gsp) {
+       if (device->func->pci && device->card_type >= TU100 &&
+           !device->func->pci(device)->bind_gsp) {
                nvdev_info(device, "leaving GSP-capable GPU to other drivers "
                           "(bind_gsp=0)\n");
                ret = -ENODEV;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
index 735f6537273b..1e159a22a94c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
@@ -1694,6 +1694,7 @@ nvkm_device_pci_new(struct pci_dev *pci_dev, const char *cfg, const char *dbg,
        }
        *pdevice = &pdev->device;
        pdev->pdev = pci_dev;
+       pdev->bind_gsp = bind_gsp;
 
        ret = nvkm_device_ctor(&nvkm_device_pci_func, quirk, &pci_dev->dev,
                               pci_is_pcie(pci_dev) ? NVKM_DEVICE_PCIE :
@@ -1703,7 +1704,7 @@ nvkm_device_pci_new(struct pci_dev *pci_dev, const char *cfg, const char *dbg,
                                    pci_dev->bus->number << 16 |
                                    PCI_SLOT(pci_dev->devfn) << 8 |
                                    PCI_FUNC(pci_dev->devfn), name,
-                              cfg, dbg, bind_gsp, &pdev->device);
+                              cfg, dbg, &pdev->device);
 
        if (ret) {
                nvkm_device_del(pdevice);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h
index a462051d2977..d0c40f034244 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h
@@ -54,7 +54,7 @@ int  nvkm_device_ctor(const struct nvkm_device_func *,
                      const struct nvkm_device_quirk *,
                      struct device *, enum nvkm_device_type, u64 handle,
                      const char *name, const char *cfg, const char *dbg,
-                     bool bind_gsp, struct nvkm_device *);
+                     struct nvkm_device *);
 int  nvkm_device_init(struct nvkm_device *);
 int  nvkm_device_fini(struct nvkm_device *, enum nvkm_suspend_state suspend);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 6d82de5b4c8c..eb4f43287796 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -329,12 +329,9 @@ nvkm_device_tegra_new(const struct nvkm_device_tegra_func *func,
 
        tdev->gpu_speedo = tegra_sku_info.gpu_speedo_value;
        tdev->gpu_speedo_id = tegra_sku_info.gpu_speedo_id;
-       /* Platform devices are always bound, regardless of the bind_gsp
-        * policy for PCI devices.
-        */
        ret = nvkm_device_ctor(&nvkm_device_tegra_func, NULL, &pdev->dev,
                               NVKM_DEVICE_TEGRA, pdev->id, NULL,
-                              cfg, dbg, true, &tdev->device);
+                              cfg, dbg, &tdev->device);
        if (ret) {
                struct nvkm_device *device = &tdev->device;


thanks,
-- 
John Hubbard
