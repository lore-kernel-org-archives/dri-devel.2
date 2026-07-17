Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330A1C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C01710F606;
	Fri, 17 Jul 2026 21:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XiZWtwnv";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B7110F5F3;
 Fri, 17 Jul 2026 21:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avPolLGwWTBnAKHtiLBEIZ9N03D2QyFOnw5mKB5g9SxVJ5TEmDdUTvSWNXdwCmfgPWFG8wjCOiqOYKyzZ1SLo4KqTB9PbrUtlmmD5WJ+r0hxjJ/hEpvl+BGLONhzAEPF/69R+2lcbQp3n/TqPT1cy1s41mwlhuxvNj/lfzD1eDq2wJEJUAK0cmC/vV1Tm+UvnhHbza9vFaVvAyrW384EOi/2zi0YDk2A4wfNFXihw0RyYXrdDviaRygb/HhuVt0YXog3XmDVgMlYL6uc/kPWPhuihzIkVd4qZZsTyMaSYH5xNimByKRiJhA/wQTEIepdXbmVOncIflHZjc0AwraIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GSToChSLjb57P+XvPGIKMLQrnfvM9f1Gn4m5sL3mwk=;
 b=yEkg33G5oHPAF/ZYviB3KUnsAq+NTkEH0gs27CpNeJgJmFdZQhA/s5w3x2CqY75u/TCOvJPBwRY4f47nw10Bf1Ap259c8jQcBdpqyHlxwGxGamf5zI8q2q+4sR3txUoq9ZDx60t3RPcYtsvxqtkrNTN1GjXouRTPMcES970Rs6Q2XoM1FpYE/xzjt+3IHRi567UQJFA6DaKXCr6qRojeLMqm08ochA/6fPS5LtZ+mBjaa1AI4ilwUe8oFw6X3CeMc45xBuPGq2nTwqv12HIlZiSRc2Ox8zRGtMHTBAoN+RcteD71dcbeD+BtJrlmLQO/7W/rv5GP4I5/zZlnxEAF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GSToChSLjb57P+XvPGIKMLQrnfvM9f1Gn4m5sL3mwk=;
 b=XiZWtwnvb3qWZbcYx/qFg/ih5VOBTZaSNjvTCSEvFr9oKfYxz6aiY1oHQ5aQD7HPE/sBPwTt1h20JQawKzAyHfMXbKtQf7dyP6nm7Eqv+P8vtP1ZO8yPNm7Hb9k3cqyMHw0le5/nc97h9pfT11aqclz2HPEGtVcODLxGwEPEPEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 21:00:37 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0181.019; Fri, 17 Jul 2026
 21:00:37 +0000
Message-ID: <b67ca397-397f-481e-9aec-cab883237eb2@amd.com>
Date: Fri, 17 Jul 2026 17:00:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix writeback completion timing
To: Alex Hung <alex.hung@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunpeng.li@amd.com, siqueira@igalia.com, mwen@igalia.com,
 tzimmermann@suse.de, ray.wu@amd.com, jpeisach@ubuntu.com,
 mario.limonciello@amd.com, cristian.ciocaltea@collabora.com,
 timur.kristof@gmail.com, ivan.lipski@amd.com, chen-yu.chen@amd.com,
 srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260711033159.3096477-1-alex.hung@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260711033159.3096477-1-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0228.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::17) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: d71d1e09-eb69-4ca4-7e47-08dee4467383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info: /GY9/1U+CXm5yrofx9Xbc7rmcqFo8a9N/aLcct0QqeITrpMWdPlZFdqrKHIPgNWDH4vLZG5GRwf9/xc4pooq3x1EBsisixTcNUtovY8n+bVupcu3aFNoCXW8Ws2ipqT6ygJhOXqokNIMXet/Bq0Q7P8qlLo8vOaieTjWuIqloEKkmfMrCc+hMzywuuJ37LEUE77CmFNSWbh2w6h9spGgMUmbKINczbh+ZXa5x9HZxRhkEmN7LAThM14H/BBYSVALyTu4WlIP64vOFNX7hYNOXU51+3oyynVOjFSNmQ4olvcGm5axHyE6UhEpf2NpEoYBtMwEYvrg819mtupSgvszUXcQ5XalM91YMfppEJhmk9fn3zD58mo14a5o6YKBhpcX50ZMXl/dilrSxWQsU3SphaeNDAfOOQ7lIHfiNWaMlx0zIRahzvPzABVn3ARQQWWEA+CP6Njo0QgPXLFOjxkObhwCiLjHzPZQ94XLX1GsuwoRqrGnOHMbrLYJIVN98SvHadpzOahLMDa2+jlXDcSu2urim+6xOi7rkyCVIAaAgZhJE9qEys9Ku/nO+KwlL96mNO9GxQFI+SX2ik01QYJPLlSVgqc2z5ZbmuI5HseH0g74Stp3lJHpoKhnzrKBEsgMPXhyuzb/0/w5yL/lHhlmqA+214wnEgINsEaIT4o8pGL49o0E9NUry6o0FoxP7zcCEnMxJvkMyaYOoYHlbEEMvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdEWHNFV2t2R010ckVUS1hTSzRBNGFyV0VXSGpIMDYxcjBMaENJU2VkZzF5?=
 =?utf-8?B?QVp1TDRXOFk2N1Y3WmRxSGpFSlFzemRJQ2dkTzhOZ0p1U0xvRkdTZEY3NnJh?=
 =?utf-8?B?Ykt3aHFZdVUzWmw0YTRtdHBVTitTcE1HK3VYRFZ1d0s4dmFjWGk5NE4yeU1R?=
 =?utf-8?B?ZEp6S1BEeU5sTFhia2ZEcCtxNDJ4aWswSm5tUWZ4UGgzdm1ncDh0TVdWY3c4?=
 =?utf-8?B?YUFzN0JzL1RWUEdOYXNrVzBNWHJpcUN5Vkw5NlZ5VkVHd2J6eVluWHlMSXph?=
 =?utf-8?B?TjRzeHBnaHpGU2hrLzRvUmM0UllGcENrNzhHRkFPUXZxWHlUSUZPeXdMZmJJ?=
 =?utf-8?B?YVk3MnMvT3VzQ2U2YytlUnd0VmF5cXZOaGppajZNdExCYWo0L1A5c2RGYTc0?=
 =?utf-8?B?WTRiSCtudWV6VVY5empRSENRMVI0SC8xeUJvblhRb0tsMS9Iclk1TXpnMXZR?=
 =?utf-8?B?YTUyWm9SZ0JsUUJPblBDNnZGTVBSbVRsVjVQcjRpaUt1NDFDbE9ieHljTTdD?=
 =?utf-8?B?aTYvMUhOTzRCVkt6QjIwR1UxNG9NN1k5N1RCdVZrZUh4MUptSVFPODdocFFW?=
 =?utf-8?B?d2VHSCswU2lXOFY2Uys4WkVuUW1lcVFFTVpXeTlxc1hNcFlFQ0lxRTR0eE93?=
 =?utf-8?B?Y1FJaGZHbmFWd1k3a3lndlNtcFBRenNVZkdxVU9zMitXN2l2b2xST3ZnaGJs?=
 =?utf-8?B?K0VmTkRQc2tsbVU1Wm8vdXlzMDFjUG9TOGk5cTBicVV2M2hkcHgwU3FlYVZ6?=
 =?utf-8?B?eXZGNlRFS2QxNVZlLysxakVIVktUSkJhQzdYZnZabXcxVmFZbWdITDVMMjZl?=
 =?utf-8?B?ckJPNXIwR29zSjNkSW5TcTNyR2pQSjhMMjIvM3JkRHZtd2JUNVJIelNIZVF0?=
 =?utf-8?B?TVZ6T0NNdHlqNk85My9xRUdwN1hsV0tzV3lhU3crNjdsR2F2b3AvczBRY0E4?=
 =?utf-8?B?NUVZbVcxUDByQVo0Z0xJSzUrMlBGazBYbW1CQUwwdlg1Qk11Zk04bytMbkxI?=
 =?utf-8?B?dWVXbzc1eE8wY244WS8zUzhHaXZpRjlpTG1za2lBbXlUelcvaE5rdEVZckVw?=
 =?utf-8?B?QkZSOE54VDFqWUx6T282L3VmdDlSMFVFc25IMTBIbDhLNlFCZWNDL1o2NXhl?=
 =?utf-8?B?SDdRZUs5UFRBN0dlYmIvaysvaFFzWXZlMnBUOWVuaTMybjJIdUMxSXBtdWRl?=
 =?utf-8?B?Rk1jbWhWZG9qcnNkRm9kZVpKclVLYmdZYkUwVUZnOUIzYmRZRFlleUMzR1lv?=
 =?utf-8?B?dHJQR2MrRElKc21KcmdxcUJlT0p5UFNRMm1TZXZORlVaQytDcmlxLy9aMUor?=
 =?utf-8?B?K29DZkVreHhLTkZBNlppc0xtYy9pcGc5NXNta1cxWG9XUWN1c0NFMGxQZFZx?=
 =?utf-8?B?TW93Y1JycGQ0dVZyazZKa0tJQVNIdzRGSHNHQitMZ0JDVjRicHIzeXZUZlNH?=
 =?utf-8?B?MXM2R2pocExJdG5mbnFyWWR1NEl0MHFPbWxwRElQQ2owSXNscHlMM2Q3UnZ0?=
 =?utf-8?B?M3pFcjNpeXBFZytvcGtxRk1pblNsV1c5RHdWMDVsUDFNdWxsOHZJU0UrMDlr?=
 =?utf-8?B?ZkREOTVUNFdGUFN4ZEdFOGpvTXVwK3BrVm9wVDJXb0xvUnBKNXYrRUpDd0lx?=
 =?utf-8?B?ODAwWXZ1S1l4dm5UMXFIYUdZT1RIYVczTTV3OE1kWHlCNGVsNjBCM1gxelIx?=
 =?utf-8?B?TmJHVWZYaVJJZ0xhZk16UmxuMTUrTUtVc2VtWXE3VUtnS25CZHJJRk5DS3Vj?=
 =?utf-8?B?b1NWcE5OSitjOXdEWnhkbndMV0J5ZE1mNlkxYnlTWmpOd2hQZDd4ZDFyZGNz?=
 =?utf-8?B?UnBqcXlEdjhVU2tHeDJyZjZVSkowQUNQaDQwR1p6Z3F4dWxYdVZUNnFQWWRF?=
 =?utf-8?B?VnUxcVhSYllHdm90NVB4eHFOSGViMlBrS0xHOGcvMCtsekhtaTlMcTJ6TElI?=
 =?utf-8?B?RWl6Q2pWUlFJVVVJQjk0UlFvcGJocEYvVE05VkUwREVwaW5PRDBPOUd3T3l2?=
 =?utf-8?B?VjNLdnJ5enRNK2R2aDBWSjNEZE9ESFdmdG5LQm1JWEdDT2lxTEhsUjgzanJ6?=
 =?utf-8?B?WkhMbk9hYnM1T1NNbkVYZURzcTlIdkVpNHFWVjdjSk9aZGZDYVdQMHJlejNR?=
 =?utf-8?B?TWRDUTFYMVh4alllYzdSYnQxcVo3M3QxYTlkUWxYbmluWVJSSWNxUmE3VlVV?=
 =?utf-8?B?ZVgwT3BTakxoNmxLUzhEZXdERFRqbGNzKzRGeDdBSDdaSkpabFVkUzFFQXNy?=
 =?utf-8?B?bkZCVzNmRjFzTjNOTjFOVE1OeWEvUkdaRzZGWmlQRml3U2dhRWhub0xzdkpv?=
 =?utf-8?B?bGN5L0psdDhUcVVRaFNHUEE1UzRTUHlzRUttSTk0aFFmSFRrYTdvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71d1e09-eb69-4ca4-7e47-08dee4467383
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:00:37.2809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgyRwCaL3ojb2uNHkjFaywFd1Jyg+EpcIaD1WBGDDkEjaLUe+iiYkT9rfqmNoVM9/vSRcHuB6uNn3Ipmgqq9tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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



On 2026-07-10 23:31, Alex Hung wrote:
> [WHY]
> The out fence was signalled on the first vblank after arming, before the
> DMA finished copying, and the old code worked around this with an
> mdelay() in the IRQ handler.
> 
> [HOW]
> Hold a vblank reference while writeback is pending and signal the out
> fence on the second vblank instead of using mdelay(). Add
> amdgpu_dm_crtc_complete_writeback() to finish and clean up writeback
> from both the IRQ and teardown paths.
> 
> This can be verified by running IGT's kms_writeback 20 times without
> timeout errors.
> 
> Assisted-by: Copilot:Claude-Opus-4.8
> Signed-off-by: Alex Hung <alex.hung@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 ++
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 33 ++++++++++---------
>  3 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 8069fc41cc7f..7c784277396a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -509,6 +509,7 @@ struct amdgpu_crtc {
>  	struct drm_pending_vblank_event *event;
> 
>  	bool wb_pending;
> +	bool wb_frame_done;
>  	bool wb_enabled;
>  	struct drm_writeback_connector *wb_conn;
>  };
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d67dcaa3fa8f..0f5453649200 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4521,6 +4521,7 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
>  	spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
>  	pending = acrtc->wb_pending;
>  	acrtc->wb_pending = false;
> +	acrtc->wb_frame_done = false;
>  	spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
> 
>  	if (!pending)
> @@ -4988,6 +4989,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
>  	 * cannot run its matching vblank_put before this get.
>  	 */
>  	WARN_ON(drm_crtc_vblank_get(&acrtc->base));
> +	acrtc->wb_frame_done = false;
>  	acrtc->wb_pending = true;
>  }
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index c5467f34c51f..4de7fb264cb2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -1974,23 +1974,26 @@ static void dm_crtc_high_irq(void *interrupt_params)
>  		return;
> 
>  	if (acrtc->wb_conn && acrtc->wb_pending) {
> -		struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
> -		unsigned int v_total, refresh_hz;
> -
> -		v_total = stream->adjust.v_total_max ?
> -			  stream->adjust.v_total_max : stream->timing.v_total;
> -		refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
> -			     100LL, (v_total * stream->timing.h_total));
> -		mdelay(1000 / refresh_hz);
> -
> -		/*
> -		 * Completion (signalling the out fence and releasing the vblank
> -		 * reference taken in dm_set_writeback()) is handled by the shared
> -		 * helper, which is also used by the teardown path.
> -		 */
> -		if (amdgpu_dm_crtc_complete_writeback(acrtc))
> +		if (acrtc->wb_frame_done) {
> +			/*
> +			 * Second vblank: the DMA for the captured frame has
> +			 * had a full frame period to flush to memory. Signal
> +			 * the out fence now.
> +			 */
> +			amdgpu_dm_crtc_complete_writeback(acrtc);
> +		} else {
> +			/*
> +			 * First vblank after arming: the frame has been
> +			 * scanned out and the DMA is finishing. Disable
> +			 * writeback immediately to prevent the hardware from
> +			 * starting a new capture that would overwrite the
> +			 * buffer. Signal completion on the next vblank to
> +			 * ensure the DMA is fully flushed to memory.
> +			 */
>  			dc_stream_fc_disable_writeback(adev->dm.dc,
>  						       acrtc->dm_irq_params.stream, 0);
> +			acrtc->wb_frame_done = true;
> +		}
>  	}
> 
>  	vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
> --
> 2.43.0
> 

