Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1665C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF7810E2C3;
	Wed, 26 Aug 2026 14:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="kJm2+Wcg";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B79C10E2C3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:34:48 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cc891373e0so13767005ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1787754887; x=1788359687; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yn02buzACRQQNaPjkaVeG7aAyIjhQMcWh60YSklrQcY=;
 b=kJm2+WcgxSyaex9JL45TgL1phtXBKxULGalDtGRHzocSQotMkX214D0m7sWV8fmsBI
 mkymtufifjiszPAWSJeK5+CGf5C+yH9EomNj3KOZGtfQciFph0YGiaeO8JKVSOVLzJUB
 aADuRp3Rw6Uzr+9UaVBpRjn0Lx5VpzFbBSuAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787754887; x=1788359687;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yn02buzACRQQNaPjkaVeG7aAyIjhQMcWh60YSklrQcY=;
 b=JqAbcpY0UnczqAoFzuds1fugjV2CWl+RLh63vx6khqeIZvww4bEVsX3HfnWnp73xnD
 yF8Hti4a3cpr1N1QNrFXk/4OXFPozqsCNsTJyEaru+LlbVoMJIRvR6XGOcZ/g/FFWMyV
 38mt4TT99YE6dxlSEHXpy1PyYFyag9q1kiTPmAC3NO3iQ3Odx31HPqrMecc+vXMsUqqd
 G2ozzPKr9azA3ZZ2RFndByi/smgZqZrHsdo0ALhWsbXm3q8ow75g6cPN32P98zvYvEdo
 +SxrXiJLnahgsYX1Ar34ZCqcO3JqSqgaYvoNnQo3ijOqNSVoDpQslQyHxr40iFcxLHet
 +l6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpg4GDMeBh8l6gTlQnaTKMrEpsHg7CDykg63ODTSRogvs3CQrfRuzxonl2Iuw0Z/L53eWUIHdBvM5Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++noOF7EiFBrRrktxCx3/TDDuDUuyNWxBYe8y51otojC2O1K/cQM
 HCZWYM2+y65NUncnzfWqVihFqCDoaYEjZbW/Tt2kuWAUAheFWyJolLTmUqp6SKG7S/U=
X-Gm-Gg: AR+sD126glVVBmRBIExmElHrWYtoK8O8NuY9GGpda23WhlnUuyRJNr86Gy8xNBVRpYF
 ooKYaeAINOdE8KMAm3l06KM850DIJYiki9L8NBi5liJcrkpL7xCMqeil/4+miyA15LeVKu7djg6
 BlfX9EmJQqSPPpSvO2RGV+jK6R5rLv/1zcbRjEeXEH4HjEId1Jnxb5hkYRa2huKcWR0XDNEp6IP
 OvXu54ljQOChbBQxCPWOeJp0WXyuu2y46/akvOxINdbpbU31JiftzzrKbBluQdVRy75pT3GWRG6
 DVLd+peGka7iGrB7uYhyXB7Q+QXXhTL3RP0iPpzkJAnBRIdJ1M0HeEAOemlwarOB2nOhyGQDtjz
 v/o4qb1RBGz20r9YxB6tMIM6K3ygxXSf8PyXnvmr3L/X8RJomwI1riaXFrp2rFeRpMEMosPF4Wb
 9lp2OdBzzuu/Tb/fHzuJyE5PAa7e0hKYPt8nwEHWsH+08qUMSR4FNvCvYa0O6yqD4=
X-Received: by 2002:a17:90b:4e88:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-3966d3e1aa7mr17670746a91.9.1787754887451; 
 Wed, 26 Aug 2026 07:34:47 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a57396sm4760198a91.13.2026.08.26.07.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 07:34:47 -0700 (PDT)
Date: Wed, 26 Aug 2026 23:34:34 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: Fix job submit error handling
Message-ID: <ao706o8ReDs-IXqf@rock-5b-plus>
References: <20260813142059.151644-1-Naixumogu@whut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813142059.151644-1-Naixumogu@whut.edu.cn>
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

On Thu, Aug 13, 2026 at 10:20:59PM +0800, MoGGuU wrote:
> Several error paths in the job submission path can be triggered by
> unprivileged userspace through malformed DRM_ROCKET_SUBMIT requests.

I think it would be better to split this per fix.
And I've tested this patch, it works.


> 
> First, the input and output BO handle counts are __u32, but GEM lookup and
> reservation helpers take int counts.  Values outside the signed range can
> become negative.  A combined count above INT_MAX can also overflow at the
> call sites.  Reject counts that cannot be represented safely before looking
> up the BOs.
> 
> Second, rocket_job_push() arms the scheduler job before collecting its
> implicit dependencies.  Dependency collection can fail with -ENOMEM, but
> drm_sched_job_arm() is a point of no return.  An armed job must be pushed;
> it must not be aborted with drm_sched_job_cleanup().  Collect dependencies
> before taking the scheduler lock and arming the job.  Only operations that
> cannot fail remain after arm().
> 
> Finally, rocket_ioctl_submit() discards each job's return value and reports
> success even when every job fails.  Return the first error
> and stop submitting the remaining jobs.  Jobs queued before an error remain
> queued, giving the ioctl ordered partial-submit semantics.
> 
> Tested on RK3588 with zero task counts, invalid task pointers, invalid BO
> handles, and oversized BO counts.  The requests returned the expected error
> codes without warnings or errors in the kernel log.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 34 +++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index bb77b6bf0..c42bbf486 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -206,21 +206,20 @@ static int rocket_job_push(struct rocket_job *job)
>  	if (ret)
>  		goto err;
>  
> +	ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
> +					   &job->base, false);
> +	if (ret)
> +		goto err_unlock;
> +
> +	ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
> +					   &job->base, true);
> +	if (ret)
> +		goto err_unlock;
> +
>  	scoped_guard(mutex, &rdev->sched_lock) {
>  		drm_sched_job_arm(&job->base);
> -
>  		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
> -
> -		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
> -		if (ret)
> -			goto err_unlock;
> -
>  		kref_get(&job->refcount); /* put by scheduler job completion */
> -
>  		drm_sched_entity_push_job(&job->base);
>  	}
>  
> @@ -556,6 +555,12 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
>  	if (job->task_count == 0)
>  		return -EINVAL;
>  
> +	/* GEM lookup and reservation helpers take signed object counts. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX ||
> +	    job->in_bo_handle_count > INT_MAX - job->out_bo_handle_count)
> +		return -EINVAL;
> +
>  	rjob = kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;
> @@ -639,8 +644,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
>  	}
>  
>  
> -	for (i = 0; i < args->job_count; i++)
> -		rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +	for (i = 0; i < args->job_count; i++) {
> +		ret = rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +		if (ret)
> +			goto exit;
> +	}
>  
>  exit:
>  	kvfree(jobs);
> 
> base-commit: d85a5e9dfb42449d9f37b0ddc6ec30b129f481ce
> -- 
> 2.43.0
> 

Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
