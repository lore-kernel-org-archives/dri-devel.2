Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15839606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHBD0nqt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0399911294C;
	Fri, 27 Nov 2026 09:56:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EBBF112926
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D75EC6256D;
 Fri, 27 Nov 2026 09:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975B31F00897;
 Fri, 27 Nov 2026 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773316;
 bh=Cf5zlw1l9n6HfDH4uFzF7HFBp2lDbS35SdnNx3cueGA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gHBD0nqtLwWo42R6g3cfaYer8BzaqYdv2hX5T6jm+hqPNqjOQibiEepRV7+IRPFhC
 gn/yTHtwbZRQFnO1NpB1sMHwxpJDUzF+/t6ny3YKXzHuiIHgkwYRd5kv4ETPsRVKD2
 cHatBgy3yfgqNZ7nm3fLaY9cntjXklKosYCl1VpGUojd1tWQUy0Qt4keS4AY3B4ezf
 yV5qfGDhvuwdlxHYXSu7P2qi7/sStJwaIN8UibKgf1iZC7ZYwgNT0gokaksjZdaW2g
 4lRDuKKGpxh6It5f6/BL9D18O8s0lTb8rikCH/jREuVDLwfiGBENWR5XwWNd1LUnwF
 ozF/cuLDVIA2A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:16 +0100
Subject: [PATCH DO NOT MERGE v10 34/36] fixup! drm/tidss: dispc: Add
 hardware state readout helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-34-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2240; i=mripard@kernel.org;
 h=from:subject:message-id; bh=oNX9pAcT4865cGeGahJBGvGQIvhOnpZxzEJnEv60btw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwdy37L9NDpXZ9XQ6708BzWn/GfMvxnXkGWeWTGMNm
 nXk1Jd1HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAidRWM9f7dteEss3j6+Wcv
 Kf5Tt+LcQ1P2loOKaS/qe7UeZ+8wP8Wwfodj58YKywjDFAl31pyPjA3zrsS90TRMsrI2XnMyUPh
 mgQzDuTnXP/++f2S38YNPn3nP3vaS67XjfpKrnx3+iC8tdDoA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The state readout of the OLDI transmitters needs to know how the
firmware configured them, but the dispc helpers only allow to program
the OLDI configuration register of a video port with
tidss_configure_oldi() and to clear it with tidss_disable_oldi().

Add tidss_get_oldi_config() to read that register back.

This is only needed by the OLDI state readout, which hasn't been tested
yet, and should be folded into the dispc readout helpers if that one
gets merged.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 5 +++++
 drivers/gpu/drm/tidss/tidss_dispc.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 15395e06f3f8..335eea08d70c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -496,10 +496,15 @@ int tidss_configure_oldi(struct tidss_device *tidss, u32 hw_videoport,
 void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 {
 	dispc_vp_write(tidss->dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 0);
 }
 
+u32 tidss_get_oldi_config(struct tidss_device *tidss, u32 hw_videoport)
+{
+	return dispc_vp_read(tidss->dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG);
+}
+
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index ce48c75b19ad..806e0cf749bd 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -100,10 +100,11 @@ extern const struct dispc_features dispc_am65x_feats;
 extern const struct dispc_features dispc_j721e_feats;
 
 int tidss_configure_oldi(struct tidss_device *tidss, u32 hw_videoport,
 			 u32 oldi_cfg);
 void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport);
+u32 tidss_get_oldi_config(struct tidss_device *tidss, u32 hw_videoport);
 unsigned int dispc_pclk_diff(unsigned long rate, unsigned long real_rate);
 
 void dispc_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask);
 dispc_irq_t dispc_read_and_clear_irqstatus(struct dispc_device *dispc);
 

-- 
2.56.1

