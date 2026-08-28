Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EC0C61DCD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA8D10F245;
	Fri, 28 Aug 2026 05:45:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="XTUjkUob";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE9710F245
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:45:14 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so1168480a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 22:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1787895914; x=1788500714; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mfUcgIwCJiYcPweMkIb+GXJK0j3pn/tPAjbOK4olTtY=;
 b=XTUjkUobsLxz6MyLLMHk6JneeClJJoH5NtJMC3kyJx5p4xYPGoSGF2RXQfWJVi3S8F
 uAe2jDKUvpbcViLBtBxACMJ7hAGV0/so7GMJANaofAT6SWHI1zy830DFt/KofEiBzRSz
 epIz5BDKAFtSKeGVIFu5HDN7y2AqtaAmt9ZY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787895914; x=1788500714;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mfUcgIwCJiYcPweMkIb+GXJK0j3pn/tPAjbOK4olTtY=;
 b=hynbTpse3+A/ipodT9BVa62/mgVPx+PgIWl+UKjO9/xN78Cq/y4Pf6k+4EEsuo/oLR
 Uy1Y/m1D1qF6a9qnuzNY44ji//n424xrdWOqNs2aToGLgJ8+YLqTyhAo0E63mwftXHpx
 J3Dw9GdVuZX8cGTjQ4mbu/g2ZlJAz8jtk26v7XvO6nr3vCJkIUI+klH6OHo3Sjg4VA6e
 8MTjoc3Xos79DDYyTEL9LQKGxkXb4Dj34mQHw3uL98jfsiErSyi9CwR24pnLnX+I3T9w
 9C/6/F9m+o3sycsjDk/L7LtNtFSq6UQ3xz7jkzCR9T9y4q9nJzJwCthB52QFbOCjcfc+
 n6iQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8QLINneUvDvb/GM7QnUZyf9oUlYzgeQXuhgYEa0I1yiDP1o355MVn5l8240ks1ePk4bP3dK4lRsE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nbJpmw/JO2Yww0jidNjXMkuSZp0CJKfcq97k6fDnFZejGyoTL+
 HersmIJYcDb7QaawjZHQa4KXPiHvPXZsn4TEeo8tY4RkrQs0julrSTMcHcllLNwsBtE=
X-Gm-Gg: AR+sD11HvJoZTODAlyPQh9QZ8fyGL4xP2FfuNLXXYLhL65WePMSXd3V07+taTpcxFyL
 60K2ky2Xd6XKphRPgGhuOFNvHRmwFdK3RnQPQaIxM2pPKX8PW2QluYowFkkoVYauuY1TNmID5pB
 XOYUeKHTpAU1Zehy7exmUfMi9f5bu30LKlKJQcWfRvjZKA+EYhKZtQIfrYzWJwcxIAth4Oo0xBD
 Fooig6Qk4dauFknxl0gPEVMIBx9KOZY99CW+NMgNcgW9N9AnZAeEFWlys1oM1JleWqSKumokfvp
 ad6krEIWfDDbpdnWCmGWWF5Z4/ujV/eUegkpIu9MCxsqRgeG1IalZFi5Lrl2veqf3IMNMwDGI9d
 eDNq0wjTVdOOVo/YM/yQRV+KPpgGU3DsvG/Dh4zziYChWSMJb5nLhT06wu8V13KxEWDfX9e24Ua
 k5sIfoCvOEOPIsxl7wLEPZESVz+NlstXFgyvJ/xJj/eMgnT7h6Vu8Ggd4qT2opppc=
X-Received: by 2002:a17:90b:380c:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-396d0ef3c2cmr8708512a91.12.1787895913751; 
 Thu, 27 Aug 2026 22:45:13 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396dda368e6sm1107298a91.4.2026.08.27.22.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 22:45:13 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:44:52 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] accel/rocket: Validate BO handle counts on job
 submission
Message-ID: <apEfoHtWdtSkSW3s@rock-5b-plus>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-2-Naixumogu@whut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828050805.38548-2-Naixumogu@whut.edu.cn>
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

On Fri, Aug 28, 2026 at 01:08:03PM +0800, MoGGuU wrote:
> The input and output BO handle counts are __u32, while GEM lookup and
> reservation helpers take int counts. A count above INT_MAX cannot be
> represented safely by the GEM lookup helper.
> 
> Reject each count above INT_MAX before looking up the BOs.
> 
> rocket_job_push() already uses check_add_overflow() for the combined count,
> but stores the result in u32, so it only detects unsigned wraparound. Store
> the result in int so sums above INT_MAX are rejected before the count is
> passed to the reservation helpers.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index bb77b6bf0f231..e6052d1973afa 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -190,7 +190,7 @@ static int rocket_job_push(struct rocket_job *job)
>  	struct rocket_device *rdev = job->rdev;
>  	struct drm_gem_object **bos;
>  	struct ww_acquire_ctx acquire_ctx;
> -	u32 bo_count;
> +	int bo_count;
>  	int ret = 0;
>  
>  	if (check_add_overflow(job->in_bo_count, job->out_bo_count, &bo_count))
> @@ -556,6 +556,11 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
>  	if (job->task_count == 0)
>  		return -EINVAL;
>  
> +	/* GEM lookup takes a signed object count. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX)
> +		return -EINVAL;
> +
>  	rjob = kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;
> -- 
> 2.43.0
> 

Looks good now, thanks.

Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
