Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC538606A330
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n74+Xaes
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3FE10F3F5;
	Tue,  3 Nov 2026 07:40:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D2A10F3EC
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEA6A605CB;
 Tue,  3 Nov 2026 07:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC741F0093A;
 Tue,  3 Nov 2026 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691625;
 bh=c8V9WqB9aQgta0XAH5FjnMzK6loax9fei5rQGTIoZqw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n74+XaesbQDDsHa8YCBq1ZMY4IJFf8ObGbvhX+84CI5nw2eZjOVNAjgwLAejpnmPM
 h2aDWAVOgWkisvAcsw2xd1zCujRzOClY1J/RnRUZOzo+XbKxf4d8Goo8KAZGzYdHb4
 9NnpJF0sSfCZo83g1yuTZo/89Rr+LZs3XTOTJdZjSRbXWb8EMSGe0FweswSQvL8dPG
 4Mla0+sWJQT8ngFIDB/g/gqZgbg7tF+NzMXKAVF4nGs20QSIWnY1Ic6+ylSZPDw82E
 kBjFifZ5pKrGbMHuAlorUjbc7yfZzp6944Wts9bIocV4d+PPa+lFT8Tv6vt08Qx/jj
 4hv4/bqYqVCag==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>,
 Inki Dae <inki.dae@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Maxime Ripard <mripard@kernel.org>
Subject: [PATCHv2 02/13] gpu: drm: exynos: call
 cec_notifier_phys_addr_invalidate if no EDID
Date: Tue,  3 Nov 2026 08:31:53 +0100
Message-ID: <80b02c6057f32dd8be8b4de95d1cd27352cdddc8.1793691124.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
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

If an EDID is present, then call cec_notifier_set_phys_addr. If not, then
call cec_notifier_phys_addr_invalidate. This helps the CEC framework
differentiate between CEC_PHYS_ADDR_INVALID due to no EDID, or due to an
EDID without a Physical Address.

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

