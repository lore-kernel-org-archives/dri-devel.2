Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0278606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oY9a2whz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14202112139;
	Thu, 26 Nov 2026 08:11:18 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22B110FC9C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:23:54 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cdd9d0c9bbdso3283843a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795616634; x=1796221434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DlrAgm4rvekrLWOzqqlR83LPwJZh1TAU2is28g+mTsA=;
 b=oY9a2whztRBIHX1YedvwmgzJ97CEfx5zhzsqt9D1uR1OmwQ/FhZUK5ajXfnc21b4js
 /08HpyiVzhbPrp0GJWSK6OXwdUInm2+QIQYsbpNIbVCL3o5OXD65Sw/Mob6QImoq7suI
 PeTXjRU+nimkD4fLwAm69DVbBe4fYuWt6dIA9q1pnfygg6sQsnus7VvznoyxH6UQRgtN
 BaaXVwSOF1Z1h7pS89pM82DyodMGZ81//8s4+HonHviV1BO1Tf9PlnBZ/MC15nCAC5SE
 0otukCWHXSFDjc5+SaqNiowFp9eMhgPgiPAhEZegFnYWkdiWiust3c2EDoKObyNcmY6X
 5mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795616634; x=1796221434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DlrAgm4rvekrLWOzqqlR83LPwJZh1TAU2is28g+mTsA=;
 b=tB6oURP8BVCoIHQG4cC8O8Egm74lv1Zd8z9z1PY4s0SPjQxVGu5sMCICXKySgW9wJM
 VAa2vecZkde1LncY3TBpwu3g9QPNfCvQV89dU/P/mlEnuu94WAkfCgHoQNSelgz5oO1S
 AkOYgnL8KR9TeqiMqojYTfqIWmqV2AHHw7eZE5yDytGAJrTXevfJjOcM1nnPtpwIQAZM
 JjEYnArRb5X1WnxSgrfbm7uGUMgbBrk7GIHbozE62QMCEGDwnaKfQqzoKpMzjTdDOaTp
 DFiff8P30aWRC20dn6472kxtxnfRx6ARY192U3ACn5QcBi3pYv8phRdTNjKJx9KPKCMg
 qS5Q==
X-Gm-Message-State: APuU4Z/ajJRx8OzJz6hfBAvPuTMEAyjjP49/H6KkaDogj8l9yGAaOkhY
 J6F7VY3gZ07csarARWTlsL+TsMIjDAiqf/WdYdnDAOSuvL3juoHgdHEdr/7joIDq
X-Gm-Gg: AZFdTZfNMBQeOhr4c1brU4JZE/qc0718+ZazV3t+k1C7HUbP1YhRFLgDYCQdRmrqNBt
 G2naJ/I+aDuHqGoQzQrw70Hwxt/nOT7CJKg521gd70vamgtK/3nM6LoBiykJC3z0s+gYmEHur3a
 ZvsfFQ+58tvn0h2L9bH6asrzIAOXRUf0A7DvBLBTfG//mRe4pGjI8k8RC7SkdK0cFOCFT7mP40T
 INuGP2fGp/O4WQ5+n3ff+3qlyPgtlrxlgo7+3qE0hIWRFsifM5N2NYZMa+qmcfGaGFdf2EUXWvM
 HU4KTFgxVgATBJ1fQOS6RbFfKrczJHiJqrGdKsgu7BxU5rvVfXxsrBDtHCB7SGWGPlCsBJsfXI7
 nVLrtFhAnHYrkgAuiCMzy6ufNBhlCeV9ksF55B3BkFPm/rbS0XpCjbP6QDL2cQCXGCyRJp1Xv9q
 Q7C/5AqojE3TBdeedHm6zF6XyAyKyn8qkQwkohpq7blBcJOUZgGgj+uWfxhRv5+sul9h18QTvQ0
 7jh66rO1WHTKFlVmAwuBJNcf+dXZZW6tbvBvx8NFsdl7JWhjlo5yj5U7LFv8rkvi8Bt73dy/9i5
 BNiNTzJLLC7JPIkHHz2svpiTMFSBRbgLNP8M2KlsPw==
X-Received: by 2002:a05:6a21:39b:b0:3eb:8c85:92b8 with SMTP id
 adf61e73a8af0-4014c94ca7emr19192828637.19.1795616634393; 
 Wed, 25 Nov 2026 06:23:54 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e45eccsm9115841b3a.31.2026.11.25.06.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:23:53 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, benjamin.gaignard@linaro.org,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH 3/3] drm/sti: hqvdp: start the XP70 from .atomic_update()
Date: Wed, 25 Nov 2026 23:23:30 +0900
Message-ID: <20261125142330.15298-4-hiyoukou@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125142330.15298-1-hiyoukou@gmail.com>
References: <20261125142330.15298-1-hiyoukou@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sti_hqvdp_atomic_check() boots the XP70 coprocessor, which loads its
firmware, then enables the main pixel clock and registers a VTG vsync
notifier.

.atomic_check() must not touch the hardware.  A commit with
DRM_MODE_ATOMIC_TEST_ONLY only runs the check hooks, so a client asking
whether a configuration is possible ends up loading firmware and
enabling a clock.

Both are one-shot, guarded by hqvdp->xp70_initialized and
hqvdp->vtg_registered, so nothing leaks, but they belong in the commit
phase.  Move them to .atomic_update().  As with the GDP, the failure
paths now log and return instead of rejecting the commit.

Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Minseo Park <hiyoukou@gmail.com>
---
 drivers/gpu/drm/sti/sti_hqvdp.c | 43 ++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index 360d213f2094..66abbe4de864 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1081,28 +1081,6 @@ static int sti_hqvdp_atomic_check(struct drm_plane *drm_plane,
 		return -EINVAL;
 	}
 
-	if (!hqvdp->xp70_initialized)
-		/* Start HQVDP XP70 coprocessor */
-		sti_hqvdp_start_xp70(hqvdp);
-
-	if (!hqvdp->vtg_registered) {
-		/* Prevent VTG shutdown */
-		if (clk_prepare_enable(hqvdp->clk_pix_main)) {
-			DRM_ERROR("Failed to prepare/enable pix main clk\n");
-			return -EINVAL;
-		}
-
-		/* Register VTG Vsync callback to handle bottom fields */
-		if (sti_vtg_register_client(hqvdp->vtg,
-					    &hqvdp->vtg_nb,
-					    crtc)) {
-			DRM_ERROR("Cannot register VTG notifier\n");
-			clk_disable_unprepare(hqvdp->clk_pix_main);
-			return -EINVAL;
-		}
-		hqvdp->vtg_registered = true;
-	}
-
 	DRM_DEBUG_KMS("CRTC:%d (%s) drm plane:%d (%s)\n",
 		      crtc->base.id, sti_mixer_to_str(to_sti_mixer(crtc)),
 		      drm_plane->base.id, sti_plane_to_str(plane));
@@ -1152,6 +1130,27 @@ static void sti_hqvdp_atomic_update(struct drm_plane *drm_plane,
 	}
 
 	mode = &crtc->mode;
+
+	if (!hqvdp->xp70_initialized)
+		/* Start HQVDP XP70 coprocessor */
+		sti_hqvdp_start_xp70(hqvdp);
+
+	if (!hqvdp->vtg_registered) {
+		/* Prevent VTG shutdown */
+		if (clk_prepare_enable(hqvdp->clk_pix_main)) {
+			DRM_ERROR("Failed to prepare/enable pix main clk\n");
+			return;
+		}
+
+		/* Register VTG Vsync callback to handle bottom fields */
+		if (sti_vtg_register_client(hqvdp->vtg, &hqvdp->vtg_nb, crtc)) {
+			DRM_ERROR("Cannot register VTG notifier\n");
+			clk_disable_unprepare(hqvdp->clk_pix_main);
+			return;
+		}
+		hqvdp->vtg_registered = true;
+	}
+
 	dst_x = newstate->crtc_x;
 	dst_y = newstate->crtc_y;
 	dst_w = clamp_val(newstate->crtc_w, 0, mode->hdisplay - dst_x);
-- 
2.43.0

