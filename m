Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA301F8A167
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC01310E890;
	Thu, 16 Apr 2026 12:00:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Uk6zrXkX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A4610E896
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PoYP6Afo93LW+/YdqAtHGiCIIQWfLLv1hNBbmNUH8Xs=; b=Uk6zrXkX2i4bIGC0Lj3iYZ/+0c
 fZ2u0TNyX0XlKyC1yB6V+94OKIZPjguOPURrirp5CUmDofNU8sm9blb47EdNFBm0gqgJaVU2SDZok
 wwJ3wOWlyRSlv+cU4AStbiod65kTO1K5XNtFC2LMfAtpM3fgMSYuT5SitCE+0X8kTN9KlHWNioLqq
 EpGPY0nygu86ZUyVCUNcw5xUF5aCAWPZtl3CYinZvRPxqnYqktJ1IMLSaLfCdtAoEcLOvGmGBY/Qs
 v5fzPFVRowIQ+vxZjTqmH2qecr2S6F0QvueQfJUb0iAyJ8HdL4+kq0Oy+wiJHsXSeFvlp/6rWm8mp
 ptUW5T9w==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wDLNw-00Gxru-MO; Thu, 16 Apr 2026 13:59:52 +0200
Message-ID: <b4ac5310-39f8-4a7d-9bce-906e100680ec@igalia.com>
Date: Thu, 16 Apr 2026 12:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/v3d: Reject invalid syncobj handles in submit
 ioctls
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-6-bac63a8ceb6c@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-6-bac63a8ceb6c@igalia.com>
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


On 13/04/2026 16:03, Maíra Canal wrote:
> drm_sched_job_add_syncobj_dependency() returns -ENOENT both when the
> handle is zero and when the handle is non-zero but does not find a
> corresponding existing syncobj (userspace bug). The driver previously
> ignored -ENOENT in both cases, silently accepting broken handles.
> 
> Distinguish the two: skip the call entirely when the handle is zero, as
> there is no dependency, and let -ENOENT propagate for non-zero handles
> that don't resolve, turning the error into a proper return to userspace.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 054367ba533d..fe8b5757c3e8 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -171,12 +171,11 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
>   	int ret = 0;
>   
>   	if (!has_multisync) {
> -		ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
> -							   in_sync, 0);
> -		// TODO: Investigate why this was filtered out for the IOCTL.
> -		if (ret && ret != -ENOENT)
> -			return ret;
> -		return 0;
> +		/* Ignore syncobj if its handle is NULL */

Nitpick s/NULL/zero/ since it is not a pointer.

> +		if (in_sync)
> +			ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
> +								   in_sync, 0);

Ah now ret needs to be initialized to zero (comment from previous patch)!

> +		return ret;
>   	}
>   
>   	if (se->in_sync_count && se->wait_stage == queue) {
> @@ -190,11 +189,13 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
>   				return -EFAULT;
>   			}
>   
> -			ret = drm_sched_job_add_syncobj_dependency(&job->base,
> -								   file_priv, in.handle, 0);
> -			// TODO: Investigate why this was filtered out for the IOCTL.
> -			if (ret && ret != -ENOENT)
> -				return ret;
> +			/* Ignore syncobj if its handle is NULL */

As above. Or perhaps even NULL makes sense as in null handle being an 
invalid handle reads more obvious than a zero handle?

> +			if (in.handle) {
> +				ret = drm_sched_job_add_syncobj_dependency(&job->base,
> +									   file_priv, in.handle, 0);
> +				if (ret)
> +					return ret;
> +			}
>   		}
>   	}
>   
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

With a slight danger there is some userspace out there which relies on 
this? Have you look at how Mesa uses it, and the history?

Regards,

Tvrtko

