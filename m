Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F1FC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A0C10E42A;
	Wed, 12 Aug 2026 16:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LIQMz1GP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D531410E42A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=jXWkxU7/1D7wTgybeFHWysB5/ozEN3dFbXlQD81TcwE=; b=LIQMz1GPkkI/mhTQxMYVxqxBQJ
 g+3VoJHroVASAZcDN9JS7F5nihLELL6+o5hxlBkcdXwAuN3QR50yGQRh+S4P9vLdcFON08HmweLmN
 LCaXSO++c75rLHiBWsw51SvbYs36ayBPH0qZruZFD5il3mlWf2hoFUZmkIduij5sDIegHS/GrsHbX
 1xykntA68Mae36ow7GNbiPq4RDeD8lejZKixm7bRsPSWluHs7aD8Vn4xvxq4ari8fDZRhDmaMj0eR
 RGq9rGo4T4g5SyzayE36w74ac8jVP8in2StiudMNNv+ihjXQtWj48SNsscwXLyT1COnS8xGuNfRij
 v0N4Sujw==;
Received: from [31.4.134.207] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wuBg4-0009Zm-TH; Wed, 12 Aug 2026 18:19:40 +0200
Message-ID: <a64e03f4-dcd5-4842-ab21-b59dce159540@igalia.com>
Date: Wed, 12 Aug 2026 18:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/atomic: remove bogus check for file_priv
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com>
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



On 29/07/2026 09:52, Thadeu Lima de Souza Cascardo wrote:
> Skipping the rest of the block here would cause the drm_pending_vblank_event
> object to leak and fail to set up the fence in case out_fence_ptr is set.
>
> Since file_priv can never be NULL at prepare_signaling() as it is only
> called by drm_mode_atomic_ioctl(), simply remove the check.

Hey,

The change looks correct, but I'm a little confused by the first sentence,
because, if `file_priv` can never be NULL, there's no real leak, right?

Could you clarify the first sentence by saying it's currently an unreachable
bug? That way, people will not think it's a live bug and will understand 
that
a Fixes tag isn't necessary.

With this small clarification added:

Reviewed-by: Melissa Wen <mwen@igalia.com>

Thanks!

>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   drivers/gpu/drm/drm_atomic_uapi.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index e997917819e8..657c15474ed5 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1445,9 +1445,6 @@ static int prepare_signaling(struct drm_device *dev,
>   		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
>   			struct drm_pending_vblank_event *e = crtc_state->event;
>   
> -			if (!file_priv)
> -				continue;
> -
>   			ret = drm_event_reserve_init(dev, file_priv, &e->base,
>   						     &e->event.base);
>   			if (ret) {
>
> ---
> base-commit: d5efb1e1b1d7cd27c642654042f80d19a7ba3caf
> change-id: 20260729-drm_atomic_bogus_check-456d5fb6eee9
>
> Best regards,
> --
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>

