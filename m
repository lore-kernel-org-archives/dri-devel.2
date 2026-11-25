Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F520606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OzPe+ftx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF55710E2DB;
	Thu, 26 Nov 2026 08:08:59 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA4910E8F0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 14:23:52 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8c20d68c83fso3685312b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795616632; x=1796221432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x00FGmiNMA24A5ACWywC+7IOWAvihEhzIQfnJRlM3xI=;
 b=OzPe+ftxMUf2we1ccJd/oHzkd4G7VpZOUu/ppJEgWG88yjucZ7xgIwfIM+AbUaegD9
 RJlJhhiILv1zm2EgxQwiWKHioRkI76EOcsgbGBYEnOZGM6rf9qM2Sno0vSrYN3PlTyB+
 Jb3JcTfL6Hd6lg6sjKqpUGxmk6UfgkUGUZVQMwNt/+CAQbfSj4noNCXv9fayTXE8KQoV
 YhZxx0ssT+5+Nr3RnVkEkUcKoenNDMoZmhAY630ufkNB+fo2dhxcJ2+FEqP10swgp9Qe
 nJgPPBEPxD0aB30M/fuk6yjOFbF2EOTiuI1X+6f49CdtG3NL5ur2VHErBdAxX4rcxDlx
 ItZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795616632; x=1796221432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x00FGmiNMA24A5ACWywC+7IOWAvihEhzIQfnJRlM3xI=;
 b=1qCOeWZFm8Gs6mWP5HKNjW3wR8L+RZfwY9WMrC+hYNtoOspuymq1hT/fEdtWvCRbMr
 UPmjRU569H06GKKmVcebwIJtHi6ffXXtt8RMs1CyzpCHISnBnHIb5B7CGFpYv8KF2b8M
 yJ2dtdQKGWDg/RRcFVD/viFVQxvgqAliRhCGWXy4MGH467NqDTlgbp6DpE5lyHtAlgEw
 tsmcobabTS8TxNDuu5HCzgkBEWJcuF3ymHfjQDNQzicL9QUbcGMqWhl/Kuadu3l5FK7K
 6Y3D5SRFPz1oxnvocriiiOsP1kkODUj2QUQpWOWxA3rtAWof+YyI08gwotig/yU7UPZA
 5yWw==
X-Gm-Message-State: APuU4Z+96ldSWb4485y2NPJGMthSPZ8MFSmZ4Se+cnp3go1+YMpLn8tQ
 6bE5tKWv4XVRe3Tqypgmki134eLvHQEHUnjMzkecz/XjNPRrBN6C1zyUFkaDG7cV
X-Gm-Gg: AZFdTZcvX+rhkvAlCVzEVKaAk6AXg5IgWSWigZt8AMv2hX3IPBftlm5IxRcq5XiwAS4
 7qxr7YnPksnQfNxMBSpt9M69j90ZrMdUHqK4GiSCAyfUtPAaQW9It9V0YUi0wAf4RkuZH47CMhm
 BoWx2ytQ7dkkd51hJ98qgm3wVz6U64Q2U/9rA3036TLBiYtaDaIyND2Xb8XR2nR3o+8P1lvqrNn
 OAbkCL3JKVndovtteENrYcr+nSPXmRlSYfclPY6qTwSST4Q2k/I+8diOrOfcmZ/g1B0lr5DaJQf
 Wu4l+iuDOZ5wRj9BAVMUgzEMSpgNmztFHQ6hkutVREJgrkKhMXwAXFor23UVJH13g2y1Lf4gPkU
 h+wJb0ZZwMPFynaNqFuikmLK74zC1Q1KoH+Hkq/2C/kC0iWznAX/w66mdgOCfo9ZYBFxkNW1QvI
 I8G5kRBEIwFGAnKGkrTm7D6cT6QGlT2KjJRf9q4u6hQYeVoBP9bnavSeSTfIfNu849bURF17BdS
 QEsLLDkcZKa5qhcRsHWbPuFCavsnMlrgvBynQlwAdDjGcP8BpsEnpLJA9GOZATI5sKZfEQMmUpW
 tM0lGLZen06+gfMihPiE0RbnyrHpJzHEaHjmUxxXpg==
X-Received: by 2002:a05:6300:2201:b0:3de:3f4d:f2bd with SMTP id
 adf61e73a8af0-4014a07116dmr12244418637.6.1795616631738; 
 Wed, 25 Nov 2026 06:23:51 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872e45eccsm9115841b3a.31.2026.11.25.06.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 06:23:51 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, benjamin.gaignard@linaro.org,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH 2/3] drm/sti: gdp: set the pixel clock from .atomic_update()
Date: Wed, 25 Nov 2026 23:23:29 +0900
Message-ID: <20261125142330.15298-3-hiyoukou@gmail.com>
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

sti_gdp_atomic_check() reparents the GDP pixel clock and calls
clk_set_rate() on it with the clock of the mode being checked.

.atomic_check() must not touch the hardware.  A commit with
DRM_MODE_ATOMIC_TEST_ONLY only runs the check hooks, and a commit that
fails a later check is dropped, so in both cases the clock of a mode
that was never applied is programmed on a display that is still scanning
out the previous one.

Move the clock setup to .atomic_update(), where the rest of the plane is
programmed.  A clk_set_rate() failure can no longer reject the commit,
so it is logged and the plane is left as it was.

Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Minseo Park <hiyoukou@gmail.com>
---
 drivers/gpu/drm/sti/sti_gdp.c | 52 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index d0c886029c57..09f8d3f936ca 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -623,7 +623,6 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 drm_plane);
 	struct sti_plane *plane = to_sti_plane(drm_plane);
-	struct sti_gdp *gdp = to_sti_gdp(plane);
 	struct drm_crtc *crtc = new_plane_state->crtc;
 	struct drm_framebuffer *fb =  new_plane_state->fb;
 	struct drm_crtc_state *crtc_state;
@@ -667,32 +666,6 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
 		return -EINVAL;
 	}
 
-	/* Set gdp clock */
-	if (mode->clock && gdp->clk_pix) {
-		struct clk *clkp;
-		int rate = mode->clock * 1000;
-		int res;
-
-		/*
-		 * According to the mixer used, the gdp pixel clock
-		 * should have a different parent clock.
-		 */
-		if (mixer->id == STI_MIXER_MAIN)
-			clkp = gdp->clk_main_parent;
-		else
-			clkp = gdp->clk_aux_parent;
-
-		if (clkp)
-			clk_set_parent(gdp->clk_pix, clkp);
-
-		res = clk_set_rate(gdp->clk_pix, rate);
-		if (res < 0) {
-			DRM_ERROR("Cannot set rate (%dHz) for gdp\n",
-				  rate);
-			return -EINVAL;
-		}
-	}
-
 	DRM_DEBUG_KMS("CRTC:%d (%s) drm plane:%d (%s)\n",
 		      crtc->base.id, sti_mixer_to_str(mixer),
 		      drm_plane->base.id, sti_plane_to_str(plane));
@@ -757,6 +730,31 @@ static void sti_gdp_atomic_update(struct drm_plane *drm_plane,
 	}
 
 	mode = &crtc->mode;
+
+	/* Set gdp clock */
+	if (mode->clock && gdp->clk_pix) {
+		struct sti_mixer *mixer = to_sti_mixer(crtc);
+		int rate = mode->clock * 1000;
+		struct clk *clkp;
+
+		/*
+		 * According to the mixer used, the gdp pixel clock
+		 * should have a different parent clock.
+		 */
+		if (mixer->id == STI_MIXER_MAIN)
+			clkp = gdp->clk_main_parent;
+		else
+			clkp = gdp->clk_aux_parent;
+
+		if (clkp)
+			clk_set_parent(gdp->clk_pix, clkp);
+
+		if (clk_set_rate(gdp->clk_pix, rate) < 0) {
+			DRM_ERROR("Cannot set rate (%dHz) for gdp\n", rate);
+			return;
+		}
+	}
+
 	dst_x = newstate->crtc_x;
 	dst_y = newstate->crtc_y;
 	dst_w = clamp_val(newstate->crtc_w, 0, mode->hdisplay - dst_x);
-- 
2.43.0

