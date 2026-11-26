Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B5606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=VGVreo6J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C97211282D;
	Fri, 27 Nov 2026 08:29:16 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 13:11:32 UTC
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95207112192
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:11:32 +0000 (UTC)
Received: from user.localdomain (unknown [223.80.110.101])
 by smtp.qiye.163.com (Hmail) with ESMTP id 561f6fac9;
 Thu, 26 Nov 2026 21:06:23 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
 vkoul@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, jie.qiu@mediatek.com,
 junzhi.zhao@mediatek.com
Cc: neil.armstrong@linaro.org, mani@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, liguangshuo@mail.sdu.edu.cn
Subject: [PATCH v2] phy: mediatek: hdmi: Fix potential stale PLL provider on
 unbind
Date: Thu, 26 Nov 2026 21:06:22 +0800
Message-Id: <20261126130622.4073620-1-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa217f6da9903a2kunmd1d1900f35cb30
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh9CVhhCH0MfQh0ZSk0ZHlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
 Y+
DKIM-Signature: a=rsa-sha256;
 b=VGVreo6JblqymZugb0+4qCtBedflwSKtMKFPEPUwtLOPRBf1bqaoOTw/IUQ1UtMTRhInHiPaD0h3NIHRYV0OacgYxdq4PaqbdqHKy1tM9bjdqoaMMzdAhehUUh30H1jXGEnP480VMFA2EK68jAkNk9VeOxAYhgiOxK/Bqk0BdvQ=;
 s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1; 
 bh=mKr1keYM02EumLxC+PGjz0vKlqa4GJrbdZwQ+sNCyN8=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The HDMI PHY registers its PLL with devres but leaves the OF clock
provider registered on unbind. Publish the PLL hardware through a
managed provider so it is withdrawn before the PLL is unregistered.

This issue was found by our static analysis tool under development.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
---
v2:
  - Update the patch author attribution to Tian Xuechen.
  - No code changes.

 drivers/phy/mediatek/phy-mtk-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index d063fc787c28..06784393b0ef 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -178,8 +178,8 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	return of_clk_add_provider(dev->of_node, of_clk_src_simple_get,
-				   hdmi_phy->pll);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &hdmi_phy->pll_hw);
 }
 
 static const struct of_device_id mtk_hdmi_phy_match[] = {

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.43.0

