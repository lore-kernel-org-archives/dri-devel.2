Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AB9CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A6010E6DA;
	Wed, 10 Jun 2026 03:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tOOR196l";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416BF10E6E3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 03:54:32 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-36dac5d5d05so3398075a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 20:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781063672; x=1781668472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kizIObzKL4IBfyjyeIAkjO2Eens7kW7Bizncq6rSEY4=;
 b=tOOR196lfiqnUv7ESnPcGM6P+NUzPo0W0NLX84B83CXJtX5HqB0Cm8bgqs0XLLKqhu
 mUriQ3PVOc3azqpsXB1L24BsFjiO+JiL7PzYSjXKxBkl5wSybA6LOeacyLINLM7L8tsI
 Tptike8Ilm4srE1RV1sr0JlwZb1Mi4tqKPnstuQuPIQemMFNokom+N2XdLKOh7VKXwqj
 NWdirt4pFmyXcClKwUU5ZqWjxoq8XrWhU+TsvnWpEr372Z8Um0sdcHvgHjvB2QPiUW13
 CdKiQtC/rSYDOcH0hbG5v4tjKdb9VtG4JrlHkosEngD3V6Nlj/bxkZp7afVETTk/ActJ
 UaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781063672; x=1781668472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kizIObzKL4IBfyjyeIAkjO2Eens7kW7Bizncq6rSEY4=;
 b=I9ZeW4dJU3M6G5tqiLgH10w35OPeYLZ7hdlPSnp9dcaiquqH/5rk9+fV8cA3anWpWW
 YpMpgQOLNovqp0dPx7KmWou9cxYAgZiVRgInATk03cINTmwfsKrAnD2uqH6Y/PE8A1Gf
 hp/PYFP7kelfwkb8rB6UjVCeVzPDPlSECFNDyLblZesDNsz20j72Fbt+Upf7/gCiJZDO
 p9vqCQKUD6tCmVOiSMSG4iVBMSlLjnnyrO7IjbqnWXb56GCrqvVAN7WYDMTMKyU45ryb
 5KXNXYKaLa8QBEiI5NGbOv9b8Kg6aTLbcq5LpWJZbk2aYC9AcAygB1JPS6IH18ojyMvf
 DWjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mJaWsHwAOJ2jLk+h0fUTVB/mE4GLR80BSWsnnmmLgbUP8UJxiEl52UHHbdQXNFhnMigPAaYhiuDY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJqi4CZJ3Ffkc2RWPLN74S4aEcfbgL9vGh5ABumLoA3Q/TKKZO
 0FTP2odTkG3bcOAm7r8bu+sloOY47ZeBQzcj3vbMhBNx3L1d8ng42OQ6
X-Gm-Gg: Acq92OGLUflU4VfOBYfsNdWJW24H0zkgnF9VaF8mV5j6jAnM9HkBRksJTDnDL3IjflD
 QmnoM9oQgbPM6GnyaH/lT3LMGB+94wyXYe2NdEXKZC51Fn/lTk/Yc6euyNSU0KhCSBX8GaCv/aC
 wHz0jG2yKSpuKfeGMIpgaDTGjR0/tgWej81pU5QlBA4Mp2mvjEZwYBm8bDBtRyKsZJrZOAWn3w/
 CuHxlCZgyPo/IW7pULiFinc5pXXPliK0fWSWV+Cl5eZF1O7O0AM7e/Z1uaEscN+3rvIWRJ2aK92
 tSTzOIKQA4mZaoch0+2DPB5rt17FxhtQufJAPhdllhds5gOie0raLL44BNA3O5uwAy582AnUK/3
 HHolTAc8dDQjtUKH7K1EnVD51NhUtUBUSduBX0n5a0d6yoClplJkashg5nPWfdO3PyvYGuSv8p4
 kW6H8Z6c+0OD/AKBwq+PXYWxQ=
X-Received: by 2002:a17:90b:4cc9:b0:36d:8e49:d8 with SMTP id
 98e67ed59e1d1-370f04818e9mr25545873a91.15.1781063671578; 
 Tue, 09 Jun 2026 20:54:31 -0700 (PDT)
Received: from lgs.. ([101.36.111.22]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3762128130asm1180510a91.1.2026.06.09.20.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 20:54:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Uma Shankar <uma.shankar@intel.com>,
 Imre Deak <imre.deak@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v2] drm/i915: clear CRTC color blob pointers after dropping
 refs
Date: Wed, 10 Jun 2026 11:54:19 +0800
Message-ID: <20260610035419.1596963-1-lgs201920130244@gmail.com>
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

intel_crtc_free_hw_state() drops the CRTC color blob references, but
leaves the corresponding pointers unchanged.

This can matter in intel_crtc_prepare_cleared_state(), which frees the
old CRTC hw state before calling intel_dp_tunnel_atomic_clear_stream_bw().
The latter can fail while looking up the DP tunnel group state, for
example with -EDEADLK.

If that happens, the function returns without completing the cleared
state preparation. The failed atomic state will then be cleared by the
atomic core and intel_crtc_free_hw_state() can be called again for the
same state, dropping the same blob references again.

Clear the blob pointers after dropping the references so repeated cleanup
of the same CRTC hw state is safe.

Fixes: fb69d0076e68 ("drm/i915/dp_tunnel: Fix error handling when clearing stream BW in atomic state")
Suggested-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Keep the original ordering in intel_crtc_prepare_cleared_state().
  - Clear the blob reference pointers in intel_crtc_free_hw_state(), as
    suggested by Imre.

 drivers/gpu/drm/i915/display/intel_atomic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
index 71b7325917b6..0cdae87e4bfc 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic.c
@@ -294,6 +294,12 @@ static void intel_crtc_put_color_blobs(struct intel_crtc_state *crtc_state)
 void intel_crtc_free_hw_state(struct intel_crtc_state *crtc_state)
 {
 	intel_crtc_put_color_blobs(crtc_state);
+
+	crtc_state->hw.degamma_lut = NULL;
+	crtc_state->hw.gamma_lut = NULL;
+	crtc_state->hw.ctm = NULL;
+	crtc_state->pre_csc_lut = NULL;
+	crtc_state->post_csc_lut = NULL;
 }
 
 /**
-- 
2.43.0

