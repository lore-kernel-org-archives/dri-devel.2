Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA1606A33D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=SxtcvOkv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BDD10F429;
	Tue, 24 Nov 2026 10:08:43 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C9D10E83D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:36 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 438DE1D0A;
 Tue, 24 Nov 2026 11:06:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514761;
 bh=ltZBsbuuLUgLruugJggBgV13oqzFIQW+pA1XxlBJnRI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SxtcvOkve28bs3tsVAdkcKTPqn4J6dd+mr5psdT3aAQPEHip4GV9hLsc+KY1MQM8H
 tJxdIE07M3TVYECDzKETvdZuIPo6GQGKuRnidKX0YcyMbHmV2++hjXEyaQzmIbEw6g
 G8z9RBcdYm34Kdl+sD+bVMO9lqlFCpz7V/XkpwDI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 24 Nov 2026 12:07:56 +0200
Subject: [PATCH v6 05/13] drm/bridge: tc358762: Drop SPICMR write
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc358762-fixes-v6-5-bd38fed6460f@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ltZBsbuuLUgLruugJggBgV13oqzFIQW+pA1XxlBJnRI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWIXOUyPoe9xQIjhc5ZTtJRvuBcvt9j+licSc
 uFW5ITGyGaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViFwAKCRD6PaqMvJYe
 9RFTEACX0Gl+X5BHPetvJp4/9G/Qw/OKrXJ0FwiQO+wTv6LpepuFZm9mmnuW31JhB4ukRif7yce
 jaMtHhS9lYUrGN3bZBJ3JBdrAxV3swPTWY2ym6GXMf0pGSEBBU4fAK3Oy97LPwtAGqixZ4yNErV
 UzfNXy98sjNwQEOrQ5n600Nx9aJk+pvx8H1dLMJe+LjThYq9OrHAnsFAqu01zOCfZNMxW7nFov9
 jeuqQkLMOGjnyi230cX/af0RuBzzflmr+UME7/I8mshFiAKDJKEpcYsHpLptOMZD4kJiZlxKTJw
 cvqGY2Z7VuLJbfGP0QPOnvLIYdzDZc+bMhLIQxZJjeIJJcpUCnmxEfa03ioAKDRBwVNoiCppc9L
 bSS2XyqlAjsK9PoTlAb7ZgaOKhr6SoBsXnq+P4e5n/p7hxJxB1+IB5/VdbsDjhc+SFrUjLKneqz
 t2qzqJOMXdYjImwxExNeOlxQdvJgvremBuaz6S+MdwapdcQwnJcyJljJrLGcOnKukMMq2rwm2qC
 g98L7sxhlXUdT+j1y3ybHX7eBhmCsh4jfefVVxRLHJfAZFH+B8b50oX1wZXbl/D7H6unw9jzXes
 aG+GKkBudAOhFQ0MbI9dpQ59p/Cvog6jxBKkKOvdfU9DBWWOrKXQ19OQBXajUV4wiDvsxDn30qJ
 aGO7yKpnWi9n2fw==
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

Drop write to SPICMR. It's unclear why the write is there, as SPI is not
supported in the driver, and it's mostly just writing zeroes to already
zero fields (reset defaults). None of the zero bits written disable
anything wrt. SPI.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index f5ee781275fc..91bc79d36a74 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -149,8 +149,6 @@ static int tc358762_init(struct tc358762 *ctx)
 	tc358762_write(ctx, PPI_D1S_ATMR, 0);
 	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
 
-	tc358762_write(ctx, SPICMR, 0x00);
-
 	lcdctrl = FIELD_PREP(LCDCTRL_PXLFORM, LCDCTRL_PXLFORM_RGB888) |
 		  LCDCTRL_DPI_EN;
 

-- 
2.43.0

