Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DB606A334
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=P1826twT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CCE310F432;
	Tue, 24 Nov 2026 10:09:37 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA25310ECE4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:38 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 73E092138;
 Tue, 24 Nov 2026 11:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514765;
 bh=6xUgwbcSdHtlDVcj+YK6T6MQTPPJ2b2Uv/YxT+h6csY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=P1826twTeiEBX8ANl2BCGZPPs9zVfU8YSSkvuRGUVgRq1PyC5cjFlQfjfJxuiwkq2
 ZaoM/X/IMFjsKbT/M18A0gD1CraCbpTgHZGtKqwlPqq96EEdvJP2p0jbDhX5k2IEuY
 wVMvn0XmqeJ4qEZPJkVZueqKQ4pssVJehkCqwL9k=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 24 Nov 2026 12:08:00 +0200
Subject: [PATCH v6 09/13] drm/bridge: tc358762: Fix sync polarities
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc358762-fixes-v6-9-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
In-Reply-To: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=6xUgwbcSdHtlDVcj+YK6T6MQTPPJ2b2Uv/YxT+h6csY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWIZkRhU4L5zsY96Mu26Mvu5c5k7C0y+6aIGB
 VICSdRDWlaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViGQAKCRD6PaqMvJYe
 9fChD/9SwsBMQDDy4pULI8k3UhH2oHpzz1aMb6lThKnICsXn7rlHlrTiowCg7bIKODEKwlXA6wM
 deGPmlZ8LivOok3gurMpDm3WpqrMvRPWFCWhSIvNXr8WeTxRpbT08dGhb6sYcuG3IRPTvvfoIPZ
 Zm2n5AdM/I1l9gUfosT6WYe0DcC/2AWTb6uxCTQas8iC2C+ulW2n/DL0y+uMZancWBL1q6/SUFa
 DZ/Z3nGFgIIlE8FS3uGSJzeVfpcTFx8i4l7p7fVW4iWJrLXYvMbghQljcZhSq1ez7yozPdHCiFY
 p9ofbixVLum7dIuHA9z+zgQyULO8m2bMlmwHVNJbgY3KSi4Js7CMlLawuchjKgorPHLdmZeP/ep
 IvIdnX5vQJzM745q0EYGG70XA+BgfEWobDdhkQs/dH/Bs8fnrZF37cf/k7udkk2HBSKYXtHnuud
 e7Oeb/EYNjLd/8yFDKoJ5P2g/1G3pxClWejP4LZgOsPLfJCGITahFewX6B/XJ6MYt6JUQiavcBa
 u6yFakuta49FxHKU1W/5T/jsaVNpnEIF1oJaqKAIMIjGVM5ouQPZmeMtQDohQm3q1N+o8o6hy0J
 +iq8N41CFMP8x2oNRh/+8Q3+nYtNGUPqe35eyt3PIhPc0/L0MW2+XzuR98BggdkVD01Z/v7SHT3
 MTcsmuPCQ2w2VTw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Setting LCDCTRL_HSYNC_POL and LCDCTRL_VSYNC_POL will make the respective
sync signal active high. The driver does this in inverse. Fix it.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 3ccb5aa40446..7a2658933216 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -190,10 +190,10 @@ static int tc358762_init(struct tc358762 *ctx)
 
 	lcdctrl |= LCDCTRL_DCLK_POL;
 
-	if (ctx->mode.flags & DRM_MODE_FLAG_NHSYNC)
+	if (ctx->mode.flags & DRM_MODE_FLAG_PHSYNC)
 		lcdctrl |= LCDCTRL_HSYNC_POL;
 
-	if (ctx->mode.flags & DRM_MODE_FLAG_NVSYNC)
+	if (ctx->mode.flags & DRM_MODE_FLAG_PVSYNC)
 		lcdctrl |= LCDCTRL_VSYNC_POL;
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);

-- 
2.43.0

