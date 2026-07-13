Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66114C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2F810E8EA;
	Mon, 13 Jul 2026 10:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="c4zTWLv/";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B449810E8E8
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:26:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D099F1595;
 Mon, 13 Jul 2026 03:26:26 -0700 (PDT)
Received: from [10.57.38.127] (unknown [10.57.38.127])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C7443F93E;
 Mon, 13 Jul 2026 03:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783938391; bh=04xZMJnBelVENru/c5P5UPci9ykz8dARVkJnOV/fkXg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=c4zTWLv/yXkwaKmdcBzo0IjA+5rtp7XJ4AlHZwo6S4QfXwG61/cxOfGE/x77JqWUm
 cX/eCFNgimY5BO2cX6JRbbdk3L0faZQ5RZA0+bfa2w4D3D3Z3/qFRV9P9Y17RH+pfp
 HPf9cNq6o/NPY0YUDrZeMojKk6b7ow7IriQ4omqU=
Message-ID: <9a0f4153-29fb-43ce-9f1b-d1c762242d78@arm.com>
Date: Mon, 13 Jul 2026 11:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Remove unused scheduled_jobs list
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?=
 <adrian.larumbe@collabora.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260710121423.2820472-2-mcanal@igalia.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260710121423.2820472-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8
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

On 10/07/2026 13:14, Maíra Canal wrote:
> The scheduled_jobs list head was introduced in commit f3ba91228e8e
> ("drm/panfrost: Add initial panfrost driver") but never used. Remove the
> dead field and its initialization.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 1 -
>  drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 7fed22d555a5..d0a23c51be39 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -218,7 +218,6 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>  	int err;
>  
>  	mutex_init(&pfdev->sched_lock);
> -	INIT_LIST_HEAD(&pfdev->scheduled_jobs);
>  	INIT_LIST_HEAD(&pfdev->as_lru_list);
>  
>  	spin_lock_init(&pfdev->as_lock);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index ec55c136b1b6..1fe1554f2652 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -156,7 +156,6 @@ struct panfrost_device {
>  	struct panfrost_job_slot *js;
>  
>  	struct panfrost_job *jobs[NUM_JOB_SLOTS][2];
> -	struct list_head scheduled_jobs;
>  
>  	struct panfrost_perfcnt *perfcnt;
>  	bool profile_mode;

