Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C30DCD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 12:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DCB10E2D3;
	Mon, 25 May 2026 12:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="R0oi3USF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD47C10E2D3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f+rjtbrxamO5jF2/5NAXy2fClzEEHzaM86PFUWcHhWM=; b=R0oi3USFagvMVFC3BPtNQ2haSA
 KyrwEfaPJXJzpDt5YY+3sthxY9FQHqDg+EOoTWmTvm211uvOz78YetYU0L0HhT1BCu1mVCMUyNvP8
 8gGKhIkI5dm+DJUhOUExZ96clMOWfq/DJrItrY+Yr4lMI3Y+XMIM0Db97Y+YgVpyeSKWkB8kUCTjR
 OiGELrGbQTn15c7Eu+r3eb0mm2TMJvatyfoyCm2KPQcqYy6sZzC32ZrA3Kvw1vmnmllc3QgLXezyX
 Zz5TWchO++Ww159ehLSg0M+O/mphVZL3Vde60zABEC+sM3gH7/ss5nPb7mufswlGwDkICr1IiNZQp
 6xkZBNIQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wRUVA-0080ve-VQ; Mon, 25 May 2026 14:33:49 +0200
Message-ID: <ff77934c-3079-4daa-b427-814df13482ac@igalia.com>
Date: Mon, 25 May 2026 13:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] drm/v3d: Make v3d_get_cpu_indirect_csd_params()
 a pure parser
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
 <20260510-v3d-sched-misc-fixes-v2-9-ca4aba343ef6@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-9-ca4aba343ef6@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 10/05/2026 23:12, Maíra Canal wrote:
> v3d_get_cpu_indirect_csd_params() currently does double duty: it parses
> the indirect CSD extension and, while still inside the extension parser,
> also creates the CSD/clean jobs and locks their BOs through a separate
> DRM exec context. This nested submission deviates from the standard flow
> and makes it hard to fold the indirect CSD path into the unified submit
> chain.
> 
> Stash the parsed drm_v3d_submit_csd args in struct v3d_indirect_csd_info
> and have the parser only fill in the parameters. Then, move job creation
> (v3d_setup_csd_jobs_and_bos()) into v3d_submit_cpu_ioctl(), where is the
> proper place to create jobs.
> 
> No functional change, but prepares to move the CPU ioctl into the
> unified submission chain.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_drv.h    |  5 +++++
>   drivers/gpu/drm/v3d/v3d_submit.c | 16 +++++++++++++---
>   2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index fc12e5215fb0..ec01668bacb6 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -425,6 +425,11 @@ struct v3d_indirect_csd_info {
>   	/* Clean cache job associated to the Indirect CSD job */
>   	struct v3d_job *clean_job;
>   
> +	/* Indirect CSD args, stashed by the extension parser and later used
> +	 * to create the CSD job from them.
> +	 */
> +	struct drm_v3d_submit_csd args;
> +
>   	/* Offset within the BO where the workgroup counts are stored */
>   	u32 offset;
>   
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index c51474403d2d..ef003ca6b42a 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -600,6 +600,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
>   	}
>   
>   	job->job_type = V3D_CPU_JOB_TYPE_INDIRECT_CSD;
> +	info->args = indirect_csd.submit;
>   	info->offset = indirect_csd.offset;
>   	info->wg_size = indirect_csd.wg_size;
>   	memcpy(&info->wg_uniform_offsets, &indirect_csd.wg_uniform_offsets,
> @@ -607,9 +608,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
>   
>   	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
>   
> -	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
> -					  &info->job, &info->clean_job,
> -					  NULL, &info->exec);
> +	return 0;
>   }
>   
>   /* Get data for the query timestamp job submission. */
> @@ -1370,6 +1369,17 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
>   		goto fail;
>   	}
>   
> +	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
> +		ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d,
> +						 &cpu_job->indirect_csd.args,
> +						 &cpu_job->indirect_csd.job,
> +						 &cpu_job->indirect_csd.clean_job,
> +						 NULL,
> +						 &cpu_job->indirect_csd.exec);
> +		if (ret)
> +			goto fail;
> +	}
> +
>   	clean_job = cpu_job->indirect_csd.clean_job;
>   	csd_job = cpu_job->indirect_csd.job;
>   
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

