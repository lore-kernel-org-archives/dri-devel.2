Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AC3C61DC4
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 02:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C7DD10E448;
	Fri, 28 Aug 2026 02:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="ChTsp/0o";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0E610E448
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 02:03:24 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2caea3f742bso8877665ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 19:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1787882604; x=1788487404; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pTlKUEzQEa7Rn+0hDVYmAqWQKbByFTTyOUa8CoMUQEQ=;
 b=ChTsp/0oM0fGygzAc5Nf23m+fgUbZ49aGDA9Yg3wu7KReU9bPxQX8xIu0UcrTjaR+h
 LZ/lYbTe40pgoGNQ09QecXcvNs9ks1Dk1MPCeG8ePvOBU2huc6c+eH0YEgwcoyRhwKM9
 Z9myFVkBjIhX1xkc9y6WtmkrJqWqCdAlnbhx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787882604; x=1788487404;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pTlKUEzQEa7Rn+0hDVYmAqWQKbByFTTyOUa8CoMUQEQ=;
 b=tHJ5RapHfUDST1xc+1oiprdKWHdy+Cv6zwELJLhJWsuvOiNl1l5ULn8oFS5ALEfeUt
 9MXKFdFx7DS9/ya0O9kRK9i5JqTMGGfCwcziO3TOmJPyRTwP42WB85YHTGP9uwIG1IJJ
 ZMxxmZbjjnqJTGr/hILUk3fWmi1ri/zyC1aB5Pt3RcZjXBUuSPXqgV/BJayzEd5/HkRB
 gJ/VgpvtaVzjlJ33aCWQ7/qgCH6E5M3ONJO5C9JSblY8G5/0MXYHNRxtwc9eY+7ceQQk
 RNgaYw/oQD1jD+Xu2/3J9WjTdln72CAtG7mahDnc03GsCyHjMOjty+oTYeKk59NzDT9g
 moCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYS12/kq2bmigjT7LsuSO+jU7WEvN/Nv4EHwzusijuZ8Uu7hwSb0OsFEZV/Vl17msounhocm3k3SU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kGzNbPOC3waP3o0sdBwpVHyPEOneRGXSCx/3qyLw7LZ3opxsGV
 mX6WNXM9OMCmIlIU3EROzDFKGH//wIi0G2xqlBE9M4ZK0VJWtzuLwv7yYV8vqYcuRSk=
X-Gm-Gg: AR+sD11Wq4+/paGo/njXrD8acBhDhkRqmPqd3zhgHsljl73G3NzNQkp16PbUgVvpAto
 HQos7p55h236+jhFxkRB13aOwOmx+YuYauq0S5cR9RCSqZEsQQUDcKK/P3f6L14XDOPbaixNMsg
 1Cb3S9mekeW8tKPsguzBt0IhWO9Be/ckkl9S+4q6RwJhw0d5z6dO/i/mHwG3OkUWvHF1i9YQ3QJ
 jsHTlpb8A+VhnRNfRU9RvxasNMaePxF7/eOMC6UWsWeJRSQeFZMiT4uycZnCYy4tiXIdtWIkGI8
 dJIfqvABY+XhtzRE1Bss5WXB1OH9pJxglC4Nq6Lv7/i/ft/or+42+AFhpCBiGdftJuq0eptMiKl
 0jZL7nPMX2YlAeU0KzTU4TeDu5Xydxk6mqgiPY0hTn/VtpHKHH+V/v3g9gOWxmQDerDp2v0+fUX
 xR5ObGua+qEvXRwL7TZ8PyVUVFpUmS95s+6iybPSbiclTIUEZYMVdEPeVXgULIfipME1e3wqL3u
 g==
X-Received: by 2002:a17:902:d484:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2d74ddddc11mr64753975ad.7.1787882604255; 
 Thu, 27 Aug 2026 19:03:24 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7598c1cb4sm813515ad.81.2026.08.27.19.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 19:03:23 -0700 (PDT)
Date: Fri, 28 Aug 2026 11:03:02 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] accel/rocket: Validate BO handle counts on job
 submission
Message-ID: <apDpz4j2y2_8_pOd@rock-5b-plus>
References: <20260827170608.39511-1-Naixumogu@whut.edu.cn>
 <20260827170608.39511-2-Naixumogu@whut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827170608.39511-2-Naixumogu@whut.edu.cn>
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

On Fri, Aug 28, 2026 at 01:06:06AM +0800, MoGGuU wrote:
> The input and output BO handle counts are __u32, while GEM lookup and
> reservation helpers take int counts. A count above INT_MAX, or a combined
> count above INT_MAX, cannot be represented safely at those call sites.
> 
> Reject such counts before looking up the BOs.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org
> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index bb77b6bf0f231..7e3d123afc5ad 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -556,6 +556,12 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
>  	if (job->task_count == 0)
>  		return -EINVAL;
>  
> +	/* GEM lookup and reservation helpers take signed object counts. */
> +	if (job->in_bo_handle_count > INT_MAX ||
> +	    job->out_bo_handle_count > INT_MAX ||
> +	    job->in_bo_handle_count > INT_MAX - job->out_bo_handle_count)

I think checking in/out is okay but the sum of in/out would be checked with check_add_overflow()
in rocket_job_push(). But it only caches overflow UINT_MAX because bo_count is u32. It seems that it
would be good to change bo_count to int.
ㅏ

> +		return -EINVAL;
> +
>  	rjob = kzalloc_obj(*rjob);
>  	if (!rjob)
>  		return -ENOMEM;
> -- 
> 2.43.0
> 
