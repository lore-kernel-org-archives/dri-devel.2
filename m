Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D8EC531F9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 06:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2047710E655;
	Sat, 25 Jul 2026 06:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NPDfth3J";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012062.outbound.protection.outlook.com
 [40.93.195.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AE310E138;
 Sat, 25 Jul 2026 06:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh/3RKlRCZlDI2wGj8JvET9MTHRrFGiz1GETQ40bY4VdnfBNUS9BjY3qvPHadUzZRL6dSFp21JZtltQmQ2J+qgfq9P2h9CyR8Vbmi6VCVIsF+bPOnfc2JGoEuK2IpxYx87W/oki1qrX+saG3p9qiIX76C/i18nUmPoz9DM9LCn4ykY10SVp6tphhY6smxbmFZw4kkXI3zQYkPhZXKxLV9b0EtDrgSy6oWfuYHFYN/gds3jzTJKbqtKRTYEsmXyYfQTo829AEviVoWQ+JA1/2qwVGntiDQEl0fdYUzA9+ncuCey8jc+3wDkVyMkDTfj9UKv6XOhPpQRKHYqRllGXxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuxMfCvjKdzi14ows2UKcrZcSXU0Lvf42dNBlkL5pBU=;
 b=NplPcVkPIA6vBPYE8pN3fgMn0lQ4yTbyDbYeKscTOGxDYGNnRueIrBsi0Wbbjs0AESw1xKCrKwgtnNd4vXuwJnt+LVuCBlgQaIvhlk35Jjscya1VzLRIjJeC70dSg/NsJXMoL/KhRKMtdYn+G06MDju5KWzNN8lmBhwyH8zpPv45/8NTMR8CEyPUq4KSB+BE4LZoJfE7SgheojF/H+RwDCi1AQiah7NkqMLPXYGFhFdGvYnVE32MVfkuju9Crwa1UwfaWIkXyc4h48Grn3xBuEUGu/7PKwK6JBfpNcwCpfZ00UhlLmrrWaWqAStXHc+5+6FiyjT0Xlv4muJQI/YJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuxMfCvjKdzi14ows2UKcrZcSXU0Lvf42dNBlkL5pBU=;
 b=NPDfth3JrxN5bX7ySa+YEIUywqzWVWiE5ikRlXY9dVUR8GAEdv2yIF/xyoHDAC3yLPDDiWdZOo4zF5xd1RyXmlXLJIKq7u1ug6wO8KetytOH/PiXtiEIOYR/GYpRZJf/C21f/EjenmHhj38QDU3UoTebDK9xEbtetJ3cMkIWmr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 06:07:54 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 06:07:54 +0000
Message-ID: <aeed9d2b-a70d-4c2d-b572-e0f4ab824a9a@amd.com>
Date: Sat, 25 Jul 2026 00:07:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] drm/amd/display: Use GAMCOR for first TF if YUV
 conversion is needed
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-9-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260722134607.136293-9-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 464a0158-e2a6-4e7e-ab97-08deea131112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lnuqHqQ+8tJIxCSuuWk+d/M/6bELpzzUJdjkjj6U3w6Bdeh4WFbYPQiidIXSnM1PLr7b8d+GJszNUDSvqUSiYFtO8dOQCzSzbxlhy2ZKCUF8Uk1L7h6kphHHMbOUtk7bybbBQNayBOX0IYD4AcHdvA8z+P5QuBX4Zel01OvtTq6yL24V+1qo8+VMXwX7H9rzHobGPO3miNqj96Pw18rOzbct1krnrUt0HCQxLcf8U5y4Z36136HroR8ob80ZYQ5ur9rqLqdXRl7m4pGicq2jUC4yeY6QkUuVWWKzy1+5MAdCLG4OF3D/MUaVfeg8L1fADddI404yKKDb7j4pw6qMhC0l5ypFVvAJCFXGvKJp0uDH5mDrw0Kfauld0pzJBJvrUXrNk3vBdnSN3Hp2w6w2R+Dwco5E+qfGab0tn3zY2CM3h63qpIz+AYnpo/xCAnv+Yo9AZEd5W9+AQiQMMNzBNPj576oPIq33jDhBY0Qw/B7uZ1xpGYB478v1OSpWoB9H/jr+kOvTwOr95ZJcu7nP1j7hvc1Qmm/3k4BI4KxCsId/pUwNM7GB8JGxlWKdTrWMow6/QkSPdfr/lXd/i4s9FYV6B4qtn9z46SIhwykzmujkmdVkpZ+JXKHGPuzf/bxzDMKJl/6s0O8htxL0bgxQ4Hy/7KSSSKW1VXWADRgcCJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJxakRZQW81cHRzcklqYUtmUzdBWnJhOUVhMzdLaXBGUmxYRFdVRmlKdFcr?=
 =?utf-8?B?TU0zRTBDMkVLMmtxcXpaZzdOdk5xdDR6d3ZxTU9qVVJvTDdZZjFxSTVqdDFO?=
 =?utf-8?B?V2lqMHdraEEzVUZmdWhYWXFFREhlUnptbFMyUUIzZU0rTitoV2o3N3J0VGlx?=
 =?utf-8?B?SHVKRFNxd1ExV1gyK3NOOE1tMGZaeTV6azlmcnE5WW5CYURyUHZiYVFnUko3?=
 =?utf-8?B?ZHNBUlFQSjNTdS9qcDJDTXAvVEtFNWttd3VqVUl5VzZrUzZLeFl1SmFhWHgx?=
 =?utf-8?B?Yzd2QUNmSUZnL29JM3loVlNIVWpPckdVQUdJWW1scldlMno2Um9HZnlUWmFo?=
 =?utf-8?B?YnJ0RDByQ2VkMUpGOW1MekM3RjY0eHBFVzUyUWROamlrWXFFVTlEQjlaSy9h?=
 =?utf-8?B?R2tJckF3VDhQTXE2UVJSVk9GQXpyV3QwbEplVG1KY2hOQ2wrRXp6dFR3ekZP?=
 =?utf-8?B?VVBuU0hWWlJ1M0RiaFpBMndiU1BmUEc0ZXZDL0g5bms5T0N0Tk5WUXk0TVd5?=
 =?utf-8?B?ZFM2Rmd5cGc0cVdRVkNZTURLVVJSQnNMMHdIU3FpbzM3MXZ5N2ZHOGNNVDhk?=
 =?utf-8?B?NC9wQkRqdWpoeTZvcGpURS9DY1B4UWw0M0Fpa1BmaEo0SmxQNTNRazBvcmdH?=
 =?utf-8?B?VmNpbnNhc2k4QmVYVGNkT3pxNzlOREtSeDNlVnhlVXRZSEJxRExvMU5vcnYw?=
 =?utf-8?B?Y2tSQ3BPOW94YTBSS09KZU1OdmhBTUdJbXVaR1QvbnBCRjd6dVBRWWJZU2dj?=
 =?utf-8?B?Y3cvVW84NGFYMzJiaVM5U1gvNXpWYUUvVFR2Q2M2WStrVHZZOUtKVGZMNkhj?=
 =?utf-8?B?R0s5ZXU3Zk5kYS90blZKRUcrcmJSODB6aGFPaUhOTWlEOW9SQmszOC81Ky9j?=
 =?utf-8?B?UDBPeTZNN2E1NnVqelUraVpEWHdWWlF3cllpK0lwTlR0cncxZTdyWE45bVB2?=
 =?utf-8?B?UVYySEZWU3h4eDZrY1pCcFNZUWc5ekFCb0ErUWVwbmIvNyt0YWFDUC9lMGRk?=
 =?utf-8?B?YktIbGFBL2Z1RGxmcHl3TkNUaXNjckZneWZHbnFoR2htS2RlaU9WbFpaVGx1?=
 =?utf-8?B?bVRGeHA3eitSdTZ2eERrYUFUandHRGJ1bnpuaFM1c2xHeFg2TWFxdHlUQUFy?=
 =?utf-8?B?UUNrTzBOcWpJbmkwUGZRZjRJTUpjRUlNcmhlSUoybDYrbjlsYXVCa1IzVzlK?=
 =?utf-8?B?RDd2TW11eDh3UFNYTHVzbDhFVU1CRFhOdWpHU21HTEs1d0xlbzFzbE1Za2lU?=
 =?utf-8?B?VFB1eGw5dVhCaTlaSWxnSm1zYXd1Z3ZMdWsraCtqbFIvQ3Znd1Zlb0IyMGtH?=
 =?utf-8?B?YWpFeUlFMUNscDNLRXZqczVPeU5iOUo4UUhxQ1c4QXliUW5nU1ZmZHZ2SXdx?=
 =?utf-8?B?QW4vbklWcmM0SWdoNGF0UTVBZUdCUXhTNFl6QW1HcDVwbDFhc0NNMWxBL1Zr?=
 =?utf-8?B?WEgxOUkvNy80Ky9jNzNVVWRTcDJxNnRmVitqelczTmR2WGsvRjNLamFRclpY?=
 =?utf-8?B?ZUk4NjZDeDFXcnNxRlA0NTVtZ0hxTFlERzhreFV4cDNsSTZrS1ZtYWZQS05H?=
 =?utf-8?B?c3BMbkVrSW92YUpqVVg4SHBhRElieGdEOXgwTEk0aWJKRXNPSzZveGthMnRm?=
 =?utf-8?B?aDRIUWsxQ2ViMjNUaStZcEh1VkEyRUNuQXlJcHVvenQrZDlrL3RvU0FWTTc3?=
 =?utf-8?B?NE9XUVFMU3U0Nm5zYU4wOFljU2tsdEFZYi9hdytLbSt4azRUenlPY1lId01w?=
 =?utf-8?B?WU9HcXA3U3VjSDVjM1Rqb2UwOWhybkIvL2ZtSFF6UGpaNitZeHJzTkhWNVZ3?=
 =?utf-8?B?bEp2dkxRVGdTaU1ZV3lwbWo1R2FvbmNRczJZK1lRb0w4d0hMRUhVdHJ0aENT?=
 =?utf-8?B?U3cxR1AwWW4zNVd1djN1cTJVZk81MnJqR1NOdGNpMitWcjhGU2hra1dmZ2RN?=
 =?utf-8?B?WmlLeVk1TGw0UnR2Qk44aFhkUGZnallOcUE3MWVjcS8rR0FLNnlnbmxVaUxX?=
 =?utf-8?B?Y3hUQkRzZU12MzJYZXBKR09vTThPSzJkNHZrR2xTRkk4VlZUUVZlVU4wVGZm?=
 =?utf-8?B?bU1vcG1mbFBwUi9mbEYxSHZjd2x4QUlUZGkzdkxFYSt0Ry9ZQzM0c1VwRVRC?=
 =?utf-8?B?b2JSdkJKaTIxejVOWitOZ2d3Z2VUM2ZVZ1VUUkpMb0I1azlvYXhSSWsyY2Ew?=
 =?utf-8?B?YmxtNVRWTlRYek5Ca0hBM0hCUm9RMkZ0SVd3VWFoS2IvRmxlVWxxVU9DbGFS?=
 =?utf-8?B?dUh2amNRNVpNdG5qS0VSVTBxSkNQK2dCRFlqNzR1Y3l1TU5ycE0vclFkaUZV?=
 =?utf-8?Q?aH8rsYb6szZDUfZS4G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464a0158-e2a6-4e7e-ab97-08deea131112
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 06:07:54.6069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mqr6YB0XzWJKk6W09knCFzCojbR/ps9xSw4OPqy2DfonI9iGsY093A+yzwlN4fSceXD5EgNfb7mZMViQrYPLYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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

On 7/22/26 07:46, Harry Wentland wrote:
> For subsampled formats we need to use GAMCOR instead of
> the DEGAM block. The color module can create a LUT for
> that if we set map_user_ramp to true. So do that when
> we have subsampled formats.
> 
> Assisted-by: Claude:claude-sonnet-4.5
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 62791077ceef..8913bc9f0f06 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1524,6 +1524,8 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>   	struct dc_transfer_func *tf = &dc_plane_state->in_transfer_func;
>   	struct drm_colorop *colorop = colorop_state->colorop;
>   	struct drm_device *drm = colorop->dev;
> +	struct dc_color_caps *color_caps = NULL;
> +	bool is_subsampled_format;
>   
>   	if (colorop->type != DRM_COLOROP_1D_CURVE)
>   		return -EINVAL;
> @@ -1537,10 +1539,23 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>   	}
>   
>   	drm_dbg(drm, "Degamma colorop with ID: %d\n", colorop->base.id);
> -
>   	tf->type = TF_TYPE_PREDEFINED;
> +
> +	/* Check if format requires post-scale color processing (subsampled formats) */
> +	is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
> +				dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
> +
>   	tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
>   
> +	if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
> +		color_caps = &dc_plane_state->ctx->dc->caps.color;
> +
> +	if (!mod_color_calculate_degamma_params(color_caps, tf, NULL,
> +						is_subsampled_format)) {
> +		drm_err(drm, "Failed to calculate degamma params\n");
> +		return -EINVAL;
> +	}
> +
>   	return 0;
>   }
>   EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);

