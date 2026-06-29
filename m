Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8416C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 262BE10E064;
	Mon, 29 Jun 2026 08:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IyVUvGrm";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B3910E064
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuEDY+SIXCslOip1QicHcsfA3MX4/ziA3p5n6O5R/tlXhyhybFA5TFhUt1egIkBEbibfWiNIvCYYWoQSIElFgR79gqFCutIL9rXGMizFrxEiIVS/Ctaoe6OMzo9WQ+2cF7CyQmQPlstB4ChMulsXdIntMmNAd4EnmaR9/p0OvJ3LIRods+R2/2J4z0X/SwPMo+67VY9uR7PMwi0pcRPbAAg2K6Q2N4Mrwlcf7EgORpi5YMlKWvYXh6M4IX+yGzdrz7mAdVhqUJzFy7gi9Cau09a/M7J3GtCDdaGgOMs8Cwvf7YMi9lOKVgKlD9gP39kF9VHbAqPEXMovrtnDACMoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWZN1J00AfWjq7+oxypIyDauw6+b6i0YqyjYqYvIHm8=;
 b=qwNFNi1eifgZbKeCtuLYK3sEcCTJa/NsNH4g7Uv3g93qkp0wkZZq5zbx1MXjUx7yIPDiUELQi4RJ73YnmW9Z9oXL5B6xVsThvw/zfSOjETJ54796Y8cbZNecpaZAb0T8uHXvSFt+x3w91kP75RH17+14r0iBi52tb+TrdvJ5DSM1LlK8zGJbbvDSYoiiUB58sPAlvuRy5rEaRa+VZyUJAGPbynJ8eH7jW/HbpNJonAOWAcqgIY3hThwiqNLyBoH9S3wPnLW87MPTAnnPrL3LndpsNDFPboHDHARoUB3kr/AAixoIfdO7WfAM8rJKitikeBs7X364x0PUfFKkvdpX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWZN1J00AfWjq7+oxypIyDauw6+b6i0YqyjYqYvIHm8=;
 b=IyVUvGrmwsHLCcCBHBrPsZcBhvvUgA8wltCk9EVnzaqg6HSg/HHlk60T/dzXl+bQhisTCeQwYQEeGmlHPEpnZesz7uX+/0J/wVIGS3HPercLP/zuGKJwF/p06S04UZAs+nECRvqibpVFOy9HrWa63XfAZiujFSc/LtFRF+OWqo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:38:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:37:59 +0000
Message-ID: <b1ee5096-31e4-4442-aabb-3de2638aa701@amd.com>
Date: Mon, 29 Jun 2026 10:37:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Memory leak error in qxl unbind
To: =?UTF-8?B?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260628154051.232214-1-megia.oscar@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260628154051.232214-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 8761a5bd-92a1-4f0b-0eaf-08ded5b9b9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5R+eCifdSR+IekDDgHWs3nXyNcJMjKBlEmmE8sE1Wuba3rn79+v98FAnyUiuhIg4Cv7KkhG7m/Nly03yqxxwtZB3SVQDrSvDIPWoFBjRtiYA3ty7AjaAExKJHwb5LFpoVMmhgwvvVuh6av6lNVCByqIsok8wVSUbbpuOug65+M+3+jOCP1qD6AND8NHqxJUUoa7FyAiz1loEsYcUuCZOyn/M3w6/H+OCLOeAblQOCJER+tRcPM0oyypzzbiV1/Vt+6BPkr/RVHQ+r/o0USOvxNd3weth2SF5fsPx+Bu9ljpJlB0cTBPscLJUcixwBiPwj26HTiiEkPCr2Z5s58CM4k/QdNaZlrmar3gwBKJANFnGjMNrA1jRS5yVoxUDnd2GFSoujGxEAqJtb/JkhHGUpm8pgeWLLspuDM8XMe1JAffkXLjBK019+NhU1EqSnZM3XpQD0wDMDvTIIGqytCRvfDPkfvhk307Xy0YPi8cgEU1YpTwfI06ocOOcvRXMR0yOEa+GPr0xeqRDQZqzyQqAy4M7h4y1bhNWN1V6kuaGQatGeOdnXFgBCexnq1UOx2W++raHi+9vgOqc8QL88pROkcGBlhBzqF1RL7Ale29vNTM+3+Ou+PmRo2X0BUroLWG5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWEzVmoweWxsV1FBNVVoR09BQlhzbkNORVA3RDVjNGJqMk1FYlo5S3ppbTBT?=
 =?utf-8?B?aXE1T2MzL01BQ2JZRWJsaGN4T3J3VXVDVW1qMk0rMENxUmVWZDZMVFZTTlVP?=
 =?utf-8?B?b3l6ajZEckF0dlEwZEVjRUYzN09QR1p4bkFFKy83ekc1R2dMc3hJY0Vpa0N0?=
 =?utf-8?B?TVVuMitESEZEaC81S0NxUzdGSDdRR21FS0dIelVXWHB3L29KM0lQTnZyN2kx?=
 =?utf-8?B?SEdTUUQ0KzBVK25qSHBDYjdNYWZTY0dGWU9LMzBZdnVrNE56T0NmUDRIajMy?=
 =?utf-8?B?Kzg3M0xuVXMxU3hZNDdlZUZpWkZvdGlKU0cvM2o4RU9OOXFVcVVYQzFXc0M5?=
 =?utf-8?B?RGRJditReDM2TSthd0wwNy8yaDRaM3I2YVBKVW1wL3lrbnV5T3BsUkJ6UXdo?=
 =?utf-8?B?V2RKK2pNMWFKRmU4bzZpY21tUDJnM1JGY295dGllQUNyZzBNazgzMWxEdFlj?=
 =?utf-8?B?WnRKR1h0OTcrSUJuUStPTHlqdU5vRXFyRlFpTTEvSlpnUVFyNDNWKzlkNU5V?=
 =?utf-8?B?MGZ1ajBkQ0hrcjM4VUE0TWYzQmVHM1BtWXFqL3BkMEYzVENQNEwzMzl0aE5B?=
 =?utf-8?B?cHpBQVo4c1pPSjNXS2owaDJ6M1BwRVkxL1RjK0hJSERpOFU3YWY0RVBrYkdu?=
 =?utf-8?B?NGpJZGwwd1FoNUs2eXdueWwzZ0RmUmdzb1FuU3pDQ0NzMTVzaGcrajVzaFp3?=
 =?utf-8?B?bVhIWFI0SEY4UHk0V0ZDZ2sreDg0MGpiTk93eEkxZWpPa0VXNUVLSGZEdVY4?=
 =?utf-8?B?eXU3YlVZVVN3L0VnUDRMZjdabTRlbnpDNmgvTXBRcU1VNGY4OVl2MkhZYTJT?=
 =?utf-8?B?ZWdpR0syOC9QSVdnZTN5OTVNZ3MyYzBGc2NIbXZ0VHNtUnNyYTh3MXFwcXdr?=
 =?utf-8?B?S3RDZkdTdzVJM2p2U0pReFNWaFVhOTYzWmFoZ3lLU2tWMUNTamlWU2ZlUnJh?=
 =?utf-8?B?UElXTU9vanBmTmsweGx2SXBZczRqcDNTa3dBb0ZSODJtUkMxdWpBS3ZFSmQ2?=
 =?utf-8?B?YjdaSW1NNm9LUmRqZjJXaFBsSGZYKzdKVGdWcWhDcURNRzN1ejBvTUpZdlBN?=
 =?utf-8?B?UGVKb2lKVmhQbmppdGFPZXc0eVpuRytBYVFXdE1JT0lJUDZGS2FkWWpDaDBv?=
 =?utf-8?B?SEVmMEZMaWhXbXMrK21zRXFCSkR6c1grZ0Vyb20weWRBT1c1a0ZCeHJEdVVy?=
 =?utf-8?B?aVZXTXJ0TEJid1p1T0ppOXFCNzdnNVJ0amNFZGV3VlZvdThyODVDMkpCQ0VJ?=
 =?utf-8?B?OVRjZEtsa0I1cFVsRXJOdGxqYTdSK2pqY2NWMDBZeUI2SUJlMlkxbTQ5bkdG?=
 =?utf-8?B?RmdlT0VkNTQxSWR3TFJpTEplT2w5b3NJTkFSeEMzZkVzUE5HMFFLbllYdzZn?=
 =?utf-8?B?RDNaT1FWbEVnUnB4cGRMd0xxV2dOTVhVcXVOVmZCaFg3dmRPLzBmTFhObmN0?=
 =?utf-8?B?eEhGWlJMbTk2bUUxUTFsS0MyTDZjRW84STM1MERXVDkyNW5rcTlkUnlhMWh6?=
 =?utf-8?B?ZzNBdE1sZWc5TCtCWGRYWFpsOUVhQWE2V3VPWTg2VXRpVzNZYUZEbThWck5j?=
 =?utf-8?B?TTlGVDhaQ1VGV3l2SithZDNtQzVZcGcvcmZlTHVYYW9zTWFZc3pTTTE2SmtD?=
 =?utf-8?B?TDFBQy9lU0pEbGhZdkxjU3BpZFovRWcyNkNiZEc0bGxrVnFHUUdrTE5NaUdk?=
 =?utf-8?B?NmpIdkpsSGlnc1FjS2UrMkprOTQycWpyeEU2QXJTMjNOMnB2QzNMVjhTVDJu?=
 =?utf-8?B?MGRaamRuUU82V3dZcitoTmROa3ZVVTczSjFxc2lrNThjME0zVzBvak45UEFl?=
 =?utf-8?B?U2t5aGFiMG1vNXVoVmJyRll2TXZoVGhaeWVaWm5xbmFlTFBYeXZZeTVFQVdF?=
 =?utf-8?B?QW1XWWExcDl0YStHalZvUXB1SEV3UmRTbmE2UE9pbThaVWx1N3dDaVdDbzN5?=
 =?utf-8?B?bmp2MEhzaU4wQ2NFWXhiSHRrQkhqV0lUNGo4dWMvOXc4SW9FeVVrcGVwRWYx?=
 =?utf-8?B?V3NEdllpV3JVVmpVUEhGVUhZazMrYXMrK3hwR3JVME9sMFRPVitxbUtST2pj?=
 =?utf-8?B?RW0vRzVWZ1owcjFzU3ZpOFBVaG1VSkZ2WGNuTHdQbFJUcFlCRnpJTGY3VExn?=
 =?utf-8?B?bVptcUdUWGM0dWpJWjVXMEJBZDdVRG44bmlrTjIyODZydFBFZVRZQTkxSzBC?=
 =?utf-8?B?eDZGYkl1cEdkcE5HTGZDVmtucis1bXhldUdud2k2SjR2Y0MyN2t1V242QVZS?=
 =?utf-8?B?Q3NzOXdBQjZrazA1azk4ME4wMS9LYTFaRk9wMDVydVZtRWthRThpekVEOFlr?=
 =?utf-8?Q?oDhMLKcy3RTXamPCSM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8761a5bd-92a1-4f0b-0eaf-08ded5b9b9cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:37:59.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muvysDWxdcvjuKrT/DuAoe577i+SPb2gXWty6j6ZXM9EGFMxVnxPbjczbL65wgPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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

On 6/28/26 17:40, Óscar Megía López wrote:
> I discovered OOM after run script below around two hours in my computer:
> 
> while :; do
>     echo [pci qxl id] > /sys/bus/pci/drivers/qxl/unbind
>     echo [pci qxl id] > /sys/bus/pci/drivers/qxl/bind
> done
> 
> If you run 10000 times above script kmemleak does not report any
> memory leak, but if you run above script about two hours several
> OOM ocurs and at the end kernel panic.
> 
> The OOM isn't just a simple leak; it's a refcount corruption that renders
> the list_lru fix dead code after the first mid-init failure.
> 
> Here's the chain:
> 
> Bug 1: ttm_global_init ignores ttm_pool_mgr_init() return
> If shrinker_alloc() fails under memory pressure, ttm_pool_mgr_init
> returns -ENOMEM with pool types already initialized (64 list_lru_init
> calls done). ttm_global_init ignored this and returned 0, leaving orphaned
> pool types with a NULL mm_shrinker.
> 
> Fix: Check ret from ttm_pool_mgr_init; if non-zero, goto out cleans up
> refcount + debugfs.
> 
> Bug 2: ttm_pool_mgr_init leaks pool types on shrinker_alloc failure
> If shrinker_alloc fails after all 64 pool types were list_lru_init'd,
> the function returned -ENOMEM without undoing them. With Bug 1 now
> triggering proper error handling, this undo is necessary.
> 
> Fix: err_shrinker: label that finalizes + destroys all 64 pool types
> before returning.
> 
> You must apply the patch from the link "[PATCH v2] drm/qxl: fix
> use-after-free to qxl_irq_handler in PCI mode" before testing.
> If you don't apply this patch, you will get a UAF error when running
> the script above.
> 
> Assisted-by: OpenCode:1.17.8-Big Pickle
> Link: https://lore.kernel.org/virtualization/20260627105445.89827-2-megia.oscar@gmail.com/T/#u
> Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
> ---
>  drivers/gpu/drm/ttm/ttm_device.c |  5 ++++-
>  drivers/gpu/drm/ttm/ttm_pool.c   | 37 ++++++++++++++++++++++++++------
>  include/drm/ttm/ttm_pool.h       |  2 ++
>  3 files changed, 37 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
> index d3bfb9a696a7..c880a0430363 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -96,7 +96,10 @@ static int ttm_global_init(void)
>                 >> PAGE_SHIFT;
>         num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
> 
> -       ttm_pool_mgr_init(num_pages);
> +       ret = ttm_pool_mgr_init(num_pages);
> +       if (ret)
> +               goto out;
> +

Please put that into a separate patch.

>         ttm_tt_mgr_init(num_pages, num_dma32);
> 
>         glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32 |
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 278bbe7a11ad..e0c82804a07d 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1198,6 +1198,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
>          * that no shrinker is concurrently freeing pages from the pool.
>          */
>         ttm_pool_synchronize_shrinkers();
> +
> +       for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
> +               for (j = 0; j < NR_PAGE_ORDERS; ++j) {
> +                       struct ttm_pool_type *pt;
> +
> +                       pt = ttm_pool_select_type(pool, i, j);
> +                       if (pt != &pool->caching[i].orders[j])
> +                               continue;
> +                       list_lru_destroy(&pt->pages);
> +               }
> +       }
>  }
>  EXPORT_SYMBOL(ttm_pool_fini);
> 
> @@ -1386,6 +1397,7 @@ static inline u64 ttm_get_node_memory_size(int nid)
>  int ttm_pool_mgr_init(unsigned long num_pages)
>  {
>         unsigned int i;
> +       int ret = 0;
> 
>         int nid;
>         for_each_node(nid) {
> @@ -1423,8 +1435,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  #endif
> 
>         mm_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool");
> -       if (!mm_shrinker)
> -               return -ENOMEM;
> +       if (!mm_shrinker) {
> +               ret = -ENOMEM;
> +               goto err_shrinker;
> +       }
> 
>         mm_shrinker->count_objects = ttm_pool_shrinker_count;
>         mm_shrinker->scan_objects = ttm_pool_shrinker_scan;
> @@ -1434,6 +1448,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>         shrinker_register(mm_shrinker);
> 
>         return 0;
> +
> +err_shrinker:
> +       ttm_pool_type_fini_and_list_lru_destroy();
> +       return ret;

Instead of the error handling move shrinker_alloc() before initializing the pool types.

>  }
> 
>  /**
> @@ -1442,17 +1460,24 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>   * Cleanup the global pools and unregister the MM shrinker.
>   */
>  void ttm_pool_mgr_fini(void)
> +{
> +       shrinker_free(mm_shrinker);
> +       ttm_pool_type_fini_and_list_lru_destroy();
> +       WARN_ON(!list_empty(&shrinker_list));
> +}
> +
> +void ttm_pool_type_fini_and_list_lru_destroy(void)
>  {
>         unsigned int i;
> 
>         for (i = 0; i < NR_PAGE_ORDERS; ++i) {
>                 ttm_pool_type_fini(&global_write_combined[i]);
> +               list_lru_destroy(&global_write_combined[i].pages);
>                 ttm_pool_type_fini(&global_uncached[i]);
> -
> +               list_lru_destroy(&global_uncached[i].pages);
>                 ttm_pool_type_fini(&global_dma32_write_combined[i]);
> +               list_lru_destroy(&global_dma32_write_combined[i].pages);
>                 ttm_pool_type_fini(&global_dma32_uncached[i]);
> +               list_lru_destroy(&global_dma32_uncached[i].pages);
>         }
> -
> -       shrinker_free(mm_shrinker);
> -       WARN_ON(!list_empty(&shrinker_list));
>  }
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 26ee592e1994..bda8e816a206 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -97,4 +97,6 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  int ttm_pool_mgr_init(unsigned long num_pages);
>  void ttm_pool_mgr_fini(void);
> 
> +void ttm_pool_type_fini_and_list_lru_destroy(void);

That function doesn't need to be exported and so doesn't belong into the header.

Regards,
Christian.

> +
>  #endif
> --
> 2.54.0
> 

