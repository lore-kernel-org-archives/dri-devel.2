Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C6606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=opiy9NOu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5896D1121B8;
	Thu, 29 Oct 2026 10:19:27 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F201121B2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:19:17 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E28E1552;
 Thu, 29 Oct 2026 11:17:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793269023;
 bh=OZYSeepAIWcZMJ2STpTUzemap4QopjkzN7WS/XD4SPw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=opiy9NOuoZHew/XXBz1ELgeCbiS1UAH0uRykgjLDE4agJbvaPanounH54j4glXZDy
 X6b0EHVHFGXG6j4UPMN8BUxL3r7qVlJgy9jom3RDSN24ZeAHk4iVOIkfxbA+5s+wLu
 TVAZgxM2TeMcCPNhLYABYvgVZO5gz57wO48CDLPs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 29 Oct 2026 12:18:53 +0200
Subject: [PATCH v4 07/14] drm/tidss: oldi: Fix wrong return value from
 tidss_oldi_mode_valid()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-beagley-ai-display-v4-7-dc7f2b532478@ideasonboard.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
In-Reply-To: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=967;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=OZYSeepAIWcZMJ2STpTUzemap4QopjkzN7WS/XD4SPw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq4x2Xbba05PnhzU/ShK3qQxyASekJkrlxJLK02
 yhEX19haSKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCauMdlwAKCRD6PaqMvJYe
 9Q+wEACQV41JZWtVhPslC96ShYfqZwRvnST6EO5qvaLlHsm8wjMkgFj4vV9cKC+vnV+wdOxeMSO
 e1N9yIiepp+Y47mkzv4sz4DpUo/s/jom1HNlXFdO6MBngGr5yCosV9L291pt+0lP8yUYR9DCCwe
 d4YWS+AEy49Zs5FZgLjhm3w9HnBF8tdo9i8D8ByVYT6ad7rL5k+OITh+b6ZcKV4llTho2i2QU8I
 oE2ae203lvVmIisRT6ZkbRlkxZcl5ShjrIGRpbupENDB72lGt+BckOPbIGrFdhFquXuujy81dEp
 I5mSnhG1NNMztfsITjUBHEw/uzW30WH6RAO4W6zvlNIVXFIy4351GZ8dTnlogxjFYpU5WjB6zq7
 5QOYuNUEnAItSwPVsz4Op8bCN4UfHHau3m5LSAnJnLdpjGrKqU///WPsu20S1DVDpGVTwVZPHEp
 33qztLmL8TR4kqcd5zUtNi2fnOL0831t3nqs1WDTAVJruiO20pgXBdLi6deWNIy2p7krgEkbK8k
 ktPNzrc1qgsNdejoRGpg2QvmrxpGXI4xYfN3SO2wSju6PbsKM3r8LCIe1XZXcRmEVE3VkeykCVJ
 XErp7yRvIteUfU59yqFvgjHNj6jp0vGeACOXULeDSdFWmqrqI4rKPS2p8/yHpugfXYu+RVUQYJ3
 K359ty7O/ExjOnA==
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

tidss_oldi_mode_valid() returns 'enum drm_mode_status', but the current
code returns -EINVAL or 0.

Fix it to return proper enum values.

Fixes: 86db652fc22f ("drm/tidss: Move OLDI mode validation to OLDI bridge mode_valid hook")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 82b059f85244..ae27ebc7306e 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -346,9 +346,9 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
 	 * we use the same 5% check here.
 	 */
 	if (dispc_pclk_diff(mode->clock * 7 * 1000, round_clock) > 5)
-		return -EINVAL;
+		return MODE_CLOCK_RANGE;
 
-	return 0;
+	return MODE_OK;
 }
 
 static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {

-- 
2.43.0

