Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A1606A331
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h0NAbfSX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E93112127;
	Thu, 26 Nov 2026 08:11:05 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580AC10E1EF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:47:30 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so10812615c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795661249; x=1796266049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Id0tE6U3zbTnx8d6Azmwz2aEvchWgOayrFm/0BxtwSY=;
 b=h0NAbfSXgqEhNxQQcL09+saPIo2a9VwXM2jYhZBx+cYubRCwaybyY9iHK1D57U2/Y+
 qeDR20mB9c/apTbJPqUr5BarcktzjCOb+C1b0zoDd4kYy50MrcLKUR6zArHNnCgFKYLc
 pnrMFmZoSdRRXlamp7NwgWWo1t2dmy0Xq3pLyuOP1cFHu8nAvDiZDqTTGHShxRgJY2Vh
 KMfJ/vGl6hdi9qa+8ycFYoOJ3jcs7uYIqabISSslzMWMVoK3iPWEgCLeyufkT0MlTrsJ
 bF9j8S0zcPzdPYh3mcKiNSdCCIDSA4Un0XI7c3GBaXxJfhpHaPc+ePf9XdZHOg+dWsJ3
 fFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795661249; x=1796266049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Id0tE6U3zbTnx8d6Azmwz2aEvchWgOayrFm/0BxtwSY=;
 b=jXMApWuIYFb6d5LnsUtApKwTuR44iWbFYmg8U4TkRLLZPfgsYGD5Hm2xti5k86DP84
 zfVcK+sbZCxo2aJWZHZKZ5cMrLkh1yVVINLIlfHRVoD//RxwENCYNZPOtbbgd9wxBF+p
 08xvV8nR/AV5BbAR19cOpr50Xv/+m0g3JPKg0loz3w1cv6sDowvAwrv3lcTolk4SkJCd
 ud0Jpvj+ecNgs8TXMvpEhe6YRCMy+WjXLK2sHmOVkuhCglYAHUVEJpkjYvVMYVmlobcJ
 N0sRAWBXpRbFM3G21qujFKkyTn4DMgc3wO+1ga14K8fU61y7keKYBUU/DVQV3K2uoTHC
 4Buw==
X-Gm-Message-State: APuU4Z9B6ICThBk4NOJzokgSXDMRUP2G38++C07p879Zz42UjTdaOozS
 c/VNNHiLk06fXYery/i7Ojy5DHDfEz3Vlx9uDa3ikXr/PxfH+9hv0Q8Ruu/j67md
X-Gm-Gg: AZFdTZfekDKNTClgaRTYpMFXb3Q9i2j9cGcOBKeZg9finPAFNMZk4P6H9bD6aRCpzgj
 PoimVAF4j1pb91ya76hQS2fr9pcB75b5YgUPc42OfTDwthKoIUkJxkirn5mVJPLX4plIGdBVvz7
 GwVlLdQgfbyJZU1kvpNQKE+fKjdsFoRKUiHqbwUmwtuLWk6hZMEzcs9vlX5wf/jzQA86Ayb+DDw
 Nq3QaH3JAlR1QtIJoqdKLKEweQEGvyp/he4iFeeDRtC6OS36LEXQCOW5bJ0b1O/DMY93tOG5HI0
 0G3vx1ZvzChBDLlPRL3GApd67vC+dHNOWC8HVCuvrMVbIsYs1uxgLZdi9Wt859+2QuTwyUQ79a6
 p9fOqN2P+hJrVJl59IcvNQt5VeSRYScy4OV8wypVjQEU/lAFd/LkASVs4eAKhQN4OEqaoFkeIad
 C83f9FjGz8zkEWAWqm7Q9wiwRSQdWNyp3krSenriXv0b4BrRpHy8L0bqAASeyQTHWNcPo7uSb0a
 Dz615u2CmBRgNuf2SIfy4hj1Iza3XEdR1j5b1AY0NBZgOXecIB9sUF5hbviqqOxO/wugYjRa/ke
 0esgHrySW0SVM0rx0Qq9yKl8gf7+kQLKSNXimW+tkw==
X-Received: by 2002:a05:7301:d81c:b0:386:b7d2:a279 with SMTP id
 5a478bee46e88-386b7d2aba6mr9405586eec.34.1795661249502; 
 Wed, 25 Nov 2026 18:47:29 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm70815493eec.5.2026.11.25.18.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 18:47:29 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, benjamin.gaignard@collabora.com,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH v2 2/4] drm/sti: gdp: set the pixel clock from .atomic_update()
Date: Thu, 26 Nov 2026 11:47:08 +0900
Message-ID: <20261126024710.33401-3-hiyoukou@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126024710.33401-1-hiyoukou@gmail.com>
References: <20261126024710.33401-1-hiyoukou@gmail.com>
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
programmed.  A clk_set_rate() failure can no longer reject the commit, so
it is logged once and the plane is left as it was.

The check still rejects a mode the clock cannot reach.  clk_round_rate()
reports the rate that would be selected without touching the hardware,
which is how the connectors already validate their own pixel clocks in
.mode_valid().  It rounds against the parent that is selected now, so the
check is skipped when this commit would reparent the clock.

Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Minseo Park <hiyoukou@gmail.com>
---
 drivers/gpu/drm/sti/sti_gdp.c | 73 ++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index d0c886029c57..4a01bc64f4ab 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -6,6 +6,7 @@
  *          for STMicroelectronics.
  */
 
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
 #include <linux/seq_file.h>
@@ -28,6 +29,9 @@
 #define BIGNOTLITTLE    BIT(23)
 #define WAIT_NEXT_VSYNC BIT(31)
 
+/* Same tolerance as the connectors use in their .mode_valid() */
+#define CLK_TOLERANCE_HZ 50
+
 /* GDP color formats */
 #define GDP_RGB565      0x00
 #define GDP_RGB888      0x01
@@ -667,29 +671,28 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
 		return -EINVAL;
 	}
 
-	/* Set gdp clock */
+	/*
+	 * The pixel clock is programmed from .atomic_update().  clk_round_rate()
+	 * reports the rate that would be selected without touching the
+	 * hardware, so the mode can still be rejected here -- but it rounds
+	 * against the parent that is selected now, so only rely on it when
+	 * this commit is not going to reparent the clock.
+	 */
 	if (mode->clock && gdp->clk_pix) {
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
+		struct clk *clkp = mixer->id == STI_MIXER_MAIN ?
+				   gdp->clk_main_parent : gdp->clk_aux_parent;
+		int target = mode->clock * 1000;
+		long rounded;
+
+		if (!clkp || clk_is_match(clk_get_parent(gdp->clk_pix), clkp)) {
+			rounded = clk_round_rate(gdp->clk_pix, target);
+			if (rounded < target - CLK_TOLERANCE_HZ ||
+			    rounded > target + CLK_TOLERANCE_HZ) {
+				drm_dbg_kms(drm_plane->dev,
+					    "gdp pixclk=%d not supported\n",
+					    target);
+				return -EINVAL;
+			}
 		}
 	}
 
@@ -757,6 +760,32 @@ static void sti_gdp_atomic_update(struct drm_plane *drm_plane,
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
+			drm_err_once(drm_plane->dev,
+				     "Cannot set rate (%dHz) for gdp\n", rate);
+			return;
+		}
+	}
+
 	dst_x = newstate->crtc_x;
 	dst_y = newstate->crtc_y;
 	dst_w = clamp_val(newstate->crtc_w, 0, mode->hdisplay - dst_x);
-- 
2.43.0

