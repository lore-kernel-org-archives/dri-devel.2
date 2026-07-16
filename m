Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99C7C44519
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9B710F3EE;
	Thu, 16 Jul 2026 21:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZUcgvjGs";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A728510E1D4;
 Thu, 16 Jul 2026 21:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAQVQDTD1DS4c6SrEf6AxjvC9JAXfEUxzE8UEEBuryqvaoLaiEAdRuP2keO/k8dSJjlFGszKP4+csdrtezidMD0KNUGLWdCo2+RzWVsvEClW/9zXUSv50WA31uCy18uF8LVzyjCpeyAQjzJc54UvgbqyiSqitIye6BI7oxjWKpLgziY3bjnINIdXkbnmelBIS4uVxnDWorfMHRWxLFFSNeqGXxewSqa6z46YwwSmuJPDAfCKOC8WrWB8C1ROoR2gK0xUw3T8MAI4qlTqaR/BTBczO36k4djkUcdY4HPuI6sD0ByaYZyS3Y0+WZkm8ECtWfpm7PwdioQVfJmXTJb+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXXp6pgqaCAiPP4OxBaxdQ9e9EhLM7bbXJ4Levqg6wU=;
 b=Pipmh35qTgi2T5d2nI0L5KnAnn86UUK1TSimJKrQFxIsr6NJVoYhS88Th10ksWDkWgSRlpp6jO8BvKTBhZM8/mKd1vuAUVzLV4mJOB6S3c8sa+ATM4orIPYgb8m5DoNz5f9qv2ynvkS1+8SQcFeGaXpS3BxPnZNLzrLYndGfmRqe12PnA+64sSe504e+XhsSaQydwEdQquMtpWfg0MXWV26SPNwMiqx5JwqSivmUhGRDEHAV+TwWRJ4FCQeQwvngegyPsWZA11ZIvIuLFrUUx/3FB2qTLMdCWuAE5TMebYcC+LOLSDXPlCkMlZaPvolE64vgHvNuLUzFeu10WEqN/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXXp6pgqaCAiPP4OxBaxdQ9e9EhLM7bbXJ4Levqg6wU=;
 b=ZUcgvjGsTAMSLc347Ko002YRA9IshuOsvl4PJDxAHRJsDcFz+tlwxWJ1Hc9sAo8OeSQPe6n4aPVhBbB9i8kZLKJzNOeoB78+PYjpqdaiNuNMxwaxhJ0nMskAudhtdR72+dI//8UG5lxz13DBjk88qMSJOe4SYLeMGse7swLE2PA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:17:05 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 21:17:04 +0000
Message-ID: <a8a47514-0847-42c8-8435-ce714c86a7cf@amd.com>
Date: Thu, 16 Jul 2026 15:17:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] drm: writeback: Modify
 drm_writeback_signal_completion helper
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
 <20260714042805.77934-5-suraj.kandpal@intel.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260714042805.77934-5-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MW5PR12MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 811482fa-e270-482b-0ef7-08dee37f95cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: or5g3Y1DlIrDcdc8WT8uSaFMWdx/zrU7MfcqDOSNd0ZHczMa+lQsy0xlpvTFJWt44h2/ovu36UyAFHFzT69OHvp6kv9nvz+Uzdl/HUdhTsLHMa3lHTLQR7llfGrWiAxs7lUnMCry9Hc4Wx/cQOaXv8MIjJRB8P7EHNsZ5FwLQmgxfu+nl51jHikcJAnrO6wjc4N99ZUf6GLoCqq/p6TAvOOx/fN8RSE4Qq/u/LWI1XarVYnckruFle8iv6VhQDL4JxraQbXM9p/w29f/2QsP63iORstZ+ZYwcBDWNLhuRoRuH87BoLzlrag3D7u8/vNfy2o3GlT8U2GewShUUYzyvLGevi4OqvRaxH68myy4LZ+oePhBmMVF6UqvPo0uvEXgFY/8wZwSsgWoME0R5n2QCI/fglqIoCOM16xWeYfTJTNIjq6P4JGOF81za+dXd6ZkUUR4YWsBPlE7Q+o0Bsq8qMMxDiO6PRTyhWN796G4HxnvyowtaajlhgD5H1FtHR/WjvnqAd73Wok8rKzWrA+xA92ISNYT30vIWSsz4461JGqWVGqu2kJa+lPhmK1v7425eA4QIbh8a7nbveUU33M0qNyU8XojXxBYexoG1pDVoAzIclQ1AsyRNc+JLrg0cFMdCkskg+ZS6H9zv34E8j+f1JsquLBc6LNcp79CNK67mk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRoTkpmYnNyRlJsMWRSdWtydk9aVHA4ckpid0p0S2dtcXJFbFlJTm14dUFx?=
 =?utf-8?B?a0RQa1pBMTMxTnYybHNDa1A5OXA1Rm1oTHZ4czlkSVN0ZU5kMGRCL0hLcXl0?=
 =?utf-8?B?WjNLQjhtMDl2YUZwRzUrdVR4bzhycTFoUjNwcUtyckY5UU45S1FMaExJZVhj?=
 =?utf-8?B?cnFWc1J4djgyNDM2TDFDNnRxMjBPeCtZTmRnS3RKR09uN0hYYUZmMDVTaFpl?=
 =?utf-8?B?RUFkcUtxOGF4emdNSDdSMGgxekFza0hrM3J2U0lLTlNydlFqYmd4RFFqS0Zy?=
 =?utf-8?B?QkZRQjZ2VFNHWDhPWTVUeUJZc2UxSWFGTVBjOEx6OXpVa0xKeGVLdmh6SDZQ?=
 =?utf-8?B?NEhpa1lIdDdyQ0dmakJvdGkybUdONGpaaGxTUEVEQ1ZGeDB1eVI0eGxyQlFo?=
 =?utf-8?B?YUlHQkVNVWM1SXpMN1QyZ1BNczVOcW9FdEtSemZQclp3QllRSGZFdnVBL3VY?=
 =?utf-8?B?WE4vMUM1T1k1WDF6RjRqOVpKc0lpb1hPc0hJeGhIVGR1V2FoMU1xdlo2bEVN?=
 =?utf-8?B?S0EyTkt5NFFPVDNCY2IrWTVKMytZN1pOU09aTExHSGw1d25PU0xXVFZMcUNo?=
 =?utf-8?B?Z21mdWEvUm9DdFFlcFhoZys1cjkvY2Jaa29PTEFjcUsxd3NEcFVwS0hIYzNp?=
 =?utf-8?B?dHNLSEtjWi9lZXM0S3hNV0NWYmlNczBWM09yRDE0cXZlVzREWm1HZXQ3WE91?=
 =?utf-8?B?T29TM0tMMjhiU1ErY1BiRmJ2V1hTS0l1KzlCRkgwOUZNcGE5SVJ6NEFVcFJ2?=
 =?utf-8?B?YlluOWRsRlgxeUZucDZmaUJySDdoRDY0VHR3ZEYrY2twYWxBV292VVZuTGhV?=
 =?utf-8?B?aHJWWEdXcVRabVRRaFNURWUrMzIxVjVkakZ2QkxHTDVEcnNPZU5hb2FQYVBM?=
 =?utf-8?B?MWo4dWl2YVRUYk1vSytoVW40WmFObHBHZXJPU1M5VGhDd2p1Sm9vdUZHVi9Y?=
 =?utf-8?B?MWJ6MExxR3hKQnJXdy9iL0tVVzBEZURpUk1xVWlKNnhaeVhJbjZ3dStJRjhE?=
 =?utf-8?B?L3pTL3RUdlJ3b3M4MzBqblVZWi9QYytlWUJhNUlMeEpnMk5KMndrY3lSclJ1?=
 =?utf-8?B?MmtKRGJYckdXOE82RHp0cHdUdGVoL0czQWJOTVFEU2xWQmtuYUs3TjZFSW1L?=
 =?utf-8?B?T04vSy9yWTNxRmFLc3NLVWpTZG5kb2FhSm5CMHpMcTFnc2tyVmhkS0JYd2tT?=
 =?utf-8?B?NHRueWRCUUtXNHlSZ2wvUHZxK0VTaUxxaGd4alVBUEptUk1yQitxK0ZwdlVH?=
 =?utf-8?B?ZVZ6dzRBaVFoOHAwbXJJK1BZOE9Nd1d3WHFKalJCb2F2V2s4cVA5UVdpaFBO?=
 =?utf-8?B?MVBlZEQwODhjMHVQRHFBS2ZOYnRTUm5tYXd1bjV4OWs5bnFRY2psd3BLcDY0?=
 =?utf-8?B?aG4xOGxQY1d4NGVDQTZoODFhTzA0TE1qaVhLRnFXL1paRzBuYTRhdFBsbGFJ?=
 =?utf-8?B?UW1RZExYa1JzZy95Z3lEd1pac3pvbDgxSVhteEpINCtiZU9zYTFVdWt3VnQy?=
 =?utf-8?B?RURDMkZCazdsOW1EajQrOGFDdHJmSjR3OXFpNmk2RVZsalY3ZE1hNWNqWDhm?=
 =?utf-8?B?dzlmWUZDYnRraUdmcW4vNXNMUTV3L2hqL2haTWRmTEtsbm0xQXAwTnFzT2o3?=
 =?utf-8?B?dTNmUUtVZzZEMGl2ZnlrNHZvQkt5K3pTM0d6VnUyYjhJYmJZVUwzd2RjTzJn?=
 =?utf-8?B?VnhxcWQ2VTdMNUVEQ1VaenB2Kzh0eE9BeFd3Z1Fwci9uTmhuQXNOVmdkejFJ?=
 =?utf-8?B?Q0k3M2tYRGJZeUtGUlIwNDNrbzJ4dnR3SUZMSnBJdDFNS0JDeUpJVklkNWlw?=
 =?utf-8?B?VGh0T1BPbDdlSDJkc0dyUCtCRmoxd0hnaWVYM1RVei9JSTB5L0NhNi9TZ092?=
 =?utf-8?B?Um82akJnbkZxK3dsT1RnMHFYQVN0STJ4VmMzZ29BMm9ZaGtKS0NFbEJCd0hw?=
 =?utf-8?B?RVluWUtZaCtLT0tYWTdOeWNmYzFvaE9CMnNTdlpYa05pSXU5ZkhFQkN0Z2Fz?=
 =?utf-8?B?c0FSa1NCNkVtOVBQeTgzU2ZqbGNQNE94ajBpOTlFandnbm5nZkRQRlBMVnlH?=
 =?utf-8?B?cklBdlE5YzZzVVZpWnFqZkpSeVdxdUxXWGtGL051aUtGUUZpdkg3MFJDZStk?=
 =?utf-8?B?T0tSZmdhazh4RWFOYTUyamhNNzJudWZRTG4rTTFRY1A4cWJMdWVlcFRHcURl?=
 =?utf-8?B?ZDlmTGtRRjFzT1JyRGZnNnNzdFdLNGlPYU85RzBDNmFUNFc0K0g5Wkc5b0F4?=
 =?utf-8?B?M1o1YXpWL0trcGdabHp1K01kQ2oweWhhYzREaUlWZis1ZmxnMGJqNFo0OFJZ?=
 =?utf-8?Q?Z4dGcyHjKqWRBcUobV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811482fa-e270-482b-0ef7-08dee37f95cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:17:04.8559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZejeMwy5bfE5W6XZ31xJ5atXMP8iFehXAw4ijMxUIakvemZJP5g3sx2LfDmKaHLxvQhUQJS0U+vtPrH4tIp+tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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
> drm_writeback_signal_completion() needs access to the parent
> drm_connector object as well as the drm_writeback_connector object
> itself. So, pass in the top level drm_connector and traverse down
> to drm_writeback_connector rather than passing in the lower level
> object and traversing back up. Update to use the top level object
> for consistency across the writeback interface.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: John Harrison <John.Harrison@Igalia.com>
> ---
> v5 -> v6:
> - Rebase over latest kernel
> 
> v4 -> v5:
> - Make @connector kerneldoc wording consistent across the series (John)
> 
> v3 -> v4:
> - Update subject line for consitency (John)
> - Update commit message across commits for consitency (John)
> 
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 2 +-
>   drivers/gpu/drm/arm/display/komeda/komeda_crtc.c    | 2 +-
>   drivers/gpu/drm/arm/malidp_hw.c                     | 6 +++---
>   drivers/gpu/drm/drm_writeback.c                     | 6 ++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 4 ++--
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 2 +-
>   drivers/gpu/drm/vc4/vc4_txp.c                       | 2 +-
>   drivers/gpu/drm/vkms/vkms_composer.c                | 2 +-
>   include/drm/drm_writeback.h                         | 2 +-
>   9 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9504f6b5571e..6c507eeeda84 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4529,7 +4529,7 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
>   	if (!pending)
>   		return false;
>   
> -	drm_writeback_signal_completion(acrtc->wb_conn, 0);
> +	drm_writeback_signal_completion(acrtc->connector, 0);
The change broke IGT's kms_writeback (null pointer deferences).

It can be fixed by "drm_writeback_to_connector", i.e., 
drm_writeback_signal_completion(drm_writeback_to_connector(acrtc->wb_conn), 
0);

>   	drm_crtc_vblank_put(&acrtc->base);
>   
>   	return true;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index c64cf5d97e62..da6bfe2797aa 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -213,7 +213,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>   		struct komeda_wb_connector *wb_conn = kcrtc->wb_conn;
>   
>   		if (wb_conn)
> -			drm_writeback_signal_completion(&wb_conn->base.writeback, 0);
> +			drm_writeback_signal_completion(&wb_conn->base, 0);
>   		else
>   			drm_warn(drm, "CRTC[%d]: EOW happen but no wb_connector.\n",
>   				 drm_crtc_index(&kcrtc->base));
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 5a7bd27d3718..9b845d3f34e1 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -1315,15 +1315,15 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
>   	if (status & se->vsync_irq) {
>   		switch (hwdev->mw_state) {
>   		case MW_ONESHOT:
> -			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
> +			drm_writeback_signal_completion(&malidp->mw_connector, 0);
>   			break;
>   		case MW_STOP:
> -			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
> +			drm_writeback_signal_completion(&malidp->mw_connector, 0);
>   			/* disable writeback after stop */
>   			hwdev->mw_state = MW_NOT_ENABLED;
>   			break;
>   		case MW_RESTART:
> -			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
> +			drm_writeback_signal_completion(&malidp->mw_connector, 0);
>   			fallthrough;	/* to a new start */
>   		case MW_START:
>   			/* writeback started, need to emulate one-shot mode */
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index e999eca5b649..df8484a7aa03 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -480,7 +480,8 @@ static void cleanup_work(struct work_struct *work)
>   
>   /**
>    * drm_writeback_signal_completion - Signal the completion of a writeback job
> - * @wb_connector: The writeback connector whose job is complete
> + * @connector: DRM connector which contains the writeback connector whose
> + * job is complete
>    * @status: Status code to set in the writeback out_fence (0 for success)
>    *
>    * Drivers should call this to signal the completion of a previously queued
> @@ -495,10 +496,11 @@ static void cleanup_work(struct work_struct *work)
>    * See also: drm_writeback_queue_job()
>    */
>   void
> -drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector,
> +drm_writeback_signal_completion(struct drm_connector *connector,
>   				int status)
>   {
>   	unsigned long flags;
> +	struct drm_writeback_connector *wb_connector = &connector->writeback;
>   	struct drm_writeback_job *job;
>   	struct dma_fence *out_fence;
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index 0a4026f22274..977fc0337fbd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -370,7 +370,7 @@ static void dpu_encoder_phys_wb_done_irq(void *arg)
>   	spin_unlock_irqrestore(phys_enc->enc_spinlock, lock_flags);
>   
>   	if (wb_enc->wb_conn)
> -		drm_writeback_signal_completion(wb_enc->wb_conn, 0);
> +		drm_writeback_signal_completion(drm_writeback_to_connector(wb_enc->wb_conn), 0);
>   
>   	/* Signal any waiting atomic commit thread */
>   	wake_up_all(&phys_enc->pending_kickoff_wq);
> @@ -431,7 +431,7 @@ static void _dpu_encoder_phys_wb_handle_wbdone_timeout(
>   	phys_enc->enable_state = DPU_ENC_ERR_NEEDS_HW_RESET;
>   
>   	if (wb_enc->wb_conn)
> -		drm_writeback_signal_completion(wb_enc->wb_conn, 0);
> +		drm_writeback_signal_completion(drm_writeback_to_connector(wb_enc->wb_conn), 0);
>   
>   	dpu_encoder_frame_done_callback(phys_enc->parent, phys_enc, frame_event);
>   }
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 5cd6c81a9710..4b0f6cd46acb 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -251,5 +251,5 @@ void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
>   
>   void rcar_du_writeback_complete(struct rcar_du_crtc *rcrtc)
>   {
> -	drm_writeback_signal_completion(&rcrtc->wb_connector.writeback, 0);
> +	drm_writeback_signal_completion(&rcrtc->wb_connector, 0);
>   }
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index 9cf2ec99bdfb..4c756702b57e 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -504,7 +504,7 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
>   	 */
>   	TXP_WRITE(TXP_DST_CTRL, TXP_READ(TXP_DST_CTRL) & ~TXP_EI);
>   	vc4_crtc_handle_vblank(vc4_crtc);
> -	drm_writeback_signal_completion(&txp->connector.writeback, 0);
> +	drm_writeback_signal_completion(&txp->connector, 0);
>   
>   	return IRQ_HANDLED;
>   }
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 27fb6a7b55bb..83d217085ad0 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -652,7 +652,7 @@ void vkms_composer_worker(struct work_struct *work)
>   		return;
>   
>   	if (wb_pending) {
> -		drm_writeback_signal_completion(&out->wb_connector.writeback, 0);
> +		drm_writeback_signal_completion(&out->wb_connector, 0);
>   		spin_lock_irq(&out->composer_lock);
>   		crtc_state->wb_pending = false;
>   		spin_unlock_irq(&out->composer_lock);
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index b4c11d380df0..5e8ab51c2da4 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -100,7 +100,7 @@ void drm_writeback_queue_job(struct drm_connector *wb_connector,
>   void drm_writeback_cleanup_job(struct drm_writeback_job *job);
>   
>   void
> -drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector,
> +drm_writeback_signal_completion(struct drm_connector *connector,
>   				int status);
>   
>   struct dma_fence *

