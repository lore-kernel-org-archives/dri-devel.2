Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F62CCD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 06:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41ED910E466;
	Fri,  5 Jun 2026 06:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VotzUqye";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BBC10E46D
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 06:07:50 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2c0c2d792c8so10561265ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 23:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780639670; x=1781244470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M5WkcatAHhLMBNeD67NubkG9Mg0FFDk4z9wml5JZOUU=;
 b=VotzUqye4l8ufsB0FJ8tEP7J+6cOElz5twrd8zV4DPpK/zK1E1ttRIrbeIrBIGCxv0
 2F3yleNhIa43o/iPh9dVPdjrFasLMXzfv+9bDEXbYSQtC09FvxBnC/vYjE3AD4MlDpbr
 iE5F2PwXU/0QWKjRlJDMgl5aCsqOqQWalXbP0WPHEYDBHdPU+T+Tv168u0sR8OLljtxs
 +3olFCZFSZpekkp9Mh3GpoE+3GcHUJE70pXX2os2VxIfhE/tv4tDuvc0e73PoZNNaKkB
 3GaDmkYG6pUMZRAo+Dq0WsDhm6tSjBMLKMY98fHpnmGXxE5KeiNIqQQw5YTkE2H4nXiE
 FAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780639670; x=1781244470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5WkcatAHhLMBNeD67NubkG9Mg0FFDk4z9wml5JZOUU=;
 b=BO4u97E5LvUFSQPY9LDzb0zVxeohPshhNwHtRdA0Ddk0Q9A5AtEGs3H6DhbVv5LPMu
 Fod6MlJ7hW2jDfA7VZrUknfGKFP3m4S5pE8FQL2Fg9WiwL16UltUphtkLvGtm7kUQOhe
 1ZkljrD4MLsFHhYdNLTLl2RiJsT0vrQi33VvHHWFvLKFSP+nWQzBtSg14qqwN3NhcS5F
 UiZo3j/qf5YslYuUAJLaTZ97qXnVY77M9i2vYqZygW9x7f3K9L9Rd7EBEAGWcJPlHrI4
 Ox7F864mumT0ZnGyLIr/e2xD3b5t8u9u7OCMUCJRRmWlLsSXFaY3mejggNx5B9cxtL7i
 Npog==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wtSiPOGcENmjqJHr7JOTjTObwg7NbqSTQ1qFZG70pMY4cj5dfFbmJlwxiBC5dFjx1NV2FB+la8jE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5XgdolmORyRrMGvBPOLRgJH/VeSvFB+Z2VgpMaTlN74HzXSdK
 55v3X84MIzBu3YoULoOp8s63By1tYQQb5lTZTCKWazSRdzoUa5GmDyh1
X-Gm-Gg: Acq92OFBJAqYkri94R+OZsseiE+cUr6JKvstjP03v3XG6xOwQ0LwnIAaxbl+XcPgRuJ
 PT0DAgugk27CBCPkQFwnNhA420Eiqj8vfKqVQiPGcVUt3bVJ619KexrajycbXTq2HBVYFGC/1P7
 0xSB4wzavfvhhkfAc6yWwK7NkPCA9Zl64X/cR3jB/5gtJtsNlEJDKNYRxDQe8pPNbZwL+N4jxuD
 ERmsiyp3s/ZGLuw0tWsc6Yj5PY145rxsrMSmctPJVN+jKl1Ng5/BlC5icmzOExMNMInFG6aoPWS
 h/NwldX9PiGeB5vLAC0DoclfkKhNbT009stNaJf60R1G9nx3HBI0kAjFOuvttZSHc4+zsGqq6Ij
 YNboZyzt8XSB312Qn7lW1cKopxVPgV5EmpKfxyin0ip9kFcOmG69EvZHkKA0aajgwrSfh3xTwis
 APPxjB8bDM5GIKkDMR
X-Received: by 2002:a17:902:fc46:b0:2c0:b9a1:6493 with SMTP id
 d9443c01a7336-2c1e7b082b4mr20237105ad.10.1780639670162; 
 Thu, 04 Jun 2026 23:07:50 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1646e5c51sm77298475ad.0.2026.06.04.23.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 23:07:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Imre Deak <imre.deak@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/i915/dp_tunnel: fix CRTC hw state cleanup ordering
Date: Fri,  5 Jun 2026 14:05:27 +0800
Message-ID: <20260605060527.1443552-1-lgs201920130244@gmail.com>
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

intel_crtc_prepare_cleared_state() frees the old CRTC hw state before
calling intel_dp_tunnel_atomic_clear_stream_bw(). The latter can fail
while looking up the DP tunnel group state, for example with -EDEADLK.

If that happens, the function returns without completing the cleared
state preparation, leaving the duplicated CRTC state with its hw color
blob references already dropped. The failed atomic state will then be
cleared by the atomic core, which can drop the same references again.

Move the hw state release after the DP tunnel stream BW clear has
succeeded. Keep the temporary state allocation before the failable DP
tunnel operation so an allocation failure cannot happen after the stream
BW has already been cleared.

Fixes: fb69d0076e68 ("drm/i915/dp_tunnel: Fix error handling when clearing stream BW in atomic state")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index ad2fe10b6b1f..0c015bc6c9fd 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -4646,9 +4646,6 @@ intel_crtc_prepare_cleared_state(struct intel_atomic_state *state,
 	if (!saved_state)
 		return -ENOMEM;
 
-	/* free the old crtc_state->hw members */
-	intel_crtc_free_hw_state(crtc_state);
-
 	err = intel_dp_tunnel_atomic_clear_stream_bw(state, crtc_state);
 	if (err) {
 		kfree(saved_state);
@@ -4656,6 +4653,9 @@ intel_crtc_prepare_cleared_state(struct intel_atomic_state *state,
 		return err;
 	}
 
+	/* free the old crtc_state->hw members */
+	intel_crtc_free_hw_state(crtc_state);
+
 	/* FIXME: before the switch to atomic started, a new pipe_config was
 	 * kzalloc'd. Code that depends on any field being zero should be
 	 * fixed, so that the crtc_state can be safely duplicated. For now,
-- 
2.43.0

