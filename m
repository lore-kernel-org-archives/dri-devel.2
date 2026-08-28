Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0247C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028F810E479;
	Fri, 28 Aug 2026 05:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="k7Cf3y3J";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E9F10E479
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:50:57 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d71e253c90so6038765ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1787896257; x=1788501057; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LpkQSACoNhXcxF8SalSGxWUmZp7l1S5RyOE6epy4FMk=;
 b=k7Cf3y3JjXxpPGU5xqFCYCCZkDKevGpokpzlV85aPq0XrB70bP5YH/jxm6aaMt9rQY
 h12zE0z26pEckkiaW6Y2VLog/HuYzcpX5GjDRla9P1DZF71SDi+fKEaEn8kPL/Zrn17e
 ioPVBtFWNEwA/skl3dIgJrXwcDDHrtaNg6E8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787896257; x=1788501057;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LpkQSACoNhXcxF8SalSGxWUmZp7l1S5RyOE6epy4FMk=;
 b=bwCTNV7wQSvrICCFp69mDtKtcSbzj26aO4KJNnjsD6950PdaDgTgQgYyzp0PuGf/+v
 k+s48OZcVB9r6nbUpEhi2EaVns7gG9l90GTfVoHiR0F8NZuEHxemkbbmMid7RK52PRIm
 I+pRLdE8G7K9fA9Ou75WwAl/74kdXo0PlLve5ERBDJB+JAPjRHTDmukZT5AjgA4YgCFt
 3qFQTwa9GmnUdKgdEJDxwX/rzvFPgvjcBoH4s5YsvHjq8m7t5Cw6mzRotCH25nt6Zgwo
 SU4pdr6XhojIrUzhMpvYhrYRxGDzjXfXcXy3JuD8kMd1mISvSXFp7AEx/GLtLr97JnBs
 8Y+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro84kaVMCtH1JdcoJHYWKQElqlXkZr8wT0OzMfDR0uxQAtE8QiAwlzlzKh+5Q9ydPR4NUhnkc3uo0U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++maGlDr5ADA6eHn6DbYV0sh4Hb0Yx3KA8c/A3HXYRDVnKreje5W
 ZnZjVCaSDqIuPwuZlvJyPaAqVfSRkAPWP5cqeM4oxpkWfYt/g0S8d6eYKkJaTffEDPc=
X-Gm-Gg: AR+sD127H4C7dWhaM+xpYR7IdoOLMBkbxPpfCOTGSBJ/ODsdSgI6Uou2dcoG3jVlSjM
 +32dtlb/B7G1Rhx8cx2PbTasP+J07xuBrExu83nBBWsixtumSwyUSN19bzKGOUv8pIz0o+KXdBv
 Knqwo5Zx9UDfu4kDR546UR4B9IoSiH3zE6rmfPKeDrkkkp5RnXeOovOLD+ZVZGDcuRJ3ueNVf4n
 iC81zUwluAJ6nFmVnX9f/vunio7MCUMaso/LuzhDrpcT8W1PHquCu7dE6KeI64jwfsgr8v71nit
 1B555WY8+gdsLSQjPfI3xhvvcbUgK/nKor49r8icbeb7kRfFA7fgJwolKcvNaXn8ylWt6GSTEEY
 ZdlCGj8vgnDSGuEO8JC1aB8dG5yahsfxsOsnsqxUW9aP6J3zXHoNLU2JkOnIJbooZw3ZzFDrLr1
 42A9DohmlARA3UXG9WpvGWIO2mmbMEhbFIhsa7rE/t1rrTUY1sRFI8GdWpmaeK0g==
X-Received: by 2002:a17:90b:3ec1:b0:38e:7168:281 with SMTP id
 98e67ed59e1d1-396d0f2dcd8mr6908508a91.10.1787896256905; 
 Thu, 27 Aug 2026 22:50:56 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396ddc07777sm1228032a91.12.2026.08.27.22.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 22:50:56 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:50:42 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] accel/rocket: Collect job dependencies before
 arming
Message-ID: <apEhmia-SLEe-39S@rock-5b-plus>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-3-Naixumogu@whut.edu.cn>
 <apEggyjyM9yCqg4A@rock-5b-plus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apEggyjyM9yCqg4A@rock-5b-plus>
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

On Fri, Aug 28, 2026 at 02:46:16PM +0900, Sidong Yang wrote:
> On Fri, Aug 28, 2026 at 01:08:04PM +0800, MoGGuU wrote:
> > rocket_job_push() arms the scheduler job before collecting its implicit
> > dependencies. Dependency collection can fail with -ENOMEM, but an armed
> > job must be pushed and must not be aborted with drm_sched_job_cleanup().
> > 
> > Collect dependencies before taking the scheduler lock and arming the job.
> > Only operations that cannot fail remain after drm_sched_job_arm().
> > 
> > Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> > Cc: stable@vger.kernel.org
> > Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> > Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> > ---
> >  drivers/accel/rocket/rocket_job.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> > index e6052d1973afa..b55e12aecfe64 100644
> > --- a/drivers/accel/rocket/rocket_job.c
> > +++ b/drivers/accel/rocket/rocket_job.c
> > @@ -206,19 +206,21 @@ static int rocket_job_push(struct rocket_job *job)
> >  	if (ret)
> >  		goto err;
> >  
> > +	ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count,
> > +					   &job->base, false);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> > +	ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count,
> > +					   &job->base, true);
> > +	if (ret)
> > +		goto err_unlock;
> > +
> >  	scoped_guard(mutex, &rdev->sched_lock) {
> >  		drm_sched_job_arm(&job->base);
> >  
> >  		job->inference_done_fence = dma_fence_get(&job->base.s_fence->finished);
> >  
> > -		ret = rocket_acquire_object_fences(job->in_bos, job->in_bo_count, &job->base, false);
> > -		if (ret)
> > -			goto err_unlock;
> > -
> > -		ret = rocket_acquire_object_fences(job->out_bos, job->out_bo_count, &job->base, true);
> > -		if (ret)
> > -			goto err_unlock;
> > -
> >  		kref_get(&job->refcount); /* put by scheduler job completion */
> >  
> >  		drm_sched_entity_push_job(&job->base);
> > -- 
> > 2.43.0
> > 
> 
> Reviewed-by: Sidong Yang <sidong.ynag@furiosa.ai>

Sorry, I typo'd my address in the previous mail. It should be:

Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
