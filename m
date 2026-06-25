Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48748CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E6310F47F;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=jasonxiang.net header.i=@jasonxiang.net header.b="MZMp/0Sa";
	dkim-atps=neutral
X-Greylist: delayed 1200 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jun 2026 14:06:37 UTC
Received: from outbound.st.icloud.com
 (p-east2-cluster2-host8-snip4-5.eps.apple.com [57.103.78.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBB410F2CC
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:06:37 +0000 (UTC)
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-1 (Postfix) with ESMTPS id
 B27591800368; Thu, 25 Jun 2026 13:30:58 +0000 (UTC)
X-ICL-RepId: 019efefa-0503-76d6-9dfa-749527867608
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQtJC0MFXgJeC0sEQwVZAFBcHA4HTytYEUoXXRVeClwXFxZWGRcNVk1TGUACWRNbEVcfHQNSHxICWkUCXRcDVxxWRVwYQwldBVccHR5DRVsTVRdGCRkIXR0ZCEcfCjADQg5WA0MHRQAtGRxXUF0KQR9XAFoMWQwcHlwMEwBeDw9MC0gBWwddAEUISwFZBFMcQQBJAVQHRgNdUwBzB1YYXR5BEVIDUEVcFU1GExlOG1dNWg1AGVgGbRRWFVIEWQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jasonxiang.net; s=sig1;
 t=1782394260; x=1784986260; bh=8gzP47/zMqNUOp3tsfzngD7CU94ViX4vNvN0q/Lo+ik=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MZMp/0SasVVMsN5wHpoKjMFgMpl2EBi8Ja2z/HTwteAP0W2truRFNu7on136PDsdc4Q7Ro3uzsJtrKedH1LCNS0csVwzVOZHFauf7OMIML0UDu3+SVhbypkg2JPgpG7nqYO92RbKvOOmNVZD9bdi2AwdkoN4oj/l1MgTYyR7GcX5DtpJeDe7tyssRci5iTibFEEWy3h4xp8s+qZRyvbVzZmAq9PhIMUbch9svBz8uFsoRI2MQywXEXT21E6NdAQqFvfsica7WDsnIYv26phfGanEKMP1/w6Bc735qiJQAjgK8gihnXXJOM+oTKx+fMbnSHUo35Dz+BpnQqkumObHZQ==
mail-alias-created-date: 1782291625467
Received: from JasonPC.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-1 (Postfix) with ESMTPSA id
 CF2821800AB4; Thu, 25 Jun 2026 13:30:55 +0000 (UTC)
From: Jason Xiang <jx@jasonxiang.net>
To: Paul Kocialkowski <paulk@sys-base.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jason Xiang <jx@jasonxiang.net>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/logicvc: Fix port node reference leak in
 logicvc_crtc_init()
Date: Thu, 25 Jun 2026 21:24:37 +0800
Message-ID: <20260625132438.191290-1-jx@jasonxiang.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExNiBTYWx0ZWRfX4bLP1CwFcp5r
 EgoJq5/5P2qU5xyzVk+gm/GoP1yTWPpULSPAbLr9177/ZfOR2saQYN34Vj6sO9sMohRnnwJnJm4
 59xtPpR1Aa9fMRUhaPIF+s02SH82Ax4SCDKdcn4BZO6d8aQgiGBb4ZuENW2DyirK0fDqZHZQhw8
 OMhH1ukfS05w+tnjLTqWCwBoSnmbaT/P3fGskgMxQNag1ONEtoNSd4opwvW+1xRkkBU7qvgzedD
 6L3cNAAtBwPk+FxWtCRZomG63qOpvKccIR3TXdr5K+uFQzRAkpdYfc9aFbspI5Bt2P8DrHDY7kl
 Iqu9tSXhO6zKsC7+IVw
X-Proofpoint-ORIG-GUID: QLiWq3RgxSC_OEwWGEEJe2qtt1gji6wq
X-Proofpoint-GUID: QLiWq3RgxSC_OEwWGEEJe2qtt1gji6wq
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

of_graph_get_port_by_id() returns the port node with its reference
count incremented; the caller has to drop that reference with
of_node_put() when done. logicvc_crtc_init() stores the node in
crtc->port but never releases it. The core CRTC cleanup
(drm_crtc_cleanup()) does not put crtc->port either, so the reference
is leaked on unbind, and also on any probe error after this point.

Drop the reference with a device-managed action, as done in other
DRM drivers (e.g. arm/malidp, arm/hdlcd). The leak has been present
since the driver was introduced.

Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
Signed-off-by: Jason Xiang <jx@jasonxiang.net>
---
 drivers/gpu/drm/logicvc/logicvc_crtc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/logicvc/logicvc_crtc.c
index 81e5b80736fa..4de48822ca21 100644
--- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
+++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
@@ -243,6 +243,11 @@ void logicvc_crtc_vblank_handler(struct logicvc_drm *logicvc)
 	}
 }
 
+static void logicvc_crtc_of_node_put(void *data)
+{
+	of_node_put(data);
+}
+
 int logicvc_crtc_init(struct logicvc_drm *logicvc)
 {
 	struct drm_device *drm_dev = &logicvc->drm_dev;
@@ -274,6 +279,10 @@ int logicvc_crtc_init(struct logicvc_drm *logicvc)
 
 	crtc->drm_crtc.port = of_graph_get_port_by_id(of_node, 1);
 
+	ret = devm_add_action_or_reset(dev, logicvc_crtc_of_node_put, crtc->drm_crtc.port);
+	if (ret)
+		return ret;
+
 	logicvc->crtc = crtc;
 
 	return 0;

base-commit: f0e6f20cb52b14c2c441f04e21cef0c95d498cac
-- 
2.53.0

