Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49931C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A0810E1C8;
	Thu, 20 Aug 2026 12:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bSs77Yfd";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A75310E1C8
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=vaoREAjzAUtVcW2w+qzwpaftYQDmc8T95lDW90yNraU=; b=bSs77Yfd6vFecBIH5ccYlLgME0
 6eQP6cHVsVSO5g/vuQ3CIDPJI/8wrrVFnJh8SfvFGiGaZflHH49Ju/zGiACsP4ATCh6wlrLgoxllo
 MHHbH6pEqgWFE2EFWkVt/7z2VXZcEy6Zwtv5mM8/hHdQvsjvPGTQ9XTFylugi/6OviLYKmESRZnHb
 1+uK2FzpQENEM9ci3SuaoPOFIHSrmUsieIu6E1KpTLh/A3nzOgwfKTr4AT81r5ekhMfNG+nJrO+6y
 FN2j9LbHY//Ie0hZ5xsO0zZvpYzbLwyD/dSeBxZig2A8nXVt6nI6rWwmaAG13VMbJXr35DtlwAmuL
 XzZkv8Zw==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=[192.168.1.204]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wx2Du-006arN-Fj; Thu, 20 Aug 2026 14:50:22 +0200
Message-ID: <b6dbc661-ef4c-4a19-96e9-84939657753e@igalia.com>
Date: Thu, 20 Aug 2026 14:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/atomic: remove bogus check for file_priv
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260817-drm_atomic_bogus_check-v2-1-2b9e60f32a7e@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260817-drm_atomic_bogus_check-v2-1-2b9e60f32a7e@igalia.com>
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



On 17/08/2026 20:45, Thadeu Lima de Souza Cascardo wrote:
> Since file_priv can never be NULL at prepare_signaling() as it is only
> called by drm_mode_atomic_ioctl(), remove the check.
>
> If that was not the case, skipping the rest of the block here would cause
> the drm_pending_vblank_event object to leak and fail to set up the fence in
> case out_fence_ptr is set.
>
> Since the check is unreachable, there is no possible leak.
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> Changes in v2:
> - Change commit message to indicate this is not a reachable leak.
> - Link to v1: https://patch.msgid.link/20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com
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
> base-commit: ab243f74ab4084ca5c8dec608cb5b0deb27db067
> change-id: 20260729-drm_atomic_bogus_check-456d5fb6eee9
>
> Best regards,
> --
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>

