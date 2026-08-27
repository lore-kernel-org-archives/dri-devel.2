Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE02FC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1336D10E8AD;
	Thu, 27 Aug 2026 15:21:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="tdpF6N75";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4C39610E8AD
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 15:21:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78AD1692
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:21:08 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9AA353F66F
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787844072; bh=vFkhu4YoIETy2KopYLS25E7PLiCY5PePdtoT9J6801Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tdpF6N75HhEmuf/R5Bs+FNuHb5CGlOweModgesmHJ6ju0UPmfETBr0ZFtTgM3loJ+
 23YGBbfAwKtcO18OoPHrfOVgtdOuB3P1/1OgmquwIfc2Nfyr9zn2MCF+4hnJOgzYJ8
 yIEzoP9x37RkRG6Fz5JgQ5WUUx6+5aUa85jMA3oQ=
Date: Thu, 27 Aug 2026 16:21:02 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/18] drm/panthor: Drop unused vm argument passed to
 panthor_vm_prepare_sync_only_op_ctx()
Message-ID: <apBV3tCWWeOl6BTT@e142607>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-6-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-6-982cc8f4234b@collabora.com>
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

On Wed, Aug 26, 2026 at 04:56:05PM +0200, Boris Brezillon wrote:
> No need to pass a panthor_vm around if it's unused.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index b4e41556247a..44a44602b8ba 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1462,8 +1462,8 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	return ret;
>  }
>  
> -static void panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx,
> -						struct panthor_vm *vm)
> +static void
> +panthor_vm_prepare_sync_only_op_ctx(struct panthor_vm_op_ctx *op_ctx)
>  {
>  	memset(op_ctx, 0, sizeof(*op_ctx));
>  	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY;
> @@ -3031,7 +3031,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  		if (!op->syncs.count)
>  			return -EINVAL;
>  
> -		panthor_vm_prepare_sync_only_op_ctx(op_ctx, vm);
> +		panthor_vm_prepare_sync_only_op_ctx(op_ctx);
>  		return 0;
>  
>  	default:
> 
> -- 
> 2.55.0
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
