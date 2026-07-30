Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9947C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AEE10E67C;
	Thu, 30 Jul 2026 10:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="sQtr2fQ3";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3745910E67C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:51:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1E471BCA
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:51:03 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 732923F86F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785408667; bh=MDQiW4ZvNPxnBTgRIKzvX+d4xEsVMeUh97WuHf/NjHU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sQtr2fQ31IPT/wYjRPOcJGt8AJaz1VRqyBiATWJrO/OXSkG9QFO8Llmtnu3zyPv9z
 cR8KBCXuBxH3nkeuZbdsbarRp4VDPwLuVuIfw56nmEUSrQVqN/wZusNBOCtWkgGoHI
 0yJXIXzsmGeo+dAovFxFACKbSYnAY6TPNSgP5gR0=
Date: Thu, 30 Jul 2026 11:50:54 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/panthor: Don't allocate protm_suspend_buf
Message-ID: <amssjgGaLXwnemyF@e142607>
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
 <20260712135439.1546950-6-ketil.johnsen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260712135439.1546950-6-ketil.johnsen@arm.com>
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

On Sun, Jul 12, 2026 at 03:54:37PM +0200, Ketil Johnsen wrote:
> The PROTM suspend buffer is only needed if the group is going to
> use PROTM in the first place, so let's not assume we need one until
> we're being asked to.
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
