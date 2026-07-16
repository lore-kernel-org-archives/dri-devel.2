Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A595FC44519
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 22:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF4D10F418;
	Thu, 16 Jul 2026 22:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kHOKLifw";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3054610F3E6;
 Thu, 16 Jul 2026 22:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEd+7xwJEdUYbghY2iIMMqdW++o1mVSlEnBWV0vHpqlRkiKSLgbmGHkccr4/zfAeErs/mUcNUC4Bmd5cUr1yBW8KV3ffbfnJfcdOUo8jmMi6lmTSt+ABGTgWCybE+TLuu7GVXwUT7jqoCE18064kKTsuRFegsDncZ9a9xXgE9G3/XAyn8wfAFer2+H0PrRnPHPbRuAbDJlOcLVB0cJIuvZrGJRLBxhD3VtwyLakBunApYKHIH02rPvQM3ifG+bWtf55Boi9R7/BOX7UcPmRT8IC6kdkXWPwCwJsLTJAWd5AehAZvLk6pFw+Q7iwryv4AuVwk0NAePnTZzfng3Rtkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Apphek63BsCQEBRdvHD4ja5GzcHx74cLNKEeMj2wp1A=;
 b=RS0XfknzQo77PqF9brd0j6N7/CnuJDxhiFQCDkpx/cPF+24oRW6sZTHww8iF9w8AmMBjH/AtEYTZbhJh8rfvlwYUqjoPwnsONLLpZy7Xoyea7RXDA6NDXNiPLq/nAGzJ2FWy4jcP8BD2frzD2QCUbUxoLbm9LADuwibO6aagYaZ9CRtDmBZmPXg5edbndJ/UO0JLtOPgGoDPnmb33j22asUK96gZ2MBzDZdwwoOM4hz4cbGCuPENL1AUqHXYEZEXaDdLpCafvKENeaNFa2A/fNLtdiezuQFu/CXGKOI8Qd/+7TKj7qZ/qF/dWZy0LDY39YqFpd/Cu7yGcBpKuopnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Apphek63BsCQEBRdvHD4ja5GzcHx74cLNKEeMj2wp1A=;
 b=kHOKLifwAyEmSd9aGSbXF04jrJXeZysqb2//tH7UGn8jJBQ2+viKFSXXWNuliDyHgtfWXrS6OzKtu9wcB6qIHAf+0uQIXKLZFESSQaLJyaufQLx7BGQBdPk3sAEgsvDtiBfn+t83pP9gVo/vebftXw9CiQpVr4/x9mEGWUlW+Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS5PPF5C0B6C3B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::64e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 22:02:11 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 22:02:11 +0000
Message-ID: <405388f8-8d99-4b04-bcd1-a8952101f5d8@amd.com>
Date: Thu, 16 Jul 2026 16:02:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] drm: writeback: Modify cleanup_writeback_job helper
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
 <20260714042805.77934-8-suraj.kandpal@intel.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260714042805.77934-8-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS5PPF5C0B6C3B6:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bc1e93-80dd-4999-4ff5-08dee385e30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|18002099003|22082099003|3023799007|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Ccaz1FND4BfhppTKL6h0L1lUfJN+XA3Ubv4iIUfmcUllUR4fy0Mv+TjUOMmJ9YUTsdiDNo/d9+akZA2ZHczZYJBJyIm19LeQdf0RE9ZgN27qQNZlPZGqhXvOp8o/BIGKXoAaBB3GUNw7MWDKUen1erST4maJJKVQ3baWSOGXeLC29okuOAnJHIBa6LymglHbswbbwesZl+PGfagSyNC6g92UKtsWPN4LbnyDTHsV+Urj7sEFQqbgqNezyGZi7LmChZvW51phYDaj8qchcDdilps8XzZxKNaJEexaC1WltgSatvF2Gv3upRHvrCbFidnienAzGxQDGuDEnlnN1pf3c0+v8j7kR7Ah4p4xp2oNY6B1fR/fQD6Mgb/VQTIajMU7RzQLmi7tDvXMBu/C+Dr4TsVAju++YKy9i5QAAckuRAIrio5waxoWhoR0pHEsanvTH9KfCNqD09Ma6NuemZwVmonOK84Brx53S/T81ToBMe4DM4+rF75OwiGgtclpLjwTQaRBYnXsNlU/CcKKyupjlkzHgqhbuo1VykxDvwlDnWY9ScyvwxxJmqIupdbyNCn7DG92GPj80YuHjNAZf/hHyAZ99Mfr3ms9UDfhcAVhLZxuVFrEtkcLV+dKtfjJh7pJZV0GcupPrK505pB38/NuPfrltBCZ/H5oDWn/NgExRqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlRaDU2TGZ4c1h1aHJES3p4SDhvcmpYdWk3VTBtQUxTODNRejJHU3NOSGlF?=
 =?utf-8?B?bFdOVi9wVjhmcXBrUGNKbUNFSExxZzlmMVdqcHdIVFN4emM4alNSY0ppT0Vl?=
 =?utf-8?B?akZXMkRQakh4Y3R5QXpNY2FwRDZueUF3cCtYMERWWUFEN2hYdDlmbzdha3Uw?=
 =?utf-8?B?YWxlOFhRVUVzUlRRZ0lKRGtSWnVSalc0TnZiN2w4eXoycHlRQitlVEh0T1cr?=
 =?utf-8?B?YjlqUzE4VXFodVRMV3FIc08yZm5jeFVnWGxlZ053cEpaOWtMbXhtaDR5WVQx?=
 =?utf-8?B?MUJKaERveEx0SHdwVThsK1hxTWwvalNDSVg0MThCWGtaNDJOdkRNOTcvRGZl?=
 =?utf-8?B?UGVkaUJLcWladnVIVmkxTjlNVDFXY21IdEVMSkZWejM0ZG9DZWxTanBUamZY?=
 =?utf-8?B?UisrNHNEb2lscFA4akRpNWV2SndXcWJ0a3gvVFdKSFBrVGYvTFFGQkRITmEx?=
 =?utf-8?B?ajhJZlNsUGo4Umh1YVRwZ3ZaN2g1Slo0VEZHazNmYTlNNEdUTmJ4K0txbEZ6?=
 =?utf-8?B?bUVLMHc0aGpETS92Y041WmVnWndNZkZIUXRQcWg5cXNzN3RwVUFTbHV2N3dV?=
 =?utf-8?B?L2UyQnBqQUxORkhCTlJUSEJHNU96OHFwdVBNVFJoYTJZdk1tWTdLNzgwbURW?=
 =?utf-8?B?a0FGR3lVME9Kekh5T2pSczdycURKUDlycWsxZ2hMb2Z5QlBMYkhIWmpJVE5a?=
 =?utf-8?B?VUNKYUpEazZkakNzWXhPWVNaZFptSVNzT3RXczFtTWRoeG4yUnBYSHhTL2l1?=
 =?utf-8?B?djRtVlZUTlhKMnNualI0WG5zNFNrOWt5VE1BckpVU1VSZXArdkxDdEhOY0RW?=
 =?utf-8?B?emZKZ0NzUlcrV3FKRVN6TzVJcHVoSjFPSEFIWnVWTzFSaU9CMmpIbk9kZjBm?=
 =?utf-8?B?ZzZ3NVBibHpxaXFFMDFOUkZnQUpOUUxDMFlwM05yYmpoZW1la01CWXY1VTZ0?=
 =?utf-8?B?eVAvWnNPc2YvR0xaZ0dIZGVTYksvaVJlcWJGbGxMOGMzUmlHdUlpM0xxMTN4?=
 =?utf-8?B?VXo4ekpWbmpyQ0orVkhtR2lWR2Y4WWZ3dlZGcFY5cTlQd1RmbTJlVFpIQURM?=
 =?utf-8?B?c0NXNTIySXI1OUZWdGtKLzIyWjJiN1p5UFNtVU5iaEc0N2NUVnpyaW8rNmNO?=
 =?utf-8?B?Y1hMQWNzUm5LUDRnc0NieE1TZHYxajMyQzRUVmNkWEFNdEtuMWdaS3FUYUZq?=
 =?utf-8?B?Um1IaE1SOHowVzF3L0ludEFjUmRscXgyeTBRZS92czB4SkxLZkFiTW5GZms2?=
 =?utf-8?B?SkpndzJNb2dJYmNHWnhSZTk3OE9LYUxjQkNCeTNpT25jZy9IdEg1VTE4VHRh?=
 =?utf-8?B?L3hEUWJqTnNHbUNCaXNyL0crUEJoWUNkZGxFcjlvdGpDSjM0TGVka1BxK2Q5?=
 =?utf-8?B?RUI1MXduZmI5NWpqOGZ6K3JkWmtpRVFrRldIODZ3OFRQMGZvTk9UbmJpMDhW?=
 =?utf-8?B?VEhXMHB1Z1F0anJTaWdGbzE1bDlrSzExdjV6ZHFQam5QRDZkdDRYbSt6VVEv?=
 =?utf-8?B?YXlxY085ak1FV1o4ckhZNktFS1dkbE9aeCsxcjRWNjlJTm9UWUlOcXZjUHJy?=
 =?utf-8?B?RFF2Wm9QcnkzRlprVVlJVjE5cmxXWUZGWVJwN0pERW5NdzZ3T3dsa1N6aUlE?=
 =?utf-8?B?d3ViWU1VWjVibmFUM0ZSbE10K0RNa21ZU3ZkM0U4Mld3KzZxU1pRckl5RnNv?=
 =?utf-8?B?V3Q0ZEJCZHhiTHlVZmVqWXQ3UU9IS2UwbzAwZnBFaVdUTmZQUzlSTVhHWXFV?=
 =?utf-8?B?YVNHdE44TGpwRkRTbnNULzh1QlI5SWk2d1E5YWdSSUJpMHh4QjlIMytvUks2?=
 =?utf-8?B?U3hXMUhxM09Jc1J4S2QzOVFBYm1SSFk0bmxZZ0RHTHlFMkRxUWJYRURhOGF6?=
 =?utf-8?B?T0RuVlh5Wm5jQmtNT0R6cW1wVyt0aGdtWFZjcnloNE4yR2huVURFV3ZldmU4?=
 =?utf-8?B?dmFObUgyQ25DZXJjNGN6U0JKeU8rbkhvVFZUOUZ0ZmZzUTl3YnJDZHgybnFh?=
 =?utf-8?B?ajU2T3RmYVU1V3lTZ0U2cjJUbGFDQ0xtdllJYnNSc1ViUWVIVWRqMUdwcUl2?=
 =?utf-8?B?MTdCNGlqaU5Qc24rclQvbFIzUlprVnFIeTYzNGZtdnFsVFEzNy9SeXdYamJ4?=
 =?utf-8?B?dmlmRER0TDlja0NjbTNtU3ZMVTA4cUh5S1dBRlF0M1ZUOTBndkdNTVEzQUZw?=
 =?utf-8?B?MUNsU29pcmhWNTEvREs2a2F3VFEzam8xY0JhejJmYzg0QmJoTFdsR2F6dHhY?=
 =?utf-8?B?MnlQZHF0R2tCV1VBUmZnR1lMd2pzSy9UREtSTld2TE1xSDNCOVAxSFJZazRp?=
 =?utf-8?Q?+iroxKtFHY10+6JLVM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bc1e93-80dd-4999-4ff5-08dee385e30b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:02:11.4255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Eo3ZZDHl6a1QIrTScdELrWsTkjoCoEDXXZJwf/SZlvpYWvDC4qd7NG78/7oFV+8q9LhJMNoANigTExAMTfPow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C0B6C3B6
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
> The cleanup_writeback_job() connector helper hook needs access to
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
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 4 ++--
>   drivers/gpu/drm/drm_writeback.c                      | 2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c        | 3 +--
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c  | 5 ++---
>   drivers/gpu/drm/vkms/vkms_writeback.c                | 5 +----
>   include/drm/drm_modeset_helper_vtables.h             | 2 +-
>   6 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index e0425eda0bb6..6fd1376fbc1a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -147,8 +147,8 @@ static int amdgpu_dm_wb_prepare_job(struct drm_connector *connector,
>   	return r;
>   }
>   
> -static void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
> -				struct drm_writeback_job *job)
> +static void amdgpu_dm_wb_cleanup_job(struct drm_connector *connector,
> +				     struct drm_writeback_job *job)
>   {
>   	struct amdgpu_bo *rbo;
>   	int r;
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index e6b52de69ad6..c8cc09118a6e 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -450,7 +450,7 @@ void drm_writeback_cleanup_job(struct drm_writeback_job *job)
>   		connector->helper_private;
>   
>   	if (job->prepared && funcs->cleanup_writeback_job)
> -		funcs->cleanup_writeback_job(wb_connector, job);
> +		funcs->cleanup_writeback_job(connector, job);
>   
>   	if (job->fb)
>   		drm_framebuffer_put(job->fb);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index 061e6960c09b..c6396ac1f64c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -100,10 +100,9 @@ static int dpu_wb_conn_prepare_job(struct drm_connector *connector,
>   	return 0;
>   }
>   
> -static void dpu_wb_conn_cleanup_job(struct drm_writeback_connector *wb_connector,
> +static void dpu_wb_conn_cleanup_job(struct drm_connector *connector,
>   		struct drm_writeback_job *job)
>   {
> -	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
>   	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
>   
>   	if (!job->fb)
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 218b6504cacf..e7d7b221c487 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -72,11 +72,10 @@ static int rcar_du_wb_prepare_job(struct drm_connector *connector,
>   	return 0;
>   }
>   
> -static void rcar_du_wb_cleanup_job(struct drm_writeback_connector *connector,
> +static void rcar_du_wb_cleanup_job(struct drm_connector *connector,
>   				   struct drm_writeback_job *job)
>   {
> -	struct drm_connector *conn = drm_writeback_to_connector(connector);
> -	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(conn);
> +	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(connector);
>   	struct rcar_du_wb_job *rjob = job->priv;
>   
>   	if (!job->fb)
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 86e5b92c7965..775abb4677ef 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -103,13 +103,10 @@ static int vkms_wb_prepare_job(struct drm_connector *connector,
>   	return ret;
>   }
>   
> -static void vkms_wb_cleanup_job(struct drm_writeback_connector *wb_conn,
> +static void vkms_wb_cleanup_job(struct drm_connector *connector,
>   				struct drm_writeback_job *job)
>   {
>   	struct vkms_writeback_job *vkmsjob = job->priv;
> -	struct drm_connector *connector = container_of(wb_conn,
> -						       struct drm_connector,
> -						       writeback);
>   	struct vkms_output *vkms_output = container_of(connector,
>   						       struct vkms_output,
>   						       wb_connector);
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index 4e26568a16fb..9ce5ddd82057 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -1134,7 +1134,7 @@ struct drm_connector_helper_funcs {
>   	 *
>   	 * This callback is used by the atomic modeset helpers.
>   	 */
> -	void (*cleanup_writeback_job)(struct drm_writeback_connector *connector,
> +	void (*cleanup_writeback_job)(struct drm_connector *connector,
>   				      struct drm_writeback_job *job);
>   
>   	/**

