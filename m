Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B40BCD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C5510EA06;
	Tue, 23 Jun 2026 08:42:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nO/hURDq";
	dkim-atps=neutral
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E38810EA06
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:42:07 +0000 (UTC)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 917EF3F215
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782204125;
 bh=YRUdbfA4V8+mw/54eWhWx7hbp+2WiDaQD/36neeUeQE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nO/hURDqPv0Hw+LeLdwYSAUk9XCKOBR9X3Z/uIukpBB3qVPz3Pw+1ESZJgjGJ14Pj
 nKO4TdZw5pW1QHKNGOc4HnV3dJxVarsK3IxuDleBCezW0zOPqHvE9C/erIscGYpVjy
 bq52dGJcTAj4QzxwpIjl4Rja+SCm01bq716vSYAFXPaAnlJSsuHh/RSXyidt7d3KAq
 tRNokxpmLunnnuk4TKtjmLpt0pUmKPvTOdjm28W79pIWLL+X4I6vG3n73M54UcEx6f
 amxwZsRaXibaFzggaJ4YcHAhUaBnr+TlH10lCJO0QgS5ZlGMARuGNuLo/BzZO59l3Y
 UBCOlIMc0AZpJ4drsYivLxXMABmq+CvzMwppXP0agREcOcThVUc54DwPW10QMvmKQw
 h+K1xspjEjve9A3kpo4snPags7/TC5pjfCn5aeQfe0hYmBLFPgz+Me5up9PvH2uz92
 macX5KHODPLXe6RDwJf2v0l5ghVB2jplbqqAv5IstVl8q7OtdS9M5sMyPAtEQ8Zh2v
 0MLn8M3P+WDNaCvgAr1DlOJhh/OaOC1PUR0aBGpGdXzbon1jNpLYGERow5EtQs/GvK
 lHv2moGgCZ3pz3vNoglD686SDlGC1pd6RUDAcOV2qC7cFHjrhJaBROxO4Fe4623vsa
 Pkr2HLigBqiT+hT4YZb5y6j8=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-845338eb797so740602b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 01:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204124; x=1782808924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRUdbfA4V8+mw/54eWhWx7hbp+2WiDaQD/36neeUeQE=;
 b=ZeJlVpnz7Kz9Mb8nhyVfV/zzBWozsLI61ewt4v4Ddph/hcK1fQdR4ajj31E/5JqCB3
 NbxQQZ55A0X+z40hDg4OMVbq7OrJQqvP/K2PRNwvznYIMnxDqSAv00jUS1z6B/fdh6XY
 cNMkfylbmORrdFYSvp555QLEY0HU/7zLCwsvsQEPy3FQQxTGzet9If7ldMsyL/Qv/23f
 o8s3O2XsZRfyDypbS8pNMwUpqGQG3A48odISa6dlnE4GhHmf2vg+gBogqYvHfVlh/Xdx
 e2M94diB4pED/esLRU750fvsBsaW1t9vI+4c1fz1aXGDUWfJfR1S9dr6GWMcegiO4oBn
 cqqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6e9TzZ834IyJBRWsN0O95+ISU2zeRDYg7y2ZHxPiMQj042ZRFwpR1Sq/JSvRDe2Pr48QFLSMhwNs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQ97IrHPGpA+xbX61AdXPvTTTt1W9bARL02HFHWdV/69oQ//Y4
 fkKmgSCKkydWGQA3SSxp6hEg9CBmB0F2bmK0WeJPYTlEgCxd+HAZT156fgXwMyh/8um0mwdFK7Z
 XUvu5So9A16rQfuzkX+5MVWuv65ux9HuY3OpGr5/7xEbgxSVbfCD46lphhm+nnc7ILxiwfPWwow
 1hpG2LAlc8Mg==
X-Gm-Gg: AfdE7cn7XdV8mBvdjCUkc/NIseY1Nm9yGRcZUq2m2+6JwSdvfhqLCB2CCp/y6hixCPN
 zFPV5ZlMwd6b9OvXQnQLV3HeDdgP6kmevjNAxj9mFIUyW5oRMdoLatZCvNf+oF/y1NaI484x3nK
 EMeY7ZDPuN7TR+1M0SegmcODa+wXBWLVJymj8zVCTEwKdjGz0RVtfIXMVjr6nhtquybreYpPVto
 vLqa9Dal0Rlsn1lFf5co54Od9aK/k6WhbDKE9fBypnz5E886fYNjPzbfFx8sd7cZ/GQi+z6Qp73
 ZptJY4zTJdwN7wuwfLdE5Eya+R3kPn5jWheKd1iggcEwEpX5Axzh9sks4dSC8ep/KDnzitGmP4R
 KKZgzpJLPK+1jgIabbFJKy+rR8lmm89LfVmeKSTMq7STN0ESPTYD8SBxtG9Xk/ai5RvrO8Dvuy/
 Q7UC/Gzh8=
X-Received: by 2002:a05:6a00:21cd:b0:835:447b:a2ac with SMTP id
 d2e1a72fcca58-84591b23f6emr2544148b3a.5.1782204124097; 
 Tue, 23 Jun 2026 01:42:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:21cd:b0:835:447b:a2ac with SMTP id
 d2e1a72fcca58-84591b23f6emr2544117b3a.5.1782204123617; 
 Tue, 23 Jun 2026 01:42:03 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564da30b5sm10828955b3a.25.2026.06.23.01.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 01:42:03 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH] drm/i915/psr: Skip PSR exit for legacy cursor updates on LNL
Date: Tue, 23 Jun 2026 16:41:37 +0800
Message-ID: <20260623084137.3421894-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

ORIGIN_CURSOR_UPDATE falls through to _psr_flush_handle() on LNL
(DISPLAY_VER >= 20), which calls intel_psr_exit(). Cursor plane updated
via legacy ioctl (drmModeMoveCursor) does not dirty the primary
frontbuffer, no PSR2 state change is needed. Match the existing
ORIGIN_FLIP behavior by unconditionally returning early.

Before this, the psr2_sel_fetch_enabled guard only prevented the early
return when PSR2 selective fetch was active, sending cursor updates
through intel_psr_exit() and causing a black line artifact on some
panels during the exit/re-enable transition.

Fixes: ef39826c12b4 ("drm/i915/display: Fix glitches when moving cursor with PSR2 selective fetch enabled")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index e138982dc91f6..32bee6c03b754 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3771,8 +3771,7 @@ void intel_psr_flush(struct intel_display *display,
 			goto unlock;
 
 		if (origin == ORIGIN_FLIP ||
-		    (origin == ORIGIN_CURSOR_UPDATE &&
-		     !intel_dp->psr.psr2_sel_fetch_enabled)) {
+		    origin == ORIGIN_CURSOR_UPDATE) {
 			tgl_dc3co_flush_locked(intel_dp, frontbuffer_bits, origin);
 			goto unlock;
 		}
-- 
2.43.0

