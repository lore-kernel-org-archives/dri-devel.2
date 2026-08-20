Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05207C5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5115F10E246;
	Thu, 20 Aug 2026 20:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WB0RLw5b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38AF510E246;
 Thu, 20 Aug 2026 20:26:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AE9560A58;
 Thu, 20 Aug 2026 20:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C19B1F000E9;
 Thu, 20 Aug 2026 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787257580;
 bh=GLhngrtwsmPKoPQxSaIufqnOylyEAivx9wbGDMn5D74=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WB0RLw5brvcDh8ew03PZsYURAfiGVwzd0Z75LsX6EzKZLG8EHz/ShSPgvwTQPMS7z
 Jx9XlPIFd+IqooiIwup2Bk+7rNqKx0Uj6BmldWLrfxTsI8yxrRPPCAmY/+tvXw9UD7
 M/Ma3X0PqnN/azPfsb3N55uLXwAlMcmCE5H7yE5nsPt70zj38PcUEpwBfLDFL+sgst
 GUsKXMozRhIgLBAx5KudHP85lcQ9KNSPjMQ0mxbrH6zvcURzv4lZ20LZH9pubiuJJc
 g/5VK39uY5zK3V7fUz7SSXDVUqBjn0/baFYlka+kRIUOfqYITPNsuWcP7kcW6ChzYF
 KATJIspIlKXRw==
Message-ID: <fc704cf9-4bc5-4c67-9705-1eaf84c41102@kernel.org>
Date: Thu, 20 Aug 2026 15:26:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix dc_lock leak on GPU reset error paths
Content-Language: en-US
To: Linkai Gong <gonglinkai@kylinos.cn>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Ray Wu <ray.wu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260819054742.3143856-1-gonglinkai@kylinos.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260819054742.3143856-1-gonglinkai@kylinos.cn>
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

On 8/19/26 00:47, Linkai Gong wrote:
> On GPU reset, dm_suspend() takes dc_lock and leaves it for dm_resume()
> to drop. If amdgpu_dm_commit_zero_streams() or dm_dmub_hw_init() fails,
> the function returns with the lock still held. The matching resume path
> is then skipped, so every later dc_lock take hangs.
> 
> Release the cached DC state and unlock before returning the error.
> 
> Fixes: 3cf7a0bc87f0 ("drm/amd/display: Catch failures for amdgpu_dm_commit_zero_streams()")
> Fixes: 2b6943df5413 ("drm/amd/display: Pass up errors for reset GPU that fails to init HW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Great finding and fix.  I'll get this added to amd-staging-drm-next.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 941c1a312824..214aca906fe1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3511,6 +3511,9 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>   		res = amdgpu_dm_commit_zero_streams(dm->dc);
>   		if (res != DC_OK) {
>   			drm_err(adev_to_drm(adev), "Failed to commit zero streams: %d\n", res);
> +			dc_state_release(dm->cached_dc_state);
> +			dm->cached_dc_state = NULL;
> +			mutex_unlock(&dm->dc_lock);
>   			return -EINVAL;
>   		}
>   
> @@ -3824,6 +3827,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   		r = dm_dmub_hw_init(adev);
>   		if (r) {
>   			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
> +			dc_state_release(dm->cached_dc_state);
> +			dm->cached_dc_state = NULL;
> +			mutex_unlock(&dm->dc_lock);
>   			return r;
>   		}
>   

