Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B89109E535
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 01:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA3110E1C2;
	Thu, 26 Mar 2026 01:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QvJaHRlY";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CA910E1BB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 01:54:13 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-82a67ce6969so358619b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774490053; x=1775094853;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xcdp7IsK8iyD34L5HISg9Ao7kXj1r2bEu5hpo8TsYx0=;
 b=QvJaHRlYINeh+IQg1t1Kk8CVQmsDTUdVzh+AlG5ZYsOrcRlsge4lPIzyAfaUI+836c
 8otGUuOoTbWP0N67b9vY14bJ5C3UsbScVFlRVOPND5CSuFtnFlWSmypwVCwom/QzE8F8
 AiFbpclNuJyTvTrr78s/I1ZC9K11nO+6yCxVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774490053; x=1775094853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xcdp7IsK8iyD34L5HISg9Ao7kXj1r2bEu5hpo8TsYx0=;
 b=DdjYTlJ7qm1KHdWtjPNsDgfWAX/c7MyYqFONpVnFnAAsvOgBLy3HaxqMU7BgBaf3dI
 7cpaJWltM0WdAqXsObqjSEVHI+peSMeL37N7/gb7Q3m7xUHu4knBA+2n2phsRWakG8uS
 J9Mi3g2eLXovtS4G6A+l4ZrdQom9gZ+WQOqLCCJonWOZCqO8l7Df6BLSzDaLvkG+XtA6
 FSqcWklB7S3FFcNDc0ZzSOyFdu7KTqGkp1otglYot5uJ5D/cAiDMSCTj0JGXPCr6hbCn
 SPXGDTBRUr0aVY4de3nHr6JQHbnFGMuSnXw4OxFov+6GHZRumjSUs5i/v3f0IH73JYky
 IKtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb1SPNMM9Pw7F3FkHOKS1epGtJ01RIU2xwfjRGdckT/D9lIrHNkFSUPb9maKhnB2if2zhyUNCGMfI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyS3lozl5Zs1c/uiun1H3wKkiG/WV6WuXEJnvJxJR6em6/XhL5y
 hYgs2YiQFeCatg2MOsDm3fk+tcsibw9WP2CuKMdewf9U13/TqGc18hHsSVdMzjxsCQ==
X-Gm-Gg: ATEYQzyv6owOSuwBaGKW6MuA8TiA0Mle1+5ndoycwpO/xMaYu5fyeG8cwHcx4ioxrHn
 dOF8luKymOyhcQYqIz6LjErLDy49wsFI/fiy3GQzaWWFIJxxbLU4TkGMxb7mfzJw1FF5pyC6U6M
 MquAqU/laLUM7hJdbgf3g/mEtUuwVHkYKjQ/+z1vGnYIUXWnYzb6Mtase2wFB5y/gjggTbxGkac
 cNcKfe25ik/YCvB1sQu7eFXCPKl79ZLmrN1Ydotygv5tDiJfKfkGJ73bCOrlsCykYL4J3rzLDnk
 ws+qI0MKmC+iv/m/tOZZA890VszBHcJwgeFtcubwvqF5yQiKg5v99VWUoxfUVUuWH4681gthdUF
 /oEoHwVp2p8KfEmowhvk6LO1hNQiAAp+jYrTiYb3sHUhiOXy8+2yDP544u18IHQqhRL41wxG0XR
 nCHbODWCclv8Xh2jrRKxCWYcJQLd0X+GLmo5NA3u/2H/htN5DSkfefpcy3IHLqkYg=
X-Received: by 2002:a05:6a00:390b:b0:82a:687e:c048 with SMTP id
 d2e1a72fcca58-82c6df8e77bmr5314949b3a.30.1774490052823; 
 Wed, 25 Mar 2026 18:54:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:bba3:6463:d2dc:395a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d390979sm947769b3a.32.2026.03.25.18.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 18:54:12 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:54:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH] drm: gpu: msm: forbid mem reclaim from reset
Message-ID: <acSRDNA8fCP7qAFJ@google.com>
References: <20260127073341.2862078-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127073341.2862078-1-senozhatsky@chromium.org>
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

On (26/01/27 16:33), Sergey Senozhatsky wrote:
> We sometimes get into a situtation where GPU hangcheck fails to
> recover GPU:
> 
> [..]
> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): hangcheck detected gpu lockup rb 0!
> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): completed fence: 7840161
> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): submitted fence: 7840162
> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): hangcheck detected gpu lockup rb 0!
> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): completed fence: 7840162
> msm_dpu ae01000.display-controller: [drm:hangcheck_handler] *ERROR* (IPv4: 1): submitted fence: 7840163
> [..]
> 
> The problem is that msm_job worker is blocked on gpu->lock
> 
> INFO: task ring0:155 blocked for more than 122 seconds.
> Not tainted 6.6.99-08727-gaac38b365d2c #1
> task:ring0 state:D stack:0 pid:155 ppid:2 flags:0x00000008
> Call trace:
> __switch_to+0x108/0x208
> schedule+0x544/0x11f0
> schedule_preempt_disabled+0x30/0x50
> __mutex_lock_common+0x410/0x850
> __mutex_lock_slowpath+0x28/0x40
> mutex_lock+0x5c/0x90
> msm_job_run+0x9c/0x140
> drm_sched_main+0x514/0x938
> kthread+0x114/0x138
> ret_from_fork+0x10/0x20
> 
> which is owned by recover worker, which is waiting for DMA fences
> from a memory reclaim path, under the very same gpu->lock
> 
> INFO: task ring0:155 is blocked on a mutex likely owned by task gpu-worker:154.
> task:gpu-worker state:D stack:0 pid:154 ppid:2 flags:0x00000008
> Call trace:
> __switch_to+0x108/0x208
> schedule+0x544/0x11f0
> schedule_timeout+0x1f8/0x770
> dma_fence_default_wait+0x108/0x218
> dma_fence_wait_timeout+0x6c/0x1c0
> dma_resv_wait_timeout+0xe4/0x118
> active_purge+0x34/0x98
> drm_gem_lru_scan+0x1d0/0x388
> msm_gem_shrinker_scan+0x1cc/0x2e8
> shrink_slab+0x228/0x478
> shrink_node+0x380/0x730
> try_to_free_pages+0x204/0x510
> __alloc_pages_direct_reclaim+0x90/0x158
> __alloc_pages_slowpath+0x1d4/0x4a0
> __alloc_pages+0x9f0/0xc88
> vm_area_alloc_pages+0x17c/0x260
> __vmalloc_node_range+0x1c0/0x420
> kvmalloc_node+0xe8/0x108
> msm_gpu_crashstate_capture+0x1e4/0x280
> recover_worker+0x1c0/0x638
> kthread_worker_fn+0x150/0x2d8
> kthread+0x114/0x138
> 
> So no one can make any further progress.
> 
> Forbid recover/fault worker to enter memory reclaim (under
> gpu->lock) to address this deadlock scenario.
> 
> Cc: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>


Folks, can somebody please review/pickup this patch?  It solves a real
(deadlock) problem that we observe in the field.

// keeping the patch body just in case

> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 995549d0bbbc..ddcd9e1c217a 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -17,6 +17,7 @@
>  #include <linux/string_helpers.h>
>  #include <linux/devcoredump.h>
>  #include <linux/sched/task.h>
> +#include <linux/sched/mm.h>
>  
>  /*
>   * Power Management:
> @@ -469,6 +470,7 @@ static void recover_worker(struct kthread_work *work)
>  	struct msm_gem_submit *submit;
>  	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
>  	char *comm = NULL, *cmd = NULL;
> +	unsigned int noreclaim_flag;
>  	struct task_struct *task;
>  	int i;
>  
> @@ -506,6 +508,8 @@ static void recover_worker(struct kthread_work *work)
>  			msm_gem_vm_unusable(submit->vm);
>  	}
>  
> +	noreclaim_flag = memalloc_noreclaim_save();
> +
>  	get_comm_cmdline(submit, &comm, &cmd);
>  
>  	if (comm && cmd) {
> @@ -524,6 +528,8 @@ static void recover_worker(struct kthread_work *work)
>  	pm_runtime_get_sync(&gpu->pdev->dev);
>  	msm_gpu_crashstate_capture(gpu, submit, NULL, comm, cmd);
>  
> +	memalloc_noreclaim_restore(noreclaim_flag);
> +
>  	kfree(cmd);
>  	kfree(comm);
>  
> @@ -588,6 +594,7 @@ void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_
>  	struct msm_gem_submit *submit;
>  	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
>  	char *comm = NULL, *cmd = NULL;
> +	unsigned int noreclaim_flag;
>  
>  	mutex_lock(&gpu->lock);
>  
> @@ -595,6 +602,8 @@ void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_
>  	if (submit && submit->fault_dumped)
>  		goto resume_smmu;
>  
> +	noreclaim_flag = memalloc_noreclaim_save();
> +
>  	if (submit) {
>  		get_comm_cmdline(submit, &comm, &cmd);
>  
> @@ -610,6 +619,8 @@ void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_
>  	msm_gpu_crashstate_capture(gpu, submit, fault_info, comm, cmd);
>  	pm_runtime_put_sync(&gpu->pdev->dev);
>  
> +	memalloc_noreclaim_restore(noreclaim_flag);
> +
>  	kfree(cmd);
>  	kfree(comm);
>  
> -- 
> 2.53.0.rc1.217.geba53bf80e-goog
> 
