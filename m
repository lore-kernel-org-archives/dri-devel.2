Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1955606A330
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CW03zdj8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F6611217D;
	Thu,  5 Nov 2026 07:27:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6EB112194
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:27:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5187660213;
 Thu,  5 Nov 2026 07:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C2E1F00A15;
 Thu,  5 Nov 2026 07:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793863636;
 bh=HoQSRqfIYqOgLi8XZHfv0mjjaYOJ1yDtBes6djU885c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CW03zdj8MeEJIWWk1xlof4nIHkkGPw1ul6DVk4+mqlHQ/GKPe+u9wFStzAJaWXXlK
 mLLFTPBkyxYd+nG2eztJhQPDf8CD/3do7DMqJUEVIv+OwseNXvaTJCfc0nsl+mmn7l
 Ob0ZjL4WJ7sKnDtxd4uZk+caYGmykcogtO85X5H8dT4PwVYU22z1IVoKzevyJy38OX
 PZ8m1VB7klgLjqzOYgsTt3RLdPBJSJw67OIfgRFvPcy/Sa1qOLN2AfV1HK5XfSsJxS
 j9H/apafPegn7I/sWd7NuWJpPKqIKOnAT3KnwiWIV/rNxnpoStS7DnFHzSVE2Vvgq5
 Kmh7i+i1d2mRQ==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, Inki Dae <inki.dae@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCHv3 02/13] gpu: drm: exynos: call
 cec_notifier_phys_addr_invalidate if no HPD
Date: Thu,  5 Nov 2026 08:22:16 +0100
Message-ID: <5ee88620981fe6e99d6a512c6d7491093f3da2ae.1793863347.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a HPD is present, then call cec_notifier_set_phys_addr. If not, then
call cec_notifier_phys_addr_invalidate. This helps the CEC framework
differentiate between CEC_PHYS_ADDR_INVALID due to no Hotplug Detect, or
due to an EDID without a Physical Address.

This driver is one of the few that was using cec_notifier_set_phys_addr
on disconnect instead of cec_notifier_phys_addr_invalidate.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 055dc04f9b3e..d03f4e531e05 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -857,7 +857,7 @@ static enum drm_connector_status hdmi_detect(struct drm_connector *connector,
 	if (gpiod_get_value(hdata->hpd_gpio))
 		return connector_status_connected;
 
-	cec_notifier_set_phys_addr(hdata->notifier, CEC_PHYS_ADDR_INVALID);
+	cec_notifier_phys_addr_invalidate(hdata->notifier);
 	return connector_status_disconnected;
 }
 
-- 
2.53.0

