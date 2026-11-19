Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E45606A333
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=sUDXz2NH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F372710E5B4;
	Thu, 19 Nov 2026 09:29:15 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC0610E5B4
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:29:09 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261119092908euoutp025785e1eb223d3e6b54074d993fbc1d98~paD_AwL2S1633916339euoutp02s
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:29:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261119092908euoutp025785e1eb223d3e6b54074d993fbc1d98~paD_AwL2S1633916339euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795080548;
 bh=mq0FLTMcQeJNISswd40D5VVFtrL8xT8puyhzXWwNSuY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=sUDXz2NHi3pGNtSeD9+2c4mClmlE67a5OLWAK5hZuBCzd2bE2t5XQjWH/tcIk78Jc
 /pU2SO9jNE3AzA2yNpcof+JUBtQKOxfk61M4taxzfFoK/kKf9WGxqLZZCdQpJR2/qe
 nLAiBo+10Ai3TNSriJ29Bpyif7Ag5rRNG0oAhirk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261119092907eucas1p2d8c811bd49cf4369d5fc66d052abfcde~paD9jpmIU1894818948eucas1p21;
 Thu, 19 Nov 2026 09:29:07 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261119092907eusmtip1d9eb3c2cce8e9ff0bf075f7f5f976fb8~paD8wR9X90676606766eusmtip1E;
 Thu, 19 Nov 2026 09:29:07 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Damon Ding
 <damon.ding@rock-chips.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>,
 Douglas Anderson <dianders@chromium.org>, Brian Norris
 <briannorris@chromium.org>
Subject: [PATCH] drm/bridge: analogix_dp: Hold runtime PM reference in
 bridge detect
Date: Thu, 19 Nov 2026 10:28:55 +0100
Message-ID: <20261119092857.1158971-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119092907eucas1p2d8c811bd49cf4369d5fc66d052abfcde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119092907eucas1p2d8c811bd49cf4369d5fc66d052abfcde
X-EPHeader: CA
X-CMS-RootMailID: 20261119092907eucas1p2d8c811bd49cf4369d5fc66d052abfcde
References: <CGME20261119092907eucas1p2d8c811bd49cf4369d5fc66d052abfcde@eucas1p2.samsung.com>
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

analogix_dp_bridge_detect() calls analogix_dp_detect_hpd() without
holding a runtime PM reference on the DP device. If there is no HPD
GPIO, analogix_dp_get_plug_in_status() reads ANALOGIX_DP_SYS_CTL_3 and,
with "force-hpd", analogix_dp_force_hpd() also writes to it. When the
display is disabled the controller is runtime suspended, so these are
accesses to possibly unpowered IP block.

The connector created by drm_bridge_connector is polled because the
bridge provides DRM_BRIDGE_OP_DETECT without DRM_BRIDGE_OP_HPD, and
userspace may also query the connector state at any time, so this path
is regularly executed with the device suspended. It affects only setups
without a next bridge or panel (e.g. a DP connector), as otherwise
detect returns early.

Take a runtime PM reference around the HPD check, the same way as
analogix_dpaux_transfer() and analogix_dpaux_wait_hpd_asserted() do,
and report the connector status as unknown if the device cannot be
resumed.

Fixes: 2b77a2918c5d ("drm: bridge: analogix/dp: move hpd detect to connector detect function")
Closes: https://sashiko.dev/#/bug/linux-ea09d64b-12cd-4301-bd54-12c515b01bde
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 84951413012b..9b7d770d1fa1 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -905,9 +905,15 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
 	if (dp->plat_data->next_bridge)
 		return connector_status_connected;
 
+	if (pm_runtime_resume_and_get(dp->dev) < 0)
+		return connector_status_unknown;
+
 	if (!analogix_dp_detect_hpd(dp))
 		status = connector_status_connected;
 
+	pm_runtime_mark_last_busy(dp->dev);
+	pm_runtime_put_autosuspend(dp->dev);
+
 	return status;
 }
 
-- 
2.43.0

