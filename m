Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC3C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 262A710E204;
	Thu, 13 Aug 2026 07:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="adIRMeJO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E18410E204
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786605176; x=1818141176;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=6eBWF9r0sKOU45Eyb2ShiZJvSuVlbZ6/CTZ1ieUnrDk=;
 b=adIRMeJO1+pv68Cy2SYO7TWyyicpxJBPggwJdhN9i6Iazcv4Lv9rKC0C
 2t160a7IJeKp1eNs9uktD/RT2PvcA28JZR7cuESpXiKcDoYkiCtYFtryZ
 RtNPXZGSTDqLdTdoDouT7o6k8tLwVK3qoucT0BBBSyXhXiHlgtxl3FQXY
 frXSIjg2n187EGjZAFMK9zGlWRYJuyA2CJ6+KIq7NOmbKGrZmnPkx2POR
 2EAP4G8owkpyGO9q1SbRv/CQaSQx3hEaKWPrDz98zGiFHYBH/v7M+1KQ4
 vNgZr/4SBZsoK+BmEw+5R/IzwTHTy39uHc9QLYZbrS9RWlV9v+f3mU9DY A==;
X-CSE-ConnectionGUID: b9d9a8M2RnWXmwjtP30vHw==
X-CSE-MsgGUID: uI5vnC2zS7SnjP2WOxsPPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87296662"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="87296662"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 00:12:56 -0700
X-CSE-ConnectionGUID: GdGNcBpwRDm0zUtUCBrc/A==
X-CSE-MsgGUID: 4BhJFFtzQleUb8kTCEXDaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="257641162"
Received: from kpleskax-mobl2.ger.corp.intel.com (HELO [10.94.252.39])
 ([10.94.252.39])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 00:12:53 -0700
Message-ID: <4c656606-b91f-4e12-8e39-3b89ec0c13cd@linux.intel.com>
Date: Thu, 13 Aug 2026 09:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: fix usage_count leak when autosuspend_delay
 is negative
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260807145416.2518999-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260807145416.2518999-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 07-Aug-26 16:54, Guangshuo Li wrote:
> ivpu_pm_init() calls pm_runtime_use_autosuspend(), but the autosuspend
> setting is not disabled when the device is removed or when
> initialization fails after runtime PM setup.
> 
> When the autosuspend delay is negative, the runtime PM core increments
> usage_count to prevent runtime suspend. Without a matching
> pm_runtime_dont_use_autosuspend(), this reference is not dropped and
> usage_count remains unbalanced.
> 
> Call pm_runtime_dont_use_autosuspend() from ivpu_pm_disable() to clean
> up the autosuspend state during normal device teardown. Also undo the
> autosuspend setting when ivpu_boot() fails after ivpu_pm_init().
> 
> This issue was found by manual code inspection.
> 
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Hello,

Thanks for the submission.

> ---
>   drivers/accel/ivpu/ivpu_drv.c | 4 +++-
>   drivers/accel/ivpu/ivpu_pm.c  | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 35e506074d5f..633c90e73f2c 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -756,13 +756,15 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
>   
>   	ret = ivpu_boot(vdev);
>   	if (ret)
> -		goto err_ipc_fini;
> +		goto err_pm_fini;

This leaves err_ipc_fini label unused, could you please remove that 
label below and keep both pm_runtime_dont_use_autosuspend(vdev->drm.dev) 
and ivpu_ipc_fini(vdev) under err_pm_fini.

Otherwise compiler will complain about unused label.
>   
>   	ivpu_job_done_consumer_init(vdev);
>   	ivpu_pm_enable(vdev);
>   
>   	return 0;
>   
> +err_pm_fini:
> +	pm_runtime_dont_use_autosuspend(vdev->drm.dev);
>   err_ipc_fini:

Remove err_ipc_fini here.

Once that gets fixed:
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

>   	ivpu_ipc_fini(vdev);
>   err_fw_fini:
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index c1ce8329790e..20dc8ec7d70a 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -445,6 +445,7 @@ void ivpu_pm_enable(struct ivpu_device *vdev)
>   
>   void ivpu_pm_disable(struct ivpu_device *vdev)
>   {
> +	pm_runtime_dont_use_autosuspend(vdev->drm.dev);
>   	pm_runtime_get_noresume(vdev->drm.dev);
>   	pm_runtime_forbid(vdev->drm.dev);
>   }


