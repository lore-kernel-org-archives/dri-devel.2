Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D627606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxbQ/N/s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D2B10FB8E;
	Thu,  5 Nov 2026 14:21:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A3A1123F7
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:21:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDF2343EBB;
 Thu,  5 Nov 2026 14:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA431F00919;
 Thu,  5 Nov 2026 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793888503;
 bh=Pr16zjmi6Ey4gHIDg3KsJXX4JIQlmrJMdXkq+NJkdzM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GxbQ/N/st1p0e/jMhwBDBsV+LLRT/yET9vrJyNqKTJQSWWKzAcd0M3NtHj+OzNrQV
 QY5LeqVHdfQrgwo+rtM32mZ4VmvI5lEvfQ2Uu+VGavJlzsjkRM3cqpR7R4PUtwQXRl
 Q7nuZyRz9aFoECQM5F1vvVXi9NAFIzsFXq/RkqqLx2coBD2yMURLPIWly/RiSCG2Z4
 GKYS7t6RYhFpu0TW2XNs2dPI5ld4hYtl2HUYUIa8NFGdr/YkQCS4vzSW2S7HH5qofX
 TEfgdYfGWdlkiX+SI72m3TAN4UUA71fcvefUdNarwRVAE/6Mexlczl26Jh9cRSp4MY
 v5hY+typysMlQ==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 4/7] MAINTAINERS: Remove Jonas Karlman from bridge reviewers
Date: Thu,  5 Nov 2026 15:21:24 +0100
Message-ID: <20261105142127.708219-4-mripard@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105142127.708219-1-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jonas Karlman's last review for the DRM bridge subsystem dates back to
2019, and he has never committed to drm-misc. The bridge subsystem has
been de facto reviewed without his involvement since.

Remove the reviewer entry to match the current situation.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bdb8e1bb32c..122a802a4eb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8954,5 +8954,4 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Robert Foss <rfoss@kernel.org>
 R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
-R:	Jonas Karlman <jonas@kwiboo.se>
 R:	Jernej Skrabec <jernej.skrabec@gmail.com>
 R:	Luca Ceresoli <luca.ceresoli@bootlin.com>
-- 
2.55.0

