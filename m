Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2008606A329
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcDKX9nc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400BA10E35F;
	Fri, 27 Nov 2026 06:13:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B811510E35F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:13:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 886C7439A4;
 Fri, 27 Nov 2026 06:13:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795759982;
 b=McGBfs6affbwUrHjaxi58by3ZjdERqe91Aef2zdFm0MTI8/KQk3z0Noqk5xBubsZ4ceh
 14dOCZAvsXZPX64LbNtUYwGqNlokFJsg4XVCHxBuwVI7l2TWoKOpoSC3z4bi5XZJDMWVn
 JLu/azeDISBIXXLEc8cpNf3sY6QT9vhRycLjzNrwcmubcetSDa3qDFvxOtmtvbyLCRfis
 jTtpjO4sf+3RKN31xi3sjjqFBuCgRY9SZVplVpRo1wI8AXz2kgVQ4TBW4yAr21fQjup+q
 giZbT8nhBbiKHnAVArF0SdYG/Ao1ggV5xgWu2toVLJQBoQxe1GE9s/m2xdKCb60ZPNg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795759982;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=+21aXSIhxglzzoXkMAiio1qQ/0kfiM8rQZc7UqiPAfs=;
 b=wPUMBWzSqP0C7FXA+L51Zq0cDPARuujtlg6cfmyn+HFF1W/zzft34B+mx8+WyPj/VSr+
 pi2r/2T+0krC96QNzfCU8gzark2zyTH7qIdG+Wc22lcwn/NHiPz/PdckbdzXAgk0YX735
 vkXMZQR/z6e1eL9bM7blauWs6Sr09Rifq3hrZddTOo0sOn1VxNlDqCpFzOM5A4ANVrD2j
 BrTdZ8ube4fIo8RdPf5xEQA1Yt7RpE/W2kK8mt0RTt/nG4e0Wz4kYjPyyknps2DVIWS1r
 PfufjCA5axa4uFi2VdUn8FCWx/OrJoKmq6qZBnR2kASkN6XSAZHnw+meZhD9+QI646w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C12981F00899;
 Fri, 27 Nov 2026 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795759982;
 bh=+21aXSIhxglzzoXkMAiio1qQ/0kfiM8rQZc7UqiPAfs=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=kcDKX9ncepVtuwjyJoi4sudyslTA9ITO5I9WiO/GtdXvqxIWfeLx7NT453qKplkVI
 ANxKPhvptBKrlXs8lgqwnVH2eD/GLo1VnRYbagL5ZSdjtVASMCzIUA8mZ5Alh15caP
 nT/Gblx50ECVoFMBR25a5D4U11CoX5G3lOv9wXd0vi7ywiNQVKsYvKxFLIzRLkLuH4
 dyLYt2Ofhq2/Dsn1a4txiru1yE+iBhBcc3mg/6zcAuwMLkiX1ah8prTzbfTS0IepIj
 mDlrSnCFhA97sfVxOkshdStV/K4xaHSO9lmJ0GfvnQewhaLvrvEnzenth+FxBP4xx6
 8tln9b5k3lGGQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3D5494B5A9;
 Fri, 27 Nov 2026 06:12:57 +0000 (UTC)
From: Hank Liou via B4 Relay <devnull+hank.liou.mediatek.com@kernel.org>
Date: Fri, 27 Nov 2026 14:12:56 +0800
Subject: [PATCH] phy: phy-mtk-dp: Suppress sysfs bind/unbind
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-phy-mtk-dp-suppress-bind-v1-1-eb64c6e39240@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAGcfCWsC/x2MQQqDMBAAvyJ7dqGJWsWvSA/GbOpSjCFrRQn5e
 0OPwzCTQCgyCYxVgkgnC+++gKorWNbZvwnZFgb90E+ldI9hvXE7PmgDyjeESCJo2FvslqFzfdN
 aRwZKXpTj67+eXjn/APeP2aZqAAAA
X-Change-ID: 20261127-phy-mtk-dp-suppress-bind-5c85f734dfeb
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
 linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Hank Liou <hank.liou@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795759976; l=1859;
 i=hank.liou@mediatek.com; s=20261126; h=from:subject:message-id;
 bh=O3jXFQr6H1w8UsvUZJ9qBE1F3KBO3rzzg1q1UUmq4PE=;
 b=0Qq9O8JaNLT8C+2TcaCnF7eQXA+zB8jRSZrFJjKrHanyORj07ENpyhfdLhjuUmcbhxvvAtinQ
 qlksxz2dR4sDTTdl3HiVOxkzXmeqU+Q3aqgo1eD3lvZ57A98med4pIm
X-Developer-Key: i=hank.liou@mediatek.com; a=ed25519;
 pk=oQN2zU+HMrJQgqX4bhL5CVRrBmac4amZ/53yK20L/6M=
X-Endpoint-Received: by B4 Relay for hank.liou@mediatek.com/20261126 with
 auth_id=1646
X-Original-From: Hank Liou <hank.liou@mediatek.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: hank.liou@mediatek.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hank Liou <hank.liou@mediatek.com>

mtk_dp_register_phy() registers the "mediatek-dp-phy" platform device
as a child of mtk_dp and caches the struct phy returned by
devm_phy_get() in mtk_dp->phy. The PHY driver still exposes the sysfs
unbind attribute, so root can unbind the child while mediatek-drm-dp
stays bound. devres then frees the struct phy, and the next
phy_configure(), phy_reset() or phy_init() call from mtk_dp uses freed
memory.

This was observed on a MT8188 Chromebook running a ChromeOS 6.1 kernel:
after unbinding the PHY device from sysfs, plugging in a DP monitor
panics in phy_reset() from the HPD IRQ thread.

The legacy PHY device is only created and destroyed by its parent, so
set suppress_bind_attrs to drop the bind/unbind attributes and let the
PHY go away only together with mtk_dp.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: Hank Liou <hank.liou@mediatek.com>
---
Other PHY drivers disable sysfs bind/unbind for the same reason, e.g. commit 6aeec986f1bc ("phy: samsung: disable bind/unbind platform driver feature"): their consumers have no way to be told that the PHY went away.
---
 drivers/phy/mediatek/phy-mtk-dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 0048e1a8c6..924f08ed4d 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -828,6 +828,7 @@ static struct platform_driver mtk_dp_phy_driver = {
 	.driver = {
 		.name = "mediatek-dp-phy",
 		.of_match_table = mtk_dp_phy_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(mtk_dp_phy_driver);

---
base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838
change-id: 20261127-phy-mtk-dp-suppress-bind-5c85f734dfeb

Best regards,
-- 
Hank Liou <hank.liou@mediatek.com>


