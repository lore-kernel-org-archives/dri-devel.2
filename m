Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1085103E166
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5CA10E4D2;
	Wed, 18 Mar 2026 11:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="jeBL3UdB";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DE610E3F2;
 Wed, 18 Mar 2026 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1773834534;
 bh=d3a7I/ZMl2ZcHGMzyuaf4o76FpCmbwrzczn7Nzm42d8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jeBL3UdBaAex3wDEjSuWgHvaT2kP7e6bIZDqeMogW213UhPSERsrD0llmkeA+u+2g
 /U++tt6oiC9Zw9c+Z0THSsK7w8M/v1UUFa0If9ZAkB4MpTdJJ7RP9pCGGfIn/a954R
 BqR36CZ1ChrIr2ic77LyBaLCKbb1Q59+RC2swfjY0g9FlQKA8bsiLQaKaJvo5Upw7H
 K326CXHJ2aLtrhAc4gMXuIz5sagmfTchL9ojX0fE0wFLqT/LAliSziFNzf+2jIP/UP
 hOKWcHaEBTPKa87EpzT4drNvfD4rL2XPAGCcUnVy+ik+x/Vn4HLEsgscB6EP4o6izy
 0NH67JPaYMPIA==
Message-ID: <13a30c40-f497-46b7-8984-861a6a9367e4@lankhorst.se>
Date: Wed, 18 Mar 2026 12:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/ttm: Update the struct ttm_operation_ctx
 kerneldoc
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
References: <20260317141856.237876-1-thomas.hellstrom@linux.intel.com>
 <20260317141856.237876-4-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260317141856.237876-4-thomas.hellstrom@linux.intel.com>
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

Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>

Den 2026-03-17 kl. 15:18, skrev Thomas Hellström:
> Update the kerneldoc with a more elaborate description of some members,
> including the gfp_retry_mayfail member. Use inline kerneldoc.
> 
> Suggested-by: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  include/drm/ttm/ttm_bo.h | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index bca3a8849d47..8310bc3d55f9 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -167,24 +167,34 @@ struct ttm_bo_kmap_obj {
>  /**
>   * struct ttm_operation_ctx
>   *
> - * @interruptible: Sleep interruptible if sleeping.
> - * @no_wait_gpu: Return immediately if the GPU is busy.
> - * @gfp_retry_mayfail: Set the __GFP_RETRY_MAYFAIL when allocation pages.
> - * @allow_res_evict: Allow eviction of reserved BOs. Can be used when multiple
> - * BOs share the same reservation object.
> - * faults. Should only be used by TTM internally.
> - * @resv: Reservation object to allow reserved evictions with.
> - * @bytes_moved: Statistics on how many bytes have been moved.
> - *
>   * Context for TTM operations like changing buffer placement or general memory
>   * allocation.
>   */
>  struct ttm_operation_ctx {
> +	/** @interruptible: Sleep interruptible if sleeping. */
>  	bool interruptible;
> +	/** @no_wait_gpu: Return immediately if the GPU is busy. */
>  	bool no_wait_gpu;
> +	/**
> +	 * @gfp_retry_mayfail: Use __GFP_RETRY_MAYFAIL | __GFP_NOWARN
> +	 * when allocation pages. This is to avoid invoking the OOM
> +	 * killer when populating a buffer object, in order to
> +	 * forward the error for it to be dealt with.
> +	 */
>  	bool gfp_retry_mayfail;
> +	/**
> +	 * @allow_res_evict: Allow eviction of reserved BOs. Can be used
> +	 * when multiple BOs share the same reservation object @resv.
> +	 */
>  	bool allow_res_evict;
> +	/**
> +	 * @resv: Reservation object to be used together with
> +	 * @allow_res_evict.
> +	 */
>  	struct dma_resv *resv;
> +	/**
> +	 * @bytes_moved: Statistics on how many bytes have been moved.
> +	 */
>  	uint64_t bytes_moved;
>  };
>  

