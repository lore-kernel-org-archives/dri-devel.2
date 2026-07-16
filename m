Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7E3C44519
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9FF10E2FF;
	Thu, 16 Jul 2026 21:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O0/6V8PT";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B148810F3D9;
 Thu, 16 Jul 2026 21:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrihHhEobwG8+jESgCB9VDHMqvFva1vc7jFul7ypTov7yRC1xl+hjdzPDyEgEDZ+6VWkk+NC4TW4xecLMe2G0B5Vghg0tYI28UuvzxpHl8Db6DRtDDe4OBOR1GLR9+Wi6MvlLgc1l46JlOuFfLg+0oNJaz2O6/ePzcKRGCGUq4z0FsgMtKo/zo+LITbYXULwtLllAOd+4aoIvKorWIpeBsXfSrpvpKM67MYB6w61nYhlSDvertFjVX76rV33h/IPA6cG0gfUAXNC6iXE/3h8CvukQSx8aHCoaWCCAQUUrJUSCg/jynpABKFDU1Wbc6NnO4fSwWmnwO9ZqvCMCF+b5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fsl8HOrV4NMa3ZuysfSWpvwfvtxB8mANWZArXbGTYtk=;
 b=wLEFHAW6Dqmj3xef5GhG3PLSa7iWcVxYiagOEwOQiO2hUnCICqumXYDrpp2kzGSLzJHmfiHUl/m5Twq7v5oaWFtZmjvjWAzpftK6dsSQ6oHMsv8NM3/0z2XouVWgcmirEVyWKmlTnNuJ6r+vO7y2hLuYBCG6iw6P2XZncIlGW25/bXlm1sliITtqQFzl08WHoeZYFEB7agSYWr3w61rKeUqmzHIGny7SlaiiYmL6yPfvtgaDJGrcOnIIdo1beW2jNtwnXaKGsd4nlE8FBRSH/8yU+DW26CifKI15RPZLbYc/wxLmjgW8+acQ7be+kOM4tlzz7VhB9d1ifpci7ebbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fsl8HOrV4NMa3ZuysfSWpvwfvtxB8mANWZArXbGTYtk=;
 b=O0/6V8PTQm6nWvhabL28Dr3FgUYeW4BKIFrr9Bhsi5jlgjGnJ6cSTvXmyQFPvoXms3NlhFZNsQKlCIjWxV9hY5LFRleMDXuqM+QYZi7rPtOS2XQKs+Pt55BgYtrNrT7N4WhNMPMO3/BInHycG/wXtjkiJR+b0o33lB+NJueYNdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ5PPF01781787B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::986) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:02:57 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 21:02:57 +0000
Message-ID: <4b4ba3c4-f778-4e23-affb-5a088fd6dbc2@amd.com>
Date: Thu, 16 Jul 2026 15:02:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] drm: writeback: Modify writeback init helpers
To: Suraj Kandpal <suraj.kandpal@intel.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: uma.shankar@intel.com, arun.r.murthy@intel.com, abhinav.kumar@linux.dev,
 tzimmermann@suse.de, sean@poorly.ru, marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com,
 kernel-dev@igalia.com, John.Harrison@Igalia.com
References: <20260714042805.77934-1-suraj.kandpal@intel.com>
 <20260714042805.77934-3-suraj.kandpal@intel.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260714042805.77934-3-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:303:b8::6) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: 858c03bc-5346-4f7d-d296-08dee37d9cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 1Vz8m+kazOkH3sdeDxOdN7S7OPkx5u+GTTZI4F65lyUALncExJuifaBXfPl0ZiOnqex4x0IVYkpcScquqpg3nCGf8/n1Vnr4FQNHOPPKV4Vi5I73gx1upUlvkU7FxPqulQvMQjK1Oe4tMwKh/+hBUG9DFHJa7f/0/gej0fJJb/74m3PjSky5ZfBCHb7EXATqDeEd9Jrp/5rxHUrKFqHL7t1sYtOfXq1DFjoOQTEQGKsrdhjpZnrFOhHUQTyEcLDEt+bNM5O0VJcBXZvtqRfVNMfy/Oiydv+5DTQpZyJEHp2rpgsRhCnMTH1USfzHZhLzRebivJxZVoyHQvrEa+kDg3CDyunXyAIX/STdG5/owrRL6zSu7Xhoncuy60CNzkWhoxLGm4bJnHYEY9oVNKe43OlQOgVQNvB0/Ar+6fjTyIgcn1M2CBSeCEAle8xeUOpqha5qtie9gqh6c47cQ5jQxT3ko9kU/blPWu94vJWTWH4+AcUoPi5qF5ENqYc8QmoWqkXsPZFhI8AhpMukErVaN8NA6/0JB42brjTAWafSt74U0jpONb1xLzjnOGYg60RJ39/mK30zWOBWQOBcQTu74btaCyHm/aF/oKpJxBTvX57KSgGTIfCG6gko4rauUwoeiGwbHxeqxTPRbGVzfC/BtUhZjtmaaZQXZNABmkEPqY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBRTUhRZUNrTXBMUUZDc1NNOUdOWmhKZlBTZDZCK1RYUGhCZzNjY2lSc2M4?=
 =?utf-8?B?QkwwVnRaRW9aR1YvTnVpZWxWdzhvS2Z1dVArem1pQ29ZQlc0MGtuZDNXUFR5?=
 =?utf-8?B?RS9NdFRiTHJ4cW1zcDZiMndUMkdJTlM4ZVpMNldEU1Q5b041dTNaWVNHNlpI?=
 =?utf-8?B?Q3phZ25YWjVLekh1Z0Y0dCtoNmNHZXU2VzhYTWdPMW9ac3JndWxGa1BoY05O?=
 =?utf-8?B?RjZwNWxRQnc0eEFEcXgvam1sM04xQitwT2hwdHpmVk9JdTBoZ2VmRHRTTlcz?=
 =?utf-8?B?NkNGY3dnckp0bnRWVkIvQUFHbTVmY3grS3E5aVpXWU9oQWVvNlBhdHUyM0JU?=
 =?utf-8?B?am5sZXkvYklHc003N202ckptOXZNMjY4SkNiQTAwQzErRWhZbXBROU82NHpQ?=
 =?utf-8?B?Uk0rQlp1aDV0RGZwYmJqVk42ZXZUL1ZaeWFkRUEvL1BqSjJXNXVIS3FIdGxx?=
 =?utf-8?B?YVZzN3dtbnFqSUczOS9Ecy85VzdGVDNDdktHTjFuZ1lWUkhTWFFKQ1dtSCt6?=
 =?utf-8?B?bFV0WE1jTk00Z3UwYkhKaXd3aVdxbjFRaWNZd0ZJNG1UVU0wdkhuK0J6cW1h?=
 =?utf-8?B?R092TnVxWWIxVG5SWk9QU1VvMHozMXJ5ZmtPVUdmQmJ6dldjZEcvUGhiUmcz?=
 =?utf-8?B?b3d2c2xQVysvaEJFRXU4Y3NUa3dHY0ZjTjBNUzd3MmZ2Q3BBV29xZ2NRQlI5?=
 =?utf-8?B?MWMvazZYZUozcXA1VTVmSzd3OFhjZHpHY2d6bTVoUGFPTGdWbFlzdVdNdFdG?=
 =?utf-8?B?R0RPdzB6QjVSVHh5azA3dzJVSUxNbVJJNENoaFdWNGFTS1ExMXV3bENPaGtZ?=
 =?utf-8?B?Zk0vYVI1Q1JlbC9DTlN3cldINW13U0xmN3VrbUVOenIwbHJMVHgySkNXQkt5?=
 =?utf-8?B?NGR2cVdUenI4K2NLYUtKMmJjek5ERUVLVTVnZ0pSZVNrUk81d3RPUmt0Qk5p?=
 =?utf-8?B?N2tIbkdPTlJPUzNUMVV2UU5UWGd4WitFUmRIcWVGWmpUL2RKYlVMK1RFRk9I?=
 =?utf-8?B?WW9TQkhkd2E3OXNYOWVkNHJvQ3hyZVVpMWNJd3EvTWNWVmt6TXhmUGwwVGg0?=
 =?utf-8?B?YkJFSnFHL1QzdU91bC9NUW5zZ0dyUUhHL2JLaDhxZllhRUZzQWtySGJBby9H?=
 =?utf-8?B?QklobHVlOTR2QjRNK0tkdGkybWdmR1VxaUZjbVBiMklFemZRMjNhL0JqR1Ny?=
 =?utf-8?B?cnk0MjlvV3M4bkdXZmZCd1c1MTRxTDk1bUZJRlpTMWZlQVhPOW9mZkpnbjBu?=
 =?utf-8?B?c1VrUm13TEZ2eWJiMi9nb0dpbElTNWNOejRmK1kvaHZ5QUVnU3R0Um9QM0dm?=
 =?utf-8?B?bFJLaklQdEI0NTFTb2E4VDlmK0M1TVJTeXlSU2tqNGdaOHpUZ2NEZm5EQnBM?=
 =?utf-8?B?dVdIV1UzQ0UvWWpyM3loZVNNSHQ5VlUzdDF5TTlId1RVU0V3TGlURXdSRW5B?=
 =?utf-8?B?NE1Mb1ZKbjY4K05McElONzZVN2tLL2NpVUJ3VGJKL2RDekw0ZEFXQnFjN1hu?=
 =?utf-8?B?OWNkRXl5VytFN2lPSmRIaldYeTRPZVN6eklUYXYxa3RSRFM2ckRKSHBueFMz?=
 =?utf-8?B?cEYzUzd2Y2Y2NWlLT3BYSFNIejU0eEJPcldwWEltMk9ma3M4ZjcrUEV3aE9E?=
 =?utf-8?B?My8rbGplSDUyeitNMmkvbTBvV2Y4MG83NUU5V1FHeExRTUM1dWNvTlJmUWVU?=
 =?utf-8?B?ZkNMd1RTaCtud1FSbFptRkZ0WVNrZHlyWnpIQ1dBc25nUE81a29HN1pqK2VQ?=
 =?utf-8?B?TURGbHpKRStLZjJKUXRTQkxVQXc4SW1aamlFZDBWdXlkM2JTL2lIVXIyeHlw?=
 =?utf-8?B?UllGNnNSRUZpQWFIVTVrdnpWR2dkNzdEL2RtWHM4QllzS3V0MU5hU05ac0Ew?=
 =?utf-8?B?WHJoU2ZyWGpOOW95dFowakF0a1VuZGxubmtuWnB2aElMTDNEZ2xlVkE4Vkpo?=
 =?utf-8?B?bzZrcHRkZ3BPM3N6bWZQdG1ES2dCTW9PTTI1Smt2K1dXUUZpQUFCbnJGMUM0?=
 =?utf-8?B?WkdhSSt4RTJ3Uk9aN2VzeEdTWUMyWWJ6dWtvbWN6ZVVrTzE0MWtMb3RrMDRl?=
 =?utf-8?B?L3dVWjFqamVPMEhPZnpOa0l2eUY4eHBKbnc5SUhURDRqZnRtb25jRDRqL3dl?=
 =?utf-8?B?b3pZdDdnMHFyM3grbzJFeExZWTBvTGNPZDlqNTJsSDBWaGFockpYOWdsY1hz?=
 =?utf-8?B?VzNXM2ZwSTB4R0hWS080bjNDVGUwcGRJWDBMUVVuSnhnWW1JSWFxRytwMXlr?=
 =?utf-8?B?V1pYaEh2YzE2RGhOYVZpam1JbXZGRjVmOXBTQUlKalNQU08vWHNxWVYyeGhs?=
 =?utf-8?Q?wZ1QcllU+6dDfL8q/q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858c03bc-5346-4f7d-d296-08dee37d9cac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:02:57.3812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5quKzSol5bEG7gGD5eKaJvtntPZaaVxUJS0Ga3MDQIBoOd0zdLky5XZSsdZ7814zZ9xeD8TzKCA5ylXMOExzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B
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

On 7/13/26 22:28, Suraj Kandpal wrote:
> The writeback connector init helpers (drm_writeback_connector_init,
> drm_writeback_connector_init_with_encoder, drmm_writeback_connector_init
> and drmm_writeback_connector_init_with_encoder) require access to the


There are no changes to drm_writeback_connector_init_with_encoder and 
drmm_writeback_connector_init_with_encoder, and they can be removed from 
the commit message.

> parent drm_connector object as well as the drm_writeback_connector
> object itself. So, pass in the top level drm_connector and traverse
> down to drm_writeback_connector rather than passing in the lower level
> object and traversing back up. Even where such is not the case, update
> to use the top level object for consistency across the interface.

The rest looks good to me.
Reviewed-by: Alex Hung <alex.hung@amd.com>

> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Reviewed-by: John Harrison <John.Harrison@Igalia.com>
> ---
> v5 -> v6:
> - Rebase over latest kernel
> 
> v4 -> v5:
> - Make @connector kerneldoc wording consistent across the series (John)
> - Fix Drm -> DRM (John)
> 
> v3 -> v4:
> - Update subject line for consitency (John)
> - Update commit message across commits for consitency (John)
> - Rename writeback to wb_connector in rcar_du_crtc for clarity (John)
> 
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c    |  2 +-
>   .../drm/arm/display/komeda/komeda_wb_connector.c    |  5 +----
>   drivers/gpu/drm/arm/malidp_mw.c                     |  2 +-
>   drivers/gpu/drm/drm_writeback.c                     | 13 +++++++------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c       |  2 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c |  3 +--
>   drivers/gpu/drm/vc4/vc4_txp.c                       |  2 +-
>   drivers/gpu/drm/vkms/vkms_writeback.c               |  4 ++--
>   include/drm/drm_writeback.h                         |  4 ++--
>   9 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 18ef4ce73b46..92039d93f9e4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -207,7 +207,7 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>   
>   	drm_connector_helper_add(&wbcon->base, &amdgpu_dm_wb_conn_helper_funcs);
>   
> -	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base.writeback,
> +	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>   					    &amdgpu_dm_wb_connector_funcs,
>   					    encoder,
>   					    amdgpu_dm_wb_formats,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 848ac37a76e4..b6476c3b2ca7 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -135,7 +135,6 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   {
>   	struct komeda_dev *mdev = kms->base.dev_private;
>   	struct komeda_wb_connector *kwb_conn;
> -	struct drm_writeback_connector *wb_conn;
>   	struct drm_display_info *info;
>   	struct drm_encoder *encoder;
>   
> @@ -151,8 +150,6 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   
>   	kwb_conn->wb_layer = kcrtc->master->wb_layer;
>   
> -	wb_conn = &kwb_conn->base.writeback;
> -
>   	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
>   					       kwb_conn->wb_layer->layer_type,
>   					       &n_formats);
> @@ -173,7 +170,7 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   
>   	encoder->possible_crtcs = drm_crtc_mask(&kcrtc->base);
>   
> -	err = drmm_writeback_connector_init(&kms->base, wb_conn,
> +	err = drmm_writeback_connector_init(&kms->base, &kwb_conn->base,
>   					    &komeda_wb_connector_funcs,
>   					    encoder,
>   					    formats, n_formats);
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 4c77a459c241..271ec83c7e48 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -229,7 +229,7 @@ int malidp_mw_connector_init(struct drm_device *drm)
>   
>   	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
>   
> -	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector.writeback,
> +	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
>   					    &malidp_mw_connector_funcs,
>   					    encoder,
>   					    formats, n_formats);
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index f93c936643bb..79c4be2acbbe 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -246,7 +246,8 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>    * a custom encoder
>    *
>    * @dev: DRM device
> - * @wb_connector: Writeback connector to initialize
> + * @connector: DRM connector which contains the writeback connector to initialize
> + * @enc: handle to the already initialized drm encoder
>    * @con_funcs: Connector funcs vtable
>    * @enc: handle to the already initialized drm encoder
>    * @formats: Array of supported pixel formats for the writeback engine
> @@ -271,12 +272,12 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>    * Returns: 0 on success, or a negative error code
>    */
>   int drm_writeback_connector_init(struct drm_device *dev,
> -				 struct drm_writeback_connector *wb_connector,
> +				 struct drm_connector *connector,
>   				 const struct drm_connector_funcs *con_funcs,
>   				 struct drm_encoder *enc,
>   				 const u32 *formats, int n_formats)
>   {
> -	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
> +	struct drm_writeback_connector *wb_connector = &connector->writeback;
>   	int ret;
>   
>   	ret = drm_connector_init(dev, connector, con_funcs,
> @@ -325,7 +326,7 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>    * a custom encoder
>    *
>    * @dev: DRM device
> - * @wb_connector: Writeback connector to initialize
> + * @connector: DRM connector which contains the writeback connector to initialize
>    * @con_funcs: Connector funcs vtable
>    * @enc: Encoder to connect this writeback connector
>    * @formats: Array of supported pixel formats for the writeback engine
> @@ -341,12 +342,12 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>    * Returns: 0 on success, or a negative error code
>    */
>   int drmm_writeback_connector_init(struct drm_device *dev,
> -				  struct drm_writeback_connector *wb_connector,
> +				  struct drm_connector *connector,
>   				  const struct drm_connector_funcs *con_funcs,
>   				  struct drm_encoder *enc,
>   				  const u32 *formats, int n_formats)
>   {
> -	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
> +	struct drm_writeback_connector *wb_connector = &connector->writeback;
>   	int ret;
>   
>   	ret = drmm_connector_init(dev, connector, con_funcs,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index d1211788625a..c9f53490c1a7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -134,7 +134,7 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
>   
>   	drm_connector_helper_add(&dpu_wb_conn->base, &dpu_wb_conn_helper_funcs);
>   
> -	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base.writeback,
> +	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
>   					   &dpu_wb_conn_funcs, enc,
>   					   format_list, num_formats);
>   
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 39be854c465a..6b27307941a4 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -201,7 +201,6 @@ static const u32 writeback_formats[] = {
>   int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   			   struct rcar_du_crtc *rcrtc)
>   {
> -	struct drm_writeback_connector *wb_conn = &rcrtc->wb_connector.writeback;
>   	struct drm_encoder *encoder;
>   
>   	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
> @@ -216,7 +215,7 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   	drm_connector_helper_add(&rcrtc->wb_connector,
>   				 &rcar_du_wb_conn_helper_funcs);
>   
> -	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
> +	return drmm_writeback_connector_init(&rcdu->ddev, &rcrtc->wb_connector,
>   					     &rcar_du_wb_conn_funcs,
>   					     encoder,
>   					     writeback_formats,
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index 864125cc7d72..f11ad54d067a 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -600,7 +600,7 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
>   
>   	drm_connector_helper_add(&txp->connector,
>   				 &vc4_txp_connector_helper_funcs);
> -	ret = drmm_writeback_connector_init(drm, &txp->connector.writeback,
> +	ret = drmm_writeback_connector_init(drm, &txp->connector,
>   					    &vc4_txp_connector_funcs,
>   					    encoder,
>   					    drm_fmts, ARRAY_SIZE(drm_fmts));
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 64d524d2168f..9341533b0325 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -170,7 +170,6 @@ static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
>   int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
>   				    struct vkms_output *vkms_output)
>   {
> -	struct drm_writeback_connector *wb = &vkms_output->wb_connector.writeback;
>   	int ret;
>   
>   	ret = drmm_encoder_init(&vkmsdev->drm, &vkms_output->wb_encoder,
> @@ -183,7 +182,8 @@ int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
>   
>   	drm_connector_helper_add(&vkms_output->wb_connector, &vkms_wb_conn_helper_funcs);
>   
> -	return drmm_writeback_connector_init(&vkmsdev->drm, wb,
> +	return drmm_writeback_connector_init(&vkmsdev->drm,
> +					     &vkms_output->wb_connector,
>   					     &vkms_wb_connector_funcs,
>   					     &vkms_output->wb_encoder,
>   					     vkms_wb_formats,
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index 702141099520..c6960c7e634e 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -78,13 +78,13 @@ drm_writeback_to_connector(struct drm_writeback_connector *wb_connector)
>   }
>   
>   int drm_writeback_connector_init(struct drm_device *dev,
> -				 struct drm_writeback_connector *wb_connector,
> +				 struct drm_connector *connector,
>   				 const struct drm_connector_funcs *con_funcs,
>   				 struct drm_encoder *enc,
>   				 const u32 *formats, int n_formats);
>   
>   int drmm_writeback_connector_init(struct drm_device *dev,
> -				  struct drm_writeback_connector *wb_connector,
> +				  struct drm_connector *connector,
>   				  const struct drm_connector_funcs *con_funcs,
>   				  struct drm_encoder *enc,
>   				  const u32 *formats, int n_formats);

