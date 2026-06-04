Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99A2CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F0710E5EB;
	Thu,  4 Jun 2026 09:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OjlnaenU";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF60110E5EB
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 09:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cE7MtlTjRzUqQbREBM8KqnatEKRVc2qv2XtdNFT8V84=; b=OjlnaenUVnpRuqziy9k4xdIvCH
 PCLHHltcN26UJyR5Mx9D9yhqxl26MJSWasNI50ssKz0JGyRtfERtaFzx+12A4lag9MSCXfIPt/vXV
 wdEuH36k6yW5U8eybANltwU/bpu+rLzADiMlSFvGYNY3IpBBLqclFOPaAqyM+Gw5F+fn044gm8zHL
 2ErQAkJeG1Hg4HrUfPFYZM7tlpOlPtSxYOwzHj4vzoBdzFkQE690Ex0+QY7OyXWofet7UJxB32Yzt
 ZJJoOFDHxE4N9A4Z8u/Jnvcs4MAlIAZ3Ydtt4yleyZ5lO3FDcF/+ekv0tmORQL0Ctp/j7+7QGSuOD
 ZG1ucm/g==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wV4rH-00Ca67-Te; Thu, 04 Jun 2026 11:59:27 +0200
Message-ID: <e3e754ce-9c98-4015-99bb-0f73049a1469@igalia.com>
Date: Thu, 4 Jun 2026 10:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] drm/v3d: Split BO fence attach from syncobj
 output handling
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
 <20260603-v3d-sched-misc-fixes-v3-12-d7114bba55a0@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-12-d7114bba55a0@igalia.com>
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


On 03/06/2026 23:25, Maíra Canal wrote:
> v3d_attach_fences_and_unlock_reservation() does three different things:
> (1) attaches the submission's last fence to every BO, (2) releases
> drm_exec, and (3) replaces the userspace out_sync syncobjs. Decouple
> these three behaviors into different functions, so that each function
> has a more self-contained behavior.
> 
> v3d_submit_jobs() now invokes the three steps explicitly, which makes the
> submission sequence self-documenting and keeps each helper self-contained.
> 
> No functional change; just code consolidation.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 1df7ab528422..2beb99a25104 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -319,12 +319,9 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
>   }
>   
>   static void
> -v3d_attach_fences_and_unlock_reservation(struct v3d_submit *submit,
> -					 u32 out_sync, struct v3d_submit_ext *se)
> +v3d_submit_attach_object_fences(struct v3d_submit *submit)
>   {
> -	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
>   	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
> -	struct drm_syncobj *sync_out;
>   
>   	/* The submission's last fence covers the entire submission. Attach it
>   	 * to every BO touched by any job in the submission.
> @@ -338,8 +335,15 @@ v3d_attach_fences_and_unlock_reservation(struct v3d_submit *submit,
>   					   DMA_RESV_USAGE_WRITE);
>   		}
>   	}
> +}
>   
> -	v3d_submit_unlock_reservations(submit);
> +static void
> +v3d_submit_process_post_deps(struct v3d_submit *submit, u32 out_sync,
> +			     struct v3d_submit_ext *se)
> +{
> +	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
> +	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
> +	struct drm_syncobj *sync_out;
>   
>   	/* Update the return sync object for the job */
>   	/* If it only supports a single signal semaphore*/
> @@ -400,7 +404,10 @@ v3d_submit_jobs(struct v3d_submit *submit, u32 out_sync,
>   
>   	mutex_unlock(&v3d->sched_lock);
>   
> -	v3d_attach_fences_and_unlock_reservation(submit, out_sync, se);
> +	v3d_submit_attach_object_fences(submit);
> +	v3d_submit_unlock_reservations(submit);
> +	v3d_submit_process_post_deps(submit, out_sync, se);
> +
>   	v3d_submit_put_jobs(submit);
>   
>   	return 0;
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

