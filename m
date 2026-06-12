Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD751CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 21:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0228F10E110;
	Fri, 12 Jun 2026 21:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fi/8K/sD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400FD10E110
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 21:52:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A05F601DD;
 Fri, 12 Jun 2026 21:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADEE1F00A3D;
 Fri, 12 Jun 2026 21:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781301132;
 bh=fSxRWIcl9qU/LEj4Rcxpx/wptYk0R48ylx0jgepqy34=;
 h=From:To:Cc:Subject:Date;
 b=fi/8K/sDey3qBtFAbLERDJWoUDVQJdX/x0+AuxxgJvu1yp+9MddIaMB4X+pvvGwHG
 CgBw9xO55Fs4BpkTtz4PRRYn3z3y2JkiiyJ/QYWsXBWGOcKFco9aDxEuwF59lIuY7U
 5utLrGbAMhp/S3tsDMtbUiVBrhR5NJ4XDhZoNBS8+95G0+rBDHYEk0AyFFDTKvI3CY
 E+5OheY3OCEc2aAtxMi1C1Dco65DmTBq6bQScFt6A/baGtwO11+blbpoplxAwxlCT+
 X9HDnJBABFl6R82je5uxMDkSgTPTkzMy2EOgs2kPLsYzEFb571PfxgGmJ+mf6VzKln
 L01bhI+K+x6jw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: sii902x: Read "sil,i2s-data-lanes" as u32
Date: Fri, 12 Jun 2026 16:52:04 -0500
Message-ID: <20260612215205.1887206-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The "sil,i2s-data-lanes" binding and in-tree DTS files use normal
uint32 cells. Reading the array as u8 only works because the values are
small, but it does not match the documented DT element size.

Use the u32 array helper so the driver follows the binding.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 12497f5ce4ff..c27e41573b19 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -862,7 +862,7 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		.max_i2s_channels = 0,
 		.no_capture_mute = 1,
 	};
-	u8 lanes[4];
+	u32 lanes[4];
 	int num_lanes, i;
 
 	if (!of_property_present(dev->of_node, "#sound-dai-cells")) {
@@ -871,10 +871,10 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		return 0;
 	}
 
-	num_lanes = of_property_read_variable_u8_array(dev->of_node,
-						       "sil,i2s-data-lanes",
-						       lanes, 1,
-						       ARRAY_SIZE(lanes));
+	num_lanes = of_property_read_variable_u32_array(dev->of_node,
+							"sil,i2s-data-lanes",
+							lanes, 1,
+							ARRAY_SIZE(lanes));
 
 	if (num_lanes == -EINVAL) {
 		dev_dbg(dev,
-- 
2.53.0

