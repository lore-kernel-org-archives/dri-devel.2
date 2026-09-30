Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE8DCA5FCF
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A60F10F4D3;
	Wed, 30 Sep 2026 19:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jA2kHvCp";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDFA410F4C6;
 Wed, 30 Sep 2026 19:36:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAqAaiCK934v0K+53mr34NdlkKyycKb3cTOAhg+5K8btCqIJin5mPPkHPqvAqH3lG+3LzPXoK28ljYKp9rsxyYZ8AHQeAUEPv2OfRASSjzJrFoCFe+pnilLq9viBf4VHmeh7vz+pn3A3caw+0egvYd0MdFdc6cMK/PDqf0NEV8agF4wF/ZGdq0ukAova5IQ9waUdz8OmYw9o4NjEbdT2v8IG+ta40rp/WvJpAeP25L7z82S3Bx8RRt8cjfyrSC9vuAfc0kiChkOIcnM/GsnrhiAhZagarnv5NLLLeF59JJiCm2k4RQ3ZGABEGyGInmMZjPePp2U9QKz9hxPjbwQNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWYxnhEc124mEAzTpHOA4/5eoLVO6ZbwT7qIemK2law=;
 b=QBhgcSXEyvHO7jfyuFMmDauILdDrIePrZUPp0tNXn6NaIG3WQJMPzz8qe41+zCkFiJl7Rb8Byb2APX0wQgZMDZuP1IjXIz5hJeYVTEs3rpDZ27EF3Ls6rgmm7dhVPj80bDugIKyQDVoabNUyYOWMLBMqT0rrC+KRRDTwLMi81Q2lDjJThXZB5YKmk8194OTzki8WaY5N/8HSfo14k3EEZTqq21yOHLjHi+YyIaSc73GXgKr16tftcy/rvmgoicaGutiQnSyCMZS4LyPjEscOLgv0k17ByhAXaZ15rNR9JLpSZktJ131XpkO4AhhAGdyHC8BeQbzX4cbV6qYQPR9/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWYxnhEc124mEAzTpHOA4/5eoLVO6ZbwT7qIemK2law=;
 b=jA2kHvCpvv1s2uukbB/j39gBdwKuidGvx6OI8K+Hh+ags1294P5834zYTxosJBbjXo1/U4zaOtZ7F3ITXxJ6gmXDZ4TT30ogmHVD4XhYt4bwtCA97NTrTTzHFvhN2ZrXJJUGHxAMh6TZSgULfbI5pdGSFysaiPxW6vRjWByFbWg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:36:34 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:36:34 +0000
Message-ID: <930c280e-e5eb-4a03-80a6-183a68a2be90@amd.com>
Date: Wed, 30 Sep 2026 15:36:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] drm/amd/display: make blnd bypass mode clearer
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sebastian.wick@redhat.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260811171011.184964-1-mwen@igalia.com>
 <20260811171011.184964-9-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-9-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0398.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::19) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 090c70db-a658-4726-d2bf-08df1f2a22ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|5023799004|11063799006|4143699003|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6GmkSFbEoXWZ9oObRPxj9reGnpZidyScw2en29vCnrPbluHbS6P9t+/GVe3x2JuYIvp1uN47bx1V7LcdwfM3Z7EHGLa44pC1QbLZKs+/76Vc7jbDM5DsN+Rd5VSjVD0aUu1zigmUWR1pvXCKh9Fksov5DaqcAi+pKTS2DWk+tFjochSr461MNbOii5429P/ccIpiVLVCi6xbv/nH5dKzyw2y0PRXLWHncu6HS3HiBdahjIM1Hs1PJBrMt8DmkXb4MT0VLAj3rOy9RHbvHcHXmlgUCKb9LiBxWgvPO48zzqT78A3OaWOGmvLD1vMXia3O24b9OHHNeNaWIT/rBoSHKhQClmt3u0TZg+9ek8ddNpJKRobSJ9loEn2Up84yK1m9wv2rv+Cd5fb8uVAogAGJlJSdY5wQt8bNHEZcno3wKeXuT5K9ngbWeSoxNKIfQa/To3Cwg3W2pODK9wSDyLruGyfxJ8ZrGMvVEU1+U090U/rq2LgfiikvJDzyInNFnc63EBmdv67btNOyxY4PbbfWsCNuDJ8TgsQpNxNjX3G16L2eRv8z/Qt+0dEH4aO65vXhUGVmfJMilDNTOrxyVEh/vIbREuk/+ZYaXgJ/3+CywmCRygKr4dzjW+zuxRCsZOR3mnDMU6k5e+yeILE2WAqhIagfNf+0BoCKz37ovryvRbpgyO1yBxQiaRurhEQ12EP74OznurEUxw1EkUYy73enmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(921020)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9mWVJudlV4Zi9FOTgzQnZybHNObjNhT0hJaitNUkxlWWpmZnNYRm5GUFN1?=
 =?utf-8?B?SklVTTh4NWg1OEZjeDBSMFNINGo0YUZLYVppNUpjWVdVczFyT01HZXFycFdo?=
 =?utf-8?B?NGM1KzQ3NVJaeGNLQVVrSmgydGpWZGNNZktQaXNWZGVXbWMvb0pCWXVnRjFl?=
 =?utf-8?B?OHJXOVBXNEFONWtpZmpuY082TmJxc05WQkdiWk9EVmhVdm1lTVVGcHBJckhY?=
 =?utf-8?B?NE82YTAyR1V6aHo1d0puUDkrOUlPSnFCVmVCOWdWUFlIMk1MV3Bwa2k4UFhW?=
 =?utf-8?B?Ykc3VlEyaDhLekNjTGtBMkNuaGV3SThhL3dXbURFTTBjVU1OaFFoTERQdkF2?=
 =?utf-8?B?RUVYWnorNGFHWkFHNkgyM3JWNTIzaUtPTDlPMUpGUmtVREhiSExMTWNpTmpS?=
 =?utf-8?B?UUpHMmJJcWYzSEdzL2RiSHlEcnd3NGlDZWRuWWNrUm5veVRwU2hNN01PcnE0?=
 =?utf-8?B?YUlkbllnSlg2UXQyb0ZJQnlobEErSW9aRCs5a1dqNER4SjNCWnpqQkI2dUNr?=
 =?utf-8?B?OG81MU5EVW5WWndzQ2NKeFVDZjFKTUk4b2VtS2I0ZFQyS3BLZWZBMGo2NDlT?=
 =?utf-8?B?S1A0TmphSG10M0phNk4yY1R0cnFBT1lib0ptWUN3K1c2WS8zRzllOWhWUi9h?=
 =?utf-8?B?bFpnNDVIZ3ovMFI0bUdDaTZtOXY4Rmw0Nk1WTG52blFGS2NLWU5yYVlKUmN1?=
 =?utf-8?B?SG9jZUdZOVVrTmJMVFlHTVhVWklXZ3l2d0JaSGozbmxCeE5tckJPWXF1OEJo?=
 =?utf-8?B?Y2FxNnpodEtxSm5GUHFxM2xrRWlyOTk1SHUwTGZvS0ZZd2lGQkpOM1ZIamxN?=
 =?utf-8?B?S0JmZDRGVFI4Qi82ZmZsN3RXRjZkSjJhZkg5RFZxc3c4bVNRY1BaZWJkanhh?=
 =?utf-8?B?Zk51Yzd4blphZTJJSkdrdkdMOUpQcjJsMjNIRURPNGQ4VUR6bVF1cG1RSzhE?=
 =?utf-8?B?c0VvSG1RMHRMVzBqNTV6dHdaenphcG5pOWM2b0Juc0REb0NPSW9zUHJBdllJ?=
 =?utf-8?B?ZGttVjQzYmpmbzVReDJ4ZENWa21SekpZUGFLZGJqSzdSSFUzNTA4bVMvS3Zu?=
 =?utf-8?B?ZGRMak92RG9vd2tRcUVGQ1hmNlBaL1NRMGxuOS9lNUFCTHIrNjN4YnB6WXZy?=
 =?utf-8?B?bjBvSXdES1VkY1h3U2tKVjBBOTBNYWQxNTVubFJ5L2J6ZmFaeUdtemRLSTRV?=
 =?utf-8?B?UFBveStReEgrZEV2THNycXlFeDVTQWpHbjZxeFVVTitaa1NoR2J2UW1LL3FQ?=
 =?utf-8?B?MnpYVHRCYzRMZCtUN1FvbWJpaS8yNGF4TEFLaVlkem9CVHkrVDdzWW1kMjVs?=
 =?utf-8?B?L3VpUGUzaTNDcytwajdTdGlqQmpmTzFTYzZxcFo5RVRWTnJqN3ptZnlDWVFs?=
 =?utf-8?B?U2ZDeFpaQ3Roc0VPQUdxWTlKbzhuVi9Va0hYdkk0dmZjeXVzbFo0SElKcmJx?=
 =?utf-8?B?TjJ4Y2NnWnBVaXNZVWg5TXE3bDNpR0V2c1VDSmZEd1k4d2drdlEyZkFlWWtk?=
 =?utf-8?B?cmVvdXdDYSttMTJEcWltcEpJTDBoRnhxd1IreU9zN3ByVzg2YUkweVJLS3hp?=
 =?utf-8?B?V2oxVTlEK2ZObE9kZi9vc2VhZUlwWjlyclBjR20zOWRCb3cwUVBpR2xXTmRo?=
 =?utf-8?B?MmhON2FHMEx1OG9WbHFMSW9ndmFVWTdDaWVBNjVBSkE2cjRvckNVb0FRTnYz?=
 =?utf-8?B?WkFnTEtlSzhDT0V4TzhzdDZQZ2hCalRCNEgyU3NRdG03VHVGTFd1UDBpVmxD?=
 =?utf-8?B?NmxSRVRLSUxNbUVkeW0xMlNweTdGK1Y1dkxWWEhxbTBZekV4VkUwUk1LMkpl?=
 =?utf-8?B?U0Z2QVRJOG1Tazg2eG5OdzBZNmRreWU4MnNSdGx6QWVld2JpajNJa3VFSzEx?=
 =?utf-8?B?VXB6amFFMTgvTUFlbnI1RVFIRHFSSFg2RGpibFcvRnFnVk1adXlrRHdXbXFn?=
 =?utf-8?B?R3BSMWFnNVhiakwxOTVDSUFHOFR2Qm9UZGdsYWFOZTNTZDMxVDUvRWt6Smor?=
 =?utf-8?B?dmpTT29hcFJyS3JlNC9vQjdmQ3FVZ0poNng3R1NOY0swVC9vVis1ZGx5Uk1s?=
 =?utf-8?B?Qk5ndTlrZ2xZSmNOUHdNdUxidlNJbUR1QkNuUFluTWU2UVNpaWl5dlQwbUlU?=
 =?utf-8?B?ZmNua2g1RzFwNW52UXM1ZWhCa21xVENiT015dE9Qd2ZlQUFHN2dsY0JxVzI1?=
 =?utf-8?B?b3prek5SK0ZYQ0JMUE5aanBYdE90SERqVXUwMWZERG8yUFJUc1lISExOYkxN?=
 =?utf-8?B?T0JjZytubzc4ZXlmU08xQndwMVFrM0xhWXk0TlMzT3lleDhXdXhMdHN0VERP?=
 =?utf-8?B?a0pUdk5VendHQzFZY1pweHZhRkZXMTg4MGU3VzJPRENUWDhacWVQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090c70db-a658-4726-d2bf-08df1f2a22ae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:36:34.3252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbnaN0N1oQ+88hx4RbiFjnVE0t57BmQ9XYPDHI1ReZNtltxd1upP9Er8UlnLpPz8K0v1AL+Wx0h54l8UAwyyoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
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

On 2026-08-11 12:45, Melissa Wen wrote:
> If userspace set blnd colorop to bypass, AMD driver just skips blnd
> transfer function configuration. Currently, this is not an issue since
> dc plane state is a reset/default state, but it's not fully correct and
> doesn't mirror shaper tf helper. Make bypass mode setup clear by
> initially set tf->type as BYPASS and let the helper change its type
> according to userspace requests.
> 
> Acked-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index ca9e43e81edf..ad67106c6435 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1837,6 +1837,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
>   	uint32_t blend_size = 0;
>   	int i = 0;
>   
> +	tf->type = TF_TYPE_BYPASS;
>   	dc_plane_state->cm.flags.bits.blend_enable = 0;
>   
>   	/* 1D Curve - BLND TF: find state */

