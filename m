Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE6BCD3447
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 05:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E85810E03A;
	Sat,  9 May 2026 05:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="XAW7qdfO";
	dkim-atps=neutral
X-Greylist: delayed 556 seconds by postgrey-1.36 at gabe;
 Sat, 09 May 2026 05:47:33 UTC
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [95.215.58.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A37010E03A
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 05:47:33 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778305095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5V5bu8wkVupwenl9kEt3EBNU8qJQmy9AXZs1gAf63t4=;
 b=XAW7qdfOIy5LLS+BTo7puF2YCVhJIuaCojxqMd05ujk61bqCA0XWrYdz0O3eelGXYByVWr
 wUZVI417lKey6DWb8pW4IgevbJivmj/tvgpoF+Iv2zVwgb4xi0TP7GiytKE0YCzhW+UBpN
 ml8YbgAmM+ybJPAwCOFEHhh3om2uj8U=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: shijiaqi_develop@163.com
Cc: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 heiko@sntech.de, hjc@rock-chips.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 p.zabel@pengutronix.de, Fushuai Wang <fushuai.wang@linux.dev>
Subject: Re: [PATCH 3/6 v2] drm/rockchip: Fix vop2_create_crtcs() error path
 cleanup in vop2_bind()
Date: Sat,  9 May 2026 13:37:37 +0800
Message-Id: <20260509053737.54007-1-fushuai.wang@linux.dev>
In-Reply-To: <177830024278.246051.2541513211000360573@openclaw.local>
References: <177830024278.246051.2541513211000360573@openclaw.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 8afabe2118a9..1234567890ab 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -2735,7 +2735,7 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
>  
>  	ret = vop2_create_crtcs(vop2);
>  	if (ret)
> -		return ret;
> +		goto err_crtcs;
>  
>  	ret = vop2_find_rgb_encoder(vop2);
>  	if (ret >= 0) {
> --

Hi, Jiaqi.

Reviewed-by: Fushuai Wang <fushuai.wang@linux.dev>

-- 
Regards,
WANG
