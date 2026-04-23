Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B21F99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53B010F078;
	Thu, 23 Apr 2026 10:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cuMMuBpH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE8B310F074
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:19:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 52B186001A;
 Thu, 23 Apr 2026 10:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CC3C2BCB2;
 Thu, 23 Apr 2026 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939557;
 bh=eyprmpsHhE9zP3aK4nK5cetaF6TLpXxxpAK4fXRj9zo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=cuMMuBpHeyO11QAgRQLIrkf5++AugEk68m8XGA2GZsjGns/dKEgXENnEtj2LUYu5R
 e0gZRyUz+XaSdcEGVrl+Bur7rUaI1olbvcO+4CbO0UCer6ayaxcvaoVI4l+zaAZVCW
 1snrALsT2Z/V0Tgvp0WeAFfNGUoq1iE7A2gzSr9aJ2gYYEz3Ny32fS94NPWYc5gzbm
 D9FmX+1Mr72lTN3Mkg9LZMNcufU0SFJ/TwiG15UtW+Cg/WmqWL3b1RmsWRicyOAQqT
 J3ZT1rdo0COwDCbwPNZWq4bN1qTsTNelf0qWB4aLq3T6NuKo3VGo5uJ+Ng52fhpzV1
 DNnfI5wecLiLw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:29 +0200
Subject: [PATCH v2 16/28] drm/mode_config: Read out hardware state in
 drm_mode_config_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-16-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=mripard@kernel.org;
 h=from:subject:message-id; bh=eyprmpsHhE9zP3aK4nK5cetaF6TLpXxxpAK4fXRj9zo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP76TurT3ksGqX3of7f1MBf3+y98/1Vv/0MLintmM8
 M8nP6y50DGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmUricsU4z89iBI4FWISkS
 offX2er+ss14opVZt27Gvjd/D3lX85WurpzbF3/N+LZSeUidqI78McaGT2zNzscaz0Sden/v+e7
 P8vF5CeKH1E69uTXzXMLH6Z279ny2PsXd7b619O4b401BGSnOAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

drm_mode_config_create_state() creates the initial state for all
KMS objects at driver registration time.

Call the drm_mode_config_funcs.atomic_sro_readout_state hook from it
so that the initial state is populated from the hardware rather than
being left as a pristine default.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 61c3ba5d3901..6bae788c30cc 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -22,10 +22,11 @@
 
 #include <linux/export.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_sro.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_managed.h>
@@ -364,10 +365,14 @@ int drm_mode_config_create_state(struct drm_device *dev)
 		if (ret)
 			return ret;
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
+	ret = dev->mode_config.funcs->atomic_sro_readout_state(dev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_mode_config_create_state);
 
 /*

-- 
2.53.0

