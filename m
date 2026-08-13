Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B361FC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E0010F30F;
	Fri, 14 Aug 2026 07:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="soudcaCH";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEFDE10E4C6
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:10:54 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1804905a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786619454; x=1787224254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SrNuYfPLf9ZRG3VPVcc9OXZy7f7BhYSur9DBwfRDvzQ=;
 b=soudcaCHKXlsRceNunxc7B0mfHQeIEKRBayRQhEfyeWfOdzUU1K2yiTTRDNiew/zAw
 XSUcY/gfOcRSLBDlc7kGgqd5XRBfOy5vaK1aKnfbLkRzDkIhvUJI+rR8jQaoyEOrrKh6
 c4TzPOtTIRuZpGIf3mEe1wkSR1dOGuHHStMDe3MbM1rcQ3fEOgq/6KWaeUKcmxD6ktTm
 gT2iy29pPTXKfGigeWXYnxsR0MrCqbL8oOPQ6MAcrj8fTd8RsRHzQfRPPY/gE9CvMtRl
 2qbL01TNrOnWj0xDmMe7fxEtvfbfhJCFRStL7fePYLyG9UGj29KukQNzz6Io2s0/0PDE
 053Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786619454; x=1787224254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SrNuYfPLf9ZRG3VPVcc9OXZy7f7BhYSur9DBwfRDvzQ=;
 b=UalXwDP4+zPE2/kxRVzn497BIRIef1mDQoGGNrSIl1Czb4q7+g4AD1fTWCAk+j6/i6
 Lpu7+wcssqj62eDHrH59MP65KiAA80eVo/4wwxRznJp7mF4EGWxW7jE2dzbjGD/MMJDO
 hin5oUbJoXUJCsCfWf2dujXk96E8SFl+/GkT7d2oXDYmLOdKLXGSy5l89ch+MZQn6Kug
 Ij+o+hkuAR2p2gbzGm65x+mqSeFaIo8ZfzOw6S2MK5SoGvVdpSay7qpT1j/ADMcoLIqm
 msiPgPlsL9SXSMuAOfgp0IajX8xB5HX3vjkcfcoKefjk/GheCqlute3w/qJBhxoMWO1y
 g0CQ==
X-Gm-Message-State: AOJu0YzJMF6Rx7SOb+5xtVQe9EO1UCCeq+62ZMQxjMEOtgvPVTr20W+U
 Esdh9HHCIsA9fwg9rFqGvvKMtbC97BYOVkqGDK/naaVF8XueGhnDJL8akW/7Fa6PBJs=
X-Gm-Gg: AR+sD11fVQTlpk4UPbBg96R8SgtSTsRDtwNKOTVUGJFUzN2OGe8jFk4uR1l1CJkdulr
 fMRnPtbWV8XY/El6y0yBeHrCpSK7WQdNkoVPRAbjPlYgfAI88FFAtMlVljD/flPoPppVdRwUx/x
 zajlZMHIGV9KHayR0yKNQ8FgOBlDoUXlWCxNZTt97pvCtpmBmVaBG2TgWfWPejB1MA0otyLimnh
 XnIRkCQKllb8wUkaonPUP4cUMCblDaY8Wbw3+iUctiOCiWSjwyzvCcIyl1pCIBRnIbrUFHn7a6j
 uNprRh8AaJxjRzhTaZ24Gs6OZbdQgw3MPJAzDdTbofhUdj86QqAZUyN1717eo9bQJ6MoC5nG9X4
 AoLNPkQrpbxJKqbO+GGDi/RfNeHS+ZW464nOPAoL1HsQy6PrAfshkptOrnenYvW/xdfGJ1Cpht6
 1S4AZumjknXEdKMsTAWVfOhJi6Nqz7Nylt+419ek3HSijA/R2qXI/M/DXaf9Q7LytSfle/0lsFh
 6CX5+NKC+O+tEyeMhCldMQ+xlO3gWX5HtU7mFGl5tifIKrOsgpBeKslxuN12Fw4x25vjrfAIL35
 SA==
X-Received: by 2002:a05:6a21:1343:b0:3bf:b9de:8570 with SMTP id
 adf61e73a8af0-3cc5527de6cmr6884387637.19.1786619454076; 
 Thu, 13 Aug 2026 04:10:54 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec0228793sm7610406eec.26.2026.08.13.04.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:10:53 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] drm: logicvc: fix device_node refcount leak in
 logicvc_layers_init()
Date: Thu, 13 Aug 2026 16:40:36 +0530
Message-ID: <20260813111037.724-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

On logicvc_layer_init() failure, logicvc_layers_init() releases the
parent layers_node reference before jumping to the error path, but
never releases layer_node, the child node held by the current
for_each_child_of_node() iteration. Add the missing of_node_put()
for layer_node alongside the existing one for layers_node.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 drivers/gpu/drm/logicvc/logicvc_layer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index 7f5ba00018..e83a2aafed 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -613,6 +613,7 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 
 		ret = logicvc_layer_init(logicvc, layer_node, index);
 		if (ret) {
+			of_node_put(layer_node);
 			of_node_put(layers_node);
 			goto error;
 		}
-- 
2.46.2.windows.1

