Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71418C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3652B10F431;
	Thu,  9 Jul 2026 07:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ebx6/rki";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A04589854
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:05:36 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cca24023edso31823275ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783436736; x=1784041536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7SSWQg6HrEbpp/1xgGT38ar/90z2MxrGW6oImpnAmb0=;
 b=Ebx6/rkiBuUQSWqDUi90wst3E2BP5XWWEH9JePBd9yMN0zrCxjw9UbeBfnQVf0TLM3
 740HreUGHq2DWENjYDwoiVw4p+KKHsF0LUoK/ChvODUVbloU4b54olc9YhmCDOjftqfB
 EGsJ56CQTlX/zaQ1w/PvIp0XJ/Y7vUr2801tmGKeYnHXgScXB7eC1j5UNR9aiHhTL5a9
 ap4+01sEn9ZwRrukSXaWw9ARluYh6nSw1UbOb9RmCxclJAgkzOSiYo/HmjYJFxqucHHf
 PmA8TP3JWdBhuGmzwgftJQnvqvcr2nRyBiWbbVN0Fz+VeJnjCISdPp0aq0XLUohTViwo
 QLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436736; x=1784041536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SSWQg6HrEbpp/1xgGT38ar/90z2MxrGW6oImpnAmb0=;
 b=I4LGoy+B2HRifBHiXR5BVlfIVnCnYX9tYfQTiJumb+HJyn+BrUkUYmmQP7BmQLX11y
 i7QFPsgEU9yNBWjBeeOk3u9ddnAdZZU5HXCPnvWmAF6EOctaRJ/MXVJRHVNVullJg4Fw
 9beA675O0aipcDpx/LAtej00NNTT6pM9j5x18wOdUaBVVEpZbY7NamkucrTo7rqgB3gU
 QxQGvliHn5tamWks3H9mUIPlH7zUE4eaoAcG4sqx9ttp14PewNNkwtR6W7gVlmALUCRN
 OcJNrSIz9GQmgABaPBNITB2VZfN9ocSJKNeMOVvdCy4GcYSmjQdSWPF+sMAoQ/pRFaFm
 Tm4g==
X-Gm-Message-State: AOJu0Yw8ZOBWulV0otClkTwfa0MwXZjp50Nb5KBMrMlHpZiD5hjq2Xyx
 BkQCp/dfFyN298QuPHHvxWkh4AOnWKhsSHK8pTQHT6sw1HEWCKQ+qfMI
X-Gm-Gg: AfdE7ckggRKN43Tp3j6uhD4mKSCBIadSibw1Hzf6gSOrVdiE92zzDFMPzsQh7Fm+2zh
 IBj+ERuCUG2S34mHgqXZI7YmUbT/lxlDR/GxTXaP3kwuVtHclzCYBtb7IIjRu4hqkARDQ2qQbPN
 uau3hJwQeIGGBLRdhXnVszviiOWsTzyrLOdRCN2B0NNB0eo333dvAbV6dsz2OJyiwfnldluMrmh
 5pzeJyxrTeHVp8IV7nl8y3tWkRKoB9r6atpRw5I+KZrhqThRMEP6NrqajXpitq+qS4pzvveEPPD
 GBat+pNlJTdk6P0E+sGWidYTsMpMn97iqhC6t/76zSuDfDKQHnCND8r7xm82Zx7BRJpa3ZTgkmK
 LZNFYzfPPaVuqgxfyp+7GaxGASBs3OFVxzabaIThFsC8KT8oA1HhFHbIF88xQwqDBi/ZM0Qy7r0
 xd+/cUUT1wwoVVGLCwab7Xqt0bbYkfeE6J
X-Received: by 2002:a17:90b:4f48:b0:387:e0bb:57f6 with SMTP id
 98e67ed59e1d1-387e0bb5c07mr2778290a91.39.1783436735574; 
 Tue, 07 Jul 2026 08:05:35 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:239e:a31b:1d0d:374f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d229a20csm1284197a91.16.2026.07.07.08.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:05:34 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] drm/mediatek: Check CRTC state before freeing
Date: Tue,  7 Jul 2026 23:05:28 +0800
Message-ID: <20260707150528.2270739-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

mtk_crtc_reset() destroys the current CRTC state only when crtc->state
is non-NULL, but it always converts crtc->state to struct mtk_crtc_state
and passes the result to kfree().

When reset is called without an existing state, container_of(NULL, ...)
does not produce NULL. Keep the mtk state free in the same crtc->state
guard as the helper state destruction.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 2d267b81898e ("drm/mtk: Use __drm_atomic_helper_crtc_reset")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 8e552cdc3b53b..97e3ff412e6ee 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -154,10 +154,10 @@ static void mtk_crtc_reset(struct drm_crtc *crtc)
 {
 	struct mtk_crtc_state *state;
 
-	if (crtc->state)
+	if (crtc->state) {
 		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-
-	kfree(to_mtk_crtc_state(crtc->state));
+		kfree(to_mtk_crtc_state(crtc->state));
+	}
 	crtc->state = NULL;
 
 	state = kzalloc_obj(*state);
-- 
2.51.0

