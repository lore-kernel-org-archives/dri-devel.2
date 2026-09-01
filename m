Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCEFC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA4AE10EBEB;
	Tue,  1 Sep 2026 08:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MplQJzO9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C373F10EBEB;
 Tue,  1 Sep 2026 08:25:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCDAD60202;
 Tue,  1 Sep 2026 08:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2F91F000E9;
 Tue,  1 Sep 2026 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788251120;
 bh=cwoiwAp4oLTxvCVw8zP4O4iMvSZjkBTBMfxJMXq0q0Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MplQJzO9GXIGFKUoOSptRVi8mKjaWyFhrcH8xSJybcRgSuWsU0TEfFfgfpToHg+yM
 vopzdEZHD1wQVuHEfaPM58r5DfLe1ry+aGpQZbuNbJHiKzJqPzqW+BaHjLA30rNcIE
 g2fwmmNmE6Ezc8dIh0M2C6qsBFkUSj8mjiN65Y2LLbMgnsfb8tvoVo/1EvFGUPNFGJ
 Vjxeex+yCRWRJ1qxijT4hjIHUODsD67MVZ6cX6K07/Y8vug0Ge7i298a3zRnuT0Dxr
 YbSgWZZ4uEaI15ebien7/je/aVs42s4EPnLeK2thvO36Ob5QlLpSzDQOZmg+GHzioN
 2J9c4ntQ7Nv8w==
Message-ID: <c8d6c58f-f9ff-4de5-96b2-b0ada727c51a@kernel.org>
Date: Tue, 1 Sep 2026 10:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/uvmm: reject zero-length range in
 validate_range
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com>
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

On 8/12/26 4:56 PM, Zhenhao Wan wrote:
> nouveau_uvmm_validate_range() rejects misaligned addresses and ranges and
> defers the remaining bounds check to drm_gpuvm_range_valid(), but neither
> rejects a zero range: 0 is page-aligned and addr + 0 does not overflow, so
> a zero-length VM_BIND request from userspace passes validation. It then
> reaches the generic GPUVA interval-tree insertion, where the node last key
> is computed as addr + range - 1. With range == 0 this underflows to
> addr - 1, producing an interval whose end lies below its start. The
> resulting malformed node corrupts the augmented interval tree and misleads
> the overlap checks of later map/unmap operations on the same VM.

Given this, why do you think drm_gpuvm_range_valid() intentionally leaves
the zero-range rejection to its callers? Why not fix this in GPUVM instead?

> drm_gpuvm_range_valid() intentionally leaves the zero-range rejection to
> its callers; drm/imagination does exactly this with an explicit "size != 0"
> test next to its drm_gpuvm_range_valid() call. nouveau simply omitted it.
> 
> Reject range == 0 alongside the existing alignment test.
> 
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index f5e4756b4de4..0efedd9ecc75 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -1008,7 +1008,7 @@ nouveau_uvmm_validate_range(struct nouveau_uvmm *uvmm, u64 addr, u64 range)
>  	if (addr & ~PAGE_MASK)
>  		return -EINVAL;
>  
> -	if (range & ~PAGE_MASK)
> +	if (!range || range & ~PAGE_MASK)
>  		return -EINVAL;
>  
>  	if (!drm_gpuvm_range_valid(&uvmm->base, addr, range))
> 
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20260812-nouveau-uvmm-pt-fixes-9706da1a03cf
> 
> Best regards,
> --  
> Zhenhao Wan <whi4ed0g@gmail.com>
> 

