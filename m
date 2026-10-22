Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0F606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=airkyi.com header.i=@airkyi.com header.a=rsa-sha256 header.s=altu2504 header.b=iGK9olYf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439CA112373;
	Thu, 22 Oct 2026 07:19:15 +0000 (UTC)
X-Greylist: delayed 172144 seconds by postgrey-1.36 at gabe;
 Thu, 22 Oct 2026 07:19:07 UTC
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E887610E363
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 07:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1792653505;
 bh=XQtpwBbNQSG09Tws7x6dKc8i9V8heR9xSsqFP4cmwGE=;
 h=From:To:Subject:Date:Message-Id;
 b=iGK9olYfhfA4y021DIIpEgCiYqOum0QL2mTxvkOeiW7s50/EaBQuuLnI3/rn1fRwe
 Ph0E+YRqvNKa0x+mntAy/PIhYPvnYNcZTsKH6/PAa5y9digGnuKSskxE4aJnMVR79t
 nQC74wdCrapIBqIGIETOayRCjLOpttRcUFmybZ8c=
X-QQ-mid: esmtpgz10t1792653498tf61c24c6
X-QQ-Originating-IP: HX1t2sOuxhJHsPQIrTI7coDscVM70zdTd26TmRi7hpU=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 15:18:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3961529649271326920
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 2/3] drm/rockchip: vop2: Skip UV plane setup for packed YUV
 formats
Date: Thu, 22 Oct 2026 15:17:36 +0800
Message-Id: <20261022071737.508-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261022071737.508-1-kernel@airkyi.com>
References: <20261022071737.508-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NoZl3lE/gOeTIssJYm9dwfUzK2ivny64agxuuKT8sgLXssg5JwxufI1w
 rjwrwj65Qi8kRktx8CsotRy92BiF17hKXmpGBPKlwfBYSnwCjomxrp8bFQGH27V8IrRc7Vi
 e89CXj3GPYnC7WMsqPPwomsFuiazyiKNJHpBgLMxh5SNr5KW5CEcsEtey5J9Vf4oiCl0jBM
 CQDe5ZCre85244mGheF4CG+ZnXrDDFxSX0bXNrZlSY6ePn95oQpTgEQ8ann+BEDBSI85cs1
 olXdc17oKME+67Q1lVZaLGit4mWj6b3/Smaw9K4ZS0CK7r2URs9O25gjS1HN2Ph2o7uy0oq
 Y6hUWNVE+CINNL2zHHfiaAfqB6uNDuJrOnuZvI9UXOD7/AM2p5chPI5s2+T6xaUmdZIMUUb
 DTHvb8/XSZ4kUDKj0T+NVs9XTmV9ck39aG7z4S8y1KY6D7nnXwvyNKCQQEfvvMi+kbZNZ7z
 NnZzFwnldKTL7BhJdP3SUZPUws+djhzauVTgWyJwulwobkjlepbmzlpMXD8SDQGMMbxYgPJ
 Vc/l6UKsuCSlfK77YiBwdjQsF1+p808Fjp1+i6bN7yzPZ2pSfxKkgZkKEauEhKUABQZ6ROf
 BY36SyoVLWpRfHQ01Up1w1WKnf/QrDsvc1zjkKvU9og8xwbfyDUjxzqsIb/oz1+t9K3poLN
 /Yx2/vqVebY8N/g8SA+fESyG7OoEeslTJu82wxLwz179No4Zz6YxMhDNeGLoLItfcq/jLwD
 OwgSWANpRDYFhRfPbRZfIxQl4daN0Gln/jQt7qO4AynXKcR8lceoqY+OjOsEVby274+l2QS
 HvaYLwqIQuMItQqOZUJWPe4udgsBQKNiLEWeElhIW9malH7EwsWpLAzdn/bITK+Wfs6vhSP
 SAxm9cIhB7uNastRIbFEKhFZr8PulbkVg5EhVr8ZoT7pbBAn9QJewaTNGaEbC16nUedOjfe
 XxJKeKCsiVxum22u+/DBIbKQg1Cpty3838s1Uve1kGZxdLU1mslM7KGrmrxj9zRp7yQ+G48
 uSp+dNUyLsfMuPDJLm
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Packed YUV formats store chroma interleaved with luma in the same plane,
so they have no plane 1 that the UV address registers could point at.

Restrict both the plane 1 offset calculation and the UV register writes
to formats with more than one plane.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 480aa8c8a8d2..42ef1b996656 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1305,7 +1305,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	rk_obj = to_rockchip_obj(fb->obj[0]);
 
 	yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
-	if (fb->format->is_yuv) {
+	if (fb->format->is_yuv && fb->format->num_planes > 1) {
 		int hsub = fb->format->hsub;
 		int vsub = fb->format->vsub;
 
@@ -1461,7 +1461,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	uv_swap = vop2_win_uv_swap(fb->format->format);
 	vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
 
-	if (fb->format->is_yuv) {
+	if (fb->format->is_yuv && fb->format->num_planes > 1) {
 		vop2_win_write(win, VOP2_WIN_UV_VIR, DIV_ROUND_UP(fb->pitches[1], 4));
 		vop2_win_write(win, VOP2_WIN_UV_MST, uv_mst);
 	}
-- 
2.53.0

