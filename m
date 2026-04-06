Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D4DF46C45
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7099F897FD;
	Mon,  6 Apr 2026 15:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZCvIG7SX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916E3897FD
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7Yb3KE25wEideBvF4KofmK4Q/AKeisOXZQtxM6N2BMA=; b=ZCvIG7SXmMS5/XbBZ5EE2kY5ST
 V0bpjf/dF/0sVWPNh4y/fFSna37f9fk3wR36v+eF36njGnumdaygSSteGrIYQF8aTXoldjP5oFoms
 73VKg4JxL69ly8v/He849UWvXKFY053Q1TfBSxFUTtqS/dvtHT2D2aHoH5xkPnEKqoQG3cAoh1FQS
 MfK2WSjj8mgDsxXlFtDAF5jV1LUUd2lrhT1AGLr5ILz+4Lf5c4BuGuJAFNj1Rm0NCtF+ysGNNCqmc
 p8HC8cCbQbBVJhYqNCFL3X7HLp8eZjH5a4M7SNTBL/JF6qjBnDZHCk4T4jpyF7G6MU5lOEx3mJTWh
 CJU+AyFQ==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w9lQy-00Cc1V-9X; Mon, 06 Apr 2026 17:00:12 +0200
Message-ID: <945bb0fa-e4e2-4be8-8d4b-0c83b4fc6c4f@igalia.com>
Date: Mon, 6 Apr 2026 16:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/vc4: Refcount vc4_file for safe access by jobs
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
 <20260402-vc4-drm-scheduler-v2-4-d84afd35c602@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260402-vc4-drm-scheduler-v2-4-d84afd35c602@igalia.com>
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


On 02/04/2026 19:36, Maíra Canal wrote:
> This is a preparation commit for per-file descriptor seqno tracking,
> which will require the struct vc4_render_job to store a pointer to
> vc4_file. Since the scheduler's free_job callback runs asynchronously,
> it can execute after vc4_close() has already freed the vc4_file, causing
> a use-after-free.
> 
> Add kref-based reference counting to vc4_file so that jobs can safely
> take a reference at submit time via vc4_file_get() and drop it in their
> free callback via vc4_file_put().
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_drv.c | 23 +++++++++++++++++++++--
>   drivers/gpu/drm/vc4/vc4_drv.h |  4 ++++
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index cacd4cb942593b44f2210b7738bd964ebc34522d..d0e515c900af6e7400a96e42a9141dab5d5bca2d 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -167,6 +167,7 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
>   			goto err_sched;
>   	}
>   
> +	kref_init(&vc4file->refcount);
>   	vc4_perfmon_open_file(vc4file);
>   	file->driver_priv = vc4file;
>   
> @@ -180,6 +181,25 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
>   
>   }
>   
> +static void vc4_file_release(struct kref *ref)
> +{
> +	struct vc4_file *vc4file = container_of(ref, struct vc4_file, refcount);
> +
> +	vc4_perfmon_close_file(vc4file);

Access of vc4->active_perfmon is not clear to me. When I was looking at 
the earlier patches I assumed it is protected by the run_job / 
workqueue. But from the angle of a delayed vc4_file release I am not 
sure why it is safe.

vc4_perfmon_close_file
   -> vc4_perfmon_delete

	/* If the active perfmon is being destroyed, stop it first */
	if (perfmon == vc4->active_perfmon)
		vc4_perfmon_stop(vc4, perfmon, false);

Why is vc4->active_perfmon stable here? Something guarantees the 
perfmons belonging to this file (vc4file->perfmons) will not be in the 
xarray any longer if it was the active one?

> +	kfree(vc4file);
> +}
> +
> +struct vc4_file *vc4_file_get(struct vc4_file *vc4file)
> +{
> +	kref_get(&vc4file->refcount);
> +	return vc4file;
> +}
> +
> +void vc4_file_put(struct vc4_file *vc4file)
> +{
> +	kref_put(&vc4file->refcount, vc4_file_release);
> +}

I'd be temped to "static inline" the above two in a header file 
(avoiding trivial function calls) but up to you.

Regards,

Tvrtko

> +
>   static void vc4_close(struct drm_device *dev, struct drm_file *file)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
> @@ -195,8 +215,7 @@ static void vc4_close(struct drm_device *dev, struct drm_file *file)
>   	for (q = 0; q < VC4_MAX_QUEUES; q++)
>   		drm_sched_entity_destroy(&vc4file->sched_entity[q]);
>   
> -	vc4_perfmon_close_file(vc4file);
> -	kfree(vc4file);
> +	vc4_file_put(vc4file);
>   }
>   
>   DEFINE_DRM_GEM_FOPS(vc4_drm_fops);
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index b828c56f98965944b94a330e6c4e5ff95c9ab8f8..2a331dd053cab1e55476cb028f399a5d25eb4309 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -898,6 +898,8 @@ struct vc4_exec_info {
>   struct vc4_file {
>   	struct vc4_dev *dev;
>   
> +	struct kref refcount;
> +
>   	struct xarray perfmons;
>   
>   	struct drm_sched_entity sched_entity[VC4_MAX_QUEUES];
> @@ -1083,6 +1085,8 @@ static inline void vc4_debugfs_add_regset32(struct drm_device *drm,
>   #endif
>   
>   /* vc4_drv.c */
> +struct vc4_file *vc4_file_get(struct vc4_file *vc4file);
> +void vc4_file_put(struct vc4_file *vc4file);
>   void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index);
>   int vc4_dumb_fixup_args(struct drm_mode_create_dumb *args);
>   
> 

