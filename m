Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C61C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AE710E00C;
	Tue, 18 Aug 2026 10:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PnOcOqT1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD97410E00C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=RNau7PoN9jPuhQBuyRX+TK9/M06EXITtJzuKcbQ4VNc=; b=PnOcOqT15LymYMz8g9fk1the1M
 Yc7CVJF3ixz4P3eyghLuh7xnMP4OdkPrYWI08/3r05/5qGp9jBQnbKqLt9ZDsEjFCr8x8iyBLpRFu
 V5FJqkG+999vnqPaP+tChlXte6Rqyo99YCD6akQv8nNpme79LqRFO6YX77t3zEVDDJhlP7+wxQWub
 1poC8yV64Y9beW0DAKXyhZdV+/jTbPtQ3EcJle06pyh7JWN6N/SDCURHlD36LdPuxY3Dtz8CYFBBN
 xiXqTRDa0ahl5zUw+KggbtnY8b0rLrzzUBzZwdehY06lo1Obfsuvi4AbUycXQNx8Q938HR0VRimV9
 SZl25gPA==;
Received: from [31.4.136.12] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wwH2K-005ZCb-4a; Tue, 18 Aug 2026 12:27:16 +0200
Message-ID: <83e32ca0-56c9-4d3c-b337-a7c01199b4e1@igalia.com>
Date: Tue, 18 Aug 2026 12:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Fix drm_crtc_commit leak if signaled when
 PAGE_FLIP_EVENT is used
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, stable@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
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



On 27/07/2026 22:45, Thadeu Lima de Souza Cascardo wrote:
> Commit 1c6ceeee6ebb ("drm/atomic: Fix memleak on ERESTARTSYS during
> non-blocking commits") fixed a very similar issue when the event was
> allocated by drm_atomic_helper_setup_commit() itself.
>
> However, if the event is allocated in prepare_signaling(), it will also be
> set to NULL in complete_signaling(), which prevents drm_crtc_commit from
> being put in __drm_atomic_helper_crtc_destroy_state().
>
> Dropping the reference when the event is set to NULL at
> complete_signaling() fixes the leak.
>
> The leak can be reproduced by sending a signal to the thread using
> DRM_MODE_PAGE_FLIP_EVENT and using a sw_sync fence to cause the atomic
> ioctl to block at drm_atomic_helper_wait_for_fences(). It happened both
> with amdgpu and vkms.

Nice catch!

- Do you have a reproducer or is there an IGT test that triggers this issue?

- cc'ing Leo and Harry as well because they worked on the similar issue 
and must be interested in it.

- I think it should point to stable # v4.11+ as in commit 1c6ceeee6ebb

Reviewed-by: Melissa Wen <mwen@igalia.com>

Thanks!

>
> Fixes: 24835e442f28 ("drm: reference count event->completion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   drivers/gpu/drm/drm_atomic_uapi.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index e997917819e8..7b951af5ab32 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1563,6 +1563,8 @@ static void complete_signaling(struct drm_device *dev,
>   		 * to prevent a double free in drm_atomic_commit_clear.
>   		 */
>   		if (event && (event->base.fence || event->base.file_priv)) {
> +			if (crtc_state->commit && crtc_state->commit->abort_completion)
> +				drm_crtc_commit_put(crtc_state->commit);
>   			drm_event_cancel_free(dev, &event->base);
>   			crtc_state->event = NULL;
>   		}
>
> ---
> base-commit: d5efb1e1b1d7cd27c642654042f80d19a7ba3caf
> change-id: 20260727-drm_crtc_atomic_commit_leak-4de5e75162b3
>
> Best regards,
> --
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>

