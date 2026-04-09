Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974F1E99046
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1116810E89A;
	Fri, 10 Apr 2026 07:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="edUXeH3m";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C167810E849
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 17:21:32 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4830b67aa6bso1429225e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775755291; x=1776360091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjo43meNd5ZF9rDDbLS97J26FxqDt/TB0OImD2ifO6U=;
 b=edUXeH3mJHDhODJlyhizJQFqfDGvsp/igUwBBSlRvMlaCJu0Zct89UGQrxNggF/Te9
 Vy6X4HelR8wAlFiyB33WWTonG3qDB+LPM6RmQJ6PLs0wx1H4lUmvpV09VsdCpMra5ebR
 KJ0aYe9xypg3ojtjHgCsTmnBVrKkp7JqCkcoD+0kOIW4D+C/Z4ipPH9pwhJidEaGZ/G4
 AsZHZFUDa8Qrc+S8qAlMR3ru3Ac+s3pkd9Z5gXJ4Edhk7uDjXq4HtCNfQ4RJfjJVsjVM
 hydW14HK9+P/TiKMnDg5ljCgPu7N+EhU/kYBrFwxhLtGSKbtG0X6vrLuh+zR93ULFeWC
 DBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775755291; x=1776360091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cjo43meNd5ZF9rDDbLS97J26FxqDt/TB0OImD2ifO6U=;
 b=DOh9hzZhfQKAFmtYWtOR+YA3hDcjALWk0kMhhVad2MJ2T8Dc0m32q7FRQGYfb0tjY6
 7cdO/XXmEbUXOuQegVouwFmv0Rcih8mGuMtfiQsOATaWYPKrNkXS7Xm1JkQmJNzYT8ou
 d6eWKnrDVYrCulq9CJZJ6/EuYXJmz8I2KqUW0HGFyEyIHjiZgkQrqrgLR5XUGkfRCC33
 14gGXPV2WISbg5eVxWFl2rAvYrrGz1roiFncBzY1E1Qd9fNZvYVkT2RY9g9CV9Rkf7+w
 s2QLEDkHR6/7309HeoEFFqAQRUphf3Bg1/htJTCH+4PQeqw0wAw0aj7/rEclY96l9Fdk
 HruA==
X-Gm-Message-State: AOJu0Ywnkt07pDjJRm9bvM21cCYYDmnSq2ulmNlEOixAxAwxql+GwiQQ
 BK0hV/Xdo09S4wIUvAzKf3fKRg8UiNw7ughpBx7qU73RUujcrRJxh7yxzu6lrCmj
X-Gm-Gg: AeBDietWphOx0UqJsZTG2EdgR0wD6vdutppXJ0Q8RiQrZqF+7wNNfUn6UhPmjiEGQzc
 4wPgW+Hgq/JlZakGW47UNsTyO8WdtpEGhnJqB0XUoC4g1RG/WJhuVSYv3LfWXC44VBbrRATpvXG
 yAZJsmb0kSvTQAheXxfAEMFLhFUkBXRqBwpGIDJNkWmlpwWgbeec9MDMwhaFDBbsymsMOwRm5Ik
 q2459VqrY5c5uD9vEnk4CB95u7VRi//FunWtC8Z8glCPJCNikwCfE3rc0qlJ+17lV1CszI2Uapt
 7UtKpUuj3GvJZlN0mBP+EfUz6Am0uf/4ys61MgtUuslLLKwtpp0xbMB+ltYvixL82z3nvOpAe2S
 Vcw1rynx2HdqCwCh90A1yy15BTiX1kZZ1p7KUzKAOIZnJsTSGIIdjCq9q9kP8Ku0cGfF/xh9vwe
 KOXQkQfe+jw0/pLLP7k28Fw1g9lKgymKDTyRJZJKmt0p0a/z1QmnnM5Hu2RF7HFAjNhtwnN8bLS
 3erBJ8oTaaN4w==
X-Received: by 2002:a05:600c:1381:b0:487:1fbb:5a28 with SMTP id
 5b1f17b1804b1-488996b43b5mr206703455e9.1.1775755291168; 
 Thu, 09 Apr 2026 10:21:31 -0700 (PDT)
Received: from localhost.localdomain
 (ip-078-043-200-145.um18.pools.vodafone-ip.de. [78.43.200.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec090sm367345f8f.12.2026.04.09.10.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 10:21:30 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 2/3] drm/nouveau/kms: add NULL check for CRTC in
 nv50_sor_atomic_disable
Date: Thu,  9 Apr 2026 19:21:25 +0200
Message-ID: <20260409172126.115441-3-marek@czernohous.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409172126.115441-1-marek@czernohous.de>
References: <20260409172126.115441-1-marek@czernohous.de>
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

