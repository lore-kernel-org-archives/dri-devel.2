Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58CFF94CA7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DAC10EDC2;
	Tue, 21 Apr 2026 21:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ws3EW2ju";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86ECC10EDC6;
 Tue, 21 Apr 2026 21:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raxrZrPRvNAWRmqu2FxA1H2re88RjK3zRRytYMWCCtBZkKZ8/uR6ysHeSXTVkVsVH9zJ4zyhjicBB4CV0JQDX0ws7sM0DEn/qSArPhuNgVI+ogwAY7mEfg2lzxENQ/Z5Ks1al7LOxxSh1RYjALonU4Ro1TOYmjSgfwhFeJ4clNgBfdJcj0rNeCIbjqNG/Sq2Vhr6GgvliINLvblsPyQfixO+j/CMnDsJ4eMUGzPkTXFF8X0QDuBBByHOoF7zNGbLXuSIQL5YbI1BYISABQ33h8eGZ7e0pflNZzb5drqvw5Gl4WiSTdzVOoBplccnFJ8AtsC6Fj9P7s2PO9CBUzYSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjk6IbafDh48TVmcomdscNwFZ9bN2UfWaWNcMk3lZ0s=;
 b=hhcSJqmzOvddaYrmEphTIS09FE4W965qI2txu7fZI6hoiehmY1RieT5b3d3+8K+NcmNI5q0GBUQuoUAFRFO1v8GQeAgyOY62piZ+ZZ+SCxWCnMYdEztahbV9GMWptnqGbVck9jdA0oCTEXLw25DUBWdWAFbkTxoYurkQacERhSS1kMjXufh1xpG6j2WLZhNZSEJxIYjcN0rZNuWZtYcg81T8Lj3GkZYgk7b4eR2s75XPq/aNu+TKYDlfCynLDIUCwOsOSHYGfX/UQCRZgCH2Y3Ew8Aw/AXQOO2YSj+H+07sEbLEvkBMDH66KvbJeAPlfuYepLnpj8B5VNPabTXbRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjk6IbafDh48TVmcomdscNwFZ9bN2UfWaWNcMk3lZ0s=;
 b=Ws3EW2juYg6Gzki88dD08/gStwokqZdxzHdEPrBS8Xo77ykVG00ShgCwTJmbQKZitxNMnUUV/4LKL7/dUw1guCySpnWSUWKkxh7Ijo+acQ101+FI2sLbUEVvp6MLXmIAOS1HV5CYI5ZZ+0EqRjTTAsZt/qm4sVncRXwxv+dpnHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:21:39 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 21:21:39 +0000
Message-ID: <6ca493d4-7f3c-486e-ac59-611714b86e06@amd.com>
Date: Tue, 21 Apr 2026 15:21:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/9] drm/vkms: Add CSC FF colorop to color pipeline
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-4-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330153451.99472-4-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:303:85::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 063ce537-78c1-4530-5703-08de9febf9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: BYOAhArH66RLAVi880KlEZ7heQloupp1G7C+UOGzgOMuXkGxRjFuyGoQ6pEtOa1/X0Zw3tHU083k60dw8fqUuSW7astv5o7Ln0spq2PeWqMywpb8LzDjUPn/ZQFq2EiGF4ve7O0s4Yw8LCRhH2KLOmrGkh1rePS0VCpLmI6GqKt7QTBtUS9IVJbfOg0/ItDcshRpYhvEzQLPoFT9puATy+GzswQCGsNxCzBolDp93aqOkXbMOPcysjU2JxPmfFIRPXZ3cvrEdWx7svaZXzrcJGkw8zclhxzfK+4UlB3879QLMbke9RDgTuer6aJiqNS3mdu22lAOUCcfjtXV3O/8DC8zoDX6jLYNombkXGdMARM0EhhxHmrb08TRVbR0MKWxE4Bmx4biK0fhzHYR8AUm9HinPJUnennN5MJpy9shp7qb7+XSHU/XMFp1aDOCqjkHCCxOFDeoSJ1E/3DTV+9rnD22rL+vcrepEuPgsQ5Yo3iKmYmvUedmPAj2MRjDXpmYCV15uZ7pZnZ0vv8M/3e3iwaauXq53MYfNqfVMKpuBfxe+BAISNJlyrDk3uYUAfvm8/8BERIuZEXGL66hEH37aCHSMQaYvdW4yvf9aDIaFBox3hukRXBMRFzI+Hqw1DMZj2T7qo7DBwdNn4nKcRj5qvVmm50nqaUOSkARhLjmyelN79RGrlk8ALbhN3pa09pZC1ZCR8OxIckIDWdyN/XMfCNS/Oa25dUlEw1T7H4mICQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXpxVDJ2OFJBMVRDK3g1dVBZZGEwbjBsZHJIR3Nlc3VjbHhFT0c4VlFlci9n?=
 =?utf-8?B?eDdNcUxPeUZvZis5c3RjL0tpS01vNjdoQklCU2d0T2lNZi9sU0EycEFObFBO?=
 =?utf-8?B?TFNHdnR3alJ3NFFBMVJleHJaY014TmJmZjZNR3FkVStsMzQ5RE9CaGk0RnEy?=
 =?utf-8?B?T1ZweVRyWWVLUXJFc21Dbjg4eGsyYnRtUGJwNkdEUUE1ZlltWU8yeURLQ2hD?=
 =?utf-8?B?cmFVRlRodjZTOE93WG5GMFhqNGQ4c1RUZ1o0L1RoczJlRi9TUUR2YXUySUFl?=
 =?utf-8?B?UDVjM2lpVWZRUmkvclhqK25RV3BMMncwNVVDRUh3dzdLQ2UyZVMxWVFjTGI3?=
 =?utf-8?B?OEtwV3JPdUg0cVNrbnB3MEQvdlBESkJqcG1kbm1JTTh2d0k4UlF3clZCNnpQ?=
 =?utf-8?B?NDF2QnBiZ2E2SkxnNjJsSXF1OXlBRTZtamF0bmoveWdBSlFQQTQrR0I0dmwr?=
 =?utf-8?B?eW5aVm9ncnpWREJWMTlEdmhBc3lwTVFIbnpKbm10TW4yTnFFS1pQRjh3Vll3?=
 =?utf-8?B?b3Z1S3ZtQTJTSnBOS1FDdTNYb2NJZ3YyV0ZuQzRvMmN1WEhWMzA5MlBJajM0?=
 =?utf-8?B?TzQ1eFk2RDRWaCtETldOOXVPc0M4UVVaSXExNWxuNXpZZWQ0MWkrUkMzNzE4?=
 =?utf-8?B?czdPUEhRam45WmJFZ2plRWJWVDhkMGVScEhrR1lDTXBUOVBGMm9xOEltVW5L?=
 =?utf-8?B?Q1ZTeWd5Y1VDTkx3OEEwNEFHMit1RE9WWXIrSXZ4RUNXQUNPS2pmMzd5bHBx?=
 =?utf-8?B?Z3lFVUpBMXBkNkIwaWlHU3ZXL2c0TTI0djhuU3MzUmJGbGVnN2RvWjAzbmpS?=
 =?utf-8?B?OGs1OGlPY1BJVEVLZXlUVjFNaU9WMk5SY0pBM3RZaHpmdVd1bVNmaWpvSWtX?=
 =?utf-8?B?MHZCT1ZiblZVV0FSUHMra1U3VnFraHpnOTIrcTg2VmMzK2FDL3Z6clErRkkr?=
 =?utf-8?B?eVkrcnNCUS9naDNzdittNzRtcG8xMlJMcDVLTTYza3JsckJtTDJVejh6R0Z2?=
 =?utf-8?B?NENLcnRycnB4WHAzZWNiekM0b05sYlU2cWJ6bXVXRUVTZGFCaVg1b0kvWnRL?=
 =?utf-8?B?NFA3OHFLQjFLWmtlVWY0WFJ6aUx1aGN5SUt6TjRUWElDMVEwQ3ZGMDlKZFk4?=
 =?utf-8?B?b1FVVGsxdGZLNFZCWmlkUGpOV3M1OEFIcGk2cGlVOG13WnpIZkFyUEdtUFNx?=
 =?utf-8?B?Qks0blhIa3FxRURMaXNrcHo3cXFibEVDQXNRSWorN3FtekhGRlo0dVlJR0Ja?=
 =?utf-8?B?MTJtZmxDb1BmRFd5bjJOUGsvOW93UmpnVUhNell5ZzhMMS83bFFuZmIyTkV1?=
 =?utf-8?B?enFTdzNZTSt3LzFMM1RydGEwUVkrWm9JK0ZOTXNWY29WRndLU1htT2NuRzRY?=
 =?utf-8?B?R2l2bWhPZVUyYnFGSExNREF0bTIvbWVXWXBEOUsyN2o5UmVhWHdqRER1V3l1?=
 =?utf-8?B?ZFdHTnFnTy90UHBhZExkNW9TbURPMUt0Mkk5a29UQU52eDREdUt4WStsanBa?=
 =?utf-8?B?SEo3ak4raFc1Tmd6TzlTT1d3dnk1b0UvaEYyMzBYVDFDNms0WHA3QkxRcUh2?=
 =?utf-8?B?eHJjL3JHeTkydTVZRjNQRVhlSTZrTnlYM3Q4UERyVVQwVmZ0anBHRkQ0cmVU?=
 =?utf-8?B?VzNPMzlzcmRsVVg5WENRdFd6QVFLZVpJMU02dlllNnJ0cU5Ob1h5MHNacS9O?=
 =?utf-8?B?UHE2bW5LeENXODdSSTlIQ3RWbUNON1ZwdUNXOU96ZDF3aHo0RngxKzVKZXRv?=
 =?utf-8?B?NWkwZlhzc3JncW5Xa1BLandUYm1wOEg5U1FVcUIycFYwQVFmYUJ3T0hEaXl4?=
 =?utf-8?B?bDV5Y3BrU3d1VmRPZTlDeFZzc0Uwdjg4M0drRzFSRldGZSttMVRxZ1BwOG92?=
 =?utf-8?B?cUw3YmlMOEZMSTNtWnB3ajhlS2JhWmZOSjlTaStOclBnM2ZtS0dpUEtpRGVS?=
 =?utf-8?B?N0dBbTZrNDJTZ20zbS9ZaENiMSt1ZzViSXpSTEpxTysvenlwZ0ZtcFpNeGZQ?=
 =?utf-8?B?ZEY3MWRCdUl2ak9iQitlWXFSRXVuOHBOeWtoUjRKK3VKLzIzNXJvbEJNNnpT?=
 =?utf-8?B?OTVOL3lPTG4zSGxLWlUyT3JnMHc4dE1sZ0pOTzhQd1dRem9nc2hLYWFLV3Yr?=
 =?utf-8?B?VlNxcnBNYzB5UG01WDVpKzhWR0F1Tk1wdmx1ZGxjREVBR0QrbHRpTHIyTm9Q?=
 =?utf-8?B?OGRoNjN4UzloOFJUSDhuU2NZYkJqbE5lNlV1YlZpTnRrekRJM09ZZ3VRclRQ?=
 =?utf-8?B?VmlYVEttYitLRGJtd2xYM1FtQ3RrYmdPZWtYWG51a2pFNm0yZXhQQnVtRWp6?=
 =?utf-8?B?Y1hwZ2wvdTB3bC9UcW0rQ01IaVUzM0VhTkpwampyaEpLVnRjTFhuQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063ce537-78c1-4530-5703-08de9febf9e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:21:39.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEwRBUj9S5WwlgeC8dUdB8CbZ5rV733a2mUMBMifXyrCLjLnNj/ICh2Yxlbr/XkKjKPNisBIKxfYLDDAv3/udQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
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
> VKMS color pipeline, before the existing 1D curve. This allows
> userspace to select YUV-to-RGB conversion via the color pipeline
> for YCbCr framebuffers.
> 
> The CSC FF colorop advertises support for all six YUV-to-RGB
> conversion presets:
>    - YUV601/709/2020 full-range to RGB
>    - YUV601/709/2020 limited-range to RGB
> 
> Bump MAX_COLOR_PIPELINE_OPS from 4 to 5 to accommodate the new op.
> 
> Assisted-by Claude:claude-opus-4.6
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/vkms/vkms_colorop.c | 66 ++++++++++++++++++++---------
>   1 file changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/vkms_colorop.c
> index 071f3a8d2e7c..fa78ac7be36e 100644
> --- a/drivers/gpu/drm/vkms/vkms_colorop.c
> +++ b/drivers/gpu/drm/vkms/vkms_colorop.c
> @@ -12,11 +12,19 @@ static const u64 supported_tfs =
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF);
>   
> +static const u64 supported_csc_ff =
> +	BIT(DRM_COLOROP_CSC_FF_YUV601_RGB601) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV709_RGB709) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV2020_RGB2020) |
> +	BIT(DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020);
> +
>   static const struct drm_colorop_funcs vkms_colorop_funcs = {
>   	.destroy = drm_colorop_destroy,
>   };
>   
> -#define MAX_COLOR_PIPELINE_OPS 4
> +#define MAX_COLOR_PIPELINE_OPS 5
>   
>   static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list)
>   {
> @@ -27,7 +35,25 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   
>   	memset(ops, 0, sizeof(ops));
>   
> -	/* 1st op: 1d curve */
> +	/* 1st op: CSC Fixed-Function (YUV to RGB) */
> +	ops[i] = kzalloc_obj(*ops[i]);
> +	if (!ops[i]) {
> +		drm_err(dev, "KMS: Failed to allocate colorop\n");
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_plane_colorop_csc_ff_init(dev, ops[i], plane, &vkms_colorop_funcs,
> +					    supported_csc_ff,
> +					    DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	list->type = ops[i]->base.id;
> +
> +	i++;
> +
> +	/* 2nd op: 1d curve */
>   	ops[i] = kzalloc_obj(*ops[i]);
>   	if (!ops[i]) {
>   		drm_err(dev, "KMS: Failed to allocate colorop\n");
> @@ -41,23 +67,6 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   	if (ret)
>   		goto cleanup;
>   
> -	list->type = ops[i]->base.id;
> -
> -	i++;
> -
> -	/* 2nd op: 3x4 matrix */
> -	ops[i] = kzalloc_obj(*ops[i]);
> -	if (!ops[i]) {
> -		drm_err(dev, "KMS: Failed to allocate colorop\n");
> -		ret = -ENOMEM;
> -		goto cleanup;
> -	}
> -
> -	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, &vkms_colorop_funcs,
> -					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> -	if (ret)
> -		goto cleanup;
> -
>   	drm_colorop_set_next_property(ops[i - 1], ops[i]);
>   
>   	i++;
> @@ -79,7 +88,24 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   
>   	i++;
>   
> -	/* 4th op: 1d curve */
> +	/* 4th op: 3x4 matrix */
> +	ops[i] = kzalloc_obj(*ops[i]);
> +	if (!ops[i]) {
> +		drm_err(dev, "KMS: Failed to allocate colorop\n");
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, &vkms_colorop_funcs,
> +					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	drm_colorop_set_next_property(ops[i - 1], ops[i]);
> +
> +	i++;
> +
> +	/* 5th op: 1d curve */
>   	ops[i] = kzalloc_obj(*ops[i]);
>   	if (!ops[i]) {
>   		drm_err(dev, "KMS: Failed to allocate colorop\n");

