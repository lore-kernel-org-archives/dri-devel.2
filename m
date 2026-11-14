Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81805606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=URQTty+q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C932F10F02E;
	Sat, 14 Nov 2026 16:25:09 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D583F10ED18
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:44:02 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c5067a2411bso291399766b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794620641; x=1795225441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tn87j8WCS61Gao2LJeMNy/CQlTMoWJ0AG+YUO7C/2pc=;
 b=URQTty+qjAu7RT0pzU3ezdObjMlzkiUcDvroGBcvGA7g+ygUzw0m2gP3nRyPxjXh+Z
 l9gBgjRStR1igtUUTrVo9ZUoj3TBA4U0hXy2VTUrmuR4uptjLhlEdYPiargsVVjJPzwS
 e5bsBuK5ILnoJCuKSLaF181yts6Pz+bnIfssWeZwoRpztqkxZc2zan2jJLcOF8fEv8uz
 Fsy/D+5bM5V8IUoFaVfhZGTQEui+SIumeq2eYMTIkycPpbbGhKiE3fXvwCUH6r2Xog0T
 f6wCzuzllgB/hsZWJZgv2iapShsVQyy71XfGRb1kqH93MjHjTKgWoiXqDXmFocGmbqoX
 0WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794620641; x=1795225441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tn87j8WCS61Gao2LJeMNy/CQlTMoWJ0AG+YUO7C/2pc=;
 b=0oqER10CRB3pplGhEXl8bOJ0Kvol2BVPZ8cysjfUljpjXCs6c01EYdJhWgABAhGyeo
 R5qiFOUFBi4iaqg3kX9JiD1EemHRXfJy5R7/CgO6EKo6x5niC4w2w5qA6h7M3p07soRz
 +jpA1VlVL1EbS2GM8JcD77oLlz8KGWOMraroWa//W1Ip+4VvzF6S/nZWYPSlYC7HALzl
 t900QKrx47WkJNcurTO9/aSTStdDsaoik61DUHA8rGPApGrkwfPgyCetOrF28TFyU51O
 sD/r1uoZCCK4SkMxTmwEySiJaJ4BLmLGoap3Jqfhpkj0jVvzovLnb/x1ZrZVeKFAKIxY
 xGaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErElASknbDeg3kGX8G4h5I2InPgv1rSdPdIRq34a/jJjxvYAOOj8XxiXDFH2To6AjgO/O+zStf+vNkA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8GCA8VJCiw1hbe3Q/xidv14HMzdRQFAeWTxkC8GCUZIBt6aDmX
 4j6bQ6jiC9Keiv0vJRlWXXo27gCqpjznKKnAaGkw4UbtKdTuLg0AdjTP
X-Gm-Gg: AYBFou0k2eWgA98EWdkhuYwGXXhWsHQPu9g496Tq6WVmeDdCYYVfqbLshyHWhs+CsWk
 0DUNLHQ1Uf5u1d65d9xr9Fy+2c7Xkm973i8G/+K9tZcwT72+FEjs0QuZRbADUGBfSjx9J18xnMv
 s5xckd+m65lI/tz5HRuNnBBLESDUimY1xqJc4IQQW/yge9o3Pl1FnGGBNvrVTMgT2e3lAMB7zFH
 TZxgnfbWkGXT1k0welPlMf7pc2JB54S8QJ1itIAZScDyrdShlKFbj8gYmX2wDl7yCB95qtqEzzc
 ztsW3fxvXGqqHfLhpyhEDy9ciY9SDRLUVGu5BN+zAOGpGIhHSNCbJnNKTjBqwSCts4dpjnshgDz
 Gb7uYE1ahWAv90cffjVoztMcH2rcwVfLEz5LPBljbpkz7Emoi+Op5ZkOHJz9WkpDavT17deLMkV
 gXHPvQzXJJUI/nZkSGbJjNYvIwZLebyviVLZIhHQWPgcPY8D3IAY/jsoWB39eBUPuLxJB17KfiJ
 g6/pKQgXFnpVrl9uSYn7KH5qBaAcfEBoTZRfXEiaM5XXWUh8802vy5vUwF/ZGlQiG8pepCz2CxR
 vcfkMpbAXYQ9UrnV/g5veY+mrixqg7gGiFifF69XonFPxUnN2BrejWG1o5EjcmGnXlYkNQKXV/m
 uQ4pZXQ4guJkAR2k2xE2kgf8=
X-Received: by 2002:a17:906:9f92:b0:c40:9e84:942a with SMTP id
 a640c23a62f3a-c509684d88cmr391927766b.48.1794620640864; 
 Fri, 13 Nov 2026 17:44:00 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5a4c1sm161402666b.48.2026.11.13.17.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:44:00 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com,
 mitulkumar.ajitkumar.golani@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ElXreno <elxreno@gmail.com>
Subject: [PATCH 4/7] drm/i915: Split intel_update_crtc() into its stages
Date: Sat, 14 Nov 2026 04:43:32 +0300
Message-ID: <20261114014335.2132756-5-elxreno@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114014335.2132756-1-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pull the arming of a pipe on the MMIO path and the bookkeeping that
follows the commit of a pipe out of intel_update_crtc(), into
commit_pipe_arm() and intel_post_update_crtc(). The next patch arms
several joined pipes inside one vblank evasion critical section and
needs them separately.

No functional change.

Signed-off-by: ElXreno <elxreno@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 82 ++++++++++++--------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 20b1103e3de4..aa03f674d93b 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7087,46 +7087,29 @@ static void intel_pre_update_crtc(struct intel_atomic_state *state,
 	}
 }
 
-static void intel_update_crtc(struct intel_atomic_state *state,
-			      struct intel_crtc *crtc)
+static void commit_pipe_arm(struct intel_atomic_state *state,
+			    struct intel_crtc *crtc)
 {
-	const struct intel_crtc_state *old_crtc_state =
-		intel_atomic_get_old_crtc_state(state, crtc);
-	struct intel_crtc_state *new_crtc_state =
+	const struct intel_crtc_state *new_crtc_state =
 		intel_atomic_get_new_crtc_state(state, crtc);
 
-	switch (new_crtc_state->commit_type) {
-	case INTEL_COMMIT_FLIPQ:
-		intel_flipq_enable(new_crtc_state);
-
-		intel_crtc_prepare_vblank_event(new_crtc_state, &crtc->flipq_event);
-
-		intel_flipq_add(crtc, INTEL_FLIPQ_PLANE_1, 0, INTEL_DSB_0,
-				new_crtc_state->dsb_commit);
-		break;
-
-	case INTEL_COMMIT_DSB:
-		intel_crtc_prepare_vblank_event(new_crtc_state, &crtc->dsb_event);
-
+	if (new_crtc_state->dsb_commit)
 		intel_dsb_commit(new_crtc_state->dsb_commit);
-		break;
 
-	case INTEL_COMMIT_MMIO:
-		/* Perform vblank evasion around commit operation */
-		intel_pipe_update_start(state, crtc);
-
-		if (new_crtc_state->dsb_commit)
-			intel_dsb_commit(new_crtc_state->dsb_commit);
+	commit_pipe_pre_planes(state, crtc);
 
-		commit_pipe_pre_planes(state, crtc);
+	intel_crtc_planes_update_arm(NULL, state, crtc);
 
-		intel_crtc_planes_update_arm(NULL, state, crtc);
-
-		commit_pipe_post_planes(state, crtc);
+	commit_pipe_post_planes(state, crtc);
+}
 
-		intel_pipe_update_end(state, crtc);
-		break;
-	}
+static void intel_post_update_crtc(struct intel_atomic_state *state,
+				   struct intel_crtc *crtc)
+{
+	const struct intel_crtc_state *old_crtc_state =
+		intel_atomic_get_old_crtc_state(state, crtc);
+	struct intel_crtc_state *new_crtc_state =
+		intel_atomic_get_new_crtc_state(state, crtc);
 
 	/*
 	 * VRR/Seamless M/N update may need to update frame timings.
@@ -7168,6 +7151,41 @@ static void intel_update_crtc(struct intel_atomic_state *state,
 	}
 }
 
+static void intel_update_crtc(struct intel_atomic_state *state,
+			      struct intel_crtc *crtc)
+{
+	struct intel_crtc_state *new_crtc_state =
+		intel_atomic_get_new_crtc_state(state, crtc);
+
+	switch (new_crtc_state->commit_type) {
+	case INTEL_COMMIT_FLIPQ:
+		intel_flipq_enable(new_crtc_state);
+
+		intel_crtc_prepare_vblank_event(new_crtc_state, &crtc->flipq_event);
+
+		intel_flipq_add(crtc, INTEL_FLIPQ_PLANE_1, 0, INTEL_DSB_0,
+				new_crtc_state->dsb_commit);
+		break;
+
+	case INTEL_COMMIT_DSB:
+		intel_crtc_prepare_vblank_event(new_crtc_state, &crtc->dsb_event);
+
+		intel_dsb_commit(new_crtc_state->dsb_commit);
+		break;
+
+	case INTEL_COMMIT_MMIO:
+		/* Perform vblank evasion around commit operation */
+		intel_pipe_update_start(state, crtc);
+
+		commit_pipe_arm(state, crtc);
+
+		intel_pipe_update_end(state, crtc);
+		break;
+	}
+
+	intel_post_update_crtc(state, crtc);
+}
+
 static void intel_old_crtc_state_disables(struct intel_atomic_state *state,
 					  struct intel_crtc *crtc)
 {
-- 
2.56.0

