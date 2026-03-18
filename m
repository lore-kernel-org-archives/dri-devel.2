Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D976810775FC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E1D10E0A5;
	Wed, 18 Mar 2026 17:59:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbXHHDsC";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D75310E44E;
 Wed, 18 Mar 2026 17:59:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNj3LqclKx40AJ5wb+jy3vVGrDxGBxw6ozlW2RD3Zbk/funVW+7tPjw5uUWR1f8GyWILoe+OwQhOEDGCy7CUiPOolOhseuqk83f1j4jNNWaYWdBAxQF2x5qG95wS3PXE0cC/u77iBQcUTs8m0UcIqsV8FQCW17W0fTfe4Ge71elGw8m1MnpTVVpkZIMxH6YExVggtoGqbuQaVwuvtnCsP5MRBfm28l8dGC7FBdDrKmed65tn3xgp5ZwBv1wloUd4CtiGOzqAFhk+Xp58KNQ57qyN6Ago30q7MJS9lCt3jUlaaTzEP5d0YEOWoiBLlAnu1r4acPesZ0SL5EK/ZNbvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM10usNjbJuAxAxRmV+16A+I7sAcA10CNL+2xSJGNMo=;
 b=fpxLI3j+H4RW7visfgsM68Qs+M+7NsxFXvOBKQwxlPNci/2xg4HPC07R9zmMB/r1H+ymhmE56kCXm3LQBWyYquVxnLyn1wb0f9Pw4gBdyVFlJyKSfNfsVGWX1BQl2bIc8vIeyrxOVQO8feluBFQWKFY0fQbnoWdn83TJwryu8uD8bS3n2rr0A4S+JdDgFyqnAWsLqqSn8OOQTPBMrJe1kc8byzjFW36Q24ZyHHWFWUzR+/O4lWcuyYTHY5RDO2RjTCT7wt6fqm0NNNwdvgSnopE9zGPRM8n7fvMot1GPqIuWG3LlgxfKGNeiSylhrAyCSFt2NdE/GSBEWWiNuHbhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM10usNjbJuAxAxRmV+16A+I7sAcA10CNL+2xSJGNMo=;
 b=bbXHHDsC6TOQrOaWZ5ilsCG6om6f6MROnT/id1bJDrxZF0H2tvs5B63RY8gispmOKPZS0dyKVp2IDDYTDe9t+vmNe9HE4nx1NfVnEm+MLHhgniH6iDy9WagvspBPfNuZk5JB17lbJ9aU41WIv0iYu58/nXVFbW4xC8ph5RbtHL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Wed, 18 Mar
 2026 17:59:30 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 17:59:27 +0000
Message-ID: <1f10aa62-5f15-4f70-b1b1-549e36825064@amd.com>
Date: Wed, 18 Mar 2026 13:59:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: use plane color_mgmt_changed to
 track colorop changes
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260318162348.299807-1-mwen@igalia.com>
 <20260318162348.299807-3-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260318162348.299807-3-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0080.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::15) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de6c6dd-1dd7-418f-4dfc-08de851818c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ySWAMWEHb24U/KCjLH1hYmVxF//okscBXZidKWRvGF1tArmuNbwk2JKB+d5z2UKCXjnukWw4qsJ4buM35xkKfGVtCBFYMtrYw09Zf5hLa2opa/FS8pWwPWIcX1xwDWu5FS2/ihPkoScIc2Ez/oXio3IgxMCHqMiLJ4NuEPYXgx2wijZNzzewVrilXDfTooknmLnwE/t8498V1RnBWbSDKXjAd9B3oZpsTjLQSS6zpvn4FiWwH4ig7tgP0A5SYyT0icM9XNeGz/t6s+vkwYGp+KdIA91XZ6oMQdIQOcmwCb0K/M6C93OVsLQw/eT7/UtrJPBpOImliCxEYZHlHAWVi4zzMAr/VKF1DL3vU3rYNjJXY757lHGl9JiTh/P9HYxDFITsyjRiKmKWTmvR/mDbD4CPkUcDcr3RIzjHWXeIbXoEmw3AY8sDIoAidiCD+3JI8+/HUJ42M8vBdd0KU5/Q1fYpg5MtI98BU5YlgEjhx3PEoy/dMNXEdYVKe+P3nfb+whfI3DXpsQ55qYo/JNYiNRpDEiFcmFwOCcijvxAEX20mwsOIuC1typ5TsP9Zf+WP2zEUl5XM2O0gVSeMFEewyncmNg/BgDj93O2d7BSmhdQmGZ9sST25DHD3HBR7mPqt7ar/1s6Tqu1i7aOyk1KMdlPRyuxb98ZtqRVO9t4qCht+e59jmp7/GAbDdrPxYGsHb7GChi8NN0Eycc/dKm/HbTwH6kZUEq5VKMVSqqfQmWj8FBMSzuYXPsdAS6/krnjx/QB63qAwPi550H0i80R7Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDd3QzlRVVpTbWZGQUc1WjNScURqVEdZQWx2ck5QV0tnMnp2aHgvYUcyQm5P?=
 =?utf-8?B?cVFkZDFLa0d1Vml5NkdrWkZTMWhsTDNqYjlrZ3o5ZjQ5WXExS0E2czRvV1Uw?=
 =?utf-8?B?a0tHcGNLU1pnczlwSE1IWCswRlMvRXdIeG1sQ2EwWUlOdE9RTU5OVk5KTXNF?=
 =?utf-8?B?ZCswSXdoUUlPbktpMXRoY1VoUURySU1ZRlBNMUFxd0NtbFRtWjZBSVpDS0hR?=
 =?utf-8?B?N2Rmd29pMU0rb3Nna09WR3Y1YnJzK01VbE92bUQ2eGpDSkxpR2FqWUJzMnVD?=
 =?utf-8?B?V1ArejJoZ2g0cUoyempSS1B1NmE5L0doY083UEZsTHhTczY2aFF5Smllb2li?=
 =?utf-8?B?OE4wekNDODRRTWVYSzlHR1VrSVZxMHJwTXVFU3RXTURjVEtnRnl2bW1JY281?=
 =?utf-8?B?aG9sUHlvSldnR21iWWljalJRRUVZbGRhcHVCNDNVQ2lOYk5aT1drVFlHR25h?=
 =?utf-8?B?bUJXNmVXb1FNR1JueGloS3VWdWJ5c1JFYTR2UUc4TDF6aFllMkg4UFhYenZF?=
 =?utf-8?B?MUE3TlVMSUgrZDQ3bEZ0SHIwZHZjd2lQRVpDZ09vbjA2UCsrSitHYnhZR2hK?=
 =?utf-8?B?R2sxZDdPMTM3VE1ielJIQjhleDduOXF4cG8xSlpLdTVBbWZDcC80OUU0Nnd1?=
 =?utf-8?B?MUR6RUdxS3NzM3dYTHdzVnYxWGhqdm93dU8vY3VVL2hLWnh3S2FWZmp4cmRE?=
 =?utf-8?B?dDd5YlNXR2YrZndsZ1YvWXo0UENZWU43SGFURlBTQ3EzaEt6M3JnanR6K2V2?=
 =?utf-8?B?S2xIVk1xVmR5YnI4SXBOeEgrc3FzL2ZoeklSNlZpUEd4WFdyMGMveGROSDJJ?=
 =?utf-8?B?U2Vsd3JJQ0daTUdkQXNsRHltTzJMSWc3dmY1VGJ5d3labDVnQlJMb1crcmh4?=
 =?utf-8?B?ZzJzRjQ4R0RvcFRuUkhJcmlPRFBKM1ZZQTdIeUd4KzZqaUZDcVhNQWhwYWNM?=
 =?utf-8?B?QXFUVUdjTm1LNE1HNmxKUDR2RlhmWjNxcUpCNUVPR3lKTCtPNnBOQjRTejA5?=
 =?utf-8?B?Vkltd3FVSHJ1NE8zNGQzOXpHcURPaHFscWdTd3JlVkhPWmlxTy9FSWJvRnZG?=
 =?utf-8?B?VVJYMnY0V0FVWElxVGlkaHpWRzNvU0x4em95YkJOQWYwRDhiMGYwQ1hqR3Jr?=
 =?utf-8?B?SzVhVXp3Q2pNcndGVzVLbm9KVTZuZUJINUxOTTJWOUJWSUlrejAzRmNMRk5B?=
 =?utf-8?B?NDByS3NNV1JucWhkVXVZTi9CSkwwUU5JNjRIMmpJYnNxZ3pJQ0lBZzlObTZN?=
 =?utf-8?B?aC9QdDNPK0FRcjJkb0RCLzZoWHVsUkFYVFRKZHFidXBES3ViOFhCczdSUjRN?=
 =?utf-8?B?UTg2d2JZeC9QU29iejJleXZxcTg1M2dyRjAxWVlpQWRiUnNGUGxOOElpWVFU?=
 =?utf-8?B?UVFNWWVFcThDM3hoTFpxTzBBL3NIWWxid3Frc3U4UUdyWUhrR2JubWZnUEtx?=
 =?utf-8?B?NVRVb1FLbjJxZytxeW8yUUZxVThnbWdEbTBMV3dnSVVlKzZmTnlUb3doc3pk?=
 =?utf-8?B?ODdySkgxa3BoZXBUbS9EYisyZjBnaDNtRnhWWjJDbk9ocXdBektUcHRGa2pY?=
 =?utf-8?B?cHFsNmxhcW9EeW54OEp1c2twMGdybG0vT3Y2a2pjUWlyL090Uzlaek4zcWJ6?=
 =?utf-8?B?ZCswc29VMU1xUlczL204bmpGOWRzS1FSMFhEUzZIV0dESDVkZXYzdkdwOEp3?=
 =?utf-8?B?eDVCa0VFVEVpQkF1Y2NtNGxlOTgrUXJYY0MraUFFeUo5Nk54WkZrMkYvazhT?=
 =?utf-8?B?WSt6Zi9KbzZPa0IvdzhEaFBnWlAzcXJDUGpPalhiSUUyTkhPbjc4a3BtZno5?=
 =?utf-8?B?RDh0QjZPdUZQQlFSVUcvV1hleDJEUXdaWXQ5Wk5QNUFlQnZvNkFrV045N2kw?=
 =?utf-8?B?TDhtU21FSVRqRGNkY1VxRmZ4eE5ES3FNdVlqOHJnazNaaUFEUllZMWlHcmFR?=
 =?utf-8?B?Z2NlUG9PVStPQXpGelBZeVJVSzBXMWhwdjludjdCOWRSeENZYnVYb0hoWnVM?=
 =?utf-8?B?YWkrUm9UQmpYSncyN29nbnI4M3ZxeUxvdEtJYi9VMlJ5QWNjdkxmK2V1TExu?=
 =?utf-8?B?Q3dVTDk0cXhiSmtaeUNHa0N2anpCd1Y2MXRtQWViaTJ1STlxMkNyd3ZRYzdh?=
 =?utf-8?B?T0M2RjJabkF3Z1ZicmpjZllzOXJucUk4d0hkSU0yTDZabTZBc0xnTk5ySk90?=
 =?utf-8?B?Mjh0MlAxN2lsUjd2MlMza1IyL2crb1ZiMGs1bTN1eUhKd0F4Nk14UGlFQWJL?=
 =?utf-8?B?eHBiOWlQZ3NOcVBwSzVRSWJPUlowOXE1V0dycHlzaEpONlZyRG9odDRIRkVn?=
 =?utf-8?B?blNjcXdyTU5zaTNvbzdwOUMwNTlSei9oQU5VYWFFOE4wTFp5NXhmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de6c6dd-1dd7-418f-4dfc-08de851818c1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 17:59:27.5232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeRFeRaNY/s4bKGwZ76eMKB3xEgEUwZ957f/YpSNaA1+WgyTrBKYI7WeECaEcOz6263+DsMf6aiNj54tvqgmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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

On 2026-03-18 12:12, Melissa Wen wrote:
> Ensure the driver tracks changes in any colorop property of a plane
> color pipeline by using the same mechanism of CRTC color management and
> update plane color blocks when any colorop property changes. It fixes an
> issue observed on gamescope settings for night mode which is done via
> shaper/3D-LUT updates.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dfe95c9b8746..dc3f284d0834 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9955,7 +9955,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  			continue;
>  
>  		bundle->surface_updates[planes_count].surface = dc_plane;
> -		if (new_pcrtc_state->color_mgmt_changed) {
> +		if (new_pcrtc_state->color_mgmt_changed || new_plane_state->color_mgmt_changed) {
>  			bundle->surface_updates[planes_count].gamma = &dc_plane->gamma_correction;
>  			bundle->surface_updates[planes_count].in_transfer_func = &dc_plane->in_transfer_func;
>  			bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
> @@ -11695,6 +11695,10 @@ static bool should_reset_plane(struct drm_atomic_state *state,
>  	if (new_crtc_state->color_mgmt_changed)
>  		return true;
>  
> +	/* Plane color pipeline or its colorop changes. */
> +	if (new_plane_state->color_mgmt_changed)
> +		return true;
> +
>  	/*
>  	 * On zpos change, planes need to be reordered by removing and re-adding
>  	 * them one by one to the dc state, in order of descending zpos.

