Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EBEC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 12:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D0A10E1A8;
	Sun,  5 Jul 2026 12:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d7HINp2y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140BC10E1A8
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 12:01:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7747141B70;
 Sun,  5 Jul 2026 12:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D151F000E9;
 Sun,  5 Jul 2026 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783252899;
 bh=8VB/Yde9WwUZSzHZNla+a60srDPe+CyYZ3Qn4u6zv1U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=d7HINp2y+EbqNdMnO9hjINkAv1BTljVXoU9l/WQkQylgqp1wUqygEwKuykG4iF/TO
 oBHZIuEZGTiKKxP/vO1bsyvQCd8uoCYkDQDuLGLs21awr0o8gLYA8M5dLpmFFEnoZF
 yXnJ/3UbOWi2qbjLhMWThhR1cK3YIx1CQNIuz3NVlWqxv7LQjjwhl+dnDkO3WfePkg
 O2h22C5QJUtsIjJPQkNUyDkC0Luq8xuLJ4vmMxon6UuKomitHxqm+K/ZbPFift0HAa
 X9LV7W8D5bZQ7yR+aOGYI70QVWsWt/vQ5R7I5widBxjVeg7hGgeg4nFX35UmVxRLbc
 RAVB2W8TqgdOw==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wgLXU-00000001PSw-45fs;
 Sun, 05 Jul 2026 14:01:36 +0200
Date: Sun, 5 Jul 2026 14:01:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2
Message-ID: <akpHoM1a4r64iIhi@hovoldconsulting.com>
References: <20260704174113.255485-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704174113.255485-1-lgs201920130244@gmail.com>
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

On Sun, Jul 05, 2026 at 01:41:13AM +0800, Guangshuo Li wrote:
> mtk_hdmi_common_probe() gets the DDC adapter with
> of_find_i2c_adapter_by_node() and registers a devm action to release the
> adapter device reference with put_device().
> 
> The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
> adapter. This is not paired with the find helper and it drops the adapter
> device reference before the devm action drops it again.

You should mention that i2c_put_adapter() also puts a module reference
that was never taken (of_find_i2c_adapter_by_node() does not take a
module reference, unlike of_get_i2c_adapter_by_node()).

> Remove the extra i2c_put_adapter() call from the HDMI v2 remove callback
> and let the common devm action release the adapter device reference.
> 
> Fixes: 9545bae5c8ac ("drm/mediatek: mtk_hdmi: Fix probe device leaks")

This is clearly not the change that introduced the issue as this driver
did not exist when it was merged.

This should be:

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")

You should also CC stable.

> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> index 7bbf463056c9..e668506daf67 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> @@ -1501,9 +1501,6 @@ static int mtk_hdmi_v2_probe(struct platform_device *pdev)
>  
>  static void mtk_hdmi_v2_remove(struct platform_device *pdev)
>  {
> -	struct mtk_hdmi *hdmi = platform_get_drvdata(pdev);
> -
> -	i2c_put_adapter(hdmi->ddc_adpt);
>  }

There's no point in keeping the empty remove() callback.

>  static const struct of_device_id mtk_drm_hdmi_v2_of_ids[] = {

Johan
