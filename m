Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0DE606C800
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BF3P0op7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F089E1126C4;
	Fri, 13 Nov 2026 16:39:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC511126C8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:39:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27B4862854;
 Fri, 13 Nov 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794587960;
 b=KCBwWLIKmGRhnbZ4JIHExnweLunSqpxQitEir4TgC18qMhOGlBDQf4caBV7P9Z8kajSK
 cMfxNgnoWOiSsSM7U1d04OjhKQgmGjXvbketaDHVNbPbOOf/xc4WgxyGp/Kcto5p+amw8
 umcbSqUYfLcMbpfhZSbQRhzqj778pF1GtFJc2sG9g0koDfzvg+6WOo570kvWBmziU+SXw
 fZ5N0xAhZRU+V6ddSp+pqooZ0jcz0jxF9+8y0h1l2zhb+baKrUT7rjhdUfDOKEpmntuoY
 su4WLeeyINMmEk/lpq6LgdLLP/YbieDVIPBx8Gtj05p+mkVZfos1P/NU+droyrYOQNQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794587960;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=caHdCdnbVcnoOel/8I7UgJt2cA+i1z3iFohsViZm+c8=;
 b=QFBwRPmXQz8/ORnGwKzacdzeWOhyfdDgL6nzxi01iKv3hSGi2ikq6gcstaeKKMZC39kr
 4vLGn+54d6N7pMWP8+PPcp7SYH233camf0ymW71ZHy8HEPlUWkID2m2X7+yuJePGhd3Ii
 YHTFaMiKt0Slx5wAbNd5grvlHC1NHQumEh3AZusy6ZgpGJouvuaETlr1czrp+BLnrarY7
 nmxpPxL4cZ+lw6kBeX1G8RIbO82sy++L8BmfyV5FwpigtGr2iPeIlWK/kHdPFowHjJat7
 DrQkMGhjI7BiJM639BbO9VEsKB0ZyC+qOUNqgEUyK4vde4NjSzQoC7UbSYuucvjlkpg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0487F1F000CA;
 Fri, 13 Nov 2026 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794587960;
 bh=caHdCdnbVcnoOel/8I7UgJt2cA+i1z3iFohsViZm+c8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=BF3P0op7c2BWvEgg0RtMnms7ouOFhgltbvdPt9NTMVsXxxw/Q/NA43L5Qdejrbj+4
 WC4sUZRs6KTu1fT6lrqgJQy95avT3GqwzTZDULgyIoZmQfIIJdT919Wn+iejEIUMPJ
 cVmK3KGzRjUqTRxvKLvtIugGKnFicdH857BjH7PtbqaU9Nx74h5zl3Jvn6YyRa/zMm
 W7K+IM+ptt12rz4rkNOgOUrHrMtR/kc0MaY5CTEdPOC6C/eKG94hQOSHp2sOhAtaA+
 n94Ms0FSBYCBTdDsb8f/8Im7NHK0UKmQ1pYA9MD0hSfc2tbstuELUrSRNbzZ4clG/h
 gGTTvkWzfdHhQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F15BF499C5;
 Fri, 13 Nov 2026 16:39:18 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:39:23 +0000
Subject: [PATCH v3 6/8] drm/rockchip: vop2: Find the first mixer of a video
 port with Esmart3 too
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-vop2-fixes-v3-6-08ae37e83b5c@gmail.com>
References: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
In-Reply-To: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Damon Ding <damon.ding@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587957; l=1927;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=LaWGFuV8U702iZKb4Y58/lyq2u07OMYD+M2uTNx0CjI=;
 b=J6XMCpRpakdX/82Mh/t68AfoQvfvi3DwZT5Oa8EoTLFXDHbPHxyhrtYJYgsWQTPAJgUeuLN1n
 kDIMsIddEZCAmZRyeY3ZJfGoQpkNc+CPWbBGtw/9NaZLP88Sz9WYzma
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

vop2_find_start_mixer_id_for_vp() passes ROCKCHIP_VOP2_ESMART3, the
highest window id, as the bit count to for_each_set_bit(), so Esmart3
is never found and a video port whose bottom layer is Esmart3 programs
the mixers of other video ports.

Add ROCKCHIP_VOP2_MAX_LAYER_ID after the last window id and search up to
it.

Fixes: d3fe9aa49585 ("drm/rockchip: vop2: Use OVL_LAYER_SEL configuration instead of use win_mask calculate used layers")
Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 1c2d7d97a6c2..87982fba7d45 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -805,6 +805,7 @@ enum vop2_layer_phy_id {
 	ROCKCHIP_VOP2_CLUSTER3,
 	ROCKCHIP_VOP2_ESMART2,
 	ROCKCHIP_VOP2_ESMART3,
+	ROCKCHIP_VOP2_MAX_LAYER_ID,
 	ROCKCHIP_VOP2_PHY_ID_INVALID = -1,
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 6d08988d7007..55e5dc8b02d8 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1882,7 +1882,7 @@ static int vop2_find_start_mixer_id_for_vp(struct vop2_video_port *vp)
 
 	for (i = 0; i < 31; i += 4) {
 		match = false;
-		for_each_set_bit(phys_id, &win_mask, ROCKCHIP_VOP2_ESMART3) {
+		for_each_set_bit(phys_id, &win_mask, ROCKCHIP_VOP2_MAX_LAYER_ID) {
 			win = vop2_find_win_by_phys_id(vop2, phys_id);
 			if (win->data->layer_sel_id[vp->id] == ((layer_sel >> i) & 0xf)) {
 				match = true;

-- 
2.55.0


