Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA0BC55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C968F10EA41;
	Tue,  4 Aug 2026 13:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jaCEfpei";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6444510E162;
 Tue,  4 Aug 2026 13:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r96iwnW/WdZ0/lPjKFvwKw53/13qLfA16D1uNcB2DA0clOWwAeWTPfFnfjrCWtAawlPifegi/Gk/O2ayEk1eejGP05KurD/x0Qzl/qgbxapFcQLJSuVd+F4UgeWYGT5buh1V9peObL1naEzQ8xEsepGmFWLYVeMEbJXgJPAjb+mGtHgUVioCh78OU+vKe0R8nWjmTmccxh8zcHU3kUPfhVSNhkjwc2UMlvW6DDgSw2JyAQZBewuCpqJr9bmHmejs5PkY2LmrLsBl0MifGE7Kj7o5+QFeimAc4/StyHcIk8jHDL4Ww0GKcD+M7kq85++0zdai8zILvBi9sZeOi+3Iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OiQ8taLrghruyRg4YmHgzFRo6wnNdajhJXdo46Fzaw=;
 b=gNY3covjJM0tESQcEQF6Gd6SDeI23uRb0Wxce+6EBk1c6KAS3ztIFMrZUp1uYFUMiA2OqLPu5xe2sPxkswv8EpEx1DltdihiPU53+/RRVOaWl38ZxdFrOflQQYo34GCUJ/D5BkxnyB0IiF6DuBNvaa1Eb/m5cuxn12cdqj8MVcnVXoVLuCEPqi923tsjcr0pwLZpDkGmE9DazKGXXIrY2vGO2w3VhQfw35vYW9Ic5UD2zuwlewQDQq8pTHpN7EDbiQADaZWYKiYZo114YAWhQBfyQ4FU+x08L14TFA4WAlN20en14x89bkXvVH3EFXpmuT36oEFjOwNW7J/uwb3TfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OiQ8taLrghruyRg4YmHgzFRo6wnNdajhJXdo46Fzaw=;
 b=jaCEfpeiA5AbrFWyKXDrHdyR9N++a+e8dvGtDEniOIwhVfg2/+TnZfgftFG7O9yPye7Pr6FH64RIN8d8HHceYZcWLw0gUjLEL9blul6pH6DLQ6s+ysexnP00vkrW+FfUsBDkNkN6/1A64ksqP7uXQVmekpaEfS8cALyAxuVWVIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 13:38:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 13:38:24 +0000
Message-ID: <1e65ec27-372e-45bc-8c44-99ca2bc97a30@amd.com>
Date: Tue, 4 Aug 2026 15:38:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gem: Move pages_to_sg helper into drm_gem.c
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Zack Rusin
 <zack.rusin@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260724-get_pages-v1-1-b10e5d65628e@collabora.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260724-get_pages-v1-1-b10e5d65628e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 0147a598-a9d1-4a3b-efc5-08def22da7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R1TpWk3vilOh0hB5JVbEo/bifnhNrQ8r79onpBBFKV5TcudcA8OnR2sxyj8OQ/Ge2XchKLsxXVpGO2VKlOdbQC3xNPfxJrHEUvhVDbXGbgB+yFOZQZWaJGVO8NLJaw3+Ke28xn1g9vEcWtBGD99stLP92Z5wS3LCjN56h79mEQ41m5XHg6ZY84myeGhgQrblxG2naiIsfrAw/5R3o1kmKTsAOstxaGLisuwl91I59F44nfXAiSskpI2EzCcvQES64hh86SJ0dCMz2LEFb+LU7hiLTyejEq5ui3od9Mq5ovBFocOVGneHOppuF7rdsyMl6kYCXvrFTVm6gxXXgizuKzHOu+peq/6EJFUyIf5042AhtpA64WD6ANFeXWz1WqDn83N+Ef1D2eH0Ful/czzXIi6rFVarIb13NEbHQS7C7mMdLDLsNZDtoz5IYiCsP9Vg7aCuG8tl24RUuRG8Ebw73XA/700jGjNdNr1cGrakyi46FplZhJrmq17+jBMKKjP1tTF+nVSfJbF6Xmv3n3i1d5ajgYi4ItYJdpQgZ/RQIndAK7fGB/ryj/9QZgKuqyDw0qS9sbOdbirG0RSVxyCWKVBKiTz7FuPnRFvmYhYw8oGmAORzpz6tosLWESIClimLvTavkVGNilMdMvwawP1UU24o8JQ8s6tISyoTWK7i9l2y0piUv4bV3hbch8AxxVLvpWgosni7vtZk/PDYvJHjcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djEyZXZZVWxvNHJOcXYyYlQzRWVKTW9naGp2VDZwNmdrQW96RENpc25SejR0?=
 =?utf-8?B?N1YzQWpJS1djMU9CUmNlZTUyenFZaDArMnpmV1BwS1p2c2xsTEZaemxzSmZy?=
 =?utf-8?B?RHgrMm1DNjZBS2xOQzhhR0M3Z1FLY0E1b3IrYVZaWFU4R0srMzF1UnM0dVdT?=
 =?utf-8?B?R2loT05LODUzaVVObVpJZ1hHNlNRLzNiTXp0T21XaXhjeTBLc1lIYVo5WWhr?=
 =?utf-8?B?dzVNUU5JMXhNdU01cGhFamFXUEFUSFg3djNCTEpGcXozMmdrbzFoV1VOOEoz?=
 =?utf-8?B?YUR1KytCUFJpaDVOUGFtREVRS1dvbit4QjQ1SkthSUtnTlBDSlR4cmlTbHNt?=
 =?utf-8?B?R2piMHFhcmE3RGhBYlBjM2RYN0RNUXpiN2RNWnJZSWF1dGZ6UjBNMG1MeTU3?=
 =?utf-8?B?cXdrbTZObHd6ZUxmbElqdXdTZzFNY2lxdU1KVlB4NDBNeTNCWEZKaTJaRCtJ?=
 =?utf-8?B?ZGJxTDV1cjN5SmRiOFV0OW1pdUkyVHFNVjc1bGZ2eDVmQVNrczhJUTU3ejdT?=
 =?utf-8?B?RDNvTExUWEhIS05hMUZ4Mm95WE9LcXNiTFNYY3lkNUxKWGFxRGlPRk94cXpy?=
 =?utf-8?B?a0F1dEp4Znp6c05BRjNCSTk1dHRmMTIweTBPZU1KbkcwTGFnbVpBWXkzcmJC?=
 =?utf-8?B?NnlyS3RCd01uN3VpOGErUiszME9Qem42N3d3OGtjbmhLUzRlSUxWTW8rM2Ry?=
 =?utf-8?B?bkIzZU9BZXg1VGkwRzNnR3lWNmRFZGc1VjZyemltWUExTmZlUllBYzRHM0FO?=
 =?utf-8?B?NWFCbUxRVm5BdWo0bW5KTGZ1TUVBWTEvSzM0d0dlS1BXY0lwUGdhcWFFVm5J?=
 =?utf-8?B?eVFFYXkyTTNkUEx4bkp5TExQSEdVd0U0T3dZWG5rcnZySzYvc3NJTmhaVktp?=
 =?utf-8?B?cUlXUFc4ZUt1aW8wS25NTVdyQnZMVVd2U0RTYUhYRUdBU010RkkxVnZuMENC?=
 =?utf-8?B?WFc5Y1d6UUxMdnUzb0hTdUZUQmRUQXdsMVZObEE0Sk9TeUFiYVI2cGhXcTZU?=
 =?utf-8?B?SzdjUEpyYWxLakt2a2JDamk3L2ZweWVYTWRSTmp0eHdFb0NPbHU2NXIzRExO?=
 =?utf-8?B?a3pkcEtNNitJa3oyYU9xOGJLTldnQWNqOW4xYmlweUdpVFRyQVg1NDlzWFNy?=
 =?utf-8?B?SzBweE1Na3JHbkdMVDlVVFhxeWFsUFovemFLYkQ4cU5tdmNuV3liU2xrTW5l?=
 =?utf-8?B?REVxSTU0MzdkRmtOUVA2Q1kvTzhjRlhlbjMxSnNtMGZWcXJaMVdOVHVybVlH?=
 =?utf-8?B?VE5jVVQydHpXWVZUdlo3NEVHa29JTUNTMEt0ekd3T3hka2FtTkhYQklJSlVR?=
 =?utf-8?B?cHRoMHFOYlNzdW1HK2pOb0tOd0c1VzJiMEdLNWFHQWRmK1FpR0hOR2p6Unpy?=
 =?utf-8?B?c3dTcXB1N3VGb3lGcjJtWmFwcmpYWGhzeVVMdFpxUXJrZUtyOEhIU2NYcVRj?=
 =?utf-8?B?WnQ4K1BHV1Yra0pnVHpKdjNGWHdBMEgwZ1NDdlovVm5MTklYVjRpY051VXNL?=
 =?utf-8?B?c0NNM2orVmZnb1MweHROd3paMDQ0ZEl0MjY1ODNRWkJmVGw2Vk0rTlN1MnA2?=
 =?utf-8?B?ZVpwd2d0Sk55bzYvMTlybHVLcFJldVZwQ3JHQy9iK0NkbERLcFhVaDh1Wk40?=
 =?utf-8?B?L2xoYmVzTjl6bk1QWEp4dFROQzQ0RDI0Rml3ZHJTdStabE1DUlphR0xvUUZI?=
 =?utf-8?B?dG16Z0laT0pvNTBaL0NVWWw1djFqVnUzTmQzMDJDYnRIYzJPOXFjbmtrbk42?=
 =?utf-8?B?K0QwTUdqakp2b0JFRldycWNYbDNSRVg3Z0srQ3NoNHBEZHBwUzlMdkgzSHVx?=
 =?utf-8?B?b1JWekJzd0lhRGFiM2JKNlBtcHUyTFoxWDJjNWsvcGRGdDVNYkNlcXVTbjh0?=
 =?utf-8?B?aXJZWHFhbXl5ZDB4UEFZbEsycGJXbEluVFMxL2ZCWENPS1AyN28zdTVKYUJO?=
 =?utf-8?B?SitocldLUlpjSmZMdVZXZDRKSjBLdnkxVTlzQVVvN1JuOWNiZzhmU1JGR0du?=
 =?utf-8?B?N1o3NGdERUlac01teFppK2YyVjRJRGJwazl4aTg4SmFxVHdjL051T25ZNGpp?=
 =?utf-8?B?ZHd2THBCZUtjTnBIdFJWMHhweExBeGQ1Q2dOV3dBb2tiSlJ3UW9pR1pwb2lo?=
 =?utf-8?B?S00vSnUvZlpQbmVXNEhkdUVnVUQxK2F0V2tVRFVIL2IwV2NvcG5WeDZrY3Rm?=
 =?utf-8?B?U3J3MlROYTR2b3RubUtUR1dSTEg4SkNNVHlLaW5iZ0ZhL3pUSjJtRllSajlP?=
 =?utf-8?B?dWFvNkFlYlpqUTdmMUVVT3hjNlF4UTBjMDYwR3VJbmFFdURHVEJwZWppejB6?=
 =?utf-8?Q?N5jlV4ACThTJGiJhD/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0147a598-a9d1-4a3b-efc5-08def22da7f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:38:24.2839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1we7gz+msqYs5BOViZcVvxzazHnyiEcfi4bcJzi5rasJ0vTAGg2bjyYN9IeDyOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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

On 7/24/26 14:08, Adrián Larumbe wrote:
> None of the semantics of the function tell of it being a PRIME-exclusive
> entry point. In fact, most drivers seem to be using it to translate a list
> of pages into an sg table that can be used for GPU mapping later on, rather
> than just for sharing an object's pages with another driver.
> 
> Move it across files and rename accordingly.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
> drm_prime_pages_to_sg() has no real dependency on PRIME/dma-buf interfaces.
> It is a generic helper that converts a page array into a scatter/gather
> table via dma_map_sg_attrs. Nothing in its implementation touches struct
> dma_buf or import/export logic.

It is correct that this helper is not DMA-buf dependent, but DMA-buf should be the only case when a DRM driver needs to convert an array of pages into an SG table.

The background is that we want to discourage people from using SG tables because it was a rather bad design choice to have pages mangled with the DMA addresses in one structure in the first place.

So question is why do you want to do this?

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c |  6 ++---
>  drivers/gpu/drm/drm_gem.c                   | 35 ++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_gem_shmem_helper.c      |  2 +-
>  drivers/gpu/drm/drm_prime.c                 | 38 -----------------------------
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c       |  3 +--
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c |  3 ++-
>  drivers/gpu/drm/loongson/lsdc_gem.c         |  3 +--
>  drivers/gpu/drm/msm/msm_gem.c               |  2 +-
>  drivers/gpu/drm/msm/msm_gem_prime.c         |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_prime.c     |  4 +--
>  drivers/gpu/drm/panthor/panthor_gem.c       |  6 ++---
>  drivers/gpu/drm/radeon/radeon_prime.c       |  5 ++--
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  6 ++---
>  drivers/gpu/drm/tegra/gem.c                 |  4 +--
>  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c         |  4 +--
>  drivers/gpu/drm/xe/xe_dma_buf.c             |  6 ++---
>  drivers/gpu/drm/xen/xen_drm_front_gem.c     |  2 +-
>  include/drm/drm_gem.h                       |  5 +++-
>  include/drm/drm_prime.h                     |  2 --
>  19 files changed, 68 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index b33c300e26e2..c9a98aec7eb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -203,9 +203,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>  
>  	switch (bo->tbo.resource->mem_type) {
>  	case TTM_PL_TT:
> -		sgt = drm_prime_pages_to_sg(obj->dev,
> -					    bo->tbo.ttm->pages,
> -					    bo->tbo.ttm->num_pages);
> +		sgt = drm_pages_to_sg(obj->dev,
> +				      bo->tbo.ttm->pages,
> +				      bo->tbo.ttm->num_pages);
>  		if (IS_ERR(sgt))
>  			return sgt;
>  
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 018df97d590d..22c8a3b5f667 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -780,6 +780,41 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>  }
>  EXPORT_SYMBOL(drm_gem_put_pages);
>  
> +/**
> + * drm_pages_to_sg - converts a page array into an sg list
> + * @dev: DRM device
> + * @pages: pointer to the array of page pointers to convert
> + * @nr_pages: length of the page vector
> + *
> + * This helper creates an sg table object from a set of pages.
> + * This is useful for implementing &drm_gem_object_funcs.get_sg_table.
> + */
> +struct sg_table *drm_pages_to_sg(struct drm_device *dev,
> +				 struct page **pages, unsigned int nr_pages)
> +{
> +	struct sg_table *sg;
> +	size_t max_segment = 0;
> +	int err;
> +
> +	sg = kmalloc_obj(struct sg_table);
> +	if (!sg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (dev)
> +		max_segment = dma_max_mapping_size(drm_dev_dma_dev(dev));
> +	if (max_segment == 0)
> +		max_segment = UINT_MAX;
> +	err = sg_alloc_table_from_pages_segment(sg, pages, nr_pages, 0,
> +						(unsigned long)nr_pages << PAGE_SHIFT,
> +						max_segment, GFP_KERNEL);
> +	if (err) {
> +		kfree(sg);
> +		sg = ERR_PTR(err);
> +	}
> +	return sg;
> +}
> +EXPORT_SYMBOL(drm_pages_to_sg);
> +
>  static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>  			  struct drm_gem_object **objs)
>  {
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 22ec52e2ffb8..144d088a477f 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -825,7 +825,7 @@ struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_object *shmem)
>  
>  	drm_WARN_ON(obj->dev, drm_gem_is_imported(obj));
>  
> -	return drm_prime_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_SHIFT);
> +	return drm_pages_to_sg(obj->dev, shmem->pages, obj->size >> PAGE_SHIFT);
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_get_sg_table);
>  
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 9b44c78cd77f..54539a8929c1 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -835,44 +835,6 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
>  	.vunmap = drm_gem_dmabuf_vunmap,
>  };
>  
> -/**
> - * drm_prime_pages_to_sg - converts a page array into an sg list
> - * @dev: DRM device
> - * @pages: pointer to the array of page pointers to convert
> - * @nr_pages: length of the page vector
> - *
> - * This helper creates an sg table object from a set of pages
> - * the driver is responsible for mapping the pages into the
> - * importers address space for use with dma_buf itself.
> - *
> - * This is useful for implementing &drm_gem_object_funcs.get_sg_table.
> - */
> -struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
> -				       struct page **pages, unsigned int nr_pages)
> -{
> -	struct sg_table *sg;
> -	size_t max_segment = 0;
> -	int err;
> -
> -	sg = kmalloc_obj(struct sg_table);
> -	if (!sg)
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (dev)
> -		max_segment = dma_max_mapping_size(drm_dev_dma_dev(dev));
> -	if (max_segment == 0)
> -		max_segment = UINT_MAX;
> -	err = sg_alloc_table_from_pages_segment(sg, pages, nr_pages, 0,
> -						(unsigned long)nr_pages << PAGE_SHIFT,
> -						max_segment, GFP_KERNEL);
> -	if (err) {
> -		kfree(sg);
> -		sg = ERR_PTR(err);
> -	}
> -	return sg;
> -}
> -EXPORT_SYMBOL(drm_prime_pages_to_sg);
> -
>  /**
>   * drm_prime_get_contiguous_size - returns the contiguous size of the buffer
>   * @sgt: sg_table describing the buffer to check
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index b0436a1e103f..a8e8614f8210 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2015-2018 Etnaviv Project
>   */
>  
> -#include <drm/drm_prime.h>
>  #include <drm/drm_print.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/shmem_fs.h>
> @@ -104,7 +103,7 @@ struct page **etnaviv_gem_get_pages(struct etnaviv_gem_object *etnaviv_obj)
>  		unsigned int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
>  		struct sg_table *sgt;
>  
> -		sgt = drm_prime_pages_to_sg(dev, etnaviv_obj->pages, npages);
> +		sgt = drm_pages_to_sg(dev, etnaviv_obj->pages, npages);
>  		if (IS_ERR(sgt)) {
>  			dev_err(dev->dev, "failed to allocate sgt: %ld\n",
>  				PTR_ERR(sgt));
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> index 6757ae6ec304..f44484325ddb 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2014-2018 Etnaviv Project
>   */
>  
> +#include <drm/drm_gem.h>
>  #include <drm/drm_prime.h>
>  #include <linux/dma-buf.h>
>  #include <linux/module.h>
> @@ -22,7 +23,7 @@ struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  	if (WARN_ON(!etnaviv_obj->pages))  /* should have already pinned! */
>  		return ERR_PTR(-EINVAL);
>  
> -	return drm_prime_pages_to_sg(obj->dev, etnaviv_obj->pages, npages);
> +	return drm_pages_to_sg(obj->dev, etnaviv_obj->pages, npages);
>  }
>  
>  int etnaviv_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> diff --git a/drivers/gpu/drm/loongson/lsdc_gem.c b/drivers/gpu/drm/loongson/lsdc_gem.c
> index 2fb03487c983..37160228244c 100644
> --- a/drivers/gpu/drm/loongson/lsdc_gem.c
> +++ b/drivers/gpu/drm/loongson/lsdc_gem.c
> @@ -9,7 +9,6 @@
>  #include <drm/drm_dumb_buffers.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
> -#include <drm/drm_prime.h>
>  #include <drm/drm_print.h>
>  
>  #include "lsdc_drv.h"
> @@ -51,7 +50,7 @@ static struct sg_table *lsdc_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	return drm_prime_pages_to_sg(obj->dev, tt->pages, tt->num_pages);
> +	return drm_pages_to_sg(obj->dev, tt->pages, tt->num_pages);
>  }
>  
>  static void lsdc_gem_object_free(struct drm_gem_object *obj)
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index efd3d3c9a449..7e3418290c22 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -207,7 +207,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
>  
>  		msm_obj->pages = p;
>  
> -		msm_obj->sgt = drm_prime_pages_to_sg(obj->dev, p, npages);
> +		msm_obj->sgt = drm_pages_to_sg(obj->dev, p, npages);
>  		if (IS_ERR(msm_obj->sgt)) {
>  			void *ptr = ERR_CAST(msm_obj->sgt);
>  
> diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
> index 036d34c674d9..d25393a9e549 100644
> --- a/drivers/gpu/drm/msm/msm_gem_prime.c
> +++ b/drivers/gpu/drm/msm/msm_gem_prime.c
> @@ -23,7 +23,7 @@ struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  	if (WARN_ON(!msm_obj->pages))  /* should have already pinned! */
>  		return ERR_PTR(-ENOMEM);
>  
> -	return drm_prime_pages_to_sg(obj->dev, msm_obj->pages, npages);
> +	return drm_pages_to_sg(obj->dev, msm_obj->pages, npages);
>  }
>  
>  int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
> index caab60fc62f6..b95f2f07df74 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_prime.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
> @@ -32,8 +32,8 @@ struct sg_table *nouveau_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  {
>  	struct nouveau_bo *nvbo = nouveau_gem_object(obj);
>  
> -	return drm_prime_pages_to_sg(obj->dev, nvbo->bo.ttm->pages,
> -				     nvbo->bo.ttm->num_pages);
> +	return drm_pages_to_sg(obj->dev, nvbo->bo.ttm->pages,
> +			       nvbo->bo.ttm->num_pages);
>  }
>  
>  struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 9855df738194..ec530d254fa4 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -321,8 +321,8 @@ panthor_gem_dev_map_get_sgt_locked(struct panthor_gem_object *bo)
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> -	sgt = drm_prime_pages_to_sg(bo->base.dev, bo->backing.pages,
> -				    bo->base.size >> PAGE_SHIFT);
> +	sgt = drm_pages_to_sg(bo->base.dev, bo->backing.pages,
> +			      bo->base.size >> PAGE_SHIFT);
>  	if (IS_ERR(sgt))
>  		return sgt;
>  
> @@ -702,7 +702,7 @@ static struct sg_table *panthor_gem_get_sg_table(struct drm_gem_object *obj)
>  	drm_WARN_ON_ONCE(obj->dev, !bo->backing.pages);
>  	drm_WARN_ON_ONCE(obj->dev, !refcount_read(&bo->backing.pin_count));
>  
> -	return drm_prime_pages_to_sg(obj->dev, bo->backing.pages, obj->size >> PAGE_SHIFT);
> +	return drm_pages_to_sg(obj->dev, bo->backing.pages, obj->size >> PAGE_SHIFT);
>  }
>  
>  static int panthor_gem_vmap_locked(struct drm_gem_object *obj,
> diff --git a/drivers/gpu/drm/radeon/radeon_prime.c b/drivers/gpu/drm/radeon/radeon_prime.c
> index a77881f035e7..4cfc4282a59c 100644
> --- a/drivers/gpu/drm/radeon/radeon_prime.c
> +++ b/drivers/gpu/drm/radeon/radeon_prime.c
> @@ -26,6 +26,7 @@
>  
>  #include <linux/dma-buf.h>
>  
> +#include <drm/drm_gem.h>
>  #include <drm/drm_prime.h>
>  #include <drm/radeon_drm.h>
>  
> @@ -38,8 +39,8 @@ struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  {
>  	struct radeon_bo *bo = gem_to_radeon_bo(obj);
>  
> -	return drm_prime_pages_to_sg(obj->dev, bo->tbo.ttm->pages,
> -				     bo->tbo.ttm->num_pages);
> +	return drm_pages_to_sg(obj->dev, bo->tbo.ttm->pages,
> +			       bo->tbo.ttm->num_pages);
>  }
>  
>  struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index b188539dca0b..7897da0becf4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -89,8 +89,8 @@ static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
>  
>  	rk_obj->num_pages = rk_obj->base.size >> PAGE_SHIFT;
>  
> -	rk_obj->sgt = drm_prime_pages_to_sg(rk_obj->base.dev,
> -					    rk_obj->pages, rk_obj->num_pages);
> +	rk_obj->sgt = drm_pages_to_sg(rk_obj->base.dev,
> +				      rk_obj->pages, rk_obj->num_pages);
>  	if (IS_ERR(rk_obj->sgt)) {
>  		ret = PTR_ERR(rk_obj->sgt);
>  		goto err_put_pages;
> @@ -432,7 +432,7 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  	int ret;
>  
>  	if (rk_obj->pages)
> -		return drm_prime_pages_to_sg(obj->dev, rk_obj->pages, rk_obj->num_pages);
> +		return drm_pages_to_sg(obj->dev, rk_obj->pages, rk_obj->num_pages);
>  
>  	sgt = kzalloc_obj(*sgt);
>  	if (!sgt)
> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index 436394e04812..701af672b4e5 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -17,7 +17,7 @@
>  
>  #include <drm/drm_drv.h>
>  #include <drm/drm_dumb_buffers.h>
> -#include <drm/drm_prime.h>
> +#include <drm/drm_gem.h>
>  
>  #include "drm.h"
>  #include "gem.h"
> @@ -352,7 +352,7 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
>  
>  	bo->num_pages = bo->gem.size >> PAGE_SHIFT;
>  
> -	bo->sgt = drm_prime_pages_to_sg(bo->gem.dev, bo->pages, bo->num_pages);
> +	bo->sgt = drm_pages_to_sg(bo->gem.dev, bo->pages, bo->num_pages);
>  	if (IS_ERR(bo->sgt)) {
>  		err = PTR_ERR(bo->sgt);
>  		goto put_pages;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> index 39f8c46550c2..c9e7f2e3668c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> @@ -28,7 +28,7 @@
>  #include "vmwgfx_bo.h"
>  #include "vmwgfx_drv.h"
>  
> -#include "drm/drm_prime.h"
> +#include "drm/drm_gem.h"
>  #include "drm/drm_gem_ttm_helper.h"
>  
>  #include <linux/debugfs.h>
> @@ -76,7 +76,7 @@ static struct sg_table *vmw_gem_object_get_sg_table(struct drm_gem_object *obj)
>  	if (vmw_tt->vsgt.sgt)
>  		return vmw_tt->vsgt.sgt;
>  
> -	return drm_prime_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages, vmw_tt->dma_ttm.num_pages);
> +	return drm_pages_to_sg(obj->dev, vmw_tt->dma_ttm.pages, vmw_tt->dma_ttm.num_pages);
>  }
>  
>  static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
> index 8a920e58245c..f0fe80706b79 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -118,9 +118,9 @@ static struct sg_table *xe_dma_buf_map(struct dma_buf_attachment *attach,
>  
>  	switch (bo->ttm.resource->mem_type) {
>  	case XE_PL_TT:
> -		sgt = drm_prime_pages_to_sg(obj->dev,
> -					    bo->ttm.ttm->pages,
> -					    obj->size >> PAGE_SHIFT);
> +		sgt = drm_pages_to_sg(obj->dev,
> +				      bo->ttm.ttm->pages,
> +				      obj->size >> PAGE_SHIFT);
>  		if (IS_ERR(sgt))
>  			return sgt;
>  
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> index eec4c1da3f9e..a4a7c7f2c91c 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> @@ -236,7 +236,7 @@ struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
>  	if (!xen_obj->pages)
>  		return ERR_PTR(-ENOMEM);
>  
> -	return drm_prime_pages_to_sg(gem_obj->dev,
> +	return drm_pages_to_sg(gem_obj->dev,
>  				     xen_obj->pages, xen_obj->num_pages);
>  }
>  
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 885244e375d3..7b9cc6335689 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -155,7 +155,7 @@ struct drm_gem_object_funcs {
>  	 * here cannot be used for sg tables pointing at driver private memory
>  	 * ranges.
>  	 *
> -	 * See also drm_prime_pages_to_sg().
> +	 * See also drm_pages_to_sg().
>  	 */
>  	struct sg_table *(*get_sg_table)(struct drm_gem_object *obj);
>  
> @@ -589,6 +589,9 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj);
>  void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>  		bool dirty, bool accessed);
>  
> +struct sg_table *drm_pages_to_sg(struct drm_device *dev,
> +				 struct page **pages, unsigned int nr_pages);
> +
>  void drm_gem_lock(struct drm_gem_object *obj);
>  void drm_gem_unlock(struct drm_gem_object *obj);
>  
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index f50f862f0d8b..603e16a40ae7 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -92,8 +92,6 @@ void drm_gem_dmabuf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map);
>  int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
>  int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma);
>  
> -struct sg_table *drm_prime_pages_to_sg(struct drm_device *dev,
> -				       struct page **pages, unsigned int nr_pages);
>  struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>  				     int flags);
>  
> 
> ---
> base-commit: 48dd37d1fef33fbf42f1d6887c61e242fd21d00d
> change-id: 20260724-get_pages-e2e91c53eaa3
> 
> Best regards,
> --  
> Adrián Larumbe <adrian.larumbe@collabora.com>
> 

