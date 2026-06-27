Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3DDC43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 05:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF2B10E45D;
	Sat, 27 Jun 2026 05:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tz1GJq1X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A575810E459;
 Sat, 27 Jun 2026 05:53:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55A69439B9;
 Sat, 27 Jun 2026 05:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6302D1F000E9;
 Sat, 27 Jun 2026 05:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782539633;
 bh=y2XSyq3zGZGOpkJqqW0NdquWFNvEnloCi4JZ+AgNhN4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Tz1GJq1XTI30zHIi88et+AM4I5pSenf2DsPEkrTQaTh7PptDGh+k+TRHA+vkeoT3B
 J0EnHmsMF5S7e4La7BnaYTv7FIRw689k0zwzHDhMx9gR6r4+yhhunojdvy/TgmSeFZ
 XqgX0+ZJDmVjvbRJZZquJqEdQ48mM3XaGIJTnEtCJckQgtPaWe3g74hn5JNeFhyzCM
 Rt7ZF6yqF1vVi6pf9qLa0NCNG3zagR2N5Drh/AmHldyo2TGn5IesjxYRBi9l3GwrvY
 A68J5YCCcG1onvar6Xu7B8BMTWC4mXkVVZmZWV4mIvS7f/9bAwrMrF2rhGjolDoajg
 ZpoNLhB4BsD7w==
Message-ID: <9f91ba0b-519b-48f3-822e-a2b08d7e6feb@kernel.org>
Date: Sat, 27 Jun 2026 00:53:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Fix resource leak in
 amdgpu_gfx_run_cleaner_shader_job()
Content-Language: en-US
To: Wentao Liang <vulab@iscas.ac.cn>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260624124731.37479-1-vulab@iscas.ac.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260624124731.37479-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/24/26 07:47, Wentao Liang wrote:
> When amdgpu_job_alloc_with_ib() fails in
> amdgpu_gfx_run_cleaner_shader_job(), the function returns directly
> without destroying the scheduler entity, causing a resource leak.
> 
> Fix this by moving the entity cleanup to a common error path. Set r = 0
> on success and use a single cleanup point at the err label to ensure the
> entity is always destroyed regardless of whether the function succeeds
> or fails.
> 
> Also remove the unnecessary error check for dma_fence_wait() since it
> never fails with intr=false and infinite timeout.
> 
> Cc: stable@vger.kernel.org
> Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 523b681d0da9..29a07af6f5f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1689,9 +1689,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>   
>   	dma_fence_put(f);
>   
> -	/* Clean up the scheduler entity */
> -	drm_sched_entity_destroy(&entity);
> -	return 0;
> +	r = 0;
>   
>   err:
>       /* Clean up the scheduler entity */

What tree is this against?  It doesn't apply against amd-staging-drm-next.

Applying: drm/amdgpu: Fix resource leak in 
amdgpu_gfx_run_cleaner_shader_job()
Patch failed at 0001 drm/amdgpu: Fix resource leak in 
amdgpu_gfx_run_cleaner_shader_job()
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:1689
error: drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
