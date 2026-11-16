Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB16606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.a=rsa-sha256 header.s=altu2504 header.b=WkmvYP94
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3ED10EBB3;
	Mon, 16 Nov 2026 08:47:17 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71EF10EA64
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 08:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1794818780;
 bh=xsQByQ0D6Ix2x9EDzpTjaiHgbcand3FUuNn+57t5Hbk=;
 h=From:To:Subject:Date:Message-Id;
 b=WkmvYP94G1jMmCFBA3kmzWG4uv/8CZkDrJFEFxQuJojl+a/Neg1lMkAj/8y+7/cgv
 jQdHg0gplNZWzOp3dRXKV6BLSSQnbgzbkneeWtZvHGjVprtDoyJ4EYVFmto9D/dGnR
 MJ71XBhxSGXxJtT/LxvTFmbkN7eCrQDaBFS33y+I=
X-QQ-mid: esmtpgz13t1794818773tdd28430e
X-QQ-Originating-IP: TBPlYzybBYcUlZTHNZ5djQ84nZ6wvxk85DaLGnl+X4Q=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 16 Nov 2026 16:46:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14606022908303960892
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
Subject: [PATCH v3 2/3] drm/rockchip: vop2: Skip UV plane setup for packed YUV
 formats
Date: Mon, 16 Nov 2026 16:45:54 +0800
Message-Id: <20261116084555.1061-3-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261116084555.1061-1-kernel@airkyi.com>
References: <20261116084555.1061-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NXAwOXNh0CeGsAHYVU5ebLtx3oOy+pS1m7AX/6mk1qAn0uEi3lrU1m5K
 T37jYmNnI/X0o4RCax/7X9OLGuZ8ZqSg6TJnayvcV6J0EumuXWTWaSDPGPlz2WOCRg739PM
 W6b0KrJwGLbv1e8XjuzAYM1Win9qVr07fhAoIcPl1hJqayf2LvvXM5PNENLkjLUttHs30xn
 peGlT/UlBu2QlK35MlzcuFmCrDwo2RVnCuzTCuvXQgkjsUK4nkyxTjWPiLkG2gmoD2bvPXK
 OS0gk2ZrmK85+ZZKN0ioovhBmCSAleA+zCUZEQ5IGYfwFozVpfsuKntecuAFAJb2f1hEoMk
 hvozHmGkXVMgyp1NFPTMEe9IL8BQpHB/sug0TLdoi4pINKpBJOmFAZSnVqBVBxk1GsOUFqg
 qXowtxBJZySZZVfTi0lVjhl3o/iIBc8sghIGMRHAc+O5O9vDHqi0mV083kZA68/K9SamFL6
 5/AT+ikoGQc9a/rY9TfBnxnUtFhUQSZ7nhY+XBY9lVXByOQIo5Vjdu8WCZR0cnnUiMOKgZZ
 4Rfv4/J1TiXaJrovYY6ja9kfdeZhTupTnqMTWolg99kONrI0g+uGV39hHcmK7EMOxEAIXop
 FfWLY6sIHHPf6rtk85BoSU6iFFVX7xNao3MMUDQmtddU2MW2roDStWJoNyIvD3sdwvxfAWQ
 miS26GOxPoD9Mbg6ud4MFi5SGWJyidkd+CTovwqhv5gGDcsC5ZC8XL6WeEOKwNfOzLxVnba
 3LwePR1P8LPX2mkaTGHmA7slfXdaviIoJk+74s21X6pkV3Ac0VpZ12/0ecku3sWsaLH3wXA
 Au85ZBXfegt+Z+24FWfJnmapG/mieLQUTXm+fMUjZk4B4xA0DIs/nPUbAK1J6DK3nmf/nxx
 xJXLd9FMLJChI1ctKgdP1P7XxQi4XOxdtvxRGZ0+NyTK4Vrt7hkdqLzF3zWki4byWiP7mpV
 1k6jVTiGyCHgJxWxL2lHtC7Giip2AugiaKGkwG2Xkwj2pqumpDWrXSFIrA48fmXExRKllbQ
 fYh/T4zfNGepL+fCVp
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
(no changes since v1)
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 0de038acb56f..e811709bdc72 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1305,7 +1305,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	rk_obj = to_rockchip_obj(fb->obj[0]);
 
 	yrgb_mst = rk_obj->dma_addr + offset + fb->offsets[0];
-	if (fb->format->is_yuv) {
+	if (fb->format->is_yuv && fb->format->num_planes > 1) {
 		int hsub = fb->format->hsub;
 		int vsub = fb->format->vsub;
 
@@ -1460,7 +1460,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	uv_swap = vop2_win_uv_swap(fb->format->format);
 	vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
 
-	if (fb->format->is_yuv) {
+	if (fb->format->is_yuv && fb->format->num_planes > 1) {
 		vop2_win_write(win, VOP2_WIN_UV_VIR, DIV_ROUND_UP(fb->pitches[1], 4));
 		vop2_win_write(win, VOP2_WIN_UV_MST, uv_mst);
 	}
-- 
2.53.0

