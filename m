Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B67C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649DC10F3FB;
	Fri, 24 Jul 2026 15:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="X7sB2M2i";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6246E10F3FB
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:03:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4720D1684;
 Fri, 24 Jul 2026 08:03:27 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 554EE3F59E;
 Fri, 24 Jul 2026 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784905411; bh=JIA80y6x5zmkltcmAjM5ESJ0y04cKtcN4rQxkx0fHos=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=X7sB2M2iFpI9VO5bxKRUaTJWwAANkv1Q2e47wmcZmGGQ/w16YdBlVzt2dVqTXAQ0+
 qAQj0+Q4kn23ouDd4/0vatZvopFP6Kd0K2vTwDBq2PRN9glUtzHJk3ejl6zxeHfNdh
 FRjEy8Rft+yn0pUPLd+zRGbHrmUo290D7E2TT9DQ=
Message-ID: <8c7e3156-065e-4520-8870-ca25cd207a18@arm.com>
Date: Fri, 24 Jul 2026 16:03:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/panthor: Don't allocate protm_suspend_buf
To: Ketil Johnsen <ketil.johnsen@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
 <20260712135439.1546950-6-ketil.johnsen@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260712135439.1546950-6-ketil.johnsen@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 12/07/2026 14:54, Ketil Johnsen wrote:
> The PROTM suspend buffer is only needed if the group is going to
> use PROTM in the first place, so let's not assume we need one until
> we're being asked to.
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index dc77a174a3368..86c0f12b09e11 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3642,9 +3642,11 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
>  	if (drm_WARN_ON(&ptdev->base, ptdev != group->ptdev))
>  		return;
>  
> -	group->fdinfo.kbo_sizes += group->suspend_buf->obj->size;
> -	group->fdinfo.kbo_sizes += group->protm_suspend_buf->obj->size;
>  	group->fdinfo.kbo_sizes += group->syncobjs->obj->size;
> +	group->fdinfo.kbo_sizes += group->suspend_buf->obj->size;
> +
> +	if (group->protm_suspend_buf)
> +		group->fdinfo.kbo_sizes += group->protm_suspend_buf->obj->size;
>  
>  	for (i = 0; i < group->queue_count; i++) {
>  		queue =	group->queues[i];
> @@ -3724,14 +3726,6 @@ int panthor_group_create(struct drm_file *file,
>  		goto err_put_group;
>  	}
>  
> -	suspend_size = csg_iface->control->protm_suspend_size;
> -	group->protm_suspend_buf = panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_size);
> -	if (IS_ERR(group->protm_suspend_buf)) {
> -		ret = PTR_ERR(group->protm_suspend_buf);
> -		group->protm_suspend_buf = NULL;
> -		goto err_put_group;
> -	}
> -
>  	group->syncobjs = panthor_kernel_bo_create(ptdev, group->vm,
>  						   group_args->queues.count *
>  						   sizeof(struct panthor_syncobj_64b),

