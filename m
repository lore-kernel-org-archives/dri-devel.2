Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CEAC624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C7C210E0BC;
	Thu,  3 Sep 2026 07:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ko1/DUbu";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C4210E0BC
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:31:54 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260903073152euoutp0294e6199304965bd2d24930f03f4ccfe4~Rvym2M3Xe1641116411euoutp02a
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:31:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260903073152euoutp0294e6199304965bd2d24930f03f4ccfe4~Rvym2M3Xe1641116411euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1788420712;
 bh=P90KN+OojKVERzLGtqb8KXxoAOaOXuBascy+p+dwixQ=;
 h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
 b=ko1/DUbuC0sG1YKC+qLyzlmqPHGh2FO6gQdmHrsJz5+WXOc2fK5RCjJr2u2U3dCTG
 GvfDO7Fyxlqw9839Crh8aOBtLdV7bl+EFDZqPXcwz8cana1eIRvHLBQTBC2RcVop2l
 kt7J/La/iQJJhpiDPJscr+wPcK2sMAsZHaqlUMwo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260903073152eucas1p244d122a79c2ce35e806eb834b7bd30f4~RvymW7c6p2890828908eucas1p2j;
 Thu,  3 Sep 2026 07:31:52 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260903073151eusmtip155334bba9d37658a6ce5aa58d3e17328~RvylQydky0401704017eusmtip1N;
 Thu,  3 Sep 2026 07:31:51 +0000 (GMT)
Message-ID: <17971ca1-74b0-4d55-8275-031eed939c34@samsung.com>
Date: Thu, 3 Sep 2026 09:31:50 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] drm/bridge: samsung-dsim: drop gpiod_put() on managed
 TE GPIO
To: Li Youhong <dayou5941@163.com>, inki.dae@samsung.com,
 jagan@amarulasolutions.com
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 dri-devel@lists.freedesktop.org, Li Youhong <liyouhong@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20260903065259.3194417-1-dayou5941@163.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260903073152eucas1p244d122a79c2ce35e806eb834b7bd30f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260903065359eucas1p1b25249b4e3e1b9365abd2efe3d6cd83a
X-EPHeader: CA
X-CMS-RootMailID: 20260903065359eucas1p1b25249b4e3e1b9365abd2efe3d6cd83a
References: <CGME20260903065359eucas1p1b25249b4e3e1b9365abd2efe3d6cd83a@eucas1p1.samsung.com>
 <20260903065259.3194417-1-dayou5941@163.com>
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

On 03.09.2026 08:52, Li Youhong wrote:
> From: Li Youhong <liyouhong@kylinos.cn>
>
> When the Exynos DSI driver was generalized into samsung-dsim, the TE
> GPIO acquisition was switched from gpiod_get_optional() to
> devm_gpiod_get_optional(), but the matching gpiod_put() calls on the
> request_irq() error path and in samsung_dsim_unregister_te_irq() were
> left in place.
>
> With a managed descriptor those puts are wrong: the GPIO is already
> released by the devres action on driver detach, so the extra
> gpiod_put() drops the GPIO chip / module references a second time.
>
> Remove the manual gpiod_put() calls and keep free_irq() for the
> non-devm request_threaded_irq().
>
> Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Samsung DSIM bridge")
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> drivers/gpu/drm/bridge/samsung-dsim.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index e2fc69fc51b6..f6aa1403e184 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1874,7 +1874,6 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
> IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN, "TE", dsi);
> if (ret) {
> dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
> - gpiod_put(dsi->te_gpio);
> return ret;
> }
> @@ -1883,10 +1882,8 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
> static void samsung_dsim_unregister_te_irq(struct samsung_dsim *dsi)
> {
> - if (dsi->te_gpio) {
> + if (dsi->te_gpio)
> free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
> - gpiod_put(dsi->te_gpio);
> - }
> }
> static int samsung_dsim_host_attach(struct mipi_dsi_host *host,

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

