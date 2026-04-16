Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DFAF8A165
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3AB10E1C1;
	Thu, 16 Apr 2026 11:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TyBTeaoG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C6710E1C1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6fDvhyU/0AGz5K006uZXFuaK3gFgPuJHFVEV4bGr3WM=; b=TyBTeaoGwta14JV4Fxyh4fm32o
 4pNlOHYptOUWYXMhi3Z8ekp0W/X534Dnz6zSjyfp+q1C9fvx5PAC6TGMMd4Slc7YJVmvWUj8q4wHC
 e1lry22fviVVHB/WAOguF3rpJbnj+0Mh9pBABCvOmHdK4S/3IV2sUC+tO07JOQLK21yfkf6fVAshP
 nAXJKBixArZTrbi/5+t6AIBqaLmWOA3dRYqF1lP/X/1hI53GqToP2LwUP7IvQQJajFDmgIx434Ejv
 MMD+tBOa/EOARJ5P2lqSvywWQ3qjKBHmFu8vOIXybSKpZTGHi/rYTEgYgrtOtaBsfylW/1VYZ2QJv
 ZTBGVzMA==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wDLHl-00GxkU-AE; Thu, 16 Apr 2026 13:53:29 +0200
Message-ID: <57756eb9-e257-4ed6-8d1f-1e995a52d5a9@igalia.com>
Date: Thu, 16 Apr 2026 12:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] drm/v3d: Extract v3d_job_add_syncobjs() helper
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
 <20260413-v3d-sched-misc-fixes-v1-5-bac63a8ceb6c@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-5-bac63a8ceb6c@igalia.com>
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
> Move the syncobj dependency setup out of v3d_job_init() into its own
> v3d_job_add_syncobjs() helper. No functional change.
> 
> This prepares for the next commit which changes the error handling, and
> for a later consolidation that separates job allocation from syncobj
> attachment.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 71 ++++++++++++++++++++++++----------------
>   1 file changed, 43 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index f75da2e3533e..054367ba533d 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -162,14 +162,52 @@ v3d_job_deallocate(void **container)
>   	*container = NULL;
>   }
>   
> +static int
> +v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
> +		     u32 in_sync, struct v3d_submit_ext *se, enum v3d_queue queue)
> +{
> +	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
> +	struct v3d_dev *v3d = job->v3d;
> +	int ret = 0;

Nitpick - looks like ret does not need to be initialized.

Otherwise extraction indeed looks like no functional change:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> +
> +	if (!has_multisync) {
> +		ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
> +							   in_sync, 0);
> +		// TODO: Investigate why this was filtered out for the IOCTL.
> +		if (ret && ret != -ENOENT)
> +			return ret;
> +		return 0;
> +	}
> +
> +	if (se->in_sync_count && se->wait_stage == queue) {
> +		struct drm_v3d_sem __user *handle = u64_to_user_ptr(se->in_syncs);
> +
> +		for (int i = 0; i < se->in_sync_count; i++) {
> +			struct drm_v3d_sem in;
> +
> +			if (copy_from_user(&in, handle++, sizeof(in))) {
> +				drm_dbg(&v3d->drm, "Failed to copy wait dep handle.\n");
> +				return -EFAULT;
> +			}
> +
> +			ret = drm_sched_job_add_syncobj_dependency(&job->base,
> +								   file_priv, in.handle, 0);
> +			// TODO: Investigate why this was filtered out for the IOCTL.
> +			if (ret && ret != -ENOENT)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
>   	     struct v3d_job *job, void (*free)(struct kref *ref),
>   	     u32 in_sync, struct v3d_submit_ext *se, enum v3d_queue queue)
>   {
>   	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
> -	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
> -	int ret, i;
> +	int ret;
>   
>   	job->v3d = v3d;
>   	job->free = free;
> @@ -180,32 +218,9 @@ v3d_job_init(struct v3d_dev *v3d, struct drm_file *file_priv,
>   	if (ret)
>   		return ret;
>   
> -	if (has_multisync) {
> -		if (se->in_sync_count && se->wait_stage == queue) {
> -			struct drm_v3d_sem __user *handle = u64_to_user_ptr(se->in_syncs);
> -
> -			for (i = 0; i < se->in_sync_count; i++) {
> -				struct drm_v3d_sem in;
> -
> -				if (copy_from_user(&in, handle++, sizeof(in))) {
> -					ret = -EFAULT;
> -					drm_dbg(&v3d->drm, "Failed to copy wait dep handle.\n");
> -					goto fail_job_init;
> -				}
> -				ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv, in.handle, 0);
> -
> -				// TODO: Investigate why this was filtered out for the IOCTL.
> -				if (ret && ret != -ENOENT)
> -					goto fail_job_init;
> -			}
> -		}
> -	} else {
> -		ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv, in_sync, 0);
> -
> -		// TODO: Investigate why this was filtered out for the IOCTL.
> -		if (ret && ret != -ENOENT)
> -			goto fail_job_init;
> -	}
> +	ret = v3d_job_add_syncobjs(job, file_priv, in_sync, se, queue);
> +	if (ret)
> +		goto fail_job_init;
>   
>   	/* CPU jobs don't require hardware resources */
>   	if (queue != V3D_CPU) {
> 

