Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A21BF94CB0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A094210EDBA;
	Tue, 21 Apr 2026 21:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CnpJe3BO";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B54510EDA4;
 Tue, 21 Apr 2026 21:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+lfHGh3oQArt+sJeF9Cquj/O8GwhZ/AlNpxNOzFhWV3bjqYDpsxOKdn/ALupt+QIe48Y2ljvmkRAa0nUn/uXeGFlBZ0FcTWf/2okbwn+BDsR21uHHT7p0vbGdRmqG2zb9DcxKmZfpi/tBMlBAqEMxfYhgPz7/0J8LkWFRskFpEWZo/ZcqI9yWqdaLLEyONpAlbBamv4r+HdVy6KdK7QbhaSz4k7MLM8vNuuWjD97H60gK2XcaYPkuSeejTU/a7pytxA7fkrP/wKRqtZVliQOYGzgZ6Ge5izYMh6/NG+0pnirspZU3h2Or8+9MIvcBafSLe/Nio9BKC+YtpaE1D7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCIxqzHa5hKMjF7UqlZkeq3P95pBnmAcv3S4QZxqZ1w=;
 b=A9pkTaSNF/C5tBk7yHhvFXGtjtUg7eCvf5DqkNhQ8fe5kGTNu2u57Dqvvf6Ay6m0UoXpzQUV/uQfjorGlWdYZtr60ia9dHqvzQxwLbOXAAz9sKJTXpGVDvhao3O4b8XRrlOKJW9dTE2Y8noeSRz7EPdCoUl6MvNtL94Nx3TcUCYQkvnGUnMQHUF1U9xtN+9DoIHp1pA/xwmGbL9y1jVrB5Q4gRs4rgHRKQxNd1NFur3BtnVL/gVn8o12qY1wv3Btw5rDLiNgfZ4GmVS/YcIVkLSreEuvW0hhHmoYH4hDAKKx1D8RHWVylzL2B1UJbpNNKTkXgRyAflBvSlnGwywszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCIxqzHa5hKMjF7UqlZkeq3P95pBnmAcv3S4QZxqZ1w=;
 b=CnpJe3BOuHp6ebr3f5EmEsD/m4tNDT1lO3ySRr4MEf0I/mmibBBQSESxJHcD4TpddbE9htojDf851A9tP/QzwV+bdr5rFTCZxMvXs6uPJAzqxgj8v2Enxr4CZL76/f/PL6IURrb7OJEF4HZ41l9fFl9DHRdnftoxfRhWKSJui4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 21:14:57 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 21:14:57 +0000
Message-ID: <de53f6fc-c1c9-4669-ba29-2d57ec7aa3f9@amd.com>
Date: Tue, 21 Apr 2026 15:14:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/9] drm/amd/display: Add CSC FF colorop to color
 pipeline
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-6-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330153451.99472-6-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:303:2b::20) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bde579-32f0-4e37-c24d-08de9feb0a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 68e5Om5Ao3X2AKZ2c5SXVrwaH5lBj9x6mstw8x2YFnZFAxHM003X3msz6ljoN5aflYmps92dw5sHB2JWgSjJhSOaJaatOfBb8WT+fj5w6ta5bvqDbaylj0HYKhd0MixKmE6IbfYPDj0GYt4LqmMnNWageDJgRSC8q9SnRASwSlEMzzZCkjrrMOzUcMjoI3/AU8HIUeo2jJEhVbnGCc36TV9iK/L5wXMurDgWVMgD6rDaZqFQTaR1izmb7EwYHlBb6SW4xZIpwZRqbaRTgo2BmJ9EhedjcMpE5UAAK3zkxWkudbTuUs4pz9sIp+NqI+GKwwyXDHuWXJ+Gho5snWmEPPr0r6EyejJYD4AMxu+cS/PhFOBMQZHu3RoHOgFWO17hBbW7FY/yQLY2bo8VE+aDWKNcQrDTqFOCowJ6kImqh409pzBPV3mMHf8wfWE3IYs1SP3DocXYrdTbhh39yRyGIZSDrEcBY68pjnGPMP0XLT48hT0CZFpgTbPmXwy1OxTBEPEEEJevf7P8jtUUyfWaamiKEBUZlj4CJhZ0Wo0YHbjsw9dV1HxyJi6XI1/GhPUhSNL7DTy3ifH+8VU/wnDFXEQ/a49qvTWNBC045gFIdqmDw7QM/t1Tc7WgPx+9c2sWvjf1xj4gLl2C4E2i1dt+RpgrXY9s2tRRiFHzwPVpwIwfMpEXb7qs9qqxu/PZnW00nE1Rac+yzcvFVrduQ3hwzhCQLCzQ3PzLnwvEoEVqL9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHY2SWNLcmxkSFBOU3NjYnZjOVpheElMZDFNYXhvVEZ2R0JMend2bXhOMlFW?=
 =?utf-8?B?emE0WkFWU3hNamp4ZHlJZU1ZYml1dU9kVkU2dGplT3BkcmVJZjc3WHYvSXdJ?=
 =?utf-8?B?M3c5TDdPQW1UZERXWFpuRXNaZmQvYnRLRnhPL3VPYVloMTZZNWk3cTY3Q1BJ?=
 =?utf-8?B?bFVJejcrc3BFYUJ5RFg2TFZTcE4wQ2I3VUtiNXdhdWVWQUdnVUlmYjhzTG5L?=
 =?utf-8?B?Zno5YWRSaWZueWMwMXcyMXNKODAxeVl4N1pXVDBCcWRUQ2tUbXpsc2t0UkNT?=
 =?utf-8?B?OVZMbG56NTkxR25pMS9reTlwSmJ1WXIwRUd4dXFyTDJzTk51ZGVqN1l1MlJT?=
 =?utf-8?B?dnluS1JSMUJOZWJXcVpJWjNmNU1RYVU0V0t4Z1JrcnExNUNkYlh2NFVNcTB0?=
 =?utf-8?B?KzExTmE4MFFvSGZwM3dHUWhoVHAwOGdWd21tL0NWMXdsUE8zT1Vvd050UVlY?=
 =?utf-8?B?Y0Z5Y3BEQ1R4UWhXZXZwVU5XTVBJdEkxRTcvR1JKNCtrelhzeE9Ic1FXd1Nt?=
 =?utf-8?B?YmRXZEVqS0g5Z3gzRVI2VWcvaTM4Q2VNVlFESktpdWJ0cGlPcytxWWVzT0Qy?=
 =?utf-8?B?d3dhZm5JY1IvM2lPSWZTMW50WWNKVnhwRU5KRWtIUE03TGxNVHgvSURNUExw?=
 =?utf-8?B?TEl1SkJRaVZpK3BhNU4zMTFSYk1jRENKSm9yUXZURXQ2amJ3T0psOHVIK29y?=
 =?utf-8?B?WDBnblBvTWU4ZGVyUjUzL0E4bEhuckp2T3BIcmhoaUVHekI4N2JTSFFmRTM5?=
 =?utf-8?B?MC9qQTJvUWc0Yk1YYU1qOUNVWmZkcy96VklEd3JIR3dJbktPbytpM2N1eU9a?=
 =?utf-8?B?ZTdwT1ZFdUJwSGUxcXNIbjhiWHAyWTJvdTlOc0lzRXpHWUpJbzE0dTc0Vml6?=
 =?utf-8?B?OEtCaXlRbWJHTDd3NU1pejNRS1g0My9STVFGbXNQNGF1dml1cXo1UDFiWVps?=
 =?utf-8?B?TGlBVWVOMUN4YWxlNE1OdUJvUlUyd0JNMWhHbjhUc1R0V3VjSmt3Y1hoOHgw?=
 =?utf-8?B?M0ZKeVRuVUpBQ25DWVBlZXFCeFNpQ2dFM1FlVDJtQjFBeVlIemFrRmMxMXVa?=
 =?utf-8?B?RDJGZHYwcGg3OFlXWFlxelRaVHVTS0tFT09ma1pBc0E5V3BBZk1CRmtnWHlK?=
 =?utf-8?B?czZublJtbHB3MFJQTEU0RlRqZFVQQm9hQnl6czZiOW9CTmtwYzN4Nm9wbTNH?=
 =?utf-8?B?ZEtaT2d4RHliRFhYalBSTFNQRGVLbmFQV1JYL0N4bGpaeXNJaGxwSmhNTnVp?=
 =?utf-8?B?U2pFUEZmWEljdGJVWnNUczBGNDAzaVA3Z2tuaW04d2t2b0JCN0JPTldycm0r?=
 =?utf-8?B?SDY2dFRReFhLa1JUTzZvbDZEVGI5MHdkNUVSMWx4MG8xa2k3QzEvK3JjTDVk?=
 =?utf-8?B?MXJVdzZRQ3BhcUxUQ0d4RnhWOGZ4Q2N5Sk00VkhoQlVYUXJUZG1uRHM4L3hZ?=
 =?utf-8?B?RktEaWU4M3V1RWU2UkRTcURTRzVyRDFmeHlMOUNtbWc2dWlXL0R2NFRlVlFQ?=
 =?utf-8?B?Y29WZGlLNVhMK2o3Z1BBd0M0VkhDbXo4ZnA1ajYvQUtFa3dwNmdDdUxITml5?=
 =?utf-8?B?YTRnbUZkcWlOTzltZmtRWGYvUXc0VU1yYXZkRnZGQURlb3liTk5kK1RGdExK?=
 =?utf-8?B?KzhKSUI1ZzQxQlQrZXRONnBVZzR6QnF4UHErMGxvNUxReElZb2NJbjFtZ3dp?=
 =?utf-8?B?TW42Vy94Y1I5dmFNQy9lWEw5R0d2eFIzaHpxR1M0Umo1WDZLaVNBVWtoaldU?=
 =?utf-8?B?NzBtVlZ5NEk3cDdIclVyOTQwK2hqdGNiNlJ2T2c4cjhzM3h1ZWR1TGJaekRy?=
 =?utf-8?B?bVdtcGJUbS93WERjcVBIRnREQm0yek5LREROTHR5eEd5eUR5NnZOUUhyVWZD?=
 =?utf-8?B?aCtZYTFLRHZ4TFBZTFR5RngwbjY0RFRyMDdVanFqMm5oWlA4Y28wTXJ2dlRS?=
 =?utf-8?B?cVEwOGRxRFQ4Vk9IdHFscGpQc1NnWXZncXAzN1Z2eG9PZkRPRk1MYVRIQmRt?=
 =?utf-8?B?QVNvd1dOSTlQQ1RuWGFjZjdDRDg4SE1sb292MzJ6UkpMVTdTLzQrYWw0dXhy?=
 =?utf-8?B?emMyTzAyMVJPSUlZSndRSXA5VVJ1SUFaRy9vTlYydThlcFRySmo1YnJiN21Q?=
 =?utf-8?B?RXhtYllnS2ZVVlVtTG1CWm40bC9INlpXMjJYdjc3aXgyQ0FNcVB6dzBGclZL?=
 =?utf-8?B?WE9qdEtjMTFxeGRDTHQwMHFzUHZKVkpYUWtlNFR2NUtzNTdxWm05WDJXald4?=
 =?utf-8?B?NFFhZDBBZm5PUFNoOUtrR2N3SzZvdzFsbWtJRDNZVmlSODJlWExHdUhzaHpx?=
 =?utf-8?B?ZzdHaDNrL0NySVBkZm1NZEtNSzlHR25CZFZnQlc1OXg2aGMxbUZ2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bde579-32f0-4e37-c24d-08de9feb0a57
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:14:57.4297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsUcq4oEj7CuEsi/1g0htL0mGzo3EydxE/aytfNnRxparEqtZJ18RzovX0hghozITjwfPY5uhI5oEllR9JDxnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/30/26 09:34, Harry Wentland wrote:
> Insert a CSC Fixed-Function colorop as the first operation in the
> amdgpu color pipeline, before the existing DEGAM 1D curve. This
> allows userspace to select YUV-to-RGB conversion via the color
> pipeline for YCbCr framebuffers.
> 
> The CSC FF colorop advertises support for all six YUV-to-RGB
> conversion presets:
>    - YUV601/709/2020 full-range to RGB
>    - YUV601/709/2020 limited-range to RGB
> 
> Assisted-by Claude:claude-opus-4.6
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 27 ++++++++++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  1 +
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index 3e05e48a8792..13521095e021 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -51,6 +51,14 @@ const u64 amdgpu_dm_supported_blnd_tfs =
>   	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
>   	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
>   
> +const u64 amdgpu_dm_supported_csc_ff =
> +	BIT(DRM_COLOROP_CSC_FF_YUV601_RGB601) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV709_RGB709) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV2020_RGB2020) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020);
> +
>   #define MAX_COLOR_PIPELINE_OPS 10
>   
>   #define LUT3D_SIZE		17
> @@ -70,6 +78,23 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
>   
>   	memset(ops, 0, sizeof(ops));
>   
> +	/* CSC Fixed-Function (YUV to RGB) */
> +	ops[i] = kzalloc_obj(*ops[0]);
> +	if (!ops[i]) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_plane_colorop_csc_ff_init(dev, ops[i], plane, &dm_colorop_funcs,
> +					    amdgpu_dm_supported_csc_ff,
> +					    DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	list->type = ops[i]->base.id;
> +
> +	i++;
> +
>   	/* 1D curve - DEGAM TF */
>   	ops[i] = kzalloc_obj(*ops[0]);
>   	if (!ops[i]) {
> @@ -83,7 +108,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
>   	if (ret)
>   		goto cleanup;
>   
> -	list->type = ops[i]->base.id;
> +	drm_colorop_set_next_property(ops[i - 1], ops[i]);
>   
>   	i++;
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
> index 2e1617ffc8ee..e509646b5567 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
> @@ -30,6 +30,7 @@
>   extern const u64 amdgpu_dm_supported_degam_tfs;
>   extern const u64 amdgpu_dm_supported_shaper_tfs;
>   extern const u64 amdgpu_dm_supported_blnd_tfs;
> +extern const u64 amdgpu_dm_supported_csc_ff;
>   
>   int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
>   

