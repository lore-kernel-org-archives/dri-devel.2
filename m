Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB45C88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 16:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792F410E751;
	Sat, 12 Sep 2026 16:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mbwXM8Rc";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7565210E751
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 16:25:20 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 630F94DC;
 Sat, 12 Sep 2026 18:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1789230219;
 bh=4CNMsE42yELW6hDHST/90JepYoJVdDA+goTAW3rWuyM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mbwXM8Rcfk72aBduE7Xs1WJx4R3sYcegGVk1n7Bp3ILBqZsrsZXsj5ZnKW3+w76CS
 3r/xHqnGUC3HHXboVpWY9p3qvfrzRkKcWQrMOpsppZ1LOQ6xKracJ1hP7+H6SC7CEJ
 Bx2rzxFswzhecijDasASZFJAUhuMq8IPGvI7oQ08=
Date: Sat, 12 Sep 2026 19:25:16 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Danilo Krummrich <dakr@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gem-dma: Correct GEM object wrapper documentation
Message-ID: <20260912162516.GA1892234@killaraus.ideasonboard.com>
References: <20260912063258.43169-1-kmehltretter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912063258.43169-1-kmehltretter@gmail.com>
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

On Sat, Sep 12, 2026 at 08:32:58AM +0200, Karl Mehltretter wrote:
> The drm_gem_dma_object_free() wrapper calls drm_gem_dma_free(), but its
> description still names the former drm_gem_dma_free_object() helper.
> Update the reference to match the wrapped function.
> 
> Also correct drm_gem_dma_object_get_sg_table() to document an error
> pointer on failure. It forwards the result of
> drm_gem_dma_get_sg_table(), which returns ERR_PTR() rather than NULL on
> failure.
> 
> Fixes: e580ea25c08d ("drm/cma-helper: Pass GEM CMA object in public interfaces")
> Fixes: 05b1de51df07 ("drm/cma-helper: Export dedicated wrappers for GEM object functions")
> Assisted-by: LLM

Throwing LLMs at this kind of things is neither a good use of computing
resources nor a good use of maintainer time. Please refrain from doing
so in the future.

> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  include/drm/drm_gem_dma_helper.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/drm/drm_gem_dma_helper.h b/include/drm/drm_gem_dma_helper.h
> index f2678e7ecb9847917e9c6c0287af9815d54bae79..5defd47d7de425515c76391d1825f0ed28077eaa 100644
> --- a/include/drm/drm_gem_dma_helper.h
> +++ b/include/drm/drm_gem_dma_helper.h
> @@ -52,7 +52,7 @@ extern const struct vm_operations_struct drm_gem_dma_vm_ops;
>   * drm_gem_dma_object_free - GEM object function for drm_gem_dma_free()
>   * @obj: GEM object to free
>   *
> - * This function wraps drm_gem_dma_free_object(). Drivers that employ the DMA helpers
> + * This function wraps drm_gem_dma_free(). Drivers that employ the DMA helpers
>   * should use it as their &drm_gem_object_funcs.free handler.
>   */
>  static inline void drm_gem_dma_object_free(struct drm_gem_object *obj)
> @@ -87,7 +87,8 @@ static inline void drm_gem_dma_object_print_info(struct drm_printer *p, unsigned
>   * use it as their &drm_gem_object_funcs.get_sg_table handler.
>   *
>   * Returns:
> - * A pointer to the scatter/gather table of pinned pages or NULL on failure.
> + * A pointer to the scatter/gather table of pinned pages on success, or
> + * an ERR_PTR() on failure.
>   */
>  static inline struct sg_table *drm_gem_dma_object_get_sg_table(struct drm_gem_object *obj)
>  {

-- 
Regards,

Laurent Pinchart
