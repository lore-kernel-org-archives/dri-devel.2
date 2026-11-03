Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2F606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4ISw4ro
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7F810F59A;
	Tue,  3 Nov 2026 13:27:35 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9505A10F5A5
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:27:28 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so4342895e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793712447; x=1794317247; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=o7EFRwU3C9t44EpOq54u2QVurE4/iG5MM90/J7UPCIk=;
 b=e4ISw4roM+YFPLxEriQRmPAbETqQFOhA5AVTnj/PfyEbf2MMGZIWpUCiCeG1czpZ0w
 p8GCiwp9RDaW+kwu60cfpQKXFaM7zAyYVZyVwmi+HU0bPzT3Z+zgl5sRdtih/Ue5aU3p
 WUhSdx/ZP6ImCV/C6p68RJthRkxuub9ykM0xg5BIVUcNbMl2/j87iOB2qy4URvNqOR0H
 sgqFvu1WepZ9AT1zIHGl75dz2gTZoaNZ36kbpcGjDGcStTgUtguk6yYUDaFOn6bDzTXv
 XlQ4vzc3TngdFJMbrqk0nY2mbLAGA3JuLjP/zimdcgERybXW88yfZsrQgppexMTLR6ev
 W/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712447; x=1794317247;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o7EFRwU3C9t44EpOq54u2QVurE4/iG5MM90/J7UPCIk=;
 b=XTLH7CNB/4g+oQ6m0ZM0ZGPyOOGR1hwjxeAo4qjq1Q/uZcIOLcuZX89yFnDRU0UtcG
 6+LTapDI6TRKSFlELCJ5oFXaAPGk5i1/KTt1bQfLaXeejjxm7ruknRhp0HPWQc7gPmzv
 WqZ7tGRolsB8oidNqQ9MobQN8FCgDytCHMr9RhHu/KLGS/5T/2a9uX4fWUL3kNb0w1BA
 t6UoD0tUdc8NmOuJctI4KJFz9LGGeqaVxZLKbvX9WUQubavBJrT4sgSUibbbQtivmpUT
 PwS3cjCw3W5BtzooXJwW9PhqcZ5LNQolCpQqn1moaE09YuPVDJmhhW9baeIadt9DmqdZ
 lHgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBySqniXcdU7QyEAUSySWUmYn1qz6RxXzxgGcOcNEjJwrlzmnpPKkN47mzO1TbRSwfO5cI0vev3rTjU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/9viDctnIXlJ7qFng9ehjg9RS662REGhm88cXjuz8ccTuCjc4M
 olvCT71YH/kVBPwShH7Fce1w4yuZAVvYQVHtaJgOODWQmcySFsZ16Vg=
X-Gm-Gg: AYBFou3L6wFs0ZTC7NqWVr4OYyunyIkGg+xEZFNEAkvRot090C1tPphpz8hgGgRecwK
 8Mn/5G3/zWAyyO3gffFVPnfZoYb19+dRtHHaqKfI0AkrYmmem1vpteUbIEwuygA9txihkoyalbp
 Ul1PWBzs5wqr83CeR2GYUBha2I1I4Q20L38f9zcrMGsxg+s7KEEw8HguUXg86AawRr9muxrXfBC
 rep7ftiv7ws+eSB4Kh5McDy+anLCRrhwzEn/LDJK2iGLHcE6nHequ2QeCUjQt8/seb5oqzxtNKR
 dBCDhtL1PlC1OCLVHotJ58wHTCFwaOZsxf3Vj2Z6fR3JREWfNHv0LbjcMBO8vCwJ97h6GtoWoyg
 cxCzRqCaonl2s8XRaNr+f7moTxK/Q+CcnaS2mCALliIBlJxDPpafY7F5no3MX+qLWZMIuCKlX9G
 rsIJbYFJURbH1zfFzrWYE4fIIsOvip2yyR86eWQ6jX5wu3GfVozepr9t3aLEqCfSStnYw5o5gor
 BzGIAAEyX+3gUvq40CLQ4j+02jeVzT0MDDOy3dkdzLguynEGni2k0wXhXcnASb+/xDAy/zVIwi0
 58J7/DNEaUY39Ejo+7bJBxJORSYvfgWpli4GFiC3YnBymFZ7bLtBThnnGSHp+OJ8oLd9el55KXJ
 7ptfLd/+uyQ==
X-Received: by 2002:a05:600c:5246:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4ac16acd947mr312817415e9.4.1793712446545; 
 Tue, 03 Nov 2026 05:27:26 -0800 (PST)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm81672285e9.13.2026.11.03.05.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 05:27:24 -0800 (PST)
Message-ID: <40178c7a-8a2f-45e0-9afc-a54732082abd@gmail.com>
Date: Tue, 3 Nov 2026 14:27:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-4-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <20261102190010.720443-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 8:00 PM, Rob Clark wrote:
> We need to move the gpu lock around a bit for the next patch.  Use
> scoped_guard/etc so we don't have to make the error path handling more
> complicated.
>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++-------------------
>   1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
> index f12701e286ec..aa59b28a3392 100644
> --- a/drivers/gpu/drm/msm/msm_debugfs.c
> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
> @@ -70,43 +70,36 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
>   	struct drm_device *dev = inode->i_private;
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct msm_gpu *gpu = priv->gpu;
> -	struct msm_gpu_show_priv *show_priv;
>   	int ret;
>   
>   	if (!gpu || !gpu->funcs->gpu_state_get)
>   		return -ENODEV;
>   
> -	show_priv = kmalloc_obj(*show_priv);
> +	struct msm_gpu_show_priv *show_priv __free(kfree)
> +		= kmalloc_obj(*show_priv);
>   	if (!show_priv)
>   		return -ENOMEM;
>   
> -	ret = mutex_lock_interruptible(&gpu->lock);
> -	if (ret)
> -		goto free_priv;
> -
> -	pm_runtime_get_sync(&gpu->pdev->dev);
> -	msm_gpu_hw_init(gpu);
> -	show_priv->state = gpu->funcs->gpu_state_get(gpu);
> -	pm_runtime_put_sync(&gpu->pdev->dev);
> -
> -	mutex_unlock(&gpu->lock);
> +	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
> +		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
> +			msm_gpu_hw_init(gpu);
> +			show_priv->state = gpu->funcs->gpu_state_get(gpu);
> +		}
> +	}
>   
>   	if (IS_ERR(show_priv->state)) {
> -		ret = PTR_ERR(show_priv->state);
> -		goto free_priv;
> +		return PTR_ERR(show_priv->state);
>   	}
>   
>   	show_priv->dev = dev;
>   
>   	ret = single_open(file, msm_gpu_show, show_priv);
>   	if (ret)
> -		goto free_priv;
> +		return ret;
>   
> -	return 0;
> +	retain_and_null_ptr(show_priv);
>   
> -free_priv:
> -	kfree(show_priv);
> -	return ret;
> +	return 0;
>   }
>   
>   static const struct file_operations msm_gpu_fops = {

Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

