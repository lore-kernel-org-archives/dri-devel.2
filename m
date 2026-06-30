Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87457C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFC610EBB3;
	Tue, 30 Jun 2026 08:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="IkElTmWd";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2608410EBB7
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782809236; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hItVkCbc3M3PPq824qURxGXz2Ojpqn4LGpxrD2QB0o+5RJbWBOHR8KirciQhXVcpkw4RRgxVYI9GAGVgzN2OPrRDb9xiuZsz1S2v/n+vsorzTZSHLKcMzm5aYVOARN56p1XyYqvcgSrnEeRLTYWu5M9p49tq2HfHPtDc/eeAAn0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782809236;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=A3dtHr7mxgHpX1rKpHtNynPWWBnhXQvlt03hbu/0Ias=; 
 b=eF8K7nTBhyNN4AXoCl6u1avGMe23X+2hiiY0HUdF5bOC2ip83FN5rPQaOPfka0GYbTei92SxHauCT04rTLIaJDsfpVi48DbT/luwAuDLdU0yfmzxmlrIw1tFBpP+7m0cFhcYckOV4xunkKm68+eEYQQDH+FyA+BGv1ggDihIyFQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782809236; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=A3dtHr7mxgHpX1rKpHtNynPWWBnhXQvlt03hbu/0Ias=;
 b=IkElTmWd4U4XZPHeDczjOCa43fdJl/9n8Hngdors59YwRWGtgWXfGuo3X5gK8wVE
 v1p2SoqZr1DVN/KCMGlaQJ2CZzlQNhdTdv7JwLrp9xPy3sqHdgmEBF67BQAAmFpp0aX
 9rQJfpAyQF07eZfR85xIDv2F9+2e83Djn3MvX7zM=
Received: by mx.zohomail.com with SMTPS id 1782809235908225.79567794510842;
 Tue, 30 Jun 2026 01:47:15 -0700 (PDT)
Message-ID: <7f28f870-6792-4820-9dcd-ccb2a731edd9@collabora.com>
Date: Tue, 30 Jun 2026 10:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
 behind driver feature
To: dri-devel@lists.freedesktop.org
References: <20260630084229.529682-1-robert.mader@collabora.com>
 <20260630084229.529682-2-robert.mader@collabora.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260630084229.529682-2-robert.mader@collabora.com>
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

On 30.06.26 10:42, Robert Mader wrote:
> The client cap is currently advertised unconditionally, even for drivers that do
> not support plane color pipelines. If clients supporting the later, like Wayland
> compositors and drm_info, enable the client cap on sich drivers they will be
> left without both color pipeline and the legacy properties COLOR_ENCODING and
> COLOR_RANGE, effectively breaking YUV->RGB conversion support.
>
> Add a new driver feature and guard the client cap behind it, allowing
> plane color pipeline and legacy YUV->RGB support to co-exist.
>
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> ---
>   drivers/gpu/drm/drm_ioctl.c | 2 ++
>   include/drm/drm_drv.h       | 6 ++++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index ff193155129e..96fda92e31b9 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -374,6 +374,8 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
>   		file_priv->supports_virtualized_cursor_plane = req->value;
>   		break;
>   	case DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE:
> +		if (!drm_core_check_feature(dev, DRIVER_PLANE_COLOR_PIPELINE))
> +			return -EOPNOTSUPP;
>   		if (!file_priv->atomic)
>   			return -EINVAL;
>   		if (req->value > 1)
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index e09559495c5b..108ddd2c8d30 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -116,6 +116,12 @@ enum drm_driver_feature {
>   	 * the cursor planes to work correctly).
>   	 */
>   	DRIVER_CURSOR_HOTSPOT           = BIT(9),
> +	/**
> +	 * @DRIVER_PLANE_COLOR_PIPELINE:
> +	 *
> +	 * Driver supports PLANE_COLOR_PIPELINE.

Sorry, forgot to append a change here. This would be

* Driver supports plane color pipelines.

in v2 (unless somebody requests another change).

> +	 */
> +	DRIVER_PLANE_COLOR_PIPELINE	= BIT(10),
>   
>   	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
>   

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

