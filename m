Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE88F327BD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3CD010E824;
	Tue, 21 Apr 2026 07:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="Sxucc7Vg";
	dkim-atps=neutral
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F6210E824
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:56:46 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=UQ/O7Ksa/m+RxlB6FRtoMDjiJJ3w54XrXWQLzeVLLUU=;
 b=Sxucc7VgYw180gKWeOpTWacw38DRhIcpymrLlhre7Kf11Q7zajHZ7shAqpz3oHJ9lmPHlcQ+R
 erFu/CDp26VwOca/FGzmR+NH5VzT4ZW9UfB5fl3fXbfemiOadfDcHprywJ7G2jCW/g/hsF1dQHh
 gF9sH0gZbrhfwHr8LgjsQ+U=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4g0Dzd4jcYzRhRV;
 Tue, 21 Apr 2026 15:50:21 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 9AD0940538;
 Tue, 21 Apr 2026 15:56:43 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 15:56:43 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 15:56:42 +0800
Message-ID: <ea18dc58-3607-4e84-b5a2-eb582c10e307@huawei.com>
Date: Tue, 21 Apr 2026 15:56:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/hibmc: Use
 drm_atomic_helper_check_plane_state()
To: Thomas Zimmermann <tzimmermann@suse.de>, <xinliang.liu@linaro.org>,
 <tiantao6@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
 <sumit.semwal@linaro.org>, <yongqin.liu@linaro.org>, <jstultz@google.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, Rongrong Zou <zourongrong@gmail.com>,
 Sean Paul <seanpaul@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Baihan Li <libaihan@huawei.com>, <stable@vger.kernel.org>,
 <shiyongbang@huawei.com>, "Liangjian(Jim,Kunpeng Solution Development Dept)"
 <liangjian010@huawei.com>, Chenjianmin <chenjianmin@huawei.com>, "fengsheng
 (A)" <fengsheng5@huawei.com>
References: <20260420121130.200133-1-tzimmermann@suse.de>
 <20260420121130.200133-2-tzimmermann@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <20260420121130.200133-2-tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
> correct positioning, rotation and scaling of the plane. Do this
> even if the plane's CRTC has been disabled by setting the parameter
> can_update_disabled. The original code returned early in this case,
> but it's safe to so and cleaner to have all plane state initialized.
> 
> As we don't set can_position, drm_atomic_helper_check_plane_state()'s
> visibility check tests if the plane covers all of the CRTC. This is
> a small change from the original code, which tested if the plane is
> exactly the size of the CRTC. With the new test, the plane still has
> to cover all of the CRTC, but can be larger than the CRTC's size. A
> later patch can fully implement this feature in hibmc.
> 
> If the plane is disabled, the helper clears the visibility flag in the
> plane state. On errors or if the plane is not visible, the atomic-check
> helper can return early. Implement all this in hibmc and drop the custom
> code that does some of it.
> > v2:
> - extend the commit description (Yongbang)
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
>  	if (new_plane_state->fb->pitches[0] % 128 != 0) {
>  		drm_dbg_atomic(plane->dev, "wrong stride with 128-byte aligned\n");
>  		return -EINVAL;
>  	}
> +
>  	return 0;
>  }
>

Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>




