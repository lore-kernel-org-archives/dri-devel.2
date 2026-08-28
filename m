Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CD9C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABA210E482;
	Fri, 28 Aug 2026 05:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="lC2GsjNh";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F71B10E482
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:46:24 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-853e2610bb4so1311960b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1787895984; x=1788500784; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yZvPrH9nbFYHNhZAMmF6wqS3Ks98wuR+oIcktCYDIEA=;
 b=lC2GsjNhH7LEqCAGntr1IboM3I6OjhttluA69pZwblxAc3RQk/VhI4wUC/YprQlf+y
 hunK0hdZnxxA3DU+p1XWTstwZJufQLe+hwGP/Wp5LyPsv1LtVid319cvggefZguODCHA
 2eLpFIew/gGlJ4cSxTkEyB3CSJWy0Fw/qv00A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787895984; x=1788500784;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yZvPrH9nbFYHNhZAMmF6wqS3Ks98wuR+oIcktCYDIEA=;
 b=r0xYhCZIJAEOUT4H+KREggMkzi1maoAHUGdAqaQgIqaX03DJERPOzAFvwfi1Dqdwmi
 8mHezNV1TfueLDeLnMUdrS9sMezVwVBZTRj1CeFv9Rm15Hma+F7fda3Yv9k7SFiyYZpB
 KcrVeZmD+THwBmgtxbR4AKNBeQiiuEm8DjVZFZvH4Z5gNSTv6tXTax17K/Pz7ZUXPsTz
 50KsGeRlU0/oUCkhNJw3Pq32b+KsgTAObn1yVGDU1umAAui62Tz73aH7TnFT7Qj3wOdn
 O/QoeMZRbarlNJ3RqM278uXC1JBZx7Did52IbFwbTyDtXHOzF95rm9P+Qo3T2QxfcTsj
 Jtlg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZixqbbLJHeMb5TXHm8nOo915salF4PmlB7iwsr/Fci7ibviBc44+7yeyB/hAZqM7bLNoTpVSQZHE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ks+cfHxymnHxIhn17hQC3QTxCVLoG6WlJq+mdFcJZ+zRr2Kdxz
 qcuFi5okXP8tZ+rzZVQs1La6Mhq3g++P/e4YngR4sKp921Tzh0y7O/+gPPwvdyThc9E=
X-Gm-Gg: AR+sD12imrmRZhOHcBoInJaj0qxipjCX7MxpQOAAV8gskCIHbC7bT2yIVbQWRnvriQ7
 4XVDGhCkefWjor9gfAiEQUtTlSBle8sq0DTdMS6SUKbJV6+t2RUHYAYSgshCaVfPsJqv0Ia5UF0
 2ERX7k5gn8WfpcdXZFZVYmasGFU6Tlb0HkLcIMMi1aUn1TyesddMUDkLiMwXIn9DuSEZhM42VB7
 HNx7/hiSNGP9mJljcL1H9BrZheJ7NsYo7cC9W2DJW/Jf3wkhLjdyUvJ9kzl+PjXcfLDEbqZ4opD
 jx67Rlho+FrMm9nnJtrngi56IU2V/+OfnaTPygTEqWM4C1JBQJjDm/VzXu82RtEZz193WTZpJmc
 Ak9zb/mQlAFEad/gf9iRezhY7Fh7XKvQMH2SOQOPOIkIAU4HB/L0TQAxQ7B23W7nw6L3EBwcO+0
 EST7vSMS9L16jSbGarZgwCIeaSZUS/7MFW8EXPWWuxNraMTe1BwazjoYLEZqrsu/Y=
X-Received: by 2002:a05:6a20:7fa3:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3d0f43b6581mr14032383637.2.1787895984063; 
 Thu, 27 Aug 2026 22:46:24 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1f32f656dsm225735a12.5.2026.08.27.22.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 22:46:23 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:46:16 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] accel/rocket: Collect job dependencies before
 arming
Message-ID: <apEggyjyM9yCqg4A@rock-5b-plus>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-3-Naixumogu@whut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828050805.38548-3-Naixumogu@whut.edu.cn>
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

On Fri, Aug 28, 2026 at 01:08:04PM +0800, MoGGuU wrote:
> rocket_job_push() arms the scheduler job before collecting its implicit
> dependencies. Dependency collection can fail with -ENOMEM, but an armed
> job must be pushed and must not be aborted with drm_sched_job_cleanup().
> 
> Collect dependencies before taking the scheduler lock and arming the job.
> Only operations that cannot fail remain after drm_sched_job_arm().
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index e6052d1973afa..b55e12aecfe64 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -206,19 +206,21 @@ static int rocket_job_push(struct rocket_job *job)
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
>  
>  		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
>  
> -		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
> -		if (ret)
> -			goto err_unlock;
> -
> -		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
> -		if (ret)
> -			goto err_unlock;
> -
>  		kref_get(&job->refcount); /* put by scheduler job completion */
>  
>  		drm_sched_entity_push_job(&job->base);
> -- 
> 2.43.0
> 

Reviewed-by: Sidong Yang <sidong.ynag@furiosa.ai>
