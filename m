Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42CC10775FC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A24410E3AE;
	Wed, 18 Mar 2026 17:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CNbWFsv/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EE910E0A5;
 Wed, 18 Mar 2026 17:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We/Xm/SYL0ycQblS5b7ncJl253tjfoWW+2/KEAD2z9N6pGJB7lOEa0zqR6BFrh1afFOeuh4XUohXLyKr+g0RH7ZhU6Y5Wrz1ExefdDJLa84I+juSBYwfOPrF6sVk6bHOjo/3hOW18sUPYqduJLyPb8veJsUIZoulOw5nD7hAL+CYKGu6o346TkY9lR5mWPUkV7OSZmLM6h6pZWBrWowePqhpS1mKDUKAuDbfGoxxh1HP3dKAQkkvk0FUlv2B1amzv9C0rJnSAMgN/WboWUZ9mlIGM2dmCYXLbBdpkUH9vpSrYtcbUPC1PM+z3q3XtjCHUGVDkHBcpXjKchHJog1c4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiUGeH219+Zj8flSddmiD/E7wiUvRbjt4LSQ7Xf/MpI=;
 b=iAZQvpD2uIkjvmgnmZKd6j34U9PV9EqGvg/wYvlhn3+MovNLd/1DRFDF8wtW//ORsIcFtoXx+Dg6kRxtC0rvFVl/aSS6xpM6EQxkopdrjzLF118iit/LwM+XiBoKAYpXe5pF0W3hzRfWdR6eXEiP0DNAYsQlibmJj9aCa4flCiw8DYvl9npCa5KeuUwgvp8sD2nVpODZoiEnMDhqNim4EmkBXM+nVnDh19nlEcrW4CHvv2SCy4dLhEQPENkK3Mak0vphmsAkLuoJM+k773xo8cgkzLF1VEV2CfE+pc3n6UvVSUUTmEKfThmTVR2Zmq6S+XTYlEvr6WjFf2QfA1VoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiUGeH219+Zj8flSddmiD/E7wiUvRbjt4LSQ7Xf/MpI=;
 b=CNbWFsv/H4cyGOGSHfx62qmZwqQHA5iiFUgN30L4OUhZr64iyrIg+IZUzb+UG7CAOvhtlAr+mWZZmnX9CsVbBOdGSu/yPQfDDtxxnln2OITNBAdl2gzn3i3nBuoCeSyEcK3vS2i0vQjK2XPPg/zTM3T4+1tmhxfPccnPxj3H6uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 17:59:02 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 17:59:01 +0000
Message-ID: <93734c25-4a1e-48f6-9197-2ab9bfab34ca@amd.com>
Date: Wed, 18 Mar 2026 13:58:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/atomic: track individual colorop updates
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
 <20260318162348.299807-2-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260318162348.299807-2-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0088.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::21) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c70f608-cc03-45a1-64eb-08de85180960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|921020|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ofT1nEBbJADUrLyM64ldzGRCxoC2FV30CoVV/PC3JxHzKHACQuQoldN8r1z9NHI536jdJmGQZe+jyp/uhfbMG0OazABVUxF6M6DcJlNGKlUY/WyNH6LYVLWgMEh0FquBX3sCZOi4QXyq1ZDW/P6SuWT5Xbz/n/vKBnb2QiWnnLfgDxU6DoqjAXrDM5SVD3PcUXiRnvQ1vtRl6+NrJu1imXF9gyTjFcn+jxfANf6clWfyFb1wETqmkbZSOV/YpYrFGfnWCNPKqC/9Lc7Dxjc2uvxR1+OukxTZoA938NvA5KgYtYSrphNldHuBsbQD5gl60Y9Ei/hM0J1s6QueU+IDMNlnTWP7sb3AvRkmvqNjUMXW5GOvhOpr2H+TCwiSnm90rZLdMPkwxbieGk/GofVwRUwJKogwoLeRlk9AYHGxErtjMTLB3T/d+PT3gkk8MzUqYdbxWwi01/KpoSEzhTBCsRURg9aG9kEO8NZmMMZClZ652lHuJtrlvUiU+9uqhWRS6V5cEiiTTf7BiifOk2E2IIbUnRM8Y62N3zhM41aI6jL6WoFrWJ5TryocOT3Up6a8PqYZ2oV2xpyR/SSFFVdk5ELazOKBv9Z94pwpSjmxZHfnlkwwG4eCpRe/lMknU8FhXiMgrSBUKXdpeFZxWW55FK07ZoITJKh0PUJKQUHKtK4qxmm6kSq+XwkWuaJKZii49tv2IbIGxj8v+CQTsp9jfrz7CEtj3InQr9jk7WJOQyF074tftY0cfWeGjQXaxKvvS8kS2CATttO97/tCl/DF5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCtHaWMzclVqTis4N2F3eTlMNWpuOW56NFJHQUxlSUJIVGxBa0tVSnNRd243?=
 =?utf-8?B?ZnNWTnFkRzdYSlVWTmhqbnZ5d3VtUHZVcHR0TUlYNjNUbDdhL0pDeUN6VGIv?=
 =?utf-8?B?bnFoU1dZcmZQQnpkb2o3UGtVNDhEYVVvNlJsMkJYaUpEL1d0dytHRmxKZXE2?=
 =?utf-8?B?WHRtcnEySU5QeU5ISUxLTXkrc2UrcVRuTXBRNG5lT0paQXFXM1M4cEJGT3pW?=
 =?utf-8?B?dEJHN2R5ZE1va3BjZEtBRGlyVktZbFRwZ3M4WGRtZGtTWVhsR0x3NlV3RHB2?=
 =?utf-8?B?dWgvQnk1eFMzVFJPblpJV0hWSjFBYnJDRjZMK2ZEazFiREFtVHVvdGFOVUJw?=
 =?utf-8?B?a0F3N0FaeFZ1Z2tqRFR1Q1ZCTVNvRXU0clNQY1lodllzM3F1ZjlRQnhjRmJp?=
 =?utf-8?B?Vnp6YkFwZkNWSUJCNXh6MER2b2oxZlBUS1lPSEx6RzZHK0JBVENYOXJLWWx6?=
 =?utf-8?B?Q1NvbFJ1eDFPWlh0a1FIV1A3WkdUT3hQb296NlEyMG0wSW55QlJibUZhWW8z?=
 =?utf-8?B?ZXVacmlrd21KOEo4cmoxT3NXbzBuc3lOd3FZTEl4VkJsVjM1aGZWZzNEZHVy?=
 =?utf-8?B?dTFVaHBmV0RmK3dORkMzWHdyb2pBanVuNDhqZmc0b1VkTmU1LzBDand2UFF3?=
 =?utf-8?B?RXV0dEZRK3FvMVlQOC9WZnVPSDFudTFvNGJzbTR3WnFXYlhpUklmeGRzZisy?=
 =?utf-8?B?N1RIV2NsWnBXK2dpMVFzaFJZV2tUVXkzbk1HcHFKSnhRdURDNkEvNlE1d01M?=
 =?utf-8?B?MjZ3VGFtd0hoekMxSXZ0UGVkVzg2OWhEZjZBdXVpdmZGSTVzdmJpaDVkcVZ2?=
 =?utf-8?B?OXBaWENueXR3a3ZjV3pZbmhnemZzNFJ5YWVEdno1Sk9JUHFuQmFXWS9DQ3dL?=
 =?utf-8?B?eW40OTA3cTV5Qlp4SlRTcnErYXliamxoeHVGdml5cnBhNHI5Yk5FT1k2Q2pj?=
 =?utf-8?B?N1J2eitNR2lWeTA0b0ZpRWU0YmhWZTNKdXdwN0Qyazd2QVl3Sm1HM2Zwdm41?=
 =?utf-8?B?VGM2QTBYUk0vSEpiZGJINWZLWGJSOThReDVQekdHN1QyM0xRNmQ5a0g4MWQ1?=
 =?utf-8?B?cDRnOEZwU3p1VlhHKzRXRDI3Tzc0RU9WLzlmOFZFdGxTT2pYNTBSc2tlSmhL?=
 =?utf-8?B?ajJxRDVqdGtNazZSSXJpazVkd3lDVWNPVGlNS20xK1RpNlc4Z2NDamRTRm1J?=
 =?utf-8?B?TVRFWHY3MGJ2eGduSmIrK015T1oxU1plQ2ROMXozclM3M3VUekxXd3BBUTlK?=
 =?utf-8?B?V1FSc0NMY3BTUWhaRlRNazJYTEo0cm1uVUJKNUlBb3VBWEdZTFBUTVl5OGZx?=
 =?utf-8?B?cWMvaG5DMm8rallxSnAvdFZNeCtidXVjbk9OSklYSXY2VmhwY1VmWGRqWFA2?=
 =?utf-8?B?QXF5VTV3QnRhaGZ0bkNjOGY1SFAxQ3l1Y0RBcDhEQVBkU08renpQTXFjcFR5?=
 =?utf-8?B?eFQySHM4SW02WEUyZnk4K0NJUHBFelZGV2t6eDVTalllbWNkOVZ1eEE1U1ls?=
 =?utf-8?B?L1hFZHJQc0cvYmZSclA4SHUrUjN4bkpDTGgzSjF4MW5HSHJCeWFOdGlMOUdu?=
 =?utf-8?B?SWx4R29CSEFhdGIzRHo2Z05LMUF2aWdRSTllWG9VNU40c3ByaTZUZ3VQbG42?=
 =?utf-8?B?NE5qT09ZbWU5MjlXWG41MGl4cDBsN1NMTU1SVThsdHVWRmdzcVU2MFlXWlU1?=
 =?utf-8?B?SElkbW4rVFBSNDRaRGxjc1AyNkdYcjhpUmdpUVFxeGk1RE9jRURzVXg5eTVY?=
 =?utf-8?B?Q2hUclB1MTFxbFhMRUovblBoWnFrWXFtRThTb3QzeVlDeGYxblVxRkh3SjZV?=
 =?utf-8?B?T05IcUFsemxONnMxWHFjTjZsMTErbEY1ZlVCQWRwRnV0ZmpHWWdrQUZDQlZ3?=
 =?utf-8?B?VXc1eG9idWl0ZGZ3d0JvdXNXOTcvWlpzZGE3Z09OZ1J5aFFEM3JxaEluSndF?=
 =?utf-8?B?MVQ4Y0N2MStWYUdDWGU1Q0pSUStpUmdDV3lJSUJPejViNzZES0VOdFN4V0Z1?=
 =?utf-8?B?RFFUeURIenhROHJEYUxlQTErVUFWaDRaOU5WdzlndkJ3RitKdTk1azJhek43?=
 =?utf-8?B?OEZWbzBRVWE4UUpnZUpNdUloWUJiLy81N1p3dUJDS0kxN3l1eW02c1J2cE84?=
 =?utf-8?B?RE1DVm9DMm9Td0UrcXdzUlZPRTFIMEpOTEgyQURFQzRtQUR2OUNBZ1BGaktz?=
 =?utf-8?B?UzdaazFPWS9KOTBaQUNzZSsxcEtiNENoaTNnOXFOY2cwbEpGQUh4YktHQXA2?=
 =?utf-8?B?V2I2ZlRhckxCdnhjKytPaFo4SlZzVUlOdWlUKytsSklScERQV0Y1WEdQQWhm?=
 =?utf-8?B?bVBGVFcvcm91cHNTQ3BqbSs4S3IxSktvMEZ0S3Nmd2VyamxWeFZ3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c70f608-cc03-45a1-64eb-08de85180960
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 17:59:01.7212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+ftk7q1b7rfSm6WPJ09+CS51eLmDunRCvICwd4U2MSULdM7hpwG14/AWI364ntXdIa6SgabP8TSi0pVsFL7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505
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
> As we do for CRTC color mgmt properties, use color_mgmt_changed flag to
> track any value changes in the color pipeline of a given plane, so that
> drivers can update color blocks as soon as plane color pipeline or
> individual colorop values change.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 53 ++++++++++++++++++++++++-------
>  include/drm/drm_atomic_uapi.h     |  2 +-
>  2 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 87de41fb4459..713fa9e81732 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -265,13 +265,19 @@ EXPORT_SYMBOL(drm_atomic_set_fb_for_plane);
>   *
>   * Helper function to select the color pipeline on a plane by setting
>   * it to the first drm_colorop element of the pipeline.
> + *
> + * Return: true if plane color pipeline value changed, false otherwise.
>   */
> -void
> +bool
>  drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
>  				 struct drm_colorop *colorop)
>  {
>  	struct drm_plane *plane = plane_state->plane;
>  
> +	/* Color pipeline didn't change */
> +	if (plane_state->color_pipeline == colorop)
> +		return false;
> +
>  	if (colorop)
>  		drm_dbg_atomic(plane->dev,
>  			       "Set [COLOROP:%d] for [PLANE:%d:%s] state %p\n",
> @@ -283,6 +289,8 @@ drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
>  			       plane->base.id, plane->name, plane_state);
>  
>  	plane_state->color_pipeline = colorop;
> +
> +	return true;
>  }
>  EXPORT_SYMBOL(drm_atomic_set_colorop_for_plane);
>  
> @@ -600,7 +608,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		if (val && !colorop)
>  			return -EACCES;
>  
> -		drm_atomic_set_colorop_for_plane(state, colorop);
> +		state->color_mgmt_changed |= drm_atomic_set_colorop_for_plane(state, colorop);
>  	} else if (property == config->prop_fb_damage_clips) {
>  		ret = drm_property_replace_blob_from_id(dev,
>  					&state->fb_damage_clips,
> @@ -709,11 +717,11 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>  static int drm_atomic_color_set_data_property(struct drm_colorop *colorop,
>  					      struct drm_colorop_state *state,
>  					      struct drm_property *property,
> -					      uint64_t val)
> +					      uint64_t val,
> +					      bool *replaced)
>  {
>  	ssize_t elem_size = -1;
>  	ssize_t size = -1;
> -	bool replaced = false;
>  
>  	switch (colorop->type) {
>  	case DRM_COLOROP_1D_LUT:
> @@ -735,28 +743,39 @@ static int drm_atomic_color_set_data_property(struct drm_colorop *colorop,
>  						 &state->data,
>  						 val,
>  						 -1, size, elem_size,
> -						 &replaced);
> +						 replaced);
>  }
>  
>  static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>  					   struct drm_colorop_state *state,
>  					   struct drm_file *file_priv,
>  					   struct drm_property *property,
> -					   uint64_t val)
> +					   uint64_t val,
> +					   bool *replaced)
>  {
>  	if (property == colorop->bypass_property) {
> -		state->bypass = val;
> +		if (state->bypass != val) {
> +			state->bypass = val;
> +			*replaced = true;
> +		}
>  	} else if (property == colorop->lut1d_interpolation_property) {
>  		colorop->lut1d_interpolation = val;
>  	} else if (property == colorop->curve_1d_type_property) {
> -		state->curve_1d_type = val;
> +		if (state->curve_1d_type != val) {
> +			state->curve_1d_type = val;
> +			*replaced = true;
> +		}
>  	} else if (property == colorop->multiplier_property) {
> -		state->multiplier = val;
> +		if (state->multiplier != val) {
> +			state->multiplier = val;
> +			*replaced = true;
> +		}
>  	} else if (property == colorop->lut3d_interpolation_property) {
>  		colorop->lut3d_interpolation = val;
>  	} else if (property == colorop->data_property) {
>  		return drm_atomic_color_set_data_property(colorop, state,
> -							  property, val);
> +							  property, val,
> +							  replaced);
>  	} else {
>  		drm_dbg_atomic(colorop->dev,
>  			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
> @@ -1273,6 +1292,8 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  	case DRM_MODE_OBJECT_COLOROP: {
>  		struct drm_colorop *colorop = obj_to_colorop(obj);
>  		struct drm_colorop_state *colorop_state;
> +		struct drm_plane_state *plane_state;
> +		bool replaced = false;
>  
>  		colorop_state = drm_atomic_get_colorop_state(state, colorop);
>  		if (IS_ERR(colorop_state)) {
> @@ -1281,7 +1302,17 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  		}
>  
>  		ret = drm_atomic_colorop_set_property(colorop, colorop_state,
> -						      file_priv, prop, prop_value);
> +						      file_priv, prop, prop_value,
> +						      &replaced);
> +		if (ret || !replaced)
> +			break;
> +
> +		plane_state = drm_atomic_get_plane_state(state, colorop->plane);
> +		if (IS_ERR(plane_state)) {
> +			ret = PTR_ERR(plane_state);
> +			break;
> +		}
> +		plane_state->color_mgmt_changed = true;
>  		break;
>  	}
>  	default:
> diff --git a/include/drm/drm_atomic_uapi.h b/include/drm/drm_atomic_uapi.h
> index 436315523326..2016b6ca0f3e 100644
> --- a/include/drm/drm_atomic_uapi.h
> +++ b/include/drm/drm_atomic_uapi.h
> @@ -50,7 +50,7 @@ drm_atomic_set_crtc_for_plane(struct drm_plane_state *plane_state,
>  			      struct drm_crtc *crtc);
>  void drm_atomic_set_fb_for_plane(struct drm_plane_state *plane_state,
>  				 struct drm_framebuffer *fb);
> -void drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
> +bool drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
>  				      struct drm_colorop *colorop);
>  int __must_check
>  drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,

