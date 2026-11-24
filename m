Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B9606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=cxjL4YKb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7901C10F42B;
	Tue, 24 Nov 2026 10:09:04 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF8510E856
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:37 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 573E22082;
 Tue, 24 Nov 2026 11:06:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514763;
 bh=CWUq5Ef6O4fjXDdCF7Z4ZeT2vzhvSq1EHxE/RYS8yjU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=cxjL4YKbm+4dtJncrjg38BQ3KJi0Nkf3M6W8P3OaNEe8aToFp5NFNPf2/pPaJIua1
 YxV4IbAq4+0oqQpyEsmd1xbHIpolfApGgorrSQRvATnCjj9iUIB+2y1oI2aRZU4I8l
 T8w39XF6po5XtSFIDDDEJFgS7+DN8PMngGTYZaMs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 24 Nov 2026 12:07:58 +0200
Subject: [PATCH v6 07/13] drm/bridge: tc358762: Update comment about the
 number of lanes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc358762-fixes-v6-7-bd38fed6460f@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=CWUq5Ef6O4fjXDdCF7Z4ZeT2vzhvSq1EHxE/RYS8yjU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWIY3UoKmHpQgw3Fd98/qRtiPO+lNbIa+5gqH
 HDlXQ4n2TyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViGAAKCRD6PaqMvJYe
 9c4lEACWNqgtEDX1g0+jTdJ1U8GsriiNiXaxOpvVYSWicwZQlFwc8nzTOVKebMe8WGu5nLP1s53
 zmGyLTnsbtNRbaTwYi9pNqR8BTluGNxhCEgsiQV1w0+A/yuoENw6RRut4NnLbJr3YNzdIy2x+Eb
 aQQ/UAnhY5S6oy/aEXA1uTrGfnDkDmrNxueM/KmOssCePYYufvFEGBnf8kePUxY1aP7d3446GAf
 EBYbg77Q01IuWunojrQEwg+tp6uqmX1tTn7m51hQ2cQq0QvfttL/tuVdUvBsKV004RCbMAVqZ5S
 Eqe9jexN4QHrEADr52UFMpftKshM/Ii7MByNAs7zI0lPPj2rgKSVXKkhbAyVhkCTtdkEkKif7Zc
 feyB+uc+ze7dYP7t3C3AGgSag1rT3scD27A/6ahvjn+FEsnVAadBPHAUtIAKwJK0Son1BqAhSmX
 urc+q3vfZ0b1DR6eYCJUMSHWG/aOfpE/tE75ENY094H73DMA7nLVDkvQJ17MD+QtVLzMferKyvR
 605CY7Rv8K60cyxFG2fMG0BhUi7LuwrMwDUygiou8GT821hJ5oNNJLnDUkLrZ6IGdqhr1SWlWov
 TsQRcNW4ROaIa19hOuOoNlve4VCboPJ9o/I1OwfBtXCnADaBn7nEDtEHMmxdpKhx0mpaUwuTE7s
 qPFcoz0SjOwnJNQ==
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

Update comment about the number of lanes.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 0933fc974a7c..59323f26b2d2 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -309,7 +309,14 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	ctx->dev = dev;
 	ctx->pre_enabled = false;
 
-	/* TODO: Find out how to get dual-lane mode working */
+	/*
+	 * When using DSI clk for pixel clock (only mode supported in the driver),
+	 * the pclk is derived directly from the DSI byteclk via simple divider,
+	 * which is either 2 or 3.
+	 * The required divider can be calculated with bitspp / 8 / nlanes. Thus,
+	 * for RGB888, only nlanes = 1 works as nlanes = 2 would require divider
+	 * of 1.5.
+	 */
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |

-- 
2.43.0

