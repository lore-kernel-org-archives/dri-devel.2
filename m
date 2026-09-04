Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8AAC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3A110E1CA;
	Fri,  4 Sep 2026 15:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="VYceCvU4";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A218810E1CA
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 15:00:45 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3969e82ff8fso1189135a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1788534045; x=1789138845; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BC8xeNc2okLWoyrNypTJfEB3etD6w4HkNrLeoChjYjY=;
 b=VYceCvU4kyyL44gbpHnli/zHxhlrGzTWCPFgZK0IzFNvOHb6SFK6l8mEkATA1wIjNX
 5ezwoZh8vI7ZmiyKbLYaV5ppW3KFa7XVSR6lUSDlF+Wia1uu0GbTQfQSl0gM8DYXH4hT
 u39G+Q8z6QyHz90psueiemA+oY+tp8JLmYbdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788534045; x=1789138845;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BC8xeNc2okLWoyrNypTJfEB3etD6w4HkNrLeoChjYjY=;
 b=ahuVdfCZmY8aHpXw16Ydlnex5xMTYjj1fwrTLJRqGDKBL620V9t6xuctv61z28Z/MQ
 Qkcx2DwTc14rbN+0V0D/LsftNro3CO1UbVsrt7u2D+es5TqTCLwSnZqIb9+1lweUBx4t
 nIyn4yQ+5kxDYg4j7/dY0t6hWt6KK2KV2HNpkZCdxaUxUEDPAhzvaIXdscjyB06IJ7kp
 VzanDR3/3CAvC76k6zub8jq/ry+VhxVgjw99dL79KQP3AGE/F9dxpUzZZ4ftv3jGLfnr
 OgsQCrSvr8/6UaJRWuf3eYSqh5EouVCBjjuSFiuLAAL8wFUCXZrSOsAbMn2knTNxkmBE
 755g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxojXc1GeTVO++ljvmvoJKvTA2zeosyzrExyBE9tLdXaWqGZQD/SRtMsZCJcJwiSmFCGi7WOggJp3o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lTnzUp9lGPXkU3vr6h24RuXjjwQXx5PWLDVatebHfH2IQGjE1E
 krX+pjWmlxAhheOlg1BR//aiTiAuCeqI16itgp695kvAUApqnAo3+XSR/b8pzA82bEs=
X-Gm-Gg: AYBFou0Unkl50pITAQaV1gW2TBtlnpOuKvBN1vtXW51nUwaILMPdyMSHMeyoIrNCRpo
 AI602QrXV2iw0Z1HQH+u9w6zfOi22rmtFEFsodjs2HlKFC3dk3xz54d56KChfs4PLJMvD7yyIRl
 1jVk22ZAri21mIIb+NkgnE9oomQqPWBObaHGDUbigZp4WpE/k4XTP7qJpAJDTlXvLXS7h2W5u49
 KmZS/5roP/Xl7YcfZ3ziJu/+05WK3AYocPw3N5ceYWQLeFR+izSsRgXsbmqda9bq3Zr0UsNx9Wk
 zBrSvDpuhuIox0kgN+T6sm7ULhp1gVPQyk0BE1BXlqqRWyAZ5uAYn5enU/mDkO8bu8mMpULJBVa
 YLIgbmv6VwF727oitmwN304Ku8rVb1Y/tCk5Dn/bzNY4vD1KV5IrHt7RmvSvQjKO5/wdFyUavBr
 x7CBsWuLnFxjsVseUHiI+bgt5gxYjfJoz2CCcaPSH086BRk+L3FWTMHLPF23YHKA==
X-Received: by 2002:a17:90b:582d:b0:399:e97:8d5a with SMTP id
 98e67ed59e1d1-39b2627fe18mr9810550a91.25.1788534044869; 
 Fri, 04 Sep 2026 08:00:44 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1497d4dbsm10522755ad.33.2026.09.04.08.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 08:00:44 -0700 (PDT)
Date: Sat, 5 Sep 2026 00:00:16 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Ross Cawston <ross@r-sc.ca>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] accel/rocket: Add per-task flags and interrupt mask
 to UAPI and kernel
Message-ID: <aprXAS8mkycmfM2n@rock-5b-plus>
References: <20260217-accel-rocket-clean-base-v1-0-d72354325a25@r-sc.ca>
 <20260217-accel-rocket-clean-base-v1-3-d72354325a25@r-sc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-accel-rocket-clean-base-v1-3-d72354325a25@r-sc.ca>
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

On Tue, Feb 17, 2026 at 01:39:51PM -0800, Ross Cawston wrote:
> Add two new fields to struct drm_rocket_task (UAPI) and struct rocket_task
> (kernel):
> 
> - u32 int_mask: which block completion interrupt(s) should signal task done
> - u32 flags: currently only ROCKET_TASK_SKIP_CNA_CORE
> 
> In rocket_copy_tasks():
> - copy the new fields
> - default int_mask to DPU_0 | DPU_1 when userspace passes zero (backward compatible)
> 
> No functional change yet - old userspace continues to work unchanged.
> 
> Signed-off-by: Ross Cawston <ross@r-sc.ca>
> ---
>  drivers/accel/rocket/rocket_job.c |  8 ++++++++
>  drivers/accel/rocket/rocket_job.h |  2 ++
>  include/uapi/drm/rocket_accel.h   | 25 +++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index 369b60805d5f..34898084cc56 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -96,6 +96,14 @@ rocket_copy_tasks(struct drm_device *dev,
>  
>  		rjob->tasks[i].regcmd = task.regcmd;
>  		rjob->tasks[i].regcmd_count = task.regcmd_count;
> +		rjob->tasks[i].int_mask = task.int_mask;
> +		rjob->tasks[i].flags = task.flags;
> +
> +		/* Default to DPU completion if no mask specified */
> +		if (!rjob->tasks[i].int_mask) {
> +			rjob->tasks[i].int_mask = PC_INTERRUPT_MASK_DPU_0 |
> +									PC_INTERRUPT_MASK_DPU_1;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/accel/rocket/rocket_job.h b/drivers/accel/rocket/rocket_job.h
> index 4ae00feec3b9..6931dfed8615 100644
> --- a/drivers/accel/rocket/rocket_job.h
> +++ b/drivers/accel/rocket/rocket_job.h
> @@ -13,6 +13,8 @@
>  struct rocket_task {
>  	u64 regcmd;
>  	u32 regcmd_count;
> +	u32 int_mask;
> +	u32 flags;

Hi Ross,

This patch grows sizeof struct drm_rocket_task, and it would make error in
checking if it is bigger than job->task_struct_size in rocket_copy_tasks().
So, Old userspace application would get error.

Thanks,
Sidong

>  };
>  
>  struct rocket_job {
> diff --git a/include/uapi/drm/rocket_accel.h b/include/uapi/drm/rocket_accel.h
> index d0685e372b79..ae0d8e48afcd 100644
> --- a/include/uapi/drm/rocket_accel.h
> +++ b/include/uapi/drm/rocket_accel.h
> @@ -90,6 +90,11 @@ struct drm_rocket_fini_bo {
>  	__u32 reserved;
>  };
>  
> +/**
> + * Flags for drm_rocket_task.flags
> + */
> +#define ROCKET_TASK_SKIP_CNA_CORE		0x1
> +
>  /**
>   * struct drm_rocket_task - A task to be run on the NPU
>   *
> @@ -106,6 +111,26 @@ struct drm_rocket_task {
>  	 * buffer
>  	 */
>  	__u32 regcmd_count;
> +
> +	/**
> +	 * Input: Interrupt mask specifying which block completion signals
> +	 * that this task is done. Uses PC_INTERRUPT_MASK_* bits.
> +	 *
> +	 * For conv/DPU tasks: DPU_0 | DPU_1 (0x0300)
> +	 * For PPU tasks:      PPU_0 | PPU_1 (0x0C00)
> +	 *
> +	 * If zero, defaults to DPU_0 | DPU_1 for backwards compatibility.
> +	 */
> +	__u32 int_mask;
> +
> +	/**
> +	 * Input: Task flags.
> +	 *
> +	 * ROCKET_TASK_SKIP_CNA_CORE: Skip CNA and Core S_POINTER MMIO
> +	 * writes for this task. Used for standalone DPU element-wise
> +	 * and PPU pooling tasks that don't use CNA/Core.
> +	 */
> +	__u32 flags;
>  };
>  
>  /**
> 
> -- 
> 2.52.0
> 
