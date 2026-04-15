Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9292F43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319D910E6FE;
	Wed, 15 Apr 2026 15:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RObxHtMV";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3547110E6FE
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:20:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24DBA46FC;
 Wed, 15 Apr 2026 08:20:00 -0700 (PDT)
Received: from [10.57.61.136] (unknown [10.57.61.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D21303F7B4;
 Wed, 15 Apr 2026 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776266405; bh=9wVMRsqQbtrg4/ocTAjHo6/dqovS2lAVJ0ffrwziy/E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RObxHtMVfFInyCLeqGa02EOjsnSb+GuOKzbgArFzMwnvHCJmqTkoQAK8VQ5PK81yk
 kmUbo8AHPFVLCBmdGANRV6rAcR/RMVncKzTX5K5IM3p9XwxzP1qFuwkLPVGEGnWNXt
 MgL8n8tM1L5kI6jzzOC61nt/7h8Zb57VNm5nmk3c=
Message-ID: <2a0f0091-3b0b-4b02-93a4-09302bfac749@arm.com>
Date: Wed, 15 Apr 2026 16:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] drm/panthor: Remove unused operation context field
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-5-adrian.larumbe@collabora.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20260415112900.681834-5-adrian.larumbe@collabora.com>
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

On 15/04/2026 12:28, Adrián Larumbe wrote:
> A Panthor BO's sgtable is now retrieved from its dmap field.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d9e2f8afb8fb..cea78e5f0591 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -195,14 +195,6 @@ struct panthor_vm_op_ctx {
>  		/** @map.bo_offset: Offset in the buffer object. */
>  		u64 bo_offset;
>  
> -		/**
> -		 * @map.sgt: sg-table pointing to pages backing the GEM object.
> -		 *
> -		 * This is gathered at job creation time, such that we don't have
> -		 * to allocate in ::run_job().
> -		 */
> -		struct sg_table *sgt;
> -
>  		/** @map.bo: the BO being mapped. */
>  		struct panthor_gem_object *bo;
>  	} map;

