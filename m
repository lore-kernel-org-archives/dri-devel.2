Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC90606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c4+IHGpO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F0510F6F9;
	Thu,  5 Nov 2026 14:21:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E98410F6F9
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:21:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7D5C609F8;
 Thu,  5 Nov 2026 14:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21401F000C1;
 Thu,  5 Nov 2026 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793888507;
 bh=y2EkE4zSQAvC+7idJ09PStW4fXOJe6Q7zMv35pj/vWU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c4+IHGpOhRYSNNEwl52cXoqin/Tbr48D/3oJYw55NqIWnPINSVaLZE6viFokRfxmz
 4szWJ9HWVo8yB7HQ7mDB86EFTjwHMNDPUQ2w0wyL5YYzhGjLmJhIrdWdQ8+JLTXl/N
 YUg+rPsH+lE5fXTSsUF4ftUCTxjaBwimrOa7kBQITQyoGbOERsVpIilyZLghxmPquP
 PeRy/uyD/rHkwb2zV0RULOHRZ5QtYZxZeRv6Y5twcbc8cY4KOoRHBh3Oe6lzsq6okA
 hZGiiXjxWIVwg0nnQPVMfaNgAtzUmBEsKmQIFddX7zKka0oXeSrfxp7dqRFEko+Jva
 JjSG/KB8N0ncA==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 5/7] MAINTAINERS: Remove Andrzej Hajda from bridge maintainers
Date: Thu,  5 Nov 2026 15:21:25 +0100
Message-ID: <20261105142127.708219-5-mripard@kernel.org>
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

Andrzej Hajda's last commit to the DRM bridge subsystem dates back to
2021, and his last bridge review to 2023. His focus has since moved to
the Intel GPU drivers.

Remove the maintainer entry to match the current situation.

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
index 122a802a4eb6..9dcaab8bd5f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8950,5 +8950,4 @@ F:	drivers/gpu/drm/atmel-hlcdc/
 
 DRM DRIVERS FOR BRIDGE CHIPS
-M:	Andrzej Hajda <andrzej.hajda@intel.com>
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Robert Foss <rfoss@kernel.org>
-- 
2.55.0

