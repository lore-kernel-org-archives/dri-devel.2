Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4317DC79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EE010E4F9;
	Thu, 10 Sep 2026 01:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="XGTRkNct";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91EA10E4F9
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789002916; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LizOaGzLxc3jCdW18fl0KrMWGBeRBVVnFkU9CB3OBEtgi0RTnXH14u5r4o3p54BZT49L7jb3KdjsJAWiihC3AvfTAzvAyJQmknu/Xs0ejeswG0EG6KAuFlcZ4D0AYfCMhN+3IA3wrdCNAO27SPKSjc38ij4W+8WqbRGYIi4vY6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789002916;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4MntxQDyfuC6cfeTweUENwwFcn3DP5wHtukYShWkrWA=; 
 b=IIEoZxNrQCzlx6iMGEemA754v+4RqGxJjarqizL7uMUW9BahhZy9jgbkQEUbZVG3LMwqIsrAjxRbupXAf8ImPwuxhehTzSgf+SClQuvjEhV+y+LD1DRY0POu2fo2DLnX2Y7qfbbfWGCHEAF/CzuE5AIWsxTZ/WrFZ1J9zsBXjpQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789002916; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=4MntxQDyfuC6cfeTweUENwwFcn3DP5wHtukYShWkrWA=;
 b=XGTRkNctszzoA5UY3TXGeq6gqjqdjtLU+np4R6oTDBn4iXUnBOsjdLPq/ryuFWMY
 +VnwIQ2IapK6vTHJ8WbwEal4duILS51fPhqvPudF9CuiVuDp9JvAOE11HhOpLDiGlcA
 u4OGdyZ0ERYcznD84zgO5EoPd8MI0poOetYHKrRA=
Received: by mx.zohomail.com with SMTPS id 1789002915190385.4411115226686;
 Wed, 9 Sep 2026 18:15:15 -0700 (PDT)
Date: Thu, 10 Sep 2026 02:15:11 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/18] drm/panthor: Drop unused vm argument passed to
 panthor_vm_prepare_sync_only_op_ctx()
Message-ID: <aqIAuZ1p0h0BW8Vn@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-6-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-6-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.982.46
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 26.08.2026 16:56, Boris Brezillon wrote:
> No need to pass a panthor_vm around if it's unused.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
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

Adrian Larumbe
