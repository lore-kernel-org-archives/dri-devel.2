Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C354DC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 22:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090FE10F405;
	Thu, 16 Jul 2026 22:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UNZppCtm";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B38010F3E6;
 Thu, 16 Jul 2026 22:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6rLj35LZOpsCUWa78bkeT/uPXFjStRNj/0/XnhfZf+xEkscnHmfZLX8jl6Ef2c1E+xJHuv1P+10/iRiV1Fr8VpNI518siDYZb4XZvdvrTX0Qfp9DVI5bXiOtQUBIa11TDGQDIklZNy2k48M0K63MzAtFb5wU6LQ/GlBuFBWjOBZ7J03DN8DFc4i2+5C3khhOkiPaUwc2scZTI+V2v7UvEqi/UFrCmnqBF07z/mKzrzXuHMW9EVn0w+jKNgkMAGIj/cLH9QuP9pko4Fj6Ah0TddSNFPGyJYXc5mlRDSKJfnCh1J6eu7GkWre7mMhZtTJc8J8/kbi20Mkmwqj9zFVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCnAbahFfvjpFVa7b9JWPaW1f6kEJL9D75GUQCNRJn4=;
 b=sGrqLLGfFvLGdAFDKEeqsQIGb92Yt7/5lLhlYs3jztY5bcMgdptdVqippGvrgF4LmERFNrrg1esjDH7ExVIfniGE9PxMb3fKIK6AKV14Y9KspcAQPgHed4m/kR2PqG+2DCJad4TsKcQISF5SobGXqOgPZuoP9ydTaViiaybeFFLqjD5pkxaGMwlFKCsXyghDh2cMZmrpmcI4N2JV3KEhBtX6co/NJmk/meQPaIke5xlMRF6XVL62TPmfZFQE2NlPVvyIiuvkSv5bI4EV0JOzt8jKxiHJuQ1OochAZCB74HQRfW4OG6k9JN/Cx3Sj1SCKFBYduTmJiMk0GgQR1myk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCnAbahFfvjpFVa7b9JWPaW1f6kEJL9D75GUQCNRJn4=;
 b=UNZppCtmtcxO7b7IASDpPkZz3vYNgBUJid+jVU7cljW3DUR0vTXy/6lX8gj4HclTmD24SFYfspyVQB6AjX31+mlT83fX1YXCVyttS2szZ/pU2yh15j80YSpQThVnE+/n6RVI4Bji365dMcnA26lJIAyGhXJ/c6nFcm98Ny5DOdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 22:01:17 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 22:01:15 +0000
Message-ID: <191d1caa-6fa4-4577-b193-47f4f08d19a9@amd.com>
Date: Thu, 16 Jul 2026 16:01:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] drm: writeback: Modify prepare_writeback_job helper
To: Suraj Kandpal <suraj.kandpal@intel.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: uma.shankar@intel.com, arun.r.murthy@intel.com, abhinav.kumar@linux.dev,
 tzimmermann@suse.de, sean@poorly.ru, marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com,
 kernel-dev@igalia.com, John.Harrison@Igalia.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260714042805.77934-1-suraj.kandpal@intel.com>
 <20260714042805.77934-7-suraj.kandpal@intel.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260714042805.77934-7-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 73198134-93ac-4745-3ec7-08dee385c193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: C1RT833pWjq7XV2W5Y+C/5XmnKpTr+Q9RvBhpEyxD9JO01EuC9Jy1y22eQir0umqfkXIjBFaw86or1UcXAP+wBPPYjorNLuJBUrLWLgSrQ+LG/gH/Qs9RnjEVVjjUV8tX28ne2IE4Iv+k2iFi1IAuxNTNiNXca5e0RrDFpppI7mQ9hRZk7Ev7B4+kjxGIrZeKunvIB716XKk2NlYhQeq2ctGcKH0SvfY2SU6G9mh4riHzjgMD311lyg1hfk5pJ9P2eNS3MUScXJfuArMQkvKJRUoURYfDIAErlcur6w5R7FSzM5fkGqoOsu/I/MeuWh2xDtuFDwdtIRjSNa/m3GLipFy/T6ButOLHte7UADaaZJsmJlaW0EdqA1Defmx0J3w8A9giGbxHAQe6nVa4icHUEU5mTbQTo8IO6RrTT+Y/vcOrN5w4b42N3kkeb2mpQy/1qFQYRcJGxHYTPx2pTAqvbkZCUCEkQZiiNMcA/Qk4Isk5I4zEwgtqN2CYQdbmTcZXya1CJ09JnZMmgVjmvHCfpJHMJLWfJGS1xwpPSVw4ir59f+gDKu2yLSgiy1Zp3unaen33MiM7NQbnwrKl1SGn1ZcSJYQsYCzIgTAFC09CmUxNiIYMkdgZ9HKDTsWmI4DUqaYLwH8U9CCtp1T8VhlVSc8jYiJBTC3/66jRWW6Mc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0IxSmY1K1hUc1FhU0grNzJUWWxqUy9NbHhpazlyTko4OFJvNlRUZmljb1FW?=
 =?utf-8?B?bTBnd2VxZWNISlNTRjRBMFgyOGozcURHOVdaMTl6L2dIcXZUUWZxWkVlY0o4?=
 =?utf-8?B?ZmlDWlAxUStJQXlGckk4Y2s0WEw2aGdoeURlaUdkVGw0dm5HbDM0VXRUWXp6?=
 =?utf-8?B?azAyeXlsRU5SVncxRXIrNjlOR0ZrNmFSM0J3aFFieGNzUkdvRGE5cStYOVpN?=
 =?utf-8?B?dE5sYWpDNlBOU2wyNENmY1ptOFAwQ0g1ejdGWXQrRWIzY1dzTUd6MGJRZ25F?=
 =?utf-8?B?NHp2MDBuMmpGNmcrR0tReGdIWmpCWFYrZ2pkMXgrUFRjTW1nZmc1Vjc0SnZw?=
 =?utf-8?B?VUJHemx2Y0hGajhDZXhoYjlHNWEwbkNscUZvVHY4dHJleXFRVU83YUVuZnp3?=
 =?utf-8?B?MEZmYUt4YzA2b3QzSWRKZU5mand3UzZxbG9KR3NqQlM2djJCdmZwRkR4L1Ja?=
 =?utf-8?B?L0l6RjRKQ041bVN3V2xETFQ0STgyRDBIWXMxb010MjEzLytFUDVzbGlTVG03?=
 =?utf-8?B?QVhGWDNtazNORlNRVHVsQ0k0Uy9aUFc5bDNKbVFiM1pFM2R0VXQ1eWlFT1ZB?=
 =?utf-8?B?ZmZPZFc1K05xRGtQbVRGWDdnUDFLZHlHTXJJdHhxaS82V21NZGNGNmhDeWV1?=
 =?utf-8?B?dlI3andNL3hOQTcrOHFNZlNxTElrYVBremh1ZnV5R1ZwN25YNHo3VnA2L05E?=
 =?utf-8?B?MnBucDl4UjFhaVhDcFNCRldUTmFGK2UyakJnbDQxcUZyVlVkMEVpdGIvcFJF?=
 =?utf-8?B?VEhHb09TZnAvUlFUSHNHMjdNK3YycmJZRkhrRFhselkyaEVvSHhKVnBLbUNy?=
 =?utf-8?B?TTlIVzRRQWRNVGttUkprNTZ1QU8rUGhHUmdDVklXeVVWVkpkbC82cGZYRnRa?=
 =?utf-8?B?NEhWMkVtcFM5QTZvUUpVdGtVaTVDY2MrS3hESDNEdTZoZTVmTkhGZ2cxaGpE?=
 =?utf-8?B?Q2pKajIyVWc5RUtCU1FodUQxbi8raFhUVmR3R2plZTlqVGJqY3JHM2ppZVVU?=
 =?utf-8?B?Q2dWemxqdk1sbHBBVUNtSnZWRTBZKzF4RTlxaWczTW1PaDMyUzJrNGhaQ1pr?=
 =?utf-8?B?WTlmT2pHOVVBZWYrS013T1pDRGE0a1dMSUNmdWZ4c2tBa1FvRVEydVkvcXNH?=
 =?utf-8?B?TUk3c3h5bmZzcmROWm9tQXZ0eEJkMXovaEEvS0RQQXZnUW1pMjFKbk9EaFlr?=
 =?utf-8?B?RGZVNGkrZ0NDK1diTGdsc0xUVklBZlR2VTByRk1WSm5Sb1hwS01UZVI4SEdX?=
 =?utf-8?B?S1BPb2plR0VpSUhOYUh2UENPTHkwb3RVeEhpSDc5dzlyUG1ialdjajI3ejNG?=
 =?utf-8?B?bjErc0x1Y2FMdk1scG5xM3ZHV2lQb3drU1ZhY0F5emdEdTV1a0J3UUg0cWNQ?=
 =?utf-8?B?VWxSbEpOTXhQUUdkV3NPTzk0UWkxdlc3NENZdkRRellNL0tKZy9NcUlMMG1U?=
 =?utf-8?B?NExNc2JDclArU3JlWC81TmFvbmhyaVdUdU05blZ6aXY0V0lzcEpjMk81T3Ir?=
 =?utf-8?B?b1BXZ0dsVWl3clBueU55ME9wcDhOQjRQM0RTL2Z0djBXZFpWbWpTYXJSeXNk?=
 =?utf-8?B?a0lleWs2dzhsWHpvVXcrenpzNGdFOGI3S3ZDUEU4dFhLQUJuYUxseEw4VlVz?=
 =?utf-8?B?VFVwUkt3TFR2ai9haE1GMGxqNnRob095dWZRT0Z6M1pOWWpKa05pV0EyVEFn?=
 =?utf-8?B?bkp5VG4rZ1QrOHhGanYvNEVnMFVkZmczNUhnZ0VBOVljR0k5OFRzaE5ZUWE5?=
 =?utf-8?B?a3YvQmtSM1RFUUs2d0lhVndhOGN0YzB1WkxIL3pYV1pCVi9OUXkwRE5wTTBl?=
 =?utf-8?B?RmlBck4yZ1IxeEs1Zm53RzFkZStRU0tOd0NGZ3NkUlVsR3p1bTZUR2NpRVNv?=
 =?utf-8?B?VlBWMGxlTzl2NVlmVUpONFFFQ0tCYVFZOWM4aEN6Ui9iM3dSYTF0WERtRWEr?=
 =?utf-8?B?NiswTnZUYm1FbGhmdzVnaHVjRmgvT1JCdGdqNWhJdzY5UzV0a3Y4T0htN0Yx?=
 =?utf-8?B?Tjg5SDRNM1JLcFd1TGtQcGF5RTRTQ01QT0VEVmRUVXAxWVhFUDM2TXdXcVlu?=
 =?utf-8?B?Nk12NHREZVRaZGtaU3ZDSzVKQmQ2WktPdGdET1MyQWZtNEZKSXRiTERIdG1z?=
 =?utf-8?B?QzBReDIybzV1YUFqWnRZTzc4cmt2ODdGZEhGVlY2UVN3N0xGRlpYRDBtWHhQ?=
 =?utf-8?B?M3RscldGNzROMndORVlaUUFaS1pBT0xxTTRhT2NjUHJmdCtSaXhxekZGUGQr?=
 =?utf-8?B?V0VGQUtiZm1NdVdrM2hxdWx2UGxma0x4RUwySERjTWt3STFUVENDTU9vVTRB?=
 =?utf-8?Q?VK6y8NyXroMIziWJEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73198134-93ac-4745-3ec7-08dee385c193
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:01:15.3194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DAKnHsd1MG8V+VVNZoeBUpll+7Gnh/89c0e5T5qnIc8ZOxsDuDIYEWDK+sgMPkUa+KQQ/hKnLeLRHP06wMbQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
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

On 7/13/26 22:28, Suraj Kandpal wrote:
> The prepare_writeback_job() connector helper hook needs access to
> the parent drm_connector object as well as the drm_writeback_connector
> object itself. So, pass in the top level drm_connector and traverse
> down to drm_writeback_connector rather than passing in the lower
> level object and traversing back up. This also makes it uniform
> with the params passed to other drm_connector_helper_funcs hooks.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: John Harrison <John.Harrison@Igalia.com>
> ---
> v5 -> v6:
> - Rebase over latest kernel
> 
> v3 -> v4:
> - Update subject line for consitency (John)
> - Update commit message across commits for consitency (John)
> 
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 2 +-
>   drivers/gpu/drm/drm_writeback.c                      | 2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c        | 3 +--
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c  | 5 ++---
>   drivers/gpu/drm/vkms/vkms_writeback.c                | 2 +-
>   include/drm/drm_modeset_helper_vtables.h             | 2 +-
>   6 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 92039d93f9e4..e0425eda0bb6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -85,7 +85,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *conn
>   }
>   EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_get_modes);
>   
> -static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
> +static int amdgpu_dm_wb_prepare_job(struct drm_connector *connector,
>   			       struct drm_writeback_job *job)
>   {
>   	struct amdgpu_framebuffer *afb;
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index d2ccb4dcba0a..e6b52de69ad6 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -396,7 +396,7 @@ int drm_writeback_prepare_job(struct drm_writeback_job *job)
>   	int ret;
>   
>   	if (funcs->prepare_writeback_job) {
> -		ret = funcs->prepare_writeback_job(wb_connector, job);
> +		ret = funcs->prepare_writeback_job(connector, job);
>   		if (ret < 0)
>   			return ret;
>   	}
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index c9f53490c1a7..061e6960c09b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -87,10 +87,9 @@ static const struct drm_connector_funcs dpu_wb_conn_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
> -static int dpu_wb_conn_prepare_job(struct drm_writeback_connector *wb_conn,
> +static int dpu_wb_conn_prepare_job(struct drm_connector *connector,
>   		struct drm_writeback_job *job)
>   {
> -	struct drm_connector *connector = drm_writeback_to_connector(wb_conn);
>   	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
>   
>   	if (!job->fb)
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 4b0f6cd46acb..218b6504cacf 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -47,11 +47,10 @@ static int rcar_du_wb_conn_get_modes(struct drm_connector *connector)
>   				    dev->mode_config.max_height);
>   }
>   
> -static int rcar_du_wb_prepare_job(struct drm_writeback_connector *connector,
> +static int rcar_du_wb_prepare_job(struct drm_connector *connector,
>   				  struct drm_writeback_job *job)
>   {
> -	struct drm_connector *conn = drm_writeback_to_connector(connector);
> -	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(conn);
> +	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(connector);
>   	struct rcar_du_wb_job *rjob;
>   	int ret;
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 2e3df9388dd2..86e5b92c7965 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -72,7 +72,7 @@ static int vkms_wb_connector_get_modes(struct drm_connector *connector)
>   				    dev->mode_config.max_height);
>   }
>   
> -static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
> +static int vkms_wb_prepare_job(struct drm_connector *connector,
>   			       struct drm_writeback_job *job)
>   {
>   	struct vkms_writeback_job *vkmsjob;
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index ca6268945c28..4e26568a16fb 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -1119,7 +1119,7 @@ struct drm_connector_helper_funcs {
>   	 *
>   	 * This callback is used by the atomic modeset helpers.
>   	 */
> -	int (*prepare_writeback_job)(struct drm_writeback_connector *connector,
> +	int (*prepare_writeback_job)(struct drm_connector *connector,
>   				     struct drm_writeback_job *job);
>   	/**
>   	 * @cleanup_writeback_job:

