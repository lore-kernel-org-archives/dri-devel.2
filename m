Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302AAF8806B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 06:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDA510E06B;
	Thu, 16 Apr 2026 06:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="vYtJAln5";
	dkim-atps=neutral
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AE110E06B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:53:54 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=V6ooxnaYpS3IiydCIisIXi5SzkIIL+iBCuoiXM/KiGY=;
 b=vYtJAln5CXv+lKgXQ9cmYQu4cOsJc171iRk50A7szCv7Xx5Z/J7V69qpnMJ8RRb24LSgzYojf
 1wnsULHCtjHv9Q+ocSaufinrl5dgUSukj7qwDYzUkO30KDs5dit9EQdkHrHNyODs2UeRKoatJl8
 otVhB240MDb4AYfKhnmnH/o=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fx7qS4KHgzRhR4;
 Thu, 16 Apr 2026 14:47:32 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 7C6FD40572;
 Thu, 16 Apr 2026 14:53:51 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 14:53:49 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 14:53:48 +0800
Message-ID: <7fd5022a-9a5d-4976-9d4a-1e0fa2022eae@huawei.com>
Date: Thu, 16 Apr 2026 14:53:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/hibmc: Use drm_atomic_helper_check_plane_state()
To: Thomas Zimmermann <tzimmermann@suse.de>, <tiantao6@hisilicon.com>,
 <kong.kongxinwei@hisilicon.com>, <sumit.semwal@linaro.org>,
 <yongqin.liu@linaro.org>, <jstultz@google.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Rongrong Zou <zourongrong@gmail.com>,
 Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
 <stable@vger.kernel.org>, <shiyongbang@huawei.com>, "Liangjian(Jim,Kunpeng
 Solution Development Dept)" <liangjian010@huawei.com>, Chenjianmin
 <chenjianmin@huawei.com>, "fengsheng (A)" <fengsheng5@huawei.com>
References: <20260413085037.17491-1-tzimmermann@suse.de>
 <20260413085037.17491-2-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260413085037.17491-2-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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


> Call drm_atomic_helper_check_plane_state() from the primary plane's
> atomic-check helper and replace the custom implementation.
> 
> All plane's implementations of atomic_check should call the shared
> _check_plane_state() helper first. It adjusts the plane state for
> correct positioning, rotation and scaling of the plane. If the plane
> is not visible, it clears the corresponding flag in the plane state.
> 
> On errors or if the plane is not visible, the atomic-check helper can
> return early. Implement all this in hibmc and drop the custom code
> that does some of it.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Xinliang Liu <xinliang.liu@linaro.org>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Baihan Li <libaihan@huawei.com>
> Cc: Yongbang Shi <shiyongbang@huawei.com>
> Cc: <stable@vger.kernel.org> # v4.10+
> ---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 46 ++++++-------------
>  1 file changed, 14 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 89bed78f1466..8fa2a95bcdd1 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -55,46 +55,28 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
>  static int hibmc_plane_atomic_check(struct drm_plane *plane,
>  				    struct drm_atomic_state *state)
>  {
> -	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
> -										 plane);
> -	struct drm_framebuffer *fb = new_plane_state->fb;
> -	struct drm_crtc *crtc = new_plane_state->crtc;
> -	struct drm_crtc_state *crtc_state;
> -	u32 src_w = new_plane_state->src_w >> 16;
> -	u32 src_h = new_plane_state->src_h >> 16;
> -
> -	if (!crtc || !fb)
> -		return 0;
> +	struct drm_plane_state *new_plane_state =
> +		drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc_state *new_crtc_state = NULL;
> +	int ret;
>  
> -	crtc_state = drm_atomic_get_crtc_state(state, crtc);
> -	if (IS_ERR(crtc_state))
> -		return PTR_ERR(crtc_state);
> +	if (new_plane_state->crtc)
> +		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
>  
> -	if (src_w != new_plane_state->crtc_w || src_h != new_plane_state->crtc_h) {
> -		drm_dbg_atomic(plane->dev, "scale not support\n");
> -		return -EINVAL;
> -	}
> -
> -	if (new_plane_state->crtc_x < 0 || new_plane_state->crtc_y < 0) {
> -		drm_dbg_atomic(plane->dev, "crtc_x/y of drm_plane state is invalid\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!crtc_state->enable)
> +	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, true);

The last parameter, "can_update_disabled", if set to true, causes the
condition "if (!crtc_state->enable && !can_update_disabled)" in the
function `drm_atomic_helper_check_plane_state` to always evaluate to
false, meaning `crtc_state->enable` will not be checked. This differs
from the behavior prior to the modification.

before:
	- crtc_state->enable(true)  --> continue check
	- crtc_state->enable(false) --> return 0(atomic check success)

after:
	- crtc_state->enable(true)   --> _helper_check_plane_ ->  continue check
	- crtc_state->enable(false)  --> _helper_check_plane_ ->  continue check


> +	if (ret)
> +		return ret;
> +	else if (!new_plane_state->visible)
>  		return 0;
>  
> -	if (new_plane_state->crtc_x + new_plane_state->crtc_w >
> -	    crtc_state->adjusted_mode.hdisplay ||
> -	    new_plane_state->crtc_y + new_plane_state->crtc_h >
> -	    crtc_state->adjusted_mode.vdisplay) {
> -		drm_dbg_atomic(plane->dev, "visible portion of plane is invalid\n");
> -		return -EINVAL;
> -	}
> -

The purpose of this check is to ensure that the right and bottom
boundaries of the plane do not extend beyond the crtc. In
`drm_atomic_helper_check_plane_state`, `drm_mode_get_hv_timing` is
called to retrieve the crtc boundaries, and `drm_rect_clip_scaled` is
used to clip the plane, any portions extending beyond the right and
bottom boundaries are discarded.

I'd like to confirm that my understanding is correct? previously, the
check failed if the plane exceeded the boundaries, but now, after
`drm_atomic_helper_check_plane_state` is called, the plane is clipped to
fit within the boundaries.

in function drm_rect_clip_scaled:

diff = dst->x2 - clip->x2;
if (diff > 0) {
	...
	dst->x2 -= diff;
}
diff = dst->y2 - clip->y2;
if (diff > 0) {
	...
	dst->y2 -= diff;
}


Thanks.

Best regards
Yongbang.


>  	if (new_plane_state->fb->pitches[0] % 128 != 0) {
>  		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
>  		return -EINVAL;
>  	}
> +
>  	return 0;
>  }
>  

