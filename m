Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A125606A32D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Heh2dHHA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D8D10ECF3;
	Mon,  2 Nov 2026 10:55:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB3810E609
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:55:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 643ED43D7E;
 Mon,  2 Nov 2026 10:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36731F00A1C;
 Mon,  2 Nov 2026 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616901;
 bh=UvuKznDDisWzpXJVj1vFfyQGluqPP7ZnNuIADfdvL1w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Heh2dHHAEvcV3QenFMWZTt6kM0t6urxfM1SScVB7aD2B3BdLsP989ZiHK2pNimAAA
 70ZuAp/FscS2VGdcdWoU4Y9gZY6VXSP6d+wwLJMpyIN82x6Nu7wrrPWN3ic5nnHlP2
 8oMkyYeVKKR28zZuCGKmkh40fcfCl99BqM7HZBwOmaYqe0XyElsUGz24pQmdvV7G2L
 jIjTk+uTcF2L4dGsTewGWFDQ8mksSRT5DTdN+xaH21c+045L6reWlmXcGmmxEAfVue
 1HbBc2dqYmAxmfguku60QHDLHW7E5QrDnOMmDDEusy2pEdvKBV5zhTZZdCA8itMVKh
 kbzaV4xNpcyKQ==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 03/13] gpu: drm: omapdrm: call cec_s_phys_addr only if EDID is
 present
Date: Mon,  2 Nov 2026 11:36:54 +0100
Message-ID: <d58e8dbe49a0af87e2e98463d620e33a8115c109.1793615824.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
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

If an EDID is present, then call cec_s_phys_addr. If not, then
call cec_phys_addr_invalidate. This helps the CEC framework differentiate
between CEC_PHYS_ADDR_INVALID due to no EDID, or due to an EDID without
a Physical Address.

This driver is one of the few that was doing this inconsistently.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/hdmi4.c     | 7 +++----
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c | 5 +++++
 drivers/gpu/drm/omapdrm/dss/hdmi4_cec.h | 5 +++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index bd6c4d2dcdc8..056bede2ec8a 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -439,7 +439,7 @@ static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
 		if (hdmi_runtime_get(hdmi))
 			return;
 
-		hdmi4_cec_set_phys_addr(&hdmi->core, CEC_PHYS_ADDR_INVALID);
+		hdmi4_cec_phys_addr_invalidate(&hdmi->core);
 		hdmi_runtime_put(hdmi);
 	}
 }
@@ -487,12 +487,11 @@ static const struct drm_edid *hdmi4_bridge_edid_read(struct drm_bridge *bridge,
 		unsigned int len = (edid->extensions + 1) * EDID_LENGTH;
 
 		cec_addr = cec_get_edid_phys_addr((u8 *)edid, len, NULL);
+		hdmi4_cec_set_phys_addr(&hdmi->core, cec_addr);
 	} else {
-		cec_addr = CEC_PHYS_ADDR_INVALID;
+		hdmi4_cec_phys_addr_invalidate(&hdmi->core);
 	}
 
-	hdmi4_cec_set_phys_addr(&hdmi->core, cec_addr);
-
 	if (need_enable)
 		hdmi4_core_disable(&hdmi->core);
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c
index 852987e67e40..60d0d85dccad 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.c
@@ -322,6 +322,11 @@ void hdmi4_cec_set_phys_addr(struct hdmi_core_data *core, u16 pa)
 	cec_s_phys_addr(core->adap, pa, false);
 }
 
+void hdmi4_cec_phys_addr_invalidate(struct hdmi_core_data *core)
+{
+	cec_phys_addr_invalidate(core->adap);
+}
+
 int hdmi4_cec_init(struct platform_device *pdev, struct hdmi_core_data *core,
 		  struct hdmi_wp_data *wp)
 {
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.h b/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.h
index 1ca5b5ca8a99..234690dd3a1e 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.h
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_cec.h
@@ -15,6 +15,7 @@ struct platform_device;
 /* HDMI CEC funcs */
 #ifdef CONFIG_OMAP4_DSS_HDMI_CEC
 void hdmi4_cec_set_phys_addr(struct hdmi_core_data *core, u16 pa);
+void hdmi4_cec_phys_addr_invalidate(struct hdmi_core_data *core);
 void hdmi4_cec_irq(struct hdmi_core_data *core);
 int hdmi4_cec_init(struct platform_device *pdev, struct hdmi_core_data *core,
 		  struct hdmi_wp_data *wp);
@@ -24,6 +25,10 @@ static inline void hdmi4_cec_set_phys_addr(struct hdmi_core_data *core, u16 pa)
 {
 }
 
+static inline void hdmi4_cec_phys_addr_invalidate(struct hdmi_core_data *core)
+{
+}
+
 static inline void hdmi4_cec_irq(struct hdmi_core_data *core)
 {
 }
-- 
2.53.0

