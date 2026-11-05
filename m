Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93CB606D83C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KUfR5Obr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFAD210EA1B;
	Thu,  5 Nov 2026 01:01:32 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6923F10E8E2
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793840475;
 bh=t4xm3scI4l7rWR2iBzxLstmE0RTUxpACdTblDz3oXNQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KUfR5ObrP8jFka/2UPUUWjo5o+FDtK93b3osH2OAYgNva3uJp9kGslkH1OJPda5Zf
 15X8CZOFNP1JNd9dCYuNZEnWFFVWRV3JrpqciB3HKcITk1exygNn1GPePk2JiLZIqy
 6LiQEhNSQKDr4q5w8frc2zPmaLmytXKMtIYys4O7CaqzfsjbFZfi+PKeGal9ZXjTR8
 2aOHtllwVzPI6ymja4nt2se6eWSmqQrg96a6lqDvy0zSfwfzPdLW84D9dTz2l55iyb
 As6jY4tda6vDPVLhwlAfVOQybrhbMNzJC/cveKrTF6i433O+G7wby2GR2vUOTHaOmq
 KvkFfAhG1aXCw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 038DD17E0CE8;
 Thu, 05 Nov 2026 02:01:15 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 05 Nov 2026 03:00:46 +0200
Subject: [PATCH v6 12/15] drm/rockchip: dw_hdmi_qp: Do not mask error code
 in atomic_check()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dw-hdmi-qp-yuv-v6-12-1bb63ef5766e@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
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

dw_hdmi_qp_rockchip_get_vop_format() calls
drm_atomic_get_bridge_state(), which takes the bridge private object
lock through the atomic state's ww acquire context and may therefore
fail with -EDEADLK when the lock is contended.

The DRM core expects -EDEADLK to be propagated up from atomic_check()
so it can drop all held locks and restart the commit.  Replacing it
with a hardcoded -EINVAL defeats this backoff mechanism, making
otherwise valid commits fail spuriously when multiple threads perform
atomic commits concurrently.

Propagate the error code returned by the helper instead of
unnecessarily overriding it.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260902230603.AF5C61F000E9@smtp.kernel.org/
Fixes: a18aa0dd7a0b ("drm/rockchip: dw_hdmi_qp: Implement "color format" DRM property")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index f2a1ea8dfefa..db1933d75ced 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -203,7 +203,7 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 
 	ingest_fmt = dw_hdmi_qp_rockchip_get_vop_format(encoder, conn_state);
 	if (ingest_fmt < 0)
-		return -EINVAL;
+		return ingest_fmt;
 
 	if (hdmi->tmds_char_rate == conn_state->hdmi.tmds_char_rate &&
 	    s->output_bpc == conn_state->hdmi.output_bpc &&

-- 
2.55.0

