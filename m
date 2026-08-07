Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E566FC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E7E110E400;
	Fri,  7 Aug 2026 11:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TSB/8pgx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9996D10E400
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=TCYeUkfn88/4kpp3bfrVyj6uLJrSiN4vArQmwoZYHCU=; b=TSB/8pgxIsfxXVgczgtvfK2MAz
 beKGP2uVS6J4RO1JuemN9H43rS7Lbz2yvfx6T/p163+rwYHVjGZSENgRdT/HE6vwS7ttiRnAzb37Z
 K5NzCSd5TRX2U/fvPj+yjl5QAhT1PYk6OYlgHYz5+2r4DG4QHlUppHEYabRq03HIMfaXL+E/eeU9i
 k2JBAedQOEVmmcFgOH3vaIg4hF6lrPNsqnI2aHlAjTTZSQi2VEcU1aeoTSk+TLXNM54tjykwZAzjv
 w+kacHXrh0iKbOcff7p86X7qctx5OhYE2XGXVy5Z9upKjdcO6ShB5T4izr8ksX9Hbm3eIBBBx34m6
 4W2fHcAQ==;
Received: from [90.243.171.171] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wsIcP-00FOvV-VJ; Fri, 07 Aug 2026 13:20:06 +0200
Message-ID: <20962e6c-b4ca-48cf-9d4e-30184271ac5c@igalia.com>
Date: Fri, 7 Aug 2026 12:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] drm/vc4: Refcount vc4_file for safe access by jobs
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com>
 <20260712-vc4-drm-scheduler-v3-5-ed6dc4defa53@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260712-vc4-drm-scheduler-v3-5-ed6dc4defa53@igalia.com>
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


On 12/07/2026 16:14, Maíra Canal wrote:
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
>   drivers/gpu/drm/vc4/vc4_drv.c | 12 ++++++++++--
>   drivers/gpu/drm/vc4/vc4_drv.h | 17 +++++++++++++++++
>   2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index cacd4cb94259..6c49304301c9 100644
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
> @@ -180,6 +181,14 @@ static int vc4_open(struct drm_device *dev, struct drm_file *file)
>   
>   }
>   
> +void vc4_file_release(struct kref *ref)
> +{
> +	struct vc4_file *vc4file = container_of(ref, struct vc4_file, refcount);
> +
> +	vc4_perfmon_close_file(vc4file);
> +	kfree(vc4file);
> +}
> +
>   static void vc4_close(struct drm_device *dev, struct drm_file *file)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
> @@ -195,8 +204,7 @@ static void vc4_close(struct drm_device *dev, struct drm_file *file)
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
> index 255a95f55586..4f452ea3b4a6 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -905,6 +905,8 @@ struct vc4_exec_info {
>   struct vc4_file {
>   	struct vc4_dev *dev;
>   
> +	struct kref refcount;
> +
>   	struct xarray perfmons;
>   
>   	struct drm_sched_entity sched_entity[VC4_MAX_QUEUES];
> @@ -1092,6 +1094,21 @@ static inline void vc4_debugfs_add_regset32(struct drm_device *drm,
>   /* vc4_drv.c */
>   void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index);
>   int vc4_dumb_fixup_args(struct drm_mode_create_dumb *args);
> +void vc4_file_release(struct kref *ref);
> +
> +static inline
> +struct vc4_file *vc4_file_get(struct vc4_file *vc4file)
> +{
> +	kref_get(&vc4file->refcount);
> +	return vc4file;
> +}
> +
> +static inline
> +void vc4_file_put(struct vc4_file *vc4file)
> +{
> +	kref_put(&vc4file->refcount, vc4_file_release);
> +}
> +
>   
>   /* vc4_dpi.c */
>   extern struct platform_driver vc4_dpi_driver;
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

