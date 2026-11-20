Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392EA60A2603
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDO3ZqZA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BBF9112A0D;
	Fri, 20 Nov 2026 12:59:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E71D1129FF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:57:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A45560E12;
 Fri, 20 Nov 2026 12:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F241F000D0;
 Fri, 20 Nov 2026 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179459;
 bh=MP13i1259C1Nj/NR0wxLD+EVYMinN/qr/p+nJOPudYA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DDO3ZqZAO+yyQ4Y0K+VVFoFE2fQ85Xq3rqJNpF/nlXibt5h+Jycr3cKa1a443lKmx
 XfFt83P2sE1+pSrWdzSuaUep1+QGofaOuM0Ds+9hmSza9+f8vPp0HcsvXVFph2n9wR
 pjLZ4eC7zFglBET8GViXYXEKm1m5hyztJraAl/HGnaFpa4dvQvDUotUgdvja71aGvS
 4at02yoxFY1drPix+zIhyaZQjYgtVkmg5ou6eOYe+xMjc+xGutApn2WLT2zliGE8rp
 kR8BPHTFqKMIWTikBc11Q+HQXy6a23o/yE2n2cuxpbu/aQe4tRlXNaTBN7GXaAjNoT
 28ufRJwiNZ9aQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 13:55:32 +0100
Subject: [PATCH DO NOT MERGE v9 40/42] fixup! drm/tidss: dispc: Add
 hardware state readout helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-state-readout-v9-40-a67c2b45b8ec@kernel.org>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
In-Reply-To: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
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
 h=from:subject:message-id; bh=73QxT3UG5fOdNClpUgLtVR43553Ur0kiU1WeGvhVST8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMzibuwn817p4IEJFoCjwvElY6Vem8eW5B2wv9R+JHt
 s4Ma4jtmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOJX8JY79kgzHpt3uzNAlM3
 ehbw5WjlWG9++bV7clqxRs1dXdbGxE9M5+s2Vezyc3R7dHLxstjHjPWutqu61ITk7yw9dySjMXS
 CrqaOjyzbIbUSHfd9ipv/GFesjitImr6XeWvgH3bNvhUxKwA=
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
index 8e61216d4532..f7309daec908 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -495,10 +495,15 @@ int tidss_configure_oldi(struct tidss_device *tidss, u32 hw_videoport,
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
index 4abcb9e679ac..c54ab9a92894 100644
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

