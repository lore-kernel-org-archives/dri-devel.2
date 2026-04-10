Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AAAE99048
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AFA410E89C;
	Fri, 10 Apr 2026 07:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="br1rhlge";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCAD10E897
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 06:15:56 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488a8f97f6bso2913845e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775801755; x=1776406555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjo43meNd5ZF9rDDbLS97J26FxqDt/TB0OImD2ifO6U=;
 b=br1rhlgeETPSImEbYo9W3k6yfrvsztmf1TRMiQaaH6wIZ8KHHZ7+/uiK1tfkiOskBK
 PFG73VadmXtS1nXSagXBM8/a1pqTsJ4TkA/XnqA+0kSoWt+41MJXuVVc2JhMzx5uCiKx
 KtyL6OheQPEvb7igMWjW5mREKisJHK19T+tE6tEYssSQyPGB3JU4iNAGiyON01Roj6qC
 aKAgKAiBKO0S4qduRv4Kkg2omCm5+l3hnwi2kWrcDmwJpOcGk1gCkJ7V0aSMO0whi0rG
 m0V63AmvJzsCb5hSScjDL+CRZiuP1Uw+h/bqF8bo0u4Qz2wVJQDCA4xzKPByBVqW1uq4
 Blkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775801755; x=1776406555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cjo43meNd5ZF9rDDbLS97J26FxqDt/TB0OImD2ifO6U=;
 b=Svvic8OEcWK5VJT1LKiYRqPBu8g2dERnjbA8Mu6PnQ+eY5GG4O7gUZICmT2ovn+pIU
 FTG9udBtab5KsJs6mQKRT8Q7F7LG+PBXd3nzQ7Two5xXarfr8WwNA2JfJfHFUWyAeFOM
 qX2OY8tyHhRx74Fgn6DtEn9L+qg90zDM3D3+y2IJgZiv92kt+nYL2+Pm9LueOEF6F8j4
 buaCtyVQZfhDy1+Kkd0I+5WygtAaEAyZvho4ei06aO2io2ajoBmgrUgHT52+KykAVHqa
 4VS7CiaTmO1QNkJpYOgn3ngvYDBroJ7UjfutrF5opgfnLcsHiW1tdYWpq3eQk/v3iyi8
 RVbQ==
X-Gm-Message-State: AOJu0Yw9Ke8uiGSK57BefJytfrPQlou1dNLgXuA6pEOgiZG8bA3w7CMX
 RVy5dGZh59wruSb3X2Tgvt5qWwbhddI3WaBBW1o6M4OeysgbwVsIcJY0
X-Gm-Gg: AeBDieuhcfdBzH10xYWzZeyTgTp4zX+pqjXgTqPdssXeTTor1q4K/GjM0loq4HBqB1U
 MqmFTEptKQjuV1phu4aQKFmMiZO/iltLSEKAAtfOWxm4PaPwuLOXGyqG7FapVinQk2FhS/YoNlS
 jyITkh6YnzyGY8Wu0QxzRAJ8463g+GWe/zx5I+8+4kqvqtKVIQUhn7XwQH5ITjGL6bHAcXgtvV1
 +Y3f1OZ44zyeD7tKGWj9jM96WLqk/kCx2olj7PBNpqDC4focQUHotu6oWwbmN6+DJErb2RPLc+7
 e+WO4KJ5YHpPyk3Tv3/lTwvFOceamKBEaKESc32oTG1pJhhAKJZa+FRwQgkl/K6jGRDLDJHfjWP
 9AQamjvSHpPaHVHFq17K9M0UA5vmNUVdEBTSrskp/1EhmyVBP0SaLkjUNk41aKOJpu1tQ6D109R
 7132J25VAPv8kCZWeprWZLLYV3ZwIqVUywqsEiwVPEtDBvwUsN4pdSzBEb7KaETy90imeFbTBYC
 2qwwMLz182PZTGzpXBEe8PI
X-Received: by 2002:a05:600c:c4a2:b0:485:3bc7:a224 with SMTP id
 5b1f17b1804b1-488d68609e0mr11649685e9.6.1775801755183; 
 Thu, 09 Apr 2026 23:15:55 -0700 (PDT)
Received: from localhost.localdomain
 (ip-078-043-200-145.um18.pools.vodafone-ip.de. [78.43.200.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888c12sm55473955e9.3.2026.04.09.23.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 23:15:54 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 2/3] drm/nouveau/kms: add NULL check for CRTC in
 nv50_sor_atomic_disable
Date: Fri, 10 Apr 2026 08:15:51 +0200
Message-ID: <20260410061552.19056-2-marek@czernohous.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410061552.19056-1-marek@czernohous.de>
References: <20260410061552.19056-1-marek@czernohous.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:48 +0000
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

nv50_sor_atomic_disable() calls nv50_head(nv_encoder->crtc) without
checking whether nv_encoder->crtc is NULL. Under Wayland compositors
that use atomic modesetting, a race condition can occur between
atomic_check and atomic_commit: the encoder's CRTC reference may
become NULL after validation but before the disable callback runs.

When this happens, nv50_head() receives a NULL drm_crtc pointer,
and container_of() produces a garbage pointer, leading to a kernel
crash (NULL pointer dereference or page fault).

Add an explicit NULL check for nv_encoder->crtc before dereferencing.
If the CRTC is already gone, release the output resource and return
early — there is nothing left to disable.

Note: checking nv50_head()'s return value would not work here because
container_of(NULL, ...) never returns NULL; the bogus pointer must be
prevented at the source.

Tested on NVAC (MCP79) with Weston --backend=drm. Without this patch,
switching VTs or closing a Wayland session triggers a kernel oops.
With this patch, Wayland session teardown and DPMS cycles are stable.

Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 6c3a8712d..42080874a 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1565,7 +1565,13 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nv50_head *head = nv50_head(nv_encoder->crtc);
+	struct nv50_head *head;
+
+	if (!nv_encoder->crtc) {
+		nvif_outp_release(&nv_encoder->outp);
+		return;
+	}
+	head = nv50_head(nv_encoder->crtc);
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
-- 
2.52.0

