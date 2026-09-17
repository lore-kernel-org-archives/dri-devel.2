Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52D0C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938F010F20B;
	Fri, 18 Sep 2026 07:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f/AsL3rs";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6ED10E731
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:51:16 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495437bb891so5787825e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 06:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789653075; x=1790257875; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZqUTUUtcpH+QYrYSYHDv9OjVF9PUa57N/cCdTlthFwY=;
 b=f/AsL3rsVEJ+EHSADL1WDwWFvY06+C8p+533hbgOlfmpZOiL6iXXDsFe0btJDLHWKa
 c/NPKJOKYFnATqM+IIlEa45VymUuDSV4bmK6zhPs9MfrDfFxY/Eenibebe4ZEzAScnw5
 tuVX3MzLtAxkoatmP+tQUsg+oCLlCqAOHLxPj6AgTwu9xhn2Z4733DjIPkmDpegd8J7I
 NREnDVVMisgrWOt3rol6c+pfZaEVKoZqkbnHnlS9JujAF9VVZAKYSEjWMiXJLAuZ7BHp
 A8F3xnb6FWYeSNnlVnosxSZHYurYDk67P74VjIQCsYbJKzpmL5jZefnxKN46x++B4Ub3
 V6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653075; x=1790257875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZqUTUUtcpH+QYrYSYHDv9OjVF9PUa57N/cCdTlthFwY=;
 b=xeGfHaFo64YHThdNybfwA+uEb2qhau8NcHnp7oUiwieEvMEAYAIejr9bpf91Y7aD9z
 D3lvhaFHCNQeRtm25bXreEPMcf+MeIHEA7amnefMEuEhZUgUom4HlHHP5N2h2Vc9TbAU
 WE55xO69KY9wlTdHwKyuD0qhscfVJDiO8S/s99ZAEcaZHYUgmYI0ETyDX17LJ9inkSjx
 5gSaP4HaKzeY7NY2UrRgSNsGaTGvLuwjQzOZTuhBGTkLJ7bZ+6WsxSQVB3vcL5mK9FW1
 4GqWUDprzNN0aTlgeyHNiEOwD9NSXgnNPdA0czbhv/eFJVjmQ/j5A8KUIf8Y4AffwSea
 kxsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbUXObfiCyaBL8cKgbkmrG6RLjNIOsx8/JkDAvIUoRoeNY+G5h1bJnWhGZPmQhOW2pH3ugCiyNCyM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkHqZ1aJv5bhfq2fdS28R4NwDXKx41e3IGGZQuNaVcSepMyADB
 cCIF8fC2GiQS9oPLcG6MB3pqvAy3tysm6zW3z1O1ZMgrY18A16DiB5Kl
X-Gm-Gg: AYBFou3SG5TIzUcAqJc+zP9M3m3eSnr2c6NfRWWSflTFApRT+u3F0QSHRK8YG2DKssM
 ajSatN73LBVxXyjzG2hIzNMNIePPSu7VhyKz3qsCVR50GHUdGznOOEwzGeHWADI0zDwu7MgURP1
 Uh4v+3EjYsrNiQsOSKX6E1YyJZvkooMLsvraKL7nQHVY5pCZdgIiG2ii650Q5wgK1/1mvKUlt6I
 3BbVYeUsGxK9G25kSEZw/k6+LyUXkrvgm4s1InhSdbYYV/cacb/+D+Fs0htu66xK0yfmHlOQWxM
 y4B7nk451rKJMYcaRySC2fyyeedn0fA4jwmcsJrPdp0ILa7Bqgf/obo9gcrF5tfKGSMH5iR9N0V
 f6GMe38XVsc7XXPE0e+k+RYxzErvonRgVdY9uY3geJ3rZPr17vjAuE2i0iaChZ9OQ+rizWr58lf
 +1q2ViEtGyWACVjTMlTMmvjGi5MEwj1irpBYPF3zSaHUzTbQjGHMH0fv8QDTOFV7o1zcYETwLpM
 14H/DB8xKyP5rzrWGAkAVRJW+nop1qR7UAXyg4e7cjaObfc3GT7Et32ei/pIQ==
X-Received: by 2002:a05:600c:a59c:b0:49d:2589:d8e9 with SMTP id
 5b1f17b1804b1-49fbd1e58a6mr31063615e9.11.1789653074785; 
 Thu, 17 Sep 2026 06:51:14 -0700 (PDT)
Received: from kbuild.local ([46.10.181.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bcc7d1esm15669993f8f.0.2026.09.17.06.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:51:13 -0700 (PDT)
From: Tano Dzhinski <tano.dzhinski@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tano Dzhinski <tano.dzhinski@gmail.com>
Subject: [PATCH] drm/nouveau/disp: don't reject HDMI config on cards without
 SCDC
Date: Thu, 17 Sep 2026 13:50:51 +0000
Message-ID: <20260917135051.47683-1-tano.dzhinski@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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

nv50_hdmi_enable() passes the sink's SCDC capability from its EDID
straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards there is no
hdmi->scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole
configuration with -EINVAL, and nv50_hdmi_enable() returns before
hdmi->ctrl() runs and before the AVI and VSI infoframes are sent.

The result on such a card driving an SCDC-capable HDMI 2.0 sink is that
HDMI audio silently stops working. Video is unaffected, and nothing is
logged, which makes the failure hard to attribute.

SCDC is optional, and the hdmi->scdc() call further down is already
guarded against a missing callback. Requesting it on a card that cannot
do it need not invalidate the rest of the HDMI configuration, so drop
that term from the condition and let the existing guard skip SCDC alone.

Giuseppe Ranieri posted a fix for this to the nouveau list on
2026-01-17, which received no review:
https://ratatoskr.run/nouveau/2026/01/16963412

Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config method")
Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
index 377d0e0cef84..9887b3898505 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *argv, u32 argc)
 
 	if (!ior->func->hdmi ||
 	    args->v0.max_ac_packet > 0x1f ||
-	    args->v0.rekey > 0x7f ||
-	    (args->v0.scdc && !ior->func->hdmi->scdc))
+	    args->v0.rekey > 0x7f)
 		return -EINVAL;
 
 	if (!args->v0.enable) {
-- 
2.43.0

