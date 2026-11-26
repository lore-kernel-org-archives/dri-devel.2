Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G2b20yBN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3BED1120F0;
	Thu, 26 Nov 2026 08:09:07 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 860A610E191
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:47:35 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-385c497bf94so4398025eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795661255; x=1796266055; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3MxnqOC+HvmSMfN8r198TjSpJ0x8uZyT0+qz3vMDZEs=;
 b=G2b20yBNBsJ9jAobfb++sb+YCcZyezQm+gWRH2tmJF+49cq1d7jvmthXIO9qd1ignn
 MRhCrx7alLWkq8RIwmE7uFNfn6JwykdeehiWvo8K9lxFqxGnS5rSJCU1bxHDK6Al5bIQ
 ldeLMN0Qxy2Ud1CTRIPbPL/FGgePITtjipVhQBbr2dO9FkJGhD9TKMkNV0ENRAZ80nly
 ZrGQTA8UR0p4dv2nGQLcXZcXjjBPOcUPvZNLLX9h+CuNsVXKHxRpIQsVSaumVZNN3BNK
 ebvaTlsOr5iblXnHqs+OPDHoAPlKcmZjm8JokFuSO6BNkyjZg1wJ+bHFMA/iVIP003XN
 JOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795661255; x=1796266055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3MxnqOC+HvmSMfN8r198TjSpJ0x8uZyT0+qz3vMDZEs=;
 b=OFXOVfz6dp63LHeaihUJxjKg9xDX2hSzdx2zj5uAyugOkfM6+9l8+SFyuAQvNVoyKJ
 /NuqZJslkJ4puygZQ0qS2cipkQB5l0n7dbkM7f62BUxaXDXZqnql33RaTaOPlPJ3xFkk
 w94bsOxA46GhoqBSy6GFaSEBnRF+nRLbC9stX7iJkgtSvAUyE6arqtVtSe4odoYh7Cn5
 ImqufNIKT8Ewjg/d0nb4gbs8rTcVoyJZjFpC4DCYYpgsLh/RwP1CNY97Ah27OQFLzHif
 P5JzuC3WXQ72oXjNzQLAdjWAkE7tl2BupAaAA3/1Q1auSqO3hkJYQL5QAtpSWPA2X1U8
 wnvw==
X-Gm-Message-State: APuU4Z9rbd3IFQlCP7AGnxqLNCDfojX0O8RtgukNGx5NbII332r7bByH
 /OQ0vbu5OCqbiP6NhXZQkRQQqp0lVF7O0XlKUQstBXazGmbOAVneYWHw79qkq9ah
X-Gm-Gg: AZFdTZfvpVlrvPk41SgoGAX2aUMTOJKahDbPZ9j64q+szJC81NDocf7j3Ab+hw5cGEi
 Uiu0XMz+NQgYw+yFs5odejJSQxDyxV/mzWr8ETlZ5vzhv+3oLpSkq003QoRBIPojknUd3lYScRk
 daRFaZ9mcAuOcCJXMUvpHgcLKngWRSij6y8JtzYUaLSwigJ1W/zsogdRpqc+g4shG5eIAFRXpN6
 nP6Nm+/ovP2jNy+V3i9iqAGHUZSTOZz8f3pfhey6BRy1vOV/00RzRJXWtX1TahJWcXUBG7fk/lE
 IQG7f3yLAFzoh6LmC+VCyg6BwkoY4tl1SmC3UzIb8F8uB123OY3HeP9QyjF0xZS7IMU85cUBaS4
 CvQvX4NeuMdwNgMIYHIh4qC8x6f20u5zIbn9p9YRwMWjFR7nLG8LTnqNdX8OW1N/1e2USK5+fLj
 sZmhGyUKQUo0raeQbVdb9tFIAtNrY9fcAj+lOgqf6LfSzB0p7dDSbynFTmQr3q+kgmtQqi7FUtY
 uAf78DCteh7kO0hZbWOu8iKdyTMiZOo6fdVVhUkMotum6uOtjcG0oyxHIBZrme+MDMHJeE7DW6K
 KFaHTrk2FwuH9nV9kiKKZ9HedoCIWMCohV5t5ZvCEzX+8xuYe2r5QXAXSihre6E=
X-Received: by 2002:a05:693c:805a:b0:376:a6d7:8f51 with SMTP id
 5a478bee46e88-3856e63bbe9mr23527078eec.12.1795661254780; 
 Wed, 25 Nov 2026 18:47:34 -0800 (PST)
Received: from a-VirtualBox ([168.188.125.88])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm70815493eec.5.2026.11.25.18.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 18:47:34 -0800 (PST)
From: Minseo Park <hiyoukou@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, alain.volmat@foss.st.com, rgallaispou@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, benjamin.gaignard@collabora.com,
 Minseo Park <hiyoukou@gmail.com>
Subject: [PATCH v2 4/4] drm/sti: hqvdp: register the VTG client from
 .atomic_update()
Date: Thu, 26 Nov 2026 11:47:10 +0900
Message-ID: <20261126024710.33401-5-hiyoukou@gmail.com>
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

sti_hqvdp_atomic_check() enables the main pixel clock and registers the
VTG vsync notifier.

.atomic_check() must not touch the hardware.  A commit with
DRM_MODE_ATOMIC_TEST_ONLY only runs the check hooks, and a commit that
fails a later check is dropped, so either way the clock is left enabled
and the notifier registered for a configuration that was never applied.

Neither of the two belongs in device init.  sti_vtg_register_client()
stores the CRTC the plane is attached to, which a commit provides and
device init does not, and the clock enable is undone by the matching
clk_disable_unprepare() in sti_hqvdp_disable(), so it follows the
streaming lifetime rather than the device lifetime.  Move both to
.atomic_update(), where sti_gdp already registers its own VTG client the
same way.

The failure paths can no longer reject the commit, so they are logged
once and the plane is left alone.

Fixes: dd86dc2f9ae1 ("drm/sti: implement atomic_check for the planes")
Signed-off-by: Minseo Park <hiyoukou@gmail.com>
---
 drivers/gpu/drm/sti/sti_hqvdp.c | 37 +++++++++++++++++----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index c6b6ed54b899..17c7f5a7854c 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1081,24 +1081,6 @@ static int sti_hqvdp_atomic_check(struct drm_plane *drm_plane,
 		return -EINVAL;
 	}
 
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
@@ -1148,6 +1130,25 @@ static void sti_hqvdp_atomic_update(struct drm_plane *drm_plane,
 	}
 
 	mode = &crtc->mode;
+
+	if (!hqvdp->vtg_registered) {
+		/* Prevent VTG shutdown */
+		if (clk_prepare_enable(hqvdp->clk_pix_main)) {
+			drm_err_once(drm_plane->dev,
+				     "Failed to prepare/enable pix main clk\n");
+			return;
+		}
+
+		/* Register VTG Vsync callback to handle bottom fields */
+		if (sti_vtg_register_client(hqvdp->vtg, &hqvdp->vtg_nb, crtc)) {
+			drm_err_once(drm_plane->dev,
+				     "Cannot register VTG notifier\n");
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

