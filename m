Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903C606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=fdLDHYcw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A75B10E50B;
	Sun, 22 Nov 2026 15:31:08 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798F210E50B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:30:55 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1394842f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795361454; x=1795966254;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GRF7RZylvqUysOgUrH3bq7GJBGa2AYrwd8X7S2pra/o=;
 b=fdLDHYcwZ/N/nz/jc6wVv8TcSFKlx7YTssnuVQRnss7tP0e7lPLcqBzcTUfaJNwujO
 Rm/2jzW3xvQsIuac7craDfjsLyWgJGGu2ezq8NcsOTQfHPFug2YYjMsWKD50ijQ1zp30
 2GvcUT+6gEi2/vEetgs6jTkt75eOvH624gRac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361454; x=1795966254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GRF7RZylvqUysOgUrH3bq7GJBGa2AYrwd8X7S2pra/o=;
 b=TGlNcEHGgLvfGQThAQRi/2TMJx/EIHhiXvbYSUFtmWil7DohC32jHE8rZO0W46wLsG
 U6ZgumkVd3ca2Ze2oSgAiX6xskbblGsd7SXjlC/qdOwuQQ25KsC4QpNsG3TKCUkkmOck
 Zq/uj9k7eqjf1FkyrZdWRuM/vji9lQeLfJMnzISnSWsSspU7ApQOhkcrHD4FO6GwIYa2
 VWQMx11ySPGEvztOcsUdPnJnLmaU5933P5FdGQPoOBAvLjxeaYR5oamoAnGMMSaWbXnH
 tLt2emUpr5pHJOX2gdf9/Nlw8YFJ3HAyb8MLvc36ughm/np0wjcGdu/whPM6teaIgXwz
 OwGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG/gk4e1UIEqc9l+3b1P8szi8eO7cGJtAqMgi1MkjEprftmDYCYJtPeeOqFFyI6icPCGigsgEU/E20=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/tVT0sl7YjI+yo7rNnEvYmINPrljHVvpHdETm4h8O7lrltKlcR
 DeijKZ2S0O3SFUg8f/C5P3fSCnVZM+tigHFHRf2EgfToUhLvEJvpJekuJP0P5O+O0j0=
X-Gm-Gg: AZFdTZeUkmcqFGFOltuni2BxJbghJoxji1W6Yek6Uhr5q1gSCrbU0FJJgIisrH7bGxT
 P1gjTvbLYutmYYpYhTsCHMMe9m/ppqFAsrAo1JJoJl6TD1D+WujVicUQmRwS1V+5mSEtw+AmaKC
 oWf+mJrhU/DIw7189EZS5bCQmNC3c4Fm8lY0s3vq/3BMF63R8h9/3LLnp+kThM3o4tr7olfDo5W
 Itgv0egmAZ+lPX6AtqssDAXXM7fFPJ1NDQJBFNTjaD+4+BZMRdswjEn85wn919jYOy0gNTfC7CW
 WOpKIleXGbiy7QexM01Mk6Z1KT1aEEW+U13iKa7A7+Ii13wkegA6FoLDKdAYCzuvEiTYrNJuYxK
 1CEt1t1R2n85VfqDQPxitsAur+M+dSqtRGXehti2v7Jt9SFm8vNimBIZwr6qMz5AV9fh1ZSs73Z
 ZGDgA2VT2cOgOginYpGkVBiub46c77Xxj8/MXQLDUQQW1Rtvpk9Ui8YEUKC+0MJBF7glRZqZGeF
 50IRvOz4YUzZNYalHGC67gAY0/M6T5n50g0sUUIYL3DarWj3ZjdX73MxLGYY+WTk/cfa1H81SlG
 WDyzUSNYIJ7dMMOtinkTspiqsUw9o2dFcnRDKi/t2KggSQX68/tKm228u+MfKA+jmnY/Rzo1XXh
 jdYHasRNgg3MQscfHEXWNA6PiH3wYKqP5N6p69A5NjUBX0gkpUWr6DcENxMFD/9pnImKwekXnd/
 YrFSQSagrXiG0iN7wGAMJr+xVzOA==
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id
 5b1f17b1804b1-4bb888267aemr185114295e9.10.1795361453840; 
 Sun, 22 Nov 2026 07:30:53 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm237833815e9.9.2026.11.22.07.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 07:30:53 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/8] drm/panel: Add sro_install hook
Date: Sun, 22 Nov 2026 16:30:02 +0100
Message-ID: <20261122153032.2782768-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
References: <20261122153032.2782768-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The panel bridge assumes the panel is enabled whenever its pipeline
is read out as active, but the panel is left marked as unprepared and
disabled. The following disable is then skipped, and the panel driver
never gets the chance to acquire the resources it will release when
unprepared.

Add the sro_install hook, called when the state read out from the
hardware is installed. On success the panel is marked as prepared and
enabled.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/gpu/drm/drm_panel.c | 16 ++++++++++++++++
 include/drm/drm_panel.h     | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index bef0e6af73ba..daccf98e5513 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -346,6 +346,21 @@ panel_bridge_connector_readout(struct drm_bridge *bridge,
 	return 0;
 }
 
+static void panel_bridge_install_state(struct drm_bridge *bridge,
+				       struct drm_bridge_state *bridge_state)
+{
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+
+	if (!panel->funcs || !panel->funcs->sro_install)
+		return;
+
+	if (panel->funcs->sro_install(panel))
+		return;
+
+	panel->prepared = true;
+	panel->enabled = true;
+}
+
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
@@ -360,6 +375,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.debugfs_init = panel_bridge_debugfs_init,
 	.atomic_sro_readout_state = panel_bridge_readout_state,
+	.atomic_sro_install_state = panel_bridge_install_state,
 	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
 	.atomic_sro_connector_readout = panel_bridge_connector_readout,
 };
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 58113ea7d63a..66f9fc0828f1 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -148,6 +148,16 @@ struct drm_panel_funcs {
 	 * Allows panels to create panels-specific debugfs files.
 	 */
 	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
+
+	/**
+	 * @sro_install:
+	 *
+	 * Acquire the resources of a panel found enabled when the hardware
+	 * state was read out, without touching the hardware.
+	 *
+	 * This function is optional.
+	 */
+	int (*sro_install)(struct drm_panel *panel);
 };
 
 struct drm_panel_follower_funcs {
-- 
2.43.0

