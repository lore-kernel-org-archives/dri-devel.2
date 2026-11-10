Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00736606A332
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz9tni4C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8C810EE58;
	Tue, 10 Nov 2026 07:19:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426C110EE51
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:18:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70DA341432;
 Tue, 10 Nov 2026 07:18:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794295133;
 b=A7JwVDefH9OPRgPc9/usUtlo9QPY6UlJO8lWr7ER0gZB2HhF1Ty7sHW69yyCNnRsmv5q
 MxeU8fXA2T+e0r/0UAdyuM/TiZojmn+xL34Id9jKY2xKhk55ZrgSxGolSmG/6cP/ibQ5Q
 6Jf/wHwuiM033VTnrH4vTENxZKv+nhwHFoBEkwjv+aLerdrU4fuErFR80330vdKfXzYjc
 CgYx3CcnzyfyKkiyfJgJB20YJRPABhagsXXJkmaXWaoSNT1N3RV/Yapkw635Xkd52tMnS
 pyIy+GodFxgTWcZkQTgDLjp0QJEvLtkkMBaEn5olsKvmJtnh6n/+Q7l9lFBaEsDl29w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794295133;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=J2agN2crGUChBNyRpetJq57O8IKkI+AJqP0nz2zxorQ=;
 b=JSoK7UMgX7s4G0+VjzuLJ3WEzKSX5Do0DzulnEK7tjgXLg9JzbC/9CWVc4aQ6IQKhczf
 Sk5fnzvniaHCppJYSvqxNAJdCd+RVeKmjD/kSuyrUfiWfmuQ7mrZ/T1eoI/XTxx4/kYcm
 TSb+uA9ajuUdkIFIzU6aZOEUyW/5m+G3DEEMlhveA8Omwo9vNsDq1bDD2hZlKWAw/BmPg
 E79UOT1kZ9/2J3DuHgpSNQUxDzFltqLkGWpoJVCkJYx5piT8tgDDdbuDpuyOXpQ8f+BLP
 GhZSzJWLuoQ4U5Fsz13fB/BtEnhW/MVR0a6azYy45UoKZobne/lV4yNNZIrSh79e9Zg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A83DF1F008A7;
 Tue, 10 Nov 2026 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295133;
 bh=J2agN2crGUChBNyRpetJq57O8IKkI+AJqP0nz2zxorQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Bz9tni4CDwoGZHWhkeFntaFp5LBmlFGZkHbU7G3L9ktlkpktihipGwhfLjZ9HYgHR
 YsQPxGiWU0dsrvSI8+memHGPHHu9k6asqOOG9KVpLbVv9Bt/2Dh89vGyqOREL6Hz6c
 chz6M7K/gn4qZfeKtNSpuQn3bm4NhYvE7VcSdiXitpPkaVNExFAvqpOGiv36i9w1og
 WPOCWe1YF4chjmg1tbXSd3sb+0jyO/0R4/DfWEiOuORwZPPdlhU15Rq/P/m8RIO71N
 NS1hBXiuaVtWGGyHR1cRc1VxMNkjgbBzLgDab7mbpLYP3wCYCBjKR44UtrG0LbG3RD
 o76OtYg1qrxGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2D601489CD;
 Tue, 10 Nov 2026 07:18:50 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:18:55 +0000
Subject: [PATCH 7/8] drm/rockchip: vop2: Keep the other LUT_PORT_SEL fields
 on gamma LUT updates
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-vop2-fixes-v1-7-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
In-Reply-To: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295129; l=1358;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=/+0LMBwuZNZCecG+Fu7CU68hi7oF5xZmzzhq/ceRbpE=;
 b=Fdfc8Pef3L3/LJG/JYhZ8bVLGge3v3zhLIa/A7NLxZww4zOUUh0lqK0533jFx9all8T4yvLz7
 qoNNcyGyEa7Cunqff53gUq65Zr1YK7O9iVo1iwKArccs+wmYyf1Baeg
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

On RK3588 the gamma LUT of a video port is written through a window that
GAMMA_AHB_WRITE_SEL in SYS_CTRL_LUT_PORT_SEL selects. The register also
holds the dclk source selection of video ports 0 and 2 and the enable of
the video port 0/1 merge for modes wider than 4096 pixels, which writing
the whole register clears.

Only update the write select field.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 3323e50224c5..9ad138457204 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1774,8 +1774,9 @@ static void vop2_crtc_atomic_set_gamma_seamless(struct vop2 *vop2,
 						struct vop2_video_port *vp,
 						struct drm_crtc *crtc)
 {
-	vop2_writel(vop2, RK3568_LUT_PORT_SEL,
-		    FIELD_PREP(RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL, vp->id));
+	regmap_update_bits(vop2->map, RK3568_LUT_PORT_SEL,
+			   RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL,
+			   FIELD_PREP(RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL, vp->id));
 	vop2_vp_dsp_lut_enable(vp);
 	vop2_crtc_write_gamma_lut(vop2, crtc);
 	vop2_vp_dsp_lut_update_enable(vp);

-- 
2.55.0


