Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E51C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E31910F4F5;
	Thu,  9 Jul 2026 11:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pu85P2Og";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9172610E6D5
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783596717;
 bh=dgSiMPi4AYj3N/GiA52EKPGuymrYrUeC48hkQYWmpzw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pu85P2OgQsZzse2Z+jn/Jhp2XUhUkwrcLXirQIGqooNVjhZMW/cGUbgsROWlkN+ms
 HQzdCXfnTIERJ98B0XF8QF5NRvp3jnaWVgNXBWFXHFpkRrnOWRk7L43G6N4r2+Kgjk
 oT68NZAUTEedyg6SxyGdzLXJ6/JU5b/hhA3pmTnFlc3ZKsN95WzS8vuC/xHAN7DZy+
 nOKEVioW+W1hLEg8O0JzoqmB+xhnn2ksLPKeyhrP9nctHp0Ba8vRQawGH245/ERYcs
 IybomlvGI72C8L9witIfX7/SvLXJ8vKxf4DmuSeOlk7mRNu3poJclLqgwt1qSqRojn
 L0CFdsATio1Yg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A80D17E0D53;
 Thu, 09 Jul 2026 13:31:56 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jitao.shi@mediatek.com, granquet@baylibre.com, rex-bc.chen@mediatek.com,
 dmitry.osipenko@collabora.com, ck.hu@mediatek.com, amergnat@baylibre.com,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v4 03/12] drm/mediatek: mtk_dp: Call pm_runtime_put_sync() in
 removal path
Date: Thu,  9 Jul 2026 13:31:39 +0200
Message-ID: <20260709113148.49090-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since pm_runtime_put() queues an asynchronous suspend, calling
pm_runtime_disable() right after will cancel the pending suspend
work.

Call pm_runtime_put_sync() instead during mtk_dp_remove() to
overcome to this issue, making sure that the suspend ops execute
and that the hardware correctly powers off before module unload.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index f656b85b8421..0d0507890d99 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2866,7 +2866,7 @@ static void mtk_dp_remove(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp = platform_get_drvdata(pdev);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	if (mtk_dp->data->bridge_type != DRM_MODE_CONNECTOR_eDP)
 		timer_delete_sync(&mtk_dp->debounce_timer);
-- 
2.54.0

