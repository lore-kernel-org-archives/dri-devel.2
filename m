Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB82F43821
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32DAD10E6F2;
	Wed, 15 Apr 2026 14:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="mK+rrhy9";
	dkim-atps=neutral
X-Greylist: delayed 937 seconds by postgrey-1.36 at gabe;
 Wed, 15 Apr 2026 14:21:16 UTC
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com
 [203.205.221.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D8510E6F2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 14:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1776262874;
 bh=X423UGRy0ZAt+/V3gZHEoyo/x53TY58dVujUIeUwt54=;
 h=From:To:Cc:Subject:Date;
 b=mK+rrhy9UhjXVbbndzIt89ley6iOJjKigvcsHL09N7Y2ZZ1RQBgNfgglVtLIs8hrG
 i65m0ErQ0zEiVgnlADr4iQA6h6zpFsDuMnNmE2+076OHOXHRa7OmRyEFeVnEGJWNSB
 j0TUSbhCTBiZdRL2PRiUzITZw1UWx8oUYUPwMRns=
Received: from localhost.localdomain ([171.223.89.103])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 15D1AA0B; Wed, 15 Apr 2026 22:05:29 +0800
X-QQ-mid: xmsmtpt1776261929tv2p75q34
Message-ID: <tencent_516ECD6F12A7B8D859A1752D090236D2AC05@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2MZfqQBUSGlXDFAuplL9vYEoRLr0LYx+fxn3ouHGV68HFF2wdVT
 m7J+hnvPHLVml45ITgD4T89j/dTRInU2lZqoRR5TH16cFBxMUQaGcTZ2mG6dbItLgAj5Kq/QtqLh
 qoKMUnHPARGvy8jfpIv70vTy0eExf5vd2kqFC9xWc2A/hDOlmVM5pFNpLra9kqOqkFIDOKxCTx5e
 3ak2z6h9G/lApyWsBsvmBp9TSH13WjReieY1vYwSZVpI7jc78QcEBSSNFakxu4wDheVbxP28vOlx
 +vnFrHbuItoF+MuSOsw0klP6Jy3ZawoR6zvElDJGnC8+yz13148U9kk1pg39Dyx7kPR4R8VlmsiR
 boPj0fpnx3Q4dUuFhqol+L8B2eMom22ePMOoOWfDMJenNxBedUT5whsUnHx6zoENkCFS8VcIoi5h
 eS2lHnoOPsmHduwKJcduWrDrbKRcBlrF7Lx9GeMvtjLkkXYI3toYlmop1+CyQEPKZjprH6NxS+bx
 qpiZ5n7JmLmOspvcJXkzrAfQN41gCuIxQQfR+MAHRk+IM/2XALi3eKpJUIz69sC1cHPWmisRr6sf
 q4iu4GhuQjm4WovxNbpP+Wy0yUXjjT/qjg2JEMdSWM1IUsSqPyAwiYSktPypi/5UU6SZsFVY+zlS
 g8dtbTHxU5ksGkojOpuROlTY1uqLC15+yjJZoVOaeSWEWippE+YUmjKXs4cx+L0gY/valgCsMaYf
 tIPy0oNX/dcCXh+c6Uz25YpqBgUbTbzN3gs2ixf0qb+P0+iFvppKMiT18vpDJAkSvg+VX3/FoOMI
 psORiDX25zHTr+tMD2o91XeJcylRrODyyr8Ejtt+lAwwtOm43anRY9azWFuxhhQVYk7SkBfxiXyj
 x1GaFbsyKZzHCVivJdTE6A68DPOrunFCJ2NPneehxSELANPHoDCYX0gd30b1M05/AViE4uqshrHA
 BpaUDsCfBAHPdBa5UtMupJgW/XVNHI57QdCRk+otlFz1VyEkGcFhmOP9HoDVyRbB/+GfXNFFQU5V
 M0ODDXvsI3biGUl5TwzUse2NueQC0xExAjXiIHa4S8u9TmwI2X8HJM1yYb2x9X7qfJGZmt3g==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Renjun Wang <renjunw0@foxmail.com>
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Renjun Wang <renjunw0@foxmail.com>
Subject: [PATCH] drm/rockchip: dw-mipi-dsi2: add sentinel to rk3588_chip_data
 table
Date: Wed, 15 Apr 2026 22:05:09 +0800
X-OQ-MSGID: <20260415140509.8325-1-renjunw0@foxmail.com>
X-Mailer: git-send-email 2.47.3
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

The while loop walks rockchip_dw_dsi2_chip_data  entries until reg
is zero in function dw_mipi_dsi2_rockchip_probe(), so rk3588 needs
the same sentinel termination as rk3576 to avoid reading past the
end of the array.

Signed-off-by: Renjun Wang <renjunw0@foxmail.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
index 0aea764e29b2..8fd4653520df 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
@@ -483,7 +483,8 @@ static const struct rockchip_dw_dsi2_chip_data rk3588_chip_data[] = {
 		.reg = 0xfde30000,
 		.grf_regs = rk3588_dsi1_grf_reg_fields,
 		.max_bit_rate_per_lane = 4500000ULL,
-	}
+	},
+	{ /* sentinel */ }
 };
 
 static const struct of_device_id dw_mipi_dsi2_rockchip_dt_ids[] = {
-- 
2.47.3

