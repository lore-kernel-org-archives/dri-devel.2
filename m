Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9923C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0897E10EDD1;
	Tue,  8 Sep 2026 22:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=leandro.ribeiro@collabora.com header.b="kTEnG4Aw";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797E410EDD1
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788905916; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZfQ1fHSTdL4Utckb7F8TIEPF3XaBGg+HB/ABRvZ2oKPwNVS7UXmtC0YbskMcdJirF9B8Nuf9HJJUL/52hC6kXWK13Cs+x1Vv0YdltRMce2SzXd51z5Uq+wH8SJSqAMWoj2/oCUiWj/HD/WXqAYm9jMKJWj5WjrGWez755kqyJ+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788905916;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uX34t09K/6FyPyum4/uGWqSmdiYpZyqWkAPNdfi7dkI=; 
 b=hQEcRL0GUdUoRow6VydCozYW+dfP+j7hNI4HQ3jgRSrUps2d9+wn1Yx8IvXlTlR43XRiYotFBeoioGtz8fOlXpGMpc+bZogqOmZhzL3yxbool4PWEvLY6XZMer7X6mvWEUtHl2Sw+XDrztYuZr9B3Ck0Vwdnt6sTi+/Z4MWgSAc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788905916; 
 s=zohomail; d=collabora.com; i=leandro.ribeiro@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=uX34t09K/6FyPyum4/uGWqSmdiYpZyqWkAPNdfi7dkI=;
 b=kTEnG4AweUAcrf2bnxFvoVfIEu29rIm3OKOqdng6yADsoBA11ONtYq2fQ+Jo7eJA
 IXhyzrzo50W1FKYnK94G8Q7c7Q0q8oFM2Yusis8f4DFxf+smZxAWSKSPdMj28uFK1dM
 qkLJYDxWoydnHqqDSAkShJmIA2KLkaHIuKcIvzM0=
Received: by mx.zohomail.com with SMTPS id 1788905915266449.26774191890786;
 Tue, 8 Sep 2026 15:18:35 -0700 (PDT)
Message-ID: <44c5ceae-4824-4b45-878c-1aac9e646116@collabora.com>
Date: Tue, 8 Sep 2026 19:18:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Add pixel blend mode property
To: oushixiong1025@163.com, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>,
 Ye Liu <liuye@kylinos.cn>
References: <20260828090257.788076-1-oushixiong1025@163.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <20260828090257.788076-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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



On 8/28/26 6:02 AM, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> The vkms planes expose formats with an alpha channel but do not
> create the pixel blend mode property. Since
> commit 860e748bddcc ("drm: ensure blend mode supported if pixel
> format with alpha exposed") this triggers a warning during
> drm_mode_config_validate():
> 
> [  993.538979] ------------[ cut here ]------------
> [  993.539000] [PLANE:35:plane-0] pixel format with alpha exposed but blend mode not setup
> [  993.539063] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate
> ......
> [  993.539578] Call trace:
> [  993.539580]  drm_mode_config_validate+0x398/0x558 [drm] (P)
> [  993.539707]  drm_dev_register+0x1cc/0x2a0 [drm]
> [  993.539832]  vkms_create+0x184/0x1d0 [vkms]
> [  993.539854]  vkms_init+0x78/0xff8 [vkms]
> ......
> 
> The vkms composer only blends premultiplied alpha, see
> pre_mul_alpha_blend(), so create the property with
> DRM_MODE_BLEND_PREMULTI as the only supported mode.
> 
> Reported-by: Ye Liu <liuye@kylinos.cn>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/gpu/drm/vkms/vkms_plane.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 6ee5c3f3207c..c4272f5f0354 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -276,6 +276,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct vkms_plane *plane;
> +	int ret;
>  
>  	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
>  					   &vkms_plane_funcs,
> @@ -287,6 +288,15 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  
>  	drm_plane_helper_add(&plane->base, &vkms_plane_helper_funcs);
>  
> +	/*
> +	 * The vkms composer only blends premultiplied alpha, see
> +	 * pre_mul_alpha_blend(), so that is the only supported mode.
> +	 */
> +	ret = drm_plane_create_blend_mode_property(&plane->base,
> +						   BIT(DRM_MODE_BLEND_PREMULTI));
> +	if (ret)
> +		return ERR_PTR(ret);
> +

Hello,

This looks good to me! But I think the comment in pre_mul_alpha_blend()
could also be updated. It states:

"The current DRM assumption is that pixel color values have been already
pre-multiplied with the alpha channel values"

Which is not true anymore.

With this change:

Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>

>  	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
>  					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
>  

-- 
Leandro Ribeiro

